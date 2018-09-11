<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-11-14 13:42:30
  - Description:
-->
<head>
<title>修改历史</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" /> 
    <script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>   
</head>
<body>
	<div id="datagrid_revise_history" dataField="reviseRecords" 
         url="com.cjhxfund.ats.sm.comm.InstructionManager.getInstructReviseHistory.biz.ext"
         class="nui-datagrid" style="width:100%;height:100%;"
	     showPager="false"
	     allowSortColumn="false"
	     enableHotTrack="false">
		<div property="columns">
			<div field="lModifyOrder" headerAlign="center" align="center" width="85px">
               修改次序
            </div>
             <div field="cIsValid" headerAlign="center" width="100px" renderer="renderInstructStatus">
                指令/建议状态
            </div>
            <div field="vcRiskApproveStatus" headerAlign="center" width="85px" renderer="renderRiskApproveStatus">
                风控审批状态
            </div>
            <div field="vcProductName" headerAlign="center"  width="85px">
               产品名称
            </div>
            <div field="vcCombiName" headerAlign="center"  width="85px">
                组合名称
            </div>
            <div field="vcSettleSpeed" headerAlign="center" width="85px" renderer="renderSettleSpeed">
                清算速度
            </div>
            <div field="vcEntrustDirection" headerAlign="center" width="85px" renderer="renderEntrustDirection">
                委托方向
            </div>
            <div field="vcStockCode" headerAlign="center" width="85px">
                债券代码
            </div>
            <div field="vcStockName" headerAlign="center" width="110px">
                债券名称
            </div>
            <div field="lRepoDays" headerAlign="center" width="85px">
                回购天数
            </div>
            <div field="enFaceAmount" headerAlign="center" numberFormat="n2" align="right" width="100px">
               回购金额(万元)
            </div>
            <div field="lIssueDate" headerAlign="center" width="110px">
                投资指令/建议录入日期
            </div>
            <div field="lTradeDate" headerAlign="center" width="85px">
                交易日
            </div>
            <div field="lFirstSettleDate" headerAlign="center" width="85px">
               首次结算日
            </div>
            <div field="lMaturitySettleDate" headerAlign="center" width="85px">
                到期结算日
            </div>
            <div field="enSettleAmount" headerAlign="center" numberFormat="n2" align="right" width="85px">
               到期结算金额(元)
            </div>
            <div field="vcQuoteMode" headerAlign="center" width="130px">
                报价方式
            </div>
            <div field="enRepoRate" headerAlign="center" align="right" width="130px">
               回购利率(%)
            </div>
            <div field="enWeightingValue" headerAlign="center" align="right" width="85px">
               加权加点(bp)
            </div>
            <div field="tInitiateTime" headerAlign="center" renderer="initiateRenderReview" width="200px">
                投资指令/建议录入时间
            </div>
           	<div field="tModifierTime" headerAlign="center" renderer="modifierReview" width="200px" >
                指令/建议修改时间
            </div>
            <div field="vcRemark" headerAlign="center" width="85px">
                备注
            </div>
		</div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	var revise_history = nui.get("datagrid_revise_history");
		var lInquiryId = null;
		function detail(selectRow){
			if(lInquiryId != selectRow.lInquiryId){
				var json = {lInquiryNo:selectRow.lInquiryNo};
    			if(selectRow.lResultNo != null){
    				json["lResultNo"] = selectRow.lResultNo;
    			}
    			revise_history.load({params:json});
			}
			lInquiryId = selectRow.lInquiryId;
		}
		
		revise_history.on("drawcell", function (e) {
	        var field = e.field,
        		value = e.value;
			if(field=="lIssueDate"){
				e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
			}
			if(field=="lTradeDate"){
				e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
			}
			if(field=="lFirstSettleDate"){
				e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
			}
			if(field=="lMaturitySettleDate"){
				e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
			}
	    });
		
		function clearDetail(){
			lInquiryId = null;
			revise_history.clearRows();
		}
		//指令/建议类别列字典翻译
	    function renderInstructType(e) {
			return nui.getDictText("instructType",e.row.vcInstructType);
		}
		//委托方向列字典翻译
	    function renderEntrustDirection(e){
	    	return nui.getDictText("entrustDirection",e.row.vcEntrustDirection);
	    }
	    //交易市场列字典翻译
	    function renderMarket(e){
	    	return nui.getDictText("tradePlace",e.row.vcMarket);
	    }
	    //业务类别列字典翻译
	    function renderBizType(e){
	    	return nui.getDictText("bizTypeRepurchase",e.row.vcBizType);
	    }
	    //清算速度列字典翻译
	    function renderSettleSpeed(e){
	    	return nui.getDictText("settleSpeed",e.row.vcSettleSpeed);
	    }
	    
	    function renderRiskApproveStatus(e){
	    	if(e.value == null){
	    		return "--";
	    	}else{
	    		return nui.getDictText("riskApproveStatus",e.row.vcRiskApproveStatus);
	    	}
	    }
	    
	    //指令/建议下达时间显示处理
	    function initiateRenderReview(e){
			return (e.row.vcInitiatorName==null?"":e.row.vcInitiatorName) + "　" + nui.formatDate(e.row.tInitiateTime, "yyyy-MM-dd HH:mm:ss");
		}
		
		//询价结果录入时间显示处理
	    function resultRenderReview(e){
	    	if(e.row.vcResultInputerName!=null || e.row.tResultInputTime!=null){
	    		return (e.row.vcResultInputerName==null?"":e.row.vcResultInputerName) + "　" + nui.formatDate(e.row.tResultInputTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return "";
			}
		}
		//投资经理确认时间处理
	    function sendRenderReview(e){
	    	if(e.row.vcFsSenderName!=null || e.row.tFsSendTime!=null){
				return (e.row.vcFsSenderName==null?"":e.row.vcFsSenderName) + "　" + nui.formatDate(e.row.tFsSendTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return "";
			}
		}
		//指令/建议状态列字典翻译
	    function renderInstructStatus(e){
	    	return nui.getDictText("instructStatus",e.row.cIsValid);
	    }
		//指令/建议修改时间处理
	    function modifierReview(e){
	    	if(e.row.vcModifierName!=null || e.row.tModifierTime!=null){
				return (e.row.vcModifierName==null?"":e.row.vcModifierName) + "　" + nui.formatDate(e.row.tModifierTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return "";
			}
		}
		window.parent.detailLoaded();
    </script>
</body>
</html>