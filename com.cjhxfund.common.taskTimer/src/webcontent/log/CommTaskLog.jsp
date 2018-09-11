<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 王锡锋
  - Date: 2018-03-06 18:26:39
  - Description:
-->
<head>
<title>定时器日志及监控</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="width:100%;">
 <div id="form1">
     <div id="div_search" class="mini-panel" title="查询条件"  iconCls="icon-find" collapseOnTitleClick="true" showCollapseButton="true" showFooter="false"  style="width:100%" >
	    <input class="nui-hidden" name="criteria._entity" value="com.cjhxfund.ats.taskTimer.dataTask.TaskLogEntity" />
	    <!-- 排序 父级菜单层级、父菜单编号、顺序、主键 -->
		  	<input class="nui-hidden" name="criteria._orderby[0]._property"  value="vcState"/>
		  	<input class="nui-hidden" name="criteria._orderby[0]._sort"  value="desc" />
		  	
		  	<input class="nui-hidden" name="criteria._orderby[1]._property"  value="vcTaskCode"/>
		  	<input class="nui-hidden" name="criteria._orderby[1]._sort"  value="asc" />
		  	
		    <input class="nui-hidden"  name="criteria._expr[0].ywrq" value="<%=new SimpleDateFormat("yyyyMMdd").format(new Date()) %>"/>
       	    <input class="nui-hidden" name="criteria._expr[0]._op" value="="/>
	      <table class="table" style="width:100%;">
	      <tr>
            <td class="tit R" style="min-width:70px">&nbsp;&nbsp;任务编码：</td>
			<td>
			<input class="nui-textbox" name="criteria._expr[1].vcTaskCode" onenter="onKeyEnter"/>
			      <input class="nui-hidden" name="criteria._expr[1]._op" value="like"/>
		          <input class="nui-hidden" name="criteria._expr[1]._likeRule" value="all"/>
			</td>
            
            <td class="tit R" style="min-width:70px;">&nbsp;&nbsp;任务名称：</td>
            <td>
            <input class="nui-textbox" name="criteria._expr[2].vcTaskNameShow" onenter="onKeyEnter"/>
           <input class="nui-hidden" name="criteria._expr[2]._op" value="like"/>
		          <input class="nui-hidden" name="criteria._expr[2]._likeRule" value="all"/>
           </td>
           <td class="tit R" style="min-width:70px;">&nbsp;&nbsp;定时器编码：</td>
            <td>
            <input class="nui-textbox" name="criteria._expr[4].vcTaskName" onenter="onKeyEnter"/>
           <input class="nui-hidden" name="criteria._expr[4]._op" value="like"/>
		          <input class="nui-hidden" name="criteria._expr[4]._likeRule" value="all"/>
           </td>
           <td class="tit R" style="min-width:70px;">&nbsp;&nbsp;执行状态：</td>
            <td>
            <input  class="nui-dictcombobox"  valueField="dictID" textField="dictName" dictTypeId="COMM_TIMER_STATE"  name="criteria._expr[3].vcState"  
              emptyText="请选择..."  showNullItem="true" nullItemText="请选择..."  >     
           <input class="nui-hidden" name="criteria._expr[3]._op" value="="/>
           </td>
           <td class="tit R" ></td>
            <td class="tit l" style="min-width:150px;">
              <a class="nui-button mini-button-red" iconCls="icon-search" onclick="search">查询</a>
	          <a class="nui-button mini-button-green" iconCls="icon-cancel" onclick="clear">清空</a>
	          <%--<a class="nui-button" iconCls="icon-add" onclick="SaveCondition.init(this.el,'form1','tasklist_done','<%=userId%>');">保存查询条件</a>--%>
	        </td>
	      </tr>
	    </table>
	</div>
</div>
<div class="nui-toolbar" >
						<table width="100%">
							<tr>
								<td>
									<a class="mini-button" iconCls="icon-ok"      onclick="runNow()">立即执行</a>
								</td>
							</tr>
						</table>
					</div>
	<!--操作按钮结束   min-height出滚动条 --> 
