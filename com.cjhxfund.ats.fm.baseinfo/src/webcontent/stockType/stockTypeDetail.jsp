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
                        <td align="right"  width="120">
						 杂项分类名称:
		                </td>
		                <td align="left"  width="20%">
							 <input  class="nui-textbox"  name="map/dictname"
                             id="dictname" width="100%"/>
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
			url="com.cjhxfund.ats.fm.baseinfo.stockTypeManager.queryStockTypeDetail.biz.ext?map/dicttypeid=StockTypeDetail"
			dataField="data" multiSelect="true" pageSize="20"  sortField="DICTID" sortOrder="desc">

                <div property="columns" >
				<div type="indexcolumn" width="10"></div>
                    <div type="checkcolumn"  width="10">
                    </div>
                    <div field="DICTID" headerAlign="left"  width="30" allowSort="true" >
                                                                                       杂项分类ID
                    </div>
                    <div field="DICTNAME" headerAlign="left" allowSort="true" >
                                                                                      杂项分类名称
                    </div>
                    <div field="STATUS" align="right"headerAlign="center" visible="false"allowSort="true" >
                                                                                      状态
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
             //查询
           function search() {
              var form = new nui.Form("#form1");              
              var json = form.getData(false,false);
              grid.load(json);//grid查询
            }
    </script>
</body>
</html>