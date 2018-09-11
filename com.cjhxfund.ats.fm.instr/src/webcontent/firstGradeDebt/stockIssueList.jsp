<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>
<html>
<!-- 
>   - Author(s): 黄燕
>   - Date: 2016-11-29 15:53:38
>   - Description:
> -->
<head>
<title>债券信息</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
	<div class="nui-toolbar" style="text-align:center;line-height:30px;" borderStyle="border:0;">
		<div id="form" class="nui-form" style="padding:2px;" align="center" style="height:10%">
		 

          <label >债券代码：</label>
          <input class="nui-textbox" id="vcStockCode" name="paramMap/vcStockCode" style="width:150px;" onenter="onKeyEnter"/>
          <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_CPXX()"/>
        </div>
    </div>
    <div class="nui-fit">

        <div id="datagrid_CPXX"
        	class="nui-datagrid"
        	style="width:100%;height:100%;"
            borderStyle="border-left:0;border-right:0;"
            dataField="issueInfo"
            url="com.cjhxfund.ats.fm.instr.FirstGradeBond.getVcStockCode.biz.ext"
            pageSize="20"
            onrowdblclick="onrowclick"
            showPageInfo="true"
            allowSortColumn="true" sortField="lStockIssueId" sortOrder="desc">

            <div property="columns">
            	<div type="indexcolumn"></div>
            	<div type="checkcolumn"></div>
            	<div field="lStockIssueId" width="100" headerAlign="center" allowSort="true" align="center" visible="false">业务序号</div>
                <div field="vcStockCode" width="100" headerAlign="center" allowSort="true" align="center">债券代码</div>
                <div field="vcStockName" width="100%" headerAlign="center" allowSort="true" align="left">债券简称</div>
                <div field="cMarketNo" width="80" headerAlign="center" align="center" renderer="marketname">交易市场</div>
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
	    var grid = nui.get("datagrid_CPXX");
	    grid.load(new nui.Form("form").getData(false,false));//grid查询
	    
	    function marketname(e){
		    if(e.row.cMarketNo == "1"){
		    	return "上交所A";
		    }else if(e.row.cMarketNo == "2"){
		    	return  "深交所A";
		    }else if(e.row.cMarketNo == "5"){
		    	return "银行间";
		    }else{
		    	return "其他";
		    }
	    }
	    
	    function search_CPXX(){
		    var form = new nui.Form("#form");
			var json = form.getData(false,false);
			grid.load(json);//grid查询
	    }
	    
	    function onKeyEnter(e) {
	        search_CPXX();
	    }
	
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	    
	    function onrowclick(e){
	    	CloseWindow(e.record.vcStockCode+"|"+e.record.lStockIssueId);
	    }
	    function onOk() {
	        var row = grid.getSelected();
	        if(row){
	        	CloseWindow(row.vcStockCode+"|"+row.lStockIssueId);
	        }else{
	        	CloseWindow("cancel");
	        }
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	</script>
</body>
</html>
