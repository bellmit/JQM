<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@page import="java.util.List"%>  
<%@page import="java.util.ArrayList"%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 翟静
  - Date: 2016-11-14 14:12:07
  - Description:
-->
<head>
<title>账户信息导入</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="<%=request.getContextPath() %>/fm/comm/fileupload/js/swfupload.js"></script>
	
	<%
	   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext);
	   //获取工作项信息
	   List msgList = (ArrayList)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"msgList");
 	%>
</head>
<body>
 <div style="width:100%;height:100%; "  borderStyle="border:solid 1px #aaa;">
	<table style="height:3px;vertical-align: middle;">
		<tr>
			<td style="width:20px;"  align="right">
				<div class="mini-button mini-button-disabled" enabled="false" iconCls="icon-edit"></div>
			</td>
			<td style="width:150px;"  align="left">
			<!-- 动态获取标头 -->
				<h4><label name="">账户信息导入配置</label></h4>
			</td>
		</tr>
	 </table>
		<hr/>
	 <div style="height:10px;">
		                 导入文件路径：
		     <input width="300px" id="fileupload1" class="mini-fileupload" name="Fdata"
			flashUrl="js/swfupload.swf" 
			uploadUrl="com.cjhxfund.ats.fm.baseinfo.ApplyTemplet.accountInfoUp.biz.ext" onuploadsuccess="onUploadSuccess"
			onuploaderror="onUploadError" onfileselect="onFileSelect" />
			 <a class="mini-button" iconCls="icon-download" plain="false" onclick="onUpload()">模板下载</a>
	  </div>
	  <!-- 动态获取表内容 -->
	<div class="description" style="margin-top:20px; height:400px;overflow: auto; ">
		 <table style="background-color:#f0f0f0; width:100%;" border="0px"  >
			 <tr><td colspan="5">当前设置的导入模式：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;Execl导入从当前工作表导入,支持(*.xls;*.xlsx)!</td></tr>
			 <tr><td colspan="5">账户信息导入接口说明：</td></tr>
			 <tr><td colspan="5">文件格式：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;EXCEL文件：*.xls  创金自定义格式               文件名：ZHXX_YYYYMMDD.XLS</td></tr>
			 <tr><td colspan="5">数据库表：</td></tr>
			 <tr><td colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;ORACLE数据库表：ORACLE数据库表名                 表名：TATSACCOUNTINFO</td></tr>
			 <tr><td colspan="5">字段要求：</td></tr>
			 <tr>
				 <td>字段名称</td>
				 <td>XLS</td>
				 <td>字段名</td>
				 <td>是否必填</td>
				 <td>说明</td>
			 </tr>
			 <tr style="width:100%"><td colspan="5"><hr/></td></tr>
			
			
		     <tr>
		         <td>产品代码</td>
		         <td>第一列</td>
		         <td>CPDM</td>
		         <td>必填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>产品名称</td>
		         <td>第二列</td>
		         <td>CPMC</td>
		         <td>必填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>登记托管机构</td>
		         <td>第三列</td>
		         <td>DJTGJG</td>
		         <td>必填</td>
		         <td>01中央结算公司=银行间02上海清算所=银行间03上交所04深交所99其他=银行间</td>
		     </tr>
			 <tr>
		         <td>账户类型</td>
		         <td>第四列</td>
		         <td>ZHLX</td>
		         <td>必填</td>
		         <td>1证券账户,2银行间,3托管账户,其他</td>
		     </tr>
			 <tr>
		         <td>账户名称</td>
		         <td>第五列</td>
		         <td>ZHMC</td>
		         <td>必填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>账户号码</td>
		         <td>第六列</td>
		         <td>ZHHM</td>
		         <td>必填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>托管劵商席位号（上海）</td>
		         <td>第七列</td>
		         <td>DGSXWH（SH）</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
			 <tr>
		         <td>托管劵商席位号（深圳）</td>
		         <td>第八列</td>
		         <td>DGSXWH（SZ）</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>托管所</td>
		         <td>第九列</td>
		         <td>TGS</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>大额支付号</td>
		         <td>第十列</td>
		         <td>DEZFH</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     <tr>
		         <td>备注</td>
		         <td>第十一列</td>
		         <td>BZ</td>
		         <td>可填</td>
		         <td></td>
		     </tr>
		     
			 <tr style="width:100%"><td colspan="5"><hr/></td></tr>
			 <tr><td colspan="5">注意：</td></tr>
			 <tr><td colspan="5">1.EXCEL文件以【XLS】对应的字段顺序匹配。</td></tr>
			 <tr><td colspan="5">2.EXCEL文件第一行：字段名称不能为空，第二行开始：具体数据。</td></tr>
			 <tr><td colspan="5">3.EXCEL文件数据中间不能有【空行】。</td></tr>
			 <tr><td colspan="5">4.导入接口文件为Excel时，要求安装MicroSoft Excel。</td></tr>
			 <tr><td colspan="5">5.对于必填字段，要求必需填写，否则导入当条数据失败；<br/>
					 	对于可填字段，当导入新增记录时，如果不填，将按说明信息中默认值代替；<br/>
						 当导入更新时，如果不填，将不更新相关数据。<br/>
			     </td>
			 </tr>
			 <tr><td colspan="5">6.对于外部评级日期字段而言，当外部评级字段取值为空时，该字段只能填空，<br/>
			     		否则当条数据将导入失败；在导入更新时如果该字段不填则取默认值0。
			     </td>
			 </tr>
			 <tr><td colspan="5">7.导入ORACLE数据库表支持ORACLE9i以上数据库版本。</td></tr>
			 
		 </table>
	 </div>

  </div>
 
	 <div id="footer" class="nui-toolbar" style="padding:0px; width:100%;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align:center;" >
					<a class='nui-button' plain='false' iconCls="icon-save" onclick="startUpload()">
                                                                        保存
					</a>
					
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
    function onFileSelect(e) {
        alert("选择文件");
    }
    function onUploadSuccess(e) {
      
	alert("123400");
    <%-- <%
	   Object rootObj= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext);
	   
	   String result = (String)com.eos.web.taglib.util.XpathUtil.getObjectByXpath(rootObj,"result");
 	%> --%>

        this.setText("");
    }
    function onUploadError(e) {
    	alert("aaa0");
         alert("上传失败：" + e.serverData);
    }

    function startUpload() {
    	alert("bbb");
        var fileupload = mini.get("fileupload1");

        fileupload.startUpload();
    }
    
    function onUpload(){
        window.location.href = "com.cjhxfund.ats.fm.baseinfo.exportFile.flow";
    }
    
    function onCancel(){
           CloseWindow("cancel");
    }
     //关闭窗口
    function CloseWindow(action) {
    if (action == "close" && form.isChanged()) {
        if (confirm("数据被修改了，是否先保存？")) {
            saveData();
        }
    }
    if (window.CloseOwnerWindow)
    return window.CloseOwnerWindow(action);
    else window.close();
    }
    </script>
</body>
</html>