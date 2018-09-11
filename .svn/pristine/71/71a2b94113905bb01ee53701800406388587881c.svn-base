<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@include file="/common/js/commscripts.jsp" %>

<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<html>
<!-- 
  - Author(s): 谢海光
  - Date: 2017-12-18 16:32:02 
  - Description:
-->
<head>
	<title><b:write property="workitem/workItemName" /></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
    <script src="<%= request.getContextPath() %>/fm/instr/processUtil/instr.js" type="text/javascript"></script>
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
   
	    #footer {z-index:999; position:fixed; bottom:0; left:0;  _position:absolute; height:30px;
		 _top: expression_r(documentElement.scrollTop + documentElement.clientHeight-this.offsetHeight-300); overflow:visible;
		}
		#dataform2 tr{
			border-top:0px;
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
	   String lNextExerciseDate = obj.getString("lNextExerciseDate");
	   
	   //获取工作项信息
	   DataObject workitem = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workitem");
	   String activityDefID = workitem.getString("activityDefID");
	   
	   //获取当前时间并转换为字符串类型
	   Date dateTime = new Date();
	   SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	   String myDate = format.format(dateTime);
	   //定义需要用印的节点
	   String str="";
	   int tabsIndex=1;//默认选择基本信息界面
 	%>
 	<script type="text/javascript" src="<%=request.getContextPath() %>/common/js/commonjs.js"></script>
 	<script src="<%= request.getContextPath() %>/fm/instr/processUtil/instr.js" type="text/javascript"></script>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;margin: 0px;">
