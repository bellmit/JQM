<%@page import="java.math.BigDecimal"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.eos.foundation.eoscommon.CacheUtil"%>
<%@page import="com.cjhxfund.ats.fm.commonUtil.JDBCUtil"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>

<%--
- Author(s): zhangyao
- Date: 2016-12-14 17:40:16
- Description:
 --%>
 <%
 	long key = JDBCUtil.getNextSequence("SEQSTOCKISSUENO");
 	String processInstID = request.getParameter("processInstID");
	String workItemID = request.getParameter("workItemID");
	String bizId=request.getParameter("bizId");
	Object obj=CacheUtil.getValue("ReloadParamConf1", "ATS_IPO_DISTRIBUTION_RATE");
	DataObject cacheData  = (DataObject)obj;
	String enPredictDistributionRate  = cacheData.getString("paramValue");

  %>
    <head>
        <title>交易员（获取外部信息）</title>
        <link rel="stylesheet" href="css/offeringStyle.css"/>
        <style>
        	.input{
        		width:60px;
        		margin-right:20px;
        		padding:3px;
        		cursor:pointer;
        	}
        	.input:hover{
        		color:#3DA2E1;
        	}
        </style>
    </head>
    <body>
        <div class="main">
            <!--表单-->
            <form id="form1" method="post" >
            	<input name="processInstID" id="processInstID" class="nui-hidden" value="<%=processInstID %>"/>
            	<input name="workItemID" id="workItemID" class="nui-hidden" value="<%=workItemID %>"/>
            	<input id="lInstructNo" name="ipoInstructInfo.lInstructNo" class="nui-hidden" />
            	<input id="vcExchangeNo" name="ipoInstructInfo.vcExchangeNo" class="nui-hidden" />
            	<!--发行人-->
	        	<ul class="form_list_name">
                    <li>
                        <span>发行人 :</span>
       					<input name="ipoInstructInfo.vcIssuerName" class="nui-textbox input_width" readonly="true"/>
                    </li>
                    <li>
                        <span>主承销商<em>*</em> :</span>
                        <input name="ipoInstructInfo.vcLeadUnderwriterName" class="nui-textbox input_width" emptyText="请输入主承销商" required="true"/>
                    </li>
	         	</ul>
	            <!--基本信息-->
            	<fieldset class="fieldset">
            		<legend>&nbsp;&nbsp;基本信息 &nbsp;&nbsp;</legend>
	                <ul class="form_list">
	                    <li>
	                        <span class="info_name">公司名称 :</span>
	       					<input name="ipoInstructInfo.vcCompanyName" class="nui-textbox" readonly="true"/>
	                    </li>
	                    <li>
	                        <span class="info_name">申购代码 :</span>
	                        <input name="ipoInstructInfo.vcIssuerNo" class="nui-textbox" readonly="true"/>
	                    </li>
	                    <li>
	                        <span class="info_name">申购建议价格(元) :</span>
	                        <input name="ipoInstructInfo.enSuggestPrice" class="nui-textbox" readonly="true"/>
	                    </li>
	                    <li>
	                        <span class="info_name">发行数量(万股)<em>*</em> :</span> 
	                        <input id="enIssueNumber" name="ipoInstructInfo.enIssueNumber" class="nui-textbox" vtype="float;min:0;" onvalidation="onIssueUpperNumberValidation" emptyText="请输入发行数量" required="true"/>
	                    </li>
	                    <li>   
	                        <span class="info_name">发行后总股本(万股) :</span>
	                        <input name="ipoInstructInfo.enTotalEquity" class="nui-textbox" readonly="true"/>
	                    </li>
	                    <li>
	                        <span class="info_name">网下申购规模(万元) :</span>
	                        <input name="ipoInstructInfo.enPurchaseScale" class="nui-textbox prohibit_input" readonly="true"/>
	                    </li>
	                    <li>   
	                        <span class="info_name">网下发行上限(万股)<em>*</em> :</span>
	                        <input id="enOfflineIssueUpperNumber" name="ipoInstructInfo.enOfflineIssueUpperNumber" class="nui-textbox" vtype="float;min:0;" onvalidation="onIssueUpperNumberValidation" emptyText="请输入网下发行上限" required="true"/>
	                    </li>
	                    <li>   
	                        <span class="info_name">网下申购上限(万股)<em>*</em> :</span>
	                        <input id="enOfflineUpperNumber" name="ipoInstructInfo.enOfflineUpperNumber" class="nui-textbox" vtype="float;min:0;" onvalidation="onEnOfflineUpperOrEnOfflineUnder" emptyText="请输入网下申购上限" required="true"/>
	                    </li>
	                    <li> 
	                        <span class="info_name">网下申购下限(万股)<em>*</em> :</span>
	                        <input id="enOfflineUnderNumber" name="ipoInstructInfo.enOfflineUnderNumber" class="nui-textbox" vtype="float;min:0;" onvalidation="onEnOfflineUpperOrEnOfflineUnder" emptyText="请输入网下申购上限" required="true"/>
	                    </li>
	                    <li>
	                        <span class="info_name">申购步长(万)<em>*</em> :</span>
	                        <input name="ipoInstructInfo.enPurchaseSize" class="nui-textbox" emptyText="请输入申购步长" vtype="int;min:0;" onvalidation="onNumberValidation" required="true"/>
	                    </li>
	                    <li>
	                        <span class="info_name">询价日 :</span>
	                        <input id="lInquiryStartDate" name="ipoInstructInfo.lInquiryStartDate" class="nui-datepicker" readonly="true"/>
	                    </li>
	                    <li>  
	                        <span class="info_name">网下申购日 :</span>
	                        <input id="lOfflinePurchaseDate" name="ipoInstructInfo.lOfflinePurchaseDate" class="nui-datepicker" readonly="true"/>
	                    </li>
	                    <li>
	                        <span class="info_name">市值门槛 (万元)<em>*</em> :</span>
	                        <input name="ipoInstructInfo.enMarketValueThreshold" class="nui-textbox"  emptyText="请输入市值门槛" vtype="float;min:0;" onvalidation="onenMarketValueThreshold" required="true"/>
	                    </li>
	                </ul>
                </fieldset>
	            <!--定价信息-->
	            <fieldset class="fieldset">
            		<legend>&nbsp;&nbsp;定价信息 &nbsp;&nbsp;</legend>
            		<ul class="form_list">
	                    <li>  
	                        <span class="info_name">预计获配率(%) <em>*</em>:</span>
	       					<input id="enPredictDistributionRate" 
	       					       name="ipoInstructInfo.enPredictDistributionRate" 
	       					       class="nui-textbox" emptyText="请输入预计获配率" 
	       					       vtype="float;range:0,100;" onvalidation="onNumberValidation" required="true">
	                    </li>
	                    
	                    <li>
	                        <span class="info_name_type">行业类别  &nbsp;:&nbsp;</span>
	                        <input name="ipoInstructInfo.vcWindIndustryType" class="nui-textbox input_width" readonly="true"/>
	                    </li>
	                </ul>
            	</fieldset>
		        <div class="nui-toolbar" style="margin-top: 25px;" borderStyle="border:0;">
					<table width="100%">
						<tr>
							<td style="text-align: center;" colspan="4">
								<input id="createProc" class='nui-button' plain='false' iconCls="icon-ok" text="提 交" onclick="createProc()"/>
							</td>
						</tr>
					</table>
				</div> 
	        </form>
		</div>	
	<script type="text/javascript">
		nui.parse();
		var form = new nui.Form("form1");
	    //标准方法接口定义
		function SetData(data) {
			if (data.action == "create") {
	            //跨页面传递的数据对象，克隆后才可以安全使用
				data = nui.clone(data);
				var json = nui.encode({vcIssuerNo:data.vcIssuerNo});
				nui.ajax({
					url: "com.cjhxfund.ats.ipo.busOpr.queryNewStockByWindByCode.biz.ext",
					type: 'POST',
					data: json, 
					contentType: 'text/json',
					success: function (o) {
						form.setData(o);
						var lInquiryStartDate=nui.encode(o.ipoInstructInfo.lInquiryStartDate);
						var lOfflinePurchaseDate=nui.encode(o.ipoInstructInfo.lOfflinePurchaseDate);
						//从数据库读取的是20161212，转成2016-12-12
						nui.get("lInquiryStartDate").setValue(strToDate(lInquiryStartDate));
						nui.get("lOfflinePurchaseDate").setValue(strToDate(lOfflinePurchaseDate));
						nui.get("enPredictDistributionRate").setValue('<%=enPredictDistributionRate %>');
					}
				});
			}
		} 
		 
		//调用创建流程
		function createProc(e){
			nui.get("createProc").disable();
			var form = new nui.Form("#form1");
			form.setChanged(false);
			form.validate();
			if (form.isValid() == false){
				nui.alert("必填项输入不正确,请重新输入","系统提示");
				nui.get("createProc").enable();
				return;
			}
			var data =form.getData();
	    	var json={stock:data.ipoInstructInfo};
		    nui.ajax({
				url: "com.cjhxfund.ats.ipo.busOpr.maualAddInstruct.biz.ext",
				type: "post",
				data: json,
				async: false,
				contentType:'text/json',
				success: function (text) {
				    var returnJson = nui.decode(text);
					if(returnJson.exception == null){
				    	if(returnJson.rtnCode==-1){
				       		nui.alert("提交失败！","系统提示",function(action){
				       			nui.get("createProc").enable();
		               			CloseWindow("close");
		               		});
				        }else{
				        	nui.alert("提交成功！","系统提示",function(action){
		               			CloseWindow("close");
		               		});
				        }
				    }else{
				    	nui.alert("提交失败！","系统提示",function(action){
				    		nui.get("createProc").enable();
		               		CloseWindow("close");
		               	});
				    }
			    },
			    ondestroy:function(action){
        			nui.get("createProc").enable();
        		},
        		error:function(error){
        			nui.get("createProc").enable();
        		}    
		    });
		}
		
		//删除数据库中附件表的的文件
		function deleteFile(ids){
			var json = nui.encode({fileIds: ids});
			$.ajax({
		        url:'com.cjhxfund.ats.fm.baseinfo.attachInfoManager.deleteAttachInfos.biz.ext',
		        type:'POST',
		        data:json,
		        cache:false,
		        contentType:'text/json',
		        success:function(data){
		         	 var returnJson = nui.decode(data);
		             if(returnJson.returnValue == "ok"){
		              	CloseWindow("close");
		             }else{
		               nui.alert("附件删除失败！","系统提示",function(action){
		               
		               });
		             }
		    	 }
		     });
		
		}
	
	   //上载时，将附件表中的id传过来，放到隐藏表单中，直接保存到数据库
	   function initAttachId(attachBusType,serverData){
	       var fileID = serverData.trim();
	   	  if(attachBusType==1){     //lRaiseInstFile
	   	  	nui.get("lRaiseInstFile").setValue(fileID);
	   	  }else if(attachBusType==2){//lRateReportFile
	   	  	nui.get("lRateReportFile").setValue(fileID);
	   	  }else if(attachBusType==3){//lBondIssueFile
	   	  	nui.get("lBondIssueFile").setValue(fileID);
	   	  }
	   	  form.setChanged(true);
	   } 
			   
	   //子页面删除文件之后，也删除父界面上的隐藏表单的值
	   function deleteFileByUpload(attachBusType){
	   	  if(attachBusType==1){     
	   	  	nui.get("lRaiseInstFile").setValue("");
	   	  }else if(attachBusType==2){//lRateReportFile
	   	  	nui.get("lRateReportFile").setValue("");
	   	  }else if(attachBusType==3){//lBondIssueFile
	   	  	nui.get("lBondIssueFile").setValue("");
	   	  }
	   }
		//关闭窗口
		function CloseWindow(action){
		  if(action=="close" && form.isChanged()){
		  	nui.confirm("数据已改变,确认退出?","系统提示",function(a){
		  		if(a=='ok'){
		  			deleteFilePreparation();
		  			CloseWindow("cance");
		  		}
		  	});
		  }else if(window.CloseOwnerWindow) 
		    return window.CloseOwnerWindow(action);
		  else
		    return window.close();
		} 
		//输入数字验证
		function onNumberValidation(e){
			if (e.isValid) {
                if (isNumber(e.value) == false) {
                    e.errorText = "请输入正确的数字";
                    e.isValid = false;
                }
            }
        }
        function isNumber(v){
        	var r = /^(0|[1-9]\d*)(\.\d+)?$/;
            if (r.test(v)) return true;
            return false;
        }
        
        function strToDate(dateStr){
			var year = dateStr.slice(0,4);
			var month = dateStr.slice(4,6);
			var date = dateStr.slice(6,8);
			var finalDate = year + "-" + month + "-" + date;
			return finalDate;
		}
		//验证市值门槛
		function onenMarketValueThreshold(e){
			if (e.isValid) {
                if (numberLength(e.value) == false) {
                    e.errorText = "数值输入过大或格式输入不正确";
                    e.isValid = false;
                }
            }
		}
		function numberLength(v){
        	var r = /^0$|^[1-9]\d{0,11}$|^[1-9]\d{0,11}\.{1}\d{1,4}$|^0\.{1}\d{1,4}$/g;
            if (r.test(v)) return true;
            return false;
        }
		
		//验证网下发行上限(万股)与发行数量
		function onIssueUpperNumberValidation(e){
			var enIssueNumber=nui.get("enIssueNumber").getValue();//发行数量
			enIssueNumber=parseFloat(enIssueNumber);
			var enOfflineIssueUpperNumber=nui.get("enOfflineIssueUpperNumber").getValue();//网下发行上限(万股)
			enOfflineIssueUpperNumber=parseFloat(enOfflineIssueUpperNumber);
			if (e.isValid) {
				if(enOfflineIssueUpperNumber>enIssueNumber){
                    e.errorText = "网下发行上限不能大于发行数量";
                    e.isValid = false;
                }else{
					return;
				}
            }
        }
        //验证网下申购上限与网下申购下限
        function onEnOfflineUpperOrEnOfflineUnder(e){
			var enOfflineUpperNumber=nui.get("enOfflineUpperNumber").getValue();//网下申购上限
			var enOfflineUnderNumber=nui.get("enOfflineUnderNumber").getValue();//网下申购下限
			enOfflineUpperNumber=parseFloat(enOfflineUpperNumber);
			enOfflineUnderNumber=parseFloat(enOfflineUnderNumber);
			if (e.isValid) {
				if(enOfflineUpperNumber<enOfflineUnderNumber){
                    e.errorText = "网下申购下限必须小于网下申购上限";
                    e.isValid = false;
                }else{
					return;
				}
            }
        }
	</script>
</body>
</html>
