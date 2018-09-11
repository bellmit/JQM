<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 陈迪
  - Date: 2017-03-22 09:27:47
  - Description:消息提醒
-->
<head>
	<title>消息提醒管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/css/instruct.css"/>
  	<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
</head>
<body style="height:100%; width:100%; overflow:hidden; margin:0;padding:0;">

<div title="最新消息提醒" id="remindManagePanel" class="nui-panel" iconCls="icon-tip" style="width:100%;" 
   				 showCollapseButton="true" collapseOnTitleClick="true">
   		<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
   			<table style="width:100%;">
	        <tr>
	            <td style="width:50%;">
	                <a class='nui-button' plain='false' iconCls="icon-ok" onclick="markAsRead()">标记为已读</a>&nbsp;
		            </td>
		        </tr>
		    </table>
   		</div>
	    <div class="nui-fit" style="width:100%; height:100%;">
	    <div id="grid_remind_message" class="nui-treegrid" style="width:100%;height:300px;"
	     url="com.cjhxfund.commonUtil.MessageService.messageReminder.biz.ext"
			 dataField="remindInfos" 
			 treeColumn="lRemindId"
			 allowResize="true"
			 pageSize="10"
			 sizeList="[10,20,30,50,100]"
			 showReloadButton="true"
			 allowHeaderWrap="true"
			 enableHotTrack="true"
			 showPager="true"
			 multiSelect="true"
			 pagerButtons="#prompt_remind">
		    <div property="columns" style="width:5%">
		    	<div field="lRemindId" visible="false">提醒编号</div>
		    	<div type="checkcolumn"></div>
		    	<div type="indexcolumn" headerAlign="center" style="width:5%">编号</div>
		        <div field="vcTitle" name="vcTitle" align="left" headerAlign="center" width="40%">标题</div>
	          	<div field="tRemindTime" width="20%" align="center" headerAlign="center"  dateFormat="yyyy-MM-dd HH:mm:ss" width="20%">提醒时间</div>
	          	<!--<div field="url" align="center" headerAlign="center" renderer="value" width="20%">地址</div>-->
	          	<div field="vcReadStatus" align="center" headerAlign="center" width="10%" renderer="renderReadStatus" width="10%">状态</div>
			    	<div field="vcContent" visible="false">内容</div>
			    </div>
			    <div id="prompt_remind">
					<div id="showRead" style="margin-left:50px; checked="false" class="nui-checkbox" onclick="showRead" readOnly="false"  text="显示已读提醒" ></div>
				</div>
		    </div>
		</div>
	</div>
	
	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("grid_remind_message");
    	grid.load();
    	
    	//显示已读提醒
    	function showRead(e){
    		var checked = this.getChecked();
    		//选中则显示已读，否则显示未读
    		if(checked == true){
    			var param = {vcReadStatus:"1"};
					grid.load({parameter:param});
    		}else{
    			grid.load();
    		}
    	}
    	
    	//标记为已读
    	function markAsRead(){
    		//获取选择的行
			var row = grid.getSelecteds();
    		if (row.length>0) {
			    nui.ajax({
			    	url : "com.cjhxfund.commonUtil.MessageService.markAllRemindRead.biz.ext",
			    	type : 'POST',
			    	data : {param:row},
			    	contentType : 'text/json',
			    	success : function(){
						grid.reload();
					}
				});
	    	}else{
	      		nui.alert("请选择需要标记为已读的数据!");
	      	}
    	}
    	
    	//查看详情页面
    	function remindDetail(e){
			var rowData = grid.getRow(parseInt(e));
		    //跳转到详情页面
			nui.open({
			    url : "<%=request.getContextPath() %>/commonUtil/messageService/remindDetail.jsp",
				title : "消息详情",
				width : 600,
				height: 300,
				onload: function () {
					var iframe = this.getIFrameEl();
					iframe.contentWindow.SetData(rowData);
        		},
				ondestroy: function (action) {
					grid.reload();
				}
			});
    	}
    	
    	//渲染列表
    	grid.on("drawcell", function (e) {
	        var record = e.record,
    		field = e.field,
			value = e.value;
			//设置标题为链接
			if(field == "vcTitle"){
				e.cellStyle = "text-decoration:underline";
				if(record.vcReadStatus == "0"){
					if(nui.formatDate(record.tRemindTime, "yyyyMMdd") == nui.formatDate(new Date(), "yyyyMMdd")){
    					e.cellHtml = '<img src="img/tips.gif"/><a style="color:#0000EE;" href="javascript:remindDetail(\'' + grid.indexOf(record) + '\')">'+value+'</a>';
					}else{
    					e.cellHtml = '<a style="color:#0000EE;" href="javascript:remindDetail(\'' + grid.indexOf(record) + '\')">'+value+'</a>';
					}
				}else{
    				e.cellHtml = '<a style="color:#0000EE;" href="javascript:remindDetail(\'' + grid.indexOf(record) + '\')">'+value+'</a>';
				}
			}
			//设置阅读状态颜色
			if(field == "vcReadStatus"){
				if(record.vcReadStatus == "0"){
					e.cellStyle = "color:#EE0000;";
				}
			}
	    });
	    
	    //阅读状态列字典翻译
	    function renderReadStatus(e){
	    	return nui.getDictText("vcReadStatus",e.row.vcReadStatus);
	    }
	    
	    // 表格显示url
	    function value(e){
	    	var s = null;
	    	if(e.row.url != null){
	    		s = '<a href="<%= request.getContextPath() %>"\'' + e.row.url + '\'>点击跳转</a>';
	    	}
	    	return s;
	    }
	    
    </script>
</body>
</html>