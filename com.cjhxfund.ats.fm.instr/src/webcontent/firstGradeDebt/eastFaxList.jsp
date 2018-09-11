<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/js/commscripts.jsp" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 陈鹏
  - Date: 2016-10-14 13:34:13
  - Description:
-->
<head>
<title>传真发送列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <%
    	String bizId = request.getParameter("bizId");
    	String processinstid = request.getParameter("processinstid");  
    	String type = request.getParameter("type"); 	
     %>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;margin: 0px;">
<div id="fax_Form">
	<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.fm.comm.comm.AtsEastFaxEntity"/>
	<input class="nui-hidden" name="criteria/_expr[1]/lBizId" value="<%=bizId%>"/>
	<input class="nui-hidden" name="criteria/_expr[1]/_op" value="="/>
	<input class="nui-hidden" name="criteria/_expr[2]/lProcessInstId" value="<%=processinstid%>"/>
	<input class="nui-hidden" name="criteria/_expr[2]/_op" value="="/>
</div>
<%
   if(!type.equals("2")){
 %>
<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	<table style="width:100%;">
		<tr>
			<td style="width:100%;">
				<a class='nui-button' plain='false' id="add" iconCls='icon-remove' onclick='abandoned()'>废弃</a>
				&nbsp;
				<a class='nui-button' plain='false' id="details" iconCls='icon-reload' onclick='refresh()'>刷新</a>
			</td>
		</tr>
	</table>
</div>
<%
}
 %>
<div id="fax_grid" class="mini-datagrid" style="width:100%;height:96%;" 
	 url="com.cjhxfund.ats.fm.comm.atsEastFaxBiz.queryEastFaxList.biz.ext" 
	 dataField="eastFaxs"  showPageInfo="false" showPager="false"  multiSelect="true" allowSortColumn="false" onshowrowdetail="onShowRowDetail">
	 <div property="columns">
		<div type="checkcolumn" width="20"></div>
		<div type="expandcolumn" >#</div>
		<div field="lFaxId"  headerAlign="center" align="center" visible="false">Fax编号</div> 
		<div field="vcFaxTheme" align="center" allowSort="true"  headerAlign="center">传真主题</div>
		<div field="workitemname" align="center" headerAlign="center">传真环节</div>
		<div field="vcUserName" headerAlign="center" align="center" width="50px">发送人</div>
		<div field="vcFaxAccount" headerAlign="center" align="center" allowSort="true">传真账号</div> 
		<div field="vcSerialNo" headerAlign="center" align="center" allowSort="true">传真编号</div>               
		<div field="dSendTime" headerAlign="center"  align="center"allowSort="true">发送时间</div>	
		<div field="vcRecvNumber" headerAlign="center" align="center" allowSort="true">接收人传真号</div>	
		<div field="vcRecvName" headerAlign="center" align="center" allowSort="true">接收人姓名</div>
		<div field="lFaxStatus" headerAlign="center" align="center" allowSort="true" renderer="onlFaxStatus">传真状态</div>
	 </div>
</div>
<div id="detailGrid_Form" style="display:none;width: 60%;float: left;margin-left: 5%;">
	<div id="employee_form">	          
		<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.fm.comm.comm.atsAttachInfoEntity"/>
		<input class="nui-hidden" name="criteria/_expr[1]/lFaxId" id="lFaxId"/>
	</div>	
	<div id="employee_grid" class="mini-datagrid" style="width:100%;height:100px;" 
		url="com.cjhxfund.ats.fm.comm.atsEastFaxBiz.queryAttachmentList.biz.ext" idField="id"
		dataField="attachments"  allowResize="true" showPager="false" multiSelect="true"
		allowSortColumn="false" allowCellEdit="true">
		<div property="columns">
				<div field="lAttachId" width="30"  headerAlign="center" >编号</div> 
				<div field="vcAttachName"  headerAlign="center" width="80%" allowSort="true">文件名</div>                
				<div field="vcAttachSize" name="vcAttachSize" width="40" align="center" headerAlign="center">文件大小</div>        
	    </div>
	</div>	         
 </div>   
<script type="text/javascript">
	nui.parse();
	
	var detailGrid_Form = document.getElementById("detailGrid_Form");
	var employee_grid = mini.get("employee_grid");
    var formData = new nui.Form("#employee_form");
        
	//附件列表查询
    var fax_grid = nui.get("fax_grid");
	var fax_Form = new nui.Form("#fax_Form").getData(false,false);
		fax_grid.load(fax_Form);
	
	//重新刷新页面
	function refresh(){
		var form = new  nui.Form("#fax_Form");
		var json = form.getData(false,false);
			fax_grid.load(json);//grid查询
    }
    
    function abandoned(){
		var rows = fax_grid.getSelected();
			if(rows){
				var json = nui.encode({lFaxId:rows.lFaxId});
				nui.confirm("请先确认传真客户端是否已取消传真，是否继续。","系统提示",function(action){
					if(action=="ok"){
						nui.confirm("确认要将此传真致为废弃状态吗?","系统提示",function(action1){
							if(action1 == "ok")
								fax_grid.loading("正在废弃中,请稍等...");
								$.ajax({
									url:"com.cjhxfund.ats.fm.comm.atsEastFaxBiz.abandonedEastFax.biz.ext",
									type:'POST',
									data:json,
									cache: false,
									contentType:'text/json',
									success:function(text){
										var returnJson = nui.decode(text);
										if(returnJson.returnValue == "yes"){
											fax_grid.reload();
											nui.alert("废弃成功", "系统提示", function(action){});
										}else{
											fax_grid.unmask();
											nui.alert("废弃失败", "系统提示");
										}
									}
								});
							 });	
						 }	
					});	

		}else{
			nui.alert("请选择一条指令/建议。","提示");
		}
	}
	
	function onlFaxStatus(e){
		return nui.getDictText("ATS_FAX_STATUS",e.row.lFaxStatus);
	}
	
	//打开详细附件列表
	function onShowRowDetail(e){
        var grid = e.sender;
        var row = e.record;
        
        //给查询附件列表与要下载的附件时工作项ID赋值
        nui.get("lFaxId").setValue(row.lFaxId);

        var td = grid.getRowDetailCellEl(row);
        employee_grid.load(formData.getData(false,false));
        
      //判断没有数据不显示列表
        employee_grid.on("load", function (e) {
   	 	   var datas = e.data;
   	 	   if(datas.length != 0){
   	 		td.appendChild(detailGrid_Form);
   	 		detailGrid_Form.style.display = "block";
   	 	   }
        });	
        
        employee_grid.on("drawcell", function (e) {
		 	 var record = e.record,
		 	     column = e.column;
		     if (column.name == "vcAttachSize") {
			 		//e.cellStyle = "text-align:left";
			 		var vcAttachSize = record.vcAttachSize/1024/1024;
			 	      if(vcAttachSize < 1){
			 		    vcAttachSize = record.vcAttachSize/1024;
			 		    e.cellHtml = vcAttachSize.toFixed(2)+"KB";
			 		}else{
			 		     e.cellHtml = vcAttachSize.toFixed(2)+"MB";
			 		} 	
	 			}
	 			
 		});
	}
</script>
</body>
</html>