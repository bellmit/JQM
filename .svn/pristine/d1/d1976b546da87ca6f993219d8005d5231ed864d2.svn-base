/**
 * 
 */
package com.cjhxfund.ats.fm.baseinfo;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.bea.xml.stream.samples.Parse;
import com.cjhxfund.ats.fm.comm.ExcelHelper;
import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * @author 黄燕
 * @date 2016-11-16 15:59:34
 *
 */
@Bizlet("")
public class DebtIssueUpload {

	//private final static String ERROR_STOCK_NAME = "债券简称为必填.";	
	private final static String ERROR_STOCK_NAME_FULL = "债券全称为必填.";
	private final static String ERROR_STOCK_TYPE = "债券类别为必填.";	
	private final static String ERROR_VC_ISSUER_NAME_FULL = "发行主体全称为必填.";	
	private final static String ERROR_EN_EXIST_LIMITE = "发行期限(年)为必填并且是大于0的数字不能超过5位.";	
	private final static String ERROR_EN_ISSUE_BALANCE = "发行规模(亿)为必填并且是大于0的数字.";	
	private final static String ERROR_VC_MORT_STOCK_AMOUNT = "股票抵押数量必须是大于0的数字.";
	private final static String ERROR_VC_MORT_STOCK_NULL = "当债券类别为可交换和可转债时,股票名称,股票抵押数量,股票代码为必填";
	private final static String ERROR_L_N_INTEREST_RATE_JUMP_P = "下一利率跳升点数必须是大于0的整数.";
	//private final static String ERROR_C_INTEREST_TYPE_NULL = "利率类型为必填.";	
	//private final static String ERROR_EN_CATEGORY_MONEY = "已投资该发行主体发行证券存量(亿)必须是大于0的数字.";
	private final static String ERROR_EN_NET_VALUE = "公司净资产必须是大于0的数字。";
	private final static String ERROR_VC_STOCK_CODE = "登记托管所为上交所深交所的时候债券代码不能超过6位.";
	private final static String ERROR_MERGE_DATA = "excel中数据重复！";
	private final static String ERROR_MERGE_DATA_ORCLE = "数据库已经存在类似数据！lStockInvestNo=";
	private final static String ERROR_VC_ISSUER_NAME = "当发行主体全称不存在要新增时,主体简称和主体类型为必填.";
	//private final static String ERROR_VC_ISSUER_PROPERTY = "当发行主体全称不存在要新增时,主体类型为必填.";
	private final static String ERROR_L_ISSUE_POST_DATE = "公告日期不合法,格式YYYYMMDD.";	
	private final static String ERROR_L_ISSUE_BEGIN_DATE = "发行日期不合法,格式YYYYMMDD.";	
	private final static String ERROR_L_PAY_DATE = "缴款日期不合法,格式YYYYMMDD.";	
	private final static String ERROR_L_PUBLISH_DATE = "上市日期不合法,格式YYYYMMDD.";	
	private final static String ERROR_L_BEGINCAL_DATE = "起息日期不合法,格式YYYYMMDD.";	
	private final static String ERROR_L_ENDINCAL_DATE = "到期日期不合法,格式YYYYMMDD。";	
	private final static String ERROR_L_NEXT_EXERCISE_DATE = "下一行权日不合法,格式YYYYMMDD.";	
	private final static String ERROR_D_BID_LIMIT_TIME = "投标截止时间不合法,格式YYYYMMDDHHMMSS.";	
	private final static String ERROR_VC_PAYMENT_PLACE = "登记托管所必须填写或者数据字典找不到.";
	private final static String ERROR_C_BOND_APPRAISE = "数据字典找不到债券评级.";
	private final static String ERROR_VC_BOND_APPRAISE_ORGAN = "数据字典找不到债券评级机构.";
	private final static String ERROR_VC_ISSUE_PROPERTY = "数据字典找不到主体类型.";
	private final static String ERROR_C_ISSUE_APPRAISE = "数据字典找不到主体评级.";
	private final static String ERROR_VC_ISSUE_APPRAISE_ORGAN = "数据字典找不到主体评级机构.";
	private final static String ERROR_C_INTEREST_TYPE = "数据字典找不到利率类型.";
	private final static String ERROR_C_PAY_INTEREST_TYPE = "数据字典找不到息票品种.";
	private final static String ERROR_EN_PAY_INTEVAL = "数据字典找不到付息频率.";
	private final static String ERROR_VC_SPECIAL_TEXT = "数据字典找不到特殊条款.";
	private final static String ERROR_VC_CITY_LEVEL = "数据字典找不到城投行政级别";
	private final static String ERROR_C_PAY_TYPE = "数据字典找不到缴款方式.";
	private final static String ERROR_C_BID_TYPE = "数据字典找不到招标方式.";
	private final static String ERROR_VC_STOCK_TYPE = "数据字典找不到债券类型.";
	private final static String ERROR_VC_INDUSTRY = "数据字典找不到所属行业.";
	private final static String ERROR_VC_ISSUE_APPRAISE_CSRC = "数据字典找不到所属行业证监会二级.";
	//private final static String ERROR_C_IS_SMALL_RAISED = "是否小公募填'是'或者'否'.";
	private final static String ERROR_C_IS_HAVE_SALEBACK = "是否具有回售权填'是'或者'否'.";
	private final static String ERROR_C_IS_HAVE_BUYBACK = "是否具有赎回权填'是'或者'否'.";
	private final static String ERROR_C_UNDERWRITE_TYPE = "数据字典找不到承销方式.";
	private final static String ERROR_MERGE_DATA_ORCLE_PARAM = "数据库已经存在类似数据(系统参数字段类似)！lStockInvestNo=";
	private final static String ERROR_MERGE_DATA_ORCLE_UPDATE = "更新数据库已经存在的数据lStockInvestNo=";
	private final static String ERROR_CHECK_EN_PAY_INTEVAL = "付息频率为“利随本清”时,息票品种为“一次还本付息券”或“贴现券”！";
	private final static String ERROR_VC_ISSUE_TYPE = "数据字典找不到发行方式.";
	
	private final static int enExistLimiteCol=5;
	private final static int enIssueBalanceCol=6;
	private final static int enFaceRateCol=27;
	private final static int enIssuerNetValueCol=50;
	private final static int vcMortStockAmountCol=48;

	private final static int lNInterestRateJumpPointsCol=52;

	private final static int enPayIntevalCol=26;

	private final static int lIssuePostDateCol=18;
	private final static int lIssueBeginDateCol=19;
	private final static int lPayDateCol=20;
	private final static int lPublishDateCol=21;
	private final static int lBegincalDateCol=22;
	private final static int lEndincalDateCol=23;
	private final static int lNextExerciseDateCol=35;

	private final static int dBidLimitTimeCol = 38;
	private final static int cIsHaveBuybackCol = 39;
	private final static int cIsHaveSalebackCol = 36;
	
	static List<DataObject> msgList = null;//错误信息
	static List<DataObject> issuerList = null;//发行主体信息
	static List<DataObject> mergeStockList = null;//重复新债信息
	
	static String[] pamArray = new String[]
			{"vcStockCode","vcStockName","vcStockNameFull","vcStockType","vcPaymentPlace","enExistLimite","enIssueBalance","cBondAppraise","vcBondAppraiseOrgan",
			"vcIssuerName","vcIssuerNameFull","vcIssueProperty","cIssueAppraise","vcIssueAppraiseOrgan","vcIndustry","vcProvince","vcGuarantorName","vcGuarantorSummary",
			"lIssuePostDate","lIssueBeginDate","lPayDate","lPublishDate","lBegincalDate","lEndincalDate","cInterestType","cPayInterestType",
			"enPayInteval","enFaceRate","cBidType","cPayType","vcSpecialText","vcMainUnderwriter","vcDeputyUnderwriter","cUnderwriteType","vcGroupUnderwriter",
			"lNextExerciseDate","cIsHaveSaleback","vcCreditAnalyze","dBidLimitTime","cIsHaveBuyback","vcIssueType","vcSpecialLimite",
			"vcTenderInterval","vcExistLimiteDesc","vcIssueBeginDateDesc","vcUnderwriterInfo",
			"vcIssueAppraiseCsrc","vcMortStockName","vcMortStockAmount","vcMortStockCode","enIssuerNetValue","vcCityLevel","lNInterestRateJumpPoints"};
	private static String[] mergeArray = null;
	private static int NUM = 0;
	
	private static int SUCCESS_NUM = 0;

	private static int FAIL_NUM = 0;
/**
		 * 获取导入的数据
		 * @param filePath
		 * @return
		 * @throws IOException 
		 */
		@Bizlet("获取导入的数据") 
	    public static List<List<DataObject>> getStockIssueExportList(String filePath, DataObject obj) throws IOException {  
			List<List<DataObject>> allList = new ArrayList<List<DataObject>>();
	        List<List<Object>> list = null;  
	        msgList = new ArrayList<DataObject>();
	        issuerList = new ArrayList<DataObject>();
	        list = ExcelHelper.exportListFromExcel(new File(filePath), 0);  //解析excel中的数据，返回list
	        if(list.size()<=1){//空模板
	        	initMsgError(0,"模板数据为空，请检查数据.");
	        }
	        //数据保存并基本校验
	        List<DataObject> stockIssueList = checkStockIssueValid(list,obj);
	        countInfo(list,stockIssueList,mergeStockList);
	        allList.add(stockIssueList);
	        allList.add(msgList);
	        allList.add(issuerList);
	        allList.add(mergeStockList);
	        return allList;
	    } 
		/**
		 * 新债信息导入校验
		 * @param list
		 * @return
		 */
		public static List<DataObject> checkStockIssueValid(List<List<Object>> list, DataObject obj){
			//解析数据
			List<DataObject> stockList = initData(list,obj);
			String isUpdate = getMergeCol("ATS_FM_UPLOAD_ISUPDATE");//根据系统参数配置是否要更新
			//根据系统参数去重
			String mergeCol = formatSqlToEnt(getMergeCol("ATS_FM_SEARCH_STRATEGY"));//cIssueAppraise,enExistLimite,enIssueBalance,lIssueBeginDate,vcIssueProperty,vcIssuerName,vcStockNameFull,vcStockType
			mergeArray = mergeCol.split(",");
			//if(!("0").equals(isUpdate)){//不更新
				//判断重复
			List<DataObject> mergeList = checkStockIssueMerge(stockList);
			//}
			//校验
			List<DataObject> trueList = checkStockIssueNotNullValid(stockList,isUpdate);
			return trueList;
		}
		
