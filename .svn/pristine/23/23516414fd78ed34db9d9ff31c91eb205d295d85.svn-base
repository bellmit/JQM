<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<!-- 
  - Author(s): chendi
  - Date: 2017-06-02 10:22:17
  - Description: 上清所指令数据(新)
-->
<head>
<title>上清-全额结算指令</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
  <div class="search-condition">
	 <div class="list">
		<form id="form_SQZLXZLB" method="post" >
			<%-- 查询类型 --%>
			<input class="nui-hidden" name="paramObject/queryType" value="SQZLXZLB">
			
			<table id="table1" class="table" style="height:100%;table-layout:fixed;">
				<tr>
					<td width="90px" align="right">
							产品简称:
					</td>
					<td>
						<input id="vcProductName_SQZLXZLB" class="nui-textbox"  name="paramObject/vcProductName" style="width:80%"/>
					</td>
					<td width="80px"  align="right">
							买方状态:
					</td>
					<td align="left">
						<input id="cBuyerstatus_SQZLXZLB" class="nui-textbox" name="paramObject/cBuyerstatus" style="width:80%"/>
					</td>
					<td  width="80px" align="right">
							卖方状态:
					</td>
					<td align="left">
						<input id="cSellerstatus_SQZLXZLB" class="nui-textbox" name="paramObject/cSellerstatus" style="width:80%"/>
					</td>
					<td width="125px" align="right">
							买方持有人简称:
					</td>
					<td align="left">
						<input id="vcBholdershortname_SQZLXZLB" class="nui-textbox" name="paramObject/vcBholdershortname" style="width:80%"/>
					</td>
					<td width="125px" align="right">
							卖方持有人简称:
					</td>
					<td>
						<input id="vcSholdershortname_SQZLXZLB" class="nui-textbox" name="paramObject/vcSholdershortname" style="width:80%"/>
					</td>
				</tr>
				<tr>
					<td align="right">
							成交编号:
					</td>
					<td>
						<input id="vcTradeid_SQZLXZLB" class="nui-textbox"  name="paramObject/vcTradeid" style="width:80%"/>
					</td>
					<td align="right">
							交易日期:
					</td>
					<td>
						<input id="lTradedate_SQZLXZLB" allowInput="false"  class="nui-datepicker"  name="paramObject/lTradedate" style="width:80%"/>
					</td>
					<td align="right">
							结算日期:
					</td>
					<td >
						<input id="lSettlementdate_SQZLXZLB" allowInput="false"  class="nui-datepicker" name="paramObject/lSettlementdate" style="width:80%"/>
					</td>
					<td align="right">
							数据日期:
					</td>
					<td>
						<input id="lDate_SQZLXZLB"  allowInput="false"  class="nui-datepicker"  name="paramObject/lDate"  value="new Date()" style="width:80%"/>
					</td>
					<td align="right">
							操作人姓名:
					</td>
					<td>
						<input id="vcOpername_SQZLXZLB" class="nui-textbox" name="paramObject/vcOpername" style="width:80%"/>
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
						<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_SQZLXZLB()"/>
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
		    id="datagrid_SQZLXZLB"
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
			<div field="L_DATE"  headerAlign="center" allowSort="true" align="left" >
                  	数据日期
			</div>
			<div field="VC_TRADEID" name="taskname" headerAlign="center" allowSort="true" align="left" >
                  	成交编号
			</div>
			<div field="VC_STTLMORDERCD" headerAlign="center" allowSort="true" align="left">
                	交易指令编号  
			</div>
			<div field="C_SOURCEFROM" headerAlign="center" allowSort="true" align="left">
					交易来源                                             
			</div>
			<div field="C_ORDERSTATUS" headerAlign="center" allowSort="true" align="left">
					指令状态
			</div>
			<div field="C_TRADETYPE" headerAlign="center" allowSort="true" align="left">
					交易方式
			</div>
			<div field="C_CLEARTYPE" headerAlign="center" allowSort="true" align="left">
					清算方式
			</div>
			<div field="VC_PRODUCTCODE" headerAlign="center" allowSort="true" align="left">
					产品代码
			</div>
			<div field="VC_PRODUCTNAME" headerAlign="center" allowSort="true" align="left">
					产品简称
			</div>
			<div field="EN_FACEVALUE" headerAlign="center" allowSort="true" align="right">
					产品面值(万元)
			</div>
			<div field="VC_BUYERHOLDERACCOUNT" headerAlign="center" allowSort="true" align="left">
					买/融入/逆回购方持有人账号			
			</div>
			<div field="VC_BHOLDERSHORTNAME" headerAlign="center" allowSort="true" align="left">
					买/融入/逆回购方持有人简称			
			</div>
			<div field="VC_BOPERHOLDERACCOUNT" headerAlign="center" allowSort="true" align="left">
					买/融入/逆回购方操作持有人账号
			</div>
			<div field="VC_SELLERHOLDERACCOUNT" headerAlign="center" allowSort="true" align="left">
					卖/融出/正回购方持有人账号
			</div>
			<div field="VC_SHOLDERSHORTNAME" headerAlign="center" allowSort="true" align="left">
					卖/融出/正回购方持有人简称			
			</div>
			<div field="VC_SOPERHOLDERACCOUNT" headerAlign="center" allowSort="true" align="left">
					卖/融出/正回购方操作持有人账号		
			</div>
			
			<div field="EN_CLEANPRICE" headerAlign="center" allowSort="true" align="right">
					净价
			</div>
			<div field="EN_FULLPRICE" headerAlign="center" allowSort="true" align="right">
					全价
			</div>
			<div field="EN_ACCRUEDINTEREST" headerAlign="center" allowSort="true" align="right">
					应计利息
			</div>
			<div field="EN_SETTLEMENTAMOUNT" headerAlign="center" allowSort="true" align="right">
					资金结算金额
			</div>
			<div field="L_TRADEDATE" headerAlign="center" allowSort="true" align="left">
					交易日期
			</div>
			<div field="L_SETTLEMENTTYPE" headerAlign="center" allowSort="true" align="left">
					首期结算方式                                            
			</div>
			<div field="L_DUESETTLEMETHOD" headerAlign="center" allowSort="true" align="left">
					到期结算方式					                                           
			</div>
			<div field="L_SETTLEMENTDATE" headerAlign="center" allowSort="true" align="left">
					结算日期					                                           
			</div>
			<div field="L_DUESETTLEDATE" headerAlign="center" allowSort="true" align="left">
					到期结算日期					                                           
			</div>
			<div field="EN_REPODAYS" headerAlign="center" allowSort="true" align="left">
					回购天数					                                           
			</div>
			<div field="C_BUYERSTATUS" headerAlign="center" allowSort="true" align="left">
					买方状态					                                           
			</div>
			<div field="C_SELLERSTATUS" headerAlign="center" allowSort="true" align="left">
					卖方状态					                                           
			</div>
			<div field="VC_OPERNAME" headerAlign="center" allowSort="true" align="left">
					操作人姓名					                                           
			</div>
			<div field="C_MATCH_FLAG" headerAlign="center" allowSort="true" align="left">
					成交匹配状态					                                           
			</div>
			<div field="VC_MATCH_ERRMSG" headerAlign="center" allowSort="true" align="left">
					匹配返回信息					                                           
			</div>
			<div field="B_CHECK_FLAG" headerAlign="center" allowSort="true" align="left">
					发送状态					                                           
			</div>
			<div field="VC_REASON" headerAlign="center" allowSort="true" align="left">
					备注					                                           
			</div>
			
          </div>
        </div>
  	</div>
	<%-- 全额结算指令列表列表结束!!! --%> 	
	
<script type="text/javascript">
    nui.parse();
    var datagrid_SQZLXZLB = nui.get("datagrid_SQZLXZLB");
    var form = new nui.Form("#form_SQZLXZLB");
	var json = form.getData(false,false);
	datagrid_SQZLXZLB.load(json);//grid查询
	
	function search_SQZLXZLB(){
	    search(datagrid_SQZLXZLB, "#form_SQZLXZLB");
	}
	$(function(){
		nui.get("lDate_SQZLXZLB").setValue(new Date());
	});
	//全屏显示
	function fullScreen(){
		window.open('<%=request.getContextPath()%>/sm/comm/back_stage_trader/bst_sqzlxzlb_detail.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
	//刷新
	//“今日待处理”模块自动刷新功能处理
    var autoRefreshReturnVal;//自动刷新定时器返回值（使用该值关闭之前的定时器）
    var autoRefreshValOld;//历史自动刷新时间
    function autoRefreshFun(){
    	search_SQZLXZLB();//同时刷新查询列表数据
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