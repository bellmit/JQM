<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@include file="/common/js/commscripts.jsp" %>
<%--
- Author(s): 章璐
- Date: 2016-10-14 17:40:16
- Description:
    --%>
    <head>
        <title>
           债券类别映射
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        
	    <%--  --%>
	    
    </head>
    
    <body style="width:100%;height:100%; overflow: hidden;">
			<div class="search-condition">
			<div class="list">
				<div id="form1" class="nui-form" style="height:10%" align="center" >
					<!-- 数据实体的名称 -->
					<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.fm.baseinfo.stockissue.TAtsStockTypeDefineAndMap">
					<!-- 排序字段 -->
					<table id="table1" class="table" style="height:100%">
						<tr>
							<td class="form_label" align="right" width="120px">
		                            债券类别:
							</td>
							<td colspan="1" width="35%" align="left">
								<input class="mini-treeselect" name="criteria/_expr[1]/vcStockType" id="cStockType" dataField="data" 
								    url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext" width="80%"  showFolderCheckBox="false"
								    multiSelect="true"  textField="text" valueField="id" parentField="pid" checkRecursive="false" 
						        	showFolderCheckBox="true"   expandOnLoad="true" showTreeIcon="false" showClose="true"  popupWidth="100%"
								    oncloseclick="onCloseClickValueEmpty"/>
                        			<input class="nui-hidden" name="criteria/_expr[1]/_op" value="in">
							</td>
							<td align="left">
								<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
							    <a id="query" class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
						                             重置
						        </a>
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
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add()">
                                增加
                            </a>
                            <span>&nbsp;</span>
                            <a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">
                                修改
                            </a>
                          <!--   <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()">
                                删除
                            </a> -->
                           </td>
                    </tr>
                </table>
            </div> 
            
            <div class="nui-fit">
                <div 
                        id="datagrid1" 
                        dataField="stocktypemaps"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.ats.fm.baseinfo.stockTypeManager.queryStockTypeMap.biz.ext"
                        pageSize="20"
                        sortField="vcStockType"
                        showPageInfo="true"
                        multiSelect="true"
                        onselectionchanged="selectionChanged">

                    <div property="columns">
                        <div type="indexcolumn">
                        </div>
                        <div type="checkcolumn">
                        </div>
                        <div field="vcStockType" headerAlign="center" allowSort="true" >
							债券类别
                        </div>
                        <div field="vcStocktypeName" headerAlign="center" width="120" allowSort="true" >
                           	债券类别名称
                        </div>
                        <div header="映射" headerAlign="center">
                        <div property="columns">
	                        <div field="vcSource" headerAlign="center" allowSort="true" >
	                            	数据来源
	                        </div>
	                        <div field="vcStockTypeId" headerAlign="center" width="120" allowSort="true" >
	                                                                                                映射证券类别
	                        </div>
	                        <div field="vcStockTypeIdName" headerAlign="center" width="120" allowSort="true" >
	                                                                                                  映射证券类别名称
	                        </div>
	                        <div field="vcStockTypeDtl" headerAlign="center"  width="120" allowSort="true" >
	                                                                                                   杂项分类
	                        </div>
	                        <div field="vcStockTypeDtlname" headerAlign="center" width="180" allowSort="true" >
	                                                                                                   杂项分类名称
	                        </div>
                        </div>
                        </div>
                        <div field="vcRemark" headerAlign="center" width="150"  allowSort="true" >
                                                                                                                               备注
                        </div>
                        <div field="cStatus" headerAlign="center" width="50" allowSort="true" renderer="cstatusname">
                                                                                                                                  状态
                        </div>
                        <div field="lMapId" headerAlign="center" allowSort="true" visible="false">
                                                                                                                                   序号
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
                    url: "<%=request.getContextPath() %>/fm/baseinfo/stockType/addstockTypeMap.jsp",
                    title: "新增映射关系", width: 600, height: 340,
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

            //修改
            function edit() {
                var row = grid.getSelected();
                if (row) {
                    nui.open({
                        url: "<%=request.getContextPath() %>/fm/baseinfo/stockType/addstockTypeMap.jsp",
                        title: "更新映射关系",
                        width: 600,
                        height: 340,
                        onload: function () {
                            var iframe = this.getIFrameEl();
                            var data = {pageType:"edit",record:{stockTypeMap:row}};
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
                    /*
                    function remove(){
                        var rows = grid.getSelecteds();
                        if(rows.length > 0){
                            nui.confirm("确定删除选中记录？","系统提示",
                            function(action){
                                if(action=="ok"){
                                    var json = nui.encode({stocktypedefineentitys:rows});
                                    grid.loading("正在删除中,请稍等...");
                                    $.ajax({
                                        url:"com.cjhxfund.ats.fm.baseinfo.stocktypedefineentitybiz.deleteStockTypeDefineEntitys.biz.ext",
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
                                }*/

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
                                    var json = form.getData(false,false);
                                    grid.load(json);//grid查询
                                }

                                //enter键触发查询
                                function onKeyEnter(e) {
                                    search();
                                }
                                function cstatusname(e){
                                	if(e.row.cStatus=='0'){
                                		return "启用";
                                	}else{
                                		return "未启用";
                                	}
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