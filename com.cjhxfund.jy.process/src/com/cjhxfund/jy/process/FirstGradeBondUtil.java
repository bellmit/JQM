/**
 * 
 */
package com.cjhxfund.jy.process;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.cjhxfund.commonUtil.JDBCUtil;
import com.eos.data.datacontext.IBaseDataContext;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.api.BPSServiceClientFactory;
import com.eos.workflow.api.IBPSServiceClient;
import com.eos.workflow.api.IWFActivityInstManager;
import com.eos.workflow.api.IWFBackActivityManager;
import com.eos.workflow.api.IWFCommonManager;
import com.eos.workflow.api.IWFProcessInstManager;
import com.eos.workflow.api.IWFRelativeDataManager;
import com.eos.workflow.api.IWFWorkItemManager;
import com.eos.workflow.omservice.WFParticipant;
import com.primeton.das.entity.impl.hibernate.mapping.IndexBackref;
import com.primeton.workflow.api.WFReasonableException;
import com.primeton.workflow.api.WFServiceException;

import commonj.sdo.DataObject;

/**
 * @author chenpeng
 * @date 2016-07-13 17:49:16
 *
 */
@Bizlet("")
public class FirstGradeBondUtil {

	/**
	 * 查询当前登录人处理过的业务ID 
	 * @param userId 登录人ID
	 * @return
	 */
	@Bizlet("查询当前登录人处理过的业务ID")
	public static String getUserIdById(String userId,String today){
		StringBuffer sb = new StringBuffer();
		String result = "";
		Connection conn = null;
		try {
			//获取默认连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			sb.append("select distinct t.process_inst_id from cf_jy_prc_aprv_info t where 1=1 ");
			if(StringUtils.isNotBlank(userId)){
				sb.append(" and t.user_code='").append(userId).append("' ");
			}
			//判断当天已办流程条件是否为空与是否等于true,等于时组装参数查询今天数据
			if(StringUtils.isNotBlank(today)){
				if(today.equals("true")){
					sb.append(" and to_char(t.create_time,'yyyy-MM-dd') = to_char(sysdate,'yyyy-MM-dd')");
				}
			}
			
			result = JDBCUtil.getListValueBySql(conn, sb.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	/**
	 * 查询用过印的流程ID
	 * @param userId 用户ID
	 * @return
	 */
	@Bizlet("查询用过印的业务Id")
	public static String getIndiaById(String userId,String today){
		StringBuffer sb = new StringBuffer();
		String result = "";
		Connection conn = null;
		try {
			//获取默认连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			sb.append("select distinct t.process_inst_id from cf_jy_attach_info t where t.whetherindia = '1'");
			/*if(StringUtils.isNotBlank(userId)){
				sb.append(" and t.user_id='").append(userId).append("' ");
			}*/
			if(StringUtils.isNotBlank(today)){
				if(today.equals("true")){
					sb.append(" and to_char(t.create_time,'yyyy-MM-dd') = to_char(sysdate,'yyyy-MM-dd')");
				}
			}
			
			result = JDBCUtil.getListValueBySql(conn, sb.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	
	/**
	 * 获取今天已处理过流程ID
	 * @return
	 */
	@Bizlet("获取今天已处理过流程ID")
	public static String getTodayById(){
		StringBuffer sb = new StringBuffer();
		String result = "";
		Connection conn = null;
		try {
			//获取默认连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			sb.append("select distinct  w.processinstid from wfworkitem w where to_char(w.endtime,'yyyy-MM-dd') = to_char(sysdate,'yyyy-mm-dd')");

			result = JDBCUtil.getListValueBySql(conn, sb.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	
	/**
	 * 当前时间加上随机5-10之间的秒数
	 * @param dateTime  当前时间
	 * @return
	 * @throws Exception
	 */
	@Bizlet("组装需要修改的时间")
	public static String assembleDateTime(Date dateTime,String activityDefID) throws Exception{
		//随机生成的5-10之间秒数
		int randomNumber = (int)(Math.random() * 6 + 12); 
		
		if(activityDefID.equals("ATS_FM_FGLDSH")){
			Thread.sleep(1*1000);
			randomNumber = randomNumber + (int)(Math.random() * 6 + 12);
		}else if(activityDefID.equals("FirstGradeBond_KZJ_RGSH") || activityDefID.equals("manualActivity16")){
			Thread.sleep(1*1000);
			randomNumber = randomNumber + (int)(Math.random() * 6 + 24);
		}
		//实例化日期处理类
		Calendar calendar = Calendar.getInstance();  
        calendar.setTime(dateTime);
      //设置秒数加上随机生成的5-10之间秒数
        calendar.add(Calendar.SECOND, randomNumber);  
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTime());
	}
	
	/**
	 * 校验接口传递的数据
	 * @param objs 接口数据
	 * @return 反馈状态
	 */
	@Bizlet("")
	public static String[] interDataValidation(DataObject objs){
		String returnCode = "";
		String returnValue = "";
		
		//判断必填项业务日期是否为空
		if(objs.getString("processDate").equals("")){
			returnCode = "1";
			returnValue = "业务日期不能为空";
		} else if(objs.getString("combProductCode").equals("")){ //判断必填产品编码是否为空
			returnCode = "1";
			returnValue = "产品编码不能为空";
		} else if(objs.getString("combProductName").equals("")){ //判断必填产品名称是否为空
			returnCode = "1";
			returnValue = "产品名称不能为空";
		} else if(objs.getString("investProductName").equals("")){ //判断必填项债券名称是否为空
			returnCode = "1";
			returnValue = "债券名称不能为空";
		} else if(objs.getString("investcount").equals("")){ //判断必填项投标金额是否为空
			returnCode = "1";
			returnValue = "投标金额不能为空";
		} else if(objs.getString("interestrate").equals("")){ //判断必填项投标利率是否为空
			returnCode = "1";
			returnValue = "投标利率不能为空";
		} else if(objs.getString("investcategory").equals("")){ //判断必填项债券种类是否为空
			returnCode = "1";
			returnValue = "债券种类不能为空";
		} else if(objs.getString("categorydate").equals("")){ //判断必填项债券期限是否为空
			returnCode = "1";
			returnValue = "债券期限不能为空";
		} /*else if(objs.getString("resaleRight").equals("1")){ //判断是否具有回售权是 1-是时
			//判断回售行权年是否为空
			if(objs.getString("resaleYear") != ""){
				returnCode = "0";
			}else{
				returnCode = "1";
				returnValue = "当是否具有回售权为是时，回售行权年值不能为空。";
			}
		} else if(objs.getString("redemptionRight").equals("1")){ //判断是否具有赎回权选项值是否为"是"
			if(objs.getString("redemptionYear") != ""){
				returnCode = "0";
			}else{
				returnCode = "1";
				returnValue = "当是否具有赎回权值为是时,赎回行权年值不能为空。";
			}
		}else if(objs.getString("associationBetween").equals("1")){ //判断是否关联交易为是时
			if(objs.getString("associationRemark") != ""){
				returnCode = "0";
			}else{
				returnCode = "1";
				returnValue = "当是否关联交易值为是时,关联交易备注值不能为空。";
			}
		}*/
		
		String[] objArr = new String[2];
		objArr[0] = returnCode;
		objArr[1] = returnValue;
		return objArr;
	}
	
	/**
	 * 
	 * @param userId		   //用户ID
	 * @param processUrl	   //流程定义名称
	 * @param processInstName  //流程实例名称
	 * @param prcoessInstDesc  //流程实例描述
	 * @param transcationSpan  //是否事务分割,true支持，false不支持 
	 * @return	流程实例ID
	 * @throws WFServiceException
	 */
	@Bizlet("")
	public static long createAndStartProcInstAndSetRelativeData(String userId,String processUrl,String processInstName,String prcoessInstDesc,boolean transcationSpan) throws WFServiceException{
		//查询用户信息
		DataObject user = DataObjectUtil.createDataObject("org.gocom.components.coframe.org.dataset.OrgEmployee");
		user.set("userid", userId);
		DatabaseUtil.expandEntityByTemplate("default", user, user);
		
		BPSServiceClientFactory.getLoginManager().setCurrentUser(user.getString("empid"), user.getString("empname")); 
		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient(); 
		IWFProcessInstManager processInstManager = client.getProcessInstManager(); 
		Map<String,Object> map = new HashMap<String,Object>(); 
		WFParticipant relaData = new WFParticipant(user.getString("empid") , user.getString("empname") , "emp"); 
		map.put("startList", new WFParticipant[]{relaData}); //arr是相关数据中定义的数组 
		//com.primeton.eos.newflow.workflow是数据库已经存在的流程定义名称 
		long  processInstID = processInstManager.createAndStartProcInstAndSetRelativeData(processUrl, processInstName, prcoessInstDesc,transcationSpan,map);; 
		return processInstID;
	}
	
	@Bizlet("终止流程")
	public static boolean terminateProcessInstanceOfPrimary(String userId, long processInstID) throws WFServiceException{
		//查询用户信息
		DataObject user = DataObjectUtil.createDataObject("org.gocom.components.coframe.org.dataset.OrgEmployee");
		user.set("userid", userId);
		DatabaseUtil.expandEntityByTemplate("default", user, user);
		
		BPSServiceClientFactory.getLoginManager().setCurrentUser(user.getString("empid"), user.getString("empname")); 
		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient(); 
		IWFProcessInstManager processInstManager = client.getProcessInstManager(); 
		Map<String, Object> map = new HashMap<String, Object> (); 
		WFParticipant relaData = new WFParticipant(user.getString("empid") , user.getString("empname") , "emp"); 
		map.put("startList", new WFParticipant[]{relaData}); //arr是相关数据中定义的数组 
		//com.primeton.eos.newflow.workflow是数据库已经存在的流程定义名称 
		 processInstManager.terminateProcessInstance(processInstID); 
		return true;
	}
	
	/**
	 * 设置相关数据值
	 * @param userId		       用户ID
	 * @param processInstID   流程ID
	 * @param relaData   相关数据值
	 * @param xpath   相关数据对象
	 * @throws WFServiceException
	 */
	@Bizlet("设置相关数据")
	public static void setRelativeData(String userId, long processInstID,Object relaData,String xpath) throws WFServiceException{
		//查询用户信息
		DataObject user = DataObjectUtil.createDataObject("org.gocom.components.coframe.org.dataset.OrgEmployee");
		user.set("userid", userId);
		DatabaseUtil.expandEntityByTemplate("default", user, user);
		
		BPSServiceClientFactory.getLoginManager().setCurrentUser(user.getString("empid"), user.getString("empname")); 
		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient(); 
		//RelativeDataManagerService
		IWFRelativeDataManager relativeDataManager = client.getRelativeDataManager(); 
		//com.primeton.eos.newflow.workflow是数据库已经存在的流程定义名称 
		relativeDataManager.setRelativeData(processInstID,xpath,relaData); 
	}
	
	/**
	 * 完成工作项
	 * @param workitemId 工作项ID
	 */
	@Bizlet("")
	public static void finishWorkItem(long workitemId, DataObject user){
		try {
			BPSServiceClientFactory.getLoginManager().setCurrentUser(user.getString("empid"), user.getString("empname")); 
			//创建BPS流程引擎实例
			IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient();
			//创建工作项管理构建实例
			IWFWorkItemManager workitemManager = client.getWorkItemManager();
			//调用完成工作项方法
			workitemManager.finishWorkItem(workitemId, false);
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 * @param userId	用户ID
	 * @param currentActInstID  当前活动实例ID 
	 * @param destActInstID		目标活动定义ID 
	 * @param rollBackStrategy	回退策略
	 * 回退策略的取值有：time、path、recent_manual、one_step或simple： 
	 * 	time为基于两点间的时间回退
	 *	path为基于两点间的路径回退
	 *	recent_manual为回退到最近的人工活动
	 *	one_step为单步回退
	 *	simple为简单回退
	 */
	@Bizlet("回退")
	public static void backActivity(String userId,long currentActInstID,String destActInstID,String rollBackStrategy){
		try{
		//查询用户信息
		DataObject user = DataObjectUtil.createDataObject("org.gocom.components.coframe.org.dataset.OrgEmployee");
		user.set("userid", userId);
		DatabaseUtil.expandEntityByTemplate("default", user, user);
				
		BPSServiceClientFactory.getLoginManager().setCurrentUser(user.getString("empid"), user.getString("empname")); 
		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient(); 
		IWFBackActivityManager instmanager = client.getBackActivityManager();
		instmanager.backActivity(currentActInstID, destActInstID, rollBackStrategy);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	@Bizlet("")
	public static int JudgeProcessState(String activityDefID,String operateType){
		int processState = 0;
		if(activityDefID.equals("manualActivity")){   //投标指令下达
			processState = 4;
		}else if(activityDefID.equals("manualActivity4")){ //投顾复核
			processState = 8;
		}else if(activityDefID.equals("manualActivity1")){ //信息核对(交易员1)
			processState = 12;
		}else if(activityDefID.equals("manualActivity2")){ //信息核对(交易员2)
			processState = 16;
		}else if(activityDefID.equals("FirstGradeBond_FKZZ_TZJLQR")){ //投资经理确认
			processState = 20;
		}else if(activityDefID.equals("ATS_FM_ZJZLSH")){  //总监助理审核
			processState = 24;
		}else if(activityDefID.equals("ATS_FM_ZXZJSH")){  //执行总监审核
			processState = 28;
		}else if(activityDefID.equals("ATS_FM_FGLDSH")){  //分管领导审核
			processState = 32;
		}else if(activityDefID.equals("manualActivity16")){ //人工审核特批交易
			processState = 36;
		}else if(activityDefID.equals("manualActivity5")){ //报价修改
			processState = 40;
		}else if(activityDefID.equals("manualActivity15")){ //报价修改后人工审核特批交易
			processState = 44;
		}else if(activityDefID.equals("FirstGradeBond_FKZZ_TGFH")){ //报价修改后投顾复核
			processState = 48;
		}else if(activityDefID.equals("manualActivity6")){  //修改执行(交易员1)
			processState = 52;
		}else if(activityDefID.equals("manualActivity7")){  //修改执行(交易员2)
			processState = 56;
		}else if(activityDefID.equals("FirstGradeBond_FKZZ_TZJLQR1")){  //投资经理确认
			processState = 60;
		}else if(activityDefID.equals("manualActivity8")){  //投标用印
			processState = 64;
		}else if(activityDefID.equals("manualActivity3")){  //传真
			processState = 68;
		}else if(activityDefID.equals("manualActivity9")){  //中标确认
			//判断操作类型是否是中标确认环节完成，返回不同状态值
			if( operateType != null && operateType.equals("bidConfirm")){
				processState = 72;
			}else{
				processState = 70;
			}
			
		}else if(activityDefID.equals("manualActivity10")){ //中标复核
			processState = 76;
		}else if(activityDefID.equals("manualActivity12")){ //协议用印
			processState = 80;
		}else if(activityDefID.equals("manualActivity14")){ //缴款执行
			processState = 84;
		}else{
			if(operateType.equals("Abandoned")){  //流程废弃
				processState = 2;
			}
		}
		return processState;
	}
	
	/**
	 * @param 
	 * @return
	 * @author 陈鹏
	 */
	@Bizlet("根据userId组装参与者集合")
	public static List<WFParticipant> getByIdEmpList(String userId,String empCode) {
		// TODO 自动生成的方法存根
		List<WFParticipant> participants = new ArrayList<WFParticipant>();

		WFParticipant ipant = new WFParticipant();
		//查询用户信息
		DataObject user = DataObjectUtil
				.createDataObject("org.gocom.components.coframe.org.dataset.OrgEmployee");
		if(empCode != null && empCode != ""){
			user.set("empcode", empCode);
		}else{
			user.set("empid", userId);
		}
		DatabaseUtil.expandEntityByTemplate("default", user, user);
		
		ipant.setId(user.getString("empid"));
		ipant.setName(user.getString("empname"));
		ipant.setTypeCode("emp");
		participants.add(ipant);

		return participants;
	}

	
	
	public static void main(String[] args) {
		Calendar calendar = Calendar.getInstance();
        Date date = new Date(System.currentTimeMillis());
        calendar.setTime(date);
//        calendar.add(Calendar.WEEK_OF_YEAR, -1);
        calendar.add(Calendar.YEAR, -1);
        date = calendar.getTime();
        System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date));
	}
	
}
