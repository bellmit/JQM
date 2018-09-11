
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-09-21 09:40:19
  - Description:
-->
<head>
<title>询价管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body onload="updateTab()">
	<div class="nui-tabs" activeIndex="0" id="tab" style="width:100%;height:100%;">
		<div title="正逆回购" url="<%= request.getContextPath() %>/inquiry/inquiryResultManage/inquiryResultEntering/repurchase/inquiryResultInstruct.jsp"></div>
		<div title="债券买卖" url="<%= request.getContextPath() %>/inquiry/inquiryResultManage/inquiryResultEntering/transaction/inquiryResultInstruct.jsp"></div>
	</div> 	
	<script type="text/javascript">
    	nui.parse();
    	function closeWindow(){
    		window.CloseOwnerWindow();
    	}
    	var tabs = nui.get("tab");
    	//初始化查询条件业务日期值为当天
    	var date = new Date();
	    var dateStr = nui.formatDate(date, "yyyyMMdd");
	    function updateTab(){
	    	//今日待处理”模块数据
	        var json = {processDate: dateStr,webType:2};		// webType: 1-投资经理确认页面，2-交易员页面
	        nui.ajax({
	            url:"com.cjhxfund.ats.sm.inquiry.inquiryInstruction.getInquriyInstructCount.biz.ext",
	            type:'POST',
	            data:{param:json},
	            cache: false,
	            contentType:'text/json',
	            success:function(text){
	                var returnJson = nui.decode(text).inquiryCountData;
	                if(returnJson.exception == null){
	                	// 正逆回购可操作指令条数
	                	var pendingCount_znhg = returnJson[0].COUNT1;
	                	// 正逆回购当天有效指令条数
	                	var allCount_znhg = returnJson[1].COUNT1;
	                	// 债券买卖待办条数
	                	var pendingCount_zqmm = returnJson[2].COUNT1;
	                	// 债券买卖有效指令条数
	                	var allCount_zqmm = returnJson[3].COUNT1;
                		var tabCmp = nui.get("tab");
                		tabCmp.updateTab(tabCmp.getTab(0), {title:"正逆回购("+pendingCount_znhg+"/"+allCount_znhg+")"});
                		tabCmp.updateTab(tabCmp.getTab(1), {title:"债券买卖("+pendingCount_zqmm+"/"+allCount_zqmm+")"});
	                }
	            }
	        });
	    }
    	
	    function planToInquiry(data){
	    	var id = data.vcBizType=="1"||data.vcBizType=="3"?1:0;
	    	var tab = tabs.getTab(id);
	    	tabs.activeTab(tab);
	    	var iframe = tabs.getTabIFrameEl(tab);
	    	if(typeof(iframe) != "undefined"){
	    		iframe.contentWindow.gridReload();//更新列表
			}
	    }
    </script>
</body>
</html>



