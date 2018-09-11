<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<table style="width:100%;table-layout:fixed;" border="0" class="nui-form-table">
		 <l:in property="workitem/activityDefID" targetValue="FirstGradeBond_KZJ_YY" >
		     <tr>
		         <td colspan="1" class="td1">主题: </td>
		         <td colspan="3" class="td2">[<b:write property="cfjybusinessbonetable/investproductnum" />]-<b:write property="cfjybusinessbonetable/combProductName" />-<b:write property="cfjybusinessbonetable/investProductName" /></td>
		     </tr>
		  </l:in>
		       <tr>
		         <td class="td1" width="20%">当前节点：</td>
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
		          <l:equal property="workitem/activityDefID" targetValue="FirstGradeBond_KZJ_TGFH">
		           <input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
						data="[{id: 1, text: '同意'}, {id: 2, text: '退办'},{id: 5, text: '否决'}]" value="1" style="float: left;"/>
				  </l:equal>
				  <!-- 当环节为指令/建议下达时没有退办、转办、征求意见选项 -->
				  <l:equal property="workitem/activityDefID" targetValue="FirstGradeBond_KZJ_SGZL">
		           <input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
						data="[{id: 1, text: '同意'},{id: 5, text: '否决'}]" value="1" style="float: left;"/>
				  </l:equal>
				  
				  <!-- 当环节为用印时增加用印选项 执行动作跟同意一样 -->
				  <l:in property="workitem/activityDefID" targetValue="FirstGradeBond_KZJ_YY">
		           <input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
						data="[{id: 1, text: '同意'}, {id: 1, text: '用印'} ,{id: 2, text: '退办'},{id: 3, text: '转办'},{id: 4, text: '征求意见'},{id: 5, text: '否决'}]" style="float: left;" value="1"/>
				  </l:in>
				  
				  <!-- 当不等于这两个环节时，显示全部属性 -->
				  <l:notIn property="workitem/activityDefID" targetValue="FirstGradeBond_KZJ_TGFH,FirstGradeBond_KZJ_SGZL,FirstGradeBond_KZJ_YY">
			           <input name="bpsParam.operateType" id="operateType" class="nui-radiobuttonlist" onitemclick="operateCheck(this)" 
							data="[{id: 1, text: '同意'}, {id: 2, text: '退办'},{id: 3, text: '转办'},{id: 4, text: '征求意见'},{id: 5, text: '否决'}]" value="1" style="float: left;"/>		
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
                   <l:equal property="workitem/activityDefID" targetValue="FirstGradeBond_KZJ_XXHD1">
                    <span style="display:inline-block;width:15px;"></span>
                   	<a class='nui-button' plain='false' iconCls="icon-download" onclick="wordDownload()">
                                                                         新债信息表下载
                   </a>
                   </l:equal>
                   <span style="display:inline-block;width:15px;"></span>
                   <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow('close')">
                                                                         返回
                   </a>
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
						<input id="backActivity" name="bpsParam.backActivity" onvaluechanged="backActivityChanged" class="nui-combobox"   textField="activityInstName" valueField="activityDefID"  style="width: 300px">
						<input id="isFallback" name="bpsParam.isFallback" class="nui-checkbox" trueValue="1" falseValue="0"/>退办后的节点通过后直接返回本节点
					</td>
				</tr>
				<l:equal property="workitem/activityDefID" targetValue="FirstGradeBond_KZJ_ZQQR">
				   <td class="td1" style="border-bottom: 1px solid #D3D3D3;">中签数量：</td>
			         <td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			           <input class="nui-textbox" name="cfjybusinessbonetable.ballotNumber" id="ballotNumber" onblur="ballotNumberFun"
			           value="<b:write property="cfjybusinessbonetable/ballotNumber" />" width="170px" required="true"/>
			         </td>
			         <td class="td1" style="border-bottom: 1px solid #D3D3D3;">中签金额：</td>
			         <td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			           <input class="nui-textbox" name="cfjybusinessbonetable.ballotMoney" id="ballotMoney" onblur="ballotMoneyFun()"
			           value="<b:write property="cfjybusinessbonetable/ballotMoney" />" width="170px" required="true"/>
			         </td>
				</l:equal>
               <tr>
		         <td class="td1">处理意见：</td>
		         <td colspan="3" class="td2"><input id="comments" class="nui-textarea" name="pmprcaprvinfo.comments" width="600" height="60" value="同意"/></td>
		       </tr>
		        <l:equal property="workitem/activityDefID" targetValue="FirstGradeBond_KZJ_CZ">
		          <tr>
			         <td class="td1" style="border-bottom: 1px solid #D3D3D3;">传真号：</td>
			         <td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			           <input class="nui-textbox" name="bpsParam.FaxNumber" id="FaxNumber" width="170px"/>
			         </td>
			         <td class="td1" style="border-bottom: 1px solid #D3D3D3;">主题：</td>
			         <td colspan="1" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			           <input class="nui-textbox" name="bpsParam.theme" id="theme" width="170px"/>
			         </td>
			       </tr>  
			       </l:equal>
		       <tr>
			       <l:notIn property="workitem/activityDefID" targetValue="FirstGradeBond_KZJ_CZ">
	               
			         <td class="td1" style="border-bottom: 1px solid #D3D3D3;">附件上传：</td>
			         <td colspan="3" class="td2" style="border-bottom: 1px solid #D3D3D3;">
			         <l:equal property="workitem/activityDefID" targetValue="">
			         </l:equal>
			         <!-- 判断当前环节是用印环节时。附件上传列表加入是否用印选项 -->
			          <l:equal property="workitem/activityDefID" targetValue="FirstGradeBond_KZJ_YY">
			           	   <iframe id="prodIfm" width="100%" height="130px"  frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"  src="<%= request.getContextPath() %>/process/fileupload/any_upload_India.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>&workItemID=<%=workItemID %>&attachType=0&attachBusType=0" ></iframe>
			          </l:equal>
	
			          <!-- 环节等于信息复核(交易员1) -->
			          <l:equal property="workitem/activityDefID" targetValue="FirstGradeBond_KZJ_XXHD1">
			               <iframe id="prodIfm" width="100%" height="130px"  frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"  src="<%= request.getContextPath() %>/process/fileupload/any_upload_AnnexSeal.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>&workItemID=<%=workItemID %>&attachType=0&attachBusType=0&activityDefID=<b:write property="workitem/activityDefID" />" ></iframe>
			          </l:equal>
	
			          <!-- 不等于用印、信息复核(交易员1)环节时显示 -->
			          <l:notIn property="workitem/activityDefID" targetValue="FirstGradeBond_KZJ_YY,FirstGradeBond_KZJ_XXHD1">
			              <iframe id="prodIfm" width="100%" height="130px"  frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no"  src="<%= request.getContextPath() %>/process/fileupload/any_upload.jsp?bizId=<%=bizId %>&processinstid=<%=processinstid %>&workItemID=<%=workItemID %>&attachType=0&attachBusType=0&type=1" ></iframe>  
			          </l:notIn>
			         </td>
			       </l:notIn>
		        </tr>
		    </table>
		   <table width="100%">
		     <tr>
		      <%-- <td width="60%">
		         <div class="nui-panel" title="流程审批信息"  style="width:100%;height: 20px;margin-top: 5px;" showToolbar="false" showFooter="true" >
		   		 </div>
		         <!-- 流程处理信息列表 -->
		         <div id="grid_form">
			      <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.process.FirstGradeBond.PmPrcAprvInfo"/>
			      <input class="nui-hidden" name="criteria/_expr[1]/processInstId" value="<%=processinstid %>"/>
			      <input class="nui-hidden" name="cirteria/_expr[1]/_op" value="="/>
		   		 </div>
					<div id="deptGrid" class="nui-datagrid" style="width:100%;height:230px;"
				        url="com.cjhxfund.jy.process.PmPrcAprvInfo.queryPmPrcAprvInfoList.biz.ext"  
				        onshowrowdetail="onShowRowDetail" dataField="PmPrcAprvInfos" pageSize="10" showPageInfo="true"
			                        multiSelect="true" allowSortColumn="true">
			        <div property="columns">            
			            <div type="expandcolumn" >#</div>
			            <div field="workItemId"  headerAlign="center" visible="false">工作项ID</div> 
			            <div field="sysid"  headerAlign="center" visible="false">编号</div> 
			            <div field="processInstId"  headerAlign="center" visible="false">流程ID</div>
			            <div field="createTime"  headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss">审批时间</div>                                        
			            <div field="workItemName"  headerAlign="left" >节点名称</div>   
			            <div field="userName"  headerAlign="left" >操作者</div>  
			            <div field="operateType"  headerAlign="left" renderer="rendeRoperateType">操作</div>  
			            <div field="comments"  headerAlign="left" >处理意见</div>         
			        </div>
			       </div> 
		       </td>--%>
		       <td width="100%">
		         <!--  <div class="nui-panel" title="附件列表"  style="width:100%;height: 20px;margin-top: 5px;" showToolbar="false" showFooter="true" >
		   		 </div> -->
		   		 <div>
	          		<a class='nui-button' plain='false' id="fileDownload" iconCls="icon-download" onclick="fileDownload1()" style="margin-top: 5px;" plain="false">下载</a>
	        	 </div>
		          <div id="file_Form">
			         <input class="nui-hidden" name="map/bizId" value="<%=bizId %>"/>
			         <input class="nui-hidden" name="map/attachBusType" value="0"/>
			         <input class="nui-hidden" name="map/processinstid" value="<%=processinstid %>"/>
		          </div>
		          <div id="file_grid" class="mini-datagrid" style="width:100%;height:225px;" 
	            	url="com.cjhxfund.jy.process.attachUitlFunction.queryAttachmentList.biz.ext" 
	              dataField="attachments"  showPageInfo="true" multiSelect="true" allowSortColumn="false">
	            <div property="columns">
	                <div type="checkcolumn" width="20">
                    </div>
                    <div field="sysid"  headerAlign="center" visible="false">编号</div> 
	                <div field="name"  headerAlign="center" allowSort="true">文件名</div> 
	                <div field="workitemname"  headerAlign="center" allowSort="true" width="40" headerAlign="center">环节名称</div>
	                <div field="annexseal" type="checkboxcolumn" trueValue="1" falseValue="0" width="30" headerAlign="center">是否用印</div>               
					<div field="whetherindia" type="checkboxcolumn" trueValue="1" falseValue="0" width="40" headerAlign="center">是否用过印</div>
					
	            </div>
	        </div>    
		       </td>
		     </tr>
		   </table>
		   
		   <div id="detailGrid_Form" style="display:none;width: 800px;float: right;">
	        <div>
	          <a class='nui-button' plain='false' id="fileDownload" iconCls="icon-download" onclick="fileDownload()"	plain="false">下载</a>
	        </div>
	        <div id="employee_form">	          
	          <input class="nui-hidden" name="processId" id="processId"/>
			  <input class="nui-hidden" name="workitemid" id="workitemid1"/>
	        </div>
	        <div id="employee_grid" class="mini-datagrid" style="width:100%;height:100px;" 
	            url="com.cjhxfund.jy.process.PmPrcAprvInfo.queryAttachmentList.biz.ext" idField="id"
	              dataField="attachments"  showPageInfo="false" allowResize="true"  multiSelect="true" allowSortColumn="false">
	            <div property="columns">
	                <div type="checkcolumn" width="20">
                    </div>
                    <div field="sysid"  headerAlign="center" visible="false">编号</div> 
	                <div field="attachName"  headerAlign="center" allowSort="true">文件名</div>                
	              <%--  <div field="attachSize" width="40" allowSort="true"  align="center" headerAlign="center">文件大小
	                
	                </div> --%>           
	               
	            </div>
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
				<!-- 计息截止日 -->
				<input class="nui-hidden" name="deadlineInterest"  id="deadlineInterest1"/>
				<!-- 票面利率 -->
				<input class="nui-hidden" name="couponRate"  id="couponRate1"/>
				<!-- 发行价格 -->
				<input class="nui-hidden" name="issuePrice"  id="issuePrice1"/>
				<!-- 计息起始日 -->
				<input class="nui-hidden" name="startingDateInterest"  id="startingDateInterest1"/>
			</form>	
	    </div>
	    <!-- 打印文档 -->
		<form action="" name="PrintForm" method="post" target="_blank">
		  <input type="hidden" name="processinstid" id="sysId" value="<%=processinstid %>"/>
		</form>
	    <script>
	      function rendeRoperateType(e){
	          if(e.row.operateType == 1){
	            return "同意";
	          }
	          if(e.row.operateType == 2){
	            return "退办";
	          }
	          if(e.row.operateType == 3){
	            return "转办";
	          }
	          if(e.row.operateType == 4){
	            return "征求意见";
	          }
	          if(e.row.operateType == 5){
	            return "否决";
	          }
	          if(e.row.operateType == 98){
				return "修改";
			  }
          }
          
          function backActivityChanged(e){
			  nui.get("comments").setValue("退办 : " + "'"+ nui.get("backActivity").getText() +"'环节");
		  }
	    </script>