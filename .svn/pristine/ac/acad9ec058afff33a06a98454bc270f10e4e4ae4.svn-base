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
	<title>研究总监（确认）</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="css/offeringStyle.css"/>
</head>
<%
    String processInstID = request.getParameter("processInstID");
	String workItemID = request.getParameter("workItemID");
	String vcExchangeNo=request.getParameter("vcExchangeNo");
	String bizId=request.getParameter("bizId");
	String vcType=request.getParameter("vcType");
 %>
<body>
<div id="tabs" class="nui-tabs" height="100%">
	<div title="确认价格建议与研究报告" class="content">
        <div class="main">
            <!--表单-->
            <form id="form1" method="post" >
            	<!--基本信息-->
            	<input name="processInstID" id="processInstID" class="nui-hidden" value="<%=processInstID %>"/>
            	<input name="workItemID" id="workItemID" class="nui-hidden" value="<%=workItemID %>"/>
            	<input id="vcExchangeNo" name="vcExchangeNo" class="nui-hidden" value="<%=vcExchangeNo %>" />
            	<input id="bizId" name="bizId" class="nui-hidden" value="<%=bizId %>" />
            	<input class="nui-hidden" name="sysid" id="sysid" />
            	<input id="lInstructNo" name="ipoInstructInfo.lInstructNo" class="nui-hidden" />
            	<input id="vcType" name="vcType" class="nui-hidden" value="<%=vcType %>"/>
            	<%@include file="/ipo/offering/common/common_basicInfo.jsp" %>
	        	<!--操作-->
	        	<fieldset class="fieldset">
	            	<legend>&nbsp;&nbsp;操作 &nbsp;&nbsp;</legend>
			        <!--附件下载-->
	           		<ul class="form_file">
	                    <li>
	                        <span class="info_name">附件下载 :</span>
	                    </li>
	                    <li>
	           				<%@include file="/ipo/offering/common/fileDownload.jsp" %>
						</li>
	                </ul>
				</fieldset>
			</form>
		</div>	
    </div>
	<div title="审批内容" name="index">
		<%@include file="/ipo/task/processControl.jsp" %>
	</div>
	<div title="流程信息" url="/ats/sm/comm/task/processGraph.jsp?processInstID=<%=processInstID %>" ></div>
</div>
<form id="file_download" method="post">
	<!-- 数据实体的名称 -->
	<input type="hidden" name="processId" id="processId" value="<%=processInstID %>"/>
	<input class="nui-hidden" name="sysid"  id="sysid"/>
</form>
<script type="text/javascript" src="js/loadbasicInfo.js"></script>
<script type="text/javascript">
	var grid = nui.get("file_grid");
	var bizId=nui.get("bizId").getValue();
	var fileDate={bizId:bizId,bizType:6};
	grid.load(fileDate);
	//流程提交函数
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
    
	//附件列表批量下载附件
	function fileDownload1(){
		var  datas = nui.get("file_grid").getSelecteds();   //获取选中的附件信息
    	//组装附件编号
    	var sysId = "";
    	for(var i = 0;i < datas.length;i++){
    		if(sysId == ""){
    			sysId = datas[i].lAttachId;
    		}else{
    			sysId = sysId + "," +datas[i].lAttachId;
    		}
    	  nui.get("sysid").setValue(sysId);
    	}
    	if(sysId == ""){
    		nui.alert("请选择要下载的附件","系统提示");
    		return;
    	}
    	//下载附件
    	nui.confirm("确认要下载吗？","系统提示",function(action){
			if(action=="ok"){
				//nui.get("fileDownload").disable();//禁用“导出”按钮
				var form = document.getElementById("file_download");
				form.action = "com.cjhxfund.ats.fm.comm.fileDownload.flow";
		        form.submit();
		        //setTimeout("enableExportFun1()",15000);//启用“导出”按钮
			}
		});
    }	
</script>
</body>
</html>