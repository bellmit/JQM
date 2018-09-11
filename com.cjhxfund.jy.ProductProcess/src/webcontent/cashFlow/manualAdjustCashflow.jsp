<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String preDateOne = DateUtil.getCalculateTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null, 0);
%>
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<!-- 
  - Author(s): chendi
  - Date: 2017-06-12 09:19:14
  - Description:
-->
<head>
<title>资金流水调整表</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheetet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
<script src="<%= request.getContextPath() %>/ProductProcess/cashFlow/cashFlow_common.js" type="text/javascript"></script>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div style="width:100%;height:100%;">
		   <%-- 资金流水调整查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_SGTZXJL" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" id="queryType" name="paramObject/queryType" value="SGTZXJL">
				 	<%-- 开始日期 --%>
				 	<input id="fromDate" class="nui-hidden" name="paramObject/fromDate">
				 	<%-- 结束日期 --%>
					<input id="toDate" class="nui-hidden" name="paramObject/toDate">
				 	
	                <table id="table_SGTZXJL" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="80px" align="right">
								资金变动日期:
	                        </td>
	                        <td colspan="1" width="25%" align="left">
	                            <input id="dateOne" class="nui-datepicker" allowInput="false" name="paramObject/dateOne" valueType="String" />
								<span style="width:2%;">-</span>
								<input id="dateTwo" class="nui-datepicker" allowInput="false" name="paramObject/dateTwo" valueType="String" />
	                        </td>
	                		<td class="form_label" width="60px" align="right">
								产品名称:
	                        </td>
	                        <td colspan="1" width="20%" align="left">
	                            <input id="vCProductCode_SGTZXJL" class="nui-buttonedit" name="paramObject/vCProductCode" onbuttonclick="ButtonClickGetFundName_SGTZXJL"/>
	                        </td>
	                        <td colspan="10">
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_SGTZXJL()"/>
	                        	<input class='nui-button' plain='false' text="重置" iconCls="icon-cancel"  onclick="reset_SGTZXJL()"/>
	                        	
	                            <input class='nui-button' plain='false' id="export_SGTZXJL" text="导出" iconCls="icon-download" onclick="export_SGTZXJL()"/>
	                        </td>
	                        <!-- <td style="width:150px;" align="right">
	                        	<span class="warn_red_bold">数据每 3分钟自动刷新</span>
	                        </td> -->
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 资金流水调整表查询条件结束!!! --%>
		   
		   <%-- 资金流水调整表列表开始... --%>
		   <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <input class='nui-button' plain='false' text="新增" iconCls="icon-add" onclick="add_SGTZXJL()"/>
                        	<input class='nui-button' plain='false' text="修改" iconCls="icon-edit" onclick="edit_SGTZXJL()"/>
                        	<input class='nui-button' plain='false' text="删除" iconCls="icon-remove" onclick="delete_SGTZXJL()"/>
                        </td>
                    </tr>
                </table>
            </div>
            <!--  -->
           <div class="nui-fit">
                <div 
                    id="datagrid_SGTZXJL"
                    dataField="resultObjectList"
                    class="nui-datagrid"
                    style="width:100%;height:100%;"
                    url="com.cjhxfund.jy.ProductProcess.CashFlow.positionForecastManage.biz.ext"
                    pageSize="10"
                   	showPageInfo="true"
                    allowSortColumn="true"
                    sortMode="client"
                    enableHotTrack="true"
                    allowHeaderWrap="true"
                    sizeList="[10,20,50]"
                    allowCellEdit="true"
					allowCellSelect="true"
					enterNextCell="true"
					allowMoveColumn="true"
					editNextOnEnterKey="true"
					multiSelect="true"   
					showfooter="false" 
					pagerButtons="#prompt_hisCashflowInfo">
                	<div property="columns">
	                    <div type="indexcolumn" width="40px">序号</div>
	                    <div type="checkcolumn" width="3%"></div>
	                    <div field="lDate" headerAlign="center" allowSort="true" align="left" width="80px">
	        	资金变动日期
		                </div>
		                <div field="vcProductName" headerAlign="center" allowSort="true" align="left" width="180px">
	        	产品名称
		                </div>
	                    <div field="vcAssetName" headerAlign="center"  align="left" width="180px">
                                                单元名称
	                    </div>
	                    <div field="enAdjustAmount" headerAlign="center"  align="right" width="120px">
            	调整金额
	                    </div>
	                    <div field="vcAdjustRemark" headerAlign="center"  align="left" width="120px">
                                                调整说明
	                    </div>
	                    <div field="vcAdjusterName" headerAlign="center"  align="left" width="120px">
                                                调整人
	                    </div>
	                    <div field="dAdjustTime" headerAlign="center"  align="left" width="180px" dateFormat="yyyy-MM-dd HH:mm:ss">
                                                调整时间
	                    </div>
		                <div field="vcProductCode" visible="false" headerAlign="center" align="left" width="120px">
	        	 产品代码
		                </div>
		                <div field="vcAssetCode" visible="false" headerAlign="center" align="left" width="120px">
	        	 单元代码
		                </div>
                	</div>
            	</div>
            	<%-- 列表底部工具栏 --%>
	            <div id="prompt_hisCashflowInfo">
					<div id="hisCashflowInfo" name="searchData/hisCashflowInfo"
						style="margin-left: 50px;" false" class="nui-checkbox"
						onclick="queryHisCashflowInfo()" readOnly="false" text="显示所有历史记录">
					</div>
					<!-- <div class='nui-button' plain='false' id="export_HIS_SGTZXJL" text="导出全部历史记录" 
						 iconCls="icon-download" onclick="export_HIS_SGTZXJL()">
					</div> -->
				</div>
        	</div>
        	<%-- 资金流水调整表列表结束!!! --%>
        
        <!-- 手工调整现金流水记录历史Grid -->
        <form id="form_SGTZXJL_HIS" method="post">
        	<%-- 查询类型 --%>
		 	<input class="nui-hidden" id="queryType" name="paramObject/queryType" value="SGTZXJL_HIS" />
		 	<input class="nui-hidden" id="hisProductCode" name="paramObject/hisProductCode" />
        </form>
		<div class="nui-tabs"
			style="width: 100%; height: auto; overflow-x: auto;" activeIndex="0">
			<div title="T+N头寸预测手工调整历史记录">
				<div id="hisCashflowGrid" class="mini-datagrid"
					showReloadButton="false" style="width: 100%; height: 300px;"
					url="com.cjhxfund.jy.ProductProcess.CashFlow.positionForecastManage.biz.ext"
					idField="lLockId" allowResize="true" showPager="false"
					dataField="resultObjectList">
					<div property="columns">
						<div type="indexcolumn" width="40px">序号</div>
						<div field="lDate_his" headerAlign="center" align="left" width="80px">资金变动日期</div>
		                <div field="vcProductName_his" headerAlign="center" align="left" width="180px">产品名称</div>
	                    <div field="vcAssetName_his" headerAlign="center"  align="left" width="180px">单元名称</div>
	                    <div field="enAdjustAmount_his" headerAlign="center"  align="right" width="120px">调整金额</div>
	                    <div field="vcAdjustRemark_his" headerAlign="center"  align="left" width="120px">调整说明</div>
	                    <div field="vcAdjusterName_his" headerAlign="center"  align="left" width="120px">调整人</div>
	                    <div field="dAdjustTime_his" headerAlign="center"  align="left" width="180px" dateFormat="yyyy-MM-dd HH:mm:ss">调整时间</div>
		                <div field="vcProductCode_his" visible="false" headerAlign="center" align="left" width="120px">产品代码</div>
		                <div field="vcAssetCode_his" visible="false" headerAlign="center" align="left" width="120px">单元代码</div>
	                </div>
				</div>
			</div>
		</div>
	</div>
