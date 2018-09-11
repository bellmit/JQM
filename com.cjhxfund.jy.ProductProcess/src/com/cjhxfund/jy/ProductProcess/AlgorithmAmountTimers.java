/**
 * 
 */
package com.cjhxfund.jy.ProductProcess;



import com.cjhxfund.commonUtil.DateUtil;
import com.eos.system.annotation.Bizlet;

import java.sql.Connection;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

/**
 * @author fengjunpei
 * @date 2016-12-19 16:50:49
 *
 */
@Bizlet("")
public class AlgorithmAmountTimers {
	@Bizlet("获取O32前台成交数据定时器管理")
	public static boolean sumAlgorithmAmount(String pIntervalTime, String pEndTime){
		System.out.println(DateUtil.currentDateTimeString()+"  抽取成交金额开始...");
		//是否调用成功
		boolean isSuccess = false;
		Connection conn = null;
		boolean execute = true;
		try {
			//获取轮询间隔时间，为空或格式错误时取默认3分钟
			int intervalTime = 3;
			if(StringUtils.isNotBlank(pIntervalTime)){
				try {
					intervalTime = Integer.valueOf(pIntervalTime.trim());
				} catch (NumberFormatException e) {
					LogUtil.logError("AlgorithmAmountTimers.sumAlgorithmAmount fail: 轮询间隔时间格式错误，取默认3分钟！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询间隔时间为空，取默认3分钟！", null, new Object[]{});
			}
			
			//获取轮询结束时间，为空或格式错误时取默认17:00
			String date = DateUtil.currentDateDefaultString();
			Date endTime = DateUtil.parse(date+" 15:30:00", DateUtil.YMDHMS_PATTERN);
			if(StringUtils.isNotBlank(pEndTime)){
				try {
					endTime = DateUtil.parse(date+" "+pEndTime.trim()+":00", DateUtil.YMDHMS_PATTERN);
				} catch (Exception e) {
					LogUtil.logError("AlgorithmAmountTimers.sumAlgorithmAmount fail: 轮询结束时间格式错误，取默认15:30！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询结束时间为空，取默认15:30！", null, new Object[]{});
			}
			
			//循环执行
			while(execute){
				System.out.println(DateUtil.currentDateTimeString()+"  sumAlgorithmAmount begin ...");
				try {

					/***业务调用开始***/
					Object[] ob = new Object[]{};
        			String componentName = "com.cjhxfund.ats.algo.report.AlgoReportManage";
                	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
					logicComponent.invoke("timersInsertAlgoAmount",ob);
					/***业务调用结束***/

				} catch (Throwable e) {
					e.printStackTrace();
				} finally {
					JDBCUtil.releaseResource(conn, null, null);
				}
				System.out.println(DateUtil.currentDateTimeString()+"  sumAlgorithmAmount end !!!");
				Thread.sleep(intervalTime * 60000);//暂停设定的轮询间隔时间
				if(DateUtil.currentDate().after(endTime)){//若当前系统时间大于轮询结束时间，则跳出循环
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
		System.out.println(DateUtil.currentDateTimeString()+"  执行sumAlgorithmAmount结束!!!");
		return isSuccess;
	}
}
