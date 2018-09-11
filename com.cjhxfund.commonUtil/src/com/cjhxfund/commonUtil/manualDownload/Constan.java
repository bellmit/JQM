package com.cjhxfund.commonUtil.manualDownload;

import java.util.HashMap;

public class Constan {
	
	public static HashMap<String,String> MAP_EXCEL = new HashMap<String,String>(){
		{
			put("WTRD_CCXX","ATS_WTRD_CCXX");//持仓信息导出
			put("WTRD_ZGJHDCZCXX","ATS_WTRD_ZGJHDCZCXX");//资管计划底层资产信息导出
			put("WTRD_TZZCJFZXX","ATS_WTRD_TZZCJFZXX");//投资资产及负债信息导出
			put("WTRD_SJXX","ATS_WTRD_SJXX");//投资资产及负债信息导出
		}
	};
	
	public static final String PATH_FORMAT="YYYYMMDD";
	
	public static final String CACHE_NAME="ReloadParamConf1";

}
