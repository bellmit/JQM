<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@include file="/common/js/commscripts.jsp" %>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<html>
<head>
	<title><b:write property="workitem/workItemName" /></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<script src="<%= request.getContextPath() %>/fm/instr/processUtil/instr.js" type="text/javascript"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
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
    <%
	   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
	   //业务ID
	   String bizId =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"bizId");
	   //流程ID
	   String processinstid =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"processInstID");
	   //工作项ID
	   String workItemID =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workItemID");
	   
	   //获取产品代码
	   DataObject obj = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"firstGradeBond");
	   String vcProductCode = obj.getString("vcProductCode");
	   
	   //获取工作项信息
	   DataObject workitem = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workitem");
	   String activityDefID = workitem.getString("activityDefID");
	   
	   //获取当前时间并转换为字符串类型
	   Date dateTime = new Date();
	   SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	   String myDate = format.format(dateTime);
	   
	   //定义需要用印的节点
	   String str="";
	   int tabsIndex=1;//默认选择基本信息界面

 	%>
 	<script type="text/javascript" src="<%=request.getContextPath() %>/common/js/commonjs.js"></script>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;margin: 0px;">
<div id="dataform1" style="height: 100%;">
	<div id="tabs" class="nui-tabs" height="100%" onactivechanged="activechangedFun"  activeIndex="<%=tabsIndex %>">
		<div title="基本信息">
			<!-- 左右布局控件 -->
			<div id="layout1" class="nui-layout" style="width:100%;height:100%;overflow-x:hidden;" >
				<!-- 主体内容 -->
				<div title="center" region="center" width="80%">
					<input class="nui-hidden" id="processinstid" name="processinstid" value="<%=processinstid %>"/>
				    <input class="nui-hidden" id="workItemID" name="workItemID" value="<%=workItemID %>"/>
				    <input class="nui-hidden" id="workItemName" value="<b:write property="workitem/workItemName" />">
				   <input class="nui-hidden" name="firstGradeBond.vcArchiveProcessId" id="vcArchiveProcessId" value="<b:write property="firstGradeBond/vcArchiveProcessId" />"/>
				    <input class="nui-hidden" id="lBizId" name="firstGradeBond.lBizId" value="<b:write property="firstGradeBond/lBizId" />"/>
				    <!-- 产品编码 -->
				    <input class="nui-hidden" id="vcProductCode" name="firstGradeBond.vcProductCode" value="<b:write property="firstGradeBond/vcProductCode" />"/>
				    <input class="nui-hidden" id="dBidLimitTime" name="firstGradeBond.dBidLimitTime" value="<b:write property="firstGradeBond/dBidLimitTime" />"/>

				    <table style="width:100%;table-layout:fixed;" class="nui-form-table"> 
		                <tr>
		                    <td class="form_label td1" width="20%" align="right">
		                        业务日期:    
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-datepicker" id="dApplicationTime" name="firstGradeBond.dApplicationTime" format="yyyy-MM-dd" width="220px" value="<b:write property="firstGradeBond/dApplicationTime" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right" width="20%">
				                 缴款日期:
				             </td>
				            <td colspan="1" >
								<input class="nui-datepicker" name="firstGradeBond.dPaymentDate" id="dPaymentDate" 
									value="<b:write property="firstGradeBond/dPaymentDate" />" onvaluechanged="onDrawDate" style="width: 220px;" readonly="readonly"/>
			             	</td>
		                </tr>
		                <tr>
		                  <td class="form_label td1" align="right">
		                        产品名称:
		                    </td>
		                    <td colspan="1" class="td2">
		                        <input class="nui-textbox" id="vcProductName" width="220px" name="firstGradeBond.vcProductName" value="<b:write property="firstGradeBond/vcProductName" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right">
			                        组合名称:
			                  </td>
			                  <td colspan="1" class="td2">
			                      <input class="nui-textbox"  width="220px" id="vcCombiName" name="firstGradeBond.vcCombiName" value="<b:write property="firstGradeBond/vcCombiName" />" readonly="readonly"/>
			                  </td>
		                </tr>
		                <tr>
		                    <td class="form_label td1" width="20%" align="right">
		                        债券简称:
		                    </td>
		                    <td colspan="1" class="td2">
		                        <input class="nui-textbox" id="vcStockName" width="220px" name="firstGradeBond.vcStockName" value="<b:write property="firstGradeBond/vcStockName" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right">
		                        债券代码:
		                    </td>
		                    <td colspan="1" >
		                        <input  id="vcStockCode" width="220px" class="nui-textbox"name="firstGradeBond.vcStockCode" value="<b:write property="firstGradeBond/vcStockCode" />" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                	<td class="form_label td1" align="right">
				登记托管机构:
					  		</td>
					  		<td colspan="1" class="td1">
					  			<!-- 登记托管机构 -->
					  			<input width="220px"class="nui-dictcombobox" id="vcPaymentPlace" name="firstGradeBond.vcPaymentPlace" value="<b:write property="firstGradeBond/vcPaymentPlace" />" dictTypeId="CF_JY_DJTGCS" readonly="readonly" />
					  		</td>
					  		<td class="form_label td1" align="right">
		                        债券类别:
		                    </td>
		                    <td colspan="1" class="td2">
		                        <input class="nui-textbox" width="220px" id="vcStocktypeName" name="firstGradeBond.vcStocktypeName" 
		                        value="<b:write property="firstGradeBond/vcStocktypeName" />" readonly="readonly"/>
		                        <input class="nui-hidden" id="vcStockType" name="firstGradeBond.vcStockType" value="<b:write property="firstGradeBond/vcStockType" />" />  
		                    </td>
		                </tr>
		                <tr>
		                	<td class="form_label td1" align="right">
		                        发行主体:
		                    </td>
		                    <td colspan="1" class="td2">
		                        <input class="nui-textbox" width="220px" id="vcIssuerNameFull" name="firstGradeBond.vcIssuerNameFull" value="<b:write property="firstGradeBond/vcIssuerNameFull" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label" align="right">
			      债券全称:
						  </td>
						  <td colspan="1">
						    <input style="width: 220px;" class="nui-textbox" id="vcStockNameFull" name="firstGradeBond.vcStockNameFull" value="<b:write property="firstGradeBond/vcStockNameFull" />" readonly="readonly"/>
						  </td>
		                </tr>
		                <tr>
		                	<td class="form_label" align="right" >
				发行日期:
						  </td>
						  <td colspan="1">
						  	<input style="width:220px" class="nui-datepicker" id="lIssueBeginDate" name="firstGradeBond.lIssueBeginDate" 
			                value="<b:write property="firstGradeBond/lIssueBeginDate" />" format="yyyy-MM-dd" readonly="readonly"/>
						  </td>
						  <td class="form_label td1" align="right">
		                         发行规模(亿):
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" name="firstGradeBond.enIssueBalance" id="enIssueBalance" width="220px" value="<b:write property="firstGradeBond/enIssueBalance" />" readonly="readonly"/>
		                    </td>
		                 </tr>
		            </table>
				   <!-- 环节在该活动实例下显示 -->
			        <%-- <l:in property="workitem/activityDefID" targetValue="ATS_FM_TGFH,ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_TZJLFH,ATS_FM_SCSFYYXY,ATS_FM_ZJQS,ATS_FM_PDFXYYY,ATS_FM_FXYYYFH,ATS_FM_FXYYY"> --%>    
		            <div title="缴款信息" id="panel2" class="mini-panel"  iconCls="icon-edit" style="width:100%;" 
           	showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="false" collapseOnTitleClick="true">
				   <table style="width:100%;table-layout:fixed;" border="0" class="nui-form-table">
				      <tr>
			             <td class="form_label td1" align="right" width="20%">
			               缴款面值(万元):
			             </td>
			             <td colspan="1" >
			                 <input class="nui-textbox" id="payFaceValue" value="<b:write property="firstGradeBond/enPayFaceValue" />" 
			                 	    onvaluechanged="payVcBallotNumber()"  style="width: 220px;" readonly="readonly"/>
			                 <input class="nui-hidden"  id="enPayFaceValue" name="firstGradeBond.enPayFaceValue" value="<b:write property="firstGradeBond/enPayFaceValue" />"/>   
			             </td>
			             <td class="form_label td1" align="right" width="20%">
			                 发行价格(元):
			             </td>
			             <td colspan="1">
			                 <input class="nui-textbox" name="firstGradeBond.enBallotPrice" id="enBallotPrice"
			                    value="<b:write property="firstGradeBond/enBallotPrice" />" vtype="maxLength:100;float" style="width: 220px;" onvaluechanged="payVcBallotPrice()" readonly="readonly"/>
			             </td>
				      </tr>
				      <tr>
			             <td class="form_label td1" align="right" width="20%">
			                 缴款金额(万元):
			             </td>
			             <td colspan="1">
			                 <input class="nui-textbox"  id="paymentMoney" value="<b:write property="firstGradeBond/enPaymentMoney" />"  style="width: 220px;" readonly="readonly"/>
			             	<input class="nui-hidden" name="firstGradeBond.enPaymentMoney" id="enPaymentMoney"
			                       value="<b:write property="firstGradeBond/enPaymentMoney" />"  />
			             </td>
			             <td class="form_label td1" align="right">
			                 票面利率(%):
			             </td>
			            <td colspan="1" class="td2">
							<input class="nui-textbox" name="firstGradeBond.enCouponRate" id="enCouponRate" 
								value="<b:write property="firstGradeBond/enCouponRate" />"  style="width: 220px;" readonly="readonly"/>
			             </td>
			          </tr>
			          <tr>
			             <td class="form_label td1" align="right">
			                        付息频率(次/年):
			             </td>
			             <td colspan="1" class="td2">
			                 <input class="nui-dictcombobox" valueFromSelect="false" dictTypeId="ATS_CF_JY_FREQUENCY" allowInput="true" name="firstGradeBond.vcFrequency" id="vcFrequency"
			                    value="<b:write property="firstGradeBond/vcFrequency" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"  style="width: 220px;" readonly="readonly"/>
			             </td>
			             <td class="form_label td1" align="right">
						计息起始日期:
					  </td>
					  <td colspan="1"  style="border-bottom: 1px solid #D3D3D3;" class="td1">
					    <input class="nui-datepicker" id="lBegincalDate" name="stockissueinfo.lBegincalDate" value="<b:write property="firstGradeBond/lBegincalDate" />" format="yyyy-MM-dd" style="width: 220px;" readonly="readonly"/>
					  </td>
			          </tr>
			          <tr>
			             <td class="form_label td1" align="right">
			                        还本方式:
			             </td>
			            <td colspan="1" class="td2" >
							<input class="nui-dictcombobox" dictTypeId="CF_JY_MODE_REPAYMENT" name="firstGradeBond.vcModeRepayment" id="vcModeRepayment" 
								value="<b:write property="firstGradeBond/vcModeRepayment" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"  style="width: 220px;" readonly="readonly"/>
			             </td>
			             <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
			                       到期日:
			             </td>
			             <td colspan="1"  style="border-bottom: 1px solid #D3D3D3;" class="td1">
			                 <input class="nui-datepicker" name="firstGradeBond.lEndincalDate" id="lEndincalDate"
			                    value="<b:write property="firstGradeBond/lEndincalDate" />"  style="width: 220px;" readonly="readonly"/>
			             </td>	             
			          </tr>
			          <tr>
		                    <td class="form_label td1" width="20%" align="right">
		                        缴款方式:    
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-dictcombobox" id="cPayType" dictTypeId="ATS_FM_PAYMENT" name="firstGradeBond.cPayType" width="220px" value="<b:write property="firstGradeBond/cPayType" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" width="20%" align="right">
		                        收款人户名:
		                    </td>
		                    <td colspan="1" class="td1">
		                        <input class="nui-textbox"id="vcBeneficiary" width="220px" name="firstGradeBond.vcBeneficiary" value="<b:write property="firstGradeBond/vcBeneficiary" />" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                	<td class="form_label td1" width="20%" align="right">
		                        收款账号:    
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" id="vcCollectionAccount" name="firstGradeBond.vcCollectionAccount" value="<b:write property="firstGradeBond/vcCollectionAccount" />" width="220px" readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" width="20%" align="right">
		                        大额支付行号:    
		                    </td>
		                    <td  class="td1">
		                        <input class="nui-textbox" id="vcPayLine" name="firstGradeBond.vcPayLine" value="<b:write property="firstGradeBond/vcPayLine" />" width="220px" readonly="readonly"/>
		                    </td>  
		                </tr>
		                <tr>
		                   <td class="form_label td1" width="20%" align="right" style="border-bottom: 1px solid #D3D3D3;">
		                        收款备注:
		                    </td>
		                    <td colspan="3" class="td1" style="border-bottom: 1px solid #D3D3D3;">
		                        <input class="nui-textarea" id="vcReceivableRemark" width="515" height="40" name="firstGradeBond.vcReceivableRemark" value="<b:write property="firstGradeBond/vcReceivableRemark" />" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
						   <td class="form_label td1" width="20%" align="right" >
							债券详情:
						   </td>
						   <td class="td1">
						   			<a  class='nui-button' plain='false' onclick="queryStockDetail()">
									    查看债券详情
									</a>
						   </td>
						   <td class="form_label td1" width="20%" align="right">
						  </td>
						  <td class="td1">
						   </td>
						</tr>
				   </table>
				   <%-- </l:in> --%>
				   </div>
				   <div title="债券详细"id="panel3" class="mini-panel"  iconCls="icon-edit" style="width:100%;" 
           	showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="false" collapseOnTitleClick="true">
				
			   <table style="width:100%;table-layout:fixed;" class="nui-form-table"> 
		               
		                <tr>
		                    <td class="form_label td1" width="20%" align="right">
		                        主承销商:    
		                    </td>
		                    <td colspan="3" >
		                    <input class="nui-textbox" id="vcMainUnderwriter" name="firstGradeBond.vcMainUnderwriter" width="85%" value="<b:write property="firstGradeBond/vcMainUnderwriter" />"  readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="form_label td1" align="right" width="20%">
				                 副主承销商:
			                </td>
			                <td colspan="3">
			                    <input class="nui-textbox" id="vcDeputyUnderwriter" name="firstGradeBond.vcDeputyUnderwriter" width="85%" value="<b:write property="firstGradeBond/vcDeputyUnderwriter" />"  readonly="readonly"/>
			                </td>
		                </tr>
		                <tr>
		                	 <td class="form_label td1" align="right" width="20%">
				                 承销团:
			                </td>
			                <td colspan="3">
			                    <input class="nui-textbox" id="vcGroupUnderwriter" name="firstGradeBond.vcGroupUnderwriter" width="85%" value="<b:write property="firstGradeBond/vcGroupUnderwriter" />"  readonly="readonly"/>
			                </td>
		                </tr>
		         </table>
	             <table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">
		                <tr>
		                    <td class="form_label td1" width="20%" align="right">
		                        主体类型:    
		                    </td>
		                    <td colspan="1" >
		                        <input class="nui-dictcombobox" id="vcIssueProperty" dictTypeId="ATS_FM_ISSUE_PROPERTY" width="220px" name="firstGradeBond.vcIssueProperty" value="<b:write property="firstGradeBond/vcIssueProperty" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right" width="20%">
				               交易对手:
				             </td>
				            <td colspan="1">
				            	<input class="nui-hidden"  id="lRivalId" name="firstGradeBond.lRivalId" value="<b:write property="firstGradeBond/lRivalId" />"/>
			                  	<input class="nui-textbox" id="vcBusinessObject" name="firstGradeBond.vcBusinessObject" width="220px" value="<b:write property="firstGradeBond/vcBusinessObject" />"  readonly="readonly"/>
			             	</td>
		                </tr>
		                <tr>
		                	<td class="form_label td1" align="right">
		                        主体评级:
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-dictcombobox" dictTypeId="issuerRating" width="220px" id="cIssueAppraise" 
		                        name="firstGradeBond.cIssueAppraise" value="<b:write property="firstGradeBond/cIssueAppraise" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right">
		                        债券评级:
		                    </td>
		                    <td colspan="1" class="td2"> 
		                        <input class="nui-dictcombobox" dictTypeId="creditRating" id="cBondAppraise" 
		                        width="220px" name="firstGradeBond.cBondAppraise" value="<b:write property="firstGradeBond/cBondAppraise" />" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="form_label td1" align="right">
		                        评级机构:
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-dictcombobox" dictTypeId="outRatingOrgan" width="220px" id="vcBondAppraiseOrgan" 
		                        name="firstGradeBond.vcBondAppraiseOrgan" value="<b:write property="firstGradeBond/vcBondAppraiseOrgan" />"  readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right">
							特殊条款:
						  </td>
						  <td colspan="1"  >
						  	<input width="220px" id="vcSpecialText" class="nui-dictcombobox" name="stockissueinfo.vcSpecialText"	value="<b:write property="firstGradeBond/vcSpecialText" />" readonly="readonly" 
						     showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="specialText" />
						  </td>
		                 	
		                </tr>
		                <tr>
						  <td class="form_label" align="right" >
				发行方式:
						  </td>
						  <td colspan="1" >
						  	<input style="width: 220px;" id="vcIssueType" class="nui-dictcombobox" name="firstGradeBond.vcIssueType" 
						      value="<b:write property="firstGradeBond/vcIssueType" />" showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="issueType" readonly="readonly"/>
						  </td>
						  <td class="form_label td1" align="right">
		                       发行期限(年):
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" id="enExistLimite" name="firstGradeBond.enExistLimite" width="220px" value="<b:write property="firstGradeBond/enExistLimite" />" readonly="readonly"/>
		                    </td>
						</tr>
		                <tr>
		                    <td class="form_label" align="right" >
				      特殊期限:
						  </td>
						  <td colspan="1">
						    <input style="width: 220px;" class="nui-textbox" id="vcSpecialLimite" name="firstGradeBond.vcSpecialLimite" value="<b:write property="firstGradeBond/vcSpecialLimite" />" readonly="readonly"/>
						  </td>
						  <td class="form_label td1" align="right">
							     下一利率跳升点数:
						  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="lNInterestRateJumpPoints" name="stockissueinfo.lNInterestRateJumpPoints" value="<b:write property="firstGradeBond/lNInterestRateJumpPoints" />" readonly="readonly"/>
						  </td>
						 </tr>
						 <tr>
						 	<td class="form_label td1" align="right" width="20%">
			                        首次付息日:
		                    </td>
		                    <td class="td2">
								<input class="nui-datepicker" name="firstGradeBond.dInitInterestPaymentDate" id="dInitInterestPaymentDate"
								value="<b:write property="firstGradeBond/dInitInterestPaymentDate" />" style="width: 220px;"  readonly="readonly"/>
		                    </td>
		                     <td class="form_label td1" align="right">
							     公司净资产（元）:
						  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="enIssuerNetValue" name="stockissueinfo.enIssuerNetValue" value="<b:write property="firstGradeBond/enIssuerNetValue" />" readonly="readonly"/>
						  </td>
						 </tr>
						 <tr>
		                   <td class="form_label td1" align="right">
							    城投行政级别:
						  </td>
						  <td colspan="1"  >
						  	<input width="220px" id="vcCityLevel" class="nui-dictcombobox" name="stockissueinfo.vcCityLevel" value="<b:write property="firstGradeBond/vcCityLevel" />" readonly="readonly"
						     showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="cityLevel" />
						  </td>
		                    <td class="form_label td1" align="right">
							    所属行业(证监会二级):
						  </td>
						  <td colspan="1">
						    <input class="nui-hidden" id="vcIssueAppraiseCsrc" width="220px" name="stockissueinfo.vcIssueAppraiseCsrc" value="<b:write property="firstGradeBond/vcIssueAppraiseCsrc" />" readonly="readonly"/>
		                    <input class="nui-textbox" width="220px" id="vcIssueAppraiseCsrcName" name="stockissueinfo.vcIssueAppraiseCsrcName" 
		                        value="<b:write property="firstGradeBond/vcIssueAppraiseCsrcName" />" readonly="readonly"/>
						  </td>
		                </tr>
		                <tr id="morStockNameAndCode">
						  <td class="form_label td1" align="right">
							    股票名称:
						  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="vcMortStockName" name="stockissueinfo.vcMortStockName" value="<b:write property="firstGradeBond/vcMortStockName" />" readonly="readonly"/>
						  </td>
						  <td class="form_label td1" align="right">
							     股票代码:
						  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="vcMortStockCode" name="stockissueinfo.vcMortStockCode" value="<b:write property="firstGradeBond/vcMortStockCode" />" readonly="readonly"/>
						  </td>
						</tr>
						<tr id="morStockAmount">
						  <td class="form_label td1" align="right">
							    股票抵押数量(万股):
						  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="vcMortStockAmount" name="stockissueinfo.vcMortStockAmount" value="<b:write property="firstGradeBond/vcMortStockAmount" />" readonly="readonly"/>
						  </td>
						   <td colspan="2" class="form_label">
						  </td>
						</tr>
		                <tr>
		                    <td class="form_label td1" align="right">
		                        是否具有回售权:
		                    </td>
		                    <td colspan="1" class="radio-border-top-none">
		                        <input id="resaleRight" class="nui-dictradiogroup" name="firstGradeBond.cIsHaveSaleback" 
		                       dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="firstGradeBond/cIsHaveSaleback" />" readonly/>
		                      <%--  &nbsp;<label id="resaleYear" style="float: left;display: none;">行权年：
		                       <input class="nui-textbox" name="firstGradeBond.enResaleYear" id="resaleYear" width="45"
		                        value="<b:write property="firstGradeBond/enResaleYear" />" readonly/></label> --%>
		                    </td>
		                    <td class="form_label td1" align="right"> 
		                        是否具有赎回权:
		                    </td>
		                    <td colspan="1" class="radio-border-top-none td2">
		                        <input id="redemptionRight" class="nui-dictradiogroup" name="firstGradeBond.cIsHaveBuyback" 
		                         dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="firstGradeBond/cIsHaveBuyback" />" readonly/>
		                         <%--  
		                           &nbsp;<label id="redemptionYear" style="float: left;display: none;">行权年：  
		                          <input class="nui-textbox" name="firstGradeBond.enRedemptionYear" id="redemptionYear"
		       						width="45" value="<b:write property="firstGradeBond/enRedemptionYear" />" readonly="readonly"/></label> --%>
		                    </td>
		                </tr>	
		                <tr>
		                    <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
		                        备注:
		                    </td>
		                    <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
		                        <input class="nui-textarea" width="515" id="vcRemarks" height="40" name="firstGradeBond.vcRemarks"
		                        value="<b:write property="firstGradeBond/vcRemarks" />" readonly="readonly"/>
		                       
		                    </td>
		                </tr>
	                </table>
	                <table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">
		                <tr>
		                    <td class="form_label" align="right" width="20%" >
		                       已投资债券存量(万元):
				            </td>
				            <td colspan="1" width="25%" >
								<input class="nui-textbox"  id="fsumamount" style="width: 180px;float: left;margin-right: 10px;"  
								onvaluechanged="BondAccountedCalculation" value="<b:write property="firstGradeBond/enCategoryMoney" />"/>
				             </td>
		                    <td class="form_label" align="right"  width="25%">
		                        产品净值规模(万元):
		                    </td>
		                    <td colspan="1" >
								<input class="nui-textbox" id="enNetScale" style="width: 180px;" value="<b:write property="firstGradeBond/enNetScale" />" onvaluechanged="BondAccountedCalculation"/>
								<input class="nui-hidden" name="firstGradeBond.enNetScale" id="enNetScale1" value="<b:write property="firstGradeBond/enNetScale" />"  />
		                    </td> 
		                </tr>
		                <tr>
			                <td class="form_label" align="right">
		                                                                       该笔债券投资占发行规模比例(%):
		                    </td>
		                    <td colspan="1">
								<input name="firstGradeBond.enInvestScaleRatio" id="enInvestScaleRatio" class="nui-textbox asLabel" style="width: 180px;"
					                   		value="<b:write property="firstGradeBond/enInvestScaleRatio" />" readonly="readonly"/>
		                    </td> 
		                    <td  class="form_label" align="right" >
				                                            同一发行主体占产品净值规模比例(%):
				            </td>
				            <td colspan="1">
								<input name="firstGradeBond.enIssuerNetRatio" id="enIssuerNetRatio" class="nui-textbox asLabel" style="width: 180px;"
					                   		value="<b:write property="firstGradeBond/enIssuerNetRatio" />" readonly="readonly"/>
				             </td>
			              </tr>
		                  <tr>
				              <td class="form_label" align="right">
			                                                                       该笔债券投资占产品净值规模比例(%):
		                    </td>
		                    <td colspan="1">
								<input name="firstGradeBond.enInvestNetRatio" id="enInvestNetRatio" style="width: 180px;"
					                   		value="<b:write property="firstGradeBond/enInvestNetRatio" />"class="nui-textbox asLabel" readonly="readonly"/>
		                    </td> 
		                    <td  class="form_label" align="right">
				                                            弱流动性资产规模占产品净值规模比例(%):
				            </td>
				            <td colspan="1">
								<input name="firstGradeBond.enWeakNetRatio" id="enWeakNetRatio" style="width: 180px;"
					                   		value="<b:write property="firstGradeBond/enWeakNetRatio" />" class="nui-textbox" readonly="readonly"/>
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
									<td >
				                  		<a class="nui-button " plain="false" iconCls="icon-search" onclick="reportHistory()"  plain="false" tooltip="报量历史">
				                    		&nbsp;
				                  		</a>
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
								报量方式：<input style="width: 130px;" id="cReportType"  url="<%= request.getContextPath() %>/fm/instr/processUtil/reportData.txt" 
								class="nui-dictcombobox"  value="<b:write property="firstGradeBond/cReportType" />" readonly="readonly"/>
								</div>
						</div>
			            <div class="nui-datagrid" id="instReport"   height="100px" showPager="false" allowSortColumn="false" allowCellSelect="true" 
							 allowCellEdit="true"  url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadReport.biz.ext?bizId=<%=bizId %>" multiSelect="true" allowCellValid="true" >
								<div property="columns">
									<div field="enReport"  headerAlign="center" allowSort="true">报量(万元)</div>
									<div field="enOffer"  headerAlign="center" allowSort="true">报价(%)</div>
									<div field="vcReportRemark"  headerAlign="center" allowSort="true">报量说明</div>
								</div>
						</div>
					</div>	            
		       </div>
				<!-- 投资范围 -->
				<div  title="投资范围" region="east" width="220" showCloseButton="false" showSplitIcon="true" expanded="false">	
		    		<iframe src="<%=request.getContextPath() %>/fm/comm/ProductInvestmentRange.jsp?vcProductCode=<%=vcProductCode %>" width="100%" height="100%" scrolling="auto" frameborder="0"></iframe>
				</div>
			</div>
		</div>
		<div title="审批内容"	id="panel5" class="mini-panel" style="width:100%;" 
   				showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="false" collapseOnTitleClick="true">
	   				<%@include file="/fm/instr/subStockIssueTrace/processControlTrace.jsp" %>
		</div>
		<div title="流程信息" url="com.cjhxfund.ats.fm.comm.processGraph.flow?processInstID=<%=processinstid %>&workItemID=<%=workItemID %>&bizId=<%=bizId %>"></div>
		<l:in property="workitem/activityDefID" targetValue="ATS_FM_XYYYPD,ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_SCSFYYXY,ATS_FM_ZJQS,ATS_FM_PDFXYYY,ATS_FM_FXYYYFH,ATS_FM_FXYYY">
			<div title="传真发送列表" url="<%=request.getContextPath() %>/fm/instr/firstGradeDebt/eastFaxList.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>&type=1" refreshOnClick="true"></div>
		</l:in>
