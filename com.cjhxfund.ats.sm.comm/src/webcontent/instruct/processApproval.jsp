<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-10-27 19:15:09
  - Description:指令/建议流程审批记录信息
-->
<head>
<title>流程审批信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	<div id="datagrid_process_approvel" dataField="approveInfos" 
	 	 url="com.cjhxfund.ats.sm.comm.InstructionManager.getProcessApprove.biz.ext"
		 class="nui-datagrid" style="width:100%;height:100%;"
         showPager="false"
         allowSortColumn="false"
         enableHotTrack="false">
	    <div property="columns">
	        <div field="vcWorkItemName" headerAlign="center" align="center" width="85px">
	            审批环节
	        </div>
	        <div field="vcUserName" headerAlign="center" align="center" width="85px">
	            审批人   
	        </div>
	        <div field="dEndTime" headerAlign="center" align="center" width="85px" dateFormat="yyyy-MM-dd HH:mm:ss">   
	            审批时间
	        </div>
	        <div field="vcOperateType" headerAlign="center" align="center" renderer="renderOperateType" width="85px">   
	             审批结果
	        </div>
	        <div field="vcComments" headerAlign="center"  align="center" width="85px">
	           审批意见
	        </div>
     	</div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	
    	var process_approvel = nui.get("datagrid_process_approvel");
    	var lResultId = null;
    	function detail(selectRow){
    		if(lResultId != selectRow.lResultId){
    			process_approvel.load({param:{lProcessInstId:selectRow.lProcessinstId}});
    		}
    		lResultId = selectRow.lResultId;
    	}
    	
    	function clearDetail(){
    		lResultId = null;
    		process_approvel.clearRows();
    	}
    	function renderOperateType(e){
    		if(e.row.vcOperateType==null){
    			return "";
    		}else if(e.row.vcOperateType == 1){
    			return "通过";
    		}else if(e.row.vcOperateType == 2){
    			return "退回";
    		}else{
    			return "不通过";
    		}
    	}
    	window.parent.detailLoaded();
    </script>
</body>
</html>