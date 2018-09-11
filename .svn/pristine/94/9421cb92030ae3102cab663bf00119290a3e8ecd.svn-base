<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<script src="<%= request.getContextPath() %>/common/nui/locale/zh_CN.js" type="text/javascript"></script>
<!-- 
  - Author(s): 章璐
  - Date: 2017-06-28 14:48:59
  - Description:
-->
<body>
<div class="nui-fit" style="padding-top:5px;">
	<table class="nui-form-table"  style="width:100%;height:20%;table-layout:fixed;border:0; cellspacing:0; cellpadding:0;">
		<tr style="border:0;cellspacing:0;cellpadding:0;">
			<td class="mini-messagebox-warning" width="30px" height="30px"></td>
			<td style="font-weight:bolder;color: #EE0000">温馨提示：为给您提供更优质的服务，以及响应实名制监管要求，请完善如下信息。 为此对您带来不便请多谅解。</td>
		</tr>
	</table>
	<!-- <div class="mini-messagebox-warning" style="width:30px;height:30px;float:left" ></div> -->
	<!-- <div style="height:30px;" align="center">由于监管审查，为满足合规要求，现对用户要求完善以下信息！！！</div> -->
	<form id="user_form" method="post">	
		<input class="nui-hidden" name="USER_ID" />
		<table class="nui-form-table" style="width:100%;height:100%;table-layout:fixed;">
		<tr>
			<td class="form_label" width="18%" align="right">用户名：</td>
			<td ><input id="USER_NAME" name="USER_NAME" class="nui-textbox" width="100%" readonly="true"/></td>
			<td width="15%" align="right"><label style="color:red">*</label>&nbsp;电话：</td>
			<td ><input id="HTEL" name="HTEL" onblur="check1(this)"  required="true" width="100%" class="nui-textbox"/></td>
		</tr>
		<tr>
			<td  align="right">传真：</td>
			<td><input id="FAXNO" name="FAXNO" onblur="check(this)"  width="100%" class="nui-textbox"/></td>
			<td  align="right" width="15%"><label style="color:red">*</label>&nbsp;邮箱：</td>
			<td><input id="OEMAIL" name="OEMAIL" onblur="checkMail(this)"  width="100%" required="true" class="nui-textbox"/></td>
		</tr>
		<tr>
			<td align="right">QQ：</td>
			<td><input id="QQ" name="QQ" onblur="check(this)" width="100%" class="nui-textbox"/></td>
			<td  align="right">地址：</td>
			<td><input id="OADDRESS" name="OADDRESS"  width="100%" class="nui-textbox"/></td>
		</tr>
		<tr>
			<td  align="right">备注：</td>
			<td colspan="3"><input id="REMARK" name="REMARK" vtype="maxLength:512" width="100%" class="nui-textArea"/></td>
		</tr>
		</table>
	</form>
</div>
<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:10px;" borderStyle="border:0;">
    <a class='nui-button' plain='false' iconCls="icon-save" onclick="saveForm();">保存</a>
    <span style="display:inline-block;width:25px;"></span>
    <a class='nui-button' plain='false' iconCls="icon-close" onclick="closeWindow('cancel');">关闭</a>
</div>
<script type="text/javascript">
	nui.parse();
	
	var form = new nui.Form("user_form");

	function setFormData(data){
		form.setData(data);
	}
	
	function saveForm() {
		form.validate();
		if (form.isValid() == false){
			nui.alert("请输入必填项!");
			return;
		} 
		if(!(check(nui.get("QQ")))){
			return;
		}
		if(!(checkMail(nui.get("OEMAIL")))){
			return;
		}
		if(!(check1(nui.get("HTEL")))){
			return;
		}
		if(!(check(nui.get("FAXNO")))){
			return;
		}
		
		$.ajax({
			url: "org.gocom.components.coframe.auth.LoginManager.saveUserEmpInfo.biz.ext",
			type: 'post',
			data: nui.encode({userInfo:form.getData()}),
			cache: false,
			contentType:'text/json',
			success: function (json) {
				if(json.status == 'success'){
					closeWindow('ok');
				}else{
					nui.alert("保存失败！");
					closeWindow('ok');
				}
			}
		});
	}
	function check(obj){ 
	       var reg = new RegExp("^[0-9]*[1-9][0-9]*$");  
		    if((!reg.test(obj.value)) && obj.value !=""){ 
		        nui.alert("请检查数据,该项只能输入整数!"); 
		        return false;
		    }
		    return true;  
	  }
    function check1(obj){  
	       var reg = /^0?1[3|4|5|7|8][0-9]\d{8}$/;  
		    if((!reg.test(obj.value)) && obj.value !=""){ 
		        nui.alert("请输入正确的手机号码!"); 
		        return false;
		    }
		    return true;  
	  }
	   function checkMail(obj){
	  		var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		    if((!reg.test(obj.value)) && obj.value !=""){ 
		        nui.alert("请输入正确的邮箱格式!");
		        return false;
		    }
		    return true;  
	  }
	function closeWindow(action) {            
		if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
		else window.close();
	}

</script>
</body>
</html>

