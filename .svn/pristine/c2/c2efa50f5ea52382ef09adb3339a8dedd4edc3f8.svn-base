<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<%--
- Author(s): 石浩
- Date: 2016-08-16 17:40:16
- Description:
    --%>
    <head>
        <title>
                                  一级债券信息查询
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

    </head>
    <body style="width:100%;height:100%;overflow:height; margin: 0px;">
      		<div class="search-condition">
					<div class="list">
			            <div id="form1" class="nui-form"  align="center" style="height:10%" >
			                <form id="queryForm" action="">
			                <table id="table1" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
			                    <tr>
			                        <td style="width:60px" align="right">
			                            	债券代码:
			                        </td>
			                        <td style="width:20%" align="left">
			                            <input class="nui-textbox" id="vcStockCode" name="map/vcStockCode" width="100%"/>
			                        </td>
			                        <td style="width:60px" align="right">
			                        	债券简称:
			                        </td>
			                        <td style="width:20%" align="left">
			                         	<input class="nui-textbox" id="vcStockName" name="map/vcStockName" width="100%"/>
			                        </td>
			                       	
			                       	<td style="width:85px" align="right">
			                            	发行主体:
			                        </td>
			                        <td style="width:20%" align="left">
			                           <input class="nui-textbox" name="map/vcIssuerNameFull" width="100%"/>
			                           <input class="nui-hidden" id="lOperatorNo" name="map/lOperatorNo" value="<%=userObject.getUserId()%>"/>
			                        </td>
			                         <td style="width:60px" align="right">
			                            	发行日期:
			                        </td>
			                        <td  align="left" style="width:15%">
			                            <input class="nui-datepicker" id="lIssueBeginDateMin" format="yyyy-MM-dd" name="map/lIssueBeginDateMin" style="width:100%"/>
			                        </td>
			                         <td style="width:15px" align="center">
			                            	至
			                        </td>
			                        <td  align="left" style="width:15%">
			                            <input class="nui-datepicker" id="lIssueBeginDateMax" format="yyyy-MM-dd" name="map/lIssueBeginDateMax" style="width:100%"/>
			                        </td>
			                   </tr>
			                   
			                   <tr>
			                   		<td style="width:60px" align="right">
			                            	新债状态:
			                        </td>
			                        <td align="left">
			                              <input class="nui-dictcombobox" dictTypeId="newstockStatus" valueField="dictID" textField="dictName"
			                                oncloseclick="onCloseClickValueEmpty" showClose="true" showNullItem="false" 
			                                 width="100%" name="map/cStatus" id="cStatus" emptyText="全部" nullItemText="全部"/>
			                        </td>
			                        <td style="width:60px" align="right">
			                            	债券类别:
			                        </td>
			                        <td align="left">
			                              <!-- <input class="nui-dictcombobox" id="vcStockType" name="map/vcStockType" showClose="true" oncloseclick="onCloseClickValueEmpty"  
			                              showNullItem="false"  valueField="ID" textField="TEXT"  width="100%"
			                              url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext?type=1"/> -->
			                              <input style="width: 100%;" id="vcStockType" name="map/vcStockType" class="mini-treeselect"  multiSelect="true" 
									        textField="text" valueField="id" parentField="pid" checkRecursive="false" showFolderCheckBox="false"
									        emptyText="全部" nullItemText="全部"
									        expandOnLoad="true" showTreeIcon="false" showClose="true"
									        popupWidth="200" oncloseclick="onCloseClickValueEmpty" />
			                        </td>
			                   		 <td style="width:85px" align="right">
			                        	登记托管机构:
			                        </td>
			                        <td align="left">
			                            <input class="nui-dictcombobox" 
					                        dictTypeId="CF_JY_DJTGCS" valueField="dictID" textField="dictName"
					                        name="map/vcPaymentPlace" showClose="true" oncloseclick="onCloseClickValueEmpty" 
					                         id="vcPaymentPlace"  width="100%"/>
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
			                            <!-- <a class='nui-button' plain='false' iconCls="icon-add" id="add" onclick="add()">新增</a> -->
			                            <privilege:operation sourceId="ATS_XZFXXX_XZ" sid="add" clazz="nui-button" onClick="add()" lableName="新增"  iconCls="icon-add" ></privilege:operation>
			                            <!-- <a class='nui-button' plain='false' iconCls="icon-edit" id="add" onclick="edit()">修改</a> -->
			                            <privilege:operation sourceId="ATS_XZFXXX_XG" sid="edit" clazz="nui-button" onClick="edit()" lableName="修改" iconCls="icon-edit" ></privilege:operation>
			                            <a class='nui-button' plain='false' iconCls="icon-upload" onclick="importStockIssue()">导入</a>
			                            <!-- <a class='nui-button' plain='false' iconCls="icon-remove" id="add" onclick="remove()">删除</a> -->
			                           <privilege:operation sourceId="ATS_XZFXXX_SC" sid="remove" clazz="nui-button" onClick="remove()" lableName="废弃"  iconCls="icon-remove" ></privilege:operation>
			                           	    
			                        </td>
			                    </tr>
			                </table>
			         </div> 
			         <div id="layout1" class="mini-layout" style="width:100%; height:85%;"  borderStyle="border:solid 1px #aaa;"> 
			         <div title="center" region="center"  >
			     <div class="nui-fit" > 
			         <div  id="datagrid1" 
			                        class="nui-datagrid"
			                        style="width:100%;height:100%;"
			                        url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryDebeIssuesWithPage.biz.ext"
			                        sortField="lStockIssueId" sortOrder="desc"onShowRowDetail="onShowRowDetailList"
			                        showPageInfo="true" pageSize="20"
			                        onselectionchanged="selectionChanged"
			                        multiSelect="true"
			                        >
			                    <div property="columns">
			                        <div type="indexcolumn"></div>
			                        <div type="checkcolumn"></div>
			                        <div type="expandcolumn"></div>
			                        <div field="lProcessInstId" headerAlign="center" allowSort="true" visible=false>流程ID</div>
			                        <div field="lStockIssueId" headerAlign="center" allowSort="true" visible=false>业务序号</div>
			                        <div field="lBizId" headerAlign="center" allowSort="true" visible=false>流程序号</div>
			                        <div field="lStockInvestNo" headerAlign="center" allowSort="true" visible=false>债券投资编号</div>
			                 
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
			                        
			                        <div field="vcIssuerNameFull" headerAlign="center" width="150px" allowSort="true" >
			                            	发行主体
			                        </div>
			                        
			                        <div field="cIssueAppraise" headerAlign="center" allowSort="true" align="center"  renderer="issuerRatingRenderer">
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
				                     
			                        <div field="lIssuePostDate" headerAlign="center" align="right"  allowSort="true" >
			                            	公告日期
			                        </div>
			                        <div field="lIssueBeginDate" headerAlign="center" align="right"  allowSort="true" >
			                            	发行日期
			                        </div>
			
			                        <div field="lPayDate" headerAlign="center" align="right"   allowSort="true" >
			                            	缴款日期
			                        </div>
			                        <div field="lPublishDate" headerAlign="center" align="right"  allowSort="true" >
			                            	上市日期
			                        </div>
			                        <div field="lBegincalDate" headerAlign="center" align="right"  allowSort="true" >
			                            	起息日期
			                        </div>
			                        
			                        <div field="lEndincalDate" headerAlign="center" align="right"   allowSort="true" visible="false">
			                            	到期日期
			                        </div>
			                        
			                        <div field="cInterestType" renderer="rendererRateType" headerAlign="center" allowSort="true" >利率类型</div>
				
									<div field="cPayInterestType" renderer="rendererPayInterstType" headerAlign="center"allowSort="true" >息票品种</div>
									
									<div field="enPayInteval" headerAlign="center" renderer="rendererEnPayInteval" allowSort="true" >付息频率</div>
									
									<div field="enFaceRate" headerAlign="center" align="right" allowSort="true" >票面利率(%)</div>
									
									<div field="cBidType" headerAlign="center" renderer="renderercBidType" allowSort="true" >招标方式</div>
									
									<div field="cPayType" headerAlign="center"allowSort="true" renderer="rendererPaymentType" >缴款方式</div>
									
									<div field="vcSpecialText" headerAlign="center"allowSort="true" renderer="rendererSpecialText">特殊条款</div>
				
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
			                        
			                        <div field="vcIssueType" headerAlign="center" align="center" allowSort="true" renderer="issueTypeRender">
			                           	            发行方式
			                        </div>
			                        
			                        <div field="vcSpecialLimite" headerAlign="center" align="center" allowSort="true" >
			                           	            特殊期限
			                        </div>
			                         
			                        <div field="lNextExerciseDate" headerAlign="center" align="right" allowSort="true">
			                           	            下一行权日
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
			                        <div field="lCreditAnalyzeNo" headerAlign="center" align="center" allowSort="true" visible="false">
			                           	            信用分析人员
			                        </div>
			                        
			                        <div field="vcCreditAnalyze" headerAlign="center" align="center" allowSort="true" visible="false">
			                           	           信用分析
			                        </div>
			                        			                        				                        			     			                        
			                        <div field="cMarketNo" headerAlign="center" allowSort="true" visible=false>交易市场</div>
			                        
			                        <div field="vcStockType" headerAlign="center" allowSort="true" visible=false>债券类别编码</div>
			                        
			                        <div field="cStatus" headerAlign="center" allowSort="true" renderer="cStatusRenderer" visible=false>流程状态</div>
			                        
			                        <div field="cStatus" headerAlign="center" allowSort="true" renderer="cStatusRenderer">新债状态</div>
			                        
			                        <div field="lOperatorName" headerAlign="center"  allowSort="true"  renderer="lOperatorNameRenderer">
			                           	           录入人
			                        </div>
			                        <div field="lOperatorNo" headerAlign="center"   allowSort="true"   visible="false">
			                           	           操作员
			                        </div>
			                        <div field="cSource" headerAlign="center" allowSort="true"   visible=false>数据来源</div>
			                        
			                        <div field="vcInterCode" headerAlign="center" allowSort="true"  visible=false>债券内码</div>
			                        
			                        <div field="vcStockCodeWind" headerAlign="center" allowSort="true" visible=false>债券代码_wind</div>
			                        
			                        <div field="cMarketNo" headerAlign="center" allowSort="true" visible=false>交易市场</div>
			                        
			                        <div field="vcStockType" headerAlign="center" allowSort="true" visible=false>债券类别编码</div>
			                        <div field="vcMainUnderwriterId" headerAlign="center" allowSort="true" visible=false>主承销商ID</div>
			                        <div field="vcDeputyUnderwriterId" headerAlign="center" allowSort="true" visible=false>副承销商ID</div>
			                        
			                        
			                    </div>
			          </div>
			          </div>
			          </div>
			          <div title="新债录入详细信息" region="south" showSplit="false" showHeader="true" height="270" showSplitIcon="true" >
				        <div id="editForm1"  class="nui-form" style="margin-right:15px">
				            <input class="mini-hidden" name="id"/>
				             <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
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
													name="enPayInteval"class="nui-dictcombobox" dictTypeId="ATS_CF_JY_FREQUENCY" readonly="true" valueFromSelect="false" 
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
													name="vcSpecialText" class="nui-dictcombobox" dictTypeId="specialText"  readonly="true"
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
							                    <td align="right">下一行权日:</td>
												<td align="left"><input id="lNextExerciseDate" width="100%"
													name="lNextExerciseDate" class="mini-textbox" readonly="true"
													inputStyle="background-color:#f0f0f0;" /></td>
											</tr>
										    <tr>
												<td align="right">担保方式:</td>
												<td align="left"><input id="cAssuerType" width="100%"
													name="cAssureType" class="nui-dictcombobox" dictTypeId="ATS_FM_ASSUER_TYPE" readonly="true"
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
							                    <td align="right">特殊期限:</td>
							                    <td align="left">
							                    	<input id="vcSpecialLimite" width="100%" name="vcSpecialLimite" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>		
							                </tr>
							                <tr>
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
<script type="text/javascript">
		nui.parse();
		var grid = nui.get("datagrid1");
		nui.get("cStatus").setValue("1");
    	var form = new nui.Form("#form1");
    	var formData = form.getData(false,false);
		grid.load(formData);
		 $("#editForm1 .mini-buttonedit-buttons").remove();
		 $("#editForm1 .mini-buttonedit-border").css("background-color","#f0f0f0");
		var renders = [{ id: "1", text: '是' }, { id: "0", text: '否'}];
		
		
    	var tempVcStockType = "";    	
    	var allVcIssueAppraiseCsrc;
    	var allVcIndustry;
    	loadStockTypeAll();
             //加载所有的债券信息
             function loadStockTypeAll(){
             	
             	nui.ajax({
				    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext",
				    type: "post",
				    dataType:"json",
				    success: function (text) {
				    	//var vcStockType = nui.get("vcStockType");
				    	nui.get("vcStockType").loadList(text.data);
				    	//stockTypeAll=text.data;
				    	tempVcStockType = text.data;
				    }
				});
             	
             }
    	//加载所属行业的证监会二级
        loadVcIssueAppraiseCsrcAll();
        //加载所属行业
        loadVcIndustryAll();
	     function loadVcIssueAppraiseCsrcAll(){
	     	nui.ajax({//com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc
			    url: "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc.biz.ext",
			    type: "post",
			    data:nui.encode({type:"1"}),
			    contentType:'text/json',
			    success: function (text) {
			    	allVcIssueAppraiseCsrc=text.data;
			    }
			});
	     }
	     function loadVcIndustryAll(){
	     	nui.ajax({//com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc
			    url: "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc.biz.ext",
			    type: "post",
			    data:nui.encode({type:"2"}),
			    contentType:'text/json',
			    success: function (text) {
			    	allVcIndustry=text.data;
			    }
			});
	     }
         
    	function reset(){
			form.reset();
		}
    	function add() {
			var url = "<%= request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueAdd.jsp";
			var title = "新债录入";
			var width = "980";
			var height = "650";
			nui.open({
				url: url,
				title: title, width: width, height: height,
				onload: function () {//弹出页面加载完成
					
				},
				ondestroy: function (action) {//弹出页面关闭前
					grid.reload();
				}
			});
		}
		
		function edit(){
		    var row = grid.getSelected();
            if (row) {
            	var status = row.cStatus;
            	if(status !='2'){
            		nui.alert('只能修改复核通过的新债，请重新选择!');
            		return false;
            	}
                nui.open({
                    url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueEdit.jsp",
                    title: "新债信息修改", 
                    width: 980, 
           			height: 650,
                    //allowResize:false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = row;
                        iframe.contentWindow.SetData(data,tempVcStockType,allVcIssueAppraiseCsrc,allVcIndustry);
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
		
		
		  function remove() {
            var row = grid.getSelected();
            
            if (row) {
            	if(row.cStatus=="0"){
            		nui.confirm("请确定需要废弃该债券信息?请谨慎操作!","删除确认",function(action){
	            	if(action!="ok") return;
	            	var json = nui.encode({id:row.lStockIssueId});
	                $.ajax({
	                     url: "com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.deleteDebtIssues.biz.ext",
		                type: 'POST',
		                data: json,
		                cache: false,
		                contentType:'text/json',
	                    success: function (text) {
	                        grid.reload();
	                    },
	                    error: function () {
	                    	 alert("废弃失败,请重试");
	                    }
	                });
                }); 
            	}else{
            		nui.alert("只能废弃草稿状态的数据!");
            	}
            } else {
                nui.alert("请选中一条记录!");
            }
        }
        $("#editForm1 .mini-buttonedit-buttons").remove();
        $("#editForm1 .mini-buttonedit-border").css("background-color","#f0f0f0");
        
            
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
        
        //债券评级
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
        
        
        function issuerRatingRenderer(e){
        	return nui.getDictText("issuerRating",e.row.cIssueAppraise);
        }
        
        function outRatingOrganRenderer(e){
        	return nui.getDictText("outRatingOrgan",e.row.vcIssueAppraiseOrgan);
        }

        function cAssureTypeRenderer(e){
        	return nui.getDictText("ATS_FM_ASSUER_TYPE",e.row.cAssureType);
        }
        
        function underwriteTypeRenderer(e){
        	return nui.getDictText("underwriteType",e.row.cUnderwriteType);
        }
        
        
        function vcPaymentPlaceRenderer(e){
        		return nui.getDictText("CF_JY_DJTGCS",e.row.vcPaymentPlace);
        }
        //rendererSpecialText
        function rendererSpecialText(e){
        		return nui.getDictText("specialText",e.row.vcSpecialText);
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
		function lOperatorNameRenderer(e){
			if(e.row.lOperatorName==null){
				return '新债归集';
			}else{
				return e.row.lOperatorName;
			}
		}	
		
        //查询
        function search(){
            nui.get("edit").enable();
            var lIssueBeginDateMin = nui.get("lIssueBeginDateMin").value;
            var lIssueBeginDateMax = nui.get("lIssueBeginDateMax").value;
            if(lIssueBeginDateMin!=null && lIssueBeginDateMin!="" && lIssueBeginDateMax!=null && lIssueBeginDateMax!=""){
	            if(lIssueBeginDateMax < lIssueBeginDateMin){
	            	nui.alert("起始日期不能大于截止日期");
	            	return false;
	            }
            }
        	var data = form.getData(false,false);      //获取表单多个控件的数据
        	var editForm1 = new nui.Form("#editForm1");
        	editForm1.reset();
        	/* data.replace("map/","map/");
        	data.map.vcStockType.replace(",","','");
        	data.map/vcStockType
        	//data.map.vcStockType ="'"+ data.map.vcStockType + "'"; */
            grid.load(data);
        }
        
       //根据交易市场，获取债券类型
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
        //当选择列时
        function selectionChanged(){
            var rows = grid.getSelecteds();
            if(rows.length>1){
                nui.get("edit").disable();
            }else{
                nui.get("edit").enable();
            }
        }
        //展示详细行数据
	function onShowRowDetailList(e) {
	    
		var grid = e.sender;//获取表格
	    var row = e.record;//获取行数据
	    var remark = null;
	    var cSource  = row.cSource;
	    /* if(cSource !="手工录入"){
	    	nui.alert("该笔数据没有审批流程");
	    	return ;
	    } */
	    var ProcessInstId = row.lProcessInstId;
	    //判断待办中传过来的流程ID是否为空
	    if(ProcessInstId == null){
	    	nui.alert("该笔数据没有审批流程");
	    	return ;
	    }

	    //获取债券信息
	    var processIdJson = nui.encode({processInstId : ProcessInstId});
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
                	
                	if(bonds.length==0){
                		nui.alert("该笔数据没有审批流程");
                	}else{
                	
	                	var html = "<table border='0'  style='width:100%;'>";
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
                	}
                    
                    
                    
                }else{
					nui.alert("加载失败", "系统提示");
                }
            }
         });
	}
    function importStockIssue() {
		mini.open({
		    url:"<%=request.getContextPath() %>/fm/baseinfo/fileupload/importDebtIssueFile.jsp",
		    title: "新债信息导入", width: 850, height: 580,
		    overflow:"hidden",
		    onload: function () {
		        
		    },
		    ondestroy: function (action) {
		        grid.reload();
		    }
		});
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
   </script>
  </body>
</html>
