<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2017-01-11 15:05:45
  - Description:
-->
<head>
<title>预置指令/建议交易确认提示</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="<%= request.getContextPath() %>/JQMHistory/common/common.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
	<style type="text/css">
    	.mini-buttonedit-border{
    		padding-right:1px;
    	}
    </style>
</head>
<body>
	<div id="datagrid_pending_instructs" dataField="presetInstructs" 
         url="com.cjhxfund.ats.sm.comm.InstructionManager.getPendingPresetInstruction.biz.ext"
         class="nui-datagrid" style="width:100%;height:100%;"
	     allowSortColumn="false"
	     onload="afterLoad"
	     allowResizeColumn="true"
	     enableHotTrack="false"
	     onshowrowdetail="onShowRowDetail">
		<div property="columns">
			<div type="expandcolumn" >#</div>
			<div name="action" width="120px" headerAlign="center" align="left">操作</div>
			<div field="lResultNo" headerAlign="center" width="80px">
               指令/建议序号
            </div>
            <div field="vcProductName" headerAlign="center" width="120px">
               产品名称
            </div>
            <div field="vcCombiName" headerAlign="center" width="110px">
               组合名称
            </div>
            <div field="vcSettleSpeed" headerAlign="center" width="80px">
                清算速度
            </div>
            <div field="vcBizType" headerAlign="center" width="100px">
                业务类型
            </div>
            <div field="vcEntrustDirection" headerAlign="center" width="85px">
                委托方向
            </div>
            <div field="vcStockCode" headerAlign="center" width="85px">
                债券代码
            </div>
            <div field="vcStockName" headerAlign="center" width="120px">
                债券名称
            </div>
		</div>
	</div>
	<div id="detail" style="display:none;"> 
        <div id="instructDetail" class="nui-tabs" style="width:100%;" activeIndex="0">
            <div title="基本信息" name="baseInfo">
            	<div id="baseDetail" style="padding:0px 10px 2px 0px"> 
	                <table style="width:100%;">
	                    <tr>
	                        <td style="width:110px;" align="right">产品名称：</td>
	                        <td style="width:180px;"><input name="vcProductName" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td style="width:100px;" align="right">组合名称：</td>
	                        <td style="width:180px;" ><input name="vcCombiName" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td style="width:100px;" align="right">清算速度：</td>
	                        <td style="width:180px;"><input name="vcSettleSpeed" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="settleSpeed" width="100%" enabled="false"/></td>
	                    </tr>
	                    <tr>
	                    	<td align="right">委托方向：</td>
	                        <td><input name="vcEntrustDirection" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="entrustDirection" width="100%" enabled="false"/></td>
	                    	<td align="right">债券代码：</td>
	                        <td style="width:180px;"><input name="vcStockCode" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td align="right">债券名称：</td>
	                        <td><input name="vcStockName" class="nui-textbox" width="100%" enabled="false"/></td>
	                    </tr>
	                	<tr>
	                		<td align="right">券面金额(万元)：</td>
	                        <td><input name="enFaceAmount" class="nui-spinner" value="enFaceAmount" minValue="0" maxValue="10000000000000" format="n2" width="100%" enabled="false"/></td>
	                		<td align="right">债券评级：</td>
	                        <td><input name="vcBondAppraise" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="creditRating" width="100%" enabled="false"/></td>
	                        <td align="right">主体评级：</td>
	                        <td><input name="vcIssueAppraise" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="issuerRating" width="100%" enabled="false"/></td>
	                    </tr>
	                    <tr>
	                    	<td align="right">行权收益率(%)：</td>
	                        <td><input name="enOptionYield" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td align="right">指令/建议净价：</td>
	                        <td><input name="enNetPrice" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td align="right">指令/建议全价：</td>
	                        <td><input name="enFullPrice" class="nui-textbox" width="100%" enabled="false"/></td>
	                    </tr>
	                    <tr>
	                       <td align="right">到期收益率(%)：</td>
	                        <td><input name="enMaturityYield" class="nui-textbox" width="100%" enabled="false"/></td>	
	                        <td align="right">交易日：</td>
	                        <td><input name="lTradeDate" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td align="right">结算日：</td>
	                        <td><input name="lFirstSettleDate" class="nui-textbox" width="100%" enabled="false"/></td>
	                    </tr>
	                    <tr>
	                    	<td align="right">交易对手：</td>
	                        <td><input name="vcCounterpartyName" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td align="right">对手主体机构：</td>
	                        <td><input name="vcCounterpartyOrgan" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td align="right">录入时间：</td>
	                        <td><input name="initiatorInfo" class="nui-textbox" width="100%" enabled="false"/></td>
	                    </tr>
	                    <tr>
	                    	<td align="right">投顾确认时间：</td>
	                        <td><input name="vcAdviserConfirm" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td align="right">委托人确认时间：</td>
	                        <td><input name="vcEntrustConfirm" class="nui-textbox" width="100%" enabled="false"/></td>
                    		<td align="right" id="yhjTraderHeader">对方交易员：</td>
                        	<td id="yhjTrader"><input name="vcCounterpartyTrader" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td align="right" id="jysAgreemtCodeHeader">约定号：</td>
	                        <td id="jysAgreemtCode"><input name="vcAgreemtCode" class="nui-textbox" width="100%" enabled="false"/></td>
	                    </tr>
	                    <tr>
	                    	<td align="right" id="jysRivalSeatHeader">对手席位：</td>
	                        <td id="jysRivalSeat"><input name="vcRivalSeat" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td align="right">备注：</td>
	                        <td><input name="vcRemark" class="nui-textbox" width="100%" enabled="false"/></td>
	                    </tr>
	                </table>
                </div>
            </div>
            <div title="基本信息" name="hgBaseInfo" >
            	<div id="hgBaseDetail" style="padding:0px 10px 2px 0px">
	                <table style="width:100%;">
	                    <tr>
	                        <td style="width:110px;" align="right">产品名称：</td>
	                        <td style="width:180px;"><input name="vcProductName" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td style="width:100px;" align="right">组合名称：</td>
	                        <td style="width:180px;"><input name="vcCombiName" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td style="width:100px;" align="right">清算速度：</td>
	                        <td style="width:180px;"><input name="vcSettleSpeed" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="settleSpeed" width="100%" enabled="false"/></td>
	                    </tr>
	                    <tr>
	                    	<td align="right">委托方向：</td>
	                        <td style="width:180px;"><input name="vcEntrustDirection" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="entrustDirection" width="100%" enabled="false"/></td>
	                    	<td align="right">回购天数：</td>
	                        <td><input name="lRepoDays" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td align="right">占款天数：</td>
	                        <td><input name="lContractPeriods" class="nui-textbox" width="100%" enabled="false"/></td>
	                    </tr>
	                    <tr>
	                    	<td align="right" id="enAmountText">首次结算金额(元)：</td><!-- 回购金额(万元)： -->
	                        <td><input id="enAmountValue" name="enAmount" class="nui-spinner" value="enAmount" minValue="0" maxValue="10000000000000" format="n2" width="100%" enabled="false"/></td>
	                       	<td align="right">报价方式：</td>
	                        <td><input name="vcQuoteMode" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="quoteMode" width="100%" enabled="false"/></td>
	                        <td align="right" id="quoteModeValue">回购利率(%)：</td>
	                        <td><input name="enRepoRateOrEnWeightingValue" class="nui-textbox" width="100%" enabled="false"/></td>
	                    </tr>
	                    <tr>
	                    	<td align="right">交易日：</td>
	                        <td><input name="lTradeDate" class="nui-textbox" width="100%" enabled="false"/></td>
	                    	<td align="right">首次结算日：</td>
	                        <td><input name="lFirstSettleDate" class="nui-textbox" width="100%" enabled="false"/></td>
	                    	<td align="right">到期结算日：</td>
	                        <td><input name="lMaturitySettleDate" class="nui-textbox" width="100%" enabled="false"/></td>
	                    </tr>
	                    <tr>
	                        <td align="right">到期结算金额(元)：</td>
	                        <td><input name="enSettleAmount" class="nui-textbox"  width="100%" enabled="false"/></td>
	                        <td align="right">回购利息(元)：</td>
	                        <td><input name="enRepoInterest" class="nui-textbox"  width="100%" enabled="false"/></td>
	                        <td align="right">交易对手：</td>
	                        <td><input name="vcCounterpartyName" class="nui-textbox" width="100%" enabled="false"/></td>
	                    </tr>
	                    <tr>
	                        <td align="right">对方交易员：</td>
	                        <td><input name="vcCounterpartyTrader" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td align="right">对手主体机构：</td>
	                        <td><input name="vcCounterpartyOrgan" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td align="right">录入时间：</td>
	                        <td><input name="initiatorInfo" class="nui-textbox" width="100%" enabled="false"/></td>
	                    </tr>
	                    <tr>
	                    	<td align="right">投顾确认时间：</td>
	                        <td><input name="vcAdviserConfirm" class="nui-textbox" width="100%" enabled="false"/></td>
	                        <td align="right">委托人确认时间：</td>
	                        <td><input name="vcEntrustConfirm" class="nui-textbox" width="100%" enabled="false"/></td>
	                    	<!-- <td align="right">发起时间：</td>
	                        <td><input name="tInitiateTime" class="nui-datepicker" format="yyyy-MM-dd H:mm:ss" timeFormat="H:mm:ss" width="100%" enabled="false"/></td> -->
	                    	<td align="right">备注：</td>
	                        <td><input name="vcRemark" class="nui-textbox" width="100%" enabled="false"/></td>
	                    </tr>
	                </table>
	        	</div>
            </div>
            
            <div title="质押券" name="mortgage" visible="false">
				<div id="datagrid_mortgage_info" dataField="mortgageInfos" 
			         url="com.cjhxfund.ats.sm.comm.InstructionManager.getMortgageInfos.biz.ext"
			         class="nui-datagrid" style="width:99%;height:100px;"
			         virtualScroll="true"
				     showPager="false">
					<div property="columns">
						<div field="vcProductName" headerAlign="center" width="100px">
			                产品名称
			            </div>
			            <div field="vcCombiName" headerAlign="center" width="100px">
			                组合名称
			            </div>
			            <div field="vcStockCode" headerAlign="center" width="100px">
			                债券代码
			            </div>
			            <div field="vcStockName" headerAlign="center" width="115px">
			               债券名称
			            </div>
			            <div field="vcExchange" headerAlign="center" width="80px" renderer="renderMarket">
			               交易市场
			            </div>
			            <div name="enNetPriceInit" field="enNetPriceInit" visible="false"  width="100px" align="right" headerAlign="center" align="center">
			            首次净价
			            </div>
			            <div name="enFullPriceInit" field="enFullPriceInit" visible="false"  width="100px" headerAlign="center" align="center" >
			            首次全价
			            </div>
						<div name="enNetPriceFinal" field="enNetPriceFinal" visible="false" width="100px" align="right" headerAlign="center" align="center">
				到期净价
						</div>
						<div name="enFullPriceFinal" field="enFullPriceFinal" visible="false"  width="100px" headerAlign="center" align="center" >
				到期全价
						</div>
			            <div field="enCbValueNetValue" headerAlign="center" align="right" width="80px">
			               净价（T-1）
			            </div>
			            <div field="enCbValueAllValue" headerAlign="center" align="right" width="80px">
			               全价（T-1）
			            </div>
			            <div field="enFaceAmount" value="enFaceAmount" numberFormat="n2" headerAlign="center" align="right" width="100px" value="enFaceAmount" class="nui-spinner" minValue="0" maxValue="10000000000000" format="n2">
			                券面金额（万元）
  			            </div>
			            <div name="enMortagageRatio"  field="enMortagageRatio" headerAlign="center" align="right" width="95px">
			               折算比例（％）
			            </div>
			            <div field="vcDepository" width="100px" headerAlign="center" align="center" renderer="depository">
			            托管机构
			            </div>
					</div>
				</div>
            </div>
        </div>
    </div>
	<script type="text/javascript">
    	nui.parse();
    	$("#instructDetail .mini-buttonedit-button").remove();
    	var pendingInstruct = nui.get("datagrid_pending_instructs");
    	var detail = document.getElementById("detail");
    	var mortgage_info = nui.get("datagrid_mortgage_info");
    	var tabDetailRole = nui.get("instructDetail");//获取详情标签列表
    	var form = new nui.Form("baseDetail");
     	var hgFrom = new nui.Form("hgBaseDetail");
     	
    	pendingInstruct.load();
    	pendingInstruct.on("drawcell", function (e) {
	        var record = e.record,
	        	field = e.field,
	        	value = e.value,
	    	 	column = e.column;
	    	if(field=="vcBizType"){
	    		if(record.vcEntrustDirection=="3" || record.vcEntrustDirection=="4"){
	    			e.cellHtml = nui.getDictText("bizTypeTransaction",e.value);
	    		}else{
	    			e.cellHtml = nui.getDictText("bizTypeRepurchase",e.value);
	    		}
	    	}
	    	if(field=="vcSettleSpeed"){
	    		e.cellHtml = nui.getDictText("settleSpeed",e.value);
	    	}
	    	if(field=="vcEntrustDirection"){
	    		e.cellHtml = nui.getDictText("entrustDirection",e.value);
	    	}
	    	
	    	if(field=="lTradeDate"){
	    		e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
	    	}
	        //action列，超连接操作按钮
	        if (column.name == "action") {
	            e.cellStyle = "text-align:center";
	            e.cellHtml = '<a style="color:#00CCFF" onclick="confirm(\'' + pendingInstruct.indexOf(record) + '\')">确认下达</a>&nbsp;&nbsp;'+
	            			 '<a style="color:#00CCFF" onclick="edit(\'' + pendingInstruct.indexOf(record) + '\')">修改</a>&nbsp;&nbsp;'+
	            			 '<a style="color:#00CCFF" onclick="cancel(\'' + pendingInstruct.indexOf(record) + '\')">撤销</a>';
	        }
	    });
		function afterLoad(){
			if(pendingInstruct.getTotalCount()==0){
				CloseOwnerWindow();
			}
		}
	    //确认下达指令/建议
	    function confirm(rowIndex){
	    	var record = pendingInstruct.getRow(parseInt(rowIndex));
	    	nui.confirm("您是否确认要进行该交易？", "交易确认提示", function(action){
	    		if (action == "ok") {
	    			var tooltip = nui.loading("正在处理中,请稍等...","提示");
	    			nui.ajax({
						url : "com.cjhxfund.ats.sm.comm.TaskManager.confirmPendingPresetInstruction.biz.ext",
						type : 'POST',
						data : {processInstID:record.lProcessinstId},
						cache : false,
						contentType : 'text/json',
						success : function(text) {
							nui.hideMessageBox(tooltip);
							var returnJson = nui.decode(text);
							if(returnJson.exception == null){
								if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
									nui.alert("指令/建议确认成功","提示", function(){
										pendingInstruct.load();
									});
									
								}else{
									nui.alert(returnJson.rtnMsg,"系统提示",function(){
										pendingInstruct.load();
									});
								}
							}else{
								nui.alert("系统异常","系统提示");
								pendingInstruct.load();
							}
						}
					});
	    		}
	    	});
	    }
	    
	    function edit(rowIndex){
	    	var record = pendingInstruct.getRow(parseInt(rowIndex));
	    	record["lInstructNo"] = record["lResultNo"];
	    	var openWidth = "1070";
	    	var openHeight = "470";
	    	var url = nui.context+"/transaction/invest/interbank_trade/instructIssue.jsp";//银行间债券买卖
	    	if(record.vcBizType=="2" || record.vcBizType == "3"){//上海大宗交易、上海固收平台
	    		url = nui.context+"/transaction/invest/sh_block_trade/instructIssue.jsp";
	    	}else if(record.vcBizType=="4"){//深圳综合协议平台
	    		url = nui.context+"/transaction/invest/sz_integrated_prot/instructIssue.jsp";
	    	}else if(record.vcBizType=="5"){//银行间质押式回购
	    		openWidth = "100%";
	    		openHeight = "100%";
    			url = nui.context+"/repurchase/invest/collateralised_repo/tBondTrade.jsp";
    		}else if(record.vcBizType=="6"){//银行间买断式回购
    			openWidth = "100%";
	    		openHeight = "100%";
    			url = nui.context+"/repurchase/invest/buyout_repo/tBondTrade.jsp";
    		}else if(record.vcBizType=="7"){//交易所协议式回购首期
    			openWidth = "100%";
	    		openHeight = "100%";
    			url = nui.context+"/repurchase/invest/protocol_repo/initialInstruct.jsp";
    			if(record.vcEntrustDirection=="17" || record.vcEntrustDirection=="18"){//交易所协议式回购到期
	    			
		    	}else if(record.vcEntrustDirection=="26" || record.vcEntrustDirection=="27"){//交易所协议式回购换券
		    		
		    	}else if(record.vcEntrustDirection=="30" || record.vcEntrustDirection=="31"){//交易所协议式续作
		    		
		    	}
    		}
	    	nui.open({
    			url: url,
    			title: "修改建议", width: openWidth, height: openHeight,
    			onload: function(){
			        var iframe = this.getIFrameEl();
			        record["operatorType"] = "1"; //0-新建指令/建议 1-编辑指令/建议
			        iframe.contentWindow.SetData(record);
    			},
    			ondestroy: function (action) {
    				pendingInstruct.load();
    			}
			});
	    }
	    
	    //撤销指令/建议
	    function cancel(rowIndex){
	    	var record = pendingInstruct.getRow(parseInt(rowIndex));
	    	record["lInstructNo"] = record["lResultNo"];
	    	nui.confirm("您是否确认要撤销改指令/建议？", "指令/建议撤销提示", function(action){	
	    		if (action == "ok") {
	    			var tooltip = nui.loading("正在处理中,请稍等...","提示");
	    			nui.ajax({
						url : "com.cjhxfund.ats.sm.comm.InstructionManager.instructRevocation.biz.ext",
						type : 'POST',
						data : {instructParameter:record},
						cache : false,
						contentType : 'text/json',
						success : function(text) {
							nui.hideMessageBox(tooltip);
							var returnJson = nui.decode(text);
							if(returnJson.exception == null){
								if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
									nui.alert("指令/建议撤销成功","提示", function(){
										pendingInstruct.load();
									});
								}else{
									nui.alert(returnJson.rtnMsg,"提示",function(){
										pendingInstruct.load();
									});
								}
							}else{
								nui.alert("系统异常","系统提示",function(){
									pendingInstruct.load();
								});
							}
						}
					});
	    		}
			});
	    }
	    
	    
	    function onShowRowDetail(e) {
            var row = nui.clone(e.record);
            //将editForm元素，加入行详细单元格内
            var td = pendingInstruct.getRowDetailCellEl(e.record);
            td.appendChild(detail);
            detail.style.display = "";
            if(row.lTradeDate != null){
				row["lTradeDate"] = nui.formatDate(DateUtil.numStrToDate(row["lTradeDate"].toString()),"yyyy-MM-dd");
			}
			if(row.lFirstSettleDate != null){
				row["lFirstSettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lFirstSettleDate"].toString()),"yyyy-MM-dd");
			}
			if(row.lMaturitySettleDate != null){
				row["lMaturitySettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lMaturitySettleDate"].toString()),"yyyy-MM-dd");
			}
			if(row.vcInitiatorName != null){
				row["initiatorInfo"] = row.vcInitiatorName +" "+ nui.formatDate(row.tInitiateTime, "yyyy-MM-dd HH:mm:ss");
			}
			if(row.lTradeQty == null){
				row["lTradeQty"] = 0;
			}
            if(row.vcEntrustDirection=="3" || row.vcEntrustDirection=="4"){
            	if(row.vcBizType=="1"){//银行间显示：对手交易员  不显示：对手席位、约定号
            		document.getElementById("yhjTraderHeader").style.display="";
					document.getElementById("yhjTrader").style.display="";
					document.getElementById("jysRivalSeatHeader").style.display="none";
					document.getElementById("jysRivalSeat").style.display="none";
					document.getElementById("jysAgreemtCodeHeader").style.display="none";
					document.getElementById("jysAgreemtCode").style.display="none";
            	}else{
            		document.getElementById("yhjTraderHeader").style.display="none";
					document.getElementById("yhjTrader").style.display="none";
					if(row.vcBizType=="4"){//上交所不显示：对手席位
						document.getElementById("jysRivalSeatHeader").style.display="";
						document.getElementById("jysRivalSeat").style.display="";
					}else{
						document.getElementById("jysRivalSeatHeader").style.display="none";
						document.getElementById("jysRivalSeat").style.display="none";
					}
					document.getElementById("jysAgreemtCodeHeader").style.display="";
					document.getElementById("jysAgreemtCode").style.display="";
            	}
            	tabDetailRole.updateTab("baseInfo",{visible:true});
            	tabDetailRole.updateTab("hgBaseInfo",{visible:false});
            	tabDetailRole.updateTab("mortgage",{visible:false});
            	tabDetailRole.activeTab(tabDetailRole.getTab("baseInfo"));
    			form.setData(row);
            }else{
            	tabDetailRole.updateTab("baseInfo",{visible:false});
            	tabDetailRole.updateTab("hgBaseInfo",{visible:true});
            	tabDetailRole.updateTab("mortgage",{visible:true});
            	tabDetailRole.activeTab(tabDetailRole.getTab("hgBaseInfo"));
            	row["enSettleAmount"] = formatNumber(row.enSettleAmount,2,1);//添加千分位
            	if(row.vcBizType=="6"){//银行间买断式     首次结算金额(元)：</td><!-- 回购金额(万元)： -->
            		document.getElementById("enAmountText").innerHTML = "首次结算金额(元)：";
            		document.getElementById("quoteModeValue").innerHTML = "回购利率(%)：";
            		row["vcQuoteMode"] = "1";
					row["enRepoRateOrEnWeightingValue"] = row.enRepoRate;
					row["enAmount"] = row.enFullPriceAmount;
            		mortgage_info.hideColumn("enMortagageRatio");
            		mortgage_info.showColumn("enNetPriceInit");
            		mortgage_info.showColumn("enFullPriceInit");
    				mortgage_info.showColumn("enNetPriceFinal");
    				mortgage_info.showColumn("enFullPriceFinal");
            	}else{//质押式
            		document.getElementById("enAmountText").innerHTML = "回购金额(万元)：";
            		if(row.vcQuoteMode=="2"){
            			document.getElementById("quoteModeValue").innerHTML = "加权加点值：";
            			row["enRepoRateOrEnWeightingValue"] = row.enWeightingValue;
            		}else{
            			document.getElementById("quoteModeValue").innerHTML = "回购利率(%)：";
            			row["enRepoRateOrEnWeightingValue"] = row.enRepoRate;
            		}
            		row["enAmount"] = row.enFaceAmount;
            		mortgage_info.showColumn("enMortagageRatio");
            		mortgage_info.hideColumn("enNetPriceInit");
            		mortgage_info.hideColumn("enFullPriceInit");
    				mortgage_info.hideColumn("enNetPriceFinal");
    				mortgage_info.hideColumn("enFullPriceFinal");
            	}
            	hgFrom.setData(row);
            	var json = {lInquiryId:row.lInquiryId,lResultId:row.lResultId};
            	mortgage_info.load(json);
            }
        }
        //交易市场列字典翻译
	    function renderMarket(e){
	    	return nui.getDictText("tradePlace",e.row.vcExchange);
	    }
	    function depository(e){
			return nui.getDictText("CF_JY_DJTGCS",e.row.vcDepository);
		}
    </script>
</body>
</html>