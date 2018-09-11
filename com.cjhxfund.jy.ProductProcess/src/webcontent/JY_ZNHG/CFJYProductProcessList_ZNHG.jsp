<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/JY_ZNHG/JY_ZNHG_common.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-05-18 14:11:41
  - Description:
-->
<head>
	<title>正逆回购</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
	<script src="<%= request.getContextPath() %>/ProductProcess/CFJYProductProcessList_common.js" type="text/javascript"></script>
	
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">

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
		                        <td style="width:28%" align="left">
		                            <input id="processDate_znhg_begin" name="criteria/_expr[2]/processDate" class="nui-datepicker" width="100px"/>
		                            <input class="nui-hidden" type="hidden" name="criteria/_expr[2]/_op" value=">=">
							 		- 
							 		<input id="processDate_znhg_end" name="criteria/_expr[6]/processDate" class="nui-datepicker" width="100px"/>
							 		<input class="nui-hidden" type="hidden" name="criteria/_expr[6]/_op" value="<="/>
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
		   
		   <%-- 正逆回购指令单列表开始... --%>
           <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td>
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
	                        &nbsp;
	                        <a id="goBack_ZNHG" class='nui-button' plain='false' iconCls="icon-no" onclick="goBack_ZNHG()">
								退回
	                        </a>
                        </td>
                        <td align="right">
	                        <%-- 点击“刷新”按钮后重启自动刷新功能（若之前自动刷新功能设置为不自动刷新关闭时） --%>
		                    <a class='nui-button' plain='false' iconCls="icon-reload" onclick="autoRefreshFun()">刷新</a>
		                    <input id="autoRefresh" class="nui-combobox" style="width:90px;" textField="text" valueField="id" url="<%= request.getContextPath() %>/ProductProcess/AutoRefreshData.txt" value="180" showNullItem="false" allowInput="false"/>
		                    &nbsp;
	        				<a href="javascript:fullScreen()"><span class="warn_red_bold" style="border-bottom:1px solid;font-size:13px;">全屏显示</span></a>
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
            <%-- 正逆回购指令单列表结束!!! --%>
		</div>
	</div>

	<script type="text/javascript">
    	nui.parse();
	    //初始化查询条件业务日期值为当天
	    var date = new Date();
		nui.get("processDate_znhg_begin").setValue(date);
		nui.get("processDate_znhg_end").setValue(date);
	    
	   <%-- 正逆回购业务 --%>
		var grid_ZNHG = nui.get("datagrid_ZNHG");
	    var formData_ZNHG = new nui.Form("#form_ZNHG").getData(false,false);
	    grid_ZNHG.load(formData_ZNHG);
	    
	    //表格行增加背景色
	    grid_ZNHG.on("drawcell", function (e) {
	    	var record = e.record;
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
					
					//若当前用户有权限处理该指令单，则该指令单使用特定背景色显示
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
					// 投资经理权限
					var userIdRelaType02 = record.userIdRelaType02;//该指令/建议单拥有投资经理下单权限的用户ID字符串
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
					if(hasPermission==true){
						e.rowCls = "processStatus_wait_confirm";
					}
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
	    grid_ZNHG.on("rowdblclick", function (e) {
	    	rowdblclickFun_common_ZNHG("JY_ZNHG/CFJYProductProcessForm_detailOperator_show_ZNHG.jsp", "正逆回购明细展示", 800, 600, e, grid_ZNHG, "query", "TG");
	    });
	    //新增
	    function add_ZNHG() {
	    	add("JY_ZNHG/CFJYProductProcessForm_ZNHG.jsp", "正逆回购新增记录", 800, 600, grid_ZNHG);
	    }
	    //编辑
	    function edit_ZNHG() {
	    	edit_common_ZNHG("JY_ZNHG/CFJYProductProcessForm_ZNHG.jsp", "正逆回购编辑数据", 800, 600, grid_ZNHG,"edit", "TG");
	    }
	    //废弃
		function remove_ZNHG(){
			remove_common_ZNHG(grid_ZNHG);
		}
		//确认
		function confirm_ZNHG(){
			//确认--所有业务通用(确认页面)
		    var rows = grid_ZNHG.getSelecteds();
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
		        	
		        	var jsonStatus = nui.encode({zhfwptjyznhg:{processId:rows[0].processId}});
		        	$.ajax({
		                url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG.getProcessStatus_ZNHG.biz.ext",
		                type:'POST',
		                data:jsonStatus,
		                cache:false,
		                contentType:'text/json',
		                success:function(text){
		                    var returnJsonStatus = nui.decode(text);
		                	var record = rows[0];//产品记录
		                    //“投资经理下单确认”、“交易员填单确认”、“交易已发送”阶段投顾可以修改，修改之后投资经理下单、交易员填单、交易已发送需要重新确认；
				        	//“前台已成交”阶段投顾可以将指令/建议单废弃，系统在备注记录废弃原因、时间等信息，“后台已成交”阶段单子不能做任何修改废弃；
				        	//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
				        	var processStatus = returnJsonStatus.processStatus;
				        	var userIdRelaType07All = record.userIdRelaType07All!=null?record.userIdRelaType07All:"";//07-产品与投顾确认权限(全部人员)
        					var userIdRelaType07 = record.userIdRelaType07!=null?record.userIdRelaType07:"";//07-产品与投顾确认权限(过滤自己)
							var userIdRelaTypeA1 = record.userIdRelaTypeA1!=null?record.userIdRelaTypeA1:"";//A1-投顾录入确认可为同一人员
			        		// 指令还未下达
			        		if(processStatus=="-2"){
			        			nui.alert("该指令/建议尚未下达，您还不能处理","提示");
			        			return;
			        			
			        		//投顾确认	
			        		}else if(processStatus=="-1" || processStatus=="0"){
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
								}
								if(hasPermission == false){
									nui.alert("您没有权限确认该指令/建议","提示");
									return;
								}
				        	
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
				        	}else{
				        		nui.alert("您没有权限确认该指令/建议","提示");
		    					return;
				        	}
				        	
				        	
				        	var msg = "";
				        	if(processStatus=="-2" || processStatus=="-1" || processStatus=="0"){
				        		msg = "该指令/建议现为指令录入完成阶段，确定要继续确认吗？";
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
					            	var jsonValidStatus = nui.encode({zhfwptjyznhg:{processId:rows[0].processId}});
								  	$.ajax({
								          url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG.getValidStatus_ZNHG.biz.ext",
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
								                    var json = nui.encode({zhfwptjyznhgs:[{processId:rows[0].processId, processStatus:processStatus}]});
									                grid_ZNHG.loading("正在确认中,请稍等...");
									                $.ajax({
									                    url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_confirm.biz.ext",
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
									                        	var invalidFixStr = returnJson.invalidFixStr;//无效指令/建议单字符串（Fix错误信息）
									                        	var validFixFailReason = returnJson.validFixFailReason;//有效指令/建议单字符串（反馈报文失败原因[警告信息等]）
									                        	
									                        	var msg = "";
									                        	var failReasonMsg = "";
									                        	var errorMsg = "";
									                        	if(validCount!=null && validCount!="" && validCount!="0"){
									                        		if(validFixFailReason!=null && validFixFailReason!=""){
									                        			var tempValidStrArr = validStr.split(",");
										                        		var tempValidFixFailReasonArr = validFixFailReason.split("★");
										                        		for(var i=0; i<tempValidStrArr.length; i++){
										                        			failReasonMsg += "【"+tempValidStrArr[i]+"触发以下风控：</br>"+tempValidFixFailReasonArr[i]+"】</br>";
										                        		}
										                        		if(failReasonMsg!=null && (failReasonMsg.indexOf("申请指令/建议审批")!=-1 || failReasonMsg.indexOf("申请风险阀值")!=-1)){
										                        			failReasonMsg += "<span class='warn_red_bold'>请联系人工审批！</span></br>";
										                        		}
									                        		}
									                        		msg += "确认成功 " + validCount + " 条</br>"+failReasonMsg;
									                        	}
									                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
									                        		var tempInvalidStrArr = invalidStr.split(",");
									                        		var tempInvalidFixStrArr = invalidFixStr.split("★");
									                        		for(var i=0; i<tempInvalidStrArr.length; i++){
									                        			errorMsg += "【"+tempInvalidStrArr[i]+"-"+tempInvalidFixStrArr[i]+"】</br>";
									                        		}
									                        		msg += "确认失败 " + invalidCount + " 条</br>"+errorMsg;
									                        	}
									                            grid_ZNHG.reload();
									                            nui.alert(msg, "系统提示", function(action){
									                            });
									                        }else{
								                                grid_ZNHG.unmask();
								                                nui.alert("确认失败", "系统提示");
									                        }
									                    }
									                });
								              }else if(returnValidStatus=="3"){
								              	  grid_ZNHG.reload();
												  nui.alert("该指令/建议已退回，您不能再确认","提示");
												  return;
								              }else{
								              	  grid_ZNHG.reload();
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
				        var userIdRelaType07All = record.userIdRelaType07All!=null?record.userIdRelaType07All:"";//07-产品与投顾确认权限(全部人员)
        				var userIdRelaType07 = record.userIdRelaType07!=null?record.userIdRelaType07:"";//07-产品与投顾确认权限(过滤自己)
						var userIdRelaTypeA1 = record.userIdRelaTypeA1!=null?record.userIdRelaTypeA1:"";//A1-投顾录入确认可为同一人员
			        	//录入尚未确认
			        	if(processStatus=="-2"){
			        		nui.alert("该指令/建议尚未下达，您还不能处理","提示");
			        		return;
			        	}else if(processStatus=="-1" || processStatus=="0"){
			        		//投顾确认	
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
							if(hasPermission!=true){
								noPermissionStr += "、" + investProductNum + "-" + combProductName;
							}
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
							
			        	}else{
			        		permissionStr += "、" + investProductNum + "-" + combProductName;
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
			                var json = nui.encode({zhfwptjyznhgs: processIdArr});
			                grid_ZNHG.loading("正在确认中,请稍等...");
			                $.ajax({
			                    url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_confirm.biz.ext",
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
			                        	var invalidFixStr = returnJson.invalidFixStr;//无效指令/建议单字符串（Fix错误信息）
			                        	var validFixFailReason = returnJson.validFixFailReason;//有效指令/建议单字符串（反馈报文失败原因[警告信息等]）
			                        	
			                        	var msg = "";
			                        	var failReasonMsg = "";
			                        	var errorMsg = "";
			                        	if(validCount!=null && validCount!="" && validCount!="0"){
			                        		if(validFixFailReason!=null && validFixFailReason!=""){
			                        			var tempValidStrArr = validStr.split(",");
				                        		var tempValidFixFailReasonArr = validFixFailReason.split("★");
				                        		for(var i=0; i<tempValidStrArr.length; i++){
				                        			failReasonMsg += "【"+tempValidStrArr[i]+"触发以下风控：</br>"+tempValidFixFailReasonArr[i]+"】</br>";
				                        		}
				                        		if(failReasonMsg!=null && (failReasonMsg.indexOf("申请指令/建议审批")!=-1 || failReasonMsg.indexOf("申请风险阀值")!=-1)){
				                        			failReasonMsg += "<span class='warn_red_bold'>请联系人工审批！</span></br>";
				                        		}
			                        		}
			                        		msg += "确认成功 " + validCount + " 条</br>"+failReasonMsg;
			                        	}
			                        	if(invalidCount!=null && invalidCount!="" && invalidCount!="0"){
			                        		var tempInvalidStrArr = invalidStr.split(",");
			                        		var tempInvalidFixStrArr = invalidFixStr.split("★");
			                        		for(var i=0; i<tempInvalidStrArr.length; i++){
			                        			errorMsg += "【"+tempInvalidStrArr[i]+"-"+tempInvalidFixStrArr[i]+"】</br>";
			                        		}
			                        		msg += "确认失败 " + invalidCount + " 条</br>"+errorMsg;
			                        	}
			                            grid_ZNHG.reload();
			                            nui.alert(msg, "系统提示", function(action){
			                            });
			                        }else{
			                            grid_ZNHG.unmask();
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
	    
	    //全屏显示
		function fullScreen(){
			window.open('<%=request.getContextPath()%>/ProductProcess/JY_ZNHG/CFJYProductProcessList_ZNHG.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		}
	    
		//退回
		function goBack_ZNHG(){
			goBack_common_confirm_ZNHG(grid_ZNHG);
		}
		
		//自动刷新功能处理
    	var autoRefreshValOld = nui.get("autoRefresh").getValue();//获取默认自动刷新时间
	    var autoRefreshReturnVal= self.setInterval("autoRefreshFun()",eval(autoRefreshValOld)*1000);//设置自动刷新时间默认3分钟
	    function autoRefreshFun(){
	    
	    	search_ZNHG(); //同时刷新查询列表数据
			
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
    </script>
</body>
</html>