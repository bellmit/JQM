<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
<script type="text/javascript">

//提交数据----所有业务通用
function submitDataCommon(json, urlStr, validStatusUrl){
	//提交之前再次实时查询指令/建议单有效状态，避免用户在操作界面停留时间太长导致界面数据状态与数据库不一致
	validStatusUrl = validStatusUrl==null||validStatusUrl==""?"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getValidStatus.biz.ext":validStatusUrl;
	var a = nui.loading("正在处理中,请稍等...","提示");    
	//若指令/建议单有效，则继续执行
  	  	$.ajax({
			url:urlStr,
			type:'POST',
			data:json,
			cache:false,
			contentType:'text/json',
			success:function(text){
				
				nui.hideMessageBox(a);
				var returnJson = nui.decode(text);
				if(returnJson.exception == null){
					nui.alert("保存成功","系统提示",function(action){
						if(action == "ok"){
							CloseWindows("ok");
						}
					});
				}else{
					nui.alert("保存失败", "系统提示", function(action){
						if(action == "ok" || action == "close"){
							//CloseWindow("saveFailed");
						}
					});
				}
			}
		});
}

//保存数据----所有业务通用
function saveDataCommon(form, pageType, urlStr, roleType, processStatusUrl, validStatusUrl, updateInstructStatus){
	
	var data = form.getData(false,true);
    var json = nui.encode(data);
    var a = nui.loading("正在处理中,请稍等...","提示"); 
	//编辑，先查询该指令/建议流程处理状态，让编辑人员再次确认
	processStatusUrl = processStatusUrl==null||processStatusUrl==""?"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProcessStatus.biz.ext":processStatusUrl;
    if(pageType=="edit" && updateInstructStatus =="0"){
    	$.ajax({
            url:processStatusUrl,
            type:'POST',
            data:json,
            cache:false,
            contentType:'text/json',
            success:function(text){
                var returnJsonStatus = nui.decode(text);
                var processStatus = returnJsonStatus.processStatus;
                nui.get("processStatus").setValue(processStatus);
                data = form.getData(false,true);
    			json = nui.encode(data);
    			//提示信息
    			var msg = "";
				if(processStatus=="-2"){
	        	}else if(processStatus=="-1"){
	        		msg = "该指令/建议已补齐，确定要继续修改吗？";
	        	}else if(processStatus=="0" || processStatus=="1"){
	        		msg = "该指令/建议投资顾问已下单，确定要继续修改吗？";
	        	}else if(processStatus=="2"){
	        		msg = "该指令/建议投资经理已下单，确定要继续修改吗？";
	        	}else if(processStatus=="3"){
	        		msg = "该指令/建议交易员已填单，确定要继续修改吗？";
	        	}else if(processStatus=="4"){
	        		msg = "该指令/建议交易已发送，确定要继续修改吗？";
	        	}else if(processStatus=="5"){
	        		msg = "该指令/建议前台已成交，不能再修改，仅可以废弃";
	        	}else if(processStatus=="6"){
	        		msg = "该指令/建议后台已成交，不能再做任何操作";
	        	}
	        	
	        	//尚未确认的记录直接修改
	        	if(processStatus=="-2" || processStatus=="0" || processStatus=="1"){
	        		//提交数据
	        		submitDataCommon(json, urlStr, validStatusUrl);
	        	}else if(processStatus=="-1" || processStatus=="2" || processStatus=="3" || processStatus=="4"){
	        		nui.confirm(msg,"系统提示",function(action){
						if(action=="ok"){
							//提交数据
	        				submitDataCommon(json, urlStr, validStatusUrl);
						}
					});
	        	}else if(processStatus=="5" || processStatus=="6"){
	        		nui.alert(msg,"提示");
	        		return;
	        	}
			}
		});
    	
    //新增，直接添加记录	
    }else{
    	$.ajax({
			url:urlStr,
			type:'POST',
			data:json,
			cache:false,
			contentType:'text/json',
			success:function(text){
				
				nui.hideMessageBox(a);
				var returnJson = nui.decode(text);
				if(returnJson.exception == null){
					nui.alert("保存成功","系统提示",function(action){
						if(action == "ok"){
							CloseWindows("ok");
						}
					});
				}else{
					nui.alert("保存失败", "系统提示", function(action){
						if(action == "ok" || action == "close"){
							//CloseWindow("saveFailed");
						}
					});
				}
			}
		});
    }
}

//关闭窗口----所有业务通用
function CloseWindow(action) {
    if (action == "close" && form.isChanged()) {
        if (confirm("数据被修改了，是否先保存？")) {
            saveData();
        }
    }
    window.parent.closeWindow();
}

//关闭窗口
function CloseWindows(action) {
    if (window.CloseOwnerWindow)
    return window.CloseOwnerWindow(action);
    else window.close();
}

//确定保存或更新----所有业务通用
function onOk() {
    saveData();
}

//取消----所有业务通用
function onCancel() {
    window.CloseOwnerWindow();
}

//选择产品时加载投资组合----所有业务通用
function changedCombProductCode(e){
	var combProductCode = nui.get("combProductCode").getValue();
	//获取combobox对象并设置其选择项为空
   	var vcCombiNo = nui.get("vcCombiNo");
	    vcCombiNo.setValue("");
	//设置url并加载
    var url = "com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getCombiNosByKeyUserId.biz.ext?productCodes=" + combProductCode;
    vcCombiNo.setUrl(url);
    //默认选中第一个选项
    vcCombiNo.select(0);
   
    //当默认选中第一条选项时设置当前选项的名称到组合名称
    nui.get("vcCombiName").setValue(nui.get("vcCombiNo").getText());
}

//选择组合时给组合名称设值
function setVcCombiName(e){
  nui.get("vcCombiName").setValue(nui.get("vcCombiNo").getText());
}
</script>
