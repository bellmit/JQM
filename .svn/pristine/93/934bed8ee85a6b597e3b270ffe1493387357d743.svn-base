<%@page import="com.cjhxfund.jy.process.FileDownload"%>
<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<%
   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
   //附加列表
   DataObject[] attachInfos = (DataObject[])com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"attachInfos");
   //产品名称
   DataObject  product = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"product");
   
   if(attachInfos.length == 1){
        //下载多个附件
   		FileDownload.SingleFileDownload(attachInfos[0].getString("attachAdd"), attachInfos[0].getString("attachName"), response);
   }else{
   		//下载多个附件
   		FileDownload.downloadFiles(request, response, attachInfos , product.getString("combProductName"));
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