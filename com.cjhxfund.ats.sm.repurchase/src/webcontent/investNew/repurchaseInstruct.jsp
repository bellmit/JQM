<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 罗倔怀
  - Date: 2017-07-03 15:16:15
  - Description:
-->
<head>
<title>回购指令/建议下达</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
    	.container{
    		width:100%;
    		height:100%;
    		padding-left: 8px;
    	}
    	    	.mini-buttonedit-border{
    		padding-right:1px;
    	}
        .infoLabel {
            width: 227px;
            float: left;
            height: 30px;
        }

        .infoLabel > label {
            float: left;
            text-align: right;
            width: 100px;
            display: block;
            margin-right: 2px;
        }

        .infoLabel > label > span {
            color: red;
        }

        .infoLabel2 {
            width: 302px;
            float: left;
            height: 30px;

        }
        
        .infoLabel2 > label {
            float: left;
            text-align: right;
            width: 140px;
            display: block;
            margin-right: 2px;
        }

        .arrowContainer {
            width: 320px;
            height: 345px;
            display: block;
            float: left;
            margin-right: 5px;
        }

        .arrow {
            background: url("image/arrow_gray.png");
            width: 22px;
            height: 22px;
            cursor: pointer;
        }

        .arrowBig {
            background: url("image/arrow_Big.png");
            width: 64px;
            height: 64px;
            cursor: pointer;
            position: absolute;
            z-index: 999;
            display: none;
        }

        .arrowSelect {
            background: url("image/arrow_blue.png");
            width: 64px;
            height: 64px;
            float: left;
            cursor: pointer;
        }

        .searchBox {
            width:100%;
        	height:24px;
        	overflow: hidden;
        	background: transparent;
        }

        .searchDiv {
            width: 270px;
            float: left;
            margin-bottom: 5px;
        }

        .searchDiv > label {
            width: 65px;
            float: left;
            text-align: right;
            display: block;
        }

        .searchDiv > div {
            width: 270px;
            text-align: left;
        }

        .searchButton {
            width: auto;
            clear: both;
        }
    </style>
</head>
<body>
  <div class="container">
   <div style="margin-bottom: 5px;">
      <div class="arrowContainer">
      <div class="mini-panel" title="相关信息" style="width:100%;height:100%;">
            <div>
		        <div class="infoLabel2"><label> 当日正回购到期(中债)： </label>
		            <input id="enGhBalanceZ" enabled="false" style="width:160px;" value="enGhBalanceZ" class="nui-spinner" minValue="-100000000000000000" maxValue="10000000000000000" format="n2"/></div>
		        <div class="infoLabel2"><label> 当日正回购到期(上清)： </label>
		            <input id="enGhBalanceS" enabled="false" style="width:160px;" value="enGhBalanceS" class="nui-spinner" minValue="-100000000000000000" maxValue="10000000000000000" format="n2"/></div>
		        <div class="infoLabel2"><label> T+0可用金额 (元)：</label>
		            <input id="vcAvailableamountT0" name="vcAvailableamountT0" style="width:160px;" value="vcAvailableamountT" class="nui-spinner" minValue="-100000000000000000" maxValue="10000000000000000" format="n2" enabled="false"/>
		        </div>
		        <div class="infoLabel2"><label> T+1可用金额(元)： </label>
		            <input id="vcAvailableamountT1" name="vcAvailableamountT1" style="width:160px;" value="vcAvailableamountT" class="nui-spinner" minValue="-100000000000000000" maxValue="10000000000000000" format="n2" enabled="false"/>
		        </div>
		        <div class="infoLabel2"><label> 基金净资产(元)： </label>
		            <input id="enFundValue" enabled="false" name="enFundValue" style="width:160px;" value="enFundValue" class="nui-spinner" minValue="-100000000000000000" maxValue="10000000000000000" format="n2"/></div>
		        <div class="infoLabel2"><label> 在途回购金额(元)： </label>
		            <input id="enGhBalance" name="enGhBalance" enabled="false" style="width:160px;" value="enGhBalance" class="nui-spinner" minValue="-100000000000000000" maxValue="10000000000000000" format="n2"/>
		        </div>
		        <div class="infoLabel2">
		        <hr/>
		        </div>
		        <div class="infoLabel2"><label> 最大可做回购金额(元)： </label>
		            <input id="enGhBalance" name="enGhBalance" enabled="false" style="width:160px;" value="enGhBalance" class="nui-spinner" minValue="-100000000000000000" maxValue="10000000000000000" format="n2"/>
		        </div>
		        <div class="infoLabel2"><label> 当前托管机构(元)： </label>
		            <input id="enGhBalance" name="enGhBalance" enabled="false" style="width:160px;" value="enGhBalance" class="nui-spinner" minValue="-100000000000000000" maxValue="10000000000000000" format="n2"/>
		        </div>
		    </div>
		    </div>
        </div>
       
