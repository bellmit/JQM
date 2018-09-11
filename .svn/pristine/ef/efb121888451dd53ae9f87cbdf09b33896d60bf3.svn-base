<%@page import="com.cjhxfund.ats.fm.commonUtil.JDBCUtil"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): zhangyao
  - Date: 2016-12-06 16:13:30
  - Description:
-->
<%
 	long key = JDBCUtil.getNextSequence("SEQSTOCKISSUENO");
 	String processInstID = request.getParameter("processInstID");
	String workItemID = request.getParameter("workItemID");
	String bizId=request.getParameter("bizId");
	String vcType=request.getParameter("vcType");
  %>
<head>
	<title>研究员（提供研究报告）</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="css/offeringStyle.css"/>
</head>
<body>
<div id="tabs" class="nui-tabs" height="100%">
	<div title="提供研究报告输入价格"  class="content">
        <div class="main">
            <!--表单-->
            <form id="form1" method="post" >
            	<input name="processInstID" id="processInstID" class="nui-hidden" value="<%=processInstID %>"/>
            	<input name="workItemID" id="workItemID" class="nui-hidden" value="<%=workItemID %>"/>
            	<input id="bizId" name="bizId" class="nui-hidden" value="<%=bizId %>" />
            	<input id="lInstructNo" name="ipoInstructInfo.lInstructNo" class="nui-hidden" />
            	<input id="vcType" name="vcType" class="nui-hidden" value="<%=vcType %>"/>
            	<!-- 发行人 -->
				<ul class="form_list_name">
					<li>
				    	<span>发行人 :</span>
				   		<input name="ipoInstructInfo.vcIssuerName" class="nui-textbox input_width" readonly="true"/>
					</li>
					<li>
				    	<span>主承销商 :</span>
				    	<input name="ipoInstructInfo.vcLeadUnderwriterName" class="nui-textbox input_width" readonly="true"/>
				  	</li>
				</ul>
			 	<fieldset class="fieldset">
				<legend>&nbsp;&nbsp;基本信息 &nbsp;&nbsp;</legend>
				 	<ul class="form_list">
				    	<li>
				        	<span class="info_name">公司名称 :</span>
				   			<input name="ipoInstructInfo.vcCompanyName" class="nui-textbox" readonly="true"/>
				        </li>
				        <li>
				            <span class="info_name">申购代码 :</span>
				        	<input name="ipoInstructInfo.vcPurchaseCode" class="nui-textbox" readonly="true"/>
				        </li>
				        <li>
	                        <span class="info_name">申购建议价格(元)<em>*</em> :</span>
	                        <input id="enSuggestPrice" name="ipoInstructInfo.enSuggestPrice"  class="nui-textbox" emptyText="请输入申购建议价格" vtype="float;min:0;" onvalidation="onNumberValidation" required="true" onvaluechanged="countScale(this.value)"/>
	                    </li>
				        <li>
				        	<span class="info_name">发行数量(万股) :</span>
				        	<input name="ipoInstructInfo.enIssueNumber" class="nui-textbox" readonly="true"/>
				        </li>
				        <li>
				        	<span class="info_name">发行后总股本(万股) :</span>
				        	<input name="ipoInstructInfo.enTotalEquity" class="nui-textbox" readonly="true"/>
				        </li>
				        <li>
				            <span class="info_name">网下发行上限(万股) :</span>
				            <input name="ipoInstructInfo.enOfflineIssueUpperNumber" class="nui-textbox" readonly="true"/>
				        </li>
				        <li>   
	                        <span class="info_name">网下申购上限(万股) :</span>
	                        <input id="enOfflineUpperNumber" name="ipoInstructInfo.enOfflineUpperNumber" class="nui-textbox" readonly="true"/>
	                    </li>
				        <li>
				            <span class="info_name">网下申购下限(万股) :</span>
				            <input name="ipoInstructInfo.enOfflineUnderNumber" class="nui-textbox" readonly="true"/>
				        </li>
				        <li>
				        	<span class="info_name">网下申购规模(万元) :</span>
				        	<input id="enPurchaseScale" name="ipoInstructInfo.enPurchaseScale" class="nui-textbox prohibit_input" readonly="true"/>
				        </li>
				        <li>
				            <span class="info_name">申购步长 :</span>
				            <input name="ipoInstructInfo.enPurchaseSize" class="nui-textbox" readonly="true"/>
				        </li>
				        <li>
				            <span class="info_name">询价日 :</span>
				            <input id="lInquiryDate" name="ipoInstructInfo.lInquiryDate" class="nui-textbox" readonly="true"/>
				        </li>
				        <li>
				            <span class="info_name">网下申购日 :</span>
				            <input id="lOfflinePurchaseDate" name="ipoInstructInfo.lOfflinePurchaseDate" class="nui-textbox" readonly="true"/>
				        </li>
				        <li>
				            <span class="info_name">市值门槛(万元)  :</span>
				            <input name="ipoInstructInfo.enMarketValueThreshold" class="nui-textbox" readonly="true"/>
				        </li>
					</ul>
				</fieldset>
				<!--定价信息-->
				<fieldset class="fieldset">
				<legend>&nbsp;&nbsp;定价信息 &nbsp;&nbsp;</legend>
					<ul class="form_list">
						<li>
				        	<span class="info_name">预计获配率(%) :</span>
				   			<input id="enPredictDistributionRate" name="ipoInstructInfo.enPredictDistributionRate" class="nui-textbox" readonly="true"/>
						</li>
						<li>
						    <span class="info_name_type">行业类别 :</span>
						    <input name="ipoInstructInfo.vcWindIndustryType" class="nui-textbox input_width" readonly="true"/>
						</li>
					</ul>
				</fieldset>
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
            		<!--上传研究报告-->
            		<ul class="form_file">
	                    <li>
	                        <span class="info_name">研究报告 :</span>
	                    </li>
	                    <li>
							<iframe id="prodIfm" width="590"  height="179px" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" 
							 	src="<%=request.getContextPath() %>/ipo/offering/common/any_upload.jsp?workItemID=<%=workItemID %>&processInstID=<%=processInstID %>&attachType=1&attachBusType=6&bizId=<%=bizId %>" >
							 </iframe>
				            <!-- hidden域 -->
				            <input class="nui-hidden" id="lRaiseInstFile" name="debtIssue.lRaiseInstFile"/>
				            <input class="nui-hidden" id="lStockInvestNo" name="debtIssue.lStockInvestNo" value="<%=bizId%>"/>
			 				<input class="nui-hidden" id="lRateReportFile" name="debtIssue.lRateReportFile"/>
							<input class="nui-hidden" id="lBondIssueFile" name="debtIssue.lBondIssueFile"/>
						</li>
	                </ul>
    			</fieldset>
	        </form>
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
		
		/****
	    *
		* 函数名：countScale
		* 机   能： 计算网下申购规模（万元）=申购建议价格*网下发行上限(万股)
		* 输   入：value  当前对象
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
		function countScale(value){
			var scale=(value*nui.get("enOfflineUpperNumber").getValue()).toFixed(4);
			nui.get("enPurchaseScale").setValue(scale);
			if(nui.get("enPurchaseScale").getValue()=="NaN"){
				nui.get("enPurchaseScale").setValue("");
			}
		}
	
		/****
	    *
		* 函数名：processSubmit
		* 机   能： 流程提交函数
		* 输   入：无
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
	    function processSubmit(){
	    	nui.get("processSubmit").disable();
	    	var form = new nui.Form("#form1");
			form.setChanged(false);
			form.validate();
			if (form.isValid() == false){
				nui.alert("请先输入申购建议价格","系统提示");
				nui.get("processSubmit").enable();
				return;
			}
			nui.confirm("确认是否提交流程？","系统提示",function(action){
				if(action == "ok"){
					var processForm=new nui.Form("processForm");
					var data=processForm.getData();
					data["workItemID"]=workItemID;
					var stockForm= new nui.Form("#form1");
					var stockData=stockForm.getData();
					updatePurchasePrice(stockData.ipoInstructInfo);
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
		
		/****
	    *
		* 函数名：updatePurchasePrice
		* 机   能： 更新指令信息
		* 输   入：ipoInstructInfo   指令信息
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
		function updatePurchasePrice(ipoInstructInfo){
			var instructInfo={ipoInstructInfo:ipoInstructInfo};
			var json=nui.encode(instructInfo);
			nui.ajax({
		        url: "com.cjhxfund.ats.ipo.busOpr.updateInstructInfo.biz.ext",
		        type: "post",
		        data: json,
		        contentType:'text/json',
		        success: function (text) {
	        		
	    		}
			});
			
		}
		
		/****
	    *
		* 函数名：deleteFile
		* 机   能：删除数据库中附件表的的文件
		* 输   入：ids   文件ID
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
		function deleteFile(ids){
			var json = nui.encode({fileIds: ids});
			$.ajax({
		        url:'com.cjhxfund.ats.fm.baseinfo.attachInfoManager.deleteAttachInfos.biz.ext',
		        type:'POST',
		        data:json,
		        cache:false,
		        contentType:'text/json',
		        success:function(data){
		         	 var returnJson = nui.decode(data);
		             if(returnJson.returnValue == "ok"){
		              	CloseWindow("close");
		             }else{
		               nui.alert("附件删除失败！","系统提示",function(action){
		               
		               });
		             }
		    	 }
		     });
		
		}
	   //上载时，将附件表中的id传过来，放到隐藏表单中，直接保存到数据库
	   function initAttachId(attachBusType,serverData){
	       var fileID = serverData.trim();
	   	  if(attachBusType==1){     //lRaiseInstFile
	   	  	nui.get("lRaiseInstFile").setValue(fileID);
	   	  }else if(attachBusType==2){//lRateReportFile
	   	  	nui.get("lRateReportFile").setValue(fileID);
	   	  }else if(attachBusType==3){//lBondIssueFile
	   	  	nui.get("lBondIssueFile").setValue(fileID);
	   	  }
	   	  form.setChanged(true);
	   } 
	   //子页面删除文件之后，也删除父界面上的隐藏表单的值
	   function deleteFileByUpload(attachBusType){
	   	  if(attachBusType==1){     
	   	  	nui.get("lRaiseInstFile").setValue("");
	   	  }else if(attachBusType==2){//lRateReportFile
	   	  	nui.get("lRateReportFile").setValue("");
	   	  }else if(attachBusType==3){//lBondIssueFile
	   	  	nui.get("lBondIssueFile").setValue("");
	   	  }
	   }
	    //关闭窗口
	    /* function CloseWindow(action){
	      if(action=="close" && form.isChanged()){
	      	nui.confirm("数据已改变,确认退出?","系统提示",function(a){
	      		if(a=='ok'){
	      			deleteFilePreparation();
	      			CloseWindow("cance");
	      		}
	      	});
	       
	      }else if(window.CloseOwnerWindow) 
	        return window.CloseOwnerWindow(action);
	      else
	        return window.close();
	    } */ 
	  	//输入数字验证
		function onNumberValidation(e){
			if (e.isValid) {
                if (isNumber(e.value) == false) {
                    e.errorText = "请输入正确的数字";
                    e.isValid = false;
                }
            }
        }
        function isNumber(v){
        	var r = /^(0|[1-9]\d*)(\.\d+)?$/;
            if (r.test(v)) return true;
            return false;
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