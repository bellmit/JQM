<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@include file="/common/js/commscripts.jsp" %>
<%
	String userIdSZ = ""; 
	if (userObject != null) {
		userIdSZ = (String)userObject.getUserId();
	}
 %>
<!-- 
  - Author(s): 谢海光
  - Date: 2017-10-27
  - Description:
-->
<head>
<title>主承销商新债预发行数据</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body style="width:100%;height:100%;overflow:height; margin: 0px;">
      		<div class="search-condition">
					<div class="list">
			            <div id="form1" class="nui-form"  align="center" style="height:10%" >
			                <form id="queryForm" action="">
			                <input type="hidden" class="nui-hidden" id="excelData" name="excelData" />
			                <input type="hidden" class="nui-hidden" id="fileName" name="fileName" />
			                <input type="hidden" class="nui-hidden" id="type" name="type" />
			                <input type="hidden" class="nui-hidden" id="userName" name="userName" />
			                <table id="table1" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
			                    <tr>
			                        <td style="width:60px" align="right">
			                        	债券简称:
			                        </td>
			                        <td  align="left">
			                         	<input  class="nui-textbox"  name="map/vcStockName"
			                             id="vcStockName" width="100%"/>
			                        </td>
			                       	
			                       	<td style="width:85px" align="right">
			                            	发行主体:
			                        </td>
			                        <td  align="left">
			                           <input class="nui-textbox" name="map/vcIssuerNameFull" width="100%" />
			                        </td>
			                        
			                        <td align="right">
			                            	更新时间:
			                        </td>
			                        <td  align="left" >
			                            <input class="nui-datepicker" id="dUpdateTimeMap" format="yyyy-MM-dd" name="map/dUpdateTime" style="width:100%"/>
			                        </td>
			                        
			                        <td align="center">
								            <a class='nui-button' plain='false' iconCls="icon-reload"  onclick="reset()">
								                	重置
								            </a>
								     </td> 
			                   </tr>
			                    <tr>
			                        <td style="width:60px" align="right">
			                        	主承销商:
			                        </td>
			                        <td  align="left">
			                         	<input  class="nui-textbox"  name="map/vc_main_underwriter"
			                             id="vc_main_underwriter" width="100%"/>
			                        </td>
			                       	
			                       	<td style="width:85px" align="right">
			                            	数据来源:
			                        </td>
			                        <td  align="left">
			                           <input class="nui-combobox" name="map/c_source" dictTypeId="c_source"  id="c_source"
                        			data="[{id: 1, text: '上海'}, {id: 2, text: '深圳'}, {id: 9, text: '主承新增'} ]" 
                        			showNullItem="false" multiSelect="false" showClose="true" valueFromSelect="true"
									  oncloseclick="onCloseClickValueEmpty"  width="100%"/>
			                        </td>
			                        
			                        <td align="right">
			                            	项目状态:
			                        </td>
			                        <td  align="left" >
			                            <input class="nui-combobox" name="map/c_status" dictTypeId="c_status"  id="c_status"
                        			data="[{id: 1, text: '已受理'}, {id: 2, text: '已反馈'}, {id: 3, text: '已接收反馈意见'}, {id: 4, text: '通过'}, {id: 5, text: '未通过'}
                        			, {id: 8, text: '终止'}, {id: 9, text: '中止'}, {id: 10, text: '已回复交易所意见'}, {id: 90, text: '新导入'}, {id: 91, text: '持续更新中'}, {id: 92, text: '已发布'} ]" 
                        			showNullItem="false" multiSelect="false" showClose="true" valueFromSelect="true"
									  oncloseclick="onCloseClickValueEmpty"  width="100%"/>
			                        </td>
			                        <td align="center">
			                        <a class='nui-button' plain='false' iconCls="icon-search"  onclick="search()">
								                	查询
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
                                    <privilege:operation sourceId="ATS_CXS_UN_REL" sid="underwriterReleaseRefur" clazz="nui-button" onClick="underwriterReleaseRefur()" lableName="刷新"  iconCls="icon-reload" ></privilege:operation>
                                    <privilege:operation sourceId="ATS_CXS_DELREL" sid="deleteRel" clazz="nui-button" onClick="deleteData()" lableName="删除" iconCls="icon-remove" ></privilege:operation>
                                    <privilege:operation sourceId="ATS_CXS_DC_REL" sid="exportExcelCustom" clazz="nui-button" onClick="exportExcelCustom()" lableName="自定义列导出"  iconCls="icon-download" ></privilege:operation>
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
			                        url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryDebtIssueUnderwriterRelease.biz.ext"
			                        sortField="lUnderwriterStockId" sortOrder="desc"
			                        showPageInfo="true" pageSize="20" dataField="underwriterStockInfo"
			                        multiSelect="true"
			                        >
			                    <div property="columns">
			                        <div type="indexcolumn"></div>
			                        <div type="checkcolumn"></div>
			                        <div field="lUnderwriterRelId" headerAlign="center" allowSort="true" visible=false>序号</div>
			                        <div field="lUnderwriterStockId" headerAlign="center" allowSort="true" visible=false>序号</div>
			                 		<div field="vcMainUnderwriter" headerAlign="center" allowSort="true" width="150px">主承销商</div>
			                 		<div field="vcUnderwriterContactInfo" headerAlign="center" allowSort="true" width="150px">主承销商相关联系方式</div>
			                 
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
									<div field="cSource" headerAlign="center" allowSort="true" renderer="rendercSource">数据来源</div>
									<div field="cStatus" headerAlign="center" allowSort="true" renderer="rendercStatus">项目状态</div>
									<div field="dUpdateTime" dateFormat="yyyy-MM-dd HH:mm:ss" width="160px"  headerAlign="center" allowSort="true" align="right" visible="true">更新时间</div>
			                    </div>
			          </div>
			          </div>
			          </div>
			          <div title="预发行详细信息" region="south" showSplit="false" showHeader="true" height="260" showSplitIcon="true" >
				       <div id="tabs" class="nui-tabs" height="100%" style="overflow: hidden;border-left: 0xp;">
						<div title="基本信息">
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
						                    <td   align="right">簿记时间:</td>
						                    <td    align="left" style="width:15%">
						                    	<input align="left" width="100%" name="vcEntryTime" id="vcEntryTime" class="mini-textbox"  readonly="true"  inputStyle="background-color:#f0f0f0;"/>
						                    </td>
						                    <td   align="right">发行主体全称:</td>
						                    <td   align="left" style="width:15%">
						                    	<input align="left" width="100%" name="vcIssuerNameFull" id="vcIssuerNameFull" class="mini-textbox"   readonly="true"  inputStyle="background-color:#f0f0f0;"/>
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
						                    <td align="right">承销商联系方式:</td>
										    <td align="left">
										   	<input  width="100%" class="mini-textbox" name="vcUnderwriterContactInfo" id="vcUnderwriterContactInfo" readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>
						                    
										   	<td align="right">更新时间:</td>
										    <td align="left">
										   	<input  width="100%" class="mini-textbox"  name="UpdateTime" id="UpdateTime"  readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>	
										   	<td align="right">数据来源:</td>
										    <td align="left">
										   	<input  width="100%" class="nui-combobox"  name="cSource" id="cSource"  readonly="true" inputStyle="background-color:#f0f0f0;" dictTypeId="c_source"  
                        			data="[{id: 1, text: '上海'}, {id: 2, text: '深圳'}, {id: 9, text: '主承新增'} ]" />
										   	</td>	
										   	<td align="right">项目状态:</td>
										    <td align="left">
										   	<input  width="100%" class="nui-combobox"  name="cStatus" id="cStatus"  readonly="true" inputStyle="background-color:#f0f0f0;" dictTypeId="c_status" 
                        			data="[{id: 1, text: '已受理'}, {id: 2, text: '已反馈'}, {id: 3, text: '已接收反馈意见'}, {id: 4, text: '通过'}, {id: 5, text: '未通过'}
                        			, {id: 8, text: '终止'}, {id: 9, text: '中止'}, {id: 10, text: '已回复交易所意见'}, {id: 90, text: '新导入'}, {id: 91, text: '持续更新中'}, {id: 92, text: '已发布'} ]" />
										   	</td>				                    
						                </tr>
							             
					            </table>
				        </div>
				        </div>
				        
				   </div>
				        
