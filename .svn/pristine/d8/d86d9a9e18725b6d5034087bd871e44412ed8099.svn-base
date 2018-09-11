<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>

<%--
- Author(s): chenpeng
- Date: 2016-03-30 10:19:16
- Description:
    --%>
    <head>
        <title>
          
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
    <body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
       <div id="dataform1" style="height: 100%">
       <div class="nui-tabs" id="tab" activeIndex="0"  style="width:100%;height:100%;">
		<!-- 业务类型标签页开始... -->
		<div title="业务信息"> 
	            <!-- hidden域 -->
	            <!-- 流程信息 -->
	            <input class="nui-hidden" id="processinstid" name="processinstid" value="<%=processinstid %>"/>
		    	<input class="nui-hidden" id="workItemID" name="workItemID" value="<%=workItemID %>"/>
	            <!-- 业务信息 -->
	            <input class="nui-hidden" name="cfjybusinessbonetable.btId" value="<b:write property="cfjybusinessbonetable/btId" />"/>
	            <input class="nui-hidden" id="cfjybusinessbonetable.bizId" name="cfjybusinessbonetable.bizId" value="<b:write property="cfjybusinessbonetable/bizId" />"/>
				<input class="nui-hidden" id="cfjybusinessbonetable.businesstype" name="cfjybusinessbonetable.businesstype" value="<b:write property="cfjybusinessbonetable/businesstype" />"/>
				<!-- 产品代码 -->
				<input class="nui-hidden" id="combProductCode" name="cfjybusinessbonetable.combProductCode" value="<b:write property="cfjybusinessbonetable/combProductCode" />"/>
				<!-- 投资编号 -->
				<input class="nui-hidden" id="investproductnum" name="cfjybusinessbonetable.investproductnum" value="<b:write property="cfjybusinessbonetable/investproductnum" />"/>
				
	            <table style="width:100%;table-layout:fixed;" class="nui-form-table">
	                <tr>
	                  <td class="form_label td1" align="right" width="17.5%">
	                        申购日期:
	                    </td>
	                    <td colspan="1" width="32.5%"> 
	                        <input class="nui-datepicker" name="cfjybusinessbonetable.processDate"  width="170" 
	                        value="<b:write property="cfjybusinessbonetable/processDate" />" readonly/>
	                    </td>
	                    <td class="form_label td1" align="right"> 
	                        主承机构:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.mainBearingMechanism" 
	                        value="<b:write property="cfjybusinessbonetable/mainBearingMechanism" />" width="170" readonly/>
	                    </td>
	                </tr>
	                <tr>
	                  <td class="form_label td1" width="17.5%" align="right">
	                        产品名称:
	                    </td>
	                    <td colspan="1" width="32.5%" class="td2">
	                        <input class="nui-textbox" id="combProductName" name="cfjybusinessbonetable.combProductName"
	                        value="<b:write property="cfjybusinessbonetable/combProductName" />" width="170" readonly/>
	                    </td>
	                  <td class="form_label td1" width="17.5%" align="right">
		                        组合名称:
		                </td>
		                <td colspan="1" width="32.5%" class="td2">
		                    <input class="nui-textbox" width="170" id="vcCombiName" name="cfjybusinessbonetable.vcCombiName" value="<b:write property="cfjybusinessbonetable/vcCombiName" />" readonly/>
		                      
		                </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" align="right">
	                        债券代码:
	                    </td>
	                    <td colspan="1">
	                       <input class="nui-textbox" name="cfjybusinessbonetable.investProductCode" 
	                       value="<b:write property="cfjybusinessbonetable/investProductCode" />" width="170" readonly/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                        债券名称:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox"  name="cfjybusinessbonetable.investProductName" id="investProductName"
	                        value="<b:write property="cfjybusinessbonetable/investProductName" />"  width="170" readonly/>
	                    </td>
	                    
	                </tr>
	                <tr>
	                  <td class="form_label td1" align="right">
	                        申购金额(万元):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.purchaseAmount" id="purchaseAmount" 
	                        value="<b:write property="cfjybusinessbonetable/purchaseAmount" />" width="170" onvaluechanged="calculationAmount(e)" readonly/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                        定金比例(%):
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.depositRatio" id="depositRatio" width="170" onvaluechanged="calculationAmount(e)"
	                        value="<b:write property="cfjybusinessbonetable/depositRatio" />"  readonly/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" align="right">
	                        定金金额(万元):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.depositAmount" id="depositAmount"
	                        value="<b:write property="cfjybusinessbonetable/depositAmount" />"  width="170" readonly/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                        发行主体:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.ratingname" 
	                        value="<b:write property="cfjybusinessbonetable/ratingname" />"  width="170" readonly/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" align="right">
	                        发行主体类型:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_ZTLX" name="cfjybusinessbonetable.ratingType"  
	                        value="<b:write property="cfjybusinessbonetable/ratingType" />"  width="170" readonly/>
	                    </td>             
	                    <td class="form_label td1" align="right">
	                        主体评级:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" name="cfjybusinessbonetable.subjectrating"  
	                        value="<b:write property="cfjybusinessbonetable/subjectrating" />"  id="subjectrating" width="170" readonly/>
	                    </td>
	                <tr>    
	                    <td class="form_label td1" align="right">
	                        债项评级:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" name="cfjybusinessbonetable.bondrating" id="bondrating" 
	                        value="<b:write property="cfjybusinessbonetable/bondrating" />"  width="170" readonly/>
	                    </td>
	                    <td class="form_label" align="right">
	                        债券种类:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox"  dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY" width="170" id="investcategory" name="cfjybusinessbonetable.investcategory"
	                         value="<b:write property="cfjybusinessbonetable/investcategory" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" readonly/>
	                    </td> 
	                </tr>
	                <tr>
	                    <td class="form_label td1" align="right">
	                        评级机构:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_RATING_AGENCIES" name="cfjybusinessbonetable.ratingagencies" id="ratingAgencies" 
	                        value="<b:write property="cfjybusinessbonetable/ratingagencies" />"   width="170" readonly/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                        发行规模(万元):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.issueSize"  
	                        value="<b:write property="cfjybusinessbonetable/issueSize" />" width="170" readonly/>
	                    </td>	                    
	                 </tr>
	                 <tr>
	                    <td class="form_label td1" align="right">
	                        债券期限(年):
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.categorydate"  
	                        value="<b:write property="cfjybusinessbonetable/categorydate" />" width="170" readonly/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                        已投资该发行主体证券存量(万元):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.categorymoney"  
	                        value="<b:write property="cfjybusinessbonetable/categorymoney" />" width="170" readonly/>
	                    </td>   
	                  </tr>
	                  <tr>
	                    <td class="form_label td1" align="right"> 
	                        中签数量:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.ballotNumber" 
	                        value="<b:write property="cfjybusinessbonetable/ballotNumber" />" width="170" readonly/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                       中签金额:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.ballotMoney" id="netWorthScale"
	                        value="<b:write property="cfjybusinessbonetable/ballotMoney" />"  width="170" readonly/>
	                    </td>
	                  </tr>
	                  <tr>
	                    <td class="form_label td1" align="right">
	                        净值规模(万元):
	                    </td>
	                    <td colspan="3" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.netWorthScale" id="netWorthScale"
	                        value="<b:write property="cfjybusinessbonetable/netWorthScale" />"  width="170" readonly/>
	                    </td>
	                  </tr>
	                <tr>
	                    <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
	                        备注:
	                    </td>
	                    <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
	                        <input class="nui-textarea" width="600" height="60" name="cfjybusinessbonetable.remarks"
	                        value="<b:write property="cfjybusinessbonetable/remarks" />" readonly/>
	                    </td>
	                </tr>                
	            </table>
	            <div class="nui-panel" title="缴款信息"  style="width:100%;height: 28px;margin-top: 5px;" showToolbar="false" showFooter="true" >
			    </div>
			   <table style="width:100%;table-layout:fixed;" class="nui-form-table">
			      <tr>
			         <td class="form_label td1" align="right" width="17%">
		                        缴款面值(万元):
		             </td>
		             <td colspan="1" class="radio-border-top-none" width="33%" >
		                 <input class="nui-textbox" name="cfjybusinessbonetable.payFaceValue" id="payFaceValue"
		                    value="<b:write property="cfjybusinessbonetable/payFaceValue" />"  style="width: 170px;" readonly/>
		             </td>
		             <td class="form_label td1" align="right" width="17%">
		                        缴款日期:
		             </td>
		            <td colspan="1" class="td2" width="33%">
						<input class="nui-datepicker" name="cfjybusinessbonetable.paymentDate" id="paymentDate" 
							value="<b:write property="cfjybusinessbonetable/paymentDate" />"  style="width: 170px;" readonly/>
		             </td>
		          </tr>
		          <tr>
		             <td class="form_label td1" align="right" width="17%">
		                        缴款金额(万元):
		             </td>
		             <td colspan="1" class="radio-border-top-none" width="33%" >
		                 <input class="nui-textbox" name="cfjybusinessbonetable.paymentMoney" id="paymentMoney"
		                    value="<b:write property="cfjybusinessbonetable/paymentMoney" />"  style="width: 170px;" readonly/>
		             </td>
		             <td class="form_label td1" align="right">
		                        发行价格(元):
		             </td>
		             <td colspan="1" >
		                 <input class="nui-textbox" name="cfjybusinessbonetable.issuePrice" id="issuePrice"
		                    value="<b:write property="cfjybusinessbonetable/issuePrice" />"  style="width: 170px;" readonly/>
		             </td>
		          </tr>
		          <tr>
		             <td class="form_label td1" align="right">
		                        票面利率(%):
		             </td>
		            <td colspan="1" class="td2">
						<input class="nui-textbox" name="cfjybusinessbonetable.couponRate" id="couponRate" 
							value="<b:write property="cfjybusinessbonetable/couponRate" />"  style="width: 170px;" readonly/>
		             </td>
		             <td class="form_label td1" align="right">
		                        付息频率:
		             </td>
		             <td colspan="1">
		                 <input class="nui-dictcombobox" dictTypeId="CF_JY_FREQUENCY" name="cfjybusinessbonetable.frequency" id="frequency"
		                    value="<b:write property="cfjybusinessbonetable/frequency" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"  style="width: 170px;" readonly/>
		             </td>
		          </tr>
		          <tr>
		             <td class="form_label td1" align="right">
		                        还本方式:
		             </td>
		            <td colspan="1" class="td2" >
						<input class="nui-dictcombobox" dictTypeId="CF_JY_MODE_REPAYMENT" name="cfjybusinessbonetable.modeRepayment" id="modeRepayment" 
							value="<b:write property="cfjybusinessbonetable/modeRepayment" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"  style="width: 170px;" readonly/>
		             </td>
		             <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
		                        计息起始日:
		             </td>
		             <td colspan="1"  style="border-bottom: 1px solid #D3D3D3;">
		             <input class="nui-datepicker" name="cfjybusinessbonetable.startingDateInterest" id="startingDateInterest" 
							value="<b:write property="cfjybusinessbonetable/startingDateInterest" />"  style="width: 170px;" readonly/>
		             </td>
	             </tr>
	             <tr>
		             <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
		                        计息截止日:
		             </td>
		             <td colspan="3"  style="border-bottom: 1px solid #D3D3D3;">
		             <input class="nui-datepicker" name="cfjybusinessbonetable.deadlineInterest" id="deadlineInterest" 
							value="<b:write property="cfjybusinessbonetable/deadlineInterest" />"  style="width: 170px;" readonly/>
		             </td>
		             
		          </tr>
			   </table>
	            <div class="nui-panel" title="收款账户信息"  style="width:100%;height: 28px;margin-top: 5px;" showToolbar="false" showFooter="true" >
		        </div>
			   <table style="width:100%;table-layout:fixed;" class="nui-form-table">
	                <tr>
	                    
	                    <td class="form_label td1" width="17%" align="right">
	                        收款人户名:
	                    </td>
	                    <td colspan="1" width="33%" class="td1">
	                        <input class="nui-textbox"id="combProductName" width="170" name="cfjybusinessbonetable.beneficiary"
	                         value="<b:write property="cfjybusinessbonetable/beneficiary" />"  readonly/>
	                    </td>
	                    <td class="form_label td1" width="17%" align="right">
	                        收款账号:    
	                    </td>
	                    <td colspan="1" width="33%" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.collectionAccount" width="170" 
	                        value="<b:write property="cfjybusinessbonetable/collectionAccount" />"  readonly/>
	                    </td>
	                  </tr>
	                <tr>
	                    <td class="form_label td1" width="17%" align="right">
	                        开户行行号:
	                    </td>
	                    <td colspan="1" width="33%" class="td1">
	                        <input class="nui-textbox" id="bankLine" width="170" name="cfjybusinessbonetable.bankLine"
	                        value="<b:write property="cfjybusinessbonetable/bankLine" />"  readonly/>
	                    </td>
	                    <td class="form_label td1" width="17%" align="right">
	                        大额支付行号:    
	                    </td>
	                    <td colspan="3" class="td1">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.payLine" width="170"
	                         value="<b:write property="cfjybusinessbonetable/payLine" />"   readonly/>
	                    </td>
	                </tr>
	                <tr>
	                   <td class="form_label td1" width="17%" align="right" style="border-bottom: 1px solid #D3D3D3;">
	                        备注:
	                    </td>
	                    <td colspan="3" class="td1" style="border-bottom: 1px solid #D3D3D3;">
	                        <input class="nui-textarea" id="receivableRemark" width="600" height="60"
	                         name="cfjybusinessbonetable.receivableRemark"  value="<b:write property="cfjybusinessbonetable/receivableRemark" />"   readonly/>
	                    </td>
	                </tr>
	            </table> 
	        </div>
	    
		
	     </div>  
        <script type="text/javascript">
            nui.parse();
 			alert();
 		
        </script>
                
                
            </body>
        </html>
