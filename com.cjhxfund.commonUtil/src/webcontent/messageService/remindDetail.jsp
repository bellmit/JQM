<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 陈迪
  - Date: 2017-03-22 15:15:50
  - Description:
-->

<head>
	<style type="text/css">
		body {  
				font-size:14px;
				font-family:"Microsoft YaHei",微软雅黑;
		    color: #080808;  
		    background:#FBFBEA;  
		}
	</style>
	<title>提醒详情</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	
</head>
<body>
	<div style="width:100%;">
		<br>
		<p id="vcContent"></p>
	</div>
		<div align="center" style="width:100%; ">
			<input id="lRemindId" name="lRemindId" class="nui-hidden"/>
			<a style="font-size:14px; margin-top:180px;" class='nui-button' plain='false' iconCls="icon-ok" onclick="markAsRead()">我知道了</a>
		</div>
	<script type="text/javascript">
			nui.parse();
			//获取主页面传参，赋到对应字段
			function SetData(data) {
				//跨页面传递的数据对象，克隆后才可以安全使用
			  	data = nui.clone(data);
			  	$("p[id='vcContent']").html("&#8195;&#8195;&#8195;&#8195;"+data.vcContent);
			  	nui.get("lRemindId").setValue(data.lRemindId);
			}
			//关闭按钮，将未读置为已读
			function markAsRead(){
				var remindId = nui.get("lRemindId").getValue();
				var param = {lRemindId:remindId};
				nui.ajax({
					url:"com.cjhxfund.commonUtil.MessageService.markAsRead.biz.ext",
					type:'POST',
					data:{remind:param},
					contentType:'text/json',
					success:function(text){
						var returnJson = nui.decode(text);
						if(returnJson.rtnCode == 1){
							window.CloseOwnerWindow();
						}
					}
				});
			}
	</script>
</body>
</html>