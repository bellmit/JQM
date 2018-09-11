/**
 * 
 */
package com.cjhxfund.ats.qrtz;

import java.lang.reflect.Method;
import java.util.Date;
import java.util.Map;

import com.cjhxfund.commonUtil.QrtzUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.common.schedule.impl.base.BaseTaskDetail;
import com.primeton.ext.common.schedule.ScheduleManager;
import com.primeton.ext.engine.component.LogicComponentFactory;

/**
 * 任务线程，启一个任务就启一个线程
 * @author 武正新
 * @date 2017-12-14 14:18:50
 *
 */
@Bizlet("")
public class QrtzTaskThread implements Runnable {

	private String jobName;//任务名称
	
	public QrtzTaskThread(String jobName){
		this.jobName=jobName;
	}
	
	/* （非 Javadoc）
	 * @see java.lang.Runnable#run()
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void run() {
		
		try {
			Map<String, Object> map = ScheduleManager.getTaskDetail(jobName);
			BaseTaskDetail taskDetail = (BaseTaskDetail) map.get("taskDetail");
			String targetName = taskDetail.getTargetName();// 目标名称,如果是java方法任务则对应类名
			if(targetName==null||"".equals(targetName)){//任务名称可能为空，不知道为什么，这是由EOS封装的
				return ;
			}
			String targetOperation = taskDetail.getTargetOperation();// 目标名称,如果是java方法任务则对应方法名
			Object[] targetArgs = taskDetail.getTargetArgs();// 参数
			Integer taskType = (Integer) map.get("taskType");
			if (taskType.equals(3)) {// JAVA方法任务
				Class taskClass = Class.forName(targetName);
				Object obj = taskClass.newInstance();
				Class[] param = new Class[targetArgs.length];
				if(targetArgs==null||targetArgs.length==0){
					Method method = taskClass.getMethod(targetOperation);
					method.invoke(obj);
				}else if(targetArgs.length>0){
					for(int index=0;index<targetArgs.length;index++){
						param[index] = String.class;
					}
					Method method = taskClass.getMethod(targetOperation, param);
					method.invoke(obj, targetArgs);
				}
			} else if (taskType.equals(2)) {// 逻辑流任务
				Long beforeTime=(new Date()).getTime();
				
				ILogicComponent comp = LogicComponentFactory.create(targetName);
				comp.invoke(targetOperation, targetArgs);
				
				Long afterTime=(new Date()).getTime();
				QrtzUtil.executeLog(jobName, beforeTime, afterTime);
			} else if (taskType.equals(1)) {// SCA服务任务
				// 待实现,目前没有这种定时任务，也没人清楚SCA服务
			}
		} catch (Throwable e) {
			LogUtil.logDebug("【定时器监控】启动定时任务异常!", e, new Object[] {});
		}
	}
	
	public static void startTask(String jobName){
		Thread taskThread=new Thread(new QrtzTaskThread(jobName));
		taskThread.start();
	}
}
