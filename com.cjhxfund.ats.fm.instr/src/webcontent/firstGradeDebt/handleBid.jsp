<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<%
	String userId_zbqr = ""; 
	if (userObject != null) {
		userId_zbqr = (String)userObject.getUserId();
	}
 %>
<!-- 
  - Author(s): 杨敏
  - Date: 2017-05-9 17:55:41
  - Description:
-->
<head>
<title>新债投标</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />  
    <style type="text/css">
    	.mini-tabs-bodys{
    		border: 0px;
    	}
    	.mini-layout-region{
    		border-left: 0px;
    		border-right: 0px;
    		border-bottom: 0px;
    	}
    	.mini-panel-border{
    		border-left: 0px;
    		border-right: 0px;
    	}
    </style> 
    <script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/common/js/commonjs.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/riskMgr/js/riskMgrComm.js"></script>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;">
<div id="layout1" class="mini-layout" style="width:100%; height:100%;"  borderStyle="border:0px;">
	<div height="65%" borderStyle="border:0px;">
		<div class="search-condition" >
		  <div class="list">
            <div id="form1" class="nui-form"  align="center" >
                <form id="queryForm" action="">
                <input type="hidden" class="nui-hidden" id="excelData" name="excelData" />
                <input type="hidden" class="nui-hidden" id=atcionType name="atcionType" />
                <input type="hidden" class="nui-hidden" id="fileName" name="fileName" />
                <!-- 数据实体的名称 -->
	            <input class="nui-hidden" name="bizCriteria/_entity" value="com.cjhxfund.ats.fm.instr.firstGradeDebt.FirstGradeDebtHandleEntity">
	            <input class="nui-hidden" name="wfCriteria/_entity" value="com.eos.workflow.data.WFWorkItem" />

