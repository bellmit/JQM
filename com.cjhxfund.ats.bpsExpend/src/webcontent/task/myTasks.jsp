<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的任务</title>
<%@include file="/bpsExpend/common/common.jsp"%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>

<body style="margin:0;width: 100%; height:100%;overflow:hidden">
	 <div id="form1" class="nui-form" align="center" style="height: 40px;">
		<table id="table1" class="table" style="height: 100%; width: 100%">
			<tr  style="width: 100%;">
			<td class="form_label" style="text-align:right">流程类型:</td>
				<td colspan="1" class="form_label" align="left">
				<input class="nui-dictcombobox" dictTypeId="PM_PROC_TYPE" id="processType" name="criteriaMap/processType" onvaluechanged="search()" 
				emptyText="全部" showNullItem="true" nullItemText="全部"/>
				
				<td colspan="1" class="form_label" style="text-align:right" width="10%">产品名称:</td>
				<td colspan="1" class="form_label" align="center">
				<input class="nui-autocomplete" style="width: 100%;" name="criteriaMap/prodName" id="prodName" onclick="queryProdName()" onvaluechanged="search()"
							url="com.cjhxfund.fpm.bpsExpend.task.queryProductInfo.biz.ext" valueField="prodName" textField="prodName" dataField="products" /> 
				</td>
			   <td style="width: 3%;">
				    &nbsp;
				</td>
				<td colspan="1" align="left" style="width: 9%;">
					<a class="nui-button" onclick="search()" iconCls="icon-search"> 查询 </a>
				</td>
				<td colspan="1" align="left" style="width: 11%;">
				    <a class="nui-button" onclick="finishNoti()" iconCls="icon-reload">一键已阅</a>
				</td>
				<td colspan="1" align="left" style="width: 15%;">
				    <a id="editParts" class="nui-button" onclick="editPartAct()" iconCls="icon-edit" enabled="false">征求意见操作</a>
				</td>
				<td style="width: 5%;">
				    &nbsp;
				</td>
			</tr>
		</table>	
	</div>
	<div id ="tabs" class="nui-tabs" width="100%" height="100%" >
		<div title="待处理任务" refreshOnClick='true' url="<%=request.getContextPath() %>/bpsExpend/task/taskSub/todoTaskList.jsp?curTabId=<b:write property="curTabId"/>">
		</div>
		<div title="流转中任务 " refreshOnClick='true' url="<%=request.getContextPath() %>/bpsExpend/task/taskSub/runningTaskList.jsp?curTabId=<b:write property="curTabId"/>">
		</div>
		<div title="已完成任务"	refreshOnClick='true' url="<%=request.getContextPath() %>/bpsExpend/task/taskSub/finishedTaskList.jsp?curTabId=<b:write property="curTabId"/>">
		</div>
		<div title="待阅通知消息 " refreshOnClick='true' url="<%=request.getContextPath() %>/bpsExpend/task/taskSub/unViewNoticeList.jsp?curTabId=<b:write property="curTabId"/>">
		</div>
		<div title="已阅通知消息" refreshOnClick='true' url="<%=request.getContextPath() %>/bpsExpend/task/taskSub/viewedNoticeList.jsp?curTabId=<b:write property="curTabId"/>">
		</div>
		<div title="代理任务" refreshOnClick='true' url="<%=request.getContextPath() %>/bpsExpend/task/taskSub/agentTaskList.jsp?curTabId=<b:write property="curTabId"/>">
		</div>
	</div>
		
