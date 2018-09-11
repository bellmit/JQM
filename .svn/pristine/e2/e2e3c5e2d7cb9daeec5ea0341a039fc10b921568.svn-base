<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-06-21 15:58:24
  - Description:债券买卖交易员指令详细页
-->
<head>
<title>指令/建议详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    <style type="text/css">
    	tr{
		    display: table-row;
		    vertical-align: inherit;
		    border-color: inherit;
		}
		.nui-form-table {
		    border-collapse: collapse;
		    border: none;
		    padding-left: 5px;
		}
		.nui-form-table tr td{
			 padding-right:0;
		}
    </style>
</head>
<body>
	<div id="instructDetail_grid">
        <table class="nui-form-table" style="width:100%; heiht:100%;">
            <tr>
                <td align="right" width="150"><span style="color: red;">*</span>产品名称：</td>
                <td width="180">    
                    <input name="instructInfo.vcProductName" class="nui-textbox" required="true" readonly/>
                </td>
                <td align="right" width="150"><span style="color: red">*</span>净价/全价：</td>
                <td width="180">    
                    <span><input style="width:65px" class="nui-textbox" id="enNetPrice" name="instructInfo.enNetPrice" required="true" readonly/></span>
					/
					<span><input style="width:65px" class="nui-textbox" id="enFullPrice" name="instructInfo.enFullPrice" required="true" readonly/></span>
                </td>
            </tr>
            <tr>
                <td align="right" width="150"><span style="color: red">*</span>组合名称：</td>
                <td width="180">    
                    <input name="instructInfo.vcCombiName" class="nui-textbox" required="true" readonly/>
                </td>
                <td align="right" width="150" id="MaturityLab"><span style="color: red">*</span>到期/行权收益率：</td>
				<td width="180" id="MaturityField">
					<span><input style="width:65px" class="nui-textbox" id="enMaturityYield" name="instructInfo.enMaturityYield" required="true" readonly/></span> 
					<label id="MaturityLabSplit">/</label> 
					<span><input style="width:65px" class="nui-textbox" id="enOptionYield"  name="instructInfo.enOptionYield" required="true" readonly/></span>
				</td>
            </tr>
            <tr>
                <td align="right" width="150"><span style="color: red">*</span>债券代码：</td>
                <td width="180">    
                    <input name="instructInfo.vcStockCode" class="nui-textbox" required="true" readonly/>
                </td>
                <td align="right" width="150"><span style="color: red">*</span>债券名称：</td>
                <td width="180">    
                    <input name="instructInfo.vcStockName" class="nui-textbox"  required="true" style="width:143px" readonly/>
                </td>
            </tr>  
            <tr>
                <td align="right" width="150"><span style="color: red">*</span>委托方向：</td>
                <td width="180">    
                    <input name="instructInfo.vcEntrustDirection" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="entrustDirection" required="true" readonly/>
                </td>
                <td align="right" width="150"><span style="color: red">*</span>交易日期：</td>
                <td width="180">                        
                    <input name="instructInfo.lTradeDate" class="nui-textbox" required="true" style="width:143px" readonly/>
                </td>
            </tr>
            <tr>
                <td align="right" width="150"><span style="color: red">*</span>清算速度：</td>
                <td width="180">    
                    <input name="instructInfo.vcSettleSpeed" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="settleSpeed" required="true" readonly/>
                </td>
                <td align="right" width="150"><span style="color: red">*</span>结算日期：</td>
                <td width="180">    
                    <input name="instructInfo.lFirstSettleDate" class="nui-textbox" required="true" style="width:143px" readonly/>
                </td>
            </tr>
            
           	<!-- 银行间业务 --> 
            <tr id="interBankBiz1">
                <td align="right" width="150"><span style="color: red">*</span>券面金额（万元）：</td>
                <td width="180">    
                	<input name="instructInfo.enFaceAmount1" class="nui-spinner" minValue="0" maxValue="10000000000" format="n2" required="true" readonly/>
                </td>
                <td align="right" width="150"><span style="color: red">*</span>交易对手：</td>
                <td width="180"> 
                	<input name="instructInfo.vcCounterpartyName1" class="nui-textbox" required="true" style="width:143px" readonly/>   
                </td>
            </tr>
            <tr id="interBankBiz2">
                <td align="right" width="150">对方交易员：</td>
                <td width="180">    
                    <input name="instructInfo.vcCounterpartyTrader1" class="nui-textbox" required="true" readonly/>
                </td>
                <td align="right" width="150">对手主体机构：</td>
                <td width="180">    
                    <input name="instructInfo.vcCounterpartyOrgan1" class="nui-textbox" required="true" style="width:143px" readonly/>
                </td>
            </tr>   
            
            <!-- 上交所固收平台 --> 
            <tr id="sjsgsBiz1">
                <td align="right" width="150"><span style="color: red">*</span>券面金额（万元）：</td>
                <td width="180">    
                	<input name="instructInfo.enFaceAmount" class="nui-spinner" minValue="0" maxValue="10000000000" format="n2" required="true" readonly/>
                </td>
                <td align="right" id="enNetPriceAmountText" width="150"><span style="color: red">*</span>净价金额：</td>
                <td width="180" id="enNetPriceAmountValue">    
                	<input name="instructInfo.enNetPriceAmount" class="nui-spinner" minValue="0" maxValue="10000000000" format="n2" required="true" style="width:143px" readonly/>
                </td>
                <td align="right" id="enFullPriceAmountText" width="150"><span style="color: red">*</span>全价金额：</td>
                <td width="180" id="enFullPriceAmountValue">    
                	<input name="instructInfo.enFullPriceAmount" class="nui-spinner" minValue="0" maxValue="10000000000" format="n2" required="true" style="width:143px" readonly/>
                </td>
            </tr>  
            <tr id="sjsgsBiz2">
                <td id="sjsgs_vcCounterpartyTrader_text" align="right" width="150"><span style="color: red">*</span>对方交易员：</td>
                <td id="sjsgs_vcCounterpartyTrader_value" width="180">    
                    <input name="instructInfo.vcCounterpartyTrader" class="nui-textbox" required="true" readonly/>
                </td>
                <td id="sjsdz_vcRivalSeat_text" align="right" width="150"><span style="color: red">*</span>对手席位：</td>
                <td id="sjsdz_vcRivalSeat_value" width="180">    
                    <input name="instructInfo.vcRivalSeat" class="nui-textbox" required="true" readonly/>
                </td>
                <td id="sjsdz_vcCounterpartyName_text" align="right" width="150"><span style="color: red">*</span>交易对手：</td>
                <td id="sjsdz_vcCounterpartyName_value" width="180"> 
                	<input name="instructInfo.vcCounterpartyName" class="nui-textbox" required="true" style="width:143px" readonly/>   
                </td>
            </tr>  
            <tr id="sjsgsBiz3">
            	<td id="sjsdz_vcAgreemtCode_text" align="right" width="150"><span style="color: red">*</span>约定号：</td>
                <td id="sjsdz_vcAgreemtCode_value" width="180">    
                    <input name="instructInfo.vcAgreemtCode" class="nui-textbox" required="true" readonly/>
                </td>
                <td id="sjsdz_vcCounterpartyOrgan_text" align="right" width="150">对手主体机构：</td>
                <td id="sjsdz_vcCounterpartyOrgan_value" width="180">    
                    <input name="instructInfo.vcCounterpartyOrgan" class="nui-textbox" required="true" style="width:143px" readonly/>
                </td>
            </tr>
            <tr>
                <td align="right" width="150">备注：</td>
                <td colspan="3" style="width:493px;">    
                    <input name="instructInfo.vcRemark" class="nui-textarea" style="width:493px;" required="true" readonly/>
                </td>
            </tr>           
        </table>
    </div>  
    <div class="nui-toolbar" id="confirmInstructInfo" style="border:0;"> 
        <table class="nui-form-table" style="padding:0px; width:100%;" borderStyle="border:0;">
        	<tr>
        		<td align="center" style="text-align:center;" colspan="3">
        			<a class="nui-button" plain="false" iconCls="icon-tip" onclick="riskControlTrial()">风控试算</a>
        			<span style="display:inline-block;width:25px;"></span>
        			<a class='nui-button' plain='false' iconCls="icon-edit" onclick="openSetEnterCheckUser()" id="openSetEnterCheckUser" enabled="false">指定复核人</a>
        			<span style="display:inline-block;width:25px;"></span>
        			<a class='nui-button' plain='false' iconCls="icon-ok" id="confirm" enabled="false" onclick="goconfirm()">确认</a>
        			<span style="display:inline-block;width:25px;"></span>
        			<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow()">关闭</a>
        		</td>
        	</tr>
        </table>
    </div>
    <div id="approveResultInfo" style="display:none"> 
        <table class="nui-form-table" style="padding:0px; width:100%;" borderStyle="border:0;">
        	<tr>
        		<td align="center" style="text-align:center;" colspan="3">
        			<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow()">关闭</a>
        		</td>
        	</tr>
        </table>
    </div>      
	<!--输入项完整指令/建议end  -->
	<script type="text/javascript">
    	nui.parse();
    	$("#instructDetail_grid .mini-buttonedit-button").remove();
    	var instruct_detail_from = new nui.Form("#instructDetail_grid");
    	var row = "";
    	var instructCheckUser = "";
    	
    	function setFormData(data){
    		//跨页面传递的数据对象，克隆后才可以安全使用
    		row = nui.clone(data);
    		if(row.lFirstSettleDate != null){
				row["lFirstSettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lFirstSettleDate"].toString()),"yyyy-MM-dd");
			}
			if(row.lTradeDate != null){
				row["lTradeDate"] = nui.formatDate(DateUtil.numStrToDate(row["lTradeDate"].toString()),"yyyy-MM-dd");
			}
			// 对方交易员
			if(row.vcCounterpartyTrader != null){
				row["vcCounterpartyTrader1"] = row.vcCounterpartyTrader;
			}
			// 券面金额
			if(row.enFaceAmount != null){
				row["enFaceAmount1"] = row.enFaceAmount;
			}
			//交易对手
			if(row.vcCounterpartyName != null){
				row["vcCounterpartyName1"] = row.vcCounterpartyName;
			}
			//对手主体机构
			if(row.vcCounterpartyOrgan != null){
				row["vcCounterpartyOrgan1"] = row.vcCounterpartyOrgan;
			}
			instruct_detail_from.setData({instructInfo:row});
			if(row.vcBizType == "1"){		
				// 买卖银行间业务显示
				document.getElementById("sjsgsBiz1").style.display = "none";
				document.getElementById("sjsgsBiz2").style.display = "none";
				document.getElementById("sjsgsBiz3").style.display = "none";
			}else if(row.vcBizType == "2" || row.vcBizType == "4"){
				// 买卖上海大宗交易业务和深交所业务显示
				document.getElementById("sjsgs_vcCounterpartyTrader_text").style.display = "none";
				document.getElementById("sjsgs_vcCounterpartyTrader_value").style.display = "none";
				document.getElementById("interBankBiz1").style.display = "none";
				document.getElementById("interBankBiz2").style.display = "none";
				// 上交所大宗 显示对手席位， 上交所固收显示对方交易员, 其他字段一致				
			}else if(row.vcBizType == "3"){
				// 买卖上海固收平台业务显示
				document.getElementById("sjsdz_vcRivalSeat_text").style.display = "none";
				document.getElementById("sjsdz_vcRivalSeat_value").style.display = "none";
				document.getElementById("interBankBiz1").style.display = "none";
				document.getElementById("interBankBiz2").style.display = "none";
			}else if(row.vcBizType == "8" || row.vcBizType == "9"){
				//竞价平台买卖
				document.getElementById("sjsdz_vcRivalSeat_text").style.display = "none";
				document.getElementById("sjsdz_vcRivalSeat_value").style.display = "none";
				document.getElementById("interBankBiz1").style.display = "none";
				document.getElementById("interBankBiz2").style.display = "none";
				document.getElementById("sjsgs_vcCounterpartyTrader_text").style.display = "none";
				document.getElementById("sjsgs_vcCounterpartyTrader_value").style.display = "none";
			    document.getElementById("sjsdz_vcRivalSeat_text").style.display = "none";
				document.getElementById("sjsdz_vcRivalSeat_value").style.display = "none";
			    document.getElementById("sjsdz_vcAgreemtCode_text").style.display = "none";
				document.getElementById("sjsdz_vcAgreemtCode_value").style.display = "none";
				document.getElementById("sjsdz_vcCounterpartyName_text").style.display = "none";
				document.getElementById("sjsdz_vcCounterpartyName_value").style.display = "none";
			    document.getElementById("sjsdz_vcCounterpartyOrgan_text").style.display = "none";
				document.getElementById("sjsdz_vcCounterpartyOrgan_value").style.display = "none";
			}
			
			// 显示净价金额或者全价金额
			if(row.vcBizType == "1"){		
				// 买卖银行间业务显示
				document.getElementById("enFullPriceAmountValue").style.display = "none";
			}else if(row.vcBizType == "2" || row.vcBizType == "3" || row.vcBizType == "4" || row.vcBizType == "8" || row.vcBizType == "9"){
				// 买卖上海大宗交易业务和深交所业务显示和上交所固收
				if(row.enNetPriceAmount != null && row.enNetPriceAmount != ""){
					// 隐藏全价
					document.getElementById("enFullPriceAmountText").style.display = "none";
					document.getElementById("enFullPriceAmountValue").style.display = "none";
				}else{
					// 展示全价
					document.getElementById("enNetPriceAmountText").style.display = "none";
					document.getElementById("enNetPriceAmountValue").style.display = "none";
				}
			}
			// 3-二级债 其他为老机器猫
			
	        var validStatus = row.cIsValid;
	        if(validStatus=="1"){
				if(row.vcInstructSource=="3"){		
					if(row.vcProcessStatus ==5 && row.cIsValid==1){
						if (getProductHandleByDealEnter(row.vcProductCode)) {
							nui.get("confirm").enable();
							nui.get("openSetEnterCheckUser").enable();
						}
					}
					if(row.vcProcessStatus ==6 && row.cIsValid==1){
						if (getProductHandleByDealCheck(row.lResultId)) {
							nui.get("confirm").enable();
						}
					}
				}else if(row.vcInstructSource=="1" || row.vcInstructSource=="2"){		//机器猫业务按钮显示
	        		if(getJqmConfrimProductHandle(row)){
						nui.get("confirm").enable();
					};
				}	        	
			}
			// 到期/行权收益率显示
			showYield(row.vcStockCode,row.vcMarket);
    	}
    	
    	// 根据序号查指令信息
    	function setResultNo(lInstructNo){
    		// 是否显示确认，退回按钮
			document.getElementById("approveResultInfo").style.display = "";
			document.getElementById("confirmInstructInfo").style.display = "none";
    		var params = {lResultNo:lInstructNo};
    		var a = nui.loading("正在处理中,请稍等...","提示");
    		nui.ajax({
		    	url: "com.cjhxfund.ats.sm.comm.InstructionManager.getInstructInfoByResultNo.biz.ext",
		      	type: 'POST',
		      	data: {params:params},
		      	contentType: 'text/json',
		      	success: function(text){
		      		nui.hideMessageBox(a);
		      		var returnJson = nui.decode(text.instrcutInfos);
		      		if(returnJson.length>0){
		      			var row = returnJson[0];
			    		if(row.lFirstSettleDate != null){
							row["lFirstSettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lFirstSettleDate"].toString()),"yyyy-MM-dd");
						}
						if(row.lTradeDate != null){
							row["lTradeDate"] = nui.formatDate(DateUtil.numStrToDate(row["lTradeDate"].toString()),"yyyy-MM-dd");
						}
						// 对方交易员
						if(row.vcCounterpartyTrader != null){
							row["vcCounterpartyTrader1"] = row.vcCounterpartyTrader;
						}
						// 券面金额
						if(row.enFaceAmount != null){
							row["enFaceAmount1"] = row.enFaceAmount;
						}
						//交易对手
						if(row.vcCounterpartyName != null){
							row["vcCounterpartyName1"] = row.vcCounterpartyName;
						}
						//对手主体机构
						if(row.vcCounterpartyOrgan != null){
							row["vcCounterpartyOrgan1"] = row.vcCounterpartyOrgan;
						}
						instruct_detail_from.setData({instructInfo:row});
						if(row.vcBizType == "1"){		
							// 买卖银行间业务显示
							document.getElementById("sjsgsBiz1").style.display = "none";
							document.getElementById("sjsgsBiz2").style.display = "none";
							document.getElementById("sjsgsBiz3").style.display = "none";
						}else if(row.vcBizType == "2" || row.vcBizType == "4"){
							// 买卖上海大宗交易业务和深交所业务显示
							document.getElementById("sjsgs_vcCounterpartyTrader_text").style.display = "none";
							document.getElementById("sjsgs_vcCounterpartyTrader_value").style.display = "none";
							document.getElementById("interBankBiz1").style.display = "none";
							document.getElementById("interBankBiz2").style.display = "none";
							
							// 上交所大宗 显示对手席位， 上交所固收显示对方交易员, 其他字段一致				
						}else if(row.vcBizType == "3"){
							// 买卖上海固收平台业务显示
							document.getElementById("sjsdz_vcRivalSeat_text").style.display = "none";
							document.getElementById("sjsdz_vcRivalSeat_value").style.display = "none";
							document.getElementById("interBankBiz1").style.display = "none";
							document.getElementById("interBankBiz2").style.display = "none";
						}else if(row.vcBizType == "8" || row.vcBizType == "9"){
							//竞价平台买卖
							document.getElementById("sjsdz_vcRivalSeat_text").style.display = "none";
							document.getElementById("sjsdz_vcRivalSeat_value").style.display = "none";
						    document.getElementById("interBankBiz1").style.display = "none";
							document.getElementById("interBankBiz2").style.display = "none";
						    document.getElementById("sjsgs_vcCounterpartyTrader_text").style.display = "none";
							document.getElementById("sjsgs_vcCounterpartyTrader_value").style.display = "none";
						    document.getElementById("sjsdz_vcRivalSeat_text").style.display = "none";
							document.getElementById("sjsdz_vcRivalSeat_value").style.display = "none";
						    document.getElementById("sjsdz_vcAgreemtCode_text").style.display = "none";
							document.getElementById("sjsdz_vcAgreemtCode_value").style.display = "none";
							document.getElementById("sjsdz_vcCounterpartyName_text").style.display = "none";
							document.getElementById("sjsdz_vcCounterpartyName_value").style.display = "none";
						    document.getElementById("sjsdz_vcCounterpartyOrgan_text").style.display = "none";
							document.getElementById("sjsdz_vcCounterpartyOrgan_value").style.display = "none";
						}
						// 显示净价金额或者全价金额
						if(row.vcBizType == "1"){		
							// 买卖银行间业务显示
							document.getElementById("enFullPriceAmountValue").style.display = "none";
						}else if(row.vcBizType == "2" || row.vcBizType == "4" || row.vcBizType == "3"){
							// 买卖上海大宗交易业务和深交所业务显示和上交所固收
							if(row.enNetPriceAmount != null && row.enNetPriceAmount != ""){
								// 隐藏全价
								document.getElementById("enFullPriceAmountText").style.display = "none";
								document.getElementById("enFullPriceAmountValue").style.display = "none";
							}else{
								// 展示全价
								document.getElementById("enNetPriceAmountText").style.display = "none";
								document.getElementById("enNetPriceAmountValue").style.display = "none";
							}
							
						}
						// 3-二级债 其他为老机器猫
			
				        var validStatus = row.cIsValid;
				        if(validStatus=="1"){
							if(row.vcInstructSource=="3"){		
								if(row.vcProcessStatus ==5 && row.cIsValid==1){
									if (getProductHandleByDealEnter(row.vcProductCode)) {
										nui.get("confirm").enable();
										nui.get("openSetEnterCheckUser").enable();
									}
								}
								if(row.vcProcessStatus ==6 && row.cIsValid==1){
									if (getProductHandleByDealCheck(row.lResultId)) {
										nui.get("confirm").enable();
									}
								}
							}else if(row.vcInstructSource=="1" || row.vcInstructSource=="2"){		//机器猫业务按钮显示
				        		if(getJqmConfrimProductHandle(row)){
									nui.get("confirm").enable();
								};
							}	        	
						}
						
						// 到期/行权收益率显示
						showYield(row.vcStockCode,row.vcMarket);
		      		}
		      	}
	 		});
    	}
    	
    	//关闭窗口
		function CloseWindow(action) {
		    if (window.CloseOwnerWindow)
		    return window.CloseOwnerWindow(action);
		    else window.close();
		}
		
		//确认--所有业务通用
		function confirm_common_confirm_ZQMM(){
			var jsonStatus = nui.encode({zhfwptjyzqmm:{processId:row.lResultId}});
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
						var userIdRelaType02 = row.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
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
						if(row.tradingConfirmAuthorityUserIds!=null && row.tradingConfirmAuthorityUserIds!=""){
							var tradingConfirmAuthorityUserIdsArr = row.tradingConfirmAuthorityUserIds.split(",");
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
						if(row.backstageConfirmAuthorityUserIds!=null && row.backstageConfirmAuthorityUserIds!=""){
							var backstageConfirmAuthorityUserIdsArr = row.backstageConfirmAuthorityUserIds.split(",");
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
							var jsonValidStatus = nui.encode({zhfwptjyzqmm:{processId:row.lResultId}});
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
										var json = nui.encode({zhfwptjyzqmms:[{processId:row.lResultId, processStatus:processStatus}]});
										var a = nui.loading("正在处理中,请稍等...","提示");
										$.ajax({
											url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_confirm.biz.ext",
											type:'POST',
											data:json,
											cache: false,
											contentType:'text/json',
											success:function(text){
                								nui.hideMessageBox(a);
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
														window.CloseWindow("ok");
													});
												}else{
													nui.alert("确认失败", "系统提示");
													window.CloseWindow("ok");
												}
											}
										});
									}else if(returnValidStatus=="3"){
										nui.alert("该指令/建议已退回，您不能再确认","提示");
										window.CloseWindow("ok");
										return;
									}else{
										nui.alert("该指令/建议已无效，不能再做任何操作","提示");
										window.CloseWindow("ok");
										return;
									}
								}
							});
						}
					});
				}
			});
		}
		
		// 确认按钮分发
		function goconfirm(){
			var json = "";
			delete row.lTradeDate;
    		delete row.lFirstSettleDate;
			// 3-二级债 其他为老机器猫
			if(row.vcInstructSource=="3"){
				// 5录单确认，6复核确认
				if(row.vcProcessStatus =="5"){
					if(instructCheckUser!=""){
						json = {param:row, userIdList:instructCheckUser};
						singleConfirm(json);
					}else{
						// 获取默认复核人
				  		nui.ajax({
			                url: "com.cjhxfund.ats.sm.comm.InstructionManager.getDefaultCheckUser.biz.ext",
			                type: 'POST',
			                contentType:'text/json',
			                success: function (text) {
			                	var returnJson = nui.decode(text);
								if(returnJson.exception == null){
									if(returnJson != null && returnJson != ""){
										if(returnJson.data.length>0){
											// 调用录单确认逻辑
											json = {param:row, userIdList:returnJson.data};
											singleConfirm(json);
										}else{
											nui.alert("默认复核人为空，请先设置","系统提示");
											return;
										}
									}else{
										nui.alert("默认复核人为空，请先设置","系统提示");
										return;
									}
								}else{
									nui.alert("操作异常","系统提示");
									return;
								}
			                }
			            });
					}
				}else if(row.vcProcessStatus =="6"){
					// 调用复核确认逻辑
					json = {param:row};
					singleConfirm(json);
				}
			}else if(row.vcInstructSource=="1" || row.vcInstructSource=="2"){	// 机器猫指令	
				confirm_common_confirm_ZQMM();
			}
		}
		
		// 二级债指令交易员确认
		function singleConfirm(json){
			var a = nui.loading("正在处理中,请稍等...","提示");
	     	nui.ajax({
		    	url: "com.cjhxfund.ats.sm.comm.InstructionManager.updateCheckEnteringStatus.biz.ext",
		      	type: 'POST',
		      	data: json,
		      	contentType: 'text/json',
		      	success: function(text){
		      		nui.hideMessageBox(a);
		      		var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
							nui.alert(returnJson.rtnMsg,"系统提示",  function(action){
								if(action == "ok"){
									window.CloseWindow("ok");
								}	
							});
						}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
							nui.alert(returnJson.rtnMsg,"系统提示",  function(action){
								if(action == "ok"){
									window.CloseWindow("ok");
								}	
							});
						}else{
							nui.alert("操作异常","系统提示");
						}
					}else{
						nui.alert("系统异常","系统提示");
					}
		      	}
     		});
		}
		
		// 录单查询权限
		function getProductHandleByDealEnter(vcProductCode) {
			var url = "";
			var result = false;
			url = "com.cjhxfund.ats.sm.comm.InstructionManager.getProductHandleByProductCodeAndRelateType.biz.ext";
			nui.ajax({
				url : url,
				type : 'POST',
				data : {
					productCode : vcProductCode,
					relateType : "04"
				},
				cache : false,
				async : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if (returnJson.exception == null) {
						var userIds = new Array();
						userIds = returnJson.userIds.split(",");
						for (var i = 0; i < userIds.length; i++) {
							if (userIds[i] == returnJson.userId) {
								result = true;
								return;
							}
						}
						result = false;
					} else {
						result = false;
					}
				}
			});
			return result;
		}
			
		// 查询复核权限
		function getProductHandleByDealCheck(resultId) {
			var url = "";
			var result = false;
			url = "com.cjhxfund.ats.sm.comm.InstructionManager.queryCheckUsersByInstructResultId.biz.ext";
			nui.ajax({
				url : url,
				type : 'POST',
				data : {
					lResultId : resultId
				},
				cache : false,
				async : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if (returnJson.exception == null) {
						var userIds = new Array();
						userIds = returnJson.userIds;
						for (var i = 0; i < userIds.length; i++) {
							if (userIds[i].vcUserId == returnJson.userId) {
								result = true;
								return;
							}
						}
						result = false;
					} else {
						result = false;
					}
				}
			});
			return result;
		}
		
		//获取机器猫业务确认权限
		function getJqmConfrimProductHandle(row){
			var url = "";
			var result = false;
			if(row.vcProcessStatus == "5" || row.vcProcessStatus == "6" || row.vcProcessStatus == "7"){
				url = "com.cjhxfund.ats.sm.comm.InstructionManager.getProductHandleUsersByRelateType.biz.ext";
				nui.ajax({
					url : url,
					type : 'POST',
					data : {
						productCode : "",
						relateType : "99"
					},
					cache : false,
					async : false,
					contentType : 'text/json',
					success : function(text) {
						var returnJson = nui.decode(text);
						if (returnJson.exception == null) {
							var userIds = new Array();
							userIds = returnJson.userIds.split(",");
							for (var i = 0; i < userIds.length; i++) {
								if (userIds[i] == returnJson.userId) {
									result = true;
									return;
								}
							}
						}
					}
				});
			}
			return result;
		}
		
		function openSetEnterCheckUser(){
			// 加载选择复核人页面
			nui.open({
				url : "<%=request.getContextPath()%>/transaction/manage/deal_entering/setEnteringCheckUser.jsp",
			    title: "选择复核人", 
			    width: 283, 
			    height: 331,
			    onload: function () {
			        var iframe = this.getIFrameEl();
			        iframe.contentWindow.SetData(row,"confirm");
			    },
			    ondestroy: function (action) {
					var iframe = this.getIFrameEl();
		            //获取选中、编辑的结果
		            var returnJson = iframe.contentWindow.getData();
		            returnJson = mini.clone(returnJson);    //必须。克隆数据。
		            instructCheckUser = returnJson;
        		}
			});
		}
		
		// 到期/行权收益率显示
		function showYield(vcStockCode,vcMarketNo){
			var parameter={vcStockCode:vcStockCode,vcMarketNo:vcMarketNo};
			nui.ajax({
				url:"com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.getAppointBondInfo.biz.ext",
				type : 'POST',
				data : {condition:parameter},
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						var vcSpecialText = null;
						if(returnJson.bondBasicInfo.length>0){
							vcSpecialText = returnJson.bondBasicInfo[0].vcSpecialText;
						}else{
							return;
						}
						
						if(vcSpecialText && (vcSpecialText.indexOf("回售条款")>=0 || vcSpecialText.indexOf("赎回条款")>=0)){
							$("#MaturityLab").html("<span style='color: red'>*</span>到期/行权收益率:");
							$("#enOptionYield").show();
						}else{
							$("#MaturityLab").html("<span style='color: red'>*</span>到期收益率:");
							$("#enOptionYield").hide();
							$("#MaturityLabSplit").hide();
						}
					}
				}
			});
		}
		
		function riskControlTrial(){
			var a = nui.loading("正在处理中,请稍等...","提示");
			nui.ajax({
        	 	url: "com.cjhxfund.ats.sm.comm.InstructionManager.approveRiskTrial.biz.ext",
	            type: 'POST',
	            data: {lProcessInstID:row.lProcessinstId, bonds: null},
	            cache: false,
	            contentType: 'text/json',
	            success: function (text) {
	            	nui.hideMessageBox(a);
	            	var returnJson = nui.decode(text);
					if(returnJson.exception == null){
		               var riskInfo = returnJson.riskMsg;
		               if (returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
		                    if(returnJson.rtnMsg!=null){
		                    	nui.alert(returnJson.rtnMsg,"系统提示");
		                    }else{
		                    	nui.alert("风控试算通过!","系统提示");
		                    }
		                }else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT%>"){
		                	nui.alert(returnJson.rtnMsg,"投资指令/建议风险提示");//可用不足
		                }else if(returnJson.rtnCode == "203"){
		                	nui.alert(returnJson.rtnMsg,"系统提示");//风控校验失败
		                }else if(returnJson.rtnCode == "301"){
		                	//风险提示框start
		                	riskInfo["alertMsg"]=returnJson.rtnMsg;
		                    nui.open({
		                        url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
		                        title: "投资指令/建议风险提示",
		                        width: 800,
		                        height: 422,
		                        onload: function () {
		                            var iframe = this.getIFrameEl();
		                            iframe.contentWindow.SetData(riskInfo,3);
		                        }
		                    });
		                }else{
		                    //风险提示框start
		                    nui.open({
		                        url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
		                        title: "投资指令/建议风险提示",
		                        width: 800,
		                        height: 380,
		                        onload: function () {
		                            var iframe = this.getIFrameEl();
		                            iframe.contentWindow.SetData(riskInfo,3);
		                        }
		                    });
		                    //风险提示框end
		                }
					}else{
						nui.alert("系统异常","系统提示");
					}
	            }
        	 });
		}
    </script>
</body>
</html>