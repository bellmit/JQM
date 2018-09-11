<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): zhangyao
  - Date: 2016-12-06 16:13:30
  - Description:
-->
<head>
	<title>新股联络人制作指令单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="css/offeringStyle.css"/>
    <style>
    	.info_name{
    		width:145px;
    	}
    	
    	/*隐藏分页栏*/
    	.mini-grid-pager{
    		display:none !important;
    	}
    	.mini-listbox-border{
    		margin:0 !important;
    	}
    </style>
</head>
<%
    String processInstID = request.getParameter("processInstID");
	String workItemID = request.getParameter("workItemID");
	String vcExchangeNo=request.getParameter("vcExchangeNo");
	String vcType=request.getParameter("vcType");
 %>
<body>
<div id="tabs" class="nui-tabs" height="100%">
	<div title="新股联络人" class="content">
        <div class="main">
            <!--表单-->
            <form id="form1" method="post" >
            	<input name="processInstID" id="processInstID" class="nui-hidden" value="<%=processInstID %>"/>
            	<input name="workItemID" id="workItemID" class="nui-hidden" value="<%=workItemID %>"/>
            	<input id="vcExchangeNo" name="vcExchangeNo" class="nui-hidden" value="<%=vcExchangeNo %>" />
            	<input id="lInstructNo" name="ipoInstructInfo.lInstructNo" class="nui-hidden" />
            	<input id="vcType" name="vcType" class="nui-hidden" value="<%=vcType %>"/>
            	<!-- 发行人 -->
			    <ul class="form_list_name">
			        <li>
			            <span>发行人 &nbsp;: &nbsp;</span>
			   			<input name="ipoInstructInfo.vcIssuerName" class="nui-textbox input_width" readonly="true"/>
			        </li>
			        <li>
			            <span>主承销商 :</span>
			            <input name="ipoInstructInfo.vcLeadUnderwriterName" class="nui-textbox input_width" readonly="true"/>
			        </li>
		         </ul>
		    	<fieldset class="fieldset">
		    		<legend>&nbsp;&nbsp;基本信息 &nbsp;&nbsp;</legend>
		            <ul class="form_list">
		                <li>
		                    <span class="info_name">公司名称 :</span>
		   					<input name="ipoInstructInfo.vcCompanyName" class="nui-textbox" readonly="true"/>
			            </li>
			            <li>
			                <span class="info_name">申购代码 :</span>
			                <input id="vcIssuerNo" name="ipoInstructInfo.vcPurchaseCode" class="nui-textbox" readonly="true"/>
			            </li>
			            <li>
			                <span class="info_name">申购建议价格(元)<em>*</em> :</span>
			                <input  id="price" name="ipoInstructInfo.enSuggestPrice" class="nui-textbox" vtype="float;min:0;" onvalidation="onNumberValidation" emptyText="请输入申购建议价格" required="true"/>
			            </li>
			            <li>
			                <span class="info_name">发行数量(万股) :</span>
			                <input name="ipoInstructInfo.enIssueNumber" class="nui-textbox" readonly="true"/>
			            </li>
			            <li>
			                <span class="info_name">发行后总股本(万股) :</span>
			                <input id="enTotalEquity" name="ipoInstructInfo.enTotalEquity" class="nui-textbox" readonly="true"/>
			            </li>
			            <li>
				            <span class="info_name">网下发行上限(万股) :</span>
				            <input name="ipoInstructInfo.enOfflineIssueUpperNumber" class="nui-textbox" readonly="true"/>
				        </li>
			            <li>
			                <span class="info_name">网下申购上限(万股) :</span>
			                <input name="ipoInstructInfo.enOfflineUpperNumber" id="uplimit" class="nui-textbox" readonly="true"/>
			            </li>
			            <li>
			                <span class="info_name">网下申购下限(万股) :</span>
			                <input name="ipoInstructInfo.enOfflineUnderNumber" id="buyfloor" class="nui-textbox" readonly="true"/>
			            </li>
			            <li>
			                <span class="info_name">网下申购规模(万元) :</span>
			                <input name="ipoInstructInfo.enPurchaseScale" id="scale" class="nui-textbox prohibit_input"  readonly="true"/>
			            </li>
			            <li>
			                <span class="info_name">申购步长  :</span>
			                <input name="ipoInstructInfo.enPurchaseSize" id="step" class="nui-textbox" readonly="true"/>
			            </li>
			            <li>
			                <span class="info_name">询价日 :</span>
			                <input id="lInquiryDate" name="ipoInstructInfo.lInquiryDate" class="nui-textbox" readonly="true"/>
			            </li>
			            <li>
			                <span class="info_name">网下申购日 :</span>
			                <input id="lOfflinePurchaseDate" name="ipoInstructInfo.lOfflinePurchaseDate" class="nui-textbox"/>
			            </li>
			            <li>
			                <span class="info_name">市值门槛(万元) :</span>
			                <input name="ipoInstructInfo.enMarketValueThreshold" class="nui-textbox" readonly="true"/>
			            </li>
		        	</ul>
		    	</fieldset>
		    	<!--定价信息-->
	            <fieldset class="fieldset">
            		<legend>&nbsp;&nbsp;定价信息 &nbsp;&nbsp;</legend>
            		<ul class="form_list">
	                    <li>
	                        <span class="info_name">预计获配率 (%)<em>*</em>:</span>
	       					<input id="lPredictDistributionRate" name="ipoInstructInfo.enPredictDistributionRate" class="nui-textbox" vtype="float;range:0,100;" onvalidation="onNumberValidation" emptyText="请输入预计获配率" required="true"/>
	                    </li>
	                    
	                    <li>
	                        <span class="info_name_type">行业类别 :</span>
	                        <input name="ipoInstructInfo.vcWindIndustryType" class="nui-textbox input_width" readonly="true"/>
	                    </li>
	                </ul>
            	</fieldset>
            	<!--合规风控-->
	            <fieldset class="fieldset">
            		<legend>&nbsp;&nbsp;合规风控 &nbsp;&nbsp;</legend>
            		<ul class="form_list">
	                    <li>
	                        <span class="info_name">合计申购股数（万股）:</span>
	       					<input name="ipoInstructInfo.enTotalPurchaseSize" id="stocknumber" class="nui-textbox prohibit_input" onvaluechanged="countStockratio(this.value)"/>
	                    </li>
	                    <li>
	                        <span class="info_name">发行人总股本（万股）:</span>
	                        <input  id="stockAll"   class="nui-textbox" readonly="true"/>
	                    </li>
	                    <li>
	                        <span class="info_name">申购量占总股本比例(%) :</span>
	                        <input name="ipoInstructInfo.enTotalPurchaseRate" id="stockratio" class="nui-textbox prohibit_input" readonly="true"/>
	                    </li>
	                    <li>
	                        <span class="info_name" style="width:200px;">获配数量占发行人总股本比例(%) :</span>
	                        <input name="ipoInstructInfo.enTotalIssuerRate" id="quantitystockratio" class="nui-textbox prohibit_input" readonly="true"/>
	                    </li>
	                </ul>
            	</fieldset>
            </form>	
        	<!--操作按钮-->
			<div style="width:100%;">
		        <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
		            <table style="width:100%;background:#DBE3F2;">
		                <tr>
		                    <td>
					            <a id="button1" class='nui-button' plain='false' iconCls="icon-cancel" onclick="removeRow()" plain="false">删除</a> 
					            <span class="separator"></span>
		                        <a id="button2" class='nui-button' plain='false' iconCls="icon-undo" onclick="undo()" plain="false">恢复</a>      
					            <span class="separator"></span>
		                        <a id="button3" class='nui-button' plain='false' iconCls="icon-reload" onclick="reCalculate()" plain="false">重新计算</a>      
		                    </td>
		                    <td  style="float:right;margin-right:10px;">
		                    	<span style="color:#626262;">已删除:<strong class="strong" style="background:#FF6666;"></strong></span>
		                    	<span style="color:#626262;">不合规:<strong class="strong" style="background:#00B2EE;"></strong></span>
		                    </td>
		                </tr>
		            </table>           
		        </div>
		    </div>
			<!--撑满页面-->
			<div class="nui-fit" > 
	            <!--表格-->
			    <div id="datagrid1" 
			    	 class="nui-datagrid" 
			    	 style="width:100%;height:100%;" 
			         url="com.cjhxfund.ats.ipo.busOpr.queryPurchaseValue2.biz.ext" 
			         idField="L_PRODUCT_NO"
			         dataField="purchaseInfo"
			         allowResize="true"  
			         allowCellEdit="true" 
			         allowCellSelect="true" 
			         multiSelect="true" 
			         editNextOnEnterKey="true" 
			         onselectionChanged="selectionChanged" >
			         <!-- hidden域 -->
				     <input class="nui-hidden" id="lRaiseInstFile" name="debtIssue.lRaiseInstFile"/>
			         
			      	<div property="columns">
			            <div type="indexcolumn">序号</div>
			            <div type="checkcolumn"></div>
			            <div field="prodName" width="160" headerAlign="center" align="center">参与组合</div>
			            <div field="vcRationProductType" dataType="currency" width="100" align="center" headerAlign="center" renderer="rendervcRationProductType">产品类型</div>                
			            <div field="enPurchasePrice" width="60" headerAlign="center" align="center">申报价格</div>                
			            
			            <div field="enPurchaseNumber" vtype="float"  width="80" headerAlign="center">申购数量<br>（万股）
			            	<input property="editor" class="nui-textbox" style="width:100%;" />
			            </div>
			            <div field="enPurchaseNumber" width="80" headerAlign="center">申购数量<br>（万股）</div>
			            
			            <div field="enPurchaseMoney" dataType="currency" width="80" headerAlign="center">申购金额<br>（万元）</div>
			            <div field="assetValue" dataType="currency" width="80" headerAlign="center">基金总资产</div>  
			            <div field="assetNetValue" dataType="currency" width="80" headerAlign="center">基金净资产</div>
			            
			              
			            <div field="enPurchaseMoneyRate" width="80" headerAlign="center">申购金额占<br>净值比例</div>
			            <div field="enDistributionRate" width="80" headerAlign="center">预计获配占<br>净值比例</div>
			            
			            <div field="lLockTime" type="comboboxcolumn" autoShowPopup="true" name="lLockTime" width="50" align="center" headerAlign="center">锁定期
			                <input property="editor" class="nui-combobox" style="width:100%;" data="allottedTime" />                
			            </div>
			            
			            <!-- <div field="lEndTime" width="100" headerAlign="center" align="center" dateFormat="yyyy-MM-dd">完成时间</div> -->
			            <div field="marketValueSz" dataType="currency" width="100" headerAlign="center" allowSort="true">深市对应新股所在<br>市场的日均市值</div>
			            <div field="marketValueSh" dataType="currency" width="100" headerAlign="center" allowSort="true">沪市对应新股所在<br>市场的日均市值</div>
			            <div field="vcRationProductCode" width="100"  align="center" headerAlign="center">深交所配售对象编码</div> 
						<div field="vcAssociationCode" width="100" align="center" headerAlign="center">上交所协会编码</div>
						<div field="vcComplianceState" width="100" align="center"  renderer="vcComplianceState" headerAlign="center">不合规</div>
			            
			            <div name="vcComplianceRemark" field="vcComplianceRemark" width="150" headerAlign="center">备注
			                <input property="editor" class="nui-textbox" style="width:100%;"/>                
			            </div>
			        </div>
			    </div>
			</div>
		</div>
	</div>
	<div title="审批内容" name="index">
		<%@include file="/ipo/task/processControl.jsp" %>
		<script type="text/javascript">
			$("#vcOperateType").attr("data","[{id: 1, text: '同意'}]");
		</script>
	</div>
	<div title="流程信息" url="/ats/sm/comm/task/processGraph.jsp?processInstID=<%=processInstID %>" ></div>	
