//收益率（%）
            function interestRateFun(e){
            	if(numberCheck(e)){//判断参数是否为数字
		           	return;
		         }
				setPriceFunCommon("enMaturityYield");
				setPriceFunCommon("enOptionYield");
            };
		function onActionRenderer(e) {
			var vcStockCode = e ? e.value : nui.get("vcStockCode").getValue();//债券代码
			if(!vcStockCode){
				window.parent.appointBondInfo("bond_details");
				return;
			}
			var businClass = nui.get("businClass").getValue();//业务类别-2（银行间）
			var exdestination = nui.get("exdestination").getValue();//交易市场代码-OTC
			var vcInvestType = nui.get("vcInvestType").getValue();//投资类型-1（可交易）
			var vcCombiCode = nui.get("vcCombiCode").getValue(); //组合代码
			var vcMarketNo = nui.get("vcMarket").getValue();//交易市场代码		
			if(vcStockCode){
				//onImmediatelyRenderer();//查询数据库并赋值
				window.parent.appointBondInfo("bond_details",vcStockCode,vcMarketNo,function(bondBasicInfo,returnJson){
					//填充本页签相关表单
					var vcSpecialText = null;
					if(bondBasicInfo){
						nui.get("vcStockName").setValue(bondBasicInfo.vcStockName);
					    nui.get("vcInterCode").setValue(bondBasicInfo.vcInterCode);
					    lLeftDays = bondBasicInfo.lEndincalDays; //距到期日天数
					    vcSpecialText = returnJson.bondBasicInfo[0].vcSpecialText;
					}else{
						nui.get("vcStockName").setValue("");
					    nui.get("vcInterCode").setValue("");
					}
					if(vcSpecialText && (vcSpecialText.indexOf("回售条款")>=0 || vcSpecialText.indexOf("赎回条款")>=0)){
						$("#MaturityLab").html("<span>*</span>到期/行权收益率:");
						$("#enOptionYield").show();
						$("#MaturityLabSplit").show();
						hasSellback = true;
					}else{
						$("#MaturityLab").html("<span>*</span>到期收益率:");
						$("#enOptionYield").hide();
						$("#MaturityLabSplit").hide();
						hasSellback = false;
					}
					
					//获取摘牌日期
					var lDelistingDateTemp = returnJson.bondBasicInfo[0] ? returnJson.bondBasicInfo[0].lDelistingDate : null;
					lDelistingDate = lDelistingDateTemp == null ? 
					null : DateUtil.DstrToDate(returnJson.bondBasicInfo[0].lDelistingDate);
					
					sumFaceAmount = returnJson.sumFaceAmount;
					enBondAsset = returnJson.enBondAsset;
				});
				if(isO32Exist){
					if(vcCombiCode){
						if(!e){
							onCombiLinkage();
						}else{
							var parameter = {businClass:businClass,exdestination:exdestination,vcEntrustDirection:3,vcInvestType:vcInvestType};
							var bondInfo = [{vcCombiCode:vcCombiCode,vcCombiNo:vcCombiCode,vcStockCode:vcStockCode,exdestination:exdestination}];
							instructAvaileAmount(parameter, bondInfo);
						}
					}
					getBondType();//根据债券代码判断是净价还是全价
					enNetPriceMet();//根据净价联动
					countIiquidationVelocity();//根据债券计算清算速度
				}
			}
		}
		function onO32ExistValidation(e) {
			if(inquirySaveOrSubmitType != "save"){
				if (e.isValid) {
					if(!checkO32Exist({vcStockCode:e.value,vcMarketNo:nui.get("vcMarket").getValue()})){
						e.errorText = "O32不存在此债券";
						e.isValid = false;
						isO32Exist = false;
					}else{
						isO32Exist = true;
					}
				}
			}
        }
		//校验交易日期是否为交易日
		function isTradeDate(e){
			if(!remindTradeDate(e,"交易日期不是交易日，还需要继续吗？")){
		    	e.errorText = "交易日期不是交易日！";
		        e.isValid = false;
		    }
		}
		
		//位数校验
		function digitCheck(e){
			var value = e.sender.value;
			var name = e.sender.name;
    		if(value.length != 6){
				e.errorText = "必须为6位";
				e.isValid = false;
				nui.get(name).setValue("");
			}
		}
		//根据组合获取指令下达左侧参数
		function onCombiLinkage(){
			//获取可用金额与净资产 start
			var vcProductCode = nui.get("vcProductCode").getValue();//产品代码
			var vcCombiCode = nui.get("vcCombiCode").getValue(); //组合代码
			var vcStockCode = nui.get("vcStockCode").getValue();//债券代码
			//var vcMarketNo = nui.get("vcMarket").getValue();//交易市场代码
			var businClass = nui.get("businClass").getValue();//业务类别-2（银行间）
			var exdestination = nui.get("exdestination").getValue();//交易市场代码
			var vcInvestType = nui.get("vcInvestType").getValue();//投资类型-1（可交易）
			var dealPosition = {};
			dealPosition["vcProductCode"]=vcProductCode;
			dealPosition["vcCombiCode"] = vcCombiCode;
			dealPosition["vcCombiNo"]=vcCombiCode;
			dealPosition["exdestination"]=exdestination;
			dealPosition["businClass"]=businClass;
			if(vcCombiCode){
				nui.ajax({
					url:"com.cjhxfund.ats.sm.transaction.TransactionBizManager.queryAvailableAmount.biz.ext",
					type : 'POST',
					data : {dealPosition:dealPosition},
					cache : false,
					contentType : 'text/json',
					success : function(text) {
						var returnJson = nui.decode(text);
						if(returnJson.exception == null){
							if(returnJson.sumList.length>0){
								var sumList = returnJson.sumList[0];
								var enFundValue = sumList.enFundValue;
								var vcAvailableamountT0 = sumList.vcAvailableamountT0;
								var vcAvailableamountT1 = sumList.vcAvailableamountT1;
								if(sumList.cLocalAvailable != null && sumList.cLocalAvailable == "0"){
									vcAvailableamountT0 = sumList.vcO32AvailableamountT0;
									vcAvailableamountT1 = sumList.vcO32AvailableamountT1;
								}
								if(nui.get("operatorType").getValue() == "1" && instructionInfo.cIsValid=="1"){//修改指令
									var tradeQty = parseInt(0);
									var fullPrice = parseFloat(0);
									if(instructionInfo.vcProcessStatus=="4" || instructionInfo.vcProcessStatus=="5"){
										if(sumList.VC_TASSET==instructionInfo.vcAssetCode && instructionInfo.vcEntrustDirection == "3"){
											fullPrice = parseFloat(instructionInfo.enFullPrice.replace(/,/g,''));
											tradeQty = parseInt(instructionInfo.enFaceAmount.replace(/,/g,''))*100;
										}
									}else{
										if(sumList.cLocalAvailable != null && sumList.cLocalAvailable == "0"){
											//获取同业务编号，指令记录流程已到O32的修改审核中的记录
											nui.ajax({
								        		data:{param:{lResultNo:instructionInfo.lResultNo,vcEntrustDirection:"3"}},
								        		async: false,
								        		url:"com.cjhxfund.ats.sm.comm.AvaiableDataManager.getO32UnderReviewInstruct.biz.ext",
								        		success:function(resp){
								        			var returnJson = nui.decode(resp);
													if(returnJson.exception == null){
														if(returnJson.updateCheckInstruct.length==1){
															var updateCheckInstruct = returnJson.updateCheckInstruct[0];
															if(updateCheckInstruct.VC_ASSET_CODE == sumList.VC_TASSET){
																tradeQty = (updateCheckInstruct.EN_FACE_AMOUNT)*100;
																fullPrice = updateCheckInstruct.EN_FULL_PRICE;
															}
														}
													}
							        			}
											});
										}else{
											if(sumList.VC_TASSET==instructionInfo.vcAssetCode){
												if(instructionInfo.vcEntrustDirection=="3"){//买入
													var now =  nui.formatDate(new Date(),"yyyyMMdd");//当日
													var now1 = nui.formatDate(new Date(new Date().getTime()+24*60*60*1000),"yyyyMMdd"); //修改指令的可以金额校验需要
									    			//原指令的交易日为今天的指令或者交易日为明天的t+0指令在需改时需要将资金加回
													if(instructionInfo.lTradeDate == now || (instructionInfo.lTradeDate == now1 && instructionInfo.vcSettleSpeed == "0")){
							    						tradeQty = parseInt(instructionInfo.enFaceAmount.replace(/,/g,''))*100;
							    						fullPrice = parseFloat(instructionInfo.enFullPrice.replace(/,/g,''));
							    					}
												}
											}
										}
									}
									if(vcAvailableamountT0 && vcAvailableamountT1){
										vcAvailableamountT0 =parseFloat(vcAvailableamountT0.replace(/,/g,''))+tradeQty*fullPrice;
										vcAvailableamountT1 = parseFloat(vcAvailableamountT1.replace(/,/g,''))+tradeQty*fullPrice;
									}
								}
								if(enFundValue){
									//调用父页面方法
									window.parent.setInfoValue('enFundValue',formatNumber(enFundValue,2,1));
								}
								if(vcAvailableamountT0){
									window.parent.setInfoValue('vcAvailableamountT0',formatNumber(vcAvailableamountT0,2,1));
								}
								if(vcAvailableamountT1){
									window.parent.setInfoValue('vcAvailableamountT1',formatNumber(vcAvailableamountT1,2,1));
								}
							}
							//计算持仓占比和未成占比和指令占比
						    var enNetPrice = nui.get("enNetPrice").value;//净价
						    var enFaceAmountTemp = nui.get("enFaceAmount").value.replace(/,/g,'');
			        		window.parent.calculatePercentage(enNetPrice,enFaceAmountTemp,enBondAsset,sumFaceAmount,function(value){
							//nui.get("enFaceAmount").setValue(value);
						    });
						}
					}
				});
				//获取可用金额与净资产end
				if(vcStockCode){//如果债券存在，获取可用数量
					if(isO32Exist){
						var parameter = {businClass:businClass,exdestination:exdestination,vcEntrustDirection:3,vcInvestType:vcInvestType};
						var bondInfo = [{vcCombiCode:vcCombiCode,vcCombiNo:vcCombiCode,vcStockCode:vcStockCode,exdestination:exdestination}];
						instructAvaileAmount(parameter, bondInfo);
					}
				}
			}
		}
		
		//关闭页面
		function onCancel() {
			window.parent.closewindow();
		}
		
		//点击事件，根据委托方向改变所有输入框对应字段的颜色
		function changeToRed(e){
			changeRed(e.source.value);
		}
		//委托方向有值时就改变所有输入框对应字段的颜色
		function changeRed(e){
				if(e == "01" || e == "3"){
					$("td[red='red']").css({"color":"red"});
				}else if(e == "02" || e == "4"){
					$("td[red='red']").css({"color":"green"});
				}
		}
		//联动方法
    	function selectFunds(e){
     		var fundCodeCombo = nui.get("vcProductCode");
    		var vcCombiCombo = nui.get("vcCombiCode");
       		var id = fundCodeCombo.getValue();
       		if(!id){
       			vcCombiCombo.setValue(null);
       			vcCombiCombo.setText(null);
       		}
    		nui.ajax({
        		data: {vcProductCode: id, queryType: "'03'", lAssetId: lAssetId},
        		url: "com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfoByProductCodeAndRealType.biz.ext",
        		success:function(resp){
        			var returnJson = nui.decode(resp);
					if(returnJson.exception == null){
						var combis = resp.data;
			            if(combis){
		                    vcCombiCombo.load(combis);
		                    if(typeof e === "object"){
		                    	vcCombiCombo.select(0);
		                    	nui.getbyName("lProductId").setValue(e.selected.L_PRODUCT_ID);
		                    }else if(typeof e === "undefined"){
		                    	vcCombiCombo.select(0);
		                    }else{
		                    	
		                    	var combiInList = false;
		                    	for(var i = 0,len = combis.length; i < len;i++){
									if(combis[i].VC_COMBI_NO==e){
										combiInList = true;
							    		vcCombiCombo.setValue(e);
							    	}
								}
								if(!combiInList){
									vcCombiCombo.setValue(null);
       								vcCombiCombo.setText(null);
								}
		                    }
		             	 }
		             	onCombiLinkage();//获取可用金额与净资产
					}else{
						window.parent.parentAlert("系统异常","系统提示");
					}
	              },
	            //有错误码之后，把后面的错误提醒补齐。
	            fail:function(resp){
	                alert(resp);
	            }
		    });
    	};
        
      //控制交易日期不能小于当天
        function limitTradeDate(id){
				var time = (new Date()).getTime() - 24*60*60*1000;
				nui.get(id).minDate = new Date(time);
					}
        
		//根据清算速度和交易日期得出结算日期
		function whetherTradeDate(){
			var tradeDatePicker = nui.get("tradeDate").value;
			var tradeDate = nui.formatDate(tradeDatePicker, "yyyyMMdd");
			var settleSpeed = nui.get("vcSettleSpeed").getValue();
			if(tradeDate && settleSpeed){
				if(settleSpeed=="0"){
					nui.get("firstSettleDate").setValue(tradeDate.toString());
				}else{
					if(isNotTradeDate(tradeDatePicker,"00")){
						settleSpeed="0";
					}
					nui.ajax({
			            url:"com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.calMaturitySettleDate.biz.ext",
			            type:'POST',
			            data:{firstSettleDate:tradeDate,repoDays:settleSpeed},
			            cache:false,
			            contentType:'text/json',
			            success:function(text){
			                var returnJson = nui.decode(text);
			                if(returnJson.exception == null){
			                	nui.get("firstSettleDate").setValue(returnJson.maturitySettleDate.toString());
			                }else{
			                    nui.alert("获取交易日失败", "系统提示");
			                }
			            }
			        });
				}
				if(bondPriceType == "0"){
					netFullPriceFun();//根据全价联动
				}else{
					enNetPriceMet();//根据净价联动
				}
			}
		}
		//将8位的时间字符转换成指定的时间格式对象
       function numStrToDate(dateStr){
		  var year = dateStr.substr(0,4);
		  var month = dateStr.substr(4,2);
		  var date = dateStr.substr(6,2);
		  var finalDate = new Date(year + "-" + month + "-" + date+" "+"00"+":"+"00"+":"+"00");
		  return finalDate;
  		}
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
		
		 //精确加
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
		    return e = Math.pow(10, Math.max(c, d)), (a * e + b * e) / e;
		}
		 //数字校验(允许英文逗号)
       function numberCheck(e){
			if(inquirySaveOrSubmitType != "save"){
				var reg= /^([0-9]([0-9,])*(\.[0-9]+)?)$/;
				var value = e.sender.value;
				if(!reg.test(value)){
					e.sender.setValue("");
					e.errorText = "请输入大于等于0的数";
					e.isValid = false;
					return true;
				}
			}
		}
