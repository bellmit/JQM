<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 谭凯
  - Date: 2017-06-06 17:02:48
  - Description:
-->
<head>
<title>申购指令/建议下达</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
    <body style="width:99.6%;height:99.6%;overflow: hidden;">
        <div class="search-condition">
		  <div class="list">
            <div id="form1" class="nui-form"  align="center" >
                <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                    <tr>
                    	<td style="width:80px" align="right">
                          	  申购截止日期:
                        </td>
                        <td style="width:20%" align="left" colspan="1">
                            <input class="nui-datepicker" id="processDate"  format="yyyy-MM-dd" name="criteria/_expr[1]/lIssueBeginDate" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[1]/_op" value=">=">
                         </td>
                         <td style="width:60px" align="center">至</td>
                         <td style="width:20%" align="left">
                            <input class="nui-datepicker"  id="processDate_stop" format="yyyy-MM-dd" name="criteria/_expr[4]/lIssueBeginDate" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[4]/_op" value="<="/>
                        </td>
                       <td style="width:60px" align="right">
                          	证券代码:
                        </td>
                        <td style="width:20%" align="left">
                            <input  class="nui-textbox"  name="criteria/_expr[2]/enExistLimite"
                             id="vcStockName" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[2]/_op" value="=">
                        </td>
                          
                      	<td style="width:80px" align="right">
							证券名称:
		                </td>
                        
                    </tr>
                    <tr>
                         <td style="width:80px">
					       <a id="query" class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
					                        重置
					       </a>                        
					     </td>  
                        <td >
					       <a id="query" class='nui-button' plain='false' iconCls="icon-search" onclick="search()">
					                        查询
					       </a>                        
					    </td>
                    </tr>
                </table>
            </div>
           </div>
         </div>   
            <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                             <a class='nui-button' plain='false' id="push" iconCls='icon-search' onclick='pushToO32()'>申购指令/建议下达</a>
                        </td>
                    </tr>
                </table>
            </div>
	<div id="layout1" class="mini-layout" style="width:100%; height:87%;"  borderStyle="border:solid 1px #aaa;"> 
		<div title="center" region="center"  >
     <div class="nui-fit">
         <div id="datagrid1"
			dataField="stockissueinfos"
			class="nui-datagrid"
			style="width:100%;height:100%"
			url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryStockIssueInfos.biz.ext"
			pageSize="20" sortField="lIssueBeginDate" sortOrder="desc"
			showPageInfo="true"
			multiSelect="true" 
			onselectionchanged="selectionChanged"
			frozenStartColumn="0" frozenEndColumn="5">

             <div property="columns" >
                 <div type="indexcolumn"></div>
                 <div type="checkcolumn"></div>
                 <div name="action" width="110" headerAlign="center">#</div>
                 <div field="vcStockCode" headerAlign="center" allowSort="true" > 证券代码 </div>
                 <div field="vcStockName" headerAlign="center" allowSort="true" width="150px"> 证券名称 </div>
                 <div field="vcStockNameFull" headerAlign="center" allowSort="true" width="150px">产品代码</div>
                 <div field="lIssueBeginDate" headerAlign="center" allowSort="true" width="100px" renderer="renderBeginDate">产品名称</div>
                 <div field="lPayDate" headerAlign="center" allowSort="true" width="100px" renderer="renderBeginDate">组合代码</div>
                 <div field="dBidLimitTime" headerAlign="center" allowSort="true" width="100px" visible="false">组合名称</div>
                 <div field="vcPaymentPlace" headerAlign="center" allowSort="true" width="80px" align="center" renderer="renderCMarketNo">交易所</div>
                 <div field="vcStocktypeName" headerAlign="center" allowSort="true" width="70px" align="center" >申购价格</div>
                 <div field="enExistLimite" headerAlign="right" align="right"allowSort="true" width="80px" align="right">申购数量(万股)</div>
                 <div field="enIssueBalance" headerAlign="right" align="right" allowSort="true" width="80px">申购金额(万元)</div>
                 <div field="enIssueBalance" headerAlign="right" align="right" allowSort="true" width="80px">申购截止日</div>
             </div>
             </div>
         </div>
     </div>
        <script type="text/javascript">
            nui.parse();
            var grid = nui.get("datagrid1");
		 
          </script>
     </body>
</html>