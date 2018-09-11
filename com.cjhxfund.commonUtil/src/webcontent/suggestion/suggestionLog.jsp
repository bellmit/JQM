<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>
<html>
<!-- 
  - Author(s): 何祎
  - Date: 2017-04-11 09:33:35
  - Description:
-->
<head>
	<title>意见/建议交流信息</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script charset="utf-8" src="<%= request.getContextPath() %>/JQMHistory/kindeditor/kindeditor-min.js"></script>
	<script charset="utf-8" src="<%= request.getContextPath() %>/JQMHistory/kindeditor/lang/zh_CN.js"></script>
	<script>
  		KindEditor.ready(function(K) {
   			window.editor = K.create('#vcCommunicationContent', { 
   				allowImageUpload:true,//允许上传图片
        		allowFileManager:true, //允许对上传图片进行管理
        		urlType:'domain',
        		allowImageRemote: false,
	    		uploadJson : '<%=request.getContextPath() %>/JQMHistory/kindeditor/jsp/upload_json.jsp',
	    		fileManagerJson : '<%=request.getContextPath() %>/JQMHistory/kindeditor/jsp/file_manager_json.jsp',
	    		afterUpload : function(){this.sync();},
	    		afterBlur : function(){this.sync();},
    		});
  		});
	</script>	
	<style type="text/css">
		.form_label {
			font-weight:bold;
		}
	</style>
</head>
<%
   String lSuggestionId = request.getParameter("lSuggestionId");
