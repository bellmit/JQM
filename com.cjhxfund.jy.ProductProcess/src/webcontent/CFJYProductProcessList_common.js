/**
 * 	童伟	
 * 20170518
 * 用于机器猫业务查询
 */
    
    //查询--所有业务通用
	function search(grid_search, form_id) {
		//获取之前选中记录的主键ID，刷新后继续选中之前记录
		var rows_search = grid_search.getSelecteds();
		var rowIds_search = "";
		for(var i=0; i<rows_search.length; i++){
			rowIds_search += rows_search[i].processId;
			if(i<rows_search.length-1){
				rowIds_search += ",";
			}
		}
		//开始查找记录
	    var form = new nui.Form(form_id);
	    var json = form.getData(false,false);
	    grid_search.load(json,function(){
	    	//选中刷新前选中的记录
	    	var rows = grid_search.findRows(function (row) {
	    		var exist = false;
	    		if(rowIds_search!=null && rowIds_search!=""){
	    			var rowIdsArr = rowIds_search.split(",");
	    			for(var i=0; i<rowIdsArr.length; i++){
	    				if (row.processId == rowIdsArr[i]){
		                	exist = true;
		                	break;
		                }
	    			}
	    		}
	    		return exist;
            });
            grid_search.selects(rows);
	    });//grid查询
	}
	
	//表格行增加背景色--所有业务通用
	function drawcellFun(e){
		var record = e.record;
		var	column = e.column;
		var	field = e.field;
		var	value = e.value;
		//设置行样式，交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
		if(record.validStatus=="1" || record.validStatus=="4"){
			e.rowCls = "validStatus_modify_1_4";
		}else if(record.validStatus=="2"){
			e.rowCls = "validStatus_del_2";
		}else if(record.validStatus=="3"){
			e.rowCls = "validStatus_modify_3";
		}else{
			//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
			if(record.processStatus=="-2"){
				e.rowCls = "processStatus_-2_tg";
			}else if(record.processStatus=="-1" || record.processStatus=="0"){
				e.rowCls = "processStatus_-1_tg";
				
				//若当前用户有权限处理该指令单，则该指令单使用特定背景色显示
				var userIdRelaType07All = record.userIdRelaType07All!=null?record.userIdRelaType07All:"";//07-产品与投顾确认权限(全部人员)
	        	var userIdRelaType07 = record.userIdRelaType07!=null?record.userIdRelaType07:"";//07-产品与投顾确认权限(过滤自己)
				var userIdRelaTypeA1 = record.userIdRelaTypeA1!=null?record.userIdRelaTypeA1:"";//A1-投顾录入确认可为同一人员
				var hasPermission = false;
				if(userIdRelaType07All!=null && userIdRelaType07All!=""){//设置了复核人员
					var userIdRelaType07Arr = userIdRelaType07.split(",");//默认过滤自己
					if(userIdRelaTypeA1!=null && userIdRelaTypeA1!=""){//可为同一人员
						userIdRelaType07Arr = userIdRelaType07All.split(",");
					}
					for(var j=0; j<userIdRelaType07Arr.length; j++){
						var userIdTemp = userIdRelaType07Arr[j];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
				}else{
					hasPermission = true;
				}
				if(hasPermission==true){
					e.rowCls = "processStatus_wait_confirm";
				}
			}else if(record.processStatus=="1"||record.processStatus=="7"){
				if(record.processStatus=="1"&&"99"==record.processType){//其它投资、委托人确认节点
					var hasPermission = false;
					var userIdRelaTypeA3 = record.userIdRelaTypeA3!=null?record.userIdRelaTypeA3:"";//A3-组合与委托人确认权限
					if(hasPermission == false && userIdRelaTypeA3!=null && userIdRelaTypeA3!=""){
					    var userIdRelaTypeA3Array=userIdRelaTypeA3.split(",");
					    for(var loop=0;loop<userIdRelaTypeA3Array.length;loop++){
					        var userIdTemp = userIdRelaTypeA3Array[loop];
							if(userIdTemp==userId){
								hasPermission = true;
								break;
							}
					    }
					    if(hasPermission==true){
							e.rowCls = "processStatus_wait_confirm";
						}
					}else{
						e.rowCls = "processStatus_1_tg";
						// 投资经理权限
				    	var processId = record.processId;
		        		nui.ajax({
		        			url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductProcessHandleByProcessId.biz.ext",
			                type:'POST',
			                data:{processId:processId},
				            async:false, 
			                cache:false,
			                contentType:'text/json',
			                success:function(text){
				        		//若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
				        		var resultData = nui.decode(text);
				        		if(resultData.exception == null){
				        			var hasPermission = false;
				                    if(resultData.users.length>0){
				                    	for(var i=0; i<resultData.users.length; i++){
				                    		userIdRelaType02Arr = resultData.users[i].userIdRelaType02.split(",");
				                    		for(var i=0; i<userIdRelaType02Arr.length; i++){
												var userIdTemp = userIdRelaType02Arr[i];
												if(userIdTemp==userId){
													hasPermission = true;
													break;
												}
											}
				                    	}
				                    }
				                    if(hasPermission==true){
										e.rowCls = "processStatus_wait_confirm";
									}
				        		}
			                } 
		        		});
					}
				}else{
					e.rowCls = "processStatus_1_tg";
					// 投资经理权限
			    	var processId = record.processId;
	        		nui.ajax({
	        			url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductProcessHandleByProcessId.biz.ext",
		                type:'POST',
		                data:{processId:processId},
			            async:false, 
		                cache:false,
		                contentType:'text/json',
		                success:function(text){
			        		//若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
			        		var resultData = nui.decode(text);
			        		if(resultData.exception == null){
			        			var hasPermission = false;
			                    if(resultData.users.length>0){
			                    	for(var i=0; i<resultData.users.length; i++){
			                    		userIdRelaType02Arr = resultData.users[i].userIdRelaType02.split(",");
			                    		for(var i=0; i<userIdRelaType02Arr.length; i++){
											var userIdTemp = userIdRelaType02Arr[i];
											if(userIdTemp==userId){
												hasPermission = true;
												break;
											}
										}
			                    	}
			                    }
			                    if(hasPermission==true){
									e.rowCls = "processStatus_wait_confirm";
								}
			        		}
		                } 
	        		});
				}
			}else if(record.processStatus=="2"){
				e.rowCls = "processStatus_2_tg";
			}else if(record.processStatus=="3"){
				e.rowCls = "processStatus_3_tg";
			}else if(record.processStatus=="4"){
				e.rowCls = "processStatus_4_tg";
			}else if(record.processStatus=="5"){
				e.rowCls = "processStatus_5_tg";
			}else if(record.processStatus=="6"){
				e.rowCls = "processStatus_6_tg";
			}
		}
	}
	
	//行双击时弹出页面展示该指令详细信息--所有业务通用
    function rowdblclickFun(jspUrl, title, width, height, e, grid_confirm) {
        var row = e.record;//行对象值
        if (row) {
        	nui.open({
                url: "<%=request.getContextPath()%>/ProductProcess/"+jspUrl,
                title: title,
                width: width,
                height: height,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = {pageType:"query",roleType:"TG",record:{cfjyproductprocess:row}};
                    //直接从页面获取，不用去后台获取
                    iframe.contentWindow.setFormData(data);
                },
                ondestroy: function (action) {//弹出页面关闭前
                	if(action=="confirmSuccess"){//若是确认，则刷新页面
                		grid_confirm.reload();
                	}
		        }
            });
        }
    }
	
	//债券类别--所有业务通用
	function renderInvestCategory(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_BOND_CATEGORY",e.row.investCategory);
	}
	//主体评级--所有业务通用
	function renderSubjectRating(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_SUBJECT_RATING",e.row.subjectRating);
	}
	//债券评级--所有业务通用
	function renderBondRating(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_BOND_RATING",e.row.bondRating);
	}
	//清算速度--所有业务通用
	function renderClearingSpeed(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_CLEARING_SPEED",e.row.clearingSpeed);
	}
	//清算类型--所有业务通用
	function renderClearType(e){
	    return nui.getDictText("CF_JY_PRODUCT_PROCESS_CLEAR_TYPE",e.row.cleartype);
	}
	//交易场所--所有业务通用
	function renderTradingPlace(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_TRADING_PLACE",e.row.tradingPlace);
	}
	//收益率类型--所有业务通用
	function renderInterestRateType(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_INTEREST_RATE_TYPE",e.row.interestRateType);
	}
    //评级机构--所有业务通用
	function renderRatingAgencies(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_RATING_AGENCIES",e.row.ratingAgencies);
	}
	//缴款场所--所有业务通用
	function renderPaymentPlace(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_PAYMENT_PLACE",e.row.paymentPlace);
	}
	//提前支取条款--所有业务通用
	function renderEarlyWithdrawalClause(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_EARLY_WITHDRAWAL_CLAUSE",e.row.earlyWithdrawalClause);
	}
	//要求到账时间--所有业务通用
	function renderDemandArrivalTime(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_DEMAND_ARRIVAL_TIME",e.row.demandArrivalTime);
	}
    //业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;16-交易所协议正回购;17-交易所协议逆回购;21-交易所正回购；22-交易所逆回购；99-其他指令/建议;
    function renderProcessType(e) {
    	var processType = "";
    	if(e.row.processType=="01" || e.row.processType=="02"){
    		processType = nui.getDictText("CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQMM",e.row.processType);
    	}else if(e.row.processType=="03" || e.row.processType=="04" || e.row.processType=="05" || e.row.processType=="06" || e.row.processType=="16" || e.row.processType=="17" || e.row.processType=="21" || e.row.processType=="22"){
    		processType = nui.getDictText("CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZNHG",e.row.processType);
    	}else if(e.row.processType=="07" || e.row.processType=="08"){
    		processType = nui.getDictText("CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQSJ",e.row.processType);
    	}else if(e.row.processType=="09" || e.row.processType=="10" || e.row.processType=="11" || e.row.processType=="18"){
    		processType = nui.getDictText("CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_JJSS",e.row.processType);
    	}else if(e.row.processType=="12" || e.row.processType=="13"){
    		processType = nui.getDictText("CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_TYCQ",e.row.processType);
    	}else if(e.row.processType=="14" || e.row.processType=="15"){
    		processType = nui.getDictText("CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZJZT",e.row.processType);
    	}
		return processType;
	}
	//交易状态处理--所有业务通用
	function renderValidStatus(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_VALID_STATUS",e.row.validStatus);
	}
	//买卖方向处理--所有业务通用
	function renderDeliveryMethod(e) {
		return nui.getDictText("CF_JY_MMFX",e.row.deliveryMethod);
	}
	
	//指令/建议询价列处理--所有业务通用
	function renderInquiry(e){
		if(e.row.inquiryName!=null || e.row.inquiryCd!=null){
			return (e.row.inquiryName==null?"":e.row.inquiryName) + "　" + nui.formatDate(e.row.inquiryCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//指令/建议补齐列处理--所有业务通用
	function renderCompleteInstructions(e){
		if(e.row.completeInstructionsName!=null || e.row.completeInstructionsCd!=null){
			return (e.row.completeInstructionsName==null?"":e.row.completeInstructionsName) + "　" + nui.formatDate(e.row.completeInstructionsCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//指令/建议录入列处理--所有业务通用
	function renderInvestAdviser(e){
		if(e.row.investAdviserName!=null || e.row.investAdviserCd!=null){
			return (e.row.investAdviserName==null?"":e.row.investAdviserName) + "　" + nui.formatDate(e.row.investAdviserCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//指令/建议确认列处理--所有业务通用
	function renderInvestAdviserConfirm(e){
		if(e.row.investAdviserConfirmName!=null || e.row.investAdviserConfirmCd!=null){
			return (e.row.investAdviserConfirmName==null?"":e.row.investAdviserConfirmName) + "　" + nui.formatDate(e.row.investAdviserConfirmCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	
	//指令复核
	function renderEntrust(e){
		if(e.row.entrustName!=null || e.row.entrustCd!=null){
			return (e.row.entrustName==null?"":e.row.entrustName) + "　" + nui.formatDate(e.row.entrustCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	
	//投资经理下单列处理--所有业务通用
	function renderInvestManager(e){
		if(e.row.investManagerName!=null || e.row.investManagerCd!=null){
			return (e.row.investManagerName==null?"":e.row.investManagerName) + "　" + nui.formatDate(e.row.investManagerCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//交易员填单列处理--所有业务通用
	function renderTrader(e){
		if(e.row.traderName!=null || e.row.traderCd!=null){
			return (e.row.traderName==null?"":e.row.traderName) + "　" + nui.formatDate(e.row.traderCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//交易已发送列处理--所有业务通用
	function renderReview(e){
		if(e.row.reviewName!=null || e.row.reviewCd!=null){
			return (e.row.reviewName==null?"":e.row.reviewName) + "　" + nui.formatDate(e.row.reviewCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//前台已成交列处理--所有业务通用
	function renderSend(e){
		if(e.row.sendName!=null || e.row.sendCd!=null){
			return (e.row.sendName==null?"":e.row.sendName) + "　" + nui.formatDate(e.row.sendCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//后台已成交列处理--所有业务通用
	function renderBackstageTrader(e){
		if(e.row.backstageTraderName!=null || e.row.backstageTraderCd!=null){
			return (e.row.backstageTraderName==null?"":e.row.backstageTraderName) + "　" + nui.formatDate(e.row.backstageTraderCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//后台成交状态--所有业务通用
	function renderBackstageTraderStatus(e){
		//return nui.getDictText("CF_JY_HTCJZT",e.row.backstageTraderStatus);
		return "";
	}
	//展示详细行数据--所有业务通用
	function onShowRowDetail(e) {
		var grid = e.sender;//获取表格
	    var row = e.record;//获取行数据
	    var remark = changeNull(row.remark);//备注信息
	    var earlyWithdrawalClause = changeNull(row.earlyWithdrawalClause);//执行备注信息
	    var abandonedReasons = changeNull(row.abandonedReasons);//废弃原因
	    var inquiryMd = nui.formatDate(row.inquiryMd, "yyyy-MM-dd HH:mm:ss");//指令/建议询价修改、废弃时间
	    var investAdviserMd = nui.formatDate(row.investAdviserMd, "yyyy-MM-dd HH:mm:ss");//指令/建议录入修改、废弃时间	    
	    var completeInstructionsMd = nui.formatDate(row.completeInstructionsMd, "yyyy-MM-dd HH:mm:ss");//指令/建议补齐修改时间
	    var mdTime =  completeInstructionsMd==null||completeInstructionsMd==""?(inquiryMd==null||inquiryMd==""?investAdviserMd:inquiryMd):completeInstructionsMd;//修改、废弃时间，交易员填单指令/建议补齐修改时间优先级最高
	    
	    var td = grid.getRowDetailCellEl(row);
		var html = "<table style='width:100%;'>";
		if(mdTime!=null && mdTime!=""){
			html +=" <tr>"
				 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>修改废弃时间：</td>"
				 + "  <td>" + mdTime + "</td>"
				 + " </tr>";
		}
		if(abandonedReasons!=null && abandonedReasons!=""){
			html +=" <tr>"
				 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>废弃原因：</td>"
				 + "  <td>" + abandonedReasons + "</td>"
				 + " </tr>";
		}
		if(remark!=null && remark!=""){
			html +=" <tr>"
				 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>备注信息：</td>"
				 + "  <td>" + remark + "</td>"
				 + " </tr>";
		}
		if(earlyWithdrawalClause!=null && earlyWithdrawalClause!=""){
			html +=" <tr>"
				 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>执行备注信息：</td>"
				 + "  <td>" + earlyWithdrawalClause + "</td>"
				 + " </tr>";
		}
		html += "</table>";
		
		td.innerHTML = html;
	}
	
	//当选择列时--所有业务通用
    function selectionChanged(grid, updateId, deleteId){
        var rows = grid.getSelecteds();
        if(rows.length>1){
            nui.get(updateId).disable();
            nui.get(deleteId).disable();
        }else{
            nui.get(updateId).enable();
            nui.get(deleteId).enable();
        }
    }
	  
    //Excel新增
    function add_excel() {
		mini.open({
		    url:"<%=request.getContextPath() %>/ProductProcess/ExcelUploadAdd/excelUploadAdd.jsp",
		    title: "Excel导入新增指令", width: 850, height: 580,
		    overflow:"hidden",
		    onload: function () {
		        
		    },
		    ondestroy: function (action) {
		        grid_ZQMM.reload();
		    }
		});
    }   
	
	//关闭窗口
	function CloseWindow(action) {
	    if (action == "close" && form.isChanged()) {
	        if (confirm("数据被修改了，是否先保存？")) {
	            saveData();
	        }
	    }
	    if (window.CloseOwnerWindow)
	    return window.CloseOwnerWindow(action);
	    else window.close();
	}
	
	//执行确认
	function onOk() {
	     
		//如果是点击确认类型页面（交易员填单）
	    if (rowPageType == "confirm") {
	    	//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
        	var validStatus = rowRecord.validStatus;
        	//获取执行备注信息
        	var earlyWithdrawalClause = "";
        	if(nui.get("earlyWithdrawalClause")!=null){
        		earlyWithdrawalClause = nui.get("earlyWithdrawalClause").getValue();
        	}
        	
        	
        	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
        		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
        		return;
        	}
        	if(validStatus=="3"){
        		nui.alert("该指令/建议已退回，您不能再确认","提示");
        		return;
        	}
        	
        	var jsonStatus = nui.encode({cfjyproductprocess:{processId:rowRecord.processId}});
        	$.ajax({
                url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProcessStatus.biz.ext",
                type:'POST',
                data:jsonStatus,
                async:false, 
		        cache:false,
                contentType:'text/json',
                success:function(text){
                    var returnJsonStatus = nui.decode(text);
                    
                    //“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
		        	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
		        	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
		        	var processStatus = returnJsonStatus.processStatus;
		        	
		        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0" || processStatus=="1"||processStatus=="7"){
		        		nui.alert("该指令/建议尚未确认，您还不能处理","提示");
        				return;
					//交易确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
		        	}else if(processStatus=="2" || processStatus=="3" || processStatus=="4"){
		        		var hasPermission = false;//是否有权限，默认无
						if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
							var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
							for(var i=0; i<tradingConfirmAuthorityUserIdsArr.length; i++){
								var userIdTemp = tradingConfirmAuthorityUserIdsArr[i];
								if(userIdTemp==userId){
									hasPermission = true;
									break;
								}
							}
						}
						if(hasPermission==false){
							nui.alert("您没有权限确认该指令/建议","提示");
    						return;
						}
		        	
		        	//后台已成交确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
		        	}else if(processStatus=="5"){
		        		var hasPermission = false;//是否有权限，默认无
						if(backstageConfirmAuthorityUserIds!=null && backstageConfirmAuthorityUserIds!=""){
							var backstageConfirmAuthorityUserIdsArr = backstageConfirmAuthorityUserIds.split(",");
							for(var i=0; i<backstageConfirmAuthorityUserIdsArr.length; i++){
								var userIdTemp = backstageConfirmAuthorityUserIdsArr[i];
								if(userIdTemp==userId){
									hasPermission = true;
									break;
								}
							}
						}
						if(hasPermission==false){
							nui.alert("您没有权限确认该指令/建议","提示");
    						return;
						}
		        	}		        	
		        	
		        	var msg = "";
		        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0" || processStatus=="1"|| processStatus=="7"){
		        		nui.alert("该指令/建议尚未确认，您还不能处理","提示");
        				return;
		        	}else if(processStatus=="2"){
		        		msg = "该指令/建议现为投资经理下单完成阶段，确定要继续确认吗？";
		        	}else if(processStatus=="3"){
		        		msg = "该指令/建议现为交易员填单完成阶段，确定要继续确认吗？";
		        	}else if(processStatus=="4"){
		        		msg = "该指令/建议现为交易已发送阶段，确定要继续确认吗？";
		        	}else if(processStatus=="5"){
		        		msg = "该指令/建议现为前台已成交阶段，确定要继续确认吗？";
		        	}else if(processStatus=="6"){
		        		nui.alert("该指令/建议后台已成交，不能再做任何操作","提示");
		        		return;
		        	}
			    
			        nui.confirm(msg,"系统提示",
			        function(action){
			            if(action=="ok"){
			            	
			            	//提交之前再次实时查询指令/建议单有效状态，避免用户在操作界面停留时间太长导致界面数据状态与数据库不一致
			            	var jsonValidStatus = nui.encode({cfjyproductprocess:{processId:rowRecord.processId}});
						  	$.ajax({
						          url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getValidStatus.biz.ext",
						          type:'POST',
						          data:jsonValidStatus,
					              async:false, 
							      cache:false,
						          contentType:'text/json',
						          success:function(text){
						              var returnJsonValidStatus = nui.decode(text);
						              //交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
						              var returnValidStatus = returnJsonValidStatus.validStatus;
						              
						              //若指令/建议单有效，则继续执行
						              if(returnValidStatus=="0"){
						              
						              	  	//封装主键ID、指令/建议流程处理状态字段传输到后台处理
						                    var json = nui.encode({cfjyproductprocesss:[{processId:rowRecord.processId, processStatus:processStatus,earlyWithdrawalClause:earlyWithdrawalClause}]});
							                $.ajax({
							                    url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.confirmCFJYProductProcesss.biz.ext",
							                    type:'POST',
							                    data:json,
								                async:false, 
										        cache:false,
							                    contentType:'text/json',
							                    success:function(text){
							                        var returnJson = nui.decode(text);
							                        if(returnJson.exception == null){
							                        	var validStr = returnJson.validStr;//有效指令/建议单字符串
							                        	var invalidStr = returnJson.invalidStr;//无效指令/建议单字符串
							                        	var validCount = returnJson.validCount;//有效指令/建议单记录数
							                        	var invalidCount = returnJson.invalidCount;//无效指令/建议单记录数
							                        	var msg = "";
							                        	if(validCount!=null && validCount!="" && validCount!="0"){
							                        		msg = "确认成功 " + validCount + " 条";
							                        	}
							                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
							                        		if(msg!=null && msg!=""){
							                        			msg += "；";
							                        		}
							                        		msg += "确认失败 " + invalidCount + " 条，产品名称为【" + invalidStr + "】";
							                        	}
							                            nui.alert(msg, "系统提示", function(action){
							                            	CloseWindow("confirmSuccess");
							                            });
							                        }else{
						                                nui.alert("确认失败", "系统提示");
							                        }
							                    }
							                });
						              }else if(returnValidStatus=="3"){
						              	  nui.alert("该指令/建议已退回，您不能再确认","提示");
        								  return;
						              }else{
										  nui.alert("该指令/建议已无效，不能再做任何操作","提示");
        								  return;
						              }
						          }
						      });
			             }
			        });
                }
            });
	    	
	    //投顾处理（投资经理和投顾确认）
	    }else{
	    
	    	//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
        	var validStatus = rowRecord.validStatus;
        	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
        		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
        		return;
        	}
        	if(validStatus=="3"){
        		nui.alert("该指令/建议已退回，请先修改重新提交后再确认","提示");
        		return;
        	}
        	
        	var jsonStatus = nui.encode({cfjyproductprocess:{processId:rowRecord.processId}});
        	var hasPermission = false;//是否有权限，默认无

        	$.ajax({
                url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProcessStatus.biz.ext",
                type:'POST',
                data:jsonStatus,
                async:false, 
		        cache:false,
                contentType:'text/json',
                success:function(text){
                    var returnJsonStatus = nui.decode(text);
                    
                    //“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
		        	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
		        	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
		        	var processStatus = returnJsonStatus.processStatus;
		        	if(processStatus=="-2"){
		        		nui.alert("该指令/建议尚未补齐，您还不能处理","提示");
        				return;
		        	}else if(processStatus=="-1" || processStatus=="0" || processStatus=="1"|| processStatus=="7"){
		        		if(processStatus=="-1" || processStatus=="0"){
		        			var pUserId = rowRecord.inquiryId==null||rowRecord.inquiryId==""?rowRecord.investAdviserId:rowRecord.inquiryId;
			        		//获取该产品投顾复核权限人员名单
					    	$.ajax({
					            url:"com.cjhxfund.jy.ProductProcess.CFJYCombProductHandleBiz.getInvestAdviserConfirmId.biz.ext",
					            type:'POST',
					            data:nui.encode({combProductCode:rowRecord.combProductCode, vcCombiNo:rowRecord.vcCombiNo, userId:pUserId}),
					            cache:false,
					            async:false, 
					            contentType:'text/json',
					            success:function(text){
					                var returnJson = nui.decode(text);
					                if(returnJson.exception == null){
					                	var confirmUserIds = returnJson.confirmUserIds;
					                	//返回值不为空，说明设置了复核人员
					                	if(confirmUserIds!=null && confirmUserIds!=""){
											var confirmUserIdsArr = confirmUserIds.split(",");
											for(var i=0; i<confirmUserIdsArr.length; i++){
												var userIdTemp = confirmUserIdsArr[i];
												if(userIdTemp==userId){
													hasPermission = true;
													break;
												}
											}
					                	}
										if(hasPermission==false){
											nui.alert("您没有权限确认该指令/建议","提示");
				    						return;
										}
					                }else{
					                    nui.alert("权限人员名单获取失败", "系统提示");
					                    return;
					                }
					            }
					        });
		        		}else if(processStatus=="1"||processStatus=="7"){
		        			if(processStatus=="1"&&rowRecord.processType=="99"){
		        				//无权限复核的记录
				        	    var userIdRelaTypeA3 = rowRecord.userIdRelaTypeA3!=null?rowRecord.userIdRelaTypeA3:"";//A3-组合与委托人确认权限
				        	    if(userIdRelaTypeA3!=null&&userIdRelaTypeA3!=""){
									var userIdRelaTypeA3Array=userIdRelaTypeA3.split(",");
									for(var loop=0;loop<userIdRelaTypeA3Array.length;loop++){
									    var userIdTemp = userIdRelaTypeA3Array[loop];
									    if(userIdTemp==userId){
											hasPermission = true;
											break;
										}
									}
									if(hasPermission == false){
										nui.alert("您没有权限复核该指令/建议","提示");
										return;
									}
								}else{
									// 投资经理权限
							    	var processId = rowRecord.processId;
					        		nui.ajax({
					        			url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductProcessHandleByProcessId.biz.ext",
						                type:'POST',
						                data:{processId:processId},
							            async:false, 
						                cache:false,
						                contentType:'text/json',
						                success:function(text){
							        		//若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
							        		var resultData = nui.decode(text);
							        		if(resultData.exception == null){
							                    if(resultData.users.length>0){
							                    	for(var i=0; i<resultData.users.length; i++){
							                    		userIdRelaType02Arr = resultData.users[i].userIdRelaType02.split(",");
							                    		for(var i=0; i<userIdRelaType02Arr.length; i++){
															var userIdTemp = userIdRelaType02Arr[i];
															if(userIdTemp==userId){
																hasPermission = true;
																break;
															}
														}
							                    	}
							                    }
												if(hasPermission==false){
													resultStatus="1";
													nui.alert("您没有权限确认该指令/建议","提示");
						    						return;
												}
							        		}else{
							        			nui.alert("系统异常","提示");
						    					return;
							        		}
						                } 
					        		});
								}
		        			}else{
		        				// 投资经理权限
						    	var processId = rowRecord.processId;
				        		nui.ajax({
				        			url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductProcessHandleByProcessId.biz.ext",
					                type:'POST',
					                data:{processId:processId},
						            async:false, 
					                cache:false,
					                contentType:'text/json',
					                success:function(text){
						        		//若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
						        		var resultData = nui.decode(text);
						        		if(resultData.exception == null){
						                    if(resultData.users.length>0){
						                    	for(var i=0; i<resultData.users.length; i++){
						                    		userIdRelaType02Arr = resultData.users[i].userIdRelaType02.split(",");
						                    		for(var i=0; i<userIdRelaType02Arr.length; i++){
														var userIdTemp = userIdRelaType02Arr[i];
														if(userIdTemp==userId){
															hasPermission = true;
															break;
														}
													}
						                    	}
						                    }
											if(hasPermission==false){
												resultStatus="1";
												nui.alert("您没有权限确认该指令/建议","提示");
					    						return;
											}
						        		}else{
						        			nui.alert("系统异常","提示");
					    					return;
						        		}
					                } 
				        		});
		        			}
		        		}
		        		if(hasPermission == true){
		        			nui.confirm("确定要确认该指令/建议吗？","系统提示",function(action){
					            if(action=="ok"){
					            	
					            	//提交之前再次实时查询指令/建议单有效状态，避免用户在操作界面停留时间太长导致界面数据状态与数据库不一致
					            	var jsonValidStatus = nui.encode({cfjyproductprocess:{processId:rowRecord.processId}});
								  	$.ajax({
								          url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getValidStatus.biz.ext",
								          type:'POST',
								          data:jsonValidStatus,
							              async:false, 
								          cache:false,
								          contentType:'text/json',
								          success:function(text){
								              var returnJsonValidStatus = nui.decode(text);
								              //交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
								              var returnValidStatus = returnJsonValidStatus.validStatus;
								              
								              //若指令/建议单有效，则继续执行
								              if(returnValidStatus=="0"){
								              
								              	  	//封装主键ID、指令/建议流程处理状态字段传输到后台处理
								                    var json = nui.encode({cfjyproductprocesss:[{processId:rowRecord.processId, processStatus:processStatus,earlyWithdrawalClause:earlyWithdrawalClause}]});
									                $.ajax({
									                    url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.confirmCFJYProductProcesss.biz.ext",
									                    type:'POST',
									                    data:json,
									                    cache: false,
									                    contentType:'text/json',
									                    success:function(text){
									                        var returnJson = nui.decode(text);
									                        if(returnJson.exception == null){
									                        	var validStr = returnJson.validStr;//有效指令/建议单字符串
									                        	var invalidStr = returnJson.invalidStr;//无效指令/建议单字符串
									                        	var validCount = returnJson.validCount;//有效指令/建议单记录数
									                        	var invalidCount = returnJson.invalidCount;//无效指令/建议单记录数
									                        	var msg = "";
									                        	if(validCount!=null && validCount!="" && validCount!="0"){
									                        		msg = "确认成功 " + validCount + " 条";
									                        	}
									                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
									                        		if(msg!=null && msg!=""){
									                        			msg += "；";
									                        		}
									                        		msg += "确认失败 " + invalidCount + " 条，产品名称为【" + invalidStr + "】";
									                        	}
									                            nui.alert(msg, "系统提示", function(action){
									                            	CloseWindow("confirmSuccess");
									                            });
									                        }else{
								                                nui.alert("确认失败", "系统提示");
									                        }
									                    }
									                });
								              }else if(returnValidStatus=="3"){
								              	  nui.alert("该指令/建议已退回，请先修改重新提交后再确认","提示");
		        								  return;
								              }else{
												  nui.alert("该指令/建议已无效，不能再做任何操作","提示");
		        								  return;
								              }
								          }
								      });
					             }
					        });
		        			
		        		}
		        		
		        	}else{
		        		nui.alert("该指令/建议已确认","提示");
        				return;
		        	}
                }
            });
	    }
	}
	
	//退回
	function onGoBack(){
		
		//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
    	var validStatus = rowRecord.validStatus;
    	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
    		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
    		return;
    	}
    	if(validStatus=="3"){
    		nui.alert("该指令/建议已退回，请不要重复操作","提示");
    		return;
    	}
		
		var processStatus = rowRecord.processStatus;//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
		if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
			nui.alert("该指令/建议尚未确认，您还不能处理","提示");
    		return;
		
		//投资经理下单操作权限认证
		}else if(processStatus=="1"||processStatus=="7"){
			if(processStatus=="1"&&rowRecord.processType=="99"){//其它投资复核结点
				var userIdRelaTypeA3 = record.userIdRelaTypeA3!=null?record.userIdRelaTypeA3:"";//A3-组合与委托人确认权限
				if(userIdRelaTypeA3!=null&&userIdRelaTypeA3!=""){//配了复核结点
					nui.alert("该指令/建议尚未确认，您还不能处理","提示");
		    		return;
				}
			}else{
				//若当前用户有权限处理该指令/建议单，则继续执行，否则返回
	    		var hasPermission = false;//是否有权限，默认无
				var userIdRelaType02 = rowRecord.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
				if(userIdRelaType02!=null && userIdRelaType02!=""){
					var userIdRelaType02Arr = userIdRelaType02.split(",");
					for(var j=0; j<userIdRelaType02Arr.length; j++){
						var userIdTemp = userIdRelaType02Arr[j];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
				}
				if(hasPermission==false){
					nui.alert("您没有权限退回该指令/建议","提示");
	    			return;
				
				}else{
					
					//封装主键ID字段传输到后台处理开始...
		    		var msg = "确定要退回该指令/建议吗？";
		    		nui.confirm(msg,"系统提示",function(action){
						if(action=="ok"){
			                var json = nui.encode({cfjyproductprocesss: [{processId: rowRecord.processId}], validStatus: "3"});
			                $.ajax({
			                    url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.updateValidStatus.biz.ext",
			                    type:'POST',
			                    data:json,
			                    cache: false,
			                    contentType:'text/json',
			                    success:function(text){
			                        var returnJson = nui.decode(text);
			                        if(returnJson.exception == null){
			                            nui.alert("退回成功", "系统提示", function(action){
			                            	CloseWindow("confirmSuccess");
			                            });
			                        }else{
			                            nui.alert("退回失败", "系统提示");
			                        }
			                    }
			                });
						}
					});
		    		//封装主键ID字段传输到后台处理结束!!!
				}
			}
		}else{
			nui.alert("该指令/建议投资经理已下单，不能做退回操作","提示");
    		return;
		}
	}
	
	//取消
	function onCancel() {
	    CloseWindow("cancel");
	}
	
	//设置表单数据公共逻辑处理----所有业务通用
	function setFormDataCommon(form, json, infos){
		form.setData(json);
        form.setChanged(false);

	    //如果是点击确认类型页面（投资经理下单、交易员填单）
	    if (infos.pageType == "confirm") {
	    	//nui.get("confirm").disable();//将“确认”按钮设置为可用
	    	nui.get("goBack").disable();//将“退回”按钮设置为不可用
	    	//获取交易确认阶段权限人员名单，权限关系类型：01-产品与投资顾问权限；02-产品与投资经理下单权限；03-产品与交易员填单权限；04-产品与复核员[交易发送]权限；05-产品与前台已成交权限；06-产品与后台已成交员权限；98-后台已成交确认阶段权限；99-交易确认阶段权限；
	    	$.ajax({
	            url:"com.cjhxfund.commonUtil.ProductManager.getTradingConfirmAuthority.biz.ext",
	            type:'POST',
	            data:null,
	            cache:false,
	            contentType:'text/json',
	            success:function(text){
	                var returnJson = nui.decode(text);
	                if(returnJson.exception == null){
	                	tradingConfirmAuthorityUserIds = returnJson.userIds99;//交易确认阶段权限人员名单字符串，确认时使用
	                	backstageConfirmAuthorityUserIds = returnJson.userIds98;//后台已成交阶段权限人员名单字符串，确认时使用
	                	//显示执行备注输入框
	                	document.getElementById('id').style.display ="";
	                }else{
	                    nui.alert("权限人员名单获取失败", "系统提示");
	                }
	            }
	        });
	    }
	}
	
	//退回--所有业务通用
	function goBack(grid_goBack){
		debugger;
	    var rows = grid_goBack.getSelecteds();
	    if(rows.length > 0){
	    
    		//有效无效验证开始...
    		var validStr = "";//有效无效验证字符串
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];//产品记录
    			var combProductName = record.combProductName;//产品名称
    			var investProductNum = record.investProductNum;//编号
	        	var validStatus = record.validStatus;//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
	        	if(validStatus!="0"){
	        		validStr += "、" + investProductNum + "-" + combProductName;
	        	}
    		}
    		if(validStr!=null && validStr!="" && validStr.length>0){
    			validStr = validStr.substr(1,validStr.length);
    			var msg = "【"+validStr+"】</br>指令/建议已无效或退回，请先剔除";
    			nui.alert(msg,"提示");
    			return;
    		}
    		//有效无效验证结束!!!
    		
    		//权限验证开始...
    		var goBackStr = "";//该阶段不能退回字符串
    		var permissionStr = "";//权限验证字符串
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];//产品记录
    			var combProductName = record.combProductName;//产品名称
    			var investProductNum = record.investProductNum;//编号
	        	var processStatus = record.processStatus;//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；7-委托人复核; 2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
	        	
	        	//投顾尚未确认
	        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
	        		goBackStr += "、" + investProductNum + "-" + combProductName;
	        	
	        	//投资经理下单操作权限认证
	        	}else if(processStatus=="1"||processStatus=="7"){
	        		
	        		if(processStatus=="1"&&record.processType=="99"){//其它投资复核结点，还没有到投资经理确认节点
						var userIdRelaTypeA3 = record.userIdRelaTypeA3!=null?record.userIdRelaTypeA3:"";//A3-组合与委托人确认权限
						if(userIdRelaTypeA3!=null&&userIdRelaTypeA3!=""){//配了复核结点
							goBackStr += "、" + investProductNum + "-" + combProductName;
						}
	        		}else{
	        			//若当前用户有权限处理该指令单，则继续执行，否则记录下该产品
		        		var hasPermission = false;//是否有权限，默认无
						var processId = record.processId;
		        		nui.ajax({
		        			url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductProcessHandleByProcessId.biz.ext",
			                type:'POST',
			                data:{processId:processId},
			                async:false, 
			                cache:false,
			                contentType:'text/json',
			                success:function(text){
				        		//若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
				        		var resultData = nui.decode(text);
				        		if(resultData.exception == null){
				                    if(resultData.users.length>0){
				                    	for(var i=0; i<resultData.users.length; i++){
				                    		userIdRelaType02Arr = resultData.users[i].userIdRelaType02.split(",");
				                    		for(var i=0; i<userIdRelaType02Arr.length; i++){
												var userIdTemp = userIdRelaType02Arr[i];
												if(userIdTemp==userId){
													hasPermission = true;
													break;
												}
											}
				                    	}
				                    }

									if(hasPermission==false){
										permissionStr += "、" + investProductNum + "-" + combProductName;
									}
				        		}else{
				        			nui.alert("系统异常","提示");
			    					return;
				        		}
			                }
		        		});
	        		}
				//投资经理下单已确认
	        	}else{
	        		goBackStr += "、" + investProductNum + "-" + combProductName;
	        	}
    		}
    		if(goBackStr!=null && goBackStr!="" && goBackStr.length>0){
    			goBackStr = goBackStr.substr(1,goBackStr.length);
    			var msg = "【"+goBackStr+"】</br>指令/建议尚未确认或投资经理已下单，请先剔除";
    			nui.alert(msg,"提示");
    			return;
    		}
    		if(permissionStr!=null && permissionStr!="" && permissionStr.length>0){
    			permissionStr = permissionStr.substr(1,permissionStr.length);
    			var msg = "您没有权限退回【"+permissionStr+"】指令/建议，请先剔除";
    			nui.alert(msg,"提示");
    			return;
    		}
    		//权限验证结束!!!
    		
    		//封装主键ID字段传输到后台处理开始...
    		var processIdArr = new Array();
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];//产品记录
    			var processIdTemp = {processId: record.processId};//封装指令单主键ID
    			processIdArr.push(processIdTemp);
    		}
    		
    		var msg = "确定要退回所选的 " + rows.length + " 条指令/建议吗？";
    		nui.confirm(msg,"系统提示",function(action){
				if(action=="ok"){
	                var json = nui.encode({cfjyproductprocesss: processIdArr, validStatus: "3"});
	                grid_goBack.loading("正在退回中,请稍等...");
	                $.ajax({
	                    url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.updateValidStatus.biz.ext",
	                    type:'POST',
	                    data:json,
	                    cache: false,
	                    contentType:'text/json',
	                    success:function(text){
	                        var returnJson = nui.decode(text);
	                        if(returnJson.exception == null){
	                            grid_goBack.reload();
	                            nui.alert("退回成功", "系统提示", function(action){
	                            });
	                        }else{
	                            grid_goBack.unmask();
	                            nui.alert("退回失败", "系统提示");
	                        }
	                    }
	                });
				}
			});
    		//封装主键ID字段传输到后台处理结束!!!
	    		
	    }else{
	        nui.alert("请先选中指令/建议！");
	    }
	}
	
	
	