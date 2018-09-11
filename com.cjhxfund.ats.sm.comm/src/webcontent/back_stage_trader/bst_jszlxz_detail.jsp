<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): 吴艳飞
- Date: 2016-12-21 16:35:39
- Description: 结算指令下载
--%>
<head>
<title>中债-结算指令</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
  <div class="search-condition">
	 <div class="list">
		<form id="form_JSZLXZ" method="post" >
			<%-- 查询类型 --%>
			<input class="nui-hidden" name="paramObject/queryType" value="JSZLXZ">
			
			<table id="table1" class="table" style="height:100%;table-layout:fixed;">
				<tr>
					<td width="80px" align="right">
					客户简称:
					</td>
					<td align="left">
						<input id="vcOrgtrnm_JSZLXZ" style="width:80%" class="nui-textbox" name="paramObject/vcOrgtrnm"/>
					</td>
					<td width="155px"" align="right">
					对手方简称:
					</td>
					<td align="left">
						<input id="vcCtrptynm_JSZLXZ" class="nui-textbox" style="width:80%" name="paramObject/vcCtrptynm" />
					</td>
					<td width="80px"" align="right">
					业务类别描述:
					</td>
					<td align="left">
						<input id="vcBiztp_JSZLXZ" class="nui-textbox" style="width:80%" name="paramObject/vcBiztp" />
					</td>
					<td width="80px" align="right">
					指令状态描述:
					</td>
					<td align="left">
						<input id="vcInstrsts_JSZLXZ" class="nui-textbox" style="width:80%" name="paramObject/vcInstrsts" />
					</td>
				</tr>
				<tr>
					
					<td align="right">
					首次交割日:
					</td>
					<td >
						<input id="vcFrstdlvrydt_JSZLXZ" class="nui-datepicker"  allowInput="false"  style="width:80%" name="paramObject/vcFrstdlvrydt"/>
					</td>
					<td align="right">
					到期交割日/远期交割成交日:
					</td>
					<td >
						<input id="vcScnddlvrydt_JSZLXZ" class="nui-datepicker" allowInput="false" style="width:80%" name="paramObject/vcScnddlvrydt"/>
					</td>
					<td width="80px" align="right">
							数据日期:
					</td>
					<td>
						<input id="lUpdatedt_MDSHGLB" class="nui-datepicker"  allowInput="false"  name="paramObject/lUpdatedt"  value="new Date()" style="width:80%"/>
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
						<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_JSZLXZ()"/>
				</td>
	            <td style="width:50%;" align="right">
	            	<%-- 点击“刷新”按钮后重启自动刷新功能（若之前自动刷新功能设置为不自动刷新关闭时） --%>
	                    <a class='nui-button' plain='false' iconCls="icon-reload" onclick="autoRefreshFun()">刷新</a>
	                    <input id="autoRefresh" class="nui-combobox" style="width:90px;" textField="text" valueField="id" url="<%= request.getContextPath() %>/ProductProcess/AutoRefreshData.txt" value="180" showNullItem="false" allowInput="false"/>
	            </td>
	        </tr>
	    </table>
    </div>
	<%-- 结算指令下载列表开始!!! --%> 	
	<div class="nui-fit">
		<div 
		    id="datagrid_JSZLXZ"
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
			<div field="L_UPDATEDT"  headerAlign="center" allowSort="true" align="left" ">
                  	数据日期
			</div>
			<div field="VC_INSTRID" name="taskname" headerAlign="center" allowSort="true" align="left" ">
                            指令编号
			</div>
			<div field="VC_ORGTRNM" headerAlign="center" allowSort="true" align="left" >
                            客户简称
			</div>
			<div field="VC_ORGTRSUBACCTID" headerAlign="center" allowSort="true" align="right">
                            本方分组合号
 			</div>
			<div field="VC_ORGTRSUBNM" headerAlign="center" allowSort="true" align="right" >
                            本方分组合简称
			</div>
			<div field="VC_ORGTRACCTID" headerAlign="center" allowSort="true" align="right">
                           债券账号
			</div>
			<div field="VC_ACCTWTHDVPNETGCONFD" headerAlign="center" allowSort="true" align="right" >
                            预发行净额结算DVP被确认账号
			</div>
			<div field="VC_ACCTWTHMRGNBLCKGCONFD" headerAlign="center" allowSort="true" align="right">
                            保证金冻结确认被确认账号
			</div>
			<div field="VC_ACCTWHTMRGNUNBLCKGCONFD" headerAlign="center" allowSort="true" align="right">
		   保证金解冻确认被确认账号
			</div>
			<div field="VC_CTRPTYNM" headerAlign="center" allowSort="true" align="right">
		   对手方简称
			</div>
            <div field="VC_CTRPTYACCT" headerAlign="center" allowSort="true" align="right">
		  对手方账号
            </div>
            <div field="VC_BIZTPCD" headerAlign="center" allowSort="true" align="right">
		  业务类别编号
             </div>
             <div field="VC_BIZTP" headerAlign="center" allowSort="true" align="right">
		  业务类别描述
             </div>
             <div field="VC_TXDRCTN" headerAlign="center" allowSort="true" align="right">
		  交易方向描述
             </div>
             <div field="VC_CSHSTTLEMDRCTN" headerAlign="center" allowSort="true" align="right" width="105px">
		  现金了结方向描述
             </div>
             <div field="VC_CONFDCSHDRCTN" headerAlign="center"  allowSort="true" align="right">
                          预发行净额结算DVP被确认款方向描述
             </div>
             <div field="VC_FRSTLEGCD" headerAlign="center"  allowSort="true" align="right" width="105px">
                           首次结算方式代码
             </div>
             <div field="VC_FRSTLEG" headerAlign="center"  allowSort="true" align="right">
                           首次结算方式符号描述
             </div>
             <div field="VC_FRSTLEGINCHIN" headerAlign="center"  allowSort="true" align="right">
                           首次结算方式中文描述
             </div>
             <div field="VC_SCNDLEGCD" headerAlign="center"  allowSort="true" align="right" width="105px">
                           到期结算方式代码
             </div>
             <div field="VC_SCNDLEG" headerAlign="center"  allowSort="true" align="right">
                           到期结算方式符号描述
             </div>
             <div field="VC_SCNDLEGINCHIN" headerAlign="center"  allowSort="true" align="right">
                           到期结算方式中文描述
             </div>
             <div field="VC_FRSTDLVRYDT" headerAlign="center"  allowSort="true" align="right">
                           首次交割日
             </div>
             <div field="VC_SCNDDLVRYDT" headerAlign="center"  allowSort="true" align="right">
                           到期交割日/远期交割成交日
             </div>
             <div field="VC_FRSTSTTLEMVAL" headerAlign="center"  allowSort="true" align="right"  width="160px">
                           首期资金清算额/净价金额/融资解押返还资金额(含融资利息)/BEPS调增、调减额度/BEPS置换换入额度
             </div>
             <div field="VC_CSHSTTLEMVAL" headerAlign="center"  allowSort="true" align="right" width="105px">
                           现金了结交割金额
             </div>
             <div field="VC_MRGNBLCKGVAL" headerAlign="center"  allowSort="true" align="right">
                           保证金冻结金额
             </div>
             <div field="VC_MRGNUNBLCKGVAL" headerAlign="center"  allowSort="true" align="right">
                           保证金解冻金额
             </div>
             <div field="VC_SCNDSTTLEMVAL" headerAlign="center"  allowSort="true" align="right"  width="160px">
                           到期资金清算额/全价金额/融资解押融资利息/融资质押起点金额/BEPS置换换出额度
             </div>
             <div field="VC_FRSTLEGPRIC" headerAlign="center"  allowSort="true" align="right" width="110px">
                           首次结算价格/净价
             </div>
             <div field="VC_SCNDLEGPRIC" headerAlign="center"  allowSort="true" align="right" width="110px">
                           到期结算价格/全价
             </div>
             <div field="VC_TTLFACEAMT" headerAlign="center"  allowSort="true" align="right">
                           债券面额合计
             </div>
             <div field="VC_TXID" headerAlign="center"  allowSort="true" align="right">
                           业务标识号
             </div>
             <div field="VC_REPORATE" headerAlign="center"  allowSort="true" align="right">
                           回购年利率
             </div>
             <div field="VC_OVRDUEDAYS" headerAlign="center"  allowSort="true" align="right">
                           逾期天数/融资解押资金使用天数
             </div>
             <div field="VC_SCTIESLNDGTERM" headerAlign="center"  allowSort="true" align="right">
                           质押融券期限
             </div>
             <div field="VC_ORGTRGRTETPCD" headerAlign="center"  allowSort="true" align="right">
                           发令方保证方式
             </div>
             <div field="VC_MRGNBLCKGIND" headerAlign="center"  allowSort="true" align="right">
                           保证金冻结成功失败标志
             </div>
             <div field="VC_MRGNUNBLCKGIND" headerAlign="center"  allowSort="true" align="right">
                           保证金解冻成功失败标志
             </div>
             <div field="VC_ORGTRGRTETP" headerAlign="center"  allowSort="true" align="right">
                           发令方保证方式描述
             </div>
             <div field="VC_CNTRPTYGRTETPCD" headerAlign="center"  allowSort="true" align="right">
                           对手方保证方式
             </div>
             <div field="VC_COLLSBSTITNIND" headerAlign="center"  allowSort="true" align="right">
                           是否允许替换质押品
             </div>
             <div field="VC_CNTRPTYGRTETP" headerAlign="center"  allowSort="true" align="right">
                           对手方保证方式描述
             </div>
             <div field="VC_ORGTRGRTEBDSEQNB" headerAlign="center"  allowSort="true" align="right">
                           发令方保证券债券序号
             </div>
             <div field="VC_ORGTRGRTEBDID" headerAlign="center"  allowSort="true" align="right">
                           发令方保证券债券代码
             </div>
             <div field="VC_ORGTRGRTEBDSHRTNM" headerAlign="center"  allowSort="true" align="right">
                           发令方保证券债券简称
             </div>
             <div field="VC_ORGTRGRTEBDFACEAMT" headerAlign="center"  allowSort="true" align="right">
                           发令方保证券债券面额
             </div>
             <div field="VC_OTCBUYGFACEAMT" headerAlign="center"  allowSort="true" align="right">
                           柜台专项结算买入面额
             </div>
             <div field="VC_ORGTRGRTEMRGN" headerAlign="center"  allowSort="true" align="right">
                           发令方保证金
             </div>
             <div field="VC_OTCBUYGVAL" headerAlign="center"  allowSort="true" align="right">
                           柜台专项结算买入金额
             </div>
             <div field="VC_CTRPTYGRTEBDSEQNB" headerAlign="center"  allowSort="true" align="right">
                           对手方保证券债券序号
             </div>
             <div field="VC_CNTRPTYGRTEBDID" headerAlign="center"  allowSort="true" align="right">
                           对手方保证券债券代码
             </div>
             <div field="VC_CNTRPTYGRTEBDSHRTNM" headerAlign="center"  allowSort="true" align="right">
                           对手方保证券债券简称
             </div>
             <div field="VC_CNTRPTYGRTEBDFACEAMT" headerAlign="center"  allowSort="true" align="right">
                           对手方保证券债券面额
             </div>
             <div field="VC_OTCSELLGFACEAMT" headerAlign="center"  allowSort="true" align="right">
                           柜台专项结算卖出面额
             </div>
             <div field="VC_CNTRPTYCSHCOLL" headerAlign="center"  allowSort="true" align="right">
                           对手方保证金
             </div>
             <div field="VC_OTCSELLGVAL" headerAlign="center"  allowSort="true" align="right">
                           柜台专项结算卖出金额
             </div>
             <div field="VC_CROSSTRFAPLT" headerAlign="center"  allowSort="true" align="right">
                           转托管申请人
             </div>
             <div field="VC_ORGNLCTRCTID" headerAlign="center"  allowSort="true" align="right">
                           对应合同号
             </div>
             <div field="VC_ORGNLINSTRID" headerAlign="center"  allowSort="true" align="right">
                           对应指令号
             </div>
             <div field="VC_TRANSFEREEID" headerAlign="center"  allowSort="true" align="right">
                           转入方账号
             </div>
             <div field="VC_TRANSFERORID" headerAlign="center"  allowSort="true" align="right">
                           转出方账号
             </div>
             <div field="VC_OPRTR" headerAlign="center"  allowSort="true" align="right">
                           操作员
             </div>
             <div field="VC_CHCKER" headerAlign="center"  allowSort="true" align="right">
                           复核员
             </div>
             <div field="VC_CNFRMOR" headerAlign="center"  allowSort="true" align="right">
                           确认员
             </div>
             <div field="VC_INSTRACCPTTM" headerAlign="center"  allowSort="true" align="right">
                           指令接收时间
             </div>
             <div field="VC_INSTRCHCKTM" headerAlign="center"  allowSort="true" align="right">
                           指令复核时间
             </div>
             <div field="VC_INSTRCNFRMTM" headerAlign="center"  allowSort="true" align="right">
                           指令确认时间
             </div>
             <div field="VC_INSTRSTSCD" headerAlign="center"  allowSort="true" align="right">
		   指令状态
             </div>
             <div field="VC_INSTRSTS" headerAlign="center"  allowSort="true" align="right">
		   指令状态描述
             </div>
             <div field="VC_LASTUPDTM" headerAlign="center"  allowSort="true" align="right">
		   最近更新时间
             </div>
             <div field="VC_GVRCSHLCTNCD" headerAlign="center"  allowSort="true" align="right">
		   付券方保证金保管地
             </div>
             <div field="VC_GVRCSHLCTN" headerAlign="center"  allowSort="true" align="right">
	  	   付券方保证金保管地描述
             </div>
             <div field="VC_TAKERCSHLCTNCD" headerAlign="center"  allowSort="true" align="right">
		    收券方保证金保管地
             </div>
             <div field="VC_TAKERCSHLCTN" headerAlign="center"  allowSort="true" align="right">
		    收券方保证金保管地描述
             </div>
             <div field="VC_COLLMDLCD" headerAlign="center"  allowSort="true" align="right">
		    担保模式代码
             </div>
             <div field="VC_COLLMDL" headerAlign="center"  allowSort="true" align="right">
		    担保模式描述
             </div>
          </div>
        </div>
  	</div>
	<%-- 结算指令下载列表结束!!! --%> 	
	
<script type="text/javascript">
    nui.parse();
    var datagrid_JSZLXZ = nui.get("datagrid_JSZLXZ");
    var form = new nui.Form("#form_JSZLXZ");
	var json = form.getData(false,false);
	datagrid_JSZLXZ.load(json);//grid查询
	
	function search_JSZLXZ(){
	    search(datagrid_JSZLXZ, "#form_JSZLXZ");
	}
	//全屏显示
	function fullScreen(){
		window.open('<%=request.getContextPath()%>/sm/comm/back_stage_trader/bst_jszlxz_detail.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
	//刷新
	//“今日待处理”模块自动刷新功能处理
    var autoRefreshReturnVal;//自动刷新定时器返回值（使用该值关闭之前的定时器）
    var autoRefreshValOld;//历史自动刷新时间
    function autoRefreshFun(){
    	search_JSZLXZ();//同时刷新查询列表数据
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