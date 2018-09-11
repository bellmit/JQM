<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): tongwei
- Date: 2017-08-01 16:42:39
- Description: 投资管理和交易管理下正逆回购业务详细页
--%>
<head>
<title>正逆回购业务</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
<script src="<%= request.getContextPath() %>/ProductProcess/CFJYProductProcessList_common.js" type="text/javascript"></script>
</head>
<body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <input class="nui-hidden" name="zhfwptjyznhg.processType4InvestProductNum" value="03,04,05,06,16,17,21,22"/>
            <input class="nui-hidden" name="zhfwptjyznhg.processId" id="processId"/>
            <input class="nui-hidden" name="zhfwptjyznhg.processStatus" id="processStatus"/>
            <input class="nui-hidden" name="zhfwptjyznhg.roleType" id="roleType"/>
            <input class="nui-hidden" name="zhfwptjyznhg.bonds" id="zhfwptjyznhg.bonds"/>	
            <input class="nui-hidden" name="zhfwptjyznhg.validStatus" id="validStatus"/>
            <input class="nui-hidden" name="zhfwptjyznhg.isNotExport" id="isNotExport"/>
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td class="form_label" align="right" width="23%">
                        业务日期:
                    </td>
                    <td colspan="1" width="27%">
                    	<input name="zhfwptjyznhg.isInquiry" id="isInquiry" class="nui-hidden" value="0">
                        <input readonly="readonly" id="processDate" class="nui-datepicker" name="zhfwptjyznhg.processDate" required="true" value=""/>
                    </td>
                    <td class="form_label" align="right" width="23%">
                        业务类别:
                    </td>
                    <td colspan="1" width="27%">
                        <input readonly="readonly" id="processType" class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZNHG" name="zhfwptjyznhg.processType" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right" width="23%">
                        产品名称:
                    </td>
                    <td colspan="1" width="27%">
                        <input readonly="readonly" id="combProductCode" required="true" class="nui-autocomplete" style="width:150px;" name="zhfwptjyznhg.combProductCode" searchField="searchKey" dataField="combProducts"
                        	valueField="fundCode" textField="fundName" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductsByKeyAndUserId.biz.ext" value="" text="" enterQuery="false" onvaluechanged="changedCombProductCode"/>
                        <input id="combProductName" class="nui-hidden" name="zhfwptjyznhg.combProductName"/>
                    </td>
                    <td class="form_label" align="right" width="23%">
                        组合名称:
                    </td>
                    <td colspan="1" width="27%">
                       <!-- <input readonly="readonly" class="nui-combobox" id="vcCombiNo"  required="true" dataField="productCombis"  name="zhfwptjyznhg.vcCombiNo" 
	                        valueField="vcCombiNo" textField="vcCombiName" onvaluechanged="setVcCombiName" searchField="searchKey"  enterQuery="false"/> -->
	                      <input class="nui-hidden" id="vcCombiNo" name="zhfwptjyznhg.vcCombiNo"/>  
	                      <input readonly="readonly" class="nui-textbox" id="vcCombiName" required="true" name="zhfwptjyznhg.vcCombiName"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                        券面总额合计（万元）:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="investCount" class="nui-textbox" name="zhfwptjyznhg.investCount" required="true" onblur="investCountFun()"/>
                    </td>
                    <td class="form_label" align="right">
                        交易金额（万元）:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="tranAmount" class="nui-textbox" name="zhfwptjyznhg.tranAmount" required="false" onblur="tranAmountFun()"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label" align="right">
                        回购期限（天）:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="actualDays" class="nui-textbox" name="zhfwptjyznhg.actualDays" required="true" onblur="actualDaysFun()"/>
                    </td>
                    <td class="form_label" align="right">
                        交易对手:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="tradingOpponent" class="nui-textbox" name="zhfwptjyznhg.tradingOpponent" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                        回购利率（%）:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="tradingRate" class="nui-textbox" name="zhfwptjyznhg.tradingRate" required="true"/>
                    </td>
                    <td class="form_label" align="right">
                        清算速度:
                    </td>
    				<td colspan="1" class="radio-border-top-none">
            			<input readonly="readonly" id="clearingSpeed" class="nui-dictradiogroup" dictTypeId="CF_JY_PRODUCT_PROCESS_CLEARING_SPEED" name="zhfwptjyznhg.clearingSpeed" value="T+0" repeatItems="1" repeatLayout="none" repeatDirection="horizontal" onvaluechanged="clearingSpeedOnvaluechanged(e)"/>
            		</td>
                </tr>
                <tr>
                	<td class="form_label" align="right">
                        首次结算日:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="firstSettlementDate" class="nui-datepicker" name="zhfwptjyznhg.firstSettlementDate" required="true" value=""/>
                    </td>
                    <td class="form_label" align="right">
                        到期结算日:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="expiryDate" class="nui-datepicker" name="zhfwptjyznhg.expiryDate" required="true" value=""/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                        备注:
                    </td>
                    <td colspan="3">
                        <input readonly="readonly" class="nui-textarea"name="zhfwptjyznhg.remark" width="100%"/>
                    </td>
                </tr>
            </table>
            
            
            <div title="回购债券信息">
			  <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
			    <table style="width:100%;">
			      <tr>
			        <td style="width:100%;">
			          	回购债券信息
			        </td>
			      </tr>
			    </table>
			  </div>
			  
			  <div 
		              id="grid_0"
		              class="nui-datagrid"
		              style="width:100%;height:238px;"
		              showPager="false"
		              sortMode="client"
		              url="com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_queryBondsByProcessId.biz.ext"
		              dataField="bonds"
		              allowCellEdit="false"
		              allowCellSelect="true"
		              multiSelect="true"
		              editNextOnEnterKey="true"
		              >
			    <div property="columns">
			      <div type="indexcolumn"></div>
			      <div type="checkcolumn"></div>
			      <div field="bondCode" allowSort="true" align="center" headerAlign="center" width="100px" >
			        债券代码
			        <input readonly="readonly" id="bondCode" required="true" class="nui-autocomplete" popupWidth="300" popupHeight="200" style="width:100px;" name="bondCode" property="editor" searchField="searchKey" dataField="investProducts"
                        	valueField="investProduct" textField="investProduct" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByKey.biz.ext" value="" text="" enterQuery="false"/>
			      </div>
			      <div field="bondName" allowSort="true" align="center" headerAlign="center" width="150px" >
			        债券名称
			        <input readonly="readonly" id="bondName" class="nui-textbox" name="bondName" property="editor" required="true"/>
			      </div>
			      <div field="bondAmount" allowSort="true" align="right" headerAlign="center" width="">
			        券面总额（万元）
			        <input readonly="readonly" id="bondAmount" class="nui-textbox" name="bondAmount" property="editor" required="true" onblur="bondAmountFun()"/>
			      </div>
			      <div field="conversionRatio" allowSort="true" align="right" headerAlign="center" width="">
			        折算比例（%）
			        <input readonly="readonly" id="conversionRatio" class="nui-textbox" name="conversionRatio" property="editor" required="true"/>
			      </div>
			      <div field="firstNetValue" allowSort="true" align="right" headerAlign="center" width="">
			        首次净价（元）
			        <input readonly="readonly" id="firstNetValue" class="nui-textbox" name="firstNetValue" property="editor" required="true" onblur="firstNetValueFun()"/>
			      </div>
			    </div>
			  </div>
			</div>
            
            
            <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a id="confirm" class='nui-button' plain='false' iconCls="icon-ok" onclick="onOk_ZNHG()">
                                确认
                            </a>
                            <span style="display:inline-block;width:25px;"></span>
                            <a id="goBack" class='nui-button' plain='false' iconCls="icon-no" onclick="onGoBack_ZNHG()">
                                退回
                            </a>
                            <span style="display:inline-block;width:25px;"></span>
                            <a id="export_ZNHG" class='nui-button' plain='false' iconCls="icon-download" onclick="export_ZNHG()">
	                      导出
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
        <div>
		<form id="export_ZNHG_FROM" method="post">
			<!-- 数据实体的名称 -->
			<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.singleDataset.ZhfwptJyZnhg">
			<input class="nui-hidden" name="exportType" value="0">
			<input class="nui-hidden" name="criteria/_expr[1]/processId" id="processId1"/>
			<input class="nui-hidden" name="criteria/_expr[1]/_op" value="in"/>
			<input class="nui-hidden" name="processType" id="processType1"/>
		</form>	
