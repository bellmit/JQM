/**
 * 
 */
var fundCodeCombo = null;
var vcCombiCombo = null;
var entrustDire = '5';//储存当前回购方向
var fundCodeData = {};
var bondsGrid = null;
var isUpdateDire = false; //是否为修改指令
var updateDireData = null; //用于储存修改指令的数据
var isT0T1avail = true; //判断是否触发可用数量不足

function weightValueVali(e){
	 var reg = /^[0-9]+(\.[0-9]{1,4})?$/;//正正数
	    if (!reg.test(e.value) || e.value.length > 8) {
	    	e.errorText = "加点PB只能为小于8位的正数！";
		 	e.isValid = false;
	    }
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
        isEnFaceAmountRight = false;
        return;
    }
    if (value > 100) {
    	nui.alert("质押比例不能大于100！");
    	isEnFaceAmountRight = false;
        return;
    }
    if(value.indexOf(".") > 0 && (value.length - value.indexOf(".") - 1) > 2){
    	nui.alert("质押比例只能存在小数点后两位！");
    	isEnFaceAmountRight = false;
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
//首次结算日期计算
var calFirstMaturityRe = function () {
    var lTradeDateValue = nui.get("lTradeDate").getValue();//交易日期
    var lFirstSettleDate = lTradeDateValue;//首次结算日期
    var lRepoDays = nui.get("lRepoDays").getValue();//回购天数
    if(!ispositiveNum(lRepoDays)){
    	lRepoDays = 0;
    }
    if (nui.get("vcSettleSpeed").getValue() == "1") {
    	var settleSpeed = 1;
    	if(isNotTradeDate(lTradeDateValue,"00")){
			settleSpeed = 0;
		}
        nui.ajax({
            url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.calMaturitySettleDate.biz.ext",
            type: 'POST',
            data: {firstSettleDate: DateUtil.toNumStr(lTradeDateValue), repoDays: settleSpeed, dateType: '00'},//使用交易所日历
            cache: false,
            contentType: 'text/json',
            success: function (resp) {
                lFirstSettleDate = resp.maturitySettleDate;
                nui.get("lFirstSettleDate").setValue(resp.maturitySettleDate);
                var temp = DateUtil.numStrToDateStr(lFirstSettleDate);
                calMaturityDate(temp, lRepoDays);
              //限制到期结算日期
                limitTradeDate(temp,"lMaturitySettleDate");
            }
        });
    } else {
        nui.get("lFirstSettleDate").setValue(lFirstSettleDate);
        calMaturityDate(lFirstSettleDate, lRepoDays);
      //限制到期结算日期
        limitTradeDate(lFirstSettleDate,"lMaturitySettleDate");
    }
    
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
    }else if(value > 1000000000){
    	nui.alert("券面金额不能超过十亿！");
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
    if (nui.get("vcEntrustDirection").getValue() === "5"  && fixStatus === "0") {
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
    var temp = mul(Number(value), div(Number(row["enMortagageRatio"]), 100)).toString();
    var index = temp.indexOf(".");
    if (index != -1) {
        temp = temp.slice(0, index + 5);
    }
    row["canRepurchaseAmount"] = temp;
    bondsGrid.updateRow(row);
    calEmFaceAmount();
}
//删除已选择的债券
var removeSelectedBonds = function (id) {
    bondsGrid.removeRow(bondsGrid.getRowByUID(id));
};
//质押券操作框删除列
function onActionRenderer(e) {
    var record = e.record;
    	return ' <a href="javascript:removeSelectedBonds(\'' + record._uid + '\')">删除</a>';
    
}
//计算汇总行
function onDrawSummaryCell(e) {
    
    if (e.field === "vcDepository") {
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
        $("#MaxRepurchAmount").text("可做回购金额:" + formatNumber(amount,4,1) + "万元");
        calEmFaceAmount();
    }

}
//设置选中债券
var setChooseBond = function(bondData){
	bondsGrid.addRows(bondData, 0);
};
function fundCodeCache(){
	var temp = null;
	    if(fundCodeData && fundCodeData.length>0){
	    	temp = nui.clone(fundCodeData);
	    }else{
	    	temp  = nui.clone(fundCodeCombo.data);
	        
	    }
	    var length = temp.length;
        for(var i = 0 ;i<length;i++){
            fundCodeData[temp[i].VC_PRODUCT_CODE] = temp[i];
        }
    return fundCodeData;
}
//选中产品触发动作
var selectFund = function(e){
//	fundCodeData = fundCodeCombo.data;
	var id = fundCodeCombo.getValue();
	if(entrustDire === '5'){
		//增加手动添加债券查询条件：fundId
		vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.getFundBond.biz.ext?fundId="+id;
	}
    $.ajax({
        data: {vcProductCode: id, queryType: "'03'"},
        url: "com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfoByProductCodeAndRealType.biz.ext",
        success: function (resp) {
            vcCombiCombo.setValue("");
            if (resp.data) {
                vcCombiCombo.load(resp.data);
                vcCombiCombo.select(0);
                vcCombiCombo.doValueChanged();
                //获取可用
                getAviliable();
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
            	nui.get("vcAvailableamountT0").setValue(formatNumber(vcAvailableamountT0,2,1));
                nui.get("vcAvailableamountT1").setValue(formatNumber(vcAvailableamountT1,2,1));
            }
        },
        //有错误码之后，把后面的错误提醒补齐。
        fail: function (resp) {
            alert(resp);
        }
    });
};

//查询基金净资产
var getEnFundValue = function(){
    var fundId = fundCodeCombo.getValue();
    if(fundId){
    	var temp = fundCodeCache();
    	if(temp.length>0){
    		var productId = fundCodeCache()[fundId]["L_PRODUCT_ID"];
            nui.ajax({
                data: {"fundId": productId},
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
    	}
    }
};

//回购方向变换颜色
function changeRed(e){
	var combiId = vcCombiCombo.getValue();
    if(e === "5"){
    	entrustDire = '5';
    	clearSelectedBonds();
    	vcStockCodeAuto.setValue(null);
    	vcStockCodeAuto.setText("");
    	if(combiId){
    		//正回购查询我们的持仓。
        	vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.getFundBond.biz.ext?fundId="+fundCodeCombo.getValue();
    	}else{
        	vcStockCodeAuto.url = "";
    	}
        $("#vcEntrustDirectionLab:not(span)").css({"color":"red"});
    }else{
    	entrustDire = '6';
    	vcStockCodeAuto.setValue(null);
    	vcStockCodeAuto.setText("");
    	//逆回购查询所有银行间债券
    	vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.queryBankBetweenBondCode.biz.ext";
        $("#vcEntrustDirectionLab:not(span)").css({"color":"green"});
    }
}
//清空已选择的债券
var clearSelectedBonds = function () {
    bondsGrid.clearRows();
};
var setColor = function(){
    $("#vcEntrustDirection  label:first").css({
        "color":"red"
    });
    $("#vcEntrustDirection  label:last").css({
        "color":"green"
    });
};
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
//计算利息和到期结算金额
function calEmFaceAmount() {
    var enFaceAmountVal = nui.get("enFaceAmount").getValue(); //回购金额
    if (!valiNum(enFaceAmountVal)) {
        return;
    }
    enFaceAmountVal = Number(enFaceAmountVal);

    var enRepoRateVal = nui.get("enRepoRate").getValue();//回购利率
    if (!enFaceAmountVal && !valiNum(enFaceAmountVal)) {
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
    if(nui.get("vcQuoteMode").getValue() === '1'){
    	enRepoInterest.setValue(interest);
    }else{
    	enRepoInterest.setValue(null);
    }
    
    //到期结算金额
    var amount = add(interest, enFaceAmountVal * 10000);
    amount = amount.toString();
    var temp2 = amount.indexOf('.');
    if (temp2 > 0) {
        amount = amount.slice(0, temp2 + 3);
        
    }
    nui.get("enSettleAmount").setValue(amount);
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
        nui.get("enWeightingValue").setValue(null);
    }else if(value === "2"){//加权加点
        //显示
        $("#enRepoRateLabel").hide();
        nui.get("enRepoRate").hide();
        //隐藏
        $("#enWeightingValueLabel").show("fast");
        $("#enWeightingValue").show().css({'width':'100%'});
        var enRepoInterest = nui.get("enRepoInterest");
        var interest = enRepoInterest.getValue();
        var enSettleAmount = nui.get("enSettleAmount");
        enSettleAmount.setValue(enSettleAmount.getValue() - interest);
        enRepoInterest.setValue(null);
        nui.get("enRepoRate").setValue("");
    }
};

//组装下达询价指令参数
function combiDireParam(){
    var bondData = bondsGrid.data;
    if (bondData.length < 1) {
        mini.showTips({
            content: "您没有选择任何可质押的债券！",
            state: "danger",
            x: "top",
            y: "top",
            timeout: 3000
        });
        return false;
    }else if(bondData.length > 15){
    	mini.showTips({
            content: "最多只能选择十五条债券！",
            state: "danger",
            x: "top",
            y: "top",
            timeout: 3000
        });
	return;
    }
    var zeroBonds = false;
    for(var b = 0;b<bondData.length;b++){
    	if(bondData[b].enFaceAmount <= 0){
    		zeroBonds = true;
    	}
    }
    if(zeroBonds){
    	nui.alert("有债券的可用数量为0。","警告");
    	return;
    }
    if(!symbol){
    	nui.alert("O32系统无该回购期限（天）对应的证券代码，请联系交易员先新增该回购期限对应的证券代码。","警告");
    	return;
    }
    var enMortagageRatioRight = true; 
    for(var d = 0;d < bondData.length;d++){
    	var enMortagageRatio = bondData[d].enMortagageRatio;
    	if (!ispositiveFlo(enMortagageRatio)) {
    		enMortagageRatioRight = false;
    		break;
        }
        if (enMortagageRatio > 100) {
        	enMortagageRatioRight = false;
        	break;
        }
        if(enMortagageRatio.toString().indexOf(".") > 0 && (enMortagageRatio.toString().length - enMortagageRatio.toString().indexOf(".") - 1) > 2){
        	enMortagageRatioRight = false;
        	break;
        }
    }
    if(enMortagageRatioRight === false){
    	mini.showTips({
            content: "质押比率不正确！",
            state: "danger",
            x: "top",
            y: "top",
            timeout: 3000
        });
    	return;
    }
    var bondEnFaceAmountRight = true;
    for(var c = 0;c < bondData.length;c++){
    	if(bondData[c].enFaceAmount%10 !== 0){
    		bondEnFaceAmountRight = false;
    		break;
    	}
    }
if(bondEnFaceAmountRight === false){
	mini.showTips({
        content: "券面金额必须为10的整数倍！",
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
    		 //nui.alert("您没有修改任何指令要素，可以不用提交噢。");
    		 //return false;
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
        			mini.showTips({
 			            content: "回购金额已超过当前可用金额！",
 			            state: "success",
 			            x: "top",
 			            y: "top",
 			            timeout: 3000
 			        });
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
    directionParam["instructCategory"] = "0"; //用来传给流程判断1、完整指令  0、询价指令
    directionParam["vcProcessStatus"] = "-1"; //流程状态
    directionParam["cIsValid"] = "1"; //有效状态
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
    directionParam["vcBizType"] = 5; //业务类别：1-银行间二级交易，2-上海大宗交易，3-上海固收平台，4-深圳综合协议平台，5-银行间质押式回购，6-银行间买断式回购，7-交易所协议式回购
    directionParam["vcInstructType"] = 2; //(指令类型：1完整指令，2询价指令)
    directionParam["enPrice"] = 100.0000; //(指令价格)
//    var vcProductData = nui.get("vcProductCode").getData();
//    for(var j = 0;j<vcProductData.length;j++){
//    	if(vcProductData[j].ID==nui.get("vcProductCode").getValue()){
//    		directionParam["lProductId"] = vcProductData[j].L_PRODUCT_ID;
//    	}
//    }
    directionParam["lProductId"] = fundCodeData[nui.get("vcProductCode").getValue()]['L_PRODUCT_ID'];
    directionParam["vcProductName"] = nui.get("vcProductCode").getText(); //组合名字
    var vcCombiCodeData = nui.get("vcCombiCode").getData();
    for(var i = 0;i<vcCombiCodeData.length;i++){
    	if(vcCombiCodeData[i].ID==nui.get("vcCombiCode").getValue()){
    		directionParam["lAssetId"] = vcCombiCodeData[i].L_ASSET_ID;
    		directionParam["vcAssetCode"] = vcCombiCodeData[i].VC_ASSET_NO;
    		directionParam["vcAssetName"] = vcCombiCodeData[i].VC_ASSET_NAME;
    		directionParam["lCombiId"] = vcCombiCodeData[i].L_COMBI_ID;
    	}
    }
    directionParam["vcCombiName"] = nui.get("vcCombiCode").getText(); //组合名字    
    directionParam["vcCounterpartyName"] = nui.get("vcCounterpartyId").getText();//交易对手名字
    //判断交易对手是否是自己手动输入
	if(directionParam["vcCounterpartyId"] == directionParam["vcCounterpartyName"]){
		directionParam["vcCounterpartyId"] = "";
	}
    directionParam["vcCombiName"] = nui.get("vcCombiCode").getText(); //产品名字    
    directionParam["vcStockCode"] = symbol;
    directionParam["vcStockName"] = symbolName;
    directionParam["vcStockInnerCode"] = symbolInterCode;
    directionParam["cOverdraft"] = cOverdraft;//是否可以透支
    directionParam["tradeQty"] = updateDireData ? updateDireData.enFaceAmount : 0;//为修改指令时，此指令所占用的可用金额
    directionParam["vcMarket"] = "5"; //市场编号
    //逆回购调整组合
    if(directionParam["vcEntrustDirection"] === "6"){
    	for(var e = 0;e<bondData.length;e++){
    		bondData[e].vcProductCode = directionParam["vcProductCode"];
    		bondData[e].vcFundCode = directionParam["vcProductCode"];
    		bondData[e].vcCombiCode = directionParam["vcCombiCode"];
    	}
    }
    
    if(inquiryOperator == "updInquiryResult"){
		return {instructParameter:directionParam, bonds: bondData, inquiryOperator:inquiryOperator, srcInstruct:updateDireData};
	}else{
		if(updateDireData.cIsValid=="0" && updateDireData.lResultId!=null){//修改指令/建议
			directionParam["lResultId"] = updateDireData.lResultId;
	    }
		return {instructParameter:directionParam, bonds: bondData, inquiryOperator:inquiryOperator};
	}
}


/**风控管理开始**/
function subData(riskReturn, instructJson){
	checkEditToRisk(riskReturn);
	var riskFlag = showRiskInfo(riskReturn, instructJson, "1");
	riskControl(riskFlag, instructJson);
}
function riskControl(riskFlag, instructJson){
	riskFlagParam = riskFlag;
	lResultIdParam = instructJson.instructParameter.lResultId;
	lRiskmgrIdParam = instructJson.instructParameter.lRiskmgrId;
	if(riskFlag=='-1'){
		return;
	}else if(riskFlag=='1'){
		formalInstructionEntry(instructJson);
	}else if(riskFlag=='2'){
		formalInstructionEntry(instructJson);
	}
}
function formalInstructionEntryFinish(){
	if(riskFlagParam=='2'){
		startRiskProcessInstruct(lResultIdParam, lRiskmgrIdParam);
	}
	if(inquiryOperator == "updInquiryResult"){	//指令修改
		updateRiskStatus("", "", updateDireData.lResultId, "4");
	}
	CloseOwnerWindow("ok");
}
/**风控管理结束**/


//下达指令
function sendDirective() {
    var param = combiDireParam();
    if(!param){
        return false;
    }
    param.instructParameter["operatorType"] = 1; //修改
    param.srcInstruct = updateDireData;
    
    
    if(judgeRiskTest(null, param.instructParameter)){	//判断是否接入风控管理
    	checkRiskInfo(param);//riskMgrComm.js的方法
    	return;
    }
    
    
    var a = nui.loading("正在处理中,请稍等...","提示");
    nui.ajax({
		url: "com.cjhxfund.ats.sm.inquiry.inquiryInstruction.submitRiskTrail.biz.ext",
        type: 'POST',
        data: param,
        cache: false,
        contentType: 'text/json',
        success: function (text) {
        	nui.hideMessageBox(a);
        	var returnJson = nui.decode(text);
        	if(returnJson.exception == null){
        		if(returnJson.rtnCode == ATS_SUCCESS){
        			nui.alert("询价结果提交成功！","提示",function(){
        				CloseOwnerWindow("ok");
                    });
        		}else if(returnJson.rtnCode == ATS_ERROR || returnJson.rtnCode == "203"){
        			nui.alert(returnJson.rtnMsg,"系统提示");
        		}else if(returnJson.rtnCode == "302"){//可用不足,继续下单先校验风控
        			nui.confirm(returnJson.rtnMsg+"</br>是否继续下单？","提示", function(action){
                		if(action == "ok") {
                			formalInstructionEntry(param);
                        }
                	});
        		}else if(returnJson.rtnCode == ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT){
//        			if(param.instructParameter["vcEntrustDirection"]=="5"){
//        				nui.alert(returnJson.rtnMsg,"系统提示");
//        			}else{
        				nui.confirm(returnJson.rtnMsg+"</br>是否继续下单？","提示", function(action){
                    		if(action == "ok") {
                    			formalInstructionEntry(param);
                            }
                    	});
//        			}
        		}else if(returnJson.rtnCode == "301"){
        			var riskInfo = returnJson.riskMsg;
        			riskInfo["alertMsg"]=returnJson.rtnMsg;
        			nui.open({
                        url: nui.context + "/fix/riskControlDetailList.jsp",
                        title: "风险提示",
                        width: 800,
                        height: 422,
                        onload: function(){
                            var iframe = this.getIFrameEl();
                            if(param.instructParameter["vcEntrustDirection"]=="5"){
                            	iframe.contentWindow.SetData(riskInfo,2);
                            }else{
                            	iframe.contentWindow.SetData(riskInfo,1);
                            }
                        },
                        ondestroy: function (action) {
                        	if (action == "ok") {
                                formalInstructionEntry(param);
                            }
                        }
                    });
        		}else{//触发风控，弹出风险提示框，展示风险信息
        			var riskInfo = returnJson.riskMsg;
        			nui.open({
                        url: nui.context + "/fix/riskControlDetailList.jsp",
                        title: "风险提示",
                        width: 800,
                        height: 380,
                        onload: function(){
                            var iframe = this.getIFrameEl();
                            iframe.contentWindow.SetData(riskInfo,1);
                        },
                        ondestroy: function(action) {
                            if (action == "ok") {
                                formalInstructionEntry(param);
                            }
                        }
                    });
        		}
        	}else{
        		nui.alert("系统异常","系统提示");
        	}
        }
    });
}

function formalInstructionEntry(param){
	var url = "com.cjhxfund.ats.sm.inquiry.inquiryInstruction.insertInquiryResult.biz.ext";
	if(inquiryOperator == "updInquiryResult"){
		url = "com.cjhxfund.ats.sm.comm.InstructionManager.insertAndUpdateInstruct.biz.ext";
	}else if(inquiryOperator == "updSaveInquiryResult"){
		url = "com.cjhxfund.ats.sm.inquiry.inquiryInstruction.updateInquiryResult.biz.ext";
	}
	var a = nui.loading("正在处理中,请稍等...","提示");
	nui.ajax({
	    url: url,
	    type: 'POST',
	    data: param,
	    cache: false,
	    contentType: 'text/json',
	    success: function (e) {
	    	nui.hideMessageBox(a);
	       	var returnJson = nui.decode(e);
			if(returnJson.exception == null){
				if(returnJson.rtnCode == ATS_SUCCESS){
					nui.alert("询价结果提交成功！","提示",function(){
						formalInstructionEntryFinish();
						//CloseOwnerWindow("ok");
	                });
	    		}else if(returnJson.rtnCode == ATS_ERROR) {
	    			nui.alert("询价结果提交失败！</br>"+returnJson.rtnMsg,"提示");
	            }
			}else{
				nui.alert("系统异常","系统提示");
			}
	    }
	});
}


//组装保存询价指令参数
function combiSaveDireParam(){
//	nui.get("vcProductCode").required = false;
//	nui.get("vcCombiCode").required = false;
	
	nui.get("lTradeDate").required = false;
	nui.get("lFirstSettleDate").required = false;
	nui.get("lRepoDays").required = false;
	nui.get("vcEntrustDirection").required = false;
	nui.get("lMaturitySettleDate").required = false;
	nui.get("vcSettleSpeed").required = false;
	nui.get("enFaceAmount").required = false;
	nui.get("vcCounterpartyId").required = false;
	nui.get("vcQuoteMode").required = false;
	nui.get("enRepoRate").required = false;
	nui.get("enWeightingValue").required = false;
	nui.get("vcCounterpartyTrader").required = false;

	
    var bondData = bondsGrid.data;

    var directionParam = {};
    var form = null;
    form = new nui.Form("#fullDirection");
    form.validate();
    if (form.isValid() == false){
    	return;
    }
    var fullDire = form.getData();
    if(fullDire.vcSettleSpeed === "0"){
    	avaiAmount = nui.get("vcAvailableamountT0").getValue();
    }else{
    	avaiAmount = nui.get("vcAvailableamountT1").getValue();
    }
    //回购天数 = 回购日期 - 开始日期。
//    fullDire["lRepoDays"] = days;
    //将所有参数打包进directionParam对象
    for (var key in fullDire) {
        directionParam[key] = fullDire[key];
    }
    directionParam["instructCategory"] = "0"; //用来传给流程判断1、完整指令  0、询价指令
    directionParam["vcProcessStatus"] = "-2"; //流程状态
    directionParam["cIsValid"] = "0"; //有效状态
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
    directionParam["vcBizType"] = 5; //业务类别：1-银行间二级交易，2-上海大宗交易，3-上海固收平台，4-深圳综合协议平台，5-银行间质押式回购，6-银行间买断式回购，7-交易所协议式回购
    directionParam["vcInstructType"] = 2; //(指令类型：1完整指令，2询价指令)
    directionParam["enPrice"] = 100.0000; //(指令价格)
    var vcProductData = nui.get("vcProductCode").getData();
    for(var j = 0;j<vcProductData.length;j++){
    	if(vcProductData[j].ID==nui.get("vcProductCode").getValue()){
    		directionParam["lProductId"] = vcProductData[j].L_PRODUCT_ID;
    	}
    }
    directionParam["vcProductName"] = nui.get("vcProductCode").getText(); //组合名字
    var vcCombiCodeData = nui.get("vcCombiCode").getData();
    for(var i = 0;i<vcCombiCodeData.length;i++){
    	if(vcCombiCodeData[i].ID==nui.get("vcCombiCode").getValue()){
    		directionParam["lAssetId"] = vcCombiCodeData[i].L_ASSET_ID;
    		directionParam["vcAssetCode"] = vcCombiCodeData[i].VC_ASSET_NO;
    		directionParam["vcAssetName"] = vcCombiCodeData[i].VC_ASSET_NAME;
    		directionParam["lCombiId"] = vcCombiCodeData[i].L_COMBI_ID;
    	}
    }
    directionParam["vcCombiName"] = nui.get("vcCombiCode").getText(); //组合名字    
    directionParam["vcCounterpartyName"] = nui.get("vcCounterpartyId").getText();//交易对手名字
    //判断交易对手是否是自己手动输入
	if(directionParam["vcCounterpartyId"] == directionParam["vcCounterpartyName"]){
		directionParam["vcCounterpartyId"] = "";
	}
    directionParam["vcCombiName"] = nui.get("vcCombiCode").getText(); //产品名字    
    directionParam["vcStockCode"] = symbol;
    directionParam["vcStockName"] = symbolName;
    directionParam["cOverdraft"] = cOverdraft;//是否可以透支
    directionParam["tradeQty"] = updateDireData ? updateDireData.enFaceAmount : 0;//为修改指令时，此指令所占用的可用金额
    directionParam["vcMarket"] = "5"; //市场编号
    return {instructParameter: directionParam, bonds: bondData};
}
//保存指令
function saveDirective(){
	var param = combiSaveDireParam();
    if(!param){
        return false;
    }
    param.instructParameter["callRiskType"] = 2; //下达指令
    param.srcInstruct = updateDireData;
    var a = nui.loading("正在处理中,请稍等...","提示");
    nui.ajax({
	    url: "com.cjhxfund.ats.sm.inquiry.inquiryInstruction.updateInquiryResult.biz.ext",
	    type: 'POST',
	    data: param,
	    cache: false,
	    contentType: 'text/json',
	    success: function (e) {
	    	nui.hideMessageBox(a);
	       	var returnJson = nui.decode(e);
			if(returnJson.exception == null){
				if(returnJson.rtnCode == ATS_SUCCESS){
					nui.alert("询价结果保存成功！","提示",function(){
						CloseOwnerWindow("ok");
	                });
	    		}else if(returnJson.rtnCode == ATS_ERROR) {
	    			nui.alert("询价结果保存失败！</br>"+returnJson.rtnMsg,"提示");
	            }
			}else{
				nui.alert("系统异常","系统提示");
			}
	    }
	});
}
//手动添加质押券方法
function addBond(){
	var vcStockCode = nui.get("vcStockCode").getText();
	var vcCombiNo = nui.get("vcStockCode").getValue();
	if(!vcCombiNo){
		return false;
	}
	bondsGrid.loading();
	vcCombiNo = vcCombiNo == 'undefined' ? null : vcCombiNo;
	if(!checkO32Exist({vcStockCode:vcStockCode,vcMarketNo:5})){
		//清空输入框
	    nui.get("vcStockCode").setValue(null);
	    nui.get("vcStockCode").setText(null);
		nui.alert("O32不存在此债券，请联系管理员。");
		bondsGrid.unmask();
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
                		chooseBond(bonds[0],function(){
                			bondsGrid.unmask();
                		});
                	});
            	}else{
            		chooseBond(bonds[0],function(){
            			bondsGrid.unmask();
            		});
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
//选择债券方法
var chooseBond = function (rowsData,recall) {
	//清空输入框
    nui.get("vcStockCode").setValue(null);
    nui.get("vcStockCode").setText(null);
	var rows = {};
	if(rowsData.row){
		rows = copySelectData([rowsData.row]);
	}else{
		rows = copySelectData([rowsData]);
	}	
	
    var firstRow = bondsGrid.data[0];
    var bool = true;
    var idStr = "canRepAmountZ";
    var remindStr = "";
    for(var a = 0;a<rows.length-1;a++){
        if(rows[a].vcDepository != rows[a+1].vcDepository){
        	remindStr = "不能同时选中两个在不同托管所的债券！("+ rows[a].vcReportCode +")";
            bool = false;
            break;
        }
    }
    if(firstRow){
    	if(firstRow.vcDepository){
    		for(var i =0;i<rows.length;i++){
                if(firstRow.vcDepository != rows[i].vcDepository){
                    bool = false;
                    remindStr = remindStr + "不能同时选中两个在不同托管所的债券！("+ rows[i].vcReportCode +")";
                    break;
                }
            }
    	}
    }
    //判断是否重复
    var bondsData = bondsGrid.data;
    for(var b = 0;b<rows.length;b++){
    	//不能选择ABN类型的债券
    	var vcStockName = rows[b].vcStockName;
    	if(vcStockName && vcStockName.indexOf("ABN")>=0){
    		bool = false;
    		remindStr = remindStr + "<br/>不能选择ABN类型债券！("+ rows[b].vcReportCode +")";
            break;
    	}
    	for(var c = 0;c<bondsData.length;c++){
    		var r = rows[b];
    		var bon = bondsData[c];
    		if((r.vcStockCode === bon.vcStockCode) &&  (r.vcExchange === bon.vcExchange)){
    			bool = false;
    			remindStr = remindStr + "<br/>不能重复选择债券！("+ bon.vcReportCode +")";
                break;
    		}
    	}
    }
    if(!bool){
    	nui.alert(remindStr,"系统提示");
    	recall();
        return false;
    }
    if(rows[0].vcDepository !== "01"){
        idStr = "canRepAmountS";
    }

    
    bondsGrid.addRows(rows, 0);
    //计算可正回购金额（中债）（上清）
    deposit = idStr;
    recall();
};

//查询可用数据
function queryVisible(datas,grid,isUpdate,recall){
	var VunitData = datas;
    nui.ajax({
        data: {'vunitstockLists': VunitData,"vcMarket":'OTC'},
        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.queryVisible.biz.ext",
        success: function (resp) {
        	var avaiList = resp.avaiList;
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
//重置指令信息
function resetDire(){
	nui.get("lRepoDays").setValue(0);
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
	nui.get("vcEntrustDirection").setValue("5");
	nui.get("vcSettleSpeed").setValue("0");
	nui.get("enFundValue").setValue(null);
	nui.get("vcAvailableamountT0").setValue(null);
	nui.get("vcAvailableamountT1").setValue(null);
	changeMode();
	bondsGrid.clearRows();
}
//初始化方法
$(function(){
	setColor();
	//去掉No Result
	$("#vcCounterpartyId>span>input").attr("placeholder","对手中文或首位拼音...");
	$("#vcStockCode>span>input").attr("placeholder","请输入债券代码...");
	fundCodeCombo = nui.get("vcProductCode");
	vcCombiCombo = nui.get("vcCombiCode");
	bondsGrid = nui.get("bondsGrid");
	nui.get("lTradeDate").setValue(new Date());
	nui.get("lFirstSettleDate").setValue(new Date());
	//设置交易日限制
	limitTradeDate(null,"lTradeDate");
});
