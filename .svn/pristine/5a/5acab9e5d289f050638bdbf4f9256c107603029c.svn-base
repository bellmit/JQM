<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp"%>
<!-- 
  - Author(s): 罗倔怀
  - Date: 2017-08-09 14:15:11
  - Description:
-->
<head>
<title>回购下单</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

</head>
<body style="width: 913px; height: 520px;">
	<div id="hgTab" class="nui-tabs" plain="true" style="width: 100%; height: 100%; overflow: hidden;">
		<div title="银行间质押式回购"
			url="<%=request.getContextPath()%>/repurchase/investNew/collateraliseRepo.jsp"
			style="overflow: hidden;"></div>
		<div title="银行间买断式回购"
			url="<%=request.getContextPath()%>/repurchase/investNew/buyoutRepo.jsp"></div>
		<div title="交易所回购"
			url="<%=request.getContextPath()%>/repurchase/investNew/CFJYProductProcessForm_ZNHG.jsp"></div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	function closeWindow(){
    		window.CloseOwnerWindow();
    	}
    	
    	//复制新增初始化页面及数据
    	function initWin(tabIndex,data){
    	    var hgTab=nui.get("hgTab");
    	    if(data!=null){
    	        //data不为空，则视为复制增加,隐藏其它无用TAB
    	        //隐藏其它tab
	    	    for(var loop=2;loop>=0;loop--){
	    	        if(loop!==tabIndex){
	    	            var tab = hgTab.getTab(loop);
			            if (tab) {
			                hgTab.updateTab(tab, { visible: false });
			            }
	    	        }
	    	    }
    	    }
    	    hgTab.activeTab(tabIndex);
    	    var activeTab=hgTab.getActiveTab();
    	    
    	    activeTab.onload = function (e) {        
	                         var tabs = e.sender;
	                         var iframe = tabs.getTabIFrameEl(e.tab);
	                         if(data!=null){
	                             iframe.contentWindow.SetData(data);
	                         }
	                     };
    	   
    	}
    </script>
</body>
</html>