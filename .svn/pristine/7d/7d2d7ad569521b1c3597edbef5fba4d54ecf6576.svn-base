/**
 * 
 */
package com.cjhxfund.fpm.bpsExpend;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.eos.das.entity.criteria.CriteriaType;
import com.eos.das.entity.criteria.ExprType;
import com.eos.das.entity.criteria.OrderbyType;
import com.eos.das.entity.criteria.impl.CriteriaTypeImpl;
import com.eos.das.entity.criteria.impl.ExprTypeImpl;
import com.eos.das.entity.criteria.impl.OrderbyTypeImpl;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.api.IWFWorkItemManager;
import com.eos.workflow.omservice.WFParticipant;
import com.primeton.workflow.api.WFServiceException;

import commonj.sdo.DataObject;

/**
 * 用于转办后退办再提交时回到本人的功能
 * 用于queryIsTurnDoByWorkItemId.biz和reassignWorkItemEx.biz
 * @author wenhao
 * @date 2016-11-29 11:38:28
 *
 */
@Bizlet("工作项信息表的处理方法")
public class pmPrcWorkInfo {
	
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
	
	
	/** 
	 * 手动将转办人换为参与者
	 * @author wenhao
	 * @param returnMap  
	 * @throws WFServiceException
	 */
	@Bizlet("将系统设计参与者替换为转办人")
	public void reassignWorkItems(Map<String, WFParticipant> returnMap) throws WFServiceException{
		int length = returnMap.size();
		if(length>0){
			Iterator<String> resultSets =returnMap.keySet().iterator();
			while(resultSets.hasNext()){								//获取Map的key的Set集合
				String key = (String) resultSets.next();			    //获取Map的key,即workItemId
				long workItemId = Long.parseLong(key); 
				WFParticipant partObj = returnMap.get(key);				//根据key获取value 值
				String partUserId = partObj.getId();		    		//参与者Id
				IWFWorkItemManager workItemManager = ServiceFactory.getWFWorkItemManager();    //调用Eos流程服务，WorkItemManager
				workItemManager.reassignWorkItem(workItemId, partUserId);					   //调用WorkItemManager中的转办方法reassignWorkItem
			}
		}
	}
	
	
	
	/**
	 * 获取系统设置人员list集合,判断各工作项对应的转办人
	 * @author wenhao
	 * @date 2016-12-06 10:14:28
	 * @param nextWorkItems 下一个活动的所有工作项
	 * @param retList 数据库查询出来的人员信息list
	 * @return participantsMap 替换转办人所需要的Map
	 */
	@Bizlet("获取系统设置人员list集合判断各工作项对应的转办人")
	public Map<String, WFParticipant> getParticipantList(DataObject[] nextWorkItems,List<Map<String,String>> retList){
		Map<String, WFParticipant> participantsMap = new HashMap<String, WFParticipant>(); 
		
		for(int i =0,len = nextWorkItems.length;i<len;i++){
			String workItemId = nextWorkItems[i].getString("workItemID");     //下一活动工作项的Id
			DataObject[] participants = (DataObject[]) nextWorkItems[i].get("participants");
			DataObject participant = participants[0];
			String typeCode = participant.getString("typeCode");
			if("emp".equals(typeCode)){
				String partUserId = participant.getString("id");		//参与者Id
				for(int j=0,len2 =retList.size();j<len2;j++ ){				
					Map<String, String> map = new HashMap<String, String>();
					map = retList.get(j);                               //数据库得到的数据Map
					String firUserId = map.get("firUserId");            //最开始提交人Id
					String lastUserId = map.get("lastUserId");		    //最后转办人Id
					String lastUserName = map.get("lastUserName");      //最后转办人名称
					if(partUserId.equals(firUserId)){      			    //如果最开始提交人 ==设定的提交人
						WFParticipant participant3 = new WFParticipant();
						participant3.setId(lastUserId);
						participant3.setName(lastUserName);
						participant3.setTypeCode("emp");
						participantsMap.put(workItemId, participant3);
					}
				}
				
			}else if("role".equals(typeCode)){
				String roleId= participant.getString("id");
				List<String> empList = new ArrayList<String>();
				
				empList = getEmpIdListByRoleId(roleId);                //查询角色表中的empId列表数据
				
				for(int j=0,len2 =retList.size();j<len2;j++ ){				
					Map<String, String> map = new HashMap<String, String>();
					map = retList.get(j);                              //数据库得到的数据Map
					String firUserId = map.get("firUserId");           //最开始提交人Id
					String lastUserId = map.get("lastUserId");		   //最后转办人Id
					String lastUserName = map.get("lastUserName");     //最后转办人名称
					if(empList.contains(firUserId)){				   //最开始提交人Id是否包含在empId列表中
						WFParticipant participant2 = new WFParticipant();
						participant2.setId(lastUserId);
						participant2.setName(lastUserName);
						participant2.setTypeCode("emp");
						participantsMap.put(workItemId, participant2);  //将数据插入到participantsMap中
					}
				}
			}else {
				System.out.println("+++++++++++没有考虑此类型，请添加++++++++++++++++++++++++++++++++");
			}
			
		}
		return participantsMap;
	}
	
