package com.cjhxfund.ats.mom.report;

import java.security.MessageDigest;

import com.eos.system.annotation.Bizlet;

/**
 * 报表鉴权类
 * @author yuejing
 *
 */
public class ReportManagerAuth {

	private static String encode(String str) {
		try {
	        //确定计算方法
	        MessageDigest md5 = MessageDigest.getInstance("MD5");
	        //加密后的字符串
	        byte[] byteArray = str.getBytes("UTF-8");
        	byte[] md5Bytes = md5.digest(byteArray);
        	StringBuffer hexValue = new StringBuffer();
	        for (int i = 0; i < md5Bytes.length; i++) {
	            int val = ((int) md5Bytes[i]) & 0xff;
	            if (val < 16) {
	                hexValue.append("0");
	            }
	            hexValue.append(Integer.toHexString(val));
	        }
	        return hexValue.toString();
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return null;
    }
	
	/**
	 * 获取鉴权的字符串信息
	 * @return
	 */
	@Bizlet("getAuthSignInfo")
	public static String getAuthSignInfo() {
		String key = "dfk23f78sdf3";
		String time = String.valueOf(System.currentTimeMillis());
		String str = key + time;
		String sign = "sign=" + encode(str) + "&time=" + time;
		return sign;
	}
}
