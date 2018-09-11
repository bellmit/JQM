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
           查询公测用户
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        
	    <%--  --%>
	    
    </head>
    
    <body style="width:100%;height:100%; overflow: hidden;">
			<div class="search-condition">
			<div class="list">
				<div id="form1" class="nui-form" style="height:10%" align="center" >
					<!-- 数据实体的名称 -->
					<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.commonUtil.dataBase.TAtsTrialUser">
					<!-- 排序字段 -->
					<table id="table1" class="table" style="width:100%;table-layout:fixed;">
						<tr >
							<td style="width:60px" align="right">
		                            用户ID:
							</td>
							<td align="left"  style="width:10%">
								<input class="nui-textbox" id="vcUserId" name="criteria/_expr[1]/vcUserId" width="100%" onenter="onKeyEnter"/>
                        		<input class="nui-hidden" type="hidden" name="criteria/_expr[1]/_op" value="like">
                            	<input class="nui-hidden" type="hidden" name="criteria/_expr[1]/_likeRule" value="all">
							</td>
							<td style="width:60px" align="right">
		                            用户姓名:
							</td>
							<td align="left"  style="width:10%">
								<input class="nui-textbox" id="vcUserName" name="criteria/_expr[3]/vcUserName" width="100%" onenter="onKeyEnter"/>
                        		<input class="nui-hidden" type="hidden" name="criteria/_expr[3]/_op" value="like">
                            	<input class="nui-hidden" type="hidden" name="criteria/_expr[3]/_likeRule" value="all">
							</td>
							<td style="width:60px" align="right">
		                            功能模块:
							</td>
							<td align="left"  style="width:20%">
								<input id="relaType" class="nui-combobox"  multiSelect="true" showClose="true" 
		                         oncloseclick="onCloseClickValueEmpty"  url="com.cjhxfund.commonUtil.userOperatorManager.queryTrialFuncDict.biz.ext" width="100%" name="trialuser.vcTrialFunCode" textField="TEXT" valueField="ID"  onenter="onKeyEnter"/></span>		 
								<input class="nui-hidden" id="vcTrialFunName" name="criteria/_expr[2]/vcTrialFunName" width="100%" />
                        		<input class="nui-hidden" type="hidden" name="criteria/_expr[2]/_op" value="in">
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
                           <!--  <a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">
                                修改
                            </a> -->
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
                        dataField="trialusers"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.commonUtil.userOperatorManager.queryTrialUser.biz.ext"
                        pageSize="20"
                        sortField="lTrialId"
                        showPageInfo="true"
                        multiSelect="true">
                        <div property="columns">
                        <div type="indexcolumn" width="20"></div>
                        <div type="checkcolumn" width="20"></div>
                        <div field="lTrialId" headerAlign="center" allowSort="true" visible="false">
                            	序号
                        </div>
                        <div field="vcUserId" headerAlign="center" width="120" allowSort="true" >
                                                                                                用户ID
                        </div>
                        <div field="vcUserName" headerAlign="center" width="120" allowSort="true" >
                                                                                                用户姓名
                        </div>
                        <div field="vcTrialFunName" headerAlign="center" width="120" allowSort="true" >
                                                                                                  试用功能名称
                        </div>
                        <div field="vcTrialFunCode" headerAlign="center"  width="120" allowSort="true" >
                                                                                                   试用功能代码
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
                window.open("<%=request.getContextPath() %>/commonUtil/AddTrialUser.jsp");
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
                    
                    function remove(){
                        var rows = grid.getSelecteds();
                        if(rows.length > 0){
                            nui.confirm("确定删除选中记录？","系统提示",
                            function(action){
                                if(action=="ok"){
                                    var json = nui.encode({trialusers:rows});
                                    grid.loading("正在删除中,请稍等...");
                                    $.ajax({
                                        url:"com.cjhxfund.commonUtil.userOperatorManager.deleteTrialUser.biz.ext",
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
                                	nui.get("vcTrialFunName").setValue(nui.get("relaType").getText());
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