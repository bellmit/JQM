<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp"%>
<!--
  - Author(s): 创金合信
  - Date: 2016-09-08 09:20:10
  - Description:
-->
<head>
<title>终止指令/建议</title>
<META HTTP-EQUIV="Pragma" CONTENT="public">
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<style type="text/css">
.infoLabel2 {
	width: 250px;
	float: left;
	height: auto;
	margin-top: 10px;
}

.infoLabel2>label:first-of-type {
	float: left;
	text-align: right;
	width: 120px;
	display: block;
}

.infoLabel2>label>span {
	color: red;
}

.searchDiv>span {
	text-align: right;
}

.button {
	margin: 0 auto;
}
</style>
</head>
<body>
	<fieldset>
		<legend>原交易要素</legend>
		<div id="oldInstructInfo" style="padding-top: 5px; height: auto; width: 100%;">
			<div class="infoLabel2">
				<label> 产品代码 </label><input id="vcFundCode" class="nui-textbox"
					enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> 产品名称 </label><input id="vcFundName" class="nui-textbox"
					enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> 回购天数 </label><input id="lRedeemDays" class="nui-textbox"
					enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> 组合名称 </label><input id="vcCombiName" class="nui-textbox"
					enabled="false" />
			</div>
		
			<div class="infoLabel2">
				<label> 委托方向 </label><input id="cEntrustDirection"
					class="nui-textbox" enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> 到期结算日期 </label>
					<input class="nui-datepicker"
					id="lSecondSettleDate" allowInput="false"
					name="lSecondSettleDate"  enabled="false"  />
			</div>
			<div class="infoLabel2">
				<label> 回购日期 </label>
				<input class="nui-datepicker"
					id="lHgDate" allowInput="false"
					name="lHgDate"  enabled="false"  />
			</div>
			<div class="infoLabel2">
				<label> 占款天数 </label><input id="lContractPeriods_"
					class="nui-textbox" enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> 交易对手 </label><input id="rivalName"
					class="nui-textbox" enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> 回购利率(%) </label><input id="enHgRatio"
					class="nui-textbox" enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> 回购金额(元) </label><input id="enHgBalance"
					class="nui-spinner" minValue="0" maxValue="10000000000" format="n2"
					enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> 成交编号 </label><input id="lDailyInstructionNo_"
					class="nui-textbox" enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> 质押券代码 </label><input id="vcPledgeCode" class="nui-textbox"
					enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> 券面金额(元) </label><input id="faceAmount" class="nui-spinner" minValue="0" maxValue="10000000000" format="n2"
					class="nui-textbox" enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> 质押券名称 </label><input id="vcPledgeCodeName" class="nui-textbox"
					enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> 质押比例(%) </label><input id="enPledgeRatio" class="nui-textbox"
					enabled="false" />
			</div>
		</div>
	</fieldset>
	<fieldset>
		<legend>终止后要素</legend>
		<div id="DirectionInfo"
			style="padding-top: 5px; height: auto; width: 100%;">
			<div class="infoLabel2">
				<label> 终止日期 </label> <input id="lTerminationDate"
					name="lTerminationDate" enabled="false" class="nui-datepicker"
					required="true" />
			</div>
			<div class="infoLabel2">
				<label> 终止后实际回购天数</label> <input id="lRepoDays" name="lRepoDays"
					class="nui-textbox" enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> <span>*</span> 实际回购利率(%)
				</label> <input id="enRepoRate" name="enRepoRate" class="nui-textbox"
					required="true" vtype="float" onblur="calEmFaceAmount()" />
			</div>
			<div class="infoLabel2">
				<label> 终止后实际占款天数</label> <input id="lContractPeriods"
					name="lContractPeriods" class="nui-textbox" enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> 实际结算金额(元) </label><input id="enSettleAmount"
					name="enSettleAmount" class="nui-spinner" minValue="0" maxValue="100000000000000" format="n2" enabled="false" />
			</div>
			<div class="infoLabel2">
				<label> 终止后实际回购利息</label><input id="enRepoInterest"
					name="enRepoInterest" class="nui-spinner" minValue="0" maxValue="100000000000000" format="n2" enabled="false" />
			</div>
			<div class="infoLabel2" style="width: 100%;">
				<label>备注 </label><input id="vcRemark" name="vcRemark"
					class="nui-textarea" style="width: 400px;" />
			</div>
			<!--<div class="infoLabel2" style="width: 100%;">
				<label>附件 </label> <input id="" name="" class="nui-htmlfile"
					limitType="" style="width: 400px;" />
			</div>-->
			<div class="infoLabel2" style="width: 100%;">
				<a class="nui-button button" onclick="onCancel"
					style="float: right; margin-left: 10px;" iconCls="icon-cancel">取消</a>
				<a class="nui-button button" onclick="sendDirective"
					iconCls="icon-ok" style="float: right;"> 指令/建议下达</a>
			</div>
		</div>
	</fieldset>

	<script type="text/javascript">
    var ATS_SUCCESS = <%= com.cjhxfund.commonUtil.Constants.ATS_SUCCESS %>;
    var ATS_ERROR = <%= com.cjhxfund.commonUtil.Constants.ATS_ERROR %>;
    var ATS_ORDER_OVER_DEAL_TIME = <%= com.cjhxfund.commonUtil.Constants.ATS_ORDER_OVER_DEAL_TIME %>;
    var ATS_ORDER_NO_RCV_FR_O32 = <%= com.cjhxfund.commonUtil.Constants.ATS_ORDER_NO_RCV_FR_O32 %>;
    var ATS_RISK_VIOLATE_FORBID_CTRL = <%= com.cjhxfund.commonUtil.Constants.ATS_RISK_VIOLATE_FORBID_CTRL %>;
