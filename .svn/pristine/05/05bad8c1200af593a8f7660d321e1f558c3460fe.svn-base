<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): zhoulin
- Date: 2017-12-01 13:42:35
- Description:
    --%>
    <head>
        <title>模板元素维护</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript">
        </script>
    </head>
    <body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;width: 100%;height:86%;" >
            <!-- hidden域 -->
        	<input class="nui-hidden" name="tatsstocktemplateelements.vcCreator" id="vcCreator"/>
            <input class="nui-hidden" name="tatsstocktemplateelements.dCreateTime" id="dCreateTime"/>
            <input class="nui-hidden" name="tatsstocktemplateelements.dUpdateTime" id="dUpdateTime"/>
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td class="form_label" align="right"colspan="1">
                 		<span style="color:red">*</span>&nbsp;要素名称:
                    </td>
                    <td colspan="2"align="left">
                         <input class="nui-textbox" style="width: 70%;" id="vcElementName" name="tatsstocktemplateelements.vcElementName" required="true"/>
                    </td>
                </tr>
				<tr>
            		<td class="form_label" align="right"colspan="1">
                    	<span style="color:red">*</span>&nbsp;要素代号:
                    </td>
                    <td colspan="2" align="left">
                		<input style="width: 70%;" class="nui-textbox" id="vcElementPlaceholder"  name="tatsstocktemplateelements.vcElementPlaceholder" 
                		onvalidation="validation" required="true"  validateOnChanged="true"/>
                    </td>
	  	    	</tr>
            </table>
            <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a class="nui-button" iconCls="icon-save" onclick="onOk()">
                                保存
                            </a>
                            <span style="display:inline-block;width:25px;">
                            </span>
                            <a class="nui-button" iconCls="icon-cancel" onclick="onCancel()">
                                取消
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
            <span style="color:red">
            	备注：要素代号的格式应符合\${...},大括号中的内容只允许字母和数字。
            </span>
        </div>
        <script type="text/javascript">
            nui.parse();
            //获取当前登录人的ID信息
            <% 	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject"); %>
 			var currentUserID = "<%=userObject.getUserId() %>";
            var currentUserName = "<%=userObject.getUserName() %>";
            //填写制作人姓名
            //console.log("name="+currentUserName);
            nui.get("vcCreator").setValue(currentUserName);

            function saveData(){
				var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
            	var form = new nui.Form("#dataform1");
            	var nowDate = new Date();
                form.setChanged(false);
                var urlStr = null;
                if(pageType=="edit"){
                	nui.get("dUpdateTime").setValue(nowDate);
                    urlStr = "com.cjhxfund.ats.fm.baseinfo.tatsstocktemplateelementsbiz.updateTAtsStockTemplateElements.biz.ext";
                }else if(pageType=="add"){
                	nui.get("dCreateTime").setValue(nowDate);
            		nui.get("dUpdateTime").setValue(nowDate);
                	urlStr = "com.cjhxfund.ats.fm.baseinfo.tatsstocktemplateelementsbiz.addTAtsStockTemplateElements.biz.ext";
            	}
                form.validate();
                if(form.isValid()==false) return;

                var data = form.getData(false,true);
                var json = nui.encode(data);
				//console.log("data="+json);
				//console.log("url="+urlStr);
                $.ajax({
                    url:urlStr,
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                            CloseWindow("saveSuccess");
                        }else{
                            nui.alert("要素代号重复录入", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                    //CloseWindow("saveFailed");
                                }
                                });
                            }
                        }
                        });
                    }

                    //页面间传输json数据
                    function setFormData(data){
                        //跨页面传递的数据对象，克隆后才可以安全使用
                        var infos = nui.clone(data);

                        //保存list页面传递过来的页面类型：add表示新增、edit表示编辑
                        nui.getbyName("pageType").setValue(infos.pageType);

                        //如果是点击编辑类型页面
                        if (infos.pageType == "edit") {
                            var json = infos.record;
                            var form = new nui.Form("#dataform1");//将普通form转为nui的form
                            form.setData(json);
                            form.setChanged(false);
                            nui.get("vcElementPlaceholder").allowInput=false;
                    		$("#vcElementPlaceholder input").css("background-color","#f0f0f0");//置灰
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
                        else window.close();
                    }

                    //确定保存或更新
                    function onOk() {
                        saveData();
                    }

                    //取消
                    function onCancel() {
                        CloseWindow("cancel");
                    }
                    function validation(e){
                    	if(e.isValid){
                    		var value = e.value;
                    		var patt = /^\\$\{[0-9a-zA-Z_]+\}$/;
                    		if(!patt.test(value)){
                    			e.errorText="要素代号格式错误";
                    			e.isValid = false;
                    			nui.alert(e.errorText, "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                    nui.get("vcElementPlaceholder").setValue("");
                                }
                                });
                    		}
                    	}
                    }
                </script>
            </body>
        </html>
