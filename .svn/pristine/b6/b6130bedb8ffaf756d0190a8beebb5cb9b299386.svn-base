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
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
</head>
<body>
	<div id="datagrid_revise_info" dataField="reviseRecords" 
         url="com.cjhxfund.ats.sm.comm.InstructionManager.combineInstructHistory.biz.ext"
         class="nui-datagrid" style="width:100%;height:100%;"
	     showPager="false"
	     allowSortColumn="false"
	     enableHotTrack="false">
		<div property="columns">
			<!-- <div field="lModifyOrder"  headerAlign="center" align="center" width="85px">
               修改次序
            </div> -->
            <div field="cIsValid" headerAlign="center" width="100px" renderer="renderInstructStatus">
                投资指令/建议状态
            </div>
            <div field="vcProductName" headerAlign="center" width="120px">
               产品名称
            </div>
            <div field="vcCombiName" headerAlign="center" width="100px">
                组合名称
            </div>
             <div field="vcSettleSpeed" headerAlign="center" width="85px" renderer="renderSettleSpeed">
                清算速度
            </div>
            <div field="vcEntrustDirection" headerAlign="center" width="120px" renderer="renderEntrustDirection">
                委托方向
            </div>
            <div field="vcStockCode" headerAlign="center" width="85px">
                债券代码
            </div>
            <div field="vcStockName" headerAlign="center" width="100px">
                债券名称
            </div>
             <div field="enFaceAmount" headerAlign="center" numberFormat="n2" align="right" width="120px">
                券面金额（万元）
            </div>
            <div field="lResultDate" headerAlign="center" width="120px">
                投资指令/建议录入日期
            </div>
            <div field="lTradeDate" headerAlign="center" width="85px">
                交易日
            </div>
            <div field="lFirstSettleDate" headerAlign="center" width="85px">
                结算日
            </div>
           
            <div field="enNetPrice" headerAlign="center" align="right" width="85px">
                净价
            </div>
            <div field="enFullPrice" headerAlign="center" align="right" width="85px">
               全价
            </div>
            <div field="enMaturityYield" headerAlign="center" align="right" width="130px">
                到期收益率（%）
            </div>
            <div field="enOptionYield" headerAlign="center" align="right" width="130px">
              行权收益率（%）
            </div>
            <div field="tInitiateTime" headerAlign="center" renderer="initiateRenderReview" width="200px">
                投资指令/建议录入时间
            </div>
            <div field="tFsSendTime" headerAlign="center" renderer="sendRenderReview" width="200px" >
                投资经理确认时间
            </div>
            <div field="tModifierTime" headerAlign="center" renderer="modifierReview" width="200px" >
                投资指令/建议修改时间
            </div>
		</div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	var revise_history = nui.get("datagrid_revise_info");
		var lResultId = null;
		function detail(selectRow){
			if(lResultId != selectRow.lResultId){
				var json = {lInquiryNo:selectRow.lInquiryNo};
    			if(selectRow.lResultNo != null){
    				json["lResultNo"] = selectRow.lResultNo;
    			}
    			revise_history.load({params:json});
			}
			lResultId = selectRow.lResultId;
		}
		
    	revise_history.on("drawcell", function (e) {
	        var field = e.field,
        		value = e.value;
			if(field=="lResultDate"){
				if(value){
					e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
				}
			}
			if(field=="lTradeDate"){
				if(value){
					e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
				}
			}
			if(field=="lFirstSettleDate"){
				if(value){
					e.cellHtml = nui.formatDate(DateUtil.numStrToDate(value.toString()),"yyyy-MM-dd");
				}
			}
	    });
		
		function clearDetail(){
			lResultId = null;
			revise_history.clearRows();
		}
		//指令/建议状态列字典翻译
	    function renderInstructStatus(e){
	    	return nui.getDictText("instructStatus",e.row.cIsValid);
	    }
		//委托方向列字典翻译
	    function renderEntrustDirection(e){
	    	return nui.getDictText("entrustDirection",e.row.vcEntrustDirection);
	    }
	    //交易市场列字典翻译
	    function renderMarket(e){
	    	return nui.getDictText("tradePlace",e.row.vcMarket);
	    }
	    //清算速度列字典翻译
	    function renderSettleSpeed(e){
	    	return nui.getDictText("settleSpeed",e.row.vcSettleSpeed);
	    }
	    //指令/建议下达时间显示处理
	    function initiateRenderReview(e){
			return (e.row.vcResultInputerName==null?"":e.row.vcResultInputerName) + "　" + nui.formatDate(e.row.tResultInputTime, "yyyy-MM-dd HH:mm:ss");
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
		
		//指令/建议修改时间处理
	    function modifierReview(e){
	    	if(e.row.vcModifierName!=null || e.row.tModifierTime!=null){
				return (e.row.vcModifierName==null?"":e.row.vcModifierName) + "　" + nui.formatDate(e.row.tModifyTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return "";
			}
		}
		window.parent.detailLoaded();
    </script>
</body>
</html>