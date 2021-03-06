<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2016-03-03 14:35:39
- Description: 综合信息查询（数据取自O32）
--%>
<head>
<title>综合信息查询</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>

</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div class="nui-tabs" id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">
		
		<%-- 业务类型标签页开始... --%>
		
		
		<div title="资金头寸">
		   <%-- 资金头寸查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_ZJTC" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="ZJTC">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="7%">
								基金名称:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vCFundCode_ZJTC" class="nui-buttonedit" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_ZJTC"/>
	                        </td>
	                        <td class="form_label" width="7%">
								资产单元:
	                        </td>
	                        <td colspan="1" width="20%">
	                            <input id="vCAssetName_ZJTC" class="nui-textbox" name="paramObject/vCAssetName"/>
	                        </td>
	                        <td colspan="1" width="118px">
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_ZJTC()"/>
	                            &nbsp;
	                            <input id="export_ZJTC" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_ZJTC()"/>
	                        </td>
	                        <td style="width:100px;" align="right">
	                        	<span class="warn_red_bold">数据每 5 分钟自动刷新</span>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 资金头寸查询条件结束!!! --%>
		  <%-- 资金头寸列表开始... --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_ZJTC"
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
                        <div field="L_DATE" headerAlign="center" allowSort="true" align="center" width="75px">
                            日期
                        </div>
                        <div field="VC_FUND_CODE" headerAlign="center" allowSort="true" align="center" width="75px">
                            基金代码
                        </div>
                        <div field="VC_FUND_NAME" headerAlign="center" allowSort="true" align="left" width="150px">
                            基金名称
                        </div>
                        <div field="VC_ASSET_NAME" headerAlign="center" allowSort="true" align="left" width="150px">
                            资产单元
                        </div>
                        <div field="T0ZLKY2" headerAlign="center" allowSort="true" align="right" width="150px">
			    不包含T+1变化的T+0可用
                        </div>
                        <div field="T0JYKY" headerAlign="center" allowSort="true" align="right" width="120px">
			  T+0交易可用
                        </div>
                        <div field="T1JYKY" headerAlign="center" allowSort="true" align="right" width="120px">
			  T+1交易可用
                        </div>
                        <div field="T0ZLKY" headerAlign="center" allowSort="true" align="right" width="120px">
			  T+0指令/建议可用
                        </div>
                        <div field="T1ZLKY" headerAlign="center" allowSort="true" align="right" width="120px">
			  T+1指令/建议可用
                        </div>
                        <div field="EN_BASIC_FROZEN_BALANCE" headerAlign="center" allowSort="true" align="right" width="120px">
                            交易保证金
                        </div>
                        <div field="EN_BEGIN_T0_ENABLE" headerAlign="center" allowSort="true" align="right" width="120px">
                            日初T+0可用金额
                        </div>
                        <div field="EN_BEGIN_T1_ENABLE" headerAlign="center" allowSort="true" align="right" width="120px">
                            日初T+1可用金额
                        </div>
                        <div field="EN_FUTURES_BALANCE" headerAlign="center" allowSort="true" align="right" width="120px">
                            期货保证金余额
                        </div>
                        <div field="EN_SETTLE_BALANCE" headerAlign="center" dataType="currency" allowSort="true" align="right" width="140px">
                            银行间入款未交收金额
                        </div>
                        <div field="EN_BALANCE_HGT" headerAlign="center" dataType="currency" allowSort="true" align="right" width="140px">
                           沪港通交易端可用金额
                        </div>
                        <div field="EN_BALANCE_INSTR_HGT" headerAlign="center" dataType="currency" allowSort="true" align="right" width="140px">
                            沪港通投资端可用金额
                        </div>
                        <div field="EN_BALANCE_SGT" headerAlign="center" dataType="currency" allowSort="true" align="right" width="140px">
                            深港通交易端可用金额
                        </div>
                        <div field="EN_BALANCE_INSTR_SGT" headerAlign="center" dataType="currency" allowSort="true" align="right" width="140px">
                            深港通投资端可用金额
                        </div>
                    </div>
                </div>
            </div>
            <%-- 资金头寸列表结束!!! --%>
		</div>
		
		<%-- 业务类型标签页结束!!! --%>
	</div>
</div>

<script type="text/javascript">
    nui.parse();
    var grid_ZJTC = nui.get("datagrid_ZJTC");//资金头寸
   
    var refreshInt = true;//刚刚打开页面时，投顾默认刷新，交易员默认不刷新
    var queryUserTypeTemp = "<%=request.getParameter("queryUserType")%>";
	if(queryUserTypeTemp!=null && queryUserTypeTemp!="" && queryUserTypeTemp!="null"){
		refreshInt = false;
	}
    
    
    //tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	function activechangedFun(){
		if(refreshInt==false){
			return;
		}
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tab").getActiveTab().title;
		if(activeTabTitle=="资金头寸"){
			search_ZJTC();
		}
	}
	
	//系统自动刷新页面--所有业务通用
    function autoRefreshFun(){
    	refreshInt = true;//打开页面之后设置值为true
    	activechangedFun();//同时刷新查询列表数据
    }
    self.setInterval("autoRefreshFun()",60000*5);//设置自动刷新时间默认5分钟
	
    
    
    
    <%-- 资金头寸查询开始... --%>
	//查询
	function search_ZJTC() {
		search(grid_ZJTC, "#form_ZJTC");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_ZJTC(e){
        ButtonClickGetFundName(this, null);
	}
	//导出
	function export_ZJTC(){
		exportSubmit("export_ZJTC", "form_ZJTC", nui.get("tab").getActiveTab().title);
	}
	<%-- 资金头寸查询结束!!! --%>
	
</script>
</body>
</html>