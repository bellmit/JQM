<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

<div title="产品信息" id="productInfoPanel" class="nui-panel" iconCls="icon-edit" style="width:100%;" showCollapseButton="true" collapseOnTitleClick="true">
	<div style="padding-top:5px;" id="productInfoForm" class="nui-form">
		<table style="width: 100%; table-layout: fixed;" class="nui-form-table">
			<tr>
				<td class="form_label td1" width="17%" align="right">产品名称:</td>
				<td colspan="1" width="16%">
					<input name="productInfo.vcProductName" width="95%" class="nui-textbox" readonly />
				</td>
				<td class="form_label td1" width="17%" align="right">产品类型:</td>
				<td colspan="1" width="16%">
					<input name="productInfo.cplx" width="95%" class="nui-textbox" readonly />
				</td>
				<td class="form_label td1" width="17%" align="right">投资经理:</td>
				<td colspan="1" width="16%">
					<input name="productInfo.tzjl" width="95%" class="nui-textbox" readonly />
				</td>
			</tr>
			<tr>
				<td class="form_label td1" width="17%" align="right">委托人:</td>
				<td colspan="1" width="16%">
					<input name="productInfo.wtr" width="95%" class="nui-textbox" readonly />
				</td>
				<td class="form_label td1" width="17%" align="right">投顾:</td>
				<td colspan="1" width="16%">
					<input name="productInfo.tg" width="95%" class="nui-textbox" readonly />
				</td>
				<td class="form_label td1" width="17%" align="right"></td>
				<td colspan="1" width="16%">
				</td>
			</tr>
		</table>
	</div>
</div>

<script type="text/javascript">

function setProductInfo(vcProductCode){
	nui.ajax({
		url : "com.cjhxfund.ats.fm.baseinfo.ProductManager.getProductInfoByCode.biz.ext",
		type : 'POST',
		data : {vcProductCode:vcProductCode},
		cache : false,
		async: true,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if(returnJson.exception == null){
				if(returnJson.productInfo != null){
					var form = new nui.Form("#productInfoForm");//将普通form转为nui的form
                    form.setData(returnJson);
				}
			}
		}
	});
}
</script>
