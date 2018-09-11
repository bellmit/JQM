<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<%@ taglib uri="https://www.cjhxfund.com/main/index"  prefix="privilege" %>
<!-- 
  - Author(s): 创金合信
  - Date: 2016-09-08 15:57:08
  - Description:chendi
-->
<head>
<title>资金交收跟踪管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/css/instruct.css"/>
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script>
</head>
<body style="height:100%; width:100%; overflow:hidden; margin:0;padding:0;">
	<div class="search-condition">
		<div id="form_bond_quate_condition" class="nui-form" align="center">
	   		<div class="list">
	   			<input id ="queryType" name="condition/queryType" class="nui-hidden" value="yhj"/>
	   			<div id="" class="nui-form" align="center">
	   				<table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
	                	<tr>
	                        <td style="width:60px" align="right">产品名称:</td>
			                <td style="width:17%" align="left">
			                	<input id="fundCodeName" class="nui-buttonedit" name="fundCodeName" emptyText="全部" showClose="true" oncloseclick="onCloseClick" onbuttonclick="ButtonClickGetFundName_fundSetmt" style="width:100%"/>
		                     </td>
	                        <td style="width:60px" align="right">业务类别:</td>
			                <td style="width:17%" align="left">
								<div name="condition/bizType" class="nui-dictcombobox" id="vcBizType" 
									valueField="dictID" 
									textField="dictName" 
									data="[{'dictID':'1','dictName':'银行间现券买卖'},{'dictID':'5','dictName':'银行间质押式回购'},{'dictID':'6','dictName':'银行间买断式回购'}]"
									multiSelect="true"
		                            allowInput="false" 
		                            showNullItem="true" 
		                            emptyText="全部..." 
		                            nullItemText="请选择..." 
		                            showClose="true" 
		                            oncloseclick="onCloseClick"
		                            style="width:100%"
									popupWidth="200px">
		                        </div>
		                    </td>
		                    <td style="width:60px" align="right">委托方向:</td>
			                <td style="width:17%" align="left">
								<div name="condition/cEntrustDirection" class="nui-dictcombobox" id="cEntrustDirection" 
									valueField="dictID" 
									textField="dictName" 
									dictTypeId="entrustDirection"
									multiSelect="true"
		                            allowInput="false" 
		                            showNullItem="true" 
		                            emptyText="全部..." 
		                            nullItemText="请选择..." 
		                            showClose="true" 
		                            oncloseclick="onCloseClick"
		                            style="width:100%"
		                            popupWidth="200px">
	                            </div>
	                        </td>
							<td style="width:60px" align="right">交收日期:</td>
			                <td style="width:17%" align="left">
								<input id="deliveryData1" style="width:100%" class="nui-datepicker" allowInput="false" name="condition/setmtDate" valueType="String" showClose="true" oncloseclick="onCloseClick"/>
							</td>
							<td align="center" style="width:20px">至</td>
							<td style="width:17%" align="left">	
								<input id="deliveryData2" style="width:100%" class="nui-datepicker" allowInput="false" name="condition/setmtDate" valueType="String" showClose="true" oncloseclick="onCloseClick"/>
								<input id="lDealDate" class="nui-hidden" name="condition/setmtDate"/>
								<input id="lDealDate1" class="nui-hidden" name="condition/setmtDate1"/>
							</td>
							<td  style="width:7.5%" align="right">	
	                         	<a class="nui-button" plain="false" style="width:60px" iconCls="icon-search" onclick="inquiry()">查询</a>
		                    </td>
		                    <td  style="width:7.5%" align="left">    
		                        <a class="nui-button" plain="false" style="width:60px" iconCls="icon-reset" onclick="reset()">重置</a>
		                    </td>
	                  	</tr>
	                  	<tr>
							<td style="width:60px" align="right">交易市场:</td>
			                <td style="width:17%" align="left">
								<div name="condition/market" class="nui-dictcombobox" id="vcMarket" 
									valueField="dictID" 
									textField="dictName" 
									data="[{'dictID':'5','dictName':'银行间'},{'dictID':'6','dictName':'场外'}]"
									multiSelect="true"
		                            allowInput="false" 
		                            showNullItem="true" 
		                            emptyText="全部..." 
		                            nullItemText="请选择..." 
		                            showClose="true" 
		                            style="width:100%"
		                            oncloseclick="onCloseClick">
	                            </div>
	                        </td>
	                        <td style="width:60px" align="right">托管机构:</td>
			                <td style="width:17%" align="left">
								<div name="condition/vcDepository" class="nui-dictcombobox" id="vcDepository" 
									valueField="dictID" 
									textField="dictName"
									data="[{'dictID':'01','dictName':'中央结算公司'},{'dictID':'02','dictName':'上海清算所'},{'dictID':'99','dictName':'其他'}]"
									multiSelect="true"
		                            allowInput="false" 
		                            showNullItem="true" 
                                    emptyText="全部"
		                            showClose="true" 
		                            oncloseclick="onCloseClick"
		                            style="width:100%"
		                            nullItemText="请选择...">
	                            </div>
	                        </td>
		                    <td style="width:60px" align="right">交收状态:</td>
			                <td style="width:17%" align="left">
	                        	<div name="condition/bsSetmtStatus"  id="deliveryStatus"  class="nui-dictcombobox"
	 								valueField="dictID" 
	 								textField="dictName" 
	 								dictTypeId="bsSetmtStatus"
	 								multiSelect="true"
	 								emptyText="全部..." 
	 								nullItemText="请选择..." 
	 								showClose="true" 
	 								oncloseclick="onCloseClick"
	 								style="width:100%"
	                                popupWidth="200px">
	                                <div property="columns">
								        <div header="状态名称" field="dictName"></div>
								    </div>
 								</div>
 							</td>
		                   	<td style="width:60px" align="right">交易日期:</td>
			                <td style="width:17%" align="left">
								<input id="businessData1" style="width:100%"  class="nui-datepicker" name=""  allowInput="false" format="yyyy-MM-dd" valueType="String" showClose="true" oncloseclick="onCloseClick"/>
							</td>
							<td align="center" style="width:20px">至</td>
							<td style="width:17%" align="left">	
								<input id="businessData2" style="width:100%" class="nui-datepicker" name=""  allowInput="false" format="yyyy-MM-dd" valueType="String" showClose="true" oncloseclick="onCloseClick"/>
								<input id="lSetmtDate" class="nui-hidden" name="condition/dealDate">
								<input id="lSetmtDate1" class="nui-hidden" name="condition/dealDate1">
							</td>
							<td  colspan="2" style="width:10%" align="center" scope="2">	
			   					<ul id="popupMenu" class="mini-menu" style="display:none;width:250px;"></ul>
								<a class="nui-menubutton" plain="false" menu="#popupMenu"
		                           id="searchCond"
		                           name="searchCond"
		                           style="width:130px;"
		                           data-options='{formId:"form_bond_quate_condition"}'
		                           iconCls="icon-add">保存查询条件</a>
							</td>
	                    </tr>
	                    <tr>
			   				<td align="left" colspan="8" style="color:red;">
		                                             此查询结果仅供参考，请以实际交收情况为准。
		                    </td>
		                 </tr>
					</table>
	   			</div>
	   		</div>
   		</div>
   	</div>
   	<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	    <table style="width:100%;">
	        <tr>
	            <td style="width:50%;">
	                <privilege:operation sourceId="ATS_JSJDCX_TJDJS" sid="ATS_JSJDCX_TJDJS" clazz="nui-button" onClick="addTranc()" lableName="添加待交收业务"  iconCls="icon-add" ></privilege:operation>&nbsp;
	            	<privilege:operation sourceId="ATS_JSJDCX_PPZL" sid="ATS_JSJDCX_PPZL" clazz="nui-button" onClick="matchInstruct()" lableName="匹配指令/建议置成交"  iconCls="icon-ok" ></privilege:operation>&nbsp;
	            	<privilege:operation sourceId="ATS_JSJDCX_SGZJS" sid="ATS_JSJDCX_SGZJS" clazz="nui-button" onClick="setmtManually()" lableName="手工置交收"  iconCls="icon-edit" ></privilege:operation>
	                <!-- <a class='nui-button' plain='false' iconCls="icon-download" onclick="seldir	">生成成交单</a> -->
	            </td>
	            <td style="width:50%;" align="right">
	            	<%-- 点击“刷新”按钮后重启自动刷新功能（若之前自动刷新功能设置为不自动刷新关闭时） --%>
	                <a class='nui-button' plain='false' iconCls="icon-reload" onclick="autoRefreshFun()">刷新</a>
	                <input id="autoRefresh" class="nui-combobox" style="width:90px;" 
	                    value="180" showNullItem="false" allowInput="false"
	                    data="[
					    { id: 0, text: '不自动刷新' },
					    { id: 15, text: '每15秒刷新' },
					    { id: 30, text: '每30秒刷新' },
						{ id: 60, text: '每1分刷新' },
						{ id: 120, text: '每2分刷新' },
						{ id: 180, text: '每3分刷新' },
						{ id: 300, text: '每5分刷新' },
						{ id: 600, text: '每10分刷新' },
						{ id: 1200, text: '每20分刷新' },
						{ id: 1800, text: '每30分刷新' }]"
					/>
					<%-- <a href="javascript:fullScreen()"><span id="fullScreen" 
					style="border-bottom:1px solid;font-size:13px;color: red;">全屏显示</span></a>
					&nbsp;&nbsp; --%>
	            </td>
	        </tr>
	    </table>
    </div>
	<div class="nui-fit" style="width:100%; height:100%;">
	    <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" dataField="returnData"
	         url="com.cjhxfund.ats.sm.comm.FundSetmtTraceManager.queryFundSetmtTrace.biz.ext"  
	         idField="id" 
	         allowResize="true"  
	         showPageInfo="true"
	         allowCellSelect="true"
	 		 enterNextCell="true"
	 		 enableHotTrack="true"
           	 allowHeaderWrap="true"
	         multiSelect="true"
	         editNextOnEnterKey="true"
	         sizeList="[20,30,50,100]" 
	         pageSize="20" 
	         pagerButtons="#prompt_todays">
	        <div property="columns">
	        	<div type="checkcolumn" ></div>     
	            <div type="indexcolumn" ></div>
	            <div field="traceId" visible="false"/>资金交收跟踪管理表序号</div>
	            <div field="setmtDate" width="80" headerAlign="center" align="left" allowSort="true" renderer="setmtDateStrToDate">交收日期</div>
	            <div field="bsSetmtStatus" width="150" allowSort="true" decimalPlaces="2"  headerAlign="center" align="left" renderer="renderBsSetmtStatus">后台交收状态</div>
	            <div field="productName" width="120" headerAlign="center"  align="left" allowSort="true">产品名称</div>
	            <div field="market" width="90" allowSort="true" headerAlign="center" align="left" renderer="renderVcMarket" >交易市场</div>
	            <div field="vcDepository" width="150" allowSort="true" headerAlign="center" align="left" renderer="renderVcDepository">登记托管机构</div>
	            <div field="bizType" width="150" allowSort="true" headerAlign="center" align="left" renderer="renderBizType">业务类别</div>
	            <div field="cEntrustDirection" width="90" allowSort="true" headerAlign="center" align="left" renderer="renderCEntrustDirection" >委托方向</div>
	            <div field="counterpartyName" width="150" allowSort="true" decimalPlaces="2" headerAlign="center" align="left">交易对手</div>
	            <div field="setmtAmount" width="100" allowSort="true" numberFormat="#,0.00" decimalPlaces="2" dataType="float" headerAlign="center" align="right">交收金额(元)</div>
	            <div field="dealAmount" visible="false" width="100" headerAlign="center" allowSort="true" numberFormat="#,0.00" align="right">成交金额(元)</div>
	            <div field="dealQuantity" width="80" headerAlign="center" align="left" allowSort="true" numberFormat="n0" >发生数量</div>
	            <div field="stockCode" width="80" headerAlign="center" align="right"  allowSort="true" decimalPlaces="2" >债券代码</div>
	            <div field="stockName" width="100" headerAlign="center" align="left" allowSort="true">债券名称</div>
	            <div field="assetName" width="120" 	renderer="onGenderRenderer" align="left" headerAlign="center">资产单元名称</div>
	            <div field="cBusinClass" visible="false" width="80" headerAlign="center" align="left" allowSort="true">资金交收业务类别</div>
	            <div field="dealDate" width="80" headerAlign="center" align="left" allowSort="true" renderer="dealDateStrToDate">成交日期</div>
	            <div field="vcDealNo" width="130" headerAlign="center"  align="right" allowSort="true">成交编号</div>
	            <div field="dataSource" width="90" headerAlign="center" align="left" allowSort="true">数据来源</div>
	            <div field="lResultNo" width="100" headerAlign="center"  align="right" allowSort="true">指令/建议序号</div>
	            <div field="remark" width="100" headerAlign="center" align="left" allowSort="true">备注</div>
	        </div>
	    </div>
	</div>

	<div id="prompt_todays">
	    <div class="flag" >
	    	 <span class="separator"></span>
	        <div class="closedata"></div>
	        <div style= "display:inline-block;">后台已成交 </div>
	    </div>
	</div>
	
	<script type="text/javascript">
		nui.parse();
	    var grid = nui.get("datagrid1");
	    $("#fullScreen").css('fontWeight','bold');
			
		//自动刷新功能处理
	    var autoRefreshReturnVal;//自动刷新定时器返回值（使用该值关闭之前的定时器）
	    var autoRefreshValOld;//历史自动刷新时间
	    function autoRefreshFun(){
	    	inquiry();//同时刷新查询列表数据
			
	    	var autoRefreshVal = nui.get("autoRefresh").getValue();//获取最新自动刷新时间
	    	//若最新获取的自动刷新时间与历史自动刷新时间不等，则关闭之前的定时器，以新的自动刷新时间新建定时器，并将新值赋予历史自动刷新时间变量
	    	if(autoRefreshVal!=autoRefreshValOld){
	    		autoRefreshValOld = autoRefreshVal;//将新值赋予历史自动刷新时间变量
	    		clearInterval(autoRefreshReturnVal);//关闭之前的定时器
	    		if(autoRefreshValOld!="0"){
	    			autoRefreshReturnVal = setInterval("autoRefreshFun()", eval(autoRefreshValOld)*1000);//以新的自动刷新时间新建定时器
	    		}
	    	}
	    }
	    autoRefreshReturnVal = self.setInterval("autoRefreshFun()",180000);//设置自动刷新时间默认3分钟
		
		//全屏显示
		function fullScreen(){
			window.open('<%=request.getContextPath()%>/sm/comm/trace/fundSetmtTraceManage.jsp','newwindow','height=900,width=1440,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		}
		
		//获取查询条件的产品名称
		function ButtonClickGetFundName_fundSetmt(e){
	        ButtonClickGetFundName(this);
		}
		
		//跨页多选选择表格获取产品
		function ButtonClickGetFundName(buttonEditObj){
	        nui.open({
	            url: "<%=request.getContextPath() %>/sm/comm/instruct/productInfoCombi.jsp",
	            title: "产品列表",
	            width: 450,
	            height: 380,
	            onload:function(){
	                var iframe = this.getIFrameEl();
	                var fundCodes = buttonEditObj.getValue();
	                var fundNames = buttonEditObj.getText();
	                var data = {
	                   fundCodes:fundCodes,
	                   fundNames:fundNames
	                };
	                iframe.contentWindow.SetData(data);
	            },
	            ondestroy: function (action) {
	                if (action == "ok") {
	                    var iframe = this.getIFrameEl();
	                    var data = iframe.contentWindow.GetData();
	                    data = nui.clone(data);
	                    buttonEditObj.setValue(data.vcProductCode);
	                    buttonEditObj.setText(data.vcProductName);
	                }
	            }
	        });
		}
		
		//添加业务
	    function addTranc(){
	    	
	      nui.open({
		        url: nui.context+"/sm/comm/trace/addBiz_yhj.jsp",
		        title: "添加业务", 
		        width: 1000, 
		        height: 200,
		        ondestroy: function (action) {
		        	if(action=="saveSuccess"){
		        		grid.reload();
		        	}
						}
		    });
	    }
	   	function setmtManually(){
	   		//记录是否所有数据都为当天的数据
	   		var count=0;
	   		//记录是否所有的数据都没有在(后台已成交、)
	   		var countBs = 0;
	   		//获取选择的数据
	   		var row = grid.getSelecteds();
	        if (row.length>0) {
	        	//存放产品代码的数组，主要用于判断是否所有选中的产品都有手工置交收的权限
	        	var paramArr = new Array();
	        	//交收日期为当天的话count++，并且将产品代码放到数组中(判断是否有手工置交收权限)
    			for (var i = 0; i < row.length; i++) {
    				if(row[i].setmtDate == DateUtil.toNumStr(new Date())){
    					paramArr[i] = row[i].productCode;
    					count++;
    				}
    				if(row[i].bsSetmtStatus == '09' || row[i].bsSetmtStatus == '11' || row[i].bsSetmtStatus == '13'){
    					countBs++;
    				}
	        	}
	        	//判断是否所有数据都是有效的手工置交收数据
	        	if(countBs>0){
	        		nui.alert("存在不允许手工置交收的数据，请检查！");
	        	}else{
	        		//判断是否全部数据的交收日期为当天
			        if(count == row.length){
			        	var json = nui.encode({data:paramArr});
				        //判断用户有没哟权限进行手工置交收
				        $.ajax({
				        	 url : "com.cjhxfund.ats.sm.comm.FundSetmtTraceManager.manualSetmtPermission.biz.ext",
				        	type : 'POST',
				        	data : json,
				        	contentType : 'text/json',
				        	success : function(data){
				        		//rntFlag:0比对成功，有权限进行手工置交收 1没有权限
			            		if(data.rtnFlag=="0"){
			            			nui.open({
									    url : nui.context+"/sm/comm/trace/manualSetmt.jsp",
										title : "后台交收状态",
										width : 520,
										height: 360,
										onload: function () {
											var rowSetmt = grid.getSelecteds();
											var iframe = this.getIFrameEl();
											iframe.contentWindow.setFormData(rowSetmt);
					        			},
										ondestroy: function (action) {
											if(action=="saveSuccess"){
													grid.reload();
												}
										}
									});
			            		}else{
			            			nui.alert("您好，您没有权限操作所选中数据，请重新选择！");
			            		}
		        			}
						});
					}else{
		      			nui.alert("只能选择交收日期为当天的数据！");
		      		}
	        	}
			}else{
				nui.alert("请选中一条数据","提示");
			}
		}
		
		function inquiry(){   
			/* 交收日期格式转换 */
			//var setmtDate2 = nui.get("deliveryData1").getValue().substring(0,10).split('-').join('');
			var setmtDate1 = "";
			var setmtDate = "";
			if(nui.get("deliveryData1").getValue()!=null&&nui.get("deliveryData1").getValue()!=""){
				setmtDate1 = DateUtil.toNumStr(nui.get("deliveryData1").getValue());
			}
			if(nui.get("deliveryData2").getValue()!=null&&nui.get("deliveryData2").getValue()!=""){
				setmtDate = DateUtil.toNumStr(nui.get("deliveryData2").getValue());
			}
			nui.get("lDealDate").setValue(setmtDate1);
			nui.get("lDealDate1").setValue(setmtDate);
			
			/* 交易日期格式转换 */
			var dealDate1 ="";
			var dealDate = "";
			
			if(nui.get("businessData1").getValue()!=null&&nui.get("businessData1").getValue()!=""){
				dealDate1 = DateUtil.toNumStr(nui.get("businessData1").getValue());
			}
			if(nui.get("businessData2").getValue()!=null&&nui.get("businessData2").getValue()!=""){
				dealDate = DateUtil.toNumStr(nui.get("businessData2").getValue());
			}
			nui.get("lSetmtDate").setValue(dealDate1);
			nui.get("lSetmtDate1").setValue(dealDate);
			
			var conditionForm = new nui.Form("#form_bond_quate_condition");
			var json = conditionForm.getData(false, false);
			var optimal_price_grid = nui.get("datagrid1");
			//下拉框多选处理
			json["condition/bizType"] = splitString(nui.get("vcBizType").getValue());
			json["condition/productCode"] = splitString(nui.get("fundCodeName").getValue());
			json["condition/market"] = splitString(nui.get("vcMarket").getValue());
			json["condition/bsSetmtStatus"] = splitString(nui.get("deliveryStatus").getValue());
			json["condition/vcDepository"] = splitString(nui.get("vcDepository").getValue());
			
			//查询类型赋值
			json["condition/queryType"] = "yhj";
			optimal_price_grid.load(json);
			
			//设置指令/建议列表数据显示颜色
			optimal_price_grid.on("drawcell", function (e) {
			 	var record = e.record;
			 	if(record.bsSetmtStatus=="09"||record.bsSetmtStatus=="11"){
			 		e.rowStyle='background-color:#CCCCCC;';
			 	}
			});
		}
		//重置
		function reset(){
			var form = new nui.Form("#form_bond_quate_condition");//将普通form转为nui的form
			form.reset();
		}
		//时间显示格式转换
		function dealDateStrToDate(e){
			if(e.value!=null){
				return nui.formatDate(DateUtil.numStrToDate(e.row.dealDate.toString()),'yyyy-MM-dd');
			}
		}
		function setmtDateStrToDate(e){
			if(e.value!=null){
				return nui.formatDate(DateUtil.numStrToDate(e.row.setmtDate.toString()),'yyyy-MM-dd');
			}
		}
		//将dealNo的值赋给vcDealNo
		function setDealNo(e){
			if(e.value!=null){
				e.record.vcDealNo = e.record.dealNo;
			}
		}
		//输入框默认显示
		window.onload=function(){
  			$("#vcBizType > span > input").attr("placeholder","全部...");
			$("#vcStockCode > span > input").attr("placeholder","请输入...");
			
			//进入页面默认查询交收日期为当天的数据
			var setmtDate = DateUtil.toNumStr(new Date());
			nui.get("deliveryData1").setValue(setmtDate);
			nui.get("deliveryData2").setValue(setmtDate);
			nui.get("lDealDate").setValue(setmtDate);
			nui.get("lDealDate1").setValue(setmtDate);
			
			var formData = new nui.Form("#form_bond_quate_condition").getData(false,false);
			grid.load(formData);
			
			//设置指令/建议列表数据显示颜色
			grid.on("drawcell", function (e) {
			 	var record = e.record;
			 	if(record.bsSetmtStatus=="09"||record.bsSetmtStatus=="11"){
			 		e.rowStyle='background-color:#CCCCCC;';
			 	}
			});
		}
		//业务类别字典
		function renderBizType(e){
			return nui.getDictText("bizTypeAll",e.row.bizType);
		}
		//委托方向字典
		function renderCEntrustDirection(e){
			return nui.getDictText("entrustDirection",e.row.cEntrustDirection);
		}
		//产品参数项字典
		function renderBsSetmtStatus(e){
			return nui.getDictText("bsSetmtStatus",e.row.bsSetmtStatus);
		}
		//交易市场字典项
		function renderVcMarket(e){
			return nui.getDictText("tradePlace",e.row.market);
		}
		//登记托管机构字典项
		function renderVcDepository(e){
			return nui.getDictText("CF_JY_DJTGCS",e.row.vcDepository);
		}
		//页面X的删除功能
		function onCloseClick(e) {
    	var obj = e.sender;
	    obj.setText("");
	    obj.setValue("");
		}
	//处理下拉框多选的情况：给多选字符加上单引号
	function splitString(data){
		var mulString = null;
		if(data != null && data != ""){
			var strs= data.split(",");
    		if(strs.length>0){
    			for(var i=0; i<strs.length; i++ ){ 
						if(i == 0){
							mulString = "'"+strs[i]+"'";
						}else{
							mulString += ",'"+strs[i]+"'";
						}
					} 
    		}
		}
		return mulString;
    }

     //匹配指令/建议要素
    function matchInstruct(){
    	var rows = grid.getSelecteds();
    	if(rows.length==1){
    		if(rows[0].setmtDate == DateUtil.toNumStr(new Date())){
    			if(!(rows[0].lResultNo == "" || rows[0].lResultNo == null)){
    				nui.alert("此指令/建议不能重复匹配！","系统提示");
    				return;
    			}
				nui.open({
				    url : nui.context+"/sm/comm/trace/matchInstruct.jsp",
					title : "手工指令/建议匹配",
					width : 400,
					height: 160,
					onload: function () {
						var iframe = this.getIFrameEl();
						iframe.contentWindow.setMatchData(rows[0]);
	        		},
					ondestroy: function (action) {
						grid.reload();
					}
				});
    		}else{
    			nui.alert("只能对交收日期为当天的数据进行指令/建议要素匹配","系统提示");
    			return;
    		}
    	}else if(rows.length==0){
    		nui.alert("请选择一条数据进行指令/建议要素匹配","系统提示");
    		return;
    	}else{
    		nui.alert("每次只能选择一条数据进行指令/建议要素匹配","系统提示");
    		return;
    	}
    }
	</script>
</body>
</html>