<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>	
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<!-- 
  - Author(s): 陈鹏
  - Date: 2017-05-16 09:16:40
  - Description:
-->
<head>
	<title>头寸管理-定期存款到期浏览表</title>
 	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
	<%
		Date dateTime = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		String PaymentDate = format.format(dateTime);
		
		//默认当天是交易日
		String businDay = DateUtil.currentDateString(DateUtil.YMD_NUMBER);
		//判断今天是否为交易日
		boolean isTradeDay = DateUtil.isTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null);
		//若当天不是交易日（周末或节假日），则业务日期获取下个交易日
		if(!isTradeDay){
			businDay = DateUtil.getCalculateTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null, 1);
		}
		//获取上一个交易日
		String preDate = DateUtil.getCalculateTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null, -1);
	 %>
</head>
<body style="overflow: hidden;">
   <%-- 查询条件开始... --%>
   <div class="search-condition">
	   <div class="list">
		   <form id="form1" method="post">
		    <input class="nui-hidden" name="paramObject/queryType" value="DQCKDQYLB"/>
            <table id="table1" class="table" border="0" style="height:100%;table-layout:fixed;">
            <tr>
                <td class="form_label" width="60px" align="right">
                    起息日:
                </td>
                <td colspan="1" width="300px" align="left">
                   	 &nbsp;从&nbsp;
                    <input class="nui-datepicker" name="paramObject/LBeginDateStart" format="yyyy-MM-dd" style="width: 120px;"/>
               		 &nbsp;到&nbsp;
                	<input class="nui-datepicker" name="paramObject/LBeginDateEnd" format="yyyy-MM-dd" style="width: 120px;"/>
                </td>
                <td class="form_label" width="70px" align="right">
                    基金名称:
                </td>
                <td colspan="1" align="left" width="200px">
                    <input id="vCFundCode_ZJTC" class="nui-buttonedit" style="width:180px;" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_DQCKDQYLB"/>
                </td>
                <td class="form_label" width="70px" align="right">
		存单状态:
                </td>
                <td colspan="1" width="200px">
					<input class="nui-dictcombobox" name="paramObject/vcDepositreceiptStatus" data="data" valueField="dictID" textField="dictName" dictTypeId="ATS_ZHBB_DEPOSITRECEIPT_STATUS"
						emptyText="全部" nullItemText="全部" showNullItem="true" style="width:160px" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
				</td>
          </tr>
          <tr>
                <td class="form_label" align="right">
                    到期日:
                </td>
                <td colspan="1" align="left" >
                    &nbsp;从&nbsp;
                    <input id="LEndDateStart" class="nui-datepicker" name="paramObject/LEndDateStart" format="yyyy-MM-dd" style="width: 120px;"/>
                    &nbsp;到&nbsp;
                    <input id="LEndDateEnd" class="nui-datepicker" name="paramObject/LEndDateEnd" format="yyyy-MM-dd" style="width: 120px;"/>
                </td>
                <td class="form_label" align="right">
                    对手方:
                </td>
                <td colspan="1" align="left">
                    <input class="nui-textbox" name="paramObject/vCBankName" style="width: 180px;"/>
                </td>
                <td align="left" colspan="2">
                    <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
                	&nbsp;
                	<input class='nui-button' plain='false' text="重置" iconCls="icon-reset" onclick="reset()"/>
		      		&nbsp;
		      		<input id="DueVisitTable" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="exportDueVisitTable()"/>
                    </td>
                </tr>
            </table>
         </form>
	  </div>
   </div>
   <%-- 查询条件结束!!! --%>

    <div class="nui-fit">
        <div 
	        id="datagrid1"
	        dataField="resultObjectList"
	        class="nui-datagrid"
	        style="width:100%;height:100%;"
	    	url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryZHXX.biz.ext"
	        pageSize="50"
	        showPageInfo="true"
	        allowSortColumn="true"
	        sortMode="client"
	        enableHotTrack="true"
	        allowHeaderWrap="true"
	        sizeList="[10,20,50,100]"
	        allowCellEdit="true"
			allowCellSelect="true"
			enterNextCell="true"
			allowMoveColumn="true"
			editNextOnEnterKey="true"
			pagerButtons="#prompt_todays"
			multiSelect="true"   
			showfooter="false">

        <div property="columns">
            <div type="indexcolumn">
            </div>
            <div field="VC_FUND_CODE" name="VC_FUND_CODE" headerAlign="center" allowSort="true" align="center" renderer="renderRelaType" width="80px">
                基金代码
            </div>
            <div field="VC_FUND_NAME" name="VC_FUND_NAME" headerAlign="center" allowSort="true" align="left" renderer="renderRelaType" width="160px">
                基金名称
            </div>
            <div field="DEPOSITRECEIPT_STATUS" headerAlign="center" allowSort="true" align="center" width="90px">
               存单状态
            </div>
            <div field="VC_BANK_NAME" headerAlign="center" allowSort="true" align="left" width="150px">
                对手方
            </div>
            <div field="EN_BALANCE" headerAlign="center" allowSort="true" align="right" width="130px"  >
                存单金额(元)
            </div>
            <div field="L_LIMIT_TIME" headerAlign="center" allowSort="true" align="right" width="80px">
                存款期限(天)
            </div>
            <div field="L_BEGIN_DATE" headerAlign="center" allowSort="true" align="center" width="80px">
               起息日
            </div>
            <div field="L_END_DATE" name="L_END_DATE" headerAlign="center" allowSort="true" align="center" width="80px">
               到期日
            </div>
            <div field="L_PAYMENT_DATE" name="L_PAYMENT_DATE" headerAlign="center" allowSort="true" align="center" width="100px">
               到期本息兑付日
            </div>
            <div field="EN_RATE" headerAlign="center" allowSort="true" align="right" width="60px">
               利率(%)
            </div>
            <div field="C_ADVANCE_LIMIT_FLAG" headerAlign="center" allowSort="true" align="left" width="150px">
               提前支取限制
            </div>
            <div field="C_ASSET_CLASS" name="C_ASSET_CLASS" headerAlign="center" allowSort="true" align="center" width="80px">
                资产类别
            </div>
            <div field="VC_REPORT_CODE" headerAlign="center" allowSort="true" align="center" width="80px">
                证券代码
            </div>
            <div field="VC_STOCK_NAME" headerAlign="center" allowSort="true" align="left" width="100px">
               证券简称
            </div>
        </div>
    </div>
    <div id="prompt_todays">
        <span class="separator"></span>
       	<div style= "display:inline-block; color:red;margin-right: 8px;">红色字体代表“到期日”，“到期本息兑付日”等于当天</div>
	</div>
</div>

<script type="text/javascript">
	nui.parse();
	var grid = nui.get("datagrid1");
	var businDay = '<%=businDay%>';//当前交易日
	nui.get("LEndDateStart").setValue(businDay);//设置默认日期-起息日-起始日期
	nui.get("LEndDateEnd").setValue(businDay);//设置默认日期-起息日-截止日期
	
	var formData = new nui.Form("#form1").getData(false,false);
	grid.load(formData);
	
	//重置查询条件
	function reset(){
		var form = new nui.Form("#form1");//将普通form转为nui的form
		form.reset();
	}
	
	//获取查询条件的基金名称
	function ButtonClickGetFundName_DQCKDQYLB(e){
        ButtonClickGetFundName(this, null);
	}
	
	//查询
	function search() {
		var form = new nui.Form("#form1");
		var json = form.getData(false,false);
		grid.load(json);//grid查询
	}
	
	//导出到期游览表
	function exportDueVisitTable(){
		exportSubmit("DueVisitTable", "form1", "定期存款到期浏览表");
	}
	
	//表格行增加样式
	grid.on("drawcell", function (e) {
    	var record = e.record;
    	var field  = e.field;
    	
    	
    	var L_END_DATE = changeNull(record.L_END_DATE);  //获取到期日
    	var L_PAYMENT_DATE = changeNull(record.L_PAYMENT_DATE);  //获取到期本息兑付日
    	var PaymentDate = '<%=PaymentDate %>';
    	
    	//
    	if(field == "L_END_DATE"){
    		//判断到期日是否等于当天时间
    		if(L_END_DATE == PaymentDate){
    	   		e.rowCls = "warn_red";
    		}
    	}
    	
    	if(field == "L_PAYMENT_DATE"){
    		//判断到期本息兑付日是否等于当天时间
    		if(L_PAYMENT_DATE == PaymentDate){
    	   		e.rowCls = "warn_red";
    		}
    	}
	});
	
</script>	
</body>
</html>