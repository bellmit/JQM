<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<%--
- Author(s): 杨敏  用于O32头寸 的分组和标签 选择产品
- Date: 2016-03-11 14:35:39
--%>
<head>
<title>综合信息查询-产品信息</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
	<div class="nui-toolbar" style="text-align:center;line-height:30px;" borderStyle="border:0;">
		<div id="form" class="nui-form" style="padding:2px;" align="center" style="height:10%">
		  
          <label >代码/名称：</label>
          <input id="searchKey" name="productName" class="nui-textbox" style="width:150px;" onenter="onKeyEnter"/>
          <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_CPXX()"/>
        </div>
    </div>
    <div class="nui-fit">

        <div id="datagrid_CPXX"
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
            url="com.cjhxfund.jy.ProductProcess.o32tcjc.queryUserAssetRight.biz.ext"
            allowSortColumn="true"
            sortMode="client"
            showPager="false"
            >
            <div property="columns">
            	<div type="indexcolumn"></div>
            	<div type="checkcolumn"></div>
            	
                <div field="vcProductCode" headerAlign="center" allowSort="true" align="center">产品代码</div>
                <div field="vcProductName"  headerAlign="center" allowSort="true" align="left">产品名称</div>
                <div field="vcAssetName"  headerAlign="center" allowSort="true" align="left">资产单元名称</div>
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
	    
	    var grid = nui.get("datagrid_CPXX");
	    grid.load(new nui.Form("form").getData(false,false));//grid查询
	    
	    function search_CPXX(){
		    search(grid, "form");
	    }
	    
	    //查询--所有业务通用
		function search(grid_search, form_id) {
	    	var form = new nui.Form(form_id);
	    	form.validate();
			if(form.isValid()==false) return;
	    	var json = form.getData(false,false);
	    	grid_search.load(json);//grid查询
		}
	
	    function onKeyEnter(e) {
	        search_CPXX();
	    }
	    
	    //Grid加载完成后选中之前已选中的记录
	    function onGridLoad(e) {
	    	var rows = selectArr;
	        if(rows) grid.selects(rows);
	    }
	    
	    //设置数据
	    function SetData(data){
	      /* data = nui.clone(data);
	       var vcProductCodes = data.vcProductCodes.split(",");
	       var vcProductNames = data.vcProductNames.split(",");
	       if(vcProductCodes!=""){
		       for(var i=0;i<vcProductCodes.length;i++){
		       	  var vcProductCode = vcProductCodes[i];
		       	  var vcProductName = vcProductNames[i];
		       	  var row = {vcProductCode:vcProductCode, vcProductName:vcProductName};
		       	  selectArr.push(row);
		       	  //回填之前选中的数据 
		       	  onGridLoad();
		       }
	       }*/
	    }
	    //获取数据
	    function GetData() {
	        var rows = selectArr;
	       
	        return rows;
	    }
	    //行选中时发生
	    function onSelect(e){
	    	var record = e.record;
	    	var isExist = false;
	    	for(var i=0; i<selectArr.length; i++){
	    		var row = selectArr[i];
	    		if(row.lAssetId==record.lAssetId){
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
	    		if(row.lAssetId!=record.lAssetId){//将原来数组中不等于取消选中行的记录重新放回去
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
	    	if(selectArr.length>100){
	    		nui.alert("最多只能选择100条哦~");
	    		return;
	    	}
	        CloseWindow("ok");
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	</script>
</body>
</html>
