<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): zhangyao
  - Date: 2016-12-06 16:13:30
  - Description:
-->
<head>
	<title>风控经理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="css/offeringStyle.css"/>
    <style>
    	.info_name{
    		width:145px;
    	}
    </style>
</head>
<%
    String processInstID = request.getParameter("processInstID");
	String workItemID = request.getParameter("workItemID");
	String vcExchangeNo=request.getParameter("vcExchangeNo");
	String vcType=request.getParameter("vcType");
 %>
<body>
<div id="tabs" class="nui-tabs" height="100%">
	<div title="风控经理确定指令" class="content">
        <div class="main">
            <!--表单-->
            <form id="form1" method="post" >
            	<!--基本信息-->
            	<input name="processInstID" id="processInstID" class="nui-hidden" value="<%=processInstID %>"/>
            	<input name="workItemID" id="workItemID" class="nui-hidden" value="<%=workItemID %>"/>
            	<input id="vcExchangeNo" name="vcExchangeNo" class="nui-hidden" value="<%=vcExchangeNo %>" />
            	<input id="lInstructNo" name="ipoInstructInfo.lInstructNo" class="nui-hidden" />
            	<input id="vcType" name="vcType" class="nui-hidden" value="<%=vcType %>"/>
            	<%@include file="/ipo/offering/common/common_basicInfo.jsp" %>
            	<!--合规风控-->
            	<%@include file="/ipo/offering/common/common_controlInfo.jsp" %>
            </form>	
        	<!--操作按钮-->
			<div style="width:100%;">
		        <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
		            <table style="width:100%;background:#DBE3F2;">
		                <tr>
		                    <td style="width:100%;">
		                        <a id="button1" class='nui-button' plain='false' iconCls="icon-cancel" onclick="cancelGL()" plain="false">关联检查不合规</a>
					            <span class="separator"></span>
					            <a id="button2" class='nui-button' plain='false' iconCls="icon-cancel" onclick="cancelTZ()" plain="false">投资比例不合规</a>       
		                        <span class="separator"></span>
		                        <a id="button3" class='nui-button' plain='false' iconCls="icon-undo" onclick="undo()" plain="false">恢复</a>
		                    </td>
		                    <td  style="float:right;margin-right:10px;width:75px;">
		                    	<span style="color:#626262;">不合规:<strong class="strong" style="background:#FF6666;"></strong></span>
		                    </td>
		                </tr>
		            </table>           
		        </div>
		    </div>
	        <!--撑满页面-->
			<div class="nui-fit" >    
	            <!--表格-->
	            <%@include file="/ipo/offering/common/common_product_instruct.jsp" %>
	        </div>
		</div>	
    </div>
    <div title="审批内容" name="index">
		<%@include file="/ipo/task/processControl.jsp" %>
	</div>
	<div title="流程信息" url="/ats/sm/comm/task/processGraph.jsp?processInstID=<%=processInstID %>" ></div>