<!-- 	            指令/建议编号倒序排列 -->
<!-- 	            <input class="nui-hidden" name="bizCriteria/_orderby[1]/_sort" value="desc" /> -->
<!-- 	            <input class="nui-hidden" name="bizCriteria/_orderby[1]/_property" value="lInvestNo" /> -->
<!-- 	            缴款日期倒序排列 -->
<!-- 	            <input class="nui-hidden" name="bizCriteria/_orderby[2]/_sort" value="desc" /> -->
<!-- 	            <input class="nui-hidden" name="bizCriteria/_orderby[2]/_property" value="dPaymentDate" /> -->
	                
	            <input class="nui-hidden" name="jurisdiction" value=""/>
                <table id="table1" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                    <tr>
                    	<td style="width:80px" align="right">
                            缴款日期:
                        </td>
                        <td style="width:15%" align="left">
                            <input class="nui-datepicker" id="dPaymentDate" format="yyyy-MM-dd" name="bizCriteria/_expr[1]/dPaymentDate" width="100%"/>
                            <input class="nui-hidden" name="bizCriteria/_expr[1]/_op" value=">=">
                        </td> 
                        <td style="width:80px" align="right">
                            投标截止日期:
                        </td>
                        <td style="width:16%" align="left">
                            <input class="nui-datepicker" id="dBidLimitTime" format="yyyy-MM-dd" name="bizCriteria/_and[1]/_or[1]/_expr[1]/dBidLimitTime" width="100%"/>
                            <input class="nui-hidden" name="bizCriteria/_and[1]/_or[1]/_expr[1]/_op" value=">=">
                            <input class="nui-hidden" name="bizCriteria/_orderby[1]/_property" value="adddate">
                            <input class="nui-hidden" name="bizCriteria/_orderby[1]/_sort" value="asc">
                            <input class="nui-hidden" name="bizCriteria/_orderby[2]/_property" value="deldate">
                            <input class="nui-hidden" name="bizCriteria/_orderby[2]/_sort" value="desc">
                            <input class="nui-hidden" name="bizCriteria/_orderby[3]/_property" value="activitydefSortno">
                            <input class="nui-hidden" name="bizCriteria/_orderby[3]/_sort" value="asc">
                        </td>
                        
                        <td style="width:60px" align="right">
                            产品名称:
                        </td>
                        <td style="width:16%" align="left">
                            <input id="vCFundCode_ZJTC" class="nui-buttonedit" name="bizCriteria/_expr[2]/vcProductCode"
                             id="combProductCode" onbuttonclick="ButtonClickGetFundName_ZJTC" width="100%"/>
                            <input class="nui-hidden" name="bizCriteria/_expr[2]/_op" value="=">
                            
                        </td>
                      <!--  <td style="width:80px" align="right">
						登记托管机构:
		                </td>
		                <td style="width:15%" align="left">
							<input class="nui-dictcombobox" name="bizCriteria/_expr[4]/vcPaymentPlace" dictTypeId="CF_JY_DJTGCS" valueField="dictID" textField="dictName"    
									emptyText="全部" nullItemText="全部"  width="100%" showClose="true" oncloseclick="onCloseClickValueEmpty"  />
                        	<input class="nui-hidden" type="hidden" name="bizCriteria/_expr[4]/_op" value="=">
                        </td>
                        <td style="width:60px" align="right">
						债券类别:
		                </td>
		                <td style="width:15%" align="left">
							<input class="mini-treeselect" name="bizCriteria/_expr[5]/vcStockType" id="cStockType" dataField="data" 
								    url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext?type=1" width="100%" 
								    multiSelect="true"  textField="text" valueField="id" parentField="pid" checkRecursive="false"  showFolderCheckBox="false"
						        	showFolderCheckBox="true"   expandOnLoad="true" showTreeIcon="false" showClose="true"  popupWidth="200"
								   oncloseclick="onCloseClickValueEmpty"/>
                        	<input class="nui-hidden" name="bizCriteria/_expr[5]/_op" value="in">
                        </td>-->
                        <!-- <td align="right" style="width:60px">
						债券代码:
		                </td>
		                <td style="width:16%" align="left">
							<input class="nui-textbox" name="bizCriteria/_expr[6]/vcStockCode" width="100%" />
                        	<input class="nui-hidden" name="bizCriteria/_expr[6]/_op" value="in">
                        </td> -->
                        <td align="right" style="width:60px">
						债券简称:
		                </td>
		                <td style="width:16%" align="left">
							<input class="nui-textbox" id="vcStockName" name="bizCriteria/_or[1]/_expr[8]/vcStockName" width="100%"/>
                        	<input class="nui-hidden" type="hidden" name="bizCriteria/_or[1]/_expr[8]/_op" value="like">
                            <input class="nui-hidden" type="hidden" name="bizCriteria/_or[1]/_expr[8]/_likeRule" value="all">
                            
                            <input class="nui-hidden" id="vcStockNameFull" name="bizCriteria/_or[1]/_expr[10]/vcStockNameFull" width="100%"/>
                        	<input class="nui-hidden" type="hidden" name="bizCriteria/_or[1]/_expr[10]/_op" value="like">
                            <input class="nui-hidden" type="hidden" name="bizCriteria/_or[1]/_expr[10]/_likeRule" value="all">
                            
                        	<input class="nui-hidden" name="bizCriteria/_expr[9]/lValidStatus" value="0" width="100%"/>
                        	<input class="nui-hidden" name="bizCriteria/_expr[9]/_op" value="=">
                        </td>
                        <td style="" align="left">
	                        <a id="query" class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
						                        重置
						    </a> 
                        </td>
                    </tr>
                    <tr>
                    	<td style="width:60px" align="right">
                          	  业务日期:
                        </td>
                        <td  align="left" colspan="1">
                            <input class="nui-datepicker" id="processDate"  format="yyyy-MM-dd" name="bizCriteria/_expr[12]/dApplicationTime" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="bizCriteria/_expr[12]/_op" value=">=">
                         </td>
                         <td style="width:60px" align="center">至</td>
                         <td  align="left">
                            <input class="nui-datepicker"  id="processDate_stop" format="yyyy-MM-dd" name="bizCriteria/_expr[13]/dApplicationTime" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="bizCriteria/_expr[13]/_op" value="<="/>
                        </td>
                         <!--<td align="right">
						发行主体:
		                </td>
                         <td align="left">
							<input id="vCFundCode_ZJTC" class="nui-textbox"  name="bizCriteria/_expr[14]/vcIssuerName"
                             id="IssuerName" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="bizCriteria/_expr[14]/_op" value="like">
                            <input class="nui-hidden" type="hidden" name="bizCriteria/_expr[14]/_likeRule" value="all">
                        </td>-->
                        
                    	<!--<td align="right">
						主体评级:
		                </td>
		                <td align="left">
							<input class="nui-dictcombobox" name="bizCriteria/_expr[15]/cIssueAppraise"  valueField="dictID" textField="dictName" dictTypeId="issuerRating"  
									emptyText="全部" nullItemText="全部" multiSelect="true" showClose="true" valueFromSelect="true" width="100%" oncloseclick="onCloseClickValueEmpty"/>
                        	<input class="nui-hidden" type="hidden" name="bizCriteria/_expr[15]/_op" value="in">
                        </td>-->
                    
                    	<!--<td align="right">
						主体类型:
		                </td>
		                <td align="left">
							<input class="nui-dictcombobox" name="bizCriteria/_expr[7]/vcIssueProperty" dictTypeId="ATS_FM_ISSUE_PROPERTY"  
									 emptyText="全部" nullItemText="全部" showNullItem="false" multiSelect="true" showClose="true" valueFromSelect="true"
									  oncloseclick="onCloseClickValueEmpty"  width="100%"/>
                        	<input class="nui-hidden" name="bizCriteria/_expr[7]/_op" value="in">
                        </td>-->
                    	<!-- <td align="right">
						流程节点:
		                </td>
		                <td align="left">
							<input class="nui-textbox" id="workitemname" name="bizCriteria/_or[1]/_expr[7]/workitemname" width="100%"/>
                        	<input class="nui-hidden" type="hidden" name="bizCriteria/_or[1]/_expr[7]/_op" value="like">
                            <input class="nui-hidden" type="hidden" name="bizCriteria/_or[1]/_expr[7]/_likeRule" value="all">
                          
                        </td> -->
                        <td align="right">是否中标: </td>
                        <td align="left">
                        	<input class="nui-combobox" name="bizCriteria/_expr[6]/isWinTheBidding" dictTypeId="isWinTheBidding"  id="isWinTheBidding"
                        			data="[{id: '中标', text: '中标'}, {id: '未中标', text: '未中标'} ]" 
                        			showNullItem="false" multiSelect="false" showClose="true" valueFromSelect="true"
									  oncloseclick="onCloseClickValueEmpty"  width="100%"/>
                        	<input class="nui-hidden" name="bizCriteria/_expr[6]/_op" value="=">
                        </td> 
                       <!--  <td align="right">流程状态: </td>
                        <td align="left">
                        	<input class="nui-combobox" name="bizCriteria/_expr[10]/currentState" dictTypeId="currentstate"  id="currentstate"
                        			data="[{id: 2, text: '流程运行中'}, {id: 8, text: '流程已结束'} ]" value="2"
                        			showNullItem="false" multiSelect="true" showClose="true" valueFromSelect="true"
									  oncloseclick="onCloseClickValueEmpty"  width="100%"/>
                        	<input class="nui-hidden" name="bizCriteria/_expr[10]/_op" value="in">
                        </td> --> 
                        <td align="right" style="width:60px">授权状态: </td>
                        <td style="width:12%" align="left">
                        	<input class="nui-dictcombobox" multiSelect="true" showClose="true" oncloseclick="onCloseClickValueEmpty" name="bizCriteria/_expr[17]/cApplyAuthStatus" id="ApplyAuthStatus"
                        	data="[{id: 0, text: '正式授权申购'}, {id: 1, text: '非正式授权申购'} ]" width="100%" showClose="true" />
                        	<input class="nui-hidden" name="bizCriteria/_expr[17]/_op" value="in">
                        	
                        	<!-- <input class="nui-hidden" name="bizCriteria/_expr[17]/cApplyAuthStatus" id="cApplyAuthStatus"/>
                        	<input class="nui-hidden" name="bizCriteria/_expr[17]/_op" value="in">
                        	<input class="nui-hidden" name="bizCriteria/_expr[18]/cPaymentAuthStatus" id="cPaymentAuthStatus"/>
                        	<input class="nui-hidden" name="bizCriteria/_expr[18]/_op" value="in"> -->
                        	<input id="vcProcessType" class="nui-hidden" name="bizCriteria/_expr[11]/vcProcessType" value="1,5"  width="100%" />
                        	<input class="nui-hidden" name="bizCriteria/_expr[11]/_op" value="in">
							
							<input class="nui-hidden" id="enPayFaceValue" name="bizCriteria/_expr[16]/activitydefSortno" width="100%" value="14"/>
                        	<input class="nui-hidden" id="enPayFaceValueOp" type="hidden" name="bizCriteria/_expr[16]/_op" value="<">
                        </td>
                        <td style="" align="left">
                        	<a class='nui-button' plain='false' iconCls="icon-search" onclick="search()">
					                        查询
					       </a>
                        </td>
                    </tr>
                </table>
               </form>
            </div>
           </div>
         </div>   
            <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">                            
                            <!-- <a class='nui-button' plain='false' iconCls='icon-add' onclick='revisedOffer()'>修改报价</a> -->
                            <privilege:operation sourceId="ATS_YJZ_XGBL" sid="revisedOffer"  clazz="nui-button" onClick="revisedOffer()" lableName="修改报价"  iconCls="icon-edit" ></privilege:operation>
                            <!-- <a class='nui-button' plain='false' iconCls='icon-edit' onclick='revokeOffer()'>撤销报价</a> -->
                            <privilege:operation sourceId="ATS_YJZ_ZXBJ" sid="revokeOffer"  clazz="nui-button" onClick="revokeOffer()" lableName="撤销报价"  iconCls="icon-undo" ></privilege:operation>
                            <!-- <a class='nui-button' plain='false' iconCls='icon-edit' onclick='payOrder()'>中标缴款</a> -->
                            <privilege:operation sourceId="ATS_YJZ_ZBQR" sid="addAll"  clazz="nui-button" onClick="payOrder()" lableName="中标确认"  iconCls="icon-edit" ></privilege:operation>
                            <!--<privilege:operation sourceId="ATS_YJZ_XD" sid="placeOrder" clazz="nui-button" onClick="placeOrder()" lableName="推送至O32"  iconCls="icon-save" ></privilege:operation> -->
                            <privilege:operation sourceId="ATS_RW_YB_LCT" sid="flowChart" clazz="nui-button" onClick="flowChart()" lableName="查看流程图"  iconCls="icon-search" ></privilege:operation> 
                            <privilege:operation sourceId="ATS_YJZ_YJFS" sid="flowChart" clazz="nui-button" onClick="sendMail()" lableName="邮件发送"  iconCls="icon-save" ></privilege:operation> 
                            <privilege:operation sourceId="ATS_YJZ_CZ" sid="sendFax" clazz="nui-button" onClick="sendFax()" lableName="传真"  iconCls="icon-save" ></privilege:operation> 
                            <privilege:operation sourceId="ATS_YJZ_DC" sid="exportExcel" clazz="nui-button" onClick="exportApply()" lableName="批量导出"  iconCls="icon-download" ></privilege:operation> 
                            <privilege:operation sourceId="ATS_JYGL_XZXXBXZ" sid="stockIssueInfoDown" clazz="nui-button" onClick="wordDownload1()" lableName="新债信息表下载"  iconCls="icon-download" ></privilege:operation> 
                            <privilege:operation sourceId="ATS_JYGL_SCZSZLWJ" sid="inputpaymentfile" clazz="nui-button" onClick="inputPaymentFile()" lableName="上传正式指令文件" iconCls="icon-upload" ></privilege:operation>
                            <privilege:operation sourceId="ATS_JYGL_SCSGH" sid="generatePurchaseOrder" clazz="nui-button" onClick="generatePurchaseOrder()" iconCls="icon-add" lableName="生成申购函" ></privilege:operation> 
                            <privilege:operation sourceId="ATS_JYGL_UPDATE" sid="updateHandleBid" clazz="nui-button" onClick="updateHandleBid()" lableName="投标结果确认"  iconCls="icon-edit" ></privilege:operation> 
                            
                            <privilege:operation sourceId="ATS_YJZ_FQFKLC" sid="atsYjzFqfklc" clazz="nui-button" onClick="startRiskProcessByApplyStockInfo()" lableName="发起风控流程"  iconCls="icon-add" ></privilege:operation>
                            
                          <!--   <a id="riskProcess" enabled="false" class='nui-button' plain='false' iconCls="icon-add" onclick="startRiskProcessByApplyStockInfo()">发起风控流程</a>&nbsp;  -->
                            <%--&nbsp;
                            <a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">编辑</a>
                            &nbsp;
                            <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()"> 删除</a>--%>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="nui-fit" >
                <div 
                        id="datagrid1"
                        dataField="wflist"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.ats.fm.instr.FirstGradeBond.investAdviceManage.biz.ext"
                        pageSize="20"
                        showPageInfo="true"
                        multiSelect="true"
                        onShowRowDetail="onShowRowDetailList"
                         onselectionchanged="selectionChanged" 
                        allowSortColumn="true"
                        sortField="dApplicationTime"
                        pagerButtons="#buttons"
                        sortOrder="desc">

                    <div property="columns">
                        <div type="checkcolumn">
                        </div>
                        <div type="expandcolumn"></div>
                        <div name="action" width="70"   headerAlign="center" align="center">
                        操作
                        </div>
                        <div field="lApplyInstId" headerAlign="center" allowSort="true" visible="false">
                           申购指令/建议编号
                        </div>
                        <div field="lBizId" headerAlign="center" allowSort="true" visible="false">
                           业务ID
                        </div>
                        <div field="workItemID" headerAlign="center" allowSort="true" visible="false">
                           工作项ID
                        </div>
                        <div field="activityDefID" headerAlign="center" allowSort="true" visible="false">
                           活动定义ID
                        </div>
                         <div field="dApplicationTime" headerAlign="center" align="center" allowSort="true" dateFormat="yyyy-MM-dd">
                            业务时间
                        </div>
						<div field="lProcessInstId" headerAlign="center" allowSort="true" >
		           流程编号
                        </div>
                        <div field="vcProductName" headerAlign="center" allowSort="true" width="150px">
                            产品名称
                        </div>
                        <div field="vcStockName" headerAlign="center" allowSort="true" >
                            债券简称
                        </div>
                        <div field=dBidLimitTime name="dBidLimitTime" headerAlign="center" width="150px" align="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss">
                            投标截止日期
                        </div>
                        <div field="workitemname" headerAlign="center" allowSort="true" width="150px" >
                            当前节点
                        </div>
                        <div field="enInterestRate" headerAlign="center" allowSort="true" >
                            投标利率(%)
                        </div>
                        <div field="enInvestBalance" headerAlign="center" allowSort="true" >
                            投标量(万元)
                        </div>
                        <div field="vcMainUnderwriter" headerAlign="center" allowSort="true" width="150px" >
                            主承销商
                        </div>
                        <div field="cFaxStatus" headerAlign="center" align="left" allowSort="true" renderer="onlFaxStatus">
                            传真&签收情况
                        </div>
                        <div field="enCouponRate" headerAlign="center" allowSort="true" >
                          票面利率
                        </div>
                        <div field="isWinTheBidding" headerAlign="center" allowSort="true" >
                          是否中标
                        </div>
                        <div field="cApplyAuthStatus" headerAlign="center" align="center" allowSort="true"  renderer="renderApplyAuthStatus">
        	  申购授权状态
                        </div>
                        <div field="dPaymentDate" name="dPaymentDate" headerAlign="center" align="center" allowSort="true" dateFormat="yyyy-MM-dd">
                            缴款日期
                        </div>
                        <div field="cMarketNo" headerAlign="center" align="center" allowSort="true" visible="false">
       	 市场代码
                        </div>
                      	<div field="lStockInvestNo" headerAlign="center" align="center" allowSort="true" visible="true">
       	投资编号
                        </div>
                </div>
			</div>
		</div>
		</div>
		<div title="投资指令/建议管理详细信息" region="south" showSplit="false" showHeader="true" height="180" showSplitIcon="true" >	
			<div id="tabs" class="nui-tabs" height="100%" style="overflow: hidden;border-left: 0xp;">
				<div title="报量信息">
					<div id="datagrid_Amount" class="nui-form">
						<input class="nui-hidden" name="bizId" id="bizId"  />
					</div>
					<div class="nui-datagrid" id="datagrid10"   height="100%" showPager="false" allowSortColumn="false" allowCellSelect="true" 
						allowCellEdit="true"  url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadReport.biz.ext" multiSelect="true" allowCellValid="true" oncellvalidation="reportEdit" >
						<div property="columns">
							<div field="enReport"  headerAlign="center" align="right" allowSort="true">
								报量(万元)
							</div>
							<div field="enOffer"  headerAlign="center" align="right" allowSort="true">
								报价(%)
							</div>
							<div field="enEnsureGold"  headerAlign="center" align="right" allowSort="true">
								保证金(万元)
							</div>
						</div>
					</div>
				</div>
	            <div title="债券详情">
	              <div id="dataform1">
	            	<table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">	
	            		<tr>
							<td style="width:80px" align="right">
						债券简称:    
							</td>
							<td style="width:15%" align="left">
								<input class="nui-textbox" name="vcStockName" inputStyle="background-color:#f0f0f0;" readonly="readonly" width="80%"/>
							</td>
							<td style="width:80px" align="right">
						证券类别:
							</td>
							<td style="width:15%" align="left">
								<input class="nui-textbox" name="vcStocktypeName" inputStyle="background-color:#f0f0f0;" readonly="readonly" width="80%"/>
							</td>
							<td style="width:80px" align="right">
				                        起息日:
							</td>
							<td style="width:15%" align="left">
								<input class="nui-datepicker" id="lBegincalDate" inputStyle="background-color:#f0f0f0;" name="lBegincalDate" format="yyyy-MM-dd" readonly="readonly" width="80%"/>
							</td>
							<td style="width:80px" align="right">
					                        到期日:
							</td>
							<td style="width:15%" align="left">
								<input class="nui-datepicker" id="lEndincalDate" inputStyle="background-color:#f0f0f0;" name="lEndincalDate" readonly="readonly" width="80%"/>
							</td>
						</tr>
						<tr>
							<td align="right">
				                        发行期限(年):
							</td>
							<td  align="left"> 
								<input  id="investProductCode" class="nui-textbox" inputStyle="background-color:#f0f0f0;" name="enExistLimite" readonly="readonly" width="80%"/>
							</td>
							<td align="right">
				                        付息频率:
							</td>
							<td  align="left">
								<input class="nui-dictcombobox" id="vcFrequency" inputStyle="background-color:#f0f0f0;"  dictTypeId="ATS_CF_JY_FREQUENCY" name="vcFrequency" readonly="readonly" width="80%"/>
							</td>
							<td align="right">
				                        票面利率(%):
							</td>
							<td align="left">
								<input class="nui-textbox"  name="enCouponRate" inputStyle="background-color:#f0f0f0;" readonly="readonly" width="80%"/>
							</td>
							<td align="right">
				                        利率类型:
							</td>
							<td align="left">
								<input class="nui-dictcombobox" dictTypeId="rateType" inputStyle="background-color:#f0f0f0;" name="cInterestType" readonly="readonly" width="80%"/>
							</td>
						</tr>
						<tr>
							<td align="right">
				                        是否具有回售权:
							</td>
							<td align="left">
								<input class="nui-dictcombobox" inputStyle="background-color:#f0f0f0;" dictTypeId="COF_YESORNO" id="cIsHaveSaleback" 
									name="cIsHaveSaleback" readonly="readonly" width="80%"/>
							</td>
							<td align="right">
				                        债券评级:
							</td>
							<td align="left">
								<input class="nui-dictcombobox" inputStyle="background-color:#f0f0f0;" dictTypeId="creditRating" name="cBondAppraise" id="cBondAppraise" readonly="readonly" width="80%"/>
							</td>
							<td align="right">
				                        主体评级:
							</td>
							<td align="left">
								<input class="nui-dictcombobox" inputStyle="background-color:#f0f0f0;" dictTypeId="issuerRating" name="cIssueAppraise" readonly="readonly" width="80%"/>
							</td>
							<td align="right">
				                        发行公告日:
							</td>
							<td align="left">
								<input class="nui-datepicker" id="lIssuePostDate"  name="lIssuePostDate" inputStyle="background-color:#f0f0f0;" readonly="readonly" width="80%"/>
							</td>
						</tr>
						<tr>
							<td align="right">
				                        发行主体:
							</td>
							<td align="left" colspan="1"> 
								<input class="nui-textbox"  id="vcIssuerName"  name="vcIssuerName" inputStyle="background-color:#f0f0f0;" readonly="readonly" width="80%"/>
							</td>
						</tr>
					</table>
				  </div>	
	            </div>
	            <!-- 传真信息 -->
				<div title="传真信息">
				</div>
            	<!-- fix指令/建议信息 -->
				<div title="fix指令/建议">
					
					
				</div>
            	<!-- 邮件发送信息 -->
				<div title="邮件发送信息">
					
					
				</div>
		</div>
	  </div>	
	</div>	
