<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>
<html>
<!-- 
  - Author(s): 翟静
  - Date: 2016-11-17 14:24:42
  - Description:
-->
<head>
<title>导入返回结果信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>

	<input  inputStyle=" color:#ff0000; width:100%" class="nui-textbox" width="100%"   id="resultMsg" readonly="true"  />

	<div class="nui-fit" >
		<div id="datagrid1"
			class="nui-datagrid"
			showPager="false"
	       	style="width:100%;height:98%; " sortField="id" sortOrder="asc">
			
			<div property="columns">
	        	<div field="rowNo" headerAlign="center" align='center' width="5px">行号</div>
	            <div field="errorMsg" headerAlign="center" align='center' width="20px">反馈信息</div>
			</div>
		</div>  
	</div>            

    <div id="footer" class="nui-toolbar" style="padding:0px; width:100%;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align:center;" >
					<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onExict()">关闭</a>
				</td>
			</tr>
		</table>
	</div>	
	
	<script type="text/javascript">
	nui.parse();
	
	var grid = nui.get("datagrid1");
	
    function SetData(data){
    	var dataMap = nui.decode(data);
		grid.setData(dataMap.errorList);
	    //结果信息列表
	    var insertList = dataMap.insertList;
	    var errorList = dataMap.errorList;
	    var insertLength = 0;
	    var errorLength = 0;
	    if(null != insertList && null != insertList.length){
	    	insertLength = insertList.length;
	    }
	    if(null != errorList && null != errorList.length){
	    	errorLength = errorList.length;
	    }
	    var resultMsg = "总计："+(insertLength+errorLength)+"条数据，成功："+insertLength+"条，失败"+errorLength+"条";
	    nui.get("resultMsg").setValue(resultMsg);
	} 
	
	function onExict(){
		CloseWindow("cancel");
		// window.Owner.onCancel();
           
 	}
    function CloseWindow(action) {
        if(window.CloseOwnerWindow){
	    	return window.CloseOwnerWindow(action);
        }
        else{
        	window.close();
        }
    }
	</script>
</body>
</html>