<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common.jsp" %>
<html>
<!-- 
  - Author(s): 陈迪
  - Date: 2016-11-23 15:48:48
  - Description:
-->
<head>
<title>新增产品参数管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>
	<!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
	<input name="pageType" class="nui-hidden"/>
	<div id="formAddProductConf" style="padding-top:5px;width: 100%;height:85%;" >
	    <!-- hidden域 -->
	    <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
	        <tr>
	            <td class="form_label" align="right">
	            产品名称:
	            </td>
	            <td colspan="3">
		    					<input name="productConf.vcProductId" class="nui-combobox" id="product_id"
			                   textField="TEXT" valueField="ID"
			                   url="com.cjhxfund.commonUtil.applyInstUtil.queryTAtsProductInfo.biz.ext?queryType=1"
			                   showNullItem="false"
			                   showClose="true"
												 emptyText="请选择..."
												 nullItemText="请选择..."
												 valueFromSelect="true"
												 allowInput="true"
												 oncloseclick="onCloseClick"
												 onvaluechanged="selectFund"
												 required="true"
			                   style="width:80%;"/>
	            	<span style="color:red">*</span>
	            </td>
	        </tr>
	        <tr>
	        		<td class="form_label" align="right">
	            产品参数项:
	          	</td>
	          	<td colspan="3">
               		<input id="conf_code" name="productConf.vcConfCode" class="nui-dictcombobox"
 								 		valueField="dictID" textField="dictName" style="width:80%;" dictTypeId="productConfCode"
 								 		showNullItem="true" emptyText="请选择..." nullItemText="请选择..." 
 								 		showClose="true" oncloseclick="onCloseClick" required="true"/>
 								 	<span style="color:red">*</span>
            	</td>
	        </tr>
	        <tr id="tr_dis">
	        		<td class="form_label" id="rblname"  align="right">
	   	参数值:
	            </td>
	            <td colspan="3" style="height: 30">
	            		<input style="width: 80%;" id="conf_value" class="nui-textbox" name="productConf.vcConfValue" required="true" />    
	            		<span style="color:red">*</span>
	            </td>
	        </tr>
	        <tr>
	            <td class="form_label" align="right">
	             描述:
	            </td>
	            <td colspan="3">
	                <input class="nui-textarea" id="conf_desc" width="80%" height="50" name="productConf.vcConfDesc" />
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
	//页面间传输json数据，此方法在主页面开始调用
  	function setFormData(data){	
	  	//跨页面传递的数据对象，克隆后才可以安全使用
	  	var infos = nui.clone(data);
	    //保存list页面传递过来的页面类型：add表示新增、edit表示编辑
	    nui.getbyName("pageType").setValue(infos.pageType);
    }
    //保存业务
    function saveData(){
        var form = new nui.Form("#formAddProductConf");
        //新增业务保存的逻辑流路径
        var urlStr = "com.cjhxfund.commonUtil.productConfManage.addProductConf.biz.ext";
        //获取当前页面是编辑还是新增状态
    	form.validate();
    	if(form.isValid()==false) return;
        var data = form.getData(false,true);
        var json = nui.encode(data);
        nui.ajax({
            url:urlStr,
            type:'POST',
            data:json,
            cache:false,
            contentType:'text/json',
            success:function(text){
            debugger;
            var returnJson = nui.decode(text);
	            if(returnJson.exception == null){
	                nui.alert("保存成功", "系统提示", function(action){
	                	CloseWindow("saveSuccess");
					});
	            }else{
	            	
	                nui.alert("该产品参数已存在，请核对！！", "系统提示", function(action){
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
		//页面X的删除功能
		function onCloseClick(e) {
		    var obj = e.sender;
		    obj.setText("");
		    obj.setValue("");
		}
		//取消
		function onCancel() {
		    CloseWindow("cancel");
		}
		
</script>
</body>
</html>