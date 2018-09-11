/**
 * 
 */
var disableOpra = function(data){
	var length = data.length;
    var lSerialNoStr = "'";
    for (var i = 0; i < length; i++) {
        lSerialNoStr += data[i].lSerialNo + "','";
    }
    lSerialNoStr = lSerialNoStr.slice(0, lSerialNoStr.lastIndexOf(",'"));
    nui.ajax({
        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.querylSerialNoes.biz.ext",
        type: 'POST',
        data: {lSerialNoes: lSerialNoStr},
        cache: false,
        contentType: 'text/json',
        success: function (e) {
            var lSerialNoArray = e.lSerialNoArray;
            var size = lSerialNoArray ? lSerialNoArray.length : 0;
            for (var i = 0; i < size; i++) {
                for (var j = 0; j < length; j++) {
                    if (data[j].lSerialNo === lSerialNoArray[i].lSerialNo) {
                        var row = thgregisterGrid.getRow(j);
                        row["disableOpra"] = 1;
                        thgregisterGrid.updateRow(row);
                    }
                }
            }
        }
    });
}
var fundCode = nui.get("fundCode");
var vcCombiName = nui.get("vcCombiName");
//查询条件产品、组合联动方法
var selectFund = function (e) {
    var id = fundCode.getValue();    
    $.ajax({
        data: {vcProductCode: id},
        url: "com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfo.biz.ext",
        success: function (resp) {
            if (resp.data) {
            	vcCombiName.load(resp.data);
            }
        },
        //有错误码之后，把后面的错误提醒补齐。
        fail: function (resp) {
            alert(resp);
        }
    });
};

//重置按钮
var reset = function () {
    (new nui.Form("searchForm")).clear();
};