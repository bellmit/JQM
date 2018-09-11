<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 胥思明
  - Date: 2016-11-17 16:48:54
  - Description:
-->
<head>
<title>发行主体归集</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

</head>
<body>

	<div class="nui-tabs" id="tab1" width="100%" height="100%" >
		<%-- <div title="发行主体信息" url="<%=request.getContextPath() %>/fm/baseinfo/issuerInfo/queryIssuerInfo.jsp"></div>
		<div title="发行主体_导出到O32" url="<%=request.getContextPath() %>/fm/baseinfo/issuerInfo/queryIssuerInfoTemp.jsp"></div> --%>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	//tab页权限处理
		 nui.ajax({
			url:"com.cjhxfund.ats.fm.comm.common.queryMenuList.biz.ext",
            type:'POST',
            data:{funcCode:"ATS_FM_ISSUER_INFO,ATS_FM_ISSUER_EXPORT_O32,ATS_FM_ISSUER_ALIAS,ATS_FM_TRADERIVAL,ATS_FM_UNDERWRITER_ALIAS"},
            cache:false,
            contentType:'text/json',
            success:function(text){
            	var result = nui.decode(text.treeNodes);
	        	if(result){
			        var tempArray = new Array();	        		
	        		for(var k=0;k<result.length;k++){
	        			if(result[k].RES_ID=="ATS_FM_ISSUER_INFO"){
							tempArray[0]=result[k];
						}
						if(result[k].RES_ID=="ATS_FM_ISSUER_EXPORT_O32"){
							tempArray[1]=result[k];
						}
						if(result[k].RES_ID=="ATS_FM_ISSUER_ALIAS"){
							tempArray[2]=result[k];
						}
						if(result[k].RES_ID=="ATS_FM_TRADERIVAL"){
							tempArray[3]=result[k];
						}	
						if(result[k].RES_ID=="ATS_FM_UNDERWRITER_ALIAS"){
							tempArray[4]=result[k];
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