<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<!-- 
  - Author(s): jiangkanqian
  - Date: 2018-04-18 15:39:20
  - Description:
-->
<head>
<title>利率互换交易端</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/css/instruct.css"/>
	<script src="<%= request.getContextPath() %>/ProductProcess/CFJYProductProcessList_common.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/JQMHistory/common/common.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/transaction/investNew/js/makeInstruct.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/instruction/instructionUtil/instruction.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">
			   <div class="search-condition">
				   <div class="list">
					   <div id="form_today_instruct" class="nui-form" style="padding:2px;" align="center" style="height:10%">
					   		<!-- 业务标签:1-投顾端、2-交易员端 -->
		   					<input class="nui-hidden" id="queryType" name="queryType" value="2"/>							
			                <table id="instruct_follow_condition" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
				                <tr>
			                		<td class="form_label" width="60px">
										产品名称:
			                        </td>
			                        <td colspan="1" width="200px">
			                            <input id="vcProductCode" class="nui-buttonedit" name="vcProductCode" emptyText="全部" showClose="true" oncloseclick="onCloseClick" onbuttonclick="ButtonClickGetFundName_todayInstruct" style="width:95%"/>
			                        </td>
									<td width="60px" class="form_label">业务方向:</td>
									<td colspan="1" width="180px">
										<input class="nui-dictcombobox" id="vcBusinType" name="vcBusinType" multiSelect="true"
											valueField="dictID" textField="dictName" dictTypeId="interestSwapBusinType" 
											emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
									</td>
									<td class="form_label" width="60px">交易日期:</td>
									<td colspan="1" width="290px">
										<input class="nui-datepicker" name="lTradeDateMin" style="width:120px" id="lTradeDateMin" showClose="true" oncloseclick="onCloseClick"/>
			                    		<span style="width:50px;" align="left">-</span>
										<input class="nui-datepicker" name="lTradeDateMax" style="width:120px" id="lTradeDateMax" showClose="true" oncloseclick="onCloseClick"/>
									</td>
									<td width="60px" class="form_label">参考利率:</td>
									<td colspan="1" width="200px">
										<input class="nui-dictcombobox" id="vcReferRate" name="vcReferRate" textField="text" valueField="vcReferRate"
											data="[{vcReferRate: 'FR007', text: 'FR007'}, {vcReferRate: 'SHIBOR_3M', text: 'SHIBOR_3M'},{vcReferRate: 'SHIBOR_O/N', text: 'SHIBOR_O/N'}]"
											emptyText="全部" showClose="true" multiSelect="true" oncloseclick="onCloseClick"/>
									</td>
								</tr>
								<tr>
									<td width="7%" class="form_label">期限:</td>
									<td colspan="1" width="20%">
										<input class="nui-combobox" id="lLeftDays"
				                           name="lLeftDays"
				                           textField="text"
				                           valueField="lLeftDays"
				                           data="[{lLeftDays: '7D', text: '7D'},{lLeftDays: '1M', text: '1M'},{lLeftDays: '3M', text: '3M'},{lLeftDays: '6M', text: '6M'},{lLeftDays: '9M', text: '9M'},
				                           {lLeftDays: '1Y', text: '1Y'},{lLeftDays: '2Y', text: '2Y'},{lLeftDays: '3Y', text: '3Y'},{lLeftDays: '4Y', text: '4Y'},{lLeftDays: '5Y', text: '5Y'},
				                           {lLeftDays: '6Y', text: '6Y'},{lLeftDays: '7Y', text: '7Y'},{lLeftDays: '8Y', text: '8Y'},{lLeftDays: '9Y', text: '9Y'},{lLeftDays: '10Y', text: '10Y'}]"
				                           multiSelect="true"
				                           emptyText="全部"		 
				                           oncloseclick="onCloseClick"
				                           style="width:95%"
				                           showClose="true"/>
				                	</td>
									<td width="7%" class="form_label">对手方:</td>
					                <td colspan="1" width="20%">
					                	<div name="vcCounterpartyId" class="mini-autocomplete" id="vcCounterpartyId"
			                             vtype="maxLength:3"
			                             textField="vcName" valueField="vcRivalCode"
			                             searchField="vcPinyin"
			                             url="com.cjhxfund.ats.sm.comm.TraderivalManager.QueryTraderByPinyin.biz.ext"
			                             popupEmptyText="全部"
			                             nullItemText="全部"
			                             loadingText="加载中"
			                             dataField="traders"
			                             multiSelect="true"
			                             style="width:95%"
			                             showClose="true"
			                             oncloseclick="onCloseClick"
			                             popupWidth="300">
			                             
				                            <div property="columns">
				                                <div header="对手代码" field="vcRivalCode" width="20"></div>
				                                <div header="对手名称" field="vcName"></div>
				        					</div>
				        				</div>
					                </td>
									<td colspan="7" align="left">
				                		<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
				                		<input class='nui-button' plain='false' text="重置" iconCls="icon-reset" onclick="reset()"/>
				                		<a class="nui-menubutton " plain="false" menu="#popupMenu"
			                               id="searchCond"
			                               name="searchCond"
			                               data-options='{formId:"form_today_instruct"}'
			                               iconCls="icon-add">保存查询条件</a>
			                            <ul id="popupMenu" class="mini-menu" style="display:none;"></ul>
				                	</td>
								</tr>
							</table>
						</div>
				  </div>
			   </div>

		<%-- 列表操作工具开始... --%>
		<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	    	<table style="width:100%;table-layout:fixed;">
	            <tr>
	                <td style="width:75%;">
	                	<a id="viewFlowChart" enabled="false" class='nui-button' plain='false' iconCls="icon-search" onclick="viewFlowChart()">查看流程图</a>&nbsp;
	                  	<a class='nui-button' plain='false' iconCls="icon-download" id="export_todayInstruct" onclick="exportExcel()">导出</a>&nbsp;
	                <td align="right">
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
		        
		        <div class="nui-fit" style="width:100%;height:100%;overflow:hidden;">
		            <div id="treegrid_todays_instruct" class="nui-treegrid" style="width:100%;height:100%;"
				 		url="com.cjhxfund.ats.instruction.InterestSwap.InterestSwapInstruction.queryInstructInfo.biz.ext" 
				 		dataField="insructInfos" treeColumn="lInstructNo"
				 		showPager="true" pageSize="20" frozenStartColumn="0" frozenEndColumn="6"
				 		showTreeIcon="false" showTreeLines="false" multiSelect="true"
				 		sizeList="[20,50,100,200,500,1000]"
				 		showReloadButton="false"
				 		onbeforeload="onBeforeTreeLoad"
				 		onselectionchanged="selectionchanged"
				 		pagerButtons="#prompt_todays"
				 		virtualScroll="true"
				 		sortField="" sortOrder=""
				 		enableHotTrack="false"
				 		idField="lInstructId"
	             		onselect="onSelect"
	             		ondeselect="onDeselect"
	             		onload="onGridLoad"
				 	>		
		                    <div property="columns">
		                        <div type="checkcolumn"></div>
		                        <div name="action" width="60px" align="center" headerAlign="center" headerallowSort="true">操作</div>
		                        <div field="vcProductName" headerAlign="center" allowSort="true" align="center" width="200px">
		                            产品名称
		                        </div>
		                        <div field="vcCombiName" headerAlign="center" allowSort="true" align="left">
		                           组合名称
		                        </div>
		                        <div field="lTradeDate" headerAlign="center" allowSort="true" align="center">
		                            交易日期
		                        </div>
		                        <div field="vcBusinType" headerAlign="center" allowSort="true" align="left" renderer="vcBusinTypeRender">
		                            业务方向
		                        </div>
		                        <div field="vcBusinName" headerAlign="center" allowSort="true" align="left" renderer="vcBusinNameRender">
		                            业务名称
		                        </div>
		                        <div field="lNominalCapital" headerAlign="center" allowSort="true" align="center" numberFormat="#,###">
		                           名义本金（万元）
		                        </div>
		                        <div field="lFixedRate" headerAlign="center" allowSort="true" align="left" numberFormat="n4">
		                           固定利率（%）
		                        </div>
		                        <div field="vcReferRate" headerAlign="center" allowSort="true" align="center">
		                            参考利率
		                        </div>
		                        <div field="lLeftDays" headerAlign="center" allowSort="true" align="left">
		                            期限
		                        </div>
		                        <div field="vcCounterpartyName" headerAlign="center" allowSort="true" align="center" width="200px">
		                            对手方
		                        </div>
		                        <div field="cIsValid" headerAlign="center" allowSort="true" align="center" renderer="renderInstructStatus" >
		                           交易状态
		                        </div>		                        		                        
		                        <div field="tInputTime" headerAlign="center" allowSort="true" 
		                        align="center" width="200px" renderer="resultRenderInput" >
		                           录入时间
		                        </div>
		                        <div field="tReviewTime" headerAlign="center" allowSort="true" 
		                        align="center" width="200px" renderer="resultRenderReview">
		                          复核时间
		                        </div>
		                        <div field="tClientTime" headerAlign="center" allowSort="true" 
		                        align="center" width="200px" renderer="RenderClientTime">
		                           确认时间
		                        </div>
		                        <div field="tInvestmanagerTime" headerAlign="center" allowSort="true" 
		                        align="center" width="200px" renderer="RenderInvestTime">
		                           投资经理审批时间
		                        </div>
		                        <div field="tFsOperateTime" headerAlign="center" allowSort="true" 
		                        align="center" width="200px" renderer="RenderFsOperateTime">
		                           前台录单时间
		                        </div>
		                        <div field="tFsReviewTime" headerAlign="center" allowSort="true" 
		                        align="center" width="200px" renderer="RenderFsReviewTime">
		                           前台发送时间
		                        </div>
		                        <div field="tFsDealTime" headerAlign="center" allowSort="true" 
		                        align="center" width="200px" renderer="RenderFsDealTime">
		                           前台成交时间
		                        </div>
		                        <div field="tBsDealTime" headerAlign="center" allowSort="true" 
		                        align="center" width="200px" renderer="RenderBsDealTime">
		                           交易后平台确认时间
		                        </div>
		                        <div field="lInstructNo" headerAlign="center" allowSort="true" 
		                        align="center">
		                           指令/建议序号
		                        </div>
		                        <div field="vcInstructSource" headerAlign="center" allowSort="true" align="center"  renderer="InstructResource">
		                           指令/建议来源
		                        </div>
		                        <div field="vcRemark" headerAlign="center" allowSort="true" align="center" width="250px">
		                           备注
		                        </div>
		                     </div>
		                </div>
		                
		 <div id="prompt_todays">
	        <span class="separator"></span>
	        <div class="investdata"></div>
	   		<div style= "display:inline-block; margin-right: 8px;">投资经理已确认</div>
	       	<div class="transactionConfirmData"></div>
	       	<div style= "display:inline-block; margin-right: 8px;">交易已确认</div>
	       	<div class="tradedate"></div>
	       	<div style= "display:inline-block; margin-right: 8px;">交易已发送</div>
	       	<div class="waitdata"></div>
	        <div style= "display:inline-block; margin-right: 8px;">前台已成交</div>
	      	<div class="closedata"></div>
	    	<div style= "display:inline-block;">后台已成交 </div>
	     	<div class="invaliddata"></div>
	        <div style= "display: inline-block; margin-right: 8px;">无效</div>
	       	<div class="backdata"></div>
	        <div style= "display:inline-block; margin-right: 8px;">已修改</div>
	        <!-- <div class="forbiddata"></div>
	        <div style= "display:inline-block; margin-right: 8px;">交易禁止</div> -->
		</div>
		                
		             </div>
		        </div>
	
		<!-- 导出参数 -->
	<div>
		<form id="export_FROM" method="post">
			<!-- 业务标签:当日指令/建议 -->
			<input class="nui-hidden" id="exportInstructId" name="paramObject/exportInstructId">
			<input class="nui-hidden" id="exportIselect" name="paramObject/exportIselect">
	   		<input class="nui-hidden" id="exportQueryType" name="paramObject/exportQueryType" value="2"/>
			<input class="nui-hidden" id="exportProductCode" name="paramObject/exportProductCode">
			<input class="nui-hidden" id="exportBusinType" name="paramObject/exportBusinType">
			<input class="nui-hidden" id="exportTradeDateMin" name="paramObject/exportTradeDateMin">
			<input class="nui-hidden" id="exportTradeDateMax" name="paramObject/exportTradeDateMax">
			<input class="nui-hidden" id="exportReferRate" name="paramObject/exportReferRate">
			<input class="nui-hidden" id="exportLeftDays" name="paramObject/exportLeftDays">
			<input class="nui-hidden" id="exportCounterpartyId" name="paramObject/exportCounterpartyId">				
		</form>	
	</div>
	<!-- 导出参数结束 -->
		            
	</div>
	
	 <!--隐藏表单-->
