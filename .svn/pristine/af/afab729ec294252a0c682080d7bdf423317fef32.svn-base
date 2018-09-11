/**
 * 
 */
package com.cjhxfund.ats.sm.comm;

import java.sql.Connection;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.ParamConfig;
import com.cjhxfund.commonUtil.QrtzUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.eoscommon.CacheUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * @author 陈迪
 * @date 2016-12-19 15:14:58
 *
 */
@Bizlet("")
public class TimerManage {
	
	/**完整类名*/
	private static final String className=Thread.currentThread().getStackTrace()[1].getClassName();
	
	private static final Log log = LogFactory.getLog(TimerManage.class);
	/** 定时器结束时间参考key：ATS_TIMER_END_TIME */
	public static String ENDTIME_PARAM_KEY = "ATS_TIMER_END_TIME";
	/** 定时器轮询间隔参考key：ATS_TIMER_POLLING_INTERVAL */
	public static String POLLING_INTERVAL_PARAM_KEY = "ATS_TIMER_POLLING_INTERVAL";
	
	// 手动定时器结束时间(执行O32前台成交状态自动更新)
	private static Date entTime_updateIriAndFstWhenFs = null;
	// 手动定时器结束时间(执行指令信息更新定时器)
	private static Date entTime_instructStatusUpdateInterval = null;
	// 手动定时器结束时间(update风控审批状态)
	private static Date entTime_updateRiskApproveStatus = null; 
	// 手动定时器结束时间(执行定时器，每天早上检查到期结算日（扫描债券锁定表）为当天的数据，然后进行把锁定券信息全部解锁)
	private static Date entTime_unLockBondTask = null; 
	// 手动定时器结束时间(执行定时器，每天早上扫描下一天为到期结算日的可用数量不足的数据，然后邮件提醒相关人员)
	private static Date entTime_availQtyEmailRemindTask = null; 
	// 上清中债excel程序下载故障提醒
	private static Date entTime_excelDataDownLoadRemindTask = null;
	//上清后台状态更新任务
	private static Date entTime_sqBsUpdateTask = null;
	
