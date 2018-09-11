<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="com.eos.foundation.common.lang.DateUtil"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/common.jsp"%>
<%
	String userid = userObject.getUserName();
 %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<title>BO报表</title>
	<link id="css_skin" rel="stylesheet" type="text/css" href="<%=contextPath%>/coframe/tools/skins/skin1/css/style.css"/>
</head>
<body style="margin:0px;">
<div class="nui-fit">
	<iframe id="reportWind" id="reportWind" src="url" height="98%" width="98%">
	</iframe>
</div>
</body>
<script type="text/javascript">
	nui.parse();
	 
	var reportWind = document.getElementById("reportWind");
	var userid = '<%=userid %>';
	var url = nui.getDictText("CJ_JY_BO_PARAM","url");
	reportWind.src =  url+"?UserId="+userid;
	
</script>
</html>