		/**
		 * 新债信息导入校验
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
		 * 新债信息导入非空校验
		 * @param list
		 * @return
		 */
		public static List<DataObject> checkStockIssueNotNullValid(List<DataObject> list,String isUpdate){
			List<DataObject> objList = new ArrayList<DataObject>();
			mergeStockList = new ArrayList<DataObject>();
			
			for(int i = 0; i < list.size(); i++){
				//1，非空数据校验
				String result="";
				
				if(list.get(i).get("vcStockName").toString().equals(ERROR_MERGE_DATA)){
					initMsgError(i,ERROR_MERGE_DATA);
					result=result+ERROR_MERGE_DATA;
				}
				if(list.get(i).get("vcStockNameFull").toString().equals("")){//债券全称					
					initMsgError(i,ERROR_STOCK_NAME_FULL);
					result=result+ERROR_STOCK_NAME_FULL;
				}
				if(list.get(i).get("vcStockType").toString().equals("")){//债券类别
					initMsgError(i,ERROR_STOCK_TYPE);
					result=result+ERROR_STOCK_TYPE;
				}
				if(!list.get(i).get("enExistLimite").toString().equals("0") && !list.get(i).get("enExistLimite").toString().equals("-1")){//发行期限（年） && 必须为数字  5位
					if(!isNumeric(list.get(i).get("enExistLimite").toString())){
						initMsgError(i,ERROR_EN_EXIST_LIMITE);
						result=result+ERROR_EN_EXIST_LIMITE;
					}else{//是数字的时候要判断长度
						int len = list.get(i).get("enExistLimite").toString().indexOf(".");
						if(len >5){
							initMsgError(i,ERROR_EN_EXIST_LIMITE);
							result=result+ERROR_EN_EXIST_LIMITE;
						}
					}
				}else{
					initMsgError(i,ERROR_EN_EXIST_LIMITE);
					result=result+ERROR_EN_EXIST_LIMITE;
				}
				if(!list.get(i).get("enIssueBalance").toString().equals("0") && !list.get(i).get("enIssueBalance").toString().equals("-1")){//发行额度（亿） &&      必须为数字 6位
					if(!isNumeric(list.get(i).get("enIssueBalance").toString())){
						initMsgError(i,ERROR_EN_ISSUE_BALANCE);
						result=result+ERROR_EN_ISSUE_BALANCE;
					}else{
						int len = list.get(i).get("enIssueBalance").toString().indexOf(".");
						if(len >6){
							initMsgError(i,ERROR_EN_ISSUE_BALANCE);
							result=result+ERROR_EN_ISSUE_BALANCE;
						}
					}
				}else{
					initMsgError(i,ERROR_EN_ISSUE_BALANCE);
					result=result+ERROR_EN_ISSUE_BALANCE;
				}
				/*if(!list.get(i).get("enCategoryMoney").toString().equals("0")){//已投资该发行主体发行证券存量(亿)     必须为数字6位
					if(!isNumeric(list.get(i).get("enCategoryMoney").toString())){
						initMsgError(i,ERROR_EN_CATEGORY_MONEY);
						result=result+ERROR_EN_CATEGORY_MONEY;
					}else{
						int len = list.get(i).get("enCategoryMoney").toString().indexOf(".");
						if(len >6){
							initMsgError(i,ERROR_EN_CATEGORY_MONEY);
							result=result+ERROR_EN_CATEGORY_MONEY;
						}
					}
				}*/
				/*if(list.get(i).get("cInterestType").toString().equals("")){//利率类型    
					initMsgError(i,ERROR_C_INTEREST_TYPE_NULL);
					result=result+ERROR_C_INTEREST_TYPE_NULL;
				}*/
				//2,日期合法性校验
				/*比如 2013-11-01 12:12:12
				/^(\d{4})-(0\d{1}|1[0-2])-(0\d{1}|[12]\d{1}|3[01]) (0\d{1}|1\d{1}|2[0-3]):[0-5]\d{1}:([0-5]\d{1})$/  
				20131101 121212
				/^(\d{4})(0\d{1}|1[0-2])(0\d{1}|[12]\d{1}|3[01]) (0\d{1}|1\d{1}|2[0-3])[0-5]\d{1}([0-5]\d{1})$/  */
				if(list.get(i).get("lIssuePostDate")!=null && !list.get(i).get("lIssuePostDate").toString().equals("0")){//公告日期    
					if(list.get(i).get("lIssuePostDate").toString().length()==8){
						if(!checkDate(list.get(i).get("lIssuePostDate").toString())){
							initMsgError(i,ERROR_L_ISSUE_POST_DATE);
							result=result+ERROR_L_ISSUE_POST_DATE;
						}
					}else{
						initMsgError(i,ERROR_L_ISSUE_POST_DATE);
						result=result+ERROR_L_ISSUE_POST_DATE;
					}
				}
				if(list.get(i).get("lIssueBeginDate") != null && !list.get(i).get("lIssueBeginDate").toString().equals("0")){//发行日期 
					if(list.get(i).get("lIssueBeginDate").toString().length()==8){
						if(!checkDate(list.get(i).get("lIssueBeginDate").toString())){
							initMsgError(i,ERROR_L_ISSUE_BEGIN_DATE);
							result=result+ERROR_L_ISSUE_BEGIN_DATE;
						}
					}else{
						initMsgError(i,ERROR_L_ISSUE_BEGIN_DATE);
						result=result+ERROR_L_ISSUE_BEGIN_DATE;
					}
					
				}
				if(list.get(i).get("lPayDate") != null && !list.get(i).get("lPayDate").toString().equals("0")){//缴款日期 
					if(list.get(i).get("lPayDate").toString().length()==8){
						if(!checkDate(list.get(i).get("lPayDate").toString())){
							initMsgError(i,ERROR_L_PAY_DATE);
							result=result+ERROR_L_PAY_DATE;
						}
					}else{
						initMsgError(i,ERROR_L_PAY_DATE);
						result=result+ERROR_L_PAY_DATE;
					}
				}
				if(list.get(i).get("lPublishDate") != null && !list.get(i).get("lPublishDate").toString().equals("0")){//上市日期   
					if(list.get(i).get("lPublishDate").toString().length()==8){
						if(!checkDate(list.get(i).get("lPublishDate").toString())){
							initMsgError(i,ERROR_L_PUBLISH_DATE);
							result=result+ERROR_L_PUBLISH_DATE;
						}
					}else{
						initMsgError(i,ERROR_L_PUBLISH_DATE);
						result=result+ERROR_L_PUBLISH_DATE;
					}
				}
				if(list.get(i).get("lBegincalDate") != null && !list.get(i).get("lBegincalDate").toString().equals("0")){//起息日期      
					if(list.get(i).get("lBegincalDate").toString().length()==8){
						if(!checkDate(list.get(i).get("lBegincalDate").toString())){
							initMsgError(i,ERROR_L_BEGINCAL_DATE);
							result=result+ERROR_L_BEGINCAL_DATE;
						}
					}
				}
				if(list.get(i).get("lEndincalDate") != null && !list.get(i).get("lEndincalDate").toString().equals("0")){//到期日期  
					if(list.get(i).get("lEndincalDate").toString().length()==8){
						if(!checkDate(list.get(i).get("lEndincalDate").toString())){
							initMsgError(i,ERROR_L_ENDINCAL_DATE);
							result=result+ERROR_L_ENDINCAL_DATE;
						}
					}else{
						initMsgError(i,ERROR_L_ENDINCAL_DATE);
						result=result+ERROR_L_ENDINCAL_DATE;
					}
				}
				if(list.get(i).get("lNextExerciseDate") != null && !list.get(i).get("lNextExerciseDate").toString().equals("0")){//下一行权日  
					if(list.get(i).get("lNextExerciseDate").toString().length()==8){
						if(!checkDate(list.get(i).get("lNextExerciseDate").toString())){
							initMsgError(i,ERROR_L_NEXT_EXERCISE_DATE);
							result=result+ERROR_L_NEXT_EXERCISE_DATE;
						}
					}else{
						initMsgError(i,ERROR_L_NEXT_EXERCISE_DATE);
						result=result+ERROR_L_NEXT_EXERCISE_DATE;
					}
				}
				if(list.get(i).get("dBidLimitTime") != null && !list.get(i).get("dBidLimitTime").toString().equals("0")){//投标截止时间   
					if(list.get(i).get("dBidLimitTime").toString().length()==14){
						if(!checkDate(list.get(i).get("dBidLimitTime").toString())){
							initMsgError(i,ERROR_D_BID_LIMIT_TIME);
							result=result+ERROR_D_BID_LIMIT_TIME;
						}else{
							SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							String dBidLimitTime = list.get(i).get("dBidLimitTime").toString();
							dBidLimitTime = dBidLimitTime.substring(0, 4) + "-" + dBidLimitTime.substring(4, 6) + "-" + dBidLimitTime.substring(6, 8) + " " + dBidLimitTime.substring(8, 10)+":"+dBidLimitTime.substring(10, 12)+":"+dBidLimitTime.substring(12, 14);
							try {
								list.get(i).setDate("dBidLimitTime", sim.parse(dBidLimitTime));
							} catch (ParseException e) {
								e.printStackTrace();
							}
							
						}
					}else{
						initMsgError(i,ERROR_D_BID_LIMIT_TIME);
						result=result+ERROR_D_BID_LIMIT_TIME;
					}
				}
				if(!list.get(i).get("cPayType").equals("")){//
					String cPayType = checkDict("ATS_FM_PAYMENT",list.get(i).get("cPayType").toString());
					if(cPayType==""){
						initMsgError(i,ERROR_C_PAY_TYPE);
						result=result+ERROR_C_PAY_TYPE;
					}else{
						list.get(i).setString("cPayType",cPayType);
					}
				}
				//校验债券类型
				if(!list.get(i).get("vcStockType").equals("")){//
					String vcStockType = checkStockType(list.get(i).get("vcStockType").toString());
					if(vcStockType==""){
						initMsgError(i,ERROR_VC_STOCK_TYPE);
						result=result+ERROR_VC_STOCK_TYPE;
					}else{
						list.get(i).setString("vcStockType",vcStockType);
					}
				}
				//校验所属行业 checkIssueAppCsrc
				if(!list.get(i).get("vcIndustry").equals("")){//
					String vcIndustry = checkIssueAppCsrc(list.get(i).get("vcIndustry").toString(),"2");
					if(vcIndustry==""){
						initMsgError(i,ERROR_VC_INDUSTRY);
						result=result+ERROR_VC_INDUSTRY;
					}else{
						list.get(i).setString("vcIndustry",vcIndustry);
					}
				}
				//校验所属行业证监会二级 checkIssueAppCsrc
				if(!list.get(i).get("vcIssueAppraiseCsrc").equals("")){//
					String vcIssueAppraiseCsrc = checkIssueAppCsrc(list.get(i).get("vcIssueAppraiseCsrc").toString(),"1");
					if(vcIssueAppraiseCsrc==""){
						initMsgError(i,ERROR_VC_ISSUE_APPRAISE_CSRC);
						result=result+ERROR_VC_ISSUE_APPRAISE_CSRC;
					}else{
						list.get(i).setString("vcIssueAppraiseCsrc",vcIssueAppraiseCsrc);
					}
				}
				//数据字典项校验【债券类型、数据字典等】
				if(list.get(i).get("vcPaymentPlace").toString().equals("")){//
					initMsgError(i,ERROR_VC_PAYMENT_PLACE);
					result=result+ERROR_VC_PAYMENT_PLACE;
				}else{
					String vcPaymentPlace = checkDict("CF_JY_DJTGCS",list.get(i).get("vcPaymentPlace").toString());
					if(vcPaymentPlace==""){
						initMsgError(i,ERROR_VC_PAYMENT_PLACE);
						result=result+ERROR_VC_PAYMENT_PLACE;
					}else{
						list.get(i).setString("vcPaymentPlace",vcPaymentPlace);
						if(vcPaymentPlace.equals("03")){
							list.get(i).setString("cMarketNo","1");
							if(list.get(i).getString("cPayType").trim().equals("")){
								list.get(i).setString("cPayType","3");
							}
						}else if("04".equals(vcPaymentPlace)){
							list.get(i).setString("cMarketNo","2");
							if(list.get(i).getString("cPayType").trim().equals("")){
								list.get(i).setString("cPayType","3");
							}
						}else if("01".equals(vcPaymentPlace)){
							list.get(i).setString("cMarketNo","5");
							if(list.get(i).getString("cPayType").trim().equals("")){
								list.get(i).setString("cPayType","2");
							}
						}else if("02".equals(vcPaymentPlace)){
							list.get(i).setString("cMarketNo","5");
							if(list.get(i).get("vcStockType").toString().trim().equals("D")){
								if(list.get(i).getString("cPayType").trim().equals("")){
									list.get(i).setString("cPayType","3");
								}
							}else{
								if(list.get(i).getString("cPayType").trim().equals("")){
									list.get(i).setString("cPayType","1");
								}
							}
						}else{
							list.get(i).setString("cMarketNo","5");
							if(list.get(i).getString("cPayType").trim().equals("")){
								list.get(i).setString("cPayType","3");
							}
						}
					}
				}
				if(!list.get(i).get("cMarketNo").toString().equals("5")){//银行间    
					if(!list.get(i).get("vcStockCode").toString().equals("")){//vcStockCode不能大于6位
						if(list.get(i).get("vcStockCode").toString().length()>6){
							initMsgError(i,ERROR_VC_STOCK_CODE);
							result=result+ERROR_VC_STOCK_CODE;
						}
					}
				}
				if(!list.get(i).get("cBondAppraise").toString().equals("") ){//
					String cBondAppraise = checkDict("creditRating",list.get(i).get("cBondAppraise").toString());
					if(cBondAppraise==""){
						initMsgError(i,ERROR_C_BOND_APPRAISE);
						result=result+ERROR_C_BOND_APPRAISE;
					}else{
						list.get(i).setString("cBondAppraise",cBondAppraise);
					}
				}
				if(!list.get(i).get("vcBondAppraiseOrgan").equals("")){//
					String vcBondAppraiseOrgan = checkDict("outRatingOrgan",list.get(i).get("vcBondAppraiseOrgan").toString());
					if(vcBondAppraiseOrgan==""){
						initMsgError(i,ERROR_VC_BOND_APPRAISE_ORGAN);
						result=result+ERROR_VC_BOND_APPRAISE_ORGAN;
					}else{
						list.get(i).setString("vcBondAppraiseOrgan",vcBondAppraiseOrgan);
					}
				}
				if(!list.get(i).get("vcIssueProperty").equals("")){//
					String vcIssueProperty = checkDict("ATS_FM_ISSUE_PROPERTY",list.get(i).get("vcIssueProperty").toString());
					if(vcIssueProperty==""){
						initMsgError(i,ERROR_VC_ISSUE_PROPERTY);
						result=result+ERROR_VC_ISSUE_PROPERTY;
					}else{
						list.get(i).setString("vcIssueProperty",vcIssueProperty);
					}
				}
				if(!list.get(i).get("cIssueAppraise").equals("")){//
					String cIssueAppraise = checkDict("issuerRating",list.get(i).get("cIssueAppraise").toString());
					if(cIssueAppraise==""){
						initMsgError(i,ERROR_C_ISSUE_APPRAISE);
						result=result+ERROR_C_ISSUE_APPRAISE;
					}else{
						list.get(i).setString("cIssueAppraise",cIssueAppraise);
					}
				}
				if(!list.get(i).get("vcIssueAppraiseOrgan").equals("")){//
					String vcIssueAppraiseOrgan = checkDict("outRatingOrgan",list.get(i).get("vcIssueAppraiseOrgan").toString());
					if(vcIssueAppraiseOrgan==""){
						initMsgError(i,ERROR_VC_ISSUE_APPRAISE_ORGAN);
						result=result+ERROR_VC_ISSUE_APPRAISE_ORGAN;
					}else{
						list.get(i).setString("vcIssueAppraiseOrgan",vcIssueAppraiseOrgan);
					}
				}
				if(!list.get(i).get("cInterestType").equals("")){//
					String cInterestType = checkDict("rateType",list.get(i).get("cInterestType").toString());
					if(cInterestType==""){
						initMsgError(i,ERROR_C_INTEREST_TYPE);
						result=result+ERROR_C_INTEREST_TYPE;
					}else{
						list.get(i).setString("cInterestType",cInterestType);
					}
				}else if(list.get(i).get("cInterestType").equals("")){
					list.get(i).setString("cInterestType","0");
				}
				if(!list.get(i).get("enPayInteval").toString().equals("-2")){//付息频率
					//if(!list.get(i).get("enPayInteval").toString().equals("-1")){
						if(!isNumeric(list.get(i).get("enPayInteval").toString())){//不是数字的时候查询数据字典
							String enPayInteval = checkDict("ATS_CF_JY_FREQUENCY",list.get(i).get("enPayInteval").toString());
							if(enPayInteval==""){
								initMsgError(i,ERROR_EN_PAY_INTEVAL);
								result=result+ERROR_EN_PAY_INTEVAL;
							}else{
								list.get(i).setString("enPayInteval",enPayInteval);
								
							}
						}else{
							int len = list.get(i).get("enPayInteval").toString().indexOf(".");
							if(len >5){
								initMsgError(i,ERROR_EN_PAY_INTEVAL);
								result=result+ERROR_EN_PAY_INTEVAL;
							}
							/*if(list.get(i).get("enPayInteval").toString().equals("0")){
								if(!list.get(i).get("cPayInterestType").toString().equals("")){
									String cPayInterestType = checkDict("payInterestType",list.get(i).get("cPayInterestType").toString());
									if(!cPayInterestType.equals("1") || !cPayInterestType.equals("3")){
										initMsgError(i,ERROR_CHECK_EN_PAY_INTEVAL);
										result=result+ERROR_CHECK_EN_PAY_INTEVAL;
									}
								}else{
									initMsgError(i,ERROR_CHECK_EN_PAY_INTEVAL);
									result=result+ERROR_CHECK_EN_PAY_INTEVAL;
								}
							}*/
						}
					/*}else{
						initMsgError(i,ERROR_EN_PAY_INTEVAL);
						result=result+ERROR_EN_PAY_INTEVAL;
					}*/
				}else{
					list.get(i).setString("enPayInteval",null);
				}
				if(!list.get(i).get("cPayInterestType").equals("")){//息票品种
					String cPayInterestType = checkDict("payInterestType",list.get(i).get("cPayInterestType").toString());
					if(cPayInterestType==""){
						initMsgError(i,ERROR_C_PAY_INTEREST_TYPE);
						result=result+ERROR_C_PAY_INTEREST_TYPE;
					}else{
						list.get(i).setString("cPayInterestType",cPayInterestType);
					}
				}
				//判断息票品种和付息频率的联动关系   当息票品种为“一次还本付息券”或者“贴现券”的时候，付息频率只能是“利随本清”
				if(list.get(i).get("cPayInterestType").equals("1")||list.get(i).get("cPayInterestType").equals("3")){
					if(list.get(i).get("enPayInteval")==null || !list.get(i).get("enPayInteval").equals("0")){
						initMsgError(i,ERROR_CHECK_EN_PAY_INTEVAL);
						result=result+ERROR_CHECK_EN_PAY_INTEVAL;
					}
				}
				if(list.get(i).get("enPayInteval")!=null && list.get(i).get("enPayInteval").equals("0")){
					if(!list.get(i).get("cPayInterestType").equals("1")&&!list.get(i).get("cPayInterestType").equals("3")){
						initMsgError(i,ERROR_CHECK_EN_PAY_INTEVAL);
						result=result+ERROR_CHECK_EN_PAY_INTEVAL;
					}
				}
				
				if(!list.get(i).get("cBidType").equals("")){//
					String cBidType = checkDict("tenderType",list.get(i).get("cBidType").toString());
					if(cBidType==""){
						initMsgError(i,ERROR_C_BID_TYPE);
						result=result+ERROR_C_BID_TYPE;
					}else{
						list.get(i).setString("cBidType",cBidType);
					}
				}
				
				if(!list.get(i).get("cUnderwriteType").equals("")){//
					String cUnderwriteType = checkDict("underwriteType",list.get(i).get("cUnderwriteType").toString());
					if(cUnderwriteType==""){
						initMsgError(i,ERROR_C_UNDERWRITE_TYPE);
						result=result+ERROR_C_UNDERWRITE_TYPE;
					}else{
						list.get(i).setString("cUnderwriteType",cUnderwriteType);
					}
				}
				
				//特殊条款数据字典
				if(!list.get(i).get("vcSpecialText").equals("")){//
					String temp = "";
					String[] arrayTemp = list.get(i).get("vcSpecialText").toString().split(",");
					if(arrayTemp.length>0){
						for(int te=0;te<arrayTemp.length;te++){
							String vcSpecialText = checkDict("specialText",arrayTemp[te]);
							if(vcSpecialText==""){
								initMsgError(i,ERROR_VC_SPECIAL_TEXT);
								result=result+ERROR_VC_SPECIAL_TEXT;
							}else{
								temp=temp+","+vcSpecialText;
							}
						}
						list.get(i).setString("vcSpecialText",temp);
					}
					
				}
				if(!list.get(i).get("vcCityLevel").equals("")){//城投行政级别:
					String vcCityLevel = checkDict("cityLevel",list.get(i).get("vcCityLevel").toString());
					if(vcCityLevel==""){
						initMsgError(i,ERROR_VC_CITY_LEVEL);
						result=result+ERROR_VC_CITY_LEVEL;
					}else{
						list.get(i).setString("vcCityLevel",vcCityLevel);
					}
				}
				//vcMortStockAmount
				if(!list.get(i).get("vcMortStockAmount").toString().equals("0") && !list.get(i).get("vcMortStockAmount").toString().equals("-1")){//股票数量(万股)
					if(!isNumeric(list.get(i).get("vcMortStockAmount").toString())){
						initMsgError(i,ERROR_VC_MORT_STOCK_AMOUNT);
						result=result+ERROR_VC_MORT_STOCK_AMOUNT;
					}else{
						int len = list.get(i).get("vcMortStockAmount").toString().indexOf(".");
						if(len >16){
							initMsgError(i,ERROR_VC_MORT_STOCK_AMOUNT);
							result=result+ERROR_VC_MORT_STOCK_AMOUNT;
						}
					}
				}
				//股票代码
				//股票数量
				//股票名称
				if(list.get(i).get("vcStockType").toString().trim().equals("O")||list.get(i).get("vcStockType").toString().trim().equals("Q")){
					if(list.get(i).get("vcMortStockAmount").toString().equals("0") || list.get(i).get("vcMortStockAmount").toString().equals("-1") || list.get(i).get("vcMortStockName").toString().equals("")||list.get(i).get("vcMortStockCode").toString().equals("")){
						initMsgError(i,ERROR_VC_MORT_STOCK_NULL);
						result=result+ERROR_VC_MORT_STOCK_NULL;
					}
				}
				//lNInterestRateJumpPoints
				if(!list.get(i).get("lNInterestRateJumpPoints").toString().equals("0") && !list.get(i).get("lNInterestRateJumpPoints").toString().equals("-1")){//下一利率跳升点数(BP)
					if(!isNumeric(list.get(i).get("lNInterestRateJumpPoints").toString())){
						initMsgError(i,ERROR_L_N_INTEREST_RATE_JUMP_P);
						result=result+ERROR_L_N_INTEREST_RATE_JUMP_P;
					}else{
						int len = list.get(i).get("lNInterestRateJumpPoints").toString().indexOf(".");
						if(len >0){
							initMsgError(i,ERROR_L_N_INTEREST_RATE_JUMP_P);
							result=result+ERROR_L_N_INTEREST_RATE_JUMP_P;
						}
					}
				}
				if(!list.get(i).get("enIssuerNetValue").toString().equals("0") && !list.get(i).get("enIssuerNetValue").toString().equals("-1")){//公司净资产
					if(!isNumeric(list.get(i).get("enIssuerNetValue").toString())){
						initMsgError(i,ERROR_EN_NET_VALUE);
						result=result+ERROR_EN_NET_VALUE;
					}else{
						int len = list.get(i).get("enIssuerNetValue").toString().indexOf(".");
						if(len >4){
							initMsgError(i,ERROR_EN_NET_VALUE);
							result=result+ERROR_EN_NET_VALUE;
						}
					}
				}
				//发行主体信息
				if(list.get(i).get("vcIssuerNameFull").equals("")){
					initMsgError(i,ERROR_VC_ISSUER_NAME_FULL);
					result=result+ERROR_VC_ISSUER_NAME_FULL;
				}else{
					DataObject issuerInfos = checkIssuerInfo(list.get(i).get("vcIssuerNameFull").toString().trim());//查询是否存在发行主体
					String lIssuerId = "";
					String vcIssueName = "";
					String vcIssueNameFull = "";
					String vcIssueProperty = "";
					String vcIssueAppraiseOrgan = "";
					String cIssueAppraise = "";
					String vcIndustry = "";
					String vcProvince = "";
					String vcIssueAppraiseCsrc = "";
					String enIssuerNetValue = "";
					String vcCityLevel = "";
					if(issuerInfos==null){//没有查到，要新增
						if(list.get(i).get("vcIssuerName").equals("") || list.get(i).get("vcIssueProperty").equals("")){//新增发行主体-----主体简称为必填,新增发行主体-----主体类型为必填
							initMsgError(i,ERROR_VC_ISSUER_NAME);
							result=result+ERROR_VC_ISSUER_NAME;
						}else{
							boolean isExit = false;
							//改发行主体没有在发行主体表中---要新增
							for(int x=0;x<issuerList.size();x++){
								if(issuerList.get(x).get("vcIssueNameFull").toString().equals(list.get(i).get("vcIssuerNameFull").toString())){//判断要新增的发行人   是否已经存在issuerList中
									isExit=true;
									lIssuerId = issuerList.get(x).get("lIssuerId").toString();
									vcIssueName = issuerList.get(x).get("vcIssueName").toString();
									vcIssueNameFull = issuerList.get(x).get("vcIssueNameFull").toString();
									
									vcIssueProperty = issuerList.get(x).get("vcIssueProperty")==null?"":issuerList.get(x).get("vcIssueProperty").toString();
									vcIssueAppraiseOrgan = issuerList.get(x).get("vcIssueAppraiseOrgan")==null?"":issuerList.get(x).get("vcIssueAppraiseOrgan").toString();
									cIssueAppraise = issuerList.get(x).get("cIssueAppraise")==null?"":issuerList.get(x).get("cIssueAppraise").toString();
									vcIndustry = issuerList.get(x).get("vcIndustry")==null?"":issuerList.get(x).get("vcIndustry").toString();
									vcProvince = issuerList.get(x).get("vcProvince")==null?"":issuerList.get(x).get("vcProvince").toString();
									vcIssueAppraiseCsrc = issuerList.get(x).get("vcIssueAppraiseCsrc")==null?"":issuerList.get(x).get("vcIssueAppraiseCsrc").toString();
									enIssuerNetValue = issuerList.get(x).get("enIssuerNetValue")==null?"":issuerList.get(x).get("enIssuerNetValue").toString();
									vcCityLevel = issuerList.get(x).get("vcCityLevel")==null?"":issuerList.get(x).get("vcCityLevel").toString();
								}
							}
							if(isExit){//如果要新增的发行人   已经在issuerList中
								list.get(i).setInt("lIssuerId",Integer.parseInt(lIssuerId));
								list.get(i).setString("vcIssuerName",vcIssueName);
								list.get(i).setString("vcIssuerNameFull",vcIssueNameFull);
							}else{//将要新增的发行主体添加到issuerList
								//,,,,
								String name = list.get(i).get("vcIssuerName").toString();
								String nameFull = list.get(i).get("vcIssuerNameFull").toString();
								String issueP = list.get(i).get("vcIssueProperty").toString();
								String issueApOr = list.get(i).get("vcIssueAppraiseOrgan").toString();
								String issueApp = list.get(i).get("cIssueAppraise").toString();
								String ind =  list.get(i).get("vcIndustry").toString();
								String pro = list.get(i).get("vcProvince").toString();
								String vcIssueA = list.get(i).get("vcIssueAppraiseCsrc").toString();
								String enIssuer =  list.get(i).get("enIssuerNetValue").toString();
								String vcCity = list.get(i).get("vcCityLevel").toString();
								DataObject issuerInfo = issuerData(name,nameFull,issueP,issueApOr,issueApp,ind,pro,vcIssueA,enIssuer,vcCity);
								issuerList.add(issuerInfo);
								list.get(i).setInt("lIssuerId",Integer.parseInt(issuerInfo.getString("lIssuerId").toString()));
								list.get(i).setString("vcIssuerName",issuerInfo.getString("vcIssueName").toString());
								list.get(i).setString("vcIssuerNameFull",issuerInfo.getString("vcIssueNameFull").toString());
							}
						}
					}else{
						lIssuerId = issuerInfos.get("lIssuerId").toString();
						vcIssueName = issuerInfos.get("vcIssueName").toString();
						vcIssueNameFull = issuerInfos.get("vcIssueNameFull").toString();
						
						vcIssueProperty = issuerInfos.get("vcIssueProperty")==null?"":issuerInfos.get("vcIssueProperty").toString();
						vcIssueAppraiseOrgan = issuerInfos.get("vcIssueAppraiseOrgan")==null?"":issuerInfos.get("vcIssueAppraiseOrgan").toString();
						cIssueAppraise = issuerInfos.get("cIssueAppraise")==null?"":issuerInfos.get("cIssueAppraise").toString();
						vcIndustry = issuerInfos.get("vcIndustry")==null?"":issuerInfos.get("vcIndustry").toString();
						vcProvince = issuerInfos.get("vcProvince")==null?"":issuerInfos.get("vcProvince").toString();
						vcIssueAppraiseCsrc = issuerInfos.get("vcIssueAppraiseCsrc")==null?"":issuerInfos.get("vcIssueAppraiseCsrc").toString();
						enIssuerNetValue = issuerInfos.get("enIssuerNetValue")==null?"":issuerInfos.get("enIssuerNetValue").toString();
						vcCityLevel = issuerInfos.get("vcCityLevel")==null?"":issuerInfos.get("vcCityLevel").toString();
						list.get(i).setInt("lIssuerId",Integer.parseInt(lIssuerId));
						list.get(i).setString("vcIssuerName",vcIssueName);
						list.get(i).setString("vcIssuerNameFull",vcIssueNameFull);
						if(list.get(i).getString("vcIssueProperty").toString().equals("")){//不为""的就覆盖
							list.get(i).setString("vcIssueProperty",vcIssueProperty);
						}
						if(list.get(i).getString("vcIssueAppraiseOrgan").toString().equals("")){//不为""的就覆盖
							list.get(i).setString("vcIssueAppraiseOrgan",vcIssueAppraiseOrgan);
						}
						if(list.get(i).getString("cIssueAppraise").toString().equals("")){//不为""的就覆盖
							list.get(i).setString("cIssueAppraise",cIssueAppraise);
						}
						if(list.get(i).getString("vcIndustry").toString().equals("")){//不为""的就覆盖
							list.get(i).setString("vcIndustry",vcIndustry);
						}
						if(list.get(i).getString("vcProvince").toString().equals("")){//不为""的就覆盖
							list.get(i).setString("vcProvince",vcProvince);
						}	
						if(list.get(i).getString("vcIssueAppraiseCsrc").toString().equals("")){//不为""的就覆盖
							list.get(i).setString("vcIssueAppraiseCsrc",vcIssueAppraiseCsrc);
						}
						if(list.get(i).getString("enIssuerNetValue").toString().equals("")){//不为""的就覆盖
							list.get(i).setString("enIssuerNetValue",enIssuerNetValue);
						}
						if(list.get(i).getString("vcCityLevel").toString().equals("")){//不为""的就覆盖
							list.get(i).setString("vcCityLevel",vcCityLevel);
						}
						
					}
				}
				//VC_GUARANTOR_NAME   担保人名称  L_GUARANTOR_ID   VC_GUARANTOR_SUMMARY
				if(!list.get(i).get("vcGuarantorName").equals("")){
					
					if(!list.get(i).get("vcGuarantorName").toString().equals(list.get(i).get("vcIssuerName").toString())){
						DataObject issuerInfos  = checkIssuerInfo(list.get(i).get("vcGuarantorName").toString().trim());
						String lGuarantor = "";
						String vcGuarantorName = "";
						String vcGuarantorSummary = "";
						if(issuerInfos==null){
							boolean isExit = false;
							//改发行主体没有在发行主体表中---要新增
							for(int x=0;x<issuerList.size();x++){//改发行主体没有在发行主体表中---要新增
								if(issuerList.get(x).get("vcIssueName").toString().equals(list.get(i).get("vcGuarantorName").toString())){//判断要新增的发行人   是否已经存在issuerList中
									isExit=true;
									lGuarantor = issuerList.get(x).get("lIssuerId").toString();
									vcGuarantorName = issuerList.get(x).get("vcIssueName").toString();
									vcGuarantorSummary = issuerList.get(x).get("vcIssueNameFull").toString();
								}
							}
							if(isExit){//如果要新增的发行人   已经在issuerList中
								list.get(i).setInt("lGuarantorId",Integer.parseInt(lGuarantor));
								list.get(i).setString("vcGuarantorName",vcGuarantorName);
								list.get(i).setString("vcGuarantorSummary",vcGuarantorSummary);
							}else{
								DataObject issuerInfo = issuerData(list.get(i).get("vcGuarantorName").toString(),list.get(i).get("vcGuarantorName").toString(),"","","","","","","","");
								issuerList.add(issuerInfo);
								list.get(i).setInt("lGuarantorId",Integer.parseInt(issuerInfo.getString("lIssuerId").toString()));
								list.get(i).setString("vcGuarantorName",issuerInfo.getString("vcIssueName").toString());
								list.get(i).setString("vcGuarantorSummary",issuerInfo.getString("vcIssueNameFull").toString());
							}
						}else{
							lGuarantor = issuerInfos.get("lIssuerId").toString();
							vcGuarantorName = issuerInfos.get("vcIssueName").toString();
							vcGuarantorSummary = issuerInfos.get("vcIssueNameFull").toString();
							list.get(i).setInt("lGuarantorId",Integer.parseInt(lGuarantor));
							list.get(i).setString("vcGuarantorName",vcGuarantorName);
							list.get(i).setString("vcGuarantorSummary",vcGuarantorSummary);
						}
					}else{
						list.get(i).setInt("lGuarantorId",list.get(i).getInt("lIssuerId"));
					}
				}
				//vcMainUnderwriter
				/*if(!list.get(i).get("vcMainUnderwriter").equals("")){
					if(!list.get(i).get("vcMainUnderwriter").toString().equals(list.get(i).get("vcIssuerNameFull").toString())){
						DataObject issuerInfos  = checkIssuerInfo(list.get(i).get("vcMainUnderwriter").toString().trim());
						String vcMainUnderwriter = "";
						if(issuerInfos==null){
							boolean isExit = false;
							//改发行主体没有在发行主体表中---要新增
							for(int x=0;x<issuerList.size();x++){//改发行主体没有在发行主体表中---要新增
								if(issuerList.get(x).get("vcIssueNameFull").toString().equals(list.get(i).get("vcMainUnderwriter").toString())){//判断要新增的发行人   是否已经存在issuerList中
									isExit=true;
									//lGuarantor = issuerList.get(x).get("lIssuerId").toString();
									vcMainUnderwriter = issuerList.get(x).get("vcIssueNameFull").toString();
								}
							}
							if(isExit){//如果要新增的发行人   已经在issuerList中
								//list.get(i).setInt("lGuarantorId",Integer.parseInt(lGuarantor));
								list.get(i).setString("vcMainUnderwriter",vcMainUnderwriter);
							}else{
								DataObject issuerInfo = issuerData(list.get(i).get("vcMainUnderwriter").toString(),list.get(i).get("vcMainUnderwriter").toString(),"","","","","");
								issuerList.add(issuerInfo);
								list.get(i).setString("vcMainUnderwriter",issuerInfo.getString("vcIssueNameFull").toString());
							}
						}else{
							vcMainUnderwriter = issuerInfos.get("vcIssueNameFull").toString();
							list.get(i).setString("vcGuarantorName",vcMainUnderwriter);
						}
					}
				}
				//vcDeputyUnderwriter
				if(!list.get(i).get("vcDeputyUnderwriter").equals("")){
					if(!list.get(i).get("vcDeputyUnderwriter").toString().equals(list.get(i).get("vcIssuerNameFull").toString())){
						DataObject issuerInfos  = checkIssuerInfo(list.get(i).get("vcDeputyUnderwriter").toString().trim());
						String vcDeputyUnderwriter = "";
						if(issuerInfos==null){
							boolean isExit = false;
							//改发行主体没有在发行主体表中---要新增
							for(int x=0;x<issuerList.size();x++){//改发行主体没有在发行主体表中---要新增
								if(issuerList.get(x).get("vcIssueNameFull").toString().equals(list.get(i).get("vcDeputyUnderwriter").toString())){//判断要新增的发行人   是否已经存在issuerList中
									isExit=true;
									//lGuarantor = issuerList.get(x).get("lIssuerId").toString();
									vcDeputyUnderwriter = issuerList.get(x).get("vcIssueNameFull").toString();
								}
							}
							if(isExit){//如果要新增的发行人   已经在issuerList中
								//list.get(i).setInt("lGuarantorId",Integer.parseInt(lGuarantor));
								list.get(i).setString("vcDeputyUnderwriter",vcDeputyUnderwriter);
							}else{
								DataObject issuerInfo = issuerData(list.get(i).get("vcDeputyUnderwriter").toString(),list.get(i).get("vcDeputyUnderwriter").toString(),"","","","","");
								issuerList.add(issuerInfo);
								list.get(i).setString("vcDeputyUnderwriter",issuerInfo.getString("vcIssueNameFull").toString());
							}
						}else{
							vcDeputyUnderwriter = issuerInfos.get("vcIssueNameFull").toString();
							list.get(i).setString("vcDeputyUnderwriter",vcDeputyUnderwriter);
						}
					}
				}*/
				
				if(!list.get(i).get("cIsHaveSaleback").toString().equals("")){
					if( !list.get(i).get("cIsHaveSaleback").toString().equals("1") && !list.get(i).get("cIsHaveSaleback").toString().equals("0")){
						initMsgError(i,ERROR_C_IS_HAVE_SALEBACK);
						result=result+ERROR_C_IS_HAVE_SALEBACK;
					}
				}
				if(!list.get(i).get("cIsHaveBuyback").toString().equals("")){
					if( !list.get(i).get("cIsHaveBuyback").toString().equals("1") && !list.get(i).get("cIsHaveBuyback").toString().equals("0")){
						initMsgError(i,ERROR_C_IS_HAVE_BUYBACK);
						result=result+ERROR_C_IS_HAVE_SALEBACK;
					}
				}
				if(!list.get(i).get("vcIssueType").equals("")){//发行方式
					String vcIssueType = checkDict("issueType",list.get(i).get("vcIssueType").toString());
					if(vcIssueType==""){
						initMsgError(i,ERROR_VC_ISSUE_TYPE);
						result=result+ERROR_VC_ISSUE_TYPE;
					}else{
						list.get(i).setString("vcIssueType",vcIssueType);
					}
				}

				if(result.equals("") || result== ""){//没有错误
					//如果系统参数设置更新则进行更新操作否则提醒
					DataObject stockIssueInfo = null;
					Long lStockIssueId = null;
					String vcStockCode = "";
					String cSource = "";
					//判断重复
					if(!list.get(i).get("vcStockCode").toString().equals("") && !list.get(i).get("vcPaymentPlace").toString().equals("")){
						stockIssueInfo = checkStockInfo(list.get(i).get("vcStockCode").toString(),list.get(i).get("vcPaymentPlace").toString());
						if(stockIssueInfo!=null){//查到重复记录记录							
							if(isUpdate.equals("1")){//系统参数设置的是要更新
								cSource = stockIssueInfo.getString("cSource");
								lStockIssueId = stockIssueInfo.getLong("lStockIssueId");
								vcStockCode = stockIssueInfo.getString("vcStockCode");
								list.get(i).setLong("lStockIssueId",  lStockIssueId);
								if(list.get(i).getString("vcStockCode").equals("")){
									list.get(i).setString("vcStockCode",  vcStockCode);
								}
								/*1,获取数据库中存在的该条数据的数据来源C_SOURCE
								if(C_SOURCE==手工导入){
									则直接将excel中的数据更新到数据库中
								}else{
									if(导入的excel字段值==null)   不要更新
									else if(导入的excel字段值!=null){
										if(数据库数据该字段为空)   更新
										else        不要更新
									}
								}*/
								if(cSource.equals("2")){//重复的数据是之前批量导入的数据。
									//则直接将excel中的数据更新到数据库中
								}else{//重复的数据不是批量导入。
									for(int j=0 ;j<pamArray.length;j++){
										String temp = list.get(i).get(pamArray[j])==null?"":list.get(i).get(pamArray[j]).toString().trim();//导入的excel的字段值
										//i=5,6,25,26,40,41,42 BigDecimal
										if(j==enExistLimiteCol || j==enIssueBalanceCol || j==enFaceRateCol || j==enPayIntevalCol || j==vcMortStockAmountCol || j==enIssuerNetValueCol){//enExistLimite,enIssueBalance,enFaceRate
											BigDecimal oldBigDecimal = stockIssueInfo.getBigDecimal(pamArray[j]);
											System.out.println(j);
											if(oldBigDecimal == null){
												list.get(i).setBigDecimal(pamArray[j],temp.equals("")?new BigDecimal(0):new BigDecimal(temp));
											}else{
												list.get(i).setBigDecimal(pamArray[j],oldBigDecimal);
											}
										}else if(j==lNInterestRateJumpPointsCol){
											Long oldLong = stockIssueInfo.getLong(pamArray[j]);
											if(oldLong == null || oldLong == 0){
												list.get(i).setLong(pamArray[j],Long.parseLong(temp));
											}else{
												list.get(i).setLong(pamArray[j],oldLong);
											}
										}else if(j==lIssuePostDateCol||j==lIssueBeginDateCol||j==lPayDateCol||j==lPublishDateCol||j==lBegincalDateCol||j==lEndincalDateCol||j==lNextExerciseDateCol){
											int oldInt = stockIssueInfo.getInt(pamArray[j]);
											if(oldInt == 0){//日期为空
												list.get(i).setInt(pamArray[j],Integer.parseInt(temp));
											}else{
												list.get(i).setInt(pamArray[j],oldInt);
											}
										}else if(j==dBidLimitTimeCol){//D_BID_LIMIT_TIME
											Date oldDate = stockIssueInfo.getDate(pamArray[j]);
											Date tempDate = list.get(i).getDate("dBidLimitTime");
											if(oldDate == null){
												list.get(i).setDate(pamArray[j],tempDate);
											}else{
												list.get(i).setDate(pamArray[j],oldDate);
											}
										}else{
											String oldString = stockIssueInfo.getString(pamArray[j])==null?"":stockIssueInfo.getString(pamArray[j]).toString().trim();
											if(oldString.equals("")){
												list.get(i).setString(pamArray[j],temp);
											}else{
												list.get(i).setString(pamArray[j],oldString);
											}
										}
									}
								}
								mergeStockList.add(list.get(i));
								initMsgError(i,ERROR_MERGE_DATA_ORCLE_UPDATE+stockIssueInfo.getLong("lStockInvestNo"));//返回到前台界面----更新的新债信息
							}else{
								initMsgError(i,ERROR_MERGE_DATA_ORCLE+stockIssueInfo.getLong("lStockInvestNo"));
								result=result+ERROR_MERGE_DATA_ORCLE;
							}
							continue;
						}
					}
					stockIssueInfo = checkStockInfoByParam(list.get(i).get("vcIssuerNameFull").toString().trim(),list.get(i).get("vcStockNameFull").toString().trim(),list.get(i).get("enExistLimite").toString().trim(),list.get(i).get("enIssueBalance").toString().trim(),
							list.get(i).get("lIssueBeginDate").toString().trim(),list.get(i).get("cIssueAppraise").toString().trim(),list.get(i).get("vcIssueProperty").toString().trim(),list.get(i).get("vcPaymentPlace").toString().trim(),list.get(i).get("cMarketNo").toString().trim());
					//系统参数判断有重复
					if(stockIssueInfo!=null){
						if(isUpdate.equals("1")){
							lStockIssueId = stockIssueInfo.getLong("lStockIssueId");
							vcStockCode = stockIssueInfo.getString("vcStockCode");
							cSource = stockIssueInfo.getString("cSource");
							list.get(i).setLong("lStockIssueId",  lStockIssueId);
							if(list.get(i).getString("vcStockCode").equals("")){
								list.get(i).setString("vcStockCode",  vcStockCode);
							}
							if(cSource.equals("2")){//重复的数据是之前批量导入的数据。
								//则直接将excel中的数据更新到数据库中
								list.get(i).setString("cSource",  "2");
							}else{//重复的数据不是批量导入。
								list.get(i).setString("cSource",  cSource);
								for(int j=0 ;j<pamArray.length;j++){
									String temp = list.get(i).get(pamArray[j])==null?"":list.get(i).get(pamArray[j]).toString().trim();//导入的excel的字段值
									//i=5,6,25,26,40,41,42 BigDecimal
									if(j==enExistLimiteCol || j==enIssueBalanceCol || j==enFaceRateCol || j==enPayIntevalCol || j==vcMortStockAmountCol || j==enIssuerNetValueCol){//enExistLimite,enIssueBalance,enFaceRate
										BigDecimal oldBigDecimal = stockIssueInfo.getBigDecimal(pamArray[j]);
										if(oldBigDecimal == null){
											list.get(i).setBigDecimal(pamArray[j],temp.equals("")?new BigDecimal(0):new BigDecimal(temp));
										}else{
											list.get(i).setBigDecimal(pamArray[j],oldBigDecimal);
										}
										System.out.println(pamArray[j]+","+temp+","+oldBigDecimal);
									}else if(j==lNInterestRateJumpPointsCol){
										Long oldLong = stockIssueInfo.getLong(pamArray[j]);
										if(oldLong == null || oldLong == 0){
											list.get(i).setLong(pamArray[j],Long.parseLong(temp));
										}else{
											list.get(i).setLong(pamArray[j],oldLong);
										}
									}else if(j==lIssuePostDateCol||j==lIssueBeginDateCol||j==lPayDateCol||j==lPublishDateCol||j==lBegincalDateCol||j==lEndincalDateCol||j==lNextExerciseDateCol){
										int oldInt = stockIssueInfo.getInt(pamArray[j]);
										if(oldInt == 0){//日期为空
											list.get(i).setInt(pamArray[j],Integer.parseInt(temp));
										}else{
											list.get(i).setInt(pamArray[j],oldInt);
										}
										System.out.println(pamArray[j]+","+Integer.parseInt(temp)+","+oldInt);
									}else if(j==dBidLimitTimeCol){//D_BID_LIMIT_TIME
										Date oldDate = stockIssueInfo.getDate(pamArray[j]);
										Date tempDate = list.get(i).getDate("dBidLimitTime");
										if(oldDate == null){
											list.get(i).setDate(pamArray[j],tempDate);
										}else{
											list.get(i).setDate(pamArray[j],oldDate);
										}
										System.out.println(pamArray[j]+","+tempDate+","+oldDate);
									}else{
										String oldString = stockIssueInfo.getString(pamArray[j])==null?"":stockIssueInfo.getString(pamArray[j]).toString().trim();
										if(oldString.equals("")){
											list.get(i).setString(pamArray[j],temp);
										}else{
											list.get(i).setString(pamArray[j],oldString);
										}
										System.out.println(pamArray[j]+","+temp+","+oldString);
									}
								}
							}
							mergeStockList.add(list.get(i));
							initMsgError(i,ERROR_MERGE_DATA_ORCLE_UPDATE+stockIssueInfo.getLong("lStockInvestNo"));//返回到前台界面----更新的新债信息
						}else{
							initMsgError(i,ERROR_MERGE_DATA_ORCLE_PARAM+stockIssueInfo.getLong("lStockInvestNo"));
							result=result+ERROR_MERGE_DATA_ORCLE_PARAM;
						}
						continue;
					}
					
					
					objList.add(list.get(i));
				}
			}
			
			return objList;
		}
		
