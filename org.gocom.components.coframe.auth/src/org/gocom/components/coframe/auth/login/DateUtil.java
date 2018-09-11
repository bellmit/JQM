package org.gocom.components.coframe.auth.login;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;
@Bizlet("时间帮助类")
public class DateUtil {
	@Bizlet("获取N分钟前的数据")
	public static DataObject getBeforeDate(DataObject dobj,int num){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		System.out.println("当前时间：" + sdf.format(now));
		
		long time = num*60*1000;//1分钟
		  
		Date beforeDate = new Date(now .getTime() - time);//1分钟前的时间
		System.out.println(num+"分钟前："+beforeDate);
		dobj.setDate("beforeDate", beforeDate);
		dobj.setDate("nowDate", now);
		
		return dobj;
	}
}
