<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<%
	String contextPath=request.getContextPath();
%>
<!-- nui入口  含nui样式 -->
<script type="text/javascript" src="<%=contextPath %>/common/nui/nui.js" ></script>
<!-- plms公用工具类 -->
<script type="text/javascript" src="<%=contextPath %>/common/commonUtil.js"></script>


<!--项目路径初始化  -->
<script type="text/javascript">
	var contextPath = '<%=contextPath%>'; // you should define the contextPath of web application
</script>