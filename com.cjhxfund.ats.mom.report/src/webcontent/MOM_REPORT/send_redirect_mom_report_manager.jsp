<%@page import="com.eos.foundation.eoscommon.BusinessDictUtil"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="com.eos.foundation.common.lang.DateUtil"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/common.jsp"%>
<% 
	String currentDate = DateUtil.getSysDateString("yyyyMMdd").toString();
	// String userid = userObject.getUserRealName();
	String userid = (String)userObject.getAttributes().get("EXTEND_USER_ID");
	if("测试-经办".equals(userid)) {
		userid = "test";
	}
	String serverName = request.getServerName();
	String host = BusinessDictUtil.getDictName("CJ_JY_IDATA_PARAM","host");
	if(serverName.startsWith("10.")){
		host = BusinessDictUtil.getDictName("CJ_JY_IDATA_PARAM","inhost");
	}
	
	// 检查是否看过免责声明
    Cookie[] cookies = null;
    cookies = request.getCookies();
    String accept = "0";
    if (cookies != null) {
    	for (Cookie cookie : cookies) {
    		if (cookie.getName().equals(userid)) {
    			accept = cookie.getValue();
    			break;
    		}
    	}
    }
 %>


<!-- 
<script type="text/javascript">
    window.show();
</script>
  -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<title>MOM报表</title>
	<link id="css_skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/tools/skins/skin1/css/style.css"/>
</head>
<body style="margin:0px;">

<div id="id-toolbar" class="nui-toolbar" style="padding:2px;border-bottom:0;display:none">
	<table style="width:100%;">
		<tr>
			<td style="width:100%;">
			 
				系列账户：<input id="seriesCombo" class="nui-combobox" style="width:150px;" textField="PROD_NAME" valueField="PROD_ID" onvaluechanged="btnSingeCombo_onChange" 
				url="com.cjhxfund.jy.momReport.reportManager.getSeriesAccount.biz.ext" dataField="datas" showNullItem="true"   nullItemText="系列汇总" emptyText="系列汇总"/>
				
				单账户：<input id="singeCombo" class="nui-combobox"  style="width:200px;" dataField="datas" showNullItem="true" textField="PROD_NAME" valueField="PROD_ID"  nullItemText="子基金汇总" emptyText="子基金汇总"/>
				
				填报日期：<input id="fillDate" class="nui-datepicker" style="width:150px;" format="yyyyMMdd" allowInput="false" />
					
				<a class='nui-button' plain='false' iconCls="icon-query" style="margin-right:3px" onclick="btnQuery_onClick()" > 查询 </a>
				<a class='nui-button' plain='false' iconCls="icon-del" style="margin-right:3px" onclick="btnClear_onClick()" > 清空 </a>
			</td>
		</tr>
	</table>
</div>
<div class="nui-fit">
	<iframe id="reportWind" id="reportWind" src="" height="100%" width="100%" style="box-sizing:border-box;">
	</iframe>
</div>


<script type="text/javascript">
	nui.parse();
	var seriesCombo = nui.get("seriesCombo");
	var singeCombo = nui.get("singeCombo");
	var fillDate = nui.get("fillDate");
	var userid = '<%=userid %>';
	var host = '<%=host %>';
	
	fillDate.setValue('<%=currentDate %>');
	var reportWind = document.getElementById("reportWind");
	var userid = '<%=userid %>';
	if (userid == '测试-经办') {
		userid = 'test';
	}
	
	
	//reportWind.src =  host+"/iData/vision/redirect.jsp?resid=I8a49602f0af779fb01589541b0af26a2&fillDate="+<%=currentDate %>	+"&userid="+userid+"&host="+host;
	
	function btnSingeCombo_onChange(e) {
	    var id = seriesCombo.getValue();
	    singeCombo.setValue("");
	    var url = "com.cjhxfund.jy.momReport.reportManager.getSingeAccount.biz.ext?prodparent="+id;
	    singeCombo.setUrl(url);
	}
	
	function btnClear_onClick(){
		seriesCombo.setValue("");
		seriesCombo.setText("");
		singeCombo.setValue(""); 
		singeCombo.setText("");
		fillDate.setValue('<%=currentDate %>');
	}
	
	function btnQuery_onClick(){
		$("#id-toolbar").show();
		var seriesAccount = seriesCombo.getValue();
		var singeAccount = singeCombo.getValue();
		var fillDate = nui.get("fillDate").getValue();
		var url = "";
		if(seriesAccount == '' && singeAccount == '')	{
			url = host+"/iData/vision/redirect.jsp?resid=I8a49602f0af779fb01589541b0af26a2&fillDate="+fillDate	+"&userid="+userid+"&host="+host;
			reportWind.src = url;
		}else if(seriesAccount != '' && singeAccount == ''){
			url = "<%=request.getContextPath()%>/report/MOM_REPORT/seriesAccount.jsp?fillDate="+fillDate+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount+"&userid="+userid;
			reportWind.src = url;
		}else if(seriesAccount != '' && singeAccount != ''){
			url = "<%=request.getContextPath()%>/report/MOM_REPORT/singeAccount.jsp?fillDate="+fillDate+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount+"&userid="+userid;
			reportWind.src = url;
		}	 
	}
	
	function setCookie(){
		var exp = new Date();
		var Days = 7;
		exp.setTime(exp.getTime() + Days*24*60*60*1000);
		document.cookie="<%=userid%>=1" + ";expires=" + exp.toGMTString();
	}
	
	
	// 弹出免责条款
	function disclaimer() {
        nui.open({
            url: "<%=request.getContextPath() %>/report/MOM_REPORT/disclaimer.jsp",
            title: "免责声明", width: 680, height: 360,
            showModal : true,
            showCloseButton:false,
            ondestroy: function (action) {
            	var iframe = this.getIFrameEl();
	            //获取选中、编辑的结果
	            var data = iframe.contentWindow.getFormData();
	            data = mini.clone(data);    // 必须。克隆数据。
	            if (data['accept'] == '1') {
	            	setCookie();
	            	btnQuery_onClick();
	            }
            } 
        });
     }
     
     // 判断是否需要提示免责声明
     var accept = "<%=accept%>";
     if (accept != '1') {
     	disclaimer();		//免责声明
     } else {
     	btnQuery_onClick();
     }

</script>
</html>