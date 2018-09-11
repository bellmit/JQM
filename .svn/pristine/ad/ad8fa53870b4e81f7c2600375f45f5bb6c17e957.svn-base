<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的流转任务</title>
<%@include file="/bpsExpend/common/common.jsp"%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>

<body style="width: 98%; height: 100%; overflow: hidden" class="body-font" onload="isshowAccountType()">
 	<div id="form1" class="nui-form" align="center" style="display: none;">
		<table id="table1" class="table" style="height: 100%; width: 100%">
			<tr  style="width: 100%;">
				<td colspan="1" align="right" class="form_label" style="text-align:right;width:10%;">任务检索关键字</td>
				<td colspan="1" align="center" style="width:80%;">
					<input class="nui-hidden" id="search2" name="criteriaMap"/>
				</td>
			</tr>
		</table>
	</div>

	<div id="taskListId" class="nui-datagrid bpsDatagrid" style="width:100%;height:98%;display:none" showPager="true" 
		url="com.cjhxfund.fpm.bpsExpend.task.queryRunningTaskList.biz.ext" allowAlternating="true" sortField="lastendtime" sortOrder="desc"
		dataField="tasks" pageSize="20" onrowclick="gridVisible" >
		<div property="columns">
			<div name="productname" field="productname" width="25%" headerAlign="center" allowSort="true" align="center" renderer="outputTaskName">产品名称</div>
			<div name="accountType" field="accountType" width="10%" headerAlign="center" align="center" allowSort="true" >账户类型</div>
		    <div name="processType" field="processType" width="10%" headerAlign="center" allowSort="true" align="center" renderer="getProcTypeDict">流程类型</div>
		    <div name="bussinessType" field="bussinessType" width="10%" headerAlign="center" align="center" allowSort="true" >业务类型</div>
			<div name="activityinstname" field="activityinstname" width="10%" headerAlign="center" allowSort="false" align="center">当前环节</div>
			<div name="participantname" field="participantname" width="10%" headerAlign="center" allowSort="false" align="center">当前参与人</div>
			<div name="creator" field="creator" width="10%" headerAlign="center" allowSort="true" align="center">提交人</div>
		    <div name="lastendtime" field="lastendtime" width="15%" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss" align="center" allowSort="true">最后处理时间</div>
		
		</div>
	</div>
	<div id="taskListId_1" class="nui-datagrid bpsDatagrid" style="width:100%;height:98%;display:none" showPager="true" 
		url="com.cjhxfund.fpm.bpsExpend.task.queryRunningTaskList.biz.ext" allowAlternating="true" sortField="lastendtime" sortOrder="desc"
		dataField="tasks" pageSize="20" onrowclick="gridVisible" >
		<div property="columns">
			<div name="productname" field="productname" width="40%" headerAlign="center" allowSort="true" align="center" renderer="outputTaskName">产品名称</div>
		    <div name="processType" field="processType" width="15%" headerAlign="center" allowSort="true" align="center" renderer="getProcTypeDict">流程类型</div>
			<div name="activityinstname" field="activityinstname" width="10%" headerAlign="center" allowSort="false" align="center">当前环节</div>
			<div name="participantname" field="participantname" width="10%" headerAlign="center" allowSort="false" align="center">当前参与人</div>
			<div name="creator" field="creator" width="10%" headerAlign="center" allowSort="true" align="center">提交人</div>
		    <div name="lastendtime" field="lastendtime" width="15%" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss" align="center" allowSort="true">最后处理时间</div>
		
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
		nui.parse();
		//任务列表
		//var taskListDataGridObj = nui.get("taskListId");
		var taskListDataGridObj=null;
		doLoadTaskList();

		resizeDatagridHeight();
		$(window).bind("resize", resizeDatagridHeight);

        //加载是否显示账户类型
    	function isshowAccountType(){
    	     var acctStat= window.parent.getUserAuth();
    	    // console.log(acctStat);
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
	    		window.parent.refrushTaskNum("runningProcess",taskListDataGridObj.totalCount);
			 });
    	}
		//加载任务列表
		function doLoadTaskList() {
			var  searchVal= window.parent.returnValue();
			nui.get("search2").setValue(searchVal);
			//var form = new nui.Form("#form1");
            //json = form.getData(false,false);
			//taskListDataGridObj.load(json, function(res) {
				//if (res.exception) {
				//	tfcToast.take("加载任务列表失败");
			//	}
			//}, function() {
			//	tfcToast.take("加载任务列表失败");
			//});
		}

		// 自动调整datagrid的外部高度,撑满屏幕
    	function resizeDatagridHeight(){
    		var realheight = window.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight;
	    	realheight = realheight  + "px";
	    	var datagridObj = document.getElementById("taskListId");
	    	datagridObj.style.height=realheight;
    	}
    	//输出任务名称
    	function outputTaskName(e){
			var s = "";
			var taskName = e.record.processinstname;
    	    var taskShowName = e.record.productname;
			s += '<a class="dgBtn" href="javascript:doOperate(' + e.row.processinstid + ',\'' + taskName + '\')">' + taskShowName + '</a> ';
			return s;
    	}
		//操作
		function onActionRenderer(e) {
			var lastendtime = nui.formatDate (e.row.lastendtime, "yyyy-MM-dd HH:mm:ss");
			var s = "";
			s += '<img src="'+contextPath+'/bpsExpend/task/img/task.gif"></img>';
			var taskName = e.record.processinstname;
    		var taskArr = taskName.split("--");
    		var taskShowName = "";
			for(var i=0;i<taskArr.length;i++){
    		   if(taskArr.length>1&i>taskArr.length-2){
    		   		taskShowName += '--<font color="red" style = "font-size: 11pt;">'+taskArr[i]+'</font>';
    		   }else if(taskArr.length>2&i>taskArr.length-3){
    		   		taskShowName += '--<font color="green" style = "font-size: 10pt;">'+taskArr[i]+'</font>';
    		   }else{
    		   		taskShowName += '<font color="blue">'+taskArr[i]+'</font>';
    		   }
    		}
			
			s += '<a class="dgBtn" href="javascript:doOperate(' + e.row.processinstid + ',\'' + taskName + '\')">' + taskShowName + '</a> ';
			s += '(当前环节:'+e.record.activityinstname+';&nbsp&nbsp当前参与人:<font color="red">'+e.record.participantname+'</font>';
			s += ';&nbsp&nbsp提交人:'+e.row.creator+';&nbsp&nbsp最后处理时间:'+lastendtime+')';
			return s;
		}
		     //从数据字典中获取流程类型
        function getProcTypeDict(e){
           var procType = e.row.processType;
           //console.log(e.row.processType+" : "+e.row.productname);
            var isfast = e.record.isFast;
            if(isfast!=null && isfast!=""){
                  return isfast+nui.getDictText("PM_PROC_TYPE",procType);
            }else{
                 return nui.getDictText("PM_PROC_TYPE",procType);
            }
        }
		//执行操作 
		function doOperate(processInstID, title) {
			var url = contextPath + "/com.cjhxfund.fpm.bpsExpend.getTaskInfo.flow?processInstID=" + processInstID+"&pageType=runPage";
			var curTabId = '<b:write property="curTabId"/>';
			var status = checkIsNewProcess(processInstID);
			var url="";
	    	//alert(status);
	    	if(status){
	    	    //alert(status);
	    	    url = contextPath + "/com.cjhxfund.fpm.bpsExpend.getTaskInfo.flow?processInstID=" + processInstID+"&pageType=runPage";
			    url += "&parTabId="+curTabId;
			}else{
			    url = contextPath + "/com.cjhxfund.fpm.util.getTaskInfo.flow?processInstID=" + processInstID+"&pageType=runPage";
			    url += "&parTabId="+curTabId;
			}
			//打开为TAB页 使用commonUtil中的方法
			openTab("runningTask" + processInstID, "tab$runningTask$" + processInstID, title, url);
		}
		
		function search(json){
            taskListDataGridObj.load(json);//grid查询
		}
		
		
		function getGrids(){
			var data=taskListDataGridObj.getSelected();
			return data;
		}
		
		//根据流程的状态
		function gridVisible(e){
			var data=taskListDataGridObj.getSelected();
			var taskObj={taskObj:data};
			var json=nui.encode(taskObj);
			nui.ajax({
				url : "com.cjhxfund.fpm.bpsExpend.opinion.queryAskForOpinios.biz.ext",
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					var resJson=nui.decode(text);
					if(resJson.exception == null || resJson.exception=="undefined"){
						if(resJson.resultFlag==1){
							window.parent.setEnabledToTrue();
						}else{
							window.parent.setEnabledToFalse();
						}
					}
				}
			});
		}
</script>