<form action="" name="openForm" method="post" target="_blank">
</form>

	<script type="text/javascript">
    	nui.parse();   		
  		
  		$("#vcCounterpartyId>span>input").attr("placeholder","请输入对手方名称...");
    	// 当天日期
    	var date = new Date();
    	var todayDate = DateUtil.toNumStr(date);
		nui.get("lTradeDateMin").setValue(todayDate);
		nui.get("lTradeDateMax").setValue(todayDate);
		var isLoad = "true";	
    	var today_instruct = new nui.Form("#form_today_instruct");
    	var todays_instruct_grid = nui.get("treegrid_todays_instruct");
    	var isSigleSelectChanged = false;
    	var selectArr = [];//已选的记录数组
    	
    	// 添加指令
		function addInterestSwap(){
    		nui.open({
	    		url:"<%=request.getContextPath() %>/instruction/interestSwap/newInstruct.jsp",
    			title:"下达投资指令/建议", 
    			width:870,
    			height:650,
    			allowResize:false,    			
    			ondestroy: function (action) {
					search();
    			}
    		});	
		}
    	
    	//自动刷新功能处理
    	var autoRefreshValOld = nui.get("autoRefresh").getValue();//获取默认自动刷新时间
	    var autoRefreshReturnVal= self.setInterval("autoRefreshFun()",eval(autoRefreshValOld)*1000);//设置自动刷新时间默认3分钟
    	//刷新
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
	    		if(row.lInstructId==record.lInstructId){
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
	    		if(row.lInstructId!=record.lInstructId){//将原来数组中不等于取消选中行的记录重新放回去
	    			selectArr.push(row);
	    		}
	    	}
	    }
	
	//查询--所有业务通用
	function autoSearch() {
	//获取之前选中记录的主键ID，刷新后继续选中之前记录
	var rows_search = selectArr;
	var rowIds_search = "";
	for(var i=0; i<rows_search.length; i++){
		rowIds_search += rows_search[i].lInstructId;
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
    
    function onBeforeTreeLoad(e) {
        	var params = e.params;  //参数对象        	
        	
	        //可以传递自定义的属性
			var initParam = new nui.Form("#form_today_instruct").getData(false,false);
			//产品名称
			initParam["vcProductCode"] = splitString(initParam["vcProductCode"]);
			//业务类别
			if(initParam.vcBusinType != null && initParam.vcBusinType != ""){
        		initParam["vcBusinType"] = nui.get("vcBusinType").getValue();
        	}       	        				
			//交易日期
        	if(initParam.lTradeDateMin != null && initParam.lTradeDateMin != ""){
        		initParam.lTradeDateMin = DateUtil.toNumStr(initParam.lTradeDateMin);
        	}else{
        		if(isLoad != "true")
        			initParam.lTradeDateMin = DateUtil.toNumStr(new Date());
        	}
        	
        	if(initParam.lTradeDateMax != null && initParam.lTradeDateMax != ""){
        		initParam.lTradeDateMax = DateUtil.toNumStr(initParam.lTradeDateMax);
        	}else{
        		if(isLoad != "true")
        			initParam.lTradeDateMax = DateUtil.toNumStr(new Date());
        	}
        	
        	//参考利率
        	if(initParam.vcReferRate != null && initParam.vcReferRate != ""){
        		initParam["vcReferRate"] = nui.get("vcReferRate").getValue();
        	}
        	//期限
        	if(initParam.lLeftDays != null && initParam.lLeftDays != ""){
        		initParam["lLeftDays"] = nui.get("lLeftDays").getValue();
        	}
        	//对手方
        	if(initParam.vcCounterpartyId != null && initParam.vcCounterpartyId != ""){
        		initParam["vcCounterpartyId"] = nui.get("vcCounterpartyId").getValue();
        	}       	       	
        	initParam["queryType"] = nui.get("queryType").getValue();
	        params.paramObject = initParam;
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
			}else if(record.cIsValid=="4"){
				e.rowCls = "instructStatus_4_zlgl";
			}else if(record.cIsValid=="1"){
				if(record.vcProcessState=="1"){
					e.rowCls = "processStatus_5or6_zlgl";
				}else if(record.vcProcessState=="2"){
					e.rowCls = "processStatus_5_zlgl";
				}else if(record.vcProcessState=="3"){
					e.rowCls = "processStatus_8_zlgl";
				}else if(record.vcProcessState=="4"){
					e.rowCls = "processStatus_7_zlgl";
				}else if(record.vcProcessState=="5"){
					e.rowCls = "processStatus_9_zlgl";
				}
			}
			
			if (e.column.name == "action") {
			e.cellStyle = "text-align:center";
			var lProcessinstId = e.row.lProcessinstId;
	    	if(lProcessinstId==null || lProcessinstId=="" || lProcessinstId==0){
	    	
	    	}
	    	else{
				if(e.row.workitemId == '0'){
					var url = '<%=request.getContextPath() %>'
					+"/com.cjhxfund.fpm.bpsExpend.getTaskInfo.flow?processInstID="
					+e.row.lProcessinstId;
					e.cellHtml = "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;color:blue;'  onclick='wfOpenWin(\""+url+"\")'>查看</a>";
				} else {
					var url = "/com.cjhxfund.fpm.bpsExpend.getTaskInfo.flow?workItemID="+e.row.workitemId;
					e.cellHtml = "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;color:blue;'  onclick='wfOpenWin(\""+url+"\")'>确认</a>";
				}
			}
		}
						
	    });    
       
       function wfOpenWin(url) {
		var winFrm=document.openForm;
		var actionURL= "";
		actionURL = '<%=request.getContextPath() %>'+"/"+url; //目标页面
		
		winFrm.action=actionURL;
		var newwin = window.open('about:blank', 'newWindow', '');
		winFrm.target = 'newWindow';//这一句是关键
		winFrm.submit();
	}
       
       function search(){
    		todays_instruct_grid.reload("com.cjhxfund.ats.instruction.InterestSwap.InterestSwapInstruction.queryInstructInfo.biz.ext");
      }
      
       //业务类别字典翻译
	   function vcBusinTypeRender(e){
	    	return nui.getDictText("interestSwapBusinType",e.row.vcBusinType);
	   }
       
       function vcBusinNameRender(e){
	    	return nui.getDictText("interestSwapBusinName",e.row.vcBusinName);
	   }
       
       	//指令/建议状态列字典翻译
	    function renderInstructStatus(e){
	    	return nui.getDictText("instructStatus",e.row.cIsValid);
	    }
       	
       	//时间显示处理
	    function resultRenderInput(e){
	    	if(e.row.vcInitiatorName!=null || e.row.vcInitiatorName!=null){
	    		return (e.row.vcInitiatorName==null?"":e.row.vcInitiatorName) + "　" + nui.formatDate(e.row.tInputTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return (nui.formatDate(e.row.tInputTime, "yyyy-MM-dd HH:mm:ss"));
			}
		}
       	
       	function resultRenderReview(e){
	    	if(e.row.vcReviewName!=null || e.row.vcReviewName!=null){
	    		return (e.row.vcReviewName==null?"":e.row.vcReviewName) + "　" + nui.formatDate(e.row.tReviewTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return (nui.formatDate(e.row.tReviewTime, "yyyy-MM-dd HH:mm:ss"));
			}
		}
		
		function RenderClientTime(e){
	    	if(e.row.vcClientName!=null || e.row.vcClientName!=""){
	    		return (e.row.vcClientName==null?"":e.row.vcClientName) + "　" + nui.formatDate(e.row.tClientTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return (nui.formatDate(e.row.tClientTime, "yyyy-MM-dd HH:mm:ss"));
			}
		}
		
		function RenderTraderfTime(e){
	    	if(e.row.vcTraderfName!=null || e.row.vcTraderfName!=""){
	    		return (e.row.vcTraderfName==null?"":e.row.vcTraderfName) + "　" + nui.formatDate(e.row.tTraderfTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return (nui.formatDate(e.row.tTraderfTime, "yyyy-MM-dd HH:mm:ss"));
			}
		}
		
		function RenderTradersTime(e){
	    	if(e.row.vcTradesName!=null || e.row.vcTradesName!=""){
	    		return (e.row.vcTradesName==null?"":e.row.vcTradesName) + "　" + nui.formatDate(e.row.tTradesTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return (nui.formatDate(e.row.tTradesTime, "yyyy-MM-dd HH:mm:ss"));
			}
		}
		
		function RenderInvestTime(e){
	    	if(e.row.vcInvestmanagerName!=null || e.row.vcInvestmanagerName!=""){
	    		return (e.row.vcInvestmanagerName==null?"":e.row.vcInvestmanagerName) + "　" + nui.formatDate(e.row.tInvestmanagerTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return (nui.formatDate(e.row.tInvestmanagerTime, "yyyy-MM-dd HH:mm:ss"));
			}
		}
		
		function RenderTradedepTime(e){
	    	if(e.row.vcTradedepName!=null || e.row.vcTradedepName!=""){
	    		return (e.row.vcTradedepName==null?"":e.row.vcTradedepName) + "　" + nui.formatDate(e.row.tTradedepTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return (nui.formatDate(e.row.tTradedepTime, "yyyy-MM-dd HH:mm:ss"));
			}
		}
		
		function RenderRiskTime(e){
	    	if(e.row.vcRiskmanagerName!=null || e.row.vcRiskmanagerName!=""){
	    		return (e.row.vcRiskmanagerName==null?"":e.row.vcRiskmanagerName) + "　" + nui.formatDate(e.row.tRiskmanagerTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return (nui.formatDate(e.row.tRiskmanagerTime, "yyyy-MM-dd HH:mm:ss"));
			}
		}
		
		function RenderFsOperateTime(e){
	    	if(e.row.vcFsOperateName!=null || e.row.vcFsOperateName!=null){
	    		return (e.row.vcFsOperateName==null?"":e.row.vcFsOperateName) + "　" + nui.formatDate(e.row.tFsOperateTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return (nui.formatDate(e.row.tFsOperateTime, "yyyy-MM-dd HH:mm:ss"));
			}
		}
		
		function RenderFsReviewTime(e){
	    	if(e.row.vcFsReviewName!=null || e.row.vcFsReviewName!=null){
	    		return (e.row.vcFsReviewName==null?"":e.row.vcFsReviewName) + "　" + nui.formatDate(e.row.tFsReviewTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return (nui.formatDate(e.row.tFsReviewTime, "yyyy-MM-dd HH:mm:ss"));
			}
		}
		
		function RenderFsDealTime(e){
	    	if(e.row.vcFsdealName!=null || e.row.vcFsdealName!=null){
	    		return (e.row.vcFsdealName==null?"":e.row.vcFsdealName) + "　" + nui.formatDate(e.row.tFsDealTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return (nui.formatDate(e.row.tFsDealTime, "yyyy-MM-dd HH:mm:ss"));
			}
		}
		
		function RenderBsDealTime(e){
	    	if(e.row.vcBsDealName!=null || e.row.vcBsDealName!=null){
	    		return (e.row.vcBsDealName==null?"":e.row.vcBsDealName) + "　" + nui.formatDate(e.row.tBsDealTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return (nui.formatDate(e.row.tBsDealTime, "yyyy-MM-dd HH:mm:ss"));
			}
		}
		
		//翻译后台成交状态字典
	    function bsDealRenderReview(e){
	    	return nui.getDictText("bsSetmtStatus",e.row.tBsDealState);
	    }
       	
		//翻译指令来源
	    function InstructResource(e){
	    	return nui.getDictText("instructResource", e.row.vcInstructSource);
	    }       
       	
       	//获取查询条件的产品名称
		function ButtonClickGetFundName_todayInstruct(e){
	        ButtonClickGetFundName(this);
		}
		
		//跨页多选选择表格获取产品
		function ButtonClickGetFundName(buttonEditObj){
	        nui.open({
	            url: "<%=request.getContextPath()%>/sm/comm/instruct/productInfoCombi.jsp",
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
       	
       	//重置
       	function reset(){
    		today_instruct.clear();
    		nui.get("queryType").setValue("2");
    		nui.get("lTradeDateMin").setValue(todayDate);
			nui.get("lTradeDateMax").setValue(todayDate);
    	}
    	
    	function onCloseClick(e){
	    	var obj = e.sender;
            obj.setText("");
            obj.setValue("");
	    }
    	
    	//复制指令/建议
		function copyInstruct(rowid){
            var row = todays_instruct_grid.getRow(rowid);
			if(rowid == undefined){
				row = todays_instruct_grid.getSelected();			
			}
			var tabIndex = 0;
		    nui.open({
					url: "<%=request.getContextPath() %>/instruction/interestSwap/newInstruct.jsp",
					title: "复制增加",
					width:870,
    				height:482,
					onload: function () {
						var iframe = this.getIFrameEl();
						row["operatorType"] = "2";//0-新建指令/建议 1-编辑指令/建议 2-复制指令
				        iframe.contentWindow.initWin(row);
					},
					ondestroy: function (action) {
    					search();
    					selectionchanged();
					},
			});

		}
    	
    	//选择改变
    	function selectionchanged(){
    		var rows = selectArr;
			nui.get("viewFlowChart").disable();
			if(rows.length == 1){
				var row = rows[0];		
				nui.get("viewFlowChart").enable();				
			}
    	}    	
    	
    	//修改
	    function edit(){
	    	var rows = selectArr;
	    	if(rows.length != 1){
				nui.alert("请先选中一条记录","提示");
				return;
			}
			var row = rows[0];
			// 3-二级债 其他为老机器猫
			if(row.vcProcessStatus == "4"){
				nui.alert("该指令/建议前台已成交,不可修改","提示");
				return;
			}else if(row.vcProcessStatus == "5"){
				nui.alert("该指令/建议已完成,不可修改","提示");
				return;
			}			
			nui.open({
					url: "<%=request.getContextPath() %>/instruction/interestSwap/newInstruct.jsp",
					title: "修改投资指令/建议",
					width:870,
    				height:507,
					onload: function () {
						var iframe = this.getIFrameEl();
						row["operatorType"] = "1"; //0-新建指令/建议 1-编辑指令/建议
				        iframe.contentWindow.initWin(row);
					},
					ondestroy: function (action) {
    					search();
    					selectionchanged();
					},
			});
	    }

	    // 指令撤销
	    function onCancle(){
	    	var rows = selectArr;	    	
	    	if(rows.length == 0){
				nui.alert("请先选中一条记录！","提示");
				return;
			}else if(rows.length > 1){
				nui.alert("请先选择一条记录,只支持单条撤销！","提示");
				return;
			}
			var row = rows[0];
			if(row.cIsValid != 1){
				nui.alert("该指令/建议已无效，无需再做撤销操作","提示");
				return;
			}
			if(row.vcProcessState == "4"){
				nui.alert("该指令/建议前台已成交,不可撤销","提示");
				return;
			}else if(row.vcProcessState == "5"){
				nui.alert("该指令/建议后台已成交,不可撤销","提示");
				return;
			}
			if(row.vcInstructSource=="3"){
				nui.open({
					url : nui.context + "/instruction/interestSwap/onCancelReason.jsp",
					title : "指令撤销",
					width : 500,
					height : 200,
					onload : function() {
						var iframe = this.getIFrameEl();
						row["operatorType"] = "3";
						row["type"]="interestSwap"
						iframe.contentWindow.setData(row);
					},
					ondestroy : function(action) {
			            var iframe = this.getIFrameEl();
			            //获取选中、编辑的结果
			            var returnJson = iframe.contentWindow.getData();
			            if(returnJson!= null){
				            returnJson = nui.clone(returnJson);    //必须。克隆数据。
					        if(returnJson.exception == null){
								if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
									nui.alert("当前指令序号为"+"["+row.lInstructNo+"],处理结果如下：</br>"+returnJson.rtnMsg,"提示",function(action){
						    			if(action == "ok"){						
						    				search();
						    			}
									});
								}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
									nui.alert("当前指令序号为"+"["+row.lInstructNo+"],处理结果如下：</br>"+returnJson.rtnMsg,"提示",function(action){
						    			if(action == "ok"){						
						    				search();
						    			}
									});
								}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_NO_RCV_FR_O32%>"){
									nui.alert("当前指令序号为"+"["+row.lInstructNo+"],处理结果如下：</br>"+returnJson.rtnMsg,"提示",function(action){
						    			if(action == "ok"){						
						    				search();
						    			}
									});
								}else{
									nui.alert("系统异常","提示",function(action){
						    			if(action == "ok"){						
						    				search();
						    			}
									});
								}
							}else{
								nui.alert("系统异常","提示",function(action){
					    			if(action == "ok"){						
					    				search();
					    			}
								});
							}
			            }else{
			            	if(action == "ok"){						
			    				search();			    				
			    			}
			            }
			            selectionchanged();
					}
				});
			}	
	    }

		//指令确认（批量）
		function batchConfirmTasks(){
			var rows = selectArr;
			if(rows.length>20){
				nui.alert("批量确认记录不能大于20条","提示");
				return;
			}
			var jsonParams = null;
    		var instructList = new Array();
        	// 开始处理
			if(rows.length>0){
				for (var i = 0; i < rows.length; i++) {
	    			var record = rows[i];//产品记录
					if(record.cIsValid!="1"){
					   	nui.alert("序号为"+rows[i].lInstructNo+"指令/建议已无效，不能再做审批确认操作！","提示");
					    return;
			  		}
					if(record.vcProcessState!="1"){
					   	nui.alert("序号为"+rows[i].lInstructNo+"指令/建议已复核，不能再做审批确认操作！","提示");
					    return;
			  		}
					//封装主键ID字段传输到后台处理开始...
					var queryType = nui.get("queryType").getValue();
			    	jsonParams = {instructId: rows[i].lInstructId, 
			    	instructNo: rows[i].lInstructNo, processState:rows[i].vcProcessState, 
			    	cIsValid:rows[i].cIsValid,queryType:queryType};
			    	instructList.push(jsonParams);
				}
				var msg = "确定要确认所选的 " + rows.length + " 条指令/建议吗？";
	    		nui.confirm(msg,"系统提示",function(action){
					if(action=="ok"){
						var a = nui.loading("正在处理中,请稍等...","提示");
						nui.ajax({
					    	url: "com.cjhxfund.ats.instruction.InterestSwap.InterestSwapInstruction.batchConfirmInstruction.biz.ext",
					      	type: 'POST',
					      	data: {tasks:instructList},		
					      	contentType: 'text/json',
					      	success: function(text){
					      		nui.hideMessageBox(a);
					      		var returnJson = nui.decode(text);
					      		if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
					      			nui.alert("指令确认成功","提示");
					      			search();
					      			selectionchanged();
					      		}
					      		if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
					      			var rtnMsg = returnJson.rtnMsg;
					      			nui.alert(rtnMsg,"提示");
					      			search();
					      			selectionchanged();
					      		}
					      	}
				 		});
				 		
					}
				});
			} else {
				nui.alert("请选中一条记录","提示");
			}
		}
    	
    	// 导出指令/建议
        function exportExcel(){
        	//清空列表
        	new nui.Form("#export_FROM").clear();
        	
			var rows = selectArr;
			// 定义指令/建议序号
			var lInstructId = "";
			var iselect = "false";
			var msg = "您未选中指令/建议，将导出全部指令/建议，确定要导出吗?";
			if(rows.length>0){
				var iselect = "true";
				msg = "确定要导出吗?";
				for(var i=0; i<rows.length; i++){
					lInstructId+= rows[i].lInstructId+",";
				}
				//去掉最后一个逗号
			    if (lInstructId.length > 0) {
			        lInstructId = lInstructId.substr(0, lInstructId.length - 1);
			    }
			}
		    
		    // 设置导出form参数
			var initParam = new nui.Form("#form_today_instruct").getData(false,false);
			var vcProductCode = initParam["vcProductCode"];
			//产品名称
			if(vcProductCode != null && vcProductCode != ""){
				document.getElementById("exportProductCode").value = vcProductCode;
			}
			//业务类别
			if(initParam.vcBusinType != null && initParam.vcBusinType != ""){
        		document.getElementById("exportBusinType").value = nui.get("vcBusinType").getValue();
        	}
        	//交易日期
        	if(initParam.lTradeDateMin != null && initParam.lTradeDateMin != ""){
        		document.getElementById("exportTradeDateMin").value = DateUtil.toNumStr(initParam.lTradeDateMin);
        	}else{
        		document.getElementById("exportTradeDateMin").value = DateUtil.toNumStr(new Date());
        	}
        	if(initParam.lTradeDateMax != null && initParam.lTradeDateMax != ""){
        		document.getElementById("exportTradeDateMax").value = DateUtil.toNumStr(initParam.lTradeDateMax);
        	}else{
        		document.getElementById("exportTradeDateMax").value = DateUtil.toNumStr(new Date());
        	}
        	//参考利率
        	if(initParam.vcReferRate != null && initParam.vcReferRate != ""){
        		document.getElementById("exportReferRate").value = nui.get("vcReferRate").getValue();
        	}
        	//期限
        	if(initParam.lLeftDays != null && initParam.lLeftDays != ""){
        		document.getElementById("exportLeftDays").value = nui.get("lLeftDays").getValue();
        	}
        	//对手方
        	if(initParam.vcCounterpartyId != null && initParam.vcCounterpartyId != ""){
        		document.getElementById("exportCounterpartyId").value = nui.get("vcCounterpartyId").getValue();
        	}    	       	
        	document.getElementById("exportQueryType").value = nui.get("queryType").getValue();
        	document.getElementById("exportIselect").value = iselect;
        	if(iselect == "true"){
        		document.getElementById("exportInstructId").value = lInstructId;
        	}
        	
			// 页面流跳转
			nui.confirm(msg,"系统提示",function(action){
				if(action=="ok"){
					nui.get("export_todayInstruct").disable();//禁用“导出”按钮
					var form = document.getElementById("export_FROM");				
					form.action = "com.cjhxfund.ats.instruction.InterestSwap.interestSwapExcle.flow";
			        form.submit();
			        //启用“导出”按钮
			        setTimeout("enableExport()",15000);
				}
			});
		}
		
		function enableExport(){
	  		nui.get("export_todayInstruct").enable();
		}
    	
    	// 任务表格操作列内容定义
		function operate(e){
			var s = null;
			var row = e.row;
			if(row.cIsValid == "1"){
					if(row.vcProcessState == "1"){
						s = '<a class="nui-button" style="color:#6959CD; cursor:pointer;text-decoration:underline;" onclick="goInstructDetail('+e.rowIndex+')">确认</a>';
					}
			}
			if(e.row.cIsValid != "5" && e.row.cIsValid != "1"){
				s = '<a class="nui-button" style="color:#6959CD; cursor:pointer;text-decoration:underline;" onclick="copyInstruct('+e.rowIndex+')">修改</a>';
			}
			return s;
		}
    	
    	// 加载指令详情页面
	    function goInstructDetail(rowid){
	    	var row = todays_instruct_grid.getRow(rowid);
			if(rowid == undefined){
				row = todays_instruct_grid.getSelected();			
			}
		    if (row) {
		    	nui.open({
		            url: "<%=request.getContextPath()%>/instruction/interestSwap/instructDetail.jsp",
		            title: "指令/建议详细展示",
		            width: 870,
		            height: 482,
		            onload: function () {
		                var iframe = this.getIFrameEl();
		                // 直接从页面获取，不用去后台获取
		                row["queryType"] = "2"; //1-投顾端 2-交易员端
		                iframe.contentWindow.setFormData(row);
		            },
		            ondestroy: function (action) {//弹出页面关闭前
		    			search();
			        }
		        });
		    }
	    }
    	
    	//行双击时弹出页面展示该指令/建议明细信息
	    todays_instruct_grid.on("rowdblclick", function (e) {
	    	var lProcessinstId = e.row.lProcessinstId;
	    	var row = e.record;
	    	if(lProcessinstId==null || lProcessinstId=="" || lProcessinstId==0){	    							
				openDetail(row);
			}
			else{	
		    	if(e.row.workitemId == '0'){
					var url = '<%=request.getContextPath() %>'
					+"/com.cjhxfund.fpm.bpsExpend.getTaskInfo.flow?processInstID="
					+e.row.lProcessinstId;
				} else {
					var url = "/com.cjhxfund.fpm.bpsExpend.getTaskInfo.flow?workItemID="+e.row.workitemId;
				}
				wfOpenWin(url);
		   }
	    });
    	
    	function openDetail(row){ 	
    		nui.open({
		            url: "<%=request.getContextPath()%>/instruction/interestSwap/instructDetail.jsp",
		            title: "指令/建议详细展示",
		            width: 870,
		            height: 482,
		            onload: function () {
		                var iframe = this.getIFrameEl();
		                iframe.contentWindow.setFormData(row);
		            },
		            ondestroy: function (action) {//弹出页面关闭前
		    			search();
			        }
		        });
    	}
    	
    	function chargeAgainst(rowid){
    		var row = todays_instruct_grid.getRow(rowid);
			if(rowid == undefined){
				row = todays_instruct_grid.getSelected();			
			}
    		nui.open({
	    		url:"<%=request.getContextPath() %>/instruction/interestSwap/newCharge.jsp",
    			title:"下达投资指令/建议", 
    			width:600,
    			height:550,
    			onload: function () {
					var iframe = this.getIFrameEl();
					row["operatorType"] = "0";
				    iframe.contentWindow.initWin(row);
				}, 			
    			ondestroy: function (action) {
					search();
					var rootMini = window.parent.mini;
					var tabs = rootMini.get("interestSwapTabs");
					var tab = tabs.getTab(2);
					tabs.reloadTab(tab);
					tabs.activeTab(tab);
    			}
    		});	
    	}
    	
    	//查看流程图
		function viewFlowChart(){
			window.open(nui.context+"/com.cjhxfund.foundation.task.ProcessChart.flow?processInstID="+selectArr[0].lProcessinstId);
		}
    	
    </script>
</body>
</html>