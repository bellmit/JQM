<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2015-10-14 10:47:44
- Description: 产品权限配置
--%>
<head>
<title>产品权限配置</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div class="nui-tabs" id="tab" activeIndex="0" style="width:100%;height:100%;">
		<div title="产品权限配置">
		   <%-- 查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				   <div id="form1" class="nui-form" style="padding:2px;" align="center" >
		            <!-- 数据实体的名称 -->
		            <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.singleDataset.CfJyCombProductHandle">
		            <!-- 排序字段 -->
		            <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="relaType">
		            <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc">
		            <input class="nui-hidden" name="criteria/_orderby[2]/_property" value="userId">
		            <input class="nui-hidden" name="criteria/_orderby[2]/_sort" value="asc">
		            <input class="nui-hidden" name="criteria/_orderby[3]/_property" value="combProductCode">
		            <input class="nui-hidden" name="criteria/_orderby[3]/_sort" value="asc">
		            <table id="table1" class="table" style="height:100%;table-layout:fixed;">
		                <tr>
		                    <td class="form_label" width="10%">
		                        权限类型:
		                    </td>
		                    <td colspan="1" width="20%" align="left">
		                        <input class="nui-dictcombobox" name="criteria/_expr[1]/relaType" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE"  
									emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
								<input class="nui-hidden" name="criteria/_expr[1]/_op" value="in"/>
		                    </td>
		                    <td class="form_label" width="10%">
		                        用户姓名:
		                    </td>
		                    <td colspan="1" width="20%" align="left">
		                        <input class="nui-textbox" name="criteria/_expr[2]/userName"/>
		                        <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
		                        <input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
		                    </td>
		                    <td class="form_label" width="10%">
		                        产品代码:
		                    </td>
		                    <td colspan="1" width="20%" align="left">
		                        <input class="nui-textbox" name="criteria/_expr[3]/combProductCode"/>
		                        <input class="nui-hidden" name="criteria/_expr[3]/_op" value="like">
		                        <input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
		                    </td>
		                   <td colspan="1" rowspan="2" width="10%" align="left">
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
	                        </td> 
		              </tr>
		              <tr>      
		                    <td class="form_label" width="10%">
		                        产品名称:
		                    </td>
		                    <td colspan="1" width="20%" align="left">
		                        <input class="nui-textbox" name="criteria/_expr[4]/combProductName"/>
		                        <input class="nui-hidden" name="criteria/_expr[4]/_op" value="like">
		                        <input class="nui-hidden" name="criteria/_expr[4]/_likeRule" value="all">
		                    </td>
		                    <td class="form_label" width="10%" >
		                        投资组合编号:
		                    </td>
		                    <td colspan="1" width="20%" align="left">
		                        <input class="nui-textbox" name="criteria/_expr[5]/vcCombiNo"/>
		                        <input class="nui-hidden" name="criteria/_expr[5]/_op" value="like">
		                        <input class="nui-hidden" name="criteria/_expr[5]/_likeRule" value="all">
		                    </td>
		                    <td class="form_label" width="10%">
		                        投资组合名称:
		                    </td>
		                    <td colspan="1" width="20%" align="left">
		                        <input class="nui-textbox" name="criteria/_expr[6]/vcCombiName"/>
		                        <input class="nui-hidden" name="criteria/_expr[6]/_op" value="like">
		                        <input class="nui-hidden" name="criteria/_expr[6]/_likeRule" value="all">
		                    </td>
		                    
		                </tr>
		            </table>
		         </div>
			  </div>
		   </div>
		   <%-- 查询条件结束!!! --%>
		   
		   
		   <%-- 产品权限配置列表开始... --%>
		   <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add()">
                                增加
                            </a>
                            <!-- 
                            <a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">
                                编辑
                            </a>
                             -->
                            <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()">
                                删除
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div 
                        id="datagrid1"
                        dataField="cfjycombproducthandles"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.CFJYCombProductHandleBiz.queryCFJYCombProductHandles.biz.ext"
                        pageSize="50"
                        showPageInfo="true"
                        allowSortColumn="true"
                        sortMode="client"
                        enableHotTrack="true"
                        allowHeaderWrap="true"
                        sizeList="[10,20,50,100]"
                        allowCellEdit="true"
						allowCellSelect="true"
						enterNextCell="true"
						allowMoveColumn="true"
						editNextOnEnterKey="true"
						multiSelect="true"   showfooter="false">

                    <div property="columns">
                        <div type="indexcolumn">
                        </div>
                        <div type="checkcolumn">
                        </div>
                        <div field="relaType" name="relaType" headerAlign="center" allowSort="true" align="left" renderer="renderRelaType" width="130px">
                            权限类型
                        </div>
                        <div field="userName" name="userName" headerAlign="center" allowSort="true" align="left" width="80px">
                            用户姓名
                        </div>
                        <div field="combProductCode" headerAlign="center" allowSort="true" align="left" width="80px">
                            产品代码
                        </div>
                        <div field="combProductName" headerAlign="center" allowSort="true" align="left" width="150px">
                            产品名称
                        </div>
                        <div field="vcCombiNo" headerAlign="center" allowSort="true" align="left" width="100px">
                            投资组合编号
                        </div>
                        <div field="vcCombiName" headerAlign="center" allowSort="true" align="left" width="130px">
                            投资组合名称
                        </div>
                        <div field="vcAssetId" headerAlign="center" allowSort="true" align="left" width="80px">
                            资产单元序号
                        </div>
                    </div>
                </div>
            </div>
		    <%-- 产品权限配置列表结束!!! --%>
		   
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
			url: "<%=request.getContextPath()%>/ProductProcess/CFJYCombProductHandleForm.jsp",
			title: "新增权限", width: 600, height: 400,
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
				url: "<%=request.getContextPath()%>/ProductProcess/CFJYCombProductHandleForm.jsp",
				title: "编辑权限",
				width: 600,
				height: 300,
				onload: function () {
					var iframe = this.getIFrameEl();
					var data = {pageType:"edit",record:{cfjycombproducthandle:row}};
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
					var json = nui.encode({cfjycombproducthandles:rows});
					grid.loading("正在删除中,请稍等...");
					$.ajax({
						url:"com.cjhxfund.jy.ProductProcess.CFJYCombProductHandleBiz.deleteCFJYCombProductHandles.biz.ext",
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
		//nui.get("update").enable();
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
		//var rows = grid.getSelecteds();
		//if(rows.length>1){
		//	nui.get("update").disable();
		//}else{
		//	nui.get("update").enable();
		//}
	}
	
	//关系类型处理
    function renderRelaType(e) {
		return nui.getDictText("CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE",e.row.relaType);
	}
	
	//合并单元格
	grid.on("load", function () {
    	grid.mergeColumns(["relaType", "userName"]);
    });
</script>

</body>
</html>
