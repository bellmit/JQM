<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String preDateOne = DateUtil.getCalculateTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null, 0);
%>
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<!-- 
  - Author(s): chendi
  - Date: 2017-06-12 09:19:14
  - Description:
-->
<head>
<title>追加提取和期货保障金明细</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheetet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
<script src="<%= request.getContextPath() %>/ProductProcess/cashFlow/cashFlow_common.js" type="text/javascript"></script>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div style="width:100%;height:100%;">
		   <%-- 追加提取和期货保障金明细查询条件开始... --%>
		   <div class="search-condition" >
			   <div class="list">
				 <form id="form_fifth_detail" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" id="queryType" name="paramObject/queryType" value="FIFTH_DETAIL_XJL">
				 	<%-- 单元编号(必传) --%>
				 	<input id="lAssetId" class="nui-hidden" name="paramObject/lAssetId">
					<%-- 交收日期(必传) --%>
					<input id="lSettleDate" class="nui-hidden" name="paramObject/lSettleDate">
					<!-- 非投资类业务类型 -->
					<input id="businType" class="nui-hidden" name="paramObject/businType">
					<%-- 列名称 --%>
					<input id="colType" class="nui-hidden" name="paramObject/colType">
					<%-- 明细类型 --%>
					<input id="type" class="nui-hidden" name="paramObject/type">
					<table id="table_first_detail" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="30%" align="left">
								</td>
								<td width="40%" align="center">
									<span id="productInfo" style="width:100%;"></span>
								</td>
				                <td width="30%" align="right">
				                	<input class='nui-button' plain='false' id="export_fifth_detail" text="导出" iconCls="icon-download" onclick="export_fifth_detail()"/>
				                </td>
                		</tr>
								</table>
				</form>
			  </div>
		   </div>
		   <%-- 第二个详情列表查询条件结束!!! --%>
		   
		   <%--追加提取和期货保障金明细开始... --%>
       <div class="nui-fit">
       		<div  id="datagrid_fifth_detail"
                dataField="resultObjectList"
                class="nui-datagrid"
                style="width:100%;height:100%;"
                url="com.cjhxfund.jy.ProductProcess.CashFlow.cashflowDetail.biz.ext"
                pageSize="10"
               	showPageInfo="true"
                allowSortColumn="true"
                sortMode="client"
                enableHotTrack="true"
                allowHeaderWrap="true"
                sizeList="[10,20,50]"
                allowCellEdit="true"
				allowCellSelect="true"
				enterNextCell="true"
				allowMoveColumn="true"
				editNextOnEnterKey="true"
				multiSelect="true"   
				showfooter="false">
			<div property="columns">
         		<div type="indexcolumn" width="40px">序号</div>
	                <div field="fundName" headerAlign="center" allowSort="true" align="left" width="180px" visible="false">
	        				产品名称
	                </div>
	                <div field="assetName" headerAlign="center" allowSort="true" align="left" width="180px" visible="false">
	        				资产单元名称
	                </div>
	                <div field="businFlag" headerAlign="center"  align="left" width="120px">
                        	交易平台
	                </div>
	                <div field="occurBal" summaryType="sum" headerAlign="center" dataType="currency" align="right" width="150px">
							发生金额(元)
	                </div>
	                <div field="dataSource" headerAlign="center"  align="left" width="180px">
                       		 指令状态
	                </div>
	            	<div field="settleDate" headerAlign="center" allowSort="true" align="left" width="100px" dateFormat="yyyy-MM-dd">
							交割日期
	            	</div>
        				</div>
		    		</div>
				</div>
				<%-- 追加提取和期货保障金明细结束 --%>
			</div>
		</div>	

<script type="text/javascript">
		nui.parse();
		//$("#stockCode > span > input").attr("placeholder","请输入...");
		var grid_fifth_detail = nui.get("datagrid_fifth_detail");//资金流水调整表
		<%-- 追加提取和期货保障金明细接口开始... --%>
		//获取主页面传过来的数据
		function setData(row){
			var rowData = nui.clone(row);
			var recordData = rowData.record;
			var colType = rowData.colType;
			//将普通form转为nui的form
			var form = new nui.Form("#form_fifth_detail");
			var prodinfo = recordData.fifthData.vcFundName+" - "+recordData.fifthData.vcAssetName;
			$("#productInfo").text(prodinfo);
			nui.get("lAssetId").setValue(recordData.fifthData.lAssetId);
			nui.get("lSettleDate").setValue(recordData.fifthData.lSettleDate);
			nui.get("colType").setValue(colType);
	    form.setChanged(false);
	    search_fifth_detail();
		}
	  //查询
		function search_fifth_detail(){
			var colField = nui.get("colType").getValue();
			if(colField=="appendBal"){
				nui.get("businType").setValue("40103");//委托人追加
			}else if(colField=="extractBal"){
				nui.get("businType").setValue("40104");//委托人提取
			}else if(colField=="futuresMarginBal"){
				nui.get("businType").setValue("725589");//期货保证金调整金额
			}
			nui.get("type").setValue("4");
			var conditionForm = new nui.Form("#form_fifth_detail");
			var json = conditionForm.getData(false, false);
			grid_fifth_detail.load(json);
		}
		//导出最新现金流水记录
    function export_fifth_detail(){
    	var colField = nui.get("colType").getValue();
    	var sheetName = "";
    	if(colField=="appendBal"){
				sheetName = "委托人追加业务明细";
			}else if(colField=="extractBal"){
				sheetName = "委托人提取业务明细";
			}else if(colField=="futuresMarginBal"){
				sheetName = "期货保障金明细信息";
			}
	    exportSubmit("export_fifth_detail", "form_fifth_detail", sheetName,"XJL_DETAIL");
    }
		<%-- 资金流水调整表结束!!! --%>
</script>
</body>
</html>