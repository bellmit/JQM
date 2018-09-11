/**
 * 
 */
package com.cjhxfund.cjapi.common;

import java.util.Date;


import com.cjhxfund.cjapi.feedback.CMBBankFeedback;
import com.cjhxfund.cjapi.feedback.InterBankFeedback;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.QrtzUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;

/**
 * @author 王锡锋
 * @date 2018-03-14 17:57:25
 *
 */
@Bizlet("")
public class TimeTaskNew {
	
	
	/**
	 * 执行自动更新
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取系统参数（ATS_MARKET_FEEDBACK_TIME_INTERVAL）默认配置间隔
	 * @param pEndTime	轮询结束时间，为空或格式错误时取系统参数（ATS_TIMER_END_TIME）默认配置时间
	 */
	@Bizlet("招行接口推送成交反馈信息")
	public static boolean doWileTaskJob(){
		LogUtil.logInfo(DateUtil.currentDateTimeString()+"  执行更新银行间成交反馈状态开始...",null);
		//是否调用成功
		boolean isSuccess = true;

		try {
			
			LogUtil.logInfo(DateUtil.currentDateTimeString()+"  银行间成交反馈 begin ...",null);
			try {
				Long beforeTime=(new Date()).getTime();
					
				/***业务调用开始***/
				CMBBankFeedback.doTaskJob();//新接口指令反馈
				InterBankFeedback.doTaskJob();//老接口指令反馈
				/***业务调用结束***/
					
				//刷新执行信息
				Long afterTime=(new Date()).getTime();
				String className=Thread.currentThread().getStackTrace()[1].getClassName();
				String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
				QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);

			} catch (Throwable e) {
				e.printStackTrace();
				isSuccess = false;
			}
			
			LogUtil.logInfo(DateUtil.currentDateTimeString()+" 银行间成交反馈 end !!!",null);
			//设置为调用成功
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
			isSuccess = false;
		} 
		LogUtil.logInfo(DateUtil.currentDateTimeString()+"  执行状态更新结束!!!",null);
		return isSuccess;
	}
}
