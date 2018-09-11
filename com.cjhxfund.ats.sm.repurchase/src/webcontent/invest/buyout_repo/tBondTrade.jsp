<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!--
  - Author(s): luojuehuai
  - Date: 2016-09-07 14:51:04
  - Description:
-->

<head>
    <title>银行间买断式回购</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <link  rel="stylesheet" type="text/css" href="<%=contextPath%>/common/css/GridDetailBlock.css"/>
    <style type="text/css">
    	.mini-buttonedit-border{
    		padding-right:1px;
    	}
        .infoLabel {
            width: 235px;
            float: left;
            height: 26px;
        }

        .infoLabel > label {
            float: left;
            text-align: right;
            width: 110px;
            display: block;
        }

        .infoLabel > label > span {
            color: red;
        }

        .infoLabel2 {
            width: 300px;
            float: left;
            height: 26px;

        }

        .infoLabel2 > label {
            float: left;
            text-align: right;
            width: 140px;
            display: block;
        }

        .arrowContainer {
            background-color: white;
            background-repeat: no-repeat;
            background-position: left;
            width: 100%;
            height: auto;
            display: block;
            float: left;
            padding-top: 5px;
        }

        .arrow {
            background: url("image/arrow_gray.png");
            width: 22px;
            height: 22px;
            cursor: pointer;
        }
        .arrowBig{
        	background: url("image/arrow_Big.png");
            width: 64px;
            height: 64px;
            cursor: pointer;
            position: absolute;
            z-index:999;
            display:none;
        }

        .arrowSelect {
            background: url("image/arrow_blue.png");
            width: 64px;
            height: 64px;
            float: left;
            cursor: pointer;
        }
        .searchBox{
        	width:100%;
        	height:24px;
        	overflow: hidden;
        	background: transparent;
        }
        .searchDiv {
        	width:270px;
        	float:left;
        	margin-bottom: 5px;
        }
        .searchDiv > label {
        	width:65px;
        	float: left;
        	text-align: right;
        	display: block;
        }
        .searchDiv > div{
        	width:270px;
        	text-align: left;
        }
        .searchButton {
            width: auto;
            clear: both;
        }
        
    </style>
