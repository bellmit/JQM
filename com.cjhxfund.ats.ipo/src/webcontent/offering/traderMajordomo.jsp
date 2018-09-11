<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): zhangyao
  - Date: 2016-12-06 16:13:30
  - Description:
-->
<head>
	<title>交易总监（确认）</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="css/offeringStyle.css"/>
    <style>
    	.info_name{
    		width:145px;
    	}
    </style>
</head>
<%
    String processInstID = request.getParameter("processInstID");
	String workItemID = request.getParameter("workItemID");
	String vcExchangeNo=request.getParameter("vcExchangeNo");
	String vcType=request.getParameter("vcType");
 %>
<body>
<div id="tabs" class="nui-tabs" height="100%">
	<div title="交易总监确认" class="content">
        <div class="main">
            <!--表单-->
            <form id="form1" method="post" >
            	<!-- 基础信息 -->
            	<input name="processInstID" id="processInstID" class="nui-hidden" value="<%=processInstID %>"/>
            	<input name="workItemID" id="workItemID" class="nui-hidden" value="<%=workItemID %>"/>
            	<input id="vcExchangeNo" name="vcExchangeNo" class="nui-hidden" value="<%=vcExchangeNo %>" />
            	<input id="lInstructNo" name="ipoInstructInfo.lInstructNo" class="nui-hidden" />
            	<input id="vcType" name="vcType" class="nui-hidden" value="<%=vcType %>"/>
            	<%@include file="/ipo/offering/common/common_basicInfo.jsp" %>
	        </form>
	        <!--撑满页面-->
			<div class="nui-fit" >
	            <!--表格-->
	            <%@include file="/ipo/offering/common/common_product_instruct.jsp" %>
	        </div>
		</div>	
    </div>
	<div title="审批内容" name="index">
		<%@include file="/ipo/task/processControl.jsp" %>
	</div>
	<div title="流程信息" url="/ats/sm/comm/task/processGraph.jsp?processInstID=<%=processInstID %>" ></div>
</div>
<script type="text/javascript" src="js/loadbasicInfo.js"></script>
<script type="text/javascript">
	var grid = nui.get("datagrid1");
	var data = {processInstID:processInstID,riskState:"00",participantType:"00"};
	grid.load(data);
	//grid.frozenColumns (0,4);
	//隐藏列
	(function (){
		var vcExchangeNo=nui.get("vcExchangeNo").value;
		grid.hideColumn (1);//复选框
		grid.hideColumn (12);
		grid.hideColumn (13);//关联检查不合规
		grid.hideColumn (14);//投资比例不合规
		if(vcExchangeNo=="04"){//03:沪市;04:深市
			grid.hideColumn (16);//对应上交所日均市值
			grid.hideColumn (19);//沪市股东账户
			grid.hideColumn (20);//上交所协会编码
		}else{
			grid.hideColumn (15);//对应深交所日均市值
			grid.hideColumn (17);//深圳席位号
			grid.hideColumn (18);//深交所配售对象编码
		}
	})();
    //提交流程
	function processSubmit(){
		nui.get("processSubmit").disable();
		nui.confirm("确认是否提交流程？","系统提示",function(action){
			if(action == "ok"){
				var processForm=new nui.Form("processForm");
				var data=processForm.getData();
				data["workItemID"]=workItemID;
				var approveData={approveParam:data};
				var json=nui.encode(approveData);
				nui.ajax({
			        url: "com.cjhxfund.ats.ipo.task.finishMyWork.biz.ext",
			        type: "post",
			        data: json,
			        contentType:'text/json',
			        success: function (text) {
		        	var returnJson = nui.decode(text);
			        	if(returnJson.exception == null){
			        		if(returnJson.rtnCode=="-1"){
			        			nui.alert("审批确认失败","系统提示");
			        			nui.get("processSubmit").enable();
			        		}else{
			        			nui.alert("审批确认成功","系统提示",function(){
			        				opener.location.reload();
									window.opener = null;
									window.open(' ', '_self', ' ');
									window.close();
			        			});
			        		}
			        	}else{
			        		nui.get("processSubmit").enable();
			        	}
	        		},
	        		ondestroy:function(action){
	        			nui.get("processSubmit").enable();
	        		},
	        		error:function(error){
	        			nui.get("processSubmit").enable();
	        		}
				});
			}else{
				nui.get("processSubmit").enable();
			}
		});
	}
</script>
</body>
</html>