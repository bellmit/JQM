<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>
<html>
<!-- 
  - Author(s): 谢海光
  - Date: 2017-06-27 16:20:37
  - Description:
-->
<head>
<title>主承销商导入模板查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
		
	<div class="search-condition">
		  <div class="list">
            <div id="form1" class="nui-form"  align="center" >
                <input type="hidden" class="nui-hidden" id="cStatus" name="map/cStatus" value="1"/>
                <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                    <tr>
                        <td align="right"  width="120">
						 用户名称:
		                </td>
		                <td align="left"  width="20%">
							 <input  class="nui-textbox"  name="map/lOperatorName" id="lOperatorName" width="100%"/>
                        </td>
                        
                        <td align="left">
					       <a id="query" class="nui-button" iconCls="icon-search" onclick="search()">
					                        查询
					       </a>                        
                            <span>&nbsp;</span>
					       <a id="query" class="nui-button" iconCls="icon-reload" onclick="reset()">
					                        重置
					       </a>                        
					    </td>
                    </tr>
                </table>
            </div>
           </div>
         </div>		
	<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class='nui-button' id="addAlisa" iconCls='icon-add' onclick='addAlias()'>增加主承导出模板</a>
                            <a class='nui-button' id="updateAlias" iconCls='icon-edit' onclick='updateAlias()'>修改</a>
                            <a class='nui-button' id="deleteAlisa" iconCls='icon-remove' onclick='deleteAlias()'>删除</a>
                        </td>
                    </tr>
                </table>
            </div>
	<div class="nui-fit">
		    <div id="datagrid1" class="nui-datagrid"
			style="width: 100%;height: 100%;" 
			url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryUnderwriterImportTemp.biz.ext"
			onselectionchanged="selectionChanged"
			dataField="underwriterInport" multiSelect="true" pageSize="20" showPageInfo="true"  sortField="lAliasId" sortOrder="desc">

                <div property="columns" >
				<div type="indexcolumn"></div>
                    <div type="checkcolumn"  width="20">
                    </div>
					<div field="cStatus" headerAlign="center" allowSort="true" visible=false>状态</div>
					<div field="lOperatorNo" headerAlign="center" allowSort="true" visible=false>用户ID</div>
					<div field="lOperatorName"  headerAlign="center" width="180" >
						 主承模板用户
			        </div>
             		<div field="vcMainUnderwriter" headerAlign="center" allowSort="true" width="100px">主承销商</div>
             		<div field="vcUnderwriterContactInfo" headerAlign="center" allowSort="true" width="100px">主承销商相关联系方式</div>
             
             		<div field="vcApplicationTime" headerAlign="center" allowSort="true" width="100px">发行时间</div>
             
             		<div field="vcEntryTime" headerAlign="center" allowSort="true" width="100px">簿记时间</div>
             
                    <div field="vcIssuerNameFull" headerAlign="center" width="100px" allowSort="true" > 发行主体 </div>
                    <div field="vcStockType" headerAlign="center" allowSort="true" width="100px">债券类别</div>
                    <div field="vcIssueType" headerAlign="center" allowSort="true" width="100px">发行方式</div>
                    <div field="vcStockName" headerAlign="center" allowSort="true"  width="100px">债券简称</div>
                    <div field="vcStockNameFull" headerAlign="center" allowSort="true" width="100px">债券全称</div>
                    <div field="vcIssueBalance" headerAlign="center" allowSort="true" width="100px" >发行规模(亿)</div>
                    <div field="vcExistLimite" headerAlign="center" allowSort="true" width="100px" >发行期限(年)</div>
                    <div field="vcExistLimiteDesc" headerAlign="center" allowSort="true" width="100px" >发行期限备注</div>
                    <div field="vcInquiryInterval" headerAlign="center" allowSort="true" width="100px" >询价区间</div>
                    <div field="vcIssueAppraise" headerAlign="center" allowSort="true" width="100px" >主体评级</div>
                    <div field="vcBondAppraise" headerAlign="center" awidth="100px">债券评级</div>
                    
                    <div field="vcAppraiseOrgan" headerAlign="center" width="100px" allowSort="true">债券评级机构</div>
                    
                    <div field="vcPaymentPlace" headerAlign="center" allowSort="true" width="100px">登记托管机构</div>
                    <div field="vcDueDate" headerAlign="center" allowSort="true" width="100px">预计到期日</div>
                    <div field="vcPayInteval" headerAlign="center" allowSort="true" width="100px">还本付息方式</div>
                    <div field="vcBegincalDate" headerAlign="center" allowSort="true" width="100px">起息日</div>
                    <div field="vcCreditSituation" headerAlign="center" allowSort="true" width="100px">增信情况</div>
					<div field="vcEnterpriseProperty" headerAlign="center" allowSort="true" width="100px">企业性质</div>
					<div field="vcIsBid" headerAlign="center" allowSort="true" width="100px">是否城投</div>
					<div field="vcMarkAssets" headerAlign="center" allowSort="true" width="100px">标的资产</div>
					<div field="vcOldHolder" headerAlign="center" allowSort="true" width="100px">原始权益人</div>
					<div field="vcIsPledge" headerAlign="center" allowSort="true" width="100px">是否可质押</div>
					<div field="vcPropertyDesc" headerAlign="center" allowSort="true" width="100px">资质简介</div>
					<div field="vcHisIssue" headerAlign="center" allowSort="true" width="100px">历史发债</div>
					<div field="vcIsHaveFinancing" headerAlign="center" allowSort="true" width="100px">是否有过融资历史</div>
					
					<div field="vcInfoNetUrlTime" headerAlign="center" allowSort="true" width="100px">材料网络版更新时间</div>
					<div field="vcInfoNetUrl" headerAlign="center" allowSort="true" width="100px">材料网络下载链接</div>
					<div field="vcSummaryUrl" headerAlign="center" allowSort="true" width="100px">调研纪要/路演纪要(若有) 下载链接</div>
					<div field="vcSummaryTime" headerAlign="center" allowSort="true" width="100px">路演时间</div>
					<div field="vcIssueBondAppraise" headerAlign="center" allowSort="true" width="100px">评级(主体/债项)</div>
					<div field="vcBondIssueAppraise" headerAlign="center" allowSort="true" width="100px">评级(债项/主体)</div>
                </div>
     </div> 
     </div> 
	<script type="text/javascript">
    	nui.parse();
        var grid = nui.get("datagrid1");
        var form = new nui.Form("#form1");
        var formData = form.getData(false,false);
        grid.load(formData);
        //重置查询条件
            function reset(){
               form.reset();
            }
             //查询
           function search() {            
              var json = form.getData(false,false);
              grid.load(json);//grid查询
            }
            function addAlias() {
				   nui.open({  
		                url: "<%=request.getContextPath()%>/fm/baseinfo/firstGradeDebt/importCustomExcel.jsp",
		            title: "新增主承模板", width: 880, height: 385,
		            onload: function () {//弹出页面加载完成
		              //var iframe = this.getIFrameEl();
		              //iframe.contentWindow.setFormData(data);
		            },
		            ondestroy: function (action) {//弹出页面关闭前
		                grid.reload();
		            }
		            });
	           
		 }
		function deleteAlias(){
	    	var rows = grid.getSelecteds();
	    	if (rows.length>0) {//com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.updateUnderwriterInfo
	    		nui.confirm("请确定需要删除承销商模板信息？","删除确认",function(action){
		            if(action!="ok") return;
					
					var json = nui.encode({alias:rows});
					$.ajax({
			          url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.deleteUnderwriterTemp.biz.ext",
			          type: 'POST',
				      data: json,
				      cache: false,
				      contentType:'text/json',
			          success:function(text){
			            var returnJson = nui.decode(text);
					    if(returnJson.exception == null){
					       nui.alert("删除成功", "系统提示", function(action){
			            		if(action == "ok" || action == "close"){
			                		grid.reload();
			            		}
			        		});
					    }
			          }
			        });
		       });
	    	} else {
	            nui.alert("请选择要删除的记录！");
	        }
        }
        function updateAlias(){
	    var row = grid.getSelected();
        if (row) {
            nui.open({
                url: "<%=request.getContextPath()%>/fm/baseinfo/firstGradeDebt/importCustomExcel.jsp",
		        title: "新增主承模板", 
		        width: 880, 
		        height: 385,
                //allowResize:false,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = row;
                    iframe.contentWindow.SetDataInit(data);
                },
                ondestroy: function (action) {
                    if(action=="saveSuccess"){
                        grid.reload();
               	 	}
                }
            });
            
        } else {
            nui.alert("请选择要修改的记录！");
        }
	   }
	   //当选择列时
        function selectionChanged(){
            var rows = grid.getSelecteds();
			if(rows.length > 1){
				nui.get("updateAlias").disable();
			}else{
				nui.get("updateAlias").enable();
			}
        }
    </script>
</body>
</html>