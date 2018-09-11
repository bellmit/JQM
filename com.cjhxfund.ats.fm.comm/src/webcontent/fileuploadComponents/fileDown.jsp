
<%@page import="com.cjhxfund.ats.fm.comm.FileDownload"%>
<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<%
   String localFile=request.getParameter("downloadFile");
   String fileName=request.getParameter("fileName");
   System.out.println("localFile：" + localFile);
   System.out.println("fileName：" + fileName);
   FileDownload.SingleFileDownload(localFile, fileName, response,request);
   
   //根据应用服务器类型，关闭输出流
	//1、获取应用服务器类型
	String serverId=com.cjhxfund.commonUtil.ServerDetector.getServerId();
	//判定和关闭流
	if("tomcat".equals(serverId) || "-tomcat".equals(serverId)){
		out.clear();
		out = pageContext.pushBody();
	}else if("weblogic".equals(serverId)){
		//response.reset();
		//response.getWriter().close();
	}

 %>