</div>

</div>
<form id="file_download" method="post">
                    <!-- 数据实体的名称 -->
                    <input class="nui-hidden" name="processId" id="processId" />
                    <input class="nui-hidden" name="sysid" id="sysid" />
                    <input class="nui-hidden" name="lBizId" id="lBizId" />
                </form>
<script type="text/javascript">
		nui.parse();
		var grid = nui.get("datagrid1");
		var userName='<%=userIdSZ %>';          //数字ID
		nui.get("userName").setValue(userName);
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
				var rows = grid.getSelecteds();
        if(rows.length==1){
           form.setData(rows[0]);
			var updatetime = rows[0].dUpdateTime;
			if(updatetime == null || updatetime == ""){
				nui.get("UpdateTime").setValue("");
			}else{
				nui.get("UpdateTime").setValue(new Date(updatetime).Format("yyyy-MM-dd hh:mm:ss"));
			}
			
	        }else{
	           form.reset();
	        }
    	});
    	
    	function underwriterReleaseRefur(){
		    var json = nui.encode({});
		    grid.loading("预发行数据刷新，请稍后......");        
		    $.ajax({
		        url: "com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.underwriterStockInfoRelease.biz.ext",
		        type:'POST',
	            data:json,
	            cache: true,
	            contentType:'text/json',
		        success: function (text) {
		            if(text.isSuccess=="true"){
		               nui.alert("数据刷新完成！", "系统提示", function(action){});
		               search();
		            }else{
		               nui.alert("数据刷新失败！", "系统提示", function(action){});
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
				var json = nui.encode({underwriterRelase:rows});
				$.ajax({
		          url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.deleteUnderwriterRelase.biz.ext",
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
    //Excel自定义列导出
	function exportExcelCustom(){
            var frm = document.getElementById("queryForm");
       		var rows = grid.getSelecteds();
       		var ids = new Array();
            if (rows.length > 0) {
                for(var i=0;i<rows.length;i++){
                	ids.push(rows[i].lUnderwriterRelId);
                }
                var data = ids.join(',');
                 var customValue={
                      "excelData":data,
                      "fileName":"预发行承销商信息.xls",
                      "type":"3"
                 };
				nui.open({
		            url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/exportCustomUnderwriterRelExcel.jsp",
		            title: "主承销商自定义列导出", 
		            width: 740, 
		   			height: 308,
		            //allowResize:false,
		            onload: function () {
		                var iframe = this.getIFrameEl();
		                iframe.contentWindow.SetDataInit(customValue);
		            },
		            ondestroy: function (action) {
		                if(action=="saveSuccess"){
		                    grid.reload();
		           	 	}
		            }
		            });
            } else {
                //nui.alert("请选中一条记录");
                //return false;
                nui.confirm("全部导出用时比较久，是否全部导出？","系统提示",function (a){
				if(a=="ok"){ 
				    var customValue={
                      "excelData":"",
                      "fileName":"预发行承销商信息.xls",
                      "type":"3"
	                 };
					nui.open({
			            url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/exportCustomUnderwriterRelExcel.jsp",
			            title: "主承销商自定义列导出", 
			            width: 740, 
			   			height: 308,
			            //allowResize:false,
			            onload: function () {
			                var iframe = this.getIFrameEl();
			                iframe.contentWindow.SetDataInit(customValue);
			            },
			            ondestroy: function (action) {
			                if(action=="saveSuccess"){
			                    grid.reload();
			           	 	}
			            }
			            });
				  }   
				});
            }
	}
	//项目状态
			function rendercStatus(e){
				if(e.row.cStatus == '90' ){
					return "新导入";
				}else if(e.row.cStatus == '91'){
					return "持续更新中";
				}else if(e.row.cStatus == '92'){
					return "已发布";
				}else if(e.row.cStatus == '1'){
					return "已受理";
				}else if(e.row.cStatus == '2'){
					return "已反馈";
				}else if(e.row.cStatus == '3'){
					return "已接收反馈意见";
				}else if(e.row.cStatus == '4'){
					return "通过";
				}else if(e.row.cStatus == '5'){
					return "未通过";
				}else if(e.row.cStatus == '8'){
					return "终止";
				}else if(e.row.cStatus == '9'){
					return "中止";
				}else if(e.row.cStatus == '10'){
					return "已回复交易所意见";
				}else if(e.row.cStatus == '11'){
					return "中止审核";
				}else{
				    return "无定义状态："+e.row.cStatus;
				}
			}
			//数据来源
			function rendercSource(e){
				if(e.row.cSource == 1){
					return "上海";
				}else if(e.row.cSource == 2){
					return "深圳";
				}else if(e.row.cSource == 9){
					return "主承新增";
				}
			}
   </script>
  </body>
</html>