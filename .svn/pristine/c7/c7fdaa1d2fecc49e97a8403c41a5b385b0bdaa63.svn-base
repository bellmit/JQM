<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): heyi
  - Date: 2017-03-29 14:48:56
  - Description:
-->
<head>
<title>备付金相关说明</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
<div style="font-weight:bold;">备付金计算逻辑：</div>
权益类最低结算备付金   = 月初至计算日业务类别为“证券买入”的成交金额汇总    / 当月交易日天数  * 权益类最低备付金比例（0.2）<br/>
<br/>
债券类最低结算备付金   = 月初至计算日业务类别为（“债券买入”、“融券回购”、“融资购回”）的成交金额汇总  / 上月交易天数  * 债券类最低备付金比例（0.1）<br/>
<br/>
最低结算备付金   = 权益类最低结算备付金  + 债券类最低结算备付金<br/>
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