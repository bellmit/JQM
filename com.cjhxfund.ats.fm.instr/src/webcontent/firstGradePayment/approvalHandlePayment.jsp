<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@include file="/common/js/commscripts.jsp" %>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<html>
<head>
	<title><b:write property="workitem/workItemName" /></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<script src="<%= request.getContextPath() %>/fm/instr/processUtil/instr.js" type="text/javascript"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
    <style type="text/css">

      .asLabel .mini-textbox-input{
        color: red;
        background:none;cursor:default;
      }
      .asLabel_gray .mini-textbox-input{
         color: black;
         background:none;cursor:default;
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
	   
	   
	   String processType =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"processType");
	   
	   //工作项ID
	   String workItemID =(String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workItemID");
	   
	   //获取产品代码
	   DataObject obj = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"firstGradeBond");
	   String vcProductCode = obj.getString("vcProductCode");
	   
	   //获取工作项信息
	   DataObject workitem = (DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"workitem");
	   String activityDefID = workitem.getString("activityDefID");
	   
	   //获取当前时间并转换为字符串类型
	   Date dateTime = new Date();
	   SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	   String myDate = format.format(dateTime);
	   
	   //定义需要用印的节点
	   String str="ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_FXYYY,";
	   int tabsIndex=0;//默认选择基本信息界面
	   //匹配节点
	   if(str.indexOf(activityDefID+",")!=-1){
	   		tabsIndex=1;
	   }
 	%>
 	<script type="text/javascript" src="<%=request.getContextPath() %>/common/js/commonjs.js"></script>
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
					
					<input class="nui-hidden" id="processType" name="processType" value="<%=processType %>"/>
					
				    <input class="nui-hidden" id="workItemID" name="workItemID" value="<%=workItemID %>"/>
				    <input class="nui-hidden" id="workItemName" value="<b:write property="workitem/workItemName" />">
				    <!-- 投资编号 -->
				    <input class="nui-hidden"  name="applyInst.cApplyAuthStatus" value="<b:write property="firstGradeBond/cApplyAuthStatus" />" /> 
					<input class="nui-hidden"  name="applyInst.cPaymentAuthStatus" value="<b:write property="firstGradeBond/cPaymentAuthStatus" />" />
					<input class="nui-hidden" name="applyInst.cApplyInstType" value="<b:write property="firstGradeBond/cApplyInstType" />" />
				    <input class="nui-hidden" id="stockissueinfo.lStockIssueId" name="stockissueinfo.lStockIssueId" value="<b:write property="firstGradeBond/lStockIssueId" />"/>
				    <input class="nui-hidden" id="lInvestNo" name="firstGradeBond.lInvestNo" value="<b:write property="firstGradeBond/lInvestNo" />"/>
				    <input class="nui-hidden" id="lApplyInstId" name="firstGradeBond.lApplyInstId" value="<b:write property="firstGradeBond/lApplyInstId" />"/>
				    <!-- 流程业务主表ID -->
				    <input class="nui-hidden" id="lBizId" name="firstGradeBond.lBizId" value="<b:write property="firstGradeBond/lBizId" />"/>
				    <!-- 产品编码 -->
				    <input class="nui-hidden" id="vcProductCode" name="firstGradeBond.vcProductCode" value="<b:write property="firstGradeBond/vcProductCode" />"/>
				    <input class="nui-hidden" id="dBidLimitTime" name="firstGradeBond.dBidLimitTime" value="<b:write property="firstGradeBond/dBidLimitTime" />"/>
				    <!-- 新债投资编号 -->
				    <input class="nui-hidden" id="lStockInvestNo" name="firstGradeBond.lStockInvestNo" value="<b:write property="firstGradeBond/lStockInvestNo" />"/>
				    <input class="nui-hidden" name="firstGradeBond.enInvestBalance" id="vcInvestBalance" value="<b:write property="firstGradeBond/enInvestBalance" />"/>
				    <input class="nui-hidden" name="firstGradeBond.enInterestRate" id="enInterestRate" value="<b:write property="firstGradeBond/enInterestRate" />"/>
				    <!-- Fix发送状态 -->
				    <input class="nui-hidden" id="lFixValidStatus" name="firstGradeBond.lFixValidStatus" value="<b:write property="firstGradeBond/lFixValidStatus" />"/>
				    <!-- 报量修改状态 -->
				    <input class="nui-hidden" id="cReportUpdateStatus" name="firstGradeBond.cReportUpdateStatus" value="<b:write property="firstGradeBond/cReportUpdateStatus" />"/>
				    
				    
				    <table style="width:100%;table-layout:fixed;" class="nui-form-table"> 
		                <tr>
		                    <td class="form_label td1" width="20%" align="right">
		                        业务日期:    
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-datepicker" name="firstGradeBond.dApplicationTime" format="yyyy-MM-dd" width="220px" value="<b:write property="firstGradeBond/dApplicationTime" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right" width="20%">
				                 缴款日期:
				             </td>
				            <td colspan="1" >
								<input class="nui-datepicker" name="firstGradeBond.dPaymentDate" id="dPaymentDate" 
									value="<b:write property="firstGradeBond/dPaymentDate" />" onvaluechanged="onDrawDate" style="width: 220px;" readonly="readonly"/>
			             	</td>
		                </tr>
		                <tr>
		                  <td class="form_label td1" align="right">
		                        产品名称:
		                    </td>
		                    <td colspan="1" class="td2">
		                        <input class="nui-textbox" id="vcProductName" width="220px" name="firstGradeBond.vcProductName" value="<b:write property="firstGradeBond/vcProductName" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right">
			                        组合名称:
			                  </td>
			                  <td colspan="1" class="td2">
			                      <input class="nui-textbox"  width="220px" id="vcCombiName" name="firstGradeBond.vcCombiName" value="<b:write property="firstGradeBond/vcCombiName" />" readonly="readonly"/>
			                  </td>
		                </tr>
		                <tr>
		                    <td class="form_label td1" width="20%" align="right">
		                        债券简称:
		                    </td>
		                    <td colspan="1" class="td2">
		                        <input class="nui-textbox" id="vcStockName" width="220px" name="firstGradeBond.vcStockName" value="<b:write property="firstGradeBond/vcStockName" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right">
		                        债券代码:
		                    </td>
		                    <td colspan="1" >
		                        <input  id="vcStockCode" width="220px" class="nui-textbox"name="firstGradeBond.vcStockCode" value="<b:write property="firstGradeBond/vcStockCode" />" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                	<td class="form_label td1" align="right">
				登记托管机构:
					  		</td>
					  		<td colspan="1" class="td1">
					  			<!-- 登记托管机构 -->
					  			<input width="220px"class="nui-dictcombobox" id="vcPaymentPlace" name="firstGradeBond.vcPaymentPlace" value="<b:write property="firstGradeBond/vcPaymentPlace" />" dictTypeId="CF_JY_DJTGCS" readonly="readonly" />
					  		</td>
					  		<td class="form_label td1" align="right">
		                        债券类别:
		                    </td>
		                    <td colspan="1" class="td2">
		                        <input class="nui-textbox" width="220px" id="vcStocktypeName" name="firstGradeBond.vcStocktypeName" 
		                        value="<b:write property="firstGradeBond/vcStocktypeName" />" readonly="readonly"/>
		                        <input class="nui-hidden" id="vcStockType" name="firstGradeBond.vcStockType" value="<b:write property="firstGradeBond/vcStockType" />" />  
		                    </td>
		                </tr>
		                <tr>
		                	<td class="form_label td1" align="right">
		                        发行主体:
		                    </td>
		                    <td colspan="1" class="td2">
		                        <input class="nui-textbox" width="220px" name="firstGradeBond.vcIssuerNameFull" value="<b:write property="firstGradeBond/vcIssuerNameFull" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label" align="right">
			      债券全称:
						  </td>
						  <td colspan="1">
						    <input style="width: 220px;" class="nui-textbox" id="vcStockNameFull" name="firstGradeBond.vcStockNameFull" value="<b:write property="firstGradeBond/vcStockNameFull" />" readonly="readonly"/>
						  </td>
		                </tr>
		                <tr>
		                	<td class="form_label" align="right" >
				发行日期:
					  		</td>
					  		<td colspan="1">
							  	<input style="width:220px" class="nui-datepicker" id="lIssueBeginDate" name="firstGradeBond.lIssueBeginDate" 
				                value="<b:write property="firstGradeBond/lIssueBeginDate" />" format="yyyy-MM-dd" readonly="readonly"/>
					  		</td>
						  	<td class="form_label td1" align="right">
		                         发行规模(亿):
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" name="firstGradeBond.enIssueBalance" id="enIssueBalance" width="220px" value="<b:write property="firstGradeBond/enIssueBalance" />" readonly="readonly"/>
		                    </td>
		                 </tr>
		            </table>
				   <!-- 环节在该活动实例下显示 -->
			        <%-- <l:in property="workitem/activityDefID" targetValue="ATS_FM_TGFH,ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_TZJLFH,ATS_FM_SCSFYYXY,ATS_FM_ZJQS,ATS_FM_PDFXYYY,ATS_FM_FXYYYFH,ATS_FM_FXYYY"> --%>    
		            <div title="缴款信息" id="panel2" class="mini-panel"  iconCls="icon-edit" style="width:100%;" 
           	showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="false" collapseOnTitleClick="true">
				   <table style="width:100%;table-layout:fixed;" border="0" class="nui-form-table">
				      <tr>
			             <td class="form_label td1" align="right" width="20%">
			               缴款面值(万元):
			             </td>
			             <td colspan="1" >
			                 <input class="nui-textbox" id="payFaceValue" value="<b:write property="firstGradeBond/enPayFaceValue" />" 
			                 	    onvaluechanged="payVcBallotNumber()"  style="width: 220px;" readonly="readonly"/>
			                 <input class="nui-hidden"  id="enPayFaceValue" name="firstGradeBond.enPayFaceValue" value="<b:write property="firstGradeBond/enPayFaceValue" />"/>   
			             </td>
			             <td class="form_label td1" align="right" width="20%">
			                 发行价格(元):
			             </td>
			             <td colspan="1">
			                 <input class="nui-textbox" name="firstGradeBond.enBallotPrice" id="enBallotPrice"
			                    value="<b:write property="firstGradeBond/enBallotPrice" />" vtype="maxLength:100;float" style="width: 220px;" onvaluechanged="payVcBallotPrice()" readonly="readonly"/>
			             </td>
				      </tr>
				      <tr>
			             <td class="form_label td1" align="right" width="20%">
			                 缴款金额(万元):
			             </td>
			             <td colspan="1">
			                 <input class="nui-textbox"  id="paymentMoney" value="<b:write property="firstGradeBond/enPaymentMoney" />"  style="width: 220px;" readonly="readonly"/>
			             	<input class="nui-hidden" name="firstGradeBond.enPaymentMoney" id="enPaymentMoney"
			                       value="<b:write property="firstGradeBond/enPaymentMoney" />"  />
			             </td>
			             <td class="form_label td1" align="right">
			                 票面利率(%):
			             </td>
			            <td colspan="1" class="td2">
							<input class="nui-textbox" name="firstGradeBond.enCouponRate" id="enCouponRate" 
								value="<b:write property="firstGradeBond/enCouponRate" />"  style="width: 220px;" readonly="readonly"/>
			             </td>
			          </tr>
			          <tr>
			             <td class="form_label td1" align="right">
			                        付息频率(次/年):
			             </td>
			             <td colspan="1" class="td2">
			                 <input class="nui-dictcombobox" valueFromSelect="false" dictTypeId="ATS_CF_JY_FREQUENCY" allowInput="true" name="firstGradeBond.vcFrequency" id="vcFrequency"
			                    value="<b:write property="firstGradeBond/vcFrequency" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"  style="width: 220px;" readonly="readonly"/>
			             </td>
			             <td class="form_label td1" align="right">
						计息起始日期:
					  </td>
					  <td colspan="1"  style="border-bottom: 1px solid #D3D3D3;" class="td1">
					    <input class="nui-datepicker" id="lBegincalDate" name="stockissueinfo.lBegincalDate" value="<b:write property="firstGradeBond/lBegincalDate" />" format="yyyy-MM-dd" style="width: 220px;" readonly="readonly"/>
					  </td>
			          </tr>
			          <tr>
			             <td class="form_label td1" align="right">
			                        还本方式:
			             </td>
			            <td colspan="1" class="td2" >
							<input class="nui-dictcombobox" dictTypeId="CF_JY_MODE_REPAYMENT" name="firstGradeBond.vcModeRepayment" id="vcModeRepayment" 
								value="<b:write property="firstGradeBond/vcModeRepayment" />" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"  style="width: 220px;" readonly="readonly"/>
			             </td>
			             <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
			                       到期日:
			             </td>
			             <td colspan="1"  style="border-bottom: 1px solid #D3D3D3;" class="td1">
			                 <input class="nui-datepicker" name="firstGradeBond.lEndincalDate" id="lEndincalDate"
			                    value="<b:write property="firstGradeBond/lEndincalDate" />"  style="width: 220px;" readonly="readonly"/>
			             </td>	             
			          </tr>
			          <tr>
		                    <td class="form_label td1" width="20%" align="right">
		                        缴款方式:    
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-dictcombobox" dictTypeId="ATS_FM_PAYMENT" name="firstGradeBond.cPayType" width="220px" value="<b:write property="firstGradeBond/cPayType" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" width="20%" align="right">
		                        收款人户名:
		                    </td>
		                    <td colspan="1" class="td1">
		                        <input class="nui-textbox"id="combProductName" width="220px" name="firstGradeBond.vcBeneficiary" value="<b:write property="firstGradeBond/vcBeneficiary" />" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                	<td class="form_label td1" width="20%" align="right">
		                        收款账号:    
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" name="firstGradeBond.vcCollectionAccount" value="<b:write property="firstGradeBond/vcCollectionAccount" />" width="220px" readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" width="20%" align="right">
		                        大额支付行号:    
		                    </td>
		                    <td  class="td1">
		                        <input class="nui-textbox" name="firstGradeBond.vcPayLine" value="<b:write property="firstGradeBond/vcPayLine" />" width="220px" readonly="readonly"/>
		                    </td>  
		                </tr>
		                <tr>
		                   <td class="form_label td1" width="20%" align="right" style="border-bottom: 1px solid #D3D3D3;">
		                        收款备注:
		                    </td>
		                    <td colspan="3" class="td1" style="border-bottom: 1px solid #D3D3D3;">
		                        <input class="nui-textarea" id="vcReceivableRemark" width="515" height="40" name="firstGradeBond.vcReceivableRemark" value="<b:write property="firstGradeBond/vcReceivableRemark" />" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
						   <td class="form_label td1" width="20%" align="right" >
							债券详情:
						   </td>
						   <td class="td1">
						   			<a  class='nui-button' plain='false' onclick="queryStockDetail()">
									    查看债券详情
									</a>
						   </td>
						   <td class="form_label td1" width="20%" align="right">
						  </td>
						  <td class="td1">
						   </td>
						</tr>
				   </table>
				   <%-- </l:in> --%>
				   </div>
				   <div title="债券详细"id="panel3" class="mini-panel"  iconCls="icon-edit" style="width:100%;" 
           	showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="false" collapseOnTitleClick="true">
				
			   <table style="width:100%;table-layout:fixed;" class="nui-form-table"> 
		               
		                <tr>
		                    <td class="form_label td1" width="20%" align="right">
		                        主承销商:    
		                    </td>
		                    <td colspan="3" >
		                    <input class="nui-textbox" name="firstGradeBond.vcMainUnderwriter" width="85%" value="<b:write property="firstGradeBond/vcMainUnderwriter" />"  readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="form_label td1" align="right" width="20%">
				                 副主承销商:
			                </td>
			                <td colspan="3">
			                    <input class="nui-textbox" name="firstGradeBond.vcDeputyUnderwriter" width="85%" value="<b:write property="firstGradeBond/vcDeputyUnderwriter" />"  readonly="readonly"/>
			                </td>
		                </tr>
		                <tr>
		                	 <td class="form_label td1" align="right" width="20%">
				                 承销团:
			                </td>
			                <td colspan="3">
			                    <input class="nui-textbox" name="firstGradeBond.vcGroupUnderwriter" width="85%" value="<b:write property="firstGradeBond/vcGroupUnderwriter" />"  readonly="readonly"/>
			                </td>
		                </tr>
		         </table>
	             <table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">
		                <tr>
		                    <td class="form_label td1" width="20%" align="right">
		                        主体类型:    
		                    </td>
		                    <td colspan="1" >
		                        <input class="nui-dictcombobox" dictTypeId="ATS_FM_ISSUE_PROPERTY" width="220px" name="firstGradeBond.vcIssueProperty" value="<b:write property="firstGradeBond/vcIssueProperty" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right" width="20%">
				               交易对手:
				             </td>
				            <td colspan="1">
				            	<input class="nui-hidden"  id="hlRivalId" name="firstGradeBond.lRivalId" value="<b:write property="firstGradeBond/lRivalId" />"/>
			                  	<input class="nui-textbox" name="firstGradeBond.vcBusinessObject" width="220px" value="<b:write property="firstGradeBond/vcBusinessObject" />"  readonly="readonly"/>
			             	</td>
		                </tr>
		                <tr>
		                	<td class="form_label td1" align="right">
		                        主体评级:
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-dictcombobox" dictTypeId="issuerRating" width="220px" id="cIssueAppraise" 
		                        name="firstGradeBond.cIssueAppraise" value="<b:write property="firstGradeBond/cIssueAppraise" />" readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right">
		                        债券评级:
		                    </td>
		                    <td colspan="1" class="td2"> 
		                        <input class="nui-dictcombobox" dictTypeId="creditRating" id="cBondAppraise" 
		                        width="220px" name="firstGradeBond.cBondAppraise" value="<b:write property="firstGradeBond/cBondAppraise" />" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="form_label td1" align="right">
		                        主体评级机构:
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-dictcombobox" dictTypeId="outRatingOrgan" width="220px" id="vcIssueAppraiseOrgan" 
		                        name="firstGradeBond.vcIssueAppraiseOrgan" value="<b:write property="firstGradeBond/vcIssueAppraiseOrgan" />"  readonly="readonly"/>
		                    </td>
		                    <td class="form_label td1" align="right">
		                        债券评级机构:
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-dictcombobox" dictTypeId="outRatingOrgan" width="220px" id="vcBondAppraiseOrgan" 
		                        name="firstGradeBond.vcBondAppraiseOrgan" value="<b:write property="firstGradeBond/vcBondAppraiseOrgan" />"  readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="form_label td1" align="right">
							特殊条款:
						  </td>
						  <td colspan="1"  >
						  	<input width="220px" id="vcSpecialText" class="nui-dictcombobox" name="stockissueinfo.vcSpecialText"	value="<b:write property="firstGradeBond/vcSpecialText" />" readonly="readonly" 
						     showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="specialText" />
						  </td>
						  <td class="form_label td1" align="right">
		                       发行期限(年):
		                    </td>
		                    <td colspan="1">
		                        <input class="nui-textbox" name="firstGradeBond.enExistLimite" width="220px" value="<b:write property="firstGradeBond/enExistLimite" />" readonly="readonly"/>
		                    </td>
						  
						</tr>
		                <tr>
						  <td class="form_label" align="right" >
				      特殊期限:
						  </td>
						  <td colspan="1">
						    <input style="width: 220px;" class="nui-textbox" id="vcSpecialLimite" name="firstGradeBond.vcSpecialLimite" value="<b:write property="firstGradeBond/vcSpecialLimite" />" readonly="readonly"/>
						  </td>
		                  <td class="form_label" align="right" >
				发行方式:
						  </td>
						  <td colspan="1" >
						  	<input style="width: 220px;" id="vcIssueType" class="nui-dictcombobox" name="firstGradeBond.vcIssueType" 
						      value="<b:write property="firstGradeBond/vcIssueType" />" showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="issueType" readonly="readonly"/>
						  </td>  
						 </tr>
						 <tr>
						  <td class="form_label td1" align="right">
							     下一利率跳升点数:
						  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="lNInterestRateJumpPoints" name="stockissueinfo.lNInterestRateJumpPoints" value="<b:write property="firstGradeBond/lNInterestRateJumpPoints" />" readonly="readonly"/>
						  </td>
						 	<td class="form_label td1" align="right" width="20%">
			                        首次付息日:
		                    </td>
		                    <td class="td2">
								<input class="nui-datepicker" name="firstGradeBond.dInitInterestPaymentDate" id="dInitInterestPaymentDate"
								value="<b:write property="firstGradeBond/dInitInterestPaymentDate" />" style="width: 220px;"  readonly="readonly"/>
		                    </td>
						 </tr>
						 <tr>
		                     <td class="form_label td1" align="right">
							     公司净资产（元）:
						  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="enIssuerNetValue" name="stockissueinfo.enIssuerNetValue" value="<b:write property="firstGradeBond/enIssuerNetValue" />" readonly="readonly"/>
						  </td>
		                   <td class="form_label td1" align="right">
							    城投行政级别:
						  </td>
						  <td colspan="1"  >
						  	<input width="220px" id="vcCityLevel" class="nui-dictcombobox" name="stockissueinfo.vcCityLevel" value="<b:write property="firstGradeBond/vcCityLevel" />" readonly="readonly"
						     showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="cityLevel" />
						  </td>
		                </tr>
		                <tr id="morStockNameAndCode">
						  <td class="form_label td1" align="right">
							    股票名称:
						  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="vcMortStockName" name="stockissueinfo.vcMortStockName" value="<b:write property="firstGradeBond/vcMortStockName" />" readonly="readonly"/>
						  </td>
						  <td class="form_label td1" align="right">
							     股票代码:
						  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="vcMortStockCode" name="stockissueinfo.vcMortStockCode" value="<b:write property="firstGradeBond/vcMortStockCode" />" readonly="readonly"/>
						  </td>
						</tr>
						<tr id="morStockAmount">
						  <td class="form_label td1" align="right">
							    股票抵押数量(万股):
						  </td>
						  <td colspan="1">
						    <input width="220px" class="nui-textbox" id="vcMortStockAmount" name="stockissueinfo.vcMortStockAmount" value="<b:write property="firstGradeBond/vcMortStockAmount" />" readonly="readonly"/>
						  </td>
						   <td colspan="2" class="form_label">
						  </td>
						</tr>
						
						
						
						
		                <tr>
		                    <td class="form_label td1" align="right">
							    所属行业(证监会二级):
						  </td>
						  <td colspan="1">
						    <input class="nui-hidden" id="vcIssueAppraiseCsrc" width="220px" name="stockissueinfo.vcIssueAppraiseCsrc" value="<b:write property="firstGradeBond/vcIssueAppraiseCsrc" />" readonly="readonly"/>
		                    <input class="nui-textbox" width="220px" id="vcIssueAppraiseCsrcName" name="stockissueinfo.vcIssueAppraiseCsrcName" 
		                        value="<b:write property="firstGradeBond/vcIssueAppraiseCsrcName" />" readonly="readonly"/>
						  </td>
						  
						  <td class="form_label td1" align="right">
							    ABS类型:
						  </td>
						  <td colspan="1">
						  	<input width="220px" id="vcAbsType" class="nui-dictcombobox"  name="firstGradeBond.vcAbsType" value="<b:write property="firstGradeBond/vcAbsType" />" readonly="readonly"
						     showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="vcAbsType"   />
						  </td>
		               </tr>	
		                
		                
		             <tr>
			           <td class="form_label td1" align="right">
						主体评级展望:
					  </td>
					  <td colspan="1"  >
					  	<input width="220px" id="vcIssueAppraiseProspect" class="nui-dictcombobox" name="firstGradeBond.vcIssueAppraiseProspect"   
					  	value="<b:write property="firstGradeBond/vcIssueAppraiseProspect" />" 
					    showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="vcIssueAppraiseProspect" readonly="readonly"/>
					  </td>
					  
					    <td class="form_label td1" align="right"> </td>
				        <td colspan="1" class="radio-border-top-none td2"></td>
					</tr>
		                
		                
		                <tr>
		                
		                 <td class="form_label td1" align="right">
		                        是否具有回售权:
		                    </td>
		                    <td colspan="1" class="radio-border-top-none">
		                        <input id="resaleRight" class="nui-dictradiogroup" name="firstGradeBond.cIsHaveSaleback" 
		                       dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="firstGradeBond/cIsHaveSaleback" />" readonly/>
		                      <%--  &nbsp;<label id="resaleYear" style="float: left;display: none;">行权年：
		                       <input class="nui-textbox" name="firstGradeBond.enResaleYear" id="resaleYear" width="45"
		                        value="<b:write property="firstGradeBond/enResaleYear" />" readonly/></label> --%>
		                    </td>
		                    
		                    <td class="form_label td1" align="right"> 
		                        是否具有赎回权:
		                    </td>
		                    <td colspan="1" class="radio-border-top-none td2">
		                        <input id="redemptionRight" class="nui-dictradiogroup" name="firstGradeBond.cIsHaveBuyback" 
		                         dictTypeId="COF_YESORNO" style="float: left;" value="<b:write property="firstGradeBond/cIsHaveBuyback" />" readonly/>
		                         <%--  
		                           &nbsp;<label id="redemptionYear" style="float: left;display: none;">行权年：  
		                          <input class="nui-textbox" name="firstGradeBond.enRedemptionYear" id="redemptionYear"
		       						width="45" value="<b:write property="firstGradeBond/enRedemptionYear" />" readonly="readonly"/></label> --%>
		                    </td>
		                   
		                </tr>
		                
		                
		                	<tr>
			  <td class="form_label td1" align="right">
				是否城投债:	 
			  </td>
			  <td colspan="1" class="radio-border-top-none">
			  	<input    id="cIsHaveCityInvestmentBond" name="firstGradeBond.cIsHaveCityInvestmentBond" class="nui-dictradiogroup"  dictTypeId="COF_YESORNO" value="<b:write property="firstGradeBond/cIsHaveCityInvestmentBond" />" readonly />
			   </td>
			  <td class="form_label td1" align="right">
				是否担保债:	 
			  </td>
			  <td colspan="1" class="radio-border-top-none">
			    <input   id="cIsGuarantyBond" name="firstGradeBond.cIsGuarantyBond" class="nui-dictradiogroup"  dictTypeId="COF_YESORNO" value="<b:write property="firstGradeBond/cIsGuarantyBond" />" readonly />
			  </td>
			</tr>
			
			
			<tr>
			  <td class="form_label td1" align="right">
				是否次级债:	 
			  </td>
			  <td colspan="1" class="radio-border-top-none">
			  	<input    id="cIsSubordinatedBond" name="firstGradeBond.cIsSubordinatedBond" class="nui-dictradiogroup"  dictTypeId="COF_YESORNO" value="<b:write property="firstGradeBond/cIsSubordinatedBond" />" readonly/>
			   </td>
			  <td class="form_label td1" align="right">
				是否永续债:	 
			  </td>
			  <td colspan="1" class="radio-border-top-none">
			    <input   id="cIsPerpetualBond" name="firstGradeBond.cIsPerpetualBond" class="nui-dictradiogroup"  dictTypeId="COF_YESORNO" value="<b:write property="firstGradeBond/cIsPerpetualBond" />" readonly/>
			  </td>
			</tr>
		                
		                
		                 <tr>
		                    <td class="form_label td1" align="right" style="border-bottom: 1px solid #D3D3D3;">
		                        备注:
		                    </td>
		                    <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
		                        <input class="nui-textarea" width="515" height="40" name="firstGradeBond.vcRemarks"
		                        value="<b:write property="firstGradeBond/vcRemarks" />" readonly="readonly"/>
		                        <l:in property="workitem/activityDefID" targetValue="ATS_FM_TGLR,ATS_FM_TGFH,ATS_FM_WTRFH,ATS_FM_XXHD1,ATS_FM_XXHD2,ATS_FM_TZJLFH,ATS_FM_ZJZLSP,ATS_FM_ZXZJFH,ATS_FM_FGLDFH,ATS_FM_FKRGSH">
									<a class='nui-button' plain='false' iconCls="icon-download" onclick="windControlTrial()" style="margin-left: 100px;">风控试算</a>
							    </l:in>
		                    </td>
		                </tr>
	                </table>
	                <table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">
		                <tr>
		                    <td class="form_label" align="right" width="20%" >
		                       已投资债券存量(万元):
				            </td>
				            <td colspan="1" width="25%" >
								<input class="nui-textbox"  id="fsumamount" style="width: 180px;float: left;margin-right: 10px;"  
								onvaluechanged="BondAccountedCalculation" value="<b:write property="firstGradeBond/enCategoryMoney" />"/>
								<a id="" class='nui-button' plain='false' onclick="loadVcNetScale()" iconCls="icon-reload">刷新</a>
				             </td>
		                    <td class="form_label" align="right"  width="25%">
		                        产品净值规模(万元):
		                    </td>
		                    <td colspan="1" >
								<input class="nui-textbox" id="enNetScale" style="width: 180px;" value="<b:write property="firstGradeBond/enNetScale" />" onvaluechanged="BondAccountedCalculation"/>
								<input class="nui-hidden" name="firstGradeBond.enNetScale" id="enNetScale1" value="<b:write property="firstGradeBond/enNetScale" />"  />
		                    </td> 
		                </tr>
		                <tr>
			                <td class="form_label" align="right">
		                                                                       该笔债券投资占发行规模比例(%):
		                    </td>
		                    <td colspan="1">
								<input name="firstGradeBond.enInvestScaleRatio" id="enInvestScaleRatio" class="nui-textbox asLabel" style="width: 180px;"
					                   		value="<b:write property="firstGradeBond/enInvestScaleRatio" />" readonly="readonly"/>
		                    </td> 
		                    <td  class="form_label" align="right" >
				                                            同一发行主体占产品净值规模比例(%):
				            </td>
				            <td colspan="1">
								<input name="firstGradeBond.enIssuerNetRatio" id="enIssuerNetRatio" class="nui-textbox asLabel" style="width: 180px;"
					                   		value="<b:write property="firstGradeBond/enIssuerNetRatio" />" readonly="readonly"/>
				             </td>
			                <%-- <td class="form_label" align="right">债券占比：</td>
			                <td colspan="3" style="padding: 0px;margin: 0xp;">
			                    <p class="p"><label style="margin-left: 5px;font-weight: inherit;">该笔债券投资占发行规模比例(%): </label>
			                   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			                   				<input name="firstGradeBond.enInvestScaleRatio" id="enInvestScaleRatio" class="nui-textbox asLabel" 
					                   		value="<b:write property="firstGradeBond/enInvestScaleRatio" />" readonly="readonly"/></p>
			                	<p class="p"><label style="margin-left: 5px;font-weight: inherit;">同一发行主体占产品净值规模比例(%): </label>
			                   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					                   		<input name="firstGradeBond.enIssuerNetRatio" id="enIssuerNetRatio" class="nui-textbox asLabel"
					                   		value="<b:write property="firstGradeBond/enIssuerNetRatio" />" readonly="readonly"/></p>
			                    <p class="p"><label style="margin-left: 5px;font-weight: inherit;">该笔债券投资占产品净值规模比例(%): </label>
			                   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					                   		<input name="firstGradeBond.enInvestNetRatio" id="enInvestNetRatio" 
					                   		value="<b:write property="firstGradeBond/enInvestNetRatio" />"class="nui-textbox asLabel" readonly="readonly"/></p>
					            <p><label style="margin-left: 5px;font-weight: inherit;">弱流动性资产规模占产品净值规模比例(%): </label>
					                   		<input name="firstGradeBond.enWeakNetRatio" id="enWeakNetRatio"
					                   		value="<b:write property="firstGradeBond/enWeakNetRatio" />" class="nui-textbox" readonly="readonly"/></p>
			                </td> --%>
			              </tr>
		                  <tr>
				              <td class="form_label" align="right">
			                                                                       该笔债券投资占产品净值规模比例(%):
		                    </td>
		                    <td colspan="1">
								<input name="firstGradeBond.enInvestNetRatio" id="enInvestNetRatio" style="width: 180px;"
					                   		value="<b:write property="firstGradeBond/enInvestNetRatio" />"class="nui-textbox asLabel" readonly="readonly"/>
		                    </td> 
		                    <td  class="form_label" align="right">
				                                            弱流动性资产规模占产品净值规模比例(%):
				            </td>
				            <td colspan="1">
								<input name="firstGradeBond.enWeakNetRatio" id="enWeakNetRatio" style="width: 180px;"
					                   		value="<b:write property="firstGradeBond/enWeakNetRatio" />" class="nui-textbox" readonly="readonly"/>
				             </td>
			              </tr>
			   </table>
			   </div>     
				   <!-- 环节不等于中标复核时显示 -->
			        <%-- <l:in property="workitem/activityDefID" targetValue="ATS_FM_TGFH,ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_SCSFYYXY,ATS_FM_ZJQS,ATS_FM_PDFXYYY,ATS_FM_FXYYYFH,ATS_FM_FXYYY"> --%>    
				   <!-- <div title="收款账户信息" id="panel4" class="mini-panel" iconCls="icon-edit" style="width:100%;" 
           	showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="false" collapseOnTitleClick="true">
		            <table style="width:100%;table-layout:fixed;" class="nui-form-table">
		                
		            </table>
		            </div> -->  
		            <%-- </l:in> --%>	
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
								报量方式：<input style="width: 130px;"  url="<%= request.getContextPath() %>/fm/instr/processUtil/reportData.txt" 
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
		       </div>
				<!-- 投资范围 -->
				<div  title="投资范围" region="east" width="220" showCloseButton="false" showSplitIcon="true" expanded="false">	
		    		<iframe src="<%=request.getContextPath() %>/fm/comm/ProductInvestmentRange.jsp?vcProductCode=<%=vcProductCode %>" width="100%" height="100%" scrolling="auto" frameborder="0"></iframe>
				</div>
			</div>
		</div>
		<div title="审批内容"	id="panel5" class="mini-panel" style="width:100%;" 
   				showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="false" collapseOnTitleClick="true">
	   				<%@include file="/fm/instr/firstGradePayment/processControlPayment.jsp" %>
		</div>
		<div title="流程信息" url="com.cjhxfund.ats.fm.comm.processGraph.flow?processInstID=<%=processinstid %>&workItemID=<%=workItemID %>&bizId=<%=bizId %>"></div>
		<l:in property="workitem/activityDefID" targetValue="ATS_FM_XYYYPD,ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_SCSFYYXY,ATS_FM_ZJQS,ATS_FM_PDFXYYY,ATS_FM_FXYYYFH,ATS_FM_FXYYY">
			<div title="传真发送列表" url="<%=request.getContextPath() %>/fm/instr/firstGradeDebt/eastFaxList.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>&type=1" refreshOnClick="true"></div>
		</l:in>
