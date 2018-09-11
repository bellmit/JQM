<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.primeton.cap.AppUserManager"%>
<html>
	<head>
		<!-- <script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.js"></script> -->
		<script type="text/javascript" src="<%=request.getContextPath()%>/common/nui/jquery/jquery-1.6.2.min.js"></script> 
	</head>
	<body style="width: 100%;height: 100%;position: absolute;margin: 0;">
		<iframe style="width:100%;height:100%;border-width: 0;" id="xxk_iframe" ></iframe>
	</body>
	<script>
		top.ats2_5_timer = 0;
		top.ats2_5_drawAllNum = function(){
			clearTimeout(top.ats2_5_timer);
			top.ats2_5_timer = setTimeout(function(){
				var tabHeaderArr = $(top.document).find("#center #mainTabs .mini-tab");
				for(var i=0;i<tabHeaderArr.length;i++){
					for(var prop in top.ats2_5_obj){
						if(tabHeaderArr[i].id == top.ats2_5_obj[prop].tabHeaderId){
							var tabHeaderTextDom = $(tabHeaderArr[i]).find(".mini-tab-text");
							tabHeaderTextDom.find("span.ats2_5_temp_tab_span").remove();
							tabHeaderTextDom.html(tabHeaderTextDom.text()+"<span class='ats2_5_temp_tab_span' style='color: red;'>"+top.ats2_5_obj[prop].num+"</span>");
						}
					}
				}
				top.ats2_5_drawAllNum();
			},500);
		}
		top.ats2_5_drawAllNum();
		
		//var prefix = "http://10.201.224.92:8080/default";
		//var prefix="http://10.211.16.13:8081/ats2_5";
		var prefix ="https://cjcwjy.cjhxfund.com/ats2_5";
		
		var fromsys = "atsv2";//atsv2 oms
		
		document.getElementById("xxk_iframe").src=prefix +"/common/ats_v2/xxkPage.jsp?fromsys="+fromsys;
		
		setInterval(function(){
			if(top.ats2_5_isXxkShow=="true"){
				$(top.document).find("#ats2_5_keepAlive").show();
			}else{
				$(top.document).find("#ats2_5_keepAlive").hide();
			}
		},1000);
	</script>
</html>