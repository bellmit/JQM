<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.primeton.cap.AppUserManager"%>
<%@page import="com.cjhxfund.commonUtil.ParamConfig"%>
<%
	String userId ="";
	String  prefix=ParamConfig.getValue("ats_url");
	try{
		userId = AppUserManager.getCurrentUserId();
	}catch(Exception e){}
 %>
<html>
	<head>
		<!-- <script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.js"></script> --> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/nui.js"></script> 
		<script>
			//var prefix="http://localhost:8080/default";
			//var prefix = "http://139.199.45.44:8081/ats2_5";
			//var prefix = "http://10.201.224.92:8080/default";
			//var prefix="http://10.211.16.13:8081/ats2_5";
			//var prefix ="https://cjcwjy.cjhxfund.com/ats2_5";
			var prefix="<%=prefix%>";
			var fromsys = "atsv2";//atsv2 oms
			
			var path = "/atsv2/redirect";
			var router = location.href.split("?")[1].split("&")[0].replace("page=","");
			var userInfo = {userId:"<%=userId %>"};
			var url = prefix + path +'?router='+ router + '&userId=' + userInfo.userId +"&fromsys="+fromsys; 
		
			if(!top.ats2_5_obj){top.ats2_5_obj={}}
			if(!top.ats2_5_obj[router]){ top.ats2_5_obj[router]={}}
			top.ats2_5_obj[router].tabHeaderId = $(top.document).find("#center #mainTabs .mini-tabs-body:visible").attr("id").replace("$body","");
			top.ats2_5_obj[router].num = top.ats2_5_obj[router].num || "";
			
		</script>
	</head>
	<body style="position:absolute;top:0;bottom:0;left:0;right:0;border-width:0;margin:0;">
		<iframe style="width:100%;height:100%;border-width: 0;" id="ats2_5_iframe"></iframe>
	</body>
	<script>
		if(userInfo.userId){
			document.getElementById("ats2_5_iframe").src=url;
		}else{
			nui.alert("【系统】会话超时，请重新登录","系统消息");
		}
		
		<%-- document.getElementById("ats2_5_iframe").onload = function(){
			if($(top.document).find("#ats2_5_keepAlive").length == 0){
				$(top.document.body).append('<iframe style="display:block;width: 252px;height: 172px;position: fixed;z-index: 100;bottom: 10px;right: 10px;border-width: 0;" id="ats2_5_keepAlive" src="<%=request.getContextPath()%>/common/ats2_5.keepAlive.jsp"></iframe>');
			}
		} --%>
	</script>
</html>