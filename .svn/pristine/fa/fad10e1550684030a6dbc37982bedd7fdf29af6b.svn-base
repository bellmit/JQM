<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-09-03 14:27:05
  - Description:当日指令/建议（指令/建议跟踪）
-->
<head>
	<title>当日指令/建议</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/css/instruct.css"/>
    <script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script> 

</head>
<body style="height:100%; width:100%; overflow:hidden; margin:0;padding:0;">
<div id="layout1" class="mini-layout" style="width:100%; height:100%;"  borderStyle="border:0px;">
	<div>
		<!-- 查询条件开始 -->
		<div class="search-condition">
		   <div class="list">
		   		<!-- 业务标签:当日指令/建议 -->
		   		<input class="nui-hidden" id="queryType" name="queryType" value="todayInstruction"/>
				<!-- 委托方向:01-买入  02–卖出  -->
				<input class="nui-hidden" id="entrustDirection" name="entrustDirection" value="'3','4'"/>
				<!-- 指令/建议有效状态:1-有效, 2-无效-已修改   3-无效-已撤销    4-无效-被退回  -->
				<input class="nui-hidden" id="cIsValid" name="cIsValid" value="1,3,4"/>
			    <div id="form_today_instruct" class="nui-form" style="padding:2px;height:10%;max-width:100%" align="left">
	                <table id="instruct_follow_condition" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
	                	<tr>
	                		<td width="60px" align="right">
								产品名称:
	                        </td>
	                        <td colspan="1" width="20%" align="left">
	                            <input id="vcProductCode" class="nui-buttonedit" name="vcProductCode" emptyText="全部" showClose="true" oncloseclick="onCloseClick" onbuttonclick="ButtonClickGetFundName_todayInstruct" style="width:95%"/>
	                        </td>
							<td width="60px" align="right">委托方向:</td>
							<td colspan="1" width="20%" align="left">
								<input class="nui-dictcombobox" id="vcEntrustDirection" name="vcEntrustDirection" 
									valueField="dictID" textField="dictName" dictTypeId="entrustDirectionTransaction" 
									emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
							</td>
							<td width="60px" align="right">业务类别:</td>
							<td colspan="1" width="20%" align="left">
								<input class="nui-dictcombobox" id="vcBizType" name="vcBizType" multiSelect="true"
									valueField="dictID" textField="dictName" dictTypeId="bizTypeTransaction" 
									emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
							</td>
							<td></td><td></td>
						</tr>
						<tr>
							<td class="form_label" width="60px" align="right">交易日期:</td>
							<td colspan="1" width="20%" align="left">
								<input class="nui-datepicker" name="lTradeDateMin" id="lTradeDateMin" style="width:45%;"/>
	                    		<span style="width:5%;">-</span>
								<input class="nui-datepicker" name="lTradeDateMax" id="lTradeDateMax" style="width:45%;" />
							</td>
							<!-- <td width="60px" align="right">指令/建议序号:</td>
							<td colspan="1" width="20%" align="left">
								<input class="nui-textbox" id="instructNo" name="instructNo" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
							</td> -->
							<td width="60px" align="right">交易状态:</td>
							<td colspan="1" width="20%" align="left">
								<input class="nui-combobox" id="instructValid"
		                           name="instructValid"
		                           textField="text"
		                           valueField="cIsValid"
		                           data="[{cIsValid: '1', text: '有效'}, {cIsValid: '3', text: '无效-已撤销'}, {cIsValid: '4', text: '无效-被退回'}]"
		                           multiSelect="true"
		                           emptyText="全部"
		                           style="width:95%"
		                           oncloseclick="onCloseClick"
		                           showClose="true"/>
		                	</td>
		                	<td align="right" width="60px">
		                		<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
		                	</td>
		                	<td colspan="1" width="20%" align="left">
								<input class='nui-button' plain='false' text="重置" iconCls="icon-reset" onclick="reset()"/>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<a class="nui-menubutton " plain="false" menu="#popupMenu"
	                               id="searchCond"
	                               name="searchCond"
	                               data-options='{formId:"form_today_instruct"}'
	                               iconCls="icon-add">保存此搜索条件</a>
	                            <ul id="popupMenu" class="mini-menu" style="display:none;width:250px;"></ul>
		                	</td>
						</tr>
					</table>
				</div>
		  	</div>
	   	</div>
		<%-- 查询条件结束!!! --%>
		
		<%-- 列表操作工具开始... --%>
	   <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	    	<table border="0" cellpadding="0" cellspacing="0" style="width:100%;table-layout:fixed;">
	            <tr>
	                <td style="width:50%;">
	                  	<a id="deal" enabled="false" class='nui-button' plain='false' iconCls="icon-ok" onclick="batchDeal()">录单确认</a>
	                  	<a id="check" enabled="false" class='nui-button' plain='false' iconCls="icon-ok" onclick="batchConfirm()">录单复核</a>
	                  	<a id="rollback" enabled="false" class='nui-button' plain='false'  iconCls="icon-undo" onclick="batchRollbackDealEntering()">回退</a>
	                  	<a id="viewFlowChart" enabled="false" class='nui-button' plain='false' iconCls="icon-ok" onclick="viewFlowChart()">查看流程图</a>
						<a class='nui-button' plain='false' iconCls="icon-download" id="export_todayInstruct_bb" onclick="exportBbExcel()">导出本币接口文件</a>
	                  	<!-- 
	                  	<a class='nui-button' plain='false' iconCls="icon-download" id="export_todayInstruct" onclick="exportExcel()">导出指令/建议</a>
	                  	 -->
	                </td>
	                <td style="width:50%;" align="right">
	                    <a class='nui-button' plain='false' iconCls="icon-reload" onclick="autoRefreshFun()">刷新</a>
	                    <input id="autoRefresh" class="nui-combobox" style="width:90px;" 
		                    value="300" showNullItem="false" allowInput="false"
		                    data="[
						    { id: 0, text: '不自动刷新' },
						    { id: 15, text: '每15秒刷新' },
						    { id: 30, text: '每30秒刷新' },
							{ id: 60, text: '每1分刷新' },
							{ id: 120, text: '每2分刷新' },
							{ id: 180, text: '每3分刷新' },
							{ id: 300, text: '每5分刷新' },
							{ id: 600, text: '每10分刷新' },
							{ id: 1200, text: '每20分刷新' },
							{ id: 1800, text: '每30分刷新' }]"/>&nbsp;&nbsp;
	            	</td>
	            </tr>
	        </table>
	    </div>
	    
	    <%-- 列表操作工具结束... --%>
	    <div class="nui-fit" style="width:100%;height:100%;overflow:hidden;">
		    <div id="treegrid_todays_instruct" class="nui-treegrid" style="width:100%;height:100%;"
				 url="com.cjhxfund.ats.sm.comm.InstructionManager.queryRightInstructInfos.biz.ext" 
				 dataField="insructInfos" treeColumn="lInstructNo"
				 showPager="true" pageSize="10" frozenStartColumn="0" frozenEndColumn="6"
				 showTreeIcon="false" showTreeLines="false" multiSelect="true"
				 onselectionchanged="selectionchanged" showReloadButton="false"
				 onbeforeload="onBeforeTreeLoad"
				 pagerButtons="#prompt_todays">
			    <div property="columns">
			    	<div type="checkcolumn" ></div>
			    	<div name="action" width="60px" align="center" headerAlign="center" headerallowSort="true" renderer="value">操作</div>
		            <!--<div field="cIsValid" headerAlign="center" width="85px" renderer="renderInstructStatus">
		                指令/建议状态
		            </div>
		            <div field="vcRiskApproveStatus" headerAlign="center" width="85px" renderer="renderRiskApproveStatus">
		                风控审批状态
		            </div>
		           <!-- <div field="vcInstructType" headerAlign="center" width="85px" renderer="renderInstructType">
		                指令/建议类型
		            </div>-->
		            <div field="vcProductName" headerAlign="center" width="130px">
		               产品名称
		            </div>
		            <div field="vcCombiName" headerAlign="center" width="120px">
		                组合名称
		            </div>
		            <div field="vcSettleSpeed" headerAlign="center" width="70px" renderer="renderSettleSpeed">
		                清算速度
		            </div>
		            <div field="vcBizType" headerAlign="center" width="120px" renderer="renderBizType">
		                业务类别
		            </div>
		            <div field="vcEntrustDirection" headerAlign="center" width="85px" renderer="renderEntrustDirection">
		                委托方向
		            </div>
		            <div field="vcCounterpartyName" headerAlign="center" width="140px">
		                交易对手
		            </div>
		            <div field="vcStockCode" headerAlign="center" width="85px">
		                债券代码
		            </div>
		            <div field="vcStockName" headerAlign="center" width="110px">
		                债券名称
		            </div>
		            <!-- <div field="vcMarket" headerAlign="center" width="85px" renderer="renderMarket">
		                交易市场
		            </div> -->
		            <div field="enFaceAmount" headerAlign="center" numberFormat="n2" align="right" width="100px">
		                券面金额（万元）
		            </div>
		            <div field="lIssueDate" headerAlign="center" width="110px">
		                投资指令/建议录入日期
		            </div>
		            <div field="lTradeDate" headerAlign="center" width="85px">
		                交易日
		            </div>
		            <div field="lFirstSettleDate" headerAlign="center" width="85px">
		                结算日
		            </div>
		            <div field="enNetPrice" headerAlign="center" align="right" width="85px">
		                指令/建议净价
		            </div>
		            <div field="enFullPrice" headerAlign="center" align="right" width="85px">
		               指令/建议全价
		            </div>
		            <div field="enMaturityYield" headerAlign="center" align="right" width="120px">
		                指令/建议到期收益率（%）
		            </div>
		            <div field="enOptionYield" headerAlign="center" align="right" width="120px">
		                指令/建议行权收益率（%）
		            </div>
		            <div field="tInitiateTime" headerAlign="center" renderer="initiateRenderReview" width="200px">
		                投资指令/建议录入时间
		            </div>
		            <!--<div field="tResultInputTime" headerAlign="center" renderer="resultRenderReview" width="200px">
		                询价结果录入时间
		            </div>-->
		            <div field="vcAdviserConfirm" headerAlign="center" width="200px">
		                投资指令/建议复核确认时间
		            </div>
		            <div field="vcEntrustConfirm" headerAlign="center" width="200px">
		                投资指令/建议确认时间
		            </div>
		            <div field="tFsSendTime" headerAlign="center" renderer="sendRenderReview" width="200px" >
		                投资经理确认时间
		            </div>
		            <div field="lFixValidStatus" headerAlign="center" renderer="fixValidStatusRenderReview" width="100px">
		               指令/建议推送状态
		            </div>
		            <div field="tFsOperateTime" headerAlign="center" renderer="operateRenderReview" width="200px">
		                前台录单时间
		            </div>
		            <div field="tFsCheckTime" headerAlign="center" renderer="checkRenderReview" width="200px">
		                前台发送时间
		            </div>
		            <div field="tFsDealTime" headerAlign="center"  dateFormat="yyyy-MM-dd HH:mm:ss" width="150px">
		                前台成交时间
		            </div>
		            <div field="vcBsDealStatus" headerAlign="center" renderer="bsDealRenderReview" width="140px">
		                后台成交状态
		            </div>
			        <div field="lInstructNo" name="lInstructNo" headerAlign="center" width="80px">
		                指令/建议序号
		            </div>
		            <div field="vcRemark" headerAlign="center" width="85px">
		                备注
		            </div>
			    </div> 
			</div>
		</div> 
		<div id="prompt_todays">
	        <span class="separator"></span>
	        <div class="investdata"></div>
	       	<div style= "display:inline-block; margin-right: 8px;">投资经理已确认</div>
	       	<div class="waitdata"></div>
	        <div style= "display:inline-block; margin-right: 8px;">交易已发送</div>
	       	<div class="tradedate"></div>
	        <div style= "display:inline-block; margin-right: 8px;">前台已成交</div>
	      	<div class="closedata"></div>
	    	<div style= "display:inline-block;">后台已成交 </div>
	     	<div class="invaliddata"></div>
	        <div style= "display: inline-block; margin-right: 8px;">撤销</div>
	       	<div class="backdata"></div>
	        <div style= "display:inline-block; margin-right: 8px;">退回</div>
	        <div class="instructSendingdata"></div>
		 	<div style= "display:inline-block; margin-right: 8px;">发送O32中</div>
	        <div class="approvedata"></div>
	   		<div style= "display:inline-block; margin-right: 8px;">风控审批中</div>
	   		
		</div>
	</div>
	<%-- 详细开始... --%>
	<div title="指令/建议相关信息" region="south" showSplit="false" height="220px" expanded="false" showHeader="true" showSplitIcon="true" >
		<div class="nui-fit">
		    <div id="tabs_instruct_follow_detail" class="nui-tabs" activeIndex="0" onactivechanged="activechanged" height="100%">
		    	<div title="指令/建议明细" url="<%= request.getContextPath() %>/sm/comm/instruct/tansaction_instruct/instructDetail.jsp"></div>
		    	<div title="成交明细" name="dealDetail" visible="false" url="<%= request.getContextPath() %>/sm/comm/instruct/tansaction_instruct/dealDetail.jsp"></div>
		    	<div title="触犯风控" url="<%= request.getContextPath() %>/sm/comm/instruct/violateRiskCtrl.jsp"></div>
		    	<div title="修改历史" url="<%= request.getContextPath() %>/sm/comm/instruct/tansaction_instruct/reviseHistory.jsp"></div>
		    	<div title="流程审批信息" url="<%= request.getContextPath() %>/sm/comm/instruct/processApproval.jsp"></div>
		    </div>
	    </div>
    </div>
    <%-- 详细结束... --%> 
