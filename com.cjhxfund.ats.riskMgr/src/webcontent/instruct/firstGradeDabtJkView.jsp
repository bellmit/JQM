<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=request.getContextPath()%>/fm/instr/processUtil/instr.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/fm/instr/processUtil/process.js" type="text/javascript"></script>
<div style="padding-top: 5px;" id="firstDabtInfoForm" class="nui-form">
	<div id="panel" class="mini-panel" title="基础信息" iconCls="icon-edit" style="width: 100%;" showToolbar="true" showCollapseButton="true" showFooter="true" allowResize="true" collapseOnTitleClick="true">
	    <input class="nui-hidden" id="vcProductCode" name="firstGradeBond.vcProductCode"/>
		<table style="width: 100%; table-layout: fixed;"  class="nui-form-table">
			<tr>
				<td class="form_label" width="25%" align="right">业务日期:</td>
				<td colspan="1" width="25%"><input class="nui-datepicker"
					width="70%" id="firstGradeBond.dApplicationTime"
					name="firstGradeBond.dApplicationTime" format="yyyy-MM-dd HH:mm:ss"
					width="170" readonly="readonly" /></td>
				<td class="form_label" width="25%" align="right">投标截止日期:</td>
				<td colspan="1" width="270px">
					<!-- 日期和时间分开显示 --> <input style="width: 98px;"
					id="dApplicationDate" onvaluechanged="onTimeValueChanged"
					class="mini-datepicker" showTodayButton="true" format="yyyy-MM-dd"
					readonly="readonly" /> <input style="width: 40px;"
					url="<%=request.getContextPath()%>/fm/instr/processUtil/timeHH.txt"
					class="nui-dictcombobox" id="dApplicationTimeHH"
					readonly="readonly" /> 时 <input style="width: 40px;"
					url="<%=request.getContextPath()%>/fm/instr/processUtil/timeMM.txt"
					class="nui-dictcombobox" id="dApplicationTimeMM"
					readonly="readonly" /> 分 <!-- 提醒的时间 --> <input class="nui-hidden"
					type="hidden" id="bidRemind" />
				</td>
			</tr>
			<tr>
				<td class="form_label" align="right">产品名称:</td>
				<td colspan="1"><input class="nui-textbox" id="vcProductName"
					width="70%" name="firstGradeBond.vcProductName" readonly="readonly" /></td>
				<td class="form_label" align="right">组合名称:</td>
				<td colspan="1"><input class="nui-textbox" width="70%"
					id="vcCombiName" name="firstGradeBond.vcCombiName"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label" align="right">债券代码:</td>
				<td colspan="1">
					<%--<input class="nui-textbox" name="firstGradeBond.vcStockCode"/>--%>
					<input class="nui-hidden"   name="firstGradeBond.lStockIssueId"  id="lStockIssueId"/>
					<input id="vcStockCode" width="70%" class="nui-textbox"
					name="firstGradeBond.vcStockCode" readonly="readonly" />
				</td>
				<td class="form_label" align="right">债券简称:</td>
				<td colspan="1"><input class="nui-textbox" id="vcStockName"
					width="70%" name="firstGradeBond.vcStockName"
					readonly="readonly" /></td>

			</tr>
			<tr>
				<td class="form_label" align="right">登记托管机构:</td>
				<td colspan="1">
					<!-- 登记托管机构 --> <input width="70%" class="nui-dictcombobox"
					id="vcPaymentPlace" name="firstGradeBond.vcPaymentPlace"
					dictTypeId="CF_JY_DJTGCS" readonly="readonly" />
				</td>
				<td class="form_label" align="right">债券类别:</td>
				<td colspan="1"><input class="nui-textbox" width="70%"
					id="vcStocktypeName" name="firstGradeBond.vcStocktypeName"
					readonly="readonly" /> <input class="nui-hidden" id="vcStockType"
					name="firstGradeBond.vcStockType"/></td>
			</tr>
			<tr>
				<td class="form_label" align="right">发行主体:</td>
				<td colspan="1"><input class="nui-textbox" width="70%"
					name="firstGradeBond.vcIssuerNameFull"
					readonly="readonly" /></td>
				<td class="form_label" align="right">债券全称:</td>
				<td colspan="1"><input class="nui-textbox" id="vcStockNameFull"
					width="70%" name="firstGradeBond.vcStockNameFull"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label" align="right">发行日期:</td>
				<td colspan="1"><input width="70%" id="lIssueBeginDate"
					name="firstGradeBond.lIssueBeginDate" class="mini-datepicker"
					showTodayButton="true" readonly="readonly"/></td>
				<td class="form_label" align="right">发行规模(亿):</td>
				<td colspan="1"><input class="nui-textbox"
					name="firstGradeBond.enIssueBalance" id="enIssueBalance"
					width="70%"
					readonly="readonly" /></td>
			</tr>
			 <tr>
				<td class="form_label" align="right">债券详情:</td>
				<td colspan="1"><a class='nui-button' plain='false'
					onclick="queryStockDetail()"> 查看债券详情 </a></td>
				<td class="form_label" align="right"></td>
				<td colspan="1"></td>
			</tr> 
		</table>

	</div>

	<div title="缴款信息" id="payPanel" class="mini-panel" iconCls="icon-edit"
		style="width: 100%;" showToolbar="true" showCollapseButton="true"
		showFooter="true" allowResize="false" collapseOnTitleClick="true">
		<table style="width: 100%; table-layout: fixed;" border="0"
			class="nui-form-table">
			<tr>
				<td class="form_label td1" align="right" width="20%">缴款面值(万元):
				</td>
				<td colspan="1">
				<input class="nui-textbox" id="payFaceValue"  name="firstGradeBond.enPayFaceValue"
					value="<b:write property="firstGradeBond/enPayFaceValue" />"
					onvaluechanged="payVcBallotNumber()" style="width: 220px;"
					readonly="readonly" />
			<%-- 	<input class="nui-hidden"  id="enPayFaceValue" name="firstGradeBond.enPayFaceValue" value="<b:write property="firstGradeBond/enPayFaceValue" />" /> --%>
				</td>
					
					
				<td class="form_label td1" align="right" width="20%">发行价格(元):</td>
				<td colspan="1"><input class="nui-textbox"
					name="firstGradeBond.enBallotPrice" id="enBallotPrice"
					value="<b:write property="firstGradeBond/enBallotPrice" />"
					vtype="maxLength:100;float" style="width: 220px;"
					onvaluechanged="payVcBallotPrice()" readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label td1" align="right" width="20%">缴款金额(万元):
				</td>
				<td colspan="1"><input class="nui-textbox" id="paymentMoney"   name="firstGradeBond.enPaymentMoney"
					value="<b:write property="firstGradeBond/enPaymentMoney" />"
					style="width: 220px;" readonly="readonly" /> 
					
				<%-- 	<input  class="nui-hidden" name="firstGradeBond.enPaymentMoney" id="enPaymentMoney"   value="<b:write property="firstGradeBond/enPaymentMoney" />" /></td> --%>
					
					
				<td class="form_label td1" align="right">票面利率(%):</td>
				<td colspan="1" class="td2"><input class="nui-textbox"
					name="firstGradeBond.enCouponRate" id="enCouponRate"
					value="<b:write property="firstGradeBond/enCouponRate" />"
					style="width: 220px;" readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label td1" align="right">付息频率(次/年):</td>
				<td colspan="1" class="td2"><input class="nui-dictcombobox"
					valueFromSelect="false" dictTypeId="ATS_CF_JY_FREQUENCY"
					allowInput="true" name="firstGradeBond.vcFrequency"
					id="vcFrequency"
					value="<b:write property="firstGradeBond/vcFrequency" />"
					emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"
					style="width: 220px;" readonly="readonly" /></td>
				<td class="form_label td1" align="right">计息起始日期:</td>
				<td colspan="1" style="border-bottom: 1px solid #D3D3D3;"
					class="td1"><input class="nui-datepicker" id="lBegincalDate"
					name="stockissueinfo.lBegincalDate"
					value="<b:write property="firstGradeBond/lBegincalDate" />"
					format="yyyy-MM-dd" style="width: 220px;" readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label td1" align="right">还本方式:</td>
				<td colspan="1" class="td2"><input class="nui-dictcombobox"
					dictTypeId="CF_JY_MODE_REPAYMENT"
					name="firstGradeBond.vcModeRepayment" id="vcModeRepayment"
					value="<b:write property="firstGradeBond/vcModeRepayment" />"
					emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"
					style="width: 220px;" readonly="readonly" /></td>
				<td class="form_label td1" align="right"
					style="border-bottom: 1px solid #D3D3D3;">到期日:</td>
				<td colspan="1" style="border-bottom: 1px solid #D3D3D3;"
					class="td1"><input class="nui-datepicker"
					name="firstGradeBond.lEndincalDate" id="lEndincalDate"
					value="<b:write property="firstGradeBond/lEndincalDate" />"
					style="width: 220px;" readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label td1" width="20%" align="right">缴款方式:</td>
				<td colspan="1"><input class="nui-dictcombobox"
					dictTypeId="ATS_FM_PAYMENT" name="firstGradeBond.cPayType"
					width="220px"
					value="<b:write property="firstGradeBond/cPayType" />"
					readonly="readonly" /></td>
				<td class="form_label td1" width="20%" align="right">收款人户名:</td>
				<td colspan="1" class="td1"><input class="nui-textbox"
					id="combProductName" width="220px"
					name="firstGradeBond.vcBeneficiary"
					value="<b:write property="firstGradeBond/vcBeneficiary" />"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label td1" width="20%" align="right">收款账号:</td>
				<td colspan="1"><input class="nui-textbox"
					name="firstGradeBond.vcCollectionAccount"
					value="<b:write property="firstGradeBond/vcCollectionAccount" />"
					width="220px" readonly="readonly" /></td>
				<td class="form_label td1" width="20%" align="right">大额支付行号:</td>
				<td class="td1"><input class="nui-textbox"
					name="firstGradeBond.vcPayLine"
					value="<b:write property="firstGradeBond/vcPayLine" />"
					width="220px" readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label td1" width="20%" align="right"
					style="border-bottom: 1px solid #D3D3D3;">收款备注:</td>
				<td colspan="3" class="td1"
					style="border-bottom: 1px solid #D3D3D3;"><input
					class="nui-textarea" id="vcReceivableRemark" width="515"
					height="40" name="firstGradeBond.vcReceivableRemark"
					value="<b:write property="firstGradeBond/vcReceivableRemark" />"
					readonly="readonly" /></td>
			</tr>
			
			<!--  <tr>
				<td class="form_label td1" width="20%" align="right">债券详情:</td>
				<td class="td1"><a class='nui-button' plain='false'
					onclick="queryStockDetail()"> 查看债券详情 </a></td>
				<td class="form_label td1" width="20%" align="right"></td>
				<td class="td1"></td>
			</tr>  -->
			
			
		</table>
	</div>
	
	
	<!-- <div style="height: 5px"></div>
	<div title="债券详情" id="payPanel" class="mini-panel" iconCls="icon-edit"
		style="width: 100%;" showToolbar="true" showCollapseButton="true"
		showFooter="true" allowResize="false" collapseOnTitleClick="true">
		<table style="width: 100%; table-layout: fixed;" border="0"
			class="nui-form-table">
			
		
			<tr>
							<td style="width:80px" align="right">
						债券简称:    
							</td>
							<td style="width:15%" align="left">
								<input class="nui-textbox" name="firstGradeBond.vcStockName1" id="vcStockName1"    readonly="readonly" width="80%"/>
							</td>
							<td style="width:80px" align="right">
						证券类别:
							</td>
							<td style="width:15%" align="left">
								<input class="nui-textbox" name="firstGradeBond.vcStocktypeName1"     id="vcStocktypeName1"   readonly="readonly" width="80%"/>
							</td>
							<td style="width:80px" align="right">
				                        起息日:
							</td>
							<td style="width:15%" align="left">
								<input class="nui-datepicker" id="lBegincalDate"  name="firstGradeBond.lBegincalDate" format="yyyy-MM-dd" readonly="readonly" width="80%"/>
							</td>
							<td style="width:80px" align="right">
					                        到期日:
							</td>
							<td style="width:15%" align="left">
								<input class="nui-datepicker" id="lEndincalDate1"  name="firstGradeBond.lEndincalDate1" readonly="readonly" width="80%"/>
							</td>
						</tr>
						<tr>
							<td align="right">
				                        发行期限(年):
							</td>
							<td  align="left"> 
								<input  id="investProductCode" class="nui-textbox"  name="firstGradeBond.enExistLimite" readonly="readonly" width="80%"/>
							</td>
							<td align="right">
				                        付息频率:
							</td>
							<td  align="left">
								<input class="nui-dictcombobox" id="vcFrequency"   dictTypeId="ATS_CF_JY_FREQUENCY" name="firstGradeBond.vcFrequency" readonly="readonly" width="80%"/>
							</td>
							<td align="right">
				                        票面利率(%):
							</td>
							<td align="left">
								<input class="nui-textbox"  name="firstGradeBond.enCouponRate1"  id="enCouponRate1" readonly="readonly" width="80%"/>
							</td>
							<td align="right">
				                        利率类型:
							</td>
							<td align="left">
								<input class="nui-dictcombobox" dictTypeId="rateType"  name="firstGradeBond.cInterestType" readonly="readonly" width="80%"/>
							</td>
						</tr>
						<tr>
							<td align="right">
				                        是否具有回售权:
							</td>
							<td align="left">
								<input class="nui-dictcombobox"  dictTypeId="COF_YESORNO" id="cIsHaveSaleback" 
									name="firstGradeBond.cIsHaveSaleback" readonly="readonly" width="80%"/>
							</td>
							<td align="right">
				                        债券评级:
							</td>
							<td align="left">
								<input class="nui-dictcombobox"  dictTypeId="creditRating" name="firstGradeBond.cBondAppraise" id="cBondAppraise" readonly="readonly" width="80%"/>
							</td>
							<td align="right">
				                        主体评级:
							</td>
							<td align="left">
								<input class="nui-dictcombobox"  dictTypeId="issuerRating" name="firstGradeBond.cIssueAppraise" readonly="readonly" width="80%"/>
							</td>
							<td align="right">
				                        发行公告日:
							</td>
							<td align="left">
								<input class="nui-datepicker" id="lIssuePostDate"  name="firstGradeBond.lIssuePostDate"        format="yyyy-MM-dd" readonly="readonly" width="80%"/>
							</td>
						</tr>
						<tr>
							<td align="right">
				                        发行主体:
							</td>
							<td align="left" colspan="7"> 
								<input class="nui-textbox"  id="vcIssuerName"  name="firstGradeBond.vcIssuerName"  readonly="readonly" width="13.3%"/>
							</td>
						</tr>
		
		</table>
	</div>	
			 -->
			

	<!-- <div style="height: 5px"></div>
	<div id="panel1" class="mini-panel" title="其他信息" iconCls="icon-edit"
		style="width: 100%; padding: 0px;" showToolbar="true"
		showCollapseButton="true" showFooter="true" allowResize="false"
		collapseOnTitleClick="true">

		<table style="width: 100%; table-layout: fixed;" border="0"
			class="nui-form-table">
			<tr>
				<td class="form_label" align="right">主承销商:</td>
				<td colspan="3"><input width="90%" class="nui-textbox"
					name="firstGradeBond.vcMainUnderwriter"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label" align="right" width="25%">副主承销商:</td>
				<td colspan="3"><input width="90%" class="nui-textbox"
					name="firstGradeBond.vcDeputyUnderwriter"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label" align="right" width="25%">承销团:</td>
				<td colspan="3"><input width="90%" class="nui-textbox"
					name="firstGradeBond.vcGroupUnderwriter"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label" align="right" width="25%">交易对手:</td>
				<td colspan="1" width="25%"><input class="nui-hidden"
					type="hidden" id="hlRivalId" name="firstGradeBond.lRivalId"/> 
					<input width="68%" class="nui-textbox"
					name="firstGradeBond.vcBusinessObject"
					readonly="readonly" /></td>
				<td class="form_label" align="right" width="25%">主体类型:</td>
				<td colspan="1" width="25%"><input class="nui-dictcombobox"
					dictTypeId="ATS_FM_ISSUE_PROPERTY" width="68%"
					name="firstGradeBond.vcIssueProperty"
					readonly="readonly" /></td>
			</tr>
			<tr>
			<tr>
				<td class="form_label" align="right">主体评级:</td>
				<td colspan="1"><input class="nui-dictcombobox"
					dictTypeId="issuerRating" width="68%" id="cIssueAppraise"
					name="firstGradeBond.cIssueAppraise"
					readonly="readonly" /></td>
				<td class="form_label" align="right">债券评级:</td>
				<td colspan="1"><input class="nui-dictcombobox"
					dictTypeId="creditRating" id="cBondAppraise" width="68%"
					name="firstGradeBond.cBondAppraise"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label" align="right">主体评级机构:</td>
				<td colspan="1"><input class="nui-dictcombobox"
					dictTypeId="outRatingOrgan" width="68%" id="vcIssueAppraiseOrgan"
					name="firstGradeBond.vcIssueAppraiseOrgan"
					readonly="readonly" /></td>
				<td class="form_label" align="right">债券评级机构:</td>
				<td colspan="1"><input class="nui-dictcombobox"
					dictTypeId="outRatingOrgan" width="68%" id="vcBondAppraiseOrgan"
					name="firstGradeBond.vcBondAppraiseOrgan"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td colspan="1" class="form_label" align="right">特殊条款:</td>
				<td colspan="1"><input width="68%"
					id="stockissueinfo.vcSpecialText" class="nui-dictcombobox"
					name="firstGradeBond.vcSpecialText" valueField="dictID"
					textField="dictName" dictTypeId="specialText" emptyText="请选择"
					nullItemText="请选择" multiSelect="true" showClose="true"
					valueFromSelect="true" oncloseclick="onCloseClickValueEmpty"
					readonly /></td>
				<td class="form_label" align="right">发行期限(年):</td>
				<td colspan="1"><input class="nui-textbox"
					name="firstGradeBond.enExistLimite" width="68%"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label" align="right">特殊期限:</td>
				<td colspan="1"><input class="nui-textbox"
					name="firstGradeBond.vcSpecialLimite" width="170"
					readonly="readonly" /></td>
				<td class="form_label" align="right">下一行权日:</td>
				<td colspan="1"><input width="68%" class="nui-datepicker"
					id="lNextExerciseDate" name="firstGradeBond.lNextExerciseDate"
					readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<td class="form_label" align="right">下一利率跳升点数:</td>
				<td colspan="1"><input class="nui-textbox"
					name="firstGradeBond.lNInterestRateJumpPoints"
					id="lNInterestRateJumpPoints" width="68%"
					readonly="readonly" /></td>
				<td class="form_label" align="right">首次付息日:</td>
				<td colspan="1"><input class="nui-datepicker"
					name="firstGradeBond.dInitInterestPaymentDate"
					id="dInitInterestPaymentDate"
					width="68%" readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label" align="right">公司净资产（元）:</td>
				<td colspan="1"><input class="nui-textbox"
					name="firstGradeBond.enIssuerNetValue" id="enIssuerNetValue"
					width="68%"
					readonly="readonly" /></td>
				<td class="form_label" align="right">城投行政级别:</td>
				<td colspan="1"><input width="68%" id="vcCityLevel"
					class="nui-dictcombobox" name="sfirstGradeBond.vcCityLevel"
					readonly="readonly" showNullItem="true" emptyText="---请选择---"
					nullItemText="---请选择---" dictTypeId="cityLevel"/></td>
			</tr>
			<tr id="morStockNameAndCode">
				<td class="form_label" align="right">股票名称:</td>
				<td colspan="1"><input class="nui-textbox"
					name="firstGradeBond.vcMortStockName" id="vcMortStockName"
					width="68%"
					readonly="readonly" /></td>
				<td class="form_label" align="right">股票代码:</td>
				<td colspan="1"><input class="nui-textbox"
					name="firstGradeBond.vcMortStockCode" id="vcMortStockCode"
					width="68%" readonly="readonly"/></td>
			</tr>

			<tr id="morStockAmount">
				<td class="form_label" align="right">股票抵押数量(万股):</td>
				<td colspan="1"><input class="nui-textbox"
					name="firstGradeBond.vcMortStockAmount" id="vcMortStockAmount"
					width="68%"
					readonly="readonly" /></td>
				<td class="form_label" align="right"></td>
				<td colspan="1"></td>
			</tr>
			<tr>
				<td class="form_label" align="right">所属行业(证监会二级):</td>
				<td colspan="1"><input class="nui-hidden"
					name="firstGradeBond.vcIssueAppraiseCsrc" id="vcIssueAppraiseCsrc"
					style="width: 170px;"
					readonly="readonly" /> <input class="nui-textbox"
					name="firstGradeBond.vcIssueAppraiseCsrcName"
					id="vcIssueAppraiseCsrcName" width="68%"
					readonly="readonly" /></td>
				<td class="form_label" align="right">投标区间:</td>
				<td colspan="1"><input class="nui-textbox"
					name="firstGradeBond.vcTenderInterval" width="68%"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="form_label" align="right">是否具有回售权:</td>
				<td colspan="1" class="radio-border-top-none"><input
					id="resaleRight" class="nui-dictradiogroup"
					name="firstGradeBond.cIsHaveSaleback" dictTypeId="COF_YESORNO"
					style="float: left;"
					readonly /></td>
				<td class="form_label" align="right">是否具有赎回权:</td>
				<td colspan="1" class="radio-border-top-none"><input
					id="redemptionRight" class="nui-dictradiogroup"
					name="firstGradeBond.cIsHaveBuyback" dictTypeId="COF_YESORNO"
					style="float: left;"
					readonly /></td>
			</tr>
			<tr>
				<td class="form_label" align="right"
					style="border-bottom: 1px solid #D3D3D3;">备注:</td>
				<td colspan="3" style="border-bottom: 1px solid #D3D3D3;"><input
					class="nui-textarea" width="515" height="40"
					name="firstGradeBond.vcRemarks"
					readonly="readonly" /></td>
			</tr>
		</table>
		<table style="width: 100%; table-layout: fixed;" border="0"
			class="nui-form-table">
			<tr>
				<td class="form_label" align="right" style="padding: 5px 5px;">
					已投资该发行主体债券存量(万元):</td>
				<td colspan="1" style="padding: 5px 5px;"><input
					class="nui-textbox" id="fsumamount" readonly="readonly"
					name='firstGradeBond.enCategoryMoney'
					style="width: 150px; float: left; margin-right: 10px;"
					onvaluechanged="BondAccountedCalculation" /></td>
				<td class="form_label" align="right" style="padding: 5px 5px;">
					产品净值规模(万元):</td>
				<td colspan="1"><input class="nui-textbox" id="enNetScale"
					width="68%" readonly="readonly"
					onvaluechanged="BondAccountedCalculation" /></td>
			</tr>
			<tr>
				<td class="form_label" align="right" style="padding: 5px 5px;">
					该笔债券投资占发行规模比例(%):</td>
				<td colspan="1" style="padding: 5px 5px;"><input
					class="nui-textbox asLabel" id="enInvestScaleRatio" width="150px"
					readonly="readonly"
					name="firstGradeBond.enInvestScaleRatio"
					onvaluechanged="BondAccountedCalculation" /></td>
				<td class="form_label" align="right" style="padding: 5px 5px;">
					同一发行主体占产品净值规模比例(%):</td>
				<td colspan="1" style="padding: 5px 5px;"><input
					class="nui-textbox asLabel" id="enIssuerNetRatio" width="65%"
					readonly="readonly"
					name="firstGradeBond.enIssuerNetRatio"
					onvaluechanged="BondAccountedCalculation" /></td>
			</tr>
			<tr>
				<td class="form_label" align="right" style="padding: 5px 5px;">
					该笔债券投资占产品净值规模比例(%):</td>
				<td colspan="1" style="padding: 5px 5px;"><input
					class="nui-textbox asLabel" id="enInvestNetRatio" width="150px"
					readonly="readonly"
					name="firstGradeBond.enInvestNetRatio"
					onvaluechanged="BondAccountedCalculation" /></td>
				<td class="form_label" align="right" style="padding: 5px 5px;">
					弱流动性资产规模占产品净值规模比例(%):</td>
				<td colspan="1" style="padding: 5px 5px;"><input
					class="nui-textbox asLabel" id="enWeakNetRatio" width="65%"
					readonly="readonly"
					name="firstGradeBond.enWeakNetRatio"
					onvaluechanged="BondAccountedCalculation" /></td>
			<tr>
		</table>
	</div> -->
	<div title="报量录入">
		<div class="nui-toolbar"
			style="border-bottom: 0; padding: 0px; margin-top: 2px; height: 27px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;">&nbsp;&nbsp;报量信息</td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</div>
		
		
		<div style="font-size: 10px; color: red;">
			<div style="width: 50%; float: left; padding-left: 10px;">
				<b>说明：</b>①报量为100万整数倍；②特殊说明请在报量说明中填写；③报价待定时为空即可
			</div>
			<div
				style="width: 30%; float: right; padding-right: 10px; text-align: right; line-height: 27px;">
				报量方式：<input style="width: 130px;"
					url="<%=request.getContextPath()%>/fm/instr/processUtil/reportData.txt"
					class="nui-dictcombobox"
					name="firstGradeBond.cReportType"
					readonly="readonly" />
			</div>
		</div>
		 <div class="nui-datagrid" id="instReport" height="100px"
			showPager="false" allowSortColumn="false" allowCellSelect="true"
			allowCellEdit="true"
			url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadReport.biz.ext?"
			multiSelect="true" allowCellValid="true">
			<div property="columns">
				<div field="enReport" headerAlign="center" allowSort="true">报量(万元)</div>
				<div field="enOffer" headerAlign="center" allowSort="true">报价(%)</div>
				<div field="vcReportRemark" headerAlign="center" allowSort="true">报量说明</div>
			</div>
		</div> 
	</div>

