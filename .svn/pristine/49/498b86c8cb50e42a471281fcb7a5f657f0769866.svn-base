/**
 * 
 */
package com.cjhxfund.ats.fm.comm;

import java.util.HashMap;
import java.util.Map;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.api.BPSServiceClientFactory;
import com.eos.workflow.api.IBPSServiceClient;
import com.eos.workflow.api.IWFProcessInstManager;
import com.eos.workflow.api.IWFRelativeDataManager;
import com.eos.workflow.api.IWFWorkItemManager;
import com.eos.workflow.omservice.WFParticipant;
import com.primeton.workflow.api.WFServiceException;
import commonj.sdo.DataObject;

/**
 * @author chenpeng
 * @date 2017-01-19 14:08:31
 *
 */
@Bizlet("")
public class ProcessDeal {
	
	@Bizlet("查询员工信息")
	public static DataObject getEmpById(String userId){
		//查询用户信息
		DataObject user = DataObjectUtil.createDataObject("org.gocom.components.coframe.org.dataset.OrgEmployee");
		user.set("userid", userId);
		DatabaseUtil.expandEntityByTemplate("default", user, user);
		return user;
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
		//根据用户ID查询员工信息
		DataObject user = getEmpById(userId);
		
		//将当前的操作人员通知BPS引擎，用来进行权限控制
		BPSServiceClientFactory.getLoginManager().setCurrentUser(user.getString("empid"), user.getString("empname")); 
		//获取流程服务客户端
		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient(); 
		//实例化启动流程接口服务
		IWFProcessInstManager processInstManager = client.getProcessInstManager(); 
		//设置参与者到相关数据中
		Map map = new HashMap(); 
		WFParticipant relaData = new WFParticipant(user.getString("empid") , user.getString("empname") , "emp"); 
		map.put("startList", new WFParticipant[]{relaData}); //arr是相关数据中定义的数组 
		//com.primeton.eos.newflow.workflow是数据库已经存在的流程定义名称 
		long  processInstID = processInstManager.createAndStartProcInstAndSetRelativeData(processUrl, processInstName, prcoessInstDesc,transcationSpan,map);; 
		return processInstID;
	}
	
	/**
	 * 
	 * @param userId	//用户ID
	 * @param processInstID //流程ID
	 * @return 
	 * @throws WFServiceException
	 */
	@Bizlet("终止流程")
	public static boolean terminateProcessInstanceOfPrimary(String userId, long processInstID) throws WFServiceException{
		//根据用户ID查询员工信息
		DataObject user = getEmpById(userId);
		//将当前的操作人员通知BPS引擎，用来进行权限控制
		BPSServiceClientFactory.getLoginManager().setCurrentUser(user.getString("empid"), user.getString("empname")); 
		//获取流程服务客户端
		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient(); 
		//实例化流程接口服务
		IWFProcessInstManager processInstManager = client.getProcessInstManager(); 
		//设置相关数据
		Map<String, Object> map = new HashMap<String, Object> (); 
		WFParticipant relaData = new WFParticipant(user.getString("empid") , user.getString("empname") , "emp"); 
		map.put("startList", new WFParticipant[]{relaData}); //arr是相关数据中定义的数组 
		//com.primeton.eos.newflow.workflow是数据库已经存在的流程定义名称 
		 processInstManager.terminateProcessInstance(processInstID); 
		return true;
	}
	
	/**
	 * 设置相关数据值
	 * @param userId		      用户ID
	 * @param processInstID   流程ID
	 * @param relaData   相关数据值
	 * @param xpath   相关数据对象
	 * @throws WFServiceException
	 */
	@Bizlet("设置相关数据")
	public static void setRelativeData(String userId, long processInstID,Object relaData,String xpath) throws WFServiceException{
		//根据用户ID查询员工信息
		DataObject user = getEmpById(userId);
		//将当前的操作人员通知BPS引擎，用来进行权限控制
		BPSServiceClientFactory.getLoginManager().setCurrentUser(user.getString("empid"), user.getString("empname")); 
		//获取流程服务客户端
		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient(); 
		//实例化相关数据管理构建
		IWFRelativeDataManager relativeDataManager = client.getRelativeDataManager(); 
		//设置相关数据
		relativeDataManager.setRelativeData(processInstID,xpath,relaData); 
	}
	
	/**
	 * 完成工作项
	 * @param workitemId 工作项ID
	 */
	@Bizlet("完成工作项")
	public static void finishWorkItem(long workitemId, String userId){
		try {
			DataObject user = getEmpById(userId);
			//将当前的操作人员通知BPS引擎，用来进行权限控制
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
}
