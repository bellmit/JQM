<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-- 
  - Author(s): zhanglu
  - Date: 2017-07-14 11:24:50
  - Description:
-->
<head>
<title>员工基本信息修改</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@include file="/coframe/tools/skins/common.jsp" %>
<script type="text/javascript" src="<%=contextPath%>/coframe/org/js/org_common.js"></script>
<style type="text/css">
    fieldset
    {
        border:solid 1px #aaa;
    }        
</style>
</head>
<body>

<div style="padding-top:5px;overflow:hidden">
<form id="form">
	<div id="form3">
		<input class="nui-hidden" name="USER_ID" />
		<table style="width:100%;" class="nui-form-table" >
			<tr>
				<th class="nui-form-label" align="right" style="width:15%;"><label>用户名：</label></th>
				<td style="width:31%;"><input id="USER_NAME" name="USER_NAME" class="nui-textbox" width="100%" readonly="true"/></td>
				<th class="nui-form-label" align="right" style="width:15%;"><label style="color:red;">*</label><label style="font-weight:bold;">&nbsp;电话：</label></th>
				<td style="width:31%;"><input id="HTEL" name="HTEL" onblur="check1(this)"  required="true" width="100%" class="nui-textbox"/></td>
			</tr>
			<tr>
				<th  align="right"><label style="font-weight:bold;">传真：</label></th>
				<td><input id="FAXNO" name="FAXNO" onblur="check(this)"  width="100%" class="nui-textbox"/></td>
				<th  align="right" width="15%"><label style="color:red">*</label><label style="font-weight:bold;">&nbsp;邮箱：</label></th>
				<td><input id="OEMAIL" name="OEMAIL" onblur="checkMail(this)"  width="100%" required="true" class="nui-textbox"/></td>
			</tr>
			<tr>
				<th align="right"><label style="font-weight:bold;">QQ：</label></th>
				<td><input id="QQ" name="QQ" onblur="check(this)" width="100%" class="nui-textbox"/></td>
				<th  align="right"><label style="font-weight:bold;">地址：</label></th>
				<td><input id="OADDRESS" name="OADDRESS"  width="100%" class="nui-textbox"/></td>
			</tr>
			<tr>
				<th  align="right"><label style="font-weight:bold;">备注：</label></th>
				<td colspan="3"><input id="REMARK" name="REMARK" vtype="maxLength:512" width="100%" class="nui-textArea"/></td>
			</tr>			
		</table>
	</div>
	<div id="form1" style="padding-top:5px;width:100%" method="post">	
	<fieldset border="0" >
			<input class="nui-hidden" name="user/userId" />
	        <legend><label><input type="checkbox"  id="userRefCheckbox" onclick="toggleFieldSet(this, 'table3')" hideFocus/>&nbsp;修改密码</label></legend>
		<table class="nui-form-table" style="width:100%;">
	      <tr class="odd">
	        <th class="nui-form-label" align="right" style="width:15%;"><label for="password$text">输入旧密码：</label></th>
	        <td style="width:35%;">
	          <input id="password" class="nui-password nui-form-input" width="100%" name="password" required="true" onvalidation="onCheckRight"/>
	        </td>
	        <td style="width:50%;"></td>
	      </tr>
	      <tr>
	        <th class="nui-form-label" align="right"><label for="pwd1$text">输入新密码：</label></th>
	        <td>
	          <input class="nui-password nui-form-input" id="pwd1" width="100%" required="true" onvalidation="onCheckPwd"/>
	        </td>
	      </tr>
	      <tr class="odd">
	        <th class="nui-form-label" align="right"><label for="pwd2$text">确定新密码：</label></th>
	        <td>
	          <input class="nui-password nui-form-input" id="pwd2" width="100%" name="user/password" required="true" onvalidation="onCheckEqual"/>
	        </td>
	      </tr>
	    </table>
		</fieldset>
    </div>
