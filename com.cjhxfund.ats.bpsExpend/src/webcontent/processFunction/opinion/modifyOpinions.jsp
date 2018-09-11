<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>处理意见</title>
<%@ include file="/bpsExpend/common/common.jsp"%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>

<body>
	<div id="form1" class="nui-form" style="width: 100%; height:100%; " >
		<table style=" width: 100%; height:100%; "  >
			<tr style="border-top: 1px solid #DCDCDC;">
           		<td colspan="3"  ;>
           			<div id="datagrid" class="nui-datagrid" 
           				dataField="workList" style="  height:270px; max-height:270px; " 
						url="com.cjhxfund.fpm.bpsExpend.opinion.queryWorkItemForAct.biz.ext"
						allowSortColumn="false" showPager="false" 
						onrowclick="modifyPart"
						allowResizeColumn="false">						
						<div property="columns" style="overflow:auto;">
							<div field="partiName" headerAlign="center">当前处理人</div>
							<div field="currentState" headerAlign="center">处理状态</div>
							<div field="endTime" headerAlign="center" 	dateFormat="yyyy-MM-dd HH:mm:ss ">处理时间</div>
						</div>						
					</div>  
           		</td>           		
           	</tr>
           	<!-- 流程操作控制 -->
			<tr   id="operateTypeTr">
				<th class="nui-form-label">操作：</th>
				<td colspan="3" >
					<input id="operType" name="operType" class="nui-radiobuttonlist" 
						data="[{id: 1, text: '改派'} ,{id: 2, text: '撤销'},{id: 3, text: '加签'}]"
	         			 value="1" 
	         			onvaluechanged="changeOperatorType(this)"></input>	
	         	</td>					
			</tr>
			<!-- 参与人设置 -->
			<tr   id="sourcePartTr">
				<th class="nui-form-label">原操作人：</th>
				<td colspan="2" >
					<input id="partNow" name="partNow" class="nui-textbox" />
	         	</td>			
			</tr>
			<!-- 参与人设置 -->
			<!-- 流程征求意见-->
			<tr id="askOpinions_tr">
				<th class="nui-form-label" id="askOpinions_td">
					<font style="color: red;">*</font>
					<span id="askOpinionsTitle">选择修改征求意见人员</span>
				</th>
                <td colspan="2"  >
                	<input class="nui-buttonedit" id="askParti"  name="askParti" onclick="selectSingleEmp">
                </td>
            </tr>
            <!-- 流程征求意见（多人）-->
			<tr id="askMutiOpinions_tr" visible="false">
				<th class="nui-form-label" id="askMutiOpinions_td">
					<font style="color: red;">*</font>
					<span id="askMutiOpinionsTitle">选择加签征求意见人员</span>
				</th>
                <td colspan="2" >
                	<input class="nui-buttonedit" id="askPartis"  name="askPartis" onclick="selectMutiEmp" >
                </td>
            </tr>
            <tr>	
				<td  id="excute" style="text-align:center;" colspan="3">
					<a class="nui-button" id="processSubBtn" iconCls="icon-ok" onclick="submitModify()">提交</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr> 
		</table>
 
<script type="text/javascript">		
	nui.parse();
	var grid=nui.get("datagrid");
	//传递活动实例ID
	function SetData(data) {
		data = nui.clone(data);
		//datagrid加载数据 
		grid.load({taskObj:data});
	}
	
	$("#askMutiOpinions_tr").hide();
	
	grid.on("drawcell", function (e) {
	 	var record = e.record;
        //设置行样式
        if (record.currentState == 12) {
        	if(e.field=="currentState"){
            	e.cellHtml = "已处理";
            }
        }else if (record.currentState == 13){
        	if(e.field=="currentState"){
        		e.cellHtml = "已撤销";
        	}
        }else if (record.currentState == 10){
        	if(e.field=="currentState"){
        		e.cellHtml = "未处理";
        	}
        }
	});
	
	//变更操作类型
	function changeOperatorType(e){
		if(e.value==1){
			$("#sourcePartTr").show();
			$("#askOpinions_tr").show();
			$("#askMutiOpinions_tr").hide();
		}else if(e.value==2){
			$("#sourcePartTr").show();
			$("#askOpinions_tr").hide();
			$("#askMutiOpinions_tr").hide();
		}else if(e.value==3){
			$("#sourcePartTr").hide();
			$("#askOpinions_tr").hide();
			$("#askMutiOpinions_tr").show();
		}
	}
	
	//设置原操作人文本域的值
	function modifyPart(){
		var workInfo=grid.getSelected();
		nui.get("partNow").setValue(workInfo.partiName);
	}
	
	//提交修改操作
	function submitModify(){
		var workInfo=grid.getSelected();
		if(workInfo.currentState==12 ||workInfo.currentState==13){
			nui.alert("选择的任务已经完成，不允许被操作，请重新选择！","系统提示");
			return;
		}
		var form = new nui.Form("#form1");
		var formData=form.getData();
		//alert(nui.encode(formData));
		var data={workInfo:workInfo,formData:formData};
		var json=nui.encode(data);
		//alert(json);
		nui.ajax({
			url : "com.cjhxfund.fpm.bpsExpend.opinion.modifyOpinionsParti.biz.ext",
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				var resJson=nui.decode(text);
				if(resJson.exception == null || resJson.exception=="undefined"){
					if(resJson.rtnCode=="01"){
						nui.alert("选择的加签的参与人中，有人已经存在征求意见任务了，请重新选择！","系统提示");
					}
					
					grid.reload();
				}
			}
		});
	}
	
	
</script>  
</body>
</html>