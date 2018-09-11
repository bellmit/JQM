<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 翟静
  - Date: 2016-11-10 14:01:57
  - Description:
-->
<head>
<title>账户信息管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
	<div class="nui-tabs" id="tab1" width="100%" height="100%" >
		<%-- <div title="公司信息维护" url="<%=request.getContextPath() %>/fm/baseinfo/applyTemplet/queryCompanyInfo.jsp"></div>
		<div title="账户信息维护" url="<%=request.getContextPath() %>/fm/baseinfo/applyTemplet/queryAccountInfo.jsp"></div> --%>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	//tab页权限处理
		 nui.ajax({
			url:"com.cjhxfund.ats.fm.comm.common.queryMenuList.biz.ext",
            type:'POST',
            data:{funcCode:"ATS_FM_COMPANY_INFO,ATS_FM_ACCOUNT_INFO"},
            cache:false,
            contentType:'text/json',
            success:function(text){
            	var result = nui.decode(text.treeNodes);
	        	if(result){	        	
	        		var tempArray = new Array();	        		
	        		for(var k=0;k<result.length;k++){
	        			if(result[k].RES_ID=="ATS_FM_COMPANY_INFO"){
							tempArray[0]=result[k];
						}
						if(result[k].RES_ID=="ATS_FM_ACCOUNT_INFO"){
							tempArray[1]=result[k];
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