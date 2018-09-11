<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<!-- 
  - Author(s): jiangkanqian
  - Date: 2018-08-10 13:29:15
  - Description:
-->
<head>
<title>排券表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
	<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>   
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_PQB" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="PQB">
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
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_PQB()"/>
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
            <%-- 标准券列表结束!!! --%>
</div>

<script type="text/javascript">
    nui.parse();
	
	function search_PQB(){
		nui.ajax({
 				url: "com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryPqb.biz.ext",
	            type: 'POST',
	            //data: instructJson,
	            cache: false,
	            contentType: 'text/json',
	            success: function (text) {
	            
	            }
	            
	   });
	   
	}
	
</script>
</body>
</html>