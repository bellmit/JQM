<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>

<!-- 
  - Author(s): 创金合信
  - Date: 2016-09-08 15:57:08
  - Description:chendi
-->
<head>
<title>资金交收跟踪管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/css/instruct.css"/>
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script>
</head>
<body style="height:100%; width:100%; overflow:hidden; margin:0;padding:0;">
	<div class="search-condition">
		<div id="form_o32_deal_data" class="nui-form" align="center">
	   		<div class="list">
	   			<div id="" class="nui-form" align="center">
	   				<table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="98%" align="left">
	                        	<span style="width:55px;">产品名称:</span>
	                        	<div name="fundCodeName" class="nui-combobox" pinyinField="vcProductCode" id="fundCodeName"
		                             textField="vcProductName" valueField="vcProductCode"
		                             searchField="productCode"
		                             url="com.cjhxfund.commonUtil.ProductManager.queryProductListByUserId.biz.ext"
		                             showNullItem="false"
		                             allowInput="true"
		                             emptyText="产品代码或产品名称..."
		                             nullItemText="产品代码或产品名称..."
		                             valueFromSelect="true"
		                             showClose="true"
		                             oncloseclick="onCloseClick"
		                             style="width:160px"
		                             onvaluechanged="selectFund"
		                             popupWidth="300px">
		                            <div property="columns">
		                                <div header="产品代码" field="vcProductCode" width="40px"></div>
		                                <div header="产品名称" field="vcProductName"></div>
		                            </div>
		                        </div>
								<span style="width:55px;padding-left:20px;">委托方向:</span>
								<div name="condition/cEntrustDirection" class="nui-dictcombobox" id="cEntrustDirection" 
									valueField="dictID" 
									textField="dictName" 
									dictTypeId="entrustDirection"
									multiSelect="true"
		                            allowInput="false" 
		                            showNullItem="true" 
		                            emptyText="全部..." 
		                            nullItemText="请选择..." 
		                            showClose="true" 
		                            oncloseclick="onCloseClick"
		                            style="width:160px;"
		                            popupWidth="200px">
	                            </div>
		                        <span style="width:55px;padding-left:20px;">债券代码:</span>
	                           	<div name="condition/stockCode" class="mini-autocomplete" id="vcStockCode"
	                                textField="stockCode" valueField="stockCode"
	                                searchField="stockCode"
	                                url="com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.queryBondCode.biz.ext"
	                                popupEmptyText="全部"
	                                nullItemText="全部"
	                                loadingText="加载中"
	                                valueFromSelect="false"
	                                dataField="bondList"
	                                multiSelect="false"
	                                showClose="true"
	                                oncloseclick="onCloseClick"
	                                style="width:160px"
	                                popupWidth="300px">
	                            	<div property="columns">
	                                	<div header="债券代码" field="stockCode" width="40px"></div>
	                                	<div header="债券名称" field="stockName"></div>
	                            	</div>
								</div>&nbsp;&nbsp;
	                         	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="inquiry()"/>&nbsp;&nbsp;&nbsp;
		                        <a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">重置</a>
	                  		</td>
	                  	</tr>
	                  	<tr>
							<td class="form_label" width="20%" align="left">
								<span align="left">交易市场:</span>
								<div name="condition/market" class="nui-dictcombobox" id="vcMarket" 
									valueField="dictID" 
									textField="dictName" 
									dictTypeId="tradePlace"
									multiSelect="true"
		                            allowInput="false" 
		                            showNullItem="true" 
		                            emptyText="全部..." 
		                            nullItemText="请选择..." 
		                            showClose="true" 
		                            oncloseclick="onCloseClick"
		                            style="width:160px;">
	                            </div>
	                            <span style="width:55px;padding-left:20px;">业务类别:</span>
								<div name="condition/bizType" class="nui-dictcombobox" id="vcBizType" 
									valueField="dictID" 
									textField="dictName" 
									dictTypeId="bizTypeAll"
									multiSelect="true"
		                            allowInput="false" 
		                            showNullItem="true" 
		                            emptyText="全部..." 
		                            nullItemText="请选择..." 
		                            showClose="true" 
		                            oncloseclick="onCloseClick"
		                            style="width:160px;"
									popupWidth="200px">
		                        </div>
		                        <span style="width:55px;padding-left:20px;">托管机构:</span>
	                        	<div name="condition/vcDepository"  id="vcDepository"  class="nui-dictcombobox"
	 								valueField="dictID" 
	 								textField="dictName" 
	 								dictTypeId="CF_JY_DJTGCS"
	 								multiSelect="true"
	 								showNullItem="true" 
	 								emptyText="全部..." 
	 								nullItemText="请选择..." 
	 								showClose="true" 
	 								oncloseclick="onCloseClick"
	 								style="width:160px"
	                                popupWidth="200px">
 								</div>&nbsp;&nbsp;
			   					<ul id="popupMenu" class="mini-menu" style="display:none;width:250px;"></ul>
		                        <a class="nui-menubutton " plain="false" menu="#popupMenu"
		                           id="searchCond"
		                           name="searchCond"
		                           data-options='{formId:"form_o32_deal_data"}'
		                           iconCls="icon-add">保存查询条件</a>
							</td>
	                    </tr>
					</table>
	   			</div>
	   		</div>
   		</div>
   	</div>
   	<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	    <table style="width:100%;">
	        <tr>
	            <td style="width:50%;">
	                <!-- <a class='nui-button' plain='false' iconCls="icon-ok" onclick="matchInstruct()">查看前台成交查询SQL</a> -->
	            </td>
	            <td style="width:50%;" align="right">
	            	<%-- 点击“刷新”按钮后重启自动刷新功能（若之前自动刷新功能设置为不自动刷新关闭时） --%>
	                <a class='nui-button' plain='false' iconCls="icon-reload" onclick="autoRefreshFun()">刷新</a>
	                <div id="autoRefresh" class="nui-combobox" style="width:90px;" 
	                    value="180" showNullItem="false" allowInput="false"
	                    data="[
	                    { id: 0, text: '不自动刷新' },
					    { id: 15, text: '每15秒刷新' },
					    { id: 30, text: '每30秒刷新' },
						{ id: 60, text: '每1分刷新' },
						{ id: 120, text: '每2分刷新' },
						{ id: 180, text: '每3分刷新' },
						{ id: 300, text: '每5分刷新' },
						{ id: 600, text: '每10分刷新' },
						{ id: 1200, text: '每20分刷新' },
						{ id: 1800, text: '每30分刷新' }]">
					</div>
	            </td>
	        </tr>
	    </table>
    </div>
	<div class="nui-fit" style="width:100%; height:100%;">
	    <div id="datagrid_o32_deal_data" class="nui-datagrid" style="width:100%;height:100%;" dataField="returnData"
	         url="com.cjhxfund.ats.sm.comm.FundSetmtTraceManager.queryFundSetmtTrace.biz.ext"  
	         idField="id" 
	         allowResize="true"  
	         showPageInfo="true"
	         allowCellSelect="true"
	 		 enterNextCell="true"
	 		 enableHotTrack="true"
           	 allowHeaderWrap="true"
	         multiSelect="true"
	         editNextOnEnterKey="true"
	         sizeList="[20,30,50,100]" 
	         pageSize="20" 
	         pagerButtons="#prompt_todays">
	        <div property="columns">
	            <div type="indexcolumn" ></div>
	            <div field="traceId" visible="false"></div>
	            <div field="lSetmtDate" width="80" headerAlign="center" align="left" allowSort="true" renderer="setmtDateStrToDate">交收日期</div>
	            <div field="vcProductName" width="120" headerAlign="center"  align="left" allowSort="true">产品名称</div>
	            <div field="vcAssetName" width="120" renderer="onGenderRenderer" align="left" headerAlign="center">资产单元名称</div>
	            <div field="vcBizType" width="150" allowSort="true" headerAlign="center" align="left" renderer="renderBizType">业务类别</div>
	            <div field="cEntrustDirection" width="90" allowSort="true" headerAlign="center" align="left" renderer="renderCEntrustDirection" >委托方向</div>
	            <div field="enDealAmount" visible="false" width="100" headerAlign="center" allowSort="true" numberFormat="#,0.00" align="right">成交金额(元)</div>
	            <div field="enSetmtAmount" width="100" allowSort="true" numberFormat="#,0.00" decimalPlaces="2" dataType="float" headerAlign="center" align="right">交收金额(元)</div>
	            <div field="vcFsDealId" width="130" headerAlign="center"  align="right" allowSort="true">成交编号</div>
	            <div field="vcClordId" width="130" headerAlign="center"  align="right" allowSort="true">第三方指令/建议编号</div>
	            <div field="vcStockCode" width="80" headerAlign="center" align="right"  allowSort="true" decimalPlaces="2" >债券代码</div>
	            <div field="vcStockName" width="100" headerAlign="center" align="left" allowSort="true">债券名称</div>
	            <div field="vcMarket" width="90" allowSort="true" headerAlign="center" align="left" renderer="renderVcMarket" >交易市场</div>
	            <div field="lDealDate" width="80" headerAlign="center" align="left" allowSort="true" renderer="dealDateStrToDate">交易日期</div>
	            <div field="lDealQuantity" width="80" headerAlign="center" align="left" allowSort="true" numberFormat="n0" >发生数量</div>
	            <div field="vcCounterpartyName" width="150" allowSort="true" decimalPlaces="2" headerAlign="center" align="left">交易对手</div>
	            <div field="vcDepository" width="150" allowSort="true" headerAlign="center" align="left" renderer="renderVcDepository">登记托管机构</div>
	            <div field="vcDataSource" width="90" headerAlign="center" align="left" allowSort="true">数据来源</div>
	            <div field="cBusinClass" visible="false" width="80" headerAlign="center" align="left" allowSort="true">资金交收业务类别</div>
	        </div>
	    </div>
	</div>

	<script type="text/javascript">
		nui.parse();
	    var grid = nui.get("datagrid_o32_deal_data");
		
		//自动刷新功能处理
	    var autoRefreshReturnVal;//自动刷新定时器返回值（使用该值关闭之前的定时器）
	    var autoRefreshValOld;//历史自动刷新时间
	    function autoRefreshFun(){
	    	inquiry();//同时刷新查询列表数据
	    	var autoRefreshVal = nui.get("autoRefresh").getValue();//获取最新自动刷新时间
	    	//若最新获取的自动刷新时间与历史自动刷新时间不等，则关闭之前的定时器，以新的自动刷新时间新建定时器，并将新值赋予历史自动刷新时间变量
	    	if(autoRefreshVal!=autoRefreshValOld){
	    		autoRefreshValOld = autoRefreshVal;//将新值赋予历史自动刷新时间变量
	    		clearInterval(autoRefreshReturnVal);//关闭之前的定时器
	    		if(autoRefreshValOld!="0"){
	    			autoRefreshReturnVal = setInterval("autoRefreshFun()", eval(autoRefreshValOld)*1000);//以新的自动刷新时间新建定时器
	    		}
	    	}
	    }
	    autoRefreshReturnVal = self.setInterval("autoRefreshFun()",180000);//设置自动刷新时间默认3分钟
	    //手工置交收
	   	function setmtManually(){
	   		
		}
		function inquiry(){
			var conditionForm = new nui.Form("#form_o32_deal_data");
			var optimal_price_grid = nui.get("datagrid_o32_deal_data");
			var json = conditionForm.getData(false, false);
			//下拉框多选处理
			json["condition/cEntrustDirection"] = splitString(nui.get("cEntrustDirection").getValue());
			json["condition/productCode"] = splitString(nui.get("fundCodeName").getValue());
			json["condition/market"] = splitString(nui.get("vcMarket").getValue());
			json["condition/vcDepository"] = splitString(nui.get("vcDepository").getValue());
			//查询类型赋值
			json["condition/queryType"] = "O32_DATA";
			optimal_price_grid.load(json);
		}
		//重置
		function reset(){
			var form = new nui.Form("#form_o32_deal_data");//将普通form转为nui的form
			form.reset();
		}
		//时间显示格式转换
		function dealDateStrToDate(e){
			if(e.value!=null){
				return nui.formatDate(DateUtil.numStrToDate(e.row.lDealDate.toString()),'yyyy-MM-dd');
			}
		}
		function setmtDateStrToDate(e){
			if(e.value!=null){
				return nui.formatDate(DateUtil.numStrToDate(e.row.lSetmtDate.toString()),'yyyy-MM-dd');
			}
		}
		//输入框默认显示
		window.onload=function(){
			var conditionForm = new nui.Form("#form_o32_deal_data");
			var optimal_price_grid = nui.get("datagrid_o32_deal_data");
  			$("#vcBizType > span > input").attr("placeholder","全部...");
			$("#vcStockCode > span > input").attr("placeholder","请输入...");
			var form_o32 = conditionForm.getData(false, false);
			//查询类型赋值
			form_o32["condition/queryType"] = "O32_DATA";
			optimal_price_grid.load(form_o32);
		}
		//业务类别字典  
		function renderBizType(e){
			return nui.getDictText("bizTypeAll",e.row.vcBizType);
		}
		//委托方向字典
		function renderCEntrustDirection(e){
			return nui.getDictText("entrustDirection",e.row.cEntrustDirection);
		}
		//交易市场字典项
		function renderVcMarket(e){
			return nui.getDictText("tradePlace",e.row.vcMarket);
		}
		//登记托管机构字典项
		function renderVcDepository(e){
			return nui.getDictText("CF_JY_DJTGCS",e.row.vcDepository);
		}
		//页面X的删除功能
		function onCloseClick(e) {
	    	var obj = e.sender;
		    obj.setText("");
		    obj.setValue("");
		}
		//处理下拉框多选的情况：给多选字符加上单引号
		function splitString(data){
			var mulString = null;
			if(data != null && data != ""){
				var strs= data.split(",");
	    		if(strs.length>0){
	    			for(var i=0; i<strs.length; i++ ){ 
							if(i == 0){
								mulString = "'"+strs[i]+"'";
							}else{
								mulString += ",'"+strs[i]+"'";
							}
						} 
	    		}
			}
			return mulString;
	    }
    
	</script>
</body>
</html>