<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/JY_ZQMM/JY_ZQMM_common.jsp" %>
<%@include file="/ProductProcess/JY_ZNHG/JY_ZNHG_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2015-10-09 11:42:39
- Description: 投资指令/建议确认
--%>
<head>
<title>投资指令/建议确认</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;" onload="onloadFun()">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
<div id="layout1" class="nui-layout" style="width:100%;height:100%;" borderStyle="border:solid 1px #aaa;">
    
    <div title="center" region="center"  >
    	<div class="nui-tabs" id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">
			<!-- 业务类型标签页开始... -->
			
			
			<div title="债券买卖">
			   <%-- 债券买卖查询条件开始... --%>
			   <div class="search-condition">
				   <div class="list">
					 <div id="form_ZQMM" class="nui-form" style="padding:2px;" align="center" style="height:10%">
						<!-- 数据实体的名称 -->
		                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryZhfwptJyZqmm4Confirm">
		                <!-- 获取01-债券买入、02-债券卖出类型；业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;99-其他指令/建议; -->
		                <input class="nui-hidden" name="criteria/_expr[1]/processType" value="01,02"/>
		                <input class="nui-hidden" name="criteria/_expr[1]/_op" value="in">
		                <!-- 排序字段 -->
		                <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="processDate">
		                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="desc">
		                <input class="nui-hidden" name="criteria/_orderby[2]/_property" value="investProductNum">
		                <input class="nui-hidden" name="criteria/_orderby[2]/_sort" value="desc">
		                <input class="nui-hidden" name="criteria/_orderby[3]/_property" value="validStatus">
		                <input class="nui-hidden" name="criteria/_orderby[3]/_sort" value="asc">
		                <input class="nui-hidden" name="criteria/_orderby[4]/_property" value="processStatus">
		                <input class="nui-hidden" name="criteria/_orderby[4]/_sort" value="asc">
		                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
		                	<tr>
		                        <td class="form_label" width="7%">
									业务日期:
		                        </td>
		                        <td colspan="1" width="13%">
		                            <input id="processDate_ZQMM" class="nui-datepicker" name="criteria/_expr[2]/processDate" width="100px"/>
		                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
		                        </td>
		                        <td class="form_label" width="7%">
									产品名称:
		                        </td>
		                        <td colspan="1" width="13%">
		                        	<input class="nui-buttonedit" name="criteria/_expr[3]/combProductCode" onbuttonclick="ButtonClickGetFundNameCommon"/>
		                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="in">
		                        </td>
		                        <td class="form_label" width="7%">
									业务类别:
		                        </td>
		                        <td colspan="1" width="13%">
									<input class="nui-dictcombobox" name="criteria/_expr[4]/processType" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQMM"  
										emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty"/>
									<input class="nui-hidden" name="criteria/_expr[4]/_op" value="in"/>
								</td>
								<td class="form_label" width="7%">
									交易状态:
		                        </td>
		                        <td colspan="1" width="18%">
									<input class="nui-dictcombobox" name="criteria/_expr[5]/validStatus" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_VALID_STATUS"  
										emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
									<input class="nui-hidden" name="criteria/_expr[5]/_op" value="in"/>
								</td>
		                        <td colspan="1" width="15%">
		                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_ZQMM()"/>
		                        </td>
		                    </tr>
						</table>
					</div>
				  </div>
			   </div>
			   <%-- 债券买卖查询条件结束!!! --%>
			   
			   <%-- 债券买卖指令/建议单列表开始... --%>
	           <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	                <table style="width:100%;">
	                    <tr>
	                        <td style="width:50%;">
	                            <a id="confirm_ZQMM" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_ZQMM()">
									确认
	                            </a>
	                            &nbsp;
	                            <a id="update_ZQMM" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit_ZQMM()">
	                               	 编辑
	                            </a>
	                            &nbsp;
	                            <a id="goBack_ZQMM" class='nui-button' plain='false' iconCls="icon-no" onclick="goBack_ZQMM()">
									退回
	                            </a>
	                        </td>
	                        <td style="width:50%;" align="right">
	                            <input class='nui-button' plain='false' text="保存" iconCls="icon-save" onclick="save_ZQMM()"/>
	                            &nbsp;
	                            <%-- 点击“刷新”按钮后重启自动刷新功能（若之前自动刷新功能设置为不自动刷新关闭时） --%>
			                    <a class='nui-button' plain='false' iconCls="icon-reload" onclick="autoRefreshFun()">刷新</a>
			                    <input id="autoRefresh" class="nui-combobox" style="width:90px;" textField="text" valueField="id" url="./AutoRefreshData.txt" value="180" showNullItem="false" allowInput="false"/>
			                    &nbsp;
                				<a href="javascript:fullScreen()"><span class="warn_red_bold" style="border-bottom:1px solid;font-size:13px;">全屏显示</span></a>
	                    		&nbsp;&nbsp;
	                        </td>
	                    </tr>
	                </table>
	            </div>
	            <div class="nui-fit">
	                <div 
	                        id="datagrid_ZQMM"
	                        dataField="zhfwptjyzqmms"
	                        class="nui-datagrid"
	                        style="width:100%;height:100%;"
	                        url="com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_query4Confirm.biz.ext"
	                        pageSize="50"
	                        showPageInfo="true"
	                        multiSelect="true"
	                        onselectionchanged="selectionChanged_ZQMM"
	                        onshowrowdetail="onShowRowDetail"
	                        allowSortColumn="true"
	                        frozenStartColumn="0"
                        	frozenEndColumn="6"
	                        sortMode="client"
	                        enableHotTrack="false"
	                        sizeList="[10,20,50,100]"
	                        allowCellEdit="true"
							allowCellSelect="true"
							enterNextCell="true"
							allowMoveColumn="true"
							editNextOnEnterKey="true">
	
	                    <div property="columns">
	                        <div type="indexcolumn"></div>
	                        <div type="checkcolumn"></div>
	                        <div type="expandcolumn"></div>
	                        <div field="processDate" headerAlign="center" allowSort="true" align="center" width="85px">
	                            业务日期
	                        </div>
	                        <div field="expiredate" headerAlign="center" allowSort="true" align="center" width="85px">
                                    截止日期
                        	</div>
	                        <div field="combProductName" headerAlign="center" allowSort="true" align="left" width="140px">
	                            产品名称
	                        </div>
	                        <div field="investProductNum" headerAlign="center" allowSort="true" align="center" width="50px">
	                            编号
	                        </div>
	                        <div field="vcCombiNo" headerAlign="center" allowSort="true" align="left" visible="false">
	                            投资组合编号
	                        </div>
	                        <div field="vcCombiName" headerAlign="center" allowSort="true" align="left" width="100px">
	                            组合名称
	                        </div>
	                        <div field="processType" headerAlign="center" allowSort="true" align="center" renderer="renderProcessType" width="70px">
	                            业务类别
	                        </div>
	                        <div field="investProductCode" headerAlign="center" allowSort="true" align="left" width="85px">
	                            债券代码
	                        </div>
	                        <div field="investProductName" headerAlign="center" allowSort="true" align="left" width="140px">
	                            债券名称
	                        </div>
	                        <div field="investCategory" headerAlign="center" allowSort="true" align="left" renderer="renderInvestCategory" width="85px">
	                            债券类别
	                        </div>
	                        <div field="subjectRating" headerAlign="center" allowSort="true" align="center" renderer="renderSubjectRating" width="85px">
	                            主体评级
	                        </div>
	                        <div field="bondRating" headerAlign="center" allowSort="true" align="center" renderer="renderBondRating" width="85px">
	                            债券评级
	                        </div>
	                        <div field="clearingSpeed" headerAlign="center" allowSort="true" align="center" renderer="renderClearingSpeed" width="60px">
	                            清算速度
	                        </div>
	                        <div field="cleartype" headerAlign="center" allowSort="true" align="center" renderer="renderClearType" width="60px">
                                          清算类型
                            </div>
	                        <div field="tradingPlace" headerAlign="center" allowSort="true" align="center" renderer="renderTradingPlace" width="120px">
	                            交易场所
	                        </div>
	                        <div field="investCount" headerAlign="center" allowSort="true" align="right" width="100px">
	                            券面金额（万元）
	                        </div>
	                        <div field="tradingOpponent" headerAlign="center" allowSort="true" align="left" width="100px">
	                            交易对手
	                        </div>
	                        <div field="netPrice" headerAlign="center" allowSort="true" align="right" width="100px">
	                            净价（元/百元面值）
	                        </div>
	                        <div field="fullPrice" headerAlign="center" allowSort="true" align="right" width="100px">
	                            全价（元/百元面值）
	                        </div>
	                        <div field="interestRateType" headerAlign="center" allowSort="true" align="center" renderer="renderInterestRateType" width="85px">
	                            收益率类型
	                        </div>
	                        <div field="interestRate" headerAlign="center" allowSort="true" align="right">
	                            收益率
	                        </div>
	                        <div field="traderCode" headerAlign="center" allowSort="true" align="center">
	                            交易员代码
	                        </div>
	                        <div field="seatNum" headerAlign="center" allowSort="true" align="center" >
	                            席位号
	                        </div>
	                        <div field="agreementNum" headerAlign="center" allowSort="true" align="center" >
	                            约定号
	                        </div>
	                        <div field="validStatus" headerAlign="center" allowSort="true" align="center" renderer="renderValidStatus" width="70px">
	                            交易状态
	                        </div>
	                        <div field="inquiryName" headerAlign="center" allowSort="true" align="center" renderer="renderInquiry" width="195px">
	                            指令/建议询价
	                        </div>	                        
	                        <div field="investAdviserName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviser" width="195px">
	                            指令/建议录入
	                        </div>
	                        <div field="completeInstructionsName" headerAlign="center" allowSort="true" align="center" renderer="renderCompleteInstructions" width="195px">
	                            指令/建议补齐
	                        </div>
	                        <div field="investAdviserConfirmName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviserConfirm" width="195px">
	                            指令/建议确认
	                        </div>
	                        <div field="investManagerName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestManager" width="195px" >
	                            投资经理下单
	                        </div>
	                        <div field="traderName" headerAlign="center" allowSort="true" align="center" renderer="renderTrader" width="195px" >
	                            交易员填单
	                        </div>
	                        <div field="reviewName" headerAlign="center" allowSort="true" align="center" renderer="renderReview" width="195px" >
	                            交易已发送
	                        </div>
	                        <div field="sendName" headerAlign="center" allowSort="true" align="center" renderer="renderSend" width="195px" >
	                            前台已成交
	                        </div>
	                        <div field="backstageTraderStatus" headerAlign="center" align="left" allowSort="true" width="170px" renderer="renderBackstageTraderStatus" >
				    后台成交状态
				    			<input property="editor" class="nui-dictcombobox" style="width:100%;" dictTypeId="CF_JY_HTCJZT" showNullItem="true" required="false" />
				            </div>
	                        <div field="backstageTraderRemark" headerAlign="center" allowSort="true" align="left" width="250px">
				    成交情况备注
				  				<input property="editor" class="nui-textarea" style="width:100%;height:100px;"/>
	                        </div>
	                     </div>
	                 </div>
	            </div>
	            <%-- 债券买卖指令/建议单列表结束!!! --%>
			</div>
			
			
			
			
			<div title="正逆回购">
			   <%-- 正逆回购查询条件开始... --%>
			   <div class="search-condition">
				   <div class="list">
					   <div id="form_ZNHG" class="nui-form" style="padding:2px;" align="center" style="height:10%">
							<!-- 数据实体的名称 -->
			                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryZhfwptJyZnhg4Confirm">
			                <!-- 获取03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购类型;16-交易所协议正回购;17-交易所协议逆回购；业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;99-其他指令/建议; -->
			                <input class="nui-hidden" name="criteria/_expr[1]/processType" value="03,04,05,06,16,17,21,22"/>
			                <input class="nui-hidden" name="criteria/_expr[1]/_op" value="in">
			                <!-- 排序字段 -->
			                <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="processDate">
			                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="desc">
			                <input class="nui-hidden" name="criteria/_orderby[2]/_property" value="investProductNum">
			                <input class="nui-hidden" name="criteria/_orderby[2]/_sort" value="desc">
			                <input class="nui-hidden" name="criteria/_orderby[3]/_property" value="validStatus">
			                <input class="nui-hidden" name="criteria/_orderby[3]/_sort" value="asc">
			                <input class="nui-hidden" name="criteria/_orderby[4]/_property" value="processStatus">
			                <input class="nui-hidden" name="criteria/_orderby[4]/_sort" value="asc">
			                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
			                	<tr>
			                        <td class="form_label" width="7%">
										业务日期:
			                        </td>
			                        <td colspan="1" width="13%">
			                            <input id="processDate_ZNHG" class="nui-datepicker" name="criteria/_expr[2]/processDate" width="100px"/>
			                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
			                        </td>
			                        <td class="form_label" width="7%">
										产品名称:
			                        </td>
			                        <td colspan="1" width="13%">
			                            <input class="nui-buttonedit" name="criteria/_expr[3]/combProductCode" onbuttonclick="ButtonClickGetFundNameCommon"/>
		                            	<input class="nui-hidden" name="criteria/_expr[3]/_op" value="in">
			                        </td>
			                        <td class="form_label" width="7%">
										业务类别:
			                        </td>
			                        <td colspan="1" width="13%">
										<input class="nui-dictcombobox" name="criteria/_expr[4]/processType" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZNHG"  
											emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty"/>
										<input class="nui-hidden" name="criteria/_expr[4]/_op" value="in"/>
									</td>
									<td class="form_label" width="7%">
										交易状态:
			                        </td>
			                        <td colspan="1" width="18%">
										<input class="nui-dictcombobox" name="criteria/_expr[5]/validStatus" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_VALID_STATUS"  
											emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
										<input class="nui-hidden" name="criteria/_expr[5]/_op" value="in"/>
									</td>
			                        <td colspan="1" width="15%">
			                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_ZNHG()"/>
			                        </td>
			                    </tr>
							</table>
						</div>
				  </div>
			   </div>
			   <%-- 正逆回购查询条件结束!!! --%>
			   
			   <%-- 正逆回购指令/建议单列表开始... --%>
	           <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	                <table style="width:100%;">
	                    <tr>
	                        <td style="width:50%;">
	                            <a id="confirm_ZNHG" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_ZNHG()">
									确认
	                            </a>
	                            &nbsp;
	                            <a id="update_ZNHG" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit_ZNHG()">
	                               	编辑
	                            </a>
	                            &nbsp;
	                            <a id="export_ZNHG" class='nui-button' plain='false' iconCls="icon-download" onclick="export_ZNHG()">
	                               	 导出
	                            </a>
	                            &nbsp;
	                            <a id="goBack_ZNHG" class='nui-button' plain='false' iconCls="icon-no" onclick="goBack_ZNHG()">
									退回
	                            </a>
	                        </td>
	                        <td style="width:50%;" align="right">
	                            <input class='nui-button' plain='false' text="保存" iconCls="icon-save" onclick="save_ZNHG()"/>
	                    		&nbsp;&nbsp;
	                        </td>
	                    </tr>
	                </table>
	            </div>
	            <div class="nui-fit">
	                <div 
	                        id="datagrid_ZNHG"
	                        dataField="zhfwptjyznhgs"
	                        class="nui-datagrid"
	                        style="width:100%;height:100%;"
	                        url="com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_query4Confirm.biz.ext"
	                        pageSize="50"
	                        showPageInfo="true"
	                        multiSelect="true"
	                        onselectionchanged="selectionChanged_ZNHG"
	                        onshowrowdetail="onShowRowDetail_ZNHG"
	                        allowSortColumn="true"
	                        frozenStartColumn="0"
                        	frozenEndColumn="7"
	                        sortMode="client"
	                        enableHotTrack="false"
	                        allowCellEdit="true"
							allowCellSelect="true"
							enterNextCell="true"
							allowMoveColumn="true"
							editNextOnEnterKey="true">
	
	                    <div property="columns">
	                        <div type="indexcolumn"></div>
	                        <div type="checkcolumn"></div>
	                        <div type="expandcolumn"></div>
	                        
	                        <div field="processStatus" headerAlign="center" allowSort="true" align="center" visible="false">
	                            状态
	                        </div>
	                        <div field="isNotExport" headerAlign="center" allowSort="true" align="center" visible="false">
	                            是否已导出
	                        </div>
	                        
	                        <div field="processDate" headerAlign="center" allowSort="true" align="center" width="85px">
	                            业务日期
	                        </div>
	                        <div field="combProductName" headerAlign="center" allowSort="true" align="left" width="140px">
	                            产品名称
	                        </div>
	                        <div field="investProductNum" headerAlign="center" allowSort="true" align="center" width="50px">
	                            编号
	                        </div>
	                        <div field="vcCombiNo" headerAlign="center" allowSort="true" align="left" visible="false">
	                            投资组合编号
	                        </div>
	                        <div field="vcCombiName" headerAlign="center" allowSort="true" align="left" width="100px">
	                            组合名称
	                        </div>
	                        <div field="processType" headerAlign="center" allowSort="true" align="center" renderer="renderProcessType" width="100px">
	                            业务类别
	                        </div>
	                        <div field="tradingOpponent" headerAlign="center" allowSort="true" align="left" width="195px">
	                            交易对手
	                        </div>
	                        <div field="investCount" headerAlign="center" allowSort="true" align="right" width="120px">
	                            券面总额合计（万元）
	                        </div>
	                        <div field="tranAmount" headerAlign="center" allowSort="true" align="right"width="120px">
	                            交易金额（万元）
	                        </div>
	                        <div field="actualDays" headerAlign="center" allowSort="true" align="center" width="100px">
	                            回购期限（天）
	                        </div>
	                        <div field="tradingRate" headerAlign="center" allowSort="true" align="center" width="90px">
	                            回购利率（%）
	                        </div>
	                        <div field="clearingSpeed" headerAlign="center" allowSort="true" align="center" renderer="renderClearingSpeed" width="60px">
	                            清算速度
	                        </div>
	                        <div field="firstSettlementDate" headerAlign="center" allowSort="true" align="center" width="85px" dateFormat="yyyy-MM-dd">
	                            首次结算日
	                        </div>
	                        <div field="expiryDate" headerAlign="center" allowSort="true" align="center" width="85px" dateFormat="yyyy-MM-dd">
	                            到期结算日
	                        </div>
	                        <div field="validStatus" headerAlign="center" allowSort="true" align="center" renderer="renderValidStatus" width="70px">
	                            交易状态
	                        </div>
	                        <div field="inquiryName" headerAlign="center" allowSort="true" align="center" renderer="renderInquiry" width="195px">
	                            指令/建议询价
	                        </div>	                        
	                        <div field="investAdviserName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviser" width="195px">
	                            指令/建议录入
	                        </div>
	                        <div field="completeInstructionsName" headerAlign="center" allowSort="true" align="center" renderer="renderCompleteInstructions" width="195px">
	                            指令/建议补齐
	                        </div>
	                        <div field="investAdviserConfirmName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviserConfirm" width="195px">
	                            指令/建议确认
	                        </div>
	                        <div field="investManagerName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestManager" width="195px" >
	                            投资经理下单
	                        </div>
	                        <div field="traderName" headerAlign="center" allowSort="true" align="center" renderer="renderTrader" width="195px" >
	                            交易员填单
	                        </div>
	                        <div field="reviewName" headerAlign="center" allowSort="true" align="center" renderer="renderReview" width="195px" >
	                            交易已发送
	                        </div>
	                        <div field="sendName" headerAlign="center" allowSort="true" align="center" renderer="renderSend" width="195px" >
	                            前台已成交
	                        </div>
	                        <div field="backstageTraderStatus" headerAlign="center" align="left" allowSort="true" width="170px" renderer="renderBackstageTraderStatus" >
				    后台成交状态
				    			<input property="editor" class="nui-dictcombobox" style="width:100%;" dictTypeId="CF_JY_HTCJZT" showNullItem="true" required="false" />
				            </div>
	                        <div field="backstageTraderRemark" headerAlign="center" allowSort="true" align="left" width="250px">
				    成交情况备注
				  				<input property="editor" class="nui-textarea" style="width:100%;height:100px;"/>
	                        </div>
	                     </div>
	                 </div>
	            </div>
	            <%-- 正逆回购指令/建议单列表结束!!! --%>
			</div>
			
			
			
			
			<div title="申购缴款">
			   <%-- 申购缴款查询条件开始... --%>
			   <div class="search-condition">
				   <div class="list">
					   <div id="form_ZQSJ" class="nui-form" style="padding:2px;" align="center" style="height:10%">
							<!-- 数据实体的名称 -->
			                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryCfJyProductProcess4Confirm">
			                <!-- 获取07-债券申购;08-债券缴款类型；业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;99-其他指令/建议; -->
			                <input class="nui-hidden" name="criteria/_expr[1]/processType" value="07,08"/>
			                <input class="nui-hidden" name="criteria/_expr[1]/_op" value="in">
			                <!-- 排序字段 -->
			                <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="processDate">
			                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="desc">
			                <input class="nui-hidden" name="criteria/_orderby[2]/_property" value="investProductNum">
			                <input class="nui-hidden" name="criteria/_orderby[2]/_sort" value="desc">
			                <input class="nui-hidden" name="criteria/_orderby[3]/_property" value="validStatus">
			                <input class="nui-hidden" name="criteria/_orderby[3]/_sort" value="asc">
			                <input class="nui-hidden" name="criteria/_orderby[4]/_property" value="processStatus">
			                <input class="nui-hidden" name="criteria/_orderby[4]/_sort" value="asc">
			                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
			                	<tr>
			                        <td class="form_label" width="7%">
										业务日期:
			                        </td>
			                        <td colspan="1" width="13%">
			                            <input id="processDate_ZQSJ" class="nui-datepicker" name="criteria/_expr[2]/processDate" width="100px"/>
			                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
			                        </td>
			                        <td class="form_label" width="7%">
										产品名称:
			                        </td>
			                        <td colspan="1" width="13%">
			                            <input class="nui-buttonedit" name="criteria/_expr[3]/combProductCode" onbuttonclick="ButtonClickGetFundNameCommon"/>
		                            	<input class="nui-hidden" name="criteria/_expr[3]/_op" value="in">
			                        </td>
			                        <td class="form_label" width="7%">
										业务类别:
			                        </td>
			                        <td colspan="1" width="13%">
										<input class="nui-dictcombobox" name="criteria/_expr[4]/processType" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQSJ"  
											emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty"/>
										<input class="nui-hidden" name="criteria/_expr[4]/_op" value="in"/>
									</td>
									<td class="form_label" width="7%">
										交易状态:
			                        </td>
			                        <td colspan="1" width="18%">
										<input class="nui-dictcombobox" name="criteria/_expr[5]/validStatus" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_VALID_STATUS"  
											emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
										<input class="nui-hidden" name="criteria/_expr[5]/_op" value="in"/>
									</td>
			                        <td colspan="1" width="15%">
			                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_ZQSJ()"/>
			                        </td>
			                    </tr>
							</table>
						</div>
				  </div>
			   </div>
			   <%-- 申购缴款查询条件结束!!! --%>
			   
			   <%-- 申购缴款指令/建议单列表开始... --%>
	           <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	                <table style="width:100%;">
	                    <tr>
	                        <td style="width:100%;">
	                            <a id="confirm_ZQSJ" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_ZQSJ()">
									确认
	                            </a>
	                            &nbsp;
	                            <a id="goBack_ZQSJ" class='nui-button' plain='false' iconCls="icon-no" onclick="goBack_ZQSJ()">
									退回
	                            </a>
	                        </td>
	                    </tr>
	                </table>
	            </div>
	            <div class="nui-fit">
	                <div 
	                        id="datagrid_ZQSJ"
	                        dataField="cfjyproductprocesss"
	                        class="nui-datagrid"
	                        style="width:100%;height:100%;"
	                        url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.queryCFJYProductProcesss4Confirm.biz.ext"
	                        pageSize="50"
	                        showPageInfo="true"
	                        multiSelect="true"
	                        onselectionchanged="selectionChanged_ZQSJ"
	                        onshowrowdetail="onShowRowDetail"
	                        allowSortColumn="true"
	                        frozenStartColumn="0"
                        	frozenEndColumn="5"
	                        sortMode="client"
	                        enableHotTrack="false">
	
	                    <div property="columns">
	                        <div type="indexcolumn"></div>
	                        <div type="checkcolumn"></div>
	                        <div type="expandcolumn"></div>
	                        <div field="processDate" headerAlign="center" allowSort="true" align="center" width="85px">
	                            业务日期
	                        </div>
	                        <div field="combProductName" headerAlign="center" allowSort="true" align="left" width="140px">
	                            产品名称
	                        </div>
	                        <div field="investProductNum" headerAlign="center" allowSort="true" align="center" width="50px">
	                            编号
	                        </div>
	                        <div field="vcCombiNo" headerAlign="center" allowSort="true" align="left" visible="false">
	                            投资组合编号
	                        </div>
	                        <div field="vcCombiName" headerAlign="center" allowSort="true" align="left" width="100px">
	                            组合名称
	                        </div>
	                        <div field="processType" headerAlign="center" allowSort="true" align="center" renderer="renderProcessType" width="70px">
	                            业务类别
	                        </div>
	                        <div field="investProductCode" headerAlign="center" allowSort="true" align="left" >
	                            债券代码
	                        </div>
	                        <div field="investProductName" headerAlign="center" allowSort="true" align="left" >
	                            债券名称
	                        </div>
	                        <div field="investCategory" headerAlign="center" allowSort="true" align="left" renderer="renderInvestCategory">
	                            债券类别
	                        </div>
	                        <div field="subjectRating" headerAlign="center" allowSort="true" align="center" renderer="renderSubjectRating">
	                            主体评级
	                        </div>
	                        <div field="bondRating" headerAlign="center" allowSort="true" align="center" renderer="renderBondRating">
	                            债券评级
	                        </div>
	                        <div field="paymentPlace" headerAlign="center" allowSort="true" align="center" renderer="renderPaymentPlace">
	                            缴款场所
	                        </div>
	                        <div field="ratingAgencies" headerAlign="center" allowSort="true" align="left" renderer="renderRatingAgencies">
	                            评级机构
	                        </div>
	                        <div field="investCount" headerAlign="center" allowSort="true" align="right">
	                            交易数量（万元）
	                        </div>
	                        <div field="interestRate" headerAlign="center" allowSort="true" align="right">
	                            投标利率
	                        </div>
	                        <div field="netPrice" headerAlign="center" allowSort="true" align="right">
	                            投标价格（元/百元面值）
	                        </div>
	                        <div field="tradingPlace" headerAlign="center" allowSort="true" align="center"renderer="renderTradingPlace">
	                            投标场所
	                        </div>
	                        <div field="leadUnderwriter" headerAlign="center" allowSort="true" align="left">
	                            承销商
	                        </div>
	                        <div field="clearingSpeed" headerAlign="center" allowSort="true" align="center" renderer="renderClearingSpeed" width="60px">
	                            清算速度
	                        </div>
	                        <div field="deliveryMethod" headerAlign="center" allowSort="true" align="center">
	                            交割方式
	                        </div>
	                        <div field="validStatus" headerAlign="center" allowSort="true" align="center" renderer="renderValidStatus" width="70px">
	                            交易状态
	                        </div>
	                        <div field="investAdviserName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviser" width="195px">
	                            指令/建议录入
	                        </div>
	                        <div field="investAdviserConfirmName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviserConfirm" width="195px">
	                            指令/建议确认
	                        </div>
	                        <div field="investManagerName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestManager" width="195px" >
	                            投资经理下单
	                        </div>
	                        <div field="traderName" headerAlign="center" allowSort="true" align="center" renderer="renderTrader" width="195px" >
	                            交易员填单
	                        </div>
	                        <div field="reviewName" headerAlign="center" allowSort="true" align="center" renderer="renderReview" width="195px" >
	                            交易已发送
	                        </div>
	                        <div field="sendName" headerAlign="center" allowSort="true" align="center" renderer="renderSend" width="195px" >
	                            前台已成交
	                        </div>
	                        <div field="backstageTraderName" headerAlign="center" allowSort="true" align="center" renderer="renderBackstageTrader" width="195px" >
	                            后台已成交
	                        </div>
	                     </div>
	                 </div>
	            </div>
	            <%-- 申购缴款指令/建议单列表结束!!! --%>
			</div>
			
			
			
			
			<div title="基金申赎">
			   <%-- 基金申赎查询条件开始... --%>
			   <div class="search-condition">
				   <div class="list">
					   <div id="form_JJSS" class="nui-form" style="padding:2px;" align="center" style="height:10%">
							<!-- 数据实体的名称 -->
			                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryCfJyProductProcess4Confirm">
			                <!-- 获取09-基金申购;10-基金赎回;11-基金转换类型；业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;99-其他指令/建议; -->
			                <input class="nui-hidden" name="criteria/_expr[1]/processType" value="09,10,11,18"/>
			                <input class="nui-hidden" name="criteria/_expr[1]/_op" value="in">
			                <!-- 排序字段 -->
			                <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="processDate">
			                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="desc">
			                <input class="nui-hidden" name="criteria/_orderby[2]/_property" value="investProductNum">
			                <input class="nui-hidden" name="criteria/_orderby[2]/_sort" value="desc">
			                <input class="nui-hidden" name="criteria/_orderby[3]/_property" value="validStatus">
			                <input class="nui-hidden" name="criteria/_orderby[3]/_sort" value="asc">
			                <input class="nui-hidden" name="criteria/_orderby[4]/_property" value="processStatus">
			                <input class="nui-hidden" name="criteria/_orderby[4]/_sort" value="asc">
			                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
			                	<tr>
			                        <td class="form_label" width="7%">
										业务日期:
			                        </td>
			                        <td colspan="1" width="13%">
			                            <input id="processDate_JJSS" class="nui-datepicker" name="criteria/_expr[2]/processDate" width="100px"/>
			                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
			                        </td>
			                        <td class="form_label" width="7%">
										产品名称:
			                        </td>
			                        <td colspan="1" width="13%">
			                            <input class="nui-buttonedit" name="criteria/_expr[3]/combProductCode" onbuttonclick="ButtonClickGetFundNameCommon"/>
		                            	<input class="nui-hidden" name="criteria/_expr[3]/_op" value="in">
			                        </td>
			                        <td class="form_label" width="7%">
										业务类别:
			                        </td>
			                        <td colspan="1" width="13%">
										<input class="nui-dictcombobox" name="criteria/_expr[4]/processType" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_JJSS"  
											emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty"/>
										<input class="nui-hidden" name="criteria/_expr[4]/_op" value="in"/>
									</td>
									<td class="form_label" width="7%">
										交易状态:
			                        </td>
			                        <td colspan="1" width="18%">
										<input class="nui-dictcombobox" name="criteria/_expr[5]/validStatus" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_VALID_STATUS"  
											emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
										<input class="nui-hidden" name="criteria/_expr[5]/_op" value="in"/>
									</td>
			                        <td colspan="1" width="15%">
			                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_JJSS()"/>
			                        </td>
			                    </tr>
							</table>
						</div>
				  </div>
			   </div>
			   <%-- 基金申赎查询条件结束!!! --%>
			   
			   <%-- 基金申赎指令/建议单列表开始... --%>
	           <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	                <table style="width:100%;">
	                    <tr>
	                        <td style="width:100%;">
	                            <a id="confirm_JJSS" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_JJSS()">
									确认
	                            </a>
	                            &nbsp;
	                            <a id="goBack_JJSS" class='nui-button' plain='false' iconCls="icon-no" onclick="goBack_JJSS()">
									退回
	                            </a>
	                        </td>
	                    </tr>
	                </table>
	            </div>
	            <div class="nui-fit">
	                <div 
	                        id="datagrid_JJSS"
	                        dataField="cfjyproductprocesss"
	                        class="nui-datagrid"
	                        style="width:100%;height:100%;"
	                        url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.queryCFJYProductProcesss4Confirm.biz.ext"
	                        pageSize="50"
	                        showPageInfo="true"
	                        multiSelect="true"
	                        onselectionchanged="selectionChanged_JJSS"
	                        onshowrowdetail="onShowRowDetail"
	                        allowSortColumn="true"
	                        frozenStartColumn="0"
                        	frozenEndColumn="5"
	                        sortMode="client"
	                        enableHotTrack="false">
	
	                    <div property="columns">
	                        <div type="indexcolumn"></div>
	                        <div type="checkcolumn"></div>
	                        <div type="expandcolumn"></div>
	                        <div field="processDate" headerAlign="center" allowSort="true" align="center" width="85px">
	                            业务日期
	                        </div>
	                        <div field="combProductName" headerAlign="center" allowSort="true" align="left" width="140px">
	                            产品名称
	                        </div>
	                        <div field="investProductNum" headerAlign="center" allowSort="true" align="center" width="50px">
	                            编号
	                        </div>
	                        <div field="vcCombiNo" headerAlign="center" allowSort="true" align="left" visible="false">
	                            投资组合编号
	                        </div>
	                        <div field="vcCombiName" headerAlign="center" allowSort="true" align="left" width="100px">
	                            组合名称
	                        </div>
	                        <div field="processType" headerAlign="center" allowSort="true" align="center" renderer="renderProcessType" width="70px">
	                            业务类别
	                        </div>
	                        <div field="investProductCode" headerAlign="center" allowSort="true" align="left" width="85px">
	                            基金代码
	                        </div>
	                        <div field="investProductName" headerAlign="center" allowSort="true" align="left" width="195px">
	                            基金名称
	                        </div>
	                        <div field="investCount" headerAlign="center" allowSort="true" align="right" width="100px">
	                            数量（元/份额）
	                        </div>
	                        <div field="transformFundCode" headerAlign="center" allowSort="true" align="center" width="85px">
	                            转入基金代码
	                        </div>
	                        <div field="transformFundName" headerAlign="center" allowSort="true" align="center" width="195px">
	                            转入基金名称
	                        </div>
	                        <div field="validStatus" headerAlign="center" allowSort="true" align="center" renderer="renderValidStatus" width="70px">
	                            交易状态
	                        </div>
	                        <div field="investAdviserName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviser" width="195px">
	                            指令/建议录入
	                        </div>
	                        <div field="investAdviserConfirmName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviserConfirm" width="195px">
	                            指令/建议确认
	                        </div>
	                        <div field="investManagerName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestManager" width="195px" >
	                            投资经理下单
	                        </div>
	                        <div field="traderName" headerAlign="center" allowSort="true" align="center" renderer="renderTrader" width="195px" >
	                            交易员填单
	                        </div>
	                        <div field="reviewName" headerAlign="center" allowSort="true" align="center" renderer="renderReview" width="195px" >
	                            交易已发送
	                        </div>
	                        <div field="sendName" headerAlign="center" allowSort="true" align="center" renderer="renderSend" width="195px" >
	                            前台已成交
	                        </div>
	                        <div field="backstageTraderName" headerAlign="center" allowSort="true" align="center" renderer="renderBackstageTrader" width="195px" >
	                            后台已成交
	                        </div>
	                     </div>
	                 </div>
	            </div>
	            <%-- 基金申赎指令/建议单列表结束!!! --%>
			</div>
			
			
			<div title="大宗交易">
			<!-- 大宗交易查询条件开始 -->
			<div class="search-condition">
			   <div class="list">
				   <div id="form_DZJY" class="nui-form" style="padding:2px;" align="center" style="height:10%">
						<!-- 数据实体的名称 -->
		                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryCfJyProductProcess4Confirm">
		                <!-- 获取99-其他指令/建议类型；业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;20-投票;99-其他指令/建议; -->
		                <input class="nui-hidden" name="criteria/_expr[1]/processType" value="19"/>
		                <input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
		                <!-- 排序字段 -->
		                <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="processDate">
		                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="desc">
		                <input class="nui-hidden" name="criteria/_orderby[2]/_property" value="investProductNum">
		                <input class="nui-hidden" name="criteria/_orderby[2]/_sort" value="desc">
		                <input class="nui-hidden" name="criteria/_orderby[3]/_property" value="validStatus">
		                <input class="nui-hidden" name="criteria/_orderby[3]/_sort" value="asc">
		                <input class="nui-hidden" name="criteria/_orderby[4]/_property" value="processStatus">
		                <input class="nui-hidden" name="criteria/_orderby[4]/_sort" value="asc">
		                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
		                	<tr>
		                        <td class="form_label" width="7%">
									业务日期:
		                        </td>
		                        <td colspan="1" width="13%">
		                            <input id="processDate_DZJY" class="nui-datepicker" name="criteria/_expr[2]/processDate" width="100px"/>
		                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
		                        </td>
		                        <td class="form_label" width="7%">
									产品名称:
		                        </td>
		                        <td colspan="1" width="13%">
		                            <input class="nui-buttonedit" name="criteria/_expr[3]/combProductCode" onbuttonclick="ButtonClickGetFundNameCommon"/>
		                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="in">
		                        </td>
								<td class="form_label" width="7%">
									交易状态:
		                        </td>
		                        <td colspan="1" width="18%">
									<input class="nui-dictcombobox" name="criteria/_expr[4]/validStatus" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_VALID_STATUS"  
										emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
									<input class="nui-hidden" name="criteria/_expr[4]/_op" value="in"/>
								</td>
		                        <td colspan="1" width="35%">
		                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_DZJY()"/>
		                        </td>
		                    </tr>
						</table>
					</div>
			  </div>
		   </div>
		   <%-- 大宗交易指令/建议查询条件结束!!! --%>
		   
		   <%-- 大宗交易指令/建议单列表开始... --%>
           <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a id="confirm_DZJY" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_DZJY()">
									确认
	                            </a>
	                            &nbsp;
	                            <a id="goBack_DZJY" class='nui-button' plain='false' iconCls="icon-no" onclick="goBack_DZJY()">
									退回
	                            </a>
                        </td>
                    </tr>
                </table>
            </div>
		   <div class="nui-fit">
                <div 
                        id="datagrid_DZJY"
                        dataField="cfjyproductprocesss"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.queryCFJYProductProcesss4Confirm.biz.ext"
                        pageSize="50"
                        showPageInfo="true"
                        multiSelect="true"
                        onselectionchanged="selectionChanged_DZJY"
                        onshowrowdetail="onShowRowDetail"
                        allowSortColumn="true"
                        frozenStartColumn="0"
                        frozenEndColumn="5"
                        sortMode="client"
                        enableHotTrack="false">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div type="checkcolumn"></div>
                        <div type="expandcolumn"></div>
                        <div field="processDate" headerAlign="center" allowSort="true" align="center" width="85px">
                            业务日期
                        </div>
                        <div field="combProductName" headerAlign="center" allowSort="true" align="left" width="140px">
                            产品名称
                        </div>
                        <div field="investProductNum" headerAlign="center" allowSort="true" align="center" width="50px">
                            编号
                        </div>
                        <div field="vcCombiNo" headerAlign="center" allowSort="true" align="left" visible="false">
                            投资组合编号
                        </div>
                        <div field="vcCombiName" headerAlign="center" allowSort="true" align="left" width="100px">
                            组合名称
                        </div>
                        <div field="investProductCode" headerAlign="center" allowSort="true" align="left">
                            证券代码
                        </div>
                        <div field="investProductName" headerAlign="center" allowSort="true" align="left">
                            证券名称
                        </div>
                        <div field="deliveryMethod" headerAlign="center" allowSort="true" align="center" renderer="renderDeliveryMethod">
                            买卖方向
                        </div>
                        <div field="netPrice" headerAlign="center" allowSort="true" align="right">
                            指令/建议价格(元)
                        </div>
                        <div field="investCount" headerAlign="center" allowSort="true" align="right">
                           委托数量(股)
                        </div>
                        <div field="seatNum" headerAlign="center" allowSort="true" align="center">
                           对方席位号
                        </div>
                        <div field="agreementNum" headerAlign="center" allowSort="true" align="center">
                           约定号
                        </div>
                        <div field="tradingOpponent" headerAlign="center" allowSort="true" align="center">
                           交易对手名称
                        </div>
                        <div field="interestRateType" headerAlign="center" allowSort="true" align="center" >
                           关联关系
                        </div>
                        <div field="validStatus" headerAlign="center" allowSort="true" align="center" renderer="renderValidStatus" width="70px">
                            交易状态
                        </div>
                        <div field="investAdviserName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviser" width="195px">
                            指令/建议录入
                        </div>
                        <div field="investAdviserConfirmName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviserConfirm" width="195px">
                            指令/建议确认
                        </div>
                        <div field="investManagerName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestManager" width="195px" >
                            投资经理下单
                        </div>
                        <div field="traderName" headerAlign="center" allowSort="true" align="center" renderer="renderTrader" width="195px" >
                            交易员执行
                        </div>
                    </div>
                </div>
             </div>           
			<%-- 大宗交易指令/建议单列表结束!!! --%>
		</div>
		
		
		
		
		
		<div title="投票">
		<!-- 投票查询条件开始 -->
		<div class="search-condition">
		   <div class="list">
			   <div id="form_TP" class="nui-form" style="padding:2px;" align="center" style="height:10%">
					<!-- 数据实体的名称 -->
	                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryCfJyProductProcess4Confirm">
	                <!-- 获取99-其他指令/建议类型；业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;20-投票;99-其他指令/建议; -->
	                <input class="nui-hidden" name="criteria/_expr[1]/processType" value="20"/>
	                <input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
	                <!-- 排序字段 -->
	                <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="processDate">
	                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="desc">
	                <input class="nui-hidden" name="criteria/_orderby[2]/_property" value="investProductNum">
	                <input class="nui-hidden" name="criteria/_orderby[2]/_sort" value="desc">
	                <input class="nui-hidden" name="criteria/_orderby[3]/_property" value="validStatus">
	                <input class="nui-hidden" name="criteria/_orderby[3]/_sort" value="asc">
	                <input class="nui-hidden" name="criteria/_orderby[4]/_property" value="processStatus">
	                <input class="nui-hidden" name="criteria/_orderby[4]/_sort" value="asc">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="7%">
								业务日期:
	                        </td>
	                        <td colspan="1" width="13%">
	                            <input id="processDate_TP" class="nui-datepicker" name="criteria/_expr[2]/processDate" width="100px"/>
	                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
	                        </td>
	                        <td class="form_label" width="7%">
								产品名称:
	                        </td>
	                        <td colspan="1" width="13%">
	                            <input class="nui-buttonedit" name="criteria/_expr[3]/combProductCode" onbuttonclick="ButtonClickGetFundNameCommon"/>
	                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="in">
	                        </td>
							<td class="form_label" width="7%">
								交易状态:
	                        </td>
	                        <td colspan="1" width="18%">
								<input class="nui-dictcombobox" name="criteria/_expr[4]/validStatus" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_VALID_STATUS"  
									emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
								<input class="nui-hidden" name="criteria/_expr[4]/_op" value="in"/>
							</td>
	                        <td colspan="1" width="35%">
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_TP()"/>
	                        </td>
	                    </tr>
					</table>
				</div>
		  </div>
	   </div>
	   <%-- 投票查询条件结束!!! --%>
	   
	   <%-- 投票指令/建议单列表开始... --%>
	   <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	        <table style="width:100%;">
	            <tr>
	                <td style="width:100%;">
	                    <a id="confirm_TP" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_TP()">
							确认
	                    </a>
	                    &nbsp;
	                    <a id="goBack_TP" class='nui-button' plain='false' iconCls="icon-no" onclick="goBack_TP()">
							退回
	                    </a>
	                </td>
	            </tr>
	        </table>
	    </div>
	   <div class="nui-fit">
        <div 
                id="datagrid_TP"
                dataField="cfjyproductprocesss"
                class="nui-datagrid"
                style="width:100%;height:100%;"
                url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.queryCFJYProductProcesss4Confirm.biz.ext"
                        pageSize="50"
                        showPageInfo="true"
                        multiSelect="true"
                        onselectionchanged="selectionChanged_TP"
                        onshowrowdetail="onShowRowDetail"
                        allowSortColumn="true"
                        frozenStartColumn="0"
                        frozenEndColumn="5"
                        sortMode="client"
                        enableHotTrack="false">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div type="checkcolumn"></div>
                        <div type="expandcolumn"></div>
                        <div field="processDate" headerAlign="center" allowSort="true" align="center" width="85px">
                            业务日期
                        </div>
                        <div field="combProductName" headerAlign="center" allowSort="true" align="left" width="140px">
                            产品名称
                        </div>
                        <div field="investProductNum" headerAlign="center" allowSort="true" align="center" width="50px">
                            编号
                        </div>
                        <div field="vcCombiNo" headerAlign="center" allowSort="true" align="left" visible="false">
                            投资组合编号
                        </div>
                        <div field="vcCombiName" headerAlign="center" allowSort="true" align="left" width="100px">
                            组合名称
                        </div>
                        <div field="investProductCode" headerAlign="center" allowSort="true" align="left">
                            证券代码
                        </div>
                        <div field="investProductName" headerAlign="center" allowSort="true" align="left">
                            证券名称
                        </div>
                        <div field="tpZcya" headerAlign="center" allowSort="true" align="left" width="300px">
                            赞成议案
                        </div>
                        <div field="tpFdyz" headerAlign="center" allowSort="true" align="left" width="300px">
                            反对议案
                        </div>
                        <div field="tpQqya" headerAlign="center" allowSort="true" align="left" width="300px">
                            弃权议案
                        </div>
                        <div field="validStatus" headerAlign="center" allowSort="true" align="center" renderer="renderValidStatus" width="70px">
                            交易状态
                        </div>
                        <div field="investAdviserName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviser" width="195px">
                            指令/建议录入
                        </div>
                        <div field="investAdviserConfirmName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviserConfirm" width="195px">
                            指令/建议确认
                        </div>
                        <div field="investManagerName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestManager" width="195px" >
                            投资经理下单
                        </div>
                        <div field="traderName" headerAlign="center" allowSort="true" align="center" renderer="renderTrader" width="195px" >
                            交易员执行
                        </div>
                    </div>
                </div>
             </div>           
			<%-- 投票指令/建议单列表结束!!! --%>
	    </div>
		    
		    
		    

		<div title="其他指令/建议">
			   <%-- 其他指令/建议查询条件开始... --%>
			   <div class="search-condition">
				   <div class="list">
					   <div id="form_QTZL" class="nui-form" style="padding:2px;" align="center" style="height:10%">
							<!-- 数据实体的名称 -->
			                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryCfJyProductProcess4Confirm">
			                <!-- 获取99-其他指令/建议类型；业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;99-其他指令/建议; -->
			                <input class="nui-hidden" name="criteria/_expr[1]/processType" value="99"/>
			                <input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
			                <!-- 排序字段 -->
			                <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="processDate">
			                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="desc">
			                <input class="nui-hidden" name="criteria/_orderby[2]/_property" value="investProductNum">
			                <input class="nui-hidden" name="criteria/_orderby[2]/_sort" value="desc">
			                <input class="nui-hidden" name="criteria/_orderby[3]/_property" value="validStatus">
			                <input class="nui-hidden" name="criteria/_orderby[3]/_sort" value="asc">
			                <input class="nui-hidden" name="criteria/_orderby[4]/_property" value="processStatus">
			                <input class="nui-hidden" name="criteria/_orderby[4]/_sort" value="asc">
			                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
			                	<tr>
			                        <td class="form_label" width="7%">
										业务日期:
			                        </td>
			                        <td colspan="1" width="13%">
			                            <input id="processDate_QTZL" class="nui-datepicker" name="criteria/_expr[2]/processDate" width="100px"/>
			                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
			                        </td>
			                        <td class="form_label" width="7%">
										产品名称:
			                        </td>
			                        <td colspan="1" width="13%">
			                            <input class="nui-buttonedit" name="criteria/_expr[3]/combProductCode" onbuttonclick="ButtonClickGetFundNameCommon"/>
		                            	<input class="nui-hidden" name="criteria/_expr[3]/_op" value="in">
			                        </td>
									<td class="form_label" width="7%">
										交易状态:
			                        </td>
			                        <td colspan="1" width="18%">
										<input class="nui-dictcombobox" name="criteria/_expr[4]/validStatus" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_VALID_STATUS"  
											emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
										<input class="nui-hidden" name="criteria/_expr[4]/_op" value="in"/>
									</td>
			                        <td colspan="1" width="35%">
			                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_QTZL()"/>
			                        </td>
			                    </tr>
							</table>
						</div>
				  </div>
			   </div>
			   <%-- 其他指令/建议查询条件结束!!! --%>
			   
			   <%-- 其他指令/建议指令/建议单列表开始... --%>
	           <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	                <table style="width:100%;">
	                    <tr>
	                        <td style="width:100%;">
	                            <a id="confirm_QTZL" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_QTZL()">
									确认
	                            </a>
	                            &nbsp;
	                            <a id="goBack_QTZL" class='nui-button' plain='false' iconCls="icon-no" onclick="goBack_QTZL()">
									退回
	                            </a>
	                        </td>
	                    </tr>
	                </table>
	            </div>
	            <div class="nui-fit">
	                <div 
	                        id="datagrid_QTZL"
	                        dataField="cfjyproductprocesss"
	                        class="nui-datagrid"
	                        style="width:100%;height:100%;"
	                        url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.queryCFJYProductProcesss4Confirm.biz.ext"
	                        pageSize="50"
	                        showPageInfo="true"
	                        multiSelect="true"
	                        onselectionchanged="selectionChanged_QTZL"
	                        onshowrowdetail="onShowRowDetail"
	                        allowSortColumn="true"
	                        frozenStartColumn="0"
                        	frozenEndColumn="5"
	                        sortMode="client"
	                        enableHotTrack="false">
	
	                    <div property="columns">
	                        <div type="indexcolumn"></div>
	                        <div type="checkcolumn"></div>
	                        <div type="expandcolumn"></div>
	                        <div field="processDate" headerAlign="center" allowSort="true" align="center" width="85px">
	                            业务日期
	                        </div>
	                        <div field="combProductName" headerAlign="center" allowSort="true" align="left" width="140px">
	                            产品名称
	                        </div>
	                        <div field="investProductNum" headerAlign="center" allowSort="true" align="center" width="50px">
	                            编号
	                        </div>
	                        <div field="vcCombiNo" headerAlign="center" allowSort="true" align="left" visible="false">
	                            投资组合编号
	                        </div>
	                        <div field="vcCombiName" headerAlign="center" allowSort="true" align="left" width="100px">
	                            组合名称
	                        </div>
	                        <div field="memo" headerAlign="center" allowSort="true" align="left" width="300px">
	                            内容
	                        </div>
	                        <div field="validStatus" headerAlign="center" allowSort="true" align="center" renderer="renderValidStatus" width="70px">
	                            交易状态
	                        </div>
	                        <div field="investAdviserName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviser" width="195px">
	                            指令/建议录入
	                        </div>
	                        <div field="investAdviserConfirmName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestAdviserConfirm" width="195px">
	                            指令/建议确认
	                        </div>
	                        <div field="entrustName" headerAlign="center" allowSort="true" align="center" renderer="renderEntrust" width="195px">
                                   指令/建议复核
                            </div>
	                        <div field="investManagerName" headerAlign="center" allowSort="true" align="center" renderer="renderInvestManager" width="195px" >
	                            投资经理下单
	                        </div>
	                        <div field="traderName" headerAlign="center" allowSort="true" align="center" renderer="renderTrader" width="195px" >
	                            交易员填单
	                        </div>
	                        <div field="reviewName" headerAlign="center" allowSort="true" align="center" renderer="renderReview" width="195px" >
	                            交易已发送
	                        </div>
	                        <div field="sendName" headerAlign="center" allowSort="true" align="center" renderer="renderSend" width="195px" >
	                            前台已成交
	                        </div>
	                        <div field="backstageTraderName" headerAlign="center" allowSort="true" align="center" renderer="renderBackstageTrader" width="195px" >
	                            后台已成交
	                        </div>
	                     </div>
	                 </div>
	            </div>
	            <%-- 其他指令/建议指令/建议单列表结束!!! --%>
			</div>
			
			<div title="导出">
			   <%-- 导出查询条件开始... --%>
			   <div class="search-condition">
				   <div class="list">
					   <form id="form_ZLDDC" method="post">
							<!-- 数据实体的名称 -->
			                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.singleDataset.CfJyProductProcess">
			                <input class="nui-hidden" name="exportType" value="0">
			                <!-- 排序字段 -->
			                <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="processDate">
			                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="desc">
			                <input class="nui-hidden" name="criteria/_orderby[2]/_property" value="investProductNum">
			                <input class="nui-hidden" name="criteria/_orderby[2]/_sort" value="desc">
			                <input class="nui-hidden" name="criteria/_orderby[3]/_property" value="validStatus">
			                <input class="nui-hidden" name="criteria/_orderby[3]/_sort" value="asc">
			                <input class="nui-hidden" name="criteria/_orderby[4]/_property" value="processStatus">
			                <input class="nui-hidden" name="criteria/_orderby[4]/_sort" value="asc">
			                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
			                	<tr>
			                        <td class="form_label" width="7%">
										业务日期:
			                        </td>
			                        <td colspan="1" width="35%">
			                        	从<input id="processDate_ZLDDC_begin" class="nui-datepicker" name="criteria/_expr[1]/processDate" required="true" width="100px"/>
			                              <input class="nui-hidden" name="criteria/_expr[1]/_op" value=">=">
										到<input id="processDate_ZLDDC_end" class="nui-datepicker" name="criteria/_expr[2]/processDate" required="true" width="100px"/>
			                              <input class="nui-hidden" name="criteria/_expr[2]/_op" value="<=">
			                        </td>
			                        <td class="form_label" width="10%">
										交易状态:
			                        </td>
			                        <td colspan="1" width="15%">
										<input class="nui-dictcombobox" name="criteria/_expr[3]/validStatus" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_VALID_STATUS"  
											emptyText="全部" nullItemText="全部" showNullItem="true" value="0" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
										<input class="nui-hidden" name="criteria/_expr[3]/_op" value="in"/>
									</td>
									<td class="form_label" width="12%">
										指令/建议处理状态:
			                        </td>
			                        <td colspan="1" width="17%">
										<input class="nui-dictcombobox" name="criteria/_expr[4]/processStatus" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_PROCESS_STATUS"  
											emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
										<input class="nui-hidden" name="criteria/_expr[4]/_op" value="in"/>
									</td>
								</tr>
								<tr>
			                        <td class="form_label">
										产品名称:
			                        </td>
			                        <td colspan="3">
				                        <input class="nui-buttonedit" name="criteria/_expr[5]/combProductCode" onbuttonclick="ButtonClickGetFundNameCommon" width="300px"/>
		                            	<input class="nui-hidden" name="criteria/_expr[5]/_op" value="in">
				                        
				                        <input id="processId" class="nui-hidden" name="criteria/_expr[6]/processId" value=""/>
			                        	<input class="nui-hidden" name="criteria/_expr[6]/_op" value="in"/>
			                        </td>
			                        <td colspan="2">
			                            <input id="export_ZLDDC" class='nui-button' plain='false' text="导出Excel" iconCls="icon-download" onclick="export_ZLDDC()"/>
			                        </td>
			                    </tr>
							</table>
						</form>
				  </div>
			   </div>
			   <%-- 导出查询条件结束!!! --%>
			</div>
			
			
			<!-- 业务类型标签页结束!!! -->
		</div>
    </div>
