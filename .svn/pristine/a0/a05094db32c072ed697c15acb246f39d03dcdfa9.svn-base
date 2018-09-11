<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp"%>
<!-- 
  - Author(s): 创金合信
  - Date: 2016-09-08 09:30:49
  - Description:
-->
<head>
<title>添加锁定券</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

</head>
<body>

	<form id="form1" method="post">
		<input name="id" class="nui-hidden" />
		<div id="main" style="width: 100%; height: 220px;">
			<div id="left" style="float: left; width: 65%; height: 100%;">
				<table style="table-layout: fixed;">
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;产品名称 
							<div name="vcProductCode" 
								class="nui-combobox" pinyinField="vcProductCode" id="vcProductCode"
                            	textField="vcProductName" valueField="vcProductCode"
								url="com.cjhxfund.ats.sm.comm.TBondLockInfoManager.queryProductHandleByRealTypes.biz.ext?realType='01','02','04'"
								showNullItem="false"
								allowInput="true" 
								emptyText="请输入产品代码或产品名称..."
								nullItemText="请输入产品代码或产品名称..."
								valueFromSelect="true"
								showClose="true"
								onvaluechanged="selectFund" 
								style="width:70%;"
								oncloseclick="onCloseClick"
								required="true" 
								popupWidth="300">
	                            <div property="columns">
	                                <div header="产品代码" field="vcProductCode" width="40px"></div>
	                                <div header="产品名称" field="vcProductName"></div>
	                            </div>
	                        </div>
    					</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;组合名称 <input
							name="vcCombiCode" class="nui-combobox" id="vcCombiCode"
							textField="TEXT" valueField="ID" dataField="data"
							url="com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfoByProductCodeAndRealType.biz.ext"
							showNullItem="false" allowInput="false"
							onvaluechanged="selectT0" emptyText="请选择" nullItemText="请选择"
							showClose="true" oncloseclick="onCloseClick" style="width: 70%;"
							valueFromSelect="true"
							required="true" />
						</td>
					</tr>

					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;交易市场 <input
							class="nui-dictcombobox" id="vcMarket" name="vcMarket"
							valueField="dictID" textField="dictName" dictTypeId="tradePlace"
							emptyText="请选择" showClose="true" 
							oncloseclick="onCloseClick" 
							onvaluechanged='clearStockCode'
							valueFromSelect="true"
							style="width: 70%" required="true" />
						</td>
					</tr>
					
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;债券代码
							<div name="vcStockCode" class="nui-autocomplete"
								popupEmptyText="请选择"
								id="vcStockCode" 
								textField="stockCode" 
								valueField="stockCode"
								searchField="stockCode"
								url="com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.queryTbondCodeList.biz.ext"
								showNullItem="false" 
								allowInput="true" 
								emptyText="请选择"
								nullItemText="请选择" 
								valueFromSelect="true" 
								dataField="bondList"
								multiSelect="false" 
								showClose="true" 
								style="width: 70%;"
								oncloseclick="onCloseClick" 
								onvaluechanged='selectT0'
								onvalidation="O32ExistCheck"
								popupWidth="300" 
								required="true"								
								onBeforeLoad="getStockCode">
								<div property="columns">
									<div header="债券代码" field="stockCode" width="40px"></div>
									<div header="债券名称" field="stockName"></div>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;锁定类型 <input
							class="nui-dictcombobox" id="vcLockType" name="vcLockType"
							valueField="dictID" textField="dictName" dictTypeId="lockType"
							emptyText="请选择" showClose="true" oncloseclick="onCloseClick"
							style="width: 70%" required="true" />
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;锁定数量 <input
							id="lLockQty" name="lLockQty" class="nui-textbox"
							width="70%" required="true" onvaluechanged='lLockQtyValidate' />
						</td>
					</tr>
					<!--  
					<tr>
						<td>锁定开始日期 <input class="nui-datepicker" name="tLockTime" id="tLockTime"
							width="70%" required="true" allowInput="false" showTodayButton="true" ondrawdate="onDrawDate" readonly="true"/>
						</td>
					</tr>
					-->
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;锁定原因 <input
							name="vcLockReason" width="70%" class="nui-textbox"
							required="true" />
						</td>
					</tr>
				</table>
			</div>
			<div id="right"
				style="float: left; width: 0.3%; height: 100%; background: #000;">
			</div>
			<div id="formRight" style="float: left; width: 30%; height: 100%;">
				<table>
					<tr style="float: left; width: 100%; height: 100%;">
						<td>持仓数量 : <input class="nui-textbox" style="border-style:none" id="lCurrentAmount">
						</td>
					</tr>
					<tr style="float: left; width: 100%; height: 100%;">
						<td>T+0可卖数量 : <input class="nui-textbox" style="border-style:none" id="canSellAmount">
						</td>
					</tr>
					<tr style="float: left; width: 100%; height: 100%;">
						<td>T+0可质押数量 : <input class="nui-textbox" style="border-style:none" id="vcAvailablequantityT0">
						</td>
					</tr>
				</table>
			</div>
		</div>

		<div style="text-align: center;">
			<hr size="1" color="black">
			<a class='nui-button' plain='false' onclick="onOk"
				style="width: 60px; margin-right: 20px;">确定</a> <a
				class='nui-button' plain='false' onclick="onCancel" style="width: 60px;">取消</a>
		</div>
	</form>
	<script type="text/javascript">
		nui.parse();
		var formRight = new nui.Form("#formRight");

		//页面产品代码与产品组合combox联动
	    var fundCodeCombo = nui.get("vcProductCode");
	    var vcCombiCombo = nui.get("vcCombiCode");
	    var vcStockCombo = nui.get("vcStockCode");
	    var vcStockName = null;
	    //nui.get("tLockTime").setValue(new Date());
	    
        $(function(){
    		$("#vcStockCode>span>input").attr("placeholder","请输入债券代码...");
        });
		
	    //联动方法
	    var selectFund = function (e) {
	        var id = fundCodeCombo.getValue();
	        if(id == ""){
	        	vcCombiCombo.setValue("");
	        	return false;
	        }else{
	        	nui.ajax({
		            data: {
		            	vcProductCode: id,
		            	queryType: "'01','02','04'"	
		            },
		            url: "com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfoByProductCodeAndRealType.biz.ext",
		            success: function (resp) {
		                if (resp.data) {
		                    vcCombiCombo.load(resp.data);
		                    vcCombiCombo.select(0);
		                    queryAvailableQty();
		                }
		            },
		            //有错误码之后，把后面的错误提醒补齐。
		            fail: function (resp) {
		                alert(resp);
		            }
		        });
	        }      
	    };
	    
	    // 交易市场变化时清空债券代码
	    function clearStockCode(e) {
			vcStockCombo.setText("");
            vcStockCombo.setValue("");
			formRight.clear();
		}
	    
	    // 验证债券代码
	    function O32ExistCheck(e){
	    	var marketNo = nui.get("vcMarket").getValue();
	    	var stockCode = vcStockCombo.getText();
	    	var msg = null;
	    	if(stockCode == null || stockCode ==""){
    			return;
			}
			// 获取债券名称
			queryStockName();
	    	if(marketNo==null || marketNo==""){
	    		msg="交易市场不能为空!";
	    		nui.alert(msg);
	    		return;
	    	//}else{
	    		//if(!checkO32Exist({vcStockCode:e.value,vcMarketNo:marketNo})){
	    		//	msg="O32不存在此债券!";
	    		//	nui.alert(msg);
	    		//	return;
				//}
				//不能选择PPN类型的债券
				//if(vcStockName && (vcStockName.indexOf("PPN")>=0 || vcStockName.indexOf("ABN")>=0)){
			      //  msg="不能选择PPN、ABN类型债券！";
			      //  vcStockCombo.setText("");
		           // vcStockCombo.setValue("");
					//formRight.clear();
			     //   nui.alert(msg);
	    		//	return;
				//}
	    	}
	    }
	    
	    // 查询证券名称
	    function queryStockName() {
	    	var marketNo = nui.get("vcMarket").getValue();
	    	var vcStockCode = vcStockCombo.getText();
			var productCode = nui.get("vcProductCode").getValue();
			nui.ajax({
		        data: {'stockCode':vcStockCode,'fundId':productCode,'marketNo':marketNo,'selectType':'1'},
		        async: false,
		        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.queryTbondCodeList.biz.ext",
		        success: function (resp) {
		        	var bonds = resp.bondList;
		        	vcStockName = bonds[0].stockName;
		        },
		        //有错误码之后，把后面的错误提醒补齐。
		        fail: function (resp) {
		            nui.alert(resp);
		        }
		    });
		}
	    
	    //根据债券代码查询右侧展示信息
	    var selectT0 = function(e){
			//控制必须先输入产品和组合
			queryAvailableQty();
	    };
	    
	    // 查询可用数量
	    function queryAvailableQty(){
	    	// 获取交易市场
	    	var marketNo = nui.get("vcMarket").getValue();
	    	var vcStockCode = vcStockCombo.getValue();
	    	var combiCode = vcCombiCombo.getValue();
		    if(combiCode==null || combiCode=="" || marketNo==null || marketNo=="" || vcStockCode==null || vcStockCode==""){
		    	formRight.clear();
		    	return;
		    }
		    if(!checkO32Exist({vcStockCode:vcStockCode,vcMarketNo:marketNo})){
				nui.alert("O32不存在此债券");
				return;
			}
			var postionMarket = marketNo;
		    if(marketNo=="1"){
    			marketNo="SS";
    		}else if(marketNo=="2"){
    			marketNo="SZ";
    		}else if(marketNo=="5"){
    			marketNo="OTC";
    		}
			//组装查询质押数量条件
	    	var sendMsg = {};
	    	sendMsg.combis=[{vcProductCode:fundCodeCombo.getValue(),vcStockCode:vcStockCode,vcAccount:combiCode,vcMarket:marketNo,vcBusinType:"5",vcInvestType:"1"}];
	    	//组装查可卖数量条件
	    	var sendMsg2 = {};
	    	sendMsg2.combis=[{vcStockCode:vcStockCode,vcAccount:combiCode,vcMarket:marketNo,vcBusinType:"4",vcInvestType:"1"}];
	    	var lm = {vcProductCode:fundCodeCombo.getValue(),vcStockCode:vcStockCode,vcAccount:combiCode,vcMarket:postionMarket};
	        nui.ajax({
	            url: "com.cjhxfund.ats.sm.comm.TBondLockInfoManager.queryLockListCount.biz.ext",
	            type: "post",
	            data: {sendMsg:sendMsg,sendMsg2:sendMsg2,lm:lm},
	            contentType:'text/json',
	            success: function (resp,resp2) {
	                var returnJson = nui.decode(resp);
	                // 可卖数量
	                var resultAvaiList = returnJson.avaiList2;
	                // 可质押数量
	                var resultPledgeList = returnJson.avaiList;
					if(returnJson.exception == null){
						var canSellAmount;
						var vcAvailablequantityT0;
						var lCurrentAmount;
						if(returnJson.avaiList2.length <= 0){
							canSellAmount = 0;
						}else{
							canSellAmount = returnJson.avaiList2[0].VC_AVAILABLEQUANTITY_T0;
							if(canSellAmount < 0){
								canSellAmount = 0;
							}
						}
						if(returnJson.avaiList.length <= 0){
							vcAvailablequantityT0 = 0;
						}else{
							vcAvailablequantityT0 = returnJson.avaiList[0].VC_AVAILABLEQUANTITY_T0;
							if(vcAvailablequantityT0 < 0){
								vcAvailablequantityT0 = 0;
							}
						}
						if(returnJson.LCurrentAmount.length <= 0){
							lCurrentAmount = 0;
						}else{
							lCurrentAmount = returnJson.LCurrentAmount[0].lCurrentAmount;
							if(lCurrentAmount < 0){
								lCurrentAmount = 0;
							}
						}
						nui.get("canSellAmount").setValue(canSellAmount);
						nui.get("vcAvailablequantityT0").setValue(vcAvailablequantityT0);
						nui.get("lCurrentAmount").setValue(lCurrentAmount);
					}else{
						nui.alert("系统异常","系统提示");
					}
	            },
	            //有错误码之后，把后面的错误提醒补齐。
	            fail: function (resp) {
	                alert(resp);
	            }
	        });
		}
    	
		function onOk(e) {
			SaveData(e);
		}
		
		function onCancel(e) {
			window.CloseOwnerWindow();
		}
		
        function isNumber(v) {
        	var re = new RegExp("^-?\d+$");
            	if (re.test(v)) return true;
            return false;
        }
        
   		// 提交锁定券添加表单
		function SaveData() {
			
			var form = new nui.Form("#form1");
			form.setChanged(false);
			//保存
			form.validate();
			if (form.isValid() == false)
			return;
			var data = form.getData(false, true);
			queryAvailableQty();
			//组装查询质押数量条件
			var marketNo = nui.get("vcMarket").getValue();
	    	var vcStockCode = vcStockCombo.getValue();
	    	var combiCode = vcCombiCombo.getValue();
    		// 获取交易市场
			if(marketNo=="1"){
    			marketNo="SS";
    		}else if(marketNo=="2"){
    			marketNo="SZ";
    		}else if(marketNo=="5"){
    			marketNo="OTC";
    		}
    		// 锁定类型 （1.不允许卖出，2.不允许质押， 3.不允许质押和卖出）
            var vcLockType = data.vcLockType;
    		// 质押券不能选择PPN类型的债券
    		if(vcLockType == "2" || vcLockType == "3"){
	    		if(vcStockName && (vcStockName.indexOf("PPN")>=0 || vcStockName.indexOf("ABN")>=0)){
			    	msg="不能选择PPN、ABN类型债券！";
			        vcStockCombo.setText("");
		            vcStockCombo.setValue("");
					formRight.clear();
			        nui.alert(msg);
	    			return;
				}
    		}
	    	
	    	var sendMsg = {};
	    	sendMsg.combis=[{vcProductCode:fundCodeCombo.getValue(),vcStockCode:vcStockCode,vcAccount:combiCode,vcMarket:marketNo,vcBusinType:"5",vcInvestType:"1"}];
	    	//组装查可卖数量条件
	    	var sendMsg2 = {};
	    	sendMsg2.combis=[{vcStockCode:vcStockCode,vcAccount:combiCode,vcMarket:marketNo,vcBusinType:"4",vcInvestType:"1"}];
	    	var lm = {vcProductCode:fundCodeCombo.getValue(),vcStockCode:vcStockCode,vcAccount:combiCode};
	    	
			// T+0可卖数量 
            var canSellAmount = nui.get("canSellAmount").getValue();;
            // T+0可质押数量
            var vcAvailablequantityT0 = nui.get("vcAvailablequantityT0").getValue();;
            // 验证可解锁数量
            if(canSellAmount == null || canSellAmount ==""){
            	nui.alert("请等待可卖数量反馈，再提交");
				return;
            }
            if(vcAvailablequantityT0 == null || vcAvailablequantityT0 ==""){
            	nui.alert("请等待可质押数量反馈，再提交");
				return;
            }
            var lLockQty = data.lLockQty;
            // 可解锁数量验证
 			if(vcLockType == '1'){
 				if(parseInt(lLockQty) > parseInt(canSellAmount)){
 					nui.alert("锁定数量不能大于T+0可卖数量！","系统提示");
 					return;
 				}
 			}
 			if(vcLockType == '2'){
 				if(parseInt(lLockQty) > parseInt(vcAvailablequantityT0)){
 					nui.alert("锁定数量不能大于T+0可质押数量！","系统提示");
 					return;
 				}
 			}
 			if(vcLockType == '3'){
 				if(canSellAmount < vcAvailablequantityT0){
 					if(parseInt(lLockQty) > parseInt(canSellAmount)){
	 					nui.alert("锁定数量不能大于T+0可卖数量！","系统提示");
	 					return;
	 				}
 				}else if(canSellAmount == vcAvailablequantityT0){
	 				if(parseInt(lLockQty) > parseInt(vcAvailablequantityT0)){
	 					nui.alert("锁定数量不能大于T+0可卖数量或者可质押数量！","系统提示");
	 					return;
	 				}
 				}else{
	 				if(parseInt(lLockQty) > parseInt(vcAvailablequantityT0)){
	 					nui.alert("锁定数量不能大于T+0可质押数量！","系统提示");
	 					return;
	 				}
 				}
 			} 

			// 申请添加锁定的数量
			var applyLockQty = data.lLockQty;
			var re = /^[1-9]\d*$/;;
			if (!re.test(applyLockQty)) {
				nui.alert("请输入大于0的正整数！");
				return;
			}
			data.vcProductName = fundCodeCombo.getText();
			data.vcCombiName = vcCombiCombo.getText();
			data.vcStockName = vcStockName;
			
            // 取锁定日期yyyy-mm-dd
            //var tLockTime = data.tLockTime.substring(0,10);
            // 当前日期
			var nowDate = new Date();
			nowDate = nowDate.getFullYear()+"-"+((nowDate.getMonth()+1)<10?"0":"")+(nowDate.getMonth()+1)+"-"+(nowDate.getDate()<10?"0":"")+nowDate.getDate();
			
			//if(tLockTime == nowDate){
			data.vcLockStatus = '1';
			//}else if(tLockTime > nowDate){
				// 待锁定
				//data.vcLockStatus = '4';
			//}else{
			//	nui.alert("请输入正确的锁定开始日期！");
			//}
			 
			data.vcStockName = vcStockName;
			data.vcLockSource = '2';
			data.lProductId = fundCodeCombo.getData('L_PRODUCT_ID')[0].L_PRODUCT_ID;
			data.lCombiId = vcCombiCombo.getData('L_COMBI_ID')[0].L_COMBI_ID;
			var a = nui.loading("正在处理中,请稍等...","提示");
			nui.ajax({
				url : "com.cjhxfund.ats.sm.comm.TBondLockInfoManager.addLock.biz.ext",
				type : 'POST',
				data : {tAtsTbondLock:data,settleDate:'',sendMsg:sendMsg, sendMsg2:sendMsg2, lm:lm },
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					nui.hideMessageBox(a);
					var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
							nui.alert("保存锁定券成功", "系统提示", function(action) {
								if (action == "ok" || action == "close") {
									window.CloseOwnerWindow();
								}
							});
						}else{
							nui.alert(returnJson.rtnMsg,"系统提示");
						}
					}else{
						nui.alert("系统异常","系统提示");
					}
				}
			});
		}
		
		//页面X的删除功能
        function onCloseClick(e) {
            var obj = e.sender;
            obj.setText("");
            obj.setValue("");
            obj.setIsValid(false);
      	    obj.doValueChanged();
            formRight.clear();
        }
        
        // 判断可锁定数量
        function lLockQtyValidate(e) {
            var lLockQty = e.value;
            var form = new nui.Form("#form1");
			var data = form.getData(false, true);
            // 锁定类型 （1.不允许卖出，2.不允许质押， 3.不允许质押和卖出）
            var vcLockType = data.vcLockType;
            // T+0可卖数量 
            var canSellAmount = $("#canSellAmount").html();
            // T+0可质押数量
            var vcAvailablequantityT0 = $("#vcAvailablequantityT0").html();
            
 			if(vcLockType == '1'){
 				if(parseInt(lLockQty) > parseInt(canSellAmount)){
 					nui.alert("锁定数量不能大于T+0可卖数量！","系统提示");
 					var obj = e.sender;
			        obj.setValue("");
 				}
 			}
 			if(vcLockType == '2'){
 				if(parseInt(lLockQty) > parseInt(vcAvailablequantityT0)){
 					nui.alert("锁定数量不能大于T+0可质押数量！","系统提示");
 					var obj = e.sender;
			        obj.setValue("");
 				}
 			}
 			if(vcLockType == '3'){
 				if(canSellAmount <= vcAvailablequantityT0){
 					if(parseInt(lLockQty) > parseInt(canSellAmount)){
	 					nui.alert("锁定数量不能大于T+0可卖数量！","系统提示");
	 					var obj = e.sender;
				        obj.setValue("");
	 				}
 				}else{
	 				if(parseInt(lLockQty) > parseInt(vcAvailablequantityT0)){
	 					nui.alert("锁定数量不能大于T+0可质押数量！","系统提示");
	 					var obj = e.sender;
				        obj.setValue("");
	 				}
 				}
 			} 
        }
        
        // 日期显示
        function onDrawDate(e) {
            var date = e.date;
            var d = new Date();

            if (date.getTime() < d.getTime()) {
                e.allowSelect = false;
            }
        }
        
        function getStockCode(e) {
        	var market = nui.get("vcMarket").getValue();
        	var productCode = nui.get("vcProductCode").getValue();
        	e.params["marketNo"] = market;
        	// 产品代码
        	e.params["fundId"] = productCode;
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
	</script>
</body>
</html>