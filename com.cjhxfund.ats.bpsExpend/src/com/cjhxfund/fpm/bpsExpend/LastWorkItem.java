/**
 * 
 */
package com.cjhxfund.fpm.bpsExpend;

import java.util.List;

import com.eos.system.annotation.Bizlet;
import com.eos.workflow.data.WFWorkItem;
import commonj.sdo.DataObject;

/**
 * @author jiangkanqian
 * @date 2017-07-28 19:21:01
 *
 */
@Bizlet("")
public class LastWorkItem {
	
	@Bizlet("针对多工作项，判断是不是最后一个工作项")
	public int isLastWorkItem(DataObject currentWorkItem,List<WFWorkItem> workList){
		int resultInt=0;
		//DataObject workItem=currentWorkItem;
		//2 运行中 4 待领取  7 已完成
		//workList.get(1).getCurrentState();
		
		long currentWorkItemID=currentWorkItem.getLong("workItemID");
		String createTime=currentWorkItem.getString("createTime");
		long maxWorkItemID=0;
		
		if(workList!=null && workList.size()>1){
			
			for(int i=1;i<workList.size();i++){
				int res=createTime.compareTo(workList.get(i).getCreateTime());
		        if(res<0){
		        	maxWorkItemID=workList.get(i).getWorkItemID();
		        }
			}
		}
		if(maxWorkItemID==currentWorkItemID){
			resultInt=1;
		}else{
			resultInt=0;
		}
		return resultInt;
	}
}
