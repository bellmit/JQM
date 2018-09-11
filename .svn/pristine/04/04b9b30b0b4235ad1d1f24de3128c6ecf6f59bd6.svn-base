<%@page import="com.cjhxfund.jy.process.FileDownload"%>
<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<%
   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
   DataObject[] datas = (DataObject[])com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"objs");
   DataObject  workitem = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workitem");
   DataObject  workItemList = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workItemList");
   
   
   if(datas.length == 1){
   		FileDownload.SingleFileDownload(datas[0].getString("attachAdd"), datas[0].getString("attachName"), response);
   }else{
       if(workitem != null){
   			FileDownload.downloadFiles(request, response, datas , workitem.getString("workItemName"));
   	   }else{
   	        String fileName = "[" + workItemList.getString("investproductnum") + "]" + "-" + workItemList.getString("combProductName") + "-" + workItemList.get("investProductName");
   	   		FileDownload.downloadFiles(request, response, datas , fileName);
   	   }
   }
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