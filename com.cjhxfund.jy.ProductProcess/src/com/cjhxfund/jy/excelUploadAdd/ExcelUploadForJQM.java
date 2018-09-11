/**
 * 
 */
package com.cjhxfund.jy.excelUploadAdd;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

import com.cjhxfund.ats.fm.comm.ExcelHelper;
import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * @author 
 * @date 
 *
 */
@Bizlet("")
public class ExcelUploadForJQM {

	private final static String ERROR_COMB_PRODUCT_CODE = "产品编码为必填.";
	private final static String ERROR_INVEST_PRODUCT_CODE = "债券代码为必填.";
	private final static String ERROR_PROCESS_TYPE = "业务类别为必填.";
	private final static String ERROR_CLEARING_SPEED = "清算速度为必填.";
	private final static String ERROR_CLEAR_TYPE = "清算类型为必填.";
	private final static String ERROR_TRADING_PLACE = "交易场所为必填.";
	private final static String ERROR_INVEST_COUNT = "券面金额为必填.";
	private final static String ERROR_TRADING_OPPONENT = "交易对手为必填.";
	
	private final static String ERROR_PROCESS_DATE = "业务日期不合法,格式YYYYMMDD.";
	private final static String ERROR_EXPIRE_DATE = "截止日期不合法,格式YYYYMMDD.";

	private final static String ERROR_ED_PROCESS_TYPE = "业务类型填写不合法";
	private final static String ERROR_ED_INVEST_CATEGORY = "债券类别填写不合法";
	private final static String ERROR_ED_BOND_RATING = "债券评级填写不合法";
	private final static String ERROR_ED_SUBJECT_RATING = "主体评级填写不合法";
	private final static String ERROR_ED_CLEARING_SPEED = "清算速度填写不合法";
	private final static String ERROR_ED_CLEAR_TYPE = "清算类型填写不合法";
	private final static String ERROR_ED_TRADING_PLACE = "交易场所填写不合法";
	private final static String ERROR_ED_INTEREST_RATE_TYPE = "收益率类型写不合法";

	private final static String ERROR_VC_COMBI_NO = "组合名称填写不合法";
	private final static String ERROR_FOR_INVEST_PRODUCT_CODE = "债券代码填写不正确，无该债券";

	static List<DataObject> msgList = null;//错误信息
	
	static String[] pamArray = new String[]
					{"combProductCode","combProductName","vcCombiName",
					"investProductCode","investProductName","processDate","expiredate",
					"processType","investCategory","bondRating",
					"subjectRating","clearingSpeed","cleartype",
					"tradingPlace","investCount","tradingOpponent",
					"interestRateType","interestRate","netPrice","fullPrice",
					"traderCode","seatNum",
					"agreementNum","backstageTraderRemark"};
	
	private static String[] mergeArray = null;
	private static int NUM = 0;
	
	private static int SUCCESS_NUM = 0;

	private static int FAIL_NUM = 0;
	
		/**
		 * 获取Excel导入的数据
		 * @param filePath
		 * @return
		 * @throws IOException 
		 */
		@Bizlet("获取Excel导入的数据") 
	    public static List<List<DataObject>> getStockIssueExportList(String filePath, DataObject obj) throws IOException {  
			List<List<DataObject>> allList = new ArrayList<List<DataObject>>();
	        List<List<Object>> list = null;  
	        msgList = new ArrayList<DataObject>();
	        
	        //解析excel中的数据，返回list
	        list = ExcelHelper.exportListFromExcel(new File(filePath), 0);
	        if(list.size()<=1){//空模板
	        	initMsgError(0,"模板数据为空，请检查数据.");
	        }
	        
	        //校验Excel导入的数据，并且将相关数据做转换
	        List<DataObject> stockIssueList = checkStockIssueValid(list,obj);
	        //获取新增，成功，失败数据数量
	        countInfo(list,stockIssueList);
	        allList.add(stockIssueList);
	        allList.add(msgList);
	        return allList;
	    } 
		/**
		 * 信息导入校验
		 * @param list
		 * @return
		 */
		public static List<DataObject> checkStockIssueValid(List<List<Object>> list, DataObject obj){
			//解析数据
			List<DataObject> stockList = initData(list,obj);

			//数据校验校验
			List<DataObject> trueList = checkStockIssueNotNullValid(stockList);

			return trueList;
		}
		
		/**
		 * 获取错误信息
		 * @param list
		 * @return
		 */
		public static List<DataObject> initMsgError(int id,String code){
			DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
			ob.setLong("id", id+1);
			ob.setString("errorCode", code);
			ob.setString("errorMsg", code);
			msgList.add(ob);
			
			return msgList;
		}
		
