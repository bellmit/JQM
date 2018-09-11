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
<style type="text/css">
  .form_label{
    font-size: 9pt;
    font-family: Tahoma,Verdana,宋体;
    line-height: 22px;
    font-weight: bold;
  }
</style>

<head>
<title>主承销商自定义列导入</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
     <div id="dataform1" style="padding-top:0px; " >
         <form id="queryForm" action="">
            <div style="text-align:center;padding-top:10px;padding-bottom:5px;" class="form_label">
                              请选择模板设置用户:<input class="nui-buttonedit" onclick="selectSendUser" name="userTemp" id="userTemp" align="middle"/>
            </div>  
            <!-- <input id="lOperatorNo"   class="nui-hidden" name="underwriter.lOperatorNo"/> -->
            <table style="width:aotu;height:223px;table-layout:fixed;" class="nui-form-table" align="center" >
                <tr>
                    <td class="form_label" align="right" >
                        	主承销商:
                        	<input class="nui-textbox" name="underwriter.vcMainUnderwriter" id="vcMainUnderwriter" width="40"/>
                    </td>
                    <td class="form_label" align="right" >
                        	主承销商相关联系方式:<input class="nui-textbox" name="underwriter.vcUnderwriterContactInfo" id="vcUnderwriterContactInfo" width="40" /> 
                    </td>
                    <td class="form_label" align="right" >
                        	发行时间:<input class="nui-textbox" name="underwriter.vcApplicationTime" id="vcApplicationTime" width="40" /> 
                    </td>
                    <td class="form_label" align="right" >
                        	簿记时间:<input class="nui-textbox" name="underwriter.vcEntryTime" id="vcEntryTime" width="40" /> 
                    </td>
                    <td class="form_label" align="right" >
                        	发行主体全称:<input class="nui-textbox" name="underwriter.vcIssuerNameFull" id="vcIssuerNameFull" width="40" /> 
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right" >
                        	债券类别:<input class="nui-textbox" name="underwriter.vcStockType" id="vcStockType" width="40" /> 
                    </td>
                    <td class="form_label" align="right" >
                        	发行方式:<input class="nui-textbox" name="underwriter.vcIssueType" id="vcIssueType" width="40" /> 
                    </td>
                    <td class="form_label" align="right" >
                        	债券简称:<input class="nui-textbox" name="underwriter.vcStockName" id="vcStockName" width="40" /> 
                    </td>
                    <td class="form_label" align="right" >
                        	债券全称:<input class="nui-textbox" name="underwriter.vcStockNameFull" id="vcStockNameFull" width="40" /> 
                    </td>
                    <td class="form_label" align="right" >
                        	发行规模(亿):<input class="nui-textbox" name="underwriter.vcIssueBalance" id="vcIssueBalance" width="40" />
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right" >
                        	发行期限(年):<input class="nui-textbox" name="underwriter.vcExistLimite" id="vcExistLimite" width="40" />
                    </td>
                    <td class="form_label" align="right" >
                        	发行期限备注:<input class="nui-textbox" name="underwriter.vcExistLimiteDesc" id="vcExistLimiteDesc" width="40" />
                    </td>
                    <td class="form_label" align="right" >
                        	询价区间:<input class="nui-textbox" name="underwriter.vcInquiryInterval" id="vcInquiryInterval" width="40" />
                    </td>
                    <td class="form_label" align="right" >
                        	主体评级:<input class="nui-textbox" name="underwriter.vcIssueAppraise" id="vcIssueAppraise" width="40" />
                    </td>
                    <td class="form_label" align="right" >
                        	债券评级:<input class="nui-textbox" name="underwriter.vcBondAppraise" id="vcBondAppraise" width="40" />
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right" >
                        	评级机构:<input class="nui-textbox" name="underwriter.vcAppraiseOrgan" id="vcAppraiseOrgan" width="40" />
                    </td>
                    <td class="form_label" align="right" >
                        	登记托管机构:<input class="nui-textbox" name="underwriter.vcPaymentPlace" id="vcPaymentPlace" width="40" />
                    </td>
                    <td class="form_label" align="right" >
                        	预计到期日:<input class="nui-textbox" name="underwriter.vcDueDate" id="vcDueDate" width="40" />
                    </td>
                    <td class="form_label" align="right" >
                        	还本付息方式:<input class="nui-textbox" name="underwriter.vcPayInteval" id="vcPayInteval" width="40" />  
                    </td>
                    <td class="form_label" align="right" >
                        	起息日:<input class="nui-textbox" name="underwriter.vcBegincalDate" id="vcBegincalDate" width="40" />
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right" >
                        	增信情况:<input class="nui-textbox" name="underwriter.vcCreditSituation" id="vcCreditSituation" width="40" />
                    </td>
                    <td class="form_label" align="right" >
                        	企业性质:<input class="nui-textbox" name="underwriter.vcEnterpriseProperty" id="vcEnterpriseProperty" width="40" />
                    </td>
                    <td class="form_label" align="right" >
                        	是否城投:<input class="nui-textbox" name="underwriter.vcIsBid" id="vcIsBid" width="40" />
                    </td>
                    <td class="form_label" align="right" >
                        	标的资产:<input class="nui-textbox" name="underwriter.vcMarkAssets" id="vcMarkAssets" width="40" />
                    </td>
                    <td class="form_label" align="right" >
                        	原始权益人:<input class="nui-textbox" name="underwriter.vcOldHolder" id="vcOldHolder" width="40" /> 
                    </td>
                </tr>
                
                <tr>
                    <td class="form_label" align="right" >
                        	是否可质押:<input class="nui-textbox" name="underwriter.vcIsPledge" id="vcIsPledge" width="40" />
                    </td>
                    <td class="form_label" align="right" >
                        	资质简介:<input class="nui-textbox" name="underwriter.vcPropertyDesc" id="vcPropertyDesc" width="40" />
                    </td>
                    <td class="form_label" align="right" >
                        	历史发债:<input class="nui-textbox" name="underwriter.vcHisIssue" id="vcHisIssue" width="40" />
                    </td>
                    <td class="form_label" align="right" >
                        	路演时间:<input class="nui-textbox" name="underwriter.vcSummaryTime" id="vcSummaryTime" width="40"/>
                    </td>
                    <td class="form_label" align="right" >
                        	是否有过融资历史:<input class="nui-textbox" name="underwriter.vcIsHaveFinancing" id="vcIsHaveFinancing" width="40" /> 
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right" >
                        	材料网络版更新时间:<input class="nui-textbox" name="underwriter.vcInfoNetUrlTime" id="vcInfoNetUrlTime" width="40" />
                    </td>
                    <td class="form_label" align="right" >  
                        	材料网络下载链接:<input class="nui-textbox" name="underwriter.vcInfoNetUrl" id="vcInfoNetUrl" width="40" />
                    </td>
                    <td class="form_label" align="right" colspan="2" >
                        	调研纪要/路演纪要(若有) 下载链接:<input class="nui-textbox" name="underwriter.vcSummaryUrl" id="vcSummaryUrl" width="40" />
                    </td>
                    <td class="form_label" align="right" >  
                        	评级(主体/债项):<input class="nui-textbox" name="underwriter.vcIssueBondAppraise" id="vcIssueBondAppraise" width="40" />
                    </td>
                </tr>
                <tr>
                   <td class="form_label" align="right" >  
                        	评级(债项/主体):<input class="nui-textbox" name="underwriter.vcBondIssueAppraise" id="vcBondIssueAppraise" width="40" />
                    </td>
                </tr>
            </table>
            </form>
        </div>
        <div class="nui-toolbar" style="border:0; top:0px">
		    <table style="width:100%;">
		       <tr>
		           <td style="text-align:center;">
		               	<a class="nui-button"  iconCls="icon-ok" onclick="onOk()">确定</a>
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
		var cStatus="1";
		var lUnderwriterTemp="1";
		function SetDataInit(data){
		   var lOperatorNo=data.lOperatorNo;
		   
    	   var json =nui.encode({userName:lOperatorNo,cStatus:cStatus,lUnderwriterTemp:lUnderwriterTemp});
				nui.ajax({
				    url: "com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryImportOrExportCustomUnderwriter.biz.ext",
				    type: "post",
				    data: json,
				    dataType:"json",
				    success: function (text) {
				        form.setData({underwriter:text.underwriterInport[0]}); //表单数据初始化
				        nui.get("userTemp").setValue(data.lOperatorNo);
		                nui.get("userTemp").setText(data.lOperatorName);
				    }
				});
    	}  
    	var excelData={
			    "A":"0","B":"1","C":"2","D":"3","E":"4","F":"5","G":"6","H":"7","I":"8","J":"9","K":"10","L":"11","M":"12","N":"13",
			    "O":"14","P":"15","Q":"16","R":"17","S":"18","T":"19","U":"20","V":"21","W":"22","X":"23","Y":"24","Z":"25","AA":"26",
			    "AB":"27","AC":"28","AD":"29","AE":"30","AF":"31","AG":"32","AH":"33","AI":"34"
			}
    	function onOk(){
    	   form.validate();
    	   if(form.isValid() == false){
				nui.alert("有数据为空或者格式不对，请确认！");
				return;
			} 
			var userTemp=nui.get("userTemp").getValue();
			var userTempText=nui.get("userTemp").getText();
			if(userTemp=="" || userTemp==null){
			    nui.alert("模板设置用户不能为空，请确认！");
				return;
			}
			var isbool=true;
			var data2 = form.getData(false,true).underwriter;
    	    var data = form.getData(false,true).underwriter;
              for ( var i in data ){
                  for( var j in data ){
                     var reZM=/^[A-Z]+$/;
                     if(data[j]!="" && !reZM.test(data[j])){
                        nui.alert("只能输入英文大写字母，请确认！"+data[j]);
				        return;
                     } 
	                 if(data[i]!="" && data[j]!="" && data[i]==data[j] && i!=j){
	                    nui.alert("Excel序列不能填写重复，请确认！"+data[i]);
				        return;
	                 }
	                 if(i=="vcIssueBondAppraise" && data[i]!=""){
	                    if((j=="vcIssueAppraise" || j=="vcBondAppraise" || j=="vcBondIssueAppraise" ) && data[j]!=""){
	                       nui.alert("主体/债项有值的话，主体评级，债券评级，债项/主体不能同时有值！"+data[i]);
				           return;
	                    }
	                 }
	                  if(i=="vcBondIssueAppraise" && data[i]!=""){
	                    if((j=="vcIssueAppraise" || j=="vcBondAppraise" || j=="vcIssueBondAppraise" ) && data[j]!=""){
	                       nui.alert("债项/主体有值的话，主体评级，债券评级，主体/债项不能同时有值！"+data[i]);
				           return;
	                    }
	                 }
	                 if(data[j]!=""){
	                   isbool=false;
	                 }
                 }
                 if(isbool){
	                    nui.alert("Excel序列不能全部为空，请确认！"+data[i]);
				        return;
	              }
                 if(data[i]!=""){
                    var toNum=data[i];
                    if(excelData[toNum]==undefined){
                        nui.alert("只能输入Excel序列前35列对应的字母，请确认！"+data[i]);
				        return;
                    }else{
                      data2[i]=excelData[toNum];
                    }
                 } 
              }
              var url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.saveUnderwriterImport.biz.ext";
              var data1 = form.getData(false,true);
              data1.underwriter.cStatus=cStatus;
              data1.underwriter.lOperatorNo=userTemp;
              data1.underwriter.lUnderwriterTemp=lUnderwriterTemp;
              data1.underwriter.lOperatorName=userTempText;
              var json =nui.encode(data1);
				nui.ajax({
				    url: url,
				    type: "post",
				    data: json,
				    dataType:"json",
				    success: function (text) {
				       if(text.returnCode=true){
				         nui.alert("保存成功！","",function(action){
                             CloseWindow("saveSuccess");
                            });
				       }else{
				         nui.alert("模板保存失败！");
				       }
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
        //选择抄送人员
		function selectSendUser(e){ 
			var btnEdit = this;
			nui.open({
				url: "<%=request.getContextPath()%>/fm/comm/util/multselet_main.jsp",
				title: "员工列表",
				width: 650,
				height: 480,
				ondestroy: function (action) {
					if (action == "ok") {
						var iframe = this.getIFrameEl();
						var emps = iframe.contentWindow.getData();
						emps = nui.clone(emps); 
						if (emps) {
							btnEdit.setValue(emps.value);
							btnEdit.setText(emps.name);
						}
					}
				}
			});   			
		}
    </script>
</body>
</html>