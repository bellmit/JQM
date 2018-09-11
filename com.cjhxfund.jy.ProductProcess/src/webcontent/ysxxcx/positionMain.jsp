<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%
	String preDate = DateUtil.getCalculateTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null, -1);
%>
<%--
- Author(s): chendi
- Date: 2016-12-21 16:12:12
- Description: 风险预算信息查询
--%>
<head>
<title>产品头寸风险测算信息查询主页面</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div  title="头寸算信息查询" class="nui-fit">
			<div class="nui-tabs" width="100%" id="tabs" style="height:100%;table-layout:fixed;"></div>
	</div>
</div>
	<script type="text/javascript">
    	nui.parse();
    	var tabs = nui.get("tabs");
		//在加载tab时首先清除掉之前的tab页面
		//abs.removeAll();
		//设置tab属性
		var tab = {title:"头寸风险预算表", url:"<%=request.getContextPath() %>/ProductProcess/ysxxcx/CFJY_zhxxcx_positionriskforecast.jsp", showCloseButton: false };
		//设置tab
		tabs.addTab(tab);
		tabs.activeTab(tab);
	   
		var tab = {title:"当日T+0头寸差额", url:"<%=request.getContextPath() %>/ProductProcess/ysxxcx/positionT0Main.jsp", showCloseButton: false };
		tabs.addTab(tab);
		
		var tab = {title:"当日T+1头寸差额", url:"<%=request.getContextPath() %>/ProductProcess/ysxxcx/positionT1Main.jsp", showCloseButton: false };
		tabs.addTab(tab);
		
		
    </script>
</body>
</html>