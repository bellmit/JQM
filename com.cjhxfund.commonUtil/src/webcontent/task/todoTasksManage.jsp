<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 程弼超
  - Date: 2016-10-27 08:47:31
  - Description: 待办任务管理界面
-->
<head>
<title>待办任务管理</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
	<!-- |查询条件开始 -->
	<div class="search-condition">
		<div class="list">
			<div id="task_condition" class="nui-form" style="padding:2px;height:10%;" align="left">
				<table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
 					<tr>
						<td width="60px" align="right">
							产品名称:
						</td>
						<td align="left">
							<input name="task/VC_PRODUCT_CODE" class="nui-combobox" id="fundCodeName"
							textField="TEXT" valueField="ID"
							url="com.cjhxfund.commonUtil.applyInstUtil.queryTAtsProductInfo.biz.ext?queryType=1"
							showNullItem="false"
							emptyText="全部"
							nullItemText="全部"
							valueFromSelect="true"
							showClose="true"
							oncloseclick="onCloseClickValueEmpty"
							onvaluechanged="selectFund()"
							width="95%"/>
						</td>
						<td width="60px" align="right">
							产品组合:              
						</td>
						<td align="left">
							<input name="task/VC_COMBI_NAME" class="nui-combobox" id="vcCombi"
							textField="TEXT" valueField="ID"
							dataField="data"
							url="com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfo.biz.ext?queryType=1"
							showNullItem="false"
							emptyText="全部"
							nullItemText="全部"
							valueFromSelect="true"
							showClose="true"
							oncloseclick="onCloseClickValueEmpty"
							width="95%"/>
						</td>
						<td width="60px" align="right">
							任务类别:
						</td>
						<td align="left">
							<input name="task/VC_PROCESS_TYPE" class="nui-dictcombobox" dictTypeId="ATS_TASK_BIZ_TYPE" 
							showNullItem="false"
							emptyText="全部"
							nullItemText="全部"
							multiSelect="true"
							valueFromSelect="true"
							showClose="true"
							oncloseclick="onCloseClickValueEmpty"
							width="95%"/>
						</td>
						<td width="60px" align="right">
							任务名称:
						</td>
						<td align="left">
							<input name="task/WORKITEMNAME" class="nui-textbox" width="95%"/>
						</td>
						<td width="60px" align="right">
							任务描述:
						</td>
						<td align="left">
							<input name="task/VC_ABSTRACT" class="nui-textbox" width="95%"/>
						</td>
					</tr>
					<tr>
						<td width="60px" align="right">
							参与人:
						</td>
						<td align="left">
							<input name="task/PARTINAME" class="nui-textbox" width="95%"/>
						</td>
						<td colspan="8" align="left">
							<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search"/>
							<input class='nui-button' plain='false' text="重置" iconCls="icon-reset" onclick="reset"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 查询条件结束| -->
	<!-- |工具栏开始  -->
	<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
		<table style="width:100%;">
			<tr>
				<td style="width:100%;">
					<a class='nui-button' plain='false' iconCls="icon-ok" onclick="batchConfirm" id="batchConfirm">
						批量确认
					</a>
					<a class='nui-button' plain='false' iconCls="icon-find" onclick="viewFlowChart" id="viewFlowChart">
						查看流程
					</a>
					<a class='nui-button' plain='false' iconCls="icon-user" onclick="changeParticipant" id="changeParticipant">
						改派任务
					</a>
				</td>
			</tr>
		</table>
	</div>
	<!-- 工具栏结束|  -->
	<!-- |列表开始  -->
	<div class="nui-fit">
		<div class="nui-datagrid" id="datagrid_tasks" 
		url="com.cjhxfund.commonUtil.taskManager.queryTasks.biz.ext?stateType=1" 
		dataField="tasks"
		allowResize="true"
		idField="WORKITEMID"
		pageSize="30"
		sizeList="[20,30,50,100]" 
		showPager="true"
		multiSelect="true"
		allowSortColumn="true"
		sortField="CREATETIME"
		sortOrder="DESC"
		onSelectionChanged="selectionChanged"
		style="width:100%;height:100%;"
		>
			<div property="columns">
				<div type="indexcolumn" headerAlign="center" align="center" width="11px">
					#
				</div>
				<div type="checkcolumn" width="11px"></div>
				<div name="action" width="17px" headerAlign="center" allowSort="true" align="center" renderer="taskOpt">
					操作
				</div>
				<div field="WORKITEMNAME" headerAlign="center" allowSort="true" align="center" width="55px">
					任务名称
				</div>
				<div field="PARTINAME" headerAlign="center" allowSort="true" align="center" width="55px">
					参与人
				</div>
				<div field="VC_PRODUCT_NAME" headerAlign="center" allowSort="true" align="center" width="55px">
					产品名称
				</div>
				<div field="VC_COMBI_NAME" headerAlign="center" allowSort="true" align="center" width="55px">
					组合名称
				</div>
				<div field="VC_ABSTRACT" headerAlign="center" allowSort="true" align="center" width="20%">
					任务描述
				</div>
				<div field="CREATETIME" headerAlign="center" allowSort="true" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" width="55px">
					创建时间
				</div>
			</div>
		</div>
	</div>
	<!-- 列表结束| -->
	<!-- |脚本开始 -->
	<script type="text/javascript">
	nui.parse();
	var grid = nui.get("datagrid_tasks");
	grid.load();
	var form = new nui.Form("#task_condition");
	var json = form.getData(false,false);
	var fundCodeCombo = nui.get("fundCodeName");
	var vcCombiCombo = nui.get("vcCombi");
	var batchConfirmButton = nui.get("batchConfirm");
	var viewFlowChartButton = nui.get("viewFlowChart");
	var changeParticipantButton = nui.get("changeParticipant");
	batchConfirmButton.disable();
	viewFlowChartButton.disable();
	changeParticipantButton.disable();
	var approveWindows = ["instructApprove","bondLockLogInfo"];
	//当窗口获取焦点时触发
	window.onfocus = function(){
		for(x in approveWindows){
			if(localStorage.lastWindow == approveWindows[x]){
				nui.alert("审批成功","系统提示");
				grid.load(json);
				localStorage.removeItem("lastWindow");
				return;
			}
		}
	};
	//任务表格操作列内容定义
	function taskOpt(e){
		var rcd = e.record;
		var s =  '<a style="color:#00CCFF" target="_blank" href="'
			+ nui.context+rcd.ACTIONURL
			+ '?workItemID='
			+ rcd.WORKITEMID
			+ '&processInstID='
			+ rcd.PROCESSINSTID
			+ '&currentState='
			+ rcd.CURRENTSTATE
			+ '&bizId='
			+ rcd.L_BIZ_ID
			+ '&processType='
			+ rcd.VC_PROCESS_TYPE
			+ '&investNo='
			+ rcd.L_INVEST_NO
			+ '">执行</a>';
		return s;
	}
	//选择产品
	function selectFund(e){
		var id = fundCodeCombo.getValue();
		nui.ajax({
			data:{vcProductCode:id},
			url:"com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfo.biz.ext?queryType=1",
			success:function(resp){
				vcCombiCombo.setValue("");
				if(resp.data){
					vcCombiCombo.load(resp.data);
					vcCombiCombo.select(0);
				}
			}
		});
	}
	//查询
	function search(){
		json = form.getData(false,false);
		grid.load(json);
	}
	//重置
	function reset(){
		form.clear();
	}
	//下拉框X
	function onCloseClickValueEmpty(e){
		var obj = e.sender;
		obj.setText("");
		obj.setValue("");
	}
	//列表选择发生变化时触发事件
	function selectionChanged(){
		var rcds = grid.getSelecteds();
		if(rcds.length == 0){
			batchConfirmButton.disable();
			viewFlowChartButton.disable();
			changeParticipantButton.disable();
		}else if(rcds.length == 1){
			batchConfirmButton.enable();
			viewFlowChartButton.enable();
			if(rcds[0].CURRENTSTATE == 4){
				changeParticipantButton.disable();
			}else{
				changeParticipantButton.enable();
			}
		}else{
			batchConfirmButton.enable();
			viewFlowChartButton.disable();
			changeParticipantButton.disable();
		}
	}
	//批量确认
	function batchConfirm(){
		var rcds = grid.getSelecteds();
		var type = "";
		for(var i=0;i<rcds.length;i++){
			if(i==0){
				type = rcds[i].VC_PROCESS_TYPE;
			}else{
				if(type != rcds[i].VC_PROCESS_TYPE){
					nui.alert("不允许对业务类型不同的任务进行批量操作","系统提示");	
					return;
				}
			}
		}
		if(type == "101" || type == "102" || type == "103"){//如果是投顾复核或锁定券解锁审批类型的任务
			batchConfirmTasks(nui.encode({tasks:rcds}));
		}else{
			nui.alert("该类型任务不可进行批量操作","系统提示");	
		}
	}
	//查看流程图
	function viewFlowChart(){
		window.open(nui.context+"/com.cjhxfund.foundation.task.ProcessChart.flow?processInstID="+grid.getSelected().PROCESSINSTID);
	}
	//二级、回购指令/建议投顾复核及锁定券解锁审批任务的批量确认
	function batchConfirmTasks(tasks){
		var a = nui.loading("正在处理中,请稍等...","提示");
		nui.ajax({
			url:"com.cjhxfund.ats.sm.comm.TaskManager.finishWorkBatch.biz.ext",
			type:'POST',
			data:tasks,
			cache: false,
			contentType:'text/json',
			success:function(text){
				nui.hideMessageBox(a);
				var returnJson = nui.decode(text);
				if(returnJson.exception == null){
					if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
						nui.alert(returnJson.rtnMsg, "系统提示", function(){grid.load(json);});
					}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
						nui.alert(returnJson.rtnMsg, "系统提示");
					}else{
						nui.alert("操作异常","系统提示");
					}
				}else{
					nui.alert("系统异常","系统提示");
				}
			}
		});
	}
	//改派任务
	function changeParticipant(){ 
		nui.open({
			url:  nui.context + "/process/util/multselet_main.jsp",
			title: "员工列表",
			width: 650,
			height: 480,
			ondestroy: function (action) {
				if(action == "ok") {
					var iframe = this.getIFrameEl();
					var emp = iframe.contentWindow.getData();
					emp = nui.clone(emp); 
					if (emp) {
						var a = nui.loading("正在处理中,请稍等...","提示");
						nui.ajax({
							url:"com.cjhxfund.commonUtil.taskManager.ressignWork.biz.ext",
							type:'POST',
							data:nui.encode({workItemID:grid.getSelected().WORKITEMID,userID:emp.value}),
							cache: false,
							contentType:'text/json',
							success:function(text){
								nui.hideMessageBox(a);
								var returnJson = nui.decode(text);
						    if(returnJson.exception == null){
									nui.alert("操作成功","系统提示");
									grid.load(json);
								}else{
									nui.alert("系统异常","系统提示");
								}
							}
			     	});
					}
				}
			}
		});
	}
	</script>
	<!-- 脚本结束| -->
</body>
</html>