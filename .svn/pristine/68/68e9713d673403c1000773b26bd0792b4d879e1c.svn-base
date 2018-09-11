<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): CJ-WB-DT13
- Date: 2016-03-09 11:38:26
- Description:
    --%>
    <head>
        <title>产品投资范围录入</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    	<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
    </head>
    <body style="width: 100%;height: 100%;overflow: hidden;">
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="width: 100%;height: 100%">
            <!-- hidden域 -->
            <input class="nui-hidden" name="cfjyproductinvestmentrange.productid"/>
         <div id="tabs1" class="nui-tabs"  activeIndex="0"  style="width:98.5%;height:94%;overflow: hidden;margin-left: 8px;" >
            <div title="合同信息" style="height: 100%;">
              <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <%--<td class="form_label" width="15%" align="right">
                        产品代码:
                    </td>
                    <td colspan="1" width="35%">
                        <input class="nui-textbox" name="cfjyproductinvestmentrange.combProductCode" width="170" id="combProductCode" readonly/>
                    </td>--%>
                    <td class="form_label" width="15%" align="right">
                        产品名称:
                    </td>
                    <td colspan="3">
                      <div id="div1">
                        <%--<input class="nui-autocomplete" id="autocomplete" width="170" required="true" dataField="combProducts"  
                         url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductsByKeyAndUserId.biz.ext"
                         valueField="fundCode" textField="fundName" onvaluechanged="setCombProductName" searchField="searchKey" value="" text="" enterQuery="false"/>
                        <input class="nui-hidden"id="combProductName" name="cfjyproductinvestmentrange.combProductName"/>--%>
                        <input id="combProductCode" required="true" class="nui-textboxlist" style="width:800px;" name="cfjyproductinvestmentrange.combProductCode" searchField="searchKey" dataField="combProducts"
                        	valueField="fundCode" textField="fundCodeName" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductsByKey.biz.ext" />
                        <input id="combProductName" class="nui-hidden" name="cfjyproductinvestmentrange.combProductName"/>
                      </div>
                      <div id="div2" style="display: none;">
                        <input id="combProductName" class="nui-textbox" name="cfjyproductinvestmentrange.combProductName" width="200" readonly="readonly"/> 
                        <input class="nui-hidden" name="cfjyproductinvestmentrange.combProductCode" id="combProductCode1" /> 
                      </div>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                        可投范围:
                    </td>
                    <td colspan="3">
                        <input class="nui-textarea" width="800" height="110" name="cfjyproductinvestmentrange.voteRange"/>
                    </td>
                </tr>
                <tr>    
                    <td class="form_label" align="right">
                        禁投范围:
                    </td>
                    <td colspan="3">
                        <input class="nui-textarea" width="800" height="110" name="cfjyproductinvestmentrange.noCastRange"/>
                    </td>
                </tr>
                <tr>     
                    <td class="form_label" align="right">
                        投资限制:
                    </td>
                    <td colspan="3">
                        <input class="nui-textarea" width="800" height="150" name="cfjyproductinvestmentrange.investmentLimit"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                        备注:
                    </td>
                    <td colspan="3">
                        <input class="nui-textarea" width="800" height="80" name="cfjyproductinvestmentrange.remarks"/>
                    </td>
                </tr>
            </table>
           </div>
           <div title="产品规范约定" style="overflow-y: hidden;height:100%;">
             <table style="width:100%;table-layout:fixed;" class="nui-form-table">
             <tr>
                    <td class="form_label" width="22%" align="right">
                        债券种类:
                    </td>
                    <td colspan="1" width="28%">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY" width="170" name="cfjyproductinvestmentrange.scopeInvestment"
                        multiSelect="true"  valueFromSelect="true"/>
                    </td>
                    <td class="form_label" width="22%" align="right">
                       主体评级:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" width="170" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" name="cfjyproductinvestmentrange.subjectrating" 
                        multiSelect="true"  valueFromSelect="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                        债项评级:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" width="170"  name="cfjyproductinvestmentrange.bondrating" multiSelect="true"  valueFromSelect="true"
                        multiSelect="true"  valueFromSelect="true"/>
                    </td>   
                    <td class="form_label" align="right">
                        评级机构:
                    </td>
                    <td colspan="1">
                        <input class="nui-dictcombobox" width="170" dictTypeId="CF_JY_PRODUCT_PROCESS_RATING_AGENCIES"  name="cfjyproductinvestmentrange.ratingagencies"
                        multiSelect="true"  valueFromSelect="true"/>
                        <%--<textarea id="ke" name="cfjyproductinvestmentrange.noCastRange" style="width:100%;height:120px;visibility:hidden;">

        				</textarea>--%>
                    </td>
                </tr>
                <tr>     
                    <td class="form_label" align="right">
                        该笔债券投资占发行规模比例:
                    </td>
                    <td colspan="1">
						<input class="nui-textbox" name="cfjyproductinvestmentrange.ioccupyScaleProportion" width="170"/>
					</td>   
                    <td class="form_label" align="right">
                       同一发行人主体占净值规模比例:
                    </td>
                    <td colspan="1">
						<input class="nui-textbox" name="cfjyproductinvestmentrange.subjectOccupyNetSize" width="170"/>
					</td>
                </tr>
                <tr>     
                    <td class="form_label" align="right">
                        该笔债投资占净值规模比例:
                    </td>
                    <td colspan="1">
						<input class="nui-textbox" name="cfjyproductinvestmentrange.netSizeProportion" width="170"/>
					</td>  
                    <td class="form_label" align="right">
                       弱流动性资产规模比例:
                    </td>
                    <td colspan="1">
						<input class="nui-textbox" name="cfjyproductinvestmentrange.weakLiquidityRatio" width="170"/>
					</td>
                </tr>
            </table>
           </div>
         </div>   
            
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

            function saveData(){

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //保存
                var urlStr = "com.cjhxfund.jy.process.cfjyproductinvestmentrangebiz.addCfJyProductInvestmentRange.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.cjhxfund.jy.process.cfjyproductinvestmentrangebiz.updateCfJyProductInvestmentRange.biz.ext";
                }
                form.validate();
                if(form.isValid()==false) return;
				
				if(pageType=="add"){
					//获取产品名称
					var combProductName = nui.get("combProductCode").getText();
					nui.get("combProductName").setValue(combProductName);
					nui.get("combProductCode1").setValue(nui.get("combProductCode").getValue());
				}
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
                            form.setChanged(false);
                            
                            document.getElementById("div1").style.display="none";
                            document.getElementById("div2").style.display="block";
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
