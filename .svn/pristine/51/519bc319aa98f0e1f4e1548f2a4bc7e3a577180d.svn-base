<%@page import="com.cjhxfund.jy.excelUploadAdd.ExcelDown"%>
<%@page import="com.eos.runtime.core.ApplicationContext"%>
<%@page import="com.eos.foundation.eoscommon.ConfigurationUtil"%>
<%@page import="com.cjhxfund.ats.fm.baseinfo.ExcelUtilConfiguration"%>
<%@page import="com.cjhxfund.ats.fm.commonUtil.Constan" %>
<%@page import="com.cjhxfund.ats.fm.commonUtil.DateUtil" %>
<%@page import="java.io.File"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): heyi
  - Date: 2017-3-16 15:29:05
  - Description:
-->
<head>
<title>债券买卖Excel导入的文件地址</title>
</head>
<body>
<%
  	ExcelDown.excelDownload(response,request); 

	String serverId=com.cjhxfund.commonUtil.ServerDetector.getServerId();
	if("tomcat".equals(serverId) || "-tomcat".equals(serverId)){
		out.clear();
		out = pageContext.pushBody();
	}else if("weblogic".equals(serverId)){
		
	}
 %>
</body>
</html>