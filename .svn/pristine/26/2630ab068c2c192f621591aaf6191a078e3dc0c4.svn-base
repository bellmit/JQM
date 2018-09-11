<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 章璐
  - Date: 2017-04-20 09:30:16
  - Description:
-->
<head>
<title>发行主体别名策略</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
	
    
</head>
<body>
			
	<div class="search-condition">
		  <div class="list">
            <div id="form1" class="nui-form"  align="center" >
                <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                    <tr>
                        <td align="right"  width="120">
						 发行主体全称:
		                </td>
		                <td align="left"  width="20%">
							 <input  class="nui-textbox"  name="issueNameFull"
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
			style="width: 100%;height: 100%;" 
			url="com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.issueAliasQuerry.biz.ext"
			dataField="data" multiSelect="true" pageSize="20" showPageInfo="true"  sortField="lAliasId" sortOrder="desc">

                <div property="columns" >
				<div type="indexcolumn" width="10"></div>
                    <div type="checkcolumn"  width="10">
                    </div>
					<div field="lDate"  headerAlign="center" width="30" dateFormat="yyyy-MM-dd" align="right"  allowSort="true">
						 日期
			        </div>
                    <div field="vcIssuerNameFull"  headerAlign="center"  width="140" allowSort="true">
						 发行主体全称
			        </div>
			        <div field="vcIssuerNameFullWind"  headerAlign="center"  width="120" allowSort="true">
						 发行主体别名
			        </div>
			        <div field="cStatus"  headerAlign="center" width="100" allowSort="true" visible=false>
						 状态
			        </div>
			        <div field="lOperatorNo"  headerAlign="center" width="100" align="right" allowSort="true" visible=false>
						 操作人
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