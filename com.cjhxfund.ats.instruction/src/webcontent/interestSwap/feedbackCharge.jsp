<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/CFJYProductProcessForm_common.jsp" %>
<!-- 
  - Author(s): jiangkanqian
  - Date: 2018-06-01 17:07:23
  - Description:
-->
<head>
<title>冲销反馈</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
    <script type="text/javascript" src="<%= request.getContextPath() %>/JQMHistory/common/common.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/instruction/instructionUtil/instruction.js"></script>
</head>
<body>
<div id="newChargeForm" style="padding-top:5px;width: 100%;">
	<input class="nui-hidden" name="newCharge.lChargeId" id="lChargeId"/>
	<input class="nui-hidden" name="newCharge.lInstructId" id="lInstructId"/>
	<input class="nui-hidden" name="newCharge.lInstructNo" id="lInstructNo"/>
	<input class="nui-hidden" name="newCharge.operatorType" id="operatorType" value="0"/>
	<input class="nui-hidden" name="newCharge.lAttachId" id="lAttachId"/>
	<table class="instructTable" border="0" style="width: 100%;">
		<tr>
			<td align="right" width="80px">
				产品名称:
			</td>
			<td colspan="1" width="100px">
				<input id="vcProductName" class="nui-textbox" name="newCharge.vcProductName" 
				style="width: 80%;" readonly="readonly" enabled="false"/>
			</td>
			<td align="right" class="form_label" width="80px">
				组合名称:
			</td>
			<td colspan="1" width="100px">
				<input id="vcCombiName" class="nui-textbox" name="newCharge.vcCombiName" 
				style="width: 80%;" readonly="readonly" enabled="false"/>
			</td>
		</tr>
		<tr></tr><tr></tr><tr>
		<tr>
			<td align="right" class="form_label" width="80px">
				业务名称:
			</td>
			<td colspan="1" width="100px">
				<input id="vcBusinName" class="nui-dictcombobox" name="newCharge.vcBusinName"
				valueField="dictID" textField="dictName" dictTypeId="interestSwapBusinName"
				style="width: 80%;" readonly="readonly" enabled="false"/>
			</td>
			<td align="right" class="form_label" width="80px">
				业务类型:
			</td>
			<td colspan="1" width="100px">
				<input id="vcBusinType" class="nui-dictcombobox" name="newCharge.vcBusinType"
				valueField="dictID" textField="dictName" dictTypeId="interestSwapBusinType" 
				style="width: 80%;" readonly="readonly" enabled="false"/>
			</td>
		</tr>
		<tr></tr><tr></tr><tr>
		<tr>
			<td align="right" class="form_label" width="80px">
				名义本金(万元):
			</td>
			<td colspan="1" width="100px">
				<input id="lNominalCapital" class="nui-textbox" name="newCharge.lNominalCapital" 
				style="width: 80%;" readonly="readonly" enabled="false"/>
			</td>
			<td align="right" class="form_label" width="80px"><span style="color:red">*</span>
				交易日期:
			</td>
			<td colspan="1" width="100px">
				<input id="lTradeDate"  class="nui-datepicker" style="width: 80%;"
                        name="newCharge.lTradeDate" required="true" 
 						 format="yyyyMMdd" readonly="readonly" enabled="false"/>
			</td>
		</tr>
		<tr></tr><tr></tr><tr>
		<tr>		
			<td align="right" class="form_label" width="80px"><span style="color:red">*</span>
				冲销金额(万元):
			</td>
			<td colspan="1" width="100px">
				<input id="lChargeCapital" class="nui-textbox" name="newCharge.lChargeCapital" 
				required="true" style="width: 80%;" readonly="readonly" enabled="false"/>
			</td>
			<td align="right" class="form_label" width="80px"><span style="color:red">*</span>
				冲销类型:
			</td>
			<td colspan="1" width="100px">
				<input id="vcChargeType"  class="nui-combobox" 
                        data = "[{id: 0, text: '双边冲销'}, {id: 1, text: '多边冲销'}]"
                        name="newCharge.vcChargeType" required="true" style="width: 80%;"
                        readonly="readonly" enabled="false"/>
			</td>
		</tr>
		<tr></tr><tr></tr><tr>
		<tr>
			<td align="right" class="form_label" width="80px"><span style="color:red">*</span>
				开仓指令/建议序号:
			</td>
			<td colspan="1" width="100px">
				<input id="openInstructNo" class="nui-textbox" name="newCharge.openInstructNo" 
				required="true" style="width: 80%;" readonly="readonly" enabled="false"/>
			</td>
			<td align="right" class="form_label" width="80px"><span style="color:red">*</span>
				已冲销金额(万元):
			</td>
			<td colspan="1" width="100px">
				<input id="lSpendCapital" class="nui-textbox" name="newCharge.lSpendCapital" 
				required="true" style="width: 80%;"/>
			</td>
		</tr>
	</table>
	
	<div class="nui-toolbar" align="left" borderStyle="border:0;"><strong>附件:</strong></div>
	<div colspan="3" class="td">
		<iframe id="prodIfm" name="prodIfm" width="98%"  height="120px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"></iframe>
	</div>
	
	<div class="nui-toolbar" align="left" borderStyle="border:0;"><strong>备注:</strong></div>
	<div colspan="5">
        <input class="nui-textarea"  name="newCharge.vcRemark" id="vcRemark" width="100%" height="90px"/>
    </div>
	
	<div class="nui-toolbar" borderStyle="border:0;">
		<div align="center" class="submitDiv">
			<!-- <a class="nui-button"  iconCls="icon-tip" plain="true"  id="exactrisk" enabled="false">风控试算</a> --> 
			<a class="nui-button"  iconCls="icon-ok" plain="true"  id="exactCommit" onclick="commit()">提交</a>  
			<a class="nui-button"  iconCls="icon-cancel" plain="true"  onclick="onCancel()">取消</a>
		</div>
	</div>
