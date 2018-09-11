<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" session="false" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): zengjing
  - Date: 2017-08-02 10:49:02
  - Description:
-->
<head>
<title>processDemo</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
</head>
<body>
	<a class="nui-button" onclick="startProcessDemo()">创建测试流程</a>

	<script type="text/javascript">
    	nui.parse();
    	function startProcessDemo(){
    		nui.ajax({
	 			type:"post",
	 			url: "com.cjhxfund.fpm.bpsExpend.processDemo.startProcessDemo.biz.ext",
	 			cache:false,
	 			async:false,
	 			contentType:'text/json',
	 			success:function(text){
	 				nui.alert("发起成功");
 				}
    		})
    	}
    </script>
</body>
</html>