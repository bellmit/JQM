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
<title>招行风险管理信息收集表</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/locale/zh_CN.js" type="text/javascript"></script>
</head>
<body style="width:100%;height:100%;">
		   <%--查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_SJXX" method="post">
		   		<%-- 查询用户类型，url，导出文件名称 --%>
			 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
			 	<input class="nui-hidden" name="paramObject/url" value="/ProductProcess/Bank_Push/queryCollectInfo.jsp">
			 	<input class="nui-hidden" id="fileName" name="paramObject/fileName" value="">
			 	<input class="nui-hidden" id="flag" value="<b:write property="flag"/>"/>
			 	<%-- 查询类型 --%>
			 	<input class="nui-hidden" name="paramObject/queryType" value="SJXX">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                    <tr>
	                        <td style="width:60px" align="right">
								日期:
	                        </td>
	                        <td style="width:15%" align="left">
	                            <input id="L_DATE" class="nui-datepicker" width="100%" format="yyyy-MM-dd" name="paramObject/lDate" required="true" allowInput="false"/>
	                        </td>
	                    	<td style="width:80px" align="right">
								计划名称:
							</td>
							<td style="width:25%" align="left">
								<input id="vcFundCode" class="nui-combobox" url="com.cjhxfund.jy.momReport.reportManager.queryProductbyCondition.biz.ext" textField="TEXT" valueField="ID" width="100%" name="paramObject/vCFundCode"/>
							</td>
	                        <td colspan="4" >
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_SJXX()"/>&nbsp;&nbsp;
	                        	<input class='nui-button' plain='false' text="重置" iconCls="icon-cancel"  onclick="resetDire_SJXX()"/>&nbsp;&nbsp;
	                            <input id="export_SJXX" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_SJXX()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 查询条件结束!!! --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_SJXX"
                        dataField="resultObjectList"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryWTRD.biz.ext"
                        pageSize="50"
                        showPageInfo="true"
                        virtualScroll="true"
                        allowSortColumn="true"
                        allowHeaderWrap="true"
                        sortMode="client"
                        enableHotTrack="true"
                        sizeList="[20,50,100,500,1000]">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        
                        <div field="PRODUCT_FULLNAME" renderer="dateRen" headerAlign="center" allowSort="true" align="left" width="240px">
                           计划名称
                        </div>
                        <div field="JG_NAME" headerAlign="center" allowSort="true" align="left" width="100px">
                            通道名称
                        </div>
                        <div field="ZQLB" headerAlign="center" allowSort="true" align="left" width="100px">
                           产品种类
                        </div>
                        <div field="VC_ZQDM" headerAlign="center" allowSort="true" align="right" width="80px">
                           证券代码
                        </div>
                        <div field="VC_KMMC" headerAlign="center" allowSort="true"  align="left" width="120px">
                           证券简称
                        </div>
                        <div field="B_INFO_ISSUER" headerAlign="center" allowSort="true" align="left" width="150px">
                            发行人
                        </div>
                        <div field="BZ" headerAlign="center" allowSort="true" align="right" width="60px">
                            币种
                        </div>
		                <div field="EN_CB" headerAlign="center" allowSort="true" align="right" width="120px">
		                            买入成本（亿元）
		                </div>
                        <div header="规模（按市价）" headerAlign="center">
			                <div property="columns">
		                        <div field="EN_SZ" headerAlign="center" allowSort="true" align="right" width="100px">
		                          （亿元）
		                        </div>
		                    </div>
		                </div>
		                <div header="规模（按面值）" headerAlign="center">
			                <div property="columns">
		                        <div field="L_SL" headerAlign="center" allowSort="true" align="right" width="110px">
		                           （亿元）                  
		                        </div>
		                      </div>
		                </div>
		               <div header="年初净值" headerAlign="center">
			                <div property="columns">
                        <div field="NCDWJZ" headerAlign="center" allowSort="true" align="right" width="120px">
                            （整项计划净值，非针对单个产品）
                        </div>
                         </div>
		                </div>
                        <div header="报告日净值" headerAlign="center">
			                <div property="columns">
                        <div field="JJDWJZ" headerAlign="center" allowSort="true" align="right" width="120px">
                            （整项计划净值，非针对单个产品）
                        </div>
                         </div>
		                </div>
                    </div>
                </div>
            </div>

<script type="text/javascript">
    nui.parse();
    nui.get("L_DATE").setValue((new Date()));
    var grid_SJXX = nui.get("datagrid_SJXX");//产品交易流水-交易所
    var form = new nui.Form("#form_SJXX");
	var json = form.getData(false,false);
	//grid_SJXX.load(json);
	
	
	//查询
	function search_SJXX() {
		var fundName = changeNull(nui.get("vcFundCode").getText());
		if(fundName==""){
			nui.alert("请先选择产品名称！");
			return;
		}
		var qdate = nui.get("L_DATE").getValue();
		if(qdate ==""){
			nui.alert("请先选择日期！");
			return;
		}
		search(grid_SJXX, "#form_SJXX");
	}

	//导出
	function export_SJXX(){
		var fundName = changeNull(nui.get("vcFundCode").getText());
		if(fundName==""){
			nui.alert("请先选择产品名称！");
			return;
		}
		var qdate = nui.get("L_DATE").getValue();
		if(qdate ==""){
			nui.alert("请先选择日期！");
			return;
		}
		var fileName = "招行风险管理信息收集表";
		qdate = qdate.substring(0,10);
		qdate = dateFormat(qdate);
		fileName =  fundName+"-"+qdate+"-"+fileName+".xls";
		nui.get("fileName").setValue(fileName);
		var frm = document.getElementById("form_SJXX");
		frm.action = "com.cjhxfund.jy.excelUploadAdd.exclUploadForWtrd.flow";
		frm.submit();
		var exportId = "export_SJXX";
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
	function resetDire_SJXX(){
		var form = new nui.Form("form_SJXX");
		form.reset();
	}
	//判断是否下载成功的返回路劲
	var flag = nui.get("flag").getValue();
	if(flag == "false"){
		nui.alert("导出失败 ！", "系统提示");
	}
	function dateFormat(date){
		var qdate = "";
		if(date.length==10){
			qdate = date.substring(0,4)+"年"+date.substring(5,7)+"月"+date.substring(8,10)+"日";
			return qdate;
		}
		return "";
	}
	
	
</script>
</body>
</html>