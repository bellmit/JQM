<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2016-04-26 19:54:39
- Description: 综合信息查询-银行间回购-银行间回购明细表查询（数据取自O32）
--%>
<head>
<title>综合信息查询-银行间回购-银行间回购明细表查询</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body>
	
	<div id="form_YHJHGDetail" class="nui-form" style="padding:2px;" align="center" style="height:10%">
	 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
	 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
	 	<%-- 查询类型 --%>
	 	<input class="nui-hidden" name="paramObject/queryType" value="YHJHGDetail">
	 	<%-- 流水号 --%>
	 	<input id="lSerialNo" class="nui-hidden" name="paramObject/lSerialNo" value="">
	</div>

	
	<%-- 银行间回购明细列表开始... --%>
	<div class="nui-fit">
		<div 
			id="datagrid_YHJHGDetail"
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
				<div field="L_DATE" headerAlign="center" allowSort="true" align="center" width="70px">
				日期
				</div>
				<div field="L_FUND_ID" headerAlign="center" allowSort="true" align="center" width="55px" visible="false">
				基金编号
				</div>
				<div field="VC_FUND_NAME" headerAlign="center" allowSort="true" align="left" width="100px">
				基金名称
				</div>
				<div field="L_BASECOMBI_ID" headerAlign="center" allowSort="true" align="center" width="55px" visible="false">
				组合序号
				</div>
				<div field="VC_COMBI_NAME" headerAlign="center" allowSort="true" align="left" width="80px">
				组合名称
				</div>
				<div field="C_INVEST_TYPE" headerAlign="center" allowSort="true" align="center" width="60px">
				投资类型
				</div>
				<div field="VC_REPORT_CODE" headerAlign="center" allowSort="true" align="left" width="75px">
				证券代码
				</div>
				<div field="VC_STOCK_NAME" headerAlign="center" allowSort="true" align="left" width="110px">
				证券名称
				</div>
				<div field="EN_RATIO" headerAlign="center" allowSort="true" align="right" width="80px">
				抵押比例(%)
				</div>
				<div field="L_MORTAGAGE_AMOUNT" headerAlign="center" allowSort="true" align="right" width="95px">
				质押数量
				</div>
			</div>
		</div>
	</div>
	<%-- 银行间回购明细列表结束!!! --%>
	
	
	<script type="text/javascript">
	    nui.parse();
	    var grid_YHJHGDetail = nui.get("datagrid_YHJHGDetail");
	    
	    //页面间传输json数据
		function setFormData(data){
		    //跨页面传递的数据对象，克隆后才可以安全使用
		    var infos = nui.clone(data);
		    var rowRecord = infos.record.rowRecord;
		    nui.get("lSerialNo").setValue(rowRecord.L_SERIAL_NO);
		    
	    	grid_YHJHGDetail.load(new nui.Form("form_YHJHGDetail").getData(false,false));//grid查询
		}
	</script>
</body>
</html>
