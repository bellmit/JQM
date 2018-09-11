<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): chenpeng
  - Date: 2016-04-21 17:13:07
  - Description:
-->
<head>
<title>判断文档类型</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
<%
  String fileName = request.getParameter("fileName");
  String sysid = request.getParameter("sysid");
  String type = request.getParameter("type");
  boolean isPDF = false;
  if(fileName !=null && fileName.trim().length() >0){
      	String fileExt = fileName.substring(fileName.lastIndexOf(".") +1 , fileName.length());
      	 if("pdf".equalsIgnoreCase(fileExt)){
      	   isPDF = true;
      	 }
     }
 %>    
</head>
<body>
   <% if(isPDF == true){ %>
    <script type="text/javascript">
		window.location.href="<%=request.getContextPath() %>/commonUtil/JQMHistory/iWebOffice/DocumentEdit.jsp?sysid=<%=sysid %>&type=<%=type %>";
    </script>  
   <%}else{ %>
    <script type="text/javascript">
		window.location.href="<%=request.getContextPath() %>/commonUtil/JQMHistory/iWebOffice/OfficeEdit.jsp?sysid=<%=sysid %>&type=<%=type %>";
    </script>  
   <%} %>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>