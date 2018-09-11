/**
 * 
 */
package com.cjhxfund.commonUtil;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.MultiPartEmail;

import com.cjhxfund.ats.fm.comm.ProductUtil;
import com.eos.common.mail.MailFactory;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.runtime.core.ApplicationContext;
import com.eos.system.annotation.Bizlet;
import com.eos.system.annotation.BizletParam;
import com.eos.system.log.LogFactory;
import com.eos.system.logging.Logger;

import commonj.sdo.DataObject;

/**
 * @author chenpeng
 * @date 2016-04-06 09:23:04
 *
 */
@Bizlet("机器猫公共邮件发送")
public class MailManager {
	//取得logger
	protected static final Logger logger = LogFactory.getLogger(MailManager.class);
	
	/**
	 * @param sendEmailInfo：发送邮件实体对象
	 * @param AttachFilePath：发送邮件需要添加的附件路径（数组）
	 * @param AttachFileName：发送邮件需要添加的附件名称（数组）
	 * @return sendEmailInfo：发送邮件对象（主要是将AttachFilePath和AttachFileName处理成字符串以及把邮件发送成功失败标志反写到对象中）
	 */
	@Bizlet("发送文本邮件，支持添加多个附件")
	public DataObject sendMultiMail(DataObject sendEmailInfo, String[] attachFilePaths,String[] attachFileNames) throws EmailException {
		
		try {
			System.out.println("开始发送邮件：sendMultiMail");
			//定义邮件属性变量
			String title = sendEmailInfo.getString("vcTitle");//邮件发送主题
			String mailTo = sendEmailInfo.getString("vcMailTo");//收件人，多个以分号隔开
			String mailCC = sendEmailInfo.getString("vcMailCc");//抄送人，多个以分号隔开
			String mailContext = sendEmailInfo.getString("vcMailContext");//邮件发送内容
			String mailSender = sendEmailInfo.getString("vcMailSender");//邮件发送人
			String smtp = sendEmailInfo.getString("vcSmtp");//SMTP服务器地址
			String mailName = sendEmailInfo.getString("vcMailName");//如果需要用户验证，设定邮件发送人用户名
			String mailPwd = sendEmailInfo.getString("vcMailPwd");//如果需要用户验证，设定邮件发送人密码（注意：密码需要填写开启SMTP服务后设置的独立授权密码）
			String vcAttachFileName = "";//附件名称，多个以分号隔开（附件路径必须和附件名称一一对应）
			String vcAttachFilePath = "";//附件路径，多个以分号隔开（附件路径必须和附件名称一一对应）
			int i;//附件循环变量
			//创建一个支持附件的Email对象
			MultiPartEmail mail = MailFactory.getMultiEmailInstance();
		
			//设置字符集
			mail.setCharset("GBK");
			//设定主题
			mail.setSubject(title);
			//邮件收件人
			if ((null != mailTo) && (mailTo.trim().length() != 0)) {
				String[] strTo = mailTo.split(";");
				for (int j = 0; j < strTo.length; j++) {
					mail.addTo(strTo[j]);
				}
			}
			//邮件抄送人
			if ((null != mailCC) && (mailCC.trim().length() != 0)) {
				String[] strCC = mailCC.split(";");
				for (int j = 0; j < strCC.length; j++) { 
					mail.addCc(strCC[j]);
				}
			}
			//邮件发送内容
			mail.setMsg((StringUtils.isNotBlank(mailContext) ? mailContext : " "));
			//设置发件人
			mail.setFrom(mailSender);
			//设置附件
			if (attachFileNames!=null && attachFileNames.length>0) {
				for (i = 0; i < attachFileNames.length; i++) {
					//创建附件
					EmailAttachment attFile = new EmailAttachment();
					//设置附件路径
					attFile.setPath(attachFilePaths[i]);
					if(attachFileNames[i]!=null){
						//设置附件显示名称
						String strName = javax.mail.internet.MimeUtility.encodeText(attachFileNames[i]);
						attFile.setName(strName);
						mail.attach(attFile);
						if(i==attachFileNames.length-1){
							//组装附件名称和路径
							vcAttachFileName = vcAttachFileName.concat(attachFileNames[i].toString());
							vcAttachFilePath = vcAttachFilePath.concat(attachFilePaths[i].toString());
						}else{
							//组装附件名称和路径
							vcAttachFileName = vcAttachFileName.concat(attachFileNames[i].toString()+";");
							vcAttachFilePath = vcAttachFilePath.concat(attachFilePaths[i].toString()+";");
						}
					}
				}
			}
			//设置SMTP服务器地址
			mail.setHostName(smtp);
			//如果需要用户验证，设定用户名和密码，第一个参数用户名,第二个参数密码
			mail.setAuthentication(mailName, mailPwd);
			//把处理后的附件名称存到对象中
			sendEmailInfo.setString("vcAttachFileName", vcAttachFileName);
			//把处理后的附件路径存到对象中
			sendEmailInfo.setString("vcAttachFilePath", vcAttachFilePath);
			//发送邮件
			mail.send();
			//邮件发送成功标志
			sendEmailInfo.set("cStatus", "0");
			LogUtil.logInfo("已成功发送邮件，主题:"+title+",收件人："+mailTo+",抄送人："+mailCC+",邮件内容："+mailContext, null, null);
			return sendEmailInfo;
		} catch (Exception e) {
			LogUtil.logError("发送邮件异常:", e, new Object[]{});
			sendEmailInfo.set("cStatus", "1");//邮件发送失败标志
			return sendEmailInfo;
		}
		
	}
	
	
	/**
	 * @param sendEmailInfo：发送邮件实体对象
	 * @param AttachFilePath：发送邮件需要添加的附件路径（数组）
	 * @param AttachFileName：发送邮件需要添加的附件名称（数组）
	 * @return sendEmailInfo：发送邮件对象（主要是将AttachFilePath和AttachFileName处理成字符串以及把邮件发送成功失败标志反写到对象中）
	 */
	@Bizlet("发送带HTML的邮件，支持添加多个附件")
	public DataObject sendMultiMailHTML(DataObject sendEmailInfo, String[] attachFilePaths,String[] attachFileNames) throws EmailException {
		try {
		    //定义邮件属性变量
			String title = sendEmailInfo.getString("vcTitle");//邮件发送主题
			String mailTo = sendEmailInfo.getString("vcMailTo");//收件人，多个以分号隔开
			String mailCC = sendEmailInfo.getString("vcMailCc");//抄送人，多个以分号隔开
			String mailContext = sendEmailInfo.getString("vcMailContext");//邮件发送内容
			String mailSender = sendEmailInfo.getString("vcMailSender");//邮件发送人
			String smtp = sendEmailInfo.getString("vcSmtp");//SMTP服务器地址
			final String mailName = sendEmailInfo.getString("vcMailName");//如果需要用户验证，设定邮件发送人用户名
			final String mailPwd = sendEmailInfo.getString("vcMailPwd");//如果需要用户验证，设定邮件发送人密码（注意：密码需要填写开启SMTP服务后设置的独立授权密码）
			String vcAttachFileName = "";//附件名称，多个以分号隔开（附件路径必须和附件名称一一对应）
			String vcAttachFilePath = "";//附件路径，多个以分号隔开（附件路径必须和附件名称一一对应）
			int i;//附件循环变量
			//获取项目路径
		    String rootPath = MailManager.getPath();
		    //实例化邮件内容实例
			Properties properties = new Properties(); 
		
			properties.put("mail.smtp.host", smtp);// 设置smtp主机
	        properties.put("mail.smtp.auth", "true");// 使用smtp身份验证
	        /*
	     * 在 JavaMail 中，可以通过 extends Authenticator 抽象类，在子类中覆盖父类中的 getPasswordAuthentication()
	     * 方法，就可以实现以不同的方式来进行登录邮箱时的用户身份认证。JavaMail 中的这种设计是使用了策略模式（Strategy
	     * */ 
	       MimeMessage message = new MimeMessage(Session.getInstance(properties,new Authenticator() {
	              public PasswordAuthentication getPasswordAuthentication() {
	                  return new PasswordAuthentication(mailName, mailPwd);
	                 }
	               }));
	       //设置邮件的属性
	       //设置邮件的发件人
	       message.setFrom(new InternetAddress(mailSender));
	       
	       //设置邮件的主题
	       message.setSubject(title);
	       
			//邮件收件人
			if ((null != mailTo) && (mailTo.trim().length() != 0)) {
				String[] strTo = mailTo.split(";");
				InternetAddress[] address = new InternetAddress[strTo.length];
				for (int j = 0; j < strTo.length; j++) {
					address[j] = new InternetAddress(strTo[j].trim());
				}
				//设置邮件的收件人   cc表示抄送   bcc 表示暗送
			    message.setRecipients(Message.RecipientType.TO, address);
			}
			//邮件抄送人
			if ((null != mailCC) && (mailCC.trim().length() != 0)) {
				String[] strCC = mailCC.split(";");
				InternetAddress[] addressCC = new InternetAddress[strCC.length];
				for (int j = 0; j < strCC.length; j++) { 
					addressCC[j] = new InternetAddress(strCC[j].trim());
				}
				//设置邮件的收件人   cc表示抄送   bcc 表示暗送
			    message.setRecipients(Message.RecipientType.CC, addressCC);
			}
			List<String> imgArry = getImgStr(mailContext);
			for(int k =0;k<imgArry.size();k++){
				mailContext = mailContext.replace(imgArry.get(k),"cid:imgs"+k);
			}
			
			   

		       /*JavaMail API不限制信息只为文本,任何形式的信息都可能作茧自缚MimeMessage的一部分.
		        * 除了文本信息,作为文件附件包含在电子邮件信息的一部分是很普遍的.
		        * JavaMail API通过使用DataHandler对象,提供一个允许我们包含非文本BodyPart对象的简便方法.*/   
		       List<MimeBodyPart> bodyparts = new ArrayList<MimeBodyPart>();
		       for(int k = 0;k<imgArry.size();k++){
		    	   //创建图片
			       MimeBodyPart img = new MimeBodyPart();
			       //获取图片名称
			       String fileName = imgArry.get(k).substring(imgArry.get(k).lastIndexOf(File.separator),imgArry.get(k).length());
			       String serverType = ParamConfig.getValue("ZHFWPT_SERVER_TYPE");//获取URL类型：0-获取本地路径（测试环境）；1-获取设置在数据中的代理路径（生产环境）；
			       
			       //组装路径
			       String url = "";
			       if(serverType.equalsIgnoreCase("0") && serverType != null){
			    	   url = rootPath + "attached\\image\\" + DateUtil.currentDateString(DateUtil.YMD_NUMBER) + fileName;
			       }else{
			    	   url = rootPath + ProductUtil.UPLOAD_FILE_PATH_LIUYANBAN + "image/" + DateUtil.currentDateString(DateUtil.YMD_NUMBER) +  fileName;
			       }
			       
			       DataHandler dh = new DataHandler(new FileDataSource(url));
			       img.setDataHandler(dh);
			       //创建图片的一个表示用于显示在邮件中显示
			       img.setContentID("imgs"+k);
			       bodyparts.add(img);
		       }
		      
		     //实例化附件对象数组
		     List<MimeBodyPart> attchArry = new ArrayList<MimeBodyPart>();
		     //设置附件
				if (attachFileNames!=null && attachFileNames.length>0) {
					for (i = 0; i < attachFileNames.length; i++) {
						if(attachFileNames[i]!=null){
							//创建附件
						    MimeBodyPart attch = new MimeBodyPart();
						     DataHandler dh1 = new DataHandler(new FileDataSource(attachFilePaths[i]));
						     attch.setDataHandler(dh1);
						     String filename1 = dh1.getName();
						     //MimeUtility 是一个工具类，encodeText（）用于处理附件字，防止中文乱码问题
						     attch.setFileName(MimeUtility.encodeText(filename1));
						     //给数组赋值
						     attchArry.add(attch);
							if(i==attachFileNames.length-1){
								//组装附件名称和路径
								vcAttachFileName = vcAttachFileName.concat(attachFileNames[i].toString());
								vcAttachFilePath = vcAttachFilePath.concat(attachFilePaths[i].toString());
							}else{
								//组装附件名称和路径
								vcAttachFileName = vcAttachFileName.concat(attachFileNames[i].toString()+";");
								vcAttachFilePath = vcAttachFilePath.concat(attachFilePaths[i].toString()+";");
							}
						}
					}
				}
			
				//创建邮件的正文
			    MimeBodyPart text = new MimeBodyPart();
			     // setContent(“邮件的正文内容”,”设置邮件内容的编码方式”)
			     text.setContent(mailContext,"text/html;charset=gb2312");
			       
		       //关系   正文和图片的
		       MimeMultipart mm = new MimeMultipart();
		       mm.addBodyPart(text);
		       //动态给图片赋值
		       for(int z = 0;z<bodyparts.size();z++){
		    	   mm.addBodyPart(bodyparts.get(z));
		       }
		       mm.setSubType("related");//设置正文与图片之间的关系
		       for(int k =0;k<attchArry.size();k++){
		    	   mm.addBodyPart(attchArry.get(k));
		       }
		       mm.setSubType("mixed");//设置正文与附件之间的关系
		      
		       message.setContent(mm);
		       System.out.println("正文===========");
		       message.saveChanges(); //保存修改

			//把处理后的附件名称存到对象中
			sendEmailInfo.setString("vcAttachFileName", vcAttachFileName);
			//把处理后的附件路径存到对象中
			sendEmailInfo.setString("vcAttachFilePath", vcAttachFilePath);
			//发送邮件
			 Transport.send(message);//发送邮件

				//邮件发送成功标志
				sendEmailInfo.set("cStatus", "0");
			return sendEmailInfo;
		} catch (Exception e) {
			LogUtil.logError("发送邮件异常:", e, new Object[]{});
			sendEmailInfo.set("cStatus", "1");//邮件发送失败标志
			return sendEmailInfo;
		}
		
	}
	
