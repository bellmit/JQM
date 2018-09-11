<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<html>
<!-- 
  - Author(s): 童伟
  - Date: 2017-11-01 15:47:21
  - Description:
-->
<head>
<title>Title</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

<script type="text/javascript">
    	var contextPath="<%=request.getContextPath()%>";
    	var msgid;
</script>

<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/button.css" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/fm/comm/fileupload/js/swfupload.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/fm/comm/fileupload/js/productInfo_any_upload.js"></script>

<style type="text/css">
.progressbar {
	position: relative;
	background: #bbb;
	width: 100%;
	height: 16px;
	overflow: hidden;
}

.progressbar-percent {
	position: absolute;
	height: 18px;
	background: blue;
	left: 0;
	top: 0px;
	overflow: hidden;
	z-index: 1;
}

.progressbar-label {
	position: absolute;
	left: 0;
	top: 0;
	width: 100%;
	font-size: 13px;
	color: White;
	z-index: 10;
	text-align: center;
	height: 16px;
	line-height: 16px;
}
</style>
</head>
<%
   String type = request.getParameter("type");
   String lAttachId = request.getParameter("lAttachId");
   HttpSession ss = request.getSession();
   UserObject user = (UserObject)ss.getAttribute("userObject");
   String usreId = user.getUserId();
   String lProductId = request.getParameter("lProductId");
   String lProductCode = request.getParameter("lProductCode");
 %>
