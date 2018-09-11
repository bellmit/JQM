package com.cjhxfund.ats.fm.baseinfo;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;


public class SynCommonUtil {

    /**
     * 插入操作错误日志
     */
    @Bizlet("")
    public static void insertMsg(String cLogType,String vcMessage,int lCount,String vcProcessName,String vcProcessMsg){
    	Connection conn_qjy = null;
    	if(vcMessage == "" || vcMessage == null){
    		vcMessage = "无错误信息！";
    	}
    	try {
    		conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
        	String sql_insert = "insert into t_ats_message_log(l_date,l_time,c_log_type,vc_message,l_count,vc_process_name,vc_process_msg) values (?,?,?,?,?,?,?)";
    		 List<Object> params = new ArrayList<Object>();
    		 SimpleDateFormat dateFormater = new SimpleDateFormat("yyyyMMdd");
             SimpleDateFormat timeFormater = new SimpleDateFormat("HHmmss");
     		 Date date=new Date();
    		 params.add(0, Integer.parseInt(dateFormater.format(date)));
    		 params.add(1, Integer.parseInt(timeFormater.format(date)));
    		 params.add(2, cLogType);
    		 params.add(3, vcMessage);
    		 params.add(4, lCount);
    		 params.add(5, vcProcessName);
    		 params.add(6, vcProcessMsg);
    		JDBCUtil.executeUpdateWithConn(conn_qjy, sql_insert, params);
		} catch (Exception e) {	
			e.printStackTrace();
			LogUtil.logError("[insertMsg]"+"插入日志表信息出错!", e, new Object[]{});
		}finally{
			JDBCUtil.releaseResource(conn_qjy, null, null);
		}
    	
    }
    /**
     * 判断同步的操作
     */
    @Bizlet("")
    public static boolean synControl(){
    	boolean isTimers = false;
    	try {
	    	String componentName = "com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz";/*逻辑构建名称*/
	        String operationName = "getParamValue";/*逻辑流名称*/
	        ILogicComponent comp = LogicComponentFactory.create(componentName);
	        String pramkey = "ATS_SYN_STOCK_ISSUE";
	        Object[] params = new Object[]{pramkey};
			Object[] result = (Object[])comp.invoke(operationName,params);
			if("1".equals(result[0])){
				isTimers =  true;
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return isTimers;
    }
}
