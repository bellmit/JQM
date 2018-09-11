<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" session="false" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 引入公共方法做页面提交后的跳转 -->
<%@include file="/bpsExpend/common/processCommon4Bus.jsp"%>
<!-- 
  - Author(s): zengjing
  - Date: 2017-08-02 10:49:02
  - Description:
-->
<head>
<title>processDemo</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <!--样式分离，只需要添加业务需要的样式 -->
</head>
<body>
    这是业务页面
    <!--表单分离  只需要添加业务相关表单-->
	<div id="dataform1">
		<a class="nui-button" onclick="processSubmit()">提交</a>			
	</div>
	<script type="text/javascript">
    	nui.parse();
    	
    	//加载form表单
		var form = new nui.Form("#dataform1"); 
		
		
		function processSubmit(){
			var parTabId = '<b:write property="parTabId"/>';
		    //流程数据获取和提交
			var processIfr = window.parent.getProcessTabIframe();
			
			//流程js验证
			if(processIfr.contentWindow.checkProcessForm()==false) return false;
			
			
			var processData = processIfr.contentWindow.getProcessFormData();
			var json = nui.encode({pmprcaprvinfo:processData.pmprcaprvinfo,
			 						workitem:processData.workitem,
			 						bpsParam:processData.bpsParam,
			 						fileIds:processData.fileIds});
			
			nui.ajax({
	 			type:"post",
	 			url: "com.cjhxfund.fpm.bpsExpend.demo.submitAll.biz.ext",
	 			data:json,
	 			cache:false,
	 			async:false,
	 			contentType:'text/json',
	 			success:function(text){
	 				//关闭tab页面或返回我的任务
					removeTabOrBackMyTasks("processNew",parTabId);
	 			}
		 	});
		}
		
		
    </script>
</body>
</html>