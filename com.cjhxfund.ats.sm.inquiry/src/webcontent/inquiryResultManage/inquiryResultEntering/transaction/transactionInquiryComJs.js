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

//债券基本信息查询
function appointBondInfo(bondDetailForm,vcStockCode,vcMarketNo){
	var parameter={vcStockCode:vcStockCode,vcMarketNo:vcMarketNo};
	nui.ajax({
		url:"com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.getAppointBondInfo.biz.ext",
		type : 'POST',
		data : {condition:parameter},
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if(returnJson.exception == null){
				var bondBasicInfo = null;
				var vcSpecialText = null;
				if(returnJson.bondBasicInfo.length>0){
					bondBasicInfo = returnJson.bondBasicInfo[0];
				}
				if(!bondBasicInfo){
					nui.get("vcStockName").setValue("");
					nui.get("vcInterCode").setValue("");
					bondDetails.setData("");           //设置多个控件数据
				}else{
					nui.get("vcStockName").setValue(bondBasicInfo.vcStockName);
					nui.get("vcInterCode").setValue(bondBasicInfo.vcInterCode);
					lLeftDays = bondBasicInfo.lEndincalDays; //距到期日天数
					bondDetails.setData(bondBasicInfo); //设置多个控件数据
					vcSpecialText = returnJson.bondBasicInfo[0].vcSpecialText;
				}
				sumFaceAmount = returnJson.sumFaceAmount;
				enBondAsset = returnJson.enBondAsset;
				calculatePercentage();//计算持仓占比和未成占比和指令占比
				
				if(vcSpecialText && (vcSpecialText.indexOf("回售条款")>=0 || vcSpecialText.indexOf("赎回条款")>=0)){
					$("#MaturityLab").html("<span>*</span>到期/行权收益率:");
					$("#enOptionYield").show();
					hasSellback = true;
				}else{
					$("#MaturityLab").html("<span>*</span>到期收益率:");
					$("#enOptionYield").hide();
					$("#MaturityLabSplit").hide();
					hasSellback = false;
				}
				//获取摘牌日期
				var lDelistingDateTemp = returnJson.bondBasicInfo[0].lDelistingDate;
				lDelistingDate = lDelistingDateTemp == null ? 
				null : DateUtil.DstrToDate(returnJson.bondBasicInfo[0].lDelistingDate);
			}
		}
	});
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
					var vcAvailablequantityT0Temp = parseInt(bondInfo.vcO32AvailablequantityT0.replace(/,/g,''));
					var vcAvailablequantityT1Temp = parseInt(bondInfo.vcO32AvailablequantityT0.replace(/,/g,''));
//					if(bondInfo.cLocalAvailable != null && bondInfo.cLocalAvailable == "0"){//不启用本地可用计算
//						vcAvailablequantityT0Temp = parseInt(bondInfo.vcAvailableQuantityInquiryT0.replace(/,/g,''));
//						vcAvailablequantityT1Temp = parseInt(bondInfo.vcAvailableQuantityInquiryT1.replace(/,/g,''));
//					}
					if(nui.get("operatorType").getValue() == "1" && instructionInfo.cIsValid=="0"){//修改指令，原指令为有效状态
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
		url:nui.context + "/inquiry/inquiryResultManage/inquiryResultEntering/transaction/inquiryInput_zqmm/HoldingPages/"+pageName,
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

function ChangeTraderName(e){
	nui.get(e.id).setValue(e.value.toUpperCase());
}

function vcCounterpartyCheck(e){
	if(!e.value){
		return;
	}
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

/**
*
*
**/
//债券基本信息查询
function appointBondInfo(formId,vcStockCode,vcMarketNo,recall){
	var parameter={vcStockCode:vcStockCode,vcMarketNo:vcMarketNo};
	var bondDetailForm = new nui.Form(formId);
	if(!vcStockCode){
		bondDetailForm.setData("");
		return;
	}
	nui.ajax({
		url:"com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.getAppointBondInfo.biz.ext",
		type : 'POST',
		data : {condition:parameter},
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if(returnJson.exception == null){
				
				var bondBasicInfo = null;
				if(returnJson.bondBasicInfo.length>0){
					bondBasicInfo = returnJson.bondBasicInfo[0];
				}
				if(!bondBasicInfo){
					bondDetailForm.setData("");           //设置多个控件数据
				}else{
					bondDetailForm.setData(bondBasicInfo); //设置多个控件数据
				}
				recall(bondBasicInfo,returnJson);
			}
		}
	});
}

function setInfoValue(id,value){
	nui.get(id).setValue(value);
}
function getInfoValue(id){
	return nui.get(id).getValue();
}
//计算持仓占比和未成占比和指令占比
function calculatePercentage(enNetPrice,enFaceAmount,enBondAsset,sumFaceAmount,recall){
	var enFundValue = nui.get("enFundValue").value;//净资产
	enFundValue = enFundValue.replace(/,/g,'');
	if(enFundValue && enNetPrice){
		var unachievedRatio = null;
		var instructRatio = null;
		var positionRatio = null;
		if(enFundValue <= 0){
			unachievedRatio = "0.0000";
			instructRatio = "0.0000";
			positionRatio = "0.0000";
		}else{
			//持仓占比:市值/净资产*100
			positionRatio = enBondAsset/enFundValue*100;
			positionRatio = formatNumber(positionRatio,4,1);
			//未成占比:当前债券代码所有没有成交的数量（券面金额元/100或万元*100）*指令净价/净资产*100
    		unachievedRatio = ((sumFaceAmount*100*enNetPrice)/enFundValue)*100;
    		unachievedRatio = formatNumber(unachievedRatio,4,1);
			//指令占比:当前指令金额( 数量 * 净价 或 （券面金额(万元) * 100）* 净价)/净资产*100
			instructRatio = enFaceAmount*100*enNetPrice/(enFundValue)*100;
			instructRatio = formatNumber(instructRatio,4,1);
		}
		//合计(占%) =持仓占%+未成占%+指令占%
		var totalRatio = add(positionRatio,unachievedRatio);
		totalRatio = add(totalRatio,instructRatio);
		
		nui.get("unachievedRatio").setValue(unachievedRatio);
		nui.get("instructRatio").setValue(instructRatio);
		nui.get("positionRatio").setValue(positionRatio);
		nui.get("totalRatio").setValue(formatNumber(totalRatio,4,0));
	}
	if(enFaceAmount){
		enFaceAmount = formatNumber(enFaceAmount,0,1);
		recall(enFaceAmount);
	}
}
//获取债券详细信息
function getBondInfo(){
	var bondDetails = new nui.Form("#bond_details");
	return bondDetails.getData(false, false);
}
function closewindow(e){
	window.CloseOwnerWindow(e);
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
//alert方法
function parentAlert(content,title,recall){
	nui.alert(content,title,function(){
		if(recall){
			recall();
		}
	});
}
function parentConfirm(content,title,recall){
	nui.confirm(content,title,function(action){
		if(recall){
			recall(action);
		}
	});
}