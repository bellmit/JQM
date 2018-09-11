/**
 * 
 */
package com.cjhxfund.fpm.bpsExpend;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;

import com.eos.common.mail.MailFactory;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.system.annotation.BizletParam;
import com.eos.workflow.api.IWFWorkItemManager;
import com.eos.workflow.omservice.WIParticipantInfo;
import com.primeton.workflow.api.WFServiceException;
import commonj.sdo.DataObject;

import edu.emory.mathcs.backport.java.util.Arrays;

/**
 * @author chenpeng
 * @date 2016-04-06 09:23:04
 *
 */
@Bizlet("")
public class MailUtil {

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
	/**
	 * 
	 * @param mailType 发送邮件的类型
	 * @param bizTitle    标题
	 * @param currentActivityName  活动名称
	 * @param url           跳转地址
	 * @return mailContext    邮件内容
	 */
	@Bizlet("")
	public static String sendMailContext(String mailType,String prodName,String currentActivityName,String nextActivityName){
		String url = CommonUtil.getSysParam("mail", "url");   //获取邮件内容中系统主页地址
		Date date = new Date();
		DateFormat format = new SimpleDateFormat("yyyy年MM月dd日");
		String time = format.format(date);
		StringBuffer mailTemp = new StringBuffer("<h3>亲爱的用户：</h3><br/>您好！");
		//待办内容
		if("auditMail".equals(mailType)){
			mailTemp.append("<br/>&nbsp;&nbsp;&nbsp;&nbsp;<font style='color:red;'>"+prodName+"</font>已经完成了<font style='color:red;'>"+currentActivityName+"</font>环节,正在进行的环节是<font style='color:red;'>"+nextActivityName+"</font>,您可登录到产品生命周期系统查询相关信息！");
		}
		//退办内容
		if(mailType.indexOf("backMail") != -1){
			mailTemp.append("<br/>&nbsp;&nbsp;&nbsp;&nbsp;<font style='color:red;'>"+prodName+"</font>已经从<font style='color:red;'>"+currentActivityName+"</font>环节退办到<font style='color:red;'>"+nextActivityName+"</font>环节,您可登录到产品生命周期系统查询相关信息！");
		}
		//只读内容
		if(mailType.indexOf("viewMail") != -1){
			mailTemp.append("<br/>&nbsp;&nbsp;&nbsp;&nbsp;<font style='color:red;'>"+prodName+"</font>已经通过了<font style='color:red;'>"+currentActivityName+"</font>环节,正在进行的环节是<font style='color:red;'>"+nextActivityName+"</font>,您可登录到产品生命周期系统查询相关信息！");
		}
		//征求意见内容
		if(mailType.indexOf("suggestMail") != -1){
			mailTemp.append("<br/>&nbsp;&nbsp;&nbsp;&nbsp;征求意见邮件");
		}
		//已完成内容
		if(mailType.indexOf("finishMail") != -1){
			mailTemp.append("<br/>&nbsp;&nbsp;&nbsp;&nbsp;<font style='color:red;'>"+prodName+"</font>已经顺利完成了,您可登录到产品生命周期系统查询相关信息！");
		}
		//审批完成内容
		if(mailType.indexOf("reviewMail") != -1){
			mailTemp.append("<br/>&nbsp;&nbsp;&nbsp;&nbsp;<font style='color:red;'>"+prodName+"</font>已经通过评审,您可登录到产品生命周期系统查询相关信息！");
		}
		//专户设计关联方信息
		if (mailType.indexOf("relatedPartyMail") != -1) {
			String[] str = prodName.split("@");
			mailTemp.append("<br/>&nbsp;&nbsp;&nbsp;&nbsp;<font style='color:red;'>"+str[1]+"</font>已完成了设计评审环节,"+str[0]);
		}
		//公募用印通知内容
		if (mailType.indexOf("pubSealMail") != -1) {
			mailTemp.append("<br/>&nbsp;&nbsp;&nbsp;&nbsp;<font style='color:red;'>"+prodName+"</font>有需要您用印的文件,请登录到产品生命周期系统查询相关信息！");
		}
		//账户有效期截止提醒mailType中后面包含剩余天数
		if(mailType.indexOf("accountTipsMail")>-1){
			int flagDay = Integer.parseInt(mailType.replace("accountTipsMail", ""));
			String[] str = prodName.split("@");
			if(str.length==2){
				mailTemp.append("<br/>&nbsp;&nbsp;&nbsp;&nbsp;<font style='color:red;'>"+str[0]+"</font>产品的<font style='color:red;'>"+str[1]+"账户</font>距离账户有效期截止日期剩余"+flagDay+"天,请尽快处理,您可登录到产品生命周期系统查询相关信息！");
			} else if (str.length==3){
				mailTemp.append("<br/>&nbsp;&nbsp;&nbsp;&nbsp;<font style='color:red;'>"+str[0]+"</font>产品的<font style='color:red;'>"+str[1]+"("+str[2]+")</font>距离账户有效期截止日期剩余"+flagDay+"天,请尽快处理,您可登录到产品生命周期系统查询相关信息！");
			}
		}
		mailTemp.append("<br/><br/><br/><a href='"+url+"'>"+url+"</a>"+
				"<br/><br/><br/>产品生命周期管理系统"+
				"<br/>"+time);
		String mailContext = mailTemp.toString();
		return mailContext;
	}
	
