<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
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
    </style>
    
</head>
<body style="height: 99%;">
 <div id="dataform1" style="height: 100%;">
   <div class="nui-tabs" id="tab" activeIndex="0"  style="width:100%;height:100%;">
		<!-- 业务类型标签页开始... -->
		<div title="基本信息">
		    <input class="nui-hidden" id="processinstid" name="processinstid" value="<%=processinstid %>"/>
		    <input class="nui-hidden" id="workItemID" name="workItemID" value="<%=workItemID %>"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.investproductnum" name="cfjybusinessbonetable.investproductnum" value="<b:write property="cfjybusinessbonetable/investproductnum" />"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.btId" name="cfjybusinessbonetable.btId" value="<b:write property="cfjybusinessbonetable/btId" />"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.bizId" name="cfjybusinessbonetable.bizId" value="<b:write property="cfjybusinessbonetable/bizId" />"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.businesstype" name="cfjybusinessbonetable.businesstype" value="<b:write property="cfjybusinessbonetable/businesstype" />"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.combProductCode" name="cfjybusinessbonetable.combProductCode" value="<b:write property="cfjybusinessbonetable/combProductCode" />"/>
		    
		    
		    <table style="width:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td class="form_label td1" width="17%" align="right">
                        业务日期:    
                    </td>
                    <td colspan="1" width="33%">
                        <input class="nui-datepicker" name="cfjybusinessbonetable.processDate" width="170" value="<b:write property="cfjybusinessbonetable/processDate" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right" width="23%">
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
                      <input class="nui-textbox"id="combProductName" width="170" name="cfjybusinessbonetable.combProductName" value="<b:write property="cfjybusinessbonetable/combProductName" />" readonly/>
                  </td>
	              <td class="form_label td1" width="17" align="right">
	                        组合名称:
	              </td>
	              <td colspan="1" width="33%" class="td2">
	                  <input class="nui-textbox" id="vcCombiName" width="170" name="cfjybusinessbonetable.vcCombiName" value="<b:write property="cfjybusinessbonetable/vcCombiName" />" readonly/>
	              </td>
	             </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        债券代码:
                    </td>
                    <td colspan="1" >
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
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" width="170" name="cfjybusinessbonetable.paymentplace" value="<b:write property="cfjybusinessbonetable/paymentplace" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                        发行主体:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" width="170" name="cfjybusinessbonetable.ratingname"value="<b:write property="cfjybusinessbonetable/ratingname" />" readonly/>
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
                        <input class="nui-textbox" name="cfjybusinessbonetable.investcount" id="investcount" width="170" value="<b:write property="cfjybusinessbonetable/investcount" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                        投标利率(%):
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" name="cfjybusinessbonetable.interestrate" width="170" value="<b:write property="cfjybusinessbonetable/interestrate" />" readonly/>
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
                <tr>
                    <td class="form_label td1" align="right">
                        评级机构:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_RATING_AGENCIES" width="170" id="ratingAgencies" 
                        name="cfjybusinessbonetable.ratingagencies" value="<b:write property="cfjybusinessbonetable/ratingagencies" />"  readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                      发行规模(万元):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="cfjybusinessbonetable.issueSize" id="issueSize" width="170" 
                        onvaluechanged="calculationNetWorthScale" value="<b:write property="cfjybusinessbonetable/issueSize" />" readonly/>
                    </td>
                </tr>
                <tr>
                     <td class="form_label td1" align="right">
                        已投资该发行主体证券存量(万元):
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" name="cfjybusinessbonetable.categorymoney" 
                        id="categorymoney" onvaluechanged="calculationNetWorthScale" width="170" value="<b:write property="cfjybusinessbonetable/categorymoney" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                        债券期限(年):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="cfjybusinessbonetable.categorydate" 
                        value="<b:write property="cfjybusinessbonetable/categorydate" />" width="170" readonly/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                       产品净值规模(万元):
                    </td>
                    <td colspan="1" class="td2">
						<input class="nui-textbox" name="cfjybusinessbonetable.netWorthScale" id="netWorthScale" style="width: 170px;"
						value="<b:write property="cfjybusinessbonetable/netWorthScale" />" onvaluechanged="calculationNetWorthScale" readonly/>
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
                       dictTypeId="COF_YESORNO" style="float: left;" onvaluechanged="resaleRightOnvaluechanged(e)" value="<b:write property="cfjybusinessbonetable/resaleRight" />" readonly/>
                       
                       &nbsp;<label id="resaleYear" style="float: left;display: none;">行权年：
                       <input class="nui-textbox" name="cfjybusinessbonetable.resaleYear" id="resaleYear" width="45"
                        value="<b:write property="cfjybusinessbonetable/resaleYear" />" readonly/></label>
                    </td>
                   <td class="form_label td1" align="right"> 
                        是否具有赎回权:
                    </td>
                    <td colspan="1" class="radio-border-top-none td2">
                        <input id="redemptionRight" class="nui-dictradiogroup" name="cfjybusinessbonetable.redemptionRight" 
                         dictTypeId="COF_YESORNO" style="float: left;" onvaluechanged="redemptionRightOnvaluechanged(e)" value="<b:write property="cfjybusinessbonetable/redemptionRight" />" readonly/>
                           &nbsp;<label id="redemptionYear" style="float: left;display: none;">行权年：  
                          <input class="nui-textbox" name="cfjybusinessbonetable.redemptionYear" id="redemptionYear"
       						width="45" value="<b:write property="cfjybusinessbonetable/redemptionYear" />" readonly="readonly"/></label>
                    </td>
                </tr>
                <tr>
                 <td class="form_label td1" align="right">
                        是否关联交易:
                  </td>
                  <td colspan="3" class="radio-border-top-none td2">
                        <input id="isInquiry" class="nui-dictradiogroup"name="cfjybusinessbonetable.associationBetween" 
                        dictTypeId="COF_YESORNO" style="float: left;" onvaluechanged="isInquiryOnvaluechanged(e)" 
                        value="<b:write property="cfjybusinessbonetable/associationBetween" />" readonly/>
                        
                          <input class="nui-textbox" name="cfjybusinessbonetable.associationRemark" id="associationRemark" 
                          value="<b:write property="cfjybusinessbonetable/associationRemark" />" style="display:none;"width="150" readonly/>
                    </td>
                    
                </tr>
                <tr>
                    <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
                        备注:
                    </td>
                    <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
                        <input class="nui-textarea" width="515" height="40" name="cfjybusinessbonetable.remarks"
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
	                    value="<b:write property="cfjybusinessbonetable/paymentMoney" />"  style="width: 170px;"  readonly/>
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
	                 <input class="nui-dictcombobox" dictTypeId="CF_JY_FREQUENCY"  name="cfjybusinessbonetable.frequency" id="frequency"
	                    value="<b:write property="cfjybusinessbonetable/frequency" />"  style="width: 170px;" readonly/>
	             </td>
	          </tr>
	          <tr>
	             <td class="form_label td1" align="right">
	                        还本方式:
	             </td>
	            <td colspan="1" class="td2" >
					<input class="nui-dictcombobox" dictTypeId="CF_JY_MODE_REPAYMENT"  name="cfjybusinessbonetable.modeRepayment" id="modeRepayment" 
						value="<b:write property="cfjybusinessbonetable/modeRepayment" />"  style="width: 170px;" readonly/>
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
	                 <input class="nui-textbox" name="cfjybusinessbonetable.deadlineInterest" id="deadlineInterest"
	                    value="<b:write property="cfjybusinessbonetable/deadlineInterest" />"  style="width: 170px;" readonly/>
	             </td> 
	          </tr>
	          
		   </table>
		   <div class="nui-panel" title="收款账户信息"  style="width:100%;height: 28px;margin-top: 5px;" showToolbar="false" showFooter="true" >
		       </div>
            <table style="width:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td class="form_label td1" width="17%" align="right">
                        交易方式:    
                    </td>
                    <td colspan="1" width="33%">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_JYFS" name="cfjybusinessbonetable.transactionType" width="170" value="<b:write property="cfjybusinessbonetable/transactionType" />" readonly/>
                    </td>
                    <td class="form_label td1" width="17%" align="right">
                        收款人户名:
                    </td>
                    <td colspan="1" width="33%" class="td1">
                        <input class="nui-textbox"id="combProductName" width="170" name="cfjybusinessbonetable.beneficiary" value="<b:write property="cfjybusinessbonetable/beneficiary" />" readonly/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" width="17%" align="right">
                        收款账号:    
                    </td>
                    <td colspan="1" width="33%">
                        <input class="nui-textbox" name="cfjybusinessbonetable.collectionAccount" value="<b:write property="cfjybusinessbonetable/collectionAccount" />" width="170" readonly/>
                    </td>
                    <td class="form_label td1" width="17%" align="right">
                        开户行行号:
                    </td>
                    <td colspan="1" width="33%" class="td1">
                        <input class="nui-textbox" id="bankLine" width="170" name="cfjybusinessbonetable.bankLine" value="<b:write property="cfjybusinessbonetable/bankLine" />" readonly/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" width="17%" align="right">
                        大额支付行号:    
                    </td>
                    <td colspan="3" class="td1">
                        <input class="nui-textbox" name="cfjybusinessbonetable.payLine" value="<b:write property="cfjybusinessbonetable/payLine" />" width="170" readonly/>
                    </td>
                </tr>
                <tr>
                   <td class="form_label td1" width="17%" align="right" style="border-bottom: 1px solid #D3D3D3;">
                        备注:
                    </td>
                    <td colspan="3" class="td1" style="border-bottom: 1px solid #D3D3D3;">
                        <input class="nui-textarea" id="receivableRemark" width="515" height="40" name="cfjybusinessbonetable.receivableRemark" value="<b:write property="cfjybusinessbonetable/receivableRemark" />" readonly/>
                    </td>
                </tr>
            </table>  
            
          </div>  
		<div title="审批内容">
		   <%@include file="/process/FirstGradeBond/processControl.jsp" %>
		</div>
		<div title="流程信息" url="com.cjhxfund.jy.process.processGraph.flow?processInstID=<%=processinstid %>&workItemID=<%=workItemID %>"></div>
		<div title="产品投资范围" url="<%=request.getContextPath() %>/process/FirstGradeBond/ProductInvestmentRange.jsp?combProductCode=<%=combProductCode %>"></div>
   </div>
 </div>
   <script type="text/javascript">
     nui.parse();
     var form = new nui.Form("#dataform1");//将普通form转为nui的form
     //在线打开用印文档
     var file_grid = nui.get("file_grid");
     var contextPath = '<%=request.getContextPath() %>';
     var activityDefID = '<b:write property="workitem/activityDefID" />';     //获取环节活动定义ID
     //获取参数
      var resaleRight = "<b:write property="cfjybusinessbonetable/resaleRight" />";          //是否具有回售权
	  var redemptionRight = "<b:write property="cfjybusinessbonetable/redemptionRight" />";  //是否具有赎回权
	  var isInquiry = "<b:write property="cfjybusinessbonetable/associationBetween" />";              //是否关联交易报备
     //inintProcess();
   </script>	
   <script src="<%=request.getContextPath() %>/process/util/process.js" type="text/javascript"></script>
   <script type="text/javascript">
     inintProcess();
   </script>
</body>
</html>