<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<table style="width:100%;table-layout:fixed;" border="0" class="nui-form-table">
		  <l:in property="workitem/activityDefID" targetValue="manualActivity8,manualActivity12" >
		     <tr>
		         <td colspan="1" class="td1">主题: </td>
		         <td colspan="3" class="td2">[<b:write property="cfjybusinessbonetable/investproductnum" />]-<b:write property="cfjybusinessbonetable/combProductName" />-<b:write property="cfjybusinessbonetable/investProductName" /></td>
		     </tr>
		  </l:in>
		       <tr>
		         <td class="td1" width="20%">
		            <l:equal property="pageType" targetValue="2">
		         	  当前节点:    
		         	</l:equal>
		         	<l:notEqual property="pageType" targetValue="2">
		         	    当前节点：
		         	</l:notEqual>
		         </td>
		         <td colspan="3" class="td2"> <b:write property="workitem/workItemName" /> </td>
		       </tr>
		       <tr>
		         <td class="td1" width="20%">上一节点参与者：</td>
		         <td colspan="1" class="td2" width="30%"> <b:write property="lastActor" /></td>
		         <td class="td2" width="20%">当前节点参与者：</td>
		         <td class="td2" colspan="1"> <b:write property="nextActor" /></td>
		       </tr>
		       <tr>
		         <td class="td1">操作：</td>
		         <td colspan="2" class="radio-border-top-none ">
		          <!-- 当环节为投顾审核时没有转办与征求意见选项 -->
		          <l:in property="workitem/activityDefID" targetValue="manualActivity4,manualActivity5,manualActivity9">
		           <input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
						data="[{id: 1, text: '同意'}, {id: 2, text: '退办'},{id: 5, text: '否决'}]" style="float: left;" value="1"/>
				  </l:in>
				  <!-- 当环节为指令/建议下达时没有退办、转办、征求意见选项 -->
				  <l:in property="workitem/activityDefID" targetValue="manualActivity">
		           <input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
						data="[{id: 1, text: '同意'},{id: 5, text: '否决'}]" style="float: left;" value="1"/>
				  </l:in>
				  
				  <!-- 当环节为用印时增加用印选项 执行动作跟同意一样 -->
				  <l:in property="workitem/activityDefID" targetValue="manualActivity8">
		           <input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
						data="[{id: 1, text: '同意'}, {id: 1, text: '用印'} ,{id: 2, text: '退办'},{id: 3, text: '转办'},{id: 4, text: '征求意见'},{id: 5, text: '否决'}]" style="float: left;" value="1"/>
				  </l:in>
				  
				  <!-- 当不等于这两个环节时，显示全部属性 -->
				  <l:notIn property="workitem/activityDefID" targetValue="manualActivity4,manualActivity,manualActivity5,manualActivity9,manualActivity8">
			           <input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
							data="[{id: 1, text: '同意'}, {id: 2, text: '退办'},{id: 3, text: '转办'},{id: 4, text: '征求意见'},{id: 5, text: '否决'}]" style="float: left;" value="1"/>		
				  </l:notIn>		 
						 <font style="color: red; margin-left: 40px;"></font><span id="handlerActorTitle"></span>
						 <input class="nui-buttonedit" id="sendUser"  name="bpsParam.sendUser" onclick="selectSendUser" style="display: none;"/>
						<input class="nui-buttonedit" id="selectUser"  name="bpsParam.selectUser" onclick="selectActor" style="display: none;"/>
						<input class="nui-buttonedit" id="handlerActor"  name="bpsParam.handlerActor" onclick="selectActor" style="display: none;"/>
		         </td>
		         <td class="td1">
		          <!-- 打开方式为待办时显示 -->
		          <l:equal property="pageType" targetValue="1">
			           <a class='nui-button' plain='false' iconCls="icon-save" onclick="processSubmit()">
	                                                                        提交
	                   </a>
	                   <l:in property="workitem/activityDefID" targetValue="manualActivity10,manualActivity14">
	                    <span style="display:inline-block;width:15px;"></span>
	                   	<a class='nui-button' plain='false' iconCls="icon-download" onclick="wordDownload()">
	                                                                         新债信息表下载
	                   </a>
	                   </l:in>
	                   <span style="display:inline-block;width:15px;"></span>
	                   <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow('close')">
	                                                                         返回
	                   </a>
	                   <!-- <l:in property="workitem/activityDefID" targetValue="manualActivity3">
	                    <span style="display:inline-block;width:15px;"></span>
	                   	<a class='nui-button' plain='false' iconCls="icon-download" onclick="sendFaxes()">
	                                                                        发送传真
	                   </a>
	                   </l:in> -->
	                   <span style="display:inline-block;width:15px;"></span>
	                   <a class='nui-button' plain='false' iconCls="icon-print" onclick="Print()">
	                                                                        打印
	                   </a>
	                  </l:equal> 
	                  <l:equal property="pageType" targetValue="2">
	                    <a class='nui-button' plain='false' iconCls="icon-print" onclick="Print()">
	                                                                        打印
	                   </a>
                  </l:equal>
		         </td>
		       </tr>
		       <!-- 退办 -->
		       <tr id="backActivity_tr" style="display: none;">
					<th class="nui-form-label td1">退办：</th>
					<td colspan="3" class="td2">
						<input id="backActivity" name="bpsParam.backActivity" class="nui-combobox" onvaluechanged="backActivityChanged" textField="activityInstName" valueField="activityDefID"  style="width: 300px">
						<input id="isFallback" name="bpsParam.isFallback" class="nui-checkbox" trueValue="1" falseValue="0"/>退办后的节点通过后直接返回本节点
					</td>
				</tr>

				<!-- 环节为缴款复核 -->
               <l:equal property="workitem/activityDefID" targetValue="manualActivity10">
               	 <l:notIn property="cfjybusinessbonetable/vcSource" targetValue="2">
	                 <tr>
				         <td class="td1 " width="20%" style="border-bottom: 1px solid #D3D3D3;">是否用印：</td>
				         <td colspan="3" class="radio-border-top-none td2" style="border-bottom: 1px solid #D3D3D3;"> 
				            <input name="bpsParam.yn" id="yn" class="nui-radiobuttonlist" 
							data="[{id: 1, text: '是'}, {id: 3, text: '否'}]" value="1"/>
				         </td>
			         </tr>
		         </l:notIn>
               </l:equal>
               
               <l:equal property="workitem/activityDefID" targetValue="manualActivity9">
               		<l:equal property="cfjybusinessbonetable/vcSource" targetValue="2">
               			<tr>
					         <td class="td1 " width="20%" style="border-bottom: 1px solid #D3D3D3;">是否用印：</td>
					         <td colspan="3" class="radio-border-top-none td2" style="border-bottom: 1px solid #D3D3D3;"> 
					            <input name="bpsParam.yn" id="yn" class="nui-radiobuttonlist" 
								data="[{id: 1, text: '是'}, {id: 3, text: '否'}]" value="1"/>
					         </td>
		        		 </tr>
               		</l:equal>
               </l:equal>
               <!-- 合同协议审核环节 -->
               <!-- <l:equal property="workitem/activityDefID" targetValue="manualActivity11">
                 <tr>
			         <td class="td1 " width="20%" style="border-bottom: 1px solid #D3D3D3;">合同协议审核是否通过：</td>
			         <td colspan="3" class="radio-border-top-none td2" style="border-bottom: 1px solid #D3D3D3;"> 
			            <input name="bpsParam.yn" id="yn" class="nui-radiobuttonlist" 
						data="[{id: 5, text: '是'}, {id: 2, text: '否'}]"/>
			         </td>
		         </tr>
               </l:equal> -->
               <tr>
		         <td class="td1">处理意见：</td>
		         <td colspan="3" class="td2"><input id="comments" class="nui-textarea" name="pmprcaprvinfo.comments" width="600" height="60" value="同意"/></td>
		       </tr>
		       <l:notIn property="workitem/activityDefID" targetValue="manualActivity3">
               <tr>
		         <td class="td1" style="border-bottom: 1px solid #D3D3D3;">附件上传：</td>
		         <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
		         <!-- 判断当前环节是用印与协议用印环节时。附件上传列表加入是否用印选项 -->
		          <l:equal property="workitem/activityDefID" targetValue="manualActivity8">
		           	   <iframe id="prodIfm" width="100%" height="130px"  frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"  src="<%= request.getContextPath() %>/process/fileupload/any_upload_India.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>&workItemID=<%=workItemID %>&attachType=0&attachBusType=0" ></iframe>
		          </l:equal>
		          <l:equal property="workitem/activityDefID" targetValue="manualActivity12">
		               <iframe id="prodIfm" width="100%" height="130px"  frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"  src="<%= request.getContextPath() %>/process/fileupload/any_upload_India.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>&workItemID=<%=workItemID %>&attachType=0&attachBusType=0" ></iframe>
		          </l:equal>
		          
		          <!-- 环节等于信息复核(交易员1) -->
		          <l:equal property="workitem/activityDefID" targetValue="manualActivity1">
		               <iframe id="prodIfm" width="100%" height="130px"  frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"  src="<%= request.getContextPath() %>/process/fileupload/any_upload_AnnexSeal.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>&workItemID=<%=workItemID %>&attachType=0&attachBusType=0&activityDefID=<b:write property="workitem/activityDefID" />" ></iframe>
		          </l:equal>
		          <!-- 环节等于修改执行(交易员1) -->
		          <l:equal property="workitem/activityDefID" targetValue="manualActivity6">
		               <iframe id="prodIfm" width="100%" height="130px"  frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"  src="<%= request.getContextPath() %>/process/fileupload/any_upload_AnnexSeal.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>&workItemID=<%=workItemID %>&attachType=0&attachBusType=0&activityDefID=<b:write property="workitem/activityDefID" />" ></iframe>
		          </l:equal>
		          <!-- 环节等于缴款复核 -->
		          <l:equal property="workitem/activityDefID" targetValue="manualActivity10">
		               <iframe id="prodIfm" width="100%" height="130px"  frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"  src="<%= request.getContextPath() %>/process/fileupload/any_upload_AnnexSeal.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>&workItemID=<%=workItemID %>&attachType=0&attachBusType=0&activityDefID=<b:write property="workitem/activityDefID" />" ></iframe>
		          </l:equal>
		          
		          <!-- 不等于用印、协议用印、信息复核(交易员1)、修改执行(交易员1)、缴款复核等环节时显示 -->
		          <l:notIn property="workitem/activityDefID" targetValue="manualActivity12,manualActivity1,manualActivity6,manualActivity10,manualActivity8">
		              <iframe id="prodIfm" width="100%" height="130px"  frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"  src="<%= request.getContextPath() %>/process/fileupload/any_upload.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>&workItemID=<%=workItemID %>&attachType=0&attachBusType=0&type=1" ></iframe>  
		          </l:notIn>
		         </td>
		       </tr>
		       </l:notIn>
		       <l:equal property="workitem/activityDefID" targetValue="manualActivity3">
		        <tr>
		         <td class="td1" style="border-bottom: 1px solid #D3D3D3;">主题：</td>
		         <td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
		           <input class="nui-textbox" name="bpsParam.theme" id="theme" width="170px"/>
		         </td>
		         <td class="td1" style="border-bottom: 1px solid #D3D3D3;">接收人传真号：</td>
		         <td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
		           <input class="nui-textbox" name="bpsParam.FaxNumber" id="FaxNumber" width="170px"/>
		         </td>
		        </tr>
		        <tr>
		         <td class="td1" style="border-bottom: 1px solid #D3D3D3;">接收人姓名：</td>
		         <td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
		           <input class="nui-textbox" name="bpsParam.recvName" id="recvName" width="170px"/>
		         </td>
		         <td class="td1" style="border-bottom: 1px solid #D3D3D3;">接收人公司名称：</td>
		         <td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
		           <input class="nui-textbox" name="bpsParam.recvCompany" id="recvCompany" width="170px"/>
		         </td>
		        </tr>
		        <tr>
		         <td class="td1" style="border-bottom: 1px solid #D3D3D3;">传真备注：</td>
		         <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
		           <input class="nui-textarea" name="bpsParam.faxComments" id="faxComments" width="500px" height="80px"/>
		         </td>
		        </tr> 
		       </l:equal>
		    </table>
		    <l:equal property="pageType" targetValue="1">
		   		 <div>
	          		<a class='nui-button' plain='false' id="fileDownload" iconCls="icon-download" onclick="fileDownload1()" style="margin-top: 5px;" plain="false">下载</a>
	        	 </div>
	        </l:equal>	 
		          <div id="file_Form">
			         <input class="nui-hidden" name="map/bizId" value="<%=bizId %>"/>
			         <input class="nui-hidden" name="map/attachBusType" value="0"/>
			         <input class="nui-hidden" name="map/processinstid" value="<%=processinstid %>"/>
		          </div>
		          <div id="file_grid" class="mini-datagrid" style="width:100%;height:265px;" 
	            	url="com.cjhxfund.jy.process.attachUitlFunction.queryAttachmentList.biz.ext" 
	              dataField="attachments"  showPageInfo="true" multiSelect="true" allowSortColumn="false">
	            <div property="columns">
	                <div type="checkcolumn" width="20">
                    </div>
                    <div field="sysid"  headerAlign="center" visible="false">编号</div> 
	                <div field="name"  headerAlign="center" style="width: 70%;" allowSort="true">文件名</div> 
	                <div field="workitemname"  headerAlign="center" allowSort="true" width="50" headerAlign="center">环节名称</div>
	                <div field="annexseal" type="checkboxcolumn" trueValue="1" falseValue="0" width="30" headerAlign="center">是否用印</div>               
					<div field="whetherindia" type="checkboxcolumn" trueValue="1" falseValue="0" width="40" headerAlign="center">是否用过印</div>
					
	            </div>
	        </div>    
		     
	    <div>
	        <!-- 文档下载  -->
			<form id="file_download" method="post">
				<!-- 数据实体的名称 -->
				<input class="nui-hidden" name="processId" value="<%=processinstid %>"/>
				<input class="nui-hidden" name="sysid"  id="sysid"/>
				<input class="nui-hidden" name="workitemid"  id="workitemid2" value="<%=workItemID %>"/>
			</form>	
	    </div>
	    
	    <div>
	        <!-- word文档下载  -->
			<form id="word_download" method="post">
				<!-- 数据实体的名称 -->
				<input class="nui-hidden" name="bizId"  id="bizId1"/>
				<!-- 还本方式 -->
				<input class="nui-hidden" name="modeRepayment"  id="modeRepayment1"/>
				<!-- 计息起始日 -->
				<input class="nui-hidden" name="startingDateInterest"  id="startingDateInterest1"/>
				<!-- 计息截止日 -->
				<input class="nui-hidden" name="deadlineInterest"  id="deadlineInterest1"/>
				<!-- 票面利率 -->
				<input class="nui-hidden" name="couponRate"  id="couponRate1"/>
				<!-- 发行价格 -->
				<input class="nui-hidden" name="issuePrice"  id="issuePrice1"/>
			</form>	
	    </div>
<!--隐藏表单 在线文档用印-->
<form action="" name="openForm" method="post" target="_blank">
  <input type="hidden" name="sysId" id="sysId">
</form>
<!-- 打印文档 -->
<form action="" name="PrintForm" method="post" target="_blank">
  <input type="hidden" name="processinstid" id="sysId" value="<%=processinstid %>"/>
</form>

<script>
  //用印环节用印，双击打开文档
    <%-- var file_grid = nui.get("file_grid");
    file_grid.on("rowdblclick", function (e) {
    	var record = e.record;
    	var actionURL="<%=request.getContextPath() %>/commonUtil/JQMHistory/iWebOffice/Judgment_document_type.jsp?sysid="+record.sysid+"&fileName="+record.name; //目标页面
		var tabs = nui.get("tab"); 
		
		//add tab
        var tab = {title: "文件用印",url:actionURL};
        tab = tabs.addTab(tab);            

        //active tab
        tabs.activeTab(tab);
	});	 --%>
	var myActivityDefID = "<b:write property="workitem/activityDefID" />";
	function backActivityChanged(e){
	   nui.get("comments").setValue("退办 : " + "'"+ nui.get("backActivity").getText() +"'环节");
	}
	
	
</script>
	    