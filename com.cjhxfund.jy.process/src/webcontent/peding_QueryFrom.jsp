<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): CJ-WB-DT13
- Date: 2016-01-25 17:40:16
- Description:
    --%>
    <head>
        <title>
            已办
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
		<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
		<script src="<%= request.getContextPath() %>/common/nui/locale/zh_CN.js" type="text/javascript"></script>
   		<script src="<%= request.getContextPath() %>/process/util/common.js" type="text/javascript"></script>
    <%
        String jurisdiction =  request.getParameter("jurisdiction");
     %>
    </head>
    <body style="width:100%;height:100%;overflow: hidden; margin: 0px;">
<!--       <div class="nui-tabs" id="tabs" style="width:100%;height:100%;">
         <div title="申购缴款" > -->
           <div class="search-condition" >
			  <div class="list">
	            <div id="form1" class="nui-form"  align="center" >
	                <!-- 数据实体的名称 -->
	                <input class="nui-hidden" name="bizCriteria/_entity" value="com.cjhxfund.jy.process.FirstGradeBond.queryWorkItemList">
	                <input class="nui-hidden" name="wfCriteria/_entity" value="com.eos.workflow.data.WFWorkItem" />
	                <input class="nui-hidden" name="bizCriteria/_orderby[1]/_sort" value="desc" />
	                <input class="nui-hidden" name="bizCriteria/_orderby[1]/_property" value="processDate" />
	                <!-- 指令/建议编号倒序排列 -->
	                <input class="nui-hidden" name="bizCriteria/_orderby[1]/_sort" value="desc" />
	                <input class="nui-hidden" name="bizCriteria/_orderby[1]/_property" value="investproductnum" />
	                
	                <input class="nui-hidden" name="jurisdiction" value="<%=request.getParameter("jurisdiction") %>"/>
	                <!-- 排序字段 -->
	                <table id="table1" class="table" style="width: 100%;" border="0">
	                    <tr>
	                        <td class="form_label" width="7%" align="right">
	                            业务日期:
	                        </td>
	                        <td colspan="1" width="17%" align="left">
	                            <input class="nui-datepicker" id="processDate" name="bizCriteria/_expr[1]/processDate" format="yyyy-MM-dd" />
	                            <input class="nui-hidden" name="bizCriteria/_expr[1]/_op" value="=">
	                        </td>
	                        <td class="form_label" width="7%" align="right">
	                        产品名称:
	                        </td>
	                        <td colspan="1" width="17%" align="left">
	                          <input id="vCFundCode_ZJTC" class="nui-buttonedit" name="bizCriteria/_expr[2]/combProductCode" id="combProductCode" onbuttonclick="ButtonClickGetFundName_ZJTC"/>
	                          <input class="nui-hidden" name="bizCriteria/_expr[2]/_op" value="in">
	                        </td>
	                        <td class="form_label" width="7%" align="right">
	                            业务类别:
	                        </td>
	                        <td colspan="1" width="17%" align="left">
	                            <input class="nui-combobox" data="[{id: 1, text: '一级债券(非可转债)'}, {id: 2, text: '一级债券(可转债/可交换债)'}]"
	                             valueField="id" name="bizCriteria/_expr[3]/businesstype" id="businessType" value="1" onvaluechanged="dynamicHidingColumn"/>
	                            <input class="nui-hidden" name="bizCriteria/_expr[3]/_op" value="=">
	                        </td>
	                        <td width="16%"></td>
	                   </tr>
	                   <tr>     
	                        <td class="form_label" align="right">
								交易状态:
			                </td>
			                <td colspan="1" align="left">
								<input class="nui-dictcombobox" name="bizCriteria/_expr[5]/validStatus" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_VALID_STATUS"  
										emptyText="全部" nullItemText="全部" showNullItem="true"  value="0"  multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
								<input class="nui-hidden" name="bizCriteria/_expr[5]/_op" value="in"/>
							</td>
							<td class="form_label" align="right">
								指令/建议编号:
			                </td>
			                <td colspan="1" align="left">
								<input class="nui-textbox" name="bizCriteria/_expr[6]/investproductnum" />
								<input class="nui-hidden"  name="bizCriteria/_expr[6]/_op" value="="/>
							</td>
							<%-- <% if(jurisdiction.equalsIgnoreCase("All")){ %> --%>
								
				                <td colspan="3" align="left">
									<div id="ck1" name="today" class="mini-checkbox" readOnly="false" value="true" text="当天已办流程"></div>
								&nbsp;&nbsp;
								    <div id="productId" name="productId" class="mini-checkbox" readOnly="false" text="本人已办流程" ></div>  
								&nbsp;&nbsp;
								    <div id="whetherindia" name="whetherindia" class="mini-checkbox" readOnly="false" text="已用印" ></div>   
								&nbsp;&nbsp;
	                        	<input class="nui-button" text="查询" iconCls="icon-search" onclick="search()" />
	                        </td>
	                    </tr>
	                </table>
	            </div>
          </div>
        </div>  
        <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" id="Abandoned" iconCls="icon-remove" onclick="Abandoned()">
                                废弃
                            </a>
                            &nbsp;
                            <a class="nui-button" id="flowChart" iconCls="icon-search" onclick="flowChart()">查看流程图</a>
                            &nbsp;
                            <a class="nui-button" id="fileDownload" iconCls="icon-download" onclick="fileDownload()">附件下载</a>
                            <!-- <a class="nui-button" iconCls="icon-edit" id="retracement" onclick="retracement()">修改</a> -->
                        </td>
                    </tr>
                </table>
            </div>
        <div class="nui-fit">
                <div id="datagrid1"
                        dataField="wflist"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.process.common.queryFinishWorkItems.biz.ext"
                        pageSize="20"
                        onselectionchanged="selectionChanged"
                        onShowRowDetail="onShowRowDetailList"
                        showPageInfo="true"
                        multiSelect="true"
                        allowSortColumn="false">

                    <div property="columns">
                        <div type="checkcolumn"></div>
                        <div type="expandcolumn"></div>
                        <div type="indexcolumn"></div>
                        <div field="btId" headerAlign="center" allowSort="true" visible="false">
                            编号
                        </div>
                        <div field="processinstid" headerAlign="center" allowSort="true" visible="false">
                            流程编号
                        </div>
                        <div field="workItemID" headerAlign="center" allowSort="true" visible="false">
                           工作项 编号
                        </div>
                        <div field="bizId" headerAlign="center" allowSort="true" visible="false">
                           业务编号
                        </div>
                        <div field="actionURL" headerAlign="center" allowSort="true" visible="false">
                           url
                        </div>
                        <div field="workitemNames" headerAlign="center" allowSort="true" width="150px" >
                           当前节点
                        </div>
                        <div field="processDate" headerAlign="center" align="center" allowSort="true" dateFormat="yyyy-MM-dd">
                            投标日期
                        </div>
                        <div field="combProductName" headerAlign="center" width="150px" allowSort="true" >
                            产品名称
                        </div>
                        <div field="vcCombiName" headerAlign="center" width="150px" allowSort="true" >
                            组合名称
                        </div>
                        <div field="investproductnum" headerAlign="center" align="center" allowSort="true" width="50">
                            编号
                        </div>
                        <div field="investProductCode" headerAlign="center" allowSort="true" >
                            债券代码
                        </div>
                        <div field="investProductName" headerAlign="center" allowSort="true" >
                            债券名称
                        </div>
                        
                        <div field="combProductCode" headerAlign="center" allowSort="true" visible="false">
                            产品代码
                        </div>
                        <div field="vcCombiNo" headerAlign="center" allowSort="true" visible="false">
                            组合代码
                        </div>
                        <div field="netWorthScale" headerAlign="center" allowSort="true" visible="false">
                            净值规模(万元)
                        </div>

                        <div field="paymentplace" headerAlign="center" align="center" allowSort="true" renderer="renderPaymentplace">
                            登记托管场所
                        </div>
                        <div field="interestrate" headerAlign="center" align="right" allowSort="true" >
                            投标利率(%)
                        </div>
                        <div field="investcount" headerAlign="center" align="right" allowSort="true" >
                            投标金额(万元)
                        </div>
                        
                        <div field="purchaseAmount" headerAlign="center" align="right" allowSort="true" visible="false">
                            申购金额(万元)
                        </div>
                        <div field="depositRatio" headerAlign="center" align="right" allowSort="true" visible="false">
                            定金比例(%)
                        </div>
                        <div field="depositAmount" headerAlign="center" align="right" allowSort="true" visible="false">
                            定金金额(万元)
                        </div>
                        
                        <div field="ratingname" headerAlign="center" align="center" allowSort="true" >
                            发行主体
                        </div>
                        <div field="ratingType" headerAlign="center" align="center" allowSort="true" renderer="renderRatingType">
                            发行主体类型
                        </div>
                        <div field="subjectrating" headerAlign="center" align="center" allowSort="true"  renderer="renderSubjectrating">
                            主体评级
                        </div>
                        <div field="bondrating" headerAlign="center" align="center" allowSort="true" renderer="renderBondrating">
                            债项评级
                        </div> 
                        <div field="ratingagencies" headerAlign="center" align="center" allowSort="true" renderer="renderRatingagencies">
                            评级机构
                        </div>
                        <div field="investcategory" headerAlign="center" align="center" allowSort="true" renderer="renderInvestcategory">
                            债券种类
                        </div>
                        <div field="issueSize" headerAlign="center" align="right" allowSort="true" >
                            发行规模(万元)
                        </div>
                        <div field="resaleRight" headerAlign="center" align="center" align="center" allowSort="true" renderer="renderresaleRight">
                            是否具有回售权
                        </div>
                        <div field="redemptionRight" headerAlign="center" align="center" allowSort="true" renderer="renderredemptionRight">
                            是否具有赎回权
                        </div>
                        <div field="categorydate" headerAlign="center" align="right" allowSort="true" >
                            债券期限(年)
                        </div>
                        <div field="categorymoney" headerAlign="center" align="right" allowSort="true" >
                            主体发行证券存量(万元)
                        </div>
                        <div field="mainBearingMechanism" headerAlign="center" align="center" allowSort="true" >
                            主承机构
                        </div>
                        <div field="validStatus" headerAlign="center" allowSort="true" renderer="renderValidStatus">
                            指令/建议状态
                        </div>
                    </div>
                </div>
            </div>
 <!--         </div>
      </div> -->
 <!--隐藏表单-->
<form action="" name="openForm" method="post" target="_blank">
  <input type="hidden" name="workItemID" id="workItemID"/>
  <input type="hidden" name="processinstid" id="processinstid"/>
  <input type="hidden" name="bizId" id="bizId"/>
  <input type="hidden" name="btId" id="btId"/>
  <input type="hidden" name="pageType" id="pageType" value="2"/>
</form>

<!-- 文档下载  -->
<form id="file_download" method="post">
	<!-- 数据实体的名称 -->
	<input class="nui-hidden" name="processId" id="processId"/>
	<input class="nui-hidden" name="btId"  id="btId"/>
</form>

<script type="text/javascript">
	nui.parse();
	var grid = nui.get("datagrid1");
			
	//给业务日期查询条件赋值
	//nui.get("processDate").setValue(new Date());
	
	var formData = new nui.Form("#form1").getData(false,false);
	grid.load(formData);

	//新增
	function add() {
		nui.open({
			url: "<%=request.getContextPath() %>/process/CfJyBusinessBoneTableForm.jsp",
			title: "新增记录", width: 700, height: 450,
			onload: function () {//弹出页面加载完成
				var iframe = this.getIFrameEl();
				var data = {pageType:"add"};//传入页面的json数据
				iframe.contentWindow.setFormData(data);
			},
			ondestroy: function (action) {//弹出页面关闭前
				grid.reload();
			}
		});
	}

	//重新刷新页面
	function refresh(){
		var form = new  nui.Form("#form1");
		var json = form.getData(false,false);
		grid.load(json);//grid查询
		nui.get("update").enable();
	}

	//查询
	top["win"] = window;
	function search() {
		var form = new nui.Form("#form1");
		var json = form.getData(false,false);
		grid.load(json);//grid查询
	}

	//重置查询条件
	function reset(){
		var form = new nui.Form("#form1");//将普通form转为nui的form
		form.reset();
	}

	//enter键触发查询
	function onKeyEnter(e) {
		search();
	}

	//当选择列时
	function selectionChanged(){
		var rows = grid.getSelecteds();
		if(rows.length>1){
			nui.get("Abandoned").disable();
			nui.get("flowChart").disable();
			nui.get("fileDownload").disable();
			//nui.get("retracement").disable();
		}else{
			nui.get("Abandoned").enable();
			nui.get("flowChart").enable();
			nui.get("fileDownload").enable();
			//nui.get("retracement").enable();
		}
	}
             
	//交易场所
	function renderPaymentplace(e){
		return nui.getDictText("CF_JY_DJTGCS",e.row.paymentplace);
	} 
             
	//主体评级
	function renderSubjectrating(e){
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_SUBJECT_RATING",e.row.subjectrating);
	}   
             
	//主体类型
	function renderRatingType(e){
		return nui.getDictText("CF_JY_ZTLX",e.row.ratingType);
	}
             
	//债项评级
	function renderBondrating(e){
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_BOND_RATING",e.row.bondrating);
	}
             
	//债券种类
	function renderInvestcategory(e){
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_BOND_CATEGORY",e.row.investcategory);
	}
             
	//评级机构
	function renderRatingagencies(e){
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_RATING_AGENCIES",e.row.ratingagencies);
	}
             
	//是否具有回售权
	function renderresaleRight(e){
		return nui.getDictText("COF_YESORNO",e.row.resaleRight);
	}
             
	//是否具有回售权
	function renderredemptionRight(e){
		return nui.getDictText("COF_YESORNO",e.row.redemptionRight);
	}
             
	//交易状态处理--所有业务通用
	function renderValidStatus(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_VALID_STATUS",e.row.validStatus);
	}
			
	function renderProessType(e){
		if(e.row.proessType ==1){
			return "一级债券(非可转债)";
		}else{
			return "一级债券(可转债)";
		}
	}
             
	//行双击时弹出页面展示该指令/建议详细信息--所有业务通用
	function rowdblclickFun(jspUrl, title, width, height, e, grid_confirm) {
		var row = e.record;//行对象值
		if (row) {
			nui.open({
				url: "<%=request.getContextPath()%>/"+jspUrl+"?bizId="+row.bizId+"&processinstid="+row.processinstid+"&workItemID="+row.workItemID,
				title: title,
				width: width,
				height: height,
				onload: function () {
					var iframe = this.getIFrameEl();
					var data = {pageType:"query",roleType:"TG",record:{cfjybusinessbonetable:row}};
					//直接从页面获取，不用去后台获取
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function (action) {//弹出页面关闭前
					if(action=="confirmSuccess"){//若是确认，则刷新页面
						grid.reload();
					}
				}
			});
		}
	}
    	
	//行双击时弹出页面展示该指令/建议详细信息
	grid.on("rowdblclick", function (e) {
		//rowdblclickFun(e.row.actionURL, e.row.workItemName, "100%", "100%", e, grid);
		wfOpenWin(e.row.actionURL,e.row.processinstid,e.row.workItemID,e.row.bizId,e.row.btId,"100%","100%");
	});
    
	function wfOpenWin(url,processInstID,workItemID,bizId,btId,width,height) {
		var winFrm=document.openForm;
		document.getElementById("processinstid").value=processInstID;
		if(workItemID == undefined){
			workItemID = 0;
		}
		document.getElementById("workItemID").value=workItemID;
		document.getElementById("bizId").value=bizId;
		document.getElementById("btId").value=btId;
		var businessType = nui.get("businessType").getValue();
		if(businessType == 1){
			url = "com.cjhxfund.jy.process.FirstGradeBond.FirstGradeBond.flow";
		}else{
			url = "com.cjhxfund.jy.process.FirstGradeBond.FirstGradeBond_KZZ.flow";
		}
		var actionURL=url; //目标页面
		winFrm.action=actionURL;
		var newwin = window.open('about:blank', 'newWindow');
		winFrm.target = 'newWindow';//这一句是关键
		winFrm.submit();
	}
		
	function ButtonClickGetFundName_ZJTC(e){
		ButtonClickGetFundName(this,'<%=request.getParameter("jurisdiction")%>');
	}
		
	function rendererWorkitemName(e){
		if(e.row.workitemNames == null){
			return "流程已结束";
		}else{
			return e.row.workitemNames;
		}
	}
		
	//指令/建议废弃
	function Abandoned(){
		var rows = grid.getSelected();
			if(rows){
				if(rows.currentstate == 7 || rows.currentstate == 8){
					nui.alert("该指令/建议已经结束,不能再次废弃!","系统提示");
					return;
				}
				var vcSource = rows.vcSource;
				var activityDefID = rows.activityDefID;
        		if(vcSource == 2 && (activityDefID == "manualActivity9" || activityDefID == "manualActivity10" || activityDefID == "manualActivity12" || activityDefID == "manualActivity14")){
        			nui.alert("已经中标确认的结果不能撤销指令/建议。","系统提示");
        			return;
        		}     
				nui.confirm("确定要废弃选中的指令/建议吗？","系统提示",
				function(action){
					if(action=="ok"){
						nui.prompt("请输入废弃原因：", "请输入",
					            function (action, value) {
					                if (action == "ok") {
					                    if(value==null || value==""){
					                    	nui.alert("请输入废弃原因再提交！");
					                    	return;
					                    }
											var json = nui.encode({processinstid:rows.processinstid,btId:rows.btId,comments:value,workitemId:rows.workItemID});
											grid.loading("正在废弃中,请稍等...");
											$.ajax({
												url:"com.cjhxfund.jy.process.cfjybusinessbonetablebiz.firstGradeBondeAbandoned.biz.ext",
												type:'POST',
												data:json,
												cache: false,
												contentType:'text/json',
												success:function(text){
													var returnJson = nui.decode(text);
													if(returnJson.returnValue == "yes"){
														grid.reload();
														nui.alert("指令/建议:"+rows.investproductnum+",废弃成功", "系统提示", function(action){});
													}else if(returnJson.returnValue == "12"){
														grid.unmask();
														nui.alert("流程已结束，不能废弃", "系统提示");
													}else{
														grid.unmask();
														if(returnJson.result == 0 && returnJson.returnValue == "no"){
															nui.alert("流程废弃失败", "系统提示");
															return;
														}else{
															nui.alert("调用订单废弃接口失败，请联系管理员。", "系统提示");
															return;
														}
													}
												}
											});
										}
									},
				            		  true
									);
								}
							}
				         );		
			}else{
				nui.alert("请选择一条指令/建议。","提示");
			}
	}
		
		
	//修改，回撤
	function retracement(){
		var row = grid.getSelected();
		if(row == null){
			nui.alert("请选择一条指令/建议。","系统提示");
			return;
		}
           
		//一级债券(非可转债)申购流程  : manualActivity4 — 投顾复核环节,manualActivity1 — 信息核对(交易员1)环节,manualActivity — 申购指令/建议下达环节
		//一级债券(可转债)申购流程 : FirstGradeBond_KZJ_SGZL — 申购指令/建议环节,FirstGradeBond_KZJ_TGFH — 投顾复核环节,FirstGradeBond_KZJ_XXHD1 — 信息核对(交易员1)环节
		if(row.activityDefID != "manualActivity4" && row.activityDefID != "manualActivity1" && row.activityDefID != "manualActivity" && row.activityDefID !="FirstGradeBond_KZJ_SGZL" && row.activityDefID !="FirstGradeBond_KZJ_TGFH" && row.activityDefID !="FirstGradeBond_KZJ_XXHD1"){
			nui.alert("该流程环节暂不支持修改要素,请通知当前处理人回退或废弃后重新发起。");
			return;
		}
           
		//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
		var validStatus = row.validStatus;
		if(validStatus != "0"){
			nui.alert("该指令/建议已无效，不能再做任何操作","提示");
			return;
		}
        	
		//判断当前登录人是否为流程发起人
		if(row.userId != operatorId){
			nui.alert("您不是该指令/建议的发起人，不能修改。");
			return;
		}
        	
		var businessType = nui.get("businessType").getValue();
           
		var url = "<%=request.getContextPath() %>/process/FirstGradeBond/CfJyBusinessBoneTableForm.jsp";
		var title = "申购缴款(非可转债)录入";
		var width = "850";
		var height = "695";
        //判断流程类型  1:一级债券(非可转债)申购流程        2:一级债券(可转债)申购流程  
		if(businessType == 2){
			url  = "<%=request.getContextPath() %>/process/FirstGradeBondKZJ/CfJyBusinessBoneTableKZZForm.jsp";
			title = "申购缴款(可转债)录入";
			width = "830";
			height = "660";
		}
                
		nui.open({
			url: url,
			title: title,
			width: width, height: height,
			onload: function () {
				var iframe = this.getIFrameEl();
				var data = {pageType:"edit",record:{cfjybusinessbonetable:row}};
				//直接从页面获取，不用去后台获取
				iframe.contentWindow.setFormData(data);
			},
			ondestroy: function (action) {
				grid.reload();
			}
		});
	}   
    
    //查看流程图 --所有业务通用
    function flowChart(){
        var rows = grid.getSelected();
        if(rows != null){
  			//process/processGraph.jsp
        	window.open("<%=request.getContextPath() %>/com.cjhxfund.jy.process.ProcessChart.flow?processInstID="+rows.processinstid);
        }else{
            nui.alert("请先选择指令/建议.","系统提示");
        }
    }    
	var jurisdiction = '<%=request.getParameter("jurisdiction") %>';
	if(jurisdiction =="All"){
		//nui.get("retracement").disable();
	}
	
	//附件下载--所有流程通用
	function fileDownload(){
		var rows = grid.getSelected();
		if(rows != null){
			//设置参数
			nui.get("processId").setValue(rows.processinstid);
			nui.get("btId").setValue(rows.btId);
			
			//给出提示并调用下载逻辑
			nui.confirm("确认要下载吗？","系统提示",function(action){
			if(action=="ok"){
				var form = document.getElementById("file_download");
				form.action = "com.cjhxfund.jy.process.indiaDFileDownload.flow";
		        form.submit();
			}
		});
		}else{
		   nui.alert("请先选择指令/建议.","系统提示");
		}
	}
</script>
  </body>
</html>
