<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2015-10-14 10:47:44
- Description: 产品组合权限关系录入
--%>
    <head>
        <title>
            产品组合权限关系录入
        </title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
    </head>
    <body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td class="form_label" align="right" width="20%">
                        权限类型:
                    </td>
                    <td colspan="1" align="left" width="80%">
                        <input id="relaType" class="nui-dictcombobox" dictTypeId="CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE" name="cfjycombproducthandle.relaType" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" width="200px" onvaluechanged="relaTypeValueChangedFun"/>
                    </td>
                 </tr>
                 <tr>
                    <td class="form_label" align="right">
                        产品&组合名称:
                    </td>
                    <td colspan="1" align="left">
                        <input id="combProductCode" required="true" class="nui-textboxlist" style="width:453px;" name="cfjycombproducthandle.combProductCode" searchField="searchKey" dataField="productCombis"
                        	valueField="fundInfo" textField="fundInfo" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductCombisByKey.biz.ext" value="" text=""/>
                        <input id="combProductName" class="nui-hidden" name="cfjycombproducthandle.combProductName"/>
                        <input id="vcCombiNo" class="nui-hidden" name="cfjycombproducthandle.vcCombiNo"/>
                        <input id="vcCombiName" class="nui-hidden" name="cfjycombproducthandle.vcCombiName"/>
                        <input id="vcAssetId" class="nui-hidden" name="cfjycombproducthandle.vcAssetId"/>
                    </td>
                 </tr>
                 <tr>
                    <td class="form_label" align="right">
                        关联用户:
                    </td>
                    <td colspan="1" align="left">
                        <input id="userIdList" required="true" name="cfjycombproducthandle.userId" allowInput="false" showClose="true" oncloseclick="onCloseClick" class="nui-buttonEdit nui-form-input" onbuttonclick="selectUser" width="430px;"/>
                    	<input id="userName" class="nui-hidden" name="cfjycombproducthandle.userName"/>
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
                form.setChanged(false);
                //保存
                var urlStr = "com.cjhxfund.jy.ProductProcess.CFJYCombProductHandleBiz.addCFJYCombProductHandle.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.cjhxfund.jy.ProductProcess.CFJYCombProductHandleBiz.updateCFJYCombProductHandle.biz.ext";
                }
                form.validate();
                if(form.isValid()==false) return;
                
                //特殊验证，权限关系类型：01-组合与投顾录入权限；07-组合与投顾确认权限；02-组合与投资经理权限；03-组合与交易员权限；04-组合与复核员权限；05-组合与送单员权限；06-组合与后台成交员权限；98-后台成交确认阶段权限；99-交易确认阶段权限；A1-投顾录入确认可为同一人员；
                var relaType = nui.get("relaType").getValue();
                if(relaType!="99" && relaType!="98"){//若不是配置“99-交易确认阶段权限”或“98-后台已成交确认阶段权限”，则产品&组合名称必输
                	//获取产品&组合名称
	                var combProductCodeVal = "";//产品代码
	                var combProductNameVal = "";//产品名称
	                var vcCombiNoVal = "";//投资组合编号
	                var vcCombiNameVal = "";//投资组合名称
	                var vcAssetIdVal = "";//资产单元序号
	                var fundInfos = nui.get("combProductCode").getValue();
	                
	                if(fundInfos==null || fundInfos==""){
                		nui.alert("产品&组合名称不能为空","提示");
        				return;
                	}
                	var fundInfoArr = fundInfos.split(",");
                	for(var i=0; i<fundInfoArr.length; i++){
                		var fundInfo = fundInfoArr[i];
                		if(fundInfo!=null && fundInfo!="" && fundInfo.split("|").length==5){
                			var fundArr = fundInfo.split("|");
	                		combProductCodeVal += fundArr[0] + ",";//产品代码
			                combProductNameVal += fundArr[1] + ",";//产品名称
			                vcCombiNoVal += fundArr[2] + ",";//投资组合编号
			                vcCombiNameVal += fundArr[3] + ",";//投资组合名称
			                vcAssetIdVal += fundArr[4] + ",";//资产单元序号
                		}
                	}
                	
                	
	                if(combProductCodeVal!=null && combProductCodeVal!=""){
	                	combProductCodeVal = combProductCodeVal.substr(0,combProductCodeVal.length-1);
	                	combProductNameVal = combProductNameVal.substr(0,combProductNameVal.length-1);
	                	vcCombiNoVal = vcCombiNoVal.substr(0,vcCombiNoVal.length-1);
	                	vcCombiNameVal = vcCombiNameVal.substr(0,vcCombiNameVal.length-1);
	                	vcAssetIdVal = vcAssetIdVal.substr(0,vcAssetIdVal.length-1);
	                }
	                nui.get("combProductCode").setValue(combProductCodeVal);
	                nui.get("combProductName").setValue(combProductNameVal);
	                nui.get("vcCombiNo").setValue(vcCombiNoVal);
	                nui.get("vcCombiName").setValue(vcCombiNameVal);
	                nui.get("vcAssetId").setValue(vcAssetIdVal);
                	
                //若配置为“99-交易确认阶段权限”或“98-后台已成交确认阶段权限”，则给产品代码、产品名称等赋予特定值
                }else{
                	nui.get("combProductCode").setValue("All Products");
                	nui.get("combProductName").setValue("全部产品");
                	nui.get("vcCombiNo").setValue("All Combis");
                	nui.get("vcCombiName").setValue("全部组合");
                	nui.get("vcAssetId").setValue("All Assets");
                }
                
                if(relaType!="A1"){//若不是配置“投顾录入确认可为同一人员”，则关联用户必输
                	//重新设置用户ID、用户姓名
	                var userIdVal = "";
	                var userNameVal = "";
	                var userIdList = nui.get("userIdList").getValue();//用户ID值
	                if(userIdList!=null && userIdList!=""){
	                	var userIdListArr = userIdList.split(",");
	                	for(var i=0; i<userIdListArr.length; i++){
	                		var userIdArr = userIdListArr[i].split(":");
	                		var userId = userIdArr[0];
	                		var userName = userIdArr[1];
	                		
	                		userIdVal += userId + ",";
	                		userNameVal += userName + ",";
	                	}
	                }
	                if(userIdVal!="" && userIdVal.length>0){
	                	userIdVal = userIdVal.substr(0,userIdVal.length-1);
	                }
	                if(userNameVal!="" && userNameVal.length>0){
	                	userNameVal = userNameVal.substr(0,userNameVal.length-1);
	                }
	                nui.get("userIdList").setValue(userIdVal);
	                nui.get("userName").setValue(userNameVal);
                }else{
                	nui.get("userIdList").setValue("All Users");
	                nui.get("userName").setValue("全部用户");
                }
                

				//获取表单值
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
                
            //设置值为空
            function onCloseClick(e){
		    	var btnEdit = e.sender;
		        btnEdit.setValue("");
		        btnEdit.setText("");
		    }
		    
		    //选择用户
		    function selectUser(e) {
		        var btnEdit = this;
		        nui.open({
		            url: "<%=request.getContextPath() %>/commonUtil/coframeSupplement/select_employee.jsp",
		            showMaxButton: false,
		            title: "选择用户",
		            width: 500,
		            height: 580,
		            onload:function(){
		                var iframe = this.getIFrameEl();
		                var ids = btnEdit.getValue();
		                var texts = btnEdit.getText();
		                var data = {
		                   ids:ids,
		                   texts:texts
		                };
		                iframe.contentWindow.SetData(data);
		            },
		            ondestroy: function (action) {
		                if (action == "ok") {
		                    var iframe = this.getIFrameEl();
		                    var data = iframe.contentWindow.GetData();
		                    data = nui.clone(data);
		                    if (data) {
		                        btnEdit.setValue(data.id);
		                        btnEdit.setText(data.text);
		                    }
		                }
		            }
		        });            
		    }
		    
		    //值变换时触发函数-权限类型
		    function relaTypeValueChangedFun(cmp){
		    	var relaType = nui.get("relaType").getValue();
                if(relaType!="99" && relaType!="98"){//若不是配置“99-交易确认阶段权限”或“98-后台已成交确认阶段权限”，则产品&组合名称必输
                	nui.get("combProductCode").setRequired(true);
                }else{
                	nui.get("combProductCode").setRequired(false);
                }
                
                if(relaType!="A1"){//若不是配置“投顾录入确认可为同一人员”，则关联用户必输
                	nui.get("userIdList").setRequired(true);
                }else{
                	nui.get("userIdList").setRequired(false);
                }
		    }

          </script>
    </body>
</html>
