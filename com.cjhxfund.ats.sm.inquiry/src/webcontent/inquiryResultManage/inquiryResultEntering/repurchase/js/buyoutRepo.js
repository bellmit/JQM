/**
 * 
 */
var fundCodeCombo = null;
var vcCombiCombo = null;
var entrustDire = '5';//储存当前回购方向
var fundCodeData = {};
var bondsGrid = null;
var isT0T1avail = true; //判断是否触发可用数量不足

//计算汇总行
function onDrawSummaryCell(e) {
	
    if (e.field === "vcDepository") {
        var data = e.data;
        var amount = 0;
        for (var i = 0; i < data.length; i++) {
            if (data[i].enFaceAmount) {
            	var enFullPriceInit = data[i].enFullPriceInit ? data[i].enFullPriceInit : 0;
                amount = add(amount,mul(data[i].enFaceAmount,enFullPriceInit));
            }

        }
        	nui.get("enFullPriceAmount").setValue((amount * 100).toFixed(2));
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
//删除已选择的债券
var removeSelectedBonds = function (id) {
    bondsGrid.removeRow(bondsGrid.getRowByUID(id));
};
//质押券操作框删除列
function onActionRenderer(e) {
    var record = e.record;
    	return ' <a href="javascript:removeSelectedBonds(\'' + record._uid + '\')">删除</a>';
    
}
//设置选中债券
var setChooseBond = function(bondData){
	var row = bondData[0];
	var enCbValueNetValue = row["enCbValueNetValue"];
    if (enCbValueNetValue) {
        var index = enCbValueNetValue.indexOf(".");
        if(index>0){
        	enCbValueNetValue = enCbValueNetValue.slice(0, index);
        }
    }
    row['enNetPriceInit'] = enCbValueNetValue;
    if (enCbValueNetValue) {
        calcNetAllValue(enCbValueNetValue,null,bondsGrid,row,function(){
			calEmFaceAmount();
		});
    }
	bondsGrid.clearRows();
	bondsGrid.addRow(row, 0);
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
//选中产品触发动作
var selectFund = function(e){
	fundCodeData = nui.clone(fundCodeCombo.data);  //数据克隆 ，不克隆可能会有异常 ，我已经踩了这个坑   wzx 2017-09-027
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
            var row = bondsGrid.data[0];
            if(row){
            	calcNetAllValue(row['enNetPriceInit'],null,bondsGrid,row,function(){
            		calEmFaceAmount();
            	});
            }
            
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
//利率框离开事件，计算利息和到期结算金额、到期全价、到期净价
function calEmFaceAmount() {
	var lContractPeriods = nui.get("lContractPeriods").getValue();//占款天数
	var value = nui.get("enRepoRate").getValue();
	if(!value || !lContractPeriods){
		return;
	}
	var row = bondsGrid.data[0];
	//计算最后付息日
	var lastPayDate = calLastPayDate(row["lNextPayintDate"],row["enPayInteval"],nui.get("lFirstSettleDate").getValue(),
			nui.get("lMaturitySettleDate").getValue());
	var middleInterest = calMiddleInterest(row["lNextPayintDate"],row["enPayInteval"],
			   row["enFaceAmount"],row["enFaceRate"],nui.get("lFirstSettleDate").getValue(),nui.get("lMaturitySettleDate").getValue());
	calNetFull(value,row["enFullPriceInit"],lContractPeriods,lastPayDate,
			nui.get("lMaturitySettleDate").getValue(),
			row["enPayInteval"],row["enFaceRate"],middleInterest);
};
function calEnSettleAmount(){
	var value = nui.get("enSettleAmount").getValue();
	var row = bondsGrid.getRow(0);
	if(!value && !row){
		return;
	}
	row.enFullPriceFinal = div(value,row.enFaceAmount*100);
	calcenFullPriceFinal(null,row.enFullPriceFinal,bondsGrid,row,function(netPrice,fullPrice,grid,row1){
		calcenFullPriceFinal(netPrice,fullPrice,grid,row1);
	});
}
//计算最后付息日(下一付息日，付息频率，首期结算日，到期结算日）
function calLastPayDate(lNextPayintDate,enPayInteval,lFirstSettleDate,lMaturitySettleDate){
	if(!lNextPayintDate || !enPayInteval || !lFirstSettleDate || !lMaturitySettleDate){
		return 0;
	}
	lNextPayintDate = DateUtil.numStrToDate(lNextPayintDate); //下一付息日
	lFirstSettleDate = DateUtil.DstrToDate(lFirstSettleDate); //首次结算日
	lMaturitySettleDate = DateUtil.DstrToDate(lMaturitySettleDate); //到期结算日
	var inteval = div(12,enPayInteval);  //多少月付一次利息。
	var startDate = new Date(lNextPayintDate); //计息起始日期
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
		return startDate;
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
	return endDate;
}
//计算中途付息利率(最后付息日，付息频率，券面金额，券面利率，首期结算日期，到期结算日期）
var lastTime = true;
var middleInterestStorage = null;
var InterestParamTemp = {};
var payment = 0;//中途付息金额
var calMiddleInterest = function(lLastPayintDate,enPayInteval,enFaceAmount,enFaceRate,lFirstSettleDate,lMaturitySettleDate){
	if((InterestParamTemp && InterestParamTemp.lLastPayintDate === lLastPayintDate
			&& InterestParamTemp.enPayInteval === enPayInteval
			&& InterestParamTemp.enFaceAmount === enFaceAmount
			&& InterestParamTemp.enFaceRate === enFaceRate
			&& InterestParamTemp.lFirstSettleDate === lFirstSettleDate
			&& InterestParamTemp.lMaturitySettleDate === lMaturitySettleDate) && middleInterestStorage){
		return middleInterest;
	}
	if(!lLastPayintDate || !enPayInteval || !enFaceAmount || !enFaceRate || !lFirstSettleDate || !lMaturitySettleDate){
		return 0;
	}
	lFirstSettleDate = DateUtil.DstrToDate(lFirstSettleDate); //首次结算日
	lMaturitySettleDate = DateUtil.DstrToDate(lMaturitySettleDate); //到期结算日
	var startDate = DateUtil.numStrToDate(lLastPayintDate); //计息起始日期
	var inteval = div(12,enPayInteval);  //多少月付一次利息。
	var calcInterestDates = [];
	for(;;){
 		var startDateNum = Number(DateUtil.toNumStr(startDate));
 		if(startDateNum >=Number(DateUtil.toNumStr(lFirstSettleDate)) &&
 				startDateNum <=Number(DateUtil.toNumStr(lMaturitySettleDate))){
 			calcInterestDates.push(startDateNum);
 		}
 		if(startDateNum > DateUtil.toNumStr(lMaturitySettleDate)){
 			break;
 		}
 		var month2 = startDate.getMonth();
		startDate.setMonth(month2+inteval);
 	}
	var bond = bondsGrid.data[0];
	var param = {
		processDate:calcInterestDates,
		marketNo:"5",
		reportCode:bond.vcReportCode,
		interCode:bond.vcInterCode,
		startDate:DateUtil.toNumStr(lFirstSettleDate),
		endDate:DateUtil.toNumStr(lMaturitySettleDate)
	};
	var interest = null;
	nui.ajax({
        url:"com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.GetInterestPayment.biz.ext",
        type:'POST',
        data:param,
        cache:false,
        async:false,
        contentType:'text/json',
        success:function(response){
        	interest = add(response.payment,response.interest);
        	payment = response.payment;
        	middleInterestStorage = interest;
        	InterestParamTemp.lLastPayintDate = lLastPayintDate;
        	InterestParamTemp.enPayInteval = enPayInteval;
			InterestParamTemp.enFaceAmount = enFaceAmount;
		    InterestParamTemp.enFaceRate = enFaceRate;
			InterestParamTemp.lFirstSettleDate = lFirstSettleDate;
			InterestParamTemp.lMaturitySettleDate = lMaturitySettleDate;
        }
    });
	return interest;
};
//计算可做回购金额方法、券面金额改动同时联动首次结算金额、到期结算金额、回购利息。
function calcFaceAmout(row,enFaceAmount,enNetPriceInit,enMortagageRatio){
	//校验券面金额Start
	   if(!ispositiveNum(enFaceAmount)) {
	        nui.alert("必须为正整数！");
	        isEnFaceAmountRight = false;
	        return;
	    }else if(enFaceAmount > 1000000000){
	    	nui.alert("券面金额不能超过十亿！");
	    	isEnFaceAmountRight = false;
	    	return;
	    }else if(enFaceAmount%10 !== 0){
	    	nui.alert("券面金额必须为10的倍数！");
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
		 //计算最后付息日
			
		   var middleInterest = calMiddleInterest(row["lNextPayintDate"],row["enPayInteval"],
				   row["enFaceAmount"],row["enFaceRate"],nui.get("lFirstSettleDate").getValue(),nui.get("lMaturitySettleDate").getValue());
		   //计算利息
		   var interest = add((enSettleAmount - row["canRepurchaseAmount"]),mul(middleInterest,row["enFaceAmount"] * 100));
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
            	row["enFirstSettleInterest"] = Number(resultArr[7]);//首期利息
            	row["enFirstYield"] = Number(resultArr[2]);
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
	
	//计算中途付息金额
	var middleInterest = calMiddleInterest(row["lNextPayintDate"],row["enPayInteval"],row["enFaceAmount"],row["enFaceRate"],nui.get("lFirstSettleDate").getValue(),
			nui.get("lMaturitySettleDate").getValue());
	nui.get("enMiddleInterest").setValue(mul(middleInterest,row["enFaceAmount"] * 100));
	var jsonParam = {processDate:lTradeDate, 
			endDate:DateUtil.toNumStr(nui.get("lMaturitySettleDate").getValue()),
			interCode:row['vcInterCode'],reportCode:row["vcStockCode"],
			netPrice:netValue, fullPrice:allValue, interestRate:null, interestRateType:'1', 
			tradingPlace:'5', clearingSpeed:vcSettleSpeed,'payment':payment};
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
            	row["enMaturitySettleInterest"] = Number(resultArr[4]);//到期利息
            	row["enMaturityYield"] = Number(resultArr[3]);
//            	row["enNetPriceFinalA"] = Number(resultArr[0]);//净价（元/百元面值）没有四舍五入的值
//            	row["enFullPriceFinalA"] = Number(resultArr[1]);//全价（元/百元面值）没有四舍五入的值
				grid.updateRow(row);
				//到期结算金额
				var enSettleAmount = (mul(row["enFullPriceFinal"], row["enFaceAmount"]/100) * 10000).toFixed(2);
				
				nui.get("enSettleAmount").setValue(enSettleAmount);
				
				//首期结算金额
				var enFullPriceAmount = nui.get("enFullPriceAmount").getValue();
				if(enFullPriceAmount && enFullPriceAmount<=0){
					return;
				}
				//计算最后付息日
				var lastPayDate = calLastPayDate(row["lNextPayintDate"],row["enPayInteval"],nui.get("lFirstSettleDate").getValue(),
						nui.get("lMaturitySettleDate").getValue());
				
				
				calInterest(row["enFullPriceInit"],row["enFullPriceFinal"],
						nui.get("lContractPeriods").getValue(),lastPayDate,
						nui.get("lMaturitySettleDate").getValue(),row["enPayInteval"],row["enFaceRate"],middleInterest
						,(bondsGrid.data[0].enFaceAmount * 100));
				
				//计算回购利息
				nui.get("enRepoInterest").setValue(add(enSettleAmount - enFullPriceAmount,mul(middleInterest,row["enFaceAmount"] * 100)).toFixed(2)); //计算回购利息
				if(recall){
					recall(Number(resultArr[0]).toFixed(4),null,bondsGrid,bondsGrid.data[0]);
				}
				
            }else{
                nui.alert("净价、全价、收益率数据获取失败", "系统提示");
            }
        }
    });
}

//回购利率计算公共方法。参数（首期全价，到期全价，实际占款天数，下一付息日期，到期结算日，付息频率，票面利率）
function calInterest(allValueInit,allValueFinal,period,lLastPayintDate,endDate,enPayInteval,enFaceRate,tc){
	var interest = null;
    var lLastPayintDateNum = DateUtil.toNumStr(lLastPayintDate);
    if(lLastPayintDateNum && (Number(DateUtil.toNumStr(endDate)) > Number(lLastPayintDateNum))){ //此条记录是否存在下一付息日同时下一付息日是否小于到期结算日
		var TC = tc;//入参改为了中途付息金额和数量
		var dTime = DateUtil.DstrToDate(endDate).getTime() - lLastPayintDate.getTime();
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
function calNetFull(enRepoRate,enFullPriceInit,period,lLastPayintDate,endDate,enPayInteval,enFaceRate,tc){
	var enFullPriceFinal = null;
	var lLastPayintDateNum = DateUtil.toNumStr(lLastPayintDate);
	if(lLastPayintDateNum && (Number(DateUtil.toNumStr(endDate)) > Number(lLastPayintDateNum))){ //此条记录是否存在下一付息日同时下一付息日是否小于到期结算日
		var TC = tc;//入参改为了中途付息金额和数量
		var dTime = DateUtil.DstrToDate(endDate).getTime() - lLastPayintDate.getTime();
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
//组装完整指令参数
function combiDireParam(){
    var bondData = bondsGrid.data;
    if (bondData.length < 1 || bondData[0].enFaceAmount <= 0) {
        nui.alert("您没有选择任何可质押的债券。或者债券数量为0。", "警告");
        return false;
    }
    if(nui.get("enSettleAmount").getValue() <=0){
    	nui.alert("到期結算金额不能为小于或等于0！", "警告");
        return false;
    }
    if(!bondData[0].enNetPriceInit || !bondData[0].enFullPriceInit || !bondData[0].enNetPriceFinal || !bondData[0].enFullPriceFinal){
    	nui.alert("您没有填写完整全价、净价。", "警告");
        return false;
    }
    if(!symbol){
    	nui.alert("O32系统无该回购期限（天）对应的证券代码，请联系交易员先新增该回购期限对应的证券代码。","警告");
    	return;
    }
    if(isEnFaceAmountRight === false){
    	mini.showTips({
	            content: "券面金额不正确！",
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
    	 if(setDataBonds != null && bondsGrid!= null){
	    	 if(setDataBonds.length == bondsGrid.data.length){
	    		 for(var s = 0;s<setDataBonds.length;s++){
	    			 if(setDataBonds[s]["enFaceAmount"] != bondsGrid.data[s]["enFaceAmount"] ||
	    					 setDataBonds[s]["enNetPriceInit"] != bondsGrid.data[s]["enNetPriceInit"] ||
	    					 setDataBonds[s]["enNetPriceFinal"] != bondsGrid.data[s]["enNetPriceFinal"]){
	    				 isbondsChange = true;
	    				 break;
	    			 }  
	    		 }
	    	 }	 
    	 }else{
    		 isbondsChange = true;
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
    directionParam["instructCategory"] = "0"; //用来传给流程判断1、完整指令  0、询价指令
    directionParam["vcProcessStatus"] = "-1"; //流程状态
    directionParam["cIsValid"] = "1"; //有效状态
    directionParam["lFixValidStatus"] = "0";//用于判断指令是否发送O32以及发送结果：0-未发送,1-修改后未发送,2-发送中,3-发送成功,4-发送失败
    directionParam["symbol"] = symbol; //申报代码
    directionParam["businClass"] = 'O';  //	2 (业务类别:O-银行间买断式回购)
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
    directionParam["vcInstructType"] = 2; //(指令类型：1完整指令，2询价指令)
    directionParam["enInvestAmount"]= directionParam["enFullPriceAmount"]!=null&&directionParam["enFullPriceAmount"]!=0?directionParam["enFullPriceAmount"]/ 10000:0;//投资金额
    //var vcProductData = nui.get("vcProductCode").getData();
    //for(var j = 0;j<vcProductData.length;j++){
    //	if(vcProductData[j].ID==nui.get("vcProductCode").getValue()){
    //		directionParam["lProductId"] = vcProductData[j].L_PRODUCT_ID;
    //	}
    //}
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
    directionParam["vcCombiName"] = nui.get("vcCombiCode").getText(); //产品名字    
    directionParam["vcCounterpartyName"] = nui.get("vcCounterpartyId").getText();//交易对手名字
    //判断交易对手是否是自己手动输入
	if(directionParam["vcCounterpartyId"] == directionParam["vcCounterpartyName"]){
		directionParam["vcCounterpartyId"] = "";
	}
    directionParam["vcStockCode"] = symbol;
    directionParam["vcStockName"] = symbolName;
    directionParam["cOverdraft"] = cOverdraft;//是否可以透支
    directionParam["tradeQty"] = 0;//为修改指令时，此指令所占用的可用金额
    directionParam["vcMarket"] = "5"; //市场编号
  //逆回购调整组合
    if(directionParam["vcEntrustDirection"] === "6"){
    	for(var e = 0;e<bondData.length;e++){
    		bondData[e].vcProductCode = directionParam["vcProductCode"];
    		bondData[e].vcFundCode = directionParam["vcProductCode"];
    		bondData[e].vcCombiCode = directionParam["vcCombiCode"];
    	}
    }
    return {instructParameter: directionParam, bonds: bondData};
}
//组装保存指令参数
function combiSaveDireParam(){
	
	nui.get("lTradeDate").required = false;
	nui.get("lFirstSettleDate").required = false;
	nui.get("lRepoDays").required = false;
	nui.get("vcEntrustDirection").required = false;
	nui.get("enFullPriceAmount").required = false;
	nui.get("lMaturitySettleDate").required = false;
	nui.get("vcSettleSpeed").required = false;
	nui.get("vcCounterpartyId").required = false;
	nui.get("enRepoRate").required = false;
	nui.get("vcCounterpartyTrader").required = false;

    var bondData = bondsGrid.data;
    var directionParam = {};
    var form = new nui.Form("#fullDirection");
    form.validate();
    if (form.isValid() == false){
    	return;
    }
    var fullDire = form.getData();

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
    directionParam["instructCategory"] = "0"; //用来传给流程判断1、完整指令  0、询价指令
    directionParam["cIsValid"] = "0"; //有效状态
    directionParam["vcProcessStatus"] = "-2"; //流程状态
    directionParam["lFixValidStatus"] = "0";//用于判断指令是否发送O32以及发送结果：0-未发送,1-修改后未发送,2-发送中,3-发送成功,4-发送失败
    directionParam["symbol"] = symbol; //申报代码
    directionParam["businClass"] = 'O';  //	2 (业务类别:O-银行间买断式回购)
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
    directionParam["vcInstructType"] = 2; //(指令类型：1完整指令，2询价指令)
    directionParam["lProductId"] = fundCodeData[nui.get("vcProductCode").getValue()]['L_PRODUCT_ID'];
    directionParam["vcProductName"] = nui.get("vcProductCode").getText(); //组合名字
    directionParam["enInvestAmount"]= directionParam["enFullPriceAmount"]!=null&&directionParam["enFullPriceAmount"]!=0?directionParam["enFullPriceAmount"]/ 10000:0;//投资金额
    var vcCombiCodeData = nui.get("vcCombiCode").getData();
    for(var i = 0;i<vcCombiCodeData.length;i++){
    	if(vcCombiCodeData[i].ID==nui.get("vcCombiCode").getValue()){
    		directionParam["lAssetId"] = vcCombiCodeData[i].L_ASSET_ID;
    		directionParam["vcAssetCode"] = vcCombiCodeData[i].VC_ASSET_NO;
    		directionParam["vcAssetName"] = vcCombiCodeData[i].VC_ASSET_NAME;
    		directionParam["lCombiId"] = vcCombiCodeData[i].L_COMBI_ID;
    	}
    }
    directionParam["vcCombiName"] = nui.get("vcCombiCode").getText(); //产品名字    
    directionParam["vcCounterpartyName"] = nui.get("vcCounterpartyId").getText();//交易对手名字
    //判断交易对手是否是自己手动输入
	if(directionParam["vcCounterpartyId"] == directionParam["vcCounterpartyName"]){
		directionParam["vcCounterpartyId"] = "";
	}
    directionParam["vcStockCode"] = symbol;
    directionParam["vcStockName"] = symbolName;
    directionParam["cOverdraft"] = cOverdraft;//是否可以透支
    directionParam["tradeQty"] = 0;//为修改指令时，此指令所占用的可用金额
    directionParam["vcMarket"] = "5"; //市场编号
  //逆回购调整组合
    if(directionParam["vcEntrustDirection"] === "6"){
    	for(var e = 0;e<bondData.length;e++){
    		bondData[e].vcProductCode = directionParam["vcProductCode"];
    		bondData[e].vcFundCode = directionParam["vcProductCode"];
    		bondData[e].vcCombiCode = directionParam["vcCombiCode"];
    	}
    }
    return {instructParameter: directionParam, bonds: bondData};
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
		formalInstructionEntry(instructJson, doCloseParam);
	}else if(riskFlag=='2'){
		formalInstructionEntry(instructJson, doCloseParam);
	}
}
function formalInstructionEntryFinish(){
	if(riskFlagParam=='2'){
		startRiskProcessInstruct(lResultIdParam, lRiskmgrIdParam);
	}
	if(doCloseParam){
		if(window.parent.closewindow){
			window.parent.closewindow("ok");
		}else{
			CloseOwnerWindow("ok");
		}
	}
}
/**风控管理结束**/


//下达指令
function sendDirective() {
    var param = combiDireParam();
    if(!param){
        return false;
    }
    var close = arguments[0];
    doCloseParam = close;
    
    if(judgeRiskTest(null, param.instructParameter)){	//对接风控管理
    	param.instructParameter["callRiskType"] = 3; //下达指令
    	checkRiskInfo(param);//riskMgrComm.js的方法
    	return;
    }
    
  //  param.instructParameter["callRiskType"] = 2; //下达指令
    //提交动作。
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
						if(window.parent.closewindow){
							window.parent.closewindow("ok");
						}else{
							CloseOwnerWindow("ok");
						}
                    });
        		}else if(returnJson.rtnCode == ATS_ERROR){
        			nui.alert(returnJson.rtnMsg,"系统提示");
        		}else if(returnJson.rtnCode == "302"){//可用不足,继续下单先校验风控
        			nui.confirm(returnJson.rtnMsg+"</br>是否继续下单？","提示", function(action){
                		if(action == "ok") {
                			formalInstructionEntry(param);
                        }
                	});
        		}else if(returnJson.rtnCode == ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT){
//        			if(param.instructParameter["vcEntrustDirection"]=="5"){
//        				nui.alert(returnJson.rtnMsg,"禁止提示");
//        			}else{
        				nui.confirm(returnJson.rtnMsg+"</br>是否继续下单？","提示", function(action){
                    		if(action == "ok") {
                    			formalInstructionEntry(param);
                            }
                    	});
//        			}
        		}else if(returnJson.rtnCode == "301" || returnJson.rtnCode == "203"){
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
                        onload: function() {
                            var iframe = this.getIFrameEl();
                            iframe.contentWindow.SetData(riskInfo,1);
                        },
                        ondestroy: function (action) {
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
    //保存指令
    function saveDirective(){
    	var param = combiSaveDireParam();
        if(!param){
            return false;
        }
        var a = nui.loading("正在处理中,请稍等...","提示");
        nui.ajax({
    	    url: "com.cjhxfund.ats.sm.inquiry.inquiryInstruction.insertInquiryResult.biz.ext",
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
    						if(window.parent.closewindow){
    							window.parent.closewindow("ok");
    						}else{
    							CloseOwnerWindow("ok");
    						}
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
  //正式修改指令/建议信息
  function formalInstructionEntry(param){
    	var a = nui.loading("正在处理中,请稍等...","提示");
    	nui.ajax({
    	    url: "com.cjhxfund.ats.sm.inquiry.inquiryInstruction.insertInquiryResult.biz.ext",
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
    						//CloseOwnerWindow("ok");
    						formalInstructionEntryFinish();
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
    
//手动添加质押券方法
function addBond(e){
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
                			var row = bondsGrid.getRow(0);
                	        if (row["enNetPriceInit"]) {
                	            calcNetAllValue(row["enNetPriceInit"],null,bondsGrid,row,function(){
                    				calEmFaceAmount();
                    			});
                	        }
                		});
                	});
            	}else{
            		chooseBond(bonds[0],function(){
            			bondsGrid.unmask();
            			var row = bondsGrid.getRow(0);
            	        if (row["enNetPriceInit"]) {
            	            calcNetAllValue(row["enNetPriceInit"],null,bondsGrid,row,function(){
                				calEmFaceAmount();
                			});
            	        }
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
	
    var bool = true;
    var idStr = "canRepAmountZ";
    var remindStr = "";
    //判断是否重复
    for(var b = 0;b<rows.length;b++){
    	//不能选择ABN类型的债券
    	var vcStockName = rows[b].vcStockName;
    	if(vcStockName && (vcStockName.indexOf("PPN")>=0 || vcStockName.indexOf("ABN")>=0)){
    		bool = false;
    		remindStr = remindStr + "<br/>不能选择PPN、ABN类型债券！("+ rows[b].vcReportCode +")";
            break;
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
    bondsGrid.clearRows();
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
        var enCbValueNetValue = object["enCbValueNetValue"];
        if (enCbValueNetValue) {
            var index = enCbValueNetValue.indexOf(".");
            if(index>0){
            	enCbValueNetValue = enCbValueNetValue.slice(0, index);
            }
        }
        object['enNetPriceInit'] = enCbValueNetValue;
        temp2.push(object);
    }
    return temp2;
};
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
	nui.get("enFundValue").setValue(null);
	nui.get("vcAvailableamountT0").setValue(null);
	nui.get("vcAvailableamountT1").setValue(null);
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
