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
	<title>投资经理（确定价格）</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="css/offeringStyle.css"/>
</head>
<%
    String processInstID = request.getParameter("processInstID");
	String workItemID = request.getParameter("workItemID");
	String vcExchangeNo=request.getParameter("vcExchangeNo");
	String vcType=request.getParameter("vcType");
 %>

<body>
<div id="tabs" class="nui-tabs" height="100%">
	<div title="投资经理确定价格" class="content">
        <div class="main">
        	<form id="form1" method="post" >
        		<!--基本信息,定价信息-->
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
	            <%@include file="/ipo/offering/common/common_form_instruct.jsp" %>
	        </div>
		</div>	
    </div>
	<div title="审批内容" name="index">
		<%@include file="/ipo/task/processControl.jsp" %>
		<script type="text/javascript">
			$("#vcOperateType").attr("data","[{id: 1, text: '同意'}]");
		</script>
	</div>
	<div title="流程信息" url="/ats/sm/comm/task/processGraph.jsp?processInstID=<%=processInstID %>" ></div>
</div>
<script type="text/javascript" src="js/loadbasicInfo.js"></script>
<script type="text/javascript">
	var grid = nui.get("datagrid1");
	//判断深市or沪市
	(function (){
		var vcExchangeNo=nui.get("vcExchangeNo").value;
		if(vcExchangeNo=="04"){//03:沪市;04:深市
			grid.hideColumn (7);//对应上交所日均市值
		}else{
			grid.hideColumn (6);//对应深交所日均市值
		}
	})();
	//申报价格
	function enSuggestPrice(){
		var enSuggestPrice=nui.get("enSuggestPrice").getValue();
		return enSuggestPrice;
	}
	//提交流程
	function processSubmit(){
		nui.get("processSubmit").disable();
		nui.confirm("确认是否提交流程？","系统提示",function(action){
			if(action == "ok"){
				var processForm=new nui.Form("processForm");
				var data=processForm.getData();
				//var data={workItemID:workItemID};
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