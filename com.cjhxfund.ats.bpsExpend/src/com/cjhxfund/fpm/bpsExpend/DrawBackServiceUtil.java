package com.cjhxfund.fpm.bpsExpend;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.api.IWFActivityInstManager;
import com.eos.workflow.api.IWFDefinitionQueryManager;
import com.eos.workflow.api.IWFWorkItemManager;
import com.eos.workflow.data.WFActivityDefine;
import com.eos.workflow.data.WFActivityInst;
import com.eos.workflow.data.WFWorkItem;
import com.primeton.workflow.api.WFServiceException;
import com.primeton.workflow.model.definition.Participant;
import commonj.sdo.DataObject;

@Bizlet
public class DrawBackServiceUtil {
	/**
	 * 
	 * @param activitys 当前执行的活动
	 * @return
	 * @throws WFServiceException
	 */
	@Bizlet("获取最后提交人员")
	public static String getLastfinishedActivity(DataObject[] activitys) throws WFServiceException{
		long lastFinishedActivityInstID = 0;
		//活动实例管理
		IWFActivityInstManager activityInstManager = ServiceFactory.getActivityInstManager();
		if(activitys.length>1){
			long previousActivityInstID = 0;
			//有流程分支，多个活动的情况下
			for (int i = 0; i < activitys.length; i++) {
				//获取最后一个前驱的人工活动实例ID
				long activityInstID = getLastManualActivityID(activitys[0].getLong("activityInstID"));
				if(previousActivityInstID==0){
					previousActivityInstID = activityInstID;
					lastFinishedActivityInstID = activityInstID;
				}else{
					//如果多分支的上一个前驱不相同，则说明有的分支已经提交过，则不可以回退
					if(previousActivityInstID != activityInstID){
						lastFinishedActivityInstID = 0;
					}
				}
			}
			
		}else if(activitys.length==1){
			List<WFActivityInst> instances = activityInstManager.queryPreviousActivityInstances(activitys[0].getLong("activityInstID"));
			if(instances.get(instances.size()-1).getActivityType().equals("route")){
				instances = activityInstManager.queryPreviousActivityInstances(instances.get(instances.size()-1).getActivityInstID());
			}
			lastFinishedActivityInstID = getLastManualActivityID(activitys[0].getLong("activityInstID"));
		}
		
		return  String.valueOf(lastFinishedActivityInstID);
		
	}
	