        /**
    	 * Excel导入信息数量统计
    	 * @param list
    	 * @param obj
    	 * @return
    	 */
    	public static List<DataObject> countInfo(List<List<Object>> list, List<DataObject> stockIssueList){
    		NUM = list.size()-1;
    		SUCCESS_NUM = stockIssueList.size();
    		FAIL_NUM = NUM - SUCCESS_NUM;
    		DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
    		ob.setLong("num", NUM);
    		ob.setLong("successNum", SUCCESS_NUM);
    		ob.setLong("failNum", FAIL_NUM);
    		msgList.add(ob);
    		return stockIssueList;
    	}
		
		/**
		 * 数据校验
		 * @param list
		 * @return
		 */
		public static List<DataObject> checkStockIssueNotNullValid(List<DataObject> list){
			List<DataObject> objList = new ArrayList<DataObject>();
			List<DataObject> ListEorro = new ArrayList<DataObject>();
			int count = 0;
			
			for(int i = 0; i < list.size(); i++){
				DataObject temp = null;
				String result="";
				
				//非空数据校验
				
				//产品编码
				if(!list.get(i).get("combProductCode").toString().equals("")){
					temp = list.get(i);
					//债券代码
					if(temp.get("investProductCode").toString().equals("")){
						initMsgError(i,ERROR_INVEST_PRODUCT_CODE);
						result=result+ERROR_INVEST_PRODUCT_CODE;
					}
					//业务类别
					if(temp.get("processType").toString().equals("")){
						initMsgError(i,ERROR_PROCESS_TYPE);
						result=result+ERROR_PROCESS_TYPE;
					}
					//清算速度
					if(temp.get("clearingSpeed").toString().equals("")){
						initMsgError(i,ERROR_CLEARING_SPEED);
						result=result+ERROR_CLEARING_SPEED;
					}
					//清算类型
					if(temp.get("cleartype").toString().equals("")){
						initMsgError(i,ERROR_CLEAR_TYPE);
						result=result+ERROR_CLEAR_TYPE;
					}
					//交易场所
					if(temp.get("tradingPlace").toString().equals("")){
						initMsgError(i,ERROR_TRADING_PLACE);
						result=result+ERROR_TRADING_PLACE;
					}
					//券面金额
					if(temp.get("investCount").toString().equals("")){
						initMsgError(i,ERROR_INVEST_COUNT);
						result=result+ERROR_INVEST_COUNT;
					}
					//交易对手
					if(temp.get("tradingOpponent").toString().equals("")){
						initMsgError(i,ERROR_TRADING_OPPONENT);
						result=result+ERROR_TRADING_OPPONENT;
					}
					
					//日期校验
					
					//业务日期
					if(temp.get("processDate") != null && !temp.get("processDate").toString().equals("0")){
						if(temp.get("processDate").toString().length()==8){
							if(!checkDate(temp.get("processDate").toString())){
								initMsgError(i,ERROR_PROCESS_DATE);
								result=result+ERROR_PROCESS_DATE;
							}
						}else{
							initMsgError(i,ERROR_PROCESS_DATE);
							result=result+ERROR_PROCESS_DATE;
						}
					}
					//截止日期
					if(temp.get("expiredate") != null && !temp.get("expiredate").toString().equals("0")){ 
						if(temp.get("expiredate").toString().length()==8){
							if(!checkDate(temp.get("expiredate").toString())){
								initMsgError(i,ERROR_EXPIRE_DATE);
								result=result+ERROR_EXPIRE_DATE;
							}
						}else{
							initMsgError(i,ERROR_EXPIRE_DATE);
							result=result+ERROR_EXPIRE_DATE;
						}
					}
					
					//数据字典校验
					
					//业务类别
					if(!temp.get("processType").toString().equals("") ){
						String processType = checkDict("CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQMM",temp.get("processType").toString());
						if(processType==""){
							initMsgError(i,ERROR_ED_PROCESS_TYPE);
							result=result+ERROR_ED_PROCESS_TYPE;
						}else{
							//替换对应的CODE
							temp.setString("processType",processType);
						}
					}
					//债券类别
					if(!temp.get("investCategory").toString().equals("") ){//
						String investCategory = checkDict("CF_JY_PRODUCT_PROCESS_BOND_CATEGORY",temp.get("investCategory").toString());
						if(investCategory==""){
							initMsgError(i,ERROR_ED_INVEST_CATEGORY);
							result=result+ERROR_ED_INVEST_CATEGORY;
						}else{
							//替换对应的CODE
							temp.setString("investCategory",investCategory);
						}
					}
					//债券评级
					if(!temp.get("bondRating").toString().equals("") ){//
						String bondRating = checkDict("CF_JY_PRODUCT_PROCESS_BOND_RATING",temp.get("bondRating").toString());
						if(bondRating==""){
							initMsgError(i,ERROR_ED_BOND_RATING);
							result=result+ERROR_ED_BOND_RATING;
						}else{
							//替换对应的CODE
							temp.setString("bondRating",bondRating);
						}
					}
					//主体评级
					if(!temp.get("subjectRating").toString().equals("") ){//
						String subjectRating = checkDict("CF_JY_PRODUCT_PROCESS_SUBJECT_RATING",temp.get("subjectRating").toString());
						if(subjectRating==""){
							initMsgError(i,ERROR_ED_SUBJECT_RATING);
							result=result+ERROR_ED_SUBJECT_RATING;
						}else{
							//替换对应的CODE
							temp.setString("subjectRating",subjectRating);
						}
					}
					//清算速度
					if(!temp.get("clearingSpeed").toString().equals("") ){//
						String clearingSpeed = checkDict("CF_JY_PRODUCT_PROCESS_CLEARING_SPEED",temp.get("clearingSpeed").toString());
						if(clearingSpeed==""){
							initMsgError(i,ERROR_ED_CLEARING_SPEED);
							result=result+ERROR_ED_CLEARING_SPEED;
						}else{
							//替换对应的CODE
							temp.setString("clearingSpeed",clearingSpeed);
						}
					}
					//清算类型
					if(!temp.get("cleartype").toString().equals("") ){//
						String cleartype = checkDict("CF_JY_PRODUCT_PROCESS_CLEAR_TYPE",temp.get("cleartype").toString());
						if(cleartype==""){
							initMsgError(i,ERROR_ED_CLEAR_TYPE);
							result=result+ERROR_ED_CLEAR_TYPE;
						}else{
							//替换对应的CODE
							temp.setString("cleartype",cleartype);
						}
					}
					//交易场所
					if(!temp.get("tradingPlace").toString().equals("") ){//
						String tradingPlace = checkDict("CF_JY_PRODUCT_PROCESS_TRADING_PLACE",temp.get("tradingPlace").toString());
						if(tradingPlace==""){
							initMsgError(i,ERROR_ED_TRADING_PLACE);
							result=result+ERROR_ED_TRADING_PLACE;
						}else{
							//替换对应的CODE
							temp.setString("tradingPlace",tradingPlace);
						}
					}
					//收益率类型
					if(!temp.get("interestRateType").toString().equals("") ){//
						String interestRateType = checkDict("CF_JY_PRODUCT_PROCESS_INTEREST_RATE_TYPE",temp.get("interestRateType").toString());
						if(interestRateType==""){
							initMsgError(i,ERROR_ED_INTEREST_RATE_TYPE);
							result=result+ERROR_ED_INTEREST_RATE_TYPE;
						}else{
							//替换对应的CODE
							temp.setString("interestRateType",interestRateType);
						}
					}
					
					//根据产品编码和组合名称获取组合编码
					if(!temp.get("combProductCode").toString().equals("") && !temp.get("vcCombiName").toString().equals("")){//
						String vcCombiNo = getvcCombiNo(temp.get("combProductCode").toString(),temp.get("vcCombiName").toString());
						if(vcCombiNo==""){
							initMsgError(i,ERROR_VC_COMBI_NO);
							result=result+ERROR_VC_COMBI_NO;
						}else{
							//替换对应的CODE
							temp.setString("vcCombiNo",vcCombiNo);
							
						}
					}
					
					//根据产品编码获取产品名称
					if(!temp.get("combProductCode").toString().equals("") && !temp.get("vcCombiName").toString().equals("")){//
						String combProductName = getCombProductName(temp.get("combProductCode").toString(),temp.get("vcCombiName").toString());
						if(combProductName==""){
							initMsgError(i,ERROR_VC_COMBI_NO);
							result=result+ERROR_VC_COMBI_NO;
						}else{
							//替换对应的值
							temp.setString("combProductName",combProductName);
							
						}
					}
					
					//根据债券代码判断该债券是否存在
					if(!temp.get("investProductCode").toString().equals("")){//
						String investProductName = getInvestProductCode(temp.get("investProductCode").toString());
						if(investProductName==""){
							initMsgError(i,ERROR_FOR_INVEST_PRODUCT_CODE);
							result=result+ERROR_FOR_INVEST_PRODUCT_CODE;
						}else{
							//替换对应的CODE
							temp.setString("investProductName",investProductName);
						}
					}
					/**
			    	 * 获取债券净价、全价、收益率（可以必填其一，选填其他，输入一个另外两个数据可以系统自动算出来）
			    	 * @param processDate 业务日期
			    	 * @param interCode 证券内码
			    	 * @param netPrice 净价（元/百元面值）
			    	 * @param fullPrice 全价（元/百元面值）
			    	 * @param interestRate 收益率（%）
			    	 * @param interestRateType 收益率类型：[1-到期;2-行权日]
			    	 * @param tradingPlace 交易场所：[01-银行间;02-上交所固收平台;03-深交所综合协议平台|上交所大宗;]
			    	 * @param clearingSpeed 清算速度：T+0、T+1
			    	 * @return 返回结果：净价，全价，收益率，收益率类型，交易场所，清算速度
			    	 * @author wuyanfei
			    	 */
					if(!temp.get("interestRate").toString().equals("") //收益率（%）
							|| !temp.get("netPrice").toString().equals("") //净价
							|| !temp.get("fullPrice").toString().equals("")){//全价
						
						String processDate = temp.get("processDate").toString();//业务日期
						String investProductCode = temp.get("investProductCode").toString();//债券代码
						String interestRate = temp.get("interestRate").toString();//收益率（%）
						String netPrice = temp.get("netPrice").toString();//净价（元/百元面值）
						String fullPrice = temp.get("fullPrice").toString();//全价（元/百元面值）
						String interestRateType = temp.get("interestRateType").toString();//收益率类型
						String clearingSpeed = temp.get("clearingSpeed").toString();//清算速度
						String tradingPlace = temp.get("tradingPlace").toString();//交易场所
						//获取本地证券内码
						String vcInterCode = getVcInterCode(temp.get("investProductCode").toString());
						//获取O32证券内码
						String interCodeAll = getInvestProductsByReportCodeAndMarketNo(investProductCode, tradingPlace);
						//截取证券内码
						String interCode = interCodeAll.substring(interCodeAll.lastIndexOf(",")+1);
						//获取债券净价、全价、收益率（可以必填其一，选填其他，输入一个另外两个数据可以系统自动算出来）
						String resultAll = getLinkageValue(processDate, interCode, netPrice, fullPrice, interestRate, interestRateType, tradingPlace, clearingSpeed);
						if(!(resultAll.equals("") || resultAll== "")){
							String[] arr = null;
							arr = resultAll.split("\\@");
							netPrice = arr[0];
							fullPrice = arr[1];
							interestRate = arr[2];
							temp.setString("interestRate",StrUtil.addThousandth(interestRate, StrUtil.df4));
							temp.setString("netPrice",StrUtil.addThousandth(netPrice, StrUtil.df4));
							temp.setString("fullPrice",StrUtil.addThousandth(fullPrice, StrUtil.df4));
						}
					}
					
				}
			if(result.equals("") || result== ""){//没有错误
				objList.add(temp);
			}else{
				count++;
			}
		}
			if(0 == count){//根据错误数量判断，其中有一条数据有错，则则返回空值，数据全部正确才新增
				return objList;
			}else{
				return ListEorro;
			}
	}
		
