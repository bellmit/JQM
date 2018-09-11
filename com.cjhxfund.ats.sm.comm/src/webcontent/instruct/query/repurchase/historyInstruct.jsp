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
    <title>历史指令/建议</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/css/instruct.css"/>
	<script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script> 
</head>
<body>
	<div class="search-condition">
   		<div class="list">
   			<!-- 业务标签:历史指令/建议 -->
	   		<input class="nui-hidden" id="queryType" name="queryType" value="historyInstruction"/>
            <!-- 委托方向:01-买入  02–卖出  -->
			<input class="nui-hidden" id="entrustDirection" name="entrustDirection" value="'5','6','15','16','17','18','26','27','30','31'"/>
			<!-- 指令/建议有效状态:1-有效, 2-无效-已修改   3-无效-已撤销    4-无效-被退回  -->
			<input class="nui-hidden" id="cIsValid" name="cIsValid" value="1,3,4"/>
			<div id="form_history_instruct" class="nui-form" style="padding:2px;height:10%;max-width:1000px" align="center">
                <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                	<tr>
						<td width="60px" align="right">
							产品名称:
                        </td>
                        <td colspan="1" width="20%" align="left">
                            <input id="vcProductCode" class="nui-buttonedit" name="vcProductCode" emptyText="全部" showClose="true" oncloseclick="onCloseClick" onbuttonclick="ButtonClickGetFundName_historyInstruct" style="width:95%"/>
                        </td>
						<td width="60px" align="right">委托方向:</td>
						<td colspan="1" width="20%" align="left">
							<input class="nui-dictcombobox" id="vcEntrustDirection" name="vcEntrustDirection" 
								multiSelect="true" valueField="dictID" textField="dictName" dictTypeId="entrustDirectionRepurchase" 
								emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
						</td>
						<td width="60px" align="right">业务类别:</td>
						<td colspan="1" width="20%" align="left">
							<input class="nui-dictcombobox" id="vcBizType" name="vcBizType" multiSelect="true"
								valueField="dictID" textField="dictName" dictTypeId="bizTypeRepurchase" 
								emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
						</td>
						<td class="form_label" width="60px" align="right">交易日期:</td>
						<td colspan="1" width="28%" align="left">
							<input class="nui-datepicker" name="lTradeDateMin" id="lTradeDateMin" style="width:45%;"/>
                    		<span style="width:5%;">-</span>
							<input class="nui-datepicker" name="lTradeDateMax" id="lTradeDateMax" style="width:44%;" />
						</td>
					</tr>
					<tr>
						<td colspan="10" align="left">
                           	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
							<input class='nui-button' plain='false' text="重置" iconCls="icon-reset" onclick="reset()"/>
							<a class="nui-menubutton " plain="false" menu="#popupMenu"
                               id="searchCond"
                               name="searchCond"
                               data-options='{formId:"form_history_instruct"}'
                               iconCls="icon-add">保存此搜索条件</a>
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
                <td style="width:50%;">
                	<!-- <a class='nui-button' plain='false' iconCls="icon-print" onclick="">生成成交单</a>&nbsp;
                  	<a class='nui-button' plain='false' iconCls="icon-upload">上传附件</a>&nbsp;-->
                  	<a class='nui-button' plain='false' iconCls="icon-download" id="export_historyInstruct" onclick="exportExcel()">导出指令/建议</a>
                </td>
            </tr>
        </table>
    </div>
    <div id="treegrid_historys_instruct" class="nui-treegrid" style="width:100%;height:302px;"
    	 url="com.cjhxfund.ats.sm.comm.InstructionManager.queryRightInstructInfos.biz.ext"
		 dataField="insructInfos" treeColumn="lInstructNo"
		 showPager="true" pageSize="10" frozenStartColumn="0" frozenEndColumn="6"
		 showTreeIcon="false" showTreeLines="true" multiSelect="true"
		 showReloadButton="false"
		 onselectionchanged="selectionchanged"
		 onbeforeload="onBeforeTreeLoad"
		 pagerButtons="#prompt_histroys">
	    <div property="columns">
	        <div field="lInstructNo" name="lInstructNo" headerAlign="center" width="80px">
                指令/建议序号
            </div>
            <!--<div field="cIsValid" headerAlign="center" width="85px" renderer="renderInstructStatus">
                指令/建议状态
            </div>-->
            <div field="vcRiskApproveStatus" headerAlign="center" width="85px" renderer="renderRiskApproveStatus">
                风控审批状态
            </div>
            <!--<div field="vcInstructType" headerAlign="center" width="85px" renderer="renderInstructType">
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
            <div field="vcStockCode" headerAlign="center" width="85px">
                债券代码
            </div>
            <div field="vcStockName" headerAlign="center" width="85px">
                债券名称
            </div>
            <div field="lRepoDays" headerAlign="center" width="85px">
                回购天数
            </div>
            <div field="enFaceAmount" headerAlign="center" numberFormat="n4" align="right" width="100px">
               回购金额(万元)
            </div>
            <div field="enRepoRate" headerAlign="center" align="right" width="85px">
               回购利率(%)
            </div>
            <div field="lIssueDate" headerAlign="center" width="110px">
                投资指令/建议录入日期
            </div>
            <div field="lTradeDate" headerAlign="center" width="85px">
                交易日
            </div>
            <div field="lFirstSettleDate" headerAlign="center" width="85px">
               首次结算日
            </div>
            <div field="lMaturitySettleDate" headerAlign="center" width="85px">
                到期结算日
            </div>
             <div field="enFullPriceAmount" headerAlign="center" numberFormat="n2" align="right" width="100px">
               首次结算金额(元)
            </div>
            <div field="enSettleAmount" headerAlign="center" numberFormat="n2" align="right" width="100px">
               到期结算金额(元)
            </div>
            <div field="vcQuoteMode" headerAlign="center" width="130px" renderer="renderQuoteMode">
                报价方式
            </div>
            <div field="enWeightingValue" headerAlign="center" align="right" width="85px">
               加权加点(bp)
            </div>
            <div field="tInitiateTime" headerAlign="center" allowSort="true" align="center" renderer="initiateRenderReview" width="200px">
                投资指令/建议录入时间
            </div>
            <div field="tResultInputTime" headerAlign="center" allowSort="true" align="center" renderer="resultRenderReview" width="200px">
                询价结果录入时间
            </div>
            <div field="vcAdviserConfirm" headerAlign="center" width="200px">
                投资指令/建议复核时间
            </div>
            <div field="vcEntrustConfirm" headerAlign="center" width="200px">
                投资指令/建议确认时间
            </div>
            <div field="tFsSendTime" headerAlign="center" allowSort="true" align="center" renderer="sendRenderReview" width="200px" >
                投资经理确认时间
            </div>
            <div field="tFsOperateTime" headerAlign="center" allowSort="true" align="center" renderer="operateRenderReview" width="200px">
                前台录单时间
            </div>
            <div field="tFsCheckTime" headerAlign="center" allowSort="true" align="center" renderer="checkRenderReview" width="200px">
                前台发送时间
            </div>
            <div field="tFsDealTime" headerAlign="center" allowSort="true" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" width="150px">
                前台成交时间
            </div>
            <div field="vcBsDealStatus" headerAlign="center" allowSort="true" align="center" renderer="bsDealRenderReview" width="140px">
                后台成交状态
            </div>
            <div field="vcRemark" headerAlign="center" allowSort="true" align="center" width="85px">
                备注
            </div>
	    </div>
    </div>
    <%-- 详细开始... --%>
    <div class="nui-fit">
	    <div id="tabs_instruct_follow_detail" class="nui-tabs" activeIndex="0" onactivechanged="activechanged" height="100%">
	    	<div title="指令/建议明细" url="<%= request.getContextPath() %>/sm/comm/instruct/repurchase_instruct/instructDetail.jsp"></div>
	    	<div title="质押券" url="<%= request.getContextPath() %>/sm/comm/instruct/repurchase_instruct/mortgageInfo.jsp"></div>
	    	<div title="成交明细" name="dealDetail" visible="false" url="<%= request.getContextPath() %>/sm/comm/instruct/repurchase_instruct/dealDetail.jsp"></div>
	    	<div title="修改历史" url="<%= request.getContextPath() %>/sm/comm/instruct/repurchase_instruct/reviseHistory.jsp"></div>
	    	<div title="触犯风控" url="<%= request.getContextPath() %>/sm/comm/instruct/violateRiskCtrl.jsp"></div>
	    	<div title="流程审批信息" url="<%= request.getContextPath() %>/sm/comm/instruct/processApproval.jsp"></div>
	    </div>
    </div>
    <%-- 详细结束... --%>
	<div id="prompt_histroys">
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
    <!-- 导出参数 -->
	<div>
		<form id="export_FROM" method="post">
			<!-- 业务标签:历史指令/建议 -->
			<input class="nui-hidden" name="queryType" id="queryType" value="historyInstruction">
			<!-- 委托方向:01-买入  02–卖出  -->
			<input class="nui-hidden" id="entrustDirection" name="entrustDirection" value="'5','6','15','16','17','18','26','27','30','31'"/>
			<input class="nui-hidden" name="exportVcBizType" id="exportVcBizType" value="">
			<!-- 指令/建议有效状态:1-有效, 2-无效-已修改   3-无效-已撤销    4-无效-被退回  -->
			<input class="nui-hidden" id="cIsValid" name="cIsValid" value="1,3,4"/>
			<input class="nui-hidden" name="sheetName" id="sheetName" value="回购历史指令/建议_">
			<!--  导出类型（买卖指令/建议1,回购指令/建议2）-->
			<input class="nui-hidden" name="exportType" id="exportType" value="2">
			<input class="nui-hidden" name="exportVcEntrustDirection" id="exportVcEntrustDirection" value="">
			<input class="nui-hidden" name="exportVcProductCode" id="exportVcProductCode" value="">	
			<!--  页面类型:指令/建议查询1,指令/建议管理2 -->
			<input class="nui-hidden" name="webType" id="webType" value="1">
			<input class="nui-hidden" name="exportTradeDateMin" id="exportTradeDateMin" value="">
			<input class="nui-hidden" name="exportTradeDateMax" id="exportTradeDateMax" value="">		
		</form>	
	</div>
	<!-- 导出参数结束 -->
	<script type="text/javascript">
	    nui.parse();
	   var history_instruct = new nui.Form("#form_history_instruct");
    	var history_instruct_grid = nui.get("treegrid_historys_instruct");	
    	var tabDetailRole = nui.get("tabs_instruct_follow_detail");//获取详情标签列表
    	var isSigleSelectChanged = false;
    	
    	function search(){
    		history_instruct_grid.load("com.cjhxfund.ats.sm.comm.InstructionManager.queryRightInstructInfos.biz.ext");
    		clearDetail();
    	}
    	
    	function reset(){
    		history_instruct.clear();
    	}
    	
    	function onBeforeTreeLoad(e) {
    		var node = e.node;      //当前节点
	        var params = e.params;  //参数对象
	        //可以传递自定义的属性
	        init_history_instruct = new nui.Form("#form_history_instruct");
	        var initParam = init_history_instruct.getData(false,false);
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
    		initParam["vcEntrustDirection"] = splitString(initParam["vcEntrustDirection"]);
        	initParam["queryType"] = nui.get("queryType").getValue();
        	initParam["entrustDirection"] = nui.get("entrustDirection").getValue();
        	initParam["cIsValid"] = nui.get("cIsValid").getValue();
        	initParam["vcBizType"] = splitString(nui.get("vcBizType").getValue());
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
    	history_instruct_grid.on("drawcell", function (e) {
	        var record = e.record,
	        	field = e.field,
        		value = e.value;
			//设置行样式，交易状态：1-有效；2-无效-已修改；3-无效-已撤销；4-有效-被退回；
			if(record.cIsValid=="3"){
				e.rowStyle='background:#FF6666;';
			}else if(record.cIsValid=="4"){
				e.rowStyle='background:#FF9999;';
			}else if(record.cIsValid=="1"){//在指令/建议状态为有效的前提下控制流程样式
				//流程处理状态:0-询价结果待录入,1-询价结果已录入,2-指令/建议待复核,3-待投资经理确认,4-待风控审批,
				//5-待交易录单,6-待录单复核,7-待前台成交,8-前台已成交,9-后台已成交
				if(record.vcProcessStatus=="3" && record.lFixValidStatus=="2"){//等待O32反馈
					e.rowStyle='background:#EEC900;';
				}else if(record.vcProcessStatus=="4"){
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
			if(field=="lIssueDate"){
				e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
			}
			if(field=="lTradeDate"){
				e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
			}
			if(field=="lFirstSettleDate"){
				e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
			}
			if(field=="lMaturitySettleDate"){
				e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
			}
	    });
    	
    	function selectionchanged(){
    		var rows = history_instruct_grid.getSelecteds();
			if(rows.length == 1){
				var row = history_instruct_grid.getSelected();
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
				showDetail(row);
			}else {
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
    			currentTabIFrameEl.contentWindow.detail(history_instruct_grid.getSelected());
    		}
    	}
    	//详情标签切换时处理逻辑
    	function activechanged(){
    		var currentTabIFrameEl = tabDetailRole.getTabIFrameEl(tabDetailRole.getActiveTab());
    		if(typeof(currentTabIFrameEl) != "undefined"){
    			if(isSigleSelectChanged == true){
    				currentTabIFrameEl.contentWindow.detail(history_instruct_grid.getSelected());
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
	    	return nui.getDictText("entrustDirection",e.row.vcEntrustDirection);
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
	    
		//导出指令/建议的excle文件
		function exportExcel(){
			var bizType = nui.get("vcBizType").getValue();
			var vcEntrustDirection = nui.get("vcEntrustDirection").getValue();
			var vcProductCode = nui.get("vcProductCode").getValue();
			var exportTradeDateMin = nui.get("lTradeDateMin").getValue();
			var exportTradeDateMax = nui.get("lTradeDateMax").getValue();
			// 设置导出form参数
			if(bizType != ""){
				nui.get("exportVcBizType").setValue = splitString(bizType);
			}
			if(vcEntrustDirection != ""){
				nui.get("exportVcEntrustDirection").setValue = vcEntrustDirection;
			}
			if(vcProductCode != ""){
				nui.get("exportVcProductCode").setValue = bizType;
			}
			if(exportTradeDateMin != null && exportTradeDateMin != ""){
        		exportTradeDateMin = DateUtil.toNumStr(exportTradeDateMin);
        		document.getElementById("exportTradeDateMin").value = exportTradeDateMin;
        	}
        	if(exportTradeDateMax != null && exportTradeDateMax != ""){
        		exportTradeDateMax = DateUtil.toNumStr(exportTradeDateMax);
        		document.getElementById("exportTradeDateMax").value = exportTradeDateMax;
        	}
			// 定义弹窗提示信息
			var msg = "确定要导出吗?";
			// 页面流跳转
			nui.confirm(msg,"系统提示",function(action){
				if(action=="ok"){			
					nui.get("export_historyInstruct").disable();//禁用“导出”按钮
					var form = document.getElementById("export_FROM");
					form.action = "com.cjhxfund.ats.sm.comm.instructExcle.flow";
			        form.submit();
			        //启用“导出”按钮
			        setTimeout("enableExport()",15000);
				}
			});
		}
	    
	    function enableExport(){
	  		nui.get("export_historyInstruct").enable();
		} 
        
        //获取查询条件的产品名称
		function ButtonClickGetFundName_historyInstruct(e){
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
	</script>
</body>
</html>