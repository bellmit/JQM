<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-06-21 15:58:24
  - Description:正逆回购--协议式回购指令交易员指令详细页
-->
<head>
<title>指令/建议详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/sm/comm/instruct/instructDetail_znhg_comm.js"></script>
    
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
    </style>
</head>
<body>
	<div id="instructDetail_grid">
        <table id="instruct_detail_from" class="nui-form-table" style="width:100%; heiht:100%">
            <tr>
                <td align="right"><span style="color: red">*</span>产品名称：</td>
                <td >    
                    <input name="instructInfo.vcProductName" class="nui-textbox" required="true" readonly/>
                </td>
                <td align="right"><span style="color: red">*</span>业务类别：</td>
                <td >    
                    <input name="instructInfo.vcBizType" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="bizTypeRepurchase" required="true" readonly/>
                </td>
            </tr>
            <tr>
                <td align="right"><span style="color: red">*</span>组合名称：</td>
                <td >    
                    <input name="instructInfo.vcCombiName" class="nui-textbox" required="true" readonly/>
                </td>
                <td align="right"><span style="color: red">*</span>交易日期：</td>
                <td >    
                    <input name="instructInfo.lTradeDate" class="nui-textbox" required="true" readonly/>
                </td>
            </tr>
            <tr>
                <td align="right"><span style="color: red">*</span>回购天数：</td>
                <td >    
                    <input name="instructInfo.lRepoDays" class="nui-textbox" required="true" readonly/>
                </td>
                <td align="right">首次结算日期：</td>
				<td>
					<input name="instructInfo.lFirstSettleDate" class="nui-textbox" required="true" readonly/>
				</td>
            </tr>
            <tr>
                <td align="right"><span style="color: red">*</span>委托方向：</td>
                <td >    
                    <input name="instructInfo.vcEntrustDirection" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="entrustDirectionRepurchase" required="true" readonly/>
                </td>
                <td align="right">到期结算日期：</td>
				<td>
					<input name="instructInfo.lMaturitySettleDate" class="nui-textbox" required="true" readonly/>
				</td>
            </tr>
            <tr>
                <td align="right"><span style="color: red">*</span>清算速度：</td>
                <td >    
                    <input name="instructInfo.vcSettleSpeed" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="settleSpeed" required="true" readonly/>
                </td>
                <td align="right">到期结算金额（元）：</td>
				<td>
					<input name="instructInfo.enSettleAmount" class="nui-spinner" minValue="0" maxValue="10000000000000000000000" format="n2" readonly/>
				</td>
            </tr>
            <tr>
                <td align="right"><span style="color: red">*</span>交易金额（万元）：</td>
                <td id="oldEnFaceAmount">    
                    <input name="instructInfo.enFaceAmount1" class="nui-spinner" minValue="0" maxValue="10000000000000000000000" format="n4" required="true" readonly/>
                </td>
                <td id="newEnFaceAmount">    
                    <input name="instructInfo.enFaceAmount" class="nui-spinner" minValue="0" maxValue="10000000000" format="n4" required="true" readonly/>
                </td>
                <td align="right">回购利息（元）：</td>
				<td>
					<input name="instructInfo.enRepoInterest" class="nui-spinner" minValue="0" maxValue="10000000000000000000000" format="n2" readonly/>
				</td>
            </tr>
            <tr>
                <td align="right"><span style="color: red">*</span>交易对手：</td>
                <td >    
                    <input name="instructInfo.vcCounterpartyName" class="nui-textbox" required="true" readonly/>
                </td>
                <td align="right">对手主体机构：</td>
				<td>
					<input name="instructInfo.vcCounterpartyOrgan" class="nui-textbox" readonly/>
				</td>
            </tr>
            <tr>
                <td align="right"><span style="color: red">*</span>报价方式：</td>
                <td >    
                    <input name="instructInfo.vcQuoteMode" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="quoteMode" required="true" readonly/>
                </td>
                <td align="right">对方交易员：</td>
				<td>
					<input name="instructInfo.vcCounterpartyTrader" class="nui-textbox" readonly/>
				</td>
            </tr>
            <tr>
                <td id="enRepoRateText" align="right"><span style="color: red">*</span>回购利率（%）：</td>
                <td id="enWeightingText" align="right"><span style="color: red">*</span>加点(bp)：</td>
                <td id="enRepoRateValue">    
                    <input name="instructInfo.enRepoRate" class="nui-textbox" required="true" readonly/>
                </td>
                <td id="enWeightingValue">    
                    <input name="instructInfo.enWeightingValue" class="nui-textbox" required="true" readonly/>
                </td>
                <!-- <td align="right">占款天数：</td>
				<td>
					<input name="instructInfo.lContractPeriods" class="nui-textbox" readonly/>
				</td> -->
				<td align="right">券面金额合计（万元）：</td>
				<td>
					<!-- <input name="instructInfo.enFaceAmountTotal" class="nui-textbox" readonly/> -->
					<input name="instructInfo.enFaceAmountTotal" class="nui-spinner" minValue="0" maxValue="10000000000000000000000" format="n4" required="true" readonly/>
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
    
    <!-- 质押券信息 -->
    <div title="质押券信息" id="mortgageInfoPanel" class="nui-panel" iconCls="icon-edit" style="width:100%;" 
   				showCollapseButton="true" collapseOnTitleClick="true">
		<div id="datagrid_mortgage_info" dataField="mortgageInfos" 
	        url="com.cjhxfund.ats.sm.comm.InstructionManager.getJqmAndSmMortgageInfo.biz.ext"
	        class="nui-datagrid" style="width:100%;height:155px;"
	        allowSortColumn="false"
		    showPager="false"
		    enableHotTrack="false">
			<div property="columns">
				<div field="vcStockCode" width="120px" headerAlign="center" align="center" >债券代码</div>
				<div field="vcStockName" width="120px" headerAlign="center" align="center" >债券名称</div>
				<div field="enFaceAmount" width="100px" headerAlign="center" align="center" numberFormat="n4"><span style="color:red;">*</span>券面金额（万元）</div>
				<div name="enMortagageRatio" field="enMortagageRatio" width="80px" headerAlign="center" align="center"><span style="color:red;">*</span>质押比例（％）</div>	
				<div field="enCbValueNetValue" width="85px" headerAlign="center" align="center" numberFormat="n4">净价（T-1）</div>
				<div field="enCbValueAllValue" width="85px" headerAlign="center" align="center" numberFormat="n4">全价（T-1）</div>
                <div field="vcDepository" width="85px" headerAlign="center" align="center" renderer="depository">托管机构</div>
				<div field="vcBondAppraise" width="85px" headerAlign="center" align="center" renderer="renderBondAppraise">债项评级</div>
				<div field="vcIssueAppraise" width="85px" headerAlign="center" align="center" renderer="renderIssueAppraise">主体评级</div>
				<div field="vcBondAppraiseOrgan" width="85px" headerAlign="center" align="center" renderer="renderBondAppraiseOrgan">评级机构</div>
                <div field="lRatingForecast" width="85px" headerAlign="center" align="center" renderer="lRatingForecastRD">评级展望</div>
                <div field="vcIssueProperty" headerAlign="center" align="center" width="100px" renderer="atsFmIssueProperty">发行人性质</div>

			</div>
		</div>
    </div>    
	
    <div class="nui-toolbar" id="confirmInstructInfo" style="border:0;"> 
        <table class="nui-form-table" style="padding:0px; width:100%;" borderStyle="border:0;">
        	<tr>
        		<td align="center" style="text-align:center;" colspan="3">
        			<a class='nui-button' plain='false' iconCls="icon-ok" id="confirm" enabled="false" onclick="goConfirm_tg()">确认</a>
        			<span style="display:inline-block;width:25px;"></span>
        			<a class='nui-button' plain='false' iconCls="icon-no" id="backConfirm" enabled="false" onclick="goBack()">退回</a>
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
	<script type="text/javascript">
    	nui.parse();
    	$("#instructDetail_grid .mini-buttonedit-button").remove();
    	var instruct_detail_from = new nui.Form("#instructDetail_grid");
    	var row = "";
    	var workItemID = "";
    	var mortgage_info = nui.get("datagrid_mortgage_info");
    	
    	function setFormData(data){
    		//跨页面传递的数据对象，克隆后才可以安全使用
    		row = nui.clone(data);
    		if(row.lFirstSettleDate != null){
				row["lFirstSettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lFirstSettleDate"].toString()),"yyyy-MM-dd");
			}
			if(row.lTradeDate != null){
				row["lTradeDate"] = nui.formatDate(DateUtil.numStrToDate(row["lTradeDate"].toString()),"yyyy-MM-dd");
			}
			if(row.lMaturitySettleDate != null){
				row["lMaturitySettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lMaturitySettleDate"].toString()),"yyyy-MM-dd");
			}
			if(row.vcInstructSource=="1" || row.vcInstructSource=="2"){
				document.getElementById("newEnFaceAmount").style.display = "none";
				row.enFaceAmount1 = row.enFaceAmount;
			}else{
				document.getElementById("oldEnFaceAmount").style.display = "none";
			}
			instruct_detail_from.setData({instructInfo:row});
			
			// 报价方式显示
			if(row.enRepoRate !="" && row.enRepoRate !=null){		
				document.getElementById("enWeightingValue").style.display = "none";
				document.getElementById("enWeightingText").style.display = "none";
			}else{
				document.getElementById("enRepoRateValue").style.display = "none";
				document.getElementById("enRepoRateText").style.display = "none";				
			}
		
			// 质押式取券面金额显示回购金额，买断式取全价金额显示首期结算金额
			if(row.VC_BIZ_TYPE == "6"){
				mortgage_info.hideColumn("enMortagageRatio");
				mortgage_info.showColumn("enNetPriceInit");
				mortgage_info.showColumn("enFullPriceInit");
				mortgage_info.showColumn("enNetPriceFinal");
				mortgage_info.showColumn("enFullPriceFinal");
				
			}else{
				mortgage_info.showColumn("enMortagageRatio");
    			mortgage_info.hideColumn("enNetPriceInit");
    			mortgage_info.hideColumn("enFullPriceInit");
    			mortgage_info.hideColumn("enNetPriceFinal");
    			mortgage_info.hideColumn("enFullPriceFinal");
			}
			// 指令id和指令来源
			var json = {lResultId:row.lResultId, instructResource:row.vcInstructSource};
			mortgage_info.load(json);					
			
			// 3-二级债 其他为老机器猫
			if(row.cIsValid == "1"){
				if(row.vcInstructSource=="3"){
					if(row.vcProcessStatus == "2"|| row.vcProcessStatus == "3"){
						if(row.workitemid){
							nui.get("confirm").enable();
							nui.get("backConfirm").enable();
						}
					}
				}else if(row.vcInstructSource=="1" || row.vcInstructSource=="2"){	// 机器猫指令	
					var hasPermission = false;
					if(row.vcProcessStatus == "2"){//流程在投顾复核确认
						var userIdRelaType07All = row.userIdRelaType07All!=null?row.userIdRelaType07All:"";//07-产品与投顾确认权限(全部人员)
						var userIdRelaType07 = row.userIdRelaType07!=null?row.userIdRelaType07:"";//07-产品与投顾确认权限(过滤自己)
						var userIdRelaTypeA1 = row.userIdRelaTypeA1!=null?row.userIdRelaTypeA1:"";//A1-投顾录入确认可为同一人员
						if(userIdRelaType07All!=null && userIdRelaType07All!=""){//设置了复核人员
							var userIdRelaType07Arr = userIdRelaType07.split(",");//默认过滤自己
							if(userIdRelaTypeA1!=null && userIdRelaTypeA1!=""){//可为同一人员
								userIdRelaType07Arr = userIdRelaType07All.split(",");
							}
							for(var j=0; j<userIdRelaType07Arr.length; j++){
								var userIdTemp = userIdRelaType07Arr[j];
								if(userIdTemp==userId){
									hasPermission = true;
									break;
								};
							};
						}
						if(hasPermission==true && row.cIsValid=="1"){
							nui.get("confirm").enable();
						}
					}else if(row.vcProcessStatus=="3"){//投资经理确认权限
						//若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
						var userIdRelaType02 = row.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
						if(userIdRelaType02!=null && userIdRelaType02!=""){
							var userIdRelaType02Arr = userIdRelaType02.split(",");
							for(var i=0; i<userIdRelaType02Arr.length; i++){
								var userIdTemp = userIdRelaType02Arr[i];
								if(userIdTemp==userId){
									hasPermission = true;
									break;
								};
							};
						}
						if(hasPermission==true && row.cIsValid=="1"){
							nui.get("confirm").enable();
							nui.get("backConfirm").enable();
						}
					}
				}
			}
			
			workItemID = row.workitemid;
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
						if(row.lMaturitySettleDate != null){
							row["lMaturitySettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lMaturitySettleDate"].toString()),"yyyy-MM-dd");
						}
						if(row.vcInstructSource=="1" || row.vcInstructSource=="2"){
							document.getElementById("newEnFaceAmount").style.display = "none";
							row.enFaceAmount1 = row.enFaceAmount;
						}else{
							document.getElementById("oldEnFaceAmount").style.display = "none";
						}
						instruct_detail_from.setData({instructInfo:row});
						// 报价方式显示
						if(row.enRepoRate !="" && row.enRepoRate !=null){		
							document.getElementById("enWeightingValue").style.display = "none";
							document.getElementById("enWeightingText").style.display = "none";
						}else{
							document.getElementById("enRepoRateValue").style.display = "none";
							document.getElementById("enRepoRateText").style.display = "none";				
						}
						
						// 质押式取券面金额显示回购金额，买断式取全价金额显示首期结算金额
						if(row.VC_BIZ_TYPE == "6"){
							mortgage_info.hideColumn("enMortagageRatio");
							mortgage_info.showColumn("enNetPriceInit");
							mortgage_info.showColumn("enFullPriceInit");
							mortgage_info.showColumn("enNetPriceFinal");
							mortgage_info.showColumn("enFullPriceFinal");
							
						}else{
							mortgage_info.showColumn("enMortagageRatio");
			    			mortgage_info.hideColumn("enNetPriceInit");
			    			mortgage_info.hideColumn("enFullPriceInit");
			    			mortgage_info.hideColumn("enNetPriceFinal");
			    			mortgage_info.hideColumn("enFullPriceFinal");
						}
						// 指令id和指令来源
						var json = {lResultId:row.lResultId, instructResource:row.vcInstructSource};
						mortgage_info.load(json);
						
						// 3-二级债 其他为老机器猫
						if(row.cIsValid == "1"){
							if(row.vcInstructSource=="3"){
								if(row.vcProcessStatus == "2"|| row.vcProcessStatus == "3"){
									if(row.workitemid){
										nui.get("confirm").enable();
										nui.get("backConfirm").enable();
									}
								}
							}else if(row.vcInstructSource=="1" || row.vcInstructSource=="2"){	// 机器猫指令	
								var hasPermission = false;
								if(row.vcProcessStatus == "2"){//流程在投顾复核确认
									var userIdRelaType07All = row.userIdRelaType07All!=null?row.userIdRelaType07All:"";//07-产品与投顾确认权限(全部人员)
									var userIdRelaType07 = row.userIdRelaType07!=null?row.userIdRelaType07:"";//07-产品与投顾确认权限(过滤自己)
									var userIdRelaTypeA1 = row.userIdRelaTypeA1!=null?row.userIdRelaTypeA1:"";//A1-投顾录入确认可为同一人员
									if(userIdRelaType07All!=null && userIdRelaType07All!=""){//设置了复核人员
										var userIdRelaType07Arr = userIdRelaType07.split(",");//默认过滤自己
										if(userIdRelaTypeA1!=null && userIdRelaTypeA1!=""){//可为同一人员
											userIdRelaType07Arr = userIdRelaType07All.split(",");
										}
										for(var j=0; j<userIdRelaType07Arr.length; j++){
											var userIdTemp = userIdRelaType07Arr[j];
											if(userIdTemp==userId){
												hasPermission = true;
												break;
											};
										};
									}
									if(hasPermission==true && row.cIsValid=="1"){
										nui.get("confirm").enable();
									}
								}else if(row.vcProcessStatus=="3"){//投资经理确认权限
									//若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
									var userIdRelaType02 = row.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
									if(userIdRelaType02!=null && userIdRelaType02!=""){
										var userIdRelaType02Arr = userIdRelaType02.split(",");
										for(var i=0; i<userIdRelaType02Arr.length; i++){
											var userIdTemp = userIdRelaType02Arr[i];
											if(userIdTemp==userId){
												hasPermission = true;
												break;
											};
										};
									}
									if(hasPermission==true && row.cIsValid=="1"){
										nui.get("confirm").enable();
										nui.get("backConfirm").enable();
									}
								}
							}
						}
						
						workItemID = row.workitemid;
		      		}
		      	}
	 		});
    	}

    </script>
</body>
</html>