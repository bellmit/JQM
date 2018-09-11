<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<%@ page import="java.io.*,java.util.*,java.text.*" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-09-03 10:33:42
  - Description:竞价系统行情（银行间债券报价）
-->
<head>
	<title>竞价系统行情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
<div id="shangJiaoMarket" style="float:left;">	
	<table class="table">
		<caption style="text-align:left">
			<span>上交所代码：<span name="vcStockCode"></span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span>上交所名称：<span name="vcStockName"></span></span>
		</caption>
		<thead>
			<tr>
				<td></td>
				<td>价格</td>
				<td>量(手)</td>
				<td>收益率(%)</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>卖五</td>
				<td name="salePrice5">--</td>
				<td name="saleAmount5">--</td>	
			</tr>
			<tr>
				<td>卖四</td>	
				<td name="salePrice4">--</td>
				<td name="saleAmount4">--</td>	
			</tr>
			<tr>
				<td>卖三</td>
				<td name="salePrice3">--</td>
				<td name="saleAmount3">--</td>	
			</tr>
			<tr>
				<td>卖二</td>	
				<td name="salePrice2">--</td>
				<td name="saleAmount2">--</td>	
			</tr>
			<tr>
				<td>卖一</td>
				<td name="salePrice1">--</td>
				<td name="saleAmount1">--</td>	
			</tr>
			<tr>
				<td>------------------------</td>	
				<td>------------------------</td>
				<td>------------------------</td>	
			</tr>
			<tr>
				<td>买一</td>
				<td name="buyPrice1">--</td>
				<td name="buyAmount1">--</td>
			</tr>
			<tr>
				<td>买二</td>		
				<td name="buyPrice2">--</td>
				<td name="buyAmount2">--</td>
			</tr>
			<tr>
				<td>买三</td>
				<td name="buyPrice3">--</td>
				<td name="buyAmount3">--</td>
			</tr>
			<tr>
				<td>买四</td>	
				<td name="buyPrice4">--</td>
				<td name="buyAmount4">--</td>
			</tr>
			<tr>
				<td>买五</td>
				<td name="buyPrice5">--</td>
				<td name="buyAmount5">--</td>
			</tr>
			<tr>
				<td>------------------------</td>	
				<td>------------------------</td>	
				<td>------------------------</td>
			</tr>
			<tr>
				<table>
					<tr>
						<td style="width:40px">开盘价</td>
						<td style="width:60px;align:left;" name="openPrice"></td>
						<td style="width:40px">最高价</td>
						<td style="width:60px;align:left;" name="maxPrice"></td>
						<td style="width:40px">最低价</td>
						<td style="width:60px;align:left;" name="minPrice"></td>
						<td style="width:28px">均价</td>
						<td style="width:60px;align:left;" name="avgPrice"></td>
					</tr>
				</table>
			</tr>
		</tbody>
	</table>
</div>	
	
<div id="shenJiaoMarket" style="float:left;margin-left:200px;">
	<table>
		<caption style="text-align:left">
			<span>深交所代码：<span name="vcStockCode"></span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span>深交所名称：<span name="vcStockName"></span></span>
		</caption>
		<thead>
			<tr>
				<td></td>
				<td>价格</td>
				<td>量(手)</td>
				<td>收益率(%)</td>
			</tr>
		</thead>
		<tr>
			<td>卖五</td>
			<td name="salePrice5">--</td>
			<td name="saleAmount5">--</td>
			<td name="saleYieldRatio5">--</td>		
		</tr>
		<tr>
			<td>卖四</td>	
			<td name="salePrice4">--</td>
			<td name="saleAmount4">--</td>
			<td name="saleYieldRatio4">--</td>	
		</tr>
		<tr>
			<td>卖三</td>
			<td name="salePrice3">--</td>
			<td name="saleAmount3">--</td>
			<td name="saleYieldRatio3">--</td>	
		</tr>
		<tr>
			<td>卖二</td>	
			<td name="salePrice2">--</td>
			<td name="saleAmount2">--</td>
			<td name="saleYieldRatio2">--</td>	
		</tr>
		<tr>
			<td>卖一</td>
			<td name="salePrice1">--</td>
			<td name="saleAmount1">--</td>
			<td name="saleYieldRatio1">--</td>	
		</tr>
		<tr>
			<td>--------------</td>	
			<td>-----------------</td>
			<td>-----------------</td>
			<td>-----------------</td>		
		</tr>
		<tr>
			<td>买一</td>
			<td name="buyPrice1">--</td>
			<td name="buyAmount1">--</td>
			<td name="buyYieldRatio1">--</td>
		</tr>
		<tr>
			<td>买二</td>		
			<td name="buyPrice2">--</td>
			<td name="buyAmount2">--</td>
			<td name="buyYieldRatio2">--</td>
		</tr>
		<tr>
			<td>买三</td>
			<td name="buyPrice3">--</td>
			<td name="buyAmount3">--</td>
			<td name="buyYieldRatio3">--</td>
		</tr>
		<tr>
			<td>买四</td>	
			<td name="buyPrice4">--</td>
			<td name="buyAmount4">--</td>
			<td name="buyYieldRatio4">--</td>
		</tr>
		<tr>
			<td>买五</td>
			<td name="buyPrice5">--</td>
			<td name="buyAmount5">--</td>
			<td name="buyYieldRatio5">--</td>
		</tr>
		<tr>
			<td>--------------</td>	
			<td>-------------------</td>	
			<td>-------------------</td>
			<td>-------------------</td>
		</tr>
		<tr>
			<table>
				<tr>
					<td style="width:40px">开盘价</td>
					<td style="width:60px;align:left;" name="openPrice"></td>
					<td style="width:40px">最高价</td>
					<td style="width:60px;align:left;" name="maxPrice"></td>
					<td style="width:40px">最低价</td>
					<td style="width:60px;align:left;" name="minPrice"></td>
					<td style="width:28px">均价</td>
					<td style="width:60px;align:left;" name="avgPrice"></td>
				</tr>
			</table>
		</tr>
	</table>
