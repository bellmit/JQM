<%@page pageEncoding="UTF-8"%>
<%@include file="/common.jsp"%>
<%@ taglib uri="http://eos.primeton.com/tags/html" prefix="h"%>
<h:outputFile outputFileName="instructOrder.xls" property="data"/>
<%out.clear();out = pageContext.pushBody();%>