		/**
		 * 数据解析
		 * 
		 */
		public static List<DataObject> initData(List<List<Object>> list, DataObject obj){
	        List<DataObject> stockIssueList = new ArrayList<DataObject>();
			for(int j = 1; j < list.size(); j++){
	        	obj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.ZhfwptJyZqmm");
	        	List<Object> pam=list.get(j);
				System.out.println(j);
				for(int i=0 ;i<pamArray.length;i++){
						if(!"".equals(pam.get(i)) && pam.get(i)!=null ){
							obj.setString(pamArray[i], pam.get(i).toString().trim());
						}else{
							obj.setString(pamArray[i], "");
						}
				}
				stockIssueList.add(obj);
	        }
			return stockIssueList;
		}
		
		//用正则表达式判断字符串是否为数字
		public static boolean isNumeric(String str) {
	        String regEx = "^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$";//"^-?[0-9]+$";//"^^[0-9]+\.?[0-9]*$"
	        Pattern pat = Pattern.compile(regEx);
	        Matcher mat = pat.matcher(str);
	        if (mat.find()) {
	        	return true;
	        }
	        else {
	            return false;
	        }
	    }
		public static boolean checkDate(String data) {
			String checkValue = data;  
            String year = checkValue.substring(0, 4); // 获取年份
            String month = checkValue.substring(4, 6); // 获取月份
            Boolean isLeap = leapYear(Integer.parseInt(year)); // 判断闰年
            StringBuffer eL= new StringBuffer();
            String longMonth = "01030507081012"; // 31天的月份
            String fix = "([2][0-3]|[0-1][0-9]|[1-9])[0-5][0-9]([0-5][0-9]|[6][0])";

            if(checkValue.length()==8){
            	if(isLeap && month.equals("02")){  // 针对2月份的情况 【闰年】
                    eL.append("\\d{4}([1][0-2]|[0][0-9])([2][0-1]|[1-2][0-9]|[0][1-9]|[1-9])");
                }else if(!isLeap && month.equals("02")){ // 针对2月份的情况 【非闰年】
                    eL.append("\\d{4}([1][0-2]|[0][0-9])([2][0-1]|[1-2][0-8]|[0][1-9]|[1-9])");
                }else if(longMonth.contains(month)){ // 31天月份
                    eL.append("\\d{4}([1][0-2]|[0][0-9])([3][0-1]|[1-2][0-9]|[0][1-9]|[1-9])");
                }else{ // 30天月份
                    eL.append("\\d{4}([1][0-2]|[0][0-9])([3][0]|[1-2][0-9]|[0][1-9]|[1-9])");
                }
            }else{
            	if(isLeap && month.equals("02")){  // 针对2月份的情况 【闰年】
                    eL.append("\\d{4}([1][0-2]|[0][0-9])([2][0-1]|[1-2][0-9]|[0][1-9]|[1-9])"+fix);
                }else if(!isLeap && month.equals("02")){ // 针对2月份的情况 【非闰年】
                    eL.append("\\d{4}([1][0-2]|[0][0-9])([2][0-1]|[1-2][0-8]|[0][1-9]|[1-9])"+fix);
                }else if(longMonth.contains(month)){ // 31天月份
                    eL.append("\\d{4}([1][0-2]|[0][0-9])([3][0-1]|[1-2][0-9]|[0][1-9]|[1-9])"+fix);
                }else{ // 30天月份
                    eL.append("\\d{4}([1][0-2]|[0][0-9])([3][0]|[1-2][0-9]|[0][1-9]|[1-9])"+fix);
                }
            }
            Pattern p = Pattern.compile(eL.toString());    
            Matcher m = p.matcher(checkValue);    
            boolean flag = m.matches();   
            return flag;
        }
        public static boolean leapYear(int year) {
            Boolean isLeap = false;
            if (((year % 100 == 0) && (year % 400 == 0))
                    || ((year % 100 != 0) && (year % 4 == 0)))
                isLeap = true;
            return isLeap;
        }
        
