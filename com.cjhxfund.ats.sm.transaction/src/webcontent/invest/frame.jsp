<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-09-03 14:45:19
  - Description: 债券二级投资指令/建议
-->
<head>
	<title>债券二级投资指令/建议</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
	
	<div id="tabs_frame" class="nui-tabs" activeIndex="0" onactivechanged="" style="width:100%;height:100%;">
		<!--<div title="机构报价查询" url="<%= request.getContextPath() %>/transaction/invest/tbond_quote/tBondQuote.jsp"></div>-->
		<div title="银行间债券买卖" url="<%= request.getContextPath() %>/transaction/invest/interbank_trade/tBondTrade.jsp"></div>
		<div title="上交所大宗交易" url="<%= request.getContextPath() %>/transaction/invest/sh_block_trade/tBondTrade.jsp"></div>
		<div title="上交所固收平台" url="<%= request.getContextPath() %>/transaction/invest/sh_fixed_income/tBondTrade.jsp"></div>
		<div title="深交所综合协议平台" url="<%= request.getContextPath() %>/transaction/invest/sz_integrated_prot/tBondTrade.jsp"></div>
		<div title="投资指令/建议管理" url="<%= request.getContextPath() %>/sm/comm/instruct/tansaction_instruct/instructFollow.jsp"></div>
		<%-- <div title="指令/建议导入" url="<%= request.getContextPath() %>/transaction/invest/szIntegratedProtTrade.jsp"></div> --%>
	</div>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>