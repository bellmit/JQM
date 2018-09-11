<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): jiangkanqian
  - Date: 2018-06-15 10:14:26
  - Description:
-->
<head>
<title>出入金基本信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<div title="基本信息" id="instructInfoPanel" class="nui-panel" iconCls="icon-edit" style="width:100%;" showCollapseButton="true" collapseOnTitleClick="true">
		 <div style="padding-top:5px;" id="goldBasicForm" class="nui-form">
		 <table class="goldTable" border="0" style="width: 100%;">
		<tr>
			<td align="right" width="60px">
				产品名称:
			</td>
			<td colspan="1" width="100px">
				<input id="vcProductName" class="nui-textbox" name="newGold.vcProductName"
				readonly="readonly"   />
			</td>
			<td align="right" class="form_label" width="60px">
				组合名称:
			</td>
			<td colspan="1" width="100px">				
				<input id="vcCombiName" class="nui-textbox" name="newGold.vcCombiName" 
				readonly="readonly"  />
			</td>
		</tr>
		<tr></tr><tr></tr><tr>
		<tr>
			<td align="right" class="form_label" width="60px">
				委托方向:
			</td>
			<td colspan="1" width="100px">
				<input id="vcEntrustDirection" class="nui-radiobuttonlist" name="newGold.vcEntrustDirection" 
				readonly="readonly"  
				data="[{id: '0', text: '出金'}, {id: '1', text: '入金'}]"/>
			</td>
			<td align="right" class="form_label" width="60px">
				金额（万元）:
			</td>
			<td colspan="1" width="100px">
				<input id="lGoldCapital" class="nui-textbox" name="newGold.lGoldCapital" 
				readonly="readonly"  />
			</td>
		</tr>
		<tr></tr><tr></tr><tr>
		<tr>
			<td align="right" class="form_label" width="60px">
				代理行:
			</td>
			<td colspan="1" width="100px">
				<input id="vcAgentBank" class="nui-textbox" name="newGold.vcAgentBank" 
				readonly="readonly"  />
			</td>
			<td align="right" class="form_label" width="60px">
				交易日期:
			</td>
			<td colspan="1" width="100px">
				<input id="lTradeDate" class="nui-datepicker" name="newGold.lTradeDate" 
				readonly="readonly"   format="yyyyMMdd"/>
			</td>		
		</tr>
		<tr></tr><tr></tr><tr>
		<tr>
			<td align="right" class="form_label" width="60px">
				代理行账号:
			</td>
			<td colspan="1" width="100px">
				<input id="lAgentNo" class="nui-textbox" name="newGold.lAgentNo" 
				readonly="readonly"  />
			</td>
			<td align="right" class="form_label" width="60px">
				代理行账户名称:
			</td>
			<td colspan="1" width="100px">
				<input id="vcAgentName" class="nui-textbox" name="newGold.vcAgentName" 
				readonly="readonly"  />
			</td>
		</tr>
	</table>	
	
	<div class="nui-toolbar" align="left" borderStyle="border:0;"><strong>附件:</strong></div>
	<div colspan="3" class="td">
		<iframe id="prodIfm1" name="prodIfm1" width="98%"  height="120px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"></iframe>
	</div>
	
	<div class="nui-toolbar" align="left" borderStyle="border:0;"><strong>备注:</strong></div>
	<div colspan="5">
        <input class="nui-textarea"  name="newGold.vcRemark" id="vcRemark" width="100%" height="90px" readonly="readonly"  />
    </div>
		 </div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	
    	var basicInfo;
    	
    	function setInstructInfo(processInstID){
    		nui.ajax({
				url : "com.cjhxfund.ats.instruction.InterestSwap.InterestSwapInstruction.queryProcessGold.biz.ext",
				type : 'POST',
				data : {lProcessinstId:processInstID},
				cache : false,
				async: false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					var goldInfo = returnJson.goldInfo;
					if(goldInfo != null){	
						basicInfo = goldInfo;
                    	nui.get("vcProductName").setValue(goldInfo.vcProductName);
                    	nui.get("vcCombiName").setValue(goldInfo.vcCombiName);
                    	nui.get("lTradeDate").setValue(goldInfo.lTradeDate.toString());
                    	nui.get("vcEntrustDirection").setValue(goldInfo.vcEntrustDirection);
                    	nui.get("lGoldCapital").setValue(goldInfo.lGoldCapital);
                    	nui.get("vcAgentBank").setValue(goldInfo.vcAgentBank);
                    	nui.get("lAgentNo").setValue(goldInfo.lAgentNo);
                    	nui.get("vcAgentName").setValue(goldInfo.vcAgentName);
                    	nui.get("vcRemark").setValue(goldInfo.vcRemark);                   	
                    	
                    	var lAttachId = goldInfo.lAttachId;
                    	$("#prodIfm1").attr("src","<%= request.getContextPath() %>/fm/baseinfo/fileuploadComm/any_upload.jsp?attachType=77&attachBusType=3&bizId="+lAttachId+"&isEdit=n");
                    	
					}
					
				}
			});
    	}
    	
    </script>
</body>
</html>