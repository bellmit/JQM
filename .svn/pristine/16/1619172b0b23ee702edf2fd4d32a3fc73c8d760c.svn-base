<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2017-12-06 14:36:49
  - Description:
-->
<head>
<title>投资计划安排</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    
</head>
<body>
	<div class="nui-toolbar" style="border-bottom:0;padding:0px;height:8.6%;">
		<table style="width:100%;table-layout:fixed;">
			<tr>
				<td style="width:75%;">
					<a id="addPlan" enabled="false" class="nui-button" plain="true" iconCls="icon-add" onclick="addInvestPlan()">新增</a>
		        	<a id="deletePlan" enabled="false" class="nui-button" plain="true" iconCls="icon-remove" onclick="deleteInvestPlan()">删除</a>
		        	<a id="modifyPlan" enabled="false" class="nui-button" plain="true" iconCls="icon-edit" onclick="modifyInvestPlan()">修改</a>
				</td>
			</tr>
		</table>
	</div>
	<div id="datagrid_invest_plan" class="nui-datagrid" style="border-bottom:0;padding:0px;width:100%;height:91%;"
		 url="com.cjhxfund.ats.sm.inquiry.financeGapManage.queryInvestPlan.biz.ext" idField="lPlanId" dataField="investPlans"
		 showPager="true" pageSize="20" sizeList="[20,50,100,200,500,1000]"
		 multiSelect="true" showReloadButton="true"
		 onbeforeload="onBeforeLoad" onselectionchanged="selectionchanged"
	 	 virtualScroll="true" enableHotTrack="false">
         <div property="columns">
         	<div type="checkcolumn">选择</div>
         	<div field="vcProductName" headerAlign="center" align="center" width="80px">
	产品名称
            </div>
            <div field="vcAssetName" headerAlign="center" align="center" width="80px">
	单元名称
            </div>
            <div field="vcBizType" headerAlign="center" align="center" width="100px" renderer="renderBizType">
	业务类别
            </div>
            <div field="vcMarketNo" headerAlign="center" align="center" width="80px" renderer="renderMarket">
	市场
            </div>
            <div field="vcEntrustDirection" headerAlign="center" align="center" width="80px" renderer="renderEntrustDirection">
	委托方向
            </div>
            <div field="enInvestAmount" headerAlign="center" numberFormat="n2"  align="right" width="80px">
	金额(万元)
            </div>
            <div field="vcFundDirection" headerAlign="center" align="center" width="80px" renderer="renderFundDirection">
	资金方向
            </div>
            <div name="action" align="center" headerAlign="center" headerallowSort="true" width="70px">
            操作
            </div> 
         </div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var investPlan = nui.get("datagrid_invest_plan");
		var rowDetail = null;
    	function detail(row){
    		nui.get("addPlan").disable();
    		nui.get("deletePlan").disable();
    		nui.get("modifyPlan").disable();
    		if(row){
    			rowDetail = nui.clone(row);
    			if(rowDetail.lDate==DateUtil.toNumStr(new Date())){
    				nui.get("addPlan").enable();
    			}
    			investPlan.load();
    		}else{
    			rowDetail = null;
    			investPlan.clearRows();
    		}
    	}
    	
    	//投资计划加载前参数设置
    	function onBeforeLoad(e){
    		var params = e.params;  //参数对象
    		params.conditionParam = {lDate:rowDetail.lDate, lAssetId:rowDetail.lAssetId};
    	}
    	
    	investPlan.on("drawcell", function (e) {
    		var record = e.record,
	        	column = e.column;
        	if(column.name == "action"){
        		if(record.vcBizType=="1" || record.vcBizType=="5"|| record.vcBizType=="6"|| record.vcBizType=="3"){//目前只支持银行间买卖与银行间质押式回购录入询价结果
        			if(record.lInvestNo){
        				e.cellHtml="已下单  "+'<a class="nui-button" style="color:#6959CD; cursor:pointer;text-decoration:underline;" onclick="inqueryDetail('+record.lResultId+','+record.vcBizType+')">询价详情</a>';
	        		}else if(record.cInquiryOperate == "1"){
	        			e.cellHtml = '<a class="nui-button" style="color:#6959CD; cursor:pointer;text-decoration:underline;" onclick="inqueryInstruction('+e.rowIndex+')">去下单</a>';
	        		}else{
	        			e.cellHtml="--";
	        		}
        		}else{
        			e.cellHtml="--";
        		}
        	}
    	});
    	
    	function selectionchanged(){
    		var rows = investPlan.getSelecteds();
    		nui.get("deletePlan").disable();
    		nui.get("modifyPlan").disable();
    		if(rows.length==1){
    			var row = investPlan.getSelected();
    			if(!row.lInvestNo){
    				nui.get("deletePlan").enable();
    				nui.get("modifyPlan").enable();
    			}
    		}else if(rows.length>1){
    			nui.get("deletePlan").enable();
    			for(var i = 0; i<rows.length; i++){
    				var row = rows[i];
    				if(row.lInvestNo){
    					nui.get("deletePlan").disable();
    					break;
    				}
    			}
    		}
    	}
    	
    	function addInvestPlan(){
    		nui.open({
    			url:nui.context+"/inquiry/financeGap/investPlanInput.jsp",
    			title:"新增投资计划",
    			width:300,
    			height:220,
    			allowResize:false,
    			onload:function(){
    				var iframe = this.getIFrameEl();
    				iframe.contentWindow.setFormData(rowDetail,"input");
    			},
    			ondestroy:function(action){
    				if(action=="ok"){
    					window.parent.reloadPositionGrid();
    				}
    			}
    		});	
    	}
    	
    	function deleteInvestPlan(){
    		var rows = investPlan.getSelecteds();
    		var a = nui.loading("正在处理中,请稍等...","提示");
    		nui.ajax({
    			url:"com.cjhxfund.ats.sm.inquiry.financeGapManage.removeInvestPlan.biz.ext",
    			type: 'POST',
		      	data: {investPlans:rows},			
		      	contentType: 'text/json',
		      	success: function(text){
		      		nui.hideMessageBox(a);
		      		var returnJson = nui.decode(text);
		      		if(returnJson.exception == null){
		      			nui.alert("删除成功","提示", function(){
		      				window.parent.reloadPositionGrid();
		      			});
					}else{
						nui.alert("删除失败，系统异常","系统提示");
					}
		      	}
    		});
    	}
    	
    	function modifyInvestPlan(){
    		var row = investPlan.getSelected();
    		nui.open({
    			url:nui.context+"/inquiry/financeGap/investPlanInput.jsp",
    			title:"修改投资计划",
    			width:300,
    			height:220,
    			allowResize:false,
    			onload:function(){
    				var iframe = this.getIFrameEl();
    				iframe.contentWindow.setFormData(row,"modify");
    			},
    			ondestroy:function(action){
    				if(action=="ok"){
    					window.parent.reloadPositionGrid();
    				}
    			}
    		});	
    	}
    	
    	//根据投资计划交易员去下询价结果
    	function inqueryInstruction(rowid){
    		var row = investPlan.getRow(rowid);
    		var data = {nodeId:"1845", vcBizType:row.vcBizType, lPlanId:row.lPlanId, lProductId:row.lProductId, vcProductCode:row.vcProductCode, vcProductName:row.vcProductName, lAssetId:row.lAssetId, vcEntrustDirection: row.vcEntrustDirection, enFaceAmount: row.enInvestAmount};
    		var url = nui.context+"/inquiry/inquiryResultManage/inquiryResultEntering/repurchase/collateraliseRepo.jsp";
    		var widthValue = 913;
    		var heightValue = 570;
    		if(row.vcBizType=="1"||row.vcBizType=="3"){
    			url = nui.context+"/inquiry/inquiryResultManage/inquiryResultEntering/transaction/inquiryInput_zqmm/inquiryIssucdFrame_zqmm.jsp";
    			widthValue = 1070;
    			heightValue = 507;
    		}
    		if(row.vcBizType=="6"){
    		    url = nui.context+"/inquiry/inquiryResultManage/inquiryResultEntering/repurchase/buyoutRepo.jsp";
    		}
    		nui.open({
    			url:url,
    			title:"添加询价指令/建议",
    			width:widthValue,
    			height:heightValue,
    			allowResize:false,
    			onload:function(){
    				var iframe = this.getIFrameEl();
    				if(row.vcBizType=="3"){
	    				iframe.contentWindow.initWin(1,data);
    				}else{
	    				iframe.contentWindow.initWin(0,data);
    				}
    			},
    			ondestroy:function(action){
    				window.parent.reloadPositionGrid();
    				if(action=="ok"){
    					window.parent.redirectComfirm(data);
    				}
    			}
    		});
    	}
    	
    	function inqueryDetail(lResultId,vcBizType){
    		nui.ajax({
    			url:"com.cjhxfund.ats.sm.inquiry.financeGapManage.getRelateInquiryInstruct.biz.ext",
    			type: 'POST',
		      	data: {paramObject:{lResultId:lResultId}},			
		      	contentType: 'text/json',
		      	success: function(text){
		      		var returnJson = nui.decode(text);
		      		var data = returnJson.inquiryInstruct;
		      		var url = nui.context+"/inquiry/inquiryResultManage/inquiryResultConfirm/repurchase/inquiryDetailShow_znhg_zyshg.jsp";
		    		var widthValue = 750;
		    		var heightValue = 666;
		    		if(vcBizType=="1"||vcBizType=="3"){
		    			if(vcBizType=="1"){
			    			heightValue = 376;
		    			}else{
			    			heightValue = 408;
		    			}
		    			url=nui.context+"/inquiry/inquiryResultManage/inquiryResultEntering/transaction/inquiryDetailShow_zqmm.jsp";
		    		}
		    		if(vcBizType=="6"){
		    			url=nui.context+"/inquiry/inquiryResultManage/inquiryResultConfirm/repurchase/instructDetailShow_znhg_mdshg_jyy.jsp";
		    		}
		    		nui.open({
			            url: url,
			            title: "询价结果详细展示",
			            width: widthValue,
			            height: heightValue,
			            onload: function () {
			                var iframe = this.getIFrameEl();
			                // 直接从页面获取，不用去后台获取
			                iframe.contentWindow.setFormData(data,"detail");
			            }
			        });
		      	}
    		});
    	}
    	
    	//交易员去修改对应的询价结果
    	function editInqueryInstruction(lResultId,vcBizType){
    		nui.ajax({
    			url:"com.cjhxfund.ats.sm.inquiry.financeGapManage.getRelateInquiryInstruct.biz.ext",
    			type: 'POST',
		      	data: {paramObject:{lResultId:lResultId}},			
		      	contentType: 'text/json',
		      	success: function(text){
		      		var returnJson = nui.decode(text);
		      		var data = returnJson.inquiryInstruct;
		      		var url = nui.context+"/inquiry/inquiryResultManage/inquiryResultEntering/repurchase/collateraliseRepoM.jsp";
		    		var widthValue = 913;
		    		var heightValue = 570;
		    		if(vcBizType=="1"){
		    			url = nui.context+"/inquiry/inquiryResultManage/inquiryResultEntering/transaction/inquiryInput_zqmm/inquiryIssucdFrame_zqmm.jsp";
		    			widthValue = 1070;
		    			heightValue = 507;
		    		}
		      		nui.open({
		    			url:url,
		    			title:"修改询价指令/建议",
		    			width:widthValue,
		    			height:heightValue,
		    			allowResize:false,
		    			onload:function(){
		    				var iframe = this.getIFrameEl();
		    				if(vcBizType=="1"){
		    					data["operatorType"] = "1";
		    					iframe.contentWindow.initWin(0,data);
		    				}else{
		    					iframe.contentWindow.SetData(data);
		    				}
		    			},
		    			ondestroy:function(action){
		    				window.parent.reloadPositionGrid();
		    				if(action=="ok"){
		    					data["nodeId"] = "1845";
		    					window.parent.redirectComfirm(data);
		    				}
		    			}
		    		});
		      	}
    		});
    	}
    	
    	//业务类别列字典翻译
		function renderBizType(e){
			if(e.value=="10"){
				return "追加提取";
			}else if(e.value=="11"){
				return "一级缴款";
			}else if(e.value=="12"){
				return "存款";
			}else if(e.value=="13"){
				return "基金申购";
			}else if(e.value=="14"){
				return "期货出入金";
			}else if(e.value=="7"){
				return "上交所协议回购";
			}else if(e.value=="8"){
				return "深交所协议回购";
			}else{
				return nui.getDictText("bizTypeAll",e.row.vcBizType);
			}
		}
		
		//交易市场列字典翻译
	    function renderMarket(e){
	    	if(e.value=="7"){
				return "期货";
			}else{
				return nui.getDictText("tradePlace",e.row.vcMarketNo);
			}
	    }
	    
	    //委托方向列字典翻译
		function renderEntrustDirection(e){
			if(e.value=="41"){
				return "追加";
			}else if(e.value=="42"){
				return "提取";
			}else if(e.value=="43"){
				return "缴款";
			}else if(e.value=="44"){
				return "存出";
			}else if(e.value=="45"){
				return "申购";
			}else if(e.value=="46"){
				return "入金";
			}else if(e.value=="47"){
				return "出金";
			}else{
				return nui.getDictText("entrustDirection",e.row.vcEntrustDirection);
			}
		}
		
		function renderFundDirection(e){
			if(e.value=="1"){
				return "入";
			}else if(e.value=="2"){
				return "出";
			}
		}
    </script>
</body>
</html>