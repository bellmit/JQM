<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-09-03 14:29:33
  - Description:指令/建议明细（指令/建议跟踪）
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
		<table id="table" border="0" cellpadding="0" cellspacing="0" style="width:100%;table-layout:fixed;">
			<tr>
                <td style="width:110px" align="right">产品名称：</td>
                <td style="width:15%" align="left">
                	<input name="instructDetail.vcProductName" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        		<td style="width:110px" align="right">交易日期：</td>
                <td style="width:15%" align="left">
                	<input name="instructDetail.lTradeDate" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
                <td style="width:110px" align="right">交易对手：</td>
                <td style="width:15%" align="left">
                	<input name="instructDetail.vcCounterpartyName" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        	 	<td style="width:110px" align="right">指令/建议录入时间：</td>
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
        		<td align="right">指令/建议复核时间：</td>
                <td align="left"> 
                	<input name="instructDetail.vcAdviserConfirm" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        	</tr>
        	<tr>
        		<td align="right">债券代码：</td>
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
                <td align="right">指令/建议确认时间：</td>
                <td align="left"> 
                	<input name="instructDetail.vcEntrustConfirm" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        	</tr>
        	<tr>
                <td align="right">债券名称：</td>
                <td align="left">
                	<input name="instructDetail.vcStockName" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right">指令/建议净价：</td>
                <td align="left">
                	<input name="instructDetail.enNetPrice" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        		<td align="right">对手席位：</td>
                <td align="left">
                	<input name="instructDetail.vcRivalSeat" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        		<td align="right">指令/建议修改时间：</td>
                <td align="left"> 
                	<input name="instructDetail.tModifyTime" class="nui-textbox tooltip" readonly="true" id="tModifyTime" enabled="false" width="80%"/>
                </td>
        	</tr>
        	<tr>
        		<td align="right">债券类别：</td>
                <td align="left">
                	<input name="instructDetail.vcStocktypeName" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right">指令/建议全价：</td>
                <td align="left">
                	<input name="instructDetail.enFullPrice" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        		<td align="right">约定号：</td>
                <td align="left">
                	<input name="instructDetail.vcAgreemtCode" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
                <td style="width:80" align="right">指令/建议撤销时间：
                <td align="left"> 
                	<input name="instructDetail.tRepealTime" class="nui-textbox tooltip" readonly="true" id="tRepealTime" enabled="false" width="80%"/>
                </td>
        	</tr>
        	<tr>
        		<td align="right">债券评级：</td>
                <td align="left">
                	<input name="instructDetail.vcBondRating" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="creditRating" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right">券面金额(万元)：</td>
                <td align="left">
                	<input name="instructDetail.enFaceAmount" value="instructDetail.enFaceAmount" class="nui-spinner" minValue="0" maxValue="10000000000" format="n2" readonly="true" enabled="false" width="80%"/>
                </td>
        		<td align="right">退回原因：</td>
                <td align="left" colspan="3"> 
            		<input name="instructDetail.vcRejectReason" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="backReason" readonly="true" enabled="false" width="92.4%"/>
                </td>
        	</tr>
        	<tr>
                <td align="right">主体评级：</td>
                <td align="left">
                	<input name="instructDetail.vcOrgRating" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="issuerRating" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right">到期收益率(%)：</td>
                <td align="left">
                	<input name="instructDetail.enMaturityYield" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        		<td align="right" rowspan="3">备注：</td>
        		<td align="left" colspan="3" rowspan="3">
                	<input name="instructDetail.vcRemark" class="nui-textarea" readonly="true" id="vcRemark" enabled="false" width="92.4%"/>
                </td>
        	</tr>
        	<tr>
        		<td align="right">剩余期限：</td>
                <td align="left">
                	<input name="instructDetail.vcLimitLeft" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
                <td align="right">行权收益率(%)：</td>
                <td align="left">
                	<input name="instructDetail.enOptionYield" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        	</tr>
        	<tr>
        		<td align="right">久期：</td>
                <td align="left">
                	<input name="instructDetail.enDuration" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        		<td align="right">结算日期：</td>
                <td align="left">
                	<input name="instructDetail.lFirstSettleDate" class="nui-textbox" readonly="true" enabled="false" width="80%"/>
                </td>
        	</tr>
		</table>
 	</div>	

	<script type="text/javascript">
    	nui.parse();
    	$("#dataform_instruct_detail .mini-buttonedit-button").remove();
    	var instruct_detail_from = new nui.Form("#dataform_instruct_detail");
    	var lInquiryId = null;
    	var lResultId = null;
    	function detail(selectRow){
    		debugger;
    		var row = nui.clone(selectRow);
    		if(lInquiryId != row.lInquiryId && lResultId != row.lResultId){
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
    			//组装指令/建议撤销时间显示
    			if(row.vcRepealerName != null && row.tRepealTime != null){
    				row["tRepealTime"] = (row.vcRepealerName==null?"":row.vcRepealerName) + "　" + nui.formatDate(row.tRepealTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			
    			//格式化8位数字为日期格式
    			if(row.lIssueDate != null){
    				row["lIssueDate"] = nui.formatDate(DateUtil.numStrToDate(row["lIssueDate"].toString()),"yyyy-MM-dd");
    			}
    			if(row.lTradeDate != null){
    				row["lTradeDate"] = nui.formatDate(DateUtil.numStrToDate(row["lTradeDate"].toString()),"yyyy-MM-dd");
    			}
    			if(row.lFirstSettleDate != null){
    				row["lFirstSettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lFirstSettleDate"].toString()),"yyyy-MM-dd");
    			}//指令/建议修改时间
    			if(row.tModifyTime != null){
    				row["tModifyTime"] = nui.formatDate(row.tModifyTime, "yyyy-MM-dd HH:mm:ss");
    			}
    			instruct_detail_from.setData({instructDetail:row});
    			lInquiryId = row.lInquiryId;
    			lResultId = row.lResultId;
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