</head>
<body>
<div class="arrowBig" onclick="chooseBond()"></div>
<div style="width:calc(100% - 545px);float:left;" id="amountInfo">
<div class="search-condition"  style="height:auto;">
    <div id="vunitstockCondition" class="searchBox" onmouseover="ExpandSearch()" onmouseleave="closeSearch('vunitstockCondition')">
            		<div class="searchDiv">
            			<label>产品名称:</label>
            			 <div name="fundCodeName" class="nui-combobox" pinyinField="ID" id="fundCodeName"
                            	textField="TEXT" valueField="ID"
                            	searchField="productCode"
								url="com.cjhxfund.commonUtil.applyInstUtil.QueryTAtsProductInfoMatch.biz.ext?queryType='01','02'"
								showNullItem="false"
								allowInput="true" 
								emptyText="请输入产品代码或产品名称..."
								nullItemText="请输入产品代码或产品名称..."
								valueFromSelect="true"
								showClose="true"
								onvaluechanged="selectFund"
								style="width:178px"
								oncloseclick="onCloseClick"
								popupWidth="300">
								<div property="columns">
	                                <div header="产品代码" field="ID" width="40px"></div>
	                                <div header="产品名称" field="TEXT"></div>
	                            </div>
                            </div>
            		</div>
            		
            		<div class="searchDiv">
            		<label>组合名称:</label>
            			<div>
            			<input name="vcCombiName" class="nui-combobox" id="vcCombi"
                                   textField="TEXT" valueField="ID"
                                   dataField="data"
                                   url="com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfo.biz.ext"
                                   showNullItem="false"
                                   allowInput="false"
                                   onvaluechanged="selectCombi"
                                   emptyText="全部"
                                   nullItemText="全部"
                                   showClose="true"
                                   oncloseclick="onCloseClick"
                                   style="width:178px"/>
            			</div>
            		</div>
            		<div class="searchDiv">
            		<label>托管机构:</label>
            			<div>
            			<input class="nui-combobox"
                                   id="vcPaymentPlace"
                                   name="vcPaymentPlace"
                                   textField="name"
                                   valueField="id"
                                   emptyText="全部"
                                   showClose="true"
                                   oncloseclick="onCloseClick"
                                   style="width:178px"
                            />
            			</div>
            		</div>
            		<div class="searchDiv">
            		<label>债项评级:</label>
            			<div>
            			<input class="nui-dictcombobox"
                                   id="ratingForecast"
                                   name="ratingForecast"
                                   multiSelect="true"
                                   valueField="dictName"
                                   textField="dictName"
                                   dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING"
                                   emptyText="全部"
                                   showClose="true"
                                   oncloseclick="onCloseClick"
                                   style="width:178px"/>
            			</div>
            		</div>
            		<div class="searchDiv">
            		<label>债券类型:</label>
            			<div>
            			<input id="vcStockType" 
                                   name="vcStockType" 
                                   class="nui-treeselect"  
                                   multiSelect="true"
                                   textField="text" 
                                   valueField="id" 
                                   parentField="pid" 
                                   emptyText="全部"
                                   url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext"
                                   checkRecursive="false"  
                                   showFolderCheckBox="false"
                                   showFolderCheckBox="true" 
                                   expandOnLoad="true" 
                                   showTreeIcon="false" 
                                   showClose="true"
                                   valueFromSelect="true"
                                   popupWidth="200" 
                                   oncloseclick="onCloseClick" 
                                   style="width:178px"/>
            			</div>
            		</div>
            		<div class="searchDiv">
            		<label>主体评级:</label>
            			<div>
            			<input class="nui-dictcombobox" 
                                   name="vcIssueAppraise" 
                                   id="vcIssueAppraise" 
                                   multiSelect="true"
                                   valueField="dictID" 
                                   textField="dictName" 
                                   dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING"
                                   emptyText="全部" 
                                   showClose="true" 
                                   oncloseclick="onCloseClick" 
                                   style="width:178px"/>
            			</div>
            		</div>
            		<div class="searchDiv">
            			<label>发行人性质:</label>
            			<div>
	            			<input class="nui-dictcombobox" 
	                                   name="issueProperty" 
	                                   id="issueProperty" 
	                                   multiSelect="true"
	                                   valueField="dictID" 
	                                   textField="dictName" 
	                                   dictTypeId="ATS_FM_ISSUE_PROPERTY"
	                                   emptyText="全部" 
	                                   showClose="true" 
	                                   oncloseclick="onCloseClick" 
	                                   style="width:178px"/>
            			</div>
            		</div>
            		<div class="searchDiv">
    			<label>债券代码:</label>
        			<div name="vcStockCode2" class="nui-autocomplete" id="vcStockCode2"
	                                 textField="stockCode" valueField="stockCode"
	                                 searchField="stockCode"
	                                 url="com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.queryBankBetweenBondCode.biz.ext"
	                                 allowInput="true"
	                                 emptyText="请选择..."
	                                 nullItemText="请选择..."
	                                 valueFromSelect="true"
	                                 dataField="bondList"
	                                 multiSelect="false"
	                                 style="width:178px"
	                                 popupWidth="300">
	                           		<div property="columns">
	                                    <div header="债券代码" field="stockCode" width="40px"></div>
	                                    <div header="债券名称" field="stockName"></div>
                                	</div>
                    		</div>
    		</div>
            		<div class="searchDiv">
            		<label></label>
            			<div>
            			
                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="queryVunitStock()"/>
                            <a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">重置</a>
                            <a class="nui-menubutton " plain="false" menu="#popupMenu"
                               id="searchCond"
                               name="searchCond"
                               data-options='{formId:"vunitstockCondition"}'
                               iconCls="icon-add">保存查询条件</a>
                            <ul id="popupMenu" class="mini-menu" style="display:none;width:250px;">
                            </ul>
            			</div>
            		</div>
            		<div style="width:100%;text-align: right;float:left;">
            		<img alt="收起" src="image/close.png"  onclick="closeSearch()" style="cursor:pointer;">
            		
            		</div>
            	</div>
