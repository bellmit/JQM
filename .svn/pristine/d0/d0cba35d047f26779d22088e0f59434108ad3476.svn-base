
<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%@page import="com.cjhxfund.ats.fm.comm.FileDownload"%>
<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<%
   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext);
   //附件信息 
   DataObject[] attachs = (DataObject[])com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"attachs");
   //指令/建议信息
   DataObject  productProcess = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"productProcess");
  
   if(attachs.length == 1){
   		FileDownload.SingleFileDownload(attachs[0].getString("vcAttachAdd"), attachs[0].getString("vcAttachName"), response,request);
   }else{
   
   		//组装附件名称
   		String fileName = "";
   		String vcProductName = productProcess.getString("combProductName");
   		
   		fileName = DateUtil.format(DateUtil.getDate(), "yyyyMMddHHmmss") + "_" + vcProductName;
   		//下载附件
   		FileDownload.downloadFiles(request, response, attachs , fileName);
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
		//response.getWriter().close();
	}

 %>