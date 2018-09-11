<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@include file="/common.jsp" %>
<!-- 标签 -->
<%@ taglib uri="http://eos.primeton.com/tags/html" prefix="h"%>
<%@ taglib uri="http://eos.primeton.com/tags/eos" prefix="e"%>
<%@ taglib uri="http://eos.primeton.com/tags/webcomp" prefix="w"%>
<%@ taglib uri="http://eos.primeton.com/tags/richweb" prefix="r"%>
 
<!-- JavaScript utilities -->
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/ArrayUtil.js" ></script>
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js" ></script>
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DialogUtil.js" ></script>
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DOMUtil.js" ></script>
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/MaskUtil.js" ></script>
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/NumberUtil.js" ></script>
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/PageUtil.js" ></script>
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/ProgressBarUtil.js" ></script>
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/SelectUtil.js" ></script>
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/StringUtil.js" ></script>
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/TableUtil.js" ></script>
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/ValidateUtil.js" ></script>
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/MsgUtil.js" ></script>

<!-- JavaScript custom classes -->
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/classes/Exception.js" ></script>
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/classes/ExcelExport.js" ></script>

<!-- project common JavaScripts -->
<script src="<%= request.getContextPath() %>/JQMHistory/common/common.js" ></script>

<!-- project common style -->
<link id="common-style" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/JQMHistory/common/common-style.css"/>

<script type="text/javascript">
	var userId = "<%= userId %>";
	var userName = "<%= userName %>";
	var operatorId = "<%=operatorId %>";
	
	//跨页多选选择表格获取基金产品
	function ButtonClickGetFundName(buttonEditObj, queryUserType, prodType){
		var queryUserTypeTemp = "<%=request.getParameter("queryUserType")%>";
		if(queryUserType!=null && queryUserType!=""){
			queryUserTypeTemp = queryUserType;
		}
        nui.open({
            url: "<%=request.getContextPath() %>/ProductProcess/zhxxcx/CFJY_zhxxcx_cpxx.jsp?queryUserType=" + queryUserTypeTemp+"&prodType="+prodType,
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
                    buttonEditObj.setValue(data.fundCode);
                    buttonEditObj.setText(data.fundName);
                }
            }
        });
	}
	
	//跨页多选选择表格获取基金产品
	function ButtonClickGetFundNameOne(buttonEditObj, queryUserType, prodType){
		var queryUserTypeTemp = "<%=request.getParameter("queryUserType")%>";
		if(queryUserType!=null && queryUserType!=""){
			queryUserTypeTemp = queryUserType;
		}
        nui.open({
            url: "<%=request.getContextPath() %>/ProductProcess/zhxxcx/CFJY_zhxxcx_cpxx_one.jsp?queryUserType=" + queryUserTypeTemp+"&prodType="+prodType,
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
                    buttonEditObj.setValue(data.fundCode);
                    buttonEditObj.setText(data.fundName);
                }
            }
        });
	}
	
	//跨页多选选择表格获取基金产品
	function ButtonClickGetFundNameTree(buttonEditObj, queryUserType, prodType){
		var queryUserTypeTemp = "<%=request.getParameter("queryUserType")%>";
		if(queryUserType!=null && queryUserType!=""){
			queryUserTypeTemp = queryUserType;
		}
        nui.open({
            url: "<%=request.getContextPath() %>/ProductProcess/zhxxcx/CFJY_zhxxcx_cpxx_tree.jsp?queryUserType=" + queryUserTypeTemp+"&prodType="+prodType,
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
                    buttonEditObj.setValue(data.fundCode);
                    buttonEditObj.setText(data.fundName);
                }
            }
        });
	}
	
	//清空多选下拉框值
    function onCloseClickValueEmpty(e){
    	var obj = e.sender;
	    obj.setText("");
	    obj.setValue("");
    }
    
    /** 
	* 将数值四舍五入后自动增加千分位. ----所有业务通用
	* @param cmpId 控件ID
	* @param cent 要保留的小数位(Number) 
	* @param isThousand 是否需要千分位 0:不需要,1:需要(数值类型); 
	* @return 格式的字符串,如'1,234,567.45' 
	* @type String 
	*/
	function formatNumberCommon(cmpId, cent, isThousand){
		cent = (cent==null||cent=="")&&cent!="0"?4:cent;//默认保留4位小数
		isThousand = isThousand==null||cent==""?1:isThousand;//默认需要千分位
		var oldVal = nui.get(cmpId).getValue();
		if(oldVal!=null && oldVal!=""){
			var newVal = formatNumber(oldVal,cent,isThousand);
			nui.get(cmpId).setValue(newVal);
		}
	}
	
	//将NULL转换为空字符串
	function changeNull(str){
		if(str==null || str=="null" || typeof(str) == "undefined"){
			return "";
		}
		return str;
	}
	
	//js中文转码
	var GB2312UnicodeConverter = {
        ToUnicode: function (str) {
            return escape(str).toLocaleLowerCase().replace(/%u/gi, '\\u'); 
        },
        ToGB2312: function (str) {
            return unescape(str.replace(/\\u/gi, '%u')); 
        }
    };
</script>
