<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/CFJYProductProcessForm_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2016-05-13 11:42:39
- Description: 指令/建议录入指令/建议单_大宗交易
--%>
<head>
<title>指令/建议录入指令/建议单_大宗交易</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <input class="nui-hidden" name="cfjyproductprocess.processType4InvestProductNum" value="19"/>
            <input class="nui-hidden" name="cfjyproductprocess.processType" value="19"/>
            <input class="nui-hidden" name="cfjyproductprocess.processId"/>
            <input class="nui-hidden" name="cfjyproductprocess.processStatus" id="processStatus"/>
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                <tr>
                    <td align="right" width="20%">
                        业务日期:
                    </td>
                    <td colspan="1" width="30%">
                        <input id="processDate" class="nui-datepicker" name="cfjyproductprocess.processDate" required="true" style="width:150px;"/>
                    </td>
                    <td align="right" width="20%">
                       买卖方向:
                    </td>
                    <td colspan="1" width="30%">
                        <input id="deliveryMethod" class="nui-dictcombobox" dictTypeId="CF_JY_MMFX" name="cfjyproductprocess.deliveryMethod" 
                        emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" style="width:150px;"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="20%">
                        产品名称:
                    </td>
                    <td colspan="1" width="30%">
                        <input id="combProductCode" required="true" class="nui-autocomplete" style="width:150px;" name="cfjyproductprocess.combProductCode" searchField="searchKey" dataField="combProducts"
                        	valueField="fundCode" textField="fundName" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductsByKeyAndUserId.biz.ext" value="" text="" enterQuery="false" onvaluechanged="changedCombProductCode"/>
                        <input id="combProductName" class="nui-hidden" name="cfjyproductprocess.combProductName"/>
                    </td>
                    <td align="right" width="20%">
                        组合名称:
                    </td>
                    <td colspan="1" width="30%">
                    	<input class="nui-combobox" id="vcCombiNo" style="width:150px;"  required="true" dataField="productCombis"  name="cfjyproductprocess.vcCombiNo" 
	                        valueField="vcCombiNo" textField="vcCombiName" onvaluechanged="setVcCombiName" searchField="searchKey" value="" text="" enterQuery="false"/>
	                      <input class="nui-hidden" id="vcCombiName" name="cfjyproductprocess.vcCombiName"/>
                    </td>
                </tr>
                <tr>
                   <td align="right" width="23%">
                        证券代码:
                    </td>
                    <td colspan="1" width="27%">
                        <input id="investProductCode" class="nui-autocomplete" popupWidth="300" popupHeight="200" name="cfjyproductprocess.investProductCode" searchField="searchKey" dataField="investProducts"
                        	valueField="investProductInfo" textField="investProduct" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByKey.biz.ext" value="" text="" enterQuery="false"
                        	onvaluechanged="enterSumbit" onitemclick="investProductCodeOnItemClick" style="width:150px;" required="true"/>
                    </td>
                    <td align="right" width="23%">
                        证券名称:
                    </td>
                    <td colspan="1" width="27%">
                        <input id="investProductName" class="nui-textbox" style="width:150px;" name="cfjyproductprocess.investProductName" required="true"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" >
                      指令/建议价格(元):
                    </td>
                    <td colspan="1">
                        <input id="netPrice" class="nui-textbox"  name="cfjyproductprocess.netPrice"  required="true" onblur="netPriceFun()" style="width:150px;"/>
                    </td>
                    <td align="right" >
                       委托数量(股):
                    </td>
                    <td colspan="1">
                        <input id="investCount" class="nui-textbox" name="cfjyproductprocess.investCount"  onblur="investCountFun()" required="true" style="width:150px;"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" >
                      对方席位号:
                    </td>
                    <td colspan="1">
                        <input id="seatNum" class="nui-textbox"  name="cfjyproductprocess.seatNum" style="width:150px;"/>
                    </td>
                    <td align="right" >
                       约定号:
                    </td>
                    <td colspan="1">
                        <input id="agreementNum" class="nui-textbox" name="cfjyproductprocess.agreementNum" style="width:150px;"/>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                      交易对手名称:
                    </td>
                    <td colspan="1">
                        <input id="tradingOpponent" class="nui-textbox"  name="cfjyproductprocess.tradingOpponent" required="true" style="width:150px;"/>
                    </td>
                    <td align="right">
                       关联关系:
                    </td>
                    <td colspan="1" class="radio-border-top-none">
						<input id="interestRateType" name="cfjyproductprocess.interestRateType"  class="nui-radiobuttonlist" repeatItems="2" repeatLayout="none" repeatDirection="vertical"
						    textField="text" valueField="id" value="无关联关系" data="[{id: '有关联关系', text: '有'}, {id: '无关联关系', text: '无'}]" />
			        </td>
                </tr>
                <tr>
                    <td align="right">
                        备注:
                    </td>
                    <td colspan="3">
                        <input class="nui-textarea"name="cfjyproductprocess.remark" width="100%" height="100"/>
                    </td>
                </tr>
            </table>
            <div class="nui-toolbar" borderStyle="border:0;">
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
                
                
            //获取产品名称值
            var combProductCodeVal = nui.get("combProductCode").getValue();//获取产品代码值
            var combProductNameVal = nui.get("combProductCode").getText();//获取产品名称值（从表单显示值取）
            nui.get("combProductName").setValue(combProductNameVal);
            if(combProductCodeVal==combProductNameVal){
                nui.alert("请输入选择正确的产品名称","提示");
            	nui.get("combProductCode").focus();
			    return;
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
              nui.get("combProductCode").setText(combProductNameVal);//设置产品名称值
              nui.get("combProductName").setValue(combProductNameVal);
              
              //设置显示债券代码
              nui.get("investProductCode").setText(json.cfjyproductprocess.investProductCode);
                            
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


      //值修改时触发函数
	  function enterSumbit(e){  
		  investProductCodeOnItemClick();
	  }
 		
	 //债券代码下拉项点击时触发函数
	 function investProductCodeOnItemClick(){
		var investProductCode = nui.get("investProductCode").getValue();//投资产品信息
		if(investProductCode!=null && investProductCode!=""){
		  if(investProductCode.indexOf(",")!=-1){		                	
			//通过交易市场编号、证券申报代码到O32系统查找投资的债券、股票等产品信息（包含债券评级等债券属性）
			var paramArr = investProductCode.split(",");
			nui.get("investProductCode").setText(paramArr[0]);
			nui.get("investProductCode").setValue(paramArr[0]);
			nui.get("investProductName").setValue(paramArr[1]);
		  }	
		}else{
		    nui.get("investProductCode").setText(null);
			nui.get("investProductCode").setValue(null);
		}
	  }
	  
	//指令/建议价格(元)
    function netPriceFun(){
		formatNumberCommon("netPrice",3);
	}
     
	//委托数量(股)
	function investCountFun(){
		formatNumberCommon("investCount",0);
	}
   </script>
   </body>
</html>
