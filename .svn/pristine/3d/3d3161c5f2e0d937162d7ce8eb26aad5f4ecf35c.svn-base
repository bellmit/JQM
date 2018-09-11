<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>

<!-- 
  - Author(s): zhangyao
  - Date: 2016-12-06 16:13:30
  - Description:
-->
<head>
	<title>启动流程</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="css/offeringStyle.css"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
</head>
<body>
	<div class="main">  
		<!--查询条件-->
		<div id="stockForm" class="nui-form">
	    	<ul class="form_list_name">
	        	<li>
	                <span class="cstyle">申购代码 :</span>
	                <input name="stock/vcIssuerNo" class="nui-textbox" emptyText="请输入申购代码" style="width:150px;" onenter="onKeyEnter"/>
	            </li>
	            <li>
	                <span class="cstyle">发行人 :</span>
	   				<input name="stock/vcIssuerName" class="nui-textbox" emptyText="请输入发行人" style="width:150px;" onenter="onKeyEnter"/>
	            </li>
	            <li>
	            	<span class="cstyle">主承销商 :</span>
	             	<input name="stock/vcLeadUnderwriterName" class="nui-textbox" emptyText="请输入主承销商" style="width:150px;" onenter="onKeyEnter"/>
	            </li>
	            <li>
	            	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>&nbsp;&nbsp;&nbsp;
	                <input class='nui-button' plain='false' text="重置" iconCls="icon-reset" onclick="reset()"/>
	            </li>
		    </ul>
	 	</div>
    	<!--操作按钮-->
		<div style="width:100%;">
	        <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	            <table style="width:100%;background:#DBE3F2;">
	                <tr>
	                    <td>
	                        <a class='nui-button' plain='false' iconCls="icon-ok" onclick="createProc()"  plain="false">启动</a>
	                    </td>
	                    <td style="float:right;margin-right:10px;">
	                    	<span style="color:#626262;">未启动:<strong class="strong" style="background:#FFF;"></strong></span>
	                    	<span style="color:#626262;">已启动:<strong class="strong" style="background:#FF6666;"></strong></span>
	                    </td>
	                </tr>
	            </table>           
	        </div>
	    </div>
	    <!--撑满页面-->
	    <div class="nui-fit" >
		    <!--表格-->
		    <div id="datagrid1" class="nui-datagrid"  style="width:100%;height:100%;" 
		        url="com.cjhxfund.ats.ipo.busOpr.queryNewStockByWind.biz.ext" 
		        idField="VC_ISSUER_NO" 
		        dataField="stockInfos" 
		        allowResize="true"
		        showPageInfo="true" 
				sizeList="[10,20,30,50]" 
		       	pageSize="20"
		       	sortField="L_PROSPECTUS_NOTICE_DATE" 
				sortOrder="DESC"
				allowSortColumn="false">
		        <div property="columns">
		            <div type="indexcolumn" headerAlign="center" align="center" width="20">序号</div>
		            <div type="checkcolumn" width="20"></div>
		            <div field="vcIssuerNo" headerAlign="center" allowSort="true" align="center" width="50">
		            	申购代码
		            </div>                
		            <div field="vcCompanyName" headerAlign="center" allowSort="true" align="center" width="120">
		            	公司名称
		            </div>
		            <div field="vcIssuerName" headerAlign="center" allowSort="true" align="center" width="80">
		            	发行人
		            </div>
		            <div field="vcLeadUnderwriterName" headerAlign="center" allowSort="true" align="center" width="120">
		            	主承销商
		            </div>    
		            <div field="enPurchaseSize" headerAlign="center" allowSort="true" align="center" width="40">
		            	申购步长
		            </div>
		            <div field="enIssueNumber" headerAlign="center" allowSort="true" width="60">
		            	发行数量(万股)
		            </div>
		            <!--  
		            <div field="enTotalEquity" headerAlign="center" allowSort="true" width="60">
		            	发行后总股本(万股)
		            </div>
		            -->                          
		        </div>
		    </div>
		</div>
	</div>
<script type="text/javascript">
	nui.parse();
	
	var grid = nui.get("datagrid1");
    grid.load();
    
   	var form=new nui.Form("#stockForm");
    
    //查询
	function search(){
		json = form.getData(false,false);
		grid.load(json);
	}
	function onKeyEnter(e) {
	        search();
	    }
	
		//重置
	function reset(){
		form.clear();
	}
	
	function createProc(){
		var row = grid.getSelected();
		if (row) {
			/*if(row.vcLeadUnderwriterName.indexOf("第一创业")!=-1){
				nui.alert("该新股的关联方为第一创业，不能发起新股申购！","系统提示");
				return;
			}*/
			var dataNo={ vcIssuerNo: row.vcIssuerNo,lProspectusNoticeDate:row.lProspectusNoticeDate };
			var json=nui.encode(dataNo);
			var flag=false;
			nui.ajax({
				url: "com.cjhxfund.ats.ipo.busOpr.queryInstructByIssueCode.biz.ext",
				type: "post",
				data: json,
				async: false,
				contentType:'text/json',
				success: function (text) {
			    	var returnJson = nui.decode(text);
				    if(returnJson.exception == null){
			        	if(returnJson.resultCount==0){
			        		flag=true;
			        	}
			        }
				}
		        
	    	});
	    	
	    	if(flag==true){
				nui.open({
		            url: "<%=request.getContextPath() %>/ipo/offering/traderGetInfo0010_a.jsp",
		            title: "启动新股流程", width: 700, height: 510,
		            onload: function () {
		                var iframe = this.getIFrameEl();
		                var data = { action: "create", vcIssuerNo: row.vcIssuerNo };
		                iframe.contentWindow.SetData(data);
		            },
		            ondestroy: function (action) {
		                grid.reload();
		            }
	        	});
        	}else{
        		nui.alert("该新股已有对应的流程运行，请重新选择！","系统提示");
        	}
        
    	} else {
        	alert("请选中一条记录");
    	}
	}
	//判断是否启动流程
	grid.on("drawcell", function (e) {
	 	var record = e.record;
        //设置行样式
        if (record.vcProcessFlag == "0") {
            e.rowStyle = "background:#FFF";
        }else{
        	e.rowStyle = "background:#FF6666";
        }
	}); 
</script>
</body>
</html>