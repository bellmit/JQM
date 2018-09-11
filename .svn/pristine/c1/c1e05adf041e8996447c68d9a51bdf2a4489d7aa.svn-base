/**
 * 
 */
package com.cjhxfund.ats.qrtz;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.cjhxfund.commonUtil.DateUtil;
import com.eos.system.annotation.Bizlet;

/**
 * 未触发定时器管理类,用作重做机制
 * @author 武正新
 * @date 2018-02-05 14:54:10 
 */
@Bizlet("")
public class MisfiredTriggerManger {
	
	/**
	 * 存储未触发定时器，用于邮件重发机制,当发现有定时器未触发则记录到MAP中并发送邮件,如果已经存在，则跳过，
	 * 人工处理（启动定时器）后则删除.即人工未处理时同一天内不重复发邮件。 key:jobName value:插入时间
	 * */
	private static Map<String, String> misfiredTriggerMap = new HashMap<String, String>();

	/**
	 * 是否已经记录到了未触发定时器集合中,未记录则记录返回false，已记录则返回true
	 * 
	 * @return 已经记录返回true 未记录返回false，并记录
	 */
	@Bizlet("")
	public static boolean isContain(String jobName) {
		Date today = new Date();
		String dateStr = DateUtil.format(today, "yyyy-MM-dd");
		// 如果集合中已经包含，并记录时间是当天则说明已经记录.否则重新记录.
		if (misfiredTriggerMap.containsKey(jobName) && dateStr.equals(misfiredTriggerMap.get(jobName))) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 新增未触发记录
	 * @param jobName
	 */
	@Bizlet("")
	public static void addMisfiredTrigger(String jobName) {
		Date today = new Date();
		String dateStr = DateUtil.format(today, "yyyy-MM-dd");
		misfiredTriggerMap.put(jobName, dateStr);
	}

	/**
	 * 删除未触发记录
	 * 
	 * @param jobName
	 */
	@Bizlet("")
	public static void deleteMisfiredTrigger(String jobName) {
		misfiredTriggerMap.remove(jobName);
	}
	
	
}
