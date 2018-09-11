<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 黄燕
  - Date: 2016-10-14 17:24:16
  - Description:
-->
<head>
<title>O32的证券类别</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
	
    
</head>
<body>

	<div class="search-condition">
		  <div class="list">
            <div id="form1" class="nui-form"  align="center" >
                <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                    <tr>
                        <td align="right" width="120">
						 证券类别名称:
		                </td>
		                <td align="left"  width="20%">
							 <input  class="nui-textbox"  name="map/vcStocktypeName"
                             id="vcStocktypeName" width="100%"/>
                        </td>
                        
                        <td align="left">
					       <a id="query" class='nui-button' plain='false' iconCls="icon-search" onclick="search()">
					                        查询
					       </a>                        
                            <span>&nbsp;</span>
					       <a id="query" class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
					                        重置
					       </a>                        
					    </td>
                    </tr>
                </table>
            </div>
           </div>
         </div>

	<div class="nui-fit">
		    <div id="datagrid1" class="nui-datagrid"
			style="width: 100%;height: 100%;"  allowResize="false"
			url="com.cjhxfund.ats.fm.baseinfo.stockTypeManager.queryStockType.biz.ext"
			dataField="stockTypes" multiSelect="true" pageSize="20" sortField="cMarketNo">
		
                <div property="columns" >
				<div type="indexcolumn"></div>
                    <div type="checkcolumn">
                    </div>
                    <div field="cStockType" headerAlign="center" width="50" allowSort="true" >
                                                                                       证券类别ID
                    </div>
                    <div field="vcMarketName" headerAlign="center" width="100"allowSort="true" >
                                                                                      交易市场
                    </div>
                    <div field="cAssetClassName" headerAlign="center" width="100"allowSort="true" >
                                                                                      资产类别
                    </div>
                    <div field="vcStocktypeName" headerAlign="center" width="150"allowSort="true" >
                                                                                      证券类别名称
                    </div>
                    <div field="lBuyUnit" headerAlign="center" align="right" visible="false" allowSort="true" >
                                                                                       买入最小单位
                    </div>
                    <div field="lSaleUnit" headerAlign="center" align="right" visible="false" allowSort="true" >
                                                                                      卖出最小单位
                    </div>
                    <div field="lBuyMax" headerAlign="center" align="right" visible="false" allowSort="true" >
                                                                                       买入最大单位
                    </div>
                    <div field="lSaleMax" headerAlign="center" align="right" visible="false" allowSort="true" >
                                                                                      卖出最大单位
                    </div>
                    <div field="enFaceValues" headerAlign="center" align="right" visible="false" allowSort="true" >
                                                                                      面值
                    </div>
                </div>
            </div>
     </div>  
	<script type="text/javascript">
    	nui.parse();
        var grid = nui.get("datagrid1");
        grid.load();
        //重置查询条件
            function reset(){
               var form = new nui.Form("#form1");//将普通form转为nui的form
               form.reset();
               var json = form.getData(false,false);
               grid.load(json);//grid查询
            }
           function search() {
              var form = new nui.Form("#form1");              
              var json = form.getData(false,false);
              grid.load(json);//grid查询
            }
    </script>
</body>
</html>