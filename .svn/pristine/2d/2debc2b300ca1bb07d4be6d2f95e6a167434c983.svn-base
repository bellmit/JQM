 <%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 姜坎骞
  - Date: 2018-06-26 15:44:15
  - Description:
-->
<head>
<title>附件预览</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
<%
  String fileName = request.getParameter("fileName");
  String sysid = request.getParameter("sysid");
  String type = request.getParameter("type");
  String vcProductCode = request.getParameter("vcProductCode");
  String bizId = request.getParameter("bizId");
  String vcStockName = request.getParameter("vcStockName");
  String vcStockCode = request.getParameter("vcStockCode");
  String cApplyInstType = request.getParameter("cApplyInstType");

  boolean isPDF = false;
  if(fileName !=null && fileName.trim().length() >0){
      	String fileExt = fileName.substring(fileName.lastIndexOf(".") +1 , fileName.length());
      	 if("pdf".equalsIgnoreCase(fileExt)){
      	   isPDF = true;
      	 }
     }
 %>   
 <style type="text/css">
	.mini-layout-region-body {
	   overflow-x :hidde;
	   overflow-y :yes;
	}
	
	 #footer {z-index:999; position:fixed; bottom:0; left:0;  _position:absolute; height:30px;
		 _top: expression_r(documentElement.scrollTop + documentElement.clientHeight-this.offsetHeight-300); overflow:visible;
		}
	#editForm2 table td{
		width:25%;
		word-wrap:break-word;
		word-break:break-all;
		border:solid #a5acb5;
		border-width:0px 1px 1px 0px;
	}
	#editForm2 table th{
		width:25%;
		word-wrap:break-word;
		word-break:break-all;
		border:solid #a5acb5;
		border-width:0px 1px 1px 0px;
	}
	#editForm2 table{
		table-layout:fixed;
	}
	/*报量信息*/
   #reportType1 table td{
		width:25%;
		word-wrap:break-word;
		word-break:break-all;
		border:solid #a5acb5;
		border-width:0px 1px 1px 0px;
	}
	#reportType1 table th{
		width:25%;
		word-wrap:break-word;
		word-break:break-all;
		border:solid #a5acb5;
		border-width:0px 1px 1px 0px;
	}
	#reportType1 table{
		table-layout:fixed;
	}
	
	
	
	.nui-form-widget-cc, th, .nui-form-widget-cc td{
		padding:0;
	}
</style>	 
</head>
<body>

<div id="layout1" class="mini-layout" style="width:100%;height:100%;"  borderStyle="border:solid 1px #aaa;" >
    <div title="center" region="center" >
    	 <input type="button"  value="复制附件名"  onclick="copyFileName()" style="margin-left: 90px;width: 80px;height: 30px;position: absolute;" />  
         <% if(isPDF == true){ %>
            <iframe id="prodIfm1" width="100%" height="99%"  frameborder="no" border="0" marginwidth="0" marginheight="0"  src="<%=request.getContextPath() %>/commonUtil/iWebOffice/DocumentEdit.jsp?sysid=<%=sysid %>&type=<%=type %>>" ></iframe>  
         <%}else{ if(!"3".equals(type)){%>
             <iframe id="prodIfm1" width="100%" height="99%"  frameborder="no" border="0" marginwidth="0" marginheight="0"  src="<%=request.getContextPath() %>/commonUtil/iWebOffice/OfficeEdit.jsp?sysid=<%=sysid %>&type=<%=type %>" ></iframe>  
         <%}else{%>
            <iframe id="prodIfm1" width="100%" height="99%"  frameborder="no" border="0" marginwidth="0" marginheight="0"  src="<%=request.getContextPath() %>/commonUtil/iWebOffice/OfficeEditTemp.jsp?sysid=<%=sysid %>&type=<%=type %>" ></iframe>  
         <%}} %>
    </div>
</div>
    <script type="text/javascript">
    
   nui.parse();
    
   function save(){
	 document.getElementById("webform").submit();
   }
   //复制文件名到粘贴版，金格目前只支持IE，那么复制功能目前也仅考虑IE。
	function copyFileName(){
		var name="<%=fileName%>";
		window.clipboardData.setData("Text",name);
		nui.alert("复制成功!");
	}
</script>
</body>
</html>