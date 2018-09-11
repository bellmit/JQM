 <%@page import="commonj.sdo.DataObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 杨敏
  - Date: 2016-07-19 15:18:15
  - Description:
-->
<head>
<title>有债券申购</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
<%
  String fileName = request.getParameter("fileName");
  String sysid = request.getParameter("sysid");
  String type = request.getParameter("type");
  String vcProductCode = request.getParameter("vcProductCode");
  String bizId = request.getParameter("bizId");
  String vcStockName = request.getParameter("vcStockName");
  String vcStockCode = request.getParameter("vcStockCode");
  String cApplyInstType = request.getParameter("cApplyInstType");

  boolean isPDF = false;
  if(fileName !=null && fileName.trim().length() >0){
      	String fileExt = fileName.substring(fileName.lastIndexOf(".") +1 , fileName.length());
      	 if("pdf".equalsIgnoreCase(fileExt)){
      	   isPDF = true;
      	 }
     }
 %>   
 <style type="text/css">
	.mini-layout-region-body {
	   overflow-x :hidde;
	   overflow-y :yes;
	}
	
	 #footer {z-index:999; position:fixed; bottom:0; left:0;  _position:absolute; height:30px;
		 _top: expression_r(documentElement.scrollTop + documentElement.clientHeight-this.offsetHeight-300); overflow:visible;
		}
	#editForm2 table td{
		width:25%;
		word-wrap:break-word;
		word-break:break-all;
		border:solid #a5acb5;
		border-width:0px 1px 1px 0px;
	}
	#editForm2 table th{
		width:25%;
		word-wrap:break-word;
		word-break:break-all;
		border:solid #a5acb5;
		border-width:0px 1px 1px 0px;
	}
	#editForm2 table{
		table-layout:fixed;
	}
	/*报量信息*/
   #reportType1 table td{
		width:25%;
		word-wrap:break-word;
		word-break:break-all;
		border:solid #a5acb5;
		border-width:0px 1px 1px 0px;
	}
	#reportType1 table th{
		width:25%;
		word-wrap:break-word;
		word-break:break-all;
		border:solid #a5acb5;
		border-width:0px 1px 1px 0px;
	}
	#reportType1 table{
		table-layout:fixed;
	}
	
	
	
	.nui-form-widget-cc, th, .nui-form-widget-cc td{
		padding:0;
	}
</style>	 
</head>
<body>

