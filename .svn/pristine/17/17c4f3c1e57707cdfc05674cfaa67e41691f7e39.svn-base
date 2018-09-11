<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-10-31 17:24:50
  - Description:
-->
<head>
<title>设置产品管理类型</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body style="margin:0px 0px 0px 0px">
	<div style="width:100%; height:339px;">
		<form id="sealInfoForm">
			<table border="0" cellpadding="1" cellspacing="2" style="border-collapse:separate;border-spacing:10px;">
			    <tr>
			        <td >传递形式：</td>
			        <td >
						<input id="lProductId" class="nui-hidden" name="lProductId">
			        	<input id="cInstructionTransferModus" name="cInstructionTransferModus" repeatItems="1" repeatLayout="table" repeatDirection="vertical"
						class="nui-radiobuttonlist" data="[{id:'0',text:'QQ'},{id:'1',text:'微信'},{id:'2',text:'邮件'},{id:'3',text:'传真'},{id:'4',text:'短信'}]" value="0"/>
			        </td>
			    </tr>
			    <tr>
			        <td >授权人签字：</td>
			        <td >
			        	<input class="nui-textarea" id="vcAuthorizedSignature" vtype="maxLength:85" width="350" height="60" name="vcAuthorizedSignature"/>
			        </td>
			    </tr>
			    <tr>
			        <td >预留印鉴上传：</td>
					<td colspan="3" style="border:0">
						<iframe id="vcPrintAttachId" style="width:350px;height:200px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" ></iframe>
					</td>
			    </tr>
			    
			</table>
		</form>
	</div>
	<div class="nui-toolbar" style="padding-top:5px;padding-bottom:5px; text-align: center;border:0">
		<a class='nui-button' plain='true' iconCls="icon-ok" onclick="updateSealInfo()">确定</a>
		<span style="display:inline-block;width:25px;"></span>
		<a class='nui-button' plain='true' iconCls="icon-cancel" onclick="closeWindow()">关闭</a>
	</div>
	
	

	<script type="text/javascript">
    	nui.parse();
    	// 指令信息
    	var row = "";
    	
    	function setData(data){
    		row = data;
    		nui.get("cInstructionTransferModus").setValue(row.cInstructionTransferModus);
    		nui.get("vcAuthorizedSignature").setValue(row.vcAuthorizedSignature);
    		var lProductId = row.lProductId;
    		nui.get("lProductId").setValue(lProductId);
    		var lAttachId = row.vcPrintAttachId;
    		var lProductCode = row.vcProductCode;
    		$("#vcPrintAttachId").attr("src","<%=request.getContextPath() %>/fm/comm/fileupload/productInfo_upload.jsp?lAttachId="+lAttachId+"&lProductId="+lProductId+"&lProductCode="+lProductCode);
    	}
    	
    	var returnJson=null;
    	function getData(){
    		return returnJson;
    	}
    	
    	// 设置产品管理类型
		function updateSealInfo(){
			var cInstructionTransferModus = nui.get("cInstructionTransferModus").getValue();
			var vcAuthorizedSignature = nui.get("vcAuthorizedSignature").getValue();
			var lProductId = nui.get("lProductId").getValue();
			var a = nui.loading("正在处理中,请稍等...","提示");
			nui.ajax({
				url:"com.cjhxfund.ats.fm.baseinfo.ProductManager.updateProductSealInfo.biz.ext",
				type:'POST',
				data: {cInstructionTransferModus:cInstructionTransferModus,vcAuthorizedSignature:vcAuthorizedSignature,lProductId:lProductId},
				cache: false,
				contentType:'text/json',
				success:function(text){
					nui.hideMessageBox(a);
					returnJson = nui.decode(text);
					window.closeWindow("ok");
				}
	    	});
	    }
		  
		function closeWindow(e) {
	       if (window.CloseOwnerWindow)
	          return window.CloseOwnerWindow(e);
	       else window.close();
		} 	
		
		//提供给附件上传调用
		function refreshFile(){} 	
    </script>
</body>
</html>