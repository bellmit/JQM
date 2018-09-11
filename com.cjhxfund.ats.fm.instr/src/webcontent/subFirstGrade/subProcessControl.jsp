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
					data="[{id: 1, text: '同意'}, {id: 1, text: '用印'} ,{id: 2, text: '退办'},{id: 3, text: '转办'},{id: 4, text: '征求意见'},{id: 5, text: '否决'}]" style="float: left;" value="1"/>
			</l:in>
			<l:in property="workitem/activityDefID" targetValue="ATS_FM_TGFH,ATS_FM_WTRFH">
				<input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
					data="[{id: 1, text: '同意'} ,{id: 5, text: '否决'}]" style="float: left;" value="1"/>
			</l:in>
			<l:in property="workitem/activityDefID" targetValue="ATS_FM_TZJYLR,ATS_FM_TGLR">
				<input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
					data="[{id: 1, text: '同意'} ,{id: 5, text: '否决'}]" style="float: left;" value="1"/>
			</l:in>
			<l:notIn property="workitem/activityDefID" targetValue="ATS_FM_YY,ATS_FM_TZJYLR,ATS_FM_TGLR,ATS_FM_TGFH,ATS_FM_WTRFH,ATS_FM_TZJYLR">
				<input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
					data="[{id: 1, text: '同意'} ,{id: 5, text: '否决'}]"  value="1"/>
				</l:notIn>
			<font style="color: red; margin-left: 10px;"></font><span id="handlerActorTitle"></span>
			<input class="nui-buttonedit" id="sendUser"  name="bpsParam.sendUser" onclick="selectSendUser" style="display: none;"/>
			<input class="nui-buttonedit" id="selectUser"  name="bpsParam.selectUser" onclick="selectActor" style="display: none;"/>
			<input class="nui-buttonedit" id="handlerActor"  name="bpsParam.handlerActor" onclick="selectActor" style="display: none;"/>
		</td>
		<td class="td1">
		  <l:in property="pageType" targetValue="1">
				<a class='nui-button' plain='false' iconCls="icon-save" onclick="processSubmit()">提交</a>
				<l:in property="workitem/activityDefID" targetValue="ATS_FM_CZ_ZBFH">
					<span style="display:inline-block;width:5px;"></span>
					<a class='nui-button' plain='false' iconCls="icon-download" onclick="wordDownload()">新债信息表下载</a>
				</l:in>
				<!-- <l:in property="workitem/activityDefID" targetValue="ATS_FM_FKRGSH">
					<span style="display:inline-block;width:5px;"></span>
					<a class='nui-button' plain='false' iconCls="icon-download" onclick="windControlTrial()">风控试算</a>
				</l:in> -->				
				<l:in property="workitem/activityDefID" targetValue="ATS_FM_CZ_ZBFH,ATS_FM_CZ_XYFH1,ATS_FM_CZ_XYFH2,ATS_FM_CZ_XYYY1,ATS_FM_CZ_XYYY2,ATS_FM_CZ_SCXY,ATS_FM_CZ_SFFXYYY,ATS_FM_CZ_JYYFH2,ATS_FM_CZ_FXYYY">    
					<span style="display:inline-block;width:5px;"></span>
					<a class='nui-button' plain='false' iconCls="icon-download" onclick="place()">推送至恒生系统</a>
				</l:in>	
				<span style="display:inline-block;width:5px;"></span>
				<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow('close')">返回</a>
				<l:in property="workitem/activityDefID" targetValue="ATS_FM_CZ_TBZX,ATS_FM_CZ_CZZZCXS,ATS_FM_CZ_FSZCXS">
					<span style="display:inline-block;width:5px;"></span>
					<a class='nui-button' plain='false' iconCls="icon-download" onclick="sendFaxes()">发送传真</a>
					<span style="display:inline-block;width:5px;"></span>
					<a class='nui-button' plain='false' iconCls="icon-download" onclick="sendmain()">发送邮件</a>
				</l:in>
				<span style="display:inline-block;width:5px;"></span>
				<a class='nui-button' plain='false' iconCls="icon-print" onclick="Print()">打印</a>
		   </l:in>
		   <l:in property="pageType" targetValue="2">
		   		<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow('close')">返回</a>
		   </l:in>
		</td>
	</tr>
	
	<!-- 退办 -->
	<tr id="backActivity_tr" style="display: none;">
		<th class="nui-form-label td1" align="right">退办:</th>
		<td colspan="3" class="td2">
			<input id="backActivity" name="bpsParam.backActivity" class="nui-combobox" onvaluechanged="backActivityChanged" textField="name" valueField="id" required="true" style="width: 300px">
			<!-- <input id="isFallback" name="bpsParam.isFallback" class="nui-checkbox" trueValue="1" falseValue="0"/>退办后的节点通过后直接返回本节点 -->
		</td>
	</tr>
	<!-- 中标确认环节 -->
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_CZ_ZBQR">      
	<tr>
		<td class="td1 " width="20%" style="border-bottom: 1px solid #D3D3D3;" align="right">是否中标:</td>
		<td colspan="3" class="radio-border-top-none td2" style="border-bottom: 1px solid #D3D3D3;"> 
			<input name="bpsParam.yn" id="yn" class="nui-radiobuttonlist" 
				data="[{id: 1, text: '是'}, {id: 3, text: '否'}]" value="1"/>
		</td>
	</tr>
	</l:in>
	<!-- 风控人工审核环节 -->
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_FKRGSH">      
	<tr>
		<td class="td1 " width="20%" style="border-bottom: 1px solid #D3D3D3;" align="right">是否通过:</td>
		<td colspan="3" class="radio-border-top-none td2" style="border-bottom: 1px solid #D3D3D3;"> 
			<input name="bpsParam.yn" id="yn" class="nui-radiobuttonlist" 
				data="[{id: 1, text: '通过'}, {id: 2, text: '未通过'}]" value="1"/>
		</td>
	</tr>
	</l:in>
	<!-- 中标复核环节 -->
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_CZ_ZBFH">      
		<tr>
			<td class="td1 " width="20%" style="border-bottom: 1px solid #D3D3D3;" align="right">用印方式:</td>
			<td colspan="3" class="radio-border-top-none td2" style="border-bottom: 1px solid #D3D3D3;"> 
				<input name="bpsParam.yn" id="yn" class="nui-radiobuttonlist" 
					data="[{id: 0, text: '无需用印'}, {id: 1, text: '我方先用印'}, {id:2, text:'对方先用印'}]" value="<b:write property="firstGradeBond/lIndiaType" />"/>
			</td>
		</tr>
	</l:in>
	
	<!-- 是否非协议用印 -->
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_CZ_SFFXYYY">      
		<tr>
			<td class="td1 " width="20%" style="border-bottom: 1px solid #D3D3D3;" align="right">是否非协议用印:</td>
			<td colspan="3" class="radio-border-top-none td2" style="border-bottom: 1px solid #D3D3D3;"> 
				<input name="bpsParam.yn" id="yn" class="nui-radiobuttonlist" 
					data="[{id: 1, text: '是'}, {id: 0, text: '否'}]" value="0"/>
			</td>
		</tr>
	</l:in>
	<tr>
		<td class="td1" align="right">处理意见:</td>
		<td colspan="3" class="td2"><input id="comments" class="nui-textarea" name="pmprcaprvinfo.vcComments" width="600" height="60" value="同意"/></td>
	</tr>
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_CZ_TBZX">
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">传真主题:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textbox" name="bpsParam.theme" id="theme" width="80%" value="<b:write property="firstGradeBond/vcProductName" />-<b:write property="firstGradeBond/vcStockName" />"/>
		</td>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right"><label style="color: red;">*</label>接收人传真号:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textbox" name="bpsParam.FaxNumber" id="FaxNumber" onvaluechanged="checkFax" width="80%"/>
		</td>
	</tr>
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">接收人姓名:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textbox" name="bpsParam.recvName" id="recvName" width="80%"/>
		</td>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">接收人公司名称:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textbox" name="bpsParam.recvCompany" id="recvCompany" width="80%" />
		</td>
	</tr>
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">传真备注:</td>
		<td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textarea" name="bpsParam.faxComments" id="faxComments" width="80%" height="60px"/>
		</td>
	</tr> 
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
<div>
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_XXHD1,ATS_FM_CZ_ZBFH,ATS_FM_CZ_SFFXYYY">
	<a class='nui-button' plain='false' id="editorFile" iconCls="icon-edit" onclick="editorFile()" style="margin-top: 5px;" plain="false">编辑文档</a>
	</l:in>
	<a class='nui-button' plain='false' id="fileDownload" iconCls="icon-download" onclick="fileDownload1()" style="margin-top: 5px;" plain="false">下载</a>
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_CZ">
	  <label style="color: red;margin-left: 50px;">发送传真时请"勾选"需要传真的附件</label>
	</l:in>
