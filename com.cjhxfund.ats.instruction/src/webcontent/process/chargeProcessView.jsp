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
<title>利率互换冲销平仓已办流程页面</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	
</head>

<body style="width: 100%; height:100%; margin: 0px; overflow:auto;">
	<!-- 主体内容 -->
	<div region="center" style="width:100%; height:570px">
		<!-- 利率冲销平仓 -->
		<%@include file="/instruction/process/chargeBasic.jsp" %>

		<!-- 审批意见 -->
		<%@include file="/bpsExpend/processComm/processViewInBiz.jsp" %>
		
	</div>
	<script type="text/javascript">
		nui.parse();
		
		var lInstructId = "";
		var bizId = "${param.bizId}";
		var pageType = "";
		
		var processForm = new nui.Form("#processForm"); 	//流程信息页
		
		$(function(){
			//加载流程信息
			initProcessView();
			
			$("#subjectTR").show();
			$("#subjectText").text(processInstName);
			$("#operateTr").hide();
			
			//加载基础信息
			setData();
			//加载基本信息
			setInstructInfo(processInstID);
			
			var processState = basicInfo.vcProcessState;
			if(processState!=null && processState!=""){
				$("#printTr").show();
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
			
			if(processState==4 || processState==5){
				$("#chargeCapitalTr").show();
				$("#chargeArrangeTr").show();
				if(basicInfo.lChargeConfirm != null){
					nui.get("chargeCapital").setValue(basicInfo.lChargeConfirm);
				}
				if(basicInfo.vcPayArrange != null){
					nui.get("chargeArrange").setValue(basicInfo.vcPayArrange);
					chargeArClick();
				}
				if(basicInfo.lPayAmout != null){
					nui.get("payAmout").setValue(basicInfo.lPayAmout);
				}
				if(basicInfo.vcPayName != null){
					nui.get("payName").setValue(basicInfo.vcPayName);
				}
				if(basicInfo.vcPayNo != null){
					nui.get("payNo").setValue(basicInfo.vcPayNo);
				}
				if(basicInfo.lIncomeAmout != null){
					nui.get("incomeAmout").setValue(basicInfo.lIncomeAmout);
				}
				
				nui.get("chargeCapital").enabled = false;	
				nui.get("chargeArrange").enabled = false;
				nui.get("payAmout").enabled = false;
				nui.get("payName").enabled = false;
				nui.get("payNo").enabled = false;
				nui.get("incomeAmout").enabled = false;								
				
			}
			
		});
		
		function chargeArClick(){
			var value = nui.get("chargeArrange").getValue();
			if(value == 1){
				$("#chargePayTr").show();
				$("#chargeIncomeTr").hide();
			}
			else if(value == 2){
				$("#chargePayTr").hide();
				$("#chargeIncomeTr").show();
			}
			else if(value == 3){
				$("#chargePayTr").hide();
				$("#chargeIncomeTr").hide();
			}
		}
		
		function setData(){
	          var processType = 14;
	          var attachUrl = contextPath+"/bpsExpend/common/any_upload.jsp?bizId="+bizId+"&processinstid="+processInstID+"&attachType=1&attachBusType="+processType+"&isEdit=n";
	          $("#prodIfm").attr("src",attachUrl);
		}
				
		
		//提供给附件上传调用
		function refreshFile(){}
    </script>
</body>
</html>