</div>
	当前行情时间:
	<%
	  SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	  Date currentTime = new Date(); 
	  String time = simpleDateFormat.format(currentTime).toString();
	  out.print(time);
	%>
	<script type="text/javascript">
    	nui.parse();
    	$("#shangJiaoMarket").css('display','none');
    	$("#shenJiaoMarket").css('display','none');
    	function detail(row){
    		if(row.vcStepMarketInterCode != null && row.vcStepMarketInterCode!=""){
    			nui.ajax({
	    			url:"com.cjhxfund.ats.sm.transaction.QuotationInfoManager.getMarketStock.biz.ext",
	    			type:"post",
	    			data:{vcStepMarketInterCode:row.vcStepMarketInterCode},
	    			async: false,
	    			contentType:"text/json",
	    			success:function(text){
	    				var returnJson = nui.decode(text);
	    				if(returnJson.exception==null){
	    					var stockInfo = returnJson.marketStock;
	    					if(stockInfo.length>0){
	    						for(var i=0;i<stockInfo.length;i++){
	    							if(stockInfo[i].VCMARKETNO == "1"){//上交所
	    								setShStockMarket({vcStockCode:stockInfo[i].VCSTOCKCODE,vcStockName:stockInfo[i].VCSTOCKNAME,vcMarketNo:stockInfo[i].VCMARKETNO});
	    							}else if(positions[i].VCMARKETNO == "2"){//深交所
	    								setSzStockMarket({vcStockCode:stockInfo[i].VCSTOCKCODE,vcStockName:stockInfo[i].VCSTOCKNAME,vcMarketNo:stockInfo[i].VCMARKETNO});
	    							}
								}
	    					};
	    				}
	    			}
	    		});
    		}else{
    			if(row.vcMarketNo=="2"){
    				setSzStockMarket(row);
    			}else{
    				setShStockMarket(row);
    			}
    		}
    	}
    	
    	function setShStockMarket(data){
    		$("#shangJiaoMarket").css('display','block');
    		$("#shangJiaoMarket [name='vcStockCode']").html(data.vcStockCode);
    		$("#shangJiaoMarket [name='vcStockName']").html(data.vcStockName);
    		nui.ajax({
    			url:"com.cjhxfund.ats.sm.transaction.QuotationInfoManager.getTstockMarket.biz.ext",
    			type:"post",
    			data:{stockInfo:data},
    			async: false,
    			contentType:"text/json",
    			success:function(text){
    				var returnJson = nui.decode(text);
    				if(returnJson.exception==null){
    					var stockMarket = returnJson.resultMap;
    					if(stockMarket.length>0){
    						$("#shangJiaoMarket [name='buyPrice1']").html(stockMarket[0].buyPrice1);
				    		$("#shangJiaoMarket [name='buyAmount1']").html(stockMarket[0].buyAmount1);
				    		$("#shangJiaoMarket [name='buyPrice2']").html(stockMarket[0].buyPrice2);
				    		$("#shangJiaoMarket [name='buyAmount2']").html(stockMarket[0].buyAmount2);
				    		$("#shangJiaoMarket [name='buyPrice3']").html(stockMarket[0].buyPrice3);
				    		$("#shangJiaoMarket [name='buyAmount3']").html(stockMarket[0].buyAmount3);
				    		$("#shangJiaoMarket [name='buyPrice4']").html(stockMarket[0].buyPrice4);
				    		$("#shangJiaoMarket [name='buyAmount4']").html(stockMarket[0].buyAmount4);
				    		$("#shangJiaoMarket [name='buyPrice5']").html(stockMarket[0].buyPrice5);
				    		$("#shangJiaoMarket [name='buyAmount6']").html(stockMarket[0].buyAmount5);
				
							$("#shangJiaoMarket [name='salePrice1']").html(stockMarket[0].salePrice1);
				    		$("#shangJiaoMarket [name='saleAmount1']").html(stockMarket[0].saleAmount1);
				    		$("#shangJiaoMarket [name='salePrice2']").html(stockMarket[0].salePrice2);
				    		$("#shangJiaoMarket [name='saleAmount2']").html(stockMarket[0].saleAmount2);
				    		$("#shangJiaoMarket [name='salePrice3']").html(stockMarket[0].salePrice3);
				    		$("#shangJiaoMarket [name='saleAmount3']").html(stockMarket[0].saleAmount3);
				    		$("#shangJiaoMarket [name='salePrice4']").html(stockMarket[0].salePrice4);
				    		$("#shangJiaoMarket [name='saleAmount4']").html(stockMarket[0].saleAmount4);
				    		$("#shangJiaoMarket [name='salePrice5']").html(stockMarket[0].salePrice5);
				    		$("#shangJiaoMarket [name='saleAmount5']").html(stockMarket[0].saleAmount5);
							
							$("#shangJiaoMarket [name='openPrice']").html(stockMarket[0].openPrice);
							$("#shangJiaoMarket [name='maxPrice']").html(stockMarket[0].maxPrice);
							$("#shangJiaoMarket [name='minPrice']").html(stockMarket[0].minPrice);
							$("#shangJiaoMarket [name='avgPrice']").html(stockMarket[0].avgPrice);
    					};
    				}
    			}
    		});
    		
    		
    		
    		
    	}
    	function setSzStockMarket(data){
    		$("#shenJiaoMarket").css('display','block');
    		$("#shenJiaoMarket [name='vcStockCode']").html(data.vcStockCode);
    		$("#shenJiaoMarket [name='vcStockName']").html(data.vcStockName);
    		nui.ajax({
    			url:"com.cjhxfund.ats.sm.transaction.QuotationInfoManager.getTstockMarket.biz.ext",
    			type:"post",
    			data:{stockInfo:data},
    			async: false,
    			contentType:"text/json",
    			success:function(text){
    				var returnJson = nui.decode(text);
    				if(returnJson.exception==null){
    					var stockMarket = returnJson.resultMap;
			    		$("#shenJiaoMarket [name='buyAmount1']").html(stockMarket[0].buyAmount1);
			    		$("#shenJiaoMarket [name='buyPrice2']").html(stockMarket[0].buyPrice2);
			    		$("#shenJiaoMarket [name='buyAmount2']").html(stockMarket[0].buyAmount2);
			    		$("#shenJiaoMarket [name='buyPrice3']").html(stockMarket[0].buyPrice3);
			    		$("#shenJiaoMarket [name='buyAmount3']").html(stockMarket[0].buyAmount3);
			    		$("#shenJiaoMarket [name='buyPrice4']").html(stockMarket[0].buyPrice4);
			    		$("#shenJiaoMarket [name='buyAmount4']").html(stockMarket[0].buyAmount4);
			    		$("#shenJiaoMarket [name='buyPrice5']").html(stockMarket[0].buyPrice5);
			    		$("#shenJiaoMarket [name='buyAmount6']").html(stockMarket[0].buyAmount5);
			
						$("#shenJiaoMarket [name='salePrice1']").html(stockMarket[0].salePrice1);
			    		$("#shenJiaoMarket [name='saleAmount1']").html(stockMarket[0].saleAmount1);
			    		$("#shenJiaoMarket [name='salePrice2']").html(stockMarket[0].salePrice2);
			    		$("#shenJiaoMarket [name='saleAmount2']").html(stockMarket[0].saleAmount2);
			    		$("#shenJiaoMarket [name='salePrice3']").html(stockMarket[0].salePrice3);
			    		$("#shenJiaoMarket [name='saleAmount3']").html(stockMarket[0].saleAmount3);
			    		$("#shenJiaoMarket [name='salePrice4']").html(stockMarket[0].salePrice4);
			    		$("#shenJiaoMarket [name='saleAmount4']").html(stockMarket[0].saleAmount4);
			    		$("#shenJiaoMarket [name='salePrice5']").html(stockMarket[0].salePrice5);
			    		$("#shenJiaoMarket [name='saleAmount5']").html(stockMarket[0].saleAmount5);
						
						$("#shenJiaoMarket [name='openPrice']").html(stockMarket[0].openPrice);
						$("#shenJiaoMarket [name='maxPrice']").html(stockMarket[0].maxPrice);
						$("#shenJiaoMarket [name='minPrice']").html(stockMarket[0].minPrice);
						$("#shenJiaoMarket [name='avgPrice']").html(stockMarket[0].avgPrice);
    				}
    			}
    		});
    	}
    	
    	
    	function clearDetail(){
    		
    	}
    	
    	window.parent.detailLoaded();
    </script>
</body>
</html>