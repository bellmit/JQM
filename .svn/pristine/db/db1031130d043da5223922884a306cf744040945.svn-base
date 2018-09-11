/**获取下一交易日**/
var getTradeDate = function(num){
	var calcDate = "yyyyMMdd";
	var dateType = "00";
    nui.ajax({
        data:{'param':{calcDate:calcDate,dateType:dateType,num:num}},
        url:"com.cjhxfund.commonUtil.common.getTradeDate.biz.ext",
        async:false,
        success:function(resp){
            return resp.tradeDate;
        },
        fail:function(resp){
        	nui.alert("系统出错","系统提示");
        }
    });
};

