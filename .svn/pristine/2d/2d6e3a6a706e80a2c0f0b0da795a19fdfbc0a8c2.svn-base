<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
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
<body onload="updateTab()">
	
	<div class="nui-tabs" id="tab" activeIndex="0" style="width:100%;height:100%;">
		<div title="回购业务" url="<%= request.getContextPath() %>/ProductProcess/JY_ZNHG/CFJYProductProcessList__queryConfirm_ZNHG.jsp"></div>
		<div title="银行间质押式回购管理" url="<%= request.getContextPath() %>/sm/comm/instruct/query/repurchase/todaysInstruct.jsp?page=1"></div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	var userId = "<%= userId %>";
		var userName = "<%= userName %>";
		var operatorId = "<%=operatorId %>";
		
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
	                	if(result!=null && result!="" && smRepurchaseData!=null && smRepurchaseData!="" ){
	                		var resultArr = result.split(",");
	                		var tabCmp = nui.get("tab");
	                		// 机器猫债券买卖条数
							//var jqmCounts = new Array();
                			jqmCounts = resultArr[0].split("/");
							// 待确认数量(待确认+待复核 / 页面全部指令)
							var znhgAllCount = parseInt(smRepurchaseData[0].COUNT+smRepurchaseData[1].COUNT) +"/"+parseInt(smRepurchaseData[2].COUNT)+")";
	                		tabCmp.updateTab(tabCmp.getTab(0), {title:"正逆回购("+resultArr[1]+")"});
	                		tabCmp.updateTab(tabCmp.getTab(1), {title:"银行间质押式回购管理("+znhgAllCount+")"});
	                		
	                	}
	                }else{
	                    nui.alert("今日待处理模块数据获取失败", "系统提示");
	                }
	            }
	        });
	    }
    </script>
</body>
</html>