<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/CFJYProductProcessForm_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2015-10-09 11:42:39
- Description: 指令/建议录入指令/建议单_申购缴款业务
--%>
<head>
<title>指令/建议录入指令/建议单_申购缴款业务</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <input class="nui-hidden" name="cfjyproductprocess.processType4InvestProductNum" value="07,08"/>
            <input class="nui-hidden" name="cfjyproductprocess.processId"/>
            <input class="nui-hidden" name="cfjyproductprocess.processStatus" id="processStatus"/>
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td class="form_label" width="21%">
                        业务日期:
                    </td>
                    <td colspan="1" width="27%">
                        <input id="processDate" class="nui-datepicker" name="cfjyproductprocess.processDate" required="true" value=""/>
                    </td>
                    <td class="form_label" width="25%">
                        业务类别:
                    </td>
                    <td colspan="1" width="27%">
                        <input id="processType" class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQSJ" name="cfjyproductprocess.processType" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" width="23%">
                        产品名称:
                    </td>
                    <td colspan="1" width="27%">
                        <input id="combProductCode" required="true" class="nui-autocomplete" style="width:150px;" name="cfjyproductprocess.combProductCode" searchField="searchKey" dataField="combProducts"
                        	valueField="fundCode" textField="fundName" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductsByKeyAndUserId.biz.ext" value="" text="" enterQuery="false" onvaluechanged="changedCombProductCode"/>
                        <input id="combProductName" class="nui-hidden" name="cfjyproductprocess.combProductName"/>
                    </td>
                    <td class="form_label" width="23%">
                        组合名称:
                    </td>
                    <td colspan="1" width="27%">
                       <input class="nui-combobox" id="vcCombiNo"  required="true" dataField="productCombis"  name="cfjyproductprocess.vcCombiNo" 
	                        valueField="vcCombiNo" textField="vcCombiName" onvaluechanged="setVcCombiName" searchField="searchKey" value="" text="" enterQuery="false"/>
	                      <input class="nui-hidden" id="vcCombiName" name="cfjyproductprocess.vcCombiName"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        债券代码:
                    </td>
                    <td colspan="1">
                        <input id="investProductCode" required="false" class="nui-autocomplete" popupWidth="300" popupHeight="200" name="cfjyproductprocess.investProductCode" searchField="searchKey" dataField="investProducts"
                        	valueField="investProductInfo" textField="investProduct" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByKey.biz.ext" value="" text="" enterQuery="false" onitemclick="investProductCodeOnItemClick"/>
                    </td>
                    <td class="form_label">
                        债券名称:
                    </td>
                    <td colspan="1">
                        <input id="investProductName" class="nui-textbox" style="width:150px;" name="cfjyproductprocess.investProductName" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        债券类别:
                    </td>
                    <td colspan="1">
                        <input id="investCategory" class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY" name="cfjyproductprocess.investCategory" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true"/>
                    </td>
                	<td class="form_label">
                        主体评级:
                    </td>
                    <td colspan="1">
                        <input id="subjectRating" class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" name="cfjyproductprocess.subjectRating" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label">
                        债券评级:
                    </td>
                    <td colspan="1">
                        <input id="bondRating" class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" name="cfjyproductprocess.bondRating" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true"/>
                    </td>
                	<td class="form_label">
                        缴款场所:
                    </td>
                    <td colspan="1">
                        <input id="paymentPlace" class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_PAYMENT_PLACE" name="cfjyproductprocess.paymentPlace" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="false"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label">
                        评级机构:
                    </td>
                    <td colspan="1">
                        <input id="ratingAgencies" class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_RATING_AGENCIES" name="cfjyproductprocess.ratingAgencies" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true"/>
                    </td>
                	<td class="form_label">
                        交易数量（万元）:
                    </td>
                    <td colspan="1">
                        <input id="investCount" class="nui-textbox" name="cfjyproductprocess.investCount" required="true" onblur="investCountFun()"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        投标利率:
                    </td>
                    <td colspan="1">
                        <input id="interestRate" class="nui-textbox" name="cfjyproductprocess.interestRate" required="false"/>
                    </td>
                    <td class="form_label">
                        投标价格（元/百元面值）:
                    </td>
                    <td colspan="1">
                        <input id="netPrice" class="nui-textbox" name="cfjyproductprocess.netPrice" required="false" onblur="netPriceFun()"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        投标场所:
                    </td>
                    <td colspan="1">
                        <input id="tradingPlace" class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_TRADING_PLACE_3" name="cfjyproductprocess.tradingPlace" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="false"/>
                    </td>
                    <td class="form_label">
                        承销商:
                    </td>
                    <td colspan="1">
                        <input id="leadUnderwriter" class="nui-textbox" name="cfjyproductprocess.leadUnderwriter" required="false"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label">
                        清算速度:
                    </td>
                    <td colspan="1">
                        <input id="clearingSpeed" class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_CLEARING_SPEED" name="cfjyproductprocess.clearingSpeed" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="false"/>
                    </td>
                	<td class="form_label">
                        交割方式:
                    </td>
                    <td colspan="1">
                        <input id="deliveryMethod" class="nui-textbox" name="cfjyproductprocess.deliveryMethod" required="false"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        备注:
                    </td>
                    <td colspan="3">
                        <input class="nui-textarea"name="cfjyproductprocess.remark" width="100%"  height="75px"/>
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
            nui.get("processDate").setValue(new Date());

            function saveData(){

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //保存
                var urlStr = "com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.addCFJYProductProcess.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.updateCFJYProductProcess.biz.ext";
                }
                form.validate();
                if(form.isValid()==false) return;
                
                //特殊验证
                var processTypeVal = nui.get("processType").value;//业务类别
                var interestRateVal = nui.get("interestRate").value;//投标利率
                var tradingPlaceVal = nui.get("tradingPlace").value;//投标场所
                var paymentPlaceVal = nui.get("paymentPlace").value;//缴款场所
                var leadUnderwriterVal = nui.get("leadUnderwriter").value;//承销商
                
                //07-债券申购
                if(processTypeVal=="07"){
                	if(interestRateVal==null || interestRateVal==""){
                		nui.alert("投标利率不能为空","提示");
                		nui.get("interestRate").focus();
				        return;
                	}
                	if(tradingPlaceVal==null || tradingPlaceVal==""){
                		nui.alert("投标场所不能为空","提示");
                		nui.get("tradingPlace").focus();
				        return;
                	}
                //08-债券缴款类型
                }else if(processTypeVal=="08"){
                	if(paymentPlaceVal==null || paymentPlaceVal==""){
                		nui.alert("缴款场所不能为空","提示");
                		nui.get("paymentPlace").focus();
				        return;
                	}
                	if(leadUnderwriterVal==null || leadUnderwriterVal==""){
                		nui.alert("承销商不能为空","提示");
                		nui.get("leadUnderwriter").focus();
				        return;
                	}
                }
                
                
                //获取产品名称值
                var combProductCodeVal = nui.get("combProductCode").getValue();//获取产品代码值
                var combProductNameVal = nui.get("combProductCode").getText();//获取产品名称值（从表单显示值取）
                nui.get("combProductName").setValue(combProductNameVal);
                if(combProductCodeVal==combProductNameVal){
                	nui.alert("请输入选择正确的产品名称","提示");
            		nui.get("combProductCode").focus();
			        return;
                }
                
                //若债券代码包含英文逗号这些，则仅取债券代码
                var investProductCode = nui.get("investProductCode").getValue();//债券代码
                if(investProductCode!=null && investProductCode!="" && investProductCode.indexOf(",")!=-1){
                	investProductCode = investProductCode.substr(0, investProductCode.indexOf(","));
                	nui.get("investProductCode").setValue(investProductCode);//债券代码
                }

                //保存数据
				saveDataCommon(form, pageType, urlStr);
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
                            
                            //设置产品名称值
                            var combProductNameVal = json.cfjyproductprocess.combProductName;
                            nui.get("combProductCode").setText(combProductNameVal);
                			nui.get("combProductName").setValue(combProductNameVal);
                			
                			//设置债券代码显示值
							var investProductCodeVal = json.cfjyproductprocess.investProductCode;
					        nui.get("investProductCode").setText(investProductCodeVal);
                			
                            form.setData(json);
                            form.setChanged(false);
                            
                            //调用方法重新加载组合
					        changedCombProductCode();
					        //重新设置选择的组合
							var vcCombiNo = json.cfjyproductprocess.vcCombiNo;
							var vcCombiName = json.cfjyproductprocess.vcCombiName;
		
					        nui.get("vcCombiNo").setValue(vcCombiNo);
					        nui.get("vcCombiNo").setText(vcCombiName);
					        
					        //重新设置隐藏组合名称
					        nui.get("vcCombiName").setValue(nui.get("vcCombiNo").getText());
                        }
                    }

                    //自动增加千分位-交易数量（万元）
                    function investCountFun(){
                    	formatNumberCommon("investCount");
                    }
                    //自动增加千分位-投标价格（元/百元面值）
                    function netPriceFun(){
                    	formatNumberCommon("netPrice");
                    }
                    
                    //债券代码下拉项点击时触发函数
		            function investProductCodeOnItemClick(){
		                var investProductCode = nui.get("investProductCode").getValue();//投资产品信息
		                if(investProductCode!=null && investProductCode!=""){
                	
		                	//通过交易市场编号、证券申报代码到O32系统查找投资的债券、股票等产品信息（包含债券评级等债券属性）
		                	var paramArr = investProductCode.split(",");
					    	$.ajax({
					            url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductInfoByMarketNoAndReportCode.biz.ext",
					            type:'POST',
					            data:nui.encode({marketNo:paramArr[2], reportCode:paramArr[0]}),
					            cache:false,
					            contentType:'text/json',
					            success:function(text){
					                var returnJson = nui.decode(text);
					                if(returnJson.exception == null){
					                	var investProductInfo = returnJson.investProductInfo;//投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
					                	
					                	//投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
					                	var investProductCodeArr = investProductInfo.split(",");
					                	var investProductCodeVal = investProductCodeArr[0];//债券代码
					                	var investProductNameVal = investProductCodeArr[1];//债券名称
					                	var investCategoryVal = investProductCodeArr[2];//债券类别代码
					                	var bondRatingVal = investProductCodeArr[3];//债券评级代码
					                	var subjectRatingVal = investProductCodeArr[4];//主体评级代码
					                	var ratingAgenciesVal = investProductCodeArr[5];//评级机构代码
					                	
						                nui.get("investProductCode").setText(investProductCodeVal);
						                nui.get("investProductCode").setValue(investProductCodeVal);
						                nui.get("investProductName").setValue(investProductNameVal);
						                //设置债券类别
						                if(investCategoryVal!=null && investCategoryVal!="" && investCategoryVal!="★"){
						                	nui.get("investCategory").setValue(investCategoryVal);
						                }else{
						                	nui.get("investCategory").setValue(null);
						                }
						                //债券评级
						                if(bondRatingVal!=null && bondRatingVal!="" && bondRatingVal!="★"){
						                	nui.get("bondRating").setValue(bondRatingVal);
						                }else{
						                	nui.get("bondRating").setValue(null);
						                }
						                //主体评级
						                if(subjectRatingVal!=null && subjectRatingVal!="" && subjectRatingVal!="★"){
						                	nui.get("subjectRating").setValue(subjectRatingVal);
						                }else{
						                	nui.get("subjectRating").setValue(null);
						                }
						                //评级机构
						                if(ratingAgenciesVal!=null && ratingAgenciesVal!="" && ratingAgenciesVal!="★"){
						                	nui.get("ratingAgencies").setValue(ratingAgenciesVal);
						                }else{
						                	nui.get("ratingAgencies").setValue(null);
						                }
					                	
					                }else{
					                    nui.alert("债券详细信息获取失败", "系统提示");
					                }
					            }
					        });
		                }else{
		                	nui.get("investProductCode").setText(null);
			                nui.get("investProductCode").setValue(null);
		                }
		            }
                </script>
            </body>
        </html>