</div>
<div id="vunitstockGrid" dataField="vunitstockList"
     url="com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.queryVunitstock.biz.ext"
     class="nui-datagrid" style="width:100%;height:265px;"
     showReloadButton = "true"
     pageSize="10"
     showPageInfo="true"
     multiSelect="true"
     allowResize="true"
     allowSortColumn="false"
     sortMode="client"
     enableHotTrack="false"
     onrowdblclick="chooseBond"
     onselectionchanged="selectOpa"
     pagerButtons="#prompt_todays"
     sizeList="[10,20,50,100]">
    <div property="columns">
        <div type="checkcolumn"></div>
<!--         <div field="vcFundName" width="120" headerAlign="center" >产品名称</div> -->
<!--         <div field="vcCombiName" width="120" headerAlign="center" >组合名称</div> -->
        <div field="vcReportCode" width="100" align="center" headerAlign="center">债券代码</div>
        <div field="vcStockName" align="center" width="100" >债券名称</div>
        <div field="vcDepository" width="100" renderer="depository">托管机构</div>
        <div field="lCurrentAmount" width="100" headerAlign="center" numberFormat="n0">持仓数量</div>
        <div field="vcAvailablequantityT0" width="100" value="-10000000000" decimalPlaces="0" numberFormat="n0">T+0可质押数量</div>
        <div field="vcAvailablequantityT1" width="100"  decimalPlaces="0" numberFormat="n0">T+1可质押数量</div>
        <div field="vcMortagageQty" width="100" numberFormat="n0">在途质押数量</div>
        <div field="lLockQty" width="100" numberFormat="n0" renderer="lLockQtyRD">锁定数量</div>
        <div field="name" width="120" headerAlign="center" >当日回转数</div>
                <div field="enCbValueNetValue" width="100" allowSort="false" format="n4">
                    净价（T-1）
                </div>
                <div field="enCbValueAllValue" width="100" format="n4">全价(T-1)</div>
        <div field="vcBondAppraise" width="120" headerAlign="center" renderer="vcBondAppraiseRD">债项评级</div>
        <div field="vcIssueAppraise" width="100" renderer="vcIssueAppraiseRD">主体评级</div>
        <div field="lRatingForecast" width="100" renderer="lRatingForecastRD">评级展望</div>
        <div field="vcBondAppraiseOrgan" width="100" renderer="vcBondAppraiseOrganRD">评级机构</div>
        <div field="lEndincalDays" width="120" headerAlign="center" renderer="calEndincalDays">剩余天数</div>
        <div field="lDelistingDate" width="120" headerAlign="center"   renderer="Delisting" >摘牌日期</div>
        <div field="vcSpecialText" width="120" headerAlign="center" >特殊条款</div>
        <div field="lNextExerciseDate" width="120" headerAlign="center"  renderer="Delisting">下一行权日</div>
        <div field="vcIssueProperty" width="120" headerAlign="center" renderer="atsFmIssueProperty">发行人性质</div>
    </div>
