<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common.jsp" %>
<html>
<!-- 
  - Author(s): 陈迪
  - Date: 2016-11-23 13:48:52
  - Description: 
--> 
<head>
<title>产品参数维护</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script>
</head>
<body style="height:100%; width:100%; overflow:hidden; margin:0;padding:0;">
		 <!-- 查询条件开始 -->
		 <div class="search-condition">
	   <div class="list">
	   		<div id="form1" class="nui-form" style="padding:2px;height:10%;" align="left">
                <table id="instruct_follow_condition" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                	<tr>
		                    <td width="60px" align="right">
		                        产品名称:
		                    </td>
		                    <td align="left">
												<input name="productConf/vcProductId" class="nui-combobox" id="product_id"
					                   textField="TEXT" valueField="ID"
					                   url="com.cjhxfund.commonUtil.applyInstUtil.queryTAtsProductInfo.biz.ext?queryType=1"
					                   showNullItem="false"
					                   showClose="true"
													   emptyText="全部..."
													   nullItemText="请选择..."
													   valueFromSelect="true"
													   allowInput="true"
													   oncloseclick="onCloseClick"
													   onvaluechanged="selectFund"
									           width="95%"/>
	            					</td>
		                    <td width="75px" align="right">
		                       产品参数项:
		                    </td>
		                    <td align="left">
		                        <input id="conf_code" name="productConf/vcConfCode" class="nui-dictcombobox"
         								 valueField="dictID" textField="dictName" width="95%" dictTypeId="productConfCode"
         								 showNullItem="false" emptyText="全部..." nullItemText="请选择..." showClose="true" 
         								 oncloseclick="onCloseClick"/>
		                    </td>
		                    <td width="75px" align="right">
		                       产品参数值:
		                    </td>
		                    <td align="left">
		                        <input class="nui-textbox" name="productConf/vcConfValue" width="95%"/>
		                    </td>
		                    <td width="30px" align="right">
		                        描述:
		                    </td>
		                    <td align="left">
		                        <input class="nui-textbox" name="productConf/vcConfDesc" width="95%"/>
		                    </td>
		              </tr>
		              <tr>
	                	<td  align="left" colspan="8">
	     					<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
	     					<a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">重置</a>
	     					<a class="nui-menubutton " plain="false" menu="#popupMenu"
	                           id="searchCond"
	                           name="searchCond"
	                           data-options='{formId:"form1"}'
	                           iconCls="icon-add">保存查询条件</a>
	                        <ul id="popupMenu" class="mini-menu" style="display:none;width:250px;">
             			</td>
		              </tr>
				</table>
			</div>
	  	</div>
   	</div>
		   <!-- 查询条件结束!!! -->
		   
		   <!-- 产品参数列表开始 -->
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
                            <a id="" class='nui-button' plain='false' iconCls="icon-reload" onclick="refresh_cache()">
                            刷新缓存
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div 
                        id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;"
                        url="com.cjhxfund.commonUtil.productConfManage.queryTAtsProductConfList.biz.ext"
                        dataField="TAtsProductConf"
                        pageSize="20"
                        sizeList="[10,20,50,100]"
                        showPager="true"
                        multiSelect="true"
                        allowSortColumn="true"
                        sortMode="client"
												showfooter="false" onselectionchanged="selectionChanged">
                    		<div property="columns">
                        <div type="indexcolumn" width="2%"></div>
                        <div type="checkcolumn" width="3%"></div>
                        <div field="vcProductName" name="vcProductName" headerAlign="center" width="20%">产品名称</div>
                        <div field="vcConfCode" name="vcConfCode" headerAlign="center" width="20%" renderer="renderConfCode">产品参数项</div>
                        <div field="vcConfValue" headerAlign="center" width="20%">产品参数值</div>
                        <div field="vcConfDesc" headerAlign="center" width="35%">描述</div>
                    </div>
                </div>
            </div>
		    <!-- 产品参数维护列表结束!!! -->	

<script type="text/javascript">
	nui.parse();
	var grid = nui.get("datagrid1");
	var formData = new nui.Form("#form1").getData(false,false);
	grid.load(formData);
	
	//新增
	function add() {
		nui.open({
				url: nui.context+"/commonUtil/productConf/addProductConfManage.jsp",
				title: "新增产品参数",
				width: 600,
				height: 340,
				onload: function () {
					var iframe = this.getIFrameEl();
					var data = {pageType:"add"};
					//直接从页面获取，不用去后台获取
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function (action) {
					grid.reload();
				}
		});
	}
	
	//编辑
	function edit() {
		var row = grid.getSelecteds();
		if (row.length>0) {
			nui.open({
				url: nui.context+"/commonUtil/productConf/editProductConfManage.jsp",
				title: "编辑产品参数",
				width: 600,
				height: 340,
				onload: function () {
					var iframe = this.getIFrameEl();
					var data = {pageType:"edit",record:{productConf:row}};
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
					var json = nui.encode({TAtsProductConfs:rows});
					grid.loading("正在删除中,请稍等...");
					$.ajax({
						url:"com.cjhxfund.commonUtil.productConfManage.deleteTAtsProductConfs.biz.ext",
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
		var grid = nui.get("datagrid1");
		var json = new nui.Form("#form1").getData(false,false);
		grid.load(json);
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
	//页面X的删除功能
	function onCloseClick(e) {
	    var obj = e.sender;
	    obj.setText("");
	    obj.setValue("");
	}
	//合并单元格
	grid.on("load", function () {
    	grid.mergeColumns(["vcProductName"]);
    });
    
	//产品参数项字典
	function renderConfCode(e){
		return nui.getDictText("productConfCode",e.row.vcConfCode);
	}
	//刷新缓存
		function  refresh_cache(){
			$.ajax({
				url:"com.cjhxfund.commonUtil.productConfManage.refreshProductConfCache.biz.ext",
				type:'POST',
				cache: false,
				contentType:'text/json',
				success:function(text){
					var returnJson = nui.decode(text);
					if(returnJson.result == true){
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