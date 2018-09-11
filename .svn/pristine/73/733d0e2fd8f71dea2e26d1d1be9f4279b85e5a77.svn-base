package com.cjhxfund.commonUtil;

import java.lang.reflect.Field;

import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;


/**
 * ATS应用常量类
 * @author 杨敏
 */
@Bizlet("ATS应用常量类")
public class Constants {
	
	public static final String ATS_SUCCESS="0";//执行成功
	public static final String ATS_ERROR="-1";//非业务的系统异常
	
	//FIX接口的错误码：01开头
	public static final String ATS_FIX_NO_RCV_FR_O32="0100";//未收到O32反馈
	
	//下达指令的错误码：02开头
	public static final String ATS_ORDER_NO_RCV_FR_O32="0200";//未收到O32反馈
	public static final String ATS_ORDER_OVER_DEAL_TIME="0201";//已超过交易时间
	public static final String ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT="0202";//可用数量不足
	
	//风控试算的错误码：03开头
	public static final String ATS_RISK_NO_RCV_FR_O32="0300";//未收到O32反馈
	public static final String ATS_RISK_VIOLATE_FORBID_CTRL="0301";//触犯禁止风控
	public static final String ATS_RISK_VIOLATE_OTHER_CTRL="0302";//触犯其他风控
	
	/**
	 * 获取常量的方法
	 * @param name 常量名字,必须和常量名字一致，区分大小写.
	 * @return 常量对应的值
	 */
	@Bizlet("获取常量类的返回码")
	public static String getConstantValue(String name){
		
		try {
			//获取到当前类
			Class ownerClass = Class.forName("com.cjhxfund.commonUtil.Constants");
			//获取常量对象
			Field field = ownerClass.getField(name); 
			//获取值
			String ret=field.get(ownerClass).toString();
			LogUtil.logDebug("获取常量类常量：{0}，常量返回值为：[{1}]", null, name,ret);
			return ret;
		} catch (Exception e) {
			LogUtil.logDebug("获取常量类常量：[{0}]发生错误。", e, name);
			e.printStackTrace();
		} 
		return "-1";
	}
	
}
