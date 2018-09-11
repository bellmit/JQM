<%@page import="com.eos.foundation.eoscommon.BusinessDictUtil"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="com.eos.foundation.common.lang.DateUtil"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/common.jsp"%>
<%
	String currentDate = DateUtil.getSysDateString("yyyyMMdd").toString();
	String userid = userObject.getUserName();
	String serverName = request.getServerName();
	String host = BusinessDictUtil.getDictName("CJ_JY_IDATA_PARAM","host");
	if(serverName.startsWith("10.")){
		host = BusinessDictUtil.getDictName("CJ_JY_IDATA_PARAM","inhost");
	}
 %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<title>MOM报表</title>
	<link id="css_skin" rel="stylesheet" type="text/css" href="<%=contextPath%>/coframe/tools/skins/skin1/css/style.css"/>
</head>
<body style="margin:0px;">
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
	<table style="width:100%;">
		<tr>
			<td style="width:100%;">
				单账户：<input id="singeCombo" class="nui-combobox"  style="width:200px;" dataField="datas" showNullItem="false"
				url="com.cjhxfund.ats.mom.report.prodUserInfoManager.queryByUserId.biz.ext" textField="prodName" valueField="prodId" />
				
				填报日期：<input id="fillDate" class="nui-datepicker" style="width:150px;" format="yyyyMMdd" allowInput="false" />
					
				<a class='nui-button' plain='false' iconCls="icon-query" style="margin-right:3px" onclick="btnQuery_onClick()" > 查询 </a>
				<a class='nui-button' plain='false' iconCls="icon-del" style="margin-right:3px" onclick="btnClear_onClick()" > 清空 </a>
			</td>
		</tr>
	</table>
</div>
<div class="nui-fit">
	<iframe id="reportWind" id="reportWind" src="" height="98%" width="98%">
	</iframe>
</div>
</body>
<script type="text/javascript">
	nui.parse();
	//var seriesCombo = nui.get("seriesCombo");
	var singeCombo = nui.get("singeCombo");
	var fillDate = nui.get("fillDate");
	var userid = '<%=userid %>';
	var host = '<%=host %>';
	
	fillDate.setValue('<%=currentDate %>');
	var reportWind = document.getElementById("reportWind");
	var userid = '<%=userid %>';
	//选中第一项
	singeCombo.select(0);
	
	/* function btnSingeCombo_onChange(e) {
	    var id = seriesCombo.getValue();
	    singeCombo.setValue("");
	    var url = "com.cjhxfund.jy.momReport.reportManager.getSingeAccount.biz.ext?prodparent="+id;
	    singeCombo.setUrl(url);
	} */
	
	function btnClear_onClick(){
		//seriesCombo.setValue("");
		//seriesCombo.setText("");
		singeCombo.setValue(""); 
		singeCombo.setText("");
		fillDate.setValue('<%=currentDate %>');
	}
	
	function btnQuery_onClick(){
		//var seriesAccount = seriesCombo.getValue();
		var seriesAccount = '';
		var singeAccount = singeCombo.getValue();
		var fillDate = nui.get("fillDate").getValue();
		var url = "";
		if(singeAccount != ''){
			url = "<%=request.getContextPath()%>/ProductProcess/MOM_REPORT/singeAccount.jsp?fillDate="+fillDate+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount+"&userid="+userid;
			reportWind.src = url;
		}
		<%-- if(seriesAccount == '' && singeAccount == '')	{
			url = host+"/iData/vision/redirect.jsp?resid=I8a618ed946a0c948015746f9427901bd&fillDate="+fillDate	+"&userid="+userid+"&host="+host;
			reportWind.src = url;
		}else if(seriesAccount != '' && singeAccount == ''){
			url = "<%=contextPath%>/ProductProcess/MOM_REPORT/seriesAccount.jsp?fillDate="+fillDate+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount+"&userid="+userid;
			reportWind.src = url;
		}else if(seriesAccount != '' && singeAccount != ''){
			url = "<%=contextPath%>/ProductProcess/MOM_REPORT/singeAccount.jsp?fillDate="+fillDate+"&seriesAccount="+seriesAccount+"&singeAccount="+singeAccount+"&userid="+userid;
			reportWind.src = url;
		} --%>
	}
	btnQuery_onClick();
</script>
</html>