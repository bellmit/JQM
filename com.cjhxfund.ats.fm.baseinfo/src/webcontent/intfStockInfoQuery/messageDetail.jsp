<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<%@include file="/common/js/commscripts.jsp" %>
<title>日志详情</title>
<script type="text/javascript" src="js/ZeroClipboard.js"></script>
<script language="JavaScript">
  var clip = null;  
  function $(id) { return document.getElementById(id); }  
  function init() {  
  	clip = new ZeroClipboard.Client();
  	clip.setHandCursor(true);  	
  	clip.addEventListener('mouseOver', function (client){
  		ZeroClipboard.setMoviePath('js/ZeroClipboard.swf');    
    	clip.setText( $('fe_text').value );
  	});
  	clip.addEventListener('complete', function (client, text) {   
    	nui.alert("复制成功。。 ");
  	});
  	clip.glue('clip_button', 'clip_container');
  }
	  function SetData(data){
		  document.getElementById("fe_text").innerText=data.vcMessage;
	  }
	  function onCancel() {
	      CloseWindow("cancel");
	  }
  
	function CloseWindow(action) {
      if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
      else window.close();
  }
    function mySelectAll(){
     document.getElementById("fe_text").focus();
     document.getElementById("fe_text").select();
     document.execCommand("copy");
  }
 
</script>
</head>

<body onLoad="init()">
<div style="width:100%; height:100%;">
	<div style="width:100%; height:90%;">
	  <textarea style="width:99.5%; height:100%;" id="fe_text" readonly="readonly"></textarea>
	</div>
	  <span id="clip_container">
	  	<button class='nui-button' plain='false' iconCls="icon-ok" id="mySelectAll" onclick="mySelectAll()">复制</button>
	  	<button class='nui-button' plain='false' id="colse" iconCls="icon-cancel" onclick="onCancel()">关闭</button>
	  </span>
</div>	    
</body>
</html>
