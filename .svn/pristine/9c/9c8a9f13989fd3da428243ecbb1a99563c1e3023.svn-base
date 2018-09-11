<%@page import="com.cjhxfund.ats.fm.comm.FileDownload"%>
<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<%
   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
   DataObject[] datas = (DataObject[])com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"objs");
    DataObject  workitem = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workitem");
   DataObject  finishWorkItem = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"finishWorkItem");
   
   String ProductName = finishWorkItem.getString("vcProductName");   //获取产品名称
   
   if(datas.length == 1){
   		FileDownload.SingleFileDownload(datas[0].getString("vcAttachAdd"), datas[0].getString("vcAttachName"), response,request);
   }else{
       if(workitem != null){
   			FileDownload.downloadFiles(request, response, datas , workitem.getString("workItemName"));
   	   }else{
   	        String fileName = "[" + finishWorkItem.getString("lInvestNo") + "]";
   	        //判断产品名称是否为空，为空不追加
   	        if(ProductName != null){
   	        	fileName = fileName + "-" + finishWorkItem.getString("vcProductName");	
   	        } 
   	        fileName = fileName + "-" + finishWorkItem.get("vcStockName");
   	   		FileDownload.downloadFiles(request, response, datas , fileName);
   	   }
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