<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-06-21 15:58:24
  - Description:正逆回购--买断式回购指令交易员指令详细页
-->
<head>
<title>指令/建议详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/sm/comm/instruct/instructDetail_znhg_comm.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/riskMgr/js/riskMgrComm.js"></script>
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
					<input name="instructInfo.lFirstSettleDate" class=	"nui-textbox" required="true" readonly/>
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
                <td align="right">占款天数：</td>
				<td>
					<input name="instructInfo.lContractPeriods" class="nui-textbox" readonly/>
				</td>
            </tr>
            <tr>
                <td align="right"><span style="color: red">*</span>首期结算金额（元）：</td>
                <td >    
                    <input name="instructInfo.enFullPriceAmount" class="nui-spinner" minValue="0" maxValue="10000000000000000000000" format="n2" required="true" readonly/>
                </td>
                <td align="right">到期结算金额（元）：</td>
				<td>
					<input name="instructInfo.enSettleAmount" class="nui-spinner" minValue="0" maxValue="10000000000000000000000" format="n2" readonly/>
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
                <td align="right"><span style="color: red">*</span>回购利率（%）：</td>
                <td >    
                    <input name="instructInfo.enRepoRate" class="nui-textbox" required="true" readonly/>
                </td>
                <td align="right">对方交易员：</td>
				<td>
					<input name="instructInfo.vcCounterpartyTrader" class="nui-textbox" readonly/>
				</td>
            </tr>
            <tr>
                <td align="right">回购利息（元）：</td>
				<td>
					<input name="instructInfo.enRepoInterest" class="nui-spinner" minValue="0" maxValue="10000000000000000000000" format="n2" readonly/>
				</td>
				<td align="right">中途付息：</td>
				<td>
					<input name="instructInfo.enMiddleInterest" class="nui-spinner" minValue="0" maxValue="10000000000000000000000" format="n2" readonly/>
				</td>
            </tr> 
            <tr>
				<td align="right" >询价交易员:</td>
				<td><input class="nui-textbox" name="instructInfo.lInquiryTrader" readonly/></td>
				<td align="right" >实际对手方:</td>
				<td><input class="nui-textbox"  name="instructInfo.lActuallyCounterParty"  style="width: 140px" readonly/></td>
			</tr>
            <tr>
				<td align="right" >中介:</td>
				<td><input class="nui-textbox" name="instructInfo.lIntermediaryAgent" readonly/></td>
				<td align="right" >对手方（类型）:</td>
				<td><input class="nui-dictcombobox"  name="instructInfo.lCounterPartyType" valueField="dictID" textField="dictName" dictTypeId="l_counter_party_type"   style="width: 140px" readonly/></td>
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
	        url="com.cjhxfund.ats.sm.inquiry.inquiryResultManage.getMortgageInfo.biz.ext"
	        class="nui-datagrid" style="width:100%;height:155px;"
	        allowSortColumn="false"
		    showPager="false"
		    enableHotTrack="false">
			<div property="columns">
				<div field="vcStockCode" width="120px" headerAlign="center" align="center" >债券代码</div>
				<div field="vcStockName" width="120px" headerAlign="center" align="center" >债券名称</div>
				<div field="enFaceAmount" width="100px" headerAlign="center" align="center" numberFormat="n4"><span style="color:red;">*</span>券面金额（万元）</div>
				<div field="enNetPriceInit" width="100px" headerAlign="center" align="center" numberFormat="n4"><span style="color:red;">*</span>首次净价</div>
				<div field="enFullPriceInit" width="100px" headerAlign="center" align="center" numberFormat="n4">首次全价</div>
				<div field="enNetPriceFinal" width="100px" headerAlign="center" align="center" numberFormat="n4" >到期净价</div>
				<div field="enFullPriceFinal" width="100px" headerAlign="center" align="center" numberFormat="n4" >到期全价</div>
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
	
    <div class="nui-toolbar" id="confirmInquiryInfo" style="display:none"> 
        <table class="nui-form-table" style="padding:0px; width:100%;" borderStyle="border:0;">
        	<tr>
        		<td align="center" style="text-align:center;" colspan="4">
        			<a class="nui-button" plain="false" iconCls="icon-tip" id="exactrisk" enabled="false" onclick="riskControlTrial()">风控试算</a>
        			<span style="display:inline-block;width:25px;"></span>
        			<a class="nui-button" plain="false" iconCls="icon-ok" id="confirm" enabled="false" onclick="investManagerConfirm()">确认</a>
        			<span style="display:inline-block;width:25px;"></span>
        			<a class="nui-button" plain="false" iconCls="icon-no" id="backConfirm" enabled="false" onclick="backTasks()">退回</a>
        			<span style="display:inline-block;width:25px;"></span>
        			<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow('close')">关闭</a>
        		</td>
        	</tr>
        </table>
	</div>    
    <div class="nui-toolbar" id="inputInquiryInfo" style=""> 
        <table class="nui-form-table" style="padding:0px; width:100%;" borderStyle="border:0;">
        	<tr>
        		<td align="center" style="text-align:center;" colspan="3">
        			<a class='nui-button' plain='false' iconCls="icon-edit" id="editOrCommit" enabled="false" onclick="editClick()">修改/提交</a>
        			<span style="display:inline-block;width:25px;"></span>
        			<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow('close')">关闭</a>
        		</td>
        	</tr>
        </table>
    </div>
    <div class="nui-toolbar" id="inquiryDetail" style="display:none"> 
        <table class="nui-form-table" style="padding:0px; width:100%;" borderStyle="border:0;">
        	<tr>
        		<td align="center" style="text-align:center;" colspan="3">
        			<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow('close')">关闭</a>
        		</td>
        	</tr>
        </table>
    </div>
	<script type="text/javascript">
    	nui.parse();
    	$("#instructDetail_grid .mini-buttonedit-button").remove();
    	var instruct_detail_from = new nui.Form("#instructDetail_grid");
    	var row = "";
    	var mortgage_info = nui.get("datagrid_mortgage_info");
    	var instructCheckUser = "";
    	var riskFlagParam = null; 
    	var lResultIdParam = null;
		var lRiskmgrIdParam = null;
		var workItemID = null;
		
    	function setFormData(data,webType){
    	debugger;
    		//跨页面传递的数据对象，克隆后才可以安全使用
    		row = nui.clone(data);
    		var instructDetail = nui.clone(data);
    		if(webType == "confirm"){
    			document.getElementById("confirmInquiryInfo").style.display = "";
    			document.getElementById("inputInquiryInfo").style.display = "none";
    			if(row.cIsValid=="1"){//在指令/建议状态为有效的前提下控制流程样式
				//流程处理状态:-2-询价结果待提交,-1-询价结果待确认,2A-预置指令/建议待激活,
				//4-待风控审批,5-待交易录单,6-待录单复核,7-待前台成交,8-前台已成交,9-后台已成交
					if(DateUtil.toNumStr(new Date())==row.lTradeDate){
						if(row.vcProcessStatus=="-1"){
							if(combiAuthorityJudgment(row.vcProductCode, row.vcCombiCode, "02")){	//拥有投资经理权限
								nui.get("confirm").enable();
								nui.get("backConfirm").enable();
								nui.get("exactrisk").enable();
							}
						}else if(row.vcProcessStatus=="3"){
							if(row.workitemid != null){			// 是否是待办参与人 
								nui.get("confirm").enable();
								nui.get("exactrisk").enable();
								nui.get("backConfirm").enable();
							}
						}
					}
				} 
    		}else if(webType == "detail"){
    			document.getElementById("inputInquiryInfo").style.display = "none";
    			document.getElementById("inquiryDetail").style.display = "";
    		}else{
    			if(row.cIsValid=="0"){
					if(row.vcProcessStatus=="-2"){
						if(getProductHandleByInstructrionInput(row.vcProductCode, row.vcCombiCode)){
							nui.get("editOrCommit").enable();
						}
					}
				}
    		}
    		
    		if(row.lFirstSettleDate != null){
				instructDetail["lFirstSettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lFirstSettleDate"].toString()),"yyyy-MM-dd");
			}
			if(row.lTradeDate != null){
				instructDetail["lTradeDate"] = nui.formatDate(DateUtil.numStrToDate(row["lTradeDate"].toString()),"yyyy-MM-dd");
			}
			if(row.lMaturitySettleDate != null){
				instructDetail["lMaturitySettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lMaturitySettleDate"].toString()),"yyyy-MM-dd");
			}
			instruct_detail_from.setData({instructInfo:instructDetail});
			// 指令id和指令来源
			var json = {lResultId:row.lResultId, instructResource:row.vcInstructSource};
			mortgage_info.load(json);
			
			// 3-二级债 其他为老机器猫
	        var validStatus = row.cIsValid;
	        if(validStatus=="1"){
				if(row.vcInstructSource=="3"){		
					if(row.vcProcessStatus ==5 && row.cIsValid==1){
						if (getProductHandleByDealEnter(row.vcProductCode)) {
							nui.get("confirm").enable();
							nui.get("updateEnterCheck").enable();
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
    	}
    	//投资经理确认询价结果
		function investManagerConfirm(){
			if(row.workitemid != null && row.workitemid != ""){		//修改后确认
				var checkResult = 1;	//1=确认，0=退回
				
				/**风控管理开始**/
			    if(row.instructSource!='2' && (row.vcBizType == "5" || row.vcBizType == "6") && judgeRiskTest(null, row) ){
			    	workItemID = row.workitemid;
					var returnJson = judgeRiskInfo(workItemID, null);	//判断是否有复核节点
					if(returnJson.rtnObject.rtnCode=='1' || returnJson.rtnObject.rtnCode=='2'){	//已经发起过风控流程 or 草稿状态的风控
						if(returnJson.riskInfo.cStatus=='2'){
							//finishInstructWorkitem(workItemID, '1', '');	//不校验风控
							checkRiskInfoApprove(workItemID, false);	//校验可用
						}else if(returnJson.workItemDetail.activityDefID=="manualActivity2A" && returnJson.riskInfo.cStatus!='5'){	//投资经理节点
							nui.alert("风控流程审批未通过，暂不能提交！");
						}else{
							checkRiskInfoApprove(workItemID);	//重新调用风控接口
						}
					}else if(returnJson.rtnObject.rtnCode=='-1'){	//投资经理不存在
						alert(returnJson.rtnObject.rtnMsg);	//不允许提交
					}else{	//不存在风控信息
						checkRiskInfoApprove(workItemID);	//重新调用风控接口
					}
					return;
				}
			    /**风控管理结束**/
				
		        var a = nui.loading("正在处理中,请稍等...","提示");
		        nui.ajax({
		            url: "com.cjhxfund.ats.sm.comm.TaskManager.approveAvailValidate.biz.ext",
		            type: "post",
		            contentType:'text/json',
		            data:{workItemID:row.workitemid, checkResult:checkResult, checkComments:""}, 
		            success: function (text) {
		            	nui.hideMessageBox(a);
		            	var returnJson = nui.decode(text);
		            	if(returnJson.exception == null){
							if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
					    		var alsertMsg = "";
					    		if(checkResult=="0"){
					    			if(returnJson.rtnMsg){
					    				alsertMsg = "</br>此单已退回！</br>退回原因："+returnJson.rtnMsg;
					    			}
					    			nui.alert("操作成功！"+alsertMsg,"系统提示",function(action){
						    			if(action == "ok"){
						    				window.CloseWindow("ok");
						    			}
					    			});
					    		}else{
					    			if(returnJson.rtnMsg){
					        			alsertMsg = "</br>【该投资建议/指令触发以下风控：</br>"+returnJson.rtnMsg+"】</br>";
					        		}
					        		nui.alert("审批成功"+alsertMsg,"系统提示",function(action){
						    			if(action == "ok"){
						    				window.CloseWindow("ok");
						    			}
					    			}); 
					    		}
					    		
							}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
								nui.alert("审批失败</br>"+returnJson.rtnMsg,"系统提示",function(action){
									if(action == "ok"){
					    				window.CloseWindow("ok");
					    			}
								});
								
							}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_NO_RCV_FR_O32%>"){
								nui.alert("审批成功"+"</br>"+returnJson.rtnMsg,"系统提示",function(action){
					    			if(action == "ok"){
					    				window.CloseWindow("ok");
					    			}
								}); 
							}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_RISK_VIOLATE_FORBID_CTRL%>"){
								nui.alert("审批失败,触发禁止风控,风控信息如下：</br>"+returnJson.rtnMsg,"系统提示",function(action){
					    			if(action == "ok"){
					    				window.CloseWindow("ok");
					    			}
								});
								
							}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT%>"){
								nui.alert("审批失败</br>"+returnJson.rtnMsg,"系统提示",function(action){
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
			}else {
			
				/**风控管理开始**/
				if(row.instructSource!='2' && (row.vcBizType == "5" || row.vcBizType == "6")&& judgeRiskTest(null, row)){
					var returnJson = judgeRiskInfo(null, row);	//判断是否存在风控、及是否有后续节点
					if(returnJson.rtnObject.rtnCode=='1' || returnJson.rtnObject.rtnCode=='2'){	//已经发起过风控流程
						if(returnJson.riskInfo.cStatus=='5'){
							//调用风控接口
							checkRiskInfoInquiryApprove(getRiskParam());
						}else if(returnJson.riskInfo.cStatus!='2'){
							//投资经理节点
							if(returnJson.riskInfo.cStatus=='0'){
								checkRiskInfoInquiryApprove(getRiskParam());
							}else{
								nui.alert("风控流程审批未通过，暂不能提交！");
							}
						}else{
							//finishInquiryWorkitem();	//不校验风控
							checkRiskInfoInquiryApprove(getRiskParam(), "false");
						}
					}else if(returnJson.rtnObject.rtnCode=='-1'){	
						alert(returnJson.rtnObject.rtnMsg);	//出错
					}else{	//不存在风控信息
						//调用风控接口
						checkRiskInfoInquiryApprove(getRiskParam());
					}
					return;
				}
				/**风控管理结束**/
			
				var a = nui.loading("正在处理中,请稍等...","提示");
				nui.ajax({
					url : "com.cjhxfund.ats.sm.inquiry.inquiryInstruction.investManagerConfirm.biz.ext",
					type : 'POST',
					data : {instructParameter:row},
					cache : false,
					contentType : 'text/json',
					success : function(text) {
						nui.hideMessageBox(a);
						var returnJson = nui.decode(text);
						if(returnJson.exception == null){
							if(returnJson.rtnCode == "<%= com.cjhxfund.commonUtil.Constants.ATS_SUCCESS %>"){
								var riskMsg = returnJson.riskMsg;
		            			if(riskMsg && riskMsg.isAgainstRisk){
		            				riskMsg["alertMsg"]="确认成功！";
		            				nui.open({
				                        url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
				                        title: "风控信息",
				                        width: 800,
				                        height: 422,
				                        onload: function () {
				                            var iframe = this.getIFrameEl();
				                            iframe.contentWindow.SetData(riskMsg,3);
				                        },
				                        ondestroy: function (action) {
				                            CloseWindow("ok");
				                        }
				                    });
		            			}else{
			            			nui.alert("确认成功！","提示",function(){
										CloseWindow("ok");
					                });
		            			}
				    		}else if(returnJson.rtnCode =="<%= com.cjhxfund.commonUtil.Constants.ATS_ORDER_NO_RCV_FR_O32 %>"){
				            	nui.alert(returnJson.rtnMsg,"提示");
				            	return;
				            }else if(returnJson.rtnCode == "<%= com.cjhxfund.commonUtil.Constants.ATS_ERROR %>") {
				    			var riskMsg = returnJson.riskMsg;
		            			if(riskMsg && riskMsg.isAgainstRisk){
		            				riskMsg["alertMsg"]="确认失败！";
		            				nui.open({
				                        url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
				                        title: "风控信息",
				                        width: 800,
				                        height: 422,
				                        onload: function () {
				                            var iframe = this.getIFrameEl();
				                            iframe.contentWindow.SetData(riskMsg,3);
				                        }
				                    });
		            			}else{
		            				nui.alert("确认失败！</br>"+returnJson.rtnMsg,"提示");
		            			}
				            }
						}else{
							nui.alert("系统异常，请联系管理员","提示");
						}
					}
				});
			}
		}
		
		/**风控管理开始**/
		function getRiskParam(){
			var parameter = nui.clone(row);
			parameter["callRiskType"]="3";//1-风控试算
			parameter["symbol"]=parameter.vcStockCode;//证券申报代码
			parameter["businClass"]="O";//2-银行间买断式业务
			parameter["exdestination"]="OTC";//交易场所：OTC-场外
			parameter["vcInvestType"]="1";//投资类型：1-可交易
			parameter["ordtype"]="2";//证券控制类型:1-金额控 、2-数量控、缺省按2-数量控
			parameter["vcFirstSettleMode"]="3";//结算方式（首次结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户)
			parameter["vcMaturitySettleMode"]="3";//结算方式（到期结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户
			parameter["timeinforce"] = 6;  //	6(指令有效模式，默认为0-Day：0 – Day，当日有效；1 – GTC，一直有效，直到完成或撤销；6 – GTD，到指定日前有效)
			parameter["judgeavailable"] = 1; //1(判断可用：0-不判；1-判)
    		parameter["judgerisk"] = 1;  //	1(判断风控：0-不判；1-判)
			var mortgages = mortgage_info.getData();
			var riskParam = {instructParameter:parameter, bonds: mortgages};
			
			return riskParam;
		}
		
		function subData(riskReturn, instructJson){
			var riskFlag = "";
			lResultIdParam = instructJson.instructParameter.lResultId;
			lRiskmgrIdParam = instructJson.instructParameter.lRiskmgrId;
			if(workItemID==null || workItemID==""){
				riskFlag = showRiskInfoInquiryApprove(riskReturn, instructJson);
			}else{
				riskFlag = showRiskInfoApprove(riskReturn, instructJson);
			}
			riskControl(riskFlag, instructJson);
		}
		function riskControl(riskFlag, instructJson){
			riskFlagParam = riskFlag;
        	if(riskFlag=='-1'){
        		return;
        	}else if(riskFlag=='1' || riskFlag=='2'){
        		if(workItemID==null || workItemID==""){
					finishInquiryWorkitem();
				}else{
					finishInstructWorkitem(workItemID, '1', '');
				}
        	}else if(riskFlag=='-2'){
        		startRiskProcessInstruct(lResultIdParam, lRiskmgrIdParam);
        	}
        }
        function finishInstructWorkitemFisish(){
        	if(riskFlagParam=='2'){
        		startRiskProcessInstruct(lResultIdParam, lRiskmgrIdParam);
        	}
			window.CloseWindow("ok");
        }
		function finishInquiryWorkitem(){
			var instructParameter = nui.clone(row);
			var a = nui.loading("正在处理中,请稍等...","提示");
			nui.ajax({
				url : "com.cjhxfund.ats.sm.inquiry.inquiryInstruction.investManagerConfirm.biz.ext",
				type : 'POST',
				data : {instructParameter:instructParameter},
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					nui.hideMessageBox(a);
					var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						if(returnJson.rtnCode == "<%= com.cjhxfund.commonUtil.Constants.ATS_SUCCESS %>"){
							var riskMsg = returnJson.riskMsg;
	            			if(riskMsg && riskMsg.isAgainstRisk){
	            				riskMsg["alertMsg"]="确认成功！";
	            				nui.open({
			                        url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
			                        title: "风控信息",
			                        width: 800,
			                        height: 422,
			                        onload: function () {
			                            var iframe = this.getIFrameEl();
			                            iframe.contentWindow.SetData(riskMsg,3);
			                        },
			                        ondestroy: function (action) {
			                            CloseWindow("ok");
			                        }
			                    });
	            			}else{
		            			nui.alert("确认成功！","提示",function(){
									finishInstructWorkitemFisish();
				                });
	            			}
			    		}else if(returnJson.rtnCode =="<%= com.cjhxfund.commonUtil.Constants.ATS_ORDER_NO_RCV_FR_O32 %>"){
			            	nui.alert(returnJson.rtnMsg,"提示",function(){
									CloseWindow("ok");
				                });
			            	return;
			            }else if(returnJson.rtnCode == "<%= com.cjhxfund.commonUtil.Constants.ATS_ERROR %>") {
			    			var riskMsg = returnJson.riskMsg;
	            			if(riskMsg && riskMsg.isAgainstRisk){
	            				riskMsg["alertMsg"]="确认失败！";
	            				nui.open({
			                        url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
			                        title: "风控信息",
			                        width: 800,
			                        height: 422,
			                        onload: function () {
			                            var iframe = this.getIFrameEl();
			                            iframe.contentWindow.SetData(riskMsg,3);
			                        }
			                    });
	            			}else{
	            				nui.alert("确认失败！</br>"+returnJson.rtnMsg,"提示");
	            			}
			            }
					}else{
						nui.alert("系统异常，请联系管理员","提示");
					}
				}
			});
		}
        /**风控管理结束**/
		
		// 退回
		function backTasks(){
			nui.open({
   				url : nui.context + "/inquiry/inquiryResultManage/inquiryInstructBackReason.jsp",
   				title : "询价退回",
   				width : 500,
   				height : 200,
   				onload : function() {
   					var iframe = this.getIFrameEl();
   					iframe.contentWindow.setData(row);
   				},
   				ondestroy : function(action) {
   					var iframe = this.getIFrameEl();
   					var returnJson = iframe.contentWindow.getData();
   					backReturnJson = mini.clone(returnJson);    //必须。克隆数据。
   					window.CloseWindow("ok");
   				}
			});
		}
		
		function riskControlTrial(){
			var parameter = nui.clone(row);
			console.log(row);
			parameter["callRiskType"]="1";//1-风控试算
			parameter["symbol"]=parameter.vcStockCode;//证券申报代码
			parameter["businClass"]="O";//2-银行间业务
			parameter["exdestination"]="OTC";//交易场所：OTC-场外
			parameter["vcInvestType"]="1";//投资类型：1-可交易
			parameter["ordtype"]="2";//证券控制类型:1-金额控 、2-数量控、缺省按2-数量控
			parameter["vcFirstSettleMode"]="3";//结算方式（首次结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户)
			parameter["vcMaturitySettleMode"]="3";//结算方式（到期结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户
			
			parameter["timeinforce"] = 6;  //	6(指令有效模式，默认为0-Day：0 – Day，当日有效；1 – GTC，一直有效，直到完成或撤销；6 – GTD，到指定日前有效)
			parameter["judgeavailable"] = 1; //1(判断可用：0-不判；1-判)
    		parameter["judgerisk"] = 1;  //	1(判断风控：0-不判；1-判)

			var mortgages = mortgage_info.getData();
			var param = {instructParameter:parameter, bonds: mortgages};
			var url = "com.cjhxfund.ats.sm.inquiry.inquiryResultManage.inquiryCheckInstructRisk.biz.ext";
			if(parameter.lProcessinstId != null && parameter.lProcessinstId != ""){
				url = "com.cjhxfund.ats.sm.comm.InstructionManager.approveRiskTrial.biz.ext";
				param = {lProcessInstID:parameter.lProcessinstId, bonds: mortgages};
			}
			//return;
			var a = nui.loading("正在处理中,请稍等...","提示");
			nui.ajax({
			 	url: url,
		        type: 'POST',
		        data: param,
		        cache: false,
		        contentType: 'text/json',
		        success: function (text) {
		        	nui.hideMessageBox(a);
		        	var returnJson = nui.decode(text);
					if(returnJson.exception == null){
		                var riskInfo = returnJson.riskMsg;
		               if (returnJson.rtnCode == "<%= com.cjhxfund.commonUtil.Constants.ATS_SUCCESS %>"){
		                    if(returnJson.rtnMsg!=null){
		                    	nui.alert(returnJson.rtnMsg,"系统提示");
		                    }else{
		                    	nui.alert("风控试算通过!","系统提示");
		                    }
		                }else if(returnJson.rtnCode =="<%= com.cjhxfund.commonUtil.Constants.ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT %>"){
		                	nui.alert(returnJson.rtnMsg,"投资指令/建议风险提示");//可用不足
		                }else if(returnJson.rtnCode == "203"){
		                	nui.alert(returnJson.rtnMsg,"系统提示");//风控校验失败
		                }else if(returnJson.rtnCode == "301"){
		                	//风险提示框start
		                	riskInfo["alertMsg"]=returnJson.rtnMsg;
		                    nui.open({
		                        url:  nui.context +"/fix/riskControlDetailList.jsp",
		                        title: "投资指令/建议风险提示",
		                        width: 800,
		                        height: 422,
		                        onload: function () {
		                            var iframe = this.getIFrameEl();
		                            iframe.contentWindow.SetData(riskInfo,3);
		                        }
		                    });
		                    //风险提示框end
		                }else{
		                    //风险提示框start
		                    nui.open({
		                        url:  nui.context +"/fix/riskControlDetailList.jsp",
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
		
		//查询投资经理权限用户，并判断当前用户是否拥有投资经理权限
		function combiAuthorityJudgment(vcProductCode, vcCombiCode, relateType) {
			var url = "com.cjhxfund.commonUtil.productUserRight.getUsersByProductCombiAndRelateTy.biz.ext";
			var result = false;
			nui.ajax({
				url : url,
				type : 'POST',
				data : {
					productCode : vcProductCode,
					combiCode : vcCombiCode,
					relateType : relateType
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
    	//点击修改/提交
		function editClick(){
   			window.CloseWindow("ok");
		}
    	function getProductHandleByInstructrionInput(vcProductCode,vcCombiCode) {
			var url = "";
			var result = false;
			url = "com.cjhxfund.commonUtil.productUserRight.getUsersByProductCombiAndRelateTy.biz.ext";
			nui.ajax({
				url : url,
				type : 'POST',
				data : {
					productCode : vcProductCode,
					combiCode : vcCombiCode,
					relateType : "03"
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
		// 根据序号查指令信息
		function setResultNo(lInstructNo){
    		// 按钮显示
			document.getElementById("confirmInquiryInfo").style.display = "none";
			document.getElementById("inputInquiryInfo").style.display = "none";
			document.getElementById("inquiryDetail").style.display = "";
    		var params = {lResultNo:lInstructNo};
    		var a = nui.loading("正在处理中,请稍等...","提示");
    		nui.ajax({
		    	url: "com.cjhxfund.ats.sm.inquiry.inquiryResultManage.getInquiryResultInfoByResultNo.biz.ext",
		      	type: 'POST',
		      	data: {params:params},
		      	contentType: 'text/json',
		      	success: function(text){
		      		nui.hideMessageBox(a);
		      		var returnJson = nui.decode(text.inquiryResultInfo);
		      		if(returnJson.length>0){
		      			var row = returnJson[0];
			    		if(row.lFirstSettleDate != null){
							row["lFirstSettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lFirstSettleDate"].toString()),"yyyy-MM-dd");
						}
						if(row.lTradeDate != null){
							row["lTradeDate"] = nui.formatDate(DateUtil.numStrToDate(row["lTradeDate"].toString()),"yyyy-MM-dd");
						}
						if(row.lMaturitySettleDate != null && row.lMaturitySettleDate != 0){
							row["lMaturitySettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lMaturitySettleDate"].toString()),"yyyy-MM-dd");
						}else{
							row["lMaturitySettleDate"] = "";
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
						if(lResultId != row.lResultId){
			    			var json = {lInquiryNo:row.lInquiryNo};
			    			if(row.lResultId != null){
			    				json["lResultId"] = row.lResultId;
			    				json["instructResource"] = row.vcInstructSource;
			    			}
			    			mortgage_info.load(json);
			    		}
		      		}
		      	}
	 		});
    	}
    	
    	
		function getEditOrCommitValue(){
			backReturnJson = "1";
			return backReturnJson;
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
    </script>
</body>
</html>