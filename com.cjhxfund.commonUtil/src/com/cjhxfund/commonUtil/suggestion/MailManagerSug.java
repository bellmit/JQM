/**
 * 
 */
package com.cjhxfund.commonUtil.suggestion;

import java.util.List;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author heyi
 * @date 2017-04-21 09:23:04
 *
 */
@Bizlet("邮件发送")
public class MailManagerSug {
	
	/**
	 * 解析邮件信息
	 * @return
	 */
	@Bizlet()
	public static String setSendmailInfo(){
		String vcMailTo = "";
		//获取缓存中邮件信息
		DataObject dojb = (DataObject)com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "ATS_SUG_MAILTO_INFO");
		//解析邮件信息
		vcMailTo=dojb.getString("paramValue");
		return vcMailTo;
	}
	
	
	/**
	 * 组装附件发送信息
	 * @return
	 */
	@Bizlet()
	public String[] setfileName(DataObject[] objs){
		String[] attachFileNames = null;

		if(null != objs){
			//实例化数组
			attachFileNames = new String[objs.length];  
			for(int i = 0; i < objs.length; i++){
				attachFileNames[i] = objs[i].getString("vcAttachName");
			}
		}
		//return array ;
		return attachFileNames ;
	}
	
	/**
	 * 获取附件地址
	 * @return
	 */
	@Bizlet()
	public String[] setfilePath(DataObject[] objs){
		String[] attachFilePaths = null;
		
		if(null != objs){
			attachFilePaths = new String[objs.length];
			for(int i = 0; i < objs.length; i++){
				attachFilePaths[i] = objs[i].getString("vcAttachAdd");
			}
		}
		//return arrayPath ;
		return attachFilePaths ;

	}
	
}
