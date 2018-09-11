<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/JY_ZQMM/JY_ZQMM_common.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-05-22 19:09:46
  - Description:
-->
<head>
<title>债券买卖</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
	<script src="<%= request.getContextPath() %>/ProductProcess/CFJYProductProcessList_queryConfirm.js" type="text/javascript"></script>
</head>
<body style="margin: 0px;padding: 0px;overflow: hidden;width: 100%;height: 100%;" onload="onloadFun()">
	<div activeIndex="0" id="tab" style="width:100%;height:100%;" onactivechanged="activechangedFun">
		<!-- 业务类型标签页开始... -->
		<%-- 债券买卖查询条件开始... --%>
	   <div class="search-condition">
		   <div class="list">
			 <div id="form_ZQMM" class="nui-form" style="padding:2px;" align="center" style="height:10%">
				<!-- 数据实体的名称 -->
                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryZhfwptJyZqmm4Confirm">
                <!-- 获取01-债券买入、02-债券卖出类型；业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;99-其他指令/建议; -->
                <input class="nui-hidden" name="criteria/_expr[1]/processType" value="01,02"/>
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
                        <td colspan="1" width="13%">
                            <input id="processDate_ZQMM" class="nui-datepicker" name="criteria/_expr[2]/processDate" width="100px"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
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
							<input class="nui-dictcombobox" name="criteria/_expr[4]/processType" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQMM"  
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
                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_ZQMM()"/>
                        </td>
                    </tr>
				</table>
			</div>
		  </div>
	   </div>
	   <%-- 债券买卖查询条件结束!!! --%>
	   
	   <%-- 债券买卖指令/建议单列表开始... --%>
       <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:50%;">
                        <a id="confirm_ZQMM" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_ZQMM()">
							确认
                        </a>
                        &nbsp;
                        <a id="update_ZQMM" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit_ZQMM()">
                           	 编辑
                        </a>
                        &nbsp;
                        <a id="goBack_ZQMM" class='nui-button' plain='false' iconCls="icon-no" onclick="goBack_ZQMM()">
							退回
                        </a>
                    </td>
                    <td style="width:50%;" align="right">
                        <input class='nui-button' plain='false' text="保存" iconCls="icon-save" onclick="save_ZQMM()"/>
                        &nbsp;
                        <%-- 点击“刷新”按钮后重启自动刷新功能（若之前自动刷新功能设置为不自动刷新关闭时） --%>
	                    <a class='nui-button' plain='false' iconCls="icon-reload" onclick="autoRefreshFun()">刷新</a>
	                    <input id="autoRefresh" class="nui-combobox" style="width:90px;" 
		                    value="300" showNullItem="false" allowInput="false"
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
							{ id: 1800, text: '每30分刷新' }]"/> &nbsp;
        				<a href="javascript:fullScreen()"><span class="warn_red_bold" style="border-bottom:1px solid;font-size:13px;">全屏显示</span></a>
                		&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div 
                    id="datagrid_ZQMM"
                    dataField="zhfwptjyzqmms"
                    class="nui-datagrid"
                    style="width:100%;height:100%;"
                    url="com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_query4Confirm.biz.ext"
                        pageSize="50"
                        showPageInfo="true"
                        multiSelect="true"
                        onselectionchanged="selectionChanged_ZQMM"
                        onshowrowdetail="onShowRowDetail"
                        allowSortColumn="true"
                        frozenStartColumn="0"
                    	frozenEndColumn="6"
                        sortMode="client"
                        enableHotTrack="false"
                        sizeList="[10,20,50,100]"
                        allowCellEdit="true"
						allowCellSelect="true"
						enterNextCell="true"
						allowMoveColumn="true"
						editNextOnEnterKey="true">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div type="checkcolumn"></div>
                        <div type="expandcolumn"></div>
                        <div field="processDate" headerAlign="center" allowSort="true" align="center" width="85px">
                            业务日期
                        </div>
                        <div field="expiredate" headerAlign="center" allowSort="true" align="center" width="85px">
                                截止日期
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
                        <div field="processType" headerAlign="center" allowSort="true" align="center" renderer="renderProcessType" width="70px">
                            业务类别
                        </div>
                        <div field="investProductCode" headerAlign="center" allowSort="true" align="left" width="85px">
                            债券代码
                        </div>
                        <div field="investProductName" headerAlign="center" allowSort="true" align="left" width="140px">
                            债券名称
                        </div>
                        <div field="investCategory" headerAlign="center" allowSort="true" align="left" renderer="renderInvestCategory" width="85px">
                            债券类别
                        </div>
                        <div field="subjectRating" headerAlign="center" allowSort="true" align="center" renderer="renderSubjectRating" width="85px">
                            主体评级
                        </div>
                        <div field="bondRating" headerAlign="center" allowSort="true" align="center" renderer="renderBondRating" width="85px">
                            债券评级
                        </div>
                        <div field="clearingSpeed" headerAlign="center" allowSort="true" align="center" renderer="renderClearingSpeed" width="60px">
                            清算速度
                        </div>
                        <div field="cleartype" headerAlign="center" allowSort="true" align="center" renderer="renderClearType" width="60px">
                                      清算类型
                        </div>
                        <div field="tradingPlace" headerAlign="center" allowSort="true" align="center" renderer="renderTradingPlace" width="120px">
                            交易场所
                        </div>
                        <div field="investCount" headerAlign="center" allowSort="true" align="right" width="100px">
                            券面金额（万元）
                        </div>
                        <div field="tradingOpponent" headerAlign="center" allowSort="true" align="left" width="100px">
                            交易对手
                        </div>
                        <div field="netPrice" headerAlign="center" allowSort="true" align="right" width="100px">
                            净价（元/百元面值）
                        </div>
                        <div field="fullPrice" headerAlign="center" allowSort="true" align="right" width="100px">
                            全价（元/百元面值）
                        </div>
                        <div field="interestRateType" headerAlign="center" allowSort="true" align="center" renderer="renderInterestRateType" width="85px">
                            收益率类型
                        </div>
                        <div field="interestRate" headerAlign="center" allowSort="true" align="right">
                            收益率
                        </div>
                        <div field="traderCode" headerAlign="center" allowSort="true" align="center">
                            交易员代码
                        </div>
                        <div field="seatNum" headerAlign="center" allowSort="true" align="center" >
                            席位号
                        </div>
                        <div field="agreementNum" headerAlign="center" allowSort="true" align="center" >
                            约定号
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
        <%-- 债券买卖指令/建议单列表结束!!! --%>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	
    	//初始化查询条件业务日期值为当天
	    nui.get("processDate_ZQMM").setValue(date);
	    
    	<%-- 债券买卖业务 --%>
	    var grid_ZQMM = nui.get("datagrid_ZQMM");
	    var formData_ZQMM = new nui.Form("#form_ZQMM").getData(false,false);
		parent.updateTab();
	    grid_ZQMM.load(formData_ZQMM);
	    //表格行增加背景色
	    grid_ZQMM.on("drawcell", function (e) {
	    	drawcellFun(e);
		});
		//行双击时弹出页面展示该指令/建议详细信息
	    grid_ZQMM.on("rowdblclick", function (e) {
	    	rowdblclickFun_common_confirm_ZQMM("JY_ZQMM/CFJYProductProcessForm_show_ZQMM.jsp", "债券买卖明细展示", 700, 510, e, grid_ZQMM, "JY_ZQMM/CFJYProductProcessForm_ZQMM.jsp");
	    });
	    //编辑
	    function edit_ZQMM() {
	    	edit_common_confirm_ZQMM("JY_ZQMM/CFJYProductProcessForm_ZQMM.jsp", "债券买卖编辑数据", 700, 510, grid_ZQMM);
	    }
		//确认
		function confirm_ZQMM(){
			confirm_common_confirm_ZQMM(grid_ZQMM);
		}
		//退回
		function goBack_ZQMM(){
			goBack_common_confirm_ZQMM(grid_ZQMM);
		}
		//查询
		function search_ZQMM() {
			search(grid_ZQMM, "#form_ZQMM");
		}
	    //当选择列时
	    function selectionChanged_ZQMM(){
	    	selectionChanged(grid_ZQMM, "confirm_ZQMM", "update_ZQMM");
	    }
	    //保存
		function save_ZQMM(){
			save(grid_ZQMM, "com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_updateBackstageTraderInfoWithFeedback.biz.ext", "#form_ZQMM");
		}
	
	    //全屏显示
		function fullScreen(){
			window.open('<%=request.getContextPath()%>/ProductProcess/JY_ZQMM/CFJYProductProcessList__queryConfirm_ZQMM.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		}
		
		//自动刷新功能处理
    	var autoRefreshValOld = nui.get("autoRefresh").getValue();//获取默认自动刷新时间
	    var autoRefreshReturnVal= self.setInterval("autoRefreshFun()",eval(autoRefreshValOld)*1000);//
	    function autoRefreshFun(){
	    	search(grid_ZQMM, "#form_ZQMM");//同时刷新查询列表数据
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