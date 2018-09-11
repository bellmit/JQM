<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2016-07-15 10:47:44
- Description: 手工开启关闭服务公共处理页面
--%>
<head>
<title>手工开启关闭服务公共处理页面</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	
	<form id="form1" method="post">
		<%-- 调用方法Key --%>
		<input class="nui-hidden" id="paramKey" name="paramObject/paramKey" value="">
		<%-- 指令/建议状态、成交数据反馈接口查询次数，为空或格式错误时取默认15次 --%>
		<input class="nui-hidden" id="executionReportQueryTime" name="paramObject/executionReportQueryTime" value="">
		<%-- 轮询间隔时间，为空或格式错误时取默认5分钟 --%>
		<input class="nui-hidden" id="pIntervalTime" name="paramObject/pIntervalTime" value="">
		<%-- 轮询结束时间，为空或格式错误时取默认17:00 --%>
		<input class="nui-hidden" id="pEndTime" name="paramObject/pEndTime" value="">
		
		<table class="nui-form-table" style="width:100%;height:100%;table-layout:fixed;" align="left">
	        <tr style="font-size:14px;font-weight:bold;">
	            <td class="form_label" width="160px" align="center">
					服务类型
	            </td>
	            <td colspan="1" width="60px" align="center">
					服务开启
	            </td>
	            <td colspan="1" width="60px" align="center">
					服务关闭
	            </td>
	            <td colspan="1" align="center">
					备注
	            </td>
			</tr>
			<tr>
	            <td class="form_label" align="left">
					【01】Fix引擎服务
	            </td>
	            <td colspan="1" align="center">
	            	<!--
					<a id="FIX_OPEN_SERVICE" class='nui-button' plain='false' iconCls="icon-ok" onclick="open_FIX_OPEN_SERVICE()">
                       	 启动
                    </a>
                    -->
                    <a id="FIX_OPEN_SERVICE_INSTRUCTION" class='nui-button' plain='false' iconCls="icon-ok" onclick="open_FIX_OPEN_SERVICE()">
                       	 启动
                    </a>
	            </td>
	            <td colspan="1" align="center">
					<a id="FIX_CLOSE_SERVICE" class='nui-button' plain='false' iconCls="icon-close" onclick="close_FIX_CLOSE_SERVICE()">
                       	 关闭
                    </a>
	            </td>
	            <td colspan="1" align="left">
					机器猫系统对接O32系统Fix引擎服务
	            </td>
			</tr>
			<tr>
	            <td class="form_label" align="left">
					【02】执行O32存储过程
	            </td>
	            <td colspan="1" align="center">
					<a id="CALL_O32_PROCEDURE" class='nui-button' plain='false' iconCls="icon-ok" onclick="open_CALL_O32_PROCEDURE()">
                       	 启动
                    </a>
                    
	            </td>
	            <td colspan="1" align="center">
	            	<a id="CLOSE_CALL_O32_PROCEDURE" class='nui-button' plain='false' iconCls="icon-close" onclick="close_CALL_O32_PROCEDURE()">
                       	 关闭
                    </a>
	            </td>
	            <td colspan="1" align="left">
					执行O32计算T+0、T+1头寸指标值等存储过程
	            </td>
			</tr>
			<tr>
	            <td class="form_label" align="left">
					【03】执行O32存储过程-新
	            </td>
	            <td colspan="1" align="center">
					<a id="CALL_O32_PROCEDURE_NEW" class='nui-button' plain='false' iconCls="icon-ok" onclick="open_CALL_O32_PROCEDURE_NEW()">
                       	 启动
                    </a>
	            </td>
	            <td colspan="1" align="center">
	            	<a id="CLOSE_CALL_O32_PROCEDURE_NEW" class='nui-button' plain='false' iconCls="icon-close" onclick="close_CALL_O32_PROCEDURE_NEW()">
                       	 关闭
                    </a>
	            </td>
	            <td colspan="1" align="left">
					执行O32计算T+0、T+1头寸指标值等存储过程-新
	            </td>
			</tr>
			<tr>
	            <td class="form_label" align="left">
					【04】执行老机器猫指令/建议前台成交状态自动更新
	            </td>
	            <td colspan="1" align="center">
					<a id="UPDATE_JQM_REAL_DEAL_STATUS" class='nui-button' plain='false' iconCls="icon-ok" onclick="open_UPDATE_JQM_REAL_DEAL_STATUS()">
                       	 启动
                    </a>
	            </td>
	            <td colspan="1" align="center">
	            	<a id="CLOSE_UPDATE_JQM_REAL_DEAL_STATUS" class='nui-button' plain='false' iconCls="icon-close" onclick="close_UPDATE_JQM_REAL_DEAL_STATUS()">
                       	 关闭
                    </a>
	            </td>
	            <td colspan="1" align="left">
					执行老机器猫指令/建议前台成交状态自动更新
	            </td>
			</tr>
			<tr>
	            <td class="form_label" align="left">
					【05】手动开启上清中债后台下载监听程序
	            </td>
	            <td colspan="1" align="center">
					<a id="OPEN_DOWNLOAD_EXCEL_LISTENER" class='nui-button' plain='false' iconCls="icon-ok" onclick="open_DownLoadExcelListener()">
                       	 启动
                	</a>
	            </td>
	             <td colspan="1" align="center">
				
	            </td>
	            <td colspan="1" align="left">
					手动开启上清中债后台下载监听程序
	            </td>
			</tr>
			<!-- 调用二级债定时器管理页面 -->
			<jsp:include page="/sm/comm/timer/timerControl_ManualCall.jsp"></jsp:include>
			<!-- end 调用二级债定时器管理页面 -->
			
			<!-- 调用一级债级债定时器管理页面 -->
			<jsp:include page="/fm/comm/timerControl_ManualCall.jsp"></jsp:include>
			<!-- end 调用一级债级债定时器管理页面 -->
			
			<!-- 调用接口级债定时器管理页面 -->
			<jsp:include page="/cjapi/common/timerControl_ManualCall.jsp"></jsp:include>
			<!-- end 调用接口级债定时器管理页面 -->
		</table>
	</form>
