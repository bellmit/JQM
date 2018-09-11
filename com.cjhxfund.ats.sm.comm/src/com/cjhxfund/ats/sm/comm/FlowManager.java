/**
 * 
 */
package com.cjhxfund.ats.sm.comm;

import com.eos.system.annotation.Bizlet;
import com.eos.workflow.api.BPSServiceClientFactory;
import com.eos.workflow.api.IBPSServiceClient;
import com.eos.workflow.api.IWFWorkItemManager;
import com.primeton.workflow.api.WFReasonableException;
import com.primeton.workflow.api.WFServiceException;

/**
 * @author 刘玉龙
 * @date 2017-04-13 14:33:43
 *
 */
@Bizlet("")
public class FlowManager {
	/**
	 * 指定工作项由指令定人员完成
	 * @param workItemID 工作项ID  userID 用户账号  userName用户名称 
	 * @return
	 * @throws WFServiceException 
	 * @throws WFReasonableException 
	 */
	@Bizlet("指定人员完成指定工作项")
	public static void finishWorkItem(Long workItemID, String userID, String userName) throws WFServiceException, WFReasonableException{
		System.out.println(workItemID+"      "+ userID+"         "+ userName);
		BPSServiceClientFactory.getLoginManager().setCurrentUser(userID, userName);//web应用中，建议将该步调用写入Filter中
		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient();
		IWFWorkItemManager workItemMananger = client.getWorkItemManager();
		//workItemMananger.assignWorkItemToSelf(workItemID);//领取工作项
		workItemMananger.finishWorkItem(workItemID, false);//完成工作项
	}
	

}
