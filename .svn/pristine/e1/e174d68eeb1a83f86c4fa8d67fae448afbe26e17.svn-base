<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): jiangkanqian
  - Date: 2018-06-01 16:16:09
  - Description:
-->
<head>
<title>利率互换交易Tab</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="width: 100%;height: 100%;overflow: hidden;margin: 0px;">
	
	<div class="nui-tabs" id="interestSwapTabs" width="100%" height="100%" >
		<div id="interestSwapOpen" name="interestSwapOpen" title="开仓" 
		style="width: auto;position: relative;" refreshOnClick="true"
			url="<%=request.getContextPath() %>/instruction/interestSwap/interestSwapTrade.jsp">
		</div>
		<div id="chargeAgainst" name="chargeAgainst" title="冲销平仓"  
		style="width: auto;position: relative;" refreshOnClick="true"
			url= "<%=request.getContextPath() %>/instruction/interestSwap/chargeAgainstTrade.jsp">
		</div>
		<div id="discrepancyGold" name="discrepancyGold" title="出入金" 
		style="width: auto;position: relative;" refreshOnClick="true"
			url="<%=request.getContextPath() %>/instruction/interestSwap/discrepancyGoldTrade.jsp">
		</div>				
	</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>