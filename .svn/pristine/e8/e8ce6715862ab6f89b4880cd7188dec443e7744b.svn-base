<%@page import="com.cjhxfund.ats.fm.commonUtil.JDBCUtil"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<%--
- Author(s): 石浩
- Date: 2016-08-17 17:40:16
- Description:
 --%>
 <%
 	long key = JDBCUtil.getNextSequence("SEQSTOCKISSUENO");
  %>
    <head>
              <title>
           	 新债录入
        </title>
    </head>
    <body style="width: 100%;height: 100%;overflow: hidden;">
        <div id="tabs" class="nui-tabs" style="width: 100%;height: 95%;">
           <div title="基本信息" >
              <div id="dataform1" style="padding-top:5px;">
              	
	            <!-- 业务子表参数 -->
	            <table style="width:100%;height:50%;table-layout:fixed;" class="nui-form-table" id="debtIssueTable">
	                <tr>
	                	 <td class="form_label" align="right" width="20%">
	                          <span style="color:red">*</span>&nbsp;登记托管机构:
	                    </td>
	                    <td colspan="1"  width="30%">
	                        <input class="nui-dictcombobox" 
	                        dictTypeId="CF_JY_DJTGCS" valueField="dictID" textField="dictName"
	                        required="true"  name="debtIssue.vcPaymentPlace" 
	                         id="vcPaymentPlace" width="90%" onvaluechanged="onMarketNoChanged"/>
	                    </td>
	                    <td class="form_label" align="right" width="15%">
	                        	利率类型:
	                    </td>
	                    <td colspan="1"  width="30%">
	                    	 <input class="nui-dictcombobox" dictTypeId="rateType" 
	                    	 width="90%" id="cInterestType" name="debtIssue.cInterestType" 
	                    	  />
	                    </td>
	                </tr>
	                <tr>
	                  <td class="form_label" align="right">
	                       	 <span style="color:red">*</span>&nbsp;债券类别:
	                  </td>
	                  <td colspan="1">
	                      <!-- <input class="nui-combobox"  width="90%" id="vcStockType" required="true"  name="debtIssue.vcStockType" 
	                      url="com.cjhxfund.ats.fm.baseinfo.stockTypeManager.getStockTypes.biz.ext"  textField="vcStocktypeName" valueField="cStockType"
	                     	     dataField="stockTypes"/> -->
	                      <input style="width: 90%;" required="true" id="vcStockType" name="debtIssue.vcStockType" class="mini-treeselect"  multiSelect="false" 
										        textField="text" valueField="id" parentField="pid" checkRecursive="false"  
										        expandOnLoad="true" showTreeIcon="false" showFolderCheckBox="true" onbeforenodeselect="beforenodeselect"
										        oncloseclick="onCloseClickValueEmpty"  onvaluechanged="cheangedVcStockType"/>
	                  </td>
	                  <td class="form_label" width="23%" align="right">
	                        	息票品种:
	                  </td>
	                  <td colspan="1">
	                   	<input class="nui-dictcombobox"  dictTypeId="payInterestType" width="90%" id="cPayInterestType" name="debtIssue.cPayInterestType" 
	                   	   onvaluechanged="changeEnPayInteval" />
	                  </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                       	债券代码:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-textbox" id="vcStockCode"  width="90%" name="debtIssue.vcStockCode"/>
	                    </td>
	                    <td class="form_label" align="right">
	                        	付息频率(次/年):
	                    </td>
	                    <td colspan="1">
	                        <!-- <input class="nui-textbox" id="enPayInteval" required="true" vtype="float" onblur="check(this);" width="90%" name="debtIssue.enPayInteval"/> -->
	                        <input class="nui-dictcombobox" allowInput="true" dictTypeId="ATS_CF_JY_FREQUENCY" vtype="float" onblur="checkFXPL(this);"  width="90%" id="enPayInteval" name="debtIssue.enPayInteval" onvaluechanged="checkCPayInterestType"/>
	                    </td>
	                </tr>
	                <tr>
	                     <td class="form_label" align="right">
	                       	债券简称:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-textbox" id="vcStockName" width="90%" name="debtIssue.vcStockName"/>
	                    </td>
	                    <td class="form_label  requiredLable" align="right">
	                          <label style="color:red">*</label>&nbsp;债券评级:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="creditRating" required="true" id="cBondAppraise" width="90%" name="debtIssue.cBondAppraise"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                           <span style="color:red">*</span>&nbsp;债券全称:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-textbox" id="vcStockNameFull" required="true" width="90%" name="debtIssue.vcStockNameFull"/>
	                    </td>
	                    <td class="form_label requiredLable" align="right">
	                       	<label  style="color:red">*</label>&nbsp;债券评级机构:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="outRatingOrgan" required="true" width="90%" id="vcBondAppraiseOrgan" name="debtIssue.vcBondAppraiseOrgan" />
	                    </td>
	                </tr>
	                <tr id="tr1">
	                    <td class="form_label" align="right">
	                          <span style="color:red">*</span>&nbsp;发行规模(亿):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox"  required="true" vtype="float" onblur="check(this)" name="debtIssue.enIssueBalance" id="enIssueBalance" width="90%" />
	                    </td>	                    
	                    <td class="form_label" align="right">
	                          <span style="color:red">*</span>&nbsp;发行期限(年):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" vtype="float" onblur="check(this)" required="true" name="debtIssue.enExistLimite" id="enExistLimite" width="90%" />
	                    </td>
	                </tr>
	                <tr id="morStockNameAndCode">
	                    <td class="form_label  lableReq" align="right">
	                          <label style="color:red">*</label>&nbsp;股票名称:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="debtIssue.vcMortStockName" id="vcMortStockName" width="90%" />
	                    </td>	                    
	                    <td class="form_label  lableReq" align="right">
	                          <label style="color:red">*</label>&nbsp;股票抵押数量(万股):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="debtIssue.vcMortStockAmount" onblur="check(this)" vtype="float" id="vcMortStockAmount" width="90%" />
	                    </td>
	                </tr>
	                <tr id="morStockAmount">
	                    <td class="form_label   lableReq" align="right">
	                         <label style="color:red">*</label>&nbsp; 股票代码:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="debtIssue.vcMortStockCode" id="vcMortStockCode" width="90%" />
	                    </td>	                    
	                </tr>
	                 <tr id="tr1">
	                   <td class="form_label" align="right">
	                        	发行规模描述:
	                    </td>
	                    <td colspan="3">
	                    	<input class="nui-textarea" id="vcExistLimiteDesc" name="debtIssue.vcExistLimiteDesc" width="96%"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                       	 公告日期:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-datepicker"  name="lIssuePostDate" id="lIssuePostDate" style="width: 90%;"  />
	                    </td>
	                    <td class="form_label" align="right">
	                         <span style="color:red">*</span>&nbsp;主体简称:
	                    </td>
	                    <td colspan="1" >
						     <input id="lookup2" style="width: 90%;" name="debtIssue.lIssuerId" class="mini-lookup"  
						        textField="vcIssueName" valueField="lIssuerId" popupWidth="auto"  
						        popup="#gridPanel" data="data"  onvalidation="onIssuerId" grid="#datagrid1" required="true" multiSelect="false" onclick="onClearClick();onSearchClick()" />
						     
						     <div id="gridPanel" class="mini-panel" title="header" iconCls="icon-add" style="width:450px;height:250px;" 
						        showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0" borderStyle="border:0" >
						        <div property="toolbar" style="padding:5px;padding-left:8px;text-align:center;">   
						            <div style="float:left;padding-bottom:2px;">
						                <span>发行主体：</span>                
						                <input id="keyText" class="mini-textbox" style="width:160px;" value="" onenter="onSearchClick()"/>
						                <a class="mini-button" onclick="onSearchClick">查询</a>
						                <a class="mini-button" id="add" iconCls='icon-add' onclick="onAddClick">添加</a>
						            </div>
						            <div style="float:right;padding-bottom:2px;margin-right:14px;">
						            </div>
						            <div style="clear:both;"></div>
						        </div>
						        <div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;" 
						            borderStyle="border:0" showPageSize="false" showPageIndex="false" 
						            url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadIssueInfo.biz.ext" onRowdblclick="dbClick2" onclick="enterSumbit()">
						            <div property="columns" >
						                <div field="vcIssueName" width="50" headerAlign="center" allowSort="true">简称</div>
						                <div field="vcIssueNameFull" width="70" headerAlign="center" allowSort="true">全称</div>
						            </div>
						        </div>  
						      </div>
					     </td>
	                </tr>
	                
	                 <tr>
	                    <td class="form_label" align="right">
	                       	 发行日期:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-datepicker" name="lIssueBeginDate" id="lIssueBeginDate" style="width: 90%;"  />
	                    </td>
	                    <td class="form_label" align="right">
	                          <span style="color:red">*</span>&nbsp;主体全称:
	                    </td>
	                    <td colspan="1">
	                    	 <input class="nui-hidden" readonly="true"  inputStyle="background-color:#f0f0f0;" id="vcIssuerName" width="90%" name="debtIssue.vcIssuerName"/>
	                    	 <input class="nui-textbox" required="true" readonly="true"  inputStyle="background-color:#f0f0f0;" id="vcIssuerNameFull" width="90%" name="debtIssue.vcIssuerNameFull"/>
	                    </td>
	                </tr>
	                
	                <tr>
	                 	<td class="form_label" align="right">
	                       	 上市日期:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-datepicker" name="lPublishDate" id="lPublishDate" style="width: 90%;"  />
	                    </td>
	                     <td class="form_label requiredLable" align="right">
	                           <label  style="color:red">*</label>&nbsp;主体评级:
	                    </td>
	                    <td colspan="1">
	                    	<input required="true"  textField="dictName" valueField="dictID" class="nui-dictcombobox"  dictTypeId="issuerRating" width="90%" id="cIssueAppraise" value="" name="debtIssue.cIssueAppraise" showNullItem="false"/>
	                    </td>
	                 </tr>
	                 
	                 <tr>
	                  	<td class="form_label" align="right">
	                       	 起息日期:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-datepicker" name="lBegincalDate" id="lBegincalDate" style="width: 90%;"  />
	                    </td> 
	                    <td class="form_label" align="right">
	                                                                                    主体类型:
	                    </td>
	                    <td colspan="1">
	                    	<input  class="nui-dictcombobox"  dictTypeId="ATS_FM_ISSUE_PROPERTY" width="90%" id="vcIssueProperty"  name="debtIssue.vcIssueProperty" showNullItem="false"/>
	                    </td>
	                </tr>
	                
	                
	                <tr>
	                	<td class="form_label" align="right">
	                       	 到期日期:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-datepicker" name="lEndincalDate" id="lEndincalDate" style="width: 90%;"  />
	                    </td>
	                    
	                    <td class="form_label" align="right">
	                                                                                    主体评级机构:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox"   dictTypeId="outRatingOrgan" width="90%" id="vcIssueAppraiseOrgan" name="debtIssue.vcIssueAppraiseOrgan" showNullItem="false"/>
	                    </td>
	                </tr>
	               
	                <tr>
	                    <td class="form_label" align="right">
	                       	 缴款日期:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-datepicker" name="lPayDate" id="lPayDate" style="width: 90%;"  />
	                    </td>
	                    <td class="form_label" align="right">
	                                                                                    所属行业:
	                    </td>
	                    <td colspan="1">
	                     	<!-- <input class="nui-textbox"  id="vcIndustry"  width="90%"   name="debtIssue.vcIndustry"/> -->
	                     	<input style="width: 90%;" id="vcIndustry" name="debtIssue.vcIndustry" class="mini-treeselect"  multiSelect="false" 
										        textField="text" valueField="id" parentField="pid" checkRecursive="false" virtualScroll="true" 
										        expandOnLoad="true" showTreeIcon="false" showFolderCheckBox="true" allowInput="true"
										        onvalidation="onComboValidation"/>
	                    </td>
	                </tr>
	                 <tr>
	                    <td class="form_label" align="right">
	                       	 发行方式:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-dictcombobox" dictTypeId="issueType" name="debtIssue.vcIssueType" id="vcIssueType" style="width: 90%;"  />
	                    </td>
	                    <td class="form_label" align="right">
	                       	 所属省份:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-textbox"  id="vcProvince" width="90%"  name="debtIssue.vcProvince"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                       	 所属行业(证监会二级):
	                    </td>
	                    <td colspan="1"> 
	                        <input style="width: 90%;" id="vcIssueAppraiseCsrc" name="debtIssue.vcIssueAppraiseCsrc" class="mini-treeselect"  multiSelect="false" 
										        textField="text" valueField="id" parentField="pid" checkRecursive="false" virtualScroll="true" 
										        expandOnLoad="true" showTreeIcon="false" showFolderCheckBox="true" allowInput="true"
										        oncloseclick="onCloseClickValueEmpty" onvalidation="onComboValidation"/>
	                    </td>
	                    <td class="form_label" align="right">
	                       	 城投行政级别:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-dictcombobox" dictTypeId="cityLevel" id="vcCityLevel" width="90%"  name="debtIssue.vcCityLevel"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                                                                                    票面利率(%):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="debtIssue.enFaceRate" id="enFaceRate" width="90%"/>
	                    </td>
	                    <td class="form_label" align="right">
	                       	 公司净资产(元):
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-textbox"  vtype="float" onblur="check(this)" id="enIssuerNetValue" width="90%"  name="debtIssue.enIssuerNetValue"/>
	                    </td>
	                </tr>
	                <tr>
	                     <td class="form_label" align="right">
	                                                                                    主承销商:
	                    </td>
	                    <td colspan="3" >
						     <input style="width: 92%;" class="nui-textbox"  id="vcMainUnderwriter" name="debtIssue.vcMainUnderwriter"/>
						     <input style="width: 92%;" class="nui-hidden"  id="vcMainUnderwriterId" name="debtIssue.vcMainUnderwriterId"/>
						     <input id="lookup3" style="width: 25px;" class="mini-lookup" onvalidation="onIssuerId3"
						        textField="vcMainUnderwriter" valueField="vcMainUnderwriterId" popupWidth="auto"  
						        popup="#gridPanel3" data="data"  grid="#datagrid3" multiSelect="true" onclick="onClearClick3();onSearchClick3();" />
						     
						     <div id="gridPanel3" class="mini-panel" title="header" iconCls="icon-add" style="width:450px;height:250px;" 
						        showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0" borderStyle="border:0" >
						        <div property="toolbar" style="padding:5px;padding-left:8px;text-align:center;">   
						            <div style="float:left;padding-bottom:2px;">
						                <span> 主承销商：</span>                
						                <input id="keyText3" class="mini-textbox" value="" style="width:170px;" onenter="onSearchClick3"/>
						                <a class="mini-button" onclick="onSearchClick3">查询</a>
						                <!-- <a class="mini-button" id="add" iconCls='icon-add' onclick="onAddClick">添加</a> -->
						            </div>
						            <div style="float:right;padding-bottom:2px;margin-right:14px;">
						            </div>
						            <div style="clear:both;"></div>
						        </div>
						        <div id="datagrid3"   class="mini-datagrid" style="width:100%;height:100%;" 
						            borderStyle="border:0" showPageSize="false" showPageIndex="false"
						            url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.loadUnderwriter.biz.ext" onRowdblclick="dbClick3">
						            <div property="columns" >
						                <div type="checkcolumn"></div>
						                <div field="vcMainUnderwriterAbbr" width="50"    headerAlign="center" allowSort="true">简称</div>
						                <div field="vcMainUnderwriter" width="70" headerAlign="center" allowSort="true">全称</div>
						            </div>
						        </div>  
						      </div>
					     </td>
	                </tr>
	                
	                 <tr>
	                     <td class="form_label" align="right">
	                                                                                    副主承销商:
	                    </td>
	                    <td colspan="3">
	                        <input style="width: 92%;" class="nui-textbox"  id="vcDeputyUnderwriter" name="debtIssue.vcDeputyUnderwriter"/>
	                        <input style="width: 92%;" class="nui-hidden"  id="vcDeputyUnderwriterId" name="debtIssue.vcDeputyUnderwriterId"/>
	                        <input id="lookup4" style="width: 25px;" class="mini-lookup"  onvalidation="onIssuerId4"
						        textField="vcMainUnderwriter" valueField="vcMainUnderwriterId" popupWidth="auto"  
						        popup="#gridPanel4" data="data"  grid="#datagrid4" multiSelect="true"  onclick="onClearClick4();onSearchClick4()"/>
						     
						     <div id="gridPanel4" class="mini-panel" title="header" iconCls="icon-add" style="width:450px;height:250px;" 
						        showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0" borderStyle="border:0" >
						        <div property="toolbar" style="padding:5px;padding-left:8px;text-align:center;">   
						            <div style="float:left;padding-bottom:2px;">
						                <span>副主承销商：</span>                
						                <input id="keyText4" class="mini-textbox" style="width:145px;" value="" onenter="onSearchClick4"/>
						                <a class="mini-button" onclick="onSearchClick4">查询</a>
						                <!-- <a class="mini-button" id="add" iconCls='icon-add' onclick="onAddClick">添加</a> -->
						            </div>
						            <div style="float:right;padding-bottom:2px;margin-right:14px;">
						            </div>
						            <div style="clear:both;"></div>
						        </div>
						        <div id="datagrid4"   class="mini-datagrid" style="width:100%;height:100%;" 
						            borderStyle="border:0" showPageSize="false" showPageIndex="false"
						            url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.loadUnderwriter.biz.ext" onRowdblclick="dbClick4">
						            <div property="columns" >
						                <div type="checkcolumn"></div>
						                <div field="vcMainUnderwriterAbbr" width="50"    headerAlign="center" allowSort="true">简称</div>
						                <div field="vcMainUnderwriter" width="70" headerAlign="center" allowSort="true">全称</div>
						            </div>
						        </div>  
						      </div>
	                    </td>
	                </tr>
	                <tr>
	                     <td class="form_label" align="right">
	                       	缴款方式:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-dictcombobox" dictTypeId="ATS_FM_PAYMENT" width="90%" id="cPayType" name="debtIssue.cPayType" showNullItem="false"/>
	                    </td>
	                     <td class="form_label" align="right">
	                          	承销方式:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox"  dictTypeId="underwriteType" width="90%" id="cUnderwriteType" name="debtIssue.cUnderwriteType" showNullItem="false"/>
	                    </td>
	                </tr>
	                <tr>
	                	<td class="form_label" align="right">
	                       	投标截止时间:
	                    </td>
	                    <td colspan="1"> 
	                    	<input class="nui-datepicker" name="debtIssue.dBidLimitTime"  id="dBidLimitTime" style="width: 100px;"  />
	                    	<input style="width: 40px;" url="<%=request.getContextPath() %>/fm/instr/processUtil/timeHH.txt" class="nui-dictcombobox" id="dApplicationTimeHH" />时
			    			<input style="width: 40px;" url="<%=request.getContextPath() %>/fm/instr/processUtil/timeMM.txt" class="nui-dictcombobox" id="dApplicationTimeMM" />分
	                    </td>
	                	<td class="form_label" align="right">
	                                                                                    投标区间:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="debtIssue.vcTenderInterval" id="vcTenderInterval" width="90%" />
	                    </td>
	                </tr>
	                <tr id="tr1">
	                   <td class="form_label" align="right">
	                        	发行日期描述:
	                    </td>
	                    <td colspan="3">
	                    	<input class="nui-textarea" id="vcIssueBeginDateDesc" name="debtIssue.vcIssueBeginDateDesc" width="96%"/>
	                    </td>
	                </tr>
	                <tr id="tr1">
	                   <td class="form_label" align="right">
	                        	承销商联系人信息:
	                    </td>
	                    <td colspan="3">
	                    	<input class="nui-textarea" id="vcUnderwriterInfo" name="debtIssue.vcUnderwriterInfo" width="96%"/>
	                    </td>
	                </tr>
	                <tr>
	                
	                <td class="form_label" align="right">
	                                                                                    承销团:
	                    </td>
	                     <td colspan="3">
	                        <input style="width: 92%;" class="nui-textbox"  id="vcGroupUnderwriter" name="debtIssue.vcGroupUnderwriter"/>
	                        <input style="width: 92%;" class="nui-hidden"  id="vcGroupUnderwriterId" name="debtIssue.vcGroupUnderwriterId"/>
	                        <input id="lookup6" style="width: 25px;" class="mini-lookup"  onvalidation="onIssuerId6"  
						        textField="vcMainUnderwriter" valueField="vcMainUnderwriterId" popupWidth="auto"  
						        popup="#gridPanel6" data="data"  grid="#datagrid6" multiSelect="true"  onclick="onClearClick6();onSearchClick6()"/>
						     
						     <div id="gridPanel6" class="mini-panel" title="header" iconCls="icon-add" style="width:450px;height:250px;" 
						        showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0" borderStyle="border:0" >
						        <div property="toolbar" style="padding:5px;padding-left:8px;text-align:center;">   
						            <div style="float:left;padding-bottom:2px;">
						                <span>副主承销商：</span>                
						                <input id="keyText6" class="mini-textbox" style="width:145px;" value="" onenter="onSearchClick6"/>
						                <a class="mini-button" onclick="onSearchClick6">查询</a>
						                <!-- <a class="mini-button" id="add" iconCls='icon-add' onclick="onAddClick">添加</a> -->
						            </div>
						            <div style="float:right;padding-bottom:2px;margin-right:14px;">
						            </div>
						            <div style="clear:both;"></div>
						        </div>
						        <div id="datagrid6"   class="mini-datagrid" style="width:100%;height:100%;" 
						            borderStyle="border:0" showPageSize="false" showPageIndex="false"
						            url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.loadUnderwriter.biz.ext" onRowdblclick="dbClick6">
						            <div property="columns" >
						                <div type="checkcolumn"></div>
						                <div field="vcMainUnderwriterAbbr" width="50"    headerAlign="center" allowSort="true">简称</div>
						                <div field="vcMainUnderwriter" width="70" headerAlign="center" allowSort="true">全称</div>
						            </div>
						        </div>  
						      </div>
	                    </td>
	                </tr>
	                <tr>
	                	<td class="form_label" align="right">
	                        	特殊条款:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="specialText" valueField="dictID" textField="dictName" multiSelect="true" width="90%" id="vcSpecialText" name="debtIssue.vcSpecialText" onvaluechanged="checkvcSpecialText"/>
	                    </td>
	                </tr>
	                 <tr id="tr1">
	                   <td class="form_label" align="right">
	                        	特殊条款说明:
	                    </td>
	                    <td colspan="3">
	                    	<input class="nui-textarea"  name="debtIssue.vcSpecialTextDesc" width="96%"/>
	                    </td>
	                </tr>
	                 <tr>
	                  	 <td class="form_label" align="right">
	                       	 下一利率跳升点数(BP):
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-textbox" onblur="checkInt(this,lNInterestRateJumpPoints)" id="lNInterestRateJumpPoints" width="90%"  name="debtIssue.lNInterestRateJumpPoints"/>
	                    </td>
	                  	 <td class="form_label" align="right">
	                                                                                    招标方式:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="tenderType" width="90%" id="cBidType" name="debtIssue.cBidType"  showNullItem="false"/>
	                    </td>
	                </tr>
	                
	                <tr>
	                  	<td class="form_label" align="right">
	                       	 担保人:
	                    </td>
	                    <td colspan="1"> 
	                    	 <input style="width: 87%;" class="nui-textbox"  id="vcGuarantorName" name="debtIssue.vcGuarantorName"/>
	                    	 <input id="lookup5" style="width: 25px;" class="mini-lookup" name="debtIssue.lGuarantorId"
						        textField="vcIssueNameFull" valueField="lIssuerId" popupWidth="auto"  
						        popup="#gridPanel5" data="data" onvalidation="onGuarantor" grid="#datagrid5" multiSelect="false"  onclick="onClearClick5();onSearchClick5()" />
						     
						     <div id="gridPanel5" class="mini-panel" title="header" iconCls="icon-add" style="width:450px;height:250px;" 
						        showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0" borderStyle="border:0" >
						        <div property="toolbar" style="padding:5px;padding-left:8px;text-align:center;">   
						            <div style="float:left;padding-bottom:2px;">
						                <span>担保人：</span>                
						                <input id="keyText5" class="mini-textbox" style="width:160px;" value="" onenter="onSearchClick5"/>
						                <a class="mini-button" onclick="onSearchClick5">查询</a>
						                <a class="mini-button" id="add" iconCls='icon-add' onclick="onAddClick">添加</a>
						            </div>
						            <div style="float:right;padding-bottom:2px;margin-right:14px;">
						            </div>
						            <div style="clear:both;"></div>
						        </div>
						        <div id="datagrid5"   class="mini-datagrid" style="width:100%;height:100%;" 
						            borderStyle="border:0" showPageSize="false" showPageIndex="false"
						            url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadIssueInfo.biz.ext" onRowdblclick="dbClick5" >
						            <div property="columns" >
						                <div field="vcIssueName" width="50"  headerAlign="center" allowSort="true">简称</div>
						                <div field="vcIssueNameFull" width="70" headerAlign="center" allowSort="true">全称</div>
						            </div>
						        </div>  
						      </div>
	                    </td>
	                  	 <td class="form_label" align="right">
	                                                                                    担保方式:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="ATS_FM_ASSUER_TYPE" width="90%" id="cAssuerType" name="debtIssue.cAssureType"  showNullItem="false"/>
	                    </td>
	                </tr>
	                <tr>
	                 <td class="form_label" align="right">
	                                                                                    担保人简介:
	                    </td>
	                    <td colspan="3">
	                    	<input class="nui-textarea"  name="debtIssue.vcGuarantorSummary"  id="vcGuarantorSummary" width="96%"/>
	                    </td>
	                </tr>
	                
	                <tr>
	                     <td class="form_label" align="right">
	                       	 下一行权日:
	                    </td>
	                    <td colspan="1">
