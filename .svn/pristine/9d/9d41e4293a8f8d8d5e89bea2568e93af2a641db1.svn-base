<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<script type="text/javascript">

//行双击时弹出页面展示该指令/建议详细信息--债券买卖
function rowdblclickFun_common_ZQMM(jspUrl, title, width, height, e, grid_confirm, pageType, roleType) {
    var row = e.record;//行对象值
    if (row) {
    	nui.open({
            url: "<%=request.getContextPath()%>/ProductProcess/"+jspUrl,
            title: title,
            width: width,
            height: height,
            onload: function () {
                var iframe = this.getIFrameEl();
                var data = {pageType:pageType,roleType:roleType,record:{zhfwptjyzqmm:row}};
                //直接从页面获取，不用去后台获取
                iframe.contentWindow.setFormData(data);
            },
            ondestroy: function (action) {//弹出页面关闭前
            	if(action=="confirmSuccess"){//若是确认，则刷新页面
            		grid_confirm.reload();
            	}
	        }
        });
    }
}


//编辑--所有业务通用
function edit_common_ZQMM(jspUrl, title, width, height, grid, pageType, roleType) {
    var row = grid.getSelected();
    if (row) {
    	//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
    	var validStatus = row.validStatus;
    	if(validStatus=="1" || validStatus=="2" || validStatus=="4" ){
    		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
    		return;
    	}
    	
    	//“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
    	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
    	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
    	var processStatus = row.processStatus;
    	var msg = "";
    	
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
    		nui.open({
                url: "<%=request.getContextPath()%>/ProductProcess/"+jspUrl,
                title: title,
                width: width,
                height: height,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = {pageType:pageType,roleType:roleType,record:{zhfwptjyzqmm:row}};
                    //直接从页面获取，不用去后台获取
                    iframe.contentWindow.setFormData(data);
                },
                ondestroy: function (action) {
                    grid.reload();
                }
            });
        
    	}else if(processStatus=="-1" || processStatus=="2" || processStatus=="3" || processStatus=="4"){
    		nui.confirm(msg,"系统提示",function(action){
				if(action=="ok"){
					nui.open({
		                url: "<%=request.getContextPath()%>/ProductProcess/"+jspUrl,
		                title: title,
		                width: width,
		                height: height,
		                onload: function () {
		                    var iframe = this.getIFrameEl();
		                    var data = {pageType:pageType,roleType:roleType,record:{zhfwptjyzqmm:row}};
		                    //直接从页面获取，不用去后台获取
		                    iframe.contentWindow.setFormData(data);
		                },
		                ondestroy: function (action) {
		                    grid.reload();
		                }
		           });
				}
			});
    		
    	}else if(processStatus=="5" || processStatus=="6"){
    		nui.alert(msg,"提示");
    		return;
    	}
     } else {
		nui.alert("请选中一条记录","提示");
     }
}


