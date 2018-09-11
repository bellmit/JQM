<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<html>
<!-- 
  - Author(s): 童伟
  - Date: 2016-12-27 17:58:19
  - Description:
-->
<head>
<title>原指令/建议信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
      .td1{
        border-right: 1px solid #D3D3D3;
        border-left: 1px solid #D3D3D3;
      }
      .td2{
        border-right: 1px solid #D3D3D3;
      } 
    </style>
</head>
<%
    String lResultId = request.getParameter("lResultId");
 %>
<body>
	<!-- 回购指令/建议审批信息 -->
	<div style="padding-top:5px;" id="refundingInstructForm" class="nui-form">
		<table style="width: 100%; table-layout: fixed;" class="nui-form-table">
			<tr>
				<td class="form_label td1" width="17%" align="right">产品代码:</td>
				<td colspan="1" width="16%">
					<input name="VC_PRODUCT_CODE" id="vc_Product_Code" width="170" class="nui-textbox" readonly/>
				</td>
				<td class="form_label td1" width="17%" align="right">组合名称:</td>
				<td colspan="1" width="16%">
					<input name="VC_COMBI_NAME" id="VC_COMBI_NAME" width="170" class="nui-textbox" readonly />
				</td>
				<td class="form_label td1" width="17%" align="right">委托方向:</td>
				<td colspan="1" width="16%">
					<input name="VC_ENTRUST_DIRECTION" id="VC_ENTRUST_DIRECTION" width="170" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="entrustDirectionRepurchase" readonly />
				</td>
			</tr>
			<tr>
				<td class="form_label td1" width="17%" align="right">回购到期日:</td>
				<td colspan="1" width="16%">
					<input name="L_MATURITY_SETTLE_DATE" id="L_MATURITY_SETTLE_DATE" class="nui-textbox" width="170" readonly />
				</td>
				<td class="form_label td1" width="17%" align="right">回购天数:</td>
				<td colspan="1" width="16%">
					<input name="L_REPO_DAYS" id="l_Repo_Days" class="nui-textbox" width="170" readonly />
				</td>
				<td class="form_label td1" width="17%" align="right">到期结算日期:</td>
				<td colspan="1" width="16%">
					<input name="L_MATURITY_SETTLE_DATE" id="L_MATURITY_SETTLE_DATE" width="170" class="nui-textbox" readonly />
				</td>
			</tr>
			<tr>
				<td class="form_label td1" width="17%" align="right">回购日期 :</td>
				<td colspan="1" width="16%">
					<input name="l_Hg_Date" id="l_Hg_Date" width="170" class="nui-textbox" readonly />
				</td>
				<td class="form_label td1" width="17%" align="right">占款天数:</td>
				<td colspan="1" width="16%">
					<input name="L_CONTRACT_PERIODS" id="L_CONTRACT_PERIODS" width="170" class="nui-textbox" readonly />
				</td>
				<td class="form_label td1" width="17%" align="right">交易对手:</td>
				<td colspan="1" width="16%">
					<input name="VC_COUNTERPARTY_NAME" id="VC_COUNTERPARTY_NAME" width="170" class="nui-textbox" readonly />
				</td>
			</tr>
			<tr>
				<td class="form_label td1" width="17%" align="right">回购利率(%):</td>
				<td colspan="1" width="16%">
					<input name="EN_REPO_RATE" id="EN_REPO_RATE" width="170" class="nui-textbox" readonly />
				</td>
				<td class="form_label td1" width="17%" align="right">回购金额:</td>
				<td colspan="1" width="16%">
					<input name="EN_FULL_PRICE_AMOUNT" id="EN_FULL_PRICE_AMOUNT" class="nui-textbox" readonly />
				</td>
				<!--<td class="form_label td1" width="17%" align="right">成交编号:</td>
				<td colspan="1" width="16%">
					<input name="l_Daily_Instruction_No_" id="l_Daily_Instruction_No_" width="170" class="nui-textbox" readonly />
				</td>-->
			</tr>
		</table>
	</div>
	<div style="" id="datagrid_mortgage_info" dataField="mortgageInfos" 
		        url="com.cjhxfund.ats.sm.comm.InstructionManager.getMortgageInfos.biz.ext"
		        class="nui-datagrid" style="width:100%;height:auto;"
		        allowSortColumn="false"
			    showPager="false"
			    enableHotTrack="false">
				<div property="columns">
					<div field="vcStockCode" width="120px" headerAlign="center" align="center" >债券代码</div>
					<div field="vcStockName" width="120px" headerAlign="center" align="center" >债券名称</div>
					<div field="vcExchange" width="100px" headerAlign="center" align="center" renderer="renderTradePlace">交易市场</div>
					<div name="vcDepository" field="vcDepository" width="120px" headerAlign="center" align="center" >托管机构</div>
					<div field="enFaceAmount" numberFormat="n2" width="100px" headerAlign="center" align="center" >券面金额（万元）</div>
					<div name="enMortagageRatio" field="enMortagageRatio" width="80px" headerAlign="center" align="center" >折算比例（％）</div>	
					<div name="enNetPriceInit" visible="false" field="enNetPriceInit" width="100px" headerAlign="center" align="center" >首次净价</div>
					<div name="enNetPriceFinal" visible="false" field="enNetPriceFinal" width="100px" headerAlign="center" align="center" >到期净价</div>
					<div field="enParvalue" width="85px" headerAlign="center" align="center" >面值</div>
					<div field="enCbValueNetValue" width="85px" headerAlign="center" align="center" >净价（T-1）</div>
					<div field="enCbValueAllValue" width="85px" headerAlign="center" align="center" >全价（T-1）</div>
					<div field="vcBondAppraise" width="85px" headerAlign="center" align="center" >债项评级</div>
					<div field="vcIssueAppraise" width="85px" headerAlign="center" align="center" >主体评级</div>
					<div field="vcIssueAppraiseOrgan" width="105px" headerAlign="center" align="center" >评级机构</div>
				</div>
			</div>
	<!-- 结束 回购业务审批信息 -->

	<script type="text/javascript">
    	nui.parse();
    	//去掉业务字典字段的下拉箭头样式
		$("#refundingInstructForm .mini-buttonedit-button").remove();
    	//加载表单数据
        var refundingInstructForm = new nui.Form("#refundingInstructForm"); 
        var lResultId = <%=lResultId %>;  
        var data = {lResultId:lResultId}; //获取表单多个控件的数据
        var json = nui.encode(data);   //序列化成JSON         
        var lInquiryId = null;
        var lResultId = null;
        nui.ajax({
            url: "com.cjhxfund.ats.sm.comm.InstructionManager.getRefundingInstructInfoByResultId.biz.ext",
            type: "post",
            data: json,
            contentType:'text/json',
            success: function (text) {
                 var info = nui.decode(text.result);   //反序列化成对象
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
	             
	             // 协议式回购续作指令/建议和协议式回购换券指令/建议 显示质押券信息
	             if(info.VC_BIZ_TYPE == "4" || info.VC_BIZ_TYPE == "5"){
	             	document.getElementById("datagrid_mortgage_info").style.display="none";
	             }
	             
	             // 质押券显示信息
				if(info.VC_BIZ_TYPE == "1"){//银行间质押式回购：显示托管机构、折算比例，隐藏首次净价、到期净价
					mortgage_info.showColumn("vcDepository");
					mortgage_info.showColumn("enMortagageRatio");
					mortgage_info.hideColumn("enNetPriceInit");
					mortgage_info.hideColumn("enNetPriceFinal");
				}else if(info.VC_BIZ_TYPE == "2"){//银行间买断式回购：显示托管机构、首次净价、到期净价，隐藏折算比例
					mortgage_info.showColumn("vcDepository");
					mortgage_info.hideColumn("enMortagageRatio");
					mortgage_info.showColumn("enNetPriceInit");
					mortgage_info.showColumn("enNetPriceFinal");
				}else{//交易所协议式回购：显示折算比例，隐藏托管机构、首次净价、到期净价
					mortgage_info.hideColumn("vcDepository");
					mortgage_info.showColumn("enMortagageRatio");
					mortgage_info.hideColumn("enNetPriceInit");
					mortgage_info.hideColumn("enNetPriceFinal");
				} 
				if(lInquiryId != info.L_INQUIRY_ID && lResultId != info.L_RESULT_ID){
					var json = {lInquiryId:info.L_INQUIRY_ID};
					if(info.L_RESULT_ID != null){
						json["lResultId"] = info.L_RESULT_ID;
					}
					mortgage_info.load(json);
					lInquiryId = info.L_INQUIRY_ID;
					lResultId = info.L_RESULT_ID;
				}	
	             
				refundingInstructForm.setData(info); 
            }
        });
    </script>
</body>
</html>