package com.cjhxfund.fpm.bpsExpend;

import java.util.List;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.api.IWFWorkItemManager;
import com.eos.workflow.data.WFWorkItem;
import com.primeton.workflow.api.WFServiceException;

import commonj.sdo.DataObject;


@Bizlet
public class HelpUtil {
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
}
