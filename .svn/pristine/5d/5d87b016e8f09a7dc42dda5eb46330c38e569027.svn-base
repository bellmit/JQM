<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
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
<title>新债信息导入</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script type="text/javascript"
	src="<%=request.getContextPath() %>/fm/comm/fileupload/js/swfupload.js"></script>
	 
</head>
<body>
<%
	String replaceFileName = DateUtil.currentDateString(DateUtil.YMD_NUMBER);
 %>
 <div style="width:100%;height:100%; "  id="dataform1" borderStyle="border:solid 1px #aaa;">
	<table style="height:3px;vertical-align: middle;">
		<tr>
			<td style="width:20px;"  align="right">
				<div class="mini-button mini-button-disabled" enabled="false" iconCls="icon-edit"></div>
			</td>
			<td style="width:150px;"  align="left">
				<h4>新债信息导入配置</h4>
			</td>
		</tr>
	 </table>
		<hr/>
	 <!-- <div style="height:10px;">
		                 &nbsp;&nbsp;导入文件路径：
		     <input width="300px" id="fileupload1" class="mini-fileupload" name="Fdata"
			flashUrl="js/swfupload.swf" 
			uploadUrl="com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager.debtIssueUpload.biz.ext" onuploadsuccess="onUploadSuccess"
			onuploaderror="onUploadError" onfileselect="onFileSelect" />
			 <a class="mini-button" iconCls="icon-download" plain="false" onclick="onUpload()">模板下载</a>
	  </div> -->
	  <iframe id="prodIfm" name="prodIfmName" width="590"  height="30px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" ></iframe>
	  <!-- 动态获取表内容 -->
	<div class="description" style="margin-top:10px; height:440px;overflow: auto; ">
		 <table style="background-color:#f0f0f0; width:100%;" border="0px"  >
			 <tr><td colspan="5">&nbsp;&nbsp;当前设置的导入模式：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Execl导入从当前工作表导入,支持(*.xls;*.xlsx)!</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;发行人信息导入接口说明：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;文件格式：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EXCEL文件：*.xls  创金自定义格式&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文件名：ATS_XZXX_YYYYMMDD.xls</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;数据库表：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ORACLE数据库表：ORACLE数据库表名&nbsp;&nbsp;&nbsp;&nbsp; 表名：T_ATS_STOCK_ISSUE_INFO</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;字段要求：</td></tr>
			 <tr>
				 <td>&nbsp;&nbsp;字段名称</td>
				 <td>XLS</td>
				 <td>是否必填</td>
				 <td>说明</td>
			 </tr>
			 <tr style="width:100%"><td colspan="5"><hr/></td></tr>
			
			
		     <tr>
		         <td>&nbsp;&nbsp;债券代码 </td>
		         <td>第一列</td>
		         <td>可填</td>
		         <td>为空自动生成</td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;债券简称</td>
		         <td>第二列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;债券全称 </td>
		         <td>第三列</td>
		         <td>必填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;债券类型 </td>
		         <td>第四列</td>
		         <td>必填</td>
		         <td>数据字典：债券类型</td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;登记托管机构 </td>
		         <td>第五列</td>
		         <td>必填</td>
		         <td>数据字典：登记托管场所 </td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;发行期限（年）</td>
		         <td>第六列</td>
		         <td>必填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;发行规模（亿）</td>
		         <td>第七列</td>
		         <td>必填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;债券评级 </td>
		         <td>第八列</td>
		         <td>可填</td>
		         <td>数据字典：信用评级</td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;债券评级机构</td>
		         <td>第九列</td>
		         <td>可填</td>
		         <td>数据字典：外部评级机构</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;主体简称</td>
		         <td>第十列</td>
		         <td>可填(新增发行主体时,主体简称必填)</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;发行主体全称</td>
		         <td>第十一列</td>
		         <td>必填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;主体类型</td>
		         <td>第十二列</td>
		         <td>可填(新增发行主体时,主体类型必填)</td>
		         <td>数据字典：主体类型</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;主体评级</td>
		         <td>第十三列</td>
		         <td>可填</td>
		         <td>数据字典：主体评级</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;主体评级机构</td>
		         <td>第十四列</td>
		         <td>可填</td>
		         <td>数据字典：外部评级机构</td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;所属行业</td>
		         <td>第十五列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;所属省份</td>
		         <td>第十六列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;担保人名称</td>
		         <td>第十七列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;担保人简介</td>
		         <td>第十八列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;公告日期</td>
		         <td>第十九列</td>
		         <td>可填</td>
		         <td>格式YYYYMMDD</td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;发行日期</td>
		         <td>第二十列</td>
		         <td>可填</td>
		         <td>格式YYYYMMDD</td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;缴款日期</td>
		         <td>第二十一列</td>
		         <td>可填</td>
		         <td>格式YYYYMMDD</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;上市日期</td>
		         <td>第二十二列</td>
		         <td>可填</td>
		         <td>格式YYYYMMDD</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;起息日期</td>
		         <td>第二十三列</td>
		         <td>可填</td>
		         <td>格式YYYYMMDD</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;到期日期</td>
		         <td>第二十四列</td>
		         <td>可填</td>
		         <td>格式YYYYMMDD</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;利率类型</td>
		         <td>第二十五列</td>
		         <td>可填</td>
		         <td>数据字典：利率形式</td>
		     </tr>  
		     <tr>
		         <td>&nbsp;&nbsp;息票品种</td>
		         <td>第二十六列</td>
		         <td>可填(息票品种为“一次还本付息券”或“贴现券”时,付息频率为“利随本清”！)</td>
		         <td>数据字典：息票品种</td>
		     </tr> 
		     <tr>
		         <td>&nbsp;&nbsp;付息频率</td>
		         <td>第二十七列</td>
		         <td>可填(付息频率为“利随本清”时,息票品种为“一次还本付息券”或“贴现券”！)</td>
		         <td>数据字典：付息频率ATS</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;票面利率</td>
		         <td>第二十八列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;招标方式</td>
		         <td>第二十九列</td>
		         <td>可填</td>
		         <td>数据字典：投标方式</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;缴款方式</td>
		         <td>第三十列</td>
		         <td>可填</td>
		         <td>数据字典：缴款方式 </td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;特殊条款</td>
		         <td>第三十一列</td>
		         <td>可填</td>
		         <td>数据字典：特殊条款</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;主承销商</td>
		         <td>第三十二列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;副主承销商</td>
		         <td>第三十三列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;承销方式</td>
		         <td>第三十四列</td>
		         <td>可填</td>
		         <td>承销方式</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;承销团</td>
		         <td>第三十五列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;下一行权日</td>
		         <td>第三十六列</td>
		         <td>可填</td>
		         <td>格式YYYYMMDD</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;是否具有回售权</td>
		         <td>第三十七列</td>
		         <td>可填</td>
		         <td>是、否</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;信用分析</td>
		         <td>第三十八列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;投标截止时间</td>
		         <td>第三十九列</td>
		         <td>可填</td>
		         <td>格式YYYYMMDDHHNNSS</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;是否具有赎回权</td>
		         <td>第四十列</td>
		         <td>可填</td>
		         <td>是、否</td>
		     </tr> 
		     <tr>
		         <td>&nbsp;&nbsp;发行方式</td>
		         <td>第四十一列</td>
		         <td>可填</td>
		         <td>数据字典：发行方式</td>
		     </tr> 
		     <tr>
		         <td>&nbsp;&nbsp;特殊期限</td>
		         <td>第四十二列</td>
		         <td>可填</td>
		         <td></td>
		     </tr> 
		     <tr>
		         <td>&nbsp;&nbsp;投标区间</td>
		         <td>第四十三列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;发行规模描述</td>
		         <td>第四十四列</td>
		         <td>可填</td>
		         <td></td>
		     </tr> 
		     <tr>
		         <td>&nbsp;&nbsp;发行日期描述</td>
		         <td>第四十五列</td>
		         <td>可填</td>
		         <td></td>
		     </tr> 
		     <tr>
		         <td>&nbsp;&nbsp;承销商联系人信息</td>
		         <td>第四十六列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;所属行业(证监会二级)</td>
		         <td>第四十七列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;股票名称</td>
		         <td>第四十八列</td>
		         <td>可填(当债券类别为可交换和可转债时,股票名称为必填)</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;股票抵押数量(万股)</td>
		         <td>第四十九列</td>
		         <td>可填(当债券类别为可交换和可转债时,股票抵押数量为必填)</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;股票代码</td>
		         <td>第五十列</td>
		         <td>可填(当债券类别为可交换和可转债时,股票代码为必填)</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;公司净资产</td>
		         <td>第五十一列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;城投行政级别</td>
		         <td>第五十二列</td>
		         <td>可填</td>
		         <td>数据字典：城投行政级别</td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;下一利率跳升点数(BP)</td>
		         <td>第五十三列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     
			 <tr style="width:100%"><td colspan="5"><hr/></td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;注意：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;1.EXCEL文件以【XLS】对应的字段顺序匹配。</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;2.EXCEL文件第一行：字段名称不能为空，第二行开始：具体数据。</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;3.EXCEL文件数据中间不能有【空行】。</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;4.对于必填字段，要求必需填写，否则导入当条数据失败；</td></tr>
        	 <tr><td colspan="5">&nbsp;&nbsp;5.对于可填字段，当导入新增记录时，如果不填，将按说明信息中默认值代替；</td></tr>
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
    	var form = new nui.Form("#dataform1");
    	$("#prodIfm").attr("src","<%=request.getContextPath() %>/fm/comm/fileupload/singleFileUpload.jsp");
    	var templetDownload = "onUpload";
    	var func = "onUploadSuccess";
    	var startUploadfunc = "startUpload";
    var UpSuccessBizParm=new Array();//params中按顺序给 逻辑流参数赋值.所以 Fdata 参数必须在回调逻辑流的第一位，其他参数必须按照数组顺序赋值，否则会出现赋值混乱，可为空
	UpSuccessBizParm[0]='<%=operatorId %>';
	//UpSuccessBizParm[1]='zs';//user_name
	var UpSuccessBiz="com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager.debtIssueUpload";//上传回调逻辑流全名称 逻辑流名称+逻辑构建全称，不可和回调函数名同时为空
    function onFileSelect(e) {
        //alert("选择文件");
    }
    function onUploadSuccess(e) {
      
      if(e.result==null){
      	form.unmask();
      	nui.alert("导入失败,请检查数据！");
      }else{
      	var msglist = e.result[0];//msglist
      //console.log(nui.decode(result));//[[Object { id=1,  errorCode="发行期限(年)为必填并且是大于0的数字不能超过5位.",  errorMsg="发行期限(年)为必填并且是大于0的数字不能超过5位."}]]
       if(nui.decode(msglist).exception){
          form.unmask();
          nui.alert("导入失败,请检查数据！", "", function(){});
          return;
        }
       if(nui.decode(msglist)){
    		form.unmask();
    		mini.open({
					    url:"<%=request.getContextPath() %>/fm/baseinfo/fileupload/resultMsg.jsp",
					    title: "导入返回的结果信息", width: 500, height: 500,
					    overflow:"hidden",
					    onload: function () {
					        var iframe = this.getIFrameEl();
					        //console.log(msglist);
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
         form.loading();//加载遮罩
         //var fileupload = mini.get("fileupload1");
			fileupload.setPostParam({userid:'<%=operatorId %>'});
         var excelName = fileupload.text;
         if(excelName == ""){
	         form.unmask();
	         nui.alert("请选择一个导入文件！", "", function(){});
	         return false;
         }
         
         if(excelName.substr(0,9) != "ATS_XZXX_"){
             form.unmask();
             nui.alert("excel名称不是ATS_XZXX_YYYYMMDD格式，请修改！", "", function(){});
	         return;
         }
         
         var uploadName = excelName.substr(0,17);
         
         var tempName = excelName.substr(0,9);/* 去掉后缀名后和真正日期的文件对比  ATS_XZXX_YYYYMMDD*/
         var relName = tempName+'<%=replaceFileName %>';
         
         
	    if(uploadName != relName){
	      form.unmask();
	      nui.alert("文件名称必须为"+relName+"!", "", function(){});
      	  return;
     }
        return true;
    }
    
    function onUpload(){
        window.location.href = "com.cjhxfund.ats.fm.baseinfo.importDebtIssueFile.flow?type=1";
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