</form>
</div>
<div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:5px;" 
    borderStyle="border:0;">
    <a class="nui-button" style="width:60px;" iconCls="icon-save" onclick="saveForm">保存</a>
    <span style="display:inline-block;width:25px;"></span>
    <a class="nui-button" id="resetBtn_01" style="width:60px;" iconCls="icon-close" onclick="cancel">取消</a>
    <a class="nui-button" id="cancelBtn_01" iconCls="icon-cancel" style="width:60px;display:none;" onclick="cancel">取消</a>
</div>
</div>

<script type="text/javascript">
	 nui.parse();

    var form = new nui.Form("#form");
	var form1 = new nui.Form("#form1");
	var form3 = new nui.Form("#form3");	

	function setFormData(data){
		form3.setData(data);
	}
	
	function saveForm() {
		form3.validate();
		if (form3.isValid() == false){
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
		var url ;
		var json ;
		var ck =document.getElementById("userRefCheckbox");
		if(ck.checked){
			  var form = document.getElementById("form1");
		      if(checkFormSelf("#form1") == false){
		        return false;
		      }
			var password = nui.get("pwd2").getValue();
			var opassword = nui.get("password").getValue();
			url = "org.gocom.components.coframe.auth.LoginManager.updateUserInfo.biz.ext";
			json = nui.encode({userInfo:form3.getData(),password:password,opassword:opassword});
		}else{
			url = "org.gocom.components.coframe.auth.LoginManager.saveUserEmpInfo.biz.ext";
			json = nui.encode({userInfo:form3.getData()});
		}
		
		$.ajax({
			url: url,
			type: 'post',
			data: json,
			cache: false,
			contentType:'text/json',
			success: function (json) {
				console.log(json.status);
				if(json.status == 'success'){
					closeWindow('ok');
				}else if(json.status == 'fail1'){
					nui.alert("保存失败！");
				}else if(json.status == 'fail2'){
					nui.alert("原密码填写错误！");
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
	

	nui.get("password").readOnly="readonly";
	$("#password input").css("background-color","#f0f0f0");
	nui.get("pwd1").readOnly="readonly";
	$("#pwd1 input").css("background-color","#f0f0f0");
	nui.get("pwd2").readOnly="readonly";
	$("#pwd2 input").css("background-color","#f0f0f0");
  	//展开，折叠
    function toggleFieldSet(ck, id) {
        if(ck.checked){
        	nui.get("password").readOnly="";
        	$("#password input").css("background-color","#FFFFE6");
        	nui.get("pwd1").readOnly="";
        	$("#pwd1 input").css("background-color","#FFFFE6");
        	nui.get("pwd2").readOnly="";
        	$("#pwd2 input").css("background-color","#FFFFE6");
        }else{
        	nui.get("password").readOnly="readonly";
        	$("#password input").css("background-color","#f0f0f0");
        	nui.get("pwd1").readOnly="readonly";
        	$("#pwd1 input").css("background-color","#f0f0f0");
        	nui.get("pwd2").readOnly="readonly";
        	$("#pwd2 input").css("background-color","#f0f0f0");
        }
    }
    function cancel(){
      CloseWindow("cancel");
    }
    
    function onCheckRight(e){
      if(e.isValid){
       // if(retValue=="false"){
        //   e.errorText = "密码不正确";
        //   e.isValid = false;
       // }
      }
    }
  
    function onCheckEqual(e){
      if(e.isValid){
        var pwd = nui.get("pwd1").value;
        if(e.value!=pwd){
          e.errorText = "新密码不一致";
          e.isValid = false;
        }
      }
    }
    
    function checkFormSelf(form1){
    	var form = new nui.Form(form1);//将普通form转为nui的form
 		form.validate();
      	if (form.isValid() == true) {
      		return true;
      	}
    	return false;
    }
    
	function closeWindow(action) {            
		if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
		else window.close();
	}
    
    //验证复杂密码，必须包含数字、特殊字符与字母，最小为8位
    function onCheckPwd(e){
      var regex = new RegExp('(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,30}');
      var pwd1 = nui.get("pwd1").getValue();
      if (!regex.test(pwd1) || pwd1.length < 8) {
          e.errorText = "密码必须包含数字、字母、特殊字符且不少于8位";
          e.isValid = false;
      }
    }
	
</script>

</body>
</html>
