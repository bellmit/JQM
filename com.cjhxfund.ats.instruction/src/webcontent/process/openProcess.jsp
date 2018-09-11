<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): jiangkanqina
  - Date: 2018-06-07 14:11:50
  - Description:
-->
<head>
<title>利率互换开仓流程页面</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	
</head>

<body style="width: 100%; height:100%; margin: 0px; overflow:auto;">
	<!-- 主体内容 -->
	<div region="center" style="width:100%; height:570px">
		<!-- 利率互换开仓 -->
		<%@include file="/instruction/process/basicInfo.jsp" %>

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

		})
		
		function setData(){
	          var processType = 13;
	          var attachUrl = contextPath+"/bpsExpend/common/any_upload.jsp?bizId="+bizId+"&workItemID="+workItemID+"&processinstid="+processInstID+"&attachType=1&attachBusType="+processType+"&isEdit=y";
	          $("#prodIfm").attr("src",attachUrl);
		}
		
		//保存
		function saveData(){
			var fromData = {lRiskmgrId:lRiskmgrId,riskDetails:getRiskDetailData(),lResultId:lResultId,vcProductCode:nui.get("vcProductCode").getValue(),approveType:getMainApproveType()};
			var json = nui.encode(fromData);
			$.ajax({   //查询用户选中设计的workItemID
	            url:"com.cjhxfund.ats.riskMgr.riskMgr.saveRiskAllInfo.biz.ext",
	            data:json,
	            type:'POST',
	            contentType:'text/json',
	            cache:false,
	            success:function(data){
	            	if(data.rtnObject.rtnCode=="-1"){
	            		nui.showTips({
				            content: "<b>错误</b> <br/>数据保存失败",
				            state: 'danger',
				            x: 'center',
				            y: 'center',
				            timeout: 2000
				        }); 
	            	} else {
	            		nui.showTips({
				            content: "<b>成功</b> <br/>数据保存成功",
				            state: 'success',
				            x: 'center',
				            y: 'center',
				            timeout: 2000
				        });
				        grid.reload();
	            	}
	            }
            });
		}
		
		function processSubmit(){
			if(checkProcessForm()==false) return false;//流程信息验证
			var fromData = getProcessFormData();
			fromData.approveInfo = fromData.pmprcaprvinfo;
			var json = nui.encode(fromData);
			var url = "com.cjhxfund.ats.instruction.process.InterestSwapProcess.openSubmitProcess.biz.ext";
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