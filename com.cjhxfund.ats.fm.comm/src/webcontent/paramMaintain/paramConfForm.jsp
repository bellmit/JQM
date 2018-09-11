<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%--
- Author(s): 杨敏
- Date: 2016-08-15 09:36:52
- Description:
    --%>
    <head>
        <title>
            	系统数据录入
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        
		
		
    </head>
    <body style="width: 100%;height: 100%;overflow: hidden;">
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" >
            <!-- hidden域 -->
            <input class="nui-hidden" name="zhfwptparamconf.paramConfId"/>
            <input class="nui-hidden" id="paramKeyUpdate"/>
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td class="form_label" width="20%">
                        参数key:
                    </td>
                    <td colspan="1" width="30%">
                        <input class="nui-textbox" name="zhfwptparamconf.paramKey"  id="paramKey" required="true" onvaluechanged="onlyParamKey"/>
                    </td>
                    <td class="form_label" width="20%">
                        参数名:
                    </td>
                    <td colspan="1" width="30%">
                        <input class="nui-textbox" name="zhfwptparamconf.paramName" required="true"/>
                    </td>
                </tr>
                <tr>
                	 <td class="form_label">
                        参数值:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="zhfwptparamconf.paramValue" required="true"/>
                    </td>
                    <td class="form_label">
                        参数类型:
                    </td>
                    <td colspan="1">
                        <input class="nui-combobox" name="zhfwptparamconf.paramType"  data="[{id : 0 , text : '不可修改'},{id : 1 , text : '可修改'}]" value="1" required="true"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label">
                        参数状态:
                    </td>
                    <td colspan="3">
                        <input class="nui-combobox" name="zhfwptparamconf.paramStatus" data="[{id : 0 , text : '启用'},{id : 1 , text : '废弃'}]" value="0" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        参数描述:
                    </td>
                    <td colspan="3">
                        <input class="nui-textarea" width="375" height="110" name="zhfwptparamconf.paramMemo"/>
                    </td>
                </tr>
            </table>
            <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">
                                保存
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
		<script type="text/javascript">
			nui.parse();
			function saveData(){
				var form = new nui.Form("#dataform1");
				var paramKey = nui.get("paramKey").getValue();
				var paramKeyUpdate = nui.get("paramKeyUpdate").getValue();
                form.setChanged(false);
                //保存com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.addZhfwptParamConf
                var urlStr = "com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.addParamConf.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.updateParamConf.biz.ext";
                }
                form.validate();
                if(form.isValid()==false) return;
                var data = {zhfwptparamconf:{paramKey:paramKey},pageType:pageType,paramKeyUpdate:paramKeyUpdate};
                var json = nui.encode(data);
				$.ajax({
					url:"com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.getParamConf.biz.ext",
		            type:'POST',
		            data:json,
		            cache:false,
		            contentType:'text/json',
		            success:function(text){
						var returnJson = nui.decode(text);
						var paramConfId = returnJson.zhfwptparamconf.paramConfId; //获取参数表主键ID
						if(paramConfId != "" && paramConfId != undefined){
							nui.alert("参数Key已经存在，请重新输入。");
						}else{
						    var data = form.getData(false,true);
                			var json = nui.encode(data);

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
                           	 			nui.alert("保存失败", "系统提示", function(action){
	                                		if(action == "ok" || action == "close"){
	                                    		//CloseWindow("saveFailed");
	                                		}
                                		});
                            		}
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
                    nui.get("paramKey").disable();
                    nui.get("paramKeyUpdate").setValue(json.zhfwptparamconf.paramKey);

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
                    
			function onlyParamKey(){
				var paramKey = nui.get("paramKey").getValue();
				var data = {zhfwptparamconf:{paramKey:paramKey}};
				var json = nui.encode(data);

				$.ajax({
					url:"com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.getParamConf.biz.ext",
		            type:'POST',
		            data:json,
		            cache:false,
		            contentType:'text/json',
		            success:function(text){
						var returnJson = nui.decode(text);
						var paramConfId = returnJson.zhfwptparamconf.paramConfId; //获取参数表主键ID
						if(paramConfId != "" && paramConfId != undefined){
							nui.alert("参数Key已经存在，请重新输入。");
		                }
		            }    
		       });
			}
		</script>
	</body>
</html>
