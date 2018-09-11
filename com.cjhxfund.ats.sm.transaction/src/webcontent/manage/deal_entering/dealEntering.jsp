<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): wuyanfei
  - Date: 2016-09-14 09:13:45
  - Description:
-->
<head>
	<title>交易录单</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/css/instruct.css"/>
	<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script>
</head>
<body>
	<!-- 查询条件开始 -->
	<div class="search-condition">
	   <div class="list">
	   		<div id="grid-query-form" class="nui-form" align="center">
   				<table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
					<tr>
						<td width="60px" align="right">产品名称:</td>
						<td align="left" width="18%">
    						<div name="parameter/vcProductCode" class="nui-combobox" pinyinField="vcProductCode" id="vcProductCode"
                            	textField="vcProductName" valueField="vcProductCode"
								url="com.cjhxfund.commonUtil.ProductManager.queryProductListByUserIdAndRealtype.biz.ext?realType=04"
								showNullItem="false"
								allowInput="true" 
								emptyText="请输入产品代码或产品名称..."
								nullItemText="请输入产品代码或产品名称..."
								valueFromSelect="true"
								showClose="true"
								style="width:95%;"
								oncloseclick="onCloseClick"
								popupWidth="300">
								<div property="columns">
	                                <div header="产品代码" field="vcProductCode" width="35px"></div>
	                                <div header="产品名称" field="vcProductName"></div>
	                            </div>
                            </div>
    					</td>
						<td width="60px" align="right">委托方向:</td>
						<td align="left" width="18%">
							<input class="nui-dictcombobox" name="parameter/vcEntrustDirection" data="data" valueField="dictID" textField="dictName" dictTypeId="entrustDirectionTransaction"  
							emptyText="全部" nullItemText="全部" style="width:95%" multiSelect="false" showClose="true" valueFromSelect="true" oncloseclick="onCloseClick" />
						</td>
						<td align="left">
                            <ul id="popupMenu" class="mini-menu" style="display:none;width:250px;"></ul>
							<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search"/>
							<input class='nui-button' plain='false' text="重置" iconCls="icon-reset" onclick="reset"/>
                            <a class="nui-menubutton " plain="false" menu="#popupMenu"
                               id="searchCond"
                               name="searchCond"
                               data-options='{formId:"grid-query-form"}'
                               iconCls="icon-add">保存此搜索条件
                        	</a>
						</td>
					</tr>
				</table>
			</div>
	  	</div>
   	</div>
	<%-- 查询条件结束!!! --%>
	
	<div style="width:100%;height:80%">
		<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
			<table style="width:100%;">
				<tr>
					<td style="width:50%;">					
						<a class='nui-button' plain='false' iconCls="icon-ok" onclick="batchDeal()">批量确认</a>
						<a class='nui-button' plain='false' iconCls="icon-edit" onclick="editCheckUser()">修改复核人员</a>
						<!--<a class='nui-button' plain='false' iconCls="icon-print">生成成交单</a>-->	
						<a class='nui-button' plain='false' iconCls="icon-download" id="export_dealEntering" onclick="exportExcel()">导出本币接口文件</a>
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
		
		<div id="dealEnteringForm" class="nui-datagrid" style="width:100%;height:46%;" 
		url="com.cjhxfund.ats.sm.comm.InstructionManager.queryTransactionEnteringList.biz.ext" 
		dataField="data"
		allowResize="true"
		pageSize="10"
		sizeList="[10,20,30,50,100]" 
		showPager="true"
		multiSelect="true"
		allowSortColumn="true"
		frozenStartColumn="0" frozenEndColumn="7"
		onselectionchanged="selectionchanged"
	 	pagerButtons="#prompt_todays">
			<div property="columns">
				<div type="checkcolumn" ></div>
				<div name="action" width="100" align="center" headerAlign="center" headerallowSort="true" renderer="value">操作</div>
				<div field="lResultNo" width="80" align="center" headerAlign="center">指令/建议序号</div> 
				<div field="vcRiskApproveStatus" headerAlign="center" renderer="renderRiskApproveStatus" width="100" align="center">风控审批状态</div>    
				<div field="cIsValid" width="80" align="center" headerAlign="center" renderer="renderInstructStatus">指令/建议状态</div>                            
				<div field="vcProductName" width="120" align="center" headerAlign="center">产品名称</div>                                    
				<div field="vcCombiName" width="80" align="center" headerAlign="center">组合名称</div>
				<div field="vcBizType" width="120" align="center" headerAlign="center" headerallowSort="true" renderer="renderBizType">业务类别</div>   
				<div field="vcEntrustDirection" width="80" align="center" headerAlign="center" renderer="renderEntrustDirection">委托方向</div>
				<div field="vcStockCode" width="100" align="center" headerAlign="center">债券代码</div>                                    
				<div field="vcStockName" width="100" align="center" headerAlign="center">债券名称</div>
				<div field="enFaceAmount" width="120" numberFormat="n2" align="center" headerAlign="center" headerallowSort="true">券面金额（万元）</div>                            
				<div field="enNetPrice" width="100" align="center" headerAlign="center">指令/建议净价</div>
				<div field="enFullPrice" width="100" align="center" headerAlign="center">指令/建议全价</div>                                    
				<div field="enMaturityYield" width="100" align="center" headerAlign="center">到期收益率(%)</div>
				<div field="enOptionYield" width="100" align="center" headerAlign="center" headerallowSort="true">行权收益率(%)</div>                            
				<div field="lTradeDate" width="100" align="center" headerAlign="center">交易日</div>
				<div field="lFirstSettleDate" width="80" align="center" headerAlign="center">结算日</div>                                    
				<div field="vcSettleSpeed" width="80" align="center" headerAlign="center" renderer="renderSettleSpeed">清算速度</div>  
			</div>
			<div id="prompt_todays">
				<div id="alreadyEntering" style="margin-left:50px; color:#9B30FF" name="parameter/alreadyEntering" checked="false" class="nui-checkbox" onclick="search()" readOnly="false"  text="显示已录单待复核记录" ></div>
				<div id="allAlreadyCheck" style="margin-left:50px; color:#A0522D" name="parameter/allAlreadyCheck" checked="false" class="nui-checkbox" onclick="search()" readOnly="false"  text="显示已复核记录" ></div>
				<div id="cIsValid" style="margin-left:50px; color:#A3A3A3" name="parameter/cIsValid" checked="false" class="nui-checkbox" onclick="search()" readOnly="false" text="显示无效指令/建议" ></div>
				<div id="riskApproveStatus" style="margin-left:50px; color:#666633" name="parameter/riskApproveStatus" checked="false" class="nui-checkbox" onclick="search()" readOnly="false" text="显示风控审批中记录" ></div>
			</div>
		</div> 
		<div id="dealEnteringDetailForm" class="nui-tabs" activeIndex="0" onactivechanged="activechanged" style="width:100%; height:350px;" >
			<div title="指令/建议明细" url="<%= request.getContextPath() %>/transaction/manage/deal_entering/instructDetail.jsp"></div>
			<div title="成交明细" name="detail" url="<%= request.getContextPath() %>/sm/comm/instruct/tansaction_instruct/dealDetail.jsp" visible="false"></div>
		    <div title="触犯风控" url="<%= request.getContextPath() %>/sm/comm/instruct/violateRiskCtrl.jsp"></div>
		    <div title="流程审批信息" url="<%= request.getContextPath() %>/sm/comm/instruct/processApproval.jsp"></div>
		</div>
		
	</div>
	<!-- 导出参数 -->
	<div>
		<form id="export_FROM" method="post">
			<input class="nui-hidden" name="exportWebName" value="买卖录单确认汇总">
			<input class="nui-hidden" name="processinstId" id="processinstId" value="">
			<input class="nui-hidden" name="exportProcessStatus" id="exportProcessStatus" value="5">
			<input class="nui-hidden" name="exportCisValid" id="exportCisValid" value="1">
			<input class="nui-hidden" name="exportEnteringType" id="exportEnteringType" value="0">
			<input class="nui-hidden" name="exportEntrustDirection" id="exportEntrustDirection" value="3,4">
		</form>	
	</div>
	<!-- 导出参数结束 -->
	<script type="text/javascript">
		nui.parse();
		var grid = nui.get("dealEnteringForm");
		var form = new nui.Form("#grid-query-form");
		var tabDetailRole = nui.get("dealEnteringDetailForm");//获取详情标签列表
		var isSigleSelectChanged = false;
		var selectCountNumValue = null;
		json = form.getData(false,false);
		// 流程状态（5：交易为录单；6：已录单），默认查未录单
    	json["parameter/vcProcessStatus"]=5;
    	// 指令/建议状态（指令/建议有效无效状态：有效；无效-修改；无效-已撤销；无效-被退回；）
    	json["parameter/cIsValid"]=1;
		// 查询类型；录单：0；复核：1
    	json["parameter/enteringType"]=0;
    	// 委托方向
    	json["parameter/vcEntrustDirection"]="3,4";
    	
    	grid.load(json);
    	
    	// 设置时间格式
		grid.on("drawcell", function (e) {
			var field = e.field,
        		value = e.value;
			if(field=="lTradeDate"){
				if(value!=null){
					e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
				}
			}
			if(field=="lFirstSettleDate"){
				if(value!=null){
					e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
				}
			}
		});
    	
    	 // 任务表格操作列内容定义
		function value(e){
			var s = null;
			// 指令/建议状态为无效、风控审批状态为审批中或审批拒绝的不允许录单确认
			if(e.row.vcProcessStatus ==5 && e.row.cIsValid==1){
				s = '<a style="color:#00CCFF" onclick="singleDeal()" href="#">确认</a>';
			}
			if(e.row.vcProcessStatus ==6){
				s = '<a style="color:#00CCFF" onclick="rollbackDealEntering()" href="#">录单回退</a>';
			}
			return s;
		}

		// 退回录单操作
		function rollbackDealEntering(){
			var selectValue = grid.getSelected();
			var param = {lProcessinstId:selectValue.lProcessinstId, enterCheck:"enterCheck", lInstructId:selectValue.lResultId};
			nui.confirm("确定回退选中记录？", "确定？",
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
										// 刷新可操作记录条数
										parent.reloadWaitConfirmFun(selectCountNumValue);
										grid.load(json);
										clearDetail();
									}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
										parent.reloadWaitConfirmFun(selectCountNumValue);
										grid.load(json);
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

		// 根据条件查询
		function search(){
			nui.parse();
			var grid = nui.get("dealEnteringForm");
			var form = new nui.Form("#grid-query-form");
			json = form.getData(false,false);
			
			// 流程状态（5：交易为录单；6：已录单），默认查未录单
	    	json["parameter/vcProcessStatus"]=5;
	    	// 指令/建议状态（指令/建议有效无效状态：有效；无效-修改；无效-已撤销；无效-被退回；）
	    	json["parameter/cIsValid"]=1;
			// 查询类型；录单：0；复核：1
	    	json["parameter/enteringType"]=0;
	    	
			// 已录单
			if(nui.get("alreadyEntering").checked){
				json["parameter/alreadyEntering"]=6;
			}
			// 已复核
			if(nui.get("allAlreadyCheck").checked){
				json["parameter/allAlreadyCheck1"]=7;
				json["parameter/allAlreadyCheck2"]=8;
				json["parameter/allAlreadyCheck3"]=9;
			}
			// 指令/建议状态
			if(nui.get("cIsValid").checked){
				json["parameter/cIsValid"]=null;
			}
			// 风控审批状态
			if(nui.get("riskApproveStatus").checked){
				json["parameter/riskApproveStatus"]=4;
			}
			//  委托方向（01买入，02卖出）
			var vcEntrustDirection = null;
			if(json["parameter/vcEntrustDirection"] == "" || json["parameter/vcEntrustDirection"] == null){
				vcEntrustDirection = "3,4";
				json["parameter/vcEntrustDirection"]= vcEntrustDirection;
			}else{
				vcEntrustDirection =json["parameter/vcEntrustDirection"];
			}
			// 产品代码
			var vcProductCode = json["parameter/vcProductCode"];
			// 查询可录单记录条数
			selectCountNumValue= {vcProcessStatus1:5, vcProductCode:vcProductCode, cIsValid:1, vcProcessStatus2:6, vcEntrustDirection:vcEntrustDirection};
			parent.reloadWaitConfirmFun(selectCountNumValue);
			grid.load(json);
		}
		
		//重置
		function reset(){
			form.clear();
		}
		
		// 录单确认（单条）
		function singleDeal() {
			var dealEnteringValue = grid.getSelected();
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
				    	// 刷新可操作记录条数
						parent.reloadWaitConfirmFun(selectCountNumValue);
	            		grid.reload();
	            		clearDetail();
	        		}
				});
			// 批量录单确认	
			}else {
				nui.alert("请选中一条记录","提示");
			}
		}
		
		// 录单确认（批量）
		function batchDeal() {
			var dealEnteringValue = grid.getSelecteds();
			if(dealEnteringValue.length>0){
				for (var i = 0; i < dealEnteringValue.length; i++) {
					if (dealEnteringValue[i].vcProcessStatus != 5
							|| dealEnteringValue[i].cIsValid!=1) {
						nui.alert("只能操作未录单的记录！", "系统提示");
						return;
					} 	
					for(var j = 0; j<dealEnteringValue.length; j++){
				        if(dealEnteringValue[i].vcProductCode != dealEnteringValue[j].vcProductCode){
				           nui.alert("请选择相同的产品批量操作","系统提示");
				           return;
				        }
				    }
				}
				for(var i =0; i<dealEnteringValue.length;i++){	
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
								// 刷新可操作记录条数
								parent.reloadWaitConfirmFun(selectCountNumValue);
								grid.load(json);
							}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
								parent.reloadWaitConfirmFun(selectCountNumValue);
								grid.load(json);
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
		
		//风控审批状态列字典翻译
	    function renderRiskApproveStatus(e){
	    	return nui.getDictText("riskApproveStatus",e.row.vcRiskApproveStatus);
	    }
	    
	    //指令/建议状态列字典翻译
	    function renderInstructStatus(e){
	    	return nui.getDictText("instructStatus",e.row.cIsValid);
	    }
	    
	    // 业务类别字典翻译
	    function renderBizType(e){
	    	return nui.getDictText("bizTypeTransaction",e.row.vcBizType);
	    }
	    
	    // 委托方向字典翻译
	    function renderEntrustDirection(e){
	    	return nui.getDictText("entrustDirectionTransaction",e.row.vcEntrustDirection);
	    }
	    
	    // 清算速度字典翻译
	    function renderSettleSpeed(e){
	    	return nui.getDictText("settleSpeed",e.row.vcSettleSpeed);
	    }
	    
	    // 选中查看的记录
	    function selectionchanged(){
    		var rows = grid.getSelecteds();
			if(rows.length == 1){
				var row = grid.getSelected();
				showDetail(row);
			}else {
				clearDetail();
			}
    	}
    	
    	//显示详细信息
    	function showDetail(row){
    		nui.get("dealEnteringDetailForm").updateTab("detail",{visible:false});
    		isSigleSelectChanged = true;
    		//获取成交明细标签页
    		var detail = tabDetailRole.getTab("detail");		
    		// 成交状态
    		var enteringStatus = row.vcProcessStatus;	
    		//判断是否成交（前台已成交=8，后台已成交=9）	
    		if(enteringStatus==8 || enteringStatus==9){		
    			nui.get("dealEnteringDetailForm").updateTab("detail",{visible:true});
    		}
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
    			currentTabIFrameEl.contentWindow.detail(grid.getSelected());
    		}
    	}
    	//详情标签切换时处理逻辑
    	function activechanged(){
    		var currentTabIFrameEl = tabDetailRole.getTabIFrameEl(tabDetailRole.getActiveTab());
    		if(currentTabIFrameEl){
    			if(isSigleSelectChanged == true){
    				currentTabIFrameEl.contentWindow.detail(grid.getSelected());
    			}else{
    				currentTabIFrameEl.contentWindow.clearDetail();
    			}
    		}
    	}
    	
    	// 清楚查询条件
    	function onCloseClick(e) {
            var obj = e.sender;
            obj.setText("");
            obj.setValue("");
        }
	  
	  	// 生成本币接口文件
        function exportExcel(){
        	if(grid.data.length>0){
				var rows = grid.getSelecteds();
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
						nui.get("export_dealEntering").disable();//禁用“导出”按钮
						var form = document.getElementById("export_FROM");
						form.action = "com.cjhxfund.ats.sm.comm.ExprotExcleByProcessinstById.flow";
				        form.submit();
				        //启用“导出”按钮
				        setTimeout("enableExport()",15000);
					}
				});
			}else{
        		nui.alert("查询不到可以导出的记录","系统提示");
        		return false;
        	}
		}
	    
	    function enableExport(){
	  		nui.get("export_dealEntering").enable();
		}  
		
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
	    
	    //设置指令/建议列表数据显示颜色
		grid.on("drawcell", function (e) {
	        var record = e.record;
			//设置行样式，交易状态：1-有效；2-无效-已修改；3-无效-已撤销；4-有效-被退回；
			if(record.cIsValid=="2" || record.cIsValid=="3" || record.cIsValid=="4" || record.cIsValid=="5" || record.cIsValid=="6"){
				e.rowStyle='color:#A3A3A3;';
			}else if(record.cIsValid=="1"){
				//流程处理状态:0-询价结果待录入,1-询价结果已录入,2-指令/建议待复核,3-待投资经理确认,4-待风控审批,
				//5-待交易录单,6-待录单复核,7-待前台成交,8-前台已成交,9-后台已成交
				if(record.vcProcessStatus=="6"){
					e.rowStyle='color:#9B30FF;';
				}else if(record.vcProcessStatus=="7" || record.vcProcessStatus=="8" || record.vcProcessStatus=="9"){
					e.rowStyle='color:#A0522D;';
				}else if(record.vcProcessStatus=="4"){
					e.rowStyle='color:#666633;';	
				}
			}
	    });
		
		// 风控审批状态
	    function renderRiskApproveStatus(e){
	    	if(e.value == null){
	    		return "--";
	    	}else{
	    		return nui.getDictText("riskApproveStatus",e.row.vcRiskApproveStatus);
	    	}
	    }
	    
	    // 修改复核人
		function editCheckUser(){
			if(grid.data.length>0){
				var rows = grid.getSelecteds();
				if(rows.length<1){
					nui.alert("请选中一条记录","提示");
					return;
				}else if(rows.length>1){
					nui.alert("修改复核人仅支持单条修改","提示");
					return;
				}else{
					if(rows[0].vcProcessStatus != 6){
						nui.alert("只有已录单待复核的记录才能修改","提示");
						return;
					}
					// 加载选择复核人页面
					nui.open({
						url : "<%=request.getContextPath()%>/transaction/manage/deal_entering/updateEnteringCheckUser.jsp",
					    title: "修改复核人", 
					    width: 500, 
					    height: 300,
					    onload: function () {
					        var iframe = this.getIFrameEl();
					        iframe.contentWindow.SetData(rows);
					    },
					    ondestroy: function (action) {
					    	// 刷新可操作记录条数
	    					parent.reloadWaitConfirmFun(selectCountNumValue);
	                		grid.reload();
	                		clearDetail();
	            		}
					});
				}
			}else{
        		nui.alert("查询不到可以导出的记录","系统提示");
        		return false;
        	}
		}
    </script>
</body>
</html>