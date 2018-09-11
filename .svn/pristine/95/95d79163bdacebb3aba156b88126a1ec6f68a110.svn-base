<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): heyi
- Date: 2017-03-08 14:35:39
- Description: 交易流水查询
--%>
<head>
<title>成交回报查询</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
<script type="text/javascript" src="/ats/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>

</head>
<body style="width:100%;height:100%;">
		   <%--产品交易流水-银行间查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_CPYHJ" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="CPYHJ">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                		<td style="width:80px" align="right">
								首次交割日:
	                        </td>
	                        <td style="width:20%" align="left">
	                        	<input id="lFirstSettleDateBegin_CPYHJ" class="nui-datepicker" name="paramObject/lFirstSettleDateBegin" width="100%"/>
	                        </td>
	                        <td style="width:20px" align="center">至</td>
	                        <td style="width:20%" align="left">
								<input id="lFirstSettleDateEnd_CPYHJ" class="nui-datepicker" name="paramObject/lFirstSettleDateEnd" width="100%"/>
	                        </td>
	                		<td style="width:60px" align="right">
								日期:
	                        </td>
	                        <td style="width:20%" align="left">
	                            <input id="lDate_CPYHJ" class="nui-datepicker" name="paramObject/lDate" width="100%"/>
	                        </td>
	                        <td style="width:60px" align="right">
								产品名称:
	                        </td>
	                        <td style="width:20%" align="left">
	                            <input id="vcFundName_CPYHJ" class="nui-buttonedit" width="100%" name="paramObject/vcFundCode" onbuttonclick="ButtonClickGetFundName_CPYHJ"/>
	                        </td>
	                        <td style="width:60px" align="right">
								债券代码:
	                        </td>
	                        <td style="width:20%" align="left">
	                            <input id="vcReportCode_CPYHJ" class="nui-textbox" width="100%" name="paramObject/vcReportCode"/>
	                        </td>
	                    </tr>
	                    <tr>
	                    	<td style="width:80px" align="right">
								到期交割日:
	                        </td>
	                        <td style="width:20%" align="left">
	                        	<input id="lSecondSettleDateBegin_CPYHJ" class="nui-datepicker" name="paramObject/lSecondSettleDateBegin" width="100%"/>
	                        </td>
	                        <td style="width:20px" align="center">至</td>
	                        <td style="width:20%" align="left">
								<input id="lSecondSettleDateEnd_CPYHJ" class="nui-datepicker" name="paramObject/lSecondSettleDateEnd" width="100%"/>
	                        </td>
	                    	<td style="width:60px" align="right">
								债券名称:
	                        </td>
	                        <td style="width:20%" align="left">
	                            <input id="vcStockName_CPYHJ" class="nui-textbox" width="100%" name="paramObject/vcStockName"/>
	                        </td>
	                        <td style="width:60px" align="right">
								委托方向:
	                        </td>
	                        <td style="width:20%" align="left">
	                            <input id="vcEntrustdirName_CPYHJ" class="nui-textbox" width="100%" name="paramObject/vcEntrustdirName"/>
	                        </td>
	                        <td colspan="2" width="59px">
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_CPYHJ()"/>
	                        	<input class='nui-button' plain='false' text="重置" iconCls="icon-cancel"  onclick="resetDire_CPYHJ()"/>
	                            <input id="export_CPYHJ" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_CPYHJ()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 产品交易流水-银行间查询条件结束!!! --%>
           <%-- 产品交易流水-银行间开始... --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_CPYHJ"
                        dataField="resultObjectList"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryZHXX.biz.ext"
                        pageSize="50"
                        showPageInfo="true"
                        allowSortColumn="true"
                        frozenStartColumn="0"
                        frozenEndColumn="4"
                        sortMode="client"
                        enableHotTrack="true"
                        sizeList="[20,50,100,500,1000]">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div field="L_DATE" renderer="dateRen" headerAlign="center" allowSort="true" align="center" width="75px">
                           日期
                        </div>
                         <div field="VC_DEAL_NO" headerAlign="center" allowSort="true" align="left" width="150px">
                           成交编号
                        </div>
                        <div field="VC_FUND_CODE" headerAlign="center" allowSort="true" align="left" width="80px">
                            产品代码
                        </div>
                        <div field="VC_FUND_NAME" headerAlign="center" allowSort="true" align="left" width="180px">
                            产品名称
                        </div>
                        <div field="VC_REPORT_CODE" headerAlign="center" allowSort="true" align="left" width="80px">
                            债券代码
                        </div>
                        <div field="VC_STOCK_NAME" headerAlign="center" allowSort="true" align="left" width="100px">
                            债券名称
                        </div>
                        <div field="VC_ENTRUSTDIR_NAME" headerAlign="center" allowSort="true" align="left" width="75px">
                           委托方向
                        </div>
                        <div field="EN_RATE" headerAlign="center" allowSort="true" align="right" width="100px">
                           回购利率(%)
                        </div>
                        <div field="L_DEAL_AMOUNT" headerAlign="center" allowSort="true" align="right" width="120px">
                            成交数量
                        </div>
                        <div field="EN_FIRST_CLEAR_BALANCE" headerAlign="center" allowSort="true" align="right"width="120px">
                            成交金额
                        </div>
                        <div field="EN_SECOND_CLEAR_BALANCE" headerAlign="center" allowSort="true" align="right"width="120px">
                            到期清算金额
                        </div>
                        <div field="L_HG_DAYS" headerAlign="center" allowSort="true" align="right" width="80px">
                            回购天数
                        </div>
                        <div field="L_USE_DAYS" headerAlign="center" allowSort="true" align="right" width="80px">
                            实际占款天数
                        </div>
                        <div field="L_SETTLE_SPEED" headerAlign="center" allowSort="true" align="center" width="80px">
                            清算速度
                        </div>
                        <div field="L_FIRST_SETTLE_DATE" renderer="dateRen" headerAlign="center" allowSort="true" align="center" width="80px">
                            首次交割日
                        </div>
                        <div field="L_SECOND_SETTLE_DATE" renderer="dateRen" headerAlign="center" allowSort="true" align="center" width="80px">
                            到期交割日
                        </div>
                        <div field="L_TRADE_RIVAL_NO" headerAlign="center" allowSort="true" align="left" width="100px">
                            交易对手
                        </div>
                        <div field="EN_FIRST_NET_PRICE" headerAlign="center" allowSort="true" align="right" width="80px">
                           净价价格
                        </div>
                        <div field="EN_FIRST_FULL_PRICE" headerAlign="center" allowSort="true" align="right" width="80px">
                            全价价格
                        </div>
                        <div field="EN_SECOND_MATURE_YIELD" headerAlign="center" allowSort="true" align="right" width="80px">
                            到期收益率(%)
                        </div>
                        <div field="C_TRUSTEE" headerAlign="center" allowSort="true" align="left" width="100px">
                           托管机构
                        </div>
                        <div field="L_TIME" renderer="timeRen" headerAlign="center" allowSort="true" align="center" width="80px">
                            成交时间
                        </div>
                    </div>
                </div>
            </div>
            <%-- 产品交易流水-银行间结束!!! --%>