<!-- 	                    	<input class="nui-textbox" vtype="float" onblur="checkedYear(this)"  name="lNextExerciseDate" id="lNextExerciseDate" width="90%" />  -->
	                        <input class="nui-datepicker"  id="lNextExerciseDate" name="lNextExerciseDate" style="width: 90%;" />
	                    </td>
	                    <td class="form_label" align="right">
	                                                                                    特殊期限:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="debtIssue.vcSpecialLimite" id="vcSpecialLimite" width="90%"/>
	                    </td>	                                          
	                </tr>
	                <tr>
	                    
	                    <td class="form_label" align="right">
	                         是否具有赎回权:
	                    </td>
	                    <td colspan="1" class="radio-border-top-none">
							<input id="cIsHaveBuyback" name="debtIssue.cIsHaveBuyback" value="0" class="nui-radiobuttonlist" data="[{id: 1, text: '是'}, {id: 0, text: '否'}]"/>
	                    </td>
	                    <td class="form_label" align="right">
	                       	 是否具有回售权:
	                    </td>
	                    <td colspan="1" class="radio-border-top-none"> 
	                    	<input id="cIsHaveSaleback" name="debtIssue.cIsHaveSaleback" class="nui-radiobuttonlist" value="0" data="[{id: 1, text: '是'}, {id: 0, text: '否'}]"/>
	                    </td>
	                </tr>
	                <tr> 
		                 <td class="form_label" align="right">
		                                                                                    募集说明书:
		                 </td>
		                 <td colspan="3" class="td">
							<iframe id="prodIfm1" width="590"  height="110px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" 
							 	src="<%=request.getContextPath() %>/fm/baseinfo/fileupload/any_upload.jsp?attachType=2&attachBusType=1&id=<%=key %>" >
							 </iframe>
						 </td>
						 
	               </tr>
	               
	               <tr> 
		                 <td class="form_label" align="right">
		                                                                                    信用评级报告:
		                 </td>
		                 <td colspan="3" class="td">
							<iframe id="prodIfm2" width="590"  height="110px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" 
							 	src="<%=request.getContextPath() %>/fm/baseinfo/fileupload/any_upload.jsp?attachType=2&attachBusType=2&id=<%=key %>" >
							 </iframe>
						 </td>
						
						 
	               </tr>
	               <tr> 
		                 <td class="form_label" align="right">
		                                                                                      债券发行公告:
		                 </td>
		                 <td colspan="3" class="td">
							<iframe id="prodIfm3" width="590"  height="110px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" 
							 	src="<%=request.getContextPath() %>/fm/baseinfo/fileupload/any_upload.jsp?attachType=2&attachBusType=3&id=<%=key %>" >
							 </iframe>
						 </td>
						 
	               </tr>
	            </table>
	            <input class="nui-hidden" name="debtIssue.lOperatorNo" value="<%=userObject.getUserId()%>" />
              
	            <!-- hidden域 -->
	            <input class="nui-hidden" id="lRaiseInstFile" name="debtIssue.lRaiseInstFile"/>
	            <input class="nui-hidden" id="lStockIssueId" name="debtIssue.lStockIssueId" value="<%=key%>"/>
	            
 				<input class="nui-hidden" id="lRateReportFile" name="debtIssue.lRateReportFile"/>
				<input class="nui-hidden" id="lBondIssueFile" name="debtIssue.lBondIssueFile"/>
				<input class="nui-hidden" id="cMarketNo" name="debtIssue.cMarketNo"/>
	        </div>
           </div>
        </div>
        <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
	         <table width="100%">
	             <tr>
	               <td style="text-align:center;" colspan="4">
	                  <a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">
	                                保存
	                  </a>
	                  <span style="display:inline-block;width:25px;"></span>
	                  <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
	                                取消
	                  </a>
	                </td>
	              </tr>
	          </table>
	      </div>
        <script type="text/javascript">
            nui.parse();
            //初始化投标截止时间的时分秒
            //nui.get("dApplicationTimeHH").setValue((new Date()).getHours());
		    //nui.get("dApplicationTimeMM").setValue((new Date()).getMinutes());
		    $("#morStockNameAndCode").hide();
		    $("#morStockAmount").hide();
		    loadStockTypeAll();
		    function checked(v){
		        var r=/^[0-9]+.?[0-9]*$/;
		        if(!r.test(v)){ //isNaN也行的,正则可以随意扩展
		            nui.alert('只能输入数字');
		        }
		    }
		   /*  function checkedYear(v){
		        var r=/^[1-2]{1}[0-9]{3}$/;
		        if(v.value!="" && v.value!=null){
		        	if(!r.test(v.value)){
		            	nui.alert('输入正确的年份');
		        	}
		        }
		    } */
             //加载所有的债券信息
             function loadStockTypeAll(){
             	
             	nui.ajax({
				    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext",
				    type: "post",
				    dataType:"json",
				    success: function (text) {
				    	nui.get("vcStockType").loadList(text.data);
				    }
				});
             	$(".lableReq").find("label").hide();//隐藏股票代码的必填红色标记
             }
            var stockIssueInfoStr;
            
            getCheckCondition();
            var grid1 = nui.get("datagrid1");
            var keyText = nui.get("keyText");
        	//grid1.load();
        	
        	var grid3 = nui.get("datagrid3");
        	var keyText3 = nui.get("keyText3");
        	//grid3.load();
        	
            var form = new nui.Form("#dataform1");
            form.setChanged(false);
            
            function onCloseClick(e) {
	            var lookup2 = nui.get("lookup2");
	            lookup2.hidePopup();
	        }
	        function onClearClick(e) {
	            /* var lookup2 = nui.get("lookup2");
	            lookup2.deselectAll();  */
	            nui.get("keyText").setValue("");
	        }
	        
	         //发行人选择 ，双击行，事件响应
	        function dbClick2(e){
	        	var lookup2 = nui.get("lookup2");
	            lookup2.hidePopup();
	        }
	        
	        function onCloseClick3(e) {
	            var lookup3 = nui.get("lookup3");
	            lookup3.hidePopup();
	        }
	        function onClearClick3(e) {
	            /* var lookup3 = nui.get("lookup3");
	            lookup3.deselectAll(); */
	            nui.get("keyText3").setValue("");
	        }
	        
	        //主承销商选择 ，双击行，事件响应
	        function dbClick3(e){
	        	 var lookup3 = nui.get("lookup3");
	            lookup3.hidePopup();
	        }
	        
	        var grid4 = nui.get("datagrid4");
        	var keyText4 = nui.get("keyText4");
        	//grid4.load();
        	 
        	function onCloseClick4(e) {
	            var lookup4 = nui.get("lookup4");
	            lookup4.hidePopup();
	        }
	        function onClearClick4(e) {
	            /* var lookup4 = nui.get("lookup4");
	            lookup4.deselectAll(); */
	            nui.get("keyText4").setValue("");
	        }
	        
	        //副主承销商，行选择，双击事件
	        function dbClick4(e) {
	            var lookup4 = nui.get("lookup4");
	            lookup4.hidePopup();
	        }
	        
	        function onSearchClick4(e) {
	            grid4.load({
	                key: keyText4.value
	            });
	        }
	        
 			var grid5 = nui.get("datagrid5");
        	var keyText5 = nui.get("keyText5");
        	//grid5.load();
        	 
        	function onCloseClick5(e) {
	            var lookup5 = nui.get("lookup5");
	            lookup5.hidePopup();
	        }
	        function onClearClick5(e) {
	            /* var lookup5 = nui.get("lookup5");
	            lookup5.deselectAll(); */
	            nui.get("keyText5").setValue("");
	        }
	        
	        function onSearchClick5(e) {
	            grid5.load({
	                key: keyText5.value
	            });
	        }
	        
	        //担保人，行选择，双击响应事件
	        function dbClick5(e) {
	            var lookup5 = nui.get("lookup5");
	            lookup5.hidePopup();
	        }
	        //承销团
        var grid6 = nui.get("datagrid6");
    	var keyText6 = nui.get("keyText6");
    	grid6.load();
    	 
    	function onCloseClick6(e) {
            var lookup6 = nui.get("lookup6");
            lookup6.hidePopup();
        }
        function onClearClick6(e) {
            nui.get("keyText6").setValue("");
        }
        
        function onSearchClick6(e) {
            grid6.load({
                key: keyText6.value
            });
        }
        function dbClick6(e) {
            var lookup6 = nui.get("lookup6");
            lookup6.hidePopup();
        }
        	
			//删除
			function gridRemoveRow(datagrid){
				var grid1 = nui.get(datagrid);
				var rows = grid1.getSelecteds();
	            if (rows.length > 0) {
	                grid1.removeRows(rows, true);
	            }
			}
			//刷新
			function gridReload(datagrid){
				var grid1 = nui.get(datagrid);
				grid1.reload();
			}
			/**
			            选择发行人触发时间
			*/
			function issueInfoOnItemClick(){
				 var lIssuerId = nui.get("lIssuerId").getValue();//发行人代码
				 if(lIssuerId!=null && lIssuerId!=""){
				      //
					  $.ajax({
						url:"com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.getIssueInfoByID.biz.ext",
						type:'POST',
						data:nui.encode({id:lIssuerId}),
						cache:false,
						contentType:'text/json',
						success:function(text){
							var returnJson = nui.decode(text);
							if(returnJson.exception == null){
							    var issueInfo = returnJson.issueInfo;//投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
							    //投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
							    var vcIssueName = issueInfo.vcIssueName;
							    var vcIssueNameFull = issueInfo.vcIssueNameFull;
							    //console.log(issueInfo);
							    var vcIssueProperty = issueInfo.vcIssueProperty;
							    var cIssueAppraise = issueInfo.cIssueAppraise;
							    var vcIssueAppraiseOrgan = issueInfo.vcIssueAppraiseOrgan;
							    var vcIndustry = issueInfo.vcIndustry;   //所属行业
							    var vcProvince = issueInfo.vcProvince;  //所属省份
								nui.get("vcIssuerName").setValue(vcIssueName);               //发行人简称
								nui.get("vcIssuerNameFull").setValue(vcIssueNameFull);               //发行人全称
								nui.get("cIssueAppraise").setValue(cIssueAppraise);			  //主体评级
								nui.get("vcIssueProperty").setValue(vcIssueProperty);	      //主体类型
								nui.get("vcIssueAppraiseOrgan").setValue(vcIssueAppraiseOrgan);//主体评级机构
								nui.get("vcIndustry").setValue(vcIndustry);			  //所属行业
								nui.get("vcProvince").setValue(vcProvince);			  //所属省份
								nui.get("vcBondAppraiseOrgan").setValue(vcBondAppraiseOrgan);
								
								
							}
						 }
					});
				  }
			
			
			}
			
		//担保人	
		function guarantorOnItemClick(){
			var lIssuerId = nui.get("lIssuerId").getValue();//发行人代码
				 if(lIssuerId!=null && lIssuerId!=""){
				      //
					  $.ajax({
						url:"com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.getIssueInfoByID.biz.ext",
						type:'POST',
						data:nui.encode({id:lIssuerId}),
						cache:false,
						contentType:'text/json',
						success:function(text){
							var returnJson = nui.decode(text);
							if(returnJson.exception == null){
							    var issueInfo = returnJson.issueInfo;//投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
							    //担保人名称，需要放到隐藏表单中
							   var vcIssueName = issueInfo.vcIssueName;
							   nui.get("vcGuarantorName").setValue(vcIssueName);               //担保人名称，需要放到隐藏表单中
							}
						 }
					});
				  }
		
		}
			
		
		function enterSumbit(e){  
		   issueInfoOnItemClick();
 		}
 		
 		//确定保存或更新
		function onOk() {
			saveData();
		}
		
		function onCancel(){
			CloseWindow("close");
		}
		
		function deleteFilePreparation(){
			var ids = "";
			var lRaiseInstFile = nui.get("lRaiseInstFile").value;
			var lRateReportFile = nui.get("lRateReportFile").value;
			var lBondIssueFile = nui.get("lBondIssueFile").value;
			if(lRaiseInstFile!=null  && lRaiseInstFile !=""){
				ids = lRaiseInstFile;
			}
			if(lRateReportFile!=null && lRateReportFile!=""){
				if(ids!=""){
					ids  = lRateReportFile+","+ids;
				}else{
					ids  = lRateReportFile;
				}
			}
		
			if(lBondIssueFile!=null && lBondIssueFile !=""){
				if(ids!=""){
					ids  = lBondIssueFile+","+ids;
				}else{
					ids  = lBondIssueFile;
				}
			}
			//如果没有上载文件，直接关闭
			if (ids == ""){
		     	//return window.CloseOwnerWindow(action);
	    	}else{
	    		deleteFile(ids);
	    	}
		}
		
		//删除数据库中附件表的的文件
		function deleteFile(ids){
			var json = nui.encode({fileIds: ids});
			$.ajax({
	            url:'com.cjhxfund.ats.fm.baseinfo.attachInfoManager.deleteAttachInfos.biz.ext',
	            type:'POST',
	            data:json,
	            cache:false,
	            contentType:'text/json',
	            success:function(data){
	             	 var returnJson = nui.decode(data);
		             if(returnJson.returnValue == "ok"){
		              	CloseWindow("close");
		             }else{
		               nui.alert("附件删除失败！","系统提示",function(action){
		               
		               });
		             }
	        	 }
	         });
		
		}
		
		//根据登记托管机构，获取交易市场和缴款方式
		 function onMarketNoChanged(e) {
		    var vcPaymentPlace = nui.get("vcPaymentPlace");
            var id = vcPaymentPlace.getValue();
            var cPayType = nui.get("cPayType").getValue();
            var cMarketNo = nui.get("cMarketNo").getValue();
            if(id=='03'){
	        	cMarketNo=1;//交易市场
	        	cPayType = "3";
	        }else if(id=='04'){
	        	cMarketNo=2;
	        	cPayType = "3";
	        }else if(id=='02'){//上海清算所
	        	cMarketNo=5;
	        	if(nui.get("vcStockType").getValue()=="D"){//同业存单
	        		cPayType = "3";
	        	}else{
	        		cPayType = "1";
	        	}
			}else if(id=='01'){
				cMarketNo=5;
				cPayType = "2";
			}else{
				cMarketNo=5;
	        	cPayType = "3";
			}
			nui.get("cMarketNo").setValue(cMarketNo);
			nui.get("cPayType").setValue(cPayType);
        }
        
        //获取查询条件
        function getCheckCondition(){
        	 $.ajax({
				url:"com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadCheckStockIssueInfo.biz.ext",
	            type:'POST',
	            data:null,
	            cache:false,
	            contentType:'text/json',
	            success:function(text){
					var data = nui.decode(text);
					stockIssueInfoStr = data.stockIssueInfoStr;
				}    
			});
        }
        
        //获取校验债券的数据
		function getCheckStockIssueInfo(){
			//定义存储变量
			var stockIssueInfoEnt={};
			if(stockIssueInfoStr=="" || stockIssueInfoStr==null){
				nui.alert("没有获取到债券校验信息，请刷新！");
				return "";
			}else{
				var strs=stockIssueInfoStr.split(",");
				for(var i=0;i<strs.length;i++){
				//vc_issuer_name,vc_stock_name_full,vc_stock_type,en_exist_limite,en_issue_balance
				//,l_issue_begin_date,c_issue_appraise,vc_issue_property
					if(strs[i]=="vc_issuer_name_full"){
						//发行人
						var vcIssuerName=nui.get("vcIssuerNameFull").getValue();
						stockIssueInfoEnt.vcIssuerNameFull=vcIssuerName;
					}
					if(strs[i]=="vc_stock_name_full"){
						//债券全称
						var vcStockNameFull=nui.get("vcStockNameFull").getValue().replace(/\s+/g, "");
						stockIssueInfoEnt.vcStockNameFull=vcStockNameFull;
					}
					if(strs[i]=="vc_stock_name"){
						//债券全称
						var vcStockName=nui.get("vcStockName").getValue().replace(/\s+/g, "");
						stockIssueInfoEnt.vcStockName=vcStockName;
					}
					if(strs[i]=="vc_stock_type"){
						//债券类型
						var vcStockType=nui.get("vcStockType").getValue();
						stockIssueInfoEnt.vcStockType=vcStockType;
					}
					if(strs[i]=="en_exist_limite"){
						//发行期限
						var enExistLimite=nui.get("enExistLimite").getValue();
						stockIssueInfoEnt.enExistLimite=enExistLimite;
					}
					if(strs[i]=="en_issue_balance"){
						//发行额度
						var enIssueBalance=nui.get("enIssueBalance").getValue();
						stockIssueInfoEnt.enIssueBalance=enIssueBalance;
					}
					if(strs[i]=="l_issue_begin_date"){
						//发行日期
						var lIssueBeginDate=nui.get("lIssueBeginDate").getValue();
						lIssueBeginDate=getIntDate(lIssueBeginDate);
						stockIssueInfoEnt.lIssueBeginDate=lIssueBeginDate;
					}
					if(strs[i]=="c_issue_appraise"){
						//主体评级
						var cIssueAppraise=nui.get("cIssueAppraise").getValue();
						stockIssueInfoEnt.cIssueAppraise=cIssueAppraise;
					}
					if(strs[i]=="vc_issue_property"){
						//主体类型
						var vcIssueProperty=nui.get("vcIssueProperty").getValue();
						stockIssueInfoEnt.vcIssueProperty=vcIssueProperty;
					}
					var cMarketNo=nui.get("cMarketNo").getValue();
					stockIssueInfoEnt.cMarketNo=cMarketNo;
				}
				return stockIssueInfoEnt;
			}
		}
		function saveData(){
				var reg = new RegExp("^^[0-9]+\.?[0-9]*$"); // /^[1-9]+[0-9]*]*$/
				var code = new RegExp("^^[A-Za-z0-9]+$");
				var vcDeputyUnderwriterObj = nui.get("vcDeputyUnderwriter").getValue();
        	    var vcMainUnderwriterObj = nui.get("vcMainUnderwriter").getValue();
        	    var vcGuarantorNameObj = nui.get("vcGuarantorName").getValue();
        	    var vcGroupUnderwriterObj = nui.get("vcGroupUnderwriter").getValue();
        	    var vcMainUnderwriterIdObj=nui.get("vcMainUnderwriterId").getValue();
        	    var vcDeputyUnderwriterIdObj=nui.get("vcDeputyUnderwriterId").getValue();
        	    var vcGroupUnderwriterIdObj=nui.get("vcGroupUnderwriterId").getValue();
        	    
        	    nui.get("vcStockName").setValue(nui.get("vcStockName").getValue().replace(/\s+/g, ""));
        	    nui.get("vcStockNameFull").setValue(nui.get("vcStockNameFull").getValue().replace(/\s+/g, ""));
				var length = 0;
				var enIssuerNetValue = nui.get("enIssuerNetValue").getValue();
				if(enIssuerNetValue!=""){
					if(!reg.test(enIssuerNetValue)){
						nui.alert("公司净资产请输入数字!");
						return;
					}
				}
				form.validate();	
				if (form.isValid() == false) {
					nui.alert("请检查必填项!");
					return;
				}
				
				var vcStockCode = nui.get("vcStockCode").value;
				var vcPaymentPlace = nui.get("vcPaymentPlace").value;
				//var lStockInvestNo = nui.get("lStockInvestNo").value;
				var cMarketNo = nui.get("cMarketNo").value;
				if(vcStockCode!=""){
					if(!code.test(vcStockCode)){
						nui.alert("债券代码请输入字母数字！");
						return;
					}
					if(cMarketNo!="5"){//银行间
						if(vcStockCode.length>6){
							nui.alert("登记托管所为上交所深交所的时候债券代码不能超过6位！");
							return;
						}
					}else{
						if(vcStockCode.length>20){
							nui.alert("债券代码不能超过20位！");
							return;
						}
					}
					if(vcStockCode.length==6 && vcPaymentPlace=="02"){
							nui.alert("债券代码为6位时，登记托管机构不能为上海清算所！");
							return;
						}
				} 
				var enPayInteval = nui.get("enPayInteval").value;
				
				if(enPayInteval<-1 ){
					nui.alert("付息频率必须大于0且小于7位!");
					return;
				}
				if(enPayInteval==-1 || enPayInteval==null || enPayInteval==""){
				
				}else{
					if(!reg.test(enPayInteval)){
						nui.alert("付息频率请输入数字或者下拉框选择!");
						return;
					}
				}
				var enIssueBalance = nui.get("enIssueBalance").value;
				length = enIssueBalance.split(".")[0].length;
				if(enIssueBalance<=0 || length>6){
					nui.alert("发行规模必须大于0且小于6位!");
					return;
				} 
				if(!reg.test(enIssueBalance)){
					nui.alert("发行规模请输入数字!");
					return;
				}
				var enExistLimite = nui.get("enExistLimite").value;//5
				length = enExistLimite.split(".")[0].length;
				if(enExistLimite<=0 || length>5){
					nui.alert("发行期限必须大于0且小于5位!");
					return;
				}
				if(!reg.test(enExistLimite)){
					nui.alert("发行期限请输入数字!");
					return;
				}
				/* var enCategoryMoney = nui.get("enCategoryMoney").value;
				length = enCategoryMoney.split(".")[0].length;
				if(enCategoryMoney!=""){
					if(!reg.test(enCategoryMoney) || length>6){
					nui.alert("主体发行债券存量(亿)请输入数字且小于6位!");
					return;
				}
				} */
				var enFaceRate = nui.get("enFaceRate").value;
				length = enFaceRate.split(".")[0].length;
				if(enFaceRate!=""){
					if(!reg.test(enFaceRate) || length>6){
					nui.alert("票面利率请输入数字且小于6位!");
					return;
				}
				}
				
				/* /* var lNextExerciseDate = nui.get("lNextExerciseDate");
				if(lNextExerciseDate!=null && lNextExerciseDate.value!=""){
					nui.get("lNextExercise").setValue(lNextExerciseDate.getValue().substr(0,4));
				} */ 
				//执行完validate方法后，导致承销商的值没有了，先保存下来，等执行完validate后再赋值
			 	nui.get("vcDeputyUnderwriter").setValue(vcDeputyUnderwriterObj);
				nui.get("vcMainUnderwriter").setValue(vcMainUnderwriterObj);
				nui.get("vcGuarantorName").setValue(vcGuarantorNameObj);
				nui.get("vcGroupUnderwriter").setValue(vcGroupUnderwriterObj);
				nui.get("vcMainUnderwriterId").setValue(vcMainUnderwriterIdObj);
				nui.get("vcDeputyUnderwriterId").setValue(vcDeputyUnderwriterIdObj);
				nui.get("vcGroupUnderwriterId").setValue(vcGroupUnderwriterIdObj);
				//设置投标截止时间
				var dBidLimitTime = nui.get("dBidLimitTime");
				if(dBidLimitTime!=null && dBidLimitTime.value!=""){
					var dApplicationDate=dBidLimitTime.text;
					var dApplicationHH=nui.get("dApplicationTimeHH").text;
					var dApplicationMM=nui.get("dApplicationTimeMM").text;
					
					var dApplicationTime1=dApplicationHH+":"+dApplicationMM+":00";
					var dDate=dApplicationDate+" "+dApplicationTime1;
					
					/* var dApplicationTime2=dApplicationHH+":"+dApplicationMM+":59";
					dApplicationDate=dApplicationDate.replace(/-/g,"/");
					var dDate2=dApplicationDate+" "+dApplicationTime2;
					var dDate3 = new Date(dDate2).getTime();
					var tDate = new Date().getTime(); //当前时间
					if(tDate > dDate3){
						nui.alert("投标截止时间小于系统当前时间");
						return;
					} */
					dBidLimitTime.setValue(dDate);
				}  
				
				var stockIssueInfo= getCheckStockIssueInfo();
				//校验数据不能为空
				if(stockIssueInfo==""){
					return;
				}
				nui.ajax({
				    url: "com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.checkDebtIssues.biz.ext",
				    type: "post",
				    data: {stockIssueInfo:stockIssueInfo,type:1,vcStockCode:vcStockCode,vcPaymentPlace:vcPaymentPlace},
				    dataType:"json",
				    success: function (text) {
					       form.unmask();//取消遮罩
					       flag = text.out;
					       if(text.out==false){
					       		/* nui.confirm("当前债券已经存在，确认需要录入吗?", "系统提示", function (a){
						       		if(a=='ok'){
						      			addDebtIssue();
						      		 }
								}); */
								nui.alert("当前债券已经存在.");
								return false;
					       }else{
					       		addDebtIssue();
					       }
				      	}
				});
		     }
		     
		   //保存到新债表
		   function addDebtIssue(){
		   		if(nui.get("enFaceRate").getValue()==""){
		   			nui.get("enFaceRate").setValue("0");
		   		}
		   		var data = form.getData(false,true);
		   		/* //补全行权年格式
		   		var year = null;
		   		if(data.lNextExerciseDate!=""){
		   			year = data.lNextExerciseDate+"-"+"11"+"-"+"11";
		   			data.lNextExerciseDate = year;
		   		} */
                var json = nui.encode(data);
 				form.loading();//加载遮罩
				$.ajax({
					url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.addDebtIssue.biz.ext",
		            type:'POST',
		            data:json,
		            cache:false,
		            contentType:'text/json',
		            success:function(text){
		                form.unmask();//取消遮罩
						var returnJson = nui.decode(text);
            			if(returnJson.exception == null){
            			    if(returnJson.returnCode=="1"){
	            			    nui.alert("保存成功", "系统提示", function(action){
	                            		CloseWindow("saveSuccess");
                    			});
            			    }else{
            			    	 nui.alert("保存失败", "系统提示", function(action){
	                        		//if(action == "ok" || action == "close"){
	                            		//CloseWindow("saveSuccess");
	                        		//}
                    			});
            			    }
            				
                			
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
		   
		   //将时间格式字符串转换为int类型
			function getIntDate(dateStr){
				if(dateStr=="" || dateStr==null){
					return "";
				}
				dateStr=dateStr.substr(0,10);//0开始，取后面10位
				dateStr=dateStr.replace(/-/g, "");
				return dateStr;
			}
		
		   //上载时，将附件表中的id传过来，放到隐藏表单中，直接保存到数据库
		   function initAttachId(attachBusType,serverData){
		       var fileID = serverData.trim();
		   	  if(attachBusType==1){     //lRaiseInstFile
		   	  	nui.get("lRaiseInstFile").setValue(fileID);
		   	  }else if(attachBusType==2){//lRateReportFile
		   	  	nui.get("lRateReportFile").setValue(fileID);
		   	  }else if(attachBusType==3){//lBondIssueFile
		   	  	nui.get("lBondIssueFile").setValue(fileID);
		   	  }
		   	  form.setChanged(true);
		   } 
		   
		   //子页面删除文件之后，也删除父界面上的隐藏表单的值
		   function deleteFileByUpload(attachBusType){
		   	  if(attachBusType==1){     
		   	  	nui.get("lRaiseInstFile").setValue("");
		   	  }else if(attachBusType==2){//lRateReportFile
		   	  	nui.get("lRateReportFile").setValue("");
		   	  }else if(attachBusType==3){//lBondIssueFile
		   	  	nui.get("lBondIssueFile").setValue("");
		   	  }
		   }
		   
		   var IssueronCkData=new Array();//发行人选中的历史数据
		    function onIssuerId(e){
				var dataIssuer=grid1.data;
	        	//设置发行人信息,累加查询结果，防止用户查询新数据后不选择
	        	if(IssueronCkData!=null){
	        		dataIssuer=dataIssuer.concat(IssueronCkData);
	        	}
	        	//获取发行人的其他数据
	        	for(var i=0;i<dataIssuer.length;i++){
	        		//查找选中的数据
	        		if(dataIssuer[i].lIssuerId==e.value){
	        			if(IssueronCkData!=null){
	        				IssueronCkData=IssueronCkData.concat(dataIssuer[i]);
	        			}else{
	        				IssueronCkData[0]=dataIssuer[i];
	        			}
	        			//console.log(dataIssuer[i]);
					    //投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
					    var vcIssueName = dataIssuer[i].vcIssueName;
					    var vcIssueNameFull = dataIssuer[i].vcIssueNameFull;
					    var vcIssueProperty = dataIssuer[i].vcIssueProperty;
					    var cIssueAppraise = dataIssuer[i].cIssueAppraise;
					    var vcIssueAppraiseOrgan = dataIssuer[i].vcIssueAppraiseOrgan;
					    var vcIndustry = dataIssuer[i].vcIndustry;   //所属行业vcIndustry
					    var vcProvince = dataIssuer[i].vcProvince;  //所属省份
					    var vcIssueAppraiseCsrc = dataIssuer[i].vcIssueAppraiseCsrc;//所属行业（证监会二级）
					    var enIssuerNetValue = dataIssuer[i].enIssuerNetValue;//公司净资产
					    var vcCityLevel = dataIssuer[i].vcCityLevel;//城投行政级别
					    
					    //console.log(vcIssueName+","+vcIssueNameFull+","+vcIssueProperty+","+cIssueAppraise+","+vcIssueAppraiseOrgan+","+vcIndustry+","+vcProvince);
						if(vcIssueName!=null){
							nui.get("vcIssuerName").setValue(vcIssueName);               //发行人全称
						}
						if(vcIssueNameFull!=null){
							nui.get("vcIssuerNameFull").setValue(vcIssueNameFull);               //发行人全称
						}
						if(cIssueAppraise!=null){
							nui.get("cIssueAppraise").setValue(cIssueAppraise);			  //主体评级
						}
						if(vcIssueProperty!=null){
							nui.get("vcIssueProperty").setValue(vcIssueProperty);	      //主体类型
						}
						if(vcIssueAppraiseOrgan!=null){
							nui.get("vcIssueAppraiseOrgan").setValue(vcIssueAppraiseOrgan);//主体评级机构
						}
						if(vcIndustry!=null){
							nui.get("vcIndustry").setValue(vcIndustry);			  //所属行业
						}
						if(vcProvince!=null){
							nui.get("vcProvince").setValue(vcProvince);			  //所属省份
						}
						if(vcIssueAppraiseCsrc!=null){
							nui.get("vcIssueAppraiseCsrc").setValue(vcIssueAppraiseCsrc);			  //所属行业（证监会二级）
						}
						if(enIssuerNetValue!=null){
							nui.get("enIssuerNetValue").setValue(enIssuerNetValue);			  //公司净资产
						}
						if(vcCityLevel!=null){
							nui.get("vcCityLevel").setValue(vcCityLevel);			  //城投行政级别
						}
	        		}
	        	}
	          
			}
			
			var GuarantorCkData=new Array();//发行人选中的历史数据
			function onGuarantor(e){
				var dataIssuer=grid5.data;
	        	//设置发行人信息,累加查询结果，防止用户查询新数据后不选择
	        	if(IssueronCkData!=null){
	        		dataIssuer=dataIssuer.concat(IssueronCkData);
	        	}
	        	//获取发行人的其他数据
	        	for(var i=0;i<dataIssuer.length;i++){
	        		//查找选中的数据
	        		if(dataIssuer[i].lIssuerId==e.value){
	        			if(IssueronCkData!=null){
	        				GuarantorCkData=GuarantorCkData.concat(dataIssuer[i]);
	        			}else{
	        				GuarantorCkData[0]=dataIssuer[i];
	        			}
					    //投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
					    var vcIssueNameFull = dataIssuer[i].vcIssueNameFull;
						nui.get("vcGuarantorName").setValue(vcIssueNameFull);               //发行人全称
	        		}
	        	}
	          
			}
			
			 function onSearchClick(e) {
	            grid1.load({
	                key: keyText.value
	            });
	        }
	        
	         function onSearchClick3(e) {
	            grid3.load({
	                key: keyText3.value
	            });
	        }
	        function onIssuerId3(e){
        		nui.get("vcMainUnderwriter").setValue(e.source.text);
        		nui.get("vcMainUnderwriterId").setValue(e.source.value);
        	}
        	function onIssuerId4(e){
        		nui.get("vcDeputyUnderwriter").setValue(e.source.text);
        		nui.get("vcDeputyUnderwriterId").setValue(e.source.value);
        	}
			function onIssuerId6(e){
        		nui.get("vcGroupUnderwriter").setValue(e.source.text);
        		nui.get("vcGroupUnderwriterId").setValue(e.source.value);
        	}
        	
		    //关闭窗口
		    function CloseWindow(action){
		      if(action=="close" && form.isChanged()){
		      	nui.confirm("数据已改变,确认退出?","系统提示",function(a){
		      		if(a=='ok'){
		      			deleteFilePreparation();
		      			CloseWindow("cance");
		      		}
		      	});
		       
		      }else if(window.CloseOwnerWindow) 
		        return window.CloseOwnerWindow(action);
		      else
		        return window.close();
		    } 
    	/* lookUpData();
	  	function lookUpData(){
			$.ajax({
	            url:"com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadIssueInfo.biz.ext",
	            type:'POST',
	            data:"",
	            cache: false,
	            contentType:'text/json',
	            success:function(text){
	            	nui.get("datagrid1").setData(text.data);
	            	nui.get("datagrid3").setData(text.data);
	            	nui.get("datagrid4").setData(text.data);
	            	nui.get("datagrid5").setData(text.data);
	            }
	        });
		} */
		function check(obj){  
	       var reg = new RegExp("^^[0-9]+\.?[0-9]*$");  
		    if(!reg.test(obj.value)){ 
		        nui.alert("请检查数据,该项只能输入数字!");  
		        return;
		    }  
	  }
	  function checkInt(obj,name){  
	       var reg = new RegExp("^[0-9]*[1-9][0-9]*$");  
		    if(!reg.test(obj.value)){ 
		        nui.alert("请检查数据,该项只能输入整数!");  
		        nui.get(name).setValue("");
		        return;
		    }  
	  }
	   
	  function checkFXPL(obj){
	  	if(obj.value=="-1" || obj.value==""){
	  		
	  	}else{
	  		var reg = new RegExp("^^[0-9]+\.?[0-9]*$");  
		    if(!reg.test(obj.value) || obj.value.indexOf(" ") != -1){ 
		        nui.alert("请输入数字或者下拉框按钮选择，且不能包含空格，请检查!");  
		        return;
		    }
	  	}
	  }
	  function checkCode(obj){
	  	var code = new RegExp("^^[A-Za-z0-9]+$"); ///^[0-9a-zA-Z]*$/g,/^[A-Za-z0-9]+$/
	  	if(obj.value!=""){
	  		if(!code.test(obj.value)){
				nui.alert("债券代码请输入字母数字！");
				return;
			}
	  	}
	  }
	  function onAddClick(){
	  	var url = "<%= request.getContextPath() %>/fm/baseinfo/issuerInfo/addIssuerInfo.jsp";
			var title = "新增发行主体";
			var width = "400";
			var height = "390";
			nui.open({
				url: url,
				title: title, width: width, height: height,
				onload: function () {//弹出页面加载完成
					
				},
				ondestroy: function (action) {//弹出页面关闭前,把新增的主体简称返回赋值给查询框
					keyText.setValue(action);
					keyText3.setValue(action);  
					keyText4.setValue(action);
					keyText5.setValue(action);
					onSearchClick();
					onSearchClick3();
					onSearchClick4();
					onSearchClick5();
				}
			});
	  }
	  function beforenodeselect(e) {
            //禁止选中父节点
            if (e.isLeaf == false) e.cancel = true;
        	}
	  //国债A、政策银行债E1、央票C、地方债B，这些利率债的主体评级、债券评级、评级机构为非必填
        function cheangedVcStockType(e){
        	
        	if(e.value=="A" || e.value=="B" || e.value=="C" || e.value=="E1"){
        		nui.get("cIssueAppraise").setRequired(false);
        		nui.get("cBondAppraise").setRequired(false);
        		nui.get("vcBondAppraiseOrgan").setRequired(false);
        		//删除红* ，必填样式
        		$(".requiredLable").find("label").hide();
        	}else{
        		//否则添加必填校验
        		nui.get("cIssueAppraise").setRequired(true);
        		nui.get("cBondAppraise").setRequired(true);
        		nui.get("vcBondAppraiseOrgan").setRequired(true);
        		$(".requiredLable").find("label").show();
        	}
        	//手工新增债券时如果是可交换债还需要录入  抵押股票代码、股票抵押数量
        	if(e.value=="Q" || e.value=="O"){
        		$("#morStockNameAndCode").show();
		        $("#morStockAmount").show();
        		nui.get("vcMortStockName").setRequired(true);
        		nui.get("vcMortStockAmount").setRequired(true);
        		nui.get("vcMortStockCode").setRequired(true);
        		$(".lableReq").find("label").show();
        	}else{
        		$("#morStockNameAndCode").hide();
		        $("#morStockAmount").hide();
        		nui.get("vcMortStockName").setRequired(false);
        		nui.get("vcMortStockAmount").setRequired(false);
        		nui.get("vcMortStockCode").setRequired(false);
        		$(".lableReq").find("label").hide();
        	}
        	onMarketNoChanged();
        }
        //付息方式可增加“利随本清”，并在“票息品种”为“一次还本付息券”或者“贴现券”时自动连动选择
	  function changeEnPayInteval(e){
	  	if(e.value=="1" || e.value=="3"){
	  		nui.get("enPayInteval").setValue("0");
	  		nui.get("enPayInteval").setReadOnly(true);//设置为不可选
	  	}else{
	  		nui.get("enPayInteval").setValue(null);
	  		nui.get("enPayInteval").setReadOnly(false);
	  	}
	  }
	  function checkCPayInterestType(e){
	  	if(e.value=="0"){
	  		if(nui.get("cPayInterestType").value != "1" || nui.get("cPayInterestType").value != "3"){
	  			nui.alert("付息频率为“利随本清”的时候，息票品种为“一次还本付息券”或者“贴现券”！");
	  			nui.get("cPayInterestType").setValue(null);
	  		}
	  	}
	  }
		//加载所属行业的证监会二级
        loadVcIssueAppraiseCsrcAll();
        //加载所属行业
        loadVcIndustryAll();
	     function loadVcIssueAppraiseCsrcAll(){
	     	nui.ajax({//com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc
			    url: "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc.biz.ext",
			    type: "post",
			    data:nui.encode({type:"1"}),
			    contentType:'text/json',
			    success: function (text) {
			    	nui.get("vcIssueAppraiseCsrc").loadList(text.data);
			    }
			});
	     }
	     function loadVcIndustryAll(){
	     	nui.ajax({//com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc
			    url: "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc.biz.ext",
			    type: "post",
			    data:nui.encode({type:"2"}),
			    contentType:'text/json',
			    success: function (text) {
			    	nui.get("vcIndustry").loadList(text.data);
			    }
			});
	     }
         function onComboValidation(e) {
        var items = this.findItems(e.value);
        if (!items || items.length == 0) {
            e.errorText = "输入值不在下拉数据中";
        }
        }
        function checkvcSpecialText(e){
		   var cIsHave=e.value;
		   if(cIsHave.indexOf("2") >= 0){
           		//赎回权
           		nui.get("cIsHaveBuyback").setValue("1");
           		readonlyInput("cIsHaveBuyback","cIsHaveBuyback");
           	}else{
           	   //赎回权
           		nui.get("cIsHaveBuyback").setValue("0");
           		addInput("cIsHaveBuyback","cIsHaveBuyback");
           	}
           	if(cIsHave.indexOf("1") >= 0){
	           	//回售权
	           	nui.get("cIsHaveSaleback").setValue("1");
	           	readonlyInput("cIsHaveSaleback","cIsHaveSaleback");
           	}else{
           	    //回售权
	           	nui.get("cIsHaveSaleback").setValue("0");
	           	addInput("cIsHaveSaleback","cIsHaveSaleback");
           	}
		}
		//还原必填
		function addInput(inputNuiId,inputJQId){
			nui.get(inputNuiId).readOnly="";//nui 取消禁用
			$("#"+inputJQId+" input").attr("readonly","");// 取消 解决nui禁用IE兼容
			$("#"+inputJQId+" input").css("background-color","");//取消 置灰
		}
		/*禁用nui的input文本框，达到效果为：不可修改，可复制，置灰
		*inputNuiId nui使用的id 即 控件的id属性值
		*inputJQId jquery使用的id,jquery id不支持特殊符号 如“。”需要转义，即传入控件的id属性值转义的值
		*/
		function readonlyInput(inputNuiId,inputJQId){
			nui.get(inputNuiId).readOnly="readonly";//nui禁用
			$("#"+inputJQId+" input").attr("readonly","readonly");//解决nui禁用IE兼容
			$("#"+inputJQId+" input").css("background-color","#f0f0f0");//置灰
		}
 		</script>
      </body>
   </html>
