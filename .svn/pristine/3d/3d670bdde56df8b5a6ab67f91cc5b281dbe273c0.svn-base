<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%
	//默认当天是交易日
	String businDay = DateUtil.currentDateString(DateUtil.YMD_NUMBER);
	//判断今天是否为交易日
	boolean isTradeDay = DateUtil.isTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null);
	//若当天不是交易日（周末或节假日），则业务日期获取下个交易日
	if(!isTradeDay){
		businDay = DateUtil.getCalculateTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null, 1);
	}
	//获取上一个交易日
	String preDate = DateUtil.getCalculateTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null, -1);
%>
<%--
- Author(s): heyi
- Date: 2017-03-08 14:35:39
- Description: 交易流水查询
--%>
<head>
<title>交易所成交回报查询</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>

</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
		<%-- 业务类型标签页开始... --%>
		   <%--产品交易流水-交易所查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_CPJYS" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="CPJYS">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                		<td class="form_label" width="7%">
								业务日期:
	                        </td>
	                        <td colspan="1" width="30%">
	                        	从<input id="lDateBegin_CPJYS" class="nui-datepicker" name="paramObject/lDateBegin" width="100px" onvaluechanged="lDateBeginFun('lDateBegin_CPJYS','lDateEnd_CPJYS')" />
								到<input id="lDateEnd_CPJYS" class="nui-datepicker" name="paramObject/lDateEnd" width="100px" onvaluechanged="lDateEndFun('lDateBegin_CPJYS','lDateEnd_CPJYS')" required="true"/>
	                        </td>
	                        <td class="form_label" width="7%">
								基金名称:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vcFundName_CPJYS" class="nui-buttonedit" name="paramObject/vcFundCode" onbuttonclick="ButtonClickGetFundName_CPJYS"/>
	                        </td>
	                        <td class="form_label" width="7%">
								证券代码:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vcReportCode_CPJYS" class="nui-textbox" name="paramObject/vcReportCode"/>
	                        </td>
	                        <td class="form_label" width="7%">
								证券名称:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vcStockName_CPJYS" class="nui-textbox" name="paramObject/vcStockName"/>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="form_label">
								业务类型:
	                        </td>
	                        <td colspan="1">
	                            <!-- <input id="cBusinClassName_CPJYS" class="nui-textbox" name="paramObject/cBusinClassName"/> -->
	                            <input class="nui-combobox"  name="paramObject/cBusinClassName"  textField="VAL" valueField="VAL" 
    url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.getYwlx.biz.ext" emptyText="请选择"  multiSelect="true"  /> 
	                        </td>
	                        <td class="form_label">
								委托方向:
	                        </td>
	                        <td colspan="1">
	                            <!-- <input id="vcEntrustdirName_CPJYS" class="nui-textbox" name="paramObject/vcEntrustdirName"/> -->
	                            <input class="nui-combobox"  name="paramObject/vcEntrustdirName"  textField="VAL" valueField="VAL" 
    url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.getYjsWtfx.biz.ext" emptyText="请选择"  multiSelect="true"  /> 
	                        </td>
	                        <td colspan="4">
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_CPJYS()"/>
	                        	<input class='nui-button' plain='false' text="重置" iconCls="icon-cancel"  onclick="resetDire_CPJYS()"/>
	                            <input id="export_CPJYS" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_CPJYS()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 产品交易流水-交易所查询条件结束!!! --%>
           <%-- 产品交易流水-交易所开始... --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_CPJYS"
                        dataField="resultObjectList"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryZHXX.biz.ext"
                        pageSize="50"
                        showPageInfo="true"
                        allowSortColumn="true"
                        frozenStartColumn="0"
                        frozenEndColumn="3"
                        sortMode="client"
                        enableHotTrack="true"
                        sizeList="[10,20,50,100]">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        
                        <div field="L_DATE" renderer="dateRen" headerAlign="center" allowSort="true" align="center" width="75px">
                            业务日期
                        </div>
                        <div field="VC_FUND_CODE" headerAlign="center" allowSort="true" align="left" width="80px">
                            基金代码
                        </div>
                        <div field="VC_FUND_NAME" headerAlign="center" allowSort="true" align="left" width="180px">
                            基金名称
                        </div>
                        <div field="VC_REPORT_CODE" headerAlign="center" allowSort="true" align="left" width="80px">
                            证券代码
                        </div>
                        <div field="VC_STOCK_NAME" headerAlign="center" allowSort="true"  align="left" width="120px">
                            证券名称
                        </div>
                        <div field="VC_ENTRUSTDIR_NAME" headerAlign="center" allowSort="true" align="left" width="80px">
                            委托方向
                        </div>
                        <div field="EN_AVG_PRICE" headerAlign="center" allowSort="true" align="right" width="100px">
                            市场成交均价
                        </div>
                        <div field="L_DEAL_AMOUNT" headerAlign="center" allowSort="true" align="right" width="120px">
                            成交数量
                        </div>
                        <div field="EN_DEAL_BALANCE" headerAlign="center" allowSort="true" align="right" width="120px">
                            成交金额
                        </div>
                        <div field="EN_AVG_DEALPRICE" headerAlign="center" allowSort="true" align="right" width="100px">
                            成交均价
                        </div>
                        <div field="EN_AVG_DEALPRICE_FULL" headerAlign="center" allowSort="true" align="right" width="100px">
                            成交均价(全价)
                        </div>
                        <div field="VC_MARKET_NAME" headerAlign="center" allowSort="true" align="left" width="80px">
                            交易市场
                        </div>
                        <div field="C_BUSIN_CLASS_NAME" headerAlign="center" allowSort="true" align="left" width="80px">
                            业务类型
                        </div>
                    </div>
                </div>
            </div>
            <%-- 产品交易流水-交易所结束!!! --%>