<body>
	<div id="form1" class="nui-form" align="center" style="width: 100%; height: 100%;">
		<input class="nui-hidden" name="map/attachType" id="attachType" value="2" />
		<input class="nui-hidden" name="map/attachBusType" id="attachBusType" value="12" />
		<input class="nui-hidden" name="map/lProductId" id="lProductId" value="<%=lProductId %>" />
	</div>
	<input class="nui-hidden" id="uploadFiles" value="<%=request.getContextPath()+"/files"%>"/>
	
	<div style="display: none;">
		<div id="content">
			<div id="divFileProgressContainer"></div>
		</div>
		<div id="thumbnails" style="display: none;">
			<table id="infoTable" border="0" width="350"
				style="display: inline; border: solid 1px #7FAAFF; background-color: #C5D9FF; padding: 2px; margin-top: 8px;">
			</table>
		</div>
	</div>
	<div style="width:350px;" foren>
		<span id="spanButtonPlaceholder"></span>
		<a class='nui-button' plain='true' iconCls="icon-remove" onclick="deletefiles()">删除</a>
		<font style="color: red;">*</font>只能上传*.jpg;*.png图片格式文件
	</div>
	<div id="datagridupload" dataField="attachments" class="nui-datagrid"
		style="width:350px; height:150px; display: block;border: 1px solid red;"
		url="com.cjhxfund.ats.fm.comm.attachUitlFunction.getAttachmentInfo.biz.ext"
		idField="id" allowResize="true" showPager="false" multiSelect="true"
		 pageSize="50" allowSortColumn="false">
		<div property="columns">
			<div type="indexcolumn"></div>
			<div type="checkcolumn"></div>
			<div field="lAttachId" width="120" headerAlign="center" allowSort="true" visible="false">ID</div>
			<div field="vcAttachName" width="160" headerAlign="center" allowSort="true">文件名</div>
			<div field="vcAttachSize" name='vcAttachSize' width="100" headerAlign="center" allowSort="true">文件大小</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	nui.parse();
	
	var grid = nui.get("datagridupload");
	var dataCount = 0;
	
	function inIt() {
		var formData = new nui.Form("#form1").getData(false,false);
		grid.load(formData);
		grid.on("drawcell", function (e) {
		 	 var record = e.record,
		 	     column = e.column;
		     if (column.name == "vcAttachSize") {
		 		//e.cellStyle = "text-align:left";
		 		var vcAttachSize = record.vcAttachSize/1024/1024;
		 	      if(vcAttachSize < 1){
		 		    vcAttachSize = record.vcAttachSize/1024;
		 		    e.cellHtml = vcAttachSize.toFixed(2)+"KB";
		 		}else{
		 		     e.cellHtml = vcAttachSize.toFixed(2)+"MB";
		 		} 	
 			}
 		});	
	}
     
	grid.on("update", function() {	
		setFileHeight();
	});
	 
	
	var swfu;
	window.onload = function() {
		inIt();	
		if(dataCount>0){
			nui.alert("请删除已有印鉴信息后，重新上传","提示");
			return;
		}
	    var attachType = "2";	// 产品信息附件
	    var attachBusType = "12";	// 产品信息附件
	    var bizId = "";
	    var lProductId = <%=lProductId %>;
	    //组装路径
	    var url = "<%=request.getContextPath() %>/fm/baseinfo/productManager/upload.jsp?attachType="+attachType+"&attachBusType="+attachBusType+"&bizId="+bizId+"&lProductId="+lProductId+"&lProductCode=<%=lProductCode%>&usreId=<%=usreId %>";
		swfu = new SWFUpload({
			upload_url : url,//表单提交的路径
			post_params : {
				"test" : "test"
			},
			// File Upload Settings
			file_size_limit : "20 MB", // 上传文件最大容量
			file_types : "*.jpg;*.png",//文件类型限制
			file_types_description : "图片",
			file_upload_limit : "0",
			file_queue_limit : "0",
			file_queue_error_handler : fileQueueError,
			file_dialog_complete_handler : fileDialogComplete,//选择好文件后提交
			file_queued_handler : fileQueued,
			upload_progress_handler : uploadProgress,
			upload_error_handler : uploadError,
			upload_success_handler : uploadSuccess,
			upload_complete_handler : uploadComplete,

			// Button Settings
			button_placeholder_id : "spanButtonPlaceholder",
			button_width : 55,
			button_height : 23,
			button_text : '增加',
			//button_text_style: '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12px; line-height:26px;color:#ffffff; }',
			button_text_left_padding : 23,
			button_text_top_padding : 0,
			button_window_mode : SWFUpload.WINDOW_MODE.TRANSPARENT,
			button_cursor : SWFUpload.CURSOR.HAND,
			button_image_url: 'image/button.png',

			// Flash Settings
			flash_url : "js/swfupload.swf",

			custom_settings : {
				upload_target : "divFileProgressContainer",
				swf_id: 'swfu_0',//swf实例id 
			},
			
			// Debug Settings
			debug : false
		//是否显示调试窗口
		});	
	};
	
	//获取所有文件ID
	function getFileIds(){
		var ids = "";
		var grid = nui.get("datagridupload");
		var data = grid.getData();	
		for (var i = 0; i < data.length; i++) {
			var obj=data[i];
			ids += obj.lAttachId;
			if(i<data.length - 1){
				ids += ",";
			} 		
		}
    	return ids;
	}
	
	function getFileId(){
	  var ids = "";
		var grid = nui.get("datagridupload");
		var rows = grid.getSelecteds();
	
    	if (rows.length > 0) {
    		for (var i = 0; i < rows.length; i++) {
    			var row=rows[i];
    			ids += row.lAttachId;
    			if(i<rows.length - 1){
    				ids += ",";
    			} 		
    		}
    	}
    	return ids;
	}  
	
	<%--//自动上传
	function fileDialogComplete(){
			this.startUpload();
	}--%>
	
	//删除
	function deletefiles(){
		var ids = "";
		var grid = nui.get("datagridupload");
		var rows = grid.getSelecteds();
    	if (rows.length > 0) {
    		for (var i = 0; i < rows.length; i++) {
    			var row=rows[i];
    			ids += row.lAttachId;
    			if(i<rows.length - 1){
    				ids += ",";
    			} 		
    		}
    	}
    	if (ids == ""){
	     	nui.alert("请选择需要删除的附件！", "系统提示");
	     	return;
	    }
	    
		var json = nui.encode({fileIds: ids});
		$.ajax({
            url:'com.cjhxfund.ats.fm.comm.attachUitlFunction.delAttachment.biz.ext',
            type:'POST',
            data:json,
            cache:false,
            contentType:'text/json',
            success:function(data){
             	var returnJson = nui.decode(data);
	     		if(returnJson.returnValue == "ok"){
	            	nui.alert("附件删除成功！","系统提示",function(action){
						var stats = swfu.getStats();  
						stats.successful_uploads = 0;  
						swfu.setStats(stats);  
		            	removeRow(); 
		                window.parent.refreshFile();
		                //window.parent.loademployeeGrid();
	            	});
	            }else{
	               nui.alert("附件删除失败！","系统提示",function(action){});
	            }
        	 }
         });
	  }
	   
	  function setFileHeight(){
		var grid = nui.get("datagridupload");
		var data = grid.getData();
		if(data.length<1){//没有数据时，不显示标题
			grid.hide();
			//nui.get("delBtn").hide();
		}else{
			grid.show();
			dataCount += 1;
			//grid.setHeight(getFileGridSize(data.length));
			//nui.get("delBtn").show();
		}
		//调用父页面方法，修改iframe高度
		/* alert(window.parent.setFileFrmHeight);
		if(window.parent.setFileFrmHeight!=null){
			window.parent.setFileFrmHeight(data.length);
		} */
	}
</script>
</html>