<div id="layout1" class="mini-layout" style="width:100%;height:100%;"  borderStyle="border:solid 1px #aaa;" >
  <!-- 左边区域 -->
  <div title="基本信息" id="west" showProxyText="true" region="west" width="420"  showSplitIcon="true" expanded="false">
  				<div style="font-size: 12px;"></div>
  				<div id="editForm" >
  				<table border="0" cellpadding="1" cellspacing="1" style="width:395px;table-layout:fixed;font-size: 10px;">
  						<colgroup>
							<col width="60px"></col>
							<col width="120px"></col>
							<col width="60px"></col>
							<col width="155px"></col>
						</colgroup>
		                <!-- 产品信息 -->
		                <tr>
		                    <td class="form_label" align="right"  style="width: 60px;">产品代码:</td>
		                    <td colspan="1">
		                    	<input  class="nui-textbox" id="vcProductCode"  name="vcProductCode" readonly="readonly"/>
		                    </td>
		                    
		                    <td class="form_label" align="right"  >债券代码:</td>
		                    <td colspan="1"  style="width:150px;">
		                    	<input  style="width:150px;" class="nui-textbox" id="vcStockCode"  name="vcStockCode" readonly="readonly"/>
		                    </td>
		                  </tr>
		                  <tr>
		                    <td class="form_label" align="right"  >产品全称:</td>
		                    <td colspan="3">
		                    	<input style="width: 332px;" class="mini-combobox"  textField="text" valueField="id"  id="vcProductName1"  name="vcProductName1" />
		                    </td>
		                </tr>
		                <!-- 债券信息 -->
		                <tr>
		                    <td class="form_label" align="right"  style="width: 60px;">债券名称:</td>
		                    <td colspan="3">
		                    	<input style="width: 332px;" class="nui-textbox" id="vcStockName"  name="vcStockName" readonly="readonly"/>
		                    </td>
		                </tr>
		                
		         </table>
		         </div>
        		<!-- 公司信息 -->
           		<div style="font-size: 12px;"></div>
           		<div id="editForm1" >
	             	<table border="0" cellpadding="1" cellspacing="1" style="width:395px;table-layout:fixed;font-size: 10px;">
	             		<colgroup>
							<col width="60px"></col>
							<col width="120px"></col>
							<col width="60px"></col>
							<col width="155px"></col>
						</colgroup>
		                <tr>
		                    <td class="form_label" align="right"  >公司名称:</td>
		                    <td colspan="3">
		                    	<input style="width: 332px;" class="nui-textbox" id="vcCompanyName"  name="vcCompanyName" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="form_label" align="right" >法定代表人:</td>
		                    <td colspan="3">
		                    	<input style="width: 332px;" class="nui-textbox" id="vcCompanyLegalizer"  name="vcCompanyLegalizer" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                	<td class="form_label" align="right"  >营业执照:</td>
		                    <td colspan="3">
		                    	<input style="width: 332px;" class="nui-textbox" id="vcBusinessLicence"  name="vcBusinessLicence" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="form_label" align="right"  >通讯地址:</td>
		                    <td colspan="3">
		                    	<input style="width: 332px;" class="nui-textbox" id="vcPostalAddress"  name="vcPostalAddress" readonly="readonly"/>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="form_label" align="right"  >注册地址:</td>
		                    <td colspan="3">
		                    	<input style="width: 332px;" class="nui-textbox" id="vcRegisteredAddress"  name="vcRegisteredAddress" readonly="readonly"/>
		                    </td>
		                </tr>
		                
		                <tr>
		                	
		                    <td class="form_label" align="right"  >经办人姓名:</td>
		                    <td colspan="1" >
		                    	<input  class="nui-textbox" id="vcOperatorName"  name="vcOperatorName" readonly="readonly"/>
		                    </td>
		                    <td class="form_label" align="right" >邮编:</td>
		                    <td colspan="1" style="width:150px;">
		                    	<input  style="width:150px;" class="nui-textbox" id="vcPostCode"  name="vcPostCode" readonly="readonly"/>
		                    </td>
		                </tr>
		                
		                <tr>
		                	<td class="form_label"  align="right">身份证号:</td>
		                    <td colspan="1" >
		                    	<input class="nui-textbox" id="vcOperatorIdcard"  name="vcOperatorIdcard" readonly="readonly"/>
		                    </td>
		                	<td class="form_label" align="right"  >联系电话:</td>
		                    <td colspan="1" style="width:150px;">
		                       <input style="width:150px;" class="nui-textbox" id="vcTelephone"  name="vcTelephone" readonly="readonly"/> 
		                    </td>
		                </tr>
		               
		                <tr>
		                	<td class="form_label" align="right"> 联系手机:</td>
		                    <td colspan="1">
		                       <input  class="nui-textbox" id="vcPhone"  name="vcPhone" readonly="readonly"/> 
		                    </td>
		                	<td class="form_label" align="right">电子邮箱:</td>
		                    <td colspan="1" style="width:150px;">
		                        <input style="width:150px;" class="nui-textbox" id="vcEmail"  name="vcEmail" readonly="readonly"/> 
		                    </td>
		                </tr>
		            </table>
	        	</div>
	        	
           		<!-- 指令/建议报量信息 -->
           		<div style="margin: 5px 0px;font-size: 12px;" id="reportType"></div>
				<div id="reportType1">
					<table id="applyInfoReportsTable" style="font-size: 12px;width: 395px;border:solid #a5acb5; border-width:1px 0px 0px 1px;" cellpadding="0" cellspacing="0" >
						
					</table>
				</div>
				<!-- 产品账户信息 -->
           		<div id="editForm2" >
           			<!-- 账户类型 -->
           			<div style="margin: 2px 0px;font-size: 12px;" id="companyInfoTableName"></div>
	             	<table id="companyInfoTableTop1" style="font-size: 12px;width: 395px;border:solid #a5acb5; border-width:1px 0px 0px 1px;" cellpadding="0" cellspacing="0" >
		               
		            </table>
		        </div>
		        <!-- 产品授权信息 -->
           		<div id="editForm3" >           			
           			<div style="margin: 2px 0px;font-size: 12px;" id="productAutoInfo"></div>
	             	<table id="productAutoInfo1" style="font-size: 12px;width: 398px;" cellpadding="0" cellspacing="0">
		                    
		            </table>
		        </div>
		         <div style="height: 10px"> </div>
    </div>
    <!-- 右边 区域 -->
    <div title="center" region="center" >
    	 <input type="button"  value="复制附件名"  onclick="copyFileName()" style="margin-left: 90px;width: 80px;height: 30px;position: absolute;" />  
         <% if(isPDF == true){ %>
            <iframe id="prodIfm1" width="100%" height="99%"  frameborder="no" border="0" marginwidth="0" marginheight="0"  src="<%=request.getContextPath() %>/commonUtil/iWebOffice/DocumentEdit.jsp?sysid=<%=sysid %>&type=<%=type %>&vcProductCode=<%=vcProductCode %>&bizId=<%=bizId %>>" ></iframe>  
         <%}else{ if(!"3".equals(type)){%>
             <iframe id="prodIfm1" width="100%" height="99%"  frameborder="no" border="0" marginwidth="0" marginheight="0"  src="<%=request.getContextPath() %>/commonUtil/iWebOffice/OfficeEdit.jsp?sysid=<%=sysid %>&type=<%=type %>&vcProductCode=<%=vcProductCode %>&bizId=<%=bizId %>" ></iframe>  
         <%}else{%>
            <iframe id="prodIfm1" width="100%" height="99%"  frameborder="no" border="0" marginwidth="0" marginheight="0"  src="<%=request.getContextPath() %>/commonUtil/iWebOffice/OfficeEditTemp.jsp?sysid=<%=sysid %>&type=<%=type %>&vcProductCode=<%=vcProductCode %>&bizId=<%=bizId %>" ></iframe>  
         <%}} %>
    </div>
