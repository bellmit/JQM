<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>

<%@taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<%@taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<%@taglib uri="http://eos.primeton.com/tags/dict" prefix="d"%>


<%
String uniTitle = "创金合信-综合服务平台";
String contextPath = request.getContextPath();
IMUODataContext muoContext = DataContextManager.current().getMUODataContext();
IUserObject userObject = muoContext.getUserObject();
String userId = "";
String userName = "";
String operatorId = "";
if (userObject != null) {
userId = (String)userObject.getAttributes().get("EXTEND_USER_ID");
userName = (String)userObject.getUserName();
operatorId = (String)userObject.getUserId();
}
%>

<title><%=uniTitle%></title>
<script type="text/javascript" src="<%=contextPath%>/common/nui/nui.js"></script>
<script type="text/javascript" src="<%=contextPath%>/common/nui/locale/zh_CN.js"></script>
<link id="css_skin" rel="stylesheet" type="text/css" href="<%=contextPath%>/coframe/tools/skins/skin1/css/style.css"/>
<link id="css_icon" rel="stylesheet" type="text/css" href="<%=contextPath%>/coframe/tools/icons/icon.css"/>
<!-- nui入口  含nui样式 -->
<script type="text/javascript" src="<%=contextPath %>/common/nui/nui.js" ></script>
<!-- plms公用工具类 -->
<script type="text/javascript" src="<%=contextPath %>/bpsExpend/common/commonUtil.js"></script>
<!--file  -->

 


<style type="text/css">
	body{
		background-color:#f7f7f7
	}
</style>



<!--项目路径初始化  -->
<script type="text/javascript">
	var contextPath = '<%=contextPath%>'; // you should define the contextPath of web application
	var EOSDEBUG = false;
	
	(function(){
		nui.context='<%=contextPath %>';
	})();
	
	var data={};
	nui.DataTree.prototype.dataField='data';
	
	nui.parse();
	
	function getBizCode(){
		var bizCode = "";
		if(nui.get("bizCode")!=null){
			bizCode = nui.get("bizCode").getValue();
		}
		return bizCode;
	}
	
	function getBizId(){
		var bizId = "";
		if(nui.get("bizId")!=null){
			bizId = nui.get("bizId").getValue();
		}
		return bizId;
	}
</script>