<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@include file="/common/js/commscripts.jsp" %>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<html>
<!-- 
  - Author(s): 陈鹏
  - Date: 2016-08-18 16:32:02 
  - Description:
-->
<head>
	<title><b:write property="workitem/workItemName" /></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
    
	
	
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
    <%
	   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
	   //业务ID
	   String bizId =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"bizId");
	   //流程ID
	   String processinstid =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"processInstID");
	   //工作项ID
	   String workItemID =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workItemID");
	   
	   //获取产品代码
	   DataObject obj = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"firstGradeBond");
	   String vcProductCode = obj.getString("vcProductCode");
	   
	   //获取工作项信息
	   DataObject workitem = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workitem");
	   String activityDefID = workitem.getString("activityDefID");
	   
 	%>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;margin: 0px;">
<div id="dataform1" style="height: 100%;">
	<div id="tabs" class="nui-tabs" height="100%" onactivechanged="activechangedFun">
		<div title="基本信息">
			<input class="nui-hidden" id="processinstid" name="processinstid" value="<%=processinstid %>"/>
		    <input class="nui-hidden" id="workItemID" name="workItemID" value="<%=workItemID %>"/>
		    <input class="nui-hidden" id="workItemName" value="<b:write property="workitem/workItemName" />">
		    <!-- 投资编号 -->
		    <input class="nui-hidden" id="lInvestNo" name="firstGradeBond.lInvestNo" value="<b:write property="firstGradeBond/lInvestNo" />"/>
		    <input class="nui-hidden" id="lApplyInstId" name="firstGradeBond.lApplyInstId" value="<b:write property="firstGradeBond/lApplyInstId" />"/>
		    <!-- 流程业务主表ID -->
		    <input class="nui-hidden" id="lBizId" name="firstGradeBond.lBizId" value="<b:write property="firstGradeBond/lBizId" />"/>
		    <!-- 流程类型 -->
		    <input class="nui-hidden" id="vcBusinessType" name="firstGradeBond.vcBusinessType" value="<b:write property="firstGradeBond/vcBusinessType" />"/>
		    <!-- 产品编码 -->
		    <input class="nui-hidden" id="vcProductCode" name="firstGradeBond.vcProductCode" value="<b:write property="firstGradeBond/vcProductCode" />"/>
		    <!-- 组合编码 -->
		    <input class="nui-hidden" id="lCombiId" name="firstGradeBond.lCombiId" value="<b:write property="firstGradeBond/lCombiId" />"/>
		    <input class="nui-hidden" id="vcCombiNo" name="firstGradeBond.vcCombiNo" value="<b:write property="firstGradeBond/vcCombiNo" />"/>
		    <!-- 资产单元序号 -->
		    <input class="nui-hidden" id="lAssetId" name="firstGradeBond.lAssetId" value="<b:write property="firstGradeBond/lAssetId" />"/>
		    <!-- 资产单元编码 -->
		    <input class="nui-hidden" id="vcAssetNo" name="firstGradeBond.vcAssetNo" value="<b:write property="firstGradeBond/vcAssetNo" />"/>
		    <!-- 资产单元名称 -->
		    <input class="nui-hidden" id="vcAssetName" name="firstGradeBond.vcAssetName" value="<b:write property="firstGradeBond/vcAssetName" />"/>
		    <input class="nui-hidden" id="vcAssetName" name="firstGradeBond.dBidLimitTime" value="<b:write property="firstGradeBond/dBidLimitTime" />"/>
		    <!-- 新债投资编号 -->
		    <input class="nui-hidden" id="lStockInvestNo" name="firstGradeBond.lStockInvestNo" value="<b:write property="firstGradeBond/lStockInvestNo" />"/>
		    <input class="nui-hidden" id="lAttchCount" name="firstGradeBond.lAttchCount" value="<b:write property="firstGradeBond/lAttchCount" />"/>
		    <input class="nui-hidden" id="vcStockType" name="firstGradeBond.vcStockType" value="<b:write property="firstGradeBond/vcStockType" />"/>
			<input class="nui-hidden" id="vcBusinessObject" name="firstGradeBond.vcBusinessObject" value="<b:write property="firstGradeBond/vcBusinessObject" />"/>
		    <input class="nui-hidden"  name="firstGradeBond.cMarketNo" value="<b:write property="firstGradeBond/cMarketNo" />" />
		    <!-- Fix指令/建议编号 -->
		    <input class="nui-hidden" id="vcClordId" name="firstGradeBond.vcClordId" value="<b:write property="firstGradeBond/vcClordId" />"/>
		    <input class="nui-hidden" id="vcOrigordId" name="firstGradeBond.vcOrigordId" value="<b:write property="firstGradeBond/vcOrigordId" />"/>
		    
		    <!-- 指令/建议状态 -->
		    <input class="nui-hidden" id="cStatus" name="firstGradeBond.cStatus" value="<b:write property="firstGradeBond/cStatus" />"/>
		    <input class="nui-hidden" id="lValidStatus" name="firstGradeBond.lValidStatus" value="<b:write property="firstGradeBond/lValidStatus" />"/>
		    <!-- Fix发送状态 -->
		    <input class="nui-hidden" id="lFixValidStatus" name="firstGradeBond.lFixValidStatus" value="<b:write property="firstGradeBond/lFixValidStatus" />"/>
		    
		    <!-- 当中标回退到中标确认环节时隐藏提交之前输入的缴款信息 -->
		    <l:in property="workitem/activityDefID" targetValue="ATS_FM_CZ_ZBQR">    
				<input class="nui-hidden" name="firstGradeBond.vcTransactionType" value="<b:write property="firstGradeBond/vcTransactionType" />"   />
				<input class="nui-hidden" name="firstGradeBond.vcBeneficiary" value="<b:write property="firstGradeBond/vcBeneficiary" />"/>
	            <input class="nui-hidden" name="firstGradeBond.vcCollectionAccount" value="<b:write property="firstGradeBond/vcCollectionAccount" />" />
	            <input class="nui-hidden" name="firstGradeBond.vcBankLine" value="<b:write property="firstGradeBond/vcBankLine" />" />
	            <input class="nui-hidden" name="firstGradeBond.vcPayLine" value="<b:write property="firstGradeBond/vcPayLine" />" />
	            <input class="nui-hidden" name="firstGradeBond.vcReceivableRemark" value="<b:write property="firstGradeBond/vcReceivableRemark" />" />
	        </l:in>
		    
		    <table style="width:100%;table-layout:fixed;" class="nui-form-table"> 
                <tr>
                    <td class="form_label td1" width="17%" align="right">
                        业务日期:    
                    </td>
                    <td colspan="1" width="33%">
                        <input class="nui-datepicker" name="firstGradeBond.dApplicationTime" format="yyyy-MM-dd" width="170" value="<b:write property="firstGradeBond/dApplicationTime" />" readonly="readonly"/>
                    </td>
                    <td class="form_label td1" align="right" width="17%">
                        主承机构:
                    </td>
                    <td colspan="1" class="td2" width="33%">
                        <input class="nui-textbox" name="firstGradeBond.vcMainUnderwriter" width="170" value="<b:write property="firstGradeBond/vcMainUnderwriter" />" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                  <td class="form_label td1" align="right">
                        产品名称:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" id="vcProductName" width="170" name="firstGradeBond.vcProductName" value="<b:write property="firstGradeBond/vcProductName" />" readonly="readonly"/>
                    </td>
                    <td class="form_label td1" align="right">
	                        组合名称:
	                  </td>
	                  <td colspan="1" class="td2">
	                      <input class="nui-textbox"  width="170" id="vcCombiName" name="firstGradeBond.vcCombiName" value="<b:write property="firstGradeBond/vcCombiName" />" readonly="readonly"/>
	                  </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        债券代码:
                    </td>
                    <td colspan="1" >
                        <%--<input class="nui-textbox" name="firstGradeBond.vcStockCode"/>--%>
                        <input  id="vcStockCode" width="170" class="nui-textbox"name="firstGradeBond.vcStockCode" value="<b:write property="firstGradeBond/vcStockCode" />" readonly="readonly"/>
                    </td>
                    <td class="form_label td1" align="right">
                        债券名称:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" id="vcStockName" width="170" name="firstGradeBond.vcStockName" value="<b:write property="firstGradeBond/vcStockName" />" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                    <%-- <td class="form_label td1" align="right">
                        交易市场:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" width="170" name="firstGradeBond.vcMarketName" value="<b:write property="firstGradeBond/vcMarketName" />" readonly="readonly"/>
                        <input class="nui-hidden"  name="firstGradeBond.cMarketNo" value="<b:write property="firstGradeBond/cMarketNo" />" />
                    </td> --%>
                    <td class="form_label td1" align="right">
                        债券类别:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" width="170" id="vcStocktypeName" name="firstGradeBond.vcStocktypeName" 
                        value="<b:write property="firstGradeBond/vcStocktypeName" />" readonly="readonly"/>
                    </td>
                    <td class="form_label td1" align="right">
		登记托管机构:
			  		</td>
			  		<td colspan="1">
			  			<!-- 登记托管机构 -->
			  			<input width="170"class="nui-dictcombobox" id="vcPaymentPlace" name="firstGradeBond.vcPaymentPlace" value="<b:write property="firstGradeBond/vcPaymentPlace" />" dictTypeId="CF_JY_DJTGCS" readonly="readonly" />
			  		</td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        投标金额(万元):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="firstGradeBond.enInvestBalance" id="vcInvestBalance" width="170" value="<b:write property="firstGradeBond/enInvestBalance" />" readonly="readonly"/>
                    </td>
                    <td class="form_label td1" align="right">
                        投标利率(%):
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" name="firstGradeBond.enInterestRate" width="170" value="<b:write property="firstGradeBond/enInterestRate" />" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label td1" align="right">
                        发行主体:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-textbox" width="170" name="firstGradeBond.vcIssuerNameFull" value="<b:write property="firstGradeBond/vcIssuerNameFull" />" readonly="readonly"/>
                    </td>
                    <td class="form_label td1" align="right">
                        主体类型:
                    </td>
                    <td colspan="1" class="td2">
                        <input class="nui-dictcombobox" dictTypeId="ATS_FM_ISSUE_PROPERTY" width="170" name="firstGradeBond.vcIssueProperty" value="<b:write property="firstGradeBond/vcIssueProperty" />" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label td1" align="right">
                        主体评级:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="issuerRating" width="170" id="cIssueAppraise" 
                        name="firstGradeBond.cIssueAppraise" value="<b:write property="firstGradeBond/cIssueAppraise" />" readonly="readonly"/>
                    </td>
                    <td class="form_label td1" align="right">
                        债券评级:
                    </td>
                    <td colspan="1" class="td2"> 
                        <input class="nui-dictcombobox" dictTypeId="creditRating" id="cBondAppraise" 
                        width="170" name="firstGradeBond.cBondAppraise" value="<b:write property="firstGradeBond/cBondAppraise" />" readonly="readonly"/>
                    </td>
                    
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        评级机构:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="outRatingOrgan" width="170" id="vcBondAppraiseOrgan" 
                        name="firstGradeBond.vcBondAppraiseOrgan" value="<b:write property="firstGradeBond/vcBondAppraiseOrgan" />"  readonly="readonly"/>
                    </td>
                    <td class="form_label td1" align="right">
                         发行规模(亿):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="firstGradeBond.enIssueBalance" width="170" value="<b:write property="firstGradeBond/enIssueBalance" />" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        发行期限(年):
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="firstGradeBond.enExistLimite" width="170" value="<b:write property="firstGradeBond/enExistLimite" />" readonly="readonly"/>
                    </td>
                    <td class="form_label td1" align="right">
                        首次付息日:
                    </td>
                    <td colspan="3" class="td2">
						<input class="nui-datepicker" name="firstGradeBond.dInitInterestPaymentDate" id="dInitInterestPaymentDate"
						value="<b:write property="firstGradeBond/dInitInterestPaymentDate" />" style="width: 170px;"  readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label td1" align="right">
                        产品净值规模(万元):
                    </td>
                    <td colspan="1" class="td2">
						<input class="nui-textbox" name="firstGradeBond.enNetScale" id="enNetScale" style="width: 170px;" readonly="readonly"
						value="<b:write property="firstGradeBond/enNetScale" />" />
                    </td>
                    <td class="form_label td1" align="right">
                        交易对手:
                    </td>
                    <td colspan="1" class="td2">
						<input class="nui-textbox" name="firstGradeBond.vcBusinessObject" id="vcBusinessObject" style="width: 170px;" readonly="readonly"
						value="<b:write property="firstGradeBond/vcBusinessObject" />" />
                    </td> 
                </tr>
                <tr>
                	<td class="form_label td1" align="right">
                        是否具有回售权:
                    </td>
                    <td colspan="1" class="radio-border-top-none">
                        <input id="resaleRight" class="nui-dictradiogroup" name="firstGradeBond.cIsHaveSaleback" 
                       dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="firstGradeBond/cIsHaveSaleback" />" readonly/>
                       &nbsp;<label id="resaleYear" style="float: left;display: none;">行权年：
                       <input class="nui-textbox" name="firstGradeBond.enResaleYear" id="resaleYear" width="45"
                        value="<b:write property="firstGradeBond/enResaleYear" />" readonly/></label>
                    </td>
                    <td class="form_label td1" align="right"> 
                        是否具有赎回权:
                    </td>
                    <td colspan="1" class="radio-border-top-none td2">
                        <input id="redemptionRight" class="nui-dictradiogroup" name="firstGradeBond.cIsHaveBuyback" 
                         dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="firstGradeBond/cIsHaveBuyback" />" readonly/>
                          
                           &nbsp;<label id="redemptionYear" style="float: left;display: none;">行权年：  
                          <input class="nui-textbox" name="firstGradeBond.enRedemptionYear" id="redemptionYear"
       						width="45" value="<b:write property="firstGradeBond/enRedemptionYear" />" readonly="readonly"/></label>
                    </td>
                </tr>
                <tr>
                	<td colspan="1" class="form_label td1" align="right">
		                       下一行权日:
                    </td>
                    <td colspan="1">
                    	<input style="width:170px;" class="nui-datepicker"  id="lNextExerciseDate" name="stockissueinfo.lNextExerciseDate" readonly="readonly"
                    	value="<b:write property="firstGradeBond/lNextExerciseDate" />"/>
                    </td>
					<td colspan="1" class="form_label td1" align="right">
						特殊条款:	
					</td>
					<td colspan="1">
				    <input width="170" id="stockissueinfo.vcSpecialText"  class="nui-dictcombobox" name="stockissueinfo.vcSpecialText"  valueField="dictID" textField="dictName" dictTypeId="specialText"  
						emptyText="请选择" nullItemText="请选择" multiSelect="true" showClose="true" valueFromSelect="true"  oncloseclick="onCloseClickValueEmpty" 
						value="<b:write property="firstGradeBond/vcSpecialText" />" readonly/>
					</td>
				</tr>
			  	<tr>
                    <td class="form_label td1" align="right">
                      	 投标区间:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="firstGradeBond.vcTenderInterval" width="170" value="<b:write property="firstGradeBond/vcTenderInterval" />" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
	                  <td class="form_label td1" align="right">债券占比：</td>
	                  <td colspan="3" style="padding: 0px;margin: 0xp;" class="td2">
	                   <p class="p"><label style="margin-left: 5px;font-weight: inherit;">该笔债券投资占发行规模比例(%): </label>
	                   				<b:write property="firstGradeBond/enInvestScaleRatio" /></p>
	                   <p class="p"><label style="margin-left: 5px;font-weight: inherit;">同一发行主体占产品净值规模比例(%): </label>
	                   				<b:write property="firstGradeBond/enIssuerNetRatio" /></p>
	                   <p class="p"><label style="margin-left: 5px;font-weight: inherit;">该笔债券投资占产品净值规模比例(%): </label>
	                   				<b:write property="firstGradeBond/enInvestNetRatio" /></p>
	                   <p><label style="margin-left: 5px;font-weight: inherit;">弱流动性资产规模占产品净值规模比例(%): </label>
	                   				<b:write property="firstGradeBond/enWeakNetRatio" /></p>
	                  </td>
	                </tr>
                <tr>
                    <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
                        备注:
                    </td>
                    <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
                        <input class="nui-textarea" width="515" height="40" name="firstGradeBond.vcRemarks"
                        value="<b:write property="firstGradeBond/vcRemarks" />" readonly="readonly"/>
                    </td>
                </tr>
            </table>
		</div>
		<div title="审批内容">
		   <%@include file="/fm/instr/firstGradeDebt/processControl.jsp" %>
		</div>
		<div title="流程信息" url="com.cjhxfund.ats.fm.comm.processGraph.flow?processInstID=<%=processinstid %>&workItemID=<%=workItemID %>&bizId=<%=bizId %>"></div>
		<div title="产品投资范围" url="<%=request.getContextPath() %>/fm/comm/ProductInvestmentRange.jsp?vcProductCode=<%=vcProductCode %>"></div>
		<l:in property="workitem/activityDefID" targetValue="ATS_FM_CZ,ATS_FM_CZ_CZZZCXS,ATS_FM_CZ_FSZCXS">
			<div title="传真发送列表" url="<%=request.getContextPath() %>/fm/instr/firstGradeDebt/eastFaxList.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>" refreshOnClick="true"></div>
		</l:in>
	</div>