</div>
<div id="file_Form">
	<input class="nui-hidden" name="map/bizId" value="<%=bizId %>"/>
	<input class="nui-hidden" name="map/attachBusType" value="1"/>
	<input class="nui-hidden" name="map/processinstid" value="<%=processinstid %>"/>
</div>
<l:notIn property="workitem/activityDefID" targetValue="ATS_FM_XXHD1,ATS_FM_CZ_ZBFH,ATS_FM_CZ_SFFXYYY">
	<div id="file_grid" class="mini-datagrid" style="width:100%;height:258px;" 
		 url="com.cjhxfund.ats.fm.comm.attachUitlFunction.queryAttachmentList.biz.ext"  showPager="false"
		 dataField="attachments" pageSize="50" showPageInfo="fase" multiSelect="true" allowSortColumn="false">
		 <div property="columns">
			<div type="checkcolumn" width="20"></div>
			<div field="lAttachId"  headerAlign="center" visible="false">编号</div> 
			<div field="vcAttachName"  headerAlign="center" style="width: 70%;" allowSort="true">文件名</div> 
			<div field="workitemname"  headerAlign="center" allowSort="true" width="50" headerAlign="center">环节名称</div>
			<div field="vcAnnexSeal" type="checkboxcolumn" trueValue="1" falseValue="0" width="30" headerAlign="center">是否用印</div>               
			<div field="vcWhetherIndia" type="checkboxcolumn" trueValue="1" falseValue="0" width="40" headerAlign="center">是否用过印</div>					
		 </div>
	</div>   
