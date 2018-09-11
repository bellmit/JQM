<%@page import="com.cjhxfund.ats.fm.comm.FileDownload"%>
<%@page import="com.eos.foundation.eoscommon.BusinessDictUtil"%>
<%@page import="com.cjhxfund.jy.ProductProcess.ProductProcessUtil"%>
<%@page import="com.cjhxfund.commonUtil.commonUtil"%>
<%@page import="java.util.List"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<%
    Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
    List<String> exclpage = (List<String>)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"exclPage");
    String pageUrl = commonUtil.DOWNLOAD_FILE_EXCEL_EXPORT;
    if(exclpage != null &&!exclpage.isEmpty()){
    	FileDownload.downloadFiles(request, response,exclpage);
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