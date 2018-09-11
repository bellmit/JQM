<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%
	String preDate = DateUtil.getCalculateTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null, -1);
%>
<%--
- Author(s): huangmizhi
- Date: 2016-06-03 15:12:12
- Description: 恒生估值系统估值表
--%>
<head>
<title>恒生估值系统估值表</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
			<%-- 证券投资基金估值表查询条件开始... --%>
			<div class="search-condition">
				<div class="list">
					<form id="form_HSFAGZB" method="post">
						<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
						<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
						<%-- 查询类型 --%>
						<input class="nui-hidden" name="paramObject/queryType" value="HSFAGZB">
						<table id="table1" class="table" style="height:100%;table-layout:fixed;">
							<tr>
								<td style="width:60px" align="right">
								日期:
		                        </td>
		                        <td style="width:25%" align="left" colspan="1">
		                        	<input id="busiDateBegin_HSFAGZB" class="nui-datepicker" name="paramObject/busiDateBegin" width="100%" required="true"/>
		                        </td>
		                        <td style="width:30px" align="center">至</td>
		                        <td style="width:25%" align="left">
									<input id="busiDateEnd_HSFAGZB" class="nui-datepicker" name="paramObject/busiDateEnd" width="100%" required="true"/>
		                        </td>
								<td style="width:60px" align="right">
									产品名称:
								</td>
								<td style="width:30%" align="left">
									<input id="vCFundCode_HSFAGZB" class="nui-buttonedit" width="100%" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_HSFAGZB"/>
								</td>
								<td colspan="1" width="65px" align="left">
									<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_HSFAGZB(0)"/>
								</td>
								<td colspan="1" width="150xp" align="left">
									<input class='nui-button' plain='false' text="所选产品最新估值表" iconCls="icon-search" onclick="search_HSFAGZB(1)"/>
								</td>
								<td colspan="1" width="90px" align="left">
									<input class='nui-button' plain='false' id="export_AHSFAGZB" text="批量导出" iconCls="icon-download" onclick="export_AHSFAGZB()"/>
								</td>
									
							</tr>
						</table>
					</form>
				</div>
			</div>
			<%-- 证券投资基金估值表查询条件结束!!! --%>
		
			<%-- 证券投资基金估值表列表开始... --%>
			<div class="nui-fit">
				<div class="nui-tabs" width="100%" id="tabs" style="height:100%;table-layout:fixed;"></div>
			</div>
			<%-- 证券投资基金估值表列表结束!!! --%>
		</div>

