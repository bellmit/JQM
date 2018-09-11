package com.cjhxfund.fpm.bpsExpend;

import com.primeton.workflow.api.WFServiceException;

/**
 * 业务表单框架接口
 * @author zengjing
 *
 */
public interface IWFBizFormForwardDriver {
	
	/**
	 * 获取是否跳转至业务表单框架
	 * @param workItemId
	 * @return
	 * @throws WFServiceException
	 */
	public boolean isForwardBizFormClient(long workItemId) throws WFServiceException;
	
	/**
	 * 获取业务表单框架地址
	 * @return
	 */
	public String queryURL4BizFormClient();
}
