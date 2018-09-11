<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="com.cjhxfund.ats.fm.commonUtil.DateUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp"%>
<!-- 
  - Author(s): heyi
  - Date: 2017-3-10 14:12:07
  - Description:Excel导入新增指令/建议
-->
<head>
<title>Excel导入新增指令/建议</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script type="text/javascript"
	src="<%=request.getContextPath() %>/fm/comm/fileupload/js/swfupload.js"></script>

</head>
<body>
	<%
	String replaceFileName = DateUtil.currentDateString(DateUtil.YMD_NUMBER);
 %>
	<div style="width: 100%; height: 100%;" id="dataform1"
		borderStyle="border:solid 1px #aaa;">
		<table style="height: 3px; vertical-align: middle;">
			<tr>
				<td style="width: 20px;" align="right">
					<div class="mini-button mini-button-disabled" enabled="false"
						iconCls="icon-edit"></div>
				</td>
				<td style="width: 150px;" align="left">
					<h4>Excel导入新增指令/建议</h4>
				</td>
			</tr>
		</table>
		<hr />
		<iframe id="prodIfm" name="prodIfmName" width="590" height="30px"
			frameborder="no" border="0" marginwidth="0" marginheight="0"
			scolling="no"></iframe>
		<!-- 动态获取表内容 -->
		<div class="description"
			style="margin-top: 10px; height: 440px; overflow: auto;">
			<table style="background-color: #f0f0f0; width: 100%;" border="0px">
				<tr>
					<td colspan="5">&nbsp;&nbsp;当前设置的导入模式：</td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Execl导入从当前工作表导入,支持(*.xls;*.xlsx)!</td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;&nbsp;发行人信息导入接口说明：</td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;&nbsp;文件格式：</td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EXCEL文件：*.xls
						创金自定义格式&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文件名：ATS_ZJMM_YYYYMMDD.xls</td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;&nbsp;数据库表：</td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ORACLE数据库表：ORACLE数据库表名&nbsp;&nbsp;&nbsp;&nbsp;
						表名：ZHFWPT_JY_ZQMM</td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;&nbsp;字段要求：</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;字段名称</td>
					<td>XLS</td>
					<td>是否必填</td>
					<td>说明</td>
				</tr>
				<tr style="width: 100%">
					<td colspan="5"><hr /></td>
				</tr>


				<tr>
					<td>&nbsp;&nbsp;产品编码</td>
					<td>第一列</td>
					<td>必填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;产品名称</td>
					<td>第二列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;组合名称</td>
					<td>第三列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;债券代码</td>
					<td>第四列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;债券名称</td>
					<td>第五列</td>
					<td>必填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;业务日期</td>
					<td>第六列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;业务类别</td>
					<td>第七列</td>
					<td>必填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;债券类别</td>
					<td>第八列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;债券评级</td>
					<td>第九列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;主体评级</td>
					<td>第十列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;清算速度</td>
					<td>第十一列</td>
					<td>必填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;清算类型</td>
					<td>第十二列</td>
					<td>必填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;交易场所</td>
					<td>第十三列</td>
					<td>必填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;券面金额（万元）</td>
					<td>第十四列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;交易对手</td>
					<td>第十五列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;净价（元/百元面值）</td>
					<td>第十六列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;全价（元/百元面值）</td>
					<td>第十七列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;收益率类型</td>
					<td>第十八列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;收益率（%）</td>
					<td>第十九列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;交易员代码</td>
					<td>第二十列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;席位号</td>
					<td>第二十一列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;约定号</td>
					<td>第二十二列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;备注</td>
					<td>第二十三列</td>
					<td>可填</td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;截止日期</td>
					<td>第二十四列</td>
					<td>可填</td>
					<td></td>
				</tr>

				<tr style="width: 100%">
					<td colspan="5"><hr /></td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;&nbsp;注意：</td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;&nbsp;1.EXCEL文件以【XLS】对应的字段顺序匹配。</td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;&nbsp;2.EXCEL文件第一行：字段名称不能为空，第二行开始：具体数据。</td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;&nbsp;3.EXCEL文件数据中间不能有【空行】。</td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;&nbsp;4.对于必填字段，要求必需填写，否则导入当条数据失败；</td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;&nbsp;5.对于可填字段，当导入新增记录时，如果不填，将按说明信息中默认值代替；</td>
				</tr>
				<tr>
					<td colspan="5">&nbsp;&nbsp;</td>
					<td></td>
				</tr>
			</table>
		</div>

	</div>

	<div id="footer" class="nui-toolbar" style="padding: 0px; width: 100%;"
		borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align: center;">
					<span style="display: inline-block; width: 25px;"></span>
					<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
						取消 </a>
				</td>
			</tr>
		</table>
	</div>

	<script type="text/javascript">
		nui.parse();
		var form = new nui.Form("#dataform1");
		$("#prodIfm").attr("src","<%=request.getContextPath() %>/fm/comm/fileupload/singleFileUpload.jsp");
		var templetDownload = "onUpload";
		var func = "onUploadSuccess";
		var startUploadfunc = "startUpload";
	    var UpSuccessBizParm=new Array();//params中按顺序给 逻辑流参数赋值.所以 Fdata 参数必须在回调逻辑流的第一位，其他参数必须按照数组顺序赋值，否则会出现赋值混乱，可为空
		UpSuccessBizParm[0]='<%=operatorId %>';
		var UpSuccessBiz="com.cjhxfund.jy.excelUploadAdd.excelUpload.excelUploadForJQM";//获取Excel数据，并且将数据保存至数据库
		
	    function onUploadSuccess(e) {
	    var returnJson = nui.decode(e);
	      if(e.result==null){
	      	nui.alert("导入失败,请检查数据！");
	      }else{
	      	var msglist = e.result[0];//msglist

	       if(nui.decode(msglist)){
	    		mini.open({
						    url:"<%=request.getContextPath() %>/ProductProcess/ExcelUploadAdd/resultExcelUpload.jsp",
						    title: "导入返回的结果信息", width: 500, height: 500,
						    overflow:"hidden",
						    onload: function () {
						        var iframe = this.getIFrameEl();
						        iframe.contentWindow.SetData({msgList:msglist});
						    },
						     ondestroy: function (action) {	
						  		prodIfmName.window.clearFileupload();
					  		} 
						});
					}
	      	}
	    }
	    
	    function onUploadError(e) {
	         nui.alert("上传失败：" + e.serverData);
	    }
	
	    function startUpload(fileupload) {
				fileupload.setPostParam({userid:'<%=operatorId %>'});
	         var excelName = fileupload.text;
	         if(excelName == ""){
		         form.unmask();
		         nui.alert("请选择一个导入文件！", "", function(){});
		         return false;
	         }
	         
		if(excelName.substr(0,9) != "ATS_ZJMM_"){
	             form.unmask();
	             nui.alert("excel名称不是ATS_ZJMM_YYYYMMDD格式，请修改！", "", function(){});
		         return;
	         } 
	         
	        var uploadName = excelName.substr(0,17);
	         
	         var tempName = excelName.substr(0,9);/* 去掉后缀名后和真正日期的文件对比  ATS_ZJMM_YYYYMMDD*/
	         var relName = tempName+'<%=replaceFileName %>';
	         
		    if(uploadName != relName){
		      form.unmask();
		      nui.alert("文件名称必须为"+relName+"!", "", function(){});
	      	  return;
	     }
	        return true;
	    }
	    
	    function onUpload(){
	        window.location.href = "com.cjhxfund.jy.excelUploadAdd.excelUploadForJQM.flow";
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