	/**
	 * 单个上传附件通用id变量
	 */
	var valueHiddenId = "valueHidden";
	var swfHiddenId = "swfHidden";
	var fileSelectSpanId = "fileSelectSpan";
	var buttonPlaceholderSpanId = "buttonPlaceholderSpan";
	var fileDownloadSpanId = "fileDownloadSpan";
	var fileDeleteSpanId = "fileDeleteSpan";
	var returnFunction = "uploadSuccess";
	var mutilSpanButtonPlaceholderSpanId = "mutilSpanButtonPlaceholder";
	
	
	/**
	 * 初始化附件控件
	 * @param tdObj 用于放置附件相关的HTML待td对象
	 * @param fileGoupId 用于区分页面唯一一组附件组件id
	 * @param fileId 文件待实际id
	 */
	function initSingleFile(tdObj,fileGoupId,fileId){
		initFileTd(tdObj,fileGoupId);
    	initSingleSWFUpload(fileGoupId);
    	if(fileId!=null&&fileId!=""){
    		checkout(fileId,fileGoupId);
    	}
	}
	
	/*
	 * 初始化文件对应的html
	 */
	function initFileTd(tdObj,idStr){
		tdObj.innerHTML =  getSingleFileHtml(idStr);
	}
	
	/*
	 * 单文件只可下载
	 */
	function showSingleFile(tdObj,fileGoupId,fileId){
		tdObj.innerHTML =  getDownloadSingleFileHtml(fileGoupId);
		displaySingleFile(fileId,fileGoupId);
	}
	
	/**
	 * 初始化附件上传控件
	 * @param idStr
	 */	
	function initSingleSWFUpload(idStr) {
			var url = contextPath+"/util/fileupload/uploadSingleFile.jsp?attachType=0&attachBusType=0&idStr="+idStr;
			var buttonPlaceholderId = buttonPlaceholderSpanId+idStr;
			var swf = new SWFUpload({
			upload_url : url,//表单提交的路径
			post_params : {
			},
			// File Upload Settings
			file_size_limit : "50 MB", // 上传文件最大容量
			file_types : "*.*",//文件类型限制
			file_types_description : "所有文件",
			file_upload_limit : 0,
	        file_queue_limit : 1,
			file_dialog_complete_handler : fileDialogComplete,//选择好文件后提交
			upload_success_handler : singleUploadSuccess,

			// Button Settings
			button_placeholder_id : buttonPlaceholderId,
			button_width : 30,
			button_height : 23,
			button_text_top_padding : 0,
			button_text_left_padding : 0,
			button_window_mode : SWFUpload.WINDOW_MODE.TRANSPARENT,
			button_cursor : SWFUpload.CURSOR.HAND,
			button_image_url: contextPath+'/util/fileupload/image/singleAdd.png',
			// Flash Settings
			flash_url :  contextPath+"/util/fileupload/js/swfupload.swf",

			custom_settings : {
			},
			// Debug Settings
			debug : false
			//是否显示调试窗口
			});
			
			//绑定删除的方法
			$("#"+fileDeleteSpanId+idStr).bind("click",function(){
				var fileId = $("#"+valueHiddenId+idStr).val();
				var swFileId = $("#"+swfHiddenId+idStr).val();
				document.getElementById(fileDownloadSpanId+idStr).style.display="none";
				document.getElementById(fileSelectSpanId+idStr).style.display="block";
				document.getElementById(fileDeleteSpanId+idStr).style.display="none";
				deleteAttachment(fileId);
				swf.cancelUpload(swFileId,false);
			});
	};
	
	//上传成功后，回调函数   
	function singleUploadSuccess(file, serverData) {
		var swfId = file.id;
		var returnStr = trim(serverData.toString());
		var returnArr = returnStr.split(",");
		var fileId = parseInt(returnArr[0]);
		var idStr = returnArr[1];
		$("#"+valueHiddenId+idStr).attr("value",fileId);
		$("#"+swfHiddenId+idStr).attr("value",swfId);
		var fileDownloadSpan = document.getElementById(fileDownloadSpanId+idStr);
		fileDownloadSpan.innerHTML = "<a href='#' onclick='downloadfile("+fileId+")'>"+file.name+"</a>";
		document.getElementById(fileDownloadSpanId+idStr).style.display="block";
		document.getElementById(fileSelectSpanId+idStr).style.display="none";
		document.getElementById(fileDeleteSpanId+idStr).style.display="block";
	}
	
	/**
	 * 初始化批量附件上传控件
	 * @param idStr
	 */	
	function initMutiSWFUpload(buttonPlaceholderId,gridId) {
			var url = contextPath+"/util/fileupload/uploadMutiFile.jsp?attachType=0&attachBusType=0&gridId="+gridId;
			new SWFUpload({
			upload_url : url,//表单提交的路径
			post_params : {
			},
			// File Upload Settings
			file_size_limit : "50 MB", // 上传文件最大容量
			file_types : "*.*",//文件类型限制
			file_types_description : "所有文件",
			file_upload_limit : "0",
			file_dialog_complete_handler : mutiFileDialogComplete,//选择好文件后提交
			upload_success_handler : mutiUploadSuccess,
			upload_complete_handler : mutiUploadComplete,
			
			// Button Settings
			button_placeholder_id : buttonPlaceholderId,
			button_width : 90,
			button_height : 23,
			button_text : '批量上传',
			button_text_top_padding : 0,
			button_text_left_padding : 23,
			button_window_mode : SWFUpload.WINDOW_MODE.TRANSPARENT,
			button_cursor : SWFUpload.CURSOR.HAND,
			button_image_url: contextPath+'/util/fileupload/image/mutiAdd.png',
			// Flash Settings
			flash_url :  contextPath+"/util/fileupload/js/swfupload.swf",

			custom_settings : {
			},
			// Debug Settings
			debug : false
			//是否显示调试窗口
			});
	};
	
	
	//自动上传	 		
	function mutiFileDialogComplete(){
			this.startUpload();
	}
	
	//多文件自动执行下一个上传动作
	function mutiUploadComplete(file) {
		if (this.getStats().files_queued > 0) {
			this.startUpload();
		} 
	}
	
	//上传成功后，回调函数   
	function mutiUploadSuccess(file, serverData) {
		var returnStr = trim(serverData.toString());
		var returnArr = returnStr.split(",");
		var fileId = parseInt(returnArr[0]);
		var gridId = returnArr[1];
		var idStr = "";
		var grid = nui.get(gridId);
		var data = grid.getData();
		if(data.length>0){
			for(var i=0;i<data.length;i++){
				var fileName = file.name;
				if(fileName.indexOf(data[i].pmOpenDocTemplet.tempKeyword)!=-1){
					idStr = gridId+data[i]._uid;
				}
			}
		}
		if(idStr!=""&&idStr!=null){
			$("#"+valueHiddenId+idStr).attr("value",fileId);
			var fileDownloadSpan = document.getElementById(fileDownloadSpanId+idStr);
			fileDownloadSpan.innerHTML = "<a href='#' onclick='downloadfile("+fileId+")'>"+file.name+"</a>";
			document.getElementById(fileDownloadSpanId+idStr).style.display="block";
			document.getElementById(fileSelectSpanId+idStr).style.display="none";
			document.getElementById(fileDeleteSpanId+idStr).style.display="block";
		}
	}
	
	
	//获取页面基础元素
	function getSingleFileHtml(idStr){
		var s = "<table style='border:0; padding: 0 0 0 0;margin: 0;border-top:none;border-collapse: separate;'><tr>";
		s += "<td><input id='"+swfHiddenId+idStr+"' type='hidden'><input id='"+valueHiddenId+idStr+"' type='hidden'><span id='"+fileSelectSpanId+idStr+"'><span id='"+buttonPlaceholderSpanId+idStr+"'></span></span></td>";
		s += "<td><a class='nui-button nui-button-plain' hidefocus='' href='javascript:void(0)' style='height:20px'>" +
				"<span id='"+fileDeleteSpanId+idStr+"' class='nui-button-text nui-button-iconOnly icon-remove' style='height:20px;display:none;'></span></a></td>";
		s += "<td><span id='"+fileDownloadSpanId+idStr+"'></span></td>";
		s += "</tr></table>";
		return s;
	}
	
	//
	function getDownloadSingleFileHtml(idStr){
		var s = "<table style='border:0; padding: 0 0 0 0;margin: 0;border-top:none;border-collapse: separate;'><tr>";
		s += "<td><span id='"+fileDownloadSpanId+idStr+"'></span></td>";
		s += "</tr></table>";
		return s;
	}
	
	/**
	 * 页面初始化显示使用
	 * @param XFileid  文件ID
	 * @param fileSelectSpan  文件渲染span外面待包裹span，用以控制显隐
	 * @param fileDownloadSpanId 放置附近下载的文件名
	 * @param fileDeleteSpanId 放置删除按钮
	 * @param buttonPlaceholderSpanId 用以附件渲染
	 */
	function checkout(XFileid,idStr){
    	if(isFileExists(XFileid)) {
    		document.getElementById(fileSelectSpanId+idStr).style.display="none";
    		displaySingleFile(XFileid,idStr);
    	}else{
    		document.getElementById(fileSelectSpanId+idStr).style.display="block";
    	}
	} 
	
	//自动上传	 		
	function fileDialogComplete(){
			this.startUpload();
	}	

	//根据文件id下载附件
	function downloadfile(fileid){
		var json = nui.encode({fileid: fileid});
		$.ajax({
            url:'com.cjhxfund.fpm.util.attachUitlFunction.queryAttachementByFileId.biz.ext',
            type:'POST',
            data:json,
            cache:false,
            contentType:'text/json',
            success:function(d){
				window.location.href= contextPath+"/util/fileupload/download.jsp?filepath="+d.pmAttachInfo.attachAdd+"&filename="+d.pmAttachInfo.attachName;		
        	}
        });
	}
	
	/**
	 * 获取附件Id
	 * @param fileGroupId
	 * @returns
	 */
	function getSingleFileId(fileGroupId){
		return  $("#"+valueHiddenId+fileGroupId).val();
	}
	
	//草稿显示文件名称并提供下载附件
	function displaySingleFile(XFileid,idStr) {
		var json = nui.encode({fileid: XFileid});
		$.ajax({
            url:'com.cjhxfund.fpm.util.attachUitlFunction.queryAttachementByFileId.biz.ext',
            type:'POST',
            data:json,
            cache:false,
            contentType:'text/json',
            async:false,
            success:function(d){
            	if(d.pmAttachInfo!=null&&d.pmAttachInfo.attachName!=null&&d.pmAttachInfo.attachName!="") {
            		var name = d.pmAttachInfo.attachName;
            		$("#"+valueHiddenId+idStr).attr("value",XFileid);
	        		var fileDownloadSpan = document.getElementById(fileDownloadSpanId+idStr);
					fileDownloadSpan.innerHTML = "<a href='#' onclick='downloadfile("+XFileid+")'>"+name+"</a>";
					if(document.getElementById(fileDeleteSpanId+idStr)!=null){
						document.getElementById(fileDeleteSpanId+idStr).style.display="block";
					}
				}
        	}
        });
	}
	//去除字符串前后空格
	function trim(str){ 
    	return str.replace(/(^\s*)|(\s*$)/g, ""); 
	}
	
	function deleteAttachment(fileId){
		var json = nui.encode({fileIds: fileId});
		$.ajax({
            url:'com.cjhxfund.fpm.util.attachUitlFunction.delAttachment.biz.ext',
            type:'POST',
            data:json,
            cache:false,
            contentType:'text/json',
            success:function(data){
        	}
        });
	}
	
	
	//判断文件是否存在
	function isFileExists(fileId){
		var flag = false;
		if(fileId==""||fileId==null){
			return false;
		}
		var json = nui.encode({fileId: fileId});
		$.ajax({
            url:'com.cjhxfund.fpm.util.attachUitlFunction.isAttachmentExists.biz.ext',
            type:'POST',
            data:json,
            cache:false,
            contentType:'text/json',
            async:false,
            success:function(data){
            	flag = data.isExist;
        	}
        });
		return flag;
	}
	
