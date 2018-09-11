/**
 * Nui风格的校验类
 */
function opponentValid(e){
    nui.ajax({
        data:{"vcRivalCode":e.value},
        url:"com.cjhxfund.ats.sm.comm.TraderivalManager.isTraderExist.biz.ext",
        async:false,
        success:function(resp){
            if(resp.traders.length<1){
            	e.errorText = "交易对手不存在！";
                e.isValid = false;
            }
        },
        fail:function(resp){
        	nui.alert("请重新输入交易对手。","系统提示");
        }
    });
}