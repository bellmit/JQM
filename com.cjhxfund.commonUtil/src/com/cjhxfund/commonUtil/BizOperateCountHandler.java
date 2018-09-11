package com.cjhxfund.commonUtil;

import java.sql.Timestamp;

import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.data.datacontext.IUserObject;
import com.eos.engine.core.IHandler;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.runtime.core.TraceLoggerFactory;
import com.eos.system.logging.Logger;
import com.primeton.ext.engine.core.IRuntimeContext;
import commonj.sdo.DataObject;

public class BizOperateCountHandler implements IHandler {
	//创建日志对象
	private static final Logger logger = TraceLoggerFactory
			.getLogger(BizOperateCountHandler.class);

	@SuppressWarnings("finally")
	public int doAfter(IRuntimeContext arg0) {
		// 取得上下文
		IMUODataContext muo = DataContextManager.current().getMUODataContext();
		try {
			if (muo != null) {
				IUserObject userObject = muo.getUserObject();
				if (userObject != null) {
					// 获取用户operatorid
					String lUserId = userObject.getUserId();
					// 获取用户账号
					String vcUserId = userObject.getAttributes()
							.get("EXTEND_USER_ID").toString();
					// 获取逻辑流全称
					String vcBizName = arg0.getName();
					// 获取当前时间
					Timestamp tOperateTime = DateUtil.getDateTime();
					// 保存操作日志
					DataObject operateLog = DataObjectUtil
							.createDataObject("com.cjhxfund.commonUtil.dataBase.TAtsUserOperateLog");
					DatabaseExt.getPrimaryKey(operateLog);
					operateLog.set("lUserId", lUserId);
					operateLog.set("vcUserId", vcUserId);
					operateLog.setString("vcBizName", vcBizName);
					operateLog.setDate("tOperateTime", tOperateTime);
					DatabaseUtil.insertEntity("default", operateLog);
					System.out.println("insert AtsUserOperateLog success");
				}
			}
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			return RET_OK;
		}
	}

	public int doBefore(IRuntimeContext arg0) {
		return RET_OK;
	}

	// 逻辑流发生异常时候执行日志记录功能
	public int doException(IRuntimeContext arg0, Throwable arg1) {
		String processorName = arg0.getProcessName();
		String currentID = arg0.getCurrentActivityID();
		String currentName = arg0.getCurrentActivityName();
		String currentType = arg0.getCurrentActivityType();
		logger.error(processorName + " " + currentID + " " + currentName + " "
				+ currentType + " make an error "
				+ arg1.getMessage().toString());
		return RET_OK;
	}

	public int doFinalize(IRuntimeContext arg0) {
		return RET_OK;
	}

}
