<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp"%>
<!-- 
  - Author(s): 周靖
  - Date: 2016-09-08 16:00:24
  - Description:手工置交收
-->
<head>
<title>后台交收状态</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

</head>
<body>
	<div>
		<div id="form_bond_quate_condition" class="nui-form-table" align="center">
			<div>
				<span id="point" style="color: red;"> </span>
			</div>
			<input id ="vcFsDealId" name="condition/vcFsDealId" class="nui-hidden" value=""/>
			<input id ="vcSourceNo" name="condition/vcSourceNo" class="nui-hidden"/>
			<input id ="vcBsDealId" name="condition/vcBsDealId" class="nui-hidden"/>
			<input id ="vcBsDealStatus" name="condition/vcBsDealStatus" class="nui-hidden"/>
			<input id ="tBsDealTime" name="condition/tBsDealTime" class="nui-hidden"/>
			<input id ="cEntrustDirection" name="condition/cEntrustDirection" class="nui-hidden"/>
			<input id ="traceId" name="condition/traceId" class="nui-hidden"/>
			<div style="font-size:13px">
				<input id="setmtStatus" name="condition/setmtStatus"  repeatItems="7"  repeatLayout="table"  repeatDirection="vertical"
					class="nui-radiobuttonlist"  style="width:80%;"
					data="[
					{id:'01',text:'我方待确认'},
					{id:'04',text:'等我方款'},
					{id:'06',text:'等我方券'},
					{id:'11',text:'担保交收'},
					{id:'09',text:'后台已成交'},
					{id:'13',text:'未成交(备注必填)'},
					{id:'99',text:'其他(备注必填)'},
					{id:'02',text:'对方待确认，请催对手方'},
					{id:'03',text:'双方待确认，请催对手方  '},
					{id:'05',text:'等对方款，请催对手方'},
					{id:'07',text:'等对方券，请催对手方'},
					{id:'10',text:'等款等券，请催对手方'},
					{id:'08',text:'双方已确认，调款中'}]" value="01" />
			</div>
			备注： <input id="remark" class="nui-textarea"
				style="resize: none; width: 80%; height: 60px;"
				name="condition/remark" />
		</div>
	</div>
<!-- <div class="nui-toolbar" style="text-align:center;padding-top:5px;padding-bottom:10px;" borderStyle="border:0;">
    <a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk">确定</a>
    <span style="display:inline-block;width:25px;"></span>
    <a class='nui-button' plain='false' iconCls="icon-close" onclick="onCancel">取消</a>
</div> -->
	<div style="text-align: center;padding-top:10px;">
		<a class="mini-button" iconCls="icon-ok" onclick="onOk" style="width: 60px; margin-right: 20px;">确定</a> 
		<a class="mini-button" iconCls="icon-cancel" onclick="onCancel" style="width: 60px;">取消</a>
	</div>
	<script type="text/javascript">
		var conditionForm = new nui.Form("#form_bond_quate_condition");
		var infos;
		function setFormData(data){
			infos = nui.clone(data);
			$("#setmtStatus  label:lt(99)").css({
					"color":"blue",
					"font-size":"13px"
			}); 
			$("#setmtStatus  label:eq(6)").css({
					"color":"green",
					"font-size":"13px"
			});
			$("#setmtStatus  label:eq(8)").css({
					"color":"green",
					"font-size":"13px"
			}); 
			$("#setmtStatus  label:eq(10)").css({
					"color":"red",
					"font-size":"13px"
			});
			$("#setmtStatus  label:eq(12)").css({
					"color":"black",
					"font-size":"13px"
			});
			/* $("#setmtStatus  table").css({
					"cellspacing":"0"
			}); */
			
		}
		function onOk(e) {
			var info={information:infos};
			var setmtStatus = nui.get("setmtStatus").getValue();
			var remark = nui.get("remark").getValue();
			info["setmtStatus"]=setmtStatus;
			info["vcRemark"]=remark;
			if(info.information.length>1 && (setmtStatus=="01"||setmtStatus=="02"||setmtStatus=="03"||setmtStatus=="04"
			||setmtStatus=="05"||setmtStatus=="06"||setmtStatus=="07"||setmtStatus=="08"||setmtStatus=="10")){
				nui.alert("只有担保交收、后台已成交、未成交和其他这四种状态时</br>才可以进行批量操作，请重新选择！","系统提示",function(){
					//window.CloseOwnerWindow("saveSuccess");
				});
			}else{
				if (setmtStatus == "99" && remark == "") {
					nui.alert("请填写备注信息！");
				} else if (setmtStatus == "13" && remark == "") {
					nui.alert("请填写备注信息！");
				}else if (setmtStatus == "99" && remark != "") {
					nui.ajax({
						url : "com.cjhxfund.ats.sm.comm.FundSetmtTraceManager.updateFundSetmtTraceManually.biz.ext",
						type : 'POST',
						data : nui.encode(info),
						contentType : 'text/json',
						success : function(returnStr) {
							var returnInfo = nui.encode(returnStr.returnStr);
							nui.alert(returnInfo.replace("\"","").replace("\"",""),"系统提示",function(){
								window.CloseOwnerWindow("saveSuccess");
							});
						}
					});
				}else{
					nui.ajax({
						url : "com.cjhxfund.ats.sm.comm.FundSetmtTraceManager.updateFundSetmtTraceManually.biz.ext",
						type : 'POST',
						data : nui.encode(info),
						contentType : 'text/json',
						success : function(returnStr) {
							var returnInfo = nui.encode(returnStr.returnStr);
							nui.alert(returnInfo.replace("\"","").replace("\"",""),"系统提示",function(){
								window.CloseOwnerWindow("saveSuccess");
							});
						}
					});
				}
			}
		}
		function onCancel(e) {
			window.CloseOwnerWindow();
		}
	</script>
</body>
</html>