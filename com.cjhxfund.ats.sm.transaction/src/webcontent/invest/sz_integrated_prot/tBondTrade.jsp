
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 吴艳飞
  - Date: 2016-09-03 14:04:50
  - Description: 上交所固收平台
-->
<head>
	<title>深圳综合协议平台</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script>
  <style type="text/css">
    	.mini-buttonedit-border{
    		padding-right:1px;
    	}
    </style>
</head>
<body>
	<!-- 查询条件开始 -->
	<div class="search-condition">
		<div class="list">
			<div id="bank_between_instruct_condition" class="nui-form" style="padding:2px;height:10%;" align="left">
				<input class="nui-hidden"  name="vcMarket" value="SZ" id="vcMarket"/>
				<input class="nui-hidden"  name="vcBusinType" value="4" id="vcBusinType"/>
				<input class="nui-hidden"  name="businClass" value="E" id="businClass"/>
				<input class="nui-hidden"  name="vcInvestType" value="1" id="vcInvestType"/>
				<input class="nui-hidden"  name="vcMarketNo" value="2" id="vcMarketNo"/>
				<table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
					<tr>
						<td width="60px" align="right">产品名称:</td>
						<td align="left">
                        <div name="vcFundCode" class="nui-combobox" pinyinField="ID" id="vcFundCode"
                            	textField="TEXT" valueField="ID"
								url="com.cjhxfund.ats.sm.transaction.TransactionBizManager.queryHavePermissionProduct.biz.ext"
								showNullItem="false"
								allowInput="true" 
								emptyText="请输入产品代码或产品名称..."
								nullItemText="请输入产品代码或产品名称..."
								valueFromSelect="true"
								showClose="true"
								style="width:95%;"
								oncloseclick="onCloseClick"
								popupWidth="300">
								<div property="columns">
	                                <div header="产品代码" field="ID" width="40px"></div>
	                                <div header="产品名称" field="TEXT"></div>
	                            </div>
                            </div>
						<td width="60px" align="right">债券代码:</td>
						<td align="left">
							<div name="vcStockCode" class="nui-autocomplete" id="vcStockCode"
	                                 textField="stockCode" valueField="stockCode"
	                                 searchField="stockCode"
	                                 url="com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.querySZBondCode.biz.ext"
	                                 allowInput="true"
	                                 emptyText="请选择..."
	                                 nullItemText="请选择..."
	                                 valueFromSelect="false"
	                                 dataField="bondList"
	                                 multiSelect="false"
	                                 style="width:95%;"
	                                 popupWidth="300">
	                           		<div property="columns">
	                                    <div header="债券代码" field="stockCode" width="40px"></div>
	                                    <div header="债券名称" field="stockName"></div>
                                	</div>
                    		</div>
						</td>
						<td width="60px" align="right">债项评级:</td>
						<td align="left">
							<input class="nui-dictcombobox"
		                                   id="vcBondAppraise"
		                                   name="vcBondAppraise"
		                                   valueField="dictName"
		                                   textField="dictName"
		                                   multiSelect="true"
		                                   dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING"
		                                   emptyText="全部"
		                                   showClose="true"
		                                   allowInput="false"
		                                   oncloseclick="onCloseClick"
		                                   style="width:95%"/>
						</td>
						<td width="100px" align="right">剩余期限(年):</td>
						<td align="left">
							<input class="nui-textbox" name="minLimiteLeft"  vtype="float"  onvalidation="numberCheck" requiredErrorText="必须是整数" style="width:45%;"/>
							<span style="width:5%;">-</span>
							<input class="nui-textbox" name="maxLimiteLeft"  vtype="float"  onvalidation="numberCheck" requiredErrorText="必须是整数" style="width:45%;" />
						</td>
					</tr>
					<tr>
                        <td align="left" colspan="8">
                            <ul id="popupMenu" class="mini-menu" style="display:none;width:250px;"></ul>
                            <input class="nui-button" text="查询" iconCls="icon-search" onclick="search()"/>
                            <a class="nui-button" iconCls="icon-reset" onclick="reset()">重置</a>
                            <a class="nui-menubutton " menu="#popupMenu"
                               id="searchCond"
                               name="searchCond"
                               data-options='{formId:"bank_between_instruct_condition"}'
                               iconCls="icon-add">保存查询条件</a>
                        </td>
                    </tr>
				</table>
			</div>
		</div>
	</div>
	<%-- 查询条件结束!!! --%>
	
	<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
		<table style="width:100%;">
			<tr>
				<td style="width:100%;">
					<a class="nui-button" iconCls="icon-goto" onclick="clicksearch()">下达投资指令/建议</a>
				</td>
			</tr>
		</table>
	</div>
    
	<%-- 列表开始... --%>
	<div id="datagrid_tbond_trade" 
			dataField="dealPosition"
			url="com.cjhxfund.ats.sm.transaction.TransactionBizManager.queryPositionsBonds.biz.ext" 
			showTreeLines="true" multiSelect="true"
			class="nui-datagrid" 
			style="width:100%;height:285px;"
			idField="id"
			pageSize="10"
			sizeList="[10,30,50,100]" 
			showPageInfo="true"
			multiSelect="true"
			onselectionchanged="onSelectionChanged"
			allowSortColumn="true"
			frozenStartColumn="0"
			frozenEndColumn="2"
			sortMode="client"
			enableHotTrack="false">
		<div property="columns" >
			<div name="action" width="100" headerAlign="center" >操作</div>
			<div field="vcFundName"  headerAlign="center"  align="left"  width="85px">
				产品名称
			</div>
			<div field="vcCombiName"  headerAlign="center"  align="left"  width="85px">
				组合名称
			</div>
			<div field="vcStockCode" headerAlign="center" align="left" width="85px">
				债券代码
			</div>
			<div field="vcStockName" headerAlign="center" align="left" width="85px">
				债券简称
			</div>
			<div field="lCurrentAmount" headerAlign="center" align="right" width="85px" allowSort="true" numberFormat="n0" >
				持仓数量
			</div>
			<div field="vcAvailablequantityT0" headerAlign="center" align="right" width="85px"  numberFormat="n0" >
				T+0可卖数量
			</div>
			<div field="vcAvailablequantityT1" headerAlign="center" align="right" width="85px"  numberFormat="n0" >
				T+1可卖数量
			</div>
			<div field="cnSell" headerAlign="center" align="center" numberFormat="n0" renderer="cnSellRD"  >
				锁定数量
			</div>
			<div field="vcBondAppraise" headerAlign="center" align="center" width="85px" allowSort="true" renderer="renderBondAppraise">
				债项评级
			</div>
			<div field="vcIssueAppraise" headerAlign="center" align="center" width="85px" allowSort="true" renderer="renderIssueAppraise">
				主体评级
			</div>
			<div field="lLimiteLeft" headerAlign="center" align="center" width="85px" allowSort="true">
				剩余期限
			</div>
			<div field="enBondAsset" headerAlign="center" align="right" width="85px" numberFormat="#,0.00" >
				市值(元)
			</div>
			<div field="positionRatio" headerAlign="center" align="center" width="85px">
				市值占净值比(%)
			</div>
		</div>
	</div>
	<%-- 列表结束... --%>
    
	<%-- 详情开始... --%>
	<div class="nui-fit">
		<div id="tabs_tbond_deal_detail" class="nui-tabs" activeIndex="0" height="100%">
			<div title="债券基本信息">
				<table id="table" style="width:98%; table-layout:fixed;margin: 0xp;padding: 0px;"border="0" class="nui-form-table">	
					<tr>
						<td style="width:90px; padding: 5px 5px 5px 0px;" align="right">债券简称：</td>
		                <td style="width:10%;">
		                	<input name="vcStockName" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		                <td style="width:100px; padding: 5px 5px 5px 0px;" align="right">债券类型：</td>
		                <td style="width:10%;">
		                	<input name="vcStocktypeName" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		                <td style="width:120px; padding: 5px 5px 5px 5px;" align="right">发行量（亿）：</td>
		                <td style="width:10%;">
		                	<input name="enIssueBalance" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		                <td style="width:110px; padding: 5px 5px 5px 5px" align="right">剩余年限：</td>
		                <td style="width:10%;">
		                	<input name="lLimiteLeft" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		        	</tr>
		         	<tr>
		         		<td style="padding: 5px 5px 5px 5px;" align="right">到期日：</td>
		                <td style="width:10%;">
		                	<input name="lEndincalDate" class="nui-textbox" format="yyyy-MM-dd" readonly="true" enabled="false"/>
		                </td>
		                <td style="padding: 5px 5px 5px 5px;" align="right">债项评级：</td>
		                <td>
		                	<input name="vcBondAppraise" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="creditRating" readonly="true" enabled="false"/>
		                </td>
		         		<td style="padding: 5px 5px 5px 5px;" align="right">主体评级：</td>
		                <td>
		                	<input name="vcIssueAppraise" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="issuerRating" readonly="true" enabled="false"/>
		                </td>
		                <td style="padding: 5px 5px 5px 5px;" align="right">评级机构：</td>
		                <td>
		                	<input name="vcIssueAppraiseOrgan" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="outRatingOrgan" readonly="true" enabled="false"/>
		                </td>
		            </tr>
		        	<tr>
		        		<td style="padding: 5px 5px 5px 5px;" align="right">评级展望：</td>
		                <td>
		                	<input name="lRatingForecast" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="ratingOutlook" readonly="true" enabled="false"/>
		                </td>
		                <td style="padding: 5px 5px 5px 5px;" align="right">票面利率：</td>
		                <td>
		                	<input name="enFaceRate" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		        		<td style="padding: 5px 5px 5px 5px;" align="right">利率类型：</td>
		                <td>
		                	<input name="cInterestType" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="rateType" readonly="true" enabled="false"/>
		                </td>
		        		
		        		<td style="padding: 5px 5px 5px 5px;" align="right">票息品种：</td>
		                <td>
		                	<input name="cPayInterestType" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="payInterestType" readonly="true" enabled="false"/>
		                </td>
		            </tr>
					                
					<tr>
						<td style="padding: 5px 5px 5px 5px;" align="right">下一付息日：</td>
		                <td>
		                	<input name="lNextPayintDate" class="nui-textbox" format="yyyy-MM-dd" readonly="true" enabled="false"/>
		                </td>
						<td style="padding: 5px 5px 5px 5px;" align="right">距下一付息日（天）：</td>
		                <td>
		                	<input name="lNextPayintDays" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		                <td style="padding: 5px 5px 5px 5px;" align="right">付息频率利率说明：</td>
		                <td>
		                	<input name="vcInterestRateDesc" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		                <td style="padding: 5px 5px 5px 5px;" align="right">下一行权日：</td>
		                <td>
		                	<input name="lNextExerciseDate" class="nui-textbox" format="yyyy-MM-dd" readonly="true" enabled="false"/>
		                </td>
		            </tr>
		            <tr>
		            	<td style="padding: 5px 5px 5px 5px;" align="right">行权特殊条款：</td>
		                <td>
		                	<input name="vcSpecialText" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		                 <td style="padding: 5px 5px 5px 5px;" align="right">是否跨市场：</td>
		                <td>
		                	<input name="lIsStepMarket" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="COF_YESORNO" readonly="true" enabled="false"/>
		                </td>
		                <td style="padding: 5px 5px 5px 5px;" align="right">交易所折算比例：</td>
		                <td>
		                	<input name="enExchangeConverRatio" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		                <td style="padding: 5px 5px 5px 5px;" align="right">中债估值收益率：</td>
		                <td>
		                	<input name="enCbValueIncmRate" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		            </tr>
		            <tr>
		            	<td style="padding: 5px 5px 5px 5px;" align="right">中债估值净价：</td>
		                <td>
		                	<input name="enCbValueNetValue" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		                <td style="padding: 5px 5px 5px 5px;" align="right">中债估值全价：</td>
		                <td>
		                	<input name="enCbValueAllValue" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		                <td style="padding: 5px 5px 5px 5px;" align="right">托管机构：</td>
		                <td>
		                	<input name="vcPaymentPlace" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="CF_JY_DJTGCS" readonly="true" enabled="false"/>
		                </td>
		                <td style="padding: 5px 5px 5px 5px;" align="right">发行人：</td>
		                <td>
		                	<input name="vcIssuerNameFull" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		            </tr>
		            <tr>
		            	<td style="padding: 5px 5px 5px 5px;" align="right">企业性质：</td>
		                <td>
		                	<input name="vcIssueProperty" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="ATS_FM_ISSUE_PROPERTY" readonly="true" enabled="false"/>
		                </td>
		            	<td style="padding: 5px 5px 5px 5px;" align="right">摘牌日：</td>
		                <td>
		                	<input name="lDelistingDate" class="nui-textbox" format="yyyy-MM-dd" readonly="true" enabled="false"/>
		                </td>
		                <td style="padding: 5px 5px 5px 5px;" align="right">行业分类：</td>
		                <td>
		                	<input name="vcIndustry" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		                <td style="padding: 5px 5px 5px 5px;" align="right">公司简介：</td>
		                <td>
		                	<input name="" class="nui-textbox" readonly="true" enabled="false"/>
		                </td>
		            </tr>
				</table>
			</div>
		</div>
	</div>
	<%-- 详情结束... --%>
	<script type="text/javascript">
    	nui.parse();
    	$("#tabs_tbond_deal_detail .mini-buttonedit-button").remove();
    	var commandInformation = null;
    	var tabDealRole = new nui.Form("#bank_between_instruct_condition");
		var conditionForm = nui.get("datagrid_tbond_trade");
		var dealDetail = new nui.Form("#tabs_tbond_deal_detail");
		//conditionForm.hideColumns([1,2]);
        
    	function clicksearch(e,text){
    		nui.open({
	    		url:"<%=request.getContextPath() %>/transaction/invest/sz_integrated_prot/instructIssue.jsp",
	    			title:"下达投资指令/建议", 
	    			width:1030,
	    			height:580,
	    			allowResize:false,
	    			onload:function(){
	    				var iframe = this.getIFrameEl();
	    				var positionInfo = {};
	    				if(e){
	    					positionInfo = conditionForm.getRow(parseInt(e));    //点买入或卖出的传参
	    					if(text == "sell" ){									//判断客户是点的卖出还是卖出 sell：卖出 否则为买入
		    					positionInfo["vcEntrustDirection"] = "4";//添加指令/建议下达的委托方向字段
	    					}else{
	    						positionInfo["vcEntrustDirection"] = "3";
	    					}
	    					positionInfo["vcProductCode"] = positionInfo["vcFundCode"]; //产品代码
	    					positionInfo["vcProductName"] = positionInfo["vcFundName"]; //产品名称
	    					positionInfo["vcCombiCode"] = positionInfo["vcCombiNo"]; //组合代码
	    					iframe.contentWindow.SetData(positionInfo);
	    				}
	    			},
	    			ondestroy:function(action){
	    				if(action == "ok"){
	    					conditionForm.reload();
	    				}
	    			}
    		});		
    	}
    /* 
       function onActionRenderer(e) {
            var grid = e.sender;  //表格对象
            var record = e.record;//行对象
            var uid = record._uid;
            var rowIndex = e.rowIndex;
            var s =  '<a style="color:#00CCFF"  onclick="clicksearch(\''+uid+'\',\'sell\')" href="#">卖出</a>&nbsp &nbsp'+
            		 '<a style="color:#00CCFF"  onclick="clicksearch(\''+uid+'\',\'buy\')" href="#">追加买入</a>';
            return s;
        } */
        //查询客户有权持仓信息
        $(function(){
        	search();
        	//初始化改变债券代码选择提示语句
    	$("#vcStockCode > span > input").attr("placeholder","全部");
		})
    </script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/transaction/invest/interbank_trade/js/tBondTrade.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/transaction/invest/transaction_JS/transactionComJs.js"></script>
</body>
</html>