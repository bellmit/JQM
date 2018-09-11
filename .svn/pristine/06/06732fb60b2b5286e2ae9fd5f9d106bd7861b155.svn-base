<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2016-03-03 14:35:39
- Description: 综合信息查询（数据取自O32）
--%>
<head>
<title>标准券查询</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
		   <%-- 标准券查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_BZQ" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="BZQ">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="7%">
								基金名称:
	                        </td>
	                        <td colspan="1" width="17%">
	                            <input id="vCFundCode_BZQ" class="nui-buttonedit" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_BZQ"/>
	                        </td>
	                        <td class="form_label" width="7%">
								交易市场:
	                        </td>
	                        <td colspan="1" width="17%">
	                            <input id="cMarketNo_BZQ" class="nui-textbox" name="paramObject/cMarketNo"/>
	                        </td>
	                        <td class="form_label" width="7%">
								证券代码:
	                        </td>
	                        <td colspan="1" width="17%">
	                            <input id="vCReportCode_BZQ" class="nui-textbox" name="paramObject/vCReportCode"/>
	                        </td>
	                        <td class="form_label" width="7%">
								证券名称:
	                        </td>
	                        <td colspan="1" width="17%">
	                            <input id="vCStockName_BZQ" class="nui-textbox" name="paramObject/vCStockName"/>
	                        </td>
	                        <td colspan="1" width="59px">
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_BZQ()"/>
	                        </td>
	                        <td colspan="1" width="59px">
	                            <input id="export_BZQ" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_BZQ()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 标准券查询条件结束!!! --%>
		   
		   <%-- 标准券列表开始... --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_BZQ"
                        dataField="resultObjectList"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryZHXX.biz.ext"
                        pageSize="50"
                        showPageInfo="true"
                        allowSortColumn="true"
                        sortMode="client"
                        enableHotTrack="true"
                        pagerButtons="#prompt_todays"
                        sizeList="[10,20,50,100]">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div field="VC_FUND_CODE" headerAlign="center" allowSort="true" align="center" width="75px">
                            基金代码
                        </div>
                        <div field="VC_FUND_NAME" headerAlign="center" allowSort="true" align="left" width="150px">
                            基金名称
                        </div>
                        <div field="VC_SSET_NAME" headerAlign="center" allowSort="true" align="left" width="150px">
                            组合名称
                        </div>
                        <div field="C_MARKET_NO" headerAlign="center" allowSort="true" align="center" width="75px">
                            交易市场
                        </div>
                        <div field="VC_REPORT_CODE" headerAlign="center" allowSort="true" align="center" width="75px">
                            证券代码
                        </div>
                        <div field="VC_STOCK_NAME" headerAlign="center" allowSort="true" align="left" width="120px">
                            证券名称
                        </div>
                        <div field="L_AMOUNT" headerAlign="center" allowSort="true" align="right" width="120px">
                            库存数量
                        </div>
                        <div field="L_AVL_AMOUNT" headerAlign="center" allowSort="true" align="right" width="120px">
                            可用数量
                        </div>
                    </div>
                </div>
            </div>
            <div id="prompt_todays">
		        <span class="separator"></span>
		       	<div style= "display:inline-block; color:red;margin-right: 8px;">红色字体代表标准券“可用数量”为负</div>
			</div>
            <%-- 标准券列表结束!!! --%>
</div>

<script type="text/javascript">
    nui.parse();
    var grid_BZQ = nui.get("datagrid_BZQ");//标准券
    
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
    	search_BZQ();
    }
    self.setInterval("autoRefreshFun()",60000*5);//设置自动刷新时间默认5分钟
    
	
	<%-- 标准券查询开始... --%>
	//查询
	function search_BZQ() {
		search(grid_BZQ, "#form_BZQ");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_BZQ(e){
        ButtonClickGetFundName(this);
	}
	//表格行增加样式
	grid_BZQ.on("drawcell", function (e) {
    	var record = e.record;
		var L_AVL_AMOUNT = record.L_AVL_AMOUNT.replace(/\$|\,/g,'');//可用数量
		//设置行样式，当标准券可用数量为负，变更为红色并加粗，提醒
		if(eval(L_AVL_AMOUNT)<0){
			e.rowCls = "warn_red_bold";
		}
	});
	//导出
	function export_BZQ(){
		exportSubmit("export_BZQ", "form_BZQ", "标准券");
	}
	<%-- 标准券查询结束!!! --%>
	
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
	
	//重置指令/建议信息
	function resetDire_CPJZ(){
		var form = new nui.Form("form_CPJZ");
		form.reset();
	}
	
	
</script>
</body>
</html>