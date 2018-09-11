<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@include file="/common/js/commscripts.jsp" %>
<%--
- Author(s): 杨敏
- Date: 2016-01-25 17:40:16
- Description:
    --%>
    <head>
        <title>
            新增分组
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <style type="text/css">
    	   
    	</style>
    
    </head>
    <!-- 权限标签 -->
    
    <body style="width:99.6%;height:99.6%;overflow: hidden;">
    <div id="dataform1">
		<table style="width:100%; table-layout:fixed;margin: 0xp;padding: 10px;" id="table" border="0" class="">	
			<tr>
                <td style="width:100px; " align="right">分组名称：</td>
                <td >
                	<input id="vcGroupName" name="vcGroupName" class="mini-textbox" style="width:80%"  />
                </td>
             </tr>
          </table>
	</div>
     <div class="nui-toolbar" id="submit_button" style="padding:30px 0 0 0;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align:center;" colspan="4">
					<a class='nui-button' plain='false' iconCls="icon-save" onclick="add()">
                                                                        保存
					</a>
					<span style="display:inline-block;width:25px;"></span>
					<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
                                                                          取消
					</a>
				</td>
			</tr>
		</table>
	</div>
        <script type="text/javascript">
            nui.parse();
            var userGroup=null;
        	function SetData(data){
        		data = nui.clone(data.parentNode);
        		if(data.nodeId=="" || data.nodeId==null || data.nodeId=="null"){
        			data.nodeId="-1";
        			data.vcGroupSeq=".-1.";
        		}
        		userGroup={"vcGroupSeq":data.vcGroupSeq,"lParentId":data.nodeId};
        	}
        	function add(){
        		userGroup.vcGroupName=$.trim(nui.get("vcGroupName").getValue());
        		
        		if(userGroup.vcGroupName==""){
        			nui.alert("请输入分组名称~");
        			return;
        		}
        		 nui.ajax({
		            url: "com.cjhxfund.jy.ProductProcess.o32tcjc.addGroup.biz.ext",
		            type: 'POST',
		            data: {userGroup:userGroup},
		            cache: false,
		            contentType:'text/json',
		            cache: false,
		            success: function (text) {
            			if(text.ret==1){
		                	nui.alert("添加成功~","系统提示",function(){
		                	onCancel();
		                });
		                }else{
		                	nui.alert("添加失败，请联系管理员","系统提示");
		                }
		            }
		        });
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
          </script>
     </body>
</html>