        /**
         * 数据字典项校验【数据字典等】
         */
        @Bizlet("")
        public static String checkDict(String dicttypeid,String dictname){
        	String dictid = "";
        	try {
    	    	String componentName = "com.cjhxfund.jy.excelUploadAdd.excelUpload";//逻辑构建名称
    	        String operationName = "checkExcelUploadDictEntry";//逻辑流名称
    	        
    	        ILogicComponent comp = LogicComponentFactory.create(componentName);
    	       
    	        Object[] params = new Object[]{dicttypeid,dictname};
    	        Object[] result = (Object[])comp.invoke(operationName,params);  	        
    	        if(result != null){
    	        	Object[] temp=(Object[]) result[0];
    	    	    if(temp.length>0){
    	    	    	DataObject data = (DataObject)temp[0];
        	    	    dictid =  data.getString("Dictid");
    	    	    }
    	        }
    		} catch (Throwable e) {
    			e.printStackTrace();
    		}
    		return dictid;
        }
       
        /**
         * 获取组合编码和产品名称
         */
        @Bizlet("")
        public static String getvcCombiNo(String combProductCode,String vcCombiName){
        	String vcCombiNo = "";
        	String combProductName = "";
        	try {
        		String componentName = "com.cjhxfund.jy.excelUploadAdd.excelUpload";//逻辑构建名称
    	        String operationName = "getVcCombiNo";//逻辑流名称
    	        
    	        ILogicComponent comp = LogicComponentFactory.create(componentName);
    	       
    	        Object[] params = new Object[]{combProductCode,vcCombiName};
    	        Object[] result = (Object[])comp.invoke(operationName,params);  	        
    	        if(result != null){
    	        	Object[] temp=(Object[]) result[0];
    	    	    if(temp.length>0){
    	    	    	DataObject data = (DataObject)temp[0];
    	    	    	vcCombiNo =  data.getString("vcCombiNo");
    	    	    }
    	        }
    		} catch (Throwable e) {
    			e.printStackTrace();
    		}
    		return vcCombiNo;
        }
        
