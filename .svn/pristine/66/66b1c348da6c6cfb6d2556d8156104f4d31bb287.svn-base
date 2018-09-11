<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common.jsp"%>
<html>
<!-- 
  - Author(s): chendi
  - Date: 2017-06-13 16:19:50
  - Description:
-->
<head>
<title>新增现金流水记录</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
</head>
<body>
	<!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
	<input name="pageType" class="nui-hidden"/>
	<div id="form_AddAdjCashflow" style="padding-top:5px;width: 100%;height:89%;" >
	    <!-- hidden域 -->
	    <!-- 产品编号 -->
	    <input id="lProductId" name="cashFlow.lProductId" class="nui-hidden" value=""/>
	    <!-- 资产单元编号 -->
	    <input id="lAssetId" name="cashFlow.lAssetId" class="nui-hidden" value=""/>
	    <!-- 调整时间 -->
	    <input id="dAdjustTime" name="cashFlow.dAdjustTime" class="nui-hidden" value=""/>
	    <!-- 资金变动日期 -->
	    <input id="lDate" name="cashFlow.lDate" class="nui-hidden" value=""/>
	    <!-- 产品名称 -->
	    <input id="vcProductName" name="cashFlow.vcProductName" class="nui-hidden" value=""/>
	    <!-- 资产单元名称 -->
	    <input id="vcAssetName" name="cashFlow.vcAssetName" class="nui-hidden" value=""/>
	    <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
	        <tr>
	            <td class="form_label" align="right">
    	产品名称:
	            </td>
	            <td colspan="3">
					<div name="cashFlow.vcProductCode" class="nui-combobox" id="vcProductCode"
	                    textField="TEXT" valueField="ID"
	                    searchField="productCode"
	                    url="com.cjhxfund.commonUtil.applyInstUtil.QueryTAtsProductInfoMatch.biz.ext?queryType=1"
	                    allowInput="true" 
	                    required="true"
						emptyText="请输入产品代码或产品名称..."
						nullItemText="请输入产品代码或产品名称..."
						valueFromSelect="true"
						showClose="true"
						onvaluechanged="selectAssets"
						style="width:240px"
						oncloseclick="onCloseClick"
						popupWidth="300">
						<div property="columns">
                            <div header="产品代码" field="ID" width="40px"></div>
                            <div header="产品名称" field="TEXT"></div>
                        </div>
                     </div>
                     <span style="color:red">*</span>
	            </td>
	        </tr>
	        <tr>
	        	<td class="form_label" align="right">
	            单元名称:
	            </td>
	        	<td colspan="3">
					<div name="cashFlow.vcAssetCode" class="nui-combobox" id="vcAssetCode"
	                	textField="TEXT" valueField="ID"
		                dataField="data"
                   	    showNullItem="false"
                   	    allowInput="false"
                        required="true"
                        emptyText="请选择..."
                        nullItemText="请选择..."
                        valueFromSelect="true"
                        showClose="true"
                        onvaluechanged="changeAsset"
		                oncloseclick="onCloseClick"
                        style="width:240px">
                    </div>
	            	<span style="color:red">*</span>
            	</td>
	        </tr>
	        <tr id="tr_dis">
        		<td class="form_label" id="rblname"  align="right">
	   	资金变动日期:
	            </td>
	            <td colspan="3" style="height: 30">
            		<input style="width:240px" id="preDate" class="nui-datepicker" name="cashFlow.preDate" format="yyyy-MM-dd" allowInput="false" required="true"/>    
            		<span style="color:red">*</span>
	            </td>
	        </tr>
	        <tr id="tr_dis">
        		<td class="form_label" id="rblname"  align="right">
	   	调整金额(元):
	            </td>
	            <td colspan="3" style="height: 30">
            		<input style="width:240px;" id="enAdjustAmount" class="nui-textbox" name="cashFlow.enAdjustAmount" required="true"/>    
            		<span style="color:red">*</span>
	            </td>
	        </tr>
	        <tr id="tr_dis">
	            <td class="form_label" align="right">
	             调整原因:
	            </td>
	            <td colspan="3">
	                <input class="nui-textarea" id="vcAdjustRemark" style="width:240px;height:50px" name="cashFlow.vcAdjustRemark" />
	            </td>
	        </tr>
	    </table>
	</div>
	<div class="nui-toolbar" style="padding:0px;height:9%;" borderStyle="border:0;">
	    <table style="width:100%;">
	       <tr>
	           <td style="text-align:center;">
	               	<a class='nui-button' plain='false' style="width:60px;" iconCls="icon-ok" onclick="onOk()">确定</a>
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
    	//设置调整日期
    	nui.get("lDate").setValue(DateUtil.toNumStr(nui.get("preDate").getValue()));
        var form = new nui.Form("#form_AddAdjCashflow");
        //新增业务保存的逻辑流路径
        var urlStr = "com.cjhxfund.jy.ProductProcess.CashFlow.addAdjCashflow.biz.ext";
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
            var returnJson = nui.decode(text);
	            if(returnJson.rtnCode == "0"){
	                nui.alert("保存成功", "系统提示", function(action){
	                	CloseWindow("saveSuccess");
					});
	            }else if(returnJson.rtnCode == "2"){
	                nui.alert("该记录已存在，如需修改请在主页面点击修改按钮进行操作！", "系统提示", function(action){
	                	CloseWindow("saveFailed");
					});
	            }else{
	            	nui.alert("保存异常！", "系统提示", function(action){
	                	CloseWindow("saveFailed");
					});
	            }
        	}
    	});
	}
	//关闭窗口
	function CloseWindow(action) {
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
	    obj.setText(null);
	    obj.setValue(null);
	    obj.setIsValid(false);
  	    obj.doValueChanged();
	}
	//取消
	function onCancel() {
	    CloseWindow("cancel");
	}
	//产品联动带出资产单元方法
	function selectAssets(e){
 		var fundCodeCombo = nui.get("vcProductCode").value;
		var vcAssetCombo = nui.get("vcAssetCode");
		if(fundCodeCombo!=null && fundCodeCombo!=""){
			nui.ajax({
	    		data:{vcProductCode:fundCodeCombo},
	    		url:"com.cjhxfund.jy.ProductProcess.CashFlow.queryAssetInfo.biz.ext?queryType=1",
	    		success:function(resp){
	    			var returnJson = nui.decode(resp);
					if(returnJson.exception == null){
	             		if(resp.data){
                			vcAssetCombo.load(resp.data);
                			if(typeof e === "object"){
                				vcAssetCombo.select(0);
                				nui.get("vcAssetName").setValue(resp.data[0].TEXT);
                				nui.get("lAssetId").setValue(resp.data[0].L_ASSET_ID);
                			}else{
                				//vcAssetCombo.setValue(e);
                			}
                			//赋值给产品编号和资产单元编号
                			nui.get("lProductId").setValue(e.selected.L_PRODUCT_ID);
                			nui.get("vcProductName").setValue(e.selected.TEXT);
             	 		}
					}else{
						nui.alert("系统异常","系统提示");
					}
	        	},
		        //有错误码之后，把后面的错误提醒补齐。
		        fail:function(resp){
		            alert(resp);
		        }
    		});
		}else{
			vcAssetCombo.setValue(e);
			//nui.get("lAssetId").setValue(resp.data.selected.L_ASSET_ID);
			//nui.get("vcProductName").setValue(e.selected.TEXT);
			//nui.get("vcAssetName").setValue(resp.data.selected.TEXT);
		}	
	};
	//改变资产单元框触发事件
	function changeAsset(e){
		nui.get("lAssetId").setValue(e.selected.L_ASSET_ID);
		nui.get("vcAssetName").setValue(e.selected.TEXT);
	}
		
</script>
</body>
</html>