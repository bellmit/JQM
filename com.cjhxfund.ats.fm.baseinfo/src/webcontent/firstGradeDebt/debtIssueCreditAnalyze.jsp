<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 石浩
  - Date: 2016-08-30 13:57:50
  - Description:
-->
<head>
<title>信用分析</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    
</head>
<body style="width: 100%;height: 100%;overflow: hidden;">
        <div id="tabs" class="nui-form" style="width: 100%;height:83%;">
              <div id="dataform1" style="padding-top:5px;">
	            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table"  border="0">
	                <!-- <tr>
	                	<td class="form_label" align="right" width="60px">&nbsp; 债券代码:</td>
	                    <td colspan="1" align="left" >
	                        <input class="nui-textbox"  id="vcStockName" width="100%" name="debtIssue.vcStockCode" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
	                    </td>
	                    <td class="form_label" align="right" width="60px">&nbsp;债券名称:</td>
	                    <td colspan="1" align="left" >
	                    	 <input class="nui-textbox" id="vcStockName" width="100%" name="debtIssue.vcStockName" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
	                    </td>
	                </tr> -->
	                <tr id="tr1">
	                   <td class="form_label" align="right" width="60px">
	                        	信用分析:
	                    </td>
	                    <td colspan="3" align="left" >
	                    	<input  class="nui-textarea" height="130px" id="vcCreditAnalyze" name="debtIssue.vcCreditAnalyze" width="100%"/>
	                    	<input class="nui-hidden" id="lStockIssueId"  name="debtIssue.lStockIssueId"/>
	                    </td>
	                </tr>
                </table>
            </div>
        </div>
        <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
	         <table width="100%">
	             <tr>
	               <td style="text-align:center;" colspan="4">
	                  <a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">
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
    	
    	function SetData(data){
    	 form.setData({debtIssue:data}); //表单数据初始化
    	}
    	
    	function onOk(){
    	     var vcCreditAnalyze = nui.get("vcCreditAnalyze").value;
    	     if(vcCreditAnalyze==""){
    	     	nui.alert("请输入信用分析!");
    	     	return;
    	     }
    	     var data = form.getData(false,true);
             var json = nui.encode(data);
			 $.ajax({
				url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.updateCreditAnalyze.biz.ext",
	            type:'POST',
	            data:json,
	            cache:false,
	            contentType:'text/json',
	            success:function(text){
					var returnJson = nui.decode(text);
        			if(returnJson.exception == null){
        				nui.alert("保存成功", "系统提示", function(action){
                        		if(action == "ok" || action == "close"){
                            		CloseWindow("saveSuccess");
                        		}
                    		});
        			}
				}    
			});
    	}
    	
    	function onCancel(){
    		CloseWindow("close");
    	}
    	
    	  //关闭窗口
		function CloseWindow(action){
	      if(action=="close" && form.isChanged()){
	        if(confirm("数据已改变,是否先保存?")){
	          return false;
	        }
	      }else if(window.CloseOwnerWindow) 
	        return window.CloseOwnerWindow(action);
	      else
	        return window.close();
		} 
    </script>
  </body>
</html>
	
