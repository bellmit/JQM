<%@page import="com.cjhxfund.ats.fm.commonUtil.JDBCUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
	
<!-- 
  - Author(s): 章璐
  - Date: 2017-5-12 11:31:33
  - Description:
-->

<head>
<title>产品信息维护</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body style="width: 100%;height: 100%;overflow: hidden;">
       <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="tabs" class="nui-tabs" style="width: 100%;height: 94%;">
           <div title="产品信息" >
              <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <input class="nui-hidden"  id="lProductId"  name="productinfo.lProductId"/>
            <table style="width:100%;height:50%;table-layout:fixed;" class="nui-form-table" id="debtIssueTable">
                <tr>
	                	 <td class="form_label" align="right" width="15%">
	                          	<label style="color:red">*</label>&nbsp;业务日期:
	                    </td>
	                    <td colspan="1"  width="35%">
	                        <input class="nui-datepicker"
	                        required="true"  name="productinfo.lBusinessDate" 
	                         id="lBusinessDate" width="90%"  format="yyyy-MM-dd"/>
	                    </td>
	                    <td class="form_label" align="right" width="15%">
	                        	<span style="color:red">*</span>&nbsp;产品代码:
	                    </td>
	                    <td colspan="1"  width="35%">
	                    	 <input class="nui-textbox" 
	                    	 width="90%" id="vcProductCode" name="productinfo.vcProductCode"  required="true"
	                    	  />
	                    </td>
	            </tr>
                <tr>
	                     <td class="form_label" align="right">
	                       	<span style="color:red">*</span>&nbsp;产品简称:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-textbox" id="vcProductName" width="90%" required="true" name="productinfo.vcProductName"/>
	                    </td>
	                    <td class="form_label  requiredLable" align="right">
	                          	产品全称:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" dictTypeId="creditRating" id="vcProductCaption" width="90%" name="productinfo.vcProductCaption"/>
	                    </td>
	            </tr>
	            <!-- <tr>
	                     <td class="form_label" align="right">
	                       	<span style="color:red">*</span>&nbsp;缺省资产单元:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-dictcombobox" data="[{id:'-1',text:'默认缺省资产单元'}]" 
	                          textField="text" valueField="id" id="lDefaultAsset" width="90%" name="productinfo.lDefaultAsset" required="true"/>
	                    </td>
	                    <td class="form_label  requiredLable" align="right">
	                          	缺省组合单元:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" data="[{id:'-1',text:'默认缺省组合单元'}]" 
	                          textField="text" valueField="id" id="lDefaultCombi" width="90%" name="productinfo.lDefaultCombi"/>
	                    </td>
	            </tr> -->
	            <tr>
	                     <td class="form_label" align="right">
	                       	<span style="color:red">*</span>&nbsp;成立日期:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-datepicker" id="lOpenDate" width="90%" name="productinfo.lOpenDate" required="true" format="yyyy-MM-dd"/>
	                    </td>
	                    <td class="form_label  requiredLable" align="right">
	                          	结束日期:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-datepicker" id="lEndDate" width="90%" name="productinfo.lEndDate" format="yyyy-MM-dd"/>
	                    </td>
	            </tr>
	            <tr>
	                     <td class="form_label" align="right">
	                       	<span style="color:red">*</span>&nbsp;产品类型:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-dictcombobox"  dictTypeId="productType" id="cProductType" width="90%" name="productinfo.cProductType" required="true"/>
	                    </td>
	                    <td class="form_label  requiredLable" align="right">
	                          <label style="color:red">*</label>&nbsp;产品状态:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="productStatus" required="true" id="cProductStatus" width="90%" name="productinfo.cProductStatus" required="true"/>
	                    </td>
	            </tr>
	            <tr>
	                     <td class="form_label" align="right">
	                       	产品总份额:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-textbox" id="enProductShare" vtype="int" width="90%" name="productinfo.enProductShare"/>
	                    </td>
	                    <td class="form_label  requiredLable" align="right">
	                          	允许多投资的市场:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="creditRating"  id="vcPermitMarket" width="90%" name="productinfo.vcPermitMarket"/>
	                    </td>
	            </tr>
	            <tr>
	                   <td class="form_label  requiredLable" align="right">
	                          	投资类型:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" style="width:90%" dictTypeId="investType" id="cInvestType" width="90%" name="productinfo.cInvestType"/>
	                    </td> 
	                    <td class="form_label" align="right">
	                       	<!-- <label style="color:red">*</label>&nbsp;本币币种: -->
	                    </td>
	                    <td colspan="1">
	                    	<!-- <input class="nui-textbox" id="vcCurrencyNo" width="90%" name="productinfo.vcCurrencyNo"/> -->
	                    </td>
	            </tr>
	            <!-- <tr>
	            		这两个字段默认o
	                     <td class="form_label" align="right">
	                       	<label style="color:red">*</label>&nbsp;多币种标志:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-textbox" id="cMultiCurrency" width="90%" name="productinfo.cMultiCurrency"/>
	                    </td>
	                    <td class="form_label  requiredLable" align="right">
	                          <label style="color:red">*</label>&nbsp;资金合用标志:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" dictTypeId="creditRating" required="true" id="cCashAddup" width="90%" name="productinfo.cCashAddup"/>
	                    </td>
	            </tr> -->
	            <tr>
	            		<!-- cashControlPoint，stockControlPoint -->
	                     <td class="form_label" align="right">
	                       	头寸控制点:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-dictcombobox" dictTypeId="cashControlPoint"  id="vcCashControlPoint" width="90%" name="productinfo.vcCashControlPoint"/>
	                    </td>
	                    <td class="form_label  requiredLable" align="right">
	                          	证券控制点:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="stockControlPoint"  id="vcStockControlPoint" width="90%" name="productinfo.vcStockControlPoint"/>
	                    </td>
	            </tr>
	            <tr>
	                     <td class="form_label" align="right">
	                       	是否投顾复核:
	                    </td>
	                    <td colspan="1" class="radio-border-top-none">
	                    	<input value="0" class="nui-radiobuttonlist" data="[{id: 1, text: '是'}, {id: 0, text: '否'}]" id="cInvestAdviseCheck" width="90%" name="productinfo.cInvestAdviseCheck"/>
	                    </td>
	                    <td class="form_label  requiredLable" align="right">
	                           	是否委托人复核:
	                    </td>
	                    <td colspan="1" class="radio-border-top-none">
	                        <input value="0" class="nui-radiobuttonlist" data="[{id: 1, text: '是'}, {id: 0, text: '否'}]" id="cInvestClientCheck" width="90%" name="productinfo.cInvestClientCheck"/>
	                    </td>
	            </tr>
	            <tr>
	                     <td class="form_label" align="right">
	                       	管理人名称:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-textbox" id="vcAdminName" width="90%" name="productinfo.vcAdminName"/>
	                    </td>
	                    <td class="form_label  requiredLable" align="right">
	                          	托管人名称:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" id="vcCustodianName" width="90%" name="productinfo.vcCustodianName"/>
	                    </td>
	            </tr>
	            <tr>
	                     <td class="form_label" align="right">
	                       	运营联系人:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-textbox" id="vcOperationName" width="90%" name="productinfo.vcOperationName"/>
	                    </td>
	                    <td class="form_label  requiredLable" align="right">
	                          	运营联系电话:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox"  id="vcOperationTel" onvaluechanged="checkPhone" width="90%" name="productinfo.vcOperationTel"/>
	                    </td>
	            </tr>
	            <tr>
	                     <td class="form_label" align="right">
	                       	运营联系手机:
	                    </td>
	                    <td colspan="1">
	                    	<input class="nui-textbox" id="vcOperationPhone" onvaluechanged="checkPhone" width="90%" name="productinfo.vcOperationPhone"/>
	                    </td>
	                    <td class="form_label  requiredLable" align="right">
	                          	运营联系邮箱:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox"  id="vcOperationEmail" onvaluechanged="checkEmail" width="90%" name="productinfo.vcOperationEmail"/>
	                    </td>
	            </tr>
	            <tr>
	                     <td class="form_label" align="right">
	                       	备注:
	                    </td>
	                    <td colspan="3">
	                    	<input class="nui-textarea" id="vcRemarks" width="96%" name="productinfo.vcRemarks"/>
	                    </td>
	            </tr>
                
            </table>
	        </div>
           </div>
        </div>
        <div class="nui-toolbar" style="border:0; top:0px">
		    <table style="width:100%;">
		       <tr>
		           <td style="text-align:center;">
		               	<a class='nui-button' plain='false' style="width:60px;" iconCls="icon-save" onclick="onOk()">保存</a>
		        		<span style="display:inline-block;width:25px;"></span>
		        		<a class='nui-button' plain='false' style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
		           </td>
		       </tr>
		    </table>
		</div>   
        


	<script type="text/javascript">
    	nui.parse();
    	 
    	 nui.get("lBusinessDate").setValue((new Date()));
    	 nui.get("lOpenDate").setValue((new Date()));
    	 function saveData(){

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //保存
                var urlStr = "com.cjhxfund.ats.fm.baseinfo.ProductManager.addProductInfo.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.cjhxfund.ats.fm.baseinfo.ProductManager.updateProdcutInfo.biz.ext";
                }
                form.validate();
                if(form.isValid()==false){
                 nui.alert("页面校验不通过，请检查必输项！","",function(){});
                 return;
                }
                var vcOperationTel1=nui.get("vcOperationTel").getValue();
                var vcOperationPhone1=nui.get("vcOperationPhone").getValue();
	    	    if(checkPhone1(vcOperationTel1)==false){
					nui.alert("运营联系电话输入格式不正确,","系统提示");
					return;
			     }
			     if(checkPhone1(vcOperationPhone1)==false){
					nui.alert("运营联系手机输入格式不正确,","系统提示");
					return;
			     }
                var vcOperationEmail=nui.get("vcOperationEmail").getValue();
                if(checkEmail1(vcOperationEmail)==false){
					nui.alert("运营联系人邮箱入格式不正确,","系统提示");
					return;
			     }
                var productinfo1 = form.getData(false,true).productinfo;
                productinfo1.lOpenDate=productinfo1.lOpenDate.replace(/-/gi,'').substr(0,8);
                productinfo1.lEndDate=productinfo1.lEndDate.replace(/-/gi,'').substr(0,8);
                productinfo1.lBusinessDate=productinfo1.lBusinessDate.replace(/-/gi,'').substr(0,8);
                var data=form.getData(false,true);
                data.productinfo=productinfo1;
                var json = nui.encode(data);
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
                            nui.alert("保存失败,产品代码已存在！", "系统提示");
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
                    //校验特殊字符
					 function validName(name){
						var re=/^[A-Za-z0-9_\u554A-\u9C52]+$/;
						if(re.test(name)){
							return true;
						}else{
				        	return false; 
						}
						}
				     //校验联系电话格式
				    function checkPhone(e){
				    	var checkPhone = /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
				    	 if(e.value!="" && e.value!=null){
				    	    if(!checkPhone.test(e.value)){
								nui.alert("输入格式不正确,","系统提示");
								return false;
						     }
						   }
				    }
				     //校验联系电话格式
				    function checkPhone1(e){
				    	var checkPhone = /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
				    	 if(e!="" && e!=null){
				    	    if(!checkPhone.test(e)){
								return false;
						     }else{
						        return true;
						     }
						   }
				     }
				     function checkEmail(e){
				        var reNum =/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
				        if(e.value!="" && e.value!=null){
				    	    if(!reNum.test(e.value)){
								nui.alert("运营联系人邮箱输入格式不正确,","系统提示");
								return false;
						     }
						   }
				     }
				     //校验联系电话格式
				    function checkEmail1(e){
				    	var reNum =/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
				    	 if(e!="" && e!=null){
				    	    if(!reNum.test(e)){
								return false;
						     }else{
						        return true;
						     }
						   }
				     }
                    //页面间传输json数据
                    function setFormData(data){
                        //跨页面传递的数据对象，克隆后才可以安全使用
                        var infos = nui.clone(data);

                        //保存list页面传递过来的页面类型：add表示新增、edit表示编辑
                        nui.getbyName("pageType").setValue(infos.pageType);
                        nui.get("lOpenDate").setValue("");
                        nui.get("lEndDate").setValue("");
                        nui.get("lBusinessDate").setValue("");
                        //如果是点击编辑类型页面
                        if (infos.pageType == "edit") {
                            //禁用产品代码
                            readonlyInput("vcProductCode","vcProductCode");
                        	var json = infos.record;
                        	var form = new nui.Form("#dataform1");//将普通form转为nui的form
                        	form.setData(json);
                        	var lOpenDate=json.productinfo.lOpenDate;
				            nui.get("lOpenDate").setValue(dateTemp(lOpenDate));
				            var lEndDate=json.productinfo.lEndDate;
				            nui.get("lEndDate").setValue(dateTemp(lEndDate));
				            var lBusinessDate=json.productinfo.lBusinessDate;
				            nui.get("lBusinessDate").setValue(dateTemp(lBusinessDate));
                        }
                    }
                    //时间转换
					function dateTemp(oldData){
						oldData=oldData+"";
						if(oldData==0 || oldData=="" || oldData=="null"){
							return "";
						}
						var datas=oldData.indexOf("-");
						if(datas>=0){
							return oldData;
						}
						var yy=oldData.substr(0,4);//0开始，截取后面4位
						var mm=oldData.substr(4,2);//4开始，截取后面2位
						var dd=oldData.substr(6,2);
						
						return yy+"-"+mm+"-"+dd;
					}			
					//产品类型
					function renderProductType(e){
						return nui.getDictText("productType",e.row.cProductType);
					}
					
					//产品状态
					function renderProductStatus(e){
						return nui.getDictText("productStatus",e.row.cProductStatus);
					}
					//产品类型
					function renderCashControlPoint(e){
						return nui.getDictText("cashControlPoint",e.row.vcCashControlPoint);
					}
					
					//产品状态
					function renderStockControlPoint(e){
						return nui.getDictText("stockControlPoint",e.row.vcStockControlPoint);
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
                    /*禁用nui的input文本框，达到效果为：不可修改，可复制，置灰
					*inputNuiId nui使用的id 即 控件的id属性值
					*inputJQId jquery使用的id,jquery id不支持特殊符号 如“。”需要转义，即传入控件的id属性值转义的值
					*/
					function readonlyInput(inputNuiId,inputJQId){
						nui.get(inputNuiId).readOnly="readonly";//nui禁用
						$("#"+inputJQId+" input").attr("readonly","readonly");//解决nui禁用IE兼容
						$("#"+inputJQId+" input").css("background-color","#f0f0f0");//置灰
					}
    </script>
</body>
</html>