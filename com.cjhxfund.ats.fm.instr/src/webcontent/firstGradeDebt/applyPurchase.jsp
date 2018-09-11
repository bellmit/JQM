 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 杨敏
  - Date: 2016-07-19 15:18:15
  - Description:
-->
<head>
<title>有债券申购</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/fm/instr/processUtil/instr.js" type="text/javascript"></script>
	<script	src="<%=request.getContextPath() %>/fm/instr/processUtil/process.js" type="text/javascript"></script>
	<style type="text/css">
	   .td{
	      border-bottom: 1px solid #D3D3D3;
	   }
	   .form_label label{
	   	color:red;
	   }
	   .form_label{
	   	text-align: right;
	   }
	   #footer {z-index:999; position:fixed; bottom:0; left:0; width:100%; _position:absolute;
 _top: expression_r(documentElement.scrollTop + documentElement.clientHeight-this.offsetHeight); overflow:visible;
		    }
		#dataform2 tr{
			border-top:0px;
		}
	   
	</style>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;">
  <div id="layout1" class="nui-layout" style="width:100%;height:100%;"  >
	<div title="center"   >
		<div id="dataform1" style="padding-top:5px;">
			<table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">
			    <tr>
			    <td colspan="1" class="form_label" width="18%">
					<label>*</label>业务日期:
				  </td>
				  <td colspan="1" width="32%">
				  	<input style="width:100%" class="nui-datepicker"  id="bdApplicationTime" name="bizprocess.dApplicationTime" 
			          format="yyyy-MM-dd" required="true" />
				  </td>
				    <td colspan="1" class="form_label" width="18%">
					投标区间:	
				  </td>
				  <td colspan="1"  width="32%">
				  	<input style="width: 100%;" class="nui-textbox" inputStyle="background-color:#f0f0f0;" id="vcTenderInterval" name="stockissueinfo.vcTenderInterval" readonly="readonly"/>
				  </td>
				</tr>
				<tr>
				  <td colspan="1" class="form_label" >
					债券简称:
				  </td>
				  <td colspan="1" >
				  	<input style="width: 100%;" inputStyle="background-color:#f0f0f0;" class="nui-textbox"  id="stockissueinfo.vcStockName" name="stockissueinfo.vcStockName" readonly="readonly" />
				  	<!-- 证券投资编号 -->
				  	<input class="nui-hidden" type="hidden" id="stockissueinfo.lStockIssueId" name="stockissueinfo.lStockIssueId" readonly="readonly"/>
				  	<input class="nui-hidden" type="hidden" id="stockissueinfo.lStockInvestNo" name="stockissueinfo.lStockInvestNo" readonly="readonly"/>
				  	<input class="nui-hidden" type="hidden" id="stockissueinfo.vcStockNameFull" name="stockissueinfo.vcStockNameFull" readonly="readonly"/>
				  	<!-- 发行主体编号 -->
				  	<input class="nui-hidden" type="hidden" id="stockissueinfo.lIssuerId" name="stockissueinfo.lIssuerId" readonly="readonly"/>
				  	
				  	<input class="nui-hidden" type="hidden" id="applyInst.lStockInvestNo" name="applyInst.lStockInvestNo" readonly="readonly"/>
				  	<!-- 债券代码  债券名称--> 
				  	
				  	<input class="nui-hidden" type="hidden" id="applyInst.vcStockName" name="applyInst.vcStockName" readonly="readonly"/>
				  	<input class="nui-hidden" type="hidden" id="applyInst.vcStockCode" name="applyInst.vcStockCode" readonly="readonly"/> 
				  	<!-- 证券类型 -->
				  	
				  	<input class="nui-hidden" type="hidden" id="applyInst.vcStockType" name="applyInst.vcStockType" readonly="readonly"/>
				  	
				  	<!-- 存储报量临时数据 -->
				  	<input class="nui-hidden" type="hidden" id="report.vcReport" name="report.vcReport" value="0" readonly="readonly"/>
				    <!-- 票面利率 -->
				    <input class="nui-hidden" type="hidden" id="stockissueinfo.enFaceRate" name="stockissueinfo.enFaceRate" readonly="readonly"/>
				    <!-- 付息频率 stockissueinfo.vcFrequency -->
				    <input class="nui-hidden" type="hidden" id="stockissueinfo.vcFrequency" name="stockissueinfo.vcFrequency" readonly="readonly"/>
				    <!-- 债券表其他信息  ，提交时同步到 指令/建议表-->
				    <input class="nui-hidden" type="hidden" id="stockissueinfo.vcIssuePrice" name="stockissueinfo.vcIssuePrice" readonly="readonly"/>
				    <input class="nui-hidden" type="hidden" id="stockissueinfo.dDeadlineInterest" name="stockissueinfo.dDeadlineInterest" readonly="readonly"/>
				    <input class="nui-hidden" type="hidden" id="stockissueinfo.dStartingDateInterest" name="stockissueinfo.dStartingDateInterest" readonly="readonly"/>
				    <!-- 流程业务表 -->
				    <input class="nui-hidden" type="hidden" id="bizprocess.lProcessInstId" name="bizprocess.lProcessInstId" readonly="readonly"/>
				    <input class="nui-hidden" type="hidden" id="bizProcess.lBizId" name="bizProcess.lBizId" readonly="readonly"/>
				    
				    <input class="nui-hidden mini-datepicker" format="yyyy-MM-dd HH:mm:ss"  type="hidden" id="applyInst.dApplicationTime" name="applyInst.dApplicationTime" readonly="readonly"/>
				   
				  </td>
				  <td class="form_label" >债券代码:</td>
				  <td>
				  <input style="width: 100%;" inputStyle="background-color:#f0f0f0;" class="nui-textbox" id="stockissueinfo.vcStockCode" name="stockissueinfo.vcStockCode"  readonly="readonly" />
				  </td>
				</tr>
				<tr>
				  <td colspan="1" class="form_label">
					债券类别:
				  </td>
				  <td colspan="1" >
				  	<input style="width: 100%;" id="stockissueinfo.vcStockType" name="stockissueinfo.vcStockType" class="mini-treeselect"  multiSelect="false" 
			        textField="text" valueField="id" parentField="pid" checkRecursive="false" 
			        showFolderCheckBox="true"   expandOnLoad="true" showTreeIcon="false" onbeforenodeselect="beforenodeselect" onvaluechanged="onAccountTypeChanged"
			        popupWidth="200"  required="true" />
				  </td>
				  <td colspan="1" class="form_label">
					发行期限(年):	 
				  </td>
				  <td colspan="1">
				  	<input style="width: 100%;" class="nui-textbox" inputStyle="background-color:#f0f0f0;" name="stockissueinfo.enExistLimite" readonly="readonly"/>
				  </td>
				</tr>
				<tr>
				  <td colspan="1" class="form_label">
					发行规模(亿):	
				  </td>
				  <td colspan="1">
				  	<input style="width: 100%;" class="nui-textbox" inputStyle="background-color:#f0f0f0;" id="enIssueBalance" name="stockissueinfo.enIssueBalance" readonly="readonly"/>
				  </td>
				  <td colspan="1" class="form_label">
					主体评级:
				  </td>
				  <td colspan="1">
				   
				    <input style="width: 100%;" class="nui-dictcombobox" inputStyle="background-color:#f0f0f0;" name="stockissueinfo.cIssueAppraise" readonly="readonly" dictTypeId="issuerRating" />
				  </td>
				</tr>
				<tr>
				  <td colspan="1" class="form_label">
					<label>*</label>产品名称:
				  </td>
				  <td colspan="1">
				  
			  	<input style="width: 100%;" id="productCombo" class="mini-combobox" name="applyInst.vcProductName"  textField="TEXT" valueField="ID" 
			    url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryTAtsProductInfo.biz.ext"   value="cn" showNullItem="false" required="true" allowInput="true"
			     emptyText="请选择"  onvalidation="onComboValidation" onvaluechanged="onProductChanged"/> 
				  	<input class="nui-hidden" type="hidden" id="vcProductName" name="applyInst.vcProductName"/>
				  	<input class="nui-hidden" type="hidden" id="vcProductCode" name="applyInst.vcProductCode"/>
				  </td>
				  <td colspan="1" class="form_label">
					<label>*</label>组合名称:
				  </td>
				  <td colspan="1">
				  <input style="width: 100%;" id="combiCombo" class="mini-combobox" name="applyInst.vcCombiNo"  textField="TEXT" valueField="ID"
			     value="cn" showNullItem="false" required="true" allowInput="true"
			   emptyText="请选择" onvalidation="onComboValidation1" /> 
				  	<!-- 组合信息 -->
				  	<input class="nui-hidden" type="hidden" id="lCombiId" name="applyInst.lCombiId"/>
				  	<input class="nui-hidden" type="hidden" id="vcCombiName" name="applyInst.vcCombiName"/>
				  	<!-- 资产单元 -->
				  	<input class="nui-hidden" type="hidden" id="lAssetId" name="applyInst.lAssetId"/>
				  	<input class="nui-hidden" type="hidden" id="vcAssetNo" name="applyInst.vcAssetNo"/>
				  	<input class="nui-hidden" type="hidden" id="vcAssetName" name="applyInst.vcAssetName"/>
				  	
				  </td>
				</tr>
				<tr>
				  <td colspan="1" class="form_label">
					主承销商:
				  </td>
				  <td colspan="1">
				  	<!-- 控件开始 -->
				  	<input style="width: 87%;" class="nui-textbox"  id="stockissueinfo.vcMainUnderwriter" name="stockissueinfo.vcMainUnderwriter"/>
				  	<input id="lookup2" style="width: 25px;"    class="mini-lookup"  
				        textField="vcIssueNameFull" valueField="lIssuerId" popupWidth="auto"  
				        popup="#gridPanel"  onvalidation="onIssuerId" allowInput="true" showNullItem="true"  grid="#datagrid1" multiSelect="true" />
								     
				     <div id="gridPanel" class="mini-panel" title="header" iconCls="icon-add" style="width:450px;height:250px;" 
				        showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0" borderStyle="border:0" >
				        <div property="toolbar" style="padding:5px;padding-left:8px;text-align:center;">   
				            <div style="float:left;padding-bottom:2px;">
				                <span>主承销商：</span>                
				                <input id="keyText" class="mini-textbox" style="width:160px;" onenter="onSearchClick"/>
				                <a class="mini-button" onclick="onSearchClick3">查询</a>
				                <a class="mini-button" id="add" iconCls='icon-add' onclick="onAddClick">添加</a>
				            </div>
				            <div style="float:right;padding-bottom:2px;">
				            </div>
				            <div style="clear:both;"></div>
				        </div>
				        <div id="datagrid1"   class="mini-datagrid" style="width:100%;height:100%;" 
				            borderStyle="border:0" showPageSize="false" showPageIndex="false"
				            url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadIssueInfo.biz.ext" onRowdblclick="onCloseClickLookup">
				            <div property="columns" >
				            <div type="checkcolumn"></div>
				                <div field="vcIssueName" width="80"    headerAlign="center" allowSort="true">简称</div>
				                <div field="vcIssueNameFull" width="120"    headerAlign="center" allowSort="true">全称</div>
				            </div>
				        </div>  
				    </div>
				    <!-- 控件结束 -->
				  </td>
				  <td colspan="1" class="form_label">
					登记托管机构:
				  </td>
				  <td colspan="1">
				  <!--  
				  	<input style="width: 100%;" class="nui-dictcombobox" id="stockissueinfo.cMarketNo1" name="stockissueinfo.cMarketNo1" allowInput="true"
				 	 url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryCMarket.biz.ext" onvaluechanged="onMarcketValueChanged"   
				 	 emptyText="请选择" textField="TEXT" valueField="ID"  required="true" showNullItem="false"  />
				 -->
				  <!-- 交易市场 根据托管机构查询债券，然后带出 -->
				  <input class="nui-hidden" type="hidden" id="applyInst.cMarketNo" name="applyInst.cMarketNo"/>
				  <!-- 登记托管机构 -->
				  <input style="width: 100%;"  class="nui-dictcombobox"  id="stockissueinfo.vcPaymentPlace" onchange="onVcPaymentPlace(0)" name="stockissueinfo.vcPaymentPlace"  dictTypeId="CF_JY_DJTGCS" />
				  </td>
				</tr>
				<tr>
					<td colspan="1"  class="form_label">
					<label>*</label>投标截止日期:
				  </td>
				  <td colspan="1">
				     <!-- 日期和时间分开显示 -->
				     <input style="width: 100px;"  id="dApplicationDate" onvaluechanged="onTimeValueChanged"   class="mini-datepicker" showTodayButton="true" format="yyyy-MM-dd"  required="true" />
				     <!--<input style="width: 62px;" name="Time" id="dApplicationTime" onvaluechanged="onTimeValueChanged" class="mini-timespinner" format="HH:mm" required="true" />
				     -->
			         <input style="width: 40px;" url="../processUtil/timeHH.txt" class="nui-dictcombobox" required="true" id="dApplicationTimeHH" onvaluechanged="onTimeValueChanged" />
				                 时
				     <input style="width: 40px;" url="../processUtil/timeMM.txt" class="nui-dictcombobox" required="true" id="dApplicationTimeMM" onvaluechanged="onTimeValueChanged" />
				                 分
				     <!-- 提醒的时间 -->
				     <input class="nui-hidden" type="hidden"    id="bidRemind"  />
				   </td>
				   <td colspan="1" class="form_label">
					发行主体全称:
				  </td>
				  <td colspan="1">
				  	<input style="width: 100%;" class="nui-textbox" name="stockissueinfo.vcIssuerNameFull" inputStyle="background-color:#f0f0f0;" readonly="readonly"/>
				  </td>
				</tr>
				<tr>
				   
				  
				  <td colspan="1" class="form_label">
					交易对手:	
				  </td>
				  <td colspan="1">
				  	  <!--<input class="nui-dictcombobox" name="stockissueinfo.lIssuerId" allowInput="true"
				     onvalidation="onIssuerId" 
				  	 url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadIssueInfo.biz.ext"   emptyText="请选择" textField="TEXT" valueField="ID"  required="true" showNullItem="false"  />
				      	控件内容  开始-->
				     <input class="nui-hidden" type="hidden" id="hlRivalId" name="applyInst.lRivalId"/>
				     <input id="lookup3" style="width: 100%;" name="applyInst.vcBusinessObject" class="mini-lookup"  
				        textField="vcAllName" valueField="lRivalId" popupWidth="auto"  
				        popup="#gridPanel3"   onvalidation="onIssuerId3" grid="#datagrid3" multiSelect="false"  onclick="onClearClick3();onSearchClick3()"/>
				     <div id="gridPanel3" class="mini-panel" title="header" iconCls="icon-add" style="width:450px;height:250px;" 
				        showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0" borderStyle="border:0" >
				        <div property="toolbar" style="padding:5px;padding-left:8px;text-align:center;">   
				            <div style="float:left;padding-bottom:2px;">
				                <span>交易对手：</span>                
				                <input id="keyText3" class="mini-textbox" style="width:160px;" onenter="onSearchClick3"/>
				                <a class="mini-button" onclick="onSearchClick">查询</a>
				                <!-- <a class="mini-button" id="add" iconCls='icon-add' onclick="onAddClick">添加</a> -->
				            </div>
				            <div style="float:right;padding-bottom:2px;">
				            </div>
				            <div style="clear:both;"></div>
				        </div>
				        <div id="datagrid3"   class="mini-datagrid" style="width:100%;height:100%;" 
				            borderStyle="border:0" showPageSize="false" showPageIndex="false"
				            url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.LoadCounterpartyInfo.biz.ext" onRowdblclick="onCloseClickLookup3">
				            <div property="columns" >
				                <div field="vcName" width="80"    headerAlign="center" allowSort="true">简称</div>
					            <div field="vcAllName" width="120"    headerAlign="center" allowSort="true">全称</div>
				            </div>
				        </div>  
				    </div>
				     <!-- 控件内容  结束-->
				  </td>
				  <td colspan="1"  class="form_label">
					  所属行业(证监会二级):
				  </td>
				  <td colspan="1">
				    <input style="width: 100%;" inputStyle="background-color:#f0f0f0;" readonly="readonly" class="nui-textbox" id="vcIssueAppraiseCsrc" name="stockissueinfo.vcIssueAppraiseCsrc" />
				   </td>
				  </tr>
				  <tr>
					<td colspan="1" class="form_label">
						 公司净资产:
					  </td>
					  <td colspan="1"  >
					  	<input style="width: 100%;" inputStyle="background-color:#f0f0f0;" readonly="readonly" class="nui-textbox" id="enIssuerNetValue" name="stockissueinfo.enIssuerNetValue" />
					  </td>
					  <td colspan="1" class="form_label">
						 <label>*</label> 发行日期
					  </td>
					  <td colspan="1">
					    <input style="width: 100%;"  id="lIssueBeginDate" name="stockissueinfo.lIssueBeginDate" required="true" class="mini-datepicker" showTodayButton="true"  />
					  </td>
					</tr>
					<tr>
					  <td colspan="1" class="form_label">
						城投行政级别:
					  </td>
					  <td colspan="1"  >
					  	<input style="width: 100%;" inputStyle="background-color:#f0f0f0;" readonly="readonly" id="vcCityLevel" class="nui-dictcombobox" name="stockissueinfo.vcCityLevel" 
					     showNullItem="true"  emptyText="---请选择---" nullItemText="---请选择---" dictTypeId="cityLevel" />
					  </td>
					  <td colspan="1" class="form_label">
						  下一利率跳升点数:
					  </td>
					  <td colspan="1">
					    <input style="width: 100%;" vtype="float" inputStyle="background-color:#f0f0f0;" readonly="readonly" class="nui-textbox" id="lNInterestRateJumpPoints" name="stockissueinfo.lNInterestRateJumpPoints" />
					  </td>
					</tr>
				    
				<tr>
					<td colspan="1" class="form_label">
					下一行权日:
					</td>
					<td colspan="1" >
					<input style="width: 100%;" class="nui-datepicker"  inputStyle="background-color:#f0f0f0;" id="lNextExerciseDate" name="stockissueinfo.lNextExerciseDate" style="width: 170px;" readonly="readonly"/>
					</td>
					<td colspan="1" class="form_label">
					特殊条款:	
				    </td>
				    <td colspan="1">
				    	<input style="width: 100%;" class="nui-dictcombobox" inputStyle="background-color:#f0f0f0;" name="stockissueinfo.vcSpecialText"  valueField="dictID" textField="dictName" dictTypeId="specialText"  
									emptyText="请选择" nullItemText="请选择" multiSelect="true" showClose="true" valueFromSelect="true" width="100%" oncloseclick="onCloseClickValueEmpty" readonly="readonly"/>
				   </td>
				</tr>
				<tr id="mortInfo" style="display:none">
					<td colspan="1" class="form_label">
						 <label>*</label>股票名称:
					  </td>
					  <td colspan="1"  >
					  	<input style="width: 100%;" class="nui-textbox" id="vcMortStockName" required="true" name="stockissueinfo.vcMortStockName" />
					  </td>
					  <td colspan="1" class="form_label">
						  <label>*</label> 股票代码:
					  </td>
					  <td colspan="1">
					    <input style="width: 100%;" class="nui-textbox" id="vcMortStockCode" required="true" name="stockissueinfo.vcMortStockCode" />
					  </td>
					</tr>
					<tr id="mortAmount" style="display:none">
					  <td colspan="1" class="form_label" >
						   <label>*</label>股票抵押数量(万股):
					  </td>
					  <td colspan="1" >
					  	<input style="width: 100%;" class="nui-textbox" id="vcMortStockAmount" required="true" vtype="float" name="stockissueinfo.vcMortStockAmount" />
					  </td>
					  <td colspan="1" class="form_label" >
						   
					  </td>
					  <td colspan="1">
					    
					  </td>
					</tr>
				<tr>
				  <td colspan="1" class="form_label td">
					备注:	
				  </td>
				  <td colspan="3" class="td">
				  	<input class="nui-textarea" width="80%" name="applyInst.vcRemarks"/>
				  </td> 
				</tr>						
			</table>
				<table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">	
						<tr>
		                    <td width="15%" class="form_label">
		                                                  产品净值规模(万元):
		                    </td>
		                    <td colspan="1">
								<input class="nui-textbox" id="enNetScale" style="width: 80%;" onvaluechanged="BondAccountedCalculation"/>
		                    </td> 
		                    <td width="25%" class="form_label">
				                       已投资该发行主体债券存量(万元):
				            </td>
				            <td colspan="1">
								<input class="nui-textbox"  id="fsumamount" style="width: 60%;float: left;margin-right: 5px;" onvaluechanged="BondAccountedCalculation"/>
								<a class='nui-button' plain='false' onclick="Calculation()" iconCls="icon-reload">刷新</a>
				             </td>
		                </tr>
		                <tr>
			                <td class="form_label td1" align="right">债券占比：</td>
			                <td colspan="3" style="padding: 0px;margin: 0xp;" class="td2">
			                    <p class="p"><label style="margin-left: 5px;font-weight: inherit;">该笔债券投资占发行规模比例(%): </label>
			                   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			                   				<input class="nui-textbox asLabel" id="enInvestScaleRatio" readonly="readonly"/></p>
			                	<p class="p"><label style="margin-left: 5px;font-weight: inherit;">同一发行主体占产品净值规模比例(%): </label>
			                   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					                   		<input class="nui-textbox asLabel" id="enIssuerNetRatio" readonly="readonly"/></p>
			                    <p class="p"><label style="margin-left: 5px;font-weight: inherit;">该笔债券投资占产品净值规模比例(%): </label>
			                   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					                   		<input name="firstGradeBond.enInvestNetRatio" id="enInvestNetRatio" class="nui-textbox asLabel" readonly="readonly"/></p>
					            <p><label style="margin-left: 5px;font-weight: inherit;">弱流动性资产规模占产品净值规模比例(%): </label>
					                   		<input name="firstGradeBond.enWeakNetRatio" id="enWeakNetRatio" class="nui-textbox" /></p>
			                </td>
			              </tr>
			     </table> 
		<div title="报量录入">
			<div class="nui-toolbar" style="border-bottom:0;padding:0px;margin-top: 2px;height: 25px;">
				<table style="width:100%;">
					<tr>
						<td style="width:100%;">
			          		&nbsp;&nbsp;报量录入
						</td>
						<td>
							<a class="nui-button " plain="false" iconCls="icon-add" onclick="gridAddRow('datagrid')"  plain="false" tooltip="增加">
			            		&nbsp;
			          		</a>
			        	</td>
			        	<td >
			          		<a class="nui-button " plain="false" iconCls="icon-remove" onclick="gridRemoveRow('datagrid')"  plain="false" tooltip="删除">
			            		&nbsp;
			          		</a>
			        	</td>
			        	<td >
	                  		<a class="nui-button " plain="false" iconCls="icon-reload" onclick="gridReload('datagrid')"  plain="false" tooltip="刷新">
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
				<div style="width:65%;float: left;padding-left: 10px;"><b>说明：</b>①报量为100万整数倍；②特殊说明请在报量说明中填写；③报价待定时为空即可</div>
				<div style="width:30%;float: right;padding-right: 10px;text-align: right;line-height: 50px;">
				<label>*</label>报量方式：<input style="width: 140px;" id="reportType"  name="applyInst.cReportType" url="<%= request.getContextPath() %>/fm/instr/processUtil/reportData.txt" class="nui-dictcombobox" required="true"  />
				</div>
			</div>
				<div class="nui-datagrid" id="datagrid"  url="" height="120px" showPager="false" allowSortColumn="false" allowCellSelect="true" 
				allowCellEdit="true" multiSelect="true" allowCellValid="true" oncellvalidation="reportEdit" >
					<div property="columns">
						<div field="enReport"  headerAlign="center" allowSort="true">
							<label style="color:red">*</label>报量(万元)
							<input id="enReport" class="nui-textbox"  name="enReport" property="editor" required="true"/>
						</div>
						<div field="enOffer"  headerAlign="center" allowSort="true">
							报价(%)
							<input id="enOffer" class="nui-textbox" name="enOffer" property="editor" />
						</div>
						<!--  <div field="enEnsureGold"  headerAlign="center" allowSort="true">
							保证金(万元)
							<input id="enEnsureGold" class="nui-textbox" name="enEnsureGold" property="editor" />
						</div>-->
						<div field="vcReportRemark"  headerAlign="center" allowSort="true">
							报量说明
							<input id="vcReportRemark" class="nui-textbox" name="vcReportRemark" property="editor" />
						</div>
					</div>
				</div>
			</div>        	 
			<table style="width:100%; table-layout:fixed;margin-top: 2px;" border="0" class="nui-form-table">
			    <tr>
				    <td class="form_label td" align="right" width="15%">
		                        附件上传:
					</td>
					<td colspan="3" class="td">
						<iframe id="prodIfm" width="590"  height="130px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" 
						  ></iframe>
					</td>
				</tr>
			</table> 
			<div style="height: 30px;">&nbsp;</div>
		</div>
	</div>
	<!-- 投资范围 -->
	<!-- 居右east，据左west -->
	<div  title="投资范围" region="east" width="220" showCloseButton="false"
		showSplitIcon="true">
		<div id="dataform2">
			<!-- hidden域 -->
			<input type="hidden" class="nui-hidden" name="cfjyProductInvestRange.productid" />
			<table style="width: 100%; height: 100%; table-layout: fixed;"
				class="nui-form-table" >
				<tr>
					<td colspan="3">产品名称：
					<input class="nui-textbox" width="100%" inputStyle="background-color:#f0f0f0;" name="ProductInvestRange.combProductName" readonly/>
					</td>
				</tr>
				<tr>
					<td colspan="3">可投范围：
					<input class="nui-textarea" width="100%"
						height="120" name="ProductInvestRange.voteRange" inputStyle="background-color:#f0f0f0;" readonly /> 
					</td>
				</tr>
				<tr>
					<td colspan="3">禁投范围：
					<input class="nui-textarea" width="100%"
						height="120" name="ProductInvestRange.noCastRange" inputStyle="background-color:#f0f0f0;" readonly /> 
					</td>
				</tr>
				<tr>
					<td colspan="3">投资限制：
					<input class="nui-textarea" width="100%"
						height="120" name="ProductInvestRange.investmentLimit" inputStyle="background-color:#f0f0f0;" readonly />
					</td>
				</tr>
			</table>
		 </div>
	  </div>
    </div>
	
	<div style="height: 50px;">&nbsp;</div>
    <div id="footer" class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align:center;" colspan="4">
					<a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">
                                                                        保存
					</a>
					<span style="display:inline-block;width:25px;"></span>
					<a class='nui-button' plain='false' iconCls="icon-save" onclick="windControlTrial()">
                                                                        风控试算
					</a>
					<span style="display:inline-block;width:25px;"></span>
					<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
                                                                          取消
					</a>
				</td>
			</tr>
		</table>
	</div>
 	<!--隐藏表单-->
	<form action="" name="openForm" method="post" target="_blank">
	  <input type="hidden" name="workItemID" id="workItemID">
	  <input type="hidden" name="processInstID" id="processInstID">
	  <input type="hidden" name="bizId" id="bizId1">
	  <input type="hidden" name="pageType" id="pageType" value="1"/>
	</form>

	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid");
    	var grid3 = nui.get("datagrid3");
    	var processInstID="<%=request.getParameter("processInstID")%>";
		var blgrid = nui.get("datagrid");
		blgrid.addRows([ {}, {}, {} ]);//默认添加3行
		
		var grid1 = mini.get("datagrid1");
        var keyText = mini.get("keyText");

        grid1.load();
		//查询发行人
        function onSearchClick(e) {
            grid1.load({
                key: keyText.value
            });
        }
        function onCloseClickLookup(e) {
            var lookup2 = mini.get("lookup2");
            lookup2.hidePopup();
        }
        function onClearClick(e) {
            //var lookup2 = mini.get("lookup2");
            //lookup2.deselectAll();
            //nui.get("applyInst.vcBusinessObject").setValue("");
            //修改为情况查询条件
            nui.get("keyText").setValue("");
        }
        
        function onIssuerId(e){
        	
        	nui.get("stockissueinfo.vcMainUnderwriter").setValue(e.source.text);
        }
        function onSearchClick3(e) {
            grid3.load({
                key: keyText.value
            });
        }
        function onCloseClickLookup3(e) {
        	
            var lookup3 = mini.get("lookup3");
            lookup3.hidePopup();
        }
        function onClearClick3(e) {
            //var lookup2 = mini.get("lookup2");
            //lookup2.deselectAll();
            //nui.get("applyInst.vcBusinessObject").setValue("");
            //修改为情况查询条件
            nui.get("keyText3").setValue("");
        }
        function onIssuerId3(e){
        	nui.get("lookup3").setValue(e.source.text);
        }
		
		var productCombo = mini.get("productCombo");
		var combiCombo = mini.get("combiCombo");
		//产品下拉改变事件		
		function onProductChanged(e) {
			var vcProductCode = productCombo.getValue();

			combiCombo.setValue("");

			var url = "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryCombiInfo.biz.ext?vcProductCode="
					+ vcProductCode;
			combiCombo.setUrl(url);

			combiCombo.select(0);
			//设置投资范围界面参数
			//nui.get("tabs").tabs[1].url = "<%=request.getContextPath() %>/fm/comm/ProductInvestmentRange.jsp?vcProductCode="+vcProductCode;
            //因参数改变重新tabs
            //nui.get("tabs").reloadTab(nui.get("tabs").tabs[1]);
            //装载组合相关信息
            var com=nui.get("combiCombo").getSelected();
            var data=nui.get("combiCombo").data;
        	//获取选中产品的其他数据
        	for(var i=0;i<data.length;i++){
        		//查找选中的数据
        		if(data[i].ID==com.ID){
        			//产品组合
        			nui.get("lCombiId").setValue(data[i].L_COMBI_ID);
        			nui.get("vcCombiName").setValue(data[i].VC_COMBI_NAME);
        			
        			//资产单元
        			nui.get("lAssetId").setValue(data[i].L_ASSET_ID);
        			nui.get("vcAssetNo").setValue(data[i].VC_ASSET_NO);
	        		nui.get("vcAssetName").setValue(data[i].VC_ASSET_NAME);
        		}
        	}
        	//查询、填充投资范围
        	Init(vcProductCode);
        }
        
        //报量值改变计算分控比例 
        function Calculation(){
        	//查询净值规模和发行存量 
        	queryScaleDaet();
        }
        //查询净值规模和发行存量 
        function queryScaleDaet(){
        	var vcProductCode = productCombo.getValue();
        	var lIssuerId =  nui.get("stockissueinfo.lIssuerId").getValue();
        	var json = nui.encode({vcProductCode : vcProductCode,lIssuerId : lIssuerId});

	        $.ajax({
	            url:"com.cjhxfund.ats.fm.instr.atsFmBiz.getVfundasset.biz.ext",
	            type:'POST',
	            data:json,
	            cache:false,
	            async:false,
	            contentType:'text/json',
	            success:function(text){
	                var returnJson = nui.decode(text);
	                if(returnJson.returnCode != 1){
		                if(null == returnJson.enFundValue[0].ENFUNDVALUE){
		                	nui.get("enNetScale").setValue(0);
		                }else{
		                	nui.get("enNetScale").setValue(returnJson.enFundValue[0].ENFUNDVALUE/10000);
		                	formatNumberCommon("enNetScale",4);
		                }
		                if(null == returnJson.fsumamount[0].FSUMAMOUNT){
		                	nui.get("fsumamount").setValue(0);
		                }else{
		                	nui.get("fsumamount").setValue(returnJson.fsumamount[0].FSUMAMOUNT);
		                }
		             }else{
	                   nui.get("enNetScale").setValue(0);
	                   nui.get("fsumamount").setValue(0);
	               }
	                BondAccountedCalculation();
	           }
			});
        }
        
        //人工风控控制计算比例值
		function BondAccountedCalculation(){
			var enIssueBalance = nui.get("enIssueBalance").getValue().replace(/,/gi,'');        //发行规模
			var form = new mini.Form("#dataform1");
			//校验表单
			if(!form.validate()){
				nui.alert("有数据为空，请确认！");
				return;
			}
			var reportData= getReportDatagrid(grid,form);
			if(reportData==false){
				//数据不通过校验
				return;
			}
			var data = form.getData(false,true);      //获取表单多个控件的数据
		    var enInvestBalance = getReportBidInfo(reportData.applyInstReport,data.applyInst).enInvestBalance; 	    //投标金额		   
		    var enNetScale = nui.get("enNetScale").getValue().replace(/,/gi,'');  				//净值规模
		    var enCategoryMoney = nui.get("fsumamount").getValue().replace(/,/gi,'');      		//债券存量		
		    //当发行规模与投标金额不为空并且不为0时计算该笔债券投资占发行规模比例
			//公式为投标金额/发行规模
			if(enIssueBalance != "" && enInvestBalance != "" && enIssueBalance != 0 && enInvestBalance != 0){
			   nui.get("enInvestScaleRatio").setValue(((enInvestBalance/(enIssueBalance * 10000)) * 100).toFixed(6));
			}else{
			   nui.get("enInvestScaleRatio").setValue(0);
			}
			       
			//当投标金额、债券存量与净值规模都不为空并且都不为0时计算同一发行人占产品净值规模比例
			//公式为(本次投标金额+主体发行债券存量)/净值规模
			if(enNetScale != "" && (enInvestBalance != "" || enCategoryMoney != "")){
			    if(enNetScale != 0){
			       nui.get("enIssuerNetRatio").setValue((((Number(enInvestBalance) + Number(enCategoryMoney))/enNetScale) * 100).toFixed(6));
			    }
			}else{
			   nui.get("enIssuerNetRatio").setValue(0);
			}
			       
			//当净值规模与投标金额不为空并且不为0时计算该笔债券投资占产品净值规模比例
			//公式为投标金额/净值规模
			if(enNetScale != "" && enInvestBalance != "" && enNetScale !=0 && enInvestBalance != 0){
			   nui.get("enInvestNetRatio").setValue(((enInvestBalance/enNetScale) * 100).toFixed(6));
			}else{
			   nui.get("enInvestNetRatio").setValue(0);
			}	
		}
        
        //查询投资范围
        function Init(vcProductCode){
            var json = nui.encode({vcProductCode : vcProductCode});

	        $.ajax({
	            url:"com.cjhxfund.ats.fm.comm.common.expandProductInvestRange.biz.ext",
	            type:'POST',
	            data:json,
	            cache:false,
	            contentType:'text/json',
	            success:function(text){
	                var returnJson = nui.decode(text);
	                var form = new nui.Form("#dataform2");//将普通form转为nui的form
	                    form.setData(returnJson);
	                   	form.setChanged(false);
	           }
			});
        }
        //控制 产品限制输入
		function onComboValidation(e){
			var items = this.findItems(e.value);
            if (!items || items.length == 0) {
                e.isValid = false;
                e.errorText = "输入值不在下拉数据中";
            }else{
            	//设置申购相关产品信息
            	var data=e.source.data;
            	//获取选中产品的其他数据
            	for(var i=0;i<data.length;i++){
            		//查找选中的数据
            		if(data[i].ID==e.value){
            			nui.get("vcProductCode").setValue(data[i].VC_PRODUCT_CODE);
            			nui.get("vcProductName").setValue(data[i].VC_PRODUCT_NAME);
            		}
            	}
            }
		}
		//限制组合输入
		function onComboValidation1(e){
			var items = this.findItems(e.value);
            if (!items || items.length == 0) {
                e.isValid = false;
                e.errorText = "输入值不在下拉数据中";
            }else{
            	//设置申购相关产品信息
            	
            	
            	var data=e.source.data;
            	//获取选中产品的其他数据
            	for(var i=0;i<data.length;i++){
            		//查找选中的数据
            		if(data[i].ID==e.value){
            			//产品组合
            			nui.get("lCombiId").setValue(data[i].L_COMBI_ID);
            			nui.get("vcCombiName").setValue(data[i].VC_COMBI_NAME);
            			//资产单元
	        			nui.get("lAssetId").setValue(data[i].L_ASSET_ID);
	        			nui.get("vcAssetNo").setValue(data[i].VC_ASSET_NO);
	        			nui.get("vcAssetName").setValue(data[i].VC_ASSET_NAME);
            		}
            	}
            }
		}
		function beforenodeselect(e) {
            //禁止选中父节点
            if (e.isLeaf == false) e.cancel = true;
        }
		//投标截止日期处理
		function onTimeValueChanged(e){
		    
			//获取日期和时间
			var dApplicationDate=nui.get("dApplicationDate").getValue().substr(0,10);
			var dApplicationHH=nui.get("dApplicationTimeHH").getValue();
			var dApplicationMM=nui.get("dApplicationTimeMM").getValue();
			
			var dApplicationTime1=dApplicationHH+":"+dApplicationMM+":00";
			//转换为毫秒数
			var startdata=dApplicationDate+" "+dApplicationTime1;
			//注意 new date(); IE8以下 不兼容，必须将 “-” 转换  “/”
			startTime=Date.parse(new Date(startdata.replace(/-/g,"/")));
			//获取的当前时间毫秒数 .getTime() 和  Date.parse（） 作用一样
			var myDate = (new Date()).getTime();
			var bidRemind=nui.get("bidRemind").getValue();
			bidRemind=(bidRemind==""||bidRemind==null)?60:bidRemind;
			var tempTime=startTime-myDate;
			if(tempTime<=0){
				nui.alert("当前时间已过投标截止时间:"+startdata+"，请确认！");
				return false;
			}
			if(tempTime<=(bidRemind*60000)){
				
				//提交校验
				if(e==""){
					nui.alert("当前时间距离投标截止时间:"+startdata+",只剩 ："+parseInt(tempTime/60000)+" 分钟,不足： "+bidRemind+" 分钟，请确认！","申购提醒",function(act){
						if(act=="ok"){
							//校验后续方法
							if(onVcPaymentPlace(1)==false){
								return;
							}
						}
					});
					return false;
				}else{
					nui.alert("当前时间距离投标截止时间:"+startdata+",只剩 ："+parseInt(tempTime/60000)+" 分钟,不足： "+bidRemind+" 分钟，请确认！");
					return false;
				}
			}
			return true;
			
		}
		//登记机构改变事件
		function onVcPaymentPlace(sibk){
			var place=nui.get("stockissueinfo.vcPaymentPlace").getValue();
			var code=nui.get("stockissueinfo.vcStockCode").getValue();
			var cMarketNo="";//交易场所
			//将等级机构转为交易场所
	        if(place==3){
	        	cMarketNo=1;
	        }else if(place==4){
	        	cMarketNo=2;
	        }else{
	        	cMarketNo=5;
	        }
	        //将登记场所转换为交易场所 赋值 到交易场所
	        nui.get("applyInst.cMarketNo").setValue(cMarketNo);
	        
			if(place!="" && cMarketNo!=5 && code!=""){
				if(code.length>6){
					nui.alert("当前债券代码大于超6位，不能再该登记托管机构下！");
					return false;
				}
			}
			return onStockType(sibk);
		}
		//债券类型改变事件
		function onStockType(sibk){
			
			var lStockIssueId=nui.get("stockissueinfo.lStockIssueId").getValue();
			var form = new mini.Form("#dataform1");
			form.loading();//加载遮罩
			//交易债券是否存在
			nui.ajax({
			    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.checkStockIssueInfo.biz.ext",
			    type: "post",
			    data: {
			    	vcStockCode:nui.get("stockissueinfo.vcStockCode").getValue(),
    				cMarketNo:nui.get("applyInst.cMarketNo").getValue(),
			    	lStockIssueId:lStockIssueId,lStockInvestNo:nui.get("stockissueinfo.lStockInvestNo").getValue()},
			    dataType:"json",
			    success: function (text) {
			       form.unmask();//取消遮罩
			       if(text.out==false){
			       		nui.confirm("当前债券已经存在多条，是否继续申购！","申购提醒",function(action){
			       			if(action == "ok"){
			       				//回调提交方法
			       				applySubmit();
			       			}
			       		});
			       		return false;
			       }else{
			       		//判定是否需要回调
			       		if(sibk!=0){
			       			//回调提交方法
			       			applySubmit();
			       		}
			       		return true;
			       }
			       
			    }
			});
			return false;
		}
		
		
		var bizId;
		//跨页面参数传递参数
		function setFormData(data){
    	    //跨页面传递的数据对象，克隆后才可以安全使用
	   		var infos = nui.clone(data);
	   		var data = {StockIssueId:infos.lStockIssueId};
	   		/*String workItemID = request.getParameter("workItemID");        //工作项ID
			   String bizId = request.getParameter("bizId");                  //业务ID
			   String processinstid = request.getParameter("processinstid");  //流程ID
			*/
	   		
	   		//判定回退
	   		if(processInstID!="null" && processInstID!="" && processInstID!=null){
	   			data = {StockIssueId:infos.lStockIssueId,processInstID:processInstID};
	   		}else{
	   			processInstID="";
	   		}
			var json = nui.encode(data);
			$.ajax({
				url:"com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadApplyInstBiz.biz.ext",
				type:'POST',
				data:json,
				cache:false,
				contentType:'text/json',
				success:function(text){
					var returnJson = nui.decode(text);
					var form = new nui.Form("#dataform1");//将普通form转为nui的form
					nui.get("stockissueinfo.vcStockType").loadList(returnJson.stockTypeData);//设置债券信息
					//加载债券类型数据
					var cMarketNo=returnJson.stockissueinfo.vcPaymentPlace;
					var nextDate =returnJson.stockissueinfo.lNextExerciseDate;
					returnJson.stockissueinfo.lNextExerciseDate = dateTemp(nextDate);			
					form.setData(returnJson);
					form.setChanged(false);
					/*//校验债券是否合法（债券代码和登记托管机构是否存在）
					if(cMarketNo!="" && cMarketNo!=null){
						onMarcketValueChanged({value:cMarketNo,selected:{dictName:nui.get("stockissueinfo.vcPaymentPlace").text}});
					}*/
					//获取投标截止时间
					var dApplicationTime=returnJson.stockissueinfo.dBidLimitTime;
					if(dApplicationTime!="" && dApplicationTime!=null){
						nui.get("dApplicationDate").setValue(dApplicationTime);
						//设置时间
						nui.get("dApplicationTimeHH").setValue(dApplicationTime.getHours());
						nui.get("dApplicationTimeMM").setValue(dApplicationTime.getMinutes());
					}
					//通过债券类别控制股票信息展示stockissueinfo.vcStockType
					var vcStockType1=returnJson.stockissueinfo.vcStockType;
					if(vcStockType1!="" && vcStockType1!=null){
						onAccountTypeChanged1(vcStockType1);
					}
					//设置发行日期lIssueBeginDate
					nui.get("lIssueBeginDate").setValue(dateTemp(returnJson.stockissueinfo.lIssueBeginDate));
					var bdApplicationTime =returnJson.bdApplicationTime;
					//设置业务时间
					nui.get("bdApplicationTime").setValue(bdApplicationTime);
					bizId=returnJson.bizProcess.lBizId;
					//投标截止提醒时间
					nui.get("bidRemind").setValue(text.timeParam);
					//将债券的主承商填充到指令/建议的交易对手
					//nui.get("applyInst.vcBusinessObject").setValue(returnJson.stockissueinfo.vcMainUnderwriter);
					
					//加载附件
					$("#prodIfm").attr("src","<%=request.getContextPath() %>/fm/comm/fileupload/any_upload.jsp?bizId="+bizId+"&attachType=3&attachBusType=1");
					
				}
			});	
    	}
		
		//提交数据
		function onOk(){
			//获取表单提交数据
			var form = new mini.Form("#dataform1");
			var lIssueBeginDate= dateTemp(nui.get("lIssueBeginDate").getValue());//发行日期
			if(lIssueBeginDate=="" || lIssueBeginDate=="null"){
			        nui.alert("发行日期不能为空，请确认!","提示");
	    			return;
	    		}
    		 lIssueBeginDate=Date.parse(new Date(lIssueBeginDate.replace(/-/g,"/")));
    		var bdApplicationTime1= dateTemp(nui.get("bdApplicationTime").getValue());//业务日期
			if(bdApplicationTime1=="" || bdApplicationTime1=="null"){
			        nui.alert("业务日期不能为空，请确认!","提示");
	    			return;
	    		}
    		bdApplicationTime1=Date.parse(new Date(bdApplicationTime1.replace(/-/g,"/")))-86400000;
			
        	if(bdApplicationTime1>lIssueBeginDate){
        			nui.alert("业务日期不能大于发行日期!","提示");
        			return;
        		}
			//验证投标时间
			if(onTimeValueChanged("")==false){
				return;
			}
			//校验债券重复和债券代码+市场合法性
			if(onVcPaymentPlace(1)==false){
				return;
			}
			
			applySubmit();
			
		}
		
		function applySubmit(){
			//获取表单提交数据
			var form = new mini.Form("#dataform1"); 
			//vcMainUnderwriter form.validate()后重新赋值，解决校验后值消失问题
			var vcMainUnderwriter=nui.get("stockissueinfo.vcMainUnderwriter").getValue();
			//校验表单
			if(!form.validate()){
				nui.get("stockissueinfo.vcMainUnderwriter").setValue(vcMainUnderwriter);
				nui.alert("有数据为空，请确认！");
				return;
			}
			nui.get("stockissueinfo.vcMainUnderwriter").setValue(vcMainUnderwriter);
			//定义存储报量
			var applyInstReport=new Array();
			
			var reportData=getReportDatagrid(grid,form);
			if(reportData==false){
				//数据不通过校验
				return;
			}
			//赋值获取报量相关信息
			applyInstReport=reportData.applyInstReport;
			
			/**---------------表单数据处理--------------------**/
			var data = form.getData(false,true);      //获取表单多个控件的数据
			var stockissueinfo,bizprocess;
			stockissueinfo=data.stockissueinfo;
			//获取投标金额和投标利率
			var applyInst=getReportBidInfo(applyInstReport,data.applyInst);
			//applyInst=data.applyInst;
			bizprocess=data.bizprocess;
			bizprocess.vcAbstract="一级债有债券申购";
		  	//债券信息 赋值到指令/建议表
			applyInst.lStockInvestNo=stockissueinfo.lStockInvestNo;
			applyInst.vcStockName=stockissueinfo.vcStockName;
			applyInst.vcStockNameFull=stockissueinfo.vcStockNameFull;
			applyInst.vcStockCode=stockissueinfo.vcStockCode;
			applyInst.vcStockType=stockissueinfo.vcStockType;//证券类别
			//applyInst.enExistLimite=stockissueinfo.enExistLimite;//年限
			//applyInst.vcIssueSize=stockissueinfo.vcIssueSize;//规模
			applyInst.cIssueAppraise=stockissueinfo.cIssueAppraise;//主体评级
			//净值规模和发行主体存量 
			applyInst.enNetScale = nui.get("enNetScale").getValue().replace(/,/gi,'');
			stockissueinfo.enCategoryMoney = nui.get("fsumamount").getValue().replace(/,/gi,'');
			applyInst.enInvestScaleRatio = nui.get("enInvestScaleRatio").getValue();
			applyInst.enIssuerNetRatio = nui.get("enIssuerNetRatio").getValue();
			applyInst.enInvestNetRatio = nui.get("enInvestNetRatio").getValue();
			applyInst.enWeakNetRatio = nui.get("enWeakNetRatio").getValue();
			
			//applyInst.dBidLimitTime=stockissueinfo.dBidLimitTime;//投标截止时间
			//组装时间
			var sBidLimitTime=nui.get("dApplicationDate").text + " " + nui.get("dApplicationTimeHH").text+":"+nui.get("dApplicationTimeMM").text+":00";
			stockissueinfo.dBidLimitTime=sBidLimitTime;
			applyInst.dBidLimitTime=sBidLimitTime;//投标截止日
			//applyInst.dBidLimitTime=sBidLimitTime;//投标截止日
			
			applyInst.vcIssuePrice=stockissueinfo.vcIssuePrice;//发行价格
			applyInst.enPayInteval=stockissueinfo.vcFrequency;//付息频率
			//applyInst.dDeadlineInterest=stockissueinfo.dDeadlineInterest;//计息截止日
			//applyInst.dStartingDateInterest=stockissueinfo.dStartingDateInterest;//计息起始日
			applyInst.vcBusinessType=1;//非可转;
			bizprocess.vcProcessType=1;//流程类型:1-一级债券申购,2-新债录入,3-新债修改,4-新债查重,5-一级债无债券申购
			applyInst.cStatus=2;//复核状态 0草稿,1待复核,2正常,3合并中,4失效
			applyInst.lValidStatus=0;//指令/建议单状态:0-有效;1-无效-修改;2-无效-废弃;3-有效-退回;4-无效-退回;
			applyInst.vcPaymentPlace=stockissueinfo.vcPaymentPlace;//登记机构
			//stockissueinfo.vcMainUnderwriter=applyInst.vcBusinessObject;//回填主承商
			//获取附件数量
			var attachCount = getAttachCount(bizId);
			applyInst.lAttchCount=attachCount;//通过查询获取该zhi
			//流程实例ID
			bizprocess.lProcessInstId=processInstID=="null"?"":processInstID;
			bizprocess.lBizId=bizId;
			
			/*nui.get("dApplicationTimeHH").setValue(dApplicationTime.getHours());
			nui.get("dApplicationTimeMM").setValue(dApplicationTime.getMinutes());*/
			
			
			//组装业务日期 加入时分秒，默认当前时间的时分秒
			var date=new Date();
			var dApplicationTime=nui.get("bdApplicationTime").text+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
			bizprocess.dApplicationTime=dApplicationTime;
			applyInst.dApplicationTime=dApplicationTime;
			var lIssueBeginDate1=stockissueinfo.lIssueBeginDate.replace(/-/gi,'').substr(0,8);//发行日期
			var cMarketNo=stockissueinfo.cMarketNo;
			//债券表登记托管机构转换
 			if(cMarketNo==3){
	        	cMarketNo=1;
	        }else if(cMarketNo==4){
	        	cMarketNo=2;
	        }else{
	        	cMarketNo=5;
	        }
			//定义需要提交的新债数据，注意是需要提交的（登记托管机构更改、投标截止时间，债券类型,主承商），不是所有 
			var stockIssueInfoTemp={lStockIssueId:stockissueinfo.lStockIssueId,dBidLimitTime:stockissueinfo.dBidLimitTime,vcStockType:stockissueinfo.vcStockType,
			vcPaymentPlace:stockissueinfo.vcPaymentPlace,vcMainUnderwriter:stockissueinfo.vcMainUnderwriter,cMarketNo:cMarketNo,enCategoryMoney:stockissueinfo.enCategoryMoney,
			vcMortStockName:stockissueinfo.vcMortStockName,vcMortStockCode:stockissueinfo.vcMortStockCode,vcMortStockAmount:stockissueinfo.vcMortStockAmount,
			lIssueBeginDate:lIssueBeginDate1};
			 //序列化成JSON
			var json = mini.encode({applyInst:applyInst,applyInstReport:applyInstReport,bizprocess:bizprocess,stockIssueInfo:stockIssueInfoTemp}); 
			
			form.loading();//加载遮罩
			//提交
			nui.ajax({
			    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.saveFirstGradeDabt.biz.ext",
			    type: "post",
			    data: json,
			    dataType:"json",
			    success: function (text) {
			    	form.unmask();//取消遮罩
			    	if(text.out==1){
			    		if(text.ret==1){
			    				var workItem = text.workItem;
			    				nui.confirm("申购已录入，是否前往复核？","申购提示",function(act){
			    					if(act=="ok"){
			    						var actionUrl = "/com.cjhxfund.ats.fm.instr.FirstGradeBond.flow";
			    						wfOpenWin(actionUrl,workItem.processInstID,workItem.workItemID,bizId);
			    					}
			    					//关闭界面
			    					CloseWindow("cancel");
			    				});
		    			}else{
			    			nui.alert("提交成功！","申购提醒",function (a){
			    			
			    				//关闭界面
			    				CloseWindow("cancel");
			    			});
		    			}
			    		
			    		
			    	}else if(text.out==2){
			    		nui.alert("提交失败,该债券被修改或者不可用!");
			    	}else{
			    		nui.alert("提交失败!");
			    	}
			    	
			        //alert("提交成功，返回结果:" + text.out);    
			    }
			});
		    
		}
		var contextPath = "<%=request.getContextPath() %>";
		function wfOpenWin(url,processInstID,workItemID,bizId) {
			var winFrm=document.openForm;
			document.getElementById("processInstID").value=processInstID;
			document.getElementById("workItemID").value=workItemID;
			document.getElementById("bizId1").value=bizId;
			var actionURL=contextPath+"/"+url; //目标页面
			winFrm.action=actionURL;
					
			var newwin = window.open('about:blank', 'newWindow' + bizId, '');
			winFrm.target = 'newWindow' + bizId;//这一句是关键
			winFrm.submit();
		}
		//关闭窗口
		function CloseWindow(action) {
			if (action == "close" && form.isChanged()) {
				if(confirm("数据被修改了，是否先保存？")) {
					saveData();
				}
			}
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else window.close();
		}
		
		//风控试算
		function windControlTrial(){
			//获取表单提交数据
			var form = new mini.Form("#dataform1"); 
			
			//校验表单
			if(!form.validate()){
				nui.alert("有数据为空，请确认！");
				return;
			}
			
			//存储报量信息
			var applyInstReport=new Array();
			var reportData=getReportDatagrid(grid,form);
			
			if(reportData==false){
				//数据不通过校验
				return;
			}
			
			//赋值获取报量相关信息
			/*vcInvestCount=reportData.vcInvestCount;
			vcInterestRate=reportData.vcInterestRate;*/
			
			applyInstReport=reportData.applyInstReport;
			
			var data = form.getData(false,true);      //获取表单多个控件的数据
			var stockissueinfo,applyInst;
			stockissueinfo=data.stockissueinfo;
			applyInst=data.applyInst;
		  	//债券信息 赋值到指令/建议表
			applyInst.vcStockName=stockissueinfo.vcStockName;
			applyInst.vcStockCode=stockissueinfo.vcStockCode;
			
			applyInstReport=getReportBidInfo(reportData.applyInstReport,applyInst);

			//组装时间
			var sBidLimitTime=nui.get("dApplicationDate").text + " " + nui.get("dApplicationTimeHH").text+":"+nui.get("dApplicationTimeMM").text+":00";
			applyInst.dBidLimitTime=sBidLimitTime;//投标截止日
			applyInst.lBizId = bizId;  //业务主表
			applyInst.vcIssuePrice=stockissueinfo.vcIssuePrice;//发行价格
			applyInst.enInterestRate=stockissueinfo.enFaceRate;//投标利率--票面利率
			applyInst.enCouponRate=stockissueinfo.enFaceRate;//票面利率--票面利率
			applyInst.enPayInteval=stockissueinfo.vcFrequency;//付息频率
			
			applyInst.enInvestBalance=applyInstReport.enInvestBalance;//投标金额
			applyInst.enInterestRate=applyInstReport.enInterestRate;//投标利率
			
			applyInst.vcPaymentPlace=stockissueinfo.vcPaymentPlace;//登记机构
			applyInst.vcStockNameFull=stockissueinfo.vcStockNameFull;
			//获取附件数量
			var attachCount = getAttachCount(bizId);
			applyInst.lAttchCount=attachCount;//通过查询获取该zhi
			var PcMarketNo=applyInst.vcPaymentPlace;
	 		//债券表登记托管机构转换
	 		if(PcMarketNo==3){
		        PcMarketNo=1;
		    }else if(PcMarketNo==4){
		        PcMarketNo=2;
		     }else{
		        PcMarketNo=5;
		     }
	 		applyInst.cMarketNo=PcMarketNo;//交易市场

			 //序列化成JSON
			var json = mini.encode({applyInst:applyInst}); 
			
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
			    	if(returnJson.returnCode == 4){
		    			nui.alert(returnJson.rtnMsg,"系统提示");
		    			return;
		    		}
			    	if(returnJson.rtnCode == 1){
			    		if(returnJson.riskMsg != undefined && returnJson.riskMsg != null && returnJson.riskMsg != ""){
			    			nui.open({
			    	  			url: "<%=request.getContextPath() %>/fix/riskControlDetailList.jsp",
			                    title: "风控试算反馈消息展示", width: 800, height: 390,
			                    onload: function () {
			                        //弹出页面加载完成
				                    var iframe = this.getIFrameEl();
				                    iframe.contentWindow.SetData(returnJson.riskMsg,returnJson.rtnMsg);
			                    },
			                    ondestroy: function (action) {//弹出页面关闭前
				                 
			                	}
			    	  		});
			    		}else{
			    			nui.alert("风控试算成功,未触发风控。","系统提示");
			    			return;
			    		}
			    	}else if(returnJson.rtnCode == 0){
			    	 	nui.alert("风控试算失败!"+returnJson.rtnMsg,"系统提示");
			    	 	return;
			    	}else if(returnJson.rtnCode == 2){
			    		nui.alert("未拿到风控试算反馈消息!","系统提示");
			    		return;
			    	}else if(returnJson.rtnCode =="no"){
			    		nui.alert("风控试算失败,请联系管理员。");
			    		return;
			    	}
			    	
			        //alert("提交成功，返回结果:" + text.out);    
			    }
			});
			
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
					onSearchClick();
				}
			});
	  }
		//取消
		function onCancel() {
			CloseWindow("cancel");
		}
		//提供给附件上传调用
		function refreshFile(){}
		
		//查询附件个数
		function getAttachCount(bizid){
			var json = nui.encode({lbizid : bizid});
			var attachCount = null;
			$.ajax({
				url:"com.cjhxfund.ats.fm.baseinfo.attachInfoManager.queryAttachCount.biz.ext",
				type:'POST',
				data:json,
				cache:false,
				async: false,
				contentType:'text/json',
				success:function(data){
					attachCount = data.attachCount;
				}
			});
			return attachCount;
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
		function onAccountTypeChanged(e) {
	        if(e.value == 'Q' || e.value == 'O' ){
		       document.getElementById( "mortInfo").style.display= "";
		       document.getElementById( "mortAmount").style.display= "";     
		       
	        }else{
		       document.getElementById( "mortInfo").style.display= "none";
		       document.getElementById( "mortAmount").style.display= "none";   
		       
		       nui.get("vcMortStockName").setValue("");
		       nui.get("vcMortStockCode").setValue("");
		       nui.get("vcMortStockAmount").setValue("");
	        }
        }
        function onAccountTypeChanged1(eid) {
	        if(eid == 'Q' || eid == 'O' ){
		       document.getElementById( "mortInfo").style.display= "";
		       document.getElementById( "mortAmount").style.display= ""; 
		       
	        }else{
		       document.getElementById( "mortInfo").style.display= "none";
		       document.getElementById( "mortAmount").style.display= "none";  
		       
		       nui.get("vcMortStockName").setValue("");
		       nui.get("vcMortStockCode").setValue("");
		       nui.get("vcMortStockAmount").setValue("");
	        }
        }
        //校验输入是否为正整数
	     function checkInt(number){
	            //验证输入是否为正数
		     	var reg = /^([0-9]+)(\.\d{1,4})?$/;
				if (!reg.test(number.value))
				{
					nui.alert("输入不能包含负数、字母、特殊字符，请输入正数！","系统提示");
					return;
				}
	     }
    </script>
</body>
</html>