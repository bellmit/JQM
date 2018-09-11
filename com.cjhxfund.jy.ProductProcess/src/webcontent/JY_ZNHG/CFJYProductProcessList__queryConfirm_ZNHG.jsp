<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/JY_ZNHG/JY_ZNHG_common.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-05-22 19:09:46
  - Description:
-->
<head>
<title>查询指令/建议--正逆回购</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
	<script src="<%= request.getContextPath() %>/ProductProcess/CFJYProductProcessList_queryConfirm.js" type="text/javascript"></script>
</head>
<body style="margin: 0px;padding: 0px;overflow: hidden;width: 100%;height: 100%;" onload="onloadFun()">
	<div activeIndex="0" id="tab" style="width:100%;height:100%;" onactivechanged="activechangedFun">
		<!-- 业务类型标签页开始... -->
			   <%-- 正逆回购查询条件开始... --%>
			   <%-- 正逆回购查询条件开始... --%>
	   <div class="search-condition">
		   <div class="list">
			   <div id="form_ZNHG" class="nui-form" style="padding:2px;" align="center" style="height:10%">
					<!-- 数据实体的名称 -->
	                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryZhfwptJyZnhg4Confirm">
	                <!-- 获取03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购类型;16-交易所协议正回购;17-交易所协议逆回购；业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;99-其他指令/建议; -->
	                <input class="nui-hidden" name="criteria/_expr[1]/processType" value="03,04,05,06,16,17,21,22"/>
	                <input class="nui-hidden" name="criteria/_expr[1]/_op" value="in">
	                <!-- 排序字段 -->
	                <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="processDate">
	                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="desc">
	                <input class="nui-hidden" name="criteria/_orderby[2]/_property" value="investProductNum">
	                <input class="nui-hidden" name="criteria/_orderby[2]/_sort" value="desc">
	                <input class="nui-hidden" name="criteria/_orderby[3]/_property" value="validStatus">
	                <input class="nui-hidden" name="criteria/_orderby[3]/_sort" value="asc">
	                <input class="nui-hidden" name="criteria/_orderby[4]/_property" value="processStatus">
	                <input class="nui-hidden" name="criteria/_orderby[4]/_sort" value="asc">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="7%">
								业务日期:
	                        </td>
	                        <td style="width:28%" align="left">
	                            <input id="processDate_znhg_begin" name="criteria/_expr[2]/processDate" class="nui-datepicker" width="100px"/>
	                            <input class="nui-hidden" type="hidden" name="criteria/_expr[2]/_op" value=">=">
						 		- 
						 		<input id="processDate_znhg_end" name="criteria/_expr[6]/processDate" class="nui-datepicker" width="100px"/>
						 		<input class="nui-hidden" type="hidden" name="criteria/_expr[6]/_op" value="<="/>
	                        </td>
	                        <td class="form_label" width="7%">
								产品名称:
	                        </td>
	                        <td colspan="1" width="13%">
	                            <input class="nui-buttonedit" name="criteria/_expr[3]/combProductCode" onbuttonclick="ButtonClickGetFundNameCommon"/>
                            	<input class="nui-hidden" name="criteria/_expr[3]/_op" value="in">
	                        </td>
	                        <td class="form_label" width="7%">
								业务类别:
	                        </td>
	                        <td colspan="1" width="13%">
								<input class="nui-dictcombobox" name="criteria/_expr[4]/processType" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZNHG"  
									emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty"/>
								<input class="nui-hidden" name="criteria/_expr[4]/_op" value="in"/>
							</td>
							<td class="form_label" width="7%">
								交易状态:
	                        </td>
	                        <td colspan="1" width="18%">
								<input class="nui-dictcombobox" name="criteria/_expr[5]/validStatus" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_VALID_STATUS"  
									emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
								<input class="nui-hidden" name="criteria/_expr[5]/_op" value="in"/>
							</td>
	                        <td colspan="1" width="15%">
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_ZNHG()"/>
	                        </td>
	                    </tr>
					</table>
				</div>
		  </div>
	   </div>
	   <%-- 正逆回购查询条件结束!!! --%>
	   
	   <%-- 正逆回购指令/建议单列表开始... --%>
       <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td>
                        <a id="confirm_ZNHG" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_ZNHG()">
							确认
                        </a>
                        &nbsp;
                        <a id="update_ZNHG" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit_ZNHG()">
                           	编辑
                        </a>
                        &nbsp;
                        <a id="export_ZNHG" class='nui-button' plain='false' iconCls="icon-download" onclick="export_ZNHG()">
                           	 导出
                        </a>
                    </td>
                    <td align="right">
                        <input class='nui-button' plain='false' text="保存" iconCls="icon-save" onclick="save_ZNHG()"/>
                        &nbsp;
                        <%-- 点击“刷新”按钮后重启自动刷新功能（若之前自动刷新功能设置为不自动刷新关闭时） --%>
	                    <a class='nui-button' plain='false' iconCls="icon-reload" onclick="autoRefreshFun()">刷新</a>
	                    <input id="autoRefresh" class="nui-combobox" style="width:90px;" textField="text" valueField="id" url="<%= request.getContextPath() %>/ProductProcess/AutoRefreshData.txt" value="180" showNullItem="false" allowInput="false"/>
	                    &nbsp;
        				<a href="javascript:fullScreen()"><span class="warn_red_bold" style="border-bottom:1px solid;font-size:13px;">全屏显示</span></a>
                		&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div 
                    id="datagrid_ZNHG"
                    dataField="zhfwptjyznhgs"
                    class="nui-datagrid"
                    style="width:100%;height:100%;"
                    url="com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_query4Confirm.biz.ext"
                        pageSize="50"
                        showPageInfo="true"
                        multiSelect="true"
                        onselectionchanged="selectionChanged_ZNHG"
                        onshowrowdetail="onShowRowDetail_ZNHG"
                        allowSortColumn="true"
                        frozenStartColumn="0"
                    	frozenEndColumn="7"
                        sortMode="client"
                        enableHotTrack="false"
                        allowCellEdit="true"
						allowCellSelect="true"
						enterNextCell="true"
						allowMoveColumn="true"
						editNextOnEnterKey="true">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div type="checkcolumn"></div>
                        <div type="expandcolumn"></div>
                        
                        <div field="processStatus" headerAlign="center" allowSort="true" align="center" visible="false">
                            状态
                        </div>
                        <div field="isNotExport" headerAlign="center" allowSort="true" align="center" visible="false">
                            是否已导出
                        </div>
                        
                        <div field="processDate" headerAlign="center" allowSort="true" align="center" width="85px">
                            业务日期
                        </div>
                        <div field="combProductName" headerAlign="center" allowSort="true" align="left" width="140px">
                            产品名称
                        </div>
                        <div field="investProductNum" headerAlign="center" allowSort="true" align="center" width="50px">
                            编号
                        </div>
                        <div field="vcCombiNo" headerAlign="center" allowSort="true" align="left" visible="false">
                            投资组合编号
                        </div>
                        <div field="vcCombiName" headerAlign="center" allowSort="true" align="left" width="100px">
                            组合名称
                        </div>
                        <div field="processType" headerAlign="center" allowSort="true" align="center" renderer="renderProcessType" width="100px">
                            业务类别
                        </div>
                        <div field="tradingOpponent" headerAlign="center" allowSort="true" align="left" width="195px">
                            交易对手
                        </div>
                        <div field="investCount" headerAlign="center" allowSort="true" align="right" width="120px">
                            券面总额合计（万元）
                        </div>
                        <div field="tranAmount" headerAlign="center" allowSort="true" align="right"width="120px">
                            交易金额（万元）
                        </div>
                        <div field="actualDays" headerAlign="center" allowSort="true" align="center" width="100px">
                            回购期限（天）
                        </div>
                        <div field="tradingRate" headerAlign="center" allowSort="true" align="center" width="90px">
                            回购利率（%）
                        </div>
                        <div field="clearingSpeed" headerAlign="center" allowSort="true" align="center" renderer="renderClearingSpeed" width="60px">
                            清算速度
                        </div>
                        <div field="firstSettlementDate" headerAlign="center" allowSort="true" align="center" width="85px" dateFormat="yyyy-MM-dd">
                            首次结算日
                        </div>
                        <div field="expiryDate" headerAlign="center" allowSort="true" align="center" width="85px" dateFormat="yyyy-MM-dd">
                            到期结算日
                        </div>
                        <div field="validStatus" headerAlign="center" allowSort="true" align="center" renderer="renderValidStatus" width="70px">
                            交易状态
                        </div>
                        <div field="inquiryName" headerAlign="center" allowSort="true" align="center" renderer="renderInquiry" width="195px">
                            指令/建议询价
                        </div>	                        
                        <div field="investAdviserName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviser" width="195px">
                            指令/建议录入
                        </div>
                        <div field="completeInstructionsName" headerAlign="center" allowSort="true" align="center" renderer="renderCompleteInstructions" width="195px">
                            指令/建议补齐
                        </div>
                        <div field="investAdviserConfirmName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviserConfirm" width="195px">
                            指令/建议确认
                        </div>
                        <div field="investManagerName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestManager" width="195px" >
                            投资经理下单
                        </div>
                        <div field="traderName" headerAlign="center" allowSort="true" align="center" renderer="renderTrader" width="195px" >
                            交易员填单
                        </div>
                        <div field="reviewName" headerAlign="center" allowSort="true" align="center" renderer="renderReview" width="195px" >
                            交易已发送
                        </div>
                        <div field="sendName" headerAlign="center" allowSort="true" align="center" renderer="renderSend" width="195px" >
                            前台已成交
                        </div>
                        <div field="backstageTraderStatus" headerAlign="center" align="left" allowSort="true" width="170px" renderer="renderBackstageTraderStatus" >
			    后台成交状态
			    			<input property="editor" class="nui-dictcombobox" style="width:100%;" dictTypeId="CF_JY_HTCJZT" showNullItem="true" required="false" />
		            </div>
                    <div field="backstageTraderRemark" headerAlign="center" allowSort="true" align="left" width="250px">
		    成交情况备注
		  				<input property="editor" class="nui-textarea" style="width:100%;height:100px;"/>
                    </div>
                 </div>
             </div>
        </div>
        <%-- 正逆回购指令/建议单列表结束!!! --%>
	</div>
	<div>
		<form id="export_ZNHG_FROM" method="post">
			<!-- 数据实体的名称 -->
			<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.singleDataset.ZhfwptJyZnhg">
			<input class="nui-hidden" name="exportType" value="0">
			<input class="nui-hidden" name="criteria/_expr[1]/processId" id="processId1"/>
			<input class="nui-hidden" name="criteria/_expr[1]/_op" value="in"/>
			<input class="nui-hidden" name="processType" id="processType1"/>
		</form>	
	</div>
	<script type="text/javascript">
    	nui.parse();
    	
    	//初始化查询条件业务日期值为当天
		nui.get("processDate_znhg_begin").setValue(date);
		nui.get("processDate_znhg_end").setValue(date);
	    
    	<%-- 正逆回购业务 --%>
		var grid_ZNHG = nui.get("datagrid_ZNHG");
	    var formData_ZNHG = new nui.Form("#form_ZNHG").getData(false,false);
		parent.updateTab();
		
	    grid_ZNHG.load(formData_ZNHG);
	    //表格行增加背景色
	    grid_ZNHG.on("drawcell", function (e) {
	    	drawcellFun(e);
	    });
	    //行双击时弹出页面展示该指令/建议详细信息
	    grid_ZNHG.on("rowdblclick", function (e) {
	    	rowdblclickFun_common_confirm_ZNHG("JY_ZNHG/CFJYProductProcessForm_detailOperator_show_ZNHG.jsp", "正逆回购明细展示", 800, 600, e, grid_ZNHG, "JY_ZNHG/CFJYProductProcessForm_ZNHG.jsp");
	    });
	    //编辑
	    function edit_ZNHG() {
	    	edit_common_confirm_ZNHG("JY_ZNHG/CFJYProductProcessForm_ZNHG.jsp", "正逆回购编辑数据", 800, 600, grid_ZNHG);
	    }
	    //确认
		function confirm_ZNHG(){
			confirm_common_confirm_ZNHG(grid_ZNHG);
		}
		//查询
		function search_ZNHG() {
			search(grid_ZNHG, "#form_ZNHG");
		}
		//当选择列时
	    function selectionChanged_ZNHG(){
	    	selectionChanged(grid_ZNHG, "confirm_ZNHG", "update_ZNHG");
	    }
	    //保存
		function save_ZNHG(){
			save(grid_ZNHG, "com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_updateBackstageTraderInfoWithFeedback.biz.ext", "#form_ZNHG");
		}
	    //展示详细行数据
		function onShowRowDetail_ZNHG(e) {
			var grid = e.sender;//获取表格
		    var row = e.record;//获取行数据
		    var remark = changeNull(row.remark);//备注信息
		    var abandonedReasons = changeNull(row.abandonedReasons);//废弃原因
		    var inquiryMd = nui.formatDate(row.inquiryMd, "yyyy-MM-dd HH:mm:ss");//指令/建议询价修改、废弃时间
		    var investAdviserMd = nui.formatDate(row.investAdviserMd, "yyyy-MM-dd HH:mm:ss");//指令/建议录入修改、废弃时间	    
		    var completeInstructionsMd = nui.formatDate(row.completeInstructionsMd, "yyyy-MM-dd HH:mm:ss");//指令/建议补齐修改时间
		    var mdTime =  completeInstructionsMd==null||completeInstructionsMd==""?(inquiryMd==null||inquiryMd==""?investAdviserMd:inquiryMd):completeInstructionsMd;//修改、废弃时间，交易员填单指令/建议补齐修改时间优先级最高
		    
		    //获取债券信息
		    var processIdJson = nui.encode({processId: row.processId});
		    $.ajax({
	            url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_queryBondsByProcessId.biz.ext",
	            type:'POST',
	            data:processIdJson,
	            cache: false,
	            contentType:'text/json',
	            success:function(text){
	                var returnJson = nui.decode(text);
	                if(returnJson.exception == null){
	                    var bonds = returnJson.bonds;
	                    var bondStr = "<table>"
	                    			+" <tr>"
	                    			+"  <td style='width:150px;font-weight:bold;' align='center'>债券代码</td>"
	                    			+"  <td style='width:220px;font-weight:bold;' align='center'>债券名称</td>"
	                    			+"  <td style='width:120px;font-weight:bold;' align='center'>券面总额（万元）</td>"
	                    			+"  <td style='width:120px;font-weight:bold;' align='center'>折算比例（%）</td>"
	                    			+"  <td style='width:120px;font-weight:bold;' align='center'>首次净价（元）</td>"
	                    			+" </tr>";
	                    			
	                    for(var i=0; i<bonds.length; i++){
	                    	var bondInfo = bonds[i];
	                    	bondStr += "<tr><td align='center'>"+changeNull(bondInfo.bondCode)+"</td><td align='center'>"+changeNull(bondInfo.bondName)+"</td><td align='center'>"+changeNull(bondInfo.bondAmount)
	                    			+	"</td><td align='center'>"+changeNull(bondInfo.conversionRatio)+"</td><td align='center'>"+changeNull(bondInfo.firstNetValue)+"</td></tr>";
	                    }
	                    bondStr += "</table>";
	                    
	                    var td = grid.getRowDetailCellEl(row);
						
						var html = bondStr;
						html += "<table style='width:100%;'>";
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
						html += "</table>";
						
						
						td.innerHTML = html;
	                    
	                }else{
						nui.alert("加载失败", "系统提示");
	                }
	            }
	         });
		}
		
		//全屏显示
		function fullScreen(){
			window.open('<%=request.getContextPath()%>/ProductProcess/JY_ZNHG/CFJYProductProcessList__queryConfirm_ZNHG.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		}
		
		//自动刷新功能处理
    	var autoRefreshValOld = nui.get("autoRefresh").getValue();//获取默认自动刷新时间
	    var autoRefreshReturnVal= self.setInterval("autoRefreshFun()",eval(autoRefreshValOld)*1000);//设置自动刷新时间默认3分钟
	    function autoRefreshFun(){
	    
	    	search_ZNHG(); //同时刷新查询列表数据
			
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
		
	</script>
</body>
</html>