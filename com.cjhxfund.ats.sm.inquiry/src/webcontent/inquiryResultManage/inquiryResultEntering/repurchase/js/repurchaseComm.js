/**
 * 描述：质押式、买断式、协议式回购主页面公共js
 */
nui.parse();
/* ******************************************
 * 全局变量 start
 ********************************************/
//页面产品代码与产品组合combox联动
var symbol = "";//申报代码
var symbolName = "";//申报名称
var symbolInterCode = "";//O32申报内码
var days = null;//计算回购天数、获取申报代码
var vcStockCodeAuto = nui.get("vcStockCode");
var enFaceAmountUpd = null;//保存修改指令初始化的回购金额
var today = new Date();//今天
var deposit = "";//储存托管机构
var cOverdraft = ""; //是否可以透支。1:允许透支；2:不允许透支
var fullDirection = null; //指令表单对象，用于储存修改指令时候的指令表单
var setDataBonds = null;
var fixStatus = 0;//fix转换机开启状态。0-开启；1-关闭。
var isEnFaceAmountRight = true; //券面金额是否合乎规范
var maxRepurchAmount = 0;
/* ******************************************
 * 全局变量 end
 ********************************************/

/* ******************************************
 * 公共工具方法 start
 ********************************************/
function ChangeTraderName(e){
	nui.get(e.id).setValue(e.value.toUpperCase());
}
function organVali(e){
	if(e.value.length>30){
		e.errorText = "对手主体机构长度不能超过30个字符！";
	 	e.isValid = false;
	}
}
//备注长度校验
function remarkVali(e){
	if(e.value.length>500){
		e.errorText = "备注长度不能超过500个字符！";
	 	e.isValid = false;
	}
}
//交易对手长度校验
function vcCounterpartyCheck(e){
	if(e.value.length > 128 || e.sender.text.length > 128){
		e.errorText = "交易对手不能超过128位！";
	 	e.isValid = false;
	}
}
//页面X的删除功能
function onCloseClick(e) {
    var obj = e.sender;
    obj.setText("");
    obj.setValue("");
}
//正数校验
var ispositiveFlo  = function(value){
    var reg = /^[1-9]\d*$/;//正正数
    var reg2 = /^[1-9]\d*\.\d*|0\.\d*[1-9]\d*$/;//正浮点数
    if (!reg.test(value) && !reg2.test(value)) {
        return false;
    }
    return true;
};
var positiveFlo = function(e){
	if(e.value  === ""){
		return;
	}
	var reg = /^[0-9]+(.[0-9]{1,4})?$/;//小数点后三位的正实数
	if (!reg.test(e.value) || e.value > 100000){
		e.errorText = "必须输入小于十万的正数，且小数点只能保留后四位！";
        e.isValid = false;
	}else{
		
	}
};
//正整数校验
var ispositiveNum = function(value){
    var reg = /^[1-9]\d*$/;//正则
    if (!reg.test(value)) {
        return false;
    }
    return true;
};
var lRepoDaysNum = function(e){
	if(e.value === null){
		return;
	}
	var reg = /^[0-9]\d*$/;
	if (!reg.test(e.value)){
		e.errorText = "必须输入正整数！";
        e.isValid = false;
	}
};

var positiveNum = function(e){
	var reg = /^[1-9]\d*$/;
	if (!reg.test(e.value)){
		e.errorText = "必须输入正整数！";
        e.isValid = false;
	}
};