</div>	

<script type="text/javascript">
	nui.parse();
	//设置默认时间 
	var preDateOne = "<%=preDateOne%>";
	nui.get("dateOne").setValue(preDateOne);
	var grid_SGTZXJL = nui.get("datagrid_SGTZXJL");//资金流水调整表
	
	var refreshInt = true;//刚刚打开页面时，投顾默认刷新，交易员默认不刷新
    var queryUserTypeTemp = "<%=request.getParameter("queryUserType")%>";
	if(queryUserTypeTemp!=null && queryUserTypeTemp!="" && queryUserTypeTemp!="null"){
		refreshInt = false;
	}
	
	<%-- 资金流水调整表开始... --%>
	//获取查询条件的基金名称
	function ButtonClickGetFundName_SGTZXJL(e){
        ButtonClickGetFundName(this, null);
	}
    //行双击时弹出页面展示该指令详细信息
	grid_SGTZXJL.on("rowdblclick", function (e) {
		var record = e.record;
		var grid_hisCashflow = nui.get("hisCashflowGrid");
		var conditionForm = new nui.Form("#form_SGTZXJL_HIS");
		var json = conditionForm.getData(false, false);
		//下拉框多选处理
		json["paramObject/hisProductCode"] = record.vcProductCode;
		grid_hisCashflow.load(json);
	});
	
    //重置
    function reset_SGTZXJL(){
    	var form = new nui.Form("#form_SGTZXJL");//将普通form转为nui的form
		form.reset();
    }
    //查询
	function search_SGTZXJL(){
		//日期格式转换
		var fromDate = null;
		var toDate = null;
		if(nui.get("dateOne").getValue()!=null&&nui.get("dateOne").getValue()!=""){
			fromDate = DateUtil.toNumStr(nui.get("dateOne").getValue());
		}
		if(nui.get("dateTwo").getValue()!=null&&nui.get("dateTwo").getValue()!=""){
			toDate = DateUtil.toNumStr(nui.get("dateTwo").getValue());
		}
		nui.get("fromDate").setValue(fromDate);
		nui.get("toDate").setValue(toDate);
		var conditionForm = new nui.Form("#form_SGTZXJL");
		var json = conditionForm.getData(false, false);
		//下拉框多选处理
		json["paramObject/vcProductCode"] = splitString(nui.get("vCProductCode_SGTZXJL").getValue());
		grid_SGTZXJL.load(json);
		//反选显示所有历史记录
		if(nui.get("hisCashflowInfo").checked){
			nui.get("hisCashflowInfo").setValue(false);
		}
		//清空历史记录
		nui.get("hisCashflowGrid").load(null);
	}
	//显示全部现金流水历史调整记录
	function queryHisCashflowInfo(){
		var check = nui.get("hisCashflowInfo").checked;
		if(check){
			var grid_hisCashflow = nui.get("hisCashflowGrid");
			search(grid_hisCashflow, "#form_SGTZXJL_HIS");
		}else{
			nui.get("hisCashflowGrid").clearRows();
		}
	}
	//处理下拉框多选的情况：给多选字符加上单引号
	function splitString(data){
		var mulString = null;
		if(data != null && data != ""){
			var strs= data.split(",");
    		if(strs.length>0){
    			for(var i=0; i<strs.length; i++ ){ 
						if(i == 0){
							mulString = "'"+strs[i]+"'";
						}else{
							mulString += ",'"+strs[i]+"'";
						}
					} 
    		}
		}
		return mulString;
    }
    
    //导出最新现金流水记录
    function export_SGTZXJL(){
    	//导出
	    exportSubmit("export_SGTZXJL", "form_SGTZXJL", "手工调整头寸预测记录表","SGTZXJL");
    }
	//新增
	function add_SGTZXJL() {
		nui.open({
			url: "<%= request.getContextPath() %>/ProductProcess/cashFlow/addAdjCashflow.jsp",
			title: "新增现金流水记录",
			width: 500,
			height: 340,
			onload: function () {
				var iframe = this.getIFrameEl();
				var data = {pageType:"add"};
				//直接从页面获取，不用去后台获取
				iframe.contentWindow.setFormData(data);
			},
			ondestroy: function (action) {
				grid_SGTZXJL.reload();
			}
		});
	}
	
	//编辑
	function edit_SGTZXJL() {
		var row = grid_SGTZXJL.getSelecteds();
		if (row.length>0) {
			nui.open({
				url: "<%= request.getContextPath() %>/ProductProcess/cashFlow/editAdjCashflow.jsp",
				title: "编辑现金流水记录",
				width: 500,
				height: 400,
				onload: function () {
					var iframe = this.getIFrameEl();
					var data = {pageType:"edit",record:{cashFlow:row}};
					//直接从页面获取，不用去后台获取
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function (action) {
					grid_SGTZXJL.reload();
				}
			});
		} else {
			nui.alert("请选中一条记录","提示");
		}
	}
	
	//删除
	function delete_SGTZXJL(){
		var rows = grid_SGTZXJL.getSelecteds();
		if(rows.length > 0){
			nui.confirm("确定删除选中记录？","系统提示",
			function(action){
				if(action=="ok"){
					var json = nui.encode({cashFlows:rows});
					//grid_SGTZXJL.loading("正在删除中,请稍等...");
					nui.ajax({
						url:"com.cjhxfund.jy.ProductProcess.CashFlow.deleteAdjCashflow.biz.ext",
						type:'POST',
						data:json,
						cache: false,
						contentType:'text/json',
						success:function(text){
							var returnJson = nui.decode(text);
							if(returnJson.rtnCode == "0"){
								nui.alert("删除成功", "系统提示", function(action){
									grid_SGTZXJL.reload();
								});
							}else{
								nui.alert("删除失败", "系统提示", function(action){
									grid_SGTZXJL.unmask();
								});
							}
						}
					});
				}
			});
		}else{
			nui.alert("请选中一条记录！");
		}
	}
	<%-- 资金流水调整表结束!!! --%>
</script>
</body>
</html>