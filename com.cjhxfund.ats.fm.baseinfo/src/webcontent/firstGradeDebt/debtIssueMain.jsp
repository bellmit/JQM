<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>
<html>
<!-- 
  - Author(s): 石浩
  - Date: 2016-08-16 14:36:39
  - Description:
-->
<head>
<title>新债信息发行维护</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body style="margin: 0px;padding: 0px;overflow: hidden;width: 100%;height: 100%;">
  <div style="width:100%;height:100%;" >
	   <div  class="nui-tabs" style="width:100%;height:100%;" activeIndex="0" id="tab1">
	 			<!-- 新债录入 -->
				<%-- <div title="新债录入" url="<%= request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueInputManage.jsp">
				</div>
				<div title="新债复核"  url="<%= request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueApprove.jsp">
				</div>
				<div title="新债查重"  url="<%= request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueMerge.jsp">
				</div>
				<div title="新债查询"  url="<%= request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueQuery.jsp">
				</div> --%>
	   </div>
  </div>
</body>
	<script type="text/javascript">
    	nui.parse();
    		//tab页权限处理
		 nui.ajax({
			url:"com.cjhxfund.ats.fm.comm.common.queryMenuList.biz.ext",
            type:'POST',
            data:{funcCode:"ATS_FM_STOCK_INPUT,ATS_FM_STOCK_APPROVE,ATS_FM_STOCK_MERGE,ATS_FM_STOCK_QUERY,ATS_FM_UNDERWRITER,ATS_FM_UNDERWRITER_TARGET,ATS_FM_UNDERWRITER_RELEASE"},
            cache:false,
            contentType:'text/json',
            success:function(text){
            	var result = nui.decode(text.treeNodes);
	        	if(result){
			        var tempArray = new Array();	        		
	        		for(var k=0;k<result.length;k++){
	        			if(result[k].RES_ID=="ATS_FM_STOCK_INPUT"){
							tempArray[0]=result[k];
						}
						if(result[k].RES_ID=="ATS_FM_STOCK_MERGE"){
							tempArray[1]=result[k];
						}
						if(result[k].RES_ID=="ATS_FM_STOCK_APPROVE"){
							tempArray[2]=result[k];
						}
						if(result[k].RES_ID=="ATS_FM_STOCK_QUERY"){
							tempArray[3]=result[k];
						}						
						if(result[k].RES_ID=="ATS_FM_UNDERWRITER"){
							tempArray[4]=result[k];
						}
						if(result[k].RES_ID=="ATS_FM_UNDERWRITER_TARGET"){
							tempArray[5]=result[k];
						}
						if(result[k].RES_ID=="ATS_FM_UNDERWRITER_RELEASE"){
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
</html>