</div>

<script type="text/javascript">
	

	function setInstructInfo(lApplyInstId) {
	
		//var lBizId = '26109';
		var data = {
			//lBizId : lBizId,
			//lProcessInstId:lProcessInstId,
			lApplyInstId:lApplyInstId,
		};
		
		
		var json = nui.encode(data);
		nui.ajax({
			url : "com.cjhxfund.ats.riskMgr.firstGrade.queryFirstGradeInfo.biz.ext",
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				var returnJson = nui.decode(text);
				console.log(text);
				var form = new nui.Form("#firstDabtInfoForm");//将普通form转为nui的form
				
				
				form.setData(returnJson);
			
				
				//nui.get("vcStockName1").setValue(returnJson.firstGradeBond.vcStockName);
				
				//nui.get("vcStocktypeName1").setValue(returnJson.firstGradeBond.vcStocktypeName);
				
				nui.get("dApplicationDate").setValue(dApplicationTime);//设置默认投标截止日期
				
				
				///nui.get("enCouponRate1").setValue(returnJson.firstGradeBond.enCouponRate);
				//nui.get("lEndincalDate1").setValue(returnJson.firstGradeBond.lEndincalDate);
				
				
				
				
				
				
				//获取投标截止时间
				var dApplicationTime=returnJson.firstGradeBond.dBidLimitTime;
				if(dApplicationTime!="" && dApplicationTime!=null){
					nui.get("dApplicationDate").setValue(dApplicationTime);
					//设置时间
					nui.get("dApplicationTimeHH").setValue(dApplicationTime.getHours());
					nui.get("dApplicationTimeMM").setValue(dApplicationTime.getMinutes());
				}
				//债券类别为可转债时，显示股票名称，股票代码，抵押股票数量
				onAccountTypeChanged();
				
				var grid = nui.get("instReport");
				grid.load({bizId:returnJson.firstGradeBond.lBizId});
			}
		});
	}
	
	//股票信息显隐
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
		
	//日期转换
	function GetDateStr(AddDayCount) { 
		var dd = new Date(); 
		dd.setDate(dd.getDate()+AddDayCount);//获取AddDayCount天后的日期 
		var y = dd.getFullYear(); 
		var m = dd.getMonth()+1;//获取当前月份的日期 
		var d = dd.getDate(); 
		return y+"-"+m+"-"+d; 
	}
	
	//时间转换
	function dateTemp(oldData) {
		oldData = oldData + "";
		if (oldData == 0 || oldData == "" || oldData == "null") {
			return "";
		}

		var datas = oldData.indexOf("-");
		if (datas >= 0) {
			return oldData;
		}
		var yy = oldData.substr(0, 4);//0开始，截取后面4位
		var mm = oldData.substr(4, 2);//4开始，截取后面2位
		var dd = oldData.substr(6, 2);

		return yy + "-" + mm + "-" + dd;
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
	  
</script>