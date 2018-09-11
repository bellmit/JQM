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
   String id = request.getParameter("id"); 
   String attachBusType = request.getParameter("attachBusType"); //
   String attachType = request.getParameter("attachType");    //附件类型 1-流程附件,2-新债录入附件
    String type = request.getParameter("type");    //查看详情   1
    String lStockInvestNo = request.getParameter("lStockInvestNo");
 %>
<body>
    <!-- 查询附件列表 参数-->
	<div id="form1" class="nui-form" align="center" style="width: 100%; height: 100%;">
		<input class="nui-hidden" name="map/attachBusType" id="attachBusType" value="<%=attachBusType %>" />
		<input class="nui-hidden" name="map/attachType" id="attachType" value="<%=attachType %>" />
		<% if(lStockInvestNo != null){ %>
				<input class="nui-hidden" name="map/lStockInvestNo" id="lStockInvestNo" value="<%=lStockInvestNo %>" />
		<%} %>
		<% if(id != null){ %>
				<input class="nui-hidden" name="map/bizId" id="bizId" value="<%=id %>" />
		<%} %>	
		
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
	<div style="width: 100%;" id="tableHead" foren>
		<span id="spanButtonPlaceholder"></span>
		<a class='nui-button' plain='true' iconCls="icon-remove" onclick="deletefiles()">删除</a>
		<font style="color: red;">*</font>最大上传50M文件，如募集说明书、信用评级报告、申购申请表等
	</div>
	<div id="down">
		<div id="datagridupload1" dataField="attachments" class="nui-datagrid"
			style="width: 100%; display: block;border: 1px solid red;"
			url="com.cjhxfund.ats.fm.baseinfo.attachInfoManager.queryAttachInfos.biz.ext"
			idField="id" allowResize="false" showPager="false" multiSelect="true"
			sizeList="[20,30,50,100]" allowSortColumn="false" onrowdblclick="fileDownload">
			<div property="columns">
				<div type="indexcolumn"></div>
				<div type="checkcolumn" visible=false></div>
				<div field="sysid" name="lAttachId" width="120" headerAlign="center" allowSort="true" visible=false>ID</div>
				<div field="name" name="vcAttachName" width="400" headerAlign="center" allowSort="true" reader="changeName">文件名</div>
				<div id="action" name="action" width="50" headerAlign="center" allowSort="true" >操作</div>
				<div field="attachSize" name="vcAttachSize" width="50" headerAlign="center" allowSort="true" visible=false>文件大小</div>
				<div field="vcAttachAdd" name="vcAttachAdd" width="50" headerAlign="center" allowSort="true" visible=false>文件地址</div>
				<div field="vcAttachType" name="vcAttachType" width="50" headerAlign="center" allowSort="true" visible=false>文件类型</div>
			</div>
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
				<div field="sysid" width="120" headerAlign="center" allowSort="true" visible=false>ID</div>
				<div field="name" width="200" headerAlign="center" allowSort="true" reader="changeName">文件名</div>
				<div field="attachSize" name='attachSize' width="50" headerAlign="center" allowSort="true">文件大小</div>
			</div>
		</div>
