<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-09-03 14:29:45
  - Description:成交明细（指令/建议跟踪）
-->
<head>
	<title>成交明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="<%= request.getContextPath() %>/JQMHistory/common/common.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
</head>
<body>
	<div id="dataform_deal_detail">
		<table id="table" border="0" cellpadding="0" cellspacing="0" style="width:100%;table-layout:fixed;">
			<tr>
                <td style="width:110px" align="right">托管机构：</td>
                <td style="width:15%" align="left">
                	<input name="dealDetails.vcItemName" class="nui-textbox" width="80%" readonly="true" enabled="false"/>
                </td>
                <td style="width:110px" align="right">交易对手：</td>
                <td style="width:15%" align="left">
                	<input name="dealDetails.vcName" class="nui-textbox" width="80%" readonly="true" enabled="false"/>
                </td>
                <td style="width:110px" align="right">对方交易员名称：</td>
                <td style="width:15%" align="left">
                	<input name="dealDetails.vcRivaltraderName" class="nui-textbox" width="80%" readonly="true" enabled="false"/>
                </td>
                <td style="width:120px" align="right">券面总额（元）：</td>
                <td style="width:15%" align="left">
                	<input name="dealDetails.enBalance" class="nui-spinner" minValue="0" maxValue="1000000000" format="n2" width="80%" readonly="true" enabled="false"/>
                </td>
               
        	</tr>
        	<tr>
        	 	<td align="right">到期收益率（%）：</td>
                <td align="left">
                	<input name="dealDetails.enSecondMatureYield" class="nui-textbox" width="80%" readonly="true" enabled="false"/>
                </td>
                <td align="right">交易金额（元）：</td>
                <td align="left">
                	<input name="dealDetails.enDealBalance" class="nui-spinner" minValue="0" maxValue="1000000000" format="n2" width="80%" readonly="true" enabled="false"/>
                </td>
                 <td align="right">应计利息（元）：</td>
                <td align="left">
                	<input name="dealDetails.enFirstSettleInterest" class="nui-spinner" minValue="0" maxValue="1000000000" format="n2" width="80%" readonly="true" enabled="false"/>
                </td>
                <td align="right">应计利息总额（元）：</td>
                <td align="left">
                	<input name="dealDetails.enTotalInterest" class="nui-spinner" minValue="0" maxValue="1000000000" format="n2" width="80%" readonly="true" enabled="false"/>
                </td>
        	</tr>
        	<tr>
        	 	<td align="right">净价（元）：</td>
                <td align="left">
                	<input name="dealDetails.enFirstNetPrice" class="nui-spinner" minValue="0" maxValue="200" format="n4" width="80%" readonly="true" enabled="false"/>
                </td>
                <td align="right">全价（元）：</td>
                <td align="left">
                	<input name="dealDetails.enFirstFullPrice" class="nui-spinner" minValue="0" maxValue="200" format="n4" width="80%" readonly="true" enabled="false"/>
                </td>
                <td align="right">结算金额（元）：</td>
                <td align="left">
                	<input name="dealDetails.enSettleBalance" class="nui-spinner" minValue="0" maxValue="1000000000" format="n2"  width="80%" readonly="true" enabled="false"/>
                </td>
                <td align="right">结算日期：</td>
                <td align="left">
                	<input name="dealDetails.lFirstSettleDate" class="nui-textbox" width="80%" readonly="true" enabled="false"/>
                </td>
        	</tr>
		</table>
	</div>	
	<script type="text/javascript">
    	nui.parse();
    	$("#dataform_deal_detail .mini-buttonedit-button").remove();
    	var deal_detail = new nui.Form("#dataform_deal_detail");
		var lResultId = null;
    	function detail(selectRow){
    		if(lResultId != selectRow.lResultId){
    			if(selectRow.vcClordId != null){
    				var json = {vcDealNo:selectRow.vcFsDealId};
		    		//债券买卖业务下的银行间买卖
		    		if(selectRow.vcBizType == "1"){
		    			json["businClass"] = "2";
		    		}else{
		    			json["businClass"] = "1";
		    		}
		    		json = nui.encode(json);
		    		nui.ajax({
						url:"com.cjhxfund.ats.sm.comm.InstructionManager.getDealDetail.biz.ext",
						type:'POST',
						data:json,
						cache: false,
						contentType:'text/json',
						success:function(text){
							var returnJson = nui.decode(text);
							if(returnJson.exception == null){
								if(returnJson.dealDetails.length>=1){
									var dealDetail = returnJson.dealDetails[0];
									if(dealDetail.lFirstSettleDate != null){
										dealDetail["lFirstSettleDate"] = nui.formatDate(DateUtil.numStrToDate(dealDetail["lFirstSettleDate"].toString()),"yyyy-MM-dd");
									}
									deal_detail.setData({dealDetails:dealDetail});
								}else{
									deal_detail.clear();
								}
								
							}
						}
					});
    			}
    			lResultId = selectRow.lResultId;
    		}
    	}
    	
    	function clearDetail(){
    		lResultId = null;
    		deal_detail.clear();
    	}
    	window.parent.detailLoaded();
    </script>
</body>
</html>