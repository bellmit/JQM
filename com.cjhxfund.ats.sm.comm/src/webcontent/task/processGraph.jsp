<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://eos.primeton.com/tags/workflow" prefix="wf"%>
<%@include file="/common/js/commscripts.jsp"%>
<html>
<!-- 
  - Author(s): 童伟
  - Date: 2016-11-02 09:10:37
  - Description:
-->
<head>
<title>流程审批信息</title>
<script src="<%= request.getContextPath() %>/workflow/wfcomponent/web/js/Graphic.js" type="text/javascript"></script>
	
<%
	String processInstID = request.getParameter("processInstID");
%>

</head>
<body topmargin="20"
	style="width: 100%; height: 100%; overflow: hidden;">
	<div id="tabs" class="nui-tabs" style="width: 100%; height: 100%;">
		<!-- 流程处理信息列表 -->
		<div title="审批信息">
			<!-- 流程处理信息列表 -->
			<div id="grid_form">
				<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.sm.comm.atsSmData.TAtsApproveInfo" />
				<input class="nui-hidden" name="criteria/_expr[1]/lProcessInstId" value="<%=processInstID%>" />
				<input class="nui-hidden" name="cirteria/_expr[1]/_op" value="=" />
			</div>
			<div id="deptGrid" class="nui-datagrid"
				style="width: 100%; height: 600px;"
				url="com.cjhxfund.ats.sm.comm.TaskManager.queryTAtsApproveInfoList.biz.ext"
				dataField="TAtsApproveInfos"
				pageSize="50" 
				showPageInfo="true" 
				multiSelect="true"
				allowSortColumn="true">
				<div property="columns">
					<div type="expandcolumn"></div>
					<div field="lWorkItemId" headerAlign="center" visible="false" align="center">工作项ID</div>
					<div field="lApproveId" headerAlign="center" visible="false" align="center">编号</div>
					<div field="processInstId" headerAlign="center" visible="false" align="center">流程ID</div>
					<div field="dEndTime" headerAlign="center"
						dateFormat="yyyy-MM-dd HH:mm:ss" align="center">审批时间</div>
					<div field="vcWorkItemName" headerAlign="center" align="center">节点名称</div>
					<div field="vcUserName" headerAlign="center" align="center">操作者</div>
					<div field="vcOperateType" headerAlign="center" allowSort="true" renderer="rendeRoperateType" align="center">操作</div>
					<div field="vcComments" headerAlign="center" align="center">处理意见</div>
				</div>
			</div>
		</div>
		<div title="流程图">
			<div width="100%" align="center" style="margin-top: 20px;">
				<wf:processGraph processInstID="<%=processInstID%>" zoomQuotiety="1" ondblclick="javaScript:showMessage(this)"/>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		nui.parse();
		// 审批意见
		var dept_grid = nui.get("deptGrid");
		var formData = new nui.Form("#grid_form").getData(false, false);
		dept_grid.load(formData);
		
		// 操作类型翻译
		function rendeRoperateType(e) {
			if(e.row.vcOperateType == 1){
    			return "通过";
    		}else if(e.row.vcOperateType == 2){
    			return "退回";
    		}else{
    			return "不通过";
    		}
		}

	</script>
</body>
</html>
