<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 石浩
  - Date: 2016-08-24 14:44:08
  - Description:
-->
<head>
        <title>
           	 新债信息复核
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        
		
    </head>
    <body style="width:100%;height:100%;overflow: hidden; margin: 0px;">
       <div class="search-condition">
		  <div class="list">
            <div id="form1" class="nui-form"  align="center" style="height:10%" >
                <!-- 数据实体的名称 -->
                <input class="nui-hidden" name="bizCriteria/_entity" value="com.cjhxfund.foundation.task.EntityDataSet.QueryWorkitemList">
                <table id="table1" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                    <tr>
                        <td style="width:60px" align="right">
                           	     发起日期:
                        </td>
                        <td style="width:100px" align="left">
                            <input class="nui-datepicker" id="dApplicationTime" format="yyyy-MM-dd" name="paramMap/dApplicationTime" width="100%"/>
                        </td>
                        <td style="width:60px" align="right">
                        	      债券简称:
                        </td>
                        <td style="width:100px" align="left">
                          <input  class="nui-textbox" name="paramMap/vcStockName" id="vcStockName" width="100%"/>
                        </td>
                       	<td style="width:60px" align="right">
                        	      债券代码:
                        </td>
                        <td style="width:100px" align="left">
                          <input class="nui-textbox" name="paramMap/vcStockCode" id="vcStockCode" width="100%"/>
                        </td>
                        <td style="width:100px" align=center>
								<input class="nui-checkbox" name="paramMap/checkBox" id="checkBox" width="100%"/>本人已办流程
						</td>
                        <td style="width:20%" align="center">
	                       <!--footer-->
					        <div property="footer" align="left">
					            <span><a class='nui-button' plain='false' iconCls="icon-search"  onclick="search()">
					                查询
					            </a>
					         &nbsp;
					            <a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
					                重置
					            </a></span>
					        </div>
                        </td>
                    </tr>
                </table>
            </div>
          </div>
        </div>  
        <div class="nui-toolbar" style="border-bottom:0;padding:0px">
                <table style="width:100%;height:20px;">
                    <tr>
                        <td style="width:100%;">
                        </td>
                    </tr>
                </table>
            </div>  
            <div id="layout1" class="mini-layout" style="width:100%; height:92%;"  borderStyle="border:solid 1px #aaa;"> 
			<div title="center" region="center"  >
            <div class="nui-fit" >
                <div 
                        id="datagrid1"
                        dataField="wflist"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryApproveInfo.biz.ext"
                        pageSize="20"
                        onShowRowDetail="onShowRowDetailList"
                        showPageInfo="true"
                        multiSelect="true" sortField="D_APPLICATION_TIME"  sortOrder="desc" onselectionchanged="selectionChange">
						
                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div type="checkcolumn"></div>
                        <div type="expandcolumn"></div>
                        <div name="action" width="40" align="center" headerAlign="center">#</div>
                        <div field="L_PROCESS_INST_ID" headerAlign="center" width="20px" allowSort="true" visible="false">
                            	流程编号
                        </div>
                        <div field="WORKITEMID" headerAlign="center" width="20px" allowSort="true" visible="false">
                           	工作项 编号
                        </div>
                        <div field="L_BIZ_ID" headerAlign="center" width="20px" allowSort="true" visible="false">
                          	 业务编号
                        </div>
                        <div field="ACTIONURL" headerAlign="center" allowSort="true" visible="false">
                           url
                        </div>
                        <div field="WORKITEMNAME" headerAlign="center" allowSort="true" width="80px" >
                          	 当前节点
                        </div>
                        <div field="D_APPLICATION_TIME" headerAlign="center" align="center" width="90px" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss">
                            	发起时间
                        </div>
                        
                        <div field="VC_STOCK_CODE" headerAlign="center" allowSort="true" >
                            	债券代码
                        </div>
                        <div field="VC_STOCK_NAME" headerAlign="center" allowSort="true" >
                            	债券简称
                        </div>                
                        <div field="VC_STOCK_NAME_FULL" headerAlign="center" allowSort="true" >
                            	债券全称
                        </div>                
                        <div field="VC_PRODUCT_CODE" headerAlign="center" allowSort="true" visible="false">
                            	产品代码
                        </div>
                        <div field="VC_COMBI_NO" headerAlign="center"  allowSort="true" visible="false">
                            	组合代码
                        </div>
                        <div field="VC_ABSTRACT" headerAlign="center" allowSort="true" >
                          	摘要
                        </div>
                        <div field="VC_PROCESS_TYPE" headerAlign="center" align="left" width="80px" allowSort="true" renderer="rendererVcProcessType">
                           	 业务操作类型
                        </div>
                        <div field="L_INVEST_NO" headerAlign="center" align="right" allowSort="true" width="50" visible="false">
                            	序号
                        </div>
                        <div field="L_STOCK_INVEST_NO" headerAlign="center" align="right" allowSort="true" width="50">
                            	序号
                        </div>
                    </div>
                </div>
               </div>
            </div>
            <div title="新债复核详细信息" region="south" showSplit="false" showHeader="true" height="250" showSplitIcon="true" >
				        <div id="editForm1" style="margin-right:15px">
				            <input class="mini-hidden" name="id"/>
				             <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
					                <tr>
							                   <td align="right">登记托管机构:</td>
											   <td align="left"><input id="vcPaymentPlace" width="100%"
													class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS"
													name="debtIssue.vcPaymentPlace" 
													readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
							                    <td  align="right">债券代码:</td>
							                    <td  align="left">
							                    	<input align="left" width="100%" id="vcStockCode" name="debtIssue.vcStockCode" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td   align="right">债券简称:</td>
							                    <td   align="left">
							                    	<input align="left" width="100%" id="vcStockName" name="debtIssue.vcStockName" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td   align="right">债券全称:</td>
							                    <td    align="left">
							                    	<input align="left" width="100%" name="debtIssue.vcStockNameFull" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td   align="right">债券类别:</td>
							                    <td   align="left">
							                    	<input align="left" width="100%" name="debtIssue.typeName" name="typeName" class="mini-textbox"   readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							                <tr>
							                    <td align="right">发行期限(年):</td>
							                    <td align="left">
							                    	<input id="enExistLimite" width="100%" name="debtIssue.enExistLimite" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">发行规模(亿):</td>
							                    <td align="left">
							                    	<input id="enIssueBalance" width="100%" name="debtIssue.enIssueBalance" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">债券评级:</td>
							                    <td align="left">
							                    	<input id="cBondAppraise" width="100%" name="debtIssue.cBondAppraise" class="nui-dictcombobox" dictTypeId="creditRating" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">债券评级机构:</td>
							                    <td align="left">
							                    	<input id="vcBondAppraiseOrgan" width="100%" name="debtIssue.vcBondAppraiseOrgan" class="nui-dictcombobox" dictTypeId="outRatingOrgan" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">主体评级:</td>
							                    <td align="left">
							                    	<input id="cIssueAppraise" width="100%" name="debtIssue.cIssueAppraise" class="nui-dictcombobox" dictTypeId="issuerRating" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							                
							                 <tr>
							                    <td align="right">主体类型:</td>
							                    <td align="left">
							                    	<input id="vcIssueProperty" width="100%" name="debtIssue.vcIssueProperty" class="nui-dictcombobox"  dictTypeId="ATS_FM_ISSUE_PROPERTY" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">主体简称:</td>
							                    <td align="left">
							                    	<input id="vcIssuerName" width="100%" name="debtIssue.vcIssuerName" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">主体评级机构:</td>
							                    <td align="left">
							                    	<input id="vcIssueAppraiseOrgan" width="100%" name="debtIssue.vcIssueAppraiseOrgan" class="nui-dictcombobox" dictTypeId="outRatingOrgan" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">所属行业:</td>
											    <td align="left"><input id="vcIndustryName" width="100%"
													name="debtIssue.vcIndustryName" class="mini-textbox" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
												<td align="right">所属省份:</td>
												<td align="left"><input id="vcProvince" width="100%"
													name="debtIssue.vcProvince" class="mini-textbox" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>	
							                </tr>
							                
							                 <tr>
							                    <td align="right">公告日期:</td>
							                    <td align="left">
							                    	<input id="lIssuePostDate" width="100%" name="debtIssue.lIssuePostDate" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">发行日期:</td>
							                    <td align="left">
							                    	<input id="lIssueBeginDate" width="100%" name="debtIssue.lIssueBeginDate" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right" style="width:90px;">投标截止时间:</td>
												<td align="left"><input id="dBidLimitTime" width="100%"
													name="debtIssue.dBidLimitTime" class="nui-datepicker" format="yyyy-MM-dd hh:mm:ss"
													readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
							                    <td align="right">缴款日期:</td>
							                    <td align="left">
							                    	<input id="lPayDate" width="100%" name="debtIssue.lPayDate" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">上市日期:</td>
							                    <td align="left">
							                    	<input id="lPublishDate" width="100%" name="debtIssue.lPublishDate" class="mini-textbox"  readonly="true"   inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							                
							                <tr>
							                    <td align="right">利率类型:</td>
												<td align="left"><input id="cInterestType" width="100%"
													name="debtIssue.cInterestType" class="nui-dictcombobox" dictTypeId="rateType" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
												<td align="right">息票品种:</td>
												<td align="left"><input id="cPayInterestType" width="100%"
													name="debtIssue.cPayInterestType" readonly="true"
													class="nui-dictcombobox" dictTypeId="payInterestType"
													inputStyle="background-color:#f0f0f0;" /></td>
												<td align="right">付息频率:</td>
												<td align="left"><input id="enPayInteval" width="100%"
													name="debtIssue.enPayInteval"class="nui-dictcombobox" dictTypeId="ATS_CF_JY_FREQUENCY" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
							                   	<td align="right">票面利率%:</td>
												<td align="left"><input id="enFaceRate" width="100%"
													name="debtIssue.enFaceRate" class="mini-textbox" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
												<td align="right">缴款方式:</td>
												<td align="left"><input id="cPayType" width="100%"
													name="debtIssue.cPayType" class="nui-dictcombobox" dictTypeId="ATS_FM_PAYMENT" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>				                    
							                </tr>
							                
							                <tr>
							                    <td align="right">主承销商:</td>
							                    <td align="left">
							                    	<input id="vcMainUnderwriter" width="100%" name="debtIssue.vcMainUnderwriter" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">副主承销商:</td>
							                    <td align="left">
							                    	<input id="vcDeputyUnderwriter" width="100%" name="debtIssue.vcDeputyUnderwriter" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">承销方式:</td>
							                    <td align="left">
							                    	<input id="cUnderwriteType" width="100%" name="debtIssue.cUnderwriteType" class="nui-dictcombobox"  dictTypeId="underwriteType" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">承销团:</td>
												<td align="left"><input id="vcGroupUnderwriter" width="100%"
													name="debtIssue.vcGroupUnderwriter" class="mini-textbox"
													readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
												<td align="right">特殊条款:</td>
												<td align="left"><input id="vcSpecialText" width="100%"
													name="debtIssue.vcSpecialText" class="nui-dictcombobox" dictTypeId="specialText" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>	
							                </tr>
							                
							                <tr>
 												<td align="right">招标方式:</td>
												<td align="left"><input id="cBidType" width="100%"
													name="debtIssue.cBidType" class="nui-dictcombobox" dictTypeId="tenderType" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
													
											    <td align="right">起息日期:</td>
												<td align="left"><input id="lBegincalDate" width="100%"
													name="debtIssue.lBegincalDate" class="mini-textbox" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
											    <td align="right">到期日期:</td>
							                    <td align="left">
							                    	<input id="lEndincalDate" width="100%" name="debtIssue.lEndincalDate" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">担保人名称:</td>
							                    <td align="left">
							                    	<input id="vcGuarantorName" width="100%" name="debtIssue.vcGuarantorName" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">信用分析:</td>
												<td align="left"><input id="vcCreditAnalyze" width="100%"
													name="debtIssue.vcCreditAnalyze" class="mini-textbox"
													readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
											</tr>
											         
										    <tr>
							                    <td align="right">下一行权日:</td>
												<td align="left"><input id="lNextExerciseDate" width="100%"
													name="debtIssue.lNextExerciseDate" class="mini-textbox" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
												<td align="right">是否具有回售权:</td>
							                    <td align="left">
							                    	<input id="cIsHaveSaleback" width="100%" name="debtIssue.cIsHaveSaleback" class="mini-combobox"  data="[{ id: 1, text: '是' }, { id: 0, text: '否'}]" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">是否具有赎回权:</td>
												<td align="left"><input id="cIsHaveBuyback" width="100%"
													name="debtIssue.cIsHaveBuyback" class="mini-combobox"  data="[{ id: 1, text: '是' }, { id: 0, text: '否'}]"
													readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
												<td align="right">发行方式:</td>
							                    <td align="left">
							                    	<input id="vcIssueType" width="100%" name="debtIssue.vcIssueType" class="nui-dictcombobox" dictTypeId="issueType" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">特殊期限:</td>
							                    <td align="left">
							                    	<input id="vcSpecialLimite" width="100%" name="debtIssue.vcSpecialLimite" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>			
							                </tr>
							                
							                <tr>
							                    <td align="right">发行规模描述:</td>
							                    <td align="left">
							                    	<input id="vcExistLimiteDesc" width="100%" name="debtIssue.vcExistLimiteDesc" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">发行日期描述:</td>
							                    <td align="left">
							                    	<input id="vcIssueBeginDateDesc" width="100%" name="debtIssue.vcIssueBeginDateDesc" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">投标区间:</td>
							                    <td align="left">
							                    	<input id="vcTenderInterval" width="100%" name="debtIssue.vcTenderInterval" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">承销商联系人信息:</td>
							                    <td align="left">
							                    	<input id="vcUnderwriterInfo" width="100%" name="debtIssue.vcUnderwriterInfo" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
					            </table>
				        </div>
