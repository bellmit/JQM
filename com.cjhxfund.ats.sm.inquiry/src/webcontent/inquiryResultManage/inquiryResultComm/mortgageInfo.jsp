<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 创金合信
  - Date: 2016-09-03 10:25:07
  - Description:质押券
-->
<head>
<title>抵押券</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	<div id="datagrid_mortgage_info" dataField="mortgageInfos" 
         url="com.cjhxfund.ats.sm.inquiry.inquiryResultManage.getMortgageInfo.biz.ext"
         class="nui-datagrid" style="width:100%;height:100%;"
         allowSortColumn="false"
	     showPager="false"
	     enableHotTrack="false">
		<div property="columns">
			<div field="vcStockCode" width="120px" headerAlign="center" align="center" >债券代码</div>
			<div field="vcStockName" width="120px" headerAlign="center" align="center" >债券名称</div>
			<div field="enFaceAmount" width="100px" headerAlign="center" align="center" numberFormat="n4"><span style="color:red;">*</span>券面金额（万元）</div>
			<div name="enMortagageRatio" field="enMortagageRatio" width="80px" headerAlign="center" align="center"><span style="color:red;">*</span>质押比例（％）</div>	
			<div name="enNetPriceInit" field="enNetPriceInit" visible="false" numberFormat="n4" width="100px" headerAlign="center" align="center" ><span style="color:red;">*</span>首次净价</div>
			<div name="enFullPriceInit" field="enFullPriceInit" visible="false" numberFormat="n4" width="100px" headerAlign="center" align="center" ><span style="color:red;">*</span>首次全价</div>
			<div name="enNetPriceFinal" field="enNetPriceFinal" visible="false" numberFormat="n4" width="100px" headerAlign="center" align="center" ><span style="color:red;">*</span>到期净价</div>
			<div name="enFullPriceFinal" field="enFullPriceFinal" visible="false" numberFormat="n4" width="100px" headerAlign="center" align="center" ><span style="color:red;">*</span>到期全价</div>
			<div field="enCbValueNetValue" width="85px" headerAlign="center" align="center" numberFormat="n4">净价（T-1）</div>
			<div field="enCbValueAllValue" width="85px" headerAlign="center" align="center" numberFormat="n4">全价（T-1）</div>
            <div field="vcDepository" width="85px" headerAlign="center" align="center" renderer="depository">托管机构</div>
			<div field="vcBondAppraise" width="85px" headerAlign="center" align="center" renderer="renderBondAppraise">债项评级</div>
			<div field="vcIssueAppraise" width="85px" headerAlign="center" align="center" renderer="renderIssueAppraise">主体评级</div>
			<div field="vcBondAppraiseOrgan" width="85px" headerAlign="center" align="center" renderer="renderBondAppraiseOrgan">评级机构</div>
            <div field="lRatingForecast" width="85px" headerAlign="center" align="center" renderer="lRatingForecastRD">评级展望</div>
            <div field="vcIssueProperty" headerAlign="center" align="center" width="100px" renderer="atsFmIssueProperty">发行人性质</div>
		</div>
	</div>
	

	<script type="text/javascript">
    	nui.parse();
    	var mortgage_info = nui.get("datagrid_mortgage_info");
		var lResultId = null;
    	function detail(selectRow){
    		if(selectRow.vcBizType == "6"){//银行间买断式回购：首次净价、首期全价、到期净价、到期全价。隐藏折算比例
    			mortgage_info.hideColumn("enMortagageRatio");
    			mortgage_info.showColumn("enNetPriceInit");
    			mortgage_info.showColumn("enFullPriceInit");
    			mortgage_info.showColumn("enNetPriceFinal");
    			mortgage_info.showColumn("enFullPriceFinal");
    		}else{//质押（协议）式回购：显示折算比例，隐藏托管机构、首次净价、到期净价
    			mortgage_info.showColumn("enMortagageRatio");
    			mortgage_info.hideColumn("enNetPriceInit");
    			mortgage_info.hideColumn("enFullPriceInit");
    			mortgage_info.hideColumn("enNetPriceFinal");
    			mortgage_info.hideColumn("enFullPriceFinal");
    		} 
    		if(lResultId != selectRow.lResultId){
    			var json = {lInquiryNo:selectRow.lInquiryNo};
    			if(selectRow.lResultId != null){
    				json["lResultId"] = selectRow.lResultId;
    				json["instructResource"] = selectRow.vcInstructSource;
    			}
    			mortgage_info.load(json);
    			lInquiryId = selectRow.lInquiryId;
    			lResultId = selectRow.lResultId;
    		}
    	}
    	function clearDetail(){
    		lResultId = null;
			mortgage_info.clearRows();
		}
		
		function renderTradePlace(e){
			return nui.getDictText("tradePlace",e.row.vcExchange);
		}
		//列表中转译债券评级
		function renderBondAppraise(e){
			return nui.getDictText("creditRating",e.row.vcBondAppraise);
		}
		//列表中转译主体评级
		function renderIssueAppraise(e){
			return nui.getDictText("issuerRating",e.row.vcIssueAppraise);
		}
		//列表中转译债券评级机构
		function renderBondAppraiseOrgan(e){
			return nui.getDictText("outRatingOrgan",e.row.vcBondAppraiseOrgan);
		}
		//列表中转译托管机构
		function depository(e){
			return nui.getDictText("CF_JY_DJTGCS",e.row.vcDepository);
		}
		//评级展望
		function lRatingForecastRD(e){
			return nui.getDictText("ratingOutlook",e.row.lRatingForecast);
		}
		// 发行人性质
		function atsFmIssueProperty(e){
			return nui.getDictText("ATS_FM_ISSUE_PROPERTY",e.row.vcIssueProperty);
		}
		window.parent.detailLoaded();
    </script>
</body>
</html>