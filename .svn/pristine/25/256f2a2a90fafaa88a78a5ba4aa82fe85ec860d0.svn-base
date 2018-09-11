<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
	
<!-- 
  - Author(s): 章璐
  - Date: 2016-10-14 17:31:33
  - Description:
-->
<head>
<title>添加债券类别映射</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;width: 100%;height:85%;" >
            <!-- hidden域 -->
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td class="form_label" align="right"  style="width: 130px;">
                        	<span style="color:red">*</span>&nbsp;债券类别名称:
                    </td>
                    <td colspan="3">
                    	<input style="width: 100%;" id="vcStockType" name="stockTypeMap.vcStockType"  class="mini-treeselect"  multiSelect="false"  dataField="data"
										        textField="text" valueField="id" parentField="pid" checkRecursive="false" onbeforenodeselect="beforenodeselect"
										        url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext" emptyText="全部" nullItemText="全部"
										        showFolderCheckBox="true"   expandOnLoad="true" showTreeIcon="false" showClose="true" required="true"
										        oncloseclick="onCloseClickValueEmpty" />
                        <!-- <input class="nui-combobox" name="stocktypedefineentity.vcStockType"/>-->
                    </td>
                </tr>
                <tr>
                	<td class="form_label" align="right"  style="width: 130px;">
                        	<span style="color:red">*</span>&nbsp;数据来源:
                    </td>
                    <td colspan="1" style="width: 50%;">
                        <input class="nui-dictcombobox" style="width: 100%;" dictTypeId="StockTypeSource" id="type_source" required="true" onvaluechanged="onsorucechanged"/>
                    <input class="nui-hidden" id="source_id_h" name="stockTypeMap.vcSource" />
                    </td>
                	<td class="form_label" align="right"  style="width: 80px;">
                        	交易市场:
                    </td>
                    <td colspan="1" style="width: 40%;">
                        <input class="nui-dictcombobox" id="marketid"
                        textField="text" valueField="id" style="width: 100%;" onvaluechanged="onmarketchanged"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label" align="right">
        				<span style="color:red">*</span>&nbsp;映射证券类别名称:
                    </td>
                    <td colspan="1" style="width: 30%;">
                        <input style="width: 100%;" popupHeight="160" id="type_id" class="nui-combobox" textField="vcStocktypeName" valueField="cStockType" required="true" onvaluechanged="ontypechanged"/>
                    <input class="nui-hidden" id="type_id_h" name="stockTypeMap.vcStockTypeName"/>
                    </td>
                	 <td class="form_label" align="right">
	   					映射证券类别:
                    </td>
                    <td colspan="1" style="width: 30%;">
                        <input style="width: 100%;" id="type_name" class="nui-textbox" name="stockTypeMap.vcStockTypeId" readonly="readonly" inputStyle="background-color:#f0f0f0;"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                      	杂项分类名称:
                    </td>
                    <td colspan="3" style="width: 60%;">
                        <input style="width: 100%;" popupHeight="150" id="detail_id"  class="nui-combobox" textField="Dictname" valueField="Dictid" multiSelect="true" showClose="true" oncloseclick="onCloseClickValue" onvaluechanged="ondetailchanged"/>
                    	<input class="nui-hidden" id="detail_id_h" name="stockTypeMap.vcStockTypeDtlname" />
                    </td>
                    
                </tr>
                <tr>
                	<td class="form_label" align="right">
                        	杂项分类:
                    </td>
                    <td colspan="1">
                        <input style="width: 100%;" id="detail_name" class="nui-textbox" name="stockTypeMap.vcStockTypeDtl" readonly="readonly" inputStyle="background-color:#f0f0f0;"/>
                    </td>
                </tr>
                <tr id="tr_dis">
                	<td class="form_label" id="rblname"  align="right">
	   					状态:
                    </td>
                    <td colspan="2" style="height: 30">
                        <div id="rbl" name="stockTypeMap.cStatus" class="mini-radiobuttonlist" data="[{id : 0 , text : '启用'},{id : 1 , text : '不启用'}]"
						    textField="text" valueField="id" >
						</div>  
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                        备注:
                    </td>
                    <td colspan="3">
                        <input class="nui-textarea" id="vcRemark" width="100%" height="50" name="stockTypeMap.vcRemark"/>
                   	<input class="nui-hidden" id="lmapid" name="stockTypeMap.lMapId" />
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
			var detail_id = nui.get("detail_id");
        	var detail_id_h = nui.get("detail_id_h");
        	var detail_name = nui.get("detail_name");
    		var type_id = nui.get("type_id");
        	var type_id_h = nui.get("type_id_h");
        	var type_name = nui.get("type_name");
        	var type_source = nui.get("type_source");
    		var source_id_h = nui.get("source_id_h");
    		var marketid = nui.get("marketid");
    		var rbl = nui.get("rbl");
            function saveData(){

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //保存
                var urlStr = "com.cjhxfund.ats.fm.baseinfo.stockTypeManager.addStockTypeMap.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.cjhxfund.ats.fm.baseinfo.stockTypeManager.updateStockTypeMap.biz.ext";
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
                            CloseWindow("saveSuccess");
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
                            if(json.stockTypeMap.vcSource = "O32"){
                            	onsorucechanged(json.stockTypeMap.vcSource);
                            	type_source.setValue("01");
                            }
                            //给表单赋值
                           	type_source.setReadOnly("true");
                           	var vcStockType = nui.get("vcStockType");
                           	vcStockType.setValue(json.stockTypeMap.vcStockType);
                           	vcStockType.setReadOnly("true");
                           	type_id.setValue(json.stockTypeMap.vcStockTypeId);
                           	var str = "";
                           	if(json.stockTypeMap.vcStockTypeDtl != null){
                           		for(var i=0;i<=(json.stockTypeMap.vcStockTypeDtl).length;i++){
                           		var c = json.stockTypeMap.vcStockTypeDtl.substring(i,i+1);
                           		str = str + c + ",";
                           		}
                           	str = str.substring(0, str.length-2);
                           	}
                           	detail_id.setValue(str);
                           	type_name.setValue(json.stockTypeMap.vcStockTypeId);
                           	detail_name.setValue(json.stockTypeMap.vcStockTypeDtl);
                           	var vcRemark = nui.get("vcRemark");
                           	vcRemark.setValue(json.stockTypeMap.vcRemark);
                           	var lmapid = nui.get("lmapid");
                           	source_id_h.setValue(json.stockTypeMap.vcSource);
                           	type_id_h.setValue(json.stockTypeMap.vcStockTypeIdName);
                           	detail_id_h.setValue(json.stockTypeMap.vcStockTypeDtlname);
                           	lmapid.setValue(json.stockTypeMap.lMapId);
                           	rbl.setValue(json.stockTypeMap.cStatus);
                            form.setChanged(false);
                        }
                        if (infos.pageType == "add"){
                        	type_source.setValue("01"); //默认数据源为O32
                        	onsorucechanged("01");
                        	 document.getElementById("tr_dis").style.display = "none";
                        }
                    }
                    
                    //类型来源联动
                    function onsorucechanged(source){
                    	if(type_source.getValue() == "01" || source == "O32"){
                    		source_id_h.setValue(type_source.getText());
                    		marketid.setData("[{id:'1',text:'上交所A'}, {id:'2', text: '深交所A'},{id:'5', text: '银行间'}]");
							type_id.load("com.cjhxfund.ats.fm.baseinfo.stockTypeManager.queryO32StockType.biz.ext");
                    		detail_id.load("com.cjhxfund.ats.fm.baseinfo.stockTypeManager.queryO32Detail.biz.ext"); 
                    	}
                    }
                    function onmarketchanged(){
                    		var url = "com.cjhxfund.ats.fm.baseinfo.stockTypeManager.queryO32StockType.biz.ext?id="+marketid.getValue();
							type_id.load(url);
                    		detail_id.load("com.cjhxfund.ats.fm.baseinfo.stockTypeManager.queryO32Detail.biz.ext");               	
                    }
                    function onCloseClickValue(){
                    	detail_id.setValue("");
                    	detail_name.setValue("");
                    }
                    
                    //类型改变联动名字
                    function ontypechanged(){
                    	type_id_h.setValue(type_id.getText());
                    	type_name.setValue(type_id.getValue());
                    }
                    //明细改变联动名字
                    function ondetailchanged(){
                    	detail_id_h.setValue(detail_id.getText().replace(/,/g,"-"));
                    	detail_name.setValue(detail_id.getValue().replace(/,/g,""));
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
					function beforenodeselect(e) {
		            //禁止选中父节点
		            if (e.isLeaf == false) e.cancel = true;
		        	}
                    //取消
                    function onCancel() {
                        CloseWindow("cancel");
                    }
                </script>
            </body>
</html>