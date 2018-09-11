<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 程弼超
  - Date: 2016-10-27 08:47:31
  - Description: 通用的已办任务查询界面
-->
<head>
<title>已办任务</title>
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
							<input name="task/vcProductCode" class="nui-combobox" id="fundCodeName"
							textField="TEXT" valueField="ID"
							url="com.cjhxfund.commonUtil.applyInstUtil.queryTAtsProductInfo.biz.ext"
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
							<input name="task/vcCombiName" class="nui-combobox" id="vcCombi"
							textField="TEXT" valueField="ID"
							dataField="data"
							url="com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfo.biz.ext"
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
							<input name="task/vcProcessType" class="nui-dictcombobox" dictTypeId="ATS_SM_TASK_TYPE" 
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
							<input name="task/workItemName" class="nui-textbox" width="95%"/>
						</td>
						<td width="60px" align="right">
							任务描述:
						</td>
						<td align="left">
							<input name="task/vcAbstract" class="nui-textbox" width="95%"/>
						</td>
					</tr>
					<tr>
						<td colspan="6" align="left">
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
					<a class='nui-button' plain='false' iconCls="icon-find" onclick="viewFlowChart()" id="viewFlowChart">
						查看流程
					</a>
				</td>
			</tr>
		</table>
	</div>
	<!-- 工具栏结束|  -->
	<!-- |列表开始  -->
	<div class="nui-fit">
		<div id="datagrid_tasks" 
		class="nui-datagrid" 
		url="com.cjhxfund.commonUtil.taskManager.queryFinishWork.biz.ext" 
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
				<div type="indexcolumn" headerAlign="center" align="center" width="10px">
					#
				</div>
				<div type="checkcolumn" width="10px"></div>
				<div name="action" width="15px" headerAlign="center" allowSort="true" align="center" renderer="taskOpt">
					操作
				</div>
				<div field="workItemName" headerAlign="center" allowSort="true" align="center" width="55px">
					任务名称
				</div>
				<div field="bizObject.vcProductName" headerAlign="center" allowSort="true" align="center" width="55px">
					产品名称
				</div>
				<div field="bizObject.vcCombiName" headerAlign="center" allowSort="true" align="center" width="55px">
					组合名称
				</div>
				<div field="bizObject.vcAbstract" headerAlign="center" allowSort="true" align="center" width="20%">
					任务描述
				</div>
				<div field="createTime" headerAlign="center" allowSort="true" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" width="55px">
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
	var viewFlowChartButton = nui.get("viewFlowChart");
	viewFlowChartButton.disable();
	//任务表格操作列内容定义
	function taskOpt(e){
		var rcd = e.record;
		var s =  '<a style="color:#00CCFF" target="_blank" href="'
			+ nui.context+rcd.actionURL
			+ '?workItemID='
			+ rcd.workItemID
			+ '&processInstID='
			+ rcd.processInstID
			+ '&currentState='
			+ rcd.currentState
			+ '&bizId='
			+ rcd.lBizId
			+ '&processType='
			+ rcd.vcProcessType
			+ '&investNo='
			+ rcd.lInvestNo
			+ '">详情</a>';
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
			viewFlowChartButton.disable();
		}else if(rcds.length == 1){
			viewFlowChartButton.enable();
		}else{
			viewFlowChartButton.disable();
		}
	}
	//查看流程图
	function viewFlowChart(){
		window.open(nui.context+"/com.cjhxfund.foundation.task.ProcessChart.flow?processInstID="+grid.getSelected().processInstID);
	}
	</script>
	<!-- 脚本结束| -->
</body>
</html>