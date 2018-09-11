<%@page import="com.eos.foundation.eoscommon.BusinessDictUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%
	String fillDate = request.getParameter("fillDate").toString();
	String userid = request.getParameter("userid").toString();
	String seriesAccount = request.getParameter("seriesAccount").toString();
	String path = request.getContextPath();
	String host = BusinessDictUtil.getDictName("CJ_JY_IDATA_PARAM","host");
	String serverName = request.getServerName();
	
	if(serverName.startsWith("10.")){
		host = BusinessDictUtil.getDictName("CJ_JY_IDATA_PARAM","inhost");
	}
	System.out.println(serverName.indexOf("10.") +"====serverName:"+serverName+"=======host:"+host);
	String iDataUrl = host+"/iData/vision/redirect.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&host="+host;
					
	String jspUrl = path+"/ProductProcess/MOM_REPORT/series_portfolio_detail.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount;
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
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>

	<div title="center" region="center" style="border:0;padding-left:5px;padding-top:0px;width:99%;height:99%;">
    	<!--Tabs-->
       <div id="seriesAccountTabs" onactivechanged="activeChangeTabs"  class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:99%;">
		    <div name="portfolio_ummary_tab" id="portfolio_ummary_tab" title="组合概况" url="<%=iDataUrl %>&resid=I8a618ed94abb390401574ba35ee9026f" visible="true" >
		    </div>
		    <div name="portfolio_holdings_tab" id="portfolio_holdings_tab" title="组合持仓" url="<%=jspUrl %>" visible="true" >
		    </div>
		    <div name="liquidity_analysis_tab" id="liquidity_analysis_tab" title="流动性分析" url="<%=iDataUrl %>&resid=I8a618ed94f5662d101574f9b489c029b" visible="true" >
		    </div>
		    <div name="special_note_tab" id="special_note_tab" title="特别提示" url="<%=iDataUrl %>&resid=I8a618ed94f5662d101574f97c1e40275" visible="true" >
		    </div>
		</div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var flag = nui.getDictText("CJ_JY_IDATA_PARAM","flag");
		var seriesAccount = '<%=seriesAccount %>';
		var fillDate = '<%=fillDate %>';
		var userid = '<%=userid %>';
		var host = '<%=host %>';
		var idataUrl = host+"/iData/vision/redirect.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&host="+host;	
		function activeChangeTabs(){
			var activeTabTitle = nui.get("seriesAccountTabs").getActiveTab().title;
			//组合概括
			if(activeTabTitle.indexOf("组合概况")!=-1){
				var portfolio_ummary_tab = nui.get("seriesAccountTabs").getTab("portfolio_ummary_tab");
				portfolio_ummary_tab.url = idataUrl+"&resid=I8a618ed94abb390401574ba35ee9026f";
			}
			
			//组合持仓
			if(activeTabTitle.indexOf("组合持仓")!=-1){
				var url = "<%=contextPath%>/ProductProcess/MOM_REPORT/series_portfolio_detail.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount;
				var portfolio_holdings_tab = nui.get("seriesAccountTabs").getTab("portfolio_holdings_tab");
				portfolio_holdings_tab.url = url;
			}
			//流动性分析
			if(activeTabTitle.indexOf("流动性分析")!=-1){
				var liquidity_analysis_tab = nui.get("seriesAccountTabs").getTab("liquidity_analysis_tab");
				liquidity_analysis_tab.url = idataUrl+"&resid=I8a618ed94f5662d101574f9b489c029b";
			}
			//特别提示
			if(activeTabTitle.indexOf("特别提示")!=-1){
				var special_note_tab = nui.get("seriesAccountTabs").getTab("special_note_tab");
				special_note_tab.url = idataUrl+"&resid=I8a618ed94f5662d101574f97c1e40275";
			}
		}
    	
    </script>
</body>
</html>