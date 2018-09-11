<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp"%>
<!-- 
  - Author(s): 创金合信
  - Date: 2016-09-08 09:30:49
  - Description:
-->
<head>
<title>解锁申请</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
	<form id="applyForm">
		<table border="0" cellpadding="1" cellspacing="2" style="border-collapse:separate;border-spacing:10px;">
		    <tr>
		        <td >解锁数量：</td>
		        <td >
		            <input class="nui-textbox" id="lLockQty" name="lLockQty" vtype="float" required="true"/>
		        </td>
		        <td class="td2" id="operableUnLockQty"></td>
		    </tr>
		    <tr>
		        <td >解锁原因：</td>
		        <td >
		            <input class="nui-textbox" id="vcUnlockReason" name="vcUnlockReason" required="true"/>
		            <input type="hidden" id="lLockId" name="lLockId"/>
					<input type="hidden" id="oldlLockQty" name="oldLockQty"/>
		        </td>
		    </tr>
		    <tr>
		        <td ></td>
		        <td >
		            <input class='nui-button' plain='false' text="确定" onclick="apply()"/>
		             <input class='nui-button' plain='false' onclick="onCancel" text="取消">
		        </td>
		    </tr>
		</table>
	</form>
	<script type="text/javascript">
    	nui.parse();
    	var searchGrid = undefined;
        function SetData(data,todo) {
         searchGrid = todo;
			if (data) {
				//跨页面传递的数据对象，克隆后才可以安全使用
				var applyData = mini.clone(data);
				$("#lLockId").val(applyData.lLockId);
				$("#oldlLockQty").val(applyData.lLockQty);
				$("#operableUnLockQty").html("可解锁数量："+format(applyData.operableUnLockQty));
			}
		}
		//提交审批
		function apply(){
			var data = (new nui.Form("applyForm")).getData();
			var form = new mini.Form("#applyForm");
			form.setChanged(false);
			//保存
			form.validate();
			if (form.isValid() == false)
			return;
			data["lLockId"] = document.getElementById("lLockId").value;
			// 申请解锁的数量
			var applyLockQty = data.lLockQty;
			var re = /^[1-9]\d*$/;;
			if (!re.test(applyLockQty)) {
				nui.alert("请输入大于0的正整数！");
				return;
			}
			var a = nui.loading("正在处理中,请稍等...","提示");
		 	nui.ajax({
                url : "com.cjhxfund.ats.sm.comm.TBondLockInfoManager.applyUnlockBond.biz.ext",
                type : 'POST',
                data : {tAtsTbondLock:data},
                cache : false,
                contentType : 'text/json',
                success: function (text) {
                	nui.hideMessageBox(a);
               		var returnJson = nui.decode(text);
                	if(returnJson.exception == null){
						if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
							nui.alert(returnJson.rtnMsg, "系统提示", function(action){
								if(action == "ok" || action == "close"){
							    	searchGrid();
							        window.CloseOwnerWindow();
							    }
							});
						}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
							nui.alert(returnJson.rtnMsg, "系统提示", function(action){
								if(action == "ok" || action == "close"){
							    	searchGrid();
							        window.CloseOwnerWindow();
							    }
							});
						}else if(returnJson.rtnCode == "3"){
							nui.alert(returnJson.rtnMsg, "系统提示", function(action){
								if(action == "ok" || action == "close"){
							    	searchGrid();
							    	$("#operableUnLockQty").html(format(returnJson.lockQty));
							    }
							});
						}else{
							nui.alert("操作异常","系统提示");
						}
                    }
            	}
            }); 
		}
		
		function format(input) {
		    return (input+ '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
		}
		
		function onCancel(e) {
			window.CloseOwnerWindow();
		}
    </script>
</body>
</html>