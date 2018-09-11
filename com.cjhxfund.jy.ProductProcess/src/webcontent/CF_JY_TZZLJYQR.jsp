<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2016-04-14 09:00:39
- Description: 投资指令/建议确认
--%>
<head>
<title>投资指令/建议确认</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div class="nui-tabs" id="tab" activeIndex="0" style="width:100%;height:100%;">
	   <%-- 业务类型标签页开始... --%>
	   
	   <!-- 投资指令/建议确认 -->
       <div title="指令/建议确认" url="<%=request.getContextPath() %>/ProductProcess/CFJYProductProcessList_confirm.jsp"></div>
	   <!-- 待办 -->
       <div title="申购缴款" url="<%=request.getContextPath() %>/com.cjhxfund.jy.process.queryPersonWorkItemList.flow?jurisdiction=All" refreshOnClick="true"></div>
       <%-- <!-- 已办 -->
       <div title="流转中流程" url="<%=request.getContextPath() %>/process/peding_QueryFrom.jsp?jurisdiction=All" refreshOnClick="true"></div>      --%> 
		
	   <%-- 业务类型标签页结束!!! --%>
	</div>
</div>

<script type="text/javascript">
    //active tab
        //tabs.activeTab(tab);
        //“今日待处理”模块自动刷新功能处理
	    var autoRefreshReturnVal;//自动刷新定时器返回值（使用该值关闭之前的定时器）
	    var autoRefreshValOld;//历史自动刷新时间
	    function autoRefreshFun(){
	    	activechangedFun();//同时刷新查询列表数据
	    	var autoRefreshVal = 300;//获取最新自动刷新时间
	    	//若最新获取的自动刷新时间与历史自动刷新时间不等，则关闭之前的定时器，以新的自动刷新时间新建定时器，并将新值赋予历史自动刷新时间变量
	    	if(autoRefreshVal!=autoRefreshValOld){
	    		autoRefreshValOld = autoRefreshVal;//将新值赋予历史自动刷新时间变量
	    		clearInterval(autoRefreshReturnVal);//关闭之前的定时器
	    		if(autoRefreshValOld!="0"){
	    			autoRefreshReturnVal = setInterval("autoRefreshFun()", eval(autoRefreshValOld)*1000);//以新的自动刷新时间新建定时器
	    		}
	    	}
	    }
	    autoRefreshReturnVal = self.setInterval("autoRefreshFun()",10000);//设置自动刷新时间默认1分钟
	    
	    //tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	function activechangedFun(){
		//标签切换时同时刷新“今日待处理”，模块数据
		reloadWaitConfirmFun();
	    
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tab").getActiveTab().title;
		if(activeTabTitle.indexOf("申购缴款")!=-1){
		    //alert("111344");
			//top["win"].activechangedFun();
		  }
		}
		
		function reloadWaitConfirmFun(){
    	//到后台获取“今日待处理”模块数据
        var json = nui.encode({jurisdiction:1});
        $.ajax({
            url:"com.cjhxfund.jy.process.common.expandDictQuantity.biz.ext",
            type:'POST',
            data:json,
            cache: false,
            contentType:'text/json',
            success:function(text){
                var returnJson = nui.decode(text);
                if(returnJson.exception == null){
                	var objs = returnJson.objs;
                	if(objs!=null ){
                		
                		//给“今日待处理”模块功能赋值
                		var tabCmp = nui.get("tab");
                		tabCmp.updateTab(tabCmp.getTab(1), {title:"申购缴款("+objs[0].BONDQUANTITY+")"});
                		//tabCmp.updateTab(tabCmp.getTab(1), {title:"正逆回购("+resultArr[1]+")"});
                		//tabCmp.updateTab(tabCmp.getTab(2), {title:"申购缴款("+resultArr[2]+")"});
                		//tabCmp.updateTab(tabCmp.getTab(3), {title:"基金申赎("+resultArr[3]+")"});
                		//tabCmp.updateTab(tabCmp.getTab(4), {title:"同业存取("+resultArr[4]+")"});
                		//tabCmp.updateTab(tabCmp.getTab(5), {title:"追加提取("+resultArr[5]+")"});
                		//tabCmp.updateTab(tabCmp.getTab(6), {title:"其他指令/建议("+resultArr[6]+")"});
                	}
                }else{
                    nui.alert("未处理任务数据获取失败", "系统提示");
                }
            }
        });
      }         
</script>
</body>
</html>