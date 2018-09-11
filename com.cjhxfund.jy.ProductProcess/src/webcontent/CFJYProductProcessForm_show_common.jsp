<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<script type="text/javascript">
	//关闭窗口
	function CloseWindow(action) {
	    if (action == "close" && form.isChanged()) {
	        if (confirm("数据被修改了，是否先保存？")) {
	            saveData();
	        }
	    }
	    if (window.CloseOwnerWindow)
	    return window.CloseOwnerWindow(action);
	    else window.close();
	}
	
	//执行确认
	function onOk() {
	
		//如果是点击确认类型页面（投资经理下单、交易员填单）
	    if (rowPageType == "confirm") {
	    	//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
        	var validStatus = rowRecord.validStatus;
        	//获取执行备注信息
        	var earlyWithdrawalClause = "";
        	if(nui.get("earlyWithdrawalClause")!=null){
        		earlyWithdrawalClause = nui.get("earlyWithdrawalClause").getValue();
        	}
        	
        	
        	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
        		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
        		return;
        	}
        	if(validStatus=="3"){
        		nui.alert("该指令/建议已退回，您不能再确认","提示");
        		return;
        	}
        	
        	var jsonStatus = nui.encode({cfjyproductprocess:{processId:rowRecord.processId}});
        	$.ajax({
                url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProcessStatus.biz.ext",
                type:'POST',
                data:jsonStatus,
                cache:false,
                contentType:'text/json',
                success:function(text){
                    var returnJsonStatus = nui.decode(text);
                    
                    //“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
		        	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
		        	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
		        	var processStatus = returnJsonStatus.processStatus;
		        	
		        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
		        		nui.alert("该指令/建议尚未确认，您还不能处理","提示");
        				return;
		        	//投资经理下单操作权限认证
		        	}else if(processStatus=="7"||processStatus=="1"){
		        		
		        	    if(processStatus=="1"&&rowRecord.processType=="99"){//其它投资，复核节点
		        	    	var userIdRelaTypeA3 = rowRecord.userIdRelaTypeA3;//该指令/建议单拥有投资经理下单权限的用户ID字符串
		        	    	if(userIdRelaTypeA3!=null && userIdRelaTypeA3!=""){
		        	    		nui.alert("该指令/建议尚未确认，您还不能处理","提示");
        				    	return;
		        	    	}else{
		        	    		var hasPermission = false;//是否有权限，默认无
								var userIdRelaType02 = rowRecord.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
								if(userIdRelaType02!=null && userIdRelaType02!=""){
									var userIdRelaType02Arr = userIdRelaType02.split(",");
									for(var i=0; i<userIdRelaType02Arr.length; i++){
										var userIdTemp = userIdRelaType02Arr[i];
										if(userIdTemp==userId){
											hasPermission = true;
											break;
										}
									}
								}
								if(hasPermission==false){
									nui.alert("您没有权限确认该指令/建议","提示");
		    						return;
								}
		        	    	}
		        	        
		        	    }else{//投资经理下单操作权限认证
			        	    //若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
			        		var hasPermission = false;//是否有权限，默认无
							var userIdRelaType02 = rowRecord.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
							if(userIdRelaType02!=null && userIdRelaType02!=""){
								var userIdRelaType02Arr = userIdRelaType02.split(",");
								for(var i=0; i<userIdRelaType02Arr.length; i++){
									var userIdTemp = userIdRelaType02Arr[i];
									if(userIdTemp==userId){
										hasPermission = true;
										break;
									}
								}
							}
							if(hasPermission==false){
								nui.alert("您没有权限确认该指令/建议","提示");
	    						return;
							}
		        	    }
					//交易确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
		        	}else if(processStatus=="2" || processStatus=="3" || processStatus=="4"){
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
							nui.alert("您没有权限确认该指令/建议","提示");
    						return;
						}
		        	
		        	//后台已成交确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
		        	}else if(processStatus=="5"){
		        		var hasPermission = false;//是否有权限，默认无
						if(backstageConfirmAuthorityUserIds!=null && backstageConfirmAuthorityUserIds!=""){
							var backstageConfirmAuthorityUserIdsArr = backstageConfirmAuthorityUserIds.split(",");
							for(var i=0; i<backstageConfirmAuthorityUserIdsArr.length; i++){
								var userIdTemp = backstageConfirmAuthorityUserIdsArr[i];
								if(userIdTemp==userId){
									hasPermission = true;
									break;
								}
							}
						}
						if(hasPermission==false){
							nui.alert("您没有权限确认该指令/建议","提示");
    						return;
						}
		        	}		        	
		        	
		        	var msg = "";
		        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
		        		nui.alert("该指令/建议尚未确认，您还不能处理","提示");
        				return;
		        	}else if(processStatus=="7"|| processStatus=="1"){
		        	    if(processStatus=="1"){
		        	        msg = "该指令/建议现为确认完成阶段，确定要继续确认吗？";
		        	    }else if(processStatus=="7"){
		        	        msg = "该指令/建议现为复核完成阶段，确定要继续确认吗？";
		        	    }
		        	}else if(processStatus=="2"){
		        		msg = "该指令/建议现为投资经理下单完成阶段，确定要继续确认吗？";
		        	}else if(processStatus=="3"){
		        		msg = "该指令/建议现为交易员填单完成阶段，确定要继续确认吗？";
		        	}else if(processStatus=="4"){
		        		msg = "该指令/建议现为交易已发送阶段，确定要继续确认吗？";
		        	}else if(processStatus=="5"){
		        		msg = "该指令/建议现为前台已成交阶段，确定要继续确认吗？";
		        	}else if(processStatus=="6"){
		        		nui.alert("该指令/建议后台已成交，不能再做任何操作","提示");
		        		return;
		        	}
			    
			        nui.confirm(msg,"系统提示",
			        function(action){
			            if(action=="ok"){
			            	
			            	//提交之前再次实时查询指令/建议单有效状态，避免用户在操作界面停留时间太长导致界面数据状态与数据库不一致
			            	var jsonValidStatus = nui.encode({cfjyproductprocess:{processId:rowRecord.processId}});
						  	$.ajax({
						          url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getValidStatus.biz.ext",
						          type:'POST',
						          data:jsonValidStatus,
						          cache:false,
						          contentType:'text/json',
						          success:function(text){
						              var returnJsonValidStatus = nui.decode(text);
						              //交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
						              var returnValidStatus = returnJsonValidStatus.validStatus;
						              
						              //若指令/建议单有效，则继续执行
						              if(returnValidStatus=="0"){
						              
						              	  	//封装主键ID、指令/建议流程处理状态字段传输到后台处理
						                    var json = nui.encode({cfjyproductprocesss:[{processId:rowRecord.processId, processStatus:processStatus,earlyWithdrawalClause:earlyWithdrawalClause}]});
							                $.ajax({
							                    url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.confirmCFJYProductProcesss.biz.ext",
							                    type:'POST',
							                    data:json,
							                    cache: false,
							                    contentType:'text/json',
							                    success:function(text){
							                        var returnJson = nui.decode(text);
							                        if(returnJson.exception == null){
							                        	var validStr = returnJson.validStr;//有效指令/建议单字符串
							                        	var invalidStr = returnJson.invalidStr;//无效指令/建议单字符串
							                        	var validCount = returnJson.validCount;//有效指令/建议单记录数
							                        	var invalidCount = returnJson.invalidCount;//无效指令/建议单记录数
							                        	var msg = "";
							                        	if(validCount!=null && validCount!="" && validCount!="0"){
							                        		msg = "确认成功 " + validCount + " 条";
							                        	}
							                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
							                        		if(msg!=null && msg!=""){
							                        			msg += "；";
							                        		}
							                        		msg += "确认失败 " + invalidCount + " 条，产品名称为【" + invalidStr + "】";
							                        	}
							                            nui.alert(msg, "系统提示", function(action){
							                            	CloseWindow("confirmSuccess");
							                            });
							                        }else{
						                                nui.alert("确认失败", "系统提示");
							                        }
							                    }
							                });
						              }else if(returnValidStatus=="3"){
						              	  nui.alert("该指令/建议已退回，您不能再确认","提示");
        								  return;
						              }else{
										  nui.alert("该指令/建议已无效，不能再做任何操作","提示");
        								  return;
						              }
						          }
						      });
			             }
			        });
                }
            });
	    	
	    //投顾处理
	    }else{
	    
	    	//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
        	var validStatus = rowRecord.validStatus;
        	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
        		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
        		return;
        	}
        	if(validStatus=="3"){
        		nui.alert("该指令/建议已退回，请先修改重新提交后再确认","提示");
        		return;
        	}
        	
        	var jsonStatus = nui.encode({cfjyproductprocess:{processId:rowRecord.processId}});
        	$.ajax({
                url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProcessStatus.biz.ext",
                type:'POST',
                data:jsonStatus,
                cache:false,
                contentType:'text/json',
                success:function(text){
                    var returnJsonStatus = nui.decode(text);
                    
                    //“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
		        	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
		        	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
		        	var processStatus = returnJsonStatus.processStatus;
		        	
		        	if(processStatus=="-2"){
		        		nui.alert("该指令/建议尚未补齐，您还不能处理","提示");
        				return;
		        	}else if(processStatus=="-1" || processStatus=="0"|| processStatus=="1"){
		        		
		        		var pUserId = rowRecord.inquiryId==null||rowRecord.inquiryId==""?rowRecord.investAdviserId:rowRecord.inquiryId;
		        		//获取该产品投顾复核权限人员名单
				    	$.ajax({
				            url:"com.cjhxfund.jy.ProductProcess.CFJYCombProductHandleBiz.getInvestAdviserConfirmId.biz.ext",
				            type:'POST',
				            data:nui.encode({combProductCode:rowRecord.combProductCode, vcCombiNo:rowRecord.vcCombiNo, userId:pUserId}),
				            cache:false,
				            contentType:'text/json',
				            success:function(text){
				                var returnJson = nui.decode(text);
				                if(returnJson.exception == null){
				                	var confirmUserIds = returnJson.confirmUserIds;
				                	var hasPermission = true;//是否有权限，默认有
				                	//返回值不为空，说明设置了复核人员
				                	if(confirmUserIds!=null && confirmUserIds!=""&&(processStatus=="-1" || processStatus=="0")){
				                		hasPermission = false;//设置为无权限
										var confirmUserIdsArr = confirmUserIds.split(",");
										for(var i=0; i<confirmUserIdsArr.length; i++){
											var userIdTemp = confirmUserIdsArr[i];
											if(userIdTemp==userId){
												hasPermission = true;
												break;
											}
										}
				                	}
				                	if(processStatus=="1"&&rowRecord.processType=="99"){//复核权限
						        	    hasPermission=false;
						        	    var userIdRelaTypeA3 = rowRecord.userIdRelaTypeA3;//该指令/建议单拥有投资经理下单权限的用户ID字符串
										if(userIdRelaTypeA3!=null && userIdRelaTypeA3!=""){
											var userIdRelaTypeA3Array=userIdRelaTypeA3.split(",");
											for(var loop=0;loop<userIdRelaTypeA3Array.length;loop++){
											    var userIdTemp = userIdRelaTypeA3Array[loop];
											    if(userIdTemp==userId){
													hasPermission = true;
													break;
												}
											}
										}
						        	}
									if(hasPermission==false){
										nui.alert("您没有权限确认该指令/建议","提示");
			    						return;
									}
				                	
				                	
				                	nui.confirm("确定要确认该指令/建议吗？","系统提示",function(action){
							            if(action=="ok"){
							            	
							            	//提交之前再次实时查询指令/建议单有效状态，避免用户在操作界面停留时间太长导致界面数据状态与数据库不一致
							            	var jsonValidStatus = nui.encode({cfjyproductprocess:{processId:rowRecord.processId}});
										  	$.ajax({
										          url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getValidStatus.biz.ext",
										          type:'POST',
										          data:jsonValidStatus,
										          cache:false,
										          contentType:'text/json',
										          success:function(text){
										              var returnJsonValidStatus = nui.decode(text);
										              //交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
										              var returnValidStatus = returnJsonValidStatus.validStatus;
										              
										              //若指令/建议单有效，则继续执行
										              if(returnValidStatus=="0"){
										              
										              	  	//封装主键ID、指令/建议流程处理状态字段传输到后台处理
										                    var json = nui.encode({cfjyproductprocesss:[{processId:rowRecord.processId, processStatus:processStatus,earlyWithdrawalClause:earlyWithdrawalClause}]});
											                $.ajax({
											                    url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.confirmCFJYProductProcesss.biz.ext",
											                    type:'POST',
											                    data:json,
											                    cache: false,
											                    contentType:'text/json',
											                    success:function(text){
											                        var returnJson = nui.decode(text);
											                        if(returnJson.exception == null){
											                        	var validStr = returnJson.validStr;//有效指令/建议单字符串
											                        	var invalidStr = returnJson.invalidStr;//无效指令/建议单字符串
											                        	var validCount = returnJson.validCount;//有效指令/建议单记录数
											                        	var invalidCount = returnJson.invalidCount;//无效指令/建议单记录数
											                        	var msg = "";
											                        	if(validCount!=null && validCount!="" && validCount!="0"){
											                        		msg = "确认成功 " + validCount + " 条";
											                        	}
											                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
											                        		if(msg!=null && msg!=""){
											                        			msg += "；";
											                        		}
											                        		msg += "确认失败 " + invalidCount + " 条，产品名称为【" + invalidStr + "】";
											                        	}
											                            nui.alert(msg, "系统提示", function(action){
											                            	CloseWindow("confirmSuccess");
											                            });
											                        }else{
										                                nui.alert("确认失败", "系统提示");
											                        }
											                    }
											                });
										              }else if(returnValidStatus=="3"){
										              	  nui.alert("该指令/建议已退回，请先修改重新提交后再确认","提示");
				        								  return;
										              }else{
														  nui.alert("该指令/建议已无效，不能再做任何操作","提示");
				        								  return;
										              }
										          }
										      });
							             }
							        });
				                	
				                }else{
				                    nui.alert("权限人员名单获取失败", "系统提示");
				                }
				            }
				        });
						
		        	}else{
		        		nui.alert("该指令/建议已确认","提示");
        				return;
		        	}
                }
            });
	    }
	}
	
	//退回
	function onGoBack(){
		
		//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
    	var validStatus = rowRecord.validStatus;
    	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
    		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
    		return;
    	}
    	if(validStatus=="3"){
    		nui.alert("该指令/建议已退回，请不要重复操作","提示");
    		return;
    	}
		
		var processStatus = rowRecord.processStatus;//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
		if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
			nui.alert("该指令/建议尚未确认，您还不能处理","提示");
    		return;
		
		//投资经理下单操作权限认证
		}else if(processStatus=="7"|| processStatus=="1"){
		
		    var hasPermission = false;//是否有权限，默认无
		    if(rowRecord.processType=="99"&&processStatus=="1"){//其它投资，复核节点
				var userIdRelaTypeA3 = rowRecord.userIdRelaTypeA3!=null?rowRecord.userIdRelaTypeA3:"";//A3-组合与委托人确认权限
				if(hasPermission == false&&userIdRelaTypeA3!=null&&userIdRelaTypeA3!=""){
				    var userIdRelaTypeA3Array=userIdRelaTypeA3.split(",");
				    for(var loop=0;loop<userIdRelaTypeA3Array.length;loop++){
				        var userIdTemp = userIdRelaTypeA3Array[loop];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
				    }
				    if(hasPermission==false){
						nui.alert("该指令/建议尚未复核，您还不能处理","提示");
	    		        return;
					}
				}else{//没有配置A3权限，判断投资经理权限
				    //若当前用户有权限处理该指令/建议单，则继续执行，否则返回
					var userIdRelaType02 = rowRecord.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
					if(userIdRelaType02!=null && userIdRelaType02!=""){
						var userIdRelaType02Arr = userIdRelaType02.split(",");
						for(var j=0; j<userIdRelaType02Arr.length; j++){
							var userIdTemp = userIdRelaType02Arr[j];
							if(userIdTemp==userId){
								hasPermission = true;
								break;
							}
						}
					}
				}
		    }else{
		         //若当前用户有权限处理该指令/建议单，则继续执行，否则返回
				var userIdRelaType02 = rowRecord.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
				if(userIdRelaType02!=null && userIdRelaType02!=""){
					var userIdRelaType02Arr = userIdRelaType02.split(",");
					for(var j=0; j<userIdRelaType02Arr.length; j++){
						var userIdTemp = userIdRelaType02Arr[j];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
				}
				
		    }
		    if(hasPermission==false){
					nui.alert("您没有权限退回该指令/建议","提示");
	    			return;
				}else{
					
					//封装主键ID字段传输到后台处理开始...
		    		var msg = "确定要退回该指令/建议吗？";
		    		nui.confirm(msg,"系统提示",function(action){
						if(action=="ok"){
			                var json = nui.encode({cfjyproductprocesss: [{processId: rowRecord.processId}], validStatus: "3"});
			                $.ajax({
			                    url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.updateValidStatus.biz.ext",
			                    type:'POST',
			                    data:json,
			                    cache: false,
			                    contentType:'text/json',
			                    success:function(text){
			                        var returnJson = nui.decode(text);
			                        if(returnJson.exception == null){
			                            nui.alert("退回成功", "系统提示", function(action){
			                            	CloseWindow("confirmSuccess");
			                            });
			                        }else{
			                            nui.alert("退回失败", "系统提示");
			                        }
			                    }
			                });
						}
					});
		    		//封装主键ID字段传输到后台处理结束!!!
				
				}
		}else{
			nui.alert("该指令/建议投资经理已下单，不能做退回操作","提示");
    		return;
		}
	}
	
	//取消
	function onCancel() {
	    CloseWindow("cancel");
	}
	
	//设置表单数据公共逻辑处理----所有业务通用
	function setFormDataCommon(form, json, infos){
		form.setData(json);
        form.setChanged(false);
	
	    //如果是点击确认类型页面（投资经理下单、交易员填单）
	    if (infos.pageType == "confirm") {
	    	//nui.get("confirm").enable();//将“确认”按钮设置为可用
	    	nui.get("goBack").enable();//将“退回”按钮设置为可用
	    	
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
	                	tradingConfirmAuthorityUserIds = returnJson.userIds99;//交易确认阶段权限人员名单字符串，确认时使用
	                	backstageConfirmAuthorityUserIds = returnJson.userIds98;//后台已成交阶段权限人员名单字符串，确认时使用
	                	//显示执行备注输入框
	                	document.getElementById('id').style.display ="";
	                }else{
	                    nui.alert("权限人员名单获取失败", "系统提示");
	                }
	            }
	        });
	    }
	}
</script>
