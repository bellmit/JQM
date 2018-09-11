<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2016-06-01 08:35:39
- Description: 综合信息查询-债券摘牌日提醒
--%>
<head>
<title>综合信息查询-债券摘牌日提醒</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div class="nui-tabs" id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">
		
		<div title="产品持仓明细">
		   <%-- 组合持仓查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_ZHCC" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="ZHCCExtend">
				 	<%-- 查询子条件-交易市场代码 --%>
				 	<input class="nui-hidden" name="paramObject/cMarketNo" value="">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="7%">
								业务日期:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="busiDateEnd_ZHCC"  class="nui-datepicker" name="paramObject/busiDateEnd"  required="true"/>
	                        </td>
	                        <td class="form_label" width="7%">
								基金名称:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vCFundCode_ZHCC" class="nui-buttonedit" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_ZHCC"/>
	                        </td>
	                        <td class="form_label" width="7%">
								证券代码:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vCReportCode_ZHCC" class="nui-textbox" name="paramObject/vCReportCode"/>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="form_label" width="7%">
								证券名称:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vCStockName_ZHCC" class="nui-textbox" name="paramObject/vCStockName"/>
	                        </td>
	                        <td class="form_label" width="7%">
								交易市场:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="cMarketName_ZHCC" class="nui-textbox" name="paramObject/cMarketName"/>
	                        </td>
	                        <td colspan="1" width="59px">
	                        </td>
	                        <td colspan="1" width="59px">
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_ZHCC()"/>
	                        	&nbsp;
	                            <input id="export_ZHCC" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_ZHCC()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 组合持仓查询条件结束!!! --%>
		   
		   <%-- 组合持仓列表开始... --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_ZHCC"
                        dataField="resultObjectList"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryZHXX.biz.ext"
                        pageSize="50"
                        showPageInfo="true"
                        allowSortColumn="true"
                        sortMode="client"
                        enableHotTrack="true"
                        sizeList="[10,20,50,100]">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div field="L_DATE" headerAlign="center" allowSort="true" align="center" width="75px">
                            日期
                        </div>
                        <div field="VC_FUND_CODE" headerAlign="center" allowSort="true" align="center" width="75px">
                            基金代码
                        </div>
                        <div field="VC_FUND_NAME" headerAlign="center" allowSort="true" align="left" width="150px">
                            基金名称
                        </div>
                        <div field="VC_COMBI_NAME" headerAlign="center" allowSort="true" align="left" width="100px">
                            组合名称
                        </div>
                        <div field="VC_REPORT_CODE" headerAlign="center" allowSort="true" align="center" width="75px">
                            证券代码
                        </div>
                        <div field="VC_STOCK_NAME" headerAlign="center" allowSort="true" align="left" width="120px">
                            证券名称
                        </div>
                        <div field="VC_MARKET_NAME" headerAlign="center" allowSort="true" align="center" width="75px">
                            交易市场
                        </div>
                        <div field="L_CURRENT_AMOUNT" headerAlign="center" allowSort="true" align="right"width="120px">
                            持仓
                        </div>
                        <div field="L_USABLE_AMOUNT" headerAlign="center" allowSort="true" align="right"width="120px">
                            可用数量
                        </div>
                        <div field="L_FROZEN_AMOUNT" headerAlign="center" allowSort="true" align="right" width="120px">
                            冻结数量
                        </div>
                        <div field="EN_QJ" headerAlign="center" allowSort="true" align="right" width="80px">
                            全价
                        </div>
                        <div field="EN_JJ" headerAlign="center" allowSort="true" align="right" width="80px">
                            净价
                        </div>
                        <div field="EN_BEGIN_COST_PRICE" headerAlign="center" allowSort="true" align="right" width="80px">
                            成本价
                        </div>
                        <div field="D_QJCB" headerAlign="center" allowSort="true" align="right" width="120px">
                            全价成本
                        </div>
                        <div field="D_QJSZ" headerAlign="center" allowSort="true" align="right" width="120px">
                            全价市值
                        </div>
                        <div field="D_QJFY" headerAlign="center" allowSort="true" align="right" width="120px">
                            全价浮盈
                        </div>
                        <div field="C_OUTER_APPRAISE" headerAlign="center" allowSort="true" align="center" width="80px">
                            外部评级
                        </div>
                        <div field="C_ISSUER_OUTER_APPRAISE" headerAlign="center" allowSort="true" align="center" width="100px">
                            发行人外部评级
                        </div>
                        <div field="ZPR" headerAlign="center" allowSort="true" align="center" width="100px">
                            债券摘牌日
                        </div>
                        <div field="DQR" headerAlign="center" allowSort="true" align="center" width="100px">
                           债券到期日
                        </div>
                    </div>
                </div>
            </div>
            <%-- 组合持仓列表结束!!! --%>
		</div>

		<%-- 业务类型标签页结束!!! --%>
	</div>
</div>

<script type="text/javascript">
    nui.parse();
    var grid_ZHCC = nui.get("datagrid_ZHCC");//债券摘牌日提醒
    
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
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tab").getActiveTab().title;
		if(activeTabTitle=="债券摘牌日提醒"){
			search_ZHCC();
		}
	}
	
	//系统自动刷新页面--所有业务通用
    function autoRefreshFun(){
    	refreshInt = true;//打开页面之后设置值为true
    	activechangedFun();//同时刷新查询列表数据
    }
    self.setInterval("autoRefreshFun()",60000*5);//设置自动刷新时间默认5分钟
	
	//查询--所有业务通用
	function search(grid_search, form_id) {
	    var form = new nui.Form(form_id);
	    form.validate();
		if(form.isValid()==false) return;
	    var json = form.getData(false,false);
	    grid_search.load(json);//grid查询
	}
    
    
    <%-- 债券摘牌日提醒查询开始... --%>
    //设置日期
    nui.get("busiDateEnd_ZHCC").setValue(new Date());
	//查询
	function search_ZHCC() {
		search(grid_ZHCC, "#form_ZHCC");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_ZHCC(e){
        ButtonClickGetFundName(this, null);
	}
	//表格行增加样式
	grid_ZHCC.on("drawcell", function (e) {
    	var record = e.record;
		var OUTPUT1 = record.OUTPUT1;//重点提示
		var OUTPUT2 = record.OUTPUT2;//头寸现状
		//设置行样式
		if((OUTPUT2!=null&&OUTPUT2.indexOf("未平")!=-1) || (OUTPUT1!=null&&OUTPUT1!="")){
			e.rowCls = "warn_red";
		}
	});
	<%-- 债券摘牌日提醒查询结束!!! --%>
	
	
	
	
	//全屏显示
	function fullScreen(){
		window.open('<%=request.getContextPath()%>/ProductProcess/zhxxcx/CFJY_zhxxcx_tz.jsp?queryUserType=<%=request.getParameter("queryUserType")%>','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
</script>
</body>
</html>

