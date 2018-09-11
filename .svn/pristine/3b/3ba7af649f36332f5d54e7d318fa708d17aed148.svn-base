<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>

<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-09-03 14:26:19
  - Description: 指令/建议跟踪
-->
<head>
	<title>指令/建议跟踪</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="margin: 0px;padding: 0px;overflow: hidden;width: 100%;height: 100%;" onload="reloadWaitConfirmFun(json)">
	<%-- 列表开始... --%>
	<div id="tabs_instruct_follow" tabPosition="bottom" class="nui-tabs" activeIndex="0" style="width:100%;height:100%;">
		<div title="债券买卖" url="<%= request.getContextPath() %>/sm/comm/instruct/query/tansaction/transactionInstruct.jsp"></div>
	<!-- 
		<div title="当日指令/建议" url="<%= request.getContextPath() %>/sm/comm/instruct/query/tansaction/todaysInstruct.jsp"></div>
		<div title="预置指令/建议" url="<%= request.getContextPath() %>/sm/comm/instruct/query/tansaction/presetInstruct.jsp"></div>
		<div title="历史指令/建议" url="<%= request.getContextPath() %>/sm/comm/instruct/query/tansaction/historyInstruct.jsp"></div>
		 -->
	</div>
    <%-- 列表结束... --%>

	<script type="text/javascript">
    	nui.parse();
    	var json = null;
		    	
    	function reloadWaitConfirmFun(json){
    		if(json == null){
    			// 默认查询条件（查询录单和复核条数）(vcProcessStatus1=待录单，vcProcessStatus2=已录单待复核)
    			json= {vcProcessStatus1:5, cIsValid:1, vcProcessStatus2:6, vcEntrustDirection:"3,4", webType:1, vcBizType:"1,2,3,4"};
    		}
	    	// 去后台获取条数信息
	        nui.ajax({
	            url:"com.cjhxfund.ats.sm.comm.InstructionManager.queryTransactionRecordCount.biz.ext",
	            type:'POST',
	            data: {param:json},
	            contentType:'text/json',
	            success:function(text){
	                var returnJson = nui.decode(text);
	                if(returnJson.exception == null){
	                	// 给标题添加条数显示
	                	var tabCmp = nui.get("tabs_instruct_follow");
	                	tabCmp.updateTab(tabCmp.getTab(0), {title:"当日指令/建议("+(returnJson.data[0].COUNT + returnJson.data[1].COUNT)+"/"+returnJson.data[2].COUNT+")"});
	                	parent.reloadWaitConfirmFun();
	                }else{
	                    nui.alert("数据获取失败", "系统提示");
	                }
	            }
	        });
      	}  
    </script>
</body>
</html>