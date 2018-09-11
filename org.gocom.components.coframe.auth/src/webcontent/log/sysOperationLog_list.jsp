<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): liupinghui
  - Date: 2018-03-12 14:58:47
  - Description:
-->
<head>
<%@include file="/common/common.jsp" %>

<%
	String nameSqlId="org.gocom.components.coframe.auth.managerLog.queryUserOperationLog";
%>
<title>登录日志</title>
</head>
<body style="width:100%;overflow:hidden;">
 <div id="div_search" class="mini-panel" title="查询条件" iconCls="icon-find" collapseOnTitleClick="true" showCollapseButton="true" showFooter="true"  style="width:100%" >
	<div id="form1"  >
		<input class="nui-hidden" name="nameSqlId" value="<%=nameSqlId%>" />
		<input class="nui-hidden" name="para/filename" value="用户操作日志管理.xlsx" />
	    <input class="nui-hidden" name="para/rulename" value="OPERATIONLOG_EXCEL_EXPORT" />
	    <input class="nui-hidden" name="para/modename" value="用户操作日志管理" />
	    
		<table class="table" style="width:100%;" >
			<tr>
				<td class="tit R" >用户账号：</td>
		        <td>
		          <input class="nui-textbox" name="para/userid"   style="width:267px"   onenter="onKeyEnter"/>
		        </td>
		        <td class="tit R" >用户姓名：</td>
		        <td>
		          <input class="nui-textbox" name="para/username" style="width:267px"  onenter="onKeyEnter"/>
		        </td>
		        <td class="tit R" >用户IP： </td>
		        <td>
		          <input class="nui-textbox" name="para/ip"    style="width:267px"  onenter="onKeyEnter"/>
		        </td>
			</tr>
	        <tr>
				<td class="tit R">父菜单名称：</td>
		        <td >
				<input class="nui-textbox" name="para/pmenuname" style="width:267px"  onenter="onKeyEnter"/>
		        </td>
		        <td class="tit R">子菜单名称：</td>
		        <td >
					 <input class="nui-textbox" name="para/menuname" style="width:267px"  onenter="onKeyEnter"/>
		        </td>
				<td class="tit R">操作时间：</td>
		        <td >
					<input class="nui-datepicker"  id="operaBegindate"   style="width:120px" name="para/operaBegindate"   onenter="onKeyEnter"/>
					 &nbsp;至&nbsp;
		            <input class="nui-datepicker"   id="operaEnddate"     style="width:120px" name="para/operaEnddate"   onenter="onKeyEnter"/>
		        </td>
	        </tr>
			<tr>
			<td class="tit R">用户类型：</td>
		        <td >
					<input class="nui-dictcombobox" name="para/vcType" valueField="dictID" textField="dictName"   onenter="onKeyEnter"
		           dictTypeId="CJHX_USER_TYPE"  emptyText="请选择..."  showNullItem="true" nullItemText="请选择..." style="width:267px"  name="para/vcType"/>
		        </td>
				<td colspan="4" class="tit C" >
					<a class="nui-button mini-button-red" iconCls="icon-search" onclick="search()" >查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="nui-button mini-button-green" iconCls="icon-cancel" onclick="clear()" >清空</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<!-- <a class="nui-button mini-button-yellow" iconCls="icon-download" id="extButton">导出</a>  -->
				</td>
	        </tr>
	    </table>
	  </div>
  </div>
  <div  style="margin:5px 0px 0px 0px;" >
    <div  id="div_btnTools" class="nui-toolbar" style="border-bottom:0;padding:0px;">
<%--      <table style="width:100%;" >
        <tr>
           <td style="width:100%;">
		     <a id="update" class="nui-button" iconCls="icon-zoomin" onclick="view()">查看</a>
		     <a class="nui-button" iconCls="icon-remove" onclick="remove()">删除</a>
           </td>
        </tr>
      </table>--%>
    </div>
  </div>
  
  <div class="nui-fit" >
	 <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" 
	  url="com.cjhxfund.commonUtil.dataBaseUtils.queryByNamedSqlWithPage.biz.ext" 
	  allowAlternating="true" frozenStartColumn="1",frozenEndColumn="3"
	  showColumnsMenu="true"  allowResize="true"
	  sizeList=<%=sizeList%> multiSelect="false" pageSize="10" >
	    <div property="columns" >
	      	  <div field="L_ID" width="20"  headerAlign="center" align="center" autoEscape="true"  allowSort="true"  visible="false">主键</div>
	      	   <div field="VC_USERID"    width="40"headerAlign="center" align="center" allowSort="true"   autoEscape="true">用户账号</div>
	      	  <div field="EMPNAME"  width="40"  headerAlign="center" align="center" allowSort="true"  autoEscape="true">用户姓名</div>
	      	<div field="VC_TYPE"  width="40"  headerAlign="center" align="center" allowSort="true"  autoEscape="true" renderer="getDictName">用户类型</div>
		      <div field="VC_IP_ADDRESS"  width="50" headerAlign="center" align="center" allowSort="true"   autoEscape="true">用户IP </div>
		          <div field="P_MENUNAME" width="50"  headerAlign="center" align="center"   autoEscape="true"  autoEscape="true"  allowSort="true">父菜单名称 </div>
		      <div field="MENUNAME" headerAlign="center" align="center"   autoEscape="true">子菜单名称 </div>
		      <div field="D_OPERATE_TIME" width="55"  dateFormat="yyyy-MM-dd HH:mm:ss"   headerAlign="center" align="center" allowSort="true" allowSort="true">操作时间</div>
	      </div>
	 </div>
  </div>

 
  <script type="text/javascript">
	var messageId=null;
    nui.parse();
    var grid = nui.get("datagrid1");
    setValue();
    search();
    
    //业务字典
    function getDictName(e){
    	var dictText="";
    	if(this.field=="VC_TYPE"){
    		dictText=nui.getDictText("CJHX_USER_TYPE",e.row.VC_TYPE);
    	}
    	
    	return dictText;
    }
    
	function setValue() {
        var begin = nui.get("operaBegindate");
        begin.setValue(new Date());
		var end = nui.get("operaEnddate");
        end.setValue(new Date());
	}
        
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
   
    function onKeyEnter(e) {
		search();
	}
	
	//导出
	$("#extButton").click(function() {
		messageId=mini.loading("正在导出，请稍后...", '提示');
		var form = new nui.Form("#form1");
		var json = form.getData(true,true);
		$.post("com.cjhxfund.common.fileUtils.exportFile.biz.ext", json, function(data) {
            var downloadFile=data.filePath;
            var fileName=downloadFile.substring(downloadFile.lastIndexOf("/")+1);
            window.location.href="<%=contextPath%>/common/file/FileDownload_view.jsp?downloadFile="+downloadFile+"&&fileName="+fileName;
            mini.hideMessageBox(messageId);
		});
	});
  </script>
</body>
</html>