</div>

	<script type="text/javascript">
		nui.parse();
    	//获取应用名称
    	var contextPath = '<%=request.getContextPath() %>';
    	var activityDefID = '<%=activityDefID %>';   //获取活动定义ID
    	var file_grid = nui.get("file_grid");   //附件列表对象
    	var form = new nui.Form("#dataform1");//将普通form转为nui的form
    	
    	//加载报量信息
		//var instReport_from = new nui.Form("instReport_from");
		var instReport = nui.get("instReport");
    	instReport.load();
    	
    	var vcFrequency = nui.get("vcFrequency").getValue();
    	if(vcFrequency==""){
    	   nui.get("vcFrequency").setText("<b:write property="firstGradeBond/vcFrequency" />");
    	}
    	
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
     
     
     function payVcBallotNumber(){
     	var payFaceValue = nui.get("payFaceValue").getValue().replace(/,/gi,'');
     	//验证缴款面值是否为正数
     	var reg = /^([0-9]+)(\.\d{1,4})?$/;
		if (!reg.test(payFaceValue))
		{
			nui.alert("缴款面值不能包含负数、字母、特殊字符，请输入正数如4。","系统提示");
			return;
		}
		
     	formatNumberCommon("payFaceValue",4);  //缴款面值加入千分位
     	
     	nui.get("enPayFaceValue").setValue(payFaceValue);      //将缴款面值设置为隐藏值
     	
     	var ballotPrice  = nui.get("enBallotPrice").getValue().replace(/,/gi,'');   //获取中标价格
     	if(ballotPrice != null && ballotPrice != ""){
     		payVcBallotPrice(); //计算缴款金额
     		//调用判断缴款金额是否大于投标金额方法
     		//judgeInvestBalance();//修改时不调用，提交时才调用
     	}
     }
     
   
     function payVcBallotPrice(){
     	var payFaceValue = nui.get("payFaceValue").getValue().replace(/,/gi,'');  //获取中标数量
     	var ballotPrice  = nui.get("enBallotPrice").getValue().replace(/,/gi,'');   //获取中标价格
     	//alert(payFaceValue +"             "+ballotPrice);
     	//验证中标价格是否为正数
     	var reg = /^(([0-9]+)|([0-9]+\.[0-9]{1,4}))$/;
		if (!reg.test(ballotPrice))
		{
			nui.alert("中标价格不能包含负数、字母、特殊字符，请输入正数如4。","系统提示");
			return;
		}
     	//alert(payFaceValue*ballotPrice);
     	//计算缴款金额并赋值
     	nui.get("paymentMoney").setValue(payFaceValue*ballotPrice/100);
     	paymentMoneyFun();    //调用方法给参数加上千分位
     	
     	nui.get("enPaymentMoney").setValue(payFaceValue*ballotPrice/100);
     	
     	//调用判断缴款金额是否大于投标金额方法
     	//judgeInvestBalance();//修改时不调用，提交时才调用
     }
     
	 function checkCollectionAccount(e){
		var reg = /^[A-Za-z0-9]+$/;   // 以19位数字开头，以19位数字结尾
		if( !reg.test(e.value) )
		{
			nui.alert("收款账号格式错误，只能输入数字与26个英文字母！","系统提示");
			return;
		}
     }
     
     function checkBankLine(e){
		var reg = /^[A-Za-z0-9]+$/;   // 以19位数字开头，以19位数字结尾
		if( !reg.test(e.value) )
		{
			nui.alert("大额支付行号格式错误，只能输入数字与26个英文字母！","系统提示");
			return;
		}
     }
          
     //判断缴款金额是否大于投标金额
     function judgeInvestBalance(){
     	var enInvestBalance = nui.get("vcInvestBalance").getValue();    //投标金额
 		var enPaymentMoney = nui.get("enPaymentMoney").getValue();		//缴款金额
 		if(enPaymentMoney.toString()!="" && enInvestBalance.toString()!=""){
 			//判断缴款金额是否大于投标金额
 			if(enPaymentMoney > enInvestBalance){
			
				openUpdateReport("缴款金额大于投标金额");
				return false;
			}else{
				return reportUpdateStatusAlert();
			}
 		}else{
 			//缴款金额或者投标金额 为空则不允许继续提交
 			nui.alert("缴款金额或者投标金额不允许为空");
 			return false;
 		}
		
     }
     //报量报价验证通过  报量修改状态 处理
     function reportUpdateStatusAlert(){
     	var cReportUpdateStatus=nui.get("cReportUpdateStatus").getValue();
     	var form = new nui.Form("#dataform1");
		 //序列化成JSON
		var json = mini.encode({applyInst:form.getData(false,true).firstGradeBond}); 
		if(cReportUpdateStatus=="0" || cReportUpdateStatus=="6"){
			return true;
		}else if(cReportUpdateStatus==1){
			nui.alert("已通知投顾修改报量，但投顾尚未在投资指令/建议中修改报价信息!");
			return false;
		}else if(cReportUpdateStatus==2){
			nui.alert("投顾已修改报量，但尚未审批完成!");
			return false;
		}else if(cReportUpdateStatus==3){
			nui.confirm("投顾发起修改报量风控审批不通过!您可以点击确认再次通知投顾修改报价，或者点【取消】调整中标确认信息！","系统提示",function(action){
				if(action=="ok"){
					noticeAdviser(json);
				}
			});
			return false;
		}else if(cReportUpdateStatus==4){
			nui.confirm("投顾发起修改报量委托人审批不通过!您可以点击确认再次通知投顾修改报价，或者点【取消】调整中标确认信息！","系统提示",function(action){
				if(action=="ok"){
					noticeAdviser(json);
				}
			});
			return false;
		}else if(cReportUpdateStatus==5){
			nui.confirm("投顾发起修改报量投顾复核不通过!您可以点击确认再次通知投顾修改报价，或者点【取消】调整中标确认信息！","系统提示",function(action){
				if(action=="ok"){
					noticeAdviser(json);
				}
			});
			return false;
		}
     }
     //报量报价验证不通过 处理报量修改状态
     function openUpdateReport(str){
     	var cReportUpdateStatus=nui.get("cReportUpdateStatus").getValue();
     	
     	var form = new nui.Form("#dataform1");
		 //序列化成JSON
		var json = mini.encode({applyInst:form.getData(false,true).firstGradeBond}); 
     	
		//校验状态
		if(cReportUpdateStatus=="0" || cReportUpdateStatus=="6"){
			nui.confirm(str+",是否修改报量信息?","系统提示",function(action){
				if(action == "ok"){
					 //获取流程参数
					 var lBizId = nui.get("lBizId").getValue();
					 var processinstid = nui.get("processinstid").getValue();
					 //打开修改报量界面
					 nui.open({
				        url: "<%=request.getContextPath() %>/fm/instr/firstGradeDebt/updateReportSub.jsp",
				        title: "中标确认修改报量子流程", width: 750, height: 530,
				        onload: function () {
				            //弹出页面加载完成
				            var iframe = this.getIFrameEl();
				            var data = {pageType:"add",processInstID:processinstid,bizId:lBizId,applyInst:form.getData(false,true).firstGradeBond};//传入页面的json数据
				            iframe.contentWindow.setFormData(data);
				        },
				        ondestroy: function (action) {//弹出页面关闭前
				        
				        }
				     });
				}
			});
		}else if(cReportUpdateStatus==1){
			nui.alert("已通知投顾修改报量，但投顾尚未在投资指令/建议中修改报价信息!");
		}else if(cReportUpdateStatus==2){
			nui.alert("投顾已修改报量，但尚未审批完成!");
		}else if(cReportUpdateStatus==3){
			nui.confirm("投顾发起修改报量风控审批不通过!您可以点击确认再次通知投顾修改报价，或者点【取消】调整中标确认信息！","系统提示",function(action){
			noticeAdviser(json);
			});
		}else if(cReportUpdateStatus==4){
			nui.confirm("投顾发起修改报量委托人审批不通过!您可以点击确认再次通知投顾修改报价，或者点【取消】调整中标确认信息！","系统提示",function(action){
			noticeAdviser(json);
			});
		}else if(cReportUpdateStatus==5){
			nui.confirm("投顾发起修改报量投顾复核不通过!您可以点击确认再次通知投顾修改报价，或者点【取消】调整中标确认信息！","系统提示",function(action){
			noticeAdviser(json);
			});
		}
	 	 
     }
     //通知投顾修改报价
     function noticeAdviser(json){
     	form.loading();//加载遮罩
		//提交
		nui.ajax({
		    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.noticeAdviser.biz.ext",
		    type: "post",
		    data: json,
		    dataType:"json",
		    success: function (text) {
		    	form.unmask();//取消遮罩
		    	var returnJson = nui.decode(text);
		    	if(returnJson.ret==0){
		    		nui.alert("成功通知投顾修改报量！");
		    	}else{
		    		nui.alert("保存缴款信息失败！，请联系管理员");
		    	}
		    	
		    }
		});
     }
     //判断投标利率是否大于中标利率(票面利率)
     function  judgeInterestRate(){
     	var enInterestRate = nui.get("enInterestRate").getValue();		//投标利率
 		var enCouponRate = nui.get("enCouponRate").getValue();			//票面利率
     	if(enCouponRate.toString()!="" && enInterestRate.toString()!=""){
	     	//判断投标利率是否大于中标利率(票面利率)
			if(enInterestRate > enCouponRate){
				openUpdateReport("投标利率大于中标利率");
				return false;
			}else{
				return reportUpdateStatusAlert();
			}
		}else{
 			//缴款金额或者投标金额 为空则不允许继续提交
 			nui.alert("投标利率和中标利率不允许为空");
 			return false;
 		}
     }
     
     function processSubmit(){
        //获取当前操作时间
     	var dCurOperateTime = "<b:write property="firstGradeBond/dCurOperateTime" />";
     	nui.ajax({
		    url: "com.cjhxfund.ats.fm.comm.common.getDate.biz.ext",
		    type: "post",
		    dataType:"json",
		    success: function (text) {
		    	var returnJson = nui.decode(text);
		    	//判上一环节前操作时间是否大于当前服务器时间,大于时不允许提交
     			if(checkdate(dCurOperateTime,returnJson.dateTime) == false){
     				return
     			}else{
     			    var typeText = nui.get("operateType").getSelected().text;
			        nui.confirm("确认是否提交流程--"+typeText+"？","系统提示",function(action){
					if(action == "ok"){
					    //提交审批意见校验
						 if(checkForm()==false){
						 	return;
						 }
			    		var form = new nui.Form("#dataform1");
			    		var operateType = nui.get("operateType").getValue();
			    		//var lFixValidStatus = nui.get("lFixValidStatus").getValue();
			    	  	//设置路径
					  	urlStr = contextPath + "/com.cjhxfund.ats.fm.instr.firstGradePayment.firstGradePaymentHandle.biz.ext";
					  	//操作为同意时调用
					  	if(operateType == 1){
					  		//校验必须文本框是否输入
					  		form.validate();
				        	if(form.isValid()==false){
				           		nui.alert("业务信息必填项不能为空，请输入。","系统提示");
				           		return;
				        	}					        	
					  	}else if(operateType == 2){
			        	  	 var backActivity = nui.get("backActivity").getValue();
			        	  	 if(backActivity == ""){
			        	  	   nui.alert("当操作为退回时,必须选择退办节点。","系统提示");
			        	  	   return;
			        	  	 }
			        	}  
			        	var bpsParam1=form.getData(false,true).bpsParam;
			        	var pmprcaprvinfo1=form.getData(false,true).pmprcaprvinfo;
						/**--------------------------组装数据----------------------------**/
						if(activityDefID!="ATS_FM_TGLR" && activityDefID!="ATS_FM_TGFH" && activityDefID!="ATS_FM_WTRFH"){
							bpsParam1.FaxNumber = nui.get("FaxNumber").getText();
							var FaxNumber =nui.get("FaxNumber").getText().split(",");
								if(bpsParam1.FaxNumber!="" && bpsParam1.FaxNumber!=null){
									var checkFax = /^((\d{3,4}-)?\d{7,8})(\d{7,8})?$/;
							    	for(var i=0;i<FaxNumber.length;i++ ){
							    	    if(!checkFax.test(FaxNumber[i])){
											nui.alert("传真格式为:XXX-12345678或XXXX-1234567或XXXX-12345678或12345678,多个传真号时，用英文逗号分隔","系统提示");
											return;
									     }
							    	} 
						    	}
						    bpsParam1.vcTelephoneNumber =nui.get("vcTelephoneNumber").getText();
						    var phoneNumber =nui.get("vcTelephoneNumber").getText().split(",");
							if(bpsParam1.vcTelephoneNumber!="" && bpsParam1.vcTelephoneNumber!=null){
						    	var checkPhone = /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
						    	for(var i=0;i<phoneNumber.length;i++ ){
						    	    if(!checkPhone.test(phoneNumber[i])){
										nui.alert("联系电话格式不正确,多个号码时，用英文逗号分隔","系统提示");
										return;
						            }
						    	} 
						    }
						}
						var applyInst1=form.getData(false,true).firstGradeBond;
			        	//债券占比
			        	applyInst1.enNetScale = nui.get("enNetScale").getValue().replace(/,/gi,'');  				//净值规模
                        bpsParam1.enCategoryMoney = nui.get("fsumamount").getValue().replace(/,/gi,'');      		//债券存量
                        applyInst1.enInvestScaleRatio=nui.get("enInvestScaleRatio").getValue();
                        applyInst1.enIssuerNetRatio=nui.get("enIssuerNetRatio").getValue();
                        applyInst1.enInvestNetRatio=nui.get("enInvestNetRatio").getValue();
                        applyInst1.enWeakNetRatio=nui.get("enWeakNetRatio").getValue();
						//组装参数		
						data = {
							workItemID:nui.get("workItemID").getValue(),
							pmprcaprvinfo:pmprcaprvinfo1,
							bpsParam:bpsParam1,
							applyInst:applyInst1,
							userTempData:form.getData(false,true).userTempData
						};
						
						//判断当前环节为信息核对(交易员1)
						if(activityDefID == "ATS_FM_PDFXYYY"){
					   		if(operateType == 1){    //判断操作为同意时
					     	//设置路径
					     	//判断id是否为空，为空给出提示是否提交，不为空时提示选择了几个附件
						     var SysId = "";
						      	//判断当前环节上传附件后获取附件列表，并判断有没有选择需要用印的附件
						      	var attachments = nui.get("file_grid").getData();
								for(var i = 0;i<attachments.length;i++){
								  if(attachments[i].vcAnnexSeal == 1){
								  	 if(SysId == ""){
								  	 	SysId = attachments[i].lAttachId; 
								  	 }else{
								  	 	SysId = SysId + "," + attachments[i].lAttachId;
								  	 }
								  }
								}
								var yn = nui.get("yn").getValue();
								if(yn==1){
							      	//判断是否选择需要用印的附件
							      	if(SysId != ""){
							          	//组装参数		
									 	data = {
											workItemID:'<%=workItemID %>',
											bpsParam:bpsParam1,
											applyInst:applyInst1,
											pmprcaprvinfo:pmprcaprvinfo1,
											attachments:attachments,
											userTempData:form.getData(false,true).userTempData};
											
							          	var Array = String(SysId).split(",");
								     	nui.confirm("已选择" + Array.length + "个需要用印的协议附件，确认是否提交！","系统提示",function(action){
								          	if(action == "ok"){
								             	saveData(data,urlStr);
								          	}else{
								            	return;
								          	}
								      	});
							   	  	}else{
							   	   		nui.confirm("没有选择需要用印的协议附件，确认是否提交！","系统提示",function(action){
									   	   	if(action =="ok"){
									          	saveData(data,urlStr);
									       	}else{
									         	return;
									       	}   
							        	});
							      	}
						      	}else{
						      	   saveData(data,urlStr);
						      	}
						   	}else{
					     		saveData(data,urlStr);
					   		}   
					   	}else{
					     	saveData(data,urlStr);
					   	} 
					}
				});	
     			}
		    }
		});
  	}
    
    //校验传真号格式
    function checkFax(e){
    	var checkFax = /^((\d{3,4}-)?\d{7,8})(\d{7,8})?$/; 
		if(!checkFax.test(e.value)){
			nui.alert("传真格式为:XXX-12345678或XXXX-1234567或XXXX-12345678或12345678","系统提示");
			return false;
		}
		return true;	
    }
    
    //默认加载审核信息
    var operateText = nui.get("operateType").getSelected().text;
	nui.get("comments").setValue(operateText);
    
    
    function onDrawDate(e) {
		//得到日期值并转化成日期格式，replace(/\-/g, "\/")是根据验证表达式把日期转化成长日期格式，这样
		//再进行判断就好判断了
		var sDate = nui.get("dPaymentDate").getValue().replace(/\-/g, "\/").substr(0,10);
		var myDate = getNowFormatDate();
		var eDate = myDate.replace(/\-/g, "\/");
		
		if(sDate < eDate){
			nui.alert("缴款日期不能小于当前系统时间，请重新选择。","系统提示");
			return false;
		}else{
			return true;
		}
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
	
//风控试算
	function windControlTrial(){
		var form = new nui.Form("#dataform1");
		var applyInst1=form.getData(false,true).firstGradeBond;
		var PcMarketNo=applyInst1.vcPaymentPlace;
 		//债券表登记托管机构转换
 		if(PcMarketNo==3){
	        PcMarketNo=1;
	    }else if(PcMarketNo==4){
	        PcMarketNo=2;
	     }else{
	        PcMarketNo=5;
	     }
	    applyInst1.cMarketNo=PcMarketNo;//交易市场
	    applyInst1.vcBusinessObject=nui.get("hlRivalId").getValue();//交易对手需要传ID
		//序列化成JSON
		var json = mini.encode({applyInst:applyInst1}); 
		
		form.loading();//加载遮罩
		//提交
		nui.ajax({
		    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.windControlTrial.biz.ext",
		    type: "post",
		    data: json,
		    dataType:"json",
		    success: function (text) {
		    	var returnJson = nui.decode(text);
		    	form.unmask();//取消遮罩
		    	if(returnJson.returnCode == "4"){
		    	    var userName='<%=userId %>';          //拼音ID
                    //获得当前参与者
					var json = nui.encode({userId:userName});
					$.ajax({
						url:"com.cjhxfund.ats.fm.instr.FirstGradeBond.isDealer.biz.ext",
						type:'POST',
						data:json,
						cache:false,
						async:false,
						contentType:'text/json',
						success:function(text){
					       //1为交易员
				           if(text.isInvestment==1){
					           nui.confirm("O32没有该债券，是否将债券推送至待导出O32列表！","系统提示",function(action){
				    				if(action=="ok"){
				    					var lStockIssueId=nui.get("stockissueinfo.lStockIssueId").getValue();
				    					//调用推送喔O32方法
				    					exportTempUtil(lStockIssueId);
				    				}
	    						});
	    						return;
					        }else{
					    	   nui.alert(returnJson.rtnMsg,"系统提示");
					           return;
	    					}
						}
					});		 
		    	}else if(returnJson.returnCode == 0){
		    	 	nui.alert("风控试算成功,未触发风控。","系统提示");
		    	 	return;
		    	}else if (returnJson.returnCode == -1){
		    			nui.alert(returnJson.rtnMsg,"系统提示");
		    			return;
		    	}else if(returnJson.returnCode != 0){
		    		if(checkRiskRet(returnJson.riskMsg)==false){
			    			return;
			    	}
	    			nui.open({
	    	  			url: "<%=request.getContextPath() %>/fix/riskApiControlDetailList.jsp",
	                    title: "风控试算反馈消息展示", width: 800, height: 390,
	                    onload: function () {
	                        //弹出页面加载完成
		                    var iframe = this.getIFrameEl();
		                    iframe.contentWindow.SetData(returnJson.riskMsg,3);
	                    },
	                    ondestroy: function (action) {//弹出页面关闭前
		                 
	                	}
	    	  		});
		    		
		    	}
		    }
		});
		
	} 

function loadVcNetScale(){
	//从O32加载产品净值规模相关信息
	var lIssuerId= "<b:write property="firstGradeBond/lIssuerId" />";
	var vcProductCode=nui.get("vcProductCode").getValue();
	if(lIssuerId=="" || vcProductCode==""){
		return;
	}
	var json = nui.encode({vcProductCode:vcProductCode,lIssuerId:lIssuerId});
	$.ajax({
		url:"com.cjhxfund.ats.fm.instr.atsFmBiz.getVfundasset.biz.ext",
		type:'POST',
		data:json,
		cache:false,
		contentType:'text/json',
		success:function(text){
			if(text.returnCode == 1 && text.returnValue != ""){
				nui.alert(text.returnValue,"系统提示");
				return;
			}
			if(text.returnCode == 2 && text.returnValue != ""){
				nui.alert(text.returnValue,"系统提示");
				return;
			}
			if((text.enFundValue!=null || text.fsumamount!=null) && text.applyInsts!=null){
				if(text.enFundValue[0] != undefined && text.enFundValue[0].ENFUNDVALUE!=null && text.enFundValue[0].ENFUNDVALUE!=""){
				    if(text.enFundValue[0].ENFUNDVALUE != 0){
						nui.get("enNetScale").setValue(text.enFundValue[0].ENFUNDVALUE/10000);
						//设置净值规模隐藏提交值
						nui.get("enNetScale1").setValue(text.enFundValue[0].ENFUNDVALUE/10000);
						formatNumberCommon("enNetScale",4);	
					}else{
						nui.get("enNetScale").setValue(0);
					}
				}else{
					nui.get("enNetScale").setValue(0);
				}

				if(text.fsumamount[0] != undefined && text.applyInsts[0] != undefined){						
					if(text.fsumamount[0].FSUMAMOUNT != null){
						nui.get("fsumamount").setValue(text.fsumamount[0].FSUMAMOUNT);
					}else{
						nui.get("fsumamount").setValue(0);
					}
				}else{
				 	nui.get("fsumamount").setValue(0);
				}
			}else{
				nui.get("fsumamount").setValue(0);
				
				nui.get("enNetScale").setValue(0);
			}
			BondAccountedCalculation();
		}
	});

}

//人工风控控制计算比例值
function BondAccountedCalculation(){
	var enIssueBalance = nui.get("enIssueBalance").getValue().replace(/,/gi,'');        //发行规模
    /* var enInvestBalance = nui.get("vcInvestBalance").getValue().replace(/,/gi,''); 	    //投标金额 */
    var enPayFaceValue = nui.get("enPayFaceValue").getValue().replace(/,/gi,''); 	    //缴款面值
    var enNetScale = nui.get("enNetScale").getValue().replace(/,/gi,'');  				//净值规模
    var enCategoryMoney = nui.get("fsumamount").getValue().replace(/,/gi,'');      		//债券存量
       		
    //当缴款面值与发行规模不为空时计算该笔债券投资占发行规模比例
	//公式为缴款面值/发行规模
	 if(enIssueBalance != "" && enIssueBalance != "" && enIssueBalance != 0 && enPayFaceValue != 0 && enPayFaceValue != 0){
	   nui.get("enInvestScaleRatio").setValue(((enPayFaceValue/(enIssueBalance * 10000)) * 100).toFixed(6));
	}else{
	   nui.get("enInvestScaleRatio").setValue(0);
	}
	       
	//当缴款面值、债券存量与净值规模都不为空并且都不为0时计算同一发行人占产品净值规模比例
	//公式为(本次缴款面值+主体发行债券存量)/净值规模
	if(enNetScale != "" && (enPayFaceValue != "" || enCategoryMoney != "")){
	    if(enNetScale != 0){
	       nui.get("enIssuerNetRatio").setValue((((Number(enPayFaceValue) + Number(enCategoryMoney))/enNetScale) * 100).toFixed(6));
	    }
	}else{
	   nui.get("enIssuerNetRatio").setValue(0);
	}
	       
	//当净值规模与投标金额不为空并且不为0时计算该笔债券投资占产品净值规模比例
	//公式为投标金额/净值规模
	if(enNetScale != "" && enPayFaceValue != "" && enNetScale !=0 && enPayFaceValue != 0){
	   nui.get("enInvestNetRatio").setValue(((enPayFaceValue/enNetScale) * 100).toFixed(6));
	}else{
	   nui.get("enInvestNetRatio").setValue(0);
	}	
}
	
	function vcTransactionType(){
		var vcTransactionType = nui.get("vcTransactionType").getValue();
		if(vcTransactionType == 3){
			document.getElementById("label1").style.display="inline";
			document.getElementById("label2").style.display="inline";
			document.getElementById("label3").style.display="inline";
		}else{
			document.getElementById("label1").style.display="none";
			document.getElementById("label2").style.display="none";
			document.getElementById("label3").style.display="none";
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
		//计算千分位
		formatNumberCommon("payFaceValue",4);
		formatNumberCommon("paymentMoney",4);
		//获取回退的实例对象
		loadActivities();
		//债券类别为可转债时，显示股票名称，股票代码，抵押股票数量
		onAccountTypeChanged();
		function inIt(){
			//缴款面值加千分位
			//payFaceValueFun();
			//缴款金额(万元)加千分位
			paymentMoneyFun();
			//中签数量加入千分位
			//formatNumberCommon("vcBallotNumber",0);  
			
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
		//inIt();
		
		//调用附件查询方法
     	loademployeeGrid("file_grid","#file_Form");	
     	var columns = file_grid.columns;
     	if(activityDefID == "ATS_FM_XXHD1" || activityDefID == "ATS_FM_XYYYPD" || activityDefID == "ATS_FM_PDFXYYY"){
     		columns[columns.length - 1].header = "<label style='color: red;'>是否需要归档</label>";
     		columns[columns.length - 2].readOnly = true;
     		columns[columns.length - 3].header = "<label style='color: red;'>是否需要用印</label>";
     	}else{
     		columns[columns.length - 3].readOnly = true;
     		columns[columns.length - 2].readOnly = true;
     		columns[columns.length - 1].readOnly = true;
     	}
     	
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
	    var lStockIssueId= nui.get("stockissueinfo.lStockIssueId").getValue();
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
	</script>
</body>
</html>