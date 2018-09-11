/**
 * 
 */
package com.cjhxfund.ats.qrtz;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cjhxfund.commonUtil.DateUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.common.schedule.impl.base.BaseTaskDetail;
import com.primeton.ext.common.schedule.ScheduleManager;

import commonj.sdo.DataObject;

/**
 * @author 武正新
 * @date 2017-12-07 14:20:53
 * 
 */
@Bizlet("定时器监控")
public class QrtzMoniteHandler {

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Bizlet("处理数据")
	public DataObject[] handleData(DataObject[] qrtzs) throws Exception {

		List<DataObject> normalQrtzs = new ArrayList<DataObject>();// 正常定时器
		List<DataObject> unnormalQrtzs = new ArrayList<DataObject>();// 异常定时器
		String autoRecoveryFlag = getQrtzAtuoRecoveryFlag();// 查询自动恢复配置，如果不是自动恢复则设置一个手动恢复标志
		for (DataObject qrtz : qrtzs) {

			qrtz.set("autoRecoveryFlag", autoRecoveryFlag);
			String jobName = qrtz.get("jobName").toString();
			Map<String, Object> map = ScheduleManager.getTaskDetail(jobName);
			if (map == null) {
				// 未生效,跳过
				continue;
			}
			Integer taskType = (Integer) map.get("taskType");
			BaseTaskDetail taskDetail = (BaseTaskDetail) map.get("taskDetail");
			qrtz.set("taskType", taskType);// 任务类型 1：SCA服务任务 2：逻辑流任务3：任意JAVA方法任务
			qrtz.set("targetName", taskDetail.getTargetName());// 目标名称,如果是java方法任务则对应类名
			qrtz.set("targetOperation", taskDetail.getTargetOperation());// 目标名称,如果是java方法任务则对应方法名
			qrtz.set("targetArgs", taskDetail.getTargetArgs());// 参数
			String prevFireTime = qrtz.getString("prevFireTime");
			List triggerList = (ArrayList) map.get("triggerList");
			// 任务已经结束则没有触发器
			if (triggerList != null && triggerList.size() > 0) {
				// TODO 这里注意，一个任务可能有多个触发器，目前都只有一个所以直接写死
				Map<String, Object> triggerMap = (Map<String, Object>) triggerList.get(0);
				String cronExpression = (String) triggerMap.get("cronExpression");
				qrtz.set("cronExpression", cronExpression);
			} else {
				// 任务已经结束
				qrtz.set("triggerState", "FINISH");
			}
			String runningStatus = getJobRunningStatus(jobName, prevFireTime);
			if ("0".equals(runningStatus)) {
				qrtz.set("runningStatus", "正常");
				normalQrtzs.add(qrtz);
			} else {
				qrtz.set("runningStatus", "未触发");
				unnormalQrtzs.add(qrtz);
			}
		}
		unnormalQrtzs.addAll(normalQrtzs);
		return (DataObject[]) unnormalQrtzs.toArray(new DataObject[qrtzs.length]);
	}

	/**
	 * 时间：时、分、秒前面补零
	 * 
	 * @param source
	 * @return
	 */
	public String addZero(String source) {

		if (source.length() < 2) {
			return "0" + source;
		} else {
			return source;
		}
	}

