<%@page import="java.net.URLDecoder"%>
<%@page import="com.cjhxfund.commonUtil.ParamConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 陈鹏
  - Date: 2016-11-14 16:02:33
  - Description:
-->
<head>
<title>批量处理反馈</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
		
		
    <%
    	String retrunText = request.getParameter("retrunText");   	//反馈记录
    	retrunText = URLDecoder.decode(retrunText,"utf-8");  
    	String[] retrunTextArr = retrunText.split(";");			  	//分拆反馈记录
 		String fulCount = request.getParameter("fulCount");		  	//成功条数
 		String failureCount = request.getParameter("failureCount"); //失败条数
 		String total = request.getParameter("total");				//总条数
 		String remaining = request.getParameter("remaining");       //剩余需要弹窗处理的条数
 		if(fulCount.equals("undefined")){
 			fulCount = "0";
 		}
 		
 		if(failureCount.equals("undefined")){
 			failureCount = "0"; 
 		}
     %>
     <style type="text/css">
     	td{
     		border-bottom: 1px solid #D3D3D3;
     		border-right: 1px solid #D3D3D3;
     	}
     	.td1{
     		border-left: 1px solid #D3D3D3;
     	}
     	.td2{
     		border-top: 1px solid #D3D3D3;
     	}
     	
     </style>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;">
<div style="height: 90%;">
	<table  style="width:99%;table-layout:fixed;margin: 2px 2px 0px 2px;" border="0" cellspacing="0" cellpadding="0" >
		<colgroup>
			<col width="15%"></col>
			<col width="25%"></col>
			<col width="40%"></col>
			<col width="20%"></col>
		</colgroup>
		<tr>
			<td colspan="4" class="td1 td2">
				<h4 style="margin-left: 5px;">
					总计<%=total %>条数据:成功<span style="color: red;"><%=fulCount %></span>条;失败<span style="color: red;"><%=failureCount %></span>条;还有<span style="color: red;"><%=remaining %></span>条数据需要弹窗处理
				</h4>
			</td>
		</tr>
		<tr align="center">
			<td class="td1">编号</td>
			<td>债券编码</td>
			<td>债券名称</td>
			<td>处理状态</td>
		</tr>
	  <%
	  	  String[] textArr = null;
	  	  for(int i=1;i<retrunTextArr.length;i++){
	  	  	textArr = retrunTextArr[i].split(",");     //分拆详细处理数据
	  	  	if(textArr[4].equals("1")){
	   %>	
		<tr>
			<td class="td1"  align="center"><%=textArr[0] %></td>
			<td><%=textArr[1] %></td>
			<td><%=textArr[2] %></td>
			<td  align="center"><%=textArr[3] %></td>
		</tr>
	  <%
	  	}else{
	   %>
	   	<tr style="color: red;">
			<td class="td1"  align="center"><%=textArr[0] %></td>
			<td><%=textArr[1] %></td>
			<td><%=textArr[2] %></td>
			<td  align="center"><%=textArr[3] %></td>
		</tr>
	   <%	
	  	}
	   %>
	  <%
	  	}
	   %>	
	</table>
</div>	
<div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
	<table width="100%">
		<tr>
			<td style="text-align:center;border: none;" colspan="4">
				<% if(Integer.valueOf(remaining) != 0){ %>
					<a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">
                                                                       弹窗处理
					</a>
                    <span style="display:inline-block;width:25px;"></span>
                 <% }%>    
					<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
                                                                      关闭
                    </a>
			</td>
		</tr>
	</table>
</div>
	<script type="text/javascript">
    	nui.parse();
    	
    	//关闭窗口
        function CloseWindow(action) {
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
				else window.close();
		}
		
		function onOk(){
			CloseWindow("ok");
		}
		
		function onCancel(){
			CloseWindow("no");
		}
			
    </script>
</body>
</html>