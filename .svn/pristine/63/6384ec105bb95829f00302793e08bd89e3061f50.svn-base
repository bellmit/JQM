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
   
   //获取工作项信息
   DataObject workitem = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workitem");
   String activityDefID = workitem.getString("activityDefID");
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
<body style="height: 99%;" >
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
		    <input class="nui-hidden" id="cfjybusinessbonetable.vcCombiNo" name="cfjybusinessbonetable.vcCombiNo" value="<b:write property="cfjybusinessbonetable/vcCombiNo" />"/>
		    <input class="nui-hidden"  name="bpsParam.vcSource" value="<b:write property="cfjybusinessbonetable/vcSource" />"/>
		    <table style="width:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td class="form_label td1" width="17%" align="right">
                        业务日期:    
                    </td>
                    <td colspan="1" width="33%">
                        <input class="nui-datepicker" name="cfjybusinessbonetable.processDate" width="170" value="<b:write property="cfjybusinessbonetable/processDate" />" readonly/>
                    </td>
                    <td class="form_label td1" width="17%" align="right">
                        主承机构:
                    </td>
                    <td colspan="1" class="td2" width="33%">
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
                    <td colspan="1" >
                        <%--<input class="nui-textbox" name="cfjybusinessbonetable.investProductCode"/>--%>
                        <input  id="investProductCode" width="170" class="nui-textbox"name="cfjybusinessbonetable.investProductCode" value="<b:write property="cfjybusinessbonetable/investProductCode" />"/>
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
                        <span style="color: red">*</span>登记托管场所:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" width="170" required="true" name="cfjybusinessbonetable.paymentplace" value="<b:write property="cfjybusinessbonetable/paymentplace" />"  emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
                    </td>
                    <td class="form_label td1" align="right">
                        <span style="color: red">*</span>发行主体:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" width="170" name="cfjybusinessbonetable.ratingname" value="<b:write property="cfjybusinessbonetable/ratingname" />" required="true"/>
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
                        <span style="color: red">*</span>投标利率(%):
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" name="cfjybusinessbonetable.interestrate" width="170" value="<b:write property="cfjybusinessbonetable/interestrate" />" required="true" />
                    </td>
                </tr>
                <tr>
                	<td class="form_label td1" align="right">
                        <span style="color: red">*</span>主体类型:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_ZTLX" width="170" required="true" name="cfjybusinessbonetable.ratingType"  value="<b:write property="cfjybusinessbonetable/ratingType" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
                    </td>
                    <td class="form_label td1" align="right">
                       <span style="color: red">*</span> 主体评级:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" width="170" required="true" id="subjectrating" name="cfjybusinessbonetable.subjectrating"
                        emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" value="<b:write property="cfjybusinessbonetable/subjectrating" />"/>
                    </td>
                </tr>
                <tr>
                   <td class="form_label td1" align="right">
                        <span style="color: red">*</span>债项评级:
                    </td>
                    <td colspan="1" class="td2"> 
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" id="bondrating" width="170" required="true" name="cfjybusinessbonetable.bondrating"
                        emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" value="<b:write property="cfjybusinessbonetable/bondrating" />"/>
                    </td>
                    <td class="form_label td1" align="right">
                       <span style="color: red">*</span>债券种类:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY" width="170" required="true" id="investcategory" name="cfjybusinessbonetable.investcategory"
                        emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" value="<b:write property="cfjybusinessbonetable/investcategory" />"/>
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
                        <span style="color: red">*</span>评级机构:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_RATING_AGENCIES" width="170" required="true" id="ratingAgencies" name="cfjybusinessbonetable.ratingagencies" 
                        emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" value="<b:write property="cfjybusinessbonetable/ratingagencies" />" />
                    </td>
                    <td class="form_label td1" align="right">
                       <span style="color: red">*</span>  发行规模(万元):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" id="issueSize" name="cfjybusinessbonetable.issueSize" width="170" value="<b:write property="cfjybusinessbonetable/issueSize" />" 
                        onblur="issueSizeFun" onvaluechanged="calculationNetWorthScale"  />
                    </td>
                </tr>
                <tr>
                     <td class="form_label td1" align="right">
                        <span style="color: red">*</span>已投资该发行主体证券存量(万元):
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" name="cfjybusinessbonetable.categorymoney" required="true" id="categorymoney" onvaluechanged="calculationNetWorthScale" onblur="categoryMoneyFun" width="170" value="<b:write property="cfjybusinessbonetable/categorymoney" />" />
                    </td>
                    <td class="form_label td1" align="right">
                        债券期限(年):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="cfjybusinessbonetable.categorydate" width="170" value="<b:write property="cfjybusinessbonetable/categorydate" />" />
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                       <span style="color: red">*</span>产品净值规模(万元):
                    </td>
                    <td colspan="1" class="td2">
						<input class="nui-textbox" name="cfjybusinessbonetable.netWorthScale" id="netWorthScale" style="width: 170px;" required="true" 
						 onvaluechanged="calculationNetWorthScale" onblur="netWorthScaleFun" value="<b:write property="cfjybusinessbonetable/netWorthScale" />"/>
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
                       dictTypeId="COF_YESORNO" style="float: left;" onvaluechanged="resaleRightOnvaluechanged(e)" value="<b:write property="cfjybusinessbonetable/resaleRight" />"/>
                       
                       &nbsp;<label id="resaleYear" style="float: left;display: none;">行权年：
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_XQNNX" name="cfjybusinessbonetable.resaleYear"
                        value="<b:write property="cfjybusinessbonetable/resaleYear" />"  width="45"/></label>
                    </td>
                    <td class="form_label td1" align="right"> 
                        是否具有赎回权:
                    </td>
                    <td colspan="1" class="radio-border-top-none td2">
                        <input id="redemptionRight" class="nui-dictradiogroup" name="cfjybusinessbonetable.redemptionRight" 
                         dictTypeId="COF_YESORNO" style="float: left;" onvaluechanged="redemptionRightOnvaluechanged(e)" value="<b:write property="cfjybusinessbonetable/redemptionRight" />"/>
                          
                           &nbsp;<label id="redemptionYear" style="float: left;display: none;">行权年：  
       						<input class="nui-dictcombobox" dictTypeId="CF_JY_XQNNX" name="cfjybusinessbonetable.redemptionYear"
       						value="<b:write property="cfjybusinessbonetable/redemptionYear" />" id="redemptionYear" width="45"/></label>
                    </td>
                </tr>
                <tr>
                  <td class="form_label td1" align="right">
                        是否关联交易:
                    </td>
                    <td colspan="3" class="radio-border-top-none td2">
                       
                        <input id="isInquiry" class="nui-dictradiogroup"name="cfjybusinessbonetable.associationBetween" 
                        dictTypeId="COF_YESORNO" style="float: left;" onvaluechanged="isInquiryOnvaluechanged(e)" value="<b:write property="cfjybusinessbonetable/associationBetween" />"/>
                          <input class="nui-textbox" name="cfjybusinessbonetable.associationRemark" id="associationRemark" style="display:none;"width="150" value="<b:write property="cfjybusinessbonetable/associationRemark" />"/>
                    </td>
                </tr>
                <tr>
                  <td class="form_label td1" align="right">债券占比：</td>
                  <td colspan="3" style="padding: 0px;margin: 0xp;" class="td2">
                   <p class="p"><label style="margin-left: 5px;font-weight: inherit;">该笔债券投资占发行规模比例(%): </label>
                   				<input name="cfjybusinessbonetable.investmentOccupyIssuesize" id="investmentOccupyIssuesize" class="nui-textbox asLabel" 
                   				value="<b:write property="cfjybusinessbonetable/investmentOccupyIssuesize" />"/></p>
                   <p class="p"><label style="margin-left: 5px;font-weight: inherit;">同一发行人占产品净值规模比例(%): </label>
                   				<input name="cfjybusinessbonetable.productEquityRatio" id="productEquityRatio" class="nui-textbox asLabel"
                   				value="<b:write property="cfjybusinessbonetable/productEquityRatio" />"/></p>
                   <p class="p"><label style="margin-left: 5px;font-weight: inherit;">该笔债券投资占产品净值规模比例(%): </label>
                   				<input name="cfjybusinessbonetable.bondOccupyProductRatio" id="bondOccupyProductRatio" 
                   				value="<b:write property="cfjybusinessbonetable/bondOccupyProductRatio" />"class="nui-textbox asLabel"/></p>
                   <p><label style="margin-left: 5px;font-weight: inherit;">弱流动性资产规模占产品净值规模比例(%): </label>
                   				<input name="cfjybusinessbonetable.weakLiquidityRatio" id="weakLiquidityRatio"
                   				value="<b:write property="cfjybusinessbonetable/weakLiquidityRatio" />" class="nui-textbox" /></p>
                  </td>
                </tr>											   
                <tr>
                    <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
                        备注:
                    </td>
                    <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
                        <input class="nui-textarea" width="515" height="40" name="cfjybusinessbonetable.remarks" value="<b:write property="cfjybusinessbonetable/remarks" />" readonly/>
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
     var activityDefID = '<%=activityDefID %>';   //获取活动定义ID
     //在线打开用印文档
     var file_grid = nui.get("file_grid");
     function inIt(){
       var issueSize = "<b:write property="cfjybusinessbonetable/issueSize" />".replace(/,/gi,'');      					 //发行规模
       var investcount = "<b:write property="cfjybusinessbonetable/investcount" />".replace(/,/gi,'');   					 //投标金额
       var categorymoney = "<b:write property="cfjybusinessbonetable/categorymoney" />".replace(/,/gi,'');  				 //债券存量
       var netWorthScale = "<b:write property="cfjybusinessbonetable/netWorthScale" />".replace(/,/gi,'');  				 //净值规模
       
       
       //当发行规模与投标金额不为空时计算该笔债券投资占发行规模比例
       //公式为投标金额/发行规模
       if(issueSize != "" && investcount != "" && issueSize!="0" && issueSize > 0){
         nui.get("investmentOccupyIssuesize").setValue(((investcount/issueSize) * 100).toFixed(6));
       }
       
       //当投标金额、债券存量与净值规模都不为空时计算同一发行人占产品净值规模比例
       //公式为(本次投标金额+主体发行债券存量)/净值规模
       if(netWorthScale != "" && investcount != "" && categorymoney!= ""){
         nui.get("productEquityRatio").setValue((((Number(investcount) + Number(categorymoney))/netWorthScale) * 100).toFixed(4));
       }
       
       //当净值规模与投标金额不为空时计算该笔债券投资占产品净值规模比例
       //公式为投标金额/净值规模
       if(netWorthScale != "" && investcount != ""){
         nui.get("bondOccupyProductRatio").setValue(((investcount/netWorthScale) * 100).toFixed(6));
       }
       
     }
     if(activityDefID == "manualActivity1"  || activityDefID == "manualActivity13"){
     	inIt();
     }
     
     var contextPath = '<%=request.getContextPath() %>';
     //获取参数
      var resaleRight = "<b:write property="cfjybusinessbonetable/resaleRight" />";          //是否具有回售权
	  var redemptionRight = "<b:write property="cfjybusinessbonetable/redemptionRight" />";  //是否具有赎回权
	  var isInquiry = "<b:write property="cfjybusinessbonetable/associationBetween" />";     //是否关联交易报备
	  
     
     
     //流程提交
	 function processSubmit(){
		var form = new nui.Form("#dataform1");
		    form.setChanged(false);
		var urlStr = "";
		var data = {};
		
		var operateType = nui.get("operateType").getValue(); //操作
		
		//设置路径
		urlStr = contextPath + "/com.cjhxfund.jy.process.cfjybusinessbonetablebiz.firstGradeBondXXHD1.biz.ext";
		//获取iframe对象
		var child = document.getElementById("prodIfm").contentWindow;
		//获取用印附件列表ID
		var SysId = child.getFileIds();
		
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
        
		//组装参数		
		data = {
			workItemID:'<%=workItemID %>',
			pmprcaprvinfo:form.getData(false,true).pmprcaprvinfo,
			bpsParam:form.getData(false,true).bpsParam,
			cfjybusinessbonetable:form.getData(false,true).cfjybusinessbonetable
		};
		//判断当前环节为信息核对(交易员1)
		if(activityDefID == "manualActivity1"){
		   if(operateType == 1){    //判断操作为同意时
		     //设置路径

		     //判断id是否为空，为空给出提示是否提交，不为空时提示选择了几个附件
			   if(SysId == ""){
			     nui.confirm("没有需要用印的文件,确认是否提交.","系统提示",function(action){
			        if(action == "ok"){
			      		saveData(data,urlStr);
			        }
			     });
			   }else{
			      SysId = child.getFileId();
			      //判断是否选择需要用印的附件
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
		     saveData(data,urlStr);
		   }
		}else{
		   saveData(data,urlStr);
		}		
	}
		
        //当净值规模值出现变化时根据相应公式重新计算比例
	    function calculationNetWorthScale(e){
	      var investcount = nui.get("investcount").getValue().replace(/,/gi,'');        //获取投标金额
	      var categorymoney = nui.get("categorymoney").getValue().replace(/,/gi,'');    //获取债券存量
	      var netWorthScale = nui.get("netWorthScale").getValue().replace(/,/gi,'');    //净值规模
	      var issueSize = nui.get("issueSize").getValue().replace(/,/gi,'');            //发行规模 
	      
	      //当发行规模与投标金额不为空时计算该笔债券投资占发行规模比例
	      //公式为投标金额/发行规模
	      if(issueSize != "" && investcount != "" && issueSize!="0" && issueSize > 0){
	         nui.get("investmentOccupyIssuesize").setValue(((investcount/issueSize) * 100).toFixed(6));
	      }else{
	         nui.get("investmentOccupyIssuesize").setValue("");
	      }
	      
	      //当投标金额、债券存量与净值规模都不为空时计算同一发行人占产品净值规模比例
	   	  //公式为(本次投标金额+主体发行债券存量)/净值规模
	   	  if(netWorthScale !=""){
	          if(investcount != "" || categorymoney!=""){
	            nui.get("productEquityRatio").setValue((((Number(investcount) + Number(categorymoney))/netWorthScale) * 100).toFixed(4));
	          }
	      }else{
	          nui.get("productEquityRatio").setValue("");
	      }
	      
	      //当净值规模与投标金额不为空时计算该笔债券投资占产品净值规模比例
	      //公式为投标金额/净值规模
	      if(netWorthScale != "" && investcount != ""){
	         nui.get("bondOccupyProductRatio").setValue(((investcount/netWorthScale) * 100).toFixed(6));
	      }else{
	        nui.get("bondOccupyProductRatio").setValue("");
	        
	      }
	    }
	    
	    //是否关联交易，选择是时显示文本框输入那种关联交易，选择否时不用输入
		function isInquiryOnvaluechanged(e){
		    var isInquiry = nui.get("isInquiry").getValue();
		    if(isInquiry == 1){
		       document .getElementById("associationRemark").style.display="block";
		    }else{
		       document .getElementById("associationRemark").style.display="none"; 
		    }
		}
		//是否具有回售权，选择是时显示文本框输入行权年，否时不用输入
		function resaleRightOnvaluechanged(e){
		    if(e.value==1){
		       document .getElementById("resaleYear").style.display="block";
		    }else{
		       document .getElementById("resaleYear").style.display="none"; 
		    }
		}
		//是否具有赎回权，选择是时显示文本框输入行权年，否时不用输入
	    function redemptionRightOnvaluechanged(e){
		    if(e.value==1){
		        document .getElementById("redemptionYear").style.display="block";
		    }else{
		        document .getElementById("redemptionYear").style.display="none"; 
		    }
		}
		
		/* var fields = form.getFields();                
            for (var i = 0, l = fields.length; i < l; i++) {
                var c = fields[i];
                if (c.setReadOnly) c.setReadOnly(true);     //只读
                if (c.setIsValid) c.setIsValid(true);      //去除错误提示
                if (c.addCls) c.addCls("asLabel");          //增加asLabel外观
            }
     */

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
     
     //用印环节用印，双击打开文档
		var file_grid = nui.get("file_grid");
	    file_grid.on("rowdblclick", function (e) {
	    	var record = e.record;
	    	var actionURL="<%=request.getContextPath() %>/commonUtil/JQMHistory/iWebOffice/Judgment_document_type.jsp?sysid="+record.sysid+"&fileName="+record.name; //目标页面
			var tabs = nui.get("tab"); 
			
			//add tab
            var tab = {title: "文件用印",url:actionURL};
            tab = tabs.addTab(tab);            

            //active tab
            tabs.activeTab(tab);
		});
		
     if(activityDefID == "ATS_FM_ZJZLSH" || activityDefID == "FirstGradeBond_FKZZ_TZJLQR" || activityDefID == "FirstGradeBond_FKZZ_TZJLQR1"){
            var fields = form.getFields();              
           
            for (var i = 0, l = fields.length; i < l; i++) {
                var c = fields[i];
                if(c.id != "operateType" && c.id!="handlerActor" && c.id!="backActivity" && c.id!="isFallback" && c.id!="comments"){
                	if (c.setReadOnly) c.setReadOnly(true);     //只读
                	if (c.setIsValid) c.setIsValid(true);      //去除错误提示
                	//if (c.addCls) c.addCls("asLabel");          //增加asLabel外观
                }
            }
        }
        
        	
   </script>
   <script src="<%=request.getContextPath() %>/process/util/process.js" type="text/javascript"></script>
   <script type="text/javascript">
     inintProcess();
    
   </script>	
</body>
</html>