<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>
<html>
<!-- 
  - Author(s): 谢海光
  - Date: 2017-06-27 16:20:37
  - Description:
-->
<head>
<title>主承销商别名策略</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
		
	<div class="search-condition">
		  <div class="list">
            <div id="form1" class="nui-form"  align="center" >
                <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                    <tr>
                        <td align="right"  width="120">
						 wind简称:
		                </td>
		                <td align="left"  width="20%">
							 <input  class="nui-textbox"  name="underwriterNameFull"
                             id="dictname" width="100%"/>
                        </td>
                        
                        <td align="left">
					       <a id="query" class="nui-button" iconCls="icon-search" onclick="search()">
					                        查询
					       </a>                        
                            <span>&nbsp;</span>
					       <a id="query" class="nui-button" iconCls="icon-reload" onclick="reset()">
					                        重置
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
                            <a class='nui-button' id="addAlisa" iconCls='icon-add' onclick='addAlias()'>增加别名</a>
                        </td>
                    </tr>
                </table>
            </div>
	<div class="nui-fit">
		    <div id="datagrid1" class="nui-datagrid"
			style="width: 100%;height: 100%;" 
			url="com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.queryUnderwriterAliasInfo.biz.ext"
			dataField="data" multiSelect="true" pageSize="20" showPageInfo="true"  sortField="lAliasId" sortOrder="desc">

                <div property="columns" >
				<div type="indexcolumn" width="10"></div>
                    <div type="checkcolumn"  width="10">
                    </div>
					<div field="lDate"  headerAlign="center" width="60" dateFormat="yyyy-MM-dd" align="right"  allowSort="true">
						 日期
			        </div>
			        <div field="vcAliasType"  headerAlign="center"  width="100" renderer="vcAliasTypeRenderer" allowSort="true">
						 别名类型
			        </div>
                    <div field="vcRightNameFullWind"  headerAlign="center"  width="140" allowSort="true">
						 wind全称
			        </div>
			        <div field="vcRightNameAbbrWind"  headerAlign="center"  width="140" allowSort="true">
						 wind简称
			        </div>
			        <div field="vcLeftNameAbbr"  headerAlign="center"  width="120" allowSort="true">
						 数据源简称
			        </div>
			        <div field="vcLeftNameFull"  headerAlign="center"  width="120" allowSort="true">
						 数据源全称
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
            function vcAliasTypeRenderer(e){
        	   return nui.getDictText("ATS_FM_ALIAS_TYPE",e.row.vcAliasType);
            }
            
            function addAlias() {
				   nui.open({  
		                url: "<%=request.getContextPath()%>/fm/baseinfo/issuerInfo/addUnderwriterAlias.jsp",
		            title: "新增别名", width: 865, height: 220,
		            onload: function () {//弹出页面加载完成
		              //var iframe = this.getIFrameEl();
		              //iframe.contentWindow.setFormData(data);
		            },
		            ondestroy: function (action) {//弹出页面关闭前
		                grid.reload();
		            }
		            });
	           
		 }
    </script>
</body>
</html>