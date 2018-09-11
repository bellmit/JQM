<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>

<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-09-03 14:26:19
  - Description: 指令/建议跟踪
-->
<head>
	<title>指令/建议跟踪</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="margin: 0px;padding: 0px;overflow: hidden;width: 100%;height: 100%;">
	<%-- 列表开始... --%>
	<div id="tabs_instruct_follow" tabPosition="bottom" class="nui-tabs" activeIndex="0" style="width:100%;height:100%;">
		<div title="当日指令/建议" url="<%= request.getContextPath() %>/sm/comm/instruct/tansaction_instruct/todaysInstruct.jsp"></div>
		<div title="预置指令/建议" url="<%= request.getContextPath() %>/sm/comm/instruct/tansaction_instruct/presetInstruct.jsp"></div>
		<div title="历史指令/建议" url="<%= request.getContextPath() %>/sm/comm/instruct/tansaction_instruct/historyInstruct.jsp"></div>
	</div>
    <%-- 列表结束... --%>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>