<%@page import="com.eos.foundation.eoscommon.BusinessDictUtil"%>
<%@page import="org.apache.log4j.Logger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%
	String fillDate = request.getParameter("fillDate");
	String userid = request.getParameter("userid");
	String seriesAccount = request.getParameter("seriesAccount");
	String singeAccount = request.getParameter("singeAccount");
	String path = request.getContextPath();
	String host = BusinessDictUtil.getDictName("CJ_JY_IDATA_PARAM","host");
	String serverName = request.getServerName();
	if(serverName.startsWith("10.")){
		host = BusinessDictUtil.getDictName("CJ_JY_IDATA_PARAM","inhost");
	}
 %>