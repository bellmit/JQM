<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<!-- 
  - Author(s): chendi
  - Date: 2017-06-02 10:22:17
  - Description: 上清所结算数据(新)
-->
<head>
<title>上清-结算数据(新)</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
  <div class="search-condition">
	 <div class="list">
		<form id="form_SQJSXZLB" method="post" >
			<%-- 查询类型 --%>
			<input class="nui-hidden" name="paramObject/queryType" value="SQJSXZLB">
			
			<table id="table1" class="table" style="height:100%;table-layout:fixed;">
				<tr>
					<td width="90px" align="right">
							产品简称:
					</td>
					<td>
						<input id="vcProductName_SQJSXZLB" class="nui-textbox"  name="paramObject/vcProductName" style="width:80%"/>
					</td>
					<td width="80px"  align="right">
							资金结算状态:
					</td>
					<td align="left">
						<input id="cFundsettstatus_SQJSXZLB" class="nui-textbox"  name="paramObject/cFundsettstatus" style="width:80%"/>
					</td>
					<td  width="80px" align="right">
							产品结算状态:
					</td>
					<td align="left">
						<input id="cProductstatus_SQJSXZLB" class="nui-textbox" name="paramObject/cProductstatus" style="width:80%"/>
					</td>
					<td width="125px" align="right">
							买方持有人账户简称:
					</td>
					<td align="left">
						<input id="vcBholdershortname_SQJSXZLB" class="nui-textbox" name="paramObject/vcBholdershortname" style="width:80%"/>
					</td>
					<td width="125px" align="right">
							卖方持有人账户简称:
					</td>
					<td>
						<input id="vcSholdershortname_SQJSXZLB" class="nui-textbox" name="paramObject/vcSholdershortname" style="width:80%"/>
					</td>
				</tr>
				<tr>
					<td align="right">
							成交编号:
					</td>
					<td>
						<input id="vcTradeid_SQJSXZLB" class="nui-textbox"  name="paramObject/vcTradeid" style="width:80%"/>
					</td>
					<td align="right">
							交易日期:
					</td>
					<td>
						<input id="lCreatedate_SQJSXZLB" allowInput="false"  class="nui-datepicker"  name="paramObject/lCreatedate" style="width:80%"/>
					</td>
					<td align="right">
							结算日期:
					</td>
					<td >
						<input id="lSettlementdate_SQJSXZLB" allowInput="false"  class="nui-datepicker" name="paramObject/lSettlementdate" style="width:80%"/>
					</td>
					<td align="right">
							数据日期:
					</td>
					<td>
						<input id="lDate_SQJSXZLB"  allowInput="false"  class="nui-datepicker"  name="paramObject/lDate"  value="new Date()" style="width:80%"/>
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
						<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_SQJSXZLB()"/>
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
		    id="datagrid_SQJSXZLB"
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
			<div field="VC_SETTLEMENTORDERID" headerAlign="center" allowSort="true" align="left">
                	结算指令编号  
			</div>
			<div field="VC_TRADEID" headerAlign="center" allowSort="true" align="left" >
                	交易指令编号  
			</div>
			<div field="VC_BUYERHOLDERACCOUNT" headerAlign="center" allowSort="true" align="left">
					买方持有人账号                                             
			</div>
			<div field="VC_BHOLDERSHORTNAME" headerAlign="center" allowSort="true" align="left">
					买方持有人账户简称                                          
			</div>
			<div field="VC_BAGENCYHOLDERACCOUNT" headerAlign="center" allowSort="true" align="left">
					买方代理持有人账号
			</div>
			<div field="VC_BAGENCYHOLDERSHORTNAME" headerAlign="center" allowSort="true" align="left">
					买方代理持有人账户简称
			</div>
			<div field="VC_BOPERHOLDERACCOUNT" headerAlign="center" allowSort="true" align="left">
					买方操作持有人账号
			</div>
			<div field="VC_SELLERHOLDERACCOUNT" headerAlign="center" allowSort="true" align="left">
					卖方持有人账号
			</div>
			<div field="VC_SHOLDERSHORTNAME" headerAlign="center" allowSort="true" align="left">
					卖方持有人账户简称			
			</div>
			<div field="VC_SAGENCYHOLDERACCOUNT" headerAlign="center" allowSort="true" align="left">
					卖方代理持有人账号			
			</div>
			<div field="VC_SAGENCYHOLDERSHORTNAME" headerAlign="center" allowSort="true" align="left">
					卖方代理持有人账户简称			
			</div>
			<div field="VC_SOPERHOLDERACCOUNT" headerAlign="center" allowSort="true" align="left">
					卖方操作持有人账号
			</div>
			<div field="VC_PRODUCTCODE" headerAlign="center" allowSort="true" align="left">
					产品代码
			</div>
			<div field="VC_PRODUCTNAME" headerAlign="center" allowSort="true" align="left">
					产品简称			
			</div>
			<div field="VC_TRADETYPE" headerAlign="center" allowSort="true" align="left">
					交易方式		
			</div>
			<div field="VC_CURRENCY" headerAlign="center" allowSort="true" align="left">
					币种
			</div>
			<div field="L_SETTLEMENTTYPE" headerAlign="center" allowSort="true" align="left">
					结算方式
			</div>
			<div field="C_FULLORDERTYPE" headerAlign="center" allowSort="true" align="left">
					全额结算指令类型
			</div>
			<div field="C_PARTICIPATETYPE" headerAlign="center" allowSort="true" align="left">
					参与方式
			</div>
			<div field="EN_SETTLEMENTAMOUNT" headerAlign="center" allowSort="true" align="right" width="105px">
					结算金额
			</div>
			<div field="EN_FACEVALUE" headerAlign="center" allowSort="true" align="right">
					产品面值
			</div>
			<div field="C_GROSSORDERSTATUS" headerAlign="center" allowSort="true" align="left">
					指令状态                                            
			</div>
			<div field="C_FUNDSETTSTATUS" headerAlign="center" allowSort="true" align="left">
					资金结算状态					                                           
			</div>
			<div field="C_PRODUCTSTATUS" headerAlign="center" allowSort="true" align="left">
					产品结算状态					                                           
			</div>
			<div field="L_FINANCEGRACEPERIOD" headerAlign="center" allowSort="true" align="left">
					资金宽限期					                                           
			</div>
			<div field="L_PRODUCTGRACEPERIOD" headerAlign="center" allowSort="true" align="left">
					产品宽限期					                                           
			</div>
			<div field="L_SETTLEMENTDATE" headerAlign="center" allowSort="true" align="left">
					结算日期					                                           
			</div>
			<div field="VC_BOPERORDERSTATUS" headerAlign="center" allowSort="true" align="left">
					买方指令可操作状态					                                           
			</div>
			<div field="VC_SOPERORDERSTATUS" headerAlign="center" allowSort="true" align="left">
					卖方指令可操作状态					                                           
			</div>
			<div field="C_STOCKSETTLE_FLAG" headerAlign="center" allowSort="true" align="left">
					证券交收状态					                                           
			</div>
			<div field="C_CASHSETTLE_FLAG" headerAlign="center" allowSort="true" align="left">
					资金交收状态					                                           
			</div>
			<div field="VC_SETTLE_ERRMSG" headerAlign="center" allowSort="true" align="left">
					交收错误信息					                                           
			</div>
			<div field="L_CREATEDATE" headerAlign="center" allowSort="true" align="left">
					交易日期					                                           
			</div>
			<div field="L_CREATETIME" headerAlign="center" allowSort="true" align="left">
					生成时间					                                           
			</div>
			<div field="L_ORDERSTATUSUPDATETIME" headerAlign="center" allowSort="true" align="left">
					更新时间					                                           
			</div>
			
          </div>
        </div>
  	</div>
	<%-- 全额结算指令列表列表结束!!! --%> 	
	
<script type="text/javascript">
    nui.parse();
    var datagrid_SQJSXZLB = nui.get("datagrid_SQJSXZLB");
    var form = new nui.Form("#form_SQJSXZLB");
	var json = form.getData(false,false);
	datagrid_SQJSXZLB.load(json);//grid查询
	
	function search_SQJSXZLB(){
	    search(datagrid_SQJSXZLB, "#form_SQJSXZLB");
	}
	$(function(){
		nui.get("lDate_SQJSXZLB").setValue(new Date());
	});
	//全屏显示
	function fullScreen(){
		window.open('<%=request.getContextPath()%>/sm/comm/back_stage_trader/bst_sqjsxzlb_detail.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
	//刷新
	//“今日待处理”模块自动刷新功能处理
    var autoRefreshReturnVal;//自动刷新定时器返回值（使用该值关闭之前的定时器）
    var autoRefreshValOld;//历史自动刷新时间
    function autoRefreshFun(){
    	search_SQJSXZLB();//同时刷新查询列表数据
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