</div>	
	<!-- 导出参数 -->
	<div>
		<form id="export_FROM" method="post">
			<!-- 业务标签:当日指令/建议 -->
			<input class="nui-hidden" name="queryType" id="queryType" value="todayInstruction">
			<!-- 委托方向:01-买入  02–卖出  -->
			<input class="nui-hidden" id="entrustDirection" name="entrustDirection" value="'3','4'"/>
			<input class="nui-hidden" name="exportVcBizType" id="exportVcBizType" value="">
			<!-- 指令/建议有效状态:1-有效, 2-无效-已修改   3-无效-已撤销    4-无效-被退回  -->
			<input class="nui-hidden" id="cIsValid" name="cIsValid" value="1,3,4"/>
			<input class="nui-hidden" name="sheetName" id="sheetName" value="买卖当日指令/建议_">
			<!--  导出类型（买卖指令/建议1,回购指令/建议2）-->
			<input class="nui-hidden" name="exportType" id="exportType" value="1">
			<input class="nui-hidden" name="exportVcEntrustDirection" id="exportVcEntrustDirection" value="">
			<input class="nui-hidden" name="exportVcProductCode" id="exportVcProductCode" value="">	
			<!--  页面类型:指令/建议查询1,指令/建议管理2 -->
			<input class="nui-hidden" name="webType" id="webType" value="1">	
			<input class="nui-hidden" name="lInstructNo" id="lInstructNo" value="">		
		</form>	
	</div>
	<!-- 导出参数结束 -->
	
	<!-- 本币导出参数 -->
	<div>
		<form id="bbExport_FROM" method="post">
			<input class="nui-hidden" name="exportWebName" value="指令建议管理汇总">
			<input class="nui-hidden" name="processinstId" id="processinstId" value="">
			<input class="nui-hidden" name="exportProcessStatus" id="exportProcessStatus" value="">
			<input class="nui-hidden" name="exportCisValid" id="exportCisValid" value="1,3,4">
			<input class="nui-hidden" name="exportEnteringType" id="exportEnteringType" value="4">
			<input class="nui-hidden" name="exportEntrustDirection" id="exportEntrustDirection" value="3,4">
		</form>	
	</div>
	<!-- 本币导出参数结束 -->
	<script type="text/javascript">
    	nui.parse();
    	// 当天日期
    	var date = new Date();
    	var todayDate = DateUtil.toNumStr(date);
		nui.get("lTradeDateMin").setValue(todayDate);
		nui.get("lTradeDateMax").setValue(todayDate);
    	var today_instruct = new nui.Form("#form_today_instruct");
    	var todays_instruct_grid = nui.get("treegrid_todays_instruct");
    	var tabDetailRole = nui.get("tabs_instruct_follow_detail");//获取详情标签列表
    	var isSigleSelectChanged = false;
    	var selectCountNumValue = null;
    	var viewFlowChartButton = nui.get("viewFlowChart");
    	// 任务表格操作列内容定义
		function value(e){
			var s = null;
			// 指令/建议状态为无效、风控审批状态为审批中或审批拒绝的不允许录单确认
			if(e.row.vcProcessStatus ==5 && e.row.cIsValid==1){
				if (getProductHandleByDealEnter(e.row.vcProductCode)) {
					s = '<a style="color:#6959CD; text-decoration:underline" onclick="singleDeal()" href="#">确认</a>';
				}
			}
			if(e.row.vcProcessStatus ==6 && e.row.cIsValid==1){
				if (getProductHandleByDealCheck(e.row.lResultId)) {
					s = '<a style="color:#6959CD; text-decoration:underline" onclick="batchConfirm()" href="#">复核</a>';
				}
				if(getProductHandleByRollBack(e.row.lResultId)){
					s = '<a style="color:#6959CD; text-decoration:underline" onclick="rollbackDealEntering()" href="#">回退</a>';
				}
			}
			return s;
		}
    	
    	function onBeforeTreeLoad(e) {
        	var node = e.node;      //当前节点
        	var params = e.params;  //参数对象
	        //可以传递自定义的属性
			var initParam = new nui.Form("#form_today_instruct").getData(false,false);
	        if(node.lInquiryId){
        		initParam["lInquiryId"] = node.lInquiryId;
        	}
        	if(initParam.lTradeDateMin != null && initParam.lTradeDateMin != ""){
        		initParam.lTradeDateMin = DateUtil.toNumStr(initParam.lTradeDateMin);
        	}
        	if(initParam.lTradeDateMax != null && initParam.lTradeDateMax != ""){
        		initParam.lTradeDateMax = DateUtil.toNumStr(initParam.lTradeDateMax);
        	}
        	initParam["vcProductCode"] = splitString(initParam["vcProductCode"]);
        	initParam["queryType"] = nui.get("queryType").getValue();
        	initParam["entrustDirection"] = nui.get("entrustDirection").getValue();
        	initParam["cIsValid"] = nui.get("cIsValid").getValue();
        	initParam["vcBizType"] = nui.get("vcBizType").getValue();
        	//initParam["instructNo"] = initParam["instructNo"];
        	initParam["instructValid"] = initParam["instructValid"];
	        params.paramObject = initParam;
	    }
	    
	    function splitString(data){
    		var string = null;
    		if(data != null && data != ""){
    			var strs= data.split(",");
	    		if(strs.length>0){
	    			for(var i=0; i<strs.length; i++ ){ 
						if(i == 0){
							string = "'"+strs[i]+"'";
						}else{
							string += ",'"+strs[i]+"'";
						}
					} 
	    		}
    		}
			return string;
    	}
    	//设置指令/建议列表数据显示颜色
    	todays_instruct_grid.on("drawcell", function (e) {
	        var record = e.record,
	        	field = e.field,
        		value = e.value;
			//设置行样式，交易状态：1-有效；2-无效-已修改；3-无效-已撤销；4-有效-被退回；
			if(record.cIsValid=="3"){
				e.rowStyle='background:#FF6666;';
			}else if(record.cIsValid=="4"){
				e.rowStyle='background:#FF9999;';
			}else if(record.cIsValid=="1"){//在指令/建议状态为有效的前提下控制流程样式
				//流程处理状态:0-询价结果待录入,1-询价结果已录入,2-指令/建议待复核,2A-预置指令/建议待确认,3-待投资经理确认,4-待风控审批,
				//5-待交易录单,6-待录单复核,7-待前台成交,8-前台已成交,9-后台已成交
				if(record.vcProcessStatus=="3" && record.lFixValidStatus=="2"){//等待O32反馈
					e.rowStyle='background:#EEC900;';
				}else 
				if(record.vcProcessStatus=="4"){
					e.rowStyle='background:#9F79EE;';
				}else if(record.vcProcessStatus=="5" || record.vcProcessStatus=="6"){
					e.rowStyle='background:#99FFFF;';
				}else if(record.vcProcessStatus=="7"){
					e.rowStyle='background:#339966;';
				}else if(record.vcProcessStatus=="8"){
					e.rowStyle='background:#33FF33;';
				}else if(record.vcProcessStatus=="9"){
					e.rowStyle='background:#CCCCCC;';
				}
			}
			if(field=="lIssueDate" || field=="lTradeDate" || field=="lFirstSettleDate"){
				if(value){
					e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
				}
			}
	    });
    	
    	//自动刷新功能处理
    	var autoRefreshValOld = nui.get("autoRefresh").getValue();//获取默认自动刷新时间
	    var autoRefreshReturnVal= self.setInterval("autoRefreshFun()",eval(autoRefreshValOld)*1000);//设置自动刷新时间默认3分钟
	    function autoRefreshFun(){
	    	search();//同时刷新查询列表数据
	    	var autoRefreshVal = nui.get("autoRefresh").getValue();//获取最新自动刷新时间
	    	//若最新获取的自动刷新时间与历史自动刷新时间不等，则关闭之前的定时器，以新的自动刷新时间新建定时器，并将新值赋予历史自动刷新时间变量
	    	if(autoRefreshVal!=autoRefreshValOld){
	    		autoRefreshValOld = autoRefreshVal;//将新值赋予历史自动刷新时间变量
	    		clearInterval(autoRefreshReturnVal);//关闭之前的定时器
	    		if(autoRefreshValOld!="0"){
	    			autoRefreshReturnVal = setInterval("autoRefreshFun()", eval(autoRefreshValOld)*1000);//以新的自动刷新时间新建定时器
	    		}
	    	}
	    }
    	
    	function search(){
    		// 刷新可操作记录条数
			parent.reloadWaitConfirmFun(selectCountNumValue);
    		todays_instruct_grid.load("com.cjhxfund.ats.sm.comm.InstructionManager.queryRightInstructInfos.biz.ext");
    		clearDetail();
    	}
    	
    	function reset(){
    		today_instruct.clear();
    	}
    	
    	function selectionchanged(){
    		nui.get("deal").disable();
			nui.get("check").disable();
			nui.get("rollback").disable();
    		var rows = todays_instruct_grid.getSelecteds();
			if(rows.length == 1){
				var row = todays_instruct_grid.getSelected();
				var dealDetailTab = tabDetailRole.getTab("dealDetail");
	    		//判断是否成交（前台已成交=8，后台已成交=9）决定是否显示成交明细
	    		if(row.vcProcessStatus==8 || row.vcProcessStatus==9){		
	    			tabDetailRole.updateTab("dealDetail",{visible:true});
	    		}else{
	    			if(tabDetailRole.getActiveTab()==dealDetailTab){
						tabDetailRole.activeTab(tabDetailRole.getTab(0));
					}
					tabDetailRole.updateTab("dealDetail",{visible:false});
	    		}
	    		// 批量确认按钮控制
				if(row.vcProcessStatus ==5 && row.cIsValid==1){
					if (getProductHandleByDealEnter(row.vcProductCode)) {
						nui.get("deal").enable();
					}else{
						nui.get("deal").disable();
					}
				}
				// 批量复核和回退按钮控制
				if(row.vcProcessStatus ==6 && row.cIsValid==1){
					if (getProductHandleByDealCheck(row.lResultId)) {
						nui.get("check").enable();
					}
					if(getProductHandleByRollBack(row.lResultId)){
						nui.get("rollback").enable();
					}
				}
				viewFlowChartButton.enable();
				showDetail(row);
			}else {
				if(rows.length >1){
		    		// 确认复核条数
		    		var dealCount = 0;
		    		// 复核条数
		    		var checkCount = 0;
		    		// 录单条数
		    		var rollbackCount = 0;
		    		// 不可操作的条数
		    		var count = 0;
					for(var i=0; i<rows.length; i++){
						// 批量确认按钮控制
						if(rows[i].vcProcessStatus ==5 && rows[i].cIsValid==1){
							if (getProductHandleByDealEnter(rows[i].vcProductCode)) {
								dealCount+= 1;
							}else{
								count+= 1;
							}
						// 批量复核和回退按钮控制
						}else if(rows[i].vcProcessStatus ==6 && rows[i].cIsValid==1){
							if (getProductHandleByDealCheck(rows[i].lResultId)) {
								checkCount+= 1;
							}else if(getProductHandleByRollBack(rows[i].lResultId)){
								rollbackCount+= 1;
							}else{
								count+= 1;
							}
						}else{
							count+= 1;
						}
					}
					if(dealCount>0 && checkCount==0 && rollbackCount==0 && count==0 ){
						nui.get("check").disable();
						nui.get("deal").enable();
						nui.get("rollback").disable();
					}else if(dealCount==0 && checkCount>0 && rollbackCount==0 && count==0 ){
						nui.get("check").enable();
						nui.get("deal").disable();
						nui.get("rollback").disable();
					}else if(dealCount==0 && checkCount==0 && rollbackCount>0 && count==0 ){
						nui.get("check").disable();
						nui.get("deal").disable();
						nui.get("rollback").enable();
					}else{
						nui.get("check").disable();
						nui.get("deal").disable();
						nui.get("rollback").disable();
					}
				}
				viewFlowChartButton.disable();
				tabDetailRole.activeTab(tabDetailRole.getTab(0));
				tabDetailRole.updateTab("dealDetail",{visible:false});
				clearDetail();
			}
    	}
    	
    	//显示详细信息
    	function showDetail(row){
    		isSigleSelectChanged = true;
    		var currentTabIFrameEl = tabDetailRole.getTabIFrameEl(tabDetailRole.getActiveTab());//重新获取当前显示的标签页
    		currentTabIFrameEl.contentWindow.detail(row);//调用当前显示的标签页的显示详情方法
    	}
    	
    	
    	//清除详细信息
    	function clearDetail(){
    		isSigleSelectChanged = false;
    		var currentTabIFrameEl = tabDetailRole.getTabIFrameEl(tabDetailRole.getActiveTab());//获取当前详情标签页
    		currentTabIFrameEl.contentWindow.clearDetail();
    	}
    	//详情子界面第一次加载时调用
    	function detailLoaded(){
    		var currentTabIFrameEl = tabDetailRole.getTabIFrameEl(tabDetailRole.getActiveTab());
    		if(isSigleSelectChanged == true){
    			currentTabIFrameEl.contentWindow.detail(todays_instruct_grid.getSelected());
    		}
    	}
    	//详情标签切换时处理逻辑
    	function activechanged(){
    		var currentTabIFrameEl = tabDetailRole.getTabIFrameEl(tabDetailRole.getActiveTab());
    		if(typeof(currentTabIFrameEl) != "undefined"){
    			if(isSigleSelectChanged == true){
    				currentTabIFrameEl.contentWindow.detail(todays_instruct_grid.getSelected());
    			}else{
    				currentTabIFrameEl.contentWindow.clearDetail();
    			}
    		}
    	}
	    
		//指令/建议类别列字典翻译
	    function renderInstructType(e) {
			return nui.getDictText("instructType",e.row.vcInstructType);
		}
		
	    //指令/建议状态列字典翻译
	    function renderInstructStatus(e){
	    	return nui.getDictText("instructStatus",e.row.cIsValid);
	    }
	    
	    //业务类别列字典翻译
	    function renderBizType(e){
	    	return nui.getDictText("bizTypeTransaction",e.row.vcBizType);
	    }
	    //委托方向列字典翻译
	    function renderEntrustDirection(e){
	    	return nui.getDictText("entrustDirectionTransaction",e.row.vcEntrustDirection);
	    }
	    
	    //交易市场列字典翻译
	    function renderMarket(e){
	    	return nui.getDictText("tradePlace",e.row.vcMarket);
	    }
	    
	    //清算速度列字典翻译
	    function renderSettleSpeed(e){
	    	return nui.getDictText("settleSpeed",e.row.vcSettleSpeed);
	    }
	    
	    function renderRiskApproveStatus(e){
	    	if(e.value == null){
	    		return "--";
	    	}else{
	    		return nui.getDictText("riskApproveStatus",e.row.vcRiskApproveStatus);
	    	}
	    }
	    
	    //指令/建议下达时间显示处理
	    function initiateRenderReview(e){
			return (e.row.vcInitiatorName==null?"":e.row.vcInitiatorName) + "　" + nui.formatDate(e.row.tInitiateTime, "yyyy-MM-dd HH:mm:ss");
		}
		
		//询价结果录入时间显示处理
	    function resultRenderReview(e){
	    	if(e.row.vcResultInputerName!=null || e.row.tResultInputTime!=null){
	    		return (e.row.vcResultInputerName==null?"":e.row.vcResultInputerName) + "　" + nui.formatDate(e.row.tResultInputTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return "";
			}
		}
		//投资经理确认时间处理
	    function sendRenderReview(e){
	    	if(e.row.vcFsSenderName!=null || e.row.tFsSendTime!=null){
				return (e.row.vcFsSenderName==null?"":e.row.vcFsSenderName) + "　" + nui.formatDate(e.row.tFsSendTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return "";
			}
		}
		
		//fix发送状态
	    function fixValidStatusRenderReview(e){
	    	if(e.value == null || e.value == "0"){
	    		return "未发送";
	    	}else if(e.value == "1"){
	    		return "不启用fix";
	    	}else if(e.value == "2"){
	    		return "发送中";
	    	}else if(e.value == "3"){
	    		return "发送成功";
	    	}else if(e.value == "4"){
	    		return "发送失败";
	    	}
	    	//return nui.getDictText("fixValidStatus",e.row.lFixValidStatus);
	    }
		
		//录单确认时间处理
	    function operateRenderReview(e){
	    	if(e.row.vcFsOperatorName!=null && e.row.tFsOperateTime!=null){
				return (e.row.vcFsOperatorName==null?"":e.row.vcFsOperatorName) + "　" + nui.formatDate(e.row.tFsOperateTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return "";
			}
		}
		
		//录单复核时间处理
	    function checkRenderReview(e){
	    	if(e.row.vcFsCheckerName!=null && e.row.tFsCheckTime!=null){
				return (e.row.vcFsCheckerName==null?"":e.row.vcFsCheckerName) + "　" + nui.formatDate(e.row.tFsCheckTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return "";
			}
		}
		
		//翻译后台成交状态字典
	    function bsDealRenderReview(e){
	    	return nui.getDictText("bsSetmtStatus",e.row.vcBsDealStatus);
	    }
	    
	    function onCloseClick(e){
	    	var obj = e.sender;
            obj.setText("");
            obj.setValue("");
	    }
	    
		// 录单确认（单条）
		function singleDeal() {
			var dealEnteringValue = todays_instruct_grid.getSelected();
			// 单条录单确认
			if (dealEnteringValue != null) {
				if (dealEnteringValue.vcProcessStatus != 5
							|| dealEnteringValue.cIsValid!=1) {
						nui.alert("只能操作未录单的记录！", "系统提示");
						return;
				} 	
				// 加载选择复核人页面
				nui.open({
					url : "<%=request.getContextPath()%>/transaction/manage/deal_entering/setEnteringCheckUser.jsp",
				    title: "选择复核人", 
				    width: 500, 
				    height: 400,
				    onload: function () {
				        var iframe = this.getIFrameEl();
				        iframe.contentWindow.SetData(dealEnteringValue);
				    },
				    ondestroy: function (action) {
				    	nui.get("deal").disable();
						// 刷新可操作记录条数
				    	search();
	        		}
				});
			// 批量录单确认	
			}else {
				nui.alert("请选中一条记录","提示");
			}
		}
		
		// 复核
		function batchConfirm() {
			
			var dealEnteringValue = todays_instruct_grid.getSelecteds();
			if (dealEnteringValue.length > 0) {
				for (var i = 0; i < dealEnteringValue.length; i++) {
					if (dealEnteringValue[i].vcProcessStatus != 6) {
						nui.alert("只能操作未复核的记录！", "系统提示");
						return;
					}
					// 时间传到后台时先转格式
	    			delete dealEnteringValue[i].tInitiateTime;
	    			delete dealEnteringValue[i].tResultInputTime;
	    			delete dealEnteringValue[i].tFsSendTime;
	    			delete dealEnteringValue[i].tFsOperateTime;
	    			delete dealEnteringValue[i].tFsCheckTime;
	    			delete dealEnteringValue[i].tRepealTime;
	    			delete dealEnteringValue[i].lTradeDate;
	    			delete dealEnteringValue[i].lFirstSettleDate;
	    			delete dealEnteringValue[i].enNetPriceAmount;
	    			delete dealEnteringValue[i].enFullPriceAmount;
				}	
				//	复核批量确认						
				nui.confirm("确定复核选中记录？", "系统提示",function (action) {            
	                if (action == "ok") {
		                nui.ajax({
			                url: "com.cjhxfund.ats.sm.comm.InstructionManager.updateBatchEnterCheckStatus.biz.ext",
			                type:'POST',
							data: {param:dealEnteringValue},
							cache: false,
							contentType:'text/json',
			                success: function (text) {
			                	var returnJson = nui.decode(text);
								if(returnJson.exception == null){
									if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
										nui.alert(returnJson.rtnMsg,"系统提示",function(action){
											if(action == "ok"){
												nui.get("check").disable();
										    	// 刷新可操作记录条数
												parent.reloadWaitConfirmFun(selectCountNumValue);
												search();
											}
										});
									}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
										nui.alert(returnJson.rtnMsg,"系统提示",function(action){
											if(action == "ok"){
												nui.get("check").disable();
										    	// 刷新可操作记录条数
												parent.reloadWaitConfirmFun(selectCountNumValue);
												search();
											}
										});
									}else{
										nui.alert("操作异常","系统提示");
									}
								}else{
									nui.alert("系统异常","系统提示");
								}
							},
						    ondestroy: function (action) {
						    	nui.get("check").disable();
						    	// 刷新可操作记录条数
								parent.reloadWaitConfirmFun(selectCountNumValue);
	                    		search();
	                		}
		          		});
	          		 }
	            });
			} else {
				nui.alert("请选中一条记录","提示");
			}
		}
		
		// 录单查询权限
		function getProductHandleByDealEnter(vcProductCode) {
			var url = "";
			var result = false;
			//if(e.row.vcProcessStatus == "5"){
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
			//}else{
				//return result;
			//}
			return result;
		}
			
		// 查询复核权限
		function getProductHandleByDealCheck(resultId) {
			var url = "";
			var result = false;
			//if(e.row.vcProcessStatus == "6"){
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
			//}else{
			//	return result;
			//}
		
			return result;
		}
        
        //导出指令/建议的excle文件
		function exportExcel(){
			var rows = todays_instruct_grid.getSelecteds();
			var bizType = nui.get("vcBizType").getValue();
			var vcEntrustDirection = nui.get("vcEntrustDirection").getValue();
			var vcProductCode = nui.get("vcProductCode").getValue();
			// 定义指令/建议序号
			var lInstructNo = "";
			// 定义弹窗提示信息
			var msg = "您未选中指令/建议，将导出全部指令/建议，确定要导出吗?";
			// 设置导出form参数
			if(bizType != ""){
				document.getElementById("exportVcBizType").value = splitString(bizType);
			}
			if(vcEntrustDirection != ""){
				document.getElementById("exportVcEntrustDirection").value = vcEntrustDirection;
			}
			if(vcProductCode != ""){
				document.getElementById("exportVcProductCode").value = vcProductCode;
			}
			
			if(rows.length>0){
				msg = "确定要导出吗?";
				// 拼接指令/建议序号
				for(var i=0; i<rows.length; i++){
					lInstructNo+= rows[i].lInstructNo+",";
				}
				//去掉最后一个逗号
			    if (lInstructNo.length > 0) {
			        lInstructNo = lInstructNo.substr(0, lInstructNo.length - 1);
			    };
			    // 设置导出form参数
				if(lInstructNo != null){
					document.getElementById("lInstructNo").value = lInstructNo;
				}
			}
			// 页面流跳转
			nui.confirm(msg,"系统提示",function(action){
				if(action=="ok"){			
					nui.get("export_todayInstruct").disable();//禁用“导出”按钮
					var form = document.getElementById("export_FROM");
					form.action = "com.cjhxfund.ats.sm.comm.instructExcle.flow";
			        form.submit();
			        //启用“导出”按钮
			        setTimeout("enableExport()",15000);
			        document.getElementById("lInstructNo").value = "";
				}
			});
		}
		
		function enableExport(){
				nui.get("export_todayInstruct").enable();
		}
		
		// 单条退回录单操作
		function rollbackDealEntering(){
			var selectValue = todays_instruct_grid.getSelected();
			var param = {lProcessinstId:selectValue.lProcessinstId, enterCheck:"enterCheck", lInstructId:selectValue.lResultId};
			nui.confirm("确定回退选中记录？", "系统提示",
	            function (action) {            
	                if (action == "ok") {
	                    nui.ajax({
			                url: "com.cjhxfund.ats.sm.comm.InstructionManager.instructCheckBackToDealEnter.biz.ext",
			                type:'POST',
							data: {paramData:param},
							contentType: 'text/json',
			                success: function(text){
								var returnJson = nui.decode(text);
								if(returnJson.exception == null){
									if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
										nui.get("rollback").disable();
										// 刷新可操作记录条数
										parent.reloadWaitConfirmFun(selectCountNumValue);
										todays_instruct_grid.load("com.cjhxfund.ats.sm.comm.InstructionManager.queryRightInstructInfos.biz.ext");
										clearDetail();
									}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
										parent.reloadWaitConfirmFun(selectCountNumValue);
										todays_instruct_grid.load("com.cjhxfund.ats.sm.comm.InstructionManager.queryRightInstructInfos.biz.ext");
										nui.alert(returnJson.rtnMsg,"系统提示");
									}else{
										nui.alert("操作异常","系统提示");
									}
								}else{
									nui.alert("系统异常","系统提示");
								}
							}
			            });
	                }
	            }
        	);
		}
		
		// 批量退回录单操作
		function batchRollbackDealEntering(){
			var selectValue = todays_instruct_grid.getSelecteds();
			if(selectValue.length > 0){
				for (var i = 0; i < selectValue.length; i++) {
					if (selectValue[i].vcProcessStatus != 6
							|| selectValue[i].cIsValid !=1) {
						nui.alert("只能操作可回退待的记录！", "系统提示");
						return;
					}
				}
				nui.confirm("确定回退选中记录？", "系统提示",
		            function (action) {            
		                if (action == "ok") {
		                    nui.ajax({
				                url: "com.cjhxfund.ats.sm.comm.InstructionManager.batchInstructCheckBackToDealEnter.biz.ext",
				                type:'POST',
								data: {paramData:selectValue},
								contentType: 'text/json',
				                success: function(text){
									var returnJson = nui.decode(text);
									if(returnJson.exception == null){
										if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
											nui.get("rollback").disable();
											// 刷新可操作记录条数
											parent.reloadWaitConfirmFun(selectCountNumValue);
											todays_instruct_grid.load("com.cjhxfund.ats.sm.comm.InstructionManager.queryRightInstructInfos.biz.ext");
											clearDetail();
										}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
											parent.reloadWaitConfirmFun(selectCountNumValue);
											todays_instruct_grid.load("com.cjhxfund.ats.sm.comm.InstructionManager.queryRightInstructInfos.biz.ext");
											nui.alert(returnJson.rtnMsg,"系统提示");
										}else{
											nui.alert("操作异常","系统提示");
										}
									}else{
										nui.alert("系统异常","系统提示");
									}
								}
				            });
		                }
		            }
	        	);
			}else {
				nui.alert("请选中一条记录","提示");
			}
		}
		
		// 录单确认（批量）
		function batchDeal() {
			var dealEnteringValue = todays_instruct_grid.getSelecteds();
			if(dealEnteringValue.length>0){
				for (var i = 0; i < dealEnteringValue.length; i++) {
					
					if (dealEnteringValue[i].vcProcessStatus != 5
							|| dealEnteringValue[i].cIsValid!=1) {
						nui.alert("只能操作未录单确认的记录！", "系统提示");
						return;
					} 	
				    // 时间传到后台时先转格式
					delete dealEnteringValue[i].tInitiateTime;
					delete dealEnteringValue[i].tResultInputTime;
					delete dealEnteringValue[i].tFsSendTime;
					delete dealEnteringValue[i].tFsOperateTime;
					delete dealEnteringValue[i].tFsCheckTime;
					delete dealEnteringValue[i].tRepealTime;
					delete dealEnteringValue[i].tModifyTime;
					delete dealEnteringValue[i].lIssueDate;
					delete dealEnteringValue[i].lTradeDate;
					delete dealEnteringValue[i].lFirstSettleDate;
					delete dealEnteringValue[i].lMaturitySettleDate;
	    			delete dealEnteringValue[i].enNetPriceAmount;
	    			delete dealEnteringValue[i].enFullPriceAmount;
				}
				// 执行录单方法
				var a = nui.loading("正在处理中,请稍等...","提示");
				nui.ajax({
			    	url: "com.cjhxfund.ats.sm.comm.InstructionManager.batchConfirmDealEntering.biz.ext",
			      	type: 'POST',
			      	data: {param:dealEnteringValue},
			      	contentType: 'text/json',
			      	success: function(text){
			      		nui.hideMessageBox(a);
			      		var returnJson = nui.decode(text);
						if(returnJson.exception == null){
							if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
								nui.alert(returnJson.rtnMsg,"系统提示");
								nui.get("deal").disable();
								// 刷新可操作记录条数
								parent.reloadWaitConfirmFun(selectCountNumValue);
								todays_instruct_grid.load("com.cjhxfund.ats.sm.comm.InstructionManager.queryRightInstructInfos.biz.ext");
							}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
								parent.reloadWaitConfirmFun(selectCountNumValue);
								todays_instruct_grid.load("com.cjhxfund.ats.sm.comm.InstructionManager.queryRightInstructInfos.biz.ext");
								nui.alert(returnJson.rtnMsg,"系统提示");
							}else{
								nui.alert("操作异常","系统提示");
							}
						}else{
							nui.alert("系统异常","系统提示");
						}
			      	
			      	}
		 		});
			} else {
				nui.alert("请选中一条记录","提示");
			}
		}
		
		// 生成本币接口文件
        function exportBbExcel(){
        	if(todays_instruct_grid.data.length>0){
				var rows = todays_instruct_grid.getSelecteds();
				// 定义弹窗提示信息
				var msg = "您未选中指令/建议，将导出全部指令/建议，确定要导出吗?";
				//判断要导出的指令/建议中是否存在多个产品
			    for(var i = 0; i<rows.length; i++){
			    	if(rows[i].cIsValid != "1" || rows[i].vcProcessStatus == "4"){
			    		nui.alert("无效和风控中的记录不能导出","系统提示");
			           return;
			    	}
			    }
				// 定义流程id
				var processinstId = "";
				if(rows.length>0){
					msg = "您已选中 " + rows.length + " 条记录，确定要导出吗?";
					// 拼接流程实例id
					for(var i=0; i<rows.length; i++){
						processinstId+= rows[i].lProcessinstId+",";
					}
					//去掉最后一个逗号
				    if (processinstId.length > 0) {
				        processinstId = processinstId.substr(0, processinstId.length - 1);
				    }
				}
				// 设置导出form参数
				if(processinstId != null){
					document.getElementById("processinstId").value = processinstId;
				}
				// 页面流跳转
				nui.confirm(msg,"系统提示",function(action){
					if(action=="ok"){
						nui.get("export_todayInstruct_bb").disable();//禁用“导出”按钮
						var form = document.getElementById("bbExport_FROM");
						form.action = "com.cjhxfund.ats.sm.comm.ExprotExcleByProcessinstById.flow";
				        form.submit();
				        //启用“导出”按钮
				        setTimeout("enableBbExport()",15000);
				        document.getElementById("processinstId").value = "";
					}
				});
			}else{
        		nui.alert("查询不到可以导出的记录","系统提示");
        		return false;
        	}
		}
	    
	    function enableBbExport(){
	  		nui.get("export_todayInstruct_bb").enable();
		}  
		
		//获取查询条件的产品名称
		function ButtonClickGetFundName_todayInstruct(e){
	        ButtonClickGetFundName(this);
		}
		
		//跨页多选选择表格获取产品
		function ButtonClickGetFundName(buttonEditObj){
	        nui.open({
	            url: "<%=request.getContextPath() %>/sm/comm/instruct/productInfoCombi.jsp",
	            title: "产品列表",
	            width: 450,
	            height: 380,
	            onload:function(){
	            	
	                var iframe = this.getIFrameEl();
	                var fundCodes = buttonEditObj.getValue();
	                var fundNames = buttonEditObj.getText();
	                var data = {
	                   fundCodes:fundCodes,
	                   fundNames:fundNames
	                };
	                iframe.contentWindow.SetData(data);
	            },
	            ondestroy: function (action) {
	            	
	                if (action == "ok") {
	                    var iframe = this.getIFrameEl();
	                    var data = iframe.contentWindow.GetData();
	                    data = nui.clone(data);
	                    buttonEditObj.setValue(data.vcProductCode);
	                    buttonEditObj.setText(data.vcProductName);
	                }
	            }
	        });
		}
		
		// 查询回退权限
		function getProductHandleByRollBack(lResultId) {
			var url = "";
			var result = false;
			url = "com.cjhxfund.ats.sm.comm.InstructionManager.getRollBackInstructHandleByResultId.biz.ext";
			nui.ajax({
				url : url,
				type : 'POST',
				data : {
					lResultId : lResultId
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
							if (userIds[i].vcFsOperator == returnJson.userId) {
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
		
		//行双击时弹出页面展示该指令/建议明细信息
	    todays_instruct_grid.on("rowdblclick", function (e) {
	    	var row = todays_instruct_grid.getSelected();
		    if (row) {
		    	nui.open({
		            url: "<%=request.getContextPath()%>/sm/comm/instruct/query/tansaction/instructDetailShow.jsp",
		            title: "指令/建议详细展示",
		            width: 700,
		            height: 390,
		            onload: function () {
		                var iframe = this.getIFrameEl();
		                // 直接从页面获取，不用去后台获取
		                iframe.contentWindow.setFormData(row);
		            },
		            ondestroy: function (action) {//弹出页面关闭前
			        }
		        });
		    }
	    });
	    
	    //查看流程图
		function viewFlowChart(){
			window.open(nui.context+"/com.cjhxfund.foundation.task.ProcessChart.flow?processInstID="+todays_instruct_grid.getSelected().lProcessinstId);
		}
	    
    </script>
</body>
</html>