<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<%@page import="com.cjhxfund.ats.fm.commonUtil.DateUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 黄燕
  - Date: 2017-03-02 15:45:57
  - Description:
-->
<head>
<title>承销商导入</title>
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
			<td style="width:160px;"  align="left">
				<h4>主承销商新债信息导入配置</h4>
			</td>
		</tr>
	 </table>
		<hr/>
	  <iframe id="prodIfm" name="prodIfmName" width="700"  height="30px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" ></iframe>
	  <!-- <iframe id="customExcel" name="customExcel" width="840"  height="315" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" ></iframe> -->
	  <!-- 动态获取表内容 -->
	<div class="description" style="margin-top:10px; height:440px;overflow: auto; ">
	     <input id="customEnglishName"   class="nui-hidden" name="customEnglishName"/>
		 <table style="background-color:#f0f0f0; width:100%;" border="0px"  >
			 <tr><td colspan="5">&nbsp;&nbsp;当前设置的导入模式：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Execl导入从当前工作表导入,支持(*.xls;*.xlsx)!</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;发行人信息导入接口说明：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;文件格式：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EXCEL文件：*.xls  创金自定义格式&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文件名：主承新债导入模板.xls</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;数据库表：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ORACLE数据库表：ORACLE数据库表名&nbsp;&nbsp;&nbsp;&nbsp; 表名：T_ATS_UNDERWRITER_STOCK_INFO</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;字段要求：</td></tr>
			 <tr>
				 <td>&nbsp;&nbsp;字段名称</td>
				 <td>XLS</td>
				 <td>是否必填</td>
				 <td>说明</td>
			 </tr>
			 <tr style="width:100%"><td colspan="5"><hr/></td></tr>
			
			
		     <tr>
		         <td>&nbsp;&nbsp;主承销商</td>
		         <td>第一列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;主承销商相关联系方式 </td>
		         <td>第二列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;发行时间（标记确定or暂定）</td>
		         <td>第三列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;簿记时间 </td>
		         <td>第四列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;发行主体全称 </td>
		         <td>第五列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;债券类别 </td>
		         <td>第六列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;发行方式</td>
		         <td>第七列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;债券简称（标记正式or非正式）</td>
		         <td>第八列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;债券全称 </td>
		         <td>第九列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;发行规模（亿）</td>
		         <td>第十列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;期限（年）</td>
		         <td>第十一列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;期限备注</td>
		         <td>第十二列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;询价区间</td>
		         <td>第十三列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;主体评级</td>
		         <td>第十四列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;债券评级</td>
		         <td>第十五列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;评级机构</td>
		         <td>第十六列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;登记托管机构</td>
		         <td>第十七列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;预计到期日</td>
		         <td>第十八列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;还本付息方式</td>
		         <td>第十九列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;起息日</td>
		         <td>第二十列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;增信情况</td>
		         <td>第二十一列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>&nbsp;&nbsp;企业性质</td>
		         <td>第二十二列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;是否城投</td>
		         <td>第二十三列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;标的资产</td>
		         <td>第二十四列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;原始权益人</td>
		         <td>第二十五列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;是否可质押</td>
		         <td>第二十六列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>  
		     <tr>
		         <td>&nbsp;&nbsp;资质简介</td>
		         <td>第二十七列</td>
		         <td>可填</td>
		         <td></td>
		     </tr> 
		     <tr>
		         <td>&nbsp;&nbsp;材料网络下载链接</td>
		         <td>第二十八列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;材料网络版更新时间</td>
		         <td>第二十九列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;路演时间</td>
		         <td>第三十列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;调研纪要/路演纪要（若有） 下载链接</td>
		         <td>第三十一列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;历史发债</td>
		         <td>第三十二列</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>&nbsp;&nbsp;是否有过融资历史</td>
		         <td>第三十三列</td>
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
    	var userId='<%=operatorId %>';
    	var form = new nui.Form("#dataform1");
    	$("#prodIfm").attr("src","<%=request.getContextPath() %>/fm/comm/fileupload/customSingleFileUpload.jsp");
    	var templetDownload = "onUpload";
    	var func = "onUploadSuccess";
    	var startUploadfunc = "startUpload";
    	var UpSuccessBizParm=new Array();//params中按顺序给 逻辑流参数赋值.所以 Fdata 参数必须在回调逻辑流的第一位，其他参数必须按照数组顺序赋值，否则会出现赋值混乱，可为空
		UpSuccessBizParm[0]='<%=operatorId %>';
	    UpSuccessBizParm[1]=nui.get("customEnglishName").getValue();
		var UpSuccessBiz="com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager.importUnderwriterPreview";//上传回调逻辑流全名称 逻辑流名称+逻辑构建全称，不可和回调函数名同时为空
	    function onFileSelect(e) {
	        //alert("选择文件");
	    }
    function onUploadSuccess(e) {
      if(e.result==null){
      	form.unmask();
      	nui.alert("导入失败,请检查数据！");
      }else{
      	var underwriterStockInfo = e.result[0];
      	var filePath = e.result[1];
      	var clientPath=e.result[2];
      	var customName=e.result[3];
       if(nui.decode(underwriterStockInfo).exception){
          form.unmask();
          nui.alert("导入失败,请检查数据！", "", function(){});
          return;
        }
       if(nui.decode(underwriterStockInfo)){
    		form.unmask();
    		mini.open({
				    url:"<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/importUnderwriterPreview.jsp",
				    title: "承销商信息导入预览", 
	                width: 980, 
	   			    height: 470,
				    overflow:"hidden",
				    onload: function () {
				        var iframe = this.getIFrameEl();
				        //console.log(msglist);
				        iframe.contentWindow.SetData({underwriterStockInfo:underwriterStockInfo,filePath1:filePath,clientPath1:clientPath,customName1:customName});
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
		 fileupload.setPostParam({userid:'<%=operatorId %>'});
         var excelName = fileupload.text;
         if(excelName == ""){
	         form.unmask();
	         nui.alert("请选择一个导入文件！", "", function(){});
	         return false;
         }
          
        return true;
    }
    
    function onUpload(){
        window.location.href = "com.cjhxfund.ats.fm.baseinfo.importDebtIssueFile.flow?type=2";
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