//废弃--所有业务通用
function remove_common_ZQMM(grid_remove){
    var rows = grid_remove.getSelecteds();
    if(rows.length > 0){
    
    	//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
    	var validStatus = rows[0].validStatus;
    	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
    		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
    		return;
    	}
    	
    	var jsonStatus = nui.encode({zhfwptjyzqmm:{processId:rows[0].processId}});
    	$.ajax({
            url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.getProcessStatus_ZQMM.biz.ext",
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
	        	var msg = "";
	        	
	        	if(processStatus=="-1"){
	        		msg = "该指令/建议已补齐，确定要继续废弃吗？";
	        	}else if(processStatus=="-2" || processStatus=="0" || processStatus=="1"){
	        		msg = "确定废弃选中指令/建议？";
	        	}else if(processStatus=="2"){
	        		msg = "该指令/建议投资经理已下单，确定要继续废弃吗？";
	        	}else if(processStatus=="3"){
	        		msg = "该指令/建议交易员已填单，确定要继续废弃吗？";
	        	}else if(processStatus=="4"){
	        		msg = "该指令/建议交易已发送，确定要继续废弃吗？";
	        	}else if(processStatus=="5"){
	        		msg = "该指令/建议前台已成交，确定要继续废弃吗？";
	        	}else if(processStatus=="6"){
	        		nui.alert("该指令/建议后台已成交，不能再做任何操作","提示");
	        		return;
	        	}
		    
		        nui.confirm(msg,"系统提示",
		        function(action){
		            if(action=="ok"){
				        nui.prompt("请输入废弃原因：", "请输入",
				            function (action, value) {
				                if (action == "ok") {
				                    if(value==null || value==""){
				                    	nui.alert("请输入废弃原因再提交！");
				                    	return;
				                    }
				                    
				                    //提交之前再次实时查询指令/建议单有效状态，避免用户在操作界面停留时间太长导致界面数据状态与数据库不一致
					            	var jsonValidStatus = nui.encode({zhfwptjyzqmm:{processId:rows[0].processId}});
								  	$.ajax({
								          url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.getValidStatus_ZQMM.biz.ext",
								          type:'POST',
								          data:jsonValidStatus,
								          cache:false,
								          contentType:'text/json',
								          success:function(text){
								              var returnJsonValidStatus = nui.decode(text);
								              //交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
								              var returnValidStatus = returnJsonValidStatus.validStatus;
								              
								              //若指令/建议单有效，则继续执行
								              if(returnValidStatus=="0" || returnValidStatus=="3"){
								              	  //封装主键ID、指令/建议流程处理状态、废弃原因字段传输到后台处理
							                      var json = nui.encode({zhfwptjyzqmms:[{processId:rows[0].processId, processStatus:processStatus, abandonedReasons:value}]});
								                  grid_remove.loading("正在废弃中,请稍等...");
								                  $.ajax({
								                      url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_delete.biz.ext",
								                      type:'POST',
								                      data:json,
								                      cache: false,
								                      contentType:'text/json',
								                      success:function(text){
								                            var returnJson = nui.decode(text);
								                          	if(returnJson.rtnCode==0){
								                          	  var invalidStr = returnJson.invalidStr;//无效指令/建议单字符串
								                          	  var invalidCount = returnJson.invalidCount;//无效指令/建议单记录数
									                          var invalidFixStr = returnJson.invalidFixStr;//无效指令/建议单字符串（Fix错误信息）

									                          var msg = "废弃成功";
									                          var errorMsg = "";
								                          	  if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
									                        	  var tempInvalidStrArr = invalidStr.split(",");
									                        	  var tempInvalidFixStrArr = invalidFixStr.split("★");
									                        	  for(var i=0; i<tempInvalidStrArr.length; i++){
									                        		  errorMsg += "【"+tempInvalidStrArr[i]+"-"+tempInvalidFixStrArr[i]+"】</br>";
									                        	  }
									                        	  msg = "废弃失败 " + invalidCount + " 条</br>"+errorMsg;
									                          }
								                              grid_remove.reload();
								                              nui.alert(msg, "系统提示", function(action){
								                              });
								                          	}else{
								                          		grid_remove.unmask();
								                              nui.alert("废弃失败", "系统提示");
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
				            },
				            true
				        );
		            }
		         });
            }
        });
    }else{
        nui.alert("请选中一条记录！");
    }
}


//确认--所有业务通用
function confirm_common_ZQMM(grid_confirm){
    var rows = grid_confirm.getSelecteds();
    if(rows.length > 0){
    
		//有效无效验证开始...
		var validStr = "";//有效无效验证字符串
		for(var i=0; i<rows.length; i++){
			var record = rows[i];//产品记录
			var combProductName = record.combProductName;//产品名称
			var investProductNum = record.investProductNum;//编号
        	var validStatus = record.validStatus;//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
        	if(validStatus!="0"){
        		validStr += "、" + investProductNum + "-" + combProductName;
        	}
		}
		if(validStr!=null && validStr!="" && validStr.length>0){
			validStr = validStr.substr(1,validStr.length);
			var msg = "【"+validStr+"】</br>指令/建议已无效或退回，请先剔除";
			nui.alert(msg,"提示");
			return;
		}
		//有效无效验证结束!!!
		
		
		//权限验证开始...
		var confirmStr = "";//该阶段不能确认字符串
		var noPermissionStr = "";//无权限确认的记录
		for(var i=0; i<rows.length; i++){
			var record = rows[i];//产品记录
			var combProductName = record.combProductName;//产品名称
			var investProductNum = record.investProductNum;//编号
        	var processStatus = record.processStatus;//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
			var userIdRelaType07All = record.userIdRelaType07All!=null?record.userIdRelaType07All:"";//07-产品与投顾确认权限(全部人员)
        	var userIdRelaType07 = record.userIdRelaType07!=null?record.userIdRelaType07:"";//07-产品与投顾确认权限(过滤自己)
			var userIdRelaTypeA1 = record.userIdRelaTypeA1!=null?record.userIdRelaTypeA1:"";//A1-投顾录入确认可为同一人员
        	
        	//投顾只能确认“交易员填单指令/建议补齐完成”或“投资顾问录入完成”阶段状态的指令/建议
        	if(processStatus!="-1" && processStatus!="0"){
        		confirmStr += "、" + investProductNum + "-" + combProductName;
        	}
        	
        	//无权限确认的记录
        	var hasPermission = false;
			if(userIdRelaType07All!=null && userIdRelaType07All!=""){//设置了复核人员
				var userIdRelaType07Arr = userIdRelaType07.split(",");//默认过滤自己
				if(userIdRelaTypeA1!=null && userIdRelaTypeA1!=""){//可为同一人员
					userIdRelaType07Arr = userIdRelaType07All.split(",");
				}
				for(var j=0; j<userIdRelaType07Arr.length; j++){
					var userIdTemp = userIdRelaType07Arr[j];
					if(userIdTemp==userId){
						hasPermission = true;
						break;
					}
				}
			}else{
				hasPermission = true;
			}
			if(hasPermission!=true){
				noPermissionStr += "、" + investProductNum + "-" + combProductName;
			}
		}
		if(confirmStr!=null && confirmStr!="" && confirmStr.length>0){
			confirmStr = confirmStr.substr(1,confirmStr.length);
			var msg = "您只能确认“指令/建议已录入”或“指令/建议已补齐”阶段的指令/建议！</br>【"+confirmStr+"】</br>指令/建议不符合要求，请先剔除";
			nui.alert(msg,"提示");
			return;
		}
		if(noPermissionStr!=null && noPermissionStr!="" && noPermissionStr.length>0){
			noPermissionStr = noPermissionStr.substr(1,noPermissionStr.length);
			var msg = "【"+noPermissionStr+"】</br>指令/建议您没有权限确认，请先剔除";
			nui.alert(msg,"提示");
			return;
		}
		//权限验证结束!!!
		
		
		
		
		//封装主键ID字段传输到后台处理开始...
		var processIdArr = new Array();
		for(var i=0; i<rows.length; i++){
			var record = rows[i];//产品记录
			var processIdTemp = {processId: record.processId};//封装指令/建议单主键ID
			processIdArr.push(processIdTemp);
		}
		
		var msg = "确定要确认所选的 " + rows.length + " 条指令/建议吗？";
		nui.confirm(msg,"系统提示",function(action){
			if(action=="ok"){
                var json = nui.encode({zhfwptjyzqmms: processIdArr});
                grid_confirm.loading("正在确认中,请稍等...");
                $.ajax({
                    url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_confirm.biz.ext",
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
                        	var invalidFixStr = returnJson.invalidFixStr;//无效指令/建议单字符串（Fix错误信息）
                        	var validFixFailReason = returnJson.validFixFailReason;//有效指令/建议单字符串（反馈报文失败原因[警告信息等]）
                        	
                        	var msg = "";
                        	var failReasonMsg = "";
                        	var errorMsg = "";
                        	if(validCount!=null && validCount!="" && validCount!="0"){
                        		if(validFixFailReason!=null && validFixFailReason!=""){
                        			var tempValidStrArr = validStr.split(",");
	                        		var tempValidFixFailReasonArr = validFixFailReason.split("★");
	                        		for(var i=0; i<tempValidStrArr.length; i++){
	                        			failReasonMsg += "【"+tempValidStrArr[i]+"触发以下风控：</br>"+tempValidFixFailReasonArr[i]+"】</br>";
	                        		}
	                        		if(failReasonMsg!=null && (failReasonMsg.indexOf("申请指令/建议审批")!=-1 || failReasonMsg.indexOf("申请风险阀值")!=-1)){
	                        			failReasonMsg += "<span class='warn_red_bold'>请联系人工审批！</span></br>";
	                        		}
                        		}
                        		msg += "确认成功 " + validCount + " 条</br>"+failReasonMsg;
                        	}
                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
                        		var tempInvalidStrArr = invalidStr.split(",");
                        		var tempInvalidFixStrArr = invalidFixStr.split("★");
                        		for(var i=0; i<tempInvalidStrArr.length; i++){
                        			errorMsg += "【"+tempInvalidStrArr[i]+"-"+tempInvalidFixStrArr[i]+"】</br>";
                        		}
                        		msg += "确认失败 " + invalidCount + " 条</br>"+errorMsg;
                        	}
                            grid_confirm.reload();
                            nui.alert(msg, "系统提示", function(action){
                            });
                        }else{
                            grid_confirm.unmask();
                            nui.alert("确认失败", "系统提示");
                        }
                    }
                });
			}
		});
		//封装主键ID字段传输到后台处理结束!!!
    		
    }else{
        nui.alert("请先选中指令/建议！");
    }
}









//行双击时弹出页面展示该指令/建议详细信息--所有业务通用
function rowdblclickFun_common_confirm_ZQMM(jspUrl, title, width, height, e, grid_confirm, editJspUrl) {
    var row = e.record;//行对象值
    if (row) {
    	
    	var processStatus = row.processStatus;//指令/建议流程处理状态
    	var validStatus = row.validStatus;//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
    	//判断是否有修改权限开始...
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
		//判断是否有修改权限结束!!!
		
		//若是1.指令/建议询价阶段（processStatus=="-2"）;2.有效指令/建议;3.有权限修改;则直接打开编辑页面
		if(processStatus=="-2" && (validStatus=="0"||validStatus=="3") && hasPermission==true){
			nui.open({
                url: "<%=request.getContextPath()%>/ProductProcess/"+editJspUrl,
                title: title,
                width: width,
                height: height,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = {pageType:"edit",roleType:"JYY",record:{zhfwptjyzqmm:row}};
                    //直接从页面获取，不用去后台获取
                    iframe.contentWindow.setFormData(data);
                },
                ondestroy: function (action) {
                    grid_confirm.reload();
                }
            });
			
		//打开确认界面
		}else{
			nui.open({
                url: "<%=request.getContextPath()%>/ProductProcess/"+jspUrl,
                title: title,
                width: width,
                height: height,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = {pageType:"confirm",roleType:"JYY",record:{zhfwptjyzqmm:row}};
                    //直接从页面获取，不用去后台获取
                    iframe.contentWindow.setFormData(data);
                },
                ondestroy: function (action) {//弹出页面关闭前
                	if(action=="confirmSuccess"){//若是确认，则刷新页面
                		grid_confirm.reload();
                	}
		        }
            });
		}
    }
}


//编辑--所有业务通用
function edit_common_confirm_ZQMM(jspUrl, title, width, height, grid) {
    var row = grid.getSelected();
    if (row) {
    	//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
    	var validStatus = row.validStatus;
    	if(validStatus=="1" || validStatus=="2" || validStatus=="4" ){
    		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
    		return;
    	}
    	
    	//判断是否有修改权限开始...
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
    	
    	//“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
    	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
    	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
    	var processStatus = row.processStatus;
    	var msg = "";
    	
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
    		nui.open({
                url: "<%=request.getContextPath()%>/ProductProcess/"+jspUrl,
                title: title,
                width: width,
                height: height,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = {pageType:"edit",roleType:"JYY",record:{zhfwptjyzqmm:row}};
                    //直接从页面获取，不用去后台获取
                    iframe.contentWindow.setFormData(data);
                },
                ondestroy: function (action) {
                    grid.reload();
                }
            });
    		
    	}else if(processStatus=="-1" || processStatus=="0" || processStatus=="1" || processStatus=="2" || processStatus=="3" || processStatus=="4"){
    		nui.confirm(msg,"系统提示",function(action){
				if(action=="ok"){
					nui.open({
		                url: "<%=request.getContextPath()%>/ProductProcess/"+jspUrl,
		                title: title,
		                width: width,
		                height: height,
		                onload: function () {
		                    var iframe = this.getIFrameEl();
		                    var data = {pageType:"edit",roleType:"JYY",record:{zhfwptjyzqmm:row}};
		                    //直接从页面获取，不用去后台获取
		                    iframe.contentWindow.setFormData(data);
		                },
		                ondestroy: function (action) {
		                    grid.reload();
		                }
		           });
				}
			});
    	}else if(processStatus=="5" || processStatus=="6"){
    		nui.alert(msg,"提示");
    		return;
    	}
    	
     } else {
		nui.alert("请选中一条记录","提示");
     }
}


