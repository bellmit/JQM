<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): CJ-WB-DT13
  - Date: 2016-07-26 14:13:17
  - Description:
-->
<head>
<title>新债信息归集</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body style="width: 100%;height: 100%;overflow: hidden;margin: 0px;">
	<div class="nui-tabs" id="tab1" width="100%" height="100%" >
		<%-- <div title="监控信息" url="<%=request.getContextPath() %>/fm/baseinfo/intfStockInfoQuery/monitorMsg.jsp"></div>
		<div title="新债接口信息_O32数据" url="<%=request.getContextPath() %>/fm/baseinfo/intfStockInfoQuery/queryIntfStockInfo.jsp"></div>
		<div title="新债接口信息_Wind数据" url="<%=request.getContextPath() %>/fm/baseinfo/intfStockInfoQuery/stockInfoWindQuery.jsp"></div>
		<div title="新债接口信息_Wind数据_ATS格式" url="<%=request.getContextPath() %>/fm/baseinfo/intfStockInfoQuery/queryWindStockInfo.jsp"></div>
		<div title="新债信息归集"  url="<%= request.getContextPath() %>/fm/baseinfo/intfStockInfoQuery/debtIssueIntfQuery.jsp"></div>
		<div title="新债信息_Wind转换规则" url="<%=request.getContextPath() %>/fm/baseinfo/intfStockInfoQuery/dictMapWind.jsp"></div>
		<div title="新债信息_导出到O32" url="<%=request.getContextPath() %>/fm/baseinfo/intfStockInfoQuery/queryStockIssueTemp.jsp"></div> --%>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	//tab页权限处理
		 nui.ajax({
			url:"com.cjhxfund.ats.fm.comm.common.queryMenuList.biz.ext",
            type:'POST',
            data:{funcCode:"ATS_FM_MONITOR_INFO,ATS_FM_STOCK_INFO_O32,ATS_FM_STOCK_WIND,ATS_FM_STOCK_WIND_ATS,ATS_FM_STOCK_INTF_TAB,ATS_FM_STOCK_WIND_MAP,ATS_FM_STOCK_INFO_TEMP"},
            cache:false,
            contentType:'text/json',
            success:function(text){
            	var result = nui.decode(text.treeNodes);
	        	if(result){
			        var tempArray = new Array();	        		
	        		for(var k=0;k<result.length;k++){
	        			if(result[k].RES_ID=="ATS_FM_MONITOR_INFO"){
							tempArray[0]=result[k];
						}
						if(result[k].RES_ID=="ATS_FM_STOCK_INFO_O32"){
							tempArray[1]=result[k];
						}
						if(result[k].RES_ID=="ATS_FM_STOCK_WIND"){
							tempArray[2]=result[k];
						}
						if(result[k].RES_ID=="ATS_FM_STOCK_WIND_ATS"){
							tempArray[3]=result[k];
						}	
						
						if(result[k].RES_ID=="ATS_FM_STOCK_INTF_TAB"){
							tempArray[4]=result[k];
						}	
						
						if(result[k].RES_ID=="ATS_FM_STOCK_WIND_MAP"){
							tempArray[5]=result[k];
						}	
						
						if(result[k].RES_ID=="ATS_FM_STOCK_INFO_TEMP"){
							tempArray[6]=result[k];
						}	
																		
	        		}
	        		
		        	for(var i=0;i<tempArray.length;i++){
		        		if(tempArray[i]!=null){
					    	var actionURL = '<%=request.getContextPath()%>'+tempArray[i].FUNCACTION;
					    	
							var tabs = nui.get("tab1"); 
							
					        var tab = {title: tempArray[i].FUNCNAME,url:actionURL,showCloseButton:false};
					        var tab1 = tabs.addTab(tab);  
				        }          			        
			        }
			        var tabs = nui.get("tab1");
			        var tab1 = tabs.getTab(0);
                    tabs.activeTab(tab1);	 
	            }
            }
		 });
    </script>
</body>
</html>