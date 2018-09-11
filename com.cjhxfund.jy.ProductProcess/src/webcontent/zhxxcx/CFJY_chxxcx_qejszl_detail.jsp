<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): 冯君培
- Date: 2016-12-21 16:35:39
- Description: 全额结算指令/建议列表列表
--%>
<head>
<title>全额结算指令/建议列表列表</title>
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
					<td class="form_label" width="5%" align="right">
							资金结算状态:
					</td>
					<td colspan="1" width="10%">
						<input id="vcFundsttlmsts_MDSHGLB" class="nui-textbox"  name="paramObject/vcFundsttlmsts" />
					</td>
					<td class="form_label" width="10%" align="right">
							结算指令/建议状态:
					</td>
					<td colspan="1" width="10%">
						<input id="vcSttlmordersts_MDSHGLB" class="nui-textbox"  name="paramObject/vcSttlmordersts" />
					</td>
					<td class="form_label" width="10%" align="right">
							产品结算状态:
					</td>
					<td colspan="1" width="10%">
						<input id="vcProdsttlmsts_MDSHGLB" class="nui-textbox" name="paramObject/vcProdsttlmsts"/>
					</td>
					<td colspan="1" width="10%" align="left">
						<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_QEJSZL()"/>
					</td>
				</tr>
				<tr>
					<td class="form_label" width="30%" align="right">
							业务品种:
					</td>
					<td colspan="1" width="10%">
						<input id="vcBiztp_MDSHGLB" class="nui-textbox"  name="paramObject/vcBiztp" />
					</td>
					<td class="form_label" width="30%" align="right">
							买/融入/逆回购方简称:
					</td>
					<td colspan="1" width="20%">
						<input id="vcBuyershortnm_MDSHGLB" class="nui-textbox" name="paramObject/vcBuyershortnm"/>
					</td>
					<td   class="form_label" width="20%" align="right">
							卖/融出/正回购方简称:
					</td>
					<td colspan="1" width="20%">
						<input id="vcSellershortnm_MDSHGLB" class="nui-textbox" name="paramObject/vcSellershortnm"/>
					</td>
					
				</tr>
				<tr>
					<td class="form_label" width="10%" align="right">
							证券简称:
					</td>
					<td colspan="1" width="20%">
						<input id="vcStocknm_MDSHGLB" class="nui-textbox"  name="paramObject/vcStocknm" />
					</td>
					<td class="form_label" width="10%" align="right">
							结算日:
					</td>
					<td colspan="1" width="20%">
						<input id="vcSttlmdt_MDSHGLB" class="nui-datepicker"  name="paramObject/vcSttlmdt" />
					</td>
					<td class="form_label" width="10%" align="right">
							指令/建议生成日
					</td>
					<td colspan="1" width="20%">
						<input id="vcOdrgnrtdate_MDSHGLB" class="nui-datepicker"  name="paramObject/vcOdrgnrtdate" />
					</td>
				</tr>
			</table>
		</form>
	  </div>
	</div>		
	<%-- 全额结算指令/建议列表列表开始!!! --%> 	
	<div class="nui-fit">
		<div 
		    id="datagrid_QEJSZL"
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
			<div field="VC_STTLMORDERCD" headerAlign="center" allowSort="true" align="left" width="150px">
                	结算指令/建议编号  
			</div>
			<div field="VC_TXDT" headerAlign="center" allowSort="true" align="left" width="150px">
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
					结算指令/建议状态
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
			<div field="VC_FUNDSTTLMVAL" headerAlign="center" allowSort="true" align="right">
					资金结算金额(元)
			</div>
			<div field="VC_STTLMDT" headerAlign="center" allowSort="true" align="right">
					结算日
			</div>
			<div field="VC_ODRGNRTDATE" headerAlign="center" allowSort="true" align="right">
					指令/建议生成日                                            
			</div>
			<div field="VC_ODRFRSTGNRTTM" headerAlign="center" allowSort="true" align="right">
					指令/建议首次创建时间					                                           
			</div>
			<div field="VC_ODRUPDATETM" headerAlign="center" allowSort="true" align="right">
					指令/建议更新时间					                                           
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
			<div field="VC_RCVPMTCFMCHECKER" headerAlign="center" allowSort="true" align="right">
					收付款确认复核人					                                           
			</div>
			<div field="VC_ODRREVOCATIONSIDE" headerAlign="center" allowSort="true" align="right">
					指令/建议撤销方					                                           
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
	<%-- 全额结算指令/建议列表列表结束!!! --%> 	
	
<script type="text/javascript">
    nui.parse();
    var datagrid_QEJSZL = nui.get("datagrid_QEJSZL");
    var form = new nui.Form("#form_QEJSZL");
	var json = form.getData(false,false);
	datagrid_QEJSZL.load(json);//grid查询
	
	function search_QEJSZL(){
	    search(datagrid_QEJSZL, "#form_QEJSZL");
	}
	
</script>
</body>
</html>