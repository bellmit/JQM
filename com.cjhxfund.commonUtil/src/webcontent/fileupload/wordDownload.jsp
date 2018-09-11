<%@page import="com.cjhxfund.commonUtil.FileDownload"%>
<%@page import="com.cjhxfund.commonUtil.ProductUtil"%>
<%@page import="com.cjhxfund.commonUtil.JavaExportDoc"%>
<%@page import="java.io.File"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%
   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
   //业务ID
   DataObject processBond =(DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"processBond");
   
   String fileName = processBond.getString("vcStockCode") + "_" + processBond.getString("vcStockName") + "_" + "新债信息表.doc";
   File file = JavaExportDoc.wordDownload("debtInfo.xml",ProductUtil.UPLOAD_FILE_PATH_DEBTINFO ,processBond,fileName);
   
   FileDownload.SingleFileDownload(file.getPath(), file.getName(), response,request);
   
   //根据应用服务器类型，关闭输出流
	//1、获取应用服务器类型
	String serverId=com.cjhxfund.commonUtil.ServerDetector.getServerId();
	//判定和关闭流
	if("tomcat".equals(serverId) || "-tomcat".equals(serverId)){
		out.clear();
		out = pageContext.pushBody();
	}else if("weblogic".equals(serverId)){
		response.reset();
	}

 %>
