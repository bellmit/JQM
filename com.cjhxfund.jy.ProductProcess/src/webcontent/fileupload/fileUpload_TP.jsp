<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="java.util.Map"%>
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
<link href="<%=request.getContextPath() %>/process/fileupload/css/default.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/process/fileupload/css/button.css" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/process/fileupload/js/swfupload.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/process/fileupload/js/any_upload.js"></script>

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
   String attachType =  "2";									  //附件类型 1-流程附件 2-投票附件
   String attachBusType = request.getParameter("attachBusType");
   String pageType = request.getParameter("pageType");  //页面类型  
   String processId = request.getParameter("processId");  //投票主键ID
   
	HttpSession sessions = request.getSession();
	
	UserObject user = (UserObject)sessions.getAttribute("userObject");
	Map<String, Object> attr = user.getAttributes();
	String roleCode = "";
	if(attr.get("roleCodeList")!=null){
		roleCode = attr.get("roleCodeList").toString();
	}
 %>
<body>
	<div id="form1" class="nui-form" align="center" style="width: 100%; height: 100%;">
		<input class="nui-hidden" name="map/bizId" id="bizId" value="<%=bizId %>" />
		<input class="nui-hidden" name="map/attachType" id="attachType" value="<%=attachType %>" />
		<input class="nui-hidden" name="map/attachBusType" id="attachBusType" value="<%=attachBusType %>" />
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
		<% if(pageType.equals("confirm") || (roleCode != null && roleCode.indexOf("ATS_JS_TGWTRTZJY") != -1)){ %><!-- 如果是投顾或者委托人开放上传按钮 -->
		<span id="spanButtonPlaceholder"></span>&nbsp;
		<a class='nui-button' plain='true' id="fileDownload" iconCls="icon-download" onclick="fileDownload()">下载</a>&nbsp;
		<a class='nui-button' plain='true' iconCls="icon-remove" onclick="deletefiles()">删除</a>
		<font style="color: red;">*</font>最大上传50M文件，如募集说明书、信用评级报告、申购申请表等
		<%}else{ %>
		<a class='nui-button' plain='true' id="fileDownload"  iconCls="icon-download" onclick="fileDownload()">下载</a>
		<%} %>	
	</div>
	<div id="datagridupload" 
		dataField="attachInfos" 
		class="nui-datagrid"
		style="width: 100%; display: block;border: 1px solid red;"
		url="com.cjhxfund.jy.ProductProcess.FileUploadUtil.queryAttachmentListTP.biz.ext"
		idField="id" 
		allowResize="true" 
		showPager="false" 
		multiSelect="true"
		sizeList="[20,30,50,100]" 
		pageSize="10" 
		allowSortColumn="false">
		<div property="columns">
			<div type="indexcolumn"></div>
			<div type="checkcolumn"></div>
			<div field="sysid" width="120" headerAlign="center" allowSort="true" visible="false">ID</div>
			<div field="name" width="160" headerAlign="center" allowSort="true">文件名</div>
			<div field="attachSize" name='attachSize' width="160" headerAlign="center" allowSort="true">文件大小</div>
		</div>
	</div>
	
	<!-- 文档下载  -->
	<form id="file_download" method="post">
	<!-- 数据实体的名称 -->
		<input class="nui-hidden" name="sysid"  id="sysid"/>
		<input class="nui-hidden" name="bizId"  id="bizId" value="<%=bizId %>" />
		<input class="nui-hidden" name="processId" value="<%=processId %>" />
	</form>	
</body>
<script type="text/javascript">
	nui.parse();
	
	var grid = nui.get("datagridupload");
	$(function() {
		var formData = new nui.Form("#form1").getData(false,false);
		grid.load(formData);
		grid.on("drawcell", function (e) {
		 	 var record = e.record,
		 	     column = e.column;
		     if (column.name == "attachSize") {
				//e.cellStyle = "text-align:left";
				var attachSize=record.attachSize/1024/1024;
				if(attachSize<1){
					attachSize=record.attachSize/1024;
					e.cellHtml =attachSize.toFixed(2)+"KB";
				}else{
					e.cellHtml =attachSize.toFixed(2)+"MB";
				} 	
			}
 		});	
	});
     
	grid.on("update", function() {	
		setFileHeight();
	});
	
	var swfu;
	window.onload = function() {
		var attachType='<%=attachType %>';
	    var attachBusType='<%=attachBusType %>';
	    var pageType='<%=pageType %>';
	    var roleCode='<%=roleCode %>';
	    //组装路径
	    var url = "<%=request.getContextPath() %>/process/fileupload/upload.jsp?attachType="+attachType+"&attachBusType="+attachBusType+"&bizId=<%=bizId %>";
		if(pageType == "confirm" || (roleCode != null && roleCode.indexOf("ATS_JS_TGWTRTZJY") != -1)){
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
				button_image_url: '<%=request.getContextPath() %>/process/fileupload/image/button.png',
	
				// Flash Settings
				flash_url : "<%=request.getContextPath() %>/process/fileupload/js/swfupload.swf",
	
				custom_settings : {
					upload_target : "divFileProgressContainer",
					swf_id: 'swfu_0',//swf实例id 
				},
				
				
				// Debug Settings
				debug : false
				//是否显示调试窗口
			});
		}else{
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

				// Flash Settings
				flash_url : "<%=request.getContextPath() %>/process/fileupload/js/swfupload.swf",
				custom_settings : {
					upload_target : "divFileProgressContainer",
					swf_id: 'swfu_0',//swf实例id 
				},
				// Debug Settings
				debug : false
			//是否显示调试窗口
			});
		}	
	};
	
	//获取所有文件ID
	function getFileIds(){
		var ids = "";
		var grid = nui.get("datagridupload");
		var data = grid.getData();	
		for (var i = 0; i < data.length; i++) {
			var obj=data[i];
			ids += obj.sysid;
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
    			ids += row.sysid;
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
    			ids += row.sysid;
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
            url:'com.cjhxfund.jy.process.attachUitlFunction.delAttachment.biz.ext',
            type:'POST',
            data:json,
            cache:false,
            contentType:'text/json',
            success:function(data){
             	 var returnJson = nui.decode(data);
	             if(returnJson.returnValue == "ok"){
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
	   
	function setFileHeight(){
		var grid = nui.get("datagridupload");
		var data = grid.getData();
		if(data.length<1){//没有数据时，不显示标题
			grid.hide();
		}else{
			grid.show();
		}
	}
	
	//批量下载附件
    function fileDownload(){
    	var datas = nui.get("datagridupload").getSelecteds();
    	var sysId = "";
    	for(var i = 0;i < datas.length;i++){
    		if(sysId == ""){
    			sysId = datas[i].sysid;
    		}else{
    			sysId = sysId + "," +datas[i].sysid;
    		}
			nui.get("sysid").setValue(sysId);	
		}
		
    	if(sysId == ""){
    		nui.alert("请选择要下载的附件","系统提示");
    		return;
    	}
    	
    	nui.confirm("确认要下载吗？","系统提示",function(action){
			if(action=="ok"){
				//nui.get("fileDownload").disable();//禁用“导出”按钮
				var form = document.getElementById("file_download");
				form.action = "com.cjhxfund.jy.ProductProcess.fileDownloadTP.flow";
		        form.submit();
		        //setTimeout("enableExportFun1()",15000);//启用“导出”按钮
			}
		});
    } 
</script>
</html>