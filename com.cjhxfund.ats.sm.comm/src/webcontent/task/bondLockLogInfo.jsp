<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp"%>
<!-- 
  - Author(s): 童伟
  - Date: 2016-11-21 10:10:28
  - Description:
-->
<head>
<title>债券提前解锁</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/locale/zh_CN.js" type="text/javascript"></script>
    <style type="text/css">
      .td1{
        border-right: 1px solid #D3D3D3;
        border-left: 1px solid #D3D3D3;
      }
      .td2{
        border-right: 1px solid #D3D3D3;
      } 
    </style>
</head>
<%
    String processInstID = request.getParameter("processInstID");
    String workItemID = request.getParameter("workItemID");
    String currentState = request.getParameter("currentState");
 %>
<body style="width:100%;height:100%;margin:0px;">

  	<div id="tabs" class="nui-tabs" height="100%">
  		
   		<div title="解锁信息">
				
		  	<div style="padding-top:5px;" id="bondLockInfoForm" class="nui-form">
		  		<input class="nui-hidden" name="lUnlockId" value="lUnlockId">
		  		<table style="width: 100%; table-layout: fixed;" class="nui-form-table">
					<tr>
						<td class="form_label td1" width="17%" align="right">产品名称:</td>
						<td colspan="1" width="16%">
							<input name="vcProductName" id="vcProductName" width="170" class="nui-textbox" readonly />
						</td>
						<td class="form_label td1" width="17%" align="right">组合名称:</td>
						<td colspan="1" width="16%">
							<input name="vcCombiName" id="vcCombiName" class="nui-textbox" width="170" readonly />
						</td>
						<td class="form_label td1" width="17%" align="right">证券名称:</td>
						<td colspan="1" width="16%">
							<input name="vcStockName" id="vcStockName" width="170" class="nui-textbox" readonly />
						</td>
					</tr>
					
					<tr>
						<td class="form_label td1" width="17%" align="right">解锁数量:</td>
						<td colspan="1" width="16%">
							<input name="lUnlockQty" id="lUnlockQty" width="170" value="lUnlockQty" class="nui-spinner" minValue="0" maxValue="10000000000000" format="n0" readonly />
						</td>
						<td class="form_label td1" width="17%" align="right">首次锁定数量:</td>
						<td colspan="1" width="16%">
							<input name="lLockQtyFirst" id="lUnlockQtyFirst" width="170" value="lUnlockQtyFirst" class="nui-spinner" minValue="0" maxValue="10000000000000" format="n0" readonly />
						</td>
						<td class="form_label td1" width="17%" align="right">解锁后数量:</td>
						<td colspan="1" width="16%">
							<input name="lLockQty" id="lLockQty" width="170" value="lLockQty" class="nui-spinner" minValue="0" maxValue="10000000000000" format="n0" readonly />
						</td>
					</tr>
					<tr>
						<td class="form_label td1" width="17%" align="right">交易市场:</td>
						<td colspan="1" width="16%">
							<input name="vcMarket" id="vcMarket" width="170" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="tradePlace" readonly/>
						</td>
						<td class="form_label td1" width="17%" align="right">操作人ID:</td>
						<td colspan="1" width="16%">
							<input name="vcOperatorId" id="vcOperatorId" width="170" class="nui-textbox" readonly />
						</td>
						<td class="form_label td1" width="17%" align="right">申请解锁时间:</td>
						<td colspan="1" width="16%">
							<input name="tApplyUnlockTime" id="tApplyUnlockTime" width="170" class="nui-textbox" readonly />
						</td>
					</tr>
					
					<tr>
						<td class="form_label td1" width="17%" align="right">锁定类型:</td>
						<td colspan="1" width="16%">
							<input name="vclockType" id="vclockType" width="170" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="lockType" readonly />
						</td>
						<td class="form_label td1" width="17%" align="right">锁定状态:</td>
						<td colspan="1" width="16%">
							<input name="vcLockStatus" id="vcLockStatus" width="170" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="lockStatus"  readonly />
						</td>
						<td class="form_label td1" width="17%" align="right">解锁原因:</td>
						<td colspan="1" width="16%">
							<input name="vcUnlockReason" id="vcUnlockReason" width="170" class="nui-textbox" readonly />
						</td>
					</tr>
					
				</table>
				<input class="nui-hidden" name="lLockId" id="lLockId">
			</div>
			<div id ="bondLockApproveForm" style="display:none">
			
				<table style="width: 100%; table-layout: fixed;" class="nui-form-table">
					<tr>
						<td class="form_label td1" width="30%" align="right">审批条件:</td>
						<td colspan="1" class="td2" width="144%">
							<input id="checkResult" name="checkResult" value="1" class="nui-radiobuttonlist" data="[{id: 1, text: '通过'}, {id: 0, text: '不通过'}]"/>
		                </td>
					</tr>
					<tr>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
						<td class="form_label td1" width="30%" align="right">审批意见:</td>
						<td colspan="1" class="td2" width="50%">
							<input class="nui-textarea" id="checkComments" width="515" height="70" name="checkComments"/>
		                </td>
					</tr>
					<tr>
						<td class="form_label td2" width="30%" align="right"></td>
						<td colspan="1" class="td1" width="30%">
							<a class='nui-button' plain='false' iconCls="icon-save" onclick="submitApprove()">提交</a>
						</td>	
					</tr>
				</table>
			</div>
		</div>
		<div title="流程信息" url="<%=request.getContextPath() %>/sm/comm/task/processGraph.jsp?processInstID=<%=processInstID %>" ></div>
		
	</div>
		
	<script type="text/javascript">
		nui.parse();
		var processInstID = <%=processInstID %>;
		var workItemID = <%=workItemID %>;
		var currentState = <%=currentState %>;
		
		// 去掉业务字典下拉箭头
		$("#bondLockInfoForm .mini-buttonedit-button").remove();
		// 任务状态（待办=10，已办=12）
		if(currentState!=12 && currentState != 7){
			document.getElementById("bondLockApproveForm").style.display="";
		}
		
		// 加载表单数据
        var form = new nui.Form("#bondLockInfoForm"); 
        var data = {processInstID:processInstID}; //获取表单多个控件的数据
        var json1 = nui.encode(data);   //序列化成JSON           
        nui.ajax({
            url: "com.cjhxfund.ats.sm.comm.TBondLockInfoManager.getBondUnLockInfoByProcessinstId.biz.ext",
            type: "post",
            data: json1,
            contentType:'text/json',
            success: function (text) {
            	var info = nui.decode(text.bondUnLockInfo);   //反序列化成对象
            	if(info.tApplyUnlockTime != null){
                 	//var date = format(info.tOperatTime, 'yyyy-MM-dd HH:mm:ss');
                 	info.tApplyUnlockTime = nui.formatDate(info.tApplyUnlockTime, 'yyyy-MM-dd HH:mm:ss');;
                 }
            	form.setData(info);             // 设置多个控件数据
            }
        });
		  	
		// 提交审批
    	function submitApprove() {
            // 获取审批实体信息        
            var bondLockLogEntity = form.getData(); 	
            // 获取审批信息
            var approveForm = new nui.Form("#bondLockApproveForm");
            var approveInfo = approveForm.getData();  
            // 审批条件
            var checkResult = approveInfo.checkResult;
            // vcApprovalStatus 2  已通过;3  未通过	; checkResult 0不通过，1通过
            if(checkResult=="" || checkResult==null){
            	nui.alert("请选择审批条件");
            	return;
            }
            // 不通过
            if(checkResult==0){
            	bondLockLogEntity.vcApprovalStatus = 3;
            }
            // 通过
            if(checkResult==1){
            	bondLockLogEntity.vcApprovalStatus = 2;
            }
            // 审批意见
            var checkComments = approveInfo.checkComments;
            // workItemID
            var json = nui.encode({bondUnLockInfo:bondLockLogEntity,workItemID:workItemID,checkComments:checkComments,checkResult:checkResult});   	//序列化成JSON
   			var a = nui.loading("正在处理中,请稍等...","提示");
            nui.ajax({
                url: "com.cjhxfund.ats.sm.comm.TBondLockInfoManager.updateBondLockStatus.biz.ext",
                data: json,
                type: "post",
                contentType:'text/json',
                success: function (text) {
                	nui.hideMessageBox(a);
               		var returnJson = nui.decode(text);
                	if(returnJson.exception == null){
						if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
							//localStorage.lastWindow = "bondLockLogInfo";
                    		//window.close();
                    		nui.alert("审批成功","系统提示",function(action){
				    			if (!!window.ActiveXObject || "ActiveXObject" in window){//如果是IE浏览器
					              	window.opener.history.go(0);
					            }else{
					              	window.opener.reloadData();
					            }
								//返回我的代办任务页面
		    					CloseWindow("confirmSuccess");
			    			}); 
						}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
							nui.alert(returnJson.rtnMsg,"系统提示");
						}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_NO_RCV_FR_O32%>"){
							nui.alert(returnJson.rtnMsg,"系统提示");
						}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_RISK_VIOLATE_FORBID_CTRL%>"){
							nui.alert(returnJson.rtnMsg,"系统提示");
						}else{
							nui.alert("操作异常","系统提示");
						}
                    }
                }
            });
        }
        
        // 转换时间格式
        function format(time, format){
		    var t = new Date(time);
		    var tf = function(i){return (i < 10 ? '0' : '') + i};
		    return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a){
		        switch(a){
		            case 'yyyy':
		                return tf(t.getFullYear());
		                break;
		            case 'MM':
		                return tf(t.getMonth() + 1);
		                break;
		            case 'mm':
		                return tf(t.getMinutes());
		                break;
		            case 'dd':
		                return tf(t.getDate());
		                break;
		            case 'HH':
		                return tf(t.getHours());
		                break;
		            case 'ss':
		                return tf(t.getSeconds());
		                break;
		        }
		    });
		}
		
		//关闭窗口
	    function CloseWindow(action) {
	       if (window.CloseOwnerWindow)
	          return window.CloseOwnerWindow(action);
	       else window.close();
	    }
    </script>
   
</body>
</html>