</div>	
</body>
<script type="text/javascript">
	nui.parse();
	var attachBusType = <%=attachBusType %>;
	var type = <%=type %>;
	var grid = nui.get("datagridupload");
	var grid1 = nui.get("datagridupload1");
	if(type==1){//查看详情的时候表头不用显示
		document .getElementById("tableHead").style.display = "none";
		var formData = new nui.Form("#form1").getData(false,false);
		grid1.load(formData);
		$("#upload").hide();
	 		grid1.on("drawcell", function (e) {
			column = e.column,
			row=e.row;
			//action列，超连接操作按钮
			if (column.name == "action") {
				e.cellStyle = "text-align:left";
				e.cellHtml = "<div headerAlign='center' align='center'><a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='fileDownload()'>下载</a></div>";
			}       
		});		
	}else {
		$("#down").hide();
	}
	function Init() {
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
	}
	setTimeout("Init()",3000);//页面加载防止并发问题
	
	
     
     grid.on("update", function() {	
		setFileHeight();
	});
	grid1.on("update", function() {	
		setFileHeight1();
	});
	 
	
	var swfu;
	window.onload = function() {
	    var attachType='<%=attachType %>';
	    var attachBusType='<%=attachBusType %>';
	    var id='<%=id %>';
	    //组装路径
	    var url = "upload.jsp?attachType="+attachType+"&attachBusType="+attachBusType+"&bizId="+id;

		swfu = new SWFUpload({
			upload_url : url,//表单提交的路径
			post_params : {
				"test" : "test"
			},
			// File Upload Settings
			file_size_limit : "50 MB", // 上传文件最大容量
			file_types : "*.*",//文件类型限制
			file_types_description : "所有文件",
			file_upload_limit :"0",//限定用户一次性最多上传多少个文件，在上传过程中，该数字会累加，如果设置为“0”，则表示没有限制
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

			custom_settings : {//自定义设置
				upload_target : "divFileProgressContainer",
				swf_id: 'swfu_0'//swf实例id 
			},
			
			
			// Debug Settings
			debug : false
		//是否显示调试窗口
		});
		
	};
	
	function urlDown(add){
		window.open(add); 
	}
	
	
		 //附件下载
    function fileDownload() {
            var datas = nui.get("datagridupload1").getSelected();          
            var sysId = "";
            //for (var i = 0; i < datas.length; i++) {
                if (sysId == "" && datas.vcAttachType=="2") {
                    sysId = datas.sysid;
                }else if(datas.vcAttachType=="3"){
                	urlDown(datas.vcAttachAdd);
                	return;
                	//window.open(datas[i].vcAttachAdd);
                }
            //}
            nui.get("sysid").setValue(sysId);
            if (datas != null && datas != "") {
                //给出提示并调用下载逻辑	
                //nui.confirm("确认要下载吗？", "系统提示",function(action) {
                    var form = document.getElementById("file_download");
                    var json1 = nui.encode({attachs:datas});
                    //if (action == "ok") {
                    	nui.ajax({
							url:"com.cjhxfund.ats.fm.baseinfo.AttachManager.attachManage.biz.ext",
							type:'POST',
							data:json1,
							cache:false,
							contentType:'text/json',		
							success:function(text){
			                    if(text.flag==false){
			                       nui.alert("下载失败，文件不存在！", "系统提示");
			                    }else{
			                        //请求下载页面流
                                    form.action = "com.cjhxfund.ats.fm.baseinfo.FileDownLoad.flow";
                                    form.submit();
                        		}
							}
					});	            
                    	
                  //  } 
        	//});
        	} else{
               nui.alert("请先选择附件!", "系统提示");
          }
   }	
   
	var msgid;
	function fileDialogCompleted(numFilesSelected, numFilesQueued) {
		//如果上传文件数据等于队列文件数量，才自动上传
		//队列数量小说明上传文件中有文件出错，或超出限制，则不自动上传
		var grid = nui.get("datagridupload");
		if(grid.getData().length!=0){
			this.cancelUpload();
			return;
		}
		if(numFilesSelected!=0 && numFilesSelected==numFilesQueued){
		 	msgid = commonLoading("正在上传......","上传");
			this.startUpload();

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
    			//删除文件时，也删除父页面的值
    			window.parent.deleteFileByUpload(attachBusType);
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
            url:'com.cjhxfund.ats.fm.baseinfo.attachInfoManager.deleteAttachInfos.biz.ext',
            type:'POST',
            data:json,
            cache:false,
            contentType:'text/json',
            success:function(data){
             	 var returnJson = nui.decode(data);
		         if(returnJson.returnValue == "ok"){
		         		//swfu.setFileUploadLimit(0);//设置只能上载一个文件
		         		removeRow();
		                nui.showTips({
					        content: "<b>成功</b> <br/>删除成功",
					        state: "danger",
					        x: "center",
					        y: "top",
					        timeout: 3000
					    });
					    document .getElementById("datagridupload").style.display = "none";
	             }else{
	              		nui.showTips({
					        content: "<b>失败</b> <br/>删除失败",
					        state: "danger",
					        x: "center",
					        y: "top",
					        timeout: 3000
					    });
					    document .getElementById("datagridupload").style.display = "block";
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
	function setFileHeight1(){
		var grid1 = nui.get("datagridupload1");
		var data = grid1.getData();
		if(data.length<1){//没有数据时，不显示标题
			grid1.hide();
		}else{
			grid1.show();

		}

	}
	
	function changeName(e){
	  var name = e.row.vcAttachName;
	  return name;
	}
	
</script>
</html>