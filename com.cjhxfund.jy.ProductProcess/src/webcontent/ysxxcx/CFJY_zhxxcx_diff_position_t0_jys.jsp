<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String preDate = DateUtil.getCalculateTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null, 0);
%>
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<!-- 
  - Author(s): chendi
  - Date: 2017-05-16 14:37:20
  - Description:
-->
<head>
<title>银行间可用质押券明细表</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheetet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">
	   <%-- 银行间可用质押券明细表查询条件开始... --%>
	   <div class="search-condition">
		   <div class="list">
			 <form id="form_T0JYS" method="post">
			 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
			 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
			 	<%-- 查询类型 --%>
			 	<input class="nui-hidden" name="paramObject/queryType" value="T0JYS">
			 	<%-- 筛选查询类型 --%>
			 	<input id="exclusivelyShowSection" class="nui-hidden"  name="paramObject/exclusivelyShowSection" value="N">
                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
                	<tr>
                        <td class="form_label" width="60px" align="right">
							基金名称:
                        </td>
                        <td colspan="1" width="15%" align="left">
                            <input id="vCFundCode_T0JYS" class="nui-buttonedit" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_T0JYS"/>
                        	<%-- 设置默认的债券基本信息表当前业务日期 --%>
                        	<input id="preDate_T0JYS" class="nui-hidden" name="paramObject/preDate" />
                        </td>
                        <td class="form_label" width="60px" align="right">
							债券代码:
                        </td>
                        <td colspan="1" width="15%" align="left">
                            <input id="vCReportCode_T0JYS" class="nui-textbox" name="paramObject/vCReportCode"/>
                        </td>
                        <td class="form_label" width="60px" align="right">
							债券名称:
                        </td>
                        <td colspan="1" width="15%" align="left">
                            <input id="vCStockName_T0JYS" class="nui-textbox" name="paramObject/vCStockName"/>
                        </td>
                        <td align="right" colspan="10">
                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_T0JYS(true)"/>
                            <input class='nui-button' plain='false' text="重置" iconCls="icon-cancel"  onclick="resetDire_T0JYS()"/>
							<input class='nui-button' plain='false' id="export_T0JYS" text="导出" iconCls="icon-download" onclick="export_T0JYS()"/>
                        </td>
                        <td style="width:130px;" align="right">
                        	<span class="warn_red_bold">数据每 3分钟自动刷新</span>
                        </td>
                    </tr>
				</table>
			</form>
		  </div>
	   </div>
	   <%-- 银行间可用质押券明细表查询条件结束!!! --%>
	   
	   <%-- 银行间可用质押券明细表列表开始... --%>
       <div class="nui-fit">
            <div 
                    id="datagrid_T0JYS"
                    dataField="resultObjectList"
                    class="nui-datagrid"
                    style="width:100%;height:100%;"
                    url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.QueryTCXX.biz.ext"
                        pageSize="100"
                       	showPageInfo="true"
                        allowSortColumn="true"
                        sortMode="client"
                        enableHotTrack="true"
                        allowHeaderWrap="true"
                        sizeList="[50,100,500,1000]"
                        allowCellEdit="true"
						allowCellSelect="true"
						enterNextCell="true"
						allowMoveColumn="true"
						editNextOnEnterKey="true"
						multiSelect="true"   showfooter="false" >
                    <div property="columns">
                        <div type="indexcolumn" width="40px">序号</div>
		                <div field="VC_FUND_NAME" name="VC_FUND_NAME" headerAlign="center" allowSort="true" align="left" width="200px">
            	  基金名称
		                </div>
		                <div field="VC_REPORT_CODE" name="VC_REPORT_CODE" headerAlign="center" allowSort="true" align="left" width="100px">
            	  债券代码
		                </div>
		                <div field="VC_STOCK_NAME" name="VC_STOCK_NAME" headerAlign="center" allowSort="true" align="left" width="130px">
            	  债券名称
		                </div>
		               	<div field="VC_MARKET_NO" name="VC_MARKET_NO" headerAlign="center" allowSort="true" align="left" width="80px">
            	  交易市场
		                </div>
                        <div field="C_BOND_RATING" name="C_BOND_RATING" headerAlign="center" allowSort="true" align="left" width="80px">
            	  债项评级
		                </div>
		                <div field="C_SUBJECT_RATING" name="C_SUBJECT_RATING" headerAlign="center" allowSort="true" align="left" width="80px">
            	  主体评级      
		                </div>
		                <div field="L_SALE_AMOUNT_COUNT" name="L_SALE_AMOUNT_COUNT" headerAlign="center" align="right" width="120px">
	  			  可用总数量       
                        </div>
                        <div field="L_SALE_AMOUNT" name="L_SALE_AMOUNT" dataType="currency" headerAlign="center" align="right" width="120px">
	  			  可用数量       
                        </div>
                        <div field="C_ISSUER_TYPE" name="C_ISSUER_TYPE" headerAlign="center" allowSort="true" align="left" width="120px">
            	  企业性质
		                </div>
		                <div field="VC_BOND_TYPE_WIND_FIRST" name="VC_BOND_TYPE_WIND_FIRST" headerAlign="center" allowSort="true" align="left" width="120px">
            	 Wind一级债券类型
		                </div>
		                <div field="VC_BOND_TYPE_WIND_SECOND" name="VC_BOND_TYPE_WIND_SECOND" headerAlign="center" allowSort="true" align="left" width="120px">
            	 Wind二级债券类型
		                </div>
		                <div field="L_FUND_ID"  name="L_FUND_ID"  headeralign="center" allowsort="true" align="left" width="50px">
		                          基金ID
		                </div>
		                <div field="VC_FUND_CODE" name="VC_FUND_CODE" headerAlign="center" allowSort="true" align="left" width="100px">
            	  基金代码
		                </div>
                </div>
            </div>
        </div>
        <%-- T0交易所可用质押券明细表结束!!! --%>
	</div>
