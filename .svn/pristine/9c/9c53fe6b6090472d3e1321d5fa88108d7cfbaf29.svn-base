<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 童伟
  - Date: 2017-11-20 14:17:22
  - Description:
-->
<head>
<title>设置产品归属公司</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin:0px 0px 0px 0px">
	<div style="width:100%; height:120px;">
		<form id="productBelongCompanyForm">
			<table border="0" cellpadding="1" cellspacing="2" style="border-collapse:separate;border-spacing:10px;">
			    <tr>
			        <td >产品归属公司：</td>
			        <td >
			        	<input class="nui-dictcombobox" name="productInfo/vcCorporBelongTo" valueField="dictID" textField="dictName" dictTypeId="corporBelongTo"  
								id="vcCorporBelongTo" style="width:95%" oncloseclick="onCloseClickValueEmpty" showClose="true"/>
			        </td>
			    </tr>
			</table>
		</form>
	</div>
	<div class="nui-toolbar" style="padding-top:5px;padding-bottom:5px; text-align: center;border:0">
		<a class='nui-button' plain='true' iconCls="icon-ok" onclick="updateCorporBelongTo()">确定</a>
		<span style="display:inline-block;width:25px;"></span>
		<a class='nui-button' plain='true' iconCls="icon-cancel" onclick="closeWindow()">关闭</a>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	// 指令信息
    	var rows = "";
    	var productBelongCompanyForm = new nui.Form("#productBelongCompanyForm");
    	
    	function setData(data){
    		rows = data;
    		if(rows.length == 1){
	    		if(rows[0].vcCorporBelongTo != "" && rows[0].vcCorporBelongTo != null){
	    			nui.get("vcCorporBelongTo").setValue(rows[0].vcCorporBelongTo);
	    		}
    		}else{
	    		nui.get("vcCorporBelongTo").setValue("");
    		}
    	}
    	
    	var returnJson=null;
    	function getData(){
    		return returnJson;
    	}
    	
    	// 设置产品归属公司
		function updateCorporBelongTo(){
			var vcCorporBelongTo = nui.get("#vcCorporBelongTo").getValue();
			
			var a = nui.loading("正在处理中,请稍等...","提示");
			var json={paramData:rows,vcCorporBelongTo:vcCorporBelongTo};		
			nui.ajax({
				url:"com.cjhxfund.ats.fm.baseinfo.ProductManager.updateProductBelongCompany.biz.ext",
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
		
		//清空多选下拉框值
	    function onCloseClickValueEmpty(e){
	    	var obj = e.sender;
		    obj.setText("");
		    obj.setValue("");
	    }	
    </script>
</body>
</html>