</div>
</div>
    <div style="width:540px;float:right;margin-top:5px;padding-right: 0;">
        <div class="nui-tabs" style="width:540px;height:auto;" activeIndex="0">
            <div title="完整指令/建议">
                <form id="fullDirection">
                    <div>
                        <div class="infoLabel"><label> <span>*</span>产品名称: </label>
                            <div name="vcProductCode" class="nui-combobox" pinyinField="ID" id="vcProductCode"
                            	textField="TEXT" valueField="ID"
                            	searchField="productCode"
								url="com.cjhxfund.commonUtil.applyInstUtil.QueryTAtsProductInfoMatch.biz.ext?queryType='01','02'"
								showNullItem="false"
								allowInput="true" 
								emptyText="请输入产品代码或产品名称..."
								nullItemText="请输入产品代码或产品名称..."
								valueFromSelect="true"
								showClose="true"
								onvaluechanged="selectFund2"
								oncloseclick="onCloseClick"
								required="true"
								popupWidth="300">
								<div property="columns">
	                                <div header="产品代码" field="ID" width="40px"></div>
	                                <div header="产品名称" field="TEXT"></div>
	                            </div>
                            </div>
                        </div>
                        <div class="infoLabel">
                            <label><span>*</span>交易日期: </label>
                            <input id="lTradeDate" allowInput="false" name="lTradeDate" required="true"
                                   onvaluechanged="calFirstMaturityRe()" class="nui-datepicker" onvalidation="lTradeDateValid"
                                   data-options='{dateType:"01"}'/>
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
                                   onvaluechanged="selectCombi2"
                                   oncloseclick="onCloseClick"
                                   required="true"
                            />
                        </div>
                        <div class="infoLabel"><label> 首期结算日:</label>
                            <input  id="lFirstSettleDate" allowInput="false" name="lFirstSettleDate"
                                   onblur="calByFirstMa()" class="nui-datepicker" required="true" 
                                   onvalidation="lFirstSettleDateValid" 
                                   data-options='{dateType:"01"}' enabled="false" />
                        </div>
                        <div class="infoLabel"><label><span>*</span>回购天数:</label>
                            <input class="nui-spinner" id="lRepoDays" required="true" name="lRepoDays"
                                   onblur="caclSymbol(true,'5','5')" maxValue="365" onvalidation="positiveNum"/>
                        </div>
                         <div class="infoLabel"><label> 到期结算日期:</label>
                            <input class="nui-datepicker" id="lMaturitySettleDate" allowInput="false"
                                   name="lMaturitySettleDate" required="true"
                                   onvalidation="setlMaturitySettleDate"  data-options='{dateType:"01"}'/>
                        </div>
                        <div class="infoLabel" id="changeInfoL" style="color:red;">
                            <label><label> *委托方向:</label></label>
                            <input class="nui-radiobuttonlist" name="vcEntrustDirection" id="vcEntrustDirection"
                                   data="[{id: '5', text:'正回购'}, {id: '6', text: '逆回购'}]" required="true"
                                   onvaluechanged="changeRed(this.value)" value="5"/>
                        </div>
                        <div class="infoLabel"><label> 占款天数:</label>
                            <input class="nui-textbox" id="lContractPeriods" name="lContractPeriods"
                                   showClose="true" vtype="int" oncloseclick="onCloseClick" enabled="false"/>
                        </div>
                        <div class="infoLabel"><label><span>*</span>清算速度: </label>
                            <input class="nui-radiobuttonlist" name="vcSettleSpeed" id="vcSettleSpeed"
                                   data="[{id: '0', text:'T+0'}, {id: '1', text: 'T+1'}]" required="true"
                                   value="0" onvaluechanged="calFirstMaturityRe()"/>
                        </div>
                        <div class="infoLabel"><label> 回购利息(元):</label>
                            <input class="nui-spinner" enabled="false" id="enRepoInterest" name="enRepoInterest"
                                   vtype="int" minValue="0" maxValue="100000000000000000000" format="n2"/>
                        </div>
                        <div class="infoLabel"><label> <span>*</span>首期结算金额(元):</label>
                            <input class="nui-spinner"
                                   id="enFullPriceAmount"
                                   name="enFullPriceAmount"
                                   required="true"
                                   vtype="double"
                                   enabled="false"
                                   onvalidation="enFaceAmountValid"
                                   minValue="0" maxValue="100000000000000000000" format="n2"
                                   />
                        </div>
                        <div class="infoLabel"><label> 到期结算金额(元):</label>
                            <input class="nui-spinner" id="enSettleAmount" vtype="float" name="enSettleAmount"
                                    enabled="false"
                                    minValue="0" maxValue="100000000000000000000" format="n2"/>
                        </div>
                        <div class="infoLabel"><label><span>*</span>交易对手: </label>
                            <div name="vcCounterpartyId" class="mini-autocomplete" id="vcCounterpartyId"
                                 required="true"
                                 textField="vcName" valueField="vcRivalCode"
                                 searchField="vcPinyin"
                                 url="com.cjhxfund.ats.sm.comm.TraderivalManager.QueryTraderByPinyin.biz.ext"
                                 popupEmptyText="全部"
                                 nullItemText="全部"
                                 loadingText="加载中"
                                 valueFromSelect="false"
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
                        <div class="infoLabel">
                            <label id="enRepoRateLabel"> <span>*</span>回购利率(%):</label>
                            <input name="enRepoRate" id="enRepoRate" class="nui-textbox" showClose="true"
                                   oncloseclick="onCloseClick" onvalidation="positiveFlo" required="true"
                                   onblur="calEmFaceAmount()"/>
                        </div>
                           <div class="infoLabel"><label> 备注:</label>
                            <input class="nui-textbox" showClose="true" id="vcRemark" name="vcRemark"/>
                        </div>
                        <div class="infoLabel">
                        <label id="enRepoRateLabel">对手主体机构:</label>
                        <input class="nui-textbox" showClose="true" id="vcCounterpartyOrgan" name="vcCounterpartyOrgan"/>
                        </div>  
                    </div>
                </form>
                <hr style="clear:left;border:1px #cccccc dotted;"/>
                <div style="float:right;margin-bottom: 5px;margin-right:5px;">
                    <label id="symbol" style="float:left;display:none;">证券申报代码：<span></span></label>
                    <a class='nui-button' plain='false' iconCls="icon-ok" onclick="sendDirective()"/>指令/建议下达</a>
                    <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="resetDire()"/>重置</a>
                </div>
            </div>
        </div>
    </div>

