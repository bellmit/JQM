<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<!-- 
  - Author(s):liangjilong
  - Date: 2016-11-11 08:25:25
  - Description:
-->
<head>
	<title>产品用户信息管理</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
<div style="margin:0px;width:100%;height:100%;" >
	<div style="width:100%;height:100%;">
		   <div class="search-condition">
			   <div class="list">
				   <div id="form1" class="nui-form" style="padding:2px;" align="center" >		            
		            <table id="table1" class="table" style="width:100%;table-layout:fixed;">
		                <tr>
		                   	<td class="form_label" width="8%" align="right">用户名:</td>
		                    <td colspan="1" width="15%" align="left">
		                        <input class="nui-textbox" style="width:95%" name="prodUserInfo/userName"  />
		                    </td>
		                    
		                    <td class="form_label" width="8%" align="right">产品名称:</td>
		                    <td colspan="1" width="15%" align="left">
		                        <input class="nui-textbox" style="width:95%" name="prodUserInfo/prodName"  />
		                    </td>	
		                    
		                   <td colspan="1" rowspan="2" width="10%" align="left">
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
	                        </td> 
		              </tr>
		            </table>
		         </div>
			  </div>
		   </div>
		   <%-- 查询条件结束!!! --%>
		   
		   <%-- 产品复核权限配置列表开始... --%>
		     <div class="nui-panel" title="产品用户列表" iconCls="icon-add" style="width:100%;height:85%;" showToolbar="false" showFooter="false" >
		        <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
		            <table style="width:100%;">
		                <tr>
		                    <td style="width:100%;">
		                        <a class='nui-button' plain='false' iconCls="icon-add" onclick="add()">新增</a>
		                          &nbsp;
		                        <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()">删除</a>
		                    </td>
		                </tr>
		            </table>
		        </div>

            <div class="nui-fit">
		   		<div id="datagrid1" 
		   			dataField="prodUserInfoList"
		   			class="nui-datagrid" 
		   			style="width:100%;height:100%;"
		        	url="com.cjhxfund.ats.mom.report.prodUserInfoManager.queryProdUserInfoList.biz.ext"
	           		pageSize="20" showPageInfo="true"
		           	allowSortColumn="true" sortMode="client"
		         	enableHotTrack="true" allowHeaderWrap="true"
		           	sizeList="[10,20,50,100]"
		           	allowCellEdit="true"
					allowCellSelect="true"
					enterNextCell="true"
					allowMoveColumn="true"
					editNextOnEnterKey="true"
					multiSelect="true"   showfooter="false">
					
                    <div property="columns">
                        <div type="checkcolumn"></div>
                        <div field="userId" headerAlign="center" allowSort="true" align="center" width="80px">用户ID</div>
                        <div field="userName" headerAlign="center" allowSort="true" align="center" width="80px">用户名</div>
                        <div field="prodId" headerAlign="center" allowSort="true" align="center" width="80px">产品编号</div>
                        <div field="prodName" headerAlign="center" allowSort="true" align="center" width="150px">产品名称 </div>
                        <!-- <div field="prodLayer" headerAlign="center" allowSort="true" align="center" width="100px" renderer="rendererProdLayerTitle"> 账号类型</div> -->
                        <!-- <div field="insertTime" headerAlign="center" allowSort="true" align="center" width="100px" renderer="onInsertTimeRenderer">操作时间 </div> -->
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
	var grid1 = nui.get("datagrid1");
	//进来这个页面就加载列表信息
	var formData = new nui.Form("#form1").getData(false,false);
	grid1.load(formData);
	 
	//设置类型的标题
 	function rendererProdLayerTitle(e){
 		return nui.getDictText("productLayer",e.row.prodLayer);
    }
	 
	 //查询
	function search() {
		var form = new nui.Form("#form1");
		var json = form.getData(false,false);
		grid1.load(json);//grid查询
	}
	
	//Grid加载完成后选中之前已选中的记录
    function onGridLoad(e) {
	    	//var rows = selectArr;
	        //if(rows) grid.selects(rows);
    }
	//添加
	function add(){
          nui.open({
	         url: "<%=request.getContextPath() %>/report/MOM_REPORT/productUserInfoForm.jsp",
	         title: "新增产品用户信息", width: 460, height: 'auto',
	         onload: function () {//弹出页面加载完成
	            var iframe = this.getIFrameEl();
	            var data = {pageType:"add"};//传入页面的json数据
	            iframe.contentWindow.setFormData(data);
	          },
	          ondestroy: function (action) {//弹出页面关闭前
	               grid1.reload();
	          }
        });    
          
	}
	//移除
	function remove(){
			var rows = grid1.getSelecteds();
			if(rows.length > 0){
				nui.confirm("确定删除选中记录？","系统提示",
				function(action){
					if(action=="ok"){
						var json = nui.encode({prodUserInfoList:rows});
						grid1.loading("正在删除中,请稍等...");
						$.ajax({
							url:"com.cjhxfund.ats.mom.report.prodUserInfoManager.deleteProdUserInfoById.biz.ext",
                            type:'POST',
                            data:json,
                            cache: false,
                            contentType:'text/json',
							success:function(text){
								var returnJson = nui.decode(text);
								if(returnJson.exception == null){
									grid1.reload();
									nui.alert("删除成功", "系统提示", function(action){});
								}else{
									grid1.unmask();
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
	
	
	 function onInsertTimeRenderer(e) {
            var value = e.value;
            if (value) return nui.formatDate(value, 'yyyy-MM-dd HH:mm:ss');
         return "";
     }
</script>
</body>
</html>