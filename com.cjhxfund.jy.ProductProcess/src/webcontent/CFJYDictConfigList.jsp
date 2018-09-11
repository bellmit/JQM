<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2015-11-09 14:12:12
- Description: 数据字典映射配置
--%>
<head>
<title>数据字典映射配置</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div class="nui-tabs" id="tab" activeIndex="0" style="width:100%;height:100%;">
		<div title="数据字典映射配置">
		   <%-- 查询条件开始... --%>
		   <div class="search-condition">
			  <div class="list">
				   <div id="form1" class="nui-form" align="center" style="height:100%">
					<!-- 数据实体的名称 -->
					<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.singleDataset.CfJyDictConfig">
					<!-- 排序字段 -->
					<input class="nui-hidden" name="criteria/_orderby[1]/_property" value="dictType">
					<input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc">
					<input class="nui-hidden" name="criteria/_orderby[2]/_property" value="dictId">
					<input class="nui-hidden" name="criteria/_orderby[2]/_sort" value="asc">
					<table id="table1" class="table" style="height:100%">
					  <tr>
					      <td class="form_label" width="7%">
					          字典类型:
					      </td>
					      <td colspan="1" width="20%">
					          <input class="nui-dictcombobox" name="criteria/_expr[1]/dictType" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_DICT_CONFIG_DICT_TYPE"  
									emptyText="全部" nullItemText="全部" showNullItem="true" />
							  <input class="nui-hidden" name="criteria/_expr[1]/_op" value="="/>
					      </td>
					      <td class="form_label" width="10%">
					          字典名称:
					      </td>
					      <td colspan="1" width="20%">
					          <input class="nui-textbox" name="criteria/_expr[2]/dictName"/>
					          <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
					          <input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
					      </td>
					      <td class="form_label" width="10%">
					          恒生字典名称:
					      </td>
					      <td colspan="1" width="20%">
					          <input class="nui-textbox" name="criteria/_expr[3]/dictNameHs"/>
					          <input class="nui-hidden" name="criteria/_expr[3]/_op" value="like">
					          <input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
					      </td>
					      <td colspan="1" width="13%">
	                          <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
	                      </td>
					  </tr>
					</table>
				   </div>
			  </div>
		   </div>
		   <%-- 查询条件结束!!! --%>
		   
		   
		   <%-- 数据字典映射配置列表开始... --%>
		   <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add()">
					              增加
					        </a>
					        <a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">
					              编辑
					        </a>
					        <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()">
					              删除
					        </a>
					        <a class='nui-button' plain='false' iconCls="icon-reload" onclick="reloadFun()">
					              刷新缓存
					        </a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div 
				      id="datagrid1"
                      dataField="cfjydictconfigs"
                      class="nui-datagrid"
                      style="width:100%;height:100%;"
                      url="com.cjhxfund.jy.ProductProcess.CFJYDictConfigBiz.queryCFJYDictConfigs.biz.ext"
                      pageSize="20"
                      showPageInfo="true"
                      multiSelect="true"
                      onselectionchanged="selectionChanged"
                      allowSortColumn="true"
                      sortMode="client"
                      sizeList="[10,20,50,100]">
				
				  <div property="columns">
				      <div type="indexcolumn"></div>
				      <div type="checkcolumn"></div>
				      <div field="dictType" headerAlign="center" allowSort="true" align="center" renderer="renderDictType" >
				          字典类型
				      </div>
				      <div field="dictId" headerAlign="center" allowSort="true" align="center" >
				          字典ID
				      </div>
				      <div field="dictName" headerAlign="center" allowSort="true" align="center" >
				          字典名称
				      </div>
				      <div field="dictIdHs" headerAlign="center" allowSort="true" align="center" >
				          恒生字典ID
				      </div>
				      <div field="dictNameHs" headerAlign="center" allowSort="true" align="center" >
				          恒生字典名称
				      </div>
				      <div field="sortNo" headerAlign="center" allowSort="true" align="center" >
				          显示顺序
				      </div>
				      <div field="remark" headerAlign="center" allowSort="true" align="left" >
				          备注信息
				      </div>
				  </div>
				</div>
            </div>
		    <%-- 数据字典映射配置列表结束!!! --%>
		   
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
			url: "<%=request.getContextPath()%>/ProductProcess/CFJYDictConfigForm.jsp",
			title: "新增记录",
			width: 700,
			height: 235,
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
				url: "<%=request.getContextPath()%>/ProductProcess/CFJYDictConfigForm.jsp",
				title: "编辑数据",
				width: 700,
				height: 235,
				onload: function () {
					var iframe = this.getIFrameEl();
					var data = {pageType:"edit",record:{cfjydictconfig:row}};
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
			nui.confirm("确定删除选中记录？","系统提示", function(action){
				if(action=="ok"){
					var json = nui.encode({cfjydictconfigs:rows});
					grid.loading("正在删除中,请稍等...");
					$.ajax({
						url:"com.cjhxfund.jy.ProductProcess.CFJYDictConfigBiz.deleteCFJYDictConfigs.biz.ext",
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
	
	//刷新缓存
	function reloadFun(){
		$.ajax({
			url:"com.cjhxfund.jy.ProductProcess.CFJYDictConfigBiz.clearDictInfoMap.biz.ext",
			type:'POST',
			data:null,
			cache: false,
			contentType:'text/json',
			success:function(text){
				var returnJson = nui.decode(text);
				if(returnJson.exception == null){
					nui.alert("刷新缓存成功", "系统提示", function(action){
					});
				}else{
					nui.alert("刷新缓存失败", "系统提示");
				}
			}
		});
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
	
	//字典类型处理
    function renderDictType(e) {
		return nui.getDictText("CF_JY_DICT_CONFIG_DICT_TYPE",e.row.dictType);
	}
</script>
</body>
</html>