<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-12-20 13:08:24
  - Description:
-->
<head>
<title>债券信用评级</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	<div id="datagrid_rating_info" class="nui-datagrid" style="width:100%;height:100%;"
			url="com.cjhxfund.ats.sm.transaction.QuotationInfoManager.getStockCredit.biz.ext" 
			dataField="creditInfos" showPager="false"
			allowSortColumn="false"
	     	enableHotTrack="false">
		<div property="columns">
			<div field="vcAppraiseStandard" width="150px" headerAlign="center" renderer="renderAppraiseStandard">评级标准</div>
			<div field="lAppraiseDate" width="100px" headerAlign="center">发布日期</div>
			<div field="vcAppraise" width="100px" headerAlign="center">信用评级</div>
			<div field="vcAppraiseForecast" width="100px" headerAlign="center">评级展望</div>
			<div field="vcAppraiseChgDir" width="100px" headerAlign="center">变动方向</div>
			<div field="vcAppraiseOrgan" width="100px" headerAlign="center">评级机构</div>
			<div field="vcAppraiseType" width="100px" headerAlign="center">评级类型</div>
		</div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	var rating_info_grid = nui.get("datagrid_rating_info");
    	var reportCode = null;
    	var marketNo = null;
    	function detail(row){
    		//当选中的单条记录不是上一个选中的时候重新加载持仓信息
    		if(reportCode !=row.vcStockCode || marketNo != row.vcMarketNo){
    			var json = {paramBond:{vcInterCode:row.vcInterCode,vcIssuerId:row.lIssuerId}};
    			json = nui.decode(json);
    			rating_info_grid.load(json);
    			reportCode = row.vcStockCode;
    			marketNo = row.vcMarketNo;
    		}
    	}
    	
    	function clearDetail(){
    		reportCode = null;
    		marketNo = null;
    		rating_info_grid.clearRows();
    	}
    	//指令/建议状态列字典翻译
	    function renderAppraiseStandard(e){
	    	if(e.value=='0'){
	    		return '债券评级';
	    	}else if(e.value=='1'){
	    		return '主体评级';
	    	}
	    }
	    window.parent.detailLoaded();
    </script>
</body>
</html>