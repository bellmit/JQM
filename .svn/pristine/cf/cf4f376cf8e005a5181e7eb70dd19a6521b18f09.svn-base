<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-09-03 14:27:32
  - Description:预置指令/建议（指令/建议跟踪）
-->
<head>
	<title>预置指令/建议</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/css/instruct.css"/>
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script> 
    
</head>
<body style="height:100%; width:100%; overflow:hidden; margin:0;padding:0;">
<div id="layout1" class="mini-layout" style="width:100%; height:100%;"  borderStyle="border:0px;">
	<div>
		<!-- 查询条件开始 -->
		<div class="search-condition">
		   	<div class="list">
		   		<!-- 业务标签:预置指令/建议  -->
		   		<input class="nui-hidden" id="queryType" name="queryType" value="presetInstruction"/>
		   		<!-- 委托方向:01-买入  02–卖出  -->
				<input class="nui-hidden" id="entrustDirection" name="entrustDirection" value="'3','4'"/>
				<!-- 指令/建议有效状态:1-有效, 2-无效-已修改   3-无效-已撤销    4-无效-被退回  -->
				<input class="nui-hidden" id="cIsValid" name="cIsValid" value="1,3,4"/>
			    <div id="form_preset_instruct" class="nui-form" style="padding:2px;height:10%;max-width:100%" align="left">
	                <table id="instruct_follow_condition" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
	                	<tr>
	                		<td width="60px" align="right">
								产品名称:
	                        </td>
	                        <td colspan="1" width="20%" align="left">
	                            <input id="vcProductCode" class="nui-buttonedit" name="vcProductCode" emptyText="全部" showClose="true" oncloseclick="onCloseClick" onbuttonclick="ButtonClickGetFundName_presetInstruct" style="width:95%"/>
	                        </td>
							<td width="60px" align="right">业务类别:</td>
							<td colspan="1" width="20%" align="left">
								<input class="nui-dictcombobox" id="vcBizType" name="vcBizType" multiSelect="true"
									valueField="dictID" textField="dictName" dictTypeId="bizDirectionCombiTransaction" 
									emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
							</td>
							<td width="60px" align="right">指令/建议序号:</td>
							<td colspan="1" width="20%" align="left">
								<input class="nui-textbox" id="instructNo" name="instructNo" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
							</td>
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
							<td width="60px" align="right">
		                		<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
		                	</td>
		                	<td width="60px" align="right">
								<input class='nui-button' plain='false' text="重置" iconCls="icon-reset" onclick="reset()"/>
		                	</td>
		                	<td colspan="1" width="20%" align="left">
								<a class="nui-menubutton " plain="false" menu="#popupMenu"
	                               id="searchCond"
	                               name="searchCond"
	                               data-options='{formId:"form_preset_instruct"}'
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
	   <div class="nui-toolbar" style="border-bottom:0;padding:0px">
	    	<table border="0" cellpadding="0" cellspacing="0" style="width:100%;table-layout:fixed;">
	            <tr>
	                <td style="width:50%;">
	                	<a id="addInstruct" class='nui-button' plain='false' iconCls="icon-add" onclick="addInstruct()">新增</a>
	                    <a id="edit" enabled="false" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">修改</a>&nbsp;
	                    <a id="remove" enabled="false" class='nui-button' plain='false' iconCls="icon-remove" onclick="onCancle()">撤销</a>&nbsp;
	                    <a class='nui-button' plain='false' iconCls="icon-download" id="export_presetInstruct" onclick="exportExcel()">导出指令/建议</a>
	                </td>
	            </tr>
	        </table>
	    </div>
	    <%-- 列表操作工具结束... --%>
	    <div class="nui-fit" style="width:100%; height:100%;overflow:hidden;">
		    <div id="treegrid_preset_instruct" class="nui-treegrid" style="width:100%;height:100%;"
				 url="com.cjhxfund.ats.sm.comm.InstructionManager.queryRightInstructInfos.biz.ext" 
				 dataField="insructInfos" treeColumn="lInstructNo"
				 showPager="true" pageSize="10" frozenStartColumn="0" frozenEndColumn="6"
				 showTreeIcon="false" showTreeLines="false" multiSelect="true"
				 onselectionchanged="selectionchanged"
				 onbeforeload="onBeforeTreeLoad"
				 pagerButtons="#prompts_preset">
			    <div property="columns">
			        <div type="checkcolumn" ></div> 
			        <div field="lInstructNo" name="lInstructNo" headerAlign="center" width="80px">
		                指令/建议序号
		            </div>
		            <!--<div field="cIsValid" headerAlign="center" width="85px" renderer="renderInstructStatus">
		                指令/建议状态
		            </div>-->
		            <!--<div field="vcInstructType" headerAlign="center" width="85px" renderer="renderInstructType">
		                指令/建议类型
		            </div>-->
		            <div field="vcProductName" headerAlign="center" width="130px">
		               产品名称
		            </div>
		            <div field="vcCombiName" headerAlign="center" width="120px">
		                组合名称
		            </div>
		            <!--<div field="vcBizType" headerAlign="center" width="120px" renderer="renderBizType">
		                业务类别
		            </div>-->
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
		                证券代码
		            </div>
		            <div field="vcStockName" headerAlign="center" width="120px">
		                证券名称
		            </div>
		            <!--<div field="vcMarket" headerAlign="center" width="85px" renderer="renderMarket">
		                交易市场
		            </div>-->
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
		            <div field="vcAdviserConfirm" headerAlign="center" width="200px">
		                投顾确认时间
		            </div>
		            <div field="vcEntrustConfirm" headerAlign="center" width="200px">
		                委托人确认时间
		            </div>
		           <!-- <div field="tResultInputTime" headerAlign="center" renderer="resultRenderReview" width="200px">
		                询价结果录入时间
		            </div>-->
		            <div field="vcRemark" headerAlign="center" width="85px">
		                备注
		            </div>
			    </div>
		    </div>
		</div>
		
	    <div id="prompts_preset">
	        <span class="separator"></span>
	     	<div class="invaliddata"></div>
	        <div style= "display: inline-block; margin-right: 8px;">无效</div>
	       	<div class="backdata"></div>
	        <div style= "display:inline-block; margin-right: 8px;">退回</div>
	    </div> 
    </div>
    <%-- 详细开始... --%>
    <div title="指令/建议相关信息" region="south" showSplit="false" height="260px" showHeader="true" showSplitIcon="true" >
	    <div class="nui-fit">
	    	<div id="tabs_instruct_follow_detail" class="nui-tabs" activeIndex="0" onactivechanged="activechanged" height="100%">
		    	<div title="指令/建议明细" url="<%= request.getContextPath() %>/sm/comm/instruct/query/tansaction/instructDetail.jsp"></div>
		    	<div title="修改历史" url="<%= request.getContextPath() %>/sm/comm/instruct/query/tansaction/reviseHistory.jsp"></div>
		    	<div title="流程审批信息" url="<%= request.getContextPath() %>/sm/comm/instruct/processApproval.jsp"></div>
		    </div>
	    </div>
    </div>
	<%-- 详细结束... --%>
