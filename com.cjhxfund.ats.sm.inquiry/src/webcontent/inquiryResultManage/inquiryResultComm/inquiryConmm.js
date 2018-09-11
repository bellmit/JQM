/**
 * 描述：质押式、买断式、协议式回购主页面公共js
 */
nui.parse();

/* ******************************************
 * 全局变量 start
 ********************************************/



/* ******************************************
 * 全局变量 end
 ********************************************/



/* ******************************************
 * 公共工具方法 start
 ********************************************/
//获取查询条件的产品名称
function ButtonClickGetFundName_inquiryResult(e){
    ButtonClickGetFundName(this);
}
//跨页多选选择表格获取产品
function ButtonClickGetFundName(buttonEditObj){
    nui.open({
        url: nui.context+"/sm/comm/instruct/productInfoCombi.jsp",
        title: "产品列表",
        width: 450,
        height: 380,
        onload:function(){
        	
            var iframe = this.getIFrameEl();
            var fundCodes = buttonEditObj.getValue();
            var fundNames = buttonEditObj.getText();
            var data = {
               fundCodes:fundCodes,
               fundNames:fundNames
            };
            iframe.contentWindow.SetData(data);
        },
        ondestroy: function (action) {
        	
            if (action == "ok") {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.GetData();
                data = nui.clone(data);
                buttonEditObj.setValue(data.vcProductCode);
                buttonEditObj.setText(data.vcProductName);
            }
        }
    });
}

//多选数据分割为可in查询的字符串
function splitString(data){
	var string = null;
	if(data != null && data != ""){
		var strs= data.split(",");
		if(strs.length>0){
			for(var i=0; i<strs.length; i++ ){ 
				if(i == 0){
					string = "'"+strs[i]+"'";
				}else{
					string += ",'"+strs[i]+"'";
				}
			} 
		}
	}
	return string;
}
//指令/建议状态列字典翻译
function renderInstructStatus(e){
	return nui.getDictText("instructStatus",e.row.cIsValid);
}

//业务类别列字典翻译
function renderBizType(e){
	return nui.getDictText("bizTypeAll",e.row.vcBizType);
}

//委托方向列字典翻译(回购)
function renderEntrustDirection(e){
	return nui.getDictText("entrustDirectionRepurchase",e.row.vcEntrustDirection);
}

//委托方向列字典翻译(买卖)
function renderEntrustDirectionZqmm(e){
	return nui.getDictText("entrustDirectionTransaction",e.row.vcEntrustDirection);
}

//交易市场列字典翻译
function renderMarket(e){
	return nui.getDictText("tradePlace",e.row.vcMarket);
}

//清算速度列字典翻译
function renderSettleSpeed(e){
	return nui.getDictText("settleSpeed",e.row.vcSettleSpeed);
}

//报价方式列字典翻译
function renderQuoteMode(e){
	return nui.getDictText("quoteMode",e.row.vcQuoteMode);
}

//询价结果录入时间显示处理
function resultRenderReview(e){
	if(e.row.vcResultInputerName!=null || e.row.tResultInputTime!=null){
		return (e.row.vcResultInputerName==null?"":e.row.vcResultInputerName) + "　" + nui.formatDate(e.row.tResultInputTime, "yyyy-MM-dd HH:mm:ss");
	}else{
		return "";
	}
}
//投资经理确认时间处理
function sendRenderReview(e){
	if(e.row.vcFsSenderName!=null || e.row.tFsSendTime!=null){
		return (e.row.vcFsSenderName==null?"":e.row.vcFsSenderName) + "　" + nui.formatDate(e.row.tFsSendTime, "yyyy-MM-dd HH:mm:ss");
	}else{
		return "";
	}
}

//录单确认时间处理
function operateRenderReview(e){
	if(e.row.vcFsOperatorName!=null && e.row.tFsOperateTime!=null){
		return (e.row.vcFsOperatorName==null?"":e.row.vcFsOperatorName) + "　" + nui.formatDate(e.row.tFsOperateTime, "yyyy-MM-dd HH:mm:ss");
	}else{
		return "";
	}
}

