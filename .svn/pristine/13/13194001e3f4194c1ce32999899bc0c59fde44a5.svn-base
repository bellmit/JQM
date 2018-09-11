/**
 * 
 */
package com.cjhxfund.ats.fm.baseinfo;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;

import com.eos.foundation.eoscommon.LogUtil;
import com.cjhxfund.ats.fm.comm.ExcelHelper;
import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.cjhxfund.cjapi.common.JSONUtil;
import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.data.datacontext.IUserObject;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.common.utils.DateUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * @author 黄燕
 * @date 2017-03-02 16:51:07
 *
 */
@Bizlet("")
public class UnderwriterStockUpload {

	
	private final static String ERROR_MERGE_DATA_ORCLE_UPDATE = "更新数据库已经存在的数据:";
	private final static String ERROR_MERGE_DATA = "excel中数据重复！";
	/*private final static String ERROR_VC_MAIN_UNDERWRITER = "主承销商为必填。";
	private final static String ERROR_VC_ISSUER_NAME_FULL = "发行主体全称为必填。";
	private final static String ERROR_VC_PAYMENT_PLACE = "登记托管机构为必填。";*/
	//主承销商-发行人-登记托管机构
	static List<DataObject> msgList = null;//错误信息
	static List<DataObject> attachInfoList = null;//附件信息
	//static List<DataObject> mergeUnderwriterList = null;//重承销商信息
	private static int NUM = 0;
	
