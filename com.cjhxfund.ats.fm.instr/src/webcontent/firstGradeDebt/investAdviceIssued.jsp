<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@include file="/common/js/commscripts.jsp"%>

<html>
<!-- 
  - Author(s): 杨敏
  - Date: 2016-08-18 16:32:02
  - Description:
-->
<head>
<title><b:write property="workitem/workItemName" /></title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script
	src="<%= request.getContextPath() %>/fm/instr/processUtil/instr.js"
	type="text/javascript"></script>
<style type="text/css">
.td1 {
	border-right: 1px solid #D3D3D3;
	border-left: 1px solid #D3D3D3;
}

.td2 {
	border-right: 1px solid #D3D3D3;
}

.asLabel .mini-textbox-input {
	color: red;
	background: none;
	cursor: default;
}

.asLabel_gray .mini-textbox-input {
	color: black;
	background: none;
	cursor: default;
}

.p {
	border-bottom: 1px solid #D3D3D3;
}

P {
	margin: 0px;
	padding: 0px;
}

.form_label label {
	color: red;
}

.form_label {
	text-align: right;
}

#dataform2 tr {
	border-top: 0px;
}
</style>
<%
	   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
	   //业务ID
	   String bizId =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"bizId");
	   //流程ID
	   String processinstid =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"processInstID");
	   //工作项ID
	   String workItemID =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workItemID");
	   
	   //获取产品代码
	   DataObject obj = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"firstGradeBond");
	   String vcProductCode = obj.getString("vcProductCode");
	   String lNextExerciseDate = obj.getString("lNextExerciseDate");
	   
	   //获取工作项信息
	   DataObject workitem = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workitem");
	   String activityDefID = workitem.getString("activityDefID");
 	%>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/common/js/commonjs.js"></script>
