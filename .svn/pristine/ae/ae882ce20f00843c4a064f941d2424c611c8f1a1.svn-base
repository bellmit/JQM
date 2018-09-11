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
<title>指令/建议缴款流程-修改报价</title>
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
				业务日期:
			  </td>
			  <td colspan="1" width="35%">
			  	<input class="mini-datepicker" id="bizProcess.dApplicationTime" name="bizProcess.dApplicationTime" format="yyyy-MM-dd H:mm:ss" timeFormat="H:mm:ss" 
			  	showTime="true" showOkButton="true" inputStyle="background-color:#f0f0f0;" showClearButton="false" readonly="readonly"  width="100%"/>
			  	
			  </td>
			  <td colspan="1" width="100px" class="form_label" align="right">
				创建时间:
			  </td>
			  <td colspan="1" width="35%">
			   <input class="mini-datepicker" id="bizProcess.dCreationTime" name="bizProcess.dCreationTime" format="yyyy-MM-dd H:mm:ss" timeFormat="H:mm:ss" 
			  	showTime="true" showOkButton="true" inputStyle="background-color:#f0f0f0;" showClearButton="false" readonly="readonly"  width="100%"/>
			  	
			  </td>
			</tr>
			<tr>
			  <td colspan="1" width="15%" class="form_label" align="right">
				债券全称:
			  </td>
			  <td colspan="1">
			  	<input class="nui-textbox" id="applyInst.vcStockName" name="applyInst.vcStockNameFull" enabled="false" readonly="readonly" width="100%"/>
			  	
			  </td>
			  <td width="15%" align="right">债券代码</td>
			  <td width="35%">
			  <input class="nui-textbox" id="applyInst.vcStockCode" name="applyInst.vcStockCode" enabled="false" readonly="readonly" width="100%"/>
			  </td>
			</tr>
			
			<tr>
			  <td colspan="1" class="form_label" align="right">
				产品名称:
			  </td>
			  <td colspan="1">
			  
		  	<input id="productCombo" class="mini-combobox" name="applyInst.vcProductCode"  textField="TEXT" valueField="ID" 
		    url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryTAtsProductInfo.biz.ext"   value="cn" showNullItem="false"  allowInput="true"
		     emptyText="请选择" enabled="false"  readonly="readonly" width="100%"/> 
			  </td>
			  <td colspan="1" class="form_label" align="right">
				组合名称:
			  </td>
			  <td colspan="1">
			  <input  class="mini-combobox" id="vcCombiNo" name="applyInst.vcCombiNo"  textField="TEXT" valueField="ID"
		     value="cn"  showNullItem="false"  allowInput="true"
		   emptyText="请选择" enabled="false"  readonly="readonly" width="100%"/> 
			  </td>
			</tr>
		       <tr>
				  <td colspan="1" width="15%" class="form_label" align="right">缴款面值(万元):</td>
				  <td colspan="1">
				  	<input class="nui-textbox" id="payFaceValue"  name="applyInst.enPayFaceValue" onvaluechanged="payVcBallotNumber()" vtype="float" width="100%"/>  
				  </td>
				  <td width="15%" align="right"> 发行价格(元):</td>
				  <td width="35%">
				  	<input class="nui-textbox" name="applyInst.enBallotPrice" id="enBallotPrice"  onvaluechanged="payVcBallotPrice()" vtype="float" width="100%"/>
				  </td>
			    </tr>
			    
			    <tr>
				  <td colspan="1" width="15%" class="form_label" align="right"> 缴款金额(万元):</td>
				  <td colspan="1">
				  	<input class="nui-textbox"  id="paymentMoney" name="applyInst.enPaymentMoney" vtype="float" width="100%"/>
				  </td>
				  <td width="15%" align="right">票面利率(%):</td>
				  <td width="35%">
				  	<input class="nui-textbox" name="applyInst.enCouponRate" id="enCouponRate" vtype="float" width="100%"/>
				  </td>
			    </tr>
			   	<tr>
				  <td colspan="1" width="15%" class="form_label" align="right"> 缴款日期:</td>
				  <td colspan="1">
				  	<input class="mini-datepicker" format="yyyy-MM-dd"  id="dPaymentDate"  name="applyInst.dPaymentDate" readonly="readonly" enabled="false" width="100%"/>
				  </td>
				  <td width="15%" align="right">首次付息日:</td>
				  <td width="35%">
				  	<input class="mini-datepicker" format="yyyy-MM-dd"  name="applyInst.dInitInterestPaymentDate" id="dInitInterestPaymentDate"  readonly="readonly"  enabled="false" width="100%"/>
				  </td>
			    </tr>
			</table>
	     	
		<div title="报量录入">
			<div class="nui-toolbar" style="border-bottom:0;padding:0px;margin-top: 2px;height: 25px;">
				<table style="width:100%;">
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
				报量方式：<input style="width: 140px;" id="reportType"  name="applyInst.cReportType" url="<%= request.getContextPath() %>/fm/instr/processUtil/reportData.txt" class="nui-dictcombobox" required="true"  />
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
	<!-- 审批信息 -->
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
	<!--隐藏表单-->
	<form action="" name="openForm" method="post" target="_blank">
	  <input type="hidden" name="workItemID" id="workItemID">
	  <input type="hidden" name="processInstID" id="processInstID">
	  <input type="hidden" name="bizId" id="bizId1">
	  <input type="hidden" name="pageType" id="pageType" value="1"/>
	</form>
	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid10");
    	var processInstID="<%=request.getParameter("processinstid") %>";
    	var processInstID,activityDefID,workItemID,activityInstID;
    	
		
		
		var bizId;
		//跨页面参数传递参数
		function setFormData(data){
			
    	    //跨页面传递的数据对象，克隆后才可以安全使用
	   		var infos = nui.clone(data);
	   		nui.get("bizId").setValue(infos.bizId);
	   		bizId=infos.bizId;
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
						activityInstID=returnJson.workItems[0].activityInstID;
						var currentState=returnJson.workItems[0].currentState;
						var form = new nui.Form("#dataform1");//将普通form转为nui的form
						//数据存入表单
						
						/*var vcStockType = nui.get("stockissueinfo.vcStockType");
						var url = "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext";
			            vcStockType.setUrl(url);*/
			            //资金清算后不能修改缴款信息
			            isUpdatePayMent(activityDefID);
			            var vcCombiNo = nui.get("vcCombiNo");
			            
						var url = "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryCombiInfo.biz.ext?queryType=1&vcProductCode=" + returnJson.applyInst.vcProductCode;
			            vcCombiNo.setUrl(url);
			            form.setData(returnJson);
						form.setChanged(false);
						//applyInst
						//判定是否包含ATS_FM_CZ,包含则工作项为非传真之前
						if(returnJson.applyInst.cReportType=="" || returnJson.applyInst.cReportType==null){
						   nui.get('reportType').select(0);
						}
						if(currentState==7){
							nui.alert("流程已结束，不允许操作！");  
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
			var form = new mini.Form("#dataform1"); 
			
			form.validate();
			if(form.isValid() == false){
				nui.alert("有数据为空或者格式不对，请确认！");
				return;
			}
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
			
			var vcComments=nui.get("vcComments").getValue();
			var prcaprvinfo={vcComments:vcComments==""?"修改报量信息":vcComments}; //审批信息
			//vcInvestCount;//最大报量 --投标金额     vcInterestRate;//最大报价   --投标利率
			var formData=form.getData(false,true);
			var applyInst=formData.applyInst;
		    
			//var applyInst={cReportType:nui.get("reportType").getValue()};
			//获取投标金额和投标利率
			applyInst=getReportBidInfo(applyInstReport,applyInst);
			//enInvestBalance 投标金额  enInterestRate 投标利率
			//enPaymentMoney 缴款金额
			//enPayFaceValue 缴款面值
			//enBallotPrice 缴款价格
			//enCouponRate 票面利率
			//1、风控条件。缴款面值改大;
			//2、报量金额必须大于等于缴款面值,报价小于等于票面利率 
			//校验报量信息与缴款信息是否匹配
			if(checkPaymentReport(applyInst)==false){return;}
			//流程实例相关信息
			var workitme={processInstID:processInstID,activityInstID:activityInstID,activityDefID:activityDefID,workItemID:workItemID};
			
			 //序列化成JSON addReposts
			var json = mini.encode({addReposts:applyInstReport,
			bizId:bizId,prcaprvinfo:prcaprvinfo,workitme:workitme,applyInst:applyInst}); 
			//console.log(json);
			form.loading();//加载遮罩
			//提交
			nui.ajax({
			    url: "com.cjhxfund.ats.fm.instr.firstGradePayment.updatePaymentReport.biz.ext",
			    type: "post",
			    data: json,
			    dataType:"json",
			    success: function (text) {
			    	form.unmask();//取消遮罩
			    	
					if(text.ret==2){
			    		var workitme = text.newWorkItem;
			    	    var userId='<%=userId %>';  //数字ID
			    		if(text.checkStatus=="1"){
			    			nui.confirm("修改成功，是否前往复核？","系统提示",function(act){
		    					if(act=="ok"){
		    					    var actionUrl = "/com.cjhxfund.ats.fm.instr.FirstGradePayment.flow";
		    						wfOpenWin(actionUrl,workitme.processInstID,workitme.workItemID,bizId);
		    					}
		    					//关闭界面
		    					CloseWindow("cancel");
		    				});
			    		}else{
			    			nui.alert("修改报价成功！","系统提示",function (a){
				    			//关闭界面
				    			CloseWindow("cancel");
				    		});
			    		}
			    	}else if(text.ret== 5){
			    		nui.alert("当前流程正在审批中，请耐心等待！","系统提示",function (a){});
			    	}else if(text.ret== 6){
			    		nui.alert("指令/建议当前不可以用，请重新打开界面！！");
			    	}else{
			    		nui.alert("提交失败，请联系管理员！");
			    	}
			    }
			});
			
			
		}
		var contextPath = "<%=request.getContextPath() %>";
		function wfOpenWin(url,processInstID,workItemID,bizId) {
			var winFrm=document.openForm;
			document.getElementById("processInstID").value=processInstID;
			document.getElementById("workItemID").value=workItemID;
			document.getElementById("bizId1").value=bizId;
			var actionURL=contextPath+"/"+url; //目标页面
			winFrm.action=actionURL;
					
			var newwin = window.open('about:blank', 'newWindow' + bizId, '');
			winFrm.target = 'newWindow' + bizId;//这一句是关键
			winFrm.submit();
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
	function isUpdatePayMent(activityDefID){
	  if(activityDefID=="ATS_FM_ZJQS" || activityDefID=="ATS_FM_PDFXYYY" || activityDefID=="ATS_FM_FXYYYFH" ||activityDefID=="ATS_FM_FXYYY"){
	     //缴款面值
	     readonlyInput("payFaceValue","payFaceValue");
	     //发行价格
	     readonlyInput("enBallotPrice","enBallotPrice");
	     //缴款金额
	     readonlyInput("paymentMoney","paymentMoney");
	     //票面利率
	     readonlyInput("enCouponRate","enCouponRate");
	  } 
	}
	function readonlyInput(inputNuiId,inputJQId){
			nui.get(inputNuiId).readOnly="readonly";//nui禁用
			$("#"+inputJQId+" input").attr("readonly","readonly");//解决nui禁用IE兼容
			$("#"+inputJQId+" input").css("background-color","#f0f0f0");//置灰
		}
	//缴款面值值改变
	function payVcBallotNumber(){
     	var payFaceValue = nui.get("payFaceValue").getValue().replace(/,/gi,'');
     	//验证缴款面值是否为正数
     	var reg = /^([0-9]+)(\.\d{1,4})?$/;
		if (!reg.test(payFaceValue))
		{
			nui.alert("缴款面值不能包含负数、字母、特殊字符，请输入正数！","系统提示");
			return;
		}
     	
     	var ballotPrice  = nui.get("enBallotPrice").getValue().replace(/,/gi,'');   //获取中标价格
     	if(ballotPrice != null && ballotPrice != ""){
     		payVcBallotPrice(); //计算缴款金额
     	}
    }
    //发行价格值改变
		function payVcBallotPrice(){
	     	var payFaceValue = nui.get("payFaceValue").getValue().replace(/,/gi,'');  //获取缴款面额
	     	var ballotPrice  = nui.get("enBallotPrice").getValue().replace(/,/gi,'');   //获取发行价格
	     	//验证中标价格是否为正数
	     	var reg = /^(([0-9]+)|([0-9]+\.[0-9]{1,4}))$/;
			if (!reg.test(ballotPrice))
			{
				nui.alert("中标价格不能包含负数、字母、特殊字符，请输入正数","系统提示");
				return;
			}
	     	//计算缴款金额并赋值
	     	nui.get("paymentMoney").setValue(payFaceValue*ballotPrice/100);
        }
    </script>
</body>
</html>