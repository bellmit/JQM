/**
 * Created by luojuehuai on 2016/12/6.
 */
nui.parse();
var entrustDire = '5';//储存当前回购方向
//提前储存Grid对象
var vunitstockGrid = nui.get("vunitstockGrid");
var bondsGrid = nui.get("bondsGrid");
var maxRepurchAmount = 0;
//是否为修改指令
var isUpdateDire = false;
var updateDireData = null;
//判断是否触发可用数量不足
var isT0T1avail = true;
//计算汇总行
function onDrawSummaryCell(e) {
    if (e.field === "vcStockName") {
        e.cellHtml = "<p style='color:#4DCE1D'>首次结算金额:</p>";
    }
    if (e.field === "vcDepository") {
        var data = e.data;
        var amount = 0;
        for (var i = 0; i < data.length; i++) {
            if (data[i].enFaceAmount) {
                amount = add(amount,data[i].enFaceAmount);
            }

        }
        maxRepurchAmount = amount;
        	nui.get("enFullPriceAmount").setValue(amount);
            e.cellHtml = "<p style='color:#4DCE1D'>" + amount + " 元</p>";
    }

}
//自定义列

function onActionRenderer(e) {
    var record = e.record;
    return ' <a class="删除" href="javascript:removeSelectedBonds(\'' + record._uid + '\')">删除</a>';
}


/*
 页面产品代码与产品组合combox联动
 */
var fundCodeCombo = nui.get("fundCodeName");
var vcCombiCombo = nui.get("vcCombi");
var fundCodeCombo2 = nui.get("vcProductCode");
var vcCombiCombo2 = nui.get("vcCombiCode");
//联动方法
var selectFund = function (e) {
	fundCodeData = fundCodeCombo.data;
    var id = fundCodeCombo.getValue();
    var text = fundCodeCombo.getText();
    fundCodeCombo2.setValue(id);
    fundCodeCombo2.setText(text);
    if(!id){
    	vcCombiCombo2.setValue(id);
    	vcCombiCombo2.setText(text);
    	vcCombiCombo.setValue(null);
    	vcCombiCombo.setText(null);
    	return;
    }
  //增加手动添加债券查询条件：fundId
	vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.getFundBond.biz.ext?fundId="+id;
    //查询在途回购金额
    getEnGhBalance();
    $.ajax({
        data: {vcProductCode: id},
        url: "com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfo.biz.ext",
        success: function (resp) {
            vcCombiCombo.setValue("");
            if (resp.data) {
                vcCombiCombo.load(resp.data);
                vcCombiCombo.select(0);
                vcCombiCombo2.load(resp.data);
                vcCombiCombo2.select(0);
                //获取可用
                getAviliable();
              //重新查询持仓
                queryVunitStock();
              //获取此组合是否可以透支
                allowOverdraft(vcCombiCombo.getValue(),'2');
            }
            //获取基金净资产
            getEnFundValue();
        },
        //有错误码之后，把后面的错误提醒补齐。
        fail: function (resp) {
            alert(resp);
        }
    });
    if(entrustDire == "5"){
    	//清空质押券操作框
        bondsGrid.clearRows(); 
        
    }
};
var selectFund2 = function(e){
	fundCodeData = fundCodeCombo2.data;
	var id = fundCodeCombo2.getValue();
	var text= fundCodeCombo2.getText();
	fundCodeCombo.setValue(id);
    fundCodeCombo.setText(text);
    if(!id){
    	vcCombiCombo2.setValue(id);
    	vcCombiCombo2.setText(text);
    	vcCombiCombo.setValue(null);
    	vcCombiCombo.setText(null);
    	return;
    }
	//增加手动添加债券查询条件：fundId
	vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.getFundBond.biz.ext?fundId="+id;
    $.ajax({
        data: {vcProductCode: id},
        url: "com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfo.biz.ext",
        success: function (resp) {
            vcCombiCombo.setValue("");
            if (resp.data) {
                vcCombiCombo.load(resp.data);
                vcCombiCombo.select(0);
              //查询在途回购金额
                getEnGhBalance();
                vcCombiCombo2.load(resp.data);
                vcCombiCombo2.select(0);
                //获取可用
                getAviliable();
                //重新查询持仓
                queryVunitStock();
              //获取此组合是否可以透支
                allowOverdraft(vcCombiCombo.getValue(),'2');
            }
            //获取基金净资产
            getEnFundValue();
        },
        //有错误码之后，把后面的错误提醒补齐。
        fail: function (resp) {
            alert(resp);
        }
    });
    if(entrustDire == "5" || entrustDire == "15"){
    	//清空质押券操作框
        bondsGrid.clearRows();
    }
};

