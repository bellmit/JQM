<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>
<html>
<!-- 
  - Author(s): 谢海光
  - Date: 2017-05-24 10:06:22
  - Description:
-->
<head>
<title>新增交易对手</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="width: 100%;height: 100%;overflow: hidden;">
              <div id="dataform1" style="width: 100%;height: 90%;" style="padding-top:5px;">
              	
	            <!-- 业务子表参数 -->
	            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
	                <tr>
	                    <td class="form_label" align="right" style="width: 40%;">
	                           <span style="color:red">*</span>&nbsp; 交易对手简称:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-textbox" id="vcName" style="width: 90%;" required="true"  name="traderivalInfo.vcName"/>
	                    </td>
	                </tr>
	                <tr id="tr1">
	                    <td class="form_label" align="right" style="width: 35%;">
	                         <span style="color:red">*</span>&nbsp; 交易对手全称:
	                    </td>
	                    <td colspan="1" >
	                    	 <input class="nui-textbox" style="width: 90%;" required="true" id="vcAllName"  name="traderivalInfo.vcAllName"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right" style="width: 35%;">
	                        <span style="color:red">*</span>&nbsp; 交易对手拼音:
	                    </td>
	                    <td colspan="1">
	                    	<input  class="nui-textbox" style="width: 90%;" required="true" id="vcPinyin"  name="traderivalInfo.vcPinyin" />
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right" style="width: 30%;">
	                       	 发行人简称:
	                    </td>
	                    <td colspan="1" > 
	                        <input class="nui-textbox"  id="vcIssuerName" style="width: 90%;"  name="traderivalInfo.vcIssuerName"/>
	                    </td>
	                </tr>                     	               
	                <tr>
	                    <td class="form_label" align="right" style="width: 30%;">
	                       	 发行人全称:
	                    </td>
	                    <td colspan="1" > 
	                        <input class="nui-textbox"  id="vcIssuerFullname" style="width: 90%;"  name="traderivalInfo.vcIssuerFullname"/>
	                    </td>
	                </tr>
	            </table>
              
	        </div>
        <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
	         <table width="100%">
	             <tr>
	               <td style="text-align:center;" colspan="4">
	                  <a class='nui-button' plain='false' iconCls="icon-save" onclick="saveData()">
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
    	var form = new nui.Form("#dataform1");
        form.setChanged(false);
    	//取消
        function onCancel() {
            CloseWindow("");
        }
     
        function check(obj){  
	       var reg = new RegExp("^^[0-9]+\.?[0-9]*$");  
		    if(!reg.test(obj.value)){ 
		        nui.alert("请检查数据,该项只能输入数字!");  
		        return;
		    }  
	  }
	  //关闭窗口
		function CloseWindow(action){
	     if(window.CloseOwnerWindow){
	      	if(action=="close"){
	      		action="";
	      	}
	      	window.returnValue = action;
	        return window.CloseOwnerWindow(action);
	      }   
	      else{
	        return window.CloseOwnerWindow("");
	      }
		} 
        function saveData(){
            form.validate();
			if (form.isValid() == false) {
				nui.alert("请检查必填项!");
				return;
			}
            var data = form.getData(false,true);
             var json = nui.encode(data);
			 $.ajax({
				url:"com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.addTraderivalInfo.biz.ext",
	            type:'POST',
	            data:json,
	            cache:false,
	            contentType:'text/json',
	            success:function(text){
					var returnJson = nui.decode(text);
        			if(returnJson.returnCode == "yes"){
        				nui.alert("保存成功", "系统提示", function(action){
                        		if(action == "ok" || action == "close"){
                            		CloseWindow(returnJson.vcName);
                        		}
                    		});
        			}else if(returnJson.returnCode == "no"){
        			   nui.alert("交易对手已存在！", "系统提示");
        			}else{
        			   nui.alert("保存失败！", "系统提示");
        			}
				}    
			});
        }
       
    </script>
</body>
</html>