<div id="dataform1" style="height: 100%;">
	<div id="tabs" class="nui-tabs" height="100%" onactivechanged="activechangedFun"  activeIndex="<%=tabsIndex %>">
		<div title="基本信息">
			<!-- 左右布局控件 -->
			<div id="layout1" class="nui-layout" style="width:100%;height:100%;overflow-x:hidden;" >
				<!-- 主体内容 -->
				<div title="center" region="center" width="80%">
				    <input class="nui-hidden" id="processinstid" name="processinstid" value="<%=processinstid %>"/>
				    <input class="nui-hidden" id="workItemID" name="workItemID" value="<%=workItemID %>"/>
				    <input class="nui-hidden" id="workItemName" value="<b:write property="workitem/workItemName" />">
				    <input class="nui-hidden" name="firstGradeBond.vcArchiveProcessId" id="vcArchiveProcessId" value="<b:write property="firstGradeBond/vcArchiveProcessId" />"/>
				    <!-- 流程业务主表ID -->
				    <input class="nui-hidden" id="lBizId" name="firstGradeBond.lBizId" value="<b:write property="firstGradeBond/lBizId" />"/>
				    <!-- 产品编码 -->
				    <input class="nui-hidden" id="vcProductCode" name="firstGradeBond.vcProductCode" value="<b:write property="firstGradeBond/vcProductCode" />"/>
				    <input class="nui-hidden" id="dBidLimitTime" name="firstGradeBond.dBidLimitTime" value="<b:write property="firstGradeBond/dBidLimitTime" />"/>
				    <table style="width:100%;table-layout:fixed;" class="nui-form-table"> 
		                <tr>
		                    <td class="form_label" width="25%" align="right">
		                        业务日期:    
		                    </td>
		                    <td colspan="1" width="25%">
		                        <input class="nui-datepicker" width="70%" id="dApplicationTime" name="firstGradeBond.dApplicationTime" format="yyyy-MM-dd" width="170" value="<b:write property="firstGradeBond/dApplicationTime" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label" width="25%" align="right">
								投标截止日期:
						  	</td>
						  	<td colspan="1" width="270px">
							     <!-- 日期和时间分开显示 -->
							     <input style="width: 98px;"  id="dApplicationDate"   class="mini-datepicker" showTodayButton="true" format="yyyy-MM-dd"  readonly="readonly"/>
						         <input style="width: 40px;" url="<%=request.getContextPath() %>/fm/instr/processUtil/timeHH.txt" class="nui-dictcombobox"  id="dApplicationTimeHH" readonly="readonly"/>
							                 时
							     <input style="width: 40px;" url="<%=request.getContextPath() %>/fm/instr/processUtil/timeMM.txt" class="nui-dictcombobox"  id="dApplicationTimeMM" readonly="readonly"/>
							                 分
							     <!-- 提醒的时间 -->
							     <input class="nui-hidden" type="hidden"  id="bidRemind" />
						  	 </td>
		                </tr>
		                <tr>
		                  <td class="form_label" align="right">
		                        产品名称:
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" id="vcProductName" width="70%" name="firstGradeBond.vcProductName" value="<b:write property="firstGradeBond/vcProductName" />" readonly="readonly"/>
		                    </td>
		                   <td class="form_label" align="right">
			                        组合名称:
		                  </td>
		                  <td colspan="1">
		                      <input class="nui-textbox"  width="70%" id="vcCombiName" name="firstGradeBond.vcCombiName" value="<b:write property="firstGradeBond/vcCombiName" />" readonly="readonly"/>
		                  </td>
		                </tr>
		                <tr>
		                    <td class="form_label" align="right">
		                        债券代码:
		                    </td>
		                    <td colspan="1">
		                        <%--<input class="nui-textbox" name="firstGradeBond.vcStockCode"/>--%>
		                        <input  id="vcStockCode" width="70%" class="nui-textbox"name="firstGradeBond.vcStockCode" value="<b:write property="firstGradeBond/vcStockCode" />" readonly="readonly"/>
		                    </td>
		                	<td class="form_label" align="right">
		                        债券简称:
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" id="vcStockName" width="70%" name="firstGradeBond.vcStockName" value="<b:write property="firstGradeBond/vcStockName" />" readonly="readonly"/>
		                    </td>
		                    
		                </tr>
		                <tr>
		                	<td class="form_label" align="right">
				登记托管机构:
					  		</td>
					  		<td colspan="1">
					  			<!-- 登记托管机构 -->
					  			<input width="70%" class="nui-dictcombobox" id="vcPaymentPlace" name="firstGradeBond.vcPaymentPlace" value="<b:write property="firstGradeBond/vcPaymentPlace" />" dictTypeId="CF_JY_DJTGCS" readonly="readonly" />
					  		</td>
		                    <td class="form_label" align="right">
		                        债券类别:
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" width="70%" id="vcStocktypeName" name="firstGradeBond.vcStocktypeName" 
		                        value="<b:write property="firstGradeBond/vcStocktypeName" />" readonly="readonly"/>
		                     	<input class="nui-hidden" id="vcStockType" name="firstGradeBond.vcStockType" value="<b:write property="firstGradeBond/vcStockType" />" />   
		                    </td>
		                </tr>
		                <tr>
		                	<td class="form_label" align="right">
		                        发行主体:
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" id="vcIssuerNameFull" width="70%" name="firstGradeBond.vcIssuerNameFull" value="<b:write property="firstGradeBond/vcIssuerNameFull" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label" align="right">
		                        债券全称:
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" id="vcStockNameFull" width="70%" name="stockissueinfo.vcStockNameFull" value="<b:write property="firstGradeBond/vcStockNameFull" />" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                <td class="form_label" align="right">
					发行日期:
					   </td>
					   <td colspan="1">
					    <input width="70%"  id="lIssueBeginDate" name="stockissueinfo.lIssueBeginDate"  class="mini-datepicker" showTodayButton="true"  readonly="readonly"  value="<b:write property="firstGradeBond/lIssueBeginDate" />"/>
					   </td>
		                   
		                 	<td class="form_label" align="right">
		                         发行规模(亿):
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" name="firstGradeBond.enIssueBalance" id="enIssueBalance" width="70%" value="<b:write property="firstGradeBond/enIssueBalance" />" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                	<td class="form_label" align="right">
		                		债券详情:
		                    </td>
		                    <td colspan="1">
		                    	<a  class='nui-button' plain='false' onclick="queryStockDetail()">
									查看债券详情
								</a>
		                    </td>
		                    <td class="form_label" align="right">
		                    </td>
		                    <td colspan="1">
		                    </td>
		                </tr>
		                </table>
		                
		                 <div style="height: 5px"></div>
		                 
	    <div id="panel1" class="mini-panel" title="其他信息" iconCls="icon-edit" style="width:100%;padding: 0px;" 
    		showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="false" collapseOnTitleClick="true">
		                
						<table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">
    					<tr>
		                 <td class="form_label" align="right" >
		                        主承销商:
		                    </td>
		                    <td colspan="3">
		                        <input width="90%" class="nui-textbox" id="vcMainUnderwriter" name="firstGradeBond.vcMainUnderwriter"  value="<b:write property="firstGradeBond/vcMainUnderwriter" />"  readonly="readonly"/>
		                    </td>
		                </tr>
		                 <tr>
		                 <td class="form_label" align="right" width="25%">
		                        副主承销商:
		                    </td>
		                    <td colspan="3">
		                        <input width="90%" class="nui-textbox" id="vcDeputyUnderwriter" name="firstGradeBond.vcDeputyUnderwriter"  value="<b:write property="firstGradeBond/vcDeputyUnderwriter" />"  readonly="readonly"/>
		                    </td>
		                </tr>
		                 <tr>
		                 <td class="form_label" align="right" width="25%">
		                        承销团:
		                    </td>
		                    <td colspan="3">
		                        <input width="90%" class="nui-textbox" id="vcGroupUnderwriter" name="firstGradeBond.vcGroupUnderwriter"  value="<b:write property="firstGradeBond/vcGroupUnderwriter" />"  readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                 <td class="form_label" align="right" width="25%">
		                        交易对手:
		                    </td>
		                    <td colspan="1" width="25%">
								<input class="nui-hidden" type="hidden" id="hlRivalId" name="firstGradeBond.lRivalId"  value="<b:write property="firstGradeBond/lRivalId" />"/>
								<input width="68%" class="nui-textbox" id="vcBusinessObject" name="firstGradeBond.vcBusinessObject"  value="<b:write property="firstGradeBond/vcBusinessObject" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label" align="right" width="25%">
		                        主体类型:
		                    </td>
		                    <td colspan="1" width="25%">
		                        <input class="nui-dictcombobox" id="vcIssueProperty" dictTypeId="ATS_FM_ISSUE_PROPERTY" width="68%" name="firstGradeBond.vcIssueProperty" value="<b:write property="firstGradeBond/vcIssueProperty" />" readonly="readonly"/>
		                    </td>
		                 </tr>   
		                <tr>
		                <tr>
		                	<td class="form_label" align="right">
		                        主体评级:
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-dictcombobox" dictTypeId="issuerRating" width="68%" id="cIssueAppraise" 
		                        name="firstGradeBond.cIssueAppraise" value="<b:write property="firstGradeBond/cIssueAppraise" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label" align="right">
		                        债券评级:
		                    </td>
		                    <td colspan="1"> 
		                        <input class="nui-dictcombobox" dictTypeId="creditRating" id="cBondAppraise" 
		                        width="68%" name="firstGradeBond.cBondAppraise" value="<b:write property="firstGradeBond/cBondAppraise" />" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                	<td class="form_label" align="right">
		                        评级机构:
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-dictcombobox" dictTypeId="outRatingOrgan" width="68%" id="vcBondAppraiseOrgan" 
		                        name="firstGradeBond.vcBondAppraiseOrgan" value="<b:write property="firstGradeBond/vcBondAppraiseOrgan" />"  readonly="readonly"/>
		                    </td>
		                    <td colspan="1" class="form_label" align="right">
					特殊条款:	
							</td>
							<td colspan="1">
							<input width="68%" id="vcSpecialText"  class="nui-dictcombobox" name="stockissueinfo.vcSpecialText"  valueField="dictID" textField="dictName" dictTypeId="specialText"  
								emptyText="请选择" nullItemText="请选择" multiSelect="true" showClose="true" valueFromSelect="true"  oncloseclick="onCloseClickValueEmpty" 
								value="<b:write property="firstGradeBond/vcSpecialText" />" readonly/>
							</td>
		                </tr>
		                <tr>
		                    <td class="form_label" align="right">
		                       发行期限(年):
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" id="enExistLimite" name="firstGradeBond.enExistLimite" width="68%" value="<b:write property="firstGradeBond/enExistLimite" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label" align="right">
						     	特殊期限:
						  </td>
						  <td colspan="1">
						      <input class="nui-textbox" id="vcSpecialLimite" name="firstGradeBond.vcSpecialLimite" width="170" value="<b:write property="firstGradeBond/vcSpecialLimite" />" readonly="readonly"/>
						  </td>
		                </tr>
		                <tr>
		                	<td class="form_label" align="right">
		                       下一行权日:
		                    </td>
		                    <td colspan="1">
		                    	<input width="68%" class="nui-datepicker"  id="lNextExerciseDate" name="stockissueinfo.lNextExerciseDate" readonly="readonly"
		                    	value="<b:write property="firstGradeBond/lNextExerciseDate" />"/>
		                    </td>
							<td class="form_label" align="right">
	                       下一利率跳升点数:
							</td>
							<td colspan="1">
								<input class="nui-textbox" name="stockissueinfo.lNInterestRateJumpPoints" id="lNInterestRateJumpPoints" width="68%"
								value="<b:write property="firstGradeBond/lNInterestRateJumpPoints" />" readonly="readonly"/>
							</td> 
		                </tr>
		                <tr>
		                	<td class="form_label" align="right">
		                        首次付息日:
		                    </td>
		                    <td colspan="1">
								<input class="nui-datepicker" name="firstGradeBond.dInitInterestPaymentDate" id="dInitInterestPaymentDate"
								value="<b:write property="firstGradeBond/dInitInterestPaymentDate" />" width="68%"  readonly="readonly"/>
		                    </td>
							
							<td class="form_label" align="right">
								公司净资产（元）:
							</td>
							<td colspan="1">
								<input class="nui-textbox" name="stockissueinfo.enIssuerNetValue" id="enIssuerNetValue" width="68%"
								value="<b:write property="firstGradeBond/enIssuerNetValue" />" readonly="readonly"/>
							</td>
		                </tr>
		                <tr>
	                    <td class="form_label" align="right">
	                     城投行政级别:
	                    </td>
	                    <td colspan="1">
							<input width="68%"  id="vcCityLevel" class="nui-dictcombobox" name="stockissueinfo.vcCityLevel"  readonly="readonly"
					     showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="cityLevel"  value="<b:write property="firstGradeBond/vcCityLevel" />"/>
	                    </td>
	                      
	                    <td class="form_label" align="right">
	                     所属行业(证监会二级):
	                    </td>
	                    <td colspan="1">
							<input class="nui-hidden" name="stockissueinfo.vcIssueAppraiseCsrc" id="vcIssueAppraiseCsrc" style="width: 170px;"
							value="<b:write property="firstGradeBond/vcIssueAppraiseCsrc" />" readonly="readonly"/>
							<input class="nui-textbox" name="stockissueinfo.vcIssueAppraiseCsrcName" id="vcIssueAppraiseCsrcName" width="68%"
							value="<b:write property="firstGradeBond/vcIssueAppraiseCsrcName" />" readonly="readonly"/>
	                    </td>
	                </tr>
		                <tr id="morStockNameAndCode">
	                    <td class="form_label" align="right">
	                       股票名称:
	                    </td>
	                    <td colspan="1">
							<input class="nui-textbox" name="stockissueinfo.vcMortStockName" id="vcMortStockName" width="68%"
							value="<b:write property="firstGradeBond/vcMortStockName" />" readonly="readonly"/>
	                    </td>
	                    <td class="form_label" align="right">
	                        股票代码:
	                    </td>
	                    <td colspan="1">
							<input class="nui-textbox" name="stockissueinfo.vcMortStockCode" id="vcMortStockCode" width="68%" readonly="readonly"
							value="<b:write property="firstGradeBond/vcMortStockCode" />" />
	                    </td>  
	                </tr>
	                
	                 <tr id="morStockAmount">
	                    <td class="form_label" align="right">
	                        股票抵押数量(万股):
	                    </td>
	                    <td colspan="1">
							<input class="nui-textbox" name="stockissueinfo.vcMortStockAmount" id="vcMortStockAmount" width="68%"
							value="<b:write property="firstGradeBond/vcMortStockAmount" />" readonly="readonly"/>
	                    </td>
	                    <td class="form_label" align="right">
	                    	
	                    </td>
	                    <td colspan="1">

	                    </td>  
	                </tr>
	                <tr>
	                <td class="form_label" align="right">
		                                   投标区间:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" id="vcTenderInterval" name="firstGradeBond.vcTenderInterval" width="170"  readonly="readonly"/>
	                    </td> 
	                    <td class="form_label" align="right">
	                    </td>
	                    <td colspan="1">
	                        
	                    </td> 
	                </tr>
	                <tr>
		                    <td class="form_label" align="right" >
		                        是否具有回售权:
		                    </td>
		                    <td colspan="1" class="radio-border-top-none">
		                        <input id="resaleRight" class="nui-dictradiogroup" name="firstGradeBond.cIsHaveSaleback" 
		                       dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="firstGradeBond/cIsHaveSaleback" />" readonly/>
		                    </td>
		                    <td class="form_label" align="right"> 
		                        是否具有赎回权:
		                    </td>
		                    <td colspan="1" class="radio-border-top-none">
		                        <input id="redemptionRight" class="nui-dictradiogroup" name="firstGradeBond.cIsHaveBuyback" 
		                         dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="firstGradeBond/cIsHaveBuyback" />" readonly/>
		                    </td>
		                </tr>  
	                <tr>		               
		                    <td class="form_label" align="right" style="border-bottom: 1px solid #D3D3D3;">
		                        备注:
		                    </td>
		                    <td colspan="3" style="border-bottom: 1px solid #D3D3D3;">
		                        <input class="nui-textarea" id="vcRemarks" width="515" height="40" name="firstGradeBond.vcRemarks"
		                        value="<b:write property="firstGradeBond/vcRemarks" />" readonly="readonly"/>
		                       
		                    </td>
		                </tr>
		            </table>
		             <table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">	
		                <tr>
		                    <td class="form_label" align="right" style="padding:5px 5px;">
				                       已投资该发行主体债券存量(万元):
				            </td>
				            <td colspan="1" style="padding:5px 5px;">
								<input class="nui-textbox"  id="fsumamount" style="width: 150px;float: left;margin-right: 10px;" 
								 value="<b:write property="firstGradeBond/enCategoryMoney" />" onvaluechanged="BondAccountedCalculation"/>
				             </td>
				             <td class="form_label" align="right" style="padding:5px 5px;">
		                        产品净值规模(万元):
		                    </td>
		                    <td colspan="1">
								<input class="nui-textbox" id="enNetScale" width="68%" value="<b:write property="firstGradeBond/enNetScale" />" onvaluechanged="BondAccountedCalculation"/>
								<input class="nui-hidden" name="firstGradeBond.enNetScale" id="enNetScale1" value="<b:write property="firstGradeBond/enNetScale" />"  />
		                    </td> 
		                </tr>
		                <tr>
			                <td class="form_label" align="right" style="padding:5px 5px;">
			                该笔债券投资占发行规模比例(%):
			                </td>
			                <td colspan="1" style="padding:5px 5px;">
								<input class="nui-textbox asLabel" id="enInvestScaleRatio" width="150px" readonly="readonly" value="<b:write property="firstGradeBond/enInvestScaleRatio" />" onvaluechanged="BondAccountedCalculation"/>
		                    </td>
		                     <td class="form_label" align="right" style="padding:5px 5px;">
			                同一发行主体占产品净值规模比例(%):
			                </td>
			                <td colspan="1" style="padding:5px 5px;">
								<input class="nui-textbox asLabel" id="enIssuerNetRatio" width="65%" readonly="readonly" value="<b:write property="firstGradeBond/enIssuerNetRatio" />" onvaluechanged="BondAccountedCalculation"/>
		                    </td>
			            </tr>
			            <tr>
			                <td class="form_label" align="right" style="padding:5px 5px;">
			                该笔债券投资占产品净值规模比例(%):
			                </td>
			                <td colspan="1" style="padding:5px 5px;">
								<input class="nui-textbox asLabel" id="enInvestNetRatio" width="150px" readonly="readonly" value="<b:write property="firstGradeBond/enInvestNetRatio" />" onvaluechanged="BondAccountedCalculation"/>
		                    </td>
		                     <td class="form_label" align="right" style="padding:5px 5px;">
			                弱流动性资产规模占产品净值规模比例(%):
			                </td>
			                <td colspan="1" style="padding:5px 5px;">
								<input class="nui-textbox asLabel" id="enWeakNetRatio" width="65%" readonly="readonly" value="<b:write property="firstGradeBond/enWeakNetRatio" />" onvaluechanged="BondAccountedCalculation"/>
		                    </td>
		                <tr>
						 </table> 
		            </div>
		            <div title="报量录入">
						<div class="nui-toolbar" style="border-bottom:0;padding:0px;margin-top: 2px;height: 27px;">
							<table style="width:100%;">
								<tr>
									<td style="width:100%;">
							          	&nbsp;&nbsp;报量信息
									</td>
									<td >
				                  		<a class="nui-button " plain="false" iconCls="icon-search" onclick="reportHistory()"  plain="false" tooltip="报量历史">
				                    		&nbsp;
				                  		</a>
				                	</td>	
							        <td>
					                  	<a class="nui-button " plain="false" iconCls="icon-reload" onclick="gridReload('instReport')"  plain="false" tooltip="刷新">
					                    	&nbsp;
					                  	</a>
					                </td>
					                <td >
										<a class="nui-button " plain="false" iconCls="icon-help" onclick="showTips()"  plain="false" tooltip="帮助">
											&nbsp;
										</a>
									</td>
								</tr>
							</table>
						</div>
						<div style="font-size:10px;color:red;">
								<div style="width:50%;float: left;padding-left: 10px;"><b>说明：</b>①报量为100万整数倍；②特殊说明请在报量说明中填写；③报价待定时为空即可</div>
								<div style="width:30%;float: right;padding-right: 10px;text-align: right;line-height: 27px;">
								报量方式：<input style="width: 130px;" id="cReportType"  url="<%= request.getContextPath() %>/fm/instr/processUtil/reportData.txt" 
								class="nui-dictcombobox"  value="<b:write property="firstGradeBond/cReportType" />" readonly="readonly"/>
								</div>
						</div>
			            <div class="nui-datagrid" id="instReport"   height="100px" showPager="false" allowSortColumn="false" allowCellSelect="true" 
							 allowCellEdit="true"  url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadReport.biz.ext?bizId=<%=bizId %>" multiSelect="true" allowCellValid="true" >
								<div property="columns">
									<div field="enReport"  headerAlign="center" allowSort="true">报量(万元)</div>
									<div field="enOffer"  headerAlign="center" allowSort="true">报价(%)</div>
									<div field="vcReportRemark"  headerAlign="center" allowSort="true">报量说明</div>
								</div>
						</div>
					</div>
				   <div class="nui-panel" title="缴款信息"  style="width:100%;height: 28px;" showToolbar="false" showFooter="true" >
				   </div>
				   <table style="width:100%;table-layout:fixed;" class="nui-form-table">
				      <tr>
				      	
			             <td class="form_label" align="right" width="17%">
			               	缴款面值(万元):
			             </td>
			             <td colspan="1" class="radio-border-top-none" width="33%" >
			                 <input class="nui-textbox" id="payFaceValue" value="<b:write property="firstGradeBond/enPayFaceValue" />" 
			                 	     style="width: 170px;"  />
			             </td>
			             <td class="form_label" align="right" width="17%">
			                           发行价格(元):
			             </td>
			             <td colspan="1" class="radio-border-top-none" width="33%" >
			                 <input class="nui-textbox" name="firstGradeBond.enBallotPrice" id="enBallotPrice"
			                    value="<b:write property="firstGradeBond/enBallotPrice" />"  style="width: 170px;" />
			             </td>
				      </tr>
				      <tr>
			             <td class="form_label" align="right" width="17%">
			                                       缴款金额(万元):
			             </td>
			             <td colspan="1" class="radio-border-top-none" width="33%" >
			                 <input class="nui-textbox"  id="paymentMoney" value="<b:write property="firstGradeBond/enPaymentMoney" />"  style="width: 170px;"/>
			    
			             </td>
			             <td class="form_label" align="right" width="17%">
			                                                缴款日期:
			             </td>
			            <td colspan="1"  width="33%">
							<input class="nui-datepicker" name="firstGradeBond.dPaymentDate" id="dPaymentDate" 
								value="<b:write property="firstGradeBond/dPaymentDate" />" style="width: 170px;" />
			             </td>
			          </tr>
			          <tr>
			             <td class="form_label" align="right">
			                             票面利率(%):
			             </td>
			            <td colspan="1" >
							<input class="nui-textbox" name="firstGradeBond.enCouponRate" id="enCouponRate" 
								value="<b:write property="firstGradeBond/enCouponRate" />"  style="width: 170px;" />
			             </td>
			             <td class="form_label" align="right">
			                        付息频率:
			             </td>
			             <td colspan="1">
			                 <input class="nui-dictcombobox" dictTypeId="ATS_CF_JY_FREQUENCY" name="firstGradeBond.vcFrequency" id="vcFrequency"
			                    value="<b:write property="firstGradeBond/vcFrequency" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"  style="width: 170px;" />
			             </td>
			          </tr>
			          <tr>
			             <td class="form_label" align="right">
			                        还本方式:
			             </td>
			            <td colspan="1"  >
							<input class="nui-dictcombobox" dictTypeId="CF_JY_MODE_REPAYMENT" name="firstGradeBond.vcModeRepayment" id="vcModeRepayment" 
								value="<b:write property="firstGradeBond/vcModeRepayment" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"  style="width: 170px;" />
			             </td>
			             <td class="form_label" align="right">
			                	计息起始日:
			             </td>
			             <td colspan="1"  >
			             		<input class="nui-datepicker" name="bpsParam.lBegincalDate" id="lBegincalDate" 
			             			value="<b:write property="firstGradeBond/lBegincalDate" />"  style="width: 170px;" />
			             </td>
			          </tr>
			          <tr>
			              <td class="form_label" align="right" style="border-bottom: 1px solid #D3D3D3;">
			                                    到期日:
			             </td>
			             <td colspan="3"  style="border-bottom: 1px solid #D3D3D3;">
			                 <input class="nui-datepicker" name="bpsParam.lEndincalDate" id="lEndincalDate"
			                    value="<b:write property="firstGradeBond/lEndincalDate" />"  style="width: 170px;"/>
			                 <input class="nui-hidden" name="bpsParam.lEndincalDate1" value="<b:write property="firstGradeBond/lEndincalDate" />"  />
			             </td>
			           </tr>
			           
				   </table>
				   
				   <div class="nui-panel" title="收款账户信息"  style="width:100%;height: 28px;margin-top: 5px;" showToolbar="false" showFooter="true" >
				       </div>
		            <table style="width:100%;table-layout:fixed;" class="nui-form-table">
		                <tr>
		                    <td class="form_label" width="25%" align="right">
		                        缴款方式:    
		                    </td>
		                    <td colspan="1" width="25%">
		                        <input class="nui-dictcombobox" id="vcTransactionType" dictTypeId="ATS_FM_PAYMENT" name="firstGradeBond.vcTransactionType" width="170" value="<b:write property="firstGradeBond/vcTransactionType" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label" width="17%" align="right">
		                        收款人户名:
		                    </td>
		                    <td colspan="1" width="25%" >
		                        <input class="nui-textbox" id="vcBeneficiary" width="170" name="firstGradeBond.vcBeneficiary" value="<b:write property="firstGradeBond/vcBeneficiary" />" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                	<td class="form_label" width="25%" align="right">
		                        收款账号:    
		                    </td>
		                    <td colspan="1" width="25%">
		                        <input class="nui-textbox" id="vcCollectionAccount" name="firstGradeBond.vcCollectionAccount" value="<b:write property="firstGradeBond/vcCollectionAccount" />" width="170" readonly="readonly"/>
		                    </td>
		                    <td class="form_label" width="17%" align="right">
		                        大额支付行号:    
		                    </td>
		                    <td  >
		                        <input class="nui-textbox" id="vcPayLine" name="firstGradeBond.vcPayLine" value="<b:write property="firstGradeBond/vcPayLine" />" width="170" readonly="readonly"/>
		                    </td>  
		                </tr>
		                <tr>
		                   <td class="form_label" width="17%" align="right" style="border-bottom: 1px solid #D3D3D3;">
		                        备注:
		                    </td>
		                    <td colspan="3"  style="border-bottom: 1px solid #D3D3D3;">
		                        <input class="nui-textarea" id="vcReceivableRemark" width="515" height="40" name="firstGradeBond.vcReceivableRemark" value="<b:write property="firstGradeBond/vcReceivableRemark" />" readonly="readonly"/>
		                    </td>
		                </tr>
		            </table>             
		       </div>
				<!-- 投资范围 -->
				<!-- 居右east，据左west -->
				<l:notIn property="workitem/activityDefID" targetValue="ATS_FM_TBYY,ATS_FM_CZ_TBZX">
				<div  title="投资范围" region="east" width="275" showCloseButton="false" showSplitIcon="true">	
		    		<iframe src="<%=request.getContextPath() %>/fm/comm/ProductInvestmentRange.jsp?vcProductCode=<%=vcProductCode %>" width="100%" height="100%" scrolling="auto" frameborder="0"></iframe>
				</div> 
				</l:notIn> 
			</div>
		</div>
		<div title="审批内容">
		   <%@include file="/fm/instr/subStockIssueTrace/processControlTrace.jsp" %>
		</div>
		<div title="流程信息" url="com.cjhxfund.ats.fm.comm.processGraph.flow?processInstID=<%=processinstid %>&workItemID=<%=workItemID %>&bizId=<%=bizId %>"></div>
		<l:in property="workitem/activityDefID" targetValue="ATS_FM_CZ_TBZX,ATS_FM_CZ_CZZZCXS,ATS_FM_CZ_FSZCXS">
			<div title="传真发送列表" url="<%=request.getContextPath() %>/fm/instr/firstGradeDebt/eastFaxList.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>&type=1" refreshOnClick="true"></div>
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
    	
		var instReport = nui.get("instReport");
    	instReport.load();
    	
    	
    //tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	function activechangedFun(){
		//标签切换时同时刷新“今日待处理”，模块数据
		//reloadWaitConfirmFun();
	
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tabs").getActiveTab().title;
		
		if(activeTabTitle.indexOf("审批内容")!=-1){
			//附件列表
		    loademployeeGrid("file_grid","#file_Form");	
		}
	}
	
	//刷新datagrid表格
	function gridReload(datagrid){
		var grid = nui.get(datagrid);
			grid.reload();
	}	
		 
	 //缴款金额(万元)
     function paymentMoneyFun(){
         formatNumberCommon("paymentMoney",4);
     }
     
     function processSubmit(){
        var processinstid=nui.get("processinstid").getValue();
        var workItemID=nui.get("workItemID").getValue();
        var lBizId=nui.get("lBizId").getValue();
        var operateType=nui.get("operateType").getValue();
		var comments=nui.get("comments").getValue();
		var vcArchiveProcessId=nui.get("vcArchiveProcessId").getValue();
		var processIdArr={
		        processinstid:processinstid,
		        workItemID:workItemID,
		        lBizId:lBizId,
		        operateType:operateType,
		        comments:comments,
		        vcArchiveProcessId:vcArchiveProcessId
		}
		var json = nui.encode({stockIssueTraceData:processIdArr});
		nui.confirm("确认是否提交？","系统提示",function(action){
			if(action=="ok"){
				var a = nui.loading("正在处理中,请稍等...","提示");
				nui.ajax({
					url:"com.cjhxfund.ats.fm.instr.subStockIssueTrace.subStockIssueTrace.biz.ext",
					type:'POST',
					data:json,
					cache: false,
					contentType:'text/json',
					success:function(text){
						nui.hideMessageBox(a);
						var returnJson = nui.decode(text);
						if(returnJson.retCode=="true"){
			      			nui.alert("流程提交成功","系统提示",function(a){
			      			try{
			    			if (!!window.ActiveXObject || "ActiveXObject" in window){//如果是IE浏览器
				              	 window.opener.history.go(0);
				              }else{
				              	window.opener.reloadData();
				              }
				           }catch(e){
			    			}
			    			//返回我的代办任务页面
		    				CloseWindow("confirmSuccess");
	    				    }); 
			      		}else{
			      		    nui.alert("流程提交失败！");
			      		}
					}
		    	});
		    }
		});	
  	 }
   
    
	function getNowFormatDate() {
    	var date = new Date();
    	var seperator1 = "-";
  
    	var year = date.getFullYear();
    	var month = date.getMonth() + 1;
    	var strDate = date.getDate();
   		if (month >= 1 && month <= 9) {
        	month = "0" + month;
    	}
    	if (strDate >= 0 && strDate <= 9) {
        	strDate = "0" + strDate;
    	}
    	var currentdate = year + seperator1 + month + seperator1 + strDate;
    	return currentdate;
	}
	
   



	function dateTemp(oldData){
			oldData=oldData+"";
			if(oldData==0 || oldData=="" || oldData=="null"){
				return "";
			}
			
			var datas=oldData.indexOf("-");
			if(datas>=0){
				return oldData;
			}
			var yy=oldData.substr(0,4);//0开始，截取后面4位
			var mm=oldData.substr(4,2);//4开始，截取后面2位
			var dd=oldData.substr(6,2);
			
			return yy+"-"+mm+"-"+dd;
		}	
		
		//登记机构改变事件
		function onVcPaymentPlace(){
			var place=nui.get("vcPaymentPlace").getValue();
			var vcStockType = nui.get("vcStockType").getValue();
			if("D"==vcStockType && "02" ==place){
				nui.get("vcTransactionType").setValue(3);
			}else if(place=="01"){
			  //中央结算公司cPayType
			  	nui.get("vcTransactionType").setValue(2);
			}else if(place=="02"){
			  //上海清算所
			  nui.get("vcTransactionType").setValue(1);
			}else{
			  nui.get("vcTransactionType").setValue(3);
			}
		}
		
		function onAccountTypeChanged() {
	 		var vcStockType=nui.get("vcStockType").getValue();
	        if(vcStockType!="" && vcStockType!=null){
		        if(vcStockType == 'Q' || vcStockType == 'O' ){
		        	$("#morStockNameAndCode").show();
		        	$("#morStockAmount").show();
		        }else{
			       $("#morStockNameAndCode").hide();
		           $("#morStockAmount").hide();
		        }
		    }
        }
       
        
    </script>
    <script	src="<%= request.getContextPath() %>/fm/instr/processUtil/process.js" type="text/javascript"></script>
	<script type="text/javascript">
		
			
		//债券类别为可转债时，显示股票名称，股票代码，抵押股票数量
		onAccountTypeChanged();		
		//分解投标截止时间
		var dApplicationDateStr =  nui.get("dBidLimitTime").getValue();
		var dApplicationDate  = new Date(Date.parse(dApplicationDateStr.replace(/-/gi,  "/")));
		nui.get("dApplicationDate").setValue(dApplicationDate);
		nui.get("dApplicationTimeHH").setValue(dApplicationDate.getHours());
		nui.get("dApplicationTimeMM").setValue(dApplicationDate.getMinutes());
		
		//初始化产品净值规模(万元)和已投资该发行主体债券存量(万元)的三位一逗
		formatNumberCommon("fsumamount",4);
		formatNumberCommon("enNetScale",4);
		
		
		
		//调用附件查询方法
     	loademployeeGrid("file_grid","#file_Form");	
     	var columns = file_grid.columns;
     	
		function showTips() {
			var reportTypeMark = "";
			var json = '{"paramKey":"REPORT_TYPE_MARK"}';
			var url = "<%= request.getContextPath() %>/fm/instr/firstGradeDebt/reportMark.jsp";
			var title = "报量方式说明";
			var width = "610";
			var height = "618";
			//从系统参数获得报量方式
			$.ajax({
				url:"com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.getParamValue.biz.ext",
				type:'POST',
				data:json,
				cache:false,
				async:false,
				contentType:'text/json',
				success:function(data){
					reportTypeMark = data.paramValue;
				}
			});
			nui.open({
				url: url,
				title: title, width: width, height: height,
				onload: function () {//弹出页面加载完成
					 var iframe = this.getIFrameEl(); 
        			//调用弹出页面方法进行初始化
        			iframe.contentWindow.SetData(reportTypeMark); 
				},
				ondestroy: function (action) {//弹出页面关闭前,把新增的主体简称返回赋值给查询框
				}
			});
	}
	
	//查询债券详情
	  function queryStockDetail(){
	    var lStockIssueId= nui.get("lStockIssueId").getValue();
	  	nui.open({
                    url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueQueryDetail.jsp?lStockIssueId="+lStockIssueId,
                    title: "详细信息", 
                    width: 980, 
           			height: 700,
                    //allowResize:false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        iframe.contentWindow.initForm();
                    },
                    ondestroy: function (action) {
                        if(action=="saveSuccess"){
	                        grid.reload();
                   	 	}
                    }
                });
	  }
	  	var grid3 = nui.get("datagrid3");
	  	var keyText3 = mini.get("keyText3");
	  	//收款账号查询条件 
	    function onClearClick3(e) {
            nui.get("keyText3").setValue("");
        }
        	var hlrivalid = nui.get("hlRivalId").getValue();
        function onSearchClick3(e) {
            grid3.load({
            	hlrivalid:hlrivalid,
                key: keyText3.value
            });
        }
       
        
	    // 报量历史展示
		function reportHistory(){
			var investNo = nui.get("lInvestNo").value;
			nui.open({
				url: "<%= request.getContextPath() %>/fm/comm/showReportHistory.jsp",
				title: "历史报量", 
				width: 650, 
				height: 450,
				onload: function () {//弹出页面加载完成
					 var iframe = this.getIFrameEl(); 
					//调用弹出页面方法进行初始化
					iframe.contentWindow.setData(investNo); 
				},
				ondestroy: function (action) {//弹出页面关闭前,把新增的主体简称返回赋值给查询框
				}
			});
		}
	grey();
    //置灰
	function grey(){
	  readonlyInput("dApplicationTime","dApplicationTime");
	  readonlyInput("dApplicationDate","dApplicationDate");
	  readonlyInput("dApplicationTimeHH","dApplicationTimeHH");
	  readonlyInput("dApplicationTimeMM","dApplicationTimeMM");
	  readonlyInput("vcProductName","vcProductName");
	  readonlyInput("vcCombiName","vcCombiName");
	  readonlyInput("vcStockCode","vcStockCode");
	  readonlyInput("vcStockName","vcStockName");
	  readonlyInput("vcPaymentPlace","vcPaymentPlace");
	  readonlyInput("vcStocktypeName","vcStocktypeName");
	  readonlyInput("vcIssuerNameFull","vcIssuerNameFull");
	  readonlyInput("vcStockNameFull","vcStockNameFull");
	  readonlyInput("lIssueBeginDate","lIssueBeginDate");
	  readonlyInput("enIssueBalance","enIssueBalance");
	  readonlyInput("vcMainUnderwriter","vcMainUnderwriter");
	  readonlyInput("vcDeputyUnderwriter","vcDeputyUnderwriter");
	  readonlyInput("vcGroupUnderwriter","vcGroupUnderwriter");
	  readonlyInput("vcBusinessObject","vcBusinessObject");
	  readonlyInput("vcIssueProperty","vcIssueProperty");
	  readonlyInput("cIssueAppraise","cIssueAppraise");
	  readonlyInput("cBondAppraise","cBondAppraise");
	  readonlyInput("vcBondAppraiseOrgan","vcBondAppraiseOrgan");
	  readonlyInput("vcSpecialText","vcSpecialText");
	  readonlyInput("enExistLimite","enExistLimite");
	  readonlyInput("vcTenderInterval","vcTenderInterval");
	  readonlyInput("lNextExerciseDate","lNextExerciseDate");
	  readonlyInput("lNInterestRateJumpPoints","lNInterestRateJumpPoints");
	  readonlyInput("dInitInterestPaymentDate","dInitInterestPaymentDate");
	  readonlyInput("enIssuerNetValue","enIssuerNetValue");
	  readonlyInput("vcCityLevel","vcCityLevel");
	  readonlyInput("vcIssueAppraiseCsrcName","vcIssueAppraiseCsrcName");
	  readonlyInput("vcMortStockName","vcMortStockName");
	  readonlyInput("vcMortStockCode","vcMortStockCode");
	  readonlyInput("vcMortStockAmount","vcMortStockAmount");
	  readonlyInput("resaleRight","resaleRight");
	  
	  readonlyInput("redemptionRight","redemptionRight");
	  
	  $("#vcRemarks textarea").attr("readonly","readonly");//解决IE兼容
	  $("#vcRemarks textarea").css("background-color","#f0f0f0");//置灰 
	  readonlyInput("vcSpecialLimite","vcSpecialLimite");
	  readonlyInput("fsumamount","fsumamount");
	  readonlyInput("enNetScale","enNetScale");
	  readonlyInput("enInvestScaleRatio","enInvestScaleRatio");
	  readonlyInput("enIssuerNetRatio","enIssuerNetRatio");
	  readonlyInput("enInvestNetRatio","enInvestNetRatio");
	  readonlyInput("enWeakNetRatio","enWeakNetRatio");
	  readonlyInput("cReportType","cReportType");
	  readonlyInput("payFaceValue","payFaceValue");
	  readonlyInput("enBallotPrice","enBallotPrice");
	  readonlyInput("paymentMoney","paymentMoney");
	  readonlyInput("dPaymentDate","dPaymentDate");
	  readonlyInput("enCouponRate","enCouponRate");
	  readonlyInput("vcFrequency","vcFrequency");
	  readonlyInput("vcModeRepayment","vcModeRepayment");
	  readonlyInput("lBegincalDate","lBegincalDate");
	  readonlyInput("lEndincalDate","lEndincalDate");
	  readonlyInput("vcTransactionType","vcTransactionType");
	  readonlyInput("vcBeneficiary","vcBeneficiary");
	  readonlyInput("vcCollectionAccount","vcCollectionAccount");
	  readonlyInput("vcTransactionType","vcTransactionType");
	  readonlyInput("vcPayLine","vcPayLine");
	  $("#vcReceivableRemark textarea").attr("readonly","readonly");//解决IE兼容
	  $("#vcReceivableRemark textarea").css("background-color","#f0f0f0");//置灰 
	  
	  readonlyInput("theme","theme");
	  readonlyInput("recvName","recvName");
	  readonlyInput("recvCompany","recvCompany");
	  readonlyInput("vcTelephoneNumber","vcTelephoneNumber");
	  readonlyInput("FaxNumber","FaxNumber");
	  $("#faxComments textarea").attr("readonly","readonly");//解决IE兼容
	  $("#faxComments textarea").css("background-color","#f0f0f0");//置灰 
	}
	function readonlyInput(inputNuiId,inputJQId){
	    $("#"+inputJQId+" input").attr("readonly","readonly");//解决nui禁用IE兼容
		$("#"+inputJQId+" input").css("background-color","#f0f0f0");//置灰
	}
	</script>
</body>
</html>