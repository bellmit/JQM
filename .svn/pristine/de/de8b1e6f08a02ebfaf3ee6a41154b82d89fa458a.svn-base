<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 侯志勇
  - Date: 2016-10-27 08:47:31
  - Description: 新股待办任务查询界面
-->
<head>
<title>待办任务</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
	<!-- |查询条件开始 -->
	<div class="search-condition">
		<div class="list">
			<div id="task_condition" class="nui-form" style="padding:2px;height:10%;" align="left">
				<table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
    			<tr>
    				<td width="60px" align="right" colspan="2">
		 				申购代码:
    				</td>
			        <td align="left">
			    		<input name="task/stockCode" class="nui-textbox" emptyText="请输入申购代码" onenter="onKeyEnter" width="50%"/>
			        </td>
			        <td align="right" width="60px" colspan="2">
	                	发行人:
	                </td>
			        <td align="left">
						<input name="task/stockName" class="nui-textbox" emptyText="请输入发行人" onenter="onKeyEnter" width="50%"/>	
					</td>
					<td align="left">
						<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search"/>&nbsp;&nbsp;&nbsp;
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
					<!-- <a class='nui-button' plain='false' iconCls="icon-ok" onclick="batchConfirm" id="batchConfirm">
						批量确认
					</a> -->
					<a class='nui-button' plain='false' iconCls="icon-find" onclick="viewFlowChart" id="viewFlowChart">
						查看流程
					</a>
				</td>
			</tr>
		</table>
	</div>
	<!-- 工具栏结束|  -->
	<!-- |列表开始  -->
	<div class="nui-fit">
		<div class="nui-datagrid" id="datagrid_tasks" 
		url="com.cjhxfund.ats.ipo.task.queryIpoWork.biz.ext" 
		dataField="workItemList"
		allowResize="true"
		idField="workitemid"
		pageSize="30"
		sizeList="[20,30,50,100]" 
		showPager="true"
		multiSelect="true"
		allowSortColumn="true"
		sortField="createTime"
		sortOrder="desc"
		onselectionChanged="selectionChanged"
		style="width:100%;height:100%;"
		>
			<div property="columns">
				<div type="indexcolumn" headerAlign="center" align="center" width="10">
					#
				</div>
				<div type="checkcolumn" width="10"></div>
				<div name="action" width="15" headerAlign="center" allowSort="true" align="center" renderer="taskOpt">
			  		操作
				</div>
				<div field="workItemName" headerAlign="center" allowSort="true" align="center" width="80">
					任务名称
				</div>
				<div field="bizObject.vcStockCode" headerAlign="center" allowSort="true" align="center" width="55">
					申购代码
				</div>
				<div field="bizObject.vcStockName" headerAlign="center" allowSort="true" align="center" width="55">
					发行人
				</div>
				<div field="bizObject.vcAbstract" headerAlign="center" allowSort="true" align="center" width="150">
					任务描述
				</div>
				<div field="createTime" headerAlign="center" allowSort="true" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" width="55">
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

	//var batchConfirmButton = nui.get("batchConfirm");
	var viewFlowChartButton = nui.get("viewFlowChart");
	//batchConfirmButton.disable();
	viewFlowChartButton.disable();
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
			+ nui.context+rcd.actionURL
			+ '?workItemID='
			+ rcd.workItemID
			+ '&processInstID='
			+ rcd.processInstID
			+ '&bizId='
			+ rcd.bizObject.lBizId
			+ '&vcExchangeNo='
			+ rcd.bizObject.vcPaymentPlace
			+ '">执行</a>';
			
		return s;
	}
	//选择产品
	function selectFund(e){
		var id = fundCodeCombo.getValue();
		nui.ajax({
			data:{vcProductCode:id},
			url:"com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfo.biz.ext",
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
	function onKeyEnter(e) {
	        search();
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
		if(rcds.length == 0){//如果没有选中任何记录
			//batchConfirmButton.disable();
			viewFlowChartButton.disable();
		}else if(rcds.length == 1){//如果选中了一条记录
			//batchConfirmButton.enable();
			viewFlowChartButton.enable();
		}else{//如果选中了多条记录
			viewFlowChartButton.disable();
		}
	}
	//批量确认
	function batchConfirm(){
		var rcds = grid.getSelecteds();
		var type = "";
		//遍历寻找是否存在业务类型不同的任务
		for(var i=0;i<rcds.length;i++){
			if(i==0){
				type = rcds[i].bizObject.vcProcessType;
			}else{
				if(type != rcds[i].bizObject.vcProcessType){
					nui.alert("不允许对业务类型不同的任务进行批量操作","系统提示");	
					return;
				}
			}
		}
		if(type == "6" || type == "7" || type == "8"){//如果是投顾复核或锁定券解锁审批类型的任务
			batchConfirmTasks(nui.encode({tasks:rcds}));
		}
	}
	//查看流程图
	function viewFlowChart(){
		window.open(nui.context+"/com.cjhxfund.ats.fm.task.ProcessChart.flow?processInstID="+grid.getSelected().processInstID);
	}
	//二级、回购指令投顾复核及锁定券解锁审批任务的批量确认
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
						nui.alert(returnJson.rtnMsg);
						grid.load(json);
					}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
						nui.alert(returnJson.rtnMsg);
					}else{
						nui.alert("操作异常","系统提示");
					}
				}else{
					nui.alert("系统异常","系统提示");
				}
			}
    });
	}
	
</script>
	<!-- 脚本结束| -->
</body>
</html>