<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<!-- 
  - Author(s): CJ-WB-DT13
  - Date: 2016-03-01 15:29:20
  - Description:
-->
<%
   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
   //业务ID
   String bizId =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"bizId");
   //流程ID
   String processinstid =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"processinstid");
   //工作项ID
   String workItemID =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workItemID");
   
   //获取产品代码
   DataObject obj = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"cfjybusinessbonetable");
   String combProductCode = obj.getString("combProductCode");
   
 %>
<head>
<title><b:write property="workitem/workItemName" /></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
    
    <style type="text/css">
      .td1{
        border-right: 1px solid #D3D3D3;
        border-left: 1px solid #D3D3D3;
      }
      .td2{
        border-right: 1px solid #D3D3D3;
      }
      
      .p{
           border-bottom: 1px solid #D3D3D3;     
        }
        P{
          margin: 0px;padding: 0px;
        }
    </style>
    
</head>
<body style="height: 99%;">
 <div id="dataform1" style="height: 100%;">
   <div class="nui-tabs" id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">
		<!-- 业务类型标签页开始... -->
		<div title="基本信息" refreshOnClick="true">
		    <input class="nui-hidden" id="processinstid" name="processinstid" value="<%=processinstid %>"/>
		    <input class="nui-hidden" id="workItemID" name="workItemID" value="<%=workItemID %>"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.investproductnum" name="cfjybusinessbonetable.investproductnum" value="<b:write property="cfjybusinessbonetable/investproductnum" />"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.btId" name="cfjybusinessbonetable.btId" value="<b:write property="cfjybusinessbonetable/btId" />"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.bizId" name="cfjybusinessbonetable.bizId" value="<b:write property="cfjybusinessbonetable/bizId" />"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.businesstype" name="cfjybusinessbonetable.businesstype" value="<b:write property="cfjybusinessbonetable/businesstype" />"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.combProductCode" name="cfjybusinessbonetable.combProductCode" value="<b:write property="cfjybusinessbonetable/combProductCode" />"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.vcCombiNo" name="cfjybusinessbonetable.vcCombiNo" value="<b:write property="cfjybusinessbonetable/vcCombiNo" />"/>
		    <input class="nui-hidden"  name="bpsParam.vcSource" value="<b:write property="cfjybusinessbonetable/vcSource" />"/>
		    <!-- 投资比例参数 -->
		    <input class="nui-hidden"  name="cfjybusinessbonetable.investmentOccupyIssuesize" value="<b:write property="cfjybusinessbonetable/investmentOccupyIssuesize" />"/>
		    <input class="nui-hidden"  name="cfjybusinessbonetable.productEquityRatio" value="<b:write property="cfjybusinessbonetable/productEquityRatio" />"/>
		    <input class="nui-hidden"  name="cfjybusinessbonetable.bondOccupyProductRatio" value="<b:write property="cfjybusinessbonetable/bondOccupyProductRatio" />"/>
		    <input class="nui-hidden"  name="cfjybusinessbonetable.weakLiquidityRatio" value="<b:write property="cfjybusinessbonetable/weakLiquidityRatio" />"/>
		    
		    <table style="width:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td class="form_label td1" width="17%" align="right">
                        业务日期:    
                    </td>
                    <td colspan="1" width="33%">
                        <input class="nui-datepicker" name="cfjybusinessbonetable.processDate" width="170" value="<b:write property="cfjybusinessbonetable/processDate" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                        主承机构:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" name="cfjybusinessbonetable.mainBearingMechanism" width="170" value="<b:write property="cfjybusinessbonetable/mainBearingMechanism" />" readonly/>
                    </td>
                </tr>
                <tr>
                  <td class="form_label td1" width="17%" align="right">
                        产品名称:
                    </td>
                    <td colspan="1" width="33%" class="td2">
                        <input class="nui-textbox" id="combProductName" width="170" name="cfjybusinessbonetable.combProductName" value="<b:write property="cfjybusinessbonetable/combProductName" />" readonly/>
                    </td>
                    <td class="form_label td1" width="25%" align="right">
	                        组合名称:
	                  </td>
	                  <td colspan="1" width="25%" class="td2">
	                      <input class="nui-textbox" id="vcCombiName" width="170" name="cfjybusinessbonetable.vcCombiName" value="<b:write property="cfjybusinessbonetable/vcCombiName" />" readonly/>
	                  </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        债券代码:
                    </td>
                    <td colspan="1">
                        <%--<input class="nui-textbox" name="cfjybusinessbonetable.investProductCode"/>--%>
                        <input  id="investProductCode" width="170" class="nui-textbox"name="cfjybusinessbonetable.investProductCode" value="<b:write property="cfjybusinessbonetable/investProductCode" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                        债券名称:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" id="investProductName" width="170" name="cfjybusinessbonetable.investProductName" value="<b:write property="cfjybusinessbonetable/investProductName" />" readonly/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        登记托管场所:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" width="170" name="cfjybusinessbonetable.paymentplace" value="<b:write property="cfjybusinessbonetable/paymentplace" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                        发行主体:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" width="170" name="cfjybusinessbonetable.ratingname" value="<b:write property="cfjybusinessbonetable/ratingname" />" readonly/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        主体类型:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_ZTLX" width="170" name="cfjybusinessbonetable.ratingType" value="<b:write property="cfjybusinessbonetable/ratingType" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                        主体评级:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" width="170" id="subjectrating"
                         name="cfjybusinessbonetable.subjectrating" value="<b:write property="cfjybusinessbonetable/subjectrating" />" readonly/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        投标金额(万元):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="cfjybusinessbonetable.investcount" width="170" value="<b:write property="cfjybusinessbonetable/investcount" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                        投标利率(%):
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" name="cfjybusinessbonetable.interestrate" value="<b:write property="cfjybusinessbonetable/interestrate" />" width="170" readonly/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        债项评级:
                    </td>
                    <td colspan="1" class="td2"> 
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" id="bondrating"
                         width="170" name="cfjybusinessbonetable.bondrating" value="<b:write property="cfjybusinessbonetable/bondrating" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                        债券种类:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY" width="170" 
                        id="investcategory" name="cfjybusinessbonetable.investcategory" value="<b:write property="cfjybusinessbonetable/investcategory" />" readonly/>
                    </td>
                </tr>
                <%--<tr>
                    
                    <td class="form_label">
                        发行主体类型:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="cfjybusinessbonetable.ratingType"/>
                    </td>
                </tr>--%>
                
                <tr>
                    <td class="form_label td1" align="right">
                        评级机构:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_RATING_AGENCIES" width="170"
                         id="ratingAgencies" name="cfjybusinessbonetable.ratingagencies" value="<b:write property="cfjybusinessbonetable/ratingagencies" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                         发行规模(万元):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="cfjybusinessbonetable.issueSize" width="170" value="<b:write property="cfjybusinessbonetable/issueSize" />" readonly/>
                    </td>
                </tr>
                <tr>
                     <td class="form_label td1" align="right">
                        已投资该发行主体证券存量(万元):
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" name="cfjybusinessbonetable.categorymoney" width="170" value="<b:write property="cfjybusinessbonetable/categorymoney" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                        债券期限(年):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="cfjybusinessbonetable.categorydate" width="170" value="<b:write property="cfjybusinessbonetable/categorydate" />" readonly/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        产品净值规模(万元):
                    </td>
                    <td colspan="1" class="td2">
						<input class="nui-textbox" name="cfjybusinessbonetable.netWorthScale" id="netWorthScale" 
						style="width: 170px;" onvaluechanged="calculationNetWorthScale" value="<b:write property="cfjybusinessbonetable/netWorthScale" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                        首次付息日:
                    </td>
                    <td colspan="1" class="td2">
						<input class="nui-datepicker" name="cfjybusinessbonetable.initialInterestPaymentDate" id="initialInterestPaymentDate"
						value="<b:write property="cfjybusinessbonetable/initialInterestPaymentDate" />" style="width: 170px;"  readonly/>
                    </td>
                </tr>
                <tr> 
                   <td class="form_label td1" align="right">
                        是否具有回售权:
                    </td>
                    <td colspan="1" class="radio-border-top-none">
                        <input id="resaleRight" class="nui-dictradiogroup" name="cfjybusinessbonetable.resaleRight" 
                       dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="cfjybusinessbonetable/resaleRight" />" readonly/>
                      
                       &nbsp;<label id="resaleYear" style="float: left;display: none;">行权年：
                       <input class="nui-textbox" name="cfjybusinessbonetable.resaleYear" id="resaleYear" width="45"
                        value="<b:write property="cfjybusinessbonetable/resaleYear" />" readonly/></label>
                    </td>
                    <td class="form_label td1" align="right"> 
                        是否具有赎回权:
                    </td>
                    <td colspan="1" class="radio-border-top-none td2">
                        <input id="redemptionRight" class="nui-dictradiogroup" name="cfjybusinessbonetable.redemptionRight" 
                         dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="cfjybusinessbonetable/redemptionRight" />" readonly/>
                         
                           &nbsp;<label id="redemptionYear" style="float: left;display: none;">行权年：  
                          <input class="nui-textbox" name="cfjybusinessbonetable.redemptionYear" id="redemptionYear"
       						width="45" value="<b:write property="cfjybusinessbonetable/redemptionYear" />" readonly="readonly"/></label>
                    </td>
                </tr>
                <tr>
                  <td class="form_label td1" align="right">
                        是否关联交易:
                    </td>
                    <td colspan="3" class="radio-border-top-none td2" >
                       
                        <input id="isInquiry" class="nui-dictradiogroup"name="cfjybusinessbonetable.associationBetween" 
                        dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="cfjybusinessbonetable/associationBetween" />" readonly/>
                         
                          <input class="nui-textbox" name="cfjybusinessbonetable.associationRemark" id="associationRemark" 
                          style="display:none;"width="150" value="<b:write property="cfjybusinessbonetable/associationRemark" />"/>
                    </td>
                </tr>
                <l:in property="workitem/activityDefID" targetValue="manualActivity6,manualActivity7">
                <tr>
                  <td class="form_label td1" align="right">债券占比：</td>
                  <td colspan="3" style="padding: 0px;margin: 0xp;" class="td2">
                   <p class="p"><label style="margin-left: 5px;font-weight: inherit;">该笔债券投资占发行规模比例(%): </label>
                   				<label style="font-weight: inherit;"><b:write property="cfjybusinessbonetable/investmentOccupyIssuesize" /></label></p>
                   <p class="p"><label style="margin-left: 5px;font-weight: inherit;">同一发行人占产品净值规模比例(%): </label>
                   				<label style="font-weight: inherit;"><b:write property="cfjybusinessbonetable/productEquityRatio" /></label></p>
                   <p class="p"><label style="margin-left: 5px;font-weight: inherit;">该笔债券投资占产品净值规模比例(%): </label>
                   				<label style="font-weight: inherit;"><b:write property="cfjybusinessbonetable/bondOccupyProductRatio" /></label></p>
                   <p><label style="margin-left: 5px;font-weight: inherit;">弱流动性资产规模占产品净值规模比例(%): </label>
                   				<label style="font-weight: inherit;"><b:write property="cfjybusinessbonetable/weakLiquidityRatio" /></label></p>
                  </td>
                </tr>	
                </l:in>			
                <tr>
                    <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
                        备注:
                    </td>
                    <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
                        <input class="nui-textarea" width="515" height="40" name="cfjybusinessbonetable.remarks" value="<b:write property="cfjybusinessbonetable/remarks" />" />
                    </td>
                </tr>
            </table>
            <l:equal property="workitem/activityDefID" targetValue="manualActivity9">
            <div class="nui-panel" title="缴款信息"  style="width:100%;height: 28px;margin-top: 5px;" showToolbar="false" showFooter="true" >
		   </div>
		   <table style="width:100%;table-layout:fixed;" class="nui-form-table">
		      <tr>
	             <td class="form_label td1" align="right" width="17%">
	                        缴款面值(万元):
	             </td>
	             <td colspan="1" class="radio-border-top-none" width="33%" >
	                 <input class="nui-textbox" name="cfjybusinessbonetable.payFaceValue" id="payFaceValue"
	                    value="<b:write property="cfjybusinessbonetable/payFaceValue" />"  style="width: 170px;" onblur="payFaceValueFun()" required="true"/>
	             </td>
	             <td class="form_label td1" align="right" width="17%">
	                        缴款日期:
	             </td>
	            <td colspan="1" class="td2" width="33%">
					<input class="nui-datepicker" name="cfjybusinessbonetable.paymentDate" id="paymentDate" 
						value="<b:write property="cfjybusinessbonetable/paymentDate" />"  style="width: 170px;" required="true"/>
	             </td>
	          </tr>
	          <tr>
	             <td class="form_label td1" align="right" width="17%">
	                        缴款金额(万元):
	             </td>
	             <td colspan="1" class="radio-border-top-none" width="33%" >
	                 <input class="nui-textbox" name="cfjybusinessbonetable.paymentMoney" id="paymentMoney"
	                    value="<b:write property="cfjybusinessbonetable/paymentMoney" />"  style="width: 170px;" onblur="paymentMoneyFun()"/>
	             </td>
	             <td class="form_label td1" align="right">
	                        发行价格(元):
	             </td>
	             <td colspan="1" >
	                 <input class="nui-textbox" name="cfjybusinessbonetable.issuePrice" id="issuePrice"
	                    value="<b:write property="cfjybusinessbonetable/issuePrice" />"  style="width: 170px;" />
	             </td>
	          </tr>
	          <tr>
	             <td class="form_label td1" align="right">
	                        票面利率(%):
	             </td>
	            <td colspan="1" class="td2">
					<input class="nui-textbox" name="cfjybusinessbonetable.couponRate" id="couponRate" 
						value="<b:write property="cfjybusinessbonetable/couponRate" />"  style="width: 170px;" required="true"/>
	             </td>
	             <td class="form_label td1" align="right">
	                        付息频率:
	             </td>
	             <td colspan="1">
	                 <input class="nui-dictcombobox" dictTypeId="CF_JY_FREQUENCY" name="cfjybusinessbonetable.frequency" id="frequency"
	                    value="<b:write property="cfjybusinessbonetable/frequency" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"  style="width: 170px;" />
	             </td>
	          </tr>
	          <tr>
	              <td class="form_label td1" align="right">
	                        还本方式:
	             </td>
	            <td colspan="1" class="td2" >
					<input class="nui-dictcombobox" dictTypeId="CF_JY_MODE_REPAYMENT" name="cfjybusinessbonetable.modeRepayment" id="modeRepayment" 
						value="<b:write property="cfjybusinessbonetable/modeRepayment" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"  style="width: 170px;" />
	             </td>
	             <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
	                        计息起始日:
	             </td>
	             <td colspan="1"  style="border-bottom: 1px solid #D3D3D3;">
	             <input class="nui-datepicker" name="cfjybusinessbonetable.startingDateInterest" id="startingDateInterest" 
						value="<b:write property="cfjybusinessbonetable/startingDateInterest" />"  style="width: 170px;" />
	             </td>
	           </tr>
	           <tr>   
	             <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
	                        计息截止日:
	             </td>
	             <td colspan="3"  style="border-bottom: 1px solid #D3D3D3;">
	             <input class="nui-datepicker" name="cfjybusinessbonetable.deadlineInterest" id="deadlineInterest" 
						value="<b:write property="cfjybusinessbonetable/deadlineInterest" />"  style="width: 170px;" />
	             </td>
	             
	          </tr>
		   </table>
		   <l:in property="cfjybusinessbonetable/vcSource" targetValue="2" scope="request" >
		   	  <div class="nui-panel" title="收款账户信息"  style="width:100%;height: 28px;margin-top: 5px;" showToolbar="false" showFooter="true" >
		       </div>
			   <table style="width:100%;table-layout:fixed;" class="nui-form-table">
	                <tr>
	                    <td class="form_label td1" width="17%" align="right">
	                        交易方式:    
	                    </td>
	                    <td colspan="1" width="33%">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_JYFS" name="cfjybusinessbonetable.transactionType"
	                          value="<b:write property="cfjybusinessbonetable/transactionType" />" width="170" required="true"  />
	                    </td>
	                    <td class="form_label td1" width="17%" align="right">
	                        收款人户名:
	                    </td>
	                    <td colspan="1" width="33%" class="td1">
	                        <input class="nui-textbox"id="combProductName" width="170" name="cfjybusinessbonetable.beneficiary"
	                         value="<b:write property="cfjybusinessbonetable/beneficiary" />" required="true"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" width="17%" align="right">
	                        收款账号:    
	                    </td>
	                    <td colspan="1" width="33%">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.collectionAccount" width="170" 
	                        value="<b:write property="cfjybusinessbonetable/collectionAccount" />" required="true"/>
	                    </td>
	                    <td class="form_label td1" width="17%" align="right">
	                        开户行行号:
	                    </td>
	                    <td colspan="1" width="33%" class="td1">
	                        <input class="nui-textbox" id="bankLine" width="170" name="cfjybusinessbonetable.bankLine"
	                        value="<b:write property="cfjybusinessbonetable/bankLine" />" required="true"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" width="17%" align="right">
	                        大额支付行号:    
	                    </td>
	                    <td colspan="3" class="td1">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.payLine" width="170"
	                         value="<b:write property="cfjybusinessbonetable/payLine" />"  required="true"/>
	                    </td>
	                </tr>
	                <tr>
	                   <td class="form_label td1" width="17%" align="right" style="border-bottom: 1px solid #D3D3D3;">
	                        备注:
	                    </td>
	                    <td colspan="3" class="td1" style="border-bottom: 1px solid #D3D3D3;">
	                        <input class="nui-textarea" id="receivableRemark" width="515" height="40"
	                         name="cfjybusinessbonetable.receivableRemark"  value="<b:write property="cfjybusinessbonetable/receivableRemark" />" />
	                    </td>
	                </tr>
	            </table>
	           </l:in> 	
		   </l:equal>
          </div>  
		<div title="审批内容" refreshOnClick="true">
		   <%@include file="/process/FirstGradeBond/processControl.jsp" %>
		</div>
		<div title="流程信息" url="com.cjhxfund.jy.process.processGraph.flow?processInstID=<%=processinstid %>&workItemID=<%=workItemID %>" ></div>
  		<div title="产品投资范围" url="<%=request.getContextPath() %>/process/FirstGradeBond/ProductInvestmentRange.jsp?combProductCode=<%=combProductCode %>"></div>
   </div>
 </div>
   <script type="text/javascript">
     nui.parse();
     var form = new nui.Form("#dataform1");//将普通form转为nui的form
     //在线打开用印文档
     var file_grid = nui.get("file_grid");

     var activityDefID = '<b:write property="workitem/activityDefID" />';     //获取环节活动定义ID
      var child = null;    //iframe对象
      var SysId = "";       //附件列表ID
     
     var contextPath = '<%=request.getContextPath() %>';
     //获取参数
      var resaleRight = "<b:write property="cfjybusinessbonetable/resaleRight" />";          //是否具有回售权
	  var redemptionRight = "<b:write property="cfjybusinessbonetable/redemptionRight" />";  //是否具有赎回权
	  var isInquiry = "<b:write property="cfjybusinessbonetable/associationBetween" />";              //是否关联交易报备
     
     
     
     //流程提交
	 function processSubmit(){
		var form = new nui.Form("#dataform1");
		    form.setChanged(false);
		var urlStr = "";    //调用逻辑流路径
		var data = {};  //参数列表	
		var files = null;
		
		 var operateType = nui.get("operateType").getValue(); //操作
		//流程js验证
		if(checkForm()==false) return;
		
		//当操作为同意时，验证必填项是否为空
		if(operateType == 1){
			form.validate();
	        if(form.isValid()==false){
	           nui.alert("业务信息必填项不能为空，请输入。","系统提示");
	           return;
	        } 
        }
        var vcSource = "<b:write property="cfjybusinessbonetable/vcSource" />";
        if(vcSource == 2 && operateType == 5 && activityDefID == "manualActivity9"){
        	nui.alert("已经中标确认的结果不能撤销指令/建议。","系统提示");
        	return;
        }       
        
        //当环节为中标确认并且为招行产品时，验证是否用印选项与合同协议审核是否通过选项
		if(activityDefID == "manualActivity9" && vcSource == 2){
			var yn = nui.get("yn").getValue();
			if(operateType == 1){
				if(yn == ""){
				    nui.alert("当操作为同意并且是招行产品时，是否用印选项不能为空。","系统提示");
				    return;
				}
			}
		}

		//参数列表
		data = {
			workItemID:'<%=workItemID %>',
			pmprcaprvinfo:form.getData(false,true).pmprcaprvinfo,
			bpsParam:form.getData(false,true).bpsParam,
			cfjybusinessbonetable:form.getData(false,true).cfjybusinessbonetable
		};
		
		 if(activityDefID !="manualActivity3"){
			 //获取iframe对象
			 child = document.getElementById("prodIfm").contentWindow;
			   
			 //获取用印附件列表ID
			 files = getFileIds();
			 SysId = files.split("@")[0];
		 } 
		 
		 if(activityDefID =="manualActivity8" || activityDefID == "manualActivity12"){
		   //调用逻辑流路径
		   urlStr = contextPath + "/com.cjhxfund.jy.process.cfjybusinessbonetablebiz.firstGradeBondXYYY.biz.ext";
		   if(operateType == 1){
			   //判断id是否为空，为空给出提示是否提交，不为空时提示选择了几个附件
			   if(SysId == ""){
			     nui.confirm("文件没有用印,是否提交.","系统提示",function(action){
			        if(action == "ok"){
			          saveData(data,urlStr);
			        }
			     });
			      
			   }else{			      
			      //SysId = child.getFileId();
			      //参数列表
			       
		   		  data = {
		   		  		workItemID:'<%=workItemID %>',
		   		  		pmprcaprvinfo:form.getData(false,true).pmprcaprvinfo,
		   		  		bpsParam:form.getData(false,true).bpsParam,
		   		  		cfjybusinessbonetable:form.getData(false,true).cfjybusinessbonetable,
		   		  		sysid:child.getFileId().split("@")[0]};
		   
			      //判断是否选择需要用印的附件
			      if(SysId != ""){
				      nui.confirm("文件:"+ files.split("@")[1] +"<br/>已用印，确认是否提交！","系统提示",function(action){
				          if(action == "ok"){
				             saveData(data,urlStr);
				          }else{
				            return;
				          }
				      });
			   }else{
			      nui.confirm("没有选择需要用印的附件，确认是否提交！","系统提示",function(action){
				   	   if(action =="ok"){
				          saveData(data,urlStr);
				       }else{
				         return;
				       }   
			        });
			   }
			 } 
		   }else{
		      saveData(data,urlStr);
		   }
		   
		   
		 }else if(activityDefID =="manualActivity6"){
		    //获取附件ID集合 
		    SysId = child.getFileId();
		    //调用逻辑流路径
		   urlStr = contextPath + "/com.cjhxfund.jy.process.cfjybusinessbonetablebiz.firstGradeBondXXHD1.biz.ext";

		   if(operateType == 1){
			   //判断id是否为空，为空给出提示是否提交，不为空时提示选择了几个附件
			  
			   if(SysId == ""){
			      nui.confirm("没有选择是否需要用印的文件,确认是否提交.","系统提示",function(action){
			        if(action == "ok"){
			     		saveData(data,urlStr);
			     	}else{
			     	   return;
			     	}
			     });		
			   }else{

			      //参数列表
				   data = {
					   workItemID:'<%=workItemID %>',
					   pmprcaprvinfo:form.getData(false,true).pmprcaprvinfo,
					   bpsParam:form.getData(false,true).bpsParam,
					   cfjybusinessbonetable:form.getData(false,true).cfjybusinessbonetable,
					   sysids:SysId
				  };
		       
			      //判断是否选择需要用印的附件
			       if(SysId != ""){
			          var Arrly = SysId.split(",");
				      nui.confirm("已选择" + Arrly.length + "个需要用印的附件，确认是否提交！","系统提示",function(action){
				          if(action == "ok"){
				             saveData(data,urlStr);
				          }else{
				            return;
				          }
				      });
				   }else{
				       nui.confirm("没有选择需要用印的附件，确认是否提交！","系统提示",function(action){
				   	   if(action =="ok"){
				          saveData(data,urlStr);
				       }else{
				         return;
				       }   
			        });
				   }
			  } 
			 }else{
			   urlStr = contextPath + "/com.cjhxfund.jy.process.cfjybusinessbonetablebiz.firstGradeBondXXHD1.biz.ext";
		       saveData(data,urlStr);
			 }  
		 }else{
		   urlStr = contextPath + "/com.cjhxfund.jy.process.cfjybusinessbonetablebiz.firstGradeBondXXHD1.biz.ext";
		   data = {workItemID:'<%=workItemID %>',pmprcaprvinfo:form.getData(false,true).pmprcaprvinfo,bpsParam:form.getData(false,true).bpsParam,cfjybusinessbonetable:form.getData(false,true).cfjybusinessbonetable};
		   saveData(data,urlStr);
		 }

	}

	  //缴款金额(万元)
      function paymentMoneyFun(){
          formatNumberCommon("paymentMoney",4);
      }
      
      //获取需要用印文件的ID与名称
      function getFileIds(){
         var rows = nui.get("file_grid").getData();
         var fileId = "";
         var FileName = "";
         
         for(var i = 0;i<rows.length;i++){
            if(rows[i].whetherindia == 1){
	           if(fileId == ""){
	             fileId = rows[i].sysid;
	             FileName = rows[i].name;
	           }else{
	             fileId = fileId +"," + rows[i].sysid;
	             FileName = FileName + "," + rows[i].name;
	           }
            }
         }
         return fileId +"@" + FileName;
      }
      
      //tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	function activechangedFun(){
		//标签切换时同时刷新“今日待处理”，模块数据
		//reloadWaitConfirmFun();
	
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tab").getActiveTab().title;
		
		if(activeTabTitle.indexOf("审批内容")!=-1){
			//附件列表
		     var file_grid = nui.get("file_grid");
		     var file_Form = new nui.Form("#file_Form").getData(false,false);
		     file_grid.load(file_Form);
		}
	 }
	 
	 //缴款面值
	 function payFaceValueFun(){
	    formatNumberCommon("payFaceValue",4);
	 }
	 
	 var operateText = nui.get("operateType").getSelected().text;
	 nui.get("comments").setValue(operateText);
   </script>	
   <script src="<%=request.getContextPath() %>/process/util/process.js" type="text/javascript"></script>
   <script type="text/javascript">
     inintProcess();
   </script>
</body>
</html>