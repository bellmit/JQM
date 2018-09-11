<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): jiangkanqina
  - Date: 2018-06-11 21:15:45
  - Description:
-->
<head>
<title>出入金流程待办页面</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	
</head>

<body style="width: 100%; height:100%; margin: 0px; overflow:auto;">
	<!-- 主体内容 -->
	<div region="center" style="width:100%; height:570px">
		<!-- 出入金 -->
		<%@include file="/instruction/process/goldBasic.jsp" %>

		<!-- 审批意见 -->
		<%@include file="/bpsExpend/processComm/processControlInBiz.jsp" %>
		
	</div>
	<script type="text/javascript">
		nui.parse();
		
		var lInstructId = "";
		var bizId = "${param.bizId}";
		var pageType = "";
		
		var processForm = new nui.Form("#processForm"); 	//流程信息页
		
		$(function(){
			var isEdit = 'n';
			//加载流程信息
			initProcessBiz();
			
			$("#subjectTR").show();
			$("#subjectText").text(processInstName);
			var operateData = [{id:'1',text:'同意'},{id:'2',text:'退办'},{id:'9',text:'否决'}];
			var operateType = nui.get("operateType");
			operateType.load(operateData);
			operateType.setValue("1");									
			
			//加载基础信息
			setData();
			//加载基本信息
			setInstructInfo(processInstID);			
			
			if(activityDefID != "manualActivity1" && activityDefID != "manualActivity2"){
				$("#printTr").show();
			}
			if(activityDefID != "manualActivity1" && activityDefID != "manualActivity2" && activityDefID != "manualActivity3"){
				var fromData = {processInstID:processInstID};
				var json = nui.encode(fromData);
				var url = "com.cjhxfund.ats.instruction.process.InterestSwapProcess.getIsPrint.biz.ext";
				$.ajax({  
	            	url: url,
	            	data:json,
	            	type:'POST',
	            	contentType:'text/json',
	            	cache:false,
	            	success:function(data){
	            		var returnJson = nui.decode(data);
	            		var isPr = returnJson.isPrint;
	              		if(isPr != null){
	              			nui.get("isPrint").setValue(isPr);
	              		}
	           		}
           		 }); 
				nui.get("isPrint").enabled = false;
			}
			
		});
			
		function setData(){
	          var processType = 15;
	          var attachUrl = contextPath+"/bpsExpend/common/any_upload.jsp?bizId="+bizId+"&workItemID="+workItemID+"&processinstid="+processInstID+"&attachType=1&attachBusType="+processType+"&isEdit=y";
	          $("#prodIfm").attr("src",attachUrl);
		}						
		
		function checkPrint(){
			var isPrint = nui.get("isPrint").getValue();
			if(isPrint==null||isPrint==""){
				nui.alert("您未选择是否用印，无法提交！");
				return false;
			}
		}
		
		function processSubmit(){
			if(checkProcessForm()==false) return false;//流程信息验证
			if(activityDefID == "manualActivity3"){
				if(checkPrint()==false) return false;
			}
			var fromData = getProcessFormData();
			fromData.approveInfo = fromData.pmprcaprvinfo;
			var json = nui.encode(fromData);
			var url = "com.cjhxfund.ats.instruction.process.InterestSwapProcess.goldSubmitProcess.biz.ext";
			$.ajax({   //查询用户选中设计的workItemID
	            url: url,
	            data:json,
	            type:'POST',
	            contentType:'text/json',
	            cache:false,
	            success:function(data){
	            	var returnJson = nui.decode(data);
	              	if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
	                 	nui.alert(returnJson.rtnMsg,"系统提示",function(action){
	                 		if(action == "ok" || action == "close"){
	                 	 		if (typeof(window.parent.opener.search)!="undefined"){                 	 		
	                 	 			window.parent.opener.search();		                    	
			                	}							
								window.parent.close();
	                    	}	                 			                 		                 	 	
	               		});
	                 
	              	}else{
	                 	var rtnMsg = returnJson.rtnMsg;
					    nui.alert(rtnMsg,"提示",function(action){ 
					    	if(action == "ok" || action == "close"){
	                 	 		if (typeof(window.parent.opener.search)!="undefined"){                 	 		
	                 	 			window.parent.opener.search();		                    	
			                	}							
								window.parent.close();
					    	}                			                 	          	 	
	               		}); 	 		                  	
	               	}
	            }
            });  
                    
		}
		
		
		//提供给附件上传调用
		function refreshFile(){}
    </script>
</body>
</html>