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
<title>申购模板清单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
	<script type="text/javascript" src="<%=request.getContextPath() %>/fm/baseinfo/applyTemplet/js/swfupload.js"></script>
	
<body style="width:100%;height:100%;overflow:height; margin: 0px;">
	<div class="search-condition">
		<div class="list">
			<div id="form1" class="nui-form" align="center" style="height: 10%">
				<!-- 排序字段 -->
				<form id="queryForm" action="">
					<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.fm.baseinfo.stockTemplate.TAtsStockTemplate">
					<input class="nui-hidden" name="criteria/_orderby[1]/_property" value="dCreateTime">
	                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc">
					<table id="table1" border="0" cellpadding="1" cellspacing="1" style="width: 100%; table-layout: fixed;">
					 <tr>
			                <td style="width: 10%" align="right">模板名称:</td>
							<td style="width:15%" align="left">
							  	<input style="width: 100%;" class="nui-textbox" name="criteria/_expr[1]/vcTemplateName" />
	                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
	                            <input class="nui-hidden" name="criteria/_expr[1]/_likeRule" value="all">
			                </td>
			                
			                <td style="width: 10%" align="right">债券代码:</td>
							<td style="width:15%" align="left">
	                            <input class="nui-textbox" name="criteria/_expr[2]/vcStockCode"  width="100%"/>
                    			<input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
                    			<input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
			                </td>
			                
			                <td style="width:10%; " align="right">主承销商:</td>
		                    <td style="width:15%" align="left" >
		                    	<input class="nui-textbox" name="criteria/_expr[3]/vcMainUnderwriter"  width="100%" />
		                    	<input class="nui-hidden" name="criteria/_expr[3]/_op" value="like" width="100%" />
		                    	<input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
		                    </td>
		                    
							<td align="left" style="width:25%"><a class='nui-button' plain='false'
								iconCls="icon-search" onclick="search()"> 查询 </a>&nbsp;
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
                    <a id="add" class='nui-button' plain='false' iconCls="icon-add" onclick="add()" >
                        	增加
                    </a>&nbsp;
                    <a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">
                      	              修改
                    </a>&nbsp;
                    <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()">
                         	删除
                    </a>&nbsp;
                    <a id="download" class="mini-button" iconCls="icon-download" onclick="download()">下载
                    </a>&nbsp;
                    <a id="preview" class="mini-button" iconCls="icon-search" onclick="preview()">预览
                    </a>
                </td>
            </tr>
       </table>
    </div>
    <div id="layout1" class="mini-layout" style="width:100%; height:89%;"  borderStyle="border:solid 1px #aaa;">       
		<div title="center" region="center"  >
		 	<div class="nui-fit">
				<div id="datagrid1" class="nui-datagrid"
					dataField="tatsstocktemplates" style="width: 100%; height: 100%;"
					url="com.cjhxfund.ats.fm.baseinfo.tatsstocktemplatebiz.queryTAtsStockTemplates.biz.ext"
					pageSize="20" onShowRowDetail="onShowRowDetailList" sortField="vcStockCode" sortOrder="desc"
					showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" >
					<div property="columns">
						<div type="indexcolumn"></div>
						<div type="checkcolumn"></div>
						<div field="vcTemplateName" width="90" headerAlign="center" allowSort="true">模板名称</div>
						<div field="vcTemplatePath" width="100" headerAlign="center">模板路径</div>
						<div field="vcStockCode" width="80" headerAlign="center" allowSort="true">债券代码</div>
						<div field="vcStockName" width="200" headerAlign="center" allowSort="true">债券名称</div>
						<div field="vcMainUnderwriter" width="100" headerAlign="center" allowSort="true">主承销商</div>
						<div field="cMarketNo" width="50" headerAlign="center" allowSort="true" renderer="marketNoRenderer">市场</div>
						<div field="lStockInvestNo" width="70" headerAlign="center" allowSort="true" visible="false">证券投资编号</div>
						<div field="vcCreator" width="50" headerAlign="center" allowSort="true">上传人</div>
						<div field="vcOrderNum" width="50" headerAlign="center" allowSort="true">序号</div>
						<div field="dCreateTime" width="60" headerAlign="center" allowSort="true">创建时间</div>
						<div field="dUpdateTime" width="60" headerAlign="center" allowSort="true">更新时间</div>
						<div field="vcRemarks" width="50" headerAlign="center">备注</div>
					</div>
				</div>
			</div>
		</div>	
	</div>
	<script type="text/javascript">
		//加载模板信息
		nui.parse();
		var contextPath = "<%= request.getContextPath() %>";
		
        var grid = nui.get("datagrid1");
        var formData = new nui.Form("#form1").getData(false,false);
        grid.load(formData);
		
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
            	nui.get("add").disable();
                nui.get("update").disable();
                nui.get("download").disable();
            }else{
            	nui.get("add").enable();
                nui.get("update").enable();
                nui.get("download").enable();
            }
        }
		
   		//新增
        function add() {
        var row = grid.getSelected();
            nui.open({  
            	url:"<%=request.getContextPath() %>/fm/baseinfo/stockTemplate/stockTemplateAddForm.jsp",
	            title: "新增模板信息", width: 520, height: 400,overflow:"hidden",
	            allowResize: false,
	            onload: function () {//弹出页面加载完成
		            var iframe = this.getIFrameEl();
		            if (row){
			            var data = {pageType:"add",record:{tatsstocktemplate:row}};//传入页面的json数据
			            iframe.contentWindow.setFormData(data);
		            }
	            },
	            ondestroy: function (action) {//弹出页面关闭前
	            	grid.reload();
	            }
            });
        }

        //修改
        function edit() {
            var row = grid.getSelected();
          	//row.cMarketName = nui.getDictText("tradePlace",row.cMarketNo);
          	//row.cMarketName = row.cMarketNo;
            if (row) {
                nui.open({
                    url: "<%=request.getContextPath() %>/fm/baseinfo/stockTemplate/stockTemplateForm.jsp",
                    title: "修改模板信息", width: 520, height: 300,
                    allowResize: false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = {pageType:"edit",record:{tatsstocktemplate:row}};
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
						var json = nui.encode({tatsstocktemplates:rows});
						grid.loading("正在删除中,请稍等...");
						$.ajax({
							url:"com.cjhxfund.ats.fm.baseinfo.tatsstocktemplatebiz.deleteTAtsStockTemplates.biz.ext",
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
								window.parent.frames[0].location.reload();
							}
						});
					}
				});
			}else{
				nui.alert("请选中一条记录！");
			}
 		}
 		
 		//下载模板文件到本地指定文件夹内
		function download(){
			var row = grid.getSelected();
          	window.location.href= encodeURI(contextPath+"/fm/baseinfo/stockTemplate/downloadStockTemplate.jsp?filename="+row.vcTemplateName+"&filepath="+row.vcTemplatePath);
		}         
		//编辑模板文件
		function preview(){
	    	var file_grid = nui.get("datagrid1");    //获取附件列表对象
	    	var rows = file_grid.getSelecteds();     //获取选中的记录
	    	if(rows.length == 0){
	    		nui.alert("请选择附件信息。","系统管理");
	    		return;
	    	}
	    	for(var i = 0;i<rows.length;i++){
	    		var fileName = rows[i].vcTemplateName; 
	    		var filePath = rows[i].vcTemplatePath;
	    		//encodeURI 可解决IE的url中文乱码问题
		    	var actionURL = encodeURI(contextPath + "/commonUtil/iWebOffice/stockTemplatePreview.jsp?fileName="
		    	+fileName+"&filePath="+filePath); //目标页面
		    	window.open(actionURL,"_blank");
	    	}     
	    }
	    //市场代码字典转换
		function marketNoRenderer(e){
        	return nui.getDictText("tradePlace",e.row.cMarketNo);
        }
		</script>
	</body>
</html>