//查询可用金额
var getAviliable = function () {
    combiData = vcCombiCombo.getValue();
    var ids = [];
    var temp = {"vcAccount": combiData, "exdestination": 'OTC'};//应该为OTC
    ids.push(temp);
    var sendMsg = {combis: ids};
    nui.ajax({
        data: {"sendMsg": sendMsg},
        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.getFundInfo.biz.ext",
        success: function (resp) {
            if(resp.avaiList.length>0){
            	var vcAvailableamountT0 = resp.avaiList[0].VC_AVAILABLEAMOUNT_T0;
				var vcAvailableamountT1 = resp.avaiList[0].VC_AVAILABLEAMOUNT_T1;
				if(resp.avaiList[0].C_LOCAL_AVAILABLE != null && resp.avaiList[0].C_LOCAL_AVAILABLE == "0"){//不启用本地头寸计算
					vcAvailableamountT0 = resp.avaiList[0].VC_O32_AVAILABLEAMOUNT_T0;
					vcAvailableamountT1 = resp.avaiList[0].VC_O32_AVAILABLEAMOUNT_T1;
				}
				var updateAmont = parseFloat(0);
				//修改指令时可用金额回填
				if(updateDireData != null && updateDireData.cIsValid=="1"){//为修改指令且原指令状态为有效
					if(updateDireData.vcProcessStatus=="4" || updateDireData.vcProcessStatus=="5"){//原指令已录入O32
						if(resp.avaiList[0].VC_TASSET == updateDireData.vcAssetCode && updateDireData.vcEntrustDirection == "6"){
							updateAmont = parseFloat(updateDireData.enFaceAmount)*10000;
						}
					}else{
						if(resp.avaiList[0].C_LOCAL_AVAILABLE != null && resp.avaiList[0].C_LOCAL_AVAILABLE == "0"){//不启用本地头寸计算
							//获取同业务编号，指令记录流程已到O32的修改审核中的记录。修改指令时回填
							nui.ajax({
				        		data:{param:{lResultNo:updateDireData.lResultNo,vcEntrustDirection:"6"}},
				        		async: false,
				        		url:"com.cjhxfund.ats.sm.comm.AvaiableDataManager.getO32UnderReviewInstruct.biz.ext",
				        		success:function(resp){
				        			var returnJson = nui.decode(resp);
									if(returnJson.exception == null){
										if(returnJson.updateCheckInstruct.length==1){
											var updateCheckInstruct = returnJson.updateCheckInstruct[0];
											if(updateCheckInstruct.VC_ASSET_CODE == resp.avaiList[0].VC_TASSET){
												updateAmont = (updateCheckInstruct.EN_FACE_AMOUNT)*10000;
											}
										}
									}
					            }
						    });
						}else{//使用本地头寸计算
							//修改指令时，原指令为有效的融券指令，且查询对象的资产单元与原指令为同一资产单元
			            	if(resp.avaiList[0].VC_TASSET == updateDireData.vcAssetCode && updateDireData.vcEntrustDirection=="6"){
			            		var now =  DateUtil.toNumStr(new Date());
			            		var now1 = DateUtil.toNumStr(new Date(new Date().getTime()+24*60*60*1000));
			            		//原指令的交易日为今天的指令或者交易日为明天的t+0指令在需改时需要将资金加回
			            		if(updateDireData.lTradeDate == now || (updateDireData.lTradeDate == now1 && updateDireData.vcSettleSpeed == "0")){
			            			updateAmont = parseFloat(updateDireData.enFaceAmount)*10000;
			            		}
			            	}
						}
					}
				}
            	nui.get("vcAvailableamountT0").setValue(vcAvailableamountT0+updateAmont);
                nui.get("vcAvailableamountT1").setValue(vcAvailableamountT1+updateAmont);
            }
        },
        //有错误码之后，把后面的错误提醒补齐。
        fail: function (resp) {
            alert(resp);
        }

    });

};
//将产品下拉列表里面的字段通过键值对缓存
var fundCodeData = {};
function fundCodeCache(){
	var temp = null;
	    if(fundCodeData && fundCodeData.length>0){
	    	temp = fundCodeData;
	    }else{
	    	temp  = fundCodeCombo.data;
	        
	    }
	    var length = temp.length;
        for(var i = 0 ;i<length;i++){
            fundCodeData[temp[i].VC_PRODUCT_CODE] = temp[i];
        }

    return fundCodeData;
}
//查询基金净资产
var getEnFundValue = function(){
    var fundId = fundCodeCombo.getValue();
    nui.ajax({
        data: {"fundId": fundCodeCache()[fundId]["L_PRODUCT_ID"]},
        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.getEnFundValueByID.biz.ext",
        success: function (resp) {
            if(resp.enFundValue.length>0){
                nui.get("enFundValue").setValue(resp.enFundValue[0].enFundValue);
            }
        },
        //有错误码之后，把后面的错误提醒补齐。
        fail: function (resp) {
            alert(resp);
        }

    });
};
//查询在途回购金额
var getEnGhBalance = function(){
    //拿到产品Id
    var fundId = fundCodeCombo.getValue();
    //获取今天日期
    nui.ajax({
        data: {param:{"lFundId": fundCodeCache()[fundId]["L_PRODUCT_ID"]}},
        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.getEnGhBalanceById.biz.ext",
        success: function (resp) {
            if(resp.enGhBalance[0]){
                nui.get("enGhBalance").setValue(resp.enGhBalance[0].enGhBalance);
            }
            if(resp.enGhBalanceS[0]){
                nui.get("enGhBalanceS").setValue(resp.enGhBalanceS[0].enGhBalanceS);
            }
            if(resp.enGhBalanceZ[0]){
                nui.get("enGhBalanceZ").setValue(resp.enGhBalanceZ[0].enGhBalanceZ);
            }
        },
        //有错误码之后，把后面的错误提醒补齐。
        fail: function (resp) {
            alert(resp);
        }

    });
};

var selectCombi = function () {
	var value = vcCombiCombo.getValue();
    vcCombiCombo2.setValue(value);
    //计算可用
    getAviliable();
    //获取此组合是否可以透支
    allowOverdraft(value,'2');
};
var bondCodeCombo = nui.get("bondCode");

var getBondCodeList = function () {
    var bondCode = $("#bondCode > span > input")[0].value;
    if (bondCode.length < 4) {
        return false;
    }
    $.ajax({
        data: {stockCode: bondCode},
        url: "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.queryBondCode.biz.ext",
        success: function (resp) {
            bondCodeCombo.setValue("");
            if (resp.bondList) {
                bondCodeCombo.load(resp.bondList);
            }
        },
        //有错误码之后，把后面的错误提醒补齐。
        fail: function (resp) {
            alert(resp);
        }

    });
};

/*
 查询债券持仓方法
 */
