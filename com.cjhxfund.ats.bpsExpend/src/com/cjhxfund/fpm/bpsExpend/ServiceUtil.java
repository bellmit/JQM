package com.cjhxfund.fpm.bpsExpend;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.math.RandomUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.api.IWFRelativeDataManager;
import com.eos.workflow.api.IWFWorkItemManager;
import com.eos.workflow.api.IWFWorklistQueryManager;
import com.eos.workflow.data.WFWorkItem;
import com.eos.workflow.omservice.WFParticipant;
import com.primeton.ext.engine.component.LogicComponentFactory;
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
public class ServiceUtil {
	
	/*
	 * Modified by Alaric Liu
	 * Desc : modify from using bps api to using namesql
	 * */
	@Bizlet("queryTaskList")
	public static DataObject[] queryTaskList(String personID,String permission, String scope, DataObject pagecond, String taskType,Map<String,String> criteriaMap) throws WFServiceException {
		IWFWorklistQueryManager queryManager = ServiceFactory.getWFWorklistQueryManager();
		DataObject[] taskList = null;
		//查询所有征求意见
		
		//DataObject[] helpDataObjects = queryHelpDataObjects();
		
		if ("self".equals(taskType)) {
			criteriaMap.put("personID", personID);
			Object[] objects = DatabaseExt.queryByNamedSqlWithPage("default", "com.cjhxfund.fpm.bpsUtil.processes.queryBackLogList",pagecond, criteriaMap);
					taskList = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsUtil.task.Task", true);
		} else if ("finishedSelf".equals(taskType)) {
			//DataObject[] taskObjs = queryManager.queryPersonFinishedWorkItems4SDO(personID, scope, false, null);
			criteriaMap.put("personID", personID);
			Object[] objects = DatabaseExt.queryByNamedSqlWithPage("default", "com.cjhxfund.fpm.bpsUtil.processes.queryFinishTaskList",pagecond, criteriaMap);
					taskList = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsUtil.task.ProcessInst", true);
		} else if ("entrust".equals(taskType)) {
			taskList = queryManager.queryPersonEntrustWorkItems4SDO(personID, scope, pagecond);
		} else if ("finishedEntrust".equals(taskType)) {
			taskList = queryManager.queryPersonEntrustFinishedWorkItems4SDO(personID, scope, false, pagecond);	
		} else {
			taskList = new DataObject[0];
		}	
		//sortDesc(taskList);
		return taskList;
	}
	//通知已完成的任务
	@Bizlet("queryViewedProcessInstNotifications")
	public static DataObject[] queryViewedProcessInstNotifications(String personID,String permission, String scope, DataObject pagecond,Map<String,String> criteriaMap) throws WFServiceException {
		
		criteriaMap.put("personID", personID);
		Object[] objects = DatabaseExt.queryByNamedSqlWithPage("default", "com.cjhxfund.fpm.bpsUtil.processes.getViewedNotice", pagecond, criteriaMap);
		
		int arrLength = objects.length;
		DataObject[] taskList = new DataObject[arrLength];
		try{
			taskList = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsUtil.task.Task", true);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		//sortDesc(taskList);
		 return taskList;
	}
	//待閱讀通知
	@Bizlet("queryUnViewedProcessInstNotifications")
	public static DataObject[] queryUnViewedProcessInstNotifications(String personID,String permission, String scope, DataObject pagecond,Map<String,String> criteriaMap) throws WFServiceException {
		
		criteriaMap.put("personID", personID);
		Object[] objects = DatabaseExt.queryByNamedSqlWithPage("default", "com.cjhxfund.fpm.bpsUtil.processes.getUnviewedNotice", pagecond, criteriaMap);
		
		int arrLength = objects.length;
		DataObject[] taskList = new DataObject[arrLength];
		try{
			taskList = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsUtil.task.Task", true);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		//sortDesc(taskList);
		return taskList;
	}
	
	/**
	 * 查询流转中任务数据 
	 * @param personID
	 * @return
	 * @throws Exception
	 */
	@Bizlet("queryRunningTaskList")
	public static DataObject[] queryRunningTaskList(Map<String,String> criteriaMap,String personID,DataObject pagecond) throws Exception{	
		int num =RandomUtils.nextInt();
		Map<String, String> parameterMap=new HashMap<String, String>();
		String keyWord = criteriaMap.get("keyWord");
		parameterMap.put("personID", personID);
		parameterMap.put("keyWord", keyWord);
		DataObject[] tasklist = null;
		Object[] objects = null;
		try{
			objects = DatabaseExt.queryByNamedSqlWithPage("default", "com.cjhxfund.fpm.bpsUtil.processes.queryRunningTaskList", pagecond, parameterMap);
			tasklist = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsUtil.task.ProcessInst", true);
			setProcessInfo(tasklist);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return tasklist;
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
			Object[] objects = DatabaseExt.queryByNamedSql("default", "com.cjhxfund.fpm.bpsUtil.processes.getRunningProcessInfo", parameterMap);
			DataObject[] dataObjects = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsUtil.task.ProcessInst", true);
			
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
			if(dataObject.getString("processinstid").equals(processInstID)){
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
		List resultList=new ArrayList();;
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
		DataObject[] result=DataObjectUtil.convertDataObjects(resultList, "com.cjhxfund.fpm.bpsUtil.task.ProcessInst", true);
		return result;
	}
	
	//查询任务数量
	@Bizlet("queryTaskCount")
	public static int queryTaskCount(String personID,String permission, String scope, DataObject pagecond, String taskType,Map<String,String> criteriaMap) throws WFServiceException{
		IWFWorklistQueryManager queryManager = ServiceFactory.getWFWorklistQueryManager();
		int arrLength = 0;
		if("self".equals(taskType)){
			//DataObject[] taskObjs = queryManager.queryPersonWorkItems4SDO(personID, permission, scope, null);
			criteriaMap.put("personID", personID);
			Object[] objects = DatabaseExt.queryByNamedSql("default", "com.cjhxfund.fpm.bpsUtil.processes.queryBackLogList", criteriaMap);
			
			arrLength = objects.length;
		} else if("finishedSelf".equals(taskType)){
			criteriaMap.put("personID", personID);
			Object[] objects = DatabaseExt.queryByNamedSql("default", "com.cjhxfund.fpm.bpsUtil.processes.queryFinishTaskList", criteriaMap);
			arrLength = objects.length;
		} 
		return arrLength;
	}
	//查询待阅通知消息数量
	@Bizlet("queryUnViewedProcessInstNotificationsCount")
	public static int queryUnViewedProcessInstNotificationsCount(String personID,String permission, String scope, DataObject pagecond,Map<String,String> criteriaMap) throws WFServiceException{
		int arrLength = 0;
		criteriaMap.put("personID", personID);
		Object[] objects = DatabaseExt.queryByNamedSql("default", "com.cjhxfund.fpm.bpsUtil.processes.getUnviewedNotice", criteriaMap);
		
		arrLength = objects.length;
		
		return arrLength;
	}
	//查询已阅通知消息数量
	@Bizlet("queryViewedProcessInstNotificationsCount")
	public static int queryViewedProcessInstNotificationsCount(String personID,String permission, String scope, DataObject pagecond,Map<String,String> criteriaMap) throws WFServiceException{
		int arrLength = 0;
		criteriaMap.put("personID", personID);
		Object[] objects = DatabaseExt.queryByNamedSql("default", "com.cjhxfund.fpm.bpsUtil.processes.getViewedNotice", criteriaMap);
		
		arrLength = objects.length;
		
		return arrLength;
	}
	//查询任务数量
	@Bizlet("queryRunningTaskCount")
	public static int queryRunningTaskCount(Map<String,String> criteriaMap,String personID,DataObject pagecond) throws Exception{	
		Map<String, String> parameterMap=new HashMap<String, String>();
		String keyWord = criteriaMap.get("keyWord");
		parameterMap.put("personID", personID);
		parameterMap.put("keyWord", keyWord);
		Object[] objects = DatabaseExt.queryByNamedSql("default", "com.cjhxfund.fpm.bpsUtil.processes.queryRunningTaskList", parameterMap);
		return objects.length;
	}
	/**
	 * 取工作项的最新的完成时间
	 * @param workitemId
	 * @return
	 * @throws Exception
	 */
	@Bizlet("getProcessLastFinishTime")
	public static Date getProcessLastFinishTime(String processInstId){	
		Date finishDate = null;
		Object[] objects = null;
		Map<String, String> parameterMap=new HashMap<String, String>();
		parameterMap.put("processInstId", processInstId);
		try{
			objects = DatabaseExt.queryByNamedSql("default", "com.cjhxfund.fpm.bpsUtil.processes.getProcessLastFinishTime", parameterMap);
			finishDate = (Date) objects[0];
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return finishDate;
	}
	
	
	/**
	 * * 根据条件过滤筛选结果集
	 * @param criteriaMap
	 * @param taskList
	 * @return
	 */
	private static DataObject[] filterList(Map<String, String> criteriaMap,DataObject[] taskList) {
		//DataObject newDataObj = DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsUtil.task.Task");
		
		//modified by huang 支持多个过滤 
		//modified by huang 201610120 在我的任务查询的时候存在(k,v)->(key,null) 根据以前的逻辑对这种情况的不予校验 作如下修改
		Iterator iter = criteriaMap.entrySet().iterator();
		List<DataObject> resultList = new ArrayList<DataObject>();
		for( int i = 0; i< taskList.length ; i++){
			resultList.add(taskList[i]);
		}
		while(iter.hasNext()){
			
			Map.Entry<String,String> entry = (Map.Entry<String,String> )iter.next();
			String key =  entry.getKey();
			String keyWord = entry.getValue();
			if(keyWord == null || "".equals(keyWord.trim())){
				continue;
			}
			List<DataObject> temptList = new ArrayList<DataObject>();
			for (int i = 0; i < resultList.size(); i++) {
				DataObject dataObj = resultList.get(i);
				String  processInstName = dataObj.getString("processInstName");
				//是否是含有关键字
				if(processInstName!=null&&!processInstName.equals("")&&keyWord!=null&&!keyWord.equals("")){
					if(processInstName.indexOf(keyWord)!=-1){
						temptList.add(dataObj);
					}
				}
				
			}
			//下一个循环
			resultList = temptList;
		}
		/*if(resultList.isEmpty()){
			return null;
		}else{*/
			DataObject[] resultTaskList = new DataObject[resultList.size()];
			for (int i = 0; i < resultTaskList.length; i++) {
				resultTaskList[i] = resultList.get(i);
				
			}
			return resultTaskList;
		//}
	}
	/**
	 * 根据征求意见来过滤
	 * @param taskList
	 * @return
	 */
	private static DataObject[] helpFilterList(DataObject[] helpDataObjects,DataObject[] taskList) {
		List<DataObject> resultList = new ArrayList<DataObject>();
		for (int i = 0; i < taskList.length; i++) {
			DataObject dataObj = taskList[i];
			String workItemID = dataObj.getString("taskId");
			String taskType = dataObj.getString("taskType");
			if(!isHelp(workItemID,taskType,helpDataObjects)){
				resultList.add(dataObj);
			}
		}
		
		DataObject[] resultTaskList = new DataObject[resultList.size()];
		for (int i = 0; i < resultTaskList.length; i++) {
			resultTaskList[i] = resultList.get(i);
			
		}
		return resultTaskList;
	}

	
	/**
	 * 通过工作项状态表查询该工作项是否有征求意见的情况
	 * @param workItemID
	 * @return
	 */
	private static boolean isHelp(String workItemID,String taskType,DataObject[] helpDataObjects) {
		boolean flag = false;
		if(taskType.equals("task")){
			for (DataObject helpDataObj : helpDataObjects) {
				String workitemId = helpDataObj.getString("workitemId");
				if(workItemID!=null&&workitemId!=null&&workItemID.equals(workitemId)){
					flag = true;
				}
			}
		}
		return flag;
	}


	/**
	 * 查询所有征求意见
	 * @return
	 */
	private static DataObject[] queryHelpDataObjects() {
		DataObject prcWorkInfo = DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsExpend.task.TAtsPrcWorkInfo");
		prcWorkInfo.set("isHelp", "1");
		return DatabaseUtil.queryEntitiesByTemplate("default", prcWorkInfo);
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
		String activityNameFlag = "false";     //定义活动名称是否存在相同的标识
		for(int i = 0; i < taskObjs.length; i++){
			String activityTemp = (String) taskObjs[i].get("activityInstName");
			activityNameFlag = checkSameName(activityInstName, activityTemp);  //拆分activityInstName并用activityTemp进行比较
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
	 * 
	 * @param criteriaMap   1.用户ID, 2.流程阶段 3.产品ID
	 * @param pagecond
	 * @return
	 * @throws Exception
	 */
	@Bizlet("getTheProcess")
	public static DataObject[] getTheProcess(Map<String,String> criteriaMap,DataObject pagecond) throws Exception{	
		DataObject[] tasklist = null;
		Object[] objects = null;
		try{
			
			objects = DatabaseExt.queryByNamedSqlWithPage("default", "com.cjhxfund.fpm.bpsUtil.processes.getTheProcess",pagecond, criteriaMap);													  
			tasklist = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsUtil.task.Task", true);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return tasklist;
	}
	
	
	@SuppressWarnings("unchecked")
	@Bizlet("获取参与人员")
	public List<WFParticipant> getParticipant(String processDefId,String activityDefId,long processInstID) throws Throwable{
		
			List<WFParticipant> returnValue = new ArrayList<WFParticipant>();
			DataObject defDataObj = DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsExpend.task.Wfprocessdefine");
			defDataObj.setLong("processdefid", Integer.parseInt(processDefId));
			DatabaseUtil.expandEntity("default", defDataObj);
			IWFRelativeDataManager relativeDataMgr = ServiceFactory.getRelativeDataManager();
			
			String defXml = defDataObj.getString("processdefcontent");
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
							System.out.println(partiType.getText());
							if(partiType.getText().equals("relevantdata")){
								String relaName = partiEl.element("specialPath").getText();
								Object relaData = relativeDataMgr.getRelativeData(processInstID, relaName);
								if(relaData!=null && !"".equals(relaData)){
									returnValue = transParticipantsArray2List(relaData);
								}								
							}
							if(partiType.getText().equals("rulelogic")){
								Element regularApp = partiEl.element("regularApp");
								Element application = regularApp.element("application");
								String applicationUri = application.element("applicationUri").getText();
								if(applicationUri.equals("com.cjhxfund.fpm.onetomanyRaise.flowMsg.participantRule")){
									ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.fpm.onetomanyRaise.flowMsg");						
//									relativeDataMgr = ServiceFactory.getRelativeDataManager();
//									String relaData = (String) relativeDataMgr.getRelativeData(processInstID, "creator");
									
									Map<String, Long> parameterMap=new HashMap<String, Long>();
									parameterMap.put("processInstID", processInstID);
									Object[] creatorObj = DatabaseExt.queryByNamedSql("default", "com.cjhxfund.fpm.bpsExpend.processUtil.queryProcessCreator", parameterMap);
									String creator = (String) creatorObj[0];
									
									Object[] params;
									params = new Object[]{creator};
									Object[] result = (Object[]) comp.invoke("participantRule", params);
									WFParticipant wp = (WFParticipant) result[0];
									returnValue.add(wp);
								}															
							}
							if(partiType.getText().equals("organization-list")){
								Element organization = partiEl.element("organization");
								Element participant = organization.element("participant");
								String roleName = participant.element("name").getName();
								ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.fpm.bpsExpend.role");
								Object[] params = new Object[]{roleName};
								Object[] result = (Object[]) comp.invoke("queryRolesByRoleCode", params);
								returnValue = (List<WFParticipant>) result[0];
							}
							
						}
					}
				}
			} catch (DocumentException e) {
				e.printStackTrace();
			}  
				
		return returnValue; 
	}
	
	@SuppressWarnings("unchecked")
	@Bizlet("查询流程环节参与者是否是流程发起人")
	public String isCreateParticipant(String processDefId,String activityDefId){
		
			String returnValue = "";
			DataObject defDataObj = DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsExpend.task.Wfprocessdefine");
			defDataObj.setLong("processdefid", Integer.parseInt(processDefId));
			DatabaseUtil.expandEntity("default", defDataObj);
			
			String defXml = defDataObj.getString("processdefcontent");
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
							if(partiType.getText().equals("process-starter")){
								returnValue = "true";
							}
							else{
								returnValue = "false";
							}
						}
					}
				}
			} catch (DocumentException e) {
				e.printStackTrace();
			}  
				
		return returnValue; 
	}
	
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
	
	 @Bizlet("判断名字在名字数组字符串中是否存在")
	 	public static String checkSameName(String nameArrayStr,String name){
		 	String flag = "false";
		 	if(!(nameArrayStr==null)){
		 		if(nameArrayStr.indexOf(",") > -1){
		 			String[] nameArray = nameArrayStr.split(",");
		 			for(int i = 0; i < nameArray.length; i++){
		 				if(nameArray[i].equals(name)){
		 					flag = "true";
		 				}
		 			}
		 		} else {
		 			if(nameArrayStr.equals(name)) flag = "true";
		 		}
		 	}
	 		return flag;
	 	}
	 
}
