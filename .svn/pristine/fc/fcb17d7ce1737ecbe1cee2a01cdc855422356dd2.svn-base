<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 创金合信
  - Date: 2016-09-03 14:31:43
  - Description: 触犯风控（ 指令/建议跟踪）
-->
<head>
	<title>触犯风控</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
	<div id="datagrid_violate_risk_ctrl" 
	 		url="com.cjhxfund.ats.sm.comm.InstructionManager.getRiskMsg.biz.ext"
	 		dataField="riskMsgs" 
			class="nui-datagrid" style="width:100%;height:100%;"
	        showPager="false"
	        allowSortColumn="false"
	        enableHotTrack="false">
	    <div property="columns">
	        <div field="cRiskSource" headerAlign="center" renderer="renderRiskSource" align="center" width="75px">
	            触警来源
	        </div>
	        <div field="cRiskOperation" headerAlign="center"  renderer="renderRiskOperation" align="center" width="75px">
	            触警操作
	        </div>
	        <div field="vcThreshhold" headerAlign="center" renderer="renderRiskThreshhold" align="center" width="75px">
	            触警级别
	        </div>
	        <div field="vcRuleId" headerAlign="center"  align="center" width="75px">
	            风控序号
	        </div>
            <div field="vcSettingValue" headerAlign="center"  align="center" numberFormat="n5" width="75px">
                        设置值
            </div>
            <div field="vcRealValue" headerAlign="center"  align="center" numberFormat="n5" width="75px">
                        实际值
            </div>
             <div field="vcRiskSummary" headerAlign="center"  align="center" width="150px">
	           风控说明
	        </div>
            <div field="vcRemark" headerAlign="center"  align="center" width="120px">
                          备注
            </div>
            <div field="lDate" headerAlign="center"  align="center" renderer="wornTimeReview" width="120px">
                           触警时间
            </div>
     	</div>
	</div>
	

	<script type="text/javascript">
    	nui.parse();
    	var risk_ctrl = nui.get("datagrid_violate_risk_ctrl");
    	var lResultId = null;
    	function detail(selectRow){
    		if(lResultId != selectRow.lResultId){
    			if(selectRow.vcClordId != null){
    				var json = {param:{vcClordid:selectRow.vcClordId}};
    				risk_ctrl.load(nui.decode(json));
    			}
    		}
    		lResultId = selectRow.lResultId;
    	}
    	
    	function clearDetail(){
    		lResultId = null;
    		risk_ctrl.clearRows();
    	}
    	
    	function renderRiskThreshhold(e){
    		return nui.getDictText("riskThreshhold",e.row.vcThreshhold);
    	}
    	
    	function renderRiskOperation(e){
    		return nui.getDictText("riskOperation",e.row.cRiskOperation);
    	}
    	
    	function renderRiskSource(e){
    		return nui.getDictText("warnSource",e.row.cRiskSource);
    	}
    	
    	function wornTimeReview(e){
    		if(e.row.lDate!=null || e.row.lTime!=null){
	    		return e.row.lDate.substring(0,4)+"-"+e.row.lDate.substring(4,6)+"-"+e.row.lDate.substring(6,8)+" "+e.row.lTime.substring(0,2)+":"+e.row.lTime.substring(2,4)+":"+e.row.lTime.substring(4,6);
			}else{
				return "";
			}
    	}
    	window.parent.detailLoaded();
    </script>
</body>
</html>