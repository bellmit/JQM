<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" 
    url="com.cjhxfund.ats.ipo.busOpr.queryProductCapital.biz.ext" 
    idField="OBJECT_ID"
    dataField="ipoProductInfo"
	showPageInfo="false" 
	showPager="false"  
	allowSortColumn="false">
    <div property="columns">
        <div type="indexcolumn" headerAlign="center" align="center">序号</div>
        <div field="prodName" width="150" headerAlign="center" align="center" allowSort="true">参与组合</div>
        <div field="vcRationProductType" width="100" align="center" headerAlign="center" renderer="rendervcRationProductType">产品类型</div>
        <div field="loginname" width="80" headerAlign="center" align="center" allowSort="true"  renderer="enSuggestPrice">申报价格</div>
        <div field="assetValue" dataType="currency" width="100" headerAlign="center" allowSort="true">基金资产</br>（万元）</div>
        <div field="assetNetValue" dataType="currency" width="100" headerAlign="center" allowSort="true">基金净资产</br>（元）</div>
        <div field="marketValueSz" dataType="currency" width="120" headerAlign="center" allowSort="true">对应深交所日均市值</br>（万元）</div>
        <div field="marketValueSh" dataType="currency" width="120" headerAlign="center" allowSort="true">对应上交所日均市值</br>（万元）</div>
    </div>
</div>
<script>
	//字典类型处理
	function rendervcRationProductType(e) {
		return nui.getDictText("ATS_IPO_RATION_TYPE",e.row.vcRationProductType);
	}
</script>
