<%@page import="com.eos.foundation.eoscommon.BusinessDictUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="../inc/common.jsp" %>
<%
	/* String fillDate = request.getParameter("fillDate").toString();
	String userid = request.getParameter("userid").toString();
	String seriesAccount = request.getParameter("seriesAccount").toString();
	String singeAccount = request.getParameter("singeAccount").toString();
	String path = request.getContextPath();
	String host = BusinessDictUtil.getDictName("CJ_JY_IDATA_PARAM","host");
	String serverName = request.getServerName();
	if(serverName.startsWith("10.")){
		host = BusinessDictUtil.getDictName("CJ_JY_IDATA_PARAM","inhost");
	} */
	String iDataUrl = host+"/iData/vision/redirect.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount+"&host="+host;
 %>	
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@include file="/common.jsp"%>
<!-- 
  - Author(s): 谭凯
  - Date: 2016-09-21 09:54:53
  - Description:
-->
<head>
<title>系列账户</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>

	<div title="center" region="center" style="border:0;padding-left:5px;padding-top:0px;width:99%;height:100%;">
    	<!--Tabs-->
       <div id="noldingsDetailTabs" onactivechanged="activeChangeTabs" class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:100%;">
		    <div name="combination_distribution_tab" id="combination_distribution_tab" title="敞口分析" url="<%=iDataUrl %>" visible="true" >
		    </div>
		    <%-- <div name="combination_limit_tab" id="combination_limit_tab" title="绝对风险分析" url="<%=iDataUrl %>" visible="true" >
		    </div> --%>
		    <div name="combination_credit_tab" id="combination_credit_tab" title="风格分析" url="<%=iDataUrl %>" visible="false" >
		    </div>
		    <div name="combination_issuer_tab" id="combination_issuer_tab" title="行业分析" url="<%=iDataUrl %>" visible="true" >
		    </div>
		</div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var flag = nui.getDictText("CJ_JY_IDATA_PARAM","flag");
		var seriesAccount = '<%=seriesAccount %>';
		var singeAccount = '<%=singeAccount %>';
		var fillDate = '<%=fillDate %>';
		var userid = '<%=userid %>';
		
		var host = '<%=host %>';
		var idataUrl = host+"/iData/vision/redirect.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount+"&host="+host;
		var combination_distribution_tab = nui.get("noldingsDetailTabs").getTab("combination_distribution_tab");
		combination_distribution_tab.url = idataUrl+"&resid=I8a49602f0af779fb0158a9d372b166e4";
		
		function activeChangeTabs(){
			var activeTabTitle = nui.get("noldingsDetailTabs").getActiveTab().title;
			//敞口分析（弱）
			if(activeTabTitle.indexOf("敞口分析")!=-1){
				var combination_distribution_tab = nui.get("noldingsDetailTabs").getTab("combination_distribution_tab");
				combination_distribution_tab.url = idataUrl+"&resid=I8a49602f0af779fb0158a9d372b166e4";
			}
			//绝对风险分析
			if(activeTabTitle.indexOf("绝对风险分析")!=-1){
				var combination_limit_tab = nui.get("noldingsDetailTabs").getTab("combination_limit_tab");
				combination_limit_tab.url = idataUrl+"&resid=I8a49602f0af779fb0158a9d6a2cc66f1";
			}
			//风格分析
			if(activeTabTitle.indexOf("风格分析")!=-1){
				var combination_credit_tab = nui.get("noldingsDetailTabs").getTab("combination_credit_tab");
				combination_credit_tab.url = idataUrl+"&resid=I8a49602f0af779fb0158a9da26bd672e";
			}
			//行业分析
			if(activeTabTitle.indexOf("行业分析")!=-1){
				var combination_issuer_tab = nui.get("noldingsDetailTabs").getTab("combination_issuer_tab");
				combination_issuer_tab.url = idataUrl+"&resid=I8a49602f0af779fb0158a9d7ca06670c";
			}
    	}
    	
    </script>
</body>
</html>