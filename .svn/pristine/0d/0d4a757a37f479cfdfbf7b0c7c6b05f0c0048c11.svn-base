<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.foundation.eoscommon.LogUtil"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
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
<%
	IMUODataContext muoContext = DataContextManager.current().getMUODataContext();
	IUserObject userObject = muoContext.getUserObject();
	String userId = "";
	String userName = "";
	if (userObject != null) {
		userId = (String)userObject.getAttributes().get("EXTEND_USER_ID");
		userName = (String)userObject.getUserName();
	}
	String isEdit = request.getParameter("isEdit");
 %>
<script type="text/javascript">
    var contextPath = "<%=request.getContextPath()%>";
    var userId = "<%=userId%>";
    var userName = "<%=userName%>";
</script>

<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/button.css" type="text/css" />
<script type="text/javascript" src="js/swfupload.js"></script>
<script type="text/javascript" src="js/any_upload.js"></script>
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
	String bizId = request.getParameter("bizId");
	if(StringUtils.isBlank(bizId)){
		bizId = "";
	}
	String attachBusType = request.getParameter("attachBusType");
	if(StringUtils.isBlank(attachBusType)){
		attachBusType = "";
	}
	String attachType = request.getParameter("attachType");
	if(StringUtils.isBlank(attachType)){
		attachType = "";
	}
    String type = request.getParameter("type");
	if(StringUtils.isBlank(type)){
		type = "";
	}
    String lStockInvestNo = request.getParameter("lStockInvestNo");
	if(StringUtils.isBlank(lStockInvestNo)){
		lStockInvestNo = "";
	}
	String workItemID = request.getParameter("workItemID");        //工作项ID
	if(StringUtils.isBlank(workItemID)){
		workItemID = "";
	}
	String processinstid = request.getParameter("processinstid");  //流程ID
	if(StringUtils.isBlank(processinstid)){
		processinstid = "";
	}
	
	
 %>
<body>
    <!-- 查询附件列表 参数-->
	<div id="form1" class="nui-form" align="center" style="width: 100%; height: 100%;">
		<input class="nui-hidden" name="map/attachBusType" id="attachBusType" value="<%=attachBusType %>" />
		<input class="nui-hidden" name="map/attachType" id="attachType" value="<%=attachType %>" />
		<input class="nui-hidden" name="map/lStockInvestNo" id="lStockInvestNo" value="<%=lStockInvestNo %>" />
		<input class="nui-hidden" name="map/bizId" id="bizId" value="<%=bizId %>" />
		<input class="nui-hidden" name="map/workItemID" id="workItemID" value="<%=workItemID %>" />
		<input class="nui-hidden" name="map/processinstid" id="processinstid" value="<%=processinstid %>" />
		
	</div>
	
	<form id="file_download" method="post">
            <input class="nui-hidden" name="sysid" id="sysid" />
    </form>
	
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
	
	<div style="width: 100%;">
	<div style="width: 100%;display:inline" id="tableHead" foren>
		<span id="spanButtonPlaceholder"></span>
		<a class='nui-button' plain='true' id="deleteFile" iconCls="icon-remove" onclick="deletefiles()">删除</a>
	</div>
	<div style="width: 100%;display:inline">
		<a class='nui-button' plain='true' id="fileDownload" iconCls="icon-download" 
		onclick="fileDownLoad(0,'all',0)">下载</a>
	</div>
	</div>
	
<div id=upload>
	<div id="datagridupload" dataField="attachments" class="nui-datagrid"
			style="width: 100%; display: block;border: 1px solid red;"
			url="com.cjhxfund.ats.fm.baseinfo.attachInfoManager.queryAttachInfos.biz.ext"
			idField="id" allowResize="false" showPager="false" multiSelect="true"
			sizeList="[20,30,50,100]"  allowSortColumn="false">
			<div property="columns">
				<div type="indexcolumn"></div>
				<div type="checkcolumn"></div>
				<div field="sysid" width="10" headerAlign="center" allowSort="true" visible=false>ID</div>
				<div field="name" width="160" headerAlign="center" allowSort="true" renderer="changeName">文件名</div>
				<div field="attachSize" name='attachSize' width="50" headerAlign="center" allowSort="true">文件大小</div>
				<div field="dCreateTime" name='dCreateTime' width="90" headerAlign="center" align="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss">上传时间</div>
				<div field="vcUserName" name='vcUserName' width="50" headerAlign="center" align="center" allowSort="true">上传者</div>
			</div>
		</div>
