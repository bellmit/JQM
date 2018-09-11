<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 黄燕
  - Date: 2016-10-25 13:49:48
  - Description:
-->
<%@include file="/common/js/commscripts.jsp" %>


<head>
<title>新债信息对比</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
       <style type="text/css">
			th{
				border-right: 1px solid #D3D3D3;
				font-weight: inherit;
			}
			.nui-form-table td{
				border-right: 1px solid #D3D3D3;
			}
			.td_bottom{
			    border-bottom: 1px solid #D3D3D3;
			}
	      
	        .asLabel .mini-textbox-border,
		    .asLabel .mini-textbox-input,
		    .asLabel .mini-buttonedit-border,
		    .asLabel .mini-buttonedit-input,
		    .asLabel .mini-textboxlist-border
		    {
		        border:0;background:none;cursor:default;
		    }
		    .asLabel .mini-buttonedit-button,
		    .asLabel .mini-textboxlist-close
		    {
		        display:none;
		    }
		    .asLabel .mini-textboxlist-item
		    {
		        padding-right:8px;
		    }
		    .inputCss{
		    	color: red;
		    }
		       
	    </style>
    
</head>
<%	
	String lStockIssueId = request.getParameter("lStockIssueId");
 %>
<body style="width:100%;height:100%;overflow: hidden; margin: 0px;">

<div class="search-condition">
		  <div class="list">
            <div id="form1" class="nui-form"  align="center"  style="height:100%" >
                <table id="table1"  border="0" style="width:100%;table-layout:fixed;">
                    <tr>
                    	<td style="width:60px" align="right">
                           	    <span style="font-size:15px;font-weight:800">请选择对比条件:</span> 
                        </td>
                        <td style="width:60px" align="left">
							<input class="nui-checkbox" id="vcStockCode" oncheckedchanged="commentsChenked(this,'vcStockCodeChecked')"/>债券代码
                        </td>
                        <td style="width:75px" align="left">
							<input class="nui-checkbox" id="vcStockName" oncheckedchanged="commentsChenked(this,'vcStockNameChecked')"/>债券简称
                        </td>
                        <td style="width:55px" align="left">
							<input id="vcStockNameFull" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcStockNameFullChecked')"/>债券全称
                        </td>
                        <td style="width:70px" align="left">
							<input id="vcStocktypeName" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcStocktypeNameChecked')"/>债券类别
                        </td>
                        <td style="width:70px" align="left">
							<input id="cMarketNo" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'cMarketNoChecked')"/>交易市场
                        </td>
                        <td style="width:50px" align="left">
							<input id="lIssuePostDate" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'lIssuePostDateChecked')"/>公告日期
                        </td>
                        <td style="width:60px" align="left">
							<input id="lIssueBeginDate" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'lIssueBeginDateChecked')"/>发行日期
                        </td>
                        <td style="width:60px" align="left">
							<input id="dBidLimitTime" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'dBidLimitTimeChecked')" />投标截止日期
                        </td>
                        <td style="width:60px" align="left">
							<input id="lPayDate" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'lPayDateChecked')" />缴款日期
                        </td>
                     </tr>
                     <tr>
                        <td style="width:60px" align="right">
							<input class="nui-checkbox" id="diffChecked" oncheckedchanged="diffChecked(this)" />显示差异项
                        </td>
                     	<!-- <td style="width:60px" align="center">
							<input id="checkedAll" checked="checked" class="nui-checkbox" oncheckedchanged="allChenked(this)" />全选                           	     
                        </td> -->
                        <td style="width:60px" align="left">
							<input  checked="checked" id="enIssueBalance" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'enIssueBalanceChecked')" />发行规模(亿)
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="enExistLimite" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'enExistLimiteChecked')" />发行期限(年)
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="cInterestType" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'cInterestTypeChecked')" />利率类型
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="cPayInterestType" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'cPayInterestTypeChecked')" />付息类型
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="enPayInteval" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'enPayIntevalChecked')" />付息频率(次/年)
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="enFaceRate" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'enFaceRateChecked')" />票面利率(%)
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="cBondAppraise" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'cBondAppraiseChecked')" />债券评级
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcBondAppraiseOrgan" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcBondAppraiseOrganChecked')" />债券评级机构
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="cBidType" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'cBidTypeChecked')" />招标方式
                        </td>
                    </tr>
                    <tr>
                        <td style="width:60px" align="right">
							<input class="nui-checkbox" id="sameChecked" oncheckedchanged="sameChecked(this)" />显示相同项
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="lPublishDate" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'lPublishDateChecked')" />上市日期
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="lBegincalDate" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'lBegincalDateChecked')" />起息日期
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="lEndincalDate" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'lEndincalDateChecked')" />到期日期
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcSpecialText" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcSpecialTextChecked')" />特殊条款
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="cIssueAppraise" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'cIssueAppraiseChecked')" />主体评级
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcIssuerName" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcIssuerNameChecked')" />主体简称
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcIssueAppraiseOrgan" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcIssueAppraiseOrganChecked')" />主体评级机构
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcMainUnderwriter" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcMainUnderwriterChecked')" />主承销商
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcDeputyUnderwriter" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcDeputyUnderwriterChecked')" />副主承销商
                        </td>
                    </tr>
                    <tr>
                        <td style="width:60px" align="right">
							
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="lNextExerciseDate" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'lNextExerciseDateChecked')" />下一行权日
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcCreditAnalyze" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcCreditAnalyzeChecked')" />信用分析
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="cIsHaveBuyback" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'cIsHaveBuybackChecked')" />是否具有赎回权
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcPaymentPlace" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcPaymentPlaceChecked')" />登记托管机构
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcIssuerNameFull" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcIssuerNameFullChecked')" />发行人全称
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="cAssureType" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'cAssureTypeChecked')" />担保方式
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcIssueType" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcIssueTypeChecked')" />发行方式
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcSpecialLimite" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcSpecialLimiteChecked')" />特殊期限
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcTenderInterval" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcTenderIntervalChecked')" />投标区间
                        </td>
                    </tr>
                    <tr>
                        <td style="width:60px" align="right">
							
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcUnderwriterInfo" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcUnderwriterInfoChecked')" />承销商联系人信息
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcIssueAppraiseCsrc" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcIssueAppraiseCsrcChecked')" />所属行业(证监会二级)
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcMortStockName" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcMortStockNameChecked')" />股票名称
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcMortStockAmount" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcMortStockAmountChecked')" />股票抵押数量(万股)
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcMortStockCode" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcMortStockCodeChecked')" />股票代码
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="enIssuerNetValue" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'enIssuerNetValueChecked')" />公司净资产
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="vcCityLevel" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'vcCityLevelChecked')" />城投行政级别
                        </td>
                        <td style="width:60px" align="left">
							<input  checked="checked" id="lNInterestRateJumpPoints" class="nui-checkbox" oncheckedchanged="commentsChenked(this,'lNInterestRateJumpPointsChecked')" />下一利率跳升点数
                        </td>
                    </tr>
                </table>
            </div>
          </div>
        </div>  