</div>


			
		 <!--隐藏表单-->
		<form action="" name="openForm" method="post" target="_blank">
		  <input type="hidden" name="workItemID" id="workItemID">
		  <input type="hidden" name="processInstID" id="processInstID">
		  <input type="hidden" name="bizId" id="bizId1">
		  <input type="hidden" name="pageType" id="pageType" value="1"/>
		</form>
		 <!--隐藏表单-->
	 <!-- 新债信息表下载  -->
		<form id="word_download" method="post">
			<!-- 数据实体的名称 -->
			<input class="nui-hidden" name="bizId"  id="bizId2"/>
			<!-- 下载方式：1是投资指令/建议管理里下载，否则为审批页面下载 -->
			<input class="nui-hidden" name="type"  id="type" value="1"/>
			<!-- 债券类别 -->
			<input class="nui-hidden" name="vcStockType"  id="vcStockType2"/>
		</form>
		
		
		
		<div id="buttons">
	 <table>
	  <tr>
	  <td><span class="separator"></span> </td>
	  
      <td><div  style="width: 15px;height: 15px;border:2px solid #49a9ee;background-color:#FFFFFF" ></div></td>
	  <td><span >投顾复核</span>&nbsp;&nbsp; </td>
	  
	  <td><div style="width: 15px;height: 15px;border:2px solid #49a9ee;background-color:#FFFF66" ></div></td>
	  <td><span >交易员1</span>&nbsp;&nbsp;</td>
	  
	  <td><div style="width: 15px;height: 15px;border:2px solid #49a9ee;background-color:#9ed0ef" ></div></td>
	  <td><span >交易员2</span>&nbsp;&nbsp;</td>
	  
	  <td><div style="width: 15px;height: 15px;border:2px solid #49a9ee;background-color:#FEC7DE" ></div></td>
	  <td><span >投标用印</span>&nbsp;&nbsp;</td>
	  
	  
	  <td><div style="width: 15px;height: 15px;border:2px solid #49a9ee;background-color:#79FF79" ></div></td>
	  <td><span >投标执行</span>&nbsp;&nbsp;</td>
	  
	  
	  <td><div style="width: 15px;height: 15px;border:2px solid #49a9ee;background-color:#8E8E8E" ></div></td>
	  <td><span >传真/签收情况成功</span>&nbsp;&nbsp;</td>
	  
	  
	   <td><div style="width: 15px;height: 15px;border:2px solid #49a9ee;background-color:#FF0000" ></div></td>
	  <td><span >改标位</span></td>
	 
	 
	  
	 </tr>
     </table>
   </div> 

	
	
	
	<script type="text/javascript">
    	nui.parse(); 
    	var grid = nui.get("datagrid1");
		var msg;
			
		//给业务日期查询条件赋值
		nui.get("dBidLimitTime").setValue(DateUtil.toNumStr(new Date()));
	
        var formData = new nui.Form("#form1").getData(false,false);
        grid.load(formData);
    	$("#dataform1 .mini-buttonedit-buttons").remove();
		$("#dataform1 .mini-buttonedit-border").css("background-color","#f0f0f0");
    	//重新刷新页面
        function refresh(){
           var form = new  nui.Form("#form1");
           var json = form.getData(false,false);
           grid.load(json);//grid查询
           nui.get("update").enable();
        }
		//渲染行对象
	 	grid.on("drawcell", function (e) {
	        var record = e.record,
	        column = e.column,
        	row=e.row;
        	if (column.name == "action") {
	        	e.cellStyle = "text-align:center";
	        	if(row.activityDefID=="ATS_FM_CZ_ZBQR"){
	        		//打开中标确认按钮事件
	        		e.cellHtml="<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='payOrder(\"" + grid.indexOf(row) + "\")'>中标确认</a>&nbsp;";
	        	}else if(row.activityDefID=="ATS_FM_TGFH" || row.activityDefID=="ATS_FM_WTRFH"){
	        		//复核，打开复核界面
	        	    e.cellHtml="<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='approval(\"" + grid.indexOf(row) + "\")'>复核</a>&nbsp;";
	        	}else{
	        		//复核，打开复核界面
	        	    e.cellHtml="<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='approval(\"" + grid.indexOf(row) + "\")'>审批</a>&nbsp;";
	        	}
        	}
        	//设置行样式
	        if (record.gender == 1) {
	            e.rowCls = "myrow";
	        }
        	
        	});
        	function checkUserId(processInstID){
        		var bl=false;
        		nui.ajax({
						url:"com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.checkWorkItemActor.biz.ext",
						type:'POST',
						data:{processInstID:processInstID},
						cache:false,
						async:false,
						contentType:'text/json',
						success:function(text){
							
							if(text.ret=="1"){
								bl = true;
							}else{
								bl = false;
							}
						}
					});
					return bl;
        	}
        	//审批处理
           function approval(index){
           		//注意index 必须转换为 整型，否则默认为字符型，getRow方法必须传入整型
           		var row = grid.getRow(parseInt(index));
           		
				if(row){
					var processInstID=row.lProcessInstId;
					var bizId=row.lBizId;
					var activityDefID="";
					var currentState=row.currentState;
					var vcProcessType=row.vcProcessType;
					var userId='<%=userId %>';  //数字ID
					//验证操作许可
					//if(applyUpdate(row.vcUserId,row.activityDefID)==false){return;}
					
					if(checkUserId(processInstID)==false){
						nui.alert("您不是当前指令/建议的参与者，不能进行审批！");
						return;
					}
		            if(currentState==7){
						nui.alert("该流程已经结束，不能下达缴款指令/建议！");
						return;
					}
					if(currentState==8){
						nui.alert("该流程已被挂起，不能下达缴款指令/建议！");
						return;
					}
					var workItemID=row.workItemID;
					//异常时不存在该属性
					try{
						activityDefID= row.activityDefID;
					}catch(e){
						nui.alert("网络错误！");
						return;
					}
					var actionUrl="";
					if(vcProcessType=="8"){
						//缴款流程
						actionUrl = "/com.cjhxfund.ats.fm.instr.FirstGradePayment.flow";
					}else{
						//默认申购流程
						actionUrl = "/com.cjhxfund.ats.fm.instr.FirstGradeBond.flow";
					}
					//打开待办
					wfOpenWin(actionUrl,processInstID,workItemID,bizId);
					
				}else{
					nui.alert("请选择一条指令/建议。","提示");
				}
           }
           //查询
           function search() {
           
           	  var processDate_stop = nui.get("processDate_stop").getValue();
           	  var processDate = nui.get("processDate").getValue();
           	  //注意 new date(); IE8以下 不兼容，必须将 “-” 转换  “/”
			  var startTime1=Date.parse(new Date(processDate_stop.replace(/-/g,"/")));
			  var startTime2=Date.parse(new Date(processDate.replace(/-/g,"/")));
           	  if(startTime2>startTime1){
           	  		nui.alert("开始时间不能大于结束时间！");
           	  		return;
           	  }
           	  
           	  /* var currentstate = nui.get("currentstate").getValue();
           	  if(currentstate == 8){
           	  	nui.get("currentstate").setValue("7,8");
           	  }else if(currentstate == "2,8"){
           	    nui.get("currentstate").setValue("2,7,8,3");
           	  }else if(currentstate == "2"){
           	    nui.get("currentstate").setValue("2,3");
           	  } */
           	  var vcStockName = nui.get("vcStockName").value;
              nui.get("vcStockNameFull").setValue(vcStockName);
              var form = new nui.Form("#form1");
              var json = form.getData(false,false);
              grid.load(json);//grid查询
            }

            //重置查询条件
            function reset(){
               var form = new nui.Form("#form1");//将普通form转为nui的form
               form.reset();
               //清空对象
               nui.get("datagrid10").clearRows();
            }
            
             //当选择列时
		     function selectionChanged(){
		        var rows = grid.getSelecteds();
		        nui.get("riskProcess").disable();
		        if(rows.length>1){
		               nui.get("revisedOffer").disable();
		               nui.get("revokeOffer").disable();
		               nui.get("addAll").disable();
		               nui.get("flowChart").disable();
		               nui.get("inputpaymentfile").disable();
		               nui.get("updateHandleBid").disable();
		        }else{
		        	   nui.get("revisedOffer").enable();
		               nui.get("revokeOffer").enable();
		               nui.get("addAll").enable();
		               nui.get("flowChart").enable();
		               nui.get("inputpaymentfile").enable();
		               nui.get("updateHandleBid").enable();
		               riskProcessBtnControlByApplyStockInfo(rows[0]);
		        }
		    } 

            //enter键触发查询
            function onKeyEnter(e) {
                search();
            }
            
             //主体类型
             function renderVcIssueProperty(e){
               return nui.getDictText("ATS_FM_ISSUE_PROPERTY",e.row.vcIssueProperty);
             }
             //主体评级
             function renderCIssueAppraise(e){
               return nui.getDictText("issuerRating",e.row.cIssueAppraise);
             }   

             function ButtonClickGetFundName_ZJTC(e){
			   	ButtonClickGetFundName(this,'<%=request.getParameter("jurisdiction")%>');
			 }
			 function rendererBizTypeName(e){
			 	if(e.row.vcProcessType=="1" || e.row.vcProcessType=="5"){
			 		return "申购流程";
			 	}else if(e.row.vcProcessType=="8"){
			 		return "缴款流程";
			 	}
			 }
			//fix状态
			function renderlFixValidStatus(e){
				if(e.row.lFixValidStatus == 0){
					return "未发送";
				}else if(e.row.lFixValidStatus == 1){
					return "修改后未发送";
				}else if(e.row.lFixValidStatus == 2){
					return "发送中";
				}else if(e.row.lFixValidStatus == 3){
					return "发送成功";
				}else if(e.row.lFixValidStatus == 4){
					return "发送失败";
				}
			}
			
			// 申购授权状态
			function renderApplyAuthStatus(e){
				if(e.row.cApplyAuthStatus == 0){
					return "正式授权申购";
				}else if(e.row.cApplyAuthStatus == 1){
					return "非正式授权申购";
				}
			}
			
			// 缴款授权状态
			function renderPaymentAuthStatus(e){
				if(e.row.cPaymentAuthStatus == 2){
					return "正式授权缴款";
				}else if(e.row.cPaymentAuthStatus == 3){
					return "非正式授权缴款";
				}
			}
			
			//渲染行对象
	grid.on("drawcell", function (e) {
		column = e.column,
		row=e.row;

		//action列，超连接操作按钮
		if (column.name == "dPaymentDate") {
			if(row.dPaymentDate == 0){
				e.cellHtml ="";
			}
			
		}
	});
			
	//修改报价
	function revisedOffer(){
		var row = grid.getSelected();
		if(row){
			//获取参数
			var processInstID=row.lProcessInstId;
			var bizId=row.lBizId;
			var activityDefID="";
			var currentState=row.currentState;
			var cReportUpdateStatus=row.cReportUpdateStatus;
			var vcProcessType=row.vcProcessType;
			
			if(currentState==7){
				nui.alert("该流程已经结束，无法修改！","系统提示");
				return;
			}
            	    
			if(currentState == 8){
				nui.alert("该指令/建议流程状态已被挂起,不能修改报价。","系统提示");
				return;
			}
            	    
			//异常时不存在该属性
			try{
				activityDefID= row.activityDefID;
			}catch(e){
				nui.alert("网络错误！");
				return;
			}
			if(activityDefID=="ATS_FM_TGLR"){
				nui.alert("录入环节不允许操作！");
				return;
			}
			if(vcProcessType=="1" || vcProcessType=="5"){
				//验证流程节点
				if(activityDefID.indexOf("ATS_FM_CZ")==-1 || activityDefID=="ATS_FM_CZ_TBZX"){
	            	    
					nui.open({
						url: "<%=request.getContextPath() %>/fm/instr/firstGradeDebt/updateReport.jsp",
						title: "修改报价", width: 750, height: 650,
						onload: function () {
							//弹出页面加载完成
							var iframe = this.getIFrameEl();
							var data = {pageType:"add",processInstID:processInstID,bizId:bizId};//传入页面的json数据
										iframe.contentWindow.setFormData(data);
						},
						ondestroy: function (action) {//弹出页面关闭前
							//刷新页面
							grid.reload();
						}
					});
	            	   
				}else if(activityDefID=="ATS_FM_CZ_ZBQR" && cReportUpdateStatus=="1"){
					nui.open({
						url: "<%=request.getContextPath() %>/fm/instr/firstGradeDebt/updateReportBidConfirm.jsp",
						title: "中标确认修改报价", width: 750, height: 560,
						onload: function () {
							//弹出页面加载完成
							var iframe = this.getIFrameEl();
							var data = {pageType:"add",processInstID:processInstID,bizId:bizId};//传入页面的json数据
					                    iframe.contentWindow.setFormData(data);
						},
						ondestroy: function (action) {//弹出页面关闭前
							//刷新页面
							grid.reload();
						}
					});
				}else{
					nui.alert("已传真过，不允许修改！");
				}
			}else if(vcProcessType=="8"){
				nui.open({
						url: "<%=request.getContextPath() %>/fm/instr/firstGradePayment/updatePaymentReport.jsp",
						title: "缴款流程修改报价", width: 770, height: 520,
						onload: function () {
							//弹出页面加载完成
							var iframe = this.getIFrameEl();
							var data = {pageType:"add",processInstID:processInstID,bizId:bizId};//传入页面的json数据
					                    iframe.contentWindow.setFormData(data);
						},
						ondestroy: function (action) {//弹出页面关闭前
							//刷新页面
							grid.reload();
						}
					});
			}
		}else{
			nui.alert("请选择一条指令/建议。","提示");
		}
	}
			
	//撤销报价
	function revokeOffer(){
		var row = grid.getSelected();
				
		if(row){
			var processInstID=row.lProcessInstId;
			var bizId=row.lBizId;
			var activityDefID=row.activityDefID;
			var vcProcessType=row.vcProcessType;
			
			nui.confirm("是否确认要撤销报价？","系统提示",function (a){
				if(a!="ok"){ return; }
	                if(vcProcessType=="1" || vcProcessType=="5"){
						var activity=["ATS_FM_CZ_TBZX","ATS_FM_CZ_ZBQR","ATS_FM_CZ_ZBFH","ATS_FM_CZ_XYFH1","ATS_FM_CZ_XYFH2",
						              "ATS_FM_CZ_XYYY1","ATS_FM_CZ_XYYY2","ATS_FM_CZ_SCXY","ATS_FM_CZ_ZJQS","ATS_FM_CZ_SFFXYYY","ATS_FM_CZ_JYYFH2","ATS_FM_CZ_FXYYY"];
						for(var i=0;i<activity.length;i++ ){
						  if(activityDefID==activity[i]){
						     nui.alert("投标已执行，无法撤销报价！");
							 return;
						  }
						}
					}else if(vcProcessType=="8"){
						var activity=["ATS_FM_XYYYPD","ATS_FM_XYYY2","ATS_FM_XYYY1","ATS_FM_SCSFYYXY","ATS_FM_ZJQS",
						              "ATS_FM_PDFXYYY","ATS_FM_FXYYYFH","ATS_FM_FXYYY"];
						for(var i=0;i<activity.length;i++ ){
						  if(activityDefID==activity[i]){
						     nui.alert("投标已执行，无法撤销报价！");
							 return;
						  }
						}
					}
				var currentState=row.currentState;
				if(currentState==7){
					nui.alert("该流程已经结束，不能撤销！");
					return;
				}
				if(processInstID=="" || processInstID==null || bizId=="" || bizId==null){
					nui.alert("网络错误，请刷新！");
					return;
				}
				if(currentState == 8){
					nui.alert("该指令/建议流程状态已被挂起,不能撤销。","系统提示");
					return;
				}
				//取消申购
				var data = {processInstID:processInstID,bizId:bizId};
				var json = nui.encode(data);
				var form = new nui.Form("#dataform1");//将普通form转为nui的form
					form.loading();//加载遮罩
				$.ajax({
					url:"com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.colseApplyInfo.biz.ext",
					type:'POST',
					data:json,
					cache:false,
					contentType:'text/json',
					success:function(text){
						form.unmask();//取消遮罩
						if(text.out==1){
							nui.alert("撤销成功！");
						}else if(text.out==2){
							nui.alert("中标后不能撤销报价！");
						}else if(text.out == 3){
							nui.alert("当前流程正在审批中，请耐心等待！");
						}else{
							nui.alert("网络错误，刷新后重试！");
						}
						//刷新
						grid.reload();
					}
				});	
			});
		}else{
			nui.alert("请选择一条指令/建议。","提示");
		}
	}
			
	//下达缴款指令/建议
	function payOrder(){
		var row = grid.getSelected();
		if(row){
			var processInstID=row.lProcessInstId;
			var bizId=row.lBizId;
			var activityDefID="";
			var currentState=row.currentState;
			var vcProcessType=row.vcProcessType;
			if(vcProcessType=="8"){
				nui.alert("缴款流程不需要下达缴款指令/建议！");
				return;
			}
			//验证操作许可
			//if(applyUpdate(row.vcUserId,row.activityDefID)==false){return;}
			if(checkUserRole(processInstID,row.vcProductCode)==false){
				return;
			}
            if(currentState==7){
				nui.alert("该流程已经结束，不能下达缴款指令/建议！");
				return;
			}
			if(currentState==8){
				nui.alert("该流程已被挂起，不能下达缴款指令/建议！");
				return;
			}
			var workItemID=row.workItemID;
			//异常时不存在该属性
			try{
				activityDefID= row.activityDefID;
			}catch(e){
				nui.alert("网络错误！");
				return;
			}
			var actionUrl = "/com.cjhxfund.ats.fm.instr.FirstGradeBond.flow";
			//验证流程节点
			if(activityDefID=="ATS_FM_CZ_ZBQR"){
				wfOpenWin(actionUrl,processInstID,workItemID,bizId);
			}else{
				nui.alert("当前不是中标环节，不能中标确认！");
			}
		}else{
			nui.alert("请选择一条指令/建议。","提示");
		}
	}
	var contextPath = "<%=request.getContextPath() %>";
	function wfOpenWin(url,processInstID,workItemID,bizId) {
		var winFrm=document.openForm;
		document.getElementById("processInstID").value=processInstID;
		document.getElementById("workItemID").value=workItemID;
		document.getElementById("bizId1").value=bizId;
		var actionURL=contextPath+"/"+url; //目标页面
		winFrm.action=actionURL;
				
		var newwin = window.open('about:blank', 'newWindow' + bizId, '');
		winFrm.target = 'newWindow' + bizId;//这一句是关键
		winFrm.submit();
	}
	//行双击时重新设置tabs页面参数
	grid.on("rowclick", function (e) {			
		var form = new nui.Form("#dataform1");//将普通form转为nui的form
				
		nui.get("bizId").setValue(e.row.lBizId);
		var from_Amount = new nui.Form("#datagrid_Amount");//将普通form转为nui的form
		var json_Amount = from_Amount.getData(false,false);
				
		//加载报量信息
		var datagrid10 = nui.get("datagrid10");
			datagrid10.load(json_Amount);
				
		//加载债券详细信息
		e.row.lBegincalDate=dateTemp(e.row.lBegincalDate);
		e.row.lEndincalDate=dateTemp(e.row.lEndincalDate);
		e.row.lIssuePostDate=dateTemp(e.row.lIssuePostDate);
					
		form.setData(e.row);
		var tabs = nui.get("tabs");  //获取tab对象
				
		//获取激活的tab标签的标题
		var faxlTab = nui.get("tabs").getTab(2);
		//加载附件列表
		var url="<%=request.getContextPath() %>/fm/instr/firstGradeDebt/eastFaxList.jsp?bizId="+e.row.lBizId+"&processinstid="+e.row.lProcessInstId+"&type=2";
				
		//获取激活的tab标签的标题
		var fixlTab = nui.get("tabs").getTab(3);
		//加载列表
		var fixurl="<%=request.getContextPath() %>/fm/instr/firstGradeDebt/eastFixapplyInstList.jsp?bizId="+e.row.lBizId+"&processinstid="+e.row.lProcessInstId+"&type=2";
				
		//加载发送邮件列表
		var mailTab = nui.get("tabs").getTab(4);
		var MailUrl = "<%=request.getContextPath() %>/fm/comm/SendMailInfoList.jsp?bizId="+e.row.lBizId+"&processinstid="+e.row.lProcessInstId;
		//tabs 加载顺序为 最后一个生效
		if(tabs.getActiveTab().title.indexOf("报量信息") != -1){
			tabs.loadTab(url , faxlTab);
			tabs.loadTab(MailUrl , mailTab);
			tabs.loadTab(fixurl , fixlTab);
		}else if(tabs.getActiveTab().title.indexOf("传真信息") != -1){
			tabs.loadTab(MailUrl , mailTab);
			//加载fixtab
			tabs.loadTab(fixurl , fixlTab);
			tabs.loadTab(url , faxlTab);
		}else if(tabs.getActiveTab().title.indexOf("fix指令/建议") != -1){
			//加载其他
			tabs.loadTab(MailUrl , mailTab);
			tabs.loadTab(url , faxlTab);
			//加载fixtab
			tabs.loadTab(fixurl , fixlTab);
		}else if(tabs.getActiveTab().title.indexOf("邮件发送信息") != -1){
			tabs.loadTab(url , faxlTab);
			//加载fixtab
			tabs.loadTab(fixurl , fixlTab);
			tabs.loadTab(MailUrl , mailTab);
		}
	});
            
	//时间转换
	function dateTemp(oldData){
		oldData=oldData+"";
		if(oldData==0 || oldData=="" || oldData=="null"){
			return "";
		}
	    		
		var datas=oldData.indexOf("-");
		if(datas>=0){
			return oldData;
		}
		var yy=oldData.substr(0,4);//0开始，截取后面4位
		var mm=oldData.substr(4,2);//4开始，截取后面2位
		var dd=oldData.substr(6,2);
	    		
		return yy+"-"+mm+"-"+dd;
	}
            
            function onDeptChanged(e) {
	            var cMarketNo=e.value;
		        //转换托管机构为交易市场
		        if(cMarketNo==3){
		        	cMarketNo=1;
		        }else if(cMarketNo==4){
		        	cMarketNo=2;
		        }else{
		        	cMarketNo=5;
		        }
				var cStockType = nui.get("cStockType");
	            cStockType.setValue("");
	            if(cMarketNo != ""){
	            	cStockType.enable();
		            var url = "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext?cMarketNo=" + cMarketNo;
		            cStockType.setUrl(url);
		            cStockType.select(0);
		        }else{
		        	cStockType.disable();
		        }    
        	}
        	
        	function onMarketBlur(e){
		   		
		   		if(e.source.value==null || e.source.value==""){
		   			//清空债券类型
		   			var vcStockType = mini.get("cStockType");
			        vcStockType.setValue("");
		            var url = "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext?type=1";
		            vcStockType.setUrl(url);
		   		}
		   		
		   }
		   
		   function onvcPaymentPlace(e){
	  			return nui.getDictText("CF_JY_DJTGCS",e.row.vcPaymentPlace);;
			}
			
			//展示详细行数据
		function onShowRowDetailList(e) {
			var grid = e.sender;//获取表格
		    var row = e.record;//获取行数据
		    var remark = changeNull(row.vcRemarks);//备注信息 
		    var ProcessInstId = row.lProcessInstId;
		    //判断待办中传过来的流程ID是否为空
		    if(ProcessInstId == undefined){
		    	ProcessInstId = row.L_PROCESS_INST_ID;
	    }

	    //获取债券信息
	    var processIdJson = nui.encode({processInstId : ProcessInstId,workItemID:row.workItemID});
	    $.ajax({
            url:"com.cjhxfund.foundation.task.pendingTreatment.queryTAtsApproveInfo.biz.ext",
            type:'POST',
            data:processIdJson,
            cache: false,
            contentType:'text/json',
            success:function(text){
                var returnJson = nui.decode(text);
                if(returnJson.exception == null){
                    var bonds = returnJson.TAsApproveInfos;
                    var html = "<table border='0'  style='width:100%;'>";
					 
					/*if(abandonedReasons!=null && abandonedReasons!=""){
						html +=" <tr>"
							 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>废弃原因：</td>"
							 + "  <td>" + abandonedReasons + "</td>"
							 + " </tr>";
					} */
					if(remark!=null && remark!=""){
						html +=" <tr>"
							 + "  <td style='width:150px;font-weight:bold;vertical-align:top;' align='right'>备注信息：</td>"
							 + "  <td>" + remark + "</td>"
							 + " </tr>";
					}
					if(returnJson.nextActor!=null && returnJson.nextActor!=""){
						html +=" <tr>"
							 + "  <td style='width:150px;font-weight:bold;vertical-align:top;' align='right'>当前节点参与者：</td>"
							 + "  <td>" + returnJson.nextActor + "</td>"
							 + " </tr>";
					}
					html += "</table>";
                    
					var bondStr = html + "</table>";
					    bondStr += "<table>"
                    			+" <tr>"
                    			+"  <td style='width:150px;font-weight:bold;' align='center'>审批时间</td>"
                    			+"  <td style='width:220px;font-weight:bold;' align='center'>节点名称</td>"
                    			+"  <td style='width:120px;font-weight:bold;' align='center'>操作者</td>"
                    			+"  <td style='width:120px;font-weight:bold;' align='center'>操作</td>"
                    			+"  <td style='width:200px;font-weight:bold;' align='center'>操作意见</td>"
                    			+" </tr>";
                    var vcOperateType = "同意";			
                    for(var i=0; i<bonds.length; i++){
                    	var bondInfo = bonds[i];
                    	  if(bondInfo.vcOperateType == 1){
                    		  vcOperateType = "同意";
					      }
					      if(bondInfo.vcOperateType == 2){
					    	  vcOperateType = "退办";
					      }
					      if(bondInfo.vcOperateType == 3){
					    	  vcOperateType = "转办";
					      }
					      if(bondInfo.vcOperateType == 4){
					    	  vcOperateType = "征求意见";
					      }
					      if(bondInfo.vcOperateType == 5){
					    	  vcOperateType = "否决";
					      }
					      if(bondInfo.vcOperateType == 99){
					    	  vcOperateType = "不同意";
					      }
					      
					      if(bondInfo.vcOperateType == 98){
					    	  vcOperateType = "修改";
					      }
					      if(bondInfo.vcOperateType == 97){
					    	  vcOperateType = "废弃";
					      }
					      
                    	bondStr += "<tr><td align='center'>"+ nui.formatDate(bondInfo.dCreateTime, "yyyy-MM-dd HH:mm:ss")+"</td><td align='center'>"+changeNull(bondInfo.vcWorkItemName)+"</td><td align='center'>"+changeNull(bondInfo.vcUserName)
                    			+	"</td><td align='center'>"+changeNull(vcOperateType)+"</td><td align='center'>"+changeNull(bondInfo.vcComments)+"</td></tr>";
                    }
                    bondStr += "</table>";
                    
                    var td = grid.getRowDetailCellEl(row);

					td.innerHTML = bondStr;
                    
                }else{
					nui.alert("加载失败", "系统提示");
                }
            }
         });
	}
	//查看流程图 --所有业务通用
    function flowChart(){
        var rows = grid.getSelected();
        if(rows != null){
  			//process/processGraph.jsp
        	window.open("<%=request.getContextPath() %>/com.cjhxfund.foundation.task.ProcessChart.flow?processInstID="+rows.lProcessInstId);
        }else{
            nui.alert("请先选择指令/建议.","系统提示");
        }
    }
    
    //下单
    function placeOrder(){
        var datagrid = nui.get("datagrid1");        //获取列表对象
        var rows =  datagrid.getSelecteds();   
        if(rows.length >= 2){
        	nui.alert("请选择一条记录。");
        	return;
        }
        
        if(rows.length == 0){
           nui.alert("请先选择指令/建议。","系统提示");
           return;
        }
        
        if(rows[0].currentState==7){
    	    nui.alert("该流程已经结束，不能下单！");
    	    return;
    	}
    	
    	if(rows[0].currentState==8){
    	    nui.alert("该流程已被挂起，不能下单！");
    	    return;
    	}
    	
        var vcProcessType=rows[0].vcProcessType;
        var activityDefID=rows[0].activityDefID;
        
        //校验数据
        if(checkWorkItem(activityDefID,vcProcessType,1)==false){
        	return;
        }
		//判定当天是否为缴款日期
        var myDate = new Date().format('yyyy-MM-dd');//获取当前日期
        //注意 new date(); IE8以下 不兼容，必须将 “-” 转换  “/”
    	var date1=rows[0].dPaymentDate;//获取缴款日
    	if(date1=="" || date1==null){
    		nui.alert("该债券的缴款日为空，请完善，否则不能推送到O32!");
    		return;
    	}
		var milliseconds = new Date(Date.parse(date1.replace(/-/g, "/"))).format('yyyy-MM-dd');
		
		
    	if(myDate!=milliseconds){
    		nui.alert("当前日期不是该债券的缴款日，不能推送到O32!");
    		return;
    	}
        var lInvestNo = rows[0].lInvestNo;
        var lBizId = rows[0].lBizId;
		var json = nui.encode({lInvestNo:lInvestNo,lBizId:lBizId,processInstID:rows[0].lProcessInstId});
		
		//查询当前Fix指令/建议状态
		$.ajax({
			url:"com.cjhxfund.ats.fm.instr.FirstGradeBond.getFixState.biz.ext",
			type:'POST',
			data:json,
			cache:false,
			contentType:'text/json',
			success:function(text){
			
				if(text.workItems==null || text.workItems==""){
					nui.alert("工作项不可用，请刷新界面");
					return;
				}else{
					var workItems=text.workItems;
			        activityDefID=workItems[0].activityDefID;
					 //校验数据
				     if(checkWorkItem(activityDefID,vcProcessType,1)==false){
				     	return;
				     }
				}
				
				if(text.applyInst.lFixValidStatus == 3){
					nui.confirm("Fix指令/建议下达成功，是否继续下达修改指令/建议?","系统提示",function(action){
						if(action == "ok"){
					      saveDate(rows[0].workItemID,rows[0].lApplyInstId);
					    }
					});
				}else if(text.applyInst.lFixValidStatus == 2){
					nui.confirm("Fix指令/建议下达未拿到反馈信息，是否继续下达指令/建议?","系统提示",function(action){
						if(action == "ok"){
					      saveDate(rows[0].workItemID,rows[0].lApplyInstId);
					    }
					});
				}else{
					saveDate(rows[0].workItemID,rows[0].lApplyInstId);
				}
			}
		});		    	
    }
    
    function saveDate(workItemID,lApplyInstId){
    	var data = {
			workItemID:workItemID,
			lApplyInstId:lApplyInstId
		};
		msg = commonLoading("正在下单至O32。","系统提示");
		var json = nui.encode(data);
		$.ajax({
			url:"com.cjhxfund.ats.fm.instr.FirstGradeBond.sendFix.biz.ext",
			type:'POST',
			data:json,
			cache:false,
			contentType:'text/json',
			success:function(text){
				var returnJson = nui.decode(text);
				commonHideMessageBox(msg);
				if(returnJson.isSuccess == "4"){
					nui.alert(returnJson.failReason == null ? returnJson.text : returnJson.failReason,"系统提示",function(){});
				}else if(returnJson.isSuccess == "2"){
					nui.alert("未获取到fix指令/建议状态返回。","系统提示");
				}else if(returnJson.isSuccess == "5"){
					nui.alert("发送Fix指令/建议异常，请联系管理员。","系统提示");
					return;
				}else if(returnJson.isSuccess == "3"){
					nui.alert("发送Fix指令/建议成功.","系统提示");
					return;
				}
			}
		});
    }
    //发送邮件
	function sendMail(){
		var row = grid.getSelected();
    	if(row){
    		//获取参数
    		var processInstID=row.lProcessInstId;
    	    var bizId=row.lBizId;
    	    var workItemID=row.workItemID;
    	    var activityDefID="";
    	    var currentState=row.currentState;
    	    var vcProcessType=row.vcProcessType;
    	    if(currentState==7){
    	    	nui.alert("该流程已经结束，不能发送邮件！");
    	    	return;
    	    }
    	    if(currentState==8){
    	    	nui.alert("该流程已被挂起，不能发送邮件！");
    	    	return;
    	    }
    	    //异常时不存在该属性
    	    try{
    	   		activityDefID= row.activityDefID;
    	    }catch(e){
    	    	nui.alert("网络错误！");
    	    	return;
    	    }
    	    if(activityDefID=="ATS_FM_TGLR"){
    	    	nui.alert("录入环节不允许操作！");
    	    	return;
    	    }
    	    
    	    //验证流程节点
		    if(checkWorkItem(activityDefID,vcProcessType,3)==false){
		    	return;
		    }
    		nui.open({
                    url: "<%=request.getContextPath() %>/fm/instr/firstGradeDebt/sendMail.jsp?processInstID="+processInstID+"&bizId="+bizId+"&workItemID="+workItemID,
                    title: "发送邮件", width: 750, height: 605,
                    onload: function () {
                        //弹出页面加载完成
	                    var iframe = this.getIFrameEl();
	                    var data = {pageType:"add",processInstID:processInstID,bizId:bizId};//传入页面的json数据
	                    iframe.contentWindow.setFormData(data);
                    },
                    ondestroy: function (action) {//弹出页面关闭前
                    //刷新页面
         			grid.reload();
                }
             });
    	   
            
    	}else{
    		nui.alert("请选择一条指令/建议。","提示");
    	}
	}
	/*
	*指令/建议操作权限
	*/
	function applyUpdate(vcUserId,activityDefID){
		
		var userId='<%=userId %>';
		if(userId=="" || userId==null || userId=="null"){
			nui.alert("未能获取到用户信息，请刷新界面或者重新登录！");
			return false;
		}
		
		if(userId!=vcUserId){
			if(activityDefID == "ATS_FM_CZ_ZBQR" && activityDefID != null){
				nui.alert("您不是当前指令/建议的参与者，不能进行中标确认。","系统提示");
				return false;
			}
			
		}
		return true;
	}
	
	/*
	*中标确认验证操作权限
	*/
	function checkUserRole(processInstID,vcProductCode){
		
		var userId_zbqr='<%=userId_zbqr %>';  //数字ID
		var userName='<%=userId %>';          //拼音ID
		var bool;
		if(userId_zbqr=="" || userId_zbqr==null || userId_zbqr=="null" || userName=="" || userName==null || userName=="null"){
			nui.alert("未能获取到用户信息，请刷新界面或者重新登录！");
			bool=false;
		}
		//获得当前参与者
		var json = nui.encode({processInstID:processInstID,userId:userName,vcProductCode:vcProductCode});
		$.ajax({
			url:"com.cjhxfund.ats.fm.instr.FirstGradeBond.getZBQRParticipantUserId.biz.ext",
			type:'POST',
			data:json,
			cache:false,
			async:false,
			contentType:'text/json',
			success:function(text){
				//console.log(text);
				//中标确认节点判断当前登录用户是否为当前节点参与者
		        if(text.participantId.indexOf(userId_zbqr) < 0){
		        	var row = grid.getSelected();
		           if(text.isInvestment==1 && text.isProduct>0){
			          //中标确认节点判断当前登录用户是否为投顾
			          nui.alert("投顾不能操作招行产品，不能中标确认！");
			          bool=false;
			          //纸质指令交易员可以做中标确认
			        }else if(text.isInvestment==0 && text.isProduct==0 && row.cApplyInstType != "1"){
			          nui.alert("交易员不能操作非招行产品，不能中标确认！");
			          bool=false;
			        }else{
			          nui.alert("当前登录用户不是当前节点参与者，不能中标确认！");
		          	  bool=false;
			        }
		        }else{
			       bool=true;
		        }
			}
		});
		return bool;
	}
    //发送传真
    function sendFax(){
    	var row = grid.getSelected();
    	if(row){
    		//获取参数
    		var processInstID=row.lProcessInstId;
    	    var bizId=row.lBizId;
    	    var workItemID=row.workItemID;
    	    var activityDefID="";
    	    var currentState=row.currentState;
    	    var vcProcessType=row.vcProcessType;
    	     
    	    if(currentState==7){
    	    	nui.alert("该流程已经结束，不能发送传真！");
    	    	return;
    	    }
    	    if(currentState==8){
    	    	nui.alert("该流程已被挂起，不能发送传真！");
    	    	return;
    	    }
    	   
    	    //异常时不存在该属性
    	    try{
    	   		activityDefID= row.activityDefID;
    	    }catch(e){
    	    	nui.alert("网络错误！");
    	    	return;
    	    }
    	    //console.log(activityDefID);
    	    if(activityDefID=="ATS_FM_TGLR"){
    	    	nui.alert("录入环节不允许操作！");
    	    	return;
    	    }
    	    //验证流程节点
		    if(checkWorkItem(activityDefID,vcProcessType,2)==false){
		    	return;
		    }
    	    
    		nui.open({
                    url: "<%=request.getContextPath() %>/fm/instr/firstGradeDebt/sendFax.jsp?processInstID="+processInstID+"&bizId="+bizId+"&workItemID="+workItemID,
                    title: "发送传真", width: 750, height: 605,
                    onload: function () {
                        //弹出页面加载完成
	                    var iframe = this.getIFrameEl();
	                    var data = {pageType:"add",processInstID:processInstID,bizId:bizId,workItemID:workItemID};//传入页面的json数据
	                    iframe.contentWindow.setFormData(data);
                    },
                    ondestroy: function (action) {//弹出页面关闭前
                    //刷新页面
         			grid.reload();
                }
             });
           
    	}else{
    		nui.alert("请选择一条指令/建议。","提示");
    	}
    }
    /*
    *校验工作项状态
    *activityDefID 工作项
    *vcProcessType 流程类型
    *checkType 校验种类
    */
    function checkWorkItem(activityDefID,vcProcessType,checkType){
    	
    	if(vcProcessType=="1" || vcProcessType=="5"){//申购流程，有无债券
    		//下单O32
    		if(checkType==1){
    			if(activityDefID.indexOf("CZ") != -1){
		        	//判断选择记录的环节为投标执行或者中标确认，提示不能进行下单
		        	if(activityDefID == "ATS_FM_CZ_TBZX" || activityDefID == "ATS_FM_CZ_ZBQR"){
		        		nui.alert("只有中标复核节点与中标复核节点之后才能下单。","系统提示");
		        		return false;
		        	}
		        }else{
		        	nui.alert("只有中标复核环节与中标复核节点之后的节点才能下单。","系统提示");
		        	return false;
		        }
    		}
    		//邮件、传真发送
    		if(checkType==2){
    			
				if(activityDefID.indexOf("ATS_FM_CZ") == -1){
					nui.alert("只有投标执行环节以及之后的环节才能发送传真。");
		        	return false;
				}
    		}
    		//邮件、传真发送
    		if(checkType==3){
    			if(activityDefID.indexOf("ATS_FM_CZ") == -1){
    				nui.alert("只有投标执行环节以及之后的环节才能发送邮件。");
    				return false;
    			}
    		}
    		return true;
    	}else if(vcProcessType=="8"){//缴款流程
    		
    		//下单O32
    		if(checkType==1){
    			//定义缴款流程 允许下单的节点
				var actStr="ATS_FM_XYYYPD,ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_SCSFYYXY,ATS_FM_ZJQS,";
				if(actStr.indexOf(activityDefID+",") == -1){
					nui.alert("当前节点不允许下单。","系统提示");
		        	return false;
				}
    		}
    		//邮件、传真发送
    		if(checkType==2){
    			var actStr="ATS_FM_XYYYPD,ATS_FM_XYYY1,ATS_FM_XYYY2,ATS_FM_SCSFYYXY,ATS_FM_ZJQS,ATS_FM_PDFXYYY,ATS_FM_FXYYYFH,ATS_FM_FXYYY,";
				if(actStr.indexOf(activityDefID+",") == -1){
					nui.alert("交易员1判定之前不允许邮件和传真。","系统提示");
		        	return false;
				}
    		}
    		return true;
    	}else{
    		nui.alert("数据异常，请刷新页面~");
    		return false;
    	}
    
    }
    
    function commonLoading(msg,title){
    	return nui.loading(msg,title);
    }

    function commonHideMessageBox(messageid){
    	 nui.hideMessageBox(messageid);
    }
    
    function reloadData(){
		grid.reload();
	}
		 //导出指令/建议
    function  exportApply(){
   		var frm = document.getElementById("queryForm");
   		var rows = grid.getSelecteds();
   		var ids = new Array();
        if (rows.length > 0) {
            for(var i=0;i<rows.length;i++){
            	ids.push(rows[i].lApplyInstId);
            }
            var data = ids.join(',');
             nui.get("excelData").setValue(data);
             nui.get("atcionType").setValue("check");
             nui.get("fileName").setValue("指令/建议信息.xls");
			frm.action = "com.cjhxfund.ats.fm.instr.applyInfoExport.flow";//com.cjhxfund.ats.fm.instr.applyInfoExport.flow
			frm.submit();
        } else {
            	//nui.alert("请选中一条指令!");
            nui.confirm("你确认要下载查询的全部指令数据吗？","系统提示",function(action){
            	if(action=="ok"){
		            nui.get("atcionType").setValue("all");
		            nui.get("fileName").setValue("指令信息.xls");
					frm.action = "com.cjhxfund.ats.fm.instr.applyInfoExport.flow";//com.cjhxfund.ats.fm.instr.applyInfoExport.flow
					frm.submit();
            	}
	            
            });
        }
   }
   //word文档下载
    function wordDownload1(){
       var row = grid.getSelected();
        if (row) {
	    	var bizId=row.lStockIssueId;
	    	var vcStockType=row.typeName;
	    	nui.get("bizId2").setValue(bizId);
	    	nui.get("vcStockType2").setValue(vcStockType);
	    	//下载附件
	    	nui.confirm("确认要下载吗？","系统提示",function(action){
				if(action=="ok"){
					var form = document.getElementById("word_download");
					form.action = "com.cjhxfund.ats.fm.baseinfo.wordDownload.flow";
			        form.submit();
				}
			});
		} else {
            nui.alert("请选中一条指令/建议!");
            return false;
        }
    }
   	Date.prototype.format = function (format) {
	     var date = {
	         "M+": this.getMonth() + 1,
	         "d+": this.getDate(),
	         "h+": this.getHours(),
	         "m+": this.getMinutes(),
	         "s+": this.getSeconds(),
	         "q+": Math.floor((this.getMonth() + 3) / 3),
	         "S+": this.getMilliseconds()
	     };
	     if (/(y+)/i.test(format)) {
	         format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
	     }
	     for (var k in date) {
	         if (new RegExp("(" + k + ")").test(format)) {
	             format = format.replace(RegExp.$1, RegExp.$1.length == 1
	                             ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
	        }
	     }
	     return format;
	}
	
     //导入授权文件
     function inputPaymentFile() {
     	var rows = grid.getSelecteds();
		if(rows.length==1){
			var lApplyInstId = rows[0].lApplyInstId;
			var workItemId = rows[0].workItemID;
			var lBizId = rows[0].lBizId;
			var lProcessInstId = rows[0].lProcessInstId;
			var instType = rows[0].cApplyInstType;
			var type="1"; //新债投标
			// 指令类型:1.纸质指令申购,2.主动投资申购,3.纸质指令缴款,4.主动投资缴款
			if(instType != "1" && instType != "3"){
				nui.alert("非纸质指令，不能上传正式授权文件","提示");
				return;
			}
			mini.open({
			    url:"<%=request.getContextPath() %>/fm/comm/authorizeFileUpload/fileUploadInput.jsp?lApplyInstId="+lApplyInstId+"&lBizId="+lBizId+"&workItemId="+workItemId+"&lProcessInstId="+lProcessInstId+"&type="+type,
			    title: "正式指令文件导入", width: 500, height: 200,
			    overflow:"hidden",
			    onload: function () {
			        
			    },
			    ondestroy: function (action) {
			        grid.reload();
			    }
			});
		}else{
			nui.alert("请选中一条指令/建议!");
		}
     }
     
     // 设置申购授权状态查询值
     function setApplyAuthStatus(){
     	var cApplyauthstatus = nui.get("ApplyAuthStatus").value;
     	var cPaymentauthstatus = "";
     	if(cApplyauthstatus.indexOf("0") > -1 || cApplyauthstatus.indexOf("1") > -1){
	     	if(cApplyauthstatus.indexOf("2") > 0){
	     		cPaymentauthstatus = cApplyauthstatus.substring(cApplyauthstatus.indexOf("2"),cApplyauthstatus.length); 
	     		cApplyauthstatus = cApplyauthstatus.substring(0,cApplyauthstatus.indexOf("2")-1); 
	     	}else if(cApplyauthstatus.indexOf("3") > 0){
	     		cPaymentauthstatus = cApplyauthstatus.substring(cApplyauthstatus.indexOf("3"),cApplyauthstatus.length); 
	     		cApplyauthstatus = cApplyauthstatus.substring(0,cApplyauthstatus.indexOf("3")-1); 
	     	}
	     	nui.get("cPaymentAuthStatus").setValue(cPaymentauthstatus);
	     	nui.get("cApplyAuthStatus").setValue(cApplyauthstatus);
     	}else{
     		nui.get("cPaymentAuthStatus").setValue(cApplyauthstatus);
     	}
     }
     function onCloseClickValueByAuthstatus(){
     	nui.get("ApplyAuthStatus").setValue("");
     	nui.get("cApplyAuthStatus").setValue("");
     	nui.get("cPaymentAuthStatus").setValue("");
     }
     
     function onlFaxStatus(e){
        if(e.row.cFaxStatus=="1"){
            e.rowStyle = 'background-color:#8E8E8E';//灰色
         } 
        return nui.getDictText("ATS_FAX_STATUS",e.row.cFaxStatus);
	 }
	  //行双击时弹出页面展示该指令/建议详细信息
	grid.on("rowdblclick", function (e) {
		 nui.open({
                    url:"<%=request.getContextPath() %>/fm/instr/firstGradeDebt/handleBidDetail.jsp",
                    title: "新债投标详情", 
                    width: 1000, 
           			height: 700,
                    //allowResize:false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var type="1";
                        var buttonHandleBid=nui.get("updateHandleBid");
                        var power="1";
                        if(buttonHandleBid==null || buttonHandleBid==undefined){
                           power="2";
                        }
                        iframe.contentWindow.initForm(type,e.row.lProcessInstId,e.row.lBizId,e.row.workItemID,power,null);
                    },
                    ondestroy: function (action) {
                        if(action=="saveSuccess"){
	                        grid.reload();
                   	 	}
                    }
                });
	});
	
	function updateHandleBid(){
	   var row = grid.getSelected();
        if (row) {
	       nui.open({
                    url:"<%=request.getContextPath() %>/fm/instr/firstGradeDebt/handleBidDetail.jsp",
                    title: "新债投标详情", 
                    width: 1000, 
           			height: 700,
                    //allowResize:false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var type="1";
                        iframe.contentWindow.initForm(type,row.lProcessInstId,row.lBizId,row.workItemID,"1",null);
                    },
                    ondestroy: function (action) {
                        if(action=="saveSuccess"){
	                        grid.reload();
                   	 	}
                    }
                });
         }else{
			nui.alert("请选中一条指令/建议!");
		}
	}

     //生成申购函
     function generatePurchaseOrder(){
     	//console.log("生成申购函");
     	var productCode = "";
     	var templateQueryParams = new Array();
     	var params = new Array();
     	var rows = grid.getSelecteds();
     	if(rows.length==0){
     		nui.alert("请先选择一条记录");
 			return;
     	}
     	for(var i=0;i<rows.length;i++){
     		var row = rows[i];
     		var map = {};
     		map['bizId']=row.lBizId;
     		map['workItemId']=row.workItemID;
     		map['processInstId']=row.lProcessInstId;
     		map['stockInvestNo']=row.lStockInvestNo;
     		params[i] = map;
     		var queryMap={};
     		queryMap['stockInvestNo'] = row.lStockInvestNo;
     		templateQueryParams[i] = queryMap;
     		//判断选中的记录是否属于同一个产品
     		var tempProductCode = row.vcProductCode;
     		if(productCode==""){
     			productCode = tempProductCode;
     		}
     		if(productCode!=tempProductCode){
     			nui.alert("所选记录不属于同一个产品。");
     			return;
     		}
		   	
     	}
     	var json = nui.encode({templateQueryParams:templateQueryParams});
     	//console.log("json = " + json);
     	$.ajax({
	            url:'com.cjhxfund.ats.fm.baseinfo.tatsstocktemplatebiz.queryTemplateFilePath.biz.ext',
	            type:'POST',
	            data:json,
	            cache:false,
	            contentType:'text/json',
	            success:function(data){
	             	var returnJson = nui.decode(data);
             		if(returnJson.templateFilePath=="erro"){
             			nui.alert("选中的债券对应多个申购函模板。");
             			return;
             		}
             		if(returnJson.templateFilePath==null||returnJson.templateFilePath=="null"){
             			nui.alert("选中的债券还没有配置对应的申购函模板。");
             			return;
             		}
         			var json1 = nui.encode({templateFilePath:returnJson.templateFilePath,productCode:productCode,params:params});
 					//console.log("json1 = "+json1);
				   	$.ajax({
			            url:'com.cjhxfund.ats.fm.baseinfo.purchaseOrderManager.generateOrder.biz.ext',
			            type:'POST',
			            data:json1,
			            cache:false,
			            contentType:'text/json',
			            success:function(data){
			            	var returnJson = nui.decode(data);
			            	if(returnJson.exception == null){
	                    		nui.alert("申购函生成成功");
	                        }else{
	                            nui.alert("申购函生成失败");
	                        }
			     		}
			     	});
	     		}
 			});
     }
     
     
     
     
     //绘制单元格时触发
		grid.on("drawcell",function(e){
		
		
	    	if(e.field=="workitemname"){
	    		
	    		if(e.value=="信息核对(交易员1)"){
	    		   	e.rowStyle = 'background-color:#FFFF66';//黄色
	    		}else  if(e.value=="信息核对(交易员2)"||e.value=="投资经理审批"||e.value=="总监助理审批"||e.value=="执行总监审批"||e.value=="分管领导审批"||e.value=="风控审核"){
	    		   e.rowStyle = 'background-color:#9ed0ef';//淡蓝色
	    		
	    		}else if(e.value=="投标用印"){
	    		  e.rowStyle = 'background-color:#FEC7DE';//粉色
	    		
	    		}else if(e.value=="投标执行"){
	    		  e.rowStyle = 'background-color:#79FF79';//绿色
	    		
	    		}

	    		
	    	}
	    	
	    });
	    
		
     
    </script>
</body>
</html>