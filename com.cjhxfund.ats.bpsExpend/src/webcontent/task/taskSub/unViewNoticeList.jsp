<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/common.jsp"%>
<html>
<head>
	<title>我的任务列表</title>
</head>
<body style="width: 100%;height:99%;overflow: hidden" class="body-font" onload="isshowAccountType()"> 
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

	<div id="taskListId" class="nui-datagrid" style=" width: 98%;height: 88%;display:none"  showPager="true"
		url="com.cjhxfund.fpm.bpsExpend.task.queryUnViewNoticeList.biz.ext" allowAlternating="true" sortField="arrivalTime" sortOrder="desc"
	    dataField="tasks" pageSize="20" >
	    <div property="columns">
	    	<div name="productName" field="productName" width="30%" headerAlign="center" allowSort="true" align="center"  renderer="outputTaskName">产品名称</div>
	    			    <div name="accountType" field="accountType" width="10%" headerAlign="center" align="center" allowSort="true" >账户类型</div>
		    <div name="processType" field="processType" width="10%" headerAlign="center" allowSort="true" align="center" renderer="processTypeAndFast">流程类型</div>
		    <div name="bussinessType" field="bussinessType" width="10%" headerAlign="center" align="center" allowSort="true" >业务类型</div>
			<div name="dealDevice"  field="dealDevice" width="10%" headerAlign="center" allowSort="true" align="center">状态</div>
			<div name="creator"  field="creator" width="15%" headerAlign="center" allowSort="true" align="center">提交人</div>
		    <div name="arrivalTime" field="arrivalTime" width="15%" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss" allowSort="true" align="center">到达时间</div>
		   
	    </div>
	</div>
	<div id="taskListId_1" class="nui-datagrid" style=" width: 98%;height: 88%;display:none"  showPager="true"
		url="com.cjhxfund.fpm.bpsExpend.task.queryUnViewNoticeList.biz.ext" allowAlternating="true" sortField="arrivalTime" sortOrder="desc"
	    dataField="tasks" pageSize="20" >
	    <div property="columns">
	    	<div name="productName" field="productName" width="40%" headerAlign="center" allowSort="true" align="center"  renderer="outputTaskName">产品名称</div>
		    <div name="processType" field="processType" width="20%" headerAlign="center" allowSort="true" align="center" renderer="processTypeAndFast">流程类型</div>
			<div name="dealDevice"  field="dealDevice" width="10%" headerAlign="center" allowSort="true" align="center">状态</div>
			<div name="creator"  field="creator" width="15%" headerAlign="center" allowSort="true" align="center">提交人</div>
		    <div name="arrivalTime" field="arrivalTime" width="15%" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss" allowSort="true" align="center">到达时间</div>
		   
	    </div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	
    	//任务列表
    	//var taskListDataGridObj = nui.get("taskListId");
    	var taskListDataGridObj = null;
    	doLoadTaskList();
    	
    		//加载是否显示账户类型
    	function isshowAccountType(){
    	     var acctStat= window.parent.getUserAuth();
			 //var gridColumn1=nui.get("taskListId").getColumn("accountType");
			 //var gridColumn2=nui.get("taskListId").getColumn("bussinessType");
    	     if(acctStat=="show"){
    	          //console.log("show");
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
	    		window.parent.refrushTaskNum("unViewNotice",taskListDataGridObj.totalCount);
			});
    	}
    	resizeDatagridHeight();
    	
    	$(window).bind("resize", resizeDatagridHeight);
    	// 自动调整datagrid的外部高度,撑满屏幕
    	function resizeDatagridHeight(){
    		var realheight = window.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight;
	    	realheight = realheight  + "px";
	    	var datagridObj = document.getElementById("taskListId");
	    	datagridObj.style.height=realheight;
    	}
    	
        //拼接是否加急
        function processTypeAndFast(e){
             var isfast = e.record.isFast;
             if(isfast!=null && isfast!=""){
                  return isfast+e.record.processType;
             }else{
                 return e.record.processType;
             }
        }
    
        //加载任务列表
        function doLoadTaskList() {
        	var  searchVal= window.parent.returnValue();
			nui.get("search1").setValue(searchVal);
			//var form = new nui.Form("#form1");
            //json = form.getData(false,false);
        	//taskListDataGridObj.load(json, function(res){
        		//if(res.exception) {
        		//	tfcToast.take("加载任务列表失败");
        		//}        		
        	//}, function() {
        	//	tfcToast.take("加载任务列表失败");
        	//});
        }
        function refreshTaskPage(){
        	var  searchVal= window.parent.returnValue();
			nui.get("search1").setValue(searchVal);
			var form = new nui.Form("#form1");
            json = form.getData(false,false);
            window.parent.refrushTaskNum("unViewNotice",taskListDataGridObj.totalCount);
        	taskListDataGridObj.load(json, function(res){
        	   if(res.exception) {
        			tfcToast.take("加载任务列表失败");
        		}        		
        	}, function() {
        		tfcToast.take("加载任务列表失败");
        	});
        }
    	//输出任务名称
    	function outputTaskName(e){
    	    var taskName = e.record.processInstName;
    		var taskShowName = e.record.productName;
    		var s = "";
            	s = s + '<a class="dgBtn"  style = "font-size: 9pt;" href="javascript:doOperate(' + e.row.taskId + ',\''+e.row.taskType+'\','+e.row.processInstID+',\'' + taskName + '\',\''+e.row.message+'\')">'+taskShowName+'</a> ';
            return s; 		
    	}

	    //执行操作
	    function doOperate(taskId,taskType,processInstID,title,message) {
	  	    var curTabId = '<b:write property="curTabId"/>';
	        var status = checkIsNewProcess(processInstID);
	    	//alert(status);
	    	if(status){
				if(processInstID=="-2"){    //流程实力ID为-2是交易单元通知
					tradeUnitNotice(taskId);
				} else if(processInstID=="-3") {  //流程实力ID为-3是只通知结果
					nui.alert("该产品已完成！", "通知", null);
					readonlyNotice(taskId);
				} else if(processInstID=="-4") {  //流程实力ID为-4是贡献收入归属部门通知
					nui.alert("该产品已修改产设贡献收入归属部门，流程需重新审批！", "通知", null);
					readonlyNotice(taskId);
				} else if(taskType=="ActivityInst") {  //公募用印通知
					openPrintPage(processInstID,title,taskId);
				} else {
	    			confirmNotice(taskId,processInstID,title);
				}
		   }else{
		       //旧流程
		       if(processInstID=="-2"){    //流程实力ID为-2是交易单元通知
					tradeUnitNoticeOld(taskId);
				} else if(processInstID=="-3") {  //流程实力ID为-3是只通知结果
					nui.alert("该产品已完成！", "通知", null);
					readonlyNoticeOld(taskId);
				} else if(processInstID=="-4") {  //流程实力ID为-4是贡献收入归属部门通知
					nui.alert("该产品已修改产设贡献收入归属部门，流程需重新审批！", "通知", null);
					readonlyNoticeOld(taskId);
				} else if(taskType=="ActivityInst") {  //公募用印通知
					openPrintPageOld(processInstID,title,taskId);
				} else {
	    			confirmNoticeOld(taskId,processInstID,title);
				}
		   }
		     refreshTaskPage();
	    }
	
	
		function confirmNotice(notificationID,processInstID,title) {			
			var data = {notificationID : notificationID};
			var json = nui.encode(data);//将数据转换成json格式
			nui.ajax({
					url : "com.cjhxfund.fpm.bpsExpend.notice.confrimNotification.biz.ext",
					type : 'POST',
					data : json,
					cache : false,
					contentType : 'text/json',
					success : function(text) {
					   window.parent.loadData();
					   doLoadTaskList();
					   var url = contextPath + "/com.cjhxfund.fpm.bpsExpend.getTaskInfo.flow?processInstID="+processInstID+"&pageType=taskList";
					   var curTabId = '<b:write property="curTabId"/>';
					   url += "&parTabId="+curTabId;
                       openTab("unViewInformation" + processInstID, "tab$unViewInformation$" + processInstID, title, url);			
					}
			});
		}
		
		function tradeUnitNotice(notificationID){
			var url = contextPath + "/com.cjhxfund.fpm.openAccount.getTradeUnitNotice.flow?inUrl=auditPage&notificationID="+notificationID;
			var data = {notificationID : notificationID};
			var json = nui.encode(data);//将数据转换成json格式
			nui.ajax({
					url : "com.cjhxfund.fpm.bpsExpend.notice.confrimNotification.biz.ext",
					type : 'POST',
					data : json,
					cache : false,
					contentType : 'text/json',
					success : function(text) {
						window.parent.loadData();
						window.location.href=url;
					}
			});
		}
		
		function readonlyNotice(notificationID){
			var data = {notificationID : notificationID};
			var json = nui.encode(data);//将数据转换成json格式
			nui.ajax({
				url : "com.cjhxfund.fpm.bpsExpend.notice.confrimNotification.biz.ext",
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
				    window.parent.loadData();
					nui.get("taskListId").load();
				}
			});
		}
		
	    //公募用印通知展示
	    function openPrintPage(processInstID,title,notificationID){
	    	var bizType = "";
	    	if(title.indexOf("公募合同审核用印")>-1) bizType = "pubSeal";
	    	else if(title.indexOf("公募注册")>-1) bizType = "pubReg";
	    	var setHeight = window.screen.availHeight-40+"px";
	    	var setWidth = window.screen.availWidth-20+"px";
	    	
	    	var data = {notificationID : notificationID};
			var json = nui.encode(data);//将数据转换成json格式
			nui.ajax({
				url : "com.cjhxfund.fpm.bpsExpend.notice.confrimNotification.biz.ext",
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
				    window.parent.loadData();
					nui.get("taskListId").load();
			    	 window.open(contextPath+"/com.cjhxfund.fpm.design.getPubInfoForSeal.flow?processInstID="+processInstID
			    	 +"&bizType="+bizType, "newwindow", "height="+setHeight+", width="+setWidth
			    	 +", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, status=no");
				}
			});
	    }
			/////////////////////////////////////  old  ////////////////////////////////
		function confirmNoticeOld(notificationID,processInstID,title) {			
			var data = {notificationID : notificationID};
			var json = nui.encode(data);//将数据转换成json格式
			nui.ajax({
					url : "com.cjhxfund.fpm.bpsUtil.notice.confrimNotification.biz.ext",
					type : 'POST',
					data : json,
					cache : false,
					contentType : 'text/json',
					success : function(text) {
					   window.parent.loadData();
					   doLoadTaskList();
					   var url = contextPath + "/com.cjhxfund.fpm.util.getTaskInfo.flow?processInstID="+processInstID+"&pageType=taskList";
					   var curTabId = '<b:write property="curTabId"/>';
					   url += "&parTabId="+curTabId;
                       openTab("unViewInformation" + processInstID, "tab$unViewInformation$" + processInstID, title, url);					
					}
			});
		}
		
		function tradeUnitNoticeOld(notificationID){
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
						window.parent.loadData();
						window.location.href=url;
					}
			});
		}
		
		function readonlyNoticeOld(notificationID){
			var data = {notificationID : notificationID};
			var json = nui.encode(data);//将数据转换成json格式
			nui.ajax({
				url : "com.cjhxfund.fpm.bpsUtil.notice.confrimNotification.biz.ext",
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
				    window.parent.loadData();
					nui.get("taskListId").load();
				}
			});
		}
		
	    //公募用印通知展示
	    function openPrintPageOld(processInstID,title,notificationID){
	    	var bizType = "";
	    	if(title.indexOf("公募合同审核用印")>-1) bizType = "pubSeal";
	    	else if(title.indexOf("公募注册")>-1) bizType = "pubReg";
	    	var setHeight = window.screen.availHeight-40+"px";
	    	var setWidth = window.screen.availWidth-20+"px";
	    	
	    	var data = {notificationID : notificationID};
			var json = nui.encode(data);//将数据转换成json格式
			nui.ajax({
				url : "com.cjhxfund.fpm.bpsUtil.notice.confrimNotification.biz.ext",
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
				    window.parent.loadData();
					nui.get("taskListId").load();
			    	 window.open("<%=request.getContextPath() %>/com.cjhxfund.fpm.design.getPubInfoForSeal.flow?processInstID="+processInstID+"&bizType="+bizType, "newwindow", "height="+setHeight+", width="+setWidth+", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, status=no");
				}
			});
	    }
	    /////////////////////////////////////////////////end/////////////////////////////////////////////////////
		function search(json){
            taskListDataGridObj.load(json);//grid查询
		}
    </script>
</body>
</html>
