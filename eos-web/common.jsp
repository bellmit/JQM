<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>

<%@taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<%@taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<%@taglib uri="http://eos.primeton.com/tags/dict" prefix="d"%>

<%--
- Author(s): huangmizhi
- Date: 2016-09-12 09:03:30
- Description: 系统基础公共资源引用文件
--%>

<%
String uniTitle = "创金合信-综合服务平台";
String contextPath = request.getContextPath();
IMUODataContext muoContext = DataContextManager.current().getMUODataContext();
IUserObject userObject = muoContext.getUserObject();
String userId = "";
String userName = "";
String operatorId = "";
if (userObject != null) {
userId = (String)userObject.getAttributes().get("EXTEND_USER_ID");
userName = (String)userObject.getUserName();
operatorId = (String)userObject.getUserId();
}
%>

<title><%=uniTitle%></title>
<script type="text/javascript" src="<%=contextPath%>/common/js/function.js"></script>
<script type="text/javascript" src="<%=contextPath%>/common/nui/nui.js"></script>
<script type="text/javascript" src="<%=contextPath%>/common/nui/locale/zh_CN.js"></script>
<link id="css_skin" rel="stylesheet" type="text/css" href="<%=contextPath%>/coframe/tools/skins/skin1/css/style.css"/>
<link id="css_icon" rel="stylesheet" type="text/css" href="<%=contextPath%>/coframe/tools/icons/icon.css"/>

<script type="text/javascript">
    (function(){
        nui.context = '<%=contextPath %>';
        nui.ATS_SUCCESS = "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS %>";
        nui.ATS_ERROR = "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>";
        nui.ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT = "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT%>";
        nui.ATS_ORDER_NO_RCV_FR_O32 = "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_NO_RCV_FR_O32%>";
    })();
    var data = {};
    nui.DataTree.prototype.dataField = 'data';
    var userId = "<%=userId%>";
    var userName = "<%=userName%>";
    var operatorId = "<%=operatorId%>";

    //屏蔽按退格键(backspace)导致的页面回退到登录界面问题
    document.onkeydown = function(e){
        var ev = e || window.event; //获取event对象 
        var obj = ev.target || ev.srcElement; //获取事件源 
        var t = obj.type || obj.getAttribute('type'); //获取事件源类型 
        //获取作为判断条件的事件类型 
        var vReadOnly = obj.readOnly;
        var vDisabled = obj.disabled;
        //处理undefined值情况 
        vReadOnly = (vReadOnly == undefined) ? false : vReadOnly;
        vDisabled = (vDisabled == undefined) ? true : vDisabled;
        //当敲Backspace键时，事件源类型为密码或单行、多行文本的， 
        //并且readOnly属性为true或disabled属性为true的，则退格键失效 
        var flag1 = ev.keyCode == 8 && (t == "password" || t == "text" || t == "textarea") && (vReadOnly == true || vDisabled == true);
        //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效 
        var flag2 = ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea";
        //判断 
        if (flag2 || flag1) return false;
    };
    
    
    /*
	下载附件通过函数
	参数：path 为附件路径，必须带文件名和后缀
	*/
	var downfile = function(path){
		//截取文件名(带后缀)；主要用于保存时自动回填文件名
		var filename = path.substring(path.lastIndexOf("/")+1,path.length);
		//截取文件后缀；主要用于保存时确认文件类型
		var filetype = path.substring(path.lastIndexOf("\.")+1,path.length);
  			//由于下载页面的小脚本获取参数的方式是通过页面流获取的，所以这里调用下页面流(相当于调用下载页面的小脚本)
  			var fileurl = nui.context + "/com.cjhxfund.ats.fm.comm.filedown.flow";
  			//判断文件路径是否为空
  			if(path != undefined && path != ""){
 			fileurl += "?downloadFile="+path;
 		}else{
 			nui.alert("下载路径不存在，请联系管理员处理","系统提示");
 			return;
 		}
 		//判断文件名是否为空
 		if(filename != undefined && filename != ""){
 			fileurl += "&fileName="+filename;
 		}else{
 			nui.alert("文件名为空，请联系管理员处理","系统提示");
 			return;
 		}
 		//判断文件后缀是否为空
 		if(filetype != undefined && filetype != ""){
 			fileurl += "&filetype="+filetype;
 		}else{
 			nui.alert("文件类型为空，请联系管理员处理","系统提示");
 			return;
 		}
 		//执行小脚本实现下载功能
		window.location.href = fileurl;
	};
</script>