<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 杨敏
  - Date: 2016-12-02 11:31:08
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<iframe id="prodIfm" name="prodIfm" width="590"  height="130px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" ></iframe>
<!-- 单个文件上传示例代码  -->
<script type="text/javascript">
	nui.parse();
	//必须具备如下变量提供给上传页面调用
	var UpSuccessBizParm=new Array();//params中按顺序给 逻辑流参数赋值.所以 Fdata 参数必须在回调逻辑流的第一位，其他参数必须按照数组顺序赋值，否则会出现赋值混乱，可为空
	UpSuccessBizParm[0]='01';
	UpSuccessBizParm[1]='zs';
	var func="test";//上传成功后回调的函数名称，不可和回调逻辑流名同时为空
	var UpSuccessBiz="com.cjhxfund.ats.fm.comm.common.fileDome";//上传回调逻辑流全名称 逻辑流名称+逻辑构建全称，不可和回调函数名同时为空
	
	//文件上长传界面回调的函数
	//e FdataUrl，FdataName
	function test(e){
		//console.log("回调函数~");
		//console.log(e);
	}
	$("#prodIfm").attr("src","<%=request.getContextPath() %>/fm/comm/fileupload/singleFileUpload.jsp");
	
</script>
</body>
</html>