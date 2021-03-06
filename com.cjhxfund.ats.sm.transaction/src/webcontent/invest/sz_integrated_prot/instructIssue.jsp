<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ page import="com.eos.foundation.eoscommon.CacheUtil" %>
<%@ page import="commonj.sdo.DataObject" %>
<%@ page import="com.eos.foundation.data.DataObjectUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 吴艳飞
  - Date: 2016-09-13 13:58:47
  - Description:
-->
<head>
<title>深圳综合下达投资指令/建议</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
    	.nui-textbox {
		    width:100%;
		 } 
		#complete_instruction  span{
		 	color:red;
		 }
		 .instructTable tr{
		 	height:32px;
		 }
    </style>
    <style type="text/css">
    	.mini-buttonedit-border{
    		padding-right:1px;
    	}
    </style>
    <script type="text/javascript" src="<%= request.getContextPath() %>/JQMHistory/common/common.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/riskMgr/js/riskMgrComm.js"></script>
    <script type="text/javascript">
    	$(function(){
    		//初始化改变债券代码选择提示语句
    		$("#vcStockCode>span>input").attr("placeholder","请输入债券代码...");
    		$("#vcCounterpartyId>span>input").attr("placeholder","对手中文或首位拼音...");
    		$("#vcCounterpartyId>span").css({
    			"background":'#FFFFE6'
    		});
    		nui.get("tradeDate").setValue(new Date());
    		nui.get("vcSettleSpeed").setValue("1");
			$("#vcEntrustDirection  label:first").css({
					"color":"red"
			});
			$("#vcEntrustDirection  label:last").css({
					"color":"green"
			})
			//当为IE8时，使用js调整宽度
			if(navigator.userAgent.indexOf("MSIE 8.0")>0){
				var width = parseFloat($("container").width());
				$("#bondDetailCont > div:first").css({
					width:(width - 505)+ "px"
				});
			}
			//限制交易日
			limitTradeDate("tradeDate");
		})
			
    </script>
