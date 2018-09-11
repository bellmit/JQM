<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>

<%--
- Author(s): 童伟
- Date: 2017-01-16 10:47:44
- Description: 手工开启关闭服务公共处理页面
--%>


	<tr>
        <td class="form_label" align="left">
			【06】O32前台成交状态更新任务
        </td>
        <td colspan="1" align="center">
			<a id="start_updateIriAndFstWhenFs" class='nui-button' plain='false' iconCls="icon-ok" onclick="start_updateIriAndFstWhenFs()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        	<a id="close_updateIriAndFstWhenFs" class='nui-button' plain='false' iconCls="icon-close" onclick="close_updateIriAndFstWhenFs()">
               	 关闭
            </a>
        </td>
        <td colspan="1" align="left">
			获取O32前台成交数据、锁定券自动加锁功能定时器管理(二级债)
        </td>
	</tr>
	<tr>
        <td class="form_label" align="left">
			【07】指令/建议信息更新定时器
        </td>
        <td colspan="1" align="center">
			<a id="start_instructStatusUpdateInterval" class='nui-button' plain='false' iconCls="icon-ok" onclick="start_instructStatusUpdateInterval()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        	<a id="close_instructStatusUpdateInterval" class='nui-button' plain='false' iconCls="icon-close" onclick="close_instructStatusUpdateInterval()">
               	 关闭
            </a>
        </td>
        <td colspan="1" align="left">
			更新指令/建议信息任务
        </td>
	</tr>
	<tr>
        <td class="form_label" align="left">
			【08】更新风控审批状态任务
        </td>
        <td colspan="1" align="center">
			<a id="start_updateRiskApproveStatus" class='nui-button' plain='false' iconCls="icon-ok" onclick="start_updateRiskApproveStatus()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        	<a id="close_updateRiskApproveStatus" class='nui-button' plain='false' iconCls="icon-close" onclick="close_updateRiskApproveStatus()">
               	 关闭
            </a>
        </td>
        <td colspan="1" align="left">
			定时执行风控审批状态更新任务(二级债)
        </td>
	</tr>
	<tr>
        <td class="form_label" align="left">
			【09】过期未完指令归档任务
        </td>
        <td colspan="1" align="center">
			<a id="start_archiveProcess" class='nui-button' plain='false' iconCls="icon-ok" onclick="start_archiveProcess()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        	<!-- <a id="close_unLockBondTask" class='nui-button' plain='false' iconCls="icon-close" onclick="close_unLockBondTask()">
               	 关闭
            </a> -->
        </td>
        <td colspan="1" align="left">
			执行定时器，将交易日已过还未前台成交的指令状态置为"无效-已过期"（新二级债）
        </td>
	</tr>
	<tr>
        <td class="form_label" align="left">
			【10】系统自动解锁锁定券任务
        </td>
        <td colspan="1" align="center">
			<a id="start_unLockBondTask" class='nui-button' plain='false' iconCls="icon-ok" onclick="start_unLockBondTask()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        	<!-- <a id="close_unLockBondTask" class='nui-button' plain='false' iconCls="icon-close" onclick="close_unLockBondTask()">
               	 关闭
            </a> -->
        </td>
        <td colspan="1" align="left">
			执行定时器，检查到期结算日（扫描债券锁定表）为当天的数据，然后进行把锁定券信息全部解锁(新二级债)
        </td>
	</tr>
	<tr>
        <td class="form_label" align="left">
			【11】系统自动激活交易日为当天的投资指令/建议
        </td>
        <td colspan="1" align="center">
			<a id="start_activePresetInstructTask" class='nui-button' plain='false' iconCls="icon-ok" onclick="start_activePresetInstructTask()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        	<!-- <a id="close_unLockBondTask" class='nui-button' plain='false' iconCls="icon-close" onclick="close_unLockBondTask()">
               	 关闭
            </a> -->
        </td>
        <td colspan="1" align="left">
			执行定时器，每天早上检测停留在预置指令待确认的交易日为当天的投资指令/建议，然后激活该指令业务流程
        </td>
	</tr>
	<tr>
        <td class="form_label" align="left">
			【12】可用数量不足邮件提醒任务
        </td>
        <td colspan="1" align="center">
			<a id="start_availQtyEmailRemindTask" class='nui-button' plain='false' iconCls="icon-ok" onclick="start_availQtyEmailRemindTask()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        	<!-- <a id="close_availQtyEmailRemindTask" class='nui-button' plain='false' iconCls="icon-close" onclick="close_availQtyEmailRemindTask()">
               	 关闭
            </a> -->
        </td>
        <td colspan="1" align="left">
			执行定时器，扫描下一日为到期结算日的可用数量不足的数据，然后邮件提醒相关人员(二级债)
        </td>
	</tr>	
	<tr>
        <td class="form_label" align="left">
			【13】手动开启上清中债后台下载监听程序
        </td>
        <td colspan="1" align="center">
			<a id="OPEN_DOWNLOAD_EXCEL_LISTENER" class='nui-button' plain='false' iconCls="icon-ok" onclick="openDownLoadExcelListener()">
               	 启动
        	</a>
        </td>
         <td colspan="1" align="center">
			<a id="CLOSE_DOWNLOAD_EXCEL_LISTENER" class='nui-button' plain='false' iconCls="icon-close" onclick="closeDownLoadExcelListener()">
               	 关闭
            </a>
        </td>
        <td colspan="1" align="left">
			手动开启上清中债后台下载监听程序(二级债)
        </td>
			</tr>	
	<tr>
        <td class="form_label" align="left">
			【14】上清中债excel下载故障邮件提醒任务
        </td>
        <td colspan="1" align="center">
			<a id="start_excelDataDownLoadRemindTask" class='nui-button' plain='false' iconCls="icon-ok" onclick="start_excelDataDownLoadRemindTask()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        	<a id="close_excelDataDownLoadRemindTask" class='nui-button' plain='false' iconCls="icon-close" onclick="close_excelDataDownLoadRemindTask()">
               	 关闭
            </a>
        </td>
        <td colspan="1" align="left">
			上清中债excel下载故障邮件提醒定时器开关
        </td>
	</tr>
	
	<tr>
        <td class="form_label" align="left">
			【15】上清后台成交接口任务
        </td>
        <td colspan="1" align="center">
			<a id="start_newInterfaceForSmTaskInterval" class='nui-button' plain='false' iconCls="icon-ok" onclick="start_newInterfaceForSmTaskInterval()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        	<a id="close_newInterfaceForSmTaskInterval" class='nui-button' plain='false' iconCls="icon-close" onclick="close_newInterfaceForSmTaskInterval()">
               	 关闭
            </a>
        </td>
        <td colspan="1" align="left">
			手动开启上清接口后台交收任务(二级债)
        </td>
	</tr>
	
	<tr>
        <td class="form_label" align="left">
			【16】回购业务到期提醒任务
        </td>
        <td colspan="1" align="center">
			<a id="start_instructMatureRemindTask" class='nui-button' plain='false' iconCls="icon-ok" onclick="start_instructMatureRemindTask()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        	
        </td>
        <td colspan="1" align="left">
			执行定时器，每天早上扫描回购业务到期结算日为当天的指令/建议，然后将到期信息添加到对应投顾与交易员提醒列表
        </td>
	</tr>
	
	<tr>
        <td class="form_label" align="left">
			【16-1】产品询价头寸缺口任务
        </td>
        <td colspan="1" align="center">
			<a id="start_dailyFinanceGapInitializeTask" class='nui-button' plain='false' iconCls="icon-ok" onclick="start_dailyFinanceGapInitializeTask()">
               	 启动
            </a>
        </td>
        <td colspan="1" align="center">
        	
        </td>
        <td colspan="1" align="left">
			执行定时器，落地O32日初资金缺口信息以及相关参考数据
        </td>
	</tr>
	