</div>

<script type="text/javascript">
    nui.parse();
    var businDay = '<%=businDay%>';//当前交易日
    var preDate = '<%=preDate%>';//上一个交易日
    
    var grid_CPJYS = nui.get("datagrid_CPJYS");//产品交易流水-交易所
	nui.get("lDateBegin_CPJYS").setValue(businDay);//设置默认日期-交易所成交回报-起始日期
	nui.get("lDateEnd_CPJYS").setValue(businDay);//设置默认日期-交易所成交回报-截止日期
    var refreshInt = true;//刚刚打开页面时，投顾默认刷新，交易员默认不刷新
	var queryUserTypeTemp = "<%=request.getParameter("queryUserType")%>";
	if(queryUserTypeTemp!=null && queryUserTypeTemp!="" && queryUserTypeTemp!="null"){
		refreshInt = false;
	}
    
	//系统自动刷新页面--所有业务通用
    function autoRefreshFun(){
    	if(refreshInt==false){
			return;
		}
    	search_CPJYS();
    }
    self.setInterval("autoRefreshFun()",60000*5);//设置自动刷新时间默认5分钟
	
	<%-- 产品交易流水-交易所查询开始... --%>
	//查询
	function search_CPJYS() {
		search(grid_CPJYS, "#form_CPJYS");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_CPJYS(e){
        ButtonClickGetFundName(this);
	}
	//导出
	function export_CPJYS(){
		exportSubmit("export_CPJYS", "form_CPJYS", "交易所成交回报");
	}
	
	//重置指令/建议信息
	function resetDire_CPJYS(){
		var form = new nui.Form("form_CPJYS");
		form.reset();
		//默认当天日期
		nui.get("lDateBegin_CPJYS").setValue(businDay);
		nui.get("lDateEnd_CPJYS").setValue(businDay);
	}
	
	<%-- 产品交易流水-交易所查询结束!!! --%>
	
</script>
</body>
</html>