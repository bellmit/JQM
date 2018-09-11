<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 陈迪
  - Date: 2017-06-27 14:45:19
  - Description: 资金交收跟踪管理
-->
<head>
	<title>资金交收跟踪管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>

	<div id="tabs_frame" class="nui-tabs" activeIndex="0" onactivechanged="" style="width:100%;height:100%;">
		<div title="资金交收管理" url="<%= request.getContextPath() %>/sm/comm/trace/fundSetmtAts.jsp"></div>
		<div title="O32当天成交数据展示" url="<%= request.getContextPath() %>/sm/comm/trace/fundSetmtO32.jsp"></div>
	</div>
	
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>