var queryVunitStock = function () {

    var condition = (new nui.Form("vunitstockCondition")).getData();
    if (!condition.vcCombiName) {
        nui.alert("请最少选择一个组合！", "警告");
        return false;
    }
    var vcStockType =condition.vcStockType ?condition.vcStockType.replace(/,/g,"','") : "";
    if(vcStockType !== ""){
    	vcStockType = "'" + vcStockType + "'";
    }
    var ratingForecast = nui.get("ratingForecast").getText().replace(/,/g,"','");
    if(ratingForecast !== ""){
    	ratingForecast = "'" + ratingForecast + "'";
    }
    var vcIssueAppraise = nui.get("vcIssueAppraise").getText().replace(/,/g,"','");
    if(vcIssueAppraise !== ""){
    	vcIssueAppraise = "'" + vcIssueAppraise + "'";
    }
    var issueProperty = nui.get("issueProperty").getValue();
    issueProperty = issueProperty ? issueProperty.replace(/,/g,"','") : "";
    if(issueProperty !== ""){
    	issueProperty = "'" + issueProperty + "'";
    }
    var vunitstockParam = {
        fundId: condition.fundCodeName,
        baseCombiId: condition.vcCombiName,
        ratingForecast: ratingForecast,
        vcPaymentPlace:condition.vcPaymentPlace,
        vcStockType:vcStockType,
        vcIssueAppraise:vcIssueAppraise,
        issueProperty:issueProperty,
        vcStockCode : condition.vcStockCode2
    };
    vunitstockGrid.load({"vunitstockParam": vunitstockParam});
    closeSearch();
};
//查询可用数据
function queryVisible(datas,grid,isUpdate,recall){
	var VunitData = datas;
    nui.ajax({
        data: {'vunitstockLists': VunitData,"vcMarket":'OTC'},
        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.queryVisible.biz.ext",
        success: function (resp) {
        	var avaiList = resp.avaiList;
        	if(isUpdate){
        		for(var i =0;i<VunitData.length;i++){
            		var row = VunitData[i];
            		for(var j =0;j<avaiList.length;j++){
            			var ava = avaiList[j];
            			if(row.vcCombiCode==ava.VC_ACCOUNT && row.vcReportCode == ava.VC_SYMBOL){
            				var vcAvailablequantityT0Temp = ava.VC_AVAILABLEQUANTITY_T0;
    						var vcAvailablequantityT1Temp = ava.VC_AVAILABLEQUANTITY_T1;
    						if(ava.C_LOCAL_AVAILABLE != null && ava.C_LOCAL_AVAILABLE == "0"){//不启用本地可用计算
    							vcAvailablequantityT0Temp = ava.VC_O32_AVAILABLEQUANTITY_T0;
    							vcAvailablequantityT1Temp = ava.VC_O32_AVAILABLEQUANTITY_T1;
    						}
                			if(isUpdateDire && updateDireData.cIsValid=="1"){//修改指令且原指令为有效指令
                				var bondsTemp = updateDireData.bonds;
                				var pledgeCount = 0;
                				if(updateDireData.vcProcessStatus=="4" || updateDireData.vcProcessStatus=="5"){//原指令已录入O32
            						if(updateDireData.vcEntrustDirection == "5"){
            							for(var t = 0;t<bondsTemp.length;t++){
                    						if(bondsTemp[t].vcCombiCode == row.vcCombiCode && bondsTemp[t].vcReportCode == row.vcReportCode){
                    							pledgeCount = parseInt(bondsTemp[t].enFaceAmount*100);
                    						}
                    					}
            						}
            					}else{//原指令未到O32
            						if(ava.C_LOCAL_AVAILABLE != null && ava.C_LOCAL_AVAILABLE == "0"){//不启用本地头寸计算
            							//获取同业务编号，指令记录流程已到O32的修改审核中的记录。修改指令时回填
            							nui.ajax({
            				        		data:{param:{lResultNo:updateDireData.lResultNo,vcEntrustDirection:"5",vcStockCode:row.vcReportCode,vcCombiCode:row.vcCombiCode,vcExchange:row.vcExchange}},
            				        		async: false,
            				        		url:"com.cjhxfund.ats.sm.comm.AvaiableDataManager.getO32UnderReviewInstructMgt.biz.ext",
            				        		success:function(resp){
            				        			var returnJson = nui.decode(resp);
            									if(returnJson.exception == null){
            										if(returnJson.updateCheckInstructMgt.length==1){
            											var updateCheckInstructMgt = returnJson.updateCheckInstructMgt[0];
            											pledgeCount = parseInt(updateCheckInstructMgt.EN_FACE_AMOUNT*100);
            										}
            									}
            					            }
            						    });
            						}else{
            							for(var t = 0;t<bondsTemp.length;t++){
                    						if(bondsTemp[t].vcCombiCode == row.vcCombiCode && bondsTemp[t].vcReportCode == row.vcReportCode){
                    							//指令为预置指令(交易日与询价结果日期不等)且流程状态当前停留在下达到O32之前时，预置指令的修改时回填可用数量使用该指令当前锁定的数量
        										if(updateDireData.lTradeDate != updateDireData.lResultDate && (updateDireData.vcProcessStatus=="1" || updateDireData.vcProcessStatus=="2" || updateDireData.vcProcessStatus=="2A" || updateDireData.vcProcessStatus=="3")){
        											//同步方法获取预置指令当前锁定数量
        											var lockParam = {"lResultId": updateDireData.lResultId,"vcCombiCode": bondsTemp[t].vcCombiCode,"vcStockCode":bondsTemp[t].vcReportCode,"vcMarket":bondsTemp[t].vcExchange,"lockSource":3};
        											nui.ajax({
        												url : "com.cjhxfund.ats.sm.comm.TBondLockInfoManager.getInstructOneBondLock.biz.ext",
        												type : 'POST',
        												data : {param:lockParam},
        												cache : false,
        												async: false,
        												contentType : 'text/json',
        												success : function(e) {
        													var returnLockJson = nui.decode(e);
        													pledgeCount = returnLockJson.lockQty;
        												}
        											});
        										}else{//非预置指令时
        											pledgeCount = parseInt(bondsTemp[t].enFaceAmount*100);
        										}
                    						}
                    					}
            							
            						}
            					}
                				vcAvailablequantityT0Temp = vcAvailablequantityT0Temp+pledgeCount;
                				vcAvailablequantityT1Temp = vcAvailablequantityT1Temp+pledgeCount;
                			}
                			if(vcAvailablequantityT0Temp>0){
            					VunitData[i].vcAvailablequantityT0 = vcAvailablequantityT0Temp;
            				}else{
            					VunitData[i].vcAvailablequantityT0 = 0;
            				}
            				if(vcAvailablequantityT1Temp>0){
            					VunitData[i].vcAvailablequantityT1 = vcAvailablequantityT1Temp;
            				}else{
            					VunitData[i].vcAvailablequantityT1 = 0;
            				}
            				grid.updateRow(VunitData[i]);
           					break;
            			}
            		}
            	}
        	}else{
        		for(var i =0;i<VunitData.length;i++){
            		var row = VunitData[i];
            		for(var j =0;j<avaiList.length;j++){
            			var ava = avaiList[j];
            			if(row.vcCombiCode==ava.VC_ACCOUNT && row.vcReportCode == ava.VC_SYMBOL){
            				var vcAvailablequantityT0Temp = ava.VC_AVAILABLEQUANTITY_T0;
    						var vcAvailablequantityT1Temp = ava.VC_AVAILABLEQUANTITY_T1;
    						if(ava.C_LOCAL_AVAILABLE != null && ava.C_LOCAL_AVAILABLE == "0"){//不启用本地可用计算
    							vcAvailablequantityT0Temp = ava.VC_O32_AVAILABLEQUANTITY_T0;
    							vcAvailablequantityT1Temp = ava.VC_O32_AVAILABLEQUANTITY_T1;
    						}
                			if(isUpdateDire && updateDireData.cIsValid=="1"){//修改指令且原指令为有效指令
                				var bondsTemp = updateDireData.bonds;
                				var pledgeCount = 0;
                				if(updateDireData.vcProcessStatus=="4" || updateDireData.vcProcessStatus=="5"){//原指令已录入O32
            						if(updateDireData.vcEntrustDirection == "5"){
            							for(var t = 0;t<bondsTemp.length;t++){
                    						if(bondsTemp[t].vcCombiCode == row.vcCombiCode && bondsTemp[t].vcReportCode == row.vcReportCode){
                    							pledgeCount = parseInt(bondsTemp[t].enFaceAmount*100);
                    						}
                    					}
            						}
            					}else{//原指令未到O32
            						if(ava.C_LOCAL_AVAILABLE != null && ava.C_LOCAL_AVAILABLE == "0"){//不启用本地头寸计算
            							//获取同业务编号，指令记录流程已到O32的修改审核中的记录。修改指令时回填
            							nui.ajax({
            				        		data:{param:{lResultNo:updateDireData.lResultNo,vcEntrustDirection:"5",vcStockCode:row.vcReportCode,vcCombiCode:row.vcCombiCode,vcExchange:row.vcExchange}},
            				        		async: false,
            				        		url:"com.cjhxfund.ats.sm.comm.AvaiableDataManager.getO32UnderReviewInstructMgt.biz.ext",
            				        		success:function(resp){
            				        			var returnJson = nui.decode(resp);
            									if(returnJson.exception == null){
            										if(returnJson.updateCheckInstructMgt.length==1){
            											var updateCheckInstructMgt = returnJson.updateCheckInstructMgt[0];
            											pledgeCount = parseInt(updateCheckInstructMgt.EN_FACE_AMOUNT*100);
            										}
            									}
            					            }
            						    });
            						}else{
            							for(var t = 0;t<bondsTemp.length;t++){
                    						if(bondsTemp[t].vcCombiCode == row.vcCombiCode && bondsTemp[t].vcReportCode == row.vcReportCode){
                    							//指令为预置指令(交易日与询价结果日期不等)且流程状态当前停留在下达到O32之前时，预置指令的修改时回填可用数量使用该指令当前锁定的数量
        										if(updateDireData.lTradeDate != updateDireData.lResultDate && (updateDireData.vcProcessStatus=="1" || updateDireData.vcProcessStatus=="2" || updateDireData.vcProcessStatus=="2A" || updateDireData.vcProcessStatus=="3")){
        											//同步方法获取预置指令当前锁定数量
        											var lockParam = {"lResultId": updateDireData.lResultId,"vcCombiCode": bondsTemp[t].vcCombiCode,"vcStockCode":bondsTemp[t].vcReportCode,"vcMarket":bondsTemp[t].vcExchange,"lockSource":3};
        											nui.ajax({
        												url : "com.cjhxfund.ats.sm.comm.TBondLockInfoManager.getInstructOneBondLock.biz.ext",
        												type : 'POST',
        												data : {param:lockParam},
        												cache : false,
        												async: false,
        												contentType : 'text/json',
        												success : function(e) {
        													var returnLockJson = nui.decode(e);
        													pledgeCount = returnLockJson.lockQty;
        												}
        											});
        										}else{//非预置指令时
        											pledgeCount = parseInt(bondsTemp[t].enFaceAmount*100);
        										}
                    						}
                    					}
            							
            						}
            					}
                				vcAvailablequantityT0Temp = vcAvailablequantityT0Temp+pledgeCount;
                				vcAvailablequantityT1Temp = vcAvailablequantityT1Temp+pledgeCount;
                			}
                			if(vcAvailablequantityT0Temp>0){
            					VunitData[i].vcAvailablequantityT0 = vcAvailablequantityT0Temp;
            				}else{
            					VunitData[i].vcAvailablequantityT0 = 0;
            				}
            				if(vcAvailablequantityT1Temp>0){
            					VunitData[i].vcAvailablequantityT1 = vcAvailablequantityT1Temp;
            				}else{
            					VunitData[i].vcAvailablequantityT1 = 0;
            				}
            				grid.updateRow(VunitData[i]);
           					break;
            			}
            		}
            	}
        	}
        	if(recall){
        		recall();
        	}
        },
        //有错误码之后，把后面的错误提醒补齐。
        fail: function (resp) {
            alert(resp);
        }

    });
}
//手动添加质押券方法
function addBond(){
	var vcStockCode = nui.get("vcStockCode").getText();
	var vcCombiNo = nui.get("vcStockCode").getValue();
	vcCombiNo = vcCombiNo == 'undefined' ? null : vcCombiNo;
	if(!checkO32Exist({vcStockCode:vcStockCode,vcMarketNo:5})){
		nui.alert("O32不存在此债券");
		return;
	}
    nui.ajax({
        data: {param:{'vcStockCode':vcStockCode,'vcCombiNo':vcCombiNo,'vcMarketNo':5}},
        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.queryBondInfo.biz.ext",
        success: function (resp) {
        	var bonds = resp.bonds;
            if (bonds && bonds.length>0) {
            	if(nui.get("vcEntrustDirection").getValue() == '5'){
                	queryVisible(bonds,bondsGrid,false,function(){
                		chooseBond(bonds[0]);
                	});
            	}else{
            		chooseBond(bonds[0]);
            	}
            	}
        },
        //有错误码之后，把后面的错误提醒补齐。
        fail: function (resp) {
            nui.alert(resp);
        }
    });
}

