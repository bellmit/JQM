<%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): CJ-WB-DT13
  - Date: 2016-03-18 10:33:21
  - Description:
-->
<head>
<title>框架页面</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%
       //Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext); 
	   //业务ID
	   //DataObject quantitys =(DataObject)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"quantity");
	   String jurisdiction = request.getParameter("jurisdiction");
	   
     %>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;margin: 0px;padding: 0px;" onload="activechangedFun()">
   <div id="tabs" class="nui-tabs" width="100%" height="100%">
       <div title="申购缴款"  url="<%=request.getContextPath() %>/process/peding_QueryList.jsp?jurisdiction=<%=jurisdiction %>"></div>
       <div title="流转中流程" url="<%=request.getContextPath() %>/process/peding_QueryFrom.jsp?jurisdiction=<%=jurisdiction %>" refreshOnClick="true"></div>
   </div>
   
<%-- 	<script type="text/javascript">
    	nui.parse();
    	var tab;
    	var tabs = nui.get("tabs");
    </script>
    
    <%
     System.out.print(quantitys.length);
     for(int i=0;i<quantitys.length;i++){
      DataObject obj = quantitys[i];
   %> 
      <%
         if(i==0){
       %>
         <script type="text/javascript">
            tab = { title: "<%=obj.getString("dictname")+"("+obj.getString("quantity")+")" %>", url: "<%=request.getContextPath() %>/process/peding_QueryList.jsp", showCloseButton: false };
         </script>
       <%}else{ %>
         <script type="text/javascript">
            tab = { title: "<%=obj.getString("dictname")+"("+obj.getString("quantity")+")" %>", url: 'pages/page' + i + '.html', showCloseButton: true };
         </script>
       <%} %>
       <script type="text/javascript">
           tabs.addTab(tab);
       </script>
   <%
     }
    %> --%>
    <script type="text/javascript">
    	nui.parse();
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
	    autoRefreshReturnVal = self.setInterval("autoRefreshFun()",60000);//设置自动刷新时间默认1分钟 
	//tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	top["win"] = window;  
	function activechangedFun(){
		//标签切换时同时刷新“今日待处理”，模块数据
		reloadWaitConfirmFun();
	
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tabs").getActiveTab().title;
		if(activeTabTitle.indexOf("申购缴款")!=-1){
			top["win"].search();
		  }
		}
		
		function reloadWaitConfirmFun(){
    	//到后台获取“今日待处理”模块数据
        var json = nui.encode({});
        $.ajax({
            url:"com.cjhxfund.jy.process.common.expandDictQuantity.biz.ext",
            type:'POST',
            data:json,
            cache: false,
            contentType:'text/json',
            success:function(text){
                var returnJson = nui.decode(text);
                if(returnJson.exception == null){
                	var quantity = returnJson.quantity;
                	if(quantity!=null && quantity!=""){
                		
                		//给“今日待处理”模块功能赋值
                		var tabCmp = nui.get("tabs");
                		if(quantity.bondquantity != undefined){
                			tabCmp.updateTab(tabCmp.getTab(0), {title:"债券申购("+quantity.bondquantity+")"});
                		}else{
                			tabCmp.updateTab(tabCmp.getTab(0), {title:"债券申购(0)"});
                		}
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