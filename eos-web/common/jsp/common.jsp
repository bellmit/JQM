<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>

<%@taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<%@taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<%@taglib uri="http://eos.primeton.com/tags/dict" prefix="d"%>

<%--
  - Author(s): huangmizhi
  - Date: 2016-09-12 09:03:30
  - Description: 系统基础公共资源引用文件
--%>

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
<link id="css_skin" rel="stylesheet" type="text/css" href="<%=contextPath%>/coframe/tools/skins/skin1/css/style.css"/>
<link id="css_icon" rel="stylesheet" type="text/css" href="<%=contextPath%>/coframe/tools/icons/icon.css"/>
<script type="text/javascript" src="<%=contextPath%>/common/nui/nui.js"></script>
<script type="text/javascript" src="<%=contextPath%>/common/nui/locale/zh_CN.js"></script>

<script type="text/javascript">
	(function(){
		nui.context = '<%=contextPath %>';
	})();
	var data = {};
	nui.DataTree.prototype.dataField = 'data';
	var userId = "<%=userId%>";
	var userName = "<%=userName%>";
	var operatorId = "<%=operatorId%>";
	
	//屏蔽按退格键(backspace)导致的页面回退到登录界面问题
	$(document).ready(function(){
  		document.onkeydown = function(e){
  			var ev = e || window.event; //获取event对象 
            var obj = ev.target || ev.srcElement; //获取事件源 
            var t = obj.type || obj.getAttribute('type'); //获取事件源类型 
            //获取作为判断条件的事件类型 
            var vReadOnly = obj.readOnly;
            var vDisabled = obj.disabled;
            //处理undefined值情况 
            vReadOnly = (vReadOnly == undefined) ? false : vReadOnly;
            vDisabled = (vDisabled == undefined) ? true : vDisabled;
            //当敲Backspace键时，事件源类型为密码或单行、多行文本的， 
            //并且readOnly属性为true或disabled属性为true的，则退格键失效 
            var flag1 = ev.keyCode == 8 && (t == "password" || t == "text" || t == "textarea") && (vReadOnly == true || vDisabled == true);
            //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效 
            var flag2 = ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea";
            //判断 
            if (flag2 || flag1) return false;
		}
	}); 
</script>