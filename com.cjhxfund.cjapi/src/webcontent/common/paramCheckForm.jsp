<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@page import="com.eos.system.utility.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<%--
  - Author(s):liangjilong
  - Date: 2016-11-11 08:25:25
  - Description:
    --%>
    <head>
        <title>参数检测信息</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
		<script src="<%= request.getContextPath() %>/common/nui/locale/zh_CN.js" type="text/javascript"></script>
    </head>
    
    
    <body style="width: 100%;height: 100%;overflow: hidden;">
       <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input class="nui-hidden" name="pageType" id="pageType" value="<%=StringUtil.htmlFilter(request.getParameter("pageType"))%>"/>
            <!-- hidden域 -->
        <div id="dataform1" style="padding-top:5px;" class="nui-fit">
        		<input class="nui-hidden" name="paramCheck/opType" id="paramCheck/opType"/>
        	  	<input class="nui-hidden" name="paramCheck/lParamCheckId" id="paramCheck/lParamCheckId"/>
              <table style="width:100%;table-layout:fixed;" class="nui-form-table">
				<tr>
                    <td class="form_label" width="22%" align="right">接口名: </td>
                    <td colspan="1"  width="32%">
                        <input class="nui-textbox"  width="180" name="paramCheck/vcInterfaceName"   id="paramCheck/vcInterfaceName"
                        required="true" requiredErrorText="接口名不能为空!"  emptyText="请输入接口名"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" width="22%" align="right">接口名(中文): </td>
                    <td colspan="1"  width="32%">
                        <input class="nui-textbox"  width="180" name="paramCheck/vcInterfaceRealName"   id="paramCheck/vcInterfaceRealName"
                        required="true" requiredErrorText="接口名(中文)不能为空!"  emptyText="请输入接口名(中文)"/>
                    </td>
                </tr>
                  <tr>
                 	 <td class="form_label" width="22%" align="right">参数名: </td>
                     <td colspan="1" width="32%">
                        <input class="nui-textbox" width="180"  name="paramCheck/vcParamName"  id="paramCheck/vcParamName"  
                         	required="true" requiredErrorText="参数名不能为空!" emptyText="请输入参数名"
                        />
                    </td>
                  </tr>
                  <tr>
                 	 <td class="form_label" width="22%" align="right">参数名(中文): </td>
                     <td colspan="1" width="32%">
                        <input class="nui-textbox" width="180"  name="paramCheck/vcParamRealName"  id="paramCheck/vcParamRealName"  
                         	required="true" requiredErrorText="参数名(中文)不能为空!" emptyText="请输入参数名(中文)"
                        />
                    </td>
                 </tr>
                 
                 <tr>
                 	 <td class="form_label" width="22%" align="right">参数类型: </td>
                     <td colspan="1" width="32%">
                           <div   class="mini-combobox" style="width:180px;" popupWidth="180" textField="text" name="paramCheck/vcParamType"  
                            id="paramCheck/vcParamType" required="true" requiredErrorText="参数类型不能为空!" emptyText="请输入参数类型" 
                            url="./data/paramTypeData.txt" valueField="id"    
                         >
                    </td>
                 </tr>
                 <tr>
                 	 <td class="form_label" width="22%" align="right">参数值长度: </td>
                     <td colspan="1" width="32%">
                        <input class="nui-textbox" width="180"  name="paramCheck/vcParamLength"  id="paramCheck/vcParamLength"  
                         	required="true" requiredErrorText="参数值长度不能为空!" emptyText="请输入(数字类型请按“长度,精度“形式填写)"
                         	onvaluechanged="checkLength(this.value)"
                        />
                    </td>
                 </tr>
                 <tr>
                 	 <td class="form_label" width="22%" align="right">是否必须: </td>
                     <td colspan="1" width="32%">
                         
                        	<div   class="mini-radiobuttonlist"  repeatLayout="table" repeatDirection="vertical"
							    textField="text" valueField="id" value="cn"  name="paramCheck/vcIsNeed" id="paramCheck/vcIsNeed"
							    url="./data/needData.txt" required="true" requiredErrorText="是否必须不能为空!" >
                    </td>
                 </tr>
            </table>
          
          <div class="nui-toolbar" style="padding:12px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">保存 </a>
                            <span style="display:inline-block;width:25px;">
                            </span>
                            <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">取消</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        
        <script type="text/javascript">
            nui.parse();
	
	        //关闭窗口
	        function CloseWindow(action) {
	            if (action == "close" && form.isChanged()) {
	                if (confirm("数据被修改了，是否先保存？")) {
	                  //  saveData();
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
            
          
            function saveData(){

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
               
                var vcInterfaceName=nui.getbyName("paramCheck/vcInterfaceName").getValue();//
                var vcInterfaceRealName=nui.getbyName("paramCheck/vcInterfaceRealName").getValue();//
                var vcParamName=nui.getbyName("paramCheck/vcParamName").getValue();//
                var vcParamRealName=nui.getbyName("paramCheck/vcParamRealName").getValue();//
                var vcParamType=nui.getbyName("paramCheck/vcParamType").getValue();//
                var vcParamLength=nui.getbyName("paramCheck/vcParamLength").getValue();// 
                 
                if(vcInterfaceName==null||vcInterfaceName==""){
                	mini.alert("接口名不能为空!!","系统提示");
                	return false;
                }
                
                if(vcInterfaceRealName==null||vcInterfaceRealName==""){
                	mini.alert("接口名(中文)不能为空!","系统提示");
                	return false;
                }
                if(vcParamRealName==null||vcParamRealName==""){
                	mini.alert("参数名（中文）不能为空!","系统提示");
                	return false;
                }
                 if(vcParamName==null||vcParamName==""){
                	mini.alert("参数名不能为空!","系统提示");
                	return false;
                }
                if(vcParamType==null||vcParamType==""){
                	mini.alert("参数类型不能为空!!","系统提示");
                	return false;
                }
                if(vcParamLength==null||vcParamLength==""){
                	mini.alert("参数值长度不能为空!!","系统提示");
                	return false;
                }
                //参数长度检测
                var lengthValue = nui.getbyName("paramCheck/vcParamLength").getValue();
                if(nui.getbyName("paramCheck/vcParamType").getValue()=="BigDecimal"){
            		if(lengthValue.split(",").length>=3){
            			nui.alert("请输入数字或者\"数字,数字\"的形式");
            			return false; 
            		}else if(lengthValue.split(",").length==2){
            			if(!isNum(lengthValue.split(",")[0])||!isNum(lengthValue.split(",")[1])){
            				nui.alert("请输入数字或者\"数字,数字\"的形式");
            				return false; 
            			}
            		}else{
            			if(!isNum(lengthValue)){
            				nui.alert("请输入数字或者\"数字,数字\"的形式");
            				return false; 
            			}
            		}
            	}else if(nui.getbyName("paramCheck/vcParamType").getValue()=="String"){
            		if(!isNum(lengthValue)){
            			nui.alert("请输入数字或者\"数字,数字\"的形式");
            			return false; 
            		}
            	}
                
                var urlStr ="";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                     nui.getbyName("paramCheck/opType").setValue("edit");//
                     urlStr = "com.cjhxfund.cjapi.common.ParamCheck.saveOrUpdateParamCheck.biz.ext";
                }else{
                     nui.getbyName("paramCheck/opType").setValue("add");//
                  	 urlStr = "com.cjhxfund.cjapi.common.ParamCheck.saveOrUpdateParamCheck.biz.ext";
                }
                
                form.validate();
                if(form.isValid()==false) return;
                var data = form.getData(false,true);
                var json = nui.encode(data);
                $.ajax({
                    url:urlStr,
                    type:'POST', 
                    data:json,
                    cache:false,
                    async: false,///异步..
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                          	nui.alert("保存成功", "系统提示");
                            CloseWindow("saveSuccess");
                        }else{
                            nui.alert("保存失败", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                    CloseWindow("cancel");
                                }
                            });
                        }
                    }
                }); 
            }
            
              //取消
            function onCancel() {
                 CloseWindow("cancel");
            }
                    
             
                
         	//页面间传输json数据
            function setFormData(data){
                //跨页面传递的数据对象，克隆后才可以安全使用
               	 var infos = nui.clone(data);
                //保存list页面传递过来的页面类型：add表示新增、edit表示编辑
                 if(infos.pageType=="edit"){
                 	 var lParamCheckId=infos.record.paramCheck.lParamCheckId;
                 	 var vcInterfaceRealName=infos.record.paramCheck.vcInterfaceRealName;
                 	 var vcInterfaceName=infos.record.paramCheck.vcInterfaceName;
                 	 var vcParamRealName=infos.record.paramCheck.vcParamRealName;
                 	 var vcParamName=infos.record.paramCheck.vcParamName;
                 	 var vcParamType=infos.record.paramCheck.vcParamType;
                 	 var vcIsNeed=infos.record.paramCheck.vcIsNeed;
                 	 var vcParamLength=infos.record.paramCheck.vcParamLength;
                 	 
                 	 nui.getbyName("paramCheck/lParamCheckId").setValue(lParamCheckId);
                 	 nui.getbyName("paramCheck/vcInterfaceName").setValue(vcInterfaceName);
                 	 nui.getbyName("paramCheck/vcParamName").setValue(vcParamName);
                 	 nui.getbyName("paramCheck/vcParamType").setValue(vcParamType);
                 	 nui.getbyName("paramCheck/vcIsNeed").setValue(vcIsNeed);
                 	 nui.getbyName("paramCheck/vcInterfaceRealName").setValue(vcInterfaceRealName);
                 	 nui.getbyName("paramCheck/vcParamRealName").setValue(vcParamRealName);
                 	 nui.getbyName("paramCheck/vcParamLength").setValue(vcParamLength);
                 	 
                 }
            }
            function isNum(num){
		        var reNum =/^[0-9]+$/;
		        return (reNum.test(num));
		     }
            function checkLength(value){
            	if(nui.getbyName("paramCheck/vcParamType").getValue()=="BigDecimal"){
            		if(value.split(",").length>=3){
            			nui.alert("请输入数字或者\"数字,数字\"的形式");
            		}else if(value.split(",").length==2){
            			if(!isNum(value.split(",")[0])||!isNum(value.split(",")[1])){
            				nui.alert("请输入数字或者\"数字,数字\"的形式");
            			}
            		}else{
            			if(!isNum(value)){
            				nui.alert("请输入数字或者\"数字,数字\"的形式");
            			}
            		}
            		return true; 
            	}else if(nui.getbyName("paramCheck/vcParamType").getValue()=="String"){
            		//alert(!isNum(value));
            		if(!isNum(value)){
            			nui.alert("请输入数字或者\"数字,数字\"的形式");
            		}
            	}
            }
            
              </script>
       </body>
  </html>
