<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%
	String preDate = DateUtil.getCalculateTradeDay(null, DateUtil.currentDateString(DateUtil.YMD_NUMBER), null, -1);
%>
<!-- 
  - Author(s): heyi
  - Date: 2017-03-07 09:42:27
  - Description: 备付金保证金预估查询
-->
<head>
<title>备付金保证金信息查询</title>
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div class="nui-tabs" id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">
		
	<div title="备付金">
		   <%--备付金查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_BFJ" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="BFJ">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                		<td class="form_label" width="100%">
								日期:
	                        	从<input id="lDateBegin_BFJ" class="nui-datepicker" name="paramObject/lDateBegin" width="100px" required="false"/>
								到<input id="lDateEnd_BFJ" class="nui-datepicker" name="paramObject/lDateEnd" width="100px" required="false"/>
								&nbsp;&nbsp;&nbsp;
								基金名称:
	                            <input id="vcFundCode_BFJ" class="nui-buttonedit" name="paramObject/vcFundCode" width="250px" onbuttonclick="ButtonClickGetFundName_BFJ"/>
								&nbsp;&nbsp;&nbsp;
								业务类型名称:
	                            <input id="vcFundCode_BFJ" class="nui-textbox" name="paramObject/vcBusinFlag" />
	                        	&nbsp;&nbsp;&nbsp;
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_BFJ()"/>
	                        	<input class='nui-button' plain='false' text="重置" iconCls="icon-cancel"  onclick="resetDire_BFJ()"/>
	                            <input id="export_BFJ" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_BFJ()"/>
	                            <input class='nui-button' plain='false' text="帮助" iconCls="icon-help" onclick="help_BFJ()" tooltip="帮助"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%--备付金查询条件结束!!! --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_BFJ"
                        dataField="resultObjectList"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryZHXX.biz.ext"
                        pageSize="50"
                        showPageInfo="true"
                        allowSortColumn="true"
                        sortMode="client"
                        enableHotTrack="true"
                        sizeList="[10,20,50,100]">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div field="L_DATE" renderer="dateRen" headerAlign="center" allowSort="true" align="center" width="80px">
                            日期
                        </div>
                        <div field="VC_FUND_CODE" headerAlign="center" allowSort="true" align="left" width="80px">
                            基金代码
                        </div>
                        <div field="VC_FUND_NAME" headerAlign="center" allowSort="true" align="left" width="150px">
                            基金名称
                        </div>
                        <div field="VC_ASSET_NAME" headerAlign="center" allowSort="true" align="left" width="130px">
                            资产单元名称
                        </div>
                        <div field="VC_BUSIN_FLAG" headerAlign="center" allowSort="true" align="left" width="80px">
                           业务类型
                        </div>
                        <div field="EN_DEAL_BALANCE" headerAlign="center" allowSort="true" align="right" width="120px">
                           成交金额
                        </div>
                        <div field="EN_BFJ_LASTDAY" headerAlign="center" allowSort="true"  align="right" width="120px">
                           预测备付金
                        </div>
                        <div field="EN_BFJ_LASTMON" headerAlign="center" allowSort="true"  align="right" width="120px">
                           月初存出备付金
                        </div>
                        <div field="EN_BFJ_GAP" headerAlign="center" allowSort="true"  align="right" width="120px">
                           预测调整金额
                        </div>
                        <div field="EN_BFJ_PREDICT" headerAlign="center" allowSort="true"  align="right" width="120px">
                           月初需冻结金额
                        </div>
                        <div field="C_GROUP_FLAG" headerAlign="center" allowSort="true"  align="center" width="80px">
                           是否分组估值
                        </div>
                        <div field="ASSET_FLAG" headerAlign="center" allowSort="true"  align="center" width="80px">
                           是否分资产单元
                        </div>
                        <div field="L_FUND_ID" headerAlign="center" allowSort="true" align="left" width="60px">
                           基金序号
                        </div>
                        <div field="L_ASSET_ID" headerAlign="center" allowSort="true"  align="left" width="60px">
                           资产单元序号
                        </div>
                    </div>
                </div>
            </div>
		</div>
		
		<div title="保证金">
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_BZJ" method="post">
				 <%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="BZJ">
	               <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                		<td class="form_label" width="7%">
								日期:
	                        	从<input id="lDateBegin_BZJ" class="nui-datepicker" name="paramObject/lDateBegin" width="100px" required="false"/>
								到<input id="lDateEnd_BZJ" class="nui-datepicker" name="paramObject/lDateEnd" width="100px" required="false"/>
								&nbsp;&nbsp;&nbsp;
								基金名称:
	                            <input id="vcFundCode_BZJ" class="nui-buttonedit" name="paramObject/vcFundCode" width="250px" onbuttonclick="ButtonClickGetFundName_BZJ"/>
	                        	&nbsp;&nbsp;&nbsp;
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_BZJ()"/>
	                        	<input class='nui-button' plain='false' text="重置" iconCls="icon-cancel"  onclick="resetDire_BZJ()"/>
	                            <input id="export_BZJ" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_BZJ()"/>
	                            <input class='nui-button' plain='false' text="帮助" iconCls="icon-help" onclick="help_BZJ()" tooltip="帮助"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 保证金查询条件结束!!! --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_BZJ"
                        dataField="resultObjectList"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryZHXX.biz.ext"
                        pageSize="50"
                        showPageInfo="true"
                        allowSortColumn="true"
                        sortMode="client"
                        enableHotTrack="true"
                        sizeList="[10,20,50,100]">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div field="L_DATE" renderer="dateRen" headerAlign="center" allowSort="true" align="center" width="80px">
                            日期
                        </div>
                        <div field="VC_FUND_CODE" headerAlign="center" allowSort="true" align="left" width="80px">
                            基金代码
                        </div>
                        <div field="VC_FUND_NAME" headerAlign="center" allowSort="true" align="left" width="150px">
                            基金名称
                        </div>
                        <div field="VC_ASSET_NAME" headerAlign="center" allowSort="true" align="left" width="130px">
                            资产单元名称
                        </div>
                        <div field="VC_SEQUARE_CODE" headerAlign="center" allowSort="true" align="left" width="80px">
                           结算参与人代码
                        </div>
                        <div field="CURRENT_BZJ" headerAlign="center" allowSort="true"  align="right" width="130px">
                           预测保证金
                        </div>
                       	<div field="MONTH_BEGIN_BZJ" headerAlign="center" allowSort="true"  align="right" width="130px">
                           月初存出保证金
                        </div>
                       	<div field="MARGIN_BZJ" headerAlign="center" allowSort="true"  align="right" width="130px">
                           预测需调整金额
                        </div>
                       	<div field="PREDICT_BZJ" headerAlign="center" allowSort="true"  align="right" width="130px">
                           下月需冻结保证金
                        </div>
                       	<div field="" headerAlign="center" allowSort="true"  align="right" width="130px">
                          预测备付金加保证金金额
                        </div>
                        <div field="L_FUND_ID" headerAlign="center" allowSort="true" align="left" width="60px">
                          基金序号
                        </div>
                        <div field="L_DEFAULT_ASSET" headerAlign="center" allowSort="true" align="left" width="60px">
                          资产单元序号
                        </div>
                    </div>
                </div>
            </div>
		</div>
	</div>