	/**
	 * 将查出的数据的empid组成一个list
	 * @author wenhao
	 * @date 2016-12-06 10:06:28
	 * @param roleId 角色Id
	 * @return empList 角色empId列表
	 */
	@Bizlet("获取该角色下的人员id列表")
	public List<String> getEmpIdListByRoleId(String roleId){
		//根据角色Id，查询角色表中该角色下的信息
		DataObject[] roleEmp =queryQRoleEmpByRoleId(roleId);
		List<String> empList = new ArrayList<String>();
		for(int i =0,len = roleEmp.length;i<len;i++){
			int empId = roleEmp[i].getInt("empid");
			String empIdString = String.valueOf(empId);
			empList.add(empIdString);
		}
		return empList;
	}
	
	/**
	 * 查询角色表中数据
	 * @author wenhao
	 * @date 2016-12-06 10:06:28
	 * @param roleId  角色Id
	 * @return roleEmp  角色表数据
	 */
	@Bizlet("获取角色表中的信息")
	public DataObject[] queryQRoleEmpByRoleId(String roleId){
		CriteriaType criteria = new CriteriaTypeImpl();
		criteria.set_entity("com.cjhxfund.fpm.bpsExpend.coframe.QRoleEmp");
		List<ExprType> expr = new ArrayList<ExprType>();
		ExprTypeImpl expr1 = new ExprTypeImpl();
		expr1.set_property("roleId");
		expr1.set_op("=");
		expr1.set_value(roleId);
		expr.add(expr1);
		
		criteria.set_expr(expr);
		
		List<OrderbyType> order = new ArrayList<OrderbyType>();
		OrderbyType order1 = new OrderbyTypeImpl();
		order1.set_property("empid");
		order1.set_sort("asc");
		order.add(order1);
		criteria.set_orderby(order);
		
		DataObject[] roleEmp = DatabaseUtil.queryEntitiesByCriteriaEntity("default", criteria);
		return roleEmp;
		
	}
	
	
	/**
	 * @author wenhao
	 * @date 2016-12-1 14:54:28
	 * @param prcWorkItemIds  工作项的Id数组
	 * @param activityDefId   下一活动的活动定义Id
	 * @return list  获取数据库工作项信息表的数据
	 */
	@Bizlet("获取数据库人员list集合")
	public List<Map<String,String>> getUserIdList(DataObject[] turnStates,String activityDefId,String processInstId){
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();
		int length = turnStates.length;
		for(int i=0;i<length;i++){
			Map<String, String> userInfoMap = new HashMap<String, String>();
			String turnState = turnStates[i].getString("turnState");		//工作项Id
			DataObject[] pmPrcWorkInfos = queryPrcWorkInfoById(turnState,activityDefId,processInstId);  //工作项信息表信息
			userInfoMap =  getuserIdMap(pmPrcWorkInfos);							//人员的Map
			list.add(userInfoMap);
		}
		return list;
	}
	
