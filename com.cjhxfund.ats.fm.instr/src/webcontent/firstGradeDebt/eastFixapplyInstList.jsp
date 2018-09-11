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
<title>fix指令/建议发送列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <%
    	String bizId = request.getParameter("bizId");
    	String processinstid = request.getParameter("processinstid");  
    	String type = request.getParameter("type"); 	
     %>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;margin: 0px;">
<div id="fix_Form">
	<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.fm.comm.comm.QueryApplyInsertStatus"/>
	<input class="nui-hidden" name="criteria/_expr[1]/lBizId" value="<%=bizId%>"/>
	<input class="nui-hidden" name="criteria/_expr[1]/_op" value="="/>
	
</div>

<div id="fix_grid" class="mini-datagrid" style="width:100%;height:96%;" 
	 url="com.cjhxfund.ats.fm.comm.atsEastFaxBiz.queryEastFixApplyInfoList.biz.ext" 
	 dataField="eastFix"  showPageInfo="false" showPager="false"  multiSelect="true" allowSortColumn="false" >
	 <div property="columns">
		<div type="checkcolumn" width="20"></div>
		<div field="vcClordid" align="center" allowSort="true"  headerAlign="center">第三方编号</div>
		<div field="receiveDate" headerAlign="center" align="center" width="50px">发送时间</div>
		<div field="sendDate" headerAlign="center" align="center" width="50px">发送时间</div>
		<div field="vcOrderqty" headerAlign="center" align="center" allowSort="true">缴款面值</div> 
		<div field="vcPrice" headerAlign="center" align="center" allowSort="true">缴款金额</div>               
		<div field="vcStatus" align="center" headerAlign="center">状态</div>
		<div field="vcText"  headerAlign="center" align="center" visible="false">反馈信息</div> 
	 </div>
</div>
   
<script type="text/javascript">
	nui.parse();
	
	//附件列表查询
    var fix_grid = nui.get("fix_grid");
	var fix_Form = new nui.Form("#fix_Form").getData(false,false);
		fix_grid.load(fix_Form);
	
	//重新刷新页面
	function refresh(){
		var form = new  nui.Form("#fix_Form");
		var json = form.getData(false,false);
			fax_grid.load(json);//grid查询
    }
	
	
</script>
</body>
</html>