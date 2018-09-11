package org.cjhxfund.sys;

import org.gocom.components.coframe.tools.JDBCUtil;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

public class SysParamUtil {
	//数据类型
	public static String ldap = "ldap";
	
	@Bizlet("获取系统参数")
	public static String getSysParam(String paramType,String paramName){
		String paramValue = "";
		DataObject sysParam = DataObjectUtil.createDataObject("org.gocom.components.coframe.auth.sysentity.PmSysParam");
		sysParam.set("paramType", paramType);
		sysParam.set("paramName", paramName);
		DatabaseUtil.expandEntity(JDBCUtil.DATA_SOURCE_DEFAULT , sysParam);
		paramValue = sysParam.getString("paramValue");
		return paramValue;
	}
}
