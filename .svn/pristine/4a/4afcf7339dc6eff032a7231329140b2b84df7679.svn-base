<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" 
    url="com.cjhxfund.ats.ipo.busOpr.queryPurchaseValue.biz.ext" 
    idField="L_PRODUCT_NO"
    dataField="purchaseInfo"
    allowResize="false"  
	multiSelect="true" 
	allowSortColumn="true"
	sortField="MARKET_VALUE_SH,MARKET_VALUE_SZ"
	sortOrder="desc"
	showPager="false"
	onselectionChanged="selectionChanged">
    <div property="columns">
        <div type="indexcolumn" headerAlign="center" align="center">序号</div>
        <div type="checkcolumn"></div>
        <div field="prodName" width="150" headerAlign="center" align="center">参与组合</div>
        <div field="vcRationProductType" width="100" align="center" headerAlign="center" renderer="rendervcRationProductType">产品类型</div>
        <div field="enPurchasePrice" dataType="currency" width="60" headerAlign="center" align="center" >申报价格</div>
        <div field="enPurchaseNumber" width="60" headerAlign="center" align="center" >申报数量</br>（万股）</div>
        <div field="enPurchaseMoney" dataType="currency" width="60" headerAlign="center" align="center" >申购金额</br>（万元）</div>
        <div field="assetValue" dataType="currency" width="80" headerAlign="center" >基金总资产</br>（万元）</div>
        <div field="assetNetValue" dataType="currency" width="80" headerAlign="center" >基金净资产</br>（元）</div>
        <div field="enPurchaseMoneyRate" width="100" headerAlign="center" >申购金额占</br>净值比例</div>
        <div field="enDistributionRate" width="100" headerAlign="center" >预计获配占</br>净值比例</div>
        <div field="lLockTime" width="60" headerAlign="center" align="center" >锁定期</div>
        <div field="lEndTime" width="100" headerAlign="center" align="center"  dateFormat="yyyy-MM-dd">完成时间</div>
        <div field="vcComplianceState1" width="100" headerAlign="center" align="center" >关联检查</br>是否合规</div>
        <div field="vcComplianceState2" width="100" headerAlign="center" align="center" >投资比例</br>是否合规</div>
        <div field="marketValueSz" dataType="currency" width="120" headerAlign="center" >对应深交所日均市值</br>（万元）</div>
        <div field="marketValueSh" dataType="currency" width="120" headerAlign="center" >对应上交所日均市值</br>（万元）</div>
        <div field="seatSz" width="100" headerAlign="center" align="center" >深圳席位号</div>
        <div field="vcRationProductCode" width="100" headerAlign="center">深交所配售</br>对象编码</div>
        <div field="vcStockAccountSh" width="100" headerAlign="center" >沪市股东账户</div>
        <div field="vcAssociationCode" width="100" headerAlign="center">上交所协会编码</div>
        <div field="vcComplianceRemark" width="150" headerAlign="center">备注</div>
    </div>
</div>
<script>
	//字典类型处理
	function rendervcRationProductType(e) {
		return nui.getDictText("ATS_IPO_RATION_TYPE",e.row.vcRationProductType);
	}
</script>