//确认--所有业务通用
function confirm_common_confirm_ZQMM(grid_confirm){
    var rows = grid_confirm.getSelecteds();
    if(rows.length > 0){
    
    	//确认记录等于1时
    	if(rows.length==1){
    		//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
        	var validStatus = rows[0].validStatus;
        	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
        		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
        		return;
        	}
        	if(validStatus=="3"){
        		nui.alert("该指令/建议已退回，您不能再确认","提示");
        		return;
        	}
        	
        	var jsonStatus = nui.encode({zhfwptjyzqmm:{processId:rows[0].processId}});
        	$.ajax({
                url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.getProcessStatus_ZQMM.biz.ext",
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
		        	}else if(processStatus=="1"){
		        		//若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
		        		var hasPermission = false;//是否有权限，默认无
						var userIdRelaType02 = rows[0].userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
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
		        	}else if(processStatus=="1"){
		        		msg = "该指令/建议现为确认完成阶段，确定要继续确认吗？";
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
			            	var jsonValidStatus = nui.encode({zhfwptjyzqmm:{processId:rows[0].processId}});
						  	$.ajax({
						          url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.getValidStatus_ZQMM.biz.ext",
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
						                    var json = nui.encode({zhfwptjyzqmms:[{processId:rows[0].processId, processStatus:processStatus}]});
							                grid_confirm.loading("正在确认中,请稍等...");
							                $.ajax({
							                    url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_confirm.biz.ext",
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
							                        	var invalidFixStr = returnJson.invalidFixStr;//无效指令/建议单字符串（Fix错误信息）
							                        	var validFixFailReason = returnJson.validFixFailReason;//有效指令/建议单字符串（反馈报文失败原因[警告信息等]）
							                        	
							                        	var msg = "";
							                        	var failReasonMsg = "";
							                        	var errorMsg = "";
							                        	if(validCount!=null && validCount!="" && validCount!="0"){
							                        		if(validFixFailReason!=null && validFixFailReason!=""){
							                        			var tempValidStrArr = validStr.split(",");
								                        		var tempValidFixFailReasonArr = validFixFailReason.split("★");
								                        		for(var i=0; i<tempValidStrArr.length; i++){
								                        			failReasonMsg += "【"+tempValidStrArr[i]+"触发以下风控：</br>"+tempValidFixFailReasonArr[i]+"】</br>";
								                        		}
								                        		if(failReasonMsg!=null && (failReasonMsg.indexOf("申请指令/建议审批")!=-1 || failReasonMsg.indexOf("申请风险阀值")!=-1)){
								                        			failReasonMsg += "<span class='warn_red_bold'>请联系人工审批！</span></br>";
								                        		}
							                        		}
							                        		msg += "确认成功 " + validCount + " 条</br>"+failReasonMsg;
							                        	}
							                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
							                        		var tempInvalidStrArr = invalidStr.split(",");
							                        		var tempInvalidFixStrArr = invalidFixStr.split("★");
							                        		for(var i=0; i<tempInvalidStrArr.length; i++){
							                        			errorMsg += "【"+tempInvalidStrArr[i]+"-"+tempInvalidFixStrArr[i]+"】</br>";
							                        		}
							                        		msg += "确认失败 " + invalidCount + " 条</br>"+errorMsg;
							                        	}
							                            grid_confirm.reload();
							                            nui.alert(msg, "系统提示", function(action){
							                            });
							                        }else{
						                                grid_confirm.unmask();
						                                nui.alert("确认失败", "系统提示");
							                        }
							                    }
							                });
						              }else if(returnValidStatus=="3"){
						              	  grid_confirm.reload();
										  nui.alert("该指令/建议已退回，您不能再确认","提示");
										  return;
						              }else{
						              	  grid_confirm.reload();
										  nui.alert("该指令/建议已无效，不能再做任何操作","提示");
        								  return;
						              }
						          }
						      });
			             }
			        });
                }
            });
    	
    	//确认记录大于1时
    	}else{
    		
    		//有效无效验证开始...
    		var validStr = "";//有效无效验证字符串
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];//产品记录
    			var combProductName = record.combProductName;//产品名称
    			var investProductNum = record.investProductNum;//编号
	        	var validStatus = record.validStatus;//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
	        	if(validStatus!="0"){
	        		validStr += "、" + investProductNum + "-" + combProductName;
	        	}
    		}
    		if(validStr!=null && validStr!="" && validStr.length>0){
    			validStr = validStr.substr(1,validStr.length);
    			var msg = "【"+validStr+"】</br>指令/建议已无效或退回，请先剔除";
    			nui.alert(msg,"提示");
    			return;
    		}
    		//有效无效验证结束!!!
    		
    		
    		//权限验证开始...
    		var permissionStr = "";//权限验证字符串
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];//产品记录
    			var combProductName = record.combProductName;//产品名称
    			var investProductNum = record.investProductNum;//编号
	        	var processStatus = record.processStatus;//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
	        	
	        	//投顾尚未确认
	        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
	        		permissionStr += "、" + investProductNum + "-" + combProductName;
	        	
	        	//投资经理下单操作权限认证
	        	}else if(processStatus=="1"){
	        		//若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
	        		var hasPermission = false;//是否有权限，默认无
					var userIdRelaType02 = record.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
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
					if(hasPermission==false){
						permissionStr += "、" + investProductNum + "-" + combProductName;
					}
					
				//交易确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
	        	}else if(processStatus=="2" || processStatus=="3" || processStatus=="4"){
	        		var hasPermission = false;//是否有权限，默认无
					if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
						var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
						for(var j=0; j<tradingConfirmAuthorityUserIdsArr.length; j++){
							var userIdTemp = tradingConfirmAuthorityUserIdsArr[j];
							if(userIdTemp==userId){
								hasPermission = true;
								break;
							}
						}
					}
					if(hasPermission==false){
						permissionStr += "、" + investProductNum + "-" + combProductName;
					}
	        	
	        	//后台已成交确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
	        	}else if(processStatus=="5"){
	        		var hasPermission = false;//是否有权限，默认无
					if(backstageConfirmAuthorityUserIds!=null && backstageConfirmAuthorityUserIds!=""){
						var backstageConfirmAuthorityUserIdsArr = backstageConfirmAuthorityUserIds.split(",");
						for(var j=0; j<backstageConfirmAuthorityUserIdsArr.length; j++){
							var userIdTemp = backstageConfirmAuthorityUserIdsArr[j];
							if(userIdTemp==userId){
								hasPermission = true;
								break;
							}
						}
					}
					if(hasPermission==false){
						permissionStr += "、" + investProductNum + "-" + combProductName;
					}
	        	}
    		}
    		if(permissionStr!=null && permissionStr!="" && permissionStr.length>0){
    			permissionStr = permissionStr.substr(1,permissionStr.length);
    			var msg = "您没有权限确认【"+permissionStr+"】指令/建议，请先剔除";
    			nui.alert(msg,"提示");
    			return;
    		}
    		//权限验证结束!!!
    		
    		
    		
    		
    		//封装主键ID字段传输到后台处理开始...
    		var processIdArr = new Array();
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];//产品记录
    			var processIdTemp = {processId: record.processId};//封装指令/建议单主键ID
    			processIdArr.push(processIdTemp);
    		}
    		
    		var msg = "确定要确认所选的 " + rows.length + " 条指令/建议吗？";
    		nui.confirm(msg,"系统提示",function(action){
				if(action=="ok"){
	                var json = nui.encode({zhfwptjyzqmms: processIdArr});
	                grid_confirm.loading("正在确认中,请稍等...");
	                $.ajax({
	                    url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_confirm.biz.ext",
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
	                        	var invalidFixStr = returnJson.invalidFixStr;//无效指令/建议单字符串（Fix错误信息）
	                        	var validFixFailReason = returnJson.validFixFailReason;//有效指令/建议单字符串（反馈报文失败原因[警告信息等]）
	                        	
	                        	var msg = "";
	                        	var failReasonMsg = "";
	                        	var errorMsg = "";
	                        	if(validCount!=null && validCount!="" && validCount!="0"){
	                        		if(validFixFailReason!=null && validFixFailReason!=""){
	                        			var tempValidStrArr = validStr.split(",");
		                        		var tempValidFixFailReasonArr = validFixFailReason.split("★");
		                        		for(var i=0; i<tempValidStrArr.length; i++){
		                        			failReasonMsg += "【"+tempValidStrArr[i]+"触发以下风控：</br>"+tempValidFixFailReasonArr[i]+"】</br>";
		                        		}
		                        		if(failReasonMsg!=null && (failReasonMsg.indexOf("申请指令/建议审批")!=-1 || failReasonMsg.indexOf("申请风险阀值")!=-1)){
		                        			failReasonMsg += "<span class='warn_red_bold'>请联系人工审批！</span></br>";
		                        		}
	                        		}
	                        		msg += "确认成功 " + validCount + " 条</br>"+failReasonMsg;
	                        	}
	                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
	                        		var tempInvalidStrArr = invalidStr.split(",");
	                        		var tempInvalidFixStrArr = invalidFixStr.split("★");
	                        		for(var i=0; i<tempInvalidStrArr.length; i++){
	                        			errorMsg += "【"+tempInvalidStrArr[i]+"-"+tempInvalidFixStrArr[i]+"】</br>";
	                        		}
	                        		msg += "确认失败 " + invalidCount + " 条</br>"+errorMsg;
	                        	}
	                            grid_confirm.reload();
	                            nui.alert(msg, "系统提示", function(action){
	                            });
	                        }else{
	                            grid_confirm.unmask();
	                            nui.alert("确认失败", "系统提示");
	                        }
	                    }
	                });
				}
			});
    		//封装主键ID字段传输到后台处理结束!!!
    		
    	}
    }else{
        nui.alert("请先选中指令/建议！");
    }
}


