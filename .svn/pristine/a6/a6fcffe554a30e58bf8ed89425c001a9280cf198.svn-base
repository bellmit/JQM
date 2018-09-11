<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ page import="com.eos.foundation.eoscommon.CacheUtil" %>
<%@ page import="commonj.sdo.DataObject" %>
<%@ page import="com.eos.foundation.data.DataObjectUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<% 
//从缓存中获取对应的净价和中债t-1的估价净价偏差比
String deviationKey ="NET_RATE_ESTIMATE_DEVIATION";
DataObject deviation= (DataObject)CacheUtil.getValue("ReloadParamConf1",deviationKey);
String deviationValue = (String)deviation.get("paramValue");
%>
<!-- 
  - Author(s): 吴艳飞
  - Date: 2016-09-13 13:58:47
  - Description:
-->
<head>
<title>银行间下达投资指令/建议</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
    	.mini-buttonedit-border{
    		padding-right:1px;
    	}
    	.nui-textbox {
		    width:100%;
		 } 
		#complete_instruction  span{
		 	color:red;
		 }
    </style>
</head>
<body style="padding-top: 10px;overflow: hidden;">
	<div class="container" style="height:100%;width:100%;">
		<div style="float:left; width:calc(100%-505px);height:auto;" id="bondDetailCont">
		<!--主体部分左边查询项begin  -->
			<div id="bond_details"  >
				<table border="0" cellpadding="1" cellspacing="2" style="width:100%;" >
					<tr>
						<td style="width:80px;" align="right">债券类型:</td>
		                <td style="width:100px;" align="left"><input  name="vcStocktypeName" class="nui-textbox" enabled="false"/></td>
	                    <td style="width:120px;" align="right">起息日:</td>
		                <td style="width:100px;" ><input name="lBegincalDate" class="nui-textbox"  enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">债项评级:</td>
	                	<td><input name="vcBondAppraise" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="creditRating" enabled="false"/></td>
	                    <td align="right">下一付息日:</td>
		                <td><input name="lNextPayintDate" class="nui-textbox"  enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">主体评级:</td>
						<td><input name="vcIssueAppraise" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="issuerRating" enabled="false"/></td>
		                <td align="right">距下一付息日天数:</td>
		                <td><input name="lNextPayintDays" class="nui-textbox"  enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">发行机构:</td>
		                <td><input name="vcIssuerNameFull" class="nui-textbox"  enabled="false"/></td>
		                <td align="right">到期日:</td>
		                <td><input name="lEndincalDate" class="nui-textbox"  enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">担保方式:</td>
		                <td><input name=vcAssureType class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="ATS_FM_ASSUER_TYPE" enabled="false"/></td>
		                <td align="right">剩余期限:</td>
		                <td><input class="nui-textbox" name="lLimiteLeft" enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">特殊条款:</td>
		                <td><input name="vcSpecialText" class="nui-textbox"  enabled="false"/></td>
		                <td align="right">距到期日天数:</td>
		                <td><input name="lEndincalDays" class="nui-textbox"  enabled="false"/></td>
					</tr>
					<tr>
						<td align="right">票面面值:</td>
		                <td><input name="enParvalue" class="nui-textbox"  enabled="false"/></td>
		                <td align="right" id="enNetValueLab">中债估价净价(元):</td>
		                <td><input id="enCbValueNetValue" name="enCbValueNetValue" class="nui-textbox"  enabled="false"/>
		                	<input id="enCzValueNetValue" name="enCzValueNetValue" class="nui-textbox"  enabled="false" style="display:none;"/>
		                </td>
					</tr>
					<tr>
						<td align="right">基准类别:</td>
		                <td><input name="vcBchmkRate" class="nui-textbox"  enabled="false"/></td>
		                <td align="right" id="enAllValueLab">中债估价全价(元):</td>
		                <td><input id="enCbValueAllValue" name="enCbValueAllValue" class="nui-textbox"  enabled="false" />
		                	<input id="enCzValueAllValue" name="enCzValueAllValue" class="nui-textbox"  enabled="false" style="display:none;"/>
		                </td>
					</tr>
					<tr>
						<td align="right">票面利率:</td>
		                <td><input name="enFaceRate" class="nui-textbox"  enabled="false"/></td>
		                <td align="right" id="enValueIncmRateLab">中债估价收益率(%):</td>
		                <td><input id="enCbValueIncmRate" name="enCbValueIncmRate" class="nui-textbox"  enabled="false"/>
		                	<input id="enCzValueIncmRate" name="enCzValueIncmRate" class="nui-textbox"  enabled="false" style="display:none;"/>
		                </td>
					</tr>
					<tr>
						<td align="right">利率类型:</td>
		                <td><input name="cInterestType" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="rateType" enabled="false"/></td>
		                <td align="right" id="enValueMdurationLab">中债估价修正久期:</td>
		                <td><input id="enCbValueMduration" name="enCbValueMduration" class="nui-textbox"  enabled="false"/>
		                	<input id="enCzValueMduration" name="enCzValueMduration" class="nui-textbox"  enabled="false" style="display:none;"/>
		                </td>
					</tr>
					<tr>
						<td align="right">付息频率:</td>
		                <td><input name="enPayInteval" class="nui-textbox"  enabled="false"/></td>
		                <td align="right" id="enValueConvexityLab">中债估值凸性:</td>
		                <td><input id="enCbValueConvexity" name="enCbValueConvexity" class="nui-textbox"  enabled="false"/>
		                    <input id="enCzValueConvexity" name="enCzValueConvexity" class="nui-textbox"  enabled="false" style="display: none;"/>
		                </td>
					</tr>
					<tr>
	                	<td align="right" id="vcNewCopBondTypeLab">新公司债类型:</td>
	                    <td><input name="vcNewCopBondType" id="vcNewCopBondType" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="newCopBondType" enabled="false" /></td>
	                </tr>
	            	<tr>
	            		<td colspan="4">
	            			<div style="width:100%;height:1px;border-bottom:1px dashed #000;margin-top:10px;margin-botton:10px"></div>
	            		</td>
	            	</tr>
	           </table>	
			</div>
		 	<div id="available_details"  style="" >
				<table border="0" cellpadding="1" cellspacing="2" style="width:100%;" >
		                <tr>
		                	<td style="width:80px;" align="right">T+0头寸:</td>
		                    <td style="width:100px;"><input id="vcAvailableamountT0"  name="vcAvailableamountT0" class="nui-textbox"  enabled="false"/></td>
		                    <td style="width:120px;" align="right">基金净资产:</td>
		                    <td style="width:100px;"><input id="enFundValue" name="enFundValue" class="nui-textbox"  enabled="false" /></td>
		                </tr>
		                <tr>
		                	<td align="right">T+1头寸:</td>
		                    <td><input id="vcAvailableamountT1"  name="vcAvailableamountT1" class="nui-textbox"  enabled="false"/></td>
		                    <td align="right">持仓(占%):</td>
		                    <td><input id="positionRatio" name="positionRatio" class="nui-textbox"  enabled="false"/></td>
		                </tr>
		                <tr>
		                	<td align="right">T+0可用数量:</td>
		                    <td><input id="vcAvailablequantityT0"  name="vcAvailablequantityT0" class="nui-textbox"  enabled="false"/></td>
		                    <td align="right">未成(占%):</td>
		                    <td><input id="unachievedRatio"  name="unachievedRatio"class="nui-textbox"  enabled="false" /></td>
		                </tr>
		                <tr>
		                	<td align="right">T+1可用数量:</td>
		                    <td><input id="vcAvailablequantityT1"  name="vcAvailablequantityT1" class="nui-textbox"  enabled="false"/></td>
		                    <td align="right">指令/建议(占%):</td>
		                    <td><input id="instructRatio"  name="instructRatio" class="nui-textbox"  enabled="false"/></td>
		                </tr>
		                <tr >
		                	<td align="right"></td>
		                    <td></td>
		                	<td align="right">合计(占%):</td>
		                    <td><input id="totalRatio"  name="totalRatio" class="nui-textbox"  enabled="false"/></td>
		                </tr>
		               
		            </table>	
			</div>
			<!--主体部分左边查询项end  -->
		</div>
		<div id="tabs" class="nui-tabs" style="height:461px; width:570px;float:right;margin-right: 10px;" onactivechanged="tabChange">
		    <div title="银行间债券市场" url="<%= request.getContextPath() %>/transaction/investNew/interBankInstruct.jsp" index="0" >
		    </div>
		    <div title="上交所固收平台" url="<%= request.getContextPath() %>/transaction/investNew/shFixIncome.jsp" index="1">
		    </div>
		    <div title="上交所大宗平台" url="<%= request.getContextPath() %>/transaction/investNew/shBlockTrade.jsp" index="2">
		    </div>
		    <div title="深交所综合协议平台" url="<%= request.getContextPath() %>/transaction/investNew/szIntegratedProt.jsp" index="3">
		    </div>
		</div>
	</div>
