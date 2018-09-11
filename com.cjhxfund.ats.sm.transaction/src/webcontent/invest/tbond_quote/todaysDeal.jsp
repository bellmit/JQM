<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 创金合信
  - Date: 2016-09-03 10:08:04
  - Description:当日成交（银行间债券报价）
-->
<head>
	<title>当日成交</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	<div id="datagrid_today_deal" dataField="todayDeals" 
			url="com.cjhxfund.ats.sm.transaction.QuotationInfoManager.queryTodayDealQuote.biz.ext"
			class="nui-datagrid" style="width:100%;height:300px;"
            pageSize="10" showPageInfo="true"
            onselectionchanged="selectionChanged"
            allowSortColumn="true"
            sortMode="client" enableHotTrack="false"
            sizeList="[10,20,50,100]"
            pagerButtons="#screens_todays_deal">
        <div property="columns">
            <div name="action" width="195px" headerAlign="center">操作</div>
            <div field="vcStockCode" headerAlign="center" width="85px">
                债券代码
            </div>
            <div field="vcStockName" headerAlign="center" width="100px">
                债券简称
            </div>
            <div field="vcLimitLeft" headerAlign="center" width="80px">
                剩余年限
            </div>
            <div field="isPosition" headerAlign="center" width="80px">
                是否有持仓
            </div>
            <div field="vcStockType" headerAlign="center" width="85px">
                类型
            </div>
            <div field="rtYield" headerAlign="center" align="right" width="85px">
                成交价
            </div>
            <div field="enCbValueIncmRate" headerAlign="center" align="right" width="85px">
                中债
            </div>
            <div field="vcBondIssueAppraise" headerAlign="center" width="85px">
                主/债
            </div>
            <div field="rtTime" headerAlign="center" width="140px" dateFormat="yyyy-MM-dd HH:mm:ss">
                时间
            </div>
            <div field="srcCode" headerAlign="center" width="85px" renderer="renderQuoteSrc">
                机构
            </div>
         </div>
     </div>
     <div id="screens_todays_deal">
        <span class="separator"></span>
        <div id="isPosition" class="nui-checkbox" readOnly="false" text="只显示有持仓债券" value="0" trueValue="1" falseValue="0" oncheckedchanged="checkChanged"></div>
		<div id="myAttention" class="nui-checkbox" readOnly="false" text="只显示关注债券" value="0" trueValue="1" falseValue="0" oncheckedchanged="checkChanged"></div>
    </div>
    
	<%-- 详情开始... --%>
	<div></div>
   	<div id="tabs_tbond_quote_detail" class="nui-tabs" activeIndex="0" ontabload="tabload" onactivechanged="activechanged" height="40%">
   		<div title="持仓信息" url="<%= request.getContextPath() %>/transaction/invest/tbond_quote/positionInfo.jsp"></div>
   		<div title="债券基本信息" url="<%= request.getContextPath() %>/transaction/invest/tbond_quote/tBondBaseInfo.jsp"></div>
   		<div title="信用评级" url="<%= request.getContextPath() %>/transaction/invest/tbond_quote/stockCreditRate.jsp"></div>
   		<div title="质押信息" url="<%= request.getContextPath() %>/transaction/invest/tbond_quote/mortgageInfo.jsp"></div>
   		<div name="sysMarket" title="竞价系统行情" url="<%= request.getContextPath() %>/transaction/invest/tbond_quote/askBidSysMarket.jsp"></div>
   	</div>
   	<%-- 详情结束... --%>

	<script type="text/javascript">
    	nui.parse();
    	var today_deal_grid = nui.get("datagrid_today_deal");
    	var tabDetailRole = nui.get("#tabs_tbond_quote_detail");//获取详情标签列表
		var isSigleSelectChanged = false;
    	function search(json){
    		today_deal_grid.load(json);//grid查询
    	}
    	function checkChanged(){
    		window.parent.search();
    	}
    	today_deal_grid.on("drawcell", function (e) {
	        var record = e.record,
	    	 	column = e.column,
	    		field = e.field,
	    		value = e.value;
	    	if(field =="isPosition"){
	    		e.cellHtml = (value == 1)?"是":"否";
	    	}
	        //action列，超连接操作按钮
	        if (column.name == "action") {
	            e.cellStyle = "text-align:center";
	            var operatColumn = '';
	            if(record.isBuyOperate =="1"){
	            	operatColumn += '<a style="color:#00CCFF" href="javascript:buyBond(\'' + today_deal_grid.indexOf(record) + '\')">买入</a>&nbsp; ';
	            }
	            if(record.isPosition == "1" && record.isSellOperate=="1"){
	            	operatColumn += '<a style="color:#00CCFF" href="javascript:sellBond(\'' + today_deal_grid.indexOf(record) + '\')">卖出</a>&nbsp; ';
	            }
	            if(record.isAttention == "1"){
	            	operatColumn += '<a style="color:#00CCFF" href="javascript:moveAttention(\'' + today_deal_grid.indexOf(record) + '\')">取消关注</a>&nbsp; ';
	            }else{
	            	operatColumn += '<a style="color:#00CCFF" href="javascript:addAttention(\'' + today_deal_grid.indexOf(record) + '\')">关注</a>&nbsp; ';
	        	}
	        	operatColumn += '<a style="color:#00CCFF" href="javascript:showHistory(\'' + today_deal_grid.indexOf(record) + '\')">历史成交</a>';
	        	e.cellHtml = operatColumn;
	        }
	    });
    	
    	
    	function selectionChanged(){
			var rows = today_deal_grid.getSelecteds();
			var marketTab = tabDetailRole.getTab("sysMarket");
			
			if(rows.length == 1){
				var row = today_deal_grid.getSelected();
				if(row.vcMarketNo=="5" && (row.vcStepMarketInterCode==null || row.vcStepMarketInterCode=="")){
					if(tabDetailRole.getActiveTab()==marketTab){
						tabDetailRole.activeTab(tabDetailRole.getTab(0));
					}
					tabDetailRole.updateTab(marketTab,{visible:false});
				}else{
					tabDetailRole.updateTab(marketTab,{visible:true});
				}
				showDetail(row);
			}else {
				tabDetailRole.activeTab(tabDetailRole.getTab(0));
				tabDetailRole.updateTab(marketTab,{visible:false});
				clearDetail();
			}
		}
		
		function showDetail(row){
			isSigleSelectChanged = true;
			var currentTabIFrameEl = tabDetailRole.getTabIFrameEl(tabDetailRole.getActiveTab());//获取当前详情标签
			currentTabIFrameEl.contentWindow.detail(row);//调用当前显示的标签页的显示详情方法
		}

		function buyBond(rowIndex){
			var record = today_deal_grid.getRow(parseInt(rowIndex));
			var data = {vcEntrustDirection:"01"};
			var url = nui.context+"/transaction/invest/interbank_trade/instructIssue.jsp";
			if(record.vcMarketNo == "1"){
				//data["vcBizType"] = "3";
				url = nui.context+"/transaction/invest/sh_block_trade/instructIssue.jsp";
			}if(record.vcMarketNo == "2"){
				url = nui.context+"/transaction/invest/sz_integrated_prot/instructIssue.jsp";
			}
			nui.open({
    			url: url,
    			title: "投资指令/建议", width: 950, height: 550,
    			onload: function () {
			        var iframe = this.getIFrameEl();
			        data["vcStockName"] = record.vcStockName;
					data["vcStockCode"] = record.vcStockCode;
			        iframe.contentWindow.SetData(data);
    			},
    			ondestroy: function (action) {
        			//grid.reload();
    			}
			});	
		}
		
		function sellBond(rowIndex){
			var record = today_deal_grid.getRow(parseInt(rowIndex));
			var data = {vcEntrustDirection:"02"};
			var url = nui.context+"/transaction/invest/interbank_trade/instructIssue.jsp";
			if(record.vcMarketNo == "1"){
				//data["vcBizType"] = "3";
				url = nui.context+"/transaction/invest/sh_block_trade/instructIssue.jsp";
			}if(record.vcMarketNo == "2"){
				url = nui.context+"/transaction/invest/sz_integrated_prot/instructIssue.jsp";
			}
			nui.open({
    			url: url,
    			title: "投资指令/建议", width: 950, height: 550,
    			onload: function () {
			        var iframe = this.getIFrameEl();
			        data["vcCombiCode"] = record.vcCombiName; //组合代码
		    		data["vcStockCode"] = record.vcStockCode;
			        iframe.contentWindow.SetData(data);
    			},
    			ondestroy: function (action) {
        			//grid.reload();
    			}
			});	
		}
		
		function addAttention(rowIndex){
			var record = today_deal_grid.getRow(parseInt(rowIndex));
			nui.ajax({
				url : "com.cjhxfund.ats.sm.comm.MyAttentionInfoManager.addAttentionBond.biz.ext",
				type : 'POST',
				data : {bondParameter:{vcStockInnerCode:record.vcInterCode,vcStockCode:record.vcStockCode,vcStockName:record.vcStockName,vcExchange:record.vcMarketNo}},
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						today_deal_grid.reload();
						//record["isAttention"] = 1;
						//today_deal_grid.updateRow(record);
					}else{
						nui.alert("系统异常","提示");
					}
				}
			});
		}
		
		function moveAttention(rowIndex){
			var record = today_deal_grid.getRow(parseInt(rowIndex));
			var json = [{vcStockInnerCode:record.vcInterCode,vcStockCode:record.vcStockCode,vcStockName:record.vcStockName,vcExchange:record.vcMarketNo}];
			nui.ajax({
				url : "com.cjhxfund.ats.sm.comm.MyAttentionInfoManager.cancelAttentionBond.biz.ext",
				type : 'POST',
				data : {bondParameter:json},
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						today_deal_grid.reload();
						//record["isAttention"] = 0;
						//today_deal_grid.updateRow(record);
					}else{
						nui.alert("系统异常","提示");
					}
				}
			});
		
		}
		
		function showHistory(rowIndex){
			var record = today_deal_grid.getRow(parseInt(rowIndex));
			nui.open({
			    url: nui.context+"/transaction/invest/tbond_quote/historyDeal.jsp",
			    title: "成交历史", width: 600, height: 400,
			    onload: function () {
			        var iframe = this.getIFrameEl();
			        var data = {vcStockCode:record.vcStockCode,vcMarketNo:record.vcMarketNo};
			        iframe.contentWindow.loadData(data);
			    },
			    ondestroy: function (action) {
			    }
			});
		}
		
		//详情子界面第一次加载时调用
    	function detailLoaded(){
    		var currentTabIFrameEl = tabDetailRole.getTabIFrameEl(tabDetailRole.getActiveTab());//获取当前详情标签
    		if(isSigleSelectChanged == true){
    			currentTabIFrameEl.contentWindow.detail(today_deal_grid.getSelected());
    		}
    	}
		
		function tabload(){
			//var currentTabIFrameEl = tabDetailRole.getTabBodyEl(tabDetailRole.getActiveTab());//获取当前详情标签
			tabDetailRole.setHeight("300px");
		}
		//详情标签切换时触发
		function activechanged(){
    		var currentTabIFrameEl = tabDetailRole.getTabIFrameEl(tabDetailRole.getActiveTab());//获取当前详情标签
    		if(typeof(currentTabIFrameEl) != "undefined"){//切换的标签界面已经加载过
    			if(isSigleSelectChanged == true){//单条选中
    				currentTabIFrameEl.contentWindow.detail(today_deal_grid.getSelected());
    			}else{
    				currentTabIFrameEl.contentWindow.clearDetail();
    			}
    		}
    	}
    	
    	//清除详情时将判断条件“是否单条选中”值置为false，并清除当前详情标签中的信息
		function clearDetail(){
			isSigleSelectChanged = false;
			var currentTabIFrameEl = tabDetailRole.getTabIFrameEl(tabDetailRole.getActiveTab());//获取当前详情标签
			if(typeof(currentTabIFrameEl) != "undefined"){
				currentTabIFrameEl.contentWindow.clearDetail();
			}
		}
    	function renderQuoteSrc(e){
			return nui.getDictText("quoteSource",e.row.srcCode);
		}
		window.parent.search();
    </script>
</body>
</html>