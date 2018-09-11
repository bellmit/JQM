<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): 冯君培
- Date: 2016-12-21 16:35:39
- Description: 结算指令/建议下载
--%>
<head>
<title>结算指令/建议下载</title>
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
					<td class="form_label" width="10%" align="right">
					客户简称:
					</td>
					<td colspan="1" width="20%">
						<input id="vcOrgtrnm_JSZLXZ" class="nui-textbox" name="paramObject/vcOrgtrnm"/>
					</td>
					<td class="form_label" width="10%" align="right">
					对手方简称:
					</td>
					<td colspan="1" width="20%">
						<input id="vcCtrptynm_JSZLXZ" class="nui-textbox"  name="paramObject/vcCtrptynm" />
					</td>
					<td class="form_label" width="10%" align="right">
					业务类别描述:
					</td>
					<td colspan="1" width="20%">
						<input id="vcBiztp_JSZLXZ" class="nui-textbox"  name="paramObject/vcBiztp" />
					</td>
					<td colspan="1" width="40%" align="left">
						<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_JSZLXZ()"/>
					</td>
				</tr>
				<tr>
					
					<td class="form_label" width="20%" align="right">
					指令/建议状态描述:
					</td>
					<td colspan="1" width="10%">
						<input id="vcInstrsts_JSZLXZ" class="nui-textbox"  name="paramObject/vcInstrsts" />
					</td>
					<td class="form_label" width="10%" align="right">
					首次交割日:
					</td>
					<td colspan="1" width="20%">
						<input id="vcFrstdlvrydt_JSZLXZ" class="nui-datepicker" name="paramObject/vcFrstdlvrydt"/>
					</td>
					<td   class="form_label" width="8%" align="right">
					到期交割日/远期交割成交日:
					</td>
					<td colspan="1" width="20%">
						<input id="vcScnddlvrydt_JSZLXZ" class="nui-datepicker" name="paramObject/vcScnddlvrydt"/>
					</td>
				</tr>
			</table>
		</form>
	  </div>
	</div>		
	<%-- 结算指令/建议下载列表开始!!! --%> 	
	<div class="nui-fit">
		<div 
		    id="datagrid_JSZLXZ"
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
			<div field="VC_INSTRID" name="taskname" headerAlign="center" allowSort="true" align="left" width="130px">
                            指令/建议编号
			</div>
			<div field="VC_ORGTRNM" headerAlign="center" allowSort="true" align="left" width="150px">
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
             <div field="VC_CSHSTTLEMDRCTN" headerAlign="center" allowSort="true" align="right">
		  现金了结方向描述
             </div>
             <div field="VC_CONFDCSHDRCTN" headerAlign="center"  allowSort="true" align="right">
                          预发行净额结算DVP被确认款方向描述
             </div>
             <div field="VC_FRSTLEGCD" headerAlign="center"  allowSort="true" align="right">
                           首次结算方式代码
             </div>
             <div field="VC_FRSTLEG" headerAlign="center"  allowSort="true" align="right">
                           首次结算方式符号描述
             </div>
             <div field="VC_FRSTLEGINCHIN" headerAlign="center"  allowSort="true" align="right">
                           首次结算方式中文描述
             </div>
             <div field="VC_SCNDLEGCD" headerAlign="center"  allowSort="true" align="right">
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
             <div field="VC_FRSTSTTLEMVAL" headerAlign="center"  allowSort="true" align="right" width="150px">
                           首期资金清算额/净价金额/融资解押返还资金额(含融资利息)/BEPS调增、调减额度/BEPS置换换入额度
             </div>
             <div field="VC_CSHSTTLEMVAL" headerAlign="center"  allowSort="true" align="right">
                           现金了结交割金额
             </div>
             <div field="VC_MRGNBLCKGVAL" headerAlign="center"  allowSort="true" align="right">
                           保证金冻结金额
             </div>
             <div field="VC_MRGNUNBLCKGVAL" headerAlign="center"  allowSort="true" align="right">
                           保证金解冻金额
             </div>
             <div field="VC_SCNDSTTLEMVAL" headerAlign="center"  allowSort="true" align="right" width="150px">
                           到期资金清算额/全价金额/融资解押融资利息/融资质押起点金额/BEPS置换换出额度
             </div>
             <div field="VC_FRSTLEGPRIC" headerAlign="center"  allowSort="true" align="right">
                           首次结算价格/净价
             </div>
             <div field="VC_SCNDLEGPRIC" headerAlign="center"  allowSort="true" align="right">
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
                           对应指令/建议号
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
                           指令/建议接收时间
             </div>
             <div field="VC_INSTRCHCKTM" headerAlign="center"  allowSort="true" align="right">
                           指令/建议复核时间
             </div>
             <div field="VC_INSTRCNFRMTM" headerAlign="center"  allowSort="true" align="right">
                           指令/建议确认时间
             </div>
             <div field="VC_INSTRSTSCD" headerAlign="center"  allowSort="true" align="right">
		   指令/建议状态
             </div>
             <div field="VC_INSTRSTS" headerAlign="center"  allowSort="true" align="right">
		   指令/建议状态描述
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
	<%-- 结算指令/建议下载列表结束!!! --%> 	
	
<script type="text/javascript">
    nui.parse();
    var datagrid_JSZLXZ = nui.get("datagrid_JSZLXZ");
    var form = new nui.Form("#form_JSZLXZ");
	var json = form.getData(false,false);
	datagrid_JSZLXZ.load(json);//grid查询
	
	function search_JSZLXZ(){
	    search(datagrid_JSZLXZ, "#form_JSZLXZ");
	}
	
</script>
</body>
</html>