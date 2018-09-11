<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 胥思明
  - Date: 2016-11-10 15:04:18
  - Description:
-->
<head>
<title>添加账户信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<%@include file="/common/js/commscripts.jsp" %>
    
    
</head>
<body style="width: 100%;height: 90%;overflow: hidden;">
<!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
         <div style="padding-top:5px;width: 100%;height:100%;">
        <div id="dataform1" style="padding-top:5px;width: 100%;height:90%;" >
            <!-- hidden域 -->
            <input class="nui-hidden"  id="lAccountId"  name="accountInfo.lAccountId"/>
            <input class="nui-hidden"  id="cSource"  name="accountInfo.cSource" />
            <input class="nui-hidden"  id="cStatus"  name="accountInfo.cStatus" />
            <table style="width:100%;height:150px;table-layout:fixed;" class="nui-form-table">
                <tr style="width:100%;height:55%;">
                    <td class="form_label" align="right"  style="width: 130px;">
                        	<span style="color:red">*</span>&nbsp;产品名称:
                    </td>
					  <td colspan="3">
						  	<input style="width:595px;" id="vcProductName" multiSelect="true" class="mini-combobox" name="accountInfo.vcProductName"  textField="TEXT" valueField="TEXT" 
								    url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryTAtsProductInfo.biz.ext"    showNullItem="false" required="true" allowInput="false"
								     emptyText="请选择"  showClose="true" oncloseclick="productEmpty" onvaluechanged="onComboValidation"/> 
						  	<!--input class="nui-hidden" type="hidden" id="vcProductCode"  name="accountInfo.vcProductCode"/-->
					  </td>
                </tr>
                <tr>
                    <td style="width: 130px;" align="right"><span style="color:red">*</span>产品代码:</td>
                    <td colspan="3">
                    	<input id="productCode" multiSelect="true" name="accountInfo.vcProductCode" style="width: 595px;"  class="nui-textbox" readonly="true" inputStyle="background-color:#f0f0f0;" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right"  style="width: 80px;">
                        	<span style="color:red">*</span>&nbsp;账户名称:
                    </td>
                    <td colspan="1">
                    		<input style="width: 180px;" class="nui-textbox" id="vcAccountName"  name="accountInfo.vcAccountName" required="true"/>
                    </td>
                	<td class="form_label" align="right"  style="width: 90px;">
	   					<span style="color:red">*</span>&nbsp;账户号码:
                    </td>
                    <td colspan="1">
                       <input style="width: 180px" onvaluechanged="check(this.value)"  class="nui-textbox" id="vcAccountNo" name="accountInfo.vcAccountNo" required="true"/>  

                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right"  style="width: 100px;">
                        	<span style="color:red">*</span>&nbsp;账户类型:
                    </td>
                    <td colspan="1">
                    		<input  emptyText="请选择" style="width:180px;" showClose="true" oncloseclick="onCloseClickValueEmpty" class="mini-combobox" required="true" data="[{ id: 1, text: '证券账户' }, { id: 2, text: '银行间'}, { id: 3, text: '托管账户'}, { id: 4, text: '机构间账户'}]" id="vcAccountType2"  name="accountInfo.vcAccountType" 
                    		textField="text" valueField="id"  onitemclick="onAccountTypeChanged" />
                    </td>
                    <td class="form_label" align="right" width="140px;" id="paymentPlaceL">
                        <span style="color:red">*</span>&nbsp;登记托管机构: 
                    </td>
	                <td colspan="1" id="paymentPlace">
	                        <input class="nui-dictcombobox"  emptyText="请选择"
		                        dictTypeId="CF_JY_DJTGCS" valueField="dictID" textField="dictName"
		                        name="accountInfo.vcPaymentPlace"  showClose="true" oncloseclick="paymentEmpty" 
		                         id="vcPaymentPlace2"   style="width:180px;" onitemclick="onPaymentPlaceChanged" required="true"/>
	                </td>
                </tr>
                <tr id="seatL">
                    <td class="form_label" style="width: 180px;" align="right" >
                                                                                  托管券商席位号(上海):
                    </td>
                    <td  colspan="1" >
                         <input style="width: 180px;"  class="nui-textbox" id="vcTrusteeSeatNoSh"  name="accountInfo.vcTrusteeSeatNoSh" /> 
                    </td>
                    <td class="form_label" align="right"  style="width: 180px;" >
                        	 托管券商席位号(深圳):
                    </td>
                    <td colspan="1" >
                    		<input style="width: 180px;" class="nui-textbox" id="vcTrusteeSeatNoSz"  name="accountInfo.vcTrusteeSeatNoSz" />
                    </td>
                </tr>
                <tr id="markAll">
                     <td class="form_label" align="right">
                         	托管所:
                    </td>
                    <td>
                         <input style="width: 180px;" class="nui-textbox" id="vcTrusteePlace"  name="accountInfo.vcTrusteePlace" /> 
                    </td>
                    <td class="form_label" align="right"  style="width: 80px;">
                        	大额支付号:
                    </td>
                    <td colspan="1">
                    		<input style="width: 180px;" class="nui-textbox" id="vcLargePaymentNo"  name="accountInfo.vcLargePaymentNo"/>
                    </td>
                </tr>
                <tr id="vcBankL">
                  <td class="form_label" align="right" >
                         	资金账户:
                    </td>
                    <td colspan="3">
                         <input style="width: 180px;" class="nui-textbox" id="vcBankAccount"  name="accountInfo.vcBankAccount" /> 
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                                                                                              备注:
                    </td>
                    <td colspan="3">
                         <input class="nui-textarea" id="vcRemarks" width="100%" height="50" name="accountInfo.vcRemarks"/>
                    </td>
                </tr>
            </table>
        </div>
        </div>
        
        <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
	         <table style="width:100%;height:100%; padding:0px;">
	             <tr style="widht:100%; height:100%;">
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
    	
    	function onComboValidation(e){
			var items = this.findItems(e.value);
            if (!items || items.length == 0) {
                e.isValid = false;
                e.errorText = "输入值不在下拉数据中";
            }else{
            	var selects = e.selecteds;
            	var productName = "";
            	var productCode = "";
            	for(var i=0;i<selects.length;i++){
            	  productCode += selects[i].VC_PRODUCT_CODE+",";
            	  productName +=  selects[i].VC_PRODUCT_NAME+",";
            	}
            	productName = productName.substring(0, productName.length-1);
            	productCode = productCode.substring(0, productCode.length-1);
            	nui.get("vcProductName").setValue(productName);
            	//nui.get("vcProductCode").setValue(productCode);
            	nui.get("productCode").setValue(productCode);
            }
		}
		
		function check(num){  
        if(isNum(num)){
        }else{
            nui.alert("输入格式不正确,请输入数字");
            nui.get("vcAccountNo").setValue("");
            return false;
        }
	    } 
	    function isNum(num){
	       var reNum =/^[0-9]+$/;
	       return (reNum.test(num));
	    }
		
		function onAccountTypeChanged(e) {
	        if(e.item.id == '4'){
	          nui.get("vcPaymentPlace2").setValue(99);
		       document.getElementById( "seatL").style.display= "none"; 
		       document.getElementById( "markAll").style.display= "none"; 
		       document.getElementById( "vcBankL").style.display= ""; 
		       
		       nui.get("vcTrusteeSeatNoSz").setValue("");
		       nui.get("vcTrusteeSeatNoSh").setValue("");
		       nui.get("vcLargePaymentNo").setValue("");
		       nui.get("vcTrusteePlace").setValue("");
	        }else if(e.item.id == '3'){
	           nui.get("vcPaymentPlace2").setValue("");
	           document.getElementById( "seatL").style.display= "none"; 
		       document.getElementById( "markAll").style.display= ""; 
		       document.getElementById( "vcBankL").style.display= "none"; 
		      
		       nui.get("vcTrusteeSeatNoSz").setValue("");
		       nui.get("vcTrusteeSeatNoSh").setValue("");
		       nui.get("vcBankAccount").setValue("");
	        }else if(e.item.id == '2'){
	           nui.get("vcPaymentPlace2").setValue("");
	           document.getElementById( "seatL").style.display= "none"; 
		       document.getElementById( "markAll").style.display= "none"; 
		       document.getElementById( "vcBankL").style.display= "none"; 
	          
	           nui.get("vcTrusteeSeatNoSz").setValue("");
	           nui.get("vcTrusteeSeatNoSh").setValue("");
	           nui.get("vcTrusteePlace").setValue("");
	           nui.get("vcLargePaymentNo").setValue("");
		       nui.get("vcBankAccount").setValue("");
	        }else if(e.item.id == '1'){
	           nui.get("vcPaymentPlace2").setValue("");
		       document.getElementById( "seatL").style.display= ""; 
		       document.getElementById( "markAll").style.display= "none"; 
		       document.getElementById( "vcBankL").style.display= "none"; 
		       
		       nui.get("vcTrusteePlace").setValue("");
	           nui.get("vcLargePaymentNo").setValue("");
		       nui.get("vcBankAccount").setValue("");
	        }
        }
	    function onPaymentPlaceChanged(e) {
	        if(e.item.dictID == '99'){
	         nui.get("vcAccountType2").setData("[{ id: 3, text: '托管账户'}, { id: 4, text: '机构间账户'}]");
           }else{
             nui.get("vcAccountType2").setData("[{ id: 1, text: '证券账户' }, { id: 2, text: '银行间'}, { id: 3, text: '托管账户'}, { id: 4, text: '机构间账户'}]");
           }
           
            if(nui.get("vcAccountType2").getValue() == 4){
	          if(nui.get("vcPaymentPlace2").getValue() != 99){
	             nui.get("vcAccountType2").setValue("");
	          }
	            nui.get("vcAccountType2").setValue("");
	          }
	          
        }
        function paymentEmpty(){
             nui.get("vcPaymentPlace2").setValue("");
             nui.get("vcAccountType2").setData("[{ id: 1, text: '证券账户' }, { id: 2, text: '银行间'}, { id: 3, text: '托管账户'}, { id: 4, text: '机构间账户'}]");
        }
        function productEmpty(){
	        nui.get("vcProductName").setValue("");
	        nui.get("productCode").setValue("");
        }
    	 function saveData(){

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //保存
                var urlStr = "com.cjhxfund.ats.fm.baseinfo.ApplyTemplet.addAccountInfo.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.cjhxfund.ats.fm.baseinfo.ApplyTemplet.updateAccountInfo.biz.ext";
                }
                form.validate();
                if(form.isValid()==false){
                  nui.alert("请检查必填项!");
                  return;
                } 

                var data = form.getData(false,true);
                var json = nui.encode(data);

                $.ajax({
                    url:urlStr,
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                            nui.alert("保存成功", "系统提示", function(action){
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

                        //保存list页面传递过来的页面类型：add表示新增、edit表示编辑
                        nui.getbyName("pageType").setValue(infos.pageType);
                        nui.get("cSource").setValue("1");
                        nui.get("cStatus").setValue("2");
                        
                        //如果是点击编辑类型页面
                        if (infos.pageType == "edit") {
                        	var json = infos.record;
                        	//console.log(json);
                        	var form = new nui.Form("#dataform1");//将普通form转为nui的form
                        	form.setData(json);
                        	var formType=json.accountInfo.vcAccountType;
                           	if(formType == '4'){
							       document.getElementById( "seatL").style.display= "none"; 
							       document.getElementById( "markAll").style.display= "none"; 
							       document.getElementById( "vcBankL").style.display= ""; 
							       
						        }else if(formType == '3'){
						           document.getElementById( "seatL").style.display= "none"; 
							       document.getElementById( "markAll").style.display= ""; 
							       document.getElementById( "vcBankL").style.display= "none"; 
							      
						        }else if(formType == '2'){
						           document.getElementById( "seatL").style.display= "none"; 
							       document.getElementById( "markAll").style.display= "none"; 
							       document.getElementById( "vcBankL").style.display= "none"; 
						          
						        }else if(formType == '1'){
							       document.getElementById( "seatL").style.display= ""; 
							       document.getElementById( "markAll").style.display= "none"; 
							       document.getElementById( "vcBankL").style.display= "none"; 
						        }
                        }
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
        
                    //取消
                    function onCancel() {
                        CloseWindow("cancel");
                    }
    </script>
</body>
</html>