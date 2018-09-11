<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): heyi
  - Date: 2017-03-29 14:44:58
  - Description:
-->
<head>
<title>保证金相关说明</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
<div style="font-weight:bold;">保证金计算免责声明:</div>
结算保证金以托管行的实际分配为准，此处从产品维度进行计算，仅供参考<br/>
<br/>
<div style="font-weight:bold;">保证金计算逻辑：</div>
上海(深圳)结算保证金   = 前六个月权益类日均结算净额的绝对值   * (上海(深圳)权益类处置价差比例   + 权益类处置成本比例) + 前六个月固收类日均结算净额的绝对值    * (上海(深圳)固收类处置价差比例   + 固收类处置成本比例)<br/>
<br/>
本月结算保证金  = 上海结算保证金   + 深圳结算保证金<br/>
<br/>
权益类处置成本比例:0.01<br/>
固收类处置成本比例:0.005<br/>
上海权益类处置价差比例:0.13<br/>
上海固收类处置价差比例:0.035<br/>
深圳权益类处置价差比例:0.15<br/>
深圳固收类处置价差比例:0.015<br/>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>