<script type="text/javascript">
    nui.parse();
    var grid_CPYHJ = nui.get("datagrid_CPYHJ");//产品交易流水-银行间
    var refreshInt = true;//刚刚打开页面时，投顾默认刷新，交易员默认不刷新
	var queryUserTypeTemp = "<%=request.getParameter("queryUserType")%>";
	if(queryUserTypeTemp!=null && queryUserTypeTemp!="" && queryUserTypeTemp!="null"){
		refreshInt = false;
	}
    
    //tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	function activechangedFun(){
		if(refreshInt==false){
			return;
		}
			search_CPYHJ();
	}
	
	//系统自动刷新页面--所有业务通用
    function autoRefreshFun(){
    	refreshInt = true;//打开页面之后设置值为true
    	activechangedFun();//同时刷新查询列表数据
    }
    self.setInterval("autoRefreshFun()",60000*5);//设置自动刷新时间默认5分钟
	
	
	<%-- 产品交易流水-银行间查询开始... --%>
	//查询
	function search_CPYHJ() {
		search(grid_CPYHJ, "#form_CPYHJ");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_CPYHJ(e){
        ButtonClickGetFundName(this,null);
	}
	//导出
	function export_CPYHJ(){
		exportSubmit("export_CPYHJ", "form_CPYHJ", "银行间成交回报");
	}
	
	//日期转换
	function dateRen(e){
		if(e.value == 0){
			return "";
		}
		if(e.value){
			return DateUtil.numStrToDateStr(e.value);
		}
		return "";
	}
	
	//时间转换
	function timeRen(e){
		if(e.value == 0){
			return "";
		}
		if(e.value){
			return DateUtil.numStrToTimeStr(e.value);
		}
		return "";
	}
	
	function resetDire_CPYHJ(){
		var form = new nui.Form("form_CPYHJ");
		form.reset();
	}
	
</script>
</body>
</html>