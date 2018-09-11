<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 翟静
  - Date: 2016-11-09 19:08:50
  - Description:
-->
<%@include file="/common/js/commscripts.jsp" %>

<head>
<title>公司信息查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    
</head>
<body>
<div class="search-condition">
		<div class="list">
			<div id="form1" class="nui-form" align="center" style="height: 10%">
				<!-- 排序字段 -->
				<form id="queryForm" action="">
					<table id="table1" border="0" cellpadding="1" cellspacing="1" style="width: 100%; table-layout: fixed;">
						<tr>
							<td style="width: 60px" align="right">公司名称:</td>
							<td style="width:25%" align="left">
			                         	<input class="nui-textbox" id="vcCompanyName" name="map/vcCompanyName" width="80%"/>
			                </td>
							
							<td style="width: 70px" align="right">法定代表人:</td>
							<td style="width:25%" align="left">
			                            <input class="nui-textbox" id="vcCompanyLegalizer" name="map/vcCompanyLegalizer"  width="80%"/>
			                </td>
			                <td style="width: 60px" align="right">经办人:</td>
							<td style="width:25%" align="left">
				                        <input class="nui-textbox" id="vcOperatorName" name="map/vcOperatorName"  width="80%"/>
				            </td>
						  
						    <td align="left" style="width:7%"><a class='nui-button' plain='false'
									iconCls="icon-search" onclick="search()"> 查询 </a></td>
						    <td align="left" style="width:10%"><a class='nui-button' plain='false' iconCls="icon-reload"
								onclick="reset()"> 重置 </a></td>
					  </tr>
					</table>
				</form>
			</div>
		</div>
	</div>

   <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:200px;">
                    <tr>
                        <td style="width:100%;">
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add()">
                                增加
                            </a>&nbsp;
                            <a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">
                                修改
                            </a>&nbsp;
                             <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()">
                                删除
                            </a>
                           </td>
                    </tr>
                </table>
            </div>
    <div id="layout1" class="mini-layout" style="width:100%; height:89%;"  borderStyle="border:solid 1px #aaa;">       
	<div title="center" region="center"  >      
     <div class="nui-fit">
		<div id="datagrid1" class="nui-datagrid"
		data="data" style="width: 100%; height: 100%;"
			url="com.cjhxfund.ats.fm.baseinfo.ApplyTemplet.queryCompanyInfoWithPage.biz.ext"
			pageSize="20" onShowRowDetail="onShowRowDetailList" sortField="lCompanyId" sortOrder="desc"
			showPageInfo="true" multiSelect="true"  onselectionchanged="selectionChanged">

			<div property="columns">
				<div type="indexcolumn"></div>
				<div type="checkcolumn"></div>
				<div field="lCompanyId" headerAlign="center" align="right" width="70px" allowSort="true">编号</div>
					
				<div field="vcCompanyName" headerAlign="center" width="150px" allowSort="true">公司名称</div>
					
				<div field="vcCompanyLegalizer" headerAlign="center" allowSort="true">法定代表人</div>

				<div field="vcBusinessLicence" headerAlign="center" width="120px" allowSort="true">营业执照</div>

				<div field="vcPostalAddress" headerAlign="center" width="150px" allowSort="true">通讯地址</div>

				<div field="vcRegisteredAddress" headerAlign="center" width="150px" allowSort="true">注册地址</div>

				<div field="vcPostCode" headerAlign="center" allowSort="true"  >邮编</div>

				<div field="vcOperatorName" headerAlign="center"  allowSort="true">经办人姓名</div>

                <div field="vcOperatorIdcard" headerAlign="center" width="170"   allowSort="true" >经办人身份证号码</div>
                
				<div field="vcTelephone" headerAlign="center" allowSort="true"  >联系电话</div>

				<div field="vcPhone" headerAlign="center" allowSort="true"  width="120px">联系手机</div>
                
                <div field="vcEmail" headerAlign="center" width="150px"  >电子邮箱</div>

				<div field="vcRemarks" headerAlign="center" width="150px" allowSort="true">备注</div>

			</div>
		</div>
	</div>
