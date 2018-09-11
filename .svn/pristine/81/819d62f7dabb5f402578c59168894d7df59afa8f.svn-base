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
<title>投标指令/建议下达</title>
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
		    <input class="nui-hidden"  name="bpsParam.vcSource" value="<b:write property="cfjybusinessbonetable/vcSource" />"/>
		    <!-- 投资比例参数 -->
		    <input class="nui-hidden"  name="cfjybusinessbonetable.investmentOccupyIssuesize" value="<b:write property="cfjybusinessbonetable/investmentOccupyIssuesize" />"/>
		    <input class="nui-hidden"  name="cfjybusinessbonetable.productEquityRatio" value="<b:write property="cfjybusinessbonetable/productEquityRatio" />"/>
		    <input class="nui-hidden"  name="cfjybusinessbonetable.bondOccupyProductRatio" value="<b:write property="cfjybusinessbonetable/bondOccupyProductRatio" />"/>
		    <input class="nui-hidden"  name="cfjybusinessbonetable.weakLiquidityRatio" value="<b:write property="cfjybusinessbonetable/weakLiquidityRatio" />"/>
		    
		    <table style="width:100%;table-layout:fixed;" class="nui-form-table" border="1">
                <tr>
                    <td class="form_label td1" width="17%" align="right">
                        业务日期:    
                    </td>
                    <td colspan="1" width="33%">
                        <input class="nui-datepicker" name="cfjybusinessbonetable.processDate" width="170" value="<b:write property="cfjybusinessbonetable/processDate" />"/>
                    </td>
                    <td class="form_label td1" align="right">
                        主承机构:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" name="cfjybusinessbonetable.mainBearingMechanism" width="170" value="<b:write property="cfjybusinessbonetable/mainBearingMechanism" />"/>
                    </td>
                </tr>
                <tr>
	                  <td class="form_label td1" align="right">
	                        产品名称:
	                  </td>
	                  <td colspan="1">
	                      <input class="nui-autocomplete" id="combProductCode" width="170" required="true" dataField="combProducts"  name="cfjybusinessbonetable.combProductCode" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductsByKeyAndUserId.biz.ext"
                         valueField="fundCode" textField="fundName" onvaluechanged="setCombProductName" searchField="searchKey" value="<b:write property="cfjybusinessbonetable/combProductCode" />" text="<b:write property="cfjybusinessbonetable/combProductName" />" enterQuery="false" />
                        <input class="nui-hidden"id="combProductName" name="cfjybusinessbonetable.combProductName" value="<b:write property="cfjybusinessbonetable/combProductName" />"/>
	                  </td>
	                  <td class="form_label td1" width="25%" align="right">
	                        组合名称:
	                  </td>
	                  <td colspan="1" width="25%">
	                      <input class="nui-combobox" id="vcCombiNo" width="170" required="true" dataField="productCombis"  name="cfjybusinessbonetable.vcCombiNo" 
	                        valueField="vcCombiNo" textField="vcCombiName" onvaluechanged="setVcCombiName" searchField="searchKey" 
	                        value="<b:write property="cfjybusinessbonetable/vcCombiNo" />" text="<b:write property="cfjybusinessbonetable/vcCombiName" />" enterQuery="false"/>
	                      <input class="nui-hidden"id="vcCombiName" name="cfjybusinessbonetable.vcCombiName" value="<b:write property="cfjybusinessbonetable/vcCombiName" />"/>
	                      
	                  </td>
	             </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        债券代码:
                    </td>
                    <td colspan="1">
                        <%--<input class="nui-textbox" name="cfjybusinessbonetable.investProductCode" value="<b:write property="cfjybusinessbonetable/investProductCode" />" readonly/>--%>
                        <input  id="investProductCode" required="true" width="170" class="nui-autocomplete" popupWidth="300" popupHeight="200" name="cfjybusinessbonetable.investProductCode" searchField="searchKey" dataField="investProducts"
                        	valueField="investProductInfo" textField="investProduct" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByKey.biz.ext"  value="<b:write property="cfjybusinessbonetable/investProductCode" />" text="<b:write property="cfjybusinessbonetable/investProductCode" />" enterQuery="false" onitemclick="investProductCodeOnItemClick"
                        	/>
                        	
                    </td>
                    <td class="form_label td1" align="right">
                        债券名称:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" id="investProductName" width="170" name="cfjybusinessbonetable.investProductName" value="<b:write property="cfjybusinessbonetable/investProductName" />"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        登记托管场所:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" width="170" name="cfjybusinessbonetable.paymentplace" value="<b:write property="cfjybusinessbonetable/paymentplace" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
                    </td>
                    <td class="form_label td1" align="right">
                        发行主体:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" width="170" name="cfjybusinessbonetable.ratingname" value="<b:write property="cfjybusinessbonetable/ratingname" />"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label td1" align="right">
                        主体类型:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_ZTLX" width="170" name="cfjybusinessbonetable.ratingType" value="<b:write property="cfjybusinessbonetable/ratingType" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
                    </td>
                    <td class="form_label td1" align="right">
                        主体评级:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" width="170" id="subjectrating" name="cfjybusinessbonetable.subjectrating" value="<b:write property="cfjybusinessbonetable/subjectrating" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        投标金额(万元):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="cfjybusinessbonetable.investcount" id="investcount" width="170" onblur="investCountFun()" value="<b:write property="cfjybusinessbonetable/investcount" />"/>
                    </td>
                    <td class="form_label td1" align="right">
                        投标利率(%):
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" name="cfjybusinessbonetable.interestrate" width="170" value="<b:write property="cfjybusinessbonetable/interestrate" />"/>
                    </td>
                </tr>
                
                <tr>
                	<td class="form_label td1"  align="right">
                        债项评级:
                    </td>
                    <td colspan="1"> 
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" id="bondrating" width="170" name="cfjybusinessbonetable.bondrating" value="<b:write property="cfjybusinessbonetable/bondrating" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
                    </td>
                    <td class="form_label td1" align="right">
                        债券种类:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY" width="170" id="investcategory" name="cfjybusinessbonetable.investcategory" value="<b:write property="cfjybusinessbonetable/investcategory" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
                    </td>
                </tr> 
                <tr>
                    <td class="form_label td1" align="right">
                        评级机构:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_RATING_AGENCIES" width="170" id="ratingAgencies" name="cfjybusinessbonetable.ratingagencies" value="<b:write property="cfjybusinessbonetable/ratingagencies" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
                    </td>
                    <td class="form_label td1" align="right">
                        发行规模(万元):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="cfjybusinessbonetable.issueSize" id="issueSize" onblur="issueSizeFun" width="170" value="<b:write property="cfjybusinessbonetable/issueSize" />"/>
                    </td>
                </tr>
                <tr>
                     <td class="form_label td1" align="right">
                      已投资该发行主体证券存量(万元):
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" name="cfjybusinessbonetable.categorymoney" id="categorymoney" onblur="categoryMoneyFun" width="170" value="<b:write property="cfjybusinessbonetable/categorymoney" />"/>
                    </td>
                    <td class="form_label td1" align="right">
                        债券期限(年):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="cfjybusinessbonetable.categorydate" width="170" value="<b:write property="cfjybusinessbonetable/categorydate" />"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        产品净值规模(万元):
                    </td>
                    <td colspan="1" class="td2">
						<input class="nui-textbox" name="cfjybusinessbonetable.netWorthScale" id="netWorthScale" style="width: 170px;" onblur="netWorthScaleFun"
						value="<b:write property="cfjybusinessbonetable/netWorthScale" />" onvaluechanged="calculationNetWorthScale" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                        首次付息日:
                    </td>
                    <td colspan="1" class="td2">
						<input class="nui-datepicker" name="cfjybusinessbonetable.initialInterestPaymentDate" id="initialInterestPaymentDate"
						value="<b:write property="cfjybusinessbonetable/initialInterestPaymentDate" />" style="width: 170px;" />
                    </td>
                </tr>
                <tr>
                   <td class="form_label td1" align="right">
                        是否具有回售权:
                    </td>
                    <td colspan="1" class="radio-border-top-none">
                        <input id="resaleRight" class="nui-dictradiogroup" name="cfjybusinessbonetable.resaleRight" 
                       dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="cfjybusinessbonetable/resaleRight" />" onvaluechanged="resaleRightOnvaluechanged" />
                       
                       &nbsp;<label id="resaleYear" style="float: left;display: none;">行权年：
                       <input class="nui-dictcombobox" dictTypeId="CF_JY_XQNNX" name="cfjybusinessbonetable.resaleYear"  width="45"
                        value="<b:write property="cfjybusinessbonetable/resaleYear" />" /></label>
                    </td>
                    <td class="form_label td1" align="right"> 
                        是否具有赎回权:
                    </td>
                    <td colspan="1" class="radio-border-top-none td2">
                        <input id="redemptionRight" class="nui-dictradiogroup" name="cfjybusinessbonetable.redemptionRight" 
                         dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="cfjybusinessbonetable/redemptionRight" />" onvaluechanged="redemptionRightOnvaluechanged"/>
                         
                        &nbsp;<label id="redemptionYear" style="float: left;display: none;">行权年：  
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_XQNNX" name="cfjybusinessbonetable.redemptionYear" 
       					width="45" value="<b:write property="cfjybusinessbonetable/redemptionYear" />" /></label>
                    </td>
                </tr>
                <tr>
                   <td class="form_label td1" align="right">
                        是否关联交易:
                    </td>
                    <td colspan="3" class="radio-border-top-none td2">
                       
                        <input id="isInquiry" class="nui-dictradiogroup"name="cfjybusinessbonetable.associationBetween"  onvaluechanged="isInquiryOnvaluechanged"
                        dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="cfjybusinessbonetable/associationBetween" />"/>
                          <input class="nui-textbox" name="cfjybusinessbonetable.associationRemark" id="associationRemark" style="display:none;"width="150" value="<b:write property="cfjybusinessbonetable/associationRemark" />"/>
                    </td>

                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        备注:
                    </td>
                    <td colspan="3" class="td2">
                        <input class="nui-textarea" width="515" height="80" name="cfjybusinessbonetable.remarks" value="<b:write property="cfjybusinessbonetable/remarks" />"/>
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
     var contextPath = '<%=request.getContextPath() %>';
     var activityDefID = '<b:write property="workitem/activityDefID" />';     //获取环节活动定义ID
     //在线打开用印文档
     var file_grid = nui.get("file_grid");
     //获取参数
      var resaleRight = "<b:write property="cfjybusinessbonetable/resaleRight" />";          //是否具有回售权
	  var redemptionRight = "<b:write property="cfjybusinessbonetable/redemptionRight" />";  //是否具有赎回权
	  var isInquiry = "<b:write property="cfjybusinessbonetable/associationBetween" />";              //是否关联交易报备
     
     //流程提交
	 function processSubmit(){
		var form = new nui.Form("#dataform1");
		    form.setChanged(false);
		var urlStr = contextPath + "/com.cjhxfund.jy.process.cfjybusinessbonetablebiz.firstGradeBondXXHD.biz.ext";
		
			
		//流程js验证
		if(checkForm()==false) return;
				
		//设置组合名称
		nui.get("vcCombiName").setValue(nui.get("vcCombiNo").getText());
		
		var data = {workItemID:'<%=workItemID %>',pmprcaprvinfo:form.getData(false,true).pmprcaprvinfo,bpsParam:form.getData(false,true).bpsParam,cfjybusinessbonetable:form.getData(false,true).cfjybusinessbonetable};
				
		saveData(data,urlStr);
	}
		
        
        //自动增加千分位-交易数量（万元）
        function investCountFun(){
             formatNumberCommon("investcount",4,1);
        }
        
        //债券代码下拉项点击时触发函数
		function investProductCodeOnItemClick(){
		   var investProductCode = nui.get("investProductCode").getValue();//投资产品信息
		   if(investProductCode!=null && investProductCode!=""){
                	
		      //通过交易市场编号、证券申报代码到O32系统查找投资的债券、股票等产品信息（包含债券评级等债券属性）
		      var paramArr = investProductCode.split(",");
			  $.ajax({
				url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductInfoByMarketNoAndReportCode.biz.ext",
				type:'POST',
				data:nui.encode({marketNo:paramArr[2], reportCode:paramArr[0]}),
				cache:false,
				contentType:'text/json',
				success:function(text){
					var returnJson = nui.decode(text);
					if(returnJson.exception == null){
					    var investProductInfo = returnJson.investProductInfo;//投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
					                	
					    //投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
					    var investProductCodeArr = investProductInfo.split(",");
					    var investProductCodeVal = investProductCodeArr[0];//债券代码
					    var investProductNameVal = investProductCodeArr[1];//债券名称
					    var investCategoryVal = investProductCodeArr[2];//债券类别代码
					    var bondRatingVal = investProductCodeArr[3];//债券评级代码
					    var subjectRatingVal = investProductCodeArr[4];//主体评级代码
					    var ratingAgenciesVal = investProductCodeArr[5];//评级机构代码
					                	
						nui.get("investProductCode").setText(investProductCodeVal);
						nui.get("investProductCode").setValue(investProductCodeVal);
						nui.get("investProductName").setValue(investProductNameVal);
						//设置债券类别
						if(investCategoryVal!=null && investCategoryVal!="" && investCategoryVal!="★"){
						    nui.get("investcategory").setValue(investCategoryVal);
						}else{
						    nui.get("investcategory").setValue(null);
						}
						//债券评级
						if(bondRatingVal!=null && bondRatingVal!="" && bondRatingVal!="★"){
						    nui.get("bondrating").setValue(bondRatingVal);
						}else{
						    nui.get("bondrating").setValue(null);
						}
						//主体评级
						if(subjectRatingVal!=null && subjectRatingVal!="" && subjectRatingVal!="★"){
						     nui.get("subjectrating").setValue(subjectRatingVal);
						 }else{
						     nui.get("subjectrating").setValue(null);
						 }
						//评级机构
						if(ratingAgenciesVal!=null && ratingAgenciesVal!="" && ratingAgenciesVal!="★"){
						     nui.get("ratingAgencies").setValue(ratingAgenciesVal);
						}else{
						     nui.get("ratingAgencies").setValue(null);
						}
					                	
					}else{
					        nui.alert("债券详细信息获取失败", "系统提示");
					}
				 }
			});
		  }else{
		      nui.get("investProductCode").setText(null);
			  nui.get("investProductCode").setValue(null);
		  }
	}
		            
        //发行规模(万元)
	    function issueSizeFun(){
	        formatNumberCommon("issueSize",0);
	     }
	            	
	     //已投资该发行主体证券存量(万元)
	     function categoryMoneyFun(){
	          formatNumberCommon("categorymoney",0);
	     }
	            	
	     // 产品净值规模(万元)
	     function netWorthScaleFun(){
	         formatNumberCommon("netWorthScale",0);
	     }
	     
	     //是否关联交易，选择是时显示文本框输入那种关联交易，选择否时不用输入
		function isInquiryOnvaluechanged(e){
		   var isInquiry = nui.get("isInquiry").getValue();
		   if(isInquiry==1){
		     document .getElementById("associationRemark").style.display="block";
		   }else{
		     document .getElementById("associationRemark").style.display="none"; 
		   }
		}
		//是否具有回售权，选择是时显示文本框输入行权年，否时不用输入
		function resaleRightOnvaluechanged(e){
		   if(e.value==1){
		     document.getElementById("resaleYear").style.display="block";
		   }else{
		     document.getElementById("resaleYear").style.display="none";
		   }
		}
		//是否具有赎回权，选择是时显示文本框输入行权年，否时不用输入
		function redemptionRightOnvaluechanged(e){
		   if(e.value==1){
		     document.getElementById("redemptionYear").style.display="block";
		   }else{
		     document.getElementById("redemptionYear").style.display="none";
		   }
		}
		
		function setCombProductName(e){
	  		nui.get("combProductName").setValue(nui.get("combProductCode").getText());
 
			var vcCombiNo = nui.get("vcCombiNo");
			vcCombiNo.setValue("");
			  
		    var url = "com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getCombiNosByKeyUserId.biz.ext?productCodes=" + nui.get("combProductCode").getValue();
		    vcCombiNo.setUrl(url);
		    
		    //默认选中第一条数据
		    vcCombiNo.select(0);
		}
		setCombProductName();
	//选择组合时触发
	function setVcCombiName(e){
		nui.get("vcCombiName").setValue(nui.get("vcCombiNo").getText());
	}
	
   </script>	
   <script src="<%=request.getContextPath() %>/process/util/process.js" type="text/javascript"></script>
   <script type="text/javascript">
     inintProcess();
     
   </script>
</body>
</html>