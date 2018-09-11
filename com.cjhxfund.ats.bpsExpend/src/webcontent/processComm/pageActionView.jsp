<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/bpsExpend/common/processCommon.jsp"%>
<!-- 
  - Author(s): zengjing
  - Date: 2015-12-15 14:34:56
  - Description:
-->
<head>
<title>页面跳转</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
</head>
<body>
<body style="height: 98%;overflow: hidden;" >
	<div id="mainProcessTabs" class="mini-tabs tab-lazy" style="width: 100%;height: 100%;">
				<div id="busTab" name="busTab" title="业务信息" style="width: auto;height:100%; position: relative;">
				</div>
				<!--审批意见  -->
				<!--<div id="processControlTab" name="processControlTab" title="流程信息" style="width: auto;position: relative;"
				 url="<%=request.getContextPath() %>/com.cjhxfund.fpm.bpsExpend.processView.flow?processInstID=${processInstID}&bizId=${bizId}" >
				</div>-->		
				<!--流程图  -->
				<div id="processGraphTab" name="processGraphTab" title="流程图"  style="width: auto;position: relative;"
				 url= "<%=request.getContextPath() %>/bpsExpend/processComm/processGraph.jsp?processInstID=${processInstID}">
				</div>
	</div>
</body>
</html>
<script type="text/javascript">
	nui.parse();
	var contextPath = "<%=request.getContextPath()%>";
	var mainProcessTabs = nui.get("mainProcessTabs");
	var busTab = mainProcessTabs.getTab('busTab');
	
	//获取业务表单的iframe
	function getBusTabIframe(){
		return mainProcessTabs.getTabIFrameEl(mainProcessTabs.getTab("busTab"));
	}
	
	//获取流程表单的iframe
	/*function getProcessTabIframe(){
		return mainProcessTabs.getTabIFrameEl(mainProcessTabs.getTab("processControlTab"));
	}*/
	
	
	var url = "";
	var processDefName='${processDefName}';
	
	if(processDefName=='com.cjhxfund.ats.riskMgr.riskmgrApprove'||processDefName=='com.cjhxfund.ats.riskMgr.riskmgrMistake'){   //跳转到储备页面
	  	url = contextPath + "/riskMgr/riskProcess/viewRiskPage.jsp?processInstID=${processInstID}&bizId=${bizId}&timestmp=${timestmp}&pageType=${pageType}&biztypename=${biztypename}";
	  	
	  	console.log(url);
	}
	else if(processDefName=='com.cjhxfund.ats.instruction.InterestSwap.openInterestSwap'){   
	  	url = contextPath + "/instruction/process/openProcessView.jsp?processInstID=${processInstID}&bizId=${bizId}&timestmp=${timestmp}";
	}
	else if(processDefName=='com.cjhxfund.ats.instruction.InterestSwap.chargeInterestSwap'){   
	  	url = contextPath + "/instruction/process/chargeProcessView.jsp?processInstID=${processInstID}&bizId=${bizId}&timestmp=${timestmp}";
	}
	else if(processDefName=='com.cjhxfund.ats.instruction.InterestSwap.goldInterestSwap'){   
	  	url = contextPath + "/instruction/process/goldProcessView.jsp?processInstID=${processInstID}&bizId=${bizId}&timestmp=${timestmp}";
	}

	mainProcessTabs.loadTab(url, busTab);
</script>