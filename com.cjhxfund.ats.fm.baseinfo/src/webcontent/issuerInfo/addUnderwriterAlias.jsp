<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/js/commscripts.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 谢海光
  - Date: 2017-06-28 15:54:06
  - Description:
-->
<head>
<title>新增别名</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
        <div id="dataform1" style="padding-top:0px; " >
            <!-- hidden域   -->
            <input   id="cStatus"   class="nui-hidden" name="alias.cStatus"/>
            <input   id="lOperatorNo"   class="nui-hidden" name="alias.lOperatorNo"/>
            <input   id="lDate" class="nui-hidden" dateFormat="yyyy-MM-dd" name="alias.lDate"/>
            <table style="width:aotu;height:157px;table-layout:fixed;" class="nui-form-table" align="center" >
                <tr>
                    <td class="form_label" align="right" >
                        	<span style="color:red">*</span>&nbsp;别名类型:
                    </td>
                    <td align="left">
                    		<input id="vcAliasType" class="nui-dictcombobox" dictTypeId="ATS_FM_ALIAS_TYPE" name="alias.vcAliasType" required="true" onvaluechanged="cheangedAliasType" />
                    </td>
                    <td class="form_label" align="right" >
                        	<span style="color:red">*</span>&nbsp;wind简称:
                    </td>
                    <td align="left">
                    		 <input id="vcRightNameAbbrWind" required="true" class="nui-autocomplete" style="width:150px;" name="alias.vcRightNameAbbrWind" searchField="searchKey" dataField="bondList"
                        	  valueField="vcRightNameFullWind" textField="vcRightNameFullWind" url="com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.queryUnderwriterInfo.biz.ext" value="" text="" enterQuery="false" onvaluechanged="cheangedMainUnderwriter"/>
                             <input id="lRightId" class="nui-hidden" name="alias.lRightId"/>
                             <input id="vcRightNameFullWind" class="nui-hidden" name="alias.vcRightNameFullWind"/>
                    </td>
                    <td class="form_label" align="right" >
                        	<span style="color:red">*</span>&nbsp;数据源简称:
                    </td>
                    <td id="vcLeftName" align="left" >
                    		<input id="vcLeftNameAbbr" required="true" class="nui-autocomplete" style="width:150px;" name="alias.vcLeftNameAbbr" searchField="searchKey" dataField="bondList"
                        	  valueField="vcLeftNameAbbr" textField="vcLeftNameAbbr" url="com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.queryUnderwriterAlisInfo.biz.ext" value="" text="" enterQuery="false" />
                    </td>
                    <td id="vcLeftName1" style="display:none" align="left">
                    		<input id="vcLeftNameAbbr1" required="true" class="nui-textbox" style="width:150px;" name="alias.vcLeftNameAbbr1" />
                    </td>  
                </tr>
            </table>
        </div>
        <div class="nui-toolbar" style="border:0; top:0px">
		    <table style="width:100%;">
		       <tr>
		           <td style="text-align:center;">
		               	<a class="nui-button"  iconCls="icon-ok" onclick="onOk()">保存</a>
		        		<span style="display:inline-block;width:25px;"></span>
		        		<a class="nui-button"   iconCls="icon-cancel" onclick="onCancel()">取消</a>
		           </td>
		       </tr>
		    </table>
		</div>   
        


	<script type="text/javascript">
    	nui.parse();
    	
    	function cheangedAliasType(e){
    	   nui.get("vcRightNameAbbrWind").setValue("");
    	   nui.get("vcRightNameAbbrWind").setText("");
    	   var vcRightNameAbbrWind = nui.get("vcRightNameAbbrWind");
	       var url = "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.queryUnderwriterInfo.biz.ext?vcAlaisType="+e.value;
	       vcRightNameAbbrWind.setUrl(url); 
	       if(e.value==2 || e.value==3){
	          document.getElementById( "vcLeftName").style.display= "none";
	          document.getElementById( "vcLeftName1").style.display= "";
	          nui.get("vcLeftNameAbbr1").setValue("");
	       }else{
	          document.getElementById( "vcLeftName").style.display= "";
	          document.getElementById( "vcLeftName1").style.display= "none";
	          nui.get("vcLeftNameAbbr").setValue("");
	          nui.get("vcLeftNameAbbr").setText("");
	       }
    	}
    	//设置当前时间保存到数据库
		 nui.getbyName("alias.lDate").setValue(new Date());
		             
         nui.getbyName("alias.cStatus").setValue("1");
         nui.getbyName("alias.lOperatorNo").setValue(<%=userObject.getUserId()%>);
    	 function saveData(){
                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                form.validate();
                if(form.isValid()==false){
                 nui.alert("必填项不能为空！","",function(){});
                 return;
                }
                var data = form.getData(false,true).alias;
                 var vcAliasType=nui.get("vcAliasType").getValue();
                 if(vcAliasType==1){
                     var vcRightNameAbbrWind=nui.get("vcRightNameAbbrWind").getData().length;
	                 var vcLeftNameAbbr=nui.get("vcLeftNameAbbr").getData().length;
	                 if(vcRightNameAbbrWind==0 || vcLeftNameAbbr==0){
	                   nui.alert("必须选择已存在数据项！","",function(){});
	                   return;
	                 }
                 }else{
                     var vcRightNameAbbrWind1=nui.get("vcRightNameAbbrWind").getData().length;
	                 if(vcRightNameAbbrWind1==0){
	                   nui.alert("必须选择已存在数据项！","",function(){});
	                   return;
	                 }
	                 data.vcLeftNameAbbr=data.vcLeftNameAbbr1;
                 }
                 
                 var lLeftId=nui.get("lRightId").getValue();
                 var json = nui.encode({underwriterInfo:data,vcMainUnderwriterId:lLeftId});
                //保存
                var urlStr = "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.addUnderwriterAliasInfo.biz.ext";
                form.loading();//加载遮罩
                $.ajax({
                    url:urlStr,
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                        form.unmask();//取消遮罩
                        var returnJson = nui.decode(text);
                        if(returnJson.returnCode == "yes"){
                            nui.alert("保存成功！","",function(action){
                             CloseWindow("saveSuccess");
                            });
                        }else if(returnJson.returnCode == "no"){
                            nui.alert("主承销商和关联别名已存在，请确认！", "系统提示");
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
                    
			      function cheangedMainUnderwriter(e){
			          if(e.selected != undefined){
			              var lRightId=e.selected.lRightId;
				          var vcRightNameFullWind=e.selected.vcRightNameFullWind;
				          nui.get("lRightId").setValue(lRightId);
				          nui.get("vcRightNameFullWind").setValue(vcRightNameFullWind);
			          }
			          
			      }
    </script>
</body>
</html>