	public static String getPath(){
		return ApplicationContext.getInstance().getWarRealPath();
	}
	
	/**
	 * 
	 * @param htmlStr 传入富文本框值
	 * @return 以list返回图片地址集合
	 */
	public static List<String> getImgStr(String htmlStr){      
        String img = "";  
        Pattern p_image;  
        Matcher m_image;  
	    List<String> pics = new ArrayList<String>();   
	    String regEx_img = "<img.*src\\s*=\\s*(.*?)[^>]*?>";  //匹配图片链接地址正则表达式
	    p_image = Pattern.compile(regEx_img, Pattern.CASE_INSENSITIVE);  
	    m_image = p_image.matcher(htmlStr);  
	    while (m_image.find()) {  
	         img = img + "," + m_image.group();  
	         // Matcher m =  
	         // Pattern.compile("src=\"?(.*?)(\"|>|\\s+)").matcher(img); //匹配src  
	         Matcher m = Pattern.compile("src\\s*=\\s*\"?(.*?)(\"|>|\\s+)").matcher(img);  
	         while (m.find()) {  
	              pics.add(m.group(1));  
	         }  
	    }  
	    return pics;  
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
			DataObject dojb = (DataObject)com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "ATS_SEND_EMAIL_INFO");
			
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
			com.eos.foundation.eoscommon.LogUtil.logError("获取邮件缓存数据失败，请检查缓存中邮件服务的相关配置;缓存key为：{0}", e, "ATS_SEND_EMAIL_INFO");
			e.printStackTrace();
		}
		
		return map;
	}
	
	/**
	 * 获取上清中债程序下载故障收件人邮箱配置
	 * @param cacheKey 缓存key值
	 * @param paramKey 参数key值
	 * @return
	 */
	@Bizlet("获取缓存信息")
	public static String getCacheInfo(String cacheKey,String paramKey){
		//定义收件人串
		String MailTo = "";
		try {
			//获取缓存中邮件信息
			DataObject dojb = (DataObject)com.eos.foundation.eoscommon.CacheUtil.getValue(cacheKey, paramKey);
			//解析邮件信息
			MailTo=dojb.getString("paramValue");
		} catch (Exception e) {
			com.eos.foundation.eoscommon.LogUtil.logError("获取邮件缓存数据失败，请检查缓存中邮件服务的相关配置;缓存key为：{0}", e, paramKey);
			e.printStackTrace();
		}
		return MailTo;
	}
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
	//测试main方法
	public static void main(String[] args) {
		/*MailManager mail = new MailManager();
		DataObject db = DataObjectUtil.createDataObject("com.cjhxfund.commonUtil.dataBase.TAtsSendmailInfo");
		db.setString("vcTitle", "二级债邮件发送功能");//邮件发送主题
		db.setString("vcMailTo", "xx@test.com;xx@qq.com");//收件人，多个以分号隔开
		db.setString("vcMailCc", "xx@qq.com");//抄送人，多个以分号隔开
		db.setString("vcMailContext", "二级债邮件发送功能测试，请勿回复，谢谢！");//邮件发送内容
		db.setString("vcMailSender", "xx@163.com");//邮件发送人
		db.setString("vcNormalMail", "xx@163.com");//默认邮件发送人（发送人为空的时候，启用默认发送人为邮件发送人）
		db.setString("vcSmtp", "smtp.163.com");//SMTP服务器地址
		db.setString("vcMailName", "xx@163.com");//如果需要用户验证，设定邮件发送人用户名
		db.setString("vcMailPwd", "xx");//如果需要用户验证，设定邮件发送人密码（注意：密码需要填写开启SMTP服务后设置的独立授权密码
		String[] AttachFilePath = {"d:/2.jpg"};
		String[] AttachFileName = {"yaoming.jpg"};
		try {
			DataObject sendMailInfo = mail.sendMultiMail(db, AttachFilePath, AttachFileName);
			if("0".equals(sendMailInfo.getString("cStatus"))){
				System.out.println("邮件发送成功！");
			}else{
				System.out.println("邮件发送失败！");
			}
		} catch (EmailException e) {
			e.printStackTrace();
			System.out.println("出现异常，邮件发送失败！");
		}*/
		//List List = getImgStr("");
		///System.out.println(List.size());
		
	}
}
