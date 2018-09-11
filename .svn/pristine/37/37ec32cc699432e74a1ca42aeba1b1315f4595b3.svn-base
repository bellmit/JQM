<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<%--
- Author(s): huangmizhi
- Date: 2015-10-14 10:47:44
- Description: 产品权限配置
--%>
<head>
<title>产品权限配置</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style>
    .mini-popup{
    	height:auto!important;
    }
    .mini-listbox-view{
    	height:auto!important;
    }
    </style>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	
	   <%-- 查询条件开始... --%>
	   <div class="search-condition">
		   <div class="list">
			   <div id="form1" class="nui-form" style="height:10%" align="center" >
	            <!-- 数据实体的名称 -->
	            <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.fm.baseinfo.basicInfo.TAtsProductHandle">
	            <!-- 排序字段 -->
	            <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="vcRelateType">
	            <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="asc">
	            <input class="nui-hidden" name="criteria/_orderby[2]/_property" value="vcUserId">
	            <input class="nui-hidden" name="criteria/_orderby[2]/_sort" value="asc">
	            <input class="nui-hidden" name="criteria/_orderby[3]/_property" value="vcProductCode">
	            <input class="nui-hidden" name="criteria/_orderby[3]/_sort" value="asc">
	            <table id="table1" class="table" style="table-layout:fixed;">
	                <tr>
	                    <td class="form_label" width="10%" align="right">
	                        权限类型:
	                    </td>
	                    <td colspan="1" width="20%" align="left">
	                        <input class="nui-dictcombobox" name="criteria/_expr[1]/vcRelateType" valueField="dictID" textField="dictName" dictTypeId="CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE"  
								emptyText="全部" nullItemText="全部" showNullItem="true"  multiSelect="true" width="95%" popupWidth="250px" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
							<input class="nui-hidden" name="criteria/_expr[1]/_op" value="in"/>
	                    </td>
	                    <td class="form_label" width="10%" align="right">
	                        用户姓名:
	                    </td>
	                    <td colspan="1" width="20%" align="left">
	                        <input class="nui-textbox" name="criteria/_expr[2]/vcUserName" width="95%"/>
	                        <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
	                        <input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
	                    </td>
	                    <td class="form_label" width="10%" align="right">
	                        产品代码:
	                    </td>
	                    <td colspan="1" width="20%" align="left">
	                        <input class="nui-textbox" name="criteria/_expr[3]/vcProductCode" width="95%"/>
	                        <input class="nui-hidden" name="criteria/_expr[3]/_op" value="like">
	                        <input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
	                    </td>
	                   <td colspan="1" rowspan="2" width="10%" align="left">
                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
                        </td> 
	              </tr>
	              <tr>      
	                    <td class="form_label" width="10%" align="right">
	                        产品名称:
	                    </td>
	                    <td colspan="1" width="20%" align="left">
	                        <input class="nui-textbox" name="criteria/_expr[4]/vcProductName" width="95%"/>
	                        <input class="nui-hidden" name="criteria/_expr[4]/_op" value="like">
	                        <input class="nui-hidden" name="criteria/_expr[4]/_likeRule" value="all">
	                    </td>
	                    <td class="form_label" width="10%" align="right">
	                        投资组合编号:
	                    </td>
	                    <td colspan="1" width="20%" align="left">
	                        <input class="nui-textbox" name="criteria/_expr[5]/vcCombiNo" width="95%"/>
	                        <input class="nui-hidden" name="criteria/_expr[5]/_op" value="like">
	                        <input class="nui-hidden" name="criteria/_expr[5]/_likeRule" value="all">
	                    </td>
	                    <td class="form_label" width="10%" align="right">
	                        投资组合名称:
	                    </td>
	                    <td colspan="1" width="20%" align="left">
	                        <input class="nui-textbox" name="criteria/_expr[6]/vcCombiName" width="95%"/>
	                        <input class="nui-hidden" name="criteria/_expr[6]/_op" value="like">
	                        <input class="nui-hidden" name="criteria/_expr[6]/_likeRule" value="all">
	                    </td>
	                    
	                </tr>
	            </table>
	         </div>
		  </div>
	   </div>
	   <%-- 查询条件结束!!! --%>
	   
	   
	   <%-- 产品权限配置列表开始... --%>
	   <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class='nui-button' plain='false' iconCls="icon-add" onclick="add()">
                            增加
                        </a>
                        <!-- 
                        <a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">
                            编辑
                        </a>
                         -->
                        <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()">
                            删除
                        </a>
                        <span></span>
                        <privilege:operation sourceId="ATS_XZCX_TBO32PI" sid="synProdInfo" clazz="nui-button" onClick="synProdInfo()" lableName="同步产品信息"  iconCls="icon-find" ></privilege:operation>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div 
                id="datagrid1"
                dataField="TAtsProductHandles"
                class="nui-datagrid"
                style="width:100%;height:100%;"
                url="com.cjhxfund.ats.fm.baseinfo.TAtsProductHandleBiz.queryTAtsProductHandles.biz.ext"
                pageSize="200"
                showPageInfo="true"
                allowSortColumn="true"
                sortMode="client"
                enableHotTrack="true"
                allowHeaderWrap="true"
                sizeList="[10,20,50,100,200,500,1000,2000]"
                allowCellEdit="true"
				allowCellSelect="true"
				enterNextCell="true"
				allowMoveColumn="true"
				editNextOnEnterKey="true"
				multiSelect="true"   showfooter="false">

            <div property="columns">
                <div type="indexcolumn">
                </div>
                <div type="checkcolumn">
                </div>
                <div field="vcRelateType" name="vcRelateType" headerAlign="center" allowSort="true" align="left" renderer="renderRelaType" width="130px">
                    权限类型
                </div>
                <div field="vcUserName" name="vcUserName" headerAlign="center" allowSort="true" align="left" width="80px">
                    用户姓名
                </div>
                <div field="vcProductCode" headerAlign="center" allowSort="true" align="left" width="80px">
                    产品代码
                </div>
                <div field="vcProductName" headerAlign="center" allowSort="true" align="left" width="150px">
                    产品名称
                </div>
                <div field="vcCombiNo" headerAlign="center" allowSort="true" align="left" width="100px">
                    投资组合编号
                </div>
                <div field="vcCombiName" headerAlign="center" allowSort="true" align="left" width="130px">
                    投资组合名称
                </div>
                <div field="lAssetId" headerAlign="center" allowSort="true" align="left" width="80px">
                    资产单元序号
                </div>
            </div>
        </div>
    </div>
	<%-- 产品权限配置列表结束!!! --%>
    
    <!-- 账户详情，产品权限配置没必要看以下账户详情信息，暂时屏蔽掉，by huangmizhi 20171026 -->
    <%-- 
    <fieldset style="border:solid 1px #aaa;position:relative;">
        <legend>账户详情</legend>
        <div id="editForm1" >
            <input class="mini-hidden" name="id"/>
             <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
	                <tr>
	                    <td style="width:140px" align="right">产品名称:</td>
	                    <td style="width:25%" align="left">
	                    	<input align="left" width="100%" id="vcProductName" name="vcProductName" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
	                    </td>
	                    <td style="width:140px" align="right">市场:</td>
	                    <td style="width:25%" align="left">
	                    	<input align="left" width="100%" id="vcPaymentPlace" name="vcPaymentPlace" class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
	                    </td>
	                    <td style="width:140px" align="right">账户类型:</td>
	                    <td style="width:25%" align="left">
	                    	<input align="left" width="100%" name="vcAccountType" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
	                    </td>
	                    
	                </tr>
	                <tr>
	                	<td  align="right">账户名称:</td>
	                    <td style="width:25%" align="left">
	                    	<input align="left" width="100%" id="vcAccountName" name="vcAccountName" class="mini-textbox"   readonly="true"  inputStyle="background-color:#f0f0f0;"/>
	                    </td>
	                    <td align="right">账户号码:</td>
	                    <td align="left">
	                    	<input id="vcAccountNo" width="100%" name="vcAccountNo" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
	                    </td>
	                    <td align="right">托管券商席位号（上海）:</td>
	                    <td align="left">
	                    	<input id="vcTrusteeSeatNoSh" width="100%" name="vcTrusteeSeatNoSh" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
	                    </td>
	                   
	                </tr>
	                
	                 <tr>
	                 	 <td align="right">托管券商席位号（深圳）:</td>
	                    <td align="left">
	                    	<input id="vcTrusteeSeatNoSz" width="100%" name="vcTrusteeSeatNoSz" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
	                    </td>
	                    <td align="right">托管行:</td>
	                    <td align="left">
	                    	<input id="vcTrusteePlace" width="100%" name="vcTrusteePlace" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
	                    </td>
	                    <td align="right">大额支付号:</td>
	                    <td align="left">
	                    	<input id="vcLargePaymentNo" width="100%" name="vcLargePaymentNo" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
	                    </td>
	                </tr>
	            </table>
        </div>
    </fieldset>
    --%>
