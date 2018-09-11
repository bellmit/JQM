package com.cjhxfund.ats.fm.baseinfo;


import java.util.Date;

import com.eos.foundation.common.utils.DateUtil;
import com.eos.system.annotation.Bizlet;


/**
 * 日期公共扩展类
 * @author shihao
 */
@Bizlet("")
public class DateUtilExt {
	public static final String YMD_NUMBER = "yyyyMMdd";
	
	
	
	/**
	 * 将日期转化成int型
	 * @param Date 日期
	 * @return int
	 */
	@Bizlet("将日期型转化成Int型")
	public  static int parseToNumber(Date date){
		int number = 0;
		if(date==null){
			return number;
		}else{
			String ymd = DateUtil.format(date, YMD_NUMBER);
			try{
				number = Integer.parseInt(ymd);
			}catch(Exception e){
				return number;
			}
			return number;
		}
		
		
		
	}

}