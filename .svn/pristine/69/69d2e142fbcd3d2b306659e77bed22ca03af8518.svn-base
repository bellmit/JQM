<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 谭凯
  - Date: 2017-05-26 10:13:30
  - Description:
-->
<head>
	<title>交易员确认入围数量&价格</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="css/offeringStyle.css"/>
</head>
<%
    String processInstID = request.getParameter("processInstID");
	String workItemID = request.getParameter("workItemID");
	String vcExchangeNo=request.getParameter("vcExchangeNo");
	String vcType=request.getParameter("vcType");
 %>
<body>
<div id="tabs" class="nui-tabs" height="100%">
	<div title="交易员确认入围数量、发行价格" class="content">
        <div class="main">
            <form id="form1" method="post" >
            	<!--基本信息-->
            	<input name="processInstID" id="processInstID" class="nui-hidden" value="<%=processInstID %>"/>
            	<input name="workItemID" id="workItemID" class="nui-hidden" value="<%=workItemID %>"/>
            	<input id="vcExchangeNo" name="vcExchangeNo" class="nui-hidden" value="<%=vcExchangeNo %>" />
            	<input id="lInstructNo" name="ipoInstructInfo.lInstructNo" class="nui-hidden" />
            	<input id="vcType" name="vcType" class="nui-hidden" value="<%=vcType %>"/>
            	<div id="panel1" class="nui-panel" title="新股发行信息"  style="width:100%;" 
                		  showCollapseButton="true"  allowResize="true" 
                		collapseOnTitleClick="true">
            		<!-- 发行人 -->
					<ul class="form_list_name">
						<li>
					    	<span>发行人 :</span>
					   		<input name="ipoInstructInfo.vcIssuerName" class="nui-textbox input_width" readonly="true"/>
						</li>
						<li>
					    	<span>主承销商 :</span>
					    	<input name="ipoInstructInfo.vcLeadUnderwriterName" class="nui-textbox input_width" readonly="true"/>
					  	</li>
					 </ul>
					 <fieldset class="fieldset">
					 <legend>&nbsp;&nbsp;基本信息 &nbsp;&nbsp;</legend>
					 	<ul class="form_list">
					    	<li>
					        	<span class="info_name">公司名称 :</span>
					   			<input name="ipoInstructInfo.vcCompanyName" class="nui-textbox" readonly="true"/>
					        </li>
					        <li>
					            <span class="info_name">申购代码 :</span>
					        	<input id="vcPurchaseCode" name="ipoInstructInfo.vcPurchaseCode" class="nui-textbox" readonly="true"/>
					        </li>
					        <li>
					        	<span class="info_name">申购建议价格(元) :</span>
					        	<input id="enSuggestPrice" name="ipoInstructInfo.enSuggestPrice" class="nui-textbox" readonly="true"/>
					        </li>
					        <li>
					        	<span class="info_name">发行数量(万股) :</span>
					        	<input name="ipoInstructInfo.enIssueNumber" class="nui-textbox" readonly="true"/>
					        </li>
					        <li>
					        	<span class="info_name">发行后总股本(万股) :</span>
					        	<input id="enTotalEquity" name="ipoInstructInfo.enTotalEquity" class="nui-textbox" readonly="true"/>
					        </li>
					        <li>
					            <span class="info_name">网下发行上限(万股) :</span>
					            <input name="ipoInstructInfo.enOfflineIssueUpperNumber" class="nui-textbox" readonly="true"/>
					        </li>
					        <li>   
					            <span class="info_name">网下申购上限(万股) :</span>
					            <input id="enOfflineUpperNumber" name="ipoInstructInfo.enOfflineUpperNumber" class="nui-textbox" readonly="true"/>
					        </li>
					        <li>
					            <span class="info_name">网下申购下限(万股) :</span>
					            <input id="enOfflineUnderNumber" name="ipoInstructInfo.enOfflineUnderNumber" class="nui-textbox" readonly="true"/>
					        </li>
					        <li>
					        	<span class="info_name">网下申购规模(万元) :</span>
					        	<input name="ipoInstructInfo.enPurchaseScale" class="nui-textbox prohibit_input" readonly="true"/>
					        </li>
					        <li>
					            <span class="info_name">申购步长(万) :</span>
					            <input id="enPurchaseSize" name="ipoInstructInfo.enPurchaseSize" class="nui-textbox" readonly="true"/>
					        </li>
					        <li>
					            <span class="info_name">询价日 :</span>
					            <input id="lInquiryDate" name="ipoInstructInfo.lInquiryDate" class="nui-textbox" readonly="true"/>
					        </li>
					        <li>
					            <span class="info_name">网下申购日<em>*</em> :</span>
					            <input id="lOfflinePurchaseDate" name="ipoInstructInfo.lOfflinePurchaseDate" class="nui-datepicker" required="true"/>
					        </li>
					        <li>
					            <span class="info_name">市值门槛(万元):</span>
					            <input name="ipoInstructInfo.enMarketValueThreshold" class="nui-textbox" readonly="true"/>
					        </li>
						</ul>
					</fieldset>
					<!--定价信息-->
					<fieldset class="fieldset">
					<legend>&nbsp;&nbsp;定价信息 &nbsp;&nbsp;</legend>
						<ul class="form_list">
							<li>
					        	<span class="info_name">预计获配率 (%):</span>
					   			<input id="enPredictDistributionRate" name="ipoInstructInfo.enPredictDistributionRate" class="nui-textbox" readonly="true"/>
							</li>
							<li>
							    <span class="info_name_type">行业类别 :</span>
							    <input name="ipoInstructInfo.vcWindIndustryType" class="nui-textbox input_width" readonly="true"/>
							</li>
							<li>
							    <span class="info_name_type">发行价格<em>*</em> :</span>
							    <input id="enEnterPrice" name="ipoInstructInfo.enEnterPrice"  class="nui-textbox" emptyText="发行价格" vtype="float;min:0;" onvalidation="onNumberValidation" onvaluechanged="onvaluechanged" required="true"/>
							</li>
						</ul>
					</fieldset>
            	</div>
            </form>	
        	<!--操作按钮-->
			<div style="width:100%; ">
		        <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
		            <table style="width:100%;background:#DBE3F2;">
		                <tr>
		                    <td>
		                        <a id="button1" class='nui-button' plain='false' iconCls="icon-remove" onclick="removeRow(1)" plain="false">剔除</a>
					            <span class="separator"></span>
		                        <a id="button2" class='nui-button' plain='false' iconCls="icon-undo" onclick="removeRow(0)" plain="false">恢复</a>      
					            <span class="separator"></span>
		                    </td>
		                     <td  style="float:right;margin-right:10px;">
		                    	<span style="color:#626262;">已删除:<strong class="strong" style="background:#FF6666;"></strong></span>
		                    </td>
		                </tr>
		            </table>           
		        </div>
		    </div>
			<!--撑满页面-->
			<div class="mini-fit height-auto" style='height:auto !important' >   
			    <!--表格-->
			    <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" 
				    url="com.cjhxfund.ats.ipo.enterOrder.queryEnterInfo.biz.ext" 
				    idField="lOrderId"
				    dataField="enterInfo"
				    allowResize="true"  
			        allowCellEdit="true" 
			        allowCellSelect="true" 
			        multiSelect="true" 
			        cellEditAction="cellclick"
			        editNextOnEnterKey="true"
					onselectionChanged="selectionChanged">
				    <div property="columns">
				        <div type="indexcolumn" headerAlign="center" align="center">序号</div>
				        <div type="checkcolumn"></div>
				        <div field="vcProductName" width="9.2%" headerAlign="center" align="center">参与产品</div>
				        <div field="vcCombiName" width="9.2%" headerAlign="center" align="center">参与组合</div>
				        <div field="vcRationProductType" width="6.1%" align="center" headerAlign="center" renderer="rendervcRationProductType">产品类型</div>
				        <div field="enPurchasePrice" dataType="currency" width="5%" headerAlign="center" align="center">询价申报价格</div>
				        <div field="enPurchaseNumber" width="5%" headerAlign="center" align="center">询价申报数量</br>（万股）</div>
				        <div field="enPurchaseMoney" dataType="currency" width="5%" headerAlign="center" align="center">询价申购金额</br>（万元）</div>
				        <div field="enEnterPrice" dataType="currency" width="5%" headerAlign="center" align="center">发行价格</div>
				        <div field="enEnterAmount" vtype="float"  width="5%" headerAlign="center">入围数量<br>（万股）
			            	<input property="editor" class="nui-textbox" style="width:100%;" />
			            </div>
				        <div field="enEnterMoney" dataType="currency" width="5%" headerAlign="center" align="center">入围申购金额</br>（万元）</div>
				        <div name="vcRemark" field="vcRemark" width="10%" headerAlign="center">备注
			                <input property="editor" class="nui-textbox" style="width:100%;"/>                
			            </div>
				    </div>
				</div>
	        </div>
		</div>	
     </div>
     <div title="审批内容" name="index">
		<%@include file="/ipo/task/processControl.jsp" %>
	</div>
	<div title="流程信息" url="/ats/sm/comm/task/processGraph.jsp?processInstID=<%=processInstID %>" ></div>
