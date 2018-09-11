<%@page import="com.cjhxfund.commonUtil.FileDownload"%>
<%@page import="com.eos.foundation.eoscommon.BusinessDictUtil"%>
<%@page import="com.cjhxfund.jy.ProductProcess.ProductProcessUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<%
    Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
    String datas = (String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"pageUrl");
    if(datas != null &&!datas.isEmpty()){
	    String[] pageUrlArr = datas.split(",");
    	FileDownload.SingleFileDownload(pageUrlArr[0], pageUrlArr[1], response,request);
    }
    //Date date = new Date();
	//SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
	
	//根据指令/建议类型Id获取数据字典名称
	//String dictName = BusinessDictUtil.getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZNHG,datas.getString("processType"));
    //组装文件名称
    //String filename = datas.getString("combProductName") + "_" + dictName.substring(0, 3) +"_" + format.format(date) +".xls";
	
%>
<%-- <h:outputFile outputFileName="<%=filename %>" property="data"/> --%>
<%
    //根据应用服务器类型，关闭输出流
	//1、获取应用服务器类型
	String serverId = com.cjhxfund.commonUtil.ServerDetector.getServerId();
	System.out.println("ProductProcess/PledgedRepoExport.jsp......serverId="+serverId);
	//判定和关闭流
	if("tomcat".equals(serverId) || "-tomcat".equals(serverId)){
		out.clear();
		out = pageContext.pushBody();
	}else if("weblogic".equals(serverId)){
		//response.reset();
	}
%>