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
<title>风控发起页面</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	
</head>

<body style="width: 100%; height:100%; margin: 0px; overflow:auto;">
<div id="tabs" class="nui-tabs" height="100%"> 
	 <div title="基本信息"> 
		<!-- 主体内容 -->
		<div region="center" style="width:100%; height:570px">
		
			<l:equal property="cBizType" propertyType="parameter" targetValue="1"  >
				<!-- 一级债交易信息 -->
   				<%@include file="/riskMgr/instruct/firstGradeDabtJkView.jsp" %>
			</l:equal>
			
			
			<l:notEqual property="cBizType"  propertyType="parameter" targetValue="1">
				<!-- 二级债交易信息 -->
	   			<%@include file="/riskMgr/instruct/instructInfoView.jsp" %>
			</l:notEqual>
			
			
   			<!-- 风控信息 -->
   			<%@include file="/riskMgr/instruct/riskInfoBanTableForApprove.jsp" %>
			
			<!-- 审批意见 -->
			<%@include file="/bpsExpend/processComm/processControlInBiz.jsp" %>
			
		</div>
	</div> 
</div>	
	<script type="text/javascript">
		nui.parse();
		var lRiskmgrId = "${param.lRiskmgrId}";
		var lResultId = "${param.lResultId}";
		var vcRiskType = "${param.vcRiskType}";
		var cBizType = "${param.cBizType}";
		var pageType = "edit";
		var isEdit = "y";
		var isNewRisk = "n";//是否手动新增的风控
		var isSaved = "n";//是否已保存
		
		var grid = nui.get("approveRiskGrid");	//风控信息页
		var processForm = new nui.Form("#processForm"); 	//流程信息页
		
		$(function(){
			//加载交易信息
			setInstructInfo(lResultId);
			//加载风控表格
			setRiskInfoTable(lRiskmgrId,null,isEdit);
			//加载误卡按钮
			judgeIsBtnAuth();
			//加载lRiskmgrId
			setRiskmgrId();
			//加载流程信息
			initProcessBiz();
			//加载审批意见
			setApproveTemp(lRiskmgrId,"11");
			var attachUrl = contextPath+"/bpsExpend/common/any_upload.jsp?bizId="+lRiskmgrId+"&processinstid=0&attachType=1&attachBusType=11&isEdit=y";
        	$("#prodIfm").attr("src",attachUrl);
		});
		
		//加载业务主键
		function setRiskmgrId(){
			if(lRiskmgrId!=null&&lRiskmgrId!="") return;
			$.ajax({   //查询用户选中设计的workItemID
	            url:"com.cjhxfund.ats.riskMgr.riskMgr.getRiskPrimaryKey.biz.ext",
	            data:{},
	            type:'POST',
	            contentType:'text/json',
	            cache : false,
				async: false,
	            success:function(data){
	            	lRiskmgrId = data.lRiskmgrId;
	            	isNewRisk = "y";
	            }
            });
			
		}
		
		//判断是否有风控误卡废弃权限
		function judgeIsBtnAuth(){
			if(lRiskmgrId==null||lRiskmgrId=="") {
				nui.get("endProcess").hide();
				return;
			}
			var json = nui.encode({vcProductCode:nui.get("vcProductCode").getValue(),lResultId:lResultId,lRiskmgrId:lRiskmgrId});
			$.ajax({   //查询用户选中设计的workItemID
	            url:"com.cjhxfund.ats.riskMgr.riskMgr.judgeIsAuth.biz.ext",
	            data:json,
	            type:'POST',
	            contentType:'text/json',
	            cache : false,
				async: false,
	            success:function(data){
	            	//风控误卡按钮显隐
	            	if(data.btnAuth){
	            		nui.get("endProcess").show();
	            	} else {
	            		nui.get("endProcess").hide();
	            	}
	            }
            });
		}
		
		//保存
		function saveData(){
		debugger;
			//遮罩
			var messageid = nui.loading("正在保存，请稍等……", "系统提示");
			//审批意见
			var approveInfo = getProcessFormData().pmprcaprvinfo;
			//风控审批类型
			var approveType = getMainApproveType();
			//禁止类型
			var fromData = {
							lRiskmgrId:lRiskmgrId,
							riskDetails:getRiskDetailData(),
							approveType:approveType,
							lResultId:lResultId,
							vcProductCode:nui.get("vcProductCode").getValue(),
							vcComment:approveInfo.vcComments,
							isNewRisk:isNewRisk
						};
			var json = nui.encode(fromData);
			$.ajax({   //查询用户选中设计的workItemID
	            url:"com.cjhxfund.ats.riskMgr.riskMgr.saveRiskAllInfo.biz.ext",
	            data:json,
	            type:'POST',
	            contentType:'text/json',
	            cache:false,
	            success:function(data){
	            	isSaved="y";
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
	            		var riskInfo = data.riskInfo;
	            		lRiskmgrId = riskInfo.lRiskmgrId;
	            		lResultId = riskInfo.lResultId;
	            		nui.showTips({
				            content: "<b>成功</b> <br/>数据保存成功",
				            state: 'success',
				            x: 'center',
				            y: 'center',
				            timeout: 2000
				        });
	            	}
	            	grid.reload();
	            }
            });
		}
		
		function processSubmit(){
			//风控表格验证
			if(checkRiskDetail())return;
			//遮罩
			var messageid = nui.loading("正在提交，请稍等……", "系统提示");
			var fileIds = document.getElementById("prodIfm").contentWindow.getNoProcessIdFileIds();
			var fromData = {riskDetails:getRiskDetailData(),lResultId:lResultId,lRiskmgrId:lRiskmgrId,
							vcProductCode:nui.get("vcProductCode").getValue(),approveType:getMainApproveType(),
							fileIds:fileIds,isNewRisk:isNewRisk};
			var processData = getProcessFormData();
			fromData.approveInfo = processData.pmprcaprvinfo;//审批意见
			var json = nui.encode(fromData);
			$.ajax({   //查询用户选中设计的workItemID
	            url:"com.cjhxfund.ats.riskMgr.riskMgr.startRiskProcess.biz.ext",
	            data:json,
	            type:'POST',
	            contentType:'text/json',
	            cache:false,
	            success:function(data){
	            	var returnJson = nui.decode(data);
	              	nui.hideMessageBox(messageid);//取消遮罩
	              	if(returnJson.exception == null){
	                 	nui.alert("流程提交成功","系统提示",function(action){
	                 	 	if (window.opener && window.opener.search){
		                    	window.opener.search();
			                }
	                 	 	//返回我的代办任务页面
			      	     	window.close();
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
		
	 	window.onbeforeunload=onclose;//如果没有保存手动新增数据，则删除
		function onclose(){
			if(isSaved=="n"&&isNewRisk=="y"){
				var json = nui.encode({lRiskmgrId:lRiskmgrId});
				$.ajax({  
		            url:"com.cjhxfund.ats.riskMgr.riskMgr.deleteTempAttachInfo.biz.ext",
		            data:json,
		            type:'POST',
		            contentType:'text/json',
		            cache : false,
					async: false,
		            success:function(data){
		            }
	            });
            }
		}
    </script>
</body>
</html>