</div>
    <script type="text/javascript">
    
   nui.parse();
   
   loadHtml();
   function loadHtml(){
	   var lProductId = "";
	   var vcProductCode = '<%=vcProductCode %>';//CJ0097
	   var bizId = '<%=bizId %>';//2911
	   var vcStockName = '<%=vcStockName %>';
	   var vcStockCode = '<%=vcStockCode %>';

	   var json = nui.encode({lProductId: lProductId,vcProductCode:vcProductCode,bizId:bizId});
	   $.ajax({
            url:'com.cjhxfund.ats.fm.baseinfo.ApplyTemplet.queryTempletProductInfo.biz.ext',
            type:'POST',
            data:json,
            cache:false,
            contentType:'text/json',
            success:function(data){
             	 var returnJson = nui.decode(data);
             	 //填充公司信息
             	 var form = new nui.Form("#editForm");
             	 var form1 = new nui.Form("#editForm1");
             	 form.setData(returnJson.applyInst);
             	 form1.setData(returnJson.companyInfo);
             	 var retProductInfo = returnJson.retProductInfo;
             	 if(vcProductCode!="" && vcProductCode!="null"){
             	     nui.get("vcProductCode").setValue(vcProductCode);
             	 }
             	 
             	 if(vcStockName!="" && vcStockName!="null"){
             	 	nui.get("vcStockName").setValue(vcStockName);
             	 }
             	 if(vcStockCode!="" && vcStockCode!="null"){
             	 	nui.get("vcStockCode").setValue(vcStockCode);
             	 }
             	 //组装填充指令/建议报量信息
             	 // 报量方式
             	 var cReportType=returnJson.applyInst.cReportType==1?"累计式":"非累计式";							             	 
             	 var applyInfoReportsTable= '<tr><th colspan="3" align="left">&nbsp;报量方式：'+isnulltext(cReportType)+'</th></tr>'+
             	         '<tr>'+
							'<th>报量</th>'+
							'<th>报价</th>'+
							'<th>报量说明</th>'+
						'</tr>';			
             	 for(var i=0;i<returnJson.applyInfoReports.length;i++){
             	 	applyInfoReportsTable+='<tr align="center">'+
							'<td>'+isnulltext(returnJson.applyInfoReports[i].enReport)+'</td>'+
							'<td>'+isnulltext(returnJson.applyInfoReports[i].enOffer)+'</td>'+
							'<td>'+isnulltext(returnJson.applyInfoReports[i].vcReportRemark)+'</td>'+
						'</tr>';
             	 }

             	 //报量
             	 $("#applyInfoReportsTable").html(applyInfoReportsTable);
             	 //组装填充账户信息
             	 var accountInfos=returnJson.accountInfos;
             	 //组装填充账户信息
             	 if(accountInfos!=null && accountInfos.length>0){
	             	var accountInfos=returnJson.accountInfos;
	             	var type=0;
	             	var curType=-1;
	             	
	             	var companyInfoTableTop1="";//表头            
	             	var companyInfoTableTop2="";//表头            
	             	var companyInfoTableTop3="";//表头            
	             	var companyInfoTableTop4="";//表头            
                    var companyInfoTableText1=""; //表内容
                    var companyInfoTableText2=""; //表内容
                    var companyInfoTableText3=""; //表内容
                    var companyInfoTableText4="";  //表内容
             	 	for(var i=0;i<accountInfos.length;i++){             	 	
					   if(accountInfos[i].vcAccountType!=null && accountInfos[i].vcAccountType!="" && accountInfos[i].vcAccountType!="undefined" ){
             	          type=accountInfos[i].vcAccountType;//获取类型
             	       }
					   else { continue;}
					
             	 	   if(accountInfos[i].vcAccountName==null || accountInfos[i].vcAccountName=="" || accountInfos[i].vcAccountName=="undefined"){
             	 	       continue;
             	 	   }
             	 	   
             	 	   if (curType != type)  
					   {   
				            curType = type;
				            
							//账户类型:1证券账户,2银行间,3托管账户
							if(type==1){      
								companyInfoTableTop1='<tr>'+
									'<th colspan="4" align="left">&nbsp;证券账户</th></tr><tr>'+
									'<th colspan="2">账户名称</th>'+
									'<th >账户号码</th>'+
									'<th >席位号</th>'+
								'</tr>';
							}else if(type==2){
								companyInfoTableTop2='<tr>'+
								    '<th colspan="4" align="left">&nbsp;银行间账户</th></tr><tr>'+
									'<th colspan="2">账户名称</th>'+
									'<th >账户号码</th>'+
									'<th >交易单元</th>'+
								'</tr>';
							}else if(type==3){
								companyInfoTableTop3='<tr>'+
									'<th colspan="4" align="left">&nbsp;托管账户</th> </tr><tr>'+
									'<th >账户名称</th>'+
									'<th >账户号码</th>'+
									'<th >托管行</th>'+
									'<th >大额支付号</th>'+
								'</tr>';
							}else if(type==4){
								companyInfoTableTop4='<tr>'+
								    '<th colspan="4" align="left">&nbsp;机构间账户</th></tr><tr>'+
									'<th colspan="2">账户名称</th>'+
									'<th >产品账户</th>'+
									'<th >资金账户</th>'+
								'</tr>';
							}
							    
						   
					   }

             	 		if(type==1){
             	 			companyInfoTableText1+='<tr align="center">'+
							'<td colspan="2">'+isnulltext(accountInfos[i].vcAccountName)+'</td>'+
							'<td >'+isnulltext(accountInfos[i].vcAccountNo)+'</td>'+
							'<td >'+isSeatNull(isnulltext(accountInfos[i].vcTrusteeSeatNoSh),isnulltext(accountInfos[i].vcTrusteeSeatNoSz))+'</td>'+
						'</tr>';
             	 		}else if(type==2){
             	 			companyInfoTableText2+=' <tr align="center">'+
             	 			'<td  colspan="2" >'+isnulltext(accountInfos[i].vcAccountName)+'</td>'+
             	 			'<td >'+isnulltext(accountInfos[i].vcAccountNo)+'</td>'+
		                	'<td >'+isnulltext(accountInfos[i].vcPaymentPlace)+'</td>'+
						'</tr>';
             	 		}else if(type==3){
             	 			companyInfoTableText3+='<tr align="center">'+
							'<td >'+isnulltext(accountInfos[i].vcAccountName)+'</td>'+
							'<td >'+isnulltext(accountInfos[i].vcAccountNo)+'</td>'+
							'<td >'+isnulltext(accountInfos[i].vcTrusteePlace)+'</td>'+
							'<td >'+isnulltext(accountInfos[i].vcLargePaymentNo)+'</td>'+
						'</tr>';
             	 		}else if(type==4){
             	 			companyInfoTableText4+='<tr align="center">'+
             	 			'<td colspan="2" >'+isnulltext(accountInfos[i].vcAccountName)+'</td>'+
							'<td >'+isnulltext(accountInfos[i].vcAccountNo)+'</td>'+
							'<td >'+isnulltext(accountInfos[i].vcBankAccount)+'</td>'+
						    '</tr>';
             	 		}
             	 		
             	 	}
             	 	var companyInfoTableTop5=companyInfoTableTop1+companyInfoTableText1+
             	 	                         companyInfoTableTop3+companyInfoTableText3+
             	 	                         companyInfoTableTop2+companyInfoTableText2+
             	 	                         companyInfoTableTop4+companyInfoTableText4;
             	 	$("#companyInfoTableTop1").html(companyInfoTableTop5);
             	 
             	 }else{
             	 	$("#companyInfoTableName").html("没有查找到相关账户信息~");
             	 }
             	 //纸质指令加载签名和印签
             	 var cApplyInstType = '<%=cApplyInstType %>';
             	 var cApplyInstTypeTmp = returnJson.applyInst.cApplyInstType;
             	 if(cApplyInstTypeTmp != "" && cApplyInstTypeTmp != null && cApplyInstTypeTmp != "undefined"){
             	 	cApplyInstType = cApplyInstTypeTmp;
             	 }
             	 if(cApplyInstType != null && cApplyInstType != ""){
             	 	if(cApplyInstType == "1" || cApplyInstType == "3"){
             	 		var C_INSTRUCTION_TRANSFER_MODUS = retProductInfo.C_INSTRUCTION_TRANSFER_MODUS;
             	 		var VC_AUTHORIZED_SIGNATURE= retProductInfo.VC_AUTHORIZED_SIGNATURE;
             	 		if(C_INSTRUCTION_TRANSFER_MODUS == null || C_INSTRUCTION_TRANSFER_MODUS == ""){
             	 			C_INSTRUCTION_TRANSFER_MODUS = " ";
             	 		}
             	 		if(VC_AUTHORIZED_SIGNATURE == null || VC_AUTHORIZED_SIGNATURE == ""){
             	 			VC_AUTHORIZED_SIGNATURE = " ";
             	 		}
						var productAuthInfo ='<tr><colgroup><col width="82px"></col><col width="315px"></colgroup>'+
		                    '<td  align="right">指令传递形式:</td>'+
		                    '<td >'+
		                    '<input class="nui-textbox" style="width:315px;" readonly="readonly" value="'+C_INSTRUCTION_TRANSFER_MODUS+'"/>'+
		                    '</td>'+
		               '</tr>'+
		               '<tr>'+
		                    '<td  align="right">授权人签字:</td>'+
		                    '<td >'+
		                    	'<input class="nui-textarea" style="width:315px;" readonly="readonly" value="'+VC_AUTHORIZED_SIGNATURE+'"/>'+
		                    '</td>'+
		               '</tr>'+
		               '<tr>'+
		                    '<td  align="right">预留印鉴:</td>'+
		                    '<td >'+
		                    	'<img id="imgpath" style="width:317px;height:290px;"/> '+
		                    '</td>'+
		               '</tr>';
		               $("#productAutoInfo1").html(productAuthInfo);
		               var imgPath = "";
		               if(retProductInfo.VC_PRINT_ATTACH_ID != null && retProductInfo.VC_PRINT_ATTACH_ID != ""){
							if(retProductInfo.VC_PRINT_ATTACH_ID.indexOf("ats.war") > 0){
								imgPath = "<%= request.getContextPath() %>"+retProductInfo.VC_PRINT_ATTACH_ID.match(/ats.war(\S*)/)[1];
							}
		               }
		               document.getElementById("imgpath").src = imgPath;
             	 	}
             	 }
             	 //加载下拉列表框数据
	             var vcProdut = nui.get("vcProductName1");
	             var suzhu="[{ id: 1, text: '"+isnulltext(returnJson.productCaption)+"'}, { id: 2, text: '"+isnulltext(returnJson.companyInfo.vcCompanyName)+"（代表"+isnulltext(returnJson.productCaption)+"）'}]";
	             if(isnulltext(vcProdut)!="空"){
                 	vcProdut.setData(suzhu);
                 	vcProdut.select(0);
	             }else{
	             	//暂停3秒后在显示
	             	setTimeout(function(){
	             		var vcProdut = nui.get("vcProductName1");
	             		if(isnulltext(vcProdut)!="空"){
	             			vcProdut.setData(suzhu);
                 			vcProdut.select(0);
	             		}
	             		
	             	},3000);
	             }
	             //显示数据
	             //nui.get("layout1").expandRegion("west");
                 
        	 }
         });
   }
   function isnulltext(text){
   		
   		if(text=="" || text==null || text=="null" || text=="undefined"){
   			return "空";
   		}else{
   			return text;
   		}
   }
   function isSeatNull(num,num1){
   		if(num=="空" && num1=="空"){
   		   return "空";
   		}
   		if(num!="空" && num1!="空"){
   		   return num1+"(深圳)/"+num+"(上海)";
   		}
   		if(num=="空"){
   			return num1+"(深圳)";
   		}else{
   			return num+"(上海)";
   		}
   }
   
   function save(){
	 document.getElementById("webform").submit();
   }
   //复制文件名到粘贴版，金格目前只支持IE，那么复制功能目前也仅考虑IE。
	function copyFileName(){
		var name="<%=fileName%>";
		window.clipboardData.setData("Text",name);
		nui.alert("复制成功!");
	}
</script>
</body>
</html>