package com.cjhxfund.fpm.bpsExpend;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.api.IWFRelativeDataManager;
import com.eos.workflow.api.IWFWorkItemManager;
import com.eos.workflow.api.IWFWorklistQueryManager;
import com.eos.workflow.data.WFWorkItem;
import com.eos.workflow.omservice.WFParticipant;
import com.primeton.workflow.api.WFReasonableException;
import com.primeton.workflow.api.WFServiceException;

import commonj.sdo.DataObject;

/**
 * 服务调用工具类
 * 
 * @author zengjing
 * @Modified by Alaric Liu
 * @Modify Date : 2017-04-20
 * @Desc : Using NamingSql replace Api-Query.
 */
@Bizlet("ServiceUtil")
public class TaskServiceUtil {
	
	/*
	 * Modified by Alaric Liu
	 * Desc : modify from using bps api to using namesql
	 * */
	@Bizlet("queryTaskList")
	public static DataObject[] queryTaskList(DataObject pagecond, String taskType,Map<String,String> criteriaMap) throws WFServiceException {
		DataObject[] taskList = null;
		Object[] objects = null;
		if ("todoTask".equals(taskType)) {//待办任务
				objects = DatabaseExt.queryByNamedSqlWithPage("default", "com.cjhxfund.fpm.bpsExpend.task.queryTaskList",pagecond, criteriaMap);
				taskList = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsExpend.task.Task", true);
		}else if ("runningProcess".equals(taskType)) {//流转中任务
				objects = DatabaseExt.queryByNamedSqlWithPage("default", "com.cjhxfund.fpm.bpsExpend.task.queryRunningTaskList", pagecond, criteriaMap);
				taskList = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsExpend.task.ProcessInst", true);
				setProcessInfo(taskList);
		}else if ("finishedProcess".equals(taskType)) {//已完成
				objects = DatabaseExt.queryByNamedSqlWithPage("default", "com.cjhxfund.fpm.bpsExpend.task.queryFinishTaskList",pagecond, criteriaMap);
				taskList = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsExpend.task.ProcessInst", true);
		}else if ("unViewNotice".equals(taskType)) {//待阅
				objects = DatabaseExt.queryByNamedSqlWithPage("default", "com.cjhxfund.fpm.bpsExpend.task.getUnviewedNotice", pagecond, criteriaMap);
				taskList = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsExpend.task.Task", true);
		}else if ("viewedNotice".equals(taskType)) {//已阅
				objects = DatabaseExt.queryByNamedSqlWithPage("default", "com.cjhxfund.fpm.bpsExpend.task.getViewedNotice", pagecond, criteriaMap);
				taskList = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsExpend.task.Task", true);
		}else{
			taskList = new DataObject[0];
		}	
		
		return taskList;
	}

	/**
	 * 查询任务数量
	 * @param taskType
	 * @param criteriaMap
	 * @return
	 * @throws WFServiceException
	 */
	@Bizlet("queryTaskListNum")
	public static int queryTaskListNum(String taskType,Map<String,String> criteriaMap) throws WFServiceException {
		int i = 0;
		if ("todoTask".equals(taskType)) {//待办任务
				i = DatabaseExt.countByNamedSql("default", "com.cjhxfund.fpm.bpsExpend.taskCount.queryTaskListCount", criteriaMap);
		}else if ("runningProcess".equals(taskType)) {//流转中任务
			i = DatabaseExt.countByNamedSql("default", "com.cjhxfund.fpm.bpsExpend.taskCount.queryRunningTaskListCount", criteriaMap);
		}else if ("finishedProcess".equals(taskType)) {//已完成
			i = DatabaseExt.countByNamedSql("default", "com.cjhxfund.fpm.bpsExpend.taskCount.queryFinishTaskListCount", criteriaMap);
		}else if ("unViewNotice".equals(taskType)) {//待阅
			i = DatabaseExt.countByNamedSql("default", "com.cjhxfund.fpm.bpsExpend.taskCount.getUnviewedNoticeCount", criteriaMap);
		}else if ("viewedNotice".equals(taskType)) {//已阅
			i = DatabaseExt.countByNamedSql("default", "com.cjhxfund.fpm.bpsExpend.taskCount.getViewedNoticeCount", criteriaMap);
		}else{
		}	
		
		return i;
	}	
	/**
	 * 查询流程想关信息并回写
	 * @param tasklist
	 */
	private static void setProcessInfo(DataObject[] tasklist) {
		Map<String, String> parameterMap=new HashMap<String, String>();
		String processInstStr = "";
		for (DataObject dataObject : tasklist) {
			processInstStr += dataObject.getString("processinstid")+",";
		}
		if(processInstStr.length()>0){
			processInstStr = processInstStr.substring(0,processInstStr.length()-1);
		}
		if(!processInstStr.equals("")){
			parameterMap.put("processinstid", processInstStr);
			Object[] objects = DatabaseExt.queryByNamedSql("default", "com.cjhxfund.fpm.bpsExpend.processUtil.getRunningProcessInfo", parameterMap);
			DataObject[] dataObjects = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsExpend.task.ProcessInst", true);
			
			for (DataObject dataObject : tasklist) {
				DataObject processInfo = getProcessInfo(dataObjects,dataObject.getString("processinstid"));
				if(processInfo!=null){
					dataObject.set("activityinstname", processInfo.getString("activityinstname"));
					dataObject.set("participantname", processInfo.getString("participantname"));
				}
			}
		}
	}
	
