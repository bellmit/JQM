<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<!-- 
  - Author(s): 章璐
  - Date: 2017-06-15 09:42:31
  - Description:
-->
<head>
<title>资管计划底层资产信息</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/locale/zh_CN.js" type="text/javascript"></script>
</head>
<body style="width:100%;height:100%;">
		   <%--查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_ZGJHDCZCXX" method="post">
		   		<%-- 查询用户类型，url，导出文件名称 --%>
			 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
			 	<input class="nui-hidden" name="paramObject/url" value="/ProductProcess/Bank_Push/queryManagementAssets.jsp">
			 	<input class="nui-hidden" id="fileName" name="paramObject/fileName" value="">
			 	<input class="nui-hidden" id="flag" value="<b:write property="flag"/>"/>
			 	<%-- 查询类型 --%>
			 	<input class="nui-hidden" name="paramObject/queryType" value="ZGJHDCZCXX">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                    <tr>
	                        <td style="width:60px" align="right">
								日期:
	                        </td>
	                        <td style="width:15%" align="left">
	                            <input id="L_DATE" class="nui-datepicker" width="100%" format="yyyy-MM-dd" name="paramObject/lDate" required="true" allowInput="false"/>
	                        </td>
	                    	<td style="width:80px" align="right">
								产品名称:
							</td>
							<td style="width:30%" align="left">
								<input id="vCFundCode_HSFAGZB" class="nui-buttonedit" width="100%" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_HSFAGZB"/>
							</td>
	                        <td colspan="4" >
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_ZGJHDCZCXX()"/>&nbsp;&nbsp;
	                        	<input class='nui-button' plain='false' text="重置" iconCls="icon-cancel"  onclick="resetDire_ZGJHDCZCXX()"/>&nbsp;&nbsp;
	                            <input id="export_ZGJHDCZCXX" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_ZGJHDCZCXX()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 查询条件结束!!! --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_ZGJHDCZCXX"
                        dataField="resultObjectList"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryWTRD.biz.ext"
                        pageSize="50"
                        showPageInfo="true"
                        virtualScroll="true"
                        allowSortColumn="true"
                        sortMode="client"
                        enableHotTrack="true"
                        sizeList="[20,50,100,500,1000]">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        
                        <div field="FXJG_NAME" renderer="dateRen" headerAlign="center" allowSort="true" align="center" width="100px">
                          发行机构代码
                        </div>
                        <div field="DY_BALANCE_CODE" headerAlign="center" allowSort="true" align="left" width="220px">
                            对应资产管理计划行内资产/负债编码
                        </div>
                        <div field="ISSUE_AMOUNT" headerAlign="center" allowSort="true" align="left" width="140px">
                           资管计划当前总发行数量
                        </div>
                        <div field="CURRENT_AMOUNT" headerAlign="center" allowSort="true" align="right" width="220px">
                           资管计划当前总折算人民币发行金额(元)
                        </div>
                        <div field="NO_INVESTMENT_POSITIONS" headerAlign="center" allowSort="true" align="right" width="200px">
                            资管计划折算人民币未投资头寸(元)
                        </div>
                        <div field="BALANCE_CODE" headerAlign="center" allowSort="true"  align="left" width="160px">
                           底层资产行内资产负债/编码
                        </div>
                        <div field="POAIRION_QUANTITY" headerAlign="center" allowSort="true" align="left" width="120px">
                            底层资产持仓数量
                        </div>
                        <div field="RMB_VALUR" headerAlign="center" allowSort="true" align="right" width="160px">
                            底层资产折算人民币市值(元)
                        </div>
                        <div field="CC_DATE" headerAlign="center" allowSort="true" align="left" width="80px">
                            持仓日期
                        </div>
                    </div>
                </div>
            </div>

<script type="text/javascript">
    nui.parse();
    nui.get("L_DATE").setValue((new Date()));
    var grid_ZGJHDCZCXX = nui.get("datagrid_ZGJHDCZCXX");//产品交易流水-交易所
    var form = new nui.Form("#form_ZGJHDCZCXX");
	var json = form.getData(false,false);
	//grid_ZGJHDCZCXX.load(json);
	
	//查询
	function search_ZGJHDCZCXX() {
		var fundName = changeNull(nui.get("vCFundCode_HSFAGZB").getText());
		if(fundName==""){
			nui.alert("请先选择产品名称！");
			return;
		}
		var qdate = nui.get("L_DATE").getValue();
		if(qdate ==""){
			nui.alert("请先选择日期！");
			return;
		}
		search(grid_ZGJHDCZCXX, "#form_ZGJHDCZCXX");
	}
		//获取查询条件的基金名称
	function ButtonClickGetFundName_HSFAGZB(e){
        ButtonClickGetFundNameOne(this, null);
	}
		//导出
	function export_ZGJHDCZCXX(){
		var fundName = changeNull(nui.get("vCFundCode_HSFAGZB").getText());
		if(fundName==""){
			nui.alert("请先选择产品名称！");
			return;
		}
		var qdate = nui.get("L_DATE").getValue();
		if(qdate ==""){
			nui.alert("请先选择日期！");
			return;
		}
		var fileName = "资管计划底层资产信息";
		qdate = qdate.substring(0,10);
		fileName = fileName +"-"+fundName+"-"+qdate+".xls";
		nui.get("fileName").setValue(fileName);
		var frm = document.getElementById("form_ZGJHDCZCXX");
		frm.action = "com.cjhxfund.jy.excelUploadAdd.exclUploadForWtrd.flow";
		frm.submit();
		var exportId = "export_ZGJHDCZCXX";
		nui.get(exportId).disable();
		enableExportId = exportId;
		setTimeout("enableExportFun()",60000);//启用“导出”按钮
	}
	
			//启用“导出”按钮
	var enableExportId = "";//启用“导出”按钮ID
	function enableExportFun(){
		nui.get(enableExportId).enable();
		enableExportId = "";
	}
	//重置指令信息
	function resetDire_ZGJHDCZCXX(){
		var form = new nui.Form("form_ZGJHDCZCXX");
		form.reset();
	}
		//判断是否下载成功的返回路劲
	var flag = nui.get("flag").getValue();
	if(flag == "false"){
		nui.alert("导出失败 ！", "系统提示");
	}
	
</script>
</body>
</html>