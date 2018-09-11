<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): liangjilong
  - Date: 2016-11-25 13:30:52
  - Description:
-->
<head>
<title>参数检测查询</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	html,body{
    		overflow-x:hidden;
    	}
    </style>
</head>
<body>
	<div style="margin:0px 2px 0px 2px;width:100%;height:100%" >
		<div class="nui-tabs" id="tab" activeIndex="0" style="width:100%;height:100%;">
			<div title="参数检测">
			   <%-- 查询条件开始... --%>
			   <div class="nui-fit" >
				  <div class="list">
					   <div id="form1" class="nui-form" style="padding:2px;" align="center" >	
						<table id="table1" class="table" style="width:100%;table-layout:fixed;">
							<tr>
								<td class="form_label" width="8%" align="right">接口名:</td>
								<td colspan="1" width="15%" align="left">
									<input class="nui-textbox" style="width:95%" name="param/vcInterfaceName"   emptyText="请输入接口名"/>
								</td>
								<td class="form_label" width="8%" align="right">接口名(中文):</td>
								<td colspan="1" width="15%" align="left">
									<input class="nui-textbox" style="width:95%" name="param/vcInterfaceRealName"   emptyText="请输入接口名(中文)"/>
								</td>
								<td class="form_label" width="8%" align="right">参数名:</td>
								<td colspan="1" width="15%" align="left">
									<input class="nui-textbox" style="width:95%" name="param/vcParamName"  emptyText="请输入参参数名"/>
								</td>	
								
								<td class="form_label" width="8%" align="right">参数名(中文):</td>
								<td colspan="1" width="15%" align="left">
									<input class="nui-textbox" style="width:95%" name="param/vcParamRealName"  emptyText="请输入参数名(中文)"/>
								</td>	
								<td class="form_label" width="8%" align="right">参数类型:</td>
								<td colspan="1" width="15%" align="left">
									<input class="nui-textbox" style="width:95%" name="param/vcParamType"   emptyText="请输入参数类型"/>
								</td>	
							   <td colspan="1" rowspan="2" width="10%" align="left">
									<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
								</td> 
						  </tr>
						</table>
				  </div>
			   </div>
			   
			   <%--列表开始... --%>
			   <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
					<table style="width:100%;">
						<tr>
							<td style="width:100%;">
								<a class='nui-button' plain='false' iconCls="icon-add" plain="false" onclick="add()">增加</a>
								<a id="update" class='nui-button' plain='false' iconCls="icon-edit" plain="false" onclick="edit()">编辑</a>
								<a class='nui-button' plain='false' iconCls="icon-remove" plain="false" onclick="remove()">删除</a>
							</td>
						</tr>
					</table>
				</div>
			    <div class="nui-fit" style="width:100%;height:100%;">
					<div 
						    id="datagrid1"
						    dataField="paramList"
						    class="nui-datagrid"
						    style="width:100%;height:100%;"
						    url="com.cjhxfund.cjapi.common.ParamCheck.queryParamCheck.biz.ext"
						    pageSize="20"
						  	showPageInfo="true"
				           	allowSortColumn="true" 
				           	sortMode="client"
				         	enableHotTrack="true" 
				         	allowHeaderWrap="true"
				           	sizeList="[10,20,50,100]"
				           	allowCellEdit="true"
							allowCellSelect="true"
							enterNextCell="true"
							allowHeaderWrap="true"  
							allowMoveColumn="true"
							editNextOnEnterKey="true"
							multiSelect="true" 
							showfooter="false">
					
					  <div property="columns">
						  <div type="checkcolumn"></div>
						  <div field="vcInterfaceName" name="vcInterfaceName" headerAlign="center" allowSort="true" align="center">
								 接口名
						  </div>
						   <div field="vcInterfaceRealName" name="vcInterfaceRealName" headerAlign="center" allowSort="true" align="center">
								 接口名(中文)
						  </div>
						  
						   <div field="vcParamName" headerAlign="center" allowSort="true" align="center" >
								参数名
						  </div>
						  <div field="vcParamRealName" headerAlign="center" allowSort="true" align="center" >
								参数名(中文)
						  </div>
						  
						  <div field="vcParamType" headerAlign="center" allowSort="true" align="center" >
								 参数类型
						  </div>
						  <div field="vcParamLength" headerAlign="center" allowSort="true" align="center" >
								 参数值长度
						  </div>
						  <div field="vcIsNeed" headerAlign="center" allowSort="true" align="center" renderer="yesOrNo">
								是否必须
						  </div>
						
					  </div>
					</div>
				</div>
			    <%-- nui-fit列表结束!!! --%>
		    
		</div>
		</div>
	</div>	
</div>

<script type="text/javascript">
	nui.parse();
	var grid = nui.get("datagrid1");
	
	//加载datagrid数据
	var formData = new nui.Form("#form1").getData(false,false);
	grid.load(formData);
	
	

	//新增
	function add() {
		nui.open({
			url: "<%=request.getContextPath()%>/cjapi/common/paramCheckForm.jsp?pageType=add",
			title: "新增记录",
			width: 500,
			height:405,
			ondestroy: function (action) {//弹出页面关闭前
				grid.reload();
			}
		});
	}
	
	//编辑
	function edit() {
		var rows = grid.getSelecteds();
		
		if(rows.length>1){
			nui.alert("只能选择一条记录进行编辑操作","提示");
			return false;
		}
		if (rows.length>0&&rows.length==1) {
			nui.open({
				url: "<%=request.getContextPath()%>/cjapi/common/paramCheckForm.jsp?pageType=edit",
				title: "编辑数据",
				width: 500,
				height:405,
				onload: function () {
					var iframe = this.getIFrameEl();
					var data = {pageType:"edit",record:{paramCheck:rows[0]}};
					//直接从页面获取，不用去后台获取
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function (action) { //弹出页面关闭前
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
						var json = nui.encode({paramList:rows});
						grid.loading("正在删除中,请稍等...");
						$.ajax({
							url:"com.cjhxfund.cjapi.common.ParamCheck.deleteParamCheckById.biz.ext",
                            type:'POST',
                            data:json,
                            cache: false,
                            contentType:'text/json',
							success:function(text){
								var returnJson = nui.decode(text);
								if(returnJson.exception == null){
									grid.reload();
									nui.alert("删除成功", "系统提示", function(action){});
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
 
 	//显示是否
 	function yesOrNo(e){
 		return nui.getDictText("CJAPI_PARAM_CHECK",e.row.vcIsNeed);
 	}
 
	 
	//合并单元格
	////这个mergeColumns方法合并是根据name进行合并的
	grid.on("load", function () {
		//两个列都是相同的值进行合并
    	grid.mergeColumns(["vcInterfaceName","vcInterfaceRealName"]);
    });
</script>

</body>
</html>