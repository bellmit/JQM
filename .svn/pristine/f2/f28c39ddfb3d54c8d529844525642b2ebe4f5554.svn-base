<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 杨敏
  - Date: 2016-11-14 14:12:07
  - Description:
-->
<head>
<title>单个文件上传</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/fm/comm/fileupload/js/swfupload.js"></script>

</head>
<body>
 <div style="width:100%;height:100%; "  borderStyle="border:solid 1px #aaa;">
	<div style="height:10px;">
	                 &nbsp;&nbsp;导入文件路径：
	     <input width="300px" id="fileupload1" class="mini-fileupload" name="Fdata"
		flashUrl="js/swfupload.swf" 
		uploadUrl="com.cjhxfund.ats.fm.comm.common.upFileUtil.biz.ext" onuploadsuccess="onUploadSuccess"
		onuploaderror="onUploadError" onfileselect="onFileSelect" />
		 <a class="mini-button" iconCls="icon-download" plain="false" onclick="download()">模板下载</a>
		 <a class='nui-button' plain='false' iconCls="icon-upload" plain="false" onclick="startUpload()">上传</a>
	</div>
 </div>	
	<!-- 方法使用：
		 1、可采用iframe内嵌方法使用，使用方式参考fileDoem.jsp
		 2、可采用直接嵌入本jsp的相关 html代码和js
		 
		 相关解释：
		1、com.cjhxfund.ats.fm.comm.common.upFileUtil.biz.ext 为通用上传逻辑流 相关参数请参考逻辑流注释
		2、关于文件上传相关参数获取，均采用回调的方式，
		方式1 通过回调js 函数方式，执行逻辑流成功后 自动调用本jsp的 onUploadSuccess()函数，
		方式2 通过逻辑流 回调 方式 需要传入回调的相关参数，回调逻辑流方法全称和相关需要带入的参数。
	 -->
	<script type="text/javascript">
    	nui.parse();
    	var func="";//上传成功后回调的函数名称，不可和UpSuccessBiz同时为空
    	//上传回调逻辑流全名称 逻辑流名称+逻辑构建全称，不可和 func 同时为空
    	var UpSuccessBiz="";
    	/*params为回调带入参数可以自动带入参数到回调逻辑流， params中按顺序给 逻辑流参数赋值.所以 Fdata 参数必须在回调逻辑流的第一位，
    	其他参数必须按照数组顺序赋值，否则会出现赋值混乱，可空
    	*/
    	var UpSuccessBizParm=new Array();
    	/*UpSuccessBizParm[0]='01';
    	UpSuccessBizParm[1]='zs';*/
    	var templetDownload="";//模板下载父页面提供方法，可空
    	var startUploadfunc="";//上传之前需要执行执行父界面的数据校验函数
	    
	    //获取父界面对文件上传的设置，如果是直接嵌入代码的方式，不需要下面操作，直接赋值
	    $(function (){
	    	UpSuccessBiz=window.parent.UpSuccessBiz;
	    	func=window.parent.func;//获取父界面的func
	    	var w=window.parent.UpSuccessBizParm;//获取父界面的UpSuccessBizParm
	    	for(var i=0;i<w.length;i++){
	    		UpSuccessBizParm[i]=w[i];
	    	}
	    	templetDownload=window.parent.templetDownload;//获取父界面的templetDownload
	    	startUploadfunc=window.parent.startUploadfunc;//获取父界面的startUploadfunc
	    });
	    
	    //文件选择后触发的方法
    	function onFileSelect(e) {
	       // nui.alert("选择文件");
	    }
	    
	    //上传成功后回调方法
	    function onUploadSuccess(e) {
	    	//回调子页面的方法，回传附件的url和名字
	    	//参数e:有两个值：附件的url和名字，FdataUrl，FdataName
	    	if(func!="" && func!=null){
	    		 if(e.serverData!=null){
	    		 	window.parent[func](nui.decode(e.serverData));
	    		 }
	    	}
	        
	    }
	    //上传错误
	    function onUploadError(e) {
	        nui.alert("上传失败，请联系管理员.");
	    }
	    
		//点击上传
	    function startUpload() {
	    	if(startUploadfunc!="" && startUploadfunc!=null){
	    		//调用父界面校验函数验证
	    		if(!window.parent[startUploadfunc](nui.get("fileupload1"))){
	    			return;
	    		}
	    	}
	        var fileupload = nui.get("fileupload1");
			fileupload.setPostParam({UpSuccessBiz:UpSuccessBiz,UpSuccessBizParm:UpSuccessBizParm});
	        fileupload.startUpload();
	        
	    }
	    //模板下载的方法
	    function download(){
	    	if(templetDownload!="" || templetDownload!=null){
	    		window.parent[templetDownload]();
	    	}
	    	 
	    }
	    //清空
	    function clearFileupload(){
	    	nui.get("fileupload1").setText("");
	    }
    </script>
</body>
</html>