<div id="prompt_todays">
	<div class="arrow"></div>
</div>
        <div class="arrowContainer">
    <div>
        <div class="infoLabel2"><label> 当日正回购到期(中债)： </label>
            <input id="enGhBalanceZ" enabled="false" style="width:160px;" value="enGhBalanceZ" class="nui-spinner" minValue="-100000000000000000" maxValue="10000000000000000" format="n2"/></div>
        <div class="infoLabel2"><label> 当日正回购到期(上清)： </label>
            <input id="enGhBalanceS" enabled="false"style="width:160px;" value="enGhBalanceS" class="nui-spinner" minValue="-100000000000000000" maxValue="10000000000000000" format="n2"/></div>
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
    </div>
</div>
<div style="width:100%;">
    <div style="float:left;width:100%;">
            <div class="mini-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:30%;">
                        <span style="color: red;font-weight: 1200;font-size: 20px;margin-left: 5px;">|</span>
                        <span style="color: red;font-size: 18px;">质押券操作框</span>
                    </td>
                    <td style="width:70%;">
                        <a class='nui-button' plain='false' onclick="addBond()" iconCls="icon-add" style="float:right;">添加</a>

                        <div name="vcStockCode" class="mini-autocomplete" id="vcStockCode"
                             textField="stockCode" valueField="vcCombiNo"
                             searchField="stockCode"
                             url=""
                             showNullItem="false"
                             allowInput="true"
                             emptyText="全部"
                             nullItemText="全部"
                             valueFromSelect="false"
                             dataField="bondList"
                             multiSelect="false"
                             showClose="true"
                             style="width:60%;float:right;margin-right: 10px;"
                             oncloseclick="onCloseClick"
                             popupWidth="300">
                            <div property="columns">
                                <div header="债券代码" field="stockCode" width="40px"></div>
                                <div header="债券名称" field="stockName"></div>
                                <div header="所在组合" field="vcCombiName"></div>
                            </div>
                        </div>
                        <span style="float:right;">添加债券代码：</span>
                    </td>
                </tr>
            </table>
        </div>
            <div id="bondsGrid" class="nui-datagrid" style="width:100%;height:225px;"
             datafield="mortgageInfos"
             url="com.cjhxfund.ats.sm.comm.InstructionManager.getMortgageInfos.biz.ext"
             showPager="false"
             allowSortColumn="false"
             multiSelect="true"
             allowCellSelect="true" 
             allowCellEdit="true"
             showSummaryRow="true"
             ondrawsummarycell="onDrawSummaryCell">
            <div property="columns">
                <div name="action" headerAlign="center" align="center" renderer="onActionRenderer">操作</div>
                <div field="vcReportCode" headerAlign="center"> 债券代码</div>
                <div field="vcStockName" align="center" width="100" >债券名称</div>
                <div field="vcDepository" width="100" renderer="depository">托管机构</div>
                <div field="enFaceAmount" numberFormat="n2" width="100" renderer="onGenderRenderer" align="center" headerAlign="center">
                   <span style="color:red;">*</span> 券面金额（万元）
                    <input property="editor"  onblur="updateFaceAmout(e)" class="mini-textbox" style="width:100%;"/>
                </div>
                <div field="enNetPriceInit" renderer="priceFixed" width="100" align="center" headerAlign="center"><span style="color:red;">*</span>
                   首次净价
                    <input property="editor"  onblur="updenNetPriceInit(e)" class="mini-textbox" style="width:100%;"/>
                </div>
                <div field="enFullPriceInit" renderer="priceFixed"  width="100" align="center" headerAlign="center"><span style="color:red;">*</span>
                   首次全价
                    <input property="editor"  onblur="updenFullPriceInit(e)" class="mini-textbox" style="width:100%;"/>
                </div>    
                <div field="enNetPriceFinal" renderer="priceFixed"  width="100"  align="center" headerAlign="center"><span style="color:red;">*</span>
                   到期净价
                    <input property="editor" onblur="updenNetPriceFinal(e)"  class="mini-textbox" style="width:100%;"/>
                </div>
                <div field="enFullPriceFinal"  renderer="priceFixed" width="100"  align="center" headerAlign="center"><span style="color:red;">*</span>
                   到期全价
                   <input property="editor" onblur="updenFullPriceFinal(e)"  class="mini-textbox" style="width:100%;"/>
                </div>
                <div field="enParvalue" width="100" headerAlign="center" dateFormat="yyyy-MM-dd" >面值
                </div>
                <div field="enCbValueNetValue" width="100" allowSort="false" format="n4">净价（T-1）</div>
                <div field="enCbValueAllValue" width="100" allowSort="false" format="n4">全价(T-1)</div>
                <div field="vcBondAppraise" width="120" headerAlign="center" renderer="vcBondAppraiseRD">债项评级</div>
                <div field="vcIssueAppraise" width="100" renderer="vcIssueAppraiseRD">主体评级</div>
                <div field="vcBondAppraiseOrgan" width="100" renderer="vcBondAppraiseOrganRD">评级机构</div>
                <div field="lRatingForecast" width="100" renderer="lRatingForecastRD">评级展望</div>
            </div>
        </div>
    </div>
    </div>
