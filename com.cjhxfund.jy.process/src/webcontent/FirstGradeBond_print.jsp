<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@ taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<%@ taglib uri="http://eos.primeton.com/tags/dict" prefix="d"%>
<%
   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 

   //流程ID
   String processinstid =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"processinstid");
 %>
<%--
- Author(s): chenpeng
- Date: 2016-03-30 10:19:16
- Description:
    --%>
<head>
    <title>
          <b:write property="gradeBond/combProductName" /> 	
    </title>
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
     </style>
</head>
<body style="margin: auto;padding: auto;">
     <h2 align="center" style="margin-top: 10px;margin-bottom: 10px;">[<b:write property="gradeBond/investproductnum" />]-<b:write property="gradeBond/combProductName" />-<b:write property="gradeBond/investProductName" /></h2>
	 <div class="nui-panel" title="业务信息"  style="width:100%;height: 28px;margin: 0px auto;" showToolbar="false" showFooter="true" >
	 </div>
	   <l:equal property="gradeBond/businesstype" targetValue="1">
	   <!-- 一级债券申购(非可转债)流程信息 -->
	     <table style="width:100%;table-layout:fixed;margin-bottom: 5px;" class="nui-form-table">
                <tr>
                    <td class="form_label td1" width="20%" align="right">
                        业务日期:    
                    </td>
                    <td colspan="1" width="30%">
                        <%--<input class="nui-datepicker" name="gradeBond.processDate" width="150" value="<b:write property="gradeBond/processDate" />" readonly/>--%>
                        <b:write property="gradeBond/processDate" formatPattern="yyyy-MM-dd"/>
                    </td>
                    <td class="form_label td1" align="right" width="23%">
	                        主承机构:
	                </td>
	                <td colspan="1" class="td2">
	                   <b:write property="gradeBond/mainBearingMechanism" />
	                </td>
                </tr>
                <tr>
                   <td class="form_label td1" width="20%" align="right">
                        产品名称:
                    </td>
                    <td colspan="1" width="30" class="td2">
                        <%--<input class="nui-textbox"id="combProductName" width="150" name="gradeBond.combProductName" value="<b:write property="gradeBond/combProductName" />" readonly/>--%>
                    	<b:write property="gradeBond/combProductName"/>
                    </td>
                    <td class="form_label td1" width="17" align="right">
	                        组合名称:
	              </td>
	              <td colspan="1" width="33%" class="td2">
	                  <b:write property="gradeBond/vcCombiName" />
	              </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        债券代码:
                    </td>
                    <td colspan="1" >
                        <%--<input class="nui-textbox" name="gradeBond.investProductCode"/>--%>
                        <%--<input  id="investProductCode" width="150" class="nui-textbox"name="gradeBond.investProductCode" value="<b:write property="gradeBond/investProductCode" />" readonly/>--%>
                        <b:write property="gradeBond/investProductCode" />
                    </td>
                    <td class="form_label td1" align="right">
                        债券名称:
                    </td>
                    <td colspan="1" class="td2">
                        <%--<input class="nui-textbox" id="investProductName" width="150" name="gradeBond.investProductName" value="<b:write property="gradeBond/investProductName" />" readonly/>--%>
                        <b:write property="gradeBond/investProductName" />
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        登记托管场所:
                    </td>
                    <td colspan="1">
                        <%--<input class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" width="150" name="gradeBond.paymentplace" value="<b:write property="gradeBond/paymentplace" />" readonly/>--%>
                        <d:write dictTypeId="CF_JY_DJTGCS" property="gradeBond/paymentplace" />
                    </td>
                    <td class="form_label td1" align="right">
                        发行主体:
                    </td>
                    <td colspan="1" class="td2">
                        <%--<input class="nui-textbox" width="150" name="gradeBond.ratingname"value="<b:write property="gradeBond/ratingname" />" readonly/>--%>
                        <b:write property="gradeBond/ratingname" />
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        主体类型:
                    </td>
                    <td colspan="1" class="td2">
                        <%--<input class="nui-dictcombobox" dictTypeId="CF_JY_ZTLX" width="150" name="gradeBond.ratingType" value="<b:write property="gradeBond/ratingType" />" readonly/>--%>
                        <d:write dictTypeId="CF_JY_DJTGCS" property="gradeBond/ratingType" />
                    </td>
                    <td class="form_label td1" align="right">
                        主体评级:
                    </td>
                    <td colspan="1" class="td2">
                      <%--   <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" width="150" id="subjectrating" 
                        name="gradeBond.subjectrating" value="<b:write property="gradeBond/subjectrating" />" readonly/> --%>
                        <d:write dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" property="gradeBond/subjectrating" />
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        投标金额(万元):
                    </td>
                    <td colspan="1">
                       <%-- <input class="nui-textbox" name="gradeBond.investcount" id="investcount" width="150" value="<b:write property="gradeBond/investcount" />" readonly/>--%>
                       <b:write property="gradeBond/investcount" />
                    </td>
                    <td class="form_label td1" align="right">
                        投标利率(%):
                    </td>
                    <td colspan="1" class="td2">
                        <%--<input class="nui-textbox" name="gradeBond.interestrate" width="150" value="<b:write property="gradeBond/interestrate" />" readonly/>--%>
                        <b:write property="gradeBond/interestrate" />
                    </td>
                </tr>
                <tr>
                     <td class="form_label td1" align="right">
                        债项评级:
                    </td>
                    <td colspan="1" class="td2"> 
                        <%--<input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" id="bondrating" 
                        width="150" name="gradeBond.bondrating" value="<b:write property="gradeBond/bondrating" />" readonly/>--%>
                        <d:write dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" property="gradeBond/bondrating" />
                    </td>
                    <td class="form_label td1" align="right">
                        债券种类:
                    </td>
                    <td colspan="1" class="td2">
                        <%-- <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY" width="150" 
                        id="investcategory" name="gradeBond.investcategory" value="<b:write property="gradeBond/investcategory" />" readonly/> --%>
                        <d:write dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY" property="gradeBond/investcategory" />
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        评级机构:
                    </td>
                    <td colspan="1">
                       <%--  <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_RATING_AGENCIES" width="150" id="ratingAgencies" 
                        name="gradeBond.ratingagencies" value="<b:write property="gradeBond/ratingagencies" />"  readonly/> --%>
                        <d:write dictTypeId="CF_JY_PRODUCT_PROCESS_RATING_AGENCIES" property="gradeBond/ratingagencies" />
                    </td>
                    <td class="form_label td1" align="right">
                      发行规模(万元):
                    </td>
                    <td colspan="1" class="td2">
                        <%-- <input class="nui-textbox" name="gradeBond.issueSize" id="issueSize" width="150" 
                        onvaluechanged="calculationNetWorthScale" value="<b:write property="gradeBond/issueSize" />" readonly/> --%>
                        <b:write property="gradeBond/issueSize" />
                    </td>
                </tr>
                <tr>
                     <td class="form_label td1" align="right">
                        已投资该发行主体证券存量(万元):
                    </td>
                    <td colspan="1" class="td2">
                        <%-- <input class="nui-textbox" name="gradeBond.categorymoney" 
                        id="categorymoney" onvaluechanged="calculationNetWorthScale" width="150" value="<b:write property="gradeBond/categorymoney" />" readonly/> --%>
                        <b:write property="gradeBond/categorymoney" />
                    </td>
                    <td class="form_label td1" align="right">
                        债券期限(年):
                    </td>
                    <td colspan="1" class="td2">
                        <%-- <input class="nui-textbox" name="gradeBond.categorydate" 
                        value="<b:write property="gradeBond/categorydate" />" width="150" readonly/> --%>
                        <b:write property="gradeBond/categorydate" />
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                       产品净值规模(万元):
                    </td>
                    <td colspan="1" class="td2">
						<b:write property="gradeBond/netWorthScale" />
                    </td>
                    <td class="form_label td1" align="right">
                        首次付息日:
                    </td>
                    <td colspan="1" class="td2">
						<b:write property="gradeBond/initialInterestPaymentDate" formatPattern="yyyy-MM-dd"/>
                    </td>
                </tr>
                <tr>
                   <td class="form_label td1" align="right">
                        是否具有回售权:
                    </td>
                    <td colspan="1" class="radio-border-top-none">
                       <label style="float: left;" ><d:write dictTypeId="COF_YESORNO" property="gradeBond/resaleRight"/></label>
                       &nbsp;
                       <label id="resaleYear" style="display: none;float: left;">&nbsp;行权年：
	                        <b:write property="gradeBond/resaleYear" />年
                       </label>
                    </td>
                   <td class="form_label td1" align="right"> 
                        是否具有赎回权:
                    </td>
                    <td colspan="1" class="radio-border-top-none td2">
                          <label style="float: left;" ><d:write dictTypeId="COF_YESORNO" property="gradeBond/redemptionRight"/></label>
                           &nbsp;<label id="redemptionYear" style="display: none;float: left;">	                                                     
                                &nbsp;行权年：  
       					    <b:write property="gradeBond/redemptionYear" />年
       					 </label>
                    </td>
                </tr>
                <tr>
                 <td class="form_label td1" align="right">
                        是否关联交易:
                  </td>
                  <td colspan="3" class="radio-border-top-none td2">
                        
                        <label style="float: left;" ><d:write dictTypeId="COF_YESORNO" property="gradeBond/associationBetween" /></label>
                        &nbsp;
                         
                          <b:write property="gradeBond/associationRemark" />
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
	                    <td class="form_label td1" align="right">
	                        主体评级:
	                    </td>
	                    <td colspan="1" class="td2">
	                         <d:write dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" property="gradeBond/subjectrating"/>
	                    </td>
	                <tr>    
	                    <td class="form_label td1" align="right">
	                        债项评级:
	                    </td>
	                    <td colspan="1">
	                        <d:write dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" property="gradeBond/bondrating"/>
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
	                        债券期限(年):
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
			<div class="nui-panel" title="缴款信息"  style="width:100%;height: 28px;margin-top: 5px;margin: 0px auto;" showToolbar="false" showFooter="true" >
			    </div>
			   <table style="width:100%;table-layout:fixed;margin: 0px auto;margin-bottom: 5px;" class="nui-form-table">
			      <tr>
			         <td class="form_label td1" align="right" width="20%">
		                        缴款面值(万元):
		             </td>
		             <td colspan="1" class="radio-border-top-none" width="30" >
		                    <b:write property="gradeBond/payFaceValue" />
		             </td>
		             <td class="form_label td1" align="right" width="20%">
		                        缴款日期:
		             </td>
		            <td colspan="1" class="td2" width="30">
							<b:write property="gradeBond/paymentDate" formatPattern="yyyy-MM-dd"/>
		             </td>
		          </tr>
		          <tr>
		             <td class="form_label td1" align="right" width="20%">
		                        缴款金额(万元):
		             </td>
		             <td colspan="1" class="radio-border-top-none" width="30" >
		                    <b:write property="gradeBond/paymentMoney" />
		             </td>
		             <td class="form_label td1" align="right">
		                        发行价格(元):
		             </td>
		             <td colspan="1" class="td2" >
		                 <b:write property="gradeBond/issuePrice" />   
		             </td>
		          </tr>
		          <tr>
		             <td class="form_label td1" align="right">
		                        票面利率(%):
		             </td>
		            <td colspan="1" class="td2">
						<b:write property="gradeBond/couponRate" />
		             </td>
		             <td class="form_label td1" align="right">
		                        付息频率:
		             </td>
		             <td colspan="1" class="td2">
		                 <d:write dictTypeId="CF_JY_FREQUENCY" property="gradeBond/frequency"/>   
		             </td>
		          </tr>
		          <tr>
		             <td class="form_label td1" align="right">
		                        还本方式:
		             </td>
		            <td colspan="1" class="td2" >
						
		             <d:write dictTypeId="CF_JY_MODE_REPAYMENT" property="gradeBond/modeRepayment"/> 
		             </td>
		             <td class="form_label td1" align="right" >
		                        计息起始日:
		             </td>
		             <td colspan="1"   class="td2">
							<b:write property="gradeBond/startingDateInterest" formatPattern="yyyy-MM-dd"/>
		             </td>
	             </tr>
	             <tr>
		             <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
		                        计息截止日:
		             </td>
		             <td colspan="3"  style="border-bottom: 1px solid #D3D3D3;" class="td2">
							<b:write property="gradeBond/deadlineInterest" formatPattern="yyyy-MM-dd"/>
		             </td>
		             
		          </tr>
			   </table>   
	            <div class="nui-panel" title="收款账户信息"  style="width:100%;height: 28px;margin-top: 5px;margin: 0px auto; " showToolbar="false" showFooter="true" >
		        </div>
			   <table style="width:100%;table-layout:fixed;margin-bottom: 5px;" class="nui-form-table">
	                <tr>
	                    
	                    <td class="form_label td1" width="20%" align="right">
	                        收款人户名:
	                    </td>
	                    <td colspan="1" width="30" class="td1">
	                         <b:write property="gradeBond/beneficiary" />
	                    </td>
	                    <td class="form_label td1" width="20%" align="right">
	                        收款账号:    
	                    </td>
	                    <td colspan="1" width="30" class="td2">
	                        <b:write property="gradeBond/collectionAccount" />
	                    </td>
	                  </tr>
	                <tr>
	                    <td class="form_label td1" width="20%" align="right">
	                        开户行行号:
	                    </td>
	                    <td colspan="1" width="30" class="td1">
	                        <%-- <input class="nui-textbox" id="bankLine" width="150" name="gradeBond.bankLine"
	                        value="<b:write property="gradeBond/bankLine" />"  readonly/> --%>
	                        <b:write property="gradeBond/bankLine" />
	                    </td>
	                    <td class="form_label td1" width="20%" align="right">
	                        大额支付行号:    
	                    </td>
	                    <td colspan="1" class="td2">
	                        <%-- <input class="nui-textbox" name="gradeBond.payLine" width="150"
	                         value="<b:write property="gradeBond/payLine" />"   readonly/> --%>
	                         <b:write property="gradeBond/payLine" />
	                    </td>
	                </tr>
	                <tr>
	                   <td class="form_label td1" width="20%" align="right" style="border-bottom: 1px solid #D3D3D3;">
	                        备注:
	                    </td>
	                    <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
	                        <%-- <input class="nui-textarea" id="receivableRemark" width="450" height="60"
	                         name="gradeBond.receivableRemark"  value="<b:write property="gradeBond/receivableRemark" />"   readonly/> --%>
	                         <b:write property="gradeBond/receivableRemark" />
	                    </td>
	                </tr>
	            </table> 
	            <div class="nui-panel" title="审批信息"  style="width:100%;height: 28px;margin-top: 5px;margin: 0px auto; " showToolbar="false" showFooter="true" >
		        </div>
		        <div id="grid_form">
				   <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.process.FirstGradeBond.PmPrcAprvInfo"/>
				   <input class="nui-hidden" name="criteria/_expr[1]/processInstId" value="<%=processinstid %>"/>
				   <input class="nui-hidden" name="cirteria/_expr[1]/_op" value="="/>
		   		</div>
				<div id="deptGrid" class="nui-datagrid" style="width:100%;margin-bottom: 5px;"
					 url="com.cjhxfund.jy.process.PmPrcAprvInfo.queryPmPrcAprvInfoList.biz.ext"  
					 dataField="PmPrcAprvInfos" pageSize="50" allowResize="true" showPager="false">
					 
				 <div property="columns">            
				     <div field="createTime"  headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss">审批时间</div>                                        
				     <div field="workItemName"  headerAlign="left" >节点名称</div>   
				     <div field="userName"  headerAlign="left" >操作者</div>  
				     <div field="operateType"  headerAlign="left" renderer="rendeRoperateType">操作</div>  
				     <div field="comments"  headerAlign="left" >处理意见</div>         
				 </div>
			   </div>
			   <div class="nui-panel" title="附件列表"  style="width:100%;height: 28px;margin-top: 5px;margin: 0px auto; " showToolbar="false" showFooter="true" >
		       </div>
			   <div id="file_Form">
			         <input class="nui-hidden" name="map/bizId" value="<b:write property="gradeBond/bizId" />"/>
			         <input class="nui-hidden" name="map/attachBusType" value="0"/>
			         <input class="nui-hidden" name="map/processinstid" value="<b:write property="gradeBond/processinstid" />"/>
		       </div>
		       <div id="file_grid" class="mini-datagrid" style="width:100%;word-wrap:break-word;" 
	            	url="com.cjhxfund.jy.process.attachUitlFunction.queryAttachmentList.biz.ext" 
	                dataField="attachments"  allowResize="true" showPager="false">
		            <div property="columns">
	                    <div field="sysid"  headerAlign="center" visible="false">编号</div> 
		                <div field="name"  headerAlign="center" width="60%" allowSort="true">文件名</div> 
		                <div field="workitemname"  headerAlign="center" allowSort="true" width="18%" align="center">环节名称</div>
		                <div field="annexseal"  headerAlign="center" width="10%" align="center" renderer="renderAnnexseal">是否用印</div>               
						<div field="whetherindia" headerAlign="center" width="12%" align="center" renderer="renderWhetherindia">是否用过印</div>
		            </div>	 
	           </div> 
        <script type="text/javascript">
            nui.parse();
 			
 			var activityDefID = "<b:write property="workitem/activityDefID" />";  //获取当前活动ID
 			var contextPath = '<%=request.getContextPath() %>';
 			var deptGrid = nui.get("deptGrid");               //获取附件列表对象
 			var grid_form = new nui.Form("#grid_form").getData(false,false);
	        deptGrid.load(grid_form);
			
			//加载附件列表
			var file_grid = nui.get("file_grid");
	     	var file_Form = new nui.Form("#file_Form").getData(false,false);
	     		file_grid.load(file_Form);
	     
			function rendeRoperateType(e){
			  if(e.row.operateType == 1){
	            return "同意";
	          }
	          if(e.row.operateType == 2){
	            return "退办";
	          }
	          if(e.row.operateType == 3){
	            return "转办";
	          }
	          if(e.row.operateType == 4){
	            return "征求意见";
	          }
	          if(e.row.operateType == 5){
	            return "否决";
	          }
	          if(e.row.operateType == 99){
	            return "不同意";
	          }
	          if(e.row.operateType == 98){
	            return "修改";
	          }
	          if(e.row.operateType == 97){
	            return "废弃";
	          }
			}
			
			function renderAnnexseal(e){
			  if(e.row.annexseal == 1){
	            return "是";
	          }else{
	          	return "否";	
	          }
			}
			
			function renderWhetherindia(e){
			  if(e.row.whetherindia == 1){
	            return "是";
	          }else{
	          	return "否";	
	          }
			}

       </script>
               <%-- <script src="<%=request.getContextPath() %>/process/util/process.js" type="text/javascript"></script>--%>
    </body>
</html>
