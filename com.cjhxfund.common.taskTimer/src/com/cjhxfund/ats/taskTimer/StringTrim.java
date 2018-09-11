package com.cjhxfund.ats.taskTimer;

import java.util.Date;

import com.eos.system.annotation.Bizlet;

@Bizlet("")
public class StringTrim {
	@Bizlet("")
	public String getTrimString(String para) {
		if(para!=null&&para.length()>0){
			String para1=para.trim();
			return para1;
			}
		
		return para;

	}
	
	@Bizlet("转义")
	public static String replaceDate(String date){
		return date.replaceAll("-", "");
	}
	
	@Bizlet()
	public void printnowdate(Date date1,Date date2,String msg){
		long datetime1 = date1.getTime();
		long datetime2 = date2.getTime();
		long result = 0;
		if(datetime2>datetime1){
			result = (datetime2-datetime1)/1000;
		}else{
			result = (datetime2-datetime1)/1000;
		}
		System.err.println(msg + "执行了=========>"+result +"秒");
	}
	
	@Bizlet("测试打印")
	public void testTask(String timerId){
		System.out.println("定时器:("+timerId+")--执行--"+new Date());
	}
	
}
