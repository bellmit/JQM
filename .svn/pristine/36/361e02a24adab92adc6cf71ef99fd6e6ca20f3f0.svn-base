package com.cjhxfund.fpm.bpsExpend;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.omservice.WFParticipant;

import commonj.sdo.DataObject;

public class WorkInfoUtil {
	/**
	 * 将替换数据手动插入prcWorkInfo表中
	 * @author wenhao
	 * @date 2016-12-5 11:41:28
	 * @param nextWorkItems 下一活动工作项信息
	 * @param returnMap     工作项id与转办人员列表信息
	 * @param retList       转办人信息List
	 * @return 
	 */
	@Bizlet("匹配对应人插入工作项信息表")
	public void insertPrcWorkInfo(DataObject[] nextWorkItems,
			Map<String, WFParticipant> returnMap,List<Map<String,String>> retList){
		
		int length  = nextWorkItems.length;
		for(int i=0;i<length;i++){    
			String nextWorkItemId = nextWorkItems[i].getString("workItemID");
			Iterator<String> resultSets =returnMap.keySet().iterator();  
			while(resultSets.hasNext()){								//获取Map的key的Set集合
				String key = (String) resultSets.next();			    //获取Map的key,即workItemId
				if(nextWorkItemId.equals(key)){
					WFParticipant partObj = returnMap.get(key);				//根据key获取value 值
					String partUserId = partObj.getId();
					for(int j=0,len=retList.size();j<len;j++){
						Map<String, String> map = new HashMap<String, String>();
						map = retList.get(j);                               //数据库得到的数据Map
						String lastUserId = map.get("lastUserId");		   //最后转办人Id
						if(partUserId.equals(lastUserId)){
							insertIntoPrcWorkInfo(nextWorkItems[i],map);
						}
					}
				}
			}
		}
	}
	
	
	/**
	 * 插入工作项信息表
	 * @author wenhao
	 * @date 2016-12-6 10:16:28
	 * @param nextWorkItem 下一个活动的所有工作项
	 * @param map 
	 */
	@Bizlet("插入工作项信息表")	
	public void insertIntoPrcWorkInfo(DataObject nextWorkItem,Map<String, String> map){
		DataObject pmPrcWorkInfo = 
				DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsExpend.task.TAtsPrcWorkInfo");
		
		String firUserId = map.get("firUserId");
		String handerActor = map.get("handerActor");
		String turnState =map.get("turnState");      
		String userCode =map.get("userCode");
		String userName =map.get("userName");
		
		String workitemId =nextWorkItem.getString("workItemID");
		String workitemName =nextWorkItem.getString("workItemName");
		String activityinstId =nextWorkItem.getString("activityInstID");
		String processinstId =nextWorkItem.getString("processInstID");
		String activityDefId =nextWorkItem.getString("activityDefID");
		
		pmPrcWorkInfo.setString("workitemId", workitemId);
		pmPrcWorkInfo.setString("workitemName",workitemName );
		pmPrcWorkInfo.setString("activityinstId",activityinstId);
		pmPrcWorkInfo.setString("processinstId", processinstId);
		pmPrcWorkInfo.setString("activityDefId", activityDefId);
		pmPrcWorkInfo.setString("operateType","3" );
		pmPrcWorkInfo.setLong("userId",Long.parseLong(firUserId));
		pmPrcWorkInfo.setString("userName", userName);
		pmPrcWorkInfo.setString("userCode", userCode);
		pmPrcWorkInfo.setDate("createTime", new Date());
		pmPrcWorkInfo.setString("turnState",turnState);
		pmPrcWorkInfo.setString("handleActor",handerActor);
		
		//获取主键，插入附件表
        DatabaseExt.getPrimaryKey(pmPrcWorkInfo);
        DatabaseUtil.insertEntity("default", pmPrcWorkInfo);
	}
}
