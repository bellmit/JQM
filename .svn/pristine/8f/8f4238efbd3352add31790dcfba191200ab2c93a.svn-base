<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 武正新
  - Date: 2017-12-13 10:35:58
  - Description:
-->
<head>
<title>定时器异常历史记录</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
</head>
<body style="width: 100%; height: 100%;padding:0px;margin:0px;border:0px;">
	<div class="nui-fit" style="margin:0px;padding:0px;border:0px;">
		<div id="datagrid2" dataField="records" class="nui-datagrid" style="width: 100%; height: 100%;margin:0px;border:0px;"
			url="com.cjhxfund.ats.qrtz.qrtzMonite.queryQrtzError.biz.ext" pageSize="20" showPageInfo="true"
			multiSelect="true" allowSortColumn="false">
			<div property="columns">
				<div type="indexcolumn" headerAlign="center" width="10">序号</div>
				<div field="jobName" headerAlign="center" allowSort="false" width="40">任务名称</div>
				<div field="prevFireTime" headerAlign="center" allowSort="false" width="40" renderer="renderPrevFireTime">上次触发时间</div>
				<div field="startTime" headerAlign="center" allowSort="false" width="40" renderer="renderStartTime">执行开使时间</div>
				<div field="endTime" headerAlign="center" allowSort="false" width="40" renderer="renderEndTime">执行结束时间</div>
				<div field="triggerState" headerAlign="center" allowSort="false" width="20" >状态</div>
				<div field="createTime" headerAlign="center" allowSort="false" width="40" >创建时间</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		nui.parse();
		var jobName = "";
		function setData(data) {
			jobName = data;
			var grid = nui.get("datagrid2");
		    grid.load({param:{"jobName":jobName}});
		}
		
		function renderPrevFireTime(e){
		    return getLocalTime(e.row.prevFireTime);
		}
		
		function renderStartTime(e){
		    return getLocalTime(e.row.startTime);
		}
		
		function renderEndTime(e){
		    return getLocalTime(e.row.endTime);
		}
		
		/* function renderCreateTime(e){
		    var timeStr=dateToString(e.row.createTime);
		    alert(timeStr);
		    return timeStr;
		} */
		
		//时间戳转时间格式yyyy-MM-dd HH:mm:ss，兼容性待测试
		function getLocalTime(nS) {     
           return new Date(parseInt(nS)).toLocaleString().replace(/年|月/g, "-").replace(/日/g," ");  
        }    
	</script>
</body>
</html>