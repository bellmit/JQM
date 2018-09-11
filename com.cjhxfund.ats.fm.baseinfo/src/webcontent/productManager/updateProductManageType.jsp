<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 童伟
  - Date: 2017-10-31 17:24:50
  - Description:
-->
<head>
<title>设置产品管理类型</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin:0px 0px 0px 0px">
	<div style="width:100%; height:127px;">
		<form id="manageTypeForm">
			<table border="0" cellpadding="1" cellspacing="2" style="border-collapse:separate;border-spacing:10px;">
			    <tr>
			        <td >产品管理类型：</td>
			        <td >
			        	<input id="manageType" name="cManageType" repeatItems="1" repeatLayout="table" repeatDirection="vertical"
						class="nui-radiobuttonlist" data="[{id:'0',text:'主动管理'},{id:'1',text:'纸质指令'},{id:'2',text:'电子指令'}]"/>
			        </td>
			    </tr>
			    
			    <tr style="padding-top:20px">
			        <td ></td>
			        <td >
	        			
			        </td>
			    </tr>
			</table>
		</form>
	</div>
	<div class="nui-toolbar" style="padding-top:5px;padding-bottom:5px; text-align: center;border:0">
		<a class='nui-button' plain='true' iconCls="icon-ok" onclick="updateManageTypeForm()">确定</a>
		<span style="display:inline-block;width:25px;"></span>
		<a class='nui-button' plain='true' iconCls="icon-cancel" onclick="closeWindow()">关闭</a>
	</div>
	
	<script type="text/javascript">
    	nui.parse();
    	// 指令信息
    	var rows = "";
    	var manageTypeForm = new nui.Form("#manageTypeForm");
    	
    	function setData(data){
    		rows = data;
    		if(rows.length == 1){
	    		if(rows[0].cManageType != "" && rows[0].cManageType != null){
    				nui.get("manageType").setValue(rows[0].cManageType);
	    		}
    		}else {
    			nui.get("manageType").setValue("");
    		}
    	}
    	
    	var returnJson=null;
    	function getData(){
    		return returnJson;
    	}
    	
    	// 设置产品管理类型
		function updateManageTypeForm(){
			var manageType = nui.get("#manageType").getValue();
			if(manageType == "" || manageType == null){
				nui.alert("你还未选择产品管理类型","提示");
				return;
			}	
			var a = nui.loading("正在处理中,请稍等...","提示");
			var json={paramData:rows,manageType:manageType};		
			nui.ajax({
				url:"com.cjhxfund.ats.fm.baseinfo.ProductManager.updateProductManageType.biz.ext",
				type:'POST',
				data: json,
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
    </script>
</body>
</html>