<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-11-07 13:10:18
  - Description:债券历史成交信息
-->
<head>
<title>历史成交信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	<div class="search-condition">
   		<div class="list">
   			<input id="vcStockCode" name="vcStockCode" class="nui-hidden">
   			<input id="vcMarketNo" name="vcMarketNo" class="nui-hidden">
   			<div id="form_history_deal" class="nui-form" align="left">
   				<table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                    <tr>
                    	<td width="45px">开始时间:</td>
                        <td colspan="1" width="20%" align="left">
                        	<input id="beginTime" name="bondInfo/beginTime" class="nui-datepicker" style="width:120px"
                        		format="yyyy-MM-dd" showTime="true" showOkButton="true" showClearButton="false" />
						</td>
						<td align="right" width="45px">结束时间:</td>
                        <td colspan="1" width="20%" align="left">
							<input id="endTime" name="bondInfo/endTime" class="nui-datepicker" style="width:120px"
								format="yyyy-MM-dd" showTime="true" showOkButton="true" showClearButton="false"/>
						</td>
						<td align="right" width="50px">
					       <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
					   	</td>
                    	<td width="50px">
                            <a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">重置</a>   
                        </td>
                    </tr>
				</table>
   			</div>
   		</div>
   	</div>
	<div id="datagrid_history_deal" dataField="historyDeals" 
            url="com.cjhxfund.ats.sm.transaction.QuotationInfoManager.getHistoryDeal.biz.ext"
            class="nui-datagrid" style="width:100%;height:290px;"
            pageSize="10"
            showPageInfo="true" multiSelect="true"
            allowSortColumn="true"
            sortMode="client"
            enableHotTrack="false"
            sizeList="[10,20,50,100]">
    		<div property="columns">
	            <div field="createTime" headerAlign="center" align="center" width="95px" dateFormat="yyyy-MM-dd HH:mm:ss">
	               日期
	            </div>
	            <div field="windCode" headerAlign="center" align="center" width="85px">
	                债券代码
	            </div>
	            <div field="secName" headerAlign="center" align="center" width="85px">
	                债券名称
	            </div>
	            <div field="rtYield" headerAlign="center" align="center" width="85px">
	                成交价
	            </div>
	            <div field="srcCode" headerAlign="center" align="center" width="85px" renderer="renderQuoteSrc">
	                中介结构名称
	            </div>
	    	</div>
		</div>
	<script type="text/javascript">
    	nui.parse();
    	var form_history_deal = new nui.Form("#form_history_deal");
    	var history_deal_grid = nui.get("datagrid_history_deal");
    	var endTime = new Date(new Date().toLocaleDateString());
    	var beginTime = new Date(endTime.getTime()-8 * 24 * 3600 * 1000);
    	nui.get("beginTime").setValue(beginTime);
    	nui.get("endTime").setValue(endTime);
    	function search(){
    		var json = form_history_deal.getData(false,false);
    		json["bondInfo/vcStockCode"] = nui.get("vcStockCode").getValue();
    		json["bondInfo/vcMarketNo"] = nui.get("vcMarketNo").getValue();
    		history_deal_grid.load(json);
    	}
    	function loadData(data){
    		nui.get("vcStockCode").setValue(data.vcStockCode);
    		nui.get("vcMarketNo").setValue(data.vcMarketNo);
    		search();
    	}
    	
    	function reset(){
    		form_history_deal.clear();
    	}
    	function renderQuoteSrc(e){
			return nui.getDictText("quoteSource",e.row.srcCode);
		}
    </script>
</body>
</html>