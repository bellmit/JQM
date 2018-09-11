//js文件中获取contextPath的方法
function getContextPath(){
	var pathName = document.location.pathname;
    var index = pathName.substr(1).indexOf("/");
    var result = pathName.substr(0,index+1);
    return result;
}

//字符串replaceAll方法
String.prototype.replaceAll = function(s1,s2) {    return this.replace(new RegExp(s1,"gm"),s2); };

//查询并设置默认文字
function defaultWord(typeNum,tableName,columnName,typeNum2){
	var returnStr = "";
	var wordQueryUrl = "com.cjhxfund.fpm.draft.prodResInfoManager.getDefaultWord.biz.ext";
	var json = nui.encode({typeNum:typeNum,tableName:tableName,columnName:columnName,typeNum2:typeNum2});
	 $.ajax({
			url:wordQueryUrl,
			data:json,
			type:'POST',
			contentType:'text/json',
	        cache:false,
	        async:false,
			success:function(data){
				//设置投资范围的默认文字
	        	returnStr = data.pmSysDefaultValue.descValue; 
	        }
		});
	return returnStr;
}
//处理键盘事件 禁止后退键（Backspace）密码或单行、多行文本框除外
function banBackSpace(e){   
	var ev = e || window.event;//获取event对象   
    var obj = ev.target || ev.srcElement;//获取事件源   
    var t = obj.type || obj.getAttribute('type');//获取事件源类型  
    //获取作为判断条件的事件类型
    var vReadOnly = obj.getAttribute('readonly');
    //处理null值情况
    var isReadOnly = (vReadOnly == "") ? false : vReadOnly;
    //当敲Backspace键时，事件源类型为密码或单行、多行文本的，
    //并且readonly属性为true或enabled属性为false的，则退格键失效
    var flag1=(ev.keyCode == 8 && (t=="password" || t=="text" || t=="textarea") 
                && isReadOnly=="readonly")?true:false;
    //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效
    var flag2=(ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea")
                ?true:false;        
    
    //判断
    if(flag2){
        return false;
    }
    if(flag1){   
        return false;   
    }   
}
    //禁止后退键 作用于Firefox、Opera
    document.onkeypress=banBackSpace;
    //禁止后退键  作用于IE、Chrome
    document.onkeydown=banBackSpace;

//设置日期格式 去除保存时的hh：mm：ss
function setSaveDate(id,dateFormat2){
	var date = nui.get(id).getValue();
	
	if(date){
		var newDate = "";
		var dateArr = date.split("-");
		var dateDay = dateArr[2].split(" ");
		
		if(dateFormat2=="yyyyMMdd"){
			newDate = dateArr[0]+""+dateArr[1]+""+dateDay[0];
		}
		return newDate;
	} else {
		return "";
	}
}

//关闭TAB页或返回我的任务列表
//发起页面时，没有workitem，所以去掉该判读
function removeTabOrBackMyTasks(type,parTabId){
	 removeTab(type,parTabId);
}

/**
 * 刷新父tab页面
 * @param tabs 父tab的tab组对象
 * @param parTabId 父tab的ID
 */
function reloadParTab(tabs,parTabId){
    if(parTabId!=null){
    	var parTab = tabs.getTab(parTabId);	
        if(parTab!=null){
        	tabs.reloadTab(parTab);
        }; 
    }
}


//流程提交后关闭tab页面
function removeTab(type,parTabId){
	var rootMini = window.parent.mini;
	
	if(type == 'processNew'){//流程新页面追加了一层iframe
		rootMini = window.parent.parent.mini;
	}
	
    var tabs = rootMini.get("mainTabs");
    
    if(type!="back"){	//非返回操作刷新我的任务页   task类型
    	//重新加载首页跟我的任务页
        var indexTab = tabs.getTab(0);	//首页
        //homepage未正式启用，暂时屏蔽
        //tabs.loadTab(contextPath+'/homePage/homepage.jsp', indexTab, null, null);
        if(type == 'processNew'){
        	tabs.loadTab(contextPath+'/bpsExpend/task/myTasks.jsp', indexTab, null, null);
        }
        else{
        	tabs.loadTab(contextPath+'/bpsExpend/task/myTasks.jsp', indexTab, null, null);
        }
        var myTask = tabs.getTab('tab$11');	//我的任务页
        if(myTask!=null){
        	 if(type == 'processNew'){
             	tabs.loadTab(contextPath+'/bpsExpend/task/myTasks.jsp', myTask, null, null);
             }
             else{
             	tabs.loadTab(contextPath+'/bpsExpend/task/myTasks.jsp', myTask, null, null);
             }
        }
        //刷新父页面
        if(parTabId!=0||parTabId!="tab$11"){//避免和上面重复时两次刷新
        	reloadParTab(tabs,parTabId);
        }
    }
    //关闭tab页面
    tabs.removeTab(tabs.getActiveTab().name);
}


//时间格式
Date.prototype.Format = function (fmt) {
	var o = {
	    "M+": this.getMonth() + 1, //月份 
	    "d+": this.getDate(), //日 
	    "h+": this.getHours(), //小时 
	    "m+": this.getMinutes(), //分 
	    "s+": this.getSeconds(), //秒 
	    "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
	    "S": this.getMilliseconds() //毫秒 
	};
	if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for (var k in o)
	if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
};


//插入字符char到字符串str到某个位置index(只支持日期20160101拼接成2016-01-01)
function insertChar(str,char,index){
	var newStr = "";
	str = str.toString();
	var head = str.substring(0,index);
	var mid = str.substring(index,index+2);
	var end = str.substring(index+2,str.length);
	newStr = head + char + mid + char + end;
	return newStr;
}


/*
*获取文件的iframe窗口大小
*/
function getFileFrameSize(fileSize){
	var frameHeight = 0 ;
	var buttonHeight = 40;
	var tableHeight = 40;
	var rowHeight = 31;
	if(fileSize<1){
		frameHeight = buttonHeight;
	}else if(0 < fileSize && fileSize < 5){
		frameHeight = buttonHeight + tableHeight + rowHeight * fileSize;
	}else{
		frameHeight = buttonHeight + tableHeight + rowHeight * 5;
	}
	return frameHeight;
}


/*
*获取文件的grid窗口大小
*样式调整，略微增加2px到整体高度
*/
function getFileGridSize(fileSize){
	var gridHeight = 0 ;
	var tableHeight = 42;
	var rowHeight = 30;
	if(fileSize<1){
		gridHeight = buttonHeight;
	}else if(0 < fileSize && fileSize < 5){
		gridHeight = tableHeight + rowHeight * fileSize;
	}else{
		gridHeight = tableHeight + rowHeight * 5;
	}
	return gridHeight;
}

function getFileGridSize1(fileSize){
	var gridHeight = 0 ;
	var tableHeight = 40;
	if(fileSize<1){
		gridHeight = buttonHeight;
	}else if(0 < fileSize && fileSize < 8){
		gridHeight = tableHeight +30 * fileSize ;
	}else{
		gridHeight = tableHeight +30 * 8 ;
	}
	return gridHeight;
}


//附件大小为空时显示
function alertMessage(msg,title){
	nui.alert(msg,title);
	
}

function commonLoading(msg,title){
	return nui.loading(msg,title);
}

function commonHideMessageBox(messageid){
	 nui.hideMessageBox(messageid);
}


/**
 * 自动调整datagrid的外部高度,撑满屏幕
 * fixHeight 需要修正的高度，一般是查询窗口的高度
 */
function resizeDatagridHeight(divID,fixHeight){
	var realheight = window.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight;
	if(navigator.userAgent.indexOf('Firefox') >= 0 || navigator.userAgent.indexOf('Chrome') >= 0){
		realheight  -= 0;
	}
	realheight = realheight - fixHeight  + "px";
	var datagridObj = document.getElementById(divID);
	datagridObj.style.height=realheight;
} 



/**
 * 封装ajax调用 
 *@param json 入参对象
 *@param urlStr 调用逻辑
 *@param async 同步或异步  true 异步/false 同步 
 */
function pm_ajax(json,urlStr,async){
	var returnData = ""; 
	nui.ajax({
		type:"post",
		url:urlStr,
		data:json,
		cache:false,
		async:async,
		contentType:'text/json',
		success:function(text){
			returnData = text;
		}
	});
	
	return returnData;
}


/*-----开始，杨志文20161017-------*/
//设置保存或提交前的信息提示
function setSaveOrSubMassage(btnType){
	var loadStr = "";
	if(btnType=="save"){
		loadStr = "数据正在保存中……";
	}else if(btnType=="load"){
		loadStr = "数据正在读取中……";
	}else if(btnType=="delete"){
		loadStr = "数据正在删除中……";
	}else{
    	loadStr = "数据正在提交中……";
    }	
    return nui.loading(loadStr);
}
/**设置保存或提交后的信息提示
 *message(遮罩信息)
 *type(按钮类型): save | sub 
 *result(结果显示样式): default| success| info| warning| danger
*/
function saveOrSubResultTips(message,type,result){
	var contentText = "";
	nui.hideMessageBox(message);
	if(type!="save")return;
	if(result=="success" || result=="info" || result=="default"){
		contentText="数据保存成功！";
	}else if(result=="danger"){
		contentText="数据保存失败！";
	}else{
		alert("信息提示参数输入错误！！");
	}
	nui.showTips({
        content: contentText,
        state: result,
        x: "center",
        y: "center",
        timeout: 2000
    }); 
}
/**设置删除后的信息提示
 *message(遮罩信息)
 *type(按钮类型): delete 
 *result(结果显示样式): default| success| info| warning| danger
*/
function deleteResultTips(message,type,result){
	var contentText = "";
	nui.hideMessageBox(message);
	if(type!="delete")return;
	if(result=="success" || result=="info" || result=="default"){
		contentText="数据删除成功！";
	}else if(result=="danger"){
		contentText="数据删除失败！";
	}else{
		alert("信息提示参数输入错误！！");
	}
	nui.showTips({
        content: contentText,
        state: result,
        x: "center",
        y: "center",
        timeout: 2000
    }); 
}

/*离开提示
 *
*/
function leftTipMethod(){
	
	var _t; 
	var _num = 0;  //标记次数
	window.onbeforeunload = function() {
	    _num++;
	    if(_num<=1){
	    	if(!closeflag){
		    	closeflag=false;
		    	setTimeout(function(){_t = setTimeout(onunloadcancel,0)},500);
		    	return "你确定离开此页面？";
			}
	    }
	};
	window.onunloadcancel = function(){  
		_num=0; 
		clearTimeout(_t);
	}; 
}

/**
 * datagrid删除空白行
 *@param datagridID：表格ID
 *@param columnNames：列名数组
 *@param removeBtnID：删除按钮ID
 */
function removeDataGridBlankRows(datagridID, columnNames, removeBtnID){
	var grid = nui.get(datagridID);
	var rows = grid.findRows(function(row){
		for(var i=0; i<columnNames.length; i++){
			var value = $.trim(row[columnNames[i]]);
			if(value!=null && value!=""){
				return false;
			}
		}
		return true;
	});
	grid.removeRows(rows, false);
	setGridHeight(datagridID,removeBtnID);
	
}
//datagrid去空格
function trimDataGridCellValue(datagridID, columnNames){
	var grid = nui.get(datagridID);
	//获取数据
	var gridData = grid.getData();
	for(var i=0; i<gridData.length; i++){
		for(var j=0; j<columnNames.length; j++){
			gridData[i][columnNames[j]] = $.trim(gridData[i][columnNames[j]]);
		}
		grid.updateRow(gridData[i],gridData[i]);
	}
}

//打开TAB页
function openTab(nodeid, name, title, url){
	var rootMini = window.parent.parent.mini;
	var tabs = rootMini.get("mainTabs");
    var tab = tabs.getTab(name);
    var connStr = "&";
    if (!tab) {
        tab = {};
        tab._nodeid = nodeid;
        tab.name = name;
        tab.title = title;
        tab.showCloseButton = true;
        
        if(url.indexOf("?")==-1){
			connStr = "?";
		}
        
        //追加tabID参数
        url += connStr + "curTabId="+name;
        tab.url = url;
        var tabArrly = tabs.getTabs();
        if (tabArrly.length > 15) {
            nui.alert("最多只能打开15个标签页，请先关闭其他标签页", "系统提示");
            return;
        }
        tabs.addTab(tab);
    }
    tabs.activeTab(tab);
}

//通过获取流程定义名称判断是否是新流程
function checkIsNewProcess(processId){
	//alert("comming..");
	var json = nui.encode({"processId":processId});
	//默认走旧流程
	var respMsg = "no";
	nui.ajax({
		url:'com.cjhxfund.fpm.bpsExpend.task.queryProcessTemp.biz.ext',
		method:'post',
		data:json,
		contentType:'text/json',
        cache:false,
        async:false,
		success:function(data){
			//alert(data.result);
			respMsg = data.result;
		}
	});
	//alert(respMsg);
	if(respMsg=="yes"){
		return true;
	}else{
		return false;
	}
	
}

//显示流程图
function showProcessByProcDefName(divID,procDefName){
	var processGraphObj = nui.get(divID);	
	processGraphObj.setProcDefName(procDefName);
	processGraphObj.load();
}	
