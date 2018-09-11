<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%
	String preDate = DateUtil.getCalculateTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null, -1);
%>
<%--
- Author(s): 冯君培
- Date: 2016-12-21 16:12:12
- Description: 科目余额表
--%>
<head>
<title>科目余额表</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
			<%-- 证券投资科目余额表查询条件开始... --%>
			<div class="search-condition">
				<div class="list">
					<form id="form_HSKMYEB" method="post">
						<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
						<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
						<%-- 查询类型 --%>
						<input class="nui-hidden" name="paramObject/queryType" value="HSKMYEB">
						<table id="table1" class="table" style="height:100%;table-layout:fixed;">
							<tr>
								<td class="form_label" width="5%">
									日期:
								</td>
								<td colspan="1" width="25%">
									<input id="busiDateEnd_HSKMYEB" class="nui-datepicker" name="paramObject/busiDateEnd"/>
								</td>
								<td class="form_label" width="7%">
									基金名称:
								</td>
								<td colspan="1" width="35%">
									<input id="vCFundCode_HSKMYEB" class="nui-buttonedit" width="250px" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_HSKMYEB"/>
								</td>
								<td colspan="1" width="20%">
									<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_HSKMYEB()"/>
									<input class='nui-button' plain='false' text="重置" iconCls="icon-reset" onclick="clear_HSKMYEB()"/>
								</td> 
							</tr>
						</table>
					</form>
				</div>
			</div>
			<%-- 证券投资基金科目余额表查询条件结束!!!   --%>
		
			<%-- 证券投资基金科目余额表列表开始... --%>
			<div class="nui-fit">
				<div class="nui-tabs" width="100%" id="tabs" style="height:100%;table-layout:fixed;"></div>
			</div>
			<%-- 证券投资基金科目余额表列表结束!!! --%>
</div>	

<script type="text/javascript">
	nui.parse();
	
	<%-- 恒生估值系统科目余额表开始... --%>
	//设置默认时间
	var preDate = "<%=preDate%>";
	nui.get("busiDateEnd_HSKMYEB").setValue(preDate);
	//查询
	function search_HSKMYEB(){
		var fundCodes = nui.get("vCFundCode_HSKMYEB").getValue();
		var fundNames = changeNull(nui.get("vCFundCode_HSKMYEB").getText());
		if(fundNames==""){
			nui.alert("请先选择基金名称");
			return;
		}
		var fundCodeArr = fundCodes.split(",");
		var fundNameArr = fundNames.split(",");
		var busiDateEnd = nui.get("busiDateEnd_HSKMYEB").getValue();
		var queryUserType = "<%=request.getParameter("queryUserType")%>";
		var tabs = nui.get("tabs");
		//在加载tab时首先清除掉之前的tab页面
		tabs.removeAll();
		
		//循环加载tab页
		for(var i=0; i<fundNameArr.length; i++){
			//将中文转换成Unicode格式
			var vCFundName = fundCodeArr[i] + "_" + GB2312UnicodeConverter.ToUnicode(fundNameArr[i]);
			//设置tab属性
			var tab = {title:fundCodeArr[i]+"-"+fundNameArr[i], url:"<%=request.getContextPath() %>/ProductProcess/zhxxcx/CFJY_zhxxcx_hskmyeb_detail.jsp?vCFundCode="+fundCodeArr[i]+"&busiDateEnd="+busiDateEnd+"&queryUserType="+queryUserType+"&vCFundName="+vCFundName, showCloseButton: true };
			//设置tab
			tabs.addTab(tab);
			//当i=0时模拟点击事件
 			if(i == 0){
          		tabs.activeTab(tab);
	        }
		}
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_HSKMYEB(e){
        ButtonClickGetFundName(this, null);
	}
	function clear_HSKMYEB(){
		nui.get("busiDateEnd_HSKMYEB").setValue("");
		nui.get("busiDateEnd_HSKMYEB").setText("");
		changeNull(nui.get("vCFundCode_HSKMYEB")).setValue("");
		changeNull(nui.get("vCFundCode_HSKMYEB")).setText("");
	}
	<%-- 恒生估值系统科目余额表结束!!! --%>

	
</script>
</body>
</html>