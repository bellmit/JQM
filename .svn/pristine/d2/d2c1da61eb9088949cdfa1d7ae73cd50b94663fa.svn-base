<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>

<!-- 
  - Author(s): zhangyao
  - Date: 2016-12-06 16:13:30
  - Description:
-->
<head>
    <title>选择研究员</title>
    
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
    <div id="form1" class="nui-toolbar" style="text-align:center;line-height:30px;" borderStyle="border:0;">
          <label>姓名：</label>
          <input name="researchar/empName" class="nui-textbox" style="width:150px;" onenter="onKeyEnter" emptyText="请输入研究员姓名"/>
          <a class='nui-button' plain='false' style="width:60px;" onclick="search()">查询</a>
    </div>
    <div class="nui-fit">
        <div id="datagrid1" class="nui-datagrid" borderStyle="border-left:0;border-right:0;"
             url="com.cjhxfund.ats.ipo.busOpr.queryIpoResearcher.biz.ext";
             style="width:100%;height:100%;" 
             idField="empId"
             dataField="researcharInfos" 
             allowResize="true"
             sizeList="[10,20,30,50]"
	       	 pageSize="10"
	       	 multiSelect="true"
             onrowdblclick="onRowDblClick"
             onload="onGridLoad" onselectionchanged="onSelectoinChanged">
            <div property="columns">
                <div type="indexcolumn">序号</div>
                <div type="checkcolumn"></div>
                <div field="empId" width="30%" headerAlign="center" align="center" allowSort="true">用户ID</div>                                            
                <div field="empName" width="70%" headerAlign="center" align="center" allowSort="true">研究员姓名</div>                                            
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
		grid.load();
		
		function GetSelecteds() {
	        var rows = grid.getSelecteds();
	        return rows;
	    }
	
	    var selectMaps = {};
	    function GetAllSelecteds() {
	        var data = [];
	        for(var pageIndex in selectMaps){
	            var rows = selectMaps[pageIndex];
	            data.addRange(rows);
	        }
	        return data;
	    }
	    function GetData() {
	        var rows = GetAllSelecteds();
	        var ids = [], texts = [];
	        for (var i = 0, l = rows.length; i < l; i++) {
	            var row = rows[i];
	            ids.push(row.empId);
	            texts.push(row.empName);
	        }
	        var data = {};
	        data.id = ids.join(",");
	        data.text = texts.join(",");
	        return data;
	    }
		function onGridLoad(e) {
	        var rows = selectMaps[grid.getPageIndex()];
	        if(rows) grid.selects(rows);
	    }
	    function onSelectoinChanged(e) {
	        var rows = grid.getSelecteds();
	        selectMaps[grid.getPageIndex()] = rows;
	    }
	    
	    //查询
	    function search(){
	    	var form=new nui.Form("#form1");
			json = form.getData(false,false);
			grid.load(json);
		}
	   
	    function onKeyEnter(e) {
	        search();
	    }
	    function onRowDblClick(e) {
	        onOk();
	    }
	    //////////////////////////////////
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	
	    function onOk() {
	    	var rows = grid.getSelecteds();
	    	var json={processInstID:processInstID,users:rows};
	    	nui.ajax({
				url : "com.cjhxfund.ats.ipo.task.setSearcher.biz.ext",
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if (returnJson.exception == null) {
						CloseWindow("ok");
					} else {
						nui.alert("设置失败", "系统提示", function(action) {
							if (action == "ok" || action == "close") {
								//CloseWindow("saveFailed");
							}
						});
					}
				}
			});
	    	
				    	
	       // CloseWindow("ok");
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }


</script>
</body>
</html>
