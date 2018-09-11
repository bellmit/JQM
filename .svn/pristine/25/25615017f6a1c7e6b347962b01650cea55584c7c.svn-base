<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 石浩
  - Date: 2016-08-16 14:36:39
  - Description:
  
-->
<head>
<title>新债信息查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body style="width:100%;height:100%;overflow: hidden; margin: 0px;">
					<div class="search-condition">
					  <div class="list">
			            <div id="form1" class="nui-form"  align="center" style="height:10%" >
			                <!-- 排序字段 -->
			                <form id="queryForm" action="">
			                
			                <input type="hidden" class="nui-hidden" id="excelData" name="excelData" />
			                <input type="hidden" class="nui-hidden" id="fileName" name="fileName" />
			                <input type="hidden" class="nui-hidden" id="cStatus" name="map/cStatus" value="2"/>
			                <table id="table1" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
			                    <tr>
			                        <td style="width:60px" align="right">
			                            	债券代码:
			                        </td>
			                        <td style="width:25%" align="left">
			                            <input class="nui-textbox" id="processDate" name="map/vcStockCode"  width="100%"/>
			                        </td>
			                        <td style="width:80px" align="right">
			                        	债券简称:
			                        </td>
			                        <td style="width:25%" align="left">
			                         	<input class="nui-textbox" id="processDate" name="map/vcStockName" width="100%"/>
			                        </td>
			                        <td style="width:80px" align="right">
			                        	登记托管机构:
			                        </td>
			                        <td style="width:25%" align="left">
			                            <input class="nui-dictcombobox" 
					                        dictTypeId="CF_JY_DJTGCS" valueField="dictID" textField="dictName"
					                        name="map/vcPaymentPlace" showClose="true" oncloseclick="onCloseClickValueEmpty" 
					                         id="vcPaymentPlace"  width="100%"/>
			                        </td>
			                        <td style="width:60px" align="right">
			                                                                                                   债券类别:
			                        </td>
			                        <td style="width:25%" align="left">
			                              <!-- <input class="nui-dictcombobox" id="vcStockType" name="map/vcStockType" showClose="true" oncloseclick="onCloseClickValueEmpty"  
			                              showNullItem="false"  valueField="ID" textField="TEXT"  width="100%"
			                              url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext?type=1"/> -->
			                              <input style="width: 100%;" id="vcStockType" name="map/vcStockType" class="mini-treeselect"  multiSelect="true" 
									        textField="text" valueField="id" parentField="pid" checkRecursive="false" 
									        emptyText="全部" nullItemText="全部" showFolderCheckBox="false"
									        showFolderCheckBox="true"   expandOnLoad="true" showTreeIcon="false" showClose="true" 
									        oncloseclick="onCloseClickValueEmpty" />
			                        </td>
			                       
			                   </tr>
			                   <tr>
			                   		 <td align="right">
			                            	发行主体:
			                        </td>
			                        <td align="left">
			                           <input class="nui-textbox" name="map/vcIssuerNameFull" width="100%"/>
			                        </td>
			                        <td align="right">
			                            	发行日期:
			                        </td>
			                        <td  align="left" style="width:25%">
			                            <input class="nui-datepicker" id="lIssueBeginDateMin" format="yyyy-MM-dd" name="map/lIssueBeginDateMin" style="width:100%"/>
			                        </td>
			                         <td align="center">
			                            	至
			                        </td>
			                        <td  align="left" style="width:25%">
			                            <input class="nui-datepicker" id="lIssueBeginDateMax" format="yyyy-MM-dd" name="map/lIssueBeginDateMax" style="width:100%"/>
			                        </td>
			                        <td align="right">
				                       
								            <a class='nui-button' plain='false' iconCls="icon-search"  onclick="search()">
								                	查询
								            </a>
								     </td> 
								     <td align="left">
								            <a class='nui-button' plain='false' iconCls="icon-reload"  onclick="reset()">
								                	重置
								            </a>
			                        </td>
			                    </tr>
			                </table>
			               </form>
			            </div>
			          </div>  
			        </div>
			        <div class="nui-toolbar" style="border-bottom:0;padding:0px">
			                <table style="width:100%;height:20px;">
			                    <tr>
			                        <td style="width:100%;">
			                              <privilege:operation sourceId="ATS_XZCX_DC" sid="exportExcel" clazz="nui-button" onClick="exportExcel()" lableName="导出到本地"  iconCls="icon-download" ></privilege:operation>
			                              <privilege:operation sourceId="ATS_XZCX_O32DC" sid="o32exportExcel" clazz="nui-button" onClick="exportTemp()" lableName="新债推送"  iconCls="icon-download" ></privilege:operation>
			 			                 <!-- <a class='nui-button' plain='false' iconCls="icon-edit" id="edit" onclick="creditAnalyze()">信用分析</a> -->
			                             <privilege:operation sourceId="ATS_XZCX_XYFX" sid="creditAnalyze" clazz="nui-button" onClick="creditAnalyze()" lableName="信用分析"  iconCls="icon-edit" ></privilege:operation>
			                             <privilege:operation sourceId="ATS_XZCX_XYFX" sid="appraise"  clazz="nui-button" onClick="bondAppraise()" lableName="历史评级"  iconCls="icon-edit" ></privilege:operation>
			                             <privilege:operation sourceId="ATS_XZCX_XYFX" sid="lookDetail" clazz="nui-button" onClick="lookDetail()" lableName="查看详情"  iconCls="icon-edit" ></privilege:operation>
			                             <privilege:operation sourceId="ATS_XZCX_XZXXXZ" sid="stockIssueInfoDown" clazz="nui-button" onClick="wordDownload1()" lableName="新债信息表下载"  iconCls="icon-download" ></privilege:operation>
			                             <!-- <privilege:operation sourceId="ATS_XZCX_O32DC" sid="o32exportExcel" clazz="nui-button" onClick="o32exportExcel()" lableName="导出到O32"  iconCls="icon-download" ></privilege:operation>
			                             <a class='nui-button' plain='false' iconCls="icon-download" id="add" onclick="synBondInfoData()">同步O32数据</a>
			                             <privilege:operation sourceId="ATS_XZCX_TBO32SJ" sid="synBondInfoData" clazz="nui-button" onClick="synBondInfoData()" lableName="同步O32数据"  iconCls="icon-find" ></privilege:operation>
			                             <a class='nui-button' plain='false' iconCls="icon-edit" id="edit" onclick="synDataByWind()">同步Wind数据</a>
			                             <privilege:operation sourceId="ATS_XZCX_TBWINESJ" sid="synDataByWind" clazz="nui-button" onClick="synDataByWind()" lableName="同步Wind数据"  iconCls="icon-find" ></privilege:operation>
			                             <a class='nui-button' plain='false' iconCls="icon-download" id="add" onclick="synStockIssueData()">同步O32&Wind数据</a>
			                             <privilege:operation sourceId="ATS_XZCX_TBO32WINDSJ" sid="synStockIssueData" clazz="nui-button" onClick="synStockIssueData()" lableName="同步O32&Wind数据"  iconCls="icon-find" ></privilege:operation> -->
			                        </td>
			                    </tr>
			                </table>
			         </div>
			         
			         <div id="layout1" class="mini-layout" style="width:100%; height:87%;"  borderStyle="border:solid 1px #aaa;"> 
			         <div title="center" region="center"  >      
			         <div class="nui-fit" >  
			         	<div  id="datagrid1"
			                        class="nui-datagrid"
			                        style="width:100%;height:100%;"
			                        url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryDebeIssuesWithPage.biz.ext"
			                        pageSize="20"
			                        onShowRowDetail="onShowRowDetailList"
			                        showPageInfo="true"
			                        multiSelect="true" onselectionchanged="selectionChanged"
			                        sortField="lStockIssueId" sortOrder="desc">
			                        
			                    <div property="columns">
			                        <div type="indexcolumn"></div>
			                        <div type="checkcolumn"></div>
			                        <div field="lStockIssueId" headerAlign="center" allowSort="true" visible=false>业务序号</div>
			                        <div field="lBizId" headerAlign="center" allowSort="true" visible=false>流程序号</div>
			                        <div field="lStockInvestNo" headerAlign="center" allowSort="true" visible=false>证券投资编号</div>
			                        
			                        <div field="vcPaymentPlace" headerAlign="center" allowSort="true" renderer="vcPaymentPlaceRenderer">登记托管机构</div>
			                         
			                        <div field="vcStockCode" headerAlign="center" allowSort="true" >债券代码</div>
			                        
			                        <div field="vcStockName" headerAlign="center" allowSort="true" >债券简称</div>
			                        
			                        <div field="vcStockNameFull" headerAlign="center" allowSort="true" >债券全称</div>
			                        
			                        <div field="typeName" headerAlign="center" allowSort="true" >债券类别</div>
			                           
			                        <div field="enExistLimite" headerAlign="center" allowSort="true" width="80px" align="right">发行期限(年)</div>
			                        
			                        <div field="enIssueBalance" headerAlign="center" allowSort="true"  align="right" width="80px" >发行规模(亿)</div>
			                        
			                         <div field="cStatus" headerAlign="center" allowSort="true" renderer="cStatusRenderer" visible="false">流程状态</div>
			                        
			                        <div field="cBondAppraise" headerAlign="center" align="center" renderer="onBondAppraiseRenderer" width="60px">债券评级</div>
			                        
			                        <div field="vcBondAppraiseOrgan" headerAlign="center" width="150px" allowSort="true"  renderer="onBondAppraiseOrganRenderer">债券评级机构</div>
			                         
									<div field="vcIssueProperty" headerAlign="center" align="center" allowSort="true" width="80"  renderer="issuePropertyRenderer">
			                            	主体类型
			                        </div>
			                        
			                        <div field="vcIssuerNameFull" headerAlign="center" width="100px" allowSort="true" >
			                            	发行主体
			                        </div>
			                        
			                        <div field="cIssueAppraise" headerAlign="center" allowSort="true" align="center" width="80px"  renderer="creditRatingRenderer">
			                            	主体评级
			                        </div>
			                        <div field="vcIssueAppraiseOrgan" headerAlign="center" allowSort="true"  renderer="outRatingOrganRenderer">
			                            	主体评级机构
			                        </div>
			                        
			                        <div field="vcIndustry" headerAlign="center" allowSort="true" visible="false">所属行业</div>
			                        <div field="vcIndustryName" headerAlign="center" allowSort="true">所属行业</div>
				
				                    <div field="vcProvince" headerAlign="center" allowSort="true">所属省份</div>
				                    
				                    <div field="vcGuarantorName" headerAlign="center" allowSort="true" >
			                            	担保人名称
			                        </div>
				                    <div field="cAssureType" headerAlign="center" allowSort="true" renderer="cAssureTypeRenderer">
			                            	担保方式
			                        </div>
				                    
				                    <div field="vcGuarantorSummary" headerAlign="center" allowSort="true">担保人简介</div>
				                     
			                        <div field="lIssuePostDate" headerAlign="center" align="right" allowSort="true" >
			                            	公告日期
			                        </div>
			                        <div field="lIssueBeginDate" headerAlign="center" align="right"  allowSort="true" >
			                            	发行日期
			                        </div>
			
			                        <div field="lPayDate" headerAlign="center" align="right"  allowSort="true" >
			                            	缴款日期
			                        </div>
			                        <div field="lPublishDate" headerAlign="center" align="right"  allowSort="true" >
			                            	上市日期
			                        </div>
			                        <div field="lBegincalDate" headerAlign="center" align="right"  allowSort="true" >
			                            	起息日期
			                        </div>
			                        
			                        <div field="lEndincalDate" headerAlign="center" align="right"  allowSort="true" visible="false">
			                            	到期日期
			                        </div>
			                        
			                        <div field="cInterestType" renderer="rendererRateType" headerAlign="center"allowSort="true" >利率类型</div>
				
									<div field="cPayInterestType" renderer="rendererPayInterstType" headerAlign="center"allowSort="true" >息票品种</div>
									
									<div field="enPayInteval" headerAlign="center" renderer="rendererEnPayInteval" allowSort="true" >付息频率</div>
									
									<div field="enFaceRate" headerAlign="center" align="right" allowSort="true" >票面利率(%)</div>
									
									<div field="cBidType" headerAlign="center" renderer="renderercBidType" allowSort="true" >招标方式</div>
									
									<div field="cPayType" headerAlign="center"allowSort="true" renderer="rendererPaymentType" >缴款方式</div>
									
									<div field="vcSpecialText" headerAlign="center"allowSort="true" renderer="rendererSpecialText">特殊条款</div>
									
									<div field="vcSpecialTextDesc" headerAlign="center"allowSort="true" >特殊条款说明</div>
				
			                        <div field="vcMainUnderwriter" headerAlign="center"  allowSort="true"  >
			                            	主承销商
			                        </div>
			                        <div field="vcDeputyUnderwriter" headerAlign="center"  allowSort="true"  >
			                            	副主承销商
			                        </div>
			                        
			                        <div field="cUnderwriteType" headerAlign="center"  allowSort="true"  renderer="underwriteTypeRenderer">
			                            	承销方式
			                        </div>
			                        
			                        <div field="vcGroupUnderwriter" headerAlign="center"allowSort="true" >承销团</div>
			                        
			                         <div field="cIsHaveSaleback" headerAlign="center" align="center" allowSort="true" renderer="isRenderer">
			                           	             是否具有回售权
			                        </div> 

			                        <div field="cIsHaveBuyback" headerAlign="center" align="center" allowSort="true" renderer="isRenderer">
			                           	            是否具有赎回权
			                        </div>
			                        			                        
			                        <div field="lNextExerciseDate" headerAlign="center"   align="right"  allowSort="true">
			                           	            下一行权日
			                        </div>
			                        
			                        <div field="lOperatorNo" headerAlign="center" align="center" allowSort="true" visible=false>
			                           	           操作员
			                        </div>
			                        
			                         <div field="lCreditAnalyzeNo" headerAlign="center" align="center" allowSort="true" visible=false>
			                           	            信用分析人员
			                        </div>
			                        
			                        <div field="vcCreditAnalyze" headerAlign="center" align="center" allowSort="true" >
			                           	           信用分析
			                        </div>
			                        
			                        <div field="vcIssueType" headerAlign="center" align="center" allowSort="true"  renderer="issueTypeRender">
			                           	            发行方式
			                        </div>
			                        
			                        <div field="vcSpecialLimite" headerAlign="center" align="center" allowSort="true" >
			                           	            特殊期限
			                        </div>			                        	
			                        <div field="vcExistLimiteDesc" headerAlign="center"allowSort="true" >发行规模描述</div>
									
									<div field="vcIssueBeginDateDesc" headerAlign="center"allowSort="true" >发行日期描述</div>
									<div field="vcTenderInterval" headerAlign="center"allowSort="true" >投标区间</div>
									<div field="vcUnderwriterInfo" headerAlign="center"allowSort="true" >承销商联系人信息</div>
									<div field="vcIssueAppraiseCsrc" headerAlign="center"allowSort="true" visible="false">所属行业(证监会二级)</div>
									<div field="vcIssueAppraiseCsrcName" headerAlign="center"allowSort="true" >所属行业(证监会二级)</div>
									<div field="vcMortStockName" headerAlign="center"allowSort="true" >股票名称</div>
									<div field="vcMortStockAmount" headerAlign="center"allowSort="true" >股票抵押数量(万股)</div>
									<div field="vcMortStockCode" headerAlign="center"allowSort="true" >股票代码</div>
									<div field="enIssuerNetValue" headerAlign="center"allowSort="true" >公司净资产</div>
									<div field="vcCityLevel" headerAlign="center"allowSort="true" renderer="vcCityLevelRender">城投行政级别</div>
									<div field="lNInterestRateJumpPoints" headerAlign="center"allowSort="true" >下一利率跳升点数</div>
			                        <div field="cSource" headerAlign="center" allowSort="true"   visible=false>数据来源</div>
			                        
			                        <div field="vcInterCode" headerAlign="center" allowSort="true"  visible=false>债券内码</div>
			                        
			                        <div field="vcStockCodeWind" headerAlign="center" allowSort="true" visible=false>债券代码_wind</div>
			                        
			                        
			                        
			                        <div field="cMarketNo" headerAlign="center" allowSort="true" visible=false>交易市场</div>
			                        
			                        <div field="vcStockType" headerAlign="center" allowSort="true" visible=false>债券类别编码</div>
			                        
			                        <div field="cStatus" headerAlign="center" allowSort="true" renderer="cStatusRenderer" visible=false>流程状态</div>
			                        
			                        <div field="vcInterCodeWind" headerAlign="center" allowSort="true"  visible=false>wind内码</div>
			                        
			                    </div>
			                 </div>
			               </div>
			               </div>
			               <div title="新债详细信息" region="south" showSplit="false" showHeader="true" height="270" showSplitIcon="true" >
						        <div id="editForm1" style="margin-right:15px">
						            <input class="mini-hidden" name="id"/>
						             <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed; ">
							                <tr>
							                   <td align="right">登记托管机构:</td>
											   <td align="left"><input id="vcPaymentPlace" width="100%"
													class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS"
													name="vcPaymentPlace" 
													readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
							                    <td  align="right">债券代码:</td>
							                    <td  align="left">
							                    	<input align="left" width="100%" id="vcStockCode" name="vcStockCode" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td   align="right">债券简称:</td>
							                    <td   align="left">
							                    	<input align="left" width="100%" id="vcStockName" name="vcStockName" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td   align="right">债券全称:</td>
							                    <td    align="left">
							                    	<input align="left" width="100%" name="vcStockNameFull" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td   align="right">债券类别:</td>
							                    <td   align="left">
							                    	<input align="left" width="100%" name="typeName" name="typeName" class="mini-textbox"   readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							                <tr>
							                    <td align="right">发行期限(年):</td>
							                    <td align="left">
							                    	<input id="enExistLimite" width="100%" name="enExistLimite" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">发行规模(亿):</td>
							                    <td align="left">
							                    	<input id="enIssueBalance" width="100%" name="enIssueBalance" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">债券评级:</td>
							                    <td align="left">
							                    	<input id="cBondAppraise" width="100%" name="cBondAppraise" class="nui-dictcombobox" dictTypeId="creditRating" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">债券评级机构:</td>
							                    <td align="left">
							                    	<input id="vcBondAppraiseOrgan" width="100%" name="vcBondAppraiseOrgan" class="nui-dictcombobox" dictTypeId="outRatingOrgan" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">主体评级:</td>
							                    <td align="left">
							                    	<input id="cIssueAppraise" width="100%" name="cIssueAppraise" class="nui-dictcombobox" dictTypeId="issuerRating" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							                
							                 <tr>
							                    <td align="right">主体类型:</td>
							                    <td align="left">
							                    	<input id="vcIssueProperty" width="100%" name="vcIssueProperty" class="nui-dictcombobox"  dictTypeId="ATS_FM_ISSUE_PROPERTY" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">发行主体:</td>
							                    <td align="left">
							                    	<input id="vcIssuerNameFull" width="100%" name="vcIssuerNameFull" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">主体评级机构:</td>
							                    <td align="left">
							                    	<input id="vcIssueAppraiseOrgan" width="100%" name="vcIssueAppraiseOrgan" class="nui-dictcombobox" dictTypeId="outRatingOrgan" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">所属行业:</td>
											    <td align="left"><input id="vcIndustryName" width="100%"
													name="vcIndustryName" class="mini-textbox" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
												<td align="right">所属省份:</td>
												<td align="left"><input id="vcProvince" width="100%"
													name="vcProvince" class="mini-textbox" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>	
							                </tr>
							                
							                 <tr>
							                    <td align="right">公告日期:</td>
							                    <td align="left">
							                    	<input id="lIssuePostDate" width="100%" name="lIssuePostDate" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">发行日期:</td>
							                    <td align="left">
							                    	<input id="lIssueBeginDate" width="100%" name="lIssueBeginDate" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right" style="width:90px;">投标截止时间:</td>
												<td align="left"><input id="dBidLimitTime" width="100%"
													name="dBidLimitTime" class="nui-datepicker" format="yyyy-MM-dd hh:mm:ss"
													readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
							                    <td align="right">缴款日期:</td>
							                    <td align="left">
							                    	<input id="lPayDate" width="100%" name="lPayDate" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">上市日期:</td>
							                    <td align="left">
							                    	<input id="lPublishDate" width="100%" name="lPublishDate" class="mini-textbox"  readonly="true"   inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							                
							                <tr>
							                    <td align="right">利率类型:</td>
												<td align="left"><input id="cInterestType" width="100%"
													name="cInterestType" class="nui-dictcombobox" dictTypeId="rateType" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
												<td align="right">息票品种:</td>
												<td align="left"><input id="cPayInterestType" width="100%"
													name="cPayInterestType" readonly="true"
													class="nui-dictcombobox" dictTypeId="payInterestType"
													inputStyle="background-color:#f0f0f0;" /></td>
												<td align="right">付息频率:</td>
												<td align="left"><input id="enPayInteval" width="100%"
													name="enPayInteval"class="nui-dictcombobox" dictTypeId="ATS_CF_JY_FREQUENCY" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
							                   	<td align="right">票面利率(%):</td>
												<td align="left"><input id="enFaceRate" width="100%"
													name="enFaceRate" class="mini-textbox" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
												<td align="right">缴款方式:</td>
												<td align="left"><input id="cPayType" width="100%"
													name="cPayType" class="nui-dictcombobox" dictTypeId="ATS_FM_PAYMENT" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>				                    
							                </tr>
							                
							                <tr>
							                    <td align="right">主承销商:</td>
							                    <td align="left">
							                    	<input id="vcMainUnderwriter" width="100%" name="vcMainUnderwriter" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">副主承销商:</td>
							                    <td align="left">
							                    	<input id="vcDeputyUnderwriter" width="100%" name="vcDeputyUnderwriter" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">承销方式:</td>
							                    <td align="left">
							                    	<input id="cUnderwriteType" width="100%" name="cUnderwriteType" class="nui-dictcombobox"  dictTypeId="underwriteType" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">承销团:</td>
												<td align="left"><input id="vcGroupUnderwriter" width="100%"
													name="vcGroupUnderwriter" class="mini-textbox"
													readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
												<td align="right">特殊条款:</td>
												<td align="left"><input id="vcSpecialText" width="100%"
													name="vcSpecialText" class="nui-dictcombobox" dictTypeId="specialText" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>	
							                </tr>
							                
							                <tr>
 												<td align="right">招标方式:</td>
												<td align="left"><input id="cBidType" width="100%"
													name="cBidType" class="nui-dictcombobox" dictTypeId="tenderType" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
													
											    <td align="right">起息日期:</td>
												<td align="left"><input id="lBegincalDate" width="100%"
													name="lBegincalDate" class="mini-textbox" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
											    <td align="right">到期日期:</td>
							                    <td align="left">
							                    	<input id="lEndincalDate" width="100%" name="lEndincalDate" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">担保人名称:</td>
							                    <td align="left">
							                    	<input id="vcGuarantorName" width="100%" name="vcGuarantorName" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">信用分析:</td>
												<td align="left"><input id="vcCreditAnalyze" width="100%"
													name="vcCreditAnalyze" class="mini-textbox"
													readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
											</tr>
											         
										    <tr>
												<td align="right">担保方式:</td>
												<td align="left"><input id="cAssuerType" width="100%"
													name="cAssureType" class="nui-dictcombobox" dictTypeId="ATS_FM_ASSUER_TYPE" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
							                    <td align="right">下一行权日:</td>
												<td align="left"><input id="lNextExerciseDate" width="100%"
													name="lNextExerciseDate" class="mini-textbox" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
												<td align="right">是否具有回售权:</td>
							                    <td align="left">
							                    	<input id="cIsHaveSaleback" width="100%" name="cIsHaveSaleback" class="mini-combobox"  data="[{ id: 1, text: '是' }, { id: 0, text: '否'}]" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">是否具有赎回权:</td>
												<td align="left"><input id="cIsHaveBuyback" width="100%"
													name="cIsHaveBuyback" class="mini-combobox"  data="[{ id: 1, text: '是' }, { id: 0, text: '否'}]"
													readonly="true" inputStyle="background-color:#f0f0f0;" /></td>
												<td align="right">发行方式:</td>
							                    <td align="left">
							                    	<input id="vcIssueType" width="100%" name="vcIssueType" class="nui-dictcombobox" dictTypeId="issueType" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    			
							                </tr>
							                <tr>
							                	<td align="right">特殊期限:</td>
							                    <td align="left">
							                    	<input id="vcSpecialLimite" width="100%" name="vcSpecialLimite" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">发行规模描述:</td>
							                    <td align="left">
							                    	<input id="vcExistLimiteDesc" width="100%" name="vcExistLimiteDesc" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">发行日期描述:</td>
							                    <td align="left">
							                    	<input id="vcIssueBeginDateDesc" width="100%" name="vcIssueBeginDateDesc" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">投标区间:</td>
							                    <td align="left">
							                    	<input id="vcTenderInterval" width="100%" name="vcTenderInterval" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">承销商联系人信息:</td>
							                    <td align="left">
							                    	<input id="vcUnderwriterInfo" width="100%" name="vcUnderwriterInfo" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							            </table>
						        </div>
		
						  </div>
			</div>			  
						  
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
</body>
	<script type="text/javascript">
    	nui.parse();
    	
    	var grid = nui.get("datagrid1");
    	var form = new nui.Form("#form1");
    	var msg;
    	
    	var renders = [{ id: "1", text: '是' }, { id: "2", text: '否'}];
    	
    	var formData = form.getData(false,false);
		grid.load(formData);
		$("#editForm1 .mini-buttonedit-buttons").remove();
	    $("#editForm1 .mini-buttonedit-border").css("background-color","#f0f0f0");
		
		function reset(){
			form.reset();
		}
		loadStockTypeAll();
             //加载所有的债券信息
             function loadStockTypeAll(){
             	
             	nui.ajax({
				    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext",
				    type: "post",
				    dataType:"json",
				    success: function (text) {
				    	nui.get("vcStockType").loadList(text.data);
				    }
				});
             	
             }
    	
    	       
         //利率类型
    	function rendererRateType(e){
    		return nui.getDictText("rateType", e.row.cInterestType);
    	}
    	
    	//息票品种
    	function rendererPayInterstType(e){
    		return nui.getDictText("payInterestType", e.row.cPayInterestType);
    	}
    	
    	//付息频率
    	function rendererEnPayInteval(e){
    		var enPay = nui.getDictText("ATS_CF_JY_FREQUENCY", e.row.enPayInteval);
    		if(enPay!=null&&enPay!=""){
    			return enPay;
    		}else{
    			return e.row.enPayInteval;
    		}
    	}
    	//招标方式
    	function renderercBidType(e){
    		return nui.getDictText("tenderType", e.row.cBidType);
    	}
    	
    	//缴款方式
    	function rendererPaymentType(e){
    		return nui.getDictText("ATS_FM_PAYMENT", e.row.cPayType);
    	}
    	
    	  //债券评级机构
        function onBondAppraiseRenderer(e){
        	return nui.getDictText("creditRating",e.row.cBondAppraise);
        }
        
         //债券评级机构
        function onBondAppraiseOrganRenderer(e){
        	return nui.getDictText("outRatingOrgan",e.row.vcBondAppraiseOrgan);
        }
        
        function issuePropertyRenderer(e){
        	return nui.getDictText("ATS_FM_ISSUE_PROPERTY",e.row.vcIssueProperty);
        }
        
        
        function creditRatingRenderer(e){
        	return nui.getDictText("issuerRating",e.row.cIssueAppraise);
        }
        
        function cAssureTypeRenderer(e){
        	return nui.getDictText("ATS_FM_ASSUER_TYPE",e.row.cAssureType);
        }

        function outRatingOrganRenderer(e){
        	return nui.getDictText("outRatingOrgan",e.row.vcIssueAppraiseOrgan);
        }
        
        function underwriteTypeRenderer(e){
        	return nui.getDictText("underwriteType",e.row.cUnderwriteType);
        }
        function lNextExerciseDateRenderer(e){
        	if(e.row.lNextExerciseDate!="" && e.row.lNextExerciseDate!=null){
        		return e.value.substr(0,4);
        	}
        } 
        function issueTypeRender(e){
        	return nui.getDictText("issueType",e.row.vcIssueType);
        } 
        function vcCityLevelRender(e){
        	return nui.getDictText("cityLevel",e.row.vcCityLevel);
        }
		function isRenderer(e) {
            for (var i = 0, l = renders.length; i < l; i++) {
                var g = renders[i];
                if (g.id == e.value) {
                  return g.text;
                }else{
                  return "否";
                }
            }
        }
        
        function cStatusRenderer(e){
			return nui.getDictText("newstockStatus",e.row.cStatus);
		}	
		
		 function vcPaymentPlaceRenderer(e){
        		return nui.getDictText("CF_JY_DJTGCS",e.row.vcPaymentPlace);
        }
        //rendererSpecialText
        function rendererSpecialText(e){
        		return nui.getDictText("specialText",e.row.vcSpecialText);
        }
		//字符串截取日期
		function getSubstr(str){
			var str1=str.substr(0,10);//0开始，截取后面4位 
		 	return str1;
		}
		function toDate(str){
		    var sd=str.split("-");
    	return new Date(sd[0],sd[1],sd[2]);
		}
        //查询
        function search(){
             if(nui.get("appraise")!=undefined){
             	nui.get("appraise").enable();
             }
             if(nui.get("creditAnalyze")!=undefined){
             	nui.get("creditAnalyze").enable();
             }
             if(nui.get("lookDetail")!=undefined){
             	nui.get("lookDetail").enable();
             }
        
        	//校验时间
        	 var lIssueBeginDateMin = toDate(getSubstr(nui.get("lIssueBeginDateMin").getValue()));
             var lIssueBeginDateMax = toDate(getSubstr(nui.get("lIssueBeginDateMax").getValue()));
             if(lIssueBeginDateMin>lIssueBeginDateMax){
             	nui.alert("查询条件日期小于起始日期");
             		return;
             }
        	
        	var data = form.getData(false,false);      //获取表单多个控件的数据
        	var editForm1 = new nui.Form("#editForm1");
        	editForm1.reset();
            grid.load(data);
        }
        
        //导出
       function  exportExcel(){
       		var frm = document.getElementById("queryForm");
       		var rows = grid.getSelecteds();
       		var ids = new Array();
            if (rows.length > 0) {
                for(var i=0;i<rows.length;i++){
                	ids.push(rows[i].lStockIssueId);
                }
                var data = ids.join(',');
                 nui.get("excelData").setValue(data);
                 nui.get("fileName").setValue("新债信息.xls");
				frm.action = "com.cjhxfund.ats.fm.baseinfo.debtIssueExport.flow";
				frm.submit();
            } else {
                nui.alert("请选中一条记录");
                return false;
            }
       }
       
       function o32exportExcel(){
       		var frm = document.getElementById("queryForm");
       		var rows = grid.getSelecteds();
       		var ids = new Array();
            if (rows.length > 0) {
                for(var i=0;i<rows.length;i++){
                	ids.push(rows[i].lStockIssueId);
                }
                var data = ids.join(',');
                 nui.get("excelData").setValue(data);
				frm.action = "com.cjhxfund.ats.fm.baseinfo.o32Export.flow";
				frm.submit();
            } else {
                nui.alert("请选中一条记录");
                return false;
            }
       		 
       }
       
       //信用分析
       function creditAnalyze(){
       		var row = grid.getSelected();
            if (row) {
                nui.open({
                    url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueCreditAnalyze.jsp",
                    title: "信用分析", 
                    width: 450, 
           			height: 210,
                    //allowResize:false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = row;
                        iframe.contentWindow.SetData(data);
                    },
                    ondestroy: function (action) {
                        if(action=="saveSuccess"){
	                        grid.reload();
                   	 	}
                    }
                });
                
            } else {
                nui.alert("请选中一条记录");
            }
       }
         
      function bondAppraise(){
       	var row = grid.getSelected();
        if (row) {
            if(row.cSource == '手工录入'){
   				row.cSource = '1';
   			}else if(row.cSource == '批量导入'){
   				row.cSource = '2';
   			}else if(row.cSource == 'O32数据'){
   				row.cSource = '3';
   			}else if(row.cSource == 'wind数据'){
   				row.cSource = '4';
   			}
              nui.open({
                    url: "<%=request.getContextPath() %>/fm/baseinfo/intfStockInfoQuery/getBondAppraise.jsp",
                    title: "新债历史评级", 
                    width: 700, 
           			height: 500,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = row;
                        iframe.contentWindow.SetData(data);
                    }
                });
        } else {
                nui.alert("请选中一条记录");
            }
            
            
       }  
        //当选择多列时
        function selectionChanged(){
            var rows = grid.getSelecteds();
            if(rows.length>1){
                nui.get("appraise").disable();
                nui.get("creditAnalyze").disable();
                nui.get("lookDetail").disable();
            }else{
                nui.get("appraise").enable();
                nui.get("creditAnalyze").enable();
                nui.get("lookDetail").enable();
            }
        }
        
       function onMarketNoChanged(e) {
		    var vcPaymentPlace = nui.get("vcPaymentPlace");
            var vcStockType = nui.get("vcStockType");
            var id = vcPaymentPlace.getValue();
            if(id=='03'){
	        	id=1;//交易市场
	        }else if(id=='04'){
	        	id=2;
	        }else{
	        	id=5;
			}
			//清空下拉列表
            vcStockType.setValue();
            var url = "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext?cMarketNo=" + id;
            vcStockType.setUrl(url);
        }
        
        function clearStockType(e){
        	if(e.source.value==null || e.source.value==""){
		   			//清空债券类型
		   			var vcStockType = nui.get("vcStockType");
			        vcStockType.setValue("");
		            var url = "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext?type=1";
		            vcStockType.setUrl(url);
		   		}
        }
        
         function synBondInfoData() {
          var form = new nui.Form("#form1");
          var data = form.getData();
          var type = 1;
          var json = nui.encode(data);
          json = nui.encode({buttonType:type});
          msg = commonLoading("正在同步恒生O32数据，请稍后...","系统提示");
          nui.ajax({
            url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getBondInfoData.biz.ext",
            type: "post",
            contentType:'text/json',
            data: json ,
            success: function (text) {
              commonHideMessageBox(msg);
              var returnJson = nui.decode(text);
              if (returnJson.returnValue == true) {
                 nui.alert("同步O32数据结果：成功", "", function(){});
              }
              else {
              	 nui.alert("同步O32数据结果：失败", "", function(){});
              }
            }
          });
        }
        
        function commonLoading(msg,title){
			return nui.loading(msg,title);
			}
		
		 function commonHideMessageBox(messageid){
		    nui.hideMessageBox(messageid);
		 }
        function synDataByWind() {
          var form = new nui.Form("#form1");
          var data = form.getData();
          var type = 2;
          var json = nui.encode(data);
          json = nui.encode({buttonType:type});
          nui.ajax({
            //url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getDataFromWind.biz.ext",
            url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getBondInfoData.biz.ext",
            type: "post",
            contentType:'text/json',
            data: json ,
            success: function (text) {
              var returnJson = nui.decode(text);
              if (returnJson.returnValue == true) {
              	nui.alert("同步Wind数据结果：成功", "", function(){});
              }
              else {
              	 nui.alert("同步Wind数据结果：失败", "", function(){});
              }
            }
          });
        }
        function synStockIssueData() {
          var form = new nui.Form("#form1");
          var data = form.getData();
          var type = 3;
          var json = nui.encode(data);
          json = nui.encode({buttonType:type});
          nui.ajax({
            //url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getStockIssueData.biz.ext",
            url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getBondInfoData.biz.ext",
            type: "post",
            contentType:'text/json',
            data: json ,
            success: function (text) {
              var returnJson = nui.decode(text);
              if (returnJson.returnValue == true) {
                 nui.alert("同步O32&Wind数据结果：成功", "", function(){});
              }
              else {
              	 nui.alert("同步O32&Wind数据结果：失败", "", function(){});
              }
            }
          });
        }
        var isfalse=true;
        function exportTemp(){
           if(isfalse){
            isfalse=false;
       		var rows = grid.getSelecteds();
       		var nodes = [];
       		var source = '';
       		if(rows.length > 0){
       			for(var i=0;i<rows.length;i++){
       				if(rows[i].cSource == '手工录入'){
       					source = '1';
       				}else if(rows[i].cSource == '批量导入'){
       					source = '2';
       				}else if(rows[i].cSource == 'O32数据'){
       					source = '3';
       				}else if(rows[i].cSource == 'wind数据'){
       					source = '4';
       				}else if(rows[i].cSource == '手工修改'){
       					source = '5';
       				}else if(rows[i].cSource == '手工去重'){
       					source = '6';
       				}else if(rows[i].cSource == '无债券申购'){
       					source = '7';
       				}else{
       					source = '8';
       				}
       				nodes.push({id:rows[i].lStockIssueId,source:source});
       			}
       			var json = nui.encode({nodes:nodes});
		       		nui.ajax({
		            url: "com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.exportTemp.biz.ext",
		            type: "post",
		            contentType:'text/json',
		            data: json ,
		            success: function (text) {
		              var returnJson = nui.decode(text);
		              isfalse=true;
		              if (returnJson.exception == null) {
		                 nui.alert("新债推送结果  ：成功", "", function(){});
		              }
		              else {
		              	 nui.alert("新债推送结果：失败", "", function(){});
		              }
		            }
		          });
       		}else{
       			nui.alert("请选择要推送的新债 !", "提示", function(){});
       		}
       	  }
        }
        //行双击时弹出页面展示该指令/建议详细信息
	grid.on("rowdblclick", function (e) {
		 nui.open({
                    url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueQueryDetail.jsp?lStockIssueId="+e.row.lStockIssueId,
                    title: "详细信息", 
                    width: 980, 
           			height: 700,
                    //allowResize:false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        iframe.contentWindow.initForm();
                    },
                    ondestroy: function (action) {
                        if(action=="saveSuccess"){
	                        grid.reload();
                   	 	}
                    }
                });
	});
	 
	 
	 //查看详情
       function lookDetail(){
       		var row = grid.getSelected();
            if (row) {
                nui.open({
                    url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueQueryDetail.jsp?lStockIssueId="+row.lStockIssueId,
                    title: "详细信息", 
                    width: 980, 
           			height: 650,
                    //allowResize:false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        iframe.contentWindow.initForm();
                    },
                    ondestroy: function (action) {
                        if(action=="saveSuccess"){
	                        grid.reload();
                   	 	}
                    }
                });
                
            } else {
                nui.alert("请选中一条记录");
            }
       }
	
        //行单击时重新设置tabs页面参数
	grid.on("rowclick", function (e) {
		var form = new nui.Form("#editForm1");//将普通form转为nui的form
		form.setData(e.row);
		//处理付息频率，值满足数据字典则直接显示数据字典中对应值，否则直接显示值
		if(nui.get("enPayInteval").getText()=="" || nui.get("enPayInteval").getText()==null){
			nui.get("enPayInteval").setText(e.row.enPayInteval);
		}				
    });
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
    </script>
</html>