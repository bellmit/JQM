<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): 吴艳飞
- Date: 2016-12-21 16:35:39
- Description: 分销数据列表
--%>
<head>
<title>上清-分销</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
  <div class="search-condition">
	 <div class="list">
		<form id="form_FXSJLB" method="post" >
			<%-- 查询类型 --%>
			<input class="nui-hidden" name="paramObject/queryType" value="FXSJLB">
			
			<table id="table1" class="table" style="height:100%;table-layout:fixed;">
				<tr>
					<td  width="90px" align="right">
					证券简称:
					</td>
					<td>
						<input id="vcStocknm_FXSJLB" class="nui-textbox"  name="paramObject/vcStocknm"  style="width:80%"/>
					</td>
					<td width="90px" align="right">
					交易状态:
					</td>
					<td>
						<input id="vcTradests_FXSJLB" class="nui-textbox"  name="paramObject/vcTradests" style="width:80%"/>
					</td>
					<td width="90px" align="right">
					卖方状态:
					</td>
					<td >
						<input id="vcSellersts_FXSJLB" class="nui-textbox" name="paramObject/vcSellersts" style="width:80%"/>
					</td>
				</tr>	
				<tr>
					<td width="80px" align="right">
					买方状态:
					</td>
					<td >
						<input id="vcBuyersts_FXSJLB" class="nui-textbox"  name="paramObject/vcBuyersts" style="width:80%"/>
					</td>
					<td align="right">
					卖方持有人简称:
					</td>
					<td >
						<input id="vcSellernm_FXSJLB" class="nui-textbox"  name="paramObject/vcSellernm" style="width:80%"/>
					</td>
					<td align="right">
					买方持有人简称:
					</td>
					<td >
						<input id="vcBuyernm_FXSJLB" class="nui-textbox" name="paramObject/vcBuyernm" style="width:80%"/>
					</td>
				</tr>
				<tr>
					<td  align="right">
					结算日期:
					</td>
					<td >
						<input id="vcSttlmdt_FXSJLB" class="nui-datepicker" allowInput="false" name="paramObject/vcSttlmdt" style="width:80%"/>
					</td>
					<td align="right">
					成交日期:
					</td>
					<td >
						<input id="vcTxdt_FXSJLB" class="nui-datepicker"  allowInput="false"  name="paramObject/vcTxdt" style="width:80%"/>
					</td>
					<td align="right">
							数据日期:
					</td>
					<td>
						<input id="lUpdatedt_MDSHGLB" class="nui-datepicker" allowInput="false"  name="paramObject/lUpdatedt"  value="new Date()" style="width:80%"/>
					</td>
				</tr>
			</table>
		</form>
	  </div>
	</div>	
	<%-- 刷新功能 --%>
	<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	    <table style="width:100%;">
	        <tr>
	            <td width="80px" align="left">
						<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_FXSJLB()"/>
				</td>
	            <td style="width:50%;" align="right">
	            	<%-- 点击“刷新”按钮后重启自动刷新功能（若之前自动刷新功能设置为不自动刷新关闭时） --%>
	                    <a class='nui-button' plain='false' iconCls="icon-reload" onclick="autoRefreshFun()">刷新</a>
	                    <input id="autoRefresh" class="nui-combobox" style="width:90px;" textField="text" valueField="id" url="<%= request.getContextPath() %>/ProductProcess/AutoRefreshData.txt" value="180" showNullItem="false" allowInput="false"/>
	            </td>
	        </tr>
	    </table>
    </div>	
	<%-- 分销数据列表开始!!! --%> 	
	<div class="nui-fit">
		<div 
		    id="datagrid_FXSJLB"
			dataField="resultObjectList"
			class="nui-datagrid"
			style="width:100%;height:100%;"
 			url="com.cjhxfund.ats.sm.comm.BackStageTrader.querySQZZCJCX.biz.ext"
			pageSize="20"
			frozenStartColumn="0"
			frozenEndColumn="2"
			showPageInfo="true"
			allowSortColumn="true"
			sortMode="client"
			enableHotTrack="true"
			allowHeaderWrap="true"
			sizeList="[10,20,50,100]"
			allowCellEdit="true"
			allowCellSelect="true"
			enterNextCell="true"
			allowMoveColumn="true"
			editNextOnEnterKey="true" resultAsTree="false" 
			allowResize="true" expandOnLoad="true" treeColumn="taskname">

		<div property="columns">
			<div type="indexcolumn"></div>
			<div field="L_UPDATEDT"  headerAlign="center" allowSort="true" align="left" >
                  	数据日期
			</div>
			<div field="VC_TXID" name="taskname" headerAlign="center" allowSort="true" align="left" >
                  	源交易编号
			</div>
			<div field="VC_TXCD" headerAlign="center" allowSort="true" align="left" >
                	成交编号  
                                              
			</div>
			<div field="VC_TXDT" headerAlign="center" allowSort="true" align="right" >
					成交日期                                              
			</div>
			<div field="VC_TRADESTS" headerAlign="center" allowSort="true" align="right" >
					交易状态                                              
			</div>
			<div field="VC_TRADESTSREM" headerAlign="center" allowSort="true" align="right" >
					交易状态备注
                                              
			</div>
			<div field="VC_STTLMDT" headerAlign="center" allowSort="true" align="right" >
					结算日期                                              
			</div>
			<div field="VC_STOCKCD" headerAlign="center" allowSort="true" align="right" >
					证券代码                                              
			</div>
			<div field="VC_STOCKNM" headerAlign="center" allowSort="true" align="right" >
					证券简称                                              
			</div>
			<div field="VC_BUYERACCT" headerAlign="center" allowSort="true" align="right" >
					买方持有人账号                                              
			</div>
			<div field="VC_BUYERNM" headerAlign="center" allowSort="true" align="right" >
					买方持有人简称                                              
			</div>
			<div field="VC_SELLERACCT" headerAlign="center" allowSort="true" align="right" >
					卖方持有人账号                                              
			</div>
			<div field="VC_SELLERNM" headerAlign="center" allowSort="true" align="right" >
					卖方持有人简称                                              
			</div>
			<div field="VC_TXFACEAMT" headerAlign="center" allowSort="true" align="right" >
					成交面额(万元)                                              
			</div>
			<div field="VC_STTLMVAL" headerAlign="center" allowSort="true" align="right" >
					结算金额(元)                                              
			</div>
			<div field="VC_PERCLPRIC" headerAlign="center" allowSort="true" align="right" >
					百元净价(元)                                              
			</div>
			<div field="VC_PEROHPRIC" headerAlign="center" allowSort="true" align="right" >
					百元全价(元)                                              
			</div>
			<div field="VC_INTEREST" headerAlign="center" allowSort="true" align="right" >
					应计利息(元)                                              
			</div>
			<div field="VC_CLTP" headerAlign="center" allowSort="true" align="right" >
					清算方式                                              
			</div>
			<div field="VC_STTLMTP" headerAlign="center" allowSort="true" align="right" >
					结算方式                                              
			</div>
			<div field="VC_BUYERSTS" headerAlign="center" allowSort="true" align="right" >
					买方状态                                              
			</div>
			<div field="VC_BUYERSTSREM" headerAlign="center" allowSort="true" align="right" >
					买方状态备注                                              
			</div>
			<div field="VC_SELLERSTS" headerAlign="center" allowSort="true" align="right" >
					卖方状态                                              
			</div>
			<div field="VC_SELLERSTSREM" headerAlign="center" allowSort="true" align="right" >
					卖方状态备注                                              
			</div>
			<div field="VC_TRADESRC" headerAlign="center" allowSort="true" align="right" >
					交易来源                                              
			</div>
          </div>
        </div>
  	</div>
	<%-- 分销数据列表列表结束!!! --%> 	
	
<script type="text/javascript">
    nui.parse();
    var datagrid_FXSJLB = nui.get("datagrid_FXSJLB");
    var form = new nui.Form("#form_FXSJLB");
	var json = form.getData(false,false);
	datagrid_FXSJLB.load(json);//grid查询
	
	function search_FXSJLB(){
	    search(datagrid_FXSJLB, "#form_FXSJLB");
	}
	//全屏显示
	function fullScreen(){
		window.open('<%=request.getContextPath()%>/sm/comm/back_stage_trader/bst_fxsjlb_detail.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
	//刷新
	//“今日待处理”模块自动刷新功能处理
    var autoRefreshReturnVal;//自动刷新定时器返回值（使用该值关闭之前的定时器）
    var autoRefreshValOld;//历史自动刷新时间
    function autoRefreshFun(){
    	search_FXSJLB();//同时刷新查询列表数据
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
    autoRefreshReturnVal = self.setInterval("autoRefreshFun()",180000);//设置自动刷新时间默认3分钟
</script>
</body>
</html>