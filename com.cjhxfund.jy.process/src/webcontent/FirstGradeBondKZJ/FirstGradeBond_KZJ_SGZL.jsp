
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
	                        <input class="nui-datepicker" name="cfjybusinessbonetable.processDate" required="true"
	                        value="<b:write property="cfjybusinessbonetable/processDate" />" width="170" />
	                    </td>
	                   <td class="form_label td1" align="right" width="17.5%"> 
	                        主承机构:
	                    </td>
	                    <td colspan="1" width="32.5%" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.mainBearingMechanism" value="<b:write property="cfjybusinessbonetable/mainBearingMechanism" />" width="170"/>
	                    </td>
	                </tr>
	                <tr>
						<td class="form_label td1" width="17.5%" align="right">
		                        产品名称:
						</td>
						<td colspan="1" width="32.5%">
							<input class="nui-autocomplete" id="combProductCode" width="170" required="true" dataField="combProducts"  name="cfjybusinessbonetable.combProductCode" 
		                     	url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductsByKeyAndUserId.biz.ext"
		                     	valueField="fundCode" textField="fundName" onvaluechanged="setCombProductName" searchField="searchKey"
		                     	 value="<b:write property="cfjybusinessbonetable/combProductCode" />" text="<b:write property="cfjybusinessbonetable/combProductName" />" enterQuery="false"/>
		                    <input class="nui-hidden"id="combProductName" name="cfjybusinessbonetable.combProductName" value="<b:write property="cfjybusinessbonetable/combProductName" />"/>
		                </td>
		                <td class="form_label td1" width="17.5%" align="right">
		                        组合名称:
		                </td>
		                <td colspan="1" width="32.5%" class="td2">
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
	                       <%-- <input class="nui-textbox" name="cfjybusinessbonetable.investProductCode"/>--%>
	                        <input  id="investProductCode"  width="170" class="nui-autocomplete" popupWidth="300" popupHeight="200" name="cfjybusinessbonetable.investProductCode" searchField="searchKey" dataField="investProducts"
	                        	valueField="investProductInfo" textField="investProduct" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByKey.biz.ext"   text="<b:write property="cfjybusinessbonetable/investProductCode" />" enterQuery="false"
	                        	value="<b:write property="cfjybusinessbonetable/investProductCode" />" onitemclick="investProductCodeOnItemClick" onvaluechanged="enterSumbit"/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                        债券名称:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox"  required="true" name="cfjybusinessbonetable.investProductName" id="investProductName"
	                        value="<b:write property="cfjybusinessbonetable/investProductName" />" width="170"/>
	                    </td>
	                    
	                </tr>
	                <tr>
	                  <td class="form_label td1" align="right">
	                        申购金额(万元):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.purchaseAmount" required="true"
	                        value="<b:write property="cfjybusinessbonetable/purchaseAmount" />" id="purchaseAmount" width="170" onvaluechanged="calculationAmount(e)"/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                        定金比例(%):
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.depositRatio" required="true" id="depositRatio" 
	                        value="<b:write property="cfjybusinessbonetable/depositRatio" />" width="170" onvaluechanged="calculationAmount(e)"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" align="right">
	                        定金金额(万元):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.depositAmount" id="depositAmount"
	                         value="<b:write property="cfjybusinessbonetable/depositAmount" />" width="170" />
	                    </td>
	                    <td class="form_label td1" align="right">
	                        发行主体:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.ratingname" width="170"
	                         value="<b:write property="cfjybusinessbonetable/ratingname" />"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" align="right">
	                        发行主体类型:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_ZTLX" name="cfjybusinessbonetable.ratingType" width="170"
	                        emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" value="<b:write property="cfjybusinessbonetable/ratingType" />"/>
	                    </td>             
	                    <td class="form_label td1" align="right">
	                        主体评级:
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING"
	                         name="cfjybusinessbonetable.subjectrating" id="subjectrating" emptyText="---请选择---" nullItemText="---请选择---"
	                          showNullItem="true" width="170" value="<b:write property="cfjybusinessbonetable/subjectrating" />"/>
	                    </td>
	                <tr>    
	                    <td class="form_label td1" align="right">
	                        债项评级:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING"
	                         name="cfjybusinessbonetable.bondrating" id="bondrating" emptyText="---请选择---" nullItemText="---请选择---"
	                          showNullItem="true" width="170" value="<b:write property="cfjybusinessbonetable/bondrating" />"/>
	                    </td>
	                    <td class="form_label td1" align="right">
		                        债券种类:
		                    </td>
		                    <td colspan="1" class="td2">
		                        <input class="nui-dictcombobox" required="true" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY" width="170" id="investcategory" name="cfjybusinessbonetable.investcategory" 
		                        value="<b:write property="cfjybusinessbonetable/investcategory" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
		                 </td>
	                </tr>
	                <tr>
	                   <td class="form_label td1" align="right">
	                        评级机构:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_RATING_AGENCIES" name="cfjybusinessbonetable.ratingagencies" id="ratingAgencies" 
	                        value="<b:write property="cfjybusinessbonetable/ratingagencies" />" width="170"/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                        发行规模(万元):
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.issueSize" value="<b:write property="cfjybusinessbonetable/issueSize" />" width="170"/>
	                    </td>
	                 </tr>
	                 <tr>
	                    <td class="form_label td1"  align="right">
	                        债券期限(年):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.categorydate" value="<b:write property="cfjybusinessbonetable/categorydate" />" width="170"/>
	                    </td>
	                    <td class="form_label td1" align="right">
	                        已投资该发行主体证券存量(万元):
	                    </td>
	                    <td colspan="1" class="td2">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.categorymoney" value="<b:write property="cfjybusinessbonetable/categorymoney" />" width="170"/>
	                    </td>   
	                  </tr>
	                  <tr>
		                    <td class="form_label td1" align="right">
		                        净值规模(万元):
		                    </td>
		                    <td colspan="3" class="td2">
		                        <input class="nui-textbox" name="cfjybusinessbonetable.netWorthScale" id="netWorthScale"
		                        value="<b:write property="cfjybusinessbonetable/netWorthScale" />"  onblur="netWorthScaleFun" width="170"/>
		                    </td>
		                  </tr>
	                <tr>
	                    <td class="form_label td1 p" align="right">
	                        备注:
	                    </td>
	                    <td colspan="3" class="td2 p">
	                        <input class="nui-textarea" width="600" height="60" name="cfjybusinessbonetable.remarks" value="<b:write property="cfjybusinessbonetable/remarks" />"/>
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

		function processSubmit(){
			//获取产品名称并设置
			var combProductCodeVal = nui.get("combProductCode").getValue();//获取产品代码值
			var combProductNameVal = nui.get("combProductCode").getText();//获取产品名称值（从表单显示值取）
			nui.get("combProductName").setValue(combProductNameVal);
                
			//判断产品编号与产品名称是否一样。一样说明产品名称不对
			if(combProductCodeVal==combProductNameVal){
				nui.alert("请输入选择正确的产品名称","提示");
				nui.get("combProductCode").focus();
				return;
			}
			
			//设置组合名称
			nui.get("vcCombiName").setValue(nui.get("vcCombiNo").getText());
				
			var form = new nui.Form("#dataform1");
				form.setChanged(false);
			//保存
			var urlStr = "com.cjhxfund.jy.process.cfjybusinessbonetableKZZ.FirstGradeBond_KZJ_ZQSG.biz.ext";
			form.validate();
			if(form.isValid()==false) return;

			var data = form.getData(false,true);
			var json = nui.encode(data);
			$.ajax({
				url:urlStr,
				type:'POST',
				data:json,
				cache:false,
				contentType:'text/json',
				success:function(text){
					var returnJson = nui.decode(text);
					if(returnJson.returnValue == "yes"){
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
                    
		//计算定金金额
		function calculationAmount(){
            	   
			//获取申购金额与定金比例
			var purchaseAmounts = nui.get("purchaseAmount").getValue();
			var x = purchaseAmounts.split(",");
			var purchaseAmount = parseFloat(x.join(""));
            	   
			var depositRatio = nui.get("depositRatio").getValue();
			var amount = 0.0;
            	   
			//判断申购金额与定金金额是否为空，不为空计算定金金额
			//计算公式(申购金额  * 定金比例)/100
			if(purchaseAmount != "" && depositRatio != ""){
				amount = (parseFloat(purchaseAmount) * parseFloat(depositRatio))/100;
			}
			nui.get("depositAmount").setValue(parseFloat(amount));
			//设置定金金额加千分位
			formatNumberCommon("depositAmount",4);
		}    
            	
		function enterSumbit(e){  
			var investProductCode = e.value;
			var   i = investProductCode.indexOf(",");
			//获取参数值，并判断有没有","分割.有分割参数并赋值
			if(investProductCode!=null && investProductCode!="" && investProductCode.indexOf(",")!=-1){
				var investProductCodes = investProductCode.split(",");
				nui.get("investProductCode").setText(investProductCodes[0]);
				nui.get("investProductName").setValue(investProductCodes[1]);
			}
			if(i != -1){
				investProductCodeOnItemClick();
			} 
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
							
							//债券类别
							if(investCategoryVal !=null && investCategoryVal!= "" && investCategoryVal!="★"){
								nui.get("investcategory").setValue(investCategoryVal);
							}else{
								nui.get("investcategory").setValue(null);
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

    	function setCombProductName(e){
	  		nui.get("combProductName").setValue(nui.get("combProductCode").getText());
 
			var vcCombiNo = nui.get("vcCombiNo");
			vcCombiNo.setValue("");
			  
		    var url = "com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getCombiNosByKeyUserId.biz.ext?productCodes=" + nui.get("combProductCode").getValue();
		    vcCombiNo.setUrl(url);
		    
		    //默认选中第一条数据
		    if(vcCombiNo.getValue() == ""){
		    	vcCombiNo.select(0);
		    }
		}
		setCombProductName();
		//选择组合时触发
		function setVcCombiName(e){
			nui.get("vcCombiName").setValue(nui.get("vcCombiNo").getText());
		}        	
            	
		var contextPath = '<%=request.getContextPath() %>';
		//用印环节用印，双击打开文档
		var file_grid = nui.get("file_grid");   //获取附件列表对象
				    
	</script>
	<script src="<%=request.getContextPath() %>/process/util/process.js" type="text/javascript"></script>
	<script type="text/javascript">
		//获取参数
	 	inintProcess("no");
	</script>
	</body>
</html>
