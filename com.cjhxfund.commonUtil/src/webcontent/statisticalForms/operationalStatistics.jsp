<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 陈迪
  - Date: 2017-03-08 09:42:09
  - Description:
-->
<head>
<title>业务使用统计</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="height:100%; width:100%; overflow:hidden; margin:0;padding:0;">
<div >
	<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
	    <form id="searchCondi" class="nui-form">
	    <table style="width: 100%;">
	        <tr>
	            <td>
	               业务日期
	                <input class="nui-datepicker"
	                       id="lDate1" 
	                       name="lDate1"
	                       emptyText="请选择..."
	                       nullItemText="请选择..."
	                       showClose="true" 
	                       oncloseclick="onCloseClick" 
	                       style="width:10%"
	                       multiSelect="true"/> 
             		<span style="width: 5%;">-</span>
	                <input class="nui-datepicker"
	                       id="lDate2" 
	                       name="lDate2"
	                       emptyText="请选择..."
	                       nullItemText="请选择..."
	                       showClose="true" 
	                       oncloseclick="onCloseClick" 
	                       style="width:10%"
	                       multiSelect="true"/>
	                业务逻辑名称
	                <input class="nui-dictcombobox" 
	                       id="vcBizName" 
	                       name="vcBizName"
	                       valueField="dictID" 
	 					   textField="dictName"
	                       dictTypeId="bizLogicName"
	                       emptyText="全部..." 
	 					   nullItemText="请选择..."
	                       showClose="true"
	                       oncloseclick="onCloseClick" 
	                       style="width:10%"
	                       multiSelect="true"/>
	                <a class="nui-menubutton " plain="false" menu="#popupMenu"
	                   id="searchCond"
	                   name="searchCond"
	                   data-options='{formId:"searchCondi"}'
	                   iconCls="icon-add">保存查询条件
	            	</a>
	                <ul id="popupMenu" class="mini-menu" style="display:none;width:250px;"></ul>
	                <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="queryBizOprCount()"/>
	                <a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">重置</a>
	            </td>
	        </tr>
	    </table>
	    </form>
	</div>
</div>	
<!-- 用户操作日志Grid -->
<div  class="nui-tabs" >
    <div title="业务使用统计">
        <div id="bizOprCountGrid"
             class="mini-datagrid"
             style="width:100%;height:300px;"
             url="com.cjhxfund.commonUtil.userOperatorManager.queryTAtsBizOperateCount.biz.ext"
             dataField="bizOprCountList"
             pageSize="10"
             sizeList="[10,20,50,100]"
             showPager="true"
             allowResize="true"
             showPager="false"
             sortMode="client"
			 showfooter="false">
            <div property="columns" >
                <div field="lDate" align="center" width="15%" headerAlign="center" >业务日期</div>
                <div field="vcBizName" align="center" width="60%" headerAlign="center" renderer="renderVcBizName">业务逻辑名称</div>
                <div field="lCount" align="center" width="25%" headerAlign="center" >业务使用总数</div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="<%=contextPath%>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script>
<script type="text/javascript">
    nui.parse();
	var grid = nui.get("bizOprCountGrid");
	var formData = new nui.Form("#searchCondi").getData(false,false);
	grid.load(formData);
		
    function queryBizOprCount(){
	    var grid = nui.get("bizOprCountGrid");
		var searchData = new nui.Form("#searchCondi").getData(false,false);
		grid.load({"bizOprCount":searchData});
    };
    
    //页面X的删除功能
    function onCloseClick(e) {
        var obj = e.sender;
        obj.setText("");
        obj.setValue("");
    }
    //重置按钮
    var reset = function () {
        (new nui.Form("searchCondi")).clear();
    };
    //业务名称字典转换
    function renderVcBizName(e){
		return nui.getDictText("bizLogicName",e.row.vcBizName);
	}
</script>
</body>
</html>