</head>
<body style="width: 100%; height: 100%; overflow: hidden; margin: 0px;">
	<div id="dataform1" style="height: 100%;">
		<div id="tabs" class="nui-tabs" height="100%"
			onactivechanged="activechangedFun">
			<div title="基本信息">
				<!-- 左右布局控件   -->
				<div id="layout1" class="nui-layout"
					style="width: 100%; height: 100%;">
					<!-- 主体内容  -->
					<div title="center" region="center" width="80%">
						<input class="nui-hidden" id="processinstid" name="processinstid"
							value="<%=processinstid %>" /> <input class="nui-hidden"
							id="workItemID" name="workItemID" value="<%=workItemID %>" /> <input
							class="nui-hidden" id="workItemName"
							value="<b:write property="workitem/workItemName" />">
						<!-- 投资编号 -->
						<input class="nui-hidden"  name="applyInst.cApplyAuthStatus" value="<b:write property="firstGradeBond/cApplyAuthStatus" />" /> 
						<input class="nui-hidden"  name="applyInst.cPaymentAuthStatus" value="<b:write property="firstGradeBond/cPaymentAuthStatus" />" />
						<input class="nui-hidden" id="cApplyInstType" name="applyInst.cApplyInstType" value="<b:write property="firstGradeBond/cApplyInstType" />" />
						<input class="nui-hidden" id="stockissueinfo.lStockIssueId"
							name="stockissueinfo.lStockIssueId"
							value="<b:write property="firstGradeBond/lStockIssueId" />" /> <input
							class="nui-hidden" id="lApplyInstId"
							name="applyInst.lApplyInstId"
							value="<b:write property="firstGradeBond/lApplyInstId" />" />
						<!-- 流程业务主表ID -->
						<input class="nui-hidden" id="lBizId" name="applyInst.lBizId"
							value="<b:write property="firstGradeBond/lBizId" />" />
						<!-- 流程类型 -->
						<input class="nui-hidden" id="vcBusinessType"
							name="applyInst.vcBusinessType"
							value="<b:write property="firstGradeBond/vcBusinessType" />" />
						<!-- 报量信息-->
						<input class="nui-hidden" name="applyInst.enInvestBalance"
							id="vcInvestBalance"
							value="<b:write property="firstGradeBond/enInvestBalance" />" />
						<input class="nui-hidden" name="applyInst.enInterestRate"
							id="enInterestRate"
							value="<b:write property="firstGradeBond/enInterestRate" />" />
						<!-- 业务流程归类 -->
						<input class="nui-hidden" type="hidden" id="vcProcessType"
							name="bizProcess.vcProcessType"
							value="<b:write property="firstGradeBond/vcProcessType" />" />
						<!-- 证券投资编号 -->
						<input class="nui-hidden" type="hidden"
							id="applyInst.lStockInvestNo" name="applyInst.lStockInvestNo"
							value="<b:write property="firstGradeBond/lStockInvestNo" />" />
						<input class="nui-hidden" type="hidden"
							id="stockissueinfo.lStockInvestNo"
							name="stockissueinfo.lStockInvestNo"
							value="<b:write property="firstGradeBond/lStockInvestNo" />" />
						<input class="nui-hidden" type="hidden"
							id="tempStockissueinfo.lStockInvestNo"
							name="tempStockissueinfo.lStockInvestNo"
							value="<b:write property="firstGradeBond/lStockInvestNo" />" />
						<input class="nui-hidden" type="hidden"
							id="tempStockissueinfo.lStockIssueId"
							name="tempStockissueinfo.lStockIssueId"
							value="<b:write property="firstGradeBond/lStockIssueId" />" /> <input
							class="nui-hidden" type="hidden" id="tempStockissueinfo.cStatus"
							name="tempStockissueinfo.cStatus"
							value="<b:write property="firstGradeBond/cSwitchstocktype" />" />
						<!-- 证券投资编号 -->
						<input class="nui-hidden" type="hidden" id="applyInst.lInvestNo"
							name="applyInst.lInvestNo"
							value="<b:write property="firstGradeBond/lInvestNo" />" />
						<!-- 存储报量临时数据 -->
						<input class="nui-hidden" type="hidden" id="report.enReport"
							name="report.enReport" value="0" />
						<table style="width: 100%; table-layout: fixed;"
							class="nui-form-table">
							<tr>
								<td class="form_label" width="25%"><label>*</label>业务日期:</td>
								<td colspan="1" width="25%"><input style="width: 170px;"
									class="mini-datepicker" id="bdApplicationTime"
									name="applyInst.dApplicationTime"
									value="<b:write property="firstGradeBond/dApplicationTime" />"
									nullValue="null" format="yyyy-MM-dd H:mm:ss"
									timeFormat="H:mm:ss" showTime="true" showOkButton="true"
									showClearButton="false" /></td>
								<td colspan="1" class="form_label"><label>*</label>投标截止日期:
								</td>
								<td colspan="1" width="270px">
									<!-- 日期和时间分开显示 --> <input style="width: 98px;"
									id="dApplicationDate" onvaluechanged="onTimeValueChanged"
									class="mini-datepicker" showTodayButton="true"
									format="yyyy-MM-dd" required="true"
									value="<b:write property="firstGradeBond/dBidLimitTime" />" />
									<!--<input style="width: 62px;" name="Time" id="dApplicationTime" onvaluechanged="onTimeValueChanged" class="mini-timespinner" format="HH:mm" required="true" />
						     --> <input style="width: 40px;"
									url="<%= request.getContextPath() %>/fm/instr/processUtil/timeHH.txt"
									class="nui-dictcombobox" required="true"
									id="dApplicationTimeHH" onvaluechanged="onTimeValueChanged" />
									时 <input style="width: 40px;"
									url="<%= request.getContextPath() %>/fm/instr/processUtil/timeMM.txt"
									class="nui-dictcombobox" required="true"
									id="dApplicationTimeMM" onvaluechanged="onTimeValueChanged" />
									分 <!-- 提醒的时间 --> <input class="nui-hidden" type="hidden"
									id="bidRemind" />

								</td>
							</tr>

							<tr>
								<td colspan="1" class="form_label" width="25%"><label>*</label>产品名称:
								</td>
								<td colspan="1" width="25%"><input style="width: 170px;"
									id="productCombo" class="mini-combobox"
									name="applyInst.vcProductCode"
									value="<b:write property="firstGradeBond/vcProductCode" />"
									textField="TEXT" valueField="ID"
									url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryTAtsProductInfo.biz.ext?queryType=1"
									value="cn" showNullItem="false" required="true"
									allowInput="true" emptyText="请选择"
									onvalidation="onComboValidation"
									onvaluechanged="onProductChanged" /> <input class="nui-hidden"
									type="hidden" id="vcProductName" name="applyInst.vcProductName"
									value="<b:write property="firstGradeBond/vcProductName" />" />
									<input class="nui-hidden" type="hidden" id="vcProductCode"
									value="<b:write property="firstGradeBond/vcProductCode" />" />
								</td>
								<td colspan="1" class="form_label"><label>*</label>组合名称:</td>
								<td colspan="1"><input style="width: 170px;"
									id="combiCombo" class="mini-combobox"
									name="applyInst.vcCombiNo"
									value="<b:write property="firstGradeBond/vcCombiNo" />"
									textField="TEXT" valueField="ID"
									url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryCombiInfo.biz.ext?queryType=1&vcProductCode=<b:write property="firstGradeBond/vcProductCode" />"
									value="cn" showNullItem="false" required="true"
									allowInput="true" emptyText="请选择"
									onvalidation="onComboValidation1" /> <!-- 组合信息 --> <input
									class="nui-hidden" type="hidden" id="lCombiId"
									name="applyInst.lCombiId"
									value="<b:write property="firstGradeBond/lCombiId" />" /> <input
									class="nui-hidden" type="hidden" id="vcCombiName"
									name="applyInst.vcCombiName"
									value="<b:write property="firstGradeBond/vcCombiName" />" /> <!-- 资产单元 -->
									<input class="nui-hidden" type="hidden" id="lAssetId"
									name="applyInst.lAssetId"
									value="<b:write property="firstGradeBond/lAssetId" />" /> <input
									class="nui-hidden" type="hidden" id="vcAssetNo"
									name="applyInst.vcAssetNo"
									value="<b:write property="firstGradeBond/vcAssetNo" />" /> <input
									class="nui-hidden" type="hidden" id="vcAssetName"
									name="applyInst.vcAssetName"
									value="<b:write property="firstGradeBond/vcAssetName" />" /></td>
							</tr>
							<tr>
								<td colspan="1" class="form_label"><label>*</label>债券代码:</td>
								<td colspan="1"><input style="width: 170px;"
									class="nui-textbox" id="applyInst.vcStockCode" required="true"
									onvaluechanged="onvalidationkCode()"
									name="applyInst.vcStockCode"
									value="<b:write property="firstGradeBond/vcStockCode" />" /></td>
								<td colspan="1" class="form_label"><label>*</label>债券简称:</td>
								<td colspan="1"><input style="width: 170px;"
									class="nui-textbox" required="true" id="applyInst.vcStockName"
									name="applyInst.vcStockName"
									value="<b:write property="firstGradeBond/vcStockName" />" /> <a
									class='nui-button' plain='false' id="queryOpen" iconCls="icon-search"
									onclick="queryOpen()" style="display: none"></a></td>
							</tr>
							<tr>
								<td colspan="1" class="form_label">登记托管机构:</td>
								<td colspan="1">
									<!-- 交易市场 根据托管机构查询债券，然后带出 --> <input class="nui-hidden"
									type="hidden" id="applyInst.cMarketNo"
									name="applyInst.cMarketNo" /> <input style="width: 170px;"
									class="nui-dictcombobox" id="applyInst.vcPaymentPlace"
									required="true" onvaluechanged="onvalidationkCode()"
									name="applyInst.vcPaymentPlace"
									value="<b:write property="firstGradeBond/vcPaymentPlace" />"
									dictTypeId="CF_JY_DJTGCS" /> <%-- <input style="width:170px;" id="stockissueinfo.vcPaymentPlace" class="nui-dictcombobox" onvaluechanged="onVcPaymentPlace()" name="stockissueinfo.vcPaymentPlace" 
                             value="<b:write property="firstGradeBond/vcPaymentPlace" />"  showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="CF_JY_DJTGCS" /> --%>
								</td>
								<td colspan="1" class="form_label"><label>*</label>债券类别:</td>
								<td colspan="1"><input style="width: 170px;"
									id="stockissueinfo.vcStockType"
									name="stockissueinfo.vcStockType" class="mini-treeselect"
									multiSelect="false" textField="text" valueField="id"
									parentField="pid" checkRecursive="false"
									showFolderCheckBox="true" expandOnLoad="true"
									showTreeIcon="false" onbeforenodeselect="beforenodeselect"
									onvaluechanged="cheangedVcStockType" popupWidth="200"
									required="true" /></td>
							</tr>
							<tr>
								<td colspan="1" class="form_label"><label>*</label>发行主体:</td>
								<td colspan="1"><input id="lookup2" style="width: 170px;"
									name="stockissueinfo.lIssuerId"
									text="<b:write property="firstGradeBond/vcIssuerNameFull" />"
									value="<b:write property="firstGradeBond/lIssuerId" />"
									class="mini-lookup" textField="vcIssueNameFull"
									valueField="lIssuerId" popupWidth="auto" popup="#gridPanel"
									onvalidation="onIssuerId2" grid="#datagrid2"
									multiSelect="false" required="true"
									onclick="onClearClick2();onSearchClick2()" />

									<div id="gridPanel" class="mini-panel" title="header"
										iconCls="icon-add" style="width: 450px; height: 250px;"
										showToolbar="true" showCloseButton="true" showHeader="false"
										bodyStyle="padding:0" borderStyle="border:0">
										<div property="toolbar"
											style="padding: 5px; padding-left: 8px; text-align: center;">
											<div style="float: left; padding-bottom: 2px;">
												<span>发行主体：</span> <input id="keyText2" class="mini-textbox"
													style="width: 160px;" onenter="onSearchClick2" /> <a
													class="mini-button" onclick="onSearchClick2">查询</a> <a
													class="mini-button" id="add" iconCls='icon-add'
													onclick="onAddClick">添加</a> <a class="mini-button"
													id="cleanLookup2" onclick="cleanLookup2()">清空</a>
											</div>
											<div style="float: right; padding-bottom: 2px;"></div>
											<div style="clear: both;"></div>
										</div>
										<div id="datagrid2" class="mini-datagrid"
											style="width: 100%; height: 100%;" borderStyle="border:0"
											showPageSize="false" showPageIndex="false"
											url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadIssueInfo.biz.ext"
											onRowdblclick="onCloseClickLookup2">
											<div property="columns">
												<div field="vcIssueName" width="80" headerAlign="center"
													allowSort="true">简称</div>
												<div field="vcIssueNameFull" width="120"
													headerAlign="center" allowSort="true">全称</div>
											</div>
										</div>
									</div> <!-- 控件内容  结束--> <input class="nui-hidden" type="hidden"
									id="vcIssueProperty" name="stockissueinfo.vcIssueProperty"
									value="<b:write property="firstGradeBond/vcIssueProperty" />" />
									<input class="nui-hidden" type="hidden" id="vcIssuerName"
									name="stockissueinfo.vcIssuerName"
									value="<b:write property="firstGradeBond/vcIssuerName" />" /> <input
									class="nui-hidden" type="hidden" id="vcIndustry"
									name="stockissueinfo.vcIndustry"
									value="<b:write property="firstGradeBond/vcIndustry" />" /> <input
									class="nui-hidden" type="hidden" id="vcProvince"
									name="stockissueinfo.vcProvince"
									value="<b:write property="firstGradeBond/vcProvince" />" /> <input
									class="nui-hidden" type="hidden" id="vcIssuerNameFull"
									name="stockissueinfo.vcIssuerNameFull"
									value="<b:write property="firstGradeBond/vcIssuerNameFull" />" />
								</td>
								<td colspan="1" class="form_label"><label>*</label>债券全称:</td>
								<td colspan="1"><input style="width: 170px;"
									class="nui-textbox" required="true" id="vcStockNameFull"
									name="stockissueinfo.vcStockNameFull"
									value="<b:write property="firstGradeBond/vcStockNameFull" />" />
								</td>
							</tr>
							<tr>
								<td colspan="1" class="form_label"><label>*</label>发行日期:</td>
								<td colspan="1"><input style="width: 170px;"
									id="lIssueBeginDate" name="stockissueinfo.lIssueBeginDate"
									value="<b:write property="firstGradeBond/lIssueBeginDate" />"
									class="mini-datepicker" showTodayButton="true" required="true" />
								</td>
								<td colspan="1" class="form_label"><label>*</label>发行规模(亿):
								</td>
								<td colspan="1"><input style="width: 170px;"
									id="enIssueBalance" name="stockissueinfo.enIssueBalance"
									value="<b:write property="firstGradeBond/enIssueBalance" />"
									onvaluechanged="calculationNetWorthScale" class="nui-textbox"
									required="true" vtype="float" /></td>
							</tr>

							<tr>
								<td colspan="1" class="form_label">债券详情:</td>
								<td colspan="1"><a class='nui-button' plain='false'
									onclick="queryStockDetail()"> 查看债券详情 </a></td>
								<td colspan="1" class="form_label"></td>
								<td colspan="1"></td>
							</tr>
						</table>
						<div style="height: 5px"></div>
						<div id="panel1" class="mini-panel" title="其他信息"
							iconCls="icon-edit" style="width: 100%;" showToolbar="true"
							showCollapseButton="true" showFooter="true" allowResize="false"
							collapseOnTitleClick="true">
							<table style="width: 100%; table-layout: fixed;" border="0"
								class="nui-form-table">
								<tr>
									<td colspan="1" class="form_label" width="25%">主承销商:</td>
									<td colspan="3">
										<!-- 控件开始 --> <input style="width: 88%;" class="nui-textbox"
										id="stockissueinfo.vcMainUnderwriter"
										name="stockissueinfo.vcMainUnderwriter"
										value="<b:write property="firstGradeBond/vcMainUnderwriter" />" />
										<input id="lookup3" style="width: 25px;" class="mini-lookup"
										textField="vcIssueNameFull" valueField="lIssuerId"
										popupWidth="auto" onclick="onSearchClick3()"
										popup="#gridPanel3" onvalidation="onIssuerId3"
										allowInput="true" showNullItem="true" grid="#datagrid3"
										multiSelect="true" />

										<div id="gridPanel3" class="mini-panel" title="header"
											iconCls="icon-add" style="width: 450px; height: 250px;"
											showToolbar="true" showCloseButton="true" showHeader="false"
											bodyStyle="padding:0" borderStyle="border:0">
											<div property="toolbar"
												style="padding: 5px; padding-left: 8px; text-align: center;">
												<div style="float: left; padding-bottom: 2px;">
													<span>主承销商：</span> <input id="keyText3"
														class="mini-textbox" style="width: 160px;"
														onenter="onSearchClick3" /> <a class="mini-button"
														onclick="onSearchClick3">查询</a> <a class="mini-button"
														id="add" iconCls='icon-add' onclick="onAddClick">添加</a>
												</div>
												<div style="float: right; padding-bottom: 2px;"></div>
												<div style="clear: both;"></div>
											</div>
											<div id="datagrid3" class="mini-datagrid"
												style="width: 100%; height: 100%;" borderStyle="border:0"
												showPageSize="false" showPageIndex="false"
												url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadIssueInfo.biz.ext"
												onRowdblclick="onCloseClickLookup3">
												<div property="columns">
													<div type="checkcolumn"></div>
													<div field="vcIssueName" width="80" headerAlign="center"
														allowSort="true">简称</div>
													<div field="vcIssueNameFull" width="120"
														headerAlign="center" allowSort="true">全称</div>
												</div>
											</div>
										</div> <!-- 控件结束 --> <input class="nui-hidden" type="hidden"
										id="vcMainUnderwriterId"
										name="stockissueinfo.vcMainUnderwriterId"
										value="<b:write property="firstGradeBond/vcMainUnderwriterId" />" />
									</td>
								</tr>
								<tr>
									<td colspan="1" class="form_label">副主承销商:</td>
									<td colspan="3">
										<!-- 控件开始 --> <input style="width: 88%;" class="nui-textbox"
										id="stockissueinfo.vcDeputyUnderwriter"
										name="stockissueinfo.vcDeputyUnderwriter"
										value="<b:write property="firstGradeBond/vcDeputyUnderwriter" />" />
										<input id="lookup5" style="width: 25px;" class="mini-lookup"
										textField="vcIssueNameFull" valueField="lIssuerId"
										popupWidth="auto" onclick="onClearClick5();onSearchClick5()"
										popup="#gridPanel5" onvalidation="onIssuerId5"
										allowInput="true" showNullItem="true" grid="#datagrid5"
										multiSelect="true" />

										<div id="gridPanel5" class="mini-panel" title="header"
											iconCls="icon-add" style="width: 450px; height: 250px;"
											showToolbar="true" showCloseButton="true" showHeader="false"
											bodyStyle="padding:0" borderStyle="border:0">
											<div property="toolbar"
												style="padding: 5px; padding-left: 8px; text-align: center;">
												<div style="float: left; padding-bottom: 2px;">
													<span>副主承销商：</span> <input id="keyText5"
														class="mini-textbox" style="width: 160px;"
														onenter="onSearchClick5" /> <a class="mini-button"
														onclick="onSearchClick5">查询</a> <a class="mini-button"
														id="add" iconCls='icon-add' onclick="onAddClick">添加</a>
												</div>
												<div style="float: right; padding-bottom: 2px;"></div>
												<div style="clear: both;"></div>
											</div>
											<div id="datagrid5" class="mini-datagrid"
												style="width: 100%; height: 100%;" borderStyle="border:0"
												showPageSize="false" showPageIndex="false"
												url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadIssueInfo.biz.ext"
												onRowdblclick="onCloseClickLookup5">
												<div property="columns">
													<div type="checkcolumn"></div>
													<div field="vcIssueName" width="80" headerAlign="center"
														allowSort="true">简称</div>
													<div field="vcIssueNameFull" width="120"
														headerAlign="center" allowSort="true">全称</div>
												</div>
											</div>
										</div> <!-- 控件结束 --> <input class="nui-hidden" type="hidden"
										id="vcDeputyUnderwriterId"
										name="stockissueinfo.vcDeputyUnderwriterId"
										value="<b:write property="firstGradeBond/vcDeputyUnderwriterId" />" />
									</td>
								</tr>
								<tr>
									<td colspan="1" class="form_label">承销团:</td>
									<td colspan="3">
										<!-- 控件开始 --> <input style="width: 88%;" class="nui-textbox"
										id="stockissueinfo.vcGroupUnderwriter"
										name="stockissueinfo.vcGroupUnderwriter"
										value="<b:write property="firstGradeBond/vcGroupUnderwriter" />" />
										<input id="lookup6" style="width: 25px;" class="mini-lookup"
										textField="vcIssueNameFull" valueField="lIssuerId"
										popupWidth="auto" onclick="onClearClick6();onSearchClick6()"
										popup="#gridPanel6" onvalidation="onIssuerId6"
										allowInput="true" showNullItem="true" grid="#datagrid6"
										multiSelect="true" />

										<div id="gridPanel6" class="mini-panel" title="header"
											iconCls="icon-add" style="width: 450px; height: 250px;"
											showToolbar="true" showCloseButton="true" showHeader="false"
											bodyStyle="padding:0" borderStyle="border:0">
											<div property="toolbar"
												style="padding: 5px; padding-left: 8px; text-align: center;">
												<div style="float: left; padding-bottom: 2px;">
													<span>承销团：</span> <input id="keyText6" class="mini-textbox"
														style="width: 160px;" onenter="onSearchClick6" /> <a
														class="mini-button" onclick="onSearchClick6">查询</a> <a
														class="mini-button" id="add" iconCls='icon-add'
														onclick="onAddClick">添加</a>
												</div>
												<div style="float: right; padding-bottom: 2px;"></div>
												<div style="clear: both;"></div>
											</div>
											<div id="datagrid6" class="mini-datagrid"
												style="width: 100%; height: 100%;" borderStyle="border:0"
												showPageSize="false" showPageIndex="false"
												url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadIssueInfo.biz.ext"
												onRowdblclick="onCloseClickLookup6">
												<div property="columns">
													<div type="checkcolumn"></div>
													<div field="vcIssueName" width="80" headerAlign="center"
														allowSort="true">简称</div>
													<div field="vcIssueNameFull" width="120"
														headerAlign="center" allowSort="true">全称</div>
												</div>
											</div>
										</div> <!-- 控件结束 --> <input class="nui-hidden" type="hidden"
										id="vcGroupUnderwriterId"
										name="stockissueinfo.vcGroupUnderwriterId"
										value="<b:write property="firstGradeBond/vcGroupUnderwriterId" />" />
									</td>
								</tr>
								<tr>
									<td colspan="1" class="form_label">交易对手:</td>
									<td>
									<input class="nui-hidden" type="hidden" id="hlRivalId" name="applyInst.lRivalId"
										value="<b:write property="firstGradeBond/lRivalId" />" /> <input
										id="lookup4" style="width: 170px;"
										name="applyInst.vcBusinessObject" class="mini-lookup"
										textField="vcAllName" valueField="lRivalId" popupWidth="auto"
										text="<b:write property="firstGradeBond/vcBusinessObject" />"
										value="<b:write property="firstGradeBond/vcBusinessObject" />"
										popup="#gridPanel4" onvalidation="onIssuerId4"
										grid="#datagrid4" multiSelect="false"
										onclick="onClearClick4();onSearchClick4()" />

										<div id="gridPanel4" class="mini-panel" title="header"
											iconCls="icon-add" style="width: 450px; height: 250px;"
											showToolbar="true" showCloseButton="true" showHeader="false"
											bodyStyle="padding:0" borderStyle="border:0">
											<div property="toolbar"
												style="padding: 5px; padding-left: 8px; text-align: center;">
												<div style="float: left; padding-bottom: 2px;">
													<span>交易对手：</span> <input id="keyText4"
														class="mini-textbox" style="width: 160px;"
														onenter="onSearchClick4" /> <a class="mini-button"
														onclick="onSearchClick4">查询</a> <a class="mini-button"
														id="add" iconCls='icon-add' onclick="onAddClick4">添加</a> <a
														class="mini-button" id="cleanLookup4"
														onclick="cleanLookup4()">清空</a>
												</div>
												<div style="float: right; padding-bottom: 2px;"></div>
												<div style="clear: both;"></div>
											</div>
											<div id="datagrid4" class="mini-datagrid"
												style="width: 100%; height: 100%;" borderStyle="border:0"
												showPageSize="false" showPageIndex="false"
												url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.LoadCounterpartyInfo.biz.ext"
												onRowdblclick="onCloseClickLookup4">
												<div property="columns">
													<div field="vcName" width="80" headerAlign="center"
														allowSort="true">简称</div>
													<div field="vcAllName" width="120" headerAlign="center"
														allowSort="true">全称</div>
												</div>
											</div>
										</div></td>
									<td colspan="1" class="form_label" width="20%">主体类型:</td>
									<td colspan="1"><input style="width: 170px;"
										id="vcIssueProperty" class="nui-dictcombobox"
										name="stockissueinfo.vcIssueProperty"
										value="<b:write property="firstGradeBond/vcIssueProperty" />"
										showNullItem="true" emptyText="---请选择---"
										nullItemText="---请选择---" dictTypeId="ATS_FM_ISSUE_PROPERTY" />
									</td>
								</tr>
								<tr>
									<td colspan="1" width="20%" class="form_label requiredLable">
										<label>*</label>主体评级:
									</td>
									<td colspan="1" width="30%"><input style="width: 170px;"
										required="true" class="nui-dictcombobox" id="cIssueAppraise"
										name="stockissueinfo.cIssueAppraise"
										value="<b:write property="firstGradeBond/cIssueAppraise" />"
										dictTypeId="issuerRating" /></td>
									<td colspan="1" class="form_label requiredLable" width="20%">
										<label>*</label>债券评级:
									</td>
									<td colspan="1" width="30%"><input style="width: 170px;"
										required="true" class="nui-dictcombobox"
										id="stockissueinfo.cBondAppraise"
										name="stockissueinfo.cBondAppraise"
										value="<b:write property="firstGradeBond/cBondAppraise" />"
										dictTypeId="creditRating" /></td>
								</tr>

								<tr>
									<td colspan="1" class="form_label requiredLable"><label>*</label>主体评级机构:
									</td>
									<td colspan="1"><input style="width: 170px;"
										required="true" class="nui-dictcombobox"
										id="stockissueinfo.vcIssueAppraiseOrgan"
										name="stockissueinfo.vcIssueAppraiseOrgan"
										dictTypeId="outRatingOrgan"
										value="<b:write property="firstGradeBond/vcIssueAppraiseOrgan" />" />
									</td>
									<td colspan="1" class="form_label requiredLable"><label>*</label>债券评级机构:
									</td>
									<td colspan="1"><input style="width: 170px;"
										required="true" class="nui-dictcombobox"
										id="stockissueinfo.vcBondAppraiseOrgan"
										name="stockissueinfo.vcBondAppraiseOrgan"
										dictTypeId="outRatingOrgan"
										value="<b:write property="firstGradeBond/vcBondAppraiseOrgan" />" />
									</td>
								</tr>
								<tr>
									<td colspan="1" class="form_label">特殊条款:</td>
									<td colspan="1"><input style="width: 170px;"
										id="stockissueinfo.vcSpecialText" class="nui-dictcombobox"
										name="stockissueinfo.vcSpecialText" valueField="dictID"
										textField="dictName" dictTypeId="specialText" emptyText="请选择"
										nullItemText="请选择" multiSelect="true" showClose="true"
										valueFromSelect="true" oncloseclick="onCloseClickValueEmpty1"
										onvaluechanged="checkvcSpecialText"
										value="<b:write property="firstGradeBond/vcSpecialText" />" />
									</td>
									<td colspan="1" width="20%" class="form_label"><label>*</label>发行期限(年):
									</td>
									<td colspan="1"><input style="width: 170px;"
										class="nui-textbox" id="enExistLimite"
										name="stockissueinfo.enExistLimite" required="true"
										vtype="float"
										value="<b:write property="firstGradeBond/enExistLimite" />" />
									</td>
								</tr>
								<tr>
									<td class="form_label" align="right">
								     	特殊期限:
								  </td>
								  <td colspan="1">
								      <input class="nui-textbox" id="vcSpecialLimite" name="stockissueinfo.vcSpecialLimite" width="170"
								      value="<b:write property="firstGradeBond/vcSpecialLimite" />" />
								  </td>
									<td class="form_label" align="right">下一行权日:</td>
									<td colspan="1"><input style="width: 170px;"
										class="nui-datepicker" id="lNextExerciseDate"
										value="<b:write property="firstGradeBond/lNextExerciseDate" />"
										name="stockissueinfo.lNextExerciseDate" /></td>
								</tr>
								<tr>
									<td colspan="1" class="form_label">下一利率跳升点数:</td>
									<td colspan="1"><input class="nui-textbox"
										name="stockissueinfo.lNInterestRateJumpPoints"
										id="lNInterestRateJumpPoints" style="width: 170px;"
										onblur="checkIntValue(this,lNInterestRateJumpPoints)"
										value="<b:write property="firstGradeBond/lNInterestRateJumpPoints" />"
										vtype="float" /></td>
									<td colspan="1" class="form_label" width="20%">首次付息日:</td>
									<td colspan="1"><input style="width: 170px"
										class="nui-datepicker" id="dInitInterestPaymentDate"
										name="applyInst.dInitInterestPaymentDate"
										value="<b:write property="firstGradeBond/dInitInterestPaymentDate" />"
										format="yyyy-MM-dd" /></td>
								</tr>
								<tr>
									<td colspan="1" class="form_label">公司净资产（元）:</td>
									<td colspan="1"><input class="nui-textbox"
										name="stockissueinfo.enIssuerNetValue" id="enIssuerNetValue"
										style="width: 170px;"
										value="<b:write property="firstGradeBond/enIssuerNetValue" />"
										vtype="float" /></td>
									<td colspan="1" class="form_label">城投行政级别:</td>
									<td colspan="1"><input style="width: 170px;"
										id="vcCityLevel" class="nui-dictcombobox"
										name="stockissueinfo.vcCityLevel" showNullItem="true"
										emptyText="---请选择---" nullItemText="---请选择---"
										dictTypeId="cityLevel"
										value="<b:write property="firstGradeBond/vcCityLevel" />" /></td>
								</tr>

								<tr id="morStockNameAndCode">
									<td colspan="1" class="form_label"><label>*</label>股票名称:
									</td>
									<td colspan="1"><input class="nui-textbox"
										name="stockissueinfo.vcMortStockName" id="vcMortStockName"
										style="width: 170px;"
										value="<b:write property="firstGradeBond/vcMortStockName" />" />
									</td>
									<td col span="1" class="form_label"><label>*</label>股票代码:
									</td>
									<td colspan="1"><input class="nui-textbox"
										name="stockissueinfo.vcMortStockCode" id="vcMortStockCode"
										style="width: 170px;"
										value="<b:write property="firstGradeBond/vcMortStockCode" />" />
									</td>
								</tr>
								
								
								<tr id="morStockAmount">
									<td colspan="1" class="form_label"><label>*</label>
										股票抵押数量(万股):</td>
									<td colspan="3"><input class="nui-textbox"
										name="stockissueinfo.vcMortStockAmount" id="vcMortStockAmount"
										style="width: 170px;"
										value="<b:write property="firstGradeBond/vcMortStockAmount" />"
										vtype="float" /></td>
								</tr>
								
								
								<tr>
									<td colspan="1" class="form_label">所属行业(证监会二级):</td>
									<td colspan="1">
										<%-- <input class="nui-textbox" name="stockissueinfo.vcIssueAppraiseCsrc" id="vcIssueAppraiseCsrc" style="width: 170px;"
										value="<b:write property="firstGradeBond/vcIssueAppraiseCsrc" />" /> --%>
										<input style="width: 170px;" id="vcIssueAppraiseCsrc"
										name="stockissueinfo.vcIssueAppraiseCsrc"
										class="mini-treeselect" multiSelect="false" textField="text"
										valueField="id" parentField="pid" checkRecursive="false"
										virtualScroll="true" expandOnLoad="true" showTreeIcon="false"
										showFolderCheckBox="true" allowInput="true" />
									</td>
									<td colspan="1" class="form_label">投标区间:</td>
									<td colspan="1"><input style="width: 170px;"
										class="nui-textbox" id="vcTenderInterval"
										name="stockissueinfo.vcTenderInterval"
										value="<b:write property="firstGradeBond/vcTenderInterval" />" />
									</td>
								</tr>
								
								
								
					<tr>
					  <td colspan="1" width="20%" class="form_label">
						ABS类型:
					  </td>
					  <td colspan="1"  >
					  	<input style="width: 170px;" id="vcAbsType" class="mini-combobox" name="stockissueinfo.vcAbsType" value="<b:write property="firstGradeBond/vcAbsType" />" 
					     showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---"    />
					  </td>
					  <td colspan="1" width="20%"  class="form_label">
						主体评级展望:
					  </td>
					  <td colspan="1"  >
					  	<input style="width: 170px;" id="vcIssueAppraiseProspect" class="nui-dictcombobox" name="stockissueinfo.vcIssueAppraiseProspect" value="<b:write property="firstGradeBond/vcIssueAppraiseProspect" />" 
					     showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="vcIssueAppraiseProspect" />
					  </td>
					</tr>
								
								
								
								<tr>
									<td colspan="1" class="form_label">是否具有回售权:</td>
									<td colspan="1" class="radio-border-top-none">
										<div onValueChanged="vcResaleYear"
											id="stockissueinfo.cIsHaveSaleback"
											name="stockissueinfo.cIsHaveSaleback"
											value="<b:write property="firstGradeBond/cIsHaveSaleback" />"
											class="nui-dictradiogroup" dictTypeId="COF_YESORNO"></div>
									</td>
									<td colspan="1" class="form_label">是否具有赎回权:</td>
									<td colspan="1" class="radio-border-top-none">
										<div onValueChanged="cIsHaveBuyback"
											id="stockissueinfo.cIsHaveBuyback"
											name="stockissueinfo.cIsHaveBuyback"
											value="<b:write property="firstGradeBond/cIsHaveBuyback" />"
											class="nui-dictradiogroup" dictTypeId="COF_YESORNO"></div>
									</td>
								</tr>
								
								
								
								
												
			<tr>
			  <td colspan="1"  class="form_label">
				是否城投债:	 
			  </td>
			  <td colspan="1" class="radio-border-top-none">
			  	<div   id="cIsHaveCityInvestmentBond" value="<b:write property="firstGradeBond/cIsHaveCityInvestmentBond" />"  name="stockissueinfo.cIsHaveCityInvestmentBond" class="nui-dictradiogroup"  dictTypeId="COF_YESORNO" >
			  </div>
			   </td>
			  <td colspan="1"  class="form_label">
				是否担保债:	 
			  </td>
			  <td colspan="1" class="radio-border-top-none">
			    <div   id="cIsGuarantyBond" value="<b:write property="firstGradeBond/cIsGuarantyBond" />"   name="stockissueinfo.cIsGuarantyBond" class="nui-dictradiogroup"  dictTypeId="COF_YESORNO" >
			  </div>
			  </td>
			</tr>
			
			
			<tr>
			  <td colspan="1"  class="form_label">
				是否次级债:	 
			  </td>
			  <td colspan="1" class="radio-border-top-none">
			  	<div     id="cIsSubordinatedBond"   value="<b:write property="firstGradeBond/cIsSubordinatedBond" />"   name="stockissueinfo.cIsSubordinatedBond" class="nui-dictradiogroup"  dictTypeId="COF_YESORNO" >
			   </div>
			   </td>
			  <td colspan="1"  class="form_label">
				是否永续债:	 
			  </td>
			  <td colspan="1" class="radio-border-top-none">
			    <div  id="cIsPerpetualBond" value="<b:write property="firstGradeBond/cIsPerpetualBond" />"   name="stockissueinfo.cIsPerpetualBond" class="nui-dictradiogroup"  dictTypeId="COF_YESORNO" >
			 </div>
			  </td>
			</tr>
								
								
								
			
			<tr>
				<td colspan="1" class="form_label td">备注:</td>
				<td colspan="3" class="td"><input class="nui-textarea"
					id="applyInst.vcRemarks" width="60%"
					name="applyInst.vcRemarks"
					value="<b:write property="firstGradeBond/vcRemarks" />" /> <l:in
						property="workitem/activityDefID"
						targetValue="ATS_FM_FKRGSH,ATS_FM_TGLR,ATS_FM_TGFH,ATS_FM_WTRFH,ATS_FM_XXHD1,ATS_FM_XXHD2,ATS_FM_TZJLFH,ATS_FM_ZJZLSP,ATS_FM_ZXZJFH,ATS_FM_FGLDFH">
						<a class='nui-button' plain='false' iconCls="icon-download"
							onclick="windControlTrial()" style="margin-left: 50px;">风控试算</a>
					</l:in></td>
			</tr>
							</table>
							<table style="width: 100%; table-layout: fixed;" border="0"
								class="nui-form-table">
								<tr>
									<td class="form_label" align="right" style="padding: 5px 5px;">
										已投资该发行主体债券存量(万元):</td>
									<td colspan="1"><input class="nui-textbox"
										id="fsumamount" style="width: 150px;"
										onvaluechanged="calculationNetWorthScale"
										name="stockissueinfo.enCategoryMoney"
										value="<b:write property="firstGradeBond/enCategoryMoney" />" />
										<a id="" class='nui-button' plain='false' onclick="doVcNetScale()"
										iconCls="icon-reload">刷新</a></td>
									<td class="form_label" align="right" style="padding: 5px 5px;">
										产品净值规模(万元):</td>
									<td colspan="1" style="padding: 5px 5px;"><input
										class="nui-textbox" name="applyInst.enNetScale"
										id="enNetScale" style="width: 170px;"
										value="<b:write property="firstGradeBond/enNetScale" />"
										onvaluechanged="calculationNetWorthScale" /></td>
								</tr>
								<tr>
									<td class="form_label" align="right" style="padding: 5px 5px;">
										该笔债券投资占发行规模比例(%):</td>
									<td colspan="1" style="padding: 5px 5px;"><input
										class="nui-textbox asLabel"
										name="applyInst.enInvestScaleRatio" id="enInvestScaleRatio"
										style="width: 150px;" inputStyle="background-color:#f0f0f0;"
										value="<b:write property="firstGradeBond/enInvestScaleRatio" />"
										onvaluechanged="calculationNetWorthScale" readonly="readonly" />
									</td>
									<td class="form_label" align="right" style="padding: 5px 5px;">
										同一发行主体占产品净值规模比例(%):</td>
									<td colspan="1" style="padding: 5px 5px;"><input
										class="nui-textbox asLabel" id="enIssuerNetRatio"
										name="applyInst.enIssuerNetRatio" style="width: 170px;"
										inputStyle="background-color:#f0f0f0;"
										onvaluechanged="calculationNetWorthScale"
										value="<b:write property="firstGradeBond/enIssuerNetRatio" />"
										readonly="readonly" /></td>
								</tr>

								<tr>
									<td class="form_label" align="right" style="padding: 5px 5px;">
										该笔债券投资占产品净值规模比例(%):</td>
									<td colspan="1" style="padding: 5px 5px;"><input
										class="nui-textbox asLabel" id="enInvestNetRatio"
										name="applyInst.enInvestNetRatio" style="width: 150px;"
										inputStyle="background-color:#f0f0f0;"
										value="<b:write property="firstGradeBond/enInvestNetRatio" />"
										readonly="readonly" /></td>
									<td class="form_label" align="right" style="padding: 5px 5px;">
										弱流动性资产规模占产品净值规模比例(%):</td>
									<td colspan="1" style="padding: 5px 5px;"><input
										class="nui-textbox asLabel" id="enWeakNetRatio"
										name="applyInst.enWeakNetRatio" style="width: 170px;"
										inputStyle="background-color:#f0f0f0;"
										onvaluechanged="calculationNetWorthScale"
										value="<b:write property="firstGradeBond/enWeakNetRatio" />"
										readonly="readonly" /></td>
								</tr>
							</table>
						</div>
						<div title="报量录入">
							<div class="nui-toolbar"
								style="border-bottom: 0; padding: 0px; margin-top: 2px; height: 25px;">
								<!-- 交易员2不可修改 -->
								<l:in property="workitem/activityDefID"
									targetValue="ATS_FM_TGLR">
									<table style="width: 100%;">
										<tr>
											<td style="width: 100%;">&nbsp;&nbsp;报量录入</td>
											<td >
						                  		<a class="nui-button " plain="false" iconCls="icon-search" onclick="reportHistory()"  plain="false" tooltip="报量历史">
						                    		&nbsp;
						                  		</a>
						                	</td>
											<td><a class="nui-button " plain="false" iconCls="icon-add"
												onclick="gridAddRow10('datagrid10')" plain="false"
												tooltip="增加"> &nbsp; </a></td>
											<td><a class="nui-button " plain="false" iconCls="icon-remove"
												onclick="gridRemoveRow10('datagrid10')" plain="false"
												tooltip="删除"> &nbsp; </a></td>
											<td><a class="nui-button " plain="false" iconCls="icon-reload"
												onclick="gridReload10('datagrid10')" plain="false"
												tooltip="刷新"> &nbsp; </a></td>
											<td><a class="nui-button " plain="false" iconCls="icon-help"
												onclick="showTips()" plain="false" tooltip="帮助"> &nbsp; </a>
											</td>
										</tr>
									</table>
								</l:in>
								<l:in property="workitem/activityDefID"
									targetValue="ATS_FM_XXHD1,ATS_FM_XXHD2">
									<table>
										<tr>
											<td><a class="nui-button " plain="false" iconCls="icon-reload"
												onclick="gridReload10('datagrid10')" plain="false"
												tooltip="刷新"> &nbsp; </a></td>
											<td style="width: 100%;">&nbsp;&nbsp;报量录入</td>
											<td >
						                  		<a class="nui-button " plain="false" iconCls="icon-search" onclick="reportHistory()"  plain="false" tooltip="报量历史">
						                    		&nbsp;
						                  		</a>
						                	</td>
											<td><a class="nui-button " plain="false" iconCls="icon-help"
												onclick="showTips()" plain="false" tooltip="帮助"> &nbsp; </a>
											</td>
										</tr>
									</table>
								</l:in>
							</div>
							<div style="font-size: 10px; color: red;">
								<div
									style="width: 65%; float: left; padding-left: 10px; line-height: 30px;"" >
									<b>说明：</b>①报量为100万整数倍；②特殊说明请在报量说明中填写；③报价待定时为空即可；
								</div>
								<div
									style="width: 30%; float: right; padding-right: 10px; text-align: right; line-height: 30px;">
									<label>*</label>报量方式：<input style="width: 140px;"
										id="reportType" name="applyInst.cReportType"
										url="<%= request.getContextPath() %>/fm/instr/processUtil/reportData.txt"
										class="nui-dictcombobox" required="true"
										value="<b:write property="firstGradeBond/cReportType" />" />
								</div>
							</div>

							<div class="nui-datagrid" id="datagrid10" height="120px"
								showPager="false" allowSortColumn="false" allowCellSelect="true"
								allowCellEdit="true"
								url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadReport.biz.ext?bizId=<%=bizId %>"
								multiSelect="true" allowCellValid="true"
								oncellvalidation="reportEdit">
								<div property="columns">
									<div field="enReport" headerAlign="center" allowSort="true">
										<label style="color: red">*</label>报量(万元) <input id="enReport"
											class="nui-textbox" name="enReport" property="editor"
											required="true" />
									</div>
									<div field="enOffer" headerAlign="center" allowSort="true">
										报价(%) <input id="enOffer" class="nui-textbox" name="enOffer"
											property="editor" />
									</div>
									<!--<div field="enEnsureGold"  headerAlign="center" allowSort="true">
										保证金(万元)
										<input id="enEnsureGold" class="nui-textbox" name="enEnsureGold" property="editor" />
									</div>  -->
									<div field="vcReportRemark" headerAlign="center"
										allowSort="true">
										报量说明 <input id="vcReportRemark" class="nui-textbox"
											name="vcReportRemark" property="editor" />
									</div>
								</div>
							</div>
						</div>
					</div>
					<div title="投资范围" region="east" width="275" showCloseButton="false"
						showSplitIcon="true">
						<div id="dataform2">
							<!-- hidden域 -->
							<input type="hidden" class="nui-hidden"
								name="cfjyProductInvestRange.productid" />
							<table style="width: 100%; height: 100%; table-layout: fixed;"
								class="nui-form-table">
								<tr>
									<td colspan="3">产品名称： <input class="nui-textbox"
										width="100%" inputStyle="background-color:#f0f0f0;"
										name="ProductInvestRange.combProductName" readonly />
									</td>
								</tr>
								<tr>
									<td colspan="3">可投范围： <input class="nui-textarea"
										width="100%" height="120" name="ProductInvestRange.voteRange"
										inputStyle="background-color:#f0f0f0;" readonly />
									</td>
								</tr>
								<tr>
									<td colspan="3">禁投范围： <input class="nui-textarea"
										width="100%" height="120"
										name="ProductInvestRange.noCastRange"
										inputStyle="background-color:#f0f0f0;" readonly />
									</td>
								</tr>
								<tr>
									<td colspan="3">投资限制： <input class="nui-textarea"
										width="100%" height="120"
										name="ProductInvestRange.investmentLimit"
										inputStyle="background-color:#f0f0f0;" readonly />
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div title="审批内容">
				<%@include file="/fm/instr/firstGradeDebt/processControl.jsp"%>
			</div>
			<div title="流程信息"
				url="com.cjhxfund.ats.fm.comm.processGraph.flow?processInstID=<%=processinstid %>&workItemID=<%=workItemID %>&bizId=<%=bizId %>">
			</div>
		</div>
	</div>
	<script type="text/javascript">
		nui.parse();
    	//获取应用名称
    	var contextPath = '<%=request.getContextPath() %>';
    	var activityDefID = '<%=activityDefID %>';   //获取活动定义ID
    	var file_grid = nui.get("file_grid");   //附件列表对象
    	var form = new nui.Form("#dataform1");//将普通form转为nui的form
    	//nui.get("bdApplicationTime").setEnabled(false);//禁用时间
    	var grid10 = nui.get("datagrid10");
    	
    	grid10.load();
    	var processInstID="<%=request.getParameter("processInstID") %>";
    	Init("<%=vcProductCode %>");//加载投资范围 
    	//tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
		function activechangedFun(){
			//标签切换时同时刷新“今日待处理”，模块数据
			//reloadWaitConfirmFun();
		
			//获取激活的tab标签的标题
			var activeTabTitle = nui.get("tabs").getActiveTab().title;
			
			if(activeTabTitle.indexOf("审批内容")!=-1){
				//附件列表
			     var file_grid = nui.get("file_grid");
			     var file_Form = new nui.Form("#file_Form").getData(false,false);
			     file_grid.load(file_Form);
			}
		}	
    	//新增债券记录
		function gridAddRow10(datagrid){
			var grid = nui.get(datagrid);
			var totalCount = grid.getData().length;
			if(totalCount>=10){
				nui.alert("最多只能输入10支债券信息","提示");
				return;
			}else{
				grid.addRow({});
			}
			
		}
		
		//删除
		function gridRemoveRow10(datagrid){
			var grid = nui.get(datagrid);
			var rows = grid.getSelecteds();
            if (rows.length > 0) {
                grid.removeRows(rows, true);
            }
		}
		//刷新
		function gridReload10(datagrid){
			var grid = nui.get(datagrid);
			grid.reload();
		}
		/*下拉 datagrgid 控件 开始*/
		var grid2 = mini.get("datagrid2"); 
		var grid3 = mini.get("datagrid3");
		var grid4 = mini.get("datagrid4");
		var grid5 = mini.get("datagrid5");
		var grid6 = mini.get("datagrid6");
		
        var keyText2 = mini.get("keyText2");
        var keyText3 = mini.get("keyText3");
        var keyText4 = mini.get("keyText4");
        var keyText5 = mini.get("keyText5");
        var keyText6 = mini.get("keyText6");

        grid3.load();
        grid5.load();
        grid6.load();

        function onSearchClick2(e) {
            grid2.load({
                key: keyText2.value
            });
        }
        function onSearchClick3(e) {
            grid3.load({
                key: keyText3.value
            });
        }
        function onSearchClick4(e) {
            grid4.load({
                key: keyText4.value
            });
        }
        function onSearchClick5(e) {
            grid5.load({
                key: keyText5.value
            });
        }
        function onSearchClick6(e) {
            grid6.load({
                key: keyText6.value
            });
        }
        
        function onCloseClickLookup2(e){
        	var lookup2 = mini.get("lookup2");
            	lookup2.hidePopup();
        }
        function onCloseClickLookup3(e) {
            var lookup3 = mini.get("lookup3");
            	lookup3.hidePopup();
        }
        function onCloseClickLookup4(e) {
            var lookup4 = mini.get("lookup4");
            lookup4.hidePopup();
        }
       function onCloseClickLookup5(e) {
          	var lookup5 = mini.get("lookup5");
            	lookup5.hidePopup();
        }
        function onCloseClickLookup6(e) {
         	var lookup6 = mini.get("lookup6");
             	lookup6.hidePopup();    
        }
        function cleanLookup2() {
            nui.get("keyText2").setValue("");
            nui.get("lookup2").setValue("");
           	nui.get("lookup2").setText("");
        }
        function cleanLookup4() {
            nui.get("keyText4").setValue("");
            nui.get("lookup4").setValue("");
           	nui.get("lookup4").setText("");
        }
        function onClearClick2(e) {
            nui.get("keyText2").setValue("");
        }
        function onClearClick3(e) {
            nui.get("keyText3").setValue("");
        }
        function onClearClick4(e) {
            nui.get("keyText4").setValue("");
        }
        function onClearClick5(e) {
            nui.get("keyText5").setValue("");
        }
        function onClearClick6(e) {
            nui.get("keyText6").setValue("");
        }
        
		//删除
		function gridRemoveRow(datagrid){
			var grid1 = nui.get(datagrid);
			var rows = grid1.getSelecteds();
            if (rows.length > 0) {
                grid1.removeRows(rows, true);
            }
		}
		//刷新
		function gridReload1(datagrid){
			var grid1 = nui.get(datagrid);
			grid1.reload();
		}
		
		var productCombo = mini.get("productCombo");
        var combiCombo = mini.get("combiCombo");
        
        var vcAbsTypes = [{ id: 1, text: '优先' }, { id: 2, text: '次级'}];
        //债券类型变更时 改变文本禁用
        //国债A、政策银行债E1、央票C、地方债B，这些利率债的主体评级、债券评级、评级机构为非必填
        function cheangedVcStockType(e){
        	var vcStockType=nui.get("stockissueinfo.vcStockType").getValue();
        	 var vcAbsType= nui.get("vcAbsType");
		         vcAbsType.setData();
		         vcAbsType.setRequired(false);
        	
        	if(vcStockType=="A" || vcStockType=="B" || vcStockType=="C" || vcStockType=="E1"){
        		nui.get("cIssueAppraise").setRequired(false);
        		nui.get("stockissueinfo.vcIssueAppraiseOrgan").setRequired(false);
        		nui.get("stockissueinfo.cBondAppraise").setRequired(false);
        		nui.get("stockissueinfo.vcBondAppraiseOrgan").setRequired(false);
        		//删除红* ，必填样式
        		$(".requiredLable").find("label").hide();
        	}else if(vcStockType == 'M1' ||vcStockType == 'M2'|| vcStockType == 'M3'){
	          vcAbsType.setData(vcAbsTypes);
	          vcAbsType.setRequired(true);
	        
	        } else{
        		//否则添加必填校验
        		nui.get("cIssueAppraise").setRequired(true);
        		nui.get("stockissueinfo.vcIssueAppraiseOrgan").setRequired(true);
        		nui.get("stockissueinfo.cBondAppraise").setRequired(true);
        		nui.get("stockissueinfo.vcBondAppraiseOrgan").setRequired(true);
        		//$(".requiredLable").html("<lable>*</lable>"+$(".requiredLable").html());
        		$(".requiredLable").find("label").show();
        	}
        	onAccountTypeChanged();
        }
        
        //定义 判定 回售 回购选择信息
        var a=0,b=0;
        
        //回售年限
        function vcResaleYear(e){
        	
        	/*if(e.value=="1"){
        		a++;
        		$("#applyInst_nx").css("display","");
        		$(".vcResaleYear").css("display","");
        		
        	}else{
        	    //回购 没有被选择才隐藏
        		if(b==0){
        			$("#applyInst_nx").css("display","none");
        		}
        		$(".vcResaleYear").css("display","none");
        		a=0;
        	}*/
        	
        }
         //赎回年限
        function cIsHaveBuyback(e){
        	
        	/*if(e.value=="1"){
        		b++;
        		$("#applyInst_nx").css("display","");
        		$(".cIsHaveBuyback").css("display","");
        		
        	}else{
        	    //回购 没有被选择才隐藏
        		if(a==0){
        			$("#applyInst_nx").css("display","none");
        		}
        		$(".cIsHaveBuyback").css("display","none");
        		b=0;
        	}*/
        	
        }
		//产品下拉改变事件		
		function onProductChanged(e) {
			
            var vcProductCode = productCombo.getValue();
            //回填隐藏产品代码文本域
            nui.get("vcProductCode").setValue(vcProductCode);
            
			//加载组合信息
            combiCombo.setValue("");
            var url = "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryCombiInfo.biz.ext?queryType=1&vcProductCode=" + vcProductCode;
            combiCombo.setUrl(url);
            combiCombo.select(0);
             //设置投资范围界面参数
            //nui.get("tabs").tabs[1].url="<%=request.getContextPath() %>/fm/comm/ProductInvestmentRange.jsp?vcProductCode="+vcProductCode;
            //因参数改变重新tabs
            //nui.get("tabs").reloadTab(nui.get("tabs").tabs[1]);
            //装载组合相关信息
            var com=nui.get("combiCombo").getSelected();
            var data=nui.get("combiCombo").data;
        	//获取选中产品的其他数据
        	for(var i=0;i<data.length;i++){
        		//查找选中的数据
        		if(data[i].ID==com.ID){
        			//产品组合
        			nui.get("lCombiId").setValue(data[i].L_COMBI_ID);
        			nui.get("vcCombiName").setValue(data[i].VC_COMBI_NAME);
        			
        			//资产单元
        			nui.get("lAssetId").setValue(data[i].L_ASSET_ID);
        			nui.get("vcAssetNo").setValue(data[i].VC_ASSET_NO);
	        	    nui.get("vcAssetName").setValue(data[i].VC_ASSET_NAME);
        		}
        	}
        	//查询、填充投资范围
        	Init(vcProductCode);
        }
        
        //查询投资范围
        function Init(vcProductCode){
        	
            var json = nui.encode({vcProductCode : vcProductCode});
	        $.ajax({
	            url:"com.cjhxfund.ats.fm.comm.common.expandProductInvestRange.biz.ext",
	            type:'POST',
	            data:json,
	            cache:false,
	            contentType:'text/json',
	            success:function(text){
	                var returnJson = nui.decode(text);
	                var form = new nui.Form("#dataform2");//将普通form转为nui的form
	                    form.setData(returnJson);
	                   	form.setChanged(false);
	           }
			});
        }
        //控制 产品限制输入
		function onComboValidation(e){
			var items = this.findItems(e.value);
            if (!items || items.length == 0) {
                e.isValid = false;
                e.errorText = "输入值不在下拉数据中";
            }else{
            	//设置申购相关产品信息
            	var data=e.source.data;
            	//获取选中产品的其他数据
            	for(var i=0;i<data.length;i++){
            		//查找选中的数据
            		if(data[i].ID==e.value){
            			/*nui.get("vcProductCode").setValue(data[i].VC_PRODUCT_CODE);*/
            			nui.get("vcProductName").setValue(data[i].VC_PRODUCT_NAME);
            		}
            	}
            }
		}
		//限制组合输入
		function onComboValidation1(e){
			var items = this.findItems(e.value);
            if (!items || items.length == 0) {
                e.isValid = false;
                e.errorText = "输入值不在下拉数据中";
            }else{
            	//设置申购相关产品信息
            	var data=e.source.data;
            	//获取选中产品的其他数据
            	for(var i=0;i<data.length;i++){
            		//查找选中的数据
            		if(data[i].ID==e.value){
            			//产品组合
            			nui.get("lCombiId").setValue(data[i].L_COMBI_ID);
            			nui.get("vcCombiName").setValue(data[i].VC_COMBI_NAME);
            			//资产单元
	        			nui.get("lAssetId").setValue(data[i].L_ASSET_ID);
	        			nui.get("vcAssetNo").setValue(data[i].VC_ASSET_NO);
	        			nui.get("vcAssetName").setValue(data[i].VC_ASSET_NAME);
            		}
            	}
            }
		}
		
		/*验证债劵代码长度*/
        function onvalidationkCode(){
			var place=nui.get("applyInst.vcPaymentPlace").getValue();
			var code=nui.get("applyInst.vcStockCode").getValue();
			var cMarketNo="";//交易场所
			//将等级机构转为交易场所
	        if(place==3){
	        	cMarketNo=1;
	        }else if(place==4){
	        	cMarketNo=2;
	        }else{
	        	cMarketNo=5;
	        }
	        //将登记场所转换为交易场所 赋值 到交易场所
	        nui.get("applyInst.cMarketNo").setValue(cMarketNo);
	        
			if(place!="" && cMarketNo!=5 && code!=""){
				var skReadOnly = nui.get("applyInst.vcStockCode").readOnly;
				//禁用状态不提示
				if(skReadOnly != "true"){
					return true;
				}
				if(code.length>6){
					nui.alert("当前登记托管机构下，债券代码不能超6位，请修改！");
					return false;
				}
			}
			
			return true;
		}
		//赋值交易对手文本框
		 function onIssuerId3(e){
        	nui.get("stockissueinfo.vcMainUnderwriter").setValue(e.source.text);
        	var vcMainUnderwriterId3= nui.get("lookup3").getValue();
        	nui.get("vcMainUnderwriterId").setValue(vcMainUnderwriterId3);
        }
        function onIssuerId4(e){
        	nui.get("hlRivalId").setValue(e.value);
        	nui.get("lookup4").setValue(e.source.text);
        }
         function onIssuerId5(e){
        	nui.get("stockissueinfo.vcDeputyUnderwriter").setValue(e.source.text);
        	var vcMainUnderwriterId5= nui.get("lookup5").getValue();
        	nui.get("vcDeputyUnderwriterId").setValue(vcMainUnderwriterId5);
        }
         function onIssuerId6(e){
        	nui.get("stockissueinfo.vcGroupUnderwriter").setValue(e.source.text);
        	var vcMainUnderwriterId6= nui.get("lookup6").getValue();
        	nui.get("vcGroupUnderwriterId").setValue(vcMainUnderwriterId6);
        }
		var IssueronCkData=new Array();//发行人选中的历史数据
		//控制 发行人限制输入
		function onIssuerId2(e){
			var dataIssuer=grid2.data;
        	//设置发行人信息,累加查询结果，防止用户查询新数据后不选择
        	if(IssueronCkData!=null){
        		dataIssuer=dataIssuer.concat(IssueronCkData);
        	}
        	//获取发行人的其他数据
        	for(var i=0;i<dataIssuer.length;i++){
        		
        		//查找选中的数据
        		if(dataIssuer[i].lIssuerId==e.value){
        			
        			if(IssueronCkData!=null){
        				IssueronCkData=IssueronCkData.concat(dataIssuer[i]);
        			}else{
        				IssueronCkData[0]=dataIssuer[i];
        			}
        			//回填发行人信息
        			nui.get("vcIssuerName").setValue(dataIssuer[i].vcIssueName);
        			nui.get("vcIssueProperty").setValue(dataIssuer[i].vcIssueProperty);
        			nui.get("vcIndustry").setValue(dataIssuer[i].vcIndustry);
        			nui.get("vcProvince").setValue(dataIssuer[i].vcProvince);
        			nui.get("vcIssuerNameFull").setValue(dataIssuer[i].vcIssueNameFull);
        			nui.get("vcIssueAppraiseCsrc").setValue(dataIssuer[i].vcIssueAppraiseCsrc);
					nui.get("enIssuerNetValue").setValue(dataIssuer[i].enIssuerNetValue);
					nui.get("vcCityLevel").setValue(dataIssuer[i].vcCityLevel);	
        		}
        	}
          
		}
		//投标截止日期处理
		function onTimeValueChanged(e){
			
			//获取日期和时间
			var dApplicationDate=nui.get("dApplicationDate").getValue().substr(0,10);
			var dApplicationHH=nui.get("dApplicationTimeHH").getValue();
			var dApplicationMM=nui.get("dApplicationTimeMM").getValue();
			
			var dApplicationTime1=dApplicationHH+":"+dApplicationMM+":00";
			//转换为毫秒数
			var startdata=dApplicationDate+" "+dApplicationTime1;
			//注意 new date(); IE8以下 不兼容，必须将 “-” 转换  “/”
			startTime=Date.parse(new Date(startdata.replace(/-/g,"/")));
			//获取的当前时间毫秒数 .getTime() 和  Date.parse（） 作用一样
			var myDate = (new Date()).getTime();
			var bidRemind=nui.get("bidRemind").getValue();
			bidRemind=(bidRemind==""||bidRemind==null)?60:bidRemind;
			var tempTime=startTime-myDate;
			
			if(tempTime<=0){
				if(e==""){
					nui.confirm("当前时间已过投标截止时间:"+startdata+"，是否继续提交？","申购提醒",function(act){
						if(act=="ok"){
							applySubmit();
						}
					});
					return false;
				}else{
					//改变事件校验
					nui.alert("当前时间已过投标截止时间:"+startdata+"，请确认！");
					return false;
				}
			}
			if(tempTime<=(bidRemind*60000)){
				//提交校验
				if(e==""){
					nui.confirm("距离截标时间只剩 ："+parseInt(tempTime/60000)+" 分钟,不足： "+bidRemind+" 分钟，存在投标修改失败的风险，请知悉风险并确认是否需要继续提交？","申购提醒",function(act){
						if(act=="ok"){
							applySubmit();
						}
					});
					return false;
				}else{
					//改变事件校验
					nui.alert("距离截标时间只剩 ："+parseInt(tempTime/60000)+" 分钟,不足： "+bidRemind+" 分钟，存在投标修改失败的风险，请知悉风险并确认！");
					return false;
				}
			}
			
			return true;
			
		}
		//还原必填
		function addInput(inputNuiId, inputJQId){
			nui.get(inputNuiId).readOnly = "";//nui 取消禁用
			$("#" + inputJQId + " input").attr("readonly", "");// 取消 解决nui禁用IE兼容
			$("#" + inputJQId + " input").css("background-color", "");//取消 置灰
		}
		loadData();
		//加载相关key
		function loadData(){
			//获取投标截止时间
			var dApplicationTime='<b:write property="firstGradeBond/dBidLimitTime" />';
			if(dApplicationTime!="" && dApplicationTime!=null){
			
			    var str = dApplicationTime.replace(/-/g,"/");
				var date = new Date(str );
				//设置时间
				nui.get("dApplicationTimeHH").setValue(date.getHours());
				nui.get("dApplicationTimeMM").setValue(date.getMinutes());
			}
			
			//加载显隐
			vcResaleYear(nui.get("stockissueinfo.cIsHaveBuyback"));
			cIsHaveBuyback(nui.get("stockissueinfo.cIsHaveSaleback"));
			//投顾录入节点
			if(activityDefID=="ATS_FM_TGLR"){
				/*债券占比 禁止输入*/
				nui.get("enInvestScaleRatio").readOnly="readonly";
				$("#enInvestScaleRatio input").css("background-color","#f0f0f0");
				
				nui.get("enIssuerNetRatio").readOnly="readonly";
				$("#enIssuerNetRatio input").css("background-color","#f0f0f0");
				
				nui.get("enInvestNetRatio").readOnly="readonly";
				$("#enInvestNetRatio input").css("background-color","#f0f0f0");
				
				nui.get("enWeakNetRatio").readOnly="readonly";
				$("#enWeakNetRatio input").css("background-color","#f0f0f0");
			}
			//交易员1禁用数据
			if(activityDefID=="ATS_FM_XXHD1"){
				//报量信息
				nui.get("datagrid10").allowCellEdit=false;
				nui.get("reportType").readOnly="readonly";
				$("#reportType input").css("background-color","#f0f0f0");
				
				//报量方式
				readonlyInput("reportType","reportType");
				$("#reportType").removeClass("mini-required");//删除必填样式
				nui.get("reportType").setRequired(false);//取消必填
				
				//业务日期
				nui.get("bdApplicationTime").readOnly="readonly";
				$("#bdApplicationTime input").css("background-color","#f0f0f0");
			}
			if(activityDefID=="ATS_FM_XXHD2"){
				//交易员2禁用数据
				readonlyAll();
			}
			//有债券需要禁用数据
			if(nui.get("vcProcessType").getValue()==1){
				//禁用文本框
				readonly();
				
			}
			var cIsHave=nui.get("stockissueinfo.vcSpecialText").getValue();
			//特殊条款和赎回和回售联动初始化、
			if(cIsHave!="" && cIsHave!=null){
				if (cIsHave.indexOf("2") >= 0) {
					//赎回权
					nui.get("stockissueinfo.cIsHaveBuyback").setValue("1");
					readonlyInput("stockissueinfo.cIsHaveBuyback","stockissueinfo\\.cIsHaveBuyback");
				} else {
					//赎回权
					nui.get("stockissueinfo.cIsHaveBuyback").setValue("0");
					addInput("stockissueinfo.cIsHaveBuyback","stockissueinfo\\.cIsHaveBuyback");
				}
				if (cIsHave.indexOf("1") >= 0) {
					//回售权
					nui.get("stockissueinfo.cIsHaveSaleback").setValue("1");
					readonlyInput("stockissueinfo.cIsHaveSaleback","stockissueinfo\\.cIsHaveSaleback");
				} else {
					//回售权
					nui.get("stockissueinfo.cIsHaveSaleback").setValue("0");
					addInput("stockissueinfo.cIsHaveSaleback","stockissueinfo\\.cIsHaveSaleback");
				}
			}
			
			if("ATS_FM_XXHD1"==activityDefID || "ATS_FM_TGLR"== activityDefID){
				//启动债券选择功能
				//1、启动事件
				//债券简称回车事件
				$("#applyInst\\.vcStockName").keyup(function(e){
			        if(e.which == 13){
			            //这里写你要执行的事件;
			            queryOpen();
			        }
			    });
				//2、启动按钮
				//$("#queryOpen").show();
				$("#queryOpen").css("display","");
				
			}
			$.ajax({
				url:"com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadApplyInstKeys.biz.ext",
				type:'POST',
				/*data:json,*/
				cache:false,
				contentType:'text/json',
				success:function(text){
					nui.get("stockissueinfo.vcStockType").loadList(text.stockTypeData);//设置债券信息
					nui.get("stockissueinfo.vcStockType").setValue('<b:write property="firstGradeBond/vcStockType" />');//设置债券类型的默认值
					nui.get("vcIssueAppraiseCsrc").loadList(text.issueAppCrscData);//设置所属行业证监会二级
					nui.get("vcIssueAppraiseCsrc").setValue('<b:write property="firstGradeBond/vcIssueAppraiseCsrc" />');//设置所属行业证监会二级的默认值
					nui.get("bidRemind").setValue(text.timeParamApprove);
					stockIssueInfoStr=text.stockIssueInfoStr;//获取债券变量数据
					//$("#prodIfm").attr("src","<%=request.getContextPath() %>/fm/comm/fileupload/any_upload.jsp?bizId=<%=bizId %>&workItemID=<%=workItemID %>&processinstid=<%=processinstid %>&attachType=3&attachBusType=1");
					//控制 债券类型的触发事件
					cheangedVcStockType("");
				}
			});	
			//从O32加载产品净值规模相关信息
			//if(activityDefID == "ATS_FM_XXHD1"){
			//	loadVcNetScale();
			//}
		}
		/*债券占比刷新*/
		function doVcNetScale(){
			var lIssuerId= nui.get("lookup2").getValue();
			if(lIssuerId=="0" || lIssuerId==null || lIssuerId==""){
				nui.alert("请选择发行主体！");
				return;
			}
			loadVcNetScale();
		}
		
		function loadVcNetScale (){
			
			//从O32加载产品净值规模相关信息
			var lIssuerId= nui.get("lookup2").getValue();
			if(lIssuerId=="0" || lIssuerId==null || lIssuerId==""){
				return;
			}
			var vcProductCode=nui.get("productCombo").getValue();
			if(lIssuerId=="" || vcProductCode==""){
				
				return;
			}
			var json = nui.encode({vcProductCode:vcProductCode,lIssuerId:lIssuerId});
			$.ajax({
				url:"com.cjhxfund.ats.fm.instr.atsFmBiz.getVfundasset.biz.ext",
				type:'POST',
				data:json,
				cache:false,
				contentType:'text/json',
				success:function(text){
					if(text.returnCode == 1 && text.returnValue != ""){
				nui.alert(text.returnValue,"系统提示");
				return;
			}
			if(text.returnCode == 2 && text.returnValue != ""){
				nui.alert(text.returnValue,"系统提示");
				return;
			}
			if((text.enFundValue!=null || text.fsumamount!=null) && text.applyInsts!=null){
				if(text.enFundValue[0] != undefined && text.enFundValue[0].ENFUNDVALUE!=null && text.enFundValue[0].ENFUNDVALUE!=""){
				    if(text.enFundValue[0].ENFUNDVALUE != 0){
						nui.get("enNetScale").setValue(text.enFundValue[0].ENFUNDVALUE/10000);
						//设置净值规模隐藏提交值
						//nui.get("enNetScale1").setValue(text.enFundValue[0].ENFUNDVALUE/10000);
						formatNumberCommon("enNetScale",4);	
					}else{
						nui.get("enNetScale").setValue(0);
					}
				}else{
					nui.get("enNetScale").setValue(0);
				}

				if(text.fsumamount[0] != undefined && text.applyInsts[0] != undefined){						
					if(text.fsumamount[0].FSUMAMOUNT != null){
						nui.get("fsumamount").setValue(text.fsumamount[0].FSUMAMOUNT);
					}else{
						nui.get("fsumamount").setValue(0);
					}
				}else{
				 	nui.get("fsumamount").setValue(0);
				}
			}else{
				nui.get("fsumamount").setValue(0);
				
				nui.get("enNetScale").setValue(0);
			}
			calculationNetWorthScale("");//重新计算 相关4个比例
		}	
	});	
}
		
		//交易员二禁用全部债券指令/建议数据
		function readonlyAll(){
			//禁用数据
			//业务日期
			nui.get("bdApplicationTime").setEnabled(false);//禁用时间
			//产品
			readonlyInput("productCombo","productCombo");
			//组合
			readonlyInput("combiCombo","combiCombo");
			//主体类型
			readonlyInput("vcIssueProperty","vcIssueProperty");
			//登记机构
			readonlyInput("applyInst.vcPaymentPlace","applyInst\\.vcPaymentPlace");
			//主承商
			readonlyInput("lookup3","lookup3");
			readonlyInput("stockissueinfo.vcMainUnderwriter","stockissueinfo\\.vcMainUnderwriter");
			//副主承商
			readonlyInput("lookup5","lookup5");
			readonlyInput("stockissueinfo.vcDeputyUnderwriter","stockissueinfo\\.vcDeputyUnderwriter");
			//承商团
			readonlyInput("lookup6","lookup6");
			readonlyInput("stockissueinfo.vcGroupUnderwriter","stockissueinfo\\.vcGroupUnderwriter");
			
			readonlyInput("dApplicationDate","dApplicationDate");
			readonlyInput("dApplicationTimeHH","dApplicationTimeHH");
			readonlyInput("dApplicationTimeMM","dApplicationTimeMM");
			//readonlyInput("enNetScale","enNetScale");
			//readonlyInput("fsumamount","fsumamount");
			readonlyInput("applyInst.vcRemarks","applyInst\\.vcRemarks");
			$("#applyInst\\.vcRemarks textarea").attr("readonly","readonly");//解决IE兼容
			$("#applyInst\\.vcRemarks textarea").css("background-color","#f0f0f0");//置灰

			
			readonlyInput("lookup4","lookup4");
			//首次付息日
			readonlyInput("dInitInterestPaymentDate","dInitInterestPaymentDate");
			
			//报量信息
			nui.get("datagrid10").allowCellEdit=false;
			nui.get("reportType").readOnly="readonly";
			$("#reportType input").css("background-color","#f0f0f0");
			//报量方式
			readonlyInput("reportType","reportType");
			$("#reportType").removeClass("mini-required");//删除必填样式
			nui.get("reportType").setRequired(false);//取消必填
			
			//禁用迁移于2016/12/09 有债券申购数据需要回填债券，bug998
			
			readonlyInput("stockissueinfo.cIsHaveBuyback","stockissueinfo\\.cIsHaveBuyback");
			
			readonlyInput("stockissueinfo.cIsHaveSaleback","stockissueinfo\\.cIsHaveSaleback");
			
			readonlyInput("stockissueinfo.vcBondAppraiseOrgan","stockissueinfo\\.vcBondAppraiseOrgan");
			readonlyInput("stockissueinfo.vcIssueAppraiseOrgan","stockissueinfo\\.vcIssueAppraiseOrgan");
			
			$("#stockissueinfo\\.vcBondAppraiseOrgan").removeClass("mini-required");//删除必填样式
			nui.get("stockissueinfo.vcBondAppraiseOrgan").setRequired(false);//取消必填
			$("#stockissueinfo\\.vcIssueAppraiseOrgan").removeClass("mini-required");//删除必填样式
			nui.get("stockissueinfo.vcIssueAppraiseOrgan").setRequired(false);//取消必填
			
			readonlyInput("enExistLimite","enExistLimite");
			
			readonlyInput("lookup2","lookup2");
			$("#lookup2").removeClass("mini-required");//去除必填样式
			nui.get("lookup2").setRequired(false);//取消必填
			
			nui.get("lIssueBeginDate").setRequired(false);//取消必填
			
			readonlyInput("stockissueinfo.cBondAppraise","stockissueinfo\\.cBondAppraise");
			$("#stockissueinfo\\.cBondAppraise").removeClass("mini-required");
			nui.get("stockissueinfo.cBondAppraise").setRequired(false);//取消必填
			
			readonlyInput("cIssueAppraise","cIssueAppraise");
			$("#cIssueAppraise").removeClass("mini-required");//删除必填样式
			nui.get("cIssueAppraise").setRequired(false);//取消必填
			//债券全称
			readonlyInput("vcStockNameFull","vcStockNameFull");
			
			readonlyInput("enIssueBalance","enIssueBalance");
			//债券类型
			readonlyInput("stockissueinfo.vcStockType","stockissueinfo\\.vcStockType");
			//发行时间
			readonlyInput("lIssueBeginDate","lIssueBeginDate");
			$("#lIssueBeginDate").removeClass("mini-required");//删除必填样式
			//债券名称
			readonlyInput("applyInst.vcStockName","applyInst\\.vcStockName");
			//债券代码
			readonlyInput("applyInst.vcStockCode","applyInst\\.vcStockCode");
			
			//债券代码
			readonlyInput("vcTenderInterval","vcTenderInterval");
			//下一行权日
			readonlyInput("lNextExerciseDate","lNextExerciseDate");
			//特殊条款
			readonlyInput("stockissueinfo.vcSpecialText","stockissueinfo\\.vcSpecialText");
			//特殊期限
			readonlyInput("vcSpecialLimite","vcSpecialLimite");
			//投标区间
			readonlyInput("vcTenderInterval","vcTenderInterval");
			
			readonlyInput("vcIssueAppraiseCsrc","vcIssueAppraiseCsrc");
			readonlyInput("vcMortStockName","vcMortStockName");
			readonlyInput("vcMortStockAmount","vcMortStockAmount");
			readonlyInput("vcMortStockCode","vcMortStockCode");
			readonlyInput("enIssuerNetValue","enIssuerNetValue");
			readonlyInput("vcCityLevel","vcCityLevel");
			readonlyInput("lNInterestRateJumpPoints","lNInterestRateJumpPoints");
		}
		//数据有债券禁用
		function readonly(){
			
			//当前ID 中包含"."号时需要转义,	removeClass("mini-required")解决必填变色的问题		
			//禁用迁移于2016/12/09 有债券申购数据需要回填债券，bug998,放开修改的原因是：wind、O32过来的债券数据不完整，但是有债券申购有必填校验，所以需要放开修改。
			//产品
			readonlyInput("productCombo","productCombo");
			//组合
			readonlyInput("combiCombo","combiCombo");
			//登记机构
			readonlyInput("applyInst.cMarketNo","applyInst\\.cMarketNo");
			//债券代码
			readonlyInput("applyInst.vcStockCode","applyInst\\.vcStockCode");
		}
		
		/*禁用nui的input文本框，达到效果为：不可修改，可复制，置灰
		*inputNuiId nui使用的id 即 控件的id属性值
		*inputJQId jquery使用的id,jquery id不支持特殊符号 如“。”需要转义，即传入控件的id属性值转义的值
		*/
		function readonlyInput(inputNuiId,inputJQId){
			nui.get(inputNuiId).readOnly="readonly";//nui禁用
			$("#"+inputJQId+" input").attr("readonly","readonly");//解决nui禁用IE兼容
			$("#"+inputJQId+" input").css("background-color","#f0f0f0");//置灰
		}
		
    	//定义存储债券字段变量
		var stockIssueInfoStr;
		
		//获取校验债券的数据
		function getCheckStockIssueInfo(){
			//定义存储变量
			var stockIssueInfoEnt={};
			if(stockIssueInfoStr=="" || stockIssueInfoStr==null){
				nui.alert("没有获取到债券校验信息，请刷新！");
				return "";
			}else{
				var strs=stockIssueInfoStr.split(",");
				for(var i=0;i<strs.length;i++){
				//vc_issuer_name,vc_stock_name_full,vc_stock_type,en_exist_limite,en_issue_balance
				//,l_issue_begin_date,c_issue_appraise,vc_issue_property
					if(strs[i]=="vc_issuer_name_full"){
						//发行人
						var vcIssuerNameFull=nui.get("vcIssuerNameFull").getValue();
						stockIssueInfoEnt.vcIssuerNameFull=vcIssuerNameFull;
					}
					if(strs[i]=="vc_stock_name_full"){
						//债券全称
						var vcStockNameFull=nui.get("vcStockNameFull").getValue();
						stockIssueInfoEnt.vcStockNameFull=vcStockNameFull;
					}
					if(strs[i]=="vc_stock_type"){
						//债券类型
						var vcStockType=nui.get("stockissueinfo.vcStockType").getValue();
						stockIssueInfoEnt.vcStockType=vcStockType;
					}
					if(strs[i]=="en_exist_limite"){
						//发行期限
						var enExistLimite=nui.get("enExistLimite").getValue();
						stockIssueInfoEnt.enExistLimite=enExistLimite;
					}
					if(strs[i]=="en_issue_balance"){
						//发行额度
						var enIssueBalance=nui.get("enIssueBalance").getValue();
						stockIssueInfoEnt.enIssueBalance=enIssueBalance;
					}
					if(strs[i]=="l_issue_begin_date"){
						//发行日期
						var lIssueBeginDate=nui.get("lIssueBeginDate").getValue();
						lIssueBeginDate=getIntDate(lIssueBeginDate);
						stockIssueInfoEnt.lIssueBeginDate=lIssueBeginDate;
					}
					if(strs[i]=="c_issue_appraise"){
						//主体评级
						var cIssueAppraise=nui.get("cIssueAppraise").getValue();
						stockIssueInfoEnt.cIssueAppraise=cIssueAppraise;
					}
					if(strs[i]=="vc_issue_property"){
						//主体类型
						var vcIssueProperty=nui.get("vcIssueProperty").getValue();
						stockIssueInfoEnt.vcIssueProperty=vcIssueProperty;
					}
				}
				
				return stockIssueInfoEnt;
			}
		}
		var tempSave=false;//非临时
		//临时保存，仅提交数据不做流程操作
		function tempSaveData(){
			///tempSave=true;
			processSubmit(true);
		}
		 //提交数据
		function processSubmit(stype){
			tempSave=stype;
			var typeText = nui.get("operateType").getSelected().text;
			var alertText = "当前操作为【"+typeText+"】，是否确认操作？";
			if(nui.get("operateType").getSelected().id!="1" && tempSave==true){
				nui.alert("暂存操作只能为【同意】选项！","系统提示");
				return;
			}else if(tempSave==true){
				alertText = "当前操作为【暂存】，是否确认提交？";
			}
			
			
			nui.confirm(alertText,"系统提示",function(action){
				if(action == "ok"){
					//获取表单提交数据
					var form = new mini.Form("#dataform1"); 
					var operateType = nui.get("operateType").getValue();
					//解决validate（）方法调用后 交易对手数据消失问题
					var tempVcBusinessObject=nui.get("lookup4").getValue();
					//vcMainUnderwriter form.validate()后重新赋值，解决校验后值消失问题
			        var vcMainUnderwriter=nui.get("stockissueinfo.vcMainUnderwriter").getValue();
			        var vcDeputyUnderwriter=nui.get("stockissueinfo.vcDeputyUnderwriter").getValue();
			        var vcGroupUnderwriter=nui.get("stockissueinfo.vcGroupUnderwriter").getValue();
			        var vcMainUnderwriterId=nui.get("vcMainUnderwriterId").getValue();
					var vcDeputyUnderwriterId=nui.get("vcDeputyUnderwriterId").getValue();
					var vcGroupUnderwriterId=nui.get("vcGroupUnderwriterId").getValue();
					var hlRivalId=nui.get("hlRivalId").getValue();
					//校验表单
					//当操作为同意时，验证必填项是否为空
					if(operateType == 1){
						form.validate();
						//解决validate（）方法调用后 交易对手数据消失问题
						nui.get("lookup4").setValue(tempVcBusinessObject);
						nui.get("stockissueinfo.vcMainUnderwriter").setValue(vcMainUnderwriter);
			            nui.get("stockissueinfo.vcDeputyUnderwriter").setValue(vcDeputyUnderwriter);
			            nui.get("stockissueinfo.vcGroupUnderwriter").setValue(vcGroupUnderwriter);
			            nui.get("vcMainUnderwriterId").setValue(vcMainUnderwriterId);
				        nui.get("vcDeputyUnderwriterId").setValue(vcDeputyUnderwriterId);
				        nui.get("vcGroupUnderwriterId").setValue(vcGroupUnderwriterId);
				        nui.get("hlRivalId").setValue(hlRivalId);
			        	if(form.isValid()==false){
			           		nui.alert("业务信息数据格式有误，或必填项不能为空，请重新输入。","系统提示");
			           		return;
			        	}	 
		        	}else if(operateType == 2){
		        	  	 var backActivity = nui.get("backActivity").getValue();
		        	  	 if(backActivity == ""){
		        	  	   nui.alert("当操作为退回时,必须选择退办节点。","系统提示");
		        	  	   return;
		        	  	 }
		        	}  
		        	
					if(nui.get("vcProcessType").getValue()==5 && (nui.get("lookup2").getValue()==0 || nui.get("lookup2").getValue()=="")){
						nui.alert("请选择发行主体！");
						return;
					}
					
					if(onvalidationkCode()==false){return;};//校验债券代码长度
					
					//验证债券类型，无债券是需要判断债券是否存在
					if(nui.get("vcProcessType").getValue()==5){
						var stockIssueInfo=getCheckStockIssueInfo();
						var lStockIssueId=nui.get("stockissueinfo.lStockIssueId").getValue();
						
						//校验数据不能为空
						if(stockIssueInfo=="" || lStockIssueId==""){
							nui.alert("债券信息异常，请确认债券信息是否正确.");
							return;
						}
						form.loading();//加载遮罩
						//交易债券是否存在
						nui.ajax({
						    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.checkStockIssueInfo.biz.ext",
						    type: "post",
						    data: {stockIssueInfo:stockIssueInfo,
						    	vcStockCode:nui.get("applyInst.vcStockCode").getValue(),
			    				cMarketNo:nui.get("applyInst.cMarketNo").getValue(),
						    	lStockIssueId:lStockIssueId,lStockInvestNo:nui.get("applyInst.lStockInvestNo").getValue()},
						    dataType:"json",
						    success: function (text) {
						       form.unmask();//取消遮罩
						       if(text.out==false){
						       		/*nui.confirm("当前债券已经存在，是否继续发起？","系统提醒",function(a){
						       			if(a=="ok"){
						       				applySubmit();
						       			}
						       			
						       		});*/
						       		nui.alert("当前债券已经存在，请使用有债券申购！","申购提醒");
						       		return;
						       }else{
						          if(operateType != 5){
							       		//验证投标时间
										if(onTimeValueChanged("")==false){
											return;
										}
									}
						       		applySubmit();
						       }
						       
						    }
						});
					}else{
					    if(operateType != 5){
							//验证投标时间,注意该代码的位置不可以变动
							if(onTimeValueChanged("")==false){
								
								return;
							}
						}
						applySubmit();
					}
				}
				
			});	
			
		}
		
		function applySubmit(){
			 var SysId = "";
			 //提交审批意见校验
			 if(checkForm()==false){
			 	return;
			 }
			//获取表单提交数据
			var form = new mini.Form("#dataform1");
			
			//获取当前操作时间
     		var dCurOperateTime = "<b:write property="firstGradeBond/dCurOperateTime" />";
     		//判上一环节前操作时间是否大于当前服务器时间,大于时不允许提交
     		if(checkdate(dCurOperateTime) == false) return;
			
			
			//存储报量信息
			var applyInstReport;
			var reportData=getReportDatagrid(grid10,form);
			
			if(reportData==false){
				//数据不通过校验
				return;
			}
			
			//赋值获取报量相关信息
			applyInstReport=reportData.applyInstReport;
			
			/**---------------表单数据处理--------------------**/
			var formData=form.getData(false,true);
			var bizprocess;
			//获取投标金额和投标利率
			var applyInst=getReportBidInfo(applyInstReport,formData.applyInst);
			stockissueinfo=formData.stockissueinfo;
			applyInst=formData.applyInst;
			bizprocess=formData.bizProcess;//注意“P”是大写
		  	//设置债券信息
		  	if((applyInst.vcStockCode).indexOf(" ")> -1){
		  		nui.alert("债券代码不能包含空格！","申购提示");
				return;
		  	}
		  	stockissueinfo.vcStockCode=applyInst.vcStockCode;//债券代码
		  	stockissueinfo.vcStockName=applyInst.vcStockName;//债券简称
		  	var operateType1 = nui.get("operateType").getValue();
		  	//交易员2环境 将债券设置为有效
		  	if(activityDefID=="ATS_FM_XXHD2" && operateType1==1){
		  		stockissueinfo.cStatus=2;//新债发行数据状态，0草稿，2有效
		  	}
 			stockissueinfo.lValidStatus=0;//指令/建议单状态
 			//stockissueinfo.lDate=new Date();//新债录入时间
 			if(nui.get("vcProcessType").getValue()==1){
 				stockissueinfo.lValidStatus="";
 			}
 			stockissueinfo.vcPaymentPlace=applyInst.vcPaymentPlace;//登记托管机构
 			var PcMarketNo=applyInst.vcPaymentPlace;
 			//债券表登记托管机构转换
 			if(PcMarketNo==3){
	        	PcMarketNo=1;
	        }else if(PcMarketNo==4){
	        	PcMarketNo=2;
	        }else{
	        	PcMarketNo=5;
	        }
	        stockissueinfo.cMarketNo=PcMarketNo;//交易市场
 			applyInst.cMarketNo=PcMarketNo;//交易市场
		  	applyInst.vcStockType=stockissueinfo.vcStockType;//债券类型
			applyInst.cStatus=1;//复核状态 0草稿,1待复核,2正常,3合并中,4失效
			applyInst.lValidStatus=0;//指令/建议单状态:0-有效;1-无效-修改;2-无效-废弃;3-有效-退回;4-无效-退回;
			applyInst.vcStockNameFull=stockissueinfo.vcStockNameFull;
			//组装时间
			var sBidLimitTime=nui.get("dApplicationDate").text + " " + nui.get("dApplicationTimeHH").text+":"+nui.get("dApplicationTimeMM").text+":00";
			
			stockissueinfo.dBidLimitTime=sBidLimitTime;
			applyInst.dBidLimitTime=stockissueinfo.dBidLimitTime;//投标截止日
			//获取附件数量
			applyInst.lAttchCount=1;//通过查询获取该zhi
			//处理千分位提交
			var enNetScale=nui.get("enNetScale").getValue();
			enNetScale=enNetScale.replace(/,/gi,'');
			applyInst.enNetScale=enNetScale;
			
			var fsumamount=nui.get("fsumamount").getValue();
			fsumamount=fsumamount.replace(/,/gi,'');
			stockissueinfo.enCategoryMoney=fsumamount;
			 
			stockissueinfo.lIssueBeginDate=getIntDate(stockissueinfo.lIssueBeginDate);//发行日期
			//stockissueinfo.vcMainUnderwriter=applyInst.vcBusinessObject;//回填主承商
			stockissueinfo.lNextExerciseDate = stockissueinfo.lNextExerciseDate.replace(/-/gi,'').substr(0,8);//下一行权日
			//流程实例ID
			bizprocess.lProcessInstId=processInstID=="null"?"":processInstID;
			bizprocess.lBizId="<%=bizId %>";
			bizprocess.vcProcessType=nui.get("vcProcessType").getValue();
			//切换时修改改变 流程类型名称
			if(bizprocess.vcProcessType==1){
				bizprocess.vcAbstract="一级债有债券申购";
			}else{
			    bizprocess.vcAbstract="一级债无债券申购";
			}
			var stockIssueInfo;//债券提交数据
			//有债券不需要提交其他数据
			/*注释于2016/12/09 有债券申购数据需要回填债券，bug998
			if(nui.get("vcProcessType").getValue()==1){
				//定义需要提交的新债数据，注意是需要提交的（登记托管机构更改、投标截止时间），不是所有 
				stockIssueInfo={lStockIssueId:stockissueinfo.lStockIssueId,dBidLimitTime:stockissueinfo.dBidLimitTime};
			}else{
				stockIssueInfo=stockissueinfo;
			}*/
			
			stockIssueInfo=stockissueinfo;
			/**-----------------审批信息处理----------------------**/
			//判断当前环节上传附件后获取附件列表，并判断有没有选择需要用印的附件
		    var attachments = nui.get("file_grid").getData();
			/**--------------------------组装数据----------------------------**/
			//序列化成JSON  这里不能 decode ，decode会将时间字符串转换为时间格式（yyyy-MM-ddThh:mm:ss），该格式带“T”EOS无法解析为TimeStamp格式，只能识别年月日。
			var bpsParam = formData.bpsParam;
			if(activityDefID!="ATS_FM_TGLR" && activityDefID!="ATS_FM_TGFH" && activityDefID!="ATS_FM_WTRFH"){
				bpsParam.FaxNumber = nui.get("FaxNumber").getText();
				var FaxNumber =nui.get("FaxNumber").getText().split(",");
					if(bpsParam.FaxNumber!="" && bpsParam.FaxNumber!=null){
						var checkFax = /^((\d{3,4}-)?\d{7,8})(\d{7,8})?$/;
				    	for(var i=0;i<FaxNumber.length;i++ ){
				    	    if(!checkFax.test(FaxNumber[i])){
								nui.alert("传真格式为:XXX-12345678或XXXX-1234567或XXXX-12345678或12345678","系统提示");
								return;
						     }
				    	} 
			    	}
			    	bpsParam.vcTelephoneNumber =nui.get("vcTelephoneNumber").getText();
				    var phoneNumber =nui.get("vcTelephoneNumber").getText().split(",");
					if(bpsParam.vcTelephoneNumber!="" && bpsParam.vcTelephoneNumber!=null){
				    	var checkPhone = /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
				    	for(var i=0;i<phoneNumber.length;i++ ){
				    	    if(!checkPhone.test(phoneNumber[i])){
								nui.alert("联系电话格式不正确,多个号码时，用英文逗号分隔","系统提示");
								return;
				            }
				    	} 
				    }
			}
			var json = {attachments:attachments,workItemID:"<%=workItemID %>",
			applyInst:applyInst,applyInstReport:applyInstReport,bizprocess:bizprocess,
			stockIssueInfo:stockIssueInfo,pmprcaprvinfo:formData.pmprcaprvinfo,
			bpsParam:bpsParam,tempStockissueinfo:formData.tempStockissueinfo,
			userTempData:formData.userTempData};
			//提交提示
			if(activityDefID!="ATS_FM_TGLR" && activityDefID!="ATS_FM_XXHD2"){
				//判断id是否为空，为空给出提示是否提交，不为空时提示选择了几个附件
			    
			      	//判断当前环节上传附件后获取附件列表，并判断有没有选择需要用印的附件
			      	var attachments = nui.get("file_grid").getData();
					for(var i = 0;i<attachments.length;i++){
					  if(attachments[i].vcAnnexSeal == 1){
					  	 if(SysId == ""){
					  	 	SysId = attachments[i].lAttachId; 
					  	 }else{
					  	 	SysId = SysId + "," + attachments[i].lAttachId;
					  	 }
					  }
					}
				//判定用印文件是否为空
				if(SysId!=""){
					 //不为空提示用印文件个数
					 var Array = String(SysId).split(",");
					 nui.confirm("已选择" + Array.length + "个需要用印的附件，确认是否提交！","系统提示",function(action){
			          	if(action == "ok"){
			             	submitAjax(json);
			          	}else{
			            	return;
			          	}
		  			});
				}else{
					//没有用印文件 提示提交
					nui.confirm("没有选择需要用印的附件，确认是否提交！","系统提示",function(action){
		   	   			if(action =="ok"){
		          			submitAjax(json);
		       			}else{
		         			return;
		       			}
					});
				}
			}else{
				submitAjax(json);
			}
		}
		function submitAjax(json){
			form.loading();//加载遮罩
			var ajaxUrl="com.cjhxfund.ats.fm.instr.FirstGradeBond.updateApplyInstBs.biz.ext";
			if(tempSave==true){
				//临时提交数据
				ajaxUrl="com.cjhxfund.ats.fm.instr.FirstGradeBond.saveApplyInstBs.biz.ext";
			}
			//提交
			nui.ajax({
			    url: ajaxUrl,
			    type: "post",
			    data: json,
			    dataType:"json",
			    success: function (text) {
			    	form.unmask();//取消遮罩
			    	if(text.out==1){
			    		nui.alert("提交成功","系统提示",function(a){
			    		  try{
			    		     if (!!window.ActiveXObject || "ActiveXObject" in window){//如果是IE浏览器
				              	 window.opener.history.go(0);
				              }else{
				              	 window.opener.reloadData();
				              }
			    		  }catch(e){
			    		  }
			    		  //返回我的代办任务页面
		    			  CloseWindow("confirmSuccess");
	    					
	    				}); 
			    	}else if(text.out==3){
			    		nui.alert("该产品未设置投资经理，请先设置投资经理！");
			    	}else if(text.out==2){
			    		nui.alert("流程待办任务已经被处理，无需再处理！");
			    	}else{
			    		nui.alert("系统异常，请联系管理员！");
			    	}
			    	
			        //alert("提交成功，返回结果:" + text.out);    
			    }
			});
		}
     //计算相关净值规模、投标金额
    function calculationNetWorthScale(e){
    	var enIssueBalance = nui.get("enIssueBalance").getValue().replace(/,/gi,'');        //发行规模
        //var enInvestBalance = '<b:write property="firstGradeBond/enInvestBalance" />'; 	    //投标金额
        var reportData=getReportDatagrid(grid10,form);
			
		if(reportData==false){
			//数据不通过校验
			return;
		}
        //赋值获取报量相关信息
		var applyInstReport=reportData.applyInstReport;
		
		/**---------------表单数据处理--------------------**/
		var formData=form.getData(false,true);
        //获取投标金额
	    var enInvestBalance=getReportBidInfo(applyInstReport,formData.applyInst).enInvestBalance;  //报量修改，重新计算投标金额
       	var enNetScale = nui.get("enNetScale").getValue().replace(/,/gi,'');  				//净值规模
       	var enCategoryMoney = nui.get("fsumamount").getValue().replace(/,/gi,'');  	      	//债券存量
       	//验证净值规模是否为正数
     	var reg = /^(([0-9]+)|([0-9]+\.[0-9]{1,6}))$/;
     	if(enNetScale != "" && enNetScale != null){
			if (!reg.test(enNetScale))
			{
				nui.alert("净值规模不能包含负数、字母、特殊字符、空格，请输入正数如4。","系统提示");
				return false;
			}
		}	
		
       	//当发行规模与投标金额不为空时计算该笔债券投资占发行规模比例
	    //公式为投标金额/发行规模
	    if(enIssueBalance != "" && enInvestBalance != "" && enIssueBalance != 0 && enInvestBalance != 0){
	       nui.get("enInvestScaleRatio").setValue(((enInvestBalance/(enIssueBalance * 10000)) * 100).toFixed(6));
	    }else{
	      nui.get("enInvestScaleRatio").setValue(0);
	    }
	       
	    //当投标金额、债券存量与净值规模都不为空时计算同一发行人占产品净值规模比例
	    //公式为(本次投标金额+主体发行债券存量)/净值规模
	    if(enNetScale != "" && (enInvestBalance != "" || enCategoryMoney != "")){
	      if(enNetScale != 0){
	      	nui.get("enIssuerNetRatio").setValue((((Number(enInvestBalance) + Number(enCategoryMoney))/enNetScale) * 100).toFixed(6));
		  }else{
	        nui.get("enIssuerNetRatio").setValue(0);
	      }	    
	    }else{
	    	nui.get("enIssuerNetRatio").setValue(0);
	    }
	       
	    //当净值规模与投标金额不为空时计算该笔债券投资占产品净值规模比例
	    //公式为投标金额/净值规模
	    if(enNetScale != "" && enInvestBalance != "" && enNetScale != 0 && enInvestBalance != 0){
	       nui.get("enInvestNetRatio").setValue(((enInvestBalance/enNetScale) * 100).toFixed(6));
	    }else{
	       nui.get("enInvestNetRatio").setValue(0);
	    }
	    return true;
    }	
    //将时间格式字符串转换为int类型
	function getIntDate(dateStr){
		if(dateStr=="" || dateStr==null){
			return "";
		}
		dateStr=dateStr.substr(0,10);//0开始，取后面10位
		dateStr=dateStr.replace(/-/g, "");
		return dateStr;
	}
    //tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	function activechangedFun(){
		//标签切换时同时刷新“今日待处理”，模块数据
		//reloadWaitConfirmFun();
	
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tabs").getActiveTab().title;
		
		if(activeTabTitle.indexOf("审批内容")!=-1){
			//附件列表
		     var file_grid = nui.get("file_grid");
		     var file_Form = new nui.Form("#file_Form").getData(false,false);
		     file_grid.load(file_Form);
		}
	}	
	 //缴款面值
	 function payFaceValueFun(){
	    formatNumberCommon("payFaceValue",4);
	 }
	 
	 //缴款金额(万元)
     function paymentMoneyFun(){
         formatNumberCommon("paymentMoney",4);
     }
     
     function payVcBallotNumber(){
     	var ballotNumber = nui.get("vcBallotNumber").getValue().replace(/,/gi,'');
     	nui.get("payFaceValue").setValue(ballotNumber/100);
     	
     	formatNumberCommon("vcBallotNumber",4);  //中签数量加入千分位
     	payFaceValueFun();  //缴款面值加入千分位
     	
     	nui.get("enBallotAmount").setValue(ballotNumber);      //将中标数量设置为隐藏值
     	nui.get("enPayFaceValue").setValue(ballotNumber/100);  //将缴款面值设置为隐藏值
     }
      
     function loademployeeGrid(){ 
		//附件列表查询
    	var file_grid = nui.get("file_grid");
		var file_Form = new nui.Form("#file_Form").getData(false,false);
		file_grid.load(file_Form);
     }
     
     //清空债券类型选择
	function onCloseClick(e) {
        var obj = e.sender;
        obj.setText("");
        obj.setValue("");
    }
	//提供给附件上传调用
	function refreshFile(){}
	 //调用附件查询方法
     loademployeeGrid();	
     function onAddClick(){
	  	var url = "<%= request.getContextPath() %>/fm/baseinfo/issuerInfo/addIssuerInfo.jsp";
		var title = "新增发行主体";
		var width = "400";
		var height = "390";
		nui.open({
			url: url,
			title: title, width: width, height: height,
			onload: function () {//弹出页面加载完成
				
			},
			ondestroy: function (action) {//弹出页面关闭前,把新增的主体简称返回赋值给查询框
					keyText2.setValue(action);
					onSearchClick2();
					
					keyText3.setValue(action);
					onSearchClick3();
					
					keyText4.setValue(action);
					onSearchClick4();

					keyText5.setValue(action);
					onSearchClick5();

					keyText6.setValue(action);
					onSearchClick6();
			}
		});
	  }
	  function onAddClick4(){
	  	var url = "<%= request.getContextPath() %>/fm/baseinfo/issuerInfo/addTraderivalInfo.jsp";
			var title = "新增交易对手";
			var width = "450";
			var height = "330";
			nui.open({
				url: url,
				title: title, width: width, height: height,
				onload: function () {//弹出页面加载完成
					
				},
				ondestroy: function (action) {//弹出页面关闭前
					keyText4.setValue(action);
					onSearchClick4();
				}
			});
	  }
	  var stockIssueInfoTemp;//存放选择的债券
		//打开查询债券界面
		function queryOpen(){
			var name=nui.get("applyInst.vcStockName").getValue();
			var templStockInvestNo = nui.get("tempStockissueinfo.lStockInvestNo").getValue();//保存最最初InvestNo
			var templStockIssueId = nui.get("tempStockissueinfo.lStockIssueId").getValue();//保存最最初IssueId
			var tempCStatus = nui.get("tempStockissueinfo.cStatus").getValue();
			//解决切债券查不到附件问题
			var mapBizId=nui.get("mapBizId").getValue();
           	var mapAttachBusType=nui.get("mapAttachBusType").getValue();
           	var mapProcessinstid=nui.get("mapProcessinstid").getValue();
			nui.open({
                    url: "<%=request.getContextPath() %>/fm/instr/firstGradeDebt/queryStockName.jsp",
                    title: "查询债券", width: 600, height: 350,
                    onload: function () {
                        //弹出页面加载完成
	                    var iframe = this.getIFrameEl();
	                    var data = {vcStockName:name};//传入页面的json数据
	                    iframe.contentWindow.setFormData(data);
                    },
                    ondestroy: function (data) {//弹出页面关闭前
                    //判定回填数据
                    if(data!=null && data!="" && data!="close"){
                    	var form = new nui.Form("#dataform1");//将普通form转为nui的form
                    	var formData = form.getData(false,true);      //获取表单多个控件的数据
                    	stockIssueInfoTemp=nui.decode(data);//存储 ，提交时使用
                    	//console.log(data);
	                    form.setData({stockissueinfo:nui.decode(data),bizProcess:formData.bizProcess,applyInst:formData.applyInst,bpsParam:formData.bpsParam,pmprcaprvinfo:formData.pmprcaprvinfo});
	                    //form.setData({applyInst:data});
	                   	form.setChanged(false);
	                   	nui.get("applyInst.cMarketNo").setValue(data.vcPaymentPlace);
	                   	nui.get("applyInst.vcStockCode").setValue(data.vcStockCode);
	                   	nui.get("applyInst.vcStockName").setValue(data.vcStockName);
	                   	//发行时间转换时间格式将数字类型 转为时间格式
	                   	nui.get("lIssueBeginDate").setValue(dateTemp(stockIssueInfoTemp.lIssueBeginDate));
	                   	
	                   	nui.get("lookup3").setText(data.vcMainUnderwriter);
	                   	nui.get("lookup2").setText(data.vcIssuerNameFull);
	                   	
	                   	//nui.get("bdApplicationTime").setValue((new Date()));
    					nui.get("bdApplicationTime").setEnabled(false);
    					
    					nui.get("applyInst.lStockInvestNo").setValue(stockIssueInfoTemp.lStockInvestNo);
    					nui.get("tempStockissueinfo.lStockInvestNo").setValue(templStockInvestNo);//设置最最初InvestNo
    					nui.get("tempStockissueinfo.lStockIssueId").setValue(templStockIssueId);//设置最最初IssueId
    					nui.get("tempStockissueinfo.cStatus").setValue(tempCStatus);//设置最最初状态
						
    					//更换流程标题
    					$("#processTitle").html('[<b:write property="firstGradeBond/lInvestNo" />]-<b:write property="firstGradeBond/vcProductName" />-'+stockIssueInfoTemp.vcStockName);
	                   	//设置为有债券申购
	                   	nui.get("vcProcessType").setValue("1");
	                   	//触发债券变更
	                   	cheangedVcStockType("");
	                   	//改变表单相关债券数据为不可以操作
	                   	readonly();
	                   	if(stockIssueInfoTemp.cIsHaveBuyback=="" || stockIssueInfoTemp.cIsHaveBuyback==null){
	                   		//赎回权
			           		nui.get("stockissueinfo.cIsHaveBuyback").setValue("0");
	                   	}
	                   	if(stockIssueInfoTemp.cIsHaveSaleback=="" || stockIssueInfoTemp.cIsHaveBuyback==null){
				           	//回售权
				           	nui.get("stockissueinfo.cIsHaveSaleback").setValue("0");
	                   	}
	                   	nui.get("mapBizId").setValue(mapBizId);
	                   	nui.get("mapAttachBusType").setValue(mapAttachBusType);
	                   	nui.get("mapProcessinstid").setValue(mapProcessinstid);
	                   	refreshFile();
                    }
                }
             });
		}
		//时间转换
		function dateTemp(oldData){
			oldData=oldData+"";
			if(oldData==0 || oldData=="" || oldData=="null"){
				return "";
			}
			
			var datas=oldData.indexOf("-");
			if(datas>=0){
				return oldData;
			}
			var yy=oldData.substr(0,4);//0开始，截取后面4位
			var mm=oldData.substr(4,2);//4开始，截取后面2位
			var dd=oldData.substr(6,2);
			
			return yy+"-"+mm+"-"+dd;
		}
		
		//风控试算
	function windControlTrial(){
		var form = new nui.Form("#dataform1");
		var applyInst = form.getData(false,true).applyInst;
		var stockissueinfo = form.getData(false,true).stockissueinfo;
		var PcMarketNo=applyInst.vcPaymentPlace;
 		//债券表登记托管机构转换
 		if(PcMarketNo==3){
	        PcMarketNo=1;
	    }else if(PcMarketNo==4){
	        PcMarketNo=2;
	     }else{
	        PcMarketNo=5;
	     }
 		applyInst.cMarketNo=PcMarketNo;//交易市场
 			
		applyInst.vcStockType=stockissueinfo.vcStockType;//债券类型
		applyInst.cStatus=1;//复核状态 0草稿,1待复核,2正常,3合并中,4失效
		applyInst.lValidStatus=0;//指令/建议单状态:0-有效;1-无效-修改;2-无效-废弃;3-有效-退回;4-无效-退回;
		applyInst.vcStockNameFull=stockissueinfo.vcStockNameFull;
		applyInst.vcBusinessObject=nui.get("hlRivalId").getValue();//交易对手需要传ID
		//将净值规模去掉千分位在设置给指令/建议信息对象
		var enNetScale=nui.get("enNetScale").getValue();
			enNetScale=enNetScale.replace(/,/gi,'');
			applyInst.enNetScale=enNetScale;
		//序列化成JSON
		var json = mini.encode({applyInst:applyInst, activityDefID:activityDefID}); 
		
		form.loading();//加载遮罩
		//提交
		nui.ajax({
		    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.windControlTrial.biz.ext",
		    type: "post",
		    data: json,
		    dataType:"json",
		    success: function (text) {
		    	var returnJson = nui.decode(text);
		    	form.unmask();//取消遮罩
		    	if(returnJson.returnCode == 4){
	    			var userName='<%=userId %>';          //拼音ID
                    //获得当前参与者
					var json = nui.encode({userId:userName});
					$.ajax({
						url:"com.cjhxfund.ats.fm.instr.FirstGradeBond.isDealer.biz.ext",
						type:'POST',
						data:json,
						cache:false,
						async:false,
						contentType:'text/json',
						success:function(text){
					       //1为交易员
				           if(text.isInvestment==1){
					           nui.confirm("O32没有该债券，是否将债券推送至待导出O32列表！","系统提示",function(action){
				    				if(action=="ok"){
				    					var lStockIssueId=nui.get("stockissueinfo.lStockIssueId").getValue();
				    					//调用推送喔O32方法
				    					exportTempUtil(lStockIssueId);
				    				}
				    			});
				    			return;
					        }else{
					    	    nui.alert(returnJson.rtnMsg,"系统提示");
					            return;
	    					}
						}
					});		 
	    		}else if(returnJson.returnCode == 0){
		    	 	if(returnJson.ishave==false){
		    			nui.alert("O32没有该债券，只能调用本地风控！","系统提示",function (){
		    				nui.alert("风控试算成功,未触发风控。","系统提示");
		    			});
	    			}else{
	    				nui.alert("风控试算成功,未触发风控。","系统提示");
	    			}
		    	 	return;
		    	}else if (returnJson.returnCode == -1){
	    			nui.alert(returnJson.rtnMsg,"系统提示");
	    			return;
		    	}else if(returnJson.returnCode != 0){
		    		if(checkRiskRet(returnJson.riskMsg)==false){
			    			return;
			    	}
		    		//判断债券是否存在o32
			    		if(returnJson.ishave==false){
			    			nui.alert("O32没有该债券，只能调用本地风控！","系统提示",function (){
			    			
			    				nui.open({
				    	  			url: "<%=request.getContextPath() %>/fix/riskApiControlDetailList.jsp",
				                    title: "风控试算反馈消息展示", width: 800, height: 390,
				                    onload: function () {
				                        //弹出页面加载完成
					                    var iframe = this.getIFrameEl();
					                    iframe.contentWindow.SetData(returnJson.riskMsg,3);
				                    },
				                    ondestroy: function (action) {//弹出页面关闭前
					                 
				                	}
				    	  		});
			    			});
		    	  			
			    		}else{
			    			nui.open({
			    	  			url: "<%=request.getContextPath() %>/fix/riskApiControlDetailList.jsp",
			                    title: "风控试算反馈消息展示", width: 800, height: 390,
			                    onload: function () {
			                        //弹出页面加载完成
				                    var iframe = this.getIFrameEl();
				                    iframe.contentWindow.SetData(returnJson.riskMsg,3);
			                    },
			                    ondestroy: function (action) {//弹出页面关闭前
				                 
			                	}
			    	  		});
			    		}
	    			
		    		
		    	}
		    }
		});
		
	} 
	
	 function onAccountTypeChanged() {
	 		var vcStockType=nui.get("stockissueinfo.vcStockType").getValue();
	 		 var vcAbsType=   nui.get("vcAbsType");
	         vcAbsType.setData();
	         vcAbsType.setRequired(false);
	         
	 		if(vcStockType!="" && vcStockType!=null){
		        if(vcStockType == 'Q' || vcStockType == 'O' ){
		        	$("#morStockNameAndCode").show();
		        	$("#morStockAmount").show();
				    nui.get("vcMortStockName").setRequired(true);
				    nui.get("vcMortStockCode").setRequired(true);
				    nui.get("vcMortStockAmount").setRequired(true);
				    
		        }else if(vcStockType == 'M1' || vcStockType == 'M2'|| vcStockType == 'M3'){
		           vcAbsType.setValue('<b:write property="firstGradeBond/vcAbsType" />');//设置ABS类型默认值
	               vcAbsType.setData(vcAbsTypes);
	               vcAbsType.setRequired(true);
	        
	        }else{
			        nui.get("vcMortStockName").setRequired(false);
				    nui.get("vcMortStockCode").setRequired(false);
				    nui.get("vcMortStockAmount").setRequired(false);
				    $("#morStockNameAndCode").hide();
		            $("#morStockAmount").hide();
		        }
		    }
        }
        
        //初始化传真参数
        function initFaxParameter(){
        	nui.ajax({
			    url: "com.cjhxfund.ats.fm.instr.FirstGradeBond.updateApplyInstBs.biz.ext",
			    type: "post",
			    data: json,
			    dataType:"json",
			    success: function(text){
			    	
			    }
			    	
			});
        }
    </script>
	<script
		src="<%=request.getContextPath()%>/fm/instr/processUtil/process.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		//转换行权日期
	    var lNextExerciseDate = dateTemp('<%=lNextExerciseDate%>');
		nui.get("lNextExerciseDate").setValue(lNextExerciseDate);
		//获取回退的实例对象
		loadActivities();
		//债券类别为可转债时，显示股票名称，股票代码，抵押股票数量
		onAccountTypeChanged();
		
		//初始化产品净值规模(万元)和已投资该发行主体债券存量(万元)的三位一逗
		formatNumberCommon("fsumamount",4);
		formatNumberCommon("enNetScale",4);
		
		function inIt(){
			var enIssueBalance = "<b:write property="firstGradeBond/enIssueBalance" />";        //发行规模
       		var enInvestBalance = "<b:write property="firstGradeBond/enInvestBalance" />"; 	    //投标金额
       		var enNetScale = "<b:write property="firstGradeBond/enNetScale" />";  				//净值规模
       		var enCategoryMoney = "<b:write property="firstGradeBond/enCategoryMoney" />";      //债券存量
       		
       	
       	   //当发行规模与投标金额不为空并且不为0时计算该笔债券投资占发行规模比例
	       //公式为投标金额/发行规模
	       if(enIssueBalance != "" && enInvestBalance != "" && enIssueBalance != 0 && enInvestBalance != 0){
	         nui.get("enInvestScaleRatio").setValue(((enInvestBalance/(enIssueBalance * 10000)) * 100).toFixed(6));
	       }else{
	   		 nui.get("enInvestScaleRatio").setValue(0);
		   }
	       
	       //当投标金额、债券存量与净值规模都不为空并且都不为0时计算同一发行人占产品净值规模比例
	       //公式为(本次投标金额+主体发行债券存量)/净值规模
	       if(enNetScale != "" && (enInvestBalance != "" || enCategoryMoney != "")){
	       	 if(enNetScale != 0){
	         	nui.get("enIssuerNetRatio").setValue((((Number(enInvestBalance) + Number(enCategoryMoney))/enNetScale) * 100).toFixed(6));
	       	 }else{
	       	 	nui.get("enIssuerNetRatio").setValue(0);
	       	 }
	       }else{
	   			nui.get("enIssuerNetRatio").setValue(0);
		   }
	       
	       //当净值规模与投标金额不为空并且不为0时计算该笔债券投资占产品净值规模比例
	       //公式为投标金额/净值规模
	       if(enNetScale != "" && enInvestBalance != "" && enNetScale !=0 && enInvestBalance != 0){
	         nui.get("enInvestNetRatio").setValue(((enInvestBalance/enNetScale) * 100).toFixed(6));
	       }else{
	   		 nui.get("enInvestNetRatio").setValue(0);
		   }
		}
		function beforenodeselect(e) {
            //禁止选中父节点
            if (e.isLeaf == false) e.cancel = true;
        	}
		if(activityDefID == "ATS_FM_XXHD1"){
			//初始化调用
			inIt();
		}
		var cApplyInstType = nui.get("cApplyInstType").getValue();
     	var columns = file_grid.columns;
     	if(((cApplyInstType != null || cApplyInstType != "") && activityDefID == "ATS_FM_TGLR") || activityDefID == "ATS_FM_XXHD1" || activityDefID == "ATS_FM_CZ_ZBFH" || activityDefID == "ATS_FM_CZ_SFFXYYY"){
     		columns[columns.length - 1].header = "<label style='color: red;'>是否需要归档</label>";
     		columns[columns.length - 2].readOnly = true;
     		columns[columns.length - 3].header = "<label style='color: red;'>是否需要用印</label>";
     	}else{
     		columns[columns.length - 3].readOnly = true;
     		columns[columns.length - 2].readOnly = true;
     		columns[columns.length - 1].readOnly = true;
     	}
     	
     	function showTips() {
			var reportTypeMark = "";
			var json = '{"paramKey":"REPORT_TYPE_MARK"}';
			var url = "<%=request.getContextPath()%>/fm/instr/firstGradeDebt/reportMark.jsp";
			var title = "报量方式说明";
			var width = "610";
			var height = "618";
			//从系统参数获得报量方式
			$.ajax({
				url:"com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.getParamValue.biz.ext",
				type:'POST',
				data:json,
				cache:false,
				async:false,
				contentType:'text/json',
				success:function(data){
					reportTypeMark = data.paramValue;
				}
			});
			nui.open({
				url: url,
				title: title, width: width, height: height,
				onload: function () {//弹出页面加载完成
					 var iframe = this.getIFrameEl(); 
        			//调用弹出页面方法进行初始化
        			iframe.contentWindow.SetData(reportTypeMark); 
				},
				ondestroy: function (action) {//弹出页面关闭前,把新增的主体简称返回赋值给查询框
				}
			});
	}
	function checkIntValue(obj,name){  
	       var reg = new RegExp("^[0-9]*[1-9][0-9]*$");  
		    if(!reg.test(obj.value)){ 
		        nui.alert("请检查数据,该项只能输入整数!");  
		        nui.get(name).setValue("");
		        return;
		    }  
	  }
	  
	  //查询债券详情
	  function queryStockDetail(){
	    var lStockIssueId= nui.get("stockissueinfo.lStockIssueId").getValue();
	  	nui.open({
                    url: "<%=request.getContextPath()%>/fm/baseinfo/firstGradeDebt/debtIssueQueryDetail.jsp?lStockIssueId="+lStockIssueId,
						title : "详细信息",
						width : 980,
						height : 700,
						//allowResize:false,
						onload : function() {
							var iframe = this.getIFrameEl();
							iframe.contentWindow.initForm();
						},
						ondestroy : function(action) {
							if (action == "saveSuccess") {
								grid.reload();
							}
						}
					});
		}
		//还原必填
		function addInput(inputNuiId, inputJQId){
			nui.get(inputNuiId).readOnly = "";//nui 取消禁用
			$("#" + inputJQId + " input").attr("readonly", "");// 取消 解决nui禁用IE兼容
			$("#" + inputJQId + " input").css("background-color", "");//取消 置灰
		}
		function onCloseClickValueEmpty1(e){
			//赎回权
			nui.get("stockissueinfo.cIsHaveBuyback").setValue("0");
			readonlyInput("stockissueinfo.cIsHaveBuyback","stockissueinfo\\.cIsHaveBuyback");
			//回售权
			nui.get("stockissueinfo.cIsHaveSaleback").setValue("0");
			readonlyInput("stockissueinfo.cIsHaveSaleback","stockissueinfo\\.cIsHaveSaleback");
			onCloseClickValueEmpty(e);
		}
		function checkvcSpecialText(e) {
			var cIsHave = e.value;
			if (cIsHave.indexOf("2") >= 0) {
				//赎回权
				nui.get("stockissueinfo.cIsHaveBuyback").setValue("1");
				readonlyInput("stockissueinfo.cIsHaveBuyback","stockissueinfo\\.cIsHaveBuyback");
			} else {
				//赎回权
				nui.get("stockissueinfo.cIsHaveBuyback").setValue("0");
				addInput("stockissueinfo.cIsHaveBuyback","stockissueinfo\\.cIsHaveBuyback");
			}
			if (cIsHave.indexOf("1") >= 0) {
				//回售权
				nui.get("stockissueinfo.cIsHaveSaleback").setValue("1");
				readonlyInput("stockissueinfo.cIsHaveSaleback","stockissueinfo\\.cIsHaveSaleback");
			} else {
				//回售权
				nui.get("stockissueinfo.cIsHaveSaleback").setValue("0");
				addInput("stockissueinfo.cIsHaveSaleback","stockissueinfo\\.cIsHaveSaleback");
			}
		}
		
		// 报量历史展示
		function reportHistory(){
			var investNo = nui.get("applyInst.lInvestNo").value;
			
			nui.open({
				url: "<%= request.getContextPath() %>/fm/comm/showReportHistory.jsp",
				title: "历史报量", 
				width: 650, 
				height: 450,
				onload: function () {//弹出页面加载完成
					 var iframe = this.getIFrameEl(); 
        			//调用弹出页面方法进行初始化
        			iframe.contentWindow.setData(investNo); 
				},
				ondestroy: function (action) {//弹出页面关闭前,把新增的主体简称返回赋值给查询框
				}
			});
		}
	</script>
</body>
</html>