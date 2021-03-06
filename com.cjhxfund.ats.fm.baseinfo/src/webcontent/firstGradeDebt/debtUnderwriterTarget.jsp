<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 谢海光
  - Date: 2017-06-29 15:13:12
  - Description:
-->
<style type="text/css">
	   .invaliddata{
			display: inline-block;
			margin: 1px;
			height: 14px;
			vertical-align: middle;
			line-height:25px;
			width: 20px;
			background-color: #FFFFBB;
			border:2px solid #6CA6CD; 
		}
		.backdata{
			display: inline-block;
			margin: 1px;
			height: 14px;
			vertical-align: middle;
			line-height:25px;
			width: 20px;
			background-color: #FFCCCC;
			border:2px solid #6CA6CD;   		 
		}
	</style>
<head>
<title>主承销商新债数据管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
   <div class="search-condition">
					<div class="list">
			            <div id="form1" class="nui-form"  align="center" style="height:10%" >
			                <form id="queryForm" action="">
			                <!-- <input type="hidden" class="nui-hidden" id="excelData" name="excelData" />
			                <input type="hidden" class="nui-hidden" id="fileName" name="fileName" />
			                <input type="hidden" class="nui-hidden" id="type" name="type" /> -->
			                <table id="table1" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
			                    <tr>
			                        <td style="width:60px" align="right">
			                        	债券简称:
			                        </td>
			                        <td style="width:20%" align="left">
			                         	<input  class="nui-textbox"  name="map/vcStockName"
			                             id="vcStockName" width="100%"/>
			                        </td>
			                       	
			                       	<td style="width:85px" align="right">
			                            	发行主体:
			                        </td>
			                        <td style="width:20%" align="left">
			                           <input class="nui-textbox" name="map/vcIssuerNameFull" width="100%" />
			                        </td>
			                         
			                        <td align="right">
			                        <a class="nui-button" iconCls="icon-search"  onclick="search()">
								                	查询
								            </a>
			                        </td>
			                        <td align="left">
								            <a class="nui-button" iconCls="icon-reload"  onclick="reset()">
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
		                          <privilege:operation sourceId="ATS_CXS_SAVE" sid="save" clazz="nui-button" onClick="saveInfo()" lableName="保存" iconCls="icon-edit" ></privilege:operation>
		                          <privilege:operation sourceId="ATS_XZZCXX_QX" sid="underwriterWash" clazz="nui-button" onClick="underwriterWash()" lableName="清洗"  iconCls="icon-edit" ></privilege:operation>
		                          <privilege:operation sourceId="ATS_CXS_FB" sid="release" clazz="nui-button" onClick="release()" lableName="发布" iconCls="icon-edit" ></privilege:operation>
                                  <privilege:operation sourceId="ATS_CXS_DELTar" sid="delete" clazz="nui-button" onClick="deleteData()" lableName="删除" iconCls="icon-remove" ></privilege:operation>
		                        </td>
		                    </tr>
		                </table>
			         </div> 
			         <div id="layout1" class="mini-layout" style="width:100%; height:89%;"  borderStyle="border:solid 1px #aaa;"> 
			         <div title="center" region="center"  >
			     <div class="nui-fit" > 
			         <div  id="datagrid1" 
			                        class="nui-datagrid"
			                        style="width:100%;height:100%;"
			                        url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryDebtIssueUnderwriterTarget.biz.ext"
			                        sortField="lUnderwriterStockId" sortOrder="desc"
			                        onselectionchanged="selectionChanged"
			                        showPageInfo="true" pageSize="20" dataField="underwriterStockInfo"
			                        multiSelect="true"
			                        allowCellEdit="true"
						            allowCellSelect="true"
						            pagerButtons="#prompts_preset"
			                        >
			                    <div property="columns">
			                        <div type="indexcolumn"></div>
			                        <div type="checkcolumn"></div>
			                        <div field="lUnderwriterStockId" headerAlign="center" allowSort="true" visible="false">序号</div>
			                 		<div field="vcMainUnderwriter" headerAlign="center" allowSort="true" width="150px">主承销商
			                 		     <input property="editor" class="mini-textbox" style="width:100%;" />
			                 		</div>
			                 		<div field="vcMainUnderwriterSign" headerAlign="center" allowSort="true" visible="false">主承销商是否清洗标记</div>
			                 		<div field="vcUnderwriterContactInfo" headerAlign="center" allowSort="true" width="150px">主承销商相关联系方式</div>
			                 		<div field="vcApplicationTime" headerAlign="center" allowSort="true" width="180px">发行时间
			                 		     <input property="editor" class="mini-textbox" style="width:100%;" />
			                 		</div>
			                 		<div field="vcApplicationTimeSign" headerAlign="center" allowSort="true" visible="false">发行时间标记</div>
			                        <div field="vcIssuerNameFull" headerAlign="center" width="150px" allowSort="true" > 发行主体 
			                             <input property="editor" class="mini-textbox" style="width:100%;" />
			                        </div>
			                        <div field="vcIssuerNameFullSign" headerAlign="center" allowSort="true" visible="false">发行主体标记</div>
			                        <div field="vcStockType" headerAlign="center" allowSort="true" >债券类别
			                             <input property="editor" class="mini-textbox" style="width:100%;" />
			                        </div>
			                        <div field="vcStockTypeSign" headerAlign="center" allowSort="true" visible="false">债券类别标记</div>
			                        <div field="vcIssueType" headerAlign="center" allowSort="true" >发行方式
			                             <input property="editor" class="mini-textbox" style="width:100%;" />
			                        </div>
			                        <div field="vcIssueTypeSign" headerAlign="center" allowSort="true" visible="false">发行方式标记</div>
			                        <div field="vcStockName" headerAlign="center" allowSort="true"  width="180px">债券简称
			                             <input property="editor" class="mini-textbox" style="width:100%;" />
			                        </div>
			                        <div field="vcStockNameSign" headerAlign="center" allowSort="true"  width="180px" visible="false">债券简称标记</div>
			                        
			                        <div field="vcStockNameFull" headerAlign="center" allowSort="true" >债券全称</div>
			                        <div field="vcIssueBalance" headerAlign="center" allowSort="true" width="80px" align="right">发行规模(亿)
			                             <input property="editor" class="mini-textbox" style="width:100%;" />
			                        </div>
			                        <div field="vcIssueBalanceSign" headerAlign="center" allowSort="true" width="80px" align="right" visible="false">发行规模(亿)标记</div>
			                        <div field="vcExistLimite" headerAlign="center" allowSort="true" width="80px" align="right">发行期限(年)
			                             <input property="editor" class="mini-textbox" style="width:100%;" />
			                        </div>
			                        <div field="vcExistLimiteSign" headerAlign="center" allowSort="true" width="80px" align="right" visible="false">发行期限(年)标记</div>
			                        <div field="vcExistLimiteDesc" headerAlign="center" allowSort="true" width="80px" align="right">发行期限备注</div>
			                        <div field="vcInquiryInterval" headerAlign="center" allowSort="true"  align="right" width="80px" >询价区间
			                             <input property="editor" class="mini-textbox" style="width:100%;" />
			                        </div>
			                        <div field="vcInquiryIntervalSign" headerAlign="center" allowSort="true"  align="right" width="80px" visible="false">询价区间标记</div>
			                        <div field="vcInquiryIntervalTop" headerAlign="center" allowSort="true"  visible="false">询价区间上限</div>
			                        <div field="vcInquiryIntervalFloor" headerAlign="center" allowSort="true"  visible="false">询价区间下限</div>
			                        <div field="vcIssueAppraise" headerAlign="center" align="center" allowSort="true" width="80" >主体评级
			                             <input property="editor" class="mini-textbox" style="width:100%;" />
			                        </div>
			                        <div field="vcIssueAppraiseSign" headerAlign="center" align="center" allowSort="true" width="80" visible="false">主体评级标记</div>
			                        <div field="vcBondAppraise" headerAlign="center" align="center" width="60px">债券评级
			                             <input property="editor" class="mini-textbox" style="width:100%;" />
			                        </div>
			                        <div field="vcBondAppraiseSign" headerAlign="center" align="center" width="60px" visible="false">债券评级标记</div>
			                        <div field="vcAppraiseOrgan" headerAlign="center" width="150px" allowSort="true">债券评级机构
			                             <input property="editor" class="mini-textbox" style="width:100%;" />
			                        </div>
			                        <div field="vcAppraiseOrganSign" headerAlign="center" width="150px" allowSort="true" visible="false">债券评级机构标记</div>
			                        <div field="vcPaymentPlace" headerAlign="center" allowSort="true">登记托管机构
			                             <input property="editor" class="mini-textbox" style="width:100%;" />
			                        </div>
			                        <div field="vcPaymentPlaceSign" headerAlign="center" allowSort="true" visible="false">登记托管机构标记</div>
			                        <div field="vcDueDate" headerAlign="center" allowSort="true" >预计到期日</div>
			                        
			                        <div field="vcPayInteval" headerAlign="center" allowSort="true" >还本付息方式</div>
			                        <div field="vcBegincalDate" headerAlign="center" allowSort="true" >起息日</div>
			                        <div field="vcCreditSituation" headerAlign="center" allowSort="true" >增信情况
			                             <input property="editor" class="mini-textbox" style="width:100%;" />
			                        </div>
			                        <div field="vcCreditSituationSign" headerAlign="center" allowSort="true"  visible="false">增信情况标记</div>
									<div field="vcEnterpriseProperty" headerAlign="center" allowSort="true" >企业性质
									     <input property="editor" class="mini-textbox" style="width:100%;" />
									</div>
									<div field="vcEnterprisePropertySign" headerAlign="center" allowSort="true"  visible="false">企业性质标记</div>
									<div field="vcIsBid" headerAlign="center" allowSort="true" >是否城投</div>
									<div field="vcMarkAssets" headerAlign="center" allowSort="true" >标的资产</div>
									<div field="vcOldHolder" headerAlign="center" allowSort="true" >原始权益人</div>
									<div field="vcIsPledge" headerAlign="center" allowSort="true" >是否可质押</div>
									<div field="vcPropertyDesc" headerAlign="center" allowSort="true" >资质简介</div>
									<div field="vcHisIssue" headerAlign="center" allowSort="true" >历史发债</div>
									
									<div field="vcIsHaveFinancing" headerAlign="center" allowSort="true" >是否有过融资历史</div>
									<div field="cStatus" headerAlign="center" allowSort="true" visible="true" renderer="renderercStatus">承销商状态</div>
									<div field="vcMaterialUpdateTime" dateFormat="yyyy-MM-dd HH:mm:ss" width="160px"  headerAlign="center" allowSort="true" align="right" visible="true">材料网络版更新时间</div>
									<div field="vcRoadshowTime" dateFormat="yyyy-MM-dd HH:mm:ss" width="160px"  headerAlign="center" allowSort="true" align="right" visible="true">路演时间</div>
									<div field="vcMaterialDownloadLink" headerAlign="center" allowSort="true" >材料网络下载链接</div>
									<div field="vcSummaryDownloadLink" headerAlign="center" allowSort="true" >调研纪要/路演纪要（若有）下载链接</div>
									<div field="vcIndustryAttribute" headerAlign="center" allowSort="true" >行业属性</div>
									<div field="vcIsScopeOfContract" headerAlign="center" allowSort="true" >是否符合合同范围（针对我司产品）</div>
			                    </div>
			                    
			          </div>        
			          </div>
			          </div>
			          <div title="承销商详细信息" region="south" showSplit="false" showHeader="true" height="280" showSplitIcon="true" >
				       <!-- <div id="tabs" class="nui-tabs" height="100%" style="overflow: hidden;border-left: 0xp;"> -->
						<!-- <div title="基本信息"> -->
				        <div id="editForm1"  class="nui-form" style="margin-right:15px">
				            <input class="mini-hidden" name="id"/>
				             <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
					                <tr>
						                   <td align="right">主承销商:</td>
										    <td align="left"  style="width:15%">
										   	<input id="vcMainUnderwriter" width="100%" class="mini-textbox" name="vcMainUnderwriter"  readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>
						                    <td   align="right">发行时间:</td>
						                    <td   align="left" style="width:15%">
						                    	<input align="left" width="100%" id="vcApplicationTime" name="vcApplicationTime" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                    <td   align="right">发行主体全称:</td>
						                    <td   align="left" style="width:15%">
						                    	<input align="left" width="100%" name="vcIssuerNameFull" id="vcIssuerNameFull" class="mini-textbox"   readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                     <td align="right">承销商联系方式:</td>
										    <td align="left">
										   	<input  width="100%" class="mini-textbox" name="vcUnderwriterContactInfo" id="vcUnderwriterContactInfo" readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>
						                </tr>
							                
						                <tr>
						                    <td align="right">债券类别:</td>
										    <td align="left">
										   	<input id="vcStockType" width="100%" class="mini-textbox" name="vcStockType"  readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>
						                    <td   align="right">发行方式:</td>
						                    <td   align="left">
						                    	<input align="left" width="100%" id="vcIssueType" name="vcIssueType" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                    <td   align="right">债券简称:</td>
						                    <td    align="left">
						                    	<input align="left" width="100%" name="vcStockName" id="vcStockName" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                    <td   align="right">债券全称:</td>
						                    <td   align="left">
						                    	<input align="left" width="100%" name="vcStockNameFull" id="vcStockNameFull" class="mini-textbox"   readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>				                    
						                </tr>
						                <tr>
						                    <td align="right">发行规模(亿):</td>
										    <td align="left">
										   	<input id="vcIssueBalance" width="100%" class="mini-textbox" name="vcIssueBalance"  readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>
						                    <td   align="right">期限(年):</td>
						                    <td   align="left">
						                    	<input align="left" width="100%" id="vcExistLimite" name="vcExistLimite" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                    <td   align="right">期限备注:</td>
						                    <td    align="left">
						                    	<input align="left" width="100%" name="vcExistLimiteDesc" id="vcExistLimiteDesc" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                    <td   align="right">询价区间:</td>
						                    <td   align="left">
						                    	<input align="left" width="100%" name="vcInquiryInterval" id="vcInquiryInterval" class="mini-textbox"   readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>				                    
						                </tr>
						                <tr>
						                    <td align="right">主体评级:</td>
										    <td align="left">
										   	<input id="vcIssueAppraise" width="100%" class="mini-textbox" name="vcIssueAppraise"  readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>
						                    <td   align="right">债券评级:</td>
						                    <td   align="left">
						                    	<input align="left" width="100%" id="vcBondAppraise" name="vcBondAppraise" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                    <td   align="right">评级机构:</td>
						                    <td    align="left">
						                    	<input align="left" width="100%" name="vcAppraiseOrgan" id="vcAppraiseOrgan" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                    <td   align="right">登记托管机构:</td>
						                    <td   align="left">
						                    	<input align="left" width="100%" name="vcPaymentPlace" id="vcPaymentPlace" class="mini-textbox"   readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>				                    
						                </tr>
						                <tr>
						                    <td align="right">预计到期日:</td>
										    <td align="left">
										   	<input id="vcDueDate" width="100%" class="mini-textbox" name="vcDueDate"  readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>
						                    <td   align="right">还本付息方式:</td>
						                    <td   align="left">
						                    	<input align="left" width="100%" id="vcPayInteval" name="vcPayInteval" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                    <td   align="right">起息日:</td>
						                    <td    align="left">
						                    	<input align="left" width="100%" name="vcBegincalDate" id="vcBegincalDate" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                    <td   align="right">增信情况:</td>
						                    <td   align="left">
						                    	<input align="left" width="100%" name="vcCreditSituation" id="vcCreditSituation" class="mini-textbox"   readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>				                    
						                </tr>
						                <tr>
						                    <td align="right">企业性质:</td>
										    <td align="left">
										   	<input id="vcEnterpriseProperty" width="100%" class="mini-textbox" name="vcEnterpriseProperty"  readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>
						                    <td   align="right">是否城投:</td>
						                    <td   align="left">
						                    	<input align="left" width="100%" id="vcIsBid" name="vcIsBid" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                    <td   align="right">标的资产:</td>
						                    <td    align="left">
						                    	<input align="left" width="100%" name="vcMarkAssets" id="vcMarkAssets" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                    <td   align="right">原始权益人:</td>
						                    <td   align="left">
						                    	<input align="left" width="100%" name="vcOldHolder" id="vcOldHolder" class="mini-textbox"   readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>				                    
						                </tr>
						                <tr>
						                    <td align="right">是否可质押:</td>
										    <td align="left">
										   	<input  width="100%" class="mini-textbox" name="vcIsPledge" id="vcIsPledge" readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>
						                    <td   align="right">资质简介:</td>
						                    <td   align="left">
						                    	<input align="left" width="100%" id="vcPropertyDesc" name="vcPropertyDesc" class="mini-textbox" readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                    <td   align="right">历史发债:</td>
						                    <td    align="left">
						                    	<input align="left" width="100%" name="vcHisIssue" id="vcHisIssue" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                    <td   align="right">是否有过融资历史:</td>
						                    <td   align="left">
						                    	<input align="left" width="100%" id="vcIsHaveFinancing" name="vcIsHaveFinancing" class="mini-textbox"   readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>				                    
						                </tr>
						                <tr>
						                   
						                    <td align="right">材料网络版更新时间:</td>
										    <td align="left">
										   	<input  width="100%"  class="nui-datepicker" format="yyyy-MM-dd" name="vcMaterialUpdateTime" id="vcMaterialUpdateTime" readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>
										   	<td align="right">路演时间:</td>
										    <td align="left">
										   	<input  width="100%" class="nui-datepicker" format="yyyy-MM-dd" name="vcRoadshowTime" id="vcRoadshowTime"  readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>
										   	<td align="right">材料网络下载链接:</td>
										    <td align="left">
										   	<input  width="100%" class="mini-textbox"  name="vcMaterialDownloadLink" id="vcMaterialDownloadLink" readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>
										   	<td align="right">纪要下载链接:</td>
										    <td align="left">
										   	<input  width="100%" class="mini-textbox"  name="vcSummaryDownloadLink" id="vcSummaryDownloadLink"  readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>					                    
						                </tr>
						                <tr>
						                   
						                    <td align="right">行业属性:</td>
										    <td align="left">
										   	<input  width="100%" class="mini-textbox"  name="vcIndustryAttribute" id="vcIndustryAttribute" readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>
										   	<td align="right">是否符合合同范围:</td>
										    <td align="left">
										   	<input  width="100%" class="mini-textbox"  name="vcIsScopeOfContract" id="vcIsScopeOfContract"  readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>				                    
						                </tr>
					            </table>
				        </div>
				     <!--    </div>    -->
				       
				  <!--  </div> -->
				        