        /**
         * 获取产品名称
         */
        @Bizlet("")
        public static String getCombProductName(String combProductCode,String vcCombiName){
        	String combProductName = "";
        	try {
        		String componentName = "com.cjhxfund.jy.excelUploadAdd.excelUpload";//逻辑构建名称
    	        String operationName = "getVcCombiNo";//逻辑流名称
    	        
    	        ILogicComponent comp = LogicComponentFactory.create(componentName);
    	       
    	        Object[] params = new Object[]{combProductCode,vcCombiName};
    	        Object[] result = (Object[])comp.invoke(operationName,params);  	        
    	        if(result != null){
    	        	Object[] temp=(Object[]) result[0];
    	    	    if(temp.length>0){
    	    	    	DataObject data = (DataObject)temp[0];
    	    	    	combProductName =  data.getString("combProductName");
    	    	    }
    	        }
    		} catch (Throwable e) {
    			e.printStackTrace();
    		}
    		return combProductName;
        }
        
        /**
         * 判断债券代码是否存在
         */
        @Bizlet("")
        public static String getInvestProductCode(String investProductCode){
        	String investProductName = "";
        	try {
        		String componentName = "com.cjhxfund.jy.excelUploadAdd.excelUpload";//逻辑构建名称
    	        String operationName = "getInvestProductCode";//逻辑流名称
    	        
    	        ILogicComponent comp = LogicComponentFactory.create(componentName);
    	       
    	        Object[] params = new Object[]{investProductCode};
    	        Object[] result = (Object[])comp.invoke(operationName,params);  	        
    	        if(result != null){
    	        	Object[] temp=(Object[]) result[0];
    	    	    if(temp.length>0){
    	    	    	DataObject data = (DataObject)temp[0];
    	    	    	investProductName =  data.getString("investProductName");
    	    	    }
    	        }
    		} catch (Throwable e) {
    			e.printStackTrace();
    		}
    		return investProductName;
        }
        
