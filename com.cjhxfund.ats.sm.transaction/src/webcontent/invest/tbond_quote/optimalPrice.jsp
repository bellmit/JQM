
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-09-03 10:05:50
  - Description: 最优报价（银行间债券报价）
-->
<head>
	<title>最优报价</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	
		<div id="datagrid_optimal_price" dataField="oprimalPrices" 
            url="com.cjhxfund.ats.sm.transaction.QuotationInfoManager.queryOprimalPrice.biz.ext"
            class="nui-datagrid" style="width:100%;height:302px;"
            pageSize="10"
            showPageInfo="true" multiSelect="true"
            onselectionchanged="selectionChanged"
            allowSortColumn="true"
            sortMode="client"
            enableHotTrack="false"
            sizeList="[10,20,50,100]"
            pagerButtons="#screens_optimal_price">
    		<div property="columns">
	            <div type="checkcolumn"></div>
	            <div name="action" width="195px" headerAlign="center" align="left">操作</div>
	            <div field="vcStockCode" headerAlign="center" width="85px">
	                债券代码
	            </div>
	            <div field="vcStockName" headerAlign="center" width="100px">
	                债券简称
	            </div>
	            <div field="vcLimitLeft" headerAlign="center" width="85px">
	                剩余年限
	            </div>
	            <div field="isPosition" headerAlign="center" align="center" width="85px">
	                是否有持仓
	            </div>
	            <div field="rtTime" headerAlign="center" width="140px" dateFormat="yyyy-MM-dd HH:mm:ss">
	                更新时间
	            </div>
	            <div field="rtYield" headerAlign="center" align="right" width="85px">
	                成交价
	            </div>
	            <div field="rtBsize" headerAlign="center" align="right" width="110px">
	                买量
	            </div>
	            <div field="rtBidyield" headerAlign="center" align="right" width="85px">
	                买入
	            </div>
	            <div field="rtAskyield" headerAlign="center" align="right" width="85px">
	                卖出
	            </div>
	            <div field="rtAsize" headerAlign="center" align="right" width="110px">
	                卖量
	            </div>
	            <div field="enCbValueIncmRate" headerAlign="center" align="right" width="85px">
	                中债估值
	            </div>
	            <div field="buyMinusValuation" headerAlign="center" align="right" width="85px">
	                买入-估值
	            </div>
	            <div field="valuationMinusSell" headerAlign="center" align="right" width="85px">
	                估值-卖出
	            </div>
	            <div field="vcBondIssueAppraise" headerAlign="center" align="center" width="85px">
	                主/债
	            </div>
	            <div field="lRatingForecast" headerAlign="center" align="center" width="85px">
	                评级展望
	            </div>
	            <div field="srcCode" headerAlign="center" align="center" width="85px" renderer="renderQuoteSrc">
	                机构
	  			</div>
	    	</div>
	    	<div id="screens_optimal_price">
		        <span class="separator"></span>
		        <div id="isPosition" class="nui-checkbox" readOnly="false" text="只显示有持仓债券" value="0" trueValue="1" falseValue="0" oncheckedchanged="checkChangeed"></div>
		        <div id="myAttention" class="nui-checkbox" readOnly="false" text="只显示关注债券" value="0" trueValue="1" falseValue="0" oncheckedchanged="checkChangeed"></div>
		    </div> 
		</div>
		
		<%-- 详情开始... --%>
	   	<div id="tabs_tbond_quote_detail" class="nui-tabs" activeIndex="0" ontabload="tabload" onactivechanged="activechanged">
	   		<div title="持仓信息" url="<%= request.getContextPath() %>/transaction/invest/tbond_quote/positionInfo.jsp"></div>
	   		<div title="债券基本信息" url="<%= request.getContextPath() %>/transaction/invest/tbond_quote/tBondBaseInfo.jsp"></div>
	   		<div title="信用评级" url="<%= request.getContextPath() %>/transaction/invest/tbond_quote/stockCreditRate.jsp"></div>
	   		<div title="质押信息" url="<%= request.getContextPath() %>/transaction/invest/tbond_quote/mortgageInfo.jsp"></div>
	   		<div name="sysMarket" title="竞价系统行情" visible="false" url="<%= request.getContextPath() %>/transaction/invest/tbond_quote/askBidSysMarket.jsp"></div>
	   	</div>
	  <%-- 详情结束... --%>

	<script type="text/javascript">
		nui.parse();
		var optimal_price_grid = nui.get("datagrid_optimal_price");
		var tabDetailRole = nui.get("#tabs_tbond_quote_detail");//获取详情标签列表
		var isSigleSelectChanged = false;
		function search(json){
			optimal_price_grid.load(json);//grid查询
		}
		
		function checkChangeed(){
			window.parent.search();
		}
		
		optimal_price_grid.on("drawcell", function (e) {
	        var record = e.record,
	    	 	column = e.column,
	    		field = e.field,
	    		value = e.value;
	    	if(field =="isPosition"){
	    		e.cellHtml = (value == 1)?"是":"否";
	    	}
	        //计算买入减估值
	        if (field == "buyMinusValuation") {
	        	var enCbValueIncmRate =  record.enCbValueIncmRate;
	        	var rtBidyield = record.rtBidyield;
	            if(enCbValueIncmRate != null && !isNaN(parseFloat(rtBidyield))){
	        		e.cellHtml = accSubtr(parseFloat(rtBidyield),parseFloat(enCbValueIncmRate));
	        	}else{
	        		e.cellHtml = "--";
	        	}
	        }
	        //计算估值减卖出
			if (field == "valuationMinusSell") {
				var enCbValueIncmRate =  record.enCbValueIncmRate;
	        	var rtAskyield = record.rtAskyield;
	        	if(enCbValueIncmRate != null && !isNaN(parseFloat(rtAskyield))){
	        		e.cellHtml = accSubtr(parseFloat(enCbValueIncmRate),parseFloat(rtAskyield));
	        	}else{
	        		e.cellHtml = "--";
	        	}
	        }
			
	        //action列，超连接操作按钮
	        if (column.name == "action") {
	            e.cellStyle = "text-align:center";
	            var operatColumn = '';
	            if(record.isBuyOperate =="1"){
	            	operatColumn += '<a style="color:#00CCFF" href="javascript:buyBond(\'' + optimal_price_grid.indexOf(record) + '\')">买入</a>&nbsp; ';
	            }
	            if(record.isPosition == "1" && record.isSellOperate=="1"){
	            	operatColumn += '<a style="color:#00CCFF" href="javascript:sellBond(\'' + optimal_price_grid.indexOf(record) + '\')">卖出</a>&nbsp; ';
	            }
	            if(record.isAttention == "1"){
	            	operatColumn += '<a style="color:#00CCFF" href="javascript:moveAttention(\'' + optimal_price_grid.indexOf(record) + '\')">取消关注</a>&nbsp; ';
	            }else{
	            	operatColumn += '<a style="color:#00CCFF" href="javascript:addAttention(\'' + optimal_price_grid.indexOf(record) + '\')">关注</a>&nbsp; ';
	        	}
	        	operatColumn += '<a style="color:#00CCFF" href="javascript:showHistory(\'' + optimal_price_grid.indexOf(record) + '\')">历史成交</a>';
	        	e.cellHtml = operatColumn;
	        }
	    });

	    function accSubtr(arg1,arg2){
			var r1,r2,m,n;
			try{r1=arg1.toString().split(".")[1].length;}catch(e){r1=0;}
			try{r2=arg2.toString().split(".")[1].length;}catch(e){r2=0;}
			m=Math.pow(10,Math.max(r1,r2));
			//动态控制精度长度
			n=(r1>=r2)?r1:r2;
			return ((arg1*m-arg2*m)/m).toFixed(n);
		} 
	    
		//债券买入
		function buyBond(rowIndex){
			var record = optimal_price_grid.getRow(parseInt(rowIndex));
			var json = {};
			var url = nui.context+"/transaction/invest/interbank_trade/instructIssue.jsp";
			if(record.vcMarketNo == "1"){
				//json["vcBizType"] = "3";
				url = nui.context+"/transaction/invest/sh_block_trade/instructIssue.jsp";
			}if(record.vcMarketNo == "2"){
				url = nui.context+"/transaction/invest/sz_integrated_prot/instructIssue.jsp";
			}
			nui.open({
    			url: url,
    			title: "投资指令/建议", width: 950, height: 550,
    			onload: function () {
			        var iframe = this.getIFrameEl();
			        json["vcEntrustDirection"] = "01";//添加指令/建议下达的委托方向字段
			        json["vcStockName"] = record.vcStockName;
					json["vcStockCode"] = record.vcStockCode;
			        iframe.contentWindow.SetData(json);
    			},
    			ondestroy: function (action) {
    			}
			});	
		}
		
		//债券卖出
		function sellBond(rowIndex){
			var record = optimal_price_grid.getRow(parseInt(rowIndex));
			var json = {};
			var url = nui.context+"/transaction/invest/interbank_trade/instructIssue.jsp";
			if(record.vcMarketNo == "1"){
				//json["vcBizType"] = "3";
				url = nui.context+"/transaction/invest/sh_block_trade/instructIssue.jsp";
			}if(record.vcMarketNo == "2"){
				url = nui.context+"/transaction/invest/sz_integrated_prot/instructIssue.jsp";
			}
			nui.open({
    			url: url,
    			title: "投资指令/建议", width: 950, height: 550,
    			onload: function () {
			        var iframe = this.getIFrameEl();
			        json["vcEntrustDirection"] = "02";//添加指令/建议下达的委托方向字段
		    		json["vcCombiCode"] = record.vcCombiName; //组合代码
		    		json["vcStockCode"] = record.vcStockCode;
			        iframe.contentWindow.SetData(json);
    			},
    			ondestroy: function (action) {
    			}
			});	
		}
		
		function addAttention(rowIndex){
			var record = optimal_price_grid.getRow(parseInt(rowIndex));
			nui.ajax({
				url : "com.cjhxfund.ats.sm.comm.MyAttentionInfoManager.addAttentionBond.biz.ext",
				type : 'POST',
				data : {bondParameter:{vcStockInnerCode:record.vcInterCode,vcStockCode:record.vcStockCode,vcStockName:record.vcStockName,vcExchange:record.vcMarketNo}},
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						optimal_price_grid.reload();
						//record["isAttention"] = 1;
						//optimal_price_grid.updateRow(record);
					}else{
						nui.alert("系统异常","提示");
					}
				}
			});
		}
		
		function moveAttention(rowIndex){
			var record = optimal_price_grid.getRow(parseInt(rowIndex));
			var json = [{vcStockInnerCode:record.vcInterCode,vcStockCode:record.vcStockCode,vcStockName:record.vcStockName,vcExchange:record.vcMarketNo}];
			nui.ajax({
				url : "com.cjhxfund.ats.sm.comm.MyAttentionInfoManager.cancelAttentionBond.biz.ext",
				type : 'POST',
				data :  {bondParameter:json},
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						optimal_price_grid.reload();
						//record["isAttention"] = 0;
						//optimal_price_grid.updateRow(record);
					}else{
						nui.alert("系统异常","提示");
					}
				}
			});
		}
		
		function showHistory(rowIndex){
			var record = optimal_price_grid.getRow(parseInt(rowIndex));
			nui.open({
			    url: nui.context+"/transaction/invest/tbond_quote/historyDeal.jsp",
			    title: "成交历史", width: 640, height: 360,
			    onload: function () {
			        var iframe = this.getIFrameEl();
			        var data = {vcStockCode:record.vcStockCode,vcMarketNo:record.vcMarketNo};
			        iframe.contentWindow.loadData(data);
			    },
			    ondestroy: function (action) {
			    }
			});
		}
    	
    	function selectionChanged(){
			var rows = optimal_price_grid.getSelecteds();
			var marketTab = tabDetailRole.getTab("sysMarket");
			if(rows.length == 1){
				var row = optimal_price_grid.getSelected();
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
		//显示当前详情界面信息，并将单条选中判断条件值置为true
		function showDetail(row){
			isSigleSelectChanged = true;
			var currentTabIFrameEl = tabDetailRole.getTabIFrameEl(tabDetailRole.getActiveTab());//获取当前详情标签
			currentTabIFrameEl.contentWindow.detail(row);//调用当前显示的标签页的显示详情方法
		}
		
		//详情子界面第一次加载时调用
    	function detailLoaded(){
    		var currentTabIFrameEl = tabDetailRole.getTabIFrameEl(tabDetailRole.getActiveTab());//获取当前详情标签
    		if(isSigleSelectChanged == true){
    			currentTabIFrameEl.contentWindow.detail(optimal_price_grid.getSelected());
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
    				currentTabIFrameEl.contentWindow.detail(optimal_price_grid.getSelected());
    			}else{
    				clearDetail();
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