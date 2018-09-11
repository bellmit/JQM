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
<title>付息兑付详情</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheetet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
<script src="<%= request.getContextPath() %>/ProductProcess/cashFlow/cashFlow_common.js" type="text/javascript"></script>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div style="width:100%;height:100%;">
		   <%-- 资金流水调整明细查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_fourth_detail" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" id="queryType" name="paramObject/queryType" value="FOURTH_DETAIL_XJL">
				 	<%-- 单元编号(必传) --%>
				 	<input id="lAssetId" class="nui-hidden" name="paramObject/lAssetId">
					<%-- 交收日期(必传) --%>
					<input id="lSettleDate" class="nui-hidden" name="paramObject/lSettleDate">
					<!-- 交易市场 -->
					<input id="marketType" class="nui-hidden" name="paramObject/marketType">
					<%-- 列名称 --%>
					<input id="colType" class="nui-hidden" name="paramObject/colType">
					<%-- 明细类型 --%>
					<input id="type" class="nui-hidden" name="paramObject/type">
				 	
	                <table id="table_third_detail" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="30%" align="left">
													<!-- <span style="width:2%;">交易市场:</span>
													<input id="marketType_third_detail" class="nui-combobox" 
	                            	 name="paramObject/marketType" 
	                               data="[{id:'5',text:'银行间'},{id:'1',text:'交易所'},
	                            			    {id:'n',text:'港股通'},{id:'6',text:'场外'}]"
	                            	 value="">-->
													<span style="width:55px;">证券代码:</span>
	                       	<div name="paramObject/stockCode" class="mini-autocomplete" id="stockCode"
	                            textField="stockCode" valueField="stockName"
	                            searchField="stockCode"
	                            url="com.cjhxfund.jy.ProductProcess.CashFlow.queryO32StockInfo.biz.ext"
	                            popupEmptyText="全部"
	                            nullItemText="全部"
	                            loadingText="加载中"
	                            valueFromSelect="false"
	                            dataField="bondList"
	                            multiSelect="false"
	                            showClose=true
	                            style="width:160px"
	                            oncloseclick="onCloseClick"
	                            popupWidth="300px">
		                        	<div property="columns">
		                            	<div header="证券代码" field="stockCode" width="40px"></div>
		                            	<div header="债券名称" field="stockName"></div>
		                        	</div>
							</div>
							</td>
							<td width="40%" align="center">
									<span id="productInfo" style="width:100%;"></span>
							</td>
	                        <td width="30%" align="right">
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_fourth_detail()"/>
	                            <input class='nui-button' plain='false' id="export_fourth_detail" text="导出" iconCls="icon-download" onclick="export_fourth_detail()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 第二个详情列表查询条件结束!!! --%>
		   
		   <%-- 第二个详情列表开始... --%>
           <div class="nui-fit">
           		<div  id="datagrid_fourth_detail"
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
		                <div field="marketNo" headerAlign="center" dataType="currency" align="right" width="120px">
    									交易市场
	                    </div>
	                    <div field="businClass" headerAlign="center" dataType="currency" align="right" width="120px">
    									交易平台
	                    </div>
	                    <div field="stockCode" headerAlign="center" align="right" width="130px">
    									证券代码
	                    </div>
	                    <div field="stockName" headerAlign="center"  align="left" width="130px">
                                    	证券名称
	                    </div>
	                    <div field="occurBal" headerAlign="center" dataType="currency" align="right" width="130px">
    									发生金额(元)
	                    </div>
	                    <div field="dataSource" headerAlign="center"  align="left" width="100px">
                                    	指令状态
	                    </div>
		                	<div field="tradeDate" headerAlign="center" allowSort="true" align="left" width="100px" dateFormat="yyyy-MM-dd">
        								交易日期
		                	</div>
		                	<div field="settleDate" headerAlign="center" allowSort="true" align="left" width="100px" dateFormat="yyyy-MM-dd">
        								交割日期
		                	</div>
                	</div>
            	</div>
        	</div>
        	<%-- 存款业务详情表列表结束!!! --%>
	</div>
</div>	

<script type="text/javascript">
	nui.parse();
	$("#stockCode > span > input").attr("placeholder","请输入...");
	var grid_fourth_detail = nui.get("datagrid_fourth_detail");//资金流水调整表
	
	var refreshInt = true;//刚刚打开页面时，投顾默认刷新，交易员默认不刷新
    var queryUserTypeTemp = "<%=request.getParameter("queryUserType")%>";
	if(queryUserTypeTemp!=null && queryUserTypeTemp!="" && queryUserTypeTemp!="null"){
		refreshInt = false;
	}
	
		<%-- 第二个详情接口开始... --%>
		//获取主页面传过来的数据
		function setData(row){
			var rowData = nui.clone(row);
			var recordData = rowData.record;
			var colType = rowData.colType;
			//将普通form转为nui的form
			var form = new nui.Form("#form_fourth_detail");
			var prodinfo = recordData.fourthData.vcFundName+" - "+recordData.fourthData.vcAssetName;
			$("#productInfo").text(prodinfo);
			nui.get("lAssetId").setValue(recordData.fourthData.lAssetId);
			nui.get("lSettleDate").setValue(recordData.fourthData.lSettleDate);
			nui.get("colType").setValue(colType);
	    form.setChanged(false);
	    search_fourth_detail();
		}
		//获取查询条件的基金名称
		function ButtonClickGetFundName_third_detail(e){
	        ButtonClickGetFundName(this, null);
		}
    //重置
    function reset_third_detail(){
    	var form = new nui.Form("#form_fourth_detail");//将普通form转为nui的form
		form.reset();
    }
    //页面X的删除功能
		function onCloseClick(e) {
		    var obj = e.sender;
		    obj.setText("");
		    obj.setValue("");
		    $("#stockCode > span > input").attr("placeholder","请输入...");
		}
	    //查询
		function search_fourth_detail(){
			var colField = nui.get("colType").getValue();
			if(colField=="bondDxDfBalCsi"){
				nui.get("marketType").setValue("5");//银行间
			}else if(colField=="bondDxDfBalCibm"){
				nui.get("marketType").setValue("1");//交易所
			}
			nui.get("type").setValue("3");
			var conditionForm = new nui.Form("#form_fourth_detail");
			var json = conditionForm.getData(false, false);
			if(json["paramObject/stockCode"]!=""){
				json["paramObject/stockCode"] = nui.get("stockCode").text;
			}
			grid_fourth_detail.load(json);
		}
		//处理下拉框多选的情况：给多选字符加上单引号 
		function splitString(data){
			var mulString = null;
			if(data != null && data != ""){
				var strs= data.split(",");
	    		if(strs.length>0){
	    			for(var i=0; i<strs.length; i++ ){ 
							if(i == 0){
								mulString = "'"+strs[i]+"'";
							}else{
								mulString += ",'"+strs[i]+"'";
							}
						} 
	    		}
			}
			return mulString;
	    }
	    //导出最新现金流水记录
	    function export_fourth_detail(){
	    	//导出
		    exportSubmit("export_fourth_detail", "form_fourth_detail", "付息兑付明细信息","XJL_DETAIL");
	    }
		<%-- 资金流水调整表结束!!! --%>
</script>
</body>
</html>