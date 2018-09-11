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
                    <td class="form_label" align="right"  style="width: 80px;">
                        	<span style="color:red">*</span>&nbsp;转换字段:
                    </td>
                    <td colspan="1">
                    		<input style="width: 100%;" class="nui-textbox" id="vcField"  name="dictMap.vcField" required="true"/>
                    </td>
                    <td class="form_label" align="right"  style="width: 90px;">
                        	<span style="color:red">*</span>&nbsp;转换字段名:
                    </td>
                    <td colspan="1">
                    		<input style="width: 100%;" class="nui-textbox" id="vcFieldName"  name="dictMap.vcFieldName" required="true"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label" align="right"  style="width: 80px;">
                        	<span style="color:red">*</span>&nbsp;转换数据:
                    </td>
                    <td colspan="1">
                    		<input style="width: 100%;" class="nui-textbox" id="vcFieldData"  name="dictMap.vcFieldData" required="true"/>
                    </td>
                </tr>
                <tr>
                	
                	<td class="form_label" align="right"  style="width: 80px;">
                        	<span style="color:red">*</span>&nbsp;O32字段:
                    </td>
                    <td colspan="1">
                    		<input style="width: 100%;" class="nui-textbox" id="vcO32Field"  name="dictMap.vcO32Field" required="true"/>
                    </td>
                    <td class="form_label" align="right"  style="width: 90px;">
                        	<span style="color:red">*</span>&nbsp;O32字段数据:
                    </td>
                    <td colspan="1">
                    		<input style="width: 100%;" class="nui-textbox" id="vcO32FieldData"  name="dictMap.vcO32FieldData" required="true"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label" align="right"  style="width: 80px;">
                        	条件字段名:
                    </td>
                    <td colspan="1">
                    		<input style="width: 100%;" class="nui-textbox" id="vcConditionField"  name="dictMap.vcConditionField" inputStyle="background-color:#f0f0f0;"/>
                    </td>
                    <td class="form_label" align="right"  style="width: 90px;">
                        	条件数据:
                    </td>
                    <td colspan="1">
                    		<input style="width: 100%;" class="nui-textbox" id="vcConditionData"  name="dictMap.vcConditionData" inputStyle="background-color:#f0f0f0;"/>
                    </td>
                </tr>
                
                <tr>
                	<td class="form_label" align="right"  style="width: 80px;">
                        	<span style="color:red">*</span>&nbsp;数据来源:
                    </td>
                    <td colspan="1" style="width: 50%;">
                        <input class="nui-dictcombobox" style="width: 100%;" dictTypeId="StockTypeSource" id="source" required="true" onvaluechanged="onsorucechanged"/>
                    	<input class="nui-hidden" id="source_id" name="dictMap.vcSource" />
                    </td>
                	
                </tr>
                <tr id="tr_dis">
                	<td class="form_label" id="rblname"  align="right">
	   					状态:
                    </td>
                    <td colspan="2" style="height: 30">
                        <div id="rbl" name="dictMap.cStatus" class="mini-radiobuttonlist" data="[{id : 0 , text : '启用'},{id : 1 , text : '不启用'}]"
						    textField="text" valueField="id" >
						</div>  
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                        备注:
                    </td>
                    <td colspan="3">
                        <input class="nui-textarea" id="vcRemark" width="100%" height="50" name="dictMap.vcRemark"/>
                        <input class="nui-hidden" id="lmapid" name="dictMap.lMapId" />
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
            function saveData(){

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //保存
                var urlStr = "com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.addDictMap.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.updateDictMap.biz.ext";
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
                        	form.setData(json);
                        	var source = nui.get("source");
                        	if("O32" == json.dictMap.vcSource){
                        		source.setValue("01");
                        	}
                        	var rbl = nui.get("rbl");
                        	rbl.setValue(json.dictMap.cStatus);
                        	
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
                        saveData();
                    }

                    //取消
                    function onCancel() {
                        CloseWindow("cancel");
                    }
                </script>
            </body>
</html>