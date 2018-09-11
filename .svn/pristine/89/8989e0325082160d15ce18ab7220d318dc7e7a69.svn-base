
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
- Author(s): chenpeng1
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
        </style>
    </head>
    <body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
       <div id="dataform1" style="height: 100%">
       <div class="nui-tabs" id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">
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
	                        主承机构:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.mainBearingMechanism" 
	                        value="<b:write property="cfjybusinessbonetable/mainBearingMechanism" />" width="170" readonly/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                        净值规模(万元):
	                    </td>
	                    <td colspan="1" class="td2">
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
	                    <%--<td class="form_label td1" width="17%" align="right">
	                        交易方式:    
	                    </td>
	                    <td colspan="1" width="33%">
	                        <input class="nui-dictcombobox" dictTypeId="TRANSACTION_TYPE" name="cfjybusinessbonetable.transactionType"
	                          value="<b:write property="cfjybusinessbonetable/transactionType" />" width="170"   />
	                    </td>--%>
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
 			var contextPath = '<%=request.getContextPath() %>';
 			var file_grid = nui.get("file_grid");               //获取附件列表对象
 			
            function processSubmit(){

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                var SysId = "";
                var child = null;
                //保存
                var urlStr = "com.cjhxfund.jy.process.cfjybusinessbonetableKZZ.FirstGradeBond_KZJ_XXHD.biz.ext";
                
                //只有当环节不等于传真时获取附件列表信息，
                if(activityDefID !="FirstGradeBond_KZJ_CZ"){
                	//获取iframe对象
					child = document.getElementById("prodIfm").contentWindow;
					//获取用印附件列表ID
					SysId = child.getFileIds();
				}
				//组装参数
                data = {
					workItemID:'<%=workItemID %>',
					pmprcaprvinfo:form.getData(false,true).pmprcaprvinfo,
					bpsParam:form.getData(false,true).bpsParam,
					cfjybusinessbonetable:form.getData(false,true).cfjybusinessbonetable,
					pmprcaprvinfo:form.getData(false,true).pmprcaprvinfo};
				
				var operateType = nui.get("operateType").getValue(); //操作

				//判断操作为同意时
                if(operateType == 1){
                  //校验
                  form.validate();
                  if(form.isValid()==false) return;
                  
                  //当环节为传真时，提交验证传真号与主题是否为空，为空不允许提交
                  /* if(activityDefID == "FirstGradeBond_KZJ_CZ"){
                       var FaxNumber = nui.get("FaxNumber").getValue();
				       var theme = nui.get("theme").getValue();
				       if(FaxNumber == "" || theme == ""){
				          nui.alert("操作为同意时，传真号与主题不能为空。","系统提示");
				          return;
				       }
                  } */
                  
                  //当当前环节为指标过滤时
                  if(activityDefID == "FirstGradeBond_KZJ_ZBGL"){
					 urlStr = "com.cjhxfund.jy.process.cfjybusinessbonetableKZZ.FirstGradeBond_KZJ_XXHD.biz.ext";
					 saveData(data , urlStr);
				  }else if(activityDefID == "FirstGradeBond_KZJ_YY"){     //当前环节为用印时             
	                  //判断附件集合是否为空，为空时不做校验直接提交
	                  if(SysId == ""){
	                    saveData(data , urlStr);
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
						      nui.confirm("已选择" + Array.length + "个已用印的附件，确认是否提交！","系统提示",function(action){
						          if(action == "ok"){
						             saveData(data,urlStr);
						          }else{
						            return;
						          }
						      });
					   	  }else{
					   	   nui.confirm("没有选择已用印的附件，确认是否提交！","系统提示",function(action){
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
 
              
              //
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
				
				//中签金额
				function ballotMoneyFun(){
				   formatNumberCommon("ballotMoney",4);
				}
				
				//中签数量
				function ballotNumberFun(){
				   formatNumberCommon("ballotNumber",4);
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
				 
				 var operateText = nui.get("operateType").getSelected().text;
	 			 nui.get("comments").setValue(operateText);
                </script>
                <script src="<%=request.getContextPath() %>/process/util/process.js" type="text/javascript"></script>
                <script type="text/javascript">
			      //获取参数
			      inintProcess("no");
                </script>
            </body>
        </html>
