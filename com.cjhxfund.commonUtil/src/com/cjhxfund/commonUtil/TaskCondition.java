package com.cjhxfund.commonUtil;

import java.util.HashMap;

import org.apache.commons.lang.StringUtils;

import com.eos.engine.component.ILogicComponent;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * 
 * @author 侯志勇
 * 任务条件查询拼装
 *
 */
public class TaskCondition {
	
	/**
	 * 待办已办查询条件拼装
	 * @param bizCriteria 业务实体查询条件，业务实体对应公共中间待办表T_ATS_BIZ_PROCESS
	 * @param workCiriteria 工作项实体查询条件，用于关联工作项表
	 * @param task 前端传入的查询条件对象
	 * @param sortField 排序字段
	 * @param sortOrder 排序方式
	 */
	@Bizlet("待办已办查询条件拼装")
	public static void setTaskQueryCondtion(DataObject bizCriteria,DataObject workCiriteria,DataObject task,String sortField,String sortOrder){
		bizCriteria.set("_entity", "com.cjhxfund.ats.sm.comm.atsSmData.TAtsBizProcess");
		workCiriteria.set("_entity", "com.eos.workflow.data.WFWorkItem");
		
		//业务查询条件
		if(!StringUtils.isEmpty(task.getString("vcProductCode"))){
			bizCriteria.set("_expr[1]/vcProductCode", task.getString("vcProductCode"));
			bizCriteria.set("_expr[1]/_op", "=");
		}
		if(!StringUtils.isEmpty(task.getString("vcCombiNo"))){
			bizCriteria.set("_expr[2]/vcCombiNo", task.getString("vcCombiNo"));
			bizCriteria.set("_expr[2]/_op", "=");
		}
		if(!StringUtils.isEmpty(task.getString("vcProcessType"))){
			bizCriteria.set("_expr[3]/vcProcessType", task.getString("vcProcessType"));
			bizCriteria.set("_expr[3]/_op", "=");
		}
		/*else{
			bizCriteria.set("_expr[3]/vcProcessType","101,102,103");
			bizCriteria.set("_expr[3]/_op", "in");
		}*/
		if(!StringUtils.isEmpty(task.getString("workItemName"))){
			workCiriteria.set("_expr[1]/workItemName", task.getString("workItemName"));
			workCiriteria.set("_expr[1]/_op", "like");
			workCiriteria.set("_expr[1]/_likeRule", "all");
		}
		if(!StringUtils.isEmpty(task.getString("stockCode"))){
			bizCriteria.set("_expr[5]/vcStockCode", task.getString("stockCode"));
			bizCriteria.set("_expr[5]/_op", "=");
		}
		if(!StringUtils.isEmpty(task.getString("stockName"))){
			bizCriteria.set("_expr[6]/vcStockName", task.getString("stockName"));
			bizCriteria.set("_expr[6]/_op", "like");
			bizCriteria.set("_expr[6]/_likeRule", "all");
		}
		if(!StringUtils.isEmpty(task.getString("vcAbstract"))){
			bizCriteria.set("_expr[7]/vcAbstract", task.getString("vcAbstract"));
			bizCriteria.set("_expr[7]/_op", "like");
			bizCriteria.set("_expr[7]/_likeRule", "all");
		}
		
		if(sortField.startsWith("bizObject")){
			bizCriteria.set("_orderby[1]/_property", sortField.substring(sortField.indexOf(".")+1));
			bizCriteria.set("_orderby[1]/_sort", sortOrder);
		}else{
			workCiriteria.set("_orderby[1]/_property", sortField);
			workCiriteria.set("_orderby[1]/_sort", sortOrder);
		}
	}
		
	/**
	 * 根据入参信息组装可处理工作项记录
	 * @param instructInfo 指令信息
	 * @return result 1=不可审批，0=可以审批
	 */
	@SuppressWarnings("rawtypes")
	@Bizlet()
	public String assemblyWorkInfo(HashMap instructInfo){
		// 1=不可审批，0=可以审批
		String result = "1";
		String processId = "";
		String userId = "";
		DataObject[] workInfos = null;
		
		if(instructInfo != null){
			// 先判断流程状态是否在待审批
			if("2".equals(instructInfo.get("vcProcessStatus")) || "3".equals(instructInfo.get("vcProcessStatus"))){
				processId = instructInfo.get("lProcessinstId").toString();
				// 查询是否有审批权限
				ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.ats.sm.comm.TaskManager");
				try {
					Object[] workInfo = comp.invoke("queryProcessApproveUsersByProcessid", new String[] { processId });
					userId = workInfo[1].toString();
					workInfos = (DataObject[])workInfo[0];
					if(workInfos.length > 0){
						for(int j=0; j<workInfos.length; j++){
							if(workInfos[j].getString("vcUserId").equals(userId)){
								result = "0";
							}
						}
					}
				} catch (Throwable e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}//调用逻辑流的方法
				
			}
		}
		return result;
	}
	
}
