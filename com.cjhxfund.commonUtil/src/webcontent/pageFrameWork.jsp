<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): chenpeng
  - Date: 2016-04-14 09:19:50
  - Description:
-->
<head>
<title>框架页面</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="height: 99%;width: 99%;overflow: hidden;">
     <div class="nui-tabs" id="tabs" style="height: 100%;margin-top: -5px;">
       <!-- 待办 -->
       <div title="待处理任务" url="<%=request.getContextPath() %>/com.cjhxfund.jy.process.queryPersonWorkItemList.flow"></div>
       <!-- 已办 -->
       <div title="已完成任务" url="<%=request.getContextPath() %>/process/peding_QueryFrom.jsp"></div>
       <!-- 指令/建议录入 -->
       <div title="指令/建议录入" url="<%=request.getContextPath() %>//ProductProcess/CFJYProductProcessList_input.jsp"></div>
     </div>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>