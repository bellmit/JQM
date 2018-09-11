var grid;
var msgid;
function fileQueueError(file, errorCode, message) {
	try {
		var imageName = "<font color='red'>文件上传错误</font>";
		var errorName = "";
		if (errorCode === SWFUpload.errorCode_QUEUE_LIMIT_EXCEEDED) {
			errorName = "格式不对.";
		}

		if (errorName !== "") {
			nui.alert(errorName);
			return;
		}
		switch (errorCode) {
			case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
				imageName = "<font color='red'>附件内容为空,不能上传</font>";
				break;
			case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
				imageName = "<font color='red'>文件大小超过限制</font>";
				break;
			case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
				message = "一个产品只能上传一个印鉴";
			case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
			default:
				nui.alert(message);
				break;
		}
		addReadyFileInfo(file.id,file.name,imageName,"无法上传");

	} catch (ex) {
		this.debug(ex);
	}
}

/**
 * 当文件选择对话框关闭消失时，如果选择的文件成功加入上传队列，
 * 那么针对每个成功加入的文件都会触发一次该事件（N个文件成功加入队列，就触发N次此事件）。
 * @param {} file
 * id : string,			    // SWFUpload控制的文件的id,通过指定该id可启动此文件的上传、退出上传等
 * index : number,			// 文件在选定文件队列（包括出错、退出、排队的文件）中的索引，getFile可使用此索引
 * name : string,			// 文件名，不包括文件的路径。
 * size : number,			// 文件字节数
 * type : string,			// 客户端操作系统设置的文件类型
 * creationdate : Date,		// 文件的创建时间
 * modificationdate : Date,	// 文件的最后修改时间
 * filestatus : number		// 文件的当前状态，对应的状态代码可查看SWFUpload.FILE_STATUS }
 */
