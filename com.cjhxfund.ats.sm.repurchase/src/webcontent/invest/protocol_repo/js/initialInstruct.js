/**
 * Created by luojuehuai on 2016/12/6.
 */
nui.parse();
/* ******************************************
 * 全局变量 start
 ********************************************/
var entrustDire = '15';//储存当前回购方向
var vunitstockGrid = nui.get("vunitstockGrid");//持仓Grid对象
var bondsGrid = nui.get("bondsGrid");//债券操作框对象
var maxRepurchAmount = 0; //最大可做回购金额
var isUpdateDire = false; //是否为修改指令
var updateDireData = null; //用于储存修改指令的数据
var isT0T1avail = true; //判断是否触发可用数量不足
var fundCodeData = {}; //缓存产品下拉列表里面的字段（通过键值对）
var bondCodeCombo = nui.get("bondCode");

/* ******************************************
 * 全局变量 end
 ********************************************/

/* ******************************************
 * 具体业务计算方法 start
 ********************************************/

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
        data: {'param': {date: DateUtil.toNumStr(firstSettleDate), dateType: '00'}}, //使用交易所日历
        cache: false,
        contentType: 'text/json',
        success: function (resp) {
            nui.get("lMaturitySettleDate").setValue(resp.workDay);
            //计算占款天数
            calPeriods();
            //计算利息和到期结算金额
            calEmFaceAmount();
        }
    });
};
//计算可做回购金额方法
function updateFaceAmout(e) {
    var row_uid = e.sender.ownerRowID;
    var value = e.sender.value;
    if (!value) {
        value = 0;
    }
    var row = bondsGrid.getRowByUID(row_uid);
    if (!ispositiveNum(value)) {
        nui.alert("必须为正数！");
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
    if (nui.get("vcEntrustDirection").getValue() === "15"  && fixStatus === "0") {
        if ((value * 100) > available) {
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
    row["enFaceAmount"] = value;
    if (!row["enMortagageRatio"]) {
        row["enMortagageRatio"] = 0;
    }
    var temp = mul(Number(value), div(Number(row["enMortagageRatio"]), 100));
    
    row["canRepurchaseAmount"] = temp.toFixed(6);
    bondsGrid.updateRow(row);
    calEmFaceAmount();
}
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
    if(value.indexOf(".") > 0 && (value.length - value.indexOf(".") - 1) > 2){
    	nui.alert("质押比例只能存在小数点后两位！");
        return;
    }
    var temp = mul(Number(row["enFaceAmount"]), div(Number(value), 100)).toString();
    var index = temp.indexOf(".");
    if (index != -1) {
        temp = temp.slice(0, index + 5);
    }
    row["canRepurchaseAmount"] = temp;
    bondsGrid.updateRow(row);
    calEmFaceAmount();
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


        //默认质押比率
        if (object["enCbValueNetValue"]) {
            var enCbValueNetValue = object["enCbValueNetValue"];
            var index = enCbValueNetValue.indexOf(".");
            if(index>0){
            	enCbValueNetValue = enCbValueNetValue.slice(0, index);
            	object["enMortagageRatio"] = enCbValueNetValue > 100 ? "100" : enCbValueNetValue.toString();
            }
        } else {
            object["enMortagageRatio"] = 0;
        }
        //计算可做回购金额
        object["canRepurchaseAmount"] = mul(div(object["enMortagageRatio"], 100), object["enFaceAmount"]);
        temp2.push(object);
    }
    return temp2;
};
//计算汇总行
function onDrawSummaryCell(e) {
    if (e.field === "vcStockName") {
        e.cellHtml = "<p style='color:#4DCE1D'>可做回购金额:</p>";
    }
    if (e.field === "enFaceAmount") {
        var data = e.data;
        var amount = 0;
        for (var i = 0; i < data.length; i++) {
            if (data[i].canRepurchaseAmount) {
                amount = add(amount,data[i].canRepurchaseAmount);
            }

        }
        maxRepurchAmount = amount;
        	nui.get("enFaceAmount").setValue(amount);
        isFirstAmount = true;
        e.cellHtml = "<p style='color:#4DCE1D'>" + amount + "  万元</p>";
        calEmFaceAmount();
    }

}
//计算利息和到期结算金额
function calEmFaceAmount() {
    var enFaceAmountVal = nui.get("enFaceAmount").getValue(); //回购金额
    if (!valiNum(enFaceAmountVal)) {
        return;
    }
    enFaceAmountVal = Number(enFaceAmountVal);

    var enRepoRateVal = nui.get("enRepoRate").getValue();//回购利率
    if (!valiNum(enFaceAmountVal)) {
        return;
    }
    enRepoRateVal = Number(enRepoRateVal);

    var enRepoInterest = nui.get("enRepoInterest");
    var lRepoDays = nui.get("lContractPeriods").getValue(); //占款天数
    if(!ispositiveNum(lRepoDays)){
    	return false;
    }
    //利息
    var interest = (div(mul(mul(div(enRepoRateVal, 100), enFaceAmountVal), lRepoDays), 365) * 10000).toFixed(2);
    
    enRepoInterest.setValue(interest);
    //到期结算金额
    var amount = add(interest, enFaceAmountVal * 10000);
    amount = amount.toString();
    var temp2 = amount.indexOf('.');
    if (temp2 > 0) {
        amount = amount.slice(0, temp2 + 3);
        
    }
    nui.get("enSettleAmount").setValue(amount);
};
//质押券操作框删除列
function onActionRenderer(e) {
    var record = e.record;
    	return ' <a href="javascript:removeSelectedBonds(\'' + record._uid + '\')">删除</a>';
    
}

//联动方法
var selectFund = function (e) {
	fundCodeData = fundCodeCombo.data;
    var id = fundCodeCombo.getValue();
    var text = fundCodeCombo.getText();
    //
    fundCodeCombo2.setValue(id);
    fundCodeCombo2.setText(text);
  //增加手动添加债券查询条件：fundId
	vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.GetSSFundBond.biz.ext?fundId="+id;
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
    if(entrustDire == "15"){
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
	vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.GetSSFundBond.biz.ext?fundId="+id;
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
    var temp = {"vcAccount": combiData, "exdestination": 'SS'};//上交所为SS
    ids.push(temp);
    var sendMsg = {combis: ids};
    nui.ajax({
        data: {"sendMsg": sendMsg},
        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.getFundInfo.biz.ext",
        success: function (resp) {
            if(resp.avaiList.length>0){
            	var updateAmont = 0;
            	//修改指令时，原指令为有效的融券指令，且查询对象的资产单元与原指令为同一资产单元
            	if(updateDireData != null && updateDireData.cIsValid=="1" && resp.avaiList[0].VC_TASSET == updateDireData.vcAssetCode && updateDireData.vcEntrustDirection=="16"){
            		var now =  DateUtil.toNumStr(new Date());
            		var now1 = DateUtil.toNumStr(new Date(new Date().getTime()+24*60*60*1000));
            		//原指令的交易日为今天的指令或者交易日为明天的t+0指令在需改时需要将资金加回
            		if(updateDireData.lTradeDate == now || (updateDireData.lTradeDate == now1 && updateDireData.vcSettleSpeed == "0")){
            			updateAmont = parseFloat(updateDireData.enFaceAmount)*10000;
            		}
            	}
            	nui.get("vcAvailableamountT0").setValue(resp.avaiList[0].VC_AVAILABLEAMOUNT_T0+updateAmont);
                nui.get("vcAvailableamountT1").setValue(resp.avaiList[0].VC_AVAILABLEAMOUNT_T1+updateAmont);
            	
            }
        },
        //有错误码之后，把后面的错误提醒补齐。
        fail: function (resp) {
            alert(resp);
        }

    });

};

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
        vcMarket:condition.vcMarket,
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
        data: {'vunitstockLists': VunitData,"vcMarket":'SS'},
        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.queryVisible.biz.ext",
        success: function (resp) {
        	var avaiList = resp.avaiList;
        	if(isUpdate){
        		for(var i =0;i<VunitData.length;i++){
            		var row = VunitData[i];
            		for(var j =0;j<avaiList.length;j++){
            			var ava = avaiList[j];
            			var pledgeCount = 0;
            			if(row.vcCombiCode==ava.VC_ACCOUNT && row.vcReportCode == ava.VC_SYMBOL){
            				if(isUpdateDire && updateDireData.cIsValid=="1" && updateDireData.vcEntrustDirection=="15"){
            					var bondsTemp = updateDireData.bonds;
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
            				if(ava.VC_AVAILABLEQUANTITY_T0+pledgeCount>0){
            					VunitData[i].vcAvailablequantityT0 = ava.VC_AVAILABLEQUANTITY_T0+pledgeCount;
            				}else{
            					VunitData[i].vcAvailablequantityT0 = 0;
            				}
            				if(ava.VC_AVAILABLEQUANTITY_T1+pledgeCount>0){
            					VunitData[i].vcAvailablequantityT1 = ava.VC_AVAILABLEQUANTITY_T1+pledgeCount;
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
            			var pledgeCount = 0;
            			if(row.vcCombiCode==ava.VC_ACCOUNT && row.vcReportCode == ava.VC_SYMBOL){
            				if(isUpdateDire && updateDireData.cIsValid=="1" && updateDireData.vcEntrustDirection=="15"){
            					var bondsTemp = updateDireData.bonds;
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
            				if(ava.VC_AVAILABLEQUANTITY_T0+pledgeCount>0){
            					VunitData[i].vcAvailablequantityT0 = ava.VC_AVAILABLEQUANTITY_T0+pledgeCount;
            				}else{
            					VunitData[i].vcAvailablequantityT0 = 0;
            				}
            				if(ava.VC_AVAILABLEQUANTITY_T1+pledgeCount>0){
            					VunitData[i].vcAvailablequantityT1 = ava.VC_AVAILABLEQUANTITY_T1+pledgeCount;
            				}else{
            					VunitData[i].vcAvailablequantityT1 = 0;
            				}
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
	if(!checkO32Exist({vcStockCode:vcStockCode,vcMarketNo:'1'})){
		nui.alert("O32不存在此债券");
		return;
	}
    nui.ajax({
        data: {param:{'vcStockCode':vcStockCode,'vcCombiNo':vcCombiNo,'vcMarketNo':'1'}},
        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.QuerySSBondInfo.biz.ext",
        success: function (resp) {
        	var bonds = resp.bonds;
            if (bonds && bonds.length>0) {
            	if(nui.get("vcEntrustDirection").getValue() == '15'){
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

//导入选择债券，要加去重功能
//选择债券方法
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
    var firstRow = bondsGrid.data[0];
    var bool = true;
    var idStr = "canRepAmountZ";
    var remindStr = "";
    //判断是否重复
    var bondsData = bondsGrid.data;
    if(bondsData.length>=5){
    	mini.showTips({
            content: "所选质押券不能超过5条！",
            state: "danger",
            x: "top",
            y: "top",
            timeout: 3000
        });
	return;
    }
    for(var b = 0;b<rows.length;b++){
    	//不能选择PPN类型的债券
    	var vcStockName = rows[b].vcStockName;
    	if(vcStockName && (vcStockName.indexOf("PPN")>=0 || vcStockName.indexOf("ABN")>=0)){
    		bool = false;
    		remindStr = remindStr + "<br/>不能选择PPN、ABN类型债券！("+ rows[b].vcReportCode +")";
            break;
    	}
    	for(var c = 0;c<bondsData.length;c++){
    		var r = rows[b];
    		var bon = bondsData[c];
    		if((r.vcStockCode === bon.vcStockCode) &&  (r.vcExchange === bon.vcExchange)){
    			bool = false;
    			remindStr = remindStr + "<br/>不能重复选择债券！("+ rows[c].vcReportCode +")";
                break;
    		}
    	}
    }
    if(!bool){
    	nui.alert(remindStr,"系统提示");
    	return false;
    }
    if(rows[0].vcDepository !== "01"){
        idStr = "canRepAmountS";
    }

    
    bondsGrid.addRows(rows, 0);
    //计算可正回购金额（中债）（上清）
    deposit = idStr;
    vunitstockGrid.clearSelect(true);
};
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
//组装完整指令参数
function combiDireParam(){
    var bondData = bondsGrid.data;
    if ((nui.get("vcEntrustDirection").getValue() == "15")  && (bondData.length < 1 || bondData[0].enFaceAmount <= 0)) {
        nui.alert("您没有选择任何可质押的债券。或者债券数量为0。", "警告");
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
    					 setDataBonds[s]["enMortagageRatio"] != bondsGrid.data[s]["enMortagageRatio"] ||
    					 setDataBonds[s]["vcReportCode"] != bondsGrid.data[s]["vcReportCode"]){
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
    	if(fullDire.vcEntrustDirection === "15"){
            if(!isT0T1avail){
            	nui.alert("存在可用数量不足的债券，请在左边操作栏重新输入相应券面金额！", "警告");
                return false;
            }
        }else{
        	if((fullDire.enFaceAmount * 10000) > avaiAmount){
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
    //回购天数 = 回购日期 - 开始日期。
    fullDire["lRepoDays"] = days;
    //将所有参数打包进directionParam对象
    for (var key in fullDire) {
        directionParam[key] = fullDire[key];
    }
    directionParam["instructCategory"] = "1"; //用来传给流程判断1、完整指令  0、询价指令
    directionParam["vcProcessStatus"] = "1"; //流程状态
    directionParam["lFixValidStatus"] = "0";//用于判断指令是否发送O32以及发送结果：0-未发送,1-修改后未发送,2-发送中,3-发送成功,4-发送失败
    directionParam["symbol"] = symbol; //申报代码
    directionParam["businClass"] = 2;  //	2 (业务类别:2-银行间二级市场业务 A –开放式基金B-存款业务C-网下申购D-债券一级市场)
    directionParam["vcInvestType"] = 1;  //	1(投资类型：交易所，1-可交易；2-持有到期；3-可供出售；回购业务投资类型为1-可交易，不传投资类型会根据系统数决定取组合的投资类型或缺省为1-可交易)
    directionParam["exdestination"] = "SS";  //	SS (上交所)
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
    directionParam["vcBizType"] = 7; //业务类别：1-银行间二级交易，2-上海大宗交易，3-上海固收平台，4-深圳综合协议平台，5-银行间质押式回购，6-银行间买断式回购，7-交易所协议式回购
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
    directionParam["vcCombiName"] = nui.get("vcCombiCode").getText(); //组合名字    
    directionParam["vcCounterpartyName"] = nui.get("vcCounterpartyId").getText();//交易对手名字
    directionParam["vcCombiName"] = nui.get("vcCombiCode").getText(); //产品名字    
    directionParam["vcStockCode"] = symbol;
    directionParam["vcStockName"] = symbolName;
    directionParam["cOverdraft"] = cOverdraft;//是否可以透支
    directionParam["tradeQty"] = updateDireData ? updateDireData.enFaceAmount : 0;//为修改指令时，此指令所占用的可用金额
    directionParam["vcMarket"] = "SS"; //市场编号
    return {instructParameter: directionParam, bonds: bondData};
}

//下达指令
function sendDirective() {
    var param = combiDireParam();
    if(!param){
        return false;
    }
    param.instructParameter["callRiskType"] = 2; //下达指令
    var url = "com.cjhxfund.ats.sm.comm.InstructionManager.insertInstruct.biz.ext";
    if(isUpdateDire){//修改指令
        param.instructParameter["operatorType"] = 1;
        param["srcInstruct"] = updateDireData;
        url = "com.cjhxfund.ats.sm.comm.InstructionManager.insertAndUpdateInstruct.biz.ext";
    }
    a = nui.loading("正在处理中,请稍等...","提示");
    nui.ajax({
        url: url,
        type: 'POST',
        data: param,
        cache: false,
        contentType: 'text/json',
        success: function (e) {
            if(e.exception == null){
                if (e.rtnCode == ATS_ERROR)
                {
                    nui.alert("指令下达失败","提示");
                } else if(e.rtnCode == '0202'){
                    nui.alert(e.rtnMsg,"提示");
                }else{
                	if(isUpdateDire){
                       	nui.alert("指令下达成功","提示",function(){
                       		CloseOwnerWindow();
                       		return;
                       	});
                       }else{
                    	   nui.alert("指令下达成功","提示");
                       }
                     //重置页面，刷新可用
                       resetDire();
                       queryVisible(vunitstockGrid.data,vunitstockGrid,true);
                       getAviliable();
                }
                
            }else{
                nui.alert("系统异常","系统提示");
            }
            nui.hideMessageBox(a);
        }
    });
}


//重置按钮
var reset = function () {
    (new nui.Form("vunitstockCondition")).clear();
};
//报价方式
var changeMode = function(){
    var value =  nui.get("vcQuoteMode").getValue();
    if(value === "1"){//固定利率
        //显示
        $("#enRepoRateLabel").show("fast");
        nui.get("enRepoRate").show();
        //隐藏
        $("#enWeightingValueLabel").hide();
        nui.get("enWeightingValue").hide();
    }else if(value === "2"){//加权加点
        //显示
        $("#enRepoRateLabel").hide();
        nui.get("enRepoRate").hide();
        //隐藏
        $("#enWeightingValueLabel").show("fast");
        nui.get("enWeightingValue").show();
        var enRepoInterest = nui.get("enRepoInterest");
        var interest = enRepoInterest.getValue();
        var enSettleAmount = nui.get("enSettleAmount");
        enSettleAmount.setValue(enSettleAmount.getValue() - interest);
        enRepoInterest.setValue("");
        nui.get("enRepoRate").setValue("");
        
    }
};

//回购方向变换颜色
function changeRed(e){
    if(e == "15"){
    	entrustDire = '15';
    	clearSelectedBonds();
    	//正回购查询我们的持仓。
    	vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.GetSSFundBond.biz.ext?fundId="+fundCodeCombo2.getValue();
        $("#changeInfoL > label").css({"color":"red"});
    }else {
    	entrustDire = '16';
    	//逆回购查询所有银行间债券
    	vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.querySHBondCode.biz.ext";
        $("#changeInfoL > label").css({"color":"green"});
    }
}

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
	calEmFaceAmount();
}
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
	nui.get("enFaceAmount").setValue(null);
	nui.get("enRepoInterest").setValue(null);
	nui.get("vcCounterpartyId").setValue(null);
	nui.get("vcCounterpartyId").setText(null);
	nui.get("vcCounterpartyTrader").setValue(null);
	nui.get("vcRemark").setValue(null);
	nui.get("enRepoRate").setValue(null);
	nui.get("enWeightingValue").setValue(null);
	nui.get("vcCounterpartyOrgan").setValue(null);
	nui.get("vcQuoteMode").setValue("1");
	nui.get("vcEntrustDirection").setValue("15");
	nui.get("vcSettleSpeed").setValue("0");
	changeMode();
	bondsGrid.clearRows();
}
function vcExchangeRD(e){
	if(e.value == '1'){
		return "上交所";
	}else if(e.value == "2"){
		return "深交所";
	}else{
		return "";
	}
}
/* ******************************************
 * 具体业务计算方法 end
 ********************************************/



/* ******************************************
 * 本页面校验方法 start
 ********************************************/
var positiveFloProtocol = function(e){
	var reg = /^[0-9]+(.[0-9]{1,3})?$/;//小数点后三位的正实数
	if (!reg.test(e.value) || e.value > 100000){
		e.errorText = "必须输入小于十万的正数，且小数点只能保留后三位！";
        e.isValid = false;
	}else{
		
	}
};
/* ******************************************
 * 本页面校验方法 end
 ********************************************/

/* ******************************************
 * 页面初始化方法 start
 ********************************************/
$(function(){
	//使用js动态调整布局宽度
	if(navigator.userAgent.indexOf("MSIE 8.0")>0){
		adjustAmountInfo();
	}
	//綁定債券查詢異步加載可用方法
	vunitstockGrid.on("load",function(){
	    	//成功查询后加载可用数据
	    	queryVisible(vunitstockGrid.data,vunitstockGrid,true);
	    }
	);
    //初始化设置颜色
    setColor();
    //初始化改变债券代码选择提示语句
    $("#bondCode>span>input").attr("placeholder","全部");
   
    //默认交易日期和首次结算日期
    //修改指令的话，不需要默认
    if(!isUpdateDire){
    	nui.get("lTradeDate").setValue(new Date());
    	nui.get("lFirstSettleDate").setValue(new Date());
    }
    //设置交易日限制
	limitTradeDate(null,"lTradeDate");
	//去掉No Result
    $("#fundCodeName>span>input").attr("placeholder","请输入产品代码或产品名称...");
	$("#vcProductCode>span>input").attr("placeholder","请输入产品代码或产品名称...");
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
/* ******************************************
 * 页面初始化方法 end
 ********************************************/