</div>
	<script type="text/javascript">
		nui.parse();
    	//获取应用名称
    	var contextPath = '<%=request.getContextPath() %>';
    	var activityDefID = '<%=activityDefID %>';   //获取活动定义ID
    	var file_grid = nui.get("file_grid");   //附件列表对象
    	var form = new nui.Form("#dataform1");//将普通form转为nui的form
    	

    
    //tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	function activechangedFun(){
		//标签切换时同时刷新“今日待处理”，模块数据
		//reloadWaitConfirmFun();
	
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tabs").getActiveTab().title;
		
		if(activeTabTitle.indexOf("审批内容")!=-1){
			//附件列表
		     var file_grid = nui.get("file_grid");
		     var file_Form = new nui.Form("#file_Form").getData(false,false);
		     file_grid.load(file_Form);
		}
	}	

     function processSubmit(){
		nui.confirm("确认是否提交流程？","系统提示",function(action){
			if(action == "ok"){
	    		var form = new nui.Form("#dataform1");
	    		var operateType = nui.get("operateType").getValue();

	    	  	//设置路径
			  	urlStr = contextPath + "/com.cjhxfund.ats.fm.instr.FirstGradeBond.firstGradeBondHandle.biz.ext";
			  	//获取iframe对象
				var child = document.getElementById("prodIfm").contentWindow;
				
				//流程js验证
				//if(checkForm()==false) return;
								
				//组装参数		
				data = {
					workItemID:nui.get("workItemID").getValue(),
					pmprcaprvinfo:form.getData(false,true).pmprcaprvinfo,
					bpsParam:form.getData(false,true).bpsParam,
					applyInst:form.getData(false,true).firstGradeBond
				};
									
			  	//操作为同意时调用
			  	if(operateType == 1){
			  		//校验必须文本框是否输入
			  		form.validate();
		        	if(form.isValid()==false){
		           		nui.alert("业务信息必填项不能为空，请输入。","系统提示");
		           		return;
		        	}	
			  		var json = nui.encode({bizId:'<%=bizId %>',processinstid:nui.get("processinstid").getValue(),});
				    $.ajax({
				       url:"com.cjhxfund.ats.fm.comm.atsEastFaxBiz.checkFaxStatus.biz.ext",
				       data:json,
				       type:'POST',
				       contentType:'text/json',
				       cache:false,
				       success:function(text){
			    			var returnJson = nui.decode(text);
				            if(returnJson.count == 0){
								saveData(data,urlStr);
				            }else{
				            	nui.confirm("传真发送失败,是否继续?","系统提示",function(action){
				            		if(action == "ok"){
				            			saveData(data,urlStr);
				            		}
				            	});
				            }
				          }
				       });
			  	}else if(operateType == 2){
	        	  	 var backActivity = nui.get("backActivity").getValue();
	        	  	 if(backActivity == ""){
	        	  	   nui.alert("当操作为退回时,必须选择退办节点。","系统提示");
	        	  	   return;
	        	  	 }
	        	  	 saveData(data,urlStr);
	     	 	}else{
	     	 		 saveData(data,urlStr);
	     	 	}  
    		}
    	});
    }
    
    //校验传真号格式
    function checkFax(e){
    	var checkFax = /^(\d{3,4}-)?\d{7,8}$/; 
		if(!checkFax.test(e.value)){
			nui.alert("传真格式为:XXX-12345678或XXXX-1234567或XXXX-12345678","系统提示");
			return false;
		}
		return true;	
    }
    
    //默认加载审核信息
    var operateText = nui.get("operateType").getSelected().text;
	nui.get("comments").setValue(operateText);
     
	 //调用附件查询方法
     loademployeeGrid();	
	
    </script>
    <script	src="<%= request.getContextPath() %>/fm/instr/processUtil/process.js" type="text/javascript"></script>
	<script type="text/javascript">
		//获取回退的实例对象
		loadActivities();
		
		function inIt(){
			
			//获取参数
      		var resaleRight = "<b:write property="firstGradeBond/cIsHaveSaleback" />";          //是否具有回售权
	  		var redemptionRight = "<b:write property="firstGradeBond/cIsHaveBuyback" />";  //是否具有赎回权

			if(resaleRight == "1"){
				document.getElementById("resaleYear").style.display = "block";
			}
			if(redemptionRight == "1"){
				
				document.getElementById("redemptionYear").style.display = "block";
			}
		}
		//初始化调用
		inIt();
	</script>
</body>
</html>