var isFileName=true;
function fileQueued(file){
	isFileName=true;
    //校验文件名是否满足命名规则
	if (isDigit(file.name)==false){
		isFileName=false;
	    swfu.setFileUploadLimit(0);//设置只能上载一个文件
		nui.alert("文件名不合法！只能由 中文、数字、字母、下划线、横线、括号组成！");
		return; 
	}
}
/*function fileDialogComplete(numFilesSelected, numFilesQueued) {
	try {
		if (numFilesQueued > 0) {
			document.getElementById('btnCancel').disabled = "";
			//this.startUpload();
		}
	} catch (ex) {
		this.debug(ex);
	}
}*/
function fileDialogComplete(numFilesSelected, numFilesQueued) {
	/*try {
		if (numFilesQueued > 0) {
			document.getElementById('btnCancel').disabled = "";
			//this.startUpload();
		}
	} catch (ex) {
		this.debug(ex);
	}*/
	//如果上传文件数据等于队列文件数量，才自动上传
	//队列数量小说明上传文件中有文件出错，或超出限制，则不自动上传
	if(numFilesSelected!=0 && numFilesSelected==numFilesQueued){
		if(isFileName==false){//判断用户名是否合法
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

//上传进度条
function uploadProgress(file, bytesLoaded) {
	try {
		var percent = Math.ceil((bytesLoaded / file.size) * 100);

		var progress = new FileProgress(file,  this.customSettings.upload_target);
		progress.setProgress(percent);
		
		var row = grid.findRow(function(row){
		    if(row.id == file.id) return true;
		});
		var new_row=nui.clone(row);
		if (percent === 100) {
			progress.setStatus("");//正在创建缩略图...
			progress.toggleCancel(false, this);
			new_row.status="";
		} else {
			progress.setStatus("正在上传...");
			progress.toggleCancel(true, this);
			new_row.status="正在上传...";
		}
		percent=percent>100?100:percent;
		new_row.jd= '<div class="progressbar">'
            + '<div class="progressbar-percent" style="width:' + percent + '%;"></div>'
            + '<div class="progressbar-label">' + percent + '%</div>'
        +'</div>';
		grid.updateRow(row,new_row);
		
		//grid.load(formData);
	} catch (ex) {
		this.debug(ex);
	}
}

/*function uploadSuccess(file, serverData) {
	try {
		var fileid = trim(serverData.toString());
		addReadyFileInfo(fileid,file.name,"成功加载到上传队列","",file.size);
		var progress = new FileProgress(file,  this.customSettings.upload_target);
		addFileInfo(file.id,"文件上传完成");
	} catch (ex) {
		this.debug(ex);
	}
}*/
//文件名校验
function isDigit(s) 
{ 
	var patrn=/^[A-Za-z0-9|\u4E00-\u9FA5|\（|\）|\【|\】|\(|\)|\[|\]|\-|\<|\>|\《|\》|\-|\_|\.]+$/; 
	if (!patrn.exec(s)) return false 
	return true 
}
function uploadSuccess(file, serverData) {
	try {
		if(msgid!=null&&msgid!=""){
			commonHideMessageBox(msgid);
		}
		var fileid = trim(serverData.toString());
		if (file.size === undefined) {
			window.parent.alertMessage("附件名："+"“"+fileName+"”"+"的内容为空，不能上传!","系统提示");
			return;
		}
		if(fileid.length> 1000){
			window.parent.alertMessage("浏览器异常，无法上传文件，请更换浏览器！","系统提示");
			return;
		}
		
		addReadyFileInfo(fileid, file.name, "成功加载到上传队列", "", file.size);
		setFileHeight();
		grid.reload();
		//addFileInfo(file.id, "文件上传完成");
	} catch (ex) {
		this.debug(ex);
	}
}

function addFileInfo(fileId,message){
	var row = document.getElementById(fileId);
	row.cells[2].innerHTML = "<font color='green'>"+message+"</font>";
	row = grid.findRow(function(row){
	    if(row.id == fileId) return true;
	});
	
	var new_row=nui.clone(row);
	new_row.status=message;
	//更新上传结果
	grid.updateRow(row,new_row);
	//grid.load(formData);
}
function addReadyFileInfo(fileid,fileName,message,status,size1){
	//用表格显示
	var attachSize=size1;
	if(attachSize == undefined){
		nui.alert(message);
		return;
	};
	//校验文件名是否满足命名规则
	if (isDigit(fileName)==false){
		isOk=false;
		nui.alert("文件名不合法！只能由 中文、数字、字母、下划线、横线、括号组成！");
		return; 
	}
	var infoTable = document.getElementById("infoTable");
	var row = infoTable.insertRow();
	row.id = fileid;
	var col1 = row.insertCell();
	var col2 = row.insertCell();
	var col3 = row.insertCell();
	var col4 = row.insertCell();
	var col5 = row.insertCell();
	col4.align = "right";
	col1.innerHTML = message+" : ";
	col2.innerHTML = fileName;
	col5.innerHTML = attachSize;
	if(status!=null&&status!=""){
		col3.innerHTML="<font color='red'>"+status+"</font>";
	}else{
		col3.innerHTML="";
	}
	col4.innerHTML = "<a href='javascript:deleteFile(\""+fileid+"\")'>删除</a>";
	col1.style.width="150";
	col2.style.width="250";
	col3.style.width="80";
	col4.style.width="50";
	col5.style.width="80";
	//新增上传文件
	var newRow = { lAttachId:fileid,vcAttachName:fileName,message:message,status:status,vcAttachSize:attachSize};
    grid.addRow(newRow, 0);
    grid.setHeight(grid.getHeight()+23);
    window.parent.refreshFile();
}

function cancelUpload(){
	var infoTable = document.getElementById("infoTable");
	var rows = infoTable.rows;
	var ids = new Array();
	if(rows==null){
		return false;
	}
	for(var i=0;i<rows.length;i++){
		ids[i] = rows[i].id;
	}	
	for(var i=0;i<ids.length;i++){
		deleteFile(ids[i]);
	}	
	//删除所有文件
	grid.clearRows();
}

function deleteFile(fileId){
	//用表格显示
	var infoTable = document.getElementById("infoTable");
	var row = document.getElementById(fileId);
	infoTable.deleteRow(row);
	swfu.cancelUpload(fileId,false);
	
}

function uploadComplete(file) {
	try {
		/*  I want the next upload to continue automatically so I'll call startUpload here */
		if (this.getStats().files_queued > 0) {
			this.startUpload();
		} else {
			var progress = new FileProgress(file,  this.customSettings.upload_target);
			progress.setComplete();
			progress.setStatus("<font color='red'>所有文件上传完毕!</b></font>");
			progress.toggleCancel(false);
			showTips();
		}
	} catch (ex) {
		this.debug(ex);
	}
}

function uploadError(file, errorCode, message) {
	var imageName =  "<font color='red'>文件上传出错!</font>";
	var progress;
	try {
		switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
			try {
				progress = new FileProgress(file,  this.customSettings.upload_target);
				progress.setCancelled();
				progress.setStatus("<font color='red'>取消上传!</font>");
				progress.toggleCancel(false);
			}
			catch (ex1) {
				this.debug(ex1);
			}
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			try {
				progress = new FileProgress(file,  this.customSettings.upload_target);
				progress.setCancelled();
				progress.setStatus("<font color='red'>停止上传!</font>");
				progress.toggleCancel(true);
			}
			catch (ex2) {
				this.debug(ex2);
			}
		case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
			imageName = "<font color='red'>文件大小超过限制!</font>";
			break;
		default:
			nui.alert(message);
			break;
		}
		addFileInfo(file.id,imageName);
	} catch (ex3) {
		this.debug(ex3);
	}

}


function addImage(src) {
	var newImg = document.createElement("img");
	newImg.style.margin = "5px";

	document.getElementById("thumbnails").appendChild(newImg);
	if (newImg.filters) {
		try {
			newImg.filters.item("DXImageTransform.Microsoft.Alpha").opacity = 0;
		} catch (e) {
			// If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
			newImg.style.filter = 'progid:DXImageTransform.Microsoft.Alpha(opacity=' + 0 + ')';
		}
	} else {
		newImg.style.opacity = 0;
	}

	newImg.onload = function () {
		fadeIn(newImg, 0);
	};
	newImg.src = src;
}

function fadeIn(element, opacity) {
	var reduceOpacityBy = 5;
	var rate = 30;	// 15 fps


	if (opacity < 100) {
		opacity += reduceOpacityBy;
		if (opacity > 100) {
			opacity = 100;
		}

		if (element.filters) {
			try {
				element.filters.item("DXImageTransform.Microsoft.Alpha").opacity = opacity;
			} catch (e) {
				// If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
				element.style.filter = 'progid:DXImageTransform.Microsoft.Alpha(opacity=' + opacity + ')';
			}
		} else {
			element.style.opacity = opacity / 100;
		}
	}

	if (opacity < 100) {
		setTimeout(function () {
			fadeIn(element, opacity);
		}, rate);
	}
}



/* ******************************************
 *	FileProgress Object
 *	Control object for displaying file info
 * ****************************************** */

function FileProgress(file, targetID) {
	this.fileProgressID = "divFileProgress";

	this.fileProgressWrapper = document.getElementById(this.fileProgressID);
	if (!this.fileProgressWrapper) {
		this.fileProgressWrapper = document.createElement("div");
		this.fileProgressWrapper.className = "progressWrapper";
		this.fileProgressWrapper.id = this.fileProgressID;

		this.fileProgressElement = document.createElement("div");
		this.fileProgressElement.className = "progressContainer";

		var progressCancel = document.createElement("a");
		progressCancel.className = "progressCancel";
		progressCancel.href = "#";
		progressCancel.style.visibility = "hidden";
		progressCancel.appendChild(document.createTextNode(" "));

		var progressText = document.createElement("div");
		progressText.className = "progressName";
		progressText.appendChild(document.createTextNode("上传文件: "+file.name));

		var progressBar = document.createElement("div");
		progressBar.className = "progressBarInProgress";

		var progressStatus = document.createElement("div");
		progressStatus.className = "progressBarStatus";
		progressStatus.innerHTML = "&nbsp;";

		this.fileProgressElement.appendChild(progressCancel);
		this.fileProgressElement.appendChild(progressText);
		this.fileProgressElement.appendChild(progressStatus);
		this.fileProgressElement.appendChild(progressBar);

		this.fileProgressWrapper.appendChild(this.fileProgressElement);
		document.getElementById(targetID).style.height = "75px";
		document.getElementById(targetID).appendChild(this.fileProgressWrapper);
		fadeIn(this.fileProgressWrapper, 0);

	} else {
		this.fileProgressElement = this.fileProgressWrapper.firstChild;
		this.fileProgressElement.childNodes[1].firstChild.nodeValue = "上传文件: "+file.name;
	}

	this.height = this.fileProgressWrapper.offsetHeight;

}
FileProgress.prototype.setProgress = function (percentage) {
	this.fileProgressElement.className = "progressContainer green";
	this.fileProgressElement.childNodes[3].className = "progressBarInProgress";
	this.fileProgressElement.childNodes[3].style.width = percentage + "%";
};
FileProgress.prototype.setComplete = function () {
	this.fileProgressElement.className = "progressContainer blue";
	this.fileProgressElement.childNodes[3].className = "progressBarComplete";
	this.fileProgressElement.childNodes[3].style.width = "";

};
FileProgress.prototype.setError = function () {
	this.fileProgressElement.className = "progressContainer red";
	this.fileProgressElement.childNodes[3].className = "progressBarError";
	this.fileProgressElement.childNodes[3].style.width = "";

};
FileProgress.prototype.setCancelled = function () {
	this.fileProgressElement.className = "progressContainer";
	this.fileProgressElement.childNodes[3].className = "progressBarError";
	this.fileProgressElement.childNodes[3].style.width = "";

};
FileProgress.prototype.setStatus = function (status) {
	this.fileProgressElement.childNodes[2].innerHTML = status;
};

FileProgress.prototype.toggleCancel = function (show, swfuploadInstance) {
	this.fileProgressElement.childNodes[0].style.visibility = show ? "visible" : "hidden";
	if (swfuploadInstance) {
		var fileID = this.fileProgressID;
		this.fileProgressElement.childNodes[0].onclick = function () {
			swfuploadInstance.cancelUpload(fileID);
			return false;
		};
	}
};

function removeRow() {
    var rows = grid.getSelecteds();
    if (rows.length > 0) {
    	for (var i = 0; i < rows.length; i++) {
    		var row=rows[i];
			grid.removeRow(row, true);
    		//deleteFile(row.id);
		}
    }
    var row = grid.getData();
    if(row.length == 0){
    	document .getElementById("datagridupload").style.display = "none";
    }
}
var isOk=true;
function showTips() {
	//没有验证通过，不能提示成功
	if(isOk==false)return;
    nui.showTips({
        content: "<b>成功</b> <br/>文件全部上传成功",
        state: "danger",
        x: "center",
        y: "top",
        timeout: 3000
    });
    document.getElementById("datagridupload").style.display = "block";
}

function trim(str){ 
    return str.replace(/(^\s*)|(\s*$)/g, ""); 
}