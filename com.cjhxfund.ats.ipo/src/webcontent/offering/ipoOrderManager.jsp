<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 谭凯
  - Date: 2017-06-06 17:53:09
  - Description:
-->
<head>
<title>网下新股申购</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>

	<div id="tab1" class="nui-tabs" activeIndex="0" style="width:100%;height:610px;">
		<div  title="询价结果" id="inquiry_result" url="<%=request.getContextPath() %>/ipo/offering/ipoEnquiryResult.jsp"></div>
		<div title="申购指令/建议下达" id="purchase_order" url="<%=request.getContextPath() %>/ipo/offering/ipoOrderEnter.jsp"></div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>