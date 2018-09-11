<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): tongwei
- Date: 2017-07-31 11:42:39
- Description: 指令/建议录入指令/建议单_投票
--%>
<head>
<title>指令/建议录入指令/建议单_投票</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
<script src="<%= request.getContextPath() %>/ProductProcess/CFJYProductProcessList_common.js" type="text/javascript"></script>

</head>
<body>
       <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <input class="nui-hidden" name="cfjyproductprocess.processType4InvestProductNum" value="20"/>
            <input class="nui-hidden" name="cfjyproductprocess.processType" value="20"/>
            <input class="nui-hidden" name="cfjyproductprocess.processId"/>
            <input class="nui-hidden" name="cfjyproductprocess.processStatus" id="processStatus"/>
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td align="right" width="23%">
                        业务日期:
                    </td>
                    <td colspan="3" width="77%">
                        <input id="processDate" style="width:150px;"  class="nui-datepicker" name="cfjyproductprocess.processDate" required="true" value=""/>
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
                    <td align="right" width="20%">
                        组合名称:
                    </td>
                    <td colspan="1" width="30%">
                    	<!-- <input readonly="readonly" class="nui-combobox" id="vcCombiNo"  required="true" dataField="productCombis"  name="cfjyproductprocess.vcCombiNo" 
	                        valueField="vcCombiNo" textField="vcCombiName" onvaluechanged="setVcCombiName" searchField="searchKey"  enterQuery="false"/> -->
	                      <input class="nui-hidden" id="vcCombiNo" name="cfjyproductprocess.vcCombiNo"/>  
	                      <input readonly="readonly" style="width:150px;"  class="nui-textbox" style="width:150px;" id="vcCombiName" required="true" name="cfjyproductprocess.vcCombiName"/>
                    </td>
                </tr>
                <tr>
                   <td align="right" width="23%">
                        证券代码:
                    </td>
                    <td colspan="1" width="27%">
                        <input id="investProductCode" style="width:150px;"  class="nui-autocomplete" popupWidth="300" popupHeight="200" name="cfjyproductprocess.investProductCode" searchField="searchKey" dataField="investProducts"
                        	valueField="investProductInfo" textField="investProduct" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByKey.biz.ext" value="" text="" enterQuery="false"
                        	onvaluechanged="enterSumbit" onitemclick="investProductCodeOnItemClick" readonly="readonly"/>
                    </td>
                    <td align="right" width="23%">
                       证券名称:
                    </td>
                    <td colspan="1" width="27%">
                        <input id="investProductName" style="width:150px;"  class="nui-textbox" style="width:150px;" name="cfjyproductprocess.investProductName" required="true" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        赞成议案:
                    </td>
                    <td colspan="3">
                        <input id="tpZcya"  class="nui-textarea" name="cfjyproductprocess.tpZcya" width="95%" height="80px" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        反对议案:
                    </td>
                    <td colspan="3">
                        <input id="tpFdyz"  class="nui-textarea" name="cfjyproductprocess.tpFdyz" width="95%" height="80px" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        弃权议案:
                    </td>
                    <td colspan="3">
                        <input id="tpQqya" class="nui-textarea" name="cfjyproductprocess.tpQqya" width="95%" height="80px" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
	                  <td align="right">
	                        附件上传:
	                  </td>
	                  <td colspan="3">
	                     <iframe id="prodIfm" width="590"  height="110px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"  ></iframe>
	                  </td>
	             </tr>
                <tr>
                    <td align="right">
                        备注:
                    </td>
                    <td colspan="3">
                        <input class="nui-textarea"name="cfjyproductprocess.remark" width="95%" readonly="readonly"/>
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
            
			//页面间传输json数据
			function setFormData(data){
				//跨页面传递的数据对象，克隆后才可以安全使用
				var infos = nui.clone(data);
				
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
				
				//设置显示债券代码
                nui.get("investProductCode").setText(json.cfjyproductprocess.investProductCode);
				
				//设置表单数据公共逻辑处理
				setFormDataCommon(form, json, infos);
				
				 var prodIfm = document.getElementById("prodIfm");   
				 prodIfm.src = "<%= request.getContextPath() %>/ProductProcess/fileupload/fileUpload_TP.jsp?bizId="+json.cfjyproductprocess.investProductNum+"&attachType=0&attachBusType=0&pageType="+infos.pageType+"&processId="+json.cfjyproductprocess.processId;
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