</div>	



	<script type="text/javascript">
    	nui.parse();
    	
    	function showFile(){
           		var uuid = nui.get("lAttachId").getValue();
           		$("#prodIfm").attr("src", nui.context + "/fm/baseinfo/fileuploadComm/any_upload.jsp?attachType=77&attachBusType=1&bizId="+uuid);
        }                    
      	
      	function initWin(data){
    		var data = nui.clone(data);  
	        if(data!=null){
	        	nui.get("lChargeId").setValue(data.lChargeId);
	        	nui.get("lInstructId").setValue(data.lInstructId);
	        	nui.get("vcProductName").setValue(data.openProductName);
	        	nui.get("vcCombiName").setValue(data.openCombiName);
	        	nui.get("vcBusinName").setValue(data.openBusinName);
	        	nui.get("vcBusinType").setValue(data.openBusinType);
	        	nui.get("lNominalCapital").setValue(data.openNominalCapital);
	        	nui.get("lTradeDate").setValue(data.lTradeDate.toString());
	        	nui.get("lChargeCapital").setValue(data.lChargeCapital);
	        	nui.get("vcChargeType").setValue(data.vcChargeType);
	        	nui.get("openInstructNo").setValue(data.openInstructNo);
	        	nui.get("lAttachId").setValue(data.lAttachId);
	        	showFile();
	        }
    	}
      	
      	// 确认按钮分发
		function commit(){
    		var lChargeId = nui.get("lChargeId").getValue();
    		var lInstructId = nui.get("lInstructId").getValue();
    		var vcChargeType = nui.get("vcChargeType").getValue();
    		var lSpendCapital = nui.get("lSpendCapital").getValue();
    		var vcRemark = nui.get("vcRemark").getValue();
			var chargeInstruct = {lChargeId: lChargeId, lInstructId: lInstructId, vcChargeType: vcChargeType,
			lSpendCapital: lSpendCapital, vcRemark:vcRemark};
    		var a = nui.loading("正在处理中,请稍等...","提示");
    		nui.ajax({
					    	url: "com.cjhxfund.ats.instruction.InterestSwap.InterestSwapInstruction.updateCharge.biz.ext",
					      	type: 'POST',
					      	data: {chargeInstruct:chargeInstruct},		
					      	contentType: 'text/json',
					      	success: function(text){
					      		nui.hideMessageBox(a);
					      		var returnJson = nui.decode(text);
					      		if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
					      			nui.alert("提交成功","提示",function(){
		            					window.CloseOwnerWindow();                  	
	                            	});				      			
					      		}
					      		if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
					      			var rtnMsg = returnJson.rtnMsg;
					      			nui.alert(rtnMsg,"提示",function(){
		            					window.CloseOwnerWindow();                  	
	                            	});						      			
					      		}
					      	}
				 		});
			
		}
      	 
    </script>
</body>
</html>