//数字校验公共方法
function valiNum(value) {
    var reg = /^\d+(\.\d+)?$/;//正则
    if (!reg.test(value)) {
        return false;
    }
    return true;
}
//页面X的删除功能
function onCloseClick(e) {
    var obj = e.sender;
    obj.setText(null);
    obj.setValue(null);
    obj.doValueChanged();
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

/* ******************************************
 * 公共工具方法 end
 ********************************************/



/* ******************************************
 * 公共校验方法 start
 ********************************************/
//校验结算日期不能大于摘牌日期
var setlMaturitySettleDate = function (e) {
	if(!e.value){
		return;
	}
    var data = nui.get("bondsGrid").getData();
    var date = DateUtil.toNumStr(e.value);
    var temp = 0;
    for (var i = 0; i < data.length; i++) {
        temp = data[i]["lDelistingDate"];
        if (temp && temp < date) {
        	nui.alert("到期结算日期不能大于选择债券摘牌日期！");
            e.errorText = "到期结算日期不能大于选择债券摘牌日期！";
            e.isValid = false;
            break;
        }
    }
    //到期日期不能大于首次结算日期
    var lFirstSettleDate = nui.get("lFirstSettleDate").getValue();
    var lFirstSettleDateNum = DateUtil.toNumStr(lFirstSettleDate);
    if (lFirstSettleDateNum >= date) {
        e.errorText = "到期结算日期必须大于首次结算日！";
        e.isValid = false;
    }
    if(!remindTradeDate(e,"交易日期不是交易日，还需要继续吗？")){
    	e.errorText = "交易日期不是交易日！";
        e.isValid = false;
    }
};

//交易日期不能小于今天校验
var lTradeDateValid = function (e) {
	if(!e.value){
		return;
	}
    var date = DateUtil.toNumStr(e.value);
    var toDay = DateUtil.toNumStr(new Date());
    if (date < toDay) {
        e.errorText = "交易日期不能小于今天！";
        e.isValid = false;
    }
    if(!remindTradeDate(e,"交易日期不是交易日，还需要继续吗？")){
    	e.errorText = "交易日期不是交易日！";
        e.isValid = false;
    }
    
};
//首次结算日期不能小于交易日期
var lFirstSettleDateValid = function (e) {
    isTradeDate(e);
    var date = DateUtil.toNumStr(e.value);
    var tradeDate = DateUtil.toNumStr(nui.get("lTradeDate").getValue());
    if (date < tradeDate) {
        e.errorText = "首次结算日期不能小于交易日期！";
        e.isValid = false;
    }
};
//回购金额校验
var enFaceAmountValid = function (e) {
	var temp = nui.get("vcEntrustDirection").getValue();
    if ( (temp == "5" || temp == "6" ||temp == "15") && e.value > maxRepurchAmount) {
        e.errorText = "最大回购金额不能大于" + maxRepurchAmount;//最大回购金额不能大于可做回购金额
        e.isValid = false;
    }
    if ( (temp == "6" || temp == "16") && e.value <=0) {
        e.errorText = "逆回购回购金额必须大于0！";
        e.isValid = false;
    }
};

//查询此组合逆回购是否支持透支金额，参数：组合、业务类别(2-银行间业务)
function allowOverdraft(vcCombiCode,businClass){
	var param = {"vcCombiCode":vcCombiCode,"businClass":businClass};
	nui.ajax({
		data:{param:param},
		url:"com.cjhxfund.commonUtil.ProductManager.whetherAllowOverdraft.biz.ext",
		success:function(returnJson){
			if(returnJson.exception == null){
				var resultInfo = returnJson.resultInfo;
				cOverdraft = resultInfo[0].cOverdraft;
			}else{
				nui.alert("系统异常","系统提示");
			}
	      
	    }
	});
}

/* ******************************************
 * 公共校验方法 end
 ********************************************/

//选择交易对手的时候，将对手主体机构带出
function setIssueOrgan(e){
	var vcIssuerName = e.selected ? e.selected.vcIssuerName : "";
	nui.get("vcCounterpartyOrgan").setValue(vcIssuerName);
}


var calByFirstMa = function(){
	var lFirstSettleDate = nui.get("lFirstSettleDate");
	if(lFirstSettleDate.getValue() === ""){
		return false;
	}
	var lRepoDays = nui.get("lRepoDays").getValue();//回购天数
    if(!ispositiveNum(lRepoDays)){
    	return false;
    }
    calMaturityDate(lFirstSettleDate.getValue(), lRepoDays);
};

function selectCombi2(e) {
	if(e.value){
    	nui.get("showHoldingButton").enable();
    }else{
    	nui.get("showHoldingButton").disable();
    }
	var value = vcCombiCombo.getValue();
	vcCombiCombo.setValue(value);
    //计算可用
    getAviliable();
    //获取此组合是否可以透支
    allowOverdraft(value,'2');
    
};
//复制上面债券选中记录。

//风控试算
function riskControlTrial() {
    var param = combiDireParam();
    if (!param) {
        return false;
    }
    param.instructParameter["callRiskType"] = 1; //风控试算
    var b = nui.loading("正在处理中,请稍等...","提示");
    //风控试算start
    nui.ajax({
	 	url: "com.cjhxfund.ats.sm.comm.InstructionManager.checkInstructAvail.biz.ext",
        type: 'POST',
        data: param,
        cache: false,
        contentType: 'text/json',
        success: function (text) {
        	nui.hideMessageBox(b);
        	var returnJson = nui.decode(text);
			if(returnJson.exception == null){
                var riskInfo = returnJson.riskMsg;
               if (returnJson.rtnCode == ATS_SUCCESS){
                    if(returnJson.rtnMsg!=null){
                    	nui.alert(returnJson.rtnMsg,"系统提示");
                    }else{
                    	nui.alert("风控试算通过!","系统提示");
                    }
                }else if(returnJson.rtnCode ==ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT){
                	nui.alert(returnJson.rtnMsg,"投资指令/建议风险提示");//可用不足
                }else if(returnJson.rtnCode == "203"){
                	nui.alert(returnJson.rtnMsg,"系统提示");//风控校验失败
                }else if(returnJson.rtnCode == "301"){
                	//风险提示框start
                	riskInfo["alertMsg"]=returnJson.rtnMsg;
                    nui.open({
                        url:  nui.context +"/fix/riskControlDetailList.jsp",
                        title: "投资指令/建议风险提示",
                        width: 800,
                        height: 422,
                        onload: function () {
                            var iframe = this.getIFrameEl();
                            iframe.contentWindow.SetData(riskInfo,3);
                        }
                    });
                    //风险提示框end
                }else{
                    //风险提示框start
                    nui.open({
                        url:  nui.context +"/fix/riskControlDetailList.jsp",
                        title: "投资指令/建议风险提示",
                        width: 800,
                        height: 380,
                        onload: function () {
                            var iframe = this.getIFrameEl();
                            iframe.contentWindow.SetData(riskInfo,3);
                        }
                    });
                    //风险提示框end
                }
			}else{
				nui.alert("系统异常","系统提示");
			}
        }
	 });
    //风控试算end
};

//检查更新字段 判断是否重新走关联风控
function checkEditToRisk(returnJson){
	var param = combiDireParam();
	var lResultId = "";
	if(!param.srcInstruct||!param.srcInstruct.cRiskStatus||param.srcInstruct.cRiskStatus=='0' || param.srcInstruct.cRiskStatus=='1'){
		if(param.instructParameter.lResultId){
			lResultId = param.instructParameter.lResultId;
		} else {
			return returnJson;
		}
	} else {
		lResultId = param.srcInstruct.lResultId;
	}
	
	var isFilter = false;//是否过滤交易关联 
	var rtnCode = returnJson.rtnCode;
	//查询原指令数据是否有修改金额及交易对手
	nui.ajax({
	 	url: "com.cjhxfund.ats.sm.inquiry.inquiryInstruction.getInstructInfo.biz.ext",
        type: 'POST',
        data: {lResultId: lResultId},
        cache: false,
        async: false,
        contentType: 'text/json',
        success: function (text) {
        	if(text.instructionInfo.length==0||text.isCheck==false){//未通过
        		isFilter = false//不过滤关联交易
        	} else {//通过，则判断是否修改关键字段，过滤关联交易
        		if(param.instructParameter.businClass=="O"){
        			var vcCounterpartyName = param.instructParameter.vcCounterpartyName;
		        	var enSettleAmount = param.instructParameter.enSettleAmount;
		        	if(vcCounterpartyName==text.instructionInfo[0].vcCounterpartyName&&enSettleAmount==text.instructionInfo[0].enSettleAmount){
		        		isFilter = true;
		        	}
        		} else {
		        	var vcCounterpartyName = param.instructParameter.vcCounterpartyName;
		        	var enFaceAmount = param.instructParameter.enFaceAmount;
		        	if(vcCounterpartyName==text.instructionInfo[0].vcCounterpartyName&&enFaceAmount==text.instructionInfo[0].enFaceAmount){
		        		isFilter = true;
		        	}
        		}
        	}
        }
	});
	
	//没有则检查风控内容是否有触发关联交易审批
	if(isFilter&&returnJson.riskMsg.resultDetail){
		var riskDetail = returnJson.riskMsg.resultDetail;
		var newRiskDetail = new Array();
		for(var i=0,j=0;i<riskDetail.length;i++){
			//去除关联交易
			if(!(riskDetail[i].cRiskOperation==3&&riskDetail[i].vcInsApproveFlow==1)){
				newRiskDetail[j]=riskDetail[i];
				j++;
			}
		}
		//处理rtnCode
		if(rtnCode==204&&newRiskDetail.length==0){
			rtnCode=0;
		}else if(rtnCode==301&&newRiskDetail.length==0){
			rtnCode=201;
		}
		
		returnJson.riskMsg.resultDetail = newRiskDetail;
		returnJson.rtnCode = rtnCode;
	}

	return returnJson;
}

//计算回购天数、获取申报代码
var caclSymbol = function (isLinkDate,cMarketNo,cParameterType) {
    days = nui.get("lRepoDays").getValue();
    if (!ispositiveNum(days)) {
        return false;
    }
    if(isLinkDate){
    	calFirstMaturityRe();
    }
    var symbolParam = {
    		actualDays: days,
    		'cParameterType': cParameterType,
    		'cMarketNo':cMarketNo
    };
    
    nui.ajax({
        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.getSymbol.biz.ext",
        type: 'POST',
        data: {"symbol":symbolParam},
        cache: false,
        contentType: 'text/json',
        success: function (resp) {
        	if(resp.symbols.length>0){
        		 symbol = resp.symbols[0].vcReportCode;
                 symbolName = resp.symbols[0].vcStockName;
                 symbolInterCode = resp.symbols[0].vcInterCode;
                 mini.showTips({
			            content: "申报代码："+symbol+"，申报名称："+symbolName+"。",
			            state: "success",
			            x: "right",
			            y: "bottom",
			            timeout: 10000
			        });
        	}else{
        		mini.showTips({
			            content: "没有查询到与回购天数相应的申报代码和申报名称，建议去O32维护。",
			            state: "warning",
			            x: "top",
			            y: "top",
			            timeout: 10000
			        });
       		 symbol = null;
             symbolName = null;
             symbolInterCode = null;
        	}
        }
    });
};

//复制增加填充数据
function SetData(srcInstruction) {
	nui.get("showHoldingButton").enable();//设置持仓可选
    //关闭是否第一次回填
    isFirstAmount = false;
    var json = {lInquiryId: srcInstruction.lInquiryId};
    if (srcInstruction.lResultId != null && srcInstruction.lResultId != "") {
        json["lResultId"] = srcInstruction.lResultId;
    }
    //查询质押券信息
    bondsGrid.load(json, function () {
    	if(srcInstruction["vcEntrustDirection"]=="5"){
    		//成功查询后加载可用数据
     		queryVisible(bondsGrid.data, bondsGrid, true,function(){
     			setInstructField(srcInstruction);});
    	 }else{
    		 setInstructField(srcInstruction);
    	 }
    });
}
function setInstructField(srcInstruction){
	//放入对应的指令数据
    for (var key in srcInstruction) {
        var temp = nui.get(key);
        if (temp) {
            temp.setValue(srcInstruction[key]);
            if (key === "lFirstSettleDate" ||
                    key === "lTradeDate" ||
                    key === "lMaturitySettleDate") {
                	if(srcInstruction[key] && srcInstruction[key] !== 0){
                		temp.setValue(DateUtil.numStrToDate(srcInstruction[key].toString()));
                	}else{
                		temp.setValue(null);
                	}
                    
                }
        }
    }
  //填入交易对手
    if(!srcInstruction.vcCounterpartyId){
    	nui.get("vcCounterpartyId").setValue(srcInstruction.vcCounterpartyName);
    }
    nui.get("vcCounterpartyId").setText(srcInstruction.vcCounterpartyName);
    //选择产品、产品组合、查询持仓
    nui.get("vcProductCode").setValue(srcInstruction.vcProductCode);
    nui.get("vcProductCode").setText(srcInstruction.vcProductName);
    fundCodeData[srcInstruction.vcProductCode] = {
    		L_PRODUCT_ID:srcInstruction.lProductId
    };
    selectFunds(srcInstruction.vcCombiCode);
    //计算申报代码
    if(srcInstruction.vcBizType === '5'){
    	caclSymbol(false,'5','1');
    }else if(srcInstruction.vcBizType === '6'){
    	caclSymbol(false,'5','5');
    }else if(srcInstruction.vcBizType === '7'){
    	caclSymbol(false,'1','1');
    }
    if(srcInstruction["vcEntrustDirection"]=="5"){
    	$("#vcEntrustDirectionLab:not(span)").css({"color":"red"});
    	vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.getFundBond.biz.ext?fundId="+srcInstruction.vcProductCode;
    }else if(srcInstruction["vcEntrustDirection"]=="6"){
    	$("#vcEntrustDirectionLab:not(span)").css({"color":"green"});
    	vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.queryBankBetweenBondCode.biz.ext";
    }else if(srcInstruction["vcEntrustDirection"]=="15"){
    	$("#vcEntrustDirectionLab:not(span)").css({"color":"red"});
    	vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.GetSSFundBond.biz.ext?fundId="+srcInstruction.vcProductCode;
    }else if(srcInstruction["vcEntrustDirection"]=="16"){
    	$("#vcEntrustDirectionLab:not(span)").css({"color":"green"});
    	vcStockCodeAuto.url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.querySHBondCode.biz.ext";
    }
	if(typeof changeMode != 'undefined'){
		changeMode();
	}
	//设置表单未变动
	fullDirection = new nui.Form("fullDirection");
	fullDirection.setChanged(false);
}
function selectFunds(e) {
    var fundCodeCombo = nui.get("vcProductCode");
    var vcCombiCombo = nui.get("vcCombiCode");
    var id = fundCodeCombo.getValue();
    nui.ajax({
        data: {vcProductCode: id, queryType: "'03'", lAssetId:lAssetId},
        url: "com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfoByProductCodeAndRealType.biz.ext",
        success: function (resp) {
            var returnJson = nui.decode(resp);
            if (returnJson.exception == null) {
                vcCombiCombo.setValue("");
                if (resp.data) {
                    vcCombiCombo.load(resp.data);
                    if (typeof e === "object" || typeof e === "undefined") {
                        vcCombiCombo.select(0);
                    } else {
                        vcCombiCombo.setValue(e);
                    }
                }
                //查询持仓
                //queryVunitStock();
                getEnFundValue();
                //getEnGhBalance();
                getAviliable();
                allowOverdraft(vcCombiCombo.getValue(),'2');//查询是否能够透支
            } else {
                nui.alert("系统异常", "系统提示");
            }
        },
        //有错误码之后，把后面的错误提醒补齐。
        fail: function (resp) {
            alert(resp);
        }
    });
};
//计算剩余天数
function calEndincalDays(e){
	var lDelistingDate = e.record.lEndincalDate;//债券到期日
	if(lDelistingDate){
		var todayTime = DateUtil.DstrToDate(DateUtil.dateToString(today));
		var date = (DateUtil.numStrToDate(lDelistingDate)).getTime();
		var temp = (date-todayTime)/(1000*60*60*24);
		return temp.toFixed(0);
	}else{
		return "";
	}
}
//限制日期选择框最小选择日期
function limitTradeDate(e,id){
	if(e){
		var temp = DateUtil.DstrToDate(e);
		nui.get(id).minDate = temp;
	}else{
		var time = today.getTime() - 24*60*60*1000;
		nui.get(id).minDate = new Date(time);
	}
	
}
//Gird 中使用的renderer，把空字符串转换为0
function lLockQtyRD(e){
	if(e.row.lLockQty == null || e.row.lLockQty == ""){
		return 0;
	}else{
		return e.row.lLockQty;
	}
}
//调整页面布局方法
function adjustAmountInfo(){
	var width = parseFloat($("body").width());
	$("#amountInfo").css({
		width:(width - 545)+ "px"
	});
}

//列表中转译托管机构
function depository(e){
	return nui.getDictText("CF_JY_DJTGCS",e.row.vcDepository);
}
//债项评级
function vcBondAppraiseRD(e){
	return nui.getDictText("creditRating",e.row.vcBondAppraise);
}
//主体评级
function vcIssueAppraiseRD(e){
	
	return nui.getDictText("issuerRating",e.row.vcIssueAppraise);
}
//评级展望
function lRatingForecastRD(e){
	return nui.getDictText("ratingOutlook",e.row.lRatingForecast);
}
//评级机构
function vcBondAppraiseOrganRD(e){
	
	return nui.getDictText("outRatingOrgan",e.row.vcBondAppraiseOrgan);
}
function atsFmIssueProperty(e){
	return nui.getDictText("ATS_FM_ISSUE_PROPERTY",e.row.vcIssueProperty);
}
//净价全价四舍五入
function priceFixed(e){
	if(e.value){
		return Number(e.value).toFixed("4");
	}else{
		return "";
	}
	
}

var searchWidth = "";
var isClose = true;


var arrayIds = "s";
/* ******************************************
 * 公共业务方法 end
 ********************************************/

$(function(){
	$("#enSettleAmount .mini-buttonedit-button").remove();
	$("#enRepoInterest .mini-buttonedit-button").remove();
	$("#lRepoDays .mini-buttonedit-button").remove();
	$("#enFundValue .mini-buttonedit-button").remove();
	$("#enFaceAmount .mini-buttonedit-button").remove();
	$("#enFullPriceAmount .mini-buttonedit-button").remove();
	$("#enMiddleInterest .mini-buttonedit-button").remove();
});
