<%@page import="com.cjhxfund.commonUtil.FileDownload"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.cjhxfund.commonUtil.StrUtil"%>
<%@page import="com.cjhxfund.jy.ProductProcess.ZhxxcxExport"%>
<%@include file="/common/common.jsp"%>
<%
	Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
    String datas = (String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"pageUrl");
    
    String[] pageUrlArr = datas.split(",");
    FileDownload.SingleFileDownload(pageUrlArr[0], pageUrlArr[1], response,request);
%>
<%out.clear();out = pageContext.pushBody();%>