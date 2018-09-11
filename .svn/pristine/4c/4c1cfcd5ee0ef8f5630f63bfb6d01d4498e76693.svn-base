<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="java.util.Map"%>

<%@ taglib uri="http://eos.primeton.com/tags/html" prefix="h"%>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<%@ taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<%@ taglib uri="http://eos.primeton.com/tags/dict" prefix="d"%>
<%@ taglib uri="http://eos.primeton.com/tags/webcomp" prefix="w"%>
<%@ taglib uri="http://eos.primeton.com/tags/eos" prefix="e"%>

<script type="text/javascript">
	var contextPath = "<%=request.getContextPath()%>";	 // you should define the contextPath of web application
</script>

<%
	String skin="skin1";
	String contextPath=request.getContextPath();
	String sizeList="[10,20,30,40,50,100,200]";
	
	HttpSession sessions = request.getSession();
	
	UserObject user = (UserObject)sessions.getAttribute("userObject");
	Map<String, Object> attr = user.getAttributes();
	String usreId = attr.get("EXTEND_USER_ID").toString();
	String roleId = attr.get("roleList").toString();
	String roleCode = "";
	if(attr.get("roleCodeList")!=null){
		roleCode = attr.get("roleCodeList").toString();
	}
%>
<h:script src="/common/scripts/eos-web.js"></h:script>
<link id="css_skin" rel="stylesheet" type="text/css" href="<%=contextPath%>/coframe/tools/skins/<%=skin %>/css/style.css"/>
<link id="css_icon" rel="stylesheet" type="text/css" href="<%=contextPath%>/coframe/tools/icons/icon.css"/>
<script type="text/javascript" src="<%=contextPath%>/common/nui/nui.js"></script>
<script type="text/javascript" src="<%=contextPath%>/common/js/function.js"></script>
<script>
	(function(){
		nui.context='<%=contextPath %>'
	})();
	
	var data={};
	nui.DataTree.prototype.dataField='data';
	
	var userId = "<%=usreId %>";//用户登录名，比如：liupinghui
	var roleId = "<%=roleId %>";//角色ID
	var roleCode = "<%=roleCode %>";//角色Code
</script>
	
<%-- 
<LINK REL=stylesheet HREF="<%=request.getContextPath() %>/common/fsjc/index/css/global_szair.css">
<LINK REL=stylesheet HREF="<%=request.getContextPath() %>/common/fsjc/index/css/global_button.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/common/fsjc/index/css/SystemTable.css" type="text/css">
<link href="<%=request.getContextPath() %>/common/fsjc/index/css/style.css?20150912" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath() %>/common/fsjc/index/css/common.css?20150911" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath() %>/common/fsjc/index/js/jquery-1.4.4.min.js"></script> --%>