	/**
	 * 从查询出的流行信息数组中，获取流程信息
	 * @param dataObjects
	 * @param processInstID
	 * @return
	 */
	private static DataObject getProcessInfo(DataObject[] dataObjects,String processInstID) {
		DataObject processInfo = null;
		for (DataObject dataObject : dataObjects) {
			if(dataObject.getString("processinstid").equals(processInstID)||dataObject.getString("ROOTPROCINSTID").equals(processInstID)){
				processInfo = dataObject;
				break;
			}
		}	
		return processInfo;
	}
	/**
	 * 
	 * @param list
	 * @param pagecond
	 * @return
	 */
	public static DataObject[] myPageCond(DataObject[] list,DataObject pagecond,String DataEntity) {
		int count=list.length;
		int length=pagecond.getInt("length");
		int totalPage=(int)Math.ceil((double)count/length);
		int begin=pagecond.getInt("begin");
		int currentPage=0;
		if(begin==0){
			currentPage=1;
		}else{
			currentPage=begin/length+1;
		}
		int end=currentPage*length;
		if (end>count)
			end=count;
		List<DataObject> resultList=new ArrayList<DataObject>();;
		for(int i=begin;i<end;i++){
			resultList.add(list[i]);
		}
		if(currentPage==1){
			pagecond.set("isFirst", true);
			pagecond.set("isLast", false);
		}else if (currentPage==totalPage){
			pagecond.set("isFirst",false);
			pagecond.set("isLast", true);
		}
		pagecond.set("count", count);
		pagecond.set("totalPage", totalPage);
		pagecond.set("currentPage", currentPage);
		DataObject[] result=DataObjectUtil.convertDataObjects(resultList, "com.cjhxfund.fpm.bpsExpend.task.ProcessInst", true);
		return result;
	}
	
