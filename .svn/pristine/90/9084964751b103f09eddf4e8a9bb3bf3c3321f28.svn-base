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
<title>利率互换冲销平仓流程页面</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	
</head>

<body style="width: 100%; height:100%; margin: 0px; overflow:auto;">
	<!-- 主体内容 -->
	<div region="center" style="width:100%; height:570px">
		<!-- 利率冲销平仓 -->
		<%@include file="/instruction/process/chargeBasic.jsp" %>

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
			
			if(activityDefID == "manualActivity8" || activityDefID == "manualActivity9" || activityDefID == "manualActivity10"){
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
				
				if(activityDefID == "manualActivity9" || activityDefID == "manualActivity10"){
					nui.get("chargeCapital").enabled = false;	
					nui.get("chargeArrange").enabled = false;
					nui.get("payAmout").enabled = false;
					nui.get("payName").enabled = false;
					nui.get("payNo").enabled = false;
					nui.get("incomeAmout").enabled = false;			
				}				
				
			}

		})
		
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
		
		function checkCharge(){
			var chargeCapital = nui.get("chargeCapital").getValue();
			var chargeArrange = nui.get("chargeArrange").getValue();
			var payAmout = nui.get("payAmout").getValue();
			var payName = nui.get("payName").getValue();
			var payNo = nui.get("payNo").getValue();
			var incomeAmout = nui.get("incomeAmout").getValue();
			
			if(chargeCapital==null||chargeCapital==""){
				nui.alert("本次已冲销金额不能为空");
				return false;
			}else{
				var validation = nui.get("chargeCapital").isValid();
				if(validation==false){
					nui.alert("本次已冲销金额输入有误");
				 	return false;
			 	} 
			}			
			
			if(chargeArrange==null||chargeArrange==""){
				nui.alert("收付款安排不能为空");
				return false;
			}
			
			if(chargeArrange==1){
				if(payAmout==null||payAmout==""){
					nui.alert("出款金额不能为空");
					return false;
				}else{
					var validation = nui.get("payAmout").isValid();
					if(validation==false){
						nui.alert("出款金额输入有误");
				 		return false;
			 		} 
				}
			
				if(payName==null||payName==""){
					nui.alert("收款账户名不能为空");
					return false;
				}
				
				if(payNo==null||payNo==""){
					nui.alert("收款账号不能为空");
					return false;
				}
			}
			if(chargeArrange==2){
				if(incomeAmout==null||incomeAmout==""){
					nui.alert("收款金额不能为空");
					return false;
				}else{
					var validation = nui.get("incomeAmout").isValid();
					if(validation==false){
						nui.alert("收款金额输入有误");
				 		return false;
			 		} 
				}
			}
			
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
			if(activityDefID == "manualActivity8"){
				if(checkCharge()==false) return false;
			}
			var fromData = getProcessFormData();
			fromData.approveInfo = fromData.pmprcaprvinfo;
			
			fromData.chargeMoney.chargeCapital = nui.get("chargeCapital").getValue().replace(/,/g,'');
			fromData.chargeMoney.payAmout = nui.get("payAmout").getValue().replace(/,/g,'');
			fromData.chargeMoney.incomeAmout = nui.get("incomeAmout").getValue().replace(/,/g,'');
			
			var json = nui.encode(fromData);
			var url = "com.cjhxfund.ats.instruction.process.InterestSwapProcess.chargeSubmitProcess.biz.ext";
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