</div>
</div>
<div>
	<form id="export_ZNHG_FROM" method="post">
		<!-- 数据实体的名称 -->
		<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.singleDataset.ZhfwptJyZnhg">
		<input class="nui-hidden" name="exportType" value="0">
		<input class="nui-hidden" name="criteria/_expr[1]/processId" id="processId1"/>
		<input class="nui-hidden" name="criteria/_expr[1]/_op" value="in"/>
		<input class="nui-hidden" name="processType" id="processType1"/>
	</form>	
</div>
<script type="text/javascript">
    nui.parse();
    //初始化查询条件业务日期值为当天
    var date = new Date();
    nui.get("processDate_ZQMM").setValue(date);
    nui.get("processDate_ZNHG").setValue(date);
    nui.get("processDate_ZQSJ").setValue(date);
    nui.get("processDate_JJSS").setValue(date);
    nui.get("processDate_DZJY").setValue(date);
    nui.get("processDate_TP").setValue(date);
    nui.get("processDate_QTZL").setValue(date);
    nui.get("processDate_ZLDDC_begin").setValue(date);
    nui.get("processDate_ZLDDC_end").setValue(date);
    
    
    var tradingConfirmAuthorityUserIds = "";//交易确认阶段权限人员名单字符串
    var backstageConfirmAuthorityUserIds = "";//后台已成交阶段权限人员名单字符串，确认时使用
    //页面加载完成后处理逻辑函数
    function onloadFun(){
    	//获取交易确认阶段权限人员名单，权限关系类型：01-产品与投资顾问权限；02-产品与投资经理下单权限；03-产品与交易员填单权限；04-产品与复核员[交易发送]权限；05-产品与前台已成交权限；06-产品与后台已成交员权限；98-后台已成交确认阶段权限；99-交易确认阶段权限；
    	$.ajax({
            url:"com.cjhxfund.commonUtil.ProductManager.getTradingConfirmAuthority.biz.ext",
            type:'POST',
            data:null,
            cache:false,
            contentType:'text/json',
            success:function(text){
                var returnJson = nui.decode(text);
                if(returnJson.exception == null){
                	tradingConfirmAuthorityUserIds = returnJson.userIds99;//交易确认阶段权限人员名单字符串，确认时使用
			        backstageConfirmAuthorityUserIds = returnJson.userIds98;//后台已成交阶段权限人员名单字符串，确认时使用
                }else{
                    nui.alert("权限人员名单获取失败", "系统提示");
                }
            }
        });
    }
    
    //获取“今日待处理”数据，根据业务处理日期查询当天所有业务类型待处理指令/建议单与当天该业务指令/建议单总数比值
    var dateStr = nui.formatDate(date, "yyyyMMdd");
    function reloadWaitConfirmFun(){
    	//到后台获取“今日待处理”模块数据
        var json = nui.encode({processDate: dateStr});
        $.ajax({
            url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getWaitConfirmByProcessDate.biz.ext",
            type:'POST',
            data:json,
            cache: false,
            contentType:'text/json',
            success:function(text){
                var returnJson = nui.decode(text);
                if(returnJson.exception == null){
                	var result = returnJson.result;
                	if(result!=null && result!=""){
                		var resultArr = result.split(",");
                		var tabCmp = nui.get("tab");
                		tabCmp.updateTab(tabCmp.getTab(0), {title:"债券买卖("+resultArr[0]+")"});
                		tabCmp.updateTab(tabCmp.getTab(1), {title:"正逆回购("+resultArr[1]+")"});
                		tabCmp.updateTab(tabCmp.getTab(2), {title:"申购缴款("+resultArr[2]+")"});
                		tabCmp.updateTab(tabCmp.getTab(3), {title:"基金申赎("+resultArr[3]+")"});
                		//tabCmp.updateTab(tabCmp.getTab(4), {title:"同业存取("+resultArr[4]+")"});
                		//tabCmp.updateTab(tabCmp.getTab(5), {title:"追加提取("+resultArr[5]+")"});
                		tabCmp.updateTab(tabCmp.getTab(4), {title:"大宗交易("+resultArr[6]+")"});
                		tabCmp.updateTab(tabCmp.getTab(5), {title:"投票("+resultArr[7]+")"});
                		tabCmp.updateTab(tabCmp.getTab(6), {title:"其他指令/建议("+resultArr[8]+")"});
                	}
                }else{
                    nui.alert("今日待处理模块数据获取失败", "系统提示");
                }
            }
        });
    	
    }
    
    //“今日待处理”模块自动刷新功能处理
    var autoRefreshReturnVal;//自动刷新定时器返回值（使用该值关闭之前的定时器）
    var autoRefreshValOld;//历史自动刷新时间
    function autoRefreshFun(){
    	activechangedFun();//同时刷新查询列表数据
		
    	var autoRefreshVal = nui.get("autoRefresh").getValue();//获取最新自动刷新时间
    	//若最新获取的自动刷新时间与历史自动刷新时间不等，则关闭之前的定时器，以新的自动刷新时间新建定时器，并将新值赋予历史自动刷新时间变量
    	if(autoRefreshVal!=autoRefreshValOld){
    		autoRefreshValOld = autoRefreshVal;//将新值赋予历史自动刷新时间变量
    		clearInterval(autoRefreshReturnVal);//关闭之前的定时器
    		if(autoRefreshValOld!="0"){
    			autoRefreshReturnVal = setInterval("autoRefreshFun()", eval(autoRefreshValOld)*1000);//以新的自动刷新时间新建定时器
    		}
    	}
    }
    autoRefreshReturnVal = self.setInterval("autoRefreshFun()",180000);//设置自动刷新时间默认3分钟
    
    
    //表格行增加背景色--所有业务通用
    function drawcellFun(e){
    	var record = e.record;
		//设置行样式，交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
		if(record.validStatus=="1" || record.validStatus=="4"){
			e.rowCls = "validStatus_modify_1_4";
		}else if(record.validStatus=="2"){
			e.rowCls = "validStatus_del_2";
		}else if(record.validStatus=="3"){
			e.rowCls = "validStatus_modify_3";
		}else{
		    //判断指令/建议是否导出过 ：1-已导出过 ，0-未导出过
		  if(record.isNotExport != 1){
			//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
			if(record.processStatus=="-2"){
				e.rowCls = "processStatus_-2_qr";
				
				//若当前用户有权限处理该指令/建议单，则该指令/建议单使用特定背景色显示（交易员填单修改权限）
				if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
					var hasPermission = false;//是否有权限，默认无
					var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
					for(var i=0; i<tradingConfirmAuthorityUserIdsArr.length; i++){
						var userIdTemp = tradingConfirmAuthorityUserIdsArr[i];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
					if(hasPermission==true){
						e.rowCls = "processStatus_wait_confirm";
					}
				}
			}else if(record.processStatus=="-1"){
				e.rowCls = "processStatus_-1_qr";
			}else if(record.processStatus=="0"){
				e.rowCls = "processStatus_0_qr";
			}else if(record.processStatus=="1"){
				e.rowCls = "processStatus_1_qr";
				
				//若当前用户有权限处理该指令/建议单，则该指令/建议单使用特定背景色显示（投资经理下单确认权限）
				var userIdRelaType02 = record.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
				if(userIdRelaType02!=null && userIdRelaType02!=""){
					var hasPermission = false;
					var userIdRelaType02Arr = userIdRelaType02.split(",");
					for(var i=0; i<userIdRelaType02Arr.length; i++){
						var userIdTemp = userIdRelaType02Arr[i];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
					if(hasPermission==true){
						e.rowCls = "processStatus_wait_confirm";
					}
				}
			}else if(record.processStatus=="2"){
				e.rowCls = "processStatus_2_qr";
			}else if(record.processStatus=="3"){
				e.rowCls = "processStatus_3_qr";
			}else if(record.processStatus=="4"){
				e.rowCls = "processStatus_4_qr";
			}else if(record.processStatus=="5"){
				e.rowCls = "processStatus_5_qr";
			}else if(record.processStatus=="6"){
				e.rowCls = "processStatus_6_qr";
			}
		}else{
		    //指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
			if(record.processStatus=="-2"){
				e.rowCls = "processStatus_-2_qr1";
				
				//若当前用户有权限处理该指令/建议单，则该指令/建议单使用特定背景色显示（交易员填单修改权限）
				if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
					var hasPermission = false;//是否有权限，默认无
					var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
					for(var i=0; i<tradingConfirmAuthorityUserIdsArr.length; i++){
						var userIdTemp = tradingConfirmAuthorityUserIdsArr[i];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
					if(hasPermission==true){
						e.rowCls = "processStatus_wait_confirm1";
					}
				}
			}else if(record.processStatus=="-1"){
				e.rowCls = "processStatus_-1_qr1";
			}else if(record.processStatus=="0"){
				e.rowCls = "processStatus_0_qr1";
			}else if(record.processStatus=="1"){
				e.rowCls = "processStatus_1_qr1";
				
				//若当前用户有权限处理该指令/建议单，则该指令/建议单使用特定背景色显示（投资经理下单确认权限）
				var userIdRelaType02 = record.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
				if(userIdRelaType02!=null && userIdRelaType02!=""){
					var hasPermission = false;
					var userIdRelaType02Arr = userIdRelaType02.split(",");
					for(var i=0; i<userIdRelaType02Arr.length; i++){
						var userIdTemp = userIdRelaType02Arr[i];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
					if(hasPermission==true){
						e.rowCls = "processStatus_wait_confirm1";
					}
				}
			}else if(record.processStatus=="2"){
				e.rowCls = "processStatus_2_qr1";
			}else if(record.processStatus=="3"){
				e.rowCls = "processStatus_3_qr1";
			}else if(record.processStatus=="4"){
				e.rowCls = "processStatus_4_qr1";
			}else if(record.processStatus=="5"){
				e.rowCls = "processStatus_5_qr1";
			}else if(record.processStatus=="6"){
				e.rowCls = "processStatus_6_qr1";
			}
		}
	  } 
    }
    
    //行双击时弹出页面展示该指令/建议详细信息--所有业务通用
    function rowdblclickFun(jspUrl, title, width, height, e, grid_confirm, editJspUrl) {
        var row = e.record;//行对象值
        if (row) {
        	
        	var processStatus = row.processStatus;//指令/建议流程处理状态
        	var validStatus = row.validStatus;//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
        	//判断是否有修改权限开始...
        	var hasPermission = false;//是否有权限，默认无
			if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
				var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
				for(var i=0; i<tradingConfirmAuthorityUserIdsArr.length; i++){
					var userIdTemp = tradingConfirmAuthorityUserIdsArr[i];
					if(userIdTemp==userId){
						hasPermission = true;
						break;
					}
				}
			}
			//判断是否有修改权限结束!!!
			
			//若是1.指令/建议询价阶段（processStatus=="-2"）;2.有效指令/建议;3.有权限修改;则直接打开编辑页面
			if(processStatus=="-2" && (validStatus=="0"||validStatus=="3") && hasPermission==true){
				nui.open({
	                url: "<%=request.getContextPath()%>/ProductProcess/"+editJspUrl,
	                title: title,
	                width: width,
	                height: height,
	                onload: function () {
	                    var iframe = this.getIFrameEl();
	                    var data = {pageType:"edit",roleType:"JYY",record:{cfjyproductprocess:row}};
	                    //直接从页面获取，不用去后台获取
	                    iframe.contentWindow.setFormData(data);
	                },
	                ondestroy: function (action) {
	                    grid_confirm.reload();
	                }
	            });
				
			//打开确认界面
			}else{
				nui.open({
	                url: "<%=request.getContextPath()%>/ProductProcess/"+jspUrl,
	                title: title,
	                width: width,
	                height: height,
	                onload: function () {
	                    var iframe = this.getIFrameEl();
	                    var data = {pageType:"confirm",roleType:"JYY",record:{cfjyproductprocess:row}};
	                    //直接从页面获取，不用去后台获取
	                    iframe.contentWindow.setFormData(data);
	                },
	                ondestroy: function (action) {//弹出页面关闭前
	                	if(action=="confirmSuccess"){//若是确认，则刷新页面
	                		grid_confirm.reload();
	                	}
			        }
	            });
			}
        }
    }
    
    //查询--所有业务通用
	function search(grid_search, form_id) {
		//获取之前选中记录的主键ID，刷新后继续选中之前记录
		var rows_search = grid_search.getSelecteds();
		var rowIds_search = "";
		for(var i=0; i<rows_search.length; i++){
			rowIds_search += rows_search[i].processId;
			if(i<rows_search.length-1){
				rowIds_search += ",";
			}
		}
		//开始查找记录
	    var form = new nui.Form(form_id);
	    var json = form.getData(false,false);
	    grid_search.load(json,function(){
	    	//选中刷新前选中的记录
	    	var rows = grid_search.findRows(function (row) {
	    		var exist = false;
	    		if(rowIds_search!=null && rowIds_search!=""){
	    			var rowIdsArr = rowIds_search.split(",");
	    			for(var i=0; i<rowIdsArr.length; i++){
	    				if (row.processId == rowIdsArr[i]){
		                	exist = true;
		                	break;
		                }
	    			}
	    		}
	    		return exist;
            });
            grid_search.selects(rows);
	    });//grid查询
	}
	
	//编辑--所有业务通用
    function edit(jspUrl, title, width, height, grid) {
        var row = grid.getSelected();
        if (row) {
        	//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
        	var validStatus = row.validStatus;
        	if(validStatus=="1" || validStatus=="2" || validStatus=="4" ){
        		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
        		return;
        	}
        	
        	//判断是否有修改权限开始...
        	var hasPermission = false;//是否有权限，默认无
			if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
				var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
				for(var i=0; i<tradingConfirmAuthorityUserIdsArr.length; i++){
					var userIdTemp = tradingConfirmAuthorityUserIdsArr[i];
					if(userIdTemp==userId){
						hasPermission = true;
						break;
					}
				}
			}
			if(hasPermission==false){
				nui.alert("您没有权限修改该指令/建议","提示");
				return;
			}
			//判断是否有修改权限结束!!!
        	
        	//“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
        	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
        	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
        	var processStatus = row.processStatus;
        	var msg = "";
        	
        	if(processStatus=="-2"){
        	}else if(processStatus=="-1"){
        		msg = "该指令/建议已补齐，确定要继续修改吗？";
        	}else if(processStatus=="0"){
        		msg = "该指令/建议已录入，确定要继续修改吗？";
        	}else if(processStatus=="1"){
        		msg = "该指令/建议已确认，确定要继续修改吗？";
        	}else if(processStatus=="2"){
        		msg = "该指令/建议投资经理已下单，确定要继续修改吗？";
        	}else if(processStatus=="3"){
        		msg = "该指令/建议交易员已填单，确定要继续修改吗？";
        	}else if(processStatus=="4"){
        		msg = "该指令/建议交易已发送，确定要继续修改吗？";
        	}else if(processStatus=="5"){
        		msg = "该指令/建议前台已成交，您不能再修改";
        	}else if(processStatus=="6"){
        		msg = "该指令/建议后台已成交，不能再做任何操作";
        	}
        	
        	
        	//“-2-指令/建议询价录入完成”阶段的记录直接修改
        	if(processStatus=="-2"){
        		nui.open({
	                url: "<%=request.getContextPath()%>/ProductProcess/"+jspUrl,
	                title: title,
	                width: width,
	                height: height,
	                onload: function () {
	                    var iframe = this.getIFrameEl();
	                    var data = {pageType:"edit",roleType:"JYY",record:{cfjyproductprocess:row}};
	                    //直接从页面获取，不用去后台获取
	                    iframe.contentWindow.setFormData(data);
	                },
	                ondestroy: function (action) {
	                    grid.reload();
	                }
	            });
        		
        	}else if(processStatus=="-1" || processStatus=="0" || processStatus=="1" || processStatus=="2" || processStatus=="3" || processStatus=="4"){
        		nui.confirm(msg,"系统提示",function(action){
					if(action=="ok"){
						nui.open({
			                url: "<%=request.getContextPath()%>/ProductProcess/"+jspUrl,
			                title: title,
			                width: width,
			                height: height,
			                onload: function () {
			                    var iframe = this.getIFrameEl();
			                    var data = {pageType:"edit",roleType:"JYY",record:{cfjyproductprocess:row}};
			                    //直接从页面获取，不用去后台获取
			                    iframe.contentWindow.setFormData(data);
			                },
			                ondestroy: function (action) {
			                    grid.reload();
			                }
			           });
					}
				});
        	}else if(processStatus=="5" || processStatus=="6"){
        		nui.alert(msg,"提示");
        		return;
        	}
        	
         } else {
			nui.alert("请选中一条记录","提示");
         }
    }
    
    //确认--所有业务通用
	function confirm(grid_confirm){
	    var rows = grid_confirm.getSelecteds();
	    if(rows.length > 0){
	    
	    	//确认记录等于1时
	    	if(rows.length==1){
	    		//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
	        	var validStatus = rows[0].validStatus;
	        	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
	        		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
	        		return;
	        	}
	        	if(validStatus=="3"){
	        		nui.alert("该指令/建议已退回，您不能再确认","提示");
	        		return;
	        	}
	        	
	        	var jsonStatus = nui.encode({cfjyproductprocess:{processId:rows[0].processId}});
	        	$.ajax({
	                url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProcessStatus.biz.ext",
	                type:'POST',
	                data:jsonStatus,
	                cache:false,
	                contentType:'text/json',
	                success:function(text){
	                    var returnJsonStatus = nui.decode(text);
	                    
	                    //“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
			        	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
			        	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
			        	var processStatus = returnJsonStatus.processStatus;
			        	
			        	
			        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
			        		nui.alert("该指令/建议尚未确认，您还不能处理","提示");
	        				return;
			        	
			        	//投资经理下单操作权限认证
			        	}else if(processStatus=="1"){
			        		//若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
			        		var hasPermission = false;//是否有权限，默认无
							var userIdRelaType02 = rows[0].userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
							if(userIdRelaType02!=null && userIdRelaType02!=""){
								var userIdRelaType02Arr = userIdRelaType02.split(",");
								for(var i=0; i<userIdRelaType02Arr.length; i++){
									var userIdTemp = userIdRelaType02Arr[i];
									if(userIdTemp==userId){
										hasPermission = true;
										break;
									}
								}
							}
							if(hasPermission==false){
								nui.alert("您没有权限确认该指令/建议","提示");
	    						return;
							}
						
						//交易确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
			        	}else if(processStatus=="2" || processStatus=="3" || processStatus=="4"){
			        		var hasPermission = false;//是否有权限，默认无
							if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
								var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
								for(var i=0; i<tradingConfirmAuthorityUserIdsArr.length; i++){
									var userIdTemp = tradingConfirmAuthorityUserIdsArr[i];
									if(userIdTemp==userId){
										hasPermission = true;
										break;
									}
								}
							}
							if(hasPermission==false){
								nui.alert("您没有权限确认该指令/建议","提示");
	    						return;
							}
			        	
			        	//后台已成交确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
			        	}else if(processStatus=="5"){
			        		var hasPermission = false;//是否有权限，默认无
							if(backstageConfirmAuthorityUserIds!=null && backstageConfirmAuthorityUserIds!=""){
								var backstageConfirmAuthorityUserIdsArr = backstageConfirmAuthorityUserIds.split(",");
								for(var i=0; i<backstageConfirmAuthorityUserIdsArr.length; i++){
									var userIdTemp = backstageConfirmAuthorityUserIdsArr[i];
									if(userIdTemp==userId){
										hasPermission = true;
										break;
									}
								}
							}
							if(hasPermission==false){
								nui.alert("您没有权限确认该指令/建议","提示");
	    						return;
							}
			        	}
			        	
			        	
			        	var msg = "";
			        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
			        		nui.alert("该指令/建议尚未确认，您还不能处理","提示");
	        				return;
			        	}else if(processStatus=="1"){
			        		msg = "该指令/建议现为确认完成阶段，确定要继续确认吗？";
			        	}else if(processStatus=="2"){
			        		msg = "该指令/建议现为投资经理下单完成阶段，确定要继续确认吗？";
			        	}else if(processStatus=="3"){
			        		msg = "该指令/建议现为交易员填单完成阶段，确定要继续确认吗？";
			        	}else if(processStatus=="4"){
			        		msg = "该指令/建议现为交易已发送阶段，确定要继续确认吗？";
			        	}else if(processStatus=="5"){
			        		msg = "该指令/建议现为前台已成交阶段，确定要继续确认吗？";
			        	}else if(processStatus=="6"){
			        		nui.alert("该指令/建议后台已成交，不能再做任何操作","提示");
			        		return;
			        	}
				    
				        nui.confirm(msg,"系统提示",
				        function(action){
				            if(action=="ok"){
				            	
				            	//提交之前再次实时查询指令/建议单有效状态，避免用户在操作界面停留时间太长导致界面数据状态与数据库不一致
				            	var jsonValidStatus = nui.encode({cfjyproductprocess:{processId:rows[0].processId}});
							  	$.ajax({
							          url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getValidStatus.biz.ext",
							          type:'POST',
							          data:jsonValidStatus,
							          cache:false,
							          contentType:'text/json',
							          success:function(text){
							              var returnJsonValidStatus = nui.decode(text);
							              //交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
							              var returnValidStatus = returnJsonValidStatus.validStatus;
							              
							              //若指令/建议单有效，则继续执行
							              if(returnValidStatus=="0"){
							              
							              	  	//封装主键ID、指令/建议流程处理状态字段传输到后台处理
							                    var json = nui.encode({cfjyproductprocesss:[{processId:rows[0].processId, processStatus:processStatus}]});
								                grid_confirm.loading("正在确认中,请稍等...");
								                $.ajax({
								                    url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.confirmCFJYProductProcesss.biz.ext",
								                    type:'POST',
								                    data:json,
								                    cache: false,
								                    contentType:'text/json',
								                    success:function(text){
								                        var returnJson = nui.decode(text);
								                        if(returnJson.exception == null){
								                        	var validStr = returnJson.validStr;//有效指令/建议单字符串
								                        	var invalidStr = returnJson.invalidStr;//无效指令/建议单字符串
								                        	var validCount = returnJson.validCount;//有效指令/建议单记录数
								                        	var invalidCount = returnJson.invalidCount;//无效指令/建议单记录数
								                        	var msg = "";
								                        	if(validCount!=null && validCount!="" && validCount!="0"){
								                        		msg = "确认成功 " + validCount + " 条";
								                        	}
								                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
								                        		if(msg!=null && msg!=""){
								                        			msg += "；";
								                        		}
								                        		msg += "确认失败 " + invalidCount + " 条，产品名称为【" + invalidStr + "】";
								                        	}
								                            grid_confirm.reload();
								                            nui.alert(msg, "系统提示", function(action){
								                            });
								                        }else{
							                                grid_confirm.unmask();
							                                nui.alert("确认失败", "系统提示");
								                        }
								                    }
								                });
							              }else if(returnValidStatus=="3"){
							              	  grid_confirm.reload();
											  nui.alert("该指令/建议已退回，您不能再确认","提示");
											  return;
							              }else{
							              	  grid_confirm.reload();
											  nui.alert("该指令/建议已无效，不能再做任何操作","提示");
	        								  return;
							              }
							          }
							      });
				             }
				        });
	                }
	            });
	    	
	    	//确认记录大于1时
	    	}else{
	    		
	    		//有效无效验证开始...
	    		var validStr = "";//有效无效验证字符串
	    		for(var i=0; i<rows.length; i++){
	    			var record = rows[i];//产品记录
	    			var combProductName = record.combProductName;//产品名称
	    			var investProductNum = record.investProductNum;//编号
		        	var validStatus = record.validStatus;//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
		        	if(validStatus!="0"){
		        		validStr += "、" + investProductNum + "-" + combProductName;
		        	}
	    		}
	    		if(validStr!=null && validStr!="" && validStr.length>0){
	    			validStr = validStr.substr(1,validStr.length);
	    			var msg = "【"+validStr+"】</br>指令/建议已无效或退回，请先剔除";
	    			nui.alert(msg,"提示");
	    			return;
	    		}
	    		//有效无效验证结束!!!
	    		
	    		
	    		//权限验证开始...
	    		var permissionStr = "";//权限验证字符串
	    		for(var i=0; i<rows.length; i++){
	    			var record = rows[i];//产品记录
	    			var combProductName = record.combProductName;//产品名称
	    			var investProductNum = record.investProductNum;//编号
		        	var processStatus = record.processStatus;//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
		        	
		        	//投顾尚未确认
		        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
		        		permissionStr += "、" + investProductNum + "-" + combProductName;
		        	
		        	//投资经理下单操作权限认证
		        	}else if(processStatus=="1"){
		        		//若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
		        		var hasPermission = false;//是否有权限，默认无
						var userIdRelaType02 = record.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
						if(userIdRelaType02!=null && userIdRelaType02!=""){
							var userIdRelaType02Arr = userIdRelaType02.split(",");
							for(var j=0; j<userIdRelaType02Arr.length; j++){
								var userIdTemp = userIdRelaType02Arr[j];
								if(userIdTemp==userId){
									hasPermission = true;
									break;
								}
							}
						}
						if(hasPermission==false){
							permissionStr += "、" + investProductNum + "-" + combProductName;
						}
						
					//交易确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
		        	}else if(processStatus=="2" || processStatus=="3" || processStatus=="4"){
		        		var hasPermission = false;//是否有权限，默认无
						if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
							var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
							for(var j=0; j<tradingConfirmAuthorityUserIdsArr.length; j++){
								var userIdTemp = tradingConfirmAuthorityUserIdsArr[j];
								if(userIdTemp==userId){
									hasPermission = true;
									break;
								}
							}
						}
						if(hasPermission==false){
							permissionStr += "、" + investProductNum + "-" + combProductName;
						}
		        	
		        	//后台已成交确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
		        	}else if(processStatus=="5"){
		        		var hasPermission = false;//是否有权限，默认无
						if(backstageConfirmAuthorityUserIds!=null && backstageConfirmAuthorityUserIds!=""){
							var backstageConfirmAuthorityUserIdsArr = backstageConfirmAuthorityUserIds.split(",");
							for(var j=0; j<backstageConfirmAuthorityUserIdsArr.length; j++){
								var userIdTemp = backstageConfirmAuthorityUserIdsArr[j];
								if(userIdTemp==userId){
									hasPermission = true;
									break;
								}
							}
						}
						if(hasPermission==false){
							permissionStr += "、" + investProductNum + "-" + combProductName;
						}
		        	}
	    		}
	    		if(permissionStr!=null && permissionStr!="" && permissionStr.length>0){
	    			permissionStr = permissionStr.substr(1,permissionStr.length);
	    			var msg = "您没有权限确认【"+permissionStr+"】指令/建议，请先剔除";
	    			nui.alert(msg,"提示");
	    			return;
	    		}
	    		//权限验证结束!!!
	    		
	    		
	    		
	    		
	    		//封装主键ID字段传输到后台处理开始...
	    		var processIdArr = new Array();
	    		for(var i=0; i<rows.length; i++){
	    			var record = rows[i];//产品记录
	    			var processIdTemp = {processId: record.processId};//封装指令/建议单主键ID
	    			processIdArr.push(processIdTemp);
	    		}
	    		
	    		var msg = "确定要确认所选的 " + rows.length + " 条指令/建议吗？";
	    		nui.confirm(msg,"系统提示",function(action){
					if(action=="ok"){
		                var json = nui.encode({cfjyproductprocesss: processIdArr});
		                grid_confirm.loading("正在确认中,请稍等...");
		                $.ajax({
		                    url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.confirmCFJYProductProcesss.biz.ext",
		                    type:'POST',
		                    data:json,
		                    cache: false,
		                    contentType:'text/json',
		                    success:function(text){
		                        var returnJson = nui.decode(text);
		                        if(returnJson.exception == null){
		                        	var validStr = returnJson.validStr;//有效指令/建议单字符串
		                        	var invalidStr = returnJson.invalidStr;//无效指令/建议单字符串
		                        	var validCount = returnJson.validCount;//有效指令/建议单记录数
		                        	var invalidCount = returnJson.invalidCount;//无效指令/建议单记录数
		                        	var msg = "";
		                        	if(validCount!=null && validCount!="" && validCount!="0"){
		                        		msg = "确认成功 " + validCount + " 条";
		                        	}
		                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
		                        		if(msg!=null && msg!=""){
		                        			msg += "；";
		                        		}
		                        		msg += "确认失败 " + invalidCount + " 条，产品名称为【" + invalidStr + "】";
		                        	}
		                            grid_confirm.reload();
		                            nui.alert(msg, "系统提示", function(action){
		                            });
		                        }else{
		                            grid_confirm.unmask();
		                            nui.alert("确认失败", "系统提示");
		                        }
		                    }
		                });
					}
				});
	    		//封装主键ID字段传输到后台处理结束!!!
	    		
	    	}
	    }else{
	        nui.alert("请先选中指令/建议！");
	    }
	}
	
	//退回--所有业务通用
	function goBack(grid_goBack){
	    var rows = grid_goBack.getSelecteds();
	    if(rows.length > 0){
	    
    		//有效无效验证开始...
    		var validStr = "";//有效无效验证字符串
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];//产品记录
    			var combProductName = record.combProductName;//产品名称
    			var investProductNum = record.investProductNum;//编号
	        	var validStatus = record.validStatus;//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
	        	if(validStatus!="0"){
	        		validStr += "、" + investProductNum + "-" + combProductName;
	        	}
    		}
    		if(validStr!=null && validStr!="" && validStr.length>0){
    			validStr = validStr.substr(1,validStr.length);
    			var msg = "【"+validStr+"】</br>指令/建议已无效或退回，请先剔除";
    			nui.alert(msg,"提示");
    			return;
    		}
    		//有效无效验证结束!!!
    		
    		
    		//权限验证开始...
    		var goBackStr = "";//该阶段不能退回字符串
    		var permissionStr = "";//权限验证字符串
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];//产品记录
    			var combProductName = record.combProductName;//产品名称
    			var investProductNum = record.investProductNum;//编号
	        	var processStatus = record.processStatus;//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
	        	
	        	//投顾尚未确认
	        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
	        		goBackStr += "、" + investProductNum + "-" + combProductName;
	        	
	        	//投资经理下单操作权限认证
	        	}else if(processStatus=="1"){
	        		//若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
	        		var hasPermission = false;//是否有权限，默认无
					var userIdRelaType02 = record.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
					if(userIdRelaType02!=null && userIdRelaType02!=""){
						var userIdRelaType02Arr = userIdRelaType02.split(",");
						for(var j=0; j<userIdRelaType02Arr.length; j++){
							var userIdTemp = userIdRelaType02Arr[j];
							if(userIdTemp==userId){
								hasPermission = true;
								break;
							}
						}
					}
					if(hasPermission==false){
						permissionStr += "、" + investProductNum + "-" + combProductName;
					}
				//投资经理下单已确认
	        	}else{
	        		goBackStr += "、" + investProductNum + "-" + combProductName;
	        	}
    		}
    		if(goBackStr!=null && goBackStr!="" && goBackStr.length>0){
    			goBackStr = goBackStr.substr(1,goBackStr.length);
    			var msg = "【"+goBackStr+"】</br>指令/建议尚未确认或投资经理已下单，请先剔除";
    			nui.alert(msg,"提示");
    			return;
    		}
    		if(permissionStr!=null && permissionStr!="" && permissionStr.length>0){
    			permissionStr = permissionStr.substr(1,permissionStr.length);
    			var msg = "您没有权限退回【"+permissionStr+"】指令/建议，请先剔除";
    			nui.alert(msg,"提示");
    			return;
    		}
    		//权限验证结束!!!
    		
    		
    		
    		
    		//封装主键ID字段传输到后台处理开始...
    		var processIdArr = new Array();
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];//产品记录
    			var processIdTemp = {processId: record.processId};//封装指令/建议单主键ID
    			processIdArr.push(processIdTemp);
    		}
    		
    		var msg = "确定要退回所选的 " + rows.length + " 条指令/建议吗？";
    		nui.confirm(msg,"系统提示",function(action){
				if(action=="ok"){
	                var json = nui.encode({cfjyproductprocesss: processIdArr, validStatus: "3"});
	                grid_goBack.loading("正在退回中,请稍等...");
	                $.ajax({
	                    url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.updateValidStatus.biz.ext",
	                    type:'POST',
	                    data:json,
	                    cache: false,
	                    contentType:'text/json',
	                    success:function(text){
	                        var returnJson = nui.decode(text);
	                        if(returnJson.exception == null){
	                            grid_goBack.reload();
	                            nui.alert("退回成功", "系统提示", function(action){
	                            });
	                        }else{
	                            grid_goBack.unmask();
	                            nui.alert("退回失败", "系统提示");
	                        }
	                    }
	                });
				}
			});
    		//封装主键ID字段传输到后台处理结束!!!
	    		
	    }else{
	        nui.alert("请先选中指令/建议！");
	    }
	}
	
	//保存--所有业务通用
	function save(save_grid, save_url, form_id){
		var grid_data = new Array();
		var changeDatas = save_grid.getChanges();
		for(var i=0; i<changeDatas.length; i++){
			var processId = changeNull(changeDatas[i].processId);//主键ID
			var clordId = changeNull(changeDatas[i].clordid);
			var backstageTraderStatus = changeNull(changeDatas[i].backstageTraderStatus);//后台成交状态
			var backstageTraderRemark = changeNull(changeDatas[i].backstageTraderRemark);//后台成交情况备注
			var tempObj = {processId:processId,clordId:clordId,backstageTraderStatus:backstageTraderStatus,backstageTraderRemark:backstageTraderRemark};
            grid_data.push(tempObj);
		}
        save_grid.loading("保存中，请稍后......");
        $.ajax({
            url: save_url,
            data: nui.encode({dataObjects: grid_data}),
            type: 'POST',
            cache: false,
            contentType:'text/json',
            success: function (text) {
                search(save_grid, form_id);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                nui.alert(jqXHR.responseText, "系统提示");
            }
        });
	}
	
	
	//当选择列时--所有业务通用
    function selectionChanged(grid, confirmCmpId, updateCmpId){
        var rows = grid.getSelecteds();
        if(rows.length>1){
            //nui.get(confirmCmpId).disable();
            if(updateCmpId!=null && updateCmpId!=""){
            	nui.get(updateCmpId).disable();
            }
        }else{
            //nui.get(confirmCmpId).enable();
            if(updateCmpId!=null && updateCmpId!=""){
            	nui.get(updateCmpId).enable();
            }
        }
    }
    
    //债券类别--所有业务通用
	function renderInvestCategory(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_BOND_CATEGORY",e.row.investCategory);
	}
	//主体评级--所有业务通用
	function renderSubjectRating(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_SUBJECT_RATING",e.row.subjectRating);
	}
	//债券评级--所有业务通用
	function renderBondRating(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_BOND_RATING",e.row.bondRating);
	}
	//清算速度--所有业务通用
	function renderClearingSpeed(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_CLEARING_SPEED",e.row.clearingSpeed);
	}
	//清算类型--所有业务通用
	function renderClearType(e){
	    return nui.getDictText("CF_JY_PRODUCT_PROCESS_CLEAR_TYPE",e.row.cleartype);
	}
	//交易场所--所有业务通用
	function renderTradingPlace(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_TRADING_PLACE",e.row.tradingPlace);
	}
	//收益率类型--所有业务通用
	function renderInterestRateType(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_INTEREST_RATE_TYPE",e.row.interestRateType);
	}
    //评级机构--所有业务通用
	function renderRatingAgencies(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_RATING_AGENCIES",e.row.ratingAgencies);
	}
	//缴款场所--所有业务通用
	function renderPaymentPlace(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_PAYMENT_PLACE",e.row.paymentPlace);
	}
	//提前支取条款--所有业务通用
	function renderEarlyWithdrawalClause(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_EARLY_WITHDRAWAL_CLAUSE",e.row.earlyWithdrawalClause);
	}
	//要求到账时间--所有业务通用
	function renderDemandArrivalTime(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_DEMAND_ARRIVAL_TIME",e.row.demandArrivalTime);
	}
	//买卖方向处理--所有业务通用
	function renderDeliveryMethod(e) {
		return nui.getDictText("CF_JY_MMFX",e.row.deliveryMethod);
	}
	
    //业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;16-交易所协议正回购;17-交易所协议逆回购;21-交易所正回购；22-交易所逆回购；99-其他指令/建议;
    function renderProcessType(e) {
    	var processType = "";
    	if(e.row.processType=="01" || e.row.processType=="02"){
    		processType = nui.getDictText("CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQMM",e.row.processType);
    	}else if(e.row.processType=="03" || e.row.processType=="04" || e.row.processType=="05" || e.row.processType=="06" || e.row.processType=="16" || e.row.processType=="17" || e.row.processType=="21" || e.row.processType=="22"){
    		processType = nui.getDictText("CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZNHG",e.row.processType);
    	}else if(e.row.processType=="07" || e.row.processType=="08"){
    		processType = nui.getDictText("CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQSJ",e.row.processType);
    	}else if(e.row.processType=="09" || e.row.processType=="10" || e.row.processType=="11" || e.row.processType=="18"){
    		processType = nui.getDictText("CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_JJSS",e.row.processType);
    	}
		return processType;
	}
	//交易状态处理--所有业务通用
	function renderValidStatus(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_VALID_STATUS",e.row.validStatus);
	}
	//指令/建议询价列处理--所有业务通用
	function renderInquiry(e){
		if(e.row.inquiryName!=null || e.row.inquiryCd!=null){
			return (e.row.inquiryName==null?"":e.row.inquiryName) + "　" + nui.formatDate(e.row.inquiryCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//指令/建议补齐列处理--所有业务通用
	function renderCompleteInstructions(e){
		if(e.row.completeInstructionsName!=null || e.row.completeInstructionsCd!=null){
			return (e.row.completeInstructionsName==null?"":e.row.completeInstructionsName) + "　" + nui.formatDate(e.row.completeInstructionsCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//指令/建议录入列处理--所有业务通用
	function renderInvestAdviser(e){
		if(e.row.investAdviserName!=null || e.row.investAdviserCd!=null){
			return (e.row.investAdviserName==null?"":e.row.investAdviserName) + "　" + nui.formatDate(e.row.investAdviserCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//指令/建议确认列处理--所有业务通用
	function renderInvestAdviserConfirm(e){
		if(e.row.investAdviserConfirmName!=null || e.row.investAdviserConfirmCd!=null){
			return (e.row.investAdviserConfirmName==null?"":e.row.investAdviserConfirmName) + "　" + nui.formatDate(e.row.investAdviserConfirmCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	
	//复核人
	function renderEntrust(e){
	    if(e.row.entrustName!=null||e.row.entrustCd!=null){
	        return  (e.row.entrustName==null?"":e.row.entrustName) + "　" + nui.formatDate(e.row.entrustCd, "yyyy-MM-dd HH:mm:ss");
	    }else{
			return "";
		}
	}
	
	//投资经理下单列处理--所有业务通用
	function renderInvestManager(e){
		if(e.row.investManagerName!=null || e.row.investManagerCd!=null){
			return (e.row.investManagerName==null?"":e.row.investManagerName) + "　" + nui.formatDate(e.row.investManagerCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//交易员填单列处理--所有业务通用
	function renderTrader(e){
		if(e.row.traderName!=null || e.row.traderCd!=null){
			return (e.row.traderName==null?"":e.row.traderName) + "　" + nui.formatDate(e.row.traderCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//交易已发送列处理--所有业务通用
	function renderReview(e){
		if(e.row.reviewName!=null || e.row.reviewCd!=null){
			return (e.row.reviewName==null?"":e.row.reviewName) + "　" + nui.formatDate(e.row.reviewCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//前台已成交列处理--所有业务通用
	function renderSend(e){
		if(e.row.sendName!=null || e.row.sendCd!=null){
			return (e.row.sendName==null?"":e.row.sendName) + "　" + nui.formatDate(e.row.sendCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//后台已成交列处理--所有业务通用
	function renderBackstageTrader(e){
		if(e.row.backstageTraderName!=null || e.row.backstageTraderCd!=null){
			return (e.row.backstageTraderName==null?"":e.row.backstageTraderName) + "　" + nui.formatDate(e.row.backstageTraderCd, "yyyy-MM-dd HH:mm:ss");
		}else{
			return "";
		}
	}
	//后台成交状态--所有业务通用
	function renderBackstageTraderStatus(e){
		return nui.getDictText("CF_JY_HTCJZT",e.row.backstageTraderStatus);
	}
	//展示详细行数据--所有业务通用
	function onShowRowDetail(e) {
		var grid = e.sender;//获取表格
	    var row = e.record;//获取行数据
	    var remark = changeNull(row.remark);//备注信息
	    var earlyWithdrawalClause = changeNull(row.earlyWithdrawalClause);//执行备注信息
	    var abandonedReasons = changeNull(row.abandonedReasons);//废弃原因
	    var inquiryMd = nui.formatDate(row.inquiryMd, "yyyy-MM-dd HH:mm:ss");//指令/建议询价修改、废弃时间
	    var investAdviserMd = nui.formatDate(row.investAdviserMd, "yyyy-MM-dd HH:mm:ss");//指令/建议录入修改、废弃时间	    
	    var completeInstructionsMd = nui.formatDate(row.completeInstructionsMd, "yyyy-MM-dd HH:mm:ss");//指令/建议补齐修改时间
	    var mdTime =  completeInstructionsMd==null||completeInstructionsMd==""?(inquiryMd==null||inquiryMd==""?investAdviserMd:inquiryMd):completeInstructionsMd;//修改、废弃时间，交易员填单指令/建议补齐修改时间优先级最高
	    
	    var td = grid.getRowDetailCellEl(row);
		var html = "<table style='width:100%;'>";
		if(mdTime!=null && mdTime!=""){
			html +=" <tr>"
				 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>修改废弃时间：</td>"
				 + "  <td>" + mdTime + "</td>"
				 + " </tr>";
		}
		if(abandonedReasons!=null && abandonedReasons!=""){
			html +=" <tr>"
				 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>废弃原因：</td>"
				 + "  <td>" + abandonedReasons + "</td>"
				 + " </tr>";
		}
		if(remark!=null && remark!=""){
			html +=" <tr>"
				 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>备注信息：</td>"
				 + "  <td>" + remark + "</td>"
				 + " </tr>";
		}
		if(earlyWithdrawalClause!=null && earlyWithdrawalClause!=""){
			html +=" <tr>"
				 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>执行备注信息：</td>"
				 + "  <td>" + earlyWithdrawalClause + "</td>"
				 + " </tr>";
		}
		html += "</table>";
		
		td.innerHTML = html;
	}
	
	//tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	function activechangedFun(){
		//标签切换时同时刷新“今日待处理”，模块数据
		reloadWaitConfirmFun();
	
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tab").getActiveTab().title;
		
		if(activeTabTitle.indexOf("债券买卖")!=-1){
			search_ZQMM();
			
		}else if(activeTabTitle.indexOf("正逆回购")!=-1){
			search_ZNHG();
			
		}else if(activeTabTitle.indexOf("申购缴款")!=-1){
			search_ZQSJ();
			
		}else if(activeTabTitle.indexOf("基金申赎")!=-1){
			search_JJSS();
			
		}else if(activeTabTitle.indexOf("其他指令/建议")!=-1){
			search_QTZL();
		
		}else if(activeTabTitle.indexOf("投票")!=-1){
			search_TP();
		
		}else if(activeTabTitle.indexOf("大宗交易")!=-1){
			search_DZJY();
		
		}
	}
	
	//跨页多选选择表格获取基金产品--所有业务通用
	function ButtonClickGetFundNameCommon(e){
	    ButtonClickGetFundName(this, "All");
	}
	
	
    
    
    
    <%-- 债券买卖业务 --%>
    var grid_ZQMM = nui.get("datagrid_ZQMM");
    var formData_ZQMM = new nui.Form("#form_ZQMM").getData(false,false);
    grid_ZQMM.load(formData_ZQMM);
    //表格行增加背景色
    grid_ZQMM.on("drawcell", function (e) {
    	drawcellFun(e);
	});
	//行双击时弹出页面展示该指令/建议详细信息
    grid_ZQMM.on("rowdblclick", function (e) {
    	rowdblclickFun_common_confirm_ZQMM("JY_ZQMM/CFJYProductProcessForm_show_ZQMM.jsp", "债券买卖明细展示", 700, 520, e, grid_ZQMM, "JY_ZQMM/CFJYProductProcessForm_ZQMM.jsp");
    });
    //编辑
    function edit_ZQMM() {
    	edit_common_confirm_ZQMM("JY_ZQMM/CFJYProductProcessForm_ZQMM.jsp", "债券买卖编辑数据", 700, 520, grid_ZQMM);
    }
	//确认
	function confirm_ZQMM(){
		confirm_common_confirm_ZQMM(grid_ZQMM);
	}
	//退回
	function goBack_ZQMM(){
		goBack_common_confirm_ZQMM(grid_ZQMM);
	}
	//查询
	function search_ZQMM() {
		search(grid_ZQMM, "#form_ZQMM");
	}
    //当选择列时
    function selectionChanged_ZQMM(){
    	selectionChanged(grid_ZQMM, "confirm_ZQMM", "update_ZQMM");
    }
    //保存
	function save_ZQMM(){
		save(grid_ZQMM, "com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_updateBackstageTraderInfoWithFeedback.biz.ext", "#form_ZQMM");
	}
    
    
    
	
	
	<%-- 正逆回购业务 --%>
	var grid_ZNHG = nui.get("datagrid_ZNHG");
    var formData_ZNHG = new nui.Form("#form_ZNHG").getData(false,false);
    //grid_ZNHG.load(formData_ZNHG);
    //表格行增加背景色
    grid_ZNHG.on("drawcell", function (e) {
    	drawcellFun(e);
    });
    //行双击时弹出页面展示该指令/建议详细信息
    grid_ZNHG.on("rowdblclick", function (e) {
    	rowdblclickFun_common_confirm_ZNHG("JY_ZNHG/CFJYProductProcessForm_show_ZNHG.jsp", "正逆回购明细展示", 800, 620, e, grid_ZNHG, "JY_ZNHG/CFJYProductProcessForm_ZNHG.jsp");
    });
    //编辑
    function edit_ZNHG() {
    	edit_common_confirm_ZNHG("JY_ZNHG/CFJYProductProcessForm_ZNHG.jsp", "正逆回购编辑数据", 800, 620, grid_ZNHG);
    }
    //确认
	function confirm_ZNHG(){
		confirm_common_confirm_ZNHG(grid_ZNHG);
	}
	//退回
	function goBack_ZNHG(){
		goBack_common_confirm_ZNHG(grid_ZNHG);
	}
	//查询
	function search_ZNHG() {
		search(grid_ZNHG, "#form_ZNHG");
	}
	//当选择列时
    function selectionChanged_ZNHG(){
    	selectionChanged(grid_ZNHG, "confirm_ZNHG", "update_ZNHG");
    }
    //保存
	function save_ZNHG(){
		save(grid_ZNHG, "com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_updateBackstageTraderInfoWithFeedback.biz.ext", "#form_ZNHG");
	}
    //展示详细行数据
	function onShowRowDetail_ZNHG(e) {
		var grid = e.sender;//获取表格
	    var row = e.record;//获取行数据
	    var remark = changeNull(row.remark);//备注信息
	    var abandonedReasons = changeNull(row.abandonedReasons);//废弃原因
	    var inquiryMd = nui.formatDate(row.inquiryMd, "yyyy-MM-dd HH:mm:ss");//指令/建议询价修改、废弃时间
	    var investAdviserMd = nui.formatDate(row.investAdviserMd, "yyyy-MM-dd HH:mm:ss");//指令/建议录入修改、废弃时间	    
	    var completeInstructionsMd = nui.formatDate(row.completeInstructionsMd, "yyyy-MM-dd HH:mm:ss");//指令/建议补齐修改时间
	    var mdTime =  completeInstructionsMd==null||completeInstructionsMd==""?(inquiryMd==null||inquiryMd==""?investAdviserMd:inquiryMd):completeInstructionsMd;//修改、废弃时间，交易员填单指令/建议补齐修改时间优先级最高
	    
	    //获取债券信息
	    var processIdJson = nui.encode({processId: row.processId});
	    $.ajax({
            url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_queryBondsByProcessId.biz.ext",
            type:'POST',
            data:processIdJson,
            cache: false,
            contentType:'text/json',
            success:function(text){
                var returnJson = nui.decode(text);
                if(returnJson.exception == null){
                    var bonds = returnJson.bonds;
                    var bondStr = "<table>"
                    			+" <tr>"
                    			+"  <td style='width:150px;font-weight:bold;' align='center'>债券代码</td>"
                    			+"  <td style='width:220px;font-weight:bold;' align='center'>债券名称</td>"
                    			+"  <td style='width:120px;font-weight:bold;' align='center'>券面总额（万元）</td>"
                    			+"  <td style='width:120px;font-weight:bold;' align='center'>折算比例（%）</td>"
                    			+"  <td style='width:120px;font-weight:bold;' align='center'>首次净价（元）</td>"
                    			+" </tr>";
                    			
                    for(var i=0; i<bonds.length; i++){
                    	var bondInfo = bonds[i];
                    	bondStr += "<tr><td align='center'>"+changeNull(bondInfo.bondCode)+"</td><td align='center'>"+changeNull(bondInfo.bondName)+"</td><td align='center'>"+changeNull(bondInfo.bondAmount)
                    			+	"</td><td align='center'>"+changeNull(bondInfo.conversionRatio)+"</td><td align='center'>"+changeNull(bondInfo.firstNetValue)+"</td></tr>";
                    }
                    bondStr += "</table>";
                    
                    var td = grid.getRowDetailCellEl(row);
					
					var html = bondStr;
					html += "<table style='width:100%;'>";
					if(mdTime!=null && mdTime!=""){
						html +=" <tr>"
							 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>修改废弃时间：</td>"
							 + "  <td>" + mdTime + "</td>"
							 + " </tr>";
					}
					if(abandonedReasons!=null && abandonedReasons!=""){
						html +=" <tr>"
							 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>废弃原因：</td>"
							 + "  <td>" + abandonedReasons + "</td>"
							 + " </tr>";
					}
					if(remark!=null && remark!=""){
						html +=" <tr>"
							 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>备注信息：</td>"
							 + "  <td>" + remark + "</td>"
							 + " </tr>";
					}
					html += "</table>";
					
					
					td.innerHTML = html;
                    
                }else{
					nui.alert("加载失败", "系统提示");
                }
            }
         });
	}
	
	
    
	
	
	<%-- 申购缴款业务 --%>
	var grid_ZQSJ = nui.get("datagrid_ZQSJ");
    var formData_ZQSJ = new nui.Form("#form_ZQSJ").getData(false,false);
    //grid_ZQSJ.load(formData_ZQSJ);
    //表格行增加背景色
    grid_ZQSJ.on("drawcell", function (e) {
		drawcellFun(e);
	});
	//行双击时弹出页面展示该指令/建议详细信息
    grid_ZQSJ.on("rowdblclick", function (e) {
    	rowdblclickFun("JY_ZQSJ/CFJYProductProcessForm_show_ZQSJ.jsp", "申购缴款明细展示", 700, 450, e, grid_ZQSJ, "JY_ZQSJ/CFJYProductProcessForm_ZQSJ.jsp");
    });
    //确认
	function confirm_ZQSJ(){
		confirm(grid_ZQSJ);
	}
	//退回
	function goBack_ZQSJ(){
		goBack(grid_ZQSJ);
	}
	//查询
	function search_ZQSJ() {
		search(grid_ZQSJ, "#form_ZQSJ");
	}
	//当选择列时
    function selectionChanged_ZQSJ(){
    	selectionChanged(grid_ZQSJ, "confirm_ZQSJ");
    }
	
	
	
	<%-- 基金申赎业务 --%>
	var grid_JJSS = nui.get("datagrid_JJSS");
    var formData_JJSS = new nui.Form("#form_JJSS").getData(false,false);
    //grid_JJSS.load(formData_JJSS);
    //表格行增加背景色
    grid_JJSS.on("drawcell", function (e) {
    	drawcellFun(e);
    });
    //行双击时弹出页面展示该指令/建议详细信息
    grid_JJSS.on("rowdblclick", function (e) {
    	rowdblclickFun("JY_JJSS/CFJYProductProcessForm_show_JJSS.jsp", "基金申赎明细展示", 700, 350, e, grid_JJSS, "JY_JJSS/CFJYProductProcessForm_JJSS.jsp");
    });
    //确认
	function confirm_JJSS(){
		confirm(grid_JJSS);
	}
	//退回
	function goBack_JJSS(){
		goBack(grid_JJSS);
	}
	//查询
	function search_JJSS() {
		search(grid_JJSS, "#form_JJSS");
	}
	//当选择列时
    function selectionChanged_JJSS(){
        selectionChanged(grid_JJSS, "confirm_JJSS");
    }
    
    <%-- 大宗交易业务 --%>
    var grid_DZJY = nui.get("datagrid_DZJY");
    var formData_DZJY = new nui.Form("#form_DZJY").getData(false,false);
    //行双击时弹出页面展示该指令/建议详细信息
    grid_DZJY.on("rowdblclick", function (e) {
    	rowdblclickFun("JY_DZJY/CFJYProductProcessForm_show_DZJY.jsp", "大宗交易明细展示", 600, 380, e, grid_DZJY, "JY_DZJY/CFJYProductProcessForm_DZJY.jsp");
    });
    //表格行增加背景色
    grid_DZJY.on("drawcell", function (e) {
    	drawcellFun(e);
    });
	//确认
	function confirm_DZJY(){
		confirm(grid_DZJY);
	}
	//退回
	function goBack_DZJY(){
		goBack(grid_DZJY);
	} 
    //查询
	function search_DZJY() {
		search(grid_DZJY, "#form_DZJY");
	}
	//当选择列时
	function selectionChanged_DZJY(){
	  selectionChanged(grid_DZJY, "confirm_DZJY");
	}
    
    
    
    <%-- 投票业务 --%>
    var grid_TP = nui.get("datagrid_TP");
    var formData_TP = new nui.Form("#form_TP").getData(false,false);
    //行双击时弹出页面展示该指令/建议详细信息
    grid_TP.on("rowdblclick", function (e) {
    	rowdblclickFun("JY_TP/CFJYProductProcessForm_show_TP.jsp", "投票明细展示", 820, 635, e, grid_TP, "JY_TP/CFJYProductProcessForm_TP.jsp");
    });
    //表格行增加背景色
    grid_TP.on("drawcell", function (e) {
    	drawcellFun(e);
    });
	//确认
	function confirm_TP(){
		confirm(grid_TP);
	}
	//退回
	function goBack_TP(){
		goBack(grid_TP);
	} 
    //查询
	function search_TP() {
		search(grid_TP, "#form_TP");
	}
	//当选择列时
	function selectionChanged_TP(){
	  selectionChanged(grid_TP, "confirm_TP");
	}
	
	
	
	
	<%-- 其他指令/建议业务 --%>
	var grid_QTZL = nui.get("datagrid_QTZL");
    var formData_QTZL = new nui.Form("#form_QTZL").getData(false,false);
    //grid_QTZL.load(formData_QTZL);
    //表格行增加背景色
    grid_QTZL.on("drawcell", function (e) {
    	//drawcellFun(e);
    	var record = e.record;
		//设置行样式，交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
		if(record.validStatus=="1" || record.validStatus=="4"){
			e.rowCls = "validStatus_modify_1_4";
		}else if(record.validStatus=="2"){
			e.rowCls = "validStatus_del_2";
		}else if(record.validStatus=="3"){
			e.rowCls = "validStatus_modify_3";
		}else{
		    //判断指令/建议是否导出过 ：1-已导出过 ，0-未导出过
		  if(record.isNotExport != 1){
			//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
			if(record.processStatus=="-2"){
				e.rowCls = "processStatus_-2_qr";
				
				//若当前用户有权限处理该指令/建议单，则该指令/建议单使用特定背景色显示（交易员填单修改权限）
				if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
					var hasPermission = false;//是否有权限，默认无
					var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
					for(var i=0; i<tradingConfirmAuthorityUserIdsArr.length; i++){
						var userIdTemp = tradingConfirmAuthorityUserIdsArr[i];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
					if(hasPermission==true){
						e.rowCls = "processStatus_wait_confirm";
					}
				}
			}else if(record.processStatus=="-1"){
				e.rowCls = "processStatus_-1_qr";
			}else if(record.processStatus=="0"){
				e.rowCls = "processStatus_0_qr";
			}else if(record.processStatus=="1"){
				e.rowCls = "processStatus_1_qr";
				var userIdRelaTypeA3 = record.userIdRelaTypeA3!=null?record.userIdRelaTypeA3:"";//A3-组合与委托人确认权限
				if(userIdRelaTypeA3==null || userIdRelaTypeA3==""){
					var userIdRelaType02 = record.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
					if(userIdRelaType02!=null && userIdRelaType02!=""){
						var hasPermission = false;
						var userIdRelaType02Arr = userIdRelaType02.split(",");
						for(var i=0; i<userIdRelaType02Arr.length; i++){
							var userIdTemp = userIdRelaType02Arr[i];
							if(userIdTemp==userId){
								hasPermission = true;
								break;
							}
						}
						if(hasPermission==true){
							e.rowCls = "processStatus_wait_confirm";
						}
					}
				}
			}else if(record.processStatus=="7"){
				e.rowCls = "processStatus_1_qr";
				//若当前用户有权限处理该指令/建议单，则该指令/建议单使用特定背景色显示（投资经理下单确认权限）
				var userIdRelaType02 = record.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
				if(userIdRelaType02!=null && userIdRelaType02!=""){
					var hasPermission = false;
					var userIdRelaType02Arr = userIdRelaType02.split(",");
					for(var i=0; i<userIdRelaType02Arr.length; i++){
						var userIdTemp = userIdRelaType02Arr[i];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
					if(hasPermission==true){
						e.rowCls = "processStatus_wait_confirm";
					}
				}
			}else if(record.processStatus=="2"){
				e.rowCls = "processStatus_2_qr";
			}else if(record.processStatus=="3"){
				e.rowCls = "processStatus_3_qr";
			}else if(record.processStatus=="4"){
				e.rowCls = "processStatus_4_qr";
			}else if(record.processStatus=="5"){
				e.rowCls = "processStatus_5_qr";
			}else if(record.processStatus=="6"){
				e.rowCls = "processStatus_6_qr";
			}
		}else{
		    //指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
			if(record.processStatus=="-2"){
				e.rowCls = "processStatus_-2_qr1";
				
				//若当前用户有权限处理该指令/建议单，则该指令/建议单使用特定背景色显示（交易员填单修改权限）
				if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
					var hasPermission = false;//是否有权限，默认无
					var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
					for(var i=0; i<tradingConfirmAuthorityUserIdsArr.length; i++){
						var userIdTemp = tradingConfirmAuthorityUserIdsArr[i];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
					if(hasPermission==true){
						e.rowCls = "processStatus_wait_confirm1";
					}
				}
			}else if(record.processStatus=="-1"){
				e.rowCls = "processStatus_-1_qr1";
			}else if(record.processStatus=="0"){
				e.rowCls = "processStatus_0_qr1";
			}else if(record.processStatus=="7"){
				e.rowCls = "processStatus_1_qr1";
				
				//若当前用户有权限处理该指令/建议单，则该指令/建议单使用特定背景色显示（投资经理下单确认权限）
				var userIdRelaType02 = record.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
				if(userIdRelaType02!=null && userIdRelaType02!=""){
					var hasPermission = false;
					var userIdRelaType02Arr = userIdRelaType02.split(",");
					for(var i=0; i<userIdRelaType02Arr.length; i++){
						var userIdTemp = userIdRelaType02Arr[i];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
					if(hasPermission==true){
						e.rowCls = "processStatus_wait_confirm1";
					}
				}
			}else if(record.processStatus=="2"){
				e.rowCls = "processStatus_2_qr1";
			}else if(record.processStatus=="3"){
				e.rowCls = "processStatus_3_qr1";
			}else if(record.processStatus=="4"){
				e.rowCls = "processStatus_4_qr1";
			}else if(record.processStatus=="5"){
				e.rowCls = "processStatus_5_qr1";
			}else if(record.processStatus=="6"){
				e.rowCls = "processStatus_6_qr1";
			}
		}
	  } 
    });
    //行双击时弹出页面展示该指令/建议详细信息
    grid_QTZL.on("rowdblclick", function (e) {
    	rowdblclickFun("JY_QTZL/CFJYProductProcessForm_show_QTZL.jsp", "其他指令/建议明细展示", 800, 635, e, grid_QTZL, "JY_QTZL/CFJYProductProcessForm_QTZL.jsp");
    });
    //确认
	function confirm_QTZL(){
	
		//confirm(grid_QTZL);
		var rows = grid_QTZL.getSelecteds();
	    if(rows.length > 0){
	    	//确认记录等于1时
	    	if(rows.length==1){
	    		//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
	        	var validStatus = rows[0].validStatus;
	        	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
	        		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
	        		return;
	        	}
	        	if(validStatus=="3"){
	        		nui.alert("该指令/建议已退回，您不能再确认","提示");
	        		return;
	        	}
	        	
	        	var jsonStatus = nui.encode({cfjyproductprocess:{processId:rows[0].processId}});
	        	$.ajax({
	                url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProcessStatus.biz.ext",
	                type:'POST',
	                data:jsonStatus,
	                cache:false,
	                contentType:'text/json',
	                success:function(text){
	                    var returnJsonStatus = nui.decode(text);
	                    
	                    //“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
			        	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
			        	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
			        	var processStatus = returnJsonStatus.processStatus;
			        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
			        		nui.alert("该指令/建议尚未确认，您还不能处理","提示");
	        				return;
			        	
			        	//投资经理下单操作权限认证
			        	}else if(processStatus=="7"|| processStatus=="1"){
			        	    if(rows[0].processType=="99"&&processStatus=="1"){
			        	    	var userIdRelaTypeA3 = rows[0].userIdRelaTypeA3;//A3-组合与委托人确认权限
			        	    	if(userIdRelaTypeA3 !=null && userIdRelaTypeA3 !=""){
									nui.alert("该指令/建议尚未复核，您还不能处理","提示");
	        				    	return;
								}else{
									//若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
					        		var hasPermission = false;//是否有权限，默认无
									var userIdRelaType02 = rows[0].userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
									if(userIdRelaType02!=null && userIdRelaType02!=""){
										var userIdRelaType02Arr = userIdRelaType02.split(",");
										for(var i=0; i<userIdRelaType02Arr.length; i++){
											var userIdTemp = userIdRelaType02Arr[i];
											if(userIdTemp==userId){
												hasPermission = true;
												break;
											}
										}
									}
									if(hasPermission==false){
										nui.alert("您没有权限确认该指令/建议","提示");
			    						return;
									}
								}
			        	    }else{
			        	        //若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
				        		var hasPermission = false;//是否有权限，默认无
								var userIdRelaType02 = rows[0].userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
								if(userIdRelaType02!=null && userIdRelaType02!=""){
									var userIdRelaType02Arr = userIdRelaType02.split(",");
									for(var i=0; i<userIdRelaType02Arr.length; i++){
										var userIdTemp = userIdRelaType02Arr[i];
										if(userIdTemp==userId){
											hasPermission = true;
											break;
										}
									}
								}
								if(hasPermission==false){
									nui.alert("您没有权限确认该指令/建议","提示");
		    						return;
								}
			        	    }
						//交易确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
			        	}else if(processStatus=="2" || processStatus=="3" || processStatus=="4"){
			        		var hasPermission = false;//是否有权限，默认无
							if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
								var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
								for(var i=0; i<tradingConfirmAuthorityUserIdsArr.length; i++){
									var userIdTemp = tradingConfirmAuthorityUserIdsArr[i];
									if(userIdTemp==userId){
										hasPermission = true;
										break;
									}
								}
							}
							if(hasPermission==false){
								nui.alert("您没有权限确认该指令/建议","提示");
	    						return;
							}
			        	//后台已成交确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
			        	}else if(processStatus=="5"){
			        		var hasPermission = false;//是否有权限，默认无
							if(backstageConfirmAuthorityUserIds!=null && backstageConfirmAuthorityUserIds!=""){
								var backstageConfirmAuthorityUserIdsArr = backstageConfirmAuthorityUserIds.split(",");
								for(var i=0; i<backstageConfirmAuthorityUserIdsArr.length; i++){
									var userIdTemp = backstageConfirmAuthorityUserIdsArr[i];
									if(userIdTemp==userId){
										hasPermission = true;
										break;
									}
								}
							}
							if(hasPermission==false){
								nui.alert("您没有权限确认该指令/建议","提示");
	    						return;
							}
			        	}
			        	
			        	var msg = "";
			        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
			        		nui.alert("该指令/建议尚未确认，您还不能处理","提示");
	        				return;
			        	}
			        	if(processStatus=="7" || processStatus=="1"){
			        		msg = "该指令/建议现为复核完成阶段，确定要继续确认吗？";
			        	}else if(processStatus=="2"){
			        		msg = "该指令/建议现为投资经理下单完成阶段，确定要继续确认吗？";
			        	}else if(processStatus=="3"){
			        		msg = "该指令/建议现为交易员填单完成阶段，确定要继续确认吗？";
			        	}else if(processStatus=="4"){
			        		msg = "该指令/建议现为交易已发送阶段，确定要继续确认吗？";
			        	}else if(processStatus=="5"){
			        		msg = "该指令/建议现为前台已成交阶段，确定要继续确认吗？";
			        	}else if(processStatus=="6"){
			        		nui.alert("该指令/建议后台已成交，不能再做任何操作","提示");
			        		return;
			        	}
				    
				        nui.confirm(msg,"系统提示",
				        function(action){
				            if(action=="ok"){
				            	
				            	//提交之前再次实时查询指令/建议单有效状态，避免用户在操作界面停留时间太长导致界面数据状态与数据库不一致
				            	var jsonValidStatus = nui.encode({cfjyproductprocess:{processId:rows[0].processId}});
							  	$.ajax({
							          url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getValidStatus.biz.ext",
							          type:'POST',
							          data:jsonValidStatus,
							          cache:false,
							          contentType:'text/json',
							          success:function(text){
							              var returnJsonValidStatus = nui.decode(text);
							              //交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
							              var returnValidStatus = returnJsonValidStatus.validStatus;
							              
							              //若指令/建议单有效，则继续执行
							              if(returnValidStatus=="0"){
							              
							              	  	//封装主键ID、指令/建议流程处理状态字段传输到后台处理
							                    var json = nui.encode({cfjyproductprocesss:[{processId:rows[0].processId, processStatus:processStatus}]});
								                grid_QTZL.loading("正在确认中,请稍等...");
								                $.ajax({
								                    url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.confirmCFJYProductProcesss.biz.ext",
								                    type:'POST',
								                    data:json,
								                    cache: false,
								                    contentType:'text/json',
								                    success:function(text){
								                        var returnJson = nui.decode(text);
								                        if(returnJson.exception == null){
								                        	var validStr = returnJson.validStr;//有效指令/建议单字符串
								                        	var invalidStr = returnJson.invalidStr;//无效指令/建议单字符串
								                        	var validCount = returnJson.validCount;//有效指令/建议单记录数
								                        	var invalidCount = returnJson.invalidCount;//无效指令/建议单记录数
								                        	var msg = "";
								                        	if(validCount!=null && validCount!="" && validCount!="0"){
								                        		msg = "确认成功 " + validCount + " 条";
								                        	}
								                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
								                        		if(msg!=null && msg!=""){
								                        			msg += "；";
								                        		}
								                        		msg += "确认失败 " + invalidCount + " 条，产品名称为【" + invalidStr + "】";
								                        	}
								                            grid_QTZL.reload();
								                            nui.alert(msg, "系统提示", function(action){
								                            });
								                        }else{
							                                grid_QTZL.unmask();
							                                nui.alert("确认失败", "系统提示");
								                        }
								                    }
								                });
							              }else if(returnValidStatus=="3"){
							              	  grid_QTZL.reload();
											  nui.alert("该指令/建议已退回，您不能再确认","提示");
											  return;
							              }else{
							              	  grid_QTZL.reload();
											  nui.alert("该指令/建议已无效，不能再做任何操作","提示");
	        								  return;
							              }
							          }
							      });
				             }
				        });
	                }
	            });
	    	
	    	//确认记录大于1时
	    	}else{
	    		
	    		//有效无效验证开始...
	    		var validStr = "";//有效无效验证字符串
	    		for(var i=0; i<rows.length; i++){
	    			var record = rows[i];//产品记录
	    			var combProductName = record.combProductName;//产品名称
	    			var investProductNum = record.investProductNum;//编号
		        	var validStatus = record.validStatus;//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
		        	if(validStatus!="0"){
		        		validStr += "、" + investProductNum + "-" + combProductName;
		        	}
	    		}
	    		if(validStr!=null && validStr!="" && validStr.length>0){
	    			validStr = validStr.substr(1,validStr.length);
	    			var msg = "【"+validStr+"】</br>指令/建议已无效或退回，请先剔除";
	    			nui.alert(msg,"提示");
	    			return;
	    		}
	    		//有效无效验证结束!!!
	    		
	    		
	    		//权限验证开始...
	    		var permissionStr = "";//权限验证字符串
	    		for(var i=0; i<rows.length; i++){
	    			var record = rows[i];//产品记录
	    			var combProductName = record.combProductName;//产品名称
	    			var investProductNum = record.investProductNum;//编号
		        	var processStatus = record.processStatus;//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
		        	
		        	//未走到下单节点(投资经理确认)
		        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
		        		permissionStr += "、" + investProductNum + "-" + combProductName;
		        	
		        	//投资经理下单操作权限认证
		        	}else if(processStatus=="1"){
		        		var userIdRelaTypeA3 = record.userIdRelaTypeA3;//A3-组合与委托人确认权限
	        	    	if(userIdRelaTypeA3 !=null && userIdRelaTypeA3 !=""){
							permissionStr += "、" + investProductNum + "-" + combProductName;
						}else{
							//若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
			        		var hasPermission = false;//是否有权限，默认无
							var userIdRelaType02 = record.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
							if(userIdRelaType02!=null && userIdRelaType02!=""){
								var userIdRelaType02Arr = userIdRelaType02.split(",");
								for(var j=0; j<userIdRelaType02Arr.length; j++){
									var userIdTemp = userIdRelaType02Arr[j];
									if(userIdTemp==userId){
										hasPermission = true;
										break;
									}
								}
							}
							if(hasPermission==false){
								permissionStr += "、" + investProductNum + "-" + combProductName;
							}
						}
		        	}else if(processStatus=="7"){
		        		//若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
		        		var hasPermission = false;//是否有权限，默认无
						var userIdRelaType02 = record.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
						if(userIdRelaType02!=null && userIdRelaType02!=""){
							var userIdRelaType02Arr = userIdRelaType02.split(",");
							for(var j=0; j<userIdRelaType02Arr.length; j++){
								var userIdTemp = userIdRelaType02Arr[j];
								if(userIdTemp==userId){
									hasPermission = true;
									break;
								}
							}
						}
						if(hasPermission==false){
							permissionStr += "、" + investProductNum + "-" + combProductName;
						}
						
					//交易确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
		        	}else if(processStatus=="2" || processStatus=="3" || processStatus=="4"){
		        		var hasPermission = false;//是否有权限，默认无
						if(tradingConfirmAuthorityUserIds!=null && tradingConfirmAuthorityUserIds!=""){
							var tradingConfirmAuthorityUserIdsArr = tradingConfirmAuthorityUserIds.split(",");
							for(var j=0; j<tradingConfirmAuthorityUserIdsArr.length; j++){
								var userIdTemp = tradingConfirmAuthorityUserIdsArr[j];
								if(userIdTemp==userId){
									hasPermission = true;
									break;
								}
							}
						}
						if(hasPermission==false){
							permissionStr += "、" + investProductNum + "-" + combProductName;
						}
		        	
		        	//后台已成交确认阶段权限认证，若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
		        	}else if(processStatus=="5"){
		        		var hasPermission = false;//是否有权限，默认无
						if(backstageConfirmAuthorityUserIds!=null && backstageConfirmAuthorityUserIds!=""){
							var backstageConfirmAuthorityUserIdsArr = backstageConfirmAuthorityUserIds.split(",");
							for(var j=0; j<backstageConfirmAuthorityUserIdsArr.length; j++){
								var userIdTemp = backstageConfirmAuthorityUserIdsArr[j];
								if(userIdTemp==userId){
									hasPermission = true;
									break;
								}
							}
						}
						if(hasPermission==false){
							permissionStr += "、" + investProductNum + "-" + combProductName;
						}
		        	}
	    		}
	    		if(permissionStr!=null && permissionStr!="" && permissionStr.length>0){
	    			permissionStr = permissionStr.substr(1,permissionStr.length);
	    			var msg = "您没有权限确认【"+permissionStr+"】指令/建议，请先剔除";
	    			nui.alert(msg,"提示");
	    			return;
	    		}
	    		//权限验证结束!!!
	    		
	    		
	    		
	    		
	    		//封装主键ID字段传输到后台处理开始...
	    		var processIdArr = new Array();
	    		for(var i=0; i<rows.length; i++){
	    			var record = rows[i];//产品记录
	    			var processIdTemp = {processId: record.processId};//封装指令/建议单主键ID
	    			processIdArr.push(processIdTemp);
	    		}
	    		
	    		var msg = "确定要确认所选的 " + rows.length + " 条指令/建议吗？";
	    		nui.confirm(msg,"系统提示",function(action){
					if(action=="ok"){
		                var json = nui.encode({cfjyproductprocesss: processIdArr});
		                grid_QTZL.loading("正在确认中,请稍等...");
		                $.ajax({
		                    url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.confirmCFJYProductProcesss.biz.ext",
		                    type:'POST',
		                    data:json,
		                    cache: false,
		                    contentType:'text/json',
		                    success:function(text){
		                        var returnJson = nui.decode(text);
		                        if(returnJson.exception == null){
		                        	var validStr = returnJson.validStr;//有效指令/建议单字符串
		                        	var invalidStr = returnJson.invalidStr;//无效指令/建议单字符串
		                        	var validCount = returnJson.validCount;//有效指令/建议单记录数
		                        	var invalidCount = returnJson.invalidCount;//无效指令/建议单记录数
		                        	var msg = "";
		                        	if(validCount!=null && validCount!="" && validCount!="0"){
		                        		msg = "确认成功 " + validCount + " 条";
		                        	}
		                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
		                        		if(msg!=null && msg!=""){
		                        			msg += "；";
		                        		}
		                        		msg += "确认失败 " + invalidCount + " 条，产品名称为【" + invalidStr + "】";
		                        	}
		                            grid_QTZL.reload();
		                            nui.alert(msg, "系统提示", function(action){
		                            });
		                        }else{
		                            grid_QTZL.unmask();
		                            nui.alert("确认失败", "系统提示");
		                        }
		                    }
		                });
					}
				});
	    		//封装主键ID字段传输到后台处理结束!!!
	    		
	    	}
	    }else{
	        nui.alert("请先选中指令/建议！");
	    }
	}
	//退回
	function goBack_QTZL(){
		var rows = grid_QTZL.getSelecteds();
	    if(rows.length > 0){
	    
    		//有效无效验证开始...
    		var validStr = "";//有效无效验证字符串
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];//产品记录
    			var combProductName = record.combProductName;//产品名称
    			var investProductNum = record.investProductNum;//编号
	        	var validStatus = record.validStatus;//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
	        	if(validStatus!="0"){
	        		validStr += "、" + investProductNum + "-" + combProductName;
	        	}
    		}
    		if(validStr!=null && validStr!="" && validStr.length>0){
    			validStr = validStr.substr(1,validStr.length);
    			var msg = "【"+validStr+"】</br>指令/建议已无效或退回，请先剔除";
    			nui.alert(msg,"提示");
    			return;
    		}
    		//有效无效验证结束!!!
    		
    		
    		//权限验证开始...
    		var goBackStr = "";//该阶段不能退回字符串
    		var permissionStr = "";//权限验证字符串
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];//产品记录
    			var combProductName = record.combProductName;//产品名称
    			var investProductNum = record.investProductNum;//编号
	        	var processStatus = record.processStatus;//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
	        	
	        	//投顾尚未确认
	        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
	        	    goBackStr += "、" + investProductNum + "-" + combProductName;
	        	//投资经理下单操作权限认证
	        	}else if(processStatus=="1"||processStatus=="7"){
	        	    if(processStatus=="1"&&record.processType=="99"){
						var userIdRelaTypeA3 = record.userIdRelaTypeA3!=null?record.userIdRelaTypeA3:"";//A3-组合与委托人确认权限
						if(userIdRelaTypeA3!=null&&userIdRelaTypeA3!=""){
						    goBackStr += "、" + investProductNum + "-" + combProductName;
						}
		        	}else{
		        		//若当前用户有权限处理该指令/建议单，则继续执行，否则记录下该产品
		        		var hasPermission = false;//是否有权限，默认无
						var userIdRelaType02 = record.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
						if(userIdRelaType02!=null && userIdRelaType02!=""){
							var userIdRelaType02Arr = userIdRelaType02.split(",");
							for(var j=0; j<userIdRelaType02Arr.length; j++){
								var userIdTemp = userIdRelaType02Arr[j];
								if(userIdTemp==userId){
									hasPermission = true;
									break;
								}
							}
						}
						if(hasPermission==false){
							permissionStr += "、" + investProductNum + "-" + combProductName;
						}
					//投资经理下单已确认
		        	}
	        	}
    		}
    		if(goBackStr!=null && goBackStr!="" && goBackStr.length>0){
    			goBackStr = goBackStr.substr(1,goBackStr.length);
    			var msg = "【"+goBackStr+"】</br>指令/建议尚未确认或投资经理已下单，请先剔除";
    			nui.alert(msg,"提示");
    			return;
    		}
    		if(permissionStr!=null && permissionStr!="" && permissionStr.length>0){
    			permissionStr = permissionStr.substr(1,permissionStr.length);
    			var msg = "您没有权限退回【"+permissionStr+"】指令/建议，请先剔除";
    			nui.alert(msg,"提示");
    			return;
    		}
    		//权限验证结束!!!
    		
    		
    		
    		
    		//封装主键ID字段传输到后台处理开始...
    		var processIdArr = new Array();
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];//产品记录
    			var processIdTemp = {processId: record.processId};//封装指令/建议单主键ID
    			processIdArr.push(processIdTemp);
    		}
    		
    		var msg = "确定要退回所选的 " + rows.length + " 条指令/建议吗？";
    		nui.confirm(msg,"系统提示",function(action){
				if(action=="ok"){
	                var json = nui.encode({cfjyproductprocesss: processIdArr, validStatus: "3"});
	                grid_QTZL.loading("正在退回中,请稍等...");
	                $.ajax({
	                    url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.updateValidStatus.biz.ext",
	                    type:'POST',
	                    data:json,
	                    cache: false,
	                    contentType:'text/json',
	                    success:function(text){
	                        var returnJson = nui.decode(text);
	                        if(returnJson.exception == null){
	                            grid_QTZL.reload();
	                            nui.alert("退回成功", "系统提示", function(action){
	                            });
	                        }else{
	                            grid_QTZL.unmask();
	                            nui.alert("退回失败", "系统提示");
	                        }
	                    }
	                });
				}
			});
    		//封装主键ID字段传输到后台处理结束!!!
	    		
	    }else{
	        nui.alert("请先选中指令/建议！");
	    }
	}
	//查询
	function search_QTZL() {
		search(grid_QTZL, "#form_QTZL");
	}
	//当选择列时
    function selectionChanged_QTZL(){
        selectionChanged(grid_QTZL, "confirm_QTZL");
    }
	
	
    
    
	<%-- 导出业务 --%>
	//启用“导出”按钮
	function enableExportFun(){
		nui.get("export_ZLDDC").enable();
	}
	//获取选中记录的主键ID--所有业务通用
	function getSelectedProcessIds(grid_selected, selectedArr) {
		var selectedCount = selectedArr[0];
		var selectedProcessIds = selectedArr[1];
		
		//获取选中记录的主键ID
		var rows_selected = grid_selected.getSelecteds();
		var rowIds_selected = "";
		for(var i=0; i<rows_selected.length; i++){
			selectedCount++;//选中指令/建议单数量加1
			rowIds_selected += rows_selected[i].processId;
			if(i<rows_selected.length-1){
				rowIds_selected += ",";
			}
		}
		if(rowIds_selected!=null && rowIds_selected!=""){
			selectedProcessIds += "," + rowIds_selected;
		}
		
		selectedArr[0] = selectedCount;
		selectedArr[1] = selectedProcessIds;
		return selectedArr;
	}
	//导出
	function export_ZLDDC(){
		var processDate_ZLDDC_begin = nui.get("processDate_ZLDDC_begin").value;
    	var processDate_ZLDDC_end = nui.get("processDate_ZLDDC_end").value;
    	if(processDate_ZLDDC_begin==null || processDate_ZLDDC_begin==""){
    		nui.alert("业务起始日期不能为空","提示");
    		nui.get("processDate_ZLDDC_begin").focus();
	        return;
    	}
    	if(processDate_ZLDDC_end==null || processDate_ZLDDC_end==""){
    		nui.alert("业务截止日期不能为空","提示");
    		nui.get("processDate_ZLDDC_end").focus();
	        return;
    	}
    	//仅能导出一年区间的指令/建议数据
    	var dates = Math.abs(processDate_ZLDDC_begin.getTime()-processDate_ZLDDC_end.getTime())/(1000*60*60*24);//间隔天数
    	if(dates>366){
    		nui.alert("仅能导出一年区间的指令/建议数据","提示");
    		nui.get("processDate_ZLDDC_begin").focus();
	        return;
    	}
    	var begin = nui.formatDate(processDate_ZLDDC_begin, "yyyy-MM-dd");
		var end = nui.formatDate(processDate_ZLDDC_end, "yyyy-MM-dd");
		var msg = "";
		
		//获取选中的指令/建议单主键ID，若没选中，则过滤该条件
		var selectedCount = 0;
		var selectedProcessIds = "";
		var selectedArr = new Array();
		selectedArr[0] = selectedCount;
		selectedArr[1] = selectedProcessIds;
		selectedArr = getSelectedProcessIds(grid_ZQMM, selectedArr);
		selectedArr = getSelectedProcessIds(grid_ZNHG, selectedArr);
		selectedArr = getSelectedProcessIds(grid_ZQSJ, selectedArr);
		selectedArr = getSelectedProcessIds(grid_JJSS, selectedArr);
		selectedArr = getSelectedProcessIds(grid_DZJY, selectedArr);
		selectedArr = getSelectedProcessIds(grid_TP, selectedArr);
		selectedArr = getSelectedProcessIds(grid_QTZL, selectedArr);
		selectedCount = selectedArr[0];
		selectedProcessIds = selectedArr[1];
		if(selectedProcessIds!=null && selectedProcessIds!="" && selectedProcessIds.length>0){
			selectedProcessIds = selectedProcessIds.substring(1, selectedProcessIds.length);
			nui.get("processId").setValue(selectedProcessIds);
		}else{
			nui.get("processId").setValue(null);
		}
		if(selectedCount!=0){
			msg = "您已选中 " + selectedCount + " 条指令/建议，确定要导出 "+begin+" 到 "+end+" 且勾选中的指令/建议吗？";
		}else{
			msg = "确定要导出 "+begin+" 到 "+end+" 的指令/建议吗？";
		}
		
		nui.confirm(msg,"系统提示",function(action){
			if(action=="ok"){
				nui.get("export_ZLDDC").disable();//禁用“导出”按钮
				var form = document.getElementById("form_ZLDDC");
				form.action = "com.cjhxfund.jy.ProductProcess.ProductProcessExport.flow";
		        form.submit();
		        setTimeout("enableExportFun()",15000);//启用“导出”按钮
			}
		});
	}
	
	//全屏显示
	function fullScreen(){
		window.open('<%=request.getContextPath()%>/ProductProcess/CFJYProductProcessList_confirm.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
	
	//导出正逆回购
	function export_ZNHG(){
	    var z = 0;
	    var k = 0;
	    var processType ="";
	    var validStr = "";
	    var jysxyznhg = "";//记录交易所协议正逆回购数据
	    var jysznhg = "";//记录交易所正逆回购数据
	    var instructions = "";  //记录processStatus状态不大于2的数据
	    var isNotExport = ""; //记录那些指令/建议已经导出过
	    var isSameType = false;
	    var datas = grid_ZNHG.getSelecteds();
	    
	    //判断要导出的指令/建议中是否存在多个产品
	    for(var z1 = 0;z1<datas.length;z1++){
	      for(var k1 =0;k1<datas.length;k1++){
	        if(datas[z1].combProductName != datas[k1].combProductName){
	           nui.alert("导出的指令/建议中存在不同产品，不能导出。","系统提示");
	           return;
	        }
	      }
	    }
	    
	    
	    for(var i=0;i<datas.length;i++){
	    
	     //判断指令/建议是否无效
	     if(datas[i].validStatus == 0){
	          //记录交易所协议正逆回购数据
	          if(datas[i].processType == "16" || datas[i].processType == "17" ){
	             jysxyznhg = jysxyznhg + "、" + datas[i].investProductNum + "-" + datas[i].combProductName;
	          }
	          
	          //记录交易所正逆回购数据
	          if(datas[i].processType == "21" || datas[i].processType == "22" ){
	             jysznhg = jysznhg + "、" + datas[i].investProductNum + "-" + datas[i].combProductName;
	          }
	          
	          //判断当前指令/建议处于哪个环节
	          if(datas[i].processStatus < 2){
	             instructions = instructions + "、" + datas[i].investProductNum + "-" + datas[i].combProductName;
	          }
	          
	          //记录经导出过的指令/建议
	          if(datas[i].isNotExport == 1){
	             isNotExport = isNotExport + "、" + datas[i].investProductNum + "-" + datas[i].combProductName;
	          }
	          
		      if(datas[i].processType == "03" || datas[i].processType == "04" ){
		          z = 1;
		          processType = "1";   //导出质押式正逆回购
		      }
		      
		      if(datas[i].processType == "05" || datas[i].processType == "06" ){
		          k = 1;
		          processType = "2";   //导出买断式正逆回购
		      }
		      
		      if(k == z){
		      	isSameType = true;		        
		      }
		      
	      }else{
	        //组装无效指令/建议
	        validStr =validStr + "、" + datas[i].investProductNum + "-" + datas[i].combProductName;
	      }
	    }
	    
	    //剔除交易所协议正逆回购业务数据
	    if(jysxyznhg != ""){
	      nui.alert("【"+jysxyznhg.substr(1,jysxyznhg.length)+"】<br/>指令/建议属于交易所协议回购，请先剔除。","系统提示");
	      return;
	    }
	    
	    //剔除交易所正逆回购业务数据
	    if(jysznhg != ""){
	      nui.alert("【"+jysznhg.substr(1,jysznhg.length)+"】<br/>指令/建议属于交易所回购，请先剔除。","系统提示");
	      return;
	    }
	    
	    if(isSameType){
	      nui.alert("不能同时导出买断式与质押式正逆回购指令/建议！","系统提示");
	      return;
	    }
	    
	    //判断是否有投资经理未下单的数据，有给出提示
	    if(instructions != ""){
	      nui.alert("【"+instructions.substr(1,instructions.length)+"】<br/>指令/建议未下单不能导出，请先剔除。","系统提示");
	      return;
	    }
	    
	    //有效无效验证
	    if(validStr != ""){
	      nui.alert("【"+validStr.substr(1,validStr.length)+"】<br/>指令/建议已无效或退回不能导出，请先剔除。","系统提示");
	      return;
	    }
	    nui.get("processType1").setValue(processType);
    	
		var msg = "";
		
		//获取选中的指令/建议单主键ID，若没选中，则过滤该条件
		var selectedCount = 0;
		var selectedProcessIds = "";
		var selectedArr = new Array();
		selectedArr[0] = selectedCount;
		selectedArr[1] = selectedProcessIds;
	
		selectedArr = getSelectedProcessIds(grid_ZNHG, selectedArr);
		selectedCount = selectedArr[0];
		selectedProcessIds = selectedArr[1];
		if(selectedProcessIds!=null && selectedProcessIds!="" && selectedProcessIds.length>0){
			selectedProcessIds = selectedProcessIds.substring(1, selectedProcessIds.length);
			nui.get("processId1").setValue(selectedProcessIds);
		}else{
			nui.get("processId1").setValue(null);
		}
		
		if(selectedCount==0){
		   nui.alert("请先选择指令/建议再导出","系统提示");
		   return;
		}
		
		//判断指令/建议是否已经导出过
		if(isNotExport != ""){
		   msg = "您已选中 " + selectedCount + " 条指令/建议，<br/>【" + isNotExport.substr(1,isNotExport.length) + "】<br/>指令/建议之前已导出，确认要继续导出吗?";
		}else{
			msg = "您已选中 " + selectedCount + " 条指令/建议，确定要导出吗?";
		}

		nui.confirm(msg,"系统提示",function(action){
			if(action=="ok"){
				nui.get("export_ZNHG").disable();//禁用“导出”按钮
				var form = document.getElementById("export_ZNHG_FROM");
				form.action = "com.cjhxfund.jy.ProductProcess.PledgedRepoExport.flow";
		        form.submit();
		        setTimeout("enableExportFun1()",15000);//启用“导出”按钮
			}
		});
	}
	
	function enableExportFun1(){
	  nui.get("export_ZNHG").enable();
	}
</script>
</body>
</html>
