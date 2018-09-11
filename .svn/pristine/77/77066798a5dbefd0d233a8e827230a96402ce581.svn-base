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
function closewindow(){
	window.CloseOwnerWindow();
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