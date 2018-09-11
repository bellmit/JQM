<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 石浩
  - Date: 2016-08-23 16:33:01
  - Description:
-->
<head>
<title>已办任务查看</title>
    <style type="text/css">
      .td1{
        border-right: 1px solid #D3D3D3;
        border-left: 1px solid #D3D3D3;
      }
      .td2{
        border-right: 1px solid #D3D3D3;
      }
      .asLabel .mini-textbox-input{
        color: red;
        background:none;cursor:default;
      }
      .asLabel_gray .mini-textbox-input{
         color: black;
         background:none;cursor:default;
      }
      
      .p{
           border-bottom: 1px solid #D3D3D3;     
        }
        P{
          margin: 0px;padding: 0px;
        }
        
    </style>
</head>

<%
    Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
    String pid = (String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"processInstID");
    String workItemID =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workItemID");
    String bizId = (String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"bizId");
    String investNo = (String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"investNo");
 %>
<body style="width:100%;height:100%;margin:0px;">

   <div id="tabs" class="nui-tabs" height="100%">
   		<div title="基本信息">
		  	<div id="dataform1" style="padding-top:5px;">
              	<input class="nui-hidden" name="debtIssue.lOperatorNo"  />
              
	            <!-- hidden域 -->
	            <input class="nui-hidden" id="lStockIssueId"  name="debtIssue.lStockIssueId" />
	            <input class="nui-hidden" id="lBizId" name="debtIssue.lBizId"/>
	            <input class="nui-hidden" id="cStatus" name="debtIssue.cStatus"/>
	            <input class="nui-hidden" id="cSource" name="debtIssue.cSource"/>
	            <input class="nui-hidden" id="lStockInvestNo" name="debtIssue.lStockInvestNo"/>
	            <input class="nui-hidden" id="lValidStatus" name="debtIssue.lValidStatus"/>
	            <input class="nui-hidden" id="vcInterCode" name="debtIssue.vcInterCode"/>
	            <input class="nui-hidden" id="lDate" name="debtIssue.lDate"/>
	            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
	                <tr>
	                    <td class="form_label" width="20%" align="right">
	                        	登记托管机构:
	                    </td>
	                    <td colspan="1" width="30%" >
								<input class="nui-dictcombobox" 
	                        data="[{id:'01',text:'中央结算公司'}, {id:'02', text: '上海清算所'},{id:'03', text: '上交所'},{id:'04', text: '深交所'}, {id:'99', text: '其他'}]" 
	                          name="debtIssue.vcPaymentPlace" textField="text" valueField="id" readonly="true"
	                         id="vcPaymentPlace" width="90%" />
	                    </td>
	                    <td class="form_label" align="right" width="15%">
	                        	利率类型:
	                    </td>
	                    <td colspan="1" width="30%" >
	                    	 <input class="nui-dictcombobox" readonly="true" dictTypeId="rateType" width="90%" id="cInterestType" name="debtIssue.cInterestType"  />
	                    </td>
	                </tr>
	                <tr>
	                   <td class="form_label" align="right">
	                       	 债券类别:
	                  </td>
	                  <td colspan="1">
	                  	 <!--  <input class="nui-combobox"  readonly="true" width="90%" id="vcStockType" name="debtIssue.vcStockType"  textField="vcStocktypeName" valueField="cStockType"
	                     	     dataField="stockTypes"/> -->
	                     <input style="width: 90%;" id="vcStockType" readonly="true" name="debtIssue.vcStockType" class="mini-treeselect"  multiSelect="false" 
										        textField="text" valueField="id" parentField="pid" checkRecursive="false" 
										        url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext" emptyText="全部" nullItemText="全部"
										        showFolderCheckBox="true"   expandOnLoad="true" showTreeIcon="false" showClose="true"  showFolderCheckBox="false"
										        popupWidth="200" oncloseclick="onCloseClickValueEmpty" />
	                  </td>
	                  <td class="form_label" width="25%" align="right">
	                        	息票品种:
	                  </td>
	                  <td colspan="1" width="25%">
	                   	<input class="nui-dictcombobox" readonly="true" dictTypeId="payInterestType" width="90%" id="cPayInterestType" name="debtIssue.cPayInterestType"/>
	                  </td>
	                </tr>
	                <tr>
	                   <td class="form_label" align="right">
	                       	 债券代码:
	                    </td>
	                    <td colspan="1">
	                    		<input class="nui-textbox" readonly="true" id="vcStockCode"  width="90%" name="debtIssue.vcStockCode"/>
	                    </td>
	                    <td class="form_label" align="right">
	                        	付息频率(次/年):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" readonly="true" dictTypeId="ATS_CF_JY_FREQUENCY"  width="90%" id="enPayInteval" name="debtIssue.enPayInteval" onvaluechanged="checkCPayInterestType"/>
	                        <!-- <input class="nui-textbox" readonly="true"  id="enPayInteval"  width="90%" name="debtIssue.enPayInteval"/> -->
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                       	 债券简称:
	                    </td>
	                    <td colspan="1">
	                    		<input class="nui-textbox" readonly="true" id="vcStockName"  width="90%" name="debtIssue.vcStockName"/>
	                    </td>
	                    <td class="form_label" align="right">
	                        	债券评级:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" readonly="true" dictTypeId="creditRating"  id="cBondAppraise"  width="90%" name="debtIssue.cBondAppraise"/>
	                    </td>
	                </tr>
	                <tr>
	                     <td class="form_label" align="right">
	                        	债券全称:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-textbox" id="vcStockNameFull" readonly="true" width="90%" name="debtIssue.vcStockNameFull"  />
	                    </td>
	                    <td class="form_label" align="right">
	                       	 债券评级机构:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" readonly="true" dictTypeId="outRatingOrgan"  width="90%" id="vcBondAppraiseOrgan" name="debtIssue.vcBondAppraiseOrgan" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
	                    </td>
	                </tr>
	                <tr id="tr1">
	                   <td class="form_label" align="right">
	                        	发行规模:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox"  readonly="true" name="debtIssue.enIssueBalance" id="enIssueBalance" width="90%"  />
	                    </td>
	                     <td class="form_label" align="right">
	                        	发行期限(年):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox"  readonly="true" name="debtIssue.enExistLimite" id="enExistLimite"  width="90%" />
	                    </td>
	                </tr>
	                <tr  id="morStockNameAndCode">
	                    <td class="form_label  lableReq" align="right">
	                          股票名称:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="debtIssue.vcMortStockName" readonly="true" id="vcMortStockName" width="90%" />
	                    </td>	                    
	                    <td class="form_label  lableReq" align="right">
	                          股票抵押数量(万股):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="debtIssue.vcMortStockAmount" readonly="true" id="vcMortStockAmount" width="90%" />
	                    </td>
	                </tr>
	                <tr  id="morStockAmount">
	                    <td class="form_label   lableReq" align="right">
	                         股票代码:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="debtIssue.vcMortStockCode" readonly="true" id="vcMortStockCode" width="90%" />
	                    </td>	                    
	                    
	                </tr>
	                 <tr id="tr1">
	                   <td class="form_label" align="right">
	                        	发行规模描述:
	                    </td>
	                    <td colspan="3">
	                    	<input class="nui-textarea" id="vcExistLimiteDesc" name="debtIssue.vcExistLimiteDesc" width="96%" readonly="true"/>
	                    </td>
	                </tr>
	                 
	                <tr>
	                    <td class="form_label" align="right">
	                       	 公告日:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-datepicker"  name="lIssuePostDate" id="lIssuePostDate" style="width: 90%;"  readonly="true"/>
	                    </td>
	                    <td class="form_label" align="right">
	                                                                                    主体简称:
	                    </td>
	                    <td colspan="1">
	                    	 <input class="nui-textbox"  id="vcIssuerName" readonly="true"  width="90%" name="debtIssue.vcIssuerName"/>
	                    </td>
	                </tr>
	                
	                 <tr>
	                    <td class="form_label" align="right">
	                       	 发行日:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-datepicker" name="lIssueBeginDate" id="lIssueBeginDate" style="width: 90%;"  readonly="true"/>
	                    </td>
	                    <td class="form_label" align="right">
	                                                                                    主体全称:
	                    </td>
	                    <td colspan="1">
	                    	 <input class="nui-textbox"  id="vcIssuerNameFull"  name="debtIssue.vcIssuerNameFull" readonly="true"  width="90%" />
	                    </td>
	                </tr>
	                
	                <tr>
	                 	<td class="form_label" align="right">
	                       	 上市日期:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-datepicker" name="lPublishDate" id="lPublishDate" style="width: 90%;"  readonly="true"/>
	                    </td>
	                     <td class="form_label" align="right">
	                                                                                    主体评级:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-dictcombobox" readonly="true"   dictTypeId="issuerRating" width="90%" id="cIssueAppraise"  name="debtIssue.cIssueAppraise" showNullItem="false"/>
	                    </td>
	                 </tr>
	                 
	                 <tr>
	                 	<td class="form_label" align="right">
	                       	 起息日期:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-datepicker" name="lBegincalDate" id="lBegincalDate" style="width: 90%;"  readonly="true"/>
	                    </td>
	                    <td class="form_label" align="right">
	                                                                                    主体类型:
	                    </td>
	                    <td colspan="1">
	                    	<input  class="nui-dictcombobox" readonly="true"   dictTypeId="ATS_FM_ISSUE_PROPERTY" width="90%" id="vcIssueProperty" value="" name="debtIssue.vcIssueProperty" showNullItem="false"/>
	                    </td>
	                </tr>
	                
	                <tr>
	                	<td class="form_label" align="right">
	                       	 到期日期:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-datepicker" name="lEndincalDate" id="lEndincalDate" style="width: 90%;" readonly="true" />
	                    </td>
	                    <td class="form_label" align="right">
	                                                                                    主体评级机构:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" readonly="true"  dictTypeId="outRatingOrgan" width="90%" id="vcIssueAppraiseOrgan" name="debtIssue.vcIssueAppraiseOrgan" showNullItem="false"/>
	                    </td>
	                </tr>
	                
	                <tr>
	                	<td class="form_label" align="right">
	                       	 缴款日期:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-datepicker" name="lPayDate" id="lPayDate" style="width: 90%;"  readonly="true"/>
	                    </td>
	                      <td class="form_label" align="right">
	                                                                                    所属行业:
	                    </td>
	                    <td colspan="1">
	                     	<!-- <input class="nui-textbox"  id="vcIndustry"  width="90%" name="debtIssue.vcIndustry" readonly="true" /> -->
	                     	<input style="width: 90%;" id="vcIndustry" name="debtIssue.vcIndustry" class="mini-treeselect"  multiSelect="false" 
										        textField="text" valueField="id" parentField="pid" checkRecursive="false" virtualScroll="true" 
										        expandOnLoad="true" showTreeIcon="false" showFolderCheckBox="true" allowInput="true" readonly="true" 
										        onvalidation="onComboValidation"/>
	                    </td>
	                </tr>
	                 <tr>
	                    <td class="form_label" align="right">
	                       	 发行方式:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-dictcombobox" dictTypeId="issueType" name="debtIssue.vcIssueType" readonly="true" id="vcIssueType" style="width: 90%;"  />
	                    </td>
	                    <td class="form_label" align="right">
	                       	 所属省份:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-textbox"  id="vcProvince" width="90%" readonly="true"  name="debtIssue.vcProvince"/>
	                    </td>
	                </tr>
	                
	                <tr>
	                    <td class="form_label" align="right">
	                       	 所属行业(证监会二级):
	                    </td>
	                    <td colspan="1"> 
	                        <!-- <input class="nui-textbox"  id="vcIssueAppraiseCsrc" width="90%" readonly="true" name="debtIssue.vcIssueAppraiseCsrc"/> -->
	                        <input style="width: 90%;" id="vcIssueAppraiseCsrc" name="debtIssue.vcIssueAppraiseCsrc" class="mini-treeselect"  multiSelect="false" 
										        textField="text" valueField="id" parentField="pid" checkRecursive="false"  readonly="true" virtualScroll="true"
										        expandOnLoad="true" showTreeIcon="false" showFolderCheckBox="true" allowInput="true"
										        oncloseclick="onCloseClickValueEmpty" onvalidation="onComboValidation"/>
	                    </td>
	                    <td class="form_label" align="right">
	                       	 城投行政级别:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-dictcombobox" dictTypeId="cityLevel" id="vcCityLevel" width="90%" readonly="true" name="debtIssue.vcCityLevel"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                       	 下一利率跳升点数(BP):
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-textbox" onblur="check(this)" id="lNInterestRateJumpPoints" width="90%" readonly="true" name="debtIssue.lNInterestRateJumpPoints"/>
	                    </td>
	                    <td class="form_label" align="right">
	                       	 公司净资产(元):
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-textbox"  vtype="float" onblur="check(this)" readonly="true" id="enIssuerNetValue" width="90%"  name="debtIssue.enIssuerNetValue"/>
	                    </td>
	                </tr>
	                <tr>
	                     <td class="form_label" align="right">
	                                                                                    主承销商:
	                    </td>
	                    <td colspan="3">
	                    	  <input class="nui-textbox"  id="vcMainUnderwriter" readonly="true"  width="96%" name="debtIssue.vcMainUnderwriter"/>
	                    	 <!-- <input  id="vcMainUnderwriter" readonly="true" width="90%" class="nui-autocomplete" popupWidth="300" popupHeight="200" name="debtIssue.vcMainUnderwriter" searchField="name" dataField="issueInfos"
	                        	valueField="vcIssueName" onvaluechanged="enterSumbit" textField="vcIssueName" url="com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.getIssueinfos.biz.ext"   enterQuery="false" onitemclick="issueInfoOnItemClick"/> -->
	                    </td>
	                </tr>
	                 <tr>
	                     <td class="form_label" align="right">
	                                                                                    副主承销商:
	                    </td>
	                    <td colspan="3">
	                    	 <input class="nui-textbox"  id="vcDeputyUnderwriter" readonly="true"  width="96%" name="debtIssue.vcDeputyUnderwriter"/>
	                    	 <!-- <input  id="vcDeputyUnderwriter"  width="90%" class="nui-autocomplete" popupWidth="300" popupHeight="200" 
	                    	 	name="debtIssue.vcDeputyUnderwriter" searchField="name" dataField="issueInfos"
	                        	valueField="vcIssueName" onvaluechanged="enterSumbit" textField="vcIssueName" 
	                        	url="com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.getIssueinfos.biz.ext"  
	                        	value="" text="" enterQuery="false" readonly="true"/> -->
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                       	 缴款方式:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-dictcombobox" readonly="true" dictTypeId="ATS_FM_PAYMENT" width="90%" id="cPayType" name="debtIssue.cPayType" showNullItem="false"/>
	                    </td>
	                     <td class="form_label" align="right">
	                                                                                    承销方式:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox"  readonly="true" dictTypeId="underwriteType" width="90%" id="cUnderwriteType" name="debtIssue.cUnderwriteType" showNullItem="false"/>
	                    </td>
	                </tr>
	                <tr>
	                	<td class="form_label" align="right">
	                       	投标截止时间:
	                    </td>
	                    <td colspan="1"> 
	                    	<input class="nui-datepicker" name="debtIssue.dBidLimitTime"  readonly="true" id="dBidLimitTime" style="width: 100px;"  />
	                    	<input style="width: 40px;" readonly="true" url="<%=request.getContextPath() %>/fm/instr/processUtil/timeHH.txt" class="nui-dictcombobox" id="dApplicationTimeHH" />时
			    			<input style="width: 40px;" readonly="true" url="<%=request.getContextPath() %>/fm/instr/processUtil/timeMM.txt" class="nui-dictcombobox" id="dApplicationTimeMM" />分
	                    </td>
	                	<td class="form_label" align="right">
	                                                                                    投标区间:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="debtIssue.vcTenderInterval" readonly="true" id="vcTenderInterval" width="90%" />
	                    </td>
	                </tr>
	                <tr id="tr1">
	                   <td class="form_label" align="right">
	                        	发行日期描述:
	                    </td>
	                    <td colspan="3">
	                    	<input class="nui-textarea" id="vcIssueBeginDateDesc" name="debtIssue.vcIssueBeginDateDesc" width="96%" readonly="true"/>
	                    </td>
	                </tr>
	                <tr id="tr1">
	                   <td class="form_label" align="right">
	                        	承销商联系人信息:
	                    </td>
	                    <td colspan="3">
	                    	<input class="nui-textarea" id="vcUnderwriterInfo" name="debtIssue.vcUnderwriterInfo" width="96%" readonly="true"/>
	                    </td>
	                </tr>
	                <tr>
	                <td class="form_label" align="right">
	                                                                                    承销团:
	                    </td>
	                     <td colspan="3">
	                    	<!-- <input class="nui-textarea"  name="debtIssue.vcGroupUnderwriter"  id="vcGroupUnderwriter" width="87%" readonly="true"/> -->
	                    	<input class="nui-textbox"  id="vcGroupUnderwriter" readonly="true"  width="96%" name="debtIssue.vcGroupUnderwriter"/>
	                    </td>
	                </tr>
	                <tr>
	                <td class="form_label" align="right">
	                        	特殊条款:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-dictcombobox" dictTypeId="specialText" multiSelect="true" readonly="true" width="90%" id="vcSpecialText" name="debtIssue.vcSpecialText" />
	                    </td>
	               </tr>
	                 <tr id="tr1">
	                   <td class="form_label" align="right">
	                        	特殊条款说明:
	                    </td>
	                    <td colspan="3">
	                    	<input class="nui-textarea" id="vcSpecialTextDesc" readonly="true"  name="debtIssue.vcSpecialTextDesc" width="96%"/>
	                    </td>
	                </tr>
	                
	                 <tr>
	                  	<td class="form_label" align="right">
	                                                                                    票面利率(%):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" readonly="true" vtype="float" name="debtIssue.enFaceRate" id="enFaceRate" width="90%" />
	                    </td>
	                   
	                  	 <td class="form_label" align="right">
	                                                                                    招标方式:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" readonly="true" dictTypeId="tenderType" width="90%" id="cBidType" name="debtIssue.cBidType"  showNullItem="false"/>
	                    </td>
	                </tr>
	                 <tr>
	                  	<td class="form_label" align="right">
	                       	 担保人:
	                    </td>
	                    <td colspan="1"> 
	                    	<!-- <input  id="lGuarantorId"  width="90%" class="nui-autocomplete" popupWidth="300" popupHeight="200" name="debtIssue.lGuarantorId" searchField="name" dataField="issueInfos"
	                        	readonly="true" valueField="lIssuerId" onvaluechanged="enterSumbit" textField="vcIssueName" url="com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.getIssueinfos.biz.ext"  enterQuery="false" onitemclick="guarantorOnItemClick"/> -->
	                    	<!--  -->
	                    	<input class="nui-textbox" id="vcGuarantorName" readonly="true"  width="90%"  name="debtIssue.vcGuarantorName"/>
	                    </td>
	                  	 <td class="form_label" align="right">
	                                                                                    担保方式:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" readonly="true" dictTypeId="ATS_FM_ASSUER_TYPE" width="90%" id="cAssuerType" name="debtIssue.cAssureType"  showNullItem="false"/>
	                    </td>
	                   
	                </tr>
	                <tr>
	                 <td class="form_label" align="right">
	                                                                                    担保人简介:
	                    </td>
	                    <td colspan="3">
	                    	<input class="nui-textarea" readonly="true" name="debtIssue.vcGuarantorSummary"  id="vcGuarantorSummary" width="96%"/>
	                    </td>
	                </tr>
	                
	                <tr>
	                    <td class="form_label" align="right">
	                       	 下一行权日:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-datepicker" name="lNextExerciseDate" id="lNextExerciseDate" style="width: 90%;" readonly="true" />
	                    </td>
	                    <td class="form_label" align="right">
	                                                                                    特殊期限:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="debtIssue.vcSpecialLimite" readonly="true" id="vcSpecialLimite" width="90%" />
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                         是否具有赎回权:
	                    </td>
	                    <td colspan="1" class="radio-border-top-none">
							<input id="cIsHaveBuyback" readonly="true" name="debtIssue.cIsHaveBuyback" value="0" class="nui-radiobuttonlist" data="[{id: 1, text: '是'}, {id: 0, text: '否'}]"/>
	                    </td>
	                    <td class="form_label" align="right">
	                       	 是否具有回售权:
	                    </td>
	                    <td colspan="1" class="radio-border-top-none"> 
	                    	<input id="cIsHaveSaleback" readonly="true" name="debtIssue.cIsHaveSaleback" class="nui-radiobuttonlist" data="[{id: 1, text: '是'}, {id: 0, text: '否'}]"/>
	                    </td>
	                </tr>
	                <tr> 
		                 <td class="form_label" align="right">
		                                                                                    募集说明书:
		                 </td>
		                 <td colspan="3" class="td">
							<iframe id="prodIfm1" width="590"  height="110px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" 
							 	src="<%=request.getContextPath() %>/fm/baseinfo/fileupload/any_upload.jsp?attachType=2&attachBusType=1&type=1" >
							 </iframe>
						 </td>
	               </tr>
	               
	               <tr> 
		                 <td class="form_label" align="right">
		                                                                                    信用评级报告:
		                 </td>
		                 <td colspan="3" class="td">
							<iframe id="prodIfm2" width="590"  height="110px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" 
							 	src="<%=request.getContextPath() %>/fm/baseinfo/fileupload/any_upload.jsp?attachType=2&attachBusType=2&type=1" >
							 </iframe>
						 </td>
	               </tr>
	               <tr> 
		                 <td class="form_label" align="right">
		                                                                                      债券发行公告:
		                 </td>
		                 <td colspan="3" class="td">
							<iframe id="prodIfm3" width="590"  height="110px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" 
							 	src="<%=request.getContextPath() %>/fm/baseinfo/fileupload/any_upload.jsp?attachType=2&attachBusType=3&type=1" >
							 </iframe>
						 </td>
	               </tr>
	            </table>
	        </div>
		</div>
   		<div title="审批内容">
   		  <div id="dataform2" style="padding-top:5px;">
   			<table style="width:100%;table-layout:fixed;" border="0" class="nui-form-table">
   			 
		     <tr>
		        
		         <td colspan="1" class="td1">主题: </td>
		         <td colspan="3" class="td2"><div id="themeOfWork"></div><input class="nui-hidden" id="activityDefID"  value=<b:write property="workitem/ACTIVITYDEFID" /> /></td>
		     </tr>
		       <tr>
		         <td class="td1" width="20%">
		         	  当前节点:    
		         </td>
		         <td colspan="3" class="td2"><b:write property="workitem/WORKITEMNAME" /></td>
		         
		       </tr>
		       <tr>
		         <td class="td1" width="20%">上一节点参与者：</td>
		         <td colspan="1" class="td2" width="30%"><b:write property="lastActor" /></td>
		         <td class="td2" width="20%">当前节点参与者：</td>
		         <td class="td2" colspan="1">  <b:write property="nextActor" /></td>
		       </tr>         
	            <l:iterate property="approveInfos" id="approveInfo">
					<tr>
					   <td class="td1">审批意见：</td>
					   <td colspan="2" class="td2"><b:write iterateId="approveInfo" property="vcUserName"/>:<b:write iterateId="approveInfo" property="vcWorkItemName"/>,<b:write iterateId="approveInfo" property="vcComments"/></td>
					   <td class="td1">	<input class="nui-hidden" id="vcOper" iterateId="approveInfo"  value=<b:write property="vcOperateType" /> /> 
					  
		         </td>
					</tr>
				</l:iterate>
				<tr>
				 <td  colspan="4" class="td1"  align="right">
	                   <span style="display:inline-block;width:15px;"></span>
	                   <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow('close')">
	                                                                         返回
	                   </a>
		         </td>      
				</tr>
		     </table>
		    </div>
   		</div>
		<div title="流程信息" url="com.cjhxfund.ats.fm.comm.processGraph.flow?processInstID=<%=pid %>&workItemID="+<%=workItemID %> ></div>
		
		<div id="mergeDet" title="去重明细信息" url="<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/mergeDetail.jsp?processInstID=<%=pid %>"></div>
   </div>

	<script type="text/javascript">
    	nui.parse();
    	var context = '<%=request.getContextPath() %>';
    	var pid= '<%=pid %>';
    	var investNo = '<%=investNo %>';
    	var form = new nui.Form("dataform1");
    	var form2 = new nui.Form("dataform2");
    	initForm();
    	var vcIssueAppraiseCsrc = "";
		var vcIndustry = "";
    	//loadActivities();
    	//初始化表单数据
    	function initForm(){
    	    var json = nui.encode({pid:pid,invest:investNo});
	    	$.ajax({
					url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.getDebtIssueByProcessInstId.biz.ext",
					type:'POST',
					data:json,
					cache:false,
					contentType:'text/json',
					success:function(text){
						var returnJson = nui.decode(text);
						var data = returnJson.debtIssue;
						if(data.cIsHaveSaleback!='1') data.cIsHaveSaleback=0;
		            	 if(data.cIsHaveBuyback!='1') data.cIsHaveBuyback=0;
						form.setData({debtIssue:data});
						//initStockType(data); //初始化债券类型
						loadStockTypeAll(data.vcStockType);
						vcIssueAppraiseCsrc = returnJson.vcIssueAppraiseCsrc;
						nui.get("vcIssueAppraiseCsrc").loadList(vcIssueAppraiseCsrc);
			    		nui.get("vcIssueAppraiseCsrc").setValue(data.vcIssueAppraiseCsrc);
			    		vcIndustry = returnJson.vcIndustry;
			    		nui.get("vcIndustry").loadList(vcIndustry);
			    		nui.get("vcIndustry").setValue(data.vcIndustry);
            			changeDate(data); //转换日期类型
            			//nui.get("lIssuerId").setValue(data.lIssuerId);
            	 		//issueInfoOnItemClick();
            	 		//showIssuerName(data);
            	 		var activityDefID = nui.get("activityDefID").value;
            	 		if(activityDefID=='ATS_FM_JYY1FH' || activityDefID=='JYY2FH' || activityDefID=='ATS_FM_XZLR'){//不是去重的时候，把去重明细信息tab页移除
				       		nui.get("tabs").removeTab(3);
				       } 
            	 		showFile(data);
            	 		initApproveContext(data);
						form.setChanged(false);
						//处理付息频率，值满足数据字典则直接显示数据字典中对应值，否则直接显示值
						if(nui.get("enPayInteval").getText()=="" || nui.get("enPayInteval").getText()==null){
							nui.get("enPayInteval").setText(data.enPayInteval);
						}
						//手工新增债券时如果是可交换债还需要录入  抵押股票代码、抵押股票数量
				    	if(data.vcStockType=="Q" || data.vcStockType=="O"){
				    		$("#morStockNameAndCode").show();
					        $("#morStockAmount").show();
				    	}else{
				    		$("#morStockNameAndCode").hide();
					        $("#morStockAmount").hide();
				    	}
					}
				});	
		}
		
		/* //初始化债券类型
        	function initStockType(data){
        		 var cMarketNo = data.cMarketNo;
            	 var type = data.vcStockType;
            	 var vcStockType = nui.get("vcStockType");
	             var json = nui.encode({id:cMarketNo});
	             $.ajax({
					url:"com.cjhxfund.ats.fm.baseinfo.stockTypeManager.queryStockType.biz.ext",
		            type:'POST',
		            data:json,
		            cache:false,
		            contentType:'text/json',
		            success:function(text){
		            	var returnJson = nui.decode(text);
		            	if(returnJson.exception == null){
							var stockTypeList = returnJson.stockTypes;
							var length = stockTypeList.length;
							for (var i = 0;i < length; i++) {
				                var stockType = stockTypeList[i];
				                if (stockType.cStockType == type) {
				                	vcStockType.setValue(stockType.cStockType);
				                	vcStockType.setText(stockType.vcStocktypeName);
				                }
				            }
	        			}
					}    
				  });
        	} */
        	//加载所有的债券信息
         function loadStockTypeAll(e){
         	
         	nui.ajax({
			    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext",
			    type: "post",
			    dataType:"json",
			    success: function (text) {
			    	nui.get("vcStockType").loadList(text.data);
			    	nui.get("vcStockType").setValue(e);
			    }
			});
         	
         } 
        	function changeDate(data){
        	    //转换公告日期
        	    
        	    var n_lIssuePostDate = data.lIssuePostDate;		  						//父页面lIssuePostDate值 为Number类型
        	    if(n_lIssuePostDate!=0){
	        	    var o_lIssuePostDate = nui.get("lIssuePostDate"); 						//当前页面lIssuePostDate对象
	            	var v_lIssuePostDate = nui.parseDate(n_lIssuePostDate+"");				//转换为Date类型
	            	var d_lIssuePostDate = nui.formatDate(v_lIssuePostDate, "yyyy-MM-dd");  //date格式化
	            	o_lIssuePostDate.setValue(d_lIssuePostDate);							//赋值
        	    }
        	    //发行日
        	    var n_lIssueBeginDate = data.lIssueBeginDate;		  						//父页面lIssueBeginDate值 为Number类型
				if(n_lIssueBeginDate!=0){
					var o_lIssueBeginDate = nui.get("lIssueBeginDate"); 						//当前页面lIssueBeginDate对象
					var v_lIssueBeginDate = nui.parseDate(n_lIssueBeginDate+"");				//转换为Date类型
					var d_lIssueBeginDate = nui.formatDate(v_lIssueBeginDate, "yyyy-MM-dd");  //date格式化
					o_lIssueBeginDate.setValue(d_lIssueBeginDate);							//赋值
				}
				//上市日期
				var n_lPublishDate = data.lPublishDate;		  						//父页面lPublishDate值 为Number类型
				if(n_lPublishDate!=0){
					var o_lPublishDate = nui.get("lPublishDate"); 						//当前页面lPublishDate对象
					var v_lPublishDate = nui.parseDate(n_lPublishDate+"");				//转换为Date类型
					var d_lPublishDate = nui.formatDate(v_lPublishDate, "yyyy-MM-dd");  //date格式化
					o_lPublishDate.setValue(d_lPublishDate);							//赋值
				}
				
				//到期日期
				var n_lEndincalDate = data.lEndincalDate;		  						//父页面lEndincalDate值 为Number类型
				if(n_lEndincalDate!=0){
					var o_lEndincalDate = nui.get("lEndincalDate"); 						//当前页面lEndincalDate对象
					var v_lEndincalDate = nui.parseDate(n_lEndincalDate+"");				//转换为Date类型
					var d_lEndincalDate = nui.formatDate(v_lEndincalDate, "yyyy-MM-dd");  //date格式化
					o_lEndincalDate.setValue(d_lEndincalDate);							//赋值
				}
				// 起息日期
				var n_lBegincalDate = data.lBegincalDate;		  						//父页面lBegincalDate值 为Number类型
				if(n_lBegincalDate!=0){
					var o_lBegincalDate = nui.get("lBegincalDate"); 						//当前页面lBegincalDate对象
					var v_lBegincalDate = nui.parseDate(n_lBegincalDate+"");				//转换为Date类型
					var d_lBegincalDate = nui.formatDate(v_lBegincalDate, "yyyy-MM-dd");  //date格式化
					o_lBegincalDate.setValue(d_lBegincalDate);							//赋值
				}
				//下一行权日
				var n_lNextExerciseDate = data.lNextExerciseDate;		  						//父页面lNextExerciseDate值 为Number类型
				if(n_lNextExerciseDate!=0){
					var o_lNextExerciseDate = nui.get("lNextExerciseDate"); 						//当前页面lNextExerciseDate对象
					var v_lNextExerciseDate = nui.parseDate(n_lNextExerciseDate+"");				//转换为Date类型
					var d_lNextExerciseDate = nui.formatDate(v_lNextExerciseDate, "yyyy-MM-dd");  //date格式化
					o_lNextExerciseDate.setValue(d_lNextExerciseDate);							//赋值
				}
				
				 //缴款日期
				var n_lPayDate = data.lPayDate;		  						//父页面lPayDate值 为Number类型
				if(n_lPayDate!=0){
					var o_lPayDate = nui.get("lPayDate"); 						//当前页面lPayDate对象
					var v_lPayDate = nui.parseDate(n_lPayDate+"");				//转换为Date类型
					var d_lPayDate = nui.formatDate(v_lPayDate, "yyyy-MM-dd");  //date格式化
					o_lPayDate.setValue(d_lPayDate);							//赋值
				}	
				
				var n_dBidLimitTime = data.dBidLimitTime;		  						
				if(n_dBidLimitTime!=0){
					var v_dBidLimitTime = nui.parseDate(n_dBidLimitTime+"");				//转换为Date类型
					if(v_dBidLimitTime!=null){
					 	nui.get("dApplicationTimeHH").setValue(v_dBidLimitTime.getHours());
					 	nui.get("dApplicationTimeMM").setValue(v_dBidLimitTime.getMinutes());
					}
				}			
            	
        	}
        	
        	/* function showIssuerName(data){
        		//发行人简称显示
        	    var lIssuerIdObj = nui.get("lIssuerId");
        	    lIssuerIdObj.setValue(data.lIssuerId);
        	    lIssuerIdObj.setText(data.vcIssuerName);
        	    
        	    //发行人简称显示 vcDeputyUnderwriter
        	    var vcDeputyUnderwriterObj = nui.get("vcDeputyUnderwriter");
        	    vcDeputyUnderwriterObj.setValue(data.vcDeputyUnderwriter);
        	    vcDeputyUnderwriterObj.setText(data.vcDeputyUnderwriter);
        	    
        	    //发行人简称显示vcMainUnderwriter
        	    var vcMainUnderwriterObj = nui.get("vcMainUnderwriter");
        	    vcMainUnderwriterObj.setValue(data.vcMainUnderwriter);
        	    vcMainUnderwriterObj.setText(data.vcMainUnderwriter);
        	    
        	    //发行人简称显示vcMainUnderwriter
        	    var vcGuarantorNameObj = nui.get("lGuarantorId");
        	    vcGuarantorNameObj.setValue(data.lGuarantorId);
        	    vcGuarantorNameObj.setText(data.vcGuarantorName);
        	    
        	} */
        	
           function showFile(data){
                var bizId=data.lBizId;
           	 	document.getElementById("prodIfm1").src = context+"/fm/baseinfo/fileupload/any_upload.jsp?type=1&attachType=2&attachBusType=1&id="+bizId;
           	 	
           	 	document.getElementById("prodIfm2").src = context+"/fm/baseinfo/fileupload/any_upload.jsp?type=1&attachType=2&attachBusType=2&id="+bizId;
           	 	
           	 	document.getElementById("prodIfm3").src = context+"/fm/baseinfo/fileupload/any_upload.jsp?type=1&attachType=2&attachBusType=3&id="+bizId;
           }
		
		   function onOk(){
		   		if(form != null && form.isChanged()){
		   			var data = form.getData(false,true);
	            	var json = nui.encode(data);
					$.ajax({
						url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.updateDebtIssue.biz.ext",
			            type:'POST',
			            data:json,
			            cache:false,
			            contentType:'text/json',
			            success:function(text){
							var returnJson = nui.decode(text);
		        			if(returnJson.exception == null){
		        				nui.alert("保存成功", "系统提示", function(action){
		                        		if(action == "ok" || action == "close"){
		                            		//CloseWindow("saveSuccess");
		                        		}
		                    		});
		        			}
						}    
					});
		   		}else{
		   		
		   		}
		   	   
		   }
		   
		   function initApproveContext(data){
		   		var themeContext =  data.vcStockName +"-"+ data.vcStockCode ;
		   		document.getElementById("themeOfWork").innerHTML=themeContext;
		   }
		
    	  //关闭窗口
		    function CloseWindow(action) {
		       if (window.CloseOwnerWindow)
		          return window.CloseOwnerWindow(action);
		       else window.close();
		    }
		    
		   /*
			*流程处理公共方法
			*/
			function operateCheck(ck) {
			    //id: 1, text: '通过'},{id: 2, text: '退办'},{id: 3, text: '修改'}
				var operateType = ck.value;
				if(operateType == 1){//同意
					nui.get("vcComments").setValue(ck.getSelected().text);
					jQuery("#handlerActor").hide();
					jQuery("#backActivity_tr").hide();
					jQuery("#handlerActorTitle").hide();
				} else if (operateType == 2){//退办
					if(nui.get("backActivity").getText() == ""){
						nui.get("vcComments").setValue("退办");
					} else {
						nui.get("vcComments").setValue( "退办 : " + "'"+ nui.get("backActivity").getText() +"'环节");
					}
					jQuery("#backActivity_tr").show();
					jQuery("#handlerActor").hide();	
					jQuery("#handlerActorTitle").hide();
					if(document.getElementById("selectUser")!=null){
						jQuery("#selectUser").hide();	
					}
					if(document.getElementById("sendUser")!=null){
						jQuery("#sendUser").hide();	
					}
					if(document.getElementById("yn_tr")!=null){
						jQuery("#yn_tr").hide();	
					}
				} else if (operateType == 3) {//修改
					if(nui.get("handlerActor").getText() == ""){
						nui.get("vcComments").setValue("修改");
					}
					//jQuery("#handlerActor").show();
					jQuery("#backActivity_tr").hide();
					//jQuery("#handlerActorTitle").show();
					//document.getElementById("handlerActorTitle").innerHTML="请选择转办人员:";	
					if(document.getElementById("selectUser")!=null){
						jQuery("#selectUser").hide();	
					}	
					if(document.getElementById("sendUser")!=null){
						jQuery("#sendUser").hide();	
					}
					if(document.getElementById("yn_tr")!=null){
						jQuery("#yn_tr").hide();	
					}
				} else if (operateType == 5) {//否决
					if(nui.get("handlerActor").getText() == ""){
						nui.get("vcComments").setValue("不同意");
					}
					jQuery("#backActivity_tr").hide();
					if(document.getElementById("selectUser")!=null){
						jQuery("#selectUser").hide();	
					}	
					if(document.getElementById("sendUser")!=null){
						jQuery("#sendUser").hide();	
					}
					if(document.getElementById("yn_tr")!=null){
						jQuery("#yn_tr").hide();	
					}
				} 
			}
			
			 //流程提交
	 function processSubmit(){
	    //如果回退到新债录入活动节点，不需要进行签收操作
	    var isSignObj = nui.get("isSign");
	    var isSign = "1";
	    if(isSignObj!=null){
	    	isSign = "0";
	    }
	    var operateType = nui.get("operateType").value;
	    if(operateType == null){
		     nui.alert("请选择操作类型。");
		     return false;
	    }
	    //如果表单有更改	
		if(!form.isChanged()){
		    var comments = nui.get("vcComments").value;
		    var activityDefID = nui.get("activityDefID").value;
		    var backActivity = nui.get("backActivity").value;
		    var approve = {vcComments:comments,vcActivityDefId:activityDefID};
			var data = {
				workItemID:'<%=workItemID %>',
				stockIssueInfo:form.getData(false,true).debtIssue,
				backActivity:backActivity,
				aprvinfo:approve,
				operateType:operateType,
				processInstID:pid,
				isSign:isSign
			};
			var json = nui.encode(data);
			$.ajax({
			  url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.approveDebtIssue.biz.ext",
			  type:'POST',
			  data:json,
			  cache:false,
			  contentType:'text/json',
			  success:function(text){
			      var returnJson = nui.decode(text);
	              if(returnJson.exception == null && returnJson.status =="10"){
	                 nui.alert("流程提交成功","系统提示",function(action){
	                 	 //返回我的代办任务页面
			      	     CloseWindow("confirmSuccess");
			             window.opener.parent.location.href=window.opener.parent.location.href;
	                 });
	                 
	              }else{
	                 nui.alert("流程提交失败。", "系统提示", function(action){
	                    if(action == "ok" || action == "close"){
	                       //CloseWindow("saveFailed");
	                    }
	                  });
	               }
			     
			      }
			    });
		}
	 }
	 
	 function  onSubmit(){
		
		var data = {
			workItemID:'<%=workItemID %>',
			stockIssueInfo:form.getData(false,true).debtIssue,
			bpsParam:form.getData(false,true).bpsParam,
			approve:form.getData(false,true).approve
			};
				
		var json = nui.encode(data);
		////url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.approveDebtIssue.biz.ext",
		$.ajax({
		  url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.test.biz.ext",
		  type:'POST',
		  data:json,
		  cache:false,
		  contentType:'text/json',
		  success:function(text){
		      var returnJson = nui.decode(text);
              if(returnJson.exception == null && returnJson.returnValue != "no"){
                 nui.alert("流程提交成功","系统提示",function(action){
                 	 //返回我的代办任务页面
		      	     CloseWindow("confirmSuccess");
		             window.opener.parent.location.href=window.opener.parent.location.href;
                 });
                 
              }else{
                 nui.alert("流程提交失败。", "系统提示", function(action){
                    if(action == "ok" || action == "close"){
                       //CloseWindow("saveFailed");
                    }
                  });
               }
		     
		      }
		    });
		}
		
		function backActivityChanged(){
		
		
		}
		
			//取回退的活动实例
		<%-- function loadActivities(){
			var workItemID = '<%=workItemID %>';
			//var urlStr = context + "/com.cjhxfund.jy.process.wf.getRollBackActivitys.biz.ext";
	    	var json = nui.encode({processInstID:pid,workItemID:workItemID});
	    	$.ajax({
	            url:'com.cjhxfund.jy.process.wf.getRollBackActivitys.biz.ext',
	            data:json,
	            type:'POST',
	            contentType:'text/json',
	            cache:false,
	            success:function(d){
	            	if(d && d.activitys) {
	            		var data = d.activitys;
	            		var backActivityCombo = nui.get("backActivity").value;
	                	backActivityCombo.load(data);
	            	}
	            }
	       });
		} --%>
		function issueInfoOnItemClick(){
				 var lIssuerId = nui.get("lIssuerId").getValue();//发行人代码
				 if(lIssuerId!=null && lIssuerId!=""){
					  $.ajax({
						url:"com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.getIssueInfoByID.biz.ext",
						type:'POST',
						data:nui.encode({id:lIssuerId}),
						cache:false,
						contentType:'text/json',
						success:function(text){
							var returnJson = nui.decode(text);
							if(returnJson.exception == null){
							    var issueInfo = returnJson.issueInfo;//投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
							    //投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
							    var vcIssueName = issueInfo.vcIssueName;
							    var vcIssueNameFull = issueInfo.vcIssueNameFull;
							   	nui.get("vcIssuerName").setValue(vcIssueName);               //发行人全称
								nui.get("vcIssuerNameFull").setValue(vcIssueNameFull);               //发行人全称
								
							}
						 }
					});
				  }
			}
			
			function loadVcIssueAppraiseCsrcAll(e){
	     	nui.ajax({//com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc
			    url: "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc.biz.ext",
			    type: "post",
			    data:nui.encode({type:"1"}),
			    contentType:'text/json',
			    success: function (text) {
			    	nui.get("vcIssueAppraiseCsrc").loadList(text.data);
			    	nui.get("vcIssueAppraiseCsrc").setValue(e);
			    }
			});
	     }
	     function loadVcIndustryAll(e){
	     	nui.ajax({//com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc
			    url: "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc.biz.ext",
			    type: "post",
			    data:nui.encode({type:"2"}),
			    contentType:'text/json',
			    success: function (text) {
			    	nui.get("vcIndustry").loadList(text.data);
			    	nui.get("vcIndustry").setValue(e);
			    }
			});
	     }    	
    </script>
   
</body>
</html>