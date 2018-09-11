<%@page import="com.cjhxfund.jy.process.FileDownload"%>
<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<%
   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
   //excl路劲
   
   String  filepath = (String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"filepath");
   Boolean  flag = (Boolean)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"flag");
   String  fileName = (String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"fileName");
   if(fileName.indexOf("(")>0 || fileName.indexOf(")")>0){
   		fileName = fileName.replace("(", "（");
   		fileName = fileName.replace(")", "）");
   }
   if(flag){
   		FileDownload.SingleFileDownload(filepath,fileName , request,response);
   }
   //根据应用服务器类型，关闭输出流
	//1、获取应用服务器类型
	String serverId=com.cjhxfund.commonUtil.ServerDetector.getServerId();
	//判定和关闭流
	if("tomcat".equals(serverId) || "-tomcat".equals(serverId)){
		out.clear();
		out = pageContext.pushBody();
	}else if("weblogic".equals(serverId)){
		//response.reset();
	}
 %>