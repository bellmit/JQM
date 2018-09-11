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
<title>头寸总明细页面</title>
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
				 <form id="form_first_detail" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" id="queryType" name="paramObject/queryType" value="FIRST_DETAIL_XJL">
				 	<%-- 单元编号(必传) --%>
				 	<input id="lAssetId" class="nui-hidden" name="paramObject/lAssetId">
					<%-- 交收日期(必传) --%>
					<input id="lSettleDate" class="nui-hidden" name="paramObject/lSettleDate">
					<!-- 头寸总明细类型 -->
					<input id="cashEnableType" class="nui-hidden" name="paramObject/cashEnableType">
					<%-- 列名称 --%>
					<input id="colType" class="nui-hidden" name="paramObject/colType">
					<%-- 明细类型 --%>
					<input id="type" class="nui-hidden" name="paramObject/type">
				 	
	                <table id="table_first_detail" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="30%" align="left">
															<!-- <span style="width:2%;">交易市场:</span>
															<input id="marketType_second_detail" class="nui-combobox" 
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
									<span id="productInfo" style="width:100%;" align="center"></span>
								</td>
				                <td width="30%" align="right">
				                	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_first_detail()"/>
			                    <input class='nui-button' plain='false' id="export_first_detail" text="导出" iconCls="icon-download" onclick="export_first_detail()"/>
				                </td>
                		</tr>
								</table>
							</form>
						  </div>
					   </div>
					   <%-- 第二个详情列表查询条件结束!!! --%>
		   
		   			<%-- 第二个详情列表开始... --%>
           <div class="nui-fit">
           		<div  id="datagrid_first_detail"
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
						showfooter="false"
						showSummaryRow="true">
                		<div property="columns">
                     	<div type="indexcolumn" width="40px">序号</div>
                     	<div field="fundName" headerAlign="center" allowSort="true" align="left" width="180px" visible="false">
	        							产品名称
		                </div>
		                <div field="assetName" headerAlign="center" allowSort="true" align="left" width="180px" visible="false">
	        							资产单元名称
		                </div>
	                    <div field="marketNo" headerAlign="center"  align="left" width="120px">
                                    	交易市场
	                    </div>
	                    <div field="trusteeShip" headerAlign="center"  align="left" width="120px" visible="false">
                                    	托管机构
	                    </div>
	                    <div field="entrustDirection" headerAlign="center"  align="left" width="120px">
                                    	委托方向
	                    </div>
	                    <div field="stockCode" headerAlign="center"  align="left" width="120px">
                                   		 证券代码
	                    </div>
	                    <div field="stockName" headerAlign="center"  align="left" width="120px">
                                    	证券名称
	                    </div>
	                    <div field="settleBalance"  headerAlign="center" dataType="currency" align="right" width="150px">
    									交易金额(元)
	                    </div>
	                    <div field="dataSource" headerAlign="center"  align="left" width="100px">
                                   		 指令状态
	                    </div>
	                    <div field="businType" headerAlign="center"  align="left" width="120px" visible="false">
                                    	业务类型
	                    </div>
	                    <div field="businTypeName" headerAlign="center"  align="left" width="120px">
                                   		 业务类型
	                    </div>
		                	<div field="settleDate" headerAlign="center" allowSort="true" align="left" width="100px" dateFormat="yyyy-MM-dd">
        								交割日期
		                	</div>
                	</div>
            	</div>
        	</div>
        	<%-- 资金流水调整第二个详情表列表结束!!! --%>
	</div>
</div>	

<script type="text/javascript">
	nui.parse();
	$("#stockCode > span > input").attr("placeholder","请输入...");
	var grid_first_detail = nui.get("datagrid_first_detail");//资金流水调整表
	
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
			var form = new nui.Form("#form_first_detail");
			var prodinfo = recordData.firstData.vcFundName+" - "+recordData.firstData.vcAssetName;
			$("#productInfo").text(prodinfo);
			nui.get("lAssetId").setValue(recordData.firstData.lAssetId);
			nui.get("lSettleDate").setValue(recordData.firstData.lSettleDate);
			nui.get("colType").setValue(colType);
	        form.setChanged(false);
	        search_first_detail();
		}
		//获取查询条件的基金名称
		function ButtonClickGetFundName_first_detail(e){
	        ButtonClickGetFundName(this, null);
		}
    //重置
    function reset_first_detail(){
    	var form = new nui.Form("#form_first_detail");//将普通form转为nui的form
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
		function search_first_detail(){
			zzdsum = 0;
		    sqssum = 0;
		    shsum = 0;
		    szsum = 0;
			var colField = nui.get("colType").getValue();
			if(colField=="beginCash"){
				nui.get("cashEnableType").setValue("0");//期初现金
			}else if(colField=="t0CashEnableBalInvest"){
				nui.get("cashEnableType").setValue("1");//T+0投资头寸
			}else if(colField=="t1CashEnableBalTrade"){
				nui.get("cashEnableType").setValue("2");//T+1交易头寸 
			}
			nui.get("type").setValue("5");
			var conditionForm = new nui.Form("#form_first_detail");
			var json = conditionForm.getData(false, false);
			if(json["paramObject/stockCode"]!=""){
				json["paramObject/stockCode"] = nui.get("stockCode").text;
			}
			grid_first_detail.load(json);
		}
	    //汇总金额
	    var zzdsum = 0;//中债登
	    var sqssum = 0;//上清所
	    var shsum = 0;//上交所
	    var szsum = 0;//深交所
		grid_first_detail.on("drawcell", function (e) {
		   	var field = e.field;
			var record = e.record;
			if(field == "settleBalance"){
				if(record.trusteeShip == "中债登"){
					zzdsum = add(zzdsum,record.settleBalance);
				}else if(record.trusteeShip == "上清所"){
					sqssum = add(sqssum,record.settleBalance);
				}else if(record.marketNo == "上交所A"){
					shsum = add(shsum,record.settleBalance);
				}else if(record.marketNo == "深交所A"){
					szsum = add(szsum,record.settleBalance);
				}
			}
			var s = "<div style='color:Brown;'>";
			if(zzdsum != 0){
				s+="中债登总金额: "+formatNumber(zzdsum,2,1)+" 、";
			}
			if(sqssum != 0){
				s+="上清所总金额: "+formatNumber(sqssum,2,1)+" 、";
			}
			if(shsum != 0){
				s+="上交所总金额: "+formatNumber(shsum,2,1)+" 、";
			}
			if(szsum != 0){
				s+="深交所总金额: "+formatNumber(szsum,2,1)+" 、";
			}
        	s+="交割总额: "+formatNumber(add(add(zzdsum,sqssum),add(shsum,szsum)),2,1)+"</div>";
			var lasttr = $('#datagrid_first_detail > div > div:eq(1) > div:eq(4)> div:eq(1) > table > tbody > tr:eq(1)');
			lasttr.html("<td colspan='10' align='center'>"+s+"</td>");
		});
		function add(a, b) {
		    var c, d, e;
		    try {
		        c = a.toString().split(".")[1].length;
		    } catch (f) {
		        c = 0;
		    }
		    try {
		        d = b.toString().split(".")[1].length;
		    } catch (f) {
		        d = 0;
		    }
		    e = Math.pow(10, Math.max(c, d));
		    return (a * e + b * e) / e;
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
	    function export_first_detail(){
	    	//导出
		    exportSubmit("export_first_detail", "form_first_detail", "头寸总和明细","XJL_DETAIL");
	    }
		<%-- 资金流水调整表结束!!! --%>
</script>
</body>
</html>