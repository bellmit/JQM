<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	
<%@include file="/common/js/commscripts.jsp" %>
<html>
<%--
  - Author(s): admin
  - Date: 2009-06-22 11:33:08
  - Description:
--%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
	<title>意见/建议录入</title>
	<script charset="utf-8" src="<%= request.getContextPath() %>/JQMHistory/kindeditor/kindeditor-min.js"></script>
	<script charset="utf-8" src="<%= request.getContextPath() %>/JQMHistory/kindeditor/lang/zh_CN.js"></script>
	<script>
  		KindEditor.ready(function(K) {
   			window.editor = K.create('#vcSuggestionContent', { 
   				allowImageUpload:true,//允许上传图片
        		allowFileManager:true, //允许对上传图片进行管理
        		urlType:'domain',//设置路径为绝对路径
        		allowImageRemote: false,
	    		uploadJson : '<%=request.getContextPath() %>/JQMHistory/kindeditor/jsp/upload_json.jsp',
	    		fileManagerJson : '<%=request.getContextPath() %>/JQMHistory/kindeditor/jsp/file_manager_json.jsp',
	    		afterUpload : function(){this.sync();},
	    		afterBlur : function(){this.sync();},
    		});
  		});
	</script>
</head>
<body style="overflow: hidden;">
	<div id="dataform1" style="table-layout: fixed">
		<table style="width:100%;table-layout:fixed;" class="nui-form-table" >
			<colgroup>
				<col width="15%"></col>
				<col width="35%"></col>
				<col width="15%"></col>
				<col width="35%"></col>
			</colgroup>
			<tr>
				<td class="form_label" align="right">主题:</td>
				<td colspan="3"><input id="vc_suggestion_titil"
					class="nui-textbox" style="width: 96%;border:0px;"
					name="vcSuggestionTitil" required="true"/></td>
			</tr>
			<tr>
				<td class="form_label" align="right">问题类别:</td>
				<td ><input id="vc_suggestion_type"
					class="nui-dictcombobox" dictTypeId="ATS_ADVICE_TYPE" style="width: 90%;"
					name="vcSuggestionType" required="true"/></td>
					
				<td class="form_label" align="right">邮箱:</td>
				<td >
					<input id="vc_user_mail" class="nui-textbox" style="width: 90%;" name="vcUserMail" required="true" vtype="email;rangeLength:5,20;"/>
				</td>
			</tr>
			<tr>
				<td class="form_label" align="right">手机:</td>
				<td><input id="l_user_phone"
					class="nui-textbox" style="width: 90%;"
					name="lUserPhone" onvaluechanged="checkFieldValue"/></td>
				<td class="form_label" align="right">座机:</td>
				<td><input id="vc_user_tel"
					class="nui-textbox" style="width: 90%;"
					name="vcUserTel" onvaluechanged="checkFieldValue"/></td>

			</tr>

			<tr>
				<td class="form_label td" align="right">邮件内容:</td>
				<td colspan="3">
					<textarea id="vcSuggestionContent" name="vcSuggestionContent" style="width:96%;height:250px;"></textarea>
				</td>
			</tr>			
		    <tr>
			    <td class="form_label td" align="right" width="15%">
	                        附件上传:
				</td>
				<td colspan="3" class="td">
					<iframe id="prodIfm" style="width: 96%;height: 110px;" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"></iframe>
				</td>
			</tr>
		</table> 
		
	</div>
	<div class="nui-toolbar" style="padding: 0px;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align: center;" colspan="4">
				<a class='nui-button' plain='false' iconCls="icon-save" onclick="getContent()">保存 </a> 
  				<a class='nui-button' plain='false' iconCls="icon-reload" onclick="setContent()">清除文本</a>
			 	<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">取消 </a>
				</td>
			</tr>
		</table>
	</div>
<script>
   nui.parse();
   var form = new nui.Form("#dataform1");
   var data2 = form.getData();
   var ids = "";
   	//附件上传相关信息加载
   	$("#prodIfm").attr("src","<%=request.getContextPath() %>/commonUtil/suggestion/sf_upload.jsp?bizId=1&attachType=9&attachBusType=9&lAttachId=99");
   	
   	
   	
   	//提供给附件上传调用
	function refreshFile(){}
	
	//获取附件ID
	function getFileId(ids,vcAttachName){
		data2["lAttachId"] = ids;
		data2["vcAttachName"] = vcAttachName;
	}
	var msg;
	function getContent() {
		//获取富文本的值
	  	editor.sync();
	    var vcSuggestionContent = $('#vcSuggestionContent').val();
	    var data = form.getData();
	    data["lAttachId"] = data2["lAttachId"];
	    data["vcAttachName"] = data2["vcAttachName"];
	    data["vcSuggestionContent"] = vcSuggestionContent;

            
    	if(data["vcSuggestionType"]==null || data["vcSuggestionType"]==""){
    		nui.alert("问题类型不能为空！", "提示");
	        return;
    	}
		if(data["vcUserMail"]==null || data["vcUserMail"]==""){
			nui.alert("操作人邮件地址不能为空！", "提示");
	        return;
    	}
		if(data["vcSuggestionTitil"]==null || data["vcSuggestionTitil"]==""){
			nui.alert("主题不能为空！", "提示");
	        return;
    	}
    	//校验手机号与座机号格式是否正确
    	if(checkFieldValue() == false) return;
    	
		var a = nui.loading("正在提交中,请稍等...","提示");
		nui.ajax({
			url : "com.cjhxfund.commonUtil.suggestion.insertSuggestion.insertSuggestion.biz.ext",
			type : 'POST',
			data : {dataSug:data},
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				nui.hideMessageBox(a);
				var returnJson = nui.decode(text);
				if(returnJson.returnCode == "yes" && returnJson.rtnCode == "0"){
					nui.alert("保存成功", "系统提示", function(action) {
						if (action == "ok" || action == "close") {
							onCancel();
						}
					});
				}else{
					if(returnJson.returnCode == "no" && returnJson.rtnCode == "1"){
						nui.alert("邮件发送失败.","系统提示");
						return;
					}else{
						nui.alert("系统异常","系统提示");
					}
				}
			}
		});
	  }

	//清除文本
	function setContent() {
		editor.html('');
		reset();
	}
		
	function reset(){
	  	var form = new nui.Form("#dataform1");
			form.reset();
	}
	//取消
	function onCancel() {
		window.CloseOwnerWindow("cancel");
	}
	
	function checkFieldValue(){
		var l_user_phone = nui.get("l_user_phone").getValue();
		var reg = /^1[3|4|5|7|8][0-9]{9}$/; //验证规则
		//校验手机号码是否正确
		if(l_user_phone != ""){
			if(reg.test(l_user_phone) == false){
				nui.alert("手机号码填写有误，请重填");  
        		return false; 
			}
		}
		
		//获取座机号码
		var vc_user_tel = nui.get("vc_user_tel").getValue();
		var reg1 = /^0\d{2,3}-\d{7,8}$/;
		//判断是否为空值
		if(vc_user_tel != ""){
			//校验座机号码是否正确
			if(reg1.test(vc_user_tel) == false){
				nui.alert("座机号码填写有误，请重填");  
        		return false; 
			}
		}
		
		return true;
	}
</script>
</body>
</html>