</div>
</div>
            
 <!--隐藏表单-->
<form action="" name="openForm" method="post" target="_blank">
  <input type="hidden" name="workItemID" id="workItemID">
  <input type="hidden" name="processInstID" id="processinstid">
  <input type="hidden" name="bizId" id="bizId">
  <input type="hidden" name="pageType" id="pageType" value="1"/>
  <input type="hidden" name="processType" id="processType"/>
  <input type="hidden" name="stockInvestNo" id="stockInvestNo"/>
</form>
<script type="text/javascript">
	nui.parse();
	var grid = nui.get("datagrid1");
	var jurisdiction ="";
	//用于显示数据详情
	var form = new nui.Form("#editForm1");
	var formSear = new nui.Form("#form1");
	var formData = new nui.Form("#form1").getData(false,false);
	grid.load(formData);
    $("#editForm1 .mini-buttonedit-buttons").remove();
	$("#editForm1 .mini-buttonedit-border").css("background-color","#f0f0f0");
	var contextPath = '<%=request.getContextPath() %>';
	var isWork = nui.get("checkBox").value;
	//行双击时弹出页面展示该指令/建议详细信息
	grid.on("rowdblclick", function (e) {
		wfOpenWin(e.row.ACTIONURL,e.row.L_PROCESS_INST_ID,e.row.WORKITEMID,e.row.L_BIZ_ID,e.row.VC_PROCESS_TYPE,e.row.L_STOCK_INVEST_NO,"100%","100%");
	});
	
	//渲染行对象
	grid.on("drawcell", function (e) {
		column = e.column,
		row=e.row;
		//action列，超连接操作按钮
		if (column.name == "action") {
			e.cellStyle = "text-align:left";//text-decoration:none;border-bottom:1px solid #FF0000
			if(isWork=="true"){
				e.cellHtml = "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='wfOpenWin(\""+row.ACTIONURL+"\",\""+row.L_PROCESS_INST_ID+"\",\""+row.WORKITEMID+"\",\""+row.L_BIZ_ID+"\",\""+row.VC_PROCESS_TYPE+"\",\""+row.L_STOCK_INVEST_NO+"\")'>详情</a>";
			}else{
				e.cellHtml = "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='wfOpenWin(\""+row.ACTIONURL+"\",\""+row.L_PROCESS_INST_ID+"\",\""+row.WORKITEMID+"\",\""+row.L_BIZ_ID+"\",\""+row.VC_PROCESS_TYPE+"\",\""+row.L_STOCK_INVEST_NO+"\")'>审批</a>";
			}
			
		}       
	});
		
	//查询
	function search() {
		var form1 = new nui.Form("#form1");
		var json = form1.getData(false,false);
		var editForm1 = new nui.Form("#editForm1");
		isWork = nui.get("checkBox").value;
        editForm1.reset();
		grid.load(json);//grid查询
	}
	    
	function wfOpenWin(url,processInstID,workItemID,bizId,processtype,stockInvestNo,width,height) {
		var winFrm=document.openForm;
		document.getElementById("processinstid").value=processInstID;
		document.getElementById("workItemID").value=workItemID;
		document.getElementById("bizId").value=bizId;
		if(isWork=="true"){
			document.getElementById("pageType").value="2";
		}else{
			document.getElementById("pageType").value="1";
		}
		document.getElementById("processType").value=processtype;
		document.getElementById("stockInvestNo").value=stockInvestNo;
		var actionURL=url; //目标页面
		winFrm.action=actionURL;
		var newwin = window.open('about:blank', 'newWindow' + bizId, '');
		winFrm.target = 'newWindow' + bizId;//这一句是关键
		winFrm.submit();
	}
	function rendererVcProcessType(e){
		return nui.getDictText("ATS_PROCESS_TYPE",e.row.VC_PROCESS_TYPE);
		}
	function reloadData(){
		grid.reload();
	}
	
	function reset(){
		formSear.reset();
	}

	
	function selectionChange(){
		var rows = grid.getSelecteds();
		if(rows.length>1){
			form.clear();
		}else if(rows.length==1){
		     var record = rows[0];
		     var id = record.L_PROCESS_INST_ID+"";
		     var stockInvestNo = record.L_STOCK_INVEST_NO+"";
			 var json =nui.encode({pid:id,stockInvestNo:stockInvestNo});
			 $.ajax({
	          url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.getDebtIssueByProcessInstId.biz.ext",
	          type: 'POST',
		      data: json,
		      cache: false,
		      contentType:'text/json',
	          success:function(text){
	            var returnJson = nui.decode(text);
			    if(returnJson.exception == null){
			      var data=returnJson.debtIssue;
			      if(data.lStockIssueId!="undefined" || data.lStockIssueId==""){
			      //发行日期 number转换成日期格式
			      var lIssueBeginDate = data.lIssueBeginDate;
			      if(lIssueBeginDate>0){
			      	var v_lIssueBeginDate = nui.parseDate(lIssueBeginDate+"");				//转换为Date类型
				  	data.lIssueBeginDate = nui.formatDate(v_lIssueBeginDate, "yyyy-MM-dd");  //date格式化  
			      }
			      //公告日期
			      var lIssuePostDate = data.lIssuePostDate;
			      if(lIssuePostDate>0){
			      	var v_lIssuePostDate = nui.parseDate(lIssuePostDate+"");				//转换为Date类型
				  	data.lIssuePostDate = nui.formatDate(v_lIssuePostDate, "yyyy-MM-dd");  //date格式化  
			      }
			      //缴款日期 
			      var lPayDate = data.lPayDate;
			      if(lPayDate>0){
			      	var v_lPayDate = nui.parseDate(lPayDate+"");				//转换为Date类型
				  	data.lPayDate = nui.formatDate(v_lPayDate, "yyyy-MM-dd");  //date格式化  
			      }
			      
			      //上市日期
			       var lPublishDate = data.lPublishDate;
			      if(lPublishDate>0){
			      	var v_lPublishDate = nui.parseDate(lPublishDate+"");				//转换为Date类型
				  	data.lPublishDate = nui.formatDate(v_lPublishDate, "yyyy-MM-dd");  //date格式化  
			      }
			      //起息日期
			      var lBegincalDate = data.lBegincalDate;
			      if(lBegincalDate>0){
			      	var v_lBegincalDate = nui.parseDate(lBegincalDate+"");				//转换为Date类型
				  	data.lBegincalDate = nui.formatDate(v_lBegincalDate, "yyyy-MM-dd");  //date格式化  
			      }
			      //到期日期
			       var lEndincalDate = data.lEndincalDate;
			      if(lEndincalDate>0){
			      	var v_lEndincalDate = nui.parseDate(lEndincalDate+"");				//转换为Date类型
				  	data.lEndincalDate = nui.formatDate(v_lEndincalDate, "yyyy-MM-dd");  //date格式化  
			      }
			      //下一行权日期
			       var lNextExerciseDate = data.lNextExerciseDate;
			      if(lNextExerciseDate>0){
			      	var v_lNextExerciseDate = nui.parseDate(lNextExerciseDate+"");				//转换为Date类型
				  	data.lNextExerciseDate = nui.formatDate(v_lNextExerciseDate, "yyyy-MM-dd");  //date格式化  
			      }
			      form.setData({debtIssue:data});
			      //处理付息频率，值满足数据字典则直接显示数据字典中对应值，否则直接显示值
				if(nui.get("enPayInteval").getText()=="" || nui.get("enPayInteval").getText()==null){
					nui.get("enPayInteval").setText(data.enPayInteval);
				}
			    }
			    }else{
			    	nui.alert("没有查到明细信息！");
			    }
	          }
	        }); 
		}
	}
	
	//展示详细行数据
	function onShowRowDetailList(e) {
		var grid = e.sender;//获取表格
	    var row = e.record;//获取行数据
	    var remark = changeNull(row.vcRemarks);//备注信息 
	    var ProcessInstId = row.lProcessInstId;
	    //判断待办中传过来的流程ID是否为空
	    if(ProcessInstId == undefined){
	    	ProcessInstId = row.L_PROCESS_INST_ID;
	    }

	    //获取债券信息
	    var processIdJson = nui.encode({processInstId : ProcessInstId});
	    $.ajax({
            url:"com.cjhxfund.foundation.task.pendingTreatment.queryTAtsApproveInfo.biz.ext",
            type:'POST',
            data:processIdJson,
            cache: false,
            contentType:'text/json',
            success:function(text){
                var returnJson = nui.decode(text);
                if(returnJson.exception == null){
                    var bonds = returnJson.TAsApproveInfos;
                    var html = "<table border='0'  style='width:100%;'>";
					 
					/*if(abandonedReasons!=null && abandonedReasons!=""){
						html +=" <tr>"
							 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>废弃原因：</td>"
							 + "  <td>" + abandonedReasons + "</td>"
							 + " </tr>";
					} */
					if(remark!=null && remark!=""){
						html +=" <tr>"
							 + "  <td style='width:150px;font-weight:bold;vertical-align:top;' align='right'>备注信息：</td>"
							 + "  <td>" + remark + "</td>"
							 + " </tr>";
					}
					if(returnJson.nextActor!=null && returnJson.nextActor!=""){
						html +=" <tr>"
							 + "  <td style='width:150px;font-weight:bold;vertical-align:top;' align='right'>当前节点参与者：</td>"
							 + "  <td>" + returnJson.nextActor + "</td>"
							 + " </tr>";
					}
					html += "</table>";
                    
					var bondStr = html + "</table>";
					    bondStr += "<table>"
                    			+" <tr>"
                    			+"  <td style='width:150px;font-weight:bold;' align='center'>审批时间</td>"
                    			+"  <td style='width:220px;font-weight:bold;' align='center'>节点名称</td>"
                    			+"  <td style='width:120px;font-weight:bold;' align='center'>操作者</td>"
                    			+"  <td style='width:120px;font-weight:bold;' align='center'>操作</td>"
                    			+"  <td style='width:200px;font-weight:bold;' align='center'>操作意见</td>"
                    			+" </tr>";
                    var vcOperateType = "同意";			
                    for(var i=0; i<bonds.length; i++){
                    	var bondInfo = bonds[i];
                    	  if(bondInfo.vcOperateType == 1){
                    		  vcOperateType = "同意";
					      }
					      if(bondInfo.vcOperateType == 2){
					    	  vcOperateType = "退办";
					      }
					      if(bondInfo.vcOperateType == 3){
					    	  vcOperateType = "转办";
					      }
					      if(bondInfo.vcOperateType == 4){
					    	  vcOperateType = "征求意见";
					      }
					      if(bondInfo.vcOperateType == 5){
					    	  vcOperateType = "否决";
					      }
					      if(bondInfo.vcOperateType == 99){
					    	  vcOperateType = "不同意";
					      }
					      
					      if(bondInfo.vcOperateType == 98){
					    	  vcOperateType = "修改";
					      }
					      if(bondInfo.vcOperateType == 97){
					    	  vcOperateType = "废弃";
					      }
					      
                    	bondStr += "<tr><td align='center'>"+ nui.formatDate(bondInfo.dCreateTime, "yyyy-MM-dd HH:mm:ss")+"</td><td align='center'>"+changeNull(bondInfo.vcWorkItemName)+"</td><td align='center'>"+changeNull(bondInfo.vcUserName)
                    			+	"</td><td align='center'>"+changeNull(vcOperateType)+"</td><td align='center'>"+changeNull(bondInfo.vcComments)+"</td></tr>";
                    }
                    bondStr += "</table>";
                    
                    var td = grid.getRowDetailCellEl(row);

					td.innerHTML = bondStr;
                    
                }else{
					nui.alert("加载失败", "系统提示");
                }
            }
         });
	}
   </script>
   
  </body>
</html>
