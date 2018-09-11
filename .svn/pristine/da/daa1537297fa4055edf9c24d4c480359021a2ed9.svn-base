<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): zhangyao
  - Date: 2016-12-06 16:13:30
  - Description:
-->
<head>
    <title>剔除产品</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
    html, body
    {
        font-size:12px;
        padding:0;
        margin:0;
        border:0;
        height:100%;
        overflow:hidden;
    }
    </style>
</head>
<%
	String   lInstructNo=request.getParameter("lInstructNo");
 %>
<body style="background:#F4F4F4;">
	<input name="pageType" class="nui-hidden" /> 
    <form id="dataform1" method="post" >
    	<!-- hidden域 -->
        <input name="lInstructNo" id="lInstructNo" class="nui-hidden" value="<%=lInstructNo %>"/>
        <div style="padding:15px 0 15px 40px;">
	        <table>
	            <tr>
	                <td style="width:40px;">备注:</td>
	                <td style="width:150px;">    
	                    <input name="product.vcRationProductCode" class="nui-textbox" emptyText="请输入剔除原因" required="true"/>
	                </td>
	            </tr>
	        </table>            
        </div>
        <div style="text-align:center;padding:10px;">               
            <a class='nui-button' plain='false' onclick="onOk()" iconCls="icon-ok" style="width:60px;margin-right:20px;">确定</a>       
            <a class='nui-button' plain='false' onclick="onCancel()" iconCls="icon-cancel" style="width:60px;">取消</a>       
        </div>        
    </form>
    <script type="text/javascript">
        nui.parse();
		
		function saveData() {
			//debugger;
			var form = new nui.Form("#dataform1");
			form.setChanged(false);
			form.validate();
			if (form.isValid() == false)
				return;

			var lInstructNo=nui.get("lInstructNo").value;
			var data={lInstructNo:lInstructNo};
			var json=nui.encode(data);
			
			nui.ajax({
				url : "com.cjhxfund.ats.ipo.busOpr.updateIpoPurchaseInfo.biz.ext",
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if (returnJson.exception == null) {
						CloseWindow("saveSuccess");
					} else {
						nui.alert("保存失败", "系统提示", function(action) {
							if (action == "ok" || action == "close") {
								//CloseWindow("saveFailed");
							}
						});
					}
				}
			});
		}

		//页面间传输json数据
		function setFormData(data) {
			//跨页面传递的数据对象，克隆后才可以安全使用
			var infos = nui.clone(data);

			//如果是点击编辑类型页面
			if (infos.pageType == "edit") {
				var json = infos.record;

				var form = new nui.Form("#dataform1");//将普通form转为nui的form
				form.setData(json);
				form.setChanged(false);
			}
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
			else
				window.close();
		}

		//确定保存或更新
		function onOk(){
			saveData();
		}

		//取消
		function onCancel() {
			CloseWindow("cancel");
		}
	
    </script>
</body>
</html>