	/**
	 * 通过任务名称取任务的运行状态（是否正常运行）
	 * 
	 * @param jobName
	 * @return 0:正常 -1：未触发
	 */
	@Bizlet("")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String getJobRunningStatus(String jobName, String prevFireTime) {

		String flag = "0";// 返回标识，0：正常 -1：未触发
		try {
			Map<String, Object> map = ScheduleManager.getTaskDetail(jobName);
			List triggerList = (ArrayList) map.get("triggerList");
			if (triggerList != null && triggerList.size() > 0) {
				// TODO 这里注意，一个任务可能有多个触发器，目前都只有一个所以直接写死
				Map<String, Object> triggerMap = (Map<String, Object>) triggerList.get(0);
				Date startTime = (Date) triggerMap.get("startTime");// 开始时间
				Date endTime = (Date) triggerMap.get("endTime");// 结束时间
				String triggerState = String.valueOf(triggerMap.get("triggerState"));// 触发器状态,0:正常
																						// 1:暂停
																						// 其它………………
				Date today = new Date();
				Long currentTime = today.getTime();
				String overTime = getQrtzMisfiredOvertime();// 时差
				// 在运行期间内,且在运行中的定时器,endTime可为空
				if (startTime.before(today) && (endTime == null || today.before(endTime)) && !"1".equals(triggerState)) {
					// 触发器类型 SIMPLE:简单定时器(固定时刻触发 ) CRON:复杂定时器（日历周期触发）
					String triggerType = String.valueOf(triggerMap.get("triggerType"));
					// 判断不同类型的触发器触发是否正常(到时间未触发视为异常)
					if (triggerType.equals("1")) {// 对应"Simple"类型
						// 触发间
						Long repeatInterval = (Long) triggerMap.get("repeatInterval");
						// 超时未触发(因为EOS调度本身就有时差，这里加了个时差)
						if ((currentTime - Long.parseLong(prevFireTime)) > (repeatInterval + (Long.parseLong(overTime) * 1000 * 60))) {
							// if("EXECUTING".equals(checkJobActive(jobName))){
							flag = "-1";
							// }
						}
						flag = "0";// 先不监控，目前自动恢复未启用，都是手工启动，这种几分钟运行一次的定时器会不断报异常
					} else {// 对应"cron"类型
						String cronExpression = (String) triggerMap.get("cronExpression");
						String[] cronArray = cronExpression.split(" ");
						String dayOfWeek = cronArray[5];// 每周几执行
						// TODO 这里只判断“循环模式”为“每周”的定时器，因为目前的定时器都是该种,其它的日后扩展
						if (dayOfWeek.indexOf(",") != -1) {// 每个月的第几周由豆号分隔的就视为“每周”
							String week = String.valueOf(DateUtil.getWeek(today));
							String[] cronWeekArray = dayOfWeek.split(",");// 取周
							for (String weekIndex : cronWeekArray) {
								if (week.equals(weekIndex)) {// 当天是否为所在的周（如执行时间为周一到周五，当天是否在这期间内）
									String executeTime = addZero(cronArray[2]) + ":" + addZero(cronArray[1]) + ":" + addZero(cronArray[0]);
									String dateString = DateUtil.format(today, "yyyy-MM-dd");
									Date executeDateTime = DateUtil.parse(dateString + " " + executeTime, "yyyy-MM-dd HH:mm:ss");
									Long executeLongTime = executeDateTime.getTime();
									Long longOverTime = (executeLongTime + (Long.parseLong(overTime) * 1000 * 60));// 执行时间加时差
									Long diffTime = (currentTime - Long.parseLong(prevFireTime));// 上次执行时间与当前时间时差
									// 超时（当前时间大于计划执行时间且当前时间比上一次实际执行时间相差不超一天）
									if ((currentTime >= longOverTime) && (diffTime > (1000 * 60 * 60 * 24))) {
										flag = "-1";
									}
								}
							}
						}
					}
				}
			}
		} catch (Throwable e) {
			LogUtil.logError("查询定时任务运行状态出现异常:", e, new Object[] {});
			flag = "-1";// 出现异常设置运行异常
		}
		return flag;
	}

	/**
	 * 触发器在触发时会更新触发器表中的上次执行时间，如果这个时间超时即说明定时器未及时触发
	 * 
	 * @param firedTriggers
	 * @return
	 */
	@Bizlet("过滤正常任务")
	public List<DataObject> filterData(Object[] firedTriggers) {

		List<DataObject> result = new ArrayList<DataObject>();
		for (int loop = 0; loop < firedTriggers.length; loop++) {
			DataObject firedTrigger = (DataObject) firedTriggers[loop];
			Long firedTime = (Long) firedTrigger.get("prevFireTime");// 触发时间
			String jobName = String.valueOf(firedTrigger.get("jobName"));
			String runningStatus = getJobRunningStatus(jobName, String.valueOf(firedTime));
			if ("-1".equals(runningStatus)) {// 超过错失触发超时间隔，视为未触发异常
				setTriggerTime(firedTrigger, jobName);// 设置触发时间（上次触发时间、下次触发时间）
				result.add(firedTrigger);
			}
		}
		return result;
	}

	/**
	 * 设置触发器的最新触发时间
	 * 
	 * @param firedTrigger
	 * @param jobName
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Bizlet("设置触发器的最新触发时间")
	public void setTriggerTime(DataObject firedTrigger, String jobName) {
		// 设置“上次触发时间”
		Map<String, Object> map = ScheduleManager.getTaskDetail(jobName);
		List triggerList = (ArrayList) map.get("triggerList");
		Map<String, Object> triggerMap = (Map<String, Object>) triggerList.get(0);

		String triggerType = String.valueOf(triggerMap.get("triggerType"));
		// 判断不同类型的触发器触发是否正常(到时间未触发视为异常)
		if (triggerType.equals("1")) {// 对应"Simple"类型
			Date today = new Date();
			firedTrigger.set("newPrevFireTime", today.getTime());
			Long repeatInterval = (Long) triggerMap.get("repeatInterval");
			Date newNextFireTime = DateUtil.addSecond(today, repeatInterval.intValue() / 1000);
			firedTrigger.set("newNextFireTime", newNextFireTime.getTime());
		} else {// 对应"cron"类型
				// 触发时间为(当天+触发时间)
			String cronExpression = (String) triggerMap.get("cronExpression");
			String[] cronArray = cronExpression.split(" ");
			String executeTime = addZero(cronArray[2]) + ":" + addZero(cronArray[1]) + ":" + addZero(cronArray[0]);
			Date today = new Date();
			String dateString = DateUtil.format(today, "yyyy-MM-dd");
			Date executeDateTime = DateUtil.parse(dateString + " " + executeTime, "yyyy-MM-dd HH:mm:ss");
			firedTrigger.set("newPrevFireTime", executeDateTime.getTime());
			// 下次触发时间
			String nextExecDateString = DateUtil.format(DateUtil.addDay(today, 1), "yyyy-MM-dd");// 下次触发时间为明天
			Date nextExecDateTime = DateUtil.parse(nextExecDateString + " " + executeTime, "yyyy-MM-dd HH:mm:ss");
			firedTrigger.set("newNextFireTime", nextExecDateTime.getTime());
		}
	}

	public DataObject queryTriggerInfoByJobName() {
		return null;
	}

	/**
	 * 启动定时任务
	 * 
	 * @param jobName
	 */
	@Bizlet("启动定时任务")
	public String startQrtzTask(String jobName) {

		try {
			QrtzTaskThread.startTask(jobName);// "0" 成功 "-1" 失败
		} catch (Throwable e) {
			LogUtil.logDebug("【定时器监控】启动定时任务异常!", e, new Object[] {});
			return "-1";// 失败
		}
		return "0";
	}

