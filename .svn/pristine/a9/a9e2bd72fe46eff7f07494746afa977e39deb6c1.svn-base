/**2016/11/08 杨敏加入  以下报量公共方法目前用于：有债券申购录入，无债券申购录入，交易员1、2审核节点，投资建议管理中修改报量功能**/
	//新增债券记录
	function gridAddRow(datagrid) {
		var grid = nui.get(datagrid);
		var totalCount = grid.getData().length;
		if (totalCount >= 10) {
			nui.alert("最多只能输入10支债券信息", "提示");
			return;
		} else {
			grid.addRow({});
		}
	}
	//删除债券记录
	function gridRemoveRow(datagrid) {
		var grid = nui.get(datagrid);
		var rows = grid.getSelecteds();
		if (rows.length > 0) {
			grid.removeRows(rows, true);
		}
	}
	//重新加载债券信息
	function gridReload(datagrid) {

		var grid = nui.get(datagrid);
		grid.clearRows();//清理所有
		grid.addRows([ {}, {}, {} ]);//默认添加3行
	}
	//报量报价输入校验
	function reportEdit(e) {
		if (e.field != "enReport" & e.field != "enOffer") {
			return;
		}
		
		
		if (e.field == "enOffer" && e.value != "" && e.value != null) {
			if ((e.value+"").indexOf(" ")> -1){
				e.isValid = false;
				e.errorText = "报价不能包含空格！";
				nui.alert("报价不能包含空格！");
				return;
			}
			if (isNaN(e.value) || e.value <= 0) {
				e.isValid = false;
				e.errorText = "报价必须输入大于0的数字";
				nui.alert("报价必须输入大于0的数字");
				return;
			}
		}
		if (e.field == "enReport") {
			if (isNaN(e.value) || e.value == "" || e.value == null) {
				e.isValid = false;
				e.errorText = "必须输入数字";
				return;
			}
			if ((e.value+"").indexOf(" ")> -1){
				e.row.enReport=$.trim(e.value);
				nui.get(e.source.id).updateRow(nui.get(e.source.id).getRow(nui.get(e.source.id).indexOf(e.row)),e.row);
				e.isValid = false;
				e.errorText = "报量不能包含空格！";
				nui.get(e.source.id).beginEditCell ();//解决360 出现文本选择问题
				nui.alert("报量不能包含空格！");
				return;
			}
			if (e.value % 100 > 0 || e.value<=0) {
				//e.value=Math.abs(parseInt(e.value / 100 ) * 100);
				e.row.enReport=Math.abs(parseInt(e.value / 100 ) * 100);
				//console.log(e);
				//console.log(nui.get(e.source.id).indexOf(e.row));
				nui.get(e.source.id).updateRow(nui.get(e.source.id).getRow(nui.get(e.source.id).indexOf(e.row)),e.row);
				e.isValid = false;
				e.errorText = "报量必须为100万的正整数倍";
				nui.get(e.source.id).beginEditCell ();//解决360 出现文本选择问题
				nui.alert("报量必须为100万的正整数倍");
				return ;
			}
		}
	}
	//报量报价提交校验
	function checkReports(rtdata){
		//校验填写规则
		for(var i=0;i<rtdata.length;i++){
			
			if(rtdata[i].enReport!="" && rtdata[i].enReport!=null){
					//校验空格
					if ((rtdata[i].enReport+"").indexOf(" ")> -1){
						nui.alert("报量不能包含空格！");
						return false;
					}
					if(isNaN(rtdata[i].enReport) || rtdata[i].enReport<=0){
						nui.alert("报量必须为100万的正整数倍");
						return false;
					}
					if (rtdata[i].enReport % 100>0) {
						nui.alert("报量必须为100万的正整数倍");
						return false;
					}
			}
			//校验报价
			if(rtdata[i].enOffer!="" && rtdata[i].enOffer!=null){
				//校验空格
				if ((rtdata[i].enOffer+"").indexOf(" ")> -1){
					nui.alert("报价不能包含空格！");
					return false;
				}
				//报价不为空时，校验报量信息
				if(rtdata[i].enReport=="" || rtdata[i].enReport==null){
					nui.alert("报量信息不能为空");
					return false;
				}
				//校验报价输入的正确性
				if(isNaN(rtdata[i].enOffer) || rtdata[i].enOffer<=0){
					nui.alert("报价必须输入大于0的数字");
					return false;
				}
			}
			
		}
		//校验业务数据是否满足业务 要求
		//业务要求：1、累计式中 任意两个报量的数值不能相同.
		var reportType=nui.get("reportType").getValue();
		//判定报量方式
		if(reportType==1){
			var rtDataTemp=new Array();//定义临时数组
			for(var i=0;i<rtdata.length;i++){
				if(rtdata[i].enReport!="" && rtdata[i].enReport!=null && rtdata[i].enReport!=undefined){
					for(var j=0;j<rtDataTemp.length;j++){
						if(rtDataTemp[j].enReport==rtdata[i].enReport){
							nui.alert("累计式报量，不能有相同报量,请确认~");
							return false;
						}
					}
					rtDataTemp[i]=rtdata[i];
				}
				
			}
		}
	}
	//报量报价提交校验
	function checkReports1(rtdata){
		//校验填写规则
		for(var i=0;i<rtdata.length;i++){
			
			if((rtdata[i].enReport!="" && rtdata[i].enReport!=null) || rtdata[i].enReport === 0){
					//校验空格
					if ((rtdata[i].enReport+"").indexOf(" ")> -1){
						nui.alert("报量不能包含空格！");
						return false;
					}
					if(isNaN(rtdata[i].enReport) || rtdata[i].enReport<=0){
						nui.alert("报量必须为100万的正整数倍");
						return false;
					}
					if (rtdata[i].enReport % 100>0) {
						nui.alert("报量必须为100万的正整数倍");
						return false;
					}
			}
			//校验报价
			if(rtdata[i].enOffer!="" && rtdata[i].enOffer!=null){
				//校验空格
				if ((rtdata[i].enOffer+"").indexOf(" ")> -1){
					nui.alert("报价不能包含空格！");
					return false;
				}
				
				//校验报价输入的正确性
				if(isNaN(rtdata[i].enOffer) || rtdata[i].enOffer<=0){
					nui.alert("报价必须输入大于0的数字");
					return false;
				}
			}
			
		}
	}
	//获取报量Datagrid的数据
	function getReportDatagrid(grid,form){
		var rtdata=grid.data;//获取报量信息
		//存储整理后的报量数据
		var applyInstReport=new Array();
		var k=0; //计数器
		
		//判定报量报价是否有未校验通过的值
		//校验报量报价信息
		if(checkReports(rtdata)==false){
			return false;
		}
		
		//提取报量数据
		for(var i=0;i<rtdata.length;i++){
			//新增vcReportRemark
			if(rtdata[i].enReport!="" && rtdata[i].enReport!=null){
				 var report_t=form.getData(false,true).report;//获取临时变量
			     report_t.enReport=rtdata[i].enReport;//用户输入的报量
			     report_t.enOffer=rtdata[i].enOffer;
			     //report_t.enEnsureGold=rtdata[i].enEnsureGold;
			     report_t.vcReportRemark=rtdata[i].vcReportRemark;
			     report_t.lValidStatus=0;//状态	0-有效;1-无效-修改;2-无效-废弃
			     applyInstReport[k]=report_t;
			     k++;
			     
			}
		}
		if(applyInstReport.length<1){
			nui.alert("报量信息不能为空！","申购提示");
			return false;
		}
		var rdata;//存储返回值
		rdata={applyInstReport:applyInstReport};
	
		return rdata;
	}
	/**
	 * 【中标前】计算投标信息（中标前的金额和利率）
	 * @param reportDataS 报量报价信息
	 * @param applyInst  指令对象，必须有报量方式
	 * @returns 返回指令对象，回填投标金额和投标利率
	 */
	function getReportBidInfo(reportDataS,applyInst){
		var vcInvestBalance=0;//最大报价的报量
		var vcInterestRate=0;//最大报价
		if(applyInst.cReportType==1){
			//累计式  ：取最大报量
			for(var i=0;i<reportDataS.length;i++){
				if(vcInvestBalance<=parseNumber(reportDataS[i].enReport)){
					vcInterestRate=parseNumber(reportDataS[i].enOffer);//报价
					vcInvestBalance=parseNumber(reportDataS[i].enReport);//报量
				}
			}
		}else{
			//非累计式：累计所有报量，取最大报价
			for(var i=0;i<reportDataS.length;i++){
				if(vcInterestRate<=parseNumber(reportDataS[i].enOffer)){
					vcInterestRate=parseNumber(reportDataS[i].enOffer);//报价
				}
				vcInvestBalance+=parseNumber(reportDataS[i].enReport);//报量
			}
		}
	
		applyInst.enInvestBalance=parseNumber(vcInvestBalance);//回填投标金额
		applyInst.enInterestRate=parseNumber(vcInterestRate);//回填投标利率
		//return {enInvestBalance:parseNumber(vcInvestBalance),enInterestRate:parseNumber(vcInterestRate)};
		return applyInst;
	} 
	function parseNumber(number){
		if(number==null || number=="" || number==undefined || number=="undefined"){
			return 0;
		}
		return parseFloat(number);
	}
	/**
	 * 计算投标信息（金额和利率）
	 * applyInst 指令信息应包含：报量方式、缴款面值、票面利率
	 * applyInstReport 报量集合
	 * 返回回填后的指令信息 回填字段 投标信息（金额和利率）
	 */
	function getBiddingInfo(applyInst,applyInstReport){
		var vcInvestBalance=0;//最大报价的报量
		var vcInterestRate=0;//最大报价
 		var enCouponRate = parseNumber(applyInst.enCouponRate);			//票面利率
		if(applyInst.cReportType==1){
			//累计式  获取 查找到  票面利率（等于小于）最接近的报价，获取到报量
			for(var i=0;i<applyInstReport.length;i++){
				if(parseNumber(applyInstReport[i].enOffer)<=enCouponRate && parseNumber(applyInstReport[i].enOffer)>vcInterestRate){
					vcInterestRate=parseNumber(applyInstReport[i].enOffer);
				   	vcInvestBalance=parseNumber(applyInstReport[i].enReport);
				}
			}
			
		}else{
		    //非累计式 获取查找到比票面利率等于小于的报价，汇总报量之和 
			for(var j=0;j<applyInstReport.length;j++){
				//小于票面利率
				if(parseNumber(applyInstReport[j].enOffer)<=enCouponRate){
					//取最大值
					if(vcInterestRate<parseNumber(applyInstReport[j].enOffer)){
						vcInterestRate=parseNumber(applyInstReport[j].enOffer);
					}
					//累加满足条件之和
					vcInvestBalance+=parseNumber(applyInstReport[j].enReport);
				}

			}
		}
		applyInst.enInvestBalance= parseNumber(vcInvestBalance);//回填投标金额
		applyInst.enInterestRate=parseNumber(vcInterestRate);//回填投标利率
		return applyInst;
	}
	/**
	 * 校验缴款流程报量的合法信息
	 * applyInst 必须包含四个参数 投标金额、投标利率；票面面值，票面利率。
	 * */
	function checkPaymentReport(applyInst){
		if(applyInst.cReportType==null || applyInst.cReportType==""){
			nui.alert("有报量时，需要填写报量方式！");
			return false;
		}
		//报量金额必须大于等于缴款面值,报价小于等于票面利率 
		if(applyInst.enInterestRate>applyInst.enCouponRate){
			nui.alert("投标利率不能大于票面利率~");
			return false;
		}
		if(applyInst.enInvestBalance<applyInst.enPayFaceValue){
			nui.alert("投标金额不能小于票面面值~");
			return false;
		}
		return true;
	}
	/**
	 * 导入新债临时表
	 * */
    function exportTempUtil(lStockIssueId){
    	var nodes=[];
    	nodes.push({id:lStockIssueId,source:'1'});
    	var json = nui.encode({nodes:nodes});
    	nui.ajax({
            url: "com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.exportTemp.biz.ext",
            type: "post",
            contentType:'text/json',
            data: json ,
            success: function (text) {
              var returnJson = nui.decode(text);
              if (returnJson.exception == null) {
                 nui.alert("新债推送结果  ：成功", "", function(){});
              }
              else {
              	 nui.alert("新债推送结果：失败", "", function(){});
              }
            }
        });
    }
    /**
     * 校验风控空数据
     */
    function checkRiskRet(riskMsg){
    	if(riskMsg.resultDetail==null || riskMsg.resultDetail=="" || riskMsg.rcGroup==0){
    		if( riskMsg.uncontrolDetail==null || riskMsg.uncontrolDetail==""){
    			nui.alert("风控中心反馈消息为空。","系统提示");
    			return false;
    		}
    	}
    	return true;
    }
    /**
     * 风控试算
     */
    function RiskTrial(json,form){
    	//提交
		nui.ajax({
		    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.windControlTrial.biz.ext",
		    type: "post",
		    data: json,
		    dataType:"json",
		    success: function (text) {
		    	var returnJson = nui.decode(text);
		    	form.unmask();//取消遮罩
		    	if(returnJson.returnCode == 4){
	    			nui.alert(returnJson.rtnMsg,"系统提示");
	    			return;
	    		}else if(returnJson.returnCode == 0){
	    			if(returnJson.ishave==false){
		    			nui.alert("O32没有该债券，只能调用本地风控！","系统提示",function (){
		    				nui.alert("风控试算成功,未触发风控。","系统提示");
		    			});
	    			}else{
	    				nui.alert("风控试算成功,未触发风控。","系统提示");
	    			}
		    	 	return;
		    	}else if (returnJson.returnCode == -1){
		    			nui.alert(returnJson.rtnMsg,"系统提示");
		    			return;
		    	}else if(returnJson.returnCode != 0){
		    		if(checkRiskRet(returnJson.riskMsg)==false){
		    			return;
		    		}
		    		//判断债券是否存在o32
		    		if(returnJson.ishave==false){
		    			nui.alert("O32没有该债券，只能调用本地风控！","系统提示",function (){
		    			
		    				nui.open({
			    	  			url: contextPath+"/fix/riskApiControlDetailList.jsp",
			                    title: "风控试算反馈消息展示", width: 800, height: 390,
			                    onload: function () {
			                        //弹出页面加载完成
				                    var iframe = this.getIFrameEl();
				                    iframe.contentWindow.SetData(returnJson.riskMsg,3);
			                    },
			                    ondestroy: function (action) {//弹出页面关闭前
				                 
			                	}
			    	  		});
		    			});
	    	  			
		    		}else{
		    			nui.open({
		    	  			url: contextPath+"/fix/riskApiControlDetailList.jsp",
		                    title: "风控试算反馈消息展示", width: 800, height: 390,
		                    onload: function () {
		                        //弹出页面加载完成
			                    var iframe = this.getIFrameEl();
			                    iframe.contentWindow.SetData(returnJson.riskMsg,3);
		                    },
		                    ondestroy: function (action) {//弹出页面关闭前
			                 
		                	}
		    	  		});
		    		}
		    		
		    	}
		    }
		});
    }
    
    
	