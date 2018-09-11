/**
 * 
 */
package com.cjhxfund.ats.fm.comm;

import java.util.HashMap;
import java.util.Map;

import com.eos.system.annotation.Bizlet;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.MultiPartEmail;

import com.eos.system.annotation.BizletParam;
import com.eos.common.mail.MailFactory;

import commonj.sdo.DataObject;

/**
 * @author chenpeng
 * @date 2016-04-06 09:23:04
 *
 */
@Bizlet("")
public class MailManager {
	
	/**
	 * 解析邮件信息
	 * @return
	 */
	@Bizlet()
	public static Map<String,String> setSendmailInfo(){
		//定义存储邮件对象
		Map<String,String> map = new HashMap<String,String>();
		try {
			//获取缓存中邮件信息
			DataObject dojb = (DataObject)com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "ATS_FM_SEND_MAIL_INFO");
			
			//解析邮件信息
			String mailInfo=dojb.getString("paramValue");
			
			//分割字段
			String[] mailInfos=mailInfo.split(",");
			
			for(int i=0;i<mailInfos.length;i++){
				//分割key-value
				String[] ss = (mailInfos[i]).split("\\|");
				//装入数据
				map.put(ss[0], ss[1]);
			}
		} catch (Exception e) {
			// TODO: handle exception
			com.eos.foundation.eoscommon.LogUtil.logError("获取邮件缓存数据失败，请检查缓存中邮件服务的相关配置;缓存key为：{0}", e, "ATS_FM_SEND_MAIL_INFO");
			e.printStackTrace();
		}
		