	/**
	 * @author wenhao
	 * @date 2016-12-1 14:00:28
	 * @param prcWorkItemId 工作项信息Id activityDefId 活动定义Id
	 * @return prcWorkInfos  工作项信息
	 */
	@Bizlet("获取对象数组")
	public DataObject[] queryPrcWorkInfoById(String turnState,String activityDefId,String processInstId){
		CriteriaType criteria = new CriteriaTypeImpl();
		criteria.set_entity("com.cjhxfund.fpm.bpsExpend.task.TAtsPrcWorkInfo");
		List<ExprType> expr = new ArrayList<ExprType>();
		ExprTypeImpl expr1 = new ExprTypeImpl();
		expr1.set_property("processinstId");
		expr1.set_op("=");
		expr1.set_value(processInstId);
		expr.add(expr1);
		
		ExprTypeImpl expr2 = new ExprTypeImpl();
		expr2.set_property("activityDefId");
		expr2.set_op("=");
		expr2.set_value(activityDefId);
		expr.add(expr2);
		
		ExprTypeImpl expr3 = new ExprTypeImpl();
		expr3.set_property("turnState");
		expr3.set_op("=");
		expr3.set_value(turnState);
		expr.add(expr3);
		
		ExprTypeImpl expr4 = new ExprTypeImpl();
		expr4.set_property("operateType");
		expr4.set_op("=");
		expr4.set_value("3");
		expr.add(expr4);
		
		criteria.set_expr(expr);
		
		List<OrderbyType> order = new ArrayList<OrderbyType>();
		OrderbyType order1 = new OrderbyTypeImpl();
		order1.set_property("sysid");
		order1.set_sort("asc");
		order.add(order1);
		criteria.set_orderby(order);
		
		DataObject[] prcWorkInfos = DatabaseUtil.queryEntitiesByCriteriaEntity("default", criteria);
		return prcWorkInfos;
	}
	
	
	
	
	/**
	 * @author wenhao
	 * @date 2016-11-30 11:38:28
	 * @param prcWorkInfo	工作项信息表信息
	 * @return 最开始的发起人firUserId，最后的被转办人lastUserId
	 */
	@Bizlet("获取最开始的提交人和最后的被转办人")
	public Map<String,String> getuserIdMap(DataObject[] prcWorkInfo){
		Map<String, String> map = new HashMap<String, String>();
		int length = prcWorkInfo.length;
		String firUserId = "";		//最开始的发起人
		String handerActor = "";    //最后转办人，格式：id，姓名
		String lastUserId ="";		//最后转办人id
		String lastUserName ="";    //最后转办人姓名
		String turnState ="";       //转办的分组
		String userCode ="";
		String userName ="";
		if(length>1){     
			firUserId = prcWorkInfo[0].getString("userId");
			userCode = prcWorkInfo[0].getString("userCode");
			userName = prcWorkInfo[0].getString("userName");
			handerActor = prcWorkInfo[length-1].getString("handleActor");
			turnState = prcWorkInfo[length-1].getString("turnState");
		}else{
			firUserId = prcWorkInfo[0].getString("userId");		
			handerActor = prcWorkInfo[0].getString("handleActor");
			turnState = prcWorkInfo[0].getString("turnState");
			userCode = prcWorkInfo[0].getString("userCode");
			userName = prcWorkInfo[0].getString("userName");
		}
		
		if(null != handerActor &&!"".equals(handerActor)){
			String[] userInfo = handerActor.split(",");
			lastUserId = userInfo[0];                               
			lastUserName = userInfo[1];   						    
			map.put("firUserId", firUserId);
			map.put("lastUserId", lastUserId);
			map.put("lastUserName", lastUserName);
			map.put("handerActor", handerActor);
			map.put("turnState", turnState);
			map.put("userCode", userCode);
			map.put("userName", userName);
 		}
		return map;
	}
	
	
	