</div>

<script type="text/javascript">
	nui.parse();
	var grid = nui.get("datagrid1");
	
	var formData = new nui.Form("#form1").getData(false,false);
	grid.load(formData);
	 $("#editForm1 .mini-buttonedit-buttons").remove();
	 $("#editForm1 .mini-buttonedit-border").css("background-color","#f0f0f0");
	//行双击时重新设置tabs页面参数
	grid.on("rowclick", function (e) {
	
        var data = {lProductId:e.row.lProductId,vcProductCode:e.row.vcProductCode};
		var json = nui.encode(data); 
		var form = new nui.Form("#editForm1");//将普通form转为nui的form
		nui.ajax({
				url:"com.cjhxfund.ats.fm.baseinfo.ApplyTemplet.getAccountInfoById.biz.ext",
				type:'POST',
				data:json,
				cache: false,
				contentType:'text/json',
				success:function(text){
					var returnJson = nui.decode(text);
					form.setData(returnJson.accountInfo);
				}
			});
		
    });
	
	//新增
	function add() {
		window.open("<%=request.getContextPath() %>/fm/baseinfo/AddProductAuthority.jsp");
		
	}
	
	//编辑
	function edit() {
		var row = grid.getSelected();
		if (row) {
			nui.open({
				url: "<%=request.getContextPath()%>/basicInfo/CFJYCombProductHandleForm.jsp",
				title: "编辑权限",
				width: 600,
				height: 300,
				onload: function () {
					var iframe = this.getIFrameEl();
					var data = {pageType:"edit",record:{TAtsCombProductHandles:row}};
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
					var json = nui.encode({TAtsProductHandles:rows});
					grid.loading("正在删除中,请稍等...");
					$.ajax({
						url:"com.cjhxfund.ats.fm.baseinfo.TAtsProductHandleBiz.deleteTAtsProductHandles.biz.ext",
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
		var grid1 = nui.get("datagrid1");
		grid1.load(json);//grid查询
		//nui.get("update").enable();
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
		//var rows = grid.getSelecteds();
		//if(rows.length>1){
		//	nui.get("update").disable();
		//}else{
		//	nui.get("update").enable();
		//}
	}
	
	//关系类型处理
    function renderRelaType(e) {
		return nui.getDictText("CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE",e.row.vcRelateType);
	}
	
	//合并单元格
	grid.on("load", function () {
    	grid.mergeColumns(["vcRelateType", "vcUserName"]);
    });
    //获取O32产品信息
    function synProdInfo() {
	          var type = 12;
	          var json = nui.encode({buttonType:type});
	          nui.ajax({
	            url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getBondInfoData.biz.ext",
	            type: "post",
	            contentType:'text/json',
	            data: json ,
	            success: function (text) {
	              var returnJson = nui.decode(text);
	              if (returnJson.returnValue == true) {
	                 nui.alert("同步O32产品信息结果：成功", "", function(){});
	              }
	              else {
	              	 nui.alert("同步O32产品信息结果：失败", "", function(){});
	              }
	            }
	          });  
        }
    
</script>

</body>
</html>
