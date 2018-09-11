<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): wuyanfei
  - Date: 2016-09-14 11:06:33
  - Description:
-->
<head>
<title>录单复核</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/css/instruct.css"/>
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script>
</head>
<body>
	<!-- 查询条件开始 -->
	<div class="search-condition">
	   <div class="list">
	   		<div id="grid-query-form"  class="nui-form" align="center">
   				<table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
					<tr>
						<td width="60px" align="right">产品名称:</td>
						<td align="left" width="18%">
    						<div name="parameter/vcProductCode" class="nui-combobox" pinyinField="vcProductCode" id="vcProductCode"
                            	textField="vcProductName" valueField="vcProductCode"
								url="com.cjhxfund.commonUtil.ProductManager.queryProductListByUserIdAndRealtype.biz.ext?realType=05"
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
						<td colspan="1" width="20%" align="left">
							<input class="nui-dictcombobox" id="vcEntrustDirection" name="parameter/vcEntrustDirection" 
								multiSelect="true" valueField="dictID" textField="dictName" dictTypeId="entrustDirectionRepurchase" 
								emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
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
						<a class='nui-button' plain='false' iconCls="icon-ok" onclick="batchConfirm()">批量复核</a>
						<a class='nui-button' plain='false' iconCls="icon-download" id="export_enterCheck" onclick="exportExcel()">导出本币接口文件</a>
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
		<div id="dealEnterCheckForm" class="mini-datagrid" style="width:100%;height:46%;" 
		    	 url="com.cjhxfund.ats.sm.comm.InstructionManager.queryTransactionEnteringList.biz.ext" 
		    	 dataField="data"
		    	 allowResize="true"
		    	 pageSize="10"
		    	 sizeList="[10,20,30,50,100]" 
		    	 showPager="true"
		    	 multiSelect="true"
		    	 allowSortColumn="true"
		    	 frozenStartColumn="0" 
		    	 frozenEndColumn="7"
		    	 onselectionchanged="selectionchanged"
             	pagerButtons="#prompt_todays">
	        <div property="columns">
	        	<div type="checkcolumn" ></div>
	            <div name="action" width="100" headerAlign="center" align="center" renderer="value">操作</div>
	            <div field="lResultNo" width="80" headerAlign="center" align="center">指令/建议序号</div> 
	            <div field="vcRiskApproveStatus" headerAlign="center" renderer="renderRiskApproveStatus" width="100" align="center">风控审批状态</div>    
	            <div field="cIsValid" width="80" renderer="renderInstructStatus" align="center" headerAlign="center">指令/建议状态</div>                            
	            <div field="vcProductName" width="120" align="center" headerAlign="center">产品名称</div>                                    
	            <div field="vcCombiName" width="100" align="center" headerAlign="center">组合名称</div>
	            <div field="vcBizType" width="100" headerAlign="center" align="center" renderer="renderBizType">业务类别</div>   
	            
	                                     
	            <div field="vcEntrustDirection" width="100"  align="center" headerAlign="center" renderer="renderEntrustDirection">委托方向</div>
	            <div field="lRepoDays" width="100"  align="center" headerAlign="center">回购天数</div>
	            <div field="lIssueDate" width="100" align="center" headerAlign="center">指令/建议下达日期</div>
	            <div field="lTradeDate" width="100" align="center" headerAlign="center" dateFormat="yyyy-MM-dd">交易日期</div>
	            <div field="lFirstSettleDate" width="100" dateFormat="yyyy-MM-dd" align="center" headerAlign="center">首次结算日期</div>
	            <div field="lMaturitySettleDate" width="100" dateFormat="yyyy-MM-dd" align="center" headerAlign="center">到期结算日期</div>
	            <div field="enFaceAmount" width="100" numberFormat="n4" align="center" headerAlign="center">回购金额（万元）</div>
	            <div field="enFullPriceAmount" width="100" align="center" numberFormat="n2" headerAlign="center">首期结算金额（元）</div>
	            <div field="enRepoRate" width="100"  align="center" headerAlign="center">回购利率</div>
	        </div>
	        <div id="prompt_todays">
	        	<!-- <span class="separator"></span> -->
				<div id="alreadyEntering" style="margin-left:50px; color:#A0522D" name="parameter/alreadyEntering" checked="false" class="mini-checkbox" onclick="search()" readOnly="false"  text="显示已复核记录" ></div>
			</div>
    	</div> 
		<div id="dealEnterCheckDetailForm" class="nui-tabs" activeIndex="0" onactivechanged="activechanged" style="width:100%; height:350px;">
			<div title="指令/建议明细" url="<%= request.getContextPath() %>/repurchase/manage/deal_entering/instructDetail.jsp"></div>
			<div title="质押券" url="<%= request.getContextPath() %>/sm/comm/instruct/repurchase_instruct/mortgageInfo.jsp"></div>
	    	<div title="成交明细" name="detail" url="<%= request.getContextPath() %>/sm/comm/instruct/repurchase_instruct/dealDetail.jsp" visible="false"></div>
	    	<div title="流程审批信息" url="<%= request.getContextPath() %>/sm/comm/instruct/processApproval.jsp"></div>
		</div>
	</div>
	<!-- 导出参数 -->
	<div>
		<form id="export_FROM" method="post">
			<input class="nui-hidden" name="exportWebName" value="回购录单复核汇总">
			<input class="nui-hidden" name="processinstId" id="processinstId" value="">
			<input class="nui-hidden" name="exportProcessStatus" id="exportProcessStatus" value="6">
			<input class="nui-hidden" name="exportEnteringType" id="exportEnteringType" value="1">
			<input class="nui-hidden" name="exportEntrustDirection" id="exportEntrustDirection" value="5,6,15,16,17,18,26,27,30,31">
		</form>	
	</div>
	<!-- 导出参数结束 -->
	<script type="text/javascript">
    	nui.parse();    	
		var grid = nui.get("dealEnterCheckForm");
		var form = new nui.Form("#grid-query-form");
		var tabDetailRole = nui.get("dealEnterCheckDetailForm");//获取详情标签列表
		var isSigleSelectChanged = false;
		var selectCountNumValue = null;
		json = form.getData(false,false);
		
		// 流程状态（5：交易为录单；6：已录单，待复核，7：已复核）
    	json["parameter/vcProcessStatus"]=6;
    	// 查询类型；录单：0；复核：1
    	json["parameter/enteringType"]=1;
    	// 委托方向
    	json["parameter/vcEntrustDirection"]="5,6,15,16,17,18,26,27,30,31";
    	grid.load(json);
    	
    	// 设置时间格式
		grid.on("drawcell", function (e) {
			var field = e.field,
        		value = e.value;
        	if(field=="lIssueDate"){
        		if(value!=null){
					e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
				}
			}
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
			if(field=="lMaturitySettleDate"){
				if(value!=null){
					e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
				}
			}
		});
    	
    	 // 任务表格操作列内容定义
		function value(e){
			var s = null;
			// 指令/建议状态为无效、风控审批状态为审批中或审批拒绝的不允许录单确认
			if(e.row.vcProcessStatus ==6){
				s = '<a style="color:#00CCFF" onclick="batchConfirm()" href="#">复核</a>';
			}
			return s;
		}
		
		// 根据条件查询
		function search(){
			nui.parse();
			var grid = nui.get("dealEnterCheckForm");
			var form = new nui.Form("#grid-query-form");
			json = form.getData(false,false);
			
			// 流程状态（5：交易为录单；6：已录单），默认查未录单
	    	json["parameter/vcProcessStatus"]=6;
			// 查询类型；录单：0；复核：1
	    	json["parameter/enteringType"]=1;
			// 已复核
			if(nui.get("alreadyEntering").checked){
				json["parameter/allAlreadyCheck1"]=7;
				json["parameter/allAlreadyCheck2"]=8;
				json["parameter/allAlreadyCheck3"]=9;
			}
			//  委托方向（01买入，02卖出）
			var vcEntrustDirection = null;
			if(json["parameter/vcEntrustDirection"] == "" || json["parameter/vcEntrustDirection"] == null){
				vcEntrustDirection = "5,6,15,16,17,18,26,27,30,31";
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
		
		//	批量复核
		function batchConfirm() {
			var dealEnteringValue = grid.getSelecteds();
			if (dealEnteringValue.length>0) {
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
	    			delete dealEnteringValue[i].lIssueDate;
	    			delete dealEnteringValue[i].lTradeDate;
	    			delete dealEnteringValue[i].lFirstSettleDate;
					delete dealEnteringValue[i].lMaturitySettleDate;
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
										nui.alert(returnJson.rtnMsg,"系统提示");
								    	// 刷新可操作记录条数
								    	parent.reloadWaitConfirmFun(selectCountNumValue);
										grid.load(json);
									}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
										// 刷新可操作记录条数
								    	parent.reloadWaitConfirmFun(selectCountNumValue);
										grid.load(json);
										nui.alert(returnJson.rtnMsg,"系统提示");
									}else{
										nui.alert("操作异常","系统提示");
									}
								}else{
									nui.alert("系统异常","系统提示");
								}
							},
						    ondestroy: function (action) {
	                    		grid.reload();
	                    		clearDetail();
	                		}
		          		});
	          		 }
	            });
					
			} else {
				nui.alert("请选中一条记录","提示");
			}
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
    		nui.get("dealEnterCheckDetailForm").updateTab("detail",{visible:false});
    		isSigleSelectChanged = true;
    		//获取成交明细标签页
    		var detail = tabDetailRole.getTab("detail");		
    		// 成交状态
    		var enteringStatus = row.vcProcessStatus;	
    		//判断是否成交（前台已成交=8，后台已成交=9）	
    		if(enteringStatus==8 || enteringStatus==9){		
    			nui.get("dealEnterCheckDetailForm").updateTab("detail",{visible:true});
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
	    	return nui.getDictText("bizTypeRepurchase",e.row.vcBizType);
	    }
	    
	    // 委托方向字典翻译
	    function renderEntrustDirection(e){
	    	return nui.getDictText("entrustDirectionRepurchase",e.row.vcEntrustDirection);
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
			if(record.vcProcessStatus=="7" || record.vcProcessStatus=="8" || record.vcProcessStatus=="9"){
				e.rowStyle='color:#A0522D;';
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
			    	if(rows[i].vcBizType != "5" && rows[i].vcBizType != "6"){
			    		nui.alert("只能导出质押式回购和买断式回购的指令/建议","系统提示");
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
						nui.get("export_enterCheck").disable();//禁用“导出”按钮
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
	  		nui.get("export_enterCheck").enable();
		}  
    </script>
</body>
</html>