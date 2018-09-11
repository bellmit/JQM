<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): CJ-WB-DT13
- Date: 2016-01-25 17:40:16
- Description:
 --%>
    <head>
        <title>
            CfJyBusinessBoneTable录入
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
	    <script src="<%= request.getContextPath() %>/process/util/FirstGradeBond.js" type="text/javascript"></script>
    </head>
    <body style="width: 100%;height: 100%;overflow: hidden;">
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="tabs" class="nui-tabs" style="width: 100%;height: 95%;">
           <div title="基本信息" >
              <div id="dataform1" style="padding-top:5px;">
	            <!-- hidden域 -->
	            <input class="nui-hidden" name="maintable.bizId" id="bizId" id="bizId"/>
	            <!-- 业务子表参数 -->
	            <input class="nui-hidden" id="btId"  name="cfjybusinessbonetable.btId" />
	            <input class="nui-hidden" name="cfjybusinessbonetable.bizId"/>
	            <input class="nui-hidden" name="cfjybusinessbonetable.businesstype" value="1"/>
	            <input class="nui-hidden" id="cfjybusinessbonetable.investproductnum" name="cfjybusinessbonetable.investproductnum"/>
	            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
	                <tr>
	                    <td class="form_label" width="27%" align="right">
	                        业务日期:
	                    </td>
	                    <td colspan="1" width="25%">
	                        <input class="nui-datepicker" format="yyyy-MM-dd" name="cfjybusinessbonetable.processDate" width="170" id="processDate" required="true"/>
	                    </td>
	                    <td class="form_label" align="right" width="23%">
	                        主承机构:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.mainBearingMechanism" width="170"/>
	                    </td>
	                </tr>
	                <tr>
	                  <td class="form_label" align="right">
	                        产品名称:
	                  </td>
	                  <td colspan="1">
	                      <input class="nui-autocomplete" id="combProductCode" width="170" required="true" dataField="combProducts"  name="cfjybusinessbonetable.combProductCode" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductsByKeyAndUserId.biz.ext"
	                         valueField="fundCode" textField="fundName" onvaluechanged="setCombProductName" searchField="searchKey" value="" text="" enterQuery="false"/>
	                      <input class="nui-hidden"id="combProductName" name="cfjybusinessbonetable.combProductName"/>
	                  </td>
	                  <td class="form_label" width="25%" align="right">
	                        组合名称:
	                  </td>
	                  <td colspan="1" width="25%">
	                      <input class="nui-combobox" id="vcCombiNo" width="170" required="true" dataField="productCombis"  name="cfjybusinessbonetable.vcCombiNo" 
	                        valueField="vcCombiNo" textField="vcCombiName" onvaluechanged="setVcCombiName" searchField="searchKey" value="" text="" enterQuery="false"/>
	                      <input class="nui-hidden"id="vcCombiName" name="cfjybusinessbonetable.vcCombiName"/>
	                      
	                  </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                        债券代码:
	                    </td>
	                    <td colspan="1">
	                        <%--<input class="nui-textbox" name="cfjybusinessbonetable.investProductCode"/>--%>
	                        <input  id="investProductCode"  width="170" class="nui-autocomplete" popupWidth="300" popupHeight="200" name="cfjybusinessbonetable.investProductCode" searchField="searchKey" dataField="investProducts"
	                        	valueField="investProductInfo" onvaluechanged="enterSumbit" textField="investProduct" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByKey.biz.ext"  value="" text="" enterQuery="false" onitemclick="investProductCodeOnItemClick"/>
	                    </td>
	                    <td class="form_label" align="right">
	                        债券名称:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" id="investProductName" required="true" width="170" name="cfjybusinessbonetable.investProductName"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                        登记托管场所:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"  width="170" name="cfjybusinessbonetable.paymentplace"/>
	                    </td>
	                    <td class="form_label" align="right">
	                        发行主体:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" width="170" name="cfjybusinessbonetable.ratingname"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                        主体类型:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_ZTLX" width="170" name="cfjybusinessbonetable.ratingType" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
	                    </td>
	                    <td class="form_label" align="right">
	                        主体评级:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" width="170" id="subjectrating" name="cfjybusinessbonetable.subjectrating" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
	                    </td>
	                </tr>
	                <tr id="tr1">
	                    <td class="form_label" align="right">
	                        投标金额(万元):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox"  required="true" name="cfjybusinessbonetable.investcount" id="investcount" width="170" onblur="investCountFun()"/>
	                    </td>
	                    <td class="form_label" align="right">
	                        投标利率(%):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" required="true" name="cfjybusinessbonetable.interestrate" width="170"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                        债项评级:
	                    </td>
	                    <td colspan="1"> 
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" id="bondrating" width="170" name="cfjybusinessbonetable.bondrating" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
	                    </td>
	                    <td class="form_label" align="right">
	                        债券种类:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" required="true" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_CATEGORY" width="170" id="investcategory" name="cfjybusinessbonetable.investcategory" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                        评级机构:
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_RATING_AGENCIES" width="170" id="ratingAgencies" name="cfjybusinessbonetable.ratingagencies" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true"/>
	                    </td>
	                    <td class="form_label" align="right">
	                       发行规模(万元):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" id="issueSize" name="cfjybusinessbonetable.issueSize" width="170" onblur="issueSizeFun"/>
	                    </td>
	                </tr>
	                <tr>
	                     <td class="form_label" align="right">
	                        已投资该发行主体证券存量(万元):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="cfjybusinessbonetable.categorymoney" onblur="categoryMoneyFun" id="categorymoney" width="170"/>
	                    </td>
	                     <td class="form_label" align="right">
	                        债券期限(年):
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" required="true" name="cfjybusinessbonetable.categorydate" width="170"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label td1" align="right">
	                        产品净值规模(万元):
	                    </td>
	                    <td colspan="1" class="td2">
							<input class="nui-textbox" name="cfjybusinessbonetable.netWorthScale" id="netWorthScale" onblur="netWorthScaleFun" style="width: 170px;"  />
	                    </td>
	                    <td class="form_label td1" align="right">
	                        首次付息日:
	                    </td>
	                    <td colspan="1" class="td2">
							<input class="nui-datepicker" name="cfjybusinessbonetable.initialInterestPaymentDate" id="initialInterestPaymentDate" style="width: 170px;"  />
	                    </td>
	                 </tr>
	                <tr>
	                   <td class="form_label" align="right">
	                        是否具有回售权:
	                    </td>
	                    <td colspan="1" class="radio-border-top-none">
	                        <input id="resaleRight" class="nui-radiobuttonlist" name="cfjybusinessbonetable.resaleRight" 
	                        value="0" repeatItems="1"
	                         repeatLayout="none" repeatDirection="horizontal"
	                          textField="text" valueField="id" url="./IsInquiryData.txt" style="float: left;"
	                          onvaluechanged="resaleRightOnvaluechanged(e)"/>
	                          &nbsp;<label id="lable1" style="float: left;display: none;">行权年：
	                          <input class="nui-dictcombobox" dictTypeId="CF_JY_XQNNX" name="cfjybusinessbonetable.resaleYear" id="resaleYear" width="45"/></label>
	                    </td>
	                    <td class="form_label" align="right"> 
	                        是否具有赎回权:
	                    </td>
	                    <td colspan="1" class="radio-border-top-none">
	                        <input id="redemptionRight" class="nui-radiobuttonlist" name="cfjybusinessbonetable.redemptionRight" 
	                        value="0" repeatItems="1"
	                         repeatLayout="none" repeatDirection="horizontal"
	                          textField="text" valueField="id" url="./IsInquiryData.txt" style="float: left;"
	                          onvaluechanged="redemptionRightOnvaluechanged(e)"/>
	                          &nbsp;<label id="lable2" style="float: left;display: none;">行权年：
	                          <input class="nui-dictcombobox" dictTypeId="CF_JY_XQNNX" name="cfjybusinessbonetable.redemptionYear" id="redemptionYear" width="45"/></label>
	                    </td>
	                </tr>                
	                 <tr>
	                   <td class="form_label" align="right">
	                        是否关联交易:
	                    </td>
	                    <td colspan="1" class="radio-border-top-none">
	                       
	                        <input id="isInquiry" class="nui-radiobuttonlist" name="cfjybusinessbonetable.associationBetween" 
	                        value="0" repeatItems="1"
	                         repeatLayout="none" repeatDirection="horizontal"
	                          textField="text" valueField="id" url="./IsInquiryData.txt" style="float: left;"
	                          onvaluechanged="isInquiryOnvaluechanged(e)"/>
	                          <input class="nui-textbox" name="cfjybusinessbonetable.associationRemark" id="associationRemark" style="display: none;"width="100"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="form_label" align="right">
	                        备注:
	                    </td>
	                    <td colspan="3">
	                        <input class="nui-textarea" width="590" height="60" name="cfjybusinessbonetable.remarks"/>
	                    </td>
	                </tr>
	                <tr id="tr1">
	                  <td class="form_label" align="right">
	                        附件上传:
	                  </td>
	                  <td colspan="3">
	                     <iframe id="prodIfm" width="590"  height="110px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"  ></iframe>
	                  </td>
	                </tr>
	            </table>
	        </div>
           </div>
           <div id="tab1" title="产品投资范围"></div>
        </div>
        <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
	         <table width="100%">
	             <tr>
	               <td style="text-align:center;" colspan="4">
	                  <a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">
	                                保存
	                  </a>
	                  <span style="display:inline-block;width:25px;"></span>
	                  <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
	                                取消
	                  </a>
	                </td>
	              </tr>
	          </table>
	      </div>
        <script type="text/javascript">
            nui.parse();
            
            //设置默认时间
            nui.get("processDate").setValue(new Date());
			var contextPath = '<%=request.getContextPath() %>';
			
            function saveData(){
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                
                //获取产品名称并设置
                var combProductCodeVal = nui.get("combProductCode").getValue();//获取产品代码值
                var combProductNameVal = nui.get("combProductCode").getText();//获取产品名称值（从表单显示值取）
                nui.get("combProductName").setValue(combProductNameVal);
                
                //判断产品编号与产品名称是否一样。一样说明产品名称不对
			    if(combProductCodeVal==combProductNameVal){
                	nui.alert("请输入选择正确的产品名称","提示");
            		nui.get("combProductCode").focus();
			        return;
                }
                
                //设置组合名称
				nui.get("vcCombiName").setValue(nui.get("vcCombiNo").getText());

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //保存
                var urlStr = "com.cjhxfund.jy.process.cfjybusinessbonetablebiz.addCfJyBusinessBoneTable.biz.ext";
                if(pageType == "edit"){
                  	urlStr = "com.cjhxfund.jy.process.cfjybusinessbonetablebiz.updateFirstGradeBond_FKZZ.biz.ext";
                }
                 
               
                form.validate();
                if(form.isValid()==false) return;

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
                        if(returnJson.exception == null && returnJson.returnValue == "y"){
                          nui.alert("保存成功", "系统提示", function(action){
                           if(action == "ok" || action == "close"){
                            	CloseWindow("saveSuccess");
                            }
                          });  
                        } else if(returnJson.returnValue == "false"){
                           nui.alert("当前流程环节暂不支持修改要素,请通知当前处理人回退或废弃后重新发起。", "系统提示", function(action){
                              if(action == "ok" || action == "close"){
                            	CloseWindow("saveSuccess");
                              }
                           });
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
 
		        //自动增加千分位-交易数量（万元）
            	function investCountFun(){
                	formatNumberCommon("investcount",0);
            	}
            	//发行规模(万元)
            	function issueSizeFun(){
            	   formatNumberCommon("issueSize",0);
            	}
            	
            	//已投资该发行主体证券存量(万元)
            	function categoryMoneyFun(){
            	   formatNumberCommon("categorymoney",0);
            	}
            	
            	// 产品净值规模(万元)
            	function netWorthScaleFun(){
            	   formatNumberCommon("netWorthScale",0);
            	}
            	
            	//初始化数据
				function inIt(){
				     
				    var data = {entityName:'com.cjhxfund.jy.process.FirstGradeBond.CfCyBusinessMainTable'};
				    var json = nui.encode(data);
				       $.ajax({
				        url:"com.cjhxfund.jy.process.cfjybusinessbonetablebiz.generatePrimaryKey.biz.ext",
				        type:'POST',
				        data:json,
				        cache:false,
				        contentType:'text/json',
				        success:function(text){
				            var returnJson = nui.decode(text);
				            //var form = new nui.Form("#dataform1");//将普通form转为nui的form
				            //    form.setData(returnJson);
				            //    form.setChanged(false);
				            nui.get("bizId").setValue(returnJson.maintable.bizId);
				             var prodIfm = document.getElementById("prodIfm");   
				             prodIfm.src = "<%= request.getContextPath() %>/process/fileupload/any_upload.jsp?bizId="+returnJson.maintable.bizId+"&attachType=0&attachBusType=0";
				          }
				      });	
				}
            	
            	
				function DynamicLoadingTabs(){
				   var combProductCode = nui.get("combProductCode").getValue();
				   //获取tabs对象
				   var tabs = nui.get("tabs");
				   //获取tabs数组
		           var tabsAyyay = tabs.getTabs();
		           //选择tabs面板
		           //var tab = tabs.activeTab(tabsAyyay[1]);
		           //重新加载tabs面板
            	   tabs.loadTab("<%=request.getContextPath() %>/process/FirstGradeBond/ProductInvestmentRange.jsp?combProductCode="+combProductCode, tabsAyyay[1]);
				}
				
		/*
		*调整文件的iframe窗口大小
		*/
		function setFileFrmHeight(fileSize){
			//document.getElementById("prodIfm").style.height = getFileFrameSize(fileSize) + "px";
			//document.getElementById("tr1").style.height = getFileFrameSize(fileSize) + "px";
			//alert(document.getElementById("tr1").style.height);
		}

		/*
		*获取文件的iframe窗口大小
		*/
		function getFileFrameSize(fileSize){
			var frameHeight = 0 ;
			var buttonHeight = 30;
			var tableHeight = 43;
			if(fileSize<1){
				frameHeight = buttonHeight;
			}else if(0 < fileSize && fileSize < 5){
				frameHeight = buttonHeight + tableHeight + 23 * fileSize;
			}else{
				frameHeight = buttonHeight + tableHeight + 23 * 5;
			}
			return frameHeight;
		}
		
		function enterSumbit(e){  
		    
			var investProductCode = e.value;
	        var   i = investProductCode.indexOf(",");
	           //获取参数值，并判断有没有","分割.有分割参数并赋值
	           if(investProductCode!=null && investProductCode!="" && investProductCode.indexOf(",")!=-1){
	
	                var investProductCodes = investProductCode.split(",");
	                //nui.get("investProductCode").setValue(investProductCodes[0]);//债券代码
	                nui.get("investProductCode").setText(investProductCodes[0]);
	                nui.get("investProductName").setValue(investProductCodes[1]);
	           }
	           if(i != -1){
	       		investProductCodeOnItemClick();
	     	   } 
 		}
 		
    
 		</script>
      </body>
   </html>
