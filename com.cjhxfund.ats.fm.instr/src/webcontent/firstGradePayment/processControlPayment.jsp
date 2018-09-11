<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<table style="width:100%;table-layout:fixed;" border="0" class="nui-form-table">
	<colgroup>
		<col width="15%"></col>
		<col width="30%"></col>
		<col width="15%"></col>
		<col width="40%"></col>
	</colgroup>
	<tr>
		<td colspan="1" class="td1" width="15%" align="right">主题: </td>
		<td colspan="3" class="td2" width="85%" id="processTitle">[<b:write property="firstGradeBond/lInvestNo" />]-<b:write property="firstGradeBond/vcProductName" />-<b:write property="firstGradeBond/vcStockName" /></td>
	</tr>
	<tr>
		<td class="td1" width="15%" align="right">上一节点参与者:</td>
		<td colspan="1" class="td2" width="30%"> <b:write property="lastActor" />		&nbsp;&nbsp;审批意见:<b:write property="lastComments" /></td>
		<td class="td2" width="15%" align="right">当前节点参与者:</td>
		<td class="td2" colspan="1" width="40%"> <b:write property="nextActor" /></td>
	</tr>
	<tr >
		<td class="td1" align="right">操作:</td>
		    <input class="nui-hidden" type="hidden" id="workitemActivityDefID" name="bpsParam.activityDefID" value="<b:write property="workitem/activityDefID"/>"/>
			<input class="nui-hidden" type="hidden" id="rollbackRemark" value="<b:write property="firstGradeBond/vcRollbackRemark" />"/>
		<td colspan="2" class="radio-border-top-none">
			
			<!-- <l:in property="workitem/activityDefID" targetValue="ATS_FM_YY">
				<input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
					data="[{id: 1, text: '同意'}, {id: 1, text: '用印'} ,{id: 2, text: '退办'},{id: 3, text: '转办'},{id: 4, text: '征求意见'},{id: 5, text: '否决'}]" style="float: left;" value="1"/>
			</l:in> -->
			<l:in property="workitem/activityDefID" targetValue="ATS_FM_TGFH,ATS_FM_WTRFH">
				<input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
					data="[{id: 1, text: '同意'} ,{id: 2, text: '退办'},{id: 5, text: '否决'}]" style="float: left;" value="1"/>
			</l:in>
			<l:in property="workitem/activityDefID" targetValue="ATS_FM_TZJYLR,ATS_FM_TGLR">
				<input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
					data="[{id: 1, text: '同意'} ,{id: 5, text: '否决'}]" style="float: left;" value="1"/>
			</l:in>
			<l:notIn property="workitem/activityDefID" targetValue="ATS_FM_YY,ATS_FM_TZJYLR,ATS_FM_TGLR,ATS_FM_TGFH,ATS_FM_WTRFH,ATS_FM_TZJYLR">
				<input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
					data="[{id: 1, text: '同意'} ,{id: 2, text: '退办'},{id: 3, text: '转办'},{id: 4, text: '征求意见'},{id: 5, text: '否决'}]" style="float: left;"  value="1"/>
				</l:notIn>
			<font style="color: red; margin-left: 10px;"></font><span id="handlerActorTitle"></span>
			<input class="nui-buttonedit" id="sendUser"  name="bpsParam.sendUser" onclick="selectSendUser" style="display: none;"/>
			<input class="nui-buttonedit" id="selectUser"  name="bpsParam.selectUser" onclick="selectActor" style="display: none;"/>
			<input class="nui-buttonedit" id="handlerActor"  name="bpsParam.handlerActor" onclick="selectActor" style="display: none;"/>
		</td>
		<td class="td1">
		  <l:in property="pageType" targetValue="1">

					<a class='nui-button' plain='false' iconCls="icon-save" onclick="processSubmit()">提交</a>
					<l:notIn property="workitem/activityDefID" targetValue="ATS_FM_TGLR,ATS_FM_TGFH,ATS_FM_WTRFH">
						<span style="display:inline-block;width:5px;"></span>
						<a class='nui-button' plain='false' iconCls="icon-download" onclick="wordDownloadPayMent()">新债信息表下载</a>
					</l:notIn>
					<l:in property="workitem/activityDefID" targetValue="ATS_FM_SCSFYYXY,ATS_FM_ZJQS">    
						<span style="display:inline-block;width:5px;"></span>
						<a class='nui-button' plain='false' iconCls="icon-download" onclick="place()">推送至恒生系统</a>
				    </l:in>
				    <l:in property="workitem/activityDefID" targetValue="ATS_FM_XYYYPD,ATS_FM_FXYYYFH,ATS_FM_PDFXYYY">    
						<span style="display:inline-block;width:5px;"></span>
						<a class='nui-button' plain='false' iconCls="icon-download" onclick="placePD()">推送至恒生系统</a>
				    </l:in>			
					<l:in property="workitem/activityDefID" targetValue="ATS_FM_XYYYPD,ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_SCSFYYXY,ATS_FM_ZJQS,ATS_FM_PDFXYYY,ATS_FM_FXYYYFH,ATS_FM_FXYYY">
						<span style="display:inline-block;width:5px;"></span>
						<a class='nui-button' plain='false' iconCls="icon-download" onclick="sendFaxes()">发送传真</a>
						<span style="display:inline-block;width:5px;"></span>
						<a class='nui-button' plain='false' iconCls="icon-download" onclick="sendmain()">发送邮件</a>
					</l:in>
					<span style="display:inline-block;width:5px;"></span>
					<a class='nui-button' plain='false' iconCls="icon-print" onclick="paymentPrint()">打印</a>
					<span style="display:inline-block;width:5px;"></span>
					<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow('close')">返回</a>
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
	<!-- 风控人工审核环节 -->
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_FKRGSH">      
	<tr>
		<td class="td1 " width="20%" style="border-bottom: 1px solid #D3D3D3;" align="right">是否通过:</td>
		<td colspan="3" class="radio-border-top-none td2" style="border-bottom: 1px solid #D3D3D3;"> 
			<input name="bpsParam.yn" id="yn" class="nui-radiobuttonlist" onitemclick="operateCheck1(this)"
				data="[{id: 1, text: '通过'}, {id: 2, text: '未通过'}]" value="1"/>
		</td>
	</tr>
	</l:in>
	<!-- 交易员协议用印判定 -->
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_XYYYPD">      
		<tr>
			<td class="td1 " width="20%" style="border-bottom: 1px solid #D3D3D3;" align="right">用印方式:</td>
			<td colspan="3" class="radio-border-top-none td2" style="border-bottom: 1px solid #D3D3D3;"> 
				<input name="bpsParam.yn" id="yn" class="nui-radiobuttonlist" onitemclick="operateCheck1(this)"
					data="[{id: 0, text: '无需用印'}, {id: 1, text: '我方先用印'}, {id:2, text:'对方先用印'}]" value="1"/>
			</td>
		</tr>
	</l:in>
	
	<!-- 交易员1判断非协议用印 -->
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_PDFXYYY">      
		<tr>
			<td class="td1 " width="20%" style="border-bottom: 1px solid #D3D3D3;" align="right">是否非协议用印:</td>
			<td colspan="3" class="radio-border-top-none td2" style="border-bottom: 1px solid #D3D3D3;"> 
				<input name="bpsParam.yn" id="yn" class="nui-radiobuttonlist" 
					data="[{id: 1, text: '是'}, {id: 0, text: '否'}]" value="1"/>
			</td>
		</tr>
	</l:in>
	<tr>
		<td class="td1" align="right">处理意见:</td>
		<l:in property="workitem/activityDefID" targetValue="ATS_FM_XYYYPD">
		   <td colspan="1" class="td2"><input id="comments" class="nui-textarea" name="pmprcaprvinfo.vcComments" width="450" height="60" value="我方先用印"/></td>
		</l:in>
		<l:notIn property="workitem/activityDefID" targetValue="ATS_FM_XYYYPD">
		   <td colspan="1" class="td2"><input id="comments" class="nui-textarea" name="pmprcaprvinfo.vcComments" width="450" height="60" value="同意"/></td>
		</l:notIn>
		<td class="td1" align="right" id="rollBack_remark1">退办原因:</td>
	    <td colspan="1" class="td2" id="rollBack_remark2"><input id="vcRollbackRemark" class="nui-textarea" name="bpsParam.vcRollbackRemark" width="400" height="60" value="<b:write property="firstGradeBond/vcRollbackRemark" />"/></td>
	    <td class="td1" align="right" id="rollBack_remark3" style="display: none;"></td>
	    <td colspan="1" class="td2" id="rollBack_remark4" style="display: none;"></td>
	</tr>
		<tr>
			<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">附件上传:</td>
			<td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
					<iframe id="prodIfm" width="100%" height="130px"  frameborder="no" border="0" marginwidth="0" marginheight="0"  src="<%= request.getContextPath() %>/fm/comm/fileupload/any_upload.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>&workItemID=<%=workItemID %>&attachType=1&attachBusType=1&type=1" ></iframe>  
			</td>
		</tr>
	<l:notIn property="workitem/activityDefID" targetValue="ATS_FM_TGLR,ATS_FM_TGFH,ATS_FM_WTRFH">
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">传真主题:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
		    <input class="nui-hidden" type="hidden" id="userTempData.vcDataType" name="userTempData.vcDataType" value="FAX"/>
			<input class="nui-hidden" type="hidden" id="userTempData.vcDataDetailType" name="userTempData.vcDataDetailType" value="<b:write property="firstGradeBond/vcStockCode" />"/>
			<input class="nui-hidden" type="hidden" id="userTempData.vcSysName" name="userTempData.vcSysName" value="FM"/>
			<input class="nui-hidden" type="hidden" id="userTempData.vcDataName" name="userTempData.vcDataName" value="传真"/>
			<input class="nui-hidden" type="hidden" id="userTempData.vcPageName" name="userTempData.vcPageName" value="<b:write property="pageURL" />"/>
			<input class="nui-hidden" type="hidden" id="userTempData.vcDataValue" name="userTempData.vcDataValue"/>
			<input class="nui-textbox" name="bpsParam.theme" id="theme" width="80%" value="<b:write property="firstGradeBond/vcProductName" />-<b:write property="firstGradeBond/vcStockName" />"/>
		</td>
		<l:in property="workitem/activityDefID" targetValue="ATS_FM_XYYYPD,ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_SCSFYYXY,ATS_FM_ZJQS,ATS_FM_PDFXYYY,ATS_FM_FXYYYFH,ATS_FM_FXYYY">
		   <td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right"><label style="color: red;">*</label>接收人传真号:</td>
		</l:in>
		<l:notIn property="workitem/activityDefID" targetValue="ATS_FM_XYYYPD,ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_SCSFYYXY,ATS_FM_ZJQS,ATS_FM_PDFXYYY,ATS_FM_FXYYYFH,ATS_FM_FXYYY">
		   <td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">接收人传真号:</td>
		</l:notIn>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input width="80%"  class="nui-combobox" id="FaxNumber"  name="bpsParam.FaxNumber" textField="vcDataValue" valueField="vcDataValue" multiSelect="true" showClose="true" onblur="checkFax1" oncloseclick="onCloseClickValueEmpty"
				   url="com.cjhxfund.ats.fm.instr.FirstGradeBond.queryFaxParametList.biz.ext?pageUrl=<b:write property="pageURL" />&sysName=FM&type=FAX&vcStockCode=<b:write property="firstGradeBond/vcStockCode"/>"  
				   emptyText="请选择" showNullItem="false"  allowInput="true" value="<b:write property="firstGradeBond/vcFaxNumber" />"/>
			<a class="nui-button " plain="false" iconCls="icon-remove" onclick="delCurrentFaxPara()"  plain="false" tooltip="删除">&nbsp;</a>
		
		</td>
	</tr>
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_XYYYPD,ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_SCSFYYXY,ATS_FM_ZJQS,ATS_FM_PDFXYYY,ATS_FM_FXYYYFH,ATS_FM_FXYYY">
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
	</l:in>
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">联系电话:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<%-- <input class="nui-textbox" onvaluechanged="checkPhone()" name="bpsParam.vcTelephoneNumber" id="vcTelephoneNumber" width="80%" value="<b:write property="firstGradeBond/vcTelephoneNumber" />"/> --%>
			<input width="80%"  class="nui-combobox" id="vcTelephoneNumber" onblur="checkPhone"  name="bpsParam.vcTelephoneNumber" textField="vcDataValue" valueField="vcDataValue" multiSelect="true" showClose="true" oncloseclick="onCloseClickValueEmpty"
				   url="com.cjhxfund.ats.fm.instr.FirstGradeBond.queryFaxParametList.biz.ext?sysName=FM&type=PHONE&vcStockCode=<b:write property="firstGradeBond/vcStockCode"/>" value="<b:write property="firstGradeBond/vcTelephoneNumber" />"
				   emptyText="请选择" showNullItem="false"  allowInput="true"/>
			<a class="nui-button " plain="false" iconCls="icon-remove" onclick="delTelephoneNumber()"  plain="false" tooltip="删除">&nbsp;</a>
		</td>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right"></td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			
		</td>
	</tr>
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">传真备注:</td>
		<td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textarea" name="bpsParam.faxComments" id="faxComments" width="80%" height="60px"/>
		</td>
	</tr> 
	</l:notIn>
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_TGLR,ATS_FM_TGFH,ATS_FM_WTRFH">
	    <!--  隐藏电话号码 -->
	    <input class="nui-hidden" name="bpsParam.vcTelephoneNumber" id="vcTelephoneNumber" value="<b:write property="firstGradeBond/vcTelephoneNumber" />"/>
	</l:in>
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_XYYYPD,ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_SCSFYYXY,ATS_FM_ZJQS,ATS_FM_PDFXYYY,ATS_FM_FXYYYFH,ATS_FM_FXYYY">
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
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_XXHD1,ATS_FM_XYYYPD,ATS_FM_PDFXYYY">
	<a class='nui-button' plain='false' id="editorFile" iconCls="icon-edit" onclick="editorFile()" style="margin-top: 5px;" plain="false">编辑文档</a>
	</l:in>
	<l:in property="workitem/activityDefID" targetValue="ATS_FM_XXHD1,ATS_FM_TGLR">
	<a class='nui-button' plain='false' id="generateFile" onclick="generateFile()" style="margin-top: 5px;" iconCls="icon-add" plain="false">生成申购函</a>
	</l:in>
	<a class='nui-button' plain='false' id="fileDownload" iconCls="icon-download" onclick="fileDownload1()" style="margin-top: 5px;" plain="false">下载</a>
	<!-- <l:in property="workitem/activityDefID" targetValue="ATS_FM_CZ">
	  <label style="color: red;margin-left: 50px;">发送传真时请"勾选"需要传真的附件</label>
	</l:in> -->
