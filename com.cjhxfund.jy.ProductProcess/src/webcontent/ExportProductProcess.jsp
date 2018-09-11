<%@page import="com.cjhxfund.commonUtil.FileDownload"%>
<%@page pageEncoding="UTF-8"%><%@include file="/common/common.jsp"%>
<%
	Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
    String datas = (String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"pageUrl");
    
    String[] pageUrlArr = datas.split(",");
    FileDownload.SingleFileDownload(pageUrlArr[0], pageUrlArr[1], response,request);
 %>
<%
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