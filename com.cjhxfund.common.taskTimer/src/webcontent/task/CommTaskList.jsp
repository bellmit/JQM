<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page pageEncoding="UTF-8"%>

<%@include file="/common/common.jsp" %>
<!-- 引入表单框架jsp -->
<html>
<head>
<title>Title</title>
<h:script src="/taskTimer/taskjs/schedule.js" />
<style>
	
	.mini-grid-row:nth-child(odd){
      background: #ffffff;
   }
</style>
</head>
<body style="margin: 0;width: 100%;height:100%;">
	<table style="width:100%;height:99%;">
		<tr style="width:100%;">
			<td valign="top" style="height:100%;" >
				<!--查询任务调度开始-->
				<div class="nui-panel" title="任务调度查询" style="width:100%;height:100%;" showToolbar="false" showCollapseButton="true" showFooter="true" allowResize="false" >
					<div id="querytask">
						<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.taskTimer.dataTask.TCommSysDispatchTask"/>
						<input class="nui-hidden" name="criteria/_orderby[2]/_property" value="lId"/>
						<input class="nui-hidden" name="criteria/_orderby[2]/_sort" value="asc" />
						<input class="nui-hidden" name="criteria/_orderby[1]/_property" value="vcFkType"/>
						<input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="desc" />
						<input class="nui-hidden" name="page/isCount" value="true" />
						<input class="nui-hidden" name="page/count" value="-1" />
						
						<table>
							<tr>
								<td align="right">任务名称：</td>
								<td align="left">
									<input class="nui-textbox" name="criteria/_expr[1]/vcTaskNameShow"  onenter="onKeyEnter"/>
									<input class="nui-hidden" name="criteria/_expr[1]/_op" value="like"/>
								</td>
								<td>
									<a class="nui-button mini-button-red" iconCls="icon-search" onclick="searchtask()" >查询</a>
								</td>
							</tr>
						</table>
					</div>
					<!--查询结束-->
					<!--按钮开始-->
					<div class="nui-toolbar">
						<table width="100%">
							<tr>
								<td>
									<a class="mini-button" iconCls="icon-add" onclick="addtask()">增加</a>
									<a class="mini-button" iconCls="icon-edit" onclick="edittask()"  id="update">编辑</a>
									<a class="mini-button" iconCls="icon-remove" onclick="removetask()">删除</a>
								</td>
							</tr>
						</table>
					</div>
					<!--按钮结束-->
					<!--列表开始-->
					<div class="nui-fit">
						<div id="taskdatagrid" style="width: 100%;height:100%;" class="nui-datagrid"
						url="com.cjhxfund.ats.taskTimer.CommTask.queryTaskList.biz.ext"
						dataField="dispatchtasks"
						showPager="true"
						pageSize="100"
						multiSelect="true"
						onselectionchanged="onloadtimer"
						allowResize="true"
						idField="lId"
						allowSortColumn="false"
						showColumnsMenu="true" 
						 onrowdblclick="dbedittask" 
						 >
							<div property="columns">
								<div type="checkcolumn" width="20"></div>
								<div field="lId" allowSort="true" headerAlign="center"  visible="false">任务主键</div>
								<div field="vcFkType" allowSort="true" headerAlign="center" width="80" align="center"  autoEscape="true">任务类型</div>
								<div field="vcCheck"    headerAlign="center" align="center"  autoEscape="true"  allowSort="true" renderer="changecron">是否监控</div>
								<div field="vcTaskCode" allowSort="true" headerAlign="center" width="80" align="center"  autoEscape="true">任务编号</div>
								<div field="vcTaskNameShow" allowSort="true" headerAlign="center" align="center"  autoEscape="true">任务名称</div>
							</div>
						</div>
					</div>
					<!--列表结束-->
				</div>
			</td>
	
		
			<td valign="top" style="width:50%;height:100%;" >
				<!--查询定时器开始-->
					<form id="querytimer" method="post">
						<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.taskTimer.dataTask.TCommSysTimer"/>
						<input class="nui-hidden" name="criteria/_orderby[1]/_property" value="lTimerId"/>
						<input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc">
						<input class="nui-hidden" name="page/isCount" value="true" />
						<input class="nui-hidden" name="page/count" value="-1" />
						<input class="nui-hidden" name="criteria/_expr[1]/lTaskId" id="taskId" /><!--任务调度主键-->
						<input class="nui-hidden" name="criteria/_expr[1]/_op" value="="/>
					</form>
					<!--查询定时器结束-->
					<!--按钮开始-->
					<div class="nui-toolbar" >
						<table width="100%">
							<tr>
								<td>
									<a class="mini-button" id="oms_addtime" iconCls="icon-add" onclick="addtime()">增加</a>
									<a class="mini-button" iconCls="icon-edit" onclick="edittime()"  id="timerUpdate">编辑</a>
									<a class="mini-button" iconCls="icon-remove" onclick="removetimer()">删除</a>
									<a class="mini-button" iconCls="icon-downgrade" onclick="jxdsq('1')">继续</a>
									<a class="mini-button" iconCls="icon-close"      onclick="jxdsq('2')">停止</a>
									<a class="mini-button" iconCls="icon-ok"      onclick="runNow()">立即执行</a>
								</td>
							</tr>
						</table>
					</div>
					<!--按钮结束-->
					<!--列表开始-->
					<div class="nui-fit">
						<div id="timerdatagrid" style="width: 100%;height:100%;" class="nui-datagrid"
						url="com.cjhxfund.ats.taskTimer.CommTimer.queryTimerList.biz.ext"
						onselectionchanged="selectionChanged"
						dataField="timers"
						showPager="true"
						pageSize="10"
						multiSelect="true"
						allowResize="true"
						onload="onloadtimerself"
						idField="timerId"
						showColumnsMenu="true" 
						allowSortColumn="true"
						 onrowdblclick="dbedittime">
							<div property="columns" >
								<div type="checkcolumn" width="20"></div>
								<div field="lTimerId" allowSort="true" headerAlign="center"  visible="false" autoEscape="true">定时器主键</div>
								<div field="vcTaskName" allowSort="true" headerAlign="center" width="80" align="center" autoEscape="true">定时器名称</div>
								<div field="vcCronExpression" allowSort="true" headerAlign="center" renderer="changecron"  align="center"  autoEscape="true">表达式</div>
								<div field="vcTimerRunType" allowSort="true" headerAlign="center" width="40" renderer="changecron" align="center"  autoEscape="true">状态</div>
							</div>
						</div>
						<!--列表结束-->
					</div>
			</td>
			
		</tr>
	</table>
