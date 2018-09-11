<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" 
	    url="com.cjhxfund.ats.ipo.busOpr.queryProductMarkValue.biz.ext" 
	    idField="L_PRODUCT_NO" 
	    dataField="ipoProductInfo"
	    showPageInfo="false" 
	    showPager="false" 
	    allowSortColumn="true"
	    sortField="MARKET_VALUE_SZ,MARKET_VALUE_SH"
		sortOrder="DESC"
	    multiSelect="true"
	    onselectionChanged="selectionChanged">
    <div property="columns">
        <div type="indexcolumn" headerAlign="center" align="center">序号</div>
        <div type="checkcolumn"></div>
        <div field="prodName" width="120" headerAlign="center" align="center">产品名称
        </div>
        <div field="vcRationProductType" width="100" align="center" headerAlign="center" renderer="rendervcRationProductType">产品类型
        </div>
        <div field="marketValueSz" dataType="currency" width="140" vtype="float" align="center" headerAlign="center" allowSort="true">对应深交所的日均市值</br>(万元)            
        </div>
        <div field="marketValueSh" dataType="currency" width="140" vtype="double" align="center" headerAlign="center" allowSort="true">对应上交所的日均市值</br>(万元)               
        </div>
        <div field="seatSz" width="100" align="center" headerAlign="center">深圳席位号              
        </div>
        <div field="vcStockAccountSh" width="100" align="center" headerAlign="center">沪市股东账户                
        </div>
        <div field="vcRationProductCode" width="100"  align="center" headerAlign="center">深交所配售对象编码               
        </div> 
        <div field="vcAssociationCode" width="100" align="center" headerAlign="center">上交所协会编码               
        </div>
        <div field="aaaa" width="100" align="center" headerAlign="center">锁定期               
        </div>
        <div field="bbbb" width="100" align="center" headerAlign="center">资格到期日               
        </div>
        <div field="prodEndDate" width="100" align="center" headerAlign="center" dateFormat="yyyy-MM-dd">产品到期日
        </div>
    </div>
</div>
<script>
	//字典类型处理
	function rendervcRationProductType(e) {
		return nui.getDictText("ATS_IPO_RATION_TYPE",e.row.vcRationProductType);
	}
</script>
	