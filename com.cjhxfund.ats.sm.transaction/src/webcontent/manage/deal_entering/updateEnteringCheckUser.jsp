<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 童伟
  - Date: 2016-12-16 10:28:36
  - Description:
-->
<head>
<title>修改录单复核人</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
</head>
<body>
	    <div class="font-size:16px">修改录单复核人，请选择复核交易员</div>
	    <div id="checkUserCombo" class="nui-combobox" style="width:250px;" required="true" popupWidth="400" textField="vcUserName" valueField="vcUserId" dataField="checkUserList"
    		multiSelect="true">
		    <div property="columns">
		        <!--<div header="编号" field="empId" id="empId"></div>-->
				<div header="用户" field="vcUserId" id="vcUserId"></div>
				<div header="姓名" field="vcUserName" id="vcUserName"></div>
		    </div>
		</div>
		 <a class='nui-button' plain='false' iconCls="icon-edit" onclick="updateCheckUserSubmit()">确认</a>
		<!-- <a class='nui-button' plain='false' iconCls="icon-edit" onclick="setDefaultCheckUser()">设置为默认复核人</a>-->
	    <script type="text/javascript">
	        nui.parse();
		    var comboForm = nui.get("checkUserCombo");
	  		var empInfo;
	  		
			// 默认复核人显示
			function SetData(row){
	        	var lResultId = row.lResultId;
	        	
	        	// 获取默认复核人
		  		nui.ajax({
	                url: "com.cjhxfund.ats.sm.comm.InstructionManager.getEnterCheckUsersByInstructId.biz.ext",
	                data: {lResultId:lResultId},
	                type: 'POST',
	                contentType:'text/json',
	                success: function (text) {
	                	var returnJson = nui.decode(text);
	                	if(returnJson != null && returnJson != ""){
	                		comboForm.setValue(returnJson.data);
	                		empInfo = returnJson.data[0];
	                	}
	                },
	            });
	         
            	var vcCombiCode = row.vcCombiCode;
				var vcProductCode = row.vcProductCode; 
            	var url = "com.cjhxfund.ats.sm.comm.InstructionManager.queryCheckUserList.biz.ext?vcProductCode="+vcProductCode+"&vcCombiCode="+vcCombiCode;
            	comboForm.load(url);
	        }
			
			// 复核人选择
			function updateCheckUserSubmit() {
				var row = comboForm.getSelected();
				if(row == null && empInfo == null){
					nui.alert("请选择复核人","提示");
					return;
				}
				var userIdList = null;
				if (row != null) {
					// 获取用户list
					userIdList = comboForm.getSelecteds();
				}else{
					if(comboForm.getValue() != ""){
						userIdList = comboForm.getValue();
					}else{
						nui.alert("请选择复核人","提示");
						return;
					}
				}
				var a = nui.loading("正在处理中,请稍等...","提示");
		     	nui.ajax({
			    	url: "com.cjhxfund.ats.sm.comm.InstructionManager.updateEnterCheckUser.biz.ext",
			      	type: 'POST',
			      	data: {param:{lInstructId:row.lResultId, lProcessinstId:row.lProcessinstId}, userIdList:userIdList},
			      	contentType: 'text/json',
			      	success: function(text){
			      		nui.hideMessageBox(a);
			      		var returnJson = nui.decode(text);
						if(returnJson.exception == null){
							if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
								window.CloseOwnerWindow();
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
	   </script>
	
	</body>
</html>