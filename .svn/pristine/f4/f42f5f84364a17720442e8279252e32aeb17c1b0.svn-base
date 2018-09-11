<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/CFJYProductProcessForm_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2015-11-25 11:42:39
- Description: 指令/建议录入指令/建议单_其他指令/建议业务
--%>
<head>
<title>指令/建议录入指令/建议单_其他指令/建议业务</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <input class="nui-hidden" name="cfjyproductprocess.processType4InvestProductNum" value="99"/>
            <input class="nui-hidden" name="cfjyproductprocess.processType" value="99"/>
            <input class="nui-hidden" name="cfjyproductprocess.processId" id="processId"/>
            <input class="nui-hidden" name="cfjyproductprocess.processStatus" id="processStatus"/>
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td align="right" width="23%">
                        业务日期:
                    </td>
                    <td colspan="3" width="77%">
                        <input id="processDate" style="width:150px;" class="nui-datepicker" name="cfjyproductprocess.processDate" required="true" value=""/>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="23%">
                        产品名称:
                    </td>
                    <td colspan="1" width="27%">
                        <input id="combProductCode" required="true" class="nui-autocomplete" style="width:150px;" name="cfjyproductprocess.combProductCode" searchField="searchKey" dataField="combProducts"
                        	valueField="fundCode" textField="fundName" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductsByKeyAndUserId.biz.ext" value="" text="" enterQuery="false" onvaluechanged="changedCombProductCode"/>
                        <input id="combProductName" class="nui-hidden" name="cfjyproductprocess.combProductName"/>
                    </td>
                    <td align="right" width="23%">
                        组合名称:
                    </td>
                    <td colspan="1" width="27%">
                    	<input class="nui-combobox" style="width:150px;" id="vcCombiNo"  required="true" dataField="productCombis"  name="cfjyproductprocess.vcCombiNo" 
	                        valueField="vcCombiNo" textField="vcCombiName" onvaluechanged="setVcCombiName" searchField="searchKey" value="" text="" enterQuery="false" />
	                      <input class="nui-hidden" id="vcCombiName" name="cfjyproductprocess.vcCombiName"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        内容:
                   </td>
                    <td colspan="3">
                        <input id="memo" class="nui-textarea" name="cfjyproductprocess.memo" width="95%" height="170px" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        备注:
                    </td>
                    <td colspan="3">
                        <input class="nui-textarea"name="cfjyproductprocess.remark" width="95%" height="80px"/>
                    </td>
                </tr>
                <tr>
	                  <td align="right">
	                        附件上传:
	                  </td>
	                  <td colspan="3">
	                     <iframe id="prodIfm" width="95%"  height="140px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"  ></iframe>
	                  </td>
	             </tr>
            </table>
            <div class="nui-toolbar" borderStyle="border:0;">
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
            nui.get("processDate").setValue(new Date());

            function saveData(){

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //保存
                var urlStr = "com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.addCFJYProductProcess.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.updateCFJYProductProcess.biz.ext";
                }
                form.validate();
                if(form.isValid()==false) return;
                
                
                //获取产品名称值
                var combProductCodeVal = nui.get("combProductCode").getValue();//获取产品代码值
                var combProductNameVal = nui.get("combProductCode").getText();//获取产品名称值（从表单显示值取）
                nui.get("combProductName").setValue(combProductNameVal);
                if(combProductCodeVal==combProductNameVal){
                	nui.alert("请输入选择正确的产品名称","提示");
            		nui.get("combProductCode").focus();
			        return;
                }
                

                //保存数据
				saveDataCommon(form, pageType, urlStr);
				
			}

                    //页面间传输json数据
                    function setFormData(data){
                        //跨页面传递的数据对象，克隆后才可以安全使用
                        var infos = nui.clone(data);
						 var json = infos.record;
						 
                        //保存list页面传递过来的页面类型：add表示新增、edit表示编辑
                        nui.getbyName("pageType").setValue(infos.pageType);

                        //如果是点击编辑类型页面
                        if (infos.pageType == "edit") {

                            var form = new nui.Form("#dataform1");//将普通form转为nui的form
                            
                            //设置产品名称值
                            var combProductNameVal = json.cfjyproductprocess.combProductName;
                            nui.get("combProductCode").setText(combProductNameVal);//设置产品名称值
                			nui.get("combProductName").setValue(combProductNameVal);
                            
                            form.setData(json);
                            form.setChanged(false);
                            
                            //调用方法重新加载组合
					        changedCombProductCode();
					        //重新设置选择的组合
							var vcCombiNo = json.cfjyproductprocess.vcCombiNo;
							var vcCombiName = json.cfjyproductprocess.vcCombiName;
		
					        nui.get("vcCombiNo").setValue(vcCombiNo);
					        nui.get("vcCombiNo").setText(vcCombiName);
					        
					        //重新设置隐藏组合名称
					        nui.get("vcCombiName").setValue(nui.get("vcCombiNo").getText());
					        
					        //指令/建议状态
					        var processStatus = json.cfjyproductprocess.processStatus;
					  
					        //初始化附件列表
							var prodIfm = document.getElementById("prodIfm");   
							prodIfm.src = "<%= request.getContextPath() %>/ProductProcess/JY_QTZL/fileUpload_QTZL.jsp?bizId="+json.cfjyproductprocess.investProductNum+"&attachType=0&attachBusType=0&pageType="+infos.pageType+"&processId=&processStatus="+processStatus;
                        }
                        
                        if(infos.pageType == "add"){
                        	$.ajax({
								url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductProcessId.biz.ext",
								type:'POST',
								data:json,
								cache:false,
								contentType:'text/json',
								success:function(text){
									var returnJson = nui.decode(text);
									//初始化附件列表
									var prodIfm = document.getElementById("prodIfm");   
									prodIfm.src = "<%= request.getContextPath() %>/ProductProcess/JY_QTZL/fileUpload_QTZL.jsp?attachType=0&attachBusType=0&pageType="+infos.pageType+"&processId="+returnJson.cfjyproductprocess.processId+"&processStatus=-1";
									
									//设置主键ID
									nui.get("processId").setValue(returnJson.cfjyproductprocess.processId);		
								}
							});
                        }  
                    }
                    
                    function commonLoading(msg,title){
				    	return nui.loading(msg,title);
				    }
				
				    function commonHideMessageBox(messageid){
				    	 nui.hideMessageBox(messageid);
				    }

                </script>
            </body>
        </html>