	private static int SUCCESS_NUM = 0;
	private static String[] mergeArray = null;
	private static int FAIL_NUM = 0;
	static String[] pamArray = new String[]
			{"vcMainUnderwriter","vcUnderwriterContactInfo","vcApplicationTime","vcEntryTime","vcIssuerNameFull","vcStockType","vcIssueType","vcStockName","vcStockNameFull",
		"vcIssueBalance","vcExistLimite","vcExistLimiteDesc","vcInquiryInterval","vcIssueAppraise","vcBondAppraise","vcAppraiseOrgan","vcPaymentPlace",
		"vcDueDate","vcPayInteval","vcBegincalDate","vcCreditSituation","vcEnterpriseProperty","vcIsBid","vcMarkAssets","vcOldHolder","vcIsPledge","vcPropertyDesc",
		"vcInfoNetUrl","vcInfoNetUrlTime","vcSummaryTime","vcSummaryUrl","vcHisIssue","vcIsHaveFinancing"};
	/**
	 * 获取导入的数据
	 * @param filePath
	 * @return
	 * @throws IOException 
	 */
	@Bizlet("获取导入的数据") 
    public static List<List<DataObject>> getUnderwriterExportList(String filePath,String fileName) throws IOException {  
		List<List<DataObject>> allList = new ArrayList<List<DataObject>>();
        List<List<Object>> list = null;  
        msgList = new ArrayList<DataObject>();
        list = ExcelHelper.exportListFromExcel(new File(filePath), 0);  //解析excel中的数据，返回list
        if(list.size()<=1){//空模板
        	initMsgError(0,"模板数据为空，请检查数据.");
        }
        //数据保存并基本校验
        List<DataObject> underwriterList = checkStockIssueValid(list,fileName);
        countInfo(list,underwriterList);
        allList.add(underwriterList);
        allList.add(msgList);
        allList.add(attachInfoList);
        return allList;
    } 
	/**
	 * 承销商信息导入校验
	 * @param list
	 * @return
	 */
	public static List<DataObject> checkStockIssueValid(List<List<Object>> list, String fileName){
		//解析数据
		List<DataObject> underList = initData(list,fileName);
		//判断重复
		List<DataObject> mergeList = checkUnderwriterMerge(underList);
		List<DataObject> trueList = checkUnderwriterListNotNullValid(underList);
		return trueList;
	}
	/**
	 * 数据解析
	 * 
	 */
	public static List<DataObject> initData(List<List<Object>> list,String fileName){
        List<DataObject> underwriterList = new ArrayList<DataObject>();
        DataObject underwriterStock = null;
        DataObject attachInfo = null;
        attachInfoList = new ArrayList<DataObject>();
		for(int j = 1; j < list.size(); j++){
        	//obj = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.stockissue.TAtsUnderwriterStockInfo");
        	List<Object> pam=list.get(j);
			System.out.println(j);
			underwriterStock = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.stockissue.TAtsUnderwriterStockInfo");
			Date date = new Date();
	    	String ymd = DateUtil.format(date, "yyyyMMdd");
			for(int i=0 ;i<pamArray.length;i++){
				if(i==27){//材料网络下载链接,材料网络版更新时间 ,
					attachInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.TAtsAttachInfo");
					if(!"".equals(pam.get(27))&&pam.get(27)!=null){
						attachInfo.setString("vcAttachAdd", pam.get(27).toString().trim());
					}
					if(!"".equals(pam.get(28))&&pam.get(28)!=null){
						attachInfo.setString("vcAttachName", pam.get(28).toString().trim()+"_"+fileName);
					}else{
						attachInfo.setString("vcAttachName", ymd+"_"+fileName);
					}
					if(attachInfo.getString("vcAttachAdd")!=null){
						attachInfo.setString("vcAttachBizType","9");
						attachInfo.setString("vcAttachType","9");
						attachInfo.setString("vcAttachSize","DR"+j);
						attachInfoList.add(attachInfo);
					}
				}else if(i==29){//路演时间,调研纪要/路演纪要（若有） 下载链接
					attachInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.TAtsAttachInfo");
					if(!"".equals(pam.get(29))&&pam.get(29)!=null){
						attachInfo.setString("vcAttachName", pam.get(29).toString().trim()+"_"+fileName);
					}else{
						attachInfo.setString("vcAttachName", ymd+"_"+fileName);
					}
					if(!"".equals(pam.get(30))&&pam.get(30)!=null){
						attachInfo.setString("vcAttachAdd", pam.get(30).toString().trim());
					}
					if(attachInfo.getString("vcAttachAdd")!=null){
						attachInfo.setString("vcAttachBizType","10");
						attachInfo.setString("vcAttachType","10");
						attachInfo.setString("vcAttachSize","DR"+j);
						attachInfoList.add(attachInfo);
					}
				}else{
					if(!"".equals(pam.get(i)) && pam.get(i)!=null ){
						underwriterStock.setString(pamArray[i], pam.get(i).toString().trim());
					}else{
						underwriterStock.setString(pamArray[i], "");
					}
					underwriterStock.setString("checkMergeParam", "");
				}
			}
			underwriterList.add(underwriterStock);
        }
		return underwriterList;
	}
	/**
	 * 新债信息导入非空校验
	 * @param list
	 * @return
	 */
	public static List<DataObject> checkUnderwriterListNotNullValid(List<DataObject> list){
		// 取得上下文
		IMUODataContext muo = DataContextManager.current().getMUODataContext();
		IUserObject user=muo.getUserObject();
		List<DataObject> objList = new ArrayList<DataObject>();
		for(int i = 0; i < list.size(); i++){
			String result="";
			/*if(list.get(i).get("vcMainUnderwriter").toString().trim().equals("")){//主承销商必填校验
				initMsgError(i,ERROR_VC_MAIN_UNDERWRITER);
				result=result+ERROR_VC_MAIN_UNDERWRITER;
			}
			if(list.get(i).get("vcIssuerNameFull").toString().trim().equals("")){//发行主体全称必填校验
				initMsgError(i,ERROR_VC_ISSUER_NAME_FULL);
				result=result+ERROR_VC_ISSUER_NAME_FULL;
			}
			if(list.get(i).get("vcPaymentPlace").toString().trim().equals("")){//登记托管机构必填校验
				initMsgError(i,ERROR_VC_PAYMENT_PLACE);
				result=result+ERROR_VC_PAYMENT_PLACE;
			}*/
			if(list.get(i).get("checkMergeParam").toString().equals(ERROR_MERGE_DATA)){
				//initMsgError(i,ERROR_MERGE_DATA);
				result=result+ERROR_MERGE_DATA;
			}
			if(result.equals("") || result== ""){
				Long lUnderwriterStockId = null;
				String vcUnderwriterName = null;
				DataObject underwriterInfo = checkUnderwriterInfo(list.get(i).get("vcStockType").toString().trim(),list.get(i).get("vcIssuerNameFull").toString().trim(),list.get(i).get("vcPaymentPlace").toString().trim(),list.get(i).get("vcExistLimite").toString().trim());//判断数据库是否存在重复的承销商
				if(underwriterInfo==null){
					DataObject underwriterInfo1 = checkUnderwriterInfoCustom(list.get(i));//判断数据库是否存在重复的承销商
					underwriterInfo=underwriterInfo1;
				}
				if(underwriterInfo!=null){//查到重复记录记录
					lUnderwriterStockId = underwriterInfo.getLong("lUnderwriterStockId");
					if(user != null && isJudgeRoleUnderwriter(user.getUserId())==1){
						if(underwriterInfo.getString("vcUnderwriterName").indexOf(user.getUserId().toString())!=-1){
							vcUnderwriterName = underwriterInfo.getString("vcUnderwriterName");
						}else{
							list.get(i).setString("vcMainUnderwriter",  list.get(i).getString("vcMainUnderwriter")+","+underwriterInfo.getString("vcMainUnderwriter"));
							vcUnderwriterName = underwriterInfo.getString("vcUnderwriterName")+","+user.getUserId();
						}
					}
					
					//mergeUnderwriterList.add(list.get(i));//添加到重复承销商信息
					initMsgError(i,ERROR_MERGE_DATA_ORCLE_UPDATE+"债券类别:"+list.get(i).get("vcStockType").toString()+",发行主体全称:"+underwriterInfo.getString("vcIssuerNameFull")+",登记托管机构:"+list.get(i).get("vcPaymentPlace").toString()+",发行期限:"+list.get(i).get("vcExistLimite").toString());//返回到前台界面----更新的新债信息
					//continue;
					
				}else{//没有重复数据，赋值主键
					lUnderwriterStockId = JDBCUtil.getNextSequence("UNDERWRITERSTOCKNO");
					if (user != null) {
						vcUnderwriterName = user.getUserId();
					}
				}
				list.get(i).setLong("lUnderwriterStockId",  lUnderwriterStockId);
				list.get(i).setString("vcUnderwriterName",  vcUnderwriterName);
				
				for(int j=0;j<attachInfoList.size();j++){
					if(attachInfoList.get(j).getString("vcAttachSize").equals("DR"+(i+1))){
						attachInfoList.get(j).setLong("lBizId",lUnderwriterStockId);
					}
				}
				objList.add(list.get(i));
			}
		}
		return objList;
	}
	/**
	 * 判断excel中重复数据vcExistLimite
	 * @param list
	 * @return
	 */
	public static List<DataObject> checkUnderwriterMerge(List<DataObject> list){
		List<DataObject> objList = new ArrayList<DataObject>();
		Map<String,Object> map=new HashMap<String, Object>();
		//
		for(int a = 0; a < list.size(); a++){
			int count=0;
			for(int b=0;b<a;b++){
				if(!list.get(a).get("vcStockType").toString().equals("")&&!list.get(a).get("vcIssuerNameFull").toString().equals("")&&!list.get(a).get("vcPaymentPlace").toString().equals("")&&!list.get(a).get("vcExistLimite").toString().equals("")){
					if(list.get(a).get("vcStockType").toString().equals(list.get(b).get("vcStockType").toString()) && list.get(a).get("vcPaymentPlace").toString().equals(list.get(b).get("vcPaymentPlace").toString())
							&& list.get(a).get("vcIssuerNameFull").toString().equals(list.get(b).get("vcIssuerNameFull").toString()) && list.get(a).get("vcExistLimite").toString().equals(list.get(b).get("vcExistLimite").toString())){
						count++;
						list.get(b).setString("checkMergeParam", ERROR_MERGE_DATA);
					}
				}
			}
			if(count!=0 && map.get(list.get(a).get("vcIssuerNameFull").toString())==null){
				initMsgError(a,list.get(a).get("vcIssuerNameFull").toString()+"数据重复,"+"已导入第"+a+"条");
				map.put(list.get(a).get("vcIssuerNameFull").toString(), list.get(a).get("vcIssuerNameFull").toString());
			}
		}
		
		return objList;
	}
	/**
     * 根据 主承销商-发行人-登记托管机构  判断excel的数据在数据库中是否存在,存在则更新，
     */
    @Bizlet("")
    public static DataObject checkUnderwriterInfo(String vcStockType,String vcIssuerNameFull,String vcPaymentPlace,String vcExistLimite){
    	DataObject data = null;
    	try {//com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager.checkMergeUnderwriter
	    	String componentName = "com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager";//逻辑构建名称
	        String operationName = "checkMergeUnderwriter";//逻辑流名称
	        Map<String, String> map = new HashMap<String, String>();
	        ILogicComponent comp = LogicComponentFactory.create(componentName);
	        //map.put("vcMainUnderwriter", vcMainUnderwriter);
	        map.put("vcExistLimite", vcExistLimite);
	        map.put("vcStockType", vcStockType);
	        map.put("vcIssuerNameFull", vcIssuerNameFull);
	        map.put("vcPaymentPlace", vcPaymentPlace);
	        
	        Object[] params = new Object[]{map};
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
     * 根据 判断excel的数据在数据库中是否存在
     */
    @Bizlet("")
    public static DataObject checkUnderwriterInfoCustom(DataObject dataObject){
    	DataObject underwriter = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.stockissue.TAtsUnderwriterStockInfo");
    	underwriter=dataObject;
    	DataObject data = null;
    	try {//com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager.checkUnderwriterUpload
	    	String componentName = "com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager";//逻辑构建名称
	        String operationName = "checkUnderwriterUpload";//逻辑流名称
	        ILogicComponent comp = LogicComponentFactory.create(componentName);
	        
	        Object[] params = new Object[]{underwriter};
			Object result3 = (Object)comp.invoke(operationName,params);
			if(result3 != null){
	        	Object temp[]=(Object[]) result3;
	        	if("1".equals(temp[1])){
	    	    	data = (DataObject)temp[0];
	    	    }
	        }
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return data;
    }
    public static void main(String[] args) {
    	/*Date date = new Date();
    	String ymd = DateUtil.format(date, "yyyyMMdd");
    	System.out.println(ymd);*/
    	String str="10亿由高新投担保，大公AA/AAA；7亿无担保，大公AA/AA";
    	String[] spl=str.split("/");
    	System.out.println("输出："+spl[0].replaceAll("[^A-Z]", "")+"====="+spl[0].replaceAll("[^A-Z]", "")+"=========="+spl.length);
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
	 * 新债信息导入统计
	 * @param list
	 * @param obj
	 * @return
	 */
	public static List<DataObject> countInfo(List<List<Object>> list, List<DataObject> underwriterList){
		NUM = list.size();
		SUCCESS_NUM = underwriterList.size();
		FAIL_NUM = NUM - SUCCESS_NUM;
		DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
		ob.setLong("num", NUM);
		ob.setLong("successNum", SUCCESS_NUM);
		ob.setLong("failNum", FAIL_NUM);
		msgList.add(ob);
		return underwriterList;
	}
	/**
	 * 获取导入日志
	 * @return
	 * @throws IOException 
	 */
	@Bizlet("获取导入的承销商数据") 
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
	 * 获取要插入的附件日志
	 * @return
	 * @throws IOException 
	 */
	@Bizlet("获取要插入的附件数据") 
    public static List<DataObject> getAttachList(List<List<DataObject>> allList) throws IOException {  
		return allList.get(2);
    }
	/**
	 * 组装交易对手代码
	 * @return
	 * @throws IOException 
	 */
	@Bizlet("组装交易对手代码") 
	public static String getRivalCode(String vcRivalCode){
		   String RivalCode=vcRivalCode.replaceAll("-", "CJ");
		return RivalCode;
	}
	
	@Bizlet("")
	public static boolean underwriterStockInfoWash() {
    	SynCommonUtil.insertMsg("2", "开始新债导入数据清洗", 0, "新债导入数据清洗", "开始新债导入数据清洗");
        boolean execute = true;
        boolean isSuccess = false;
        Connection conn_qjy = null;
        CallableStatement cStmt_qjy = null;
        System.out.println("[SP_SYNC_UNDERWRITER_STOCK_WASH]"+"开始执行存储过程SP_SYNC_UNDERWRITER_STOCK_WASH..");
        LogUtil.logInfo("[SP_SYNC_UNDERWRITER_STOCK_WASH]"+"开始执行存储过程SP_SYNC_UNDERWRITER_STOCK_WASH..", null, new Object[]{});
        while (execute) {
            conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
            try {
                String procedure = "{call SP_SYNC_UNDERWRITER_STOCK_WASH(?,?)}";
                cStmt_qjy = conn_qjy.prepareCall(procedure);
                cStmt_qjy.registerOutParameter(1, Types.INTEGER);
                cStmt_qjy.registerOutParameter(2, Types.INTEGER);
                cStmt_qjy.executeUpdate();
                int l_success = -1;
                isSuccess = true;
                l_success = cStmt_qjy.getInt(1);
                if (l_success != 0){
                    isSuccess = false;
                    execute = false;
                    LogUtil.logError("[SP_SYNC_UNDERWRITER_STOCK_WASH]"+"函数执行失败,新债导入数据清洗出错!", null, new Object[]{});
                }
            } catch (Exception e) {
                e.printStackTrace();
                LogUtil.logError("[SP_SYNC_UNDERWRITER_STOCK_WASH]"+"函数执行失败,新债导入数据清洗出错!", e, new Object[]{});
            }
            finally {
                JDBCUtil.releaseResource(conn_qjy, cStmt_qjy, null);
            }
            execute = false;
        }
        SynCommonUtil.insertMsg("2", "结束新债导入数据清洗", 0, "新债导入数据清洗", "结束新债导入数据清洗");
        LogUtil.logInfo("[SP_SYNC_UNDERWRITER_STOCK_WASH]"+"结束执行存储过程SP_SYNC_UNDERWRITER_STOCK_WASH..", null, new Object[]{});
        System.out.println("[SP_SYNC_UNDERWRITER_STOCK_WASH]"+"结束执行存储过程SP_SYNC_UNDERWRITER_STOCK_WASH..");
        return isSuccess;
    }
	/**
	 * 判断当前登录人员是否为交易员
	 * @param userId  用户ID
	 * @return 反馈状态 
	 */
	@Bizlet("判断是否交易员")
	public static int isJudgeRoleJYY(String userId){
		int judge = 0;
		//根据用户ID查询相应员工信息
		DataObject emp = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.OrgEmployee");
		emp.setString("operatorid", userId);
		DatabaseUtil.expandEntityByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, emp, emp);
		
		//根据员工ID查询所属的机构
		DataObject emporg = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.OrgEmporg");
		emporg.setString("empid", emp.getString("empid"));
		DataObject[] objs = DatabaseUtil.queryEntitiesByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, emporg);
		
		//判断当前登录用户是否是交易员
		for(int i = 0; i < objs.length; i++){
			if(objs[i].getString("orgid").equals("2")){
				judge = 1;
				return judge;
			}
		}
		return judge;
	}
	/**
	 * 判断当前登录人员是否为主承销商
	 * @param userId  用户ID
	 * @return 反馈状态 
	 */
	@Bizlet("判断当前登录人员是否为主承销商")
	public static int isJudgeRoleUnderwriter(String userId){
		int judge = 0;
		//根据用户ID查询相应员工信息
		DataObject emp = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.OrgEmployee");
		emp.setString("operatorid", userId);
		DatabaseUtil.expandEntityByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, emp, emp);
		
		//根据员工ID查询所属的机构
		DataObject emporg = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.OrgEmporg");
		emporg.setString("empid", emp.getString("empid"));
		DataObject[] objs = DatabaseUtil.queryEntitiesByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, emporg);
		
		//判断当前登录用户是否是主承销商
		for(int i = 0; i < objs.length; i++){
			if(objs[i].getString("orgid").equals("201")){
				judge = 1;
				return judge;
			}
		}
		return judge;
	}
	
