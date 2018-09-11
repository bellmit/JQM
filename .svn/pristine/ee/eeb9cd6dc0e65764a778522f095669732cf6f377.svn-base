<%@page import="com.cjhxfund.commonUtil.ParamConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@page import="com.primeton.cap.AppUserManager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<%--
- Author(s): CJ-WB-DT13
- Date: 2016-01-25 17:40:16
- Description:
--%>
    <head>
        <title>
            风控信息查询
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
	</head>
    <body style="width:100%;height:100%;overflow: hidden; margin: 0px;">
       <div class="search-condition">
		  <div class="list">
            <div id="form1" class="nui-form"  align="center" style="height:10%" >
                <!-- 数据实体的名称 -->
                <table id="table1" class="table" style="width:100%;table-layout:fixed;" border="0">
                    <tr>
                        <td class="form_label" align="right" style="width: 60px;">
                            业务日期:
                        </td>
                        <td colspan="1" align="left" style="width:17%">
                            <input class="nui-datepicker" id="lTradeDateMin" format="yyyy-MM-dd" name="map.lTradeDateMin" width="95%"
                            showClose="true" oncloseclick="onCloseClickValueEmpty" onvaluechanged="search()"/>
                       </td>
                       <td style="width:60px" align="center">至</td>
                       <td colspan="1" align="left" style="width:17%">
                            <input class="nui-datepicker" id="lTradeDateMax" format="yyyy-MM-dd" name="map.lTradeDateMax" width="95%"
                            showClose="true" oncloseclick="onCloseClickValueEmpty" style="" onvaluechanged="search()"/>
                        </td>
                        <td class="form_label" align="right" width="80px">
                        产品名称:
                        </td>
                        <td colspan="1" align="left" style="width:17%">
                          <input class="nui-buttonedit" name="map.vcProductName" id="combProductCode" onbuttonclick="fundProdName" width="95%"
                          showClose="true" oncloseclick="onCloseClickValueEmpty" onvaluechanged="search()"/>
                        </td>
                        <td class="form_label" align="right" width="60px">
                            业务类型:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-dictcombobox" dictTypeId="bizTypeAll"
                            name="map.vcBizType" id="" width="95%" onvaluechanged="search()"
                            emptyText="全部" nullItemText="全部" multiSelect="true" valueFromSelect="true" showClose="true" oncloseclick="onCloseClickValueEmpty"/>
                        </td>
                        <td style="width:80px" align="left">
					       <a id="query" class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
					                        重置
					       </a>                        
					    </td>  
                   	</tr>
                   	<tr>	     
                        <td class="form_label" align="right">
                            流程节点:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-combobox"name="map.activityInstName" url="com.cjhxfund.ats.riskMgr.comm.queryRiskActivityName.biz.ext"
                            dataField="riskActName" textField="activityTranName" valueField="activityTranName" emptyText="全部" nullItemText="全部"
                            width="95%" showClose="true" oncloseclick="onCloseClickValueEmpty" onvaluechanged="search()"/>
                        </td>
                        <td class="form_label" align="right">
                            风控序号:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-textbox" name="map.lResultNo" width="95%" showClose="true" oncloseclick="onCloseClickValueEmpty" onvaluechanged="search()"/>
                        </td>
                         <td class="form_label" align="right">
                            风控审批类型:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-dictcombobox" dictTypeId="riskApproveType"
                            name="map.vcApproveType" id="businessType" width="95%" onvaluechanged="search()"
                            emptyText="全部" nullItemText="全部" multiSelect="true" valueFromSelect="true" showClose="true" oncloseclick="onCloseClickValueEmpty"/>
                        </td>
                        <td class="form_label" align="right">
                        风控状态:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-dictcombobox" dictTypeId="ATS_RISKMGR_STATUS"
                            name="map.cStatus" id="cStatus" width="95%" onvaluechanged="search()"
                            emptyText="全部" nullItemText="全部" multiSelect="true" valueFromSelect="true" showClose="true" oncloseclick="onCloseClickValueEmpty"/>
                        </td>
                        <td style="width: 60px;">
					        <div property="footer" align="left">
					            <a class='nui-button' plain='false' iconCls="icon-search"  onclick="search()">
					                查询
					            </a>
					        </div>
                        </td>
                    </tr>
                </table>
            </div>
          </div>
        </div>  
        <div class="nui-toolbar" style="border-bottom:0;padding:0px">
                <table style="width:100%;">
                    <tr>
                        <td style="width:65%;">
                        	<privilege:operation sourceId="startRiskBtn" sid="startRiskBtn" clazz="nui-button" onClick="confirm()" lableName="发起风控"  iconCls="icon-ok" ></privilege:operation>
                            <privilege:operation sourceId="batchStartRiskBtn" sid="batchStartRiskBtn" clazz="nui-button" onClick="batchConfirm()" lableName="批量发起"  iconCls="icon-ok" ></privilege:operation>
                            <input id="batchCheckRisk" class="nui-button" onClick="batchCheck()"iconCls="icon-ok" text="批量审批"/>
                        	<privilege:operation sourceId="" sid="flowChart" clazz="nui-button" onClick="flowChart()" lableName="查看流程图"  iconCls="icon-search" ></privilege:operation>
                        	<input class='nui-button' plain='false' text="自定义列" iconCls="icon-save" onclick="userColSet()"/>
                        </td>
                        <td align="right">
                        	<input class='nui-button' plain='false' iconCls="icon-reload" onclick="autoRefreshFun()" text="刷新"/>
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
							{ id: 1800, text: '每30分刷新' }]"/>
                        </td>
                    </tr>
                </table>
            </div>  
            <div class="nui-fit" >
            <!-- ------------填充方法配置------------- -->
                <div 
                        id="datagrid1"
                        dataField="riskmgrs"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.ats.riskMgr.riskMgr.queryRiskmgrList.biz.ext"
                        pageSize="20"
                        onShowRowDetail="onShowRowDetailList"
                        onselectionchanged="selectionChanged"
                        showPageInfo="true" showReloadButton="false"
                        multiSelect="true"
                        allowSortColumn="true"
                        sortField="dInsertDate"
                        sortOrder="desc">

                    <div property="columns">
                        
                        <%--<div type="checkcolumn">
                        </div>
                        <div type="expandcolumn"></div>
                        <div type="indexcolumn"></div>
                         <div name="action" width="40" align="center" headerAlign="center">操作</div>
                        <div field="lTradeDate" headerAlign="center" align="center" width="140px" allowSort="true" dateFormat="yyyy-MM-dd">
                            业务日期
                        </div>
                        <div field="dInsertDate" headerAlign="center" align="center" width="140px" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss">
                            录入时间
                        </div>
                        <div field="cStatus" headerAlign="center" allowSort="true" align="center" width="80px" renderer="rendererCStatus" >
                           风控状态
                        </div>
                        <div field="activityInstName" headerAlign="center" allowSort="true" width="200px" >
                           当前节点
                        </div>
                        <div field="vcProductName" headerAlign="center" width="250px" allowSort="true" >
                            产品名称
                        </div>
                        <div field="vcBizType" headerAlign="center" align="center" allowSort="true" width="150" renderer="bizTypeAll">
                            业务类型
                        </div>
                        <div field="vcEntrustDirection" headerAlign="center" align="center" allowSort="true"  renderer="entrustDirection" width="100">
                           委托方向
                        </div>
                        <div field="vcStockCode" headerAlign="center" align="center" allowSort="true" width="100px">
                            证券代码
                        </div>
                        <div field="stockCode" headerAlign="center" align="center" width="100px">
                           回购代码
                        </div>
                        <div field="vcStockName" headerAlign="center" allowSort="true" width="150px">
                            证券名称
                        </div>
                        <div field="lResultNo" headerAlign="center" align="center" allowSort="true" width="100px" >
                           交易序号
                        </div>                        
                        <div field="vcCombiName" headerAlign="center" align="center" width="100px" allowSort="true" >
                            组合名称
                        </div>
                        <div field="enFaceAmount" headerAlign="center"align="center" allowSort="true" width="100px">
                            券面金额
                        </div>
                        <div field="enFullPriceAmount" headerAlign="center"align="center" allowSort="true" width="100px">
                            交易金额
                        </div>
                        <div field="enTransactionPrice" headerAlign="center" allowSort="true"align="center" width="100px">
                            交易价格
                        </div>
                        <div field="" headerAlign="center" allowSort="true"align="center" width="100px">
                            设置值
                        </div>
                        <div field="" headerAlign="center" allowSort="true"align="center" width="100px">
                            偏离值
                        </div>
                        <div field="" headerAlign="center" allowSort="true" width="200px">
                            风控序号及对应的风控条款
                        </div>
                        <div field="vcApproveType" headerAlign="center" allowSort="true"align="center" renderer="riskApproveType" width="100px">
                            风控审批类型
                        </div>
                        <div field="cMistake" headerAlign="center" allowSort="true"align="center" renderer="rendererMistake" width="100px">
                            风控误卡
                        </div>--%>
                        
                    </div>
                </div>
            </div>
 <!--隐藏表单-->
