<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 创金合信
  - Date: 2016-09-03 14:29:45
  - Description:
-->
<head>
<title>成交明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    <style type="text/css">
    	.mini-buttonedit-border{
    		padding-right:1px;
    	}
    </style>
</head>
<body>
	<div id="dataform_deal_detail_yhj">
		<table id="table" style="width:100%; table-layout:fixed;margin: 0xp;padding: 0px;" border="0" class="nui-form-table">	
			<tr>
                <td style="width:120px; padding: 5px 5px 5px 0px;" align="right">回购天数：</td>
                <td style="width:10%;">
                	<input name="dealDetails.lHgDays" class="nui-textbox" width="100px" readonly="true" enabled="false"/>
                </td>
                <td style="width:15%; padding: 5px 5px 5px 5px" align="right">首次结算日：</td>
                <td style="width:10%;">
                	<input name="dealDetails.lFirstSettleDate" class="nui-textbox" width="100px" readonly="true" enabled="false"/>
                </td>
                <td style="width:15%; padding: 5px 5px 5px 5px;" align="right">回购利率(%)：</td>
                <td style="width:10%;">
                	<input name="dealDetails.enRate" class="nui-textbox" width="100px" readonly="true" enabled="false"/>
                </td>
                <td id="enSettleBalance" style="width:15%; padding: 5px 5px 5px 0px;" align="right">成交金额(元)：</td>
                <td style="width:10%;">
                	<input name="dealDetails.enSettleBalance"  class="nui-spinner" minValue="0" maxValue="1000000000" format="n2" width="100px" readonly="true" enabled="false"/>
                </td>
        	</tr>
        	<tr>
                <td style="padding: 5px 5px 5px 5px" align="right">实际占款天数：</td>
                <td>
                	<input name="dealDetails.lUseDays" class="nui-textbox" width="100px" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">到期结算日：</td>
                <td>
                	<input name="dealDetails.lSecondSettleDate" class="nui-textbox" width="100px" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px" align="right">应计利息(元)：</td>
                <td>
                	<input name="dealDetails.enHgInterest"  class="nui-spinner" minValue="0" maxValue="1000000000" format="n2"  width="100px" readonly="true" enabled="false"/>
                </td>
        	 	<td style="padding: 5px 5px 5px 5px" align="right">到期结算金额(元)：</td>
                <td>
                	<input name="dealDetails.enSecondClearBalance"  class="nui-spinner" minValue="0" maxValue="1000000000" format="n2" width="100px" readonly="true" enabled="false"/>
                </td>
        	</tr>
		</table>
		
	</div>	
	<div id="dataform_deal_detail_jys"  style="display:none">
		<div id="datagrid_deal_details" dataField="dealDetails" 
	         url="com.cjhxfund.ats.sm.comm.InstructionManager.getDealDetail.biz.ext"
	         class="nui-datagrid" style="width:100%;height:120px;"
	         onselectionchanged="selectionchanged"
		     showPager="false"
		     allowSortColumn="false"
		     enableHotTrack="false">
			<div property="columns">
				<div field="lHgDays" width="100px" headerAlign="center" align="center">回购天数</div>
				<div field="enRate" width="120px" headerAlign="center" align="left">回购利率</div>
				<div field="enDealBalance" width="120px" headerAlign="center" align="left">交易金额</div>
				<div field="enHgInterest" width="120px" headerAlign="center" align="center">应计利息(元)</div>
				<div field="enSecondClearBalance" width="100px" headerAlign="center" align="center">到期结算金额(元)</div>	
				<div field="lFirstSettleDate" width="100px" headerAlign="center" align="center">首次结算日</div>
				<div field="lSecondSettleDate" width="120px" headerAlign="center" align="center">到期结算日</div>
				<div field="" width="120px" headerAlign="center" align="center">实际占款天数</div>
				<div field="" width="120px" headerAlign="center" align="center">交易品种</div>
			</div>
		</div>
	</div>
	
	<div id="datagrid_mortgage_info" dataField="mortgageInfos" 
         url="com.cjhxfund.ats.sm.comm.InstructionManager.getDealMortgageInfos.biz.ext"
         class="nui-datagrid" style="width:100%;height:100px;"
	     showPager="false"
	     onload="loaded"
	     allowSortColumn="false"
	     enableHotTrack="false">
		<div property="columns">
			<div field="vcReportCode" width="100px" headerAlign="center" align="center">债券代码</div>
			<div field="vcStockName" width="120px" headerAlign="center" align="center">债券名称</div>
			<div field="cMarketNo" name="cMarketNo" width="120px" headerAlign="center" align="center" renderer="renderTradePlace">交易市场</div>
			<div field="vcItemName" name="vcItemName" width="120px" headerAlign="center" align="center">托管机构</div>
			<div field="enBalance"  name="enBalance" width="100px" numberFormat="n2" headerAlign="center" align="center">券面总额（万元）</div>	
			<div field="enRatio" name="enRatio" width="100px" headerAlign="center" align="center">折算比率（%）</div>
			<div field="enFirstNetPrice" name="enFirstNetPrice" numberFormat="n4" width="120px" headerAlign="center" align="center">首次净价</div>
			<div field="enMatureNetPrice" name="enMatureNetPrice" numberFormat="n4" width="120px" headerAlign="center" align="center">到期净价</div>
		</div>
	</div>
	
	<script type="text/javascript">
    	nui.parse();
    	$("#dataform_deal_detail_yhj .mini-buttonedit-button").remove();
    	$("#dataform_deal_detail_jys .mini-buttonedit-button").remove();
    	var deal_detail = new nui.Form("#dataform_deal_detail_yhj");
    	var deal_detail_jys = new nui.Form("#dataform_deal_detail_jys");
    	var mortgage_grid = nui.get("datagrid_mortgage_info");
    	var deal_details_grid = nui.get("datagrid_deal_details");
    	function detail(selectRow){
			if(selectRow.vcFsDealId != null){
				var json = {vcDealNo:selectRow.vcFsDealId};
	    		if(selectRow.vcBizType=="5"){//银行间：5-银行间质押式回购
	    			document.getElementById("dataform_deal_detail_yhj").style.display="block";
	    			document.getElementById("datagrid_mortgage_info").style.display="block";
	    			document.getElementById("dataform_deal_detail_jys").style.display="none";
	    			document.getElementById("enSettleBalance").innerHTML = "成交金额(元)：";
	    			json["businClass"]=2;
	    			mortgage_grid.showColumn("enRatio");
					mortgage_grid.hideColumn("cMarketNo");
					mortgage_grid.hideColumn("vcItemName");
					mortgage_grid.hideColumn("enFirstNetPrice");
					mortgage_grid.hideColumn("enMatureNetPrice");
	    		}else if(selectRow.vcBizType=="6"){//银行间：6-银行间买断式回购
	    			document.getElementById("dataform_deal_detail_yhj").style.display="block";
	    			document.getElementById("datagrid_mortgage_info").style.display="block";
	    			document.getElementById("dataform_deal_detail_jys").style.display="none";
	    			document.getElementById("enSettleBalance").innerHTML = "首次结算金额(元)：";
	    			json["businClass"]=2;
	    			mortgage_grid.hideColumn("enRatio");
					mortgage_grid.showColumn("cMarketNo");
					mortgage_grid.showColumn("vcItemName");
					mortgage_grid.showColumn("enFirstNetPrice");
					mortgage_grid.showColumn("enMatureNetPrice");
	    		}else{//交易所回购业务
	    			document.getElementById("dataform_deal_detail_jys").style.display="block";
	    			document.getElementById("dataform_deal_detail_yhj").style.display="none";
	    			document.getElementById("datagrid_mortgage_info").style.display="none";
	    			document.getElementById("enSettleBalance").innerHTML = "成交金额(元)：";
	    			json["businClass"]=1;
	    			
	    			//json["businClass"]=1;
	    			//deal_details_grid.load(json);
	    			//return;
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
								if(dealDetail.lFirstSettleDate != null){
									dealDetail["lSecondSettleDate"] = nui.formatDate(DateUtil.numStrToDate(dealDetail["lSecondSettleDate"].toString()),"yyyy-MM-dd");
								}
								deal_detail.setData({dealDetails:dealDetail});
								mortgage_grid.load({lSerialNo:dealDetail.lSerialNo});
							}else{
								deal_detail.clear();
							}
						}
					}
				});
			}
    	}
    	function loaded(){
    		deal_details_grid.select(deal_details_grid.getRow(0),true);
    	}
    	function selectionchanged(){
    		var row = deal_details_grid.getSelected();
    		mortgage_grid.load({lSerialNo:row.lSerialNo});
    	}
    	
    	function clearDetail(){
			deal_detail.clear();
		}
		function renderTradePlace(e){
			return nui.getDictText("tradePlace",e.row.cMarketNo);
		}
    	window.parent.detailLoaded();
    </script>
</body>
</html>