</div>
        <div title="公司详细信息" region="south" showSplit="false" showHeader="true" height="210" showSplitIcon="true" >
		<div id="editForm1" style="margin-right:15px">
			<input class="mini-hidden" name="id" />
			<table border="0" cellpadding="1" cellspacing="1"
				style="width: 100%; table-layout: fixed;">
				<tr>
					<td style="width: 80px" align="right">公司名称:</td>
					<td style="width: 25%" align="left"><input align="left"
						width="100%" id="vcCompanyName" name="vcCompanyName"
						class="mini-textbox" readonly="true"
						inputStyle="background-color:#f0f0f0;" /></td>
					<td style="width: 80px" align="right">法定代表人:</td>
					<td style="width: 25%" align="left"><input align="left"
						width="100%" name="vcCompanyLegalizer" class="mini-textbox"
						readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
					<td style="width: 80px" align="right">营业执照:</td>
					<td style="width: 25%" align="left"><input align="left" 
						width="100%" id="vcBusinessLicence" name="vcBusinessLicence" class="mini-textbox"
						readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
				</tr>
				<tr>
				    <td style="width: 80px" align="right">邮编:</td>
					<td style="width: 25%" align="left"><input align="left"
						width="100%" id="vcPostCode" name="vcPostCode"
						class="mini-textbox" readonly="true"
						inputStyle="background-color:#f0f0f0;" /></td>
					<td style="width: 80px" align="right">电子邮箱:</td>
					<td style="width: 25%" align="left"><input align="left"
						width="100%" id="vcEmail" name="vcEmail" class="mini-textbox"
						readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
					<td style="width: 80px" align="right">经办人姓名:</td>
					<td style="width: 25%" align="left"><input align="left"
						width="100%" name="vcOperatorName" class="mini-textbox"
						readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
				</tr>
	            <tr>
					<td style="width: 80px" align="right">经办人身份证:</td>
					<td style="width: 25%" align="left"><input align="left"
						width="100%" id="vcOperatorIdcard" name="vcOperatorIdcard" class="mini-textbox"
						readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
					<td style="width: 80px" align="right">联系电话:</td>
					<td style="width: 25%" align="left"><input align="left"
						width="100%" id="vcTelephone" name="vcTelephone"
						class="mini-textbox" readonly="true"
						inputStyle="background-color:#f0f0f0;" /></td>
					<td style="width: 80px" align="right">联系手机:</td>
					<td style="width: 25%" align="left"><input align="left"
						width="100%" id="vcPhone" name="vcPhone"
						class="mini-textbox" readonly="true"
						inputStyle="background-color:#f0f0f0;" /></td>
				</tr>
				<tr>
				    <td style="width: 80px" align="right">通讯地址:</td>
					<td style="width: 25%" align="left" colspan="3"><input align="left" 
						width="100%" id="vcPostalAddress" name="vcPostalAddress"
						class="mini-textbox" readonly="true"
						inputStyle="background-color:#f0f0f0;" /></td>
					<td style="width: 80px" align="right">注册地址:</td>
					<td style="width: 25%" align="left"  ><input align="left"
						width="100%" id="vcRegisteredAddress" name="vcRegisteredAddress"
						class="mini-textbox" readonly="true"
						inputStyle="background-color:#f0f0f0;" /></td>
				</tr>
				<tr>
				    <td style="width: 80px" align="right">备注:</td>
					<td style="width: 25%" align="left" colspan="3"><input align="left"
						width="100%" id="vcRemarks" name="vcRemarks"
						class="nui-textarea" readonly="true"
						inputStyle="background-color:#f0f0f0;" /></td>
				</tr>
			</table>
		</div>
    </div>
    </div>	
	<script type="text/javascript">
		nui.parse();
		var grid = nui.get("datagrid1");
		grid.load();
        var form = new nui.Form("#form1");
		var msg;
		var db = new nui.DataBinding();
		db.bindForm("editForm1", grid);
        var formData = form.getData(false, false);
		grid.load(formData);
		
             
		//查询
		function search() {
		    nui.get("update").enable();
		    var editForm1 = new nui.Form("#editForm1");
        	editForm1.reset();
			var data = form.getData(false, false); //获取表单多个控件的数据
			grid.load(data);
		}
		//重置
		function reset() {
			form.reset();
		}
		var editForm1 = nui.Form("#editForm1");
       //明细重置
		function editReset() {
			editForm1.reset();
		}
        //新增
        function add() {
            nui.open({  
                url: "<%=request.getContextPath()%>/fm/baseinfo/applyTemplet/companyInfoForm.jsp",
            title: "新增公司信息", width: 600, height: 360,
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
                        url: "<%=request.getContextPath() %>/fm/baseinfo/applyTemplet/companyInfoForm.jsp",
                        title: "编辑公司信息",
                        width: 600,
                        height: 360,
                        onload: function () {
                            var iframe = this.getIFrameEl();
                            var data = {pageType:"edit",record:{TAtsCompanyInfo:row}};
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
                    
            //当选择列时
            function selectionChanged(){
                var rows = grid.getSelecteds();
                if(rows.length>1){
                    nui.get("update").disable();
                }else{
                    nui.get("update").enable();
                }
            }
           	//删除
		   function remove(){
				var rows = grid.getSelecteds();
				if(rows.length > 0){
					nui.confirm("确定删除选中记录？","系统提示",
					function(action){
						if(action=="ok"){
							var json = nui.encode({TAtsCompanyInfo:rows});
							grid.loading("正在删除中,请稍等...");
							$.ajax({
								url:"com.cjhxfund.ats.fm.baseinfo.ApplyTemplet.deleteCompanyInfo.biz.ext",
								type:'POST',
								data:json,
								cache: false,
								contentType:'text/json',
								success:function(text){
									var returnJson = nui.decode(text);
									if(returnJson.exception == null){
										grid.reload();
										 var editform = new nui.Form("#editForm1");
										 editform.reset();
										  nui.get("update").enable();
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
                        nui.get("update").enable();
                        editReset();
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
                    
	</script>
	
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>