<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): wjh
  - Date: 2018-03-07 17:00:50
  - Description:
-->
<head>
<title>风控待办页面</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	
</head>

<body style="width: 100%; height:100%; margin: 0px; overflow:auto;">
	<!-- 主体内容 -->
	<div region="center" style="width:100%; height:570px">
	
	
	<%-- 	<l:equal property="pageType" propertyType="parameter" targetValue="1"  >
			<!-- 一级债交易信息 -->
   			<%@include file="/riskMgr/instruct/firstGradeDabtView.jsp" %>
		</l:equal>
		 --%>
		
		<l:equal property="pageType" propertyType="parameter" targetValue="1"  >
				<!-- 一级债交易信息 -->
				
				<l:equal property="biztypename" propertyType="parameter" targetValue="申购流程"  >
				<!-- 一级债交易信息 -->
   				<%@include file="/riskMgr/instruct/firstGradeDabtSgView.jsp" %>
			   </l:equal>
			   
			   
			   
			   <l:equal property="biztypename" propertyType="parameter" targetValue="缴款流程"  >
				<!-- 一级债交易信息 -->
   				<%@include file="/riskMgr/instruct/firstGradeDabtJkView.jsp" %>
			   </l:equal>
			
	   </l:equal>
			
		
		
		
		<l:notEqual property="pageType"  propertyType="parameter" targetValue="1">
			<!-- 交易信息 -->
   			<%@include file="/riskMgr/instruct/instructInfoView.jsp" %>
		</l:notEqual>
		
		
		
		
   		<!-- 风控信息 -->
   		<%@include file="/riskMgr/instruct/riskInfoBanTableForApprove.jsp" %>
		
		<!-- 审批意见 -->
		<%@include file="/bpsExpend/processComm/processControlInBiz.jsp" %>
		
	</div>
	<script type="text/javascript">
		nui.parse();
		
		var lRiskmgrId = "${param.lRiskmgrId}";
		var lResultId = "${param.lResultId}";
		var vcRiskType = "${param.vcRiskType}";
		var bizId = "${param.bizId}";
		var biztypename = "${param.biztypename}";
		var cBizType = "${param.cBizType}";
		
		var pageType = "";
		
		var grid = nui.get("approveRiskGrid");	//风控信息页
		var processForm = new nui.Form("#processForm"); 	//流程信息页
		
		$(function(){
		
		debugger;
			var isEdit = 'n';
			
		
			//加载基础信息
			setData();
			
			
			//加载交易信息
			setInstructInfo(lResultId);
			
				//加载流程信息
			initProcessBiz();
			
			
			if(activityDefID=="manualActivitym1"){
				isEdit = 'y';
				nui.get("saveBtn").show();//流程信息页面保存按钮
			}
			//若为风控误卡流程
			if(processDefName=="com.cjhxfund.ats.riskMgr.riskmgrMistake"){
				isEdit = 'n';
				nui.get("saveBtn").hide();
			}
			//加载风控表格
			setRiskInfoTable(lRiskmgrId,null,isEdit);
		})
		
		function setData(){
		debugger;
			var json = nui.encode({bizId:bizId});
			$.ajax({   //查询用户选中设计的workItemID
	            url:"com.cjhxfund.ats.riskMgr.riskMgr.getRIskInfoByBizId.biz.ext",
	            data:json,
	            type:'POST',
	            contentType:'text/json',
	            cache : false,
				async: false,
	            success:function(data){
	            	lRiskmgrId = data.riskInfo.lRiskmgrId;
	            	lResultId = data.riskInfo.lResultId;
	            	//风控误卡按钮显隐
	            	if(data.btnAuth){
	            		nui.get("endProcess").show();
	            	} else {
	            		nui.get("endProcess").hide();
	            	}
	            	var processType = 11;
	            	if(processDefName == "com.cjhxfund.ats.riskMgr.riskmgrMistake") {
	            		processType = 12;
	            		nui.get("endProcess").hide();
            		}
	            	var attachUrl = contextPath+"/bpsExpend/common/any_upload.jsp?bizId="+bizId+"&workItemID="+workItemID+"&processinstid="+processInstID+"&attachType=1&attachBusType="+processType+"&isEdit=y";
	            	$("#prodIfm").attr("src",attachUrl);
	            }
            });
		}
		
		//保存
		function saveData(){
			//遮罩
			var messageid = nui.loading("正在保存，请稍等……", "系统提示");
			var fromData = {lRiskmgrId:lRiskmgrId,riskDetails:getRiskDetailData(),lResultId:lResultId,vcProductCode:nui.get("vcProductCode").getValue(),approveType:getMainApproveType()};
			var json = nui.encode(fromData);
			$.ajax({   //查询用户选中设计的workItemID
	            url:"com.cjhxfund.ats.riskMgr.riskMgr.saveRiskAllInfo.biz.ext",
	            data:json,
	            type:'POST',
	            contentType:'text/json',
	            cache:false,
	            success:function(data){
	            	nui.hideMessageBox(messageid);//取消遮罩
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
			//遮罩
			var messageid = nui.loading("正在提交，请稍等……", "系统提示");
			//风控表格验证
			if(checkRiskDetail())return false;
			var fromData = getProcessFormData();
			fromData.riskDetails=getRiskDetailData();
			fromData.lResultId=lResultId;
			fromData.lRiskmgrId=lRiskmgrId;
			fromData.vcProductCode=nui.get("vcProductCode").getValue();
			fromData.approveType=getMainApproveType();
			fromData.approveInfo = fromData.pmprcaprvinfo;
			var json = nui.encode(fromData);
			var url = "com.cjhxfund.ats.riskMgr.riskMgr.auditRiskProcess.biz.ext";
			if(processDefName=="com.cjhxfund.ats.riskMgr.riskmgrMistake") 
				url = "com.cjhxfund.ats.riskMgr.riskmgrMistake.auditRiskMistakeProcess.biz.ext";
			$.ajax({   //查询用户选中设计的workItemID
	            url: url,
	            data:json,
	            type:'POST',
	            contentType:'text/json',
	            cache:false,
	            success:function(data){
	            	var returnJson = nui.decode(data);
	              	nui.hideMessageBox(messageid);//取消遮罩
	              	if(returnJson.exception == null){
	                 	nui.alert("流程提交成功","系统提示",function(action){
	                 	 	//刷新前页面
	                 	 	if (typeof(window.parent.opener.search)!="undefined"){
		                    	window.parent.opener.search();
			                }
	                 	 	//返回我的代办任务页面
							window.parent.close();
	               		});
	                 
	              	}else{
	                 	nui.alert("流程提交失败。", "系统提示", function(action){
	                    	if(action == "ok" || action == "close"){
	                    	}
	                  	});
	               	}
	            }
            });
		}
		
		//验证风控信息
		function checkRiskDetail(){
			var rows = grid.getData();
			var text = "";
			for(var i=0;i<rows.length;i++){
				if(rows[i].vcRiskDescribe==null||rows[i].vcRiskDescribe==""){
					text += text?"<br/>风控信息第"+(i+1)+"行的风控说明不能为空":"风控信息第"+(i+1)+"行的风控说明不能为空";
				}
			}
			if(text)nui.alert(text);
			return text?true:false;
		}
		
		//提供给附件上传调用
		function refreshFile(){}
    </script>
</body>
</html>