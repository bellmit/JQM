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
<title>综合信息查询</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
<script type="text/javascript" src="/ats/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div class="nui-tabs" id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">
		
		<%-- 业务类型标签页开始... --%>
		
		
		<div title="资金头寸">
		   <%-- 资金头寸查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_ZJTC" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="ZJTC">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="7%">
								基金名称:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vCFundCode_ZJTC" class="nui-buttonedit" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_ZJTC"/>
	                        </td>
	                        <td class="form_label" width="7%">
								资产单元:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vCAssetName_ZJTC" class="nui-textbox" name="paramObject/vCAssetName"/>
	                        </td>
	                        <td colspan="1" width="118px">
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_ZJTC()"/>
	                            &nbsp;
	                            <input id="export_ZJTC" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_ZJTC()"/>
	                        </td>
	                        <td style="width:100px;" align="right">
	                        	<span class="warn_red_bold">数据每 5 分钟自动刷新</span>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 资金头寸查询条件结束!!! --%>
		   
		   <%-- 资金头寸列表开始... --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_ZJTC"
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
                        <div field="VC_ASSET_NAME" headerAlign="center" allowSort="true" align="left" width="150px">
                            资产单元
                        </div>
                        <div field="T0ZLKY2" headerAlign="center" allowSort="true" align="right" width="150px">
			    不包含T+1变化的T+0可用
                        </div>
                        <div field="T0JYKY" headerAlign="center" allowSort="true" align="right" width="120px">
			  T+0交易可用
                        </div>
                        <div field="T1JYKY" headerAlign="center" allowSort="true" align="right" width="120px">
			  T+1交易可用
                        </div>
                        <div field="T0ZLKY" headerAlign="center" allowSort="true" align="right" width="120px">
			  T+0指令/建议可用
                        </div>
                        <div field="T1ZLKY" headerAlign="center" allowSort="true" align="right" width="120px">
			  T+1指令/建议可用
                        </div>
                        <div field="EN_BASIC_FROZEN_BALANCE" headerAlign="center" allowSort="true" align="right" width="120px">
                            交易保证金
                        </div>
                        <div field="EN_BEGIN_T0_ENABLE" headerAlign="center" allowSort="true" align="right" width="120px">
                            日初T+0可用金额
                        </div>
                        <div field="EN_BEGIN_T1_ENABLE" headerAlign="center" allowSort="true" align="right" width="120px">
                            日初T+1可用金额
                        </div>
                        <div field="EN_FUTURES_BALANCE" headerAlign="center" allowSort="true" align="right" width="120px">
                            期货保证金余额
                        </div>
                    </div>
                </div>
            </div>
            <%-- 资金头寸列表结束!!! --%>
		</div>
				
		
		
		
		<div title="交易所质押券">
		   <%-- 质押券查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_ZYQ" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="ZYQ">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="7%">
								基金名称:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vCFundCode_ZYQ" class="nui-buttonedit" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_ZYQ"/>
	                        </td>
	                        <td class="form_label" width="7%">
								组合名称:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vcCombiName_ZYQ" class="nui-textbox" name="paramObject/vcCombiName"/>
	                        </td>
	                        <td class="form_label" width="7%">
								股东代码:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vCStockholderId_ZYQ" class="nui-textbox" name="paramObject/vCStockholderId"/>
	                        </td>
	                     </tr>
	                     <tr>
	                        <td class="form_label" width="7%">
								证券代码:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vCReportCode_ZYQ" class="nui-textbox" name="paramObject/vCReportCode"/>
	                        </td>
	                        <td class="form_label" width="7%">
								证券名称:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vCStockName_ZYQ" class="nui-textbox" name="paramObject/vCStockName"/>
	                        </td>
	                        <td colspan="1" width="59px">
	                        </td>
	                        <td colspan="1" width="59px">
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_ZYQ()"/>
	                        	&nbsp;
	                            <input id="export_ZYQ" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_ZYQ()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 质押券查询条件结束!!! --%>
		   
		   <%-- 质押券列表开始... --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_ZYQ"
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
                        <div field="VC_STOCKHOLDER_ID" headerAlign="center" allowSort="true" align="center" width="120px">
                            股东代码
                        </div>
                        <div field="VC_REPORT_CODE" headerAlign="center" allowSort="true" align="center" width="75px">
                            证券代码
                        </div>
                        <div field="VC_STOCK_NAME" headerAlign="center" allowSort="true" align="left" width="120px">
                            证券名称
                        </div>
                        <div field="L_ENABLE_AMOUNT" headerAlign="center" allowSort="true" align="right" width="120px">
                            可质押数量
                        </div>
                        <div field="L_IMPAWN_AMOUNT" headerAlign="center" allowSort="true" align="right" width="120px">
                            已质押数量
                        </div>
                        <div field="L_AMOUNT" headerAlign="center" allowSort="true" align="right" width="120px">
                            持仓
                        </div>
                        <div field="L_RATIO" headerAlign="center" allowSort="true" align="right" width="120px">
                            抵押比率（%）
                        </div>
                        <div field="L_IMPAWNSTD_AMOUNT" headerAlign="center" allowSort="true" align="right" width="120px">
                            已转标准券数量
                        </div>
                        <div field="L_ENABLESTD_AMOUNT" headerAlign="center" allowSort="true" align="right" width="120px">
                            可转标准券数量
                        </div>
                    </div>
                </div>
            </div>
            <%-- 质押券列表结束!!! --%>
		</div>
		
		
		
		
		<div title="银行间质押券">
		   <%-- 银行间质押券查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_YHJZYQ" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="ZHCC">
				 	<%-- 查询子条件-交易市场代码 --%>
				 	<input class="nui-hidden" name="paramObject/cMarketNo" value="5">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="7%">
								业务日期:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="busiDateEnd_YHJZYQ" class="nui-datepicker" name="paramObject/busiDateEnd" width="100px" required="true"/>
	                        </td>
	                        <td class="form_label" width="7%">
								基金名称:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vCFundCode_YHJZYQ" class="nui-buttonedit" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_YHJZYQ"/>
	                        </td>
	                        <td class="form_label" width="7%">
								证券代码:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vCReportCode_YHJZYQ" class="nui-textbox" name="paramObject/vCReportCode"/>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td class="form_label" width="7%">
								证券名称:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vCStockName_YHJZYQ" class="nui-textbox" name="paramObject/vCStockName"/>
	                        </td>
	                        <td colspan="1" width="59px">
	                        </td>
	                        <td colspan="1" width="59px">
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_YHJZYQ()"/>
	                        	&nbsp;
	                            <input id="export_YHJZYQ" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_YHJZYQ()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 银行间质押券查询条件结束!!! --%>
		   
		   <%-- 银行间质押券列表开始... --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_YHJZYQ"
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
                        <div field="EN_QJ" headerAlign="center" allowSort="true" align="right" width="80px">
                            全价
                        </div>
                        <div field="EN_JJ" headerAlign="center" allowSort="true" align="right" width="80px">
                            净价
                        </div>
                        <div field="C_OUTER_APPRAISE" headerAlign="center" allowSort="true" align="center" width="80px">
                            外部评级
                        </div>
                        <div field="C_ISSUER_OUTER_APPRAISE" headerAlign="center" allowSort="true" align="center" width="100px">
                            发行人外部评级
                        </div>
                    </div>
                </div>
            </div>
            <%-- 银行间质押券列表结束!!! --%>
		</div>
		
		
		
		
		<div title="标准券">
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
                        sizeList="[10,20,50,100]">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div field="VC_FUND_CODE" headerAlign="center" allowSort="true" align="center" width="75px">
                            基金代码
                        </div>
                        <div field="VC_FUND_NAME" headerAlign="center" allowSort="true" align="left" width="150px">
                            基金名称
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
            <%-- 标准券列表结束!!! --%>
		</div>
		
		
		
		
		<div title="交易所回购">
		   <%-- 交易所回购查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_JYSHG" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="JYSHG">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                		<td class="form_label" width="10%">
								回购日期:
	                        </td>
	                        <td colspan="1" width="30%">
	                        	从<input id="busiDateBegin_JYSHG" class="nui-datepicker" name="paramObject/busiDateBegin" width="100px" required="false"/>
								到<input id="busiDateEnd_JYSHG" class="nui-datepicker" name="paramObject/busiDateEnd" width="100px" required="false"/>
	                        </td>
	                        <td class="form_label" width="7%">
								基金名称:
	                        </td>
	                        <td colspan="1" width="17%">
	                            <input id="vCFundCode_JYSHG" class="nui-buttonedit" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_JYSHG"/>
	                        </td>
	                        <td class="form_label" width="7%">
								组合名称:
	                        </td>
	                        <td colspan="1" width="17%">
	                            <input id="vcCombiName_JYSHG" class="nui-textbox" name="paramObject/vcCombiName"/>
	                        </td>
	                        <td colspan="1" width="59px">
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_JYSHG()"/>
	                        </td>
	                    </tr>
	                    <tr>
	                    	<td class="form_label" width="10%">
								实际购回日期:
	                        </td>
	                        <td colspan="1" width="30%">
	                        	从<input id="lRedeemLiquidateBegin_JYSHG" class="nui-datepicker" name="paramObject/lRedeemLiquidateBegin" width="100px" required="false"/>
								到<input id="lRedeemLiquidateEnd_JYSHG" class="nui-datepicker" name="paramObject/lRedeemLiquidateEnd" width="100px" required="false"/>
	                        </td>
	                        <td class="form_label" width="7%">
								回购代码:
	                        </td>
	                        <td colspan="1" width="17%">
	                            <input id="vCReportCode_JYSHG" class="nui-textbox" name="paramObject/vCReportCode"/>
	                        </td>
	                        <td class="form_label" width="7%">
								委托方向:
	                        </td>
	                        <td colspan="1" width="17%">
	                            <input id="vCEntrustdirName_JYSHG" class="nui-textbox" name="paramObject/vCEntrustdirName"/>
	                        </td>
	                        <td colspan="1" width="59px">
	                            <input id="export_JYSHG" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_JYSHG()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 交易所回购查询条件结束!!! --%>
		   
		   <%-- 交易所回购列表开始... --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_JYSHG"
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
                        <div field="L_HG_DATE" headerAlign="center" allowSort="true" align="center" width="75px">
                            回购日期
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
                            回购代码
                        </div>
                        <div field="VC_ENTRUSTDIR_NAME" headerAlign="center" allowSort="true" align="center" width="75px">
                            委托方向
                        </div>
                        <div field="L_DEAL_AMOUNT" headerAlign="center" allowSort="true" align="right" width="120px">
                            数量
                        </div>
                        <div field="EN_NET_ZJ" headerAlign="center" allowSort="true" align="right" width="120px">
                            净资金额
                        </div>
                        <div field="EN_INTEREST_RATE" headerAlign="center" allowSort="true" align="right" width="120px">
                            平均利率(%)
                        </div>
                        <div field="EN_PROFIT" headerAlign="center" allowSort="true" align="right" width="120px">
                            利润
                        </div>
                        <div field="L_REDEEM_LIQUIDATE" headerAlign="center" allowSort="true" align="center" width="85px">
                            实际购回日期
                        </div>
                        <div field="L_SETTLE_DATE" headerAlign="center" allowSort="true" align="center" width="85px">
                            购回交割日期
                        </div>
                        <div field="L_USE_DAYS" headerAlign="center" allowSort="true" align="center" width="85px">
                            实际占款天数
                        </div>
                    </div>
                </div>
            </div>
            <%-- 交易所回购列表结束!!! --%>
		</div>
		
		
		
		
		<div title="银行间回购">
		   <%-- 银行间回购查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_YHJHG" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="YHJHG">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="10%">
								回购日期:
	                        </td>
	                        <td colspan="1" width="30%">
	                        	从<input id="busiDateBegin_YHJHG" class="nui-datepicker" name="paramObject/busiDateBegin" width="100px" required="false"/>
								到<input id="busiDateEnd_YHJHG" class="nui-datepicker" name="paramObject/busiDateEnd" width="100px" required="false"/>
	                        </td>
	                        <td class="form_label" width="7%">
								基金名称:
	                        </td>
	                        <td colspan="1" width="17%">
	                            <input id="vCFundCode_YHJHG" class="nui-buttonedit" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_YHJHG"/>
	                        </td>
	                        <td class="form_label" width="7%">
								组合名称:
	                        </td>
	                        <td colspan="1" width="17%">
	                            <input id="vcCombiName_YHJHG" class="nui-textbox" name="paramObject/vcCombiName"/>
	                        </td>
	                        <td colspan="1" width="59px">
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_YHJHG()"/>
	                        </td>
	                    </tr>
	                    <tr>
	                    	<td class="form_label" width="10%">
								实际购回日期:
	                        </td>
	                        <td colspan="1" width="30%">
	                        	从<input id="lRedeemLiquidateBegin_YHJHG" class="nui-datepicker" name="paramObject/lRedeemLiquidateBegin" width="100px" required="false"/>
								到<input id="lRedeemLiquidateEnd_YHJHG" class="nui-datepicker" name="paramObject/lRedeemLiquidateEnd" width="100px" required="false"/>
	                        </td>
	                        <td class="form_label" width="7%">
								回购代码:
	                        </td>
	                        <td colspan="1" width="17%">
	                            <input id="vCReportCode_YHJHG" class="nui-textbox" name="paramObject/vCReportCode"/>
	                        </td>
	                        <td class="form_label" width="7%">
								委托方向:
	                        </td>
	                        <td colspan="1" width="17%">
	                            <input id="vCEntrustdirName_YHJHG" class="nui-textbox" name="paramObject/vCEntrustdirName"/>
	                        </td>
	                        <td colspan="1" width="59px">
	                            <input id="export_YHJHG" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_YHJHG()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 银行间回购查询条件结束!!! --%>
		   
		   <%-- 银行间回购列表开始... --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_YHJHG"
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
                        <div field="L_HG_DATE" headerAlign="center" allowSort="true" align="center" width="75px">
                            回购日期
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
                            回购代码
                        </div>
                        <div field="VC_ENTRUSTDIR_NAME" headerAlign="center" allowSort="true" align="center" width="75px">
                            委托方向
                        </div>
                        <div field="L_DEAL_AMOUNT" headerAlign="center" allowSort="true" align="right" width="120px">
                            数量
                        </div>
                        <div field="EN_NET_ZJ" headerAlign="center" allowSort="true" align="right" width="120px">
                            净资金额
                        </div>
                        <div field="EN_RET_ZJ" headerAlign="center" allowSort="true" align="right" width="120px">
                            返回金额
                        </div>
                        <div field="VC_RIVAL_NAME" headerAlign="center" allowSort="true" align="left" width="150px">
                            交易对手
                        </div>
                        <div field="EN_INTEREST_RATE" headerAlign="center" allowSort="true" align="right" width="80px">
                            平均利率(%)
                        </div>
                        <div field="EN_PROFIT" headerAlign="center" allowSort="true" align="right" width="120px">
                            利润
                        </div>
                        <div field="L_REDEEM_LAWDATE" headerAlign="center" allowSort="true" align="center" width="85px">
                            法定购回日期
                        </div>
                        <div field="L_REDEEM_LIQUIDATE" headerAlign="center" allowSort="true" align="center" width="85px">
                            实际购回日期
                        </div>
                        <div field="L_SETTLE_DATE" headerAlign="center" allowSort="true" align="center" width="85px">
                            购回交割日期
                        </div>
                        <div field="C_STOCK_TYPE" headerAlign="center" allowSort="true" align="center" width="75px">
                            证券类别
                        </div>
                        <div field="VC_REAL_CODE" headerAlign="center" allowSort="true" align="center" width="85px">
                            实际回购代码
                        </div>
                        <div field="C_TRUSTEE" headerAlign="center" allowSort="true" align="center" width="85px">
                            托管机构
                        </div>
                    </div>
                </div>
            </div>
            <%-- 银行间回购列表结束!!! --%>
		</div>
		
		
		
		
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
	                            <input id="busiDateEnd_ZHCC" class="nui-datepicker" name="paramObject/busiDateEnd" width="100px" required="true"/>
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
                        frozenStartColumn="0"
                        frozenEndColumn="3"
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
                        <div field="VC_INTER_CODE" headerAlign="center" visible="false">
                            证券内码
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
                            债券兑付日
                        </div>
                        <!-- 万得BBQ产品下架了 -->
                        <!-- 
                        <div field="RT_YIELD" headerAlign="center" allowSort="true" align="right">
                            成交价
                        </div>
                        <div field="RT_ASKYIELD" headerAlign="center" allowSort="true" align="right">
                            卖出收益价
                        </div>
                        <div field="RT_BIDYIELD" headerAlign="center" allowSort="true" align="right">
                            买入收益价
                        </div>
                        -->
                    </div>
                </div>
            </div>
            <%-- 组合持仓列表结束!!! --%>
		</div>
		
		<div title="产品净值">
		   <%--产品净值查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_CPJZ" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="CPJZ">
	               <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                		<td class="form_label" width="35px">
								日期:
	                        </td>
	                        <td colspan="1" width="40%">
	                        	从<input id="lDateBegin_CPYHJ" class="nui-datepicker" name="paramObject/lDateBegin" width="100px" required="false"/>
								到<input id="lDateEnd_CPYHJ" class="nui-datepicker" name="paramObject/lDateEnd" width="100px" required="false"/>
	                        </td>
	                        <td class="form_label" width="60px">
								基金名称:
	                        </td>
	                        <td colspan="2" width="30%">
	                            <input id="vcFundCode_CPJZ" class="nui-buttonedit" name="paramObject/vcFundCode" onbuttonclick="ButtonClickGetFundName_CPJZ"/>
	                        </td>
	                        <td colspan="2" width="20%">
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_CPJZ()"/>
	                        	<input class='nui-button' plain='false' text="重置" iconCls="icon-cancel"  onclick="resetDire_CPJZ()"/>
	                        	&nbsp;
	                            <input id="export_CPJZ" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_CPJZ()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 产品净值查询条件结束!!! --%>
             <%-- 产品净值开始... --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_CPJZ"
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
                        <div field="L_DATE" renderer="dateRen" headerAlign="center" allowSort="true" align="center" width="20%">
                           统计日期
                        </div>
                        <div field="VC_FUND_NAME" headerAlign="center" allowSort="true" align="left" width="20%">
                            基金名称
                        </div>
                        <div field="EN_FUND_VALUE" headerAlign="center" allowSort="true" align="right" width="20%">
                           净值
                        </div>
                        <div field="EN_NAV" headerAlign="center" allowSort="true" align="right" width="20%">
                           单位净值
                        </div>
                        <div field="EN_TOTAL_NAV" headerAlign="center" allowSort="true"  align="right" width="20%">
                           累计单位净值
                        </div>
                    </div>
                </div>
            </div>
            <%-- 产品净值结束!!! --%>
		</div>
		
		<%-- 业务类型标签页结束!!! --%>
	</div>
