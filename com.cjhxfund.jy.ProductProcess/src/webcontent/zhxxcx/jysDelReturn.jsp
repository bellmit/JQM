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
	                		<td style="width:80px" align="right">
								业务日期:
	                        </td>
	                        <td style="width:25%" align="left" colspan="1">
	                        	<input id="lDateBegin_CPJYS" class="nui-datepicker" name="paramObject/lDateBegin" width="100%" onvaluechanged="lDateBeginFun" readonly="readonly"/>
	                        </td>
	                        <td style="width:60px" align="center">至</td>
	                        <td style="width:25%" align="left">
								<input id="lDateEnd_CPJYS" class="nui-datepicker" name="paramObject/lDateEnd" width="100%" onvaluechanged="lDateEndFun" readonly="readonly"/>
	                        </td>
	                        <td style="width:60px" align="right">
								产品名称:
	                        </td>
	                        <td style="width:25%" align="left">
	                            <input id="vcFundName_CPJYS" class="nui-buttonedit" name="paramObject/vcFundCode" width="100%" onbuttonclick="ButtonClickGetFundName_CPJYS"/>
	                        </td>
	                        <td style="width:60px" align="right">
								业务类型:
	                        </td>
	                        <td style="width:25%" align="left" colspan="1">
	                            <input id="cBusinClassName_CPJYS" class="nui-textbox" width="100%" name="paramObject/cBusinClassName"/>
	                        </td>
	                    </tr>
	                    <tr>
	                    	<td style="width:80px" align="right">
								债券代码:
	                        </td>
	                        <td style="width:25%" align="left" colspan="1">
	                            <input id="vcReportCode_CPJYS" class="nui-textbox" width="100%" name="paramObject/vcReportCode"/>
	                        </td>
	                        <td style="width:60px" align="right">
								债券名称:
	                        </td>
	                        <td style="width:25%" align="left">
	                            <input id="vcStockName_CPJYS" class="nui-textbox" width="100%" name="paramObject/vcStockName"/>
	                        </td>
	                        
	                        <td style="width:60px" align="right">
								委托方向:
	                        </td>
	                        <td style="width:25%" align="left" colspan="1">
	                            <input id="vcEntrustdirName_CPJYS" class="nui-textbox" width="100%" name="paramObject/vcEntrustdirName"/>
	                        </td>
	                        <td colspan="4" >
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
                        sizeList="[20,50,100,500,1000]">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        
                        <div field="L_DATE" renderer="dateRen" headerAlign="center" allowSort="true" align="center" width="75px">
                            业务日期
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
                        <div field="VC_STOCK_NAME" headerAlign="center" allowSort="true"  align="left" width="120px">
                            债券名称
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

<script type="text/javascript">
    nui.parse();
    var grid_CPJYS = nui.get("datagrid_CPJYS");//产品交易流水-交易所
	nui.get("lDateBegin_CPJYS").setValue(new Date());//设置默认日期-交易所成交回报-起始日期
	nui.get("lDateEnd_CPJYS").setValue(new Date());//设置默认日期-交易所成交回报-截止日期
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
			search_CPJYS();
	}
	
	//系统自动刷新页面--所有业务通用
    function autoRefreshFun(){
    	refreshInt = true;//打开页面之后设置值为true
    	activechangedFun();//同时刷新查询列表数据
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
		nui.get("lDateBegin_CPJYS").setValue(new Date());
		nui.get("lDateEnd_CPJYS").setValue(new Date());
	}
	
	//取昨天的日期
	var yesDate = GetDateStr(-1);
	function GetDateStr(AddDayCount) {
		var dd = new Date();
		dd.setDate(dd.getDate()+AddDayCount);
		return dd;
	} 

	//时间判断
	function lDateBeginFun(){
		var lDateBegin_CPJYS = DateUtil.toNumStr(nui.get("lDateBegin_CPJYS").getValue());
		var lDateEnd_CPJYS = DateUtil.toNumStr(nui.get("lDateEnd_CPJYS").getValue());
		var toDay = DateUtil.toNumStr(new Date());
		if(null != lDateBegin_CPJYS && null !=lDateEnd_CPJYS ){
			if(lDateBegin_CPJYS > lDateEnd_CPJYS){
				nui.alert("起始日期不能大于截止日期！","提示");
				//日期校验
				nui.get("lDateBegin_CPJYS").setValue(new Date());
				nui.get("lDateEnd_CPJYS").setValue(new Date());
				return;
			}
			if(lDateBegin_CPJYS > toDay || lDateEnd_CPJYS > toDay){
				nui.alert("仅能查询当天或历史的交易流水！","提示");
				nui.get("lDateEnd_CPJYS").setValue("yesDate");
				return;
			}
			if(toDay == lDateEnd_CPJYS && toDay != lDateBegin_CPJYS){
				nui.alert("仅能查询当天或历史的交易流水！","提示");
				//查询历史数据时，如果日期包含了当天，则不允许查询，设置默认值为昨天
				nui.get("lDateEnd_CPJYS").setValue("yesDate");
				return;
			}
		}
	}
	
	//时间判断
	function lDateEndFun(){
		var lDateBegin_CPJYS = DateUtil.toNumStr(nui.get("lDateBegin_CPJYS").getValue());
		var lDateEnd_CPJYS = DateUtil.toNumStr(nui.get("lDateEnd_CPJYS").getValue());
		var toDay = DateUtil.toNumStr(new Date());
		if(lDateEnd_CPJYS < lDateBegin_CPJYS){
			//起始时间不能大于截止时间
			nui.get("lDateBegin_CPJYS").setValue(lDateEnd_CPJYS);
		}
		if(lDateBegin_CPJYS > toDay || lDateEnd_CPJYS > toDay){
			nui.alert("仅能查询当天或历史的交易流水！","提示");
			nui.get("lDateEnd_CPJYS").setValue("yesDate");
			return;
		}
		if(toDay == lDateEnd_CPJYS && toDay != lDateBegin_CPJYS){
			nui.alert("仅能查询当天或历史的交易流水！","提示");
			//查询历史数据时，如果日期包含了当天，则不允许查询，设置默认值为昨天
			nui.get("lDateEnd_CPJYS").setValue("yesDate");
			return;
		}
	}
	<%-- 产品交易流水-交易所查询结束!!! --%>

	
</script>
</body>
</html>