	/**
	 * 获取系统参数:定时任务错失触发超时间隔
	 * 
	 * @return
	 */
	@Bizlet()
	public static String getQrtzMisfiredOvertime() {
		// 上清中债缓存定义
		String qrtzInfo = null;
		try {
			// 获取缓存中邮件信息
			DataObject dojb = (DataObject) com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "ATS_QRTZ_MISFIRED_OVERTIME");
			// 上清中债缓存信息
			qrtzInfo = dojb.getString("paramValue");
		} catch (Exception e) {
			com.eos.foundation.eoscommon.LogUtil.logError("获取缓存数据失败，请检查缓存中相关配置;缓存key为：{0}", e, "ATS_QRTZ_MISFIRED_OVERTIME");
			e.printStackTrace();
		}
		return qrtzInfo;
	}

	/**
	 * 获取系统参数:定时任务是否自动恢复
	 * 
	 * @return
	 */
	@Bizlet()
	public static String getQrtzAtuoRecoveryFlag() {
		// 上清中债缓存定义
		String qrtzInfo = null;
		try {
			// 获取缓存中邮件信息
			DataObject dojb = (DataObject) com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "ATS_QRTZ_AUTO_RECOVERY");
			// 上清中债缓存信息
			qrtzInfo = dojb.getString("paramValue");
		} catch (Exception e) {
			com.eos.foundation.eoscommon.LogUtil.logError("获取缓存数据失败，请检查缓存中相关配置;缓存key为：{0}", e, "ATS_QRTZ_AUTO_RECOVERY");
			e.printStackTrace();
		}
		return qrtzInfo;
	}

	/**
	 * 获取系统参数:定时任务监控扫瞄时间间隔
	 * 
	 * @return
	 */
	@Bizlet()
	public static String getQrtzScanInterval() {
		// 上清中债缓存定义
		String qrtzInfo = null;
		try {
			// 获取缓存中邮件信息
			DataObject dojb = (DataObject) com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "ATS_QRTZ_SCAN_INTERVAL");
			// 上清中债缓存信息
			qrtzInfo = dojb.getString("paramValue");
		} catch (Exception e) {
			com.eos.foundation.eoscommon.LogUtil.logError("获取缓存数据失败，请检查缓存中相关配置;缓存key为：{0}", e, "ATS_QRTZ_SCAN_INTERVAL");
			e.printStackTrace();
		}
		return qrtzInfo;
	}

	/**
	 * 获取系统参数:定时任务异常邮件接收人
	 * 
	 * @return
	 */
	@Bizlet()
	public static String getQrtzErrorMailto() {
		// 上清中债缓存定义
		String qrtzInfo = null;
		try {
			// 获取缓存中邮件信息
			DataObject dojb = (DataObject) com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "ATS_QRTZ_ERROR_MAILTO");
			// 上清中债缓存信息
			qrtzInfo = dojb.getString("paramValue");
		} catch (Exception e) {
			com.eos.foundation.eoscommon.LogUtil.logError("获取缓存数据失败，请检查缓存中相关配置;缓存key为：{0}", e, "ATS_QRTZ_ERROR_MAILTO");
			e.printStackTrace();
		}
		return qrtzInfo;
	}

	/**
	 * 启动定时任务监控(注：这里只是为了测试方便而开发，上线会屏敝)
	 */
	@Bizlet()
	public static String startQrtzMonite() {
		try {
			Thread qrtzMonitorThread = new Thread(new QrtzMoniteThread());
			qrtzMonitorThread.start();
			return "0";
		} catch (Exception e) {
			LogUtil.logError("启动定时任务监控失败！", e, new Object[] {});
			return "-1";
		}
	}

	/**
	 * 停止定时任务监控(注：这里只是为了测试方便而开发，上线会屏敝)
	 */
	@Bizlet()
	public static String stopQrtzMonite() {
		QrtzMoniteThread.stop();
		return "0";
	}

	/**
	 * 取监控的运行状态(注：这里只是为了测试方便而开发，上线会屏敝)
	 * 
	 * @return:监控的运行状态 stoped:已停止 started：已启动
	 */
	@Bizlet()
	public static String getQrtzMoniteStatus() {
		return QrtzMoniteThread.getMoniteStatus();
	}
}
