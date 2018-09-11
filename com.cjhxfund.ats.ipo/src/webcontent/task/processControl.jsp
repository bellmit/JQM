<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<form id="processForm" method="post" >
<table id="processTbl" style="width:100%;table-layout:fixed;" border="0" class="nui-form-table">
	<colgroup>
		<col width="15%"></col>
		<col width="35%"></col>
		<col width="15%"></col>
		<col width="35%"></col>
	</colgroup>
	<tr>
		<td colspan="1" class="td1" width="15%" align="right">新股流程: </td>
		<td id="stockTd" colspan="3" class="td2" width="85%">
		</td>
	</tr>
	<tr>
		<td class="td1" width="15%" align="right">
		当前节点:    
		</td>
		<td id="currentTd" colspan="3" class="td2" width="85%">
		</td>
	</tr>
	
</table>
<table style="width:100%;table-layout:fixed;" border="0" class="nui-form-table">
	<colgroup>
		<col width="15%"></col>
		<col width="35%"></col>
		<col width="15%"></col>
		<col width="35%"></col>
	</colgroup>
	<tr>
		<td class="td1" width="15%" align="right">操作:</td>
		<td colspan="1" class="radio-border-top-none">
			<input name="vcOperateType" id="vcOperateType" class="nui-radiobuttonlist" onitemclick="operateCheck()" 
					data="[{id: 1, text: '同意'} ,{id: 2, text: '驳回'}]" style="float: left;" value="1"/>
		</td>
	</tr>
	<tr>
		<td class="td1" align="right">处理意见:</td>
		<td colspan="3" class="td2"><input id="vcComments" class="nui-textarea" name="vcComments" width="600" height="60" value="同意"/></td>
	</tr>
	<tr>
		<td class="td1" colspan="2" align="center">
			<a id="processSubmit" class='nui-button' plain='false' iconCls="icon-save" onclick="processSubmit()">提交</a> &nbsp;&nbsp;&nbsp;&nbsp;
		   	<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow('close')">返回</a>
		</td>
	</tr>
</table>
</form>
<script>
	//设置处理意见
	function operateCheck(){
		var vcOperateTypeValue=nui.get("vcOperateType").getValue();//获取选中项的value
		if(vcOperateTypeValue==2){//同意:1,驳回:2
			nui.get("vcComments").setValue("驳回");//设置处理意见的value
		}else{
			nui.get("vcComments").setValue("同意");//设置处理意见的value
		}
	}
	//关闭窗口--返回
    function CloseWindow(action){
      if(action=="close" && form.isChanged()){
      	nui.confirm("数据已改变,确认退出?","系统提示",function(a){
      		if(a=='ok'){
      			deleteFilePreparation();
      			CloseWindow("cance");
      		}
      	});
      }else if(window.CloseOwnerWindow) 
        return window.CloseOwnerWindow(action);
      else{
      	window.opener = null;
		window.open(' ', '_self', ' ');
		window.close();
      }
    }
</script>
	    