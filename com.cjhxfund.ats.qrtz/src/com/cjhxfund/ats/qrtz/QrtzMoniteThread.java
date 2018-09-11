package com.cjhxfund.ats.qrtz;

import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

/**
 * 定时任务监控线程, 1、记录异常信息 2、自动恢复定时任务
 * 
 * @author wuzhengxin
 * 
 */
@Bizlet("")
public class QrtzMoniteThread implements Runnable {

	private static boolean execute = true;
	
	/**是否是监控第一次扫瞄,这里的场景就是系统在重启时会扫瞄，这种情况要排除在外,否则每次发包都会发邮件*/
	private static boolean firstScan=true;

	public void run() {

		System.out.println("定时器监控线程启动!");
		String interval = QrtzMoniteHandler.getQrtzScanInterval();
		Integer intervalInt = Integer.parseInt(interval);
		execute = true;// 复位
		while (execute) {
			System.out.println("定时器监控线程运行");
			try {
				Object[] ob = new Object[] {};
				String componentName = "com.cjhxfund.ats.qrtz.qrtzMonite";
				ILogicComponent comp = LogicComponentFactory.create(componentName);
				comp.invoke("moniteQrtzTask", ob);
//				Thread scanThread=new Thread(new QrtzScanThread());
//				scanThread.start();
			} catch (Throwable e) {
				System.out.println("定时器监控线程出现异常!");
				LogUtil.logError("定时器监控线程出现异常!", e, new Object[] {});
			} finally {
				try {
					Thread.sleep(intervalInt * 60 * 1000);
				} catch (InterruptedException e) {
					LogUtil.logError("定时器监控异常", e, new Object[] {});
				}
			}

		}
	}

	public static void stop() {
		execute = false;
	}

	public static String getMoniteStatus() {

		if (execute) {
			return "started";
		} else {
			return "stoped";
		}
	}
	
	@Bizlet
	public static boolean isFirstScan(){
		return firstScan;
	}
	
	@Bizlet
	public static void upateFirstScan(){
	    firstScan=false;
	}
}
