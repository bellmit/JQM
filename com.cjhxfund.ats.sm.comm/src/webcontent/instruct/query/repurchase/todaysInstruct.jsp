<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!--
  - Author(s): luojuehuai
  - Date: 2016-09-06 10:44:58
  - Description:
-->
<head>
    <title>当日指令/建议</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/css/instruct.css"/>
    <script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script> 

</head>
<body style="height:100%; width:100%; overflow:hidden; margin:0;padding:0;" onload="onloadFun()">
<div id="layout1" class="mini-layout" style="width:100%; height:100%;"  borderStyle="border:0px;">
	<div>
		<div class="search-condition">
	   		<div class="list">
				<!-- 业务标签:当日指令/建议 -->
		   		<input class="nui-hidden" id="queryType" name="queryType" value="2"/>
				<!-- 委托方向:01-买入  02–卖出  -->
				<input class="nui-hidden" id="entrustDirection" name="entrustDirection" value="'5','6','15','16','17','18','26','27','30','31'"/>
				<input class="nui-hidden" id="bizType" name="bizType" value="'5','6','7','10'"/>
				<!-- 指令/建议有效状态:1-有效, 2-无效-已修改   3-无效-已撤销    4-无效-被退回  -->
	   			<div id="form_today_instruct" class="nui-form" style="padding:2px;height:10%;max-width:100%" align="left">
	                <table id="instruct_follow_condition" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
	                	<tr>
							<td width="60px" align="right">
								产品名称:
	                        </td>
	                        <td colspan="1" width="15%" align="left">
	                            <input id="vcProductCode" class="nui-buttonedit" name="vcProductCode" emptyText="全部" onbuttonclick="ButtonClickGetFundName_todayInstruct" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
	                        </td>
	                        <td width="60px" align="right">业务类别:</td>
							<td colspan="1" width="11%" align="left">
								<input class="nui-dictcombobox" id="vcBizType" name="vcBizType" multiSelect="true"
									valueField="dictID" textField="dictName" dictTypeId="bizTypeRepurchase" 
									emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
							</td>
							<td width="60px" align="right">委托方向:</td>
							<td colspan="1" width="11%" align="left">
								<input class="nui-combobox" id="vcEntrustDirection" name="vcEntrustDirection"
		                           textField="text"
		                           valueField="value"
		                           data="[{value: '5,15', text: '正回购'}, {value: '6,16', text: '逆回购'}]"
		                           multiSelect="true"
		                           emptyText="全部"
		                           style="width:95%"
		                           oncloseclick="onCloseClick"
		                           showClose="true"/></input>
		              		</td>
							
							<td width="60px" align="right">交易状态:</td>
							<td colspan="1" width="9%" align="left">
								<input class="nui-combobox" id="instructValid"
		                           name="instructValid"
		                           textField="text"
		                           valueField="cIsValid"
		                           data="[{cIsValid: '1', text: '有效'}, {cIsValid: '2', text: '无效-已修改'}, {cIsValid: '3', text: '无效-已撤销'}, {cIsValid: '4', text: '无效-被退回'}, {cIsValid: '5', text: '修改审核中'}, {cIsValid: '6', text: '无效-修改未通过'}, {cIsValid: '7', text: '无效-已过期'},{cIsValid: '8', text: '作废'}]"
		                           multiSelect="true"
		                           emptyText="全部"
		                           style="width:100%"
		                           oncloseclick="onCloseClick"
		                           showClose="true"/>
		              		</td>
		              		<td class="form_label" width="60px" align="right">交易日期:</td>
							<td colspan="1" width="20%" align="left">
								<input class="nui-datepicker" name="lTradeDateMin" id="lTradeDateMin" showClose="true" oncloseclick="onCloseClick" style="width:45%;"/>
	                    		<span style="width:5%;">-</span>
								<input class="nui-datepicker" name="lTradeDateMax" id="lTradeDateMax" showClose="true" oncloseclick="onCloseClick" style="width:45%;" />
							</td>
						</tr>
						<tr>
							<td colspan="8">
	                           	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
								<input class='nui-button' plain='false' text="重置" iconCls="icon-reset" onclick="reset()"/>
								<a class="nui-menubutton " plain="false" menu="#popupMenu"
	                               id="searchCond"
	                               name="searchCond"
	                               data-options='{formId:"form_today_instruct"}'
	                               iconCls="icon-add">保存查询条件</a>
	                            <ul id="popupMenu" class="mini-menu" style="display:none;width:250px;"></ul>
	                        </td>
	                    </tr>
					</table>
				</div>
	   		</div>
	   	</div>
	   	
	   	<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	    	<table style="width:100%;">
	            <tr>
	                <td style="width:70%;">
	                	<a id="deal" enabled="false" class='nui-button' plain='false' iconCls="icon-ok" onclick="batchDeal()">确认</a>
	                  	<!-- <a id="check" enabled="false" class='nui-button' plain='false' iconCls="icon-ok" onclick="batchConfirm()">录单复核</a>-->
	                  	<!-- <a id="rollback" enabled="false" class='nui-button' plain='false'  iconCls="icon-undo" onclick="batchRollbackDealEntering()">回退</a> -->
						<a id="viewFlowChart" plain="false" enabled="false" class='nui-button' plain='false' iconCls="icon-search" onclick="viewFlowChart()">查看流程图</a>
						<a class='nui-button' plain='false' iconCls="icon-download" id="export_todayInstruct_bb" onclick="exportBbExcel()">导出本币接口文件</a>
						<a class='nui-button' plain='false' iconCls="icon-reload" onclick="refresh_pinyin()">同步O32交易对手</a>
        				<a class='nui-button' plain='false' iconCls="icon-edit" onclick="openSetEnterCheckUser()">设置默认复核人</a>
        				<a id="matchInstruct" enabled="false" class='nui-button' plain='false' iconCls="icon-ok" onClick="matchInstruct()">匹配指令置成交</a>
	                </td>
	                <td style="width:30%;" align="right">
	                    <a class='nui-button' plain='false' iconCls="icon-reload" onclick="autoRefreshFun()">刷新</a>
	                    <input id="autoRefresh" class="nui-combobox" style="width:90px;" 
		                    value="180" showNullItem="false" allowInput="false"
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
				 url="com.cjhxfund.ats.sm.comm.InstructionManager.queryCombineInstructInfo.biz.ext" 
				 dataField="insructInfos" treeColumn="lInstructNo"
				 showPager="true" pageSize="20" frozenStartColumn="0" frozenEndColumn="6"
				 showTreeIcon="false"  multiSelect="true" showReloadButton="false"
				 onselectionchanged="selectionchanged"
				 onbeforeload="onBeforeTreeLoad"
				 sizeList="[20,50,100,200,500,1000]"
				 pagerButtons="#prompt_todays"
				 sortField="" sortOrder="" virtualScroll="true"
				 enableHotTrack="false"
				 idField="lResultId"
	             onselect="onSelect"
	             ondeselect="onDeselect"
	             onload="onGridLoad">
			    <div property="columns">
			    	<div type="checkcolumn" ></div>
			    	<div name="action" width="60px" align="center"  headerAlign="center" headerallowSort="true" renderer="value">操作</div>
		            <div field="vcProductName"  headerAlign="center" allowSort="true" width="130px">
		               产品名称
		            </div>
		            <div field="vcCombiName"  headerAlign="center" allowSort="true" width="120px">
		                组合名称
		            </div>
		            <div field="vcSettleSpeed"  headerAlign="center" allowSort="true" width="70px" renderer="renderSettleSpeed">
		                清算速度
		            </div>
		            <div field="vcBizType"  headerAlign="center" allowSort="true" width="120px" renderer="renderBizType">
		                业务类别
		            </div>
		            <div field="vcEntrustDirection"  headerAlign="center" allowSort="true" width="85px" renderer="renderEntrustDirection">
		                委托方向
		            </div>
		            <div field="vcCounterpartyName"  headerAlign="center" allowSort="true" width="100px">
		                交易对手
		            </div>
		            <div field="vcStockCode"  headerAlign="center" allowSort="true" width="85px">
		                债券代码
		            </div>
		            <div field="vcStockName"  headerAlign="center" allowSort="true" width="120px">
		                债券名称
		            </div>
		            <div field="lRepoDays"  headerAlign="center" allowSort="true" width="85px">
		                回购天数
		            </div>
		             <div field="enFaceAmount" headerAlign="center" allowSort="true" align="right" width="100px" numberFormat="n4">
		               回购金额(万元)
		            </div>
		            <div field="enRepoRate"  headerAlign="center" allowSort="true" align="right" numberFormat="n4" width="85px">
		               回购利率(%)
		            </div>
		            <div field="lResultDate"  headerAlign="center" allowSort="true" width="110px">
		                录入日期
		            </div>
		            <div field="lTradeDate"  headerAlign="center" allowSort="true" width="85px">
		                交易日
		            </div>
		            <div field="lFirstSettleDate"  headerAlign="center" allowSort="true" width="85px">
		               首次结算日
		            </div>
		            <div field="lMaturitySettleDate"  headerAlign="center" allowSort="true" width="85px">
		                到期结算日
		            </div>
		             <div field="enFullPriceAmount"  headerAlign="center" allowSort="true" numberFormat="n2" align="right" width="100px">
		               首次结算金额(元)
		            </div>
		            <div field="enSettleAmount"  headerAlign="center" allowSort="true" numberFormat="n2" align="right" width="100px">
		               到期结算金额(元)
		            </div>
		            <div field="vcQuoteMode"  headerAlign="center" allowSort="true" width="130px" renderer="renderQuoteMode">
		                报价方式
		            </div>
		            <div field="enWeightingValue"  headerAlign="center" allowSort="true" align="right" width="85px">
		               加点(bp)
		            </div>
		            <div field="cIsValid"  headerAlign="center" allowSort="true" align="center" width="95px" renderer="renderInstructStatus">
		                交易状态
		            </div>
		            
		            
		            <div field="tResultInputTime"  headerAlign="center" allowSort="true" renderer="resultRenderReview" width="200px">
		                录入时间
		            </div>
		            <div field="vcAdviserConfirm"  headerAlign="center" allowSort="true" width="200px">
		              复核时间
		            </div>
		            <div field="vcEntrustConfirm"  headerAlign="center" allowSort="true" width="200px">
		                确认时间
		            </div>
		            <div field="tFsSendTime"  headerAlign="center" allowSort="true" align="center" renderer="sendRenderReview" width="200px" >
		                投资经理确认时间
		            </div>
		            <div field="lFixValidStatus" headerAlign="center" allowSort="true" align="center" renderer="fixValidStatusRenderReview" width="100px">
		                推送状态
		            </div>
		            <div field="tFsOperateTime"  headerAlign="center" allowSort="true" align="center" renderer="operateRenderReview" width="200px">
		                 前台录单时间
		            </div>
		            <div field="tFsCheckTime"  headerAlign="center" allowSort="true" align="center" renderer="checkRenderReview" width="200px">
		                 前台发送时间
		            </div>
		            <div field="tFsDealTime"  headerAlign="center" allowSort="true" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" width="150px">
		                 前台成交时间
		            </div>
		            <div field="vcBsDealStatus"  headerAlign="center" allowSort="true" align="center" renderer="bsDealRenderReview" width="140px">
		                 后台成交状态
		            </div>
		            <div field="lInstructNo" name="lInstructNo"  headerAlign="center" allowSort="true" width="120px">
		                 指令/建议序号
		            </div>
		            <div field="instructSource"  headerAlign="center" allowSort="true" width="90px" renderer="rendererInstructResource">
		                指令/建议来源
		            </div>
		            <div field="vcRemark"  headerAlign="center" allowSort="true" align="center" width="85px">
		                 备注
		            </div>
			    </div>
			</div>
		</div>
		<div id="prompt_todays">
	        <span class="separator"></span>
	        <div class="investdata"></div>
	       	<div style= "display:inline-block; margin-right: 8px;">投资经理已确认</div>
	       	<div class="transactionConfirmData"></div>
	       	<div style= "display:inline-block; margin-right: 8px;">交易已确认</div>
	       	<div class="waitdata"></div>
	        <div style= "display:inline-block; margin-right: 8px;">交易已发送</div>
	       	<div class="tradedate"></div>
	        <div style= "display:inline-block; margin-right: 8px;">前台已成交</div>
	      	<div class="closedata"></div>
	        <div style= "display:inline-block;">后台已成交 </div>
	     	<div class="invaliddata"></div>
	        <div style= "display: inline-block; margin-right: 8px;">无效</div>
	       	<div class="backdata"></div>
	        <div style= "display:inline-block; margin-right: 8px;">已修改</div>
	       	<div class="approvedata"></div>
	       	<div style= "display:inline-block; margin-right: 8px;">触发风控</div>
	       	<div class="forbiddata"></div>
	        <div style= "display:inline-block; margin-right: 8px;">交易禁止</div>
	    </div> 
	</div>
	<%-- 详细开始... --%>
	<div title="指令/建议相关信息" region="south" showSplit="false" height="220px" showHeader="true" showSplitIcon="true" expanded="false">
		<div class="nui-fit">
		    <div id="tabs_instruct_follow_detail" class="nui-tabs" activeIndex="0" onactivechanged="activechanged" height="100%">
		    	<div title="指令/建议明细" url="<%= request.getContextPath() %>/sm/comm/instruct/repurchase_instruct/instructDetail.jsp"></div>
		    	<div title="质押券" url="<%= request.getContextPath() %>/sm/comm/instruct/repurchase_instruct/mortgageInfo.jsp"></div>
		    	<div title="成交明细" name="dealDetail" visible="false" url="<%= request.getContextPath() %>/sm/comm/instruct/repurchase_instruct/dealDetail.jsp"></div>
		    	<div title="修改历史" name="editHistory" url="<%= request.getContextPath() %>/sm/comm/instruct/repurchase_instruct/reviseHistory.jsp"></div>
		    	<div title="触犯风控" name="riskDetailTab" url="<%= request.getContextPath() %>/sm/comm/instruct/violateRiskCtrl.jsp"></div>
		    	<div title="流程审批信息" name="approveTab" url="<%= request.getContextPath() %>/sm/comm/instruct/processApproval.jsp"></div>
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
			<input class="nui-hidden" id="entrustDirection" name="entrustDirection" value="'5','6','15','16','17','18','26','27','30','31'"/>
			<input class="nui-hidden" name="exportVcBizType" id="exportVcBizType" value="">
			<input class="nui-hidden" name="sheetName" id="sheetName" value="回购当日指令/建议_">
			<!--  导出类型（买卖指令/建议1,回购指令/建议2）-->
			<input class="nui-hidden" name="exportType" id="exportType" value="2">
			<!--  页面类型:指令/建议查询1,指令/建议管理2 -->
			<input class="nui-hidden" name="webType" id="webType" value="1">
			<input class="nui-hidden" name="exportVcEntrustDirection" id="exportVcEntrustDirection" value="">
			<input class="nui-hidden" name="exportVcProductCode" id="exportVcProductCode" value="">			
			<input class="nui-hidden" name="lInstructNo" id="lInstructNo" value="">		
		</form>	
	</div>
	<!-- 导出参数结束 -->
	
	<!-- 本币导出参数 -->
	<div>
		<form id="bbExport_FROM" method="post">
			<input class="nui-hidden" name="exportWebName" value="指令建议管理汇总">
			<input class="nui-hidden" name="lResultNo" id="lResultNo" value="">
			<input class="nui-hidden" name="exportProcessStatus" id="exportProcessStatus" value="">
			<input class="nui-hidden" name="exportCisValid" id="exportCisValid" value="1">
			<input class="nui-hidden" name="exportEnteringType" id="exportEnteringType" value="4">
			<input class="nui-hidden" name="exportEntrustDirection" id="exportEntrustDirection" value="'5','6','15','16','17','18','26','27','30','31'">
			<input class="nui-hidden" name="exportVcBizType" id="exportVcBizType" value="'5','6'">
			
			<input class="nui-hidden" name="exportBbTradeDateMin" id="exportBbTradeDateMin" value="">
			<input class="nui-hidden" name="exportBbTradeDateMax" id="exportBbTradeDateMax" value="">	
		</form>	
	</div>
	<!-- 本币导出参数结束 -->
	<script type="text/javascript">
	    nui.parse();
	    $(function(){
			parent.updateTab();	    
	    });
	    
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
    	
    	var selectArr = [];//已选的记录数组
    	
    	//Grid加载完成后选中之前已选中的记录
	    function onGridLoad(e) {
    		var rows = selectArr;
	        if(rows) todays_instruct_grid.selects(rows);
	    }
    	
    	//行选中时发生
	    function onSelect(e){
	    	var record = e.record;
	    	var isExist = false;
	    	for(var i=0; i<selectArr.length; i++){
	    		var row = selectArr[i];
	    		if(row.lResultId==record.lResultId){
	    			selectArr[i] = record;
	    			isExist = true;//若之前已选中，则直接返回
	    			break;
	    		}
	    	}
	    	//若之前尚未选中该记录，则新增该记录到数组中
	    	if(isExist==false){
	    		selectArr.push(record);
	    	}
	    }
	    
	    //行取消选中时发生
	    function onDeselect(e){
	    	var record = e.record;
	    	var selectArrTemp = selectArr;//将原数组赋予临时数组
	    	selectArr = [];//将原数组清空，重新赋值
	    	for(var i=0; i<selectArrTemp.length; i++){
	    		var row = selectArrTemp[i];
	    		if(row.lResultId!=record.lResultId){//将原来数组中不等于取消选中行的记录重新放回去
	    			selectArr.push(row);
	    		}
	    	}
	    }
	    
    	// 任务表格操作列内容定义
		function value(e){
			var s = null;
			// 指令/建议状态为无效、风控审批状态为审批中或审批拒绝的不允许录单确认
			if(e.row.vcInstructSource=="3"){		// 3-二级债 其他为老机器猫
				if(e.row.vcProcessStatus ==5 && e.row.cIsValid==1){
					if (e.row.smJyyConfirmRelateTypeUser != null) {
						s = '<a style="color:#6959CD; text-decoration:underline" onclick="goInstructDetail('+e.rowIndex+')" href="#">确认</a>';
					}
				}
				if(e.row.vcProcessStatus ==6 && e.row.cIsValid==1){
					if (e.row.smJyyCheckUser != null) {
						s = '<a style="color:#6959CD; text-decoration:underline" onclick="goInstructDetail('+e.rowIndex+')" href="#">确认</a>';
					}
					if(e.row.vcFsOperator != null){
						s = '<a style="color:#6959CD; text-decoration:underline" onclick="rollbackDealEntering('+e.rowIndex+')" href="#">重新确认</a>';
					}
				}
			}else{		//机器猫业务按钮显示
	        	var validStatus = e.row.cIsValid;
	        	if(validStatus=="1"){
	        		if(e.row.jqmJyyConfirmRelateTypeUser != null){
						s = '<a style="color:#6959CD; text-decoration:underline" onclick="goInstructDetail('+e.rowIndex+')" href="#">确认</a>';
					};
	        	}
			}
			return s;
		}
    	
    	function onBeforeTreeLoad(e) {
        	var node = e.node;      //当前节点
        	var params = e.params;  //参数对象
	        //可以传递自定义的属性
			var initParam = new nui.Form("#form_today_instruct").getData(false,false);
        	if(initParam.lTradeDateMin != null && initParam.lTradeDateMin != ""){
        		initParam.lTradeDateMin = DateUtil.toNumStr(initParam.lTradeDateMin);
        	}else{
        		initParam.lTradeDateMin = DateUtil.toNumStr(new Date());
        	}
        	if(initParam.lTradeDateMax != null && initParam.lTradeDateMax != ""){
        		initParam.lTradeDateMax = DateUtil.toNumStr(initParam.lTradeDateMax);
        	}else{
        		initParam.lTradeDateMax = DateUtil.toNumStr(new Date());
        	}
        	if(initParam.vcEntrustDirection != null && initParam.vcEntrustDirection != ""){
        		initParam["vcEntrustDirection"] = nui.get("vcEntrustDirection").getValue();
        	}else{
        		initParam["vcEntrustDirection"] = nui.get("entrustDirection").getValue();
        	}
        	if(initParam.instructValid != null && initParam.instructValid != ""){
        		initParam["instructValid"] = nui.get("instructValid").getValue();
        	}else{
        		//initParam["instructValid"] = nui.get("cIsValid").getValue();
        	}
        	if(initParam.vcBizType != null && initParam.vcBizType != ""){
        		initParam["vcBizType"] = nui.get("vcBizType").getValue();
        	}else{
        		initParam["vcBizType"] = nui.get("bizType").getValue();
        	}
        	
        	initParam["vcProductCode"] = splitString(initParam["vcProductCode"]);
        	//initParam["queryType"] = nui.get("queryType").getValue();
        	//initParam["instructNo"] = initParam["instructNo"];
	        params.paramObject = initParam;
	        // 获取页签栏条数
	        
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
			if(record.cIsValid=="2"){
				e.rowCls = "instructStatus_2_zlgl";
			}else if(record.cIsValid=="3"||record.cIsValid=="4"||record.cIsValid=="5"||record.cIsValid=="6"||record.cIsValid=="7"||record.cIsValid=="8"){
				e.rowCls = "instructStatus_3_4_5_6_zlgl";
			}else if(record.cIsValid=="1"){//在指令/建议状态为有效的前提下控制流程样式
				//流程处理状态:0-询价结果待录入,1-询价结果已录入,2-指令/建议待复核,2A-预置指令/建议待确认,3-待投资经理确认,4-待风控审批,
				//5-待交易录单,6-待录单复核,7-待前台成交,8-前台已成交,9-后台已成交
				if((record.cRiskStatus=='0' || record.cRiskStatus=='1')&&record.vcRiskType=='2'){	//交易禁止
					e.rowCls = "processStatus_forbid_zlgl";
				}else if(record.vcProcessStatus=="4" || record.cRiskStatus=='0' || record.cRiskStatus=='1'){
					e.rowCls = "processStatus_4_zlgl";
				}else if(record.vcProcessStatus=="2" && record.lFixValidStatus=="3"){//等待O32反馈
					e.rowCls = "processStatus_3after_zlgl";
				}else if(record.vcProcessStatus=="5"){
					e.rowCls = "processStatus_5or6_zlgl";
				}else if( record.vcProcessStatus=="6"){
					e.rowCls = "processStatus_5_zlgl";
				}else if(record.vcProcessStatus=="7"){
					e.rowCls = "processStatus_7_zlgl";
				}else if(record.vcProcessStatus=="8"){
					e.rowCls = "processStatus_8_zlgl";
				}else if(record.vcProcessStatus=="9"){
					e.rowCls = "processStatus_9_zlgl";
				}
			}
			if(field=="lResultDate" || field=="lTradeDate" || field=="lFirstSettleDate" || field=="lMaturitySettleDate"){
				if(value){
					e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
				}
			}
			if(field=="vcProductName" && record.vcAvailResult=="false"){
				e.cellHtml = '<span title="'+value+'，可用不足！"'
				+' style="background: url('+nui.context+'/common/nui/themes/default/images/messagebox/icon-warning.gif);'
				+'background-size:20px 15px;background-repeat:no-repeat; '
				+'padding-left: 24px;">'+value+'</span>';
			}
	    });
	    
	    //自动刷新功能处理
    	var autoRefreshValOld = nui.get("autoRefresh").getValue();//获取默认自动刷新时间
	    var autoRefreshReturnVal= self.setInterval("autoRefreshFun()",eval(autoRefreshValOld)*1000);//设置自动刷新时间默认3分钟
	    function autoRefreshFun(){
	    	autoSearch();//同时刷新查询列表数据
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
    		todays_instruct_grid.reload("com.cjhxfund.ats.sm.comm.InstructionManager.queryCombineInstructInfo.biz.ext");
    		clearDetail();
    	}
    	
    	function reset(){
    		today_instruct.clear();
        	nui.get("lTradeDateMin").setValue(todayDate);
			nui.get("lTradeDateMax").setValue(todayDate);
    	}
    	
    	function selectionchanged(){
    		nui.get("deal").disable();
			nui.get("matchInstruct").disable();
    		var rows = selectArr;
			if(rows.length == 1){
				var row = rows[0];
				var dealDetailTab = tabDetailRole.getTab("dealDetail");
				if(row.vcInstructSource=="3"){		// 3-二级债 其他为老机器猫
					
					tabDetailRole.updateTab("riskDetailTab",{visible:true});
					tabDetailRole.updateTab("approveTab",{visible:true});
					tabDetailRole.updateTab("editHistory",{visible:true});
					// 批量复核和回退按钮控制
					if(row.vcProcessStatus ==6 && row.cIsValid==1){
						if (row.smJyyCheckUser != null) {
							nui.get("deal").enable();
						}
					}
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
		    		if(row.cIsValid==1){
						if(row.vcProcessStatus ==5){
							if (row.smJyyConfirmRelateTypeUser != null) {
								nui.get("deal").enable();
							}else{
								nui.get("deal").disable();
							}
						}
						if(row.vcProcessStatus == 4 || row.vcProcessStatus == 5 || row.vcProcessStatus == 6 || row.vcProcessStatus == 7){
							nui.get("matchInstruct").enable();
						}
		    		}
					viewFlowChartButton.enable();
				}else{
					// 机器猫指令不显示风控审批信息和流程审批信息
					tabDetailRole.updateTab("riskDetailTab",{visible:false});
					tabDetailRole.updateTab("approveTab",{visible:false});
					tabDetailRole.updateTab("editHistory",{visible:false});
	    			// 批量确认按钮控制
					if (row.jqmJyyConfirmRelateTypeUser != null) {
						nui.get("deal").enable();
					}else{
						nui.get("deal").disable();
					}
					viewFlowChartButton.disable();
				}
				showDetail(row);
			}else {
				if(rows.length >1){
		    		// 确认复核条数
		    		var dealCount = 0;
		    		// 不可操作的条数
		    		var count = 0;
					for(var i=0; i<rows.length; i++){
						if(rows[i].vcInstructSource=="3"){		// 3-二级债 其他为老机器猫
						
							// 批量确认按钮控制
							if(rows[i].vcProcessStatus ==5 && rows[i].cIsValid==1){
								if (rows[i].smJyyConfirmRelateTypeUser != null) {
									dealCount+= 1;
								}else{
									count+= 1;
								}
							// 批量复核和回退按钮控制
							}else if(rows[i].vcProcessStatus ==6 && rows[i].cIsValid==1){
								if (rows[i].smJyyCheckUser != null) {
									dealCount+= 1;
								}else{
									count+= 1;
								}
							}else{
								count+= 1;
							}
						}else{			//机器猫业务
							if (rows[i].jqmJyyConfirmRelateTypeUser != null) {
								dealCount+= 1;
							}else{
								count+= 1;
							}
						}
					}
					
					if(dealCount>0 && count>0){
						nui.get("deal").disable();
					}else if(dealCount>0 && count==0){
						nui.get("deal").enable();
					}else{
						nui.get("deal").disable();
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
	    	return nui.getDictText("bizTypeRepurchase",e.row.vcBizType);
	    }
	    //委托方向列字典翻译
	    function renderEntrustDirection(e){
	    	return nui.getDictText("entrustDirectionRepurchase",e.row.vcEntrustDirection);
	    }
	    
	    //交易市场列字典翻译
	    function renderMarket(e){
	    	return nui.getDictText("tradePlace",e.row.vcMarket);
	    }
	    
	    //清算速度列字典翻译
	    function renderSettleSpeed(e){
	    	return nui.getDictText("settleSpeed",e.row.vcSettleSpeed);
	    }
	    
	    //报价方式列字典翻译
	    function renderQuoteMode(e){
	    	return nui.getDictText("quoteMode",e.row.vcQuoteMode);
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
	    //下拉框清除按钮功能
	    function onCloseClick(e){
	    	var obj = e.sender;
            obj.setText("");
            obj.setValue("");
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
		function getProductHandleByDealCheck(lResultId) {
			var url = "";
			var result = false;
			url = "com.cjhxfund.ats.sm.comm.InstructionManager.queryCheckUsersByInstructResultId.biz.ext";
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
		
		// 单条退回录单操作
		function rollbackDealEntering(rowid){
			var selectValue = todays_instruct_grid.getRow(rowid);
			if(rowid == undefined){
				selectValue = todays_instruct_grid.getSelected();			
			}
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
										//nui.get("rollback").disable();
										search();
									}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
										//nui.get("rollback").disable();
										search();
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
			
			var selectValue = selectArr;
			if(selectValue.length > 0){
				for (var i = 0; i < selectValue.length; i++) {
					if (selectValue[i].vcProcessStatus != 6
							|| selectValue[i].cIsValid !=1) {
						nui.alert("只能操作可回退的记录！", "系统提示");
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
											//nui.get("rollback").disable();
											search();
											clearDetail();
										}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
											search();
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
		
		// 机器猫和二级债指令录单确认（批量）（批量处理二级债待复核和待录单确认和机器猫待确认的记录）
		function batchDeal() {
			var rows = selectArr;
			var jsonParams = null;
    		var instructList = new Array();
			if(rows.length>20){
				nui.alert("批量确认记录不能大于20条","提示");
				return;
			}
        	// 开始处理
			if(rows.length>0){
				for (var i = 0; i < rows.length; i++) {
					// 3-二级债 其他为老机器猫
					if(rows[i].vcInstructSource=="3"){
						if (rows[i].vcProcessStatus != 5 && rows[i].vcProcessStatus != 6
								&& rows[i].cIsValid!=1) {
							nui.alert("只能操作待录单确认或待复核的记录！", "系统提示");
							return;
						}
						//封装主键ID字段传输到后台处理开始...
			    		jsonParams = {processId: rows[i].lResultId, vcInstructSource: rows[i].vcInstructSource, processStatus: rows[i].vcProcessStatus};
			    		instructList.push(jsonParams);
	    			}else{		//机器猫业务处理
	    			
	    			//----------------------机器猫业务开始--------------------------------------------------
	    				var record = rows[i];//产品记录
	    				// 机器猫买卖指令参数
			    		var validStr = "";//有效无效验证字符串
						var combProductName = record.vcProductName;//产品名称
						var investProductNum = record.vcProductCode;//编号
			        	var validStatus = record.cIsValid;
			        	var processStatus = record.vcProcessStatus;
			        	
			        	if(validStatus!="1"){
			        		validStr += "、" + investProductNum + "-" + combProductName;
			        	}
			    		if(validStr!=null && validStr!="" && validStr.length>0){
			    			validStr = validStr.substr(1,validStr.length);
			    			var msg = "【"+validStr+"】</br>指令/建议已无效或退回，请先剔除";
			    			nui.alert(msg,"提示");
			    			return;
			    		}
			    		//有效无效验证结束!!!
			    		
			    		
			    		//权限验证开始...
			    		var permissionStr = "";//权限验证字符串
			        	//投顾尚未确认
			        	if(processStatus=="1" || processStatus=="2" || processStatus=="3"){
			        		permissionStr += "、" + investProductNum + "-" + combProductName;	
						//交易确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
			        	}else if(processStatus=="5" || processStatus=="6" || processStatus=="7"){
			        		var hasPermission = false;//是否有权限，默认无
							if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
								var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
								for(var j=0; j<tradingConfirmAuthorityUserIdsArr.length; j++){
									var userIdTemp = tradingConfirmAuthorityUserIdsArr[j];
									if(userIdTemp==userId){
										hasPermission = true;
										break;
									}
								}
							}
							if(hasPermission==false){
								permissionStr += "、" + investProductNum + "-" + combProductName;
							}
			        	
			        	//后台已成交确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
			        	}else if(processStatus=="8"){
			        		var hasPermission = false;//是否有权限，默认无
							if(backstageConfirmAuthorityUserIds!=null && backstageConfirmAuthorityUserIds!=""){
								var backstageConfirmAuthorityUserIdsArr = backstageConfirmAuthorityUserIds.split(",");
								for(var j=0; j<backstageConfirmAuthorityUserIdsArr.length; j++){
									var userIdTemp = backstageConfirmAuthorityUserIdsArr[j];
									if(userIdTemp==userId){
										hasPermission = true;
										break;
									}
								}
							}
							if(hasPermission==false){
								permissionStr += "、" + investProductNum + "-" + combProductName;
							}
			        	}
			    		if(permissionStr!=null && permissionStr!="" && permissionStr.length>0){
			    			permissionStr = permissionStr.substr(1,permissionStr.length);
			    			var msg = "您没有权限确认【"+permissionStr+"】指令/建议，请先剔除";
			    			nui.alert(msg,"提示");
			    			return;
			    		}
			    		//权限验证结束!!!
			    		
			    		
			    		//封装主键ID字段传输到后台处理开始...
			    		jsonParams = {processId: record.lResultId, vcInstructSource: record.vcInstructSource, processStatus: rows[i].vcProcessStatus};
			    		instructList.push(jsonParams);
	    			}
				}
				var msg = "确定要确认所选的 " + rows.length + " 条指令/建议吗？";
	    		nui.confirm(msg,"系统提示",function(action){
					if(action=="ok"){
						var a = nui.loading("正在处理中,请稍等...","提示");
						nui.ajax({
					    	url: "com.cjhxfund.ats.unionBiz.instructManager.batchConfrimSmAndJqmZqmmInstruct.biz.ext",
					      	type: 'POST',
					      	data: {instructList:instructList, webType:'2'},			// webType:1买卖指令，2回购指令
					      	contentType: 'text/json',
					      	success: function(text){
					      		nui.hideMessageBox(a);
					      		var returnJson = nui.decode(text);
					      		if(returnJson.resultInfoList.length>0){
					      			nui.open({
							            url: "<%=request.getContextPath()%>/sm/comm/instruct/query/repurchase/instructApproveResultInfoList.jsp",
							            title: "审批返回信息",
							            width: 700,
							            height: 415,
							            onload: function () {
							                var iframe = this.getIFrameEl();
							                returnJson.resultInfoList["tradingConfirmAuthorityUserIds"] = tradingConfirmAuthorityUserIds;
							                returnJson.resultInfoList["backstageConfirmAuthorityUserIds"] = backstageConfirmAuthorityUserIds;
							                // 直接从页面获取，不用去后台获取
							                iframe.contentWindow.setFormData(returnJson.resultInfoList);
							            },
							            ondestroy: function (action) {//弹出页面关闭前
											search();
										}
							        });
					      		}
					      	}
				 		});
					}
				});
			} else {
				nui.alert("请选中一条记录","提示");
			}
		}
		
		// 生成本币接口文件
        function exportBbExcel(){
			var exportTradeDateMin = nui.get("lTradeDateMin").getValue();
			var exportTradeDateMax = nui.get("lTradeDateMax").getValue();
        	if(todays_instruct_grid.data.length>0){
				var rows = selectArr;
				// 定义弹窗提示信息
				var msg = "您未选中指令/建议，将导出全部指令/建议，确定要导出吗?";
				//判断要导出的指令/建议中是否存在多个产品
			    for(var i = 0; i<rows.length; i++){
			    	if(rows[i].cIsValid != "1" || rows[i].vcProcessStatus == "4"){
			    		nui.alert("无效和风控中的记录不能导出","系统提示");
			           return;
			    	}
			    	if(rows[i].vcBizType != "5" && rows[i].vcBizType != "6"){
		    			nui.alert("只能导出银行间质押式回购和银行间买断式回购的指令/建议","系统提示");
			            return;
			    	}
			    }
		    	
				// 定义流程id
				var lResultNo = "";
				if(rows.length>0){
					msg = "您已选中 " + rows.length + " 条记录，确定要导出吗?";
					// 拼接流程实例id
					for(var i=0; i<rows.length; i++){
						lResultNo+= rows[i].lResultNo+",";
					}
					//去掉最后一个逗号
				    if (lResultNo.length > 0) {
				        lResultNo = lResultNo.substr(0, lResultNo.length - 1);
				    }
				}
				// 设置导出form参数
				if(lResultNo != null){
					document.getElementById("lResultNo").value = lResultNo;
				}
	        	if(exportTradeDateMin != null && exportTradeDateMin != ""){
	        		document.getElementById("exportBbTradeDateMin").value = DateUtil.toNumStr(exportTradeDateMin);
	        	}else{
	        		document.getElementById("exportBbTradeDateMin").value = DateUtil.toNumStr(new Date());
	        	}
	        	if(exportTradeDateMax != null && exportTradeDateMax != ""){
	        		document.getElementById("exportBbTradeDateMax").value = DateUtil.toNumStr(exportTradeDateMax);
	        	}else{
	        		document.getElementById("exportBbTradeDateMax").value = DateUtil.toNumStr(new Date());
	        	}
				// 页面流跳转
				nui.confirm(msg,"系统提示",function(action){
					if(action=="ok"){
						nui.get("export_todayInstruct_bb").disable();//禁用“导出”按钮
						var form = document.getElementById("bbExport_FROM");
						form.action = "com.cjhxfund.ats.sm.comm.ExprotExcleByResultId.flow";
				        form.submit();
				        //启用“导出”按钮
				        setTimeout("enableBbExport()",15000);
				        document.getElementById("lResultNo").value = "";
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
		
		//跨页多选选择表格获取基金产品
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
		
		//行双击时弹出页面展示该指令/建议明细信息
	    todays_instruct_grid.on("rowdblclick", function (e) {
	    	var row = e.record;
	    	var url ="";
	    	var iframeHeight = 0;
	    	// 5质押式回购，6买断式回购， 7协议式回购
	    	if(row.vcBizType == "5"){
	    		url = "<%=request.getContextPath()%>/sm/comm/instruct/query/repurchase/instructDetailShow_znhg_zyshg_jyy.jsp";
	    		iframeHeight = 600;
	    	}else if(row.vcBizType == "6"){
	    		url = "<%=request.getContextPath()%>/sm/comm/instruct/query/repurchase/instructDetailShow_znhg_mdshg_jyy.jsp";
	    		iframeHeight = 600;
	    	}else if(row.vcBizType == "7" || row.vcBizType == "10" || row.vcBizType == "11"){
	    		url = "<%=request.getContextPath()%>/sm/comm/instruct/query/repurchase/instructDetailShow_znhg_xyshg_jyy.jsp";
	    		iframeHeight = 600;
	    	}
		    if (row) {
		    	nui.open({
		            url: url,
		            title: "指令/建议详细展示",
		            width: 750,
		            height: iframeHeight,
		            onload: function () {
		                var iframe = this.getIFrameEl();
		                row["tradingConfirmAuthorityUserIds"] = tradingConfirmAuthorityUserIds;
		                row["backstageConfirmAuthorityUserIds"] = backstageConfirmAuthorityUserIds;
		                // 直接从页面获取，不用去后台获取
		                iframe.contentWindow.setFormData(row);
		            },
		            ondestroy: function (action) {//弹出页面关闭前
				    	if(action == "ok"){
							search();
						}
			        }
		        });
		    }
	    });
	    
	    // 加载指令详情页面
	    function goInstructDetail(rowid){
	    	var row = todays_instruct_grid.getRow(rowid);
			if(rowid == undefined){
				row = todays_instruct_grid.getSelected();			
			}
	    	var url ="";
	    	var iframeHeight = 0;
	    	// 5质押式回购，6买断式回购， 7协议式回购
	    	if(row.vcBizType == "5"){
	    		url = "<%=request.getContextPath()%>/sm/comm/instruct/query/repurchase/instructDetailShow_znhg_zyshg_jyy.jsp";
	    		iframeHeight = 600;
	    	}else if(row.vcBizType == "6"){
	    		url = "<%=request.getContextPath()%>/sm/comm/instruct/query/repurchase/instructDetailShow_znhg_mdshg_jyy.jsp";
	    		iframeHeight = 600;
	    	}else if(row.vcBizType == "7" || row.vcBizType == "10" || row.vcBizType == "11"){
	    		url = "<%=request.getContextPath()%>/sm/comm/instruct/query/repurchase/instructDetailShow_znhg_xyshg_jyy.jsp";
	    		iframeHeight = 600;
	    	}
		    if (row) {
		    	nui.open({
		            url: url,
		            title: "指令/建议详细展示",
		            width: 750,
		            height: iframeHeight,
		            onload: function () {
		                var iframe = this.getIFrameEl();
		                row["tradingConfirmAuthorityUserIds"] = tradingConfirmAuthorityUserIds;
		                row["backstageConfirmAuthorityUserIds"] = backstageConfirmAuthorityUserIds;
		                // 直接从页面获取，不用去后台获取
		                iframe.contentWindow.setFormData(row);
		            },
		            ondestroy: function (action) {//弹出页面关闭前
						if(action == "ok"){
							search();
						}
			        }
		        });
		    }
	    }
	    
	    //查看流程图
		function viewFlowChart(){
			window.open(nui.context+"/com.cjhxfund.foundation.task.ProcessChart.flow?processInstID="+selectArr[0].lProcessinstId);
		}
		
		var tradingConfirmAuthorityUserIds = "";//交易确认阶段权限人员名单字符串
	    var backstageConfirmAuthorityUserIds = "";//后台已成交阶段权限人员名单字符串，确认时使用
	    //页面加载完成后处理逻辑函数
	    function onloadFun(){
	    	//获取交易确认阶段权限人员名单，权限关系类型：01-产品与投资顾问权限；02-产品与投资经理下单权限；03-产品与交易员填单权限；04-产品与复核员[交易发送]权限；05-产品与前台已成交权限；06-产品与后台已成交员权限；98-后台已成交确认阶段权限；99-交易确认阶段权限；
	    	$.ajax({
	            url:"com.cjhxfund.commonUtil.ProductManager.getTradingConfirmAuthority.biz.ext",
	            type:'POST',
	            data:null,
	            cache:false,
	            contentType:'text/json',
	            success:function(text){
	                var returnJson = nui.decode(text);
	                if(returnJson.exception == null){
	                	tradingConfirmAuthorityUserIds = returnJson.userIds99;//交易确认阶段权限人员名单字符串，确认时使用
				        backstageConfirmAuthorityUserIds = returnJson.userIds98;//后台已成交阶段权限人员名单字符串，确认时使用
	                }else{
	                    nui.alert("权限人员名单获取失败", "系统提示");
	                }
	            }
	        });
	    }
	    
	    // 同步对手交易库
		function refresh_pinyin(){
			var a = nui.loading("正在处理中,请稍等...","提示");
			$.ajax({
				url:"com.cjhxfund.ats.sm.comm.TraderivalManager.TraderivalToPinyin.biz.ext",
				type:'POST',
				cache: false,
				contentType:'text/json',
				success:function(text){
					var returnJson = nui.decode(text);
					if(returnJson.reCode == 0){
						nui.alert("同步交易对手成功", "系统提示");
					}else{
						nui.alert("同步交易对手失败", "系统提示");
					}
					nui.hideMessageBox(a);
				}
			});
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
		
		//翻译指令来源
	    function rendererInstructResource(e){
	    	return nui.getDictText("instructResource", e.row.instructSource);
	    }
	    
	    function openSetEnterCheckUser(){
			// 加载选择复核人页面
			nui.open({
				url : "<%=request.getContextPath()%>/transaction/manage/deal_entering/setEnteringCheckUser.jsp",
			    title: "设置默认复核人", 
			    width: 283, 
			    height: 327,
			    onload: function () {
			        var iframe = this.getIFrameEl();
			        iframe.contentWindow.SetData("","set");
			    },
			    ondestroy: function (action) {
				    if(action == "ok"){
						search();
					}
        		}
			});
		}
		
		//fix发送状态
	    function fixValidStatusRenderReview(e){
	    	if(e.value == null || e.value == "0"){
	    		return "未发送";
	    	}else if(e.value == "-1"){
	    		return "--";
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
	    
	    // 回购金额（质押式回购显示，买断式回购不显示）
	    function enFaceAmountRenderReview(e){
	    	if(e.row.vcBizType == "6"){
	    		return "";	
	    	}else {
	    		return e.cellHtml;	
	    	}
	    }
	    
	    //匹配指令/建议要素
	    function matchInstruct(){
	    	var rows = selectArr;
	    	if(rows.length==1){
	    		if(rows[0].lTradeDate == DateUtil.toNumStr(new Date())){
	    			nui.open({
					    url : nui.context+"/sm/comm/instruct/query/manualMatchInstruct.jsp",
						title : "手工指令/建议匹配",
						width : 400,
						height: 160,
						onload: function () {
							var iframe = this.getIFrameEl();
							iframe.contentWindow.setMatchData(rows[0]);
		        		},
						ondestroy: function (action) {
							if(action == "ok"){
								search();
							}
						}
					});
	    		}else{
	    			nui.alert("只能对交收日期为当天的数据进行指令/建议要素匹配","系统提示");
	    			return;
	    		}
	    	}else if(rows.length==0){
	    		nui.alert("请选择一条数据进行指令/建议要素匹配","系统提示");
	    		return;
	    	}else{
	    		nui.alert("每次只能选择一条数据进行指令/建议要素匹配","系统提示");
	    		return;
	    	}
	    }
	    
	    // 业务类别
	    function changedBizType(e){
	    	var entrustDirectionCombo = nui.get("vcEntrustDirection");
	    	var bizTypeValue = e.value;
	    	var entrustDirection = nui.get("vcEntrustDirection").getValue();
	    	var smData = [{value: '5', text: '正回购'}, {value: '6', text: '逆回购'}];
	    	var jqmXysData = [{value: '15', text: '正回购'}, {value: '16', text: '逆回购'}];
	    	var allData = [{value: '5,15', text: '正回购'}, {value: '6,16', text: '逆回购'}];
	    	if(bizTypeValue != null){
	    		if(bizTypeValue == '7'){
	    			nui.get("vcEntrustDirection").setData(jqmXysData);
	    		}else if(bizTypeValue == '5' || bizTypeValue == '6' || bizTypeValue == '10'){
	    			nui.get("vcEntrustDirection").setData(smData);
		    	}else{
	    			nui.get("vcEntrustDirection").setData(allData);
	    			if(entrustDirection == '5' || entrustDirection == '15'){
	    				entrustDirection = '5,15';
	    			}else if(entrustDirection == '6' || entrustDirection == '16'){
	    				entrustDirection = '6,16';
	    			}
	    			nui.get("vcEntrustDirection").setValue(entrustDirection);
	    			entrustDirectionCombo.selects(entrustDirection);
	    			alert(nui.get("vcEntrustDirection").getValue());
	    			
		    	}
	    	}
	    }
	    
	    // 委托方向
	    function changedEntrustDirection(e){
	    	var bizTypeValue = nui.get("vcBizType").getValue();
	    	var entrustDirection = e.value;
	    	var entrustDirections = entrustDirection.split(",");
	    	if(bizTypeValue != null){
	    		var strs= bizTypeValue.split(",");
	    		if(strs.length>1){
		    		for(var i=0; i<strs.length; i++ ){ 
						if(strs[i] == '7'){
							if(entrustDirection!= null && entrustDirections.length == 1){
								nui.get("vcEntrustDirection").setValue('5,15');
							}else{
								nui.get("vcEntrustDirection").setValue('5,6,15,16');
							}
						}
					} 
	    		}
	    	}
	    }
	    
	    //查询--所有业务通用
		function autoSearch() {
			//获取之前选中记录的主键ID，刷新后继续选中之前记录
			var rows_search = selectArr;
			var rowIds_search = "";
			for(var i=0; i<rows_search.length; i++){
				rowIds_search += rows_search[i].lResultId;
				if(i<rows_search.length-1){
					rowIds_search += ",";
				}
			}
			//开始查找记录
		    var form = new nui.Form(today_instruct);
		    var json = form.getData(false,false);
		    todays_instruct_grid.load(json,function(){
		    	//选中刷新前选中的记录
		    	var rows = todays_instruct_grid.findRows(function (row) {
		    		var exist = false;
		    		if(rowIds_search!=null && rowIds_search!=""){
		    			var rowIdsArr = rowIds_search.split(",");
		    			for(var i=0; i<rowIdsArr.length; i++){
		    				if (row.lResultId == rowIdsArr[i]){
			                	exist = true;
			                	break;
			                }
		    			}
		    		}
		    		return exist;
	            });
	            todays_instruct_grid.selects(rows);
		    });
		}
	</script>
</body>
</html>