	/**
	 * 转换承销商历史表数据
	 * @author 谢海光
	 * 
	 */
	@Bizlet("转换承销商历史表数据")
	public static DataObject getUnderwritInfo(DataObject[] objs,DataObject obj) {
		String[] pamArray = new String[]
				{"lUnderwriterStockId","vcMainUnderwriter","vcUnderwriterContactInfo","vcApplicationTime","vcEntryTime","vcIssuerNameFull","vcStockType","vcIssueType",
				"vcStockName","vcStockNameFull","vcIssueBalance","vcExistLimite","vcExistLimiteDesc","vcInquiryInterval","vcIssueAppraise","vcBondAppraise",
				"vcAppraiseOrgan","vcPaymentPlace","vcDueDate","vcPayInteval","vcBegincalDate","vcCreditSituation","vcEnterpriseProperty","vcIsBid",
				"vcMarkAssets","vcOldHolder","vcIsPledge","vcPropertyDesc","vcHisIssue","vcIsHaveFinancing","cStatus","vcExportFilename",
				"lReleaseCount","dUpdateTime","lOperatorNo"};

		
		SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义时间格式
		//解析数组中对于字段的值
		for (int i = 0; i < pamArray.length; i++) {
			//时间类型数据处理
			if("dUpdateTime".equals(pamArray[i])){
				try {
					Date value=objs[0].getDate(pamArray[i]);
					//传入返回对象中
					obj.setDate(pamArray[i],value);
				} catch (Exception e) {
					LogUtil.logError("字段dUpdateTime 时间格式转换失败:{0}", e, objs[0].getDate(pamArray[i]));
					e.printStackTrace();
				}
			}else{
				String value=objs[0].getString(pamArray[i]);
				//传入返回对象中
				obj.setString(pamArray[i], value);
			}
			
		}
		
		return obj;
	}
	
