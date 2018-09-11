<%@page import="java.util.Date"%>
<%@page import="java.security.MessageDigest"%>
<%@ page language="java" pageEncoding="UTF-8"%> 
<%
	/* class Md5Util {
		public String encode(String str) {
			try {
		        //确定计算方法
		        MessageDigest md5 = MessageDigest.getInstance("MD5");
		        //加密后的字符串
		        byte[] byteArray = str.getBytes("UTF-8");
	        	byte[] md5Bytes = md5.digest(byteArray);
	        	StringBuffer hexValue = new StringBuffer();
		        for (int i = 0; i < md5Bytes.length; i++) {
		            int val = ((int) md5Bytes[i]) & 0xff;
		            if (val < 16) {
		                hexValue.append("0");
		            }
		            hexValue.append(Integer.toHexString(val));
		        }
		        return hexValue.toString();
	        } catch (Exception e) {
	        	e.printStackTrace();
	        }
	        return null;
	    }
	}
    
	String key = "dfk23f78sdf3";
    
	String sign = request.getParameter("sign");
	String time = request.getParameter("time");
    String curSign = new Md5Util().encode(key + time);
    if(time != null && curSign.equals(sign)) {
    	//判断是否超时
    	Long curDate = System.currentTimeMillis();
    	if(curDate - Long.valueOf(time) > 10 * 1000) {
	    	out.print("请求超时!!!");
	    	return;
    	}
    } else {
    	out.print("请求参数错误!!!");
    	return;
    } */
    
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String resid = request.getParameter("resid");
	String fillDate = request.getParameter("fillDate");
	String seriesAccount = request.getParameter("seriesAccount");
	String singeAccount = request.getParameter("singeAccount");
	String flag = "none";
	if(seriesAccount != null && !"".equals(seriesAccount)){
		flag = "one";
	}
	if(singeAccount != null && !"".equals(singeAccount)){
		flag = "two";
	}
	String userid = request.getParameter("userid");
	if(fillDate != null && !"".equals(fillDate)){
		fillDate.replaceAll("-", "").substring(0, 8);
	}
	
	System.out.println("fillDate-"+fillDate+"==resid-"+resid+"==seriesAccount-"+seriesAccount+"==singeAccount-"+singeAccount+"==userid-"+userid);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		 <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	</head>
	<script language = "JavaScript">
	//??javascript��???�ݡ�3?son?��?
	function toJSONString(obj) { 
		var m = {	'\b': '\\b',
							'\t': '\\t',
							'\n': '\\n',
							'\f': '\\f',
							'\r': '\\r',
							'"' : '\\"',
							'\\': '\\\\'	};
		var s = {
			array: function (x) {
				var a = ['['], b, f, i, l = x.length, v;
				for (i = 0; i < l; i += 1) {
					v = x[i];
					f = s[typeof v];
					if (f) {
						v = f(v);
						if (typeof v == 'string') {
							if (b) {
								a[a.length] = ',';
							}
							a[a.length] = v;
							b = true;
						}
					}
				}
				a[a.length] = ']';
				return a.join('');
			},
			'boolean': function (x) {
				return String(x);
			},
			'null': function (x) {
				return "null";
			},
			number: function (x) {
				return isFinite(x) ? String(x) : 'null';
			},
			object: function (x) {
				if (x) {
					if (x instanceof Array) {
						return s.array(x);
					}
					var a = ['{'], b, f, i, v;
					for (i in x) {
						v = x[i];
							f = s[typeof v];
							if (f) {
								v = f(v);
								if (typeof v == 'string') {
									if (b) {
										a[a.length] = ',';
									}
									a.push(s.string(i), ':', v);
									b = true;
								}
							}
						}
					a[a.length] = '}';
					return a.join('');
				}
				return 'null';
			},
			string: function (x) {
				if (/["\\\x00-\x1f]/.test(x)) {
					x = x.replace(/([\x00-\x1f\\"])/g, function(a, b) {
							var c = m[b];
							if (c) {
								return c;
							}
							c = b.charCodeAt();
							return '\\u00' + Math.floor(c / 16).toString(16) + (c % 16).toString(16);
					});
				}
        		return '"' + x + '"';
			}
		};
		return s[typeof obj](obj);
	} 
	function setParamInfo() {   
		var params = new Array();
		var param = new Object();  
		param.name = 'fillDate'; 
		param.value = '<%=fillDate%>' ; 
		params[0] = param;  		
		var param1 = new Object();  
		param1.name = 'usrID'; 
		param1.value = '<%=userid%>' ; 
		params[1] = param1; 
		
		var seriesAccount = '<%=seriesAccount%>';
		var singeAccount = '<%=singeAccount%>';
		
		var flag = '<%=flag%>';
		
		if(flag == 'two'){
			var param2 = new Object();  
			param2.name = 'single'; 
			param2.value = '1' ; 
			params[2] = param2; 
			
			var param3 = new Object();  
			param3.name = 'prodId'; 
			param3.value = '<%=singeAccount%>';
			params[3] = param3; 
			 
		}
		
		if(flag == 'one'){
			
			var param2 = new Object();  
			param2.name = 'single'; 
			param2.value = '2' ; 
			params[2] = param2; 
			
			var param3 = new Object();  
			param3.name = 'prodId'; 
			param3.value = '<%=seriesAccount%>';
			params[3] = param3; 
		}
		
		 
 
		document.getElementById('resid').value = '<%=resid%>';
		document.getElementById('paramsInfo').value = toJSONString(params);  
		var form1 = document.getElementById('form1');
		form1.submit();
		
	}
	</SCRIPT>
  <body onload="setParamInfo()">
    <FORM id="form1" name="form1" method="post" action="<%=basePath%>vision/openresource.jsp?user=admin&password=%25$*%5E@%25882095925D274459" > 
    	<INPUT id="resid" type="hidden" name="resid" size="40"><br> 
		<INPUT id="paramsInfo" type="hidden" name="paramsInfo">
    </FORM>
  </body>
</html>
