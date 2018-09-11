<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/bpsExpend/common/common.jsp"%>
<html>
<head>
	<title>我的任务列表</title>
	<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
	<META HTTP-EQUIV="expires" CONTENT="0">
</head>

<body style="width: 100%;height:99%;overflow: hidden" class="body-font" onload="autoshowDetail()"> 
	<div id="form1" class="nui-form" align="center" style="height: 30px;display: none;">
		<table id="table1" class="table" style="height: 100%; width: 100%">
			<tr  style="width: 100%">
				<td  align="right" colspan="1" class="form_label" style="text-align:right;width:10%;">任务检索关键字</td>
				<td colspan="1"  align="center" style="width:80%;">
					<input class="nui-hidden" id="search1" name="criteriaMap"/>
				</td>
			</tr>
		</table>
	</div>
<div class="nui-fit" >
	<div id="taskListId" class="nui-datagrid" style="width: 98%;height: 100%;display:none;" 
		url="com.cjhxfund.fpm.bpsExpend.task.queryTodoTaskList.biz.ext" allowAlternating="true" sortField="arrivalTime" sortOrder="desc"
		dataField="tasks" pageSize="20" allowSortColumn="true" showPageInfo="true" >
	    <div property="columns">
	        <div name="productName" field="productName" width="25%" headerAlign="center" align="center" allowSort="true" renderer="outputTaskName">产品名称</div>
	        <div name="accountType" field="accountType" width="10%" headerAlign="center" align="center" allowSort="true" >账户类型</div>
		    <div name="processType" field="processType" width="10%" headerAlign="center" align="center" allowSort="true" renderer="getProcTypeDict">流程类型</div>
		    <div name="bussinessType" field="bussinessType" width="10%" headerAlign="center" align="center" allowSort="true" >业务类型</div>
			<div name="processActivityName" field="processActivityName" width="15%" headerAlign="center" align="center" allowSort="true" >流程环节</div>
			<div name="creator" field="creator" width="15%" headerAlign="center" align="center" allowSort="true">提交人</div>
		    <div name="arrivalTime" field="arrivalTime" width="25%" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" allowSort="true">到达时间</div>
	    </div>
	</div>
	<div id="taskListId_1" class="nui-datagrid" style="width: 98%;height: 100%;display:none;"
		url="com.cjhxfund.fpm.bpsExpend.task.queryTodoTaskList.biz.ext" allowAlternating="true" sortField="arrivalTime" sortOrder="desc"
		dataField="tasks" pageSize="20" allowSortColumn="true" showPageInfo="true">
	    <div property="columns">
	        <div name="productName" field="productName" width="30%" headerAlign="center" align="center" allowSort="true" renderer="outputTaskName">产品名称</div>
		    <div name="processType" field="processType" width="15%" headerAlign="center" align="center" allowSort="true" renderer="getProcTypeDict">流程类型</div>
			<div name="processActivityName" field="processActivityName" width="15%" headerAlign="center" align="center" allowSort="true" >流程环节</div>
			<div name="creator" field="creator" width="15%" headerAlign="center" align="center" allowSort="true">提交人</div>
		    <div name="arrivalTime" field="arrivalTime" width="25%" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" allowSort="true">到达时间</div>
	    </div>
	</div>
