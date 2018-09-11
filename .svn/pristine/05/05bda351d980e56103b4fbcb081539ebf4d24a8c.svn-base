<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/JY_ZQMM/JY_ZQMM_common.jsp" %>
<%@include file="/ProductProcess/JY_ZNHG/JY_ZNHG_common.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-05-22 19:09:46
  - Description:
-->
<head>
<title>查询指令/建议--导出</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
	<script src="<%= request.getContextPath() %>/ProductProcess/CFJYProductProcessList_queryConfirm.js" type="text/javascript"></script>
</head>
<body style="margin: 0px;padding: 0px;overflow: hidden;width: 100%;height: 100%;">
   <%-- 导出查询条件开始... --%>
   <div class="search-condition">
	   <div class="list" class="nui-form" style="padding:2px;height:10%;max-width:100%" align="left">
		   <form id="form_ZLDDC" method="post">
				<!-- 数据实体的名称 -->
                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.singleDataset.CfJyProductProcess">
                <!-- 交易员-->
                <input class="nui-hidden" name="exportType" value="0">
                <!-- 排序字段 -->
                <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="processDate">
                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="desc">
                <!-- 指令/建议查询页面=1，以前业务默认为空 -->
                <input class="nui-hidden" name="webType" value="1">
                <!-- 二级债业务指令/建议导出条件 -->
                <input class="nui-hidden" name="tradeDate_begin" id="tradeDate_begin" value="">
                <input class="nui-hidden" name="tradeDate_end" id="tradeDate_end" value="">
                <input class="nui-hidden" name="vcProductCode" id="vcProductCode" value="">
                <!-- 一级债产品代码是不需要加入 '' 号的 -->
                <input class="nui-hidden" name="fmVcProductCode" id="fmVcProductCode" value="">
                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
                	<tr>
                		<td style="width:60px;" align="right">产品名称：</td>
                        <td style="width:210px;"  align="left">
	                        <input class="nui-buttonedit" id="combProductCode" name="criteria/_expr[0]/combProductCode" onbuttonclick="ButtonClickGetFundNameCommon" width="200px" showClose="true" oncloseclick="onCloseClick"/>
                        	<input class="nui-hidden" name="criteria/_expr[0]/_op" value="in">
                        </td>
                        <td style="width:100px;" align="right">业务日期：</td>
                        <td  style="width:249px;" align="left">
                        	<input id="processDate_ZLDDC_begin" class="nui-datepicker" required="true" width="100px"/>
							 - <input id="processDate_ZLDDC_end" class="nui-datepicker" required="true" width="100px"/>
                        </td>
                        <td>
                            <input id="export_ZLDDC" class='nui-button' plain='false' text="导出Excel" iconCls="icon-download" onclick="export_ZLDDC()"/>
                        </td>
                    </tr>
				</table>
			</form>
	  </div>
   </div>
   <%-- 导出查询条件结束!!! --%>

	<script type="text/javascript">
		nui.parse();
		
	    nui.get("processDate_ZLDDC_begin").setValue(date);
	    nui.get("processDate_ZLDDC_end").setValue(date);
	    
		<%-- 导出业务 --%>
		//启用“导出”按钮
		function enableExportFun(){
			nui.get("export_ZLDDC").enable();
		}
		
		//导出
		function export_ZLDDC(){
			var processDate_ZLDDC_begin = nui.get("processDate_ZLDDC_begin").value;
	    	var processDate_ZLDDC_end = nui.get("processDate_ZLDDC_end").value;
	    	var combProductCode = nui.get("combProductCode").value;
	    	var fmVcProductCode = nui.get("combProductCode").value;
	    	if(combProductCode!= null && combProductCode!= ""){
	    		combProductCode = splitString(combProductCode);
	    	}
	    	if(processDate_ZLDDC_begin==null || processDate_ZLDDC_begin==""){
	    		nui.alert("业务起始日期不能为空","提示");
	    		nui.get("processDate_ZLDDC_begin").focus();
		        return;
	    	}
	    	if(processDate_ZLDDC_end==null || processDate_ZLDDC_end==""){
	    		nui.alert("业务截止日期不能为空","提示");
	    		nui.get("processDate_ZLDDC_end").focus();
		        return;
	    	}
	    	//仅能导出一年区间的指令/建议数据
	    	var dates = Math.abs(processDate_ZLDDC_begin.getTime()-processDate_ZLDDC_end.getTime())/(1000*60*60*24);//间隔天数
	    	if(dates>366){
	    		nui.alert("仅能导出一年区间的指令/建议数据","提示");
	    		nui.get("processDate_ZLDDC_begin").focus();
		        return;
	    	}
	    	
        	var begin = nui.formatDate(processDate_ZLDDC_begin, "yyyy-MM-dd");
			var end = nui.formatDate(processDate_ZLDDC_end, "yyyy-MM-dd");
			var msg = "";
			msg = "确定要导出 "+begin+" 到 "+end+" 的指令/建议吗？";
			
			if(processDate_ZLDDC_begin != null && processDate_ZLDDC_begin != ""){
        		processDate_ZLDDC_begin = DateUtil.toNumStr(processDate_ZLDDC_begin);
        		document.getElementById("tradeDate_begin").value = processDate_ZLDDC_begin;
        	}
        	if(processDate_ZLDDC_end != null && processDate_ZLDDC_end != ""){
        		processDate_ZLDDC_end = DateUtil.toNumStr(processDate_ZLDDC_end);
        		document.getElementById("tradeDate_end").value = processDate_ZLDDC_end;
        	}
        	document.getElementById("vcProductCode").value = combProductCode;
        	document.getElementById("fmVcProductCode").value = fmVcProductCode;
			nui.confirm(msg,"系统提示",function(action){
				if(action=="ok"){
					nui.get("export_ZLDDC").disable();//禁用“导出”按钮
					var form = document.getElementById("form_ZLDDC");
					form.action = "com.cjhxfund.jy.ProductProcess.ProductProcessExport.flow";
			        form.submit();
			        setTimeout("enableExportFun()",15000);//启用“导出”按钮
				}
			});
		}
		
		//全屏显示
		function fullScreen(){
			window.open('<%=request.getContextPath()%>/ProductProcess/AllBizProductProcessList_export.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		}
		
		//查询参数组装
 		function splitString(data){
     		var string = null;
     		if(data != null && data != ""){
     			var strs= data.split(",");
 	    		if(strs.length>0){
 	    			for(var i=0; i<strs.length; i++ ){ 
 						if(i == 0){
 							string = "'"+strs[i]+"'";
 						}else{
 							string += ",'"+strs[i]+"'";
 						}
 					} 
 	    		}
     		}
 			return string;
     	}
		
		function onCloseClick(e){
	    	var obj = e.sender;
            obj.setText("");
            obj.setValue("");
	    }
	</script>
</body>
</html>