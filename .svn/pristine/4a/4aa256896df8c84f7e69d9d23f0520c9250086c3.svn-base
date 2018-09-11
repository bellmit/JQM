	//计算网下申购规模(万元) = 申购建议价格 * 网下申购上限(万股)
	function countScale(){
		var price=nui.get("price").getValue();//申购建议价格
		var uplimit=nui.get("uplimit").getValue();//网下发行上限(万股)
		var scale=(price*uplimit).toFixed(4);
		nui.get("scale").setValue(scale);
		if(nui.get("scale").getValue()=="NaN"||nui.get("scale").getValue()=="0.0000"){
			nui.get("scale").setValue("0");
		}
	}
	//为申购建议价格绑定onchange事件-- 非IE
	document.getElementById("price").onchange=function(){
		countScale();
		declarePrice();
		declareMoney();
	}
	//按enter 键事件 --IE
	document.getElementById("price").onkeypress=function(event){
        var e = event || window.event || arguments.callee.caller.arguments[0];
        if(e && e.keyCode==13){ // enter 键
        	countScale();
    		declarePrice();
    		declareMoney();   
        }
    }; 
	
	//计算申购量占总股本比例= 合计申购股数(万股)/发行人总股本(万股)
	function countStockratio(){
		var stocknumber=nui.get("stocknumber").getValue();//合计申购股数（万股）
		var enTotalEquity=nui.get("enTotalEquity").getValue();//发行人总股本（万股）
		var stockratio=(stocknumber/enTotalEquity).toFixed(4);
		nui.get("stockratio").setValue(stockratio);
		if(nui.get("stockratio").getValue()=="NaN"||nui.get("stockratio").getValue()=="0.0000"){
			nui.get("stockratio").setValue("0");
		}
	}
	
	//计算获配数量占发行人总股本比例=预计获配率*合计申购股数(万股)/发行人总股本(万股)
	function countQuantitystockratio(){
		var lPredictDistributionRate=nui.get("lPredictDistributionRate").getValue();//预计获配率
		var stocknumber=nui.get("stocknumber").getValue();//合计申购股数（万股）
		var enTotalEquity=nui.get("enTotalEquity").getValue();//发行人总股本（万股
		var quantitystockratio=(lPredictDistributionRate*stocknumber/enTotalEquity).toFixed(4);
		nui.get("quantitystockratio").setValue(quantitystockratio);
		if(nui.get("quantitystockratio").getValue()=="NaN"||nui.get("quantitystockratio").getValue()=="0.0000"){
			nui.get("quantitystockratio").setValue("0");
		}
	}
	//为预计获配率绑定onchange事件
	document.getElementById("lPredictDistributionRate").onchange=function(){
		countQuantitystockratio();
		declarePrice();
	}
	//按enter 键事件 --IE
	document.getElementById("lPredictDistributionRate").onkeypress=function(event){
        var e = event || window.event || arguments.callee.caller.arguments[0];
        if(e && e.keyCode==13){ // enter 键
        	countQuantitystockratio();
    		declarePrice();   
        }
    };
	
	//计算合计申购股数
	function stockNumberAll(){
		//获取申购数量列----
		var rows=grid.getData();
		//alert(rows);
		var sum=0.0;
		for(var i=0;i<rows.length;i++){
			var vcProductParticipantion=rows[i].vcProductParticipantion;
			var vcComplianceState=rows[i].vcComplianceState;
			if(vcProductParticipantion=="00"&&vcComplianceState!="01"&&vcComplianceState!="02"){
				sum+=parseFloat(rows[i].enPurchaseNumber);
			}
		}
		sum=sum.toFixed(4);
		nui.get("stocknumber").setValue(sum);
		if(nui.get("stocknumber").getValue()=="NaN"||nui.get("stocknumber").getValue()=="0.0000"){
			nui.get("stocknumber").setValue("0");
		}
	}
	
	
	//计算申购金额,申购金额占净值比例,预计获配占净值比例
	function declareMoney(){
		var price=nui.get("price").getValue();//申购建议价格
		var lPredictDistributionRate=nui.get("lPredictDistributionRate").getValue();//预计获配率
		var row=grid.getSelected ();//获取当前行
		if(row){
			var enPurchaseNumber=row.enPurchaseNumber;//获取当前行中的申购数量
			//申购金额= 申购数量(万股)*申报价格 
			row.enPurchaseMoney=(enPurchaseNumber*price).toFixed(4);
			if(row.assetNetValue==null){
				//申购金额占净值比例= 申购金额(万元) / 基金总资产
				row.enPurchaseMoneyRate=(parseFloat(row.enPurchaseMoney/row.assetValue*100)).toFixed(2);
				//预计获配占净值比例= (申购金额(万元)*预计获配率)/(基金总资产或者基金净资产)
				row.enDistributionRate=(parseFloat(row.enPurchaseMoney*lPredictDistributionRate/row.assetValue*100)).toFixed(4);
			}else{
				//申购金额占净值比例= 申购金额(万元) / 基金净资产
				row.enPurchaseMoneyRate=(parseFloat(row.enPurchaseMoney/row.assetNetValue*100)).toFixed(2);
				//预计获配占净值比例= (申购金额(万元)*预计获配率)/(基金资产或者基金净资产)
				row.enDistributionRate=(parseFloat(row.enPurchaseMoney*lPredictDistributionRate/row.assetNetValue*100)).toFixed(4);
			}
			grid.updateRow(row);
		}
	}
	var grid = nui.get("datagrid1");
	//更新申购价格列
	function declarePrice(){
		var buyfloor=nui.get("buyfloor").getValue();//网下申购下限(万股)
		var uplimit=nui.get("uplimit").getValue();//网下发行上限(万股)
		var step=nui.get("step").getValue();//申购步长
		var price=nui.get("price").getValue();//申购建议价格
		buyfloor=parseFloat(buyfloor);
		uplimit=parseFloat(uplimit);
		step=parseFloat(step);
		price=parseFloat(price);
		var lPredictDistributionRate=nui.get("lPredictDistributionRate").getValue();
    	var rows=grid.getData();
    	for(var i=0;i<=rows.length-1;i++){
    		grid.updateRow(rows[i],{enPurchasePrice:price});//更新每行申报价格
    		if(rows[i].assetNetValue==null){
    			//计算申购数量=基金总资产/申购建议价格
    			rows[i].enPurchaseNumber=parseFloat((rows[i].assetValue/price-rows[i].assetValue%step).toFixed(0));
    			//申购金额占净值比例= 申购金额(万元) / 基金总资产
    			rows[i].enPurchaseMoneyRate=(parseFloat(rows[i].enPurchaseMoney/rows[i].assetValue*100)).toFixed(2);
    			if(rows[i].enPurchaseMoneyRate=="NaN"){
    				rows[i].enPurchaseMoneyRate=0.00;
    			}
    			//预计获配占净值比例= (申购金额(万元)*预计获配率)/(基金总资产或者基金净资产)
    			rows[i].enDistributionRate=(parseFloat(rows[i].enPurchaseMoney*lPredictDistributionRate/rows[i].assetValue*100)).toFixed(4);
    			if(rows[i].enDistributionRate=="NaN"){
    				rows[i].enDistributionRate=0.0000;
    			}
    		}else{
    			//计算申购数量=基金净资产/申购建议价格
    			rows[i].enPurchaseNumber=parseFloat((rows[i].assetNetValue/price-rows[i].assetNetValue%step).toFixed(0));
    			//申购金额占净值比例= 申购金额(万元) / 基金净资产
    			rows[i].enPurchaseMoneyRate=(parseFloat(rows[i].enPurchaseMoney/rows[i].assetNetValue*100)).toFixed(2);
    			if(rows[i].enPurchaseMoneyRate=="NaN"){
    				rows[i].enPurchaseMoneyRate=0.00;
    			}
    			//预计获配占净值比例= (申购金额(万元)*预计获配率)/(基金资产或者基金净资产)
    			rows[i].enDistributionRate=(parseFloat(rows[i].enPurchaseMoney*lPredictDistributionRate/rows[i].assetNetValue*100)).toFixed(4);
    			if(rows[i].enDistributionRate=="NaN"){
    				rows[i].enDistributionRate=0.0000;
    			}
    		}
    		//如果处于申购下限与发行上限之间申购数量须是步长的整数倍
			if(rows[i].enPurchaseNumber>buyfloor&&rows[i].enPurchaseNumber<uplimit&&rows[i].enPurchaseNumber%step!=0){
				var newRow = { enPurchaseNumber: (rows[i].enPurchaseNumber-(rows[i].enPurchaseNumber%step))<buyfloor?buyfloor:(rows[i].enPurchaseNumber-(rows[i].enPurchaseNumber%step)) };
				grid.updateRow(rows[i],newRow);
			//申购数量不能小于网下申购下限
			}else if(rows[i].enPurchaseNumber<buyfloor){
				var newRow = { enPurchaseNumber: buyfloor };
				grid.updateRow(rows[i],newRow);
			//申购数量不能大于网下申购上限
			}else if(rows[i].enPurchaseNumber>uplimit){
				var newRow = { enPurchaseNumber: uplimit };
				grid.updateRow(rows[i],newRow);
			}else{
				
			}
    		//当前行的申报金额=申购建议价格*申购数量
    		rows[i].enPurchaseMoney=parseFloat((price*rows[i].enPurchaseNumber).toFixed(4));
    		grid.updateRow(rows[i]);
    	}
    	stockNumberAll();
    }
	