//退回--所有业务通用
function goBack_common_confirm_ZQMM(grid_goBack){
    var rows = grid_goBack.getSelecteds();
    if(rows.length > 0){
    
		//有效无效验证开始...
		var validStr = "";//有效无效验证字符串
		for(var i=0; i<rows.length; i++){
			var record = rows[i];//产品记录
			var combProductName = record.combProductName;//产品名称
			var investProductNum = record.investProductNum;//编号
        	var validStatus = record.validStatus;//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
        	if(validStatus!="0"){
        		validStr += "、" + investProductNum + "-" + combProductName;
        	}
		}
		if(validStr!=null && validStr!="" && validStr.length>0){
			validStr = validStr.substr(1,validStr.length);
			var msg = "【"+validStr+"】</br>指令/建议已无效或退回，请先剔除";
			nui.alert(msg,"提示");
			return;
		}
		//有效无效验证结束!!!
		
		
		//权限验证开始...
		var goBackStr = "";//该阶段不能退回字符串
		var permissionStr = "";//权限验证字符串
		for(var i=0; i<rows.length; i++){
			var record = rows[i];//产品记录
			var combProductName = record.combProductName;//产品名称
			var investProductNum = record.investProductNum;//编号
        	var processStatus = record.processStatus;//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
        	
        	//投顾尚未确认
        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
        		goBackStr += "、" + investProductNum + "-" + combProductName;
        	
        	//投资经理下单操作权限认证
        	}else if(processStatus=="1"){
        		//若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
        		var hasPermission = false;//是否有权限，默认无
				var userIdRelaType02 = record.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
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
				if(hasPermission==false){
					permissionStr += "、" + investProductNum + "-" + combProductName;
				}
			//投资经理下单已确认
        	}else{
        		goBackStr += "、" + investProductNum + "-" + combProductName;
        	}
		}
		if(goBackStr!=null && goBackStr!="" && goBackStr.length>0){
			goBackStr = goBackStr.substr(1,goBackStr.length);
			var msg = "【"+goBackStr+"】</br>指令/建议尚未确认或投资经理已下单，请先剔除";
			nui.alert(msg,"提示");
			return;
		}
		if(permissionStr!=null && permissionStr!="" && permissionStr.length>0){
			permissionStr = permissionStr.substr(1,permissionStr.length);
			var msg = "您没有权限退回【"+permissionStr+"】指令/建议，请先剔除";
			nui.alert(msg,"提示");
			return;
		}
		//权限验证结束!!!
		
		
		
		
		//封装主键ID字段传输到后台处理开始...
		var processIdArr = new Array();
		for(var i=0; i<rows.length; i++){
			var record = rows[i];//产品记录
			var processIdTemp = {processId: record.processId};//封装指令/建议单主键ID
			processIdArr.push(processIdTemp);
		}
		
		var msg = "确定要退回所选的 " + rows.length + " 条指令/建议吗？";
		nui.confirm(msg,"系统提示",function(action){
			if(action=="ok"){
                var json = nui.encode({zhfwptjyzqmms: processIdArr, validStatus: "3"});
                grid_goBack.loading("正在退回中,请稍等...");
                $.ajax({
                    url:"com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_updateValidStatus.biz.ext",
                    type:'POST',
                    data:json,
                    cache: false,
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                            grid_goBack.reload();
                            nui.alert("退回成功", "系统提示", function(action){
                            });
                        }else{
                            grid_goBack.unmask();
                            nui.alert("退回失败", "系统提示");
                        }
                    }
                });
			}
		});
		//封装主键ID字段传输到后台处理结束!!!
    		
    }else{
        nui.alert("请先选中指令/建议！");
    }
}



</script>