</div>
    <script type="text/javascript" src="js/loadInfo.js"></script>
    <script type="text/javascript" src="js/count.js"></script>
	<script type="text/javascript">
		var allottedTime = [{ id: 0, text: '0' }, { id: 12, text: '12'}];
    	var grid = nui.get("datagrid1");
    	//var data1 = {processInstID:processInstID};
       // grid.load(data1);
        //设置已办详情入口申购数量不可修改
        (function (){
	    	var vcType=nui.get("vcType").getValue();
	    	if(vcType=="null"){//null:待办执行入口;finish:已办详情入口
    			grid.hideColumn(6);
	    	}else{
	    		grid.hideColumn(5);
	    	}
	    })();
        
        
        function vcComplianceState(e){
        	var vcComplianceState = e.row.vcComplianceState;
        	if(vcComplianceState == "01"){
        		return e.row.vcComplianceState1;
        	} 
        	if(vcComplianceState == "02"){
        		return e.row.vcComplianceState2;
        	} 
        }
		//判断深市or沪市
		(function (){
			var vcExchangeNo=nui.get("vcExchangeNo").value;
			if(vcExchangeNo=="04"){//03:沪市;04:深市
				grid.hideColumn (14);
				grid.hideColumn (16);
			}else{
				grid.hideColumn (13);
				grid.hideColumn (15);
			}
		})();
        //删除行
        function removeRow(){
			var lInstructNo=nui.get("lInstructNo").value;
			var rows = grid.getSelecteds();
			for(var i=0;i<rows.length;i++){
				if(rows[i].vcComplianceRemark==null){
					nui.alert("请备注删除原因","系统提示",function(){
						grid.setCurrentCell([rows[i],"vcComplianceRemark"]);
						grid.beginEditCell();
					});
					return;
				}
			}
			var data={productJoin:rows,lInstructNo:lInstructNo,joinType:"02",updateFlag:"0040"};
			var json=nui.encode(data);
			if(rows.length>0){
				nui.ajax({
			        url: "com.cjhxfund.ats.ipo.busOpr.addJoinInfo.biz.ext",
			        type: "post",
			        data: json,
			        contentType:'text/json',
			        success: function (text) {
			        	var returnJson = nui.decode(text);
			        	if(returnJson.exception == null){
			        		grid.reload();
			        		nui.alert("删除成功","系统提示",function(){
			        			//计算合计申购股数
								stockNumberAll();
								//计算申购量占总股本比例
								countStockratio();
								//计算获配数量占发行人总股本比例
								countQuantitystockratio();
			        		});
			        	}
			        },
		    	});
		    }else{
		    	nui.alert("请选择一行数据","系统提示");
		    }
		}
         //恢复
	    function undo(){
			var lInstructNo=nui.get("lInstructNo").value;
			var rows = grid.getSelecteds();
			for(var i=0;i<rows.length;i++){
				if(rows[i].vcComplianceRemark==null){
					nui.alert("请备注恢复原因","系统提示",function(){
						grid.setCurrentCell([rows[i],"vcComplianceRemark"]);
						grid.beginEditCell();
					});
					return;
				}
			}
			var data={productJoin:rows,lInstructNo:lInstructNo,operatorType:"0",updateFlag:"0040"};
			var json=nui.encode(data);
			if(rows.length>0){
				nui.ajax({
			        url: "com.cjhxfund.ats.ipo.busOpr.updateRemark.biz.ext",
			        type: "post",
			        data: json,
			        async: false,
			        contentType:'text/json',
			        success: function (text) {
			        	var returnJson = nui.decode(text);
			        	if(returnJson.exception == null){
			        		grid.reload();
			        		nui.alert("恢复成功","系统提示",function(){
			        			//计算合计申购股数
								stockNumberAll();
								//计算申购量占总股本比例
								countStockratio();
								//计算获配数量占发行人总股本比例
								countQuantitystockratio();
			        		});
			        		
			        	}
			        }
		    	});
		    }else{
		    	nui.alert("请选择一行数据","系统提示");
		    }
		} 
        
        function reCalculate(){
        	var lInstructNo=nui.get("lInstructNo").value;
        	var data={lInstructNo:lInstructNo};
        	var json=nui.encode(data);
			nui.ajax({
				url: "com.cjhxfund.ats.ipo.busOpr.updateInstructStatus.biz.ext",
			    type: "post",
			    data: json,
			    async: false,
			    contentType:'text/json',
			    success: function (text) {
			     	var returnJson = nui.decode(text);
			       	if(returnJson.exception == null){
			       		grid.reload();
			       		nui.alert("刷洗成功","系统提示",function(){
			        			//计算合计申购股数
								stockNumberAll();
								//计算申购量占总股本比例
								countStockratio();
								//计算获配数量占发行人总股本比例
								countQuantitystockratio();
			        	});
			       	}else{
			       		nui.alert("刷新失败！");
			       	}
			    }
		    });        	
        }
        
       //提交流程
		function processSubmit(){
			nui.get("processSubmit").disable();
			var form = new nui.Form("#form1");
			form.setChanged(false);
			form.validate();
			if (form.isValid() == false){
				nui.alert("请先输入申购建议价格与预计获配率","系统提示");
				nui.get("processSubmit").enable();
				return;
			}
			var lInquiryDate=nui.get("lInquiryDate").getValue();
			lInquiryDate=lInquiryDate+" 08:31:00";
			var date=new Date(lInquiryDate.replace(/-/g,'/'));
			if(new Date()<Date.parse(date)){
				nui.alert("请您在询价日08:30之后提交","系统提示");
				nui.get("processSubmit").enable();
				return;
			}
			nui.confirm("确认是否提交流程？","系统提示",function(action){
				if(action == "ok"){
					var processForm=new nui.Form("processForm");
					var data=processForm.getData();
					//获取指令数据信息
					var instructData=form.getData();
					//保存指令数据
					var rtnSaveCode=saveInstructModifyInfo(instructData.ipoInstructInfo);
					if(rtnSaveCode==0){
						return;
					}
					//设置工作项ID
					data["workItemID"]=workItemID;
					var approveData={approveParam:data};
					var json=nui.encode(approveData);
					nui.ajax({
				        url: "com.cjhxfund.ats.ipo.task.finishMyWork.biz.ext",
				        type: "post",
				        data: json,
				        contentType:'text/json',
				        success: function (text) {
			        		var returnJson = nui.decode(text);
				        	if(returnJson.exception == null){
				        		if(returnJson.rtnCode=="-1"){
				        			nui.alert("审批确认失败","系统提示");
				        			nui.get("processSubmit").enable();
				        		}else{
				        			nui.alert("审批确认成功","系统提示",function(){
				        				opener.location.reload();
										window.opener = null;
										window.open(' ', '_self', ' ');
										window.close();
				        			});
				        		}
				        	}else{
				        		nui.get("processSubmit").enable();
				        	}
		        		},
		        		ondestroy:function(action){
		        			nui.get("processSubmit").enable();
		        		},
		        		error:function(error){
		        			nui.get("processSubmit").enable();
		        		}
					});
				}else{
					nui.get("processSubmit").enable();
				}
			});
		}	
        
        
        //保存指令修改信息及对应的申购产品修改信息
        function saveInstructModifyInfo(instructData){
        	var rows=grid.getChanges();
        	var data={productInfo:rows,instructInst:instructData};
        	var json=nui.encode(data);
        	var resultCode=1;
        	nui.ajax({
				url: "com.cjhxfund.ats.ipo.busOpr.updateInstructPurchase.biz.ext",
				type: "post",
				data: json,
				async:false,
				contentType:'text/json',
				success: function (text) {
					var returnJson = nui.decode(text);
		      		if(returnJson.rtnCode=="-1"){
		        		resultCode=0;
		        		nui.alert("审批确认失败，是由于申购产品修改更新失败","系统提示");
		       		}
		        }
			});
			return resultCode;
        }
        //输入数字验证
		function onNumberValidation(e){
			if (e.isValid) {
                if (isNumber(e.value) == false) {
                    e.errorText = "请输入正确的数字";
                    e.isValid = false;
                }
            }
        }
        function isNumber(v){
        	var r = /^(0|[1-9]\d*)(\.\d+)?$/;
            if (r.test(v)) return true;
            return false;
        }
        //字典类型处理
		function rendervcRationProductType(e) {
			return nui.getDictText("ATS_IPO_RATION_TYPE",e.row.vcRationProductType);
		}
        grid.on("drawcell", function (e) {
		 	var record = e.record;
	        //设置行样式
	        if (record.vcProductParticipantion == "02") {//02:已删除;00:未删除
	            e.rowStyle = "background:#FF6666";
	        }else if(record.vcComplianceState=="01"||record.vcComplianceState=="02"){//不合规
	        	e.rowStyle = "background:#00B2EE";
	        }else{
	        	e.rowStyle = "background:#fff";
	        }
		});
		//列表选择发生变化时触发事件
		function selectionChanged(){
			var vcType=nui.get("vcType").getValue();
			if(vcType!="null"){
				return;
			}
			var rcds = grid.getSelecteds();
			var button1=nui.get("button1");
			var button2=nui.get("button2");
			var index = 0; 
			var len=rcds.length;
			if(rcds.length>0&&rcds[0].vcProductParticipantion=="02"){
				while((index < len)&&(rcds[index].vcProductParticipantion == "02")){ 
					index++; 
				}
				if(index == len){
					button1.disable();
					button2.enable();
				}else{
					button1.disable();
					button2.disable();
				}
			}else{
				while((index < len)&&(rcds[index].vcProductParticipantion == "00")){ 
					index++; 
				}
				if(index == len){
					button1.enable();
					button2.disable();
				}else{
					button1.disable();
					button2.disable();
				}
			}
			for(var i=0,len=rcds.length;i<len;i++){
				if(rcds[i].vcComplianceState=="01"||rcds[i].vcComplianceState=="02"){
					button1.disable();
					button2.disable();
				}
			}
			if(rcds.length==0){
				button1.enable();
				button2.enable();
			}
		} 
    </script>
    
</body>
</html>