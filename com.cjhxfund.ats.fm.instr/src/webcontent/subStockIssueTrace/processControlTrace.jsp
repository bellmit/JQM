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
			
			<input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
					data="[{id: 1, text: '同意'} ,{id: 5, text: '否决'}]" style="float: left;" value="1"/>
		
			<font style="color: red; margin-left: 10px;"></font><span id="handlerActorTitle"></span>
			<input class="nui-buttonedit" id="sendUser"  name="bpsParam.sendUser" onclick="selectSendUser" style="display: none;"/>
			<input class="nui-buttonedit" id="selectUser"  name="bpsParam.selectUser" onclick="selectActor" style="display: none;"/>
			<input class="nui-buttonedit" id="handlerActor"  name="bpsParam.handlerActor" onclick="selectActor" style="display: none;"/>
		</td>
		<td class="td1">
		  <l:in property="pageType" targetValue="1">

					<a class='nui-button' plain='false' iconCls="icon-save" onclick="processSubmit()">提交</a>
					
					<span style="display:inline-block;width:5px;"></span>
					<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow('close')">返回</a>
		   </l:in>
		   <l:in property="pageType" targetValue="2">
		   		<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow('close')">返回</a>
		   </l:in>
		</td>
	</tr>
	
	
	

	<tr>
		<td class="td1" align="right">处理意见:</td>
		   <td colspan="1" class="td2"><input id="comments" class="nui-textarea" name="pmprcaprvinfo.vcComments" width="450" height="60" value="同意"/></td>
		   <td class="td1" style="border-bottom: 1px solid #D3D3D3;">
		</td>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;">
		</td>
	</tr>
		
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">传真主题:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
		   
			<input class="nui-textbox" name="bpsParam.theme" id="theme" width="80%" readOnly="readonly"  value="<b:write property="firstGradeBond/vcProductName" />-<b:write property="firstGradeBond/vcStockName" />"/>
		</td>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">接收人传真号:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input width="80%"  class="nui-combobox" id="FaxNumber"  name="bpsParam.FaxNumber" readOnly="readonly"  textField="vcDataValue" valueField="vcDataValue" multiSelect="true" showClose="true"  oncloseclick="onCloseClickValueEmpty"
				   url="com.cjhxfund.ats.fm.instr.FirstGradeBond.queryFaxParametList.biz.ext?pageUrl=<b:write property="pageURL" />&sysName=FM&type=FAX&vcStockCode=<b:write property="firstGradeBond/vcStockCode"/>"  
				   emptyText="请选择" showNullItem="false"  allowInput="true" value="<b:write property="firstGradeBond/vcFaxNumber" />"/>
		
		</td>
		
	</tr>
	
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">接收人姓名:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textbox" name="bpsParam.recvName" id="recvName" width="80%" readOnly="readonly" style="background-color:#f0f0f0"/>
		</td>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">接收人公司名称:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textbox" name="bpsParam.recvCompany" id="recvCompany" width="80%" readOnly="readonly" style="background-color:#f0f0f0"/>
		</td>
	</tr>
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">联系电话:</td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<%-- <input class="nui-textbox" onvaluechanged="checkPhone()" name="bpsParam.vcTelephoneNumber" id="vcTelephoneNumber" width="80%" value="<b:write property="firstGradeBond/vcTelephoneNumber" />"/> --%>
			<input width="80%"  class="nui-combobox" id="vcTelephoneNumber" name="bpsParam.vcTelephoneNumber" textField="vcDataValue" valueField="vcDataValue" multiSelect="true" showClose="true" oncloseclick="onCloseClickValueEmpty"
				   url="com.cjhxfund.ats.fm.instr.FirstGradeBond.queryFaxParametList.biz.ext?sysName=FM&type=PHONE&vcStockCode=<b:write property="firstGradeBond/vcStockCode"/>" value="<b:write property="firstGradeBond/vcTelephoneNumber" />"
				   emptyText="请选择" showNullItem="false"  allowInput="true" readOnly="readonly" />
		</td>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right"></td>
		<td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			
		</td>
	</tr>
	<tr>
		<td class="td1" style="border-bottom: 1px solid #D3D3D3;" align="right">传真备注:</td>
		<td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			<input class="nui-textarea" name="bpsParam.faxComments" id="faxComments" readOnly="readonly"  width="80%" height="60px"/>
		</td>
	</tr> 
	
	
</table>
<div>
	<!-- <a class='nui-button' plain='false' id="fileDownload" iconCls="icon-download" onclick="fileDownload1()" style="margin-top: 5px;" plain="false">下载</a>
 -->
</div>

<div id="file_Form">
	<input class="nui-hidden" id="mapBizId" name="map/bizId" value="<%=bizId %>"/>
	<input class="nui-hidden" id="mapAttachBusType" name="map/attachBusType" value="1"/>
	<input class="nui-hidden" id="mapProcessinstid" name="map/processinstid" value="<%=processinstid %>"/>
</div>
	<div id="file_grid" class="mini-datagrid" style="width:100%;height:258px;" 
		 url="com.cjhxfund.ats.fm.comm.attachUitlFunction.queryProcrssAttachment.biz.ext"  showPager="false"
		 dataField="attachments" pageSize="50" showPageInfo="fase" multiSelect="true" allowSortColumn="false" >
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

<script type="text/javascript">
  //用印环节用印，双击打开文档
   
</script>
	    