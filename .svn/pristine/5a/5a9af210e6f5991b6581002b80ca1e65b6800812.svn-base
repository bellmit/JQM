<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 谢海光
  - Date: 2017-12-14 13:45:24
  - Description:
-->
<head>
<title>新债缴款详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>

<head>
<title>详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

    <style type="text/css">
    
      .asLabel .mini-textbox-input{
        color: red;
        background:none;cursor:default;
      }
      .asLabel_gray .mini-textbox-input{
         color: black;
         background:none;cursor:default;
      }
	    #footer {z-index:999; position:fixed; bottom:0; left:0;  _position:absolute; height:30px;
		 _top: expression_r(documentElement.scrollTop + documentElement.clientHeight-this.offsetHeight-300); overflow:visible;
		}
		#dataform2 tr{
			border-top:0px;
		}
    </style>
    
</head>
<body style="height: 99%;">
 <div id="dataform1" style="height: 100%;">
   <div class="nui-tabs" id="tabs" activeIndex="0"  style="width:100%;height:96%;">
		<!-- 业务类型标签页开始... -->
		<div title="基本信息">
			<!-- 左右布局控件 -->
			<div id="layout1" class="nui-layout" style="width:100%;height:100%;" >
				<!-- 主体内容 -->
				<div title="center" region="center" width="80%">
			   <input class="nui-hidden" id="dBidLimitTime" name="firstGradeBond.dBidLimitTime" />
				<input class="nui-hidden" id="lInvestNo" name="firstGradeBond.lInvestNo" />
				<input class="nui-hidden" id="vcProductCode" name="firstGradeBond.vcProductCode" />
				<input class="nui-hidden" id="lBizId" name="firstGradeBond.lBizId" />
				<input class="nui-hidden" id="lProcessInstId" name="firstGradeBond.lProcessInstId" />
				<input class="nui-hidden" id="lStockInvestNo" name="firstGradeBond.lStockInvestNo" />
				<input class="nui-hidden" id="lApplyInstId" name="firstGradeBond.lApplyInstId" />
			    <table style="width:100%;table-layout:fixed;" class="nui-form-table">
	                <tr>
	                    <td class="form_label td1" width="20%" align="right">
	                        业务日期:    
	                    </td>
	                    <td colspan="1"  width="30%">
	                        <input class="nui-datepicker" id="dApplicationTime" name="firstGradeBond.dApplicationTime" width="220px" readonly/>
	                    </td>
	                    <td class="form_label td1" align="right" width="20%">
		                        缴款日期:
			             </td>
			            <td colspan="1" class="td2"  width="30%">
							<input class="nui-datepicker" name="firstGradeBond.dPaymentDate" id="dPaymentDate" 
							 style="width: 220px;" readonly="readonly"/>
			             </td>
	                </tr>
	                <tr>
	                  <td class="form_label td1" align="right">
	                        产品名称:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" id="vcProductName" width="220px" name="firstGradeBond.vcProductName" readonly/>
	                    </td>
	                    <td class="form_label td1" align="right">
		                        组合名称:
		                  </td>
		                  <td colspan="1" class="td2">
		                      <input class="nui-textbox"  width="220px" id="vcCombiName" name="firstGradeBond.vcCombiName" readonly/>
		                  </td>
	                </tr>
	                <tr>
	                	<td class="form_label td1" width="20%" align="right">
	                        债券简称:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" id="vcStockName" width="220px" name="firstGradeBond.vcStockName"  readonly/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                        债券代码:
	                    </td>
	                    <td colspan="1" >
	                        <input  id="vcStockCode" width="220px" class="nui-textbox"name="firstGradeBond.vcStockCode" readonly/>
	                    </td>
	                    
	                </tr>
	                <tr>
	                	<td class="form_label td1" align="right">
				登记托管机构:
					  		</td>
					  		<td colspan="1" class="td1">
					  			<input width="220px"class="nui-dictcombobox" id="vcPaymentPlace" name="firstGradeBond.vcPaymentPlace"  dictTypeId="CF_JY_DJTGCS" readonly="readonly" />
					  		</td>
					  	<td class="form_label td1" align="right">
		                        债券类别:
		                    </td>
		                    <td colspan="1" class="td2">
		                        <input class="nui-textbox" width="220px" id="vcStocktypeName" name="firstGradeBond.vcStocktypeName" 
		                        readonly="readonly"/>
		                        <input class="nui-hidden" id="vcStockType" name="firstGradeBond.vcStockType" 
		                         />  
		                    </td>
	                </tr>
	                <tr>
		                	<td class="form_label td1" align="right">
		                        发行主体:
		                    </td>
		                    <td colspan="1" class="td2">
		                        <input class="nui-textbox" width="220px" id="vcIssuerNameFull" name="firstGradeBond.vcIssuerNameFull"  readonly="readonly"/>
		                    </td>
		                    <td class="form_label" align="right">
			      债券全称:
						  </td>
						  <td colspan="1">
						    <input style="width: 220px;" class="nui-textbox" id="vcStockNameFull" name="firstGradeBond.vcStockNameFull" />
						  </td>
		            </tr>
		            <tr>
		                <td class="form_label" align="right" >
				发行日期:
						  </td>
						  <td colspan="1">
						  	<input style="width:220px" class="nui-datepicker" id="lIssueBeginDate" name="firstGradeBond.lIssueBeginDate" 
			                format="yyyy-MM-dd" readonly="readonly"/>
						  </td>
		                <td class="form_label td1" align="right">
		                         发行规模(亿):
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" name="firstGradeBond.enIssueBalance" id="enIssueBalance" width="220px" readonly="readonly"/>
		                    </td>
		             </tr>
	            </table>
	
		        <div class="nui-panel" title="缴款信息"  style="width:100%;height: 28px;margin-top: 5px;" showToolbar="false" showFooter="true" >
			   </div>
			   
			   <table style="width:100%;table-layout:fixed;" class="nui-form-table">
			      
			      <tr>
		             <td class="form_label td1" align="right" width="20%">
		               	缴款面值(万元):
		             </td>
		             <td colspan="1" class="radio-border-top-none"  width="30%">
		                 <input class="nui-textbox" id="enPayFaceValue" name="firstGradeBond.enPayFaceValue"  style="width: 220px;" readonly="readonly" /> 
		             </td>
			         <td class="form_label td1" align="right" width="20%">
		                                                   发行价格(元):
		             </td>
		             <td colspan="1" class="radio-border-top-none"  width="30%">
		                 <input class="nui-textbox" name="firstGradeBond.enBallotPrice" id="vcBallotPrice"
		                    style="width: 220px;"  readonly="readonly"/>
		             </td>
				  </tr>
			      <tr>	 
		             <td class="form_label td1" align="right" width="20%">
						缴款金额(万元):
		             </td>
		             <td colspan="1" class="radio-border-top-none" >
		                 <input class="nui-textbox"  id="paymentMoney" name="firstGradeBond.enPaymentMoney" style="width: 220px;" readonly="readonly"/>
		             </td>
		             <td class="form_label td1" align="right">
		                        票面利率(%):
		             </td>
		            <td colspan="1" class="td2">
						<input class="nui-textbox" name="firstGradeBond.enCouponRate" id="enCouponRate" 
						  style="width: 220px;" readonly="readonly"/>
		             </td>
				</tr>
		          <tr>	 
		             
		             <td class="form_label td1" align="right">
		                        付息频率:
		             </td>
		             <td colspan="1">
		                 <input class="nui-dictcombobox" dictTypeId="ATS_CF_JY_FREQUENCY" allowInput="true" name="firstGradeBond.vcFrequency" id="vcFrequency"
		                    readonly="readonly"  style="width: 220px;" />
		             </td>
		             <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
		                        计息起始日期:
		             </td>
		             <td colspan="1"  style="border-bottom: 1px solid #D3D3D3;">
		             <input class="nui-datepicker" name="firstGradeBond.lBegincalDate" id="lBegincalDate" 
						readonly="readonly"  style="width: 220px;" />
		             </td>
				  </tr>
		          <tr> 
		             <td class="form_label td1" align="right">
		                        还本方式:
		             </td>
		            <td colspan="1" class="td2" >
						<input class="nui-dictcombobox" dictTypeId="CF_JY_MODE_REPAYMENT" name="firstGradeBond.vcModeRepayment" id="vcModeRepayment" 
						readonly="readonly"  style="width: 220px;" />
		             </td>
		             <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
		                        到期日:
		             </td>
		             <td colspan="3"  style="border-bottom: 1px solid #D3D3D3;">
		                 <input class="nui-datepicker" name="firstGradeBond.lEndincalDate" id="lEndincalDate"
		                  readonly="readonly"  style="width: 220px;"/>
		             </td>
				  </tr>
		           <tr>
	                    <td class="form_label td1" width="20%" align="right">
	                        缴款方式:    
	                    </td>
	                    <td colspan="1" >
	                        <input class="nui-dictcombobox" id="cPayType" dictTypeId="ATS_FM_PAYMENT" name="firstGradeBond.cPayType" width="220px" readonly/>
	                    </td>
	                    <td class="form_label td1" width="20%" align="right">
	                        收款人户名:
	                    </td>
	                    <td colspan="1" class="td1">
	                        <input class="nui-textbox"id="vcBeneficiary" width="220px" name="firstGradeBond.vcBeneficiary"  readonly/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" width="20%" align="right">
	                        收款账号:    
	                    </td>
	                    <td colspan="1" >
	                        <input class="nui-textbox" id="vcCollectionAccount" name="firstGradeBond.vcCollectionAccount"  width="220px" readonly/>
	                    </td>
	                    <td class="form_label td1" width="20%" align="right">
	                        大额支付号:
	                    </td>
	                    <td colspan="1" class="td1">
	                        <input class="nui-textbox" id="vcPayLine" width="220px" name="firstGradeBond.vcPayLine" readonly/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" width="20%" align="right">
	                        划款情况:    
	                    </td>
	                    <td colspan="1" >
							<input class="nui-combobox" name="firstGradeBond.cTransferMoney" dictTypeId="cTransferMoney"  id="cTransferMoney"
                        			data="[{id: 1, text: '余额不足'}, {id: 2, text: '未出款'}, {id: 3, text: '已出款'}, {id: 4, text: '对方已成功收款'} ]" value="2"
                        			showNullItem="false" multiSelect="false" showClose="true" valueFromSelect="true"
									  oncloseclick="onCloseClickValueEmpty"  width="220px"/>
	                    </td>
	                    <td class="form_label td1" width="20%" align="right">
	                    </td>
	                    <td colspan="1" class="td1">
	                    </td>
	                </tr>
	                <tr>
	                   <td class="form_label td1" width="20%" align="right" style="border-bottom: 1px solid #D3D3D3;">
	                        收款备注:
	                    </td>
	                    <td colspan="3" class="td1" style="border-bottom: 1px solid #D3D3D3;">
	                        <input class="nui-textarea" id="receivableRemark" width="515" height="40" name="firstGradeBond.vcReceivableRemark" readonly/>
	                    </td>
	                </tr>
			   </table>
			   <div class="nui-panel" title="债券详细"  style="width:100%;height: 28px;margin-top: 5px;" showToolbar="false" showFooter="true" >
			   </div>
			   <table style="width:100%;table-layout:fixed;" class="nui-form-table">
				   <tr>
				   	   	<td class="form_label td1" align="right" width="20%">
			                 主承销商:
		                </td>
		                <td colspan="3" width="85%">
		                    <input class="nui-textbox" id="vcMainUnderwriter" name="firstGradeBond.vcMainUnderwriter" width="85%"  readonly="readonly"/>
		                </td>
		                
			   	   </tr>
			   	   <tr>
				   	   	<td class="form_label td1" align="right" width="20%">
			                 副主承销商:
		                </td>
		                <td colspan="3">
		                    <input class="nui-textbox" id="vcDeputyUnderwriter" name="firstGradeBond.vcDeputyUnderwriter" width="85%"  readonly="readonly"/>
		                </td>
			   	   </tr>
			   	   <tr>
				   	   	<td class="form_label td1" align="right" width="20%">
			                 承销团:
		                </td>
		                <td colspan="3">
		                    <input class="nui-textbox" id="vcGroupUnderwriter" name="firstGradeBond.vcGroupUnderwriter" width="85%"  readonly="readonly"/>
		                </td>
			   	   </tr>
					</table>
	                <table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">
		                <tr>
		                    <td class="form_label td1" align="right" width="20%">
		                        主体类型:
		                    </td>
		                    <td colspan="1" class="td2" width="30%">
		                        <input class="nui-dictcombobox" dictTypeId="ATS_FM_ISSUE_PROPERTY" id="vcIssueProperty" width="220px" name="firstGradeBond.vcIssueProperty"  readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right" width="20%">
	                        交易对手:
	                    </td>
	                    <td colspan="1" class="td2"  width="30%">
	                        <input class="nui-textbox" name="firstGradeBond.vcBusinessObject" id="vcBusinessObject" width="220px"  readonly/>
	                    </td>
		                </tr>
		                <tr>
		                	<td class="form_label td1" align="right">
		                        主体评级:
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-dictcombobox" dictTypeId="issuerRating" width="220px" id="cIssueAppraise" 
		                        name="firstGradeBond.cIssueAppraise"  readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right">
		                        债券评级:
		                    </td>
		                    <td colspan="1" class="td2"> 
		                        <input class="nui-dictcombobox" dictTypeId="creditRating" id="cBondAppraise" 
		                        width="220px" name="firstGradeBond.cBondAppraise"  readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="form_label td1" align="right">
		                        评级机构:
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-dictcombobox" dictTypeId="outRatingOrgan" width="220px" id="vcBondAppraiseOrgan" 
		                        name="firstGradeBond.vcBondAppraiseOrgan"  readonly="readonly"/>
		                    </td>
		                   <td class="form_label td1" align="right">
							特殊条款:
						  </td>
						  <td colspan="1"  >
						  	<input width="220px" id="vcSpecialText" class="nui-dictcombobox" name="firstGradeBond.vcSpecialText" readonly="readonly" 
						     showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="specialText" />
						  </td>
		                </tr>
		                <tr>
						  <td class="form_label" align="right" >
				发行方式:
						  </td>
						  <td colspan="1" >
						  	<input style="width: 220px;" id="vcIssueType" class="nui-dictcombobox" name="firstGradeBond.vcIssueType" 
						      showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="issueType" readonly="readonly"/>
						  </td>
						  <td class="form_label td1" align="right">
		                       发行期限(年):
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" id="enExistLimite" name="firstGradeBond.enExistLimite" width="220px" readonly="readonly"/>
		                    </td>
						</tr>
						<tr>
							<td class="form_label" align="right" >
				      特殊期限:
						  </td>
						  <td colspan="1">
						    <input style="width: 220px;" class="nui-textbox" id="vcSpecialLimite" name="firstGradeBond.vcSpecialLimite" readonly="readonly" />
						  </td>
						  <td class="form_label td1" align="right">
							     下一利率跳升点数:
						  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="lNInterestRateJumpPoints" name="firstGradeBond.lNInterestRateJumpPoints"  readonly="readonly"/>
						  </td>
						</tr>
						<tr>
							<td class="form_label td1" align="right" width="20%">
			                        首次付息日:
		                    </td>
		                    <td class="td2">
								<input class="nui-datepicker" name="firstGradeBond.dInitInterestPaymentDate" id="dInitInterestPaymentDate"
								style="width: 220px;"  readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right">
								     公司净资产（元）:
							  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="enIssuerNetValue" name="firstGradeBond.enIssuerNetValue" readonly="readonly"/>
						  </td>
						</tr>
		                <tr>
		                    <td class="form_label td1" align="right">
							    城投行政级别:
						  </td>
						  <td colspan="1"  >
						  	<input width="220px" id="vcCityLevel" class="nui-dictcombobox" name="firstGradeBond.vcCityLevel" readonly="readonly"
						     showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="cityLevel" />
						  </td>
		                    <td class="form_label td1" align="right">
							    所属行业(证监会二级):
						  </td>
						  <td colspan="1">
						    <input class="nui-hidden" id="vcIssueAppraiseCsrc" width="220px" name="firstGradeBond.vcIssueAppraiseCsrc" value="<b:write property="firstGradeBond/vcIssueAppraiseCsrc" />" readonly="readonly"/>
						    <input class="nui-textbox" width="220px" id="vcIssueAppraiseCsrcName" name="firstGradeBond.vcIssueAppraiseCsrcName" 
		                       readonly="readonly"/>
						  </td>
		                </tr>
		                <tr id="morStockNameAndCode">
						  <td class="form_label td1" align="right">
							    股票名称:
						  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="vcMortStockName" name="firstGradeBond.vcMortStockName" readonly="readonly"/>
						  </td>
						  <td class="form_label td1" align="right">
							     股票代码:
						  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="vcMortStockCode" name="firstGradeBond.vcMortStockCode" readonly="readonly"/>
						  </td>
						</tr>
						<tr id="morStockAmount">
						  <td class="form_label td1" align="right">
							    股票数量:
						  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="vcMortStockAmount" name="firstGradeBond.vcMortStockAmount" readonly="readonly"/>
						  </td>
						 <td colspan="2" class="form_label">
						  </td>
						</tr>
		                <tr>
		                   <td class="form_label td1" align="right">
		                        是否具有回售权:
		                    </td>
		                    <td colspan="1" class="radio-border-top-none">
		                        <input id="cIsHaveSaleback" class="nui-dictradiogroup" name="firstGradeBond.cIsHaveSaleback" 
		                       dictTypeId="COF_YESORNO" style="float: left;" readonly/>
		                    </td>
		                    <td class="form_label td1" align="right"> 
		                        是否具有赎回权:
		                    </td>
		                    <td colspan="1" class="radio-border-top-none td2">
		                        <input id="redemptionRight" class="nui-dictradiogroup" name="firstGradeBond.cIsHaveBuyback" 
		                         dictTypeId="COF_YESORNO" style="float: left;" readonly/>
		                          
		                    </td>
		                </tr>
		                <tr>
		                    <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
		                        备注:
		                    </td>
		                    <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
		                        <input class="nui-textarea" width="515" height="40" id="vcRemarks" name="firstGradeBond.vcRemarks"
		                         readonly/>
		                    </td>
		                </tr>
		            </table>
	                <table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">
		                <tr>
		                    <td class="form_label" align="right" style="padding: 5px 5px;">
				                       已投资债券存量(万元):
				            </td>
				            <td colspan="1"  style="padding: 5px 5px;">
								<input class="nui-textbox"  id="fsumamount" style="width: 150px;float: left;margin-right: 10px;" 
								readonly="readonly" name="firstGradeBond.enCategoryMoney" />
				             </td>
				             <td class="form_label" align="right" style="padding: 5px 5px;">
		                        产品净值规模(万元):
		                    </td>
		                    <td colspan="1" style="padding: 5px 5px;">
								<input class="nui-textbox" id="enNetScale" style="width: 150px;" readonly="readonly"  name="firstGradeBond.enNetScale"/>
		                    </td> 
		                </tr>
		                <tr>
			                <td class="form_label" align="right" style="padding: 5px 5px;">
		                                                                       该笔债券投资占发行规模比例(%):
		                    </td>
		                    <td colspan="1" style="padding: 5px 5px;">
								<input name="firstGradeBond.enInvestScaleRatio" id="enInvestScaleRatio" class="nui-textbox" style="width: 150px;"
					                   		readonly="readonly"/>
		                    </td> 
		                    <td  class="form_label" align="right" style="padding: 5px 5px;">
				                                            同一发行主体占产品净值规模比例(%):
				            </td>
				            <td colspan="1" style="padding: 5px 5px;">
								<input name="firstGradeBond.enIssuerNetRatio" id="enIssuerNetRatio" class="nui-textbox" style="width: 150px;"
					                   		 readonly="readonly"/>
				             </td>
				           </tr>
		                  <tr>
				              <td class="form_label" align="right" style="padding: 5px 5px;">
			                                                                       该笔债券投资占产品净值规模比例(%):
		                    </td>
		                    <td colspan="1" style="padding: 5px 5px;">
								<input name="firstGradeBond.enInvestNetRatio" id="enInvestNetRatio" style="width: 150px;"
					                   		class="nui-textbox" readonly="readonly"/>
		                    </td> 
		                    <td  class="form_label" align="right" style="padding: 5px 5px;">
				                                            弱流动性资产规模占产品净值规模比例(%):
				            </td>
				            <td colspan="1" style="padding: 5px 5px;">
								<input name="firstGradeBond.enWeakNetRatio" id="enWeakNetRatio" style="width: 150px;"
					                   		 class="nui-textbox" readonly="readonly"/>
				             </td>
			              </tr>
		                
			   </table>
			   <div id="guiDangInfo">
			       <div class="nui-panel" title="归档信息"  style="width:100%;height: 28px;margin-top: 5px;" showToolbar="false" showFooter="true" >
			       </div>
			       <table style="width:100%;table-layout:fixed;" class="nui-form-table">
	                <tr>
	                    <td class="form_label" width="25%" align="right">
	                                               联系人与联系电话:    
	                    </td>
	                    <td colspan="1" width="25%">
	                        <input class="nui-textbox"id="vcContactInfo" width="170" name="firstGradeBond.vcContactInfo"/>
	                    </td>
	                    <td class="form_label" width="25%" align="right">
	                                               快递单号:
	                    </td>
	                    <td colspan="1" width="25%" >
	                        <input class="nui-textbox"id="vcTrackNumber" width="170" name="firstGradeBond.vcTrackNumber"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" width="25%" align="right">
	                                              归档完成情况:    
	                    </td>
	                    <td colspan="1" width="25%">
	                        <input class="nui-dictcombobox" data="[{id: 0, text: '待归档'}, {id: 1, text: '归档中'}, {id: 2, text: '归档成功'}, {id: 3, text: '归档失败'}, {id: 4, text: '无需归档'} ]" id="vcArchiveStatus"  name="firstGradeBond.vcArchiveStatus"  width="170"/>
	                    </td>
	                    <td class="form_label" width="25%" align="right">
	                    </td>
	                    <td colspan="1" width="25%" >
	                       
	                    </td>
	                </tr>
	                <tr>
	                   <td class="form_label" width="25%" align="right" style="border-bottom: 1px solid #D3D3D3;">
	                                            备注:
	                    </td>
	                    <td colspan="3"  style="border-bottom: 1px solid #D3D3D3;">
	                        <input class="nui-textarea" id="vcRemark" width="515" height="40" name="firstGradeBond.vcRemark"/>
	                    </td>
	                </tr>
	            </table>  
	            </div>
	         <div title="报量录入">
						<div class="nui-toolbar" style="border-bottom:0;padding:0px;margin-top: 2px;height: 27px;">
							<table style="width:100%;">
								<tr>
									<td style="width:100%;">
							          	&nbsp;&nbsp;报量信息
									</td>	
							        <td>
					                  	<a class="nui-button " plain="false" iconCls="icon-reload" onclick="gridReload('instReport')"  plain="false" tooltip="刷新">
					                    	&nbsp;
					                  	</a>
					                </td>
					                 <td >
										<a class="nui-button " plain="false" iconCls="icon-help" onclick="showTips()"  plain="false" tooltip="帮助">
											&nbsp;
										</a>
									</td>
								</tr>
							</table>
						</div>
						<div style="font-size:10px;color:red;">
								<div style="width:50%;float: left;padding-left: 10px;"><b>说明：</b>①报量为100万整数倍；②特殊说明请在报量说明中填写；③报价待定时为空即可</div>
								<div style="width:30%;float: right;padding-right: 10px;text-align: right;line-height: 27px;">
								报量方式：<input style="width: 130px;"  url="<%= request.getContextPath() %>/fm/instr/processUtil/reportData.txt" 
								class="nui-dictcombobox" id="cReportType" name="firstGradeBond.cReportType" readonly="readonly"/>
								</div>
						</div>
						<div id="datagrid_Amount" class="nui-form">
						     <input class="nui-hidden" name="bizId" id="bizId"  />
					    </div>
			            <div class="nui-datagrid" id="instReport"   height="100px" showPager="false" allowSortColumn="false" allowCellSelect="true" 
							 allowCellEdit="true"  url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadReport.biz.ext" multiSelect="true" allowCellValid="true" >
								<div property="columns">
									<div field="enReport"  headerAlign="center" allowSort="true">报量(万元)</div>
									<div field="enOffer"  headerAlign="center" allowSort="true">报价(%)</div>
									<div field="vcReportRemark"  headerAlign="center" allowSort="true">报量说明</div>
								</div>
						</div>
					</div>
				<div id="file_Form" style="margin-top: 5px;">
					<input class="nui-hidden" id="fileBizId" name="map/bizId"/>
					<input class="nui-hidden" name="map/attachBusType" value="1"/>
					<input class="nui-hidden" id="fileProcessinstid" name="map/processinstid"/>
				</div>
				<div id="file_grid" class="mini-datagrid" style="width:100%;height:150px;" 
					 url="com.cjhxfund.ats.fm.comm.attachUitlFunction.queryProcrssAttachment.biz.ext" 
					 dataField="attachments"  showPageInfo="false" showPager="false" pageSize="50" multiSelect="true" allowSortColumn="false" allowCellEdit="true">
					 <div property="columns">
					 	<div type="checkcolumn" width="50"></div>
						<div field="lAttachId"  headerAlign="center" visible="false">编号</div> 
						<div field="vcAttachName"  headerAlign="center" style="width: 70%;" allowSort="true">文件名</div> 
						<div field="workitemname"  headerAlign="center" allowSort="true" width="50" headerAlign="center">环节名称</div>
						<div field="vcAnnexSeal" type="checkboxcolumn" trueValue="1" falseValue="0" width="30" headerAlign="center" readOnly="true">是否用印</div>               
						<div field="vcWhetherIndia" type="checkboxcolumn" trueValue="1" falseValue="0" width="40" headerAlign="center" readOnly="true">是否用过印</div>
						<div field="cWhetherArchiving" type="checkboxcolumn" trueValue="1" falseValue="0" width="40" headerAlign="center">是否需要归档</div>
									
					 </div>
				</div>   
             </div>
         </div>
         </div>
   </div>
    <div id="footer" class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
	<table width="100%">
		<tr>
			<td style="text-align:center;" colspan="4">
				<a id="saveStock" class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">
                                                                    保存
				</a>
				<span style="display:inline-block;width:25px;"></span>
				<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel1()">
                                                                      取消
				</a>
			</td>
		</tr>
	</table>
	</div>
 </div>
   <script type="text/javascript">
     nui.parse();
     var form = new nui.Form("#dataform1");//将普通form转为nui的form
     var file_grid = nui.get("file_grid");   //附件列表对象
   </script>	
    <script src="<%=request.getContextPath() %>/fm/instr/processUtil/process.js" type="text/javascript"></script> 
   <script type="text/javascript">
    	var form = new nui.Form("#dataform1");//将普通form转为nui的form

        var contextPath = '<%=request.getContextPath() %>';
    	var activityDefID="";
    	
    	 function onAccountTypeChanged() {
	 		var vcStockType=nui.get("vcStockType").getValue();
	 		if(vcStockType!="" && vcStockType!=null){
		        if(vcStockType == 'Q' || vcStockType == 'O' ){
		        	$("#morStockNameAndCode").show();
		        	$("#morStockAmount").show();
		        }else{
			       nui.get("vcMortStockName").setValue("");
			       nui.get("vcMortStockCode").setValue("");
			       nui.get("vcMortStockAmount").setValue("");
			       $("#morStockNameAndCode").hide();
		           $("#morStockAmount").hide();
		        }
		    }
        }
        
		//缴款面值
		 function payFaceValueFun(){
		    formatNumberCommon("payFaceValue",4);
		 }
		 
		 //缴款金额(万元)
	     function paymentMoneyFun(){
	         formatNumberCommon("paymentMoney",4);
	     }
	     
		
		//刷新datagrid表格
		function gridReload(datagrid){
			var grid = nui.get(datagrid);
				grid.reload();
		}
		//取消
			function onCancel1() {
				CloseWindow("cancel");
			}
			//关闭窗口
			function CloseWindow(action) {
				if (action == "close" && form.isChanged()) {
					if(confirm("数据被修改了，是否先保存？")) {
						saveData();
					}
				}
				if (window.CloseOwnerWindow)
					return window.CloseOwnerWindow(action);
				else window.close();
			}
		
		function showTips() {
			var reportTypeMark = "";
			var json = '{"paramKey":"REPORT_TYPE_MARK"}';
			var url = "<%= request.getContextPath() %>/fm/instr/firstGradeDebt/reportMark.jsp";
			var title = "报量方式说明";
			var width = "610";
			var height = "618";
			//从系统参数获得报量方式
			$.ajax({
				url:"com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.getParamValue.biz.ext",
				type:'POST',
				data:json,
				cache:false,
				async:false,
				contentType:'text/json',
				success:function(data){
					reportTypeMark = data.paramValue;
				}
			});
			nui.open({
				url: url,
				title: title, width: width, height: height,
				onload: function () {//弹出页面加载完成
					 var iframe = this.getIFrameEl(); 
        			//调用弹出页面方法进行初始化
        			iframe.contentWindow.SetData(reportTypeMark); 
				},
				ondestroy: function (action) {//弹出页面关闭前,把新增的主体简称返回赋值给查询框
				}
			});
	}
	var urlType="";
    function initForm(type,lProcessInstId,bizId,workItemID,power,vcArchiveStatus){
        urlType=type;
        if(power=="1"){
		    if(type=="2"){
		       $("#guiDangInfo").hide();
		    }else if(type=="3"){
		       readonlyInput("cTransferMoney","cTransferMoney");
		       
	           $("#vcContactInfo input").css("background-color","#FFFFBB");
			   $("#vcTrackNumber input").css("background-color","#FFFFBB");
			   readonlyInput("vcArchiveStatus","vcArchiveStatus");
			   $("#vcRemark textarea").css("background-color","#FFFFBB");
	       }
	       //渲染行对象
				 file_grid.on("drawcell", function (e) {
				    column = e.column,
			        row=e.row;
			        if(type!="3" || vcArchiveStatus=="1" || vcArchiveStatus=="2"){
			           column.readOnly ="true";
			        }
			       var field = e.field;
				        if (field == "cWhetherArchiving" && type=="3"){
				          if(vcArchiveStatus !="1" && vcArchiveStatus !="2"){
				              e.cellStyle = "background-color:#FFFFBB;";
				           }
				        }
				}); 
	    }else{
	       readonlyInput("vcContactInfo","vcContactInfo");
	       readonlyInput("vcTrackNumber","vcTrackNumber");
	       readonlyInput("cTransferMoney","cTransferMoney");
	        $("#vcRemark textarea").attr("readonly","readonly");//解决IE兼容
			$("#vcRemark textarea").css("background-color","#f0f0f0");//置灰receivableRemark 
			
			document.getElementById("saveStock").style.display= "none";
	    }
	    var json = nui.encode({bizId:bizId,processinstid:lProcessInstId,workItemID:workItemID});
	   //从系统参数获得报量方式
			$.ajax({
				url:"com.cjhxfund.ats.fm.instr.FirstGradeBond.queryFirstGradeBond.biz.ext",
				type:'POST',
				data:json,
				cache:false,
				async:false,
				contentType:'text/json',
				success:function(data){
					form.setData({firstGradeBond:data.firstGradeBond}); //表单数据初始化
					
					onAccountTypeChanged();
					//初始化产品净值规模(万元)和已投资该发行主体债券存量(万元)的三位一逗
					formatNumberCommon("fsumamount",4);
					formatNumberCommon("enNetScale",4);
					
					//缴款面值加千分位
					payFaceValueFun();
					//缴款金额(万元)加千分位
					paymentMoneyFun();
                    //加载报量信息
			    	nui.get("bizId").setValue(bizId);
					var from_Amount = new nui.Form("#datagrid_Amount");//将普通form转为nui的form
					var json_Amount = from_Amount.getData(false,false);
					var datagrid10 = nui.get("instReport");
						datagrid10.load(json_Amount); 
				    //加载附件信息
			    	nui.get("fileBizId").setValue(bizId);
			    	nui.get("fileProcessinstid").setValue(lProcessInstId); 
			    	var file_grid = nui.get("file_grid");
					var file_Form = new nui.Form("#file_Form").getData(false,false);
					file_grid.load(file_Form);
				}
			});
		}
		grey();
		//置灰
			function grey(){
			    readonlyInput("dApplicationTime","dApplicationTime");
			    readonlyInput("dPaymentDate","dPaymentDate");
			    
			    readonlyInput("vcProductName","vcProductName");
			    readonlyInput("vcCombiName","vcCombiName");
			    readonlyInput("vcStockCode","vcStockCode");
			    readonlyInput("vcStockName","vcStockName");
			    readonlyInput("vcPaymentPlace","vcPaymentPlace");
			    readonlyInput("vcStocktypeName","vcStocktypeName");
			    readonlyInput("vcIssuerNameFull","vcIssuerNameFull");
			    readonlyInput("vcStockNameFull","vcStockNameFull");
			    readonlyInput("lIssueBeginDate","lIssueBeginDate");
			    readonlyInput("enIssueBalance","enIssueBalance");
			    readonlyInput("vcMainUnderwriter","vcMainUnderwriter");
			    readonlyInput("vcDeputyUnderwriter","vcDeputyUnderwriter");
			    readonlyInput("vcGroupUnderwriter","vcGroupUnderwriter");
			    readonlyInput("vcBusinessObject","vcBusinessObject");
			    readonlyInput("vcIssueProperty","vcIssueProperty");
			    readonlyInput("cIssueAppraise","cIssueAppraise");
			    readonlyInput("cBondAppraise","cBondAppraise");
			    readonlyInput("vcBondAppraiseOrgan","vcBondAppraiseOrgan");
			    readonlyInput("vcSpecialText","vcSpecialText");
			   readonlyInput("enExistLimite","enExistLimite");
			    readonlyInput("lNInterestRateJumpPoints","lNInterestRateJumpPoints");
			    readonlyInput("dInitInterestPaymentDate","dInitInterestPaymentDate");
			    readonlyInput("enIssuerNetValue","enIssuerNetValue");
			    readonlyInput("vcCityLevel","vcCityLevel");
			    readonlyInput("vcIssueAppraiseCsrcName","vcIssueAppraiseCsrcName");
			    readonlyInput("vcBeneficiary","vcBeneficiary");
			    
			    readonlyInput("vcCollectionAccount","vcCollectionAccount");
			    
			    readonlyInput("vcMortStockName","vcMortStockName");
			    readonlyInput("vcMortStockCode","vcMortStockCode");
			    readonlyInput("vcMortStockAmount","vcMortStockAmount");
			    
			    readonlyInput("cIsHaveSaleback","cIsHaveSaleback");
			    readonlyInput("redemptionRight","redemptionRight");
			    $("#vcRemarks textarea").attr("readonly","readonly");//解决IE兼容
			    $("#vcRemarks textarea").css("background-color","#f0f0f0");//置灰receivableRemark 
			    
			    $("#receivableRemark textarea").attr("readonly","readonly");//解决IE兼容
			    $("#receivableRemark textarea").css("background-color","#f0f0f0");//置灰 
			    readonlyInput("fsumamount","fsumamount");
			    readonlyInput("enNetScale","enNetScale");
			    readonlyInput("enInvestScaleRatio","enInvestScaleRatio");
			    readonlyInput("enIssuerNetRatio","enIssuerNetRatio");
			    readonlyInput("enInvestNetRatio","enInvestNetRatio");
			    readonlyInput("cPayType","cPayType");
			    readonlyInput("vcPayLine","vcPayLine"); 
			    
			     readonlyInput("enWeakNetRatio","enWeakNetRatio");
			    readonlyInput("cReportType","cReportType");
			    //readonlyInput("payFaceValue","payFaceValue");
			    readonlyInput("vcBallotPrice","vcBallotPrice"); 
			    readonlyInput("paymentMoney","paymentMoney");
			    readonlyInput("enPayFaceValue","enPayFaceValue"); 
			    readonlyInput("enCouponRate","enCouponRate");
			    readonlyInput("vcFrequency","vcFrequency");
			    readonlyInput("vcModeRepayment","vcModeRepayment");
			    readonlyInput("lBegincalDate","lBegincalDate");
			    readonlyInput("lEndincalDate","lEndincalDate");
			    readonlyInput("vcIssueType","vcIssueType");
			    readonlyInput("vcSpecialLimite","vcSpecialLimite");  
			    
			    $("#cTransferMoney input").css("background-color","#FFFFBB");
			}
		    function readonlyInput(inputNuiId,inputJQId){
		        nui.get(inputNuiId).readOnly="readonly";//nui禁用
			    $("#"+inputJQId+" input").attr("readonly","readonly");//解决nui禁用IE兼容
				$("#"+inputJQId+" input").css("background-color","#f0f0f0");//置灰
			}
			function onOk(){
			    if(urlType=="2"){
			       onOk1();
			    }else if(urlType=="3"){
			      onOk3();
			    }
			}
			function onOk1(){
				var lProcessInstId=nui.get("lProcessInstId").getValue();
				var cTransferMoney=nui.get("cTransferMoney").getValue();
				var paramM={
				        lProcessInstId:lProcessInstId,
				        cTransferMoney:cTransferMoney,
				}
				var json = nui.encode({map:paramM});
				nui.confirm("确认是否保存？","系统提示",function(action){
					if(action=="ok"){
						var a = nui.loading("正在处理中,请稍等...","提示");
						nui.ajax({
							url:"com.cjhxfund.ats.fm.instr.subStockIssueTrace.savehandPaymentDetailTrace.biz.ext",
							type:'POST',
							data:json,
							cache: false,
							contentType:'text/json',
							success:function(text){
								nui.hideMessageBox(a);
								var returnJson = nui.decode(text);
								if(returnJson.retCode=="true"){
					      			nui.alert("保存成功", "系统提示", function(action){
		                        		if(action == "ok" || action == "close"){
		                            		CloseWindow("saveSuccess");
		                        		}
		                    		});
					      		}
							}
				    	});
				    }
				});	
	   }	
	   function onOk3(){
	            var attachments = nui.get("file_grid").getData();
	            
				var lProcessInstId=nui.get("lProcessInstId").getValue();
				var vcContactInfo=nui.get("vcContactInfo").getValue();
				var vcTrackNumber=nui.get("vcTrackNumber").getValue();
				var vcRemark=nui.get("vcRemark").getValue();
				var processIdArr={
				        lProcessInstId:lProcessInstId,
				        vcContactInfo:vcContactInfo,
				        vcTrackNumber:vcTrackNumber,
				        vcRemark:vcRemark
				}
				var json = nui.encode({stockIssueTraceData:processIdArr,attachments:attachments});
				nui.confirm("确认是否保存？","系统提示",function(action){
					if(action=="ok"){
						var a = nui.loading("正在处理中,请稍等...","提示");
						nui.ajax({
							url:"com.cjhxfund.ats.fm.instr.subStockIssueTrace.saveStockIssueTrace.biz.ext",
							type:'POST',
							data:json,
							cache: false,
							contentType:'text/json',
							success:function(text){
								nui.hideMessageBox(a);
								var returnJson = nui.decode(text);
								if(returnJson.retCode=="true"){
					      			nui.alert("保存成功", "系统提示", function(action){
		                        		if(action == "ok" || action == "close"){
		                            		CloseWindow("saveSuccess");
		                        		}
		                    		});
					      		}
							}
				    	});
				    }
				});	
	   }	
   </script>
</body>
</html>