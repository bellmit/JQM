<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/CFJYProductProcessForm_common.jsp" %>
<!-- 
  - Author(s): jiangkanqian
  - Date: 2018-05-03 09:22:42
  - Description:
-->
<head>
<title>指令详细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/transaction/investNew/js/transactionInstructComJs.js"></script>  
</head>
<body>

	<div id="newInterestswapInstructForm" style="padding-top:5px;width: 100%;">
			<input class="nui-hidden" name="newInterestswapInstruct.lInstructNo" id="lInstructNo"/>
			<!-- 下单操作类型:0-新建指令/建议 1-修改指令/建议 -->
			<input class="nui-hidden" name="newInterestswapInstruct.operatorType" id="operatorType" value="0"/>	
			<input class="nui-hidden" name="newInterestswapInstruct.vcProcessState" id="vcProcessState"/>
			<!-- 业务标签:1-投顾端、2-交易员端 -->
		   	<input class="nui-hidden" id="queryType" name="newInterestswapInstruct.queryType"/>	
		   	<input class="nui-hidden" id="cIsValid" name="newInterestswapInstruct.cIsValid"/>
		   	<input class="nui-hidden" id="lInstructId" name="newInterestswapInstruct.lInstructId"/>		           
            <table class="instructTable" border="0" style="width: 100%;">
                <tr>
                	<td align="right" width="20%">
                        产品名称:
                    </td>
                    <td colspan="1" width="10%">
		                 <input id="vcProductCode"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcProductCode" required="true"
                        readonly="readonly" enabled="false"/>       
                    </td>
                    <td align="right" width="20%">
                        交易日期:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="lTradeDate"  class="nui-datepicker" 
                        name="newInterestswapInstruct.lTradeDate" required="true" format="yyyyMMdd"
                        onvaluechanged="tradeDateChange" readonly="readonly" enabled="false"/>
                    </td>
                    <td align="right" width="20%">
                        业务名称:
                    </td>
                    <td colspan="1" width="20%">
                        <input id="vcBusinName"  class="nui-combobox" 
                        name="newInterestswapInstruct.vcBusinName" required="true" 
                        onvaluechanged="businNameChange" readonly="readonly" enabled="false"/>
                    </td>
                </tr>
                <tr>
                	<td align="right" width="20%">
                        组合名称:
                    </td>
                    <td colspan="1" width="10%">
                        <input name="newInterestswapInstruct.vcCombiCode" class="nui-textbox" id="vcCombiCode"
                           readonly="readonly" enabled="false"/>
                    </td>
                    <td align="right" width="20%">
                        名义本金（万元）:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="lNominalCapital"  class="nui-textbox" 
                        name="newInterestswapInstruct.lNominalCapital" required="true"
                        readonly="readonly" enabled="false"/>
                    </td>
                    <td align="right" width="20%">
                        期限:
                    </td>
                    <td colspan="1" width="20%">
                        <input id="lLeftDays"  class="nui-textbox" 
                        name="newInterestswapInstruct.lLeftDays" 
                        required="true" readonly="readonly" enabled="false"/>
                    </td>
                </tr>
                <tr>
                	<td align="right" width="20%">
                        业务类别:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="vcBusinType"  class="nui-combobox" 
                        data = "[{id: 0, text: '支付固定'}, {id: 1, text: '收取固定'}]"
                        name="newInterestswapInstruct.vcBusinType" required="true"
                        readonly="readonly" enabled="false"/>
                    </td>
                    <td align="right" width="20%">
                        固定利率（%）:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="lFixedRate"  class="nui-textbox" 
                        name="newInterestswapInstruct.lFixedRate" required="true"
                        readonly="readonly" enabled="false"/>
                    </td>
                    <td align="right" width="20%">
                        起息日:
                    </td>
                    <td colspan="1" width="20%">
                        <input id="lValueDate"  class="nui-datepicker" 
                        name="newInterestswapInstruct.lValueDate" required="true" 
                        readonly="readonly" enabled="false" format="yyyyMMdd"/>
                    </td>
                </tr>
                <tr>
                	<td align="right" width="20%">
                        到期日:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="lDueDate"  class="nui-datepicker" 
                        name="newInterestswapInstruct.lDueDate" required="true"
                        readonly="readonly" enabled="false" format="yyyyMMdd"/>
                    </td>
                    <td align="right" width="20%">
                        首期起息日:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="lFirstvalueDate"  class="nui-datepicker" 
                        name="newInterestswapInstruct.lFirstvalueDate" required="true"
                        readonly="readonly" enabled="false" format="yyyyMMdd"/>
                    </td>
                    <td align="right" width="20%">
                        计息天数调整:
                    </td>
                    <td colspan="1" width="20%">
                        <input id="vcInterdayAdj"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcInterdayAdj" required="true" 
                        readonly="readonly" enabled="false" value="实际天数"/>
                    </td>
                </tr>
                <tr>
                	<td align="right" width="20%">
                        支付日调整:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="vcPaydayAdj"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcPaydayAdj" required="true" 
                        readonly="readonly" enabled="false"
                        value="经调整的下一营业日"/>
                    </td>
                    <td align="right" width="20%">
                        清算方式:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="vcClearType"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcClearType" required="true" 
                        readonly="readonly" enabled="false"
                        value="上海清算所清算"/>
                    </td>
                    <td align="right" width="20%">
                        计算机构:
                    </td>
                    <td colspan="1" width="20%">
                        <input id="vcCalcuOrganiz"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcCalcuOrganiz" required="true" 
                        readonly="readonly" enabled="false"
                        value="中国外汇交易中心"/>
                    </td>
                </tr>
                <tr>
                	<td align="right" width="20%">
                        对手方:
                    </td>
                    <td colspan="1" width="10%">                       
        				<input id="vcCounterpartyId"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcCounterpartyId" required="true"
                        readonly="readonly" enabled="false"/>
                    </td>
                    <td align="right" width="20%">
                        交易员:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="vcTrader"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcTrader" required="true"
                        readonly="readonly" enabled="false"/>
                    </td>                   
                </tr>
         </table>
         <div class="nui-toolbar" borderStyle="border:0;">
                <a>浮动利率明细</a>
         </div>
         <table>
                <tr>
                	<td align="right" width="20%">
                        参考利率:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="vcReferRate"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcReferRate" required="true" 
                        readonly="readonly" enabled="false"/>
                    </td>
                    <td align="right" width="20%">
                        利差(bps):
                    </td>
                    <td colspan="1" width="10%">
                        <input id="vcMargin"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcMargin" required="true" 
                        readonly="readonly" enabled="false"
                        value="0"/>
                    </td>
                    <td align="right" width="20%">
                        支付周期:
                    </td>
                    <td colspan="1" width="20%">
                        <input id="vcPayCycle"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcPayCycle" required="true" 
                        readonly="readonly" enabled="false"/>
                    </td>
                </tr>
                <tr>
                	<td align="right" width="20%">
                        首期定期支付日:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="lFiregulPayday"  class="nui-datepicker" 
                        name="newInterestswapInstruct.lFiregulPayday" required="true"
                        readonly="readonly" enabled="false" format="yyyyMMdd"/>                                              
                    </td>
                    <td align="right" width="20%">
                        重置频率:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="vcResetFrequency"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcResetFrequency" required="true" 
                        readonly="readonly" enabled="false"/>
                    </td>
                    <td align="right" width="20%">
                        首期利率确定日:
                    </td>
                    <td colspan="1" width="20%">
                        <input id="lFirateDay"  class="nui-datepicker" 
                        name="newInterestswapInstruct.lFirateDay" required="true" 
                        readonly="readonly" enabled="false"/>
                    </td>
                </tr>
                <tr>
                	<td align="right" width="20%">
                        计息方法:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="vcInterestMethod"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcInterestMethod" required="true" 
                        readonly="readonly" enabled="false"/>
                    </td>
                    <td align="right" width="20%">
                        计息基准:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="vcFloatrateBench"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcFloatrateBench" required="true" 
                        readonly="readonly" enabled="false"/>
                    </td>                    
                </tr>
            </table>
            <div class="nui-toolbar" borderStyle="border:0;">
                <a>固定利率明细</a>
         	</div>
         	<table>
         		<tr>
                	<td align="right" width="20%">
                       支付周期:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="vcFixPayCycle"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcPayCycle" required="true" 
                        readonly="readonly" enabled="false"/>
                    </td>
                    <td align="right" width="20%">
                        首期定期支付日:
                    </td>
                    <td colspan="1" width="10%">
                        <input id="lFixFiregulPayday"  class="nui-datepicker" 
                        name="newInterestswapInstruct.lFiregulPayday" required="true"
                        readonly="readonly" enabled="false" format="yyyyMMdd"/>
                    </td>
                    <td align="right" width="20%">
                        计息基准:
                    </td>
                    <td colspan="1" width="20%">
                        <input id="vcFixrateBench"  class="nui-textbox" 
                        name="newInterestswapInstruct.vcFixrateBench" required="true" 
                        readonly="readonly" enabled="false"/>
                    </td>
                </tr>
                <tr>
                	<td align="right">
                        备注:
                    </td>
                    <td colspan="5">
                        <input class="nui-textarea"  name="newInterestswapInstruct.vcRemark" 
                        id="vcRemark" width="100%" height="105px" readonly="readonly" enabled="false"/>
                    </td>
                </tr>
           </table>
           <!-- <div class="nui-toolbar" borderStyle="border:0;">
				<div align="center" class="submitDiv">
					<a class="nui-button"  iconCls="icon-ok" plain="true"  id="exactCommit" onclick="goconfirm()">确认</a> 
					<a class="nui-button"  iconCls="icon-cancel" plain="true"  onclick="onCancel()">关闭</a>
				</div>
			</div> -->
        </div>

	<script type="text/javascript">
    	nui.parse();
    	
    	//页面一开始要加载的方法
		$(function() {
	    	loadData( );
		});	
    	
    	//数据初始化
    	function loadData( ){
    		var businData = "[{id: 0, text: 'FR007_1M'}, {id: 1, text: 'FR007_3M'}, {id: 2, text: 'FR007_6M'},"
    	 	+ "{id: 3, text: 'FR007_9M'}, {id: 4, text: 'FR007_1Y'}, {id: 5, text: 'FR007_2Y'},"
    	 	+ "{id: 6, text: 'FR007_3Y'}, {id: 7, text: 'FR007_4Y'}, {id: 8, text: 'FR007_5Y'},"
    	 	+ "{id: 9, text: 'FR007_7Y'}, {id: 10, text: 'FR007_10Y'}, {id: 11, text: 'SHIBOR_3M_6M'},"
    	 	+ "{id: 12, text: 'SHIBOR_3M_9M'}, {id: 13, text: 'SHIBOR_3M_1Y'}, {id: 14, text: 'SHIBOR_3M_2Y'},"
    	 	+ "{id: 15, text: 'SHIBOR_3M_3Y'}, {id: 16, text: 'SHIBOR_3M_4Y'}, {id: 17, text: 'SHIBOR_3M_5Y'},"
    	 	+ "{id: 18, text: 'SHIBOR_3M_6Y'}, {id: 19, text: 'SHIBOR_3M_7Y'}, {id: 20, text: 'SHIBOR_3M_8Y'},"
    	 	+ "{id: 21, text: 'SHIBOR_3M_9Y'}, {id: 22, text: 'SHIBOR_3M_10Y'}, {id: 23, text: 'SHIBOR_O/N_7D'},"
    	 	+ "{id: 24, text: 'SHIBOR_O/N_1M'}, {id: 25, text: 'SHIBOR_O/N_3M'}, {id: 26, text: 'SHIBOR_O/N_6M'},"
    	 	+ "{id: 27, text: 'SHIBOR_O/N_9M'}, {id: 28, text: 'SHIBOR_O/N_1Y'}, {id: 29, text: 'SHIBOR_O/N_2Y'}, "
    	 	+ "{id: 30, text: 'SHIBOR_O/N_3Y'}]";
    	 	var businName = nui.get("vcBusinName");
    		businName.setData(businData);
    	}
    	   	
    	  	
    	//页面X的删除功能
		function onCloseClick(e) {
		    var obj = e.sender;
		    obj.setText(null);
		    obj.setValue(null);
		    obj.doValueChanged();
		}
    	    	    	
    	//复制新增初始化页面及数据
    	function setFormData(data){
    		//跨页面传递的数据对象，克隆后才可以安全使用 
    		var insructInfo = nui.clone(data); 
	        if(insructInfo!=null){
	        	nui.get("vcProductCode").setValue(insructInfo.vcProductName);
                    	nui.get("vcProductCode").setValue(insructInfo.vcProductName);
						nui.get("lTradeDate").setValue(insructInfo.lTradeDate.toString());
						nui.get("vcBusinName").setValue(insructInfo.vcBusinName);					
						nui.get("vcCombiCode").setValue(insructInfo.vcCombiName);
						nui.get("lNominalCapital").setValue(insructInfo.lNominalCapital);
						nui.get("lLeftDays").setValue(insructInfo.lLeftDays);
						nui.get("vcBusinType").setValue(insructInfo.vcBusinType);
						nui.get("lFixedRate").setValue(insructInfo.lFixedRate);
						nui.get("lValueDate").setValue(insructInfo.lValueDate.toString());
						nui.get("lDueDate").setValue(insructInfo.lDueDate.toString());
						nui.get("lValueDate").setValue(insructInfo.lValueDate.toString());
						nui.get("lFirstvalueDate").setValue(insructInfo.lFirstvalueDate.toString());
						nui.get("vcCounterpartyId").setValue(insructInfo.vcCounterpartyName);
						nui.get("vcTrader").setValue(insructInfo.vcTrader);
						nui.get("vcReferRate").setValue(insructInfo.vcReferRate);
						nui.get("vcPayCycle").setValue(insructInfo.vcPayCycle);
						nui.get("lFiregulPayday").setValue(insructInfo.lFiregulPayday.toString());
						nui.get("vcResetFrequency").setValue(insructInfo.vcResetFrequency);
						nui.get("lFirateDay").setValue(insructInfo.lFirateDay.toString());
						nui.get("vcInterestMethod").setValue(insructInfo.vcInterestMethod);
						nui.get("vcFloatrateBench").setValue(insructInfo.vcFloatrateBench);
						nui.get("vcFixrateBench").setValue(insructInfo.vcFixrateBench);	
						nui.get("vcFixPayCycle").setValue(insructInfo.vcPayCycle.toString());	
						nui.get("lFixFiregulPayday").setValue(insructInfo.lFiregulPayday.toString());
						nui.get("vcCalcuOrganiz").setValue(insructInfo.vcCalcuOrganiz);	
						nui.get("vcRemark").setValue(insructInfo.vcRemark);				
	        }
    	}
    			
		
    </script>
</body>
</html>