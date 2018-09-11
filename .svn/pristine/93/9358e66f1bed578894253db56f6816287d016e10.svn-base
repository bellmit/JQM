<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 创金合信
  - Date: 2016-09-08 15:58:02
  - Description:
-->
<head>
<title>手工添加业务</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
</head>
<body>
	<div>
		<div id="form_add_biz" class="nui-form" align="center">
			<table border="0" cellpadding="1" align="center" cellspacing="1" style="width:100%;table-layout:fixed;padding-top:5px">
				<tr>
					<td style="text-align:right;width:90px">
		            	<label style="color: red">*</label>
		            	<label>产品名称:</label>
	            	</td>
	            	<td>
			            <div name="vcProductCode" class="nui-combobox" pinyinField="vcProductCode" id="vcProductCode"
				             textField="vcProductName" valueField="vcProductCode"
				             searchField="productCode"
				             url="com.cjhxfund.ats.sm.comm.FundSetmtTraceManager.addBizPermission.biz.ext"
				             showNullItem="false"
				             allowInput="true"
				             emptyText="产品代码或产品名称..."
				             nullItemText="产品代码或产品名称..."
				             valueFromSelect="true"
				             showClose="true"
				             oncloseclick="onCloseClick"
				             style="width:180px"
				             onvaluechanged="selectFunds"
				             required="true"
				             popupWidth="300px">
				            <div property="columns">
				                <div header="产品代码" field="vcProductCode" width="40px"></div>
				                <div header="产品名称" field="vcProductName"></div>
				            </div>
				        </div>
		        	</td>
        			<td style="text-align:right;width:90px">
						<label style="color: red">*</label>  
						<label>资产单元:</label>
					</td>
	            	<td>
						<input name="vcAssetCode" class="nui-combobox" id="vcAssetCode"
				               textField="TEXT" valueField="ID"
				               dataField="data"
		                   	   showNullItem="false"
		                   	   allowInput="false"
		                       required="true"
		                       emptyText="请选择..."
		                       nullItemText="请选择..."
		                       valueFromSelect="true"
		                       showClose="true"
				               oncloseclick="onCloseClick"
		                       style="width:180px"/>
					</td>
					<td style="text-align:right;width:90px">
						<label style="color: red">*</label>
						<label>证券代码:</label>
					</td>
	            	<td>
						<div name="vcStockCode" class="mini-autocomplete" id="vcStockCode"
			                textField="stockCode" 
			                valueField="stockName"
			                searchField="stockCode"
			                url="com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.queryBondCode.biz.ext"
			                popupEmptyText="全部"
			                nullItemText="全部"
			                loadingText="加载中"
			                valueFromSelect="false"
			                dataField="bondList"
			                multiSelect="false"
			                showClose="true"
			                required="true"
			                style="width:180px"
			                oncloseclick="onCloseClick"
			                popupWidth="300px"/>
			            	<div property="columns">
			                	<div header="债券代码" field="stockCode" width="40px"></div>
			                	<div header="债券名称" field="stockName"></div>
			            	</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="text-align:right;width:90px">
						<label style="color: red">*</label>
						<label>业务类别:</label>
					</td>
	            	<td>
            			<input name="vcBizType" class="nui-dictcombobox" id="vcBizType" 
							valueField="dictID"
							textField="dictName" 
							data="[{'dictID':'1','dictName':'银行间现券买卖'},{'dictID':'5','dictName':'银行间质押式回购'},{'dictID':'6','dictName':'银行间买断式回购'}]"
							required="true"
			            	allowInput="false" 
			            	showNullItem="true" 
			            	emptyText="请选择..." 
			            	nullItemText="请选择..." 
			            	showClose="true" 
			            	oncloseclick="onCloseClick" 
			            	style="width:180px;"/>
					</td>
					<td style="text-align:right;width:90px">
						<label style="color: red">*</label>
						<label>委托方向:</label>
					</td>
	            	<td>
            			<input name="cEntrustDirection" class="nui-dictcombobox" id="cEntrustDirection" 
							valueField="dictID"
							textField="dictName" 
							dictTypeId="entrustDirection"
							required="true"
			            	allowInput="false" 
			            	showNullItem="true" 
			            	emptyText="请选择..." 
			            	nullItemText="请选择..." 
			            	showClose="true" 
			            	oncloseclick="onCloseClick"
			            	style="width:180px;"/>
					</td>
					<td style="text-align:right;width:90px">
						<label style="color: red">*</label>
						<label>交收金额(元): </label>
					</td>
	            	<td>
						<input id="enSetmtAmount" name="enSetmtAmount" class="nui-textbox" align="right" required="true" style="width:180px;" />
					</td>
				</tr>
				<tr>
					<td style="text-align:right;width:90px">
						<label style="color: red">*</label>
						<label>交收日期:</label>
					</td>
	            	<td>
						<input id="lSetmtDate1" class="nui-datepicker" name="lSetmtDate1" style="width:180px;" format="yyyy-MM-dd" align="right" valueType="String" required="true" allowInput="false" showClose="true" oncloseclick="onCloseClick"/>
					</td>
					<td style="text-align:right;width:90px">
						<label>交易日期:</label>
					</td>
	            	<td>
						<input id="lDealDate1" class="nui-datepicker" name="lDealDate1" style="width:180px;" align="right" format="yyyy-MM-dd" align="right" valueType="String" allowInput="false" showClose="true" oncloseclick="onCloseClick"/>
					</td>
					<td style="text-align:right;width:90px">
						<label>成交金额(元):</label>
					</td>
	            	<td>
						<input id="enDealAmount" class="nui-textbox" name="enDealAmount"  align="right" style="width:180px;" />
					</td>
				</tr>
				<tr>
					<!-- 
					<td style="text-align:right;width:90px">
						<label>成交数量:</label>
					</td>
	            	<td>
						<input id="lDealQuantity" class="nui-textbox" name="lDealQuantity" align="right" style="width:180px;"/>
					</td>
					 -->
					<td style="text-align:right;width:90px">
						<label>成交编号: </label>
					</td>
	            	<td>
						<input id="vcDealNo" name="vcDealNo" class="nui-textbox" align="right"  style="width:180px;" />
					</td>
					<td style="text-align:right;width:90px">
						<label>交易对手: </label>
					</td>
					<td>
						<div name="vcCounterpartyId" class="mini-autocomplete" id="vcCounterpartyId"
			                 textField="vcName"
			                 valueField="vcRivalCode"
			                 searchField="vcPinyin"
			                 url="com.cjhxfund.ats.sm.comm.TraderivalManager.QueryTraderByPinyin.biz.ext"
			                 popupEmptyText="全部"
			                 nullItemText="全部"
			                 loadingText="加载中"
			                 valueFromSelect="true"
			                 dataField="traders"
			                 multiSelect="false"
			                 showClose="true"
			                 oncloseclick="onCloseClick"
			                 style="width:180px;"
			                 popupWidth="300">
			                <div property="columns">
			                    <div header="对手代码" field="vcRivalCode" width="20"></div>
			                    <div header="对手名称" field="vcName"></div>
			                </div>
            			</div>
					</td>
					<td style="text-align:right;width:90px">
						<label>指令/建议序号:</label>
					</td>
	            	<td>
						<input id="lResultNo" name="lResultNo" class="nui-textbox" style="width:180px;" align="right" onvaluechanged="relatedInstructInfo"/>
					</td>
				</tr>
			</table>
			<div>
				<label>备注: </label>
				<input class="nui-textbox" name="vcRemark" style="width:85%"/>
			</div>
			<div>
				<input id="lDealDate" class="nui-hidden" name="lDealDate" />
				<input id="lSetmtDate" class="nui-hidden" name="lSetmtDate" />
				<input id="cBusinClass" class="nui-hidden" name="cBusinClass" />
				<input id="cCancelFlag" class="nui-hidden" name="cCancelFlag" />
				<input id="vcDataSource" class="nui-hidden" name="vcDataSource" />
				<input id="vcCounterpartyName" class="nui-hidden" name="vcCounterpartyName" />
				<input id="lAssetId" class="nui-hidden" name="lAssetId" />
				<input id="lProductId" class="nui-hidden" name="lProductId" />
				<input id="vcProductName" class="nui-hidden" name="vcProductName" />
				<input id="vcAssetName" class="nui-hidden" name="vcAssetName" />
				<input id="vcStockName" class="nui-hidden" name="vcStockName" />
				<input id="vcBusinCaption" class="nui-hidden" name="vcBusinCaption" />
				<input id="vcMarket" class="nui-hidden" name="vcMarket" />
			</div>
		</div>
	</div>
	<div style="text-align: center; padding-top:10px">
		<a class="mini-button" iconCls="icon-ok" onclick="saveData()" style="width: 60px; margin-right: 20px;">确定</a>
		<a class="mini-button" iconCls="icon-cancel" onclick="cancel()" style="width: 60px;">取消</a>
	</div>
	<script type="text/javascript">
		nui.parse();
		//进入页面加载
		window.onload=function(){
			//初始化页面
			initForm();
		};
		//联动带出指令/建议信息
		function relatedInstructInfo(e){
			debugger;
			var form = new nui.Form("#form_add_biz");
			var jsonData = form.getData(false, false);
			nui.ajax({
			  	url:"com.cjhxfund.ats.sm.comm.FundSetmtTraceManager.validInstructStatus.biz.ext",
	 		  	type:'POST',
	    	  	data:{fundSetmtTrace:jsonData},
	    	 	cache:false,
	    	 	contentType:'text/json',
		    	success:function(data){
		    		var rtnData = data.rtnCode;
		    		if(rtnData.length>0){
		    			if(rtnData[0]=='5' || rtnData[0] =='6' || rtnData[0] == '7'){
		    				nui.ajax({
								url : "com.cjhxfund.ats.sm.comm.FundSetmtTraceManager.checkInstructNo.biz.ext",
								type : 'POST',
								data : {fundSetmtTrace:jsonData},
								contentType : 'text/json',
								success : function(data) {
									var instructInfos = data.instructInfos;
									if(instructInfos.length>0){
										var instructInfo = instructInfos[0];
										if(instructInfo!=null){
											var bizForm = new nui.Form("#form_add_biz");
											var returnData=nui.decode(instructInfo);
											bizForm.setData(returnData);
											nui.get("vcStockCode").setValue(instructInfo.vcStockName);
											nui.get("vcStockCode").setText(instructInfo.vcStockCode);
											nui.get("vcAssetCode").setValue(instructInfo.vcAssetCode);
											nui.get("vcAssetCode").setText(instructInfo.vcAssetName);	
											//初始化页面
											initForm();
										}
									}
								}
							});
			    		}else{
			    			nui.alert("该指令/建议状态不允许成交匹配！");
			    			nui.get("lResultNo").setValue(null);
			    		}
		    		}else{
		    			nui.alert("指令/建议序号不存在！");
						//初始化页面
						initForm();
		    		}
		    	}
			});
		}
		//保存业务
		function saveData(){
			var form = new nui.Form("#form_add_biz");
			form.validate();
    		if(form.isValid()==false) return;
    		var entrustDirection = nui.get("cEntrustDirection").getValue();
    		var bizType = nui.get("vcBizType").getValue();
    		
			nui.get("lDealDate").setValue(DateUtil.toNumStr(nui.get("lDealDate1").getValue()));
    		nui.get("lSetmtDate").setValue(DateUtil.toNumStr(nui.get("lSetmtDate1").getValue()));
    		nui.get("vcDataSource").setValue("手工添加");
    		nui.get("cCancelFlag").setValue("0");
    		nui.get("vcAssetName").setValue(nui.get("vcAssetCode").text);
    		nui.get("vcProductName").setValue(nui.get("vcProductCode").text);
    		nui.get("vcStockName").setValue(nui.get("vcStockCode").value);
    		nui.get("vcStockCode").setValue(nui.get("vcStockCode").text);
    		nui.get("vcCounterpartyName").setValue(nui.get("vcCounterpartyId").text);
    		//处理业务类型(cBusinClass)
    		nui.get("cBusinClass").setValue(getCBusinClass(bizType));
    		//处理交易市场
    		nui.get("vcMarket").setValue(getVcMarket(bizType));
    		
        	var jsonData = form.getData(false,true);
        	nui.ajax({
	            url:"com.cjhxfund.ats.sm.comm.FundSetmtTraceManager.saveBizManually.biz.ext",
	            type:'POST',
	            data:{fundSetmtTrace:jsonData},
	            cache:false,
	            contentType:'text/json',
	            success:function(text){
		            var returnJson = nui.decode(text);
		            if(returnJson.rtnCode == "0"){
		                nui.alert("保存成功", "系统提示", function(action){
	                		CloseWindow("saveSuccess");
						});
		            }else{
		                nui.alert("保存失败", "系统提示", function(action){
		                    /* if(action == "ok" || action == "close"){
		                        CloseWindow("saveFailed");
		                    } */
	                	});
	            	}
	        	}
			});
		}
		
		//取消
		function cancel() {
			window.CloseOwnerWindow();
		}
		//关闭窗口
		function CloseWindow(action) {
	    if (action == "close" && form.isChanged()) {
	        if (confirm("数据被修改了，是否先保存？")) {
	            saveData();
	        }
	    }
	    if (window.CloseOwnerWindow)
	    return window.CloseOwnerWindow(action);
	    else window.close();
		}
		//页面X的删除功能
		function onCloseClick(e) {
	    	var obj = e.sender;
		    obj.setText(null);
		    obj.setValue(null);
		    obj.setIsValid(false);
      	    obj.doValueChanged();
		}
		//产品联动带出资产单元方法
		function selectFunds(e){
	 		var fundCodeCombo = nui.get("vcProductCode").value;
			var vcAssetCombo = nui.get("vcAssetCode");
			if(fundCodeCombo!=null && fundCodeCombo!=""){
				nui.ajax({
		    		data:{vcProductCode:fundCodeCombo},
		    		url:"com.cjhxfund.ats.sm.comm.FundSetmtTraceManager.queryAssetInfo.biz.ext?queryType=1",
		    		success:function(resp){
		    			var returnJson = nui.decode(resp);
						if(returnJson.exception == null){
		             		if(resp.data){
	                			vcAssetCombo.load(resp.data);
	                			if(typeof e === "object"){
	                				vcAssetCombo.select(0);
	                			}else{
	                				vcAssetCombo.setValue(e);
	                			}
	             	 		}
						}else{
							nui.alert("系统异常","系统提示");
						}
		        	},
			        //有错误码之后，把后面的错误提醒补齐。
			        fail:function(resp){
			            alert(resp);
			        }
	    		});
			}else{
				vcAssetCombo.setValue(e);
			}	
		};
		//初始化页面
		function initForm(){
			//默认设置交易日期和交收日期为当天
			var today = DateUtil.toNumStr(new Date());
			nui.get("lDealDate1").setValue(today);
			nui.get("lSetmtDate1").setValue(today);
			//业务类别初始化
			$("#vcMarket > span > input").attr("placeholder","请选择...");
			$("#vcAssetCode > span > input").attr("placeholder","请选择...");
			$("#vcStockCode > span > input").attr("placeholder","请输入...");
			$("#vcCounterpartyId > span > input").attr("placeholder","对手编号或拼音...");
			$("#lResultNo > span > input").attr("placeholder","输入指令/建议序号带出指令/建议信息...");
			$("#vcDealNo > span > input").attr("placeholder","有成交编号的交易请务必填写...");
		}
		//处理业务类型(cBusinClass)
		function getCBusinClass(vcBizType){
			var cBusinClass = null;
			if(vcBizType == "1" || vcBizType == "5"){
				//银行间二级交易、银行间质押式回购
				cBusinClass = "2";
			}else if(vcBizType == "6"){
				//银行间买断式回购
				cBusinClass = "O";
			}else if(vcBizType == "2"){
				//上海大宗交易
				cBusinClass = "E";
			}else if(vcBizType == "3"){
				//上海固收平台
				cBusinClass = "I";
			}else if(vcBizType == "4"){
				//深圳综合协议平台
				cBusinClass = "E";
			}else if(vcBizType == "7"){
				//交易所协议式回购
				cBusinClass = "I";
			}
			return cBusinClass;
		}
		//处理交易市场
		function getVcMarket(vcBizType){
			var vcMarket = null;
			if(vcBizType == "1" || vcBizType == "5" || vcBizType == "6"){
				//银行间
				vcMarket = "5";
			}else if(vcBizType == "2" || vcBizType == "3" || vcBizType == "7"){
				//上交所A
				vcMarket = "1";
			}else if(vcBizType == "4"){
				//深交所A
				vcMarket = "2";
			}else{
				//场外
				vcMarket = "6";
			}
			return vcMarket;
		}
	</script>
</body>
</html>