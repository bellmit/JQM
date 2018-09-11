<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 创金合信
  - Date: 2016-09-03 14:45:19
  - Description:指令/建议跟踪
-->
<head>
<title>指令/建议跟踪</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body onload="updateTab()">
	<div class="nui-tabs" activeIndex="0" id="tab" style="width:100%;height:100%;">
		<div title="债券买卖" url="<%= request.getContextPath() %>/sm/comm/instruct/query/tansaction/transactionInstruct.jsp"></div>
		<!-- 
		<div title="债券买卖" url="<%= request.getContextPath() %>/ProductProcess/JY_ZQMM/CFJYProductProcessList__queryConfirm_ZQMM.jsp"></div>
		 -->
		<div title="正逆回购" url="<%= request.getContextPath() %>/sm/comm/instruct/query/repurchase/todaysInstruct.jsp"></div>
		<div title="一级新债" url="<%= request.getContextPath() %>/fm/instr/firstGradeDebt/frame_apply.jsp"></div>
		<div title="场外基金" url="<%= request.getContextPath() %>/ProductProcess/JY_JJSS/CFJYProductProcessList__queryConfirm_JJSS.jsp"></div>
		<!-- 
		<div title="同业存取" url="<%= request.getContextPath() %>/ProductProcess/JY_TYCQ/CFJYProductProcessList__queryConfirm_TYCQ.jsp"></div>
		<div title="追加提取" url="<%= request.getContextPath() %>/ProductProcess/JY_ZJZT/CFJYProductProcessList__queryConfirm_ZJZT.jsp"></div>
		 -->
		<div title="股票大宗" url="<%= request.getContextPath() %>/ProductProcess/JY_DZJY/CFJYProductProcessList__queryConfirm_DZJY.jsp"></div>
		<div title="行权管理" url="<%= request.getContextPath() %>/ProductProcess/JY_TP/CFJYProductProcessList__queryConfirm_TP.jsp"></div>
		<div title="其他交易" url="<%= request.getContextPath() %>/ProductProcess/JY_QTZL/CFJYProductProcessList__queryConfirm_QTZL.jsp"></div>
		<div title="导出" url="<%= request.getContextPath() %>/sm/comm/instruct/query/AllBizProductProcessList_export.jsp"></div>
	</div>
	<script type="text/javascript">
        //获取“今日待处理”数据，根据业务处理日期查询当天所有业务类型待处理指令/建议单与当天该业务指令/建议单总数比值
        //初始化查询条件业务日期值为当天
    	var date = new Date();
	    var dateStr = nui.formatDate(date, "yyyyMMdd");
	    function updateTab(){
	    	//今日待处理”模块数据
	        var json = nui.encode({processDate: dateStr});
	        $.ajax({
	            url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getAllBizWaitConfirmInstructCount.biz.ext",
	            type:'POST',
	            data:json,
	            cache: false,
	            contentType:'text/json',
	            success:function(text){
	                var returnJson = nui.decode(text);
	                if(returnJson.exception == null){
	                	// 机器猫业务条数
	                	var result = returnJson.result;
	                	//一级债业务条数
	                	var ret = returnJson.ret;
	                	// 二级债业务条数
	                	var smRepurchaseData = returnJson.smRepurchaseCount;
	                	var smTransactionData = returnJson.smTransactionCount;     
	                	if(ret!="" && ret!=""){
	                		var tabCmp = nui.get("tab");
	                		tabCmp.updateTab(tabCmp.getTab(2), {title:"一级新债("+ret+"/"+ret+")"});
	                	}
	                	if(result!=null && result!="" && smRepurchaseData!=null && smRepurchaseData!="" && smTransactionData!=null && smTransactionData!=""){
	                		var resultArr = result.split(",");
	                		var tabCmp = nui.get("tab");
	                		// 机器猫债券买卖条数
							//var jqmCounts = new Array();
                			jqmCounts = resultArr[0].split("/");
							// 待确认数量(待确认+待复核 / 页面全部指令)
							var zqmmAllCount = parseInt(smTransactionData[0].COUNT+smTransactionData[1].COUNT) +"/"+parseInt(smTransactionData[2].COUNT)+")";
							var znhgAllCount = parseInt(smRepurchaseData[0].COUNT+smRepurchaseData[1].COUNT) +"/"+parseInt(smRepurchaseData[2].COUNT)+")";
							
                			tabCmp.updateTab(tabCmp.getTab(0), {title:"债券买卖("+zqmmAllCount});
	                		//tabCmp.updateTab(tabCmp.getTab(1), {title:"债券买卖("+resultArr[0]+")"});
	                		tabCmp.updateTab(tabCmp.getTab(1), {title:"正逆回购("+znhgAllCount});
	                		tabCmp.updateTab(tabCmp.getTab(3), {title:"场外基金("+resultArr[3]+")"});
	                		tabCmp.updateTab(tabCmp.getTab(4), {title:"股票大宗("+resultArr[6]+")"});
	                		tabCmp.updateTab(tabCmp.getTab(5), {title:"行权管理("+resultArr[7]+")"});
	                		tabCmp.updateTab(tabCmp.getTab(6), {title:"其他交易("+resultArr[8]+")"});
	                	}
	                }
	            }
	        });
	    }
	</script>
</body>
</html>