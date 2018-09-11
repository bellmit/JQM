<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/CFJYProductProcessForm_show_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2015-10-09 11:42:39
- Description: 指令/建议录入指令/建议单_债券买卖业务
--%>
<head>
<title>指令/建议录入指令/建议单_债券买卖业务</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <input class="nui-hidden" name="zhfwptjyzqmm.processType4InvestProductNum" value="01,02"/>
            <input class="nui-hidden" name="zhfwptjyzqmm.processId"/>
            <input class="nui-hidden" name="zhfwptjyzqmm.processStatus" id="processStatus"/>
            <input class="nui-hidden" name="zhfwptjyzqmm.roleType" id="roleType"/>
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
            	<%-- <tr style="border-top:none;">
            		<td colspan="4" width="100%" align="center" class="radio-border-top-none">
            			<input readonly="readonly" id="isInquiry" class="nui-radiobuttonlist" name="zhfwptjyzqmm.isInquiry" value="0" repeatItems="1" repeatLayout="none" repeatDirection="horizontal" textField="text" valueField="id" url="<%=request.getContextPath()%>/ProductProcess/IsInquiryData.txt" onvaluechanged="isInquiryOnvaluechanged(e)" />
            		</td>
            	</tr> --%>
                <tr>
                    <td class="form_label" width="21%">
                        业务日期:
                    </td>
                    <td colspan="1" width="29%">
                    	<input name="zhfwptjyzqmm.isInquiry" id="isInquiry" class="nui-hidden" value="0">
                        <input id="processDate" readonly="readonly" class="nui-datepicker" style="width:150px;" name="zhfwptjyzqmm.processDate" required="true" value=""/>
                    </td>
                    <td class="form_label" width="21%">
                         截止日期:
                    </td>
                    <td colspan="1" width="29%">
                        <input id="expiredate" readonly="readonly" class="nui-datepicker" style="width:150px;" name="zhfwptjyzqmm.expiredate" required="true" value=""/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label" width="23%">
                        产品名称:
                    </td>
                    <td colspan="1" width="27%">
                        <input readonly="readonly" id="combProductCode" required="true" class="nui-autocomplete" style="width:150px;" name="zhfwptjyzqmm.combProductCode" searchField="searchKey" dataField="combProducts"
                        	valueField="fundCode" textField="fundName" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductsByKeyAndUserId.biz.ext" value="" text="" enterQuery="false" onvaluechanged="changedCombProductCode"/>
                        <input id="combProductName" class="nui-hidden" name="zhfwptjyzqmm.combProductName"/>
                    </td>
                	<td class="form_label" width="23%">
                        组合名称:
                    </td>
                    <td colspan="1" width="27%">
                    	<!-- <input readonly="readonly" class="nui-combobox" id="vcCombiNo"  required="true" dataField="productCombis"  name="zhfwptjyzqmm.vcCombiNo" 
	                        valueField="vcCombiNo" textField="vcCombiName" onvaluechanged="setVcCombiName" searchField="searchKey"  enterQuery="false"/> -->
	                      <input class="nui-hidden" id="vcCombiNo" name="zhfwptjyzqmm.vcCombiNo"/>  
	                      <input readonly="readonly" class="nui-textbox" style="width:150px;" id="vcCombiName" required="true" name="zhfwptjyzqmm.vcCombiName"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label">
                        债券代码:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="investProductCode" required="true" class="nui-autocomplete" style="width:150px;" popupWidth="300" popupHeight="200" name="zhfwptjyzqmm.investProductCode" searchField="searchKey" dataField="investProducts"
                        	valueField="investProductInfo" textField="investProduct" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByKey.biz.ext" value="" text="" enterQuery="false" onitemclick="investProductCodeOnItemClick"/>
                    </td>
                    <td class="form_label">
                        债券名称:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="investProductName" class="nui-textbox" style="width:150px;" name="zhfwptjyzqmm.investProductName" required="true"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label">
                        业务类别:
                    </td>
                    <td colspan="1">
                        <input id="processType" readonly="readonly" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQMM" name="zhfwptjyzqmm.processType" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" onvaluechanged="processTypeValueChangedFun"/>
                    </td>
                    <td class="form_label">
                        债券类别:
                    </td>
                    <td colspan="1">
                        <input id="investCategory" readonly="readonly" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY" name="zhfwptjyzqmm.investCategory" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="false"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        债券评级:
                    </td>
                    <td colspan="1">
                        <input id="bondRating" readonly="readonly" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" name="zhfwptjyzqmm.bondRating" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="false"/>
                    </td>
                	<td class="form_label">
                        主体评级:
                    </td>
                    <td colspan="1">
                        <input id="subjectRating" readonly="readonly" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" name="zhfwptjyzqmm.subjectRating" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="false"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label">
                        清算速度:
                    </td>
                    <td colspan="1">
                        <input id="clearingSpeed" readonly="readonly" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_CLEARING_SPEED" name="zhfwptjyzqmm.clearingSpeed" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" onvaluechanged="setBondPriceUtil"/>
                    </td>
                    <td class="form_label">
                        清算类型:
                    </td>
                    <td colspan="1">
                        <input id="cleartype" readonly="readonly" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_CLEAR_TYPE" name="zhfwptjyzqmm.cleartype" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" />
                    </td>
                </tr>
                <tr>
                	<td class="form_label">
                        交易场所:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly"  id="tradingPlace" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_TRADING_PLACE" name="zhfwptjyzqmm.tradingPlace" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true"/>
                    </td>
                    <td class="form_label">
                        券面金额（万元）:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="investCount" class="nui-textbox" style="width:150px;" name="zhfwptjyzqmm.investCount" required="true" onblur="investCountFun()"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        交易对手:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="tradingOpponent" class="nui-textbox" style="width:150px;" name="zhfwptjyzqmm.tradingOpponent" required="true"/>
                    </td>
                    <td colspan="2">
                		<table>
                			<tr style="border-top:none;">
			                    <td class="form_label" style="padding:0;">
						                        净价（元/百元面值）:
			                    </td>
			                    <td colspan="1" style="padding:0 0 0 66px;">
			                        <input readonly="readonly" id="netPrice" class="nui-textbox" style="width:90px;" name="zhfwptjyzqmm.netPrice" required="false" onblur="netPriceFun()" width="80px"/>
			                    </td>
			                    <td style="padding:0;">
			                    	<input readonly="readonly" id="autoCalc" name="autoCalc" class="nui-checkbox" checked="true" text="联动"/>
			                    </td>
                			</tr>
                		</table>
                	</td>
                </tr>
                <tr>
                	<td class="form_label">
			                        全价（元/百元面值）:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="fullPrice" class="nui-textbox" name="zhfwptjyzqmm.fullPrice" style="width:150px;" required="false" onblur="fullPriceFun()"/>
                    </td>
                    <td class="form_label">
                        收益率类型:
                    </td>
                    <td colspan="1">
                    	<input readonly="readonly" id="interestRateType" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_INTEREST_RATE_TYPE" name="zhfwptjyzqmm.interestRateType" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="false" onvaluechanged="interestRateTypeValueChangedFun"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        收益率（%）:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="interestRate" class="nui-textbox" style="width:150px;" name="zhfwptjyzqmm.interestRate" required="false" onblur="interestRateFun()"/>
                    </td>
                    <td class="form_label">
                        交易员代码:
                    </td>
                    <td colspan="1" id="traderCodeTd">
                    	<input readonly="readonly" id="traderCode" class="nui-textbox" style="width:150px;" name="zhfwptjyzqmm.traderCode" required="false"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        席位号:
                    </td>
                    <td colspan="1">
                    	<input readonly="readonly" id="seatNum" class="nui-textbox" style="width:150px;" name="zhfwptjyzqmm.seatNum" required="false"/>
                    </td>
                    <td class="form_label">
                        约定号:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="agreementNum" class="nui-textbox" style="width:150px;" name="zhfwptjyzqmm.agreementNum" required="false"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        备注:
                    </td>
                    <td colspan="3">
                        <input readonly="readonly" class="nui-textarea"name="zhfwptjyzqmm.remark" width="100%"/>
                    </td>
                </tr>
            </table>
            <div class="nui-toolbar" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a id="confirm" class='nui-button' plain='false' iconCls="icon-ok" onclick="onOk_ZQMM()">
                                确认
                            </a>
                            <span style="display:inline-block;width:25px;"></span>
                            <a id="goBack" class='nui-button' plain='false' iconCls="icon-no" onclick="onGoBack_ZQMM()">
                                退回
                            </a>
                            <span style="display:inline-block;width:25px;"></span>
                            <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
                                取消
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();
            //nui.get("confirm").disable();//将“确认”按钮设置为不可用
            nui.get("goBack").disable();//将“退回”按钮设置为不可用
            var rowPageType = "";//页面类型
            var rowRecord;//保存行记录数据，确认时使用
            var tradingConfirmAuthorityUserIds = "";//交易确认阶段权限人员名单字符串，确认时使用
            var backstageConfirmAuthorityUserIds = "";//后台已成交阶段权限人员名单字符串，确认时使用
			
			//页面间传输json数据
			function setFormData(data){
			    //跨页面传递的数据对象，克隆后才可以安全使用
			    var infos = nui.clone(data);
			
			    //保存list页面传递过来的页面类型：add表示新增、edit表示编辑、query表示查询
			    nui.getbyName("pageType").setValue(infos.pageType);
			    
			    rowPageType = infos.pageType;//页面类型
			    rowRecord = infos.record.zhfwptjyzqmm;
			    var json = infos.record;
		        var form = new nui.Form("#dataform1");//将普通form转为nui的form
		        
		        //设置产品名称值
		        var combProductNameVal = json.zhfwptjyzqmm.combProductName;
		        nui.get("combProductCode").setText(combProductNameVal);
				nui.get("combProductName").setValue(combProductNameVal);
				
				
				//设置债券代码显示值
				var investProductCodeVal = json.zhfwptjyzqmm.investProductCode;
		        nui.get("investProductCode").setText(investProductCodeVal);
		        
		        //设置表单数据公共逻辑处理
				setFormDataCommon(form, json, infos);
				
				nui.get("autoCalc").setChecked(true);//设置“联动”为勾选				
				isInquiryOnvaluechanged(nui.get("isInquiry"));//初始化设置必输项，是否询价指令/建议：0-否（完整指令/建议）;1-是（询价指令/建议）;
			}
			
			//是否询价指令/建议：0-否（完整指令/建议）;1-是（询价指令/建议）;
            function isInquiryOnvaluechanged(e){
            	var val = e.value;
            	if(val=="0"){
            		nui.get("investProductCode").setRequired(true);//债券代码
            		nui.get("investProductName").setRequired(true);//债券名称            		
            		nui.get("clearingSpeed").setRequired(true);//清算速度
            		nui.get("tradingPlace").setRequired(true);//交易场所
            		nui.get("investCount").setRequired(true);//券面金额（万元）
            		nui.get("tradingOpponent").setRequired(true);//交易对手
            		nui.get("cleartype").setRequired(true);//清算类型
            	}else{
            		nui.get("investProductCode").setRequired(false);//债券代码
            		nui.get("investProductName").setRequired(false);//债券名称            		
            		nui.get("clearingSpeed").setRequired(false);//清算速度
            		nui.get("tradingPlace").setRequired(false);//交易场所
            		nui.get("investCount").setRequired(false);//券面金额（万元）
            		nui.get("tradingOpponent").setRequired(false);//交易对手
            		nui.get("cleartype").setRequired(false);//清算类型
            	}
            }
			
			//执行确认
			function onOk_ZQMM() {
				
				//如果是点击确认类型页面（投资经理下单、交易员填单）
			    if (rowPageType == "confirm") {
			    	//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
		        	var validStatus = rowRecord.validStatus;
		        	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
		        		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
		        		return;
		        	}
		        	if(validStatus=="3"){
		        		nui.alert("该指令/建议已退回，您不能再确认","提示");
		        		return;
		        	}
		        	
		        	var jsonStatus = nui.encode({zhfwptjyzqmm:{processId:rowRecord.processId}});
		        	$.ajax({
		                url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.getProcessStatus_ZQMM.biz.ext",
		                type:'POST',
		                data:jsonStatus,
		                cache:false,
		                contentType:'text/json',
		                success:function(text){
		                    var returnJsonStatus = nui.decode(text);
		                    
		                    //“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
				        	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
				        	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
				        	var processStatus = returnJsonStatus.processStatus;
				        	
				        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
				        		nui.alert("该指令/建议尚未确认，您还不能处理","提示");
		        				return;
				        	
				        	//投资经理下单操作权限认证
				        	}else if(processStatus=="1"){
				        		//若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
				        		var hasPermission = false;//是否有权限，默认无
								var userIdRelaType02 = rowRecord.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
								if(userIdRelaType02!=null && userIdRelaType02!=""){
									var userIdRelaType02Arr = userIdRelaType02.split(",");
									for(var i=0; i<userIdRelaType02Arr.length; i++){
										var userIdTemp = userIdRelaType02Arr[i];
										if(userIdTemp==userId){
											hasPermission = true;
											break;
										}
									}
								}
								if(hasPermission==false){
									nui.alert("您没有权限确认该指令/建议","提示");
		    						return;
								}
								
							//交易确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
				        	}else if(processStatus=="2" || processStatus=="3" || processStatus=="4"){
				        		var hasPermission = false;//是否有权限，默认无
								if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
									var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
									for(var i=0; i<tradingConfirmAuthorityUserIdsArr.length; i++){
										var userIdTemp = tradingConfirmAuthorityUserIdsArr[i];
										if(userIdTemp==userId){
											hasPermission = true;
											break;
										}
									}
								}
								if(hasPermission==false){
									nui.alert("您没有权限确认该指令/建议","提示");
		    						return;
								}
				        	
				        	//后台已成交确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
				        	}else if(processStatus=="5"){
				        		var hasPermission = false;//是否有权限，默认无
								if(backstageConfirmAuthorityUserIds!=null && backstageConfirmAuthorityUserIds!=""){
									var backstageConfirmAuthorityUserIdsArr = backstageConfirmAuthorityUserIds.split(",");
									for(var i=0; i<backstageConfirmAuthorityUserIdsArr.length; i++){
										var userIdTemp = backstageConfirmAuthorityUserIdsArr[i];
										if(userIdTemp==userId){
											hasPermission = true;
											break;
										}
									}
								}
								if(hasPermission==false){
									nui.alert("您没有权限确认该指令/建议","提示");
		    						return;
								}
				        	}		        	
				        	
				        	var msg = "";
				        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
				        		nui.alert("该指令/建议尚未确认，您还不能处理","提示");
		        				return;
				        	}else if(processStatus=="1"){
				        		msg = "该指令/建议现为确认完成阶段，确定要继续确认吗？";
				        	}else if(processStatus=="2"){
				        		msg = "该指令/建议现为投资经理下单完成阶段，确定要继续确认吗？";
				        	}else if(processStatus=="3"){
				        		msg = "该指令/建议现为交易员填单完成阶段，确定要继续确认吗？";
				        	}else if(processStatus=="4"){
				        		msg = "该指令/建议现为交易已发送阶段，确定要继续确认吗？";
				        	}else if(processStatus=="5"){
				        		msg = "该指令/建议现为前台已成交阶段，确定要继续确认吗？";
				        	}else if(processStatus=="6"){
				        		nui.alert("该指令/建议后台已成交，不能再做任何操作","提示");
				        		return;
				        	}
					    
					        nui.confirm(msg,"系统提示",
					        function(action){
					            if(action=="ok"){
					            	
					            	//提交之前再次实时查询指令/建议单有效状态，避免用户在操作界面停留时间太长导致界面数据状态与数据库不一致
					            	var jsonValidStatus = nui.encode({zhfwptjyzqmm:{processId:rowRecord.processId}});
								  	$.ajax({
								          url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.getValidStatus_ZQMM.biz.ext",
								          type:'POST',
								          data:jsonValidStatus,
								          cache:false,
								          contentType:'text/json',
								          success:function(text){
								              var returnJsonValidStatus = nui.decode(text);
								              //交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
								              var returnValidStatus = returnJsonValidStatus.validStatus;
								              
								              //若指令/建议单有效，则继续执行
								              if(returnValidStatus=="0"){
								              
								              	  	//封装主键ID、指令/建议流程处理状态字段传输到后台处理
								                    var json = nui.encode({zhfwptjyzqmms:[{processId:rowRecord.processId, processStatus:processStatus}]});
									                $.ajax({
									                    url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_confirm.biz.ext",
									                    type:'POST',
									                    data:json,
									                    cache: false,
									                    contentType:'text/json',
									                    success:function(text){
									                        var returnJson = nui.decode(text);
									                        if(returnJson.exception == null){
									                        	var validStr = returnJson.validStr;//有效指令/建议单字符串
									                        	var invalidStr = returnJson.invalidStr;//无效指令/建议单字符串
									                        	var validCount = returnJson.validCount;//有效指令/建议单记录数
									                        	var invalidCount = returnJson.invalidCount;//无效指令/建议单记录数
									                        	var invalidFixStr = returnJson.invalidFixStr;//无效指令/建议单字符串（Fix错误信息）
									                        	var validFixFailReason = returnJson.validFixFailReason;//有效指令/建议单字符串（反馈报文失败原因[警告信息等]）
									                        	
									                        	var msg = "";
									                        	var failReasonMsg = "";
									                        	var errorMsg = "";
									                        	if(validCount!=null && validCount!="" && validCount!="0"){
									                        		if(validFixFailReason!=null && validFixFailReason!=""){
									                        			var tempValidStrArr = validStr.split(",");
										                        		var tempValidFixFailReasonArr = validFixFailReason.split("★");
										                        		for(var i=0; i<tempValidStrArr.length; i++){
										                        			failReasonMsg += "【"+tempValidStrArr[i]+"触发以下风控：</br>"+tempValidFixFailReasonArr[i]+"】</br>";
										                        		}
										                        		if(failReasonMsg!=null && (failReasonMsg.indexOf("申请指令/建议审批")!=-1 || failReasonMsg.indexOf("申请风险阀值")!=-1)){
										                        			failReasonMsg += "<span class='warn_red_bold'>请联系人工审批！</span></br>";
										                        		}
									                        		}
									                        		msg += "确认成功 " + validCount + " 条</br>"+failReasonMsg;
									                        	}
									                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
									                        		var tempInvalidStrArr = invalidStr.split(",");
									                        		var tempInvalidFixStrArr = invalidFixStr.split("★");
									                        		for(var i=0; i<tempInvalidStrArr.length; i++){
									                        			errorMsg += "【"+tempInvalidStrArr[i]+"-"+tempInvalidFixStrArr[i]+"】</br>";
									                        		}
									                        		msg += "确认失败 " + invalidCount + " 条</br>"+errorMsg;
									                        	}
									                            nui.alert(msg, "系统提示", function(action){
									                            	CloseWindow("confirmSuccess");
									                            });
									                        }else{
								                                nui.alert("确认失败", "系统提示");
									                        }
									                    }
									                });
								              }else if(returnValidStatus=="3"){
								              	  nui.alert("该指令/建议已退回，您不能再确认","提示");
		        								  return;
								              }else{
												  nui.alert("该指令/建议已无效，不能再做任何操作","提示");
		        								  return;
								              }
								          }
								      });
					             }
					        });
		                }
		            });
			    	
			    //投顾处理
			    }else{
			    
			    	//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
		        	var validStatus = rowRecord.validStatus;
		        	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
		        		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
		        		return;
		        	}
		        	if(validStatus=="3"){
		        		nui.alert("该指令/建议已退回，请先修改重新提交后再确认","提示");
		        		return;
		        	}
		        	
		        	var jsonStatus = nui.encode({zhfwptjyzqmm:{processId:rowRecord.processId}});
		        	$.ajax({
		                url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.getProcessStatus_ZQMM.biz.ext",
		                type:'POST',
		                data:jsonStatus,
		                cache:false,
		                contentType:'text/json',
		                success:function(text){
		                    var returnJsonStatus = nui.decode(text);
		                    
		                    //“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
				        	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
				        	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
				        	var processStatus = returnJsonStatus.processStatus;
				        	
				        	if(processStatus=="-2"){
				        		nui.alert("该指令/建议尚未补齐，您还不能处理","提示");
		        				return;
				        	}else if(processStatus=="-1" || processStatus=="0"){
				        		
				        		var pUserId = rowRecord.inquiryId==null||rowRecord.inquiryId==""?rowRecord.investAdviserId:rowRecord.inquiryId;
				        		//获取该产品投顾复核权限人员名单
						    	$.ajax({
						            url:"com.cjhxfund.jy.ProductProcess.CFJYCombProductHandleBiz.getInvestAdviserConfirmId.biz.ext",
						            type:'POST',
						            data:nui.encode({combProductCode:rowRecord.combProductCode, vcCombiNo:rowRecord.vcCombiNo, userId:pUserId}),
						            cache:false,
						            contentType:'text/json',
						            success:function(text){
						                var returnJson = nui.decode(text);
						                if(returnJson.exception == null){
						                	var confirmUserIds = returnJson.confirmUserIds;
						                	var hasPermission = true;//是否有权限，默认有
						                	//返回值不为空，说明设置了复核人员
						                	if(confirmUserIds!=null && confirmUserIds!=""){
						                		hasPermission = false;//设置为无权限
												var confirmUserIdsArr = confirmUserIds.split(",");
												for(var i=0; i<confirmUserIdsArr.length; i++){
													var userIdTemp = confirmUserIdsArr[i];
													if(userIdTemp==userId){
														hasPermission = true;
														break;
													}
												}
						                	}
											if(hasPermission==false){
												nui.alert("您没有权限确认该指令/建议","提示");
					    						return;
											}
						                	
						                	
						                	nui.confirm("确定要确认该指令/建议吗？","系统提示",function(action){
									            if(action=="ok"){
									            	
									            	//提交之前再次实时查询指令/建议单有效状态，避免用户在操作界面停留时间太长导致界面数据状态与数据库不一致
									            	var jsonValidStatus = nui.encode({zhfwptjyzqmm:{processId:rowRecord.processId}});
												  	$.ajax({
												          url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.getValidStatus_ZQMM.biz.ext",
												          type:'POST',
												          data:jsonValidStatus,
												          cache:false,
												          contentType:'text/json',
												          success:function(text){
												              var returnJsonValidStatus = nui.decode(text);
												              //交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
												              var returnValidStatus = returnJsonValidStatus.validStatus;
												              
												              //若指令/建议单有效，则继续执行
												              if(returnValidStatus=="0"){
												              
												              	  	//封装主键ID、指令/建议流程处理状态字段传输到后台处理
												                    var json = nui.encode({zhfwptjyzqmms:[{processId:rowRecord.processId, processStatus:processStatus}]});
													                $.ajax({
													                    url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_confirm.biz.ext",
													                    type:'POST',
													                    data:json,
													                    cache: false,
													                    contentType:'text/json',
													                    success:function(text){
													                        var returnJson = nui.decode(text);
													                        if(returnJson.exception == null){
													                        	var validStr = returnJson.validStr;//有效指令/建议单字符串
													                        	var invalidStr = returnJson.invalidStr;//无效指令/建议单字符串
													                        	var validCount = returnJson.validCount;//有效指令/建议单记录数
													                        	var invalidCount = returnJson.invalidCount;//无效指令/建议单记录数
													                        	var invalidFixStr = returnJson.invalidFixStr;//无效指令/建议单字符串（Fix错误信息）
													                        	var validFixFailReason = returnJson.validFixFailReason;//有效指令/建议单字符串（反馈报文失败原因[警告信息等]）
													                        	
													                        	var msg = "";
													                        	var failReasonMsg = "";
													                        	var errorMsg = "";
													                        	if(validCount!=null && validCount!="" && validCount!="0"){
													                        		if(validFixFailReason!=null && validFixFailReason!=""){
													                        			var tempValidStrArr = validStr.split(",");
														                        		var tempValidFixFailReasonArr = validFixFailReason.split("★");
														                        		for(var i=0; i<tempValidStrArr.length; i++){
														                        			failReasonMsg += "【"+tempValidStrArr[i]+"触发以下风控：</br>"+tempValidFixFailReasonArr[i]+"】</br>";
														                        		}
														                        		if(failReasonMsg!=null && (failReasonMsg.indexOf("申请指令/建议审批")!=-1 || failReasonMsg.indexOf("申请风险阀值")!=-1)){
														                        			failReasonMsg += "<span class='warn_red_bold'>请联系人工审批！</span></br>";
														                        		}
													                        		}
													                        		msg += "确认成功 " + validCount + " 条</br>"+failReasonMsg;
													                        	}
													                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
													                        		var tempInvalidStrArr = invalidStr.split(",");
													                        		var tempInvalidFixStrArr = invalidFixStr.split("★");
													                        		for(var i=0; i<tempInvalidStrArr.length; i++){
													                        			errorMsg += "【"+tempInvalidStrArr[i]+"-"+tempInvalidFixStrArr[i]+"】</br>";
													                        		}
													                        		msg += "确认失败 " + invalidCount + " 条</br>"+errorMsg;
													                        	}
													                            nui.alert(msg, "系统提示", function(action){
													                            	CloseWindow("confirmSuccess");
													                            });
													                        }else{
												                                nui.alert("确认失败", "系统提示");
													                        }
													                    }
													                });
												              }else if(returnValidStatus=="3"){
												              	  nui.alert("该指令/建议已退回，请先修改重新提交后再确认","提示");
						        								  return;
												              }else{
																  nui.alert("该指令/建议已无效，不能再做任何操作","提示");
						        								  return;
												              }
												          }
												      });
									             }
									        });
						                	
						                }else{
						                    nui.alert("权限人员名单获取失败", "系统提示");
						                }
						            }
						        });
								
				        	}else{
				        		nui.alert("该指令/建议已确认","提示");
		        				return;
				        	}
		                }
		            });
			    }
			}
			
			//退回
			function onGoBack_ZQMM(){
				
				//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
		    	var validStatus = rowRecord.validStatus;
		    	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
		    		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
		    		return;
		    	}
		    	if(validStatus=="3"){
		    		nui.alert("该指令/建议已退回，请不要重复操作","提示");
		    		return;
		    	}
				
				var processStatus = rowRecord.processStatus;//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
				if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
					nui.alert("该指令/建议尚未确认，您还不能处理","提示");
		    		return;
				
				//投资经理下单操作权限认证
				}else if(processStatus=="1"){
					//若当前用户有权限处理该指令/建议单，则继续执行，否则返回
		    		var hasPermission = false;//是否有权限，默认无
					var userIdRelaType02 = rowRecord.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
					if(userIdRelaType02!=null && userIdRelaType02!=""){
						var userIdRelaType02Arr = userIdRelaType02.split(",");
						for(var j=0; j<userIdRelaType02Arr.length; j++){
							var userIdTemp = userIdRelaType02Arr[j];
							if(userIdTemp==userId){
								hasPermission = true;
								break;
							}
						}
					}
					if(hasPermission==false){
						nui.alert("您没有权限退回该指令/建议","提示");
		    			return;
					
					}else{
						
						//封装主键ID字段传输到后台处理开始...
			    		var msg = "确定要退回该指令/建议吗？";
			    		nui.confirm(msg,"系统提示",function(action){
							if(action=="ok"){
				                var json = nui.encode({zhfwptjyzqmms: [{processId: rowRecord.processId}], validStatus: "3"});
				                $.ajax({
				                    url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_updateValidStatus.biz.ext",
				                    type:'POST',
				                    data:json,
				                    cache: false,
				                    contentType:'text/json',
				                    success:function(text){
				                        var returnJson = nui.decode(text);
				                        if(returnJson.exception == null){
				                            nui.alert("退回成功", "系统提示", function(action){
				                            	CloseWindow("confirmSuccess");
				                            });
				                        }else{
				                            nui.alert("退回失败", "系统提示");
				                        }
				                    }
				                });
							}
						});
			    		//封装主键ID字段传输到后台处理结束!!!
					
					}
				}else{
					nui.alert("该指令/建议投资经理已下单，不能做退回操作","提示");
		    		return;
				}
			}
			
	</script>
</body>
</html>
