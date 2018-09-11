<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-03-08 17:21:50
  - Description:
-->
<head>
<title>二级债任务审批</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="<%= request.getContextPath() %>/riskMgr/js/riskMgrComm.js"></script>
	
</head>
<%
    String processInstID = request.getParameter("processInstID");
	String workItemID = request.getParameter("workItemID");
	String currentState = request.getParameter("currentState");
 %>
<body style="width: 100%; height:100%; margin: 0px; overflow:auto;">
<div id="tabs" class="nui-tabs" height="100%"> 
	 <div title="基本信息"> 
		<!-- 主体内容 -->
		<div region="center" style="width:100%; height:570px">
			<!-- 买卖指令/建议信息 -->
			<div title="买卖指令/建议信息" id="transManagePanel" class="nui-panel" iconCls="icon-edit" style="width:100%;" 
   				 showCollapseButton="true" collapseOnTitleClick="true">
   				<div style="padding-top:5px;" id="instructInfoForm" class="nui-form">
			  		<input class="nui-hidden" name="processInstID" id="processInstID" value="<%=processInstID%>" />
					<table style="width: 100%; table-layout: fixed;" class="nui-form-table">
						<tr>
							<td class="form_label td1" width="17%" align="right">录入人员:</td>
							<td colspan="1" width="16%">
								<input name="VC_INITIATOR_ID" id="L_INITIATOR_ID" width="170" class="nui-textbox" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">业务类型:</td>
							<td colspan="1" width="16%">
								<input name="VC_BIZ_TYPE" id="VC_BIZ_TYPE" class="nui-dictcombobox" width="170" valueField="dictID" textField="dictName" dictTypeId="bizTypeTransaction" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">录入时间:</td>
							<td colspan="1" width="16%">
								<input name="T_INITIATE_TIME" id=T_INITIATE_TIME width="170" class="nui-textbox" readonly/>
							</td>
						</tr>
						<tr>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>产品名称:</td>
							<td colspan="1" width="16%">
								<input name="VC_PRODUCT_NAME" id="VC_PRODUCT_NAME" width="170" class="nui-textbox" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>委托方向:</td>
							<td colspan="1" width="16%">
								<input name="VC_ENTRUST_DIRECTION" id="VC_ENTRUST_DIRECTION" width="170" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="entrustDirectionTransaction" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>券面金额（万元）:</td>
							<td colspan="1" width="16%">
								<input name="EN_FACE_AMOUNT" id="EN_FACE_AMOUNT" value="EN_FACE_AMOUNT" width="170" class="nui-spinner" minValue="0" maxValue="10000000000" format="n2" required="true" readonly />
							</td>
						</tr>
						<tr>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>组合名称:</td>
							<td colspan="1" width="16%">
								<input name="VC_COMBI_NAME" id="VC_COMBI_NAME" width="170" class="nui-textbox" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>清算速度:</td>
							<td colspan="1" width="16%">
								<input name="VC_SETTLE_SPEED" id="VC_SETTLE_SPEED" class="nui-dictcombobox" width="170" valueField="dictID" textField="dictName" dictTypeId="settleSpeed" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>净价（元）:</td>
							<td colspan="1" width="16%">
								<input name="EN_NET_PRICE" id="EN_NET_PRICE" width="170" value="EN_NET_PRICE" class="nui-spinner" minValue="0" maxValue="100000000000000" format="n4" required="true" readonly />
							</td>
						</tr>
						<tr>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>债券名称:</td>
							<td colspan="1" width="16%">
								<input name="VC_STOCK_NAME" id="VC_STOCK_NAME" width="170" class="nui-textbox" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>交易日期:</td>
							<td colspan="1" width="16%">
								<input name="L_TRADE_DATE" id="L_TRADE_DATE" width="170" class="nui-textbox" required="true" readonly/>
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>全价（元）:</td>
							<td colspan="1" width="16%">
								<input name="EN_FULL_PRICE" id="EN_FULL_PRICE" value="EN_FULL_PRICE" width="170" class="nui-spinner" minValue="0" maxValue="100000000000000" format="n4" required="true" readonly />
							</td>
						</tr>
						<tr>
						</tr>
						<tr>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>债券代码:</td>
							<td colspan="1" width="16%">
								<input name="VC_STOCK_CODE" id="VC_STOCK_NAME" width="170" class="nui-textbox" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>结算日期:</td>
							<td colspan="1" width="16%">
								<input name="L_FIRST_SETTLE_DATE" id="L_FIRST_SETTLE_DATE" width="170" class="nui-textbox" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>到期收益率:</td>
							<td colspan="1" width="16%">
								<input name="EN_MATURITY_YIELD" id="EN_MATURITY_YIELD" width="170" class="nui-textbox" required="true" readonly />
							</td>
						</tr>
						<tr>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>债项评级:</td>
							<td colspan="1" width="16%">
								<input name="VC_BOND_RATING" id="VC_BOND_RATING" class="nui-dictcombobox" width="170" valueField="dictID" textField="dictName" dictTypeId="creditRating" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>交易对手:</td>
							<td colspan="1" width="16%">
								<input name="VC_COUNTERPARTY_NAME" id="VC_COUNTERPARTY_NAME" width="170" class="nui-textbox" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>行权收益率:</td>
							<td colspan="1" width="16%">
								<input name="EN_OPTION_YIELD" id="EN_OPTION_YIELD" width="170" class="nui-textbox" required="true" readonly />
							</td>
						</tr>
						<tr>
							<td class="form_label td1" width="17%" align="right">主体评级:</td>
							<td colspan="1" width="16%">
								<input name="VC_ORG_RATING" id="VC_ORG_RATING" class="nui-dictcombobox" width="170" valueField="dictID" textField="dictName" dictTypeId="issuerRating" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">对手主体机构:</td>
							<td colspan="1" width="16%">
								<input name="VC_COUNTERPARTY_ORGAN" id="VC_COUNTERPARTY_ORGAN" width="170" class="nui-textbox" readonly/>
							</td>
							<td class="form_label td1" width="17%" align="right">净价金额（元）:</td>
							<td colspan="1" width="16%">
								<input name="EN_NET_PRICE_AMOUNT" id="EN_NET_PRICE_AMOUNT" value="EN_NET_PRICE_AMOUNT" width="170" class="nui-spinner" minValue="0" maxValue="100000000000000" format="n2" required="true" readonly />
							</td>
						</tr>
						<tr>
							<td class="form_label td1" width="17%" align="right">剩余期限:</td>
							<td colspan="1" width="16%">
								<input name="L_LEFT_DAYS" id="L_LEFT_DAYS" width="170" class="nui-textbox" readonly />
							</td>
							<td style="" class="form_label td1" width="17%" align="right" id="vcRivalSeatText">对手席位号:</td>
							<td style="" id="vcRivalSeatValue" colspan="1" width="16%">
								<input name="VC_RIVAL_SEAT" id="VC_RIVAL_SEAT" width="170" class="nui-textbox" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right" id="vcCounterpartyTraderText">交易员名称:</td>
							<td colspan="1" width="16%" id="vcCounterpartyTraderValue">
								<input name="VC_COUNTERPARTY_TRADER" id="VC_COUNTERPARTY_TRADER" width="170" class="nui-textbox" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">全价金额（元）:</td>
							<td colspan="1" width="16%">
								<input name="EN_FULL_PRICE_AMOUNT" id="EN_FULL_PRICE_AMOUNT" value="EN_FULL_PRICE_AMOUNT" width="170" class="nui-spinner" minValue="0" maxValue="100000000000000" format="n2" readonly />
							</td>
						</tr>
						<tr>
							<td class="form_label td1" width="17%" align="right">久期:</td>
							<td colspan="1" width="16%">
								<input name="EN_DURATION" id="EN_DURATION" width="170" class="nui-textbox" readonly />
							</td>
							<td class="form_label td1" width="17%" id="vcAgreemtCodeText" align="right">约定号:</td>
							<td colspan="1" id="vcAgreemtCodeValue" width="16%">
								<input name="VC_AGREEMT_CODE" id="VC_AGREEMT_CODE" width="170" class="nui-textbox" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">备注:</td>
							<td colspan="1" width="16%">
								<input name="VC_REMARK" id="VC_REMARK" width="170" class="nui-textbox" readonly />
							</td>
						</tr>
					</table>
			    </div>
   			</div>
   			<!-- 回购信息 -->
   			
   			<!-- 原指令/建议信息 --><!--
   			<div title="原指令/建议信息" id="refundingPanel" class="nui-panel" iconCls="icon-edit" style="width:100%;" 
	   				showCollapseButton="true" collapseOnTitleClick="true">
				<div style="padding-top:5px;" id="refundingInstructForm" class="nui-form">
			  		<table style="width: 100%; table-layout: fixed;" class="nui-form-table">
						<tr>
							<td class="form_label td1" width="17%" align="right">产品代码:</td>
							<td colspan="1" width="16%">
								<input name="vcFundCode" id="vcFundCode" width="170" class="nui-textbox" readonly/>
							</td>
							<td class="form_label td1" width="17%" align="right">组合名称:</td>
							<td colspan="1" width="16%">
								<input name="vcCombiName" id="vcCombiName" width="170" class="nui-textbox" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>委托方向:</td>
							<td colspan="1" width="16%">
								<input name="redeemInterest" id="redeemInterest" width="170" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="entrustDirectionRepurchase" required="true" readonly />
							</td>
						</tr>
						<tr>
							
							<td class="form_label td1" width="17%" align="right">回购到期日:</td>
							<td colspan="1" width="16%">
								<input name="lRedeemLawdate" id="lRedeemLawdate" width="170" class="nui-textbox" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>回购天数:</td>
							<td colspan="1" width="16%">
								<input name="lRedeemDays" id="lRedeemDays" class="nui-textbox" width="170" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">到期结算日期:</td>
							<td colspan="1" width="16%">
								<input name="lMaturitySettleDate" id="lMaturitySettleDate" width="170" class="nui-textbox" readonly />
							</td>
						</tr>
						<tr>
							
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>回购日期 :</td>
							<td colspan="1" width="16%">
								<input name=lHgDate id="lHgDate" width="170" class="nui-textbox" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">占款天数:</td>
							<td colspan="1" width="16%">
								<input name="L_CONTRACT_PERIODS" id="L_CONTRACT_PERIODS" width="170" class="nui-textbox" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>交易对手:</td>
							<td colspan="1" width="16%">
								<input name="lTradeRivalNo" id="lTradeRivalNo" width="170" class="nui-textbox" required="true" readonly />
							</td>
						</tr>
						<tr>
							
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>回购利率(%):</td>
							<td colspan="1" width="16%">
								<input name="enRedeemInterest" id=enRedeemInterest width="170" class="nui-textbox" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>回购金额（万元）:</td>
							<td colspan="1" width="16%">
								<input name="enFaceAmount" id="enFaceAmount" value="EN_FACE_AMOUNT" width="170" class="nui-spinner" minValue="0" maxValue="10000000000" format="n4" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">成交编号:</td>
							<td colspan="1" width="16%">
								<input name="vcDealNo" id="vcDealNo" width="170" class="nui-textbox" readonly />
							</td>
						</tr>
					</table>
				</div>
			</div>   --> 
			<!-- end 原指令/建议信息 --> 
			
   			<!-- 新指令/建议信息 --> 
		  	<div title="回购指令/建议信息" id="newRepurchaseInstructPanel" class="nui-panel" iconCls="icon-edit" style="width:100%;" 
   				showCollapseButton="true" collapseOnTitleClick="true">
				<div style="padding-top:5px;" id="instructRepurchaseInfoForm" class="nui-form">
			  		<input class="nui-hidden" name="processInstID" id="processInstID" value="<%=processInstID%>" />
					<table style="width: 100%; table-layout: fixed;" class="nui-form-table">
						<tr>
							<td class="form_label td1" width="17%" align="right">指令/建议下达日期:</td>
							<td colspan="1" width="16%">
								<input name="L_RESULT_DATE" id="L_RESULT_DATE" width="170" class="nui-textbox" readonly/>
							</td>
							<td class="form_label td1" width="17%" align="right">指令/建议发起人:</td>
							<td colspan="1" width="16%">
								<input name="VC_INITIATOR_ID" id="L_INITIATOR_ID" width="170" class="nui-textbox" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">业务类型:</td>
							<td colspan="1" width="16%">
								<input name="VC_BIZ_TYPE" id="VC_BIZ_TYPE" class="nui-dictcombobox" width="170" valueField="dictID" textField="dictName" dictTypeId="bizTypeRepurchase" readonly />
							</td>
						</tr>
						<tr>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>产品名称:</td>
							<td colspan="1" width="16%">
								<input name="VC_PRODUCT_NAME" id="VC_PRODUCT_NAME" width="170" class="nui-textbox" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">组合名称:</td>
							<td colspan="1" width="16%">
								<input name="VC_COMBI_NAME" id="VC_COMBI_NAME" width="170" class="nui-textbox" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>委托方向:</td>
							<td colspan="1" width="16%">
								<input name="VC_ENTRUST_DIRECTION" id="VC_ENTRUST_DIRECTION" width="170" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="entrustDirectionRepurchase" required="true" readonly />
							</td>
						</tr>
						<tr>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>交易日期:</td>
							<td colspan="1" width="16%">
								<input name="L_TRADE_DATE" id="L_TRADE_DATE" width="170" class="nui-textbox" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">首次结算日期:</td>
							<td colspan="1" width="16%">
								<input name="L_FIRST_SETTLE_DATE" id="L_FIRST_SETTLE_DATE" width="170" class="nui-textbox" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">到期结算日期:</td>
							<td colspan="1" width="16%">
								<input name="L_MATURITY_SETTLE_DATE" id="L_MATURITY_SETTLE_DATE" width="170" class="nui-textbox" readonly />
							</td>
						</tr>
						<tr>
							<td class="form_label td1" id="weightingText" width="17%" align="right" style="display:none">加点(bp):</td>
							<td colspan="1" width="16%" id="weightingValue" style="display:none">
								<input name="EN_WEIGHTING_VALUE" id="EN_WEIGHTING_VALUE" width="170" class="nui-textbox" readonly />
							</td>
							<td class="form_label td1" id="repoRateText" width="17%" align="right"><span style="color: red">*</span>回购利率（%）:</td>
							<td colspan="1" width="16%" id="repoRateValue">
								<input name="EN_REPO_RATE" id="EN_REPO_RATE" width="170" class="nui-textbox" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">回购利息（元）:</td>
							<td colspan="1" width="16%">
								<input name="EN_REPO_INTEREST" id="EN_REPO_INTEREST" value="EN_REPO_INTEREST" width="170" class="nui-spinner" minValue="0" maxValue="10000000000" format="n2" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>回购天数（天）:</td>
							<td colspan="1" width="16%">
								<input name="L_REPO_DAYS" id="L_REPO_DAYS" width="170" class="nui-textbox" required="true" readonly />
							</td>
						</tr>
						<tr>
							<td class="form_label td1" width="17%" align="right" id="enFullPriceAmountText" style="">首期结算金额（元）:</td>
							<td colspan="1" width="16%"  style="" id="enFullPriceAmountValue">
								<input name="EN_FULL_PRICE_AMOUNT" id="EN_FULL_PRICE_AMOUNT" value="EN_FULL_PRICE_AMOUNT" width="170" class="nui-spinner" minValue="0" maxValue="100000000000000" format="n2" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right" id="enFaceAmountText" style=""><span style="color: red">*</span>回购金额（万元）:</td>
							<td colspan="1" width="16%"  style="" id="enFaceAmountValue">
								<input name="EN_FACE_AMOUNT" id="EN_FACE_AMOUNT" value="EN_FACE_AMOUNT" width="170" class="nui-spinner" minValue="0" maxValue="100000000000000" format="n4" required="true" readonly />
							</td>
							
							<td class="form_label td1" width="17%" align="right" style="">到期结算金额（元）:</td>
							<td colspan="1" width="16%">
								<input name="EN_SETTLE_AMOUNT" id="EN_SETTLE_AMOUNT" value="EN_SETTLE_AMOUNT" width="170" class="nui-spinner" minValue="0" maxValue="100000000000000" format="n2" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">实际占款天数（天）:</td>
							<td colspan="1" width="16%">
								<input name="L_CONTRACT_PERIODS" id="L_CONTRACT_PERIODS" width="170" class="nui-textbox" readonly />
							</td>
						</tr>
						<tr>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>清算速度:</td>
							<td colspan="1" width="16%">
								<input name="VC_SETTLE_SPEED" id="VC_SETTLE_SPEED" class="nui-dictcombobox" width="170" valueField="dictID" textField="dictName" dictTypeId="settleSpeed" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right"><span style="color: red">*</span>报价方式:</td>
							<td colspan="1" width="16%">
								<input name="VC_QUOTE_MODE" id="VC_QUOTE_MODE" class="nui-dictcombobox" width="170" valueField="dictID" textField="dictName" dictTypeId="quoteMode" required="true" readonly />
							</td>
							<td class="form_label td1" width="17%" align="right">对手主体机构:</td>
							<td colspan="1" width="16%">
								<input name="VC_COUNTERPARTY_ORGAN" id="VC_COUNTERPARTY_ORGAN" width="170" class="nui-textbox" readonly/>
							</td>
						</tr>
						<!--<tr>
							<td class="form_label td1" width="17%" align="right">指令/建议类型:</td>
							<td colspan="1" width="16%">
								<input name="VC_INSTRUCT_TYPE" id="VC_INSTRUCT_TYPE" class="nui-dictcombobox" width="170" valueField="dictID" textField="dictName" dictTypeId="instructType" readonly />
							</td>
						</tr>-->
					</table>
				</div>
            </div>
			<!-- end 新指令/建议信息 -->
			
   			<!-- 质押券信息 -->
            <div title="质押券信息" id="mortgageInfoPanel" class="nui-panel" iconCls="icon-edit" style="width:100%;" 
   				showCollapseButton="true" collapseOnTitleClick="true">
				<div style="" id="datagrid_mortgage_info" dataField="mortgageInfos" 
			        url="com.cjhxfund.ats.sm.comm.InstructionManager.getMortgageInfos.biz.ext"
			        class="nui-datagrid" style="width:100%;height:auto;"
			        allowSortColumn="false"
				    showPager="false"
				    enableHotTrack="false">
					<div property="columns">
						<div field="vcStockCode" width="120px" headerAlign="center" align="center" >债券代码</div>
						<div field="vcStockName" width="120px" headerAlign="center" align="center" >债券名称</div>
						<div field="enFaceAmount" width="100px" headerAlign="center" align="center" ><span style="color:red;">*</span>券面金额（万元）</div>
						<div name="enMortagageRatio" field="enMortagageRatio" width="80px" headerAlign="center" align="center"><span style="color:red;">*</span>质押比例（％）</div>	
						<div name="enNetPriceInit" field="enNetPriceInit" visible="false"  width="100px" headerAlign="center" align="center" numberFormat="n4">首次净价</div>
						<div name="enFullPriceInit" field="enFullPriceInit" visible="false"  width="100px" headerAlign="center" align="center" numberFormat="n4">首次全价</div>
						<div name="enNetPriceFinal" field="enNetPriceFinal" visible="false" width="100px" headerAlign="center" align="center" numberFormat="n4">到期净价</div>
						<div name="enFullPriceFinal" field="enFullPriceFinal" visible="false"  width="100px" headerAlign="center" align="center" numberFormat="n4">到期全价</div>
						<div field="enCbValueNetValue" width="85px" headerAlign="center" align="center" numberFormat="n4">净价（T-1）</div>
						<div field="enCbValueAllValue" width="85px" headerAlign="center" align="center" numberFormat="n4">全价（T-1）</div>
			            <div field="vcDepository" width="85px" headerAlign="center" align="center" renderer="depository">托管机构</div>
						<div field="vcBondAppraise" width="85px" headerAlign="center" align="center" renderer="renderBondAppraise">债项评级</div>
						<div field="vcIssueAppraise" width="85px" headerAlign="center" align="center" renderer="renderIssueAppraise">主体评级</div>
						<div field="vcBondAppraiseOrgan" width="85px" headerAlign="center" align="center" renderer="renderBondAppraiseOrgan">评级机构</div>
			            <div field="lRatingForecast" width="85px" headerAlign="center" align="center" renderer="lRatingForecastRD">评级展望</div>
			            <div field="vcIssueProperty" headerAlign="center" align="center" width="100px" renderer="atsFmIssueProperty">发行人性质</div>
					</div>
				</div>
            </div>
			<!-- end 质押券信息 -->
			
			<!-- 审批意见 -->
			<div title="审批操作" class="nui-panel" id ="instructApproveForm" iconCls="icon-edit" style="width:100%;" 
   				showCollapseButton="true" collapseOnTitleClick="true">
				<table class="nui-form-table" style="width:100%;">
					<tr>
						<td class="form_label td1" width="20%" align="right">审批条件:</td>
						<td colspan="1" class="td2" width="80%">
							<input id="checkResult" name="checkResult" value="1" class="nui-radiobuttonlist" data="[{id: 1, text: '通过'}, {id: 0, text: '不通过'}]"/>
		                </td>
					</tr>
					<tr>
						<td class="form_label td1" width="30%" align="right">审批意见:</td>
						<td colspan="1" class="td2" width="70%">
							<input class="nui-textarea" id="checkComments" width="515" height="70" name="checkComments"/>
		                </td>
					</tr>
					<tr>
						<td class="form_label td1" width="30%" align="right"></td>
						<td colspan="1" width="70%">
							<a class='nui-button' plain='false' iconCls="icon-save" onclick="submitApprove()">提交</a>
						</td>	
					</tr>
				</table>
			</div>
	        <!-- end审批意见 -->
		</div>
	</div> 
	<div title="流程信息" url="<%= request.getContextPath() %>/sm/comm/task/processGraph.jsp?processInstID=<%=processInstID %>"></div>
