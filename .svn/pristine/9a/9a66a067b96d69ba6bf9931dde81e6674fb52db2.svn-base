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
<title>风控弹出列表（新）</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
    	.mini-buttonedit-border{
    		padding-right:1px;
    	}
    </style>
</head>
<body>
		<div id="riskMsgDatagrid" class="mini-datagrid" style="width:100%;height:190px;" 
		showPager="false" url=""  multiSelect="false" onselectionchanged="onSelectionChanged">
        <div property="columns">
            <div field="vcThreshhold" headeralign="center" renderer="renderRiskThreshhold" align="center" width="60px">触警级别</div>   
            <div field="vcRuleId" headeralign="center" align="center" width="60px">风控序号</div>   
            <div field="cRiskOperation" headeralign="center" renderer="renderRiskOperation" align="center" width="60px">触警操作</div>    
            <div field="vcProductName" headeralign="center" align="center" width="60px">基金</div>
            <div field="vcSymbol" headeralign="center" align="center" width="60px">证券代码</div>
            <div field="vcRiskType" headeralign="center" align="center" width="60px">风控类型</div>
            <div field="vcRealValue" headeralign="center" align="center" numberFormat="n5" width="60px">实际值</div>
            <div field="vcSettingValue" headeralign="center" align="center" numberFormat="n5" width="60px">设置值</div>  
            <div field="vcRiskSummary" headeralign="center" align="center" width="60px">风控说明</div>  
        </div>
    </div>

    <div id="detailForm" >
        <table style="width:100%;">
            <tr>
                <td width="70px" align="right">实际值：</td>
                <td><input name="detailRiskMsg.vcRealValue" class="mini-textbox" enable="true" readonly="readonly"/></td>
                <td width="70px" align="right">设置值：</td>
                <td><input name="detailRiskMsg.vcSettingValue" class="mini-textbox" enable="false" readonly="readonly"/></td>
                <td width="70px" align="right">触警操作：</td>
                <td><input name="detailRiskMsg.cRiskOperation" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="riskOperation" enable="false" readonly="readonly"/></td>
            </tr>
            <tr>
                <td align="right">基金：</td>
                <td><input name="detailRiskMsg.vcProductName" class="mini-textbox" enable="false" readonly="readonly"/></td>
                <td align="right">证券代码：</td>
                <td><input name="detailRiskMsg.vcSymbol" class="mini-textbox" enable="false" readonly="readonly"/></td>
                <td align="right">证券名称：</td>
                <td><input name="detailRiskMsg.vcStockName" class="mini-textbox" enable="false" readonly="readonly"/></td>
            </tr>
            <tr>
                <td align="right">风控说明：</td>
                <td colspan="5"><input id="vcRiskSummary" name="detailRiskMsg.vcRiskSummary" class="mini-textbox" width="93%" enable="false" readonly="readonly"/></td>
            </tr>
            <tr>
                <td align="right">备注：</td>
                <td colspan="5"><input name="detailRiskMsg.vcRemark" class="nui-textarea" width="93%" enable="false" readonly="readonly"/></td>
            </tr>
        </table>
    </div>
	<div class="nui-toolbar" >
        <table width="100%">
            <tr>
                <td style="text-align:center;" colspan="4">
                    <a id="continue" class='nui-button' plain='false' iconCls="icon-ok" onclick="goOn()">
                        继续
                    </a>
                    <a id="cancel" class='nui-button' plain='false' iconCls="icon-cancel" onclick="goCancel()">
                        取消
                    </a>
                    <a id="confirm" class='nui-button' plain='false' iconCls="icon-ok" onclick="goOn()">
                       确定
                    </a>
                </td>
            </tr>
        </table>
    </div>
	<script type="text/javascript">
    	nui.parse();
    	$("#detailForm .mini-buttonedit-button").remove();
    	var riskMsgDatagrid = nui.get("riskMsgDatagrid");
    	var riskMsgForm = new nui.Form("#detailForm");
    	function SetData(data,riskType){
    		if(riskType==3){
    			nui.get("continue").hide();
    			nui.get("cancel").hide();
    		}else if(riskType==2){
    			nui.get("continue").disable();
    			nui.get("confirm").hide();
    		}else{
    			nui.get("continue").enable();
    			nui.get("confirm").hide();
    		}
    		var riskMsg = nui.clone(data);
    		if(riskMsg==null || riskMsg==""){
    			nui.get("vcRiskSummary").setValue(data.rtnMsg);
    			return;
    		}
    		//判空
    		if(riskMsg.resultDetail==null || riskMsg.resultDetail==""){
    			nui.get("vcRiskSummary").setValue(riskMsg.uncontrolDetail[0].vcRiskSummary);
    		}else{
    			riskMsgDatagrid.addRows(riskMsg.resultDetail);
    			riskMsgDatagrid.select(riskMsgDatagrid.getRow(0),true);
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
    	//列表数据选中事件
    	function onSelectionChanged(e){
    		var record = riskMsgDatagrid.getSelected();
    		riskMsgForm.setData({detailRiskMsg: record});
    	}
    	
    	 //关闭窗口
        function CloseWindow(action) {
            if (window.CloseOwnerWindow)
            return window.CloseOwnerWindow(action);
            else window.close();
        }
    	function goOn(){
    		CloseWindow("ok");
    	}
    	function goCancel(){
    		CloseWindow("cancel");
    	}
    	
    	function renderRiskThreshhold(e){
    		return nui.getDictText("riskThreshhold",e.row.vcThreshhold);
    	}
    	
    	function renderRiskOperation(e){
    		return nui.getDictText("riskOperation",e.row.cRiskOperation);
    	}
    </script>
</body>
</html>