</div>
	<script type="text/javascript">
    	nui.parse();
    	
    	//任务列表
    	//var taskListDataGridObj = nui.get("taskListId");
    	var taskListDataGridObj=null;
    	//加载使用哪一个datagrid
		function autoshowDetail(){
			   var roleJson = nui.encode({"roleCode":nui.getDictText("PM_ISSHOW_ACCT_TYPE",1001)});
			   var submitUrl = "com.cjhxfund.fpm.bpsExpend.role.queryRoleByCurrUserId.biz.ext";
				//获取后台处理前台数据的结果
			   var staticData = pm_ajax(roleJson,submitUrl,false);
			   //console.log(staticData.roleEmp);
			   if(staticData!=null && staticData.roleEmp.flag==1){
			       //acctStat="show";
			       taskListDataGridObj = nui.get("taskListId");
			       var taskListDataGridObj1 = nui.get("taskListId_1");
			       taskListDataGridObj1.hide();
				   taskListDataGridObj.show();
			   }else{
			         // acctStat="hide";
			       taskListDataGridObj = nui.get("taskListId_1");
			       var taskListDataGridObj1 = nui.get("taskListId");
			       taskListDataGridObj1.hide();
				   taskListDataGridObj.show();
		       }
		     //刷新任务数量提示
		    taskListDataGridObj.on("update", function() {	
	    		window.parent.refrushTaskNum("todoTask",taskListDataGridObj.totalCount);
			});
    	}
    	doLoadTaskList();
    	var acctStat="";
 	    var gridColumn1="";
        var gridColumn2="";
        var userRoleAuth="";
    
    	resizeDatagridHeight();
    	
    	$(window).bind("resize", resizeDatagridHeight);
    	// 自动调整datagrid的外部高度,撑满屏幕
    	function resizeDatagridHeight(){
    		var realheight = window.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight;
	    	realheight = realheight  + "px";
	    	var datagridObj = document.getElementById("taskListId");
	    	datagridObj.style.height=realheight;
    	}
    	
        //加载任务列表
        function doLoadTaskList() {
        	var  searchVal= window.parent.returnValue();
			nui.get("search1").setValue(searchVal);
			//var form = new nui.Form("#form1");
            //json = form.getData(false,false);
        	//taskListDataGridObj.load(json, function(res){
        	//	if(res.exception) {
        	//		tfcToast.take("加载任务列表失败");
        	//	}        		
        	//}, function() {
        	//	tfcToast.take("加载任务列表失败");
        	//});
        }
    	//输出任务名称
    	function outputTaskName(e){
    		var taskName = e.record.processInstName;
            var productNm = e.record.productName;
            var s="";
            	s += '<a class="dgBtn"  style = "font-size: 9pt;" href="javascript:doOperate(' 
            	+ e.row.taskId + ',\''+e.row.taskType+'\','+e.row.processInstID + ',\'' + taskName + '\')">'+productNm+'</a> ';
            	
          	return s;
    	}
    	//操作
    	function onActionRenderer(e) {
    		var arrivalTime = nui.formatDate (e.row.arrivalTime, "yyyy-MM-dd HH:mm:ss");
    		var taskName = e.record.processInstName;
    		var taskArr = taskName.split("--");
    		var taskShowName = "";
    		for(var i=0;i<taskArr.length;i++){
    			if(taskArr[i].indexOf("加急")>-1){
    				var str = taskArr[i].substring(0,4);
    				var last = taskArr[i].substring(4,taskArr[i].length);
    				var frist = '<font color="red" style = "font-size: 10pt;">'+str+'</font>';
    				taskArr[i]= frist+last;
    			}
    		   if(taskArr.length>1&i>taskArr.length-2){
    		   		taskShowName += '--<font color="red" style = "font-size: 11pt;">'+taskArr[i]+'</font>';
    		   }else if(taskArr.length>2&i>taskArr.length-3){
    		   		taskShowName += '--<font color="green" style = "font-size: 10pt;">'+taskArr[i]+'</font>';
    		   }else{
    		   		taskShowName += '--<font color="blue">'+taskArr[i]+'</font>';
    		   }
    		}
    		
    		var s = "";
    			s += '<img src="'+contextPath+'/bpsExpend/task/img/task.gif"></img>';
            	s += '<a class="dgBtn"  style = "font-size: 9pt;" href="javascript:doOperate(' 
            	+ e.row.taskId + ',\''+e.row.taskType+'\','+e.row.processInstID + ',\'' + taskName + '\')">'+taskShowName+'</a> ';
            	s += '(提交人:'+e.row.creator+'; &nbsp到达时间:'+arrivalTime+')';
            return s;
        }
        //从数据字典中获取流程类型
        function getProcTypeDict(e){
           var procType = e.row.processType;
            var isfast = e.record.isFast;
            if(isfast!=null && isfast!=""){
                  return isfast+nui.getDictText("PM_PROC_TYPE",procType);
            }else{
                 return nui.getDictText("PM_PROC_TYPE",procType);
            }
        }
	    //执行操作
	    function doOperate(taskId,taskType,processInstID,taskShowName) {
	    	var url = "";
	    	//依赖于index页面的opentab的方法 关闭父页面使用，如为空，不影响其他功能
	    	var curTabId = '<b:write property="curTabId"/>';
	    	var status = checkIsNewProcess(processInstID);
	    	//alert(status);
	    	//alert(taskType);
	    	if(status){
	    	    //new process
	    		url = contextPath + "/com.cjhxfund.fpm.bpsExpend.getTaskInfo.flow?workItemID="+taskId;
	    		url += "&parTabId="+curTabId;
	    		//打开为TAB页
    		    openTab("task" + taskId, "tab$task$" + taskId, taskShowName, url);
	    	}else{
	    	    //old process
	    		if(taskType == "task"){
		    		url = contextPath + "/com.cjhxfund.fpm.util.getTaskInfo.flow?workItemID="+taskId;
		    		url += "&parTabId="+curTabId;
		    		//打开为TAB页
		    		openTab("task" + taskId, "tab$task$" + taskId, taskShowName, url);
	    		
		    	}else if(taskType == "notice"){
					if(processInstID=="-2"){    //流程实力ID为-2是交易单元通知
	    				tradeUnitNotice(taskId);
	    			} else if(processInstID=="-3") {  //流程实力ID为-3是只通知结果
	    				nui.alert("该产品已完成！", "通知", null);
	    				readonlyNotice(taskId);
	    			} else if(processInstID=="-4") {  //流程实力ID为-3是只通知结果
	    				nui.alert("该产品已修改产设贡献收入归属部门，流程需重新审批！", "通知", null);
	    				readonlyNotice(taskId);
	    			}else {
		    			confirmNotice(taskId,processInstID);
	    			}
		    	}
	    	}
    		
	    }
	    function tradeUnitNotice(notificationID){
			var url = contextPath + "/com.cjhxfund.fpm.openAccount.getTradeUnitNotice.flow?inUrl=auditPage&notificationID="+notificationID;
			var data = {notificationID : notificationID};
			var json = nui.encode(data);//将数据转换成json格式
			nui.ajax({
					url : "com.cjhxfund.fpm.bpsUtil.notice.confrimNotification.biz.ext",
					type : 'POST',
					data : json,
					cache : false,
					contentType : 'text/json',
					success : function(text) {
						window.location.href=url;
					}
			});
		}
		function readonlyNotice(notificationID){
			var data = {notificationID : notificationID};
			var json = nui.encode(data);//将数据转换成json格式
			nui.ajax({
				url : "com.cjhxfund.fpm.bpsUtil.notice.confrimNotification.biz.ext",
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					nui.get("taskListId").load();
				}
			});
		}
		function confirmNotice(notificationID,processInstID) {			
			var data = {notificationID : notificationID};
			var json = nui.encode(data);//将数据转换成json格式
			nui.ajax({
					url : "com.cjhxfund.fpm.bpsUtil.notice.confrimNotification.biz.ext",
					type : 'POST',
					data : json,
					cache : false,
					contentType : 'text/json',
					success : function(text) {
						var url = contextPath + "/com.cjhxfund.fpm.util.getTaskInfo.flow?processInstID="+processInstID+"&pageType=taskList";
						window.location.href=url;
						//grid.reload();						
					}
			});
		}
		function search(json){
            taskListDataGridObj.load(json);//grid查询
		}
		
    </script>
</body>
</html>
