<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<title>合规风控信息</title>
<fieldset class="fieldset">
	<legend>&nbsp;&nbsp;合规风控 &nbsp;&nbsp;</legend>
	<ul class="form_list">
	    <li>
	        <span class="info_name">合计申购股数（万股）:</span>
	   		<input id="stocknumber" name="ipoInstructInfo.enTotalPurchaseSize" class="nui-textbox prohibit_input" readonly="true"/>
	     </li>
	     <li>
	         <span class="info_name">发行人总股本（万股）:</span>
	         <input id="stockAll" class="nui-textbox" readonly="true"/>
	     </li>
	     <li>
	         <span class="info_name">申购量占总股本比例(%) :</span>
	         <input id="stockratio" name="ipoInstructInfo.enTotalPurchaseRate" class="nui-textbox prohibit_input" readonly="true"/>
	     </li>
	     <li>
	        <span class="info_name" style="width:190px;">获配数量占发行人总股本比例(%) :</span>
	        <input id="quantitystockratio" name="ipoInstructInfo.enTotalIssuerRate" class="nui-textbox prohibit_input" readonly="true"/>
	    </li>
	</ul>
</fieldset>