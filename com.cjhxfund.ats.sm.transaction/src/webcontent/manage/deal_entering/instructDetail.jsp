<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2016-12-26 14:44:10
  - Description:
-->
<head>
	<title>指令/建议明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    <style type="text/css">
    	.mini-buttonedit-border{
    		padding-right:1px;
    	}
    </style>
</head>
<body>
	<div id="dataform_instruct_detail">
		<table id="table" style="width:100%; table-layout:fixed;margin: 0xp;padding: 0px;" border="0" class="nui-form-table">	
			<tr>
                <td style="width:125px; padding: 5px 5px 5px 5px;" align="right">产品名称：</td>
                <td style="width:20%;">
                	<input name="instructDetail.vcProductName" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="width:15%; padding: 5px 5px 5px 0px;" align="right">组合名称：</td>
                <td style="width:20%;">
                	<input name="instructDetail.vcCombiName" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="width:120px; padding: 5px 5px 5px 0px;" align="right">债券代码：</td>
                <td style="width:20%;">
                	<input name="instructDetail.vcStockCode" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="width:115px; padding: 5px 5px 5px 5px;" align="right">债券类别：</td>
                <td style="width:20%;">
                	<input name="instructDetail.vcStockType" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
        	</tr>
        	<tr>
        		<td style="padding: 5px 5px 5px 5px" align="right">债券名称：</td>
                <td style="width:20%;">
                	<input name="instructDetail.vcStockName" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
        	 	<td style="padding: 5px 5px 5px 5px" align="right">业务类别：</td>
                <td>
                	<input name="instructDetail.vcBizType" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="bizTypeTransaction" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">指令/建议净价：</td>
                <td>
                	<input name="instructDetail.enNetPrice" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">指令/建议全价：</td>
                <td>
                	<input name="instructDetail.enFullPrice" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
        	</tr>
        	<tr>
        	 	<td style="padding: 5px 5px 5px 5px" align="right">债券评级：</td>
                <td>
                	<input name="instructDetail.vcBondRating" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="creditRating" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">主体评级：</td>
                <td>
                	<input name="instructDetail.vcOrgRating" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="issuerRating" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">剩余期限：</td>
                <td>
                	<input name="instructDetail.lLeftDays" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">久期：</td>
                <td>
                	<input name="instructDetail.enDuration" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
        	</tr>
        	<tr>
        	 	<td style="padding: 5px 5px 5px 5px" align="right">到期收益率（%）：</td>
                <td>
                	<input name="instructDetail.enMaturityYield" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">行权收益率（%）：</td>
                <td>
                	<input name="instructDetail.enOptionYield" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">券面金额(万元)：</td>
                <td>
	            	<input name="instructDetail.enFaceAmount" value="instructDetail.enFaceAmount" class="nui-spinner" minValue="0" maxValue="10000000000" format="n2" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">委托方向：</td>
                <td>
                	<input name="instructDetail.vcEntrustDirection" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="entrustDirectionTransaction" readonly="true" enabled="false"/>
                </td>
                
        	</tr>
        	<tr>
        	 	<td style="padding: 5px 5px 5px 5px" align="right">清算速度：</td>
                <td>
                	<input name="instructDetail.vcSettleSpeed" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="settleSpeed" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">交易对手：</td>
                <td>
                	<input name="instructDetail.vcCounterpartyName" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">对手交易员：</td>
                <td>
                	<input name="instructDetail.vcCounterpartyTrader" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">对手席位：</td>
                <td>
                	<input name="instructDetail.vcRivalSeat" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
        	</tr>
        	<tr>
        		<td style="padding: 5px 5px 5px 5px" align="right">约定号：</td>
                <td>
                	<input name="instructDetail.vcAgreemtCode" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
        	 	<td style="padding: 5px 5px 5px 5px" align="right">指令/建议下达时间：</td>
                <td>                	
                	<input name="instructDetail.initiator" class="nui-textbox tooltip" readonly="true" id="initiator" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">询价结果录入时间：</td>
                <td>
                	<input name="instructDetail.resultInputer" class="nui-textbox tooltip" readonly="true" id="resultInputer" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">前台成交时间：</td>
                <td>
                	<input name="instructDetail.tFsDealTime" class="nui-textbox tooltip" readonly="true" id="tFsDealTime" enabled="false"/>
                </td>
        	</tr>
        	<tr>
                <td style="padding: 5px 5px 5px 5px" align="right">后台成交状态：</td>
        		<td>
                	<input name="instructDetail.vcBsDealStatus" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="CF_JY_HTCJZT" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">前台录单时间：</td>
                <td>
                	<input name="instructDetail.fsOperator" class="nui-textbox tooltip" readonly="true" id="fsOperator" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">前台发送时间：</td>
                <td>
                	<input name="instructDetail.fsChecker" class="nui-textbox tooltip" readonly="true" id="fsChecker" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">退回原因：</td>
                <td>
            		<input name="instructDetail.vcRejectReason" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="backReason" readonly="true" enabled="false"/>
                </td>
        	</tr>
        	<tr>
        		<td style="padding: 5px 5px 5px 5px" align="right">风控审批状态：</td>
                <td>
                	<input name="instructDetail.vcRiskApproveStatus" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="riskApproveStatus" readonly="true" enabled="false"/>
                </td>
                <!--<td style="padding: 5px 5px 5px 5px" align="right">投顾复核时间：</td>
                <td>
                	<input name="instructDetail.fsChecker" class="nui-textbox" readonly="true" enabled="false"/>
                </td>-->
                <!--<td style="padding: 5px 5px 5px 5px" align="right">指令/建议修改时间：</td>
                <td>
                	<input name="instructDetail.fsUpdate" class="nui-textbox" readonly="true" enabled="false"/>
                </td>-->
                <td style="padding: 5px 5px 5px 5px" align="right">投资经理确认时间：</td>
                <td>
                	<input name="instructDetail.fsSender" class="nui-textbox tooltip" readonly="true" id="fsSender" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">指令/建议撤销时间：</td>
                <td>
                	<input name="instructDetail.tRepealTime" class="nui-textbox tooltip" readonly="true" id="tRepealTime" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">交易日期：</td>
                <td>
                	<input name="instructDetail.lTradeDate" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
        	</tr>
        	<tr>
        		<td style="padding: 5px 5px 5px 5px" align="right">对手主体机构：</td>
        		<td>
                	<input name="instructDetail.vcCounterpartyOrgan" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
        	</tr>
        	<tr>
        		<td style="padding: 5px 5px 5px 5px" align="right">备注：</td>
        		<td colspan="7">
                	<input name="instructDetail.vcRemark" class="nui-textarea" style="width:50%" readonly="true" enabled="false"/>
                </td>
        	</tr>

 <!--       	<tr>
        		<td style="padding: 5px 5px 5px 5px" align="right">附件：</td>
                <td colspan="7">
                	<input name="" class="nui-textbox" style="width:50%" readonly="true" />
                </td>
        	</tr>-->
		</table>
 	</div>	

	<script type="text/javascript">
    	nui.parse();
    	$("#dataform_instruct_detail .mini-buttonedit-button").remove();
    	var instruct_detail_from = new nui.Form("#dataform_instruct_detail");
    	var lInquiryId = null;
    	var lResultId = null;
    	function detail(selectRow){
    		if(lInquiryId != selectRow.lInquiryId && lResultId != selectRow.lResultId){
    			//组装指令/建议下达时间显示信息
    			if(selectRow.vcInitiatorName != null || selectRow.tInitiateTime != null){
    				selectRow["initiator"] = (selectRow.vcInitiatorName==null?"":selectRow.vcInitiatorName) + "　" + nui.formatDate(selectRow.tInitiateTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//组装询价结果录入时间显示信息
    			if(selectRow.vcResultInputerName != null || selectRow.tResultInputTime != null){
    				selectRow["resultInputer"] = (selectRow.vcResultInputerName==null?"":selectRow.vcResultInputerName) + "　" + nui.formatDate(selectRow.tResultInputTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//组装前台发送时间显示信息
    			if(selectRow.vcFsSenderName != null || selectRow.tFsSendTime != null){
    				selectRow["fsSender"] = (selectRow.vcFsSenderName==null?"":selectRow.vcFsSenderName) + "　" + nui.formatDate(selectRow.tFsSendTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//组装投录单确认时间显示信息
    			if(selectRow.vcFsOperatorName != null && selectRow.tFsOperateTime != null){
    				selectRow["fsOperator"] = (selectRow.vcFsOperatorName==null?"":selectRow.vcFsOperatorName) + "　" + nui.formatDate(selectRow.tFsOperateTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//组装录单复核时间显示信息
    			if(selectRow.vcFsCheckerName != null && selectRow.tFsCheckTime != null){
    				selectRow["fsChecker"] = (selectRow.vcFsCheckerName==null?"":selectRow.vcFsCheckerName) + "　" + nui.formatDate(selectRow.tFsCheckTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//组装指令/建议撤销时间显示
    			if(selectRow.vcRepealerName != null && selectRow.tRepealTime != null){
    				selectRow["tRepealTime"] = (selectRow.vcRepealerName==null?"":selectRow.vcRepealerName) + "　" + nui.formatDate(selectRow.tRepealTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			if(selectRow.lTradeDate != null && selectRow.lTradeDate.toString().length == 8){
    				selectRow["lTradeDate"] = nui.formatDate(DateUtil.numStrToDate(selectRow.lTradeDate.toString()),"yyyy-MM-dd");
    			}
    			//组装指令/建议修改时间
    			if(selectRow.vcModifierName != null && selectRow.tModifyTime != null){
    				selectRow["fsUpdate"] = (selectRow.vcModifierName==null?"":selectRow.vcModifierName) + "　" + nui.formatDate(selectRow.tModifyTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//前台成交时间
    			if(selectRow.tFsDealTime != null){
    				selectRow["tFsDealTime"] = nui.formatDate(selectRow.tFsDealTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			instruct_detail_from.setData({instructDetail:selectRow});
    			lInquiryId = selectRow.lInquiryId;
    			lResultId = selectRow.lResultId;
    		}
    	}

    	function clearDetail(){
    		lInquiryId = null;
    		lResultId = null;
    		instruct_detail_from.clear();
    	}
		
		// 鼠标悬停提示悬浮框
    	var tip = new nui.ToolTip();
    	tip.set({
	        target: document,
	        selector: '.tooltip',
	        placement:"top",
	        onbeforeopen: function (e) {            
	            e.cancel = false;
	        },
	        onopen: function (e) {
	        	var el = e.element;
            	var id = el.id;
                var content=nui.get(id).value;
                tip.setContent(content);
	        }
		});    	
    </script>
</body>
</html>