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
<title>投资指令/建议管理-修改报价</title>
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
			  <td colspan="1" width="35%">
			  	<input class="nui-textbox" id="applyInst.vcStockName" width="90%" name="applyInst.vcStockName" enabled="false" readonly="readonly" />
			  	
			  </td>
			  <td width="100px" align="right">债券代码:</td>
			  <td width="35%">
			  <input class="nui-textbox" width="90%"  id="applyInst.vcStockCode" name="applyInst.vcStockCode" enabled="false" readonly="readonly" />
			  </td>
			</tr>
			<tr>
			  <td colspan="1" width="15%" class="form_label" align="right">
				债券类别:
			  </td>
			  <td colspan="1" width="35%">
			    <input  class="nui-dictcombobox"  width="90%" id="stockissueinfo.vcStockType" name="stockissueinfo.vcStockType" value="<b:write property="firstGradeBond/vcStockType" />" allowInput="true"
			  	  emptyText="请选择" textField="text"  valueField="id" enabled="false"  showNullItem="false" readonly="readonly" />
			  	
			  </td>
			  <td colspan="1" width="15%" class="form_label" align="right">
				发行期限(年):	 
			  </td>
			  <td colspan="1" width="35%">
			  	<input class="nui-textbox"  width="90%" name="stockissueinfo.enExistLimite" enabled="false" readonly="readonly"/>
			  </td>
			</tr>
			<tr>
			  <td colspan="1" class="form_label" align="right">
				发行规模(亿):	
			  </td>
			  <td colspan="1">
			  	<input class="nui-textbox"  width="90%" name="stockissueinfo.enIssueBalance" enabled="false" readonly="readonly"/>
			  </td>
			  <td colspan="1" class="form_label" align="right">
				主体评级:
			  </td>
			  <td colspan="1">
			     <input  class="nui-dictcombobox"  width="90%" name="stockissueinfo.cIssueAppraise" enabled="false" readonly="readonly" dictTypeId="issuerRating" />
			  				
			  </td>
			</tr>
			<tr>
			  <td colspan="1" class="form_label" align="right">
				产品名称:
			  </td>
			  <td colspan="1">
			  
		  	<input id="productCombo" class="mini-combobox"  width="90%" name="applyInst.vcProductCode"  textField="TEXT" valueField="ID" 
		    url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryTAtsProductInfo.biz.ext"   value="cn" showNullItem="false"  allowInput="true"
		     emptyText="请选择" enabled="false"  readonly="readonly"/> 
			  </td>
			  <td colspan="1" class="form_label" align="right">
				组合名称:
			  </td>
			  <td colspan="1">
			  <input  class="mini-combobox" id="vcCombiNo"  width="90%" name="applyInst.vcCombiNo"  textField="TEXT" valueField="ID"
		     value="cn"  showNullItem="false"  allowInput="true"
		   emptyText="请选择" enabled="false"  readonly="readonly"/> 
			  </td>
			</tr>
			<tr>
			  <td colspan="1" class="form_label" align="right">
				交易对手:
			  </td>
			  <td colspan="1">
			  	<input class="nui-textbox"  width="90%" name="applyInst.vcBusinessObject" enabled="false" readonly="readonly" />
			  </td>
			  <td colspan="1" class="form_label" align="right">
				登记托管机构:
			  </td>
			  <td colspan="1">
			  	<input class="nui-dictcombobox"  width="90%" name="applyInst.vcPaymentPlace" allowInput="true"
			  	 dictTypeId="CF_JY_DJTGCS" readonly="readonly"  enabled="false" emptyText="请选择"    showNullItem="false"  />
			  </td>
			</tr>
			<tr id="payInfo" >
			  <td colspan="1" width="15%" class="form_label" align="right">缴款面值(万元):</td>
			  <td colspan="1">
			  	<input class="nui-textbox" id="payFaceValue"  width="90%" name="applyInst.enPayFaceValue" readonly="readonly" enabled="false"/>  
			  </td>
			  <td width="15%" align="right"> 发行价格(元):</td>
			  <td width="35%">
			  	<input class="nui-textbox"  width="90%" name="applyInst.enBallotPrice" id="enBallotPrice" readonly="readonly" enabled="false"/>
			  </td>
		    </tr>
		    
		    <tr id="payInfo1" >
			  <td colspan="1" width="15%" class="form_label" align="right"> 缴款金额(万元):</td>
			  <td colspan="1">
			  	<input class="nui-textbox"  width="90%" id="paymentMoney" name="applyInst.enPaymentMoney" readonly="readonly" enabled="false"/>
			  </td>
			  <td width="15%" align="right">票面利率(%):</td>
			  <td width="35%">
			  	<input class="nui-textbox"  width="90%" name="applyInst.enCouponRate" id="enCouponRate"  readonly="readonly"  enabled="false"/>
			  </td>
		    </tr>
		    <tr>
			  <td colspan="1" class="form_label" align="right">
				投标截止日期:
			  </td>
			  <td colspan="3">
			  	<!-- 日期和时间分开显示 -->
			     <input style="width: 98px;"  id="dBidLimitDate"  readonly="readonly"  inputStyle="background-color:#f0f0f0;"  onvaluechanged="onTimeValueChanged"  class="mini-datepicker" showTodayButton="true" format="yyyy-MM-dd"  />
			      <!--<input style="width: 62px;" name="Time" id="dApplicationTime" onvaluechanged="onTimeValueChanged" class="mini-timespinner" format="HH:mm" required="true" />
			     -->
		         <input style="width: 40px;" url="../processUtil/timeHH.txt" class="nui-dictcombobox" readonly="readonly"  inputStyle="background-color:#f0f0f0;"  id="dBidLimitDateHH" onvaluechanged="onTimeValueChanged" />
			                 时
			     <input style="width: 40px;" url="../processUtil/timeMM.txt" class="nui-dictcombobox" readonly="readonly" inputStyle="background-color:#f0f0f0;"  id="dBidLimitDateMM" onvaluechanged="onTimeValueChanged" />
			                 分
			     <!-- 提醒的时间 -->
			     <input class="nui-hidden" type="hidden"    id="bidRemind"  />
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
				<div style="width:30%;float: right;padding-right: 10px;text-align: right;line-height: 30px;">
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
					<a class='nui-button' plain='false' iconCls="icon-save" onclick="submitUpdateReport()">
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
						//投标截止提醒时间
					    nui.get("bidRemind").setValue(returnJson.timeParam);
					    //获取投标截止时间
						var dBidLimitDate=returnJson.applyInst.dBidLimitTime;
						if(dBidLimitDate!="" && dBidLimitDate!=null){
							nui.get("dBidLimitDate").setValue(dBidLimitDate);
							//设置时间
							nui.get("dBidLimitDateHH").setValue(dBidLimitDate.getHours());
							nui.get("dBidLimitDateMM").setValue(dBidLimitDate.getMinutes());
						}
						//console.log(returnJson.applyInst.enPayFaceValue+"-++++-"+returnJson.applyInst.enPayFaceValue);
						//根据缴款面值是否有值来展示缴款信息
						/*if(returnJson.applyInst.enPayFaceValue==null || returnJson.applyInst.enPayFaceValue==""){
						  $("#payInfo").hide();
						  $("#payInfo1").hide();
						}else{
						  $("#payInfo").show();
						  $("#payInfo1").show();
						}*/
						//applyInst
						//判定是否包含ATS_FM_CZ,包含则工作项为非传真之前
						if(activityDefID.indexOf("ATS_FM_CZ")>=0 && activityDefID!="ATS_FM_CZ_TBZX"){
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
    	
    	function submitUpdateReport(){
    	    //验证投标时间
			if(onTimeValueChanged("")==false){
				return;
			}
            onOk();
    	}
		
		//提交数据
		function onOk(){
		    nui.confirm("确认提交修改？","系统提示",function(action){
		    if(action == "ok"){
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
			
			//额外校验报价不允许改为空值
			for(var i=0;i<applyInstReport.length;i++){
				if(applyInstReport[i].enOffer=="" || applyInstReport[i].enOffer==null || applyInstReport[i].enOffer<=0){
					nui.alert("报价必须为大于0的数字！");
					return;
				}
			}
			
			
			
			var vcComments=nui.get("vcComments").getValue();
			var prcaprvinfo={vcComments:vcComments==""?"修改报量信息":vcComments}; //审批信息
			//vcInvestCount;//最大报量 --投标金额     vcInterestRate;//最大报价   --投标利率
			
			var applyInst={cReportType:nui.get("reportType").getValue()};
			//获取投标金额和投标利率
			applyInst=getReportBidInfo(applyInstReport,applyInst);
			//流程实例相关信息
			var workitme={processInstID:processInstID,activityInstID:activityInstID,activityDefID:activityDefID,workItemID:workItemID};
			
			 //序列化成JSON addReposts
			var json = mini.encode({addReposts:applyInstReport,
			bizId:bizId,prcaprvinfo:prcaprvinfo,workitme:workitme,applyInst:applyInst}); 
			//console.log(json);
			form.loading();//加载遮罩
			//提交
			nui.ajax({
			    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.updateReport.biz.ext",
			    type: "post",
			    data: json,
			    dataType:"json",
			    success: function (text) {
			    	form.unmask();//取消遮罩
			    	/*
			    	*-1、系统异常
					-2、流程已结束
					-3、中标确认无需发起子流程
					1、投顾复核前，主流程处理
					2、投顾复核到中标确认间 修改报量子流程处理（子流程1）
					3、中标确认时中标修改报量子流程（子流程2）
					4、中标确认后不允许修改
					5、流程在自动审批中
					6、当前工作项不可用
					*/
					if(text.ret==4 ||  text.ret==3 || text.ret==-2){
			    		nui.alert("当前流程已经不在中标确认环节，请确认！！");
			    	}else if(text.ret==1  || text.ret==2){
			    		
			    		var workitme = text.newWorkItem;
			    	    var userId='<%=userId %>';  //数字ID
			    		if(text.checkStatus=="1"){
			    			nui.confirm("修改成功，是否前往复核？","系统提示",function(act){
		    					if(act=="ok"){
		    						var actionUrl = "/com.cjhxfund.ats.fm.instr.FirstGradeBond.flow";
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
			    		nui.alert("节点已被扭转，请关闭页面后重新打开！");
			    	}else{
			    		nui.alert("提交失败，请联系管理员！");
			    	}
			    	  
			    }
			});
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
	//投标截止日期处理
		function onTimeValueChanged(e){
			//debugger;
			//获取日期和时间
			var dApplicationDate=nui.get("dBidLimitDate").getValue().substr(0,10);
			var dApplicationHH=nui.get("dBidLimitDateHH").getValue();
			var dApplicationMM=nui.get("dBidLimitDateMM").getValue();
			
			var dApplicationTime1=dApplicationHH+":"+dApplicationMM+":00";
			//转换为毫秒数
			var startdata=dApplicationDate+" "+dApplicationTime1;
			//注意 new date(); IE8以下 不兼容，必须将 “-” 转换  “/”
			startTime=Date.parse(new Date(startdata.replace(/-/g,"/")));
			//获取的当前时间毫秒数 .getTime() 和  Date.parse（） 作用一样
			var myDate = (new Date()).getTime();
			var bidRemind=nui.get("bidRemind").getValue();
			bidRemind=(bidRemind==""||bidRemind==null)?60:bidRemind;
			var tempTime=startTime-myDate;
			if(tempTime<=0){
				//提交校验
				if(e==""){
					nui.confirm("当前时间已过投标截止时间:"+startdata+"，是否继续提交？","修改报价提醒",function(act){
						if(act=="ok"){
							onOk();
						}
					});
					return false;
				}else{
					//改变事件校验
					nui.alert("当前时间已过投标截止时间:"+startdata+"，请确认！");
					return false;
				}
			}
			if(tempTime<=(bidRemind*60000)){
				//提交校验
				if(e==""){
					nui.confirm("距离截标时间已不足： "+bidRemind+" 分钟，存在投标修改失败的风险，请知悉风险并确认是否需要继续提交？","修改报价提醒",function(act){
						if(act=="ok"){
							onOk();
						}
					});
					return false;
				}else{
					//改变事件校验
					nui.alert("距离截标时间已不足： "+bidRemind+" 分钟，存在投标修改失败的风险，请知悉风险并确认！");
					return false;
				}
			}
			return true;
			
		}
    </script>
</body>
</html>