<div class="mini-panel" title="指令/建议详情"  style="width:540px;padding-right: 0;">
                <form id="fullDirection">
                    <div>
                        <div class="infoLabel"><label> <span>*</span>产品名称: </label>
                        <div name="vcProductCode" class="nui-autocomplete" pinyinField="ID" id="vcProductCode"
                            	textField="TEXT" valueField="ID"
                            	searchField="productCode"
								url="com.cjhxfund.commonUtil.applyInstUtil.QueryTAtsProductInfoMatchSort.biz.ext?queryType=01"
								showNullItem="false"
								allowInput="true" 
								emptyText="请输入产品代码或产品名称..."
								nullItemText="请输入产品代码或产品名称..."
								valueFromSelect="true"
								showClose="true"
								onvaluechanged="selectFund2"
								oncloseclick="onCloseClick"
								popupWidth="300"
								required="true">
								<div property="columns">
	                                <div header="产品代码" field="ID" width="40px"></div>
	                                <div header="产品名称" field="TEXT"></div>
	                            </div>
                            </div>
                        </div>
                        <div class="infoLabel">
                            <label><span>*</span>交易日期: </label>
                            <input id="lTradeDate" allowInput="false" name="lTradeDate" required="true" data-options='{dateType:"01"}'
                                   onvaluechanged="calFirstMaturityRe()" class="nui-datepicker" onvalidation="lTradeDateValid"/>
                        </div>
                        <div class="infoLabel"><label> <span>*</span>组合名称:</label>
                            <input name="vcCombiCode" class="nui-combobox" id="vcCombiCode"
                                   textField="TEXT" valueField="ID"
                                   dataField="data"
                                   url="com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfo.biz.ext"
                                   showNullItem="false"
                                   emptyText="请选择..."
                                   nullItemText="请选择..."
                                   showClose="true"
                                   oncloseclick="onCloseClick"
                                   onvaluechanged="selectCombi2"
                                   required="true"
                            />
                        </div>
                        <div class="infoLabel"><label> 首次结算日期:</label>
                            <input id="lFirstSettleDate" allowInput="false" name="lFirstSettleDate"
                                   onblur="calByFirstMa()" class="nui-datepicker" required="true"
                                   data-options='{dateType:"01"}' enabled="false"/>
                        </div>
                        <div class="infoLabel"><label><span>*</span>回购天数:</label>
                            <input class="nui-spinner" id="lRepoDays" required="true" name="lRepoDays"
                                   onblur="caclSymbol(true,'5','1')" maxValue="365" onvalidation="positiveNum"/>
                        </div>
                         <div class="infoLabel"><label> 到期结算日期:</label>
                            <input class="nui-datepicker" id="lMaturitySettleDate" allowInput=
                            "false" name="lMaturitySettleDate"required="true"
                                   onvalidation="setlMaturitySettleDate"  data-options='{dateType:"01"}'/>
                        </div>
                        <div class="infoLabel" id="changeInfoL" style="color:red;">
                            <label><label> *委托方向:</label></label>
                            <input class="nui-radiobuttonlist" name="vcEntrustDirection" id="vcEntrustDirection"
                                   data="[{id: '5', text:'正回购'}, {id: '6', text: '逆回购'}]" required="true"
                                   onvaluechanged="changeRed(this.value)" value="5"/>
                        </div>
                       <div class="infoLabel"><label> 到期结算金额(元):</label>
                            <input class="nui-textbox" id="enSettleAmount" vtype="float" name="enSettleAmount"
                                    enabled="false"/>
                        </div>
                        <div class="infoLabel"><label><span>*</span>清算速度: </label>
                            <input class="nui-radiobuttonlist" name="vcSettleSpeed" id="vcSettleSpeed"
                                   data="[{id: '0', text:'T+0'}, {id: '1', text: 'T+1'}]" required="true"
                                   value="0" onvaluechanged="calFirstMaturityRe()"/>
                        </div>
                        <div class="infoLabel"><label> 占款天数:</label>
                            <input class="nui-textbox" id="lContractPeriods" name="lContractPeriods"
                                   showClose="true" vtype="int" oncloseclick="onCloseClick" enabled="false"/>
                        </div>
                        <div class="infoLabel"><label> <span>*</span>回购金额(万元):</label>
                            <input class="nui-spinner" minValue="0" maxValue="999999999999" format="n4"
                                   id="enFaceAmount"
                                   name="enFaceAmount"
                                   required="true"
                                   vtype="float"
                                   onblur="calEmFaceAmount()"
                                   onvalidation="enFaceAmountValid"
                                   />
                        </div>
                        <div class="infoLabel"><label> 回购利息(元):</label>
                            <input class="nui-textbox" enabled="false" id="enRepoInterest" name="enRepoInterest"/>
                        </div>
                        <div class="infoLabel"><label><span>*</span>交易对手: </label>
                            <div name="vcCounterpartyId" class="mini-autocomplete" id="vcCounterpartyId"
                                 required="true"
                                 textField="vcName"
                                 valueField="vcRivalCode"
                                 searchField="vcPinyin"
                                 url="com.cjhxfund.ats.sm.comm.TraderivalManager.QueryTraderByPinyin.biz.ext"
                                 popupEmptyText="全部"
                                 nullItemText="全部"
                                 loadingText="加载中"
                                 valueFromSelect="true"
                                 dataField="traders"
                                 multiSelect="false"
                                 showClose="true"
                                 oncloseclick="onCloseClick"
                                 style="width:125px"
                                 popupWidth="300"
                                 onvaluechanged="setIssueOrgan">
                                <div property="columns">
                                    <div header="对手代码" field="vcRivalCode" width="20"></div>
                                    <div header="对手名称" field="vcName"></div>
                                </div>
                            </div>
                        </div>
                        <div class="infoLabel"><label> 对方交易员:</label>
                            <input class="nui-textbox" id="vcCounterpartyTrader" name="vcCounterpartyTrader"/>
                        </div>
                        <div class="infoLabel"><label> <span>*</span>报价方式:</label>
                            <input class="nui-dictcombobox" valueField="dictID" textField="dictName"
                                   onvaluechanged="changeMode"
                                   dictTypeId="quoteMode" name="vcQuoteMode" id="vcQuoteMode" showClose="true"
                                   oncloseclick="onCloseClick"
                                   required="true"/>
                        </div>
                           <div class="infoLabel"><label> 备注:</label>
                            <input class="nui-textbox" showClose="true" id="vcRemark" name="vcRemark"/>
                        </div>
                        <div class="infoLabel">
                            <label id="enRepoRateLabel"> <span>*</span>回购利率(%):</label>
                            <label id="enWeightingValueLabel" style="display:none;"> <span>*</span>加点(bp)</label>
                            <input name="enRepoRate" id="enRepoRate" class="nui-textbox" showClose="true"
                                   oncloseclick="onCloseClick" onvalidation="positiveFlo" required="true"
                                   onblur="calEmFaceAmount()"/>
                            <input name="enWeightingValue" style="display:none;" id="enWeightingValue"
                                   class="nui-textbox" showClose="true"
                                   oncloseclick="onCloseClick" required="true" vtype="float"/>

                        </div>
                        <div class="infoLabel">
                        <label id="enRepoRateLabel">对手主体机构:</label>
                        <input class="nui-textbox" showClose="true" id="vcCounterpartyOrgan" name="vcCounterpartyOrgan"/>
                        </div>  
