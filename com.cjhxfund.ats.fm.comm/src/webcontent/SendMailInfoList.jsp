<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/js/commscripts.jsp" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 陈鹏
  - Date: 2016-10-14 13:34:13
  - Description:
-->
<head>
<title>传真发送列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <%
    	String bizId = request.getParameter("bizId");
    	String processinstid = request.getParameter("processinstid");  
     %>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;margin: 0px;">
<div id="fax_Form">
	<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.fm.comm.comm.TAtsSendmailInfo"/>
	<input class="nui-hidden" name="criteria/_expr[1]/lBizId" value="<%=bizId%>"/>
	<input class="nui-hidden" name="criteria/_expr[1]/_op" value="="/>
	<input class="nui-hidden" name="criteria/_expr[2]/lProcessInstId" value="<%=processinstid%>"/>
	<input class="nui-hidden" name="criteria/_expr[2]/_op" value="="/>
</div>

<div id="fax_grid" class="mini-datagrid" style="width:100%;height:96%;" 
	 url="com.cjhxfund.ats.fm.comm.common.querySendMailInfoList.biz.ext" 
	 dataField="objs"  showPageInfo="false" showPager="false"  multiSelect="true" allowSortColumn="false">
	 <div property="columns">
		<div type="checkcolumn" width="20"></div>
		<div field="lEmailId"  headerAlign="center" align="center" visible="false">编号</div> 
		<div field="vcTitle" align="center" allowSort="true"  headerAlign="center">主题</div>
		<div field="vcMailTo" align="center" headerAlign="center">收件人</div>
		<div field="vcMailCc" headerAlign="center" align="center">抄送人</div>
		<div field="vcMailContext" headerAlign="center" align="center" allowSort="true">正文</div> 
		<div field="vcMailSender" headerAlign="center" align="center" allowSort="true">发送人</div>               
		<div field="vcAttachFileName" headerAlign="center"  align="center"allowSort="true">附件名称</div>
		<div field="cStatus" headerAlign="center"  align="center"allowSort="true" renderer="rendererSentStatus">发送状态</div>
	 </div>
</div>

<script type="text/javascript">
	nui.parse();
        
	//附件列表查询
    var fax_grid = nui.get("fax_grid");
	var fax_Form = new nui.Form("#fax_Form").getData(false,false);
		fax_grid.load(fax_Form);
		
	function rendererSentStatus(e){
		if(e.row.cStatus=='0'){
        		return "成功";
        }else if(e.row.cStatus=='1'){
        		return "失败";
        }
	}
</script>
</body>
</html>