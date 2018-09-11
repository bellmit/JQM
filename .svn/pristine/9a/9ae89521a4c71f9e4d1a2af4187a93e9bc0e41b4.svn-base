<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>

<%--
- Author(s): 童伟
- Date: 2017-01-16 10:47:44
- Description: 手工开启关闭服务公共处理页面
--%>


	<tr>
        <td class="form_label" align="left">
			【17】传真状态更新任务
        </td>
        <td colspan="1" align="center">
			<a id="start_updateEastFaxStatus" class='nui-button' plain='false' iconCls="icon-ok" onclick="start_updateEastFaxStatus()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        	<a id="close_updateEastFaxStatus" class='nui-button' plain='false' iconCls="icon-close" onclick="close_updateEastFaxStatus()">
               	 关闭
            </a>
        </td>
        <td colspan="1" align="left">
			传真状态更新任务(一级债)
        </td>
	</tr>
	<tr>
		<td class="form_label" align="left">
			【18】自动导出O32任务
        </td>
        <td colspan="1" align="center">
			<a id="run_updateExportO32Status" class='nui-button' plain='false' iconCls="icon-ok" onclick="run_updateExportO32Status()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        </td>
        <td colspan="1" align="left">
			执行定时器，每天在9:30-17:30时间范围内，扫描导出到O32共享目录下的excl反馈导出状态
        </td>
	</tr>
	<tr>
		<td class="form_label" align="left">
			【19】归集历史评级任务
        </td>
        <td colspan="1" align="center">
			<a id="run_synBondAppraise" class='nui-button' plain='false' iconCls="icon-ok" onclick="run_synBondAppraise()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        </td>
        <td colspan="1" align="left">
			归集债券大于当前库中最大日期的历史评级
        </td>
	</tr>
	<tr>
		<td class="form_label" align="left">
			【20】归集产品信息任务
        </td>
        <td colspan="1" align="center">
			<a id="run_synProductInfo" class='nui-button' plain='false' iconCls="icon-ok" onclick="run_synProductInfo()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        </td>
        <td colspan="1" align="left">
			从O32归集全量的产品信息
        </td>
	</tr>
	<tr>
		<td class="form_label" align="left">
			【21】归集账户信息任务
        </td>
        <td colspan="1" align="center">
			<a id="run_synAccountInfo" class='nui-button' plain='false' iconCls="icon-ok" onclick="run_synAccountInfo()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        </td>
        <td colspan="1" align="left">
			从数据中心归集账户信息
        </td>
	</tr>
	<tr>
		<td class="form_label" align="left">
			【22】归集新债信息任务
        </td>
        <td colspan="1" align="center">
			<a id="run_synStockIssueInfo" class='nui-button' plain='false' iconCls="icon-ok" onclick="run_synStockIssueInfo()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        </td>
        <td colspan="1" align="left">
			从O32和wind归集新债信息，并自动去重任务
        </td>
	</tr>

<script type="text/javascript">
	
	//手动开启定时器(传真状态更新任务)
	function start_updateEastFaxStatus() {
		serviceTimerFun_FM("start_updateEastFaxStatus", "open", "确定要开启吗？");
	}
	//手动关闭定时器(传真状态更新任务)
	function close_updateEastFaxStatus() {
		serviceTimerFun_FM("close_updateEastFaxStatus", "close", "确定要关闭吗？");
	}
	//手动开启定时器(导出到O32状态更新)
	function run_updateExportO32Status() {
		serviceTimerFun_FM("run_updateExportO32Status", "open", "确定要开启吗？");
	}
	//手动开启定时器(归集历史评级)
	function run_synBondAppraise() {
		serviceTimerFun_FM("run_synBondAppraise", "open", "确定要开启吗？");
	}
	//手动开启定时器(归集产品信息)
	function run_synProductInfo() {
		serviceTimerFun_FM("run_synProductInfo", "open", "确定要开启吗？");
	}
	//手动开启定时器(归集账户信息)
	function run_synAccountInfo() {
		serviceTimerFun_FM("run_synAccountInfo", "open", "确定要开启吗？");
	}
	//手动开启定时器(归集新债信息)
	function run_synStockIssueInfo() {
		serviceTimerFun_FM("run_synStockIssueInfo", "open", "确定要开启吗？");
	}
	
	//手工开启关闭服务公共处理函数
	function serviceTimerFun_FM(businType, operaType, promptMsg){
		nui.confirm(promptMsg,"系统提示",function(action){
			if(action=="ok"){
				disableButtonFun(businType);//禁用按钮
				nui.get("paramKey").setValue(businType);//给“调用方法Key”赋值
				var msgOperaType = operaType=="open"?"启动":"关闭";
				var json = nui.encode(new nui.Form("#form1").getData(false,false));
				
				$.ajax({
		            url:"com.cjhxfund.ats.fm.comm.common.manuallyRunOrCloseTimerTask.biz.ext",
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
		                enableButtonFun(businType);//启用按钮
		            }
		        });
			}
		});
	}
	
</script>
