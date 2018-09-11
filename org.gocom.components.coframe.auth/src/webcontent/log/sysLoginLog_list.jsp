<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): liupinghui
  - Date: 2018-03-12 13:20:43
  - Description:
-->
<head>
<%@include file="/common/common.jsp" %>

<%
	String nameSqlId="org.gocom.components.coframe.auth.managerLog.queryUserLoginLog";
	
%>
<title>登录日志</title>
</head>
<body style="width:100%;overflow:hidden;">
 <div id="div_search" class="mini-panel" title="查询条件" iconCls="icon-find" collapseOnTitleClick="true" showCollapseButton="true" showFooter="true"  style="width:100%" >
	<div id="form1"  >
		<input class="nui-hidden" name="nameSqlId" value="<%=nameSqlId%>" />
	  	<input class="nui-hidden" name="para/filename" value="系统登录日志管理.xlsx" />
	    <input class="nui-hidden" name="para/rulename" value="USERLOG_EXCEL_EXPORT" />
	    <input class="nui-hidden" name="para/modename" value="系统登录日志管理" />
	    
		<table class="table" style="width:100%;" >
			<tr>
		        <td class="tit R" >用户姓名：</td>
		        <td>
		          <input class="nui-textbox" name="para/username" style="width:267px"  onenter="onKeyEnter"/>
		        </td>
		        <td class="tit R" >登录账号：</td>
		        <td>
		          <input class="nui-textbox" name="para/userid"   style="width:267px"   onenter="onKeyEnter"/>
		        </td>
		        <td class="tit R" >登录IP： </td>
		        <td>
		          <input class="nui-textbox" name="para/ip"    style="width:267px"  onenter="onKeyEnter"/>
		        </td>
			</tr>
	        <tr>
		        <td class="tit R">登录时间：</td>
		        <td >
					<input class="nui-datepicker" id="loginBegindate"   style="width:120px" name="para/loginBegindate"   onenter="onKeyEnter"/>
					 &nbsp;至&nbsp;
		            <input class="nui-datepicker" id="loginEnddate"     style="width:120px" name="para/loginEnddate"   onenter="onKeyEnter"/>
		        </td>
		        
		        <td class="tit R">退出时间：</td>
		        <td >
					<input class="nui-datepicker" id="logoutBegindate" value=""  style="width:120px" name="para/logoutBegindate"   onenter="onKeyEnter"/>
					&nbsp;至&nbsp;
		            <input class="nui-datepicker"  id="logoutEnddate"  value=""  style="width:120px" name="para/logoutEnddate"   onenter="onKeyEnter"/>
		        </td>
		       
				 <td class="tit R">退出原因：</td>
		        <td>
		           <input class="nui-dictcombobox" name="para/outreason" valueField="dictID" textField="dictName"   onenter="onKeyEnter"
		           dictTypeId="OMS_OUT_REASON"  emptyText="请选择..."  showNullItem="true" nullItemText="请选择..." style="width:267px"  name="para/reason"/>
		        </td>
	        </tr>
	        <tr >
	        <td class="tit R">用户类型：</td>
		        <td >
					<input class="nui-dictcombobox" name="para/vcType" valueField="dictID" textField="dictName"   onenter="onKeyEnter"
		           dictTypeId="CJHX_USER_TYPE"  emptyText="请选择..."  showNullItem="true" nullItemText="请选择..." style="width:267px"  name="para/vcType"/>
		        </td>
				<td colspan="4" class="tit C" >
					<a class="nui-button mini-button-red" iconCls="icon-search" onclick="search()" >查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="nui-button mini-button-green" iconCls="icon-cancel" onclick="clear()" >清空</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<!-- <a class="nui-button mini-button-yellow" iconCls="icon-download" id="extButton">导出</a> --> 
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
	      	 <%-- <div type="checkcolumn" width="10"></div>--%>
	      	  <div field="VC_USERNAME"  width="40"  headerAlign="center" align="center" allowSort="true">用户姓名</div>
	      	  <div field="VC_USERCODE"    width="40"headerAlign="center" align="center" allowSort="true">登录账号</div>
	      	  <div field="VC_TYPE"  width="40"  headerAlign="center" align="center" allowSort="true"  autoEscape="true" renderer="getDictName">账号类型</div>
		      <div field="VC_IP"  width="50" headerAlign="center" align="center" allowSort="true">登录IP </div>
		      <div field="D_LOGINTIME" width="55"  dateFormat="yyyy-MM-dd HH:mm:ss"   headerAlign="center" align="center" allowSort="true" allowSort="true">登录时间</div>
		      <div field="D_OUTTIME" width="55"   dateFormat="yyyy-MM-dd HH:mm:ss"  headerAlign="center" align="center" allowSort="true" >退出时间</div>
		      <div field="VC_LOGINMINUTES"  width="40"   headerAlign="center"  dataType="float" decimalPlaces="2" align="center"  allowSort="true">登录时长(分)</div>
		      <div field="VC_OUTREASON" headerAlign="center" align="center"   renderer="getDictName">退出原因 </div>
	      </div>
	 </div>
  </div>

 
  <script type="text/javascript">
  	var messageId=null;
    nui.parse();
    var grid = nui.get("datagrid1");
    setValue();
    search();
    
    function setValue() {
		var begin = nui.get("loginBegindate");
        begin.setValue(new Date());
		var end = nui.get("loginEnddate");
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
		if(!check()) return;
		grid.load(data);
    }
	
	
	//业务字典
    function getDictName(e){
    	var dictText="";
    	if(this.field=="VC_OUTREASON"){
    		dictText=nui.getDictText("OMS_OUT_REASON",e.row.VC_OUTREASON);
	    }
    	if(this.field=="VC_TYPE"){
    		dictText=nui.getDictText("CJHX_USER_TYPE",e.row.VC_TYPE);
    	}
    	
    	return dictText;
    }
	    
	  //时间验证
    function check(){
    	debugger;
	    var startcl1 = mini.get("loginBegindate").value;
	    var endcl1 = mini.get("loginEnddate").value;//登录日期
	    var startcl = new Date(mini.get("loginBegindate").value).format("yyyyMMdd");//登录日期
	    var endcl = new Date(mini.get("loginEnddate").value).format("yyyyMMdd");//登录日期
	    
	    var startqp1 = mini.get("logoutBegindate").value;//退出日期
	    var endDaqp1 = mini.get("logoutEnddate").value;//退出日期
	    var startqp =new Date( mini.get("logoutBegindate").value).format("yyyyMMdd");//退出日期
	    var endDaqp =new Date( mini.get("logoutEnddate").value).format("yyyyMMdd");//退出日期
   
		if(startcl1 !=""&&startcl !=null && endcl1 !=""&&startcl > endcl){
	        nui.alert("登录开始日期不能大于结束日期！");
	     	return false;
		}
	     
		if(startqp1 !="" && endDaqp1 !=""&&startqp > endDaqp){
			nui.alert("退出开始日期不能大于结束日期！");
	     	return false;
		}
		return true;
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