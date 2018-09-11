<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>	
<!-- 
  - Author(s): 周林
  - Date: 2017-11-28 14:01:57
  - Description:
-->

<head>
<title>申购模板要素</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
	<script type="text/javascript" src="<%=request.getContextPath() %>/fm/baseinfo/applyTemplet/js/swfupload.js"></script>
	
<body style="width:100%;height:100%;overflow:height; margin: 0px;">
	<div class="search-condition">
		<div class="list">
			<div id="form1" class="nui-form" align="center" style="height: 10%">
				<!-- 排序字段 -->
				<form id="queryForm" action="">
					<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.fm.baseinfo.stockTemplate.TAtsStockTemplateElements">
					<input class="nui-hidden" name="criteria/_orderby[1]/_property" value="dCreateTime">
	                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc">
					<table id="table1" border="0" cellpadding="1" cellspacing="1" style="width: 100%; table-layout: fixed;">
					 <tr>
			                
			                <td style="width: 10%" align="right">要素代号:</td>
							<td style="width:15%" align="left">
	                            <input class="nui-textbox" name="criteria/_expr[1]/vcElementPlaceholder"  width="100%"/>
                    			<input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
                    			<input class="nui-hidden" name="criteria/_expr[1]/_likeRule" value="all">
			                </td>
			                
			                <td style="width:10%; " align="right">要素名称:</td>
		                    <td style="width:15%" align="left" >
		                    	<input class="nui-textbox" name="criteria/_expr[2]/vcElementName"  width="100%" />
		                    	<input class="nui-hidden" name="criteria/_expr[2]/_op" value="like" width="100%" />
		                    	<input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
		                    </td>
		                    
							<td align="left" style="width:25%">
							<a class='nui-button' plain='false'	iconCls="icon-search" onclick="search()"> 查询 </a>&nbsp;
					    	<a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()"> 重置 </a>
					    	</td>
					  </tr>
					</table>
				</form>
			</div>
		</div>
	</div>
   <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class='nui-button' plain='false' iconCls="icon-add" onclick="add()">
                        	增加
                    </a>&nbsp;
                    <a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">
                      	              修改
                    </a>&nbsp;
                    <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()">
                         	删除
                    </a>
                </td>
            </tr>
       </table>
    </div>
    <div id="layout1" class="mini-layout" style="width:100%; height:89%;"  borderStyle="border:solid 1px #aaa;">       
		<div title="center" region="center"  >
		 	<div class="nui-fit">
				<div id="datagrid1" class="nui-datagrid"
					dataField="tatsstocktemplateelementss" style="width: 100%; height: 100%;"
					url="com.cjhxfund.ats.fm.baseinfo.tatsstocktemplateelementsbiz.queryTAtsStockTemplateElementss.biz.ext"
					pageSize="50" onShowRowDetail="onShowRowDetailList" sortField="vcElementName" sortOrder="desc"
					showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" >
					<div property="columns">
						<div type="indexcolumn"></div>
						<div type="checkcolumn"></div>
						<div field="vcElementName" width="190" headerAlign="center" align="center">要素名称</div>
						<div field="vcElementPlaceholder" width="90" headerAlign="center" align="center" allowSort="true">要素代号</div>
						<div field="vcCreator" width="100" headerAlign="center" align="center" allowSort="true">制作人</div>
						<div field="dCreateTime" width="100" headerAlign="center" align="center" allowSort="true">创建时间</div>
						<div field="dUpdateTime" width="100" headerAlign="center" align="center" allowSort="true">更新时间</div>
					</div>
				</div>
			</div>
		</div>	
	</div>
	<script type="text/javascript">
		nui.parse();
        var grid = nui.get("datagrid1");

        var formData = new nui.Form("#form1").getData(false,false);
        grid.load(formData);

        //新增
        function add() {
            nui.open({
                url: "<%=request.getContextPath() %>/fm/baseinfo/stockTemplate/stockTemplateElementsForm.jsp",
                title: "新增模板元素", width: 400, height: 200,
                allowResize: false,
                onload: function () {//弹出页面加载完成
                var iframe = this.getIFrameEl();
                var data = {pageType:"add"};//传入页面的json数据
                iframe.contentWindow.setFormData(data);
                },
                ondestroy: function (action) {//弹出页面关闭前
                grid.reload();
            }
            });
        }

        //编辑
        function edit() {
            var row = grid.getSelected();
            if (row) {
                nui.open({
                    url: "<%=request.getContextPath() %>/fm/baseinfo/stockTemplate/stockTemplateElementsForm.jsp",
                    title: "编辑模板元素",
                    width: 400,
                    height: 200,
                    allowResize: false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = {pageType:"edit",record:{tatsstocktemplateelements:row}};
                        //直接从页面获取，不用去后台获取
                        iframe.contentWindow.setFormData(data);
                        },
                        ondestroy: function (action) {
                            grid.reload();
                        }
                });
            } else {
                nui.alert("请选中一条记录","提示");
            }
        }

        //删除
        function remove(){
            var rows = grid.getSelecteds();
            if(rows.length > 0){
                nui.confirm("确定删除选中记录？","系统提示",
                function(action){
                    if(action=="ok"){
                        var json = nui.encode({tatsstocktemplateelementss:rows});
                        grid.loading("正在删除中,请稍等...");
                        $.ajax({
                            url:"com.cjhxfund.ats.fm.baseinfo.tatsstocktemplateelementsbiz.deleteTAtsStockTemplateElementss.biz.ext",
                            type:'POST',
                            data:json,
                            cache: false,
                            contentType:'text/json',
                            success:function(text){
                                var returnJson = nui.decode(text);
                                if(returnJson.exception == null){
                                    grid.reload();
                                    nui.alert("删除成功", "系统提示", function(action){
                                        });
                                    }else{
                                        grid.unmask();
                                        nui.alert("删除失败", "系统提示");
                                    }
                                }
                        });
                    }
                });
            }else{
                nui.alert("请选中一条记录！");
            }
        }

        //重新刷新页面
        function refresh(){
            var form = new  nui.Form("#form1");
            var json = form.getData(false,false);
            grid.load(json);//grid查询
            nui.get("update").enable();
        }

        //查询
        function search() {
            var form = new nui.Form("#form1");
            var json = form.getData(false,false);
            grid.load(json);//grid查询
        }

        //重置查询条件
        function reset(){
            var form = new nui.Form("#form1");//将普通form转为nui的form
            form.reset();
        }

        //enter键触发查询
        function onKeyEnter(e) {
            search();
        }

        //当选择列时
        function selectionChanged(){
            var rows = grid.getSelecteds();
            if(rows.length>1){
                nui.get("update").disable();
            }else{
                nui.get("update").enable();
            }
        }
		</script>
	</body>
</html>