<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/CFJYProductProcessForm_show_common.jsp" %>
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
            <input class="nui-hidden" name="cfjyproductprocess.processId"/>
            <input class="nui-hidden" name="cfjyproductprocess.processStatus" id="processStatus"/>
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td align="right" width="23%">
                        业务日期:
                    </td>
                    <td colspan="3" width="77%">
                        <input readonly="readonly" style="width:150px;" id="processDate" class="nui-datepicker" name="cfjyproductprocess.processDate" required="true" value=""/>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="23%">
                        产品名称:
                    </td>
                    <td colspan="1" width="27%">
                        <input readonly="readonly" id="combProductCode" required="true" class="nui-autocomplete" style="width:150px;" name="cfjyproductprocess.combProductCode" searchField="searchKey" dataField="combProducts"
                        	valueField="fundCode" textField="fundName" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductsByKeyAndUserId.biz.ext" value="" text="" enterQuery="false" onvaluechanged="changedCombProductCode"/>
                        <input id="combProductName" class="nui-hidden" name="cfjyproductprocess.combProductName"/>
                    </td>
                    <td align="right" width="23%">
                        组合名称:
                    </td>
                    <td colspan="1" width="27%">
                    	<!-- <input readonly="readonly" class="nui-combobox" id="vcCombiNo"  required="true" dataField="productCombis"  name="cfjyproductprocess.vcCombiNo" 
	                        valueField="vcCombiNo" textField="vcCombiName" onvaluechanged="setVcCombiName" searchField="searchKey"  enterQuery="false"/> -->
	                      <input class="nui-hidden" id="vcCombiNo" name="cfjyproductprocess.vcCombiNo"/>  
	                      <input readonly="readonly" style="width:150px;" class="nui-textbox" style="width:150px;" id="vcCombiName" required="true" name="cfjyproductprocess.vcCombiName"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        内容:
                    </td>
                    <td colspan="3">
                        <input readonly="readonly" id="memo" class="nui-textarea" name="cfjyproductprocess.memo" width="95%" height="170px" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        备注:
                    </td>
                    <td colspan="3">
                        <input readonly="readonly" class="nui-textarea"name="cfjyproductprocess.remark" width="95%" height="80px"/>
                    </td>
                </tr>
                
                <tr id = "id">
                    <td align="right">
                       执行备注:
                    </td>
                    <td colspan="3">
                        <input id="earlyWithdrawalClause" class="nui-textarea" name="cfjyproductprocess.earlyWithdrawalClause" width="95%" height="80px"/>
                    </td>
                </tr>
                 <tr>
	                  <td align="right">
	                        附件上传:
	                  </td>
	                  <td colspan="3">
	                     <iframe id="prodIfm" width="95%"  height="130px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"  ></iframe>
	                  </td>
	             </tr>
            </table>
            <div class="nui-toolbar" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a id="confirm" class='nui-button' plain='false' iconCls="icon-ok" onclick="onOk()">
                                确认
                            </a>
                            <span style="display:inline-block;width:25px;"></span>
                            <a id="goBack" class='nui-button' plain='false' iconCls="icon-no" onclick="onGoBack()">
                                退回
                            </a>
                            <span style="display:inline-block;width:25px;"></span>
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
            //nui.get("confirm").disable();//将“确认”按钮设置为不可用
            nui.get("goBack").disable();//将“退回”按钮设置为不可用
            var rowPageType = "";//页面类型
            var rowRecord;//保存行记录数据，确认时使用
            var tradingConfirmAuthorityUserIds = "";//交易确认阶段权限人员名单字符串，确认时使用
            var backstageConfirmAuthorityUserIds = "";//后台已成交阶段权限人员名单字符串，确认时使用
            
            //隐藏执行备注输入框
            //document.getElementById('id').style.display ="none";
            
			//页面间传输json数据
			function setFormData(data){
				//跨页面传递的数据对象，克隆后才可以安全使用
				var infos = nui.clone(data);
				var roleType = infos.roleType;  //参与者类型
				if(roleType == "TG"){
					readonlyInput("earlyWithdrawalClause","earlyWithdrawalClause");
				}
				//保存list页面传递过来的页面类型：add表示新增、edit表示编辑、query表示查询
				nui.getbyName("pageType").setValue(infos.pageType);
				
				
				
				rowPageType = infos.pageType;//页面类型
				rowRecord = infos.record.cfjyproductprocess;
				var json = infos.record;
				var form = new nui.Form("#dataform1");//将普通form转为nui的form
				
				//设置产品名称值
				var combProductNameVal = json.cfjyproductprocess.combProductName;
				nui.get("combProductCode").setText(combProductNameVal);//设置产品名称值
				nui.get("combProductName").setValue(combProductNameVal);
				
				
				
				//设置表单数据公共逻辑处理
				setFormDataCommon(form, json, infos);
				//指令/建议状态
				var processStatus = json.cfjyproductprocess.processStatus;
				//初始化附件列表
				var prodIfm = document.getElementById("prodIfm");   
				prodIfm.src = "<%= request.getContextPath() %>/ProductProcess/JY_QTZL/fileUpload_QTZL.jsp?bizId="+json.cfjyproductprocess.investProductNum+"&attachType=0&attachBusType=0&pageType="+infos.pageType+"&processId=&processStatus="+processStatus;
			}
			
			function commonLoading(msg,title){
		    	return nui.loading(msg,title);
		    }
		
		    function commonHideMessageBox(messageid){
		    	 nui.hideMessageBox(messageid);
		    }
		    
		    /*禁用nui的input文本框，达到效果为：不可修改，可复制，置灰
			*inputNuiId nui使用的id 即 控件的id属性值
			*inputJQId jquery使用的id,jquery id不支持特殊符号 如“。”需要转义，即传入控件的id属性值转义的值
			*/
			function readonlyInput(inputNuiId,inputJQId){
				nui.get(inputNuiId).readOnly="readonly";//nui禁用
				$("#"+inputJQId+" textarea").attr("readonly","readonly");//解决nui禁用IE兼容
				//$("#"+inputJQId+" input").css("background-color","#f0f0f0");//置灰
			}
			
        </script>
    </body>
</html>
