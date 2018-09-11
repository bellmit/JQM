<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-05-18 14:11:41
  - Description:
-->
<head>
	<title>投票</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
	<script src="<%= request.getContextPath() %>/ProductProcess/CFJYProductProcessList_common.js" type="text/javascript"></script>
	
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">
		<!-- <div title="投票"> -->
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
		                        <td style="width:80px" align="right">
									业务日期:
		                        </td>
		                        <td style="width:28%" align="left">
		                            <input id="processDate_tp_begin" name="criteria/_expr[2]/processDate" class="nui-datepicker" width="100px"/>
		                            <input class="nui-hidden" type="hidden" name="criteria/_expr[2]/_op" value=">=">
							 		- 
							 		<input id="processDate_tp_end" name="criteria/_expr[5]/processDate" class="nui-datepicker" width="100px"/>
							 		<input class="nui-hidden" type="hidden" name="criteria/_expr[5]/_op" value="<="/>
		                        </td>
		                        <td style="width:80px" align="right">
									产品名称:
		                        </td>
		                        <td style="width:25%" align="left">
		                            <input class="nui-textbox" width="100%" name="criteria/_expr[3]/combProductName"/>
		                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="like">
		                            <input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
		                        </td>
								<td style="width:80px" align="right">
									交易状态:
		                        </td>
		                        <td style="width:25%" align="left">
									<input class="nui-dictcombobox" width="100%" name="criteria/_expr[4]/validStatus" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_VALID_STATUS"  
										emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
									<input class="nui-hidden" name="criteria/_expr[4]/_op" value="in"/>
								</td>
		                        <td colspan="1" width="25%">
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
                        <td>
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
		                    &nbsp;
		                    <a id="goBack_TP" class='nui-button' plain='false' iconCls="icon-no" onclick="goBack_TP()">
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
	</div>
<!-- </div>  -->

	<script type="text/javascript">
    	nui.parse();
	    //初始化查询条件业务日期值为当天
	    var date = new Date();
		nui.get("processDate_tp_begin").setValue(date);
		nui.get("processDate_tp_end").setValue(date);
	    
	    <%-- 投票业务 --%>
	    var grid_TP = nui.get("datagrid_TP");
	    var formData_TP = new nui.Form("#form_TP").getData(false,false);
	    grid_TP.load(formData_TP);
	    
	    //表格行增加背景色
	    grid_TP.on("drawcell", function (e) {
	    	drawcellFun(e);
	    });
	    //行双击时弹出页面展示该指令/建议详细信息
	    grid_TP.on("rowdblclick", function (e) {
	    	rowdblclickFun("JY_TP/CFJYProductProcessForm_detailOperator_show_TP.jsp", "投票明细展示", 820, 613, e, grid_TP);
	    });
	    //新增
	    function add_TP(){
	      add("JY_TP/CFJYProductProcessForm_TP.jsp", "投票新增记录", 820, 583, grid_TP);
	    }
	    //编辑
		function edit_TP(){
		   edit("JY_TP/CFJYProductProcessForm_TP.jsp", "投票编辑数据", 820, 583, grid_TP);
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
		    var resultStatus = "";
		    
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
	    		
	    		// 权限验证
	    		for(var i=0; i<rows.length; i++){
	    			var record = rows[i];//产品记录
		        	var processStatus = record.processStatus;//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
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
		        		var processId = record.processId;
		        		nui.ajax({
		        			url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductProcessHandleByProcessId.biz.ext",
			                type:'POST',
			                data:{processId:processId},
			                async:false, 
			                cache:false,
			                contentType:'text/json',
			                success:function(text){
				        		//若当前用户有权限处理该指令/建议单，则继续执行，否则终止并提示
				        		var hasPermission = false;//是否有权限，默认无
				        		var resultData = nui.decode(text);
				        		if(resultData.exception == null){
				                    if(resultData.users.length>0){
				                    	for(var i=0; i<resultData.users.length; i++){
				                    		userIdRelaType02Arr = resultData.users[i].userIdRelaType02.split(",");
				                    		for(var i=0; i<userIdRelaType02Arr.length; i++){
												var userIdTemp = userIdRelaType02Arr[i];
												if(userIdTemp==userId){
													hasPermission = true;
													break;
												}
											}
				                    	}
				                    }
									if(hasPermission==false){
										resultStatus="1";
										nui.alert("您没有权限确认该指令/建议","提示");
			    						return;
									}
				        		}else{
				        			nui.alert("系统异常","提示");
			    					return;
				        		}
			                }
			                    
		        		});
					
					}else{
						nui.alert("您没有权限确认该指令/建议","提示");
    					return;
					}
	    		}
	    		//权限验证结束!!!
	    		if(resultStatus == "1"){
	    			return;
	    		}
	    		
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
	    
	    //全屏显示
		function fullScreen(){
			window.open('<%=request.getContextPath()%>/ProductProcess/JY_TP/CFJYProductProcessList_TP.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		}
	    
		//退回
		function goBack_TP(){
			goBack(grid_TP);
		} 
		
		//“今日待处理”模块自动刷新功能处理
	    var autoRefreshValOld = nui.get("autoRefresh").getValue();//获取默认自动刷新时间
	    var autoRefreshReturnVal= self.setInterval("autoRefreshFun()",eval(autoRefreshValOld)*1000);//设置自动刷新时间默认3分钟
	    function autoRefreshFun(){
	    	search_TP(); //同时刷新查询列表数据
			
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