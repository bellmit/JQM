<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%
	String preDate = DateUtil.getCalculateTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null, -1);
%>
<%--
- Author(s): 吴艳飞
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
		var tab = {title:"中债-结算指令", url:"<%=request.getContextPath() %>/sm/comm/back_stage_trader/bst_jszlxz_detail.jsp", showCloseButton: false };
		//设置tab
		tabs.addTab(tab);
		tabs.activeTab(tab);
	   
		var tab = {title:"中债-结算合同", url:"<%=request.getContextPath() %>/sm/comm/back_stage_trader/bst_jshtxz_detail.jsp", showCloseButton: false };
		tabs.addTab(tab);
		
		var tab = {title:"上清-分销", url:"<%=request.getContextPath() %>/sm/comm/back_stage_trader/bst_fxsjlb_detail.jsp", showCloseButton: false };
		tabs.addTab(tab);
		
		var tab = {title:"上清-买断式回购", url:"<%=request.getContextPath() %>/sm/comm/back_stage_trader/bst_mdshglb_detail.jsp", showCloseButton: false };
		tabs.addTab(tab);
		
		var tab = {title:"上清-现券交易", url:"<%=request.getContextPath() %>/sm/comm/back_stage_trader/bst_xqjylb_detail.jsp", showCloseButton: false };
		tabs.addTab(tab);
		
		var tab = {title:"上清-质押式回购", url:"<%=request.getContextPath() %>/sm/comm/back_stage_trader/bst_zyshglb_detail.jsp", showCloseButton: false };
		tabs.addTab(tab);
		
		var tab = {title:"上清-全额结算指令", url:"<%=request.getContextPath() %>/sm/comm/back_stage_trader/bst_qejszl_detail.jsp", showCloseButton: false };
		tabs.addTab(tab);
		
		var tab = {title:"上清-指令数据(新)", url:"<%=request.getContextPath() %>/sm/comm/back_stage_trader/bst_sqzlxzlb_detail.jsp", showCloseButton: false };
		tabs.addTab(tab);
		
		var tab = {title:"上清-结算数据(新)", url:"<%=request.getContextPath() %>/sm/comm/back_stage_trader/bst_sqjsxzlb_detail.jsp", showCloseButton: false };
		tabs.addTab(tab);
    </script>
</body>
</html>