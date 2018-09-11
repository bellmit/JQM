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
<title>询价结果</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<style type="text/css">
    	   #table tr th{
    	      font-weight: inherit;
    	   }
    	   
	.row_input {
	    background-position: 6px 50%;
	    background-repeat: no-repeat;
	    height:18px;
	    font-size: 9pt;
	}
    	</style>
    	<style type="text/css">
    	.mini-tabs-bodys{
    		border: 0px;
    	}
    	.mini-layout-region{
    		border-left: 0px;
    		border-right: 0px;
    		border-bottom: 0px;
    	}
    	.mini-panel-border{
    		border-left: 0px;
    		border-right: 0px;
    	}
    </style> 
    </head>
    <!-- 权限标签 -->
    
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
                            <input  class="nui-textbox"  name="criteria/_expr[2]/enExistLimite" id="vcStockName" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[2]/_op" value="=">
                        </td>
                          
                      	<td style="width:80px" align="right">
							证券名称:
		                </td>
                         <td style="width:20%" align="left">
                            <input  class="nui-textbox"  name="criteria/_expr[2]/enExistLimite" id="vcStockName" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[2]/_op" value="=">
                        </td>
                    </tr>
                    <tr>
                         <td style="width:80px" colspan="2">
					       <a id="query" class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
					                        重置
					       </a>                        
					     </td>  
                        <td colspan="2">
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
                             <a class='nui-button' plain='false' id="push" iconCls='icon-search' onclick='pushToO32()'>推送至O32</a>
                        </td>
                    </tr>
                </table>
            </div>
	<div id="layout1" class="mini-layout" style="width:100%; height:87%;"  borderStyle="border:solid 1px #aaa;"> 
		<div title="center" region="center"  >
     <div class="nui-fit">
         <div id="datagrid1"
			dataField="inquirys"
			class="nui-datagrid"
			style="width:100%;height:100%"
			url="com.cjhxfund.ats.ipo.enterOrder.queryInquiryWithPermissions.biz.ext"
			pageSize="20" showPageInfo="true" multiSelect="true" 
			onselectionchanged="selectionChanged">
             <div property="columns" >
                 <div type="indexcolumn"></div>
                 <div type="checkcolumn"></div>
                 <div field="vcPurchaseCode" headerAlign="center"  width="8%" allowSort="true" > 证券代码 </div>
                 <div field="vcCompanyName" headerAlign="center" width="12%" allowSort="true"> 证券名称 </div>
                 <div field="vcProductNo" headerAlign="center" width="8%" allowSort="true">产品代码</div>
                 <div field="vcProductName" headerAlign="center" width="20%" allowSort="true">产品名称</div>
                 <div field="vcCombiNo" headerAlign="center" width="8%" allowSort="true">组合代码</div>
                 <div field="vcCombiName" headerAlign="center" width="7%" allowSort="true">组合名称</div>
                 <div field="enEnterPrice" headerAlign="center" width="7%" align="right" allowSort="true">入围价格(元)</div>
                 <div field="enEnterAmount" headerAlign="center" width="7%" align="right" allowSort="true">入围数量(万股)</div>
                 <div field="enEnterMoney" headerAlign="center" width="7%" align="right" allowSort="true">申购金额(万元)</div>
                 <div field="lOfflinePurchaseDate" headerAlign="center" width="7%" align="right" allowSort="true">申购截止日</div>
                 <div field="cOrderStatus" headerAlign="center" width="7%" align="center" allowSort="true" renderer="rendercOrderStatus">指令/建议状态</div>
             </div>
             </div>
         </div>
     </div>
        <script type="text/javascript">
            nui.parse();
            var grid = nui.get("datagrid1");
		 	grid.load();
		 	
		 	/****
			*
			* 函数名：rendercOrderStatus
			* 机   能：字典类型处理
			* 输   入：e 当前对象
			* 输   出: 无
			* 日   期：2017-06-06
			* 作   者： 
			*
			*****/		
			function rendercOrderStatus(e) {
				if(e.value == "0"){
					return "未处理";
				}
				
				if(e.value == "2"){
					return "已生成";
				}
				
				if(e.value == "3"){
					return "已推送";
				}
				
				if(e.value == "4"){
					return "推送失败";
				}
			}
          </script>
     </body>
</html>