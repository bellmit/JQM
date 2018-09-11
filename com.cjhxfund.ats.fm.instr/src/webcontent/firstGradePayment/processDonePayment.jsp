<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<table style="width:100%;table-layout:fixed;" border="0" class="nui-form-table">
	<colgroup>
		<col width="15%"></col>
		<col width="35%"></col>
		<col width="15%"></col>
		<col width="35%"></col>
	</colgroup>
	<tr>
		<td colspan="1" class="td1" width="15%" align="right">主题: </td>
		<td colspan="3" class="td2" width="85%">[<b:write property="firstGradeBond/lInvestNo" />]-<b:write property="firstGradeBond/vcProductName" />-<b:write property="firstGradeBond/vcStockName" /></td>
	</tr>
	<tr>
		<td class="td1" width="15%" align="right">
		当前节点:    
		</td>
		<td colspan="3" class="td2" width="85%"> <b:write property="workitem/workItemName" /> </td>
	</tr>
	<tr>
		<td class="td1" width="15%" align="right">上一节点参与者:</td>
		<td colspan="1" class="td2" width="35%"> <b:write property="lastActor" />		&nbsp;&nbsp;审批意见:<b:write property="lastComments" /></td>
		<td class="td2" width="15%" align="right">当前节点参与者:</td>
		<td class="td2" colspan="1" width="35%"> <b:write property="nextActor" /></td>
	</tr>
	<tr>
		<td class="td1" align="right">操作:</td>
		<td colspan="2" class="radio-border-top-none">
			<l:in property="workitem/activityDefID" targetValue="ATS_FM_YY">
				<input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
					data="[{id: 1, text: '同意'}, {id: 1, text: '用印'} ,{id: 2, text: '退办'},{id: 3, text: '转办'},{id: 4, text: '征求意见'},{id: 5, text: '否决'}]" style="float: left;" value="1" readonly="readonly"/>
			</l:in>
			<l:in property="workitem/activityDefID" targetValue="ATS_FM_TGFH,ATS_FM_WTRFH">
				<input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
					data="[{id: 1, text: '同意'} ,{id: 2, text: '退办'},{id: 5, text: '否决'}]" style="float: left;" value="1" readonly="readonly"/>
			</l:in>
			<l:in property="workitem/activityDefID" targetValue="ATS_FM_TZJYLR">
				<input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
					data="[{id: 1, text: '同意'} ,{id: 5, text: '否决'}]" style="float: left;" value="1" readonly="readonly"/>
			</l:in>
			<l:notIn property="workitem/activityDefID" targetValue="ATS_FM_YY,ATS_FM_TZJYLR,ATS_FM_TGFH,ATS_FM_WTRFH,ATS_FM_TZJYLR">
				<input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
					data="[{id: 1, text: '同意'} ,{id: 2, text: '退办'},{id: 3, text: '转办'},{id: 4, text: '征求意见'},{id: 5, text: '否决'}]"  value="1" readonly="readonly"/>
				</l:notIn>
			
		</td>
		<td class="td1">
		        <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow('close')">返回</a>
		        <span style="display:inline-block;width:5px;"></span>
		        <a class='nui-button' plain='false' iconCls="icon-print" onclick="paymentPrint()">打印</a>
		</td>
	</tr>
	
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_CZ_ZBQR">      
	<tr>
		<td class="td1 " width="20%" style="border-bottom: 1px solid #D3D3D3;" align="right">是否中标:</td>
		<td colspan="3" class="radio-border-top-none td2" style="border-bottom: 1px solid #D3D3D3;"> 
			<input name="bpsParam.yn" id="yn" class="nui-radiobuttonlist" 
				data="[{id: 1, text: '是'}, {id: 3, text: '否'}]" value="1" readonly="readonly"/>
		</td>
	</tr>
	</l:in>
	<!-- 风控人工审核环节 -->
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_FKRGSH">      
	<tr>
		<td class="td1 " width="20%" style="border-bottom: 1px solid #D3D3D3;" align="right">是否通过:</td>
		<td colspan="3" class="radio-border-top-none td2" style="border-bottom: 1px solid #D3D3D3;"> 
			<input name="bpsParam.yn" id="yn" class="nui-radiobuttonlist" 
				data="[{id: 1, text: '通过'}, {id: 2, text: '未通过'}]" value="1" readonly="readonly"/>
		</td>
	</tr>
	</l:in>
	<!-- 中标复核环节 -->
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_CZ_ZBFH">      
		<tr>
			<td class="td1 " width="20%" style="border-bottom: 1px solid #D3D3D3;" align="right">用印方式:</td>
			<td colspan="3" class="radio-border-top-none td2" style="border-bottom: 1px solid #D3D3D3;"> 
				<input name="bpsParam.yn" id="yn" class="nui-radiobuttonlist" 
					data="[{id: 0, text: '无需用印'}, {id: 1, text: '我方先用印'}, {id:2, text:'对方先用印'}]" value="<b:write property="firstGradeBond/lIndiaType" />" readonly="readonly"/>
			</td>
		</tr>
	</l:in>
	<tr>
		<td class="td1" align="right">处理意见:</td>
		<td colspan="3" class="td2"><input id="comments" class="nui-textarea" name="pmprcaprvinfo.vcComments" width="600" height="60" value="同意" readonly="readonly"/></td>
	</tr>
	
	<l:notIn property="workitem/activityDefID" targetValue="ATS_FM_TGLR,ATS_FM_TGFH,ATS_FM_WTRFH">
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right"><label style="color: red;">*</label>主题:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textbox" name="bpsParam.theme" id="theme" width="80%" value="<b:write property="firstGradeBond/vcProductName" />-<b:write property="firstGradeBond/vcStockName" />" readonly="readonly"/>
		</td>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right"><label style="color: red;">*</label>接收人传真号:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textbox" name="bpsParam.FaxNumber" id="FaxNumber" readonly="readonly" width="80%" value="<b:write property="firstGradeBond/vcFaxNumber" />"/>
		</td>
	</tr>
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_SCSFYYXY,ATS_FM_ZJQS,ATS_FM_PDFXYYY,ATS_FM_FXYYYFH,ATS_FM_FXYYY">
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">接收人姓名:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textbox" name="bpsParam.recvName" id="recvName" width="80%" readonly="readonly"/>
		</td>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">接收人公司名称:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textbox" name="bpsParam.recvCompany" id="recvCompany" width="80%" readonly="readonly"/>
		</td>
	</tr>
	</l:in>
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">联系电话:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textbox" name="bpsParam.vcTelephoneNumber" id="vcTelephoneNumber" readonly="readonly" width="80%" value="<b:write property="firstGradeBond/vcTelephoneNumber" />"/>
		</td>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right"></td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			
		</td>
	</tr>
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">传真备注:</td>
		<td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textarea" name="bpsParam.faxComments" id="faxComments"  width="500px" height="40px" readonly="readonly"/>
		</td>
	</tr> 
	</l:notIn>
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_SCSFYYXY,ATS_FM_ZJQS,ATS_FM_PDFXYYY,ATS_FM_FXYYYFH,ATS_FM_FXYYY">
	<!-- 邮件信息 -->
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">邮件主题:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textbox" name="bpsParam.title" id="title" width="80%" value="<b:write property="firstGradeBond/vcProductName" />-<b:write property="firstGradeBond/vcStockName" />"/>
		</td>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right"><label style="color: red;">*</label>邮件主送:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textbox" name="bpsParam.mailTo" id="mailTo"  width="80%"/>
		</td>
	</tr>
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">邮件抄送:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textbox" name="bpsParam.mailCc" id="mailCc" width="80%" />
		</td>
	</tr>
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">邮件正文:</td>
		<td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textarea" name="bpsParam.mailContext" id="mailContext" width="80%" height="60px"/>
		</td>
	</tr> 
	</l:in>
