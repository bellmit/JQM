<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<%--
- Author(s): chenpeng
- Date: 2016-07-07 09:36:52
- Description:
    --%>
    <head>
        <title>
            ZhfwptParamConf录入
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
		<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
		<script src="<%= request.getContextPath() %>/common/nui/locale/zh_CN.js" type="text/javascript"></script>
    </head>
    <body style="width: 100%;height: 100%;overflow: auto;" ><!-- 滚动条overflow: hidden; -->
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="tabs" class="nui-form" style="width: 100%;height:88%;" >
        <div id="dataform1"  style="height: 100%;">
            <!-- hidden域 -->
            <input class="nui-hidden" name="zhfwptparamconf.paramConfId"/>
            <input class="nui-hidden" id="paramKeyUpdate"/>
            <input class="nui-hidden" name="zhfwptparamconf.paramControlType" id="paramControlType"/>
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td class="form_label" width="60px" align="right" >
                        参数key:
                    </td>
                    <td colspan="3" align="left" >
                        <input class="nui-textbox" name="zhfwptparamconf.paramKey" width="100%" id="paramKey" required="true" onvaluechanged="onlyParamKey"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" width="60px" align="right" >
                        参数名:
                    </td>
                    <td colspan="3" align="left" >
                        <input class="nui-textbox" name="zhfwptparamconf.paramName" width="100%" required="true"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label" width="60px" align="right">
                        参数状态:
                    </td>
                    <td colspan="1" align="left">
                        <input class="nui-combobox" name="zhfwptparamconf.paramStatus" width="100%" data="[{id : 0 , text : '启用'},{id : 1 , text : '废弃'}]" value="0" required="true"/>
                    </td>
                    <td class="form_label" width="60px" align="right">
                        参数类型:
                    </td>
                    <td colspan="1" align="left">
                        <input class="nui-combobox" name="zhfwptparamconf.paramType" width="100%" data="[{id : 0 , text : '不可修改'},{id : 1 , text : '可修改'}]" value="1" required="true"/>
                    </td>
                </tr>
                <tr>
                	 <td class="form_label" width="60px" align="right">
                        参数值:
                    </td>
                    <td colspan="3" align="left" style="display: none;" id="textbox_td">
                    	<input class="nui-textbox" id="textbox" width="100%" name="zhfwptparamconf.paramValue" value="" required="true"/>
                    </td>
                    <td colspan="3" align="left" style="display: none;" id="combobox_td">
                    	<input class="nui-combobox" id="combobox" width="100%" required="true" name="zhfwptparamconf.paramValue" textField="text" valueField="id"/>
                    </td>
                    <td colspan="3" align="left" style="display: none;" id="comboboxlist_td">
                    	<input class="nui-combobox" id="comboboxlist" popupHeight="130" popupMaxHeight="130" width="100%" multiSelect="true" required="true" name="zhfwptparamconf.paramValue"  textField="text" valueField="id"/>
                    </td>
                    <td colspan="3" align="left" style="display: none;" id="timespinner_td">
                    	<input id="dateStart" class="mini-timespinner" style="width:48%;" format="H:mm:ss" timeFormat="H:mm:ss"/>
                    	<span style="width:4%;">- </span>
                    	<input id="dateEnd" class="mini-timespinner" style="width:48%;" format="H:mm:ss" timeFormat="H:mm:ss"/>
                    </td>
                    <td colspan="3" align="left" style="display: none;overflow:auto" id="timeMM_td">
                    	<input style="width: 30%;" popupHeight="130" popupMaxHeight="130"  url="./timeMM.txt" class="nui-dictcombobox" required="true" id="timeMM" />
                    </td>
                    <td colspan="3"  align="left" style="display: none;" id="datepicker_td">
                        <input class="nui-datepicker" id="datepicker" format="yyyy-MM-dd" style="width:100%"/>
                    </td>
                    <td colspan="3" align="left" style="display: none;" id="radiobuttonlist_td">
                        <input class="mini-radiobuttonlist" id="radiobuttonlist" valueField="id"  required="true" height="25px"/>
                    </td>
                    <td colspan="3" align="left" style="display: none;" id="buttonedit_td">
                        <input class="nui-buttonedit" onbuttonclick="editParam(this)"  id="buttoneditlist" width="100%" required="true" height="25px"/> 
                    </td>
                </tr>
                <tr>
                    <td class="form_label" width="60px" align="right">
                        参数描述:
                    </td>
                    <td colspan="3" align="left">
                        <input class="nui-textarea" width="100%" height="110px" name="zhfwptparamconf.paramMemo"/>
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
         </div>

		<script type="text/javascript">
			nui.parse();
			function saveData(){
				var form = new nui.Form("#dataform1");
				var paramKey = nui.get("paramKey").getValue();
				var paramKeyUpdate = nui.get("paramKeyUpdate").getValue();
				var paramControlType = nui.get("paramControlType").getValue();
                form.setChanged(false);
                //保存
                var urlStr = "com.cjhxfund.commonUtil.zhfwptparamconfbiz.addZhfwptParamConf.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.cjhxfund.commonUtil.zhfwptparamconfbiz.updateZhfwptParamConf.biz.ext";
                }
                form.validate();
                if(form.isValid()==false) return;
                var data = {zhfwptparamconf:{paramKey:paramKey},pageType:pageType,paramKeyUpdate:paramKeyUpdate};
                var json = nui.encode(data);
				$.ajax({
					url:"com.cjhxfund.commonUtil.zhfwptparamconfbiz.getZhfwptParamConf.biz.ext",
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
                			if(paramControlType == "COMBOBOX"){
                				data.zhfwptparamconf.paramValue=nui.get("combobox").getValue();
                			}else if(paramControlType == "TIMESPINNER"){
                				if(nui.get("dateStart").getValue()>nui.get("dateEnd").getValue()){
                					nui.alert("开始时间必须早于结束时间！！");
                					return false;
                				}
                				var start = nui.get("dateStart").getValue().getHours();
                				if(nui.get("dateStart").getValue().getMinutes()<10){
                					start = start + "0" + nui.get("dateStart").getValue().getMinutes();
                				}else{
                					start = start +""+ nui.get("dateStart").getValue().getMinutes();
                				}
                				if(nui.get("dateStart").getValue().getSeconds()<10){
                					start = start + "0" +nui.get("dateStart").getValue().getSeconds();
                				}else{
                					start = start +""+ nui.get("dateStart").getValue().getSeconds();
                				}
                				var end = nui.get("dateEnd").getValue().getHours();
                				if(nui.get("dateEnd").getValue().getMinutes()<10){
                					end = end + "0" +nui.get("dateEnd").getValue().getMinutes();
                				}else{
                					end = end +""+ nui.get("dateEnd").getValue().getMinutes();
                				}
                				if(nui.get("dateEnd").getValue().getSeconds()<10){
                					end = end + "0" +nui.get("dateEnd").getValue().getSeconds();
                				}else{
                					start = start +""+ nui.get("dateEnd").getValue().getSeconds();
                				}
                				data.zhfwptparamconf.paramValue=start+"-"+end;
                			}else if(paramControlType == "COMBOBOXLIST"){
                				data.zhfwptparamconf.paramValue=nui.get("comboboxlist").getValue();
                			}else if(paramControlType == "TIMEMM"){
                				data.zhfwptparamconf.paramValue=nui.get("timeMM").getValue();
                			}else if(paramControlType == "RADIOBUTTONLIST"){
                				data.zhfwptparamconf.paramValue=nui.get("radiobuttonlist").getValue();
                			}else if(paramControlType == "IP"){
                				var ip = nui.get("textbox").getValue();
							   var re=/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/;//正则表达式   
							   if(re.test(ip))   
							   {   
							       if( RegExp.$1<256 && RegExp.$2<256 && RegExp.$3<256 && RegExp.$4<256){
							       		data.zhfwptparamconf.paramValue=nui.get("textbox").getValue();
							       }else{
							       		nui.alert("IP地址有误！！");   
							   			return false;
							       }
							   }else{
							   		nui.alert("IP有误！");   
							   		return false;
							   }
                			}else if(paramControlType == "BUTTONEDIT"){
                				data.zhfwptparamconf.paramValue=nui.get("buttoneditlist").getValue();
                			}else{
                				data.zhfwptparamconf.paramValue=nui.get("textbox").getValue();
                			}
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
                    if(json.zhfwptparamconf.paramControlType == "COMBOBOXLIST" || json.zhfwptparamconf.paramControlType == "COMBOBOX"){
						if(json.zhfwptparamconf.paramTextareaMethod != null && json.zhfwptparamconf.paramTextareaMethod != "json"){
	                    	$.ajax({
								url:"com.cjhxfund.commonUtil.zhfwptparamconfbiz.getParamTextArea.biz.ext",
					            type:'POST',//{'map/dicttypeid':'select t.c_stock_type as id ,t.vc_stocktype_name as text from  t_ats_stock_type t','paramTextareaMethod':'sql'}
					            data:nui.encode({'map/dicttypeid':json.zhfwptparamconf.paramTextarea,'paramTextareaMethod':json.zhfwptparamconf.paramTextareaMethod}),
					            cache:false,//{'map/dicttypeid':json.zhfwptparamconf.paramTextarea,'paramTextareaMethod':json.zhfwptparamconf.paramTextareaMethod}
					            contentType:'text/json',
					            success:function(text){
									if(json.zhfwptparamconf.paramControlType == "COMBOBOXLIST"){
										jQuery("#comboboxlist_td").show();
				                    	nui.get("comboboxlist").setData(text.json);
				                    	nui.get("comboboxlist").setValue(json.zhfwptparamconf.paramValue);
									}else if(json.zhfwptparamconf.paramControlType == "COMBOBOX"){
				                    	jQuery("#combobox_td").show();
				                    	nui.get("combobox").setData(text.json);
				                    	nui.get("combobox").setValue(json.zhfwptparamconf.paramValue);
	                    			}
					            }    
					       });
	                    }else{
	                    	if(json.zhfwptparamconf.paramControlType == "COMBOBOXLIST"){
								jQuery("#comboboxlist_td").show();
		                    	nui.get("comboboxlist").setData(json.zhfwptparamconf.paramTextarea);
		                    	nui.get("comboboxlist").setValue(json.zhfwptparamconf.paramValue);
							}else if(json.zhfwptparamconf.paramControlType == "COMBOBOX"){
		                    	jQuery("#combobox_td").show();
		                    	nui.get("combobox").setData(json.zhfwptparamconf.paramTextarea);
		                    	nui.get("combobox").setValue(json.zhfwptparamconf.paramValue);
		        			}
	                    }
					}else if(json.zhfwptparamconf.paramControlType == "TIMESPINNER"){
                    	jQuery("#timespinner_td").show();
                    	var str = json.zhfwptparamconf.paramValue.split("-");
                    	var strHM = str[0].substring(0,str[0].length-2);
                    	var strH = strHM.substring(0,strHM.length-2);
                    	nui.get("dateStart").setValue(strH+":"+strHM.substring(strHM.length-2)+":"+str[0].substring(str[0].length-2));
                    	var strHM = str[1].substring(0,str[1].length-2);
                    	var strH = strHM.substring(0,strHM.length-2);
                    	nui.get("dateEnd").setValue(strH+":"+strHM.substring(strHM.length-2)+":"+str[1].substring(str[1].length-2));
                    }else if(json.zhfwptparamconf.paramControlType == "TIMEMM"){
                    	jQuery("#timeMM_td").show();
                    	nui.get("timeMM").setValue(json.zhfwptparamconf.paramValue);
                    }else if(json.zhfwptparamconf.paramControlType == "RADIOBUTTONLIST"){
                    	jQuery("#radiobuttonlist_td").show();
                    	nui.get("radiobuttonlist").setData(json.zhfwptparamconf.paramTextarea);
                    	nui.get("radiobuttonlist").setValue(json.zhfwptparamconf.paramValue);
                    }else if(json.zhfwptparamconf.paramControlType == "BUTTONEDIT"){
                    	jQuery("#buttonedit_td").show();
                    	//nui.get("buttoneditlist").setData(json.zhfwptparamconf.paramTextarea);
                    	nui.get("buttoneditlist").setValue(json.zhfwptparamconf.paramValue);
                    	nui.get("buttoneditlist").setText(json.zhfwptparamconf.paramValue);
                    }else{
                    	jQuery("#textbox_td").show();
                    	nui.get("textbox").setValue(json.zhfwptparamconf.paramValue);
                    }
                    form.setData(json);
                    form.setChanged(false);
                }else{
                	jQuery("#textbox_td").show();
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
					url:"com.cjhxfund.commonUtil.zhfwptparamconfbiz.getZhfwptParamConf.biz.ext",
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
			function editParam(value){
				nui.open({
		            url: "<%=request.getContextPath() %>/commonUtil/paramMaintain/editParam.jsp",
		            title: "参数值修改",
		            width: 350,
		            height: 200,
		            onload:function(){
		                var iframe = this.getIFrameEl();
	                	iframe.contentWindow.setFormData(value.value);
		            },
		            ondestroy: function (action) {
		               if(action != "cancel" && action != "close"){
		               		nui.get("buttoneditlist").setValue(action);
		               		nui.get("buttoneditlist").setText(action);
		               }
		            }
		        });
			}
		</script>
	</body>
</html>
