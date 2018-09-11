<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-09-21 14:25:11
  - Description:
-->
<head>
<title>风控弹出列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="<%= request.getContextPath() %>/riskMgr/js/riskMgrComm.js"></script>
    <style type="text/css">
    	.mini-buttonedit-border{
    		padding-right:1px;
    	}
    	
    </style>
</head>
<body>
	<div id="panel" class="nui-panel" style="width:100%;height:100%;" showHeader="false" showFooter="true">
		<div property="footer" style="height: 30px">
	        <table width="100%">
	            <tr>
	                <td id="vcRiskType" style="text-align:center;" colspan="4">
						<span id="vcRiskType2" style="">
							<%--<span style="color: red;">触发禁止类风控、流程不允许提交：</span>--%>
							<span style="color: red;">是否覆盖当前风控信息：</span>
							<a id="continue2-1" class='nui-button' plain='false' iconCls="icon-ok" onclick="goOn(1)">覆盖</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a id="continue2-2" class='nui-button' plain='false' iconCls="icon-ok" onclick="goOn(-1)">取消</a>
						</span>
	                </td>
	            </tr>
	        </table>
	    </div>
		
		
		<div id="riskMsgDatagrid" class="nui-datagrid" style="width:100%;height:176px;" 
			showPager="false" multiSelect="false" onselectionchanged="onSelectionChanged">
	        <div property="columns">  
	            <div field="vcRuleId" headeralign="center" align="center" width="60px">风控序号</div>     
	            <div field="cRiskOperation" headeralign="center" renderer="renderRiskOperation" align="center" width="60px">触警操作</div>    
	            <div field="vcRiskType" headeralign="center" align="center" width="80px" renderer="renderRiskType">风控类型</div>  
	            <div field="vcRealValue" headeralign="center" align="center" numberFormat="n5" width="60px">实际值</div>
	            <div field="vcSettingValue" headeralign="center" align="center" numberFormat="n5" width="60px">设置值</div>  
	            <div field="vcRiskSummary" headeralign="center" align="center" width="180px">风控说明</div>  
	            <%--<div field="vcNumerator" headeralign="center" align="center" width="60px">分子值</div>
	            <div field="vcDenominator" headeralign="center" align="center" width="60px">分母值</div>--%>
	        </div>
	    </div>
	    
	    <div id="detailForm">
			<table style="width:100%;">
	            <tr>
	                <td width="70px" style="text-align: right">实际值：</td>
	                <td><input name="detailRiskMsg.vcRealValue" class="mini-textbox" enable="true" readonly="readonly"/></td>
	                <td width="70px" style="text-align: right">设置值：</td>
	                <td><input name="detailRiskMsg.vcSettingValue" class="mini-textbox" enable="false" readonly="readonly"/></td>
	                <td width="70px" style="text-align: right">触警操作：</td>
	                <td><input name="detailRiskMsg.cRiskOperation" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="riskOperation" enable="false" readonly="readonly"/></td>
	            </tr>
	            <tr>
	                <td style="text-align: right">基金：</td>
	                <td><input name="detailRiskMsg.vcProductName" class="mini-textbox" enable="false" readonly="readonly"/></td>
	                <td style="text-align: right">证券代码：</td>
	                <td><input name="detailRiskMsg.vcSymbol" class="mini-textbox" enable="false" readonly="readonly"/></td>
	                <td style="text-align: right">证券名称：</td>
	                <td><input name="detailRiskMsg.vcStockName" class="mini-textbox" enable="false" readonly="readonly"/></td>
	            </tr>
	            <tr>
	                <td style="text-align: right">风控说明：</td>
	                <td colspan="5"><input name="detailRiskMsg.vcRiskSummary" class="mini-textbox" width="93%" enable="false" readonly="readonly"/></td>
	            </tr>
	            <tr>
	                <td style="text-align: right">备注：</td>
	                <td colspan="5"><input name="detailRiskMsg.vcRemark" class="nui-textarea" width="93%" enable="false" readonly="readonly"/></td>
	            </tr>
	        </table>
	    </div>
	    
	</div>
	
	
	
	
	<script type="text/javascript">
    	nui.parse();
    	var riskMsgDatagrid = nui.get("riskMsgDatagrid");
    	var riskMsgForm = new nui.Form("#detailForm");
    	var riskMsg = {};	//风控信息
    	var instructParameter = {};	//交易信息
    	var riskInfo = {};	//风控管理数据
    	var lRiskmgrId = "";
    	
    	/*
    		callRiskType：1为查看页面，只有确认按钮
    		riskMsgData：触发的风控信息详情
    		instructParameterData：交易信息
    		amountInsufficient：是否触发可用 true(可用不足)
    		workItemID：工作项信息
    	*/
    	function SetData(callRiskType, riskMsgData, instructParameterData, riskmgrId){
    		riskMsg = nui.clone(riskMsgData);
    		instructParameter = nui.clone(instructParameterData);
    		lRiskmgrId = riskmgrId;
    		if(callRiskType!='1'){
	    		var vcRiskType = 1;	//1:预警  2:禁止  3:审批
	    		var resultDetail = riskMsg.resultDetail;
	    		if(resultDetail!=null){
	    			for(var i=0; i<resultDetail.length; i++){
		    			if(resultDetail[i].cRiskOperation=='2'){
		    				vcRiskType = 2;
		    				break;
		    			}
		    			if(resultDetail[i].cRiskOperation!='1'){
		    				vcRiskType = 3;
		    			}
		    		}
	    		}
	    		riskMsg.vcRiskType = vcRiskType;
	    		riskMsg.cDataSource = '1';	//数据来源
	    		
    		}
    		riskMsgDatagrid.addRows(riskMsg.resultDetail);
    		riskMsgDatagrid.select(riskMsgDatagrid.getRow(0),true);
    	}
    	
    	
    	
    	//按钮事件
    	function goOn(status){
    		var retAction = {action:''};
    		if(status=="1"){
    			saveRiskInfoByInstruct();//保存新风控信息
    			retAction.action = '1';
    		} else if (status=="-1"){
    			retAction.action = '-1';
    		}
    		CloseWindow(retAction);
    	}
    	
    	//保存新风控信息
    	function saveRiskInfoByInstruct(){
    		if(riskInfo!=null && riskInfo.lRiskmgrId!=null && riskInfo.lRiskmgrId!=""){
    			riskMsg.lRiskmgrId =  riskInfo.lRiskmgrId;
    		}
    		nui.ajax({
				url : "com.cjhxfund.ats.riskMgr.riskMgr.saveReloadRiskDetails.biz.ext",
				type : 'POST',
				data : {instructParameter:instructParameter, riskMsg:riskMsg, lRiskmgrId:lRiskmgrId},
				cache : false,
				async: false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if(returnJson.exception==null && returnJson.rtnObject!=null){
						if(returnJson.rtnObject.rtnCode!='-1'){
							rtn.lResultId = returnJson.riskMgrInfo.lResultId;
							rtn.lRiskmgrId = returnJson.riskMgrInfo.lRiskmgrId;
						}
					}
				}
		 	});
    	}
    	
    	
    	 //关闭窗口
        function CloseWindow(action) {
            if(window.CloseOwnerWindow){
            	return window.CloseOwnerWindow(action);
            }else{
            	window.close();
            }
        }
        
        riskMsgDatagrid.on("drawcell", function (e) {
	        var field = e.field,
	    		value = e.value;
	    	if(field =="cRiskOperation"){
	    		if(value=='1'){
	    			e.cellStyle = "color:#EEB422;font-weight:bold;";
	    		}else if(value=='2'){
	    			e.cellStyle = "color:red;font-weight:bold;";
	    		}
	    	}
	    });
    	
    	function renderRiskThreshhold(e){
    		return nui.getDictText("riskThreshhold",e.row.vcThreshhold);
    	}
    	
    	function renderRiskOperation(e){
    		return nui.getDictText("riskOperation",e.row.cRiskOperation);
    	}
    	
    	function renderRiskType(e){
    		return nui.getDictText("riskType",e.row.vcRiskType);
    	}
    	
    	//列表数据选中事件
    	function onSelectionChanged(e){
    		var record = riskMsgDatagrid.getSelected();
    		riskMsgForm.setData({detailRiskMsg: record});
    	}
    	
    </script>
</body>
</html>