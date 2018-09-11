<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-09-03 10:10:29
  - Description: 持仓信息（银行间债券报价）
-->
<head>
	<title>持仓信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	<div id="datagrid_position_info" class="nui-datagrid" style="width:100%;height:100%;"
			url="com.cjhxfund.ats.sm.transaction.QuotationInfoManager.getPositionInfoByBond.biz.ext" 
			dataField="positionInfos" showPager="false"
			onload="loadAvailQty" 
			allowSortColumn="false"
	     	enableHotTrack="false">
		<div property="columns">
			<div name="action" width="100px" headerAlign="center">操作</div>
			<div field="vcFundName" width="150px" headerAlign="center">产品名称</div>
			<div field="vcCombiName" width="100px" headerAlign="center">组合名称</div>
			<div field="vcReportCode" width="100px" headerAlign="center">债券代码</div>
			<div field="vcStockName" width="100px" headerAlign="center">债券名称</div>
			<div field="cMarketNo" width="100px" headerAlign="center" renderer="renderMarket">所属市场</div>
			<div field="enCostPrice" width="100px" numberFormat="n2" align="right" headerAlign="center">成本价</div>
			<div field="lCurrentAmount" width="100px" numberFormat="n0" align="right" headerAlign="center">持仓数量</div>
			<div field="vcAvailablequantity" width="100px" numberFormat="n0" align="right" headerAlign="center">可用数量</div>
			<div name="mortgageDetail" width="100px" align="center" headerAlign="center">质押明细</div>
		</div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	var position_info_grid = nui.get("datagrid_position_info");
    	var reportCode = null;
    	var marketNo = null;
    	function detail(row){
    		//当选中的单条记录不是上一个选中的时候重新加载持仓信息
    		if(reportCode !=row.vcStockCode || marketNo != row.vcMarketNo){
    			var json = {paramBond:{reportCode:row.vcStockCode}};
    			json = nui.decode(json);
    			position_info_grid.load(json);
    			
    			reportCode = row.vcStockCode;
    			marketNo = row.vcMarketNo;
    		}
    	}
    	function loadAvailQty(){
    		var positionList = position_info_grid.getResultObject();//获取列表加载数据信息
    		var positions = positionList.positionInfos;
    		var sendMsg = {};
    		sendMsg.combis=[];
    		
    		for(var i=0;i<positions.length;i++){
    			sendMsg.combis[sendMsg.combis.length] = {vcAccount:positions[i].vcCombiNo,vcStockCode:positions[i].vcReportCode,vcMarket:"OTC",vcBusinType:"01",vcInvestType:"1"};
			}
			if(positions.length>0){
				nui.ajax({
		            url: "com.cjhxfund.ats.sm.comm.AvaiableDataManager.queryAvailQty.biz.ext",
		            type: "post",
		            data: {sendMsg:sendMsg},
		            contentType:'text/json',
		            success: function (text) { 
		              	var returnJson = nui.decode(text);//反序列化成对象
						if(returnJson.exception == null){
						    var row = {};
							$(returnJson.ret).each(function(){ 
								var vcCombiNo = this.VC_ACCOUNT;
								var vcReportCode = this.VC_SYMBOL;
								var cMarketNo = this.VC_EXDESTINATION;
								row = position_info_grid.findRow(function(row){
									if(row.vcCombiNo == vcCombiNo && row.vcReportCode == vcReportCode && row.cMarketNo == cMarketNo) return true;
								});
	 							row["vcAvailablequantity"] = this.VC_AVAILABLEQUANTITY_T0;
	 							position_info_grid.updateRow(row);
							}); 
						}
		            }
		        });
			}
    	}
    	
    	position_info_grid.on("drawcell", function (e) {
	        var record = e.record,
	    	 	column = e.column;
	        //action列，超连接操作按钮
	        if (column.name == "action") {
	            e.cellStyle = "text-align:center";
	            var operatColumn = "--";
	            if(record.isSellOperate=="1"){
	            	operatColumn = '<a style="color:#00CCFF" href="javascript:sellBond(\'' + position_info_grid.indexOf(record) + '\')">卖出</a>&nbsp; ' +
	        				 	   '<a style="color:#00CCFF" href="javascript:buyBond(\'' + position_info_grid.indexOf(record) + '\')">追加买入</a> ';
	            }
	        	e.cellHtml = operatColumn;
	        }
	        //质押明细列，超连接操作按钮
	        if (column.name == "mortgageDetail") {
	        	
	            e.cellStyle = "text-align:center";
	        	e.cellHtml = '<a style="color:#00CCFF" href="javascript:mortgageDetail(' + position_info_grid.indexOf(record) + ')">明细</a>&nbsp; ';
	        }
	    });
    	
    	//质押明细
    	function mortgageDetail(rowIndex){
    		var record = position_info_grid.getRow(parseInt(rowIndex));
    		nui.open({
			    url: nui.context+"/transaction/invest/tbond_quote/mortgageDetail.jsp",
			    title: "质押明细", width: 600, height: 400,
			    onload: function () {
			        var iframe = this.getIFrameEl();
			        var data = {combiCode:record.vcCombiNo,reportCode:record.vcReportCode,marketNo:record.cMarketNo};
			        iframe.contentWindow.setData(data);
			    },
			    ondestroy: function (action) {
			    }
			});
    	}
    
    	//卖出
    	function sellBond(rowIndex){
    		var record = position_info_grid.getRow(parseInt(rowIndex));
    		var url = nui.context+"/transaction/invest/interbank_trade/instructIssue.jsp";
    		var json = {};
			if(record.cMarketNo == "1"){//上交所
				//json["vcBizType"] = "3";
				url = nui.context+"/transaction/invest/sh_block_trade/instructIssue.jsp";
			}if(record.cMarketNo == "2"){//深交所
				url = nui.context+"/transaction/invest/sz_integrated_prot/instructIssue.jsp";
			}
			nui.open({
    			url: url,
    			title: "投资指令/建议", width: 950, height: 550,
    			onload: function () {
			        var iframe = this.getIFrameEl();
			        json["vcEntrustDirection"]="01";
			        json["vcProductCode"]=record.vcFundCode;
			        json["vcCombiCode"]=record.vcCombiNo;
			        json["vcStockCode"]=record.vcReportCode;
			        if(record.vcAvailablequantity != "" && typeof(record.vcAvailablequantity) != "undefined"){
			        	data["enFaceAmount"]= parseInt(record.vcAvailablequantity)*100/10000;
			        }
			        iframe.contentWindow.SetData(json);
    			},
    			ondestroy: function (action) {
        			//grid.reload();
    			}
			});	
    	}
    	
    	//追加买入
    	function buyBond(rowIndex){
    		var record = position_info_grid.getRow(parseInt(rowIndex));
    		var url = nui.context+"/transaction/invest/interbank_trade/instructIssue.jsp";
    		var json = {};
			if(record.cMarketNo == "1"){//上交所
				//json["vcBizType"] = "3";
				url = nui.context+"/transaction/invest/sh_block_trade/instructIssue.jsp";
			}if(record.cMarketNo == "2"){//深交所
				url = nui.context+"/transaction/invest/sz_integrated_prot/instructIssue.jsp";
			}
			nui.open({
    			url: url,
    			title: "投资指令/建议", width: 950, height: 550,
    			onload: function () {
			        var iframe = this.getIFrameEl();
			        json["vcEntrustDirection"]="01";
			        json["vcProductCode"]=record.vcFundCode;
			        json["vcCombiCode"]=record.vcCombiNo;
			        json["vcStockCode"]=record.vcReportCode;
			        iframe.contentWindow.SetData(json);
    			},
    			ondestroy: function (action) {
        			//grid.reload();
    			}
			});	
    	}
    	
    	function clearDetail(){
    		reportCode = null;
    		marketNo = null;
    		position_info_grid.clearRows();
    	}
    	//交易市场列字典翻译
	    function renderMarket(e){
	    	return nui.getDictText("tradePlace",e.row.cMarketNo);
	    }
    </script>
</body>
</html>