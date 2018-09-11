package com.cjhxfund.ats.ipo;


import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.dom4j.DocumentException;

import com.cjhxfund.commonUtil.DateUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.api.BPSServiceClientFactory;
import com.eos.workflow.api.IBPSServiceClient;
import com.eos.workflow.api.IWFActivityInstManager;
import com.eos.workflow.api.IWFDefinitionQueryManager;
import com.eos.workflow.api.IWFWorkItemManager;
import com.eos.workflow.data.WFActivityInst;
import com.eos.workflow.data.WFWorkItem;
import com.primeton.ext.engine.component.LogicComponentFactory;
import com.primeton.workflow.api.WFServiceException;

import commonj.sdo.DataObject;

@Bizlet("流程自动处理业务类")
public class AutoOperator {
	
	private static Object lock = new Object();
	
	@Bizlet("投顾自动完成工作项")
	public static String autoFinishWorkItem(DataObject wi){
		String retVal = "00";
		BPSServiceClientFactory.getLoginManager().setCurrentUser(wi.getString("participant"), wi.getString("partiName"));
		try {
			
			IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient();
			IWFWorkItemManager workItemMananger = client.getWorkItemManager();
			synchronized (lock) {
				if(wi.getInt("currentState")==10){
					retVal = "01";
					workItemMananger.finishWorkItem(wi.getLong("workItemID"), false);
					Thread.sleep(1000);
					System.out.println("new Date():"+new Date());
				}
			}
			
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		} 
		return retVal;
	}
	
	@Bizlet("激活自动活动")
	public static void activateAutoActivity(long processInstID) throws WFServiceException{
		BPSServiceClientFactory.getLoginManager().setCurrentUser("1", "sysadmin");
		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient();
		//活动实例管理对象
		IWFActivityInstManager actInstMsg = client.getActivityInstManager();
		//查询自动活动的活动实体
		WFActivityInst actInst=actInstMsg.findLastActivityInstByActivityID(processInstID, "autoActivity");
		//激活自动环节
		if(actInst.getCurrentState()==10){
			actInstMsg.activateActivityInstance(actInst.getActivityInstID());
		}
		
	}
	
	@Bizlet("查询所有投顾的工作项对象")
	public static DataObject[] queryWorkItemByActID(long processInstID) throws WFServiceException{
		BPSServiceClientFactory.getLoginManager().setCurrentUser("1", "sysadmin");
		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient();
		//活动实例管理对象
		IWFActivityInstManager actInstMsg = client.getActivityInstManager();
		//工作项管理对象
		IWFWorkItemManager workItemMananger = client.getWorkItemManager();
		//获取投顾环节的活动实例
		WFActivityInst actInst=actInstMsg.findLastActivityInstByActivityID(processInstID, "manualActivity1");
		//查询投顾环节活动实例下的所有工作项
		/*List<WFWorkItem> workList=workItemMananger.queryWorkItemsByActivityInstID(actInst.getActivityInstID(), null);
		if(workList!=null && workList.size()>0){
			for(int i=0;i<workList.size();i++){
				if(workList.get(i).getCurrentState()==12){
					workList.remove(i);
				}
			}
		}*/
		
		DataObject[] workItems=workItemMananger.queryWorkItemsByActivityInstID4SDO(actInst.getActivityInstID(), null);
		return workItems;
	}
	
