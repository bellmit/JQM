<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://eos.primeton.com/tags/html" prefix="h"%>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<%@ taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<%@ taglib uri="http://eos.primeton.com/tags/dict" prefix="d"%>
<%@ taglib uri="http://eos.primeton.com/tags/webcomp" prefix="w"%>
<%@ taglib uri="http://eos.primeton.com/tags/eos" prefix="e"%>
<%@ taglib uri="http://eos.primeton.com/tags/richweb" prefix="r"%>
<%@ taglib uri="http://eos.primeton.com/tags/workflow" prefix="wf"%>

<%	
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	
	String contextPath=request.getContextPath();
	String skin="skin1";
	String sizeList="[1,10,20,30,40,50,100,200]";
	
	String currtime = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
  	String defultDay = currtime.substring(0,10);
  	String defultMonth = currtime.substring(0,7);
%>
<!-- nui入口  含nui样式 -->
<script type="text/javascript" src="<%=contextPath%>/common/nui/nui.js"></script>
<!-- plms公用工具类 -->
<script type="text/javascript" src="<%=contextPath %>/common/commonUtil.js"></script>

<!--不知用途暂时注释掉
<script type="text/javascript" src="<%=contextPath%>/common/js/function.js"></script> 
<script type="text/javascript" src="<%=contextPath%>/common/js/define.js" ></script>
<script type="text/javascript" src="<%=contextPath%>/common/js/dbUtil.js"></script>
<script type="text/javascript" src="<%=contextPath%>/common/commonUtil.js"></script>
<script type="text/javascript" src="<%=contextPath%>/common/javascripts/message.js" i18n="true" ></script>
<script type="text/javascript" src="<%=contextPath%>/common/skins/skin0/scripts/resource.js"></script>
<script type="text/javascript" src="<%=contextPath%>/common/scripts/eos-web.js"></script>-->
<script>
	(function(){
		nui.context='<%=contextPath %>'
	})();
	
	var data={};
	nui.DataTree.prototype.dataField='data';
	var contextPath = "<%=request.getContextPath()%>";	 // you should define the contextPath of web application
</script>