//检查O32是否存在输入的债券
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

var operation = function () {
    nui.open({
        url: "<%= request.getContextPath() %>/repurchase/repurchaseOpra.jsp",
        title: "编辑员工", width: 600, height: 400,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {action: "edit", id: row.id};
            iframe.contentWindow.SetData(data);
        },
        ondestroy: function (action) {
//                         grid.reload();
        }
    });
};

//导入选择债券，要加去重功能
var chooseBond = function (rowsData) {
	var rows = {};
	if(rowsData){
		if(rowsData.row){
			rows = copySelectData([rowsData.row]);
		}else{
			rows = copySelectData([rowsData]);
		}	
	}else{
		rows = copySelectData(vunitstockGrid.getSelecteds());
	}
	//不能选择PPN类型的债券
	var vcStockName = rows[0].vcStockName;
	if(vcStockName && (vcStockName.indexOf("PPN")>=0 || vcStockName.indexOf("ABN")>=0)){
        nui.alert("不能选择PPN、ABN类型债券！","系统提示");
        return false;
	}
	
	//清空选择的债卷
	clearSelectedBonds();
	var idStr = "canRepAmountZ";
	
	if(rows.length > 1){
		nui.alert("请勿选择多个债券","系统提示");
	    return false;
	}
	if(rows[0].vcDepository !== "01"){
	    idStr = "canRepAmountS";
	}
	bondsGrid.addRows(rows, 0);
	deposit = idStr;
	vunitstockGrid.clearSelect(true);
};
//计算中途付息利息
var calMiddleInterest = function(lNextPayintDate,enPayInteval,enFaceAmount,enFaceRate,lFirstSettleDate,lMaturitySettleDate){
	if(!lNextPayintDate || !enPayInteval || !enFaceAmount || !enFaceRate || !lFirstSettleDate || !lMaturitySettleDate){
		return 0;
	}
	lNextPayintDate = DateUtil.numStrToDate(lNextPayintDate); //下一付息日
	lFirstSettleDate = DateUtil.DstrToDate(lFirstSettleDate); //首次结算日
	lMaturitySettleDate = DateUtil.DstrToDate(lMaturitySettleDate); //到期结算日
	var inteval = div(12,enPayInteval);  //多少月付一次利息。
	var startDate = new Date(lNextPayintDate); //计息日期
 	var endDate =  null; //计息截止日期
	for(;;){      //循环计算计息日期
		if(Number(DateUtil.toNumStr(startDate))>Number(DateUtil.toNumStr(lFirstSettleDate))){  //当下一付息日大于首次结算日，则为计息日期。
			endDate = new Date(startDate);
			break;
		}else{
			var month2 = startDate.getMonth();
			startDate.setMonth(month2+inteval);
		}
	}
	if(Number(DateUtil.toNumStr(startDate)) >= Number(DateUtil.toNumStr(lMaturitySettleDate))){
		return 0;
	}else{
		var month = startDate.getMonth();
		startDate.setMonth(month - inteval);
	}
	for(;;){ //循环计算截止日期
		if(Number(DateUtil.toNumStr(endDate))>Number(DateUtil.toNumStr(lMaturitySettleDate))){ //当到期结算日第一次大于累加起来的付息日期，往前推一个付息周期，得到截止日期。
			var month3 = endDate.getMonth();
			endDate.setMonth(month3 - inteval);
			break;
		}else{
			var month4 = endDate.getMonth();
			endDate.setMonth(month4 + inteval);
		}
	}
	var date = div((endDate.getTime() - startDate.getTime()),86400000);
	var interest = div(mul(mul(enFaceRate,date),enFaceAmount*100),365);
	return interest;
};
//计算可做回购金额方法、券面金额改动同时联动首次结算金额、到期结算金额、回购利息。
function calcFaceAmout(row,enFaceAmount,enNetPriceInit,enMortagageRatio){
	//校验券面金额Start
	   if(!ispositiveNum(enFaceAmount)) {
	        nui.alert("必须为正整数！");
	        isEnFaceAmountRight = false;
	        return;
	    }
	   isEnFaceAmountRight = true;
	    var available = 0;
	    var t = "T+0";
	    if (nui.get("vcSettleSpeed").getValue() === '0') {
	        available = row["vcAvailablequantityT0"];
	    } else {
	        available = row["vcAvailablequantityT1"];
	        t = "T+1";
	    }
	    available = available ? available : 0;
	    if (nui.get("vcEntrustDirection").getValue() === "5" && fixStatus === "0") {
	        if ((enFaceAmount * 100) > available) {
	            nui.alert("已超过" + t + "最大可质押数量！");
	            isT0T1avail = false;
	            e.sender.setValue(0);
	            row["canRepurchaseAmount"] = 0;
	            bondsGrid.updateRow(row);
	            return;
	        } else {
	            isT0T1avail = true;
	        }
	    }
	  //校验券面金额End
	    
	   //计算回购金额        
	   var enFullPriceInit = row["enFullPriceInit"] ? row["enFullPriceInit"] : 0;
	   row["canRepurchaseAmount"] =(mul(enFullPriceInit, enFaceAmount/100) * 10000).toFixed(2);//首期结算金额
	   var enFullPriceFinal = row["enFullPriceFinal"] ? row["enFullPriceFinal"] : row["enFullPriceFinal"]; //到期全价
	   if(enFullPriceFinal>0){
		   var enSettleAmount = mul(mul(enFullPriceFinal, enFaceAmount/100) , 10000).toFixed(2); //到期结算金额
		   var middleInterest = calMiddleInterest(row["lNextPayintDate"],row["enPayInteval"],
				   row["enFaceAmount"],row["enFaceRate"],nui.get("lFirstSettleDate").getValue(),nui.get("lMaturitySettleDate").getValue());
		   //计算利息
		   var interest = add((enSettleAmount - row["canRepurchaseAmount"]),middleInterest);
		   nui.get("enSettleAmount").setValue(enSettleAmount);
		   nui.get("enRepoInterest").setValue(interest);
	   }
	   bondsGrid.updateRow(row);
	   //回购金额变动，计算首期结算金额、利息和到期结算金额
	   
}
//计算可做首期结算金额方法，券面金额入口
function updateFaceAmout(e) {
    var row_uid = e.sender.ownerRowID;
    var row = bondsGrid.getRowByUID(row_uid);
  //计算回购金额
    calcFaceAmout(row,e.sender.value,row["enFullPriceInit"],row["enFaceAmount"]);
}
//计算首次全价、净价公共方法
function calcNetAllValue(netValue,allValue,grid,row,recall){
	if(!netValue && !allValue){
		return;
	}
	var lTradeDate = nui.get("lTradeDate");
	if(!lTradeDate){	
		return;
	}
	lTradeDate = DateUtil.toNumStr(nui.get("lTradeDate").getValue());
	
	var vcSettleSpeed = nui.get("vcSettleSpeed").getValue();
	vcSettleSpeed = vcSettleSpeed == "1" ? 'T+1' : 'T+0';
	var jsonParam = {processDate:lTradeDate, interCode:row['vcInterCode'], 
			netPrice:netValue, fullPrice:allValue, interestRate:null, interestRateType:'1', 
			tradingPlace:'01', clearingSpeed:vcSettleSpeed};
	nui.ajax({
        url:"com.cjhxfund.ats.sm.comm.InstructionManager.getLinkageValue.biz.ext",
        type:'POST',
        data:jsonParam,
        cache:false,
        contentType:'text/json',
        success:function(response){
            if(response.exception == null){
            	var result = response.result; //返回结果：净价，全价，到期收益率，收益率类型，交易场所，清算速度，行权收益率
            	var resultArr = result.split("@");
            	row["enNetPriceInit"] = Number(resultArr[0]);//净价（元/百元面值）
            	row["enFullPriceInit"] = Number(resultArr[1]);//全价（元/百元面值）
//            	row["enNetPriceInitA"] = Number(resultArr[0]);//净价（元/百元面值）没有四舍五入的值
//            	row["enFullPriceInitA"] = Number(resultArr[1]);//全价（元/百元面值）没有四舍五入的值
            	
            	//计算回购金额
                row["canRepurchaseAmount"] = (mul(row["enFullPriceInit"], row["enFaceAmount"]/100) * 10000).toFixed(2) ;
                grid.updateRow(row);
                if(recall){
					recall(Number(resultArr[0]).toFixed(4),null,bondsGrid,bondsGrid.data[0]);
				}
            }else{
                nui.alert("净价、全价、收益率数据获取失败", "系统提示");
            }
        }
    });
}
//计算到期全价、净价公共方法
function calcenFullPriceFinal(netValue,allValue,grid,row,recall){
	if(!netValue && !allValue){
		return;
	}
	var lTradeDate = nui.get("lMaturitySettleDate").getValue();
	if(!lTradeDate){
		nui.alert("请输入回购天数！");
		return;
	}
	lTradeDate = DateUtil.toNumStr(lTradeDate);
	
	var vcSettleSpeed = nui.get("vcSettleSpeed").getValue();
	vcSettleSpeed = vcSettleSpeed == "1" ? 'T+1' : 'T+0';
	var jsonParam = {processDate:lTradeDate, interCode:row['vcInterCode'],reportCode:row["vcStockCode"],
			netPrice:netValue, fullPrice:allValue, interestRate:null, interestRateType:'1', 
			tradingPlace:'5', clearingSpeed:vcSettleSpeed};
	nui.ajax({
        url:"com.cjhxfund.ats.sm.comm.InstructionManager.getLinkageLastValue.biz.ext",
        type:'POST',
        data:jsonParam,
        cache:false,
        contentType:'text/json',
        success:function(response){
            if(response.exception == null){
            	var result = response.result; //返回结果：净价，全价，到期收益率，收益率类型，交易场所，清算速度，行权收益率
            	var resultArr = result.split("@");
            	row["enNetPriceFinal"] = Number(resultArr[0]);//净价（元/百元面值）
            	row["enFullPriceFinal"] = Number(resultArr[1]);//全价（元/百元面值）
//            	row["enNetPriceFinalA"] = Number(resultArr[0]);//净价（元/百元面值）没有四舍五入的值
//            	row["enFullPriceFinalA"] = Number(resultArr[1]);//全价（元/百元面值）没有四舍五入的值
				grid.updateRow(row);
				//到期结算金额
				var enSettleAmount = (mul(row["enFullPriceFinal"], row["enFaceAmount"]/100) * 10000).toFixed(2);
				
				nui.get("enSettleAmount").setValue(enSettleAmount);
				calInterest(row["enFullPriceInit"],row["enFullPriceFinal"],
						nui.get("lContractPeriods").getValue(),row["lNextPayintDate"],nui.get("lMaturitySettleDate").getValue(),row["enPayInteval"],row["enFaceRate"]);
				//首期结算金额
				var enFullPriceAmount = nui.get("enFullPriceAmount").getValue();
				if(enFullPriceAmount && enFullPriceAmount<=0){
					return;
				}
				//计算中途付息金额
				var middleInterest = calMiddleInterest(row["lNextPayintDate"],row["enPayInteval"],row["enFaceAmount"],row["enFaceRate"],nui.get("lFirstSettleDate").getValue(),
						nui.get("lMaturitySettleDate").getValue());
				//计算回购利息
				nui.get("enRepoInterest").setValue(add(enSettleAmount - enFullPriceAmount,middleInterest).toFixed(2)); //计算回购利息
				if(recall){
					recall(Number(resultArr[0]).toFixed(4),null,bondsGrid,bondsGrid.data[0]);
				}
				
            }else{
                nui.alert("净价、全价、收益率数据获取失败", "系统提示");
            }
        }
    });
}

