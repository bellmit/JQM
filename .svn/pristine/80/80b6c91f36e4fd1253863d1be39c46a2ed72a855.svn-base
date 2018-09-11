<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 黄燕
  - Date: 2016-12-19 17:43:27
  - Description:
-->
<head>
<title>修改参数值</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body style="width: 100%;height: 100%;overflow: hidden;" >
        <div id="tabs" class="nui-form" style="width: 100%;height:85%;" >
        <div id="dataform1"  style="height: 90%;">
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td class="form_label" style="width: 30%;" align="right" >
                        邮箱名称:
                    </td>
                    <td colspan="1" align="left" >
                        <input class="nui-textbox" id="vcMailName" width="80%" required="true" />
                    </td>
                </tr>
                <tr>
                    <td class="form_label" style="width: 30%;" align="right" >
                       邮箱密码:
                    </td>
                    <td colspan="1" align="left" >
                        <input class="nui-password" id="vcMailPwd" width="80%" required="true"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label" style="width: 30%;" align="right">
                       服务器地址:
                    </td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" id="vcSmtp" width="80%"  required="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" style="width: 30%;" align="right">
                        发件人:
                    </td>
                    <td colspan="1" align="left">
                        <input class="nui-textbox" id="vcMailSender" width="80%"  required="true"/>
                    </td>
                </tr>
                
            </table>
            <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;">
                            <a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">
                                确定
                            </a>
                            <span style="display:inline-block;width:25px;">
                            </span>
                            <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
                                取消
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
         </div>
         </div>



	<script type="text/javascript">
    	nui.parse();
    	var form = new nui.Form("#dataform1");
    	function setFormData(value){
    		var arr = value.split(",");
    		var vcMailName = arr[0].split("|");
    		var vcMailPwd = arr[1].split("|");
    		var vcSmtp = arr[2].split("|");
    		var vcMailSender = arr[3].split("|");
    		nui.ajax({
					url:"com.cjhxfund.commonUtil.zhfwptparamconfbiz.passwordDES.biz.ext",
                    type:'POST',
                    data:nui.encode({passwordDES:vcMailPwd[1]}),
                    cache: false,
                    contentType:'text/json',
					success:function(text){
						var returnJson = nui.decode(text);
						nui.get("vcMailPwd").setValue(returnJson.password);
					}
				});
    		nui.get("vcMailName").setValue(vcMailName[1]);
    		
    		nui.get("vcSmtp").setValue(vcSmtp[1]);
    		nui.get("vcMailSender").setValue(vcMailSender[1]);
    	}
    	function onOk(){
    		form.validate();
			if (form.isValid() == false) {
				nui.alert("请检查必填项!");
				return;
			}
    		var json = nui.encode({password:nui.get("vcMailPwd").value});
    		nui.ajax({
					url:"com.cjhxfund.commonUtil.zhfwptparamconfbiz.passwordToDES.biz.ext",
                    type:'POST',
                    data:json,
                    cache: false,
                    contentType:'text/json',
					success:function(text){
						var returnJson = nui.decode(text);
						passwordMD5 = returnJson.passwordMD5;
						//vcMailName|cj_itsupport,vcMailPwd|A+12345678,vcSmtp|10.224.1.50,vcMailSender|cj_itsupport@cjhxfund.com
						var paramValue = "vcMailName|"+nui.get("vcMailName").value+",vcMailPwd|"+passwordMD5+",vcSmtp|"+nui.get("vcSmtp").value+",vcMailSender|"+nui.get("vcMailSender").value;
			    		CloseWindow(paramValue);
					}
				});
			
    	}
    	
    	//取消
		function onCancel() {
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
				else window.close("cancel");
		}
    </script>
</body>
</html>