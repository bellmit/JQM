<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): 冯君培
- Date: 2016-12-21 16:35:39
- Description: 综合信息查询-科目余额表
--%>
<head>
<title>综合信息查询-科目余额表</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
  <div class="search-condition">
	 <div class="list">
		<form id="form_HSKMYEB" method="post" >
			<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
			<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
			<%-- 查询类型 --%>
			<input class="nui-hidden" name="paramObject/queryType" value="HSKMYEB">
			<%--基金代码 --%>
			<input class="nui-hidden" name="paramObject/vCFundCode" value="<%=request.getParameter("vCFundCode")%>">
			<%--业务日期 --%>
			<input class="nui-hidden" name="paramObject/busiDateEnd" value="<%=request.getParameter("busiDateEnd") %>">
			<table id="table1" class="table" style="height:100%;table-layout:fixed;">
				<tr>
					<td class="form_label" width="10%" align="right">
					科目代码:
					</td>
					<td colspan="1" width="20%">
						<input id="vCKmdm_HSKMYEB" class="nui-textbox" name="paramObject/vCKmdm"/>
					</td>
					<td class="form_label" width="10%" align="right">
					科目名称:
					</td>
					<td colspan="1" width="20%">
						<input id="vCKmmc_HSKMYEB" class="nui-textbox"  name="paramObject/vCKmmc" />
					</td>
					<td colspan="1" width="40%" align="left">
						<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_HSKMYEB()"/>
						&nbsp;
						<input class='nui-button' plain='false' id="export_HSKMYEB" text="导出" iconCls="icon-download" onclick="export_HSKMYEB()"/>
					</td>
				</tr>
			</table>
		</form>
	  </div>
	</div>		
	<%-- 恒生估值系统估值表列表开始!!! --%> 	
	<div class="nui-fit">
		<div 
		    id="datagrid_HSKMYEB"
			dataField="resultObjectList"
			class="nui-datagrid"
			style="width:100%;height:100%;"
 			url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryZHXX.biz.ext"
			pageSize="50"
			frozenStartColumn="0"
			frozenEndColumn="2"
			showPageInfo="true"
			allowSortColumn="true"
			sortMode="client"
			enableHotTrack="true"
			allowHeaderWrap="true"
			sizeList="[10,20,50,100]"
			allowCellEdit="true"
			allowCellSelect="true"
			enterNextCell="true"
			allowMoveColumn="true"
			editNextOnEnterKey="true"
			idField="VC_KMDM" parentField="VC_KMDM" resultAsTree="false" 
			allowResize="true" expandOnLoad="true" treeColumn="taskname">

		<div property="columns">
			<div type="indexcolumn"></div>
			<div field="VC_KMDM" name="taskname" headerAlign="center" allowSort="true" align="left" width="130px">
                            科目代码
			</div>
			<div field="VC_KMMC" headerAlign="center" allowSort="true" align="left" width="150px">
                            科目名称
			</div>
			<div field="CPDM" headerAlign="center" allowSort="true" align="left" width="80px">
                            产品代码
 			</div>
			<div field="CPMC" headerAlign="center" allowSort="true" align="left" width="150px">
                            产品名称
			</div>
			<div field="L_FUNDID" headerAlign="center" allowSort="true" align="left" width="80px">
                            账套编号
			</div>
			<div field="L_DATE" headerAlign="center" allowSort="true" align="left" width="80px">
                            日期
			</div>
			<div field="NCYE" headerAlign="center" allowSort="true" align="right" width="120px">
                            年初余额
			</div>
			<div field="QCYE" headerAlign="center" allowSort="true" align="right" width="120px">
		   月初余额
			</div>
			<div field="BQJFFSE" headerAlign="center" allowSort="true" align="right" width="130px">
		本期借方发生（当日）
			</div>
            <div field="BQDFFSE" headerAlign="center" allowSort="true" align="right" width="130px">
		本期贷方发生（当日）
            </div>
            <div field="LJJFFSE" headerAlign="center" allowSort="true" align="right" width="120px">
		本年累计借方发生额
             </div>
             <div field="LJDFFSE" headerAlign="center" allowSort="true" align="right" width="120px">
		本年累计贷方发生额
             </div>
             <div field="QMYE" headerAlign="center" allowSort="true" align="right" width="120px">
		期末余额（截至当日）
             </div>
             <div field="SRCSYS" headerAlign="center" allowSort="true" align="left" width="80px">
		来源系统
             </div>
             <div field="INSERTTIME" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss" allowSort="true" align="left" width="150px">
		写入时间
             </div>
          </div>
        </div>
  	</div>
	<%-- 恒生估值系统估值表列表结束!!! --%>
	
	
<script type="text/javascript">
    nui.parse();
    var datagrid_HSKMYEB = nui.get("datagrid_HSKMYEB");
    var form = new nui.Form("#form_HSKMYEB");
	var json = form.getData(false,false);
	datagrid_HSKMYEB.load(json);//grid查询
	
	
	//表格行增加样式
	datagrid_HSKMYEB.on("drawcell", function (e) {
    	var record = e.record;
		var VC_KMDM = record.VC_KMDM;//科目代码
		//设置行样式
		if(VC_KMDM!=null && VC_KMDM!="" && VC_KMDM.length==4){
			e.rowCls = "warn_bold";
		}
	});
	
	function search_HSKMYEB(){
	    search(datagrid_HSKMYEB, "#form_HSKMYEB");
	}
	
	function export_HSKMYEB(){
	    exportSubmit("export_HSKMYEB", "form_HSKMYEB", GB2312UnicodeConverter.ToGB2312('<%=request.getParameter("vCFundName")%>'));
	}
	
</script>
</body>
</html>