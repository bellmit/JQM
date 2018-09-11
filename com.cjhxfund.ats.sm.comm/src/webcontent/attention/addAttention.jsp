<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 吴艳飞
  - Date: 2016-09-08 16:03:00
  - Description:
-->
<head>
<title>添加关注</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
    	$(function(){
    		 //初始化改变债券代码选择提示语句
    		$("#vcStockCode>span>input").attr("placeholder","请输入证券代码");
		})
			
    </script>
</head>
<body>
	<div style="width: 100%;">
		<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;" id="attention_condition">
			<table align="center">
				<tr>
					<td align="right" >证券代码:</td>
					<td style="white-space: nowrap;">
						<div name="vcStockCode" class="nui-autocomplete" id="vcStockCode"
	                             textField="stockCode" valueField="stockCode"
	                             searchField="stockCode"
	                             url="com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.queryBondCode.biz.ext"
	                             allowInput="true"
	                             emptyText="请选择..."
	                             nullItemText="请选择..."
	                             valueFromSelect="false"
	                             dataField="bondList"
	                             multiSelect="false"
	                             onitemclick="getExchange"
	                             popupWidth="250"
	                             style="width:90%">
	                       		<div property="columns">
	                                <div header="债券代码" field="stockCode" width="40px"></div>
	                                <div header="债券名称" field="stockName"></div>
	                        	</div>
	            		</div>
		             </td>
	            		<!-- <td><a class='nui-button' plain='false' iconCls="icon-add" onclick="addAttention()">添加关注</a></td> -->
						<!-- <a class="mini-button" onclick="search()">查询</a> -->
				</tr>
				<tr>
					<td>交易市场:</td>
		                <td>
		                	<input class="nui-dictcombobox" 
	                           id="vcMarketNo" 
	                           name="vcMarketNo"
	                           valueField="dictID" 
	                           textField="dictName" 
	                           dictTypeId="tradePlace"
	                           emptyText="全部" 
	                           showClose="true" 
	                           oncloseclick="onCloseClick" 
	                           style="width:90%"/>
						</td>
		             </td>
				</tr>
				
			</table>
		</div>
		<div style="margin-top: 180px" align="center">
			<a class='nui-button' plain='false' iconCls="icon-save" onclick="addAttention()">保存</a>
			<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="cancel()">取消</a>
		</div>
	</div>

	<script type="text/javascript">
		nui.parse();
// 		var tabAttentionInfo = new nui.Form("#attention_condition");
// 		var conditionForm = nui.get("datagrid_position_info"); 
		
		function addAttention(){
			var conditionInformation = {};
			var bondInfo = [];
			var positionInfo = null;
			var stockInfo = nui.get("vcStockCode");
			bondInfo = stockInfo.data;
// 			var conditionInformation = tabAttentionInfo.getData(false,false);
// 			var stockCode = conditionInformation.vcStockCode;
			var stockCode = nui.get("vcStockCode").getValue();
			if(!stockCode){
				if(bondInfo.length<=0){//此处为了兼容火狐浏览器不兼容情况
					nui.alert("证券代码不能为空!","提示");
					return;
				}else if(bondInfo.length = 1){
					stockCode = bondInfo[0].stockCode;
				}
			}
// 			var vcMarketNo = conditionInformation.vcMarketNo;
			var vcMarketNo = nui.get("vcMarketNo").getValue();
			if(!vcMarketNo){
				nui.alert("交易市场不能为空!","提示");
				return;
			}
			if(bondInfo.length > 0){
				for (var i = 0;i < bondInfo.length;i++){
					for (var key in bondInfo[i]) {
						if(bondInfo[i][key] == stockCode){
							positionInfo = bondInfo[i];
						}
	        		}
				}
			}
			if(isNaN(vcMarketNo)){
				if(vcMarketNo == "上交所A"){
					conditionInformation.vcMarketNo = "1";
				}else if(vcMarketNo == "深交所A"){
					conditionInformation.vcMarketNo = "2";
				}else if(vcMarketNo == "银行间"){
					conditionInformation.vcMarketNo = "5";
				}else if(vcMarketNo == "场外"){
					conditionInformation.vcMarketNo = "6";
				}
			}
			conditionInformation["vcStockCode"] = stockCode;
			conditionInformation["vcMarketNo"] = vcMarketNo;
			nui.ajax({
	            url : "com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.getAppointBondInfo.biz.ext",
				type : 'POST',
				data : {condition:conditionInformation},
				cache : false,
				contentType : 'text/json',
	            success: function (text) {
	            	var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						if(returnJson.bondBasicInfo.length <= 0){
							nui.alert("无此证券或交易市场不匹配","提示");
							return;
						}else{
							if(positionInfo == null){
								positionInfo = returnJson.bondBasicInfo[0];
								positionInfo["vcExchange"] = positionInfo.vcMarketNo;
								positionInfo["vcStockInnerCode"] = positionInfo.vcInterCode;
							}else{
								positionInfo["vcStockCode"] = positionInfo.stockCode;
								positionInfo["vcStockName"] = positionInfo.stockName;
								positionInfo["vcExchange"] = positionInfo.vcMarketNo;
							}
							attention(positionInfo);
						}
					}else{
						nui.alert("系统异常,关注失败","系统提示");
					}
	            }
	        });
		}
		function attention(positionInfo){
			nui.ajax({
	            url : "com.cjhxfund.ats.sm.comm.MyAttentionInfoManager.addAttentionBond.biz.ext",
				type : 'POST',
				data : {bondParameter:positionInfo},
				cache : false,
				contentType : 'text/json',
	            success: function (text) {
	            	var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						if(returnJson.rtnCode == "2"){
							nui.alert("此证券已关注,不能重复关注!","提示");
						}else{
							CloseOwnerWindow("ok");
						}
					}else{
						nui.alert("系统异常,关注失败","提示");
					}
	            }
	        });
		}
		function getExchange(){
			var bondInfo = [];
			var stockInfo = nui.get("vcStockCode");
			bondInfo = stockInfo.data;
			var stockCode = stockInfo.getValue();
			var positionInfo = {};
			for (var i = 0;i < bondInfo.length;i++){
				for (var key in bondInfo[i]) {
					if(bondInfo[i][key] == stockCode){
						positionInfo = bondInfo[i];
					}
        		}
			}
			var vcExchange = positionInfo.vcMarketNo;
			nui.get("vcMarketNo").setValue(vcExchange);
			nui.get("vcMarketNo").setText(nui.getDictText("tradePlace",vcExchange));
		}
		//页面X的删除功能
        function onCloseClick(e) {
            var obj = e.sender;
            obj.setText("");
            obj.setValue("");
        }
        function cancel(){
        	CloseOwnerWindow();
        }
	</script>
</body>
</html>