        /**
         * 获取债券内码
         */
        @Bizlet("")
        public static String getVcInterCode(String investProductCode){
        	String vcInterCode = "";
        	try {
        		String componentName = "com.cjhxfund.jy.excelUploadAdd.excelUpload";//逻辑构建名称
    	        String operationName = "getInvestProductCode";//逻辑流名称
    	        
    	        ILogicComponent comp = LogicComponentFactory.create(componentName);
    	       
    	        Object[] params = new Object[]{investProductCode};
    	        Object[] result = (Object[])comp.invoke(operationName,params);  	        
    	        if(result != null){
    	        	Object[] temp=(Object[]) result[0];
    	    	    if(temp.length>0){
    	    	    	DataObject data = (DataObject)temp[0];
    	    	    	vcInterCode =  data.getString("vcInterCode");
    	    	    }
    	        }
    		} catch (Throwable e) {
    			e.printStackTrace();
    		}
    		return vcInterCode;
        }

    	/**
    	 * 获取导入的数据
    	 * @return
    	 * @throws IOException 
    	 */
    	@Bizlet("获取导入的数据") 
        public static List<DataObject> getExportList(List<List<DataObject>> allList) throws IOException {  
    		return allList.get(0);
        }  
    	/**
    	 * 获取错误数据
    	 * @return
    	 * @throws IOException 
    	 */
    	@Bizlet("获取错误数据") 
        public static List<DataObject> getErrorList(List<List<DataObject>> allList) throws IOException {  
    		return allList.get(1);
        }
    	
    	
    	/**
    	 * 获取债券净价、全价、收益率（可以必填其一，选填其他，输入一个另外两个数据可以系统自动算出来）
    	 * @param processDate 业务日期
    	 * @param interCode 证券内码
    	 * @param netPrice 净价（元/百元面值）
    	 * @param fullPrice 全价（元/百元面值）
    	 * @param interestRate 收益率（%）
    	 * @param interestRateType 收益率类型：[1-到期;2-行权日]
    	 * @param tradingPlace 交易场所：[01-银行间;02-上交所固收平台;03-深交所综合协议平台|上交所大宗;]
    	 * @param clearingSpeed 清算速度：T+0、T+1
    	 * @return 返回结果：净价，全价，收益率，收益率类型，交易场所，清算速度
    	 * @author wuyanfei
    	 */
    	@Bizlet("")
    	public static String getLinkageValue(String processDate, String interCode, String netPrice, String fullPrice, String interestRate, String interestRateType, String tradingPlace, String clearingSpeed){
    		//返回结果：净价，全价，收益率，收益率类型，交易场所，清算速度
    		String result = StrUtil.changeNull(netPrice) + "@" + StrUtil.changeNull(fullPrice) + "@" + StrUtil.changeNull(interestRate) + "@" + StrUtil.changeNull(interestRateType) + "@" + StrUtil.changeNull(tradingPlace)  + "@" + StrUtil.changeNull(clearingSpeed);
    		if(StringUtils.isBlank(processDate) || StringUtils.isBlank(interCode)
    				|| (StringUtils.isBlank(netPrice)&&StringUtils.isBlank(fullPrice)&&StringUtils.isBlank(interestRate))){
    			return result;
    		}
    		processDate = processDate.replaceAll("-", "");
    		//若不传入“收益率类型”值，则取“1-到期”
    		if("01".equals(interestRateType)){
    			interestRateType = "1";
    		}
    		if("02".equals(interestRateType)){
    			interestRateType = "2";
    		}
    		Connection conn = null;
    		try {
    			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());//获取O32系统数据库连接
    			
    			//获取“证券内码”、“百元债券利息”、“当日利息”
    			String sql_bond_info = "select t1.vc_inter_code,nvl(t1.EN_BOND_INTEREST,0) EN_BOND_INTEREST,nvl(t1.EN_TODAY_INTEREST,0) EN_TODAY_INTEREST from trade.TBONDPROPERTY t1 where t1.vc_inter_code='" + interCode + "'";
    			String val_bond_info = JDBCUtil.getRecordValueBySql(conn, sql_bond_info);
    			
    			//若查找到“证券内码”、“百元债券利息”、“当日利息”，则继续执行，否则直接结束返回
    			if(StringUtils.isNotEmpty(val_bond_info)){
    				String[] val_bond_info_arr = val_bond_info.split(",");
    				String vc_inter_code = val_bond_info_arr[0];//证券内码
    				String val_en_bond_interest = val_bond_info_arr[1];//“百元债券利息”
    				String en_today_interest = val_bond_info_arr[2];//“当日利息”
    				
    				String busiDate = processDate;//计算业务日期，默认使用传入的业务日期
    				String bond_interest = val_en_bond_interest;//应计利息，默认使用“百元债券利息”
    				//若清算速度为T+1，则计算业务日期取T+1日，应计利息取“当日利息”
    				if("T+1".equals(clearingSpeed)){
    					busiDate = DateUtil.getCalculateTradeDay(conn, processDate, null, 1);
    					bond_interest = en_today_interest;
    				}else{
    					clearingSpeed = "T+0";//默认计算T+0的值
    				}
    				
    				//若传入净价，优先使用净价计算全价、收益率
    				if(StringUtils.isNotBlank(netPrice)){
    					netPrice = netPrice.replaceAll(",", "").trim();
    					
    					//根据债券价格[净价]计算债券到期收益率（统计日期，债券代码[内码]，单券债券委托价格[净价]，计算到指定日期的收益率[默认0]，计算到到期还是到行权日[1-到期;2-行权日]）
    					//sf_get_bond_yield(l_date_p,vc_inter_code_p,en_price_p,l_design_end_date_p,c_type_p)
    					String sql_sf_get_bond_yield_expire = "select 100*round(trade.sf_get_bond_yield("+busiDate+",'"+vc_inter_code+"',"+netPrice+",0,'"+1+"'),6) bond_yield from dual";
    					String val_yield_expire = JDBCUtil.getValueBySql(conn, sql_sf_get_bond_yield_expire);
    					
    					//根据债券价格[净价]计算债券行权收益率（统计日期，债券代码[内码]，单券债券委托价格[净价]，计算到指定日期的收益率[默认0]，计算到到期还是到行权日[1-到期;2-行权日]）
    					String sql_sf_get_bond_yield_exercise = "select 100*round(trade.sf_get_bond_yield("+busiDate+",'"+vc_inter_code+"',"+netPrice+",0,'"+2+"'),6) bond_yield from dual";
    					String val_yield_exercise = JDBCUtil.getValueBySql(conn, sql_sf_get_bond_yield_exercise);
    					
    					//计算全价，全价=净价+百元债券利息
    					fullPrice = String.valueOf(Double.parseDouble(netPrice.trim()) + Double.parseDouble(bond_interest));
    					
    					//返回结果：净价，全价，到期收益率，收益率类型，交易场所，清算速度，行权收益率
    					result = netPrice.trim() + "@" + fullPrice + "@" + val_yield_expire + "@" + interestRateType + "@" + StrUtil.changeNull(tradingPlace)  + "@" + StrUtil.changeNull(clearingSpeed) +"@"+val_yield_exercise;
    					
    					
    				//若净价为空，存在全价，则使用全价计算净价、收益率
    				}else if(StringUtils.isNotBlank(fullPrice)){
    					fullPrice = fullPrice.replaceAll(",", "").trim();
    					
    					//计算净价，净价=全价-百元债券利息
    					double dNetPrice = Double.parseDouble(fullPrice.trim()) - Double.parseDouble(bond_interest);
    					
    					//根据债券价格[净价]计算债券到期收益率（统计日期，债券代码[内码]，单券债券委托价格[净价]，计算到指定日期的收益率[默认0]，计算到到期还是到行权日[1-到期;2-行权日]）
    					//sf_get_bond_yield(l_date_p,vc_inter_code_p,en_price_p,l_design_end_date_p,c_type_p)
    					String sql_sf_get_bond_yield_expire = "select 100*round(trade.sf_get_bond_yield("+busiDate+",'"+vc_inter_code+"',"+dNetPrice+",0,'"+1+"'),6) bond_yield from dual";
    					String val_yield_expire = JDBCUtil.getValueBySql(conn, sql_sf_get_bond_yield_expire);
    					
    					//根据债券价格[净价]计算债券行权收益率（统计日期，债券代码[内码]，单券债券委托价格[净价]，计算到指定日期的收益率[默认0]，计算到到期还是到行权日[1-到期;2-行权日]）
    					String sql_sf_get_bond_yield_exercise = "select 100*round(trade.sf_get_bond_yield("+busiDate+",'"+vc_inter_code+"',"+dNetPrice+",0,'"+2+"'),6) bond_yield from dual";
    					String val_yield_exercise = JDBCUtil.getValueBySql(conn, sql_sf_get_bond_yield_exercise);
    					
    					//返回结果：净价，全价，到期收益率，收益率类型，交易场所，清算速度，行权收益率
    					result = String.valueOf(dNetPrice) + "@" + fullPrice + "@" + val_yield_expire + "@" + interestRateType + "@" + StrUtil.changeNull(tradingPlace)  + "@" + StrUtil.changeNull(clearingSpeed) + "@" + val_yield_exercise;
    					
    					
    				//若净价、全价为空，存在收益率，则使用收益率计算净价、全价
    				}else if(StringUtils.isNotBlank(interestRate)){
    					interestRate = interestRate.replaceAll(",", "").trim();
    					
    					//根据债券收益率计算债券价格[全价]（统计日期，基金编号，债券代码[内码]，到期收益率，计算到到期还是到行权日[1-到期;2-行权日]）
    					String sql_sf_get_bond_price = "select trade.sf_get_bond_price("+busiDate+",null,'"+vc_inter_code+"',"+Double.parseDouble(interestRate)/100+",'"+interestRateType+"') bond_price from dual";
    					String val_sf_get_bond_price = JDBCUtil.getValueBySql(conn, sql_sf_get_bond_price);
    					
    					//计算净价，净价=全价-百元债券利息
    					netPrice = String.valueOf(Double.parseDouble(val_sf_get_bond_price) - Double.parseDouble(bond_interest));
    					String val_yield;
    					if("2".equals(interestRateType)){
    						//根据债券价格[净价]计算债券行权收益率（统计日期，债券代码[内码]，单券债券委托价格[净价]，计算到指定日期的收益率[默认0]，计算到到期还是到行权日[1-到期;2-行权日]）
    						String sql_sf_get_bond_yield = "select 100*round(trade.sf_get_bond_yield("+busiDate+",'"+vc_inter_code+"',"+netPrice+",0,'"+2+"'),6) bond_yield from dual";
    						val_yield = JDBCUtil.getValueBySql(conn, sql_sf_get_bond_yield);
    						//返回结果：净价，全价，到期收益率，收益率类型，交易场所，清算速度，行权收益率
    						result = netPrice + "@" + val_sf_get_bond_price + "@" + interestRate + "@" + interestRateType + "@" + StrUtil.changeNull(tradingPlace)  + "@" + StrUtil.changeNull(clearingSpeed) + "@" +val_yield;
    					}else{
    						//根据债券价格[净价]计算债券到期收益率（统计日期，债券代码[内码]，单券债券委托价格[净价]，计算到指定日期的收益率[默认0]，计算到到期还是到行权日[1-到期;2-行权日]）
    						String sql_sf_get_bond_yield = "select 100*round(trade.sf_get_bond_yield("+busiDate+",'"+vc_inter_code+"',"+netPrice+",0,'"+1+"'),6) bond_yield from dual";
    						val_yield = JDBCUtil.getValueBySql(conn, sql_sf_get_bond_yield);
    						//返回结果：净价，全价，到期收益率，收益率类型，交易场所，清算速度，行权收益率
    						result = netPrice + "@" + val_sf_get_bond_price + "@" + val_yield + "@" + interestRateType + "@" + StrUtil.changeNull(tradingPlace)  + "@" + StrUtil.changeNull(clearingSpeed) + "@" +interestRate;
    					}
    				}
    			}
    		} catch (Exception e) {
    			e.printStackTrace();
    		} finally {
    			JDBCUtil.releaseResource(conn, null, null);
    		}
    		return result;
    	}
    	
    	/**
    	 * 通过债券代码、交易市场编号到O32系统查找投资的债券信息
    	 * @param vcReportCode 债券代码
    	 * @param cMarketNo 市场编号
    	 * @return
    	 * @author wuyanfei
    	 */
    	@Bizlet("")
    	public static String getInvestProductsByReportCodeAndMarketNo(String vcReportCode, String cMarketNo){
    		if("01".equals(cMarketNo)){
    			cMarketNo = "1";
    		}
    		if("02".equals(cMarketNo)){
    			cMarketNo = "2";
    		}
    		if("03".equals(cMarketNo)){
    			cMarketNo = "3";
    		}
    		
    		String result = "";
    		StringBuffer sb = new StringBuffer();
    		Connection conn = null;
    		try {
    			//获取O32系统数据库连接
    			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
    			
    			//拼接SQL语句，投资产品信息（债券代码,债券名称,交易市场编号,证券内码）
    			sb.append("select distinct t.vc_report_code || ',' || t.vc_stock_name || ',' || ")
    			  .append("                t.c_market_no || ',' || t.vc_inter_code investProductInfo ")
    			  .append("  from trade.TSTOCKINFO t ")
    			  .append(" where 1 = 1 ")
    			  .append("   and t.vc_report_code = '" + vcReportCode + "' ")
    			  .append("   and t.c_market_no = '" + cMarketNo + "' ")
    			  .append("   and rownum = 1 ");
    			
    			result = JDBCUtil.getValueBySql(conn, sb.toString());
    			
    		} catch (Exception e) {
    			e.printStackTrace();
    		} finally {
    			sb.setLength(0);
    			sb = null;
    			JDBCUtil.releaseResource(conn, null, null);
    		}
    		return result;
    	}
    
}
