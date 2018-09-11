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
	<title>新股申购产品维护</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="css/offeringStyle.css"/>
</head>
<body>
	<div style="width:100%;">
	    <div class="nui-toolbar" id="form1" style="border-bottom:0;padding:0px;">
	        <table style="width:100%;">
	            <tr>
	                <td style="width:100%;">
	                    <a class='nui-button' plain='false' iconCls="icon-add" onclick="add()" plain="false">新增</a>
	                    <span class="separator"></span>
	                    <a id="edit" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()" plain="false">修改</a>
	                    <span class="separator"></span>
	                    <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()" plain="false">删除</a>  
	                </td>
	                <td style="white-space:nowrap;">
	                	<span>产品组合简称:</span>
	                    <input class="nui-textbox" name="product/vcRationProductName" emptyText="请输入配售对象名称" style="width:240px;" onenter="onKeyEnter"/>&nbsp;&nbsp;
	                    <span>对象类型:</span>
	                    <input class="nui-dictcombobox" 
	                    	   name="product/vcRationProductType"  
	                    	   onenter="onKeyEnter"
					           dictTypeId="ATS_IPO_RATION_TYPE"  
							   emptyText="全部" nullItemText="全部" showNullItem="true" />&nbsp;&nbsp;&nbsp;
	                    <span>参与类型:</span>
	                    <input class="nui-dictcombobox" 
	                    	   name="product/vcJoinType"  
	                    	   onenter="onKeyEnter"
					           dictTypeId="ATS_IPO_JOIN_TYPE"  
							   emptyText="全部" nullItemText="全部" showNullItem="true" />&nbsp;&nbsp;&nbsp;
	                    <a class='nui-button' plain='false' iconCls="icon-search" onclick="search()" style="margin-right:20px">查询</a>
	                </td>
	            </tr>
	        </table>           
	    </div>
	</div>
	<!--撑满页面-->
	<div class="nui-fit" >
		<div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" 
				allowResize="true"
		    	url="com.cjhxfund.ats.ipo.busOpr.queryIpoProductInfo.biz.ext"  
		    	dataField="products" 
			    showPageInfo="true" 
		    	multiSelect="true" 
		    	pageSize="20"
		    	onselectionchanged="selectionChanged"
		    	sizeList="[10,20,50,100]"
		    	>
		    <div property="columns">
		        <div type="indexcolumn" >序号</div>        
		        <div type="checkcolumn" ></div>        
		        <div field="vcRationProductCode" width="100" headerAlign="center" align="center">配售对象编码</div>    
		        <div field="vcRationProductName" width="200" headerAlign="center">配售对象名称</div>    
		        <div field="vcRationProductType" width="100" headerAlign="center" align="center" renderer="rendervcRationProductType">对象类型</div>
		        <div field="vcAssociationCode" width="80" headerAlign="center" align="center">协会编码</div> 
		        <div field="vcStockAccountSh" width="100" headerAlign="center" align="center">沪市证券账户</div>                    
		        <div field="vcStockAccountSz" width="100" headerAlign="center" align="center">深市证券账户</div>                    
		        <div field="vcStockAccountSzName" width="200" headerAlign="center">深市证券账户名称</div>                    
		        <div field="vcAssetType" width="110" headerAlign="center" align="center" renderer="rendervcAssetType">资产类别</br>（总资产、净资产）</div>                    
		        <div field="vcRecordType" width="100" headerAlign="center" align="center" renderer="rendervcRecordType">备案类型</br>（备案、未备案）</div>                    
		        <div field="vcJoinType" width="100" headerAlign="center" align="center" renderer="rendervcJoinType">参与类型</br>（参与、不参与）</div>                    
		        <!-- <div field="vcRecordRemark" width="80" headerAlign="center">备案备注</div> -->                    
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
                url: "<%=request.getContextPath() %>/ipo/offering/ProductServiceWindow.jsp",
                title: "新增记录", width: 600, height: 280,
                ondestroy: function (action) {
                	if(action=="saveSuccess"){
                		nui.alert("新增成功","系统提示");
                	}
                    grid.reload();
                }
            });
        }
        
        //修改
        function edit() {
		var row = grid.getSelected();
		if (row) {
			nui.open({
				url: "<%=request.getContextPath() %>/ipo/offering/ProductServiceWindow.jsp",
				title: "编辑数据",
				width: 600,
				height: 280,
				onload: function () {
					var iframe = this.getIFrameEl();
					var data = {pageType:"edit",record:{product:row}};
					//直接从页面获取，不用去后台获取
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function (action) { //弹出页面关闭前
					if(action=="saveSuccess"){
                		nui.alert("修改成功","系统提示");
                	}
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
					var json = nui.encode({products:rows});
					grid.loading("正在删除中,请稍等...");
					$.ajax({
						url:"com.cjhxfund.ats.ipo.busOpr.deleteIpoProductInfo.biz.ext",
						type:'POST',
						data:json,
						cache: false,
						contentType:'text/json',
						success:function(text){
							var returnJson = nui.decode(text);
							if(returnJson.exception == null){
								grid.reload();
								nui.alert("删除成功", "系统提示");
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
        
        //查询
        function search() {
            var form = new nui.Form("#form1"); 
 			var data = form.getData(false,false); //获取表单 JS 对象数据 
			grid.load(data); //datagrid 加载数据
        }
        function onKeyEnter(e) {
            search();
        }
       //当选择列时
        function selectionChanged(){
            var rows = grid.getSelecteds();
            if(rows.length>1){
                nui.get("edit").disable();
            }else{
                nui.get("edit").enable();
            }
        }
       
        // 字典类型处理
	    function rendervcAssetType(e) {
			return nui.getDictText("ATS_IPO_ASSET_TYPE",e.row.vcAssetType);
		}
		function rendervcRecordType(e) {
			return nui.getDictText("ATS_IPO_RECORD_TYPE",e.row.vcRecordType);
		}
		function rendervcJoinType(e) {
			return nui.getDictText("ATS_IPO_JOIN_TYPE",e.row.vcJoinType);
		}
		function rendervcRationProductType(e) {
			return nui.getDictText("ATS_IPO_RATION_TYPE",e.row.vcRationProductType);
		}
		
    </script>
</body>
</html>