//净价（元/百元面值）
            function netPriceFun(e){
            	 if(numberCheck(e)){//判断参数是否为数字
	            	return;
	            }
            	setPriceFunCommon("enNetPrice");//自动增加千分位-净价（元/百元面值）
            	enNetPriceMet();
            }
            //根据净价联动
            function enNetPriceMet(){
            	var enNetPrice = nui.get("enNetPrice").getValue();  //净价
            	if(enNetPrice){
            		if(enNetPrice <= 0){
	            		nui.get("enFullPrice").setValue("0.0000");
	 					nui.get("enMaturityYield").setValue("0.0000");
						nui.get("enOptionYield").setValue("0.0000");
						return;
	            	}
	            	setBondPriceCommon(enNetPrice, null, null, null);//净价、全价、收益率，可以必填其一，选填其他，输入一个另外两个数据可以系统自动算出来
            	}
            }
             //自动增加千分位
            function setPriceFunCommon(cmpId){
            	var oldVal = nui.get(cmpId).getValue();
            	if(oldVal){
            		//特殊验证，交易场所：[01-银行间;02-上交所固收平台;03-深交所综合协议平台|上交所大宗;]
                	var tradingPlaceVal = "01";//交易场所
                	var newVal = formatNumber(oldVal,4,1);
                	if(tradingPlaceVal=="02" || tradingPlaceVal=="03"){
                		newVal = formatNumber(oldVal,3,1);
                	}
            		nui.get(cmpId).setValue(newVal);
            	}
            }
            //全价（元/百元面值）
            function fullPriceFun(e){
	            if(numberCheck(e)){//判断参数是否为数字
	            	return;
	            }
            	setPriceFunCommon("enFullPrice");//自动增加千分位-全价（元/百元面值）
            	netFullPriceFun();
            }
            //根据全价联动
            function netFullPriceFun(){
            	var enFullPrice = nui.get("enFullPrice").getValue();  //全价
            	if(enFullPrice){
            		if(enFullPrice <= 0){
                		nui.get("enNetPrice").setValue("0.0000");
     					nui.get("enMaturityYield").setValue("0.0000");
    					nui.get("enOptionYield").setValue("0.0000");
    					return;
                	}
                	setBondPriceCommon(null, enFullPrice, null, null);//净价、全价、收益率，可以必填其一，选填其他，输入一个另外两个数据可以系统自动算出来
            	}
            }
            //计算净价、全价、收益率，可以必填其一，选填其他，输入一个另外两个数据可以系统自动算出来
            function setBondPriceCommon(netPrice, fullPrice, interestRate, interestRateType){
            	var autoCalc = nui.get("autoCalc");//获取“联动”值（是否勾选）
            	if(autoCalc.checked==false){//若“联动”未勾选，则不自动计算而直接返回
            		return;
            	}
            	var vcReportCode = nui.get("vcStockCode").getValue();//债券代码
                //以下情况重新获取债券信息
                if(investProductInfoCommon==null || investProductInfoCommon=="" || investProductInfoCommon.split(",").length!=4 || vcReportCode != investProductInfoCommon.split(",")[0]){
                	var cMarketNo = nui.get("vcMarket").getValue(); //交易市场编号
                	if(!vcReportCode){
                		return;
                	}
                	nui.ajax({
			            url:"com.cjhxfund.ats.sm.comm.InstructionManager.getInvestProductsByReportCodeAndMarketNo.biz.ext",
			            type:'POST',
			            data:nui.encode({vcReportCode:vcReportCode, cMarketNo:cMarketNo}),
			            cache:false,
			            contentType:'text/json',
			            success:function(text){
			                var returnJson = nui.decode(text);
			                if(returnJson.exception == null){
			                	investProductInfoCommon = returnJson.investProductInfo; //投资产品信息（债券代码,债券名称,交易市场编号,证券内码）
			                	getBondPriceFun(netPrice, fullPrice, interestRate, interestRateType);
			                }else{
			                    nui.alert("债券详细信息获取失败", "系统提示");
			                }
			            }
			        });
                }else{
                	getBondPriceFun(netPrice, fullPrice, interestRate, interestRateType);
                }
            }
             //获取净价、全价、收益率数据
            function getBondPriceFun(netPrice, fullPrice, interestRate, interestRateType){
            	var investProductCode = nui.get("vcStockCode").getValue();//债券代码
                //若投资产品信息全局变量的债券代码值不等于债券代码属性的值则直接返回
                if(investProductCode!=investProductInfoCommon.split(",")[0]){
                	return;
                }
                var interCode = investProductInfoCommon.split(",")[3];//获取证券内码[投资产品信息（债券代码,债券名称,交易市场编号,证券内码）]
                var processDate = nui.formatDate(nui.get("tradeDate").value, "yyyyMMdd");//业务日期
                var vcBizType = nui.get("vcBizType").getValue();
                var tradingPlace = null;
                if(vcBizType == "3"){
                	tradingPlace = "02";//交易场所：[01-银行间;02-上交所固收平台;03-深交所综合协议平台|上交所大宗;]
                }else{
                	tradingPlace = "03";//交易场所：[01-银行间;02-上交所固收平台;03-深交所综合协议平台|上交所大宗;]
                }
                
                var clearingSpeed = nui.get("vcSettleSpeed").value;//清算速度：T+0、T+1
                if(clearingSpeed == "1"){
                	clearingSpeed = "T+1";
                }else{
                	clearingSpeed = "T+0";
                }
            	var interestRateTypeP = 1;//收益率类型：[1-到期;2-行权日]
            	if(interestRateType=="02"){
            		interestRateTypeP = 2;
            	}
            	
            	var jsonParam = nui.encode({processDate:processDate, interCode:interCode, netPrice:netPrice, fullPrice:fullPrice, interestRate:interestRate, interestRateType:interestRateTypeP, tradingPlace:tradingPlace, clearingSpeed:clearingSpeed});
            	nui.ajax({
		            url:"com.cjhxfund.ats.sm.comm.InstructionManager.getLinkageValue.biz.ext",
		            type:'POST',
		            data:jsonParam,
		            cache:false,
		            contentType:'text/json',
		            success:function(text){
		                var returnJson = nui.decode(text);
		                if(returnJson.exception == null){
		                	var result = returnJson.result; //返回结果：净价，全价，到期收益率，收益率类型，交易场所，清算速度，行权收益率
		                	var resultArr = result.split("@");
		                	nui.get("enNetPrice").setValue(resultArr[0]);//净价（元/百元面值）
    						nui.get("enFullPrice").setValue(resultArr[1]);//全价（元/百元面值）
    						nui.get("enMaturityYield").setValue(resultArr[2]);//到期收益率（%）
    						if(hasSellback){
    							nui.get("enOptionYield").setValue(resultArr[6]);//行权收益率
    						}else{
    							nui.get("enOptionYield").setValue("");//行权收益率
    						}
    						
    						setPriceFunCommon("enNetPrice");//自动增加千分位-净价（元/百元面值）
    						setPriceFunCommon("enFullPrice");//自动增加千分位-全价（元/百元面值）
    						setPriceFunCommon("enMaturityYield");//自动增加千分位-收益率（%）
    						setPriceFunCommon("enOptionYield");//自动增加千分位-收益率（%）
    						if(eval(nui.get("enMaturityYield").getValue())<=0){
    							nui.get("enMaturityYield").setValue("0.0000");
    						}
    						if(eval(nui.get("enOptionYield").getValue())<=0){
    							nui.get("enOptionYield").setValue("0.0000");
    						}
    						getNetPrice();
    						//计算持仓占比和未成占比和指令占比
    						var enNetPrice = nui.get("enNetPrice").value;//净价
    						var enFaceAmountTemp = nui.get("enFaceAmount").value.replace(/,/g,'');
    						window.parent.calculatePercentage(enNetPrice,enFaceAmountTemp,enBondAsset,sumFaceAmount,function(value){
	    						//nui.get("enFaceAmount").setValue(value);
    						});
		                }else{
		                    nui.alert("净价、全价、收益率数据获取失败", "系统提示");
		                }
		            }
		        });
            }
         //数字校验
  	   	  function calculateNetPrice(e){
  	   	  		if(numberCheck(e)){
  					return ;
  				}
  	   	  		getNetPrice();
  	   	  }
  	    //净价或券价金额的计算
   	  function getNetPrice(){
   		var enNetPrice = null;
   		if(bondPriceType == "0"){//全价
   			enNetPrice = nui.get("enFullPrice").getValue().replace(/,/g,'');	 //全价价格
   		}else{
   			enNetPrice = nui.get("enNetPrice").getValue().replace(/,/g,'');	 //净价价格
   		}  
  		var enFaceAmount = nui.get("enFaceAmount").getValue().replace(/,/g,''); //券面金额
  		var enNetPriceAmount = null;
  		if(enNetPrice){
			if(enFaceAmount){
				//净价金额：净价价格*券面金额（万元）*100,全价金额计算方式一致
  				enNetPriceAmount = mul(enNetPrice,mul(enFaceAmount,100));
  				enNetPriceAmount = formatNumber(enNetPriceAmount,2,1);
  				nui.get("enNetPriceAmount").setValue(enNetPriceAmount);
  				enFaceAmount = formatNumber(enFaceAmount,2,1);
				nui.get("enFaceAmount").setValue(enFaceAmount);
			}
			enNetPrice = formatNumber(enNetPrice,4,1);
			if(bondPriceType == "0"){//全价
	   			nui.get("enFullPrice").setValue(enNetPrice);	 //全价金额
	   		}else{
	   			nui.get("enNetPrice").setValue(enNetPrice);	 //净价金额
	   		}
			//计算持仓占比和未成占比和指令占比
			var enNetPrice = nui.get("enNetPrice").value;//净价
			var enFaceAmountTemp = nui.get("enFaceAmount").value.replace(/,/g,'');
			window.parent.calculatePercentage(enNetPrice,enFaceAmountTemp,enBondAsset,sumFaceAmount,function(value){
				//nui.get("enFaceAmount").setValue(value);
			});
  		}else if(enFaceAmount){
  			enFaceAmount = formatNumber(enFaceAmount,2,1);
  			nui.get("enFaceAmount").setValue(enFaceAmount);
  		//计算持仓占比和未成占比和指令占比
			var enNetPrice = nui.get("enNetPrice").value;//净价
			window.parent.calculatePercentage(enNetPrice,enFaceAmount,enBondAsset,sumFaceAmount,function(value){
				//nui.get("enFaceAmount").setValue(value);
			});
  		}
   	  }
  	  //根据债券代码判断是净价还是全价
  		function getBondType(){
  			var vcStockCode = nui.get("vcStockCode").getValue();
  			var vcMarket = nui.get("vcMarket").getValue();
  			var parameter = {};
  			parameter["vcStockCode"] = vcStockCode;
  			parameter["vcMarketNo"] = vcMarket;
  			if(vcStockCode){
  				nui.ajax({
  	  				url : "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.getBondAttribute.biz.ext",
  	  				type : 'POST',
  	  				data : {instructParameter:parameter},
  	  				cache : false,
  	  				contentType : 'text/json',
  	  				success : function(text) {
  	  					var returnJson = nui.decode(text);
  	  					if(returnJson.exception == null){
  	  						if(text.resultObject.length > 0){
  	  							var bondType = text.resultObject[0].cNetPrice;
  	  							if(bondType == "1"){
  	  								nui.get("enFullPrice").disable();
  	  								nui.get("enNetPrice").enable();
  	  								$("td[money='money']").html("<span>*</span>净价金额:");
  	  							}else{
  	  								nui.get("enNetPrice").disable();
  	  								nui.get("enFullPrice").enable();
  	  								$("td[money='money']").html("<span>*</span>全价金额:");
  	  							}
  	  							bondPriceType = bondType;
  	  						}else{
  	  							var msg = "找不到债券代码为:"+vcStockCode+"的价格，现默认使用净价！";
  	  							nui.get("enFullPrice").disable();
  								nui.get("enNetPrice").enable();
  								$("td[money='money']").html("<span>*</span>净价金额:");
  	  							bondPriceType = "1";
  	  							nui.alert(msg,"系统提示");
  	  						}
  	  					}else{
  	  						nui.alert("系统异常","系统提示");
  	  					}
  	  				}
  	  			});
  			}
  		}