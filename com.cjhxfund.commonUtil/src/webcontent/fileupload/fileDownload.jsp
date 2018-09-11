<%@page import="com.cjhxfund.commonUtil.FileDownload"%>
<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<%
   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
   DataObject[] datas = (DataObject[])com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"objs");
   DataObject  workitem = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workitem");
   DataObject bizProcess = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"bizProcess");
   if(datas != null){
   if(datas.length == 1){
   		FileDownload.SingleFileDownload(datas[0].getString("vcAttachAdd"), datas[0].getString("vcAttachName"), response,request);
   }else{
   		//组装附件名称
   		String fileName = "[" + bizProcess.getString("lInvestNo") + "]";
   		String vcProductName = bizProcess.getString("vcProductName");
   		if(vcProductName != "" && vcProductName !=null){
   			fileName = fileName +"_" + vcProductName;
   		}
   		fileName = fileName + "_" + bizProcess.getString("vcStockName");
   		//下载附件
   		FileDownload.downloadFiles(request, response, datas , fileName);
   }
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
 }else{
   out.print("新债信息表下载失败。");
 }
 %>