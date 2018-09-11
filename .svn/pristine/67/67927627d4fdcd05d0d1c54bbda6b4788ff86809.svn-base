<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 王锡锋
  - Date: 2018-03-08 16:45:56
  - Description:
-->
<head>
<%
	String taskId= request.getParameter("vcTaskName");
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");//设置日期格式
	String nowDate = df.format(new Date());// new Date()为获取当前系统时间
 %>
<title>执行日志明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="width:98%;">
 <div id="form1">
     <div id="div_search" class="mini-panel" title="查询条件"  iconCls="icon-find" collapseOnTitleClick="true" showCollapseButton="true" showFooter="false"  style="width:100%" >
	    <input class="nui-hidden" name="criteria._entity" value="com.cjhxfund.ats.taskTimer.dataTask.ExecuteLogEntity" />
	    <!-- 排序 父级菜单层级、父菜单编号、顺序、主键 -->
		  	<input class="nui-hidden" name="criteria._orderby[0]._property"  value="lId"/>
		  	<input class="nui-hidden" name="criteria._orderby[0]._sort"  value="desc" />

		    <input class="nui-hidden"  name="criteria._expr[0].vcTimerName" value="<%=taskId %>"/>
       	    <input class="nui-hidden" name="criteria._expr[0]._op" value="="/>
	      <table class="table" style="width:100%;">
	      <tr>
            <td class="tit R" style="min-width:70px">&nbsp;&nbsp;执行日期：</td>
			<td>
			<input class="nui-datepicker" name="criteria._expr[1].vcYwrq" style="width:45%;" value="<%=nowDate %>" format="yyyy-MM-dd"/>
				  <input type="hidden" name="criteria._expr[1]._op" value="=" >
			</td>
			<td class="tit R" style="min-width:70px">&nbsp;&nbsp;执行状态：</td>
			<td>
			<input  class="nui-dictcombobox"  valueField="dictID" textField="dictName" dictTypeId="COMM_EXECUTE_STATE"  name="criteria._expr[2].vcState"  
              emptyText="请选择..."  showNullItem="true" nullItemText="请选择..."  >
				  <input type="hidden" name="criteria._expr[2]._op" value="=" >
			</td>
            <td class="tit" ></td>
            <td class="tit l" style="min-width:150px;">
              <a class="nui-button mini-button-red" iconCls="icon-search" onclick="search">查询</a>
	          <a class="nui-button mini-button-green" iconCls="icon-cancel" onclick="clear">清空</a>
	          <%--<a class="nui-button" iconCls="icon-add" onclick="SaveCondition.init(this.el,'form1','tasklist_done','<%=userId%>');">保存查询条件</a>--%>
	        </td>
	      </tr>
	    </table>
	</div>
</div>

	<!--操作按钮结束   min-height出滚动条 --> 
<div class="nui-fit" style="min-height:300px;">
	 <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;"  
	  url="com.cjhxfund.ats.taskTimer.CommTimerLog.queryExecuteLogs.biz.ext" 
	  showColumnsMenu="true"   allowResize="true" dataField="executeLogs"
	  sizeList=[10,20,30,40,50,100,200] multiSelect="true" pageSize="100" >
	  
	    <div property="columns" >
	     <div type="indexcolumn" >序号</div>
	     <div field="vcTaskCode"    headerAlign="center" align="center" autoEscape="true">任务编码</div>
	      <div field="vcTaskNameShow"    headerAlign="center" align="center"  autoEscape="true"  allowSort="true">任务名称</div>
	      <div field="vcTimerName"   headerAlign="center" align="center"  autoEscape="true"  allowSort="true">定时器编码</div>
	      <div field="dStartTime"  width="180px"    headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" autoEscape="true"  allowSort="true">执行开始时间</div>
	      <div field="dEndTime"   width="180px"  headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm:ss" autoEscape="true"  allowSort="true" >执行结束时间</div>
	      <div field="vcYwrq"    headerAlign="center" align="center" autoEscape="true"  allowSort="true" >执行日期</div>
	      <div field="vcState"    headerAlign="center" align="center"  autoEscape="true"  allowSort="true"  renderer="getDictType">执行状态</div>
          <div field="vcResult"     headerAlign="center" align="center"  autoEscape="true"  allowSort="true">执行结果</div>
	   </div>
	   
	 </div>
  </div>



	<script type="text/javascript">
    	nui.parse();
    	nui.parse();
    var grid = nui.get("datagrid1");
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
    
     function onvaluechanged(e){
        search();
       }
        //业务字典
	    function getDictType(e){
	    	var dictText="";
	    	if(this.field=="vcState"){
	    		dictText=nui.getDictText("COMM_EXECUTE_STATE",e.row.vcState);//业务类型
	    	}
	    	return dictText;
	    }

    </script>
</body>
</html>