<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-06-21 15:58:24
  - Description:
-->
<head>
<title>指令/建议详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    <style type="text/css">
    	tr{
		    display: table-row;
		    vertical-align: inherit;
		    border-color: inherit;
		}
		.nui-form-table {
		    border-collapse: collapse;
		    border: none;
		    padding-left: 5px;
		}
    </style>
</head>
<body>
	<div id="instructDetail_grid">
        <table class="nui-form-table" style="width:100%; heiht:100%">
            <tr>
                <td align="right"><span style="color: red">*</span>产品名称：</td>
                <td >    
                    <input name="instructInfo.vcProductName" class="nui-textbox" required="true" readonly/>
                </td>
                <td align="right"><span style="color: red">*</span>交易日期：</td>
                <td >    
                    <input name="instructInfo.lTradeDate" class="nui-textbox" required="true" readonly/>
                </td>
            </tr>
            <tr>
                <td align="right"><span style="color: red">*</span>组合名称：</td>
                <td >    
                    <input name="instructInfo.vcCombiName" class="nui-textbox" required="true" readonly/>
                </td>
                <td align="right">首次结算日期：</td>
				<td>
                   <input name="instructInfo.lFirstSettleDate" class="nui-textbox" required="true" readonly/>
				</td>
            </tr>
            <tr>
                <td align="right"><span style="color: red">*</span>回购天数：</td>
                <td >    
                    <input name="instructInfo.lRepoDays" class="nui-textbox" required="true" readonly/>
                </td>
                <td align="right">到期结算日期：</td>
                <td >    
                    <input name="instructInfo.lMaturitySettleDate" class="nui-textbox"  required="true" readonly/>
                </td>
            </tr>  
            <tr>
                <td align="right"><span style="color: red">*</span>委托方向：</td>
                <td >    
                    <input name="instructInfo.vcEntrustDirection" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="entrustDirection" required="true" readonly/>
                </td>
                <td align="right">到期结算金额(元)：</td>
                <td >                        
                    <input class="nui-textbox" name="instructInfo.enSettleAmount" id="enSettleAmount" enabled="false" maxValue="100000000000000000000" format="n4" readonly/>
                </td>
            </tr>
            <tr>
                <td align="right"><span style="color: red">*</span>清算速度：</td>
                <td >    
                    <input name="instructInfo.vcSettleSpeed" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="settleSpeed" required="true" readonly/>
                </td>
                <td align="right">占款天数：</td>
                <td >    
                    <input name="instructInfo.lContractPeriods" class="nui-textbox" required="true" readonly/>
                </td>
            </tr>
            
            <tr>
                <td align="right"><span style="color: red">*</span>回购金额（万元）：</td>
                <td >    
                	<input name="instructInfo.enFaceAmount" class="nui-spinner" minValue="0" maxValue="10000000000" format="n2" required="true" readonly/>
                </td>
                <td align="right">回购利息（元）：</td>
                <td> 
                	<input name="instructInfo.enRepoInterest" class="nui-spinner" enabled="false"
                                   vtype="int"  minValue="0" maxValue="100000000000000000000" format="n4" readonly/>   
                </td>
            </tr>
            <tr>
                <td align="right"><span style="color: red">*</span>交易对手：</td>
                <td> 
                	<input name="instructInfo.vcCounterpartyName" class="nui-textbox" required="true" readonly/>   
                </td>
                <td align="right">对方交易员：</td>
                <td>    
                    <input name="instructInfo.vcCounterpartyTrader" class="nui-textbox" readonly/>
                </td>
            </tr>   
            <tr>
                <td align="right"><span style="color: red">*</span>报价方式：</td>
                <td> 
                	<input name="instructInfo.vcQuoteMode" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="quoteMode" id="vcQuoteMode" required="true" readonly/>   
                </td>
                <td align="right">备注：</td>
                <td>    
                    <input name="instructInfo.vcRemark" class="nui-textbox" required="true" readonly/>
                </td>
            </tr>
            <tr>
            	<td id="enRepoRateText" align="right"><span style="color: red">*</span>回购利率（%）：</td>
            	<td id="enWeightingText" align="right"><span style="color: red">*</span>加点(bp)：</td>
                <td id="enRepoRateValue">    
                    <input name="instructInfo.enRepoRate" class="nui-textbox" required="true" readonly/>
                </td>
                <td id="enWeightingValues">    
                    <input name="instructInfo.enWeightingValue" class="nui-textbox" required="true" readonly/>
                </td>
                <td align="right">对手主体机构：</td>
                <td >    
                    <input name="instructInfo.vcCounterpartyOrgan" class="nui-textbox" required="true" readonly/>
                </td>
            </tr>        
        </table>
        <table class="nui-form-table" style="width:100%;">
        	<tr>
        		<td align="center">
        			<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow()">关闭</a>
        		</td>
        	</tr>
        </table>
    </div>      
	<!--输入项完整指令/建议end  -->

	<script type="text/javascript">
    	nui.parse();
    	$("#instructDetail_grid .mini-buttonedit-button").remove();
    	var instruct_detail_from = new nui.Form("#instructDetail_grid");
    	
    	function setFormData(data){
    		//跨页面传递的数据对象，克隆后才可以安全使用
    		var row = nui.clone(data);
    		if(row.lFirstSettleDate != null){
				row["lFirstSettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lFirstSettleDate"].toString()),"yyyy-MM-dd");
			}
			if(row.lMaturitySettleDate != null){
				row["lMaturitySettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lMaturitySettleDate"].toString()),"yyyy-MM-dd");
			}
			if(row.lTradeDate != null){
				row["lTradeDate"] = nui.formatDate(DateUtil.numStrToDate(row["lTradeDate"].toString()),"yyyy-MM-dd");
			}
			instruct_detail_from.setData({instructInfo:row});
    	}
    	
    	// 根据序号查指令信息
    	function setResultNo(resultNo){
    		var params = {instructNo:resultNo, instructValid:'1'};
    		var a = nui.loading("正在处理中,请稍等...","提示");
    		nui.ajax({
		    	url: "com.cjhxfund.ats.sm.comm.InstructionManager.queryRightInstructInfos.biz.ext",
		      	type: 'POST',
		      	data: {paramObject:params},
		      	contentType: 'text/json',
		      	success: function(text){
		      		nui.hideMessageBox(a);
		      		var returnJson = nui.decode(text.insructInfos);
		      		if(returnJson.length>0){
		      			var row = returnJson[0];
			    		if(row.lFirstSettleDate != null){
							row["lFirstSettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lFirstSettleDate"].toString()),"yyyy-MM-dd");
						}
						if(row.lMaturitySettleDate != null){
							row["lMaturitySettleDate"] = nui.formatDate(DateUtil.numStrToDate(row["lMaturitySettleDate"].toString()),"yyyy-MM-dd");
						}
						if(row.lTradeDate != null){
							row["lTradeDate"] = nui.formatDate(DateUtil.numStrToDate(row["lTradeDate"].toString()),"yyyy-MM-dd");
						}
						instruct_detail_from.setData({instructInfo:row});
						if(row.enRepoRate !=null && row.enRepoRate !=""){
							document.getElementById("enWeightingText").style.display = "none";
							document.getElementById("enWeightingValues").style.display = "none";
						}else{
							document.getElementById("enRepoRateText").style.display = "none";
							document.getElementById("enRepoRateValue").style.display = "none";
						}
		      		}
		      	}
	 		});
    	}
    	
    	//关闭窗口
		function CloseWindow(action) {
		    if (window.CloseOwnerWindow)
		    return window.CloseOwnerWindow(action);
		    else window.close();
		}
    </script>
</body>
</html>