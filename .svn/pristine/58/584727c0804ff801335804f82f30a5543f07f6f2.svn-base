function ChangeTraderName(e){
	nui.get(e.id).setValue(e.value.toUpperCase());
}
function vcCounterpartyCheck(e){
	if(!e.sender.text){
		e.errorText = "交易对手不能为空！";
        e.isValid = false;
        return;
	} 
	if(e.value.length > 30 || e.sender.text.length > 30){
		e.errorText = "交易对手不能超过30位！";
	 	e.isValid = false;
	}
}
//自动增加千分位
function setPriceFunCommon(cmpId){
	var oldVal = nui.get(cmpId).getValue();
	if(oldVal){
		//特殊验证，交易场所：[01-银行间;02-上交所固收平台;03-深交所综合协议平台|上交所大宗;]
    	var tradingPlaceVal = "01";//交易场所
    	var newVal = formatNumber(oldVal,4,1);
    	if(tradingPlaceVal=="02" || tradingPlaceVal=="03"){
    		newVal = formatNumber(oldVal,3,1);
    	}
		nui.get(cmpId).setValue(newVal);
	}
}
//检查输入债券是否在O32中存在
function checkO32Exist(parameter){
	var O32Exit = false;
	nui.ajax({
		url : "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.checkO32Stock.biz.ext",
		type : 'POST',
		data : {stockInfo:parameter},
		cache : false,
		async: false,
		contentType : 'text/json',
		success : function(e) {
			var returnJson = nui.decode(e);
			if(returnJson.exception == null){
				if(returnJson.count!="0"){
					O32Exit=true;
				}
			}
		}
	});
    return O32Exit;
}
//查询可用数量
function instructAvaileAmount(param,bonds){
	//param:businClass--业务类别\exdestination--市场\vcEntrustDirection--委托方向\vcInvestType--投资类型
	//bonds:vcCombiNo\vcStockCode\vcmarket
	nui.ajax({
		url : "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.getO32resultInfo.biz.ext",
		type : 'POST',
		data : {condition:param,bondBasicInfo:bonds},
		cache : false,
		contentType : 'text/json',
		success : function(e) {
			var returnJson = nui.decode(e);
			if(returnJson.exception == null){
				var bondInfo = returnJson.bondInfo;
				if(typeof(bondInfo.vcAvailablequantityT0) != "undefined" && typeof(bondInfo.vcAvailablequantityT1) != "undefined"){
					var vcAvailablequantityT0Temp = parseInt(bondInfo.vcAvailablequantityT0.replace(/,/g,''));
					var vcAvailablequantityT1Temp = parseInt(bondInfo.vcAvailablequantityT1.replace(/,/g,''));
					if(bondInfo.cLocalAvailable != null && bondInfo.cLocalAvailable == "0"){//不启用本地可用计算
						vcAvailablequantityT0Temp = parseInt(bondInfo.vcO32AvailablequantityT0.replace(/,/g,''));
						vcAvailablequantityT1Temp = parseInt(bondInfo.vcO32AvailablequantityT1.replace(/,/g,''));
					}
					if(nui.get("operatorType").getValue() == "1" && instructionInfo.cIsValid=="1"){//修改指令，原指令为有效状态
						var tradeQty = parseInt(0);
						if(instructionInfo.vcProcessStatus=="4" || instructionInfo.vcProcessStatus=="5"){//原指令已下到O32
							if(vcCombiCode==instructionInfo.vcCombiCode && instructionInfo.vcEntrustDirection=="4" && nui.get("vcStockCode").getValue()==instructionInfo.vcStockCode){//原指令与修改后的指令为同一组合同一债券
								tradeQty = parseInt(instructionInfo.enFaceAmount.replace(/,/g,''))*100;
							}
						}else{//原指令未到O32
							if(bondInfo.cLocalAvailable != null && bondInfo.cLocalAvailable == "0"){//不启用本地可用计算
								//获取同业务编号，指令记录流程已到O32的修改审核中的记录
								nui.ajax({
					        		data:{param:{lResultNo:instructionInfo.lResultNo,vcEntrustDirection:"4"}},
					        		async: false,
					        		url:"com.cjhxfund.ats.sm.comm.AvaiableDataManager.getO32UnderReviewInstruct.biz.ext",
					        		success:function(resp){
					        			var returnJson = nui.decode(resp);
										if(returnJson.exception == null){
											if(returnJson.updateCheckInstruct.length==1){
												var updateCheckInstruct = returnJson.updateCheckInstruct[0];
												if(updateCheckInstruct.VC_COMBI_CODE == vcCombiCode && nui.get("vcStockCode").getValue()==updateCheckInstruct.VC_STOCK_CODE){
													tradeQty = (updateCheckInstruct.EN_FACE_AMOUNT)*100;
												}
											}
										}
						            }
							    });
							}else{//启用本地可用计算
								if(vcCombiCode==instructionInfo.vcCombiCode && nui.get("vcStockCode").getValue()==instructionInfo.vcStockCode && instructionInfo.vcEntrustDirection=="4"){//卖出
									tradeQty = parseInt(instructionInfo.enFaceAmount.replace(/,/g,''))*100;
									//指令为预置指令(交易日与询价结果日期不等)且流程状态当前停留在下达到O32之前时，预置指令的回填使用改指令当前自动锁定的数量
									if(instructionInfo.lTradeDate != instructionInfo.lResultDate){
										//同步方法获取预置指令当前锁定数量
										var lockParam = {"lResultId": instructionInfo.lResultId,"vcCombiCode": instructionInfo.vcCombiCode,"vcStockCode":instructionInfo.vcStockCode,"vcMarket":instructionInfo.vcMarket,"lockSource":3};
										nui.ajax({
											url : "com.cjhxfund.ats.sm.comm.TBondLockInfoManager.getInstructOneBondLock.biz.ext",
											type : 'POST',
											data : {param:lockParam},
											cache : false,
											async: false,
											contentType : 'text/json',
											success : function(e) {
												var returnLockJson = nui.decode(e);
												tradeQty = returnLockJson.lockQty;
											}
										});
									}
								}
							}
						}
						vcAvailablequantityT0Temp=vcAvailablequantityT0Temp+tradeQty;
						vcAvailablequantityT1Temp=vcAvailablequantityT1Temp+tradeQty;
					}
					if(vcAvailablequantityT0Temp>0){
						vcAvailablequantityT0Temp=formatNumber(vcAvailablequantityT0Temp,0,1);
					}else{
						vcAvailablequantityT0Temp=0;
					}
					if(vcAvailablequantityT1Temp>0){
						vcAvailablequantityT1Temp=formatNumber(vcAvailablequantityT1Temp,0,1);
					}else{
						vcAvailablequantityT1Temp=0;
					}
					window.parent.setInfoValue("vcAvailablequantityT0",vcAvailablequantityT0Temp);
					window.parent.setInfoValue("vcAvailablequantityT1",vcAvailablequantityT1Temp);
				}
			}else{
				nui.alert("系统异常","系统提示");
			}
		}
	});
}
function showHoldingPage(pageName){
	nui.open({
		url:nui.context + "/transaction/investNew/HoldingPages/"+pageName,
			title:"选择债券", 
			width:1100,
			height:410,
			allowResize:false,
			onload:function(){
				var iframe = this.getIFrameEl();
				var vcProductCode = nui.get('vcProductCode');
				var vcCombiCode = nui.get('vcCombiCode');
				var searchField = {
					'vcProductCode':vcProductCode.getValue(),	
					'vcProductCodeText':vcProductCode.getText(),
					'vcCombiCode':vcCombiCode.getValue(),
					'vcCombiCodeText':vcCombiCode.getText()
				};
					iframe.contentWindow.SetSearchField(searchField);
				
			},
			ondestroy:function(action){
				
			}
	});	
}
function lDelistingVali(e){
	var date = DateUtil.toNumStr(e.value);
	if(!lDelistingDate){
		return;
	}
    var tempDay = DateUtil.toNumStr(lDelistingDate);
    if (date >= tempDay) {
        e.errorText = "结算日期不能大于摘牌日期！";
        e.isValid = false;
    }
}
//实现精确乘
function mul(a, b) {
    var c = 0,
        d = a.toString(),
        e = b.toString();
    try {
        c += d.split(".")[1].length;
    } catch (f) {
    }
    try {
        c += e.split(".")[1].length;
    } catch (f) {
    }
    return Number(d.replace(".", "")) * Number(e.replace(".", "")) / Math.pow(10, c);
}
//除法函数
function div(a, b) {
    var c, d, e = 0,
        f = 0;
    try {
        e = a.toString().split(".")[1].length;
    } catch (g) {
    }
    try {
        f = b.toString().split(".")[1].length;
    } catch (g) {
    }
    c = Number(a.toString().replace(".", ""));
    d = Number(b.toString().replace(".", ""));
    var fin = (c / d) * Math.pow(10, f - e);
    return fin;
}
//加法函数
function add(a, b) {
    var c, d, e;
    try {
        c = a.toString().split(".")[1].length;
    } catch (f) {
        c = 0;
    }
    try {
        d = b.toString().split(".")[1].length;
    } catch (f) {
        d = 0;
    }
    e = Math.pow(10, Math.max(c, d));
    return (a * e + b * e) / e;
}