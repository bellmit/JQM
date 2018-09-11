<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): liyongtu
  - Date: 2016-11-22 10:22:40
  - Description:
-->
<head>
<title>Title</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=request.getContextPath()%>/common/nui/nui.js"
	type="text/javascript"></script>
</head>

<body>
	<!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
	<input name="pageType" class="nui-hidden" />
	<div id="dataform1" style="padding-top: 5px;">
		<!-- hidden域 -->
		<input class="nui-hidden" name="dictconfig.dictConfigId" />
		<fieldset style="border:solid 1px #aaa;border-radius:5px;padding:5px 0 5px 20px;">
		<legend>基本信息</legend>
		<table class="nui-form-table"  style="width: 100%;">
			<tr>
				<td class="form_label">
		字典类型:
				</td>
				<td>
					<input id="dictID" class="nui-dictcombobox"
						dictTypeId="CJAPI_DICT_CONFIG_DICT_TYPE" name="dictconfig.dictType" 
						emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"
						required="true" />
				</td>
				<td class="form_label">
		显示顺序:
				</td>
				<td>
					<input class="nui-textbox"
							name="dictconfig.sortNo"
							emptyText="请输入整数" vtype="int" />
				</td>
			</tr>
			<tr>
				<td class="form_label">
		一级债字典名称:
				</td>
				<td>
					<input name="dictconfig.dictName" class="nui-textbox" required="true"
						requiredErrorText="不能为空"  />
				</td>
				<td class="form_label">
		一级债字典ID:
				</td>
				<td>
					<input name="dictconfig.dictId" class="nui-textbox" required="true"
						requiredErrorText="不能为空" />
				</td>
			</tr>
			<tr>
				<td class="form_label">
		机器猫字典名称:
				</td>
				<td>
					<input class="nui-textbox" required="true"
						requiredErrorText="不能为空" name="dictconfig.dictNameHs"/>
				</td>
				<td class="form_label">
		机器猫字典ID:
				</td>
				<td>
					<input class="nui-textbox" required="true"
							requiredErrorText="不能为空" name="dictconfig.dictIdHs"/>
				</td>
			</tr>
			<tr>
				<td class="form_label">
		备注信息 :
				</td>
				<td colspan="3">
					<input class="nui-textarea"  style="width:91%;" name="dictconfig.remark"  />
				</td>
			</tr>
		</table>
		</fieldset>
		<div class="nui-toolbar" style="margin-top: 15px;" borderStyle="border:0;border-radius:5px">
			<table width="100%">
				<tr>
					<td style="text-align: center;" colspan="4">
						<a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()"> 保存 </a> 
						<span style="display: inline-block; width: 25px;"></span> 
						<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">取消 </a>
						
					</td>
				</tr>
			</table>
		</div>
	</div>

	<script type="text/javascript">
		nui.parse();
		
		function saveData() {
			var form = new nui.Form("#dataform1");
			form.setChanged(false);
			//保存
			var urlStr = "com.cjhxfund.cjapi.DictConfig.insertDict.biz.ext";
			var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
			//编辑
			if (pageType == "edit") {
				urlStr = "com.cjhxfund.cjapi.DictConfig.updateDict.biz.ext";
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