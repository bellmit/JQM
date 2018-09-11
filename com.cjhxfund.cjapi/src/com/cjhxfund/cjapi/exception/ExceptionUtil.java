package com.cjhxfund.cjapi.exception;

import java.util.Map;

import com.cjhxfund.commonUtil.DateUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * 
 * @author luwenxing
 * @date 2016-11-24 16:04:03
 * 
 */
public class ExceptionUtil {
	/**
	 * 获取异常信息
	 * 
	 * @param 捕获到的异常
	 * @return exception message
	 */
	@Bizlet("将异常转化成字符信息")
	public static String getMsg(AppException e) {
		return e.getMessage();
	}

	/**
	 * 异常信息的处理
	 * 
	 * @param 捕获到的异常
	 * @return exception message
	 */
	@Bizlet("处理捕捉到的异常")
	public static AppException exceptionDeal(String errorFunc, Exception e) {
		AppException ae = new AppException();
		if (e == null) {
			ae.code = CJAPIConstants.ERROR_SYSTEM;
			ae.msg = CJAPIConstants.ERROR_SYSTEM_MSG;
			ae.level = CJAPIConstants.EXCEPTION_LEVEL_SYSTEM;
		}

		if (e instanceof AppException) {
			ae = (AppException) e;
		} else {
			ae.code = CJAPIConstants.ERROR_SYSTEM;
			ae.msg = CJAPIConstants.ERROR_SYSTEM_MSG;
			ae.level = CJAPIConstants.EXCEPTION_LEVEL_SYSTEM;
		}
		/**
		 * 异常入库
		 */
		addLog(errorFunc, ae);
		return ae;
	}

	/**
	 * 新增错误日志
	 * 
	 * @param errorFunc
	 *            出错逻辑
	 * @param ae
	 *            出错信息
	 */
	private static void addLog(String errorFunc, AppException ae) {
		DataObject logDo = DataObjectUtil
				.createDataObject(CJAPIConstants.CJAPI_LOGINFO_ENTITY_NAME);
		try {
			logDo.setLong("logId",
					DatabaseExt.getNextSequence("SEQ_CJAPI_LOG_INFO"));
			logDo.setLong("logCode", ae.getCode());
			logDo.setString("logInfo", ae.getMsg());
			logDo.setString("errerFunction", errorFunc);
			logDo.setInt("createTime", DateUtil.currentTimeInt());
			logDo.setInt("createDate", DateUtil.currentDateYYYYMMDDInt());
			DatabaseUtil.saveEntity(CJAPIConstants.DS_DEFAULT, logDo);
		} catch (Exception e) {
			/**
			 * 此处如果异常，不入库
			 */
			e.printStackTrace();

		}
	}
	
	/**
	 * @Description 统一处理异常信息
	 * @Author		liangjilong
	 * @Date		2016年12月9日 下午5:40:37
	 * @param 		retMap返回接口的Map对象信息
	 * @param 		e 异常对象信息
	 * @param 		errorFunc执行异常信息
	 * @param 		errorMsg 返回异常信息
	 * @return 		void 返回类型
	 */
	public static Map<String, Object> retExceptionInfo(Map<String, Object> retMap, Exception e, String errorFunc, String errorMsg) {
		//处理异常
		AppException ae = exceptionDeal(errorFunc, e);
		retMap.put("vcRetCode", ae.getCode());
		retMap.put("vcRetMsg", ae.getMsg());
		LogUtil.logError(errorMsg, ae);
		return retMap; 
	}

}
