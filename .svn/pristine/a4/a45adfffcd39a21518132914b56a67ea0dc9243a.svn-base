<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.cjhxfund.ats.fm.commonUtil.JDBCUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
 <%
 	long key = JDBCUtil.getNextSequence("UNDERWRITERSTOCKNO");
  %>
    <head>
        <title>
           	承销商信息修改
        </title>
	    
    </head>
    <body style="width: 100%;height: 100%;overflow: hidden;">
    	<div id="tabs" class="nui-tabs" style="width: 100%;height: 95%;">
    	   <div title="承销商新债信息" >
              <div id="dataform1" style="padding-top:5px;">
              	<input class="nui-hidden" name="underwriterInfo.lUnderwriterStockId" id="lUnderwriterStockId" />
              	<input class="nui-hidden" name="underwriterInfo.cStatus" id="cStatus"/>
	            <input class="nui-hidden" name="underwriterInfo.lOperatorNo" id="lOperatorNo" value="<%=userObject.getUserId()%>"/>
	            <input class="nui-hidden" name="map.lOperatorNo" id="lOperatorNo1" value="<%=userObject.getUserId()%>"/>
	            <input class="nui-hidden" name="map.lUnderwriterStockId" id="lUnderwriterStockIdCheck" />
	            <input class="nui-hidden" name="map.vcIssuerNameFull" id="vcIssuerNameFullCheck"/>
	            <input class="nui-hidden" name="map.vcPaymentPlace" id="vcPaymentPlaceCheck"/>
	            <input class="nui-hidden" name="map.vcStockType" id="vcStockTypeCheck"/>
	            <input class="nui-hidden" name="map.vcExistLimite" id="vcExistLimiteCheck"/>
	            <input class="nui-hidden" name="map.type" id="mapType" value="1"/>
	            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
	                <tr>
	                    <td class="form_label" align="right" width="25%">
	                          	<span style="color:red">*</span>&nbsp;主承销商:
	                    </td>
	                    <td colspan="1">
	                    	 <input class="nui-textbox" id="vcMainUnderwriter" required="true" width="200" name="underwriterInfo.vcMainUnderwriter"/>
	                    	 <!-- <input style="width: 92%;" class="nui-textbox"  id="vcMainUnderwriter" name="debtIssue.vcMainUnderwriter"/> -->
						     <!-- <input style="width: 92%;" class="nui-hidden"  id="vcMainUnderwriterId" name="debtIssue.vcMainUnderwriterId"/> -->
						     <input id="lookup3" style="width: 25px;" class="mini-lookup" onvalidation="onIssuerId3"
						        textField="vcMainUnderwriter" valueField="vcMainUnderwriterId" popupWidth="auto"   
						        popup="#gridPanel3" data="data"  grid="#datagrid3" multiSelect="true" onclick="onClearClick3();onSearchClick3();" />
						     
						     <div id="gridPanel3" class="mini-panel" title="header" iconCls="icon-add" style="width:450px;height:250px;" 
						        showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0" borderStyle="border:0" >
						        <div property="toolbar" style="padding:5px;padding-left:8px;text-align:center;">   
						            <div style="float:left;padding-bottom:2px;">
						                <span> 主承销商：</span>                
						                <input id="keyText3" class="mini-textbox" value="" style="width:170px;" onenter="onSearchClick3"/>
						                <a class="mini-button" onclick="onSearchClick3">查询</a>
						                <!-- <a class="mini-button" id="add" iconCls='icon-add' onclick="onAddClick">添加</a> -->
						            </div>
						            <div style="float:right;padding-bottom:2px;margin-right:14px;">
						            </div>
						            <div style="clear:both;"></div>
						        </div>
						        <div id="datagrid3"   class="mini-datagrid" style="width:100%;height:100%;" 
						            borderStyle="border:0" showPageSize="false" showPageIndex="false"
						            url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.loadUnderwriter.biz.ext" onRowdblclick="dbClick3">
						            <div property="columns" >
						                <div type="checkcolumn"></div>
						                <div field="vcMainUnderwriterAbbr" width="50"    headerAlign="center" allowSort="true">简称</div>
						                <div field="vcMainUnderwriter" width="70" headerAlign="center" allowSort="true">全称</div>
						            </div>
						        </div>  
						      </div>
	                    </td>
	                    
	                    <td class="form_label" align="right" width="20%">
	                        	承销商联系方式:
	                    </td>
	                    <td colspan="1">
	                    		<input class="nui-textbox" id="vcUnderwriterContactInfo" width="200" name="underwriterInfo.vcUnderwriterContactInfo"/>
	                    </td>
	                </tr>
	                <tr>
	                  <td class="form_label" align="right">
	                       	发行时间:
	                  </td>
	                  <td colspan="1">
	                    		<input class="nui-textbox" id="vcApplicationTime" width="200" name="underwriterInfo.vcApplicationTime"/>
	                  </td>
	                  <td class="form_label" width="25%" align="right">
	                        	簿记时间:
	                  </td>
	                  <td colspan="1" width="25%">
	                    		<input class="nui-textbox" id="vcEntryTime" width="200" name="underwriterInfo.vcEntryTime"/>
	                  </td>
	                </tr>
	                <tr>
	                    
	                    <td class="form_label" align="right">
	                       	发行主体全称:
	                    </td>
	                    <td colspan="1">
	                    		<!-- <input class="nui-textbox" id="vcIssuerNameFull" width="200" name="underwriterInfo.vcIssuerNameFull" maxlength="20"/> -->
	                    		<!--控件内容  开始-->
						     <input id="lookup1" width="200"  name="vcIssuerNameFull" class="mini-lookup" 
						        textField="vcIssueNameFull" valueField="lIssuerId" popupWidth="auto" 
						        popup="#gridPanel1"   onvalidation="onIssuerId1" grid="#datagrid1" multiSelect="false"  onclick="onClearClick1();onSearchClick1()"/>
						     
						     <div id="gridPanel1" class="mini-panel" title="header" iconCls="icon-add" style="width:400px;height:250px;" 
						        showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0" borderStyle="border:0" >
						        <div property="toolbar" style="padding:5px;padding-left:8px;text-align:center;">   
						            <div style="float:left;padding-bottom:2px;">
						                <span>发行主体：</span>                
						                <input id="keyText1" class="mini-textbox" style="width:160px;" onenter="onSearchClick1"/>
						                <a class="mini-button" onclick="onSearchClick1">查询</a>
						                <a class="mini-button" id="add" iconCls='icon-add' onclick="onAddClick1">添加</a>
						                <a class="mini-button" id="cleanLookup3" onclick="cleanLookup1()">清空</a>
						            </div>
						            <div style="float:right;padding-bottom:2px;">
						            </div>
						            <div style="clear:both;"></div>
						        </div>
						        <div id="datagrid1"   class="mini-datagrid" style="width:100%;height:100%;" 
						            borderStyle="border:0" showPageSize="false" showPageIndex="false"
						            url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadIssueInfo.biz.ext" onRowdblclick="onCloseClickLookup">
						            <div property="columns" >
						                <div field="vcIssueName" width="80"    headerAlign="center" allowSort="true">简称</div>
		            					<div field="vcIssueNameFull" width="120"    headerAlign="center" allowSort="true">全称</div>
						            </div>
						        </div>  
						    </div>
	                    </td>
	                    <td class="form_label" align="right">
	                        	债券类别:
	                    </td>
	                    <td colspan="1">
	                    		<!-- <input class="nui-textbox" id="vcStockType" width="200" name="underwriterInfo.vcStockType"/> -->
	                    		<input width="200" id="vcStockType" name="underwriterInfo.vcStockType" class="mini-treeselect"  multiSelect="false" 
										        textField="text" valueField="id" parentField="pid" checkRecursive="false"  
										        expandOnLoad="true" showTreeIcon="false" showFolderCheckBox="true" onbeforenodeselect="beforenodeselect"
										        oncloseclick="onCloseClickValueEmpty" />
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                       	 发行方式:
	                    </td>
	                    <td colspan="1">
	                    		<!-- <input class="nui-textbox" id="vcIssueType" width="200" name="underwriterInfo.vcIssueType"/> -->
	                    		<input class="nui-dictcombobox"  allowInput="true" dictTypeId="issueType" name="underwriterInfo.vcIssueType" id="vcIssueType" width="200" />
	                    </td>
	                    <td class="form_label" align="right">
	                        	债券简称:
	                    </td>
	                    <td colspan="1">
	                    		<input class="nui-textbox" id="vcStockName" width="200" name="underwriterInfo.vcStockName"/>
	                    </td>
	                </tr>
	                <tr>
	                   <td class="form_label" align="right">
	                        	债券全称:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-textbox" id="vcStockNameFull" width="200" name="underwriterInfo.vcStockNameFull"/>
	                    </td>
	                    <td class="form_label requiredLable" align="right">
	                       	 发行规模（亿）:
	                    </td>
	                    <td colspan="1">
	                    		<input class="nui-textbox" id="vcIssueBalance" width="200" name="underwriterInfo.vcIssueBalance"/>
	                    </td>
	                </tr>
	                <tr id="tr1">
	                     <td class="form_label" align="right">
	                        	期限（年）:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="underwriterInfo.vcExistLimite" id="vcExistLimite" width="200" />
	                    </td>
	                     <td class="form_label" align="right">
	                        	询价区间:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="underwriterInfo.vcInquiryInterval"  id="vcInquiryInterval" width="200" />
	                    </td>
	                </tr>
	                <tr id="tr1">
	                   <td class="form_label" align="right">
	                        	期限备注:
	                    </td>
	                    <td colspan="3">
	                    	<input class="nui-textarea" id="vcExistLimiteDesc" name="underwriterInfo.vcExistLimiteDesc" width="95%"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                       	 主体评级:
	                    </td>
	                    <td colspan="1"> 
	                    		<input textField="dictName" valueField="dictID"  allowInput="true" class="nui-dictcombobox"  dictTypeId="issuerRating" width="200" id="vcIssueAppraise" name="underwriterInfo.vcIssueAppraise" />
	                    </td>
	                    
	                    <td class="form_label" align="right">
	                           	债券评级:
	                    </td>
	                    <td colspan="1">
	                    		<input class="nui-dictcombobox" dictTypeId="creditRating"  allowInput="true" id="vcBondAppraise" width="200" name="underwriterInfo.vcBondAppraise"/>
	                    </td>
	                </tr>
	                
	                 <tr>
	                    <td class="form_label" align="right">
	                       	 评级机构:
	                    </td>
	                    <td colspan="1"> 
	                    		<input class="nui-dictcombobox" dictTypeId="outRatingOrgan"  allowInput="true" width="200" id="vcAppraiseOrgan" name="underwriterInfo.vcAppraiseOrgan" />
	                    </td>
	                    <td class="form_label" align="right">
	                        登记托管机构:
	                    </td>
	                    <td colspan="1">
	                    		<input class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS"  allowInput="true" valueField="dictID" textField="dictName"  name="underwriterInfo.vcPaymentPlace" id="vcPaymentPlace" width="200" />
	                    </td>
	                </tr>
	                
	                <tr>
	                 	<td class="form_label" align="right">
	                       	 预计到期日:
	                    </td>
	                    <td colspan="1"> 
	                    		<input class="nui-textbox" id="vcDueDate" width="200" name="underwriterInfo.vcDueDate"/>
	                    </td>
	                     <td class="form_label" align="right">
	                           	还本付息方式:
	                    </td>
	                    <td colspan="1">
	                    		<input class="nui-textbox" id="vcPayInteval" width="200" name="underwriterInfo.vcPayInteval"/>
	                    </td>
	                 </tr>
	                 
	                 <tr>
	                 	<td class="form_label" align="right">
	                       	 起息日:
	                    </td>
	                    <td colspan="1">
	                    		<input class="nui-textbox" id="vcBegincalDate" width="200" name="underwriterInfo.vcBegincalDate"/>
	                    </td>
	                    <td class="form_label" align="right">
	                                                                                    增信情况:
	                    </td>
	                    <td colspan="1">
	                    		<input class="nui-textbox" id="vcCreditSituation" width="200" name="underwriterInfo.vcCreditSituation"/>
	                    </td>
	                </tr>
	                
	                <tr>
	                	<td class="form_label" align="right">
	                       	 企业性质:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-textbox" id="vcEnterpriseProperty" width="200" name="underwriterInfo.vcEnterpriseProperty"/>
	                    </td>
	                    <td class="form_label" align="right">
	                                                                                    是否城投:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" id="vcIsBid" width="200" name="underwriterInfo.vcIsBid"/>
	                    </td>
	                </tr>
	                
	                <tr>
	                    <td class="form_label" align="right">
	                       	 标的资产:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-textbox" id="vcMarkAssets" width="200" name="underwriterInfo.vcMarkAssets"/>
	                    </td>
	                      <td class="form_label" align="right">
	                                                                                   原始权益人:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" id="vcOldHolder" width="200" name="underwriterInfo.vcOldHolder"/>
	                    </td>
	                </tr>
	                 <tr>
	                     <td class="form_label" align="right">
	                       	 是否可质押:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-textbox" id="vcIsPledge" width="200" name="underwriterInfo.vcIsPledge"/>
	                    </td>
	                    <td class="form_label" align="right">
	                                                                                    是否有过融资历史:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox"  id="vcIsHaveFinancing" width="200" name="underwriterInfo.vcIsHaveFinancing"/>
	                    </td>
	                </tr>
	                
	                <tr>
	                     <td class="form_label" align="right">
	                       	  历史发债:
	                    </td>
	                    <td colspan="1"> 
	                         <input class="nui-textbox"  id="vcHisIssue" width="200" name="underwriterInfo.vcHisIssue"/>
	                    </td>
	                    <td class="form_label" align="right">
	                                                                                    材料网络版更新时间:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox"  id="vcAttachName1" width="200" name="attachInfo1.vcAttachName"/>
	                        <input class="nui-hidden"  id="vcAttachBizType1" width="200" name="attachInfo1.vcAttachBizType" value ="9"/>
	                        <input class="nui-hidden"  id="lAttachId1" width="200" name="attachInfo1.lAttachId"/>
	                        <input class="nui-hidden"  id="lBizId1" width="200" name="attachInfo1.lBizId"/>
	                    </td>
	                </tr>
	                <tr>
	                     <td class="form_label" align="right">
	                       	 调研纪要/路演纪要(若有)下载链接:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-textbox" id="vcAttachAdd2" width="200" name="attachInfo2.vcAttachAdd"/>
	                    </td>
	                    <td class="form_label" align="right">
	                                                                                    路演时间:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox"  id="vcAttachName2" width="200" name="attachInfo2.vcAttachName"/>
	                        <input class="nui-hidden"  id="vcAttachBizType2" width="200" name="attachInfo2.vcAttachBizType" value ="10"/>
	                        <input class="nui-hidden"  id="lAttachId2" width="200" name="attachInfo2.lAttachId"/>
	                        <input class="nui-hidden"  id="lBizId2" width="200" name="attachInfo2.lBizId"/>
	                    </td>
	                </tr>
	                
	                <tr id="tr1">
	                   <td class="form_label" align="right">
	                        	资质简介:
	                    </td>
	                    <td colspan="3">
	                    	<input class="nui-textarea" id="vcPropertyDesc" name="underwriterInfo.vcPropertyDesc" width="95%"/>
	                    </td>
	                </tr>
	                <tr>
	                   <td class="form_label" align="right">
	                        	网络材料附件上传:
	                    </td>
	                    <td colspan="3">
	                    	<iframe id="prodIfm1" width="590"  height="110px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" 
							 	src="<%=request.getContextPath() %>/fm/baseinfo/fileupload/any_uploadUnderwriter.jsp?attachType=9&attachBusType=9&id=<%=key %>" >
							 </iframe>
	                    </td>
	                </tr>
	            </table>
	        </div>
	     </div>
	    </div>   
	     
        <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
	         <table width="100%">
	             <tr>
	               <td style="text-align:center;" colspan="4">
	                  <a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">
	                                	保存
	                  </a>
	                  <span style="display:inline-block;width:25px;"></span>
	                  <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
	                               	 取消
	                  </a>
	                </td>
	              </tr>
	          </table>
	      </div>

    <script type="text/javascript">
        nui.parse();
        var context = "<%=request.getContextPath() %>";
        var lOperatorNo=nui.get("lOperatorNo").getValue();
        var form = new nui.Form("#dataform1");
            form.setChanged(false);
		    function onOk(){
		        var vcMainUnderwriter=nui.get("vcMainUnderwriter").getValue();
				nui.get("lUnderwriterStockIdCheck").setValue(nui.get("lUnderwriterStockId").getValue());
	            nui.get("vcStockTypeCheck").setValue(nui.get("vcStockType").text.replace(/(^\s*)|(\s*$)/g, ""));
             	nui.get("vcIssuerNameFullCheck").setValue(nui.get("lookup1").text.replace(/(^\s*)|(\s*$)/g, ""));
             	nui.get("vcPaymentPlaceCheck").setValue(nui.get("vcPaymentPlace").text.replace(/(^\s*)|(\s*$)/g, ""));
             	nui.get("vcExistLimiteCheck").setValue(nui.get("vcExistLimite").getValue());
	   		 	form.validate();
	   		 	nui.get("vcMainUnderwriter").setValue(vcMainUnderwriter);
				if (form.isValid() == false) {
					nui.alert("请检查必填项!");
					return;
				}
				var data = form.getData(false,true);
				data.underwriterInfo.vcStockType=nui.get("vcStockType").text.replace(/(^\s*)|(\s*$)/g, "");
				data.underwriterInfo.vcIssueType=nui.get("vcIssueType").text.replace(/(^\s*)|(\s*$)/g, "");
				data.underwriterInfo.vcIssueAppraise=nui.get("vcIssueAppraise").text.replace(/(^\s*)|(\s*$)/g, "");
				data.underwriterInfo.vcBondAppraise=nui.get("vcBondAppraise").text.replace(/(^\s*)|(\s*$)/g, "");
				data.underwriterInfo.vcAppraiseOrgan=nui.get("vcAppraiseOrgan").text.replace(/(^\s*)|(\s*$)/g, "");
				data.underwriterInfo.vcPaymentPlace=nui.get("vcPaymentPlace").text.replace(/(^\s*)|(\s*$)/g, "");
				data.underwriterInfo.vcIssuerNameFull=nui.get("lookup1").text.replace(/(^\s*)|(\s*$)/g, "");
				var vcAttachName1=nui.get("vcAttachName1").getValue();
				var vcAttachAdd2=nui.get("vcAttachAdd2").getValue();
				var vcAttachName2=nui.get("vcAttachName2").getValue();
				if(vcAttachName1==""){
					data.attachInfo1=null;
				}
				if(vcAttachAdd2=="" || vcAttachName2==""){
					data.attachInfo2=null;
				}
	            var url = "com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.editUnderwriterInfo.biz.ext";
	            if(nui.get("lUnderwriterStockId").getValue()==null||nui.get("lUnderwriterStockId").getValue()==""){
	            	if(!form.isChanged()){
						nui.alert("请填写相关数据后保存!");
						return;
					}
	            	url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.addUnderwriterInfo.biz.ext";
	            	data.underwriterInfo.lUnderwriterStockId=<%=key %>;
	            }
	            var json = nui.encode(data);
	            form.loading();
	            if(nui.get("vcStockTypeCheck").getValue()!=""&&nui.get("vcIssuerNameFullCheck").getValue()!=""&&nui.get("vcPaymentPlaceCheck").getValue()!="" && nui.get("vcExistLimiteCheck").getValue()!=""){
	            	nui.ajax({
					    url: "com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager.checkMergeUnderwriter.biz.ext",
					    type: "post",
					    data: json,
					    dataType:"json",
					    success: function (text) {
						       form.unmask();//取消遮罩
						       var underwriterInfo =text.underwriterInfo;
						       if(underwriterInfo.length>0){
						            //当前登录人为承销商
						            if(text.isInvestment == "1"){
							            //新增数据存在，如果是当前承销商的，则提示已存在，是别的承销商的，则修改
							            var vcUnderwriterName=underwriterInfo[0].vcUnderwriterName.toString();
							            if(vcUnderwriterName.indexOf(lOperatorNo)!=-1){
							                nui.alert("当前承销商已经存在.");
										    return false;
							            }else{
							                   var lUnderwriterStockId1=nui.get("lUnderwriterStockId").getValue();
							                 //新增时，有重复的则修改原有数据，修改时，如有重复的，则合并，并且合并主承销商的历史记录
							                 if(lUnderwriterStockId1==null||lUnderwriterStockId1==""){
							                     //新增相同记录
							                     url = "com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.editUnderwriterInfo.biz.ext";
								                 data.underwriterInfo.lUnderwriterStockId=underwriterInfo[0].lUnderwriterStockId;
								                 data.underwriterInfo.vcMainUnderwriter=underwriterInfo[0].vcMainUnderwriter+","+vcMainUnderwriter;
								                 data.underwriterInfo.vcUnderwriterName=vcUnderwriterName+","+lOperatorNo;
								                 var json1 = nui.encode(data);
								                 addData(url,json1);
							                 }else{
							                     //修改相同记录，合并数据
								                 data.underwriterInfo.vcMainUnderwriter=underwriterInfo[0].vcMainUnderwriter+","+vcMainUnderwriter;
								                 data.underwriterInfo.vcUnderwriterName=vcUnderwriterName+","+lOperatorNo;
								                 var json1 = nui.encode(data);
								                 
								                 var json2=nui.encode({underwriterInfoId:underwriterInfo[0].lUnderwriterStockId,lUnderwriterStockId:lUnderwriterStockId1});
								                 $.ajax({
														url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.mergeUnderwriter.biz.ext",
											            type:'POST',
											            data:json2,
											            cache:false,
											            contentType:'text/json',
											            success:function(text){
											            	form.unmask();
															var returnJson = nui.decode(text);
															if(returnJson.exception == null){
										        				addData(url,json1);
										                    	}
										        			}
													});
							                 }
							            }
						            }else{
						                nui.alert("当前承销商已经存在.");
										return false;
						            }
						       }else{
						       		addData(url,json);
						       }
					      	}
					});
	            }else{
	            	addData(url,json);
	            }
				
		   }
		   function addData(url,json){
		   	$.ajax({
					url:url,
		            type:'POST',
		            data:json,
		            cache:false,
		            contentType:'text/json',
		            success:function(text){
		            	form.unmask();
						var returnJson = nui.decode(text);
						if(returnJson.exception == null){
	        				nui.alert("保存成功", "系统提示", function(action){
                        		if(action == "ok" || action == "close"){
                            		CloseWindow("saveSuccess");
                        		}
                    		});
	                    	}
	        			}
				});
		   }
		   
		    //关闭窗口
		   function CloseWindow(action){
		      if(action=="close" && form.isChanged()){
		         nui.confirm("数据已改变,确定退出", "系统提示", function(action){
		         	if(action=='ok'){
		         		 CloseWindow("cancel");
		         	}
		         });
		      }else if(window.CloseOwnerWindow) 
		        return window.CloseOwnerWindow(action);
		      else
		        return window.close();
		    } 
		     
		  
		   
	   function SetData(data) {
	         //debugger;
        	 form.setData({underwriterInfo:data}); //表单数据初始化
        	 nui.get("vcStockType").setText(data.vcStockType);
			 nui.get("vcIssueType").setText(data.vcIssueType);
			 nui.get("vcIssueAppraise").setText(data.vcIssueAppraise);
			 nui.get("vcBondAppraise").setText(data.vcBondAppraise);
			 nui.get("vcAppraiseOrgan").setText(data.vcAppraiseOrgan);
			 nui.get("vcPaymentPlace").setText(data.vcPaymentPlace);
			 nui.get("lookup1").setText(data.vcIssuerNameFull);
        	 var userId=<%=userObject.getUserId()%>;
        	 nui.get("lOperatorNo").setValue(userId);
        	 nui.get("lOperatorNo1").setValue(userId);
        	 nui.get("mapType").setValue(1);
        	 var vcAttachBizType = "9,10";
        	 nui.get("vcAttachBizType1").setValue("9");
		      nui.get("vcAttachBizType2").setValue("10");
		      nui.get("lBizId1").setValue(data.lUnderwriterStockId);
		      nui.get("lBizId2").setValue(data.lUnderwriterStockId);
		      document.getElementById("prodIfm1").src= "<%=request.getContextPath() %>/fm/baseinfo/fileupload/any_uploadUnderwriter.jsp?attachType=9&attachBusType=9&id="+data.lUnderwriterStockId;
			var json =nui.encode({lBizId:data.lUnderwriterStockId,vcAttachBizType:vcAttachBizType});
			$.ajax({
	          url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryUnderwriterAttach.biz.ext",
	          type: 'POST',
		      data: json,
		      cache: false,
		      contentType:'text/json',
	          success:function(text){
	            var returnJson = nui.decode(text);
			    if(returnJson.exception == null){
			      var data=returnJson.underwriterAttach;
			      
			      if(data.length==1){
			      	if(data[0].vcAttachBizType=="9"){
			      		nui.get("vcAttachName1").setValue(data[0].vcAttachName);
			      		nui.get("lAttachId1").setValue(data[0].lAttachId);
			      		nui.get("lBizId1").setValue(data[0].lBizId);
			      		
			      	}else{
			      		nui.get("vcAttachName2").setValue(data[0].vcAttachName);
			      		nui.get("vcAttachAdd2").setValue(data[0].vcAttachAdd);
			      		nui.get("lAttachId2").setValue(data[0].lAttachId);
			      		nui.get("lBizId2").setValue(data[0].lBizId);
			      	}
			      }else if(data.length>1){
			      	if(data[0].vcAttachBizType=="9"){
			      		nui.get("vcAttachName1").setValue(data[0].vcAttachName);
			      		nui.get("lAttachId1").setValue(data[0].lAttachId);
			      		nui.get("lBizId1").setValue(data[0].lBizId);
			      		nui.get("vcAttachName2").setValue(data[1].vcAttachName);
			      		nui.get("vcAttachAdd2").setValue(data[1].vcAttachAdd);
			      		nui.get("lAttachId2").setValue(data[1].lAttachId);
			      		nui.get("lBizId2").setValue(data[1].lBizId);
			      	}else{
			      		nui.get("vcAttachName1").setValue(data[1].vcAttachName);
			      		nui.get("lAttachId1").setValue(data[1].lAttachId);
			      		nui.get("lBizId1").setValue(data[1].lBizId);
			      		nui.get("vcAttachName2").setValue(data[0].vcAttachName);
			      		nui.get("vcAttachAdd2").setValue(data[0].vcAttachAdd);
			      		nui.get("lAttachId2").setValue(data[0].lAttachId);
			      		nui.get("lBizId2").setValue(data[0].lBizId);
			      	}
			      }else{
			      	nui.get("vcAttachName1").setValue("");
		      		nui.get("vcAttachName2").setValue("");
		      		nui.get("vcAttachAdd2").setValue("");
			      }
			    }
	          }
	        });
	        loadStockTypeAll();
        }
        	
        var grid3 = nui.get("datagrid3");
        var keyText3 = nui.get("keyText3");
        
        function onCloseClick3(e) {
	            var lookup3 = nui.get("lookup3");
	            lookup3.hidePopup();
	        }
	        function onClearClick3(e) {
	            nui.get("keyText3").setValue("");
	        }
	        
	        //主承销商选择 ，双击行，事件响应
	        function dbClick3(e){
	        	 var lookup3 = nui.get("lookup3");
	            lookup3.hidePopup();
	        }
	        function onSearchClick3(e) {
	            grid3.load({
	                key: keyText3.value
	            });
	        }
	        function onIssuerId3(e){
        		nui.get("vcMainUnderwriter").setValue(e.source.text);
        	}
        function onCancel(){
			//查询是否有附件，有，则删除
			CloseWindow("close");
			
		}
        	//loadStockTypeAll();
        	 //加载所有的债券信息
             function loadStockTypeAll(){
                var vcStockType=nui.get("vcStockType").getValue();
             	nui.ajax({
				    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext",
				    type: "post",
				    dataType:"json",
				    success: function (text) {
				    	nui.get("vcStockType").loadList(text.data);
				    	nui.get("vcStockType").setText(vcStockType);
				    }
				});
				var userId=<%=userObject.getUserId()%>;
				var json =nui.encode({userName:userId});
				nui.ajax({
				    url: "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadUnderwriterName.biz.ext",
				    type: "post",
				    data: json,
				    dataType:"json",
				    success: function (text) {
				        var isInvestment=text.isInvestment;
				        var lUnderwriterStockId=nui.get("lUnderwriterStockId").getValue();
				        if(lUnderwriterStockId==null || lUnderwriterStockId==""){
				           //新增
				           nui.get("vcMainUnderwriter").setValue(text.underwriterName);
				        }
				        //1为主承销商
				        if(isInvestment==1){
				           readonlyInput("vcMainUnderwriter","vcMainUnderwriter");
				           document.getElementById( "lookup3").style.display= "none";
				        }
				    }
				});
             }
             function beforenodeselect(e) {
               //禁止选中父节点
               if (e.isLeaf == false) e.cancel = true;
        	}
        	//readonlyInput("vcMainUnderwriter","vcMainUnderwriter");
        	function readonlyInput(inputNuiId,inputJQId){
				nui.get(inputNuiId).readOnly="readonly";//nui禁用
				$("#"+inputJQId+" input").attr("readonly","readonly");//解决nui禁用IE兼容
				$("#"+inputJQId+" input").css("background-color","#f0f0f0");//置灰
		    }
		    
		    //子页面删除文件之后，也删除父界面上的隐藏表单的值
		   function deleteFileByUpload(attachBusType){
		   	  
		   }
		   var grid1 = mini.get("datagrid1");
		   var keyText1 = mini.get("keyText1");
		   grid1.load();
		   function cleanLookup1() {
            nui.get("keyText1").setValue("");
            nui.get("lookup1").setValue("");
           	nui.get("lookup1").setText("");
           }
           function onCloseClickLookup(e) {
            var lookup1 = mini.get("lookup1");
            lookup1.hidePopup();
           }
           function onSearchClick1(e) {
            grid1.load({
                key: keyText1.value
            });
           }
           function onClearClick1(e) {
             //修改为情况查询条件
            nui.get("keyText1").setValue("");
           }
           var IssueronCkData=new Array();//发行人选中的历史数据
           //控制 发行人限制输入
			function onIssuerId1(e){
				var dataIssuer=grid1.data;
	        	//设置发行人信息,累加查询结果，防止用户查询新数据后不选择
	        	if(IssueronCkData!=null){
	        		dataIssuer=dataIssuer.concat(IssueronCkData);
	        	}
	        	//获取发行人的其他数据
	        	for(var i=0;i<dataIssuer.length;i++){
	        		
	        		//查找选中的数据
	        		if(dataIssuer[i].lIssuerId==e.value){
	        			
	        			if(IssueronCkData!=null){
	        				IssueronCkData=IssueronCkData.concat(dataIssuer[i]);
	        			}else{
	        				IssueronCkData[0]=dataIssuer[i];
	        			}
	        			//回填发行人信息
	        			nui.get("vcIssueAppraise").setValue(dataIssuer[i].cIssueAppraise);
	        			nui.get("vcAppraiseOrgan").setValue(dataIssuer[i].vcIssueAppraiseOrgan);
	        			//nui.get("vcEnterpriseProperty").setValue(dataIssuer[i].vcIssueProperty);
	        			nui.get("vcEnterpriseProperty").setValue(nui.getDictText("ATS_FM_ISSUE_PROPERTY",dataIssuer[i].vcIssueProperty));
	        			nui.get("vcIsBid").setValue(nui.getDictText("cityLevel",dataIssuer[i].vcCityLevel));
	        		}
	        	}
	          
			}
			function onAddClick1(){
			  	var url = "<%= request.getContextPath() %>/fm/baseinfo/issuerInfo/addIssuerInfo.jsp";
					var title = "新增发行主体";
					var width = "400";
					var height = "390";
					nui.open({
						url: url,
						title: title, width: width, height: height,
						onload: function () {//弹出页面加载完成
							
						},
						ondestroy: function (action) {//弹出页面关闭前,把新增的主体简称返回赋值给查询框
							keyText1.setValue(action);
							onSearchClick1();
						}
					});
			  }
 		</script>
      </body>
   </html>
