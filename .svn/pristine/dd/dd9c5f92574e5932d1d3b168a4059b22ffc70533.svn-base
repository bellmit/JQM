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
<link href="<%=request.getContextPath() %>/fm/comm/fileupload/css/default.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/fm/comm/fileupload/css/button.css" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/fm/comm/fileupload/js/swfupload.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/fm/comm/fileupload/js/any_upload.js"></script>

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
   String bizId = request.getParameter("bizId");                  //业务ID
   String attachType =  "4";									  
   String attachBusType = request.getParameter("attachBusType");
   String pageType = request.getParameter("pageType");  //页面类型  
   String processId = request.getParameter("processId");  //投票主键ID
   int processStatus = Integer.valueOf(request.getParameter("processStatus"));   //指令/建议状态
 %>
<body>
	<div id="form1" class="nui-form" align="center" style="width: 100%; height: 100%;">
		<input class="nui-hidden" name="map/bizId" id="bizId" value="<%=bizId %>" />
		<input class="nui-hidden" name="map/attachType" id="attachType" value="<%=attachType %>" />
		<input class="nui-hidden" name="map/attachBusType" id="attachBusType" value="<%=attachBusType %>" />
		<% if(!processId.equals("null")){ %>
			<input class="nui-hidden" name="map/processinstid" id="processinstid" value="<%=processId %>"/>
		<%} %>
	</div>
	
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
	<input class="nui-hidden" id="uploadFiles" value="<%=request.getContextPath()+"/files"%>"/>
	<div style="width: 100%;" foren>
		<% if(!pageType.equals("confirm")){ %>
			<% if(pageType.equals("query")){ %>
				<% if(processStatus < 2){ %>
					<span id="spanButtonPlaceholder"></span>&nbsp;
				<% } %>
					<a class='nui-button' plain='true' iconCls="icon-download" onclick="fileDownload()" style="margin-top: 0px;padding-top:0px;">下载</a>&nbsp;
				<% if(processStatus < 2){ %>
					<a class='nui-button' plain='true' iconCls="icon-remove" onclick="deletefiles()" style="margin-top: 0px;">删除</a>
				<% } %>
			<% }else{ %>
					<span id="spanButtonPlaceholder"></span>&nbsp;
					<a class='nui-button' plain='true' iconCls="icon-download" onclick="fileDownload()" style="margin-top: 0px;padding-top:0px;">下载</a>&nbsp;
					<a class='nui-button' plain='true' iconCls="icon-remove" onclick="deletefiles()" style="margin-top: 0px;">删除</a>
			<% } %>
		<%}else{ %>
			<a class='nui-button' plain='true' iconCls="icon-download" onclick="fileDownload()" >下载</a>&nbsp;
		<%} %>
		<font style="color: red;">*</font>最大上传50M文件
	</div>
	<div id="datagridupload" dataField="attachments" class="nui-datagrid"
		style="width: 100%;  display: block;border: 1px solid red;"
		url="com.cjhxfund.commonUtil.attachUitlFunction.queryAttachmentList.biz.ext"
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
	
	<!-- 文档下载  -->
	<form id="file_download" method="post">
	<!-- 数据实体的名称 -->
		<input class="nui-hidden" name="lAttachIds"  id="lAttachIds"/>
		<input class="nui-hidden" name="bizId" value="<%=bizId %>" />
	</form>	
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
	    var bizId = '<%=bizId %>';
	    //组装路径
	    
	    var url = "<%=request.getContextPath() %>/ProductProcess/JY_QTZL/upload.jsp?attachType="+attachType+"&attachBusType="+attachBusType+"&processinstid=<%=processId %>";
	    if(bizId != "null"){
	    	url = url + "&bizId=" + bizId;
	    }
	    try{
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
		}catch(err){
    	  
       }
	};
	
	function fileDownload(){
		var grid = nui.get("datagridupload");
		var rows = grid.getSelecteds();
		var lAttachIds = "";
		
		//判断是否选择了附件
		if(rows.length == 0){
			nui.alert("请先选择附件在下载","系统提示");
			return ;
		}
		
		for(var i =0;i<rows.length;i++){
			if(lAttachIds == ""){
				lAttachIds = rows[i].lAttachId;
			}else{
				lAttachIds = lAttachIds + "," + rows[i].lAttachId;
			}
		}
		
		nui.get("lAttachIds").setValue(lAttachIds);
		
		nui.confirm("确认要下载吗？","系统提示",function(action){
			if(action=="ok"){
				//nui.get("fileDownload").disable();//禁用“导出”按钮
				var form = document.getElementById("file_download");
				form.action = "com.cjhxfund.jy.ProductProcess.fileDownloadQTZL.flow";
		        form.submit();
		        //setTimeout("enableExportFun1()",15000);//启用“导出”按钮
			}
		});
	}

	//删除
	function deletefiles(){
		var grid = nui.get("datagridupload");
		var rows = grid.getSelecteds();
    	if (rows.length == 0) {
    		nui.alert("请选择需要删除的附件！", "系统提示");
	     	return;
    	}else{
			var json = nui.encode({attachinfos: rows});
			$.ajax({
	            url:'com.cjhxfund.commonUtil.attachUitlFunction.deleteAttachment.biz.ext',
	            type:'POST',
	            data:json,
	            cache:false,
	            contentType:'text/json',
	            success:function(data){
	             	 var returnJson = nui.decode(data);
		             if(returnJson.returnValue == "yes"){
		               nui.alert("附件删除成功！","系统提示",function(action){
		                   removeRow();
		                   //window.parent.loademployeeGrid();
		               });
		             }else{
		               nui.alert("附件删除失败！","系统提示",function(action){});
		             }
	        	 }
	         });
       	 } 
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