//到期全价、首期全价、回购利息互联计算公共方法。参数（首期全价，到期全价，实际占款天数，下一付息日期，到期结算日，付息频率，票面利率）
function calInterest(allValueInit,allValueFinal,period,lNextPayintDate,endDate,enPayInteval,enFaceRate){
	var interest = null;
	if(lNextPayintDate && (Number(DateUtil.toNumStr(endDate)) > Number(lNextPayintDate))){ //此条记录是否存在下一付息日同时下一付息日是否小于到期结算日
		var TC = div(enFaceRate,enPayInteval);
		var dTime = DateUtil.DstrToDate(endDate).getTime() - DateUtil.numStrToDate(lNextPayintDate).getTime();
		var d = dTime/86400000;
		var son = add((allValueFinal - allValueInit),TC);
		var IPD = div(mul(allValueInit,period),365);
		var TCd = div(mul(TC,d),365);
		interest = div(son,(IPD - TCd)) * 100;
	}else{
		var FPIP = (allValueFinal - allValueInit);
		var IPD = mul(allValueInit,period);
		interest = div(mul(FPIP,365),IPD) * 100;
	}
	nui.get("enRepoRate").setValue(interest.toFixed(4));
}

function calNetFull(enRepoRate,enFullPriceInit,period,lNextPayintDate,endDate,enPayInteval,enFaceRate){
	var enFullPriceFinal = null;
	if(lNextPayintDate && (Number(DateUtil.toNumStr(endDate)) > Number(lNextPayintDate))){ //此条记录是否存在下一付息日同时下一付息日是否小于到期结算日
		var TC = div(enFaceRate,enPayInteval);
		var dTime = DateUtil.DstrToDate(endDate).getTime() - DateUtil.numStrToDate(lNextPayintDate).getTime();
		var d = dTime/86400000;
		var RIPD = mul(mul(enRepoRate/100,enFullPriceInit),period);
		var RTCD = mul(mul(enRepoRate/100,TC),d);
		var son = RIPD - RTCD;		
		enFullPriceFinal = add(enFullPriceInit,div(son,365)) - TC;
	}else{
		var RIP = mul(enRepoRate/100,enFullPriceInit);
		var D365 = div(period,365);
		var IPDR365 = mul(RIP,D365);
		enFullPriceFinal = add(IPDR365,enFullPriceInit); //得到到期全價
	}
	calcenFullPriceFinal(null,enFullPriceFinal,bondsGrid,bondsGrid.data[0],function(netPrice,fullPrice,grid,row1){
		calcenFullPriceFinal(netPrice,fullPrice,grid,row1);
	});
}
//根据到期净价计算其他
function updenNetPriceFinal(e){
	var row_uid = e.sender.ownerRowID;
	var row = bondsGrid.getRowByUID(row_uid);
	calcenFullPriceFinal(e.sender.value,null,bondsGrid,row);
}
//根据到期全价计算其他
function updenFullPriceFinal(e){
	var row_uid = e.sender.ownerRowID;
	var row = bondsGrid.getRowByUID(row_uid);
	calcenFullPriceFinal(null,e.sender.value,bondsGrid,row,function(netPrice,fullPrice,grid,row1){
		calcenFullPriceFinal(netPrice,fullPrice,grid,row1);
	});
}
//根据首次净价计算首次全价
function updenNetPriceInit(e){
	var row_uid = e.sender.ownerRowID;
	var row = bondsGrid.getRowByUID(row_uid);
	calcNetAllValue(e.sender.value,null,bondsGrid,row,function(){
		calEmFaceAmount();
	});
}
//根据首次全价计算首次净价
function updenFullPriceInit(e){
	var row_uid = e.sender.ownerRowID;
	var row = bondsGrid.getRowByUID(row_uid);
	calcNetAllValue(null,e.sender.value,bondsGrid,row,function(netPrice,fullPrice,grid,row1){
		calcNetAllValue(netPrice,fullPrice,grid,row1);
	});
}
//计算券面金额
var copySelectData = function (rows) {
    var temp = rows;
    var temp2 = [];
    for (var i = 0; i < temp.length; i++) {
        var object = {};
        for (var key in temp[i]) {
            object[key] = temp[i][key];
        }
        //券面金额、
        if (object["vcAvailablequantityT0"]) {
            object["enFaceAmount"] = object["vcAvailablequantityT0"] / 100;
        } else {
            object["enFaceAmount"] = 0;
        }
        
        //计算可做回购金额
        //object["canRepurchaseAmount"] = mul(object["enCbValueAllValue"], object["enFaceAmount"]);
        temp2.push(object);
    }
    return temp2;
};
function updateMortagage(e) {
    var row_uid = e.sender.ownerRowID;
    var value = e.sender.value;
    if (!value) {
        value = 0;
    }
    var row = bondsGrid.getRowByUID(row_uid);
    if (!ispositiveFlo(value)) {
        nui.alert("必须为正数！");
        return;
    }
    if (value > 100) {
        nui.alert("质押比例不能大于100！");
        return;
    }
    row["enMortagageRatio"] = value;
    var temp = mul(Number(row["enFaceAmount"]), div(Number(value), 100)).toString();
    var index = temp.indexOf(".");
    if (index != -1) {
        temp = temp.slice(0, index + 5);
    }
    row["canRepurchaseAmount"] = temp;
    bondsGrid.updateRow(row);
}
//删除已选择的债券
var removeSelectedBonds = function (id) {
    bondsGrid.removeRow(bondsGrid.getRowByUID(id));
};
//清空已选择的债券
var clearSelectedBonds = function () {
    bondsGrid.clearRows();
};
//高亮导入箭头
var selectOpa = function () {
    var rows = vunitstockGrid.getSelecteds();
    var arrow = $(".arrow");
	var arrowBig = $(".arrowBig");
    if (rows.length > 0) {
    	var top = arrow.offset().top;
        var left = arrow.offset().left;
        if(top === 0 || left === 0){
        	return;
        }
    	arrow.animate({
    		marginTop:"+22px",
    	},300,function(){
    		arrow.fadeOut(100,function(){
    			arrowBig.css({ 
    	        	top: top-60,
    	            left: left
    	            }).fadeIn(100).animate({
    	            	marginTop:"+30px"
    	            },100);
    		});
    	});
    } else {
    	arrowBig.animate({
    		marginTop:"-5px",
    	},300,function(){
    		arrowBig.fadeOut(100,function(){
    			arrow.fadeIn(100).animate({
    	            	marginTop:"-1px"
    	            },100);
    		});
    	});
    }

};
//交易日日期设置及限制
var lTradeDate = new Date();
var lFirstSettleDate = lTradeDate;
var lMaturitySettleDate = lFirstSettleDate;

