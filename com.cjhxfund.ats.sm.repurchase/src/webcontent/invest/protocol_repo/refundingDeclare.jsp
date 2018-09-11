<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!--
  - Author(s): 罗倔怀
  - Date: 2016-09-08 09:20:10
  - Description:
-->
<head>
    <title>换券申报</title>
    <META HTTP-EQUIV="Pragma" CONTENT="public">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <style type="text/css">
        .infoLabel2 {
            width: 250px;
            float: left;
            height: auto;
            margin-top: 10px;
        }

        .infoLabel2 > label:first-of-type {
            float: left;
            text-align: right;
            width: 100px;
            display: block;
        }

        .infoLabel2 > label > span {
            color: red;
        }

        .searchDiv > span {
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
		<legend>换券后要素</legend>
		<div  style="padding-top: 5px; height: auto; width: 100%;">
		<form id="DirectionInfo">
			<div class="infoLabel2">
				<label><span>*</span>新质押券代码 </label>
				<div name="vcStockCode" class="mini-autocomplete" id="vcStockCode"
				                                 textField="stockCode" valueField="stockName"
				                                 searchField="stockCode"
				                                 url="com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.GetSSFundBond.biz.ext"
				                                 allowInput="true"
				                                 emptyText="请选择..."
				                                 nullItemText="请选择..."
				                                 valueFromSelect="true"
				                                 dataField="bondList"
				                                 multiSelect="false"
				                                 showClose="true"
				                                 oncloseclick="onCloseClick"
				                                 style="width:125px"
				                                 onblur="getStockName"
				                                 required="true" 
				                                 popupWidth="300">
		                                	<div property="columns">
			                                    <div header="债券代码" field="stockCode" width="40px"></div>
			                                    <div header="债券名称" field="stockName"></div>
		                                	</div>
	                            		</div>
			</div>
			<div class="infoLabel2">
				<label> 新质押券名称 </label><input id="vcStockName" class="nui-textbox" enabled="false"/>
			</div>
			<div class="infoLabel2">
				<label> 新券面金额(元) </label><input id="enFaceAmount2"
					 class="nui-spinner" minValue="0" maxValue="10000000000" format="n2" enabled="false" />
			</div>
			
			<div class="infoLabel2">
				<label> <span>*</span>质押数量 </label><input id="lMortagageAmount" required="true"  class="nui-textbox" onvaluechanged="calcEnFaceAmount2" />
			</div>
			<div class="infoLabel2">
				<label> 新质押比例(%) </label><input id="enRatio" class="nui-textbox" enabled="false" />
			</div>
			<div class="infoLabel2">
				<label>备注</label> <input class="nui-textbox" showClose="true"
					id="vcRemark" name="vcRemark" />
			</div>

			<div class="infoLabel2" style="width: 100%; float: right;">
				<a class="nui-button button"
					onclick="onCancel" style="float:right;margin-left:10px;" iconCls="icon-cancel">取消</a>
				<a class="nui-button button" onclick="sendDirective"
					iconCls="icon-ok" style="float:right;"> 指令/建议下达</a>
			</div>
                </form>
		</div>
	</fieldset>
	<script type="text/javascript">
		nui.parse();
		$("#oldInstructInfo .mini-buttonedit-button").remove();
		$("#DirectionInfo .mini-buttonedit-button").remove();
		var directionParam = {};
		var searchThgregister = null;
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
		nui.get("vcStockCode").url = "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.GetSSFundBond.biz.ext?fundId="+data.vcFundCode;
    }

		//组装完整指令/建议参数
		function combiDireParam() {
			var form = new nui.Form("#DirectionInfo");
			form.validate();
			if (form.isValid() == false){
    	return;
    }
			var conData = form.getData(); //获取表单多个控件的数据
			
			//加入表单字段
			debugger;
            directionParam.instructParameter["lFirstSettleDate"] = DateUtil.toNumStr(nui.get("lHgDate").getValue());
			directionParam.instructParameter["lMaturitySettleDate"] = directionParam.instructParameter.lSecondSettleDate; //到期结算日
			directionParam.instructParameter["enFaceAmount"] = nui.get("enHgBalance").getValue() / 10000; //到期结算日
			directionParam.instructParameter["enSettleAmount"] = directionParam.instructParameter.enContractBalance; //到期结算金额
			directionParam.instructParameter["lContractPeriods"] = nui.get("lContractPeriods_").getValue(); //占款天数
			directionParam.instructParameter["enRepoRate"] = directionParam.instructParameter.enHgRatio;//回购利率
			directionParam.instructParameter["enRepoInterest"] = directionParam.instructParameter.enRedeemInterest;//回购利息
			directionParam.instructParameter["lRepoDays"] = directionParam.instructParameter.lRedeemDays;//回购天数
			directionParam.instructParameter["vcRemark"] = conData.vcRemark;//备注
			directionParam.instructParameter["vcProductCode"] = directionParam.instructParameter.vcFundCode;
			directionParam.instructParameter["vcProductName"] = directionParam.instructParameter.vcFundName;
			directionParam.instructParameter["vcCombiCode"] = directionParam.instructParameter.vcCombiNo;
			directionParam.instructParameter["vcCombiName"] = directionParam.instructParameter.vcCombiName;
			directionParam.instructParameter["lTradeDate"] = DateUtil.toNumStr(new Date());
			directionParam.instructParameter["symbol"] = directionParam.instructParameter.vcHgCode; //申报代码
			directionParam.instructParameter["vcStockCode"] = directionParam.instructParameter.vcHgCode; 
            directionParam.instructParameter["vcStockName"] = directionParam.instructParameter.vcHgCodeName;
			directionParam.instructParameter["vcQuoteMode"] = 1; //报价方式,固定利率。
			directionParam.instructParameter["lSerialNo"] = directionParam.instructParameter.lSerialNo; //O32流水号
			//默认值      .instructParameter
			directionParam.instructParameter["instructCategory"] = "1"; //用来传给流程判断1、完整指令/建议  0、询价指令/建议
			directionParam.instructParameter["vcProcessStatus"] = "1"; //流程状态
			directionParam.instructParameter["lFixValidStatus"] = "0";//用于判断指令/建议是否发送O32以及发送结果：0-未发送,1-修改后未发送,2-发送中,3-发送成功,4-发送失败
			directionParam.instructParameter["symbol"] = ""; //申报代码
			directionParam.instructParameter["businClass"] = 1; //	1 交易所业务
			directionParam.instructParameter["vcInvestType"] = 1; //	1(投资类型：交易所，1-可交易；2-持有到期；3-可供出售；回购业务投资类型为1-可交易，不传投资类型会根据系统数决定取组合的投资类型或缺省为1-可交易)
			directionParam.instructParameter["exdestination"] = "SS"; // 上交所业务
			directionParam.instructParameter["ordtype"] = 2; //	2 (【前端设置2】 40-证券控制类型:1-金额控 、2-数量控、缺省按2-数量控)
			directionParam.instructParameter["vcFirstSettleMode"] = 3; //	3(【前端设置3】13204-结算方式（首次结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户)
			directionParam.instructParameter["vcMaturitySettleMode"] = 3; //	3(【前端设置3】13208-结算方式（到期结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户)
			directionParam.instructParameter["timeinforce"] = 6; //	6(指令/建议有效模式，默认为0-Day：0 – Day，当日有效；1 – GTC，一直有效，直到完成或撤销；6 – GTD，到指定日前有效)
			directionParam.instructParameter["vcInstructionlevel"] = 1; //【前端设置】指令/建议操作级别:0无 1快速 2一般 3慢速
			directionParam.instructParameter["judgeavailable"] = 1; //1(判断可用：0-不判；1-判)
			directionParam.instructParameter["judgerisk"] = 1; //	1(判断风控：0-不判；1-判)
			directionParam.instructParameter["vcBizType"] = 7; //业务类型:协议式换券指令/建议 (1-银行间二级交易，2-上海大宗交易，3-上海固收平台，4-深圳综合协议平台，5-银行间质押式回购，6-银行间买断式回购，7-交易所协议式回购)
			directionParam.instructParameter["vcInstructType"] = 1; //(指令/建议类型：1完整指令/建议，2询价指令/建议)
			var direction = nui.getDictText("entrustDirection", directionParam.instructParameter["cEntrustDirection"]);
			if(direction.indexOf("逆") >= 0){
				directionParam.instructParameter["vcEntrustDirection"] = 27;
			}else{
				directionParam.instructParameter["vcEntrustDirection"] = 26;
			}
			directionParam.instructParameter["vcSettleSpeed"] = "0"; //清算速度
			
			directionParam.instructParameter['tIssueTime'] = DateUtil.toNumStr(new Date());       //指令/建议下达时间
			
			//组装质押券信息
			directionParam.bonds['vcCombiNo'] = directionParam.instructParameter.vcPledgeCombiNo;
			directionParam.bonds['vcCombiCode'] = directionParam.instructParameter.vcPledgeCombiNo;
			directionParam.bonds['vcReportCode'] = nui.get("vcStockCode").getText();
			directionParam.bonds['vcStockCode'] = nui.get("vcStockCode").getText();
			directionParam.bonds['vcStockName'] = nui.get("vcStockCode").getValue(); 
			directionParam.bonds['vcExchange'] = 'SS';
			directionParam.bonds['enFaceAmount'] = nui.get("faceAmount").getValue();
			directionParam.bonds['enMortagageRatio'] = nui.get("enPledgeRatio").getValue(); //质押比率			
			directionParam.bonds['vcMortagageQty'] = nui.get("lMortagageAmount").getValue(); //质押数量
			
			directionParam.bonds['enParvalue'] = 100; //面值
			
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
						url : "com.cjhxfund.ats.sm.comm.InstructionManager.insertInstruct.biz.ext",
						type : 'POST',
						data : param,
						cache : false,
						contentType : 'text/json',
						success : function(e) {
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
		function getStockName(){
			nui.get("vcStockName").setValue(nui.get("vcStockCode").getValue());
			var enFaceAmount2 = nui.get("enFaceAmount2");
			var lMortagageAmount = nui.get("lMortagageAmount");			
			var enRatio = nui.get("enRatio");
			var faceAmount = nui.get("faceAmount").getValue();
			enFaceAmount2.setValue(faceAmount);
			enRatio.setValue(100);
			lMortagageAmount.setValue(faceAmount / 100);
		}
		//计算新的券面总额
		function calcEnFaceAmount2(e){
			if(!ispositiveNum(e.value)){
				return;
			}
			var enFaceAmount2 = nui.get("enFaceAmount2"); //新券面金额输入框
			var faceAmountValue = nui.get("faceAmount").getValue(); //券面金额
			var enPledgeRatio = nui.get("enPledgeRatio").getValue();
			var temp = mul(faceAmountValue,enPledgeRatio); //老质押金额
			var newFaceAmount = mul(e.value,100);
			enFaceAmount2.setValue(newFaceAmount);//写入新券面金额
			var enRatio = div(temp,newFaceAmount);
			if(enRatio>100){
				mini.showTips({
 			            content: "质押比率不能超过100噢。",
 			            state: "warning",
 			            x: "top",
 			            y: "top",
 			            timeout: 2000
 			        });
			}
			nui.get("enRatio").setValue(enRatio);
		}
		
	var ATS_SUCCESS = <%= com.cjhxfund.commonUtil.Constants.ATS_SUCCESS %>;
    var ATS_ERROR = <%= com.cjhxfund.commonUtil.Constants.ATS_ERROR %>;
    var ATS_ORDER_OVER_DEAL_TIME = <%= com.cjhxfund.commonUtil.Constants.ATS_ORDER_OVER_DEAL_TIME %>;
    var ATS_ORDER_NO_RCV_FR_O32 = <%= com.cjhxfund.commonUtil.Constants.ATS_ORDER_NO_RCV_FR_O32 %>
    var ATS_RISK_VIOLATE_FORBID_CTRL = <%= com.cjhxfund.commonUtil.Constants.ATS_RISK_VIOLATE_FORBID_CTRL %>;
	</script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/repurchase/invest/protocol_repo/js/protocalCom.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
</body>
</html>