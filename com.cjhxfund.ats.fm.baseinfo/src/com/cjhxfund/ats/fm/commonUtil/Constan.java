package com.cjhxfund.ats.fm.commonUtil;

import java.util.HashMap;

public class Constan {
	
	public static HashMap<String,String> MAP_EXCEL = new HashMap<String,String>(){
		{
			put("CJ_FXRXX","ATS_CJ_FXRXX_URL");//发行人信息
			put("CJ_ZQXX","ATS_CJ_ZQXX_URL");//债券信息
			
			put("CJ_ZQFXZQ","ATS_CJ_ZQFXZQ_URL");//债券发行周期
			put("CJ_GBXX","ATS_CJ_GBXX_URL");//股本信息
			
			put("CJ_ZQLL","ATS_CJ_ZQLL_URL");//债券利率
			put("CJ_ZQPJ","ATS_CJ_ZQPJ_URL");//债券评级
			put("CJ_ZQFXXX","ATS_CJ_ZQFXXX_URL");//债券发行信息
		}
	};
	
	public static final String PATH_FORMAT="YYYYMMDD";
	
	public static final String CACHE_NAME="ReloadParamConf1";

}