</body>
<script type="text/javascript">
	nui.parse();
	//查询任务
	searchtask();
	
	function onKeyEnter(e) {
		searchtask();
	}
	
	//定义全局变量
	var pageType="";//页面类型：add,edit
	var taskId = "";//任务ID
	//获取页面类型，提供子页面调用
	function getPageType(){
		return pageType;
	}
	//获取任务id，提供子页面调用
	function getTaskId(){
		return taskId;
	}
	//获取定时器的列表对象，提供子页面调用
	function getDataGrid(){
		return nui.get("timerdatagrid");
	}
	
	//任务调度
	var taskdatagr = nui.get("taskdatagrid");
	//定时器
	var timerdatagr = nui.get("timerdatagrid");
	
	function selectionChanged() {
		var rows = timerdatagr.getSelecteds();
		if (rows.length > 1) {
			nui.get("timerUpdate").disable();
		} else {
			nui.get("timerUpdate").enable();
		}
	}

	//查询任务调度
	function searchtask() {
		var taskdatagr = nui.get("taskdatagrid");
		var formData = new nui.Form("querytask").getData(false, false);
		//alert(formData);
		taskdatagr.load(formData);
	}

	//任务列表加载完后默认选中第一个，并清除定时器列表内容
	function onloadtaskself(e) {//加载第一个
		if (e.data[0] != null) {
			var grid = e.sender;
			if (grid.getSelecteds().length == 0) {
				grid.select(grid.getRow(0));
			}
		}
		timerdatagr.clearData();//清除定时器的内容
	}

	//选中任务时触发加载定时器列表内容
	function onloadtimer(e) {
		//debugger;
		var timerdatagr = nui.get("timerdatagrid");
		var grid = e.sender;
		var record = grid.getSelected();
		var len = nui.get("taskdatagrid").getSelecteds().length;
		var lId = "0";
		if (len >= 2 || len == 0) {
			lId = "0000";
		} else {
			lId = record.lId;
		}
		nui.get("taskId").setValue(lId);

		timerdatagr.clearData();//清除定时器的内容
		searchtimer();

		var rows = grid.getSelecteds();
		if (rows.length > 1) {
			nui.get("update").disable();
		} else {
			nui.get("update").enable();
		}
	}
	nui.parse();
	//新增任务调度
	function addtask() {
		nui.open({
			url : "<%=request.getContextPath()%>/taskTimer/task/editTaskForm.jsp",
			title: "新增记录", width: 600, height: 700,
			onload: function (){//弹出页面加载完成
				var iframe = this.getIFrameEl();
				var data = {pageType:"add"};//传入页面的json数据
				iframe.contentWindow.setFormData(data);
			},
			ondestroy: function (action){//弹出页面关闭前
				searchtask();//调用任务查询方法加载任务列表数据
			}
		});
	}
	
	function dbedittask(){
    	 var row = taskdatagr.getSelected();
    	 if(row!=null){
    	 	edittask();
    	 }
    }
	//修改任务调度
	function edittask(){
		var taskdatagrid = nui.get("taskdatagrid");//获取任务列表对象
		var row = taskdatagrid.getSelected();//获取选中的任务
		if(row){
			//remind：提醒项 ；monitor：监控项；（这两个定时器不允许修改）
			if(row.vcFkType=="提醒项" || row.vcFkType=="监控项"){
				//nui.alert(row.vcFkType+" 为系统配置的任务，请不要修改","系统提示");
				nui.alert("该记录为系统配置任务,请勿操作！","系统提示");
				return;
			}
			nui.open({
				url: "<%=request.getContextPath()%>/taskTimer/task/editTaskForm.jsp",
				title: "新增记录", width: 600, height: 700,
				onload: function (){//弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {pageType:"edit",record:{task:row}};
					iframe.contentWindow.setFormData(data);//调用子页面的方法并传递参数
				},
				ondestroy: function (action){
					taskdatagrid.reload();//重新加载任务列表
				}
			});
		}else{
			nui.alert("请选择一行任务记录","系统提示");
		}
	}
	
	//删除任务调度
	function removetask(){
		var taskdatagrid = nui.get("taskdatagrid");//获取任务列表对象
		var rows = taskdatagrid.getSelecteds();//获取选中的任务记录
		if(rows){
			//remind：提醒项 ；monitor：监控项；（这两个定时器不允许修改）
			var falg = true;
			for(var i=0;i<rows.length;i++){
				var row = rows[i];
				if(row.vcFkType=="提醒项" || row.vcFkType=="监控项"){
					falg = true;
					break;
				}else{
					falg = false;
				}
			}
			if(falg){
				nui.alert("选中的记录中包含了系统配置的任务，请不要删除任务类型为 “remind”和“monitor”和“system” 的记录","系统提示");
				return;
			}
			
			nui.confirm("即将删除任务调度以及下级所有信息，确定删除选中记录？","系统提示",
				function(action){
					if(action=="ok"){
						var json = nui.encode({tasktables:rows});
						taskdatagrid.loading("正在删除中,请稍等...");
						$.ajax({
							url:"com.cjhxfund.ats.taskTimer.CommTask.deleteTask.biz.ext",
							type:'POST',data:json,cache: false,contentType:'text/json',
							success:function(text){
								 var returnJson = nui.decode(text);
								 if(returnJson.exception == null){
								 	taskdatagrid.reload();
								 	nui.alert("删除成功", "系统提示");
								 	searchtimer();
								 }else{
								 	moduledatagr.unmask();
								 	nui.alert("删除失败", "系统提示");
								 }
							}
						});
					}
				}
			);
		}else{
			nui.alert("请选中要删除的任务","系统提示");
		}
	}
	
	//定时器的datagrid
	//查询定时器
	function searchtimer(){
		var timerdatagr = nui.get("timerdatagrid");
		var formData = new nui.Form("querytimer").getData(false,false);
		timerdatagr.load(formData);
	}
	//默认选中第一个定时器
	function onloadtimerself(e){
		if(e.data[0] != null) {
			var grid = e.sender;
			if (grid.getSelecteds().length==0 ){
				grid.select(grid.getRow(0));
			}	
		}
	}
	
	//暂停、继续定时器
	function jxdsq(type){
		var taskrow = taskdatagr.getSelected();
		if(taskrow.vcFkType=="提醒项" || taskrow.vcFkType=="监控项"){
			//nui.alert(taskrow.vcFkType+" 为系统配置的任务，请不要在这个任务下添加定时器","系统提示");
			nui.alert("该记录为系统配置任务,请勿操作！","系统提示");
			return;
		}
		var timerdatagrid = nui.get("timerdatagrid");
		
		var rows = timerdatagrid.getSelecteds();
		var timerId =  "";
		var len = rows.length;
		for(var ii=0;ii<parseInt(len);ii++){
			timerId+=rows[ii].lTimerId+",";
		}
		var data = {"timerId":timerId,"type":type};
		var url = "com.cjhxfund.ats.taskTimer.CommTimer.updateTimerState.biz.ext";
		var json = nui.encode(data);
		mini.mask({
             el: document.body,
             cls: 'mini-mask-loading',
             html: '执行中,请稍等...'
        }); 
		$.ajax({
			url: url,
            type: 'POST',data: json,cache: false,contentType:'text/json',
            success: function (text) {
                var statu = nui.decode(text).statu;
                if(statu==3){
                	nui.alert("没有找到定时器，请联系管理员","系统提示");	
                	searchtimer();
                }else{
                	searchtimer();
                }
                 mini.unmask();
            },
            error: function (jqXHR, textStatus, errorThrown) {
                nui.alert("系统出错，请联系管理员解决","系统提示");
            }
		});
	}
	//直接执行定时器
	function runNow(){
		
		//获取定时任务选中的记录
		var taskrow = taskdatagr.getSelecteds();
		//只允许选中一行定时任务
		if(!taskrow || taskrow.length!=1){
			nui.alert("请选中一行任务","系统提示");
			return;
		}		
		//获取定时器列表
		var timerdatagrid = nui.get("timerdatagrid");
		//获取定时器选中的记录
		var timerRows = timerdatagrid.getSelecteds();
		debugger;
		//只允许选中一行定时器记录
		if(!timerRows || timerRows.length!=1){
			nui.alert("请选择一行定时器","系统提示");
			return;
		}else{
			var url = taskrow[0].vcTargetQname+"."+taskrow[0].vcTargetOperation+".biz.ext";
			var json = nui.encode({timerId:timerRows[0].vcTaskName});
			console.info("手动执行定时器: ===> "+url);
			$.ajax({
				url: url,
	            type: 'POST',data: json,cache: false,contentType:'text/json',
	            success: function (text) {
	                var returnJson = nui.decode(text);
	                if(returnJson.exception == null){
	                	nui.alert("执行成功","系统提示");
	                }else{
	                	nui.alert("执行失败","系统提示");
	                }
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                nui.alert("系统出错，请联系管理员解决","系统提示");
	            }
			});
		}
	}
	nui.parse();
	//添加定时器
	function addtime(){
		var taskrow = taskdatagr.getSelected();
		if(taskrow.vcFkType=="提醒项" || taskrow.vcFkType=="监控项"){
			//nui.alert(taskrow.vcFkType+" 为系统配置的任务，请不要在这个任务下添加定时器","系统提示");
			nui.alert("该记录为系统配置任务,请勿操作！","系统提示");
			return;
		}
		taskId = nui.get("taskId").getValue();
		pageType = "add";
		if(taskId==""){
			nui.alert("请选择任务调度...","系统提示");
			return ;
		}
		nui.open({
			url: "<%=request.getContextPath()%>/taskTimer/task/editTimerForm.jsp",
			title: "配置定时器", width: 700, height: 400,
			onload: function (){},
			ondestroy: function (action){//弹出页面关闭前
				searchtimer();
			}
		});
	}
	
	
	function dbedittime(){
    	 var row = timerdatagr.getSelected();
    	 if(row!=null){
    	 	edittime();
    	 }
    }
	//修改定时器
	function edittime(){
		var taskrow = taskdatagr.getSelected();
		if(taskrow.vcFkType=="提醒项" || taskrow.vcFkType=="监控项"){
			//nui.alert(taskrow.vcFkType+" 为系统配置的任务，请不要修改这个任务下的定时器","系统提示");
			nui.alert("该记录为系统配置任务,请勿操作！","系统提示");
			return;
		}
		taskId = nui.get("taskId").getValue();
		pageType = "edit";
		if(taskId==""){
			nui.alert("请选择任务调度...","系统提示");
			return ;
		}
		var row = timerdatagr.getSelecteds();
		if(row.length==1){
			nui.open({
	            url: "<%=request.getContextPath()%>/taskTimer/task/editTimerForm.jsp",
	            title: "编辑数据",width: 700,height: 400,
				onload: function () {},
				ondestroy: function (action) {
					timerdatagr.reload();
				}
			});
		}else{
			nui.alert("请选中一条记录","提示");
        }
	}
	
	//删除定时器
	function removetimer(){//debugger;
		var taskrow = taskdatagr.getSelected();
		if(taskrow.vcFkType=="提醒项" || taskrow.vcFkType=="监控项"){
			//nui.alert(taskrow.vcFkType+" 为系统配置的任务，请不要删除这个任务下的定时器","系统提示");
			nui.alert("该记录为系统配置任务,请勿操作！","系统提示");
			return;
		}
		var timerdatagrid = nui.get("timerdatagrid");
		var taskId = nui.get("taskId").getValue();
		var rows = timerdatagrid.getSelecteds();
		if(rows){
			nui.confirm("即将删除定时器信息，确定删除选中记录？","系统提示",
			function(action){
				if(action=="ok"){
					var json = nui.encode({taskId:taskId,timertables:rows});
					timerdatagrid.loading("正在删除中,请稍等...");
					$.ajax({
						url:"com.cjhxfund.ats.taskTimer.CommTimer.deleteTimerTask.biz.ext",
						type:'POST',
						data:json,
						cache: false,
						contentType:'text/json',
						success:function(text){
							 var returnJson = nui.decode(text);
							 if(returnJson.exception == null){
							 	timerdatagrid.reload();
							 	nui.alert("删除成功", "系统提示", function(action){});
							 }else{
							 	timerdatagrid.unmask();
							 	nui.alert("删除失败", "系统提示");
							 }
						}
					});
				}
			});
		
		}
	}
	//转换表达式
	function changecron(e){
		var crontext="";
		//转换定时器运行状态
		if(this.field=="vcTimerRunType"){
			if(e.row.vcTimerRunType == '0'){
				crontext = "正常";
			}else if(e.row.vcTimerRunType == '1'){
				crontext = "暂停";
			}
		}
		if(this.field=="vcCheck"){
			crontext = nui.getDictText("COMM_IS_CHECK",e.row.vcCheck);//是否监控
		}
		//转换表达式
		if(this.field=="vcCronExpression"){
			var value = e.row.vcCronExpression;//表达式
			var schedule = new Schedule(value);//实例化定时任务对象
			var day = schedule.day.toText();//天
			var week = schedule.week.toText();//周
			var month = schedule.month.toText();//月
			var shijian = "";//时间
			var vcBegin = e.row.vcBegin;
			var vcEnd = e.row.vcEnd;
			if(e.row.vcTriggerType=="0"){
				shijian =vcBegin+" 执行";
			}else{
				shijian =vcBegin+":00 到 "+vcEnd+":00 每"+e.row.vcFrequency+"分钟执行一次";
			}
			
			if(day=="*" && month=="*"&&week=="?"){
				crontext = "每天 "+shijian;
			}
			if(day=="?" && week!="*" && month=="*"){
				if(week.indexOf("#")>0||week.indexOf("L")>0){
					crontext="每月: "+day+"日 "+shijian;
				}else{
					var nowweek = setWeek(schedule.week.toText());
					crontext="每周: "+nowweek+" "+shijian;
				}
			}
			if(day!="*" && week=="?" && month=="*"){
				crontext="每月: "+day+"日 "+shijian;
			}
			if(month!="*"){
				crontext="每年: "+month+"月"+day+"日 "+shijian;
			}
		}
		return crontext;
	}
	//通过参数查找具体是星期几
	function setWeek(weekText){
		var nowweek = "";
		if(weekText.indexOf(1)>=0){
			nowweek = nowweek+"星期天 ";
		}
		if(weekText.indexOf(2)>=0){
			nowweek = nowweek+"星期一 ";
		}
		if(weekText.indexOf(3)>=0){
			nowweek = nowweek+"星期二 ";
		}
		if(weekText.indexOf(4)>=0){
			nowweek = nowweek+"星期三 ";
		}
		if(weekText.indexOf(5)>=0){
			nowweek = nowweek+"星期四 ";
		}
		if(weekText.indexOf(6)>=0){
			nowweek = nowweek+"星期五 ";
		}
		if(weekText.indexOf(7)>=0){
			nowweek = nowweek+"星期六 ";
		}
		return nowweek;
	}
	
	taskdatagr.on("drawcell", function (e) {
	        var record = e.record;//记录
	        if (record.vcFkType=="提醒项" || record.vcFkType=="监控项") {
                     e.cellStyle = "background:#ecedef";
	        } 
            
       });
       
    
	
	
</script>
</html>