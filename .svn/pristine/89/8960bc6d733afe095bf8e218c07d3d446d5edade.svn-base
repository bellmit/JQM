<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
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
      .asLabel .mini-textbox-input{
        color: red;
        background:none;cursor:default;
      }
      .asLabel_gray .mini-textbox-input{
         color: black;
         background:none;cursor:default;
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
   <div class="nui-tabs" id="tab" activeIndex="0"  style="width:100%;height:100%;">
		<!-- 业务类型标签页开始... -->
		<div title="基本信息">
		    <input class="nui-hidden" id="processinstid" name="processinstid" value="<%=processinstid %>"/>
		    <input class="nui-hidden" id="workItemID" name="workItemID" value="<%=workItemID %>"/>
		    
		    <input class="nui-hidden" id="cfjybusinessbonetable.btId" name="cfjybusinessbonetable.btId" value="<b:write property="cfjybusinessbonetable/btId" />"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.bizId" name="cfjybusinessbonetable.bizId" value="<b:write property="cfjybusinessbonetable/bizId" />"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.businesstype" name="cfjybusinessbonetable.businesstype" value="<b:write property="cfjybusinessbonetable/businesstype" />"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.investproductnum" name="cfjybusinessbonetable.investproductnum" value="<b:write property="cfjybusinessbonetable/investproductnum" />"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.combProductCode" name="cfjybusinessbonetable.combProductCode" value="<b:write property="cfjybusinessbonetable/combProductCode" />"/>
		    <input class="nui-hidden" id="cfjybusinessbonetable.vcCombiNo" name="cfjybusinessbonetable.vcCombiNo" value="<b:write property="cfjybusinessbonetable/vcCombiNo" />"/>
		    
		    <!-- 投资比例参数 -->
		    <input class="nui-hidden"  name="cfjybusinessbonetable.investmentOccupyIssuesize" value="<b:write property="cfjybusinessbonetable/investmentOccupyIssuesize" />"/>
		    <input class="nui-hidden"  name="cfjybusinessbonetable.productEquityRatio" value="<b:write property="cfjybusinessbonetable/productEquityRatio" />"/>
		    <input class="nui-hidden"  name="cfjybusinessbonetable.bondOccupyProductRatio" value="<b:write property="cfjybusinessbonetable/bondOccupyProductRatio" />"/>
		    <input class="nui-hidden"  name="cfjybusinessbonetable.weakLiquidityRatio" value="<b:write property="cfjybusinessbonetable/weakLiquidityRatio" />"/>
		    
		    <input class="nui-hidden"  name="bpsParam.vcSource" value="<b:write property="cfjybusinessbonetable/vcSource" />"/>
		    <!-- 判断参数 -->
		    <input class="nui-hidden" id="investcount" name="investcount" value="<b:write property="cfjybusinessbonetable/investcount" />"/>
		    <input class="nui-hidden" id="interestrate" value="<b:write property="cfjybusinessbonetable/interestrate" />" />
		    
		    <table style="width:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td class="form_label td1" width="17%" align="right">
                        业务日期:    
                    </td>
                    <td colspan="1" width="33%">
                        <input class="nui-datepicker" name="cfjybusinessbonetable.processDate" width="170" value="<b:write property="cfjybusinessbonetable/processDate" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right" width="17%">
                        主承机构:
                    </td>
                    <td colspan="1" class="td2" width="33%">
                        <input class="nui-textbox" name="cfjybusinessbonetable.mainBearingMechanism" width="170" value="<b:write property="cfjybusinessbonetable/mainBearingMechanism" />" readonly/>
                    </td>
                </tr>
                <tr>
                  <td class="form_label td1"  align="right">
                        产品名称:
                    </td>
                    <td colspan="1"  class="td2">
                        <input class="nui-textbox" id="combProductName" width="170" name="cfjybusinessbonetable.combProductName" value="<b:write property="cfjybusinessbonetable/combProductName" />" readonly/>
                    </td>
                    <td class="form_label td1"  align="right">
	                        组合名称:
	                  </td>
	                  <td colspan="1" class="td2">
	                      <input class="nui-textbox" width="170" id="vcCombiName" name="cfjybusinessbonetable.vcCombiName" value="<b:write property="cfjybusinessbonetable/vcCombiName" />" readonly/>
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
                    <td colspan="1" class="td1">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" width="170" name="cfjybusinessbonetable.paymentplace" value="<b:write property="cfjybusinessbonetable/paymentplace" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                        发行主体:
                    </td>
                    <td colspan="1" class="td1">
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
                    <td colspan="1" class="td1">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" width="170" id="subjectrating" name="cfjybusinessbonetable.subjectrating" 
                        value="<b:write property="cfjybusinessbonetable/subjectrating" />" readonly/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        <span style="color: red">*</span>投标金额(万元):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" style="color: red;" name="cfjybusinessbonetable.investcount" width="170" onblur="investCountFun()" id="n_investcount" value="<b:write property="cfjybusinessbonetable/investcount" />" required="true"/>
                    </td>
                    <td class="form_label td1"  align="right">
                        <span style="color: red">*</span>投标利率(%):
                    </td>
                    <td colspan="1" class="td2" >
                        <input class="nui-textbox" name="cfjybusinessbonetable.interestrate" id="n_interestrate"  width="170" onblur="interestrateFun()" value="<b:write property="cfjybusinessbonetable/interestrate" />" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        债项评级:
                    </td>
                    <td colspan="1" class="td2"> 
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" id="bondrating" width="170"
                         name="cfjybusinessbonetable.bondrating" value="<b:write property="cfjybusinessbonetable/bondrating" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                        债券种类:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY" width="170" id="investcategory" name="cfjybusinessbonetable.investcategory" value="<b:write property="cfjybusinessbonetable/investcategory" />" readonly/>
                    </td>
                </tr>
                
                <tr>
                    <td class="form_label td1" align="right">
                        评级机构:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_RATING_AGENCIES" width="170" id="ratingAgencies" name="cfjybusinessbonetable.ratingagencies" value="<b:write property="cfjybusinessbonetable/ratingagencies" />" readonly/>
                    </td>
                    <td class="form_label td1" align="right">
                         发行规模(万元):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="cfjybusinessbonetable.issueSize" id="issueSize" width="170" value="<b:write property="cfjybusinessbonetable/issueSize" />" readonly/>
                    </td>
                </tr>
                <tr>
                    
                     <td class="form_label td1" align="right">
                       已投资该发行主体证券存量(万元):
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" name="cfjybusinessbonetable.categorymoney" id="categorymoney" width="170" value="<b:write property="cfjybusinessbonetable/categorymoney" />" readonly/>
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
                       dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="cfjybusinessbonetable/resaleRight" />" readonly/>
                       &nbsp;<label id="resaleYear" style="float: left;display: none;">行权年：
                       <input class="nui-textbox"  name="cfjybusinessbonetable.resaleYear" id="resaleYear" width="45"
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
                    <td colspan="1" class="radio-border-top-none td2">
                       
                        <input id="isInquiry" class="nui-dictradiogroup"name="cfjybusinessbonetable.associationBetween" 
                        dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="cfjybusinessbonetable/associationBetween" />"  readonly/>
                          
                          <input class="nui-textbox" name="cfjybusinessbonetable.associationRemark" id="associationRemark" 
                          style="display:none;"width="150" value="<b:write property="cfjybusinessbonetable/associationRemark" />" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                  <td class="form_label td1" align="right">债券占比：</td>
                  <td colspan="3" style="padding: 0px;margin: 0xp;" class="td2">
                   <p class="p"><label style="margin-left: 5px;font-weight: inherit;">该笔债券投资占发行规模比例(%): </label>
                   				<input name="cfjybusinessbonetable.investmentOccupyIssuesize" id="investmentOccupyIssuesize" class="nui-textbox" 
                   				value="<b:write property="cfjybusinessbonetable/investmentOccupyIssuesize" />" readonly="readonly"/></p>
                   <p class="p"><label style="margin-left: 5px;font-weight: inherit;">同一发行人占产品净值规模比例(%): </label>
                   				<input name="cfjybusinessbonetable.productEquityRatio" id="productEquityRatio" class="nui-textbox"
                   				value="<b:write property="cfjybusinessbonetable/productEquityRatio" />" readonly="readonly"/></p>
                   <p class="p"><label style="margin-left: 5px;font-weight: inherit;">该笔债券投资占产品净值规模比例(%): </label>
                   				<input name="cfjybusinessbonetable.bondOccupyProductRatio" id="bondOccupyProductRatio" 
                   				value="<b:write property="cfjybusinessbonetable/bondOccupyProductRatio" />"class="nui-textbox" readonly="readonly"/></p>
                   <p><label style="margin-left: 5px;font-weight: inherit;">弱流动性资产规模占产品净值规模比例(%): </label>
                   				<input name="cfjybusinessbonetable.weakLiquidityRatio" id="weakLiquidityRatio"
                   				value="<b:write property="cfjybusinessbonetable/weakLiquidityRatio" />" class="nui-textbox" style="border: 0px;" readonly="readonly"/></p>
                  </td>
                </tr>	
                <tr>
                    <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
                        备注:
                    </td>
                    <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
                        <input class="nui-textarea" width="515" height="40" name="cfjybusinessbonetable.remarks" value="<b:write property="cfjybusinessbonetable/remarks" />" />
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
     //获取参数
      var resaleRight = "<b:write property="cfjybusinessbonetable/resaleRight" />";          //是否具有回售权
	  var redemptionRight = "<b:write property="cfjybusinessbonetable/redemptionRight" />";  //是否具有赎回权
	  var isInquiry = "<b:write property="cfjybusinessbonetable/associationBetween" />";              //是否关联交易报备
      var activityDefID = '<b:write property="workitem/activityDefID" />';     //获取环节活动定义ID
     
     //将维修改的投标金额赋给比较值
     nui.get("investcount").setValue("<b:write property="cfjybusinessbonetable/investcount" />");
     
     //流程提交
	 function processSubmit(){
	    //var operateType = nui.getbyName("bpsParam.operateType").getValue();	
		var form = new nui.Form("#dataform1");
		    form.setChanged(false);
		var urlStr = contextPath + "/com.cjhxfund.jy.process.cfjybusinessbonetablebiz.firstGradeBondBJXG.biz.ext";
			
		//流程js验证
		if(checkForm()==false) return;
			
		/* if(operateType == 1){
			var yn = nui.get("yn").getValue();
			if(yn == ""){
				nui.alert("当操作为同意时，请选择是否修改选项。","系统提示");
				return;
			}
		} */
			
		var data = {
			investcount:nui.get("investcount").getValue(),
			workItemID:'<%=workItemID %>',
			pmprcaprvinfo:form.getData(false,true).pmprcaprvinfo,
			bpsParam:form.getData(false,true).bpsParam,
			cfjybusinessbonetable:form.getData(false,true).cfjybusinessbonetable,
			interestrate:nui.get("interestrate").getValue()};
				
		saveData(data,urlStr);
	}
		
        //自动增加千分位-交易数量（万元）
        function investCountFun(){
            formatNumberCommon("n_investcount",4,1);
            
            //获取修改前投标金额与修改后投标金额
            var n_investcount = nui.get("n_investcount").getValue().replace(/,/gi,'');
            var investcount = nui.get("investcount").getValue().replace(/,/gi,'');
            
            //判断修改前与修改后金额是否修改，修改的话标红.否则恢复为原来样式
            if(n_investcount != investcount){
            	nui.get("n_investcount").removeCls("asLabel_gray");
            	nui.get("n_investcount").addCls("asLabel");
            }else{
            	nui.get("n_investcount").removeCls("asLabel");
                nui.get("n_investcount").addCls("asLabel_gray");
            }
            
            //重新计算比例
            calculationNetWorthScale();
        }
        
        //判断是否修改
        function interestrateFun(){
        
        	//获取修改前投标利率与修改后投标利率
            var n_interestrate = nui.get("n_interestrate").getValue();
            var interestrate = nui.get("interestrate").getValue();
            //判断修改前与修改后投标利率是否修改，修改的话标黄。否则恢复为原来样式
            if(n_interestrate != interestrate){
               nui.get("n_interestrate").removeCls("asLabel_gray");
               nui.get("n_interestrate").addCls("asLabel");
            }else{
               nui.get("n_interestrate").removeCls("asLabel");
               nui.get("n_interestrate").addCls("asLabel_gray");
            }
        }
        
        //当净值规模值出现变化时根据相应公式重新计算比例
	    function calculationNetWorthScale(e){
	      var investcount = nui.get("n_investcount").getValue().replace(/,/gi,'');        //获取投标金额
	      var categorymoney = nui.get("categorymoney").getValue().replace(/,/gi,'');    //获取债券存量
	      var netWorthScale = nui.get("netWorthScale").getValue().replace(/,/gi,'');    //净值规模
	      var issueSize = nui.get("issueSize").getValue().replace(/,/gi,'');            //发行规模 
	      
	      //当发行规模与投标金额不为空时计算该笔债券投资占发行规模比例
	      //公式为投标金额/发行规模
	      if(issueSize != "" && investcount != ""){
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
          
   </script>	
   <script src="<%=request.getContextPath() %>/process/util/process.js" type="text/javascript"></script>
   <script type="text/javascript">
     inintProcess();
   </script>
</body>
</html>