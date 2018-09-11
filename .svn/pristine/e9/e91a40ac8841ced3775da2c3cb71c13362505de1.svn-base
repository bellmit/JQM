<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 陈鹏
  - Date: 2016-09-10 11:30:50
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%
    	String processinstid = request.getParameter("processinstid");   //流程ID
    	String activityDefID = request.getParameter("activityDefID");	//活动定义ID
     %>
</head>
<body style="width: 100%;height: 100%;margin: 0px;overflow: hidden;">
	<!-- 流程处理信息列表 -->
		   <div id="grid_form">
			   <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.foundation.task.EntityDataSet.TAtsApproveInfo"/>
			   <input class="nui-hidden" name="criteria/_expr[1]/lProcessInstId" value="<%=processinstid %>"/>
			   <input class="nui-hidden" name="cirteria/_expr[1]/_op" value="="/>
			   <input class="nui-hidden" name="criteria/_expr[2]/vcActivityDefId" value="<%=activityDefID %>"/>
			   <input class="nui-hidden" name="cirteria/_expr[2]/_op" value="="/>
		   	</div>
			<div id="deptGrid" class="nui-datagrid" style="width:100%;height:250px;"
				 url="com.cjhxfund.foundation.task.pendingTreatment.queryTAtsApproveInfoList.biz.ext"  
				 dataField="TAtsApproveInfos" pageSize="50" showPageInfo="true"
			                        multiSelect="true" allowSortColumn="true">
			 <div property="columns">            
			     <div field="lWorkItemId"  headerAlign="center" visible="false">工作项ID</div> 
			     <div field="lApproveId"  headerAlign="center" visible="false">编号</div> 
			     <div field="processInstId"  headerAlign="center" visible="false">流程ID</div>
			     <div field="dStartTime"  headerAlign="center" align="center" width="80px"dateFormat="yyyy-MM-dd HH:mm:ss">审批时间</div>                                         
			     <div field="vcUserName"  headerAlign="center" align="center" width="50px">操作者</div>  
			     <div field="vcOperateType"  headerAlign="center" align="center" width="30px" renderer="rendeRoperateType">操作</div>  
			     <div field="vcComments"  headerAlign="center" >处理意见</div>         
			 </div>
		</div> 
	<script type="text/javascript">
    	nui.parse();
    	
    	 //审批意见
	var dept_grid = nui.get("deptGrid");
	var formData = new nui.Form("#grid_form").getData(false,false);
	dept_grid.load(formData);
	
	function rendeRoperateType(e){
	          if(e.row.vcOperateType == 1){
	            return "同意";
	          }
	          if(e.row.vcOperateType == 2){
	            return "退办";
	          }
	          if(e.row.vcOperateType == 3){
	            return "转办";
	          }
	          if(e.row.vcOperateType == 4){
	            return "征求意见";
	          }
	          if(e.row.vcOperateType == 5){
	            return "否决";
	          }
	          if(e.row.vcOperateType == 99){
	            return "不同意";
	          }
	          if(e.row.vcOperateType == 98){
				return "修改";
			  }
			  if(e.row.vcOperateType == 97){
				return "废弃";
			  }
          }
    </script>
</body>
</html>