%>
<body style="width: 100%;height: 100%;overflow-X: hidden; ">
<div id="dataform1" style="padding-top: 5px; table-layout: fixed;">
	<table style="width:100%;table-layout:fixed;" class="nui-form-table" border="0">
		<colgroup>
			<col width="15%"></col>
			<col width="35%"></col>
			<col width="15%"></col>
			<col width="35%"></col>
		</colgroup>
		<tr>
			<td class="form_label" align="right">标题:</td>
			<td colspan="3"><div id="vcSuggestionTitil" style="width: 96%;"></div></td>
		</tr>
		<tr>
			<td class="form_label" align="right">问题类别:</td>
			<td><div id="vcSuggestionType" style="width: 90%;"></div></td>
			<td class="form_label" align="right">邮箱:</td>
			<td><div id="vcUserMail"style="width: 90%;"></div></td>
		</tr>
		<tr>
			<td class="form_label" align="right">手机:</td>
			<td><div id="lUserPhone"style="width: 90%;"></div></td>
			<td class="form_label" align="right">座机:</td>
			<td><div id="vcUserTel"style="width: 90%;"></div></td>
		</tr>
		<tr>
			<td class="form_label" align="right">邮件内容:</td>
			<td colspan="3">
				<div style="margin-left:20px;width: 96%;" id="vcSuggestionContentList"></div>
			</td>
		</tr>
		<tr>
			<td class="form_label" align="right" style="border-bottom: 1px solid #D3D3D3;">附件信息</td>
			<td colspan="3" style="border-bottom: 1px solid #D3D3D3;">
				<iframe id="prodIfm1" name="prodIfm1" width="96%"  height="80px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" ></iframe>	
			</td>
		</tr>
	</table>
			<div style='font-weight: bold;border-bottom: 1px solid #D3D3D3;'>消息记录</div>
			<ol id="vcCommunicationContentList" style="width: 100%;">
			</ol>
	</div>
	<table style="width:100%;table-layout:fixed;" border="0" class="nui-form-table" >
		<colgroup>
			<col width="15%"></col>
			<col width="85%"></col>
		</colgroup>
		<tr>
			<td class="form_label" align="right">
				邮件内容:
			</td>
			<td>
				<textarea id="vcCommunicationContent" name="vcCommunicationContent" style="width: 96%;height:200px;"></textarea>
			</td>
		</tr>
	</table>
	<div class="nui-toolbar" style="padding: 0px;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align: center;" colspan="4">
				<a class='nui-button' plain='false' iconCls="icon-save" onclick="getContent()">
					提交</a>
  				<a class='nui-button' plain='false' iconCls="icon-reload" onclick="setContent()">
					 清除文本</a>
			 	<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
					取消 </a>
				</td>
			</tr>
		</table>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	
    	//意见建议id
    	var lSuggestionId = "<%=lSuggestionId %>";
    	var context = '<%=request.getContextPath() %>';
    	var vcUserMail = "";
    	var vcSuggestionTitil = "";
    	//获取意见建议相关信息
    	function search(){
	    	nui.ajax({
				url : "com.cjhxfund.commonUtil.suggestion.insertSuggestion.querySuggestionById.biz.ext",
				type : 'POST',
				data : {lSuggestionId:lSuggestionId},
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if(returnJson.exception == null){
					
						//获取意见建议信息,给指定字段赋值
						$("#vcSuggestionType").text(renderSuggestionType(returnJson.tAtsSuggestion[0].vcSuggestionType));
						$("#vcUserMail").text(returnJson.tAtsSuggestion[0].vcUserMail);
						$("#lUserPhone").text(returnJson.tAtsSuggestion[0].lUserPhone);
						$("#vcUserTel").text(returnJson.tAtsSuggestion[0].vcUserTel);
						$("#vcSuggestionTitil").text(returnJson.tAtsSuggestion[0].vcSuggestionTitil);
						//转换HTML格式
						$("#vcSuggestionContentList").html(returnJson.tAtsSuggestion[0].vcSuggestionContent);
						
						//获取沟通交流信息
						var temp = "";
						for(var i=0;i< returnJson.vcCommunication.length;i++){
							temp = "<li style='border-bottom: 1px solid #D3D3D3;width:100%;'><label style='margin-left: 10px;'>操作时间:" + returnJson.vcCommunication[i].tCommunicationDate +"&nbsp;&nbsp;操作人:"+
							returnJson.vcCommunication[i].vcCommunicationUsername +"<br/>&nbsp;&nbsp;内容:"+
						 	returnJson.vcCommunication[i].vcCommunicationContent+"</li></label>" + temp;
						}
						$("#vcCommunicationContentList").html(temp);
						var lAttachId = returnJson.tAtsSuggestion[0].lAttachId;
						vcUserMail = returnJson.tAtsSuggestion[0].vcUserMail;
						vcSuggestionTitil = returnJson.tAtsSuggestion[0].vcSuggestionTitil;
						showFile(lAttachId);
					}else{
						nui.alert("系统异常","系统提示");
					}
				}
			});
		}
		
		//问题类型
		function renderSuggestionType(vcSuggestionType){
			return nui.getDictText("ATS_ADVICE_TYPE",vcSuggestionType);
		} 
		
		//保存沟通交流信息
		function getContent() {
	  		//获取富文本的值
	  		editor.sync();
	    	var vcCommunicationContent = $('#vcCommunicationContent').val();
	    	var a = nui.loading("正在提交中,请稍等...","提示");
			nui.ajax({
				url : "com.cjhxfund.commonUtil.suggestion.insertSuggestion.insertVcCommunicationContent.biz.ext",
				type : 'POST',
				data : {vcCommunicationContent:vcCommunicationContent,lSuggestionId:lSuggestionId,vcUserMail:vcUserMail,vcSuggestionTitil:vcSuggestionTitil},
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					nui.hideMessageBox(a);
					var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						nui.alert("保存成功", "系统提示", function(action) {
							if (action == "ok" || action == "close") {
								search();
								//清空富文本编辑框内的内容
								editor.html('');
							}
						});
					}else{
						nui.alert("系统异常","系统提示");
					}
				}
			});
	  	}
	  
	    function showFile(lAttachId){
			document.getElementById("prodIfm1").src = context+"/commonUtil/suggestion/sf_upload.jsp?bizId=1&attachType=9&attachBusType=9&type=1&lAttachId="+lAttachId;
		}
	  
	  	//获取附件ID
		function getFileId(ids){}
	  	search();
	
		//取消
    	function onCancel() {
    		CloseWindow("cancel");
    	}
    
    	//关闭窗口
		function CloseWindow(action) {
			if (action == "close" && form.isChanged()) {
				if (confirm("数据被修改了，是否先保存？")) {
					getContent();
				}
			}
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else window.close();
		}  
    </script>
</body>
</html>