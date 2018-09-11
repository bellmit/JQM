<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%
	String preDate = DateUtil.getCalculateTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null, -1);
%>
<%--
- Author(s): 冯君培
- Date: 2016-12-21 16:12:12
- Description: 中债上清成交查询
--%>
<head>
<title>中债上清成交查询</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div  title="中债上清成交查询" class="nui-fit">
			<div class="nui-tabs" width="100%" id="tabs" style="height:100%;table-layout:fixed;"></div>
	</div>
</div>
	<script type="text/javascript">
    	nui.parse();
    	var tabs = nui.get("tabs");
		//在加载tab时首先清除掉之前的tab页面
		//abs.removeAll();
		//设置tab属性
		var tab = {title:"结算指令/建议下载", url:"<%=request.getContextPath() %>/ProductProcess/zhxxcx/CFJY_zhxxcx_jszlxz_detail.jsp", showCloseButton: true };
		//设置tab
		tabs.addTab(tab);
		tabs.activeTab(tab);
		
		var tab = {title:"结算合同下载", url:"<%=request.getContextPath() %>/ProductProcess/zhxxcx/CFJY_zhxxcx_jshtxz_detail.jsp", showCloseButton: true };
		tabs.addTab(tab);
		
		var tab = {title:"分销数据列表", url:"<%=request.getContextPath() %>/ProductProcess/zhxxcx/CFJY_zhxxcx_fxsjlb_detail.jsp", showCloseButton: true };
		tabs.addTab(tab);
		
		var tab = {title:"买断式回购列表", url:"<%=request.getContextPath() %>/ProductProcess/zhxxcx/CFJY_zhxxcx_mdshglb_detail.jsp", showCloseButton: true };
		tabs.addTab(tab);
		
		var tab = {title:"现券交易列表", url:"<%=request.getContextPath() %>/ProductProcess/zhxxcx/CFJY_zhxxcx_xqjylb_detail.jsp", showCloseButton: true };
		tabs.addTab(tab);
		
		var tab = {title:"质押式回购列表", url:"<%=request.getContextPath() %>/ProductProcess/zhxxcx/CFJY_zhxxcx_zyshglb_detail.jsp", showCloseButton: true };
		tabs.addTab(tab);
		
		var tab = {title:"全额结算指令/建议列表", url:"<%=request.getContextPath() %>/ProductProcess/zhxxcx/CFJY_chxxcx_qejszl_detail.jsp", showCloseButton: true };
		tabs.addTab(tab);
		
    </script>
</body>
</html>