<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.primeton.cap.AppUserManager"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="com.cjhxfund.commonUtil.EncodesUtils"%>
<%@page import="com.cjhxfund.commonUtil.ParamConfig"%>
<%

    HttpSession  ss = request.getSession();
	UserObject user = (UserObject)ss.getAttribute("userObject");
	String  prefix=ParamConfig.getValue("paladin_url");
	String userId ="";
	
	String passwdOld ="";
	String passwdNew ="";
	String userIdOld = "";
	String userIdNew="";
	try{
		userId = AppUserManager.getCurrentUserId();
		
		userIdOld = AppUserManager.getCurrentUserId();
		userIdNew=EncodesUtils.encodeBase64(userIdOld);
		
		
		passwdOld = user.getAttributes().get("passwd").toString();
		passwdNew=EncodesUtils.encodeBase64(passwdOld);
	}catch(Exception e){}
	
	System.out.println("--------------------------");
	System.out.println(userIdOld+" "+userIdNew+" "+passwdOld+"  "+passwdNew);
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
			
			Date.prototype.Format = function (fmt) { 
		    var o = {
		        "M+": this.getMonth() + 1, 
		        "d+": this.getDate(), 
		        "h+": this.getHours(), 
		        "m+": this.getMinutes(), 
		        "s+": this.getSeconds(), 
		        "q+": Math.floor((this.getMonth() + 3) / 3), 
		        "S": this.getMilliseconds() 
		    };
		    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		    for (var k in o)
		    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		    return fmt;
		    };
			//var prefix ="http://10.201.235.54:8088/scxx-web";
			var prefix="<%=prefix%>";
			var fromsys = "atsv2";//atsv2 oms
	        var path = "/atsv2/redirect";
	        var router = location.href.split("?")[1].split("&")[0].replace("page=","");
			var userInfo = {userId:"<%=userIdNew %>",passWord:"<%=passwdNew %>"};
			
			var timestamp=new Date().Format("yyyyMMddhhmmss");
		
			var url = prefix +router+'?customer=CJ'  + '&username=' + userInfo.userId + '&password=' + userInfo.passWord+ '&timestamp=' +timestamp;  
			// "http://10.201.235.54:8088/scxx-web/ipoSecTraceController/manager?customer=CJ&username=c3lzYWRtaW4=&password=aCswZUVEVUNJZ3c9"
		    
		
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