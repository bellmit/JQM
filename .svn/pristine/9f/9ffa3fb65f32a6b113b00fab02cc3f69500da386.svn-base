<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 胥思明
  - Date: 2016-11-07 11:30:06
  - Description:
-->
<head>
<title>债券信息查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    
</head>
<body style="width:100%;height:100%;overflow: hidden; margin: 0px;">
			<input name="pageType" class="nui-hidden"/>
			<!-- 指令/建议编号倒序排列 -->
            <input class="nui-hidden" name="bizCriteria/_orderby[1]/_sort" value="desc" />
            <input class="nui-hidden" name="bizCriteria/_orderby[1]/_property" value="lStockInvestNo" />
			<div class="search-condition">
					  <div class="list">
			            <div id="form1" class="nui-form"  align="center" style="height:10%" >
			            <!-- 数据实体的名称 -->
               			<input class="nui-hidden" name="bizCriteria/_entity" value=com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsIntfStockInfoWind>
			                <!-- 排序字段 -->
			                <form id="queryForm" action="">
			                <table id="table1" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
			                    <tr>
			                        <td style="width:60px" align="right">
			                            	债券代码:
			                        </td>
			                        <td style="width:25%" align="left">
			                            <input class="nui-textbox" id="vcStockCode" name="map/vcStockCode"  width="100%"/>
			                        </td>
			                        <td style="width:80px" align="right">
			                        	债券简称:
			                        </td>
			                        <td style="width:25%" align="left">
			                         	<input class="nui-textbox" id="vcStockName" name="map/vcStockName" width="100%"/>
			                        </td>
			                        <td style="width:80px" align="right">
			                        	发行主体:
			                        </td>
			                        <td style="width:25%" align="left">
			                         	<input class="nui-textbox" id="vcIssuerNameFull" name="map/vcIssuerNameFull" width="100%"/>
			                        </td>
			                        
			                        <td style="width:80px" align="right">
			                        	登记托管机构:
			                        </td>
			                        <td style="width:25%" align="left">
			                         	<input class="nui-textbox" id="vcPaymentPlaces" name="map/vcPaymentPlace" width="100%"/>
			                         	<input class="nui-hidden" id="sMarketType" name="map/vcMarketType" />
			                        </td>
			                   </tr>
			                   <tr>
			                        <td style="width:60px" align="right">
			                                                                                                   债券类别:
			                        </td>
			                        <td style="width:25%" align="left">
			                              <input style="width: 100%;" id="treeVcStockType" name="map/vcStockType" class="mini-treeselect"  multiSelect="true" 
									        textField="text" valueField="id" parentField="pid" checkRecursive="false"  showFolderCheckBox="false"
									        url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext" emptyText="全部" nullItemText="全部"
									        showFolderCheckBox="true"   expandOnLoad="true" showTreeIcon="false" showClose="true" dataField="data"
									        oncloseclick="onCloseClickValueEmpty" onclick=""/>
									        <input class="nui-hidden" name="bizCriteria/_expr[5]/_op" value="in">
			                        </td>
			                        <td style="width:80px" align="right">
			                        	主体评级:
			                        </td>
			                        <td style="width:25%" align="left">
			                         	<input class="nui-textbox" id="vcIssueAppraise" name="map/vcIssueAppraise" width="100%"/>
			                        </td>
			                        <td align="right">
			                            	发行日期:
			                        </td>
			                        <td  align="left" style="width:25%">
			                            <input class="nui-datepicker" oncloseclick="onCloseClickValueEmpty" format="yyyy-MM-dd"
			                              id="lDate" name="map/lIssueBeginDate" width="100%" showClose="true" />
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
			                        	<privilege:operation sourceId="ATS_XZCX_TBWINDSJ" sid="synDataByWind" clazz="nui-button" onClick="synControl()" lableName="获取Wind数据"  iconCls="icon-find" ></privilege:operation>
			                        </td>
			                    </tr>
			                </table>
			         </div>
			         
			<div id="layout1" class="mini-layout" style="width:100%; height:83.5%;"  borderStyle="border:solid 1px #aaa;"> 
			<div title="center" region="center"  >
			<div class="nui-fit" >  
			         	<div  id="datagrid1"
			                        class="nui-datagrid"
			                        style="width:100%;height:100%;"
			                        url="com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.queryTAtsIntfStockInfoWinds.biz.ext"
			                        pageSize="20"
			                        onShowRowDetail="onShowRowDetailList"
			                        showPageInfo="true"
			                        multiSelect="true"
			                        sortField="vcStockType" sortOrder="desc"  >
			             
			                        
			                    <div property="columns">
			                        <div type="indexcolumn"></div>
			                        <div type="checkcolumn"></div>
			                        <div field="lStockIssueId" headerAlign="center" allowSort="true" visible=false>业务序号</div>
			                        <div field="lBizId" headerAlign="center" allowSort="true" visible=false>流程序号</div>
			                        <div field="lStockInvestNo" headerAlign="center" allowSort="true" visible=false>证券投资编号</div>
			                        <div field="vcMarketType" headerAlign="center" allowSort="true" >
			                        	  交易市场
			                        </div>
			                        <div field="vcPaymentPlace" headerAlign="center" allowSort="true" width="200">
			                            	登记托管机构
			                        </div> 
			                        <div field="vcInterCode" headerAlign="center" allowSort="true" >
			                            	债券内码
			                        </div>
			                        <div field="vcStockCode" headerAlign="center" allowSort="true" >
			                       		     债券代码
			                        </div>
			                        <div field="vcStockName" headerAlign="center" allowSort="true" >
			                            	债券简称
			                        </div>
			                        <div field="vcStockNameFull" headerAlign="center" allowSort="true" >
			                            	债券全称
			                        </div>
			                        <div field="vcStockType" headerAlign="center" allowSort="true" >
			                          		债券类别
			                        </div>
			                        <div field="enExistLimite" headerAlign="center" align="right" allowSort="true" >
			                            	发行期限(年)
			                        </div>
			                        <div field="enIssueBalance" headerAlign="center" align="right" allowSort="true" >
			                            	发行规模(亿)
			                        </div>
			                        <div field="vcBondAppraise" headerAlign="center" allowSort="true" >
			                            	债券评级
			                        </div>
			                        <div field="vcBondAppraiseOrgan" headerAlign="center" allowSort="true">
			                            	债券评级机构
			                        </div>
			                        <div field="lIssuerId" headerAlign="center" align="right" allowSort="true" >
			                           	发行主体编号
			                        </div>
			                        <div field="vcIssuerNameFull" headerAlign="center" allowSort="true" >
			                            	发行主体
			                        </div>
			                        <div field="vcIssueProperty" headerAlign="center" allowSort="true">
			                            	主体类型
			                        </div>
			                        <div field="vcIssueAppraise" headerAlign="center" allowSort="true">
			                            	主体评级
			                        </div>
			                        <div field="vcIssueAppraiseOrgan" headerAlign="center" allowSort="true">
			                            	主体评级机构
			                        </div>
			                        <div field="vcIndustry" headerAlign="center" allowSort="true" >
			                            	所属行业
			                        </div>
			                        <div field="vcIndustryWind1" headerAlign="center" allowSort="true" >
			                           	 所属行业1
			                        </div>
			                        <div field="vcIndustryWind2" headerAlign="center" allowSort="true" >
			                           	 所属行业2
			                        </div>
			                        <div field="vcIndustryWind3" headerAlign="center" allowSort="true" >
			                            	所属行业3
			                        </div>
			                        <div field="vcIndustryWind4" headerAlign="center" allowSort="true" >
			                            	所属行业4
			                        </div>
			                        <div field="vcProvince" headerAlign="center" allowSort="true" >
			                            	所属省份
			                        </div>
			                        <div field="lGuarantorId" headerAlign="center" align="right" allowSort="true" >
			                            	担保人序号
			                        </div>
			                        <div field="vcGuarantorNameFull" headerAlign="center" allowSort="true" >
			                            	担保人名称
			                        </div>
				                    <div field="vcAssureType" headerAlign="center" allowSort="true">
			                            	担保方式
			                        </div>
			                        <div field="vcGuarantorSummary" headerAlign="center" allowSort="true" >
			                            	担保人简介
			                        </div>
			                        
			                     	<div field="lIssuePostDate" headerAlign="center" align="right" allowSort="true"   >公告日期</div>
				
									<div field="lIssueBeginDate" headerAlign="center" align="right" allowSort="true" >发行日期</div>
					
									<div field="lPayDate" headerAlign="center" align="right" allowSort="true"  >缴款日期</div>
									
									<div field="lPublishDate" headerAlign="center" align="right" allowSort="true"  >上市日期</div>
									
									<div field="lBegincalDate" headerAlign="center" align="right" allowSort="true"  >起息日期</div>
					
									<div field="lEndincalDate" headerAlign="center" align="right" allowSort="true"   >到期日期</div>
									<div field="vcTenderInterval" headerAlign="center"allowSort="true" >投标区间</div>
								    <div field="cInterestType"  headerAlign="center" allowSort="true" >
			                            	利率类型
			                        </div>
			                        <div field="cPayInterestType" headerAlign="center" allowSort="true" >
			                            	息票品种
			                        </div>
			                        <div field="enPayInteval" headerAlign="center" renderer="rendererEnPayInteval" allowSort="true" >
			                            	付息频率(次/年)
			                        </div>
			                        <div field="enFaceRate" headerAlign="center" align="right" allowSort="true" >
			                            	票面利率(%)	
			                        </div>
			                        <div field="cBidType" headerAlign="center"  allowSort="true" >
			                            	招标方式
			                        </div>
			                        <div field="cPayType" headerAlign="center" allowSort="true" >
			                           	 缴款方式
			                        </div>
			                        <div field="vcSpecialText" headerAlign="center" allowSort="true" >
			                           	 特殊条款
			                        </div>
			                        <div field="vcMainUnderwriter" headerAlign="center" allowSort="true" >
			                            	主承销商
			                        </div>
			                        <div field="vcDeputyUnderwriterId" headerAlign="center" align="right" allowSort="true" >
			                         	   副承销商ID
			                        </div>
			                        <div field="vcDeputyUnderwriter" headerAlign="center" allowSort="true" >
			                           	 副承销商
			                        </div>
			                        <div field="cUnderwriteType" headerAlign="center" allowSort="true">
			                            	承销方式
			                        </div>
			                        <div field="vcGroupUnderwriter" headerAlign="center" allowSort="true" >
			                           	 承销团
			                        </div>
			                        <div field="lNextExerciseDate" headerAlign="center"  align="right" allowSort="true"  renderer="renderDataTemp">
			                        	    下一行权日
			                        </div>
			                        <div field="cIsSmallRaised" headerAlign="center" allowSort="true" visible="false">
			                          	  是否小公募
			                        </div>
			                        <div field="cIsHaveSaleback" headerAlign="center" allowSort="true" renderer="isRenderer">
			                            	是否具有回售权
			                        </div>
			                        <div field="vcIssueType" headerAlign="center" allowSort="true"  renderer="issueTypeRender">
			                          	 发行方式
			                        </div>
			                        <div field="vcSpecialLimite" headerAlign="center" allowSort="true">
			                           	 特殊期限
			                        </div>
			                    </div>
			                 </div>
			                </div>
			               </div>
			       <div title="Wind新债详细信息" region="south" showSplit="false" showHeader="true" height="250" showSplitIcon="true" >
						        <div id="editForm1" style="margin-right:15px">
						            <input class="mini-hidden" name="id"/>
						             <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
							                <tr>
							                    <td align="right">登记托管机构:</td>
							                    <td align="left">
							                    	<input id="vcPaymentPlace" width="100%" name="vcPaymentPlace" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td   align="right">债券代码:</td>
							                    <td   align="left">
							                    	<input align="left" width="100%" name="vcStockCode" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td   align="right">债券简称:</td>
							                    <td   align="left">
							                    	<input align="left" width="100%" name="vcStockName" name="vcStockName" class="mini-textbox"   readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">债券全称:</td>
							                    <td align="left">
							                    	<input id="vcStockNameFull" width="100%" name="vcStockNameFull" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">债券类别:</td>
							                    <td align="left">
							                    	<input id="vcStockType" width="100%" name="vcStockType" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							                <tr>
							                  <td align="right">发行期限(年):</td>
							                    <td align="left">
							                    	<input id="enExistLimite" width="100%" name="enExistLimite" class="mini-textbox" dictTypeId="creditRating" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">发行规模(亿):</td>
							                    <td align="left">
							                    	<input id="enIssueBalance" width="100%" name="enIssueBalance" class="mini-textbox" dictTypeId="outRatingOrgan" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">债券评级:</td>
							                    <td align="left">
							                    	<input id="vcBondAppraise" width="100%" name="vcBondAppraise" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">债券评级机构:</td>
							                    <td align="left">
							                    	<input id="vcBondAppraiseOrgan" width="100%" name="vcBondAppraiseOrgan" class="mini-textbox"  dictTypeId="issueProperty" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">主体评级:</td>
							                    <td align="left">
							                    	<input id="vcIssueAppraise" width="100%" name="vcIssueAppraise" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							                
							                 <tr>
							                    <td align="right">主体类型:</td>
							                    <td align="left">
							                    	<input id="vcIssueProperty" width="100%" name="vcIssueProperty" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">发行主体:</td>
							                    <td align="left">
							                    	<input id="vcIssuerNameFull" width="100%" name="vcIssuerNameFull" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">主体评级机构:</td>
							                    <td align="left">
							                    	<input id="vcIssueAppraiseOrgan" width="100%" name="vcIssueAppraiseOrgan" class="mini-textbox" readonly="true"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">所属省份:</td>
							                    <td align="left">
							                    	<input id="vcProvince" width="100%" name="vcProvince" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">所属行业:</td>
							                    <td align="left">
							                    	<input id="vcIndustry" width="100%" name="vcIndustry" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							                <tr>
							                    <td align="right">债券内码:</td>
							                    <td align="left">
							                    	<input id="vcInterCode" width="100%" name="vcInterCode" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    
							                    <td align="right">公告日期:</td>
							                    <td align="left">
							                    	<input id="lIssuePostDate" width="100%" name="lIssuePostDate" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                     <td align="right">发行日期:</td>
							                    <td align="left">
							                    	<input id="lIssueBeginDate" width="100%" name="lIssueBeginDate" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">缴款日期:</td>
							                    <td align="left">
							                    	<input id="lPayDate" width="100%" name="lPayDate" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">上市日期:</td>
							                    <td align="left">
							                    	<input id="lPublishDate" width="100%" name="lPublishDate" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>	
							                 </tr>
							                 <tr>
							                    <td align="right">利率类型:</td>
							                    <td align="left">
							                    	<input id="cInterestType" width="100%" name="cInterestType" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">息票品种:</td>
							                    <td align="left">
							                    	<input id="cPayInterestType" width="100%" name="cPayInterestType" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">付息频率(次/年):</td>
							                    <td align="left">
							                    	<input id="enPayInteval" width="100%" name="enPayInteval" class="nui-dictcombobox" dictTypeId="ATS_CF_JY_FREQUENCY" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">票面利率(%):</td>
							                    <td align="left">
							                    	<input id="enFaceRate" width="100%" name="enFaceRate" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">缴款方式:</td>
							                    <td align="left">
							                    	<input id="cPayType" width="100%" name="cPayType" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							                <tr>
							                    <td align="right">招标方式:</td>
							                    <td align="left">
							                    	<input id="cBidType" width="100%" name="cBidType" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">起息日期:</td>
							                    <td align="left">
							                    	<input id="lBegincalDate" width="100%" name="lBegincalDate" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">到期日期:</td>
							                    <td align="left">
							                    	<input id="lEndincalDate" width="100%" name="lEndincalDate" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">担保人名称:</td>
							                    <td align="left">
							                        <input id="vcGuarantorNameFull" width="100%" name="vcGuarantorNameFull" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">担保人简介:</td>
							                    <td align="left">
							                       <input id="vcGuarantorSummary" width="100%" name="vcGuarantorSummary" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							                
							                <tr>
							                    <td align="right">主承销商:</td>
							                    <td align="left">
							                    	<input id="vcMainUnderwriter" width="100%" name="vcMainUnderwriter" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">副承销商:</td>
							                    <td align="left">
							                    	<input id="vcDeputyUnderwriter" width="100%" name="vcDeputyUnderwriter" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">承销方式:</td>
							                    <td align="left">
							                    	<input id="cUnderwriteType" width="100%" name="cUnderwriteType" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">承销团:</td>
							                    <td align="left">
							                    	<input id="vcGroupUnderwriter" width="100%" name="vcGroupUnderwriter" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">特殊条款:</td>
							                    <td align="left">
							                    	<input id="vcSpecialText" width="100%" name="vcSpecialText" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							                <tr>
							                    <td align="right">担保方式:</td>
							                    <td align="left">
							                    	<input id="vcAssureType" width="100%" name="vcAssureType" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">下一行权日:</td>
							                    <td align="left">
							                    	<input id="lNextExerciseDate" width="100%" name="lNextExerciseDate" class="mini-textbox" 	  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">是否具有回售权:</td>
							                    <td align="left">
							                    	<input id="cIsHaveSaleback" width="100%" name="cIsHaveSaleback" class="mini-combobox"  data="[{ id: 1, text: '是' }, { id: 0, text: '否'}]" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    
							                    <td align="right">交易市场:</td>
							                    <td align="left">
							                    	<input id="vcMarketType" width="100%" name="vcMarketType" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">发行方式:</td>
							                    <td align="left">
							                    	<input id="vcIssueType" width="100%" name="vcIssueType" class="nui-dictcombobox" dictTypeId="issueType"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							                <tr>
							                	<td align="right">特殊期限:</td>
							                    <td align="left">
							                    	<input id="vcSpecialLimite" width="100%" name="vcSpecialLimite" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                    <td align="right">投标区间:</td>
							                    <td align="left">
							                    	<input id="vcTenderInterval" width="100%" name="vcTenderInterval" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
							                    </td>
							                </tr>
							            </table>
						        </div>
						        </div>
			               </div>
	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid1");
    	var form = new nui.Form("#form1");
    	var db = new nui.DataBinding();
        db.bindForm("editForm1", grid);
        
        var formData = form.getData(false,false);
		grid.load(formData);
         $("#editForm1 .mini-buttonedit-buttons").remove();
  		 $("#editForm1 .mini-buttonedit-border").css("background-color","#f0f0f0");
        //重置
        function reset(){
			form.reset();
		}
		
		//查询
        function search(){
        	if(nui.get("vcPaymentPlaces").getValue()!=null && nui.get("vcPaymentPlaces").getValue()!=""){
        		nui.get("sMarketType").setValue(nui.get("vcPaymentPlaces").getValue());
        	}
        	
        	var t = mini.get("treeVcStockType");
        	t.setValue(t.getText());
        	var data = form.getData(false,false);      //获取表单多个控件的数据
        	var editForm1 = new nui.Form("#editForm1");
        	editForm1.reset();//清除明细信息
            grid.load(data);
        }
        
         //更改日期格式
		function renderDataTemp(e){
			if(e.value == "0" || e.value == null){
				return "";
			}
			return dataTemp(e.value);
		}
			function dataTemp(oldData){
			oldData = oldData+"";
			if(oldData=="0" || oldData=="" || oldData=="null" || oldData==null || oldData=="1"){
				return "";
			}
			var yy = oldData.substr(0,4);
			var mm = oldData.substr(4,2);
			var dd = oldData.substr(6,2);
			return yy+"-"+mm+"-"+dd;
		}
		
		  function cellClick(){
            var lIssuePostDate =  nui.get("lIssuePostDate").getValue();
	        if(lIssuePostDate == "0" || lIssuePostDate == null){
	        nui.get("lIssuePostDate").setValue("");
	        }else{
	         nui.get("lIssuePostDate").setValue(dataTemp(lIssuePostDate));
	        }
	        
	        var lIssueBeginDate =  nui.get("lIssueBeginDate").getValue();
	        if(lIssueBeginDate == "0" || lIssueBeginDate == null){
	        nui.get("lIssueBeginDate").setValue("");
	        }else{
	          nui.get("lIssueBeginDate").setValue( dataTemp(lIssueBeginDate));
	        }
	        
	        var lPayDate =  nui.get("lPayDate").getValue();
	        if(lPayDate == "0" || lPayDate == null){
	        nui.get("lPayDate").setValue("");
	        }else{
	          nui.get("lPayDate").setValue(dataTemp(lPayDate));
	        }
	        
	        var lPublishDate =  nui.get("lPublishDate").getValue();
	        if(lPublishDate == "0" || lPublishDate == null){
	        nui.get("lPublishDate").setValue("");
	        }else{
	          nui.get("lPublishDate").setValue(dataTemp(lPublishDate));
	        }
	        
	        var lBegincalDate =  nui.get("lBegincalDate").getValue();
	        if(lBegincalDate == "0" || lBegincalDate == null){
	        nui.get("lBegincalDate").setValue("");
	        }else{
	          nui.get("lBegincalDate").setValue(dataTemp(lBegincalDate));
	        }
	        
	        var lEndincalDate =  nui.get("lEndincalDate").getValue();
	        if(lEndincalDate == "0" || lEndincalDate == null){
	        nui.get("lEndincalDate").setValue("");
	        }else{
	          nui.get("lEndincalDate").setValue(dataTemp(lEndincalDate));
	        }
	       
	        var lNextExerciseDate =  nui.get("lNextExerciseDate").getValue();
	        if(lNextExerciseDate == "0" || lNextExerciseDate == null){
	        nui.get("lNextExerciseDate").setValue("");
	        }else{
	          nui.get("lNextExerciseDate").setValue(dataTemp(lNextExerciseDate));
	        } 
	        
        }
		//债券评级
        function onBondAppraiseRenderer(e){
        
        	return nui.getDictText("creditRating",e.row.vcBondAppraise);
        }
        
        function underwriteTypeRenderer(e){
        	return nui.getDictText("underwriteType",e.row.cUnderwriteType);
        }
        function issueTypeRender(e){
        	return nui.getDictText("issueType",e.row.vcIssueType);
        }
        var renders = [{ id: "1", text: '是' }, { id: "0", text: '否'}];
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
         //债券评级机构
        function onBondAppraiseOrganRenderer(e){
        	return nui.getDictText("outRatingOrgan",e.row.vcBondAppraiseOrgan);
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
    		return nui.getDictText("ATS_CF_JY_FREQUENCY", e.row.enPayInteval);
    	}
    	//招标方式
    	function renderercBidType(e){
    		return nui.getDictText("tenderType", e.row.cBidType);
    	}
    	
    	//缴款方式
    	function rendererPaymentType(e){
    		return nui.getDictText("ATS_FM_PAYMENT", e.row.cPayType);
    	}
    	
		function vcPaymentPlaceRenderer(e){
        		return nui.getDictText("CF_JY_DJTGCS",e.row.vcPaymentPlace);
        }
        
        function issuePropertyRenderer(e){
        	return nui.getDictText("issueProperty",e.row.vcIssueProperty);
        }
        
        
        function creditRatingRenderer(e){
        	return nui.getDictText("creditRating",e.row.vcIssueAppraise);
        }
        
        function outRatingOrganRenderer(e){
        	return nui.getDictText("outRatingOrgan",e.row.vcIssueAppraiseOrgan);
        }
        
        function synDataByWind(ismanual) {
          if(ismanual){	
	          var type = 6;
	          var json = nui.encode({buttonType:type});
	          nui.ajax({
	            //url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getDataFromWind.biz.ext",
	            url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getBondInfoData.biz.ext",
	            type: "post",
	            contentType:'text/json',
	            data: json ,
	            success: function (text) {
	              var returnJson = nui.decode(text);
	              if (returnJson.returnValue == true) {
	              	nui.alert("获取Wind数据结果：成功", "", function(){});
	              }
	              else {
	              	 nui.alert("获取Wind数据结果：失败", "", function(){});
	              }
	            }
	          });
	       }else{
	       		nui.alert("手工新债信息归集未开启 ， 不允许手工操作 【获取Wind数据】", "提示", function(){});
	       }
        }
        function synControl(){
        	var ismanual = false;
        	var parmKey = "ATS_SYN_STOCK_ISSUE";
        	var json = nui.encode({paramKey:parmKey});
        	nui.ajax({
            url: "com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.getParamValue.biz.ext",
            type: "post",
            contentType:'text/json',
            data: json ,
            success: function (text) {
              var returnJson = nui.decode(text);
              if (returnJson.paramValue != null && returnJson.paramValue !="") {
              	if(returnJson.paramValue == "0"){
              		ismanual = true;
              		synDataByWind(ismanual);
              	}else{
              		ismanual = false;
              		synDataByWind(ismanual);
              	}
              }
            }
          });
        }        
    </script>
</body>
</html>