</script>
	<script type="text/javascript"
		src="/ats/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>

	<script type="text/javascript">
    nui.parse();
	$("#oldInstructInfo .mini-buttonedit-button").remove();
	$("#DirectionInfo .mini-buttonedit-button").remove();
	var searchThgregister = null;
	var bond = {};
    //获取主页面传参，赋到对应字段
    function SetData(instructParameter,recall) {
        directionParam = instructParameter;
        searchThgregister = recall;
        var data = instructParameter.instructParameter;
        for (var key in data) {
            var temp = nui.get(key);
            if (temp) {
                temp.setValue(data[key]);
            }
        }
        nui.get("enRepoRate").setValue(data["enHgRatio"]);
        
        //设置券面金额
        var faceAmount = mul(100,data.enPledgeAmount );
		nui.get("faceAmount").setValue(faceAmount);
		//设置委托方向
		var cEntrustDirection = nui.getDictText("entrustDirection", data.cEntrustDirection);
		nui.get("cEntrustDirection").setValue(cEntrustDirection);
		//计算原占款天数
		var lFirstSettleDate =  DateUtil.numStrToDate(data.lFirstSettleDate);
		var lSecondSettleDate = DateUtil.numStrToDate(data.lSecondSettleDate);
		var lContractPeriods_ = (lSecondSettleDate.getTime() - lFirstSettleDate.getTime()) / 86400000;
		nui.get("lContractPeriods_").setValue(lContractPeriods_);
		//设置指令/建议新信息
        setDateInfo();
        getBondInfo(data['vcPledgeCode'],data['vcCombiNo']);
    }
    function getBondInfo(vcStockCode,vcCombiNo){
    debugger;
    	nui.ajax({
        data: {param:{'vcStockCode':vcStockCode,'vcCombiNo':vcCombiNo,'vcMarketNo':'1'}},
        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.QuerySSBondInfo.biz.ext",
        success: function (resp) {
        
        	var bonds = resp.bonds;
            if (bonds && bonds.length>0) {
            	bond = bonds[0];
            }
        },
        //有错误码之后，把后面的错误提醒补齐。
        fail: function (resp) {
            nui.alert(resp);
        }
    });
    }
    function setDateInfo() {
        //设置终止日期默认为当天
        var lTerminationDate = DateUtil.dateToString(new Date());
        nui.get("lTerminationDate").setValue(lTerminationDate);
        //终止日期
        var temp = nui.get("lHgDate").getValue();
        temp = temp.slice(0,temp.indexOf(" "));
        var lHgDate = DateUtil.DstrToDate(temp);
        var lTerminationDateTime = DateUtil.DstrToDate(lTerminationDate).getTime();
        //设置回购天数
        var lRepoDays = (lTerminationDateTime - lHgDate.getTime()) / 86400000;
        nui.get("lRepoDays").setValue(lRepoDays);
        //终止后占款天数
        nui.get("lContractPeriods").setValue((lTerminationDateTime - lHgDate.getTime()) / 86400000);
        //计算利息
        calEmFaceAmount();
    }

    //计算实际回购利息和实际结算金额
    function calEmFaceAmount() {
    
        var enFaceAmountVal = nui.get("enHgBalance").getValue(); //回购金额:enFaceAmount
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
        var lContractPeriods = Number(nui.get("lContractPeriods").getValue() ? nui.get("lContractPeriods").getValue() : 0);
        //利息
        var interest = div(mul(mul(div(enRepoRateVal, 100), enFaceAmountVal), lContractPeriods), 365);
        enRepoInterest.setValue(interest.toFixed(2));
        //到期结算金额
        var amount = add(interest, enFaceAmountVal);
        amount = amount.toString();
        var temp2 = amount.indexOf('.');
        if (temp2 > 0) {
            amount = amount.slice(0, temp2 + 3);
        }
        nui.get("enSettleAmount").setValue(amount);
    }

    //组装完整指令/建议参数
    var directionParam = {};
		function combiDireParam() {
			var form = new nui.Form("#DirectionInfo");
			form.validate();
			if (form.isValid() == false){
    	return;
    }
			var conData = form.getData(); //获取表单多个控件的数据

			var lTerminationDate = conData.lTerminationDate;
			directionParam.instructParameter["lMaturitySettleDate"] = DateUtil.toNumStr(lTerminationDate); //到期结算日(终止日期)
			directionParam.instructParameter["enSettleAmount"] = conData.enSettleAmount; //到期结算金额
			directionParam.instructParameter["lContractPeriods"] = conData.lContractPeriods; //占款天数
			directionParam.instructParameter["enRepoRate"] = conData.enRepoRate;//回购利率
			directionParam.instructParameter["enRepoInterest"] = conData.enRepoInterest;//回购利息
			directionParam.instructParameter["lRepoDays"] = conData.lRepoDays;//实际回购天数
			directionParam.instructParameter["vcRemark"] = conData.vcRemark;//备注
			directionParam.instructParameter["vcProductCode"] = directionParam.instructParameter.vcFundCode;
			directionParam.instructParameter["vcProductName"] = directionParam.instructParameter.vcFundName;
			directionParam.instructParameter["vcCombiCode"] = directionParam.instructParameter.vcCombiNo;
			directionParam.instructParameter["vcCombiName"] = directionParam.instructParameter.vcCombiName;
			directionParam.instructParameter["lTradeDate"] = DateUtil.toNumStr(new Date());
			directionParam.instructParameter["symbol"] = directionParam.instructParameter.vcHgCode; //申报代码
			directionParam.instructParameter["vcStockCode"] = directionParam.instructParameter.vcHgCode; 
            directionParam.instructParameter["vcStockName"] = directionParam.instructParameter.vcHgCodeName;
            directionParam.instructParameter["lSerialNo"] = directionParam.instructParameter.lSerialNo; //O32流水号
            directionParam.instructParameter["vcQuoteMode"] = 1; //报价方式,固定利率。
            directionParam.instructParameter["enFaceAmount"] = directionParam.instructParameter.enHgBalance / 10000;//回购金额
            
			directionParam.instructParameter["instructCategory"] = "1"; //用来传给流程判断1、完整指令/建议  0、询价指令/建议
			directionParam.instructParameter["vcProcessStatus"] = "1"; //流程状态
			directionParam.instructParameter["lFixValidStatus"] = "0";//用于判断指令/建议是否发送O32以及发送结果：0-未发送,1-修改后未发送,2-发送中,3-发送成功,4-发送失败
			directionParam.instructParameter["symbol"] = ""; //申报代码
			directionParam.instructParameter["businClass"] = 1; //	1 交易所业务
			directionParam.instructParameter["vcInvestType"] = 1; //	1(投资类型：交易所，1-可交易；2-持有到期；3-可供出售；回购业务投资类型为1-可交易，不传投资类型会根据系统数决定取组合的投资类型或缺省为1-可交易)
			directionParam.instructParameter["exdestination"] = "SS"; //	OTC(交易市场:OTC 场外)
			directionParam.instructParameter["ordtype"] = 2; //	2 (【前端设置2】 40-证券控制类型:1-金额控 、2-数量控、缺省按2-数量控)
			directionParam.instructParameter["vcFirstSettleMode"] = 3; //	3(【前端设置3】13204-结算方式（首次结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户)
			directionParam.instructParameter["vcMaturitySettleMode"] = 3; //	3(【前端设置3】13208-结算方式（到期结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户)
			directionParam.instructParameter["timeinforce"] = 6; //	6(指令/建议有效模式，默认为0-Day：0 – Day，当日有效；1 – GTC，一直有效，直到完成或撤销；6 – GTD，到指定日前有效)
			directionParam.instructParameter["vcInstructionlevel"] = 1; //【前端设置】指令/建议操作级别:0无 1快速 2一般 3慢速
			directionParam.instructParameter["judgeavailable"] = 1; //1(判断可用：0-不判；1-判)
			directionParam.instructParameter["judgerisk"] = 0; //	1(判断风控：0-不判；1-判)
			directionParam.instructParameter["vcBizType"] = 7; //业务类别：1-银行间二级交易，2-上海大宗交易，3-上海固收平台，4-深圳综合协议平台，5-银行间质押式回购，6-银行间买断式回购，7-交易所协议式回购
			directionParam.instructParameter["vcInstructType"] = 1; //(指令/建议类型：1完整指令/建议，2询价指令/建议)
			directionParam.instructParameter['vcMarket'] = 'SS';
			var direction = nui.getDictText("entrustDirection", directionParam.instructParameter["cEntrustDirection"]);
			if(direction.indexOf("逆") >= 0){
				directionParam.instructParameter["vcEntrustDirection"] = 18;
			}else{
				directionParam.instructParameter["vcEntrustDirection"] = 17;
			}
			directionParam.instructParameter["vcSettleSpeed"] = "0"; //清算速度
			
			
			directionParam.instructParameter['tIssueTime'] = DateUtil.toNumStr(new Date());       //指令/建议下达时间
			//组装质押券信息
			directionParam.bonds = bond;
			directionParam.bonds['vcCombiNo'] = directionParam.instructParameter.lPledgeBasecombiId;
			directionParam.bonds['vcCombiCode'] = directionParam.instructParameter.lPledgeBasecombiId;
			directionParam.bonds['vcReportCode'] = directionParam.instructParameter.vcPledgeCode;
			directionParam.bonds['vcStockCode'] = directionParam.instructParameter.vcPledgeCode;
			directionParam.bonds['vcExchange'] = 'SS';
			directionParam.bonds['vcMarket'] = 'SS';
			directionParam.bonds['vcStockName'] = directionParam.instructParameter.vcPledgeCodeName; 
			directionParam.bonds['enMortagageRatio'] = directionParam.instructParameter.enPledgeRatio; //质押比率
			directionParam.bonds['enParvalue'] = 100; //面值
			
			directionParam.bonds['enFaceAmount'] = nui.get("faceAmount").getValue();
			
			return directionParam ;
		}

    //下达指令/建议
    function sendDirective() {
        var param = combiDireParam();
        if (!param) {
            return false;
        }
        a = nui.loading("正在处理中,请稍等...", "提示");
        nui.ajax({
            url: "com.cjhxfund.ats.sm.comm.InstructionManager.insertInstruct.biz.ext",
            type: 'POST',
            data: param,
            cache: false,
            contentType: 'text/json',
            success: function (e) {
                if (e.exception == null) {
                    if (e.rtnCode == ATS_ERROR) {
									nui.alert("指令/建议下达失败。", "提示");
								} else if(e.rtnCode == '0202'){
									nui.alert("可用数量不足！", "提示");
								}else{
								searchThgregister();
								setTimeout("window.CloseOwnerWindow();",1500);
								mini.showTips({
			 			            content: "指令/建议下达成功。",
			 			            state: "success",
			 			            x: "top",
			 			            y: "top",
			 			            timeout: 1500
			 			            
			 			        });
								}
                } else {
                    nui.alert("系统异常", "系统提示");
                }
                nui.hideMessageBox(a);
            }
        });
    }

    function onCancel(e) {
        window.CloseOwnerWindow();
    }

    //数字校验公共方法
    function valiNum(value) {
        var reg = /^\d+(\.\d+)?$/;//正则
        if (!reg.test(value)) {
            return false;
        }
        return true;
    }

</script>
	<script type="text/javascript"
		src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
	<script type="text/javascript"
		src="<%= request.getContextPath() %>/repurchase/invest/protocol_repo/js/protocalCom.js"></script>
</body>
</html>