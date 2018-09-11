<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): 吴艳飞
- Date: 2016-12-21 16:35:39
- Description: 买断式回购列表
--%>
<head>
<title>上清-买断式回购</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
  <div class="search-condition">
	 <div class="list">
		<form id="form_MDSHGLB" method="post" >
			<%-- 查询类型 --%>
			<input class="nui-hidden" name="paramObject/queryType" value="MDSHGLB">
			
			<table id="table1" class="table" style="height:100%;table-layout:fixed;">
				<tr>
					<td width="110px"  align="right">
						证券简称:
					</td>
					<td >
						<input id="vcStocknm_MDSHGLB" class="nui-textbox" style="width:80%" name="paramObject/vcStocknm"/>
					</td>
					<td   width="80px" align="right">
						正回购方状态:
					</td>
					<td >
						<input id="vcSellreposts_MDSHGLB" class="nui-textbox" style="width:80%" name="paramObject/vcSellreposts"/>
					</td>
					<td width="80px" align="right">
						逆回购方状态:
					</td>
					<td >
						<input id="vcRevreposts_MDSHGLB" class="nui-textbox" style="width:80%" name="paramObject/vcRevreposts" />
					</td>
					<td   width="80px" align="right">
						交易状态:
					</td>
					<td>
						<input id="vcTradests_MDSHGLB" class="nui-textbox" style="width:80%" name="paramObject/vcTradests"/>
					</td>					
					<td width="115px" align="right">
						正回购方持有人简称:
					</td>
					<td  align="left">
						<input id="vcSellreponm_MDSHGLB" class="nui-textbox" style="width:80%" name="paramObject/vcSellreponm" />
					</td>
				</tr>
				<tr>
					<td width="110px" align="right">
						成交日期:
					</td>
					<td  align="left">
						<input id="vcTxdt_MDSHGLB" class="nui-datepicker"  allowInput="false" style="width:80%" name="paramObject/vcTxdt" />
					</td>
					<td width="80px" align="right">
						首期结算日期:
					</td>
					<td  align="left">
						<input id="vcFrststtlmdt_MDSHGLB" class="nui-datepicker" allowInput="false"  style="width:80%" name="paramObject/vcFrststtlmdt" />
					</td>
					<td width="80px" align="right">
						到期结算日期:
					</td>
					<td  align="left">
						<input id="vcScndsttlmdt_MDSHGLB" class="nui-datepicker" allowInput="false"  style="width:80%" name="paramObject/vcScndsttlmdt"/>
					</td>
					<td width="80px"  align="right">
							数据日期:
					</td>
					<td align="left">
						<input id="lUpdatedt_MDSHGLB" class="nui-datepicker" allowInput="false"  name="paramObject/lUpdatedt"  value="new Date()" style="width:80%"/>
					</td>
					<td align="right">
						逆回购方持有人简称:
					</td>
					<td >
						<input id="vcRevreponm_MDSHGLB" class="nui-textbox"  style="width:80%" name="paramObject/vcRevreponm"/>
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
						<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_MDSHGLB()"/>
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
		    id="datagrid_MDSHGLB"
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
			<div field="VC_TXDT" headerAlign="center" allowSort="true" align="right">
					成交日期                                              
			</div>
			<div field="VC_TRADESTS" headerAlign="center" allowSort="true" align="right">
					交易状态                                              
			</div>
			<div field="VC_TRADESTSREM" headerAlign="center" allowSort="true" align="right">
					交易状态备注
                                              
			</div>
			<div field="VC_STOCKCD" headerAlign="center" allowSort="true" align="right">
					证券代码			
			</div>
			<div field="VC_STOCKNM" headerAlign="center" allowSort="true" align="right">
					证券简称			
			</div>
			<div field="VC_SELLREPOACCT" headerAlign="center" allowSort="true" align="right" width="115px">
					正回购方持有人账号			
			</div>
			<div field="VC_SELLREPONM" headerAlign="center" allowSort="true" align="right" width="115px">
					正回购方持有人简称			
			</div>
			<div field="VC_REVREPOACCT" headerAlign="center" allowSort="true" align="right" width="115px">
					逆回购方持有人账号
			</div>
			<div field="VC_REVREPONM" headerAlign="center" allowSort="true" align="right" width="115px">
					逆回购方持有人简称			
			</div>
			<div field="VC_REPODAYS" headerAlign="center" allowSort="true" align="right">
					回购天数
			</div>
			<div field="VC_CLTP" headerAlign="center" allowSort="true" align="right">
					清算方式			
			</div>
			<div field="VC_STTLMVAL" headerAlign="center" allowSort="true" align="right">
					成交面额(万元)			
			</div>
			<div field="VC_FRSTSTTLMVAL" headerAlign="center" allowSort="true" align="right" width="105px">
					首期结算金额(元)
			</div>
			<div field="VC_FRSTSTTLMTP" headerAlign="center" allowSort="true" align="right">
					首期结算方式
			</div>
			<div field="VC_FRSTSTTLMDT" headerAlign="center" allowSort="true" align="right">
					首期结算日期
			</div>
			<div field="VC_SCNDSTTLMVAL" headerAlign="center" allowSort="true" align="right" width="105px">
					到期结算金额(元)
			</div>
			<div field="VC_SCNDSTTLMTP" headerAlign="center" allowSort="true" align="right">
					到期结算方式
			</div>
			<div field="VC_SCNDSTTLMDT" headerAlign="center" allowSort="true" align="right">
					到期结算日期
			</div>
			<div field="VC_SELLREPOSTS" headerAlign="center" allowSort="true" align="right">
					正回购方状态			
			</div>
			<div field="VC_SELLREPOSTSREM" headerAlign="center" allowSort="true" align="right" width="110px">
					正回购方状态备注			
			</div>
			<div field="VC_REVREPOSTS" headerAlign="center" allowSort="true" align="right">
					逆回购方状态			
			</div>
			<div field="VC_REVREPOSTSREM" headerAlign="center" allowSort="true" align="right" width="110px">
					逆回购方状态备注			
			</div>
			<div field="VC_TRADESRC" headerAlign="center" allowSort="true" align="right">
					交易来源                                              
			</div>
          </div>
        </div>
  	</div>
	<%-- 买断式回购列表列表结束!!! --%> 	
	
<script type="text/javascript">
    nui.parse();
    var datagrid_MDSHGLB = nui.get("datagrid_MDSHGLB");
    var form = new nui.Form("#form_MDSHGLB");
	var json = form.getData(false,false);
	datagrid_MDSHGLB.load(json);//grid查询
	
	function search_MDSHGLB(){
	    search(datagrid_MDSHGLB, "#form_MDSHGLB");
	}
	
	//全屏显示
	function fullScreen(){
		window.open('<%=request.getContextPath()%>/sm/comm/back_stage_trader/bst_mdshglb_detail.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
	//刷新
	//“今日待处理”模块自动刷新功能处理
    var autoRefreshReturnVal;//自动刷新定时器返回值（使用该值关闭之前的定时器）
    var autoRefreshValOld;//历史自动刷新时间
    function autoRefreshFun(){
    	search_MDSHGLB();//同时刷新查询列表数据
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