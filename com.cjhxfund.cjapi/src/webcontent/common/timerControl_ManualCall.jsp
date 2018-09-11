<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>

<%--
- Author(s): 杨敏
- Date: 2017-01-16 10:47:44
- Description: 手工开启关闭服务公共处理页面（接口）
--%>


	<tr>
        <td class="form_label" align="left">
			【23】招行成交反馈定时器
        </td>
        <td colspan="1" align="center">
			<a id="start_strikeFeedback" class='nui-button' plain='false' iconCls="icon-ok" onclick="startstrikeFeedback()">
               	 启动
            </a>
        </td>
         <td colspan="1" align="center">
        	<a id="close_strikeFeedback" class='nui-button' plain='false' iconCls="icon-close" onclick="closestrikeFeedback()">
               	 关闭
            </a>
        </td>
        <td colspan="1" align="left">
			<div id="status_strikeFeedback">招行成交反馈定时器</div>
        </td>
	</tr>
	

<script type="text/javascript">
	
	//手动开启定时器(传真状态更新任务)
	function startstrikeFeedback() {
		serviceTimerFun_API("start_strikeFeedback", "open", "确定要开启吗？");
	}
	//手动关闭定时器(传真状态更新任务)
	function closestrikeFeedback() {
		serviceTimerFun_API("close_strikeFeedback", "close", "确定要关闭吗？");
	}
	
	$(function (){
				nui.get("paramKey").setValue("status_strikeFeedback");//给“调用方法Key”赋值
				var json = nui.encode(new nui.Form("#form1").getData(false,false));
				
				$.ajax({
		            url:"com.cjhxfund.cjapi.common.ParamCheck.manuallyRunOrCloseTimerTask.biz.ext",
		            type:'POST',
		            data:json,
		            cache: false,
		            contentType:'text/json',
		            success:function(text){
		                var returnJson = nui.decode(text);
		                if(returnJson.exception == null){
		                	var isSuccess = returnJson.isSuccess;//是否调用成功，true-成功；false-失败；
		                	if(isSuccess==true){
		                		disableButtonFun("start_strikeFeedback");//禁用按钮
		                		enableButtonFun("close_strikeFeedback");//启用按钮
		                		$("#status_strikeFeedback").html("招行成交反馈定时器;<span style='color:red'>成交反馈定时器已经启动了！</span>");	
		                	}else{
		                		disableButtonFun("close_strikeFeedback");//禁用按钮
		                		enableButtonFun("start_strikeFeedback");//启用按钮
		                		$("#status_strikeFeedback").html("招行成交反馈定时器;<span style='color:red'>成交反馈定时器异常，请手工启动！</span>");	
		                	}
		                }else{
		                	$("#status_strikeFeedback").html("招行成交反馈定时器;<span style='color:red'>获取成交反馈状态状态异常</span>");	
		                	enableButtonFun("close_strikeFeedback");//启用按钮
		                	enableButtonFun("start_strikeFeedback");//启用按钮
		                }
		            }
		         });
	});
	//手工开启关闭服务公共处理函数
	function serviceTimerFun_API(businType, operaType, promptMsg){
		nui.confirm(promptMsg,"系统提示",function(action){
			if(action=="ok"){
				disableButtonFun(businType);//禁用按钮
				
				nui.get("paramKey").setValue(businType);//给“调用方法Key”赋值
				var msgOperaType = operaType=="open"?"启动":"关闭";
				var json = nui.encode(new nui.Form("#form1").getData(false,false));
				
				$.ajax({
		            url:"com.cjhxfund.cjapi.common.ParamCheck.manuallyRunOrCloseTimerTask.biz.ext",
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
		                 /* else{
		                  	 if(isSuccess == false){
		                  	 	 nui.alert(msgOperaType+"失败，请查看后台服务器日志定位原因！", "系统提示", function(action){});
		                  	 }else{
		                  	 	 nui.alert(msgOperaType+"成功", "系统提示", function(action){});
		                  	 }
		                 }   */
		                }else{
		                    nui.alert(msgOperaType+"失败，请查看后台服务器日志定位原因！", "系统提示");
		                    
		                }
		               
		            }
		        });
			}
		});
	}
	
</script>
