<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<html>
<!-- 
  - Author(s): andy
  - Date: 2014-12-05 10:35:03
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
<script type="text/javascript" src="<%=request.getContextPath() %>/commonUtil/fileupload/js/swfupload.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/commonUtil/fileupload/js/any_upload.js"></script>

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
   String workItemID = request.getParameter("workItemID");        //工作项ID
   String bizId = request.getParameter("bizId");                  //业务ID
   String processinstid = request.getParameter("processinstid");  //流程ID 
   String attachType =  "1";									  //附件类型 1-流程附件
   //request.getParameter("attachType");        
   String attachBusType = request.getParameter("attachBusType");  
   String type = request.getParameter("type");
 %>
<body>
	<div id="form1" class="nui-form" align="center" style="width: 100%; height: 100%;">
		<input class="nui-hidden" name="map/bizId" id="bizId" value="<%=bizId %>" />
		<input class="nui-hidden" name="attachType" id="attachType" value="<%=attachType %>" />
		<input class="nui-hidden" name="map/attachBusType" id="attachBusType" value="<%=attachBusType %>" />
		<% if(type != null){ %>
		   <% if(workItemID != null){ %>
				<input class="nui-hidden" name="map/workItemID" id="workItemID" value="<%=workItemID %>" />
		   <%} %>	
			<input class="nui-hidden" name="map/processinstid" id="processinstid" value="<%=processinstid %>" />
	    <%} %>
	</div>
	
	
	<input class="nui-hidden" id="uploadFiles" value="<%=request.getContextPath()+"/files"%>"/>
	
	<div style="display: none;">
		<div id="content">
			<div id="divFileProgressContainer"></div>
		</div>
		<div id="thumbnails" style="display: none;">
			<table id="infoTable" border="0" width="530"
				style="display: inline; border: solid 1px #7FAAFF; background-color: #C5D9FF; padding: 2px; margin-top: 8px;">
			</table>
		</div>
	</div>
	<div style="width: 100%;" foren>
		<span id="spanButtonPlaceholder"></span>
		<a class='nui-button' plain='true' iconCls="icon-remove" onclick="deletefiles()">删除</a>
		<font style="color: red;">*</font>最大上传50M文件，如募集说明书、信用评级报告、申购申请表等
	</div>
	<div id="datagridupload" dataField="attachments" class="nui-datagrid"
		style="width: 100%;  display: block;border: 1px solid red;"
		url="com.cjhxfund.ats.fm.comm.attachUitlFunction.queryAttachmentList.biz.ext"
		idField="id" allowResize="true" showPager="false" multiSelect="true"
		sizeList="[20,30,50,100]" pageSize="10" allowSortColumn="false">
		<div property="columns">
			<div type="indexcolumn"></div>
			<div type="checkcolumn"></div>
			<div field="lAttachId" width="120" headerAlign="center" allowSort="true" visible="false">ID</div>
			<div field="vcAttachName" width="160" headerAlign="center" allowSort="true">文件名</div>
			<div field="vcAttachSize" name='vcAttachSize' width="160" headerAlign="center" allowSort="true">文件大小</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	nui.parse();
	
	var grid = nui.get("datagridupload");

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
	
	inIt();
	
     
     grid.on("update", function() {	
		setFileHeight();
	});
	 
	
	var swfu;
	window.onload = function() {
	    var attachType='<%=attachType %>';
	    var attachBusType='<%=attachBusType %>';
	    //组装路径
	    
	    var url = "<%=request.getContextPath() %>/commonUtil/fileupload/upload.jsp?attachType="+attachType+"&attachBusType="+attachBusType+"&bizId=<%=bizId %>";
	    
	    //当流程ID不等于空时追加流程ID参数
	    if('<%=processinstid %>' != "null"){    
	       url = url + "&processinstid=<%=processinstid %>";
	    }
	    //判断工作项ID不为空时追加工作项ID       
	    if('<%=workItemID %>' != "null"){
	       url = url + "&workItemID=<%=workItemID %>";
	    }

		swfu = new SWFUpload({
			upload_url : url,//表单提交的路径
			post_params : {
				"test" : "test"
			},
			// File Upload Settings
			file_size_limit : "50 MB", // 上传文件最大容量
			file_types : "*.*",//文件类型限制
			file_types_description : "所有文件",
			file_upload_limit : "0",
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
			button_image_url: '<%=request.getContextPath() %>/commonUtil/fileupload/image/button.png',

			// Flash Settings
			flash_url : "<%=request.getContextPath() %>/commonUtil/fileupload/js/swfupload.swf",

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