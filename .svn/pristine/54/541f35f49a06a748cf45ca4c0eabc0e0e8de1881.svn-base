<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<head>
    <title>股票信息面板</title>
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
    </style>
</head>
<body style="background:#F4F4F4;">    
    <form id="dataform1" method="post" >
        <!-- hidden域 -->
		<input class="nui-hidden" name="purchaseInfo.lPurchaseNo" id="lPurchaseNo" />
		
        <fieldset style="border:solid 1px #aaa;padding:5px;margin:10px;">
            <legend >产品信息</legend>
            <div style="padding:5px;">
	        <table>
	            
	            <tr>
	                <td style="width:120px;">申报数量（万股）:</td>
	                <td>    
	                    <input id="enPurchaseNumber" name="purchaseInfo.enPurchaseNumber" emptyText="请输入修改数量" onvalidation="onNumberValidation" class="nui-textbox" vtype="float" required="true"/>
	                </td>
	            </tr>
	            <tr>
	                <td style="width:120px;">备注:</td>
	                <td>    
	                    <input name="purchaseInfo.vcComplianceRemark" emptyText="请输入修改原因" class="nui-textbox" required="true"/>
	                </td>
	            </tr>
	            
	        </table>            
            </div>
        </fieldset>
        <div style="text-align:center;padding:10px;">               
            <a class='nui-button' plain='false' onclick="onOk" iconCls="icon-ok" style="width:60px;margin-right:20px;">确定</a>       
            <a class='nui-button' plain='false' onclick="onCancel" iconCls="icon-cancel" style="width:60px;">取消</a>       
        </div>        
    </form>
    <script type="text/javascript">
        
        nui.parse();
		
		
		/****
	    *
		* 函数名：saveData
		* 机   能：保存修改记录
		* 输   入：无
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
        function saveData() {
			var form = new nui.Form("#dataform1");
			form.setChanged(false);
			form.validate();
			if (form.isValid() == false)
				return;

			var data = form.getData(false, true);
			var json = nui.encode(data);
			nui.ajax({
				url : "com.cjhxfund.ats.ipo.busOpr.updateIpoPurchaseInfo.biz.ext",
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
		
		/****
	    *
		* 函数名：SetData
		* 机   能：页面间传输json数据
		* 输   入：data  传入参数
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
		function SetData(data) {
			//跨页面传递的数据对象，克隆后才可以安全使用
			var infos = nui.clone(data);
			var form = new nui.Form("#dataform1");
			//如果是点击编辑类型页面
			if (infos.action == "edit") {
				var json = infos;
				form.setData(json);
				form.setChanged(false);
			}
			oldPurchaseNumber=infos.purchaseInfo.enPurchaseBeforeNumber;//修改前的申报数量
			oldPurchaseNumber=parseFloat(oldPurchaseNumber);
			enOfflineUpperNumber=infos.enOfflineUpperNumber;//网下申购上限
			enOfflineUpperNumber=parseFloat(enOfflineUpperNumber);
			enOfflineUnderNumber=infos.enOfflineUnderNumber;//网下申购下限
			enOfflineUnderNumber=parseFloat(enOfflineUnderNumber);
			enPurchaseSize=infos.enPurchaseSize;//申购步长
			enPurchaseSize=parseFloat(enPurchaseSize);
		}
				
		/****
	    *
		* 函数名：onNumberValidation
		* 机   能：验证修改申报数量
		* 输   入：e  当前单元格对象
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
		function onNumberValidation(e){
			var enPurchaseNumber=nui.get("enPurchaseNumber").getValue();//获取修改后的申报数量
			enPurchaseNumber=parseFloat(enPurchaseNumber);
			if (e.isValid) {
				if(enPurchaseNumber>enOfflineUnderNumber&&enPurchaseNumber<enOfflineUpperNumber&&enPurchaseNumber%enPurchaseSize!=0){
                    e.errorText = "修改数量须是步长的整数倍";
                    e.isValid = false;
                }else if(enPurchaseNumber>oldPurchaseNumber){
                	e.errorText = "修改数量不能大于之前的数量";
                    e.isValid = false;
                }else if(enPurchaseNumber>enOfflineUpperNumber){
                	e.errorText = "修改数量不能大于网下申购上限";
                    e.isValid = false;
                }else if(enPurchaseNumber<enOfflineUnderNumber){
                	e.errorText = "修改数量不能小于网下申购下限";
                    e.isValid = false;
                }else{
					return;
				}
            }
        }
		
		/****
	    *
		* 函数名：CloseWindow
		* 机   能：关闭窗口
		* 输   入：action  判断参数
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
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

		
		/****
	    *
		* 函数名：onOk
		* 机   能：确定保存或更新
		* 输   入：无
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
		function onOk(){
			saveData();
		}

		
		/****
	    *
		* 函数名：onCancel
		* 机   能：取消
		* 输   入：无
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
		function onCancel() {
			CloseWindow("cancel");
		}
		
		
		
		
    </script>
</body>
</html>