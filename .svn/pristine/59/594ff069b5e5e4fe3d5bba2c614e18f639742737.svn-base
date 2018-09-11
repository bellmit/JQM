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

public class BizOperateCommonHandler implements IHandler{
	//创建日志对象
	private static final Logger logger = TraceLoggerFactory.getLogger(BizOperateCommonHandler.class);
	
	//手工调用业务逻辑
	@SuppressWarnings("finally")
	public int doAfter(IRuntimeContext arg0) {
		// 取得上下文
		IMUODataContext muo = DataContextManager.current().getMUODataContext();
		try {
			if (muo != null) {
				//查询业务类型代码
				String vcBizKey = "";
				//业务类型
				String vcBizFullName = "";
				//取得用户对象
				IUserObject userObject = muo.getUserObject();
				DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
				if (userObject != null) {
					//获取用户operatorid
					String lUserId = userObject.getUserId();
					//获取用户账号
					String vcUserId = userObject.getAttributes().get("EXTEND_USER_ID").toString();
					//获取逻辑流全称
					String vcBizName = arg0.getName();
					data.set("vcBizName", vcBizName);
					
					//查询映射表的业务类别key值，不存在则为公共整体逻辑流拦截；有一条记录则取出业务类型key值，通过上下文将业务类型获取
					Object[] bizMapping = DatabaseExt.queryByNamedSql(JDBCUtil.DATA_SOURCE_DEFAULT, "com.cjhxfund.commonUtil.userOpr.queryBizMapping",data);
					if(bizMapping.length==1){
						vcBizKey = (String)bizMapping[0];
						vcBizFullName = vcBizName + "|" + (String)arg0.get(vcBizKey);
					}else{
						vcBizFullName = vcBizName;
					}
					//获取当前时间
					Timestamp tOperateTime = DateUtil.getDateTime();
					//保存操作日志
					DataObject operateLog = DataObjectUtil.createDataObject("com.cjhxfund.commonUtil.dataBase.TAtsUserOperateLog");
					DatabaseExt.getPrimaryKey(operateLog);
					operateLog.set("lUserId", lUserId);
					operateLog.set("vcUserId", vcUserId);
					operateLog.setString("vcBizName", vcBizFullName);
					operateLog.setDate("tOperateTime", tOperateTime);
					DatabaseUtil.insertEntity("default", operateLog);
					System.out.println("[用户操作业务记录]insert："+vcBizFullName+" success");
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
