<%@page import="com.cjhxfund.ats.fm.comm.FileDownload"%>
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
  - Author(s): 翟静
  - Date: 2016-11-16 15:29:05
  - Description:
-->
<head>
<title>新债信息导入的文件地址</title>
</head>
<body>
<%
  String type = request.getParameter("type");//type=2承销商模板下载、type=3招行新债导入模板
  String path = request.getContextPath();
  String templateDir=ApplicationContext.getInstance().getWarRealPath()+ConfigurationUtil.getContributionConfig(ExcelUtilConfiguration.CONTRIBUTION_ABFRAME_UTILS,
				ExcelUtilConfiguration.MODULE_ABFRAME,
				ExcelUtilConfiguration.GROUP_EXCEL,
				ExcelUtilConfiguration.EXCEL_TEMPLATE_PATH);
  //获取替换配置文件目录中的YYYYMMDD
  String replaceFileName = DateUtil.currentDateString(DateUtil.YMD_NUMBER);
 String filedir = "ATS_XZXX_YYYYMMDD.xls";
 if(type.equals("2")){
 	filedir = "ATS_ZCXS_YYYYMMDD.xls";
 }else if("3".equals(type)){
 	filedir = "ATS_ZH_IMPORT_STOCK.xlsx";
 }
 File file = new File(templateDir+"//"+filedir);
 if(type.equals("2")){
 	filedir = "主承新债导入_YYYYMMDD.xls";
 }else if("3".equals(type)){
 	filedir = "新债导入模板.xlsx";
 }
 filedir = filedir.replaceAll(Constan.PATH_FORMAT, replaceFileName); 
  
  FileDownload.SingleFileDownload(file.getPath(), filedir, response,request); 
  
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