</div>

<div id="file_Form">
	<input class="nui-hidden" id="mapBizId" name="map/bizId" value="<%=bizId %>"/>
	<input class="nui-hidden" id="mapAttachBusType" name="map/attachBusType" value="1"/>
	<input class="nui-hidden" id="mapProcessinstid" name="map/processinstid" value="<%=processinstid %>"/>
</div>
	<div id="file_grid" class="mini-datagrid" style="width:100%;height:258px;" 
		 url="com.cjhxfund.ats.fm.comm.attachUitlFunction.queryProcrssAttachment.biz.ext"  showPager="false"
		 dataField="attachments" pageSize="50" showPageInfo="fase" multiSelect="true" allowSortColumn="false" allowCellEdit="true">
		 <div property="columns">
			<div type="checkcolumn" width="20"></div>
			<div field="lAttachId"  headerAlign="center" visible="false">编号</div> 
			<div field="vcAttachName"  headerAlign="center" style="width: 70%;" allowSort="true">文件名</div> 
			<div field="workitemname"  headerAlign="center" allowSort="true" width="50" headerAlign="center">环节名称</div>
			<div field="vcAnnexSeal" type="checkboxcolumn" trueValue="1" falseValue="0" width="30" headerAlign="center">是否用印</div>               
			<div field="vcWhetherIndia" type="checkboxcolumn" trueValue="1" falseValue="0" width="40" headerAlign="center" readOnly="true">是否用过印</div>		
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
		<!-- 下载方式：1是投资指令/建议管理，和申购中标确认前下载，否则为中标确认后的审批页面下载及缴款审批页下载 -->
		<input class="nui-hidden" name="type"  id="type" value="0"/>
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
	
		//删除传真参数
	function delCurrentFaxPara(){
		var faxText = nui.get("FaxNumber").getText();
		if(""==faxText){
			nui.alert("请选择一条数据！");
			return;
		}
		nui.confirm("确定删除当前记录？","系统提示",
					function(action){
						if(action=="ok"){
							var faxNumberData = nui.get("FaxNumber").getData();
							var inputFaxNumber = faxText.split(",");
							var deleteFaxNumberArray = new Array();
							for(var i =0;i<faxNumberData.length;i++){
								var tmpFaxNumber = faxNumberData[i].vcDataValue;
								for(var j=0;j<inputFaxNumber.length;j++){
									if(tmpFaxNumber == inputFaxNumber[j]){
										deleteFaxNumberArray.push(faxNumberData[i].lDataId);
									}
								}
							}
							if(deleteFaxNumberArray.length==0){
								nui.get("FaxNumber").setValue("");
								return;
							}else{
								var json = nui.encode({lDataId:deleteFaxNumberArray.toString()});
								$.ajax({
									url:"com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.deleteFaxParam.biz.ext",
									type:'POST',
									data:json,
									contentType:'text/json',
									success:function(obj){
											nui.get("FaxNumber").load("com.cjhxfund.ats.fm.instr.FirstGradeBond.queryFaxParametList.biz.ext?sysName=FM&type=FAX&vcStockCode=<b:write property="firstGradeBond/vcStockCode"/>");
									}
								});
							}
						}
					});
	}
	//删除电话号码
	function delTelephoneNumber(){
		var faxText = nui.get("vcTelephoneNumber").getText();
		if(""==faxText){
			nui.alert("请选择一条数据！");
			return;
		}
		nui.confirm("确定删除当前记录？","系统提示",
					function(action){
						if(action=="ok"){
							var faxNumberData = nui.get("vcTelephoneNumber").getData();
							var inputFaxNumber = faxText.split(",");
							var deleteFaxNumberArray = new Array();
							for(var i =0;i<faxNumberData.length;i++){
								var tmpFaxNumber = faxNumberData[i].vcDataValue;
								for(var j=0;j<inputFaxNumber.length;j++){
									if(tmpFaxNumber == inputFaxNumber[j]){
										deleteFaxNumberArray.push(faxNumberData[i].lDataId);
									}
								}
							}
							if(deleteFaxNumberArray.length==0){
								nui.get("vcTelephoneNumber").setValue("");
								return;
							}else{
								var json = nui.encode({lDataId:deleteFaxNumberArray.toString()});
								$.ajax({
									url:"com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.deleteFaxParam.biz.ext",
									type:'POST',
									data:json,
									contentType:'text/json',
									success:function(obj){
											nui.get("vcTelephoneNumber").load("com.cjhxfund.ats.fm.instr.FirstGradeBond.queryFaxParametList.biz.ext?sysName=FM&type=PHONE&vcStockCode=<b:write property="firstGradeBond/vcStockCode"/>");
									}
								});
							}
						}
					});
	}
	//校验传真号格式
    function checkFax1(){
       var FaxNum =nui.get("FaxNumber").getText();
		if(FaxNum!="" && FaxNum!=null){
	        var FaxNumber =nui.get("FaxNumber").getText().split(",");
	    	var checkFax = /^((\d{3,4}-)?\d{7,8})(\d{7,8})?$/;
	    	for(var i=0;i<FaxNumber.length;i++ ){
	    	    if(!checkFax.test(FaxNumber[i])){
					nui.alert("传真格式为:XXX-12345678或XXXX-1234567或XXXX-12345678或12345678,多个传真号时，用英文逗号分隔","系统提示");
					return false;
			     }
	    	} 
			return true;	
	    }
    }
    //校验联系电话格式
    function checkPhone(){
       var vcTelephoneNumber =nui.get("vcTelephoneNumber").getText();
		if(vcTelephoneNumber!="" && vcTelephoneNumber!=null){
	        var phoneNumber =nui.get("vcTelephoneNumber").getText().split(",");
	    	var checkPhone = /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
	    	for(var i=0;i<phoneNumber.length;i++ ){
	    	    if(!checkPhone.test(phoneNumber[i])){
					nui.alert("联系电话格式不正确,多个号码时，用英文逗号分隔","系统提示");
					return false;
			     }
	    	} 
			return true;	
	    }
    }
    function operateCheck1(ck) {
      var operateType = ck.value;
		if(operateType == 0){//无需用印
			nui.get("comments").setValue(ck.getSelected().text);
		} else if (operateType == 1){//我方先用印
		    nui.get("comments").setValue(ck.getSelected().text);
		} else if (operateType == 2){//对方先用印
		    nui.get("comments").setValue(ck.getSelected().text);
		}
    }
    window.onload = function(){
	    //根据退办原因是否有值来展示
	    var rollBack=$("#rollbackRemark").val();
		if(rollBack==null || rollBack==""){
		   $("#rollBack_remark1").hide();
		   $("#rollBack_remark2").hide();
		   $("#rollBack_remark3").show();
		   $("#rollBack_remark4").show();
		}else{ 
		   $("#rollBack_remark3").hide();
		   $("#rollBack_remark4").hide();
		   $("#rollBack_remark1").show();
		   $("#rollBack_remark2").show();
		}
	}
	//生成申购函
     function generateFile(){
     	//console.log("生成申购函");
     	var productCode = "<%=vcProductCode %>";
     	var templateQueryParams = new Array();
     	var params = new Array();
     		var map = {};
     		map['bizId']="<%=bizId %>";
     		map['workItemId']="<%=workItemID %>";
     		map['processInstId']="<%=processinstid %>";
     		map['stockInvestNo']=nui.get("applyInst.lStockInvestNo").getValue();
     		params[0] = map;
     		var queryMap={};
     		queryMap['stockInvestNo'] = nui.get("applyInst.lStockInvestNo").getValue();
     		templateQueryParams[0] = queryMap;
		   	
     	var json = nui.encode({templateQueryParams:templateQueryParams});
     	//console.log("json = " + json);
     	$.ajax({
	            url:'com.cjhxfund.ats.fm.baseinfo.tatsstocktemplatebiz.queryTemplateFilePath.biz.ext',
	            type:'POST',
	            data:json,
	            cache:false,
	            contentType:'text/json',
	            success:function(data){
	             	var returnJson = nui.decode(data);
             		if(returnJson.templateFilePath=="erro"){
         			nui.alert("选中的债券对应多个申购函模板。");
         			return;
	         		}
	         		if(returnJson.templateFilePath==null||returnJson.templateFilePath=="null"){
	         			nui.alert("选中的债券还没有配置对应的申购函模板。");
	         			return;
	         		}
         			var json1 = nui.encode({templateFilePath:returnJson.templateFilePath,productCode:productCode,params:params});
 					//console.log("json1 = "+json1);
				   	$.ajax({
			            url:'com.cjhxfund.ats.fm.baseinfo.purchaseOrderManager.generateOrder.biz.ext',
			            type:'POST',
			            data:json1,
			            cache:false,
			            contentType:'text/json',
			            success:function(data){
			            	var returnJson = nui.decode(data);
			            	if(returnJson.exception == null){
                        		nui.alert("申购函生成成功");
                        		window.parent.frames[0].location.reload(); 
	                        }else{
	                            nui.alert("申购函生成失败");
	                        }
			     		}
			     	});
	     		}
 			});
     }  
</script>
	    