	/**
	 * 获取导入的数据
	 * @param filePath
	 * @return
	 * @throws IOException 
	 */
	@Bizlet("获取自定义导入的数据") 
    public static List<List<DataObject>> getUnderwriterExportListCustom(String filePath,String fileName,String customName) throws IOException {  
		List<List<DataObject>> allList = new ArrayList<List<DataObject>>();
        List<List<Object>> list = null;  
        msgList = new ArrayList<DataObject>();
        IMUODataContext muo = DataContextManager.current().getMUODataContext();
		IUserObject user=muo.getUserObject();
		//特殊主承模板导入，主承模板特殊解析
		list = ExcelHelper.exportListFromExcelUnderwriter(new File(filePath), 0);  //解析excel中的数据，返回list
		/*}else{
			list = ExcelHelper.exportListFromExcel(new File(filePath), 0);  //解析excel中的数据，返回list
		}*/
        if(list.size()<1){//空模板
        	initMsgError(0,"模板数据为空，请检查数据.");
        }
        //数据保存并基本校验
        List<DataObject> underwriterList = customCheckStockIssueValid(list,fileName,customName,user);
        countInfo(list,underwriterList);
        allList.add(underwriterList);
        allList.add(msgList);
        allList.add(attachInfoList);
        return allList;
    } 
	
