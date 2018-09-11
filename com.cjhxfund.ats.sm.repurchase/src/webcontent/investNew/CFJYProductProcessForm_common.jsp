<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<script type="text/javascript">

//提交数据----所有业务通用
function submitDataCommon(json, urlStr, validStatusUrl){
	//提交之前再次实时查询指令/建议单有效状态，避免用户在操作界面停留时间太长导致界面数据状态与数据库不一致
	validStatusUrl = validStatusUrl==null||validStatusUrl==""?"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getValidStatus.biz.ext":validStatusUrl;
  	$.ajax({
          url:validStatusUrl,
          type:'POST',
          data:json,
          cache:false,
          contentType:'text/json',
          success:function(text){
              var returnJsonValidStatus = nui.decode(text);
              //交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
              var returnValidStatus = returnJsonValidStatus.validStatus;
              
              //若指令/建议单有效，则继续执行
              if(returnValidStatus=="0" || returnValidStatus=="3"){
              	  	$.ajax({
						url:urlStr,
						type:'POST',
						data:json,
						cache:false,
						contentType:'text/json',
						success:function(text){
							var returnJson = nui.decode(text);
							if(returnJson.exception == null){
								CloseWindow("saveSuccess");
							}else{
								nui.alert("保存失败", "系统提示", function(action){
									if(action == "ok" || action == "close"){
										//CloseWindow("saveFailed");
									}
								});
							}
						}
					});
              }else{
				  nui.alert("该指令/建议已无效，不能再做任何操作","提示");
				  return;
              }
         }
    });
}

//保存数据----所有业务通用
function saveDataCommon(form, pageType, urlStr, roleType, processStatusUrl, validStatusUrl){
	var data = form.getData(false,true);
    var json = nui.encode(data);

	//编辑，先查询该指令/建议流程处理状态，让编辑人员再次确认
	processStatusUrl = processStatusUrl==null||processStatusUrl==""?"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProcessStatus.biz.ext":processStatusUrl;
    if(pageType=="edit"){
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
    			
    			//交易员填单修改
    			if(roleType=="JYY"){
    				
    				//获取交易确认阶段权限人员名单，权限关系类型：01-产品与投资顾问权限；02-产品与投资经理下单权限；03-产品与交易员填单权限；04-产品与复核员[交易发送]权限；05-产品与前台已成交权限；06-产品与后台已成交员权限；98-后台已成交确认阶段权限；99-交易确认阶段权限；
			    	$.ajax({
			            url:"com.cjhxfund.commonUtil.ProductManager.getTradingConfirmAuthority.biz.ext",
			            type:'POST',
			            data:null,
			            cache:false,
			            contentType:'text/json',
			            success:function(text){
			                var returnJson = nui.decode(text);
			                if(returnJson.exception == null){
			                	//判断是否有修改权限开始...
			                	var tradingConfirmAuthorityUserIds = returnJson.userIds99;//交易确认阶段权限人员名单字符串
			                	var hasPermission = false;//是否有权限，默认无
								if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
									var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
									for(var i=0; i<tradingConfirmAuthorityUserIdsArr.length; i++){
										var userIdTemp = tradingConfirmAuthorityUserIdsArr[i];
										if(userIdTemp==userId){
											hasPermission = true;
											break;
										}
									}
								}
								if(hasPermission==false){
									nui.alert("您没有权限修改该指令/建议","提示");
		    						return;
								}
								//判断是否有修改权限结束!!!
								
								
								if(processStatus=="-2"){
					        	}else if(processStatus=="-1"){
					        		msg = "该指令/建议已补齐，确定要继续修改吗？";
					        	}else if(processStatus=="0"){
					        		msg = "该指令/建议已录入，确定要继续修改吗？";
					        	}else if(processStatus=="1"){
					        		msg = "该指令/建议已确认，确定要继续修改吗？";
					        	}else if(processStatus=="2"){
					        		msg = "该指令/建议投资经理已下单，确定要继续修改吗？";
					        	}else if(processStatus=="3"){
					        		msg = "该指令/建议交易员已填单，确定要继续修改吗？";
					        	}else if(processStatus=="4"){
					        		msg = "该指令/建议交易已发送，确定要继续修改吗？";
					        	}else if(processStatus=="5"){
					        		msg = "该指令/建议前台已成交，您不能再修改";
					        	}else if(processStatus=="6"){
					        		msg = "该指令/建议后台已成交，不能再做任何操作";
					        	}
					        	//“-2-指令/建议询价录入完成”阶段的记录直接修改
					        	if(processStatus=="-2"){
					        		//提交数据
					        		submitDataCommon(json, urlStr, validStatusUrl);
					        	}else if(processStatus=="-1" || processStatus=="0" || processStatus=="1" || processStatus=="2" || processStatus=="3" || processStatus=="4"){
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
			                	
			                }else{
			                    nui.alert("权限人员名单获取失败", "系统提示");
			                }
			            }
			        });
    			
    			//投顾修改
    			}else{
    				
    				if(processStatus=="-2"){
		        	}else if(processStatus=="-1"){
		        		msg = "该指令/建议已补齐，确定要继续修改吗？";
		        	}else if(processStatus=="0" || processStatus=="1"){
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
				var returnJson = nui.decode(text);
				if(returnJson.exception == null){
					CloseWindow("saveSuccess");
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

//确定保存或更新----所有业务通用
function onOk() {
    saveData();
}

//取消----所有业务通用
function onCancel() {
    CloseWindow("cancel");
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
