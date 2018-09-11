<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>


<%--
- Author(s): chenpeng
- Date: 2016-07-07 09:36:52
- Description:系统参数维护
--%>
<head>
    <title>
        	系统参数维护
    </title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	
	
	
</head>
<body style="width:99.6%;height:99.6%;overflow:hidden;">
	<div class="search-condition">
		<div class="list">
			<div id="form1" class="nui-form" style="margin: 0px;">
				<!-- 数据实体的名称 -->
				<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.fm.comm.comm.ZhfwptParamConf">
				<!-- 排序字段 -->
				<table id="table1" class="table" width="100%" style="table-layout:fixed;">
					<tr>
						<td class="form_label" width="50px" align="right">
	                            参数名:
						</td>
						<td colspan="1" width="15%" align="left">
							<input class="nui-textbox" name="criteria/_expr[1]/paramName"/>
							<input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
							<input class="nui-hidden" name="criteria/_expr[1]/_likeRule" value="all">
						</td>
						<td class="form_label" width="100px" align="right">
		                            参数类型:
						</td>
						<td colspan="1" width="15%" align="left" >
							<input class="nui-combobox" name="criteria/_expr[2]/paramType" data="[{id : 0 , text : '不可修改'},{id : 1 , text : '可修改'}]" 
							emptyText="全部" nullItemText="全部" showNullItem="true"/>
							<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
						</td>
						<td class="form_label" width="100px" align="right">
	                            参数状态:
	                    </td>
	                    <td colspan="1" width="150px" align="left">
							<input class="nui-combobox" name="criteria/_expr[3]/paramStatus" data="[{id : 0 , text : '启用'},{id : 1 , text : '废弃'}]"
							emptyText="全部" nullItemText="全部" showNullItem="true"/>
	                        <input class="nui-hidden" name="criteria/_expr[3]/_op" value="=">
	                    </td>
	                    <td>
					        <a class='nui-button' plain='false' onclick="search()" iconCls="icon-search">查询</a>
					        <a class='nui-button' plain='false' onclick="reset()" iconCls="icon-close">重置</a>
	                    </td>
	                 </tr>
	             </table>
			</div>
		</div>    
	</div>
	<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
		<table style="width:100%;">
			<tr>
				<td style="width:100%;">
					&nbsp;
					<a class='nui-button' plain='false' iconCls="icon-add" onclick="add()">
                            增加
					</a>
                    &nbsp;
                    <a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">
                            编辑
                    </a>
                    &nbsp;
                    <a id="" class='nui-button' plain='false' iconCls="icon-reload" onclick="refresh_cache()">刷新缓存</a>
                        <!-- <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()">
                            删除
                        </a> -->
				</td>
			</tr>
		</table>
	</div>
    <div class="nui-fit">
		<div id="datagrid1"
			 dataField="zhfwptparamconfs"
             class="nui-datagrid"
             style="width:100%;height:100%;"
             url="com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.queryParamConfs.biz.ext"
             pageSize="50"
             showPageInfo="true"
             multiSelect="true"
             onselectionchanged="selectionChanged"
             allowSortColumn="false">

 			<div property="columns">
				<div type="checkcolumn"></div>
				<div type="indexcolumn" headerAlign="center">序号</div>
				<div field="paramConfId" headerAlign="center" allowSort="true" visible="false">
                            主键ID
                </div>
                <div field="paramKey" headerAlign="center" allowSort="true" >
                            参数key
                </div>
                <div field="paramName" headerAlign="center" allowSort="true" >
                            参数名
                </div>
                <div field="paramValue" headerAlign="center" allowSort="true" >
                            参数值
                </div>
                <div field="paramType" headerAlign="center" allowSort="true" visible="false">
                            参数类型
                </div>
                <div field="paramStatus" headerAlign="center" allowSort="true" renderer="renderParamStatus">
                            参数状态
                </div>
                <div field="paramMemo" headerAlign="center" allowSort="true" >
                            参数描述
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
				url: "<%=request.getContextPath() %>/comm/paramMaintain/paramConfForm.jsp",
                title: "新增参数记录", width: 700, height: 300,
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
				var paramType = row.paramType;     //获取参数类型
				var paramStatus = row.paramStatus; //获取参数状态
				var msg = ""; //提示消息    
				//判断参数类型，0-页面不可维护的系统参数  1-系统启动就加载进内存的参数	           		
				if(paramType == "0"){
					msg = "该参数为系统不可修改参数，确认要继续修改吗?";
				}
				//判断参数状态，0-启用 1-废弃
				if(paramStatus == "1"){
					if(msg == ""){
						msg = "该参数已经废弃，确认要继续修改吗?";
					}
				}
            	//默认弹出消息
            	if(msg == ""){
            	  msg = "确认要修改吗?";
            	}	
				nui.confirm(msg,"系统提示",function(action){
					if(action == "ok"){
						nui.open({
							url: "<%=request.getContextPath() %>/comm/paramMaintain/paramConfForm.jsp",
							title: "编辑参数",
							width: 500,
							height: 280,
							onload: function () {
								var iframe = this.getIFrameEl();
		                        var data = {pageType:"edit",record:{zhfwptparamconf:row}};
		                        //直接从页面获取，不用去后台获取
		                        iframe.contentWindow.setFormData(data);
		                     },
		                     ondestroy: function (action) {
		                        grid.reload();
		                     }
						});
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
						var json = nui.encode({zhfwptparamconfs:rows});
						grid.loading("正在删除中,请稍等...");
						$.ajax({
							url:"com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.deleteParamConfs.biz.ext",
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
                                
		//参数类型
		/* function renderParamType(e){
				if(e.row.paramType == "0"){
					return "不可修改";
				}else{
					re
				}
			} */
		function renderParamStatus(e){
			if(e.row.paramStatus == "0"){
				return "启用";
			}else{
				return "废弃";
			}
		}
		
		//刷新缓存
		function  refresh_cache(){
			$.ajax({
				url:"com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.reloadParamConf.biz.ext",
				type:'POST',
				cache: false,
				contentType:'text/json',
				success:function(text){
					var returnJson = nui.decode(text);
					if(returnJson.reCode == 1){
						//grid.reload();
						nui.alert("缓存刷新成功", "系统提示", function(action){});
					}else{
						grid.unmask();
						nui.alert("缓存刷新失败", "系统提示");
					}
				}
			});
		}
		</script>
</body>
</html>
