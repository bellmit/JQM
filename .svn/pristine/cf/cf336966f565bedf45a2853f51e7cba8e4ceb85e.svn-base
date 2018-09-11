<%@page import="com.cjhxfund.ats.fm.comm.StrUtil"%>
<%@page import="com.cjhxfund.ats.fm.comm.commonUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 陈鹏
  - Date: 2016-08-17 13:17:37
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <%
       String processInstId = request.getParameter("processInstId");        //流程ID
       String bizId = request.getParameter("bizId");  //业务ID 
       processInstId = StrUtil.changeNull(processInstId);
       bizId = StrUtil.changeNull(bizId);
     %>
</head>
<body style="width: 100%;height: 100%;margin: 0px;padding: 0px;" onload="inIt()">
	<div id="tabs" class="nui-tabs" height="100%" onactivechanged="activechangedFun">
		<!-- <div title="债券详情">
			<div id="dataform1">
				<table style="width:100%; table-layout:fixed;margin: 0xp;padding: 0px;" id="table" border="0" class="nui-form-table">	
					<tr>
						<th class="form_label" width="12%" align="right" >
						债券名称:    
						</th>
						<td colspan="1" width="13%" align="left">
							<input class="nui-textbox" name="stockIssueinfo/vcStockName" readonly="readonly"/>
						</td>
						<th class="form_label" align="right" width="12%">
						证券类别:
						</th>
						<td colspan="1" width="13%">
							<input class="nui-textbox" name="stockIssueinfo/vcStockType" readonly="readonly"/>
						</td>
						<th class="form_label" width="10%" align="right">
				                        起息日:
						</th>
						<td colspan="1" width="12%" >
							<input class="nui-textbox" name="stockIssueinfo/lBegincalDate" readonly="readonly"/>
						</td>
						<th class="form_label" width="17" align="right">
					                到期日:
						</th>
						<td colspan="1" width="13%" >
							<input class="nui-textbox" name="stockIssueinfo/lEndincalDate" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th class="form_label" align="right">
				                        债券年限(年):
						</th>
						<td colspan="1" > 
							<input class="nui-textbox" name="stockIssueinfo/enExistLimite" readonly="readonly"/>
						</td>
						<th class="form_label" align="right">
				                        付息频率:
						</th>
						<td colspan="1" >
							<input class="nui-textbox" name="stockIssueinfo/enPayInteval" readonly="readonly"/>
						</td>
						<th class="form_label" align="right">
				                        票面利率(%):
						</th>
						<td colspan="1">
							<input class="nui-textbox" name="stockIssueinfo/enFaceRate" readonly="readonly"/>
						</td>
						<th class="form_label" align="right">
				                        利率类型:
						</th>
						<td colspan="1" >
							<input class="nui-textbox"  name="stockIssueinfo/cInterestType" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th class="form_label" align="right">
				                        基准类别:
						</th>
						<td colspan="1" >
							<input class="nui-dictcombobox" dictTypeId="CF_JY_ZTLX" name="stockIssueinfo.ratingType" readonly="readonly"/>
						</td>
							<th class="form_label" align="right">
				                        含权标识:
						</th>
						<td colspan="1" >
							<input class="nui-textbox" name="stockIssueinfo.cIsHaveSaleback" readonly="readonly"/>
						</td>
						<th class="form_label" align="right">
				                        债券信用评级:
						</th>
						<td colspan="1">
							<input class="nui-textbox" name="stockIssueinfo.cBondAppraise"  readonly="readonly"/>
						</td>
						<th class="form_label" align="right">
				                        发行人信用评级:
						</th>
						<td colspan="1" >
							<input class="nui-textbox" name="stockIssueinfo.cIssueAppraise" readonly="readonly"/>
						</td>
					</tr>
						
					<tr>
						<th class="form_label" align="right">
				                        发行机构:
						</th>
						<td colspan="1" > 
							<input class="nui-textbox" name="stockIssueinfo.vcIndustry" readonly="readonly"/>
						</td>
						<th class="form_label" align="right">
				                        最近付息日:
						</th>
						<td colspan="1" >
							<input class="nui-textbox" name="cfjybusinessbonetable.investcategory" readonly="readonly"/>
						</td>
						<th class="form_label" align="right">
				                        债券登记日:
						</th>
						<td colspan="1">
							<input class="nui-textbox" name="stockIssueinfo.lIssuePostDate"  readonly="readonly"/>
						</td>
						<th class="form_label" align="right">
				                     中债估值(元):
						</th>
						<td colspan="1">
							<input class="nui-textbox" name="stockIssueinfo.issueSize" readonly="readonly"/>
						</td>
					</tr>
				</table>
			</div>
	    </div> -->
		<div title="审批信息" style="overflow: hidden;" refreshOnClick="true">
		<!-- 流程处理信息列表 -->
			<div id="approval_form">
				<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.foundation.task.EntityDataSet.TAtsApproveInfo"/>
				<input class="nui-hidden" name="criteria/_expr[1]/lProcessInstId" id="processInstId"/>
				<input class="nui-hidden" name="cirteria/_expr[1]/_op" value="="/>
			</div>
			<div id="approvalGrid" class="nui-datagrid" style="width:100%;height:205px;"
				 url="com.cjhxfund.foundation.task.pendingTreatment.queryTAtsApproveInfoList.biz.ext"  
				 dataField="TAtsApproveInfos"  showPageInfo="false" showPager="false">
				<div property="columns">            
					<div field="lApproveId"  headerAlign="center" visible="false">编号</div> 
					<div field="lProcessInstId"  headerAlign="center" visible="false">流程ID</div>
					<div field="dStartTime"  headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss">审批时间</div>                                        
					<div field="vcWorkItemName"  headerAlign="center" >节点名称</div>   
					<div field="vcUserName"  headerAlign="center" >操作者</div>  
					<div field="vcOperateType"  headerAlign="center" renderer="rendeRoperateType">操作</div>  
					<div field="vcComments"  headerAlign="center" >处理意见</div>         
				</div>
			</div> 
		</div>
		<div title="流程图" url="<%=request.getContextPath() %>/com.cjhxfund.foundation.task.ProcessChart.flow?processInstID=<%=processInstId %>"></div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	function inIt(){
    		var data = {bizId:'<%=bizId %>'};
			var json = nui.encode(data);
			$.ajax({
				url:"com.cjhxfund.foundation.task.pendingTreatment.expandTAtsStockIssueInfo.biz.ext",
				type:'POST',
				data:json,
				cache:false,
				contentType:'text/json',
				success:function(text){
					var returnJson = nui.decode(text);
					var form = new nui.Form("#dataform1");//将普通form转为nui的form
					form.setData(returnJson);
					form.setChanged(false);
				}
			});	

		}
		
	//tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	function activechangedFun(){
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tabs").getActiveTab().title;
		if(activeTabTitle.indexOf("审批信息")!=-1){
			nui.get("processInstId").setValue('<%=processInstId %>');
			//审批意见
			var approvalGrid = nui.get("approvalGrid");
			var formData = new nui.Form("#approval_form").getData(false,false);
			approvalGrid.load(formData);
		}
	}		
    </script>
</body>
</html>