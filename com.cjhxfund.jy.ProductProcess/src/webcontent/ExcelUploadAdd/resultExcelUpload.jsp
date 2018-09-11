<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>
<html>
<!-- 
  - Author(s): heyi
  - Date: 2017-03-20 10:24:42
  - Description:
-->
<head>
<title>导入返回结果信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
         <input  inputStyle=" color:#ff0000; width:100%" class="nui-textbox" width="100%"   id="resultMsg" readonly="true"  />
	
	<div class="nui-fit" >
     <div  id="datagrid1"
           class="nui-datagrid"
           showPager="false"
           style="width:100%;height:98%; " sortField="id" sortOrder="asc">
				
          <div property="columns">
                <div field="id" headerAlign="center" align='center' width="5px"  >
                    	行号
                </div>
                <div field="errorMsg" headerAlign="center" align='center' width="20px"  >
                    	反馈信息
                </div>
          </div>
    </div>  
     </div>            

    <div id="footer" class="nui-toolbar" style="padding:0px; width:100%;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align:center;" >
					<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onExict()">
                                                                        关闭
					</a>
				</td>
			</tr>
		</table>
	</div>	
	
	<script type="text/javascript">
	nui.parse();
	var grid = nui.get("datagrid1"); 
    function SetData(data){
	    grid.setData(nui.decode(data).msgList);
	    //结果信息列表
	    var msgList = nui.decode(data).msgList;
	        var resultMsg = "总计："+msgList[msgList.length-1].num+"条数据，成功："+msgList[msgList.length-1].successNum+"条，失败"+msgList[msgList.length-1].failNum+"条";
	        nui.get("resultMsg").setValue(resultMsg);
	    
	 } 
	
	 function onExict(){
           CloseWindow("cancel");
          // window.Owner.onCancel();
    }
    function CloseWindow(action) {
        if (window.CloseOwnerWindow){
	        return window.CloseOwnerWindow(action);
        }
        else window.close();
    }
	</script>
</body>
</html>