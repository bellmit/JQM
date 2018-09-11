<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): 冯君培
- Date: 2016-12-21 16:35:39
- Description: 质押式回购列表
--%>
<head>
<title>质押式回购列表</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
  <div class="search-condition">
	 <div class="list">
		<form id="form_ZYSHGLB" method="post" >
			<%-- 查询类型 --%>
			<input class="nui-hidden" name="paramObject/queryType" value="ZYSHGLB">
			
			<table id="table1" class="table" style="height:100%;table-layout:fixed;">
				<tr>
					<td class="form_label" width="10%" align="right">
						成交日期:
					</td>
					<td colspan="1" width="10%">
						<input id="vcTxdt_MDSHGLB" class="nui-datepicker"  name="paramObject/vcTxdt" />
					</td>
					<td class="form_label" width="10%" align="right">
						首期结算日期:
					</td>
					<td colspan="1" width="10%">
						<input id="vcFrststtlmdt_MDSHGLB" class="nui-datepicker"  name="paramObject/vcFrststtlmdt" />
					</td>
					<td class="form_label" width="10%" align="right">
						到期结算日期:
					</td>
					<td colspan="1" width="10%">
						<input id="vcScndsttlmdt_MDSHGLB" class="nui-datepicker" name="paramObject/vcScndsttlmdt"/>
					</td>
					<td   class="form_label" width="8%" align="right">
						交易状态:
					</td>
					<td colspan="1" width="10%">
						<input id="vcTradests_MDSHGLB" class="nui-textbox" name="paramObject/vcTradests"/>
					</td>
					<td colspan="1" width="10%" align="left">
						<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_ZYSHGLB()"/>
					</td>
				</tr>
				<tr>
					<td class="form_label" width="30%" align="right">
						正回购方持有人简称:
					</td>
					<td colspan="1" width="10%">
						<input id="vcSellreponm_MDSHGLB" class="nui-textbox"  name="paramObject/vcSellreponm" />
					</td>
					<td class="form_label" width="30%" align="right">
						逆回购方持有人简称:
					</td>
					<td colspan="1" width="20%">
						<input id="vcRevreponm_MDSHGLB" class="nui-textbox" name="paramObject/vcRevreponm"/>
					</td>
					<td   class="form_label" width="8%" align="right">
						正回购方状态:
					</td>
					<td colspan="1" width="20%">
						<input id="vcSellreposts_MDSHGLB" class="nui-textbox" name="paramObject/vcSellreposts"/>
					</td>
					<td class="form_label" width="20%" align="right">
						逆回购方状态:
					</td>
					<td colspan="1" width="20%">
						<input id="vcRevreposts_MDSHGLB" class="nui-textbox"  name="paramObject/vcRevreposts" />
					</td>
				</tr>
			</table>
		</form>
	  </div>
	</div>		
	<%-- 质押式回购列表开始!!! --%> 	
	<div class="nui-fit">
		<div 
		    id="datagrid_ZYSHGLB"
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
			<div field="VC_TXDT" headerAlign="center" allowSort="true" align="right">
					成交日期                                              
			</div>
			<div field="VC_TRADESTS" headerAlign="center" allowSort="true" align="right">
					交易状态                                              
			</div>
			<div field="VC_TRADEREM" headerAlign="center" allowSort="true" align="right">
					交易状态备注
			</div>
			<div field="VC_SELLREPOACCT" headerAlign="center" allowSort="true" align="right">
					正回购方持有人账号
			</div>
			<div field="VC_SELLREPONM" headerAlign="center" allowSort="true" align="right">
					正回购方持有人简称
			</div>
			<div field="VC_REVREPOACCT" headerAlign="center" allowSort="true" align="right">
					逆回购方持有人账号			
			</div>
			<div field="VC_REVREPONM" headerAlign="center" allowSort="true" align="right">
					逆回购方持有人简称			
			</div>
			<div field="VC_REPODAYS" headerAlign="center" allowSort="true" align="right">
					回购天数			
			</div>
			<div field="VC_CLTP" headerAlign="center" allowSort="true" align="right">
					清算方式
			</div>
			<div field="VC_FRSTSTTLMVAL" headerAlign="center" allowSort="true" align="right">
					首期结算金额(元)
			</div>
			<div field="VC_FRSTSTTLMTP" headerAlign="center" allowSort="true" align="right">
					首期结算方式
			</div>
			<div field="VC_FRSTSTTLMDT" headerAlign="center" allowSort="true" align="right">
					首期结算日期			
			</div>
			<div field="VC_SCNDSTTLMVAL" headerAlign="center" allowSort="true" align="right">
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
			<div field="VC_SELLREPOSTSREM" headerAlign="center" allowSort="true" align="right">
					正回购方状态备注
			</div>
			<div field="VC_REVREPOSTS" headerAlign="center" allowSort="true" align="right">
					逆回购方状态
			</div>
			<div field="VC_REVREPOSTSREM" headerAlign="center" allowSort="true" align="right">
					逆回购方状态备注
			</div>
			<div field="VC_TRADESRC" headerAlign="center" allowSort="true" align="right">
					交易来源                                              
			</div>
          </div>
        </div>
  	</div>
	<%-- 质押式回购列表结束!!! --%> 	
	
<script type="text/javascript">
    nui.parse();
    var datagrid_ZYSHGLB = nui.get("datagrid_ZYSHGLB");
    var form = new nui.Form("#form_ZYSHGLB");
	var json = form.getData(false,false);
	datagrid_ZYSHGLB.load(json);//grid查询
	
	function search_ZYSHGLB(){
	    search(datagrid_ZYSHGLB, "#form_ZYSHGLB");
	}
	
</script>
</body>
</html>