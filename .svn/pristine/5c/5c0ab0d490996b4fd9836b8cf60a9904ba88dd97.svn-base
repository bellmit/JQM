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
<title>中标确认修改报价发起子流程</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        
	    
	    
		<script src="<%= request.getContextPath() %>/fm/instr/processUtil/instr.js" type="text/javascript"></script>
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
			  <td colspan="1" width="100px" class="form_label" align="right">
				债券简称:
			  </td>
			  <td colspan="1">
			  	<input class="nui-textbox" id="applyInst.vcStockName" name="applyInst.vcStockName" enabled="false" readonly="readonly" />
			  	
			  </td>
			  <td width="100px" align="right">债券代码:</td>
			  <td width="35%">
			  <input class="nui-textbox" id="applyInst.vcStockCode" name="applyInst.vcStockCode" enabled="false" readonly="readonly" />
			  </td>
			</tr>
			<tr>
			  <td colspan="1" width="15%" class="form_label" align="right">
				债券类别:
			  </td>
			  <td colspan="1" width="35%">
			    <input  class="nui-dictcombobox" id="stockissueinfo.vcStockType" name="stockissueinfo.vcStockType" value="<b:write property="firstGradeBond/vcStockType" />" allowInput="true"
			  	  emptyText="请选择" textField="text"  valueField="id" enabled="false"  showNullItem="false" readonly="readonly" />
			  	
			  </td>
			  <td colspan="1" width="15%" class="form_label" align="right">
				发行期限(年):	 
			  </td>
			  <td colspan="1" width="35%">
			  	<input class="nui-textbox" name="stockissueinfo.enExistLimite" enabled="false" readonly="readonly"/>
			  </td>
			</tr>
			<tr>
			  <td colspan="1" class="form_label" align="right">
				发行规模(亿):	
			  </td>
			  <td colspan="1">
			  	<input class="nui-textbox" name="stockissueinfo.enIssueBalance" enabled="false" readonly="readonly"/>
			  </td>
			  <td colspan="1" class="form_label" align="right">
				主体评级:
			  </td>
			  <td colspan="1">
			     <input  class="nui-dictcombobox" name="stockissueinfo.cIssueAppraise" enabled="false" readonly="readonly" dictTypeId="issuerRating" />
			  				
			  </td>
			</tr>
			<tr>
			  <td colspan="1" class="form_label" align="right">
				产品名称:
			  </td>
			  <td colspan="1">
			  
		  	<input id="productCombo" class="mini-combobox" name="applyInst.vcProductCode"  textField="TEXT" valueField="ID" 
		    url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryTAtsProductInfo.biz.ext"   value="cn" showNullItem="false"  allowInput="true"
		     emptyText="请选择" enabled="false"  readonly="readonly"/> 
			  </td>
			  <td colspan="1" class="form_label" align="right">
				组合名称:
			  </td>
			  <td colspan="1">
			  <input  class="mini-combobox" id="vcCombiNo" name="applyInst.vcCombiNo"  textField="TEXT" valueField="ID"
		     value="cn"  showNullItem="false"  allowInput="true"
		   emptyText="请选择" enabled="false"  readonly="readonly"/> 
			  </td>
			</tr>
			<tr>
			  <td colspan="1" class="form_label" align="right">
				交易对手:
			  </td>
			  <td colspan="1">
			  	<input class="nui-textbox" name="applyInst.vcBusinessObject" enabled="false" readonly="readonly" />
			  </td>
			  <td colspan="1" class="form_label" align="right">
				登记托管机构:
			  </td>
			  <td colspan="1">
			  	<input class="nui-dictcombobox" name="applyInst.vcPaymentPlace" allowInput="true"
			  	 dictTypeId="CF_JY_DJTGCS" readonly="readonly"  enabled="false" emptyText="请选择"    showNullItem="false"  />
			  </td>
			</tr>
			<tr>
			  <td colspan="1" width="15%" class="form_label" align="right">缴款面值(万元):</td>
			  <td colspan="1">
			  	<input class="nui-textbox" id="payFaceValue"  name="applyInst.enPayFaceValue" readonly="readonly" enabled="false"/>  
			  </td>
			  <td width="15%" align="right"> 发行价格(元):</td>
			  <td width="35%">
			  	<input class="nui-textbox" name="applyInst.enBallotPrice" id="enBallotPrice" readonly="readonly" enabled="false"/>
			  </td>
		    </tr>
		    
		    <tr>
			  <td colspan="1" width="15%" class="form_label" align="right"> 缴款金额(万元):</td>
			  <td colspan="1">
			  	<input class="nui-textbox"  id="paymentMoney" name="applyInst.enPaymentMoney" readonly="readonly" enabled="false"/>
			  </td>
			  <td width="15%" align="right">票面利率(%):</td>
			  <td width="35%">
			  	<input class="nui-textbox" name="applyInst.enCouponRate" id="enCouponRate"  readonly="readonly"  enabled="false"/>
			  </td>
		    </tr>
			<tr>
			  <td colspan="1" class="form_label td" align="right">
				备注:	
			  </td>
			  <td colspan="3" class="td">
			  	<input class="nui-textarea" width="80%" name="applyInst.vcRemarks" enabled="false" readonly="readonly"/>
			  </td>
			</tr>
		</table>
	     
		<div title="报量录入">
			<div class="nui-toolbar" style="border-bottom:0;padding:0px;margin-top: 2px;height: 25px;">
				<table style="width:100%;" id="reportButton">
					<tr>
						<td style="width:100%;">
			          		报量录入
						</td>
						<td>
							<a class="nui-button " plain="false" iconCls="icon-add" onclick="gridAddRow('datagrid10')"  plain="false" tooltip="增加">
			            		&nbsp;
			          		</a>
			        	</td>
			        	<td >
			          		<a class="nui-button " plain="false" iconCls="icon-remove" onclick="gridRemoveRow('datagrid10')"  plain="false" tooltip="删除">
			            		&nbsp;
			          		</a>
			        	</td>
			        	<td >
	                  		<a class="nui-button " plain="false" iconCls="icon-reload" onclick="gridReload('datagrid10')"  plain="false" tooltip="刷新">
	                    		&nbsp;
	                  		</a>
	                	</td>
	                	<td >
	                  		<a class="nui-button " plain="false" iconCls="icon-help" onclick="showTips()"  plain="false" tooltip="帮助">
	                    		&nbsp;
	                  		</a>
	                	</td>
					</tr>
				</table>
			</div>
			<input class="nui-hidden" type="hidden" id="bizId" name="bizId" value="1"/>
			<!-- 存储报量临时数据 -->
			<input class="nui-hidden" type="hidden" id="report.enReport" name="report.enReport" value="0" />
			<div style="font-size:10px;color:red;">
				<div style="width:65%;float: left;padding-left: 10px;"><b>说明：</b>①报量为100万整数倍；②特殊说明请在报量说明中填写；③报价待定时为空即可</div>
				<div style="width:30%;float: right;padding-right: 10px;text-align: right;line-height: 50px;">
				报量方式：<input style="width: 140px;" id="reportType"  name="applyInst.cReportType"  url="<%= request.getContextPath() %>/fm/instr/processUtil/reportData.txt" class="nui-dictcombobox" required="true"  />
				</div>
			</div>
			    
			<div class="nui-datagrid" id="datagrid10"   height="120px" showPager="false" allowSortColumn="false" allowCellSelect="true" 
			allowCellEdit="true"  url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadReport.biz.ext" multiSelect="true" allowCellValid="true"  oncellvalidation="reportEdit" >
				<div property="columns">
					<div field="enReport"  headerAlign="center" allowSort="true">
						报量(万元)
						<input id="enReport" class="nui-textbox"  name="enReport" property="editor" required="true"/>
					</div>
					<div field="enOffer"  headerAlign="center" allowSort="true">
						报价(%)
						<input id="enOffer" class="nui-textbox" name="enOffer" property="editor" />
					</div>
					<!-- <div field="enEnsureGold"  headerAlign="center" allowSort="true">
						保证金(万元)
						<input id="enEnsureGold" class="nui-textbox" name="enEnsureGold" property="editor" />
					</div> -->
					<div field="vcReportRemark"  headerAlign="center" allowSort="true">
						报量说明
						<input id="vcReportRemark" class="nui-textbox" name="vcReportRemark" property="editor" />
					</div>
				</div>
			</div>
		</div>	 
		
	</div>
	<!-- 审批信息 
	<div>
	  <table style="width:100%; table-layout:fixed;" border="0" class="nui-form-table">
			<tr>
			  <td colspan="1" width="15%" class="form_label">
				修改意见:
			  </td>
			  <td colspan="1">
			  	
			   <input class="nui-textarea" id="vcComments" width="80%" name="prcaprvinfo.vcComments" />
			  </td>
			</tr>
	  </table>
	</div>
	-->
    <div class="nui-toolbar" id="submit_button" style="padding:0px;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align:center;" colspan="4">
					<a class='nui-button' plain='false' id="onOK" iconCls="icon-save" onclick="onOk()">
                                                                        确认修改
					</a>
					<span style="display:inline-block;width:25px;"></span>
					<a class='nui-button' plain='false' id="noticeAdviser" iconCls="icon-download" onclick="noticeAdviser()">
                                                                          通知投顾修改报量
					</a>
					<a class='nui-button' plain='false' id="onCancel" iconCls="icon-cancel" onclick="onCancel()">
                                                                          取消
					</a>
				</td>
			</tr>
		</table>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid10");
    	var processInstID="<%=request.getParameter("processinstid") %>";
    	var processInstID,activityDefID,workItemID,activityInstID;
    	
		
		
		var bizId;
		var applyInst;//传入的指令/建议信息
		var stockIssueInfo;//传入的新债信息
		//跨页面参数传递参数
		function setFormData(data){
    	    //跨页面传递的数据对象，克隆后才可以安全使用
	   		var infos = nui.clone(data);
	   		nui.get("bizId").setValue(infos.bizId);
	   		bizId=infos.bizId;
	   		stockIssueInfo = infos.stockIssueInfo;
	   		applyInst=infos.applyInst;////传入的指令/建议信息
	   		//加载报量数据			
			grid.load({bizId:infos.bizId},function (){
				//默认显示三行数据，不足行数 自动加入。
				var totalCount = 3 - grid.getData().length;
				var arrays=[];
				if(totalCount>0){
					for(var i=0;i<totalCount;i++){
						arrays[i]={};
					}
				}
				//追加不足的行数
				grid.addRows(arrays);
			
			});
			//禁用类型选择，2017-12-4 和蒋芳怡然确认
			nui.get("reportType").readOnly="readonly";
			
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
						activityInstID = returnJson.workItems[0].activityInstID;
						var form = new nui.Form("#dataform1");//将普通form转为nui的form
						//数据存入表单
						
						var vcStockType = nui.get("stockissueinfo.vcStockType");
						var url = "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext";
			            vcStockType.setUrl(url);
			            
			            var vcCombiNo = nui.get("vcCombiNo");
			            
						var url = "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryCombiInfo.biz.ext?queryType=1&vcProductCode=" + returnJson.applyInst.vcProductCode;
			            vcCombiNo.setUrl(url);
			            form.setData(returnJson);
						form.setChanged(false);
						//显示缴款信息
						nui.get("payFaceValue").setValue(applyInst.enPayFaceValue);
						nui.get("enBallotPrice").setValue(applyInst.enBallotPrice);
						nui.get("paymentMoney").setValue(applyInst.enPaymentMoney);
						nui.get("enCouponRate").setValue(applyInst.enCouponRate);
						
						//根据产品的中标确认权限来控制，“确认修改”和“提醒投顾修改”的显示和隐藏
						if(returnJson.isAuth==1){
							//存在中标确认权限，当前使用者则为交易员，否则为投顾
							$("#onOK").css("display","none");//关闭提交按钮
							nui.get("datagrid10").allowCellEdit=false;//禁用编辑
							$("#reportButton").css("display","none");//隐藏按钮
							nui.get("reportType").readOnly="readonly";
							
						}else{
							$("#noticeAdviser").css("display","none");//关闭提交按钮
						}
						
						//applyInst
						//判定是否包含ATS_FM_CZ,包含则工作项为非传真之前
						if(activityDefID!="ATS_FM_CZ_ZBQR"){
							nui.alert("流程已经不在中标确认，不能再修改，请确认！");
							//隐藏提交
							$("#submit_button").css("display","none");
						}
						
					}else{
						nui.alert("已发起子流程,主流程挂起！");
						//隐藏提交
						$("#submit_button").css("display","none");
					}
					
			    }
			});
	   		
    	}
		//通知投顾修改报价
     function noticeAdviser(){
     	var form = new mini.Form("#dataform1"); 
     	//获取父页面传递的缴款信息
     	var json = mini.encode({applyInst:applyInst,stockIssueInfo:stockIssueInfo}); 
     	form.loading();//加载遮罩
		//提交
		nui.ajax({
		    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.noticeAdviser.biz.ext",
		    type: "post",
		    data: json,
		    dataType:"json",
		    success: function (text) {
		    	form.unmask();//取消遮罩
		    	var returnJson = nui.decode(text);
		    	if(returnJson.ret==0){
		    		nui.alert("成功通知投顾修改报量！","系统提醒",function(){
		    			CloseWindow("cancel");
		    		});
		    		
		    	}else{
		    		nui.alert("保存缴款信息失败！，请联系管理员");
		    	}
		    	
		    }
		});
     }
		//提交数据
		function onOk(){
		 nui.confirm("确认提交修改？","系统提示",function(action){
		    if(action == "ok"){
			//获取表单提交数据
			//获取表单提交数据
			var form = new mini.Form("#dataform1"); 
			if(bizId=="" || bizId==null){
				nui.alert("数据异常,请刷新页面!");
				return;
			}
			//定义报量存储
			var applyInstReport=new Array();
			
			var reportData=getReportDatagrid(grid,form);
			if(reportData==false){
				//数据不通过校验
				return;
			}
			//赋值获取报量相关信息
			applyInstReport=reportData.applyInstReport;
			applyInst.cReportType=nui.get("reportType").getValue();//保存报量方式 1累计式   0非累计式
			
			applyInst=getBiddingInfo(applyInst,applyInstReport);//获取投标金额和利率
			
	 		var enPayFaceValue = parseFloat(applyInst.enPayFaceValue);		//缴款面值 EN_PAY_FACE_VALUE
	 		var enInvestBalance = parseFloat(applyInst.enInvestBalance);//投标金额
	 		
	 		if(enPayFaceValue!="" && enInvestBalance!="" && enPayFaceValue!=0 && enInvestBalance!=0){
	 			//判断缴款金额是否大于投标金额
	 			if(enPayFaceValue > enInvestBalance){
	 				nui.alert("缴款面值大于投标报量，不能提交数据，请确认！");
	 				return;
	 			}
 			}else{
 				nui.alert("输入的报量信息和缴款信息数据不匹配，请正确输入相关数据，请确认！");
	 			return;
 			}
 			
			//流程实例相关信息
			var workitme={processInstID:processInstID,activityInstID:activityInstID,activityDefID:activityDefID,workItemID:workItemID};
			//提交中标信息数据
			var applyInstSubmit={lBizId:bizId,enPayFaceValue:applyInst.enPayFaceValue,enBallotPrice:applyInst.enBallotPrice,
			dPaymentDate:applyInst.dPaymentDate,enCouponRate:applyInst.enCouponRate,enPaymentMoney:applyInst.enPaymentMoney,cReportType:applyInst.cReportType,
			vcFrequency:applyInst.vcFrequency,vcModeRepayment:applyInst.vcModeRepayment,lBegincalDate:applyInst.lBegincalDate,lEndincalDate:applyInst.lEndincalDate};
			 //序列化成JSON addReposts  isNoticeAdviser:是否为通知投顾状态 1是，2否
			var json = mini.encode({addReposts:applyInstReport,
			bizId:bizId,workitme:workitme,applyInst:applyInstSubmit,isNoticeAdviser:2,stockIssueInfo:stockIssueInfo}); 
			//console.log(json);
			form.loading();//加载遮罩
			
			//提交
			nui.ajax({
			    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.reportConfirm.biz.ext",
			    type: "post",
			    data: json,
			    dataType:"json",
			    success: function (text) {
			    	form.unmask();//取消遮罩
			    	/*
			    	-1、系统异常
					-2、流程已结束
					-3、中标确认无需发起子流程
					1、投顾复核前，主流程处理
					2、投顾复核到中标确认间 修改报量子流程处理
					3、中标确认时中标修改报量子流程
					4、中标确认后不允许修改
			    	*/
			    	if(text.ret==3){
			    		nui.alert("已发起修改报价子流程，当前申购指令/建议已挂起！","系统提示",function (a){
			    			//关闭界面
			    			CloseWindow("cancel");
			    			if (!!window.ActiveXObject || "ActiveXObject" in window){//如果是IE浏览器
				              	 window.opener.history.go(0);
				              }else{
				              	 window.opener.reloadData();
				              }
	    					//返回我的代办任务页面
	    					CloseWindow("confirmSuccess");
			    		});
			    	}else if(text.ret==4 ||  text.ret==2 || text.ret==1 || text.ret==-2){
			    		nui.alert("当前流程已经不在中标确认环节，请确认！！");
			    	}else if(text.ret==-3){
			    		nui.alert("已经成功修改报量数据，请确认！！","系统提示",function (a){
				    		//关闭界面
				    		CloseWindow("cancel");
				    		if (!!window.ActiveXObject || "ActiveXObject" in window){//如果是IE浏览器
				              	 window.opener.history.go(0);
				              }else{
				              	 window.opener.reloadData();
				              }
	    					//返回我的代办任务页面
	    					CloseWindow("confirmSuccess");
    					});
			    	}else if(text.ret==-4){
			    		nui.alert("输入的报量信息和缴款信息数据不匹配，请正确输入相关数据，请确认！");
			    	}else{
			    		nui.alert("提交失败，请联系管理！");
			    	}
			    	  
			    }
			});
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
		
		function showTips() {
			var reportTypeMark = "";
			var json = '{"paramKey":"REPORT_TYPE_MARK"}';
			var url = "<%= request.getContextPath() %>/fm/instr/firstGradeDebt/reportMark.jsp";
			var title = "报量方式说明";
			var width = "610";
			var height = "618";
			//从系统参数获得报量方式
			$.ajax({
				url:"com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.getParamValue.biz.ext",
				type:'POST',
				data:json,
				cache:false,
				async:false,
				contentType:'text/json',
				success:function(data){
					reportTypeMark = data.paramValue;
				}
			});
			nui.open({
				url: url,
				title: title, width: width, height: height,
				onload: function () {//弹出页面加载完成
					 var iframe = this.getIFrameEl(); 
        			//调用弹出页面方法进行初始化
        			iframe.contentWindow.SetData(reportTypeMark); 
				},
				ondestroy: function (action) {//弹出页面关闭前,把新增的主体简称返回赋值给查询框
				}
			});
	}
    </script>
</body>
</html>