<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-08-23 15:51:40
  - Description:
-->
<head>
	<title>复核设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	
	
	
    
</head>
<body>

        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr id="singleShow">
                    <td class="form_label" align="right" width="20%">产品代码：</td>
                    <td style="width:15%;">
                    	<input name="ProductInfo.vcProductCode" class="mini-textbox" readonly="true" />
                    </td>
                    
                    <td class="form_label" align="right" width="30%">产品名称：</td>
                    <td style="width:35%;">
                    	<input name="ProductInfo.vcProductName" class="mini-textbox" readonly="true" />
                    </td>
                 </tr>
                 <tr>
                 	<td class="form_label"  align="right" width="20%">是否投顾复核：</td>
                    <td style="width:15%;">
                    	<input id="cInvestAdviseCheck" name="cInvestAdviseCheck" class="nui-checkbox"/>
                    </td>
                    
                    <td class="form_label"  align="right" width="30%">是否委托人复核：</td>
                    <td style="width:35%;">
                    	 <input id="cInvestClientCheck" name="cInvestClientCheck" class="nui-checkbox"/>
                    </td>
                </tr>
            </table>
            <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">
                                保存
                            </a>
                            <span style="display:inline-block;width:25px;">
                            </span>
                            <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
                                取消
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

	<script type="text/javascript">
    	nui.parse();
    	var selectDate = null;
    	
    	//页面间传输json数据
		function setFormData(data){
		    //跨页面传递的数据对象，克隆后才可以安全使用
		    var infos = nui.clone(data);
		    //保存list页面传递过来的页面类型：add表示新增、edit表示编辑
		    nui.getbyName("pageType").setValue(infos.pageType);
			selectDate = infos.records;
			
		    //如果是点击编辑类型页面
		    if (infos.pageType == "singleSet") {
		    	$("#singleShow").css("display","");
		        var json = infos.record;		
		        var form = new nui.Form("#dataform1");//将普通form转为nui的form
		        form.setData(json);
		        form.setChanged(false);
		    }else if (infos.pageType == "multiSet"){
		    	$("#singleShow").css("display","none");
		    }
		    
		}
		
		//确定更改复核设置
        function onOk() {
       		var pageType = nui.getbyName("pageType").getValue();
       		if(pageType=="singleSet"){
       			saveData();
       		}else{
	       		nui.confirm("确定设置所有选中记录？","系统提示", function(action){
					if(action=="ok"){
						saveData();
					}
				});
       		}
     		
            
        }
		function saveData(){
			var cInvestAdviseCheck;
			var cInvestClientCheck;
			if(nui.get("cInvestAdviseCheck").getValue()=="true"){
				cInvestAdviseCheck=1;
			}else{
				cInvestAdviseCheck=0;
			}
			if(nui.get("cInvestClientCheck").getValue()=="true"){
				cInvestClientCheck=1;
			}else{
				cInvestClientCheck=0;
			}

			var json = {productInfos:selectDate,cInvestAdviseCheck:cInvestAdviseCheck,cInvestClientCheck:cInvestClientCheck};
			$.ajax({
                url:"com.cjhxfund.ats.fm.baseinfo.ProductManager.setCheckForProduct.biz.ext",
                type: 'POST',
                data: nui.encode(json),
                cache: false,
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
		
		
		//取消
        function onCancel() {
            CloseWindow("cancel");
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
    </script>
</body>
</html>