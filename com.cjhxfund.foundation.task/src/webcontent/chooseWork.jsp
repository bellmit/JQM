<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 侯志勇
  - Date: 2017-03-15 17:38:29
  - Description:
-->
<head>
<title>选择要查询的环节</title>
	 <style type="text/css">
	    body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }
    </style>   
</head>
<%
	String processInstID=request.getParameter("processInstID");
 %>
<body>
	<div class="nui-fit">
        <div id="datagrid1" class="nui-datagrid" borderStyle="border-left:0;border-right:0;"
             url="com.cjhxfund.foundation.task.common.queryFinishMyWork.biz.ext";
             style="width:100%;height:100%;" 
             idField="ACTIVITYDEFID"
             dataField="workDatas" 
             allowResize="false" 
             showPager="false"
	       	 multiSelect="false" 
	       	 onrowdblclick="onRowDblClick" 
	       	 selectOnLoad="true">
            <div property="columns">
                <div type="indexcolumn">序号</div>
                <div type="checkcolumn"></div>
                <div field="WORKITEMID" width="30%" headerAlign="center" align="center"  visible="false">工作项ID</div>
                <div field="WORKITEMNAME" width="30%" headerAlign="center" align="center">环节名称</div>                                            
                <div field="ACTIONURL" width="70%" headerAlign="center" align="center" visible="false">环节URL</div>                                            
            </div>
        </div>
    </div>
	<div class="nui-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class='nui-button' plain='false' style="width:60px;" onclick="onOk()">确定</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class='nui-button' plain='false' style="width:60px;" onclick="onCancel()">取消</a>
    </div>

	<script type="text/javascript">
    	nui.parse();
    	var processInstID=<%=processInstID %>;
	    var grid = nui.get("datagrid1");
	    var data={processInstID:processInstID};
		grid.load(data);
		
		function GetData() {
	        var rows = grid.getSelected();
	        return rows;
	    }
		
		function onOk() {
	       CloseWindow("ok");
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	    
	    function onRowDblClick(e) {
	        onOk();
	    }
	    
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
    </script>
</body>
</html>