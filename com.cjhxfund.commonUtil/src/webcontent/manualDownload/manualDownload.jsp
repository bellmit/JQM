<%@page import="com.cjhxfund.commonUtil.manualDownload.manualDownload"%>
<%@page import="com.eos.runtime.core.ApplicationContext"%>
<%@page import="com.eos.foundation.eoscommon.ConfigurationUtil"%>
<%@page import="com.cjhxfund.commonUtil.manualDownload.WordUtilConfiguration"%>
<%@page import="com.cjhxfund.ats.fm.commonUtil.Constan" %>
<%@page import="com.cjhxfund.ats.fm.commonUtil.DateUtil" %>
<%@page import="java.io.File"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@page import="com.eos.web.taglib.util.*" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): heyi
  - Date: 2017-3-24 15:29:05
  - Description:
-->
<head>
<title>操作手册下载的文件地址</title>
</head>
<body>
<%
   //获取标签中使用的国际化资源信息
   String fileNotExist=com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("l_fileNotExist");
   Object root= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext);
   String userType=(String)XpathUtil.getObjectByXpath(root,"userType");
   String vcManualName = (String)XpathUtil.getObjectByXpath(root,"vcManualName");
   
 manualDownload.manualFileDownload(response,request,userType,vcManualName); 

  //根据应用服务器类型，关闭输出流
	//1、获取应用服务器类型
	String serverId=com.cjhxfund.commonUtil.ServerDetector.getServerId();
	//判定和关闭流
	if("tomcat".equals(serverId) || "-tomcat".equals(serverId)){
		out.clear();
		out = pageContext.pushBody();
	}else if("weblogic".equals(serverId)){
		
	}
 %>
</body>
</html>