	/**
	 * 取工作项的最新的完成时间
	 * @param workitemId
	 * @return
	 * @throws Exception
	 */
	@Bizlet("getLastProcessFinishTime")
	public static Date getLastProcessFinishTime(String processInstId){	
		Date finishDate = null;
		Object[] objects = null;
		Map<String, String> parameterMap=new HashMap<String, String>();
		parameterMap.put("processInstId", processInstId);
		try{
			objects = DatabaseExt.queryByNamedSql("default", "com.cjhxfund.fpm.bpsExpend.processUtil.getLastProcessFinishTime", parameterMap);
			finishDate = (Date) objects[0];
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return finishDate;
	}
	

	
	@Bizlet("executeWorkItem")
	public static void executeWorkItem(long workItemID, String submitType, 
			String personID, String reason, DataObject[] participants, long processInstID, Map<String, Object> workItemFormData) throws WFServiceException, WFReasonableException {
		if ("get".equals(submitType)) {//领取
			ServiceFactory.getWFWorkItemManager().assignWorkItemToSelf(workItemID);
		} else if ("cancelGet".equals(submitType)) {//取消领取
			ServiceFactory.getWFWorkItemManager().withdrawWorkItem(workItemID);
		} else if ("delegate".equals(submitType)) {
			ServiceFactory.getWFDelegateManager().delegateWorkItem4SDO(workItemID, participants, "DELEG");
			ServiceFactory.getWFProcessLogManager().addProcessLog4SDO(workItemID, "代办", personID, reason, null);
		} else if ("help".equals(submitType)) {
			ServiceFactory.getWFDelegateManager().delegateWorkItem4SDO(workItemID, participants, "HELP");
			ServiceFactory.getWFProcessLogManager().addProcessLog4SDO(workItemID, "协办", personID, reason, null);
		} else if ("redo".equals(submitType)) {
			ServiceFactory.getWFDelegateManager().redoDelegatedWorkItem(workItemID);
			ServiceFactory.getWFProcessLogManager().addProcessLog4SDO(workItemID, "重做", personID, reason, null);
		} else if ("reject".equals(submitType)) {
			ServiceFactory.getWFDelegateManager().rejectDelegatedWorkItem(workItemID);
			ServiceFactory.getWFProcessLogManager().addProcessLog4SDO(workItemID, "拒绝", personID, reason, null);
		} else if ("withdraw".equals(submitType)) {
			ServiceFactory.getWFDelegateManager().withdrawDelegatedWorkItem(workItemID);
			ServiceFactory.getWFProcessLogManager().addProcessLog4SDO(workItemID, "收回", personID, reason, null);
		} else {
			if ("save".equals(submitType)) {
				//保存工作项
				if (workItemFormData != null && workItemFormData.size() > 0) {
					IWFRelativeDataManager relativeDataManager = ServiceFactory.getWFRelativeDataManager();
					relativeDataManager.setRelativeDataBatch(processInstID, workItemFormData);
				}
			} else {
				IWFWorkItemManager workItemManager = ServiceFactory.getWFWorkItemManager();
	
				//如果自动表单不为空：保存相关数据，完成工作项
				if (workItemFormData != null && workItemFormData.size() > 0) {
					workItemManager.finishWorkItemWithRelativeData(workItemID, workItemFormData, false);				
				} else { // 完成工作项
					workItemManager.finishWorkItem(workItemID, false);
				}
			}
		}
	}
	
	@Bizlet("openBizform")
	public static boolean openBizform(long workItemID) throws WFServiceException{
		IWFBizFormForwardDriver manager = ServiceFactory.getWFBizFormForwardDriver();	
		return manager.isForwardBizFormClient(workItemID);
	}
	
	@Bizlet("queryWorkItemByPerson")
	public static DataObject queryWorkItemByPerson(String personID, String activityInstName,String processInstId) throws WFServiceException {
		IWFWorklistQueryManager queryManager = ServiceFactory.getWFWorklistQueryManager();
		//获取该人物ID的所有任务taskObjs
		DataObject[] taskObjs = queryManager.queryPersonWorkItems4SDO(personID, "ALL", "ALL", null);
		CommonUtil su = new CommonUtil();
		String activityNameFlag = "false";     //定义活动名称是否存在相同的标识
		for(int i = 0; i < taskObjs.length; i++){
			String activityTemp = (String) taskObjs[i].get("activityInstName");
			activityNameFlag = su.checkSameName(activityInstName, activityTemp);  //拆分activityInstName并用activityTemp进行比较
			String processTemp = Long.toString(taskObjs[i].getLong("processInstID"));
			
			if("true".equals(activityNameFlag) && processInstId.equals(processTemp))
				return taskObjs[i];
		}
		return queryHelpWorkItemByPerson(taskObjs,processInstId);
	}
	
	private static DataObject queryHelpWorkItemByPerson(DataObject[] taskObjs,String processInstId){
		for(int i = 0; i < taskObjs.length; i++){
			String activityTemp =  taskObjs[i].getString("activityInstName");
			if("征求意见".equals(activityTemp)){
				DataObject prcWorkInfo = DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsExpend.task.TAtsPrcWorkInfo");
				prcWorkInfo.set("isHelp", "1");
				prcWorkInfo.set("helpProcessinstId", taskObjs[i].get("processInstID"));
				prcWorkInfo.set("processinstId", processInstId);
				int num = DatabaseUtil.expandEntityByTemplate("default", prcWorkInfo, prcWorkInfo);
				if(num!=0){
					return taskObjs[i];
				}
			}
		}
		return null;
	}
	/*
	 * destActDefID：目标回退定义ID 例：manualActivitym2a1
	 */
	@Bizlet("筛选回退后需要设置为线路为false的路径")
	public static String filterBackDestAcitvityPath(String destActDefID){
		String destActDefPath = destActDefID.replace("manualActivity", "");
		destActDefPath = destActDefPath.substring(0, destActDefPath.length()-1);
		return destActDefPath;
	}
	
	@Bizlet("过滤所有路径")
	public static String[] filterAllBackAcitvityPath(DataObject[] activitys){
		Set<String> activitySet = new HashSet<String>();
		for (DataObject dataObj : activitys) {
			//manualActivitym2b3 manualActivitym2
			String activityDefID = dataObj.getString("activityDefID");
			if(activityDefID.indexOf("manualActivity")!=-1){
				//m2b3 m2
				String path = activityDefID.replace("manualActivity", "");
				//m2b m2
				path = path.substring(0,path.length()-1);
				//2是主支，大于2才是分支,且不是目标分支
				if(path.length()>2){
					activitySet.add(path);
				}
			}
		}
		String[] pathArr = new String[activitySet.size()];
		int i = 0 ;
		
		for (String path : activitySet) {
			pathArr[i] = path;
			i++;
		}
		
		return pathArr;
	}
	
	/*
	 * activitys:可回退的活动列表
	 * destActDefID：目标回退定义ID 例：manualActivitym2a1
	 */
	@Bizlet("筛选回退后需要设置为线路为false的路径")
	public static String[] filterBackAcitvityPath(DataObject[] activitys,String destActDefID){
		Set<String> activitySet = new HashSet<String>();
		//获取目标回退分支变量
		//m2a1
		String destActDefPath = destActDefID.replace("manualActivity", "");
		//m2a
		destActDefPath = destActDefPath.substring(0, destActDefPath.length()-1);
		
		for (DataObject dataObj : activitys) {
			//manualActivitym2b3 manualActivitym2
			String activityDefID = dataObj.getString("activityDefID");
			if(activityDefID.indexOf("manualActivity")!=-1){
				//m2b3 m2
				String path = activityDefID.replace("manualActivity", "");
				//m2b m2
				path = path.substring(0,path.length()-1);
				//2是主支，大于2才是分支,且不是目标分支
				if(path.length()>2&&!path.equals(destActDefPath)){
					activitySet.add(path);
				}
			}
		}
		String[] pathArr = new String[activitySet.size()];
		int i = 0 ;
		
		for (String path : activitySet) {
			pathArr[i] = path;
			i++;
		}
		
		return pathArr;
	}
	
	/**
	 * 通过母流程ID和当前执行人获取子流程的工作项
	 * @param helpWorkitem
	 * @return helpTargetWorkitem
	 */
	@Bizlet("获取征求意见子流程工作项")
	public WFWorkItem getHelpSubWorkitem(WFWorkItem helpWorkitem,String userid){
		IWFWorkItemManager workItemManager = null;
		WFWorkItem helpTargetWorkitem = null;
		try {
			workItemManager = ServiceFactory.getWFWorkItemManager();
			DataObject prcWorkInfo = DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsExpend.task.TAtsPrcWorkInfo");
			prcWorkInfo.set("isHelp", "1");
			prcWorkInfo.set("workitemId", helpWorkitem.getWorkItemID());
			DatabaseUtil.expandEntityByTemplate("default", prcWorkInfo, prcWorkInfo);
			
			if(prcWorkInfo.get("helpProcessinstId")!=null){
				List<WFWorkItem> list = workItemManager.queryNextWorkItemsByProcessInstID((Long) prcWorkInfo.get("helpProcessinstId"), true);
				
				for (WFWorkItem wfWorkItem : list) {
					if(wfWorkItem.getParticipant().equals(userid)){
						helpTargetWorkitem = wfWorkItem;
					}
				}
			}
		} catch (WFServiceException e) {
			e.printStackTrace();
		}
		
		if(helpTargetWorkitem==null){
			helpTargetWorkitem = helpWorkitem;
		}
		
		return helpTargetWorkitem;
	}

	/*
	 * 对数组待时间字段排序
	 */
	public static void sortDesc(DataObject[] list,String sortColumn){
		DataObject temp;
		for(int i=0;i<list.length -1; i++){
			for(int j=0;j<list.length-1-i;j++){
				Date iDate = list[j].getDate(sortColumn);
				Date jDate = list[j+1].getDate(sortColumn);
				if(iDate!=null&&jDate!=null){
					if(iDate.compareTo(jDate)<0){
						temp = list[j];
						list[j] = list[j+1];
						list[j+1] = temp;
					}
				}
			}
		}
	}
	
	
	/**
	 * 业务控制添加技术前驱控制，取交集
	 * @param activitys
	 * @param previousActivitys
	 * @return
	 */
	@Bizlet("业务查询和技术查询取交集")
	public static DataObject[] gatherTask(DataObject[] activitys,DataObject[] previousActivitys){
		
		ArrayList<DataObject> resultList = new ArrayList<DataObject>();
		for (int j = 0; j < activitys.length; j++) {
			DataObject activity = activitys[j];
			for (int k = 0; k < previousActivitys.length; k++) {
				DataObject preActivity = previousActivitys[k];
				if(activity.get("activitydefid").equals(preActivity.get("id"))){
					resultList.add(activity);
				}
			}
		}
		DataObject[] resultArr = new  DataObject[resultList.size()];
		
		for (int i = 0; i < resultList.size(); i++) {
			resultArr[i] = resultList.get(i);
			
		}
		
		return resultArr;
	}
	
	
	/**
	 * 相关数据变量是否存在
	 * @param processDefId 流程定义ID
	 * @param relaDataName 相关数据名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Bizlet("获取相关数据变量名称")
	public boolean hasRelaDataNameByActivityDefId(String processDefId,String relaDataName){
		boolean flag = false;
		if(processDefId!=null||relaDataName!=null){
			return flag;
		}
		DataObject defDataObj = DataObjectUtil.createDataObject("com.eos.workflow.data.WFProcessDefine");
		defDataObj.setLong("processDefID", Integer.parseInt(processDefId));
		DatabaseUtil.expandEntity("default", defDataObj);
		
		String defXml = defDataObj.getString("processDefContent");
		if(defXml!=null){
			try {
				Document document = DocumentHelper.parseText(defXml);
				Element rootElement = document.getRootElement();
				Element activitys = rootElement.element("processHeader");
				List<Element> list = activitys.elements("dataFields");
				for (Element element : list) {
					if(element.element("dataField").element("name").getText().equals(relaDataName)){
						flag = true;
					}
				}
			} catch (DocumentException e) {
				e.printStackTrace();
			}  
		}
		return flag; 
	}
	

	/**
	 * 获取相关数据变量名称
	 * @param processDefId 流程定义ID
	 * @param activityDefId 活动定义ID
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Bizlet("获取相关数据变量名称")
	public String getRelaDataNameByActivityDefId(String processDefId,String activityDefId){
		
			String returnValue = "";
			DataObject defDataObj = DataObjectUtil.createDataObject("com.eos.workflow.data.WFProcessDefine");
			defDataObj.setLong("processDefID", Integer.parseInt(processDefId));
			DatabaseUtil.expandEntity("default", defDataObj);
			
			String defXml = defDataObj.getString("processDefContent");
			
			if(defXml!=null){
				try {
					Document document = DocumentHelper.parseText(defXml);
					Element rootElement = document.getRootElement();
					Element activitys = rootElement.element("activities");
					List<Element> list = activitys.elements("activity");
					for (Element element : list) {
							//System.out.println(element.element("activityId").getText());
							//System.out.println(element.element("activityType").getText());
						if(element.element("activityId").getText().equals(activityDefId)&&element.element("activityType").getText().equals("manual")){
							Element impEl = element.element("implementation");
							if(impEl!=null){
								Element manualEl = impEl.element("manualActivity");
								Element partiEl = manualEl.element("participants");
								Element partiType = partiEl.element("participantType");
								if(partiType.getText().equals("relevantdata")){
									returnValue = partiEl.element("specialPath").getText();
								}
							}
						}
					}
				} catch (DocumentException e) {
					e.printStackTrace();
				}  
			}
			
				
		return returnValue; 
	}
	
	/**
	 * 流程中取到的相关数据可能是不同的类型，这里进行统一处理
	 * @param participants
	 * @return
	 */
	@Bizlet("将参与者数组转化为参与者list")
	public List<WFParticipant> transParticipantsArray2List(Object participants){
		List<WFParticipant> partiArray = new ArrayList<WFParticipant>();
		DataObject[] participantArr = null;
		if(participants instanceof DataObject[]){
			participantArr = (DataObject[]) participants;
			for (int i = 0; i < participantArr.length; i++) {
				WFParticipant parti = new WFParticipant();
				parti.setId(participantArr[i].get("id").toString());
				parti.setName(participantArr[i].get("name").toString());
				parti.setTypeCode(participantArr[i].get("typeCode").toString());
				partiArray.add(parti);
			}
			
		}else if(participants instanceof WFParticipant[]){
			WFParticipant[] participantStrs = (WFParticipant[]) participants;
			for (int i = 0; i < participantStrs.length; i++) {
				partiArray.add(participantStrs[i]);
			}
			
		}else if(participants instanceof WFParticipant){
			WFParticipant participant = (WFParticipant) participants;
			partiArray.add(participant);
		}
		
		return partiArray;
		
	}
}
