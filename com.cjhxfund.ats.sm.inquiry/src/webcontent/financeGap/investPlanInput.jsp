<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2017-12-07 10:08:15
  - Description:
-->
<head>
<title>编辑投资计划</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <script type="text/javascript" src="<%= request.getContextPath() %>/JQMHistory/common/common.js"></script>
</head>
<body>
	<div style="height:auto; width:100%;">
		<div id="invest_plan_form" style="padding-left:11px; padding-right:11px; padding-bottom:5px;">
			<table border="0" style="width: 100%;">
				<tr>
                    <td style="width:70px; text-align:right;">产品名称：</td>
                    <td style="width:170px;">
                    	<input name="lProductId" class="nui-hidden"/>
                    	<input name="vcProductCode" class="nui-hidden"/>
                        <input name="vcProductName" class="nui-textbox" enabled="false" style="width: 100%;" required="true"/>
                    </td>
                    
                </tr>
                <tr>
                	<td style="text-align:right;">单元名称：</td>
                    <td>
                    	<input name="lAssetId" class="nui-hidden"/>
                    	<input name="vcAssetCode" class="nui-hidden"/>
                        <input name="vcAssetName" class="nui-textbox" enabled="false" style="width: 100%;" required="true" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align:right;">业务类别：</td>
                    <td>    
                        <input name="vcBizType" class="nui-combobox" 
                        	valueField="dictID" textField="dictName" 
                        	data="[{'dictID':'1','dictName':'银行间现券买卖'},{'dictID':'2','dictName':'上交所大宗交易平台现券买卖'},
                        		   {'dictID':'3','dictName':'上交所固收交易平台现券买卖'},{'dictID':'4','dictName':'深交所综合协议平台现券买卖'},
                        		   {'dictID':'5','dictName':'银行间质押式回购'},{'dictID':'6','dictName':'银行间买断式回购'},
                        		   {'dictID':'10','dictName':'追加提取'},{'dictID':'11','dictName':'一级缴款'},
                        		   {'dictID':'12','dictName':'存款'},{'dictID':'13','dictName':'基金申购'},
                        		   {'dictID':'14','dictName':'期货出入金'},{'dictID':'7','dictName':'上交所协议回购'},{'dictID':'8','dictName':'深交所协议回购'}]" 
                        	onvaluechanged="onBizChanged" required="true" popupHeight="110px" emptyText="请选择业务" style="width: 100%;"/>
                       	<input name="vcMarketNo" class="nui-hidden"/>
                    </td>
                </tr>
                <tr>
                	<td style="text-align:right;">委托方向：</td>
                    <td>    
                        <input name="vcEntrustDirection" class="nui-combobox" valueField="dictID" textField="dictName" required="true" style="width: 100%;"/>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:right;">金额(万元)：</td>
                    <td>
                        <input name="enInvestAmount" class="nui-textbox" onvalidation="onAmountValidation" required="true" style="width: 100%;"/>
                    </td>
                </tr>
			</table>
		</div>
	</div>
	<div style="text-align:center;padding:10px;">               
        <a class="nui-button" onclick="sendDirective()" style="width:60px;margin-right:20px;">提交</a>       
        <a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>
    </div>  
	<script type="text/javascript">
    	nui.parse();
    	var investForm = new nui.Form("#invest_plan_form");
    	var spotTradeData = "[{'dictID':'4','dictName':'卖出'},{'dictID':'3','dictName':'买入'}]";
    	var hgTradeData = "[{'dictID':'5','dictName':'正回购'},{'dictID':'6','dictName':'逆回购'}]";
    	var aeData = "[{'dictID':'41','dictName':'追加'},{'dictID':'42','dictName':'提取'}]";
    	var payData = "[{'dictID':'43','dictName':'缴款'}]";
    	var depositData = "[{'dictID':'44','dictName':'存出'}]";
    	var purchaseData = "[{'dictID':'45','dictName':'申购'}]";
    	var eeData = "[{'dictID':'46','dictName':'入金'}, {'dictID':'47','dictName':'出金'}]";
    	
    	var entrustDirection = nui.getbyName("vcEntrustDirection");
    	var oldData = null;
    	var operatType = null;
    	function setFormData(data, type){
    		operatType = type;
    		if(type == "input"){//新增
    			
    		}else{//修改
    			oldData = data;
    			if(data.vcBizType=="1" || data.vcBizType=="2" || data.vcBizType=="3" || data.vcBizType=="4"){
	    			entrustDirection.setData(spotTradeData);
	    		}else if(data.vcBizType=="5" || data.vcBizType=="6" || data.vcBizType=="7" || data.vcBizType=="8"){
	    			entrustDirection.setData(hgTradeData);
	    		}else if(data.vcBizType=="10"){
	    			entrustDirection.setData(aeData);
	    		}else if(data.vcBizType=="11"){
	    			entrustDirection.setData(payData);
	    		}else if(data.vcBizType=="12"){
	    			entrustDirection.setData(depositData);
	    		}else if(data.vcBizType=="13"){
	    			entrustDirection.setData(purchaseData);
	    		}else if(data.vcBizType=="14"){
	    			entrustDirection.setData(eeData);
	    		}
    		}
    		investForm.setData(data);
    	}
    	
    	//业务类别与委托方向联动
    	function onBizChanged(e){
    		if(e.value=="1" || e.value=="2" || e.value=="3" || e.value=="4"){
    			entrustDirection.setData(spotTradeData);
    			entrustDirection.setValue("4");
    		}else if(e.value=="5" || e.value=="6" || e.value=="7" || e.value=="8"){
    			entrustDirection.setData(hgTradeData);
    			entrustDirection.setValue("5");
    		}else if(e.value=="10"){
    			entrustDirection.setData(aeData);
    			entrustDirection.setValue("41");
    		}else if(e.value=="11"){
    			entrustDirection.setData(payData);
    			entrustDirection.setValue("43");
    		}else if(e.value=="12"){
    			entrustDirection.setData(depositData);
    			entrustDirection.setValue("44");
    		}else if(e.value=="13"){
    			entrustDirection.setData(purchaseData);
    			entrustDirection.setValue("45");
    		}else if(e.value=="14"){
    			entrustDirection.setData(eeData);
    			entrustDirection.setValue("46");
    		}
    		if(e.value=="1" || e.value=="5" || e.value=="6" || e.value=="11"){
    			(nui.getbyName("vcMarketNo")).setValue("5");
    		}else if(e.value=="2" || e.value=="3" || e.value=="7"){
    			(nui.getbyName("vcMarketNo")).setValue("1");
    		}else if(e.value=="4" || e.value=="8"){
    			(nui.getbyName("vcMarketNo")).setValue("2");
    		}else if(e.value=="10" || e.value=="12" || e.value=="13"){
    			(nui.getbyName("vcMarketNo")).setValue("6");
    		}else if(e.value=="14"){
    			(nui.getbyName("vcMarketNo")).setValue("7");
    		}
    	}
    	
    	//校验可输入金额
    	function onAmountValidation(e){
    		var value = e.value.replace(/,/g,'');
    		var point = 0;
    		if (e.isValid){
    			var re1 = /^(\-|\+)?\d+(\.\d+)?$/;//数字类型
    			var re2 = /^(\-|\+)?\d{1,12}$/; //限制整数位
                if (!re1.test(value)) {
                    e.errorText = "请输入数字";
                    e.isValid = false;
                    return;
                }else if(!re2.test(value.split(".")[0])){
                	e.errorText = "整数位不可超过12位";
                    e.isValid = false;
                    return;
                }else{
                	if(value<0){
                		 e.errorText = "请输入正数";
                    	e.isValid = false;
                    	return;
                	}
                }
                if(value.split(".").length>1){
    				point = value.split(".")[1].length;
    				point = point>4?4:point;
    			}
                e.sender.setValue(formatNumber(value,point,1));
            }
    	}
    	
    	//保存投资计划
    	function sendDirective(){
    		investForm.validate();
		    if (investForm.isValid() == false){
		    	return;
		    }
    		var investPlan = investForm.getData();
    		investPlan["lDate"] = DateUtil.toNumStr(new Date());
    		investPlan["enInvestAmount"] = investPlan.enInvestAmount.replace(/,/g,'');
    		var vcEntrustDirection = investPlan["vcEntrustDirection"];
    		if(vcEntrustDirection == "4" || vcEntrustDirection == "5" || vcEntrustDirection == "41" || vcEntrustDirection == "47"){
    			investPlan["vcFundDirection"] = "1";
    		}else{
    			investPlan["vcFundDirection"] = "2";
    		}
    		var operatUrl = "com.cjhxfund.ats.sm.inquiry.financeGapManage.insertInvestPlan.biz.ext";
    		if(operatType=="modify"){
    			investPlan["lPlanId"]=oldData.lPlanId;
    			operatUrl = "com.cjhxfund.ats.sm.inquiry.financeGapManage.updateInvestPlan.biz.ext";
    		}
    		var a = nui.loading("正在处理中,请稍等...","提示");
    		nui.ajax({
	            url: operatUrl,
	            type: 'POST',
	            data: {investPlan: investPlan},
	            cache: false,
	            contentType: 'text/json',
	            success: function (resp) {
	            	nui.hideMessageBox(a);
	            	var returnJson = nui.decode(resp);
	            	if(returnJson.exception == null){
	            		nui.alert("投资计划提交成功！","提示",function(){
	            			window.CloseOwnerWindow("ok");
		             	});
	            	}else{
	            		nui.alert("系统异常","提示");
	            	}
	            }
	        });
    	}
    	
    	//取消保存，关闭窗口
    	function onCancel(e) {
    		window.CloseOwnerWindow("cancel");
        }
    </script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
</body>
</html>