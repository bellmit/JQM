<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<%--
- Author(s): tongwei
- Date: 2017-05-26 14:35:39
- Description: 指令/建议页面产品组合选择页
--%>
<head>
<title>指令/建议-产品信息</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body>
	<div class="nui-toolbar" style="text-align:center;line-height:30px;" borderStyle="border:0;">
		<div id="form" class="nui-form" style="padding:2px;" align="center" style="height:10%">
          <label >代码/名称：</label>
          <input id="productCode" name="productCode" class="nui-textbox" style="width:150px;" onenter="onKeyEnter"/>
          <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_productInfo()"/>
        </div>
    </div>
    <div class="nui-fit">

        <div id="datagrid_productInfouctInfo"
        	class="nui-datagrid"
        	style="width:100%;height:100%;"
            idField="vcProductCode"
            allowResize="true"
            borderStyle="border-left:0;border-right:0;"
            multiSelect="true"
            onload="onGridLoad"
            onselect="onSelect"
            ondeselect="onDeselect"
            dataField="data"
            url="com.cjhxfund.ats.sm.inquiry.financeGapManage.queryFinanceProductHandle.biz.ext"
            pageSize="50"
            showPageInfo="true"
            allowSortColumn="true"
            sortMode="client"
            sizeList="[20,50,100,500]">
            <div property="columns">
            	<div type="indexcolumn"></div>
            	<div type="checkcolumn"></div>
                <div field="vcProductCode" width="100" headerAlign="center" allowSort="true" align="center">产品代码</div>
                <div field="vcProductName" width="100%" headerAlign="center" allowSort="true" align="left">产品名称</div>
            </div>
        </div>
    </div>
    
    <div class="nui-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class='nui-button' iconCls="icon-ok" plain='false' style="width:60px;" onclick="onOk()">确定</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class='nui-button' iconCls="icon-cancel" plain='false' style="width:60px;" onclick="onCancel()">取消</a>
    </div>
	
	
	<script type="text/javascript">
	    nui.parse();
	    
	    var selectArr = [];//已选的记录数组
	    
	    var grid = nui.get("datagrid_productInfouctInfo");
	    grid.load(new nui.Form("form").getData(false,false));//grid查询
	    
	    function search_productInfo(){
		    search(grid, "form");
	    }
	    function onKeyEnter(e) {
	        search_productInfo();
	    }
	    
	    //Grid加载完成后选中之前已选中的记录
	    function onGridLoad(e) {
	    	var rows = selectArr;
	        if(rows) grid.selects(rows);
	    }
	    
	    //设置数据
	    function SetData(data){
	       data = nui.clone(data);
	       var fundCodes = data.fundCodes.split(",");
	       var fundNames = data.fundNames.split(",");
	       if(fundCodes!=""){
		       for(var i=0;i<fundCodes.length;i++){
		       	  var fundCode = fundCodes[i];
		       	  var fundName = fundNames[i];
		       	  var row = {vcProductCode:fundCode, vcProductName:fundName};
		       	  selectArr.push(row);
		       }
	       }
	    }
	    //获取数据
	    function GetData() {
	        var rows = selectArr;
	        var fundCodes = [], fundNames = [];
	        for (var i = 0, l = rows.length; i < l; i++) {
	            var row = rows[i];
	            fundCodes.push(row.vcProductCode);
	            fundNames.push(row.vcProductName);
	        }
	        var data = {};
	        data.vcProductCode = fundCodes.join(",");
	        data.vcProductName = fundNames.join(",");
	        return data;
	    }
	    //行选中时发生
	    function onSelect(e){
	    	var record = e.record;
	    	var isExist = false;
	    	for(var i=0; i<selectArr.length; i++){
	    		var row = selectArr[i];
	    		if(row.vcProductCode==record.vcProductCode){
	    			isExist = true;//若之前已选中，则直接返回
	    			break;
	    		}
	    	}
	    	//若之前尚未选中该记录，则新增该记录到数组中
	    	if(isExist==false){
	    		selectArr.push(record);
	    	}
	    }
	    //行取消选中时发生
	    function onDeselect(e){
	    	var record = e.record;
	    	var selectArrTemp = selectArr;//将原数组赋予临时数组
	    	selectArr = [];//将原数组清空，重新赋值
	    	for(var i=0; i<selectArrTemp.length; i++){
	    		var row = selectArrTemp[i];
	    		if(row.vcProductCode!=record.vcProductCode){//将原来数组中不等于取消选中行的记录重新放回去
	    			selectArr.push(row);
	    		}
	    	}
	    }
	
	    //////////////////////////////////
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	    function onOk() {
	        window.CloseOwnerWindow("ok");
	    }
	    function onCancel() {
	       window.CloseOwnerWindow("cancel");
	    }
	    
	    //查询--所有业务通用
		function search(grid_search, form_id) {
		    var form = new nui.Form(form_id);
		    form.validate();
			if(form.isValid()==false) return;
		    var json = form.getData(false,false);
		    grid_search.load(json);//grid查询
		}
	</script>
</body>
</html>