	/**
	 * 查询后续环节是否需要自动完成
	 * @param actInst 当前环节活动实例
	 * @return 返回所有后续环节的工作项
	 * @throws Throwable 
	 */
	public void autoFinshMyWork(WFWorkItem wi) throws Throwable{
		//AutoOperator autoOperator=new AutoOperator();
		//List<WFWorkItem> workList=autoOperator.queryWorksByActvityInstID(actInst);
		String bizComponent="com.cjhxfund.ats.ipo.task";
		String bizName="autoAddApprove";
		//创建自动添加审批信息的逻辑流
		ILogicComponent logicComponent = LogicComponentFactory.create(bizComponent);
		//调用逻辑流需要的参数
		Object[] params = new Object[1];
		String participatID=wi.getParticipant();
		String participantName=wi.getPartiName();
		//工作项的多个参与者的存储方式是1002|2003|1005,对应的名称是 小明|小五|小王
		String[] partIds=participatID.split("\\|");
		
		if(partIds.length>1){
			String[] partNames=participantName.split("\\|");
			//随机取一个数，去取其中任一个人
			Random random = new Random();
			int i=random.nextInt(partIds.length);
			participatID=partIds[i];
			participantName=partNames[i];
		}
		BPSServiceClientFactory.getLoginManager().setCurrentUser(participatID, participantName);

		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient();
		//工作项管理对象
		IWFWorkItemManager workItemMananger = client.getWorkItemManager();
		IWFDefinitionQueryManager defMsg=client.getDefinitionQueryManager();
		String extStr=defMsg.getExtendAttribute(wi.getProcessDefID(),wi.getActivityDefID());
		//将扩展配置信息解析出对应的值
		Map<String,String> extMap=FlowExtendUtil.getBackInfo(extStr);
		if(extMap!=null){
			//获取配置的自动完成的key
			String autoFinish=extMap.get("autoFinish");
			if(autoFinish!=null && !"".equals(autoFinish)){
				//判断是否需要自动完成
				if("true".equals(autoFinish)){
					if(wi.getCurrentState()==10){
						System.out.println("participant="+wi.getPartiName());
						synchronized (this) {
							Thread.sleep(5000);
							//完成当前工作项
							workItemMananger.finishWorkItem(wi.getWorkItemID(), false);
							//调用自动添加审批信息参数（是工作项对象）
							params[0]=wi;
							//调用自动添加审批表
							logicComponent.invoke(bizName, params);
							System.out.println("new Date="+new Date());
						}
					}
				}
			}
		}
		System.out.println("new Date():"+new Date());
		
	}
	
	
	
	
	/**
	 * 根据当前活动实例对象，查询当前活动下所有的工作项列表
	 * @param actInst 当前所在环节的活动实例对象
	 * @return 返回所有工作项列表
	 * @throws WFServiceException
	 */
	@Bizlet("查询工作项列表")
	public  List<WFWorkItem> queryWorksByActvityInstID(WFActivityInst actInst){
		BPSServiceClientFactory.getLoginManager().setCurrentUser("1", "sysadmin");
		//查询当前活动下的所有工作项列表
		List<WFWorkItem> workList=null;
		try {
			IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient();
			//工作项管理对象
			IWFWorkItemManager workMsg = client.getWorkItemManager();
			workList = workMsg.queryWorkItemsByActivityInstID(actInst.getActivityInstID(), null);
		} catch (WFServiceException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return workList;
		
	}
	
	/**
	 * 查询活动实例下的所有工作项
	 * @param actInst 当前活动实例对象
	 * @return 返回工作项数组，类型为 DataObject 数组
	 * @throws WFServiceException
	 */
	@Bizlet("查询工作项列表")
	public static DataObject[] queryWorksByActInstID(WFActivityInst actInst) throws WFServiceException{
		BPSServiceClientFactory.getLoginManager().setCurrentUser("1", "sysadmin");
		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient();
		//工作项管理对象
		IWFWorkItemManager workMsg = client.getWorkItemManager();
		//查询活动实例下的所有工作项返回结果为DataObject数组
		DataObject[] myWorks=workMsg.queryWorkItemsByActivityInstID4SDO(actInst.getActivityInstID(), null);
		return myWorks;
	}
	
	/**
	 * 获取活动环节的扩展配置内容
	 * @param wi
	 * @return
	 * @throws WFServiceException
	 * @throws DocumentException
	 */
	@Bizlet("获取当前活动类型")
	public static Map<String,String> getActType(WFWorkItem wi) throws WFServiceException, DocumentException{
		BPSServiceClientFactory.getLoginManager().setCurrentUser(wi.getParticipant(), wi.getPartiName());
		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient();
		IWFDefinitionQueryManager defMsg=client.getDefinitionQueryManager();
		String extStr=defMsg.getExtendAttribute(wi.getProcessDefID(),wi.getActivityDefID());
		//将扩展配置信息解析出对应的值
		Map<String,String> extMap=FlowExtendUtil.getBackInfo(extStr);
		return extMap;
	}
	
	/**
	 * 获取邮件标题
	 * @param wi
	 * @return
	 * @throws WFServiceException
	 * @throws DocumentException
	 */
	@Bizlet("获取当前活动类型")
	public static String getMailTitle(WFWorkItem wi) throws WFServiceException, DocumentException{
		BPSServiceClientFactory.getLoginManager().setCurrentUser(wi.getParticipant(), wi.getPartiName());

		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient();
		//工作项管理对象
//		IWFWorkItemManager workItemMananger = client.getWorkItemManager();
		IWFDefinitionQueryManager defMsg=client.getDefinitionQueryManager();
		String extStr=defMsg.getExtendAttribute(wi.getProcessDefID(),wi.getActivityDefID());
		//将扩展配置信息解析出对应的值
		Map<String,String> extMap=FlowExtendUtil.getBackInfo(extStr);
		String mailTitle=extMap.get("mailTitle");
		return mailTitle;
	}
	
	
	@Bizlet("获取时间")
	public static String getCreateDate(String createDate){
		String resultDate=null;
		if(createDate!=null && !"".equals(createDate)){
			resultDate=createDate.substring(0,4)+"-"+createDate.substring(4,6)+"-"+createDate.substring(6,8);
		}
		return resultDate;
	}
	
	/**
	 * 从实体名称中截取新股的申购代码
	 * @param instName 申购代码-发行人-网下申购-创建日期
	 * @return 返回第一个申购代码
	 */
	@Bizlet("获取申购代码")
	public static String getPurchaseCode(String instName){
		String vcPurchaseCode=null;
		if(instName!=null && !"".equals(instName)){
			String[] instStrs=instName.split("-");
			vcPurchaseCode=instStrs[0];
		}
		return vcPurchaseCode;
	}
	
	/**
	 * 主要用于投顾当日12点自动完成工作项
	 * 计算工作项创建到12点之间的时间
	 * @param startTime 传入工作项的创建时间
	 * @return 计算后的时间
	 */
	@Bizlet("计算超时时间")
	public static String setTimeOutNum(String dateStr){
		String remindTime=null;
		Date date=null;
		if(dateStr!=null && !"".equals(dateStr)){
			date=DateUtil.parse(dateStr, "yyyyMMddHHmmss");
		}else{
			date=new Date();
		}
		if(date!=null){
			int hours=DateUtil.getHour(date);
			int minutes=DateUtil.getMinute(date);
			int timeHour=11-hours;
			int timeMinute=60-minutes;
			if(timeHour<0){
				timeHour=0;
				timeMinute=3;
			}
			remindTime=String.valueOf(timeHour)+"."+String.valueOf(timeMinute);
		}
		return remindTime;
	}
	
	
	public static void main(String[] args) {
		//随机取一个数，去取
		Random random = new Random();
		int i=random.nextInt(5-1);
		for(int j=0;j<10;j++){
			int m=random.nextInt(4-1);
			System.out.println(m);
		}
	}
	
}
