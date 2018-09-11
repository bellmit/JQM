<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%
   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
   //业务ID
   String bizId =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"bizId");
   //流程ID
   String processinstid =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"processinstid");
   //工作项ID
   String workItemID =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workItemID");
   
 %>
<%--
- Author(s): chenpeng
- Date: 2016-03-30 10:19:16
- Description:
    --%>
    <head>
        <title>
           	<b:write property="workitem/workItemName" />
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
		    .p{
           		border-bottom: 1px solid #D3D3D3;     
        	  }
        	P{
          		margin: 0px;padding: 0px;
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
				<!-- 产品名称 -->
				<input class="nui-hidden" id="combProductCode" name="cfjybusinessbonetable.combProductCode" value="<b:write property="cfjybusinessbonetable/combProductCode" />"/>
				<!-- 组合编号 -->
				<input class="nui-hidden" id="vcCombiNo" name="cfjybusinessbonetable.vcCombiNo" value="<b:write property="cfjybusinessbonetable.vcCombiNo" />"/>
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
	                        value="<b:write property="cfjybusinessbonetable/mainBearingMechanism" />" width="170"/>
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
	                        <%--<input  id="investProductCode"  width="170" class="nui-autocomplete" popupWidth="300" popupHeight="200" name="cfjybusinessbonetable.investProductCode" searchField="searchKey" dataField="investProducts"
	                        	valueField="investProductInfo" textField="investProduct" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByKey.biz.ext"  value="" text="" enterQuery="false" onitemclick="investProductCodeOnItemClick" readonly/>--%>
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
	                       <span style="color: red">*</span>发行主体:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.ratingname" 
	                        value="<b:write property="cfjybusinessbonetable/ratingname" />" required="true" width="170"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" align="right">
	                        <span style="color: red">*</span>发行主体类型:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_ZTLX" name="cfjybusinessbonetable.ratingType"  
	                        value="<b:write property="cfjybusinessbonetable/ratingType" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" width="170"/>
	                    </td>             
	                    <td class="form_label td1" align="right">
	                        <span style="color: red">*</span>主体评级:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" name="cfjybusinessbonetable.subjectrating"  
	                        value="<b:write property="cfjybusinessbonetable/subjectrating" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" id="subjectrating" width="170"/>
	                    </td>
	                <tr>    
	                    <td class="form_label td1" align="right">
	                        <span style="color: red">*</span>债项评级:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" name="cfjybusinessbonetable.bondrating" id="bondrating" 
	                        value="<b:write property="cfjybusinessbonetable/bondrating" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" width="170"/>
	                    </td>
	                    <td class="form_label" align="right">
	                        债券种类:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" required="true" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY" width="170" id="investcategory" name="cfjybusinessbonetable.investcategory"
	                         value="<b:write property="cfjybusinessbonetable/investcategory" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" align="right">
	                       <span style="color: red">*</span>评级机构:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_RATING_AGENCIES" name="cfjybusinessbonetable.ratingagencies" id="ratingAgencies" 
	                        value="<b:write property="cfjybusinessbonetable/ratingagencies" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true"  width="170"/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                        <span style="color: red">*</span>发行规模(万元):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.issueSize"  required="true" id="issueSize"
	                        value="<b:write property="cfjybusinessbonetable/issueSize" />" onvaluechanged="CalculatingProportion" onblur="issueSizeFun" width="170"/>
	                    </td>
	                 </tr>
	                 <tr>
	                    <td class="form_label td1" align="right">
	                        <span style="color: red">*</span>债券期限(年):
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.categorydate"  required="true"
	                        value="<b:write property="cfjybusinessbonetable/categorydate" />" width="170"/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                       <span style="color: red">*</span>已投资该发行主体证券存量(万元):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.categorymoney"  required="true" id="categorymoney"
	                        value="<b:write property="cfjybusinessbonetable/categorymoney" />" onblur="categoryMoneyFun" onvaluechanged="CalculatingProportion" width="170"/>
	                    </td>   
	                  </tr>
	                  <tr>
	                    <td class="form_label td1" align="right">
	                        <span style="color: red">*</span>净值规模(万元):
	                    </td>
	                    <td colspan="3" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.netWorthScale" id="netWorthScale"
	                        value="<b:write property="cfjybusinessbonetable/netWorthScale" />"  onblur="netWorthScaleFun" width="170" onvaluechanged="CalculatingProportion" required="true"/>
	                    </td>
	                  </tr>
	                  <tr>
		                  <td class="form_label td1" align="right">债券占比：</td>
		                  <td colspan="3" style="padding: 0px;margin: 0xp;" class="td2">
		                   <p class="p"><label style="margin-left: 5px;font-weight: inherit;">定金金额/发行规模(%): </label>
		                   				<input name="cfjybusinessbonetable.investmentOccupyIssuesize" id="investmentOccupyIssuesize" 
		                   					   value="<b:write property="cfjybusinessbonetable/investmentOccupyIssuesize" />" class="nui-textbox asLabel"/></p>
		                   <p class="p"><label style="margin-left: 5px;font-weight: inherit;">投资该发行主体发行证券存量/产品净值规模(%): </label>
		                   				<input name="cfjybusinessbonetable.productEquityRatio" id="productEquityRatio" 
		                   					   value="<b:write property="cfjybusinessbonetable/productEquityRatio" />"	class="nui-textbox asLabel"/></p>
		                   </td>
                   	   </tr>				
	                <tr>
	                    <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
	                        备注:
	                    </td>
	                    <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
	                        <input class="nui-textarea" width="600" height="60" name="cfjybusinessbonetable.remarks"
	                        value="<b:write property="cfjybusinessbonetable/remarks" />"/>
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
		                    value="<b:write property="cfjybusinessbonetable/payFaceValue" />"  style="width: 170px;" onblur="payFaceValueFun()" required="true"/>
		             </td>
		             <td class="form_label td1" align="right" width="17%">
		                        缴款日期:
		             </td>
		            <td colspan="1" class="td2" width="33%">
						<input class="nui-datepicker" name="cfjybusinessbonetable.paymentDate" id="paymentDate" required="true" 
						value="<b:write property="cfjybusinessbonetable/paymentDate" />"  style="width: 170px;" />
		             </td>
		          </tr>
		          <tr>
		             <td class="form_label td1" align="right" width="17%">
		                        缴款金额(万元):
		             </td>
		             <td colspan="1" class="radio-border-top-none" width="33%" >
		                 <input class="nui-textbox" name="cfjybusinessbonetable.paymentMoney" id="paymentMoney"
		                    value="<b:write property="cfjybusinessbonetable/paymentMoney" />"  style="width: 170px;" onblur="paymentMoneyFun()" />
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
	            <div class="nui-panel" title="收款账户信息"  style="width:100%;height: 28px;margin-top: 5px;" showToolbar="false" showFooter="true" >
		        </div>
			   <table style="width:100%;table-layout:fixed;" class="nui-form-table">
	                <tr>
	                    <%--<td class="form_label td1" width="17%" align="right">
	                        交易方式:    
	                    </td>
	                    <td colspan="1" width="33%">
	                        <input class="nui-dictcombobox" dictTypeId="TRANSACTION_TYPE" name="cfjybusinessbonetable.transactionType"
	                          value="<b:write property="cfjybusinessbonetable/transactionType" />" width="170" required="true"  />
	                    </td>--%>
	                    <td class="form_label td1" width="17%" align="right">
	                        收款人户名:
	                    </td>
	                    <td colspan="1" width="33%" class="td1">
	                        <input class="nui-textbox"id="combProductName" width="170" name="cfjybusinessbonetable.beneficiary"
	                         value="<b:write property="cfjybusinessbonetable/beneficiary" />" required="true"/>
	                    </td>
	                    <td class="form_label td1" width="17%" align="right">
	                        收款账号:    
	                    </td>
	                    <td colspan="1" width="33%" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.collectionAccount" width="170" 
	                        value="<b:write property="cfjybusinessbonetable/collectionAccount" />" required="true"/>
	                    </td>
	                  </tr>
	                <tr>
	                    <td class="form_label td1" width="17%" align="right">
	                        开户行:
	                    </td>
	                    <td colspan="1" width="33%" class="td1">
	                        <input class="nui-textbox" id="bankLine" width="170" name="cfjybusinessbonetable.bankLine"
	                        value="<b:write property="cfjybusinessbonetable/bankLine" />" required="true"/>
	                    </td>
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
	                        <input class="nui-textarea" id="receivableRemark" width="600" height="60"
	                         name="cfjybusinessbonetable.receivableRemark"  value="<b:write property="cfjybusinessbonetable/receivableRemark" />"  />
	                    </td>
	                </tr>
	            </table> 
	        </div>
	      <div title="审批内容">
		   		<%@include file="/process/FirstGradeBondKZJ/processControl_KZZ.jsp" %>
		  </div>
		  <div title="流程信息" url="com.cjhxfund.jy.process.processGraph.flow?processInstID=<%=processinstid %>&workItemID=<%=workItemID %>"> 
		  </div>  
		  <div title="产品投资范围" url="<%=request.getContextPath() %>/process/FirstGradeBond/ProductInvestmentRange.jsp?combProductCode=<b:write property="cfjybusinessbonetable/combProductCode" />"></div>
	     </div>  
	  </div>   
        <script type="text/javascript">
            nui.parse();
            
            var activityDefID = "<b:write property="workitem/activityDefID" />";  //获取当前活动ID
            var file_grid = nui.get("file_grid");    //获取附件列表对象
            
            function Init(){
              var depositAmount = nui.get("depositAmount").getValue().replace(/,/gi,'');    //获取定金金额
              var issueSize = nui.get("issueSize").getValue().replace(/,/gi,'');    //发行规模
              var categorymoney = nui.get("categorymoney").getValue().replace(/,/gi,'');    //已投资该发行主体发行证券存量
              var netWorthScale = nui.get("netWorthScale").getValue().replace(/,/gi,'');    //产品净值规模
              
              //当发行规模不为空时计算比例
              if(issueSize != ""){
                 nui.get("investmentOccupyIssuesize").setValue(((depositAmount/issueSize) * 100).toFixed(6));
              }
              
              //当产品净值规模与已投资该发行主体发行证券存量不为空时计算比例
              if(categorymoney != "" && netWorthScale!= ""){
                nui.get("productEquityRatio").setValue(((categorymoney/netWorthScale) * 100).toFixed(6));
              }
            }
            
            Init();

            function processSubmit(){

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                
                //保存
                var urlStr = "com.cjhxfund.jy.process.cfjybusinessbonetableKZZ.FirstGradeBond_KZJ_XXHD.biz.ext";
                //获取iframe对象
				var child = document.getElementById("prodIfm").contentWindow;
				//获取用印附件列表ID
				var SysId = child.getFileId();
				
				//组装参数
                data = {
					workItemID:'<%=workItemID %>',
					pmprcaprvinfo:form.getData(false,true).pmprcaprvinfo,
					bpsParam:form.getData(false,true).bpsParam,
					cfjybusinessbonetable:form.getData(false,true).cfjybusinessbonetable,
					pmprcaprvinfo:form.getData(false,true).pmprcaprvinfo,
					sysids:SysId};
				
				var operateType = nui.get("operateType").getValue(); //操作
				
				//判断操作为同意时
                if(operateType == 1){
                  //校验
                  form.validate();
                  if(form.isValid() == false){
                     nui.alert("业务信息有必填项未录入,请先录入。","系统提示");
                     return;
                  } 
                  
                  if(activityDefID == "FirstGradeBond_KZJ_XXHD1"){
	                  //判断附件集合是否为空，为空时不做校验直接提交
	                  if(SysId == ""){
	                   nui.confirm("没有选择需要用印的附件，确认是否提交！","系统提示",function(action){
						  if(action =="ok"){
	                    	saveData(data , urlStr);
	                      }
	                    }); 
	                  }else{
	                     SysId = child.getFileId();
					      //判断是否有选择需要用印的附件
					      if(SysId != ""){
					          //组装参数		
							  data = {
								workItemID:'<%=workItemID %>',
								pmprcaprvinfo:form.getData(false,true).pmprcaprvinfo,
								bpsParam:form.getData(false,true).bpsParam,
								cfjybusinessbonetable:form.getData(false,true).cfjybusinessbonetable,
								pmprcaprvinfo:form.getData(false,true).pmprcaprvinfo,
								sysids:SysId};
									
					          var Array = SysId.split(",");
						      nui.confirm("已选择" + Array.length + "个需要用印的附件，确认是否提交！","系统提示",function(action){
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
                    saveData(data , urlStr);
                  }   
                }else{
                   saveData(data , urlStr);
                }                                
             }
              function saveData(data , urlStr){
                var json = nui.encode(data);

                $.ajax({
                    url:urlStr,
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.returnValue == "y"){
                          nui.alert("保存成功", "系统提示", function(action){
                            CloseWindow("saveSuccess");
                            window.opener.parent.location.href=window.opener.parent.location.href;
                          });  
                        }else{
                            nui.alert("保存失败", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                    //CloseWindow("saveFailed");
                                }
                                });
                            }
                        }
                        });
              }      

            	var contextPath = '<%=request.getContextPath() %>';
			    
			    
			    //发行规模(万元)
            	function issueSizeFun(){
            	   formatNumberCommon("issueSize",4);
            	}
            	
            	//已投资该发行主体证券存量(万元)
            	function categoryMoneyFun(){
            	   formatNumberCommon("categorymoney",4);
            	}
            	
            	// 产品净值规模(万元)
			     function netWorthScaleFun(){
			         formatNumberCommon("netWorthScale",4);
			     }
            	
            	//计算债券比例
            	function CalculatingProportion(){
            	  var depositAmount = nui.get("depositAmount").getValue().replace(/,/gi,'');    //获取定金金额
	              var issueSize = nui.get("issueSize").getValue().replace(/,/gi,'');    //发行规模
	              var categorymoney = nui.get("categorymoney").getValue().replace(/,/gi,'');    //已投资该发行主体发行证券存量
	              var netWorthScale = nui.get("netWorthScale").getValue().replace(/,/gi,'');    //产品净值规模
	              
	              //当发行规模不为空时计算比例
	              if(issueSize != ""){
	                 nui.get("investmentOccupyIssuesize").setValue(((depositAmount/issueSize) * 100).toFixed(6));
	              }
	              
	              //当产品净值规模与已投资该发行主体发行证券存量不为空时计算比例
	              if(categorymoney != "" && netWorthScale!= ""){
	                nui.get("productEquityRatio").setValue(((categorymoney/netWorthScale) * 100).toFixed(6));
	              }
            	}
            	
            	//缴款金额
			      function paymentMoneyFun(){
			          formatNumberCommon("paymentMoney",0);
			      }
			      //缴款面值
				 function payFaceValueFun(){
				    formatNumberCommon("payFaceValue",4);
				 }
                </script>
                <script src="<%=request.getContextPath() %>/process/util/process.js" type="text/javascript"></script>
                <script type="text/javascript">
                  //获取参数
			      inintProcess("no");
                </script>
            </body>
        </html>