</body>
	<script type="text/javascript">
    	nui.parse();
    	$(function(){
    	$("#bondDetailCont .mini-buttonedit-button").remove();
			//当为IE8时，使用js调整宽度
			if(navigator.userAgent.indexOf("MSIE 8.0")>0){
				var width = parseFloat($("container").width());
				$("#bondDetailCont > div:first").css({
					width:(width - 505)+ "px"
				});
			}
		});
		//切换面板事件
		function tabChange(e){
			var tab = nui.get("tabs").getTabIFrameEl(e.tab);
			var bondDetails = new nui.Form("#bond_details");
			var availableDetails = new nui.Form("#available_details");
			bondDetails.clear();
			availableDetails.clear();
			if(e.index === 0){
				$("#enNetValueLab").html("中债估价净价");
				$("#enAllValueLab").html("中债估价全价(元)");
				$("#enValueIncmRateLab").html("中债估价收益率(%)");
				$("#enValueMdurationLab").html("中债估价修正久期");
				$("#enValueConvexityLab").html("中债估值凸性");
				$("#vcNewCopBondTypeLab").html("");
				$("#vcNewCopBondType").hide();
				
				$("#enCbValueNetValue").show(); 
				$("#enCbValueAllValue").show();
				$("#enCbValueIncmRate").show(); 
				$("#enCbValueMduration").show();
				$("#enCbValueConvexity").show();
				
				$("#enCzValueNetValue").hide();
				$("#enCzValueAllValue").hide();
				$("#enCzValueIncmRate").hide();
				$("#enCzValueMduration").hide();
				$("#enCzValueConvexity").hide();
				
			}else{
				$("#enNetValueLab").html("中证净价");
				$("#enAllValueLab").html("中证全价");
				$("#enValueIncmRateLab").html("中证估价收益率");
				$("#enValueMdurationLab").html("中证估价修正久期");
				$("#enValueConvexityLab").html("中证估值凸性");
				$("#vcNewCopBondTypeLab").html("新公司债类型");
				$("#vcNewCopBondType").show();
				
				$("#enCzValueNetValue").show();
				$("#enCzValueAllValue").show();
				$("#enCzValueIncmRate").show();
				$("#enCzValueMduration").show();
				$("#enCzValueConvexity").show();
				
				$("#enCbValueNetValue").hide(); 
				$("#enCbValueAllValue").hide();
				$("#enCbValueIncmRate").hide(); 
				$("#enCbValueMduration").hide();
				$("#enCbValueConvexity").hide();
			}
			if(tab){//非第一次加载tab
				tab.contentWindow.onActionRenderer(null);
			}
		}
		
		//复制新增初始化页面及数据
    	function initWin(tabIndex,data){
    	    var tabs=nui.get("tabs");
    	    if(data!=null){
    	        //data不为空，则视为复制增加,隐藏其它无用TAB
    	        //隐藏其它tab
	    	    for(var loop=3;loop>=0;loop--){
	    	        if(loop!==tabIndex){
	    	            var tab = tabs.getTab(loop);
			            if (tab) {
			                tabs.updateTab(tab, { visible: false });
			            }
	    	        }
	    	    }
    	    }
    	    tabs.activeTab(tabIndex);
    	    var activeTab=tabs.getActiveTab();
    	    activeTab.onload = function (e) {        
	                         var tradeTabs = e.sender;
	                         var iframe = tradeTabs.getTabIFrameEl(e.tab);
	                         if(data!=null){
	                             //data不为空，则视为复制增加，需填充页面数据
	                             iframe.contentWindow.SetData(data);
	                         }
	                     };
    	}
	</script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/transaction/invest/transaction_JS/transactionInstructComJs.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/JQMHistory/common/common.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/transaction/investNew/js/makeInstruct.js"></script>
</html>