</table>
<a class='nui-button' plain='false' id="fileDownload" iconCls="icon-download" onclick="fileDownload1()" style="margin-top: 5px;" plain="false">下载</a>
<div id="file_Form" style="margin-top: 5px;">
	<input class="nui-hidden" name="map/bizId" value="<%=bizId %>"/>
	<input class="nui-hidden" name="map/attachBusType" value="1"/>
	<input class="nui-hidden" name="map/processinstid" value="<%=processinstid %>"/>
</div>
<div id="file_grid" class="mini-datagrid" style="width:100%;height:350px;" 
	 url="com.cjhxfund.ats.fm.comm.attachUitlFunction.queryAttachmentList.biz.ext" 
	 dataField="attachments"  showPageInfo="false" showPager="false" pageSize="50" multiSelect="true" allowSortColumn="false">
	 <div property="columns">
	 	<div type="checkcolumn" width="50"></div>
		<div field="lAttachId"  headerAlign="center" visible="false">编号</div> 
		<div field="vcAttachName"  headerAlign="center" style="width: 70%;" allowSort="true">文件名</div> 
		<div field="workitemname"  headerAlign="center" allowSort="true" width="50" headerAlign="center">环节名称</div>
		<div field="vcAnnexSeal" type="checkboxcolumn" trueValue="1" falseValue="0" width="30" headerAlign="center">是否用印</div>               
		<div field="vcWhetherIndia" type="checkboxcolumn" trueValue="1" falseValue="0" width="40" headerAlign="center">是否用过印</div>
		<div field="cWhetherArchiving" type="checkboxcolumn" trueValue="1" falseValue="0" width="40" headerAlign="center">是否需要归档</div>
	 </div>
</div>    

<div>
	<!-- 文档下载  -->
	<form id="file_download" method="post">
		<!-- 数据实体的名称 -->
		<input class="nui-hidden" name="processId" value="<%=processinstid %>"/>
		<input class="nui-hidden" name="sysid"  id="sysid"/>
		<input class="nui-hidden" name="workitemid"  id="workitemid2" value="<%=workItemID %>"/>
	</form>	
</div>
<div>
	<!-- word文档下载  -->
	<form id="word_download" method="post">
		<!-- 数据实体的名称 -->
		<input class="nui-hidden" name="bizId"  id="bizId"/>
		<!-- 还本方式 -->
		<input class="nui-hidden" name="modeRepayment"  id="modeRepayment"/>
		<!-- 计息起始日 -->
		<input class="nui-hidden" name="startingDateInterest"  id="lBegincalDate1"/>
		<!-- 计息截止日 -->
		<input class="nui-hidden" name="deadlineInterest"  id="deadlineInterest"/>
		<!-- 票面利率 -->
		<input class="nui-hidden" name="couponRate"  id="couponRate"/>
		<!-- 发行价格 -->
		<input class="nui-hidden" name="issuePrice"  id="issuePrice"/>
	</form>	
</div>
<!--隐藏表单 在线文档用印-->
<form action="" name="openForm" method="post" target="_blank">
  <input type="hidden" name="sysId" id="sysId">
</form>
<!-- 打印文档 -->
<form action="" name="PrintForm" method="post" target="_blank">
  <input type="hidden" name="processinstid" id="sysId" value=""/>
</form>