	/**
	 * 执行O32前台成交状态自动更新
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取系统参数（ATS_TIMER_POLLING_INTERVAL）默认配置间隔
	 * @param pEndTime 轮询结束时间，为空或格式错误时取系统参数（ATS_TIMER_END_TIME）默认配置时间
	 * @return
	 * @author chendi
	 */
	@Bizlet("获取O32前台成交数据、锁定券自动加锁功能定时器管理")
	public static boolean updateIriAndFstWhenFs(String pIntervalTime, String pEndTime){
		System.out.println(DateUtil.currentDateTimeString()+"  执行O32指令前台成交数据自动更新开始...");
		//是否调用成功
		boolean isSuccess = false;
		Connection conn = null;
		boolean execute = true;
		try {
			//获取轮询间隔时间，为空或格式错误时取默认3分钟
			int intervalTime = Integer.parseInt(ParamConfig.getValue(TimerManage.POLLING_INTERVAL_PARAM_KEY));
			if(StringUtils.isNotBlank(pIntervalTime)){
				try {
					intervalTime = Integer.valueOf(pIntervalTime.trim());
				} catch (NumberFormatException e) {
					LogUtil.logError("FundSetmtTraceManager.fundSetmtTracewhenFs fail: 轮询间隔时间格式错误，取默认"+intervalTime+"分钟！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询间隔时间为空，取默认"+intervalTime+"分钟！", null, new Object[]{});
			}
			//获取轮询结束时间，为空或格式错误时取默认17:00
			String date = DateUtil.currentDateDefaultString();
			String endTime = ParamConfig.getValue(TimerManage.ENDTIME_PARAM_KEY);
			entTime_updateIriAndFstWhenFs = DateUtil.parse(date+" "+endTime, DateUtil.YMDHMS_PATTERN);
			if(StringUtils.isNotBlank(pEndTime)){
				try {
					entTime_updateIriAndFstWhenFs = DateUtil.parse(date+" "+pEndTime.trim()+":00", DateUtil.YMDHMS_PATTERN);
				} catch (Exception e) {
					LogUtil.logError("FundSetmtTraceManager.fundSetmtTracewhenFs fail: 轮询结束时间格式错误，取默认"+endTime+"！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询结束时间为空，取默认"+endTime+"！", null, new Object[]{});
			}
			
			//循环执行
			while(execute){
				System.out.println(DateUtil.currentDateTimeString()+"  fundSetmtTracewhenFs begin ...");
				try {

					Long beforeTime=(new Date()).getTime();
					/***业务调用开始***/
					Object[] ob = new Object[]{};
        			String componentName = "com.cjhxfund.ats.sm.comm.FundSetmtTraceManager";
                	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
					logicComponent.invoke("updateFundSetmtTraceWhenFs",ob);
					/***业务调用结束***/

					Long afterTime=(new Date()).getTime();
					String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
					QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
				} catch (Throwable e) {
					e.printStackTrace();
				} finally {
					JDBCUtil.releaseResource(conn, null, null);
				}
				System.out.println(DateUtil.currentDateTimeString()+"  fundSetmtTracewhenFs end !!!");
				Thread.sleep(intervalTime * 60000);//暂停设定的轮询间隔时间

				if(DateUtil.currentDate().after(entTime_updateIriAndFstWhenFs)){//若当前系统时间大于轮询结束时间，则跳出循环
					execute = false;
				}
			}
			//设置为调用成功
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		System.out.println(DateUtil.currentDateTimeString()+"  执行O32指令前台成交数据自动更新结束!!!");
		return isSuccess;
	}
	
	/**
	 * 执行指令信息更新定时器
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取系统参数（ATS_TIMER_POLLING_INTERVAL）默认配置间隔
	 * @param pEndTime 轮询结束时间，为空或格式错误时取系统参数（ATS_TIMER_END_TIME）默认配置时间
	 * @return
	 * @author zhanglu
	 */
	@Bizlet("指令信息更新")
	public static boolean instructStatusUpdateInterval(String pIntervalTime, String pEndTime){
		System.out.println(DateUtil.currentDateTimeString()+"  执行更新指令信息开始...");
		//是否调用成功
		boolean isSuccess = false;
		Connection conn = null;
		boolean execute = true;
		try {
			//获取轮询间隔时间，为空或格式错误时取默认3分钟
			int intervalTime = Integer.parseInt(ParamConfig.getValue(TimerManage.POLLING_INTERVAL_PARAM_KEY));
			if(StringUtils.isNotBlank(pIntervalTime)){
				try {
					intervalTime = Integer.valueOf(pIntervalTime.trim());
				} catch (NumberFormatException e) {
					LogUtil.logError("FundSetmtTraceManager.instructStatusUpdateInterval fail: 轮询间隔时间格式错误，取默认"+intervalTime+"分钟！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询间隔时间为空，取默认"+intervalTime+"分钟！", null, new Object[]{});
			}
			
			//获取轮询结束时间，为空或格式错误时取默认17:00
			String date = DateUtil.currentDateDefaultString();
			String endTime = ParamConfig.getValue(TimerManage.ENDTIME_PARAM_KEY);
			entTime_instructStatusUpdateInterval = DateUtil.parse(date+" "+endTime, DateUtil.YMDHMS_PATTERN);
			if(StringUtils.isNotBlank(pEndTime)){
				try {
					entTime_instructStatusUpdateInterval = DateUtil.parse(date+" "+pEndTime.trim()+":00", DateUtil.YMDHMS_PATTERN);
				} catch (Exception e) {
					LogUtil.logError("FundSetmtTraceManager.instructStatusUpdateInterval fail: 轮询结束时间格式错误，取默认"+endTime+"！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询结束时间为空，取默认"+endTime+"！", null, new Object[]{});
			}
			
			//循环执行
			while(execute){
				System.out.println(DateUtil.currentDateTimeString()+"  instructStatusUpdateInterval begin ...");
				try {

					Long beforeTime=(new Date()).getTime();
					/***业务调用开始***/
					Object[] ob = new Object[]{};
        			String componentName = "com.cjhxfund.ats.sm.comm.FundSetmtTraceManager";
                	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
					logicComponent.invoke("updateResultInstructAndProcessWhenFs",ob);
					/***业务调用结束***/

					Long afterTime=(new Date()).getTime();
					String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
					QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
				} catch (Throwable e) {
					e.printStackTrace();
				} finally {
					JDBCUtil.releaseResource(conn, null, null);
				}
				System.out.println(DateUtil.currentDateTimeString()+"  instructStatusUpdateInterval end !!!");
				Thread.sleep(intervalTime * 60000);//暂停设定的轮询间隔时间

				if(DateUtil.currentDate().after(entTime_instructStatusUpdateInterval)){//若当前系统时间大于轮询结束时间，则跳出循环
					execute = false;
				}
			}
			//设置为调用成功
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		System.out.println(DateUtil.currentDateTimeString()+"  执行更新指令信息结束!!!");
		return isSuccess;
	}
	/**
	 * update风控审批状态
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取系统参数（ATS_TIMER_POLLING_INTERVAL）默认配置间隔
	 * @param pEndTime 轮询结束时间，为空或格式错误时取系统参数（ATS_TIMER_END_TIME）默认配置时间
	 * @return
	 * @author chendi
	 */
	@Bizlet("update风控审批状态")
	public static boolean updateRiskApproveStatus(String pIntervalTime, String pEndTime){
		System.out.println(DateUtil.currentDateTimeString()+"  执行风控审批状态定时器开始...");
		//是否调用成功
		boolean isSuccess = false;
		Connection conn = null;
		boolean execute = true;
		try {
			//获取轮询间隔时间，为空或格式错误时取默认3分钟
			int intervalTime = Integer.parseInt(ParamConfig.getValue(TimerManage.POLLING_INTERVAL_PARAM_KEY));
			if(StringUtils.isNotBlank(pIntervalTime)){
				try {
					intervalTime = Integer.valueOf(pIntervalTime.trim());
				} catch (NumberFormatException e) {
					LogUtil.logError("FundSetmtTraceManager.updateRiskApproveStatus fail: 轮询间隔时间格式错误，取默认"+intervalTime+"分钟！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询间隔时间为空，取默认"+intervalTime+"分钟！", null, new Object[]{});
			}
			
			//获取轮询结束时间，为空或格式错误时取默认17:00
			String date = DateUtil.currentDateDefaultString();
			String endTime = ParamConfig.getValue(TimerManage.ENDTIME_PARAM_KEY);
			entTime_updateRiskApproveStatus = DateUtil.parse(date+" "+endTime, DateUtil.YMDHMS_PATTERN);
			if(StringUtils.isNotBlank(pEndTime)){
				try {
					entTime_updateRiskApproveStatus = DateUtil.parse(date+" "+pEndTime.trim()+":00", DateUtil.YMDHMS_PATTERN);
				} catch (Exception e) {
					LogUtil.logError("FundSetmtTraceManager.updateRiskApproveStatus fail: 轮询结束时间格式错误，取默认"+endTime+"！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询结束时间为空，取默认"+endTime+"！", null, new Object[]{});
			}
			
			//循环执行
			while(execute){
				System.out.println(DateUtil.currentDateTimeString()+"  updateRiskApproveStatus begin ...");
				try {
					
					Long beforeTime=(new Date()).getTime();
					
					/***业务调用开始***/
					Object[] ob = new Object[]{};
        			String componentName = "com.cjhxfund.ats.sm.comm.InstructionManager";
                	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
					logicComponent.invoke("riskApprove",ob);
					/***业务调用结束***/

					Long afterTime=(new Date()).getTime();
					String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
					QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
				} catch (Throwable e) {
					e.printStackTrace();
				} finally {
					JDBCUtil.releaseResource(conn, null, null);
				}
				System.out.println(DateUtil.currentDateTimeString()+"  updateRiskApproveStatus end !!!");
				Thread.sleep(intervalTime * 60000);//暂停设定的轮询间隔时间
				if(DateUtil.currentDate().after(entTime_updateRiskApproveStatus)){//若当前系统时间大于轮询结束时间，则跳出循环
					execute = false;
				}
			}
			//设置为调用成功
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		System.out.println(DateUtil.currentDateTimeString()+"  执行风控审批状态定时器结束!!!");
		return isSuccess;
	}
	
	/**
	 * 上清中债excel程序下载故障提醒
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取系统参数（ATS_TIMER_POLLING_INTERVAL）默认配置间隔
	 * @param pEndTime 轮询结束时间，为空或格式错误时取系统参数（ATS_TIMER_END_TIME）默认配置时间
	 * @return
	 * @author chendi
	 */
	@Bizlet("上清中债excel程序下载故障提醒")
	public static boolean excelDataDownLoadRemindTask(String pIntervalTime, String pEndTime){
		System.out.println(DateUtil.currentDateTimeString()+"  上清中债excel程序下载故障提醒开始...");
		//是否调用成功
		boolean isSuccess = false;
		Connection conn = null;
		boolean execute = true;
		try {
			//获取轮询间隔时间，为空或格式错误时取默认3分钟
			int intervalTime = Integer.parseInt(ParamConfig.getValue(TimerManage.POLLING_INTERVAL_PARAM_KEY));
			if(StringUtils.isNotBlank(pIntervalTime)){
				try {
					intervalTime = Integer.valueOf(pIntervalTime.trim());
				} catch (NumberFormatException e) {
					LogUtil.logError("MessageService.excelDataDownLoadRemindTask fail: 轮询间隔时间格式错误，取默认"+intervalTime+"分钟！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询间隔时间为空，取默认"+intervalTime+"分钟！", null, new Object[]{});
			}
			
			//获取轮询结束时间，为空或格式错误时取默认17:00
			String date = DateUtil.currentDateDefaultString();
			String endTime = ParamConfig.getValue(TimerManage.ENDTIME_PARAM_KEY);
			entTime_excelDataDownLoadRemindTask = DateUtil.parse(date+" "+endTime, DateUtil.YMDHMS_PATTERN);
			if(StringUtils.isNotBlank(pEndTime)){
				try {
					entTime_excelDataDownLoadRemindTask = DateUtil.parse(date+" "+pEndTime.trim()+":00", DateUtil.YMDHMS_PATTERN);
				} catch (Exception e) {
					LogUtil.logError("MessageService.excelDataDownLoadRemindTask fail: 轮询结束时间格式错误，取默认"+endTime+"！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询结束时间为空，取默认"+endTime+"！", null, new Object[]{});
			}
			
			//循环执行
			while(execute){
				System.out.println(DateUtil.currentDateTimeString()+"  excelDataDownLoadRemindTask begin ...");
				try {

					Long beforeTime=(new Date()).getTime();
					
					/***业务调用开始***/
					Object[] ob = new Object[]{};
        			String componentName = "com.cjhxfund.commonUtil.MessageService";
                	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
					logicComponent.invoke("excelDataDownLoadRemind",ob);
					/***业务调用结束***/

					Long afterTime=(new Date()).getTime();
					String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
					QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
					
				} catch (Throwable e) {
					LogUtil.logError("MessageService.excelDataDownLoadRemindTask fail: 调用逻辑流出现异常！", e, new Object[]{});
				} finally {
					JDBCUtil.releaseResource(conn, null, null);
				}
				System.out.println(DateUtil.currentDateTimeString()+"  excelDataDownLoadRemindTask end !!!");
				Thread.sleep(intervalTime * 60000);//暂停设定的轮询间隔时间
				if(DateUtil.currentDate().after(entTime_excelDataDownLoadRemindTask)){//若当前系统时间大于轮询结束时间，则跳出循环
					execute = false;
				}
			}
			//设置为调用成功
			isSuccess = true;
		} catch (Exception e) {
			LogUtil.logError("上清中债excel程序下载故障提醒出现异常！", e, new Object[]{});
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		System.out.println(DateUtil.currentDateTimeString()+"  上清中债excel程序下载故障提醒结束!!!");
		return isSuccess;
	}
	/**
	 * 上清后台状态更新任务(二级债)
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取系统参数（ATS_TIMER_POLLING_INTERVAL）默认配置间隔
	 * @param pEndTime 轮询结束时间，为空或格式错误时取系统参数（ATS_TIMER_END_TIME）默认配置时间
	 * @return
	 * @author chendi
	 */
	@Bizlet("二级债上清后台状态更新任务")
	public static boolean sqNewInterfaceForSmTask(String pIntervalTime, String pEndTime){
		System.out.println(DateUtil.currentDateTimeString()+"  二级债上清后台状态更新任务开始...");
		//是否调用成功
		boolean isSuccess = false;
		Connection conn = null;
		boolean execute = true;
		try {
			//获取轮询间隔时间，为空或格式错误时取默认3分钟
			int intervalTime = Integer.parseInt(ParamConfig.getValue(TimerManage.POLLING_INTERVAL_PARAM_KEY));
			if(StringUtils.isNotBlank(pIntervalTime)){
				try {
					intervalTime = Integer.valueOf(pIntervalTime.trim());
				} catch (NumberFormatException e) {
					LogUtil.logError("BackStageTrader.dealO32SqsDatas fail: 轮询间隔时间格式错误，取默认"+intervalTime+"分钟！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询间隔时间为空，取默认"+intervalTime+"分钟！", null, new Object[]{});
			}
			
			//获取轮询结束时间，为空或格式错误时取默认17:00
			String date = DateUtil.currentDateDefaultString();
			String endTime = ParamConfig.getValue(TimerManage.ENDTIME_PARAM_KEY);
			entTime_sqBsUpdateTask = DateUtil.parse(date+" "+endTime, DateUtil.YMDHMS_PATTERN);
			if(StringUtils.isNotBlank(pEndTime)){
				try {
					entTime_sqBsUpdateTask = DateUtil.parse(date+" "+pEndTime.trim()+":00", DateUtil.YMDHMS_PATTERN);
				} catch (Exception e) {
					LogUtil.logError("BackStageTrader.dealO32SqsDatas fail: 轮询结束时间格式错误，取默认"+endTime+"！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询结束时间为空，取默认"+endTime+"！", null, new Object[]{});
			}
			
			//循环执行
			while(execute){
				System.out.println(DateUtil.currentDateTimeString()+"--二级债--dealO32SqsDatas begin ...");
				try {

					Long beforeTime=(new Date()).getTime();
					
					/***业务调用开始***/
					Object[] ob = new Object[]{};
        			String componentName = "com.cjhxfund.ats.sm.comm.BackStageTrader";
                	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
					logicComponent.invoke("dealO32SqsDatas",ob);
					/***业务调用结束***/

					Long afterTime=(new Date()).getTime();
					String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
					QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
					
				} catch (Throwable e) {
					e.printStackTrace();
				} finally {
					JDBCUtil.releaseResource(conn, null, null);
				}
				System.out.println(DateUtil.currentDateTimeString()+"--二级债--dealO32SqsDatas end !!!");
				Thread.sleep(intervalTime * 60000);//暂停设定的轮询间隔时间
				if(DateUtil.currentDate().after(entTime_sqBsUpdateTask)){//若当前系统时间大于轮询结束时间，则跳出循环
					execute = false;
				}
			}
			//设置为调用成功
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		System.out.println(DateUtil.currentDateTimeString()+"  二级债上清后台状态更新任务结束!!!");
		return isSuccess;
	}
	/**
	 * 执行定时器，每天早上检查到期结算日（扫描债券锁定表）为当天的数据，然后进行把锁定券信息全部解锁
	 * @return
	 * @author chendi
	 */
	@Bizlet("系统自动解锁锁定券任务")
	public static boolean unLockBondTask(){
		System.out.println(DateUtil.currentDateTimeString()+" unLockBondTask begin...");
		//是否调用成功
		boolean isSuccess = true;
		Connection conn = null;
			try {
				System.out.println(DateUtil.currentDateTimeString()+" unLockBondTask invoke autoUnLockBondsBySystem.bizx begin...");
				Long beforeTime=(new Date()).getTime();
				
				Object[] ob = new Object[]{};
				String componentName = "com.cjhxfund.ats.sm.comm.TBondLockInfoManager";
	        	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
				logicComponent.invoke("autoUnLockBondsBySystem",ob);
				
				Long afterTime=(new Date()).getTime();
				String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
				QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
				
				System.out.println(DateUtil.currentDateTimeString()+" unLockBondTask invoke autoUnLockBondsBySystem.bizx end and success...");
			} catch (Throwable e) {
				//设置为调用成功
				isSuccess = false;
				System.out.println(DateUtil.currentDateTimeString()+" unLockBondTask invoke autoUnLockBondsBySystem.bizx end but failed...");
				e.printStackTrace();
			} finally {
				JDBCUtil.releaseResource(conn, null, null);
			}
		System.out.println(DateUtil.currentDateTimeString()+" unLockBondTask end...");
		return isSuccess;
	}
	
	/**
	 * 执行定时器，每天早上检查交易日已过而未前台成交的指令数据
	 * @return
	 * @author 刘玉龙
	 */
	@Bizlet("系统自动将逾期未成交数据进行过期处理")
	public static boolean archiveProcessTask(){
		System.out.println(DateUtil.currentDateTimeString()+" archivingProcessing begin...");
		//是否调用成功
		boolean isSuccess = true;
		Connection conn = null;
			try {
				System.out.println(DateUtil.currentDateTimeString()+" archivingProcessing invoke overdueInstructHandle.bizx begin...");
				Long beforeTime=(new Date()).getTime();
				
				Object[] ob = new Object[]{};
				String componentName = "com.cjhxfund.ats.sm.comm.DailyManager";
	        	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
				logicComponent.invoke("overdueInstructHandle",ob);
				//更新交收跟踪表状态
				String setmtComponentName = "com.cjhxfund.ats.sm.comm.DailyManager";
	        	ILogicComponent setmtLogicComponent = LogicComponentFactory.create(setmtComponentName);
	        	setmtLogicComponent.invoke("overdueSetmtTraceHandle",ob);
	        	
	        	Long afterTime=(new Date()).getTime();
				String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
				QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
				
				System.out.println(DateUtil.currentDateTimeString()+" archivingProcessing invoke overdueSetmtTraceHandle.bizx end and success...");
			} catch (Throwable e) {
				//设置为调用成功
				isSuccess = false;
				System.out.println(DateUtil.currentDateTimeString()+" archivingProcessing invoke overdueInstructHandle.bizx end but failed...");
				e.printStackTrace();
			} finally {
				JDBCUtil.releaseResource(conn, null, null);
			}
		System.out.println(DateUtil.currentDateTimeString()+" overdueInstructHandle end...");
		return isSuccess;
	}
	
	
	/**
	 * 执行定时器，每天早上获取O32初始资金信息
	 * @return
	 * @author 刘玉龙
	 */
	@Bizlet("系统日初自动更新产品头寸缺口信息")
	public static boolean dailyFinanceGapInitializeTask(){
		boolean isSuccess = true;
		Connection conn = null;
			try {
				System.out.println(DateUtil.currentDateTimeString()+" dailyFinanceGapInitializeTask invoke initialPositionGap.bizx begin...");
				Long beforeTime=(new Date()).getTime();
				
				Object[] ob = new Object[]{};
				String componentName = "com.cjhxfund.ats.sm.inquiry.financeGapManage";
	        	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
				logicComponent.invoke("initialPositionGap",ob);
				
				Long afterTime=(new Date()).getTime();
				String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
				QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
				
				System.out.println(DateUtil.currentDateTimeString()+" dailyFinanceGapInitializeTask invoke initialPositionGap.bizx end and success...");
			} catch (Throwable e) {
				//设置为调用成功
				isSuccess = false;
				System.out.println(DateUtil.currentDateTimeString()+" dailyFinanceGapInitializeTask invoke initialPositionGap.bizx end but failed...");
				e.printStackTrace();
			} finally {
				JDBCUtil.releaseResource(conn, null, null);
			}
		return isSuccess;
	}
	
	/**
	 * 执行定时器，每天早上检查交易日为当天的停留在预置指令待确认环节的有效指令，并激活指令流程
	 * @return
	 * @author liuyulong
	 */
	@Bizlet("系统自动激活交易日为当天的预置指令")
	public static boolean activePresetInstructTask(){
		System.out.println(DateUtil.currentDateTimeString()+" activePresetInstructTask begin...");
		//是否调用成功
		boolean isSuccess = true;
		Connection conn = null;
			try {
				System.out.println(DateUtil.currentDateTimeString()+" activePresetInstructTask invoke presetInstructAutoConfirm.bizx begin...");
				Long beforeTime=(new Date()).getTime();
				
				Object[] ob = new Object[]{};
				String componentName = "com.cjhxfund.ats.sm.comm.InstructionManager";
	        	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
				logicComponent.invoke("presetInstructAutoConfirm",ob);
				
				Long afterTime=(new Date()).getTime();
				String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
				QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
				
				System.out.println(DateUtil.currentDateTimeString()+" activePresetInstructTask invoke presetInstructAutoConfirm.bizx end and success...");
			} catch (Throwable e) {
				//设置为调用成功
				isSuccess = false;
				System.out.println(DateUtil.currentDateTimeString()+" activePresetInstructTask invoke presetInstructAutoConfirm.bizx end but failed...");
				e.printStackTrace();
			} finally {
				JDBCUtil.releaseResource(conn, null, null);
			}
		System.out.println(DateUtil.currentDateTimeString()+" activePresetInstructTask end...");
		return isSuccess;
	}
	
	
	/**
	 * 执行定时器，每天早上9:15查询从WIND同步到ISP下对应的表的数据，
	 * 然后按当天为招股日启动流程
	 * @return
	 * @author houzhiyong
	 */
	@Bizlet("系统自动启动新股任务")
	public static boolean autoStartIpoProcessTask(){
		System.out.println(DateUtil.currentDateTimeString()+" autoStartIpoProcessTask begin...");
		//是否调用成功
		boolean isSuccess = true;
		Connection conn = null;
			try {
				System.out.println(DateUtil.currentDateTimeString()+" autoStartIpoProcessTask invoke autoStartIpoProcess.bizx begin...");
				Long beforeTime=(new Date()).getTime();
				
				Object[] ob = new Object[]{};
				String componentName = "com.cjhxfund.ats.ipo.task";
	        	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
				logicComponent.invoke("autoStartIpoProcess",ob);
				
				Long afterTime=(new Date()).getTime();
				String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
				QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
				
				System.out.println(DateUtil.currentDateTimeString()+" autoStartIpoProcessTask invoke autoStartIpoProcess.bizx end and success...");
			} catch (Throwable e) {
				//设置为调用成功
				isSuccess = false;
				System.out.println(DateUtil.currentDateTimeString()+" autoStartIpoProcessTask invoke autoStartIpoProcess.bizx end but failed...");
				e.printStackTrace();
			} finally {
				JDBCUtil.releaseResource(conn, null, null);
			}
		System.out.println(DateUtil.currentDateTimeString()+" autoStartIpoProcessTask end...");
		return isSuccess;
	}
	/**
	 * 执行定时器，每天早上9:15查询从WIND同步到ISP下对应的表的数据，
	 * 然后按当天为招股日启动流程。按照一定的频率打印一条日志确定定时器的活动性。
	 * @return
	 * @author zhoulin
	 */
	public static void startIPOtask(){
		System.out.println(DateUtil.currentDateTimeString()+" startIPOtask begin...");
		// 当天的定时任务是否已经正确执行
		boolean isSuccess = false;
		// 获取业务逻辑执行时间
		DataObject cachedTaskTime = (DataObject)CacheUtil.getValue("ReloadParamConf1", "ATS_IPO_START_TIME");
		int taskTime = Integer.parseInt(cachedTaskTime.getString("paramValue").trim());
		while (true) {
			// 获取当前时间
			int now = DateUtil.currentTimeInt();
			if (now >= taskTime && !isSuccess) {
				// 执行任务主体
				try {
					System.out.println(DateUtil.currentDateTimeString()+" startIPOtask invoke autoStartIpoProcess.bizx begin...");
					Long beforeTime=(new Date()).getTime();
					
					Object[] ob = new Object[]{};
					String componentName = "com.cjhxfund.ats.ipo.task";
		        	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
					logicComponent.invoke("autoStartIpoProcess",ob);
					isSuccess = true;
					
					Long afterTime=(new Date()).getTime();
					String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
					QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
					
					System.out.println(DateUtil.currentDateTimeString()+" startIPOtask invoke autoStartIpoProcess.bizx end and success...");
				} catch (Throwable e) {
					isSuccess = false;
					System.out.println(DateUtil.currentDateTimeString()+" startIPOtask invoke autoStartIpoProcess.bizx end but failed...");
					e.printStackTrace();
				}
			} else {
				try {
					System.out.println((DateUtil.currentDateTimeString()+" startIPOtask is sleeping..."));
					if(now>taskTime-1500&&now < taskTime+1500){
						Thread.sleep(1 * 60 * 1000);
					}else{
						Thread.sleep(5 * 60 * 1000);
					}
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			if(now>=170000){
				System.out.println(DateUtil.currentDateTimeString()+" startIPOtask end...");
				break;
			}
		}
	}
	
	
	
	/**
	 * 执行定时器，每天早上扫描下一天为到期结算日的可用数量不足的数据，然后邮件提醒相关人员
	 * @return
	 * @author chendi
	 */
	@Bizlet("可用数量不足邮件提醒任务")
	public static boolean availQtyEmailRemindTask(){
		System.out.println(DateUtil.currentDateTimeString()+" availQtyEmailRemindTask begin...");
		//创建可用对象
		AvailableDataManager availData = new AvailableDataManager();
		//是否调用成功
		boolean isSuccess = true;
		Connection conn = null;
		try {
			log.info(DateUtil.currentDateTimeString()+" availQtyEmailRemindTask invoke availData.sendEmailForAvailQty begin...");
			Long beforeTime=(new Date()).getTime();
			
			//调用可用数量不足发送邮件方法
			availData.sendEmailForAvailQty();
			
			Long afterTime=(new Date()).getTime();
			String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
			QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
			
			log.info(DateUtil.currentDateTimeString()+" availQtyEmailRemindTask invoke availData.sendEmailForAvailQty end...");
		} catch (Exception e) {
			//失败
			isSuccess = false;
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		System.out.println(DateUtil.currentDateTimeString()+" availQtyEmailRemindTask end...");
		return isSuccess;
	}
	
	/**
	 * 每天早上8点定时统计前一天业务使用统计
	 * @author chendi
	 */
	@Bizlet("定时统计前一天业务使用统计")
	public static boolean bizOperateCountTask(){
		System.out.println(DateUtil.currentDateTimeString()+"  bizOperateCountTask begin...");
		//是否调用成功
		boolean isSuccess = true;
		Connection conn = null;
		try{
			System.out.println(DateUtil.currentDateTimeString()+"  saveBizOperateCount.bizx start...");
			Long beforeTime=(new Date()).getTime();
			
			Object[] param = new Object[]{};
			String componentCount = "com.cjhxfund.commonUtil.userOperatorManager";
        	ILogicComponent logicComponent = LogicComponentFactory.create(componentCount);
        	Object[] result = logicComponent.invoke("saveBizOperateCount",param);
        	
        	Long afterTime=(new Date()).getTime();
			String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
			QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
			
    		if("0".equals(result[0])){
    			System.out.println(DateUtil.currentDateTimeString()+" bizOperateCountTask invoke saveBizOperateCount.bizx end and success...");
    		}else{
    			//调用失败
    			isSuccess = false;
    			System.out.println(DateUtil.currentDateTimeString()+" bizOperateCountTask invoke saveBizOperateCount.bizx end but failed...");
    		}
		} catch (Throwable e) {
			e.printStackTrace();
			//调用失败
			isSuccess = false;
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		System.out.println(DateUtil.currentDateTimeString()+"  bizOperateCountTask end...");
		return isSuccess;
	}
	
	/**
	 * 执行定时器，每天早上8:30查询已完成的到期指令添加到投顾与交易员（投顾录入与交易录单确认）提醒列表
	 * 
	 * @return
	 * @author 刘玉龙
	 */
	@Bizlet("回购业务到期提醒")
	public static boolean instructMatureRemind(){
		System.out.println(DateUtil.currentDateTimeString()+" instructMatureRemind begin...");
		//是否调用成功
		boolean isSuccess = true;
		Connection conn = null;
			try {
				System.out.println(DateUtil.currentDateTimeString()+" instructMatureRemind invoke hgInstructMatureRemind.bizx begin...");
				Long beforeTime=(new Date()).getTime();
				
				Object[] ob = new Object[]{};
				String componentName = "com.cjhxfund.ats.sm.comm.RemindManager";
	        	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
				logicComponent.invoke("hgInstructMatureRemind",ob);
				
				Long afterTime=(new Date()).getTime();
				String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
				QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
				
				System.out.println(DateUtil.currentDateTimeString()+" instructMatureRemind invoke hgInstructMatureRemind.bizx end and success...");
			} catch (Throwable e) {
				//设置为调用成功
				isSuccess = false;
				System.out.println(DateUtil.currentDateTimeString()+" instructMatureRemind invoke hgInstructMatureRemind.bizx end but failed...");
				e.printStackTrace();
			} finally {
				JDBCUtil.releaseResource(conn, null, null);
			}
		System.out.println(DateUtil.currentDateTimeString()+" instructMatureRemind end...");
		return isSuccess;
	}
	
	
	/**
	 * 手动定时器结束时间(执行O32前台成交状态自动更新)
	 * @author 童伟
	 */
	@Bizlet("")
	public static boolean closeUpdateIriAndFstWhenFs(){
		entTime_updateIriAndFstWhenFs = DateUtil.getNow();
		System.out.println(DateUtil.currentDateTimeString()+"  手动关闭执行定时器功能，结束时间："+entTime_updateIriAndFstWhenFs);
		return true;
	}
	/**
	 * 手动定时器结束时间(执行O32前台成交状态自动更新)
	 * @author 童伟
	 */
	@Bizlet("")
	public static boolean closeinstructStatusUpdateInterval(){
		entTime_instructStatusUpdateInterval = DateUtil.getNow();
		System.out.println(DateUtil.currentDateTimeString()+"  手动关闭执行定时器功能，结束时间："+entTime_instructStatusUpdateInterval);
		return true;
	}
	
	/**
	 * 手动定时器结束时间(update风控审批状态)
	 * @author 童伟
	 */
	@Bizlet("")
	public static boolean closeUpdateRiskApproveStatus(){
		entTime_updateRiskApproveStatus = DateUtil.getNow();
		System.out.println(DateUtil.currentDateTimeString()+"  手动关闭执行定时器功能，结束时间："+entTime_updateRiskApproveStatus);
		return true;
	}
	
	/**
	 * 手动定时器结束时间(执行定时器，每天早上检查到期结算日（扫描债券锁定表）为当天的数据，然后进行把锁定券信息全部解锁)
	 * @author 童伟
	 */
	@Bizlet("")
	public static boolean closeUnLockBondTask(){
		entTime_unLockBondTask = DateUtil.getNow();
		System.out.println(DateUtil.currentDateTimeString()+"  手动关闭执行定时器功能，结束时间："+entTime_unLockBondTask);
		return true;
	}
	
	/**
	 * 手动定时器结束时间(执行定时器，每天早上扫描下一天为到期结算日的可用数量不足的数据，然后邮件提醒相关人员)
	 * @author 童伟
	 */
	@Bizlet("")
	public static boolean closeAvailQtyEmailRemindTask(){
		entTime_availQtyEmailRemindTask = DateUtil.getNow();
		System.out.println(DateUtil.currentDateTimeString()+"  手动关闭执行定时器功能，结束时间："+entTime_availQtyEmailRemindTask);
		return true;
	}
	
	/**
	 * 手动定时器结束时间(上清中债excel程序下载故障提醒)
	 * @author 陈迪
	 */
	@Bizlet("")
	public static boolean closeExcelDataDownLoadRemindTask(){
		entTime_excelDataDownLoadRemindTask = DateUtil.getNow();
		System.out.println(DateUtil.currentDateTimeString()+"  手动关闭执行定时器功能，结束时间："+entTime_excelDataDownLoadRemindTask);
		return true;
	}
	
	/**
	 * 手动定时器结束时间(上清接口)
	 * @author 陈迪
	 */
	@Bizlet("")
	public static boolean closeSqNewInterfaceForSmTask(){
		entTime_sqBsUpdateTask = DateUtil.getNow();
		System.out.println(DateUtil.currentDateTimeString()+"  手动关闭执行定时器功能，结束时间："+entTime_sqBsUpdateTask);
		return true;
	}
	
}
