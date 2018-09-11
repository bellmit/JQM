<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 武正新
  - Date: 2017-12-06 10:10:48
  - Description:
-->
<head>
<title>定时任务监控</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<%-- <script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script> --%>
</head>
<body style="width: 99.6%; height: 99.6%; overflow: hidden;">
	<div class="search-condition">
		<div class="list">
			<div id="form1" class="nui-form" style="margin: 0px;">
				<!-- 排序字段 -->
				<table id="table1" class="table" width="100%" style="table-layout: fixed;">
					<tr>
						<td>任务名称: <input class="nui-textbox" name="qrtz/jobName" /> &nbsp;&nbsp; <a
							class='nui-button' plain='false' onclick="search()" iconCls="icon-search">查询</a> <a
							class='nui-button' plain='false' onclick="reset()" iconCls="icon-close">重置</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;">
				    <span id="" style="margin-left:10px;">实时监控状态：</span>
					<span id="moniteStatus" style="color: red;font-weight:bold;"></span>
					&nbsp;
					<a class="nui-button" id="startBtn" iconCls="icon-ok" plain="false" onclick="startMonite()"> 启动 </a>
					&nbsp;
					<a class="nui-button" id="stopBtn" iconCls="icon-no" plain="false" onclick="stopMonite()"> 停止 </a>
					&nbsp;
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="qrtzs" class="nui-datagrid" style="width: 100%; height: 100%;"
			url="com.cjhxfund.ats.qrtz.qrtzMonite.queryQrtzTask.biz.ext" pageSize="50" showPageInfo="true"
			multiSelect="true" allowSortColumn="false">
			<div property="columns">
			    <div type="checkcolumn" width="15"></div>
				<div type="indexcolumn" headerAlign="center" width="15">序号</div>
				<div field="jobName" headerAlign="center" allowSort="true" width="80">任务名称</div>
				<div field="taskType" headerAlign="center" allowSort="true" width="50" renderer="renderTaskType">任务类型</div>
				<div field="triggerType" headerAlign="center" allowSort="true" width="20" >触发类型</div>
				<div field="targetName" headerAlign="center" allowSort="true" width="150">目标名称</div>
				<div field="targetOperation" headerAlign="center" allowSort="true" width="90">目标操作名称</div>
				<div field="targetArgs" headerAlign="center" allowSort="true" width="100" visible="false">目标操作执行参数
				</div>
				<div field="cronExpression" headerAlign="center" allowSort="true" width="60">执行时间</div>
				<div field="isStateFul" headerAlign="center" allowSort="true" width="30"
					renderer="renderIsStateFul">是否有状态任务</div>
				<div field="triggerState" headerAlign="center" allowSort="true" width="30"
					renderer="renderTriggerState">触发器状态</div>
				<div field="runningStatus" headerAlign="center" allowSort="true" width="30"
					renderer="renderRunningStatus">运行状态</div>
				<div field="" headerAlign="center" allowSort="true" width="60" renderer="renderOperate">操作</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		nui.parse();
		var grid = nui.get("datagrid1");
		search();
		getMoniteStatus();//取监控运行状态

		//查询
		function search() {
			var form = new nui.Form("#form1");
			var json = form.getData(false, false);
			grid.load(json);//grid查询
		}

		//重置查询条件
		function reset() {
			var form = new nui.Form("#form1");//将普通form转为nui的form
			form.reset();
		}

		//enter键触发查询
		function onKeyEnter(e) {
			search();
		}

        //运行状态
		function renderRunningStatus(e) {
			if (e.row.runningStatus=="未触发") {
				return "<span style='color:red;font-weight:bold;'>未触发</span>";
			} else if (e.row.runningStatus=="正常") {
				return "正常";
			}
		}

		function renderIsStateFul(e) {
			if (e.row.isStateFul == "0") {
				return "无状态";
			} else {
				return "<span style='color:green'>有状态</span>";
			}
		}

		function renderTriggerState(e) {
		    if (e.row.triggerState == "WAITING") {
				return "<span style='color:green;'>正常</span>";
			}else if (e.row.triggerState == "PAUSED") {
				return "<span style='color:#FFB90F'>暂停</span>";
			} else if (e.row.triggerState == "ERROR") {
				return "<span style='color:red;'>错误</span>";
			} else if (e.row.triggerState == "FINISH") {
				return "<span style='color:#FFB90F;'>结束</span>";
			}else if (e.row.triggerState == "COMPLETE") {
			    return "<span style='color:green;'>正常</span>";
			}else if (e.row.triggerState == "ACQUIRED") {
			    return "<span style='color:green;'>正常</span>";
			}else{
			    return e.row.triggerState;
			}
		}

		function renderOperate(e) {
		    var a1 = "";
		    var a2 = "&nbsp&nbsp<a href='javascript:void(0)'  onclick='queryErrorRecord(\""+e.row.jobName+"\")' style='color:blue;font-weight:bold;'>查看异常记录</a>";
			if (e.row.runningStatus=="未触发") {
				if (e.row.autoRecoveryFlag=="1") {//自动恢复开关为：关闭,则显示手动启动按钮
					a1 = "<a href='javascript:void(0)' onclick='startQrtzTask(\""+e.row.jobName+"\",\""+e.row.prevFireTime+"\")' style='color:blue;font-weight:bold;'>启动</a>";
				}
			} 
			return a1 + a2;
		}

		function renderTaskType(e) {
			if (e.row.taskType == 3) {
				return "任意JAVA方法任务";
			} else if (e.row.taskType == 2) {
				return "逻辑流任务";
			} else if (e.row.taskType == 1) {
				return "SCA服务任务";
			}
		}

        //启动定时任务
        function startQrtzTask(jobName,prevFireTime){
            var jsonJobName = nui.encode({"jobName":jobName,"prevFireTime":prevFireTime});
            $.ajax({
                url: "com.cjhxfund.ats.qrtz.qrtzMonite.startQrtzTask.biz.ext",
                type:"POST",
                data:jsonJobName,
                cache:false,
                contentType:'text/json',
                success: function (text) {
                    var returnJsonStatus = nui.decode(text).returnCode;
                    if(returnJsonStatus=="0"){
                       nui.alert("启动成功<br>请手动刷新页面或等待系统自动刷新(默认2秒,因为启动任务是异步的，<br>数据更新时间不定，个别定时器运行时间长，请耐心等待)！");
                       window.setTimeout(function (){search();},2*1000);//等待两秒再刷新列表,因为启动定时器是异步的
                    }else{
                       mini.alert("启动失败！");
                    }
                },
                error: function () {
                    mini.alert("启动失败！");
                }
            });
        }
        
        //查看历史异常记录
		function queryErrorRecord(jobName) {
		    var pageUrl="<%=request.getContextPath()%>/qrtz/qrtzMonite/errorRecord.jsp";
			mini.open({
				url : pageUrl,
				title : "错失触发异常历史记录",
				width : 750,
				height : 380,
				onload:function(){
				    var iframe=this.getIFrameEl();
				    iframe.contentWindow.setData(jobName);
				}
			});
		}
		
		//启动实时监控
		function startMonite(){
		    $.ajax({
		        url:"com.cjhxfund.ats.qrtz.qrtzMonite.startQrtzMonite.biz.ext",
		        type:"post",
		        success:function(text){
		            var returnCode=nui.decode(text).returnCode;
		            if(returnCode=="0"){
                       mini.alert("启动成功！");
                       $("#moniteStatus").html("<span style='color:green;'>已启动</span>");
                       nui.get("stopBtn").set({enabled:true});
		               nui.get("startBtn").set({enabled:false});
                    }else{
                       mini.alert("启动失败！");
                    }
		        }
		    });
		}
		
		//停止实时监控
		function stopMonite(){
		    $.ajax({
		       url:"com.cjhxfund.ats.qrtz.qrtzMonite.stopQrtzMonite.biz.ext",
		       type:"post",
		       success:function(text){
		           var returnCode=text.returnCode;
		           if(returnCode=="0"){
		               mini.alert("停止成功!");
		               $("#moniteStatus").html("<span style='color:red;'>已停止</span>");
		               nui.get("stopBtn").set({enabled:false});
		               nui.get("startBtn").set({enabled:true});
		           }else{
		               mini.alert("停止失败!");
		           }
		       }
		    });
		}
		
		//取实时监控运行状态
		function getMoniteStatus(){
		    $.ajax({
		       url:"com.cjhxfund.ats.qrtz.qrtzMonite.queryMoniteStatus.biz.ext",
		       type:"post",
		       success:function(text){
		           var status=text.status;
		           if(status=="started"){
		               $("#moniteStatus").html("<span style='color:green;'>已启动</span>");
		               nui.get("startBtn").set({enabled:false});
		           }else{
		               $("#moniteStatus").html("<span style='color:red;'>已停止</span>");
		               nui.get("stopBtn").set({enabled:false});
		           }
		       }
		    });
		}
		
	</script>
</body>
</html>