<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!-- 发行人 -->
<ul class="form_list_name">
	<li>
    	<span>发行人 :</span>
   		<input name="ipoInstructInfo.vcIssuerName" class="nui-textbox input_width" readonly="true"/>
	</li>
	<li>
    	<span>主承销商 :</span>
    	<input name="ipoInstructInfo.vcLeadUnderwriterName" class="nui-textbox input_width" readonly="true"/>
  	</li>
 </ul>
 <fieldset class="fieldset">
 <legend>&nbsp;&nbsp;基本信息 &nbsp;&nbsp;</legend>
 	<ul class="form_list">
    	<li>
        	<span class="info_name">公司名称 :</span>
   			<input name="ipoInstructInfo.vcCompanyName" class="nui-textbox" readonly="true"/>
        </li>
        <li>
            <span class="info_name">申购代码 :</span>
        	<input id="vcPurchaseCode" name="ipoInstructInfo.vcPurchaseCode" class="nui-textbox" readonly="true"/>
        </li>
        <li>
        	<span class="info_name">申购建议价格(元) :</span>
        	<input id="enSuggestPrice" name="ipoInstructInfo.enSuggestPrice" class="nui-textbox" readonly="true"/>
        </li>
        <li>
        	<span class="info_name">发行数量(万股) :</span>
        	<input name="ipoInstructInfo.enIssueNumber" class="nui-textbox" readonly="true"/>
        </li>
        <li>
        	<span class="info_name">发行后总股本(万股) :</span>
        	<input id="enTotalEquity" name="ipoInstructInfo.enTotalEquity" class="nui-textbox" readonly="true"/>
        </li>
        <li>
            <span class="info_name">网下发行上限(万股) :</span>
            <input name="ipoInstructInfo.enOfflineIssueUpperNumber" class="nui-textbox" readonly="true"/>
        </li>
        <li>   
            <span class="info_name">网下申购上限(万股) :</span>
            <input id="enOfflineUpperNumber" name="ipoInstructInfo.enOfflineUpperNumber" class="nui-textbox" readonly="true"/>
        </li>
        <li>
            <span class="info_name">网下申购下限(万股) :</span>
            <input id="enOfflineUnderNumber" name="ipoInstructInfo.enOfflineUnderNumber" class="nui-textbox" readonly="true"/>
        </li>
        <li>
        	<span class="info_name">网下申购规模(万元) :</span>
        	<input name="ipoInstructInfo.enPurchaseScale" class="nui-textbox prohibit_input" readonly="true"/>
        </li>
        <li>
            <span class="info_name">申购步长(万) :</span>
            <input id="enPurchaseSize" name="ipoInstructInfo.enPurchaseSize" class="nui-textbox" readonly="true"/>
        </li>
        <li>
            <span class="info_name">询价日 :</span>
            <input id="lInquiryDate" name="ipoInstructInfo.lInquiryDate" class="nui-textbox" readonly="true"/>
        </li>
        <li>
            <span class="info_name">网下申购日 :</span>
            <input id="lOfflinePurchaseDate" name="ipoInstructInfo.lOfflinePurchaseDate" class="nui-textbox" readonly="true"/>
        </li>
        <li>
            <span class="info_name">市值门槛(万元):</span>
            <input name="ipoInstructInfo.enMarketValueThreshold" class="nui-textbox" readonly="true"/>
        </li>
	</ul>
</fieldset>
<!--定价信息-->
<fieldset class="fieldset">
<legend>&nbsp;&nbsp;定价信息 &nbsp;&nbsp;</legend>
	<ul class="form_list">
		<li>
        	<span class="info_name">预计获配率 (%):</span>
   			<input id="enPredictDistributionRate" name="ipoInstructInfo.enPredictDistributionRate" class="nui-textbox" readonly="true"/>
		</li>
		<li>
		    <span class="info_name_type">行业类别 :</span>
		    <input name="ipoInstructInfo.vcWindIndustryType" class="nui-textbox input_width" readonly="true"/>
		</li>
	</ul>
</fieldset>
<script type="text/javascript">
	
</script>
