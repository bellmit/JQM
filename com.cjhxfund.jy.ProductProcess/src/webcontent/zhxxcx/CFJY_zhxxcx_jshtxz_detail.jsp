<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): 冯君培
- Date: 2016-12-21 16:35:39
- Description: 结算合同下载
--%>
<head>
<title>结算合同下载</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
  <div class="search-condition">
	 <div class="list">
		<form id="form_JSHTXZ" method="post" >
			<%-- 查询类型 --%>
			<input class="nui-hidden" name="paramObject/queryType" value="JSHTXZ">
			
			<table id="table1" class="table" style="height:100%;table-layout:fixed;">
				<tr>
					<td class="form_label" width="10%" align="right">
					付券方简称:
					</td>
					<td colspan="1" width="20%">
						<input id="vcBdgvrnm_JSHTXZ" class="nui-textbox" name="paramObject/vcBdgvrnm"/>
					</td>
					<td class="form_label" width="10%" align="right">
					收券方简称:
					</td>
					<td colspan="1" width="20%">
						<input id="vcBdtakernm_JSHTXZ" class="nui-textbox"  name="paramObject/vcBdtakernm" />
					</td>
					<td class="form_label" width="10%" align="right">
					业务类别描述:
					</td>
					<td colspan="1" width="20%">
						<input id="vcBiztp_JSHTXZ" class="nui-textbox"  name="paramObject/vcBiztp" />
					</td>
					<td colspan="1" width="40%" align="left">
						<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_JSHTXZ()"/>
					</td>
				</tr>
				<tr>
					
					<td class="form_label" width="20%" align="right">
					交割日:
					</td>
					<td colspan="1" width="10%">
						<input id="vcDlvrydt_JSHTXZ"  class="nui-datepicker"  name="paramObject/vcDlvrydt" />
					</td>
					<td class="form_label" width="10%" align="right">
					资金状态描述:
					</td>
					<td colspan="1" width="20%">
						<input id="vcCshsts_JSHTXZ" class="nui-textbox" name="paramObject/vcCshsts"/>
					</td>
					<td   class="form_label" width="8%" align="right">
					合同状态描述:
					</td>
					<td colspan="1" width="20%">
						<input id="vcCtrctsts_JSHTXZ" class="nui-textbox" name="paramObject/vcCtrctsts"/>
					</td>
				</tr>
			</table>
		</form>
	  </div>
	</div>		
	<%-- 结算合同下载列表开始!!! --%> 	
	<div class="nui-fit">
		<div 
		    id="datagrid_JSHTXZ"
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
			<div field="VC_CTRCTID" name="taskname" headerAlign="center" allowSort="true" align="left" width="130px">
                                                合同编号
			</div>
			<div field="VC_INSTRORGNACCT" headerAlign="center" allowSort="true" align="left" width="150px">
                                                指令/建议来源账号
			</div>
			<div field="VC_BDGVRACCT" headerAlign="center" allowSort="true" align="right" width="150px">
                                                付券方账号
 			</div>
			<div field="VC_ACCTWTHDVPNETGCONFD" headerAlign="center" allowSort="true" align="right">
				预发行净额结算DVP被确认账号
			</div>
			<div field="VC_ACCTWTHMRGNBLCKGCONFD" headerAlign="center" allowSort="true" align="right">
				保证金冻结确认被确认账号
			</div>
			<div field="VC_ACCTWHTMRGNUNBLCKGCONFD" headerAlign="center" allowSort="true" align="right">
				保证金解冻确认被确认账号
			</div>
			<div field="VC_BDGVRNM" headerAlign="center" allowSort="true" align="right">
				付券方简称
			</div>
			<div field="VC_BDGVRSUBACCT" headerAlign="center" allowSort="true" align="right">
				付券方分组合号
			</div>
			<div field="VC_BDGVRSUBNM" headerAlign="center" allowSort="true" align="right">
				付券方分组合简称
			</div>
            <div field="VC_BDTAKERACCT" headerAlign="center" allowSort="true" align="right">
				收券方账号
            </div>
            <div field="VC_BDTAKERNM" headerAlign="center" allowSort="true" align="right">
				收券方简称
             </div>
             <div field="VC_BDTAKERSUBACCT" headerAlign="center" allowSort="true" align="right">
				收券方分组合号
             </div>
             <div field="VC_BDTAKESUBRNM" headerAlign="center" allowSort="true" align="right">
				收券方分组合简称
             </div>
             <div field="VC_TXID" headerAlign="center" allowSort="true" align="right">
				业务标识号
             </div>
             <div field="VC_BIZTPCD" headerAlign="center"  allowSort="true" align="right">
				业务类别编号            
			 </div>
             <div field="VC_BIZTP" headerAlign="center"  allowSort="true" align="right">
				业务类别描述
             </div>
             <div field="VC_STTLMTPCD" headerAlign="center"  allowSort="true" align="right">
				结算方式代码
             </div>
             <div field="VC_STTLMTP" headerAlign="center"  allowSort="true" align="right">
				结算方式符号描述
             </div>
             <div field="VC_STTLMTPINCHIN" headerAlign="center"  allowSort="true" align="right">
				结算方式中文描述
             </div>
             <div field="VC_BDGVRGRTEBDID" headerAlign="center"  allowSort="true" align="right">
				付券方保证券债券代码
             </div>
             <div field="VC_BDGVRGRTEBDSHRTNM" headerAlign="center"  allowSort="true" align="right">
				付券方保证券债券简称
             </div>
             <div field="VC_BDGVRGRTEBDFACEAMT" headerAlign="center"  allowSort="true" align="right">
				付券方保证券债券面额
             </div>
             <div field="VC_OTCBUYGFACEAMT" headerAlign="center"  allowSort="true" align="right">
				柜台专项结算买入面额
             </div>
             <div field="VC_BDGVRCSHCOLL" headerAlign="center"  allowSort="true" align="right">
				付券方保证金/融资质押实际融资金额/BEPS质押增加待分配额度/BEPS置换换入额度
             </div>
             <div field="VC_OTCBUYGVAL" headerAlign="center"  allowSort="true" align="right">
				柜台专项结算买入金额
             </div>
             <div field="VC_BDTAKERGRTEBDID" headerAlign="center"  allowSort="true" align="right">
				收券方保证券债券代码
             </div>
             <div field="VC_BDTAKERGRTEBDSHRTNM" headerAlign="center"  allowSort="true" align="right">
				收券方保证券债券简称
             </div>
             <div field="VC_BDTAKERGRTEBDFACEAMT" headerAlign="center"  allowSort="true" align="right">
				收券方保证券债券面额
             </div>
             <div field="VC_OTCSELLGVAL" headerAlign="center"  allowSort="true" align="right">
				柜台专项结算卖出金额
             </div>
             <div field="VC_BDTAKERCSHCOLL" headerAlign="center"  allowSort="true" align="right">
				收券方保证金/融资质押起点金额/BEPS置换换出额度
             </div>
             <div field="VC_OTCSELLGFACEAMT" headerAlign="center"  allowSort="true" align="right">
				柜台专项结算卖出面额
             </div>
             <div field="VC_BLCKGPMTVAL" headerAlign="center"  allowSort="true" align="right">
				冻结缴款金额
             </div>
             <div field="VC_BDCNT" headerAlign="center"  allowSort="true" align="right">
				债券数目
             </div>
             <div field="VC_TTLFACEAMT" headerAlign="center"  allowSort="true" align="right">
				债券总额
             </div>
             <div field="VC_CTRCTVAL" headerAlign="center"  allowSort="true" align="right">
				合同金额/BEPS调增、调减额度
             </div>
             <div field="VC_SCTIESLNDGFEES" headerAlign="center"  allowSort="true" align="right">
				借贷业务融券费用
             </div>
             <div field="VC_RATE" headerAlign="center"  allowSort="true" align="right">
				回购利率
             </div>
             <div field="VC_DLVRYDT" headerAlign="center"  allowSort="true" align="right">
				交割日
             </div>
             <div field="VC_INSTRIDTOCTRCT" headerAlign="center"  allowSort="true" align="right">
				生成合同的指令/建议编号
             </div>
             <div field="VC_ORGNLCTRCTID" headerAlign="center"  allowSort="true" align="right">
				原合同编号(期调、券置换、撤销合同时使用)
             </div>
             <div field="VC_ORGNLINSTRID" headerAlign="center"  allowSort="true" align="right">
				原指令/建议编号(撤销指令/建议的指令/建议时使用)
             </div>
             <div field="VC_GVRBDSTSCD" headerAlign="center"  allowSort="true" align="right">
				付券方券状态
             </div>
             <div field="VC_GVRBDSTS" headerAlign="center"  allowSort="true" align="right">
				付券方券状态描述
             </div>
             <div field="VC_GVRGRTEBDSTSCD" headerAlign="center"  allowSort="true" align="right">
				付券方保证券状态
             </div>
             <div field="VC_GVRGRTEBDSTS" headerAlign="center"  allowSort="true" align="right">
				付券方保证券状态描述
             </div>
             <div field="VC_TAKERBDSTSCD" headerAlign="center"  allowSort="true" align="right">
				收券方券状态
             </div>
             <div field="VC_TAKERBDSTS" headerAlign="center"  allowSort="true" align="right">
				收券方券状态描述
             </div>
             <div field="VC_TAKERGRTEBDSTSCD" headerAlign="center"  allowSort="true" align="right">
				收券方保证券状态
             </div>
             <div field="VC_TAKERGRTEBD" headerAlign="center"  allowSort="true" align="right">
				收券方保证券状态描述
             </div>
             <div field="VC_CSHSTSCD" headerAlign="center"  allowSort="true" align="right">
				资金状态
             </div>
             <div field="VC_CSHSTS" headerAlign="center"  allowSort="true" align="right">
				资金状态描述
             </div>
             <div field="VC_BLCKDSTSCD" headerAlign="center"  allowSort="true" align="right">
				冻结状态
             </div>
             <div field="VC_BLCKDSTS" headerAlign="center"  allowSort="true" align="right">
				冻结状态描述
             </div>
             <div field="VC_EXCTDTM" headerAlign="center"  allowSort="true" align="right">
				过户时间/失败时间
             </div>
             <div field="VC_CTRCTSTSCD" headerAlign="center"  allowSort="true" align="right">
				合同状态
             </div>
             <div field="VC_CTRCTSTS" headerAlign="center"  allowSort="true" align="right">
				合同状态描述
             </div>
             <div field="VC_CTRCTCRETM" headerAlign="center"  allowSort="true" align="right">
				合同生成时间
             </div>
             <div field="VC_LASTUPDTM" headerAlign="center"  allowSort="true" align="right">
				最近更新时间
             </div>
             <div field="VC_BDGVRCSHCOLLSTSCD" headerAlign="center"  allowSort="true" align="right">
				付券方保证金状态
             </div>
             <div field="VC_BDGVRCSHCOLLSTS" headerAlign="center"  allowSort="true" align="right">
				付券方保证金状态描述
             </div>
             <div field="VC_BDTAKERCSHCOLLSTSCD" headerAlign="center"  allowSort="true" align="right">
				收券方保证金状态
             </div>
             <div field="VC_BDTAKERCSHCOLLSTS" headerAlign="center"  allowSort="true" align="right">
				收券方保证金状态描述
             </div>
             <div field="VC_BDGVRCSHLCTNCD" headerAlign="center"  allowSort="true" align="right">
				付券方保证金保管地
             </div>
             <div field="VC_BDGVRCSHLCTN" headerAlign="center"  allowSort="true" align="right">
				付券方保证金保管地描述
             </div>
             <div field="VC_BDTAKERCSHLCTNCD" headerAlign="center"  allowSort="true" align="right">
				收券方保证金保管地
             </div>
             <div field="VC_BDTAKERCSHLCTN" headerAlign="center"  allowSort="true" align="right">
				收券方保证金保管地描述
             </div>
          </div>
        </div>
  	</div>
	<%-- 结算合同下载列表结束!!! --%> 	
	
<script type="text/javascript">
    nui.parse();
    var datagrid_JSHTXZ = nui.get("datagrid_JSHTXZ");
    var form = new nui.Form("#form_JSHTXZ");
	var json = form.getData(false,false);
	datagrid_JSHTXZ.load(json);//grid查询
	
	function search_JSHTXZ(){
	    search(datagrid_JSHTXZ, "#form_JSHTXZ");
	}
	
</script>
</body>
</html>