	/**
	 * 自定义承销商信息导入校验
	 * @param list
	 * @return
	 */
	public static List<DataObject> customCheckStockIssueValid(List<List<Object>> list, String fileName,String customName,IUserObject user){
		//解析数据
		List<DataObject> underList = customInitData(list,fileName,customName,user);
		//判断重复
		List<DataObject> mergeList = checkUnderwriterMerge(underList);
		List<DataObject> trueList = checkUnderwriterListNotNullValid(underList);
		return trueList;
	}
	/**
	 * 自定义数据解析
	 * 
	 */
	public static List<DataObject> customInitData(List<List<Object>> list,String fileName,String customName,IUserObject user){
		Map<String,Object> map=JSONUtil.jsonToMap(customName);
		//判断导入人是否主承销商角色
		boolean isUnderwriter=false;
		String vcUnderwriterName="";
		if (user != null) {
			String vcUnderwriterId = user.getUserId();
			if(isJudgeRoleUnderwriter(vcUnderwriterId)==1){
				isUnderwriter=true;
				DataObject emp = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.CapUser");
				emp.setString("operatorId", vcUnderwriterId);
				DatabaseUtil.expandEntityByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, emp, emp);
				vcUnderwriterName=emp.getString("userName");
			}
		}
        List<DataObject> underwriterList = new ArrayList<DataObject>();
        DataObject underwriterStock = null;
        DataObject attachInfo = null;
        attachInfoList = new ArrayList<DataObject>();
		for(int j = 0; j < list.size(); j++){
        	//obj = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.stockissue.TAtsUnderwriterStockInfo");
        	List<Object> pam=list.get(j);
			//System.out.println(j);
			underwriterStock = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.stockissue.TAtsUnderwriterStockInfo");
			Date date = new Date();
	    	String ymd = DateUtil.format(date, "yyyyMMdd");
			for(int i=0 ;i<pamArray.length;i++){
				if(i==27){//材料网络下载链接,材料网络版更新时间 ,
					attachInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.TAtsAttachInfo");
					int vcAttachAddNumber=-1;
					if(map.get(pamArray[i])!=null && !"".equals(map.get(pamArray[i]))){
						vcAttachAddNumber=Integer.parseInt((String) map.get(pamArray[i]));
					}
					if(vcAttachAddNumber!=-1 && !"".equals(pam.get(vcAttachAddNumber))&&pam.get(vcAttachAddNumber)!=null){
						attachInfo.setString("vcAttachAdd", pam.get(vcAttachAddNumber).toString().trim());
					}
					int vcInfoNetUrlTime1=-1;
					if(map.get(pamArray[i])!=null && !"".equals(map.get(pamArray[i]))){
						vcInfoNetUrlTime1=Integer.parseInt((String) map.get("vcInfoNetUrlTime"));
					}
					if(vcInfoNetUrlTime1!=-1 && !"".equals(pam.get(vcInfoNetUrlTime1))&&pam.get(vcInfoNetUrlTime1)!=null){
						attachInfo.setString("vcAttachName", pam.get(vcInfoNetUrlTime1).toString().trim()+"_"+fileName);
					}else{
						attachInfo.setString("vcAttachName", ymd+"_"+fileName);
					}
					if(attachInfo.getString("vcAttachAdd")!=null){
						attachInfo.setString("vcAttachBizType","9");
						attachInfo.setString("vcAttachType","9");
						attachInfo.setString("vcAttachSize","DR"+j);
						attachInfoList.add(attachInfo);
					}
				}else if(i==29){//路演时间,调研纪要/路演纪要（若有） 下载链接
					attachInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.TAtsAttachInfo");
					int vcAttachAddNumber1=-1;
					if(map.get(pamArray[i])!=null && !"".equals(map.get(pamArray[i]))){
						vcAttachAddNumber1=Integer.parseInt((String) map.get(pamArray[i]));
					}
					if(vcAttachAddNumber1!=-1 && !"".equals(pam.get(vcAttachAddNumber1))&&pam.get(vcAttachAddNumber1)!=null){
						attachInfo.setString("vcAttachName", pam.get(vcAttachAddNumber1).toString().trim()+"_"+fileName);
					}else{
						attachInfo.setString("vcAttachName", ymd+"_"+fileName);
					}
					int vcSummaryTime1=-1;
					if(map.get(pamArray[i])!=null && !"".equals(map.get(pamArray[i]))){
						vcSummaryTime1=Integer.parseInt((String) map.get("vcSummaryUrl"));
					}
					if(vcSummaryTime1!=-1 && !"".equals(pam.get(vcSummaryTime1))&&pam.get(vcSummaryTime1)!=null){
						attachInfo.setString("vcAttachAdd", pam.get(vcSummaryTime1).toString().trim());
					}
					if(attachInfo.getString("vcAttachAdd")!=null){
						attachInfo.setString("vcAttachBizType","10");
						attachInfo.setString("vcAttachType","10");
						attachInfo.setString("vcAttachSize","DR"+j);
						attachInfoList.add(attachInfo);
					}
				}else{
					//登录人是主承销商角色的话，需要替换主承销商字段
					if(isUnderwriter && i==0){
						underwriterStock.setString(pamArray[i], vcUnderwriterName);
					}else{
						int number=-1;
						if(map.get(pamArray[i])!=null && !"".equals(map.get(pamArray[i]))){
							number=Integer.parseInt((String) map.get(pamArray[i]));
						}
						if(number!=-1 && !"".equals(pam.get(number))&&pam.get(number)!=null){
							underwriterStock.setString(pamArray[i], pam.get(number).toString().trim());
						}else{
							if("vcIssueAppraise".equals(pamArray[i]) || "vcBondAppraise".equals(pamArray[i])){
								String issueBond=(String) map.get("vcIssueBondAppraise")==null?(String) map.get("vcBondIssueAppraise"):(String) map.get("vcIssueBondAppraise");
								if(issueBond!=null && pam.get(Integer.parseInt(issueBond))!=null){
									number=Integer.parseInt(issueBond);
									if((String) map.get("vcIssueBondAppraise")!=null && "vcIssueAppraise".equals(pamArray[i])){
										String[] spl=pam.get(number).toString().trim().split("/");
										if(spl.length>2){
											underwriterStock.setString(pamArray[i], pam.get(number).toString().trim());
										}else{
											underwriterStock.setString(pamArray[i], spl[0]);
										}
									}else if((String) map.get("vcIssueBondAppraise")!=null && "vcBondAppraise".equals(pamArray[i])){
										String[] spl=pam.get(number).toString().trim().split("/");
											if(spl.length==2){
												underwriterStock.setString(pamArray[i], spl[1]);
											}else if(spl.length==1){
												underwriterStock.setString(pamArray[i], "");
											}else{
												underwriterStock.setString(pamArray[i], pam.get(number).toString().trim());
											}
								    	
									}else if((String) map.get("vcBondIssueAppraise")!=null && "vcBondAppraise".equals(pamArray[i])){
										String[] spl=pam.get(number).toString().trim().split("/");
										if(spl.length>2){
											underwriterStock.setString(pamArray[i], pam.get(number).toString().trim());
										}else{
											underwriterStock.setString(pamArray[i], spl[0]);
										}
									}else if((String) map.get("vcBondIssueAppraise")!=null && "vcIssueAppraise".equals(pamArray[i])){
										String[] spl=pam.get(number).toString().trim().split("/");
											if(spl.length==2){
												underwriterStock.setString(pamArray[i], spl[1]);
											}else if(spl.length==1){
												underwriterStock.setString(pamArray[i], "");
											}else{
												underwriterStock.setString(pamArray[i], pam.get(number).toString().trim());
											}
									}else{
										underwriterStock.setString(pamArray[i], pam.get(number).toString().trim());
									}
									
								}else{
									underwriterStock.setString(pamArray[i], "");
								}
							}else{
								underwriterStock.setString(pamArray[i], "");
							}
							
						}
					}
					underwriterStock.setString("checkMergeParam", "");
				}
			}
			underwriterList.add(underwriterStock);
        }
		return underwriterList;
	}

    
    @Bizlet("预发行数据刷新")
	public static boolean underwriterStockInfoRelease() {
    	SynCommonUtil.insertMsg("2", "开始新债预发行数据清洗", 0, "新债预发行数据清洗", "开始新债预发行数据清洗");
        boolean execute = true;
        boolean isSuccess = false;
        Connection conn_qjy = null;
        CallableStatement cStmt_qjy = null;
        System.out.println("[SP_SYNC_UNDERWRITER_MERGE]"+"开始执行存储过程SP_SYNC_UNDERWRITER_MERGE..");
        LogUtil.logInfo("[SP_SYNC_UNDERWRITER_MERGE]"+"开始执行存储过程SP_SYNC_UNDERWRITER_MERGE..", null, new Object[]{});
        while (execute) {
            conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
            try {
                String procedure = "{call SP_SYNC_UNDERWRITER_MERGE(?,?)}";
                cStmt_qjy = conn_qjy.prepareCall(procedure);
                cStmt_qjy.registerOutParameter(1, Types.INTEGER);
                cStmt_qjy.registerOutParameter(2, Types.INTEGER);
                cStmt_qjy.executeUpdate();
                int l_success = -1;
                isSuccess = true;
                l_success = cStmt_qjy.getInt(1);
                if (l_success != 0){
                    isSuccess = false;
                    execute = false;
                    LogUtil.logError("[SP_SYNC_UNDERWRITER_MERGE]"+"函数执行失败,新债预发行数据清洗出错!", null, new Object[]{});
                }
            } catch (Exception e) {
                e.printStackTrace();
                LogUtil.logError("[SP_SYNC_UNDERWRITER_MERGE]"+"函数执行失败,新债预发行数据清洗出错!", e, new Object[]{});
            }
            finally {
                JDBCUtil.releaseResource(conn_qjy, cStmt_qjy, null);
            }
            execute = false;
        }
        SynCommonUtil.insertMsg("2", "结束新债预发行数据清洗", 0, "新债预发行数据清洗", "结束新债预发行数据清洗");
        LogUtil.logInfo("[SP_SYNC_UNDERWRITER_MERGE]"+"结束执行存储过程SP_SYNC_UNDERWRITER_MERGE..", null, new Object[]{});
        System.out.println("[SP_SYNC_UNDERWRITER_MERGE]"+"结束执行存储过程SP_SYNC_UNDERWRITER_MERGE..");
        return isSuccess;
    }
}
