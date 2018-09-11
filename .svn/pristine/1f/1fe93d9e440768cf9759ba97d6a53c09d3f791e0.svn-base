<%@page import="com.cjhxfund.jy.ProductProcess.ProductProcessUtil"%>
<%@page import="com.cjhxfund.jy.process.FileDownload"%>
<%@page import="java.io.File"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.cjhxfund.jy.process.JavaExportDoc"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>

<%
   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
   //业务ID
   DataObject processBond =(DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"processBond");
   
   String fileName = processBond.getString("investProductName") +"_" + "新债信息表.doc";
   File file = JavaExportDoc.wordDownload("发行人名称.xml",ProductProcessUtil.UPLOAD_FILE_PATH_LIUCHENG + "/" + fileName,processBond);
   
   FileDownload.SingleFileDownload(file.getPath(), file.getName(), response);
   
   //根据应用服务器类型，关闭输出流
	//1、获取应用服务器类型
	String serverId = com.cjhxfund.commonUtil.ServerDetector.getServerId();
	System.out.println("ProductProcess/PledgedRepoExport.jsp......serverId="+serverId);
	//判定和关闭流
	if("tomcat".equals(serverId) || "-tomcat".equals(serverId)){
		out.clear();
		out = pageContext.pushBody();
	}else if("weblogic".equals(serverId)){
		//response.reset();
	}
 %>
