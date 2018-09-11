<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="com.cjhxfund.ats.fm.commonUtil.DateUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<head>
<title>授权文件导入</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script type="text/javascript"
	src="<%=request.getContextPath() %>/fm/comm/fileupload/js/swfupload.js"></script>
</head>
<%
String lApplyInstId = request.getParameter("lApplyInstId"); 
String lBizId = request.getParameter("lBizId"); 
 %>
<body>

 <div style="width:100%;height:100%; "  id="dataform1" borderStyle="border:solid 1px #aaa;">
	<table style="height:3px;vertical-align: middle;">
		<tr>
			<td style="width:20px;"  align="right">
				<div class="mini-button mini-button-disabled" enabled="false" iconCls="icon-edit"></div>
			</td>
			<td style="width:150px;"  align="left">
				<h4>授权文件导入说明</h4>
			</td>
		</tr>
	 </table>
		<hr/>
	  <iframe id="prodIfm" name="prodIfmName" width="100%"  height="30px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" ></iframe>
	  <!-- 动态获取表内容 -->
	<div class="description" style="margin-top:10px; overflow: auto; ">
		 <table style="background-color:#f0f0f0; width:100%;" border="0px"  >
			 
			 
		 </table>
	 </div>

  </div>
 
	 <div id="footer" class="nui-toolbar" style="padding:0px; width:100%;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align:center;" >
					
					<span style="display:inline-block;width:25px;"></span>
					<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
                                                                          取消
					</a>
				</td>
			</tr>
		</table>
	</div>	
	  
	<script type="text/javascript">
    	nui.parse();
    	var form = new nui.Form("#dataform1");
    	$("#prodIfm").attr("src","<%=request.getContextPath() %>/fm/comm/fileupload/FileUpload.jsp");
    	var templetDownload = "onUpload";
    	var func = "onUploadSuccess";
    	var startUploadfunc = "startUpload";
    var UpSuccessBizParm=new Array();//params中按顺序给 逻辑流参数赋值.所以 Fdata 参数必须在回调逻辑流的第一位，其他参数必须按照数组顺序赋值，否则会出现赋值混乱，可为空
	UpSuccessBizParm[0]=<%=lApplyInstId %>;
	UpSuccessBizParm[1]=<%=lBizId %>;
	var UpSuccessBiz="com.cjhxfund.ats.fm.instr.firstGradePayment.updateApplyAuthStatus";//上传回调逻辑流全名称 逻辑流名称+逻辑构建全称，不可和回调函数名同时为空
    function onFileSelect(e) {
        //alert("选择文件");
    }
    function onUploadSuccess(e) {
    	form.unmask();
    	if(e.result==null){
      	nui.alert("导入失败,请检查数据！","提示",function(action){
      			if(action == "ok"){
      				onCancel();
      			}
      		});
      }else{
      	if(e.result[0] == "ok"){
      		nui.alert("导入成功！","提示",function(action){
      			if(action == "ok"){
      				onCancel();
      			}
      		});
      	}
      }
    }
    
    function onUploadError(e) {
         nui.alert("上传失败：" + e.serverData);
    }

    function startUpload(fileupload) {
         form.loading();//加载遮罩
         //var fileupload = mini.get("fileupload1");
         var excelName = fileupload.text;
         if(excelName == ""){
	         form.unmask();
	         nui.alert("请选择一个导入文件！", "", function(){});
	         return false;
         }
        fileupload.setPostParam({userid:'<%=operatorId %>'});
        return true;
    }
    function onUpload(){
    }
    
    function onCancel(){
           CloseWindow("cancel");
    }
         //关闭窗口
     function CloseWindow(action) {
        if (window.CloseOwnerWindow){
	        return window.CloseOwnerWindow(action);
        }
        else window.close();
    }
    </script>
</body>
</html>