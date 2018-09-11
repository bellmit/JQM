<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 杨敏
  - Date: 2016-07-19 15:18:15
  - Description:
-->
<head>
<title>中标缴款</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        
	    
	    
	<style type="text/css">
	   .td{
	      border-bottom: 1px solid #D3D3D3;
	   }
	</style>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;">
	<!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
    <input name="pageType" class="nui-hidden" type="hidden"/>
	<div id="dataform1" style="padding-top:5px;">
	     
	    <table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">
			<tr>
			  <td colspan="1"  class="form_label">
				债券名称:
			  </td>
			  <td colspan="1">
			  	<input class="nui-textbox" id="applyInst.vcStockName" name="applyInst.vcStockName" readonly="readonly" />
			  	
			  </td>
			  <td >债券代码</td>
			  <td >
			  <input class="nui-textbox" id="applyInst.vcStockCode" name="applyInst.vcStockCode" readonly="readonly" />
			  </td>
			</tr>
			<tr>
			  <td colspan="1"  class="form_label">
				债券类别:
			  </td>
			  <td colspan="1" >
			    <input class="nui-combobox" name="applyInst.vcStockType" readonly="readonly"  valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY"  
									emptyText="全部" nullItemText="全部" showNullItem="true" multiSelect="true" showClose="true" valueFromSelect="true" />
			  </td>
			  <td colspan="1"  class="form_label">
				发行期限:	 
			  </td>
			  <td colspan="1" >
			  	<input class="nui-textbox" name="applyInst.enExistLimite" readonly="readonly"/>
			  </td>
			</tr>
			<tr>
			  <td colspan="1" class="form_label">
				发行规模:	
			  </td>
			  <td colspan="1">
			  	<input class="nui-textbox" name="applyInst.vcIssueSize" readonly="readonly"/>
			  </td>
			  <td colspan="1" class="form_label">
				主体评级:
			  </td>
			  <td colspan="1">
			    <input class="nui-combobox" name="applyInst.cIssueAppraise" readonly="readonly"  valueField="dictID" textField="dictName" dictTypeId="issuerRating"  
									emptyText="全部" nullItemText="全部" showNullItem="true" multiSelect="true" showClose="true" valueFromSelect="true" />
			  </td>
			</tr>
			<tr>
			  <td colspan="1" class="form_label">
				产品名称:
			  </td>
			  <td colspan="1">
			  
		  	<input id="productCombo" class="nui-dictcombobox" name="applyInst.vcProductCode"  textField="TEXT" valueField="ID" 
		    url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryTAtsProductInfo.biz.ext"  data="data" value="cn" showNullItem="false" required="true" allowInput="true"
		     emptyText="请选择"   readonly="readonly"/> 
			  </td>
			  <td colspan="1" class="form_label">
				组合名称:
			  </td>
			  <td colspan="1">
			  <input id="combiCombo" class="nui-dictcombobox" name="applyInst.vcCombiNo"  textField="TEXT" valueField="ID"
		     value="cn" url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryCombiInfo.biz.ext" showNullItem="false" required="true" allowInput="true"
		   emptyText="请选择"  readonly="readonly"/> 
			  </td>
			</tr>
			<tr>
			  <td colspan="1" class="form_label">
				交易对手:
			  </td>
			  <td colspan="1">
			  	<input class="nui-textbox" name="applyInst.vcBusinessObject" readonly="readonly" required="true"/>
			  </td>
			  <td colspan="1" class="form_label">
				交易场所:
			  </td>
			  <td colspan="1">
			  	<input class="nui-dictcombobox" name="applyInst.cMarketNo" allowInput="true"
			  	 url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryCMarket.biz.ext" readonly="readonly"  emptyText="请选择" textField="TEXT" valueField="ID"  required="true" showNullItem="false"  />
			  </td>
			</tr>
			<tr>
			  <td colspan="1" class="form_label td">
				备注:	
			  </td>
			  <td colspan="3" class="td">
			  	<input class="nui-textarea" width="80%" name="applyInst.vcRemarks" readonly="readonly"/>
			  </td>
			</tr>
		</table>
	     
		<div title="缴款信息">
			<div class="nui-toolbar" style="border-bottom:0;padding:0px;margin-top: 2px;height: 25px;">
				<table style="width:100%;">
					<tr>
						<td style="width:100%;">
			          		缴款信息
						</td>
					</tr>
				</table>
			</div>
			<table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">
				<tr>
				  <td colspan="1" class="form_label td">
					缴款面值(万元):	
				  </td>
				  <td  class="td">
				  	<input class="nui-textbox"  name="stockIssueInfo.vcPayFaceValue" required="true"/>
				  </td>
				  <td colspan="1" class="form_label td">
					缴款日期:	
				  </td>
				  <td  class="td">
				  	<input class="nui-datepicker" showTodayButton="true"  name="stockIssueInfo.dPaymentDate" required="true"/>
				  </td>
				</tr>
				<tr>
				  <td colspan="1" class="form_label td">
					缴款金额(万元):	
				  </td>
				  <td  class="td">
				  	<input class="nui-textbox"  name="stockIssueInfo.vcPaymentMoney" required="true" />
				  </td>
				  <td colspan="1" class="form_label td">
					发行价格:	
				  </td>
				  <td  class="td">
				  	<input class="nui-textbox"  name="stockIssueInfo.vcIssuePrice" />
				  </td>
				</tr>
				<tr>
				  <td colspan="1" class="form_label td">
					票面利率(万元):	
				  </td>
				  <td  class="td">
				  	<input class="nui-textbox"  name="stockIssueInfo.enFaceRate" required="true"/>
				  </td>
				  <td colspan="1" class="form_label td">
					付息频率:	
				  </td>
				  <td  class="td">
				  	<input class="nui-dictcombobox" readonly="readonly" dictTypeId="ATS_CF_JY_FREQUENCY" name="stockIssueInfo.vcFrequency" />
				  </td>
				</tr>
				<tr>
				  <td colspan="1" class="form_label td">
					还本方式:	
				  </td>
				  <td  class="td">
				  	<input class="nui-dictcombobox" dictTypeId="CF_JY_MODE_REPAYMENT" name="stockIssueInfo.vcModeRepayment" />
				  </td>
				  <td colspan="1" class="form_label td">
					计息起始日:	
				  </td>
				  <td  class="td">
				  	<input class="nui-datepicker" showTodayButton="true" readonly="readonly"  name="stockIssueInfo.dStartingDateInterest" />
				  </td>
				</tr>
				<tr>
				  <td colspan="1" class="form_label td">
					计息截止日:	
				  </td>
				  <td  class="td">
				  	<input class="nui-datepicker" showTodayButton="true" readonly="readonly" onvalidation="onComboValidation"  name="stockIssueInfo.dDeadlineInterest" />
				  </td>
				 
				</tr>
			</table>
		</div>
			
			
			<input class="nui-hidden" type="hidden" id="bizId" name="bizId" value="1"/>
			<!-- 存储报量临时数据 -->
			<input class="nui-hidden" type="hidden" id="report.vcReport" name="report.vcReport" value="0" />
			    
			
		
	</div>
	<!-- 审批信息 -->
	<div>
	  <table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">
			<tr>
			  <td colspan="1"  class="form_label">
				修改意见:
			  </td>
			  <td colspan="3">
			   <input class="nui-textarea" id="vcComments" width="80%" name="prcaprvinfo.vcComments" />
			  </td>
			</tr>
	  </table>
	</div>
    <div class="nui-toolbar" id="submit_button" style="padding:0px;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align:center;" colspan="4">
					<a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">
                                                                        确认修改
					</a>
					<span style="display:inline-block;width:25px;"></span>
					<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
                                                                          取消
					</a>
				</td>
			</tr>
		</table>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	
    	var processInstID="<%=request.getParameter("processinstid") %>";
    	var processInstID,activityDefID,workItemID;
    	
		
		function onComboValidation(e){
			//var items = this.findItems(e.value);
           //console.log(e);
            if(e.value==0){
            	e.value="";
            }
		}
		//跨页面参数传递参数
		function setFormData(data){
			
    	    //跨页面传递的数据对象，克隆后才可以安全使用
	   		var infos = nui.clone(data);
	   		
	   		//processInstID:processInstID,bizId:bizId
	   		//var data = {bizId:infos.bizId};
	   		nui.get("bizId").setValue(infos.bizId);
		
			//查询流程当前待办工作项
			nui.ajax({
			    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadWorkItem.biz.ext",
			    type: "post",
			    data: {bizId:nui.get("bizId").getValue()},
			    dataType:"json",
			    success: function (text) {
			    	var returnJson = nui.decode(text);
					if(returnJson.workItems.length>0){
						processInstID = returnJson.workItems[0].processInstID;//流程实例id
						activityDefID = returnJson.workItems[0].activityDefID;//活动id
						workItemID = returnJson.workItems[0].workItemID;//工作项id
						var form = new nui.Form("#dataform1");//将普通form转为nui的form
						//数据存入表单
						form.setData(returnJson);
						form.setChanged(false);
						//applyInst
						//判定是否包含ATS_FM_CZ,包含则工作项为非传真之前
						if(activityDefID.indexOf("ATS_FM_CZ")>0 && activityDefID!="ATS_FM_CZ"){
							nui.alert("已经传真过了，不能再修改，请确认！");
							//隐藏提交
							$("#submit_button").css("display","none");
						}
						
					}else{
						nui.alert("网络错误，请重新打开页面！");
						//隐藏提交
						$("#submit_button").css("display","none");
					}
					
			    }
			});
	   		
    	}
		
		//提交数据
		function onOk(){
			//获取表单提交数据
			var form = new nui.Form("#dataform1"); 
			form.loading();//加载遮罩
			//校验表单
			if(!form.validate()){
				nui.alert("有数据为空，请确认！");
				return;
			}
			
			
			var vcComments=nui.get("vcComments").getValue();
			var prcaprvinfo={vcComments:vcComments==""?"修改报量信息":vcComments}; //审批信息
			
			var data = form.getData(false,true);      //获取表单多个控件的数据
			var applyInst=data.applyInst;//指令/建议信息
			var stockIssueInfo=data.stockIssueInfo;//债券信息
			//债券同步指令/建议
			applyInst.dInitInterestPaymentDate=stockIssueInfo.dInitInterestPaymentDate; //首次付息日
			applyInst.vcIssuePrice=stockIssueInfo.vcIssuePrice; //发行价格
			applyInst.vcCouponRate=stockIssueInfo.vcCouponRate;  //票面利率
			applyInst.vcFrequency=stockIssueInfo.vcFrequency; //付息频率
			applyInst.vcModeRepayment=stockIssueInfo.vcModeRepayment; //还本方式
			applyInst.dDeadlineInterest=stockIssueInfo.dDeadlineInterest; //计息截止日
			applyInst.dStartingDateInterest=stockIssueInfo.dStartingDateInterest; //计息起始日
			applyInst.vcPayFaceValue=stockIssueInfo.vcPayFaceValue; //缴款面值
			applyInst.dPaymentDate=stockIssueInfo.dPaymentDate; //缴款日期
			applyInst.vcPaymentMoney=stockIssueInfo.vcPaymentMoney; //缴款金额
			
			//流程实例相关信息
			var workitme={processInstID:processInstID,activityDefID:activityDefID,workItemID:workItemID};
			var bizId=nui.get("bizId").getValue();//获取bizId
			 //序列化成JSON addReposts
			var json = nui.encode({bizId:bizId,prcaprvinfo:prcaprvinfo,workitme:workitme,applyInst:applyInst}); 
			//console.log(json);
			
			//提交
			nui.ajax({
			    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.saveBiddingPayment.biz.ext",
			    type: "post",
			    data: json,
			    dataType:"json",
			    success: function (text) {
			    	if(text.out==1){
			    		nui.alert("提交成功！");
			    	}
			    	form.unmask();//取消遮罩
			        //alert("提交成功，返回结果:" + text.out);    
			    }
			});
			
			
		}
		
		//关闭窗口
		function CloseWindow(action) {
			if (action == "close" && form.isChanged()) {
				if(confirm("数据被修改了，是否先保存？")) {
					saveData();
				}
			}
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else window.close();
		}
		
		//取消
		function onCancel() {
			CloseWindow("cancel");
		}
    </script>
</body>
</html>