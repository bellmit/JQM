<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-11-07 10:04:44
  - Description:显示指定持仓的质押明细
-->
<head>
<title>质押明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	<div id="datagrid_mortgage_detail" class="nui-datagrid" style="width:100%;height:100%;"
		 url="com.cjhxfund.ats.sm.repurchase.MortgageInfoManager.getMortagageByCombi.biz.ext" 
		 dataField="thgmortagageList"
		 showPager="false" idField="id" allowResize="true">
		<div property="columns">
			<div field="vcFundName" width="100" allowSort="true">产品名称</div>
			<div field="vcCombiName" width="120" headerAlign="center" allowSort="true">组合名称</div>
			<div field="" width="120" headerAlign="center" allowSort="true" >债券代码</div>
			<div field="" width="100" align="center" headerAlign="center">债券名称</div>			
			<div field="" width="100" allowSort="true">质押数量</div>
			<div field="" width="100" allowSort="true">质押比率</div>
			<div field="" width="100" allowSort="true">质押券面金额（万元）</div>	
			<div field="" width="100" allowSort="true">质押日期</div>
			<div field="" width="100" allowSort="true">质押到期日期</div>		
			<div field="" width="100" allowSort="true">交易对手</div>
			<div field="" width="100" allowSort="true">托管机构</div>
		</div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var mortgage_detail_grid = nui.get("datagrid_mortgage_detail");
    	
    	function setData(data){
    		var json = {thgmortagageParam:data};
    		mortgage_detail_grid.load(json);
    	}
    </script>
</body>
</html>