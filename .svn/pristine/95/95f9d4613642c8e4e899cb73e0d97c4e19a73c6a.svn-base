<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@page import="java.util.List"%>  
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="java.util.ArrayList"%>  
<%@page import="com.cjhxfund.ats.fm.commonUtil.DateUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 翟静
  - Date: 2016-11-14 14:12:07
  - Description:
-->
<head>
<title>账户信息导入</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script type="text/javascript"
	src="<%=request.getContextPath() %>/fm/comm/fileupload/js/swfupload.js"></script>
	 
</head>
<body>
<%
	String replaceFileName = DateUtil.currentDateString(DateUtil.YMD_NUMBER);
 %>
 <div style="width:100%;height:100%; "  borderStyle="border:solid 1px #aaa;">
	<table style="height:3px;vertical-align: middle;">
		<tr>
			<td style="width:20px;"  align="right">
				<div class="mini-button mini-button-disabled" enabled="false" iconCls="icon-edit"></div>
			</td>
			<td style="width:150px;"  align="left">
				<h4>账户信息导入配置</h4>
			</td>
		</tr>
	 </table>
		<hr/>
	 <!-- <div style="height:10px;">
	<input class="nui-hidden" name="userId" value="sysadmin" />
		                 &nbsp;&nbsp;导入文件路径：
		     <input width="300px" id="fileupload1" class="mini-fileupload" name="Fdata"
			flashUrl="js/swfupload.swf" 
			limitType="*.xls;*.xlsx"
			uploadUrl="com.cjhxfund.ats.fm.baseinfo.ApplyTemplet.accountInfoUp.biz.ext" onuploadsuccess="onUploadSuccess"
			onuploaderror="onUploadError" onfileselect="onFileSelect" />
			 <a class="mini-button" iconCls="icon-download" plain="false" onclick="onUpload()">模板下载</a>
	  </div> -->
	  <iframe id="prodIfm" name="prodIfm" width="590"  height="30px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" ></iframe>
	  <!-- 动态获取表内容 -->
	<div class="description" style="margin-top:10px;margin-bottom:0px; height:450px;overflow: auto; ">
		 <table style="background-color:#f0f0f0; width:100%;" border="0px"  >
			 <tr><td colspan="5">&nbsp;&nbsp;当前设置的导入模式：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Execl导入从当前工作表导入,支持(*.xls;*.xlsx)!</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;账户信息导入接口说明：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;文件格式：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EXCEL文件：*.xls  创金自定义格式&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文件名:ATS_ZHXX_YYYYMMDD.xls</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;数据库表：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ORACLE数据库表：ORACLE数据库表名&nbsp;&nbsp;&nbsp;&nbsp;表名：T_ATS_ACCOUNT_INFO</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;字段要求：</td></tr>
			 <tr>
				 <td>&nbsp;&nbsp;字段名称</td>
				 <td>XLS</td>
				 <td>是否必填</td>
				 <td>说明</td>
			 </tr>
			 <tr style="width:100%"><td colspan="5"><hr/></td></tr>
			
			
		     <tr>
		         <td>&nbsp;&nbsp;产品代码</td>
		         <td>第一列</td>
		         <td>必填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;产品名称</td>
		         <td>第二列</td>
		         <td>必填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;登记托管机构</td>
		         <td>第三列</td>
		         <td>可填</td>
		         <td>中央结算公司、上海清算所、上交所、深交所、其他</td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;账户类型</td>
		         <td>第四列</td>
		         <td>必填</td>
		         <td>证券账户、银行间、托管账户、其他</td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;账户名称</td>
		         <td>第五列</td>
		         <td>必填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;账户号码</td>
		         <td>第六列</td>
		         <td>必填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;托管劵商席位号(上海)</td>
		         <td>第七列</td>
		         <td>可填(当账户类型为证券账户时,托管券商席位号(上海)为必填)</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;托管劵商席位号(深圳)</td>
		         <td>第八列</td>
		         <td>可填(当账户类型为证券账户时,托管券商席位号(深圳)为必填)</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;托管所</td>
		         <td>第九列</td>
		         <td>可填(当账户类型为托管账户时,托管行为必填)</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;大额支付号</td>
		         <td>第十列</td>
		         <td>可填(当账户类型为托管账户时,大额支付号为必填)</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;资金账户</td>
		         <td>第十一列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;数据来源</td>
		         <td>第十二列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;状态</td>
		         <td>第十三列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;备注</td>
		         <td>第十一列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     
			 <tr style="width:100%"><td colspan="5"><hr/></td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;注意：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;1.EXCEL文件以【XLS】对应的字段顺序匹配。</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;2.EXCEL文件第一行：字段名称不能为空，第二行开始：具体数据。</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;3.EXCEL文件数据中间不能有【空行】。</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;4.对于必填字段，要求必需填写，否则导入当条数据失败。</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;5.对于可填字段，当导入新增记录时，如果不填，将按说明信息中默认值代替。</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;</td><td></td></tr>
			 
		 </table>
	 </div>

  </div>
 
	 <div id="footer" class="nui-toolbar" style="padding:0px; width:100%;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align:center;" >
					<!-- <a class='nui-button' plain='false' iconCls="icon-save" onclick="startUpload()">
                                                                        保存
					</a> -->
					
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
    	$("#prodIfm").attr("src","<%=request.getContextPath() %>/fm/comm/fileupload/singleFileUpload.jsp");
    	var templetDownload = "onUpload";
    	var func = "onUploadSuccess";
    	var startUploadfunc = "startUpload";
    var UpSuccessBizParm=new Array();//params中按顺序给 逻辑流参数赋值.所以 Fdata 参数必须在回调逻辑流的第一位，其他参数必须按照数组顺序赋值，否则会出现赋值混乱，可为空
	
	//UpSuccessBizParm[1]='zs';//user_name
	var UpSuccessBiz="com.cjhxfund.ats.fm.baseinfo.ApplyTemplet.accountInfoUp";//上传回调逻辑流全名称 逻辑流名称+逻辑构建全称，不可和回调函数名同时为空
    	
    function onFileSelect(e) {
        //alert("选择文件");
    }
    function onUploadSuccess(e) {
        //var data = e.serverData;
        //console.log(e);
       var msglist = e.result[0];
        if(nui.decode(msglist).exception){
          nui.alert("导入失败,请检查数据！", "", function(){});
          return;
        }
        if(nui.decode(msglist)){
        	mini.open({
					    url:"<%=request.getContextPath() %>/fm/baseinfo/fileupload/resultMsg.jsp",
					    title: "导入返回的结果信息", width: 700, height: 500,
					    overflow:"hidden",
					    onload: function () {
					        var iframe = this.getIFrameEl();
					        iframe.contentWindow.SetData({msgList:msglist});
					    },
					    ondestroy: function (action) {	
					  		prodIfm.window.clearFileupload();
				  		} 
					});
        }
    }
    
    
    function onUploadError(e) {
         alert("上传失败：" + e.serverData);
         //nui.decode(e.serverData);
    }

    function startUpload(fileupload) {
         //var fileupload = mini.get("fileupload1");

         var excelName = fileupload.text;
         if(excelName == ""){
	         nui.alert("请选择一个导入文件", "", function(){});
	         return;
         }
          if(excelName.substr(0,9) != "ATS_ZHXX_"){
             nui.alert("excel名称不是ATS_ZHXX_YYYYMMDD格式，请修改！", "", function(){});
	         return;
         }
         
         var upladName = excelName.substr(0,17);
         
         var tempName = excelName.substr(0,9);/* 去掉后缀名后和真正日期的文件对比  ATS_ZHXX_YYYYMMDD*/
         //真正日期
         /* var myDate = new Date();    
         var year = myDate.getFullYear().toString();
         var month = (myDate.getMonth() + 1).toString();  
         var day = myDate.getDate().toString();  
         var date = year+month+day;
         var relName = tempName+date; */
         var relName = tempName+'<%=replaceFileName %>';
	    if(upladName != relName){
	      nui.alert("文件名称必须为"+relName+"!", "", function(){});
      	  return;
     }
        //fileupload.startUpload();
        return true;
    }
    
    function onUpload(){
        window.location.href = "com.cjhxfund.ats.fm.baseinfo.exportFile.flow";
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