</div>
        <script type="text/javascript">
            nui.parse();
            //nui.get("confirm").disable();//将“确认”按钮设置为不可用
            var rowPageType = "";//页面类型
            var rowRecord;//保存行记录数据，确认时使用
            var tradingConfirmAuthorityUserIds = "";//交易确认阶段权限人员名单字符串，确认时使用
            var backstageConfirmAuthorityUserIds = "";//后台已成交阶段权限人员名单字符串，确认时使用
            
			//设置债券记录
			function setGridData(datagrid,dataid){
		        var grid = nui.get(datagrid);
		        var grid_data = grid.getData();
		        var grid_data_new = new Array();
		        for(var i=0; i<grid_data.length; i++){
		        	var bond = grid_data[i];
                	var bondCode = bond.bondCode;//债券代码
                	var bondName = bond.bondName;//债券名称
                	var bondAmount = bond.bondAmount;//券面总额（万元）
                	var conversionRatio = bond.conversionRatio;//折算比例（%）
                	var firstNetValue = bond.firstNetValue;//首次净价（元）
                	var bondCodeTemp = bondCode;
                	var bondNameTemp = bondName;
                	if(bondCode!=null && bondCode!="" && bondCode.indexOf("-")!=-1){//若是选择债券，则将债券代码、债券名称拆分保存
                		bondCodeTemp = bondCode.substr(0, bondCode.indexOf("-"));
                		if(bondCode.length >= bondCode.indexOf("-")+1){
                			bondNameTemp = bondCode.substr(bondCode.indexOf("-")+1, bondCode.length);
                		}
                	}
                	var bondTemp = {bondCode:bondCodeTemp,bondName:bondNameTemp,bondAmount:bondAmount,conversionRatio:conversionRatio,firstNetValue:firstNetValue};
                	grid_data_new.push(bondTemp);
		        }
		        nui.get(dataid).setValue(grid_data_new);
			}
			
			//页面间传输json数据
			function setFormData(data){
				//跨页面传递的数据对象，克隆后才可以安全使用
				var infos = nui.clone(data);
				
				//保存list页面传递过来的页面类型：add表示新增、edit表示编辑、query表示查询
				nui.getbyName("pageType").setValue(infos.pageType);
				
				rowPageType = infos.pageType;//页面类型
				rowRecord = infos.record.zhfwptjyznhg;
				var json = infos.record;
				var form = new nui.Form("#dataform1");//将普通form转为nui的form
				
				//加载债券信息
				nui.get("grid_0").load({processId:json.zhfwptjyznhg.processId});
				
				//设置产品名称值
				var combProductNameVal = json.zhfwptjyznhg.combProductName;
				nui.get("combProductCode").setText(combProductNameVal);
				nui.get("combProductName").setValue(combProductNameVal);
				
				//设置表单数据公共逻辑处理
				setFormDataCommon(form, json, infos);
				
				isInquiryOnvaluechanged(nui.get("isInquiry"));//初始化设置必输项，是否询价指令/建议：0-否（完整指令/建议）;1-是（询价指令/建议）;
			}
			
			//是否询价指令/建议：0-否（完整指令/建议）;1-是（询价指令/建议）;
            function isInquiryOnvaluechanged(e){
            	var val = e.value;
            	if(val=="0"){
            		nui.get("tradingOpponent").setRequired(true);//交易对手
            		nui.get("investCount").setRequired(true);//券面总额合计（万元）
            		nui.get("actualDays").setRequired(true);//回购期限（天）
            		nui.get("tradingRate").setRequired(true);//回购利率（%）
            		nui.get("firstSettlementDate").setRequired(true);//首次结算日
            		nui.get("expiryDate").setRequired(true);//到期结算日
            	}else{
            		nui.get("tradingOpponent").setRequired(false);//交易对手
            		nui.get("investCount").setRequired(false);//券面总额合计（万元）
            		nui.get("actualDays").setRequired(false);//回购期限（天）
            		nui.get("tradingRate").setRequired(false);//回购利率（%）
            		nui.get("firstSettlementDate").setRequired(false);//首次结算日
            		nui.get("expiryDate").setRequired(false);//到期结算日
            	}
            }
            
            //导出正逆回购
			function export_ZNHG(){

			    var processType =nui.get("processType").getValue();
			    var validStatus = nui.get("validStatus").getValue();
			    if(validStatus != 0){
			      nui.alert("该指令/建议无效，不能导出。","系统提示");
			      return;
			    }
			    
			    //判断当指令/建议状态小于2时给出提示
			    var processStatus = nui.get("processStatus").getValue();
			    if(processStatus < 2){
			      nui.alert("该指令/建议未下单，不能导出。","系统提示");
			      return;
			    }
			    
			    //交易所协议正逆回购业务数据不能导出
			    if(processType == "16" || processType == "17"){
			      nui.alert("该指令/建议属于交易所协议回购，不能导出。","系统提示");
			      return;
			    }
			    
			    //交易所协议正逆回购业务数据不能导出
			    if(processType == "21" || processType == "22"){
			      nui.alert("该指令/建议属于交易所回购，不能导出。","系统提示");
			      return;
			    }
			    
			    if(processType == "03" || processType == "04"){
			       processType = "1";
			    }
			    if(processType == "05" || processType == "06"){
			       processType = "2";
			    }
			    
			    nui.get("processType1").setValue(processType);
		    	
		    	//判断该指令/建议是否已经导出过
		    	var isNotExport = nui.get("isNotExport").getValue();
		    	var msg = "确定要导出当前指令/建议吗？";
		    	if(isNotExport == 1){
		    	   msg = "指令/建议之前已导出，确认要继续导出吗?";
		    	}
				
				
				//获取选中的指令/建议单主键ID，若没选中，则过滤该条件
				nui.get("processId1").setValue(nui.get("processId").getValue());
				
				nui.confirm(msg,"系统提示",function(action){
					if(action=="ok"){
						nui.get("export_ZNHG").disable();//禁用“导出”按钮
						var form = document.getElementById("export_ZNHG_FROM");
						form.action = "com.cjhxfund.jy.ProductProcess.PledgedRepoExport.flow";
				        form.submit();
				        setTimeout("enableExportFun1()",15000);//启用“导出”按钮
					}
				});
			}
			
			function enableExportFun1(){
			  nui.get("export_ZNHG").enable();
			}
			
			//执行确认
			function onOk_ZNHG() {
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
		        	
		        	var jsonStatus = nui.encode({zhfwptjyznhg:{processId:rowRecord.processId}});
		        	$.ajax({
		                url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG.getProcessStatus_ZNHG.biz.ext",
		                type:'POST',
		                data:jsonStatus,
		                async:false, 
				        cache:false,
		                contentType:'text/json',
		                success:function(text){
		                    var returnJsonStatus = nui.decode(text);
		                    
		                    //“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
				        	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
				        	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
				        	var processStatus = returnJsonStatus.processStatus;
				        	
				        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0" || processStatus=="1"){
				        		nui.alert("该指令/建议尚未确认，您还不能处理","提示");
		        				return;
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
				        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0" || processStatus=="1"){
				        		nui.alert("该指令/建议尚未确认，您还不能处理","提示");
		        				return;
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
					            	var jsonValidStatus = nui.encode({zhfwptjyznhg:{processId:rowRecord.processId}});
								  	$.ajax({
								          url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG.getValidStatus_ZNHG.biz.ext",
								          type:'POST',
								          data:jsonValidStatus,
						                  async:false, 
								          cache:false,
								          contentType:'text/json',
								          success:function(text){
								              var returnJsonValidStatus = nui.decode(text);
								              //交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
								              var returnValidStatus = returnJsonValidStatus.validStatus;
								              
								              //若指令/建议单有效，则继续执行
								              if(returnValidStatus=="0"){
								              	  	//封装主键ID、指令/建议流程处理状态字段传输到后台处理	
								                    var json = nui.encode({zhfwptjyznhgs:[{processId:rowRecord.processId, processStatus:processStatus}]});
									                $.ajax({
									                    url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_confirm.biz.ext",
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
		        	
		        	var jsonStatus = nui.encode({zhfwptjyznhg:{processId:rowRecord.processId}});
		        	var hasPermission = false;//是否有权限，默认无
		        	$.ajax({
		                url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG.getProcessStatus_ZNHG.biz.ext",
		                type:'POST',
		                data:jsonStatus,
		                async:false, 
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
				        	}else if(processStatus=="-1" || processStatus=="0" || processStatus=="1"){
				        		if(processStatus=="-1" || processStatus=="0"){
				        			var pUserId = rowRecord.inquiryId==null||rowRecord.inquiryId==""?rowRecord.investAdviserId:rowRecord.inquiryId;
					        		//获取该产品投顾复核权限人员名单
							    	$.ajax({
							            url:"com.cjhxfund.jy.ProductProcess.CFJYCombProductHandleBiz.getInvestAdviserConfirmId.biz.ext",
							            type:'POST',
							            data:nui.encode({combProductCode:rowRecord.combProductCode, vcCombiNo:rowRecord.vcCombiNo, userId:pUserId}),
						                async:false, 
								        cache:false,
							            contentType:'text/json',
							            success:function(text){
							                var returnJson = nui.decode(text);
							                if(returnJson.exception == null){
							                	var confirmUserIds = returnJson.confirmUserIds;
							                	//返回值不为空，说明设置了复核人员
							                	if(confirmUserIds!=null && confirmUserIds!=""){
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
												
											}
										}
									});
				        		}else{
					        		//若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
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
				        		}
				        		if(hasPermission == true){
				        			nui.confirm("确定要确认该指令/建议吗？","系统提示",function(action){
							            if(action=="ok"){
							            	
							            	//提交之前再次实时查询指令/建议单有效状态，避免用户在操作界面停留时间太长导致界面数据状态与数据库不一致
							            	var jsonValidStatus = nui.encode({zhfwptjyznhg:{processId:rowRecord.processId}});
										  	$.ajax({
										          url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG.getValidStatus_ZNHG.biz.ext",
										          type:'POST',
										          data:jsonValidStatus,
									              async:false, 
											      cache:false,
										          contentType:'text/json',
										          success:function(text){
										              var returnJsonValidStatus = nui.decode(text);
										              //交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
										              var returnValidStatus = returnJsonValidStatus.validStatus;
										              
										              //若指令/建议单有效，则继续执行
										              if(returnValidStatus=="0"){
										              		
										              	  	//封装主键ID、指令/建议流程处理状态字段传输到后台处理
										                    var json = nui.encode({zhfwptjyznhgs:[{processId:rowRecord.processId, processStatus:processStatus}]});
											                $.ajax({
											                    url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_confirm.biz.ext",
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
				        		}
				        	}else{
				        		nui.alert("该指令/建议已确认","提示");
		        				return;
				        	}
		                }
		            });
			    }
			}
			
			
			//退回
			function onGoBack_ZNHG(){
				
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
				                var json = nui.encode({zhfwptjyznhgs: [{processId: rowRecord.processId}], validStatus: "3"});
				                $.ajax({
				                    url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_updateValidStatus.biz.ext",
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
