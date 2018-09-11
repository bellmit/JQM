<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 刘玉龙
  - Date: 2016-08-22 13:25:25
  - Description:
-->
<head>
	<title>产品信息管理</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>

<div style="margin:0px;width:100%;height:100%;" >
	<div style="width:100%;height:100%;">
		   <div class="search-condition">
			   <div class="list">
				   <div id="form1" class="nui-form" style="padding:2px;" align="center" >		            
		            <table id="table1" class="table" style="width:100%;table-layout:fixed;">
		                <tr>
		                   	<td class="form_label" width="8%" align="right">产品代码:</td>
		                    <td colspan="1" width="15%" align="left">
		                        <input class="nui-textbox" style="width:95%" name="productInfo/vcProductCode"/>
		                    </td>
		                    
		                    <td class="form_label" width="8%" align="right">产品简称:</td>
		                    <td colspan="1" width="15%" align="left">
		                        <input class="nui-textbox" style="width:95%" name="productInfo/vcProductName"/>
		                    </td>	
		                    
 							<td class="form_label" width="8%" align="right">产品类型:</td>
		                    <td colspan="1" width="15%" align="left">
		                        <input class="nui-dictcombobox" name="productInfo/cProductType"  valueField="dictID" textField="dictName" dictTypeId="productType"  
									emptyText="全部" nullItemText="全部" style="width:95%" showClose="true" oncloseclick="onCloseClickValueEmpty" />
		                    </td> 
		                    
		                    <td class="form_label" width="8%" align="right">投资类型:</td>
		                    <td colspan="1" width="15%" align="left">
		                        <input class="nui-dictcombobox" name="productInfo/cInvestType"  valueField="dictID" textField="dictName" dictTypeId="investType"  
									emptyText="全部" nullItemText="全部" style="width:95%" showClose="true" oncloseclick="onCloseClickValueEmpty" />
		                    </td> 
		                    
		                    
		                   <td colspan="1" rowspan="2" width="10%" align="left">
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
	                        </td> 
		              </tr>
		            </table>
		         </div>
			  </div>
		   </div>
		   
            <div class="nui-fit">
		   		<div id="datagrid1" dataField="productInfos"
		   			class="nui-datagrid" style="width:100%;height:100%;"
		        	url="com.cjhxfund.ats.fm.baseinfo.ProductManager.queryProductInfoWithPage.biz.ext"
		           	pageSize="20" showPageInfo="true"
		           	allowSortColumn="true" sortMode="client"
		         	enableHotTrack="true" allowHeaderWrap="true"
		           	sizeList="[10,20,50,100]"
		           	allowCellEdit="true"
					allowCellSelect="true"
					enterNextCell="true"
					allowMoveColumn="true"
					onrowdblclick="onRowDblClick"
					editNextOnEnterKey="true"
					onload="format"
					multiSelect="true"   showfooter="false">
                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div field="vcProductCode" headerAlign="center" allowSort="true" align="left" width="80px">
                            	产品代码
                        </div>
                        <div field="vcProductName" headerAlign="center" allowSort="true" align="left" width="150px">
                            	产品简称
                        </div>
                        <div field="vcProductCaption" headerAlign="center" allowSort="true" align="left" width="200px">
                            	产品全称
                        </div>
                    </div>
                </div>
            </div>
		    <%-- 产品权限配置列表结束!!! --%>
		    <div class="nui-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
		        <a class='nui-button' plain='false' style="width:60px;" onclick="onOk()">确定</a>
		        <span style="display:inline-block;width:25px;"></span>
		        <a class='nui-button' plain='false' style="width:60px;" onclick="onCancel()">取消</a>
		    </div>
	</div>	
</div>
<script type="text/javascript">
	nui.parse();
	var grid1 = nui.get("datagrid1");
	
	
	var formData = new nui.Form("#form1").getData(false,false);
	grid1.load(formData);
	
	//查询
	function search() {
		var form = new nui.Form("#form1");
		var json = form.getData(false,false);
		grid1.load(json);//grid查询
	}
	
 
	function onOk() {
		var rows = grid1.getSelecteds();
	    if(rows.length < 1) {
	    	nui.alert("请选择一条记录!");
	    	return false;
	    }
		CloseWindow("ok");
	}	
	
	
	function GetData() {
	    var rows = grid1.getSelecteds();
	    if(rows.length < 1) {
	    	nui.alert("请选择一条记录!");
	    	return false;
	    }
	    var row = rows[0];
	    return row;
	}
		
	function onCancel() {
		CloseWindow("cancel");
	}
	
	
 	function CloseWindow(action) {
		if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
		else window.close();
	}	
	
	
	function onRowDblClick(e) {
		onOk();
	}
</script>
</body>
</html>