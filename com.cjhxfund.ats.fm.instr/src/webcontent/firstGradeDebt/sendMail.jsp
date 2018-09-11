<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 杨敏
  - Date: 2016-07-19 15:18:15
  - Description:
-->
<head>
<title>发送邮件</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%
    	String bizId = request.getParameter("bizId");   				//业务编号
    	String processinstid = request.getParameter("processInstID");   //流程Id
    	String workItemID = request.getParameter("workItemID");   		//工作项Id
     %>
	<style type="text/css">
	   .td{
	      border-bottom: 1px solid #D3D3D3;
	   }
	</style>
	<script src="<%= request.getContextPath() %>/fm/instr/processUtil/instr.js" type="text/javascript"></script>
	
</head>
<body style="width: 100%;height: 100%;overflow: hidden;">
	<!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
    <input name="pageType" class="nui-hidden" type="hidden"/>
	<div id="dataform1" style="padding-top:5px;">
		<input class="nui-hidden" name="applyInst.vcProductCode" id="vcProductCode" />
	    <table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">
			<tr>
			  <td width="15%" align="right">债券代码</td>
			  <td width="35%">
			  	<input class="nui-textbox" id="applyInst.vcStockCode" name="applyInst.vcStockCode" enabled="false" readonly="readonly" width="80%"/>
			  </td>
			  <td width="15%" colspan="1" width="15%" class="form_label" align="right">
				债券简称:
			  </td>
			  <td colspan="1" width="35%">
			  	<input class="nui-textbox" id="applyInst.vcStockName" name="applyInst.vcStockName" enabled="false" readonly="readonly" width="80%"/>
			  </td>
			</tr>
			<tr>
			  <td colspan="1" class="form_label" align="right">
				产品名称:
			  </td>
			  <td colspan="1">
			  
		  	<input id="productCombo" class="nui-textbox" name="applyInst.vcProductName"   readonly="readonly" width="80%"/> 
			  </td>
			  <td colspan="1" class="form_label" align="right">
				组合名称:
			  </td>
			  <td colspan="1">
			  <input  class="nui-textbox" id="vcCombiNo" name="applyInst.vcCombiName"   readonly="readonly" width="80%"/> 
			  </td>
			</tr>
			<!-- <tr>
			  <td colspan="1" class="form_label" align="right">
				登记托管机构:
			  </td>
			  <td colspan="1">
			  	<input class="nui-dictcombobox" name="applyInst.vcPaymentPlace" allowInput="true"
			  	 dictTypeId="CF_JY_DJTGCS" readonly="readonly"  enabled="false" emptyText="请选择"    showNullItem="false" width="80%" />
			  </td>
			</tr>
			<tr>
				<td colspan="1" class="form_label" align="right">
				主承销商:
				 </td>
				 <td colspan="3" colspan="1">
				   <input class="nui-textbox" name="stockissueinfo.vcMainUnderwriter" enabled="false" readonly="readonly" width="80%"/>
				 </td>
			</tr> -->
			
			
			<tr>
			  <td colspan="1" class="form_label td" align="right">
				邮件主题:
			  </td>
			  <td colspan="3" class="td">
			  	<input class="nui-textbox" name="bpsParam.title" id="title" width="80%" />
			  </td>
			 </tr>
			 <tr>
			  <td colspan="1" class="form_label td" align="right">
				<label style="color: red;">*</label>邮件主送:	
			  </td>
			  <td colspan="3" class="td">
			  	<input class="nui-textbox" name="bpsParam.mailTo" id="mailTo"  width="80%"/>
			  </td>
			</tr>
			<tr>
			  <td colspan="1" class="form_label td" align="right">
				邮件抄送:
			  </td>
			  <td colspan="3" class="td">
			  	<input class="nui-textbox" name="bpsParam.mailCc" id="mailCc" width="80%" />
			  </td>
			</tr>
			<tr>
			  <td colspan="1" class="form_label td" align="right">
				邮件正文:
			  </td>
			  <td colspan="3" class="td">
			  	<input class="nui-textarea" name="bpsParam.mailContext" id="mailContext" width="80%" height="60px"/>
			  </td>
			</tr>
			<tr>
				<td>附件上传:</td>
				<td colspan="3">
					<iframe id="prodIfm" width="100%" height="130px"  frameborder="no" border="0" marginwidth="0" marginheight="0"  src="<%= request.getContextPath() %>/fm/comm/fileupload/any_upload.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>&workItemID=<%=workItemID %>&attachType=1&attachBusType=1&type=1" ></iframe>  
				</td>
			</tr>
		</table>
		
		<input class="nui-hidden" type="hidden" id="bizId" name="bizId" value="1"/>
		 <div id="file_Form1">
			<input class="nui-hidden" name="map/bizId" id="map_bizId" value="<%=bizId %>"/>
			<input class="nui-hidden" name="map/attachBusType" value="1"/>
			<input class="nui-hidden" name="map/processinstid" id="map_processinstid" value="<%=processinstid %>"/>
		</div>
		 <div id="file_grid" class="mini-datagrid" style="width:100%;height:160px;" 
			 url="com.cjhxfund.ats.fm.comm.attachUitlFunction.queryAttachmentList.biz.ext" 
			 dataField="attachments"  showPageInfo="true" multiSelect="true" allowSortColumn="false">
			 <div property="columns">
				<div type="checkcolumn" width="20"></div>
				<div field="lAttachId"  headerAlign="center" visible="false">编号</div> 
				<div field="vcAttachName"  headerAlign="center" style="width: 70%;" allowSort="true">文件名</div> 
				<div field="workitemname"  headerAlign="center" allowSort="true" width="50" headerAlign="center">环节名称</div>
				<div field="vcAnnexSeal" type="checkboxcolumn" trueValue="1" falseValue="0" width="30" headerAlign="center">是否用印</div>               
				<div field="vcWhetherIndia" type="checkboxcolumn" trueValue="1" falseValue="0" width="40" headerAlign="center">是否用过印</div>
				<div field="cWhetherArchiving" type="checkboxcolumn" trueValue="1" falseValue="0" width="40" headerAlign="center">是否需要归档</div>			
			 </div>
		</div> 	 
	</div>
	<table width="100%">
		<tr>
			<td style="text-align:center;" colspan="4">
				<a class='nui-button' plain='false' iconCls="icon-save" onclick="sendmain()">
					发送邮件
				</a>
				<span style="display:inline-block;width:25px;"></span>
				<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
					取消
				</a>
			</td>
		</tr>
	</table>
	
		
	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid10");
    	var processInstID,activityDefID,workItemID,activityInstID;
    	//附件列表
		var file_grid = nui.get("file_grid");
		var file_Form = new nui.Form("#file_Form1").getData(false,false);
		
		
		var bizId;
		var processInstID;
		//跨页面参数传递参数
		function setFormData(data){
			//console.log(data);
    	    //跨页面传递的数据对象，克隆后才可以安全使用
	   		var infos = nui.clone(data);
	   		nui.get("bizId").setValue(infos.bizId);
	   		nui.get("map_bizId").setValue(infos.bizId);
	   		nui.get("map_processinstid").setValue(infos.processInstID);
	   		bizId=infos.bizId;
	   		processInstID=infos.processInstID;
	   		
			file_grid.load(file_Form);
			//查询流程当前待办工作项
			nui.ajax({
			    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadWorkItem.biz.ext",
			    type: "post",
			    data: {bizId:nui.get("bizId").getValue()},
			    dataType:"json",
			    success: function (text) {
			    	var returnJson = nui.decode(text);
					if(returnJson.workItems.length>0){
						processInstID = returnJson.workItems[0].processInstID;//流程实例id
						activityDefID = returnJson.workItems[0].activityDefID;//活动id
						workItemID = returnJson.workItems[0].workItemID;//工作项id
						activityInstID=returnJson.workItems[0].activityInstID;
						var form = new nui.Form("#dataform1");//将普通form转为nui的form
						//数据存入表单
			            form.setData(returnJson);
						form.setChanged(false);
						nui.get("title").setValue(returnJson.applyInst.vcProductName+"--"+returnJson.applyInst.vcStockName);
						//applyInst
						//判定是否包含ATS_FM_CZ,包含则工作项为非传真之前
						if(activityDefID.indexOf("ATS_FM_CZ")>=0 && activityDefID!="ATS_FM_CZ"){
							//nui.alert("已经传真过了，不能再修改，请确认！");
							//隐藏提交
							//$("#submit_button").css("display","none");
						}
						
					}else{
						nui.alert("网络错误，请重新打开页面！");
						//隐藏提交
						$("#submit_button").css("display","none");
					}
					
			    }
			});
	   		
    	}
		//刷新附件列表
	function refreshFile(){
		file_grid.load(file_Form);
	}
	//校验邮箱
	function checkEmail(str){
	    var re = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;;
	    if(re.test(str)){
	        return true;
	    }else{
	    	return false;
	    }
	}
	//获取选中的附件相关信息
    function FileSelectedsColumn(){
    	var  datas = nui.get("file_grid").getSelecteds();   //获取选中的附件信息
    	//组装附件名称
    	var sysId = "";
    	var vcAttachName= "";
    	var vcAttachAdd= "";
    	var lAttachId= "";
    	for(var i = 0;i < datas.length;i++){
    		if(i==0){
    			vcAttachName = datas[i].vcAttachName;//附件名称
    			vcAttachAdd = datas[i].vcAttachAdd;//附件路径
    			lAttachId = datas[i].lAttachId;//附件id
    		}else{
    			vcAttachName += "," +datas[i].vcAttachName;//附件名称
    			vcAttachAdd += "," +datas[i].vcAttachAdd;//附件路径
    			lAttachId += "," +datas[i].lAttachId;//附件id
    		}
    	}
    	//组装返回数据
    	sysId={'vcAttachName':vcAttachName,'vcAttachAdd':vcAttachAdd,'lAttachId':lAttachId};
    	return sysId;
    }
	//发送邮件
	function sendmain(){
		nui.get("mailTo").setValue($.trim(nui.get("mailTo").getValue()));//去空格处理
	    nui.get("mailCc").setValue($.trim(nui.get("mailCc").getValue()));//去空格处理
		var emailAddress=nui.get("mailTo").getValue()+";"+nui.get("mailCc").getValue();//邮件收件人
		var emails = emailAddress.split(";");
		if(emailAddress==";" || emails.length<0){
			nui.alert("邮件不能为空，请确认.","系统提示");
			return;
		}
		for(var i=0;i<emails.length;i++){
			//校验邮箱地址
			if(emails[i]!="" && checkEmail(emails[i])==false){
				nui.alert("邮件格式不正确，请确认.","系统提示");
				return;
			}
		}
		var title = nui.get("title").getValue();//邮件主题
		var mailTo = nui.get("mailTo").getValue();
		var mailCc = nui.get("mailCc").getValue();
		var mailContext = nui.get("mailContext").getValue();
		//获取选中的附件信息
		var mailInfo = FileSelectedsColumn();
        var vcAttachNames = mailInfo.vcAttachName;//附件名称
        var vcAttachAdds = mailInfo.vcAttachAdd;//附件路径
        var lAttachId = mailInfo.lAttachId;//附件id
        
        if(vcAttachNames == "" || vcAttachAdds == "" || lAttachId==""){
        	nui.alert("邮件附件不能为空，请勾选需要传真的附件。","系统提示");
        	return;
        }
        var sendmail="";//定义邮件发送实体
        sendmail={vcTitle:title,
		        vcMailTo:mailTo,
		        vcMailCc:mailCc,
		        vcMailContext:mailContext,
		        lAttachId:lAttachId,
		        vcAttachFilePath:vcAttachAdds,
		        vcAttachFileName:vcAttachNames,
		        lBizId:bizId,
		        lProcessInstId:processInstID};
        
             
        //发送邮件
		var json = nui.encode({sendmail:sendmail,mailContext:mailContext,title:title,mailTo:mailTo,mailCc:mailCc,vcAttachNames:vcAttachNames.split(","),vcAttachAdds:vcAttachAdds.split(","),lBizId:bizId,lProcessInstId:processInstID});
    	$.ajax({
    		url:"com.cjhxfund.ats.fm.instr.FirstGradeBond.sendMail.biz.ext",
    		type:'POST',
    		data:json,
    		cache:false,
    		contentType:'text/json',
    		success:function(text){
    			var returnJson = nui.decode(text);
    			if(returnJson.exception == null && returnJson.returnValue != "no"){
    				nui.alert("邮件已发送。","系统提示",function(action){});
	                 
    			}else{
    				nui.alert("邮件发送失败。", "系统提示", function(action){});
    			}
    		}
    	});
	}
	
		
		//关闭窗口
		function CloseWindow(action) {
			if (action == "close" && form.isChanged()) {
				if(confirm("数据被修改了，是否先保存？")) {
					saveData();
				}
			}
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else window.close();
		}
		
		//取消
		function onCancel() {
			CloseWindow("cancel");
		}
		var file_grid = nui.get("file_grid");    //获取附件列表对象
		//在线打开用印文档
	    file_grid.on("rowdblclick", function (e) {
	    	
	    	var type = 0;
	    	if(activityDefID == "ATS_FM_TBYY" || activityDefID == "ATS_FM_CZ_XYYY1" || activityDefID == "ATS_FM_CZ_XYYY2" || activityDefID == "ATS_FM_CZ_FXYYY"){
	    		type = 1;
	    	}
	    	var record = e.record;
	    	var vcProductCode = nui.get("vcProductCode").getValue(); //产品编号
	    	var lBizId = '<%=bizId %>';  //业务ID
	    	
	    	var actionURL = '<%= request.getContextPath() %>' + "/commonUtil/iWebOffice/Judgment_document_type.jsp?sysid="+record.lAttachId+"&fileName="+record.vcAttachName+"&type="+type+"&vcProductCode="+vcProductCode+"&bizId="+lBizId; //目标页面
	    	window.open(actionURL);
	    	/*
			var tabs = nui.get("tabs"); 
			
			//add tab 
	        var tab = {title: record.vcAttachName,url:actionURL,showCloseButton:true};
	        tab = tabs.addTab(tab);            
	
	        //active tab  
	        tabs.activeTab(tab);*/
		});	
    </script>
</body>
</html>