<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2016-06-08 11:54:39
- Description: 综合信息查询-组合持仓（产品持仓明细）-万得BBQ行情展示查询
--%>
<head>
<title>万得BBQ行情展示查询</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body>
	
	<div id="form_WindBbqHq" class="nui-form" style="padding:2px;" align="center" style="height:10%">
	 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
	 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
	 	<%-- 查询类型 --%>
	 	<input class="nui-hidden" name="paramObject/queryType" value="WindBbqHq">
	 	<%-- 证券内码 --%>
	 	<input id="vCInterCode" class="nui-hidden" name="paramObject/vCInterCode" value="">
	</div>
	
	<%-- 自动化头寸明细表查询列表开始... --%>
	<div class="nui-fit">
		<div 
			id="datagrid_WindBbqHq"
			dataField="resultObjectList"
			class="nui-datagrid"
			style="width:100%;height:100%;"
			url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryZHXX.biz.ext"
			pageSize="50"
			showPageInfo="true"
			allowSortColumn="true"
			sortMode="client"
			enableHotTrack="true"
			sizeList="[10,20,50,100]"
			>
		
			<div property="columns">
				<div type="indexcolumn"></div>
				<div field="RT_YIELD" headerAlign="center" allowSort="true" align="right" width="70px">
				成交价
				</div>
				<div field="RT_ASKYIELD" headerAlign="center" allowSort="true" align="right" width="70px">
				卖出收益价
				</div>
				<div field="RT_BIDYIELD" headerAlign="center" allowSort="true" align="right" width="70px">
				买入收益价
				</div>
				<div field="RT_ASIZE" headerAlign="center" allowSort="true" align="right" width="90px">
				卖量
				</div>
				<div field="RT_BSIZE" headerAlign="center" allowSort="true" align="right" width="90px">
				买量
				</div>
				<div field="YIELD_CNBD" headerAlign="center" allowSort="true" align="center" width="70px">
				中债
				</div>
				<div field="COUPONRATE" headerAlign="center" allowSort="true" align="center" width="70px">
				票息
				</div>
				<div field="MATURITYDATE" headerAlign="center" allowSort="true" align="center" width="70px">
				期限(天)
				</div>
				<div field="RT_TIME" headerAlign="center" allowSort="true" align="center" width="110px">
				时间
				</div>
			</div>
		</div>
	</div>
	<%-- 自动化头寸明细表查询列表结束!!! --%>
	
	<script type="text/javascript">
	    nui.parse();
	    var grid_WindBbqHq = nui.get("datagrid_WindBbqHq");
	    
	    //页面间传输json数据
		function setFormData(data){
		    //跨页面传递的数据对象，克隆后才可以安全使用
		    var infos = nui.clone(data);
		    var rowRecord = infos.record.rowRecord;
		    nui.get("vCInterCode").setValue(rowRecord.VC_INTER_CODE);
		    
	    	search_WindBbqHq();
		}
		
		//查询--所有业务通用
		function search_WindBbqHq() {
		    search(grid_WindBbqHq, "#form_WindBbqHq");
		}
		
	</script>
</body>
</html>
