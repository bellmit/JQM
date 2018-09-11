<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="com.cjhxfund.ats.fm.commonUtil.DateUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<head>
<title>用印文件导入</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script type="text/javascript"
	src="<%=request.getContextPath() %>/fm/comm/fileupload/js/swfupload.js"></script>
	 
</head>
<body>

 <div style="width:100%;height:100%; "  id="dataform1" borderStyle="border:solid 1px #aaa;">
	<table style="height:3px;vertical-align: middle;">
		<tr>
			<td style="width:20px;"  align="right">
				<div class="mini-button mini-button-disabled" enabled="false" iconCls="icon-edit"></div>
			</td>
			<td style="width:150px;"  align="left">
				<h4>用印文件导入说明</h4>
			</td>
		</tr>
	 </table>
		<hr/>
	  <iframe id="prodIfm" name="prodIfmName" width="100%"  height="30px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" ></iframe>
	  <!-- 动态获取表内容 -->
	<div class="description" style="margin-top:10px; overflow: auto; ">
		 <table style="background-color:#f0f0f0; width:100%;" border="0px"  >
			 <tr><td colspan="5">&nbsp;&nbsp;用印文件名称格式：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;公司简称+日期(yyyy年mm月dd日)+产品代码(6位)+估值表</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如"建信基金2017年05月12日JX0344估值表"</td></tr>
			 
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
    	$("#prodIfm").attr("src","<%=request.getContextPath() %>/ProductProcess/fileupload/singleFileUpload.jsp");
    	var templetDownload = "onUpload";
    	var func = "onUploadSuccess";
    	var startUploadfunc = "startUpload";
    var UpSuccessBizParm=new Array();//params中按顺序给 逻辑流参数赋值.所以 Fdata 参数必须在回调逻辑流的第一位，其他参数必须按照数组顺序赋值，否则会出现赋值混乱，可为空
	UpSuccessBizParm[0]='<%=operatorId %>';
	UpSuccessBizParm[1]="yy";
	//UpSuccessBizParm[1]='zs';//user_name
	var UpSuccessBiz="com.cjhxfund.jy.excelUploadAdd.excelUpload.insertMOMFail";//上传回调逻辑流全名称 逻辑流名称+逻辑构建全称，不可和回调函数名同时为空
    function onFileSelect(e) {
        //alert("选择文件");
    }
    function onUploadSuccess(e) {
    	if(e.result==null){
      	form.unmask();
      	nui.alert("导入失败,请检查数据！","提示",function(action){
      			if(action == "ok"){
      				onCancel();
      			}
      		});
      }else{
      	if(e.result[0] == "ok"){
      		form.unmask();
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
         excelName = excelName.substr(0,excelName.lastIndexOf('.'));
         if(excelName.substr(excelName.length-3,3) != "估值表"){
         	 form.unmask();
             nui.alert("文件名称不是正确格式，请修改！", "", function(){});
	         return;
         }
         var reg = new RegExp("^[A-Za-z0-9]+$");
         if(!reg.test(excelName.substr(excelName.length-9,6))){
         	 form.unmask();
             nui.alert("文件名称不是正确格式，请修改！", "", function(){});
	         return;
         }
         if(excelName.substr(excelName.length-20,11) != ""){
         	var bdata = excelName.substr(excelName.length-20,11);
         	 if(!bdata.length==11){
         	 		 form.unmask();
		             nui.alert("文件名称不是正确格式，请修改！", "", function(){});
			         return;	         	
         	 }else{
         	 	 var reg1 = new RegExp("^[0-9]*$");
         	 	 var year = bdata.substr(0,4);
	         	 var mm = bdata.substr(5,2);
	         	 var dd = bdata.substr(8,2);
	         	 if(!reg1.test(year+mm+dd)){
		         	 form.unmask();
		             nui.alert("excel名称不是正确格式，请修改！", "", function(){});
			         return;
         	 	}
    		}
        }
        fileupload.setPostParam({userid:'<%=operatorId %>'});
        return true;
    }
    
    function onUpload(){
        window.location.href = "com.cjhxfund.jy.excelUploadAdd.importMOMFile.flow";
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