</div>	

<script type="text/javascript">
	nui.parse();
	var havingAlert = false;
	//设置默认时间
	var preDate = "<%=preDate%>";
	nui.get("preDate_T0JYS").setValue(preDate);
	
	var grid_T0JYS = nui.get("datagrid_T0JYS");//T0交易所可用质押券明细表
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
		    search_T0JYS();
	}
	
	//系统自动刷新页面--所有业务通用
    function autoRefreshFun(){
    	refreshInt = true;//打开页面之后设置值为true
    	activechangedFun();//同时刷新查询列表数据
    }
    self.setInterval("autoRefreshFun()",60000*3);//设置自动刷新时间默认5分钟
	
	
	
	<%-- 当日T+0头寸差额开始... --%>
	//查询
	function search_T0JYS(flag){
		havingAlert = flag;
		nui.get("exclusivelyShowSection").setValue("1");
		search(grid_T0JYS, "#form_T0JYS");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_T0JYS(e){
        ButtonClickGetFundName(this, null);
	}
    //行双击时弹出页面展示该指令详细信息
	grid_T0JYS.on("rowdblclick", function (e) {
		rowdblclickFun("CFJY_tcxxcx_T0JYS_detail.jsp", "当日T+0头寸差额-交易所非担保交易债券明细", 710, 400, e, grid_T0JYS);
	});
	//合并单元格
	grid_T0JYS.on("load", function () {
		var length = grid_T0JYS.data.length;
		var datas = grid_T0JYS.data;
    	if(length == 0 ){
    		if(havingAlert){
    			nui.alert("没有符合筛选的数据！");
    		}
    	}else{
    		for(var i=0;i<length;i++){
    			var count = 0.00;
				for(var k=0;k<length;k++){
					if(datas[k].L_FUND_ID == datas[i].L_FUND_ID){
						//将千分位去掉之后再将其转化为浮点数然后计算可用数量总数
						count +=parseFloat(datas[k].L_SALE_AMOUNT);
					}
				}
				datas[i].L_SALE_AMOUNT_COUNT = formatNumber(count,2,1);
			}
	    	grid_T0JYS.mergeColumns(["L_FUND_ID","VC_FUND_CODE","VC_FUND_NAME","L_SALE_AMOUNT_COUNT"]);
    	}
    	havingAlert = false;
    });
    /** 
     * 逆序每隔3位添加一个逗号 
     * @param "31232" 
     * @return "31,232" 
     */  
    function f(n){  
       var b=parseInt(n).toString();  
       var len=b.length;
       if(len<=3){return b;}
       var r=len%3;  
       return r>0?b.slice(0,r)+","+b.slice(r,len).match(/\d{3}/g).join(","):b.slice(r,len).match(/\d{3}/g).join(",");  
	}
    //重置指令信息
	function resetDire_T0JYS(){
		var form = new nui.Form("form_T0JYS");
		form.reset();
	}
	//导出
	function export_T0JYS(){
	    exportSubmit("export_T0JYS", "form_T0JYS", "当日T+0头寸差额-交易所非担保交易债券明细","TCXXCX");
	}
	<%-- 当日T+0头寸差额结束!!! --%>
</script>
</body>
</html>