	//return 0:无法送邮件;-1:发送失败;-2:sysParam属性错误;大于0:发送邮件次数
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
	public static int sendHtmlMail(String Title,String MailContext,String MailTo, 
			String MailCC,String[] AttachFilePath,String[] AttachFileName) throws EmailException {
		String mailState = CommonUtil.getSysParam("mail", "state");
		int flag = 0;
		System.out.println("-----------邮件发送开始------------");
		if("on".equals(mailState)){
			String smtp = CommonUtil.getSysParam("mail", "smtp");//SMTP服务器地址
			String mailSender = CommonUtil.getSysParam("mail", "mailSender");//发送人邮箱地址
			String normalMail = CommonUtil.getSysParam("mail", "normalMail");//默认发送人邮箱地址
			String mailName = CommonUtil.getSysParam("mail", "mailName");
			String mailPwd = CommonUtil.getSysParam("mail", "mailPwd");
			//定义临时变量
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
			if (mailSender.trim().equals("")) {
				//设定默认发送者邮件地址
				mail.setFrom(normalMail);
			} else {
				//设定发送者邮件地址
				mail.setFrom(mailSender);
			}
			//设置发送对象
			if ((null != MailTo) && (MailTo.trim().length() != 0)) {
				String[] strTo = MailTo.split(";");
				iLen = strTo.length;
				for (i = 0; i < iLen; i++) {
					if(null!=strTo[i] && !"null".equals(strTo[i])&&!"".equals(strTo[i])) {
						mail.addTo(strTo[i]);
					}
				}
				mail.addTo("zhoukaiyu@cjhxfund.com");
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
				System.out.println("附件异常");
			}
			System.out.println(MailContext);
			//发送邮件
			mail.send();
			flag += 1;
			System.out.println("---------发送成功----------");
			return flag;
		} else if("off".equals(mailState)) {
			System.out.println("---------邮件状态没开----------");
			return 0;
		} else {
			System.out.println("--------发送异常----------");
			return -2;
		}
	}
	
	@Bizlet("发送邮件")
	public static int sendMail(String sendType,String prodName,String currentActivityName,String nextActivityName,
			String MailTo,String MailCC,String[] AttachFilePath,String[] AttachFileName){
		int sendFlag = 0;
		if(sendType!=null&&!"".equals(sendType)){  //判断非空
			String[] mailTypes = sendType.split(",");     //分离发送类型
			for(int i = 0; i < mailTypes.length; i++){
				String mailType = mailTypes[i];
				if(mailType.indexOf("Mail")>-1){			 //判断发送类型是否邮件
					//获取邮件标题
					String mailTitle = CommonUtil.getSysParam("mail", "mailTitle");
					System.out.println("邮件标题："+mailTitle);
					//设置邮件内容
					String mailContext = MailUtil.sendMailContext(mailType, prodName, currentActivityName,nextActivityName);
					System.out.println("邮件内容："+mailContext);
					System.out.println("邮件接收人："+MailTo);
					//发送邮件
					try {
						sendFlag = MailUtil.sendHtmlMail(mailTitle, mailContext, MailTo, MailCC, AttachFilePath, AttachFileName);
					} catch (EmailException e) {
						e.printStackTrace();
					}
				}else{
					System.out.println("sendType中不含有'Mail',所以不发邮件");
				}
			}
		}
		return sendFlag;
	}
	/**
	 * 
	 * @param workItem    
	 * @param sendUserMail   发送人地址
	 * @return
	 */
	@Bizlet("获取工作项中参与人邮件地址")
	public static String setPartMailByNextWorkItem(DataObject workItem,String sendUserMail){
		StringBuilder mailStr = new StringBuilder();
		String mailAddress = CommonUtil.getSysParam("mail", "mailAddress");   //获取邮件后缀地址
		List<WIParticipantInfo> wp = new ArrayList<WIParticipantInfo>();
		if(sendUserMail==null||"".equals(sendUserMail)) {
			System.out.println("当前操作人没有邮箱地址");
			return null;
		}
		try {
			Long workItemID = workItem.getLong("workItemID");
			IWFWorkItemManager workItemManager = ServiceFactory.getWFWorkItemManager();
			wp =  workItemManager.queryWorkItemParticipantInfo(workItemID);
		} catch (WFServiceException e) {
			e.printStackTrace();
		}
		for(int j = 0; j < wp.size(); j++){
			if(wp!=null&&"role".equals(wp.get(j).getTypeCode())){
				String partiname = workItem.getString("partiName");
				DataObject qroleTemp = DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsExpend.coframe.QRoleEmp");//实例化数据对象
				qroleTemp.set("roleName", partiname);
				DataObject[] qrole = DatabaseUtil.queryEntitiesByTemplate("default", qroleTemp);
				for(int k = 0; k < qrole.length; k++){
					String empid = qrole[k].getString("empid");
					String toUserMail = getEmails(sendUserMail, empid, mailAddress);
					mailStr.append(mailStr.length() == 0 ? toUserMail : (";" + toUserMail));
				}
			}
			else{
				String toUserMail = getEmails(sendUserMail, wp.get(j).getId(), mailAddress);
				mailStr.append(mailStr.length() == 0 ? toUserMail : (";" + toUserMail));
			}
		}
		System.out.println("该邮件应发送至  ：****************   " + mailStr.toString() + "  ****************");
		return mailStr.toString();
	}
	