//首期结算日设置
var setLFirstSettleDate = function(){
    var getlTradeDate = nui.get("lTradeDate").getValue();
	if(getlTradeDate != "" ){
		lFirstSettleDate = nui.parseDate(getlTradeDate);
		lMaturitySettleDate = nui.parseDate(getlTradeDate);
	}
};


//组装完整指令参数
function combiDireParam(){
    var bondData = bondsGrid.data;
    
    if ((nui.get("vcEntrustDirection").getValue() == "5")  && (bondData.length < 1 || bondData[0].enFaceAmount <= 0)) {
        nui.alert("您没有选择任何可质押的债券。或者债券数量为0。", "警告");
        return false;
    }
    if(!bondData[0].enNetPriceInit || !bondData[0].enFullPriceInit || !bondData[0].enNetPriceFinal || !bondData[0].enFullPriceFinal){
    	nui.alert("您没有填写完整全价、净价。", "警告");
        return false;
    }
    if(isEnFaceAmountRight === false){
    	mini.showTips({
	            content: "券面金额必须为正整数！",
	            state: "danger",
	            x: "top",
	            y: "top",
	            timeout: 3000
	        });
    	return;
    }
    var directionParam = {};
    var form = null;
    if(fullDirection){
    	 form = fullDirection ;
    	 var isbondsChange = false;
    	 if(setDataBonds.length == bondsGrid.data.length){
    		 for(var s = 0;s<setDataBonds.length;s++){
    			 if(setDataBonds[s]["enFaceAmount"] != bondsGrid.data[s]["enFaceAmount"] ||
    					 setDataBonds[s]["enNetPriceInit"] != bondsGrid.data[s]["enNetPriceInit"] ||
    					 setDataBonds[s]["enNetPriceFinal"] != bondsGrid.data[s]["enNetPriceFinal"]){
    				 isbondsChange = true;
    				 break;
    			 }  
    		 }
    	 }else{
    		 isbondsChange = true;
    	 }
    	 if(!fullDirection.isChanged() && (!isbondsChange)){
    		 nui.alert("您没有修改任何指令要素，可以不用提交噢。");
    		 return false;
    	 }
    	 }else{
    		 form = new nui.Form("#fullDirection");
    	 }
    form.validate();
    if (form.isValid() == false){
    	return;
    }
    var fullDire = form.getData();
    
    var avaiAmount = 0;
    if(fullDire.vcSettleSpeed === "0"){
    	avaiAmount = nui.get("vcAvailableamountT0").getValue();
    }else{
    	avaiAmount = nui.get("vcAvailableamountT1").getValue();
    }
    if(fixStatus == 0){ //转换机是否开启
    	if(fullDire.vcEntrustDirection === "5"){
            if(!isT0T1avail){
            	nui.alert("存在可用数量不足的债券，请在左边操作栏重新输入相应券面金额！", "警告");
                return false;
            }
        }else{
        	if(fullDire.enFullPriceAmount > avaiAmount){
        		if(cOverdraft == 1){ //允许透支
        			mini.showTips({
 			            content: "回购金额已超过当前可用金额，但此组合可以透支，仍然继续下达指令。",
 			            state: "success",
 			            x: "top",
 			            y: "top",
 			            timeout: 3000
 			        });
        		}else{
        			nui.alert("回购金额不能超过当前可用金额！","警告");
            		return false;
        		}
        		
        	}
        }
    }
    
    //全价金额（首期结算金额、回购金额）
    //首期结算金额暂时为0
//    fullDire["enFullPriceAmount"] = 0 + parseInt(fullDire["enFaceAmount"]);
    //回购天数 = 回购日期 - 开始日期。
    fullDire["lRepoDays"] = days;
    //将所有参数打包进directionParam对象
    for (var key in fullDire) {
        directionParam[key] = fullDire[key];
    }
    directionParam["instructCategory"] = "0";
    directionParam["instructCategory"] = "1"; //用来传给流程判断1、完整指令  0、询价指令
    directionParam["vcProcessStatus"] = "1"; //流程状态
    directionParam["lFixValidStatus"] = "0";//用于判断指令是否发送O32以及发送结果：0-未发送,1-修改后未发送,2-发送中,3-发送成功,4-发送失败
    directionParam["symbol"] = symbol; //申报代码
    directionParam["businClass"] = 2;  //	2 (业务类别:2-银行间二级市场业务 A –开放式基金B-存款业务C-网下申购D-债券一级市场)
    directionParam["vcInvestType"] = 1;  //	1(投资类型：交易所，1-可交易；2-持有到期；3-可供出售；回购业务投资类型为1-可交易，不传投资类型会根据系统数决定取组合的投资类型或缺省为1-可交易)
    directionParam["exdestination"] = "OTC";  //	OTC(交易市场:OTC 场外)
    directionParam["ordtype"] = 2;    //	2 (【前端设置2】 40-证券控制类型:1-金额控 、2-数量控、缺省按2-数量控)
    directionParam["vcFirstSettleMode"] = 3; //	3(【前端设置3】13204-结算方式（首次结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户)
    directionParam["vcMaturitySettleMode"] = 3; //	3(【前端设置3】13208-结算方式（到期结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户)
    directionParam["timeinforce"] = 6;  //	6(指令有效模式，默认为0-Day：0 – Day，当日有效；1 – GTC，一直有效，直到完成或撤销；6 – GTD，到指定日前有效)
    directionParam["vcInstructionlevel"] = 1;  //【前端设置】指令操作级别:0无 1快速 2一般 3慢速
    directionParam["judgeavailable"] = 1; //1(判断可用：0-不判；1-判)
    directionParam["judgerisk"] = 1;  //	1(判断风控：0-不判；1-判)
    directionParam["lMaturitySettleDate"] = DateUtil.toNumStr(directionParam["lMaturitySettleDate"]);
    directionParam["lFirstSettleDate"] = DateUtil.toNumStr(directionParam["lFirstSettleDate"]);
    directionParam["lTradeDate"] = DateUtil.toNumStr(directionParam["lTradeDate"]);
    directionParam["vcBizType"] = 6; //业务类型：6-银行间买断式回购
    directionParam["vcInstructType"] = 1; //(指令类型：1完整指令，2询价指令)
    directionParam["vcProductName"] = nui.get("vcProductCode").getText(); //组合名字
    var vcCombiCodeData = nui.get("vcCombiCode").getData();
    for(var i = 0;i<vcCombiCodeData.length;i++){
    	if(vcCombiCodeData[i].ID==nui.get("vcCombiCode").getValue()){
    		directionParam["lAssetId"] = vcCombiCodeData[i].L_ASSET_ID;
    		directionParam["vcAssetCode"] = vcCombiCodeData[i].VC_ASSET_NO;
    		directionParam["vcAssetName"] = vcCombiCodeData[i].VC_ASSET_NAME;
    	}
    }
    directionParam["vcCombiName"] = nui.get("vcCombiCode").getText(); //产品名字    
    directionParam["vcCounterpartyName"] = nui.get("vcCounterpartyId").getText();//交易对手名字
    directionParam["vcStockCode"] = symbol;
    directionParam["vcStockName"] = symbolName;
    directionParam["cOverdraft"] = cOverdraft;//是否可以透支
    directionParam["tradeQty"] = updateDireData ? updateDireData.enFullPriceAmount : 0;//为修改指令时，此指令所占用的可用金额
    directionParam["vcMarket"] = "5"; //市场编号
    return {instructParameter: directionParam, bonds: bondData};
}

