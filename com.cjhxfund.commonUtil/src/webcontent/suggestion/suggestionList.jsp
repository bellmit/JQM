<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>
<html>
<!-- 
  - Author(s): 何祎
  - Date: 2017-04-10 13:49:12
  - Description:
-->
<head>
<title>意见/建议信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body style="width: 100%;height: 100%;overflow: hidden;margin: 0px;">
	<div class="nui-tabs" id="tab" activeIndex="0" style="width:100%;height:100%;">
		<div title="意见/建议信息">
		   <%--意见/建议信息查询条件开始... --%>		   
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_sug" class="nui-form" method="post">
	                <table id="table1"  border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
	                	<tr>
	                		<td class="form_label" style="width: 80px;text-align: right;">日期:</td>
	                		<td style="width: 28%;text-align: left;">
	                        	<input id="T_SUGGESTION_DATE_B" class="nui-datepicker" name="paramObject/tSuggestionDateB" width="140px" required="false"/>
								&nbsp;到&nbsp;<input id="T_SUGGESTION_DATE_E" class="nui-datepicker" name="paramObject/tSuggestionDateE" width="140px" required="false"/>
							</td>	
							<td style="width: 80px;text-align: right;">主题:</td>
							<td>
	                            <input id="vcSuggestionTitil" class="nui-textbox" style="width: 90%;" name="paramObject/vcSuggestionTitil" />
	                        </td>
	                        <td style="width: 80px;text-align: right;">问题类型:</td>
							<td>		
								<input id="vcSuggestionTitil" class="nui-dictcombobox" dictTypeId="ATS_ADVICE_TYPE" style="width: 90%;" name="paramObject/vcSuggestionTitil2" />	
							</td>	
	                        <td>
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
	                        	<input class='nui-button' plain='false' text="重置" iconCls="icon-reload"  onclick="reset()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>   
		   <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">  
                        	<input class='nui-button' plain='false' text="意见/建议录入" iconCls="icon-add"  onclick="add()"/>
                        </td>
                    </tr>
                 </table>
           </div>             
           <div class="nui-fit">
            <div id="datagrid_sug"
                dataField="tAtsSuggestion"
                class="nui-datagrid"
                style="width:100%;height:100%;"
                url="com.cjhxfund.commonUtil.suggestion.insertSuggestion.querySuggestionList.biz.ext"
                pageSize="50"
                showPageInfo="true"
                allowSortColumn="true"
                sortMode="client"
                enableHotTrack="true"
                sizeList="[10,20,50,100]">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div field="tSuggestionDate" headerAlign="center" allowSort="true" align="center" width="60px" dateFormat="yyyy-MM-dd HH:mm:ss">
                            日期
                        </div>
                        <div field="vcSuggestionTitil" name="vcSuggestionTitil" headerAlign="center" allowSort="true" align="left" width="300px">
       	   主题
                       </div>
                       
                        <div field="vcSuggestionType" name="vcSuggestionType" headerAlign="center" renderer="renderSuggestionType" allowSort="true" align="left" width="80px">
                           问题类型
                        </div>
                        <div field="vcSuggestionUsername" headerAlign="center" allowSort="true" align="left" width="80px">
                           操作人
                        </div>
                    </div>
                </div>
            </div>
		</div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	var datagrid = nui.get("datagrid_sug");
    	var form = new nui.Form("#form_sug");
    		
    		
    	function search(){
			var data = form.getData();
			datagrid.load(data);
		}
		
		function reset(){
			form.reset();
		}
		
		//问题类型
		function renderSuggestionType(e){
			return nui.getDictText("ATS_ADVICE_TYPE",e.row.vcSuggestionType);
		}  
    	
    	//意见建议录入
    	function add() {
		mini.open({
		    url:"<%=request.getContextPath() %>/commonUtil/suggestion/suggestionAdd.jsp",
		    title: "意见/建议录入", width: 850, height:540,
		    overflow:"hidden",
		    onload: function () {
		    },
			ondestroy: function (action) {//弹出页面关闭前
				search();
			}
		});
    }   
    
    //渲染行对象
	datagrid.on("drawcell", function (e) {
		column = e.column,
		row=e.row;
		        
		//action列，超连接操作按钮
		if (column.name == "vcSuggestionTitil") {
			e.cellStyle = "text-align:left";
			e.cellHtml="<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='wfOpenWin(\"" + row.lSuggestionId + "\")'>"+e.record.vcSuggestionTitil+"</a>&nbsp;";
		}       
	});
	
	function wfOpenWin(lSuggestionId){
		nui.open({
		    url:"<%=request.getContextPath() %>/commonUtil/suggestion/suggestionLog.jsp?lSuggestionId="+lSuggestionId+"",
		    title: "意见/建议详情", width: 870, height:540,
		    overflow:"hidden",
		    onload: function () {
		    },
		});
	}
    
    search();
    
    </script>
</body>
</html>