</div>
<script type="text/javascript" src="js/loadbasicInfo.js"></script>
<script type="text/javascript">
    	var grid = nui.get("datagrid1");
    	//grid.frozenColumns (0,6);
    	var data = {processInstID:processInstID};
    	grid.load(data);
    	var vcExchangeNo=nui.get("vcExchangeNo").value;
    	var processInstID=nui.get("processInstID").value;
    	var button1=nui.get("button1");
    	
    	
    	/****
	    *
		* 函数名：processSubmit
		* 机   能： 提交流程
		* 输   入：无
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
		function processSubmit(){
			nui.get("processSubmit").disable();
			var processForm=new nui.Form("processForm");
			nui.confirm("确认是否提交流程？","系统提示",function(action){
				if(action == "ok"){
					var processForm=new nui.Form("processForm");
					var data=processForm.getData();
					data["workItemID"]=workItemID;
					var stockForm= new nui.Form("#form1");
					var stockData=stockForm.getData();
					var resultCode = updatePurchaseOrder(stockData.ipoInstructInfo);
					if(resultCode == 0){
						return false;
					}
					var approveData={approveParam:data};
					var json=nui.encode(approveData);
					<%--nui.ajax({
				        url: "com.cjhxfund.ats.ipo.task.finishMyWork.biz.ext",
				        type: "post",
				        data: json,
				        contentType:'text/json',
				        success: function (text) {
			        	var returnJson = nui.decode(text);
				        	if(returnJson.exception == null){
				        		if(returnJson.rtnCode=="-1"){
				        			nui.alert("审批确认失败","系统提示");
				        			nui.get("processSubmit").enable();
				        		}else{
				        			nui.alert("审批确认成功","系统提示",function(){
				        				opener.location.reload();
										window.opener = null;
										window.open(' ', '_self', ' ');
										window.close();
				        			});
				        		}
				        	}else{
				        		nui.get("processSubmit").enable();
				        	}
		        		},
		        		ondestroy:function(action){
		        			nui.get("processSubmit").enable();
		        		},
		        		error:function(error){
		        			nui.get("processSubmit").enable();
		        		}
					});--%>
				}else{
					nui.get("processSubmit").enable();
				}
			});
		}
    	
        /****
	    *
		* 函数名：removeRow
		* 机   能： 剔除入围产品报价信息
		* 输   入：无
		* 输   出: 无
		* 日   期：2017-06-06
		* 作   者： 
		*
		*****/
        function removeRow(status){
			var rows = grid.getSelecteds();
			if(status == 1){
				for(var i=0;i<rows.length;i++){
					if(rows[i].vcRemark==null){
						nui.alert("请备注删除原因","系统提示",function(){
							grid.setCurrentCell([rows[i],"vcRemark"]);
							grid.beginEditCell();
						});
						return;
					}
				}
			}
			var data={enterInfo:rows,status:status};
			var json=nui.encode(data);
			if(rows.length>0){
				nui.ajax({
			        url: "com.cjhxfund.ats.ipo.enterOrder.removeEnterOrder.biz.ext",
			        type: "post",
			        data: json,
			        contentType:'text/json',
			        success: function (text) {
			        	var returnJson = nui.decode(text);
			        	if(returnJson.exception == null){
			        		grid.reload();
			        		nui.alert("删除成功","系统提示");
			        	}
			        },
		    	});
		    }else{
		    	nui.alert("请选择一行数据","系统提示");
		    }
		}
		
	/****
	*
	* 函数名：selectionChanged
	* 机   能：列表选择发生变化时触发事件
	* 输   入：无
	* 输   出: 无
	* 日   期：2017-06-06
	* 作   者： 
	*
	*****/	
	function selectionChanged(){
		var vcType=nui.get("vcType").getValue();
		if(vcType!="null"){
			return;
		}
		var rcds = grid.getSelecteds();
		if(rcds.length == 1){//如果选中了一条记录
			button1.enable();
		}else{//如果选中了多条记录
			button1.disable();
		}
	}
	/****
	*
	* 函数名：rendervcRationProductType
	* 机   能：字典类型处理
	* 输   入：e 当前对象
	* 输   出: 无
	* 日   期：2017-06-06
	* 作   者： 
	*
	*****/		
	function rendervcRationProductType(e) {
		return nui.getDictText("ATS_IPO_RATION_TYPE",e.row.vcRationProductType);
	}
	
	
	/****
	*
	* 函数名：onNumberValidation
	* 机   能： 输入数字验证
	* 输   入：e 当前对象
	* 输   出: 无
	* 日   期：2017-06-06
	* 作   者： 
	*
	*****/		
	function onNumberValidation(e){
		if (e.isValid) {
	        if (isNumber(e.value) == false) {
	            e.errorText = "请输入正确的数字";
	            e.isValid = false;
	        }
	    }
	}
	
	/****
	*
	* 函数名：isNumber
	* 机   能： 是否数字判断
	* 输   入：v 传入参数
	* 输   出: 无
	* 日   期：2017-06-06
	* 作   者： 
	*
	*****/	
	function isNumber(v){
		var r = /^(0|[1-9]\d*)(\.\d+)?$/;
	    if (r.test(v)) return true;
	    return false;
	}
	
	/****
	*
	* 函数名：onvaluechanged
	* 机   能： 值发生改变时发生
	* 输   入：e  当前行对象
	* 输   出: 无
	* 日   期：2017-06-06
	* 作   者： 
	*
	*****/
	function onvaluechanged(e){
		var enEnterPrice = e.value;
		var rows=grid.getData();
    	for(var i=0;i<=rows.length-1;i++){
    		var enEnterMoney = rows[i].enEnterAmount * enEnterPrice;
    		grid.updateRow(rows[i],{enEnterPrice:enEnterPrice});//更新每行入围发行价格
    		grid.updateRow(rows[i],{enEnterMoney:enEnterMoney});//更新每行入围申购金额
    	}
	}
	
	
	/****
	*
	* 函数名：
	* 机   能： 编辑结束时发生
	* 输   入：e  当前行对象
	* 输   出: 无
	* 日   期：2017-06-06
	* 作   者： 
	*
	*****/
	grid.on("cellendedit", function (e) {
		var record=e.record;
		var enEnterAmount = record.enEnterAmount;
		enEnterAmount = parseFloat(enEnterAmount);
		var enOfflineUpperNumber=nui.get("enOfflineUpperNumber").getValue();
		enOfflineUpperNumber = parseFloat(enOfflineUpperNumber);
        var enOfflineUnderNumber=nui.get("enOfflineUnderNumber").getValue();
        enOfflineUnderNumber = parseFloat(enOfflineUnderNumber);
        if(enEnterAmount > enOfflineUpperNumber){
        	record.enEnterAmount = enOfflineUpperNumber;
        	record.enEnterMoney = record.enEnterPrice*enOfflineUpperNumber;
        	nui.alert("入围申购数量不能大于网下申购上限!");
        }else if(enEnterAmount < enOfflineUnderNumber){
        	record.enEnterAmount = enOfflineUnderNumber;
        	record.enEnterMoney = record.enEnterPrice*enOfflineUnderNumber;
        	nui.alert("入围申购数量不能小于网下申购下限!");
        }else{
			record.enEnterMoney = record.enEnterPrice*record.enEnterAmount;
        }
		grid.updateRow(record);//更新每行入围申购金额
	});
	
	/****
	*
	* 函数名：updatePurchaseOrder
	* 机   能： 更新入围指令/建议系你想
	* 输   入：enterInfo  基础指令/建议信息
	* 输   出: 无
	* 日   期：2017-06-06
	* 作   者： 
	*
	*****/
	function updatePurchaseOrder(enterInfo){
		var resultCode=1;
		var rows=grid.getChanges();
        var data={orderList:rows,enterInfo:enterInfo};
        var json=nui.encode(data);
        nui.ajax({
			url: "com.cjhxfund.ats.ipo.enterOrder.updateEnterOrder.biz.ext",
			type: "post",
			data: json,
			async:false,
			contentType:'text/json',
			success: function (text) {
				var returnJson = nui.decode(text);
		    	if(returnJson.rtnCode=="-1"){
		      		resultCode=0;
		       		nui.alert("审批确认失败，是由于申购指令/建议修改更新失败","系统提示");
		    	}
		    }
		});
		return resultCode;
	}
	
	
	grid.on("drawcell", function (e) {
	 	var record = e.record;
        //设置行样式
        if (record.cOrderStatus == "1") {//1:已删除;0:未删除
            e.rowStyle = "background:#FF6666";
        }else{
        	e.rowStyle = "background:#fff";
        }
	});
</script>
<style>
#tabs{
	height:auto !important
}
.mini-panel-viewport.mini-grid-viewport{
	height:auto !important
}
.height-auto{
	height:auto !important
}
.mini-panel-body.mini-grid-rows{
	height:auto !important
}
</style>
</body>
</html>