<script type="text/javascript">
	
	//手动开启定时器(指令/建议信息更新定时器)
	function start_instructStatusUpdateInterval() {
		serviceTimerFun("start_instructStatusUpdateInterval", "open", "确定要开启吗？");
	}
	//手动关闭定时器(指令/建议信息更新定时器)
	function close_instructStatusUpdateInterval() {
		serviceTimerFun("close_instructStatusUpdateInterval", "close", "确定要关闭吗？");
	}
	
	//手动开启定时器(O32前台成交状态更新任务)
	function start_updateIriAndFstWhenFs() {
		serviceTimerFun("start_updateIriAndFstWhenFs", "open", "确定要开启吗？");
	}
	//手动关闭定时器(O32前台成交状态更新任务)
	function close_updateIriAndFstWhenFs() {
		serviceTimerFun("close_updateIriAndFstWhenFs", "close", "确定要关闭吗？");
	}
	
	//手动开启定时器(更新风控审批状态任务)
	function start_updateRiskApproveStatus() {
		serviceTimerFun("start_updateRiskApproveStatus", "open", "确定要开启吗？");
	}
	//手动关闭定时器(更新风控审批状态任务)
	function close_updateRiskApproveStatus() {
		serviceTimerFun("close_updateRiskApproveStatus", "close", "确定要关闭吗？");
	}
	//手动开启定时器(系统日初自动过期逾期未完成指令)
	function start_archiveProcess() {
		serviceTimerFun("start_archiveProcess", "open", "确定要开启吗？");
	}
	//手动开启定时器(系统自动解锁锁定券)
	function start_unLockBondTask() {
		serviceTimerFun("start_unLockBondTask", "open", "确定要开启吗？");
	}
	
	function start_newInterfaceForSmTaskInterval(){
		serviceTimerFun("start_newInterfaceForSmTaskInterval", "open", "确定要开启吗？");
	}
	
	function close_newInterfaceForSmTaskInterval(){
		serviceTimerFun("close_newInterfaceForSmTaskInterval", "close", "确定要关闭吗？");
	}
	
	//手动开启定时器(系统自动解锁锁定券)
	function start_activePresetInstructTask() {
		serviceTimerFun("start_activePresetInstructTask", "open", "确定要开启吗？");
	}
	
	//产品询价头寸缺口任务
	function start_dailyFinanceGapInitializeTask(){
		serviceTimerFun("start_dailyFinanceGapInitializeTask", "open", "确定要开启吗？");
	}
	
	
	//手动关闭定时器(系统自动解锁锁定券)
	function close_unLockBondTask() {
		serviceTimerFun("close_unLockBondTask", "close", "确定要关闭吗？");
	}
	
	//手动开启定时器(可用数量不足邮件提醒)
	function start_availQtyEmailRemindTask() {
		serviceTimerFun("start_availQtyEmailRemindTask", "open", "确定要开启吗？");
	}
	//手动关闭定时器(可用数量不足邮件提醒)
	function close_availQtyEmailRemindTask() {
		serviceTimerFun("close_availQtyEmailRemindTask", "close", "确定要关闭吗？");
	}
	
	//手动开启上清中债后台excel下载监听
	function openDownLoadExcelListener(){
		serviceTimerFun("OPEN_DOWNLOAD_EXCEL_LISTENER", "open", "确定要【开启】上清中债后台excel下载监听吗？");
	}
	//手动关闭上清中债后台excel下载监听
	function closeDownLoadExcelListener(){
		serviceTimerFun("CLOSE_DOWNLOAD_EXCEL_LISTENER", "close", "确定要【关闭】上清中债后台excel下载监听吗？");
	}
	
	//手动开启定时器(上清中债excel下载故障邮件提醒)
	function start_excelDataDownLoadRemindTask() {
		serviceTimerFun("start_excelDataDownLoadRemindTask", "open", "确定要开启吗？");
	}
	//手动关闭定时器(上清中债excel下载故障邮件提醒)
	function close_excelDataDownLoadRemindTask() {
		serviceTimerFun("close_excelDataDownLoadRemindTask", "close", "确定要关闭吗？");
	}
	
	//手动开启定时器(回购业务到期提醒)
	function start_instructMatureRemindTask() {
		serviceTimerFun("start_instructMatureRemindTask", "open", "确定要开启吗？");
	}
	
	//手工开启和关闭定时器
	function serviceTimerFun(timerName, operaType, promptMsg){
		nui.confirm(promptMsg,"系统提示",function(action){
			if(action=="ok"){
				disableButtonFun(timerName);//禁用按钮
				nui.get("paramKey").setValue(timerName);//给“调用方法Key”赋值
				var msgOperaType = operaType=="open"?"启动":"关闭";
				var json = nui.encode(new nui.Form("#form1").getData(false,false));
				
				$.ajax({
		            url:"com.cjhxfund.ats.sm.comm.TaskManager.manuallyRunOrCloseTimerTask.biz.ext",
		            type:'POST',
		            data:json,
		            cache: false,
		            contentType:'text/json',
		            success:function(text){
		                var returnJson = nui.decode(text);
		                if(returnJson.exception == null){
		                	//是否调用成功，true-成功；false-失败；
		                	var isSuccess = returnJson.isSuccess;
		                	var msgIsSuccess = isSuccess==true?"成功":"失败，请查看后台服务器日志定位原因！";
		                    nui.alert(msgOperaType+msgIsSuccess, "系统提示", function(action){
		                    });
		                }else{
		                    nui.alert(msgOperaType+"失败，请查看后台服务器日志定位原因！", "系统提示");
		                }
		                enableButtonFun(timerName);//启用按钮
		            }
		        });
			}
		});
	}
	
</script>