</div>	
</body>

<form action="" name="newShowForm" method="post" target="_blank">
</form>

<script type="text/javascript">
	nui.parse();
	var attachType='<%=attachType %>';
    var attachBusType='<%=attachBusType %>';
    var bizId='<%=bizId %>';
    var lStockInvestNo = '<%=lStockInvestNo %>';
    var type = '<%=type %>';
    var workItemID = '<%=workItemID %>';
    var processinstid = '<%=processinstid %>';
    
	var grid = nui.get("datagridupload");
	
	var isEdit = '<%=isEdit %>';
	if(isEdit=='n'){//已办的时候表头不用显示
		document .getElementById("tableHead").style.display = "none";
	}
	function Init() {
		var formData = new nui.Form("#form1").getData(false,false);
		grid.load(formData);
		grid.on("drawcell", function (e) {
			var record = e.record,
				column = e.column;
			if (column.name == "attachSize") {
				var attachSize=record.attachSize/1024/1024;
				if(attachSize<1){
		 			attachSize=record.attachSize/1024;
		 		    e.cellHtml =attachSize.toFixed(2)+"KB";
		 		}else{
		 		    e.cellHtml =attachSize.toFixed(2)+"MB";
		 		} 	
	 		}
		});	
	}
	
	setTimeout("Init()",100);//页面加载防止并发问题
	
	
     
	grid.on("update", function() {	
		setFileHeight();
		if(window.parent.refreshFile){	//调整父页面高度
	        window.parent.refreshFile();
	    }
	});
	 
	
	var swfu;
	window.onload = function() {
	    //组装路径
	    var url = "upload.jsp?attachType="+attachType
	    			+"&attachBusType="+attachBusType
	    			+"&bizId="+bizId
	    			+"&lStockInvestNo="+lStockInvestNo
	    			+"&type="+type
	    			+"&workItemID="+workItemID
	    			+"&processinstid="+processinstid;
	    
		swfu = new SWFUpload({
			upload_url : url,//表单提交的路径
			post_params : {
				"test" : "test"
			},
			// File Upload Settings
			file_size_limit : "50 MB", // 上传文件最大容量
			file_types : "*.*",//文件类型限制
			file_types_description : "所有文件",
			file_upload_limit : "0",//限定用户一次性最多上传多少个文件，在上传过程中，该数字会累加，如果设置为“0”，则表示没有限制
			file_queue_error_handler : fileQueueError,
			file_dialog_complete_handler : fileDialogCompleted,//选择好文件后提交
			file_queued_handler : fileQueued,
			upload_progress_handler : uploadProgress,
			upload_error_handler : uploadError,
			upload_success_handler : newUploadSuccess,
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
			custom_settings : {//自定义设置
				upload_target : "divFileProgressContainer",
				swf_id: 'swfu_0'//swf实例id 
			},
			debug : false	//是否显示调试窗口
		});
	};
	
	var msgid;
	function fileDialogCompleted(numFilesSelected, numFilesQueued) {
		//如果上传文件数据等于队列文件数量，才自动上传
		//队列数量小说明上传文件中有文件出错，或超出限制，则不自动上传
		if(numFilesSelected!=0 && numFilesSelected==numFilesQueued){
		   if(isFileName==false){
	          this.cancelUpload();
	       }else{
			 	msgid = commonLoading("正在上传......","上传");
				this.startUpload();
			}
		}else if(numFilesSelected>numFilesQueued){
			for(var i=0;i<numFilesQueued;i++){
				this.cancelUpload();
			}
		}
	}
	
	function commonLoading(msg,title){
		return nui.loading(msg,title);
	}
	
	function commonHideMessageBox(messageid){
    	nui.hideMessageBox(messageid);
	}
	
	//需要将附件的Id返回回去
	function newUploadSuccess(file, serverData) {
		try {
			if(msgid!=null&&msgid!=""){
				commonHideMessageBox(msgid);
			}
			var fileid = trim(serverData.toString());
			if (file.size === undefined) {
				window.parent.nui.alert("附件名："+"“"+fileName+"”"+"的内容为空，不能上传!","系统提示");
				return;
			}
			if(fileid.length> 1000){
				window.parent.nui.alert("浏览器异常，无法上传文件，请更换浏览器！","系统提示");
				return;
			}
			//swfu.setFileUploadLimit(1);//设置只能上载一个文件
			addReadyFileInfo(fileid, file.name, "成功加载到上传队列", "", file.size);
			if(window.parent.initAttachId){
				window.parent.initAttachId(attachBusType,serverData);
			}
			addFileInfo(file.id, "文件上传完成");
		} catch (ex) {
			this.debug(ex);
		}
	}
	
	
	//获取所有文件ID
	function getFileIds(){
		var ids = "";
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
	
	//获得选中行的ID
	function getSelectFileIds(){
		var ids = "";
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
	
	
	function checkDeleteFiles(){
		var rows = grid.getSelecteds();
		for(var i=0; i<rows.length; i++){
			if(userId != rows[i].vcUserId){
				return false;
			}
		}
		return true;
	}
	
	//删除
	function deletefiles(){
		if(!checkDeleteFiles()){
			window.parent.nui.alert("不能删除其他人上传的附件！", "系统提示");
			return;
		}
		var ids = getSelectFileIds();
    	if(ids == ""){
	     	window.parent.nui.alert("请选择需要删除的附件！", "系统提示");
	     	return;
	    }
	    
		var json = nui.encode({fileIds: ids});
		$.ajax({
            url:'com.cjhxfund.ats.fm.baseinfo.attachInfoManager.deleteAttachInfos.biz.ext',
            type:'POST',
            data:json,
            cache:false,
            contentType:'text/json',
            success:function(data){
				var returnJson = nui.decode(data);
				if(returnJson.returnValue == "ok"){
					removeRows();
	                nui.showTips({content: "<b>成功</b> <br/>删除成功", state: "danger", x: "center", y: "top", timeout: 3000 });
				}else{
              		nui.showTips({content: "<b>失败</b> <br/>删除失败", state: "danger", x: "center", y: "top", timeout: 3000 });
	             }
        	 }
         });
	}
	   
	function setFileHeight(){
		//var data = grid.getData();
		//if(data.length<1){//没有数据时，不显示标题
		//	grid.hide();
		//}else{
		//	grid.show();
		//}
	} 
	
	function setGridHeight(){
		grid.setHeight(28 + 23*grid.getData().length);
	}
	
	//附件名称
	function changeName(e){
		var name = '<a href="javascript: fileDownLoad('+e.row.sysid+', \''+e.row.vcAttachType+'\', \''+e.row.vcAttachAdd+'\')">'+e.row.name+'</a>';
		return name;
	}
	
	//附件下载
	function fileDownLoad(sysid, vcAttachType, vcAttachAdd){
		console.log(vcAttachType);
		console.log(vcAttachAdd);
		if(vcAttachType == '3'){
			urlDown(vcAttachAdd);
		}
		if(vcAttachType == 'all'){
			var ids = getSelectFileIds();
			if(ids!=null && ids!=""){
				nui.get("sysid").setValue(ids);
				var form = document.getElementById("file_download");
            	form.action = "com.cjhxfund.ats.fm.baseinfo.FileDownLoad.flow";
            	form.submit();
            }
            else{
            	window.parent.nui.alert("未勾选，无法下载！","系统提示");
            }
		}
		else{						
			nui.get("sysid").setValue(sysid);
			var form = document.getElementById("file_download");
            form.action = "com.cjhxfund.ats.fm.baseinfo.FileDownLoad.flow";
            form.submit();
		}
	}
	
	function urlDown(add){
		window.open(add); 
	}
	
	grid.on("rowdblclick", function (e) {
			var type = 0;
	    	var record = e.record;
	    	var actionURL = '<%=request.getContextPath() %>' 
	    	+ "/fm/baseinfo/fileuploadComm/documentShow.jsp?sysid="
	    	+record.sysid+"&fileName="+record.name+"&type="+type; //目标页面
	    	var winFrm=document.newShowForm;
	    	winFrm.action=actionURL;
			winFrm.target = 'newWindow';
			winFrm.submit();
	    	
		});	
	
	function downloadOnly(){
		console.log("dfsf");
		//$("#spanButtonPlaceholder").hide();
		//$("#deleteFile").hide();
		document.getElementById("deleteFile").style.display = "none";
	}
	
</script>
</html>