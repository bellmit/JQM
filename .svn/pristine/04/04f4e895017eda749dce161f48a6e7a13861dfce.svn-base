<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-09-03 10:25:07
  - Description:质押信息（银行间债券报价）
-->
<head>
	<title>质押信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	<div id="datagrid_mortgage_info" dataField="thgmortagageList" 
         url="com.cjhxfund.ats.sm.repurchase.MortgageInfoManager.queryMortagageByEmpId.biz.ext"
         class="nui-datagrid" style="width:100%;height:100%;"
         showPager="false">
		<div property="columns">
			<div field="vcFundName" width="100px" headerAlign="center">产品名称</div>
			<div field="vcCombiName" width="120px" headerAlign="center">组合名称</div>
			<div field="" width="120px" headerAlign="center">债券代码</div>
			<div field="vcStockName" width="100px" headerAlign="center">债券名称</div>				
			<div field="" width="100px" numberFormat="n0" align="right" headerAlign="center">质押数量</div>
			<div field="" width="100px" align="right" headerAlign="center">质押比率(%)</div>
			<div field="" width="120px" numberFormat="n0" align="right" headerAlign="center">质押券面金额（万元）</div>	
			<div field="" width="100px" headerAlign="center">质押日期</div>
			<div field="" width="100px" headerAlign="center">质押到期日期</div>							
			<div field="" width="100px" headerAlign="center">交易对手</div>
			<div field="" width="100px" headerAlign="center">托管机构</div>
		</div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var mortgage_info_grid = nui.get("datagrid_mortgage_info");
    	var reportCode = null;
    	var marketNo = null;
    	function detail(row){
    		//当选中的单条记录不是上一个选中的时候重新加载质押信息
    		if(reportCode !=row.vcStockCode || marketNo != row.vcMarketNo){
    			var json = {thgmortagageParam:{reportCode:row.vcStockCode,marketNo:row.vcMarketNo}};
    			json = nui.decode(json);
    			mortgage_info_grid.load(json);
    			reportCode = row.vcStockCode;
    			marketNo = row.vcMarketNo;
    		}
    	}
    	function clearDetail(){
    		reportCode = null;
    		marketNo = null;
    		mortgage_info_grid.clearRows();
    	}
    	window.parent.detailLoaded();
    </script>
</body>
</html>