<script type="text/javascript">	
	nui.parse();
	var tabs = nui.get("tabs");
	var userRoleAuth="";
    getRoleAuth();
	loadData();
	resizeDatagridHeight();
	function getRoleAuth(){
	   //获取一个角色
		var roleJson = nui.encode({"roleCode":nui.getDictText("PM_ISSHOW_ACCT_TYPE",1001)});
		$.ajax({
			url : "com.cjhxfund.fpm.bpsExpend.role.queryRoleByCurrUserId.biz.ext",
			type : 'POST',
			data : roleJson,
			contentType : 'text/json',
			cache : false,
			async: true,
			success : function(obj) {
			   //console.log(obj.roleEmp);
			   //console.log(obj.roleEmp.flag);
			   if(obj!=null && obj.roleEmp.flag==1){
			       userRoleAuth="show";
			   }else{
			       userRoleAuth="hide";
			   }
			}
		});
	}
	//供其它页面调用
	function getUserAuth(){
	     return userRoleAuth;
	}
	//加载数据
	function loadData(){
		var json = nui.encode({processType:nui.get("processType").getValue(),prodName:nui.get("prodName").getValue()});
		//统计数量
		$.ajax({
			url : "com.cjhxfund.fpm.bpsExpend.task.queryTaskCount.biz.ext",
			type : 'POST',
			data : json,
			contentType : 'text/json',
			cache : false,
			async: true,
			success : function(d) {
				refrushTaskNum("todoTask",d.waitCount);
				refrushTaskNum("runningProcess",d.runningCount);
				refrushTaskNum("finishProcess",d.finishCount);
				refrushTaskNum("unViewNotice",d.unViewCount);
				refrushTaskNum("viewedNotice",d.viewCount);
				refrushTaskNum("agentTask",d.agentTaskCount);
			}
		});
	}
	
    //点击模糊查询产品名称 
	function queryProdName(){
		var t = nui.get("prodName");
	    //t.params = {prodName:nui.get("prodName").getValue()};
	    //console.log(t);
	   	t.doQuery();
	}
		
    	
    $(window).bind("resize", resizeDatagridHeight);
	// 自动调整datagrid的外部高度,撑满屏幕
	function resizeDatagridHeight(){
		var realheight = window.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight;
    	realheight = realheight - 30 + "px";
    	var datagridObj = document.getElementById("tabs");
    	datagridObj.style.height=realheight;
	}
	
	
	/**
	*更新任务数量
	*/
	function refrushTaskNum(taskType,taskNum){
		var tabs = nui.get("tabs");
		var tab = null;
		if(taskType == 'todoTask'){
			tab = tabs.getTab(0);
			tab.title="待处理任务<font color='red'>("+taskNum+")</font>";
			tabs.updateTab(tab,0);
		}else if(taskType == 'runningProcess'){	
			tab = tabs.getTab(1);
			tab.title="流转中任务<font color='red'>("+taskNum+")</font>";
			tabs.updateTab(tab,1);
		}else if(taskType == 'finishProcess'){
			tab = tabs.getTab(2);
			tab.title="已完成任务<font color='red'>("+taskNum+")</font>";
			tabs.updateTab(tab,2);
		}else if(taskType == 'unViewNotice'){
			tab = tabs.getTab(3);
			tab.title="待阅通知消息<font color='red'>("+taskNum+")</font>";
			tabs.updateTab(tab,3);
		}else if(taskType == 'viewedNotice'){
			tab = tabs.getTab(4);
			tab.title="已阅通知消息<font color='red'>("+taskNum+")</font>";
			tabs.updateTab(tab,4);
		}else if(taskType == 'agentTask'){
			tab = tabs.getTab(5);
			tab.title="代理任务<font color='red'>("+taskNum+")</font>";
			tabs.updateTab(tab,5);
		}
	}
	function search(){
		var form = new nui.Form("#form1");
        json = form.getData(false,false);
	   
	    var tab = tabs.getActiveTab();
	   	var iframe = tabs.getTabIFrameEl(tab);
	    iframe.contentWindow.search(json);
	     
	    loadData();
	}
	//一键待阅的方法   fanghb 20161208
	function finishNoti(){
		nui.showTips({
            content: "操作成功！请稍等",
            state: "success",
            x: "center",
            y: "center",
            timeout: 2000
        }); 
        $.ajax({
			url : "com.cjhxfund.fpm.bpsExpend.notice.finishNotificationByMytask.biz.ext",
			type : 'POST',
			data : "",
			contentType : 'text/json',
			cache : false,
			success : function(d) {
					search();
			}
		});
      
	}
    tabs.on("tabload",function(){
    	setEnabledToFalse();
    	search();
    });
    
    function returnValue(){
    	return {processType:nui.get("processType").getValue(),prodName:nui.get("prodName").getValue()};
    }
    
    /**
    * 打开操作征求意见环节参与人
    **/
    function editPartAct(){
    	var finishTab = tabs.getTab(1);
    	var iframe = tabs.getTabIFrameEl(finishTab);
    	var data=iframe.contentWindow.getGrids();
    	//alert(nui.encode(data));
    	nui.open({
			url: contextPath + "/bpsExpend/processFunction/opinion/modifyOpinions.jsp",
            title: "操作征求意见环节参与人", 
			width: 590,
	        height: 410,
            onload: function () {
				var iframe = this.getIFrameEl();
				iframe.contentWindow.SetData(data);
			},
			ondestroy: function (action) {
				
			}
		});
    }
    
    //用于开启被禁用页面上的征求意见按钮操作
    //该方法被"已完成任务"子页面调用
    function setEnabledToTrue(){
    	nui.get("editParts").setEnabled(true);
    }
    
    function setEnabledToFalse(){
    	nui.get("editParts").setEnabled(false);
    }
    
    
</script>
</body>
</html>