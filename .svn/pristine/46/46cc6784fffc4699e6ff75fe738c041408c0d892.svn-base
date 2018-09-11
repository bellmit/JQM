<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.eos.foundation.data.DataObjectUtil"%>
<%@page import="com.eos.engine.component.ILogicComponent"%>
<%@page import="com.primeton.ext.engine.component.LogicComponentFactory"%>


<%
	DataObject roleParam = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
	roleParam.setString("roleCode", "CJHX_JJJLTZJL");
	Object[] params = new Object[1];
	params[0] = roleParam;
	String componentName = "com.cjhxfund.commonUtil.userOperatorManager";
	String operationName = "isUserBelongToRole";
	try {
		ILogicComponent logicComponent = LogicComponentFactory
			.create(componentName);
		Object[] result = logicComponent.invoke(operationName, params);
		if(result.length>0){
			System.out.println(result[0]);
			System.out.println(request.getContextPath());
			if(!(Boolean)result[0]){
				response.sendRedirect(request.getContextPath()+"/ProductProcess/JY_ZNHG/CFJYProductProcessList_ZNHG.jsp");
			}
		}
	}catch (Throwable e) {
		e.printStackTrace();
	}
 %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-07-26 13:23:00
  - Description:
-->
<head>
	<title>正逆回购投资建议/指令导航页</title>
	    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	</head>
	<script  type="text/javascript">  
	 	//window.location.replace("<%= request.getContextPath() %>/ProductProcess/JY_ZNHG/CFJYProductProcessList_ZNHG.jsp");
	</script> 
<body>
	
	<div class="nui-tabs" activeIndex="0" style="width:100%;height:100%;">
		<div title="回购业务" url="<%= request.getContextPath() %>/ProductProcess/JY_ZNHG/CFJYProductProcessList_ZNHG.jsp"></div>
		<div title="银行间质押式回购" url="<%= request.getContextPath() %>/repurchase/invest/collateralised_repo/tBondTrade.jsp"></div>
		<div title="银行间质押式回购管理" url="<%= request.getContextPath() %>/sm/comm/instruct/repurchase_instruct/todaysInstruct.jsp"></div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>