//编辑结束时发生
grid.on("cellendedit", function (e) {
	var record=e.record;
	//验证申购数量
	var buyfloor=nui.get("buyfloor").getValue();//网下申购下限(万股)
	var uplimit=nui.get("uplimit").getValue();//网下发行上限(万股)
	var step=nui.get("step").getValue();//申购步长
	buyfloor=parseFloat(buyfloor);
	uplimit=parseFloat(uplimit);
	step=parseFloat(step);
	//获取当前行中的申购数量
	var div=record.enPurchaseNumber;
	div=parseFloat(div);
	//如果处于申购下限与发行上限之间 则 申购数量(万股) = 申购数量(万股) - (申购数量(万股) % 申购步长)
	if(div>buyfloor&&div<uplimit&&div%step!=0){
		nui.alert("申购数量须是步长的整数倍","申购数量提示");
		var newRow = { enPurchaseNumber: (div-(div%step))<buyfloor?buyfloor:(div-(div%step)) };
		grid.updateRow(record,newRow);
	}else if(div<buyfloor){
		nui.alert("申购数量不能小于网下申购下限","申购数量提示");
		var newRow = { enPurchaseNumber: buyfloor };
		grid.updateRow(record,newRow);
	}else if(div>uplimit){
		nui.alert("申购数量不能大于网下申购上限","申购数量提示");
		var newRow = { enPurchaseNumber: uplimit };
		grid.updateRow(record,newRow);
	}else{}
	//verify();
	stockNumberAll();
	countStockratio();
	countQuantitystockratio();
	//declareMoney();
	//计算申购金额,申购金额占净值比例,预计获配占净值比例
	var price=nui.get("price").getValue();//申购建议价格
	var lPredictDistributionRate=nui.get("lPredictDistributionRate").getValue();//预计获配率
	if(record){
		var enPurchaseNumber=record.enPurchaseNumber;//获取当前行中的申购数量
		//申购金额= 申购数量(万股)*申报价格 
		record.enPurchaseMoney=(enPurchaseNumber*price).toFixed(4);
		if(record.assetNetValue==null){
			//申购金额占净值比例= 申购金额(万元) / 基金总资产
			record.enPurchaseMoneyRate=(parseFloat(record.enPurchaseMoney/record.assetValue*100)).toFixed(2);
			//预计获配占净值比例= (申购金额(万元)*预计获配率)/(基金总资产或者基金净资产)
			record.enDistributionRate=(parseFloat(record.enPurchaseMoney*lPredictDistributionRate/record.assetValue*100)).toFixed(4);
		}else{
			//申购金额占净值比例= 申购金额(万元) / 基金净资产
			record.enPurchaseMoneyRate=(parseFloat(record.enPurchaseMoney/record.assetNetValue*100)).toFixed(2);
			//预计获配占净值比例= (申购金额(万元)*预计获配率)/(基金资产或者基金净资产)
			record.enDistributionRate=(parseFloat(record.enPurchaseMoney*lPredictDistributionRate/record.assetNetValue*100)).toFixed(4);
		}
		grid.updateRow(record);
	}
});

