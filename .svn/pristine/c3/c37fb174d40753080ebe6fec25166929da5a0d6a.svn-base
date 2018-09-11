<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): zhangyao
  - Date: 2016-12-06 16:13:30
  - Description:
-->
<head>
    <title>产品面板</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
    html, body
    {
        font-size:12px;
        padding:0;
        margin:0;
        border:0;
        height:100%;
        overflow:hidden;
    }
    em{
    	color:#f00;
    }
    </style>
</head>
<body>
	<!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
	<input name="pageType" class="nui-hidden" /> 
    <form id="dataform1" method="post" >
    	<!-- hidden域 -->
        <input name="product.lProductNo" id="lProductNo" class="nui-hidden" />
        <fieldset style="border:solid 1px #aaa;padding:3px;margin:15px;">
            <legend >产品信息</legend>
            <div style="padding:5px;">
		        <table>
		            <tr>
		                <td style="width:120px;"><em>*</em> 配售对象编码:</td>
		                <td style="width:150px;">    
		                    <input name="product.vcRationProductCode" class="nui-textbox" required="true"/>
		                </td>
		                <td style="width:120px;"><em>*</em> 配售对象名称:</td>
		                <td style="width:150px;">                        
		                    <input name="product.vcRationProductName" class="nui-textbox" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <td style="width:120px;"><em>*</em> 对象类型:</td>
		                <td style="width:150px;">    
		                	<input name="product.vcRationProductType"
		                    	   class="nui-dictcombobox" 
		                    	   dictTypeId="ATS_IPO_RATION_TYPE"
		                    	   emptyText="---请选择---" 
		                    	   required="true"/>
		                </td>
		                <td style="width:120px;"><em>*</em> 协会编码:</td>
		                <td style="width:150px;">                        
		                    <input name="product.vcAssociationCode" class="nui-textbox" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <td style="width:120px;"><em>*</em> 沪市证券账户:</td>
		                <td style="width:150px;">    
		                    <input name="product.vcStockAccountSh" class="nui-textbox" required="true"/>
		                </td>
		                <td style="width:120px;"><em>*</em> 深市证券账户:</td>
		                <td style="width:150px;">                        
		                    <input name="product.vcStockAccountSz" class="nui-textbox" required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <td style="width:120px;"><em>*</em> 深市证券账户名称:</td>
		                <td style="width:150px;">    
		                    <input name="product.vcStockAccountSzName" class="nui-textbox" required="true"/>
		                </td>
		                <td style="width:120px;"><em>*</em> 资产类别:</td>
		                <td style="width:150px;">
		                   	<input name="product.vcAssetType"
		                    	   class="nui-dictcombobox" 
		                    	   dictTypeId="ATS_IPO_ASSET_TYPE"
		                    	   emptyText="---请选择---" 
		                    	   required="true"/>
		                </td>
		            </tr>
		            <tr>
		                <td style="width:120px;"><em>*</em>备案类型:</td>
		                <td style="width:150px;">    
		                   	<input name="product.vcRecordType"
		                    	   class="nui-dictcombobox" 
		                    	   dictTypeId="ATS_IPO_RECORD_TYPE"
		                    	   emptyText="---请选择---"
		                    	   required="true"/>
		                </td>
		                <td style="width:120px;"><em>*</em>参与类型:</td>
		                <td style="width:150px;">    
		                   	<input name="product.vcJoinType"
		                    	   class="nui-dictcombobox" 
		                    	   dictTypeId="ATS_IPO_JOIN_TYPE"
		                    	   emptyText="---请选择---"
		                    	   required="true"/>
		                </td>
		            </tr>    
		        </table>            
            </div>
        </fieldset>
        <div class="nui-toolbar" style="margin-top: 15px;" borderStyle="border:0;">
			<table width="100%">
				<tr>
					<td style="text-align: center;" colspan="4">
						<a class='nui-button' plain='false' onclick="onOk()" iconCls="icon-ok" style="width:60px;margin-right:20px;">确定</a>       
						<span style="display: inline-block; width: 25px;"></span> 
						<a class='nui-button' plain='false' onclick="onCancel()" iconCls="icon-cancel" style="width:60px;">取消</a>
					</td>
				</tr>
			</table>
		</div>
    </form>
    <script type="text/javascript">
        nui.parse();
		
		function saveData() {
			//debugger;
			var form = new nui.Form("#dataform1");
			form.setChanged(false);
			//保存
			var urlStr = "com.cjhxfund.ats.ipo.busOpr.addIpoProductInfo.biz.ext";
			var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
			//编辑
			if (pageType == "edit") {
				urlStr = "com.cjhxfund.ats.ipo.busOpr.updateIpoProduct.biz.ext";
			}
			form.validate();
			if (form.isValid() == false)
				return;

			var data = form.getData(false, true);
			var json = nui.encode(data);

			nui.ajax({
				url : urlStr,
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if (returnJson.exception == null) {
						CloseWindow("saveSuccess");
					} else {
						nui.alert("保存失败", "系统提示", function(action) {
							if (action == "ok" || action == "close") {
								//CloseWindow("saveFailed");
							}
						});
					}
				}
			});
		}

		//页面间传输json数据
		function setFormData(data) {
			//跨页面传递的数据对象，克隆后才可以安全使用
			var infos = nui.clone(data);

			//保存list页面传递过来的页面类型：add表示新增、edit表示编辑
			nui.getbyName("pageType").setValue(infos.pageType);
			//alert(infos.pageType);
			//如果是点击编辑类型页面
			if (infos.pageType == "edit") {
				var json = infos.record;

				var form = new nui.Form("#dataform1");//将普通form转为nui的form
				form.setData(json);
				form.setChanged(false);
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
			else
				window.close();
		}

		//确定保存或更新
		function onOk(){
			saveData();
		}

		//取消
		function onCancel() {
			CloseWindow("cancel");
		}
	
    </script>
</body>
</html>