package com.cjhxfund.ats.riskMgr;

public class Ass {
    /**
* 加密邮件的明文密码
*/
public static void encryptSendMailPwd(String pwd){

String mw=com.eos.foundation.common.utils.CryptoUtil.encryptByDES(pwd,"ats_key");
System.out.println("字符串: "+pwd+" ,转换为密文是："+mw);
String key = com.eos.foundation.common.utils.CryptoUtil.decryptByDES(mw,"ats_key");
//System.out.println(""+key);
}
/**
* 密文解密问明文
* @param pwd
*/
public static void decryptSendMailPwd(String pwd){
String mw = com.eos.foundation.common.utils.CryptoUtil.decryptByDES(pwd,"ats_key");
System.out.println("密文: "+pwd+" ,转换为明文是："+mw);
}

public static void main(String[] args) {
	Ass.encryptSendMailPwd("Cjhx@20170531");
}
}