<form action="" name="openForm" method="post" target="_blank">
  <input type="hidden" name="workItemID" id="workItemID">
  <input type="hidden" name="processInstID" id="processinstid">
  <input type="hidden" name="bizId" id="bizId">
  <input type="hidden" name="processType" id="processType">
  <input type="hidden" name="pageType" id="pageType" value="1"/>
  <input type="hidden" name="biztypename" id="biztypename"  />
  <input type="hidden" name="lResultId" id="lResultId"  />
  <input type="hidden" name="cBizType" id="cBizType"  />
</form>
<script type="text/javascript">
	nui.parse();
	var isFundManager = checkRole("ATS_JS_JJJLTZJL");	//是否投资/基金经理
	var grid = nui.get("datagrid1");
	var form = new nui.Form("#form1");
	var date = new Date();
	var todayDate = DateUtil.toNumStr(date);
	nui.get("lTradeDateMin").setValue(todayDate);
	nui.get("lTradeDateMax").setValue(todayDate);
	search();//加载表格
	var contextPath = '<%=request.getContextPath() %>';
	
	//根据配置加载显示列
	showUserColSet("riskmgr_query_list");
	
	//当选择列时
	function selectionChanged(e){
		var rows = grid.getSelecteds();
		if(rows.length>1){
			nui.get("flowChart").disable();
			if(nui.get("startRiskBtn"))nui.get("startRiskBtn").disable();
			
			var batchStartFlag = false;
			var batchCheckFlag = false;
			for(var i=0;i<rows.length;i++){
				var row = rows[i];
				var nextActor = row.nextActor;
				if(nextActor&&nextActor.indexOf(userName)>-1)batchCheckFlag = true;
				if(row.cStatus=="0"&& ("0" != row.cManageType || isFundManager) && !row.lAvailId) batchStartFlag = true;
			}
			//批量审批按钮
			if(batchCheckFlag) nui.get("batchCheckRisk").enable();
			else nui.get("batchCheckRisk").disable();
			//批量发起按钮
			if(batchStartFlag) if(nui.get("batchStartRiskBtn"))nui.get("batchStartRiskBtn").enable();
			else if(nui.get("batchStartRiskBtn"))nui.get("batchStartRiskBtn").disable();
		}else if(rows.length==1){
			var nextActor = rows[0].nextActor;
			if(rows[0].lProcessinstId&&rows[0].lProcessinstId!=0){
				nui.get("flowChart").enable();
			} else {
				nui.get("flowChart").disable();
			}
			if(rows[0].cStatus=="0" && ("0" != rows[0].cManageType || isFundManager) && !rows[0].lAvailId){
				if(nui.get("startRiskBtn"))nui.get("startRiskBtn").enable();
				if(nui.get("batchStartRiskBtn"))nui.get("batchStartRiskBtn").enable();
				nui.get("batchCheckRisk").disable();
			}else{
				if(nui.get("startRiskBtn"))nui.get("startRiskBtn").disable();
				if(nui.get("batchStartRiskBtn"))nui.get("batchStartRiskBtn").disable();
			}
			if(rows[0].cStatus=="1"&&nextActor&&nextActor.indexOf(userName)>-1){
				nui.get("batchCheckRisk").enable();
			} else {
				nui.get("batchCheckRisk").disable();
			}
			//风控误卡
			if(rows[0].cMistakeStatus=="1"||rows[0].cMistakeStatus=="2"){
				if(nui.get("startRiskBtn"))nui.get("startRiskBtn").disable();
				if(nui.get("batchStartRiskBtn"))nui.get("batchStartRiskBtn").disable();
			}
		}else{
		
		}
	}
	
	//渲染行对象
	grid.on("drawcell", function (e) {
		var record = e.record,
	 	    column = e.column;
		var row = e.row;
		var value = e.value;
		var nextActor = record.nextActor;
	    if(nextActor=="null" || nextActor=="" || nextActor=="undefined" || nextActor==null || nextActor==undefined)nextActor=null;
		//action列，超连接操作按钮
		if (column.name == "action") {
			e.cellStyle = "text-align:left";
			if(row.lProcessinstId&&row.lProcessinstId!=0){//判断风控流程
				//流程为当前处理人且未发起误卡流程或误卡废弃
				if(nextActor&&nextActor.indexOf(userName)>-1&&(row.cMistakeStatus!=1&&row.cMistakeStatus!=2)){
					e.cellHtml = "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='operateBtn(\"" + grid.indexOf(row) + "\",\"y\")'>审批</a>";
				} else {//不是当前处理人
					e.cellHtml = "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='operateBtn(\"" + grid.indexOf(row) + "\",\"n\")'>查看</a>";
				}
			} else if(row.cStatus==5||row.cStatus==6||((row.cStatus==4||row.cStatus==2)&&(!row.lProcessinstId||row.lProcessinstId==0))||!nui.get("startRiskBtn")){
				e.cellHtml = "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='operateBtn(\"" + grid.indexOf(row) + "\",\"n\")'>查看</a>";
			} else if(nui.get("startRiskBtn") && ("0" != row.cManageType || isFundManager)){//有发起权限且未发起误卡或误卡废弃
				e.cellHtml = "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='clickConfirm(\"" + grid.indexOf(row) + "\")'>发起</a>";
			} else {
				e.cellHtml = "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='operateBtn(\"" + grid.indexOf(row) + "\",\"n\")'>查看</a>";
			}
		}
		//展开行
		if(e.type=="expandcolumn"){
			if(!row.lProcessinstId||row.lProcessinstId==0){//判断风控流程
				e.cellHtml = "";
			}
		}
		//日期转换
		if(e.field=="lTradeDate" ){
			if(e.value){
				e.cellHtml = nui.formatDate(DateUtil.numStrToDate(e.value.toString()),"yyyy-MM-dd");
			}
		}
		//可用不足
		if(e.field=="vcProductName" && record.lAvailId!="" && record.lAvailId!=null){
			e.cellHtml = '<span title="'+value+'，可用不足！"'
			+' style="background: url('+nui.context+'/common/nui/themes/default/images/messagebox/icon-warning.gif);'
			+'background-size:20px 15px;background-repeat:no-repeat; '
			+'padding-left: 24px;">'+value+'</span>';
		}
	});
	
	//行双击时弹出页面展示该指令/建议详细信息
	grid.on("rowdblclick", function (e) {
		var index = grid.indexOf(e.row);
		if((!e.row.lProcessinstId||e.row.lProcessinstId==0)&&e.row.cStatus==0&&nui.get("startRiskBtn")&&(e.row.cMistakeStatus!=1&&e.row.cMistakeStatus!=2)) {
			confirm();
			return;
		}
		//没有流程ID
		if((!e.row.lProcessinstId||e.row.lProcessinstId==0)
				&&((e.row.cStatus==5||e.row.cStatus==6||e.row.cStatus==4||e.row.cStatus==2||!nui.get("startRiskBtn"))
					||e.row.cMistakeStatus==1||e.row.cMistakeStatus==2)){
			var url = "riskMgr/riskProcess/readRiskPage.jsp?lRiskmgrId="
   			+e.row.lRiskmgrId+"&lResultId="+e.row.lResultId+"&vcRiskType="+e.row.vcRiskType+"&cStatus="+e.row.cStatus+"&cBizType="+e.row.cBizType;
	   		var bizId = e.row.lRiskmgrId;
	   		wfOpenWin(url,"","",bizId);
			return;
		}
		var isUserFlag = "y";
		var nextActor = e.row.nextActor;
		if(nextActor&&nextActor.indexOf(userName)>-1)isUserFlag = "y";
		else isUserFlag = "n";
		operateBtn(index,isUserFlag);
	});
	
	//查看审批按钮
	function operateBtn(index,isUser){
	
	debugger;
		//注意index 必须转换为 整型，否则默认为字符型，getRow方法必须传入整型
   		var row = grid.getRow(parseInt(index));
   		var actionUrl="";
		if(row){
			var bizId=row.lRiskmgrId;
			var processInstId=row.lProcessinstId;
			var workItemID="";
			var activityInstName=row.activityInstName;
			var lResultId=row.lResultId;
			
			var pageType="";
			
			
			 var  vcBizType=row.vcBizType;
			var  biztypename="";
			if(vcBizType=="F1" ){
				biztypename= "申购流程";
				pageType="1";
		 	}else if(vcBizType=="F2"){
		 		biztypename= "缴款流程";
		 		pageType="1";
		 	}else{
		 	   pageType="2";
		 	
		 	}
		 	
		 	document.getElementById("biztypename").value=biztypename;
		 	document.getElementById("lResultId").value=lResultId;
		 	document.getElementById("pageType").value=pageType;
			
			if(isUser=="y"){//是否有权限
				var json = nui.encode({personID:operatorId,activityInstName:activityInstName,processInstId:processInstId});
				$.ajax({   //查询用户选中设计的workItemID
		            url:"com.cjhxfund.fpm.bpsExpend.process.queryWorkItemIdByUserId.biz.ext",
		            data:json,
		            type:'POST',
		            contentType:'text/json',
		            cache:false,
		            async:false,
		            success:function(data){
		            debugger;
		          
	                	if(data.workItem){
	                		workItemID = data.workItem.workItemID;
			    			actionUrl = "/com.cjhxfund.fpm.bpsExpend.getTaskInfo.flow?workItemID="+data.workItem.workItemID;
			    		} else {
			    			actionUrl = "/com.cjhxfund.fpm.bpsExpend.getTaskInfo.flow?processInstID="+processInstId;
			    		}
                   	}
                });
	    	} else if(processInstId!=""&&processInstId!=null&&processInstId!=0){//查看交易流程---------------------修改交易查看流程的URL
		    	actionUrl = contextPath + "/com.cjhxfund.fpm.bpsExpend.getTaskInfo.flow?processInstID="+processInstId;
	    	} else {
	    		var url = "riskMgr/riskProcess/readRiskPage.jsp?lRiskmgrId="
	   			+row.lRiskmgrId+"&lResultId="+row.lResultId+"&vcRiskType="+row.vcRiskType+"&cStatus="+row.cStatus+"&cBizType="+row.cBizType;
		   		var bizId = row.lRiskmgrId;
		   		wfOpenWin(url,"","",bizId);
				return;
	    	}
	    	wfOpenWin(actionUrl,processInstId,workItemID,bizId,row.processType,biztypename,lResultId);//----------------修改判断交易流程类型字段名
		}
	}
	
	//打开页面
	function wfOpenWin(url,processInstID,workItemID,bizId,processType,biztypename,lResultId) {
	     debugger;
		var winFrm=document.openForm;
		var actionURL=contextPath+"/"+url; //目标页面
		winFrm.action=actionURL;
		//防止重复打开页面
		winFrm.target = 'newWindow' + bizId;//这一句是关键
		var newwin = window.open('about:blank', 'newWindow' + bizId, '');
		winFrm.submit();
	}
	
	function fundProdName(){
		var btnObj = nui.get("combProductCode");
		ButtonClickGetFundNameString(btnObj);
	}
	
	
	//批量发起
	function batchConfirm(){
		var rows = grid.getSelecteds();
		var riskIds = [];
		//未选择产品
		if(rows.lenght==0){
			nui.alert("请选择待发起风控流程的数据");
			return;
		}
		
		var data = [];
		for(var i=0,j=0;i<rows.length;i++){
			var row = rows[i];
			if((!row.lProcessinstId || row.lProcessinstId==0) && row.cStatus==0 && (row.cMistakeStatus!=1&&row.cMistakeStatus!=2) && ("0" != row.cManageType || isFundManager)){//判断是否为交易流程数据
				riskIds[i] = row.lRiskmgrId;
				var vcEntrustDirection = row.vcEntrustDirection?row.vcEntrustDirection:"";
				var vcStockName = row.vcStockName?row.vcStockName:"";
				var enFullPriceAmount = row.enFullPriceAmount?row.enFullPriceAmount:"";
				data[j++] = {vcProductName:row.vcProductName,vcEntrustDirection:vcEntrustDirection,vcStockName:vcStockName,enFullPriceAmount:enFullPriceAmount};
			}
		}
		
		if(riskIds.length==0){
			nui.alert("请选择未发起风控流程的产品");
			return;
		} else {
			nui.open({
	            url: "<%=request.getContextPath()%>/riskMgr/instruct/riskTip.jsp",
	            title: "请确定是否启动以下交易的风控流程？",
	            width: 800,
	            height: 410,
	            onload: function () {
	                var iframe = this.getIFrameEl();
	                // 直接从页面获取，不用去后台获取
	                iframe.contentWindow.setData(data);
	            },
	            ondestroy: function (action) {//弹出页面关闭前
            		if(action == "1"){
            			var json = nui.encode({lRiskmgrIds:riskIds});
						$.ajax({   //批量发起流程
							//-------------------------------------批量发起逻辑流
				            url:"com.cjhxfund.ats.riskMgr.riskMgr.batchStartRiskProcess.biz.ext",
				            data:json,
				            type:'POST',
				            contentType:'text/json',
				            cache:false,
				            success:function(data){
				            	nui.alert("批量发起风控流程成功！");
				            	search();
				           	}
		    			});
	            	}
				}
	        });
		}
		
		
	}
	
	
	
	
	//发起单个风控
	function confirm(){
	debugger;
	 var row = grid.getSelected();
	 
	 var  vcBizType=row.vcBizType;
	 var  biztypename="";
	if(vcBizType=="F1" ){
		biztypename= "申购流程";
 	}else if(vcBizType=="F2"){
 		biztypename= "缴款流程";
 	}
 	
 	
 	
   		if(!row){
   			nui.alert("请选择一个产品发起风控！");
   			return;
   		}
   		//--------------------------------------------发起页面
   		//var url = "riskMgr/riskProcess/addRiskPage.jsp";
   		var url = "riskMgr/riskProcess/addRiskPage.jsp?lRiskmgrId="+row.lRiskmgrId+"&lResultId="+row.lResultId+"&vcRiskType="+row.vcRiskType+"&cBizType="+row.cBizType+"&biztypename="+biztypename;
   		var bizId = row.lRiskmgrId;
   		wfOpenWin(url,"","",bizId);
	}
	
	
	//点击发起操作
	function clickConfirm(index){
		var row = grid.getRow(parseInt(index));
		
	/* 	var  vcProcessType=row.vcProcessType;
	if(vcProcessType=="1" ||vcProcessType=="5"){
		biztypename= "申购流程";
 	}else if(vcProcessType=="8"){
 		biztypename= "缴款流程";
 	} */
 	
 	
 	var  vcBizType=row.vcBizType;
	 var  biztypename="";
	if(vcBizType=="F1" ){
		biztypename= "申购流程";
 	}else if(vcBizType=="F2"){
 		biztypename= "缴款流程";
 	}
		//--------------------------------------------发起页面
   		var url = "riskMgr/riskProcess/addRiskPage.jsp?lRiskmgrId="
   			+row.lRiskmgrId+"&lResultId="+row.lResultId+"&vcRiskType="+row.vcRiskType+"&cBizType="+row.cBizType+"&biztypename="+biztypename;
   		var bizId = row.lRiskmgrId;
   		wfOpenWin(url,"","",bizId);
	}
	
	
	
	//批量审批
	function batchCheck(){
		var rows = grid.getSelecteds();
		var riskDatas = [];
		//未选择产品
		if(rows.lenght==0){
			nui.alert("请选择待审批的风控流程");
			return;
		}
		
		for(var i=0;i<rows.length;i++){
			var row = rows[i];
			var data = {};
			var nextActor = row.nextActor;
			if(row.lProcessinstId&&row.lProcessinstId!=0&&row.cStatus==1&&nextActor&&nextActor.indexOf(userName)>-1
					&&(row.cMistakeStatus!=1&&row.cMistakeStatus!=2)){//判断是否为流转中风控流程数据
				data = {lRiskmgrId:row.lRiskmgrId,processInstId:row.lProcessinstId,activityInstName:row.activityInstName,userId:operatorId}
				riskDatas[i] = data;
			}
		}
		if(riskDatas.length==0){
			nui.alert("请选择待审批的风控流程");
			return;
		} else {
    		var json = nui.encode({riskDatas:riskDatas});
			$.ajax({   //批量审批流程
				//-------------------------------------批量审批逻辑流
	            url:"com.cjhxfund.ats.riskMgr.riskMgr.batchCheckRIskProcess.biz.ext",
	            data:json,
	            type:'POST',
	            contentType:'text/json',
	            cache:false,
	            success:function(data){
	            	nui.alert("批量审批风控流程成功！");
	            	search();
	           	}
			});
		}
	}
	
	//自动刷新功能
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
	
	//查看流程图 --所有业务通用
    function flowChart(){
        var rows = grid.getSelected();
        if(rows != null){
        	window.open("<%=request.getContextPath() %>/bpsExpend/processComm/processGraph.jsp?processInstID="+rows.lProcessinstId);
        }else{
            nui.alert("请选择一条流程","系统提示");
        }
    }
	
	function bizTypeAll(e){
	  	return nui.getDictText("bizTypeAll",e.row.vcBizType);
	}
	
	
	function riskType(e){
		return nui.getDictText("ATS_RISKMGR_RISKTYPE",e.row.vcRiskType);
	}
	
	function riskApproveType(e){
	  	return nui.getDictText("riskApproveType",e.row.vcApproveType);
	}
	
	function entrustDirection(e){
	  	return nui.getDictText("entrustDirection",e.row.vcEntrustDirection);
	}
	
	function rendererCStatus(e){
		return nui.getDictText("ATS_RISKMGR_STATUS",e.row.cStatus);
	}
	
	function rendererMistake(e){
		return nui.getDictText("COF_YESORNO",e.row.cMistake);
	}
	
	function reloadData(){//查询
		var json = form.getData(false,false);
		grid.reload(json);
	}
	
	//查询
	function search() {
		var form = new nui.Form("#form1");
		var json = form.getData(false,true);
		json.map.lTradeDateMin = json.map.lTradeDateMin?DateUtil.toNumStr(json.map.lTradeDateMin):null;
		json.map.lTradeDateMax = json.map.lTradeDateMax?DateUtil.toNumStr(json.map.lTradeDateMax):null;
		json.map.vcBizType = dealInValue(json.map.vcBizType);
		json.map.vcApproveType = dealInValue(json.map.vcApproveType);
		json.map.cStatus = dealInValue(json.map.cStatus);
		grid.load(json);//grid查询
	}
	//为多选值增加''
	function dealInValue(value){
		if(!value) return "";
		var array = value.split(",");
		for(var i=0;i<array.length;i++){
			array[i]="'"+array[i]+"'";
		}
		return array.join(",");
	}
	
	function reset(){//重置
		form.reset();
		search();
	}
	
	//enter键触发查询
	function onKeyEnter(e) {
		search();
	}
	
		//展示详细行数据
	function onShowRowDetailList(e) {
		var grid = e.sender;//获取表格
	    var row = e.record;//获取行数据
	    var remark = changeNull(row.vcRemarks);//备注信息 
	    var ProcessInstId = row.lProcessinstId;
	    var workItemID = row.workItemID;
	    //判断待办中传过来的流程ID是否为空-------------------流程ID为空时，不出现展开按钮
	    if(ProcessInstId == undefined||ProcessInstId==""||ProcessInstId==null){
	    	return;
	    }
	    if(workItemID == undefined){
	    	workItemID = row.WORKITEMID;
	    }
	    
	    var vcProcessType = row.vcProcessType;
	    if(vcProcessType == undefined){
	    	vcProcessType = row.VC_PROCESS_TYPE;
	    }

	    //获取债券信息
	    var processIdJson = nui.encode({processInstId : ProcessInstId,workItemID:workItemID});
	    $.ajax({
            url:"com.cjhxfund.ats.riskMgr.comm.queryTAtsApproveInfo.biz.ext",
            type:'POST',
            data:processIdJson,
            cache: false,
            contentType:'text/json',
            success:function(text){
                var returnJson = nui.decode(text);
                if(returnJson.exception == null){
                    var bonds = returnJson.TAsApproveInfos;
                    var heights = 0;  //动态div与table高度
                    //动态获取table高度
					var height = bonds.length * 25;
					if(height >= 250){   //判断是否大于250,设置DIV高度
						heights = 250;
					}else{
						heights = height + 75;
					}

                    var html = "<div style='width:1000px;height:"+heights+"px;overflow:auto;'><table border='0'  style='width:100%;'>";
					 
					/*if(abandonedReasons!=null && abandonedReasons!=""){
						html +=" <tr>"
							 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>废弃原因：</td>"
							 + "  <td>" + abandonedReasons + "</td>"
							 + " </tr>";
					} */
					if(remark!=null && remark!=""){
						html +=" <tr>"
							 + "  <td style='width:150px;font-weight:bold;vertical-align:top;' align='right'>备注信息：</td>"
							 + "  <td>" + remark + "</td>"
							 + " </tr>";
					}
					if(returnJson.nextActor!=null && returnJson.nextActor!=""){
						html +=" <tr>"
							 + "  <td style='width:150px;font-weight:bold;vertical-align:top;' align='right'>当前节点参与者：</td>"
							 + "  <td>" + returnJson.nextActor + "</td>"
							 + " </tr>";
					}
					html += "</table>";
                    
					if(height >= 150){   //判断是否大于150,设置table高度
						heights = 150;
					}else{
						heights = height;
					}
					var bondStr = html + "</table>";
					    bondStr += "<table  style='width:99%;height:"+heights+"px;'>"
                    			+" <tr>"
                    			+"  <td style='width:150px;font-weight:bold;' align='center'>审批时间</td>"
                    			+"  <td style='width:220px;font-weight:bold;' align='center'>节点名称</td>"
                    			+"  <td style='width:120px;font-weight:bold;' align='center'>操作者</td>"
                    			+"  <td style='width:120px;font-weight:bold;' align='center'>操作</td>"
                    			+"  <td style='width:200px;font-weight:bold;' align='center'>操作意见</td>"
                    			+" </tr>";
                    var vcOperateType = "同意";			
                    for(var i=0; i<bonds.length; i++){
                    	var bondInfo = bonds[i];
                    	  if(bondInfo.vcOperateType == 1){
                    		 vcOperateType = "同意";
					      }
					      if(bondInfo.vcOperateType == 2){
				    		  vcOperateType = "退办";
					      }
					      if(bondInfo.vcOperateType == 3){
					    	  vcOperateType = "转办";
					      }
					      if(bondInfo.vcOperateType == 4){
					    	  vcOperateType = "征求意见";
					      }
					      if(bondInfo.vcOperateType == 5){
					    	  vcOperateType = "否决";
					      }
					      
					      if(bondInfo.vcOperateType == 99 || bondInfo.vcOperateType == 0){
					    	  if(vcProcessType != 101 && vcProcessType != 102 && vcProcessType != 103){
					    		  vcOperateType = "不同意";
					    	  }else{
					    		  vcOperateType = "不通过";
					    	  }
					      }
					      
					      if(bondInfo.vcOperateType == 98){
					    	  vcOperateType = "修改";
					      }
					      if(bondInfo.vcOperateType == 97){
					    	  vcOperateType = "废弃";
					      }
					      if(bondInfo.vcOperateType == 96){
					    	  vcOperateType = "撤回";
					      }
					      
                    	bondStr += "<tr style='height:25px;'><td align='center'>"+ nui.formatDate(bondInfo.dEndTime, "yyyy-MM-dd HH:mm:ss")+"</td><td align='center'>"+changeNull(bondInfo.vcWorkItemName)+"</td><td align='center'>"+changeNull(bondInfo.vcUserName)
                    			+	"</td><td align='center'>"+changeNull(vcOperateType)+"</td><td align='center'>"+changeNull(bondInfo.vcComments)+"</td></tr>";
                    }
                    bondStr += "</table></div>";
                    
                    var td = grid.getRowDetailCellEl(row);

					td.innerHTML = bondStr;
                    
                }else{
					nui.alert("加载失败", "系统提示");
                }
            }
         });
	}
	
	/*自定义列*/
    function userColSet(){
    	nui.open({
            url: nui.context + "/riskMgr/userCol/addUserColSet.jsp?vcGridName=riskmgr_query_list",
            title: "自定义列", width: 750, height: 482
         });
    }
    
    function showUserColSet(vcGridName){
    	nui.ajax({
			url : "com.cjhxfund.ats.riskMgr.comm.queryUserColSet.biz.ext",
			type : 'POST',
			data : {vcGridName:vcGridName},
			cache : false,
			async: true,
			contentType : 'text/json',
			success : function(text) {
				var returnJson = nui.decode(text);
				if(returnJson.exception == null){
					if(returnJson.datas != null){
						var datas = returnJson.datas;
						var columns = initColumns();
						for(var i=0; i<datas.length; i++){
							if(datas[i].cIsShow=="1"){	//显示
								var column = {headerAlign:"center"};
								column.header = datas[i].vcColComment;
								column.field = datas[i].vcColName;
								if(datas[i].vcColWidth) column.width = datas[i].vcColWidth;
								if(datas[i].vcColAlign) column.align = datas[i].vcColAlign;
								if(datas[i].vcColAllowsort) column.allowSort = datas[i].vcColAllowsort;
								if(datas[i].vcColDateformat) column.dateFormat = datas[i].vcColDateformat;
								if(datas[i].vcColRenderer) column.renderer = datas[i].vcColRenderer;
								//columns.push(column);
								
								//判断是否分组
								if(datas[i].vcColGroup==null || datas[i].vcColGroup=="" || datas[i].vcColGroup=="-1"){
									columns.push(column);
								}else{
									//判断是否跟上一列属于同一个分组
									if(i>0 && columns.length>0 && datas[i].vcColGroup==columns[columns.length-1].header && columns[columns.length-1].columns!=null){
										columns[columns.length-1].columns.push(column);
									}else{
										var groups = new Array();
										groups.push(column);
										columns.push({header:datas[i].vcColGroup, headerAlign:"center", columns: groups});
									}
								}
								
							}
						}
						//console.log(columns);
						grid.setColumns(columns);
						return;
					}
				}
				alert("自定义列["+vcGridName+"]加载出错...请联系管理员！");
			}
		});
    }
    
    function initColumns(){
    	var columns = new Array();
    	columns.push({type: "checkcolumn"});
    	columns.push({type: "expandcolumn"});
    	columns.push({type: "indexcolumn"});
    	columns.push({header:"操作", name:"action", width:"40", headerAlign:"center"});
    	return columns;
    }
    
    //判断当前用户是否属于指定的角色
    function checkRole(roleCode){
    	var rtn = false;
    	nui.ajax({
			url : "com.cjhxfund.fpm.bpsExpend.role.queryRoleByCurrUserId.biz.ext",
			type : 'POST',
			data : {roleCode:roleCode},
			cache : false,
			async: false,
			contentType : 'text/json',
			success : function(text) {
				var returnJson = nui.decode(text);
				if(returnJson.exception == null){
					if(returnJson.roleEmp!=null && returnJson.roleEmp.flag =="1"){
						rtn = true;	
					}
				}
			}
		 });
		 return rtn;
    }
	
   </script>
  </body>
</html>