	/**
	 * 流程转办时使用reassignWorkItemEx.biz
	 * 判断需要附的分组的值
	 * @param prcWorkInfos
	 * @return
	 */
	@Bizlet("判断要附的组别值")
	public String setTurnState(DataObject[] prcWorkInfos){
		String newTurnNum = "";
		int length = prcWorkInfos.length;
		if(length>1){    //如果多于1条数据，即证明这组数据已有分组
			newTurnNum  = prcWorkInfos[0].getString("turnState");    //已有分组，则附相同的组别
		}else if(length == 1){           //如果查出1条数据，即证明为新的分组
			String processinstId = prcWorkInfos[0].getString("processinstId");
			String activityDefId = prcWorkInfos[0].getString("activityDefId");
			newTurnNum = getTurnStateGroup(activityDefId,processinstId);   //得到最新的组别
		}else{
			System.out.println("+++++++++++++++系统有误，查询工作项表失败++++++++++++");
		}
		return newTurnNum;
	}
	
	
	/**
	 * 流程转办时新增数据时，查询转办的分组情况
	 * @param activityDefId
	 * @param processinstId
	 * @return
	 */
	@Bizlet("查改工作项下的信息转办分组组别")
	public String getTurnStateGroup(String activityDefId,String processinstId){
		String newTurnNum ="";  //最新分组
		int bigTurnState = 0;   //数据中分组的最大值
		DataObject[] pmPrcWorkInfos = queryPrcWorkInfoByActivityDefId(activityDefId,processinstId);  //工作项信息表信息
		
		//循环得到组别的最大值
		for(int i=0,len=pmPrcWorkInfos.length;i<len;i++){
			String turnState = pmPrcWorkInfos[i].getString("turnState");
			if(turnState==null||turnState.equals("")){
				
			}else{
				int turnStateNum = Integer.parseInt(turnState);
				if(bigTurnState==0){                
					bigTurnState = turnStateNum;
				}else if(bigTurnState<turnStateNum){ 
					bigTurnState = turnStateNum;
				}
			}
		}
		newTurnNum = String.valueOf(bigTurnState+1);
		return newTurnNum;
	}
	
	/**
	 * 根据条件，查询该流程该活动环节的转办的数据集
	 * @param activityDefId
	 * @param processinstId
	 * @return
	 */
	@Bizlet("获取对象数组")
	public DataObject[] queryPrcWorkInfoByActivityDefId(String activityDefId,String processinstId){
		CriteriaType criteria = new CriteriaTypeImpl();
		criteria.set_entity("com.cjhxfund.fpm.bpsExpend.task.TAtsPrcWorkInfo");
		List<ExprType> expr = new ArrayList<ExprType>();
		ExprTypeImpl expr1 = new ExprTypeImpl();
		expr1.set_property("processinstId");
		expr1.set_op("=");
		expr1.set_value(processinstId);
		expr.add(expr1);
		
		ExprTypeImpl expr2 = new ExprTypeImpl();
		expr2.set_property("activityDefId");
		expr2.set_op("=");
		expr2.set_value(activityDefId);
		expr.add(expr2);
		
		ExprTypeImpl expr3 = new ExprTypeImpl();
		expr3.set_property("operateType");
		expr3.set_op("=");
		expr3.set_value("3");
		expr.add(expr3);
		
		criteria.set_expr(expr);
		
		List<OrderbyType> order = new ArrayList<OrderbyType>();
		OrderbyType order1 = new OrderbyTypeImpl();
		order1.set_property("workitemId");
		order1.set_sort("asc");
		order.add(order1);
		criteria.set_orderby(order);
		
		DataObject[] prcWorkInfos = DatabaseUtil.queryEntitiesByCriteriaEntity("default", criteria);
		return prcWorkInfos;
	}
}
