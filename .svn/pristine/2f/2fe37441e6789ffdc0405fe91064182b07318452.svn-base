<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/JY_ZQMM/JY_ZQMM_common.jsp" %>
<%@include file="/ProductProcess/JY_ZNHG/JY_ZNHG_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2015-10-09 11:42:39
- Description: 投资指令/建议录入
--%>
<head>
<title>投资指令/建议录入</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div class="nui-tabs" id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">
		
		<!-- 业务类型标签页开始... -->
		
		
		<div title="债券买卖">
		   <%-- 债券买卖查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <div id="form_ZQMM" class="nui-form" style="padding:2px;" align="center" style="height:10%">
					<!-- 数据实体的名称 -->
	                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryZhfwptJyZqmm4Tg">
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
	                            <input class="nui-textbox" name="criteria/_expr[3]/combProductName"/>
	                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="like">
	                            <input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
	                        </td>
	                        <td class="form_label" width="7%">
								业务类别:
	                        </td>
	                        <td colspan="1" width="13%">
								<input class="nui-dictcombobox" name="criteria/_expr[4]/processType" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQMM"  
									emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
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
                        <td>
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add_ZQMM()">
								增加
                            </a>
                            <!-- &nbsp;
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add_excel()">
								Excel导入
                            </a> -->
                            &nbsp;
                            <a id="update_ZQMM" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit_ZQMM()">
                               	 编辑
                            </a>
                            &nbsp;
                            <a id="del_ZQMM" class='nui-button' plain='false' iconCls="icon-remove" onclick="remove_ZQMM()">
                               	 废弃
                            </a>
                            &nbsp;
                            <a id="confirm_ZQMM" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_ZQMM()">
								确认
                            </a>
                        </td>
                        <td style="width:150px;">
                        	<span class="warn_red_bold">数据每 5 分钟自动刷新</span>
                        </td>
	                    <td style="width:80px;" align="right">
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
                        url="com.cjhxfund.jy.ProductProcess.JY_ZQMM.JY_ZQMM_query4Tg.biz.ext"
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
                        sizeList="[10,20,50,100]">

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
		                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryZhfwptJyZnhg4Tg">
		                <!-- 获取03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购类型;16-交易所协议正回购;17-交易所协议逆回购；21-交易所正回购；22-交易所逆回购；业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;99-其他指令/建议; -->
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
		                            <input class="nui-textbox" name="criteria/_expr[3]/combProductName"/>
		                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="like">
		                            <input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
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
                        <td style="width:100%;">
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add_ZNHG()">
								增加
                            </a>
                            &nbsp;
                            <a id="update_ZNHG" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit_ZNHG()">
                               	 编辑
                            </a>
                            &nbsp;
                            <a id="del_ZNHG" class='nui-button' plain='false' iconCls="icon-remove" onclick="remove_ZNHG()">
                               	 废弃
                            </a>
                            &nbsp;
                            <a id="confirm_ZNHG" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_ZNHG()">
								确认
                            </a>
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
                        url="com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_query4Tg.biz.ext"
                        pageSize="50"
                        showPageInfo="true"
                        multiSelect="true"
                        onselectionchanged="selectionChanged_ZNHG"
                        onshowrowdetail="onShowRowDetail_ZNHG"
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
		                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryCfJyProductProcess">
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
		                            <input class="nui-textbox" name="criteria/_expr[3]/combProductName"/>
		                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="like">
		                            <input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
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
		   <%--
           <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add_ZQSJ()">
								增加
                            </a>
                            &nbsp;
                            <a id="update_ZQSJ" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit_ZQSJ()">
                               	 编辑
                            </a>
                            &nbsp;
                            <a id="del_ZQSJ" class='nui-button' plain='false' iconCls="icon-remove" onclick="remove_ZQSJ()">
                               	 废弃
                            </a>
                            &nbsp;
                            <a id="confirm_ZQSJ" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_ZQSJ()">
								确认
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
            --%>
            <div class="nui-fit">
                <div 
                        id="datagrid_ZQSJ"
                        dataField="cfjyproductprocesss"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.queryCFJYProductProcesssByInvestAdviser.biz.ext"
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
		                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryCfJyProductProcess">
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
		                            <input class="nui-textbox" name="criteria/_expr[3]/combProductName"/>
		                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="like">
		                            <input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
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
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add_JJSS()">
								增加
                            </a>
                            &nbsp;
                            <a id="update_JJSS" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit_JJSS()">
                               	 编辑
                            </a>
                            &nbsp;
                            <a id="del_JJSS" class='nui-button' plain='false' iconCls="icon-remove" onclick="remove_JJSS()">
                               	 废弃
                            </a>
                            &nbsp;
                            <a id="confirm_JJSS" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_JJSS()">
								确认
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
                        url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.queryCFJYProductProcesssByInvestAdviser.biz.ext"
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
		                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryCfJyProductProcess">
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
		                            <input class="nui-textbox" name="criteria/_expr[3]/combProductName"/>
		                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="like">
		                            <input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
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
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add_DZJY()">
								增加
                            </a>
                            &nbsp;
                            <a id="update_DZJY" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit_DZJY()">
                               	 编辑
                            </a>
                            &nbsp;
                            <a id="del_DZJY" class='nui-button' plain='false' iconCls="icon-remove" onclick="remove_DZJY()">
                               	 废弃
                            </a>
                            &nbsp;
                            <a id="confirm_DZJY" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_DZJY()">
								确认
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
                        url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.queryCFJYProductProcesssByInvestAdviser.biz.ext"
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
		                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryCfJyProductProcess">
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
		                            <input class="nui-textbox" name="criteria/_expr[3]/combProductName"/>
		                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="like">
		                            <input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
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
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add_TP()">
								增加
                            </a>
                            &nbsp;
                            <a id="update_TP" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit_TP()">
                               	 编辑
                            </a>
                            &nbsp;
                            <a id="del_TP" class='nui-button' plain='false' iconCls="icon-remove" onclick="remove_TP()">
                               	 废弃
                            </a>
                            &nbsp;
                            <a id="confirm_TP" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_TP()">
								确认
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
                        url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.queryCFJYProductProcesssByInvestAdviser.biz.ext"
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
		                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.queryDataset.QueryCfJyProductProcess">
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
		                            <input class="nui-textbox" name="criteria/_expr[3]/combProductName"/>
		                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="like">
		                            <input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
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
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add_QTZL()">
								增加
                            </a>
                            &nbsp;
                            <a id="update_QTZL" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit_QTZL()">
                               	 编辑
                            </a>
                            &nbsp;
                            <a id="del_QTZL" class='nui-button' plain='false' iconCls="icon-remove" onclick="remove_QTZL()">
                               	 废弃
                            </a>
                            &nbsp;
                            <a id="confirm_QTZL" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_QTZL()">
								确认
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
                        url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.queryCFJYProductProcesssByInvestAdviser.biz.ext"
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
		                <input class="nui-hidden" name="exportType" value="1">
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
		                            <input id="combProductCode" required="false" class="nui-textboxlist" style="width:430px;" name="criteria/_expr[5]/combProductCode" searchField="searchKey" dataField="combProducts"
			                        	valueField="fundCode" textField="fundCodeName" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductsByKeyAndUserId.biz.ext" value="" text=""/>
			                        <input class="nui-hidden" name="criteria/_expr[5]/_op" value="in"/>
			                        
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
    
    //新增--所有业务通用
    function add(jspUrl, title, width, height, grid) {
        nui.open({
            url: "<%=request.getContextPath()%>/ProductProcess/" + jspUrl,
		    title: title,
		    width: width,
		    height: height,
		    onload: function () {//弹出页面加载完成
			    var iframe = this.getIFrameEl();
			    var data = {pageType:"add",roleType:"TG"};//传入页面的json数据
			    iframe.contentWindow.setFormData(data);
		    },
		    ondestroy: function (action) {//弹出页面关闭前
		    	grid.reload();
	        }
        });
    }
    
    //编辑--所有业务通用
    function edit(jspUrl, title, width, height, grid, editData) {
        var row = grid.getSelected();
        if (row) {
        	//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
        	var validStatus = row.validStatus;
        	if(validStatus=="1" || validStatus=="2" || validStatus=="4" ){
        		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
        		return;
        	}
        	
        	//“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
        	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
        	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
        	var processStatus = row.processStatus;
        	var msg = "";
        	
        	if(processStatus=="-2"){
        	}else if(processStatus=="-1"){
        		msg = "该指令/建议已补齐，确定要继续修改吗？";
        	}else if(processStatus=="0" || processStatus=="1"){
        	}else if(processStatus=="2"){
        		msg = "该指令/建议投资经理已下单，确定要继续修改吗？";
        	}else if(processStatus=="3"){
        		msg = "该指令/建议交易员已填单，确定要继续修改吗？";
        	}else if(processStatus=="4"){
        		msg = "该指令/建议交易已发送，确定要继续修改吗？";
        	}else if(processStatus=="5"){
        		msg = "该指令/建议前台已成交，不能再修改，仅可以废弃";
        	}else if(processStatus=="6"){
        		msg = "该指令/建议后台已成交，不能再做任何操作";
        	}
        	
        	//尚未确认的记录直接修改
        	if(processStatus=="-2" || processStatus=="0" || processStatus=="1"){
        		nui.open({
	                url: "<%=request.getContextPath()%>/ProductProcess/"+jspUrl,
	                title: title,
	                width: width,
	                height: height,
	                onload: function () {
	                    var iframe = this.getIFrameEl();
	                    var data = {pageType:"edit",roleType:"TG",record:{cfjyproductprocess:row}};
	                    //特殊处理，若传入编辑对象，则取编辑对象
	                    if(editData!=null && editData!=""){
	                    	data = editData;
	                    }
	                    //直接从页面获取，不用去后台获取
	                    iframe.contentWindow.setFormData(data);
	                },
	                ondestroy: function (action) {
	                    grid.reload();
	                }
	            });
	        
        	}else if(processStatus=="-1" || processStatus=="2" || processStatus=="3" || processStatus=="4"){
        		nui.confirm(msg,"系统提示",function(action){
					if(action=="ok"){
						nui.open({
			                url: "<%=request.getContextPath()%>/ProductProcess/"+jspUrl,
			                title: title,
			                width: width,
			                height: height,
			                onload: function () {
			                    var iframe = this.getIFrameEl();
			                    var data = {pageType:"edit",roleType:"TG",record:{cfjyproductprocess:row}};
			                    //特殊处理，若传入编辑对象，则取编辑对象
			                    if(editData!=null && editData!=""){
			                    	data = editData;
			                    }
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
    
    //废弃--所有业务通用
	function remove(grid_remove){
	    var rows = grid_remove.getSelecteds();
	    if(rows.length > 0){
	    
	    	//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
        	var validStatus = rows[0].validStatus;
        	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
        		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
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
		        	var msg = "";
		        	
		        	if(processStatus=="-1"){
		        		msg = "该指令/建议已补齐，确定要继续废弃吗？";
		        	}else if(processStatus=="-2" || processStatus=="0" || processStatus=="1"){
		        		msg = "确定废弃选中指令/建议？";
		        	}else if(processStatus=="2"){
		        		msg = "该指令/建议投资经理已下单，确定要继续废弃吗？";
		        	}else if(processStatus=="3"){
		        		msg = "该指令/建议交易员已填单，确定要继续废弃吗？";
		        	}else if(processStatus=="4"){
		        		msg = "该指令/建议交易已发送，确定要继续废弃吗？";
		        	}else if(processStatus=="5"){
		        		msg = "该指令/建议前台已成交，确定要继续废弃吗？";
		        	}else if(processStatus=="6"){
		        		nui.alert("该指令/建议后台已成交，不能再做任何操作","提示");
		        		return;
		        	}
			    
			        nui.confirm(msg,"系统提示",
			        function(action){
			            if(action=="ok"){
					        nui.prompt("请输入废弃原因：", "请输入",
					            function (action, value) {
					                if (action == "ok") {
					                    if(value==null || value==""){
					                    	nui.alert("请输入废弃原因再提交！");
					                    	return;
					                    }
					                    
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
									              if(returnValidStatus=="0" || returnValidStatus=="3"){
									              	  //封装主键ID、指令/建议流程处理状态、废弃原因字段传输到后台处理
								                      var json = nui.encode({cfjyproductprocesss:[{processId:rows[0].processId, processStatus:processStatus, abandonedReasons:value}]});
									                  grid_remove.loading("正在废弃中,请稍等...");
									                  $.ajax({
									                      url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.deleteCFJYProductProcesss.biz.ext",
									                      type:'POST',
									                      data:json,
									                      cache: false,
									                      contentType:'text/json',
									                      success:function(text){
									                          var returnJson = nui.decode(text);
									                          if(returnJson.exception == null){
									                              grid_remove.reload();
									                              nui.alert("废弃成功", "系统提示", function(action){
									                              });
									                          }else{
									                              grid_remove.unmask();
									                              nui.alert("废弃失败", "系统提示");
									                          }
									                      }
									                 });
									              }else{
													  nui.alert("该指令/建议已无效，不能再做任何操作","提示");
			        								  return;
									              }
									          }
									      });
					                }
					            },
					            true
					        );
			            }
			         });
                }
            });
	    }else{
	        nui.alert("请选中一条记录！");
	    }
	}
	
	//确认--所有业务通用
	function confirm(grid_confirm){
	    var rows = grid_confirm.getSelecteds();
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
    		var confirmStr = "";//该阶段不能确认字符串
    		var noPermissionStr = "";//无权限确认的记录
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];//产品记录
    			var combProductName = record.combProductName;//产品名称
    			var investProductNum = record.investProductNum;//编号
	        	var processStatus = record.processStatus;//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
				var userIdRelaType07All = record.userIdRelaType07All!=null?record.userIdRelaType07All:"";//07-产品与投顾确认权限(全部人员)
	        	var userIdRelaType07 = record.userIdRelaType07!=null?record.userIdRelaType07:"";//07-产品与投顾确认权限(过滤自己)
				var userIdRelaTypeA1 = record.userIdRelaTypeA1!=null?record.userIdRelaTypeA1:"";//A1-投顾录入确认可为同一人员
	        	//投顾只能确认“交易员填单指令/建议补齐完成”或“投资顾问录入完成”阶段状态的指令/建议
	        	if(processStatus!="-1" && processStatus!="0"){
	        		confirmStr += "、" + investProductNum + "-" + combProductName;
	        	}
	        	
	        	//无权限确认的记录
	        	var hasPermission = false;
				if(userIdRelaType07All!=null && userIdRelaType07All!=""){//设置了复核人员
					var userIdRelaType07Arr = userIdRelaType07.split(",");//默认过滤自己
					if(userIdRelaTypeA1!=null && userIdRelaTypeA1!=""){//可为同一人员
						userIdRelaType07Arr = userIdRelaType07All.split(",");
					}
					for(var j=0; j<userIdRelaType07Arr.length; j++){
						var userIdTemp = userIdRelaType07Arr[j];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
				}else{
					hasPermission = true;
				}
				if(hasPermission!=true){
					noPermissionStr += "、" + investProductNum + "-" + combProductName;
				}
    		}
    		if(confirmStr!=null && confirmStr!="" && confirmStr.length>0){
    			confirmStr = confirmStr.substr(1,confirmStr.length);
    			var msg = "您只能确认“指令/建议已录入”或“指令/建议已补齐”阶段的指令/建议！</br>【"+confirmStr+"】</br>指令/建议不符合要求，请先剔除";
    			nui.alert(msg,"提示");
    			return;
    		}
    		if(noPermissionStr!=null && noPermissionStr!="" && noPermissionStr.length>0){
    			noPermissionStr = noPermissionStr.substr(1,noPermissionStr.length);
    			var msg = "【"+noPermissionStr+"】</br>指令/建议您没有权限确认，请先剔除";
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
	    		
	    }else{
	        nui.alert("请先选中指令/建议！");
	    }
	}
    
    //tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	function activechangedFun(){
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tab").getActiveTab().title;
		if(activeTabTitle=="债券买卖"){
			search_ZQMM();
		}else if(activeTabTitle=="正逆回购"){
			search_ZNHG();
		}else if(activeTabTitle=="申购缴款"){
			search_ZQSJ();
		}else if(activeTabTitle=="基金申赎"){
			search_JJSS();
		}else if(activeTabTitle=="大宗交易"){
			search_DZJY();
		}else if(activeTabTitle=="投票"){
			search_TP();
		}else if(activeTabTitle=="其他指令/建议"){
			search_QTZL();
		}
	}
	
	//系统自动刷新页面--所有业务通用
    function autoRefreshFun(){
    	activechangedFun();//同时刷新查询列表数据
    }
    self.setInterval("autoRefreshFun()",60000*5);//设置自动刷新时间默认5分钟
	
	//表格行增加背景色--所有业务通用
	function drawcellFun(e){
		var record = e.record;
		var	column = e.column;
		var	field = e.field;
		var	value = e.value;
		
		//设置行样式，交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
		if(record.validStatus=="1" || record.validStatus=="4"){
			e.rowCls = "validStatus_modify_1_4";
		}else if(record.validStatus=="2"){
			e.rowCls = "validStatus_del_2";
		}else if(record.validStatus=="3"){
			e.rowCls = "validStatus_modify_3";
		}else{
			//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
			if(record.processStatus=="-2"){
				e.rowCls = "processStatus_-2_tg";
			}else if(record.processStatus=="-1" || record.processStatus=="0"){
				e.rowCls = "processStatus_-1_tg";
				
				//若当前用户有权限处理该指令/建议单，则该指令/建议单使用特定背景色显示
				var userIdRelaType07All = record.userIdRelaType07All!=null?record.userIdRelaType07All:"";//07-产品与投顾确认权限(全部人员)
	        	var userIdRelaType07 = record.userIdRelaType07!=null?record.userIdRelaType07:"";//07-产品与投顾确认权限(过滤自己)
				var userIdRelaTypeA1 = record.userIdRelaTypeA1!=null?record.userIdRelaTypeA1:"";//A1-投顾录入确认可为同一人员
				var hasPermission = false;
				if(userIdRelaType07All!=null && userIdRelaType07All!=""){//设置了复核人员
					var userIdRelaType07Arr = userIdRelaType07.split(",");//默认过滤自己
					if(userIdRelaTypeA1!=null && userIdRelaTypeA1!=""){//可为同一人员
						userIdRelaType07Arr = userIdRelaType07All.split(",");
					}
					for(var j=0; j<userIdRelaType07Arr.length; j++){
						var userIdTemp = userIdRelaType07Arr[j];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
				}else{
					hasPermission = true;
				}
				if(hasPermission==true){
					e.rowCls = "processStatus_wait_confirm";
				}
			}else if(record.processStatus=="1"){
				e.rowCls = "processStatus_1_tg";
			}else if(record.processStatus=="2"){
				e.rowCls = "processStatus_2_tg";
			}else if(record.processStatus=="3"){
				e.rowCls = "processStatus_3_tg";
			}else if(record.processStatus=="4"){
				e.rowCls = "processStatus_4_tg";
			}else if(record.processStatus=="5"){
				e.rowCls = "processStatus_5_tg";
			}else if(record.processStatus=="6"){
				e.rowCls = "processStatus_6_tg";
			}
		}
	}
	
	//行双击时弹出页面展示该指令/建议详细信息--所有业务通用
    function rowdblclickFun(jspUrl, title, width, height, e, grid_confirm) {
        var row = e.record;//行对象值
        if (row) {
        	nui.open({
                url: "<%=request.getContextPath()%>/ProductProcess/"+jspUrl,
                title: title,
                width: width,
                height: height,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = {pageType:"query",roleType:"TG",record:{cfjyproductprocess:row}};
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
	//买卖方向处理--所有业务通用
	function renderDeliveryMethod(e) {
		return nui.getDictText("CF_JY_MMFX",e.row.deliveryMethod);
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
		//return nui.getDictText("CF_JY_HTCJZT",e.row.backstageTraderStatus);
		return "";
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
	
	//当选择列时--所有业务通用
    function selectionChanged(grid, updateId, deleteId){
        var rows = grid.getSelecteds();
        if(rows.length>1){
            nui.get(updateId).disable();
            nui.get(deleteId).disable();
        }else{
            nui.get(updateId).enable();
            nui.get(deleteId).enable();
        }
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
    	rowdblclickFun_common_ZQMM("JY_ZQMM/CFJYProductProcessForm_show_ZQMM.jsp", "债券买卖明细展示", 750, 528, e, grid_ZQMM, "query", "TG");
    });
    //新增
    function add_ZQMM() {
    	add("JY_ZQMM/CFJYProductProcessForm_ZQMM.jsp", "债券买卖新增记录", 750, 528, grid_ZQMM);
    }
    
    //Excel新增
    function add_excel() {
		mini.open({
		    url:"<%=request.getContextPath() %>/ProductProcess/ExcelUploadAdd/excelUploadAdd.jsp",
		    title: "Excel导入新增指令/建议", width: 850, height: 580,
		    overflow:"hidden",
		    onload: function () {
		        
		    },
		    ondestroy: function (action) {
		        grid_ZQMM.reload();
		    }
		});
    }   
    
    //编辑
    function edit_ZQMM() {
    	edit_common_ZQMM("JY_ZQMM/CFJYProductProcessForm_ZQMM.jsp", "债券买卖编辑数据", 750, 528, grid_ZQMM, "edit", "TG");
    }
    //废弃
	function remove_ZQMM(){
		remove_common_ZQMM(grid_ZQMM);
	}
	//确认
	function confirm_ZQMM(){
		confirm_common_ZQMM(grid_ZQMM);
	}
	//查询
	function search_ZQMM() {
		search(grid_ZQMM, "#form_ZQMM");
	}
	//当选择列时
    function selectionChanged_ZQMM(){
    	selectionChanged(grid_ZQMM, "update_ZQMM", "del_ZQMM");
    }
	//重新刷新页面
    function refresh(){
        var form = new  nui.Form("#form_ZQMM");
        var json = form.getData(false,false);
        grid_ZQMM.load(json);//grid查询
        nui.get("update_ZQMM").enable();
    }
    //重置查询条件
    function reset(){
        var form = new nui.Form("#form_ZQMM");//将普通form转为nui的form
        form.reset();
    }
    //enter键触发查询
    function onKeyEnter(e) {
        search_ZQMM();
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
    	rowdblclickFun_common_ZNHG("JY_ZNHG/CFJYProductProcessForm_show_ZNHG.jsp", "正逆回购明细展示", 800, 620, e, grid_ZNHG, "query", "TG");
    });
    //新增
    function add_ZNHG() {
    	add("JY_ZNHG/CFJYProductProcessForm_ZNHG.jsp", "正逆回购新增记录", 800, 620, grid_ZNHG);
    }
    //编辑
    function edit_ZNHG() {
    	edit_common_ZNHG("JY_ZNHG/CFJYProductProcessForm_ZNHG.jsp", "正逆回购编辑数据", 800, 620, grid_ZNHG,"edit", "TG");
    }
    //废弃
	function remove_ZNHG(){
		remove_common_ZNHG(grid_ZNHG);
	}
	//确认
	function confirm_ZNHG(){
		confirm_common_ZNHG(grid_ZNHG);
	}
	//查询
	function search_ZNHG() {
		search(grid_ZNHG, "#form_ZNHG");
	}
	//当选择列时
    function selectionChanged_ZNHG(){
    	selectionChanged(grid_ZNHG, "update_ZNHG", "del_ZNHG");
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
    	rowdblclickFun("JY_ZQSJ/CFJYProductProcessForm_show_ZQSJ.jsp", "申购缴款明细展示", 700, 450, e, grid_ZQSJ);
    });
    //新增
    function add_ZQSJ() {
    	add("JY_ZQSJ/CFJYProductProcessForm_ZQSJ.jsp", "申购缴款新增记录", 700, 450, grid_ZQSJ);
    }
    //编辑
    function edit_ZQSJ() {
    	edit("JY_ZQSJ/CFJYProductProcessForm_ZQSJ.jsp", "申购缴款编辑数据", 700, 450, grid_ZQSJ);
    }
    //废弃
	function remove_ZQSJ(){
		remove(grid_ZQSJ);
	}
	//确认
	function confirm_ZQSJ(){
		confirm(grid_ZQSJ);
	}
	//查询
	function search_ZQSJ() {
		search(grid_ZQSJ, "#form_ZQSJ");
	}
	//当选择列时
    function selectionChanged_ZQSJ(){
        selectionChanged(grid_ZQSJ, "update_ZQSJ", "del_ZQSJ");
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
    	rowdblclickFun("JY_JJSS/CFJYProductProcessForm_show_JJSS.jsp", "基金申赎明细展示", 700, 350, e, grid_JJSS);
    });
    //新增
    function add_JJSS() {
    	add("JY_JJSS/CFJYProductProcessForm_JJSS.jsp", "基金申赎新增记录", 700, 350, grid_JJSS);
    }
    //编辑
    function edit_JJSS() {
    	edit("JY_JJSS/CFJYProductProcessForm_JJSS.jsp", "基金申赎编辑数据", 700, 350, grid_JJSS);
    }
    //废弃
	function remove_JJSS(){
		remove(grid_JJSS);
	}
	//确认
	function confirm_JJSS(){
		confirm(grid_JJSS);
	}
	//查询
	function search_JJSS() {
		search(grid_JJSS, "#form_JJSS");
	}
	//当选择列时
    function selectionChanged_JJSS(){
        selectionChanged(grid_JJSS, "update_JJSS", "del_JJSS");
    }
    
    <%-- 大宗交易业务 --%>
    var grid_DZJY = nui.get("datagrid_DZJY");
    var formData_DZJY = new nui.Form("#form_DZJY").getData(false,false);
    //表格行增加背景色
    grid_DZJY.on("drawcell", function (e) {
    	drawcellFun(e);
    });
    //行双击时弹出页面展示该指令/建议详细信息
    grid_DZJY.on("rowdblclick", function (e) {
    	rowdblclickFun("JY_DZJY/CFJYProductProcessForm_show_DZJY.jsp", "大宗交易明细展示", 600, 380, e, grid_DZJY);
    });
    //新增
    function add_DZJY(){
      add("JY_DZJY/CFJYProductProcessForm_DZJY.jsp", "大宗交易新增记录", 600, 380, grid_DZJY);
    }
    //编辑
	function edit_DZJY(){
	   edit("JY_DZJY/CFJYProductProcessForm_DZJY.jsp", "大宗交易编辑数据", 600, 380, grid_DZJY);
	}
	//废弃
	function remove_DZJY(){
	   remove(grid_DZJY);
	}
	//确认
	function confirm_DZJY(){
		confirm(grid_DZJY);
	}
    //查询
	function search_DZJY() {
		search(grid_DZJY, "#form_DZJY");
	}
	//列选择时调用
	function selectionChanged_DZJY(){
	  selectionChanged(grid_DZJY, "update_DZJY", "del_DZJY");
	}
	
	
	
	
    
    <%-- 投票业务 --%>
    var grid_TP = nui.get("datagrid_TP");
    var formData_TP = new nui.Form("#form_TP").getData(false,false);
    //表格行增加背景色
    grid_TP.on("drawcell", function (e) {
    	drawcellFun(e);
    });
    //行双击时弹出页面展示该指令/建议详细信息
    grid_TP.on("rowdblclick", function (e) {
    	rowdblclickFun("JY_TP/CFJYProductProcessForm_show_TP.jsp", "投票明细展示", 820, 620, e, grid_TP);
    });
    //新增
    function add_TP(){
      add("JY_TP/CFJYProductProcessForm_TP.jsp", "投票新增记录", 820, 590, grid_TP);
    }
    //编辑
	function edit_TP(){
	   edit("JY_TP/CFJYProductProcessForm_TP.jsp", "投票编辑数据", 820, 590, grid_TP);
	}
	//废弃
	function remove_TP(){
	   remove(grid_TP);
	}
	//确认
	function confirm_TP(){
		confirm(grid_TP);
	}
    //查询
	function search_TP() {
		search(grid_TP, "#form_TP");
	}
	//列选择时调用
	function selectionChanged_TP(){
	  selectionChanged(grid_TP, "update_TP", "del_TP");
	}
	
	
	
	
	<%-- 其他指令/建议业务 --%>
	var grid_QTZL = nui.get("datagrid_QTZL");
    var formData_QTZL = new nui.Form("#form_QTZL").getData(false,false);
    //grid_QTZL.load(formData_QTZL);
    
    //表格行增加背景色
    grid_QTZL.on("drawcell", function (e) {
    	//drawcellFun(e);
    	var record = e.record;
		var	column = e.column;
		var	field = e.field;
		var	value = e.value;
		
		//设置行样式，交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
		if(record.validStatus=="1" || record.validStatus=="4"){
			e.rowCls = "validStatus_modify_1_4";
		}else if(record.validStatus=="2"){
			e.rowCls = "validStatus_del_2";
		}else if(record.validStatus=="3"){
			e.rowCls = "validStatus_modify_3";
		}else{
			//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
			if(record.processStatus=="-2"){
				e.rowCls = "processStatus_-2_tg";
			}else if(record.processStatus=="-1" || record.processStatus=="0"){
				e.rowCls = "processStatus_-1_tg";
				
				//若当前用户有权限处理该指令/建议单，则该指令/建议单使用特定背景色显示
				var userIdRelaType07All = record.userIdRelaType07All!=null?record.userIdRelaType07All:"";//07-产品与投顾确认权限(全部人员)
	        	var userIdRelaType07 = record.userIdRelaType07!=null?record.userIdRelaType07:"";//07-产品与投顾确认权限(过滤自己)
				var userIdRelaTypeA1 = record.userIdRelaTypeA1!=null?record.userIdRelaTypeA1:"";//A1-投顾录入确认可为同一人员
				var hasPermission = false;
				if(userIdRelaType07All!=null && userIdRelaType07All!=""){//设置了复核人员
					var userIdRelaType07Arr = userIdRelaType07.split(",");//默认过滤自己
					if(userIdRelaTypeA1!=null && userIdRelaTypeA1!=""){//可为同一人员
						userIdRelaType07Arr = userIdRelaType07All.split(",");
					}
					for(var j=0; j<userIdRelaType07Arr.length; j++){
						var userIdTemp = userIdRelaType07Arr[j];
						if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
				}else{
					hasPermission = true;
				}
				if(hasPermission==true){
					e.rowCls = "processStatus_wait_confirm";
				}
			}else if(record.processStatus=="1"){
			    //无权限复核的记录
			    var hasPermission = false;	
		        var userIdRelaTypeA3 = record.userIdRelaTypeA3!=null?record.userIdRelaTypeA3:"";//A3-组合与委托人确认权限
			    if(userIdRelaTypeA3!=null&&userIdRelaTypeA3!=""){
				    var userIdRelaTypeA3Array=userIdRelaTypeA3.split(",");
					for(var loop=0;loop<userIdRelaTypeA3Array.length;loop++){
					    var userIdTemp = userIdRelaTypeA3Array[loop];
					    if(userIdTemp==userId){
							hasPermission = true;
							break;
						}
					}
				}
				if(hasPermission==true){
					e.rowCls = "processStatus_wait_confirm";
				}
			}else if(record.processStatus=="7"){
				e.rowCls = "processStatus_1_tg";
			}else if(record.processStatus=="2"){
				e.rowCls = "processStatus_2_tg";
			}else if(record.processStatus=="3"){
				e.rowCls = "processStatus_3_tg";
			}else if(record.processStatus=="4"){
				e.rowCls = "processStatus_4_tg";
			}else if(record.processStatus=="5"){
				e.rowCls = "processStatus_5_tg";
			}else if(record.processStatus=="6"){
				e.rowCls = "processStatus_6_tg";
			}
		}
    });
    //行双击时弹出页面展示该指令/建议详细信息
    grid_QTZL.on("rowdblclick", function (e) {
    	rowdblclickFun("JY_QTZL/CFJYProductProcessForm_show_QTZL.jsp", "其他指令/建议明细展示", 780, 635, e, grid_QTZL);
    });
    
    //新增
    function add_QTZL() {
    	add("JY_QTZL/CFJYProductProcessForm_QTZL.jsp", "其他指令/建议新增记录", 780, 555, grid_QTZL);
    }
    //编辑
    function edit_QTZL() {
    	//edit("JY_QTZL/CFJYProductProcessForm_QTZL.jsp", "其他指令/建议编辑数据", 780, 555, grid_QTZL);
    	var row = grid_QTZL.getSelected();
    	var title="其他指令/建议编辑数据";
    	var width="780";
    	var height="555";
        if (row) {
        	//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
        	var validStatus = row.validStatus;
        	if(validStatus=="1" || validStatus=="2" || validStatus=="4" ){
        		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
        		return;
        	}
        	//“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
        	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
        	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
        	var processStatus = row.processStatus;
        	var msg = "";
        	
        	if(processStatus=="-2"){
        	}else if(processStatus=="-1"){
        		msg = "该指令/建议已补齐，确定要继续修改吗？";
        	}else if(processStatus=="0" || processStatus=="1"){
        	}else if(processStatus=="7"){
        		msg = "该指令/建议已复核，确定要继续修改吗？";
        	}else if(processStatus=="2"){
        		msg = "该指令/建议投资经理已下单，确定要继续修改吗？";
        	}else if(processStatus=="3"){
        		msg = "该指令/建议交易员已填单，确定要继续修改吗？";
        	}else if(processStatus=="4"){
        		msg = "该指令/建议交易已发送，确定要继续修改吗？";
        	}else if(processStatus=="5"){
        		msg = "该指令/建议前台已成交，不能再修改，仅可以废弃";
        	}else if(processStatus=="6"){
        		msg = "该指令/建议后台已成交，不能再做任何操作";
        	}
        	
        	//尚未确认的记录直接修改
        	if(processStatus=="-2" || processStatus=="0" || processStatus=="1"|| processStatus=="7"){
        		nui.open({
	                url: "<%=request.getContextPath()%>/ProductProcess/JY_QTZL/CFJYProductProcessForm_QTZL.jsp",
	                title: title,
	                width: width,
	                height: height,
	                onload: function () {
	                    var iframe = this.getIFrameEl();
	                    var data = {pageType:"edit",roleType:"TG",record:{cfjyproductprocess:row}};
	                    //直接从页面获取，不用去后台获取
	                    iframe.contentWindow.setFormData(data);
	                },
	                ondestroy: function (action) {
	                    grid_QTZL.reload();
	                }
	            });
	        
        	}else if(processStatus=="-1" || processStatus=="2" || processStatus=="3" || processStatus=="4"){
        		nui.confirm(msg,"系统提示",function(action){
					if(action=="ok"){
						nui.open({
			                url: "<%=request.getContextPath()%>/ProductProcess/JY_QTZL/CFJYProductProcessForm_QTZL.jsp",
			                title: title,
			                width: width,
			                height: height,
			                onload: function () {
			                    var iframe = this.getIFrameEl();
			                    var data = {pageType:"edit",roleType:"TG",record:{cfjyproductprocess:row}};
			                    //直接从页面获取，不用去后台获取
			                    iframe.contentWindow.setFormData(data);
			                },
			                ondestroy: function (action) {
			                    grid_QTZL.reload();
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
    //废弃
	function remove_QTZL(){
		//remove(grid_QTZL);
		var rows = grid_QTZL.getSelecteds();
	    if(rows.length > 0){
	    
	    	//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
        	var validStatus = rows[0].validStatus;
        	if(validStatus=="1" || validStatus=="2" || validStatus=="4"){
        		nui.alert("该指令/建议已无效，不能再做任何操作","提示");
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
		        	var msg = "";
		        	
		        	if(processStatus=="-1"){
		        		msg = "该指令/建议已补齐，确定要继续废弃吗？";
		        	}else if(processStatus=="-2" || processStatus=="0" || processStatus=="1"|| processStatus=="7"){
		        		msg = "确定废弃选中指令/建议？";
		        	}else if(processStatus=="2"){
		        		msg = "该指令/建议投资经理已下单，确定要继续废弃吗？";
		        	}else if(processStatus=="3"){
		        		msg = "该指令/建议交易员已填单，确定要继续废弃吗？";
		        	}else if(processStatus=="4"){
		        		msg = "该指令/建议交易已发送，确定要继续废弃吗？";
		        	}else if(processStatus=="5"){
		        		msg = "该指令/建议前台已成交，确定要继续废弃吗？";
		        	}else if(processStatus=="6"){
		        		nui.alert("该指令/建议后台已成交，不能再做任何操作","提示");
		        		return;
		        	}
			    
			        nui.confirm(msg,"系统提示",
			        function(action){
			            if(action=="ok"){
					        nui.prompt("请输入废弃原因：", "请输入",
					            function (action, value) {
					                if (action == "ok") {
					                    if(value==null || value==""){
					                    	nui.alert("请输入废弃原因再提交！");
					                    	return;
					                    }
					                    
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
									              if(returnValidStatus=="0" || returnValidStatus=="3"){
									              	  //封装主键ID、指令/建议流程处理状态、废弃原因字段传输到后台处理
								                      var json = nui.encode({cfjyproductprocesss:[{processId:rows[0].processId, processStatus:processStatus, abandonedReasons:value}]});
									                  grid_QTZL.loading("正在废弃中,请稍等...");
									                  $.ajax({
									                      url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.deleteCFJYProductProcesss.biz.ext",
									                      type:'POST',
									                      data:json,
									                      cache: false,
									                      contentType:'text/json',
									                      success:function(text){
									                          var returnJson = nui.decode(text);
									                          if(returnJson.exception == null){
									                              grid_QTZL.reload();
									                              nui.alert("废弃成功", "系统提示", function(action){
									                              });
									                          }else{
									                              grid_QTZL.unmask();
									                              nui.alert("废弃失败", "系统提示");
									                          }
									                      }
									                 });
									              }else{
													  nui.alert("该指令/建议已无效，不能再做任何操作","提示");
			        								  return;
									              }
									          }
									      });
					                }
					            },
					            true
					        );
			            }
			         });
                }
            });
	    }else{
	        nui.alert("请选中一条记录！");
	    }
	}
	//确认
	function confirm_QTZL(){
		//confirm(grid_QTZL);
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
    		var confirmStr = "";//该阶段不能确认字符串
    		var noPermissionStr = "";//无权限确认的记录
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];//产品记录
    			var combProductName = record.combProductName;//产品名称
    			var investProductNum = record.investProductNum;//编号
	        	var processStatus = record.processStatus;//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
				var userIdRelaType07All = record.userIdRelaType07All!=null?record.userIdRelaType07All:"";//07-产品与投顾确认权限(全部人员)
	        	var userIdRelaType07 = record.userIdRelaType07!=null?record.userIdRelaType07:"";//07-产品与投顾确认权限(过滤自己)
				var userIdRelaTypeA1 = record.userIdRelaTypeA1!=null?record.userIdRelaTypeA1:"";//A1-投顾录入确认可为同一人员
	        	var userIdRelaTypeA3 = record.userIdRelaTypeA3!=null?record.userIdRelaTypeA3:"";//A1-投顾录入确认可为同一人员
	        	//投顾只能确认“交易员填单指令/建议补齐完成”或“投资顾问录入完成”阶段状态的指令/建议
	        	if(processStatus!="-1" && processStatus!="0"&& processStatus!="1"){//新增复核结点
	        		confirmStr += "、" + investProductNum + "-" + combProductName;
	        	}
	        	//无权限确认的记录
		        var hasPermission = false;
	        	if(processStatus=="-1"||processStatus=="0"){
					if(userIdRelaType07All!=null && userIdRelaType07All!=""){//设置了复核人员
						var userIdRelaType07Arr = userIdRelaType07.split(",");//默认过滤自己
						if(userIdRelaTypeA1!=null && userIdRelaTypeA1!=""){//可为同一人员
							userIdRelaType07Arr = userIdRelaType07All.split(",");
						}
						for(var j=0; j<userIdRelaType07Arr.length; j++){
							var userIdTemp = userIdRelaType07Arr[j];
							if(userIdTemp==userId){
								hasPermission = true;
								break;
							}
						}
					}
	        	}else if(processStatus=="1"){
		        	if(hasPermission ==false&&userIdRelaTypeA3!=null&&userIdRelaTypeA3!=""){
					    var userIdRelaTypeA3Array=userIdRelaTypeA3.split(",");
						for(var loop=0;loop<userIdRelaTypeA3Array.length;loop++){
						    var userIdTemp = userIdRelaTypeA3Array[loop];
						    if(userIdTemp==userId){
								hasPermission = true;
								break;
							}
						}
					}
	        	}
				if(hasPermission!=true){
					noPermissionStr += "、" + investProductNum + "-" + combProductName;
				}
    		}
    		if(confirmStr!=null && confirmStr!="" && confirmStr.length>0){
    			confirmStr = confirmStr.substr(1,confirmStr.length);
    			var msg = "您只能确认“指令/建议已录入”或“指令/建议已补齐”阶段的指令/建议！</br>【"+confirmStr+"】</br>指令/建议不符合要求，请先剔除";
    			nui.alert(msg,"提示");
    			return;
    		}
    		if(noPermissionStr!=null && noPermissionStr!="" && noPermissionStr.length>0){
    			noPermissionStr = noPermissionStr.substr(1,noPermissionStr.length);
    			var msg = "【"+noPermissionStr+"】</br>指令/建议您没有权限确认，请先剔除";
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
        selectionChanged(grid_QTZL, "update_QTZL", "del_QTZL");
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
		window.open('<%=request.getContextPath()%>/ProductProcess/CFJYProductProcessList_input.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
</script>
</body>
</html>