</div>	
	<script type="text/javascript">
		nui.parse();
		
		//去掉业务字典字段的下拉箭头样式
		$("#instructInfoForm .mini-buttonedit-button").remove();
		$("#instructRepurchaseInfoForm .mini-buttonedit-button").remove();
		//$("#refundingInstructForm .mini-buttonedit-button").remove();
		var currentState = <%=currentState %>;
		// 指令/建议信息
		var instructInfo = null;
		var mortgage_info = nui.get("datagrid_mortgage_info");
    	var lInquiryId = null;
		var lResultId = null;
		var workItemID = <%=workItemID %>;
		var tabs = nui.get("tabs");
		var bizType = null;
		var instructSource = null;
		// 任务状态（待办=10，已办=12）
		if(currentState!=10 && currentState!=4){
			document.getElementById("instructApproveForm").style.display="none";
		}
		
		//加载表单数据
        var transactionForm = new nui.Form("#instructInfoForm"); 
        var RepurchaseForm = new nui.Form("#instructRepurchaseInfoForm"); 
       // var refundingInstructData = new nui.Form("#refundingInstructForm"); 
        var processInstID = document.getElementById("processInstID").value;
        var data = {processInstID:processInstID}; //获取表单多个控件的数据
        var json = nui.encode(data);   //序列化成JSON       
        
        var entrustDirection = null;
        var lSerialNo = null;
        
        // 加载新指令/建议信息    
        nui.ajax({
            url: "com.cjhxfund.ats.sm.comm.InstructionManager.getInstructionByProcessinstID.biz.ext",
            type: "post",
            data: json,
            contentType:'text/json',
            success: function (text) {
            	var info = nui.decode(text.result);   //反序列化成对象
            	if(info!=null){
	            	bizType = info.VC_BIZ_TYPE;
	            	instructSource = info.VC_INSTRUCT_SOURCE;
            	}
                // 首次结算日期
                if(info.L_FIRST_SETTLE_DATE != null){
                	info.L_FIRST_SETTLE_DATE = String(info.L_FIRST_SETTLE_DATE);
                 	info.L_FIRST_SETTLE_DATE = info.L_FIRST_SETTLE_DATE.substring(0, 4)+"-"+info.L_FIRST_SETTLE_DATE.substring(4,6)+"-"+info.L_FIRST_SETTLE_DATE.substring(6,8);
	            }
	            // 到期结算日期
                if(info.L_MATURITY_SETTLE_DATE != null){
					info.L_MATURITY_SETTLE_DATE = String(info.L_MATURITY_SETTLE_DATE);
                 	info.L_MATURITY_SETTLE_DATE = info.L_MATURITY_SETTLE_DATE.substring(0, 4)+"-"+info.L_MATURITY_SETTLE_DATE.substring(4,6)+"-"+info.L_MATURITY_SETTLE_DATE.substring(6,8);
				}
				// 交易日期
                if(info.L_TRADE_DATE != null){
                 	info.L_TRADE_DATE = String(info.L_TRADE_DATE);
                 	info.L_TRADE_DATE = info.L_TRADE_DATE.substring(0, 4)+"-"+info.L_TRADE_DATE.substring(4,6)+"-"+info.L_TRADE_DATE.substring(6,8);
	            }
	            // 指令/建议下达日期
                if(info.T_INITIATE_TIME != null){
                 	info.T_INITIATE_TIME = nui.formatDate(info.T_INITIATE_TIME, "yyyy-MM-dd HH:mm:ss");
	            }
	            // 指令下达日期
                if(info.L_RESULT_DATE != null){
					info.L_RESULT_DATE = String(info.L_RESULT_DATE);
                 	info.L_RESULT_DATE = info.L_RESULT_DATE.substring(0, 4)+"-"+info.L_RESULT_DATE.substring(4,6)+"-"+info.L_RESULT_DATE.substring(6,8);
				}
				// 显示回购或者买卖
				if(info.VC_ENTRUST_DIRECTION == "3" || info.VC_ENTRUST_DIRECTION == "4"){
					document.getElementById("newRepurchaseInstructPanel").style.display="none";
					//document.getElementById("refundingPanel").style.display="none";
					document.getElementById("mortgageInfoPanel").style.display="none";
				 	transactionForm.setData(info); 
				}
				// 报价方式
				if(info.VC_QUOTE_MODE == null || info.VC_QUOTE_MODE== ""){
					info.VC_QUOTE_MODE = "1";
				}
				if(info.EN_WEIGHTING_VALUE != null && info.EN_WEIGHTING_VALUE!= ""){
					document.getElementById("weightingText").style.display = "";
					document.getElementById("weightingValue").style.display = "";
					document.getElementById("repoRateText").style.display = "none";
					document.getElementById("repoRateValue").style.display = "none";
				}
				
				instructInfo = info;
				if(info.VC_ENTRUST_DIRECTION != "3" && info.VC_ENTRUST_DIRECTION != "4"){
				 	document.getElementById("transManagePanel").style.display="none";
				 	RepurchaseForm.setData(info); 
				 	// 重设换券指令/建议信息显示链接
					// tabs.updateTab("refundingInstructForm",{url:"<%=request.getContextPath()%>/sm/comm/task/reFundingInstructInfo.jsp?lResultId="+instructInfo.L_RESULT_ID});	
					
				}
				
				// 质押式取券面金额显示回购金额，买断式取全价金额显示首期结算金额
				if(instructInfo.VC_BIZ_TYPE == "6"){
					document.getElementById("enFaceAmountText").style.display = "none";
					document.getElementById("enFaceAmountValue").style.display = "none";
					mortgage_info.hideColumn("enMortagageRatio");
    				mortgage_info.showColumn("enNetPriceInit");
    				mortgage_info.showColumn("enFullPriceInit");
    				mortgage_info.showColumn("enNetPriceFinal");
    				mortgage_info.showColumn("enFullPriceFinal");
					
				}else{
					document.getElementById("enFullPriceAmountText").style.display = "none";
					document.getElementById("enFullPriceAmountValue").style.display = "none";
					mortgage_info.showColumn("enMortagageRatio");
	    			mortgage_info.hideColumn("enNetPriceInit");
	    			mortgage_info.hideColumn("enFullPriceInit");
	    			mortgage_info.hideColumn("enNetPriceFinal");
	    			mortgage_info.hideColumn("enFullPriceFinal");
				}
				if(lInquiryId != instructInfo.L_INQUIRY_ID && lResultId != instructInfo.L_RESULT_ID){
					var json = {lInquiryId:instructInfo.L_INQUIRY_ID};
					if(instructInfo.L_RESULT_ID != null){
						json["lResultId"] = instructInfo.L_RESULT_ID;
					}
					mortgage_info.load(json);
					lInquiryId = instructInfo.L_INQUIRY_ID;
					lResultId = instructInfo.L_RESULT_ID;
				}	
				// 根据页面类型显示指令/建议信息
            	entrustDirection = instructInfo.VC_ENTRUST_DIRECTION;
            	lSerialNo = instructInfo.lSerialNo;
            	if(entrustDirection == "3" || entrustDirection == "4" || entrustDirection == "5" || entrustDirection == "6" || entrustDirection == "15" || entrustDirection == "16"){
					//document.getElementById("refundingPanel").style.display="none";
				}
				//else{
					// 调用获取原指令/建议信息方法
 					//getOldInstructInfo();
					
            	//}
				// 根据业务决定是否显示对手席位
				if(instructInfo.VC_BIZ_TYPE == "3"){
					document.getElementById("vcRivalSeatText").style.display="none";
					document.getElementById("vcRivalSeatValue").style.display="none";
					$("#vcCounterpartyTraderText").html("对方交易员");
				}else{
					document.getElementById("vcCounterpartyTraderText").style.display="none";
					document.getElementById("vcCounterpartyTraderValue").style.display="none";
				}
				// 根据业务决定是否显示约定号
				//if(instructInfo.VC_BIZ_TYPE == "1"){
				//	document.getElementById("vcAgreemtCodeText").style.display="none";
				//	document.getElementById("vcAgreemtCodeValue").style.display="none";
				//}
            }
        });
        
        // 加载原指令/建议信息
         function getOldInstructInfo() {
 			var repurchaseData = {lResultId:lResultId, entrustDirection:entrustDirection}; 
 	        nui.ajax({
 	            url: "com.cjhxfund.ats.sm.comm.InstructionManager.getRefundingInstructInfoByResultId.biz.ext",
 	            type: "post",
 	            data: {repurchaseJson:repurchaseData},
 	            contentType:'text/json',
 	            success: function (text) {
 		            var repurchaseResult = nui.decode(text.result);   //反序列化成对象
 		            if(repurchaseResult.exception == null){
 						// 回购到期日期
 		                if(repurchaseResult.lRedeemLawdate != null){
 		            		repurchaseResult.lRedeemLawdate = String(repurchaseResult.lRedeemLawdate);
 		                	repurchaseResult.lRedeemLawdate = repurchaseResult.lRedeemLawdate.substring(0, 4)+"-"+repurchaseResult.lRedeemLawdate.substring(4,6)+"-"+repurchaseResult.lRedeemLawdate.substring(6,8);
 			             }
 			            // 到期结算日期
 		                if(repurchaseResult.lMaturitySettleDate != null){
 							repurchaseResult.lMaturitySettleDate = String(repurchaseResult.lMaturitySettleDate);
 		                 	repurchaseResult.lMaturitySettleDate = repurchaseResult.lMaturitySettleDate.substring(0, 4)+"-"+repurchaseResult.lMaturitySettleDate.substring(4,6)+"-"+repurchaseResult.lMaturitySettleDate.substring(6,8);
 						 }
 						 //  回购日期
 		                 if(repurchaseResult.lHgDate != null){
 		                 	repurchaseResult.lHgDate = String(repurchaseResult.lHgDate);
 		                 	repurchaseResult.lHgDate = repurchaseResult.lHgDate.substring(0, 4)+"-"+repurchaseResult.lHgDate.substring(4,6)+"-"+repurchaseResult.lHgDate.substring(6,8);
 			             }
			             
 						refundingInstructData.setData(repurchaseResult); 
 					}else{
 						nui.alert("系统异常","系统提示");
 					}
 				}
 	        });
 		}
		  
		
		/**风控管理开始**/
		function subData(riskReturn, instructJson){
			var riskFlag = showRiskInfoApprove(riskReturn, instructJson);
			riskControl(riskFlag, instructJson);
		}
		function riskControl(riskFlag, instructJson){
			riskFlagParam = riskFlag;
			lResultIdParam = instructJson.instructParameter.lResultId;
        	lRiskmgrIdParam = instructJson.instructParameter.lRiskmgrId;
        	if(riskFlag=='-1'){
        		return;
        	}else if(riskFlag=='1'){
        		finishInstructWorkitem(workItemID, '1', '');
        	}else if(riskFlag=='2'){
        		finishInstructWorkitem(workItemID, '1', '');
        	}
        }
        function finishInstructWorkitemFisish(){
        	if(riskFlagParam=='2'){
        		startRiskProcessInstruct(lResultIdParam, lRiskmgrIdParam);
        	}
			window.CloseWindow("ok");
        }
        /**风控管理结束**/
		  
		  
    	function submitApprove() {
            // 提交表单数据
            var form = new nui.Form("#instructApproveForm");            
            var data = form.getData(); 		//获取表单多个控件的数据
           	data.workItemID = workItemID;
            var json = nui.encode(data);   	//序列化成JSON
            // 审批条件
            var checkResult = data.checkResult;
            // checkResult 0不通过，1通过
            if(checkResult=="" || checkResult==null){
            	nui.alert("请选择审批条件");
            	return;
            }
            

            /**风控管理开始**/
            if(checkResult=="1" && instructSource!="2" && (bizType=="1" || bizType=="5" || bizType=="6" || bizType=="2" || bizType=="3" || bizType=="4") && judgeRiskTest(workItemID)){
            	var returnJson = judgeRiskInfo(workItemID, null);	//判断是否有复核节点
            	
            	if(returnJson.rtnObject.rtnCode=='-1'){		//投资经理不存在
					alert(returnJson.rtnObject.rtnMsg);		//不允许提交
				}else if(returnJson.rtnObject.rtnCode=='1' || returnJson.rtnObject.rtnCode=='2'){	//风控管理存在数据
					if(returnJson.riskInfo.cStatus=='2'){	//风控通过
						checkRiskInfoApprove(workItemID, false);	//校验可用
					}else if(returnJson.workItemDetail.activityDefID=="manualActivity2A"){	//投资经理节点
						nui.alert("风控流程审批未通过，暂不能提交！");
					}else if(returnJson.riskInfo.cStatus=='0' || returnJson.riskInfo.cStatus=='5'){
						checkRiskInfoApprove(workItemID);	//重新调用风控接口
					}else{
						if(returnJson.workItemDetail.activityDefID=="manualActivity1" || returnJson.workItemDetail.activityDefID=="manualActivity111"){
							nui.confirm("风控流程未审批完成，复核通过后会停留在下一节点！","系统提示",function(action){
								if(action=="ok"){
									checkRiskInfoApprove(workItemID, false);	//校验可用
								}
							});
						}else{
							checkRiskInfoApprove(workItemID, false);	//校验可用
						}
					}
				}else{	//风控管理不存在数据
					if(returnJson.workItemDetail.activityDefID=="manualActivity2A"){	//投资经理节点
						checkRiskInfoApprove(workItemID, false);	//校验可用
					}else{	//非投资经理节点
						checkRiskInfoApprove(workItemID);	//重新调用风控接口
					}
				}
				
				return;
            }
            /**风控管理结束**/
            
            
            var a = nui.loading("正在处理中,请稍等...","提示");
            nui.ajax({
                url: "com.cjhxfund.ats.sm.comm.TaskManager.approveAvailValidate.biz.ext",
                type: "post",
                contentType:'text/json',
                data:json ,
                success: function (text) {
                	nui.hideMessageBox(a);
                	var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
                    		var alsertMsg = "";
                    		if(checkResult=="0"){
                    			if(returnJson.rtnMsg){
                    				alsertMsg = "</br>此单已退回！</br>退回原因："+returnJson.rtnMsg;
                    			}
                    			nui.alert("操作成功！"+alsertMsg,"系统提示",function(action){
					    			if (!!window.ActiveXObject || "ActiveXObject" in window){//如果是IE浏览器
						              	window.opener.history.go(0);
						            }else{
						              	window.opener.reloadData();
						            }
									//返回我的代办任务页面
			    					CloseWindow("confirmSuccess");
				    			});
                    		}else{
                    			if(returnJson.rtnMsg){
	                    			alsertMsg = "</br>【该投资建议/指令触发以下风控：</br>"+returnJson.rtnMsg+"】</br>";
	                    		}
	                    		nui.alert("审批成功"+alsertMsg,"系统提示",function(action){
					    			if (!!window.ActiveXObject || "ActiveXObject" in window){//如果是IE浏览器
						              	window.opener.history.go(0);
						            }else{
						              	window.opener.reloadData();
						            }
									//返回我的代办任务页面
			    					CloseWindow("confirmSuccess");
				    			}); 
                    		}
                    		
						}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
							nui.alert("审批失败</br>"+returnJson.rtnMsg,"系统提示",function(action){
								nui.get("checkResult").setValue("0");
								nui.get("checkComments").setValue(returnJson.rtnMsg.replace(/<[^>]+>/g,""));
							});
							
						}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_NO_RCV_FR_O32%>"){
			    			nui.alert("审批成功"+"</br>"+returnJson.rtnMsg,"系统提示",function(action){
				    			if (!!window.ActiveXObject || "ActiveXObject" in window){//如果是IE浏览器
					              	window.opener.history.go(0);
					            }else{
					              	window.opener.reloadData();
					            }
								//返回我的代办任务页面
		    					CloseWindow("confirmSuccess");
			    			}); 
						}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_RISK_VIOLATE_FORBID_CTRL%>"){
							nui.alert("审批失败,触发禁止风控,风控信息如下：</br>"+returnJson.rtnMsg,"系统提示",function(action){
								nui.get("checkResult").setValue("0");
								nui.get("checkComments").setValue(returnJson.rtnMsg.replace(/<[^>]+>/g,""));
							});
							
						}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT%>"){
							nui.alert("审批失败</br>"+returnJson.rtnMsg,"系统提示",function(action){
								nui.get("checkResult").setValue("0");
								nui.get("checkComments").setValue(returnJson.rtnMsg.replace(/<[^>]+>/g,""));
							});
						}else{
							nui.alert("操作异常","系统提示");
						}
					}else{
						nui.alert("系统异常","系统提示");
					}
                }
            });
        }
	    
	    // 交易市场显示
	    function renderTradePlace(e){
	    	return nui.getDictText("tradePlace",e.row.vcExchange);
	    }
		//列表中转译债券评级
		function renderBondAppraise(e){
			return nui.getDictText("creditRating",e.row.vcBondAppraise);
		}
		//列表中转译主体评级
		function renderIssueAppraise(e){
			return nui.getDictText("issuerRating",e.row.vcIssueAppraise);
		}
		//列表中转译债券评级机构
		function renderBondAppraiseOrgan(e){
			return nui.getDictText("outRatingOrgan",e.row.vcBondAppraiseOrgan);
		}//列表中转译托管机构
		function depository(e){
			return nui.getDictText("CF_JY_DJTGCS",e.row.vcDepository);
		}
		//评级展望
		function lRatingForecastRD(e){
			return nui.getDictText("ratingOutlook",e.row.lRatingForecast);
		}
		// 发行人性质
		function atsFmIssueProperty(e){
			return nui.getDictText("ATS_FM_ISSUE_PROPERTY",e.row.vcIssueProperty);
		}
		
		//关闭窗口
	    function CloseWindow(action) {
	       if (window.CloseOwnerWindow)
	          return window.CloseOwnerWindow(action);
	       else window.close();
	    }
		
    </script>
</body>
</html>