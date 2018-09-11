<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 创金合信
  - Date: 2016-09-03 14:29:33
  - Description:
-->
<head>
	<title>指令/建议明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    <style type="text/css">
    	.mini-tabs-bodys{
    		border: 0px;
    	}
    	.mini-layout-region{
    		border-left: 0px;
    		border-right: 0px;
    		border-bottom: 0px;
    	}
    	.mini-panel-border{
    		border-left: 0px;
    		border-right: 0px;
    	}
    </style>
</head>
<body>
	<div id="dataform_instruct_detail">
		<table id="table" border="0" cellpadding="0" cellspacing="0" style="width:100%;table-layout:fixed;">	
			<tr>
                <td style="width:110px" align="right">产品名称：</td>
                <td style="width:15%" align="left">
                	<input name="instructDetail.vcProductName" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
                <td style="width:110px" align="right">业务类型：</td>
				<td style="width:15%" align="left">
					<input name="instructDetail.vcBizType" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="bizTypeRepurchase" readonly="true" width="80%" enabled="false"/>
				</td>
                <td style="width:110px" align="right">交易对手：</td>
                <td style="width:15%" align="left">
                	<input name="instructDetail.vcCounterpartyName" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
                <td style="width:110px" align="right">投资指令/建议录入时间：</td>
                <td style="width:15%" align="left">               	
                	<input name="instructDetail.initiator" class="nui-textbox tooltip" readonly="true" id="initiator" enabled="false" width="80%"/>
                </td>
        	</tr>
        	<tr>
        		<td align="right">组合名称：</td>
                <td align="left">
                	<input name="instructDetail.vcCombiName" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right">委托方向：</td>
                <td align="left">
                	<input name="instructDetail.vcEntrustDirection" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="entrustDirectionTransaction" width="80%" readonly="true" enabled="false"/>
                </td>
                <td align="right">对手主体机构：</td>
                <td align="left">
                	<input name="instructDetail.vcCounterpartyOrgan" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right">投资指令/建议复核时间：</td>
                <td align="left"> 
                	<input name="instructDetail.vcAdviserConfirm" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        	</tr>
        	<tr>
                <td align="right">回购品种：</td>
                <td align="left"> 
                	<input name="instructDetail.vcStockCode" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right">清算速度：</td>
                <td align="left">
                	<input name="instructDetail.vcSettleSpeed" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="settleSpeed" readonly="true" enabled="false" width="80%"/>
                </td>
        		<td align="right">对手交易员：</td>
                <td align="left">
                	<input name="instructDetail.vcCounterpartyTrader" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right">投资指令/建议确认时间：</td>
                <td align="left"> 
                	<input name="instructDetail.vcEntrustConfirm" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>

        	</tr>
        	<tr>
        		<td align="right">报价方式：</td>
                <td align="left">
                	<input name="instructDetail.vcQuoteMode" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="quoteMode" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right">交易日期：</td>
                <td align="left">
                	<input name="instructDetail.lTradeDate" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        		<td align="right">指令/建议修改时间：</td>
                <td align="left"> 
                	<input name="instructDetail.tModifyTime" class="nui-textbox tooltip" readonly="true" id="tModifyTime" enabled="false" width="80%"/>
                </td>
        		<td align="right">指令/建议撤销时间：</td>
                <td align="left"> 
                	<input name="instructDetail.tRepealTime" class="nui-textbox tooltip" readonly="true" id="tRepealTime" enabled="false" width="80%"/>
                </td>
        	</tr>
        	<tr>
        		<td align="right" id="enRepoRateText" >回购利率：</td>
                <td align="left">
                	<input name="instructDetail.enRepoRate" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        		<td align="right">回购天数：</td>
                <td align="left">
                	<input name="instructDetail.lRepoDays" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right">退回原因：</td>
                <td align="left" colspan="3"> 
            		<input name="instructDetail.vcRejectReason" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="backReason" readonly="true" enabled="false" width="92.4%"/>
                </td>
        	</tr>
        	<tr>
        		<td align="right">回购利息(元)：</td>
                <td align="left">
                	<input name="instructDetail.enRepoInterest" value="instructDetail.enRepoInterest" class="nui-spinner" minValue="0" maxValue="10000000000" format="n2" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right">占款天数：</td>
                <td align="left">
                	<input name="instructDetail.lContractPeriods" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right" rowspan="3">备注：</td>
        		<td align="left" colspan="3" rowspan="3">
                	<input name="instructDetail.vcRemark" class="nui-textarea" readonly="true" id="vcRemark" enabled="false" width="92.4%"/>
                </td>
        	</tr>
        	<tr>
        		<td align="right" id="enAmountText">回购金额(万元)：</td>
                <td align="left">
	            	<input name="instructDetail.enAmount" value="instructDetail.enAmount" class="nui-spinner" minValue="0" maxValue="10000000000" format="n4" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right">首期结算日：</td>
                <td align="left">
                	<input name="instructDetail.lFirstSettleDate" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        	</tr>
        	<tr>
        		<td align="right">到期结算金额(元)：</td>
                <td align="left">
	            	<input name="instructDetail.enSettleAmount" value="instructDetail.enSettleAmount" class="nui-spinner" minValue="0" maxValue="10000000000" format="n2" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right">到期结算日：</td>
                <td align="left">
                	<input name="instructDetail.lMaturitySettleDate" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        	</tr>
		</table>
 	</div>	
	<script type="text/javascript">
    	nui.parse();
    	$("#dataform_instruct_detail .mini-buttonedit-button").remove();
    	var instruct_detail_from = new nui.Form("#dataform_instruct_detail");
    	var lInquiryId = null;
    	function detail(selectRow){
    		var row = nui.clone(selectRow);
    		if(lInquiryId != row.lInquiryId){
    			//组装指令/建议下达时间显示信息
    			if(row.vcInitiatorName != null || row.tInitiateTime != null){
    				row["initiator"] = (row.vcInitiatorName==null?"":row.vcInitiatorName) + "　" + nui.formatDate(row.tInitiateTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//组装询价结果录入时间显示信息
    			if(row.vcResultInputerName != null || row.tResultInputTime != null){
    				row["resultInputer"] = (row.vcResultInputerName==null?"":row.vcResultInputerName) + "　" + nui.formatDate(row.tResultInputTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//组装投资经理确认时间显示信息
    			if(row.vcFsSenderName != null || row.tFsSendTime != null){
    				row["fsSender"] = (row.vcFsSenderName==null?"":row.vcFsSenderName) + "　" + nui.formatDate(row.tFsSendTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//组装投录单确认时间显示信息
    			if(row.vcFsOperatorName != null && row.tFsOperateTime != null){
    				row["fsOperator"] = (row.vcFsOperatorName==null?"":row.vcFsOperatorName) + "　" + nui.formatDate(row.tFsOperateTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			//组装录单复核时间显示信息
    			if(row.vcFsCheckerName != null && row.tFsCheckTime != null){
    				row["fsChecker"] = (row.vcFsCheckerName==null?"":row.vcFsCheckerName) + "　" + nui.formatDate(row.tFsCheckTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			
    			//组装指令/建议撤销时间显示
    			if(row.vcRepealerName != null && row.tRepealTime != null){
    				row["tRepealTime"] = (row.vcRepealerName==null?"":row.vcRepealerName) + "　" + nui.formatDate(row.tRepealTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			
    			if(row.lTradeDate != null){
    				row["lTradeDate"] = nui.formatDate(DateUtil.numStrToDate(row["lTradeDate"].toString()),"yyyy-MM-dd");
    			}
    			if(row.lFirstSettleDate != null){
    				row["lFirstSettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lFirstSettleDate"].toString()),"yyyy-MM-dd");
    			}
    			if(row.lMaturitySettleDate != null){
    				row["lMaturitySettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lMaturitySettleDate"].toString()),"yyyy-MM-dd");
    			}
    			//前台成交时间
    			if(row.tFsDealTime != null){
    				row["tFsDealTime"] = nui.formatDate(row.tFsDealTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			if(row.vcBizType=="6"){
    				document.getElementById("enAmountText").innerHTML = "首次结算金额(元)：";
    				row["enAmount"] = row.enFullPriceAmount;
    			}else{
    				document.getElementById("enAmountText").innerHTML = "回购金额(万元)：";
    				row["enAmount"] = row.enFaceAmount;
    			}
    			if(row.vcQuoteMode == "2"){
    				document.getElementById("enRepoRateText").innerHTML = "加权加点值(bp)：";
    				row["enRepoRate"] = row.vcQuoteMode;
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