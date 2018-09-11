<%@page import="org.gocom.components.coframe.auth.login.DaemonThread"%>
<%@page import="org.gocom.components.coframe.auth.login.UserText"%>
<%@page import="com.eos.foundation.data.DataObjectUtil"%>
<%@page import="java.util.Date"%>
<%@page import="com.eos.runtime.core.ApplicationContext"%>
<%@page import="org.gocom.components.coframe.auth.login.VerifyCodeServlet"%>
<%@page import="com.eos.system.utility.StringUtil"%>
<%@page import="com.eos.access.http.security.config.HttpSecurityConfig"%>
<%@page import="org.gocom.components.coframe.auth.login.SendMsncService"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="com.primeton.cap.AppUserManager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-- 
  - Author(s): zhangyao
  - Date: 2017-01-17 15:44:40
  - Description:
-->
<head>
<title>创金综合服务平台-用户登录</title>
<%
   String contextPath=request.getContextPath();
   String url = null;
   HttpSecurityConfig securityConfig = new HttpSecurityConfig();
   boolean isOpenSecurity = securityConfig.isOpenSecurity();
   if(isOpenSecurity){
   		boolean isAllInHttps = securityConfig.isAllInHttps();
   		if(!isAllInHttps){
   			String ip = securityConfig.getHost();
   			String https_port = securityConfig.getHttps_port();
   			url = "https://" + ip + ":" + https_port + contextPath + "/coframe/auth/login/org.gocom.components.coframe.auth.login.login.flow";
   		}else{
   			url = "org.gocom.components.coframe.auth.login.login.flow"; 
   		}
   }else{
   		url = "org.gocom.components.coframe.auth.login.login.flow";
   }
 %>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <script type="text/javascript" src="<%=contextPath %>/common/nui/nui.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=contextPath %>/coframe/auth/login/css/style.css"" />
	<link rel="stylesheet" href="<%=contextPath %>/coframe/auth/login/css/supersized.css"/>
	<link rel="icon" href="<%=contextPath %>/coframe/auth/login/images/logo_min.png"/>
	<style>
		.mini-textbox-input{
			height:22px !important;
		}
		
		.login-item{
			height: 25px;
		}
		.input1{
			bottom: 15px;
		}
		.input2{
			bottom: 45px;
		}
		#mscnCode .mini-textbox-border{
			width:81% !important;
		}
		::-ms-reveal{display:none;}
		.contact{
			color:red;
		}
	</style>
</head>
<%
	String original_url=null;
	Object objAttr=request.getAttribute("original_url");
	if(objAttr != null){
		original_url=StringUtil.htmlFilter((String)objAttr);
	}
 %>

<body class="login">

<div id="warpper" class="wrap">
		<div class="main">
			<div id="form1" class="login-box">
				<!--登录框-->
	            <div id="ie9-filter" class="login-box2">
					<span class="icon_logo">
						<img src="<%=contextPath %>/coframe/auth/login/images/logo.png" alt=""/>
					</span>
					<h3>欢迎使用综合服务平台</h3>
					<form method="post"	name="loginForm" onsubmit="return login();" action="<%=url%>">
						<input class="nui-hidden" id="vcIpAddress" name="paramObj/vcIpAddress"/>
						<p class="login-item">
						  <em>用户名：</em>
						  <input class="nui-textbox" id="userId" name="userId" style="width:220px;height:26px;" onenter="keyboardLogin"
						   		 onvalidation="onCheckUserId" onblur="userBlur()"/>
						</p>
						<p class="login-item">
						  <em>密　码：</em>
						  <input class="nui-password" id="password"  name="password" vtype="minLength:6" minLengthErrorText="密码不能少于6个字符"
				           		 style="width:220px;height:26px;" onvalidation="onCheckPassword" 
				          		 autocomplete="off" onenter="keyboardLogin"/>
						</p>
						<!--图片验证码  style="display: none;" -->
						<p class="login-item" id="VerifyCode" style="display: none;">
							<em>验证码：</em>
							<input  class="nui-textbox" name="inputCode" style="height:26px;width:120px;" id="inputCode" onblur="onCheckValidateCode" onenter="keyboardLogin" />
							<img src="<%=request.getContextPath() %>/VerifyCodeServlet" id="VerifyCodeServlet" align="middle" style="margin-top: 0px;"
								title="看不清，请点我"  onclick="javascript:refresh();" onmouseover="mouseover(this)"/>
							<a href="#" onclick="javascript:refresh()">换一张</a> 
						</p>
						<!--短信验证码  -->
						<p class="login-item" id="msncCode" style="display: none;">
							<em>验证码：</em>
							<input class="nui-textbox" id="mscnCode" name="mscnCode" style="height:26px;width:120px;"  onvalidation="onCheckMscnCode" />
							
							
							<input class="inputCode" id="getInputCode" onclick="getUserMscnCode()" type="button" value="获取验证码" style="border: 1px solid #7ea2a6;border-radius: 4px;font-size: 9pt;height: 24px;"/>
							
							
						</p>
						<p id="error" class="login-error" style="display:inline-block;height:20px;color:red;margin-top: 0px;"></p>
						<p class="login-btn center">
							<input class="log" id="login1" type="button" value="登 &nbsp;&nbsp;&nbsp录" style=""/>
						</p>
					</form>
				</div>
			</div>
		</div>
		<div class="foot">
			<p>(c) Copyright 创金合信基金管理有限公司 2015-2018. All Rights Reserved. 服务热线：<span class="contact">0755-82820143 / 0755-23838959 </span></p>
		</div>
	</div>

