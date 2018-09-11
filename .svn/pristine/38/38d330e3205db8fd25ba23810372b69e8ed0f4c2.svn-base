<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): 何祎
- Date: 2017-03-07 09:42:27
- Description: 保证金明细
--%>
<head>
<title>保证金明细表查询</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body>
	
	<div id="form_BZJDetail" class="nui-form" style="padding:2px;" align="center" style="height:10%">
	 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
	 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
	 	<%-- 查询类型 --%>
	 	<input class="nui-hidden" name="paramObject/queryType" value="BZJDetail">
	 	<input id="VC_FUND_CODE" class="nui-hidden" name="paramObject/VC_FUND_CODE" value="">
 		<input id="L_DATE" class="nui-hidden" name="paramObject/L_DATE" value="">
 		<input id="L_FUND_ID" class="nui-hidden" name="paramObject/L_FUND_ID" value="">
	</div>

	
	<%-- 保证金明细列表开始... --%>
	<div class="nui-fit">
		<div 
			id="datagrid_BZJDetail"
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
				<div field="VC_BUSIN_CAPTION" headerAlign="center" allowSort="true" align="center" width="55px">
				业务类型	
				</div>
				<div field="VC_REPORT_CODE" headerAlign="center" allowSort="true" align="left" width="100px">
				证券代码
				</div>
				<div field="VC_STOCK_NAME" headerAlign="center" allowSort="true" align="center" width="55px">
				证券名称
				</div>
				<div field="EN_DEAL_BALANCE" headerAlign="center" allowSort="true" align="left" width="80px">
				成交金额
				</div>
				<div field="L_CAL_RATIO" headerAlign="center" allowSort="true" align="center" width="60px">
				保证金比例
				</div>
				
			</div>
		</div>
	</div>
	<%-- 保证金明细列表结束!!! --%>
	
	
	<script type="text/javascript">
	    nui.parse();
	    var grid_BZJDetail = nui.get("datagrid_BZJDetail");
	    
	    //页面间传输json数据
		function setFormData(data){
		    //跨页面传递的数据对象，克隆后才可以安全使用
		    var infos = nui.clone(data);
		    var rowRecord = infos.record.rowRecord;
		    nui.get("L_DATE").setValue(rowRecord.L_DATE);
		    nui.get("L_FUND_ID").setValue(rowRecord.L_FUND_ID);
		    nui.get("VC_FUND_CODE").setValue(rowRecord.VC_FUND_CODE);
		    
	    	grid_BZJDetail.load(new nui.Form("form_BZJDetail").getData(false,false));//grid查询
		}
	</script>
</body>
</html>