</div>
	<!-- 导出参数 -->
	<div>
		<form id="export_FROM" method="post">
			<!-- 业务标签:预置指令/建议  -->
	   		<input class="nui-hidden" id="queryType" name="queryType" value="presetInstruction"/>
			<!-- 委托方向:01-买入  02–卖出  -->
			<input class="nui-hidden" id="entrustDirection" name="entrustDirection" value="'3','4'"/>
			<input class="nui-hidden" name="exportVcBizType" id="exportVcBizType" value="">
			<input class="nui-hidden" name="sheetName" id="sheetName" value="买卖预置指令/建议_">
			<!--  导出类型（买卖指令/建议1,回购指令/建议2）-->
			<input class="nui-hidden" name="exportType" id="exportType" value="1">
			<input class="nui-hidden" name="exportVcEntrustDirection" id="exportVcEntrustDirection" value="">
			<input class="nui-hidden" name="exportVcProductCode" id="exportVcProductCode" value="">	
			<!--  页面类型:指令/建议查询1,指令/建议管理2 -->
			<input class="nui-hidden" name="webType" id="webType" value="2">
			<input class="nui-hidden" name="lInstructNo" id="lInstructNo" value="">
		</form>	
	</div>
	<!-- 导出参数结束 -->
	<script type="text/javascript">
    	nui.parse();
    	var preset_instruct = new nui.Form("#form_preset_instruct");
    	var preset_instruct_grid = nui.get("treegrid_preset_instruct");	
    	var tabDetailRole = nui.get("tabs_instruct_follow_detail");//获取详情标签列表
    	var isSigleSelectChanged = false;
    	function onBeforeTreeLoad(e) {
        	var node = e.node;      //当前节点
        	var params = e.params;  //参数对象
	        //可以传递自定义的属性
			var initParam = new nui.Form("#form_preset_instruct").getData(false,false);
	        if(node.lInquiryId){
        		initParam["lInquiryId"] = node.lInquiryId;
        	}
        	initParam["vcProductCode"] = splitString(initParam["vcProductCode"]);
        	initParam["queryType"] = nui.get("queryType").getValue();
        	initParam["entrustDirection"] = nui.get("entrustDirection").getValue();
        	initParam["cIsValid"] = nui.get("cIsValid").getValue();
        	initParam["vcBizType"] = nui.get("vcBizType").getValue();
        	initParam["instructNo"] = initParam["instructNo"];
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
    	preset_instruct_grid.on("drawcell", function (e) {
	        var record = e.record,
	        	field = e.field,
        		value = e.value;
			//设置行样式，交易状态：1-有效；2-无效-已修改；3-无效-已撤销；4-有效-被退回；
			if(record.cIsValid=="3"){
				e.rowStyle='background:#FF6666;';
			}else if(record.cIsValid=="4"){
				e.rowStyle='background:#FF9999;';
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
	    });

    	function search(){
    		preset_instruct_grid.load("com.cjhxfund.ats.sm.comm.InstructionManager.queryRightInstructInfos.biz.ext");
    		clearDetail();
    	}
    	
    	function reset(){
    		preset_instruct.clear();
    	}
    	
    	function selectionchanged(){
			nui.get("remove").disable();
			nui.get("edit").disable();
    		var rows = preset_instruct_grid.getSelecteds();
			if(rows.length == 1){
				var row = preset_instruct_grid.getSelected();
				if(row.cIsValid == 1){
					nui.get("remove").enable();
				}
				nui.get("edit").enable();
				showDetail(row);
			}else {
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
    			currentTabIFrameEl.contentWindow.detail(preset_instruct_grid.getSelected());
    		}
    	}
    	//详情标签切换时处理逻辑
    	function activechanged(){
    		var currentTabIFrameEl = tabDetailRole.getTabIFrameEl(tabDetailRole.getActiveTab());
    		if(typeof(currentTabIFrameEl) != "undefined"){
    			if(isSigleSelectChanged == true){
    				currentTabIFrameEl.contentWindow.detail(preset_instruct_grid.getSelected());
    			}else{
    				currentTabIFrameEl.contentWindow.clearDetail();
    			}
    		}
    	}
	    
	    function edit(){
	    	var rows = preset_instruct_grid.getSelecteds();
	    	if(rows.length != 1){
				nui.alert("请先选中一条记录","提示");
				return;
			}
			var row = preset_instruct_grid.getSelected();
			if(row.lFixValidStatus == 2){
				nui.alert("指令/建议发送O32途中,不可修改","提示");
				return;
			}
			if(!authorityJudgment(row)){
				nui.alert("您没有该产品的操作权限,请先确认！","提示");
				return;
			}
			var url = nui.context+"/transaction/invest/interbank_trade/instructIssue.jsp";
			if(row.vcBizType == "2" || row.vcBizType == "3"){//上海大宗交易、上海固收平台
				url = nui.context+"/transaction/invest/sh_block_trade/instructIssue.jsp";
			}else if(row.vcBizType == "4"){//深圳综合协议平台
				url = nui.context+"/transaction/invest/sz_integrated_prot/instructIssue.jsp";
			}
	    	nui.open({
    			url: url,
    			title: "修改建议", width: 1070, height: 470,
    			onload: function () {
			        var iframe = this.getIFrameEl();
			        row["operatorType"] = "1"; //0-新建指令/建议 1-编辑指令/建议
			        iframe.contentWindow.SetData(row);
    			},
    			ondestroy: function (action) {
    				search();
    			}
			});
	    }
	    
	    function onCancle(){
	    	var rows = preset_instruct_grid.getSelecteds();
	    	if(rows.length == 0){
				nui.alert("请先选中一条记录！","提示");
				return;
			}else if(rows.length > 1){
				nui.alert("请先选中一条记录,只支持单条撤销！","提示");
				return;
			}
			var row = preset_instruct_grid.getSelected();
			if(row.cIsValid != 1){
				nui.alert("	该指令/建议已无效，无需再做撤销操作","提示");
				return;
			}
			if(!authorityJudgment(row)){
				nui.alert("您没有该产品的操作权限,请先确认！","提示");
				return;
			}
			nui.confirm("您是否确认要撤销选中指令/建议？", "指令/建议撤销提示", function(action){
				 if (action == "ok") {
                   var a = nui.loading("正在处理中,请稍等...","提示");
					nui.ajax({
						url : "com.cjhxfund.ats.sm.comm.InstructionManager.instructRevocation.biz.ext",
						type : 'POST',
						data : {instructParameter:row},
						cache : false,
						contentType : 'text/json',
						success : function(text) {
							nui.hideMessageBox(a);
							var returnJson = nui.decode(text);
							if(returnJson.exception == null){
								if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
									nui.alert(returnJson.rtnMsg,"提示");
								}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_NO_RCV_FR_O32%>"){
									nui.alert(returnJson.rtnMsg,"提示");
								}else{
									nui.alert("指令/建议撤销成功","提示");
								}
							}else{
								nui.alert("系统异常","系统提示");
							}
							search();
						}
					});
                }
			});
	    }
	    //指令/建议操作权限判断
	    function authorityJudgment(data){
	    	var result = false;
	    	nui.ajax({
				url : "com.cjhxfund.ats.sm.comm.InstructionManager.authorityJudgment.biz.ext",
				type : 'POST',
				data : {productCode:data.vcProductCode},
				cache : false,
				async: false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						var userIds= new Array(); 
						userIds=returnJson.userIds.split(",");
						for (var i=0; i<userIds.length; i++ ){ 
							if(userIds[i] == returnJson.userId){
								result = true;
								return;
							}
						} 
						result = false;
					}else{
						result = false;
					}
				}
			 });
			return result;
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
	    function onCloseClick(e){
	    	var obj = e.sender;
            obj.setText("");
            obj.setValue("");
	    }
	    
	    // 导出指令/建议
	    function exportExcel(){
			var rows = preset_instruct_grid.getSelecteds();
			// 定义指令/建议序号
			var lInstructNo = "";
			// 定义弹窗提示信息
			//var msg = "您已选中 " + rows.length + " 条记录，确定要导出吗?";
			var msg = "您未选中指令/建议，将导出全部指令/建议，确定要导出吗?";
			//if(rows.length ==null || rows.length<=0){
			//	nui.alert("请先选择一条记录再导出","系统提示");
			//	return;
			//}
			if(rows.length>0){
				msg = "确定要导出吗?";
				// 拼接指令/建议序号
				for(var i=0; i<rows.length; i++){
					lInstructNo+= rows[i].lInstructNo+",";
				}
				//去掉最后一个逗号
			    if (lInstructNo.length > 0) {
			        lInstructNo = lInstructNo.substr(0, lInstructNo.length - 1);
			    }
			}
		   
			// 设置导出form参数
			if(lInstructNo != null){
				document.getElementById("lInstructNo").value = lInstructNo;
			}
			// 页面流跳转
			nui.confirm(msg,"系统提示",function(action){
				if(action=="ok"){
					nui.get("export_presetInstruct").disable();//禁用“导出”按钮
					var form = document.getElementById("export_FROM");
					form.action = "com.cjhxfund.ats.sm.comm.instructExcle.flow";
			        form.submit();
			        //启用“导出”按钮
			        setTimeout("enableExport()",15000);
				}
			});
		}
			
		function enableExport(){
	  		nui.get("export_presetInstruct").enable();
		}
		
		//获取查询条件的产品名称
		function ButtonClickGetFundName_presetInstruct(e){
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
		
		// 添加指令/建议页面跳转
		function addInstruct(){
    		nui.open({
	    		url:"<%=request.getContextPath() %>/transaction/investNew/makeInstruct.jsp",
    			title:"下达投资指令/建议", 
    			width:1180,
    			height:470,
    			allowResize:false,
    				onload:function(){
    			},
    			ondestroy: function (action) {
    				search();
    			}
    		});	
		}
    </script>
</body>
</html>