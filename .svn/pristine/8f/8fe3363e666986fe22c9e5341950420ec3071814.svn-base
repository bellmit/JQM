<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/CFJYProductProcessForm_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2015-10-09 11:42:39
- Description: 指令/建议录入指令/建议单_基金申赎业务
--%>
<head>
<title>指令/建议录入指令/建议单_基金申赎业务</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <input class="nui-hidden" name="cfjyproductprocess.processType4InvestProductNum" value="09,10,11"/>
            <input class="nui-hidden" name="cfjyproductprocess.processId"/>
            <input class="nui-hidden" name="cfjyproductprocess.processStatus" id="processStatus"/>
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td align="right" width="23%">
                        业务日期:
                    </td>
                    <td colspan="1" width="27%">
                        <input id="processDate" style="width:150px;" class="nui-datepicker" name="cfjyproductprocess.processDate" required="true" value=""/>
                    </td>
                    <td align="right">
                        业务类别:
                    </td>
                    <td colspan="1">
                        <input id="processType" style="width:150px;" class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_JJSS" name="cfjyproductprocess.processType" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" onitemclick="processTypeOnItemClick"/>
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
	                        valueField="vcCombiNo" textField="vcCombiName" onvaluechanged="setVcCombiName" searchField="searchKey" value="" text="" enterQuery="false"/>
	                      <input class="nui-hidden" id="vcCombiName" name="cfjyproductprocess.vcCombiName"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        基金代码:
                    </td>
                    <td colspan="1">
                        <input id="investProductCode" style="width:150px;" required="true" class="nui-autocomplete" popupWidth="300" popupHeight="133" name="cfjyproductprocess.investProductCode" searchField="searchKey" dataField="investProducts"
                        	valueField="investProductCode" textField="investProduct" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByKey.biz.ext" value="" text="" enterQuery="false" onitemclick="investProductCodeOnItemClick"/>
                    </td>
                    <td align="right">
                        基金名称:
                    </td>
                    <td colspan="1">
                        <input id="investProductName" style="width:150px;" class="nui-textbox" style="width:150px;" name="cfjyproductprocess.investProductName" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <span id="investCountText">数量:</span>
                    </td>
                    <td colspan="1">
                        <input id="investCount" style="width:150px;" class="nui-textbox" name="cfjyproductprocess.investCount" required="true" onblur="investCountFun()"/>
                    </td>
                    <td align="right">
                        转入基金代码:
                    </td>
                    <td colspan="1">
                        <input id="transformFundCode" style="width:150px;" required="false" class="nui-autocomplete" popupWidth="300" popupHeight="90" name="cfjyproductprocess.transformFundCode" searchField="searchKey" dataField="investProducts"
                        	valueField="investProductCode" textField="investProduct" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByKey.biz.ext" value="" text="" enterQuery="false" onitemclick="transformFundCodeOnItemClick"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        转入基金名称:
                    </td>
                    <td colspan="1">
                        <input id="transformFundName" style="width:150px;" class="nui-textbox" name="cfjyproductprocess.transformFundName" required="false"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        备注:
                    </td>
                    <td colspan="3">
                        <input class="nui-textarea"  name="cfjyproductprocess.remark" width="100%" height="105px"/>
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
                
                
                //特殊验证，业务类别：09-基金申购;10-基金赎回;11-基金转换
                var processTypeVal = nui.get("processType").value;//业务类别
                var transformFundCodeVal = nui.get("transformFundCode").value;//转入基金代码
                var transformFundNameVal = nui.get("transformFundName").value;//转入基金名称
                //11-基金转换
                if(processTypeVal=="11"){
                	if(transformFundCodeVal==null || transformFundCodeVal==""){
                		nui.alert("转入基金代码不能为空","提示");
                		nui.get("transformFundCode").focus();
				        return;
                	}
                	if(transformFundNameVal==null || transformFundNameVal==""){
                		nui.alert("转入基金名称不能为空","提示");
                		nui.get("transformFundName").focus();
				        return;
                	}
                }
                
                
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

                        //保存list页面传递过来的页面类型：add表示新增、edit表示编辑
                        nui.getbyName("pageType").setValue(infos.pageType);

                        //如果是点击编辑类型页面
                        if (infos.pageType == "edit") {
                            var json = infos.record;

                            var form = new nui.Form("#dataform1");//将普通form转为nui的form
                            
                            //设置产品名称值
                            var combProductNameVal = json.cfjyproductprocess.combProductName;
                            nui.get("combProductCode").setText(combProductNameVal);//设置产品名称值
                			nui.get("combProductName").setValue(combProductNameVal);
                			
					        //设置基金代码显示值
							var investProductCodeVal = json.cfjyproductprocess.investProductCode;
					        nui.get("investProductCode").setText(investProductCodeVal);
					        
					        //设置转入基金代码显示值
							var transformFundCodeVal = json.cfjyproductprocess.transformFundCode;
					        nui.get("transformFundCode").setText(transformFundCodeVal);
					        
					        
					        //业务类别：09-基金申购;10-基金赎回;11-基金转换
					        var processTypeVal = json.cfjyproductprocess.processType;
					        if(processTypeVal=="09"){
			            		document.getElementById("investCountText").innerHTML = "数量（元）:";
			            	}else if(processTypeVal=="10"){
			            		document.getElementById("investCountText").innerHTML = "数量（份额）:";
			            	}else{
			            		document.getElementById("investCountText").innerHTML = "数量:";
			            	}
                            
                            
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
                        }
                    }

                    //自动增加千分位-数量（元/份额）
                    function investCountFun(){
                    	formatNumberCommon("investCount");
                    }
                    
                    //基金代码下拉项点击时触发函数
		            function investProductCodeOnItemClick(){
		            	//获取投资产品（债券）名称值
		                var investProductNameVal = "";
		                var investProductCodeVal = nui.get("investProductCode").getValue();//投资产品（债券）代码值
		                var investProductCodeText = nui.get("investProductCode").getText();//投资产品（债券）名称值（从表单显示值取）
		                if(investProductCodeText!=null && investProductCodeText!="" && (investProductCodeText.length>investProductCodeVal.length+1)){
		                	investProductNameVal = investProductCodeText.substr(investProductCodeVal.length+1,investProductCodeText.length);
		                }
		                nui.get("investProductCode").setText(investProductCodeVal);
		                nui.get("investProductName").setValue(investProductNameVal);
		            }
		            
		            //转入基金代码下拉项点击时触发函数
		            function transformFundCodeOnItemClick(){
		            	//获取投资产品（债券）名称值
		                var transformFundNameVal = "";
		                var transformFundCodeVal = nui.get("transformFundCode").getValue();//投资产品（债券）代码值
		                var transformFundCodeText = nui.get("transformFundCode").getText();//投资产品（债券）名称值（从表单显示值取）
		                if(transformFundCodeText!=null && transformFundCodeText!="" && (transformFundCodeText.length>transformFundCodeVal.length+1)){
		                	transformFundNameVal = transformFundCodeText.substr(transformFundCodeVal.length+1,transformFundCodeText.length);
		                }
		                nui.get("transformFundCode").setText(transformFundCodeVal);
		                nui.get("transformFundName").setValue(transformFundNameVal);
		            }
		            
		            //业务类别下拉项点击时触发函数
		            function processTypeOnItemClick(){
		            	var processType = nui.get("processType").getValue();//业务类别值：09-基金申购;10-基金赎回;11-基金转换
		            	if(processType=="09"){
		            		document.getElementById("investCountText").innerHTML = "数量（元）:";
		            	}else if(processType=="10"){
		            		document.getElementById("investCountText").innerHTML = "数量（份额）:";
		            	}else{
		            		document.getElementById("investCountText").innerHTML = "数量:";
		            	}
		            }
                </script>
            </body>
        </html>
