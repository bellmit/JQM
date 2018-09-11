<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@include file="/common/js/commscripts.jsp" %>
<%--
- Author(s): 杨敏
- Date: 2016-01-25 17:40:16
- Description:
    --%>
    <head>
        <title>
            一级债券信息查询
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        
	    <%--  --%>
	    
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
    </head>
    <!-- 权限标签 -->
    
    <body style="width:99.6%;height:99.6%;overflow: hidden;">
     <%--<div id="tabs" class="nui-tabs" style="width: 100%;height: 100%;">--%>
        <%--<div title="申购缴款(非可转债)">--%>
        <div class="search-condition">
		  <div class="list">
            <div id="form1" class="nui-form"  align="center" >
                <!-- 数据实体的名称 -->
                
                <input class="nui-hidden" type="hidden" name="queryUserType" value="<%=request.getParameter("queryUserType") %>"/>
                <!-- 排序字段 -->
                <!-- <input class="nui-hidden" type="hidden" name="criteria/_orderby[1]/_sort" value="desc" />
                <input class="nui-hidden" type="hidden" name="criteria/_orderby[1]/_property" value="processDate" /> -->
                <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                    <tr>
                        <td align="right"  width="120px">
						债券类别:
		                </td>
		                <td align="left"  width="20%">
							 <input  class="nui-textbox"  name="criteria/_expr[1]/vcStockType"
                             id="vcStockType" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[1]/_op" value="like">
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[1]/_likeRule" value="all">
                        </td>
                        <td align="right"  width="90px">
						债券类别名称:
		                </td>
                         <td align="left"  width="20%">
							 <input  class="nui-textbox"  name="criteria/_expr[2]/vcStocktypeName"
                             id="vcStocktypeName" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[2]/_op" value="like">
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[2]/_likeRule" value="all">
                        </td>
                        
                        <td width="40%" align="left">
					       <a id="query" class='nui-button' plain='false' iconCls="icon-search" onclick="search()">
					                        查询
					       </a>                        
                            <span>&nbsp;</span>
					       <a id="query" class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
					                        重置
					       </a>                        
					    </td>
                    </tr>
                    <!-- vcStockType
						vcStocktypeName
						vcParentStockType
						lLevel
						lIsLeaf
						lOrderId -->
                </table>
            </div>
           </div>
         </div>   

		<div class="nui-fit">
			<div id="datagrid1" dataField="stockTypeDefines"  class="nui-datagrid"
			style="width: 100%;height: 100%;"  allowResize="false"
			url="com.cjhxfund.ats.fm.baseinfo.stockTypeManager.queryStockTypeDefine.biz.ext"
			dataField="stockTypes" multiSelect="true" pageSize="20" sortField="lOrderId" >
                <div property="columns" >
				<div type="indexcolumn"></div>
                    <div type="checkcolumn">
                    </div>
                    <div field="vcStockType" headerAlign="center" width="60" align="center" allowSort="true" >
                                                                                       债券类别
                    </div>
                    <div field="vcStocktypeName" headerAlign="center" width="170" align="center" allowSort="true" >
                                                                                       债券类别名称
                    </div>
                    <div field="vcParentStockType" headerAlign="center" width="150"  align="center" allowSort="true" >
                       	  父节点
                    </div>
                    <div field="lIsLeaf" headerAlign="center" align="center" allowSort="true"  renderer="renderLIsLeaf">
                                                                                       是否子节点
                    </div>
                    <div field="lOrderId" headerAlign="center" align="center" allowSort="true" >
                                                                                       排序
                    </div>
        		
                </div>
            </div>
     </div>    
        <script type="text/javascript">
            nui.parse();
            var grid = nui.get("datagrid1");
			
			//给业务日期查询条件赋值
			
            var formData = new nui.Form("#form1").getData(false,false);
            grid.load(formData);//加载列表数据
            
			
			//渲染行对象
			 grid.on("drawcell", function (e) {
	            var record = e.record,
		        column = e.column,
		        row=e.row;
		        
		        /*field = e.field,
		        value = e.value;*/
		        //action列，超连接操作按钮
		       /*if (column.name == "action") {
		            e.cellStyle = "text-align:left";
		            e.cellHtml = "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='add(\"" + grid.indexOf(row) + "\")'>申购</a>&nbsp;"
								+"<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;' onclick='details()'>详情</a>&nbsp;";
								//lAttchCount
								//显示附件图标
								if( row.lAttchCount >0){
									e.cellHtml +="<img style='vertical-align:middle;' height='12px' src='<%=request.getContextPath() %>/fm/comm/img/fujian.png'>";
								}
								
		        
		        }*/
		        //设置行样式
		        if (record.gender == 1) {
		            e.rowCls = "myrow";
		        }

        	});
        	 function renderLIsLeaf(e){
             	if(e.value=="1"){
             		return "是";
             	}else{
             	
             	}
             	return "否";
             }
        	 //查询
           function search() {
              var form = new nui.Form("#form1");
              
              var json = form.getData(false,false);
              grid.load(json);//grid查询
            }
	        //重置查询条件
            function reset(){
               var form = new nui.Form("#form1");//将普通form转为nui的form
               form.reset();
               var json = form.getData(false,false);
               grid.load(json);//grid查询
            }
	       
          </script>
     </body>
</html>