<div id="dataform1" style="padding-top:5px;height:70%;width: 100%;" >	
                <table id="table2"  border="0" style="width:100%;height:50px; table-layout:fixed;">
                    <tr>
                        <td style="width:20%" align="right">
                          	<span >对比新债1:</span>
                        </td>
                        <td style="width:20%" align="left">
                             <input class="nui-buttonedit" allowInput="false" onbuttonclick="searchVcStock(1)" id="searchVcStockCode1" width="100%"/> 
                             <input  class="nui-hidden"  id="searchStockIssueId1" width="100%"/> 
                            <!-- <input id="searchVcStockCode1" required="true" width="100%"class="nui-textboxlist"  searchField="searchKey" dataField="stockIssues"
                        	valueField="vcStockCode" textField="vcStockCode" url="com.cjhxfund.ats.fm.instr.FirstGradeBond.getVcStockCode.biz.ext"  value="vcStockCode" text="vcStockCode"/> -->
                        </td>
                    	<td  style="width:10%" align="left">
					       <a id="query" class='nui-button' plain='false' iconCls="icon-search" onclick="search()">
					                        查询
					       </a>                        
					    </td>
                        <td style="width:10%" align="right">
							<span >对比新债2:</span>
		                </td>
		                <td style="width:20%" align="left">
							<input class="nui-buttonedit" allowInput="false"  onbuttonclick="searchVcStock(2)" id="searchVcStockCode2" width="100%"/>
							<input  class="nui-hidden"  id="searchStockIssueId2" width="100%"/>
                        </td>
                    	<td >
					       <a id="query" class='nui-button' plain='false' iconCls="icon-search" onclick="search()">
					                        查询
					       </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
					       <a id="query" class='nui-button' plain='false' iconCls="icon-save" onclick="submit()">
					                        去重
					       </a>                       
					    </td>
                    </tr>
                </table>
	    <div id="dataform2" style="padding-top:5px;height:100%;width: 100%;overflow-y: scroll;" >	
		<table style="width:100%;table-layout:fixed;" class="nui-form-table">
			<!-- <tr style="width: 100%">
				<th class="form_label" width="20%" align="right" style="font-size:20px;font-weight:900">对比字段</th>
				<th class="form_label" width="40%" align="left" style="font-size:20px;font-weight:900">新债1</th>
				<th class="form_label" width="40%" align="left" style="font-size:20px;font-weight:900">新债2</th>
                <td width="40%" align="center">
                	<input class="nui-textbox" value="新债1" style="width: 100%;font-size:20px;font-weight:900"/>
                </td>
                <td width="40%" align="center">
                	<input class="nui-textbox" value="新债2" style="width: 100%;font-size:20px;font-weight:900"/>
                </td>
			</tr> -->
			<tr id="vcStockCodeChecked">
            	<th class="form_label td_bottom" width="20%" align="right">
                        债券代码:
                </th>
                <td colspan="1" align="center" class="td_bottom">
                	<input class="nui-textbox"  id="vcStockCode1" name="stockissueinfo1.vcStockCode"  style="width: 100%;"/>
                </td>
                <td colspan="1" align="center" class="td_bottom">
                	<input class="nui-textbox" id="vcStockCode2" name="stockissueinfo2.vcStockCode" style="width: 100%"/>
                </td>
			</tr>
			<tr id="vcStockNameChecked">
                <th class="form_label td_bottom" width="20%" align="right">
                        债券简称:
                </th>
                <td colspan="1"  align="center" class="td_bottom">
                    <input class="nui-textbox" id="vcStockName1" name="stockissueinfo1.vcStockName" style="width: 100%"/>
                </td>
                <td colspan="1" align="center" class="td_bottom">
                    <input class="nui-textbox" id="vcStockName2" name="stockissueinfo2.vcStockName" style="width: 100%"/>
                </td>
            </tr>
            <tr id="vcStockNameFullChecked">
                <th class="form_label td_bottom" width="20%" align="right" >
                        债券全称:
                </th>
                <td colspan="1" align="center" class="td_bottom">
                    <input class="nui-textbox" id="vcStockNameFull1" name="stockissueinfo1.vcStockNameFull" style="width: 100%"/>
                    
                </td>
                <td colspan="1" align="center" class="td_bottom">
                    <input class="nui-textbox" id="vcStockNameFull2" name="stockissueinfo2.vcStockNameFull" style="width: 100%"/>
                </td>
			</tr>
			<tr id="vcStocktypeNameChecked">
                <th class="form_label td_bottom" width="20%" align="right">
                        债券类别:
                </th>
                <td colspan="1"  width="40%" align="center" class="td_bottom">
			       <!--  <input class="nui-textbox" id="vcStocktypeName1" name="stockissueinfo1.vcStocktypeName" style="width: 100%"/> -->
			        <input style="width: 100%;" id="vcStocktypeName1" name="stockissueinfo1.vcStockType" class="mini-treeselect"  multiSelect="true" 
									        textField="text" valueField="id" parentField="pid" checkRecursive="false" 
									        showFolderCheckBox="true"   expandOnLoad="true" showTreeIcon="false" />
                </td>
                <td colspan="1" width="40%" align="center" class="td_bottom">
			        <!-- <input class="nui-textbox" id="vcStocktypeName2" name="stockissueinfo2.vcStocktypeName" style="width: 100%"/> -->
			        <input style="width: 100%;" id="vcStocktypeName2" name="stockissueinfo2.vcStockType" class="mini-treeselect"  multiSelect="true" 
									        textField="text" valueField="id" parentField="pid" checkRecursive="false" 
									        showFolderCheckBox="true"   expandOnLoad="true" showTreeIcon="false" />
                </td>
            </tr>
            <tr id="cMarketNoChecked">
                <th class="form_label td_bottom" width="20%" align="right">
                        交易市场:
                </th>
                <td colspan="1" width="40%" align="center" class="td_bottom">
                    <input class="nui-dictcombobox" id="cMarketNo1" name="stockissueinfo1.cMarketNo" allowInput="true"
			  	url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryCMarket.biz.ext"  style="width: 100%" textField="TEXT" valueField="ID" readonly="readonly" showNullItem="false"  />
                </td>
                <td colspan="1" width="40%" align="center" class="td_bottom">
                    <input class="nui-dictcombobox" id="cMarketNo2" name="stockissueinfo2.cMarketNo" allowInput="true"
			  	 url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryCMarket.biz.ext"  style="width: 100%" textField="TEXT" valueField="ID" readonly="readonly" showNullItem="false"  />
                </td>
			</tr>
			<tr id="lIssuePostDateChecked" class="td_bottom">
                <th class="form_label td_bottom" width="20%" align="right">
                        公告日期:
                </th>
                <td colspan="1" width="40%" align="center" class="td_bottom">
                    <input class="nui-textbox" id="lIssuePostDate1" style="width: 100%"  name="stockissueinfo1.lIssuePostDate"/>
                </td>
                <td colspan="1" width="40%" align="center" class="td_bottom">
                    <input class="nui-textbox" id="lIssuePostDate2" style="width: 100%" name="stockissueinfo2.lIssuePostDate"/>
                </td>
            </tr>
            <tr id="lIssueBeginDateChecked">
                <th class="form_label td_bottom" width="20%" align="right">
                        发行日期:
                </th>
                <td colspan="1" width="40%" align="center" class="td_bottom">
                    <input class="nui-textbox" id="lIssueBeginDate1" style="width: 100%" name="stockissueinfo1.lIssueBeginDate"/>
                </td>
                <td colspan="1" width="40%" align="center" class="td_bottom">
                    <input class="nui-textbox" id="lIssueBeginDate2" style="width: 100%" name="stockissueinfo2.lIssueBeginDate"/>
                </td>
			</tr>
			<tr id="dBidLimitTimeChecked">
                <th class="form_label td_bottom" width="20%" align="right">
                        投标截止日期:
                </th>
                <td colspan="1" width="40%" align="center" class="td_bottom">
                    <input class="nui-textbox" id="dBidLimitTime1" style="width: 100%" format="yyyy-MM-dd H:mm:ss" name="stockissueinfo1.dBidLimitTime"/>
                </td>
                <td colspan="1" width="40%" align="center" class="td_bottom">
                    <input class="nui-textbox" id="dBidLimitTime2" style="width: 100%" format="yyyy-MM-dd H:mm:ss" name="stockissueinfo2.dBidLimitTime"/>
                </td>
            </tr>
            <tr id="lPayDateChecked">
                <th class="form_label td_bottom" width="20%" align="right">
                        缴款日期:
                </th>
                <td colspan="1" width="40%" align="center" class="td_bottom">
                    <input class="nui-textbox" id="lPayDate1" style="width: 100%" name="stockissueinfo1.lPayDate"/>
                </td>
                <td colspan="1" width="40%" align="center" class="td_bottom">
                    <input class="nui-textbox" id="lPayDate2" style="width: 100%" name="stockissueinfo2.lPayDate"/>
                </td>
			</tr>
			<tr id="lPublishDateChecked">
                <th class="form_label td_bottom" width="20%" align="right">
                        上市日期:
                </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-textbox" id="lPublishDate1" style="width: 100%" name="stockissueinfo1.lPublishDate"/>
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-textbox" id="lPublishDate2" style="width: 100%" name="stockissueinfo2.lPublishDate"/>
                    </td>
                </tr>
                <tr id="lBegincalDateChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        起息日期:
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-textbox" id="lBegincalDate1" style="width: 100%" name="stockissueinfo1.lBegincalDate"/>
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-textbox" id="lBegincalDate2" style="width: 100%" name="stockissueinfo2.lBegincalDate"/>
                    </td>
			</tr>
			<tr id="lEndincalDateChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        到期日期:
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-textbox" id="lEndincalDate1" style="width: 100%" name="stockissueinfo1.lEndincalDate"/>
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-textbox" id="lEndincalDate2" style="width: 100%" name="stockissueinfo2.lEndincalDate"/>
                    </td>
                </tr>
                <tr id="enIssueBalanceChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        发行规模(亿):
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-textbox" id="enIssueBalance1" style="width: 100%" name="stockissueinfo1.enIssueBalance"/>
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-textbox" id="enIssueBalance2" style="width: 100%" name="stockissueinfo2.enIssueBalance"/>
                    </td>
			</tr>
			<tr id="enExistLimiteChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        发行期限(年):
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-textbox" id="enExistLimite1" style="width: 100%" name="stockissueinfo1.enExistLimite"/>
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-textbox" id="enExistLimite2" style="width: 100%" name="stockissueinfo2.enExistLimite"/>
                    </td>
                </tr>
                <tr id="cInterestTypeChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        利率类型:
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-dictcombobox" dictTypeId="rateType" style="width: 100%" id="cInterestType1" name="stockissueinfo1.cInterestType" readonly="readonly"/>
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-dictcombobox" dictTypeId="rateType" style="width: 100%" id="cInterestType2" name="stockissueinfo2.cInterestType" readonly="readonly"/>
                    </td>
			</tr>
			<tr id="cPayInterestTypeChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        息票品种:
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        
                        <input class="nui-dictcombobox" dictTypeId="payInterestType" style="width: 100%" id="cPayInterestType1" name="stockissueinfo1.cPayInterestType" readonly="readonly"/>
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        
                        <input class="nui-dictcombobox" dictTypeId="payInterestType" style="width: 100%" id="cPayInterestType2" name="stockissueinfo2.cPayInterestType" readonly="readonly"/>
                    </td>
                </tr>
                <tr id="enPayIntevalChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        付息频率(次/年):
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-dictcombobox" width="100%" readonly="readonly" id="enPayInteval1"  name="stockissueinfo1.enPayInteval" dictTypeId="ATS_CF_JY_FREQUENCY"/>
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-dictcombobox" width="100%" readonly="readonly" id="enPayInteval2"  name="stockissueinfo2.enPayInteval" dictTypeId="ATS_CF_JY_FREQUENCY"/>
                    </td>
			</tr>
			<tr id="enFaceRateChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        票面利率(%):
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-textbox" name="stockissueinfo1.enFaceRate" style="width: 100%" id="enFaceRate1" readonly="readonly" />
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-textbox" name="stockissueinfo2.enFaceRate" style="width: 100%" id="enFaceRate2" readonly="readonly" />
                    </td>
                </tr>
                <tr id="cBondAppraiseChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        债券评级:
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        
                        <input class="nui-dictcombobox" name="stockissueinfo1.cBondAppraise" style="width: 100%" id="cBondAppraise1" readonly="readonly"  dictTypeId="creditRating" />
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        
                        <input class="nui-dictcombobox" name="stockissueinfo2.cBondAppraise" style="width: 100%" id="cBondAppraise2" readonly="readonly"  dictTypeId="creditRating" />
                    </td>
			</tr>
			<tr id="vcBondAppraiseOrganChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        债券评级机构:
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-dictcombobox" id="vcBondAppraiseOrgan1" style="width: 100%" name="stockissueinfo1.vcBondAppraiseOrgan" readonly="readonly" dictTypeId="outRatingOrgan" />
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-dictcombobox" id="vcBondAppraiseOrgan2" style="width: 100%" name="stockissueinfo2.vcBondAppraiseOrgan" readonly="readonly" dictTypeId="outRatingOrgan" />
                    </td>
                </tr>
                <tr id="cBidTypeChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        招标方式:
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-dictcombobox" name="stockissueinfo1.cBidType" style="width: 100%" id="cBidType1" readonly="readonly" dictTypeId="tenderType" />
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-dictcombobox" name="stockissueinfo2.cBidType" style="width: 100%" id="cBidType2" readonly="readonly" dictTypeId="tenderType" />
                    </td>
			</tr>
			<tr id="vcIssuerNameChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        主体简称:
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-textbox" id="vcIssuerName1" style="width: 100%" name="stockissueinfo1.vcIssuerName"/>
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-textbox" id="vcIssuerName2" style="width: 100%" name="stockissueinfo2.vcIssuerName"/>
                    </td>
                </tr>
                <tr id="vcSpecialTextChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        特殊条款:
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        
                        <input class="nui-dictcombobox" dictTypeId="specialText" id="vcSpecialText1" style="width: 100%" name="stockissueinfo1.vcSpecialText"/>
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">       
                        <input class="nui-dictcombobox" dictTypeId="specialText" id="vcSpecialText2" style="width: 100%" name="stockissueinfo2.vcSpecialText"/>
                    </td>
                </tr>
                <tr id="cIssueAppraiseChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        主体评级:
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-dictcombobox" id="cIssueAppraise1" style="width: 100%" name="stockissueinfo1.cIssueAppraise" dictTypeId="issuerRating" />
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">
                        <input class="nui-dictcombobox" id="cIssueAppraise2" style="width: 100%" name="stockissueinfo2.cIssueAppraise" dictTypeId="issuerRating" />
                    </td>
			</tr>
			<tr id="vcIssueAppraiseOrganChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        主体评级机构:
                    </th>
                    <td colspan="1" width="40%" align="center" class="td_bottom">                       
                        <input class="nui-dictcombobox" id="vcIssueAppraiseOrgan1" style="width: 100%" name="stockissueinfo1.vcIssueAppraiseOrgan" dictTypeId="outRatingOrgan" />                       
                    </td>
                    <td colspan="1" width="40%" align="center" class="td_bottom">                       
                        <input class="nui-dictcombobox" id="vcIssueAppraiseOrgan2" style="width: 100%" name="stockissueinfo2.vcIssueAppraiseOrgan" dictTypeId="outRatingOrgan" />                       
                    </td>
                </tr>
                <tr id="vcMainUnderwriterChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        主承销商:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-textbox" id="vcMainUnderwriter1" style="width: 100%" name="stockissueinfo1.vcMainUnderwriter"/>
                    </td>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-textbox" id="vcMainUnderwriter2" style="width: 100%" name="stockissueinfo2.vcMainUnderwriter"/>
                    </td>
			</tr>
			<tr id="vcDeputyUnderwriterChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        副主承销商:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-textbox" id="vcDeputyUnderwriter1" style="width: 100%" name="stockissueinfo1.vcDeputyUnderwriter"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-textbox" id="vcDeputyUnderwriter2" style="width: 100%" name="stockissueinfo2.vcDeputyUnderwriter"/>
                    </td>
                </tr>
			<tr id="lNextExerciseDateChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        下一行权日:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-textbox" id="lNextExerciseDate1" style="width: 100%" name="stockissueinfo1.lNextExerciseDate"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-textbox" id="lNextExerciseDate2" style="width: 100%" name="stockissueinfo2.lNextExerciseDate"/>
                    </td>
                </tr>
			<tr id="vcCreditAnalyzeChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        信用分析:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-textbox" id="vcCreditAnalyze1" style="width: 100%" name="stockissueinfo1.vcCreditAnalyze"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-textbox" id="vcCreditAnalyze2" style="width: 100%" name="stockissueinfo2.vcCreditAnalyze"/>
                    </td>
                </tr>
			<tr id="cIsHaveBuybackChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        是否具有赎回权:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="mini-combobox"  data="[{ id: 1, text: '是' }, { id: 0, text: '否'}]" id="cIsHaveBuyback1" style="width: 100%" name="stockissueinfo1.cIsHaveBuyback"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="mini-combobox"  data="[{ id: 1, text: '是' }, { id: 0, text: '否'}]" id="cIsHaveBuyback2" style="width: 100%" name="stockissueinfo2.cIsHaveBuyback"/>
                    </td>
                </tr>
			<tr id="vcPaymentPlaceChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        登记托管机构:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" id="vcPaymentPlace1" style="width: 100%" name="stockissueinfo1.vcPaymentPlace"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" id="vcPaymentPlace2" style="width: 100%" name="stockissueinfo2.vcPaymentPlace"/>
                    </td>
                </tr>
			<tr id="vcIssuerNameFullChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        发行人全称:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-textbox" id="vcIssuerNameFull1" style="width: 100%" name="stockissueinfo1.vcIssuerNameFull"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-textbox" id="vcIssuerNameFull2" style="width: 100%" name="stockissueinfo2.vcIssuerNameFull"/>
                    </td>
                </tr>
			<tr id="cAssureTypeChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        担保方式:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-dictcombobox" dictTypeId="ATS_FM_ASSUER_TYPE" id="cAssureType1" style="width: 100%" name="stockissueinfo1.cAssureType"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-dictcombobox" dictTypeId="ATS_FM_ASSUER_TYPE" id="cAssureType2" style="width: 100%" name="stockissueinfo2.cAssureType"/>
                    </td>
                </tr>
			<tr id="vcIssueTypeChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        发行方式:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-dictcombobox" dictTypeId="issueType" id="vcIssueType1" style="width: 100%" name="stockissueinfo1.vcIssueType"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-dictcombobox" dictTypeId="issueType" id="vcIssueType2" style="width: 100%" name="stockissueinfo2.vcIssueType"/>
                    </td>
                </tr>
			<tr id="vcSpecialLimiteChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        特殊期限:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-textbox" id="vcSpecialLimite1" style="width: 100%" name="stockissueinfo1.vcSpecialLimite"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-textbox" id="vcSpecialLimite2" style="width: 100%" name="stockissueinfo2.vcSpecialLimite"/>
                    </td>
                </tr>
			<tr id="vcTenderIntervalChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        投标区间:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-textbox" id="vcTenderInterval1" style="width: 100%" name="stockissueinfo1.vcTenderInterval"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-textbox" id="vcTenderInterval2" style="width: 100%" name="stockissueinfo2.vcTenderInterval"/>
                    </td>
                </tr>
			<tr id="vcUnderwriterInfoChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        承销商联系人信息:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-textbox" id="vcUnderwriterInfo1" style="width: 100%" name="stockissueinfo1.vcUnderwriterInfo"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-textbox" id="vcUnderwriterInfo2" style="width: 100%" name="stockissueinfo2.vcUnderwriterInfo"/>
                    </td>
                </tr>
			<tr id="vcIssueAppraiseCsrcChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        所属行业(证监会二级):
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input style="width: 100%;" id="vcIssueAppraiseCsrc1" name="stockissueinfo1.vcIssueAppraiseCsrc" class="mini-treeselect"  multiSelect="false" 
										        textField="text" valueField="id" parentField="pid" checkRecursive="false"  
										        expandOnLoad="true" showTreeIcon="false" showFolderCheckBox="true" allowInput="true"
										        oncloseclick="onCloseClickValueEmpty" onvalidation="onComboValidation"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input style="width: 100%;" id="vcIssueAppraiseCsrc2" name="stockissueinfo2.vcIssueAppraiseCsrc" class="mini-treeselect"  multiSelect="false" 
										        textField="text" valueField="id" parentField="pid" checkRecursive="false"  
										        expandOnLoad="true" showTreeIcon="false" showFolderCheckBox="true" allowInput="true"
										        oncloseclick="onCloseClickValueEmpty" onvalidation="onComboValidation"/>
                    </td>
                </tr>
			<tr id="vcMortStockNameChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        股票名称:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-textbox" id="vcMortStockName1" style="width: 100%" name="stockissueinfo1.vcMortStockName"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-textbox" id="vcMortStockName2" style="width: 100%" name="stockissueinfo2.vcMortStockName"/>
                    </td>
                </tr>
			<tr id="vcMortStockAmountChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        股票抵押数量(万股):
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-textbox" id="vcMortStockAmount1" style="width: 100%" name="stockissueinfo1.vcMortStockAmount"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-textbox" id="vcMortStockAmount2" style="width: 100%" name="stockissueinfo2.vcMortStockAmount"/>
                    </td>
                </tr>
			<tr id="vcMortStockCodeChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        股票代码:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-textbox" id="vcMortStockCode1" style="width: 100%" name="stockissueinfo1.vcMortStockCode"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-textbox" id="vcMortStockCode2" style="width: 100%" name="stockissueinfo2.vcMortStockCode"/>
                    </td>
                </tr>
			<tr id="enIssuerNetValueChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        公司净资产(元):
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-textbox" id="enIssuerNetValue1" style="width: 100%" name="stockissueinfo1.enIssuerNetValue"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-textbox" id="enIssuerNetValue2" style="width: 100%" name="stockissueinfo2.enIssuerNetValue"/>
                    </td>
                </tr>
			<tr id="vcCityLevelChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        城投行政级别:
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-dictcombobox" dictTypeId="cityLevel" id="vcCityLevel1" style="width: 100%" name="stockissueinfo1.vcCityLevel"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-dictcombobox" dictTypeId="cityLevel" id="vcCityLevel2" style="width: 100%" name="stockissueinfo2.vcCityLevel"/>
                    </td>
                </tr>
			<tr id="lNInterestRateJumpPointsChecked">
                    <th class="form_label td_bottom" width="20%" align="right">
                        下一利率跳升点数(BP):
                    </th>
                    <td colspan="1" class="td_bottom" width="40%" align="center">
                        <input class="nui-textbox" id="lNInterestRateJumpPoints1" style="width: 100%" name="stockissueinfo1.lNInterestRateJumpPoints"/>
                    </td>
                    <td colspan="1" class="td_bottom"  width="40%" align="center">
                        <input class="nui-textbox" id="lNInterestRateJumpPoints2" style="width: 100%" name="stockissueinfo2.lNInterestRateJumpPoints"/>
                    </td>
                </tr>
				           
              </table>
            </div>
  </div>


	<script type="text/javascript">
    	nui.parse();
    	var lStockIssueId = '<%=lStockIssueId %>';
    	var form = new nui.Form("#dataform2");//将普通form转为nui的form
		var arrayList = ['vcStockCode','vcStockName','vcStockNameFull','vcStocktypeName','cMarketNo','lIssuePostDate','lIssueBeginDate','dBidLimitTime','lPayDate','lPublishDate','lBegincalDate','lEndincalDate','enIssueBalance','enExistLimite','cInterestType','cPayInterestType','enPayInteval','enFaceRate','cBondAppraise','vcBondAppraiseOrgan','cBidType','vcIssuerName',
		'vcSpecialText','cIssueAppraise','vcIssueAppraiseOrgan','vcMainUnderwriter','vcDeputyUnderwriter','lNextExerciseDate','vcCreditAnalyze','cIsHaveBuyback','vcPaymentPlace','vcIssuerNameFull','cAssureType','vcIssueType','vcSpecialLimite','vcTenderInterval','vcUnderwriterInfo','vcIssueAppraiseCsrc','vcMortStockName','vcMortStockAmount','vcMortStockCode','enIssuerNetValue','vcCityLevel','lNInterestRateJumpPoints'];
    	//form.load();
    	loadStockTypeAll();
    	var rows ="";
         //加载所有的债券信息
         function loadStockTypeAll(){
         	nui.ajax({
			    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext",
			    type: "post",
			    dataType:"json",
			    success: function (text) {
			    	nui.get("vcStocktypeName1").loadList(text.data);
			    	nui.get("vcStocktypeName2").loadList(text.data);
			    }
			});
         	
         }
         //加载所属行业的证监会二级
        loadVcIssueAppraiseCsrcAll();
	     function loadVcIssueAppraiseCsrcAll(){
	     	nui.ajax({//com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc
			    url: "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc.biz.ext",
			    type: "post",
			    data:nui.encode({type:"1"}),
			    contentType:'text/json',
			    success: function (text) {
			    	nui.get("vcIssueAppraiseCsrc1").loadList(text.data);
			    	nui.get("vcIssueAppraiseCsrc2").loadList(text.data);
			    }
			});
	     }
    	var fields = form.getFields();                
       for (var i = 0, l = fields.length; i < l; i++) {
			var c = fields[i];
			if (c.setReadOnly) c.setReadOnly(true);     //只读
			if (c.setIsValid) c.setIsValid(true);      //去除错误提示
			if (c.addCls) c.addCls("asLabel");          //增加asLabel外观
		}
		var form1 = new nui.Form("#form1");
    	var fieldsCheck = form1.getFields();
		var searchVcStockCode1="";
		var searchVcStockCode2="";
		function search(){
			var searchStockIssueId1 = nui.get("searchStockIssueId1").value;
			var searchStockIssueId2 = nui.get("searchStockIssueId2").value;
			var issueId = searchStockIssueId1+","+searchStockIssueId2;
			init(nui.encode({lStockIssueId : issueId}));
		}
		//{stockissueinfo1:[0],stockissueinfo2:[1]}
		init(nui.encode({lStockIssueId : lStockIssueId}));
		function init(json){
			$.ajax({
				    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryStockIssueCompare.biz.ext",
				    type: "post",
				    data:json,
				    cache: false,
            		contentType:'text/json',
				    success: function (text) {
				    	var returnJson ={stockissueinfo1:null,stockissueinfo2:null};
				    	$("#dataform1").find("input").css("color","");
				    	if(text.stockIssueData.length==1){
			    			returnJson = {stockissueinfo1:text.stockIssueData[0],stockissueinfo2:null};
				    		returnJson.stockissueinfo1.lIssuePostDate=dateTemp(returnJson.stockissueinfo1.lIssuePostDate);
							returnJson.stockissueinfo1.lIssueBeginDate=dateTemp(returnJson.stockissueinfo1.lIssueBeginDate);
							returnJson.stockissueinfo1.lPayDate=dateTemp(returnJson.stockissueinfo1.lPayDate);
							returnJson.stockissueinfo1.lPublishDate=dateTemp(returnJson.stockissueinfo1.lPublishDate);
							returnJson.stockissueinfo1.lBegincalDate=dateTemp(returnJson.stockissueinfo1.lBegincalDate);
							returnJson.stockissueinfo1.lPublishDate=dateTemp(returnJson.stockissueinfo1.lPublishDate);
							returnJson.stockissueinfo1.lEndincalDate=dateTemp(returnJson.stockissueinfo1.lEndincalDate);
							returnJson.stockissueinfo1.lNextExerciseDate=dateTemp(returnJson.stockissueinfo1.lNextExerciseDate);
							returnJson.stockissueinfo1.dBidLimitTime=dateTempDBid(returnJson.stockissueinfo1.dBidLimitTime);//dateTempDBid
							nui.get("searchVcStockCode1").setValue(returnJson.stockissueinfo1.vcStockCode);
							nui.get("searchVcStockCode1").setText(returnJson.stockissueinfo1.vcStockCode);
							nui.get("searchStockIssueId1").setValue(returnJson.stockissueinfo1.lStockIssueId);
							
							 if((searchVcStockCode1 == searchVcStockCode2)){//档两个查询框里的债券代码一样的时候
								returnJson = {stockissueinfo1:text.stockIssueData[0],stockissueinfo2:text.stockIssueData[0]};
								returnJson.stockissueinfo1.lIssuePostDate=dateTemp(returnJson.stockissueinfo1.lIssuePostDate);
								returnJson.stockissueinfo1.lIssueBeginDate=dateTemp(returnJson.stockissueinfo1.lIssueBeginDate);
								returnJson.stockissueinfo1.lPayDate=dateTemp(returnJson.stockissueinfo1.lPayDate);
								returnJson.stockissueinfo1.lPublishDate=dateTemp(returnJson.stockissueinfo1.lPublishDate);
								returnJson.stockissueinfo1.lBegincalDate=dateTemp(returnJson.stockissueinfo1.lBegincalDate);
								returnJson.stockissueinfo1.lPublishDate=dateTemp(returnJson.stockissueinfo1.lPublishDate);
								returnJson.stockissueinfo1.lEndincalDate=dateTemp(returnJson.stockissueinfo1.lEndincalDate);
								returnJson.stockissueinfo1.lNextExerciseDate=dateTemp(returnJson.stockissueinfo1.lNextExerciseDate);
								returnJson.stockissueinfo1.dBidLimitTime=dateTempDBid(returnJson.stockissueinfo1.dBidLimitTime);
						    	returnJson.stockissueinfo2.lIssuePostDate=dateTemp(returnJson.stockissueinfo2.lIssuePostDate);
								returnJson.stockissueinfo2.lIssueBeginDate=dateTemp(returnJson.stockissueinfo2.lIssueBeginDate);
								returnJson.stockissueinfo2.lPayDate=dateTemp(returnJson.stockissueinfo2.lPayDate);
								returnJson.stockissueinfo2.lPublishDate=dateTemp(returnJson.stockissueinfo2.lPublishDate);
								returnJson.stockissueinfo2.lBegincalDate=dateTemp(returnJson.stockissueinfo2.lBegincalDate);
								returnJson.stockissueinfo2.lPublishDate=dateTemp(returnJson.stockissueinfo2.lPublishDate);
								returnJson.stockissueinfo2.lEndincalDate=dateTemp(returnJson.stockissueinfo2.lEndincalDate);
								returnJson.stockissueinfo2.lNextExerciseDate=dateTemp(returnJson.stockissueinfo2.lNextExerciseDate);
								returnJson.stockissueinfo2.dBidLimitTime=dateTempDBid(returnJson.stockissueinfo2.dBidLimitTime);
								
								nui.get("searchVcStockCode1").setValue(returnJson.stockissueinfo1.vcStockCode);
								nui.get("searchVcStockCode1").setText(returnJson.stockissueinfo1.vcStockCode);
								nui.get("searchVcStockCode2").setValue(returnJson.stockissueinfo2.vcStockCode);
								nui.get("searchVcStockCode2").setText(returnJson.stockissueinfo2.vcStockCode);
								nui.get("searchStockIssueId1").setValue(returnJson.stockissueinfo1.lStockIssueId);
								nui.get("searchStockIssueId2").setValue(returnJson.stockissueinfo2.lStockIssueId);
							} 
				    	}else if(text.stockIssueData.length>=2){
				    		if(nui.get("searchStockIssueId1").value==text.stockIssueData[0].lStockIssueId){
				    			returnJson = {stockissueinfo1:text.stockIssueData[0],stockissueinfo2:text.stockIssueData[1]};
				    		}else{
				    			returnJson = {stockissueinfo1:text.stockIssueData[1],stockissueinfo2:text.stockIssueData[0]};
				    		}
					    	returnJson.stockissueinfo1.lIssuePostDate=dateTemp(returnJson.stockissueinfo1.lIssuePostDate);
							returnJson.stockissueinfo1.lIssueBeginDate=dateTemp(returnJson.stockissueinfo1.lIssueBeginDate);
							returnJson.stockissueinfo1.lPayDate=dateTemp(returnJson.stockissueinfo1.lPayDate);
							returnJson.stockissueinfo1.lPublishDate=dateTemp(returnJson.stockissueinfo1.lPublishDate);
							returnJson.stockissueinfo1.lBegincalDate=dateTemp(returnJson.stockissueinfo1.lBegincalDate);
							returnJson.stockissueinfo1.lPublishDate=dateTemp(returnJson.stockissueinfo1.lPublishDate);
							returnJson.stockissueinfo1.lEndincalDate=dateTemp(returnJson.stockissueinfo1.lEndincalDate);
							returnJson.stockissueinfo1.lNextExerciseDate=dateTemp(returnJson.stockissueinfo1.lNextExerciseDate);
							returnJson.stockissueinfo1.dBidLimitTime=dateTempDBid(returnJson.stockissueinfo1.dBidLimitTime);
					    	returnJson.stockissueinfo2.lIssuePostDate=dateTemp(returnJson.stockissueinfo2.lIssuePostDate);
							returnJson.stockissueinfo2.lIssueBeginDate=dateTemp(returnJson.stockissueinfo2.lIssueBeginDate);
							returnJson.stockissueinfo2.lPayDate=dateTemp(returnJson.stockissueinfo2.lPayDate);
							returnJson.stockissueinfo2.lPublishDate=dateTemp(returnJson.stockissueinfo2.lPublishDate);
							returnJson.stockissueinfo2.lBegincalDate=dateTemp(returnJson.stockissueinfo2.lBegincalDate);
							returnJson.stockissueinfo2.lPublishDate=dateTemp(returnJson.stockissueinfo2.lPublishDate);
							returnJson.stockissueinfo2.lEndincalDate=dateTemp(returnJson.stockissueinfo2.lEndincalDate);
							returnJson.stockissueinfo2.lNextExerciseDate=dateTemp(returnJson.stockissueinfo2.lNextExerciseDate);
							returnJson.stockissueinfo2.dBidLimitTime=dateTempDBid(returnJson.stockissueinfo2.dBidLimitTime);
							setColor(returnJson);
							nui.get("searchVcStockCode1").setValue(returnJson.stockissueinfo1.vcStockCode);
							nui.get("searchVcStockCode2").setValue(returnJson.stockissueinfo2.vcStockCode);
							nui.get("searchVcStockCode1").setText(returnJson.stockissueinfo1.vcStockCode);
							nui.get("searchVcStockCode2").setText(returnJson.stockissueinfo2.vcStockCode);
							nui.get("searchStockIssueId1").setValue(returnJson.stockissueinfo1.lStockIssueId);
							nui.get("searchStockIssueId2").setValue(returnJson.stockissueinfo2.lStockIssueId);
				    	}
				    	rows=returnJson;
				    	form.setData(returnJson);
				    	form.setChanged(false);
				    	//处理付息频率，值满足数据字典则直接显示数据字典中对应值，否则直接显示值
						if(nui.get("enPayInteval1").getText()=="" || nui.get("enPayInteval1").getText()==null){
							nui.get("enPayInteval1").setText(returnJson.stockissueinfo1==null?"":returnJson.stockissueinfo1.enPayInteval);
						}
						if(nui.get("enPayInteval2").getText()=="" || nui.get("enPayInteval2").getText()==null){
							nui.get("enPayInteval2").setText(returnJson.stockissueinfo2==null?"":returnJson.stockissueinfo2.enPayInteval);
						} 
				    }
				});
		}
		
		function setColor(returnJson){
			if(returnJson.stockissueinfo1.vcStockCode!=returnJson.stockissueinfo2.vcStockCode){
				setInputColor("vcStockCode");
			} 
			if(returnJson.stockissueinfo1.vcStockName!=returnJson.stockissueinfo2.vcStockName){
				setInputColor("vcStockName");
			}
			if(returnJson.stockissueinfo1.vcStockNameFull!=returnJson.stockissueinfo2.vcStockNameFull){
				setInputColor("vcStockNameFull");
			}
			if(returnJson.stockissueinfo1.vcStockType!=returnJson.stockissueinfo2.vcStockType){
				setInputColor("vcStocktypeName");
			}
			if(returnJson.stockissueinfo1.cMarketNo!=returnJson.stockissueinfo2.cMarketNo){
				setInputColor("cMarketNo");
			}
			if(returnJson.stockissueinfo1.lIssuePostDate!=returnJson.stockissueinfo2.lIssuePostDate){
				setInputColor("lIssuePostDate");
			}
			if(returnJson.stockissueinfo1.lIssueBeginDate!=returnJson.stockissueinfo2.lIssueBeginDate){
				setInputColor("lIssueBeginDate");
			}
			if(returnJson.stockissueinfo1.dBidLimitTime!=returnJson.stockissueinfo2.dBidLimitTime){
				setInputColor("dBidLimitTime");
			}
			if(returnJson.stockissueinfo1.lPayDate!=returnJson.stockissueinfo2.lPayDate){
				setInputColor("lPayDate");
			}
			if(returnJson.stockissueinfo1.lPublishDate!=returnJson.stockissueinfo2.lPublishDate){
				setInputColor("lPublishDate");
			}
			if(returnJson.stockissueinfo1.lBegincalDate!=returnJson.stockissueinfo2.lBegincalDate){
				setInputColor("lBegincalDate");
			}
			if(returnJson.stockissueinfo1.lEndincalDate!=returnJson.stockissueinfo2.lEndincalDate){
				setInputColor("lEndincalDate");
			}
			if(returnJson.stockissueinfo1.enIssueBalance!=returnJson.stockissueinfo2.enIssueBalance){
				setInputColor("enIssueBalance");
			}
			if(returnJson.stockissueinfo1.enExistLimite!=returnJson.stockissueinfo2.enExistLimite){
				setInputColor("enExistLimite");
			}
			if(returnJson.stockissueinfo1.cInterestType!=returnJson.stockissueinfo2.cInterestType){
				setInputColor("cInterestType");
			}
			if(returnJson.stockissueinfo1.cPayInterestType!=returnJson.stockissueinfo2.cPayInterestType){
				setInputColor("cPayInterestType");
			}
			if(returnJson.stockissueinfo1.enPayInteval!=returnJson.stockissueinfo2.enPayInteval){
				setInputColor("enPayInteval");
			}
			if(returnJson.stockissueinfo1.enFaceRate!=returnJson.stockissueinfo2.enFaceRate){
				setInputColor("enFaceRate");
			}
			if(returnJson.stockissueinfo1.cBondAppraise!=returnJson.stockissueinfo2.cBondAppraise){
				setInputColor("cBondAppraise");
			}
			if(returnJson.stockissueinfo1.vcBondAppraiseOrgan!=returnJson.stockissueinfo2.vcBondAppraiseOrgan){
				setInputColor("vcBondAppraiseOrgan");
			}
			if(returnJson.stockissueinfo1.cBidType!=returnJson.stockissueinfo2.cBidType){
				setInputColor("cBidType");
			}
			if(returnJson.stockissueinfo1.vcIssuerName!=returnJson.stockissueinfo2.vcIssuerName){
				setInputColor("vcIssuerName");
			}
			if(returnJson.stockissueinfo1.vcSpecialText!=returnJson.stockissueinfo2.vcSpecialText){
				setInputColor("vcSpecialText");
			}
			if(returnJson.stockissueinfo1.cIssueAppraise!=returnJson.stockissueinfo2.cIssueAppraise){
				setInputColor("cIssueAppraise");
			}
			if(returnJson.stockissueinfo1.vcIssueAppraiseOrgan!=returnJson.stockissueinfo2.vcIssueAppraiseOrgan){
				setInputColor("vcIssueAppraiseOrgan");
			}
			if(returnJson.stockissueinfo1.vcMainUnderwriter!=returnJson.stockissueinfo2.vcMainUnderwriter){
				setInputColor("vcMainUnderwriter");
			}
			if(returnJson.stockissueinfo1.vcDeputyUnderwriter!=returnJson.stockissueinfo2.vcDeputyUnderwriter){
				setInputColor("vcDeputyUnderwriter");
			}
			if(returnJson.stockissueinfo1.lNextExerciseDate!=returnJson.stockissueinfo2.lNextExerciseDate){
				setInputColor("lNextExerciseDate");
			}
			if(returnJson.stockissueinfo1.vcCreditAnalyze!=returnJson.stockissueinfo2.vcCreditAnalyze){
				setInputColor("vcCreditAnalyze");
			}
			if(returnJson.stockissueinfo1.cIsHaveBuyback!=returnJson.stockissueinfo2.cIsHaveBuyback){
				setInputColor("cIsHaveBuyback");
			}
			if(returnJson.stockissueinfo1.vcPaymentPlace!=returnJson.stockissueinfo2.vcPaymentPlace){
				setInputColor("vcPaymentPlace");
			}
			if(returnJson.stockissueinfo1.vcIssuerNameFull!=returnJson.stockissueinfo2.vcIssuerNameFull){
				setInputColor("vcIssuerNameFull");
			}
			if(returnJson.stockissueinfo1.cAssureType!=returnJson.stockissueinfo2.cAssureType){
				setInputColor("cAssureType");
			}
			if(returnJson.stockissueinfo1.vcIssueType!=returnJson.stockissueinfo2.vcIssueType){
				setInputColor("vcIssueType");
			}
			if(returnJson.stockissueinfo1.vcSpecialLimite!=returnJson.stockissueinfo2.vcSpecialLimite){
				setInputColor("vcSpecialLimite");
			}
			if(returnJson.stockissueinfo1.vcTenderInterval!=returnJson.stockissueinfo2.vcTenderInterval){
				setInputColor("vcTenderInterval");
			}
			if(returnJson.stockissueinfo1.vcUnderwriterInfo!=returnJson.stockissueinfo2.vcUnderwriterInfo){
				setInputColor("vcUnderwriterInfo");
			}
			if(returnJson.stockissueinfo1.vcIssueAppraiseCsrc!=returnJson.stockissueinfo2.vcIssueAppraiseCsrc){
				setInputColor("vcIssueAppraiseCsrc");
			}
			if(returnJson.stockissueinfo1.vcMortStockName!=returnJson.stockissueinfo2.vcMortStockName){
				setInputColor("vcMortStockName");
			}
			if(returnJson.stockissueinfo1.vcIssuerName!=returnJson.stockissueinfo2.vcIssuerName){
				setInputColor("vcIssuerName");
			}
			if(returnJson.stockissueinfo1.vcMortStockAmount!=returnJson.stockissueinfo2.vcMortStockAmount){
				setInputColor("vcMortStockAmount");
			}
			if(returnJson.stockissueinfo1.vcMortStockCode!=returnJson.stockissueinfo2.vcMortStockCode){
				setInputColor("vcMortStockCode");
			}
			if(returnJson.stockissueinfo1.enIssuerNetValue!=returnJson.stockissueinfo2.enIssuerNetValue){
				setInputColor("enIssuerNetValue");
			}
			if(returnJson.stockissueinfo1.vcCityLevel!=returnJson.stockissueinfo2.vcCityLevel){
				setInputColor("vcCityLevel");
			}
			if(returnJson.stockissueinfo1.lNInterestRateJumpPoints!=returnJson.stockissueinfo2.lNInterestRateJumpPoints){
				setInputColor("lNInterestRateJumpPoints");
			}
			
		}
		//时间转换
    	function dateTemp(oldData){
    		oldData=oldData+"";
    		if(oldData==0 || oldData=="" || oldData=="null"){
    			return "";
    		}
    		var datas=oldData.indexOf("-");
    		if(datas>=0){
    			return oldData;
    		}
    		var yy=oldData.substr(0,4);//0开始，截取后面4位
    		var mm=oldData.substr(4,2);//4开始，截取后面2位
    		var dd=oldData.substr(6,2);
    		return yy+"-"+mm+"-"+dd;
    	}
    	//投标截止时间转换
    	function dateTempDBid(oldData){
    		oldData=oldData+"";
    		if(oldData==0 || oldData=="" || oldData=="null"){
    			return "";
    		}else{
    			return oldData.substr(0,19);
    		}
    	}
		function commentsChenked(e,value){
			if(!e.checked || e.checked=="false"){
				e.checked=false;
				document.getElementById(value).style.display = "none";	
			}else{
				e.checked=true;
				document.getElementById(value).style.display = "";
			}
		}
		var form1 = new nui.Form("#form1");
    	var fieldsCheck = form1.getFields();
		for(var b=0;b<arrayList.length;b++){
			nui.get(arrayList[b]).setChecked(true);//初始化单选框都勾上
		}
		function allChenked(e){//全选
			if(e.checked){
				for(var a=0;a<arrayList.length;a++){
					nui.get(arrayList[a]).setChecked(true);
					document.getElementById(arrayList[a]+"Checked").style.display = "";
				}
			}else{
				for(var a=0;a<arrayList.length;a++){
					nui.get(arrayList[a]).setChecked(false);
					document.getElementById(arrayList[a]+"Checked").style.display = "none";
				}
			}						
		}               
       
		
		function setInputColor(id){
			$("#"+id+"1").find("input").css("color","red");
			$("#"+id+"2").find("input").css("color","red");
		}
		
		
		function checkBox(e){
			nui.get(e).setChecked(true);
		}
		function noCheckBox(e){
			nui.get(e).setChecked(false);
		}
		function diffChecked(e){
			
			if(e.checked){//仅显示差异
				if($("#sameChecked").find("input").prop("checked")==true){//如果仅显示相同勾上                         $("#sameChecked").find("input").prop("checked")
					allChenked(e);
				}else{
					for(var i=0;i<arrayList.length;i++){
						var vcStockCode1 = nui.get(arrayList[i]+"1").value;
						var vcStockCode2 = nui.get(arrayList[i]+"2").value;
						if(vcStockCode1!=vcStockCode2){
							checkBox(arrayList[i]);
							document.getElementById(arrayList[i]+"Checked").style.display = "";
							setInputColor(arrayList[i]);
						}else{
							noCheckBox(arrayList[i]);
							document.getElementById(arrayList[i]+"Checked").style.display = "none";
						}
					}
				}
			}else{
				if($("#sameChecked").find("input").prop("checked")==true){//显示差异没选中，显示相同选中
					for(var c=0;c<arrayList.length;c++){
						var vcStockCode1 = nui.get(arrayList[c]+"1").value;
						var vcStockCode2 = nui.get(arrayList[c]+"2").value;
						if(vcStockCode1==vcStockCode2){
							document.getElementById(arrayList[c]+"Checked").style.display = "";
							checkBox(arrayList[c]);
						}else{
							document.getElementById(arrayList[c]+"Checked").style.display = "none";
							noCheckBox(arrayList[c]);
							setInputColor(arrayList[c]);
						}
					}
				}else{//显示差异没选中，显示相同没选中
					for(var d=0;d<arrayList.length;d++){
						nui.get(arrayList[d]).setChecked(false);//初始化单选框都勾上
						document.getElementById(arrayList[d]+"Checked").style.display = "none";
					}
					
				}
			}
		}
		function sameChecked(e){
			if(e.checked){//仅显示相同
				if($("#diffChecked").find("input").prop("checked")==true){//如果仅显示相同勾上
					allChenked(e);
				}else{
					for(var j=0;j<arrayList.length;j++){
						var vcStockCode1 = nui.get(arrayList[j]+"1").value;
						var vcStockCode2 = nui.get(arrayList[j]+"2").value;
						if(vcStockCode1==vcStockCode2){
							document.getElementById(arrayList[j]+"Checked").style.display = "";
							checkBox(arrayList[j]);
						}else{
							document.getElementById(arrayList[j]+"Checked").style.display = "none";
							noCheckBox(arrayList[j]);
							setInputColor(arrayList[j]);
						}
					}
				}
			}else{
				
				if($("#diffChecked").find("input").prop("checked")==true){
					for(var i=0;i<arrayList.length;i++){
						var vcStockCode1 = nui.get(arrayList[i]+"1").value;
						var vcStockCode2 = nui.get(arrayList[i]+"2").value;
						if(vcStockCode1!=vcStockCode2){
							checkBox(arrayList[i]);
							document.getElementById(arrayList[i]+"Checked").style.display = "";
							setInputColor(arrayList[i]);
						}else{
							noCheckBox(arrayList[i]);
							document.getElementById(arrayList[i]+"Checked").style.display = "none";
						}
					}
				}else{
					for(var d=0;d<arrayList.length;d++){
						nui.get(arrayList[d]).setChecked(false);//初始化单选框都勾上
						document.getElementById(arrayList[d]+"Checked").style.display = "none";
					}
				}
			}
		}
		function searchVcStock(e){
		        nui.open({
		            url: "<%=request.getContextPath() %>/fm/instr/firstGradeDebt/stockIssueList.jsp",
		            title: "债券列表",
		            width: 450,
		            height: 380,
		            onload:function(){
		                
		            },
		            ondestroy: function (action) {
		                if (action != "cancel" && action != "close") {
		                    var strs= new Array();
		                    strs = action.split("|");
		                    if(strs.length>0){
		                    	if(e==1){
		                    		nui.get("searchVcStockCode1").setValue(strs[0]);
		                    		nui.get("searchVcStockCode1").setText(strs[0]);
		                    		nui.get("searchStockIssueId1").setValue(strs[1]);
		                    	}else{
		                    		nui.get("searchVcStockCode2").setValue(strs[0]);
		                    		nui.get("searchVcStockCode2").setText(strs[0]);
		                    		nui.get("searchStockIssueId2").setValue(strs[1]);
		                    	}
		                    }
		                    
		                }
		            }
		        });
			}
			
			
			function submit(){
			
			if(rows.length<2){
				nui.alert("请选择大于一条数据记录！");
			}else{
				if(nui.get("searchStockIssueId1").value==nui.get("searchStockIssueId2").value){
					nui.alert("两条数据一样，没办法去重，请重新选择!");
					return;
				}
				
				var arr = [];
				arr.add(rows.stockissueinfo1);
				arr.add(rows.stockissueinfo2);
				nui.open({
				  url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueMergeChoose.jsp",
				                title: "选择目标债券", width: 400, height: 210,
				  onload: function () {
				    var  iframe = this.getIFrameEl();
				    iframe.contentWindow.SetData(arr);
				  },
				  ondestroy: function (action) {
				  	if (!!window.ActiveXObject || "ActiveXObject" in window){//如果是IE浏览器
		              	 window.opener.history.go(0);
		              }else{
		              	 window.opener.reloadData();
		              }
		              CloseWindow("confirmSuccess");
				  }
				});
			}
		}
		
		 //关闭窗口
		    function CloseWindow(action) {
		       if(action=="close" && form.isChanged()){
		      	if(confirm("数据已改变,确认退出?")){
		           deleteFilePreparation();
		           /* window.opener.location.reloadData();
		           return window.CloseOwnerWindow(action); */
		           return CloseWindow("cance");/* window.close();// */
		        }else{
		           return false;
		        }
		      }else if(window.CloseOwnerWindow) {
		      	window.opener.location.reloadData();
		      	return window.CloseOwnerWindow(action);
		      } else{
		      	//window.opener.reloadData();
		      	return window.close();
		      }
		    }
    </script>
</body>
</html>