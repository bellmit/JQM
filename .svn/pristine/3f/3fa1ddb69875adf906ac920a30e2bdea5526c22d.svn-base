<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://eos.primeton.com/tags/workflow" prefix="wf"%>
<%@include file="/common/js/commscripts.jsp" %>
<html>
<head>
<title>流程图</title> 
<h:script src="/workflow/wfcomponent/web/js/workflow.js"/>
<h:script src="/workflow/wfcomponent/web/js/Graphic.js"/>
<!-- <h:script src="/workflow/wfcomponent/web/js/workflow-tag.js"/> -->
 <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
<%
   String processinstid = request.getParameter("processInstID");
   String bizId = request.getParameter("bizId");
 %>
</head>
<body topmargin="20" style="width: 100%;height: 100%;overflow: hidden;" >
 <div id="tabs" class="nui-tabs" style="width: 100%;height: 100%;">
    <div title="审批信息">
      <!-- 流程处理信息列表 -->
		   <div id="grid_form">
			   <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.commonUtil.dataBase.TAtsApproveInfo"/>
			   <input class="nui-hidden" name="criteria/_expr[1]/lProcessInstId" value="<%=processinstid %>"/>
			   <input class="nui-hidden" name="cirteria/_expr[1]/_op" value="="/>
		   	</div>
			<div id="deptGrid" class="nui-datagrid" style="width:100%;height:600px;"
				 url="com.cjhxfund.commonUtil.pendingTreatment.queryTAtsApproveInfoList.biz.ext"  
				 onshowrowdetail="onShowRowDetail" dataField="TAtsApproveInfos" pageSize="50" showPageInfo="true"
			                        multiSelect="true" allowSortColumn="true">
			 <div property="columns">            
			     <div type="expandcolumn" >#</div>
			     <div field="lWorkItemId"  headerAlign="center" visible="false">工作项ID</div> 
			     <div field="lApproveId"  headerAlign="center" visible="false">编号</div> 
			     <div field="processInstId"  headerAlign="center" visible="false">流程ID</div>
			     <div field="dEndTime"  headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss">审批时间</div>                                        
			     <div field="vcWorkItemName"  headerAlign="center" >节点名称</div>   
			     <div field="vcUserName"  headerAlign="center" >操作者</div>  
			     <div field="vcOperateType"  headerAlign="center" renderer="rendeRoperateType">操作</div>  
			     <div field="vcComments"  headerAlign="center" >处理意见</div>         
			 </div>
		</div> 
		<div id="detailGrid_Form" style="display:none;width: 100%;float: right;">
	        <div>
	          <a class='nui-button' plain='false' id="fileDownload" iconCls="icon-download" onclick="fileDownload()"	plain="false">下载</a>
	        </div>
	        <div id="employee_form">	          
	          <input class="nui-hidden" name="map/processId" value="<%=processinstid %>"/>
			  <input class="nui-hidden" name="map/workitemid" id="workitemid1"/>
			  <input class="nui-hidden" name="map/bizId" value="<%=bizId %>"/>
	        </div>
	        <div id="employee_grid" class="mini-datagrid" style="width:100%;height:100px;" 
	            url="com.cjhxfund.commonUtil.pendingTreatment.queryAttachmentList.biz.ext" idField="id"
	              dataField="attachments"  allowResize="true" showPager="false" multiSelect="true"
	              allowSortColumn="false" allowCellEdit="true">
	            <div property="columns">
	                <div type="checkcolumn" width="20">
                    </div>
                    <div field="lAttachId"  headerAlign="center" visible="false">编号</div> 
	                <div field="vcAttachName"  headerAlign="center" allowSort="true">文件名</div>                
	              <%--  <div field="attachSize" width="40" allowSort="true"  align="center" headerAlign="center">文件大小
	                
	                </div> --%>           
	               
	            </div>
	        </div>    
	    </div>
	    
    </div>
    <div title="流程图">
       <div width="100%" align="center" style="margin-top: 20px;">
	     <wf:processGraph processInstID="@processInstID" zoomQuotiety="1" ondblclick="javaScript:showMessage(this)"/>
	  </div>
    </div>
 </div>
 <div>
	        <!-- 文档下载  -->
			<form id="file_download" method="post">
				<!-- 数据实体的名称 -->
				<input class="nui-hidden" name="processId" value="<%=processinstid %>"/>
				<input class="nui-hidden" name="sysid"  id="sysid"/>
				<input class="nui-hidden" name="workitemid"  id="workitemid2"/>
			</form>	
	    </div>
  <script type="text/javascript">
    nui.parse();
    
    //审批意见
	var dept_grid = nui.get("deptGrid");
	var formData = new nui.Form("#grid_form").getData(false,false);
	dept_grid.load(formData);
	
	//点击流程审批信息加载附件列表
    function onShowRowDetail(e) {
        var grid = e.sender;
        var row = e.record;
        
        //给查询附件列表与要下载的附件时工作项ID赋值
        nui.get("workitemid1").setValue(row.lWorkItemId);
        nui.get("workitemid2").setValue(row.lWorkItemId);
      
        var detailGrid_Form = document.getElementById("detailGrid_Form");
        
        var employee_grid = mini.get("employee_grid");
        var formData = new nui.Form("#employee_form").getData(false,false);
        
        var td = grid.getRowDetailCellEl(row);
        
        //td.appendChild(detailGrid_Form);
	 		//detailGrid_Form.style.display = "block";

        employee_grid.load(formData);
        
      //判断没有数据不显示列表
        employee_grid.on("load", function (e) {
   	 	   var datas = e.data;
   	 	   if(datas.length != 0){
   	 		td.appendChild(detailGrid_Form);
   	 		detailGrid_Form.style.display = "block";
   	 	   }
        });	
    }
    
    //批量下载附件
    function fileDownload(){
    	var  datas = nui.get("employee_grid").getSelecteds();
    	var sysId = "";
    	for(var i = 0;i < datas.length;i++){
    		if(sysId == ""){
    			sysId = datas[i].lAttachId;
    		}else{
    			sysId = sysId + "," +datas[i].lAttachId;
    		}
     	 }	
    	nui.get("sysid").setValue(sysId);	
    	
    	nui.confirm("确认要下载吗？","系统提示",function(action){
			if(action=="ok"){
				//nui.get("fileDownload").disable();//禁用“导出”按钮
				var form = document.getElementById("file_download");
				form.action = "com.cjhxfund.ats.fm.comm.fileDownload.flow";
		        form.submit();
		        //setTimeout("enableExportFun1()",15000);//启用“导出”按钮
			}
		});
      }
      
	      function rendeRoperateType(e){
	          if(e.row.vcOperateType == 1){
	            return "同意";
	          }
	          if(e.row.vcOperateType == 2){
	            return "退办";
	          }
	          if(e.row.vcOperateType == 3){
	            return "转办";
	          }
	          if(e.row.vcOperateType == 4){
	            return "征求意见";
	          }
	          if(e.row.vcOperateType == 5){
	            return "否决";
	          }
	          if(e.row.vcOperateType == 99){
	            return "不同意";
	          }
	          if(e.row.vcOperateType == 98){
				return "修改";
			  }
			  if(e.row.vcOperateType == 97){
				return "废弃";
			  }
          }
          
         function showMessage(e){
         	var json = nui.encode({activityInstId:e.activityInstId});
       		$.ajax({
					url:"com.cjhxfund.ats.fm.comm.wf.findActivityInstByActivityInstID.biz.ext",
		            type:'POST',
		            data:json,
		            cache:false,
		            contentType:'text/json',
		            success:function(text){
						var returnJson = nui.decode(text);
						var activityInstName = returnJson.activityInst.activityInstName;
						nui.open({
							url: "<%=request.getContextPath() %>/fm/comm/atsApproveInfoList.jsp?processinstid=<%=processinstid %>&activityDefID="+e.activityDefID,
			                title: activityInstName + "-审批信息", width: 500, height: 280,
			                onload: function () {//弹出页面加载完成
			            	},
			            	ondestroy: function (action) {//弹出页面关闭前
			                }
			            });
		            }    
		      });
         } 
	</script>
</body>
</html>