</div>
<script type="text/javascript" src="js/loadbasicInfo.js"></script>
<script type="text/javascript">
	var grid = nui.get("datagrid1");
	var data={processInstID:processInstID,participantType:"00"};
	grid.load(data);
	//grid.frozenColumns (0,5);
	
	//隐藏列
	(function (){
		grid.hideColumn (19);//沪市股东账户
		grid.hideColumn (20);//上交所协会编码
		grid.hideColumn (17);//深圳席位号
		grid.hideColumn (18);//深交所配售对象编码
		grid.hideColumn (16);//对应上交所日均市值
		grid.hideColumn (15);//对应深交所日均市值
		grid.hideColumn (12);//完成时间
	})();
	
	//提交流程
	function processSubmit(){
		nui.get("processSubmit").disable();
		nui.confirm("确认是否提交流程？","系统提示",function(action){
			if(action == "ok"){
				var processForm=new nui.Form("processForm");
				var data=processForm.getData();
				//var data={workItemID:workItemID};
				data["workItemID"]=workItemID;
				var approveData={approveParam:data};
				var json=nui.encode(approveData);
				nui.ajax({
					url: "com.cjhxfund.ats.ipo.task.finishMyWork.biz.ext",
				   	type: "post",
				    data: json,
				    contentType:'text/json',
				    success: function (text) {
			        	var returnJson = nui.decode(text);
				        if(returnJson.exception == null){
				        	if(returnJson.rtnCode=="-1"){
			        			nui.alert("审批确认失败","系统提示");
			        			nui.get("processSubmit").enable();
			        		}else{
			        			nui.alert("审批确认成功","系统提示",function(){
			        				opener.location.reload();
									window.opener = null;
									window.open(' ', '_self', ' ');
									window.close();
			        			});
			        		}
			        	}else{
			        		nui.get("processSubmit").enable();
			        	}
	        		},
	        		ondestroy:function(action){
	        			nui.get("processSubmit").enable();
	        		},
	        		error:function(error){
	        			nui.get("processSubmit").enable();
	        		}
				});
			}else{
				nui.get("processSubmit").enable();
			}
		});
	}
			
	//关联检查不合规
	function cancelGL(){
		//获取当前行
		var rows=grid.getSelecteds ();
		if(rows.length!=0){
			nui.confirm("确认所选产品是关联检查不合规！","系统提示",function(action){
				if(action == "ok"){
					var loadData = {processInstID:processInstID,participantType:"00"};
					//获取指令数据信息
					var instructData=form.getData();
					var data={productInfo:rows,instructInst:instructData.ipoInstructInfo,vcComplianceState:"01"};
					var json=nui.encode(data);
					nui.ajax({
				        url: "com.cjhxfund.ats.ipo.busOpr.updateRiskState.biz.ext",
				        type: "post",
				        data: json,
				        contentType:'text/json',
				        success: function (text) {
			        		var returnJson = nui.decode(text);
				        	if(returnJson.exception == null){
				        		if(returnJson.rtnCode=="-1"){
				        			nui.alert("更新合规状态失败","系统提示");
				        		}else{
				        			nui.alert("更新合规状态成功","系统提示");
				        			grid.load(loadData);
				        		}
				        	}
		        		}
					});
		        }
			}); 
		}else{
			nui.alert("请选中一条记录");
		}
	 }
	//投资比例不合规
	function cancelTZ(){
		//获取当前行
		var rows=grid.getSelecteds ();
		if(rows.length!=0){
			nui.confirm("确认所选产品是投资比例检查不合规！","系统提示",function(action){
				if(action == "ok"){
					var loadData = {processInstID:processInstID,participantType:"00"};
					//获取指令数据信息
					var instructData=form.getData();
					var data={productInfo:rows,instructInst:instructData.ipoInstructInfo,vcComplianceState:"02"};
					var json=nui.encode(data);
					nui.ajax({
				        url: "com.cjhxfund.ats.ipo.busOpr.updateRiskState.biz.ext",
				        type: "post",
				        data: json,
				        contentType:'text/json',
				        success: function (text) {
			        		var returnJson = nui.decode(text);
				        	if(returnJson.exception == null){
				        		if(returnJson.rtnCode=="-1"){
				        			nui.alert("更新合规状态失败","系统提示");
				        		}else{
				        			nui.alert("更新合规状态成功","系统提示");
				        			grid.load(loadData);
				        		}
				        	}
		        		}
					});
		        }
			});
		}else{
			nui.alert("请选中一条记录");
		}
	}
	//恢复
    function undo(){
		var lInstructNo=nui.get("lInstructNo").value;
		var rows = grid.getSelecteds();
		var data={productInfo:rows,lInstructNo:lInstructNo,vcComplianceState:"00"};
		var json=nui.encode(data);
		if(rows.length>0){
			nui.ajax({
		        url: "com.cjhxfund.ats.ipo.busOpr.recoverRiskState.biz.ext",
		        type: "post",
		        data: json,
		        async: false,
		        contentType:'text/json',
		        success: function (text) {
		        	var returnJson = nui.decode(text);
		        	if(returnJson.exception == null){
		        		grid.reload();
		        		nui.alert("恢复成功","系统提示");
		        	}
		        }
	    	});
	    }else{
	    	nui.alert("请选择一行数据","系统提示");
	    }
	}
	//列表选择发生变化时触发事件
	function selectionChanged(){
	
	}
	grid.on("drawcell", function (e) {
	 	var record = e.record;
        //设置行样式
        if (record.vcComplianceState == "01"||record.vcComplianceState == "02") {//01:关联检查不合规;02:投资比例不合规
            e.rowStyle = "background:#FF6666";
        }
	});
		
</script>
</body>
</html>