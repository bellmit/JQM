/**
 * 保存用户搜索条件js
 * author：罗倔怀
 */

//用户保存的搜索条件集合
var conditionMenu = new Array();

//获取页面命名
var href = "";
var getHref = function () {
    if (href !== "") {
        return href;
    }
    var hrefTemp = location.href;
    href = hrefTemp.slice(hrefTemp.lastIndexOf("ats/") + 4, hrefTemp.indexOf(".jsp"));
    return href;
};
//提前储存条件选择框对象
var searchCondCombi = {};
var getSearchCondCombi = function () {
    if (searchCondCombi.length > 0) {
        return searchCondCombi;
    }
    searchCondCombi = nui.get("searchCond");
    return searchCondCombi;
};
//保存用户搜索条件
var saveSearchCond = function (formId) {
	if(conditionMenu.length>9){
		nui.alert("最多只能保存10个搜索条件噢。");
		return false;
	}
    mini.prompt("请输入保存的搜索条件名：", "请输入",
        function (action, value) {
            if (action == "ok") {
            	//校验搜索条件名字不能大于10个字节
            	if(value && value.length>10){
            		nui.alert("搜索条件名长度不能大于10位噢！");
            		return;
            	}
                formId = nui.get("searchCond").formId;
                var data = (new nui.Form(formId)).getData();
                delete data['lTradeDateMax'];
                delete data['lTradeDateMin'];
                delete data['lResultDateMax'];
                delete data['lResultDateMin'];
                for (var key in data) {
                    var text = nui.getbyName(key).text;
                    data[key] = {"value": data[key], "text": text};
                }
                conditionMenu.push({"text": value, "value": JSON.stringify(data)});
                var searchCondStr = JSON.stringify(conditionMenu);

                nui.ajax({
                    url: "com.cjhxfund.ats.sm.comm.PersonConfManage.setPerSearchCon.biz.ext",
                    type: 'POST',
                    data: {"tAtsPersonConf": {"vcConfCode": getHref() + formId, "vcConfValue": searchCondStr}},
                    cache: false,
                    contentType: 'text/json',
                    success: function (e) {
                        if (e.rtnCode == 'success') {
                            setConditionItem(conditionMenu);
                        } else {
                            nui.alert("保存出了一点小问题哦。。。");
                        }
                    }
                });
            }
        }
    );
};

//初始化页面所有搜索条件选择框。
$(function () {
    var vcConfCode = getHref() + nui.get("searchCond").formId;
    nui.ajax({
        url: "com.cjhxfund.ats.sm.comm.PersonConfManage.getPerSearchCond.biz.ext",
        type: 'POST',
        data: {"confKey": {"vcConfCode": vcConfCode}},
        cache: false,
        contentType: 'text/json',
        success: function (e) {
            var value = e.confValue[0];
            if (value && value.vcConfValue) {
                var temp = eval("(" + value.vcConfValue + ")");
                conditionMenu = temp;
                //展示搜索条件选择项
                setConditionItem(temp);
//                if (ids instanceof Array) {
//                    $("#searchCond").after('<input type="hidden" value="' + ids[j] + '"/>');
//                } else {
//                    $("#searchCond").after('<input type="hidden" value="' + ids + '"/>');
//                }
            }else{
            	setConditionItem();
            }

        }
    });
});

//用户选择已保存的搜索条件，循环复原各个输入框。
var selectCond = function (selectCon) {
    var conData = eval("(" + selectCon + ")");
    for (var key in conData) {
        var o = nui.getbyName(key);
        if (o) {
            o.setValue(conData[key]["value"]);
            if ("undefined" !== typeof o['setText']) {
                o.setText(conData[key]["text"]);
            }
            if(o.doValueChanged){
            	o.doValueChanged();
            }
        }
    }
};
//删除用户搜索条件
var deleteCond = function (text) {
    var size = conditionMenu.length;
    //将要删除的项至空
    for (var i = 0; i < size; i++) {
        if (conditionMenu[i].text === text) {
            conditionMenu[i] = null;
            break;
        }
    }
    //剔除空项
    var conTemp = new Array();
    for (var i = 0; i < conditionMenu.length; i++) {
        if (conditionMenu[i]) {
            conTemp.push(conditionMenu[i]);
        }
    }
    conditionMenu = conTemp;
    var conStr = JSON.stringify(conTemp);
    var tAtsPersonConf = {};
    //获取键
    tAtsPersonConf.vcConfCode = getHref() + nui.get("searchCond").formId; //页面地址+表单ID
    tAtsPersonConf.vcConfValue = conStr;
    nui.ajax({
        url: "com.cjhxfund.ats.sm.comm.PersonConfManage.updPerSearch.biz.ext",
        type: 'POST',
        data: {tAtsPersonConf: tAtsPersonConf},
        cache: false,
        contentType: 'text/json',
        success: function (e) {
            if (e.rtnCode == 'success') {
                setConditionItem(conTemp);
            } else {
                nui.alert("删除出了一点小问题哦。。。");
            }
        }
    });
};

//把搜索条件数据展示到menuButton菜单项里面去
var setConditionItem = function (temp) {
    var items = new Array();
    //设置保存搜索条件按钮
    var itemSave = new mini.MenuItem();
    itemSave.set({
        iconCls: "icon-add",
        text: "保存查询条件",
        onclick: function () {
            saveSearchCond();
        }
    });
    items.push(itemSave);
    if(temp){
        //循环设置搜索条件项
        for (var i = 0; i < temp.length; i++) {
            var item = new mini.MenuItem();
            var value = temp[i].value;
            item.set({
                text: '<span style="display:block;"><span>' + temp[i].text + '</span><span style="float:right;">|&nbsp&nbsp<a href="javascript:deleteCond(\''
                + temp[i].text + '\')" style="color:red;text-decoration: none;"> 删除</a></span></span>',
                onclick: function (e) {
                    selectCond(e.sender.itemValue);
                },
                itemValue: value
            });
            items.push(item);
        }
    }
    nui.get("searchCond").menu.setItems(items);
};