</div>
</div>
<div id="prompts_preset">
        <span class="separator"></span>
        <div class="invaliddata"></div>
        <div style= "display: inline-block; margin-right: 8px;">未清洗</div>
       	<div class="backdata"></div>
        <div style= "display:inline-block; margin-right: 8px;">修改</div>
    </div> 
<script type="text/javascript">
		nui.parse();
		var grid = nui.get("datagrid1");
		
    	var form = new nui.Form("#form1");
    	var formData = form.getData(false,false);
		grid.load(formData);
		 $("#editForm1 .mini-buttonedit-buttons").remove();
		 $("#editForm1 .mini-buttonedit-border").css("background-color","#f0f0f0");
		 var tempVcStockType = "";  
		 loadStockTypeAll();
		 function loadStockTypeAll(){
             	
             	nui.ajax({
				    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext",
				    type: "post",
				    dataType:"json",
				    success: function (text) {
				    	//nui.get("vcStockType").loadList(text.data);
				    	tempVcStockType = text.data;
				    }
				});
             	
             }
             
		 function search(){
		 	var vcStockName = nui.get("vcStockName").value;
            nui.get("vcStockNameFull").setValue(vcStockName);
          	var data = form.getData(false,false);      //获取表单多个控件的数据
        	var editForm1 = new nui.Form("#editForm1");
        	editForm1.reset();
            grid.load(data);
		 }
		function reset(){
			form.reset();
			nui.get("cStatus").setValue("");//重置按钮情况状态值
		}
		function renderercStatus(e){
			if(e.row.cStatus==0){
				return "新导入";
			}else if(e.row.cStatus==1){
				return "持续更新中";
			}else if(e.row.cStatus==2){
				return "已发布";
			}else{
				return "废弃";
			}
		}
		Date.prototype.Format = function (fmt) { 
		    var o = {
		        "M+": this.getMonth() + 1, //月份 
		        "d+": this.getDate(), //日 
		        "h+": this.getHours(), //小时 
		        "m+": this.getMinutes(), //分 
		        "s+": this.getSeconds(), //秒 
		        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
		        "S": this.getMilliseconds() //毫秒 
		    };
		    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		    for (var k in o)
		    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		    return fmt;
		}
		
		//行单击时重新设置tabs页面参数
		grid.on("rowclick", function (e) {
			var form = new nui.Form("#editForm1");//将普通form转为nui的form
			form.setData(e.row);
			
    	});
    	
	 //当选择列时
    function selectionChanged(){
        var rows = grid.getSelecteds();
        if(rows.length>1){
            nui.get("release").disable();
        }else{
            nui.get("release").enable();
        }
    } 
		//发布
	function release(){
		var row = grid.getSelected();
        
        if (row) {//com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.underwriterToStockIssue
	    	if(row.cStatus==5){
	        	nui.alert("改数据已经作废!");
	        	return;
	        }
	    	nui.open({
            url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/underwriterToStockIssue.jsp",
            title: "承销商信息发布", 
            width: 1200, 
   			height: 650,
            //allowResize:false,
            onload: function () {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.SetDataInit(row,tempVcStockType,allVcIssueAppraiseCsrc,allVcIndustry);
            },
            ondestroy: function (action) {
                if(action=="saveSuccess"){
                    grid.reload();
           	 	}
            }
            });
        } else {
            nui.alert("请选择要发布的记录！");
        }
	}
	
	var allVcIssueAppraiseCsrc;
	var allVcIndustry;
	loadVcIssueAppraiseCsrcAll();
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
	     
	  //渲染行对象
	 grid.on("drawcell", function (e) {
	 var record = e.record,
        row=e.row;
        //debugger;
        field = e.field;
         	//action列，超连接操作按钮
         	//debugger;
	        if ((field == "vcMainUnderwriter" && record.vcMainUnderwriterSign=="1") || 
	            (field == "vcApplicationTime" && record.vcApplicationTimeSign=="1") ||
	            (field == "vcIssuerNameFull" && record.vcIssuerNameFullSign=="1") || 
	            (field == "vcStockType" && record.vcStockTypeSign=="1") || 
	            (field == "vcIssueType" && record.vcIssueTypeSign=="1") || 
	            (field == "vcStockName" && record.vcStockNameSign=="1") || 
	            (field == "vcIssueBalance" && record.vcIssueBalanceSign=="1") || 
	            (field == "vcExistLimite" && record.vcExistLimiteSign=="1") || 
	            (field == "vcInquiryInterval" && record.vcInquiryIntervalSign=="1") || 
	            (field == "vcBondAppraise" && record.vcBondAppraiseSign=="1") || 
	            (field == "vcAppraiseOrgan" && record.vcAppraiseOrganSign=="1") || 
	            (field == "vcIssueAppraise" && record.vcIssueAppraiseSign=="1") || 
	            (field == "vcPaymentPlace" && record.vcPaymentPlaceSign=="1") || 
	            (field == "vcCreditSituation" && record.vcCreditSituationSign=="1") ||
	            (field == "vcEnterpriseProperty" && record.vcEnterprisePropertySign=="1") 
	           ) {
	            e.cellStyle = "background-color:#FFFFBB;";
	        }
	        if ((field == "vcMainUnderwriter" && record.vcMainUnderwriterSign=="3") || 
	            (field == "vcApplicationTime" && record.vcApplicationTimeSign=="3") ||
	            (field == "vcIssuerNameFull" && record.vcIssuerNameFullSign=="3") || 
	            (field == "vcStockType" && record.vcStockTypeSign=="3") || 
	            (field == "vcIssueType" && record.vcIssueTypeSign=="3") || 
	            (field == "vcStockName" && record.vcStockNameSign=="3") || 
	            (field == "vcIssueBalance" && record.vcIssueBalanceSign=="3") || 
	            (field == "vcExistLimite" && record.vcExistLimiteSign=="3") || 
	            (field == "vcInquiryInterval" && record.vcInquiryIntervalSign=="3") ||
	            (field == "vcBondAppraise" && record.vcBondAppraiseSign=="3") || 
	            (field == "vcAppraiseOrgan" && record.vcAppraiseOrganSign=="3") || 
	            (field == "vcIssueAppraise" && record.vcIssueAppraiseSign=="3") || 
	            (field == "vcPaymentPlace" && record.vcPaymentPlaceSign=="3") || 
	            (field == "vcCreditSituation" && record.vcCreditSituationSign=="3") ||
	            (field == "vcEnterpriseProperty" && record.vcEnterprisePropertySign=="3") 
	           ) {
	            e.cellStyle = "background-color:#FFCCCC;";
	        }
	        	
	}); 
	function saveInfo(){
	debugger;
	    //获得增加、删除、修改的记录集合
	    var rows = grid.getChanges();
	    var processIdArr = new Array();
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];
    			var processIdTemp = {
    			    lUnderwriterStockId: record.lUnderwriterStockId,
    			    vcMainUnderwriter:record.vcMainUnderwriter,
    			    vcMainUnderwriterSign:record.vcMainUnderwriterSign,
    			    vcApplicationTime:record.vcApplicationTime,
    			    vcApplicationTimeSign:record.vcApplicationTimeSign,
    			    vcIssuerNameFull:record.vcIssuerNameFull,
    			    vcIssuerNameFullSign:record.vcIssuerNameFullSign,
    			    vcStockType:record.vcStockType,
    			    vcStockTypeSign:record.vcStockTypeSign,
    			    vcIssueType:record.vcIssueType,
    			    vcIssueTypeSign:record.vcIssueTypeSign,
    			    vcStockName:record.vcStockName,
    			    vcStockNameSign:record.vcStockNameSign,
    			    vcIssueBalance:record.vcIssueBalance,
    			    vcIssueBalanceSign:record.vcIssueBalanceSign,
    			    vcExistLimite:record.vcExistLimite,
    			    vcExistLimiteSign:record.vcExistLimiteSign,
    			    vcInquiryInterval:record.vcInquiryInterval,
    			    vcInquiryIntervalSign:record.vcInquiryIntervalSign,
    			    vcIssueAppraise:record.vcIssueAppraise,
    			    vcIssueAppraiseSign:record.vcIssueAppraiseSign,
    			    
    			    vcBondAppraise:record.vcBondAppraise,
    			    vcBondAppraiseSign:record.vcBondAppraiseSign,
    			    vcAppraiseOrgan:record.vcAppraiseOrgan,
    			    vcAppraiseOrganSign:record.vcAppraiseOrganSign,
    			    vcPaymentPlace:record.vcPaymentPlace,
    			    vcPaymentPlaceSign:record.vcPaymentPlaceSign,
    			    vcCreditSituation:record.vcCreditSituation,
    			    vcCreditSituationSign:record.vcCreditSituationSign,
    			    vcEnterpriseProperty:record.vcEnterpriseProperty,
    			     
    			    vcEnterprisePropertySign:record.vcEnterprisePropertySign
    			};
    			if(record.vcInquiryInterval !=null && record.vcInquiryInterval.indexOf("-") != -1){
    			      processIdTemp.vcInquiryIntervalFloor=record.vcInquiryInterval.split("-")[0];
    			      processIdTemp.vcInquiryIntervalTop=record.vcInquiryInterval.split("-")[1];
    			    
    			}
    			processIdArr.push(processIdTemp);
    		}
	    var json = nui.encode({underwriterTargetInfo:processIdArr});
	    grid.loading("保存中，请稍后......");        
	    $.ajax({
	        url: "com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.saveDebtIssueUnderwriterTarget.biz.ext",
	        type:'POST',
            data:json,
            cache: false,
            contentType:'text/json',
	        success: function (text) {
	            grid.reload();
	        },
	        error: function (jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.responseText);
	        }
	    });
	}
	grid.on("cellcommitedit", onCellCommitEdit);
	//提交单元格编辑数据前激发
	function onCellCommitEdit(e) {
	    if (e.oldValue != e.value) {
	        var grid = e.sender;
            var record = e.record;
            var field = e.field;
	        if (field == "vcMainUnderwriter") {                 
                grid.updateRow(record, { vcMainUnderwriterSign: "3"});
            }else if (field == "vcApplicationTime") {                 
                grid.updateRow(record, { vcApplicationTimeSign: "3"});
            }else if (field == "vcIssuerNameFull") {                 
                grid.updateRow(record, { vcIssuerNameFullSign: "3"});
            }else if (field == "vcStockType") {                 
                grid.updateRow(record, { vcStockTypeSign: "3"});
            }else if (field == "vcIssueType") {                 
                grid.updateRow(record, { vcIssueTypeSign: "3"});
            }else if (field == "vcStockName") {                 
                grid.updateRow(record, { vcStockNameSign: "3"});
            }else if (field == "vcIssueBalance") {                 
                grid.updateRow(record, { vcIssueBalanceSign: "3"});
            }else if (field == "vcInquiryInterval") {                 
                grid.updateRow(record, { vcInquiryIntervalSign: "3"});
            }else if (field == "vcAppraiseOrgan") {                 
                grid.updateRow(record, { vcAppraiseOrganSign: "3"});
            }else if (field == "vcPaymentPlace") {                 
                grid.updateRow(record, { vcPaymentPlaceSign: "3"});
            }else if (field == "vcCreditSituation") {                 
                grid.updateRow(record, { vcCreditSituationSign: "3"});
            }else if (field == "vcEnterpriseProperty") {                 
                grid.updateRow(record, { vcEnterprisePropertySign: "3"});
            }else if (field == "vcExistLimite") {                 
                grid.updateRow(record, { vcExistLimiteSign: "3"});
            }else if (field == "vcIssueAppraise") {                 
                grid.updateRow(record, { vcIssueAppraiseSign: "3"});
            }else if (field == "vcBondAppraise") {                 
                grid.updateRow(record, { vcBondAppraiseSign: "3"});
            }
	    }
	}
	
	
    function underwriterWash(){
	    var json = nui.encode({});
	    grid.loading("清洗中，请稍后......");        
	    $.ajax({
	        url: "com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.underwriterStockInfoWash.biz.ext",
	        type:'POST',
            data:json,
            cache: true,
            contentType:'text/json',
	        success: function (text) {
	            if(text.isSuccess=="true"){
	               nui.alert("数据清洗完成！", "系统提示", function(action){});
	            }else{
	               nui.alert("数据清洗失败！", "系统提示", function(action){});
	            }
	            grid.unmask();//取消遮罩
	        },
	        error: function (jqXHR, textStatus, errorThrown) {
	            alert(jqXHR.responseText);
	        }
	    });
	}
	function deleteData(){
    	var rows = grid.getSelecteds();
    	if (rows.length>0) {//com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.updateUnderwriterInfo
    		nui.confirm("请确定需要删除承销商信息？","删除确认",function(action){
	            if(action!="ok") return;
				
				var json = nui.encode({underwriterTarget:rows});
				$.ajax({
		          url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.deleteUnderwriterTarget.biz.ext",
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
   </script>
</body>
</html>