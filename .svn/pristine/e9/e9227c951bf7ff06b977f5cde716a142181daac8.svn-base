<%@page import="com.cjhxfund.ats.fm.comm.FileDownload"%>
<%@page import="com.eos.runtime.core.ApplicationContext"%>
<%@page import="com.eos.foundation.eoscommon.ConfigurationUtil"%>
<%@page import="com.cjhxfund.ats.fm.baseinfo.ExcelUtilConfiguration"%>
<%@page import="java.io.File"%>
<%@page import="com.cjhxfund.ats.fm.commonUtil.DateUtil" %>
<%@page import="com.cjhxfund.ats.fm.commonUtil.Constan" %>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): 翟静
  - Date: 2016-11-14 15:53:40
  - Description:
-->
<head>
<title>jsp auto create</title> 
</head>
<body>
<%
  String path = request.getContextPath();
  String templateDir=ApplicationContext.getInstance().getWarRealPath()+ConfigurationUtil.getContributionConfig(ExcelUtilConfiguration.CONTRIBUTION_ABFRAME_UTILS,
				ExcelUtilConfiguration.MODULE_ABFRAME,
				ExcelUtilConfiguration.GROUP_EXCEL,
				ExcelUtilConfiguration.EXCEL_TEMPLATE_PATH);
  //获取替换配置文件目录中的YYYYMMDD
  String replaceFileName = DateUtil.currentDateString(DateUtil.YMD_NUMBER);
  String filedir = "ATS_ZHXX_YYYYMMDD.xls";
  filedir = filedir.replaceAll(Constan.PATH_FORMAT, replaceFileName); 
  File file = new File(templateDir+"//ATS_ZHXX_YYYYMMDD.xls");
  FileDownload.SingleFileDownload(file.getPath(),filedir, response,request); 
  
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
