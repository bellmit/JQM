<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/JY_ZQMM/JY_ZQMM_common.jsp" %>
<%@include file="/ProductProcess/JY_ZNHG/JY_ZNHG_common.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-05-18 14:11:41
  - Description:
-->
<head>
	<title>同业存款</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
	<script src="<%= request.getContextPath() %>/ProductProcess/CFJYProductProcessList_common.js" type="text/javascript"></script>
	
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">

		<div title="同业存取">
			   <%-- 同业存取查询条件开始... --%>
			   <div class="search-condition">
				   <div class="list">
					   <div id="form_TYCQ" class="nui-form" style="padding:2px;" align="center" style="height:10%">
							<!-- 数据实体的名称 -->
			                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryCfJyProductProcess4Confirm">
			                <!-- 获取12-同存存入;13-同存提取类型；业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;99-其他指令/建议; -->
			                <input class="nui-hidden" name="criteria/_expr[1]/processType" value="12,13"/>
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
			                            <input id="processDate_TYCQ" class="nui-datepicker" name="criteria/_expr[2]/processDate" width="100px"/>
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
										<input class="nui-dictcombobox" name="criteria/_expr[4]/processType" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_TYCQ"  
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
			                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_TYCQ()"/>
			                        </td>
			                    </tr>
							</table>
						</div>
				  </div>
			   </div>
			   <%-- 同业存取查询条件结束!!! --%>
			   
			   <%-- 同业存取指令/建议单列表开始... --%>
	           <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	                <table style="width:100%;">
	                    <tr>
	                        <td style="width:100%;">
	                            <a id="confirm_TYCQ" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_TYCQ()">
									确认
	                            </a>
	                            &nbsp;
	                            <a id="goBack_TYCQ" class='nui-button' plain='false' iconCls="icon-no" onclick="goBack_TYCQ()">
									退回
	                            </a>
	                        </td>
	                    </tr>
	                </table>
	            </div>
	            <div class="nui-fit">
	                <div 
	                        id="datagrid_TYCQ"
	                        dataField="cfjyproductprocesss"
	                        class="nui-datagrid"
	                        style="width:100%;height:100%;"
	                        url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.queryCFJYProductProcesss4Confirm.biz.ext"
	                        pageSize="50"
	                        showPageInfo="true"
	                        multiSelect="true"
	                        onselectionchanged="selectionChanged_TYCQ"
	                        onshowrowdetail="onShowRowDetail"
	                        allowSortColumn="true"
	                        frozenStartColumn="0"
                        	frozenEndColumn="5"
	                        sortMode="client"
	                        enableHotTrack="false">
	
	                    <div property="columns">
	                        <div type="indexcolumn"></div>
	                        <div type="checkcolumn"></div>
	                        <div type="expandcolumn"></div>
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
	                        <div field="processType" headerAlign="center" allowSort="true" align="center" renderer="renderProcessType" width="70px">
	                            业务类别
	                        </div>
	                        <div field="investCount" headerAlign="center" allowSort="true" align="right" width="85px">
	                            数量（万元）
	                        </div>
	                        <div field="startInterestDate" headerAlign="center" allowSort="true" align="center" width="85px">
	                            起息日
	                        </div>
	                        <div field="dueDate" headerAlign="center" allowSort="true" align="center" width="85px">
	                            到期日
	                        </div>
	                        <div field="tradingRate" headerAlign="center" allowSort="true" align="center" width="85px">
	                            存款利率
	                        </div>
	                        <div field="depositTerm" headerAlign="center" allowSort="true" align="center" width="85px">
	                            存款期限
	                        </div>
	                        <div field="earlyWithdrawalClause" headerAlign="center" allowSort="true" align="center"renderer="renderEarlyWithdrawalClause" width="85px">
	                            提前支取条款
	                        </div>
	                        <div field="tradingOpponent" headerAlign="center" allowSort="true" align="left" width="195px">
	                            交易对手
	                        </div>
	                        <div field="validStatus" headerAlign="center" allowSort="true" align="center" renderer="renderValidStatus" width="70px">
	                            交易状态
	                        </div>
	                        <div field="investAdviserName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviser" width="195px">
	                            指令/建议录入
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
	                        <div field="backstageTraderName" headerAlign="center" allowSort="true" align="center" renderer="renderBackstageTrader" width="195px" >
	                            后台已成交
	                        </div>
	                     </div>
	                 </div>
	            </div>
	            <%-- 同业存取指令/建议单列表结束!!! --%>
			</div>
	</div>
</div>
	<script type="text/javascript">
    	nui.parse();
	    //初始化查询条件业务日期值为当天
	    var date = new Date();
	    nui.get("processDate_TYCQ").setValue(date);
	    
	    <%-- 同业存取业务 --%>
		var grid_TYCQ = nui.get("datagrid_TYCQ");
	    var formData_TYCQ = new nui.Form("#form_TYCQ").getData(false,false);
	    //grid_TYCQ.load(formData_TYCQ);
	    //表格行增加背景色
	    grid_TYCQ.on("drawcell", function (e) {
	    	drawcellFun(e);
	    });
	    //行双击时弹出页面展示该指令/建议详细信息
	    grid_TYCQ.on("rowdblclick", function (e) {
	    	rowdblclickFun("JY_TYCQ/CFJYProductProcessForm_show_TYCQ.jsp", "同业存取明细展示", 700, 380, e, grid_TYCQ, "JY_TYCQ/CFJYProductProcessForm_TYCQ.jsp");
	    });
	    //确认
		function confirm_TYCQ(){
			confirm(grid_TYCQ);
		}
		//退回
		function goBack_TYCQ(){
			goBack(grid_TYCQ);
		}
		//查询
		function search_TYCQ() {
			search(grid_TYCQ, "#form_TYCQ");
		}
		//当选择列时
	    function selectionChanged_TYCQ(){
	        selectionChanged(grid_TYCQ, "confirm_TYCQ");
	    }
    </script>
</body>
</html>