<!-- 使用搜狐接口获取用户的IP地址 -->
<!-- <script src="http://pv.sohu.com/cityjson?ie=utf-8"></script> -->
<script src="<%=contextPath %>/JQMHistory/kindeditor/examples/jquery.js" type="text/javascript"></script>
<script src="<%=contextPath %>/coframe/auth/login/js/supersized.3.2.7.min.js"></script>
<script>
    
	jQuery(function($){
	    $.supersized({
	        // Functionality
	        slide_interval     : 4000,
	        transition         : 1,    
	        transition_speed   : 1000,
	        performance        : 1,  
	
	        // Size & Position
	        min_width          : 0,  
	        min_height         : 0, 
	        vertical_center    : 1,  
	        horizontal_center  : 1, 
	        fit_always         : 0,  
	        fit_portrait       : 1,
	        fit_landscape      : 0, 
	
	        // Components
	        slide_links        : 'blank', 
	        slides             : [  
	                                 {image : '<%=contextPath %>/coframe/auth/login/images/backgroundImages/1.jpg'},
	                                 {image : '<%=contextPath %>/coframe/auth/login/images/backgroundImages/2.jpg'},
	                                 {image : '<%=contextPath %>/coframe/auth/login/images/backgroundImages/3.jpg'}
	                             ]
	
	    });
	
	});
	//session超时提醒 杨敏嵌入2016-11-14
	var loginMsg="<%=request.getAttribute("loginMsg") %>";
	if(loginMsg!="" && loginMsg!="null" && loginMsg!=null){
		nui.alert(loginMsg);
	}
	
     if(window.top!=window){
		window.top.location = window.location;
	 }
     nui.parse();
  
     var form = new nui.Form("#form1");
     
     nui.get("userId").focus();
     
     function onCheckUserId(e){
       if (e.isValid) {
         if(e.value==""){
           e.errorText = "用户名不能为空";
           e.isValid = false;
         }
         //var ret = /\s/;
         //if(ret.test(e.value)){
         //	e.errorText = "用户名不能包含空格，请重新输入";
         //	e.isValid = false;
         //}
       }
     }
     var status=0;//还未判断是否开启
     /*输入用户名后，判断是否显示验证码*/
     function userBlur(){
     	var userId = nui.get("userId").getValue();
	 	if(userId!=""){
	 		nui.ajax({
			url : "org.gocom.components.coframe.auth.LoginManager.checkMscnStatus.biz.ext",
			type : 'POST',
			data:{userId:userId},
			cache : false,
			async : false,
			contentType : 'text/json',
			success : function(text) {
				var returnJson = nui.decode(text);				
	        	if(returnJson.ret == "0"){
	        		//显示短信验证码
	        		document.getElementById("msncCode").style.display="block";
	  	  			document.getElementById("login1").style.bottom = "15px";
	  	  			status=1;//开启验证码
	        	}else{
	        		status=2;//不开启
	        	}
			}
		});	
	 	}
	 };
     function onCheckPassword(e){
       if (e.isValid) {
         if(e.value==""){
           e.errorText = "密码不能为空";
           e.isValid = false;
         }
         //var ret = /\s/;
         //if(ret.test(e.value)){
        // 	e.errorText = "密码不能包含空格，请重新输入";
         //	e.isValid = false;
        // }
       }
     }
     function onCheckMscnCode(e){
       if (e.isValid) {
         if(e.value==""){
           nui.alert("验证码不能为空~");
           //e.isValid = false;
           //$(".mini-errorIcon").style.display="none";
         }
         
         //var ret = /\s/;
         //if(ret.test(e.value)){
         //	e.errorText = "用户名不能包含空格，请重新输入";
         //	e.isValid = false;
         //}
       }
     }
     function getUserMscnCode(){
     	if(num!=0){return;}
     	var userId = nui.get("userId").getValue();
     	if(userId=="" || userId==null){
     		nui.alert("登录用户名不能为空~");
     		return;
     	}
     	num=60;
		textTime(); 
 		nui.ajax({
			url : "org.gocom.components.coframe.auth.LoginManager.getUserMscnCode.biz.ext",
			type : 'POST',
			data:{userId:userId},
			cache : false,
			async : false,
			contentType : 'text/json',
			success : function(text) {
				var returnJson = nui.decode(text);				
	        	if(returnJson.msgCode == "0"){
	        		nui.alert("验证码已经发送到号码为["+returnJson.emp.otel+"]的手机上。");
	        		//$("#getInputCode").html("");
	        		/*num=60;
	        		textTime(); */
	        		/*setTimeout(function(){ 
 						textTime(); 
 					},1000); */
	        	}else{
	        		nui.alert("验证码获取失败，请联系管理员。");
	        	}
			}
		});	
     
     }
     var num=0;
     function textTime(){
     	if(num<1){
     		$("#getInputCode").val ("获取验证码");
     		return;
     	}
     	num--;
     	$("#getInputCode").val(num+"秒后重新获取");
     	setTimeout(function(){ 
 			textTime(); 
 		},1000); 
     }
     
     
     function onCheckValidateCode(e){
     	var  VerifyCodeServlet = nui.get("inputCode").getValue();
     	if(VerifyCodeServlet == ""){
     		nui.alert("验证码不能为空");
           	return false;
     	}else{
     		nui.ajax({
				url : "org.gocom.components.coframe.auth.LoginManager.getValidateCode.biz.ext",
				type : 'POST',
				cache : false,
				async : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);				
		        	if(returnJson.validateCode != VerifyCodeServlet.toUpperCase()){
		        		nui.alert("验证码错误，请重新输入。");
		        		return false;
		        	}
				}
			});	
     	}
     	return true;
     }
     <% 
     	Object result = request.getAttribute("result");
     	String userName = (String)request.getAttribute("userId");
     	if (userName==null)userName="";
     	String password = (String)request.getAttribute("password");
     	if (password==null)password="";
     	UserText users = VerifyCodeServlet.userMap.get(userName);
     	int indexCount = 0;
     	if(users == null){
     		users = new UserText(userName,indexCount,new Date());
     		//users.setString("IP", ApplicationContext.getInstance().get);
     	}else{
     		indexCount = users.getIndexCount();
     	}
     	
     	if(result != null){
     		Integer resultCode = (Integer)result;
     		 if(resultCode == 0){
		     	out.println("showError('密码错误！')");
		     }else if(resultCode == -1){
		     	out.println("showError('用户不存在！')");
		     }else if(resultCode == -2){
		     	out.println("showError('用户无权限登录，请联系系统管理员！')");
		     }else if(resultCode == 3){
		     	out.println("showError('用户已过期！')");
		     }else if(resultCode == 4){
		     	out.println("showError('用户未到开始使用时间！')");
		     }else if(resultCode == 5){
		     	out.println("showError('密码已过期！')");
		     }else if(resultCode == -3){
      			out.println("showError('查询用户信息失败，请联系系统管理员检查数据库连接！')");
     		 }else if(resultCode == -8){
      			out.println("showError('短信验证码错误！')");
     		 }else{
      			out.println("showError('未知的异常，请联系系统管理员！')");
     		 }
			indexCount = indexCount + 1;
			users.setIndexCount(indexCount);
			VerifyCodeServlet.userMap.put(userName, users);
     	}
     	if(indexCount == 1){
			//启动线程池
			DaemonThread.removeNumberThread(userName);
		}
		
		boolean status = false;//new SendMsncService().getSendMsncStatus2();
	  %>
	  var indexCount = '<%=indexCount %>';
	  var showMscnCode = '<%=status %>';
	  //先使用短信验证码，当短信验证码未开启时，使用图片验证码
	  if(showMscnCode==true || showMscnCode=="true"){
	  	  document.getElementById("msncCode").style.display="block";
	  	  document.getElementById("login1").style.bottom = "15px";
	  }else{
	  	  if(indexCount >= 3){
	  	 	  document.getElementById("VerifyCode").style.display="block";
	  	 	  document.getElementById("login1").style.bottom = "15px";
		  }else{							   
		  	 document.getElementById("login1").style.bottom = "45px";
		  }
	  }
	  
	 /* if(indexCount >= 3){
	  	 document.getElementById("VerifyCode").style.display="block";
	  	 document.getElementById("login1").style.bottom = "15px";
	  }else{							   
	  	 document.getElementById("login1").style.bottom = "15px";
	  }*/
	  
      function showError(msg){
      	 $("#error").html(msg);
      }
      
      //获取键盘 Enter 键事件并响应登录
     function keyboardLogin(e){
       login();
     }
     $(function(){
 		var validateResult = "<%=result %>";
 		nui.get("userId").setValue("<%=userName %>");
 		nui.get("password").setValue("<%=password %>");
 	 });
 	 
	  	//判断验证码是否为空
     	jQuery(".log").click(function(){
     		login();
     	});
     
     function login(){
     	
     	//获取用户IP地址并设置到vcIpAddress变量
     	//var vcIpAddress = returnCitySN["cip"];
     	//nui.get("vcIpAddress").setValue(vcIpAddress);
     	
     	var form = new nui.Form("#form1");
        form.validate();
        if (form.isValid() == false){ 
        	return false;
        }
        if(status==0){
        	//还未判定过，需要判断
        	var userId = nui.get("userId").getValue();
		 	if(userId!=""){
		 		nui.ajax({
				url : "org.gocom.components.coframe.auth.LoginManager.checkMscnStatus.biz.ext",
				type : 'POST',
				data:{userId:userId},
				cache : false,
				async : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);				
		        	if(returnJson.ret == "0"){
		        		//nui.alert("");
		        		//显示短信验证码
		        		document.getElementById("msncCode").style.display="block";
		  	  			document.getElementById("login1").style.bottom = "15px";
		  	  			status=1;//开启验证码
		        	}else{
		        		status=2;//不开启
		        		//登录
				     	if(indexCount >= 3){
				      		if(onCheckValidateCode() == false) return;
				      	}
				        document.loginForm.submit();
		        	}
			  }
			  });	
		  }
      }else if(status==1){
        if(nui.get("mscnCode").getValue()==""){
     		return false;
     	}else{
     		//登录
	     	if(indexCount >= 3){
	      		if(onCheckValidateCode() == false) return;
	      	}
	        document.loginForm.submit();
     	}
     }else{
     	//登录
     	if(indexCount >= 3){
      		if(onCheckValidateCode() == false) return;
      	}
        document.loginForm.submit();
     }
       
     }  
     
     //刷新验证码
     function refresh(){
     	 var obj = document.getElementById("VerifyCodeServlet");
         obj.src = "<%=request.getContextPath() %>/VerifyCodeServlet?" + Math.random();  
     }  
          
     function mouseover(obj){  
         obj.style.cursor = "pointer";  
     }
</script>
 </body>
  <%
 	request.getSession().invalidate();
 	Cookie[] cookies = request.getCookies();
 	if(cookies != null){
 		for(int i=0;i<cookies.length;i++){
 			if(StringUtil.equals("jsessioinid", cookies[i].getName())){
 				cookies[i].setMaxAge(0);
 			}
 		}
 	
 	}
  %>
</html>
