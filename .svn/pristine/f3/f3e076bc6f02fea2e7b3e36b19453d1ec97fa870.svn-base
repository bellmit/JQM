<%@page import="com.eos.foundation.eoscommon.BusinessDictUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="inc/common.jsp" %>
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
	String iDataUrl = host+":"+host+"/iData/vision/redirect.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount+"&host="+host;
	String jspUrl = path+"/report/report/singer/portfolio_detail.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount;	
	String jspSpecialUrl = path+"/report/report/singer/special_detail.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount;	
	String jspAscribeUrl = path+"/report/report/singer/ascribe_detail.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount;	
	String jspQyfxUrl = path+"/report/report/singer/qyfx_detail.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount;	
	String jspYspfxUrl = path+"/report/report/singer/yspfx_detail.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount;
 %>		
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@include file="/common.jsp"%>
<!-- 
  - Author(s): 谭凯
  - Date: 2016-09-21 09:55:14
  - Description:
-->
<head>
<title>单账户</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	<div title="center" region="center" style="border:0;padding-left:5px;padding-top:0px;width:99%;height:100%;">
	    <!--Tabs-->
	    <div id="singeAccountTabs" onactivechanged="activeChangeTabs"  class="nui-tabs  bg-toolbar" activeIndex="0" style="width:100%;height:99%;">
		   <div name="portfolio_ummary_tab" id="portfolio_ummary_tab" title="组合概况" url="<%=iDataUrl %>&resid=I8a49602f0af779fb0158a87596bd4732" visible="true" >
		    </div>
		   <div name="performance_overview_tab" id="performance_overview_tab" title="业绩表现" url="<%=iDataUrl %>&resid=I8a49602f0af779fb0158a8ba5bc3524a" visible="true" >
		   </div>
		   <div name="portfolio_assets_tab" id="portfolio_assets_tab" title="组合资产" url="<%=iDataUrl %>&resid=I8a49602f0af779fb0158a8d9db5c566f" >
		   </div>
		   <div name="portfolio_holdings_tab" id="portfolio_holdings_tab" title="固定收益分析" url="<%=jspUrl %>" visible="true" >
		    </div>
		   <div name="portfolio_qyfx_tab" id="portfolio_qyfx_tab" title="权益分析" url="<%=jspQyfxUrl %>" visible="true" >
		    </div>
		   <div name="portfolio_yspfx_tab" id="portfolio_yspfx_tab" title="衍生品分析" url="<%=jspYspfxUrl %>" visible="true" >
		    </div>
		   <div name="performance_attribution_tab" id="performance_attribution_tab"  title="业绩归因" url="<%=jspAscribeUrl %>" visible="true" >
		   </div>
		   <div name="liquidity_analysis_tab" id="liquidity_analysis_tab" title="流动性分析" url="<%=iDataUrl %>&resid=I8a49602f0af779fb0158a9ec46146986" visible="true" >
		    </div>
		    <div name="special_note_tab" id="special_note_tab" title="特别提示" url="<%=jspSpecialUrl %>" visible="true" >
		    </div>
		</div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	
    	var flag = nui.getDictText("CJ_JY_IDATA_PARAM","flag");
		var seriesAccount = '<%=seriesAccount %>';
		var fillDate = '<%=fillDate %>';
		var userid = '<%=userid %>';
		var singeAccount = '<%=singeAccount %>';
		var host = '<%=host %>';
		var idataUrl = host+"/iData/vision/redirect.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount+"&host="+host;
		var portfolio_ummary_tab = nui.get("singeAccountTabs").getTab("portfolio_ummary_tab");
		portfolio_ummary_tab.url = idataUrl+"&resid=I8a618ed964027a60015764e7206207c7";
		
		function activeChangeTabs(){
			var activeTabTitle = nui.get("singeAccountTabs").getActiveTab().title;
			
			//1.组合概况	单账户组合概况
			if(activeTabTitle.indexOf("组合概况")!=-1){
				var portfolio_ummary_tab = nui.get("singeAccountTabs").getTab("portfolio_ummary_tab");
				portfolio_ummary_tab.url = idataUrl+"&resid=I8a49602f0af779fb0158a87596bd4732";
			}
			//2.业绩表现	单账户业绩表现	
			if(activeTabTitle.indexOf("业绩表现")!=-1){
				var performance_overview_tab = nui.get("singeAccountTabs").getTab("performance_overview_tab");
				performance_overview_tab.url = idataUrl+"&resid=I8a49602f0af779fb0158a8ba5bc3524a";
			}
			//3.组合资产	单帐组合资产
			if(activeTabTitle.indexOf("组合资产")!=-1){
				var portfolio_assets_tab = nui.get("singeAccountTabs").getTab("portfolio_assets_tab");
				portfolio_assets_tab.url = idataUrl+"&resid=I8a49602f0af779fb0158a8d9db5c566f";
			}	
			//4.组合持仓 固定收益分析
			if(activeTabTitle.indexOf("固定收益分析")!=-1){
				var portfolio_holdings_tab = nui.get("singeAccountTabs").getTab("portfolio_holdings_tab");
				var redirectUrl = "<%=request.getContextPath()%>/report/MOM_REPORT/singer/portfolio_detail.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount;
				portfolio_holdings_tab.url = redirectUrl;
			}
			//权益分析
			if(activeTabTitle.indexOf("权益分析")!=-1){
				var portfolio_qyfx_tab = nui.get("singeAccountTabs").getTab("portfolio_qyfx_tab");
				var redirectUrl = "<%=request.getContextPath()%>/report/MOM_REPORT/singer/qyfx_detail.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount;
				portfolio_qyfx_tab.url = redirectUrl;
			}
			//衍生品分析
			if(activeTabTitle.indexOf("衍生品分析")!=-1){
				var portfolio_yspfx_tab = nui.get("singeAccountTabs").getTab("portfolio_yspfx_tab");
				var redirectUrl = "<%=request.getContextPath()%>/report/MOM_REPORT/singer/yspfx_detail.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount;
				portfolio_yspfx_tab.url = redirectUrl;
			}
			
			//5.业绩归因	单帐业绩归因
			if(activeTabTitle.indexOf("业绩归因")!=-1){
				var performance_attribution_tab = nui.get("singeAccountTabs").getTab("performance_attribution_tab");
				var redirectUrl = "<%=request.getContextPath()%>/report/MOM_REPORT/singer/ascribe_detail.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount;
				performance_attribution_tab.url = redirectUrl;
			}	
			//6.市场及流动性风险	单账户流动性分析
			if(activeTabTitle.indexOf("流动性分析")!=-1){
				var liquidity_analysis_tab = nui.get("singeAccountTabs").getTab("liquidity_analysis_tab");
				liquidity_analysis_tab.url = idataUrl+"&resid=I8a49602f0af779fb0158a9ec46146986";
			}	
			//7.特别提示	单帐系列特别提示
			if(activeTabTitle.indexOf("特别提示")!=-1){
				var special_note_tab = nui.get("singeAccountTabs").getTab("special_note_tab");
				var redirectUrl = "<%=request.getContextPath()%>/report/MOM_REPORT/singer/special_detail.jsp?fillDate="+fillDate+"&userid="+userid+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount;
				special_note_tab.url = redirectUrl;
			}	
		}
		    	
    </script>
</body>
</html>