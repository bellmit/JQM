<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 黄燕
  - Date: 2016-11-08 13:38:57
  - Description:
-->
<head>
<title>修改发行主体</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <script type="text/javascript" src="js/getPY.js"></script>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;">
              <div id="dataform1" style="width: 100%;height: 92%;" style="padding-top:5px;">
              	
	            <!-- 业务子表参数 -->
	            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
	               
	                <tr>
	                    <td class="form_label" align="right" style="width: 40%;">
	                           <span style="color:red">*</span>&nbsp; 主体简称:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-textbox" id="vcIssueName" style="width: 90%;" required="true"  name="issuerInfo.vcIssueName"/>
	                    	<input class="nui-hidden" id="vcIssueNameChar" style="width: 95%;"  name="issuerInfo.vcIssueNameChar"/>
	                    	<input class="nui-hidden" id="lIssuerId" style="width: 95%;"  name="issuerInfo.lIssuerId"/>
	                    	<input class="nui-hidden" id="lIssuerIdO32" style="width: 95%;"  name="issuerInfo.lIssuerIdO32"/>
	                    	<input class="nui-hidden" id="vcIssuerCode" style="width: 95%;"  name="issuerInfo.vcIssuerCode"/>
	                    </td>
	                </tr>
	                <tr id="tr1">
	                    <td class="form_label" align="right" style="width: 35%;">
	                         <span style="color:red">*</span>&nbsp; 主体全称:
	                    </td>
	                    <td colspan="1" >
	                    	 <input class="nui-textbox" style="width: 90%;" required="true" id="vcIssueNameFull"  name="issuerInfo.vcIssueNameFull"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right" style="width: 35%;">
	                                                                                    <span style="color:red">*</span>&nbsp;主体类型:
	                    </td>
	                    <td colspan="1">
	                    	<input  class="nui-dictcombobox" style="width: 90%;" required="true" popupHeight="140px" dictTypeId="ATS_FM_ISSUE_PROPERTY" id="vcIssueProperty"  name="issuerInfo.vcIssueProperty" showNullItem="false"/>
	                    </td>
	                </tr>
	                <tr>
	                     <td class="form_label" align="right" style="width: 30%;">
	                                                                                    主体评级:
	                    </td>
	                    <td colspan="1">
	                    	<input  textField="dictName" valueField="dictID" style="width: 90%;" popupHeight="140px" class="nui-dictcombobox"  dictTypeId="issuerRating" id="cIssueAppraise" value="" name="issuerInfo.cIssueAppraise" showNullItem="false"/>
	                    </td>
	                </tr>	                	                
	                <tr>
	                      <td class="form_label" align="right" style="width: 30%;">
	                                                                                    所属行业:
	                    </td>
	                    <td colspan="1">
	                     	<!-- <input class="nui-textbox"  id="vcIndustry" style="width: 90%;"  name="issuerInfo.vcIndustry"/> -->
	                     	<input style="width: 90%;" id="vcIndustry" name="issuerInfo.vcIndustry" class="mini-treeselect"  multiSelect="false" 
										        textField="text" valueField="id" parentField="pid" checkRecursive="false" virtualScroll="true" 
										        url="com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc.biz.ext?type=2" 
										        expandOnLoad="true" showTreeIcon="false" showFolderCheckBox="true" allowInput="true"
										        onvalidation="onComboValidation"/>
	                    </td>
	                </tr> 
	                <tr>
	                    <td class="form_label" align="right" style="width: 30%;">
	                       	 所属省份:
	                    </td>
	                    <td colspan="1" > 
	                        <input class="nui-textbox"  id="vcProvince" style="width: 90%;"  name="issuerInfo.vcProvince"/>
	                    </td>
	                </tr>                     	               
	                <tr>
	                    <td class="form_label" align="right" style="width: 30%;">
	                                                                                    主体评级机构:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" style="width: 90%;" popupHeight="150px" dictTypeId="outRatingOrgan" id="vcIssueAppraiseOrgan" name="issuerInfo.vcIssueAppraiseOrgan" showNullItem="false"/>
	                    </td>
	                </tr>        
	                <tr>
	                      <td class="form_label" align="right" style="width: 30%;">
	                                                                                    所属行业(证监会二级):
	                    </td>
	                    <td colspan="1">
	                     	<input style="width: 90%;" id="vcIssueAppraiseCsrc" name="issuerInfo.vcIssueAppraiseCsrc" class="mini-treeselect"  multiSelect="false" 
										        textField="text" valueField="id" parentField="pid" checkRecursive="false" virtualScroll="true" 
										        url="com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc.biz.ext?type=1"
										        expandOnLoad="true" showTreeIcon="false" showFolderCheckBox="true" allowInput="true"
										        onvalidation="onComboValidation"/>
	                    </td>
	                </tr> 
	                <tr>
	                    <td class="form_label" align="right" style="width: 30%;">
	                       	 公司净资产(元):
	                    </td>
	                    <td colspan="1" > 
	                        <input class="nui-textbox"  id="enIssuerNetValue" vtype="float" onblur="check(this)" style="width: 90%;"  name="issuerInfo.enIssuerNetValue"/>
	                    </td>
	                </tr>                     	               
	                <tr>
	                    <td class="form_label" align="right" style="width: 30%;">
	                                                                                    城投行政级别:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" style="width: 90%;" dictTypeId="cityLevel" id="vcCityLevel" name="issuerInfo.vcCityLevel" showNullItem="false"/>
	                    </td>
	                </tr>             	               
	            </table>
              
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
    	function SetData(data,allVcIssueAppraiseCsrc,allVcIndustry) {
        	 nui.get("vcIssueAppraiseCsrc").loadList(allVcIssueAppraiseCsrc);
        	 nui.get("vcIndustry").loadList(allVcIndustry);
        	 form.setData({issuerInfo:data}); //表单数据初始化	
        	 
    	}
    	//取消
        function onCancel() {
            CloseWindow("cancel");
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
		function check(obj){  
	       var reg = new RegExp("^^[0-9]+\.?[0-9]*$");  
		   if(obj.value!=""){
		   	if(!reg.test(obj.value)){ 
		        nui.alert("请检查数据,该项只能输入数字!");  
		        return;
		    }
		   }  
	  }
        //保存
        function onOk() {
        	form.validate();
			nui.get("vcIssueNameFull").setValue(nui.get("vcIssueNameFull").getValue().replace(/\s+/g, ""));
            nui.get("vcIssueName").setValue(nui.get("vcIssueName").getValue().replace(/\s+/g, ""));
			var reg = new RegExp("^^[0-9]+\.?[0-9]*$"); // /^[1-9]+[0-9]*]*$/
			var enIssuerNetValue = nui.get("enIssuerNetValue").getValue();
			if(enIssuerNetValue!=""){
				if(!reg.test(enIssuerNetValue)){
					nui.alert("公司净资产请输入数字!");
					return;
				}
			}
			if (form.isValid() == false) {
				nui.alert("请检查必填项!");
				return;
			}
           // var vcIssuerNameChar = query(nui.get("vcIssueName").value);
           // nui.get("vcIssueNameChar").setValue(vcIssuerNameChar);
            var data = form.getData(false,true);
             var json = nui.encode(data);
             
			 $.ajax({
				url:"com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.updateIssuerInfo.biz.ext",
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
        
	     
         function onComboValidation(e) {
        var items = this.findItems(e.value);
         if (!items || items.length == 0) {
            //e.isValid = false;
            e.errorText = "输入值不在下拉数据中";
        } 
        }
    </script>
</body>
</html>