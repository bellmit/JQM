/**
 * 
 */
package com.cjhxfund.ats.sm.comm.instructEntity;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author 王锡锋
 * @date 2018-04-27 14:35:16
 *
 */
@Bizlet("")
public class LogUtil {

	@Bizlet("记录日志")
	public static void recordLog(String logName,String logContent){
		try{
			DataObject obj = DataObjectUtil.createDataObject("com.cjhxfund.ats.sm.comm.log.TAtsAllLog");
			DatabaseExt.getPrimaryKey(obj);
			obj.setString("logName", logName);
			obj.setString("logContent", logContent);
			obj.setDate("logDate", new Date());
			DatabaseUtil.insertEntity("default", obj);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@Bizlet()
	public static String getLogContent(Date start,Date end){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try{
			String startStr = sdf.format(start);
			String endStr = sdf.format(end);
			long interval = (end.getTime() - start.getTime())/1000;
			return "开始时间:" + startStr + ",结束时间：" + endStr + ",花费" + String.valueOf(interval) + "秒";
		}catch(Exception e){
			e.printStackTrace();
			return "";
		}
	}
}
