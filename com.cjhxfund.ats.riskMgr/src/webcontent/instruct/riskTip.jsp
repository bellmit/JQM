<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<%@include file="/common.jsp" %>

<div style="width:99%;height: 100%">
		<div 
            id="datagrid1"
            dataField="riskmgrs"
            class="nui-datagrid"
            style="width:100%;"
            height="350px"
            url=""
            showPager="false">
			
            <div property="columns">
				<div field="vcProductName" headerAlign="center" width="40%" >
                            产品名称
                </div>  
                <div field="vcEntrustDirection" headerAlign="center" align="center" renderer="entrustDirection" width="10%">
                           委托方向
                </div>     
                <div field="vcStockName" headerAlign="center"width="25%">
                            证券名称
                </div>
                <div field="enFullPriceAmount" headerAlign="center"align="center"  width="25%">
                            交易金额
                </div>
            </div>
        </div>
	<div class="nui-toolbar" style="width:100%;">
		<p align="center">
		<input class="nui-button"  iconCls="icon-ok"   id="ok" onclick="btnClick('1')" text="确定"/> 
		<input class="nui-button"  iconCls="icon-cancel" id="cancel" onclick="btnClick('2')" text="取消"/> 
		</p>
	</div>
</div>

<script type="text/javascript">
	
	function setData(data){
		nui.get("datagrid1").setData(data);
	}
	
	function btnClick(flag){
		CloseWindow(flag);
	}
	
	
	 //关闭窗口
    function CloseWindow(action) {
        if(window.CloseOwnerWindow){
        	return window.CloseOwnerWindow(action);
        }else{
        	window.close();
        }
    }
    
	function entrustDirection(e){
	  	return nui.getDictText("entrustDirection",e.row.vcEntrustDirection);
	}
</script>