	/**
	 * 获取最后一个前驱的人工活动实例ID
	 * 递归方法
	 * @param activity
	 * @return
	 * @throws WFServiceException
	 */
	private static long getLastManualActivityID(long activityInstID) throws WFServiceException{
		IWFActivityInstManager activityInstManager = ServiceFactory.getActivityInstManager();
		List<WFActivityInst> instances = activityInstManager.queryPreviousActivityInstances(activityInstID);
		if(instances.get(instances.size()-1).getActivityType().equals("route")){
			return getLastManualActivityID(instances.get(instances.size()-1).getActivityInstID());
		}else if(instances.get(instances.size()-1).getActivityType().equals("toolapp")){ //跳过自动抄送节点 
			 return getLastManualActivityID(instances.get(instances.size()-1).getActivityInstID());
		}else{
		     return instances.get(instances.size()-1).getActivityInstID();
		}
	}
	/**
	 * 
	 * @param activitys 获取上一步参与者
	 * add by chenxing
	 * @throws Throwable 
	 */
	@Bizlet("获取上一步参与者")
	public static String getPrevJoiner(DataObject[] activitys) throws Throwable{
		long lastFinishedActivityInstID = 0;
		//获取工作项管理器
		IWFWorkItemManager  workItemManager = ServiceFactory.getWFWorkItemManager();
	    //上一参与者输出
		StringBuffer sbf = new StringBuffer();
		//拼接查询的工作项ID
		StringBuffer workitemIdStr = new StringBuffer();
		 //获取最后一个活动实例中的所有工作项
		List<WFWorkItem> workitemList;
		//参与者集合
		//List<WIParticipantInfo> joiner;
		//List<WFParticipant> joiner;
		Map<Long,Long> isExistMap = new HashMap<Long,Long>();
		//判断是否加入 --》 符号
		int s=0;
		int leng;
		String endStr;
		Map<String,String> joinerMap = new HashMap<String,String>();
		Set<String> joinerSet;
		String activityinstname="";
//		String operationName = "getActiPartiPerson";
//		Object[] params;
//		Object[] result;
		for (int i = 0; i < activitys.length; i++) {
				//获取最后一个活动ID
				//System.out.println(activitys[i].getLong("activityInstID"));
				lastFinishedActivityInstID = getLastManualActivityID(activitys[i].getLong("activityInstID"));
				if(!isExistMap.containsKey(lastFinishedActivityInstID)){	
				    //获取最后一个活动实例中的所有工作项
					workitemList = workItemManager.queryWorkItemsByActivityInstID(lastFinishedActivityInstID, null);
					if(workitemList.size()>0){
							for (WFWorkItem wfWorkItem : workitemList) {
								workitemIdStr.append(wfWorkItem.getWorkItemID()).append(",");
							}
					 }
				  }
				  isExistMap.put(lastFinishedActivityInstID, lastFinishedActivityInstID);
				}
				Map<String, String> parameterMap=new HashMap<String, String>();
				if(workitemIdStr.length()>0){
					parameterMap.put("workitemIds", workitemIdStr.substring(0, (workitemIdStr.length()-1)));
					//System.out.println(parameterMap);
					Object[] objects = DatabaseExt.queryByNamedSql("default","com.cjhxfund.fpm.bpsExpend.processUtil.queryFlowPreActor",parameterMap);
					DataObject[] dataObjects = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsExpend.task.ProcessInst", true);
					//只显示操作的参与者。
					//Object[] objects = DatabaseExt.queryByNamedSql("default","com.cjhxfund.fpm.bpsExpend.processUtil.queryActivityJoiner",parameterMap);
					//DataObject[] dataObjects = DataObjectUtil.convertDataObjects(objects, "com.cjhxfund.fpm.bpsUtil.task.ProcessInst", true);
					//获取从数据库表中获得的参与者
					//update by chenxing 2017101106
					for (DataObject dataObject : dataObjects) {
					    activityinstname = dataObject.getString("activityinstname");
					    if(!joinerMap.containsKey(activityinstname)){
					    	joinerMap.put(activityinstname, dataObject.getString("participantname"));
					    }
					}	
					
					//最后输出上一环节参与者
				    Set<String> activitySet = joinerMap.keySet();
				    if(activitySet.size()>0){
					    for (String activityNm : activitySet) {
					    	if(sbf.length()>0){
								sbf.append("@");
							}
					    	sbf.append(activityNm).append(" --> ").append(joinerMap.get(activityNm));
						}
				    }
				}
		
		    
		    return  sbf.toString();
		
	}
	/**
	 * 获取下一参与者
	 * add by chenxing
	 */
	@Bizlet("获取下一参与者")
	public String getNextJoiner(DataObject[] activitys) throws WFServiceException{
		//获取活动实列管理器
		//IWFActivityInstManager activityInstManager = ServiceFactory.getActivityInstManager();
		IWFDefinitionQueryManager defManager = ServiceFactory.getDefinitionQueryManager();
		List<WFActivityDefine> activityDefList;
		StringBuffer sbf = new StringBuffer();
		List<Participant>  joinerList;
		String activityVar;
		long processDefId;
		for (int i = 0; i < activitys.length; i++) {
			activityVar = activitys[i].getString("activityDefID");
			processDefId = activitys[i].getLong("processInstID");
			activityDefList = defManager.queryNextActivities(processDefId, activityVar);
		    for (WFActivityDefine wfActivityDef : activityDefList) {
		        //通过活动定义ID获取参与者 
		    	//joinerList = defManager.getActivityParticipants(wfActivityDef.getProcessDefId(),wfActivityDef.getId(), false);
		    	joinerList = wfActivityDef.getParticipants();
		    	if(sbf.length()>0){
					sbf.append("@");
				}
				sbf.append(wfActivityDef.getName()).append(" --> ");
                for(Participant participant : joinerList){
					sbf.append(participant.getParticipantName()).append(",");
				}
				sbf = new StringBuffer(sbf.substring(0, (sbf.length()-1)));
		  }
		}
		return sbf.toString();
	}
	/**
	 * 检查是否有重复活动ID，并把数据放入Map中
	 * add by chenxing
	 */
	@Bizlet("检查是否有重复活动ID")
	public Map<String,String> checkRepeatActivityID(Map<String,String> param,Map<String,String> activityNameMap)throws WFServiceException{
		String joinstr=" --> ";
		String join = "@";
		StringBuffer sbf;
		String key;
		String value;
		Map<String,String> result = new HashMap<String,String>();
		Set<String> set = param.keySet();
		for (Iterator iterator = set.iterator(); iterator.hasNext();){
			key = (String) iterator.next();
			if(!"isRepeat".equals(key)){
				value = param.get(key);
				if(result.containsKey("returnValue")){
					sbf = new StringBuffer(result.get("returnValue"));
					sbf.append(join).append(activityNameMap.get(key)).append(joinstr).append(value);
					result.put("returnValue",sbf.toString());
				}else{
					//第一步 加入--》
				   sbf = new StringBuffer(activityNameMap.get(key));
				   sbf.append(joinstr).append(value);
				   result.put("returnValue",sbf.toString());
				}
			}
		}
		return result;
	}
	/**
	 * 往Map里存活动ID和参与者
	 * add by chenxing
	 */
	@Bizlet("把活动ID活动名称参与者放到map中")
	public HashMap<String,String> appendActivityIdAndJoiner(HashMap<String,String> param,HashMap<String,String> activityNameMap, String activityId,String joiner,String activityName){
		StringBuffer sbf;    
		if(param.containsKey(activityId)){
			param.put("isRepeat","Y");
			sbf = new StringBuffer(param.get(activityId));
			sbf.append(",").append(joiner);
			param.put(activityId, sbf.toString());
			activityNameMap.put(activityId, activityName);
		}else{
			param.put(activityId,joiner);
			activityNameMap.put(activityId, activityName);
			param.put("isRepeat","N");
		}
		return param;
	}
}