</div>

<script type="text/javascript">
	nui.parse();
	
	//启用按钮
	function enableButtonFun(buttonId){
		nui.get(buttonId).enable();
	}
	//禁用按钮
	function disableButtonFun(buttonId){
		nui.get(buttonId).disable();
	}
	
	//手工开启关闭服务公共处理函数
	function serviceFun(businType, operaType, promptMsg){
		nui.confirm(promptMsg,"系统提示",function(action){
			if(action=="ok"){
				disableButtonFun(businType);//禁用按钮
				nui.get("paramKey").setValue(businType);//给“调用方法Key”赋值
				var msgOperaType = operaType=="open"?"启动":"关闭";
				var json = nui.encode(new nui.Form("#form1").getData(false,false));
				
				$.ajax({
		            url:"com.cjhxfund.jy.ProductProcess.ManualCallUtil.manualCall.biz.ext",
		            type:'POST',
		            data:json,
		            cache: false,
		            contentType:'text/json',
		            success:function(text){
		                var returnJson = nui.decode(text);
		                if(returnJson.exception == null){
		                	var isSuccess = returnJson.isSuccess;//是否调用成功，true-成功；false-失败；
		                	var msgIsSuccess = isSuccess==true?"成功":"失败，请查看后台服务器日志定位原因！";
		                    nui.alert(msgOperaType+msgIsSuccess, "系统提示", function(action){
		                    });
		                }else{
		                    nui.alert(msgOperaType+"失败，请查看后台服务器日志定位原因！", "系统提示");
		                }
		                enableButtonFun(businType);//启用按钮
		            }
		        });
			}
		});
	}
	
	
	//开启Fix服务
	function open_FIX_OPEN_SERVICE(){
		nui.get("executionReportQueryTime").setValue("15");//设置指令/建议状态、成交数据反馈接口查询次数，为空或格式错误时取默认15次
		//serviceFun("FIX_OPEN_SERVICE", "open", "确定要【启动】Fix引擎服务吗？");
		//【新】Fix指令/建议下达、状态反馈、委托反馈、成交反馈任务合并后的会话对象开启（需在恒生转换机启动之后再启动）
		serviceFun("FIX_OPEN_SERVICE_INSTRUCTION", "open", "确定要【启动】Fix引擎服务吗？");
	}
	//关闭Fix服务
	function close_FIX_CLOSE_SERVICE(){
		serviceFun("FIX_CLOSE_SERVICE", "close", "确定要【关闭】Fix引擎服务吗？");
	}
	//执行O32存储过程
	function open_CALL_O32_PROCEDURE(){
		nui.get("pIntervalTime").setValue("5");//设置轮询间隔时间，为空或格式错误时取默认5分钟
		nui.get("pEndTime").setValue("23:59");//设置轮询结束时间，为空或格式错误时取默认17:00
		serviceFun("CALL_O32_PROCEDURE", "open", "确定要执行O32存储过程吗？");
	}
	//执行O32存储过程-新
	function open_CALL_O32_PROCEDURE_NEW(){
		nui.get("pIntervalTime").setValue("3");//设置轮询间隔时间，为空或格式错误时取默认3分钟
		nui.get("pEndTime").setValue("23:59");//设置轮询结束时间，为空或格式错误时取默认17:00
		serviceFun("CALL_O32_PROCEDURE_NEW", "open", "确定要执行新的O32存储过程吗？");
	}
	//执行老机器猫指令/建议前台成交状态自动更新
	function open_UPDATE_JQM_REAL_DEAL_STATUS(){
		nui.get("pIntervalTime").setValue("3");//设置轮询间隔时间，为空或格式错误时取默认3分钟
		nui.get("pEndTime").setValue("23:59");//设置轮询结束时间，为空或格式错误时取默认17:00
		serviceFun("UPDATE_JQM_REAL_DEAL_STATUS", "open", "确定要执行老机器猫指令/建议前台成交状态自动更新吗？");
	}
	//关闭老机器猫指令/建议前台成交状态自动更新
	function close_UPDATE_JQM_REAL_DEAL_STATUS(){
		serviceFun("CLOSE_UPDATE_JQM_REAL_DEAL_STATUS", "close", "确定要【关闭】老机器猫指令/建议前台成交状态自动更新服务吗？");
	}
	//关闭执行O32存储过程-新
	function close_CALL_O32_PROCEDURE_NEW(){
		serviceFun("CLOSE_CALL_O32_PROCEDURE_NEW", "close", "确定要【关闭】执行O32存储过程-新吗？");
	}
	//关闭执行O32存储过程
	function close_CALL_O32_PROCEDURE(){
		serviceFun("CLOSE_CALL_O32_PROCEDURE", "close", "确定要【关闭】执行O32存储过程吗？");
	}
	//手动开启上清中债后台excel下载监听
	function open_DownLoadExcelListener(){
		serviceFun("OPEN_DOWNLOAD_EXCEL_LISTENER", "open", "确定要【开启】上清中债后台excel下载监听吗？");
	}
	
</script>
</body>
</html>
