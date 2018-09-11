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
		    <div name="combination_distribution_tab" id="combination_distribution_tab" title="固定收益业绩归因" url="<%=iDataUrl %>" visible="true" >
		    </div>
		    <div name="combination_limit_tab" id="combination_limit_tab" title="权益业绩归因" url="<%=iDataUrl %>" visible="true" >
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
		combination_distribution_tab.url = idataUrl+"&resid=I8a49602f0af779fb0158a89992624caa";
		
		function activeChangeTabs(){
			var activeTabTitle = nui.get("noldingsDetailTabs").getActiveTab().title;
			//固定收益业绩归因
			if(activeTabTitle.indexOf("固定收益业绩归因")!=-1){
				var combination_distribution_tab = nui.get("noldingsDetailTabs").getTab("combination_distribution_tab");
				combination_distribution_tab.url = idataUrl+"&resid=I8a49602f0af779fb0158a89992624caa";
			}
			//权益业绩归因
			if(activeTabTitle.indexOf("权益业绩归因")!=-1){
				var combination_limit_tab = nui.get("noldingsDetailTabs").getTab("combination_limit_tab");
				combination_limit_tab.url = idataUrl+"&resid=I8a49602f0af779fb0158aa1038ab6cc6";
			}
    	}
    	
    </script>
</body>
</html>