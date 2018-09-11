<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/CFJYProductProcessForm_show_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2015-11-25 11:42:39
- Description: 指令/建议录入指令/建议单_大宗交易
--%>
<head>
<title>指令/建议录入指令/建议单_大宗交易</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <input class="nui-hidden" name="cfjyproductprocess.processType4InvestProductNum" value="19"/>
            <input class="nui-hidden" name="cfjyproductprocess.processType" value="19"/>
            <input class="nui-hidden" name="cfjyproductprocess.processId"/>
            <input class="nui-hidden" name="cfjyproductprocess.processStatus" id="processStatus"/>
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td align="right" width="20%">
                        业务日期:
                    </td>
                    <td colspan="1" width="30%">
                        <input readonly="readonly" id="processDate" class="nui-datepicker" name="cfjyproductprocess.processDate" required="true" style="width:150px;"/>
                    </td>
                    <td align="right" width="20%">
                       买卖方向:
                    </td>
                    <td colspan="1" width="30%">
                        <input readonly="readonly" id="deliveryMethod" class="nui-dictcombobox" dictTypeId="CF_JY_MMFX" name="cfjyproductprocess.deliveryMethod" 
                        emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" style="width:150px;"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="20%">
                        产品名称:
                    </td>
                    <td colspan="1" width="30%">
                        <input readonly="readonly" id="combProductCode" required="true" class="nui-autocomplete" style="width:150px;" name="cfjyproductprocess.combProductCode" searchField="searchKey" dataField="combProducts"
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
	                      <input readonly="readonly" class="nui-textbox" style="width:150px;" id="vcCombiName" required="true" name="cfjyproductprocess.vcCombiName"/>
                    </td>
                </tr>
                <tr>
                   <td align="right" width="23%">
                        证券代码:
                    </td>
                    <td colspan="1" width="27%">
                        <input readonly="readonly" id="investProductCode" class="nui-autocomplete" popupWidth="300" popupHeight="200" name="cfjyproductprocess.investProductCode" searchField="searchKey" dataField="investProducts"
                        	valueField="investProductInfo" textField="investProduct" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByKey.biz.ext" value="" text="" enterQuery="false"
                        	onvaluechanged="enterSumbit" onitemclick="investProductCodeOnItemClick" style="width:150px;" required="true"/>
                    </td>
                    <td align="right" width="23%">
                        证券名称:
                    </td>
                    <td colspan="1" width="27%">
                        <input readonly="readonly" id="investProductName" class="nui-textbox" style="width:150px;" name="cfjyproductprocess.investProductName" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                      指令/建议价格(元):
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="netPrice" class="nui-textbox"  name="cfjyproductprocess.netPrice"  required="true" onblur="netPriceFun()" style="width:150px;"/>
                    </td>
                    <td align="right">
                       委托数量(股):
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="investCount" class="nui-textbox" name="cfjyproductprocess.investCount"  onblur="investCountFun()" required="true" style="width:150px;"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                      对方席位号:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="seatNum" class="nui-textbox"  name="cfjyproductprocess.seatNum" style="width:150px;"/>
                    </td>
                    <td align="right">
                       约定号:
                    </td>
                    <td colspan="1">
                        <input readonly="readonly" id="agreementNum" class="nui-textbox" name="cfjyproductprocess.agreementNum" style="width:150px;"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                      交易对手名称:
                    </td>
                    <td colspan="1">
                        <input id="tradingOpponent" class="nui-textbox"  name="cfjyproductprocess.tradingOpponent" required="true" style="width:150px;"/>
                    </td>
                    <td align="right">
                       关联关系:
                    </td>
                    <td colspan="1" class="radio-border-top-none">
						<input id="interestRateType" name="cfjyproductprocess.interestRateType"  class="nui-radiobuttonlist" repeatItems="2" repeatLayout="none" repeatDirection="vertical"
						    textField="text" valueField="id" value="无关联关系" data="[{id: '有关联关系', text: '有'}, {id: '无关联关系', text: '无'}]" />
			        </td>
                </tr>
                <tr>
                    <td align="right">
                        备注:
                    </td>
                    <td colspan="3">
                        <input readonly="readonly" class="nui-textarea"name="cfjyproductprocess.remark" width="100%" height="100"/>
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
			}
			
        </script>
    </body>
</html>
