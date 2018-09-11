<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-05-22 19:09:46
  - Description:
-->
<head>
<title>查询指令/建议--大宗交易</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
	<script src="<%= request.getContextPath() %>/ProductProcess/CFJYProductProcessList_queryConfirm.js" type="text/javascript"></script>
</head>
<body style="margin: 0px;padding: 0px;overflow: hidden;width: 100%;height: 100%;" onload="onloadFun()">
	<div activeIndex="0" id="tab" style="width:100%;height:100%;" onactivechanged="activechangedFun">
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
		                        <td style="width:80px" align="right">
									业务日期:
		                        </td>
		                        <td style="width:25%" align="left">
		                            <input id="processDate_dzjy_begin" name="criteria/_expr[2]/processDate" class="nui-datepicker" width="110px"/>
		                            <input class="nui-hidden" type="hidden" name="criteria/_expr[2]/_op" value=">=">
							 		- 
							 		<input id="processDate_dzjy_end" name="criteria/_expr[5]/processDate" class="nui-datepicker" width="110px"/>
							 		<input class="nui-hidden" type="hidden" name="criteria/_expr[5]/_op" value="<="/>
		                        </td>
		                        <td style="width:80px" align="right">
									产品名称:
		                        </td>
		                        <td style="width:25%" align="left">
		                            <input class="nui-buttonedit" width="100%" name="criteria/_expr[3]/combProductCode" onbuttonclick="ButtonClickGetFundNameCommon"/>
		                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="in">
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
                        <td>
                            <a id="confirm_DZJY" class='nui-button' plain='false' iconCls="icon-ok" onclick="confirm_DZJY()">
									确认
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
	<script type="text/javascript">
    	nui.parse();
    	
    	//初始化查询条件业务日期值为当天
	    var date = new Date();
    	nui.get("processDate_dzjy_begin").setValue(date);
    	nui.get("processDate_dzjy_end").setValue(date);
    	
    	<%-- 大宗交易业务 --%>
	    var grid_DZJY = nui.get("datagrid_DZJY");
	    var formData_DZJY = new nui.Form("#form_DZJY").getData(false,false);
        // 获取页签栏条数
        parent.updateTab();
	    grid_DZJY.load(formData_DZJY);
	    //行双击时弹出页面展示该指令/建议详细信息
	    grid_DZJY.on("rowdblclick", function (e) {
	    	rowdblclickFun("JY_DZJY/CFJYProductProcessForm_detailOperator_show_DZJY.jsp", "大宗交易明细展示", 600, 387, e, grid_DZJY, "JY_DZJY/CFJYProductProcessForm_DZJY.jsp");
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
		                	parent.updateTab();
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
		                		parent.updateTab();
		                		grid_confirm.reload();
		                	}
				        }
		            });
				}
	        }
	    }
	    
	    //全屏显示
		function fullScreen(){
			window.open('<%=request.getContextPath()%>/ProductProcess/JY_DZJY/CFJYProductProcessList__queryConfirm_DZJY.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		}
		
		//“今日待处理”模块自动刷新功能处理
	    var autoRefreshValOld = nui.get("autoRefresh").getValue();//获取默认自动刷新时间
	    var autoRefreshReturnVal= self.setInterval("autoRefreshFun()",eval(autoRefreshValOld)*1000);//设置自动刷新时间默认3分钟
	    function autoRefreshFun(){
	    	search_DZJY(); //同时刷新查询列表数据
			
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