		/**
		 * 判断新债重复数据
		 * @param list
		 * @return
		 */
		public static List<DataObject> checkStockIssueMerge(List<DataObject> list){
			List<DataObject> objList = new ArrayList<DataObject>();
			
			int isMerge = 0;
			//用债券代码和交易市场判重====交易市场根据登记托管所来的，
			for(int a = 0; a < list.size(); a++){
				for(int b=0;b<a;b++){
					if(!list.get(a).get("vcStockCode").toString().equals("")){
						if(list.get(a).get("vcStockCode").toString().equals(list.get(b).get("vcStockCode").toString()) && list.get(a).get("vcPaymentPlace").toString().equals(list.get(b).get("vcPaymentPlace").toString())){
							initMsgError(a,"第"+(a+1)+"行和第"+(b+1)+"行债券代码和登记托管所数据重复！");
							list.get(a).setString("vcStockName", ERROR_MERGE_DATA);
							list.get(b).setString("vcStockName", ERROR_MERGE_DATA);
						}
					}
					for(int c = 0; c<mergeArray.length;c++){
						if(list.get(a).get(mergeArray[c]).toString().equals(list.get(b).get(mergeArray[c]).toString())){
							isMerge++;
						}
					}
					if(isMerge!=mergeArray.length){//不重复
						objList.add(list.get(a));
					}else{
						initMsgError(a,"第"+(a+1)+"行和第"+(b+1)+"行系统参数数据重复！");
						list.get(a).setString("vcStockName", ERROR_MERGE_DATA);
						list.get(b).setString("vcStockName", ERROR_MERGE_DATA);
					}
					isMerge=0;
				}
			}
			
			return objList;
		}
		/**
		 * 将查重策略转变  vc_issuer_name=vcIssuerName
		 * @return map
		 */
		@Bizlet("将查重策略转变")
		public  static String formatSqlToEnt(String array){//c_issue_appraise,en_exist_limite,en_issue_balance,l_issue_begin_date,vc_issue_property,vc_issuer_name,vc_stock_name_full,vc_stock_type

			int index=0;
			String arr="";
			String b="";
			for(int i=0;i<array.length();i++){
				index = array.indexOf("_");
				if(index>0){
					arr = array.substring(0, index);
					arr = array.substring(index+1, index+2);			
					array = array.substring(0, index)+arr.toUpperCase()+array.substring(index+2, array.length());
				}
			}
	
			return array;
		}
		/**
		 * 数据解析
		 * 
		 */
		public static List<DataObject> initData(List<List<Object>> list, DataObject obj){
	        List<DataObject> stockIssueList = new ArrayList<DataObject>();
			for(int j = 1; j < list.size(); j++){
	        	obj = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.stockissue.TAtsStockIssueInfo");
	        	List<Object> pam=list.get(j);
				/*String[] pamArray = new String[]
						{"vcStockCode","vcStockName","vcStockNameFull","vcStockType","vcPaymentPlace","enExistLimite","enIssueBalance","cBondAppraise","vcBondAppraiseOrgan",
						"vcIssuerName","vcIssuerNameFull","vcIssueProperty","cIssueAppraise","vcIssueAppraiseOrgan","vcIndustry","vcProvince","vcGuarantorName","vcGuarantorSummary",
						"lIssuePostDate","lIssueBeginDate","lPayDate","lPublishDate","lBegincalDate","lEndincalDate","cInterestType","cPayInterestType",
						"enPayInteval","enFaceRate","cBidType","cPayType","vcSpecialText","vcMainUnderwriter","vcDeputyUnderwriter","cUnderwriteType","vcGroupUnderwriter",
						"lNextExerciseDate","cIsHaveSaleback","vcCreditAnalyze","dBidLimitTime","cIsHaveBuyback","vcIssueType","vcSpecialLimite"};*/

				//0-8,9-17,18-25,26-34,35-39
				System.out.println(j);
				for(int i=0 ;i<pamArray.length;i++){
					//i=5,6,25,26,40,41,42 BigDecimal
					if(i==enExistLimiteCol || i==enIssueBalanceCol || i==enFaceRateCol || i==enIssuerNetValueCol || i==vcMortStockAmountCol){//enExistLimite,enIssueBalance,enFaceRate
						if(!"".equals(pam.get(i)) && pam.get(i)!=null ){//EN_PAY_INTEVAL
							if(!"".equals(pam.get(i).toString().trim())){
								if(!isNumeric(pam.get(i).toString().trim())){
									//initMsgError(j,ERROR_EN_ISSUE_BALANCE);
									obj.setBigDecimal(pamArray[i], new BigDecimal(-1));
								}else{
									BigDecimal bd=new BigDecimal(pam.get(i).toString().trim());
									obj.setBigDecimal(pamArray[i], bd);
								}
								
							}else{
								obj.setBigDecimal(pamArray[i], new BigDecimal(0));
							}
						}else{
							obj.setBigDecimal(pamArray[i], new BigDecimal(0));
						}
					}else if( i==lNInterestRateJumpPointsCol){
						if(!"".equals(pam.get(i)) && pam.get(i)!=null ){//EN_PAY_INTEVAL
							if(!"".equals(pam.get(i).toString().trim())){
								if(!isNumeric(pam.get(i).toString().trim())){
									//initMsgError(j,ERROR_EN_ISSUE_BALANCE);
									obj.setString(pamArray[i], pam.get(i).toString().trim());
								}else{
									if(pam.get(i).toString().trim().indexOf(".")>0){
										obj.setString(pamArray[i], pam.get(i).toString().trim());
									}else{
										obj.setLong(pamArray[i], Long.parseLong(pam.get(i).toString().trim()));
									}
								}
								
							}else{
								obj.setLong(pamArray[i], 0);
							}
						}else{
							obj.setLong(pamArray[i], 0);
						}
					}else if(i==enPayIntevalCol){//enPayInteval
						if(!"".equals(pam.get(i)) && pam.get(i)!=null ){//EN_PAY_INTEVAL
							if(!"".equals(pam.get(i).toString().trim())){
								if(!isNumeric(pam.get(i).toString().trim())){
									obj.setString(pamArray[i], pam.get(i).toString().trim());
								}else{
									BigDecimal bd=new BigDecimal(pam.get(i).toString().trim());
									obj.setBigDecimal(pamArray[i], bd);
								}
								
							}else{
								obj.setBigDecimal(pamArray[i], new BigDecimal(-2));
							}
						}else{
							obj.setBigDecimal(pamArray[i], new BigDecimal(-2));
						}
					}else if(i==lIssuePostDateCol||i==lIssueBeginDateCol||i==lPayDateCol||i==lPublishDateCol||i==lBegincalDateCol||i==lEndincalDateCol||i==lNextExerciseDateCol){
						if(!"".equals(pam.get(i)) && pam.get(i)!=null){//L_BEGINCAL_DATE
							if(!"".equals(pam.get(i).toString().trim())){
								if(pam.get(i).toString().trim().length()==8){
									if(!checkDate(pam.get(i).toString().trim())){
										obj.setInt(pamArray[i], -1);
									}else{
										obj.setInt(pamArray[i], Integer.parseInt(pam.get(i).toString().trim()));
									}
								}else{
									obj.setInt(pamArray[i], -1);
								}
							}else{
								obj.setInt(pamArray[i], -1);
							}
							//obj.setInt(pamArray[i], Integer.parseInt(pam.get(i).toString()));
						}else{
							obj.setInt(pamArray[i], 0);
						}
					}/*else if(i==35){//lNextExerciseDate行权年只要输入年
						if(!"".equals(pam.get(i)) && pam.get(i)!=null){
							if(!"".equals(pam.get(i).toString().trim())){
								if(pam.get(i).toString().trim().length()==4){//只输入年
									String lNextExerciseDate =pam.get(i).toString().trim()+"0101";//补齐日期
									if(!checkDate(lNextExerciseDate)){
										obj.setInt(pamArray[i], -1);
									}else{
										obj.setInt(pamArray[i], Integer.parseInt(lNextExerciseDate));
									}
								}else{
									obj.setInt(pamArray[i], -1);
								}
							}else{
								obj.setInt(pamArray[i], -1);
							}
						}else{
							obj.setInt(pamArray[i], 0);
						}
					}*/else if(i==dBidLimitTimeCol){//D_BID_LIMIT_TIME
						if(!"".equals(pam.get(i)) && pam.get(i)!=null){//D_BID_LIMIT_TIME
							//obj.setString(pamArray[i], pam.get(i).toString());
							if(!"".equals(pam.get(i).toString().trim())){
								if(pam.get(i).toString().trim().length()==14){
									if(!checkDate(pam.get(i).toString().trim())){
										//initMsgError(j,ERROR_D_BID_LIMIT_TIME);
										obj.setInt(pamArray[i], -1);
									}else{
										obj.setString(pamArray[i],pam.get(i).toString().trim());
									}
								}else{
									obj.setInt(pamArray[i], -1);
								}
							}else{
								obj.setInt(pamArray[i], -1);
							}
						}else{
							obj.setDate(pamArray[i], null);
						}
					}else if(i==cIsHaveBuybackCol ||  i== cIsHaveSalebackCol){//填是否
						if(!"".equals(pam.get(i)) && pam.get(i)!=null ){//C_PAY_INTEREST_TYPE
							if("".equals(pam.get(i).toString().trim())){
								obj.setString(pamArray[i], "");
							}else{
								if("是".equals(pam.get(i).toString().trim())){
									obj.setString(pamArray[i], "1");
								}else if("否".equals(pam.get(i).toString().trim())){
									obj.setString(pamArray[i], "0");
								}else{
									obj.setString(pamArray[i], pam.get(i).toString().trim());
								}
							}
							
						}else{
							obj.setString(pamArray[i], "0");
						}
					}else{
						if(!"".equals(pam.get(i)) && pam.get(i)!=null ){//C_PAY_INTEREST_TYPE
							obj.setString(pamArray[i], pam.get(i).toString().trim());
						}else{
							obj.setString(pamArray[i], "");
						}
					}
				}
	        	
				obj.setInt("lIssuerId", 0);//L_ISSUER_ID
				obj.setString("cMarketNo", "");//C_MARKET_NO
				obj.setLong("lStockIssueId", 0);//lStockIssueId
				stockIssueList.add(obj);
	        }
			return stockIssueList;
		}
		/**
		 * 数据解析
		 * name,nameFull,issueP,issueApOr,issueApp,ind,pro,vcIssueA,enIssuer,vcCity
		 */
		public static DataObject issuerData(String name,String vcIssuerNameFull,String issueP,String issueApOr,String issueApp,String ind,String pro,String vcIssueA,String enIssuer,String vcCity){
			DataObject obj = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.stockissue.TAtsIssuerInfo");
			Long lIssuerId = JDBCUtil.getNextSequence("SEQISSUERNO");
			Long code = JDBCUtil.getNextSequence("SEQISSUERCODE");//seqissuercode
			String issuerCode = "CJ"+code;
			obj.setInt("lIssuerId", new Long(lIssuerId).intValue());
			obj.setString("vcIssueName", name);
			obj.setString("vcIssueNameFull", vcIssuerNameFull);
			String vcIssueNameChar = getHZPY(vcIssuerNameFull);
			obj.setString("vcIssueNameChar",vcIssueNameChar);
			
			obj.setString("vcIssueProperty",issueP);//VC_ISSUE_PROPERTY
			obj.setString("vcIssueAppraiseOrgan",issueApOr);//VC_ISSUE_APPRAISE_ORGAN
			obj.setString("vcIssueAppraise",issueApp);//C_ISSUE_APPRAISE
			obj.setString("vcIndustry",ind);//VC_INDUSTRY
			obj.setString("vcProvince",pro);//VC_PROVINCE
			obj.setString("vcIssueAppraiseCsrc",vcIssueA);//vcIssueAppraiseCsrc
			if(enIssuer!=""){
				obj.setBigDecimal("enIssuerNetValue",new BigDecimal(enIssuer.trim()));//enIssuerNetValue
			}else{
				obj.setBigDecimal("enIssuerNetValue",new BigDecimal(0));//enIssuerNetValue
			}
			obj.setString("vcCityLevel",vcCity);//vcCityLevel
			obj.setString("vcIssuerCode",issuerCode);//VC_ISSUER_CODE
			obj.setInt("lIssuerIdO32",0);//L_ISSUER_ID_O32
			return obj;
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
        public static void main(String[] args) {
        	
		}
        /**
         * 获取去重地段
         */
        @Bizlet("")
        public static String getMergeCol(String key){
        	String mergeCol = "";
        	try {//com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.getParamValue
    	    	String componentName = "com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz";//逻辑构建名称
    	        String operationName = "getParamValue";//逻辑流名称
    	        
    	        ILogicComponent comp = LogicComponentFactory.create(componentName);
    	        String paramKey = key;//"ATS_FM_SEARCH_STRATEGY";
    	        Object[] params = new Object[]{paramKey};
    	        Object[] result = (Object[])comp.invoke(operationName,params);  	        
    	        mergeCol = result[0].toString();//[c_issue_appraise,en_exist_limite,en_issue_balance,l_issue_begin_date,vc_issue_property,vc_issuer_name,vc_stock_name_full,vc_stock_type]
    		} catch (Throwable e) {
    			e.printStackTrace();
    		}
    		return mergeCol;
        }
        /**
         * 数据字典项校验【数据字典等】
         */
        @Bizlet("")
        public static String checkDict(String dicttypeid,String dictname){
        	String dictid = "";
        	try {
    	    	String componentName = "com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager";//逻辑构建名称
    	        String operationName = "checkDictEntry";//逻辑流名称
    	        
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
         * 【债券类型查询】
         */
        @Bizlet("")
        public static String checkStockType(String vcStocktypeName){
        	String stockType = "";
        	try {
    	    	String componentName = "com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager";//逻辑构建名称
    	        String operationName = "checkStockType";//逻辑流名称
    	        
    	        ILogicComponent comp = LogicComponentFactory.create(componentName);
    	        Object[] params = new Object[]{vcStocktypeName};
    			Object[] result2 = (Object[])comp.invoke(operationName,params);
    			if(result2[0]!=null){
    				stockType = result2[0].toString();
    			}else{
    				stockType = "";
    			}
    			
    		} catch (Throwable e) {
    			e.printStackTrace();
    		}
    		return stockType;
        }
        /**
         * 【所属行业查询】
         */
        @Bizlet("")
        public static String checkIssueAppCsrc(String vcName,String type){
        	String issueAppCsrc = "";
        	try {
    	    	String componentName = "com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager";//逻辑构建名称
    	        String operationName = "checkIndustry";//逻辑流名称
    	        
    	        ILogicComponent comp = LogicComponentFactory.create(componentName);
    	        Object[] params = new Object[]{vcName,type};
    			Object[] result2 = (Object[])comp.invoke(operationName,params);
    			if(result2[0]!=null){
    				issueAppCsrc = result2[0].toString();
    			}else{
    				issueAppCsrc = "";
    			}
    			
    		} catch (Throwable e) {
    			e.printStackTrace();
    		}
    		return issueAppCsrc;
        }
        /**
         * 【发行主体查询】
         */
        @Bizlet("")
        public static DataObject checkIssuerInfo(String vcIssuerNameFull){
        	DataObject issuerInfo = null ;
        	try {
    	    	String componentName = "com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager";//逻辑构建名称
    	        String operationName = "checkIssuerInfo";//逻辑流名称
    	        
    	        ILogicComponent comp = LogicComponentFactory.create(componentName);
    	        Object[] params = new Object[]{vcIssuerNameFull};
    			Object[] result3 = (Object[])comp.invoke(operationName,params);
    			/*if(result3[0]!=null){
    				issuerInfo = result3[0].toString();
    			}else{
    				issuerInfo = "";
    			}*/
    			if(result3[0]!=null){
    				Object[] temp=(Object[]) result3[0];
    				if(temp.length>0){
    					issuerInfo = (DataObject) temp[0];
    				}
    			}
    		} catch (Throwable e) {
    			e.printStackTrace();
    		}
    		return issuerInfo;
        }
        /**
         * 根据债券代码和登记托管所   判断excel的数据在数据库中是否存在
         */
        @Bizlet("")
        public static DataObject checkStockInfo(String vcStockCode,String vcPaymentPlace){
        	DataObject data = null;
        	try {//com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager.checkStockIssueInfo
    	    	String componentName = "com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager";//逻辑构建名称
    	        String operationName = "checkStockIssueInfo";//逻辑流名称
    	        
    	        ILogicComponent comp = LogicComponentFactory.create(componentName);
    	        Object[] params = new Object[]{vcStockCode,vcPaymentPlace};
    			Object[] result3 = (Object[])comp.invoke(operationName,params);
    			if(result3 != null){
    	        	Object[] temp=(Object[]) result3[0];
    	    	    if(temp.length>0){
    	    	    	data = (DataObject)temp[0];
    	    	    }
    	        }
    		} catch (Throwable e) {
    			e.printStackTrace();
    		}
    		return data;
        }
        /**
         * 根据系统参数   判断excel的数据在数据库中是否存在
         * 发行人全称|vcIssuerNameFull;债券全称|vcStockNameFull;发行期限|enExistLimite;发行额度|enIssueBalance;
         * 发行日期|lIssueBeginDate;主体评级|cIssueAppraise;企业性质|vcIssueProperty;登记托管机构|vcPaymentPlace;
         * 
         */
        @Bizlet("")
        public static DataObject checkStockInfoByParam(String vcIssuerNameFull,String vcStockNameFull,String enExistLimite,String enIssueBalance,String lIssueBeginDate,String cIssueAppraise,String vcIssueProperty,String vcPaymentPlace,String cMarketNo){
        	DataObject data = null;
        	Map<String, String> map = new HashMap<String, String>();
        	try {//com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager.checkStockInfoByParam
    	    	String componentName = "com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager";//逻辑构建名称
    	        String operationName = "checkStockInfoByParam";//逻辑流名称
    	        ILogicComponent comp = LogicComponentFactory.create(componentName);
    	        map.put("cMarketNo", cMarketNo);
    	        if(mergeArray.length>0){
    	        	for(int x=0;x<mergeArray.length;x++){
    	        		if(mergeArray[x].equals("vcIssuerNameFull")){
    	        			map.put("vcIssuerNameFull", vcIssuerNameFull);
    	        		}
    	        		if(mergeArray[x].equals("vcStockNameFull")){
    	        			map.put("vcStockNameFull", vcStockNameFull);
    	        		}
    	        		if(mergeArray[x].equals("enExistLimite")){
    	        			map.put("enExistLimite", enExistLimite);
    	        		}
    	        		if(mergeArray[x].equals("enIssueBalance")){
    	        			map.put("enIssueBalance", enIssueBalance);
    	        		}
    	        		if(mergeArray[x].equals("lIssueBeginDate")){
    	        			map.put("lIssueBeginDate", lIssueBeginDate);
    	        		}
    	        		if(mergeArray[x].equals("cIssueAppraise")){
    	        			map.put("cIssueAppraise", cIssueAppraise==""?null:cIssueAppraise);
    	        		}
    	        		if(mergeArray[x].equals("vcIssueProperty")){
    	        			map.put("vcIssueProperty", vcIssueProperty==""?null:vcIssueProperty);
    	        		}
    	        		if(mergeArray[x].equals("vcPaymentPlace")){
    	        			map.put("vcPaymentPlace", vcPaymentPlace);
    	        		}
    	        	}
    	        }
    	        Object[] params = new Object[]{map};
    			Object[] result3 = (Object[])comp.invoke(operationName,params);
    			
    			if(result3 != null){
    	        	Object[] temp=(Object[]) result3[0];
    	    	    if(temp.length>0){
    	    	    	data = (DataObject)temp[0];
    	    	    	//bool =  data.getString("lStockIssueId");
    	    	    }
    	        }
    			
    			//bool = result3[0].toString();
    		} catch (Throwable e) {
    			e.printStackTrace();
    		}
    		return data;
        }
        /**
    	 * 新债信息导入统计
    	 * @param list
    	 * @param obj
    	 * @return
    	 */
    	public static List<DataObject> countInfo(List<List<Object>> list, List<DataObject> stockIssueList,List<DataObject> mergeStockList){
    		NUM = list.size()-1;
    		SUCCESS_NUM = stockIssueList.size() + mergeStockList.size();
    		FAIL_NUM = NUM - SUCCESS_NUM;
    		DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
    		ob.setLong("num", NUM);
    		ob.setLong("successNum", SUCCESS_NUM);
    		ob.setLong("failNum", FAIL_NUM);
    		msgList.add(ob);
    		return stockIssueList;
    	}
    	@Bizlet("")
        public static String getHZPY(String vcIssueName) {
        	String vcIssueNameChar = "";
        	StringBuffer sql = new StringBuffer();
            boolean execute = true;
            Connection conn_qjy = null;
            CallableStatement cStmt_qjy = null;
            while (execute) {
                conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
                try {
                   sql.append("select UPPER(GETHZPY.GETHZPYCAP(");//"vcIssueNameChar"+)) from dual"
                   sql.append("'"+vcIssueName+"')) from dual");
                   vcIssueNameChar = JDBCUtil.getValueBySql(conn_qjy, sql.toString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                finally {
                    JDBCUtil.releaseResource(conn_qjy, cStmt_qjy, null);
                }
                execute = false;
            }
            return vcIssueNameChar;
        }

    	/**
    	 * 获取导入日志
    	 * @return
    	 * @throws IOException 
    	 */
    	@Bizlet("获取导入的数据") 
        public static List<DataObject> getExportList(List<List<DataObject>> allList) throws IOException {  
    		return allList.get(0);
        }  
    	/**
    	 * 获取错误日志日志
    	 * @return
    	 * @throws IOException 
    	 */
    	@Bizlet("获取错误日志的数据") 
        public static List<DataObject> getErrorList(List<List<DataObject>> allList) throws IOException {  
    		return allList.get(1);
        }
    	/**
    	 * 获取要插入发行主体日志日志
    	 * @return
    	 * @throws IOException 
    	 */
    	@Bizlet("获取错误日志的数据") 
        public static List<DataObject> getissuerList(List<List<DataObject>> allList) throws IOException {  
    		return allList.get(2);
        }
    	/**
    	 * 获取重复的新债信息
    	 * @return
    	 * @throws IOException 
    	 */
    	@Bizlet("获取错误日志的数据") 
        public static List<DataObject> getMergeStockList(List<List<DataObject>> allList) throws IOException {  
    		return allList.get(3);
        }

    	@Bizlet("转换债券类别")
    	public static String formatVcStockType(String stockType){		
    		//转换债券类别
    		String issuerInfo = null ;
    		if(stockType!=null || stockType!=""){
            	try {//com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager.queryStockTypeName
        	    	String componentName = "com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager";//逻辑构建名称
        	        String operationName = "queryStockTypeName";//逻辑流名称
        	        
        	        ILogicComponent comp = LogicComponentFactory.create(componentName);
        	        Object[] params = new Object[]{stockType};
        			Object[] result3 = (Object[])comp.invoke(operationName,params);
        			if(result3[0]!=null){
        				issuerInfo = result3[0].toString();
        			}else{
        				issuerInfo = "";
        			}
        		} catch (Throwable e) {
        			e.printStackTrace();
        		}
            	
    		}
    		
    		return issuerInfo;
    	}

}
