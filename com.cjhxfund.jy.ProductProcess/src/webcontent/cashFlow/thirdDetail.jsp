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
<title>存款业务明细</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheetet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
<script src="<%= request.getContextPath() %>/ProductProcess/cashFlow/cashFlow_common.js" type="text/javascript"></script>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div style="width:100%;height:100%;">
		   <%-- 存款业务明细查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_third_detail" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" id="queryType" name="paramObject/queryType" value="THIRD_DETAIL_XJL">
				 	<%-- 单元编号(必传) --%>
				 	<input id="lAssetId" class="nui-hidden" name="paramObject/lAssetId">
					<%-- 交收日期(必传) --%>
					<input id="lSettleDate" class="nui-hidden" name="paramObject/lSettleDate">
					<!-- 头寸明细类型 -->
					<input id="dpstType" class="nui-hidden" name="paramObject/dpstType">
					<%-- 列名称 --%>
					<input id="colType" class="nui-hidden" name="paramObject/colType">
					<%-- 明细类型 --%>
					<input id="type" class="nui-hidden" name="paramObject/type">
				 	<table id="table_third_detail" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="30%" align="left">
							</td>
							<td width="40%" align="center">
									<span id="productInfo" style="width:100%;"></span>
							</td>
	                        <td width="30%" align="right">
	                        	<input class="nui-button" id="export_third_detail" text="导出" iconCls="icon-download" onclick="export_third_detail()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 存款业务详情列表查询条件结束!!! --%>
		   
		   <%-- 存款业务详情列表开始... --%>
           <div class="nui-fit">
           		<div  id="datagrid_third_detail"
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
	                    <div field="businTypeName" headerAlign="center"  align="left" width="120px">
                                    	业务类型
	                    </div>
		                	<div field="dpstBalance" headerAlign="center" dataType="currency" align="right" width="150px">
    									存款金额(元)
	                    </div>
	                    <div field="dpstRatio" headerAlign="center" dataType="currency" align="right" width="150px">
    									存款利率
	                    </div>
	                    <div field="dpstStlBal" headerAlign="center" dataType="currency" align="right" width="150px">
    									存款到期交割金额(元)
	                    </div>
	                    <div field="dataSource" headerAlign="center"  align="left" width="100px">
                                    	指令状态
	                    </div>
		                	<div field="beginDate" headerAlign="center" allowSort="true" align="left" width="100px" dateFormat="yyyy-MM-dd">
        								起息日期
		                	</div>
		                	<div field="endDate" headerAlign="center" allowSort="true" align="left" width="100px" dateFormat="yyyy-MM-dd">
        								到息日期
		                	</div>
	                    <div field="businType" headerAlign="center"  align="left" width="120px" visible="false">
                                    	业务类型
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
	var grid_third_detail = nui.get("datagrid_third_detail");//资金流水调整表
	
	var refreshInt = true;//刚刚打开页面时，投顾默认刷新，交易员默认不刷新
    var queryUserTypeTemp = "<%=request.getParameter("queryUserType")%>";
	if(queryUserTypeTemp!=null && queryUserTypeTemp!="" && queryUserTypeTemp!="null"){
		refreshInt = false;
	}
	
		<%-- 存款业务详情接口开始... --%>
		//获取主页面传过来的数据
		function setData(row){
			var rowData = nui.clone(row);
			var recordData = rowData.record;
			var colType = rowData.colType;
			//将普通form转为nui的form
			var form = new nui.Form("#form_third_detail");
			var prodinfo = recordData.thirdData.vcFundName+" - "+recordData.thirdData.vcAssetName;
			$("#productInfo").text(prodinfo);
			nui.get("lAssetId").setValue(recordData.thirdData.lAssetId);
			nui.get("lSettleDate").setValue(recordData.thirdData.lSettleDate);
			nui.get("colType").setValue(colType);
	        form.setChanged(false);
	        search_third_detail();
		}
		//获取查询条件的基金名称
		function ButtonClickGetFundName_third_detail(e){
	        ButtonClickGetFundName(this, null);
		}
    //重置
    function reset_third_detail(){
    	var form = new nui.Form("#form_third_detail");//将普通form转为nui的form
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
		function search_third_detail(){
			var colField = nui.get("colType").getValue();
			if(colField=="depositBal"){
				nui.get("dpstType").setValue("F");//F-存款存入
			}else if(colField=="depositExpireBal"){
				nui.get("dpstType").setValue("i");//i-存款到期
			}
			nui.get("type").setValue("2");
			var conditionForm = new nui.Form("#form_third_detail");
			var json = conditionForm.getData(false, false);
			grid_third_detail.load(json);
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
	    function export_third_detail(){
	    	//导出
		    exportSubmit("export_third_detail", "form_third_detail", "存款业务明细","XJL_DETAIL");
	    }
		<%-- 资金流水调整表结束!!! --%>
</script>
</body>
</html>