</head>
<body>
	<div class="container" style="height:100%;width:100%;">
		<div style="float:left; width:calc(100%-505px);height:auto;" id="bondDetailCont">
		<!--主体部分左边查询项begin  -->
			<div id="bond_details"  >
				<table border="0" cellpadding="1" cellspacing="2" style="width:100%;" >
	           		<tr>
						<td style="width:80px;" align="right">债券类型:</td>
		                <td style="width:100px;" align="left"><input  name="vcStocktypeName" class="nui-textbox" enabled="false"/></td>
	                    <td style="width:120px;" align="right">起息日:</td>
		                <td style="width:100px;" ><input name="lBegincalDate" class="nui-textbox"  enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">债项评级:</td>
	                	<td><input name="vcBondAppraise" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="creditRating" enabled="false"/></td>
	                    <td align="right">下一付息日:</td>
		                <td><input name="lNextPayintDate" class="nui-textbox"  enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">主体评级:</td>
						<td><input name="vcIssueAppraise" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="issuerRating" enabled="false"/></td>
		                <td align="right">距下一付息日天数:</td>
		                <td><input name="lNextPayintDays" class="nui-textbox"  enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">发行机构:</td>
		                <td><input name="vcIssuerNameFull" class="nui-textbox"  enabled="false"/></td>
		                <td align="right">到期日:</td>
		                <td><input name="lEndincalDate" class="nui-textbox"  enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">担保方式:</td>
		                <td><input name=vcAssureType class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="ATS_FM_ASSUER_TYPE" enabled="false"/></td>
		                <td align="right">剩余期限:</td>
		                <td><input class="nui-textbox" name="lLimiteLeft" enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">特殊条款:</td>
		                <td><input name="vcSpecialText" class="nui-textbox"  enabled="false"/></td>
		                <td align="right">距到期日天数:</td>
		                <td><input name="lEndincalDays" class="nui-textbox"  enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">票面面值:</td>
		                <td><input name="enParvalue" class="nui-textbox"  enabled="false"/></td>
		                <td align="right">中证净价(元):</td>
		                <td><input id="enCzValueNetValue" name="enCzValueNetValue" class="nui-textbox"  enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">基准类别:</td>
		                <td><input name="vcBchmkRate" class="nui-textbox"  enabled="false"/></td>
		                <td align="right">中证全价(元):</td>
		                <td><input name="enCzValueAllValue" class="nui-textbox"  enabled="false" /></td>
					</tr>
					<tr>
						<td align="right">票面利率:</td>
		                <td><input name="enFaceRate" class="nui-textbox"  enabled="false"/></td>
		                <td align="right">中证估价收益率(%):</td>
		                <td><input name="enCzValueIncmRate" class="nui-textbox"  enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">利率类型:</td>
		                <td><input name="cInterestType" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="rateType" enabled="false"/></td>
		                <td align="right">中证估价修正久期:</td>
		                <td><input name="enCzValueMduration" class="nui-textbox"  enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">付息频率:</td>
		                <td><input name="enPayInteval" class="nui-textbox"  enabled="false"/></td>
		                <td align="right">中证估值凸性:</td>
		                <td><input name="enCzValueConvexity" class="nui-textbox"  enabled="false"/></td>
					</tr>
					<tr>
	                	<td align="right" id="vcNewCopBondTypeLab">新公司债类型:</td>
	                    <td><input name="vcNewCopBondType" id="vcNewCopBondType" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="newCopBondType" enabled="false" /></td>
	                </tr>
	            	<tr>
	            		<td colspan="4">
	            			<div style="width:100%;height:1px;border-bottom:1px dashed #000;margin-top:10px;margin-botton:10px"></div>
	            		</td>
	            	</tr>
		        </table>	
			  </div>
			  		  
		      <div id="available_details"  style="" >
				<table border="0" cellpadding="1" cellspacing="2" style="width:100%;" >
	                <tr>
	                	<td style="width:80px;" align="right">T+0头寸:</td>
	                    <td style="width:100px;"><input id="vcAvailableamountT0"  name="vcAvailableamountT0" class="nui-textbox"  enabled="false"/></td>
	                    <td style="width:120px;" align="right">基金净资产:</td>
	                    <td style="width:100px;"><input id="enFundValue" name="enFundValue" class="nui-textbox"  enabled="false" /></td>
	                </tr>
	                <tr>
	                	<td align="right">T+1头寸:</td>
	                    <td><input id="vcAvailableamountT1"  name="vcAvailableamountT1" class="nui-textbox"  enabled="false"/></td>
	                    <td align="right">持仓(占%):</td>
	                    <td><input id="positionRatio" name="positionRatio" class="nui-textbox"  enabled="false"/></td>
	                </tr>
	                <tr>
	                	<td align="right">T+0可用数量:</td>
	                    <td><input id="vcAvailablequantityT0"  name="vcAvailablequantityT0" class="nui-textbox"  enabled="false"/></td>
	                    <td align="right">未成(占%):</td>
	                    <td><input id="unachievedRatio"  name="unachievedRatio"class="nui-textbox"  enabled="false" /></td>
	                </tr>
	                <tr>
	                	<td align="right">T+1可用数量:</td>
	                    <td><input id="vcAvailablequantityT1"  name="vcAvailablequantityT1" class="nui-textbox"  enabled="false"/></td>
	                    <td align="right">指令/建议(占%):</td>
	                    <td><input id="instructRatio"  name="instructRatio" class="nui-textbox"  enabled="false"/></td>
	                </tr>
	                <tr >
	                	<td align="right"></td>
	                    <td></td>
	                	<td align="right">合计(占%):</td>
	                    <td><input id="totalRatio"  name="totalRatio" class="nui-textbox"  enabled="false"/></td>
	                </tr>
	            </table>	
			</div>
			<!--主体部分左边查询项end  -->
		</div>
		
		<!--输入项完整指令/建议begin  -->
		<div id="tabs" class="nui-tabs" style="height:100%; width:570px;float:right;" activeIndex="0">
			<div title="深交所综合协议平台">
				<div id="complete_instruction" style="padding: 5px">
					<!-- 下单操作类型:0-新建指令/建议 1-修改指令/建议 -->
					<input class="nui-hidden" name="operatorType" id="operatorType" value="1"/>
					<!-- 业务类别:2-银行间二级市场业务 A –开放式基金B-存款业务C-网下申购D-债券一级市场 E-交易所大宗交易，I-上交所固定收益平台 -->
					<input class="nui-hidden" name="businClass" id="businClass" value="E"/>
					<!-- 交易市场：OTC-场外（银行间）SS-上交所，SZ-深交所； -->
					<input id="exdestination" name="exdestination" class="nui-hidden" value="SZ"/>
					<!-- 投资类型：交易所，1-可交易；2-持有到期；3-可供出售；回购业务投资类型为1-可交易，不传投资类型会根据系统数决定取组合的投资类型或缺省为1-可交易，具体取值和O3保持一致。 -->
					<input id="vcInvestType" name="vcInvestType" class="nui-hidden" value="1"/>
					<!-- 证券控制类型:1-金额控 、2-数量控、缺省按2-数量控 -->
					<input id="ordtype" name="ordtype" class="nui-hidden" value="2"/>
					<!-- 结算方式（首次结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户-->
					<input id="vcFirstSettleMode" name="vcFirstSettleMode" class="nui-hidden" value="3"/>
					<!-- 指令/建议有效模式，默认为0-Day：0 – Day，当日有效；1 – GTC，一直有效，直到完成或撤销；6 – GTD，到指定日前有效  -->
					<input id="timeinforce" name="timeinforce" class="nui-hidden" value="6"/>
					<!-- 判断可用：0-不判；1-判  -->
					<input id="judgeavailable" name="judgeavailable" class="nui-hidden" value="1"/>
					<!-- 判断风控：0-不判；1-判   -->
					<input id="judgerisk" name="judgerisk" class="nui-hidden" value="1"/>
					<!--业务类型 1:银行间二级交易 2:上海大宗交易 3:	上海固收平台 4:深圳综合协议平台  -->
					<input class="nui-hidden" name="vcBizType" id="vcBizType"   value="4"/>
					<!--币种 人民币:CNY  -->
					<input class="nui-hidden" name="vcCurrency" id="vcCurrency"   value="CNY"/>
					<!--插表交易市场 1-上交所;2-深交所;5-银行间;6-场外;7-中金所 -->
					<input class="nui-hidden" name="vcMarket" id="vcMarket"   value="2"/>
					<!--收益率类型：1-到期收益率，2-行权收益率  -->
					<input class="nui-hidden" name="vcYieldType" id="vcYieldType"   value="1"/>
					<!--判断债券是净价还是全价 1-净价，2-全价-->
					<input class="nui-hidden" name="bondType" id="bondType"  value="1"/>
					<table id="instrcutInfo" class="instructTable" border="0" cellpadding="1" cellspacing="2" style="width: 100%;">
						<tr>
							<td style="width: 15.38%;" align="right" ><span>*</span>产品名称:</td>
							<td style="width: 31.76%;" align="left">
	                        <div name="vcProductCode" class="mini-autocomplete" pinyinField="ID" id="vcProductCode"
		                             textField="TEXT" valueField="ID"
		                             searchField="productCode"
		                             url="com.cjhxfund.commonUtil.applyInstUtil.QueryTAtsProductInfoMatchSort.biz.ext"
		                             showNullItem="false"
		                             allowInput="true"
		                             emptyText="请输入产品代码或产品名称..."
		                             nullItemText="请输入产品代码或产品名称..."
		                             valueFromSelect="true"
		                             showClose="true"
		                             onvaluechanged="selectFunds"
		                             oncloseclick="onCloseClick"
		                             popupWidth="300"
		                             style="width: 125px"
		                             required="true">
		                            <div property="columns">
		                                <div header="产品代码" field="ID" width="40px"></div>
		                                <div header="产品名称" field="TEXT"></div>
		                            </div>
		                        </div>    
		                        <div class="nui-hidden" type="hidden" id="lProductId" name="lProductId" />
							</td>
							<td style="width: 19%;" align="right" ><span>*</span>净价/全价:</td>
							<td style="width: 33.83%;" align="left">
								<span><input class="nui-textbox" id="enNetPrice" name="enNetPrice" required="true" style="width: 63px" onvalidation="numberCheck" onblur="netPriceFun" /></span>
								<label>/</label> 
								<span><input class="nui-textbox" id="enFullPrice" name="enFullPrice" required="true" style="width: 63px" onvalidation="numberCheck" onblur="fullPriceFun"/></span>
							</td>
		
						</tr>
						<tr>
							<td align="right" ><span>*</span>组合名称:</td>
							<td>
								<input name="vcCombiCode" class="nui-combobox" id="vcCombiCode"
                                   textField="TEXT" valueField="ID"
                                   dataField="data"
                                   showNullItem="false"
                                   allowInput="false"
                                   required="true"
                                   emptyText="请选择..."
                                   nullItemText="请选择..."
                                   style="width: 140px"
                                   onitemclick="onCombiLinkage"
                                   showClose="true"
                                   oncloseclick="onCloseClick"/>
							</td>
							<td align="right" id="MaturityLab"><span>*</span>到期/行权收益率:</td>
							<td align="left" id="MaturityField">
								<span><input class="nui-textbox" id="enMaturityYield" name="enMaturityYield" style="width: 63px" enabled="false" required="true"   onblur="interestRateFun"/></span> 
								<label id="MaturityLabSplit">/</label> 
								<span><input class="nui-textbox" id="enOptionYield"  name="enOptionYield" style="width: 63px" enabled="false" required="true"  onblur="enOptionInterestRateFun"/></span>
							</td>
							
						</tr>
						<tr>
							<td align="right" ><span>*</span>债券代码:</td>
							<td>
								<div name="vcStockCode" class="mini-autocomplete" id="vcStockCode"
	                                 textField="stockCode" valueField="stockCode"
	                                 searchField="stockCode"
	                                 url="com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.querySZBondCode.biz.ext"
	                                 allowInput="true"
	                                 emptyText="请选择..."
	                                 nullItemText="请选择..."
	                                 valueFromSelect="true"
	                                 dataField="bondList"
	                                 multiSelect="false"
	                                 style="width: 140px;float:left;"
	                                 required="true"
	                                 popupWidth="300"
	                                 onvalidation="onO32ExistValidation"
	                                 onvaluechanged="onActionRenderer">
                                	<div property="columns">
	                                    <div header="债券代码" field="stockCode" width="40px"></div>
	                                    <div header="债券名称" field="stockName"></div>
                                	</div>
                        		</div>
                        		<a class="nui-button" plain="true" style="float:left;height:19px;" iconCls="icon-search" onclick="showHoldingPage('szIntegratedProtHolding.jsp')" tooltip="添加新债券"></a>
                        	</td>
                        	<td align="right" ><span>*</span>债券名称:</td>
							<td>
								<input id="vcStockName" class="nui-textbox" name="vcStockName"  style="width: 140px" required="true"  enabled="false"/>
								<input id="vcInterCode" class="nui-hidden"name="vcInterCode"/>
							</td>
							
						</tr>
						<tr>
							<td align="right" red="red"><span>*</span>委托方向:</td>
							<td><input id="vcEntrustDirection" class="nui-radiobuttonlist" name="vcEntrustDirection" onitemclick="changeToRed"
								data="[{id: '3', text: '买入'}, {id: '4', text: '卖出'}]" required="true"/>
							</td>
							
                        	<td align="right" ><span>*</span>交易日期:</td>
							<td>
								<input id="tradeDate" class="nui-datepicker" name="tradeDate" 
									required="true"  style="width: 140px" allowInput="false"  
									onvaluechanged="whetherTradeDate" showClearButton="false" 
									data-options='{dateType:"00"}'  onvalidation="isTradeDate" />
							</td>
						</tr>
						<tr>
							<td align="right" ><span>*</span>清算速度:</td>
							<td><input  class="nui-radiobuttonlist"  id="vcSettleSpeed" name="vcSettleSpeed" required="true"  enabled="false" onitemclick="whetherTradeDate"
								data="[{id: 0, text: 'T+0'}, {id: 1, text: 'T+1'}]"  onitemclick="whetherTradeDate"/>
							</td>
							<td align="right" ><span>*</span>结算日期:</td>
							<td>
								<input id="firstSettleDate" class="nui-datepicker" name="firstSettleDate" required="true" style="width: 140px"  onvalidation="lDelistingVali"  readonly="readonly"/>
							</td>
							
						</tr>
						<tr>
							<td align="right"><span>*</span>券面金额:</td>
							<td><input class="nui-textbox" style="width: 140px" 
									id="enFaceAmount" name="enFaceAmount"  required="true" 
									onvalidation="enFaceAmountCheck"  onblur="calculateNetPrice"/><span style="padding-left:3px;">万元</span></td>
							<td align="right"  money="money"><span>*</span>净价金额:</td>
							<td align="left">
								<input class="nui-textbox"  id="enNetPriceAmount" style="width: 140px" name="enNetPriceAmount"  required="true"  enabled="false"/> 
								<input class="nui-textbox" id="enFullPriceAmount" style="width: 140px" name="enFullPriceAmount"  required="true"  enabled="false"/>
							</td>
						</tr>
						<tr>
							<td align="right" ><span>*</span>对手席位:</td>
							<td>
								<input id="vcRivalSeat" class="nui-textbox" style="width: 140px" name="vcRivalSeat" required="true" onvalidation="digitCheck"/>
							</td>
							<td align="right" ><span>*</span>交易对手:</td>
							<td>
								<div name="vcCounterpartyId" class="mini-autocomplete" id="vcCounterpartyId"
	                                 textField="vcName" valueField="vcRivalCode"
	                                 searchField="vcPinyin"
	                                 url="com.cjhxfund.ats.sm.comm.TraderivalManager.QueryTraderByPinyin.biz.ext"
	                                 popupEmptyText="全部"
	                                 nullItemText="全部"
	                                 loadingText="加载中"
	                                 dataField="traders"
	                                 multiSelect="false"
	                                 style="width: 140px"
	                                 popupWidth="300"
	                                 onvalidation="vcCounterpartyCheck"
	                                 onvaluechanged="setIssueOrgan">
	                                <div property="columns">
		                                <div header="对手代码" field="vcRivalCode" width="20"></div>
		                                <div header="对手名称" field="vcName"></div>
                					</div>
                				</div>
							</td>
						</tr>
						<tr>
							<td align="right" ><span>*</span>约定号:</td>
							<td><input  class="nui-textbox"  id="vcAgreemtCode"  style="width: 140px" name="vcAgreemtCode" required="true"  onvalidation="digitCheck"/></td>
							<td align="right" >对手主体机构:</td>
							<td><input class="nui-textbox" showClose="true"  style="width: 140px" id="vcCounterpartyOrgan" name="vcCounterpartyOrgan"/></td>
						</tr>
						<tr style="height:64px !important">
							<td align="right" style="vertical-align: text-top;">备注:</td>
							<td colspan="3"><input class="nui-textarea" vtype="maxLength:1024" id="vcRemark" name="vcRemark" style="width: 415px"/></td>
						</tr>
					</table>
					
				</div>
				<div align="center">
					<a class="nui-button" iconCls="icon-tip" plain="true" id="exactrisk" onclick="riskControlTrial(this)">风控试算</a>
					<a class="nui-button" iconCls="icon-ok" plain="true" id="exactCommit" onclick="commit(this)">提交</a> 
					<a class="nui-button" iconCls="icon-cancel" plain="true" onclick="onCancel()">取消</a>
				</div> 
			</div>
			
		</div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	$("#bondDetailCont .mini-buttonedit-button").remove();
		var sumFaceAmount = null;//当前债券代码所有没有成交的数量
		var enBondAsset = null; //当前债券的市值
		var bondPriceType = null;//判断债券是净价还是全价 1-净价，2-全价
		var lLeftDays = null;  //距到期日天数
		var originalInstructionInfo = null;//修改指令/建议时校验是否修改
		var instructionInfo = null;//修改指令/建议的所有传值
		var investProductInfoCommon = "";//投资产品信息全局变量（债券代码,债券名称,交易市场编号,证券内码）
		var hasSellback = true; //是否有回售条款
		var lDelistingDate = null; //摘牌日期
		
		var bondDetails = new nui.Form("#bond_details");
		var completeInstruction = new nui.Form("#complete_instruction");
		//根据债券计算清算速度并得出结算日期
		function countIiquidationVelocity(){
			var paramter = {};
			var vcStockCode = nui.get("vcStockCode").getValue();//债券代码
			var vcBizType = nui.get("vcBizType").getValue();//交易平台
			paramter["vcBizType"] = vcBizType;
			paramter["vcStockCode"] = vcStockCode;
			if(vcStockCode){
				nui.ajax({
	                url:"com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.queryStockLiquidationVelocity.biz.ext",
	                type: 'POST',
	                data: {paramter:paramter},
	                cache: false,
	                contentType: 'text/json',
	                success: function (e) {
	                   	var returnJson = nui.decode(e);
						if(returnJson.exception == null){
							var stockInfo = returnJson.stockInfo;
							if(stockInfo.length>0){
								var vcSpeed = stockInfo[0].vcSpeed;
								nui.get("vcSettleSpeed").setValue(vcSpeed);
							}
							whetherTradeDate();//根据清算速度和交易日期得出结算日期
						}else{
							nui.alert("系统异常","系统提示");
						}
	                }
	            });
			}
		}
		
		function SetData(data) {
			//跨页面传递的数据对象，克隆后才可以安全使用
            data = nui.clone(data);
            bondDetails.clear();
			changeRed(data.vcEntrustDirection);
			var vcStockCode = data.vcStockCode;
			var vcEntrustDirection = data["vcEntrustDirection"];//委托方向
			nui.get("vcProductCode").setText(data["vcProductName"]);//产品名称
            nui.get("vcProductCode").setValue(data["vcProductCode"]);//产品代码
            nui.get("lProductId").setValue(data.lProductId);//产品Id
            selectFunds(data["vcCombiCode"]);
            		var vcAvailablequantityT0 = data["vcAvailablequantityT0"];//T+0可用数量
					if(vcAvailablequantityT0 && vcEntrustDirection == "4"){
						//券面金额：可用数量（先取T+0可用数量）*100
					 	var enFaceAmount = formatNumber(vcAvailablequantityT0/100,2,1);
						nui.get("enFaceAmount").setValue(enFaceAmount);
					}
			nui.get("vcEntrustDirection").setValue(vcEntrustDirection);//委托方向
			nui.get("vcStockCode").setValue(vcStockCode);
			nui.get("vcStockCode").setText(vcStockCode);//债券代码
			nui.get("vcStockName").setValue(data["vcStockName"]);//债券名称
			nui.get("vcInterCode").setValue(data["vcInterCode"]);//O32债券内码
			lDelistingDate = data["lDelistingDate"];
        	if(data["operatorType"] == "1"){
        		nui.get("operatorType").setValue(data["operatorType"]);
        		nui.get("vcSettleSpeed").setValue(data["vcSettleSpeed"]);//清算速度
        		nui.get("vcCombiCode").setValue(data["vcCombiCode"]);//组合代码
        		var lTradeDate = data["lTradeDate"].toString();
        		var lFirstSettleDate = data["lFirstSettleDate"].toString();
        		nui.get("tradeDate").setValue(lTradeDate);//交易日期
        		nui.get("firstSettleDate").setValue(lFirstSettleDate);//结算日期
        		nui.get("enFaceAmount").setValue(formatNumber(data["enFaceAmount"],2,1));//券面金额
        		nui.get("enNetPrice").setValue(data["enNetPrice"]);//净价
        		nui.get("enFullPrice").setValue(data["enFullPrice"]);//全价
        		nui.get("enMaturityYield").setValue(data["enMaturityYield"]);//到期收益率
        		nui.get("enOptionYield").setValue(data["enOptionYield"]);//行权收益率
        		nui.get("enNetPriceAmount").setValue(formatNumber(data["enNetPriceAmount"],2,1));//净价金额
        		nui.get("enFullPriceAmount").setValue(formatNumber(data["enFullPriceAmount"],2,1));//全价金额
        		nui.get("vcAgreemtCode").setValue(data["vcAgreemtCode"]);//约定号
				nui.get("vcCounterpartyId").setText(data["vcCounterpartyName"]);//交易对手
				nui.get("vcCounterpartyId").setValue(data["vcCounterpartyId"]);//交易对手编号
				nui.get("vcRivalSeat").setValue(data["vcRivalSeat"]);//对手席位
				nui.get("vcCounterpartyOrgan").setValue(data["vcCounterpartyOrgan"]);//交易对手编号
				nui.get("vcRemark").setValue(data["vcRemark"]);//备注
				//禁用不可修改元素
				nui.get("vcProductCode").disable();
				nui.get("vcCombiCode").disable();
				nui.get("vcStockCode").disable();
				nui.get("vcEntrustDirection").disable();
        		instructionInfo = data;
        	}else{
        		countIiquidationVelocity();  //根据债券计算清算速度并得出结算日期
        	}
        	getBondType();//根据债券代码判断是净价还是全价
			//selectFunds(data["vcCombiCode"]);
			originalInstructionInfo = completeInstruction.getData(false,false);
		}

        
       	function commit(e) {
			//验证表单
    		completeInstruction.validate();
			if(completeInstruction.isValid()==false){
				nui.alert("必填项为空或校验有误，请确认","提示");
				return;
			}
			//判断修改指令/建议是否有做修改
			if(nui.get("operatorType").getValue() == "1"){
				var flag = false;
				var instructions = completeInstruction.getData(false,false);
				for(var key1 in originalInstructionInfo){
					for(var key in instructions){
						if(key1 == key){
							if(key1 && key){
								if(originalInstructionInfo[key1] != instructions[key]){
									flag = true;
								}
							}
						}
					}
				}
				if(!flag){
					nui.alert("未做任何修改","提示");
					return;
				}
			} 
			
			var json = null;
			var parameter = capsulationInstructParameter();
			json = {instructParameter:parameter};
			var operatorType = nui.get("operatorType").getValue();
			if(operatorType == "1"){   //下达指令/建议，否则为修改指令/建议
				json["srcInstruct"] = instructionInfo;
			}
			nui.ajax({
        		data:json,
        		url:"com.cjhxfund.ats.sm.comm.InstructionManager.instructionDateConfirm.biz.ext",
        		success:function(resp){
        			var returnJson = nui.decode(resp);
					if(returnJson.exception == null){//客户下达指令/建议时间>产品参数配置时间
						 if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_OVER_DEAL_TIME%>"){ 
							nui.confirm("该投资指令/建议下达时间过晚，无法完全保证交易达成，确定继续？", "提示",
					            function (action) {
					                if (action == "ok") {
					                   instructSub(json);
					                }
					            }
					        );
						}else if(returnJson.rtnCode =="<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>" ){
							nui.alert("系统异常,请稍后再试","提示");
						}else{
							 instructSub(json);
						}
					}else{
						nui.alert("系统异常","系统提示");
					}
		          
	            }
			});
		}
		
		/*风控管理开始*/
		function subData(riskReturn, instructJson){
        	var riskFlag = showRiskInfo(riskReturn, instructJson);
        	riskControl(riskFlag, instructJson);
        }
        function riskControl(riskFlag, instructJson){
        	riskFlagParam = riskFlag;
        	lResultIdParam = instructJson.instructParameter.lResultId;
        	lRiskmgrIdParam = instructJson.instructParameter.lRiskmgrId;
        	if(riskFlag=='-1'){
        		return;
        	}else if(riskFlag=='1'){
        		formalInstructionEntry(instructJson);
        	}else if(riskFlag=='2'){
        		formalInstructionEntry(instructJson);
        	}
        }
        function formalInstructionEntryFinish(){
        	if(riskFlagParam=='2'){
        		startRiskProcessInstruct(lResultIdParam, lRiskmgrIdParam);
        	}
        	CloseOwnerWindow("ok");
        }
        /*风控管理结束*/
		  
 		function instructionAvailIssue(instructJson){
 			var tooltip = nui.loading("正在处理中,请稍等...","提示");
 			nui.ajax({
 				url: "com.cjhxfund.ats.sm.comm.InstructionManager.checkInstructAvail.biz.ext",
	            type: 'POST',
	            data: instructJson,
	            cache: false,
	            contentType: 'text/json',
	            success: function (text) {
	            	nui.hideMessageBox(tooltip);
	            	var returnJson = nui.decode(text);
	            	if(returnJson.exception == null){
	            		if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
	            			var riskMsg = returnJson.riskMsg;
	            			if(riskMsg.isAgainstRisk){
	            				riskMsg["alertMsg"]="投资指令/建议修改成功！";
	            				nui.open({
			                        url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
			                        title: "投资指令/建议风控信息",
			                        width: 800,
			                        height: 422,
			                        onload: function () {
			                            var iframe = this.getIFrameEl();
			                            iframe.contentWindow.SetData(riskMsg,3);
			                        },
			                        ondestroy: function (action) {
			                           CloseOwnerWindow("ok");
			                        }
			                    });
	            			}else{
		            			nui.alert("投资指令/建议修改成功！","提示",function(){
	                            	CloseOwnerWindow("ok");
	                            });
	            			}
	            		}else if(returnJson.rtnCode == "203" || returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT%>"){//可用不足,继续下单先校验风控
	            			nui.confirm(returnJson.rtnMsg+"</br>是否继续下单？","提示", function(action){
		                		if(action == "ok") {
                                	formalInstructionEntry(instructJson);
                                }
		                	});
	            		}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
	            			var riskMsg = returnJson.riskMsg;
	            			if(riskMsg.isAgainstRisk){//触发了风控
	            				riskMsg["alertMsg"]="投资指令/建议修改失败！";
	            				nui.open({
			                        url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
			                        title: "投资指令/建议风控信息",
			                        width: 800,
			                        height: 422,
			                        onload: function () {
			                            var iframe = this.getIFrameEl();
			                            iframe.contentWindow.SetData(riskMsg,3);
			                        }
			                    });
	            			}else{
	            				nui.alert(returnJson.rtnMsg,"系统提示");
	            			}
	            		}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_NO_RCV_FR_O32%>"){
	            			nui.alert("投资指令/建议修改成功！</br>"+returnJson.rtnMsg,"提示",function(){
                            	CloseOwnerWindow("ok");
                            });
	            		}else if(returnJson.rtnCode == "301"){//既触发风控又触发可用
	            			var riskMsg = returnJson.riskMsg;
	            			riskMsg["alertMsg"]=returnJson.rtnMsg;
	            			nui.open({
		                        url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
		                        title: "投资指令/建议风险提示",
		                        width: 800,
		                        height: 422,
		                        onload: function(){
		                            var iframe = this.getIFrameEl();
		                            iframe.contentWindow.SetData(riskMsg,1);
		                        },
		                        ondestroy: function (action) {
		                            if (action == "ok") {
	                                    formalInstructionEntry(instructJson);
	                                }
		                        }
		                    });
	            		}else{//触发风控，弹出风险提示框，展示风险信息
	            			var riskInfo = returnJson.riskMsg;
		                    nui.open({
		                        url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
		                        title: "投资指令/建议风险提示",
		                        width: 800,
		                        height: 380,
		                        onload: function () {
		                            var iframe = this.getIFrameEl();
		                            iframe.contentWindow.SetData(riskInfo,1);
		                        },
		                        ondestroy: function (action) {
		                            if (action == "ok") {
	                                    formalInstructionEntry(instructJson);
	                                }
		                        }
		                    });
	            		}
	            	}else{
	            		nui.alert("系统异常","系统提示");
	            	}
	            }
 			 });
   		 }
   	 	
   	 	//正式修改指令/建议信息
   	 	function formalInstructionEntry(instructJson){
   	 		var tooltip = nui.loading("正在处理中,请稍等...","提示");
   	 		nui.ajax({
                url: "com.cjhxfund.ats.sm.comm.InstructionManager.insertAndUpdateInstruct.biz.ext",
                type: 'POST',
                data: instructJson,
                cache: false,
                contentType: 'text/json',
                success: function (e) {
                	nui.hideMessageBox(tooltip);
                   	var returnJson = nui.decode(e);
					if(returnJson.exception == null){
						if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>") {
                        	var riskMsg = returnJson.riskMsg;
	            			if(riskMsg.isAgainstRisk){
	            				riskMsg["alertMsg"]="投资指令/建议修改成功！";
	            				nui.open({
			                        url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
			                        title: "投资指令/建议风控信息",
			                        width: 800,
			                        height: 422,
			                        onload: function () {
			                            var iframe = this.getIFrameEl();
			                            iframe.contentWindow.SetData(riskMsg,3);
			                        },
			                        ondestroy: function (action) {
			                           CloseOwnerWindow("ok");
			                        }
			                    });
	            			}else{
		            			nui.alert("投资指令/建议修改成功！","提示",function(){
	                            	CloseOwnerWindow("ok");
	                            });
	            			}
                        }else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>") {
                        	var riskMsg = returnJson.riskMsg;
	            			if(riskMsg.isAgainstRisk){
	            				riskMsg["alertMsg"]="投资指令/建议修改失败！";
	            				nui.open({
			                        url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
			                        title: "投资指令/建议风控信息",
			                        width: 800,
			                        height: 422,
			                        onload: function () {
			                            var iframe = this.getIFrameEl();
			                            iframe.contentWindow.SetData(riskMsg,3);
			                        }
			                    });
	            			}else{
	            				nui.alert("投资指令/建议修改失败！</br>"+returnJson.rtnMsg,"提示");
	            			}
                        } else{
                            nui.alert("指令/建议修改成功!"+returnJson.rtnMsg,"提示",function(){
                            	CloseOwnerWindow("ok");
                            });
                        }
					}else{
						nui.alert("系统异常","系统提示");
					}
                }
            });
   	 	}
		  
		//封装指令/建议参数
	  	function capsulationInstructParameter(){
	   	 	var tradeDate = nui.formatDate(nui.get("tradeDate").value, "yyyyMMdd");
			var firstSettleDate = nui.formatDate(nui.get("firstSettleDate").value, "yyyyMMdd");
			var parameter = null;
			var bondInfo = null;
			bondInfo = bondDetails.getData(false, false);//仅用作给后台传参用
			parameter = completeInstruction.getData(false, false);
			//仅插入数据库用，start
			var funds = nui.get("vcProductCode").getData();
			for(var i = 0,len = funds.length; i < len;i++){
				if(funds[i].ID==nui.get("vcProductCode").getValue()){
		    		parameter["lProductId"] = funds[i].L_PRODUCT_ID;
		    	}
			}
			parameter["vcProductName"] = nui.get("vcProductCode").getText();//产品名称
			var combis = nui.get("vcCombiCode").getData();
			for(var i = 0,len = combis.length; i < len;i++){
				var asset = combis[i];
				if(asset.ID==nui.get("vcCombiCode").getValue()){
		    		parameter["lAssetId"] = asset.L_ASSET_ID;
		    		parameter["vcAssetCode"] = asset.VC_ASSET_NO;
		    		parameter["vcAssetName"] = asset.VC_ASSET_NAME;
		    		parameter["lCombiId"] = asset.L_COMBI_ID;
		    	}
			}
			if(nui.get("operatorType").getValue() == "1" && instructionInfo.cIsValid=="1"){//修改指令/建议
				var tradeQty = parseInt(instructionInfo.enFaceAmount.replace(/,/g,''))*100;
				if(instructionInfo.vcEntrustDirection=="01" || instructionInfo.vcEntrustDirection=="3"){//买入
					if(parameter["vcAssetCode"] == instructionInfo.vcAssetCode){
						var now =  nui.formatDate(new Date(),"yyyyMMdd");//当日
						var now1 = nui.formatDate(new Date(new Date().getTime()+24*60*60*1000),"yyyyMMdd"); //修改指令/建议的可以金额校验需要
			    		//原指令/建议的交易日为今天的指令/建议或者交易日为明天的t+0指令/建议在需改时需要将资金加回
						if(instructionInfo.lTradeDate == now || (instructionInfo.lTradeDate == now1 && instructionInfo.vcSettleSpeed == "0")){
    						var fullPrice = parseFloat(instructionInfo.enFullPrice.replace(/,/g,''));
							tradeQty = tradeQty*fullPrice;
							parameter["tradeQty"] = tradeQty;
    					}
					}
				}else{//卖出
					if(nui.get("vcStockCode").getValue() == instructionInfo.vcStockCode && nui.get("vcCombiCode").getValue()==instructionInfo.vcCombiCode){
						parameter["tradeQty"] = tradeQty;
					}
				}
			}
			parameter["lTradeDate"] = tradeDate;		//交易日期
			parameter["lFirstSettleDate"] = firstSettleDate;//结算日期
			parameter["lLeftDays"] = lLeftDays;		//距到期日天数
			parameter["vcCombiName"] = nui.get("vcCombiCode").getText();		//组合名称
			parameter["vcOrgRating"] = bondInfo["vcIssueAppraise"];					//主体评级
			parameter["vcBondRating"] =bondInfo["vcBondAppraise"];					//债项评级
			parameter["enDuration"] =bondInfo["enCzValueMduration"];				//中证估价修正久期(推荐)
			parameter["vcCounterpartyName"] = nui.get("vcCounterpartyId").getText(); //交易对手编号
			//仅插入数据库用，end
			var enNetPrice = parameter.enNetPrice.replace(/,/g,'');		//净价
			var enFaceAmount = parameter.enFaceAmount.replace(/,/g,'');
			var enFullPrice = parameter.enFullPrice.replace(/,/g,'');//全价
			//净价金额的计算,净价价格*券面金额（万元）*100,全价金额计算方式一致
			var enNetPriceAmount = enNetPrice*enFaceAmount*100; 
			var enFullPriceAmount = enFullPrice*enFaceAmount*100; 
			parameter["enNetPriceAmount"] = enNetPriceAmount	;		//净价金额
			parameter["enFullPriceAmount"] = enFullPriceAmount;		//全价金额
			if(bondPriceType == "1"){
				parameter["vcPrice"] = enNetPrice;									//作为O32传入价格
				parameter["enPrice"] = enNetPrice;									//作为O32传入价格
			}else{
				parameter["vcPrice"] = enFullPrice;				//作为O32传入价格
				parameter["enPrice"] = enFullPrice;				//作为O32传入价格
			}
			//判断交易对手是否是自己手动输入
			if(parameter["vcCounterpartyId"] == parameter["vcCounterpartyName"]){
				parameter["vcCounterpartyId"] = "";
			}
			parameter["enNetPrice"] = enNetPrice;				//净价
			parameter["enFullPrice"] = enFullPrice;				//全价
			parameter["enFaceAmount"] = enFaceAmount;			//券面金额
			parameter["vcInstructType"] = "1"; 			 //用来传给流程判断1、完整指令/建议  2、询价指令/建议
			parameter["vcProcessStatus"] = "1";			//流程状态
			parameter["lFixValidStatus"] = "0";//用于判断指令/建议是否发送O32以及发送结果：0-未发送,1-修改后未发送,2-发送中,3-发送成功,4-发送失败
			return parameter;
	   	 }
   	 
   	 	//位数校验
		function digitCheck(e){
			var reg = /^\d+(\.\d+)?$/;//正则
		    if (!reg.test(e.value)) {
		    	e.errorText = "必须为数字！";
			    e.isValid = false;
		        return false;
		    }
			var value = e.sender.value;
			var name = e.sender.name;
    		if(value.length != 6){
				e.errorText = "必须为6位";
				e.isValid = false;
				nui.get(name).setValue("");
			}
		}
		//风控试算
        function riskControlTrial(e){
        	//验证表单
    		completeInstruction.validate();
			if(completeInstruction.isValid()==false){
				nui.alert("必填项为空或校验有误，请确认","提示");
				return;
			} 
        	var parameter = capsulationInstructParameter();
        	var operatorType = nui.get("operatorType").getValue();
        	parameter["callRiskType"] = "1";//调风控类型：1-风控试算，2-指令/建议下达
        	var json = null;
        	json = {instructParameter:parameter};
        	if(operatorType == "1"){   //下达指令/建议，否则为修改指令/建议
        		json["srcInstruct"] = instructionInfo;
			}
        	 //风控试算start
        	var a = nui.loading("正在处理中,请稍等...","提示");
	        nui.ajax({
        	 	url: "com.cjhxfund.ats.sm.comm.InstructionManager.checkInstructAvail.biz.ext",
	            type: 'POST',
	            data: json,
	            cache: false,
	            contentType: 'text/json',
	            success: function (text) {
	            	nui.hideMessageBox(a);
	            	var returnJson = nui.decode(text);
					if(returnJson.exception == null){
		                var riskInfo = returnJson.riskMsg;
		                //可用不足或风控校验失败
		                if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT%>"){
		                	nui.alert(returnJson.rtnMsg,"投资指令/建议风险提示");//可用不足
		                }else if(returnJson.rtnCode == "203"){
		                	nui.alert(returnJson.rtnMsg,"系统提示");//风控校验失败
		                }else if (returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>") {
		                    if(returnJson.rtnMsg!=null){
		                    	nui.alert(returnJson.rtnMsg,"系统提示");
		                    }else{
		                    	nui.alert("风控试算通过!","系统提示");
		                    }
		                }else if(returnJson.rtnCode == "301"){
		                	riskInfo["alertMsg"]=returnJson.rtnMsg;
		                    nui.open({
		                        url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
		                        title: "投资指令/建议风险提示",
		                        width: 800,
		                        height: 422,
		                        onload: function () {
		                            var iframe = this.getIFrameEl();
		                            iframe.contentWindow.SetData(riskInfo,3);
		                        }
		                    });
		                }else{
		                     nui.open({
		                        url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
		                        title: "投资指令/建议风险提示",
		                        width: 800,
		                        height: 380,
		                        onload: function () {
		                            var iframe = this.getIFrameEl();
		                            iframe.contentWindow.SetData(riskInfo,3);
		                        }
		                    });
		                }
					}else{
						nui.alert("系统异常","系统提示");
					}
	            }
        	 });
	        //风控试算end
        }
        
   	 	//页面X的删除功能
		function onCloseClick(e) {
		    var obj = e.sender;
		    obj.setText(null);
		    obj.setValue(null);
		    obj.doValueChanged();
		}
		//校验交易日期是否为交易日
		function isTradeDate(e){
			if(!remindTradeDate(e,"交易日期不是交易日，还需要继续吗？")){
	    	e.errorText = "交易日期不是交易日！";
	        e.isValid = false;
	    }
		}
		
	//选择交易对手的时候，将对手主体机构带出
	function setIssueOrgan(e){
		var vcIssuerName = e.selected ? e.selected.vcIssuerName : "";
		nui.get("vcCounterpartyOrgan").setValue(vcIssuerName);
	}
	function showHoldingPage(pageName){
		nui.open({
			url:nui.context + "/transaction/investNew/HoldingPages/"+pageName,
				title:"选择债券", 
				width:1100,
				height:410,
				allowResize:false,
				onload:function(){
				},
				ondestroy:function(action){
					
				}
		});	
	}
	function enFaceAmountCheck(e){
		var reg= /^([1-9][0-9]{0,11}(\.[0-9]{2})?)$/;
            	var value = e.sender.value;
            	if(!reg.test(value.replace(/,/g,''))){
            		e.sender.setValue("");
            		e.errorText = "请输入1~12位正数";
            	 	e.isValid = false;
            	 	return true;
            	}
            	var enNetPriceAmountVal = nui.get("enNetPriceAmount").getValue();
            	var enNetPriceAmountValArray = enNetPriceAmountVal.split(',');
            	enNetPriceAmountVal = "";
            	for(var i = 0 ;i<enNetPriceAmountValArray.length;i++){
            		enNetPriceAmountVal = enNetPriceAmountVal + enNetPriceAmountValArray[i];
            	}
            	enNetPriceAmountVal = parseInt(enNetPriceAmountVal);
            	if((!enNetPriceAmountVal) || enNetPriceAmountVal < 500000){
            		if(value<50){
            		e.errorText = "券面金额或交易金额不能小于50万！";
            	 	e.isValid = false;
            	}
            	}
	}
	</script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/transaction/invest/sh_block_trade/js/instructIssueMerge.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/transaction/invest/transaction_JS/transactionInstructComJs.js"></script>
</body>
</html>