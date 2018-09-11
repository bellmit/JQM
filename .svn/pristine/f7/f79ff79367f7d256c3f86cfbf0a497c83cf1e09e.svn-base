<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 胥思明
  - Date: 2016-11-28 11:24:34
  - Description:
-->

<style type="text/css">
    fieldset
    {
        border:solid 1px #aaa;
    }        
    .hideFieldset
    {
        border-left:0;
        border-right:0;
        border-bottom:0;
    }
    .hideFieldset .fieldset-body
    {
        display:none;
    }
</style>
    
<head>
<title>添加债券类别映射</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	    <input name="pageType" class="nui-hidden"/>      
        <div id="dataform1" style="padding-top:5px;width: 100%;height:85%;" >
            <!-- hidden域 -->
            <table style="width:100%;height:200px;table-layout:fixed;" class="nui-form-table">
            
                <tr>
                	<td class="form_label" align="right"  style="width:90px;">
                        	<span style="color:red">*</span>&nbsp;字典名称:
                    </td>
                    <td colspan="1" style="width: 130px;">
					<input style="width: 100%;" id="vcMapFieldName" class="mini-combobox" name="dictWindMap.vcMapFieldName"  textField="COMMENTS" valueField="COMMENTS"
							url="com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.loadDictWindMap.biz.ext?tableName=T_ATS_STOCK_INFO_WIND"
						    showNullItem="false" allowInput="false" onvaluechanged="onDictValueChanged" onclick="formatValue" required="true"
						     showClose="true" oncloseclick="onCloseClickValueEmpty"/> 
        			<input class="nui-hidden"  id="vcMapFieldId"  name="dictWindMap.vcMapFieldId"/>
        			<input class="nui-hidden"  id="vcMapSource"  name="dictWindMap.vcMapSource"/>
                    </td>
       						
                    <td class="form_label" align="right"  style="width: 40px;">
                        	<span style="color:red">*</span>&nbsp;字典值:
                    </td>
                    <td colspan="1" style="width: 150px;">
					<input style="width: 100%;" required="true" id="vcMapFieldValue" class="mini-textbox" name="dictWindMap.vcMapFieldValue"/> 
                    </td>
                </tr>
                <tr>
                	<td class="form_label" align="right"  style="width: 80px;">
                        	<span style="color:red">*</span>&nbsp;(ATS)字典名称:
                    </td>
                    <td colspan="1" style="width: 130px;">
                    		<input style="width: 100%;" id="vcDicId" name="dictWindMap.vcDicId" class="mini-combobox" textField="DNAME" valueField="DID"
						    url="com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.loadDictWindMap.biz.ext" showNullItem="false" allowInput="false"
						    onvaluechanged="onDictATSChanged" showClose="true" required="true" oncloseclick="onCloseClickValueEmpty"/> 
        					<input class="nui-hidden"  id="vcDicName"  name="dictWindMap.vcDicName"/>
        					<input class="nui-hidden"  id="vcDicKey"  name="dictWindMap.vcDicKey" required="true"/>
                    </td>
                    
                    <td class="form_label" align="right"  style="width: 80px;">
                        	<span style="color:red">*</span>&nbsp;字典值:
                    </td>
                    <td colspan="1" style="width: 130px;">
                    		<input style="width: 100%;" id="vcDicKeyValue" class="mini-combobox" name="dictWindMap.vcDicKeyValue"  textField="ENAME" valueField="ENAME"
						    onvaluechanged="onDictATSKEYChanged" showNullItem="false" required="true" allowInput="false" showClose="true" oncloseclick="onCloseClickValueEmpty"/> 
                    </td>
                </tr>
                <tr>
                	<!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
		         
                	<td class="form_label" align="right"  style="width: 80px;">
                        	(辅助)字典名称:
                    </td>
                    <td colspan="1" style="width: 130px;">
                    		<input style="width: 100%;" id="vcFirstDicId" class="mini-combobox" name="dictWindMap.vcFirstDicId"  textField="DNAME" valueField="DID"
						    url="com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.loadDictWindMap.biz.ext" showNullItem="false" allowInput="false"
						    disabled="true" DropDownConut="3" onvaluechanged="onDictATSChangeds"  showClose="true" oncloseclick="onCloseClickValueEmpty"/> 
						    <input class="nui-hidden"  id="vcFirstDicKey"  name="dictWindMap.vcFirstDicKey"/>
        					<input class="nui-hidden"  id="vcFirstDicName"  name="dictWindMap.vcFirstDicName"/> 
                    </td>
                    <td class="form_label" align="right"  style="width: 80px;">
                        	字典值:
                    </td>
                    <td colspan="1" style="width: 130px;">
                    		<input style="width: 100%;" id="vcFirstDicKeyValue" class="mini-combobox" name="dictWindMap.vcFirstDicKeyValue"  textField="ENAME" valueField="ENAME"
						    onvaluechanged="onDictATSKEYChangeds" showNullItem="false" allowInput="false" showClose="true" oncloseclick="onCloseClickValueEmpty"/>
                    </td>
                   <!-- <td class="form_label" align="right"  style="width: 80px;">
                        	<span style="color:red">*</span>&nbsp;字典值:
                    </td>
                    <td colspan="1" style="width: 130px;">
                    		<input style="width: 100%;" class="nui-textbox" id="vcFieldData"  name="dictMap.vcFieldData" required="true"/>
                    </td>
                   
                </tr>-->
                <tr>
                	<td class="form_label" id="rblname"  align="right">
	   					状态:
                    </td>
                    <td colspan="3" style="height: 30">
                        <div id="rbl" name="dictWindMap.cStatus" class="mini-radiobuttonlist" data="[{id : 0 , text : '启用'},{id : 1 , text : '不启用'}]"
						    textField="text" valueField="id" value="0">
						</div>  
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                                                                       说明:
                    </td>
                    <td colspan="3" style="width: 230px;">
                        <input class="nui-textarea" id="vcRemark" width="100%" height="120" name="dictWindMap.vcRemark"/>
                        <input class="nui-hidden" id="lmapid" name="dictWindMap.lMapId" />
                    </td>
                </tr>
            </table>
        </div>
	        <div class="nui-toolbar" style="border:0;">
		    <table style="width:100%;">
		       <tr>
		           <td style="text-align:center;">
		               	<a class='nui-button' plain='false' style="width:60px;" iconCls="icon-ok" onclick="onOk()">保存</a>
		        		<span style="display:inline-block;width:25px;"></span>
		        		<a class='nui-button' plain='false' style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
		           </td>
		       </tr>
		    </table>
			</div>
        <script type="text/javascript">
            nui.parse();
            function toggleFieldSet(ck, id) {
	            var dom = document.getElementById(id);
	            dom.className = !ck.checked ? "hideFieldset" : "";
        	}
       	    function onDictNameChanged(e){
       	    	//var tableName = nui.get("tableName").getValue();
       	    	var tableName = 'T_ATS_STOCK_INFO_WIND';
       	    	var dictName = nui.get("vcMapFieldName");
       	    	dictName.setValue("");
       	    	var url = "com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.loadDictWindMap.biz.ext?tableName="+tableName;
       	    	dictName.setUrl(url);
       	    }
       	    
            
            function onDictATSChanged(e){
	            var dictId = nui.get("vcDicId");
	       	    var vcDictName = nui.get("vcDicKeyValue");
            	var typeId = dictId.getValue();
	            vcDictName.setValue("");
	            var url = "com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.loadDictWindMap.biz.ext?typeId="+typeId;
	            vcDictName.setUrl(url);
	            
	            //vcDictName.select(0);
	            var data=e.source.data;
            	//获取选中产品的其他数据
            	for(var i=0;i<data.length;i++){
            		//查找选中的数据
            		if(data[i].DID==e.value){
               			 nui.get("vcDicName").setValue(data[i].DNAME);
            		}
            	}
	            
            }
            function onDictATSKEYChanged(e){
            	var data=e.source.data;
            	//获取选中产品的其他数据
            	for(var i=0;i<data.length;i++){
            		//查找选中的数据
            		if(data[i].ENAME==e.value){
               			 nui.get("vcDicKey").setValue(data[i].DICID);
            		}
            	}
            }
            
            function onDictATSChangeds(e){
	            var dictIds = nui.get("vcFirstDicId");
	       	    var vcDictNames = nui.get("vcFirstDicKeyValue");
            	var typeId = dictIds.getValue();
	            vcDictNames.setValue("");
	            var url = "com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.loadDictWindMap.biz.ext?typeId="+typeId;
	            vcDictNames.setUrl(url);
	            
	            //vcDictName.select(0);
	            var data=e.source.data;
            	//获取选中产品的其他数据
            	for(var i=0;i<data.length;i++){
            		//查找选中的数据
            		if(data[i].DID==e.value){
               			 nui.get("vcFirstDicName").setValue(data[i].DNAME);
            		}
            	}
            }
            function onDictATSKEYChangeds(e){
            	var data=e.source.data;
            	//获取选中产品的其他数据
            	for(var i=0;i<data.length;i++){
            		//查找选中的数据
            		if(data[i].ENAME==e.value){
               			 nui.get("vcFirstDicKey").setValue(data[i].DICID);
            		}
            	}
            }
            
            
            
            function onDictValueChanged(e){
            	var data=e.source.data;
            	//获取选中产品的其他数据
            	for(var i=0;i<data.length;i++){
            		//查找选中的数据
            		if(data[i].COMMENTS==e.value){
            			nui.get("vcMapFieldId").setValue(data[i].UCNAME);
            			//nui.get("vcProductName").setValue(data[i].VC_PRODUCT_NAME);
            		}
            	}	
            }
            function formatValue(e){
            	var data = e.source.data;
            	
            	for(var i = 0; i < data.length; i++){
            		if(data[i].COMMENTS.indexOf(":")>0){
            			data[i].COMMENTS = data[i].COMMENTS.substr(0,data[i].COMMENTS.indexOf(":"));
            		}
            	}
            }
            
            function onComboValidation(e){
			var items = this.findItems(e.value);
            if (!items || items.length == 0) {
                e.isValid = false;
                e.errorText = "输入值不在下拉数据中";
            }else{
            	var data=e.source.data;
            	//获取选中产品的其他数据
            	for(var i=0;i<data.length;i++){
            		//查找选中的数据
            		if(data[i].COMMENTS==e.value){
            			//nui.get("vcProductName").setValue(data[i].VC_PRODUCT_NAME);
            		}
            	}
            }
		}
		
            function saveData(){
				nui.get("vcMapSource").setValue("Wind");
                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //保存
                var urlStr = "com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.addDictWindMap.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.updateDictWindMap.biz.ext";
                }
                form.validate();
                if(form.isValid()==false) return;

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

                        //如果是点击编辑类型页面
                        if (infos.pageType == "edit") {
                        	var json = infos.record;
                        	var form = new nui.Form("#dataform1");//将普通form转为nui的form
                        	form.setData(json);
       	    				
       	    				var dictId = nui.get("vcDicId");
				       	    var vcDictName = nui.get("vcDicKeyValue");
			            	var typeId = dictId.getValue();
				            var url = "com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.loadDictWindMap.biz.ext?typeId="+typeId;
				            vcDictName.setUrl(url);
				            
				            var dictIds = nui.get("vcFirstDicId");
				       	    var vcDictNames = nui.get("vcFirstDicKeyValue");
			            	var typeIds = dictIds.getValue();
				            var url = "com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.loadDictWindMap.biz.ext?typeId="+typeIds;
				            vcDictNames.setUrl(url);
                        	//nui.get("vcMapFieldName").setValue(json.dictWindMap.vcMapFieldName);
                        	//var source = nui.get("vcMapSource");
                        	//if("O32" == json.dictWindMap.vcMapSource){
                        	//	source.setValue("01");
                        	//}
                        	var rbl = nui.get("rbl");
                        	rbl.setValue(json.dictWindMap.cStatus);
                        	
                        }
                        if (infos.pageType == "add"){
                        	document.getElementById("tr_dis").style.display = "none";
                        }
                    }
                     //类型来源联动
                    function onsorucechanged(source){
                    		var source = nui.get("source");
                    		var source_id = nui.get("source_id");
                    		source_id.setValue(source.getText());
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
                    	var form = new nui.Form("#dataform1");
                    	form.validate();
		                if(form.isValid()==false){
		                 nui.alert("页面校验不通过，请检查必输项！","",function(){});
		                 return;
		                }
                        saveData();
                    }

                    //取消
                    function onCancel() {
                        CloseWindow("cancel");
                    }
                </script>
            </body>
</html>