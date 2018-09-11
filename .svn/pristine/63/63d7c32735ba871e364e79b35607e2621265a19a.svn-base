/**
 * 
 */
package com.cjhxfund.foundation.fix;

import java.util.Date;


import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.ParamConfig;
import com.cjhxfund.commonUtil.QrtzUtil;
import com.eos.system.annotation.Bizlet;

/**
 * @author 王锡锋
 * @date 2018-03-14 17:43:45
 *
 */
@Bizlet("")
public class FixToUtilNew {
	
	
	/**
	 * 【新】定时器开启Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话对象（需在恒生转换机启动之后再启动）
	 * Fix会话对象开启成功后同步将是否启用Fix对接O32设置为“0-启用”（0-启用；1-不启用；）
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取默认3分钟
	 * @param pEndTime 轮询结束时间，为空或格式错误时取默认10:00
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("定时启动Fix会话对象")
	public static boolean fixOpenServiceInstruction4Timer(){
		System.out.println(DateUtil.currentDateTimeString()+"  【新】定时器开启Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话对象开始...");
		//是否调用成功
		boolean isSuccess = false;
		try {
			//获取主服务器IP地址
			String mainServerAddress = ParamConfig.getValue("ZHFWPT_SERVER_MAIN_ADDRESS");
			//获取FIX服务端（O32转换机）连接IP地址：172.19.8.11 [O32转换机（主）]、172.19.8.12 [O32转换机（备）]
			String fixO32SocketConnectHost = ParamConfig.getValue("ZHFWPT_FIX_O32_SOCKET_CONNECT_HOST");
			
			Long beforeTime=(new Date()).getTime();
				
			//获取Fix会话对象开启是否成功
			boolean isSuccess_fix = FixToUtil.fixOpenServiceInstruction(mainServerAddress, fixO32SocketConnectHost, null);
				
			Long afterTime=(new Date()).getTime();
			String className=Thread.currentThread().getStackTrace()[1].getClassName();
			String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
			QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
				
			//若Fix会话对象开启失败，则等待轮询间隔时间后继续执行开启
			if(!isSuccess_fix){
				FixToUtil.fixCloseServiceCommon();//关闭Fix会话对象（若不关闭，Fix引擎会一直尝试连接）
			//若Fix会话对象开启成功，则同步将是否启用Fix对接O32设置为“0-启用”（0-启用；1-不启用；）
			}else{
					
				//将是否启用Fix对接O32设置为“0-启用”（0-启用；1-不启用；）
				boolean isSuccess_update = ParamConfig.updateParamValueByParamKey(FixToUtil.ENABLE_FIX_PARAM_KEY, FixToUtil.ENABLE_FIX_PARAM_KEY_OPEN);
				//重新加载缓存
				boolean isSuccess_reload = ParamConfig.reloadCacheByName(null);
				//更新标志位跳出循环
					
				//是否调用成功
				isSuccess = isSuccess_update && isSuccess_reload;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(DateUtil.currentDateTimeString()+"  【新】定时器开启Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话对象结束!!!"+(isSuccess==true?"【成功】":"【失败】"));
		return isSuccess;
	}
}