<div class="nui-fit" style="min-height:300px;">
	 <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;"  
	  url="com.cjhxfund.ats.taskTimer.CommTimerLog.queryTaskLog.biz.ext" 
	  showColumnsMenu="true"   allowResize="true" dataField="taskLogs"
	  sizeList=[10,20,30,40,50,100,200] multiSelect="true" pageSize="100" >
	  
	    <div property="columns" >
	    <div type="checkcolumn" ></div>
	     <div type="indexcolumn" >序号</div>
	     <div field="vcTaskCode"    headerAlign="center" align="center" autoEscape="true">任务编码</div>
	      <div field="vcTaskNameShow"    headerAlign="center" align="center"  autoEscape="true"  allowSort="true">任务名称</div>
	      <div field="vcTaskName"   width="180px" headerAlign="center" align="center"  autoEscape="true"  allowSort="true">定时器编码</div>
	      <div field="vcYwrq"     headerAlign="center" align="center"  autoEscape="true"  allowSort="true">业务日期</div>
	      
	      <div field="vcTargetQname"   width="180px" headerAlign="center" align="center"  autoEscape="true"  visible="false"  allowSort="true" >方法前缀</div>
	      <div field="vcTargetOperation"     headerAlign="center" align="center"  autoEscape="true"  visible="false"  allowSort="true">方法名</div>
	      
	      <div field="vcRunState"    headerAlign="center" align="center"  autoEscape="true"  allowSort="true" renderer="getDictType">定时器状态</div>
          <div field="vcStatus"    headerAlign="center" align="center"  autoEscape="true"  allowSort="true"  renderer="getDictType">监控状态</div>
	      <div field="vcState"    headerAlign="center" align="center"  autoEscape="true"  allowSort="true"  renderer="getDictType">执行状态</div>
          <div field="vcDetail"    headerAlign="center" align="center" renderer="getDictType">日志详情</div>
	   </div>
	   
	 </div>
  </div>



	<script type="text/javascript">
    	nui.parse();
    	nui.parse();
    var grid = nui.get("datagrid1");
    var messageId=null;
    search();//查询
    //重置查询条件
    function clear(){
       var form = new nui.Form("#form1");
       form.reset();
      }
      
    //查询
  
    function search(){
       var form = new nui.Form("#form1");
       var data = form.getData(true,true);
       grid.load(data);
    }
    
    //直接执行定时器
	function runNow(){
		//获取定时器列表
		var timerdatagrid = nui.get("datagrid1");
		//获取定时器选中的记录
		var timerRows = timerdatagrid.getSelecteds();
		debugger;
		//只允许选中一行定时器记录
		if(!timerRows || timerRows.length!=1){
			nui.alert("请选择一行定时器","系统提示");
			return;
		}else{
			var url = timerRows[0].vcTargetQname+"."+timerRows[0].vcTargetOperation+".biz.ext";
			var json = nui.encode({timerId:timerRows[0].vcTaskName});
			console.info("手动执行定时器: ===> "+url);
			$.ajax({
				url: url,
	            type: 'POST',data: json,cache: false,contentType:'text/json',
	            success: function (text) {
	                var returnJson = nui.decode(text);
	                if(returnJson.exception == null){
	                	nui.alert("执行成功","系统提示");
	                	search();
	                }else{
	                	nui.alert("执行失败","系统提示");
	                }
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                nui.alert("系统出错，请联系管理员解决","系统提示");
	            }
			});
		}
	}
    
     function onvaluechanged(e){
        search();
       }
        //业务字典
	    function getDictType(e){
	    	var dictText="";
	    	if(this.field=="vcState"){
	    		dictText=nui.getDictText("COMM_TIMER_STATE",e.row.vcState);//当天执行状态
	    	}
	    	if(this.field=="vcStatus"){
	    		dictText=nui.getDictText("COMM_JK_STATE",e.row.vcStatus);//监控状态
	    		if(e.row.vcStatus=="3"||e.row.vcStatus=="5"||e.row.vcStatus=="6"){
	    			e.cellStyle = "color:#FF0000;font-weight:bold;";
	    		}
	    	}
	    	if(this.field=="vcRunState"){
				if(e.row.vcRunState == '1'||e.row.vcRunState == '3'){
					e.cellStyle = "color:#FF0000;font-weight:bold;";
				}
				dictText=nui.getDictText("COMM_QRTZ_STATE",e.row.vcRunState);//定时器状态
			}
	    	if(this.field=="vcDetail"){
	    		dictText = "<a href='javascript:void(0)' style='text-decoration:none;color:blue;' onclick='logDetails(\""+e.row.vcTaskName+"\")'>日志详情</a>"; //需求详情
	    	}
	    	return dictText;
	    }

       
        //定时器执行日志详情
	      function logDetails(vcTaskName){ 
       	   nui.open({
	          url:"<%=request.getContextPath()%>/taskTimer/log/CommExecuteLogDetail.jsp?vcTaskName="+vcTaskName,
	          title:'执行日志详情',
	          iconCls:"",
	          width:1200,
	          height:450,
	          onload:function(){
	           /* var iframe = this.getIFrameEl();
			   iframe.contentWindow.setRowData(grid.getSelected()); */ 
	          },
	          ondestroy:function(result){ 
	          }
	       });
       }
		 
    </script>
</body>
</html>