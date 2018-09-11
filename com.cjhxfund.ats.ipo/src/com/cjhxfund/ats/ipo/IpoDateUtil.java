package com.cjhxfund.ats.ipo;


import com.eos.system.annotation.Bizlet;

@Bizlet("IPO内部日期操作类")
public class IpoDateUtil {
	
	@Bizlet("将日期字符串去掉时间，并将日期转换成YYYYMMDD格式")
	public static String traslateStringToDate(String dateStr){
		String result=null;
		if(dateStr!=null && !"".equals(dateStr)){
			String[] dates=dateStr.split(" ");
			if(dates!=null && dates.length>1){
				String date=dates[0];
				result=date.replaceAll("-", "");
			}
		}
		return result;
	}
//	
//	public static void main(String[] args) {
//		String dateStr="2017-02-17 14:23:23";
//		System.out.println(traslateStringToDate(dateStr));
//	}
}