</l:notIn>
<l:in property="workitem/activityDefID" targetValue="ATS_FM_XXHD1,ATS_FM_CZ_ZBFH,ATS_FM_CZ_SFFXYYY">
	<div id="file_grid" class="mini-datagrid" style="width:100%;height:258px;" 
		 url="com.cjhxfund.ats.fm.comm.attachUitlFunction.queryAttachmentList.biz.ext"  showPager="false"
		 dataField="attachments" pageSize="50" showPageInfo="fase" multiSelect="true" allowSortColumn="false" allowCellEdit="true">
		 <div property="columns">
			<div type="checkcolumn" width="20"></div>
			<div field="lAttachId"  headerAlign="center" visible="false">编号</div> 
			<div field="vcAttachName"  headerAlign="center" style="width: 70%;" allowSort="true">文件名</div> 
			<div field="workitemname"  headerAlign="center" allowSort="true" width="50" headerAlign="center">环节名称</div>
			<div field="vcAnnexSeal" type="checkboxcolumn" trueValue="1" falseValue="0" width="30" headerAlign="center"><label style="color: red;">是否需要用印</label></div>               
			<div field="vcWhetherIndia" type="checkboxcolumn" trueValue="1" falseValue="0" width="40" headerAlign="center" readOnly="true">是否用过印</div>
			<div field="cWhetherArchiving" type="checkboxcolumn" trueValue="1" falseValue="0" width="40" headerAlign="center">是否需要归档</div>		
		 </div>
	</div>   
</l:in>	
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

<script>
  //用印环节用印，双击打开文档
	function backActivityChanged(e){
	   nui.get("comments").setValue("退办 : " + "'"+ nui.get("backActivity").getText() +"'环节");
	}
	
	
</script>
	    