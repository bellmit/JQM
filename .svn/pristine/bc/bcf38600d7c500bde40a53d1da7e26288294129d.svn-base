<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/js/commscripts.jsp" %>
<%@page import="com.eos.data.datacontext.UserObject"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 谢海光
  - Date: 2017-08-22 15:43:29
  - Description:
-->
<head>
<title>主承销商自定义列导出</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
     <div id="dataform1" style="padding-top:0px; " >
         <form id="queryForm" action="">
            <input   id="excelData"   class="nui-hidden" name="excelData"/>
            <input   id="fileName"   class="nui-hidden" name="fileName"/>
            <input   id="type"   class="nui-hidden" name="type"/>
            <input   type="hidden" class="nui-hidden" id="userName" name="userName" value="<%=userObject.getUserId() %>" />
            <input   id="customChineseName"   class="nui-hidden" name="customChineseName"/>
            <input   id="customEnglishName"   class="nui-hidden" name="customEnglishName"/>
            <table style="width:aotu;height:223px;table-layout:fixed;" class="nui-form-table" align="center" >
                <tr>
                    <td class="form_label" align="left" >
                        	<div id="vcMainUnderwriter" name="custom.vcMainUnderwriter" class="mini-checkbox" readOnly="false" text="主承销商"></div>
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcUnderwriterContactInfo" name="custom.vcUnderwriterContactInfo" class="mini-checkbox" readOnly="false" text="主承销商相关联系方式" ></div> 
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcApplicationTime" name="custom.vcApplicationTime" class="mini-checkbox" readOnly="false" text="发行时间" ></div>  
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcEntryTime" name="custom.vcEntryTime" class="mini-checkbox" readOnly="false" text="簿记时间" ></div>  
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcIssuerNameFull" name="custom.vcIssuerNameFull" class="mini-checkbox" readOnly="false" text="发行主体" ></div>  
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="left" >
                        	<div id="vcStockType" name="custom.vcStockType" class="mini-checkbox" readOnly="false" text="债券类别"></div>
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcIssueType" name="custom.vcIssueType" class="mini-checkbox" readOnly="false" text="发行方式" ></div> 
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcStockName" name="custom.vcStockName" class="mini-checkbox" readOnly="false" text="债券简称" ></div>  
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcStockNameFull" name="custom.vcStockNameFull" class="mini-checkbox" readOnly="false" text="债券全称" ></div>  
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcIssueBalance" name="custom.vcIssueBalance" class="mini-checkbox" readOnly="false" text="发行规模(亿)" ></div>  
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="left" >
                        	<div id="vcExistLimite" name="custom.vcExistLimite" class="mini-checkbox" readOnly="false" text="发行期限(年)"></div>
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcExistLimiteDesc" name="custom.vcExistLimiteDesc" class="mini-checkbox" readOnly="false" text="发行期限备注" ></div> 
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcInquiryInterval" name="custom.vcInquiryInterval" class="mini-checkbox" readOnly="false" text="询价区间" ></div>  
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcIssueAppraise" name="custom.vcIssueAppraise" class="mini-checkbox" readOnly="false" text="主体评级" ></div>  
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcBondAppraise" name="custom.vcBondAppraise" class="mini-checkbox" readOnly="false" text="债券评级" ></div>  
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="left" >
                        	<div id="vcAppraiseOrgan" name="custom.vcAppraiseOrgan" class="mini-checkbox" readOnly="false" text="债券评级机构"></div>
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcPaymentPlace" name="custom.vcPaymentPlace" class="mini-checkbox"  readOnly="false" text="登记托管机构" ></div> 
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcDueDate" name="custom.vcDueDate" class="mini-checkbox" readOnly="false" text="预计到期日" ></div>  
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcPayInteval" name="custom.vcPayInteval" class="mini-checkbox" readOnly="false" text="还本付息方式" ></div>  
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcBegincalDate" name="custom.vcBegincalDate" class="mini-checkbox" readOnly="false" text="起息日" ></div>  
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="left" >
                        	<div id="vcCreditSituation" name="custom.vcCreditSituation" class="mini-checkbox" readOnly="false" text="增信情况"></div>
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcEnterpriseProperty" name="custom.vcEnterpriseProperty" class="mini-checkbox" readOnly="false" text="企业性质" ></div> 
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcIsBid" name="custom.vcIsBid" class="mini-checkbox" readOnly="false" text="是否城投" ></div>  
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcMarkAssets" name="custom.vcMarkAssets" class="mini-checkbox" readOnly="false" text="标的资产" ></div>  
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcOldHolder" name="custom.vcOldHolder" class="mini-checkbox" readOnly="false" text="原始权益人" ></div>  
                    </td>
                </tr>
                
                <tr>
                    <td class="form_label" align="left" >
                        	<div id="vcIsPledge" name="custom.vcIsPledge" class="mini-checkbox" readOnly="false" text="是否可质押"></div>
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcPropertyDesc" name="custom.vcPropertyDesc" class="mini-checkbox" readOnly="false" text="资质简介" ></div> 
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcHisIssue" name="custom.vcHisIssue" class="mini-checkbox" readOnly="false" text="历史发债" ></div>  
                    </td>
                    <td class="form_label" align="left" >
                        	&nbsp;&nbsp;<div id="vcIsHaveFinancing" name="custom.vcIsHaveFinancing" class="mini-checkbox" readOnly="false" text="是否有过融资历史" ></div>  
                    </td>
                </tr>
               
            </table>
            </form>
        </div>
        <div class="nui-toolbar" style="border:0; top:0px">
		    <table style="width:100%;">
		       <tr>
		           <td style="text-align:center;">
		                <a class="nui-button" onclick="checkAll()"  iconCls="icon-edit">全选</a>
		                <span style="display:inline-block;width:25px;"></span>
		               	<a class="nui-button"  iconCls="icon-ok" onclick="onOk()">导出</a>
		        		<span style="display:inline-block;width:25px;"></span>
		        		<a class="nui-button"   iconCls="icon-cancel" onclick="onCancel()">取消</a>
		           </td>
		       </tr>
		    </table>
		</div>   
        


	<script type="text/javascript">
    	nui.parse();
		
		var form = new nui.Form("#dataform1");
		var userId=<%=userObject.getUserId()%>;
		var cStatus="2";
		var lUnderwriterTemp="1";
		function SetDataInit(data){
    	 var json =nui.encode({userName:userId,cStatus:cStatus,lUnderwriterTemp:lUnderwriterTemp});
				nui.ajax({
				    url: "com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryImportOrExportCustomUnderwriter.biz.ext",
				    type: "post",
				    data: json,
				    dataType:"json",
				    success: function (text) {
				        form.setData({custom:text.underwriterInport[0]}); //表单数据初始化
				        nui.get("excelData").setValue(data.excelData);
    	                nui.get("fileName").setValue(data.fileName);
    	                nui.get("type").setValue(data.type);
				    }
			});
		 
    	}  

    	function onOk(){
    	    var frm = document.getElementById("queryForm");
    	    var data = form.getData(false,true).custom;
    	    var arrChineseName = [];
    	    var arrEnglishName = [];
    	    var str="";
    	    var strChinese="";
              for ( var i in data ){
                 if(data[i]=="true"){
                    str = i;
                    strChinese=nui.get(str).getText();
                    arrEnglishName.push(str);
                    arrChineseName.push(strChinese);
                 }
              }
              if(str==""){
                 nui.alert("不能导出为空！");
                 return;
              }
              nui.get("customEnglishName").setValue(arrEnglishName.join(","));
              nui.get("customChineseName").setValue(arrChineseName.join(","));
    	    
    	    frm.action = "com.cjhxfund.ats.fm.baseinfo.debtIssueExport.flow";
		    frm.submit();
		    
		    var url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.saveUnderwriterExport.biz.ext";
              var data = form.getData(false,true);
              data.custom.cStatus="2";
              data.custom.lUnderwriterTemp="1";
              data.custom.lOperatorNo=userId;
              var json =nui.encode(data);
				nui.ajax({
				    url: url,
				    type: "post",
				    data: json,
				    dataType:"json",
				    success: function (text) {
				       
				    }
				});
		    
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


        //取消
        function onCancel() {
            CloseWindow("cancel");
        }
        var all=true;
        function checkAll(){
           if(all){
               all=false;
               var vcMainUnderwriter = nui.get("vcMainUnderwriter");
	           vcMainUnderwriter.setChecked(true);
	           var vcUnderwriterContactInfo = nui.get("vcUnderwriterContactInfo");
	           vcUnderwriterContactInfo.setChecked(true);
	           var vcApplicationTime = nui.get("vcApplicationTime");
	           vcApplicationTime.setChecked(true);
	           var vcEntryTime = nui.get("vcEntryTime");
	           vcEntryTime.setChecked(true);
	           var vcIssuerNameFull = nui.get("vcIssuerNameFull");
	           vcIssuerNameFull.setChecked(true);
	           
	           var vcStockType = nui.get("vcStockType");
	           vcStockType.setChecked(true);
	           var vcIssueType = nui.get("vcIssueType");
	           vcIssueType.setChecked(true);
	           var vcStockName = nui.get("vcStockName");
	           vcStockName.setChecked(true);
	           var vcStockNameFull = nui.get("vcStockNameFull");
	           vcStockNameFull.setChecked(true);
	           var vcIssueBalance = nui.get("vcIssueBalance");
	           vcIssueBalance.setChecked(true);
	           
	           var vcExistLimite = nui.get("vcExistLimite");
	           vcExistLimite.setChecked(true);
	           var vcExistLimiteDesc = nui.get("vcExistLimiteDesc");
	           vcExistLimiteDesc.setChecked(true);
	           var vcInquiryInterval = nui.get("vcInquiryInterval");
	           vcInquiryInterval.setChecked(true);
	           var vcIssueAppraise = nui.get("vcIssueAppraise");
	           vcIssueAppraise.setChecked(true);
	           var vcBondAppraise = nui.get("vcBondAppraise");
	           vcBondAppraise.setChecked(true);
	           
	           var vcAppraiseOrgan = nui.get("vcAppraiseOrgan");
	           vcAppraiseOrgan.setChecked(true);
	           var vcPaymentPlace = nui.get("vcPaymentPlace");
	           vcPaymentPlace.setChecked(true);
	           var vcDueDate = nui.get("vcDueDate");
	           vcDueDate.setChecked(true);
	           var vcPayInteval = nui.get("vcPayInteval");
	           vcPayInteval.setChecked(true);
	           var vcBegincalDate = nui.get("vcBegincalDate");
	           vcBegincalDate.setChecked(true);
	           
	           var vcCreditSituation = nui.get("vcCreditSituation");
	           vcCreditSituation.setChecked(true);
	           var vcEnterpriseProperty = nui.get("vcEnterpriseProperty");
	           vcEnterpriseProperty.setChecked(true);
	           var vcIsBid = nui.get("vcIsBid");
	           vcIsBid.setChecked(true);
	           var vcMarkAssets = nui.get("vcMarkAssets");
	           vcMarkAssets.setChecked(true);
	           var vcOldHolder = nui.get("vcOldHolder");
	           vcOldHolder.setChecked(true);
	           
	           var vcIsPledge = nui.get("vcIsPledge");
	           vcIsPledge.setChecked(true);
	           var vcPropertyDesc = nui.get("vcPropertyDesc");
	           vcPropertyDesc.setChecked(true);
	           var vcHisIssue = nui.get("vcHisIssue");
	           vcHisIssue.setChecked(true);
	           var vcIsHaveFinancing = nui.get("vcIsHaveFinancing");
	           vcIsHaveFinancing.setChecked(true);
           }else{
               var vcMainUnderwriter = nui.get("vcMainUnderwriter");
	           vcMainUnderwriter.setChecked(!vcMainUnderwriter.getChecked());
	           var vcUnderwriterContactInfo = nui.get("vcUnderwriterContactInfo");
	           vcUnderwriterContactInfo.setChecked(!vcUnderwriterContactInfo.getChecked());
	           var vcApplicationTime = nui.get("vcApplicationTime");
	           vcApplicationTime.setChecked(!vcApplicationTime.getChecked());
	           var vcEntryTime = nui.get("vcEntryTime");
	           vcEntryTime.setChecked(!vcEntryTime.getChecked());
	           var vcIssuerNameFull = nui.get("vcIssuerNameFull");
	           vcIssuerNameFull.setChecked(!vcIssuerNameFull.getChecked());
	           
	           var vcStockType = nui.get("vcStockType");
	           vcStockType.setChecked(!vcStockType.getChecked());
	           var vcIssueType = nui.get("vcIssueType");
	           vcIssueType.setChecked(!vcIssueType.getChecked());
	           var vcStockName = nui.get("vcStockName");
	           vcStockName.setChecked(!vcStockName.getChecked());
	           var vcStockNameFull = nui.get("vcStockNameFull");
	           vcStockNameFull.setChecked(!vcStockNameFull.getChecked());
	           var vcIssueBalance = nui.get("vcIssueBalance");
	           vcIssueBalance.setChecked(!vcIssueBalance.getChecked());
	           
	           var vcExistLimite = nui.get("vcExistLimite");
	           vcExistLimite.setChecked(!vcExistLimite.getChecked());
	           var vcExistLimiteDesc = nui.get("vcExistLimiteDesc");
	           vcExistLimiteDesc.setChecked(!vcExistLimiteDesc.getChecked());
	           var vcInquiryInterval = nui.get("vcInquiryInterval");
	           vcInquiryInterval.setChecked(!vcInquiryInterval.getChecked());
	           var vcIssueAppraise = nui.get("vcIssueAppraise");
	           vcIssueAppraise.setChecked(!vcIssueAppraise.getChecked());
	           var vcBondAppraise = nui.get("vcBondAppraise");
	           vcBondAppraise.setChecked(!vcBondAppraise.getChecked());
	           
	           var vcAppraiseOrgan = nui.get("vcAppraiseOrgan");
	           vcAppraiseOrgan.setChecked(!vcAppraiseOrgan.getChecked());
	           var vcPaymentPlace = nui.get("vcPaymentPlace");
	           vcPaymentPlace.setChecked(!vcPaymentPlace.getChecked());
	           var vcDueDate = nui.get("vcDueDate");
	           vcDueDate.setChecked(!vcDueDate.getChecked());
	           var vcPayInteval = nui.get("vcPayInteval");
	           vcPayInteval.setChecked(!vcPayInteval.getChecked());
	           var vcBegincalDate = nui.get("vcBegincalDate");
	           vcBegincalDate.setChecked(!vcBegincalDate.getChecked());
	           
	           var vcCreditSituation = nui.get("vcCreditSituation");
	           vcCreditSituation.setChecked(!vcCreditSituation.getChecked());
	           var vcEnterpriseProperty = nui.get("vcEnterpriseProperty");
	           vcEnterpriseProperty.setChecked(!vcEnterpriseProperty.getChecked());
	           var vcIsBid = nui.get("vcIsBid");
	           vcIsBid.setChecked(!vcIsBid.getChecked());
	           var vcMarkAssets = nui.get("vcMarkAssets");
	           vcMarkAssets.setChecked(!vcMarkAssets.getChecked());
	           var vcOldHolder = nui.get("vcOldHolder");
	           vcOldHolder.setChecked(!vcOldHolder.getChecked());
	           
	           var vcIsPledge = nui.get("vcIsPledge");
	           vcIsPledge.setChecked(!vcIsPledge.getChecked());
	           var vcPropertyDesc = nui.get("vcPropertyDesc");
	           vcPropertyDesc.setChecked(!vcPropertyDesc.getChecked());
	           var vcHisIssue = nui.get("vcHisIssue");
	           vcHisIssue.setChecked(!vcHisIssue.getChecked());
	           var vcIsHaveFinancing = nui.get("vcIsHaveFinancing");
	           vcIsHaveFinancing.setChecked(!vcIsHaveFinancing.getChecked());
           }
       }     
    </script>
</body>
</html>