</div>

	<script type="text/javascript">
		nui.parse();
    	//获取应用名称
    	var contextPath = '<%=request.getContextPath() %>';
    	var activityDefID = '<%=activityDefID %>';   //获取活动定义ID
    	var file_grid = nui.get("file_grid");   //附件列表对象
    	var form = new nui.Form("#dataform1");//将普通form转为nui的form
    	
    	//加载报量信息
		//var instReport_from = new nui.Form("instReport_from");
		var instReport = nui.get("instReport");
    	instReport.load();
    	
    	var vcFrequency = nui.get("vcFrequency").getValue();
    	if(vcFrequency==""){
    	   nui.get("vcFrequency").setText("<b:write property="firstGradeBond/vcFrequency" />");
    	}
    	
    //tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	function activechangedFun(){
		//标签切换时同时刷新“今日待处理”，模块数据
		//reloadWaitConfirmFun();
	
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tabs").getActiveTab().title;
		
		if(activeTabTitle.indexOf("审批内容")!=-1){
			//附件列表
		    loademployeeGrid("file_grid","#file_Form");	
		}
	}
	
	//刷新datagrid表格
	function gridReload(datagrid){
		var grid = nui.get(datagrid);
			grid.reload();
	}	
		 
	 //缴款金额(万元)
     function paymentMoneyFun(){
         formatNumberCommon("paymentMoney",4);
     }
     
     
     function payVcBallotNumber(){
     	var payFaceValue = nui.get("payFaceValue").getValue().replace(/,/gi,'');
     	//验证缴款面值是否为正数
     	var reg = /^([0-9]+)(\.\d{1,4})?$/;
		if (!reg.test(payFaceValue))
		{
			nui.alert("缴款面值不能包含负数、字母、特殊字符，请输入正数如4。","系统提示");
			return;
		}
		
     	formatNumberCommon("payFaceValue",4);  //缴款面值加入千分位
     	
     	nui.get("enPayFaceValue").setValue(payFaceValue);      //将缴款面值设置为隐藏值
     	
     	var ballotPrice  = nui.get("enBallotPrice").getValue().replace(/,/gi,'');   //获取中标价格
     	if(ballotPrice != null && ballotPrice != ""){
     		payVcBallotPrice(); //计算缴款金额
     		//调用判断缴款金额是否大于投标金额方法
     		//judgeInvestBalance();//修改时不调用，提交时才调用
     	}
     }
     
   
     function payVcBallotPrice(){
     	var payFaceValue = nui.get("payFaceValue").getValue().replace(/,/gi,'');  //获取中标数量
     	var ballotPrice  = nui.get("enBallotPrice").getValue().replace(/,/gi,'');   //获取中标价格
     	//alert(payFaceValue +"             "+ballotPrice);
     	//验证中标价格是否为正数
     	var reg = /^(([0-9]+)|([0-9]+\.[0-9]{1,4}))$/;
		if (!reg.test(ballotPrice))
		{
			nui.alert("中标价格不能包含负数、字母、特殊字符，请输入正数如4。","系统提示");
			return;
		}
     	//alert(payFaceValue*ballotPrice);
     	//计算缴款金额并赋值
     	nui.get("paymentMoney").setValue(payFaceValue*ballotPrice/100);
     	paymentMoneyFun();    //调用方法给参数加上千分位
     	
     	nui.get("enPaymentMoney").setValue(payFaceValue*ballotPrice/100);
     	
     	//调用判断缴款金额是否大于投标金额方法
     	//judgeInvestBalance();//修改时不调用，提交时才调用
     }
     
	 function checkCollectionAccount(e){
		var reg = /^[A-Za-z0-9]+$/;   // 以19位数字开头，以19位数字结尾
		if( !reg.test(e.value) )
		{
			nui.alert("收款账号格式错误，只能输入数字与26个英文字母！","系统提示");
			return;
		}
     }
     
     function checkBankLine(e){
		var reg = /^[A-Za-z0-9]+$/;   // 以19位数字开头，以19位数字结尾
		if( !reg.test(e.value) )
		{
			nui.alert("大额支付行号格式错误，只能输入数字与26个英文字母！","系统提示");
			return;
		}
     }
          
     //判断缴款金额是否大于投标金额
     function judgeInvestBalance(){
     	var enInvestBalance = nui.get("vcInvestBalance").getValue();    //投标金额
 		var enPaymentMoney = nui.get("enPaymentMoney").getValue();		//缴款金额
 		if(enPaymentMoney.toString()!="" && enInvestBalance.toString()!=""){
 			//判断缴款金额是否大于投标金额
 			if(enPaymentMoney > enInvestBalance){
			
				openUpdateReport("缴款金额大于投标金额");
				return false;
			}else{
				return reportUpdateStatusAlert();
			}
 		}else{
 			//缴款金额或者投标金额 为空则不允许继续提交
 			nui.alert("缴款金额或者投标金额不允许为空");
 			return false;
 		}
		
     }
    
    
    
  
  
    //默认加载审核信息
    var operateText = nui.get("operateType").getSelected().text;
	nui.get("comments").setValue(operateText);
    
	
	function getNowFormatDate() {
    	var date = new Date();
    	var seperator1 = "-";
  
    	var year = date.getFullYear();
    	var month = date.getMonth() + 1;
    	var strDate = date.getDate();
   		if (month >= 1 && month <= 9) {
        	month = "0" + month;
    	}
    	if (strDate >= 0 && strDate <= 9) {
        	strDate = "0" + strDate;
    	}
    	var currentdate = year + seperator1 + month + seperator1 + strDate;
    	return currentdate;
	}
	



	function vcTransactionType(){
		var vcTransactionType = nui.get("vcTransactionType").getValue();
		if(vcTransactionType == 3){
			document.getElementById("label1").style.display="inline";
			document.getElementById("label2").style.display="inline";
			document.getElementById("label3").style.display="inline";
		}else{
			document.getElementById("label1").style.display="none";
			document.getElementById("label2").style.display="none";
			document.getElementById("label3").style.display="none";
		}
	}
	
	function onAccountTypeChanged() {
	 		var vcStockType=nui.get("vcStockType").getValue();
	 		if(vcStockType!="" && vcStockType!=null){
		        if(vcStockType == 'Q' || vcStockType == 'O' ){
		        	$("#morStockNameAndCode").show();
		        	$("#morStockAmount").show();
		        }else{
			       $("#morStockNameAndCode").hide();
		           $("#morStockAmount").hide();
		        }
		    }
        }	
    </script>
    <script	src="<%= request.getContextPath() %>/fm/instr/processUtil/process.js" type="text/javascript"></script>
	<script type="text/javascript">
		//计算千分位
		formatNumberCommon("payFaceValue",4);
		formatNumberCommon("paymentMoney",4);
		//债券类别为可转债时，显示股票名称，股票代码，抵押股票数量
		onAccountTypeChanged();
		
		
		//调用附件查询方法
     	loademployeeGrid("file_grid","#file_Form");	
     
     	
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
		//查询债券详情
	  function queryStockDetail(){
	    var lStockIssueId= nui.get("stockissueinfo.lStockIssueId").getValue();
	  	nui.open({
                    url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueQueryDetail.jsp?lStockIssueId="+lStockIssueId,
                    title: "详细信息", 
                    width: 980, 
           			height: 700,
                    //allowResize:false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        iframe.contentWindow.initForm();
                    },
                    ondestroy: function (action) {
                        if(action=="saveSuccess"){
	                        grid.reload();
                   	 	}
                    }
                });
	  }
	  
	// 报量历史展示
	function reportHistory(){
		var investNo = nui.get("lInvestNo").value;
		nui.open({
			url: "<%= request.getContextPath() %>/fm/comm/showReportHistory.jsp",
			title: "历史报量", 
			width: 650, 
			height: 450,
			onload: function () {//弹出页面加载完成
				 var iframe = this.getIFrameEl(); 
				//调用弹出页面方法进行初始化
				iframe.contentWindow.setData(investNo); 
			},
			ondestroy: function (action) {//弹出页面关闭前,把新增的主体简称返回赋值给查询框
			}
		});
	}
	
	function processSubmit(){
        var processinstid=nui.get("processinstid").getValue();
        var workItemID=nui.get("workItemID").getValue();
        var lBizId=nui.get("lBizId").getValue();
        var operateType=nui.get("operateType").getValue();
		var comments=nui.get("comments").getValue();
		var vcArchiveProcessId=nui.get("vcArchiveProcessId").getValue();
		var processIdArr={
		        processinstid:processinstid,
		        workItemID:workItemID,
		        lBizId:lBizId,
		        operateType:operateType,
		        comments:comments,
		        vcArchiveProcessId:vcArchiveProcessId
		}
		var json = nui.encode({stockIssueTraceData:processIdArr});
		nui.confirm("确认是否提交？","系统提示",function(action){
			if(action=="ok"){
				var a = nui.loading("正在处理中,请稍等...","提示");
				nui.ajax({
					url:"com.cjhxfund.ats.fm.instr.subStockIssueTrace.subStockIssueTrace.biz.ext",
					type:'POST',
					data:json,
					cache: false,
					contentType:'text/json',
					success:function(text){
						nui.hideMessageBox(a);
						var returnJson = nui.decode(text);
						if(returnJson.retCode=="true"){
						    try{
			    			if (!!window.ActiveXObject || "ActiveXObject" in window){//如果是IE浏览器
				              	 window.opener.history.go(0);
				              }else{
				              	window.opener.reloadData();
				              }
				           }catch(e){
			    			}
			      			nui.alert("流程提交成功","系统提示",function(a){
			    			//返回我的代办任务页面
		    				CloseWindow("confirmSuccess");
	    				    }); 
			      		}else{
			      		    nui.alert("流程提交失败！");
			      		}
					}
		    	});
		    }
		});	
  	 }
   grey();
    //置灰
	function grey(){
	  readonlyInput("dApplicationTime","dApplicationTime");
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
	  readonlyInput("vcMortStockName","vcMortStockName");
	  readonlyInput("vcMortStockCode","vcMortStockCode");
	  readonlyInput("vcMortStockAmount","vcMortStockAmount");
	  readonlyInput("resaleRight","resaleRight");
	  readonlyInput("vcIssueType","vcIssueType");
	  readonlyInput("redemptionRight","redemptionRight");
	  readonlyInput("vcSpecialLimite","vcSpecialLimite");
	  readonlyInput("cPayType","cPayType");
	  
	  $("#vcRemarks textarea").attr("readonly","readonly");//解决IE兼容
	  $("#vcRemarks textarea").css("background-color","#f0f0f0");//置灰 
	  
	  readonlyInput("fsumamount","fsumamount");
	  readonlyInput("enNetScale","enNetScale");
	  readonlyInput("enInvestScaleRatio","enInvestScaleRatio");
	  readonlyInput("enIssuerNetRatio","enIssuerNetRatio");
	  readonlyInput("enInvestNetRatio","enInvestNetRatio");
	  readonlyInput("enWeakNetRatio","enWeakNetRatio");
	  readonlyInput("cReportType","cReportType");
	  readonlyInput("payFaceValue","payFaceValue");
	  readonlyInput("enBallotPrice","enBallotPrice");
	  readonlyInput("paymentMoney","paymentMoney");
	  readonlyInput("dPaymentDate","dPaymentDate");
	  readonlyInput("enCouponRate","enCouponRate");
	  readonlyInput("vcFrequency","vcFrequency");
	  readonlyInput("vcModeRepayment","vcModeRepayment");
	  readonlyInput("lBegincalDate","lBegincalDate");
	  readonlyInput("lEndincalDate","lEndincalDate");
	  readonlyInput("vcBeneficiary","vcBeneficiary");
	  readonlyInput("vcCollectionAccount","vcCollectionAccount");
	  readonlyInput("vcPayLine","vcPayLine");
	  $("#vcReceivableRemark textarea").attr("readonly","readonly");//解决IE兼容
	  $("#vcReceivableRemark textarea").css("background-color","#f0f0f0");//置灰 
	  
	  readonlyInput("theme","theme");
	  readonlyInput("recvName","recvName");
	  readonlyInput("recvCompany","recvCompany");
	  readonlyInput("vcTelephoneNumber","vcTelephoneNumber");
	  readonlyInput("FaxNumber","FaxNumber");
	  $("#faxComments textarea").attr("readonly","readonly");//解决IE兼容
	  $("#faxComments textarea").css("background-color","#f0f0f0");//置灰 
	}
    function readonlyInput(inputNuiId,inputJQId){
	    $("#"+inputJQId+" input").attr("readonly","readonly");//解决nui禁用IE兼容
		$("#"+inputJQId+" input").css("background-color","#f0f0f0");//置灰
	}
	</script>
</body>
</html>