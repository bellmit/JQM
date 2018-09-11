<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<%
	String contextPath=request.getContextPath();
%>
<!-- 
  - Author(s): zengjing
  - Date: 2017-07-28 14:34:56
  - Description:
-->
<head>
<!-- nui入口  含nui样式 -->
<script type="text/javascript" src="<%=contextPath %>/common/nui/nui.js" ></script>
<!-- 流程图相关js -->
<script type="text/javascript" src="<%=contextPath %>/bpsExpend/processComm/js/graph/selectResource.js" ></script>
<script type="text/javascript" src="<%=contextPath %>/bpsExpend/processComm/js/graph/showProcStartAndWorkItemForm.js" ></script>
<script type="text/javascript" src="<%=contextPath %>/bpsExpend/processComm/js/graph/fetchMessageList.js" ></script>
<script type="text/javascript" src="<%=contextPath %>/bpsExpend/processComm/js/graph/appointActivityOrStepParticipant.js" ></script>
<script type="text/javascript" src="<%=contextPath %>/bpsExpend/processComm/js/graph/graph4BPS.js" ></script>
<script type="text/javascript" src="<%=contextPath %>/bpsExpend/processComm/js/graph/processGraph.js" ></script>
<script type="text/javascript" src="<%=contextPath %>/bpsExpend/processComm/js/graph/bpsPager.js" ></script>
<script type="text/javascript" src="<%=contextPath %>/bpsExpend/processComm/js/graph/nui-ext.js" ></script>
<script type="text/javascript" src="<%=contextPath %>/bpsExpend/processComm/js/graph/common.js" ></script>

<title>页面跳转</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="width: 99%;height:99%;overflow:hidden">
	<div id="processgraph" class="nui-bps-processgraph" showParticipants="true"></div> 
</body>
<script type="text/javascript">
	nui.parse();
	//流程图
	inintGraph();
	
	/**
	* 初始化流程图，
	* 先判断流程实例ID是否存在，优先级最高
	* 再判断流程定义ID是否存在，只能显示流程图
	* 最后判断流程定义名称是否存在 只能显示流程图
	*/
	function inintGraph(){	
		var processInstID = '<b:write property="processInstID"/>';
		var procDefID = '<b:write property="procDefID"/>';
		var procDefName = '<b:write property="procDefName"/>';
		
		var processGraphObj = nui.get("processgraph");
		if(processInstID!=null&&processInstID!=""){
			processGraphObj.setProcInstID(processInstID);
		}else if(procDefID!=null&&procDefID!=""){
			processGraphObj.setProcDefID(procDefID);
		}else if(procDefName!=null&&procDefName!=""){
			processGraphObj.setProcDefName(procDefName);	
		}
		processGraphObj.load();	
	}

</script>	 
</html>
