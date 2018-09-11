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
  - Author(s): 黄燕
  - Date: 2017-03-02 11:20:22
  - Description:
-->
<head>
<title>主承销商新债数据</title>
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
			                         <td style="width:85px" align="right">
			                            	新债状态:
			                        </td>
			                        <td align="left">
			                              <input class="nui-combobox" data="[{id:'0',text:'新导入'}, {id:'1', text: '持续更新中'}, {id:'2', text: '已发布'},{id:'5',text:'废弃'}]"
			                                oncloseclick="onCloseClickValueEmpty" showClose="true" showNullItem="false" 
			                                 width="100%" name="map/cStatus" id="cStatus" emptyText="全部" value="0,1" nullItemText="全部"/>
			                        </td>
			                        <td align="right">
			                            	更新时间:
			                        </td>
			                        <td  align="left" >
			                            <input class="nui-datepicker" id="dUpdateTimeMap" format="yyyy-MM-dd" name="map/dUpdateTime" style="width:100%"/>
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
		                            <!-- <a class='nui-button' plain='false' iconCls="icon-upload" sid="upload" onclick="upload()">导入</a>
		                            <a class='nui-button' plain='false' iconCls="icon-edit" sid="edit"  onclick="edit()">修改</a>
		                            <a class='nui-button' plain='false' iconCls="icon-remove" sid="deleteDate" onclick="deleteDate()">删除</a>
		                            <a class='nui-button' plain='false' iconCls="icon-edit" sid="release" onclick="release()">发布</a> -->
		                            <privilege:operation sourceId="ATS_CXS_XZ" sid="add" clazz="nui-button" onClick="add()" lableName="新增"  iconCls="icon-add" ></privilege:operation>
		                           <!--  <privilege:operation sourceId="ATS_CXS_DR" sid="upload" clazz="nui-button" onClick="upload()" lableName="导入"  iconCls="icon-upload" ></privilege:operation> -->
		                            <privilege:operation sourceId="ATS_CXS_XG" sid="edit" clazz="nui-button" onClick="edit()" lableName="修改" iconCls="icon-edit" ></privilege:operation>
		                            <privilege:operation sourceId="ATS_CXS_SC" sid="deleteDate" clazz="nui-button" onClick="deleteDate()" lableName="删除" iconCls="icon-remove" ></privilege:operation>
		                           <!--  <privilege:operation sourceId="ATS_CXS_FB" sid="release" clazz="nui-button" onClick="release()" lableName="发布" iconCls="icon-edit" ></privilege:operation> -->
		                            <!-- <privilege:operation sourceId="ATS_CXS_DC" sid="exportExcel" clazz="nui-button" onClick="exportExcel()" lableName="导出"  iconCls="icon-download" ></privilege:operation> -->
                                    <privilege:operation sourceId="ATS_CXS_DC_CT" sid="exportExcelCustom" clazz="nui-button" onClick="exportExcelCustom()" lableName="自定义列导出"  iconCls="icon-download" ></privilege:operation>
                                    <privilege:operation sourceId="ATS_CXS_DR_CT" sid="uploadExcelCustom" clazz="nui-button" onClick="uploadExcelCustom()" lableName="自定义列导入"  iconCls="icon-upload" ></privilege:operation>
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
			                        url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryDebtIssueUnderwriter.biz.ext"
			                        sortField="lUnderwriterStockId" sortOrder="desc"
			                        onselectionchanged="selectionChanged"
			                        showPageInfo="true" pageSize="20" dataField="underwriterStockInfo"
			                        multiSelect="true"
			                        >
			                    <div property="columns">
			                        <div type="indexcolumn"></div>
			                        <div type="checkcolumn"></div>
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
									<div field="cStatus" headerAlign="center" allowSort="true" visible="true" renderer="renderercStatus">承销商状态</div>
									<div field="lReleaseCount" headerAlign="center" allowSort="true" align="right" visible="true">发布次数</div>
									<div field="lOperatorNo" headerAlign="center" allowSort="true" align="right" visible="true">更新人</div>
									<div field="dUpdateTime" dateFormat="yyyy-MM-dd HH:mm:ss" width="160px"  headerAlign="center" allowSort="true" align="right" visible="true">更新时间</div>
			                    </div>
			          </div>
			          </div>
			          </div>
			          <div title="承销商详细信息" region="south" showSplit="false" showHeader="true" height="260" showSplitIcon="true" >
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
						                    <td align="right">更新人:</td>
										    <td align="left">
										   	<input  width="100%" class="mini-textbox"  name="lOperatorNo" id="lOperatorNo" readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>
										   	<td align="right">更新时间:</td>
										    <td align="left">
										   	<input  width="100%" class="mini-textbox"  name="UpdateTime" id="UpdateTime"  readonly="true" inputStyle="background-color:#f0f0f0;" />
										   	</td>				                    
						                </tr>
							             
					            </table>
				        </div>
				        </div>
				        <div title="附件信息">
				        	<div id="editForm2"  class="nui-form" style="margin-right:15px">
				        	    <div style="margin-left:15px">
									<a class='nui-button' plain='false' id="fileDownload" iconCls="icon-download" onclick="fileDownload()" style="margin-top: 4px;">附件下载</a>
								</div>
				                <div id="file_Form">
									<input class="nui-hidden" id="mapBizId" name="map/bizId" />
									<input class="nui-hidden" id="mapAttachBusType" name="map/attachBusType" value="1"/>
									<input class="nui-hidden" id="mapProcessinstid" name="map/processinstid" />
								</div>
								<div id="file_grid" class="mini-datagrid" style="width:100%;height:175px;" 
									 url=""  showPager="false"  multiSelect="true"
									 pageSize="50" >
									 <div property="columns">
										<div type="checkcolumn" width="20"></div>
										<div field="lAttachId"  headerAlign="center" visible="false">编号</div> 
										<div field="vcAttachName"  headerAlign="center" style="width: 70%;" readOnly="true">附件名称</div> 
										<div field="vcAttachAdd"  headerAlign="center" width="100" headerAlign="center" readOnly="true">附件地址</div>
										<div field="dCreateTime" width="40" headerAlign="center" dateFormat="yyyy-MM-dd">
                                                                                           创建时间
                                        </div>
                                        <div field="vcUserId" width="40" headerAlign="center">
                                                                                           用户名称
                                        </div>		
									 </div>
								</div>   
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
		var file_grid = nui.get("file_grid");
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
				var rows = grid.getSelecteds();
        if(rows.length==1){
           form.setData(rows[0]);
			var updatetime = rows[0].dUpdateTime;
			if(updatetime == null || updatetime == ""){
				nui.get("UpdateTime").setValue("");
			}else{
				nui.get("UpdateTime").setValue(new Date(updatetime).Format("yyyy-MM-dd hh:mm:ss"));
			}
			var vcAttachBizType = "9,10";
			var json =nui.encode({lBizId:rows[0].lUnderwriterStockId,vcAttachBizType:vcAttachBizType});
			$.ajax({
	          url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryUnderwriterAttach.biz.ext",
	          type: 'POST',
		      data: json,
		      cache: false,
		      contentType:'text/json',
	          success:function(text){
	            var returnJson = nui.decode(text);
			    if(returnJson.exception == null){
			      var data=returnJson.underwriterAttach;
			          file_grid.setData(data);
				    }
		          }
		        });
	        }else{
	           form.reset();
	           file_grid.setData(null);
	        }
    	});
    	
    	function upload() {
			mini.open({
			    url:"<%=request.getContextPath() %>/fm/baseinfo/fileupload/importUnderwriterStockInfo.jsp",
			    title: "承销商新债信息导入", width: 850, height: 580,
			    overflow:"hidden",
			    onload: function () {
			       
			    },
			    ondestroy: function (action) {
			        grid.reload();
			    }
		});
    }
    //自定义列导入
    function uploadExcelCustom() {
			mini.open({
			    url:"<%=request.getContextPath() %>/fm/baseinfo/fileupload/customImportUnderwriterStockInfo.jsp",
			    title: "承销商新债信息自定义导入", width: 850, height: 580,
			    overflow:"hidden",
			    onload: function () {
			       
			    },
			    ondestroy: function (action) {
			        grid.reload();
			    }
		});
    }
    function deleteDate(){
    	var rows = grid.getSelecteds();
    	if (rows.length>0) {//com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.updateUnderwriterInfo
    		nui.confirm("请确定需要删除承销商录入信息？","删除确认",function(action){
	            	if(action!="ok") return;
				for(var i=0;i<rows.length;i++){
					if(rows[i].cStatus==5){
						nui.alert("该条数据已经作废!");
						return;
					}
				}
				var json = nui.encode({underwriterInfoArray:rows,type:'1'});
				$.ajax({
		          url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.updateUnderwriterInfo.biz.ext",
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
    function edit(){
	    var row = grid.getSelected();
        if (row) {
            nui.open({
                url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtUnderwriterEdit.jsp",
                title: "承销商信息修改", 
                width: 980, 
       			height: 650,
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
            nui.alert("请选择要修改的记录！");
        }
	}
	function add(){
	    nui.open({
            url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtUnderwriterEdit.jsp",
            title: "承销商信息新增", 
            width: 980, 
   			height: 650,
            onload: function () {
                 var iframe = this.getIFrameEl();
                    iframe.contentWindow.loadStockTypeAll();
            },
            ondestroy: function (action) {
                grid.reload();
            }
        });
	}			
	//当选择列时
    function selectionChanged(){
        var rows = grid.getSelecteds();
        if(rows.length>1){
            nui.get("edit").disable();
            //nui.get("deleteDate").disable();
            //nui.get("release").disable();
        }else{
            nui.get("edit").enable();
            //nui.get("deleteDate").enable();
            //nui.get("release").enable();
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

	//Excel自定义列导出
	function exportExcelCustom(){
            var frm = document.getElementById("queryForm");
       		var rows = grid.getSelecteds();
       		var ids = new Array();
            if (rows.length > 0) {
                for(var i=0;i<rows.length;i++){
                	ids.push(rows[i].lUnderwriterStockId);
                }
                var data = ids.join(',');
                 var customValue={
                      "excelData":data,
                      "fileName":"承销商信息.xls",
                      "type":"2"
                 };
				nui.open({
		            url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/exportCustomExcel.jsp",
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
                      "fileName":"承销商信息.xls",
                      "type":"2"
	                 };
					nui.open({
			            url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/exportCustomExcel.jsp",
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
	//导出
       function  exportExcel(){
       		var frm = document.getElementById("queryForm");
       		var rows = grid.getSelecteds();
       		var ids = new Array();
            if (rows.length > 0) {
                for(var i=0;i<rows.length;i++){
                	ids.push(rows[i].lUnderwriterStockId);
                }
                var data = ids.join(',');
                 nui.get("excelData").setValue(data);
                 nui.get("fileName").setValue("承销商信息.xls");
                 nui.get("type").setValue("1");
				frm.action = "com.cjhxfund.ats.fm.baseinfo.debtIssueExport.flow";
				frm.submit();
            } else {
                //nui.alert("请选中一条记录");
                //return false;
                nui.confirm("全部导出用时比较久，是否全部导出？","系统提示",function (a){
				if(a=="ok"){ 
				     nui.get("excelData").setValue("");
		             nui.get("fileName").setValue("承销商信息.xls");
		             nui.get("type").setValue("1");
				     frm.action = "com.cjhxfund.ats.fm.baseinfo.debtIssueExport.flow";
					 frm.submit();
				  }   
				});
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
		        column = e.column,
		        row=e.row;
		        
		        field = e.field,
		        value = e.value;
		        if (field == "vcMainUnderwriter") {
		            e.cellStyle = "text-align:left";
					e.cellHtml = "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;' onclick='updateHisOne(\"" + grid.indexOf(row) + "\")'>"+value+"</a>&nbsp;";
					
		        }
        	});
        	
        //查看历史
	  function updateHisOne(id){
		//获取当前行
	    var index=parseInt(id);
	    var row=grid.getRow(index);
        if (row) {
	    	nui.open({
            url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueUnderwriterHis.jsp",
            title: "查看承销商修改历史信息", 
            width: 1200, 
   			height: 650,
            //allowResize:false,
            onload: function () {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.SetDataInit(row);
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
	//附件下载
    function fileDownload() {
        var datas = nui.get("file_grid").getSelecteds();
        var sysId = "";
        for (var i = 0; i < datas.length; i++) {
            if (sysId == "") {
                sysId = datas[i].lAttachId;
            } else {
                sysId = sysId + "," + datas[i].lAttachId;
            }
        }
        nui.get("sysid").setValue(sysId);
        if (datas != null && datas != "") {
            //给出提示并调用下载逻辑
            nui.confirm("确认要下载吗？", "系统提示",
            function(action) {
                if (action == "ok") {
                 var json = nui.encode({attachs:datas});
                   	nui.ajax({
						url:"com.cjhxfund.ats.fm.baseinfo.AttachManager.attachManage.biz.ext",
						type:'POST',
						data:json,
						cache:false,
						contentType:'text/json',		
						success:function(text){
		                    if(text.flag==false){
		                       nui.alert("下载失败，文件不存在！", "系统提示");
		                    }else{
		                         var form = document.getElementById("file_download");
                                 form.action = "com.cjhxfund.ats.fm.baseinfo.FileDownLoad.flow";
                                 form.submit();
                    		}
						}
				});	
                }
            });
        } else {
            nui.alert("请先选择下载附件", "系统提示");
        }
        
    }
   </script>
  </body>
</html>