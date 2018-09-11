<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>
<html>
<!-- 
  - Author(s): 谢海光
  - Date: 2017-08-16 15:46:02
  - Description:
-->
<head>
<title>查看新债历史</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<div id="dataform1">
	  <input class="nui-hidden" id="lUnderwriterStockIdMap" name="map/lUnderwriterStockId" />
	</div>

    <div class="nui-fit">
		<div id="datagrid1" class="nui-datagrid"
		 style="width: 100%; height: 95%;" 
		 pageSize="20"   sortField=dUpdateTime  dataField="underwriterStockInfo" sortOrder="desc"
		 showPageInfo="true" url = "com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryDebtIssueUnderwriterHis.biz.ext">
	
			<div property="columns">
				<div field="lUnderwriterStockId" headerAlign="center" allowSort="true" visible=false>序号</div>
         		<div field="vcMainUnderwriter" headerAlign="center" allowSort="true" width="150px" visible=false>主承销商</div>
         		<div field="vcUnderwriterContactInfo" headerAlign="center" allowSort="true" width="150px" visible=false>主承销商相关联系方式</div>
         
         		<div field="vcApplicationTime" headerAlign="center" allowSort="true" width="180px">发行时间</div>
         
         		<div field="vcEntryTime" headerAlign="center" allowSort="true">簿记时间</div>
         
                <div field="vcIssuerNameFull" headerAlign="center" width="150px" allowSort="true" > 发行主体 </div>
                <div field="vcStockType" headerAlign="center" allowSort="true" >债券类别</div>
                <div field="vcIssueType" headerAlign="center" allowSort="true" >发行方式</div>
                <div field="vcStockName" headerAlign="center" allowSort="true"  width="180px">债券简称</div>
                <div field="vcStockNameFull" headerAlign="center" allowSort="true" >债券全称</div>
                <div field="vcIssueBalance" headerAlign="center" allowSort="true" width="80px" align="right">发行规模(亿)</div>
                <div field="vcExistLimite" headerAlign="center" allowSort="true" width="80px" align="right">发行期限(年)</div>
                <div field="vcExistLimiteDesc" headerAlign="center" allowSort="true" width="80px" align="right">发行期限备注</div>
                <div field="vcInquiryInterval" headerAlign="center" allowSort="true"  align="right" width="80px" >询价区间</div>
                <div field="vcIssueAppraise" headerAlign="center" align="center" allowSort="true" width="80" >主体评级</div>
                <div field="vcBondAppraise" headerAlign="center" align="center" width="60px">债券评级</div>
                
                <div field="vcAppraiseOrgan" headerAlign="center" width="150px" allowSort="true">债券评级机构</div>
                
                <div field="vcPaymentPlace" headerAlign="center" allowSort="true">登记托管机构</div>
                <div field="vcDueDate" headerAlign="center" allowSort="true" >预计到期日</div>
                <div field="vcPayInteval" headerAlign="center" allowSort="true" >还本付息方式</div>
                <div field="vcBegincalDate" headerAlign="center" allowSort="true" >起息日</div>
                <div field="vcCreditSituation" headerAlign="center" allowSort="true" >增信情况</div>
				<div field="vcEnterpriseProperty" headerAlign="center" allowSort="true" >企业性质</div>
				<div field="vcIsBid" headerAlign="center" allowSort="true" >是否城投</div>
				<div field="vcMarkAssets" headerAlign="center" allowSort="true" >标的资产</div>
				<div field="vcOldHolder" headerAlign="center" allowSort="true" >原始权益人</div>
				<div field="vcIsPledge" headerAlign="center" allowSort="true" >是否可质押</div>
				<div field="vcPropertyDesc" headerAlign="center" allowSort="true" >资质简介</div>
				<div field="vcHisIssue" headerAlign="center" allowSort="true" >历史发债</div>
				<div field="vcIsHaveFinancing" headerAlign="center" allowSort="true" >是否有过融资历史</div>
				<div field="cStatus" headerAlign="center" allowSort="true" visible="false" renderer="renderercStatus">承销商状态</div>
				<div field="lReleaseCount" headerAlign="center" allowSort="true" align="right" visible="true">发布次数</div>
				<div field="lOperatorNo" headerAlign="center" allowSort="true" align="right" visible="true">更新人</div>
				<div field="dUpdateTime" dateFormat="yyyy-MM-dd HH:mm:ss" width="160px"  headerAlign="center" allowSort="true" align="right" visible="true">更新时间</div>
			</div>
		</div>
	</div>
	
	  <div id="footer" class="nui-toolbar" style="padding:0px; width:100%;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align:center;" >
					<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onExict()">
                                                                        关闭
					</a>
				</td>
			</tr>
		</table>
	</div>
	<script type="text/javascript">
    	nui.parse();
		var grid = nui.get("datagrid1"); 
		
		var form = new nui.Form("#dataform1");
		 
		function SetDataInit(data){
    	 
    	// grid.setData(nui.decode(data.appraise));
    	 form.setData(data); 
    	 nui.get("lUnderwriterStockIdMap").setValue(data.lUnderwriterStockId);
    	 var data = form.getData(false,false);      //获取表单多个控件的数据
         grid.load(data);
    	 
    	 //grid.setData(nui.decode(data));
    	}  
    	
	  //当选择列时
        function selectionChanged(){
            var rows = grid.getSelecteds();
            if(rows.length>1){
                nui.get("update").disable();
            }else{
                nui.get("update").enable();
            }
        }
        
       function onExict(){
           CloseWindow("cancel");
           
       }
	   function CloseWindow(action) {
	       if (window.CloseOwnerWindow){
		        return window.CloseOwnerWindow(action);
	       }
	       else window.close();
	   }
    </script>
</body>
</html>