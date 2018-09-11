<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" session="false" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/bpsExpend/common/processCommon.jsp"%>
	<head>
	 <style type="text/css">
     .mini-grid-cell2{
     	text-align: center;
     	color: red;
     	font-size: 12pt;
     }
      #sendUser .mini-buttonedit-border{
    		border:solid 1px #a5acb5;
    	}
     	#sendUser .mini-textbox-border{
    		border:solid 1px #a5acb5;
    	}
     	#sendUser .mini-buttonedit-icon{
     		display:block;
     	}
     	#sendUser .mini-buttonedit-button{
     		display:block;
     	}
    </style>
    <title>流程信息查看</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<!-- 
	  - Author(s): zengjing
	  - Date: 2017-08-03 10:33:56
	  - Description:
	-->
	</head>
    <body style="width: 100%;height:99%;">
        <table id="processTable" style="width: 98%; table-layout: fixed;" class="nui-form-table">
			<tr class="odd">
				<th class="nui-form-label" style="width: 13%" >流程说明：</th>
				<td colspan="5" style="padding-left: 5px;width: 86%"><b:write property="processInst/processInstName" />
				</td>
			</tr>
			<tr>
				<l:notEmpty property="nextActor">
				        <th class="nui-form-label" style="width: 13%;">当前参与者：</th>
						<td style="padding-left: 5px;width: 20%" id="nextActorTd" valign="top"><b:write property="nextActor" /></td>
				    <l:notEmpty property="lastActor">
						<th class="nui-form-label" style="width: 8%">上一参与者：</th>
						<td style="padding-left: 5px;width: 20%;" id="lastActorTd" valign="top"><b:write property="lastActor" /></td>
					</l:notEmpty>
					<l:empty property="lastActor">
					     <th class="nui-form-label" style="width:8%"></th>
					     <td style="padding-left: 5px;width:20%"></td>
					</l:empty>
					<l:notEmpty property="procNextAct">
						<th class="nui-form-label" style="width:8%">下一参与者：</th>
						<td style="padding-left: 5px;width:20%" id="procNextActTd" valign="top"><b:write property="procNextAct" /></td>
					</l:notEmpty>
					<l:empty property="procNextAct">
					    <th class="nui-form-label" style="width:8%"></th>
					    <td style="padding-left: 5px;width:20%"></td>
					</l:empty>
				</l:notEmpty>

				<l:empty property="nextActor">
					<th class="nui-form-label" style="width:13%;"></th>
					<td style="padding-left: 5px;width: 20%"></td>
					<l:notEmpty property="lastActor">
						<th class="nui-form-label" style="width: 8%">上一参与者：</th>
						<td style="padding-left: 5px;width: 20%" id="lastActorTd" valign="top"><b:write property="lastActor" /></td>
					</l:notEmpty>
					<l:empty property="lastActor">
					     <th class="nui-form-label" style="width:8%"></th>
					     <td style="padding-left: 5px;width:20%"></td>
					</l:empty>
					<l:notEmpty property="procNextAct">
						<th class="nui-form-label" style="width:8%">下一参与者：</th>
						<td style="padding-left: 5px;width:20%" id="procNextActTd" valign="top"><b:write property="procNextAct" /></td>
					</l:notEmpty>
					<l:empty property="procNextAct">
					    <th class="nui-form-label" style="width:8%"></th>
					    <td style="padding-left: 5px;width:20%"></td>
					</l:empty>
				</l:empty>
			</tr>
			<l:equal property="processInst/currentState" targetValue="2">
			<tr>
				<th class="nui-form-label" style="width: 13%;">操作：</th>
				<td colspan="5"  style="padding-left: 5px;width: 86%">
					<l:equal property="bizProcess/processCreator"  targetProperty="currentUserId" >
							<!--杨志文20161020，将localType参数改为pageType参数  -->
							<a class="nui-button" id="abandon" iconCls="icon-close" onclick="abandonPro('<b:write property="processInst/processInstID"/>','<b:write property="pageType"/>','<b:write property="parTabId"/>')">废弃</a>
					</l:equal>
					<l:equal property="processInst/relateData"  targetValue="y" >
							<a class="nui-button" id="undo" iconCls="icon-undo" onclick="undo('<b:write property="processInst/processInstID"/>','<b:write property="parTabId"/>')">撤回</a>
					</l:equal>
				</td>
			</tr>
			</l:equal>
			
	         <tr class="odd">
		        <th class="nui-form-label" style="vertical-align: top;"> 附件： </th>
	            <td colspan="5">
				</td>
            </tr>
            </table>    
			 <table style="width: 100%; table-layout: fixed; border-collapse: collapse;">
			<tr>
           		<th class="nui-form-label" style="vertical-align: top;width:13%;">审批意见：</th>
           		
           		
           		<td colspan="3"  style="padding-left: 8px">
					 
		 		</td>
           	</tr>
           	
         <tr>
           		<td colspan="5"  style="padding-left: 28px">
					<div id="processGrid" class="nui-datagrid" dataField="pmprcaprvinfos" style="width: 97%;  max-height:270px; height:270px; margin-bottom: 50px"
						url="com.cjhxfund.fpm.bpsExpend.aprvInfo.queryAprvInfo.biz.ext"
						multiSelect="true" allowSortColumn="false" showPager="false" allowCellSelect="true" allowResizeColumn="false" allowCellWrap="true">
						<div property="columns"  style="overflow:auto;">
							<div field="vcWorkItemName" headerAlign="center" allowSort="true" width="13%"		visible="true">任务项</div>
							<div field="vcUserName" name="userName" headerAlign="center"  width="7%"	allowSort="true" visible="true">参与者</div>
							<div field="vcOperateType" headerAlign="center" allowSort="true" renderer="onOperateType"  width="7%">操作</div>
							<div field="vcOperatePeople" headerAlign="center" allowSort="true"  width="10%">转办/征求接收人</div>
							<div field="vcComments" headerAlign="center" allowSort="true" width="33%"		visible="true">处理意见</div>
							<div field="dStartTime" headerAlign="center" allowSort="true" width="12%"		visible="true" dateFormat="yyyy-MM-dd HH:mm:ss ">开始时间</div>
							<div field="dEndTime" headerAlign="center" allowSort="true" width="12%"	visible="true" dateFormat="yyyy-MM-dd HH:mm:ss ">结束时间</div>
						</div>
					</div>  
		 		</td>
           	</tr>
           	
		</table>  
	</body> 
