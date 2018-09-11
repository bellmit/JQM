<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<%@ taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<%@ taglib uri="http://eos.primeton.com/tags/dict" prefix="d"%>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<%
   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 

   //流程ID
   String processinstid =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"processInstID");
   
   //
   //String processinstid =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"processinstid");
 %>
<%--
- Author(s): chenpeng
- Date: 2016-03-30 10:19:16
- Description:
    --%>
<head>
    <title>
          <b:write property="workItemName" />_打印 	
    </title>
   <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
   
   
   
	    
    <style type="text/css">
       .td1{
		  border-right: 1px solid #D3D3D3;
		  border-left: 1px solid #D3D3D3;
		}
	    .td2{
		  border-right: 1px solid #D3D3D3;
		}
		.td3{
			border-bottom: 1px solid #D3D3D3;
		}
		.table{
			border-right: 1px solid #D3D3D3;
			border-left: 1px solid #D3D3D3;
			border-top: 1px solid #D3D3D3;
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
     </style>
</head>
<body style="margin: auto;padding: auto;">
     <h2 align="center" style="margin-top: 10px;margin-bottom: 10px;">[<b:write property="gradeBond/lInvestNo" />]-<b:write property="gradeBond/vcProductName" />-<b:write property="gradeBond/vcStockName" /></h2>
	 <div class="nui-panel" title="业务信息"  style="width:100%;height: 28px;margin: 0px auto;" showToolbar="false" showFooter="true" >
	 </div>
	   <l:equal property="gradeBond/vcBusinessType" targetValue="1">
	   <!-- 一级债券申购(非可转债)流程信息 -->
	     <table style="width:100%;table-layout:fixed;margin-bottom: 5px;" class="nui-form-table">
                <tr>
                    <td class="form_label td1" width="20%" align="right"> 业务日期:</td>
                    <td class="form_label td2" colspan="1" width="30%">
                        <b:write property="gradeBond/dApplicationTime" formatPattern="yyyy-MM-dd"/>
                    </td>
                    <td class="form_label td1" width="20%" align="right">缴款日期:</td>
                    <td class="form_label td2" colspan="1" width="30%">
                        <b:write property="gradeBond/dPaymentDate" formatPattern="yyyy-MM-dd"/>
                    </td>
                </tr>
                <tr>
	                <td class="form_label td1" align="right">组合名称:</td>
	              	<td colspan="1" class="td2">
	                  <b:write property="gradeBond/vcCombiName"/>
	              	</td>
	               	<td class="form_label td1" align="right">产品名称:</td>
	                <td colspan="1"  class="td2">
	                	<b:write property="gradeBond/vcProductName"/>
	                </td>
                </tr>
                <tr>
                	<td class="form_label td1" align="right">债券简称:</td>
                    <td colspan="1" class="td2">
                        <b:write property="gradeBond/vcStockName"/>
                    </td>
                    <td class="form_label td1" align="right">债券代码:</td>
                    <td colspan="1" class="td2">
                        <b:write property="gradeBond/vcStockCode"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label td1" align="right">登记托管机构:</td>
                    <td colspan="1" class="td2">
						<d:write dictTypeId="CF_JY_DJTGCS"  property="gradeBond/vcPaymentPlace"/>
                    </td>
                    <td class="form_label td1" align="right">债券类别:</td>
                    <td colspan="1" class="td2">
                        <b:write property="gradeBond/vcStocktypeName"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label td1" align="right">发行主体:</td>
                    <td colspan="1" class="td2">
                        <b:write property="gradeBond/vcIssuerNameFull" />
                    </td>
                    <td class="form_label td1" align="right">债券全称:</td>
                    <td colspan="1" class="td2">
                        <b:write property="gradeBond/vcStockNameFull" />
                    </td>
                </tr>
                <tr>
                	<td class="form_label td1 td3" align="right">发行日期:</td>
                    <td colspan="1" class="td2 td3">
                        <b:write property="gradeBond/lIssueBeginDate" formatPattern="yyyy-MM-dd"/>
                    </td>
                    <td class="form_label td1 td3" align="right">发行规模(亿):</td>
                    <td colspan="1" class="td2 td3">
                        <b:write property="gradeBond/enIssueBalance" />
                    </td>
				</tr>
       	 </table>
       <div class="nui-panel" title="其他信息"  style="width:100%;height: 28px;margin-top: 5px;margin: 0px auto;" showToolbar="false" showFooter="true" ></div>
      		<table style="width:100%;table-layout:fixed;"class="nui-form-table">
	      		<tr>
	       			<td class="form_label td1" align="right" width="20%">主承销商:</td>
	   				<td colspan="3" class="td2">
	                    <b:write property="gradeBond/vcMainUnderwriter" />
	                </td>
	       		</tr>
	   			<tr>
	   				<td class="form_label td1" align="right" width="20%">副主承销商:</td>
	   				<td colspan="3" class="td2" width="80%">
	                    <b:write property="gradeBond/vcDeputyUnderwriter" />
	                </td>
	   			</tr>  
	   			<tr>
	   				<td class="form_label td1" align="right" width="20%">承销团:</td>
	   				<td colspan="3" class="td2" width="80%">
	                    <b:write property="gradeBond/vcGroupUnderwriter"/>
	                </td>
	   			</tr> 
	      	</table>
	      	<table style="width:100%;table-layout:fixed;margin-bottom: 5px;" class="nui-form-table" border="1px">
                <tr>
                	<td class="form_label td1 td3" align="right" width="20%">主体类型:</td>
                    <td colspan="1" class="td2 td3">
                        <d:write dictTypeId="ATS_FM_ISSUE_PROPERTY" property="gradeBond/vcIssueProperty" />
                    </td>
                	<td class="form_label td1" align="right" width="20%">交易对手:</td>
                    <td colspan="1" class="td3">
                    	 <b:write property="gradeBond/vcBusinessObject"/>
                    </td>
                </tr>
                <tr>
					<td class="form_label td1" align="right">主体评级:</td>
					<td colspan="1" class="td2">
						 <d:write dictTypeId="issuerRating" property="gradeBond/cIssueAppraise" />
					</td>   
					 <td class="form_label td1" align="right">债券评级:</td>
					<td colspan="1" class="td2"> 
						<d:write dictTypeId="creditRating" property="gradeBond/cBondAppraise" />
					</td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">评级机构:</td>
                    <td colspan="1">
                        <d:write dictTypeId="outRatingOrgan" property="gradeBond/vcBondAppraiseOrgan" />
                    </td>
                    <td class="form_label td1" align="right">特殊条款:</td>
                    <td colspan="1">
                        <d:write dictTypeId="specialText" property="gradeBond/vcSpecialText" />
                    </td>
                </tr>
                <tr>
                	<td class="form_label td1" align="right">发行方式:</td>
                    <td colspan="1" class="td2">
                    	<d:write dictTypeId="issueType" property="gradeBond/vcIssueType" />
                    </td>
                    <td class="form_label td1" align="right">发行期限(年):</td>
                    <td colspan="1" class="td2">
                        <b:write property="gradeBond/enExistLimite" />
                    </td>
                    <%-- <td class="form_label td1" align="right">投标区间:</td>
                    <td colspan="1" class="td2">
                      	<b:write property="gradeBond/vcTenderInterval"/>
                    </td> --%>
                </tr>
                
                <tr>
                    <%-- <td class="form_label td1" align="right">下一行权日:</td>
                    <td colspan="1" class="td2">
                        <b:write property="gradeBond/lNextExerciseDate" formatPattern="yyyy-MM-dd"/>
                    </td> --%>
                    <td class="form_label td1" align="right">特殊期限:</td>
                    <td colspan="1" class="td2">
                        <b:write property="gradeBond/vcSpecialLimite"/>
                    </td>
                    <td class="form_label td1" align="right">下一利率跳升点数:</td>
                    <td colspan="1" class="td2">
                      	<b:write property="gradeBond/lNInterestRateJumpPoints" />
                    </td>
                </tr>
                <tr>
                	<td class="form_label td1" align="right">首次付息日:</td>
                    <td colspan="1" class="td2">
						<b:write property="gradeBond/dInitInterestPaymentDate" formatPattern="yyyy-MM-dd"/>
                    </td>
                    <td class="form_label td1" align="right">公司净资产（元）:</td>
                    <td colspan="1" class="td2">
						<b:write property="gradeBond/enIssuerNetValue" />
                    </td>
                </tr>
                <tr>
                	<td class="form_label td1" align="right">城投行政级别:</td>
                    <td colspan="1" class="td2">
                    	<d:write dictTypeId="cityLevel" property="gradeBond/vcCityLevel" />
                    </td>
                    <td class="form_label td1" align="right">所属行业(证监会二级):</td>
                    <td colspan="1" class="td2">
						<b:write property="gradeBond/vcIssueAppraiseCsrcName" />
                    </td>
                </tr>
	            <tr id="mortInfo">
                    <td class="form_label td1" align="right">
                                                                 股票名称:
                    </td>
                    <td colspan="1"  class="td2">
						<b:write property="gradeBond/vcMortStockName" />
                    </td>
                    <td class="form_label td1" align="right">
                                                                         股票代码:
                    </td>
                    <td colspan="1"  class="td2">
						<b:write property="gradeBond/vcMortStockCode" />
                    </td>  
                </tr>
                
                 <tr id="mortAmount">
                    <td class="form_label td1" align="right">
                                                                      股票抵押数量(万股):
                    </td>
                    <td colspan="1"  class="td2">
						<b:write property="gradeBond/vcMortStockAmount" />
	                 </td>
                    <td class="form_label td1" align="right">
                    	
                    </td>
	                <td colspan="1"  class="td2">

	                 </td>  
	                </tr>
                <tr>
                   <td class="form_label td1" align="right">是否具有回售权:</td>
                    <td colspan="1" class="radio-border-top-none">
                       <label style="float: left;font-weight: normal;" ><d:write dictTypeId="COF_YESORNO" property="gradeBond/cIsHaveSaleback"/></label>
                    </td>
                   <td class="form_label td1" align="right"> 是否具有赎回权:</td>
                    <td colspan="1" class="radio-border-top-none td2">
                          <label style="float: left;font-weight: normal;" ><d:write dictTypeId="COF_YESORNO"  property="gradeBond/cIsHaveBuyback"/></label>
                    </td>
                </tr>

                <tr>
                    <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
                        备注:
                    </td>
                    <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
                        <b:write property="gradeBond/vcRemarks" />
                    </td>
                </tr>
            </table>
			</l:equal>
			<!-- 一级债券申购(可转债)流程信息 -->
			<l:equal property="gradeBond/businesstype" targetValue="2">
			  <table style="width:100%;table-layout:fixed;" class="nui-form-table">
	                <tr>
	                  <td class="form_label td1" align="right" width="20%">
	                        申购日期:
	                    </td>
	                    <td colspan="1" width="30%"> 
	                        <b:write property="gradeBond/processDate" formatPattern="yyyy-MM-dd"/>
	                    </td>
	                    <td class="form_label td1" width="20%" align="right">
	                        产品名称:
	                    </td>
	                    <td colspan="1" width="30%" class="td2">
	                        <b:write property="gradeBond/combProductName" />
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" align="right">
	                        债券代码:
	                    </td>
	                    <td colspan="1">
	                       <b:write property="gradeBond/investProductCode" />
	                    </td>
	                    <td class="form_label td1" align="right">
	                        债券名称:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <b:write property="gradeBond/investProductName" />
	                    </td>
	                    
	                </tr>
	                <tr>
	                  <td class="form_label td1" align="right">
	                        申购金额(万元):
	                    </td>
	                    <td colspan="1">
	                        <b:write property="gradeBond/purchaseAmount" />
	                    </td>
	                    <td class="form_label td1" align="right">
	                        定金比例(%):
	                    </td>
	                    <td colspan="1" class="td2">
	                        <b:write property="gradeBond/depositRatio" />
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" align="right">
	                        定金金额(万元):
	                    </td>
	                    <td colspan="1">
	                        <b:write property="gradeBond/depositAmount" />
	                    </td>
	                    <td class="form_label td1" align="right">
	                        发行主体:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <b:write property="gradeBond/ratingname" />
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" align="right">
	                        发行主体类型:
	                    </td>
	                    <td colspan="1">
	                        <d:write dictTypeId="CF_JY_ZTLX" property="gradeBond/ratingType"/>
	                    </td>             
	                    <td class="form_label" align="right">
	                        债券种类:
	                    </td>
	                    <td colspan="1">
	                        <b:write property="cfjybusinessbonetable/investcategory" />
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" align="right">
	                        评级机构:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <d:write dictTypeId="CF_JY_PRODUCT_PROCESS_RATING_AGENCIES" property="gradeBond/ratingagencies"/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                        发行规模(万元):
	                    </td>
	                    <td colspan="1">
	                        <b:write property="gradeBond/issueSize" />
	                    </td>
	                 </tr>
	                 <tr>
	                    <td class="form_label td1" align="right">
	                        发行期限(年):
	                    </td>
	                    <td colspan="1" class="td2">
	                        <b:write property="gradeBond/categorydate" />
	                    </td>
	                    <td class="form_label td1" align="right">
	                        已投资该发行主体证券存量(万元):
	                    </td>
	                    <td colspan="1">
	                        <b:write property="gradeBond/categorymoney" />
	                    </td>   
	                  </tr>
	                  <tr>
	                    <td class="form_label td1" align="right"> 
	                        主承机构:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <b:write property="gradeBond/mainBearingMechanism" />
	                    </td>
	                    <td class="form_label td1" align="right">
	                        净值规模(万元):
	                    </td>
	                    <td colspan="1" class="td2">
	                        <b:write property="gradeBond/netWorthScale" />
	                    </td>
	                  </tr>
	                  <tr>
	                    <td class="form_label td1" align="right"> 
	                        中签数量:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <b:write property="gradeBond/ballotNumber" />
	                    </td>
	                    <td class="form_label td1" align="right">
	                       中签金额:
	                    </td>
	                    <td colspan="1" class="td2">
	                      <b:write property="gradeBond/ballotMoney" />
	                    </td>
	                  </tr>
	                <tr>
	                    <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
	                        备注:
	                    </td>
	                    <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
	                        <b:write property="gradeBond/remarks" />
	                    </td>
	                </tr>                
	            </table>
	 </l:equal>
			<div class="nui-panel" title="报量信息"  style="width:100%;height: 28px;margin-top: 5px;margin: 0px auto;" showToolbar="false" showFooter="true" ></div>
			<div style="font-size:10px;color:red;">
				<div style="width:68%;float: left;padding-left: 10px;"><b>说明：</b>①报量为100万整数倍；②特殊说明请在报量说明中填写；③报价待定时为空即可</div>
				<div style="width:30%;float: right;text-align: left;line-height: 27px;">
					报量方式：<input style="width: 70px;"  url="<%= request.getContextPath() %>/fm/instr/processUtil/reportData.txt" 
					class="nui-dictcombobox asLabel"  value="<b:write property="gradeBond/cReportType" />" readonly="readonly"/>
				</div>
			</div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table"  style="margin-bottom: 5px;">
				<tr style="text-align: center;">
					<td class="td2 td3" width="20%" align="center">报量(万元)</td>
					<td class="td2 td3" width="30%" align="center">报价(%)</td>
					<td class="td3" width="50%">报量说明</td>
				</tr>
				<l:iterate id="applyInst" property="applyInstReports">
					<tr>
						<td class="td2 td3" align="center"><b:write iterateId="applyInst" property="enReport"/></td>
						<td class="td2 td3" align="center"><b:write iterateId="applyInst" property="enOffer"/></td>
						<td class="td3"><b:write iterateId="applyInst" property="vcReportRemark"/></td>
					</tr>
				</l:iterate>
			</table>
			<div class="nui-panel" title="缴款信息"  style="width:100%;height: 28px;margin-top: 5px;margin: 0px auto;" showToolbar="false" showFooter="true" >
			    </div>
			   <table style="width:100%;table-layout:fixed;margin: 0px auto;margin-bottom: 5px;" class="nui-form-table">
			      <tr>
			         <td class="form_label td1" align="right" width="20%">
		                        缴款面值(万元):
		             </td>
		             <td colspan="1" class="radio-border-top-none" width="30%" >
		                    <b:write property="gradeBond/enPayFaceValue" />
		             </td>
		             <td class="form_label td1" align="right" width="20%">
		                        发行价格(元):
		             </td>
		             <td colspan="1" class="td2" width="30%">
		                 <b:write property="gradeBond/enBallotPrice" />   
		             </td>
		          </tr>
		          <tr>
		             <td class="form_label td1" align="right">
		                        缴款金额(万元):
		             </td>
		             <td colspan="1" class="radio-border-top-none">
		                    <b:write property="gradeBond/enPaymentMoney" />
		             </td>
		              <td class="form_label td1" align="right">
		                        票面利率(%):
		             </td>
		            <td colspan="1" class="td2">
						<b:write property="gradeBond/enCouponRate" />
		             </td>
		          </tr>
		          <tr>
		            
		             <td class="form_label td1" align="right">
		                        付息频率:
		             </td>
		             <td colspan="1" class="td2">
		                 <d:write dictTypeId="ATS_CF_JY_FREQUENCY" property="gradeBond/vcFrequency"/>   
		             </td>
		             <td class="form_label td1" align="right">
		                        计息起始日期:
		             </td>
		            <td colspan="1" class="td2">
							<b:write property="gradeBond/lBegincalDate" formatPattern="yyyy-MM-dd"/>
		             </td>
		          </tr>
		          <tr>
		             <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
		                        还本方式:
		             </td>
		            <td colspan="1" class="td2"  style="border-bottom: 1px solid #D3D3D3;">
		             	<d:write dictTypeId="CF_JY_MODE_REPAYMENT" property="gradeBond/vcModeRepayment"/> 
		            </td>
		             <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
		                         到期日:
		             </td>
		             <td colspan="1"   class="td2" style="border-bottom: 1px solid #D3D3D3;">
							<b:write property="gradeBond/lEndincalDate" formatPattern="yyyy-MM-dd"/>
		             </td>
	             </tr>
			   </table>   
	            <div class="nui-panel" title="收款账户信息"  style="width:100%;height: 28px;margin-top: 5px;margin: 0px auto; " showToolbar="false" showFooter="true" >
		        </div>
			   <table style="width:100%;table-layout:fixed;margin-bottom: 5px;" class="nui-form-table">
	                <tr>
	                    <td class="form_label td1" width="20%" align="right">
	                      缴款方式:
	                    </td>
	                    <td width="30%" class="td1">
	                         <d:write dictTypeId="ATS_FM_PAYMENT" property="gradeBond/vcTransactionType" />
	                    </td>
	                    <td class="form_label td1" width="20%" align="right">
	                        收款人户名:
	                    </td>
	                    <td width="30%" class="td1">
	                         <b:write property="gradeBond/vcBeneficiary" />
	                    </td>
	                  </tr>
	                <tr>
	                	<td class="form_label td1" align="right">
	                        收款账号:    
	                    </td>
	                    <td colspan="1"class="td2">
	                        <b:write property="gradeBond/vcCollectionAccount" />
	                    </td>
	                    <%-- <td class="form_label td1" width="20%" align="right">
	                        开户行行号:
	                    </td>
	                    <td colspan="1" width="30" class="td1">
	                        <input class="nui-textbox" id="bankLine" width="150" name="gradeBond.bankLine"
	                        value="<b:write property="gradeBond/bankLine" />"  readonly/>
	                        <b:write property="gradeBond/vcBankLine" />
	                    </td> --%>
	                    <td class="form_label td1" align="right">
	                        大额支付行号:    
	                    </td>
	                    <td colspan="1" class="td2">
	                        <%-- <input class="nui-textbox" name="gradeBond.payLine" width="150"
	                         value="<b:write property="gradeBond/payLine" />"   readonly/> --%>
	                         <b:write property="gradeBond/vcPayLine" />
	                    </td>
	                </tr>
	                <tr>
	                   <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
	                        备注:
	                    </td>
	                    <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
	                        <%-- <input class="nui-textarea" id="receivableRemark" width="450" height="60"
	                         name="gradeBond.receivableRemark"  value="<b:write property="gradeBond/receivableRemark" />"   readonly/> --%>
	                         <b:write property="gradeBond/vcReceivableRemark" />
	                    </td>
	                </tr>
	            </table> 
	            <div class="nui-panel" title="审批信息"  style="width:100%;height: 28px;margin-top: 5px;margin: 0px auto; " showToolbar="false" showFooter="true" >
		        </div>
		        <div id="grid_form">
				   <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.foundation.task.EntityDataSet.TAtsApproveInfo"/>
				   <input class="nui-hidden" name="criteria/_expr[1]/lProcessInstId" value="<%=processinstid %>"/>
				   <input class="nui-hidden" name="cirteria/_expr[1]/_op" value="="/>
		   		</div>
				<%-- <div id="deptGrid" class="nui-datagrid" style="width:100%;margin-bottom: 5px;"
					 url="com.cjhxfund.foundation.task.pendingTreatment.queryTAtsApproveInfoList.biz.ext"  
					 dataField="TAtsApproveInfos" pageSize="50" allowResize="true" showPager="false">
					 
				 <div property="columns">            
				     <div field="dStartTime"  headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss">审批时间</div>                                        
				     <div field="vcWorkItemName"  headerAlign="left" >节点名称</div>   
				     <div field="vcUserName"  headerAlign="left" >操作者</div>  
				     <div field="vcOperateType"  headerAlign="left" renderer="rendeRoperateType">操作</div>  
				     <div field="vcComments"  headerAlign="left" >处理意见</div>         
				 </div>
			   </div> --%>
			   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table"  style="margin-bottom: 5px;">
				<tr style="text-align: center;">
					<td class="td2 td3" width="25%" >审批时间</td>
					<td class="td2 td3" width="17%">节点名称</td>
					<td class="td3 td2" width="13%">操作者</td>
					<td class="td2 td3" width="15%">操作</td>
					<td class="td3" width="30%">处理意见</td>
				</tr>
				<l:iterate id="approveInfos" property="tAtsApproveInfos">
					<tr>
						<td class="td2 td3" style="text-align: center;"><b:write iterateId="approveInfos" property="dStartTime" /></td>
						<td class="td2 td3"><b:write iterateId="approveInfos" property="vcWorkItemName"/></td>
						<td class="td2 td3" style="text-align: center;"><b:write iterateId="approveInfos" property="vcUserName"/></td>
						<td class="td2 td3" style="text-align: center;">
							<script type="text/javascript">
								var vcOperateType ="<b:write iterateId="approveInfos" property="vcOperateType"/>";	
								  if(vcOperateType == 1){
						            document.write("同意");
						          }
						          if(vcOperateType == 2){
						            document.write("退办");
						          }
						          if(vcOperateType == 3){
						            document.write("转办");
						          }
						          if(vcOperateType == 4){
						            document.write("征求意见");
						          }
						          if(vcOperateType == 5){
						            document.write("否决");
						          }
						          if(vcOperateType == 99){
						            document.write("不同意");
						          }
						          if(vcOperateType == 98){
						            document.write("修改");
						          }
						          if(vcOperateType == 97){
						            document.write("废弃");
						          }
							</script>
						</td>
						<td class="td3"><b:write iterateId="approveInfos" property="vcComments"/></td>
					</tr>
				</l:iterate>
			   </table>
			   <div class="nui-panel" title="附件列表"  style="width:100%;height: 28px;margin-top: 5px;margin: 0px auto; " showToolbar="false" showFooter="true" >
		       </div>
	           <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table"  style="margin-bottom: 5px;">
				<tr style="text-align: center;">
					<!--<td class="td2 td3">编号</td>-->
					<td class="td2 td3" width="55%">文件名</td>
					<td class="td3 td2" width="25%">节点名称</td>
					<td class="td2 td3">是否用印</td>
					<td class="td3">是否用过印</td>
					<td class="td2 td3">是否需要归档</td>
				</tr>
				<l:iterate id="attachment" property="attachInfos">
					<tr>
						<%-- <td class="td2 td3"><b:write iterateId="attachment" property="lAttachId" /></td> --%>
						<td class="td2 td3"><b:write iterateId="attachment" property="vcAttachName"/></td>
						<td class="td2 td3"><b:write iterateId="attachment" property="workitemname"/></td>
						<td class="td2 td3" style="text-align: center;">
							<script type="text/javascript">
								var vcAnnexSeal ="<b:write iterateId="attachment" property="vcAnnexSeal"/>";	
								  if(vcAnnexSeal == 1){
						            document.write("是");
						          }else{
						            document.write("否");
						          }
							</script>
						</td>
						<td class="td3" style="text-align: center;">
							<script type="text/javascript">
								var vcWhetherIndia ="<b:write iterateId="attachment" property="vcWhetherIndia"/>";	
								  if(vcWhetherIndia == 1){
						            document.write("是");
						          }else{
						            document.write("否");
						          }
							</script>
						</td>
						<td class="td2 td3" style="text-align: center;">
							<script type="text/javascript">
								var cWhetherArchiving ="<b:write iterateId="attachment" property="cWhetherArchiving"/>";	
								  if(cWhetherArchiving == 1){
						            document.write("是");
						          }else{
						            document.write("否");
						          }
							</script>
						</td>
					</tr>
				</l:iterate>
			   </table> 
        <script type="text/javascript">
            nui.parse();
            //债券类型
		    var vcStockType="<b:write property="gradeBond/vcStockType"/>";
		    //通过债券类别控制股票信息展示stockissueinfo.vcStockType
			if(vcStockType!="" && vcStockType!=null){
				onAccountTypeChanged1(vcStockType);
			}
			function onAccountTypeChanged1(eid) {
	        if(eid == 'Q' || eid == 'O' ){
		       document.getElementById( "mortInfo").style.display= "";
		       document.getElementById( "mortAmount").style.display= ""; 

	        }else{
		       document.getElementById( "mortInfo").style.display= "none";
		       document.getElementById( "mortAmount").style.display= "none";  
		       
	        }
        }
       </script>
    </body>
</html>
