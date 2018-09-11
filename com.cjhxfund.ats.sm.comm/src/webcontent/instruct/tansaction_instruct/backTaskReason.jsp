<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-08-10 09:32:53
  - Description:
-->
<head>
<title>退回原因</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	<form id="reasonForm">
		<table border="0" cellpadding="1" cellspacing="2" style="border-collapse:separate;border-spacing:10px;">
		    <tr>
		        <td >退回原因：</td>
		        <td >
		        	<input class="nui-textarea" id="checkComments" vtype="maxLength:85" width="400" height="100" name="checkComments" required="true"/>
		        </td>
		    </tr>
		    <tr>
		        <td ></td>
		        <td style="text-align: center">
        			<a class='nui-button' plain='true' iconCls="icon-ok" onclick="backTasks()">确定</a>
        			<span style="display:inline-block;width:25px;"></span>
        			<a class='nui-button' plain='true' iconCls="icon-cancel" onclick="closeWindow()">关闭</a>
		        </td>
		    </tr>
		</table>
	</form>
	

	<script type="text/javascript">
    	nui.parse();
    	// 指令信息
    	var row = "";
    	var reasonForm = new nui.Form("#reasonForm");
    	
    	function setData(data){
    		row = data;
    	}
    	
    	var returnJson=null;
    	function getData(){
    		return returnJson;
    	}
    	
    	// 退回操作
		function backTasks(){
			reasonForm.validate();
            if (reasonForm.isValid() == false) return;
			var checkComments = nui.get("#checkComments").getValue();
		   	// 新二级债退回
			var a = nui.loading("正在处理中,请稍等...","提示");
			var json={checkResult:0,checkComments:checkComments,workItemID:row.workitemid};		//checkResult审批结果1通过，0不通过
			nui.ajax({
				url:"com.cjhxfund.ats.sm.comm.TaskManager.approveAvailValidate.biz.ext",
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