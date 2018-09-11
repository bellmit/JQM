<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): 冯君培
- Date: 2016-12-21 16:35:39
- Description: 分销数据列表
--%>
<head>
<title>分销数据列表</title>
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
					<td class="form_label" width="10%" align="right">
					证券简称:
					</td>
					<td colspan="1" width="20%">
						<input id="vcStocknm_FXSJLB" class="nui-textbox"  name="paramObject/vcStocknm" />
					</td>
					<td class="form_label" width="10%" align="right">
					交易状态:
					</td>
					<td colspan="1" width="20%">
						<input id="vcTradests_FXSJLB" class="nui-textbox"  name="paramObject/vcTradests" />
					</td>
					<td class="form_label" width="10%" align="right">
					卖方状态:
					</td>
					<td colspan="1" width="20%">
						<input id="vcSellersts_FXSJLB" class="nui-textbox" name="paramObject/vcSellersts"/>
					</td>
					<td class="form_label" width="10%" align="right">
					买方状态:
					</td>
					<td colspan="1" width="20%">
						<input id="vcBuyersts_FXSJLB" class="nui-textbox"  name="paramObject/vcBuyersts" />
					</td>
					<td colspan="1" width="10%" align="left">
						<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_FXSJLB()"/>
					</td>
				</tr>
				<tr>
					
					<td class="form_label" width="30%" align="right">
					卖方持有人简称:
					</td>
					<td colspan="1" width="10%">
						<input id="vcSellernm_FXSJLB" class="nui-textbox"  name="paramObject/vcSellernm" />
					</td>
					<td class="form_label" width="30%" align="right">
					买方持有人简称:
					</td>
					<td colspan="1" width="20%">
						<input id="vcBuyernm_FXSJLB" class="nui-textbox" name="paramObject/vcBuyernm"/>
					</td>
					<td   class="form_label" width="8%" align="right">
					结算日期:
					</td>
					<td colspan="1" width="20%">
						<input id="vcSttlmdt_FXSJLB" class="nui-datepicker" name="paramObject/vcSttlmdt"/>
					</td>
					<td   class="form_label" width="8%" align="right">
					成交日期:
					</td>
					<td colspan="1" width="20%">
						<input id="vcTxdt_FXSJLB" class="nui-datepicker" name="paramObject/vcTxdt"/>
					</td>
				</tr>
			</table>
		</form>
	  </div>
	</div>		
	<%-- 分销数据列表开始!!! --%> 	
	<div class="nui-fit">
		<div 
		    id="datagrid_FXSJLB"
			dataField="resultObjectList"
			class="nui-datagrid"
			style="width:100%;height:100%;"
 			url="com.cjhxfund.jy.ProductProcess.SqZzManage.querySQZZCJCX.biz.ext"
			pageSize="50"
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
			<div field="VC_TXID" name="taskname" headerAlign="center" allowSort="true" align="left" width="130px">
                  	源交易编号
			</div>
			<div field="VC_TXCD" headerAlign="center" allowSort="true" align="left" width="150px">
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
	
</script>
</body>
</html>