//下达指令
function sendDirective() {
    var param = combiDireParam();
    if(!param){
        return false;
    }
    param.instructParameter["callRiskType"] = 2; //下达指令
    if(isUpdateDire){//修改指令
        param.instructParameter["operatorType"] = 1;
        param["srcInstruct"] = updateDireData;
    }
    //提交动作。
    var instructJson = {instructParameter: param.instructParameter, bonds: param.bonds};
    var url = "com.cjhxfund.ats.sm.comm.InstructionManager.insertInstruct.biz.ext";
    var successMsg = "指令下达成功";
    var errorMsg = "指令下达失败";
    if(isUpdateDire){//修改指令
    	successMsg = "指令修改成功";
    	errorMsg = "指令修改失败";
        url = "com.cjhxfund.ats.sm.comm.InstructionManager.insertAndUpdateInstruct.biz.ext";
        instructJson["srcInstruct"] = updateDireData;
    }
    
        a = nui.loading("正在处理中,请稍等...","提示");
        nui.ajax({
            url: url,
            type: 'POST',
            data: instructJson,
            cache: false,
            contentType: 'text/json',
            success: function (e) {
                nui.hideMessageBox(a);
                var returnJson = nui.decode(e);
                if(returnJson.exception == null){
                    if (returnJson.rtnCode == ATS_ERROR || returnJson.rtnCode == ATS_ORDER_OVER_DEAL_TIME){
                    	if(returnJson.rtnMsg != null){
                    		nui.alert(errorMsg+","+returnJson.rtnMsg,"提示");
                    	}else{
                    		nui.alert(errorMsg,"提示");
                    	}
                    } else {
                      //重置页面，刷新可用
                        if(isUpdateDire){
                        	nui.alert(successMsg,"提示",function(){
                        		CloseOwnerWindow();
                        	});
                        	return;
                        }
                        nui.alert(successMsg,"提示");
                        resetDire();
                        queryVisible(vunitstockGrid.data,vunitstockGrid,true);
                        getAviliable();
                    }
                }else{
                    nui.alert("系统异常","系统提示");
                }
            }
        
        });
    };

