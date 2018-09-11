<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 童伟
  - Date: 2017-07-13 16:25:43
  - Description:
-->
<head>
<title>页面跳转</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>

	<script type="text/javascript">
		// 试用阶段，有使用权限的用户可以进到新债券买卖页面，没有试用权限用户进老页面
    	nui.parse();
    	nui.ajax({
	    	url : "com.cjhxfund.ats.sm.comm.PersonConfManage.queryMenuPermissionUsers.biz.ext",
	    	data : {trialFunCode:"ATS_IS_SM_TRIAL"},
	    	type : 'POST',
	    	contentType : 'text/json',
	    	success : function(text){
    			var returnJson = nui.decode(text);
	    		if (returnJson.exception == null) {
					var userIds = new Array();
					userIds = returnJson.userList;
					var trialInfo = returnJson.trialStatuInfo;
					if(trialInfo.length>0){
						trialInfo = trialInfo[0];
						// 0不启用，1启用
						if(trialInfo.paramValue == "1"){
							if (userIds.length>0) {
	    						// 跳转二级债新页面
	    						window.location.href="<%= request.getContextPath() %>/sm/comm/instruct/tansaction_instruct/transactionInstruct.jsp";
							}else{
			    				//跳转机器猫页面
			    				window.location.href="<%= request.getContextPath() %>/ProductProcess/JY_ZQMM/CFJYProductProcessList_ZQMM.jsp"; 
							}
						}else{
				    		window.location.href="<%= request.getContextPath() %>/ProductProcess/JY_ZQMM/CFJYProductProcessList_ZQMM.jsp"; 
						}
					}
				} else {
					nui.alert("系统异常", "系统提示");
				}
			}
		});
    </script>
</body>
</html>