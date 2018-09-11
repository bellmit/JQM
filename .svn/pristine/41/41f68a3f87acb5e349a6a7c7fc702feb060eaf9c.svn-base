<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 翟静
  - Date: 2016-12-09 9:47:27
  - Description:
-->
<head>
<title>添加别名信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    
</head>
<body>
       <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:0px; " >
            <!-- hidden域   -->
            <input   id="lAliasId"   class="nui-hidden" name="alias.lAliasId"/>
            <input   id="vcIssuerNameFull"   class="nui-hidden" name="alias.vcIssuerNameFull"/>
            <input   id="cStatus"   class="nui-hidden" name="alias.cStatus"/>
            <input   id="lOperatorNo"   class="nui-hidden" name="alias.lOperatorNo"/>
            <input   id="lDate" class="nui-hidden" dateFormat="yyyy-MM-dd" name="alias.lDate"/>
            <table style="width:aotu;height:100px;table-layout:fixed;" class="nui-form-table" align="center" >
                <tr>
                    <td class="form_label" align="right" >
                        	<span style="color:red">*</span>&nbsp;别名:
                    </td>
                    <td align="left">
                    		<input style="width: 150px;"   class="nui-textbox" id="vcIssuerNameFullWind"  name="alias.vcIssuerNameFullWind" required="true" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-toolbar" style="border:0; top:0px">
		    <table style="width:100%;">
		       <tr>
		           <td style="text-align:center;">
		               	<a class='nui-button' plain='false'  iconCls="icon-ok" onclick="onOk()">保存</a>
		        		<span style="display:inline-block;width:25px;"></span>
		        		<a class='nui-button' plain='false'   iconCls="icon-cancel" onclick="onCancel()">取消</a>
		           </td>
		       </tr>
		    </table>
		</div>   
        


	<script type="text/javascript">
    	nui.parse();
    	
    	 function saveData(){
                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                form.validate();
                if(form.isValid()==false){
                 nui.alert("添加别名不能为空！","",function(){});
                 return;
                }
                 var data = form.getData(false,true);
                 var json = nui.encode(data);
                //保存
                var urlStr = "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.addIssueAliasInfo.biz.ext";

                $.ajax({
                    url:urlStr,
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                            nui.alert("保存成功！","",function(action){
                             CloseWindow("saveSuccess");
                            });
                        }else{
                            nui.alert("保存失败", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                    //CloseWindow("saveFailed");
                                }
                                });
                            }
                        }
                        });
                    }

                     //页面间传输json数据
                    function setFormData(data){
                        //跨页面传递的数据对象，克隆后才可以安全使用
                        var infos = nui.clone(data);
                         var vcIssueNameFull = infos.substring(1,infos.length-1);
                        	 nui.getbyName("alias.vcIssuerNameFull").setValue(vcIssueNameFull);
                        	
		                	 //设置当前时间保存到数据库
				             nui.getbyName("alias.lDate").setValue(new Date());
				             
		                	 nui.getbyName("alias.cStatus").setValue("1");
		                	 nui.getbyName("alias.lOperatorNo").setValue(<%=userObject.getUserId()%>);
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

                    //确定保存或更新
                    function onOk() {
                        saveData();
                    }

                    //取消
                    function onCancel() {
                        CloseWindow("cancel");
                    }
    </script>
</body>
</html>