<!--                         <div class="infoLabel"><label> 附件:</label> -->
<!--                         <input class="nui-htmlfile" limitType=""  style="width:125px;"/></div> -->
                    </div>
                </form>
                <hr style="clear:left;border:1px #cccccc dotted;"/>
                <div style="float:right;margin-bottom: 5px;margin-right:5px;">
                    <label id="symbol" style="float:left;display:none;">证券申报代码：<span></span></label>
                    <a class='nui-button' plain='false' iconCls="icon-tip" onclick="riskControlTrial()"/>风控试算</a>
                    <a class='nui-button' plain='false' iconCls="icon-ok" onclick="sendDirective()"/>指令/建议下达</a>
                    <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="resetDire()"/>重置</a>
                </div>
                </div>
                </div>
                  	<div  style="height:auto;width:865px;">
        <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                	<td style="width:80%;" align="left">
                		<span style="float:left;padding-left: 2px;">添加债券代码：</span>
                        <div name="vcStockCode" class="mini-autocomplete" id="vcStockCode"
                             textField="stockCode" valueField="vcCombiNo"
                             searchField="stockCode"
                             url=""
                             showNullItem="false"
                             allowInput="true"
                             emptyText="全部"
                             nullItemText="全部"
                             valueFromSelect="true"
                             dataField="bondList"
                             multiSelect="false"
                             showClose="true"
                             style="width:40%;float:left;margin-right: 10px;"
                             oncloseclick="onCloseClick"
                             popupWidth="300">
                            <div property="columns">
                                <div header="债券代码" field="stockCode" width="60px"></div>
                                <div header="债券名称" field="stockName"></div>
                                <div header="所在组合" field="vcCombiName"></div>
                            </div>
                        </div>
                    </td>
                    <td style="width:20%;" align="right">
                    <a class='nui-button' plain='false' onclick="showHolding()" plain="false"  iconCls="icon-search">从持仓选择</a>
                    </td>
                    </tr>
            </table>
        </div>
        <div id="bondsGrid" class="nui-datagrid" style="width:100%;height:277px;"
             datafield="mortgageInfos"
             url="com.cjhxfund.ats.sm.comm.InstructionManager.getMortgageInfos.biz.ext"
             showPager="false"
             allowSortColumn="false"
             multiSelect="true"
             allowCellSelect="true" allowCellEdit="true"
             showSummaryRow="true"
             ondrawsummarycell="onDrawSummaryCell">
            <div property="columns">
                <div name="action" headerAlign="center" align="center" renderer="onActionRenderer">操作</div>
                <div field="vcReportCode" headerAlign="center"> 债券代码</div>
                <div field="vcStockName" align="center" width="100" id="tianjia">债券名称</div>
                <div field="vcDepository" width="100" renderer="depository">托管机构</div>
                <div field="enFaceAmount" width="100" numberFormat="n2" renderer="onGenderRenderer" align="center" headerAlign="center">
                   <span style="color:red;">*</span> 券面金额（万元）
                    <input property="editor" onblur="updateFaceAmout(e)" class="mini-textbox" style="width:100%;"/>
                </div>
                <div field="enMortagageRatio" align="right" width="100"><span style="color:red;">*</span>质押比例（%）
                    <input property="editor" floatErrorText="true" onblur="updateMortagage(e)" class="mini-textbox"
                           style="width:100%;"/>
                </div>
                <div field="canRepurchaseAmount" numberFormat="n2" width="100" >
                    可做回购金额(万元)
                </div>
                <div field="enParvalue" width="100" headerAlign="center" dateFormat="yyyy-MM-dd">面值
                </div>
                <div field="enCbValueNetValue" width="100" allowSort="false" format="n4">
                    净价（T-1）
                </div>
                <div field="enCbValueAllValue" width="100" format="n4">全价(T-1)</div>
                <div field="vcBondAppraise" width="120" headerAlign="center" renderer="vcBondAppraiseRD">债项评级</div>
                <div field="vcIssueAppraise" width="100" renderer="vcIssueAppraiseRD">主体评级</div>
                <div field="vcBondAppraiseOrgan" width="100" renderer="vcBondAppraiseOrganRD">评级机构</div>
                <div field="lRatingForecast" width="100" renderer="lRatingForecastRD">评级展望</div>
            </div>
        </div>

        </div>
  </div>
	<script type="text/javascript">
    	nui.parse();
    	function showHolding(){
    		nui.open({
	    		url:"<%=request.getContextPath() %>/repurchase/investNew/interBankHolding.jsp",
	    			title:"银行间债券持仓", 
	    			width:1024,
	    			height:370,
	    			allowResize:true,
	    			onload:function(){
	    			},
	    			ondestroy:function(action){
	    				if(action == "ok"){
	    				}
	    			}
    		});	
    	}
    </script>
</body>
</html>