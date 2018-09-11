/**
 * 
 */
package com.cjhxfund.ats.qrtz;

import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

/**
 * @author 武正新
 * @date 2018-02-05 20:44:59
 * 
 */
@Bizlet("")
public class QrtzScanThread implements Runnable {

	public void run() {
		try {
			Object[] ob = new Object[] {};
			String componentName = "com.cjhxfund.ats.qrtz.qrtzMonite";
			ILogicComponent comp = LogicComponentFactory.create(componentName);
			comp.invoke("moniteQrtzTask", ob);
		} catch (Throwable e) {
			System.out.println("定时器监控线程出现异常!");
			LogUtil.logError("定时器监控线程出现异常!", e, new Object[] {});
		}
	}

}
