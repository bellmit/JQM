/**
 * 
 */
package com.cjhxfund.jy.BackStageTradeProcess;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.eos.system.annotation.Bizlet;

/**
 * ServletContextListener 接口能够监听 ServletContext 对象的生命周期
 * @author 金文轩
 * @date 2016-09-14 14:11:26
 *
 */
@Bizlet("监听器")
public class InitListener implements ServletContextListener{
	//@Override
	/**
	 * Servlet容器启动时调用此方法
	 */
	public void contextInitialized(ServletContextEvent paramServletContextEvent) {
		//调用O32ServiceEntry的方法
		O32ServiceEntry.loadData();
	}
	//@Override
	public void contextDestroyed(ServletContextEvent paramServletContextEvent) {
	}
}