//重置按钮
var reset = function () {
    (new nui.Form("vunitstockCondition")).clear();
};
//页面X的删除功能
function onCloseClick(e) {
    var obj = e.sender;
    obj.setText("");
    obj.setValue("");
}
//回购方向变换颜色
function changeRed(e){
    if(e == "5"){
    	entrustDire = '5';
    	clearSelectedBonds();
    	//正回购查询我们的持仓。
    	vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.getFundBond.biz.ext?fundId="+fundCodeCombo2.getValue();
        $("#changeInfoL > label").css({"color":"red"});
    }else {
    	entrustDire = '6';
    	//逆回购查询所有银行间债券
    	vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.queryBankBetweenBondCode.biz.ext";
        $("#changeInfoL > label").css({"color":"green"});
    }
}

//利率框离开事件，计算利息和到期结算金额、到期全价、到期净价
function calEmFaceAmount() {
	var lContractPeriods = nui.get("lContractPeriods").getValue();//占款天数
	var value = nui.get("enRepoRate").getValue();
	if(!value || !lContractPeriods){
		return;
	}
	var row = bondsGrid.data[0];
	calNetFull(value,row["enFullPriceInit"],lContractPeriods,row["lNextPayintDate"],nui.get("lMaturitySettleDate").getValue(),
			row["enPayInteval"],row["enFaceRate"]);
};


//计算占款天数
function calPeriods(){
	var lTradeDate = nui.get('lFirstSettleDate').getValue();//首次结算日期
	var lMaturitySettleDate = nui.get('lMaturitySettleDate').getValue();
	if(!lTradeDate && !lMaturitySettleDate && lTradeDate ==="" && lMaturitySettleDate === ""){
		return false;
	}
	lTradeDate = lTradeDate.slice(0,lTradeDate.indexOf(" "));
	lTradeDate  = lTradeDate + " 00:00:00";
	var fDate = DateUtil.DstrToDate(lTradeDate);
	var mDate = DateUtil.DstrToDate(lMaturitySettleDate);
	var value = (mDate.getTime() - fDate.getTime())/86400000;//转换
	nui.get("lContractPeriods").setValue(parseInt(value));
	//重新计算到期全价、净价、利率。
	calEmFaceAmount();
}
//计算到期结算日、占款天数
var calMaturityDate = function (firstSettleDateStr, repurchDays) {
   if (!repurchDays || repurchDays == "") {
        return;
    }
    var firstSettleDate =DateUtil.DstrToDate(firstSettleDateStr);
    var firstSettleDateL = firstSettleDate.getTime();
    firstSettleDate = new Date(firstSettleDateL + (repurchDays * 24 * 60 * 60 * 1000));
    nui.ajax({
        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.getNextWorkDay.biz.ext",
        type: 'POST',
        data: {'param': {date: DateUtil.toNumStr(firstSettleDate), dateType: '00'}},//使用交易所日历
        cache: false,
        contentType: 'text/json',
        success: function (resp) {
            nui.get("lMaturitySettleDate").setValue(resp.workDay);
            //计算占款天数
            calPeriods();
        }
    });
    if(bondsGrid.data && bondsGrid.data.length > 0){
    	var row = bondsGrid.data[0];
    	if(!row.enNetPriceFinal){
    		return;
    	}
    	calcenFullPriceFinal(row.enNetPriceFinal,null,bondsGrid,row);
    }
    
};
//日期转换
var dateRen = function(e){
        var value = e.value;
        if (value) return nui.formatDate(value, 'yyyy-MM-dd');
        return "";
};
var setColor = function(){
    $("#vcEntrustDirection  label:first").css({
        "color":"red"
    });
    $("#vcEntrustDirection  label:last").css({
        "color":"green"
    });
};
//转换摘牌日期格式
function Delisting(e){
	if(e.value){
		return DateUtil.numStrToDateStr(e.value);
	}
	return "";
}
//重置指令信息
function resetDire(){
	nui.get("lRepoDays").setValue(null);
	nui.get("lMaturitySettleDate").setValue(null);
	nui.get("enSettleAmount").setValue(null);
	nui.get("lContractPeriods").setValue(null);
	nui.get("enRepoInterest").setValue(null);
	nui.get("vcCounterpartyId").setValue(null);
	nui.get("vcCounterpartyId").setText(null);
	nui.get("vcCounterpartyTrader").setValue(null);
	nui.get("vcRemark").setValue(null);
	nui.get("enRepoRate").setValue(null);
	nui.get("enFullPriceAmount").setValue(null);
	nui.get("vcCounterpartyOrgan").setValue(null);
	nui.get("vcEntrustDirection").setValue("5");
	nui.get("vcSettleSpeed").setValue("0");
	bondsGrid.clearRows();
}
//加载时执行
$(function(){
	//使用js动态调整布局宽度
	if(navigator.userAgent.indexOf("MSIE 8.0")>0){
		adjustAmountInfo();
	}
	//綁定債券查詢異步加載可用方法
	vunitstockGrid.on("load",function(){
	    	//成功查询后加载可用数据
	    	queryVisible(vunitstockGrid.data,vunitstockGrid,true);
	    	showDetail('vunitstockGrid');
	    	}
	);
	onHeaderShowDetail('vunitstockGrid',[undefined,undefined,undefined,'在那座阴雨的小城里','我从未忘记你','让我，感到为难的','是挣扎的自由']);
    //初始化设置颜色
    setColor();
    //初始化改变债券代码选择提示语句
    $("#bondCode>span>input").attr("placeholder","全部");
    
    //设置托管机构
    nui.get("vcPaymentPlace").load([{
        id:"01",
        name:"中央结算公司"
    },{
        id:"02",
        name:"上海清算所"
    }]);
    
  //默认交易日期和首次结算日期
    nui.get("lTradeDate").setValue(new Date());
	nui.get("lFirstSettleDate").setValue(new Date());
	
	//设置交易日限制
	limitTradeDate(null,"lTradeDate");
	
	//去掉No Result
	$("#vcCounterpartyId>span>input").attr("placeholder","对手中文或首位拼音...");
	$("#vcStockCode>span>input").attr("placeholder","请输入债券代码...");
	$("#vcStockCode2>span>input").attr("placeholder","请输入债券代码...");
	//获取fix转换机状态
	nui.ajax({
        url: "com.cjhxfund.ats.sm.comm.InstructionManager.getFixStatus.biz.ext",
        type: 'POST',
        data: "",
        success: function (resp) {
        	if(resp.fixStatus){
        		fixStatus = resp.fixStatus;
        	}
        }
	});
});