	private static String getEmails(String sendUserMail, String empid ,String mailAddress){
		StringBuilder mailStr = new StringBuilder();
		DataObject emp = DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsExpend.coframe.OrgEmployee");//实例化数据对象
		emp.set("empid", empid);
		DataObject[] emps = DatabaseUtil.queryEntitiesByTemplate("default", emp);
		if (emps.length == 0) return null;
		for(int k = 0;k < emps.length; k++){
			String oaUserMail = emps[k].getString("oemail");
			String personUserMail = emps[k].getString("pemail");
			String toUserMail = oaUserMail != null ? oaUserMail : (personUserMail!=null ? personUserMail : (emps[k].getString("userid") + mailAddress));
			if(sendUserMail.equals(toUserMail)) continue;
			mailStr.append((mailStr.length() == 0) ? toUserMail : (";" + toUserMail));
		}
		return mailStr.toString();
	}
	
	public static void main(String[] args) {
	 /*try{	
		MultiPartEmail mail = MailFactory.getMultiEmailInstance();
		// 设置SMTP服务器地址 "smtp.qq.com","smtp.163.com"
		mail.setHostName("mail.cjhxfund.com");
		mail.setSmtpPort(25);
		// 如果需要用户验证，设定用户名和密码"1039256923", "000000"
		mail.setAuthentication("cj_itsupport","A+12345678");
		// 设定收件人邮件地址
		mail.addTo("15277000230@139.com");
		
		
		// 设定发送者邮件地址
		mail.setFrom("cj_itsupport@cjhxfund.com");
		//mail.setFrom("wmsalert@livzon.cn");
        // 设定主题
		mail.setSubject("321");
		// 设定消息内容
		mail.setMsg("<html><div>你好测试</div></html>");
		sendHtmlMail("123", "15277000230@139.com", null, "你好测试", "cjItsvc@fcsc.com", null, null, "mail.cjhxfund.com", "cjItsvc", "A+12345678", "cjItsvc@fcsc.com");
		//String a = mail.send();
		//System.out.println(a);
	 }catch(EmailException  e){
		 e.printStackTrace();
	 }*/
		/*-------------------------1--------------------------------*/
		/*int newSheetIndex = 0;
		int newCellIndex = 3;
		int newStartRow = 1;
		int newCompareCell = 0;//新的比较列
		int newConditionCell = 1;//条件列
		int oldSheetIndex = 2;
		int oldCellIndex = 0;
		int oldStartRow = 1;
		int oldCompareCell = 9;//旧的比较列
		int compareKey = 1;
		String filePatch = "E:\\FPMS\\doc\\2. 项目需求\\需求\\需求_开户流程1.4\\数据比对\\生产数据\\交易席位.xls";*/
		/*-------------------------1--------------------------------*/
		/*-------------------------2--------------------------------*/
		/*int newSheetIndex = 0;
		int newCellIndex = 3;
		int newStartRow = 1;
		int newCompareCell = 0;//新的比较列
		int newConditionCell = 1;//条件列
		int oldSheetIndex = 2;
		int oldCellIndex = 0;
		int oldStartRow = 1;
		int oldCompareCell = 9;//旧的比较列
		int compareKey = 2;
		String filePatch = "E:\\FPMS\\doc\\2. 项目需求\\需求\\需求_开户流程1.4\\数据比对\\生产数据\\交易股东.xls";*/
		/*-------------------------2--------------------------------*/
		/*-------------------------3本方账户--------------------------------*/
		/*int newSheetIndex = 0;
		int newCellIndex = 4;
		int newStartRow = 1;
		int newCompareCell = 5;//新的比较列
		int newConditionCell = 3;//条件列
		int oldSheetIndex = 0;
		int oldCellIndex = 8;
		int oldStartRow = 1;
		int oldCompareCell = 9;//旧的比较列
		int compareKey = 3;
		String filePatch = "E:\\FPMS\\doc\\2. 项目需求\\需求\\需求_开户流程1.4\\数据比对\\生产数据\\划款指令帐户信息.xls";*/
		/*-------------------------3本方账户--------------------------------*/
		/*-------------------------4--------------------------------*/
		/*int newSheetIndex = 0;
		int newCellIndex = 4;
		int newStartRow = 1;
		int newCompareCell = 0;//新的比较列
		int newConditionCell = 1;//条件列
		int oldSheetIndex = 3;
		int oldCellIndex = 0;
		int oldStartRow = 1;
		int oldCompareCell = 9;//旧的比较列
		int compareKey = 4;
		String filePatch = "E:\\FPMS\\doc\\2. 项目需求\\需求\\需求_开户流程1.4\\数据比对\\生产数据\\期货交易股东.xls";*/
		/*-------------------------4--------------------------------*/
		/*-------------------------5期货保证金--------------------------------*/
		/*int newSheetIndex = 0;
		int newCellIndex = 1;
		int newStartRow = 1;
		int newCompareCell = 5;//新的比较列
		int newConditionCell = 3;//条件列
		int oldSheetIndex = 3;
		int oldCellIndex = 0;
		int oldStartRow = 1;
		int oldCompareCell = 9;//旧的比较列
		int compareKey = 5;
		String filePatch = "E:\\FPMS\\doc\\2. 项目需求\\需求\\需求_开户流程1.4\\数据比对\\生产数据\\划款指令帐户信息.xls";*/
		/*-------------------------5期货保证金--------------------------------*/
		/*-------------------------6--------------------------------*/
		/*int newSheetIndex = 0;
		int newCellIndex = 2;
		int newStartRow = 1;
		int newCompareCell = 5;//新的比较列
		int newConditionCell = 3;//条件列
		int oldSheetIndex = 1;
		int oldCellIndex = 0;
		int oldStartRow = 1;
		int oldCompareCell = 9;//旧的比较列
		int compareKey = 6;
		String filePatch = "E:\\FPMS\\doc\\2. 项目需求\\需求\\需求_开户流程1.4\\数据比对\\生产数据\\银行间债券账户.xls";*/
		/*----------------------6-----------------------------------*/
		/*-------------------------7--------------------------------*/
		/*int newSheetIndex = 0;
		int newCellIndex = 1;
		int newStartRow = 1;
		int newCompareCell = 3;//新的比较列
		int newConditionCell = 3;//条件列
		int oldSheetIndex = 2;
		int oldCellIndex = 0;
		int oldStartRow = 1;
		int oldCompareCell = 9;//旧的比较列
		int compareKey = 7;
		String filePatch = "E:\\FPMS\\doc\\2. 项目需求\\需求\\需求_开户流程1.4\\数据比对\\生产数据\\结算参与人编号.xls";*/
		/*-------------------------7--------------------------------*/
		/*-------------------------8--------------------------------*/
		/*int newSheetIndex = 0;
		int newCellIndex = 1;
		int newStartRow = 1;
		int newCompareCell = 3;//新的比较列
		int newConditionCell = 3;//条件列
		int oldSheetIndex = 3;
		int oldCellIndex = 0;
		int oldStartRow = 1;
		int oldCompareCell = 4;//旧的比较列
		int compareKey = 7;
		String filePatch = "E:\\FPMS\\doc\\2. 项目需求\\需求\\需求_开户流程1.4\\数据比对\\生产数据\\期货资金账号.xls";*/
		/*-------------------------8--------------------------------*/
		/*-------------------------9--------------------------------*/
		int newSheetIndex = 0;
		int newCellIndex = 0;
		int newStartRow = 1;
		int newCompareCell = 1;//新的比较列
		int newConditionCell = 3;//条件列
		int oldSheetIndex = 2;
		int oldCellIndex = 6;
		int oldStartRow = 1;
		int oldCompareCell = 7;//旧的比较列
		int compareKey = 7;
		String filePatch = "E:\\FPMS\\doc\\2. 项目需求\\需求\\需求_开户流程1.4\\数据比对\\生产数据\\主席位.xls";
		/*-------------------------9--------------------------------*/
		Workbook newwb;
		Workbook oldwb;
		try {
			File newFile = new File(filePatch);
			newwb = Workbook.getWorkbook(newFile);
			Sheet newSheet=newwb.getSheet(newSheetIndex);
	        //int newClos=newSheet.getColumns();//得到所有的列
	        int newRows=newSheet.getRows();//得到所有的行
	        File oldFile = new File("E:\\FPMS\\doc\\2. 项目需求\\需求\\需求_开户流程1.4\\数据比对\\开户信息_20160619164041.xls");
	       oldwb = Workbook.getWorkbook(oldFile);
			Sheet oldSheet=oldwb.getSheet(oldSheetIndex);
			//int oldClos=oldSheet.getColumns();//得到所有的列
	        int oldRows=oldSheet.getRows();//得到所有的行
	        Map<String,List<Integer>> newMap = new LinkedHashMap<String,List<Integer>>();
	        Map<String,List<Integer>> oldMap = new LinkedHashMap<String,List<Integer>>();
	        for (int i = newStartRow; i < newRows; i++) {
	        	Cell[] cell = newSheet.getRow(i);
	        	if(cell[newCellIndex]!=null&&cell[newCellIndex].getContents()!=null&&cell[newCellIndex].getContents().length()>0){
	        		if(newMap.get(cell[newCellIndex].getContents())==null){
	        			if(compareKey==3){
	        				if("本方账户".equals(cell[newConditionCell].getContents())){
	        					List<Integer> rowIndex = new ArrayList<Integer>();
		        				rowIndex.add(i);
		        				newMap.put(cell[newCellIndex].getContents(), rowIndex);
	        				}
	        			}else if(compareKey==5){
	        				if("期货保证金".equals(cell[newConditionCell].getContents())){
	        					List<Integer> rowIndex = new ArrayList<Integer>();
		        				rowIndex.add(i);
		        				newMap.put(cell[newCellIndex].getContents(), rowIndex);
	        				}
	        			}else{
	        				List<Integer> rowIndex = new ArrayList<Integer>();
	        				rowIndex.add(i);
	        				newMap.put(cell[newCellIndex].getContents(), rowIndex);
	        			}
	        			continue;
	        		}
	        		if(compareKey==3){
        				if("本方账户".equals(cell[newConditionCell].getContents())){
        					newMap.get(cell[newCellIndex].getContents()).add(i);
        				}
        			}else if(compareKey==5){
        				if("期货保证金".equals(cell[newConditionCell].getContents())){
        					newMap.get(cell[newCellIndex].getContents()).add(i);
        				}
        			}else{
        				newMap.get(cell[newCellIndex].getContents()).add(i);
        			}
	        	}
	        }
	        for (int i = oldStartRow; i < oldRows; i++) {
	        	Cell[] cell = oldSheet.getRow(i);
	        	if(cell[oldCellIndex]!=null&&cell[oldCellIndex].getContents()!=null&&cell[oldCellIndex].getContents().length()>0){
	        		if(oldMap.get(cell[oldCellIndex].getContents())==null){
	        			List<Integer> rowIndex = new ArrayList<Integer>();
	        			rowIndex.add(i);
	        			oldMap.put(cell[oldCellIndex].getContents(), rowIndex);
	        			continue;
	        		}
	        		oldMap.get(cell[oldCellIndex].getContents()).add(i);
	        	}
	        }
	        StringBuffer sb = new StringBuffer();
	        StringBuffer stringBuf = null;
	        for(String cellStr : newMap.keySet()){
	        	if(oldMap.get(cellStr)!=null){
	        		List<Integer> newRowList = newMap.get(cellStr);
        			List<Integer> oldRowList = oldMap.get(cellStr);
        			 Map<String,Integer> istrueMap = new HashMap<String,Integer>();
        			 if(stringBuf!=null&&stringBuf.toString().length()>0&&compareKey==1){
        				 sb.append(stringBuf.toString());
        			 }
        			 stringBuf= new StringBuffer();
        			outer:for(int newRowIndex :newRowList){
        				StringBuffer stringBuffer = null;
        				Cell[] newCells = newSheet.getRow(newRowIndex);
        				switch (compareKey) {
						case 1:
							/*----------------------------交易席位-----------------------------------------*/
							stringBuffer = new StringBuffer();
							String newCellStr = newCells[2].getContents();
							String newCellStrSub = newCellStr.substring(0, 4);
							if(istrueMap.get(newCellStrSub)==null){
								istrueMap.put(newCellStrSub, 0);
							}
							if(istrueMap.get(newCellStrSub)!=3){
								if("上海".equals(newCells[newConditionCell].getContents())||"港股通".equals(newCells[newConditionCell].getContents())){
									if(istrueMap.get(newCellStrSub)==1){
										continue outer;
									}else{
										for(int oldRowIndex :oldRowList){
											Cell[] oldCells = oldSheet.getRow(oldRowIndex);
											if(newCells[newCompareCell].getContents().equals(oldCells[8].getContents())){
												if(istrueMap.get(newCellStrSub)==2){
													istrueMap.put(newCellStrSub, 3);
													stringBuf = new StringBuffer();
													break outer;
												}else{
													istrueMap.put(newCellStrSub, 1);
													continue outer;
												}
												//sb.append(getExcelColumnName(newCompareCell)+"列与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行第"+getExcelColumnName(8)+"列数据一致");
											}else{
												stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
												stringBuffer.append(getExcelColumnName(newCompareCell)+"列"+newCells[newCompareCell].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行"+
														getExcelColumnName(8)+"列"+oldCells[8].getContents()+"数据不一致");
												stringBuffer.append(System.getProperty("line.separator"));
											}
										}
									}
								}else if("深圳".equals(newCells[newConditionCell].getContents())){
									if(istrueMap.get(newCellStrSub)==2){
										continue outer;
									}else{
										for(int oldRowIndex :oldRowList){
											Cell[] oldCells = oldSheet.getRow(oldRowIndex);
											if(newCells[newCompareCell].getContents().equals(oldCells[6].getContents())){
												if(istrueMap.get(newCellStrSub)==1){
													istrueMap.put(newCellStrSub, 3);
													stringBuf = new StringBuffer();
													break outer;
												}else{
													istrueMap.put(newCellStrSub, 2);
													continue outer;
												}
												//sb.append(getExcelColumnName(newCompareCell)+"列与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行第"+getExcelColumnName(6)+"列数据一致");
											}else{
												stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
												stringBuffer.append(getExcelColumnName(newCompareCell)+"列"+newCells[newCompareCell].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行"+
														getExcelColumnName(6)+"列"+oldCells[6].getContents()+"数据不一致");
												stringBuffer.append(System.getProperty("line.separator"));
											}
										}
									}
								}else{
									stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
									stringBuffer.append(getExcelColumnName(newCompareCell)+"列"+newCells[newCompareCell].getContents()+"没有匹配项");
									stringBuffer.append(System.getProperty("line.separator"));
								}
								stringBuf.append(stringBuffer.toString());
								//sb.append(stringBuffer.toString());
							}
							/*-----------------------------交易席位----------------------------------------*/
							break;
						case 2:
							/*----------------------------交易股东-----------------------------------------*/
							stringBuffer = new StringBuffer();
							if("上海".equals(newCells[newConditionCell].getContents())){
								for(int oldRowIndex :oldRowList){
									Cell[] oldCells = oldSheet.getRow(oldRowIndex);
									if(newCells[newCompareCell].getContents().equals(oldCells[4].getContents())){
										break outer;
										//sb.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行");
										//sb.append(getExcelColumnName(newCompareCell)+"列与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行"+getExcelColumnName(4)+"列数据一致");
										//sb.append(System.getProperty("line.separator"));
									}else{
										stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
										stringBuffer.append(getExcelColumnName(newCompareCell)+"列"+newCells[newCompareCell].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+
												"行"+getExcelColumnName(4)+"列"+oldCells[4].getContents()+"数据不一致");
										stringBuffer.append(System.getProperty("line.separator"));
									}
								}
							}else if("深圳".equals(newCells[newConditionCell].getContents())){
								for(int oldRowIndex :oldRowList){
									Cell[] oldCells = oldSheet.getRow(oldRowIndex);
									if(newCells[newCompareCell].getContents().equals(oldCells[5].getContents())){
										break outer;
										//sb.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行");
										//sb.append(getExcelColumnName(newCompareCell+1)+"列与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行第"+getExcelColumnName(5)+"列数据一致");
										//sb.append(System.getProperty("line.separator"));
									}else{
										stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
										stringBuffer.append(getExcelColumnName(newCompareCell)+"列"+newCells[newCompareCell].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+
												"行"+getExcelColumnName(5)+"列"+oldCells[5].getContents()+"数据不一致");
										stringBuffer.append(System.getProperty("line.separator"));
									}
								}
							}else{
								stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
								stringBuffer.append(getExcelColumnName(newCompareCell)+"列"+newCells[newCompareCell].getContents()+"没有匹配项");
								stringBuffer.append(System.getProperty("line.separator"));
							}
							sb.append(stringBuffer.toString());
							/*-----------------------------交易股东----------------------------------------*/
							break;
						case 3:
						case 7:
							/*-----------------------------划款指令----------------------------------------*/
							stringBuffer = new StringBuffer();
							for(int oldRowIndex :oldRowList){
								Cell[] oldCells = oldSheet.getRow(oldRowIndex);
								if(newCells[newCompareCell].getContents().equals(oldCells[oldCompareCell].getContents())){
									//sb.append(getExcelColumnName(newCompareCell)+"列与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行"+getExcelColumnName(oldCompareCell)+"列数据一致");
									//stringBuffer.append(System.getProperty("line.separator"));
									break outer;
								}else{
									stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
									stringBuffer.append(getExcelColumnName(newCompareCell)+"列"+newCells[newCompareCell].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行"
											+getExcelColumnName(oldCompareCell)+"列"+oldCells[oldCompareCell].getContents()+"数据不一致");
									stringBuffer.append(System.getProperty("line.separator"));
								}
							}
							sb.append(stringBuffer.toString());
							break;
							/*-----------------------------划款指令----------------------------------------*/
						case 4:
							/*-----------------------------期货交易股东----------------------------------------*/
							stringBuffer = new StringBuffer();
							if("套保".equals(newCells[newConditionCell].getContents())){
								for(int oldRowIndex :oldRowList){
									Cell[] oldCells = oldSheet.getRow(oldRowIndex);
									if(newCells[newCompareCell].getContents().equals(oldCells[6].getContents())){
										break outer;
										//sb.append(getExcelColumnName(newCompareCell)+"列与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行"+getExcelColumnName(6)+"列数据一致");
									}else{
										stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
										stringBuffer.append(getExcelColumnName(newCompareCell)+"列"+newCells[newCompareCell].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行"
												+getExcelColumnName(6)+"列"+oldCells[6].getContents()+"数据不一致");
										stringBuffer.append(System.getProperty("line.separator"));
									}
								}
							}else if("投机".equals(newCells[newConditionCell].getContents())){
								for(int oldRowIndex :oldRowList){
									Cell[] oldCells = oldSheet.getRow(oldRowIndex);
									if(newCells[newCompareCell].getContents().equals(oldCells[8].getContents())){
										break outer;
										//sb.append(getExcelColumnName(newCompareCell)+"列与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行"+getExcelColumnName(8)+"列数据一致");
									}else{
										stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
										stringBuffer.append(getExcelColumnName(newCompareCell)+"列"+newCells[newCompareCell].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行"
												+getExcelColumnName(8)+"列"+oldCells[8].getContents()+"数据不一致");
										stringBuffer.append(System.getProperty("line.separator"));
									}
								}
							}else{
								stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
								stringBuffer.append(getExcelColumnName(newCompareCell)+"列"+newCells[newCompareCell].getContents()+"没有匹配项");
								stringBuffer.append(System.getProperty("line.separator"));
							}
							sb.append(stringBuffer.toString());
							break;
							/*-----------------------------期货交易股东----------------------------------------*/
						case 5:
							/*-----------------------------划款指令----------------------------------------*/
							stringBuffer = new StringBuffer();
							for(int oldRowIndex :oldRowList){
								Cell[] oldCells = oldSheet.getRow(oldRowIndex);
								if(newCells[newCompareCell].getContents().equals(oldCells[oldCompareCell].getContents())){
									break outer;
									//sb.append(getExcelColumnName(newCompareCell)+"列与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行"+getExcelColumnName(oldCompareCell)+"列数据一致");
								}else{
									stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
									stringBuffer.append(getExcelColumnName(newCompareCell)+"列"+newCells[newCompareCell].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行"
											+getExcelColumnName(oldCompareCell)+"列"+oldCells[oldCompareCell].getContents()+"数据不一致");
									stringBuffer.append(System.getProperty("line.separator"));
								}
							}
							sb.append(stringBuffer.toString());
							/*-----------------------------划款指令----------------------------------------*/
							break;
						case 6:
							/*-----------------------------银行间----------------------------------------*/
							stringBuffer = new StringBuffer();
							if("上清所DVP账户".equals(newCells[newConditionCell].getContents())){
								for(int oldRowIndex :oldRowList){
									int istrue = 0;
									Cell[] oldCells = oldSheet.getRow(oldRowIndex+1);
									if(newCells[4].getContents().equals(oldCells[4].getContents())){
										istrue++;
									}else{
										stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
										stringBuffer.append(getExcelColumnName(4)+"列"+newCells[4].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+1+oldStartRow)+"行"
												+getExcelColumnName(4)+"列"+oldCells[4].getContents()+"数据不一致");
										stringBuffer.append(System.getProperty("line.separator"));
									}
									oldCells = oldSheet.getRow(oldRowIndex);
									if(newCells[5].getContents().equals(oldCells[4].getContents())){
										istrue++;
									}else{
										stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
										stringBuffer.append(getExcelColumnName(5)+"列"+newCells[5].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行"
												+getExcelColumnName(4)+"列"+oldCells[4].getContents()+"数据不一致");
										stringBuffer.append(System.getProperty("line.separator"));
									}
									oldCells = oldSheet.getRow(oldRowIndex+4);
									if(newCells[6].getContents().equals(oldCells[4].getContents())){
										istrue++;
									}else{
										stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
										stringBuffer.append(getExcelColumnName(6)+"列"+newCells[6].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+4+oldStartRow)+"行"
												+getExcelColumnName(4)+"列"+oldCells[4].getContents()+"数据不一致");
										stringBuffer.append(System.getProperty("line.separator"));
									}
									oldCells = oldSheet.getRow(oldRowIndex+5);
									if(newCells[7].getContents().equals(oldCells[4].getContents())){
										istrue++;
									}else{
										stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
										stringBuffer.append(getExcelColumnName(7)+"列"+newCells[7].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+5+oldStartRow)+"行"
												+getExcelColumnName(4)+"列"+oldCells[4].getContents()+"数据不一致");
										stringBuffer.append(System.getProperty("line.separator"));
									}
									if(istrue==4){
										break outer;
									}
									sb.append(stringBuffer.toString());
								}
							}else if("中债登DVP账户".equals(newCells[newConditionCell].getContents())){
								for(int oldRowIndex :oldRowList){
									int istrue = 0;
									Cell[] oldCells = oldSheet.getRow(oldRowIndex+1);
									if(newCells[4].getContents().equals(oldCells[8].getContents())){
										istrue++;
									}else{
										stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
										stringBuffer.append(getExcelColumnName(4)+"列"+newCells[4].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+1+oldStartRow)+"行"
												+getExcelColumnName(8)+"列"+oldCells[8].getContents()+"数据不一致");
										stringBuffer.append(System.getProperty("line.separator"));
									}
									oldCells = oldSheet.getRow(oldRowIndex);
									if(newCells[5].getContents().equals(oldCells[8].getContents())){
										istrue++;
									}else{
										stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
										stringBuffer.append(getExcelColumnName(5)+"列"+newCells[5].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+oldStartRow)+"行"
												+getExcelColumnName(8)+"列"+oldCells[8].getContents()+"数据不一致");
										stringBuffer.append(System.getProperty("line.separator"));
									}
									oldCells = oldSheet.getRow(oldRowIndex+4);
									if(newCells[6].getContents().equals(oldCells[8].getContents())){
										istrue++;
									}else{
										stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
										stringBuffer.append(getExcelColumnName(6)+"列"+newCells[6].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+4+oldStartRow)+"行"
												+getExcelColumnName(8)+"列"+oldCells[8].getContents()+"数据不一致");
										stringBuffer.append(System.getProperty("line.separator"));
									}
									oldCells = oldSheet.getRow(oldRowIndex+5);
									if(newCells[7].getContents().equals(oldCells[8].getContents())){
										istrue++;
									}else{
										stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
										stringBuffer.append(getExcelColumnName(7)+"列"+newCells[7].getContents()+"与"+oldwb.getSheet(oldSheetIndex).getName()+"第"+(oldRowIndex+5+oldStartRow)+"行"
												+getExcelColumnName(8)+"列"+oldCells[8].getContents()+"数据不一致");
										stringBuffer.append(System.getProperty("line.separator"));
									}
									if(istrue==4){
										break outer;
									}
									sb.append(stringBuffer.toString());
								}
							}else{
								stringBuffer.append(newFile.getName()+"第"+(newRowIndex+newStartRow)+"行"+getExcelColumnName(newCellIndex)+"列"+newCells[newCellIndex].getContents()+",");
								stringBuffer.append(getExcelColumnName(newCompareCell)+"列"+newCells[newCompareCell].getContents()+"没有匹配项");
								stringBuffer.append(System.getProperty("line.separator"));
							}
							/*-----------------------------银行间----------------------------------------*/
							break;
						default:
							break;
						}
        			}
        		}else{
        			int[] array = new int[newMap.get(cellStr).size()];
        			int i =0;
        			for(int value :newMap.get(cellStr)){
        				array[i]=value+newStartRow;
        				i++;
        			}
        			sb.append(newFile.getName()+"第"+Arrays.toString(array)+"行"+getExcelColumnName(newCellIndex)+"列"+cellStr+"没有匹配项"+System.getProperty("line.separator"));
        		}
	        }
	        newwb.close();
	        oldwb.close();
	        BufferedWriter bw = new BufferedWriter(new FileWriter("D://"+newFile.getName()+"和"+oldwb.getSheet(oldSheetIndex).getName()+"比较结果"+System.currentTimeMillis()+".txt"));
	        bw.write(sb.toString());
	        bw.close();
		} catch (BiffException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private static void setExcelColumnName(StringBuilder str, int col){
	    int tmp = col / 26;
	    if(tmp > 26){
	        setExcelColumnName(str, tmp - 1);
	    }else if(tmp > 0){
	        str.append((char)(tmp + 64));
	    }
	    str.append((char)(col % 26 + 65));
	}
	 
	public static String getExcelColumnName(int col) {
	    StringBuilder str = new StringBuilder(2);
	    setExcelColumnName(str, col);
	    return str.toString();
	}
	
	/**
	 * 跟均下一活动是否为空，判断当前活动是已完结，还是代办当中的
	 * @param sendType 发送类型
	 * @param nextActivityInstName 下一环节轰动名称
	 * @param currentActivity 当前活动名称
	 * @return 返回精确的发送类型
	 */
	@Bizlet("")
	public static String setSendType(String sendType,String nextActivityInstName,String currentActivity){
		//返回的字符串
		StringBuilder type = new StringBuilder();
		
		if(null!=sendType&&!"".equals(sendType)){
			
			//截取sendType,防止最后一位是“，”,对其截取，保持数据的纯净
			if(sendType.lastIndexOf(",")==(sendType.length()-1))sendType=sendType.substring(0, sendType.length()-1);
			String sendTypes[]=sendType.split(",");	
			
			//当前流程状态
			String flowState = "audit";
			if (nextActivityInstName == null || nextActivityInstName.equals("")) flowState = "finish";
			
			for (int i = 0; i < sendTypes.length; i++) {
				if (sendTypes[i].length() < 8) type.append(flowState);
				type.append(sendTypes[i]);
				if (i != sendTypes.length-1) type.append(",");
			}
		}
		return type.toString();
	}
}
