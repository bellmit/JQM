<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/CFJYProductProcessForm_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2015-10-09 11:42:39
- Description: 指令/建议录入指令/建议单_债券买卖业务
--%>
<head>
<title>指令/建议录入指令/建议单_债券买卖业务</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <input class="nui-hidden" name="zhfwptjyzqmm.processType4InvestProductNum" value="01,02"/>
            <input class="nui-hidden" name="zhfwptjyzqmm.processId"/>
            <input class="nui-hidden" name="zhfwptjyzqmm.processStatus" id="processStatus"/>
            <input class="nui-hidden" name="zhfwptjyzqmm.roleType" id="roleType"/>
            <input class="nui-hidden" name="zhfwptjyzqmm.dataSource" id="zhfwptjyzqmm.dataSource"/>
            <!-- 业务类别 2-银行间二级市场业务-->
            <input class="nui-hidden" name="zhfwptjyzqmm.businclass" id="businclass" value="2"/>
            <!-- 指令/建议操作级别：0无；1快速；2一般；3慢速；数据字典40345项  -->
            <input class="nui-hidden" name="zhfwptjyzqmm.instructionlevel" id="instructionlevel" value="0"/>
            <!-- 结算方式（首次结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户； -->
            <input class="nui-hidden" name="zhfwptjyzqmm.bondsettletype" id="bondsettletype" value="3"/>
            <!-- 【只用于银行间回购】到期结算方式：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户； -->
            <input class="nui-hidden" name="zhfwptjyzqmm.bondsettletype2" id="bondsettletype2" value="3"/>
            <!-- 投资类型：交易所，1-可交易；2-持有到期；3-可供出售；回购业务投资类型为1-可交易，不传投资类型会根据系统数决定取组合的投资类型或缺省为1-可交易，具体取值和O3保持一致。 -->
            <input class="nui-hidden" name="zhfwptjyzqmm.investtype" id="investtype" value="1"/>
            <!-- 价格模式：1 - 市价（表示不限制委托价格，在涨跌停范围内即可）；2 - 限价（表示限制委托价格，买入不高于，卖出不低于）； -->
            <input class="nui-hidden" name="zhfwptjyzqmm.ordtype" id="ordtype" value="2"/>
            <!-- 交易市场：OTC-场外； -->
            <input class="nui-hidden" name="zhfwptjyzqmm.exdestination" id="exdestination" value="OTC"/>
            <!-- 判断可用（风控）：0-不判；1-判； -->
            <input class="nui-hidden" name="zhfwptjyzqmm.judgeavailable" id="judgeavailable" value="1"/>
            <!-- 判断风控：0-不判；1-判； -->
            <input class="nui-hidden" name="zhfwptjyzqmm.judgerisk" id="judgerisk" value="1"/>
            
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
            	<!--  
            	<tr style="border-top:none;">
            		<td colspan="4" width="100%" align="center" class="radio-border-top-none">
            			<input id="isInquiry" class="nui-radiobuttonlist" name="zhfwptjyzqmm.isInquiry" value="0" repeatItems="1" repeatLayout="none" repeatDirection="horizontal" textField="text" valueField="id" url="<%=request.getContextPath()%>/ProductProcess/IsInquiryData.txt" onvaluechanged="isInquiryOnvaluechanged(e)"/>
            		</td>
            	</tr>
            	-->
            	<!-- 默认完整指令0 -->
                <tr>
                    <td class="form_label" width="21%">
                        业务日期:
                    </td>
                    <td colspan="1" width="29%">
                    	<input name="zhfwptjyzqmm.isInquiry" id="isInquiry" class="nui-hidden" value="0">
                        <input id="processDate" class="nui-datepicker" style="width:150px;" name="zhfwptjyzqmm.processDate" required="true" value=""/>
                    </td>
                    <td class="form_label" width="21%">
                         截止日期:
                    </td>
                    <td colspan="1" width="29%">
                        <input id="expiredate" class="nui-datepicker" style="width:150px;" name="zhfwptjyzqmm.expiredate" required="true" value=""/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label">
                        产品名称:
                    </td>
                    <td colspan="1">
                        <input id="combProductCode" required="true" class="nui-autocomplete" style="width:150px;" name="zhfwptjyzqmm.combProductCode" searchField="searchKey" dataField="combProducts"
                        	valueField="fundCode" textField="fundName" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductsByKeyAndUserId.biz.ext" value="" text="" enterQuery="false" onvaluechanged="changedCombProductCode"/>
                        <input id="combProductName" class="nui-hidden" name="zhfwptjyzqmm.combProductName"/>
                    </td>
                	<td class="form_label">
                        组合名称:
                    </td>
                    <td colspan="1">
                    	<input class="nui-combobox" id="vcCombiNo" style="width:150px;"  required="true" dataField="productCombis"  name="zhfwptjyzqmm.vcCombiNo" 
	                        valueField="vcCombiNo" textField="vcCombiName" onvaluechanged="setVcCombiName" searchField="searchKey" value="" text="" enterQuery="false"/>
	                      <input class="nui-hidden" id="vcCombiName" name="zhfwptjyzqmm.vcCombiName"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label">
                        债券代码:
                    </td>
                    <td colspan="1">
                        <input id="investProductCode" required="true" class="nui-autocomplete" style="width:150px;" popupWidth="300" popupHeight="200" name="zhfwptjyzqmm.investProductCode" searchField="searchKey" dataField="investProducts"
                        	valueField="investProductInfo" textField="investProduct" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByKey.biz.ext" value="" text="" enterQuery="false" onitemclick="investProductCodeOnItemClick"/>
                    </td>
                    <td class="form_label">
                        债券名称:
                    </td>
                    <td colspan="1">
                        <input id="investProductName" class="nui-textbox" style="width:150px;" style="width:150px;" name="zhfwptjyzqmm.investProductName" required="true"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label">
                        业务类别:
                    </td>
                    <td colspan="1">
                        <input id="processType" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQMM" name="zhfwptjyzqmm.processType" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" onvaluechanged="processTypeValueChangedFun"/>
                    </td>
                    <td class="form_label">
                        债券类别:
                    </td>
                    <td colspan="1">
                        <input id="investCategory" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY" name="zhfwptjyzqmm.investCategory" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="false"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        债券评级:
                    </td>
                    <td colspan="1">
                        <input id="bondRating" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" name="zhfwptjyzqmm.bondRating" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="false"/>
                    </td>
                	<td class="form_label">
                        主体评级:
                    </td>
                    <td colspan="1">
                        <input id="subjectRating" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" name="zhfwptjyzqmm.subjectRating" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="false"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label">
                        清算速度:
                    </td>
                    <td colspan="1">
                        <input id="clearingSpeed" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_CLEARING_SPEED" name="zhfwptjyzqmm.clearingSpeed" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" onvaluechanged="setBondPriceUtil"/>
                    </td>
                    <td class="form_label">
                        清算类型:
                    </td>
                    <td colspan="1">
                    	<!-- 【只用于银行间债券】清算类型：1-	全额结算；2-净额结算；缺省为1，取自数据字典60151-银行间指令/建议清算类型 -->
                        <input id="cleartype" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_CLEAR_TYPE" name="zhfwptjyzqmm.cleartype" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" />
                    </td>
                </tr>
                <tr>
                	<td class="form_label">
                        交易场所:
                    </td>
                    <td colspan="1">
                        <input id="tradingPlace" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_TRADING_PLACE" name="zhfwptjyzqmm.tradingPlace" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true"/>
                    </td>
                    <td class="form_label">
                        券面金额（万元）:
                    </td>
                    <td colspan="1">
                        <input id="investCount" class="nui-textbox" style="width:150px;" name="zhfwptjyzqmm.investCount" required="true" onblur="investCountFun()"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        交易对手:
                    </td>
                    <td colspan="1">
                        <input id="tradingOpponent" class="nui-textbox" style="width:150px;" name="zhfwptjyzqmm.tradingOpponent" required="true"/>
                    </td>
                    <td colspan="2" align="left">
                		<table>
                			<tr style="border-top:none;">
			                    <td class="form_label" style="padding:0;">
						                        净价（元/百元面值）:
			                    </td>
			                    <td colspan="1" style="padding:0 0 0 66px;">
			                        <input id="netPrice" class="nui-textbox" style="width:90px;" name="zhfwptjyzqmm.netPrice" required="false" onblur="netPriceFun()" width="80px"/>
			                    </td>
			                    <td style="padding:0;">
			                    	<input id="autoCalc" name="autoCalc" style="width:150px;" class="nui-checkbox" checked="true" text="联动"/>
			                    </td>
                			</tr>
                		</table>
                	</td>
                </tr>
                <tr>
                	<td class="form_label">
			                        全价（元/百元面值）:
                    </td>
                    <td colspan="1">
                        <input id="fullPrice" class="nui-textbox" style="width:150px;" name="zhfwptjyzqmm.fullPrice" required="false" onblur="fullPriceFun()"/>
                    </td>
                    <td class="form_label">
                        收益率类型:
                    </td>
                    <td colspan="1">
                    	<input id="interestRateType" class="nui-dictcombobox" style="width:150px;" dictTypeId="CF_JY_PRODUCT_PROCESS_INTEREST_RATE_TYPE" name="zhfwptjyzqmm.interestRateType" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="false" onvaluechanged="interestRateTypeValueChangedFun"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        收益率（%）:
                    </td>
                    <td colspan="1">
                        <input id="interestRate" class="nui-textbox" style="width:150px;" name="zhfwptjyzqmm.interestRate" required="false" onblur="interestRateFun()"/>
                    </td>
                    <td class="form_label">
                        交易员代码:
                    </td>
                    <td colspan="1" id="traderCodeTd">
                    	<input id="traderCode" class="nui-textbox" style="width:150px;" name="zhfwptjyzqmm.traderCode" required="false"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        席位号:
                    </td>
                    <td colspan="1">
                    	<input id="seatNum" class="nui-textbox" style="width:150px;" name="zhfwptjyzqmm.seatNum" required="false"/>
                    </td>
                    <td class="form_label">
                        约定号:
                    </td>
                    <td colspan="1">
                        <input id="agreementNum" class="nui-textbox" style="width:150px;" name="zhfwptjyzqmm.agreementNum" required="false"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        备注:
                    </td>
                    <td colspan="3">
                        <input class="nui-textarea"name="zhfwptjyzqmm.remark" width="100%"/>
                    </td>
                </tr>
            </table>
            <div class="nui-toolbar" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                        	<!-- <a class='nui-button' plain='false' iconCls="icon-tip" onclick="saveData(0)">
                                风控试算
                            </a>
                            <span style="display:inline-block;width:25px;"></span> -->
                            <a class='nui-button' plain='false' iconCls="icon-save" onclick="saveData(1)">
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
            nui.get("processDate").setValue(new Date()); //默认开始日期
            nui.get("expiredate").setValue(new Date());  //默认截止日期
            var investProductInfoCommon = "";//投资产品信息全局变量（债券代码,债券名称,交易市场编号,证券内码）

            function saveData(type){//type==0:风控试算   type==1:保存
                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //风险试算
                var riskControlUrl = "com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.riskControl.biz.ext";
                //保存
                var urlStr = "com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_add.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                var roleType = nui.get("roleType").getValue();//获取当前页面是投顾打开还是交易员填单打开
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_update.biz.ext";
                }
                form.validate();
                if(form.isValid()==false) return;
                
                
                //是否询价指令/建议：0-否（完整指令/建议）;1-是（询价指令/建议）;
                var isInquiry = nui.get("isInquiry").value;
                //若是完整指令/建议，则需要特殊验证
                if(isInquiry=="0"){
                	//特殊验证，业务类别：01-债券买入、02-债券卖出
	                var processTypeVal = nui.get("processType").value;//业务类别
	                var investCategoryVal = nui.get("investCategory").value;//债券类别
	                var subjectRatingVal = nui.get("subjectRating").value;//主体评级
	                var bondRatingVal = nui.get("bondRating").value;//债券评级
	                //债券买入指令/建议中：债券类别、主体评级、债券评级必输
	                if(processTypeVal=="01"){
	                	if(investCategoryVal==null || investCategoryVal==""){
	                		nui.alert("债券类别不能为空","提示");
	                		nui.get("investCategory").focus();
					        return;
	                	}
	                	if(investCategoryVal!="01"){//利率债--主体评级、债券评级可以为空
	                		if(subjectRatingVal==null || subjectRatingVal==""){
		                		nui.alert("主体评级不能为空","提示");
		                		nui.get("subjectRating").focus();
						        return;
		                	}
		                	if(bondRatingVal==null || bondRatingVal==""){
		                		nui.alert("债券评级不能为空","提示");
		                		nui.get("bondRating").focus();
						        return;
		                	}
	                	}
	                }
	                
	                //特殊验证，交易场所：[01-银行间;02-上交所固收平台;03-深交所综合协议平台|上交所大宗;]
	                var tradingPlaceVal = nui.get("tradingPlace").value;//交易场所
	                var traderCodeVal = nui.get("traderCode").value;//交易员代码
	                var agreementNumVal = nui.get("agreementNum").value;//约定号
	                var seatNumVal = nui.get("seatNum").value;//席位号
	                //02-上交所固收平台， 新增：交易员代码、约定号（非必输）
	                if(tradingPlaceVal=="02"){
	                	if(traderCodeVal==null || traderCodeVal==""){
	                		nui.alert("交易员代码不能为空","提示");
	                		nui.get("traderCode").focus();
					        return;
	                	}
	                //03-深交所综合协议平台|上交所大宗，新增：席位号、约定号（非必输）
	                }else if(tradingPlaceVal=="03"){
	                	if(seatNumVal==null || seatNumVal==""){
	                		nui.alert("席位号不能为空","提示");
	                		nui.get("seatNum").focus();
					        return;
	                	}
	                }
	                
	                //特殊验证，净价、全价、收益率，可以必填其一，选填其他，输入一个另外两个数据可以系统自动算出来
	                var netPrice = nui.get("netPrice").value;//净价（元/百元面值）
	                var fullPrice = nui.get("fullPrice").value;//全价（元/百元面值）
	                var interestRate = nui.get("interestRate").value;//收益率
	                var interestRateType = nui.get("interestRateType").value;//收益率类型
	                if((netPrice==null||netPrice=="") && (fullPrice==null||fullPrice=="") && (interestRate==null||interestRate=="")){
	                	nui.alert("净价、全价、收益率必填其一，选填其他","提示");
	            		nui.get("netPrice").focus();
				        return;
	                }
	                if((interestRate!=null&&interestRate!="") && (interestRateType==null||interestRateType=="")){
	                	nui.alert("收益率类型不能为空","提示");
	            		nui.get("interestRateType").focus();
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
                
                var processStatusUrl = "com.cjhxfund.jy.ProductProcess.JY_ZQMM.getProcessStatus_ZQMM.biz.ext";
                var validStatusUrl = "com.cjhxfund.jy.ProductProcess.JY_ZQMM.getValidStatus_ZQMM.biz.ext";
                //对于完整先进行风控试算，根据结果进行处理，对于询价指令/建议直接保存数据
                if(isInquiry=="0" && type=="0"){
	                var data = form.getData(false,true);
	                var json = nui.encode(data);
	                $.ajax({
			            url:riskControlUrl,
			            type:'POST',
			            data:json,
			            cache:false,
			            contentType:'text/json',
			            success:function(text){
			            	var result = nui.decode(text);
			            	if(result.rtnCode=="0"){
			            		nui.open({
			            			url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
					                title: "指令/建议风险提示",
					                width: 650,
					                height: 380,
					                allowResize: false,
					                onload: function () {
				                        var iframe = this.getIFrameEl();
				                        var data = result.riskMsg;
				                        iframe.contentWindow.SetData(data);
					           		},
								    ondestroy: function (action) {  //弹出页面关闭前
								        if (action == "ok") {       //如果点击“继续”
								        }                        
								    }
			            		});
			            	}
			            	if(result.rtnCode=="1"){
			            		nui.alert("风险试算通过，您可以下达该指令/建议");
			            	}
			            	if(result.rtnCode=="2"){
			            		nui.alert("执行异常");
			            	}
			            }
			      	});
                }else{
                	saveDataCommon(form, pageType, urlStr, roleType, processStatusUrl, validStatusUrl);
                }
				
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
			        var combProductNameVal = json.zhfwptjyzqmm.combProductName;
			        nui.get("combProductCode").setText(combProductNameVal);
					nui.get("combProductName").setValue(combProductNameVal);
					var dataSource = json.zhfwptjyzqmm.dataSource;
					nui.get("zhfwptjyzqmm.dataSource").setValue(dataSource);
				
					//设置债券代码显示值
					var investProductCodeVal = json.zhfwptjyzqmm.investProductCode;
			        nui.get("investProductCode").setText(investProductCodeVal);
			        
			        form.setData(json);
			        form.setChanged(false);
			        
			        nui.get("autoCalc").setChecked(true);//设置“联动”为勾选
			        
			        //调用方法重新加载组合
			        changedCombProductCode();
			        //重新设置选择的组合
					var vcCombiNo = json.zhfwptjyzqmm.vcCombiNo;
					var vcCombiName = json.zhfwptjyzqmm.vcCombiName;

			        nui.get("vcCombiNo").setValue(vcCombiNo);
			        nui.get("vcCombiNo").setText(vcCombiName);
			        
			        //重新设置隐藏组合名称
			        nui.get("vcCombiName").setValue(nui.get("vcCombiNo").getText());   
			    }
			    
			    //若当前页面是交易员填单打开，则设置“是否询价指令/建议”标识为只读，且值为“0-否（完整指令/建议）”
                if(infos.roleType=="JYY"){
                	nui.get("isInquiry").setValue("0");
                	nui.get("isInquiry").disable();
                }
                nui.get("roleType").setValue(infos.roleType);//设置角色类型值传输到后台处理
            	isInquiryOnvaluechanged(nui.get("isInquiry"));//初始化设置必输项，是否询价指令/建议：0-否（完整指令/建议）;1-是（询价指令/建议）;
			}
			
			//值变换时触发函数-业务类别：01-债券买入;02-债券卖出;
			function processTypeValueChangedFun(cmp){
			}
			
			//自动增加千分位-券面金额（万元）
            function investCountFun(){
            	//是否询价指令/建议：0-否（完整指令/建议）;1-是（询价指令/建议）;
                var isInquiry = nui.get("isInquiry").value;
                //若是完整指令/建议，则需要转换为千分位格式
                if(isInquiry=="0"){
                	formatNumberCommon("investCount");
                }
            }
            //自动增加千分位
            function setPriceFunCommon(cmpId){
            	var oldVal = nui.get(cmpId).getValue();
            	if(oldVal!=null && oldVal!=""){
            		//特殊验证，交易场所：[01-银行间;02-上交所固收平台;03-深交所综合协议平台|上交所大宗;]
                	var tradingPlaceVal = nui.get("tradingPlace").value;//交易场所
                	var newVal = formatNumber(oldVal,4,1);
                	if(tradingPlaceVal=="02" || tradingPlaceVal=="03"){
                		newVal = formatNumber(oldVal,3,1);
                	}
            		nui.get(cmpId).setValue(newVal);
            	}
            }
            //净价（元/百元面值）
            function netPriceFun(){
            	setPriceFunCommon("netPrice");//自动增加千分位-净价（元/百元面值）
            	setBondPriceCommon(nui.get("netPrice").getValue(), null, null, null);//净价、全价、收益率，可以必填其一，选填其他，输入一个另外两个数据可以系统自动算出来
            }
            //全价（元/百元面值）
            function fullPriceFun(){
            	setPriceFunCommon("fullPrice");//自动增加千分位-全价（元/百元面值）
            	setBondPriceCommon(null, nui.get("fullPrice").getValue(), null, null);//净价、全价、收益率，可以必填其一，选填其他，输入一个另外两个数据可以系统自动算出来
            }
            
            //债券代码下拉项点击时触发函数
            function investProductCodeOnItemClick(){
                var investProductCode = nui.get("investProductCode").getValue();//投资产品信息
                if(investProductCode!=null && investProductCode!=""){
                
                	investProductInfoCommon = investProductCode;//给投资产品信息全局变量赋值
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
			                	//var ratingAgenciesVal = investProductCodeArr[5];//评级机构代码
			                	
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
				                
				                
				                //计算净价、全价、收益率联动，供净价、全价、收益率之外的属性值变动时调用
				                setBondPriceUtil();
			                	
			                }else{
			                    nui.alert("债券详细信息获取失败", "系统提示");
			                }
			            }
			        });
	                
                }else{
                	nui.get("investProductCode").setText(null);
	                nui.get("investProductCode").setValue(null);
	                investProductInfoCommon = "";//给投资产品信息全局变量赋值
                }
            }
            
            //是否询价指令/建议：0-否（完整指令/建议）;1-是（询价指令/建议）;
            function isInquiryOnvaluechanged(e){
            	var val = e.value;
            	if(val=="0"){
            		nui.get("investProductCode").setRequired(true);//债券代码
            		nui.get("investProductName").setRequired(true);//债券名称            		
            		nui.get("clearingSpeed").setRequired(true);//清算速度
            		nui.get("tradingPlace").setRequired(true);//交易场所
            		nui.get("investCount").setRequired(true);//券面金额（万元）
            		nui.get("tradingOpponent").setRequired(true);//交易对手
            		nui.get("cleartype").setRequired(true);//清算类型
            	}else{
            		nui.get("investProductCode").setRequired(false);//债券代码
            		nui.get("investProductName").setRequired(false);//债券名称            		
            		nui.get("clearingSpeed").setRequired(false);//清算速度
            		nui.get("tradingPlace").setRequired(false);//交易场所
            		nui.get("investCount").setRequired(false);//券面金额（万元）
            		nui.get("tradingOpponent").setRequired(false);//交易对手
            		nui.get("cleartype").setRequired(false);//清算类型
            	}
            }
            
            //计算净价、全价、收益率，可以必填其一，选填其他，输入一个另外两个数据可以系统自动算出来
            function setBondPriceCommon(netPrice, fullPrice, interestRate, interestRateType){
            	var autoCalc = nui.get("autoCalc");//获取“联动”值（是否勾选）
            	if(autoCalc.checked==false){//若“联动”未勾选，则不自动计算而直接返回
            		return;
            	}
            	
                //以下情况重新获取债券信息
                if(investProductInfoCommon==null || investProductInfoCommon=="" || investProductInfoCommon.split(",").length!=4){
                	var vcReportCode = nui.get("investProductCode").getValue();//债券代码
                	var vcStockName = nui.get("investProductName").getValue();//债券名称
                	
                	$.ajax({
			            url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByReportCodeAndStockName.biz.ext",
			            type:'POST',
			            data:nui.encode({vcReportCode:vcReportCode, vcStockName:vcStockName}),
			            cache:false,
			            contentType:'text/json',
			            success:function(text){
			                var returnJson = nui.decode(text);
			                if(returnJson.exception == null){
			                	investProductInfoCommon = returnJson.investProductInfo;//投资产品信息（债券代码,债券名称,交易市场编号,证券内码）
			                	getBondPriceFun(netPrice, fullPrice, interestRate, interestRateType);
			                }else{
			                    nui.alert("债券详细信息获取失败", "系统提示");
			                }
			            }
			        });
                }else{
                	getBondPriceFun(netPrice, fullPrice, interestRate, interestRateType);
                }
            }
            
            //获取净价、全价、收益率数据
            function getBondPriceFun(netPrice, fullPrice, interestRate, interestRateType){
            	var investProductCode = nui.get("investProductCode").getValue();//债券代码
                //若债券代码包含英文逗号这些，则仅取债券代码
                if(investProductCode!=null && investProductCode!="" && investProductCode.indexOf(",")!=-1){
                	investProductCode = investProductCode.substr(0, investProductCode.indexOf(","));
                }
                //若投资产品信息全局变量的债券代码值不等于债券代码属性的值则直接返回
                if(investProductCode!=investProductInfoCommon.split(",")[0]){
                	return;
                }
                var interCode = investProductInfoCommon.split(",")[3];//获取证券内码[投资产品信息（债券代码,债券名称,交易市场编号,证券内码）]
                var processDate = nui.formatDate(nui.get("processDate").value, "yyyyMMdd");//业务日期
                var tradingPlace = nui.get("tradingPlace").value;//交易场所：[01-银行间;02-上交所固收平台;03-深交所综合协议平台|上交所大宗;]
                var clearingSpeed = nui.get("clearingSpeed").value;//清算速度：T+0、T+1
            	var interestRateTypeP = 1;//收益率类型：[1-到期;2-行权日]
            	if(interestRateType=="02"){
            		interestRateTypeP = 2;
            	}
            	
            	var jsonParam = nui.encode({processDate:processDate, interCode:interCode, netPrice:netPrice, fullPrice:fullPrice, interestRate:interestRate, interestRateType:interestRateTypeP, tradingPlace:tradingPlace, clearingSpeed:clearingSpeed});
            	$.ajax({
		            url:"com.cjhxfund.jy.ProductProcess.ProductProcessUtilBiz.getBondPrice.biz.ext",
		            type:'POST',
		            data:jsonParam,
		            cache:false,
		            contentType:'text/json',
		            success:function(text){
		                var returnJson = nui.decode(text);
		                if(returnJson.exception == null){
		                	var result = returnJson.result;//返回结果：净价，全价，收益率，收益率类型，交易场所，清算速度
		                	var resultArr = result.split("@");
		                	nui.get("netPrice").setValue(resultArr[0]);//净价（元/百元面值）
    						nui.get("fullPrice").setValue(resultArr[1]);//全价（元/百元面值）
    						nui.get("interestRate").setValue(resultArr[2]);//收益率（%）
    						nui.get("interestRateType").setValue(resultArr[3]=="2"?"02":"01");//收益率类型：01-到期;02-行权;
    						nui.get("tradingPlace").setValue(resultArr[4]);//交易场所
    						nui.get("clearingSpeed").setValue(resultArr[5]);//清算速度：T+0、T+1
    						
    						setPriceFunCommon("netPrice");//自动增加千分位-净价（元/百元面值）
    						setPriceFunCommon("fullPrice");//自动增加千分位-全价（元/百元面值）
    						formatNumberCommon("interestRate");//自动增加千分位-收益率（%）
    						if(eval(nui.get("interestRate").getValue())<0){
    							nui.get("interestRate").setValue(0.0000);
    						}
		                }else{
		                    nui.alert("净价、全价、收益率数据获取失败", "系统提示");
		                }
		            }
		        });
            }
            
            //计算净价、全价、收益率联动，供净价、全价、收益率之外的属性值变动时调用
            function setBondPriceUtil(){
            	//计算净价、全价、收益率
                var netPrice = nui.get("netPrice").getValue();//净价（元/百元面值）
				var fullPrice = nui.get("fullPrice").getValue();//全价（元/百元面值）
				var interestRate = nui.get("interestRate").getValue();//收益率（%）
				var interestRateType = nui.get("interestRateType").getValue();//收益率类型：01-到期;02-行权;
                //若传入净价，优先使用净价计算全价、收益率
                if(netPrice!=null && netPrice!=""){
                	setBondPriceCommon(netPrice, null, null, null);
                //若净价为空，存在全价，则使用全价计算净价、收益率
                }else if((netPrice==null||netPrice=="") && (fullPrice!=null && fullPrice!="")){
                	setBondPriceCommon(null, fullPrice, null, null);
                //若净价、全价为空，存在收益率，则使用收益率计算净价、全价
                }else if((netPrice==null||netPrice=="") && (fullPrice==null||fullPrice=="") && (interestRate!=null && interestRate!="")){
                	setBondPriceCommon(null, null, interestRate, interestRateType);
                }
            }
            
            //收益率（%）
            function interestRateFun(){
            	//净价、全价、收益率，可以必填其一，选填其他，输入一个另外两个数据可以系统自动算出来
            	setBondPriceCommon(null, null, nui.get("interestRate").getValue(), nui.get("interestRateType").getValue());
            }
            //收益率类型
            function interestRateTypeValueChangedFun(cmp){
            	interestRateFun();
            }
			
	</script>
</body>
</html>
