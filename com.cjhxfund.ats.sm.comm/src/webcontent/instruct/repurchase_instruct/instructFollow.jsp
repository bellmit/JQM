<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 创金合信
  - Date: 2016-09-03 14:26:19
  - Description:回购业务指令/建议跟踪主界面
-->
<head>
<title>指令/建议跟踪</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>

	<%-- 列表开始... --%>
    <div id="tabs_instruct_follow" tabPosition="bottom" class="nui-tabs" activeIndex="0" height="100%">
        <div title="当日指令/建议" url="<%= request.getContextPath() %>/sm/comm/instruct/repurchase_instruct/todaysInstruct.jsp"></div>
        <div title="预置指令/建议" url="<%= request.getContextPath() %>/sm/comm/instruct/repurchase_instruct/presetInstruct.jsp"></div>
        <div title="历史指令/建议" url="<%= request.getContextPath() %>/sm/comm/instruct/repurchase_instruct/historyInstruct.jsp"></div>
    </div>
    <%-- 列表结束... --%>
	
	<script type="text/javascript">
    	nui.parse();
    	
    </script>
</body>
</html>