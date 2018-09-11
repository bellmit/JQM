<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 童伟
  - Date: 2016-11-10 13:49:57
  - Description:
-->
<%@include file="/common.jsp" %>

<head>
<title>交易录单复核人选择</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/JQMHistory/kindeditor/lang/zh_CN.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
</head>
<body style="height:90%;">
		<div style="padding-left:10px; ">
			<div style="width:100%">
				<div id="setDefaultCheckUserTips">请设置默认复核交易员</div>
				<div id="setDefaultCheckUserTips1" style="display:none">请选择复核交易员</div>
			    <div id="checkUserCombo" align="center" class="nui-combobox" style="width:250px;" required="true" popupWidth=250px textField="vcUserName" valueField="vcUserId" dataField="checkUserList"
					multiSelect="true">
				    <div property="columns">
				        <!--<div header="编号" field="empId" id="empId"></div>-->
						<div header="用户" field="vcUserId" id="vcUserId"></div>
						<div header="姓名" field="vcUserName" id="vcUserName"></div>
				    </div>
				</div>
			</div>
			<div id="setCheckUserTips" style="width:100%;height:10px;">
				<label style="display:block;padding-top: 50px;color:red;">
					【温馨提示】
					</br>此设置只会对当前指令生效，设置默认复核人请前往指令列表页面设置！
				</label>
			</div>
		</div>
		<div style=" bottom:0;padding-bottom:10px;text-align: center;width:100%;margin-top: 217px;">
			<a class='nui-button' plain='false' iconCls="icon-ok" onclick="setNowInstructCheckUser()" id="enterConfirm">确定</a>
			<a class='nui-button' plain='false' iconCls="icon-edit" onclick="setDefaultCheckUser()" id="setEnterCheckUser">设置为默认复核人</a>
			<span style="display:inline-block;width:25px;"></span>
			<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow()">关闭</a>
		</div>
	    <script type="text/javascript">
	        nui.parse();
		    var comboForm = nui.get("checkUserCombo");
	  		var row = "";
	  		var empInfo;
	  		var instructCheckUser = "";
	  		var selectCountNumValue = null;
	  		
			// 默认复核人显示
			function SetData(obj,webType){
				row = obj;
				if(webType == "set"){
					document.getElementById("enterConfirm").style.display="none";
					document.getElementById("setCheckUserTips").style.display="none";
				}else if(webType == "confirm"){
					document.getElementById("setEnterCheckUser").style.display="none";
					document.getElementById("setDefaultCheckUserTips").style.display = "none";
					document.getElementById("setDefaultCheckUserTips1").style.display = "";
				}else{
					return;
				}
	        	// 获取默认复核人
		  		nui.ajax({
	                url: "com.cjhxfund.ats.sm.comm.InstructionManager.getDefaultCheckUser.biz.ext",
	                type: 'POST',
	                contentType:'text/json',
	                success: function (text) {
	                	var returnJson = nui.decode(text);
	                	if(returnJson != null && returnJson != ""){
	                		comboForm.setValue(returnJson.data);
	                		empInfo = returnJson.data[0];
	        				comboForm.selects(returnJson.data);
	                	}
	                }
	            });
	         
            	var url = "com.cjhxfund.ats.sm.comm.InstructionManager.queryCheckUserList.biz.ext";
            	comboForm.load(url);
	        }
			
			// 设置默认复核人选择
			function setDefaultCheckUser() {
				var rows = comboForm.getSelecteds();
				var checkUser = null ;
				if (rows.length>0) {
					checkUser = comboForm.getValue();
				}else{
					nui.alert("请选择复核人","提示");
					return;
				}
				var a = nui.loading("正在处理中,请稍等...","提示");
		     	nui.ajax({
			    	url: "com.cjhxfund.ats.sm.comm.InstructionManager.updateDefaultCheckUserByProductCode.biz.ext",
			      	type: 'POST',
			      	data: {checkUser:checkUser},
			      	contentType: 'text/json',
			      	success: function(text){
			      		nui.hideMessageBox(a);
			      		var returnJson = nui.decode(text);
						if(returnJson.exception == null){
							if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
								nui.alert(returnJson.rtnMsg,"系统提示",  function(action){
									if(action == "ok"){
										window.CloseWindow();
									}	
								});
							}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
								nui.alert(returnJson.rtnMsg,"系统提示");
							}else{
								nui.alert("操作异常","系统提示");
							}
						}else{
							nui.alert("系统异常","系统提示");
						}
			      	
			      	}
	     		});
			}
			
			//关闭窗口
	        function CloseWindow(action) {
	            if (window.CloseOwnerWindow)
	            return window.CloseOwnerWindow(action);
	            else window.close();
	        }
	        
	        // 二级债指令交易员确认
			function singleConfirm(){
				delete row.lTradeDate;
				delete row.lFirstSettleDate;
				delete row.lMaturitySettleDate;
				var rows = comboForm.getSelecteds();
				var checkUser = null ;
				if (rows.length>0) {
					checkUser = rows;
				}else{
					nui.alert("请选择复核人","提示");
					return;
				}
				var json = {param:row, userIdList:checkUser};
				var a = nui.loading("正在处理中,请稍等...","提示");
			 	nui.ajax({
			    	url: "com.cjhxfund.ats.sm.comm.InstructionManager.updateCheckEnteringStatus.biz.ext",
			      	type: 'POST',
			      	data: json,
			      	contentType: 'text/json',
			      	success: function(text){
			      		nui.hideMessageBox(a);
			      		var returnJson = nui.decode(text);
						if(returnJson.exception == null){
							if(returnJson.rtnCode == "0"){
								nui.alert(returnJson.rtnMsg,"系统提示",  function(action){
									if(action == "ok"){
										window.CloseWindow();
									}	
								});
							}else if(returnJson.rtnCode == "-1"){
								nui.alert(returnJson.rtnMsg,"系统提示",  function(action){
									if(action == "ok"){
										window.CloseWindow();
									}	
								});
							}else{
								nui.alert("操作异常","系统提示");
							}
						}else{
							nui.alert("系统异常","系统提示");
						}
			      	}
				});
			}
			
			// 设置当前指令复核人（在页面保存）
			function setNowInstructCheckUser(){
				var rows = comboForm.getSelecteds();
				if (rows.length>0) {
					instructCheckUser = rows;
					nui.alert("设置成功","系统提示",  function(action){
						if(action == "ok"){
							window.CloseWindow();
						}	
					});
				}else{
					nui.alert("请选择复核人","提示");
					return;
				}
			}
			
			function getData(){
				return instructCheckUser;
			}
	   </script>
	
	</body>
</html>