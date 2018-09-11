<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>	
<!-- 
  - Author(s): 胥思明
  - Date: 2016-11-10 14:06:46
  - Description:
-->

<head>
<title>账户信息查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
	<script type="text/javascript" src="<%=request.getContextPath() %>/fm/baseinfo/applyTemplet/js/swfupload.js"></script>
	
<body style="width:100%;height:100%;overflow:height; margin: 0px;">
<div class="search-condition">
		<div class="list">
			<div id="form1" class="nui-form" align="center" style="height: 10%">
				<!-- 排序字段 -->
				<form id="queryForm" action="">
					<table id="table1" border="0" cellpadding="1" cellspacing="1" style="width: 100%; table-layout: fixed;">
					 <tr>
							<td style="width: 60px" align="right">产品代码:</td>
							<td style="width:10%" align="left">
			                            <input class="nui-textbox" id="vcProductCode" name="map/vcProductCode"  width="100%"/>
			                </td>
			                <td style="width: 60px" align="right">产品名称:</td>
							<td style="width:10%" align="left">
						  	<input style="width: 100%;" id="vcProductName" class="nui-textbox" name="map/vcProductName" /> 
						  	
			              </td>
			                <td style="width:60px; " align="right">账户类型:</td>
		                    <td style="width:10%" align="left" >
		                    	<input id="vcAccountType1" name="map/vcAccountType" data="[{ id: 1, text: '证券账户' }, { id: 2, text: '银行间'}, { id: 3, text: '托管账户'}, { id: 4, text: '机构间账户'}]" 
		                    	class="mini-combobox"  width="100%" showClose="true"  textField="text" valueField="id" 
		                    	  onitemclick="onAccountTypeChanged" oncloseclick="onCloseClickValueEmpty" />
		                    </td>
			              	<td style="width: 80px" align="right">登记托管机构:</td>
						    <td style="width:10%" align="left">
			                            <input class="nui-dictcombobox" 
					                        dictTypeId="CF_JY_DJTGCS" valueField="dictID" textField="dictName"
					                        name="map/vcPaymentPlace" showClose="true" oncloseclick="paymentEmpty" 
					                         id="vcPaymentPlace1"  onitemclick="onPaymentPlaceChanged"   width="100%"/>
			                </td>
								<td align="left" style="width:20%"><a class='nui-button' plain='false'
									iconCls="icon-search" onclick="search()"> 查询 </a>&nbsp;
						    <a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()"> 重置 </a></td>
						   
						    
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
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add()">
                                	增加
                            </a>&nbsp;
                            <a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">
                              	              修改
                            </a>&nbsp;
                             <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()">
                                 	删除
                            </a>&nbsp;
                            <a class="mini-button" iconCls="icon-upload" onclick="importAccount()">导入</a>
                    </tr>
                    <tr>
               </table>
            </div>
    <div id="layout1" class="mini-layout" style="width:100%; height:89%;"  borderStyle="border:solid 1px #aaa;">       
	<div title="center" region="center"  >
     <div class="nui-fit">
		<div id="datagrid1" class="nui-datagrid"
		data="data" style="width: 100%; height: 100%;"
			url="com.cjhxfund.ats.fm.baseinfo.ApplyTemplet.queryAccountInfoWithPage.biz.ext"
			pageSize="20" onShowRowDetail="onShowRowDetailList" sortField="lAccountId" sortOrder="desc"
			showPageInfo="true" multiSelect="true" onselectionchanged="selectionChanged" >
			<div property="columns">
				<div type="indexcolumn"></div>
				<div type="checkcolumn"></div>
				<div field="lAccountId" width="70" headerAlign="center" allowSort="true">序号</div>
				<div field="vcProductCode" width="90" headerAlign="center" allowSort="true">产品代码</div>
				<div field="vcProductName" width="190" headerAlign="center">产品名称</div>
				<div field="vcPaymentPlace" width="110" headerAlign="center" allowSort="true" renderer="vcPaymentPlaceRenderer">登记托管机构</div>
				<div field="vcAccountName" width="100" headerAlign="center" allowSort="true">账户名称</div>
				<div field="vcAccountType" width="90" headerAlign="center" allowSort="true" renderer="renderAccountType">账户类型</div>
				<div field="vcAccountNo" width="100" headerAlign="center" allowSort="true">账户号码</div>
				<div header="托管劵商席位号" headerAlign="center">
                <div property="columns">
                    <div field="vcTrusteeSeatNoSh" width="120" headerAlign="center" allowSort="true">上海</div>
					<div field="vcTrusteeSeatNoSz" width="120" headerAlign="center" allowSort="true">深圳</div>
                </div>
            	</div>
				<div field="vcTrusteePlace" width="100" headerAlign="center">托管所</div>
				<div field="vcLargePaymentNo" width="100" headerAlign="center" allowSort="true">大额支付号</div>
				<div field="vcBankAccount" width="100" headerAlign="center" allowSort="true">资金账户</div>
				<div field="cSource" width="100" headerAlign="center" renderer="cSourceRenderer" allowSort="true">数据来源</div>
				<div field="cStatus" width="100" headerAlign="center" renderer="cStatusRenderer" allowSort="true">状态</div>
				<div field="vcRemarks" width="230" headerAlign="center" allowSort="true">备注</div>
			</div>
		</div>
		</div>
	</div>
	<div title="账户详细信息" region="south" showSplit="false" showHeader="true" height="150" showSplitIcon="true" >
		<div id="editForm1" style="margin-right:15px">
			<input class="mini-hidden" name="id" />
			<table border="0" cellpadding="1" cellspacing="1"
				style="width: 100%; table-layout: fixed;">
				<tr>
                    <td style="width:100px;height:50%" align="right">产品代码:</td>
                    <td>
                    	<input name="vcProductCode" class="mini-textbox" style="width:80%" readonly="true" inputStyle="background-color:#f0f0f0;" />
                    </td>
                    <td style="width:130px;" align="right">产品名称:</td>
                    <td>
                    	<input name="vcProductName" class="mini-textbox" style="width:80%" readonly="true" inputStyle="background-color:#f0f0f0;" />
                    </td>
	        		<td style="width:180px;" align="right">登记托管机构:</td>
                    <td>
                   	<input align="left" width="80%" id="vcPaymentPlace" name="vcPaymentPlace" class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" readonly="true"  inputStyle="background-color:#f0f0f0;"/> 
                   </td>
	        	</tr>
	        	
	        	<tr>
                    <td style="width:80%;" align="right">账户名称:</td>
                    <td>
                    	<input name="vcAccountName" class="mini-textbox" style="width:80%" readonly="true" inputStyle="background-color:#f0f0f0;" />
                    </td>
                    <td style="width:120px;" align="right">账户号码:</td>
                    <td>
                    	<input name="vcAccountNo" class="mini-textbox" style="width:80%" readonly="true" inputStyle="background-color:#f0f0f0;" />
                    </td>
                    <td align="right">托管券商席位号(上海):</td>
						<td style="width:100px;" align="left">
	                    	<input style="width: 80%"  id="vcTrusteeSeatNoSh" name="vcTrusteeSeatNoSh" class="mini-textbox" readonly="true" inputStyle="background-color:#f0f0f0;" /><br/>
	                    </td>
	        	</tr>
	        	<tr>
                    
                    <td style="width:80%; " align="right">账户类型:</td>
                    <td >
                    	<input id="vcAccountType" name="vcAccountType" data="[{ id: 1, text: '证券账户' }, { id: 2, text: '银行间'}, { id: 3, text: '托管账户'}, { id: 4, text: '机构间账户'}]" class="mini-combobox" style="width:80%" readonly="true" inputStyle="background-color:#f0f0f0;" />
                    </td><td style="width:80%;" align="right">托管所:</td>
                    <td>
                    	<input name="vcTrusteePlace" class="mini-textbox" style="width:80%" readonly="true" inputStyle="background-color:#f0f0f0;" />
                    </td>
                    <td align="right">托管券商席位号(深圳):</td>
					<td style="width:100px;" align="left">
                    	<input style="width: 80%"  id="vcTrusteeSeatNoSz" name="vcTrusteeSeatNoSz" class="mini-textbox" readonly="true" inputStyle="background-color:#f0f0f0;" />
                    </td>
	        	</tr>
	        	<tr>
                    <td style="width:80%;" align="right">大额支付号:</td>
                    <td>
                    	<input name="vcLargePaymentNo" class="mini-textbox" style="width:80%" readonly="true" inputStyle="background-color:#f0f0f0;" />
                    </td>
                    <td style="width:80%;" align="right">资金账户:</td>
                    <td>
                    	<input name="vcBankAccount" class="mini-textbox" style="width:80%" readonly="true" inputStyle="background-color:#f0f0f0;" />
                    </td>
				    <td style="width:80%;" align="right">数据来源:</td>
                    <td>
                    	<input name="cSource" class="nui-dictcombobox" dictTypeId="ATS_FM_STOCKSOURCE" style="width:80%" readonly="true" inputStyle="background-color:#f0f0f0;" />
                    </td>
	        	</tr>
				<tr>
                    <td style="width:80%;" align="right">状态:</td>
                    <td>
                    	<input name="cStatus" class="nui-dictcombobox" dictTypeId="newstockStatus" style="width:80%" readonly="true" inputStyle="background-color:#f0f0f0;" />
                    </td>
					<td style="width: 80px" align="right">备注:</td>
					<td colspan="3" align="left" ><input align="left"
						width="93%" id="vcRemarks" name="vcRemarks"
						class="mini-textbox" readonly="true"
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
         $("#editForm1 .mini-buttonedit-buttons").remove();
		 $("#editForm1 .mini-buttonedit-border").css("background-color","#f0f0f0");
		function renderAccountType(e){
		if(e.value == "1"){
			return "证券账户";
		}else if (e.value == "2"){
			return "银行间";
		}else if (e.value == "3"){
			return "托管账户";
		}else if (e.value == "4"){
			return "机构间账户";
		}else {
			return "其他";
		}
    }
    function cStatusRenderer(e){
    	return nui.getDictText("newstockStatus",e.row.cStatus);
    }
    function cSourceRenderer(e){
    	return nui.getDictText("ATS_FM_STOCKSOURCE",e.row.cSource);
    }
    //如果账户类型为“机构间账户”，那么登记托管机构为“其他”
    function onAccountTypeChanged(e) {
        if(e.item.id == '4'){
         nui.get("vcPaymentPlace1").setValue(99);
        }
    }
    //如果登记托管机构为“其他”，那么账户类型应该为非“证券账户”和“银行间账户”。
    function onPaymentPlaceChanged(e) {
        if(e.item.dictID == '99'){
         nui.get("vcAccountType1").setData("[{ id: 3, text: '托管账户'}, { id: 4, text: '机构间账户'}]");
        }else{
         nui.get("vcAccountType1").setData("[{ id: 1, text: '证券账户' }, { id: 2, text: '银行间'}, { id: 3, text: '托管账户'}, { id: 4, text: '机构间账户'}]");
        }
        
      if(nui.get("vcAccountType1").getValue() == 4){
          if(nui.get("vcPaymentPlace1").getValue() != 99){
             nui.get("vcAccountType1").setValue("");
          }
            nui.get("vcAccountType1").setValue("");
          }
    }
   function paymentEmpty(){
        nui.get("vcPaymentPlace1").setValue("");
        nui.get("vcAccountType1").setData("[{ id: 1, text: '证券账户' }, { id: 2, text: '银行间'}, { id: 3, text: '托管账户'}, { id: 4, text: '机构间账户'}]");
     }
        
   function vcPaymentPlaceRenderer(e){
        		return nui.getDictText("CF_JY_DJTGCS",e.row.vcPaymentPlace);
        }
		//查询
		function search() {
			var data = form.getData(false, false); //获取表单多个控件的数据
			var editForm1 = new nui.Form("#editForm1");
        	editForm1.reset();
			grid.load(data);
		}
		//重置
		function reset() {
			form.reset();
		}

   //新增
        function add() {
            nui.open({  
                url: "<%=request.getContextPath()%>/fm/baseinfo/applyTemplet/addAccountInfo.jsp",
            title: "新增账户信息", width: 780, height: 390,overflow:"hidden",
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
                        url: "<%=request.getContextPath() %>/fm/baseinfo/applyTemplet/addAccountInfo.jsp",
                        title: "修改账户信息",
                        width: 780,
                        height: 390,
                        onload: function () {
                            var iframe = this.getIFrameEl();
                            var data = {pageType:"edit",record:{accountInfo:row}};
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
							var json = nui.encode({accountInfo:rows});
							grid.loading("正在删除中,请稍等...");
							$.ajax({
								url:"com.cjhxfund.ats.fm.baseinfo.ApplyTemplet.deleteAccountInfo.biz.ext",
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
		
		//导出
       function  exportExcel(){
       		var frm = document.getElementById("queryForm");
       		var rows = grid.getSelecteds();
       		var ids = new Array();
            if (rows.length > 0) {
                for(var i=0;i<rows.length;i++){
                	ids.push(rows[i].lStockIssueId);
                }
                var data = ids.join(',');
                 nui.get("excelData").setValue(data);
				frm.action = "com.cjhxfund.ats.fm.baseinfo.accountInfoExport.flow";
				frm.submit();
            } else {
                alert("请选中一条记录");
                return false;
            }
       }
       
                    //重新刷新页面
                   function refresh(){
                        var form = new  nui.Form("#form1");
                        var json = form.getData(false,false);
                        grid.load(json);//grid查询
                        nui.get("update").enable();
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
	            function importAccount() {
					mini.open({
					    title: "导入账户信息", width: 850, height: 580,
					    url:"<%=request.getContextPath() %>/fm/baseinfo/fileupload/importAccountFile.jsp",
					    overflow:"hidden",
					    onload: function () {
					        var iframe = this.getIFrameEl();
					        var data = { action: "new"};
					        //iframe.contentWindow.SetData(data);
					    },
					    ondestroy: function (action) {
					
					        grid.reload();
					    }
					});
		        }  
    	nui.parse();
	</script>
	
</body>
</html>