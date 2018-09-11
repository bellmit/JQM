/**
 * 
 */
package com.cjhxfund.cjapi.common;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.cjhxfund.ats.sm.comm.TimerManage;
import com.cjhxfund.cjapi.feedback.CMBBankFeedback;
import com.cjhxfund.cjapi.feedback.InterBankFeedback;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.ParamConfig;
import com.cjhxfund.commonUtil.QrtzUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;


/**
 * @author yangminwb
 * @date 2017-09-06 14:31:27
 *
 */
@Bizlet("")
public class TimedTask {
	//转换日期格式为yyyyMMddHHmmss
	public static SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");	
	public static SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	// 手动定时器结束时间(执行状态变更)
	private static Date MARKET_FEEDBACK_entTime = null;
	public static String ATS_MARKET_FEEDBACK_TIME_INTERVAL = "ATS_MARKET_FEEDBACK_TIME_INTERVAL";
	//定时器执行结束时间（作为判断定时器有没有正常执行的判断依据，和当前时间比较，两个的差量大于定时器的频率则，定时器出现问题）
	private static Date taskEntTime = null;
	//secondMarketFeedback
	//定义自动定时器的频率
	private static long  frequencyTime = 180;//秒
	/**
	 * 执行自动更新
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取系统参数（ATS_MARKET_FEEDBACK_TIME_INTERVAL）默认配置间隔
	 * @param pEndTime	轮询结束时间，为空或格式错误时取系统参数（ATS_TIMER_END_TIME）默认配置时间
	 */
	@Bizlet("")
	public static boolean doWileTaskJob(String pIntervalTime, String pEndTime){
		LogUtil.logInfo(DateUtil.currentDateTimeString()+"  执行更新银行间成交反馈状态开始...",null);
		//是否调用成功
		boolean isSuccess = true;
		
		boolean execute = true;
		try {
			//获取轮询间隔时间，为空或格式错误时取默认30秒
			int intervalTime = Integer.parseInt(ParamConfig.getValue(TimedTask.ATS_MARKET_FEEDBACK_TIME_INTERVAL));
			
			if(StringUtils.isNotBlank(pIntervalTime)){
				try {
					intervalTime = Integer.valueOf(pIntervalTime.trim());
				} catch (NumberFormatException e) {
					LogUtil.logError("InterBankFeedback.doTaskJob fail: 轮询间隔时间格式错误，取默认"+intervalTime+"秒！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询间隔时间为空，取默认"+intervalTime+"秒！", null, new Object[]{});
			}
			
			//获取轮询结束时间，为空或格式错误时取默认17:00
			String date = DateUtil.currentDateDefaultString();
			String endTime = ParamConfig.getValue(TimerManage.ENDTIME_PARAM_KEY);
			MARKET_FEEDBACK_entTime = DateUtil.parse(date+" "+endTime, DateUtil.YMDHMS_PATTERN);
			if(StringUtils.isNotBlank(pEndTime)){
				try {
					MARKET_FEEDBACK_entTime = DateUtil.parse(date+" "+pEndTime.trim()+":00", DateUtil.YMDHMS_PATTERN);
				} catch (Exception e) {
					LogUtil.logError("InterBankFeedback.doTaskJob fail: 轮询结束时间格式错误，取默认"+endTime+"！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询结束时间为空，取默认"+endTime+"！", null, new Object[]{});
			}
			
			//循环执行
			while(execute){
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
				
				taskEntTime=DateUtil.currentDate();//获取时间
				
				LogUtil.logInfo(DateUtil.currentDateTimeString()+" 银行间成交反馈 end !!!",null);
				Thread.sleep(intervalTime * 1000);//暂停设定的轮询间隔时间
				
				if(DateUtil.currentDate().after(MARKET_FEEDBACK_entTime)){//若当前系统时间大于轮询结束时间，则跳出循环
					execute = false;
				}
			}
			//设置为调用成功
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
			isSuccess = false;
		} 
		LogUtil.logInfo(DateUtil.currentDateTimeString()+"  执行状态更新结束!!!",null);
		return isSuccess;
	}
	/**
	 * 手动定时器结束时间(执行银行间成交反馈定时器)
	 * @author 杨敏
	 */
	@Bizlet("")
	public static boolean closeBankFeedbackStatus(){
		MARKET_FEEDBACK_entTime = DateUtil.getNow();
		LogUtil.logInfo(DateUtil.currentDateTimeString()+"  手动关闭执行定时器功能，结束时间："+MARKET_FEEDBACK_entTime,null);
		return true;
	}
	/**
	 * 判断定时器是否处于执行状态
	 * @author 杨敏
	 */
	@Bizlet("判断定时器是否处于执行状态")
	public static boolean getTaskFeedbackStatus(){
		Date stem = DateUtil.getNow();
		//Date taskEntTime = InterBankFeedback.getTaskEntTime();
		if(taskEntTime==null){
			//还未启动过
			return false;
		}
		Long between = (stem.getTime() - taskEntTime.getTime())/1000;
		//时间间隔大于 定时器频率，则定时器异常了
		if(between-frequencyTime>0){
			return false;
		}else{
			//小于这定时器正常执行
			return true;
		}
	}
}