</html>		
<script type="text/javascript">
	nui.parse();		
		
	var processDefName = '<b:write property="workitem/processDefName" />';
	var processInstID = '<b:write property="workitem/processInstID"/>';
	var wProcessInstID = '<b:write property="processInst/processInstID"/>';
	var activityInstID = '<b:write property="workitem/activityInstID"/>';
	var activityDefID = '<b:write property="workitem/activityDefID"/>';
	var activityInstName = '<b:write property="workitem/activityInstName" />';
	var workItemID = '<b:write property="workitem/workItemID"/>';
	var bizId = '<b:write property="bizId" />';
		
	//初始化流程
	initProcessView();
	function initProcessView(){
		var jsonstr;
		var thisProcessInstID = processInstID;
		if(processInstID == null||processInstID==""){
			thisProcessInstID = wProcessInstID;
		}
		//循环初始化附件直到业务页面被加载
		var interval = setInterval(function(){
			var iframe = loadProcessViewFileSrc();
			if(!!iframe){
				clearInterval(interval);
			}
		},1000);
		//审批意见
		var processGrid = nui.get("processGrid");
    	jsonstr = {processinstid:thisProcessInstID};
    	processGrid.load(jsonstr); 	
		//初始化参与者显示
		reSetActor();
	}		
	
	
 	//重新设置参与者人员
	function reSetActor(){
		if(document.getElementById("nextActorTd")!=null){
			var nextActor = document.getElementById("nextActorTd").innerHTML;
			if(nextActor.indexOf("@")!=-1){
			   nextActor = nextActor.replaceAll("@","<br>");
			}
			document.getElementById("nextActorTd").innerHTML = nextActor;
		}
		//上一参与者
		if(document.getElementById("lastActorTd")!=null){
			var nextActor = document.getElementById("lastActorTd").innerHTML;
			if(nextActor.indexOf("@")!=-1){
			    nextActor = nextActor.replaceAll("@","<br>");
			}
			document.getElementById("lastActorTd").innerHTML = nextActor;
		}
		//下一参与者
		if(document.getElementById("procNextActTd")!=null){
			var nextActor = document.getElementById("procNextActTd").innerHTML;
			if(nextActor.indexOf("@")!=-1){
			   nextActor = nextActor.replaceAll("@","<br>");
			}
			document.getElementById("procNextActTd").innerHTML = nextActor;
		}
	}
	
	
	function onOperateType(e){
  		return nui.getDictText("ATS_OPERATE_TYPE", e.row.operateType);
  	} 
  	
  	
  	    
	//废弃功能
    //将localType参数，改为pageType参数，杨志文，20161020
    function abandonPro(processInstID,pageType,parTabId){
        var urlStr="com.cjhxfund.fpm.bpsExpend.abandon.checkAbandonProcessInst.biz.ext";
        var json = nui.encode({processInstID:processInstID});
        var result = pm_ajax(json,urlStr,false);
        //console.log(result.processType);
        //console.log(result.procFlag);
        if(result!=null && result.procFlag=="Y"){
		    	if(confirm("是否确定废弃该流程？")){
		    	    abandonProcessData(json,parTabId);
		    	 }else{
		    		 return false;
		    	 } 
		 }else{
		   // 过虑产品名称变更子流程不能废弃
           if(result!=null && result.processType=="12"){
		        nui.alert("子流程不能被废弃","提示");
		   }else{
		       if(confirm("是否确定废弃该流程？")){
		    	    abandonProcessData(json,parTabId);
		       }else{
		    		return false;
		       } 
		   }
		 }
      }
    function abandonProcessData(reqData,parTabId){
            var urlStr = "com.cjhxfund.fpm.bpsExpend.abandon.abandonProcessInstByProcessInstID.biz.ext";
			nui.ajax({
				type:"post",
				url:urlStr,
				data:reqData,
				cache:false,
				async:false,
				contentType:'text/json',
				success:function(text){
					//关闭tab页面或返回我的任务
	                removeTabOrBackMyTasks('processNew',parTabId);
				}
			});
    }
    //撤回功能
	function undo(processInstID,parTabId){
		if(confirm("是否确定撤回流程提交？")){
    		var urlStr = "com.cjhxfund.fpm.bpsExpend.drawBack.drawBackWorkItem.biz.ext";
    		var json = nui.encode({processInstID:processInstID});
    		nui.ajax({
    			type:"post",
    			url:urlStr,
    			data:json,
    			cache:false,
    			async:false,
    			contentType:'text/json',
    			success:function(text){
    				//关闭tab页面或返回我的任务
                    removeTabOrBackMyTasks('processNew',parTabId);
    			}
    		});
    	 }
    	 else{
    		 return false;
    	 } 
	}
    
      //传阅功能
     function passRound(processInstID,localType){
    	 var btnEdit = nui.get("sendUser");
         nui.open({
	         url: contextPath +"/bpsExpend/empSelect/multSeletSend.jsp",
	         title: "员工列表",
	         width: 650,
	         height: 480,
	         onload: function () {
	             var iframe = this.getIFrameEl();
	             var btnEditValue = btnEdit.getValue();
	             var data = [];
	             if(btnEditValue!=null&&btnEditValue!=""){
	             	var empArr = btnEditValue.split(";");
	             	if(empArr!=null&&empArr.length>0){
	             		for(var i=0;i<empArr.length;i++){
	             			var emp = empArr[i];
	             			if(emp!=null&&emp!=""){
	             				var eArr = emp.split(",");
	             				var json = {"empid":eArr[0],"username":eArr[1]};
	             				data.push(json);
	             			}
	             		}
	             	}
	             }
	             iframe.contentWindow.setData(data);
	         },
	         ondestroy: function (action) {
	             if (action == "ok") {
	                 var iframe = this.getIFrameEl();
	                 var emps = iframe.contentWindow.getData();
	                 emps = nui.clone(emps); 
	                 if (emps) {
	                 	var empValue = "";
	                 	 var empValueArr =	emps.value.split(",");
	                      var empNameArr =	emps.name.split(","); 	
	                 	for(var i=0;i<empValueArr.length;i++){
	                 		if(empValueArr[i]!=""&&empValueArr[i]!="")
	                 			empValue += empValueArr[i] +","+empNameArr[i];
	                 		if(i<empValueArr.length-1){
	                 			empValue += ";";
	                 		}
	                 	}
	                     btnEdit.setValue(empValue);
	                     btnEdit.setText(emps.name);
	                     sendTips(empValue,emps.name,processInstID,localType);
	                 }
	             }
	         }
	     });   			
     }
     
     //TODO 传阅逻辑需要修改
     //发送传阅
     function sendTips(sendUser,sendUserText,processInstID,localType){
    	 if(!sendUser){
    		 alert("请选择传阅人员！");
    		 return;
    	 } else {
    		 if(confirm("请确定是否传阅至："+sendUserText)){
    			 
        	 }else{
	    		return false;
	    	 }
    	 }
    	 var json = nui.encode({sendUser:sendUser,processInstID:processInstID});
    	 nui.ajax({
 			type:"post",
 			url: "com.cjhxfund.fpm.bpsExpend.taskNotification.sendPassRoundNotice.biz.ext",
 			data:json,
 			cache:false,
 			async:false,
 			contentType:'text/json',
 			success:function(text){
 				if(confirm("发送信息成功，是否关闭本页面？")){
 			       setTimeout(function () {
 			    	  var rootMini = window.parent.mini;
 	 			      var tabs = rootMini.get("mainTabs");
 	 			      var tab = tabs.getActiveTab();
 	 			      tabs.removeTab(tab.name);
 		            }, 1);
 	        	 }else{
 		    		return false;
 		    	 }
 			}
 		});
     }
</script>		