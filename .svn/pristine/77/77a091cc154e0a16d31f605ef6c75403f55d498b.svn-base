<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://eos.primeton.com/tags/workflow" prefix="wf"%>
 <%@include file="/common/js/commscripts.jsp" %>
<html>
<head>
<title>流程图</title> 
<h:script src="/workflow/wfcomponent/web/js/workflow.js"/>
<h:script src="/workflow/wfcomponent/web/js/Graphic.js"/>

<%
   String processinstid = request.getParameter("processInstID");
 %>
</head>
<body topmargin="20" style="width: 100%;height: 100%;overflow-y: hidden; " >
       <div width="100%" align="center" style="margin-top: 20px;">
	     <wf:processGraph processInstID="@processInstID" zoomQuotiety="1"/>
	  </div>
 
  <script type="text/javascript">
    nui.parse();
	</script>
</body>
</html>
