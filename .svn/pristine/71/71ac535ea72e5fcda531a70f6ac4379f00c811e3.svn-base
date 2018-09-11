/**
 * Created by luojuehuai on 2017/02/14.
 * 描述：协议式回购公共js
 */
var symbol = ""; //申报代码
var symbolName = ""; //申报名称
		//实现精确乘
function mul(a, b) {
    var c = 0,
        d = a.toString(),
        e = b.toString();
    try {
        c += d.split(".")[1].length;
    } catch (f) {}
    try {
        c += e.split(".")[1].length;
    } catch (f) {}
    return Number(d.replace(".", "")) * Number(e.replace(".", "")) / Math.pow(10, c);
}
//除法函数
function div(a, b) {
    var c, d, e = 0,
        f = 0;
    try {
        e = a.toString().split(".")[1].length;
    } catch (g) {}
    try {
        f = b.toString().split(".")[1].length;
    } catch (g) {}
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

//正整数校验
var ispositiveNum = function(value){
    var reg = /^[1-9]\d*$/;//正则
    if (!reg.test(value)) {
        return false;
    }
    return true;
};

var positiveNum = function(e){
	var reg = /^[1-9]\d*$/;
	if (!reg.test(e.value)){
		e.errorText = "必须输入正整数！";
        e.isValid = false;
	}
};
var positiveFloProtocol = function(e){
	var reg = /^[0-9]+(.[0-9]{1,3})?$/;//小数点后三位的正实数
	if (!reg.test(e.value) || e.value > 100000){
		e.errorText = "必须输入小于十万的正数，且小数点只能保留后三位！";
        e.isValid = false;
	}else{
		
	}
};
//查询可用数量数据
function queryVisible(bondData){
	 
	 nui.ajax({
	        data: {'vunitstockLists': VunitData,"vcMarket":'SS'}, //市场编号为上交所
	        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.queryVisible.biz.ext",
	        success: function (resp) {
	        	
	        }
	 });
	 
}
//获取申报代码、申报名称
var caclSymbol = function (days,cMarketNo,cParameterType) {
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
        	}else{
        		mini.showTips({
			            content: "没有查询到与回购天数相应的申报代码和申报名称，建议去O32维护。",
			            state: "warning",
			            x: "top",
			            y: "top",
			            timeout: 10000
			        });
        	}
        }
    });
};
//页面X的删除功能
function onCloseClick(e) {
    var obj = e.sender;
    obj.setText("");
    obj.setValue("");
}