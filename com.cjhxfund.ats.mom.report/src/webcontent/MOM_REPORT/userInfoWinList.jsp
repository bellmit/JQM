<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<!-- 
  - Author(s):liangjilong
  - Date: 2016-11-11 08:25:25
  - Description:
-->
<head>
	<title>用户信息</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
 <body style="width: 100%;height: 100%;overflow: hidden;">

<div style="margin:0px;width:100%;height:100%;" >
	<div style="width:100%;height:100%;">
		   <div class="search-condition">
			   <div class="list">
				   <div id="form1" class="nui-form" style="padding:2px;" align="center" >		            
		            <table id="table1" class="table" style="width:100%;table-layout:fixed;">
		                <tr>
		                   	<td class="form_label" width="8%" align="right">员工姓名:</td>
		                    <td colspan="1" width="15%" align="left">
		                        <input class="nui-textbox" style="width:95%" name="userInfo/empName"  />
		                    </td>
		                    
		                    <td class="form_label" width="8%" align="right">所属机构:</td>
		                    <td colspan="1" width="15%" align="left">
		                        <input class="nui-textbox" style="width:95%" name="userInfo/orgName"  />
		                    </td>	
		                    
		                   <td colspan="1" rowspan="2" width="10%" align="left">
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
	                        </td> 
		              </tr>
		            </table>
		         </div>
			  </div>
		   </div>
		   <%-- 查询条件结束!!! --%>
		   
		   <%-- 产品复核权限配置列表开始... --%>
		        

            <div class="nui-fit">
		   		<div id="datagrid1" 
		   			dataField="userInfoList"
		   			class="nui-datagrid" 
		   			style="width:100%;height:96%;"
		        	url="com.cjhxfund.ats.mom.report.prodUserInfoManager.queryUserList.biz.ext"
	           		pageSize="20"  
	           		allowUnselect="false"
                	showPageInfo="true" 
                	multiSelect="false" 
                	allowSortColumn="true"
                	allowMoveColumn="true"
                	onselectionchanged="selectionUserChanged"
                	onrowdblclick="onOk"
                	>
					
                    <div property="columns">
                        <div type="checkcolumn" width="5%">选择</div>
                        <div field="empCode" headerAlign="center" allowSort="true" align="left" width="80px">员工编号</div>
                        <div field="empName" headerAlign="center" allowSort="true" align="left" width="150px">员工姓名</div>
                        <div field="orgName" headerAlign="center" allowSort="true" align="left" width="100px">所属机构</div>
                    </div>
                </div>

            </div>
		    <%-- nui-fit列表结束!!! --%>
		     <div class="nui-toolbar" style="padding:12px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">保存 </a>
                            	<span style="display:inline-block;width:25px;"> </span>
                            <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">取消</a>
                        </td>
                    </tr>
                </table>
            </div>
		</div>
	</div>	
</div>
<script type="text/javascript">
	nui.parse();
	var grid1 = nui.get("datagrid1");
	//进来这个页面就加载列表信息
	var formData = new nui.Form("#form1").getData(false,false);
	grid1.load(formData);
	 
	 
	 //查询
	function search() {
		var form = new nui.Form("#form1");
		var json = form.getData(false,false);
		grid1.load(json);//grid查询
	}
	
 
	 function onOk(){
	 	var rows = grid1.getSelecteds();
	 	if(rows.length>0){
	 		CloseWindow("ok");
	 	}else{
	 		nui.alert("请选择一条数据进行操作","系统提示");
	 		return false;
	 	}
	 }
	 
	    //关闭窗口
      function CloseWindow(action) {
         if (action == "close" && form.isChanged()) {
            if (confirm("数据被修改了，是否先保存？")) {
               // saveData();
            }
         }
            if (window.CloseOwnerWindow)
            return window.CloseOwnerWindow(action);
            else window.close();
        }
	   //取消
      function onCancel() {
            CloseWindow("cancel");
      }
	 
	 function selectionUserChanged(){
	 	 var row = grid1.getSelected();
		 return row;
	 }
	 
	 
	
</script>
</body>
</html>