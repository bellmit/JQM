<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 创金合信
  - Date: 2016-09-05 11:11:15
  - Description:
-->
<head>
<title>上交所协议式回购</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
<div  class="nui-tabs" style="width:100%;height:100%;" activeIndex="0">
    <div title="首期指令/建议" url="<%= request.getContextPath() %>/repurchase/invest/protocol_repo/initialInstruct.jsp" >
        首期指令/建议
    </div>
    <div title="到期指令/建议" url="<%= request.getContextPath() %>/repurchase/invest/protocol_repo/earlyTerminatedInstruct.jsp">
   到期指令/建议
    </div>
    <div title="续作指令/建议" url="<%= request.getContextPath() %>/repurchase/invest/protocol_repo/sequentialInstruct.jsp">
        续作指令/建议
    </div>
    <div title="换券指令/建议" url="<%= request.getContextPath() %>/repurchase/invest/protocol_repo/refundingInstruct.jsp">
        换券指令/建议
    </div>
    
</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>