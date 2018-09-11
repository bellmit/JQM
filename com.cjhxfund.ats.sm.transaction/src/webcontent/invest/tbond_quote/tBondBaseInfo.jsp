<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 创金合信
  - Date: 2016-09-03 10:24:14
  - Description: 债券基本信息（银行间债券报价）
-->
<head>
	<title>债券基本信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
    	.mini-buttonedit-border{
    		padding-right:1px;
    	}
    </style>
</head>
<body>
	<div id="dataform_tbond_base_info">
		<table id="table" style="width:100%; table-layout:fixed;margin: 0xp;padding: 0px;"border="0" class="nui-form-table">	
			<tr>
				<td style="width:100px; padding: 5px 5px 5px 0px;" align="right">债券简称：</td>
                <td style="width:10%;">
                	<input name="baseInfo.vcStockName" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="width:100px; padding: 5px 5px 5px 0px;" align="right">债券类型：</td>
                <td style="width:10%;">
                	<input name="baseInfo.vcStockType" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="width:120px; padding: 5px 5px 5px 5px;" align="right">发行量（亿）：</td>
                <td style="width:10%;">
                	<input name="baseInfo.enIssueBalance" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="width:110px; padding: 5px 5px 5px 5px" align="right">剩余年限：</td>
                <td style="width:10%;">
                	<input name="baseInfo.vcLimitLeft" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
        	</tr>
         	<tr>
         		<td style="padding: 5px 5px 5px 5px;" align="right">到期日：</td>
                <td style="width:10%;">
                	<input name="baseInfo.lEndincalDate" class="nui-datepicker" format="yyyy-MM-dd" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px;" align="right">债项评级：</td>
                <td>
                	<input name="baseInfo.vcBondAppraise" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
         		<td style="padding: 5px 5px 5px 5px;" align="right">主体评级：</td>
                <td>
                	<input name="baseInfo.vcIssueAppraise" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px;" align="right">评级机构：</td>
                <td>
                	<input name="baseInfo.vcIssueAppraiseOrgan" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
            </tr>
        	<tr>
        		<td style="padding: 5px 5px 5px 5px;" align="right">评级展望：</td>
                <td>
                	<input name="baseInfo.lRatingForecast" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px;" align="right">票面利率：</td>
                <td>
                	<input name="baseInfo.enFaceRate" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
        		<td style="padding: 5px 5px 5px 5px;" align="right">利率类型：</td>
                <td>
                	<input name="baseInfo.cInterestType" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
        		
        		<td style="padding: 5px 5px 5px 5px;" align="right">票息品种：</td>
                <td>
                	<input name="baseInfo.cPayInterestType" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
            </tr>
			                
			<tr>
				<td style="padding: 5px 5px 5px 5px;" align="right">下一付息日：</td>
                <td>
                	<input name="baseInfo.lNextPayintDate" class="nui-datepicker" format="yyyy-MM-dd" readonly="true" enabled="false"/>
                </td>
				<td style="padding: 5px 5px 5px 5px;" align="right">距下一付息日（天）：</td>
                <td>
                	<input name="baseInfo.lNextPayintDays" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px;" align="right">付息频率利率说明：</td>
                <td>
                	<input name="baseInfo.vcInterestRateDesc" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px;" align="right">下一行权日：</td>
                <td>
                	<input name="baseInfo.lNextExerciseDate" class="nui-datepicker" format="yyyy-MM-dd" readonly="true" enabled="false"/>
                </td>
            </tr>
            <tr>
            	<td style="padding: 5px 5px 5px 5px;" align="right">行权特殊条款：</td>
                <td>
                	<input name="baseInfo.vcSpecialText" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                 <td style="padding: 5px 5px 5px 5px;" align="right">是否跨市场：</td>
                <td>
                	<input name="baseInfo.lIsStepMarket" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px;" align="right">交易所折算比例：</td>
                <td>
                	<input name="baseInfo.enExchangeConverRatio" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px;" align="right">中债估值收益率：</td>
                <td>
                	<input name="baseInfo.enCbValueIncmRate" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
            </tr>
            <tr>
            	<td style="padding: 5px 5px 5px 5px;" align="right">中债估值净价：</td>
                <td>
                	<input name="baseInfo.enCbValueNetValue" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px;" align="right">中债估值全价：</td>
                <td>
                	<input name="baseInfo.enCbValueAllValue" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px;" align="right">托管机构：</td>
                <td>
                	<input name="baseInfo.vcPaymentPlace" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px;" align="right">发行人：</td>
                <td>
                	<input name="baseInfo.vcIssuerNameFull" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
            </tr>
            <tr>
            	<td style="padding: 5px 5px 5px 5px;" align="right">企业性质：</td>
                <td>
                	<input name="baseInfo.vcIssueProperty" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
            	<td style="padding: 5px 5px 5px 5px;" align="right">摘牌日：</td>
                <td>
                	<input name="baseInfo.lDelistingDate" class="nui-datepicker" format="yyyy-MM-dd" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px;" align="right">行业分类：</td>
                <td>
                	<input name="baseInfo.vcIndustry" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
                <td style="padding: 5px 5px 5px 5px;" align="right">公司简介：</td>
                <td>
                	<input name="" class="nui-textbox" readonly="true" enabled="false"/>
                </td>
            </tr>
		</table>
  	</div>	

	<script type="text/javascript">
    	nui.parse();
    	$("#dataform_tbond_base_info .mini-buttonedit-button").remove();
    	var tbond_base_info_from = new nui.Form("#dataform_tbond_base_info");
    	var reportCode = null;
    	var marketNo = null;
    	
    	function detail(selectRow){
    		//当选中的单条记录不是上一个选中的时候重新加载债券信息
    		var row = nui.clone(selectRow);
    		if(reportCode !=row.vcStockCode || marketNo != row.vcMarketNo){
    			if(row.lIsStepMarket=='1'){
    				row["lIsStepMarket"] ="是";
    			}else{
    				row["lIsStepMarket"] ="否";
    			}
    			tbond_base_info_from.setData({baseInfo:row});
    			reportCode = row.vcStockCode;
    			marketNo = row.vcMarketNo;
    		}
    	}
    	function clearDetail(){
    		reportCode = null;
    		marketNo = null;
    		tbond_base_info_from.clear();
    	}
    	window.parent.detailLoaded();
    </script>
</body>
</html>