<!-- 第二个table end -->
<script type="text/javascript">
    var ATS_SUCCESS = "<%= com.cjhxfund.commonUtil.Constants.ATS_SUCCESS %>";
    var ATS_ERROR = "<%= com.cjhxfund.commonUtil.Constants.ATS_ERROR %>";
    var ATS_ORDER_OVER_DEAL_TIME = "<%= com.cjhxfund.commonUtil.Constants.ATS_ORDER_OVER_DEAL_TIME %>";
   	var ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT = "<%= com.cjhxfund.commonUtil.Constants.ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT %>";
    var ATS_ORDER_NO_RCV_FR_O32 = "<%= com.cjhxfund.commonUtil.Constants.ATS_ORDER_NO_RCV_FR_O32 %>";
    var ATS_RISK_VIOLATE_FORBID_CTRL = "<%= com.cjhxfund.commonUtil.Constants.ATS_RISK_VIOLATE_FORBID_CTRL %>";
    nui.parse();
// 	$("#amountInfo .mini-buttonedit-button").remove();
</script>
<script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
<script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script>
<script type="text/javascript" src="<%=contextPath%>/repurchase/invest/buyout_repo/js/tBondTrade.js"></script>
<script type="text/javascript" src="<%=contextPath%>/repurchase/invest/repurchaseJs/repurchaseComm.js"></script>
<script type="text/javascript" src="<%=contextPath%>/common/js/GridDetailBlock.js"></script>
</body>
</html>