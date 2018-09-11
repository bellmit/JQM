<%@page import="com.cjhxfund.ats.fm.comm.FileDownload"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.eos.foundation.eoscommon.LogUtil"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%
   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
   DataObject[] datas = (DataObject[])com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"objs");
   Date createDate = new Date();
   SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
   String dateString = formatter.format(createDate);
   if(datas.length == 1){
        FileDownload.SingleFileDownload(datas[0].getString("vcAttachAdd"), datas[0].getString("vcAttachName"), response,request);
   }else{
   		FileDownload.downloadFiles(request, response, datas , dateString+"用印附件下载");
   }
   
   //根据应用服务器类型，关闭输出流
	//1、获取应用服务器类型
	String serverId = com.cjhxfund.commonUtil.ServerDetector.getServerId();
	//判定和关闭流
	if("tomcat".equals(serverId) || "-tomcat".equals(serverId)){
		out.clear();
		out = pageContext.pushBody();
	}else if("weblogic".equals(serverId)){
		response.reset();
	}
 %>