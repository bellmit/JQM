/**
 * 资金头寸公用代码
 */
function ButtonClickGetFundName(e){
    selectFund(this);
}
function selectFund(buttonEditObj){
    nui.open({
        url: nui.context+"/inquiry/financeGap/productInfo.jsp",
        title: "产品列表",
        width: 450,
        height: 380,
        onload:function(){
            var iframe = this.getIFrameEl();
            var fundCodes = buttonEditObj.getValue();
            var fundNames = buttonEditObj.getText();
            var data = {
               fundCodes:fundCodes,
               fundNames:fundNames
            };
            iframe.contentWindow.SetData(data);
        },
        ondestroy: function (action) {
            if (action == "ok") {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.GetData();
                data = nui.clone(data);
                buttonEditObj.setValue(data.vcProductCode);
                buttonEditObj.setText(data.vcProductName);
                buttonEditObj.doValueChanged();
            }
        }
    });
}

//多选数据分割为可in查询的字符串
function splitString(data){
	var string = null;
	if(data != null && data != ""){
		var strs= data.split(",");
		if(strs.length>0){
			for(var i=0; i<strs.length; i++ ){ 
				if(i == 0){
					string = "'"+strs[i]+"'";
				}else{
					string += ",'"+strs[i]+"'";
				}
			} 
		}
	}
	return string;
}
//下拉框清除按钮功能
function onCloseClick(e){
	var obj = e.sender;
    obj.setText("");
    obj.setValue("");
}