<script type="text/javascript">
	nui.parse();
	
	<%-- 恒生估值系统估值表开始... --%>
	//设置默认时间
	var preDate = "<%=preDate%>";
	nui.get("busiDateEnd_HSFAGZB").setValue(preDate);
	nui.get("busiDateBegin_HSFAGZB").setValue(preDate);
	//查询
	var busDateArr = new Array();
	var sheet;
	function search_HSFAGZB(type){
		busDateArr = [];
		var fundCodes = nui.get("vCFundCode_HSFAGZB").getValue();
		var fundNames = changeNull(nui.get("vCFundCode_HSFAGZB").getText());
		if(fundNames==""){
			nui.alert("请先选择产品名称！");
			return;
		}
		var busiDateEnd = nui.get("busiDateEnd_HSFAGZB").getValue();
		var busiDateBegin = nui.get("busiDateBegin_HSFAGZB").getValue();
		if(busiDateEnd =="" || busiDateBegin =="" ){
			nui.alert("请先选择日期！");
			return;
		}
		busiDateEnd = busiDateEnd.substr(0,10);
		busiDateBegin = busiDateBegin.substr(0,10);
		var checkDate = diffDate(busiDateBegin,busiDateEnd);
		if(checkDate == false){
			return;
		}
		var fundCodeArr = fundCodes.split(",");
		var fundNameArr = fundNames.split(",");
		
		var queryUserType = "<%=request.getParameter("queryUserType")%>";
		var tabs = nui.get("tabs");
		//在加载tab时首先清除掉之前的tab页面
		tabs.removeAll();
		//获取日期区间的业务日期和产品
		var prodcodes = "'"+fundCodes.replace(/,/g,"','")+"'";
		 json = nui.encode({busiDateBegin:busiDateBegin,busiDateEnd:busiDateEnd,prodcodes:prodcodes,type:type});
          nui.ajax({
            url: "com.cjhxfund.jy.ProductProcess.FileUploadUtil.queryGZBBusDate.biz.ext",
            type: "post",
            contentType:'text/json',
            data: json ,
            success: function (text) {
              if (text.busDates.length>0) {
					//循环加载tab页
              	 for(var j=0; j<text.busDates.length; j++){
					var busDate = text.busDates[j].D_YWRQ;
					var vc_cpdm = text.busDates[j].VC_CPDM;
					busDateArr.add(busDate+"_"+vc_cpdm);
						var productCode = text.busDates[j].VC_CPDM;
						var productName = retProdName(productCode,fundCodeArr,fundNameArr);
						//将中文转换成Unicode格式
						var fbusDate = busDate.substr(0,4)+'年'+busDate.substr(5,2)+'月'+busDate.substr(8,2)+'日';
						var vCFundName =  GB2312UnicodeConverter.ToUnicode(productName+fbusDate)+productCode+GB2312UnicodeConverter.ToUnicode("估值表");
						sheet = productName+fbusDate+productCode+'估值表';
						//设置tab属性
						var tab = {title:productCode+productName+busDate, url:"<%=request.getContextPath() %>/ProductProcess/zhxxcx/CFJY_zhxxcx_hsfagzb_detail.jsp?vCFundCode="+productCode+"&busiDateBegin="+busiDateBegin+"&busiDateEnd="+busDate+"&queryUserType="+queryUserType+"&vCFundName="+vCFundName, showCloseButton: true };
						//设置tab
						tabs.addTab(tab);
						//当i=0时模拟点击事件
			 			if(j == 0){
			          		tabs.activeTab(tab);
				        }
					//}
				}
              }
              else {
              	 nui.alert("未查询到估值数据，请重新选择日期或产品！", "", function(){});
              }
            }
          });
	}
	
	//根据产品代码返回选择的产品名称
	function retProdName(Prodcode,fundCodeArr,fundNameArr){
		for(var i=0; i<fundCodeArr.length; i++){
			if(fundCodeArr[i] == Prodcode){
				return fundNameArr[i];
			}
		}
	}
	
	//日期天数差 
    function diffDate(begindate,enddate){
    	var bdate = new Date(begindate.replace(/-/g,"/"));
    	var edate = new Date(enddate.replace(/-/g,"/"));
    	var iDay = parseInt(Math.abs(edate - bdate) / 1000 / 60 / 60 /24)//把相差的毫秒数转换为天数 
    	if(begindate>enddate){
    		nui.alert("开始时间大于截止时间，请重新调整日期！");
    		return false;
    	}
    	if(iDay>4){
    		nui.alert("查询日期区间最多为五天，请重新调整日期区间！");
    		return false;
    	}
    }

	//获取查询条件的基金名称
	function ButtonClickGetFundName_HSFAGZB(e){
        ButtonClickGetFundName(this, null);
	}
	<%-- 恒生估值系统估值表结束!!! --%>
	//批量导出 查询的产品估计表 
	function export_AHSFAGZB(){
		var tabs = nui.get("tabs");
		var fundCodes = nui.get("vCFundCode_HSFAGZB").getValue();
		var fundNames = changeNull(nui.get("vCFundCode_HSFAGZB").getText());
		if(tabs.getTabs().length == 0){
			nui.alert("请先查询估值表！");
		}else if(tabs.getTabs().length == 1){
			exportSubmit("export_AHSFAGZB", "form_HSFAGZB", sheet);
		}else{
			var form = new nui.Form("#form_HSFAGZB");
		    form.validate();
			if(form.isValid()==false) return;			
			//在form表单中新增元素
			var msg = "确定要导出吗？";
			nui.confirm(msg,"系统提示",function(action){
				exportSubmit_pl("export_AHSFAGZB", "form_HSFAGZB",fundCodes,fundNames,busDateArr);
			});
		}
	}
	
	
</script>
</body>
</html>