//录单复核时间处理
function checkRenderReview(e){
	if(e.row.vcFsCheckerName!=null && e.row.tFsCheckTime!=null){
		return (e.row.vcFsCheckerName==null?"":e.row.vcFsCheckerName) + "　" + nui.formatDate(e.row.tFsCheckTime, "yyyy-MM-dd HH:mm:ss");
	}else{
		return "";
	}
}

//fix发送状态
function fixValidStatusRenderReview(e){
	if(e.value == null || e.value == "0"){
		return "未发送";
	}else if(e.value == "1"){
		return "不启用";
	}else if(e.value == "2"){
		return "发送中";
	}else if(e.value == "3"){
		return "发送成功";
	}else if(e.value == "4"){
		return "发送失败";
	}
	//return nui.getDictText("fixValidStatus",e.row.lFixValidStatus);
}

//翻译后台成交状态字典
function bsDealRenderReview(e){
	return nui.getDictText("bsSetmtStatus",e.row.vcBsDealStatus);
}

//下拉框清除按钮功能
function onCloseClick(e){
	var obj = e.sender;
    obj.setText("");
    obj.setValue("");
}

//自动刷新功能处理
function autoRefreshFun(){
	autoSearch();//同时刷新查询列表数据
	var autoRefreshVal = nui.get("autoRefresh").getValue();//获取最新自动刷新时间
	//若最新获取的自动刷新时间与历史自动刷新时间不等，则关闭之前的定时器，以新的自动刷新时间新建定时器，并将新值赋予历史自动刷新时间变量
	if(autoRefreshVal!=autoRefreshValOld){
		autoRefreshValOld = autoRefreshVal;//将新值赋予历史自动刷新时间变量
		clearInterval(autoRefreshReturnVal);//关闭之前的定时器
		if(autoRefreshValOld!="0"){
			autoRefreshReturnVal = setInterval("autoRefreshFun()", eval(autoRefreshValOld)*1000);//以新的自动刷新时间新建定时器
		}
	}
}

/* ******************************************
 * 公共业务方法 end
 ********************************************/

//退回
function backTasks(){
	var rows = todays_instruct_grid.getSelecteds();
	var row = todays_instruct_grid.getSelected();
	if(rows.length!=1){
		nui.alert("请选择一条指令退回","提示");
		return;
	}
	nui.open({
		url : nui.context + "/inquiry/inquiryResultManage/inquiryInstructBackReason.jsp",
		title : "询价退回",
		width : 500,
		height : 200,
		onload : function() {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setData(row);
		},
		ondestroy : function(action) {
			var iframe = this.getIFrameEl();
            //获取选中、编辑的结果
            var returnJson = iframe.contentWindow.getData();
            if(returnJson!= null){
            	returnJson = mini.clone(returnJson);    //必须。克隆数据。
            	resultMsg(returnJson);
			}else{
            	if(action == "ok"){
					search();
            	}
            }
		}
	});
}
//提示消息处理
function resultMsg(returnJson){
	if(returnJson.exception == null){
		if(returnJson.rtnCode == "0"){
    		var alsertMsg = "";
			if(returnJson.rtnMsg){
				alsertMsg = "</br>此单已退回！</br>退回原因："+returnJson.rtnMsg;
			}
			nui.alert("操作成功！"+alsertMsg,"系统提示",function(action){
    			if(action == "ok"){
    				search();
    			}
			});
		}else if(returnJson.rtnCode == "-1"){
			nui.alert("审批失败</br>"+returnJson.rtnMsg,"系统提示",function(action){
				if(action == "ok"){
					search();
    			}
			});
			
		}else if(returnJson.rtnCode == "0200"){
			nui.alert("审批成功"+"</br>"+returnJson.rtnMsg,"系统提示",function(action){
    			if(action == "ok"){
    				search();
    			}
			}); 
		}else if(returnJson.rtnCode == "0301"){
			nui.alert("审批失败,触发禁止风控,风控信息如下：</br>"+returnJson.rtnMsg,"系统提示",function(action){
    			if(action == "ok"){
    				search();
    			}
			});
		}else if(returnJson.rtnCode == "0202"){
			nui.alert("审批失败</br>"+returnJson.rtnMsg,"系统提示",function(action){
    			if(action == "ok"){
    				search();
    			}
			});
		}else{
			nui.alert("操作异常","系统提示");
		}
	}else{
		nui.alert("系统异常","系统提示");
	}
}