</div>

<script type="text/javascript">
    nui.parse();
    var grid_ZJTC = nui.get("datagrid_ZJTC");//资金头寸
    var grid_ZYQ = nui.get("datagrid_ZYQ");//质押券
    var grid_YHJZYQ = nui.get("datagrid_YHJZYQ");//银行间质押券
    var grid_BZQ = nui.get("datagrid_BZQ");//标准券
    var grid_JYSHG = nui.get("datagrid_JYSHG");//交易所回购
    var grid_YHJHG = nui.get("datagrid_YHJHG");//银行间回购
    var grid_ZHCC = nui.get("datagrid_ZHCC");//组合持仓
    var grid_CPJZ = nui.get("datagrid_CPJZ");//产品净值
    
    var refreshInt = true;//刚刚打开页面时，投顾默认刷新，交易员默认不刷新
    var queryUserTypeTemp = "<%=request.getParameter("queryUserType")%>";
	if(queryUserTypeTemp!=null && queryUserTypeTemp!="" && queryUserTypeTemp!="null"){
		refreshInt = false;
	}
    
    //初始化查询条件业务日期值为当天
    var date = new Date();
    nui.get("busiDateEnd_YHJZYQ").setValue(date);
    nui.get("busiDateEnd_ZHCC").setValue(date);
    
    //tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	function activechangedFun(){
		if(refreshInt==false){
			return;
		}
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tab").getActiveTab().title;
		if(activeTabTitle=="资金头寸"){
			search_ZJTC();
		}else if(activeTabTitle=="交易所质押券"){
			search_ZYQ();
		}else if(activeTabTitle=="银行间质押券"){
			search_YHJZYQ();
		}else if(activeTabTitle=="标准券"){
			search_BZQ();
		}else if(activeTabTitle=="交易所回购"){
			search_JYSHG();
		}else if(activeTabTitle=="银行间回购"){
			search_YHJHG();
		}else if(activeTabTitle=="产品持仓明细"){
			search_ZHCC();
		}else if(activeTabTitle=="产品净值"){
			search_CPJZ();
		}
	}
	
	//系统自动刷新页面--所有业务通用
    function autoRefreshFun(){
    	refreshInt = true;//打开页面之后设置值为true
    	activechangedFun();//同时刷新查询列表数据
    }
    self.setInterval("autoRefreshFun()",60000*5);//设置自动刷新时间默认5分钟
	
    
    
    
    
    <%-- 资金头寸查询开始... --%>
	//查询
	function search_ZJTC() {
		search(grid_ZJTC, "#form_ZJTC");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_ZJTC(e){
        ButtonClickGetFundName(this, null);
	}
	//导出
	function export_ZJTC(){
		exportSubmit("export_ZJTC", "form_ZJTC", nui.get("tab").getActiveTab().title);
	}
	<%-- 资金头寸查询结束!!! --%>
	
	
	
	<%-- 质押券查询开始... --%>
	//查询
	function search_ZYQ() {
		search(grid_ZYQ, "#form_ZYQ");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_ZYQ(e){
        ButtonClickGetFundName(this);
	}
	//导出
	function export_ZYQ(){
		exportSubmit("export_ZYQ", "form_ZYQ", nui.get("tab").getActiveTab().title);
	}
	<%-- 质押券查询结束!!! --%>
	
	
	
	<%-- 银行间质押券查询开始... --%>
	//查询
	function search_YHJZYQ() {
		search(grid_YHJZYQ, "#form_YHJZYQ");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_YHJZYQ(e){
        ButtonClickGetFundName(this);
	}
	//导出
	function export_YHJZYQ(){
		exportSubmit("export_YHJZYQ", "form_YHJZYQ", nui.get("tab").getActiveTab().title);
	}
	<%-- 银行间质押券查询结束!!! --%>
	
	
	
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
		exportSubmit("export_BZQ", "form_BZQ", nui.get("tab").getActiveTab().title);
	}
	<%-- 标准券查询结束!!! --%>
	
	
	
	<%-- 交易所回购查询开始... --%>
	//查询
	function search_JYSHG() {
		search(grid_JYSHG, "#form_JYSHG");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_JYSHG(e){
        ButtonClickGetFundName(this);
	}
	//表格行增加样式
	grid_JYSHG.on("drawcell", function (e) {
    	var record = e.record;
    	var dateStr = nui.formatDate(date,"yyyyMMdd");
		//设置行样式，当“法定购回日期”或“实际购回日期”或“购回交割日期”等于当天时，记录字体红色
		if(dateStr==record.L_REDEEM_LIQUIDATE || dateStr==record.L_SETTLE_DATE){
			e.rowCls = "warn_red";
		}
	});
	//导出
	function export_JYSHG(){
		exportSubmit("export_JYSHG", "form_JYSHG", nui.get("tab").getActiveTab().title);
	}
	<%-- 交易所回购查询结束!!! --%>
	
	
	
	<%-- 银行间回购查询开始... --%>
	//查询
	function search_YHJHG() {
		search(grid_YHJHG, "#form_YHJHG");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_YHJHG(e){
        ButtonClickGetFundName(this);
	}
	//表格行增加样式
	grid_YHJHG.on("drawcell", function (e) {
    	var record = e.record;
    	var dateStr = nui.formatDate(date,"yyyyMMdd");
		//设置行样式，当“法定购回日期”或“实际购回日期”或“购回交割日期”等于当天时，记录字体红色
		if(dateStr==record.L_REDEEM_LAWDATE || dateStr==record.L_REDEEM_LIQUIDATE || dateStr==record.L_SETTLE_DATE){
			e.rowCls = "warn_red";
		}
	});
	//行双击时弹出页面展示银行间回购明细表
    grid_YHJHG.on("rowdblclick", function (e) {
    	rowdblclickFun("CFJY_zhxxcx_yhjhg_detail.jsp", "银行间回购明细表", 710, 300, e, grid_YHJHG);
    });
    //导出
	function export_YHJHG(){
		exportSubmit("export_YHJHG", "form_YHJHG", nui.get("tab").getActiveTab().title);
	}
	<%-- 银行间回购查询结束!!! --%>
	
    
    
    <%-- 组合持仓查询开始... --%>
	//查询
	function search_ZHCC() {
		search(grid_ZHCC, "#form_ZHCC");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_ZHCC(e){
        ButtonClickGetFundName(this);
	}
	//表格行增加样式
	grid_ZHCC.on("drawcell", function (e) {
    	var record = e.record;
    	var dateStr = nui.formatDate(date,"yyyyMMdd");
		//设置行样式，当“债券摘牌日”或“债券兑付日”等于当天时，记录字体红色
		if(dateStr==record.ZPR || dateStr==record.DQR){
			e.rowCls = "warn_red";
		}
	});
	//导出
	function export_ZHCC(){
		exportSubmit("export_ZHCC", "form_ZHCC", nui.get("tab").getActiveTab().title);
	}
	//行双击时弹出页面展示万得BBQ实时行情--万得BBQ产品下架了
    //grid_ZHCC.on("rowdblclick", function (e) {
    //	var row = e.record;
    //	rowdblclickFun("CFJY_zhxxcx_zhcc_wind_bbq_hq.jsp", row.VC_REPORT_CODE + "-" + row.VC_STOCK_NAME + "  万得BBQ实时行情", 800, 300, e, grid_ZHCC);
    //});
	<%-- 组合持仓查询结束!!! --%>
	
	
	
	<%-- 产品净值查询开始... --%>
	//查询
	function search_CPJZ() {
		search(grid_CPJZ, "#form_CPJZ");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_CPJZ(e){
        ButtonClickGetFundName(this);
	}
	//导出
	function export_CPJZ(){
		exportSubmit("export_CPJZ", "form_CPJZ", nui.get("tab").getActiveTab().title);
	}
	<%-- 产品净值查询结束!!! --%>
	
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