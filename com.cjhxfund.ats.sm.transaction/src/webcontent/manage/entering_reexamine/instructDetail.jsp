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
    <script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
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
			
				<td style="width:125px; padding: 5px 5px 5px 5px;" align="right">指令/建议序号：</td>
                <td style="width:20%;">
                	<input name="instructDetail.lResultNo" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
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
        	</tr>
        	<tr>
        		<td style="width:120px; padding: 5px 5px 5px 0px;" align="right">债券名称：</td>
                <td style="width:20%;">
                	<input name="instructDetail.vcStockName" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
        	 	<td style="padding: 5px 5px 5px 5px" align="right">业务类别：</td>
                <td>
                	<input name="instructDetail.vcBizType" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="bizTypeTransaction" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">委托方向：</td>
                <td>
                	<input name="instructDetail.vcEntrustDirection" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="entrustDirectionTransaction" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">指令/建议净价：</td>
                <td>
                	<input name="instructDetail.enNetPrice" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
        	</tr>
        	<tr>
                <td style="padding: 5px 5px 5px 5px" align="right">指令/建议全价：</td>
                <td>
                	<input name="instructDetail.enFullPrice" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
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
        	</tr>
        	<tr>
                <td style="padding: 5px 5px 5px 5px" align="right">交易日期：</td>
                <td>
                	<input name="instructDetail.lTradeDate" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">结算日期：</td>
                <td>
                	<input name="instructDetail.lFirstSettleDate" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">交易对手：</td>
                <td>
                	<input name="instructDetail.vcCounterpartyName" class="nui-textbox" readonly="true" enabled="false"/>
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
        	</tr>
        	<tr>
                <td style="padding: 5px 5px 5px 5px" align="right">久期：</td>
                <td>
                	<input name="instructDetail.enDuration" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">指令/建议下达时间：</td>
                <td>                	
                	<input name="instructDetail.initiator" class="nui-textbox tooltip" readonly="true" id="initiator" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">询价结果录入时间：</td>
                <td>
                	<input name="instructDetail.resultInputer" class="nui-textbox tooltip" readonly="true" id="resultInputer" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">前台发送时间：</td>
                <td>
                	<input name="instructDetail.fsChecker" class="nui-textbox tooltip" readonly="true" id="fsChecker" enabled="false"/>
                </td>
        	</tr>
        	<tr>
        		<td style="padding: 5px 5px 5px 5px" align="right">前台成交时间：</td>
                <td>
                	<input name="instructDetail.tFsDealTime" class="nui-textbox tooltip" readonly="true" id="tFsDealTime" enabled="false"/>
                </td>
        		<td style="padding: 5px 5px 5px 5px" align="right">前台录单时间：</td>
                <td>
                	<input name="instructDetail.fsOperator" class="nui-textbox tooltip" readonly="true" id="fsOperator" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">复核人：</td>
                <td>
                	<input name="instructDetail.vcFsCheckerName" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">指令/建议撤销时间：</td>
                <td>
                	<input name="instructDetail.tRepealTime" class="nui-textbox tooltip" readonly="true" id="tRepealTime" enabled="false"/>
                </td>
                <!--<td style="padding: 5px 5px 5px 5px" align="right">投顾复核时间：</td>
                <td>
                	<input name="instructDetail.fsSender" class="nui-textbox" readonly="true" enabled="false"/>
                </td>-->
                
        	</tr>
        	<tr>
                <td style="padding: 5px 5px 5px 5px" align="right">后台成交状态：</td>
        		<td>
                	<input name="instructDetail.vcBsDealStatus" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="CF_JY_HTCJZT" readonly="true" enabled="false"/>
                </td>
        		<!--<td style="padding: 5px 5px 5px 5px" align="right">指令/建议修改时间：</td>
                <td>
                	<input name="instructDetail.fsUpdate" class="nui-textbox" readonly="true" enabled="false"/>
                </td>-->
        		<td style="padding: 5px 5px 5px 5px" align="right">投资经理确认时间：</td>
                <td>
                	<input name="instructDetail.fsSender" class="nui-textbox tooltip" readonly="true" id="fsSender" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">对手主体机构：</td>
        		<td>
                	<input name="instructDetail.vcCounterpartyOrgan" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
        	</tr>
		</table>
 	</div>	

	<script type="text/javascript">
    	nui.parse();
    	
    	$("#dataform_instruct_detail .mini-buttonedit-button").remove();
    	var instruct_detail_from = new nui.Form("#dataform_instruct_detail");
    	var lInquiryId = null;
    	function detail(row){
    		if(lInquiryId != row.lInquiryId){
    			//组装指令/建议下达时间显示信息
    			if(row.vcInitiatorName != null || row.tInitiateTime != null){
    				row["initiator"] = (row.vcInitiatorName==null?"":row.vcInitiatorName) + "　" + nui.formatDate(row.tInitiateTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//组装询价结果录入时间显示信息
    			if(row.vcResultInputerName != null || row.tResultInputTime != null){
    				row["resultInputer"] = (row.vcResultInputerName==null?"":row.vcResultInputerName) + "　" + nui.formatDate(row.tResultInputTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//组装前台发送时间显示信息
    			if(row.vcFsSenderName != null || row.tFsSendTime != null){
    				row["fsSender"] = (row.vcFsSenderName==null?"":row.vcFsSenderName) + "　" + nui.formatDate(row.tFsSendTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//组装投录单确认时间显示信息
    			if(row.vcFsOperatorName != null && row.tFsOperateTime != null){
    				row["fsOperator"] = (row.vcFsOperatorName==null?"":row.vcFsOperatorName) + "　" + nui.formatDate(row.tFsOperateTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//组装指令/建议复核时间
    			if(row.vcFsCheckerName != null && row.tFsCheckTime != null){
    				row["fsChecker"] = (row.vcFsCheckerName==null?"":row.vcFsCheckerName) + "　" + nui.formatDate(row.tFsCheckTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//组装指令/建议撤销时间显示
    			if(row.vcRepealerName != null && row.tRepealTime != null){
    				row["tRepealTime"] = (row.vcRepealerName==null?"":row.vcRepealerName) + "　" + nui.formatDate(row.tRepealTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			if(row.lFirstSettleDate != null && row.lFirstSettleDate.toString().length == 8){
    				row["lFirstSettleDate"] = nui.formatDate(DateUtil.numStrToDate(row.lFirstSettleDate.toString()),"yyyy-MM-dd");
    			}
    			if(row.lMaturitySettleDate != null && row.lMaturitySettleDate.toString().length == 8){
    				row["lMaturitySettleDate"] = nui.formatDate(DateUtil.numStrToDate(row.lMaturitySettleDate.toString()),"yyyy-MM-dd");
    			}
    			if(row.lTradeDate != null && row.lTradeDate.toString().length == 8){
    				row["lTradeDate"] = nui.formatDate(DateUtil.numStrToDate(row.lTradeDate.toString()),"yyyy-MM-dd");
    			}
    			//组装指令/建议修改时间
    			if(row.vcModifierName != null && row.tModifyTime != null){
    				row["fsUpdate"] = (row.vcModifierName==null?"":row.vcModifierName) + "　" + nui.formatDate(row.tModifyTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//前台成交时间
    			if(row.tFsDealTime != null){
    				row["tFsDealTime"] = nui.formatDate(row.tFsDealTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			instruct_detail_from.setData({instructDetail:row});
    			lInquiryId = row.lInquiryId;
    		}
    	}
    	
    	function clearDetail(){
    		lInquiryId = null;
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