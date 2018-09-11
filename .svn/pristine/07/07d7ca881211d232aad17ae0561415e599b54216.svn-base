<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>

<html>
<!-- 
  - Author(s): 陈鹏
  - Date: 2016-08-18 16:32:02
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
	
	
	<script	src="<%= request.getContextPath() %>/comm/util/process.js" type="text/javascript"></script>
    
    <style type="text/css">
      .td1{
        border-right: 1px solid #D3D3D3;
        border-left: 1px solid #D3D3D3;
      }
      .td2{
        border-right: 1px solid #D3D3D3;
      }
      .asLabel .mini-textbox-input{
        color: red;
        background:none;cursor:default;
      }
      .asLabel_gray .mini-textbox-input{
         color: black;
         background:none;cursor:default;
      }
      
      .p{
           border-bottom: 1px solid #D3D3D3;     
        }
        P{
          margin: 0px;padding: 0px;
        }
        
    </style>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;margin: 0px;">
	<div id="tabs" class="nui-tabs" height="100%">
		<div title="基本信息"></div>
		<div title="审批内容">
		   <%@include file="/comm/processControl.jsp" %>
		</div>
		<div title="流程信息" url="com.cjhxfund.ats.fm.comm.processGraph.flow?processInstID=130&workItemID="></div>
		<div title="产品投资范围" url="<%=request.getContextPath() %>/process/FirstGradeBond/ProductInvestmentRange.jsp?combProductCode="></div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	//获取应用名称
    	var contextPath = '<%=request.getContextPath() %>';
    </script>
</body>
</html>