</div>
	<script type="text/javascript">
	nui.parse();
    var grid_BFJ = nui.get("datagrid_BFJ");//备付金
    var grid_BZJ = nui.get("datagrid_BZJ");//保证金
    
	var refreshInt = false;
	
	//第一次进入页面，查询权限是否是投顾
	nui.ajax({
		url : "com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.getUserType.biz.ext",
		type : 'POST',
		data : {},
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			if(null !=text.userType){//投顾
				refreshInt = true;
				}
			}
		});

    //tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	function activechangedFun(){
		if(refreshInt==false){
			return;
		}
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tab").getActiveTab().title;
		if(activeTabTitle=="保证金"){
			//首次打开页面，展示说明
			refresh();
			search_BZJ();
		}else if(activeTabTitle=="备付金"){
		    //获取权限
			search_BFJ();
		}
	}
    
    //首次打开页面，展示说明
    var refreshHelp = true;
    function refresh(){
	    if(refreshHelp == false){
	    	return;
	    }
		help_BZJ();
		refreshHelp = false;
    }
    //设置默认时间
	var preDate = "<%=preDate%>";
		nui.get("lDateBegin_BFJ").setValue(preDate);
		nui.get("lDateEnd_BFJ").setValue(preDate);
		nui.get("lDateBegin_BZJ").setValue(preDate);
		nui.get("lDateEnd_BZJ").setValue(preDate);
    
    <%-- 备付金查询条件 --%>	
    //备付金查询
	function search_BFJ(){
		search(grid_BFJ, "#form_BFJ");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_BFJ(e){
        ButtonClickGetFundName(this);
	}
	//导出
	function export_BFJ(){
		exportSubmit("export_BFJ", "form_BFJ", nui.get("tab").getActiveTab().title);
	}
	//表格行增加样式
	grid_BFJ.on("drawcell", function(e){
    	var record = e.record;
    	var EN_BFJ_GAP = parseInt(record.EN_BFJ_GAP);
    	var EN_BFJ_PREDICT = parseInt(record.EN_BFJ_PREDICT);
		//正直标红
		if(EN_BFJ_GAP > 0 || EN_BFJ_PREDICT > 0){
			e.rowCls = "warn_red";
		}
		
	});
	//重置指令/建议信息
	function resetDire_BFJ(){
		var form = new nui.Form("form_BFJ");
		form.reset();
	}
	
	
	function help_BFJ() {
		var url = "<%= request.getContextPath() %>/ProductProcess/BZJBFJ/BFJexplain.jsp";
		var title = "备付金相关说明";
		var width = "650";
		var height = "400";
		nui.open({
			url: url,
			title:title,width: width, height: height,
		});
	}
	
	<%-- 保证金查询 --%>
    //保证金查询
	function search_BZJ(){
		search(grid_BZJ, "#form_BZJ");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_BZJ(e){
        ButtonClickGetFundName(this);
	}
	//导出
	function export_BZJ(){
		exportSubmit("export_BZJ", "form_BZJ", nui.get("tab").getActiveTab().title);
	}
	//表格行增加样式
	grid_BZJ.on("drawcell", function(e){
    	var record = e.record;
    	var MARGIN_BZJ = parseInt(record.MARGIN_BZJ);
    	var PREDICT_BZJ = parseInt(record.PREDICT_BZJ);
		//正直标红
		if(MARGIN_BZJ > 0 || PREDICT_BZJ > 0){
			e.rowCls = "warn_red";
		}

	});
	//行双击时弹出页面展示银行间回购明细表
    grid_BZJ.on("rowdblclick", function(e){
    	rowdblclickFunBZJ("BZJ_detail.jsp", "保证金明细", 710, 300, e, grid_BZJ);
    	
    });
    
    function rowdblclickFunBZJ(jspUrl, title, width, height, e, grid) {
    var row = e.record;//行对象值
    if (row) {
    	nui.open({
            url: "<%=request.getContextPath()%>/ProductProcess/BZJBFJ/"+jspUrl+"?queryUserType=<%=request.getParameter("queryUserType")%>",
            title: title,
            width: width,
            height: height,
            onload: function () {
                var iframe = this.getIFrameEl();
                var data = {record:{rowRecord:row}};
                //直接从页面获取，不用去后台获取
                iframe.contentWindow.setFormData(data);
            },
            ondestroy: function (action) {//弹出页面关闭前
	        }
        });
    }
    }
    
    //重置指令/建议信息
	function resetDire_BZJ(){
		var form = new nui.Form("form_BZJ");
		form.reset();
	}

	function help_BZJ() {
		var url = "<%= request.getContextPath() %>/ProductProcess/BZJBFJ/BZJexplain.jsp";
		var title = "保证金相关说明";
		var width = "650";
		var height = "400";
		nui.open({
			url: url,
			title:title,width: width, height: height,
		});
	}
			
    </script>
</body>
</html>