<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2016-04-26 19:54:39
- Description: 自动化头寸表-自动化头寸明细表查询（数据取自O32）
--%>
<head>
<title>自动化头寸表-自动化头寸明细表查询</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body>
	
	<div id="form_ZDHTCBDetail" class="nui-form" style="padding:2px;" align="center" style="height:10%">
	 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
	 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
	 	<%-- 查询类型 --%>
	 	<input id="queryType" class="nui-hidden" name="paramObject/queryType" value="ZDHTCBDetailNew">
	 	<%-- 基金序号 --%>
	 	<input id="vCFundId" class="nui-hidden" name="paramObject/vCFundId" value="">
	 	<table width="80%" border="0" style="margin-left: 0px;">
	 	   <tr>
	 	     <td class="form_label" align="right">指标描述：</td>
	 	     <td align="left"><input class="nui-textbox" id="busiDesc" name="paramObject/busiDesc"/></td>
	 	     <td align="left">
	 	     	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_ZDHTCBDetail()"/>
	 	     </td>
	 	   </tr>
	 	</table>
	</div>
	
	<%-- 自动化头寸明细表查询列表开始... --%>
	<div class="nui-fit">
		<div 
			id="datagrid_ZDHTCBDetail"
			dataField="resultObjectList"
			class="nui-datagrid"
			style="width:100%;height:100%;"
			url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryZHXX.biz.ext"
			pageSize="50"
			showPageInfo="true"
			allowSortColumn="true"
			sortMode="client"
			enableHotTrack="true"
			sizeList="[10,20,50,100]"
			ondrawsummarycell="onDrawSummaryCell"
			showSummaryRow="true"
			>
		
			<div property="columns">
				<div type="indexcolumn" width="20"></div>
				<div field="EN_BALANCE" headerAlign="center" allowSort="true" align="right" width="55px" visible="true" numberFormat="n">
				指标金额
				</div>
				<div field="BZ" headerAlign="center" allowSort="true" align="left" width="100px">
				备注
				</div>
				<div field="BUSI_DESC" headerAlign="center" allowSort="true" align="left" width="55px" visible="true">
				指标描述
				</div>
			</div>
		</div>
	</div>
	<%-- 自动化头寸明细表查询列表结束!!! --%>
	
	<script type="text/javascript">
	    nui.parse();
	    var grid_ZDHTCBDetail = nui.get("datagrid_ZDHTCBDetail");
	    
	    //页面间传输json数据
		function setFormData(data){
		    //跨页面传递的数据对象，克隆后才可以安全使用
		    var infos = nui.clone(data);
		    var rowRecord = infos.record.rowRecord;
		    nui.get("vCFundId").setValue(rowRecord.L_FUND_ID);
		    var rowType=infos.record.rowType;
		    if(rowType=="real"){
		        nui.get("queryType").setValue("ZDHTCBDetailNew");
		    }else{
		        //回款未交收资金
		        nui.get("queryType").setValue("ZDHTCBDetail2New");
		    }
	    	search_ZDHTCBDetail();
		}
		
		//查询--所有业务通用
		function search_ZDHTCBDetail() {
		    search(grid_ZDHTCBDetail, "#form_ZDHTCBDetail");
		}
		
		function onDrawSummaryCell(e){
            var rows = e.data;
            if (e.field == "EN_BALANCE") {
                var total = 0;
                for (var i = 0, l = rows.length; i < l; i++) {
                    var row = rows[i];
					var resultStr = parseFloat(row.EN_BALANCE.replace("," , ""));
                    if (isNaN(resultStr)) continue;
                    total += resultStr;
                }
                var newVal = formatNumber(total,4,1);
                e.cellHtml = "总计: " + newVal;
            }
        }
	</script>
</body>
</html>
