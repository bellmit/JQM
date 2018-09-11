<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): 吴艳飞
- Date: 2016-12-21 16:35:39
- Description: 全额结算指令列表列表
--%>
<head>
<title>上清-全额结算指令</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
  <div class="search-condition">
	 <div class="list">
		<form id="form_QEJSZL" method="post" >
			<%-- 查询类型 --%>
			<input class="nui-hidden" name="paramObject/queryType" value="QEJSZL">
			
			<table id="table1" class="table" style="height:100%;table-layout:fixed;">
				<tr>
					<td  width="90px" align="right">
							资金结算状态:
					</td>
					<td align="left">
						<input id="vcFundsttlmsts_MDSHGLB" class="nui-textbox"  name="paramObject/vcFundsttlmsts"  style="width:80%"/>
					</td>
					<td width="80px"  align="right">
							结算指令状态:
					</td>
					<td align="left">
						<input id="vcSttlmordersts_MDSHGLB" class="nui-textbox"  name="paramObject/vcSttlmordersts" style="width:80%"/>
					</td>
					<td  width="80px" align="right">
							产品结算状态:
					</td>
					<td align="left">
						<input id="vcProdsttlmsts_MDSHGLB" class="nui-textbox" name="paramObject/vcProdsttlmsts" style="width:80%"/>
					</td>
					<td  width="60px" align="right">
							业务品种:
					</td>
					<td align="left">
						<input id="vcBiztp_MDSHGLB" class="nui-textbox"  name="paramObject/vcBiztp"  style="width:80%"/>
					</td>
					<td width="125px" align="right">
							买/融入/逆回购方简称:
					</td>
					<td align="left">
						<input id="vcBuyershortnm_MDSHGLB" class="nui-textbox" name="paramObject/vcBuyershortnm" style="width:80%"/>
					</td>
				</tr>
				<tr>
					<td align="right">
							证券简称:
					</td>
					<td>
						<input id="vcStocknm_MDSHGLB" class="nui-textbox"  name="paramObject/vcStocknm" style="width:80%"/>
					</td>
					<td align="right">
							结算日:
					</td>
					<td >
						<input id="vcSttlmdt_MDSHGLB" class="nui-datepicker" allowInput="false"  name="paramObject/vcSttlmdt" style="width:80%"/>
					</td>
					<td align="right">
							指令生成日:
					</td>
					<td>
						<input id="vcOdrgnrtdate_MDSHGLB" class="nui-datepicker" allowInput="false"  name="paramObject/vcOdrgnrtdate" style="width:80%"/>
					</td>
					<td align="right">
							数据日期:
					</td>
					<td>
						<input id="lUpdatedt_MDSHGLB"  allowInput="false"  class="nui-datepicker"  name="paramObject/lUpdatedt"  value="new Date()" style="width:80%"/>
					</td>
					<td align="right">
							卖/融出/正回购方简称:
					</td>
					<td>
						<input id="vcSellershortnm_MDSHGLB" class="nui-textbox" name="paramObject/vcSellershortnm" style="width:80%"/>
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
						<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_QEJSZL()"/>
				</td>
	            <td style="width:50%;" align="right">
	            	<%-- 点击“刷新”按钮后重启自动刷新功能（若之前自动刷新功能设置为不自动刷新关闭时） --%>
	                    <a class='nui-button' plain='false' iconCls="icon-reload" onclick="autoRefreshFun()">刷新</a>
	                    <input id="autoRefresh" class="nui-combobox" style="width:90px;" textField="text" valueField="id" url="<%= request.getContextPath() %>/ProductProcess/AutoRefreshData.txt" value="180" showNullItem="false" allowInput="false"/>
	            </td>
	        </tr>
	    </table>
    </div>		
	<%-- 全额结算指令列表列表开始!!! --%> 	
	<div class="nui-fit">
		<div 
		    id="datagrid_QEJSZL"
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
			<div field="VC_STTLMORDERCD" headerAlign="center" allowSort="true" align="left">
                	结算指令编号  
			</div>
			<div field="VC_TXDT" headerAlign="center" allowSort="true" align="left" >
                	成交编号  
			</div>
			<div field="VC_FRSTORSCND" headerAlign="center" allowSort="true" align="right">
					首期/到期                                             
			</div>
			<div field="VC_BIZTP" headerAlign="center" allowSort="true" align="right">
					业务品种                                          
			</div>
			<div field="VC_STTLMTP" headerAlign="center" allowSort="true" align="right">
					结算方式
			</div>
			<div field="VC_STTLMORDERSTS" headerAlign="center" allowSort="true" align="right">
					结算指令状态
			</div>
			<div field="VC_PRODSTTLMSTS" headerAlign="center" allowSort="true" align="right">
					产品结算状态
			</div>
			<div field="VC_FUNDSTTLMSTS" headerAlign="center" allowSort="true" align="right">
					资金结算状态			
			</div>
			<div field="VC_BUYERACCT" headerAlign="center" allowSort="true" align="right">
					买/融入/逆回购方账号			
			</div>
			<div field="VC_BUYERSHORTNM" headerAlign="center" allowSort="true" align="right">
					买/融入/逆回购方简称			
			</div>
			<div field="VC_BUYERAGNTACCT" headerAlign="center" allowSort="true" align="right">
					买/融入/逆回购方代理账号
			</div>
			<div field="VC_BUYERAGNTSHORTNM" headerAlign="center" allowSort="true" align="right">
					买/融入/逆回购方代理简称
			</div>
			<div field="VC_SELLERACCT" headerAlign="center" allowSort="true" align="right">
					卖/融出/正回购方账号
			</div>
			<div field="VC_SELLERSHORTNM" headerAlign="center" allowSort="true" align="right">
					卖/融出/正回购方简称			
			</div>
			<div field="VC_SELLERAGNTACCT" headerAlign="center" allowSort="true" align="right">
					卖/融出/正回购方代理账号		
			</div>
			<div field="VC_SELLERAGNTSHORTNM" headerAlign="center" allowSort="true" align="right">
					卖/融出/正回购方代理简称
			</div>
			<div field="VC_STOCKCD" headerAlign="center" allowSort="true" align="right">
					证券代码
			</div>
			<div field="VC_STOCKNM" headerAlign="center" allowSort="true" align="right">
					证券简称
			</div>
			<div field="VC_STOCKFACEAMT" headerAlign="center" allowSort="true" align="right">
					证券面额(万元)
			</div>
			<div field="VC_FUNDSTTLMVAL" headerAlign="center" allowSort="true" align="right" width="105px">
					资金结算金额(元)
			</div>
			<div field="VC_STTLMDT" headerAlign="center" allowSort="true" align="right">
					结算日
			</div>
			<div field="VC_ODRGNRTDATE" headerAlign="center" allowSort="true" align="right">
					指令生成日                                            
			</div>
			<div field="VC_ODRFRSTGNRTTM" headerAlign="center" allowSort="true" align="right" width="105px">
					指令首次创建时间					                                           
			</div>
			<div field="VC_ODRUPDATETM" headerAlign="center" allowSort="true" align="right">
					指令更新时间					                                           
			</div>
			<div field="VC_PRODSTTLMGRACE" headerAlign="center" allowSort="true" align="right">
					产品结算宽限期					                                           
			</div>
			<div field="VC_FUNDSTTLMGRACE" headerAlign="center" allowSort="true" align="right">
					资金结算宽限期					                                           
			</div>
			<div field="VC_RCVPMTCFMER" headerAlign="center" allowSort="true" align="right">
					收付款确认人					                                           
			</div>
			<div field="VC_RCVPMTCFMCHECKER" headerAlign="center" allowSort="true" align="right" width="105px">
					收付款确认复核人					                                           
			</div>
			<div field="VC_ODRREVOCATIONSIDE" headerAlign="center" allowSort="true" align="right">
					指令撤销方					                                           
			</div>
			<div field="VC_REVOCATIONTM" headerAlign="center" allowSort="true" align="right">
					撤销时间					                                           
			</div>
			<div field="VC_REVOCATIONCFMER" headerAlign="center" allowSort="true" align="right">
					撤销确认方					                                           
			</div>
			<div field="VC_REVOCATIONCFMTM" headerAlign="center" allowSort="true" align="right">
					撤销确认时间					                                           
			</div>
			<div field="VC_REVOCATIONRSLT" headerAlign="center" allowSort="true" align="right">
					撤销处理结果					                                           
			</div>
			
          </div>
        </div>
  	</div>
	<%-- 全额结算指令列表列表结束!!! --%> 	
	
<script type="text/javascript">
    nui.parse();
    var datagrid_QEJSZL = nui.get("datagrid_QEJSZL");
    var form = new nui.Form("#form_QEJSZL");
	var json = form.getData(false,false);
	datagrid_QEJSZL.load(json);//grid查询
	
	function search_QEJSZL(){
	    search(datagrid_QEJSZL, "#form_QEJSZL");
	}
	$(function(){
		nui.get("lUpdatedt_MDSHGLB").setValue(new Date());
	});
	//全屏显示
	function fullScreen(){
		window.open('<%=request.getContextPath()%>/sm/comm/back_stage_trader/bst_qejszl_detail.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
	//刷新
	//“今日待处理”模块自动刷新功能处理
    var autoRefreshReturnVal;//自动刷新定时器返回值（使用该值关闭之前的定时器）
    var autoRefreshValOld;//历史自动刷新时间
    function autoRefreshFun(){
    	search_QEJSZL();//同时刷新查询列表数据
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