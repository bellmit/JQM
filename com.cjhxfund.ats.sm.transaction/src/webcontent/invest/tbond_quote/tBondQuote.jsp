<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>

<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-09-03 10:02:55
  - Description: 银行间债券报价
-->
<head>
	<title>银行间债券报价</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script>
</head>
<body>
	<%-- 查询条件开始... --%>
	
	<div class="search-condition">
		<div class="list">
			<div id="form_bond_quate_condition" class="nui-form" style="padding:2px;" align="left">
				<table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
					<tr>
						<td width="60px" align="right">债券代码:</td>
						<td align="left">
							<div id="bondCode" name="paramObject/vcStockCode" class="nui-autocomplete"
	                                 textField="stockCode" valueField="stockCode"
	                                 searchField="stockCode"
	                                 url="com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.queryBondCode.biz.ext"
	                                 dataField="bondList"
	                                 style="width:95%;">
	                           		<div property="columns">
	                                    <div header="债券代码" field="stockCode" width="40px"></div>
	                                    <div header="债券名称" field="stockName"></div>
                                	</div>
                    		</div>
						</td>
						<td width="60px" align="right">债券类型:</td>
						<td align="left">
							<input id="vcStockType" name="paramObject/vcStockType" class="nui-treeselect"  multiSelect="true" 
						        textField="text" valueField="id" parentField="pid" emptyText="全部" 
						        url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext"
						        checkRecursive="false"  showFolderCheckBox="false"
						        showFolderCheckBox="true" expandOnLoad="true" showTreeIcon="false" showClose="true" 
						        popupWidth="200" oncloseclick="onCloseClick" style="width:95%;"/>
						</td>
						<td width="60px" align="right">债券评级:</td>
						<td align="left">
							<input class="nui-dictcombobox" name="paramObject/vcBondAppraise" id="vcBondAppraise" multiSelect="true"
								valueField="dictID" textField="dictName" dictTypeId="creditRating" 
								emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
						</td>
						<td width="60px" align="right">主体评级:</td>
						<td align="left">
							<input class="nui-dictcombobox" name="paramObject/vcIssueAppraise" id="vcIssueAppraise" multiSelect="true"
							valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" 
							emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
						</td>
						<td width="100px" align="right">剩余期限(年):</td>
						<td align="left">
							<!--<input class="nui-textbox" name="paramObject/lLimiteLeft" vtype="int" onvalidation="numberCheck" requiredErrorText="必须是整数" style="width:95%;"/>-->
							<input class="nui-textbox" name="paramObject/minLimiteLeft" vtype="int" onvalidation="numberCheck" requiredErrorText="必须是整数" style="width:44%;"/>
							<span style="width:5%;">-</span>
							<input class="nui-textbox" name="paramObject/maxLimiteLeft" vtype="int" onvalidation="numberCheck" requiredErrorText="必须是整数" style="width:44%;" />
						</td>
					</tr>
					<tr>
						<td width="60px" align="right">报价来源:</td>
						<td align="left">
							<input class="nui-dictcombobox" id="srcCode" name="paramObject/srcCode" multiSelect="true"
							valueField="dictID" textField="dictName" dictTypeId="quoteSource" 
							emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%;"/>
						</td>
						<td width="60px" align="right">企业性质:</td>
						<td align="left">
							<input id="vcIssueProperty" name="paramObject/vcIssueProperty" class="nui-dictcombobox" multiSelect="true"
							data="data" valueField="dictID" textField="dictName" dictTypeId="ATS_FM_ISSUE_PROPERTY" 
							emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%;"/>
						</td>
						<td width="60px" align="right">含权方式:</td>
						<td>
							<input class="nui-dictcombobox" id="vcRightType" name="paramObject/vcRightType" 
							data="data" valueField="dictID" textField="dictName" dictTypeId="cumRightsWay" 
							emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%;"/>
						</td>
						<td width="60px" align="right">买价区间:</td>
						<td align="left">
							<input class="nui-textbox" name="paramObject/rtBidyieldMin" vtype="float" onvalidation="numberCheck" requiredErrorText="必须是数字" style="width:44%;"/>
							<span style="width:5%;">-</span>
							<input class="nui-textbox" name="paramObject/rtBidyieldMax" vtype="float" onvalidation="numberCheck" requiredErrorText="必须是数字" style="width:44%;" />
						</td>
						<td width="100px" align="right">卖价区间:</td>
						<td align="left">
							<input class="nui-textbox" name="paramObject/rtAskyieldMin" vtype="float" onvalidation="numberCheck" requiredErrorText="必须是数字" style="width:44%"/>
							<span style="width:5%">-</span>
							<input class="nui-textbox" name="paramObject/rtAskyieldMax" vtype="float" onvalidation="numberCheck" requiredErrorText="必须是数字" style="width:44%"/>
							<input class="nui-hidden"  name="paramObject/isPosition"/>
							<input class="nui-hidden"  name="paramObject/isMyAttention"/>
						</td>
					</tr>
					<tr>
						<td colspan="10"  align="left">
							<a class="nui-menubutton " plain="false" menu="#popupMenu"
                               id="searchCond"
                               name="searchCond"
                               data-options='{formId:"form_bond_quate_condition"}'
                               iconCls="icon-add">保存查询条件</a>
                            <ul id="popupMenu" class="mini-menu" style="display:none;width:250px;"></ul>
							<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search"/>
							<input class='nui-button' plain='false' text="重置" iconCls="icon-reset" onclick="reset"/>   
						</td>
					</tr>
				</table>
			</div>
   		</div>
	</div>
	<%-- 查询条件结束... --%>
	
	<%-- 列表开始... --%>
	<div class="nui-fit">
		<div id="tabs_tbond_quote" class="nui-tabs" activeIndex="0" height="100%">
			<div title="最优报价" url="<%= request.getContextPath() %>/transaction/invest/tbond_quote/optimalPrice.jsp"></div>
			<div title="当日成交" url="<%= request.getContextPath() %>/transaction/invest/tbond_quote/todaysDeal.jsp"></div>
		</div>
	</div>
	<%-- 列表结束... --%>
	<script type="text/javascript">
    	nui.parse();
    	$("#bondCode>span>input").attr("placeholder","请输入债券代码...");
    	var conditionForm = new nui.Form("#form_bond_quate_condition");
    	var tabQuoteRole = nui.get("#tabs_tbond_quote");//获取债券报价标签列表
    	
    	
    	var json = conditionForm.getData(false,false);
    	var row = null; 
    	var isSigleSelectChanged = false;

		function numberCheck(e){
			if (!e.isValid) {
				e.sender.setValue("");
            }
		}
    	function search(){
    		var quoteCurrentTabIFrameEl = tabQuoteRole.getTabIFrameEl(tabQuoteRole.getActiveTab());//获取当前激活的报价标签
    		var position = quoteCurrentTabIFrameEl.contentWindow.nui.get("isPosition");//获取子页面（iframe）中的数据信息
    		var attention = quoteCurrentTabIFrameEl.contentWindow.nui.get("myAttention");//获取子页面（iframe）中的数据信息
    		conditionForm.setData({"paramObject/isPosition":position.getValue(),"paramObject/isMyAttention":attention.getValue()}, false);
			var json = conditionForm.getData(false,false);
			json["paramObject/vcStockType"] = splitString(nui.get("vcStockType").getText());
			json["paramObject/vcBondAppraise"] = splitString(nui.get("vcBondAppraise").getText());
			json["paramObject/vcIssueAppraise"] = splitString(nui.get("vcIssueAppraise").getText());
			json["paramObject/vcRightType"] = nui.get("vcRightType").getText();
			json["paramObject/vcIssueProperty"] = splitString(nui.get("vcIssueProperty").getText());
			quoteCurrentTabIFrameEl.contentWindow.search(json);//调用子页面（iframe）中的js方法	
			quoteCurrentTabIFrameEl.contentWindow.clearDetail();	
    	}
    	
    	function splitString(data){
    		var string = null;
    		if(data != null && data != ""){
    			var strs= data.split(",");
	    		if(strs.length>0){
	    			for(var i=0; i<strs.length; i++ ){ 
						if(i == 0){
							string = "'"+strs[i]+"'";
						}else{
							string += ",'"+strs[i]+"'";
						}
					} 
	    		}
    		}
			return string;
    	}
    	
    	function reset(){
    		conditionForm.clear();
    	}
    	function onCloseClick(e){
	    	var obj = e.sender;
            obj.setText("");
            obj.setValue("");
	    }
    </script>
</body>
</html>