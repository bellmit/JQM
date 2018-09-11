	conditionForm.on("load",function(e){
			var parameter = {};
	        var dealPosition = conditionForm.data;
	        if(dealPosition.length > 0){
	        	parameter["businClass"] = nui.get("businClass").getValue(); //业务类别（二级市场买卖业务）：2-银行间二级市场业务  E-交易所大宗交易  I-上交所固定收益平台
	        	parameter["exdestination"] = nui.get("vcMarket").getValue(); //交易市场
	 	        parameter["vcEntrustDirection"] = "4";//委托方向:4-卖出
	 	        parameter["vcInvestType"] = nui.get("vcInvestType").getValue();//投资类型
	 	        nui.ajax({
	                 url : "com.cjhxfund.ats.sm.comm.AvaiableDataManager.queryAvailableQuantity.biz.ext",
	 				type : 'POST',
	 				data : {dealPosition:dealPosition,parameter:parameter},
	 				cache : false,
	 				contentType : 'text/json',
	                 success: function (text) {
	                 	var returnJson = nui.decode(text);
	 					if(returnJson.exception == null){
	 						if(returnJson.availableInfo.length > 0){
	 							var availableData = returnJson.availableInfo;
	 							for(var j=0; j<dealPosition.length; j++){
	 								for(var i=0; i<availableData.length; i++){
	 									if(availableData[i].VC_ACCOUNT == dealPosition[j].vcCombiNo && availableData[i].VC_SYMBOL == dealPosition[j].vcStockCode){
	 										var vcAvailablequantityTmpT0 = parseInt(availableData[i].VC_AVAILABLEQUANTITY_T0.toString());
	 										var vcAvailablequantityTmpT1 = parseInt(availableData[i].VC_AVAILABLEQUANTITY_T1.toString());
	 										if(availableData[i].C_LOCAL_AVAILABLE != null && availableData[i].C_LOCAL_AVAILABLE == "0"){//不启用本地可用计算
	 											vcAvailablequantityTmpT0 = parseInt(availableData[i].VC_O32_AVAILABLEQUANTITY_T0.toString());
	 											vcAvailablequantityTmpT1 = parseInt(availableData[i].VC_O32_AVAILABLEQUANTITY_T1.toString());
	 										}
	 										if(vcAvailablequantityTmpT0 > 0){
	 											dealPosition[j].vcAvailablequantityT0 = vcAvailablequantityTmpT0;
	 										}else{
	 											dealPosition[j].vcAvailablequantityT0 = "0";
	 										}
	 										if(vcAvailablequantityTmpT1>0){
	 											dealPosition[j].vcAvailablequantityT1 = vcAvailablequantityTmpT1;
	 										}else{
	 											dealPosition[j].vcAvailablequantityT1 = "0";
	 										}
	 										conditionForm.updateRow(dealPosition[j]);
	 										break;
	 									}
	 								}
	 							}
	 						}
	 					}
	                 }
	             });	
	        }
		});
		//监听事件
		conditionForm.on("drawcell",function (e){
			 var record = e.record,
    	 	 column = e.column;
    		  //action列，超连接操作按钮
	        if (column.name == "action") {
	            e.cellStyle = "text-align:center";
	            var operatColumn = null;
	             if( record.isSellOperate=="1"){
	            	operatColumn =  '<a style="color:#00CCFF"  onclick="clicksearch(\''+conditionForm.indexOf(record)+'\',\'sell\')" href="#">卖出</a>&nbsp&nbsp'+
	            								  '<a style="color:#00CCFF"  onclick="clicksearch(\''+conditionForm.indexOf(record)+'\',\'buy\')" href="#">追加买入</a>';
	             }
	             e.cellHtml = operatColumn;
	        }
		});
		//绑定表单
        function onSelectionChanged(e) {
            var grid = e.sender;
            var record = grid.getSelected();
            if (record) {
                editRow(record._uid);
            } else {                
                form.reset();
            }
        }
        function editRow(row_uid) {
            var row = conditionForm.getRowByUID(row_uid);
            row["vcMarketNo"] = nui.get("vcMarketNo").getValue();
            if (row) {
                //表单加载员工信息
                if (conditionForm.isNewRow(row)) {                    
                    dealDetail.reset();
                } else {
                    nui.ajax({
                        url : "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.getAppointBondInfo.biz.ext",
						type : 'POST',
						data : {condition:row},
						cache : false,
						contentType : 'text/json',
                        success: function (text) {
                        	var returnJson = nui.decode(text);
							if(returnJson.exception == null){
								var bondBasicInfo = returnJson.bondBasicInfo[0];
			                    dealDetail.setData(bondBasicInfo);
			                    dealDetail.unmask();
							}else{
								nui.alert("系统异常","系统提示");
							}
                        }
                    });
                }
            }
        }
        //查询客户有权持仓信息
        function search(){
     		commandInformation = tabDealRole.getData(false,false);
     		commandInformation["vcBondAppraise"] = splitString(commandInformation.vcBondAppraise);
 	        conditionForm.load({parameter:commandInformation});
 	        dealDetail.setData("");
     	} 
        
         //页面X的删除功能
         function onCloseClick(e) {
             var obj = e.sender;
             obj.setText("");
             obj.setValue("");
         }
         
         //重置功能
         function reset(){
                tabDealRole.reset();
          }
          //整数校验
          function numberCheck(e){
 			if (!e.isValid) {
 				e.sender.setValue("");
             }
 		}
 		//查询参数组装
 		function splitString(data){
     		var string = null;
     		if(data != null && data != ""){
     			var strs= data.split(",");
 	    		if(strs.length>0){
 	    			for(var i=0; i<strs.length; i++ ){ 
 						if(i == 0){
 							string = "'"+strs[i]+"'";
 						}else{
 							string += ",'"+strs[i]+"'";
 						}
 					} 
 	    		}
     		}
 			return string;
     	}
 		
 		function renderBondAppraise(e){
 			return nui.getDictText("creditRating",e.row.vcBondAppraise);
 		}
 		
 		function renderIssueAppraise(e){
 			return nui.getDictText("issuerRating",e.row.vcIssueAppraise);
 		}
 		