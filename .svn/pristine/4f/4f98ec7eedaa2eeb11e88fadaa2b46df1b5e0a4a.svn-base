<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 翟静
  - Date: 2016-11-10 10:47:27
  - Description:
-->
<head>
<title>公司信息维护</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    
</head>
<body>
       <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;width: 100%;height:86%;" >
            <!-- hidden域 -->
            <input class="nui-hidden"  id="lCompanyId"  name="TAtsCompanyInfo.lCompanyId"/>
            <table style="width:100%;height:aotu;table-layout:fixed;" class="nui-form-table" cellspacing="0" cellpadding="0" border-collapse="collapse" padding="0px" marign="0px">
                <tr>
                    <td class="form_label" align="right"  style="width: 80px;">
                        	<span style="color:red">*</span>&nbsp;公司名称:
                    </td>
                    <td colspan="1">
                    		<input style="width: 100%;" class="nui-textbox" id="vcCompanyName"  name="TAtsCompanyInfo.vcCompanyName" required="true"/>
                    </td>
                    <td class="form_label" align="right"  style="width: 95px;">
                        	<span style="color:red">*</span>&nbsp;法定代表人:
                    </td>
                    <td colspan="1">
                    		<input style="width: 100%;" class="nui-textbox" id="vcCompanyLegalizer"  name="TAtsCompanyInfo.vcCompanyLegalizer" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right" >
                        	<span style="color:red">*</span>经办人姓名:
                    </td>
                    <td colspan="1">
                    		<input style="width: 100%;" class="nui-textbox" id="vcOperatorName"  name="TAtsCompanyInfo.vcOperatorName" required="true"/>
                    </td>
                    <td class="form_label" align="right" >
                        	<span style="color:red">*</span>经办人身份证号:
                    </td>
                    <td colspan="1"  >
                    	<input style="width: 100%;" class="nui-textbox" id="vcOperatorIdcard"  name="TAtsCompanyInfo.vcOperatorIdcard" required="true"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label" align="right"  >
                        	<span style="color:red">*</span>&nbsp;营业执照:
                    </td>
                    <td colspan="1">
                    		<input style="width: 100%;" class="nui-textbox" id="vcBusinessLicence"  name="TAtsCompanyInfo.vcBusinessLicence" required="true"/>
                    </td>
                    <td class="form_label" align="right" >
                        	邮编:
                    </td>
                    <td colspan="1">
                    		<input style="width: 100%;" class="nui-textbox" id="vcPostCode"  name="TAtsCompanyInfo.vcPostCode" />
                    </td>
                </tr>
                <tr>
                	<td class="form_label" align="right"  >
	   					          联系电话:
                    </td>
                    <td colspan="1" style="height: 30">
                       <input style="width: 100%;" class="nui-textbox" id="vcTelephone"  name="TAtsCompanyInfo.vcTelephone" onvaluechanged="check(this.value)"/> 
                    </td>
                     <td class="form_label" align="right">
                                                                                     联系手机:
                    </td>
                    <td colspan="1">
                         <input style="width: 100%;" class="nui-textbox" id="vcPhone"  name="TAtsCompanyInfo.vcPhone" onvaluechanged="check1(this.value)"/> 
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right" >
                                                                                     电子邮箱:
                    </td>
                    <td colspan="3">
                         <input style="width: 100%;"  class="nui-textbox" id="vcEmail"  name="TAtsCompanyInfo.vcEmail" /> 
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right"  >
                        	<span style="color:red">*</span>&nbsp;通讯地址:
                    </td>
                    <td colspan="3">
                    		<input style="width: 100%;" class="nui-textbox" id="vcPostalAddress"  name="TAtsCompanyInfo.vcPostalAddress" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right" >
                        	<span style="color:red">*</span>&nbsp;注册地址:
                    </td>
                    <td colspan="3">
                    		<input style="width: 100%;" class="nui-textbox" id="vcRegisteredAddress"  name="TAtsCompanyInfo.vcRegisteredAddress" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                                                                                              备注:
                    </td>
                    <td colspan="3">
                         <input class="nui-textarea" id="vcRemarks" width="100%" height="50" name="TAtsCompanyInfo.vcRemarks"/>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-toolbar" style="border:0; top:0px">
		    <table style="width:100%;">
		       <tr>
		           <td style="text-align:center;">
		               	<a class='nui-button' plain='false' style="width:60px;" iconCls="icon-save" onclick="onOk()">保存</a>
		        		<span style="display:inline-block;width:25px;"></span>
		        		<a class='nui-button' plain='false' style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
		           </td>
		       </tr>
		    </table>
		</div>   
        


	<script type="text/javascript">
    	nui.parse();
    	
    	 function saveData(){

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //保存
                var urlStr = "com.cjhxfund.ats.fm.baseinfo.ApplyTemplet.addCompanyInfo.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.cjhxfund.ats.fm.baseinfo.ApplyTemplet.updateCompanyInfo.biz.ext";
                }
                form.validate();
                if(form.isValid()==false){
                 nui.alert("页面校验不通过，请检查必输项！","",function(){});
                 return;
                }
                
                var idCard = nui.get("vcOperatorIdcard").getValue();
                if(idCard.length != 18){
                  nui.alert("身份证号输入有误，请检查！","",function(){});
                  return;
                }
                var vcCompanyName = nui.get("vcCompanyName").getValue();
                var vcCompanyLegalizer = nui.get("vcCompanyLegalizer").getValue();
                var vcOperatorName = nui.get("vcOperatorName").getValue();
                 /* if(!validName(vcCompanyName)){
	                 nui.alert("公司名称输入含有特殊字符，请检查！","",function(){});
	                 return;
                 }  
                 if(!validName(vcCompanyLegalizer)){
	                 nui.alert("法定代表人输入含有特殊字符，请检查！","",function(){});
	                 return;
                 } 
                 if(!validName(vcOperatorName)){
	                 nui.alert("经办人姓名输入含有特殊字符，请检查！","",function(){});
	                 return;
                 } */
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
                            nui.alert("保存成功！","",function(action){
                             CloseWindow("saveSuccess");
                            });
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
                    //校验特殊字符
					 function validName(name){
						var re=/^[A-Za-z0-9_\u554A-\u9C52]+$/;
						if(re.test(name)){
							return true;
						}else{
				        	return false; 
						}
						}
				     //校验手机号码
					 function check(num){  
					        if(isNum(num)){
					        }else{
					            nui.alert("输入格式不正确,请输入数字");
					            nui.get("vcTelephone").setValue("");
					            return false;
					        }
						    } 
				    function check1(num){  
					        if(isNum(num)){
					        }else{
					            nui.alert("输入格式不正确,请输入数字");
					            nui.get("vcPhone").setValue("");
					            return false;
					        }
						    } 
				     function isNum(num){
				        var reNum =/^[0-9]+$/;
				        return (reNum.test(num));
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
    </script>
</body>
</html>