		return map;
	}
	

	/**
	 * 
	 */
	@Bizlet(params = { @BizletParam(index = 0, paramAlias = "Title"),
			@BizletParam(index = 1, paramAlias = "MailTo"),
			@BizletParam(index = 2, paramAlias = "MailCC"),
			@BizletParam(index = 3, paramAlias = "MailContext"),
			@BizletParam(index = 4, paramAlias = "MailSender"),
			@BizletParam(index = 5, paramAlias = "AttachFilePath"),
			@BizletParam(index = 6, paramAlias = "AttachFileName"),
			@BizletParam(index = 7, paramAlias = "smtp"),
			@BizletParam(index = 8, paramAlias = "mailName"),
			@BizletParam(index = 9, paramAlias = "mailPwd"),
			@BizletParam(index = 10, paramAlias = "normalMail") })
	public static void sendMultiMail(String Title, String MailTo, String MailCC,
			String MailContext, String MailSender, String[] AttachFilePath,
			String[] AttachFileName, String smtp, String mailName,
			String mailPwd, String normalMail) throws EmailException {
		//		定义临时变量
		int i = 0;
		int iLen = 0;
		//声明一个支持附件的Email
		org.apache.commons.mail.MultiPartEmail mail = MailFactory
				.getMultiEmailInstance();
		//邮件属性设置
		//设置字符集
		//mail.setCharset("UTF-8");
		mail.setCharset("GBK");
		//设置SMTP服务器地址
		mail.setHostName(smtp);
		//如果需要用户验证，设定用户名和密码
		//第一个参数用户名,第二个参数密码
		mail.setAuthentication(mailName, mailPwd);
		//邮件内容设置
		//设定主题
		mail.setSubject(Title);
		//设置发件人，如果没有输入发送人则采用默认用户
		if (MailSender.trim().equals("")) {
			//设定默认发送者邮件地址
			mail.setFrom(normalMail);
		} else {
			//设定发送者邮件地址
			mail.setFrom(MailSender);
		}
		
		//设置发送对象
		if ((null != MailTo) && (MailTo.trim().length() != 0)) {
			String[] strTo = MailTo.split(";");
			iLen = strTo.length;
			for (i = 0; i < iLen; i++) {
				mail.addTo(strTo[i]);
			}
		}
		//设置抄送者
		if ((null != MailCC) && (MailCC.trim().length() != 0)) {
			String[] strCC = MailCC.split(";");
			iLen = strCC.length;
			for (i = 0; i < iLen; i++) { 
				mail.addCc(strCC[i]);
			}
		}
		//设定消息内容 文本格式
		mail.setMsg((StringUtils.isNotBlank(MailContext) ? MailContext : " "));

		//设置附件
		try {
			if (null != AttachFileName) {
				iLen = AttachFileName.length;
				for (i = 0; i < iLen; i++) {
					//创建附件
					EmailAttachment attFile = new EmailAttachment();
					//设置附件路径
					attFile.setPath(AttachFilePath[i]);
					//设置附件显示名称
					//String strName = new String(AttachFileName[i].getBytes("GBK"), "ISO-8859-1");
					String strName = javax.mail.internet.MimeUtility.encodeText(AttachFileName[i]);
					attFile.setName(strName);
					mail.attach(attFile);
				}
			}
		} catch (Exception e) {

		}
		//发送邮件
		mail.send();
	}
	
	
	@Bizlet(params = { @BizletParam(index = 0, paramAlias = "Title"),
			@BizletParam(index = 1, paramAlias = "MailTo"),
			@BizletParam(index = 2, paramAlias = "MailCC"),
			@BizletParam(index = 3, paramAlias = "MailContext"),
			@BizletParam(index = 4, paramAlias = "MailSender"),
			@BizletParam(index = 5, paramAlias = "AttachFilePath"),
			@BizletParam(index = 6, paramAlias = "AttachFileName"),
			@BizletParam(index = 7, paramAlias = "smtp"),
			@BizletParam(index = 8, paramAlias = "mailName"),
			@BizletParam(index = 9, paramAlias = "mailPwd"),
			@BizletParam(index = 10, paramAlias = "normalMail") })
	public static void sendHtmlMail(String Title, String MailTo, String MailCC,
			String MailContext, String MailSender, String[] AttachFilePath,
			String[] AttachFileName, String smtp, String mailName,
			String mailPwd, String normalMail) throws EmailException {
		//		定义临时变量
		int i = 0;
		int iLen = 0;
		//声明一个html格式并支持附件的Email
		org.apache.commons.mail.HtmlEmail mail = MailFactory
				.getHtmlEmailInstance();
		//邮件属性设置
		//设置字符集
		//mail.setCharset("UTF-8");
		mail.setCharset("GBK");
		//设置SMTP服务器地址
		mail.setHostName(smtp);
		//如果需要用户验证，设定用户名和密码
		//第一个参数用户名,第二个参数密码
		mail.setAuthentication(mailName, mailPwd);
		//邮件内容设置
		//设定主题
		mail.setSubject(Title);
		//设置发件人，如果没有输入发送人则采用默认用户
		if (MailSender.trim().equals("")) {
			//设定默认发送者邮件地址
			mail.setFrom(normalMail);
		} else {
			//设定发送者邮件地址
			mail.setFrom(MailSender);
		}
		//设置发送对象
		if ((null != MailTo) && (MailTo.trim().length() != 0)) {
			String[] strTo = MailTo.split(";");
			iLen = strTo.length;
			for (i = 0; i < iLen; i++) {
				mail.addTo(strTo[i]);
			}
		}
		//设置抄送者
		if ((null != MailCC) && (MailCC.trim().length() != 0)) {
			String[] strCC = MailCC.split(";");
			iLen = strCC.length;
			for (i = 0; i < iLen; i++) {
				mail.addCc(strCC[i]);
			}
		}
		//设定消息内容 HTML格式
		mail.setHtmlMsg((MailContext != null ? MailContext : " "));

		//设置附件
		try {
			if (null != AttachFileName) {
				iLen = AttachFileName.length;
				for (i = 0; i < iLen; i++) {
					//创建附件
					EmailAttachment attFile = new EmailAttachment();
					//设置附件路径
					attFile.setPath(AttachFilePath[i]);
					//设置附件显示名称
					//String strName = new String(AttachFileName[i].getBytes("GBK"), "ISO-8859-1");
					String strName = javax.mail.internet.MimeUtility.encodeText(AttachFileName[i]);
					attFile.setName(strName);
					mail.attach(attFile);
				}
			}
		} catch (Exception e) {

		}
		//发送邮件
		mail.send();
	}
	
	public static void main1(String[] args) {
	 try{	
		MultiPartEmail mail = MailFactory.getMultiEmailInstance();
		// 设置SMTP服务器地址 "smtp.qq.com","smtp.163.com"
		mail.setHostName("mail.cjhxfund.com");
		mail.setSmtpPort(25);
		// 如果需要用户验证，设定用户名和密码"1039256923", "000000"
		mail.setAuthentication("cj_itsupport","A+12345678");
		// 设定收件人邮件地址
		mail.addTo("294806367@qq.com");
		
		
		// 设定发送者邮件地址
		mail.setFrom("cj_itsupport@cjhxfund.com");
		//mail.setFrom("wmsalert@livzon.cn");
        // 设定主题
		mail.setSubject("111");
		// 设定消息内容
		mail.setMsg("你好测试");
		String a = mail.send();
		System.out.println(a);
	 }catch(EmailException  e){
		 e.printStackTrace();
	 }
	}
}
