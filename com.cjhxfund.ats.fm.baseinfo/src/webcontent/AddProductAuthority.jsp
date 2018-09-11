<%@page pageEncoding="UTF-8"%>
<%-- <%@page import="com.eos.data.datacontext.UserObject"%>
<% 
	UserObject user = (UserObject)session.getAttribute("userObject");
%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/common/js/commscripts.jsp" %>
<html>
<!-- 
  - Author(s): 章璐
  - Date: 2016-10-25 17:24:51
  - Description:
-->
<head>
<title>新增产品权限</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style>
    /*如果样式有调整 需要重新定位 这个id */
    #mini-71{
    	width:60px!important;
    }
    .mini-popup{
    	height:auto!important;
    }
    .mini-listbox-view{
    	height:auto!important;
    }
    </style>
</head>
<body>
<div id="dataform1" style="width:100%;height:100%;" class="nui-form">
	<div style="height: 10%;text-align: center;border: 1px solid #a5acb5;">
		 <div style="margin-top: 20px;">
		 <span style="color:red">*</span><span>权限类型:</span>
		 <span><input id="relaType" class="nui-dictcombobox" dictTypeId="CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE" name="TAtsProductHandle.vcRelateType" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" width="220px" height="400px!important" multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty"/></span>
		 <input class="nui-button" plain="false" iconCls="icon-help" onclick="showHelp()" plain="false" tooltip="帮助"/>
		 </div>
	</div>
	<div style="width: 100%;height: 84%;">
		<div class="mini-tabs" activeIndex="0"  style="width: 100%;height: 100%;">
		    <div title="关联用户">
		         <div class="mini-splitter" style="width:100%;height:100%;">  
				    <div size="20%" showCollapseButton="true">
				         <div id="deptsearch" class="mini-fit" style="height:100%;" borderStyle="border:0;"> 
				            <ul id="depttree" class="nui-tree" url="com.cjhxfund.jy.process.common.findAllorganization.biz.ext" style="width:100%;height:100%;"
				                showTreeIcon="true" textField="orgname" idField="orgid" 
				                parentField="parentorgid" dataField="organizations" resultAsTree="false" showExpandButtons="true" expandOnLoad="true">        
				            </ul>
				        </div>
				      </div>
				    <div size="80%" showCollapseButton="true"> 
				    	<div id="form1" class="nui-form" align="left" style="height:40px;">
				            <!-- 数据实体的名称 -->
				            <!-- 排序字段 -->
				            <table id="table1" class="table" style="height:100%; width: "300px";">
				                <tr>
				                    <td class="form_label" style="text-align: right">
				                        员工姓名:
				                    </td>
				                    <td colspan="1">
				                        <input class="nui-textbox" id="targetName"/>
				                    </td>
				                    <td class="form_label" style="text-align: right">
				                        员工账号:
				                    </td>
				                    <td colspan="1">
				                        <input class="nui-textbox" id="userid"/>
				                    </td>
				                    <td colspan="1">
										<a class='nui-button' plain='false' iconCls="icon-search" onclick="search(1)"> 查询 </a>
					            		<a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">重置</a>
									</td>
				                </tr>
				            </table>
				        </div>
				         <div class="nui-fit" style="width:100%;height:30%;">
				            <div 
				                id="usergrid1"
				                dataField="data"
				                class="nui-datagrid"
				                style="width:100%;height:100%;"
				                url="com.cjhxfund.ats.fm.comm.common.DeptUserListToALL.biz.ext"
				                allowCellSelect="true"
				                allowUnselect="true"   
				                showPageInfo="false"
				                showPager="false"
				                onrowdblclick="select1"
				                multiSelect="true"
				                allowSortColumn="false">
				                <div property="columns">
				                	<div type="indexcolumn" width="20" headerAlign="center" align="center">序号</div>
				                    <div field="targetName" width="100" headerAlign="center" align="center" allowSort="true">员工姓名</div>
				                   <div field="userid" width="80" headerAlign="center"  align="center" allowSort="true">员工帐号</div>
				                   <div field="orgname" width="100" headerAlign="center"  align="center" allowSort="true">所属机构</div>
				                   <div type="checkcolumn"></div>
				                </div>
				            </div>  
				        </div>
				        <div class="nui-fit" style="height:30px">
				      		<div style="width:200px;float:left;margin-top:3px;">已选关联用户</div>
				      		<span><a  class='nui-button' plain='false' style="margin-top:3px;" onclick="downmove()" >下移</a></span>
				      		<span><a  class='nui-button' plain='false' style="margin-top:3px;" onclick="downmoveAll()" >全部下移</a></span>
				      		<span><a  class='nui-button' plain='false' style="margin-top:3px;" onclick="removeselects()" >移除</a></span>
				      		<span><a  class='nui-button' plain='false' style="margin-top:3px;" onclick="removeselectsAll()" >全部移除</a></span>
				        </div>
				        <div class="nui-fit" style="width:100%;height:30%;">
				            <div 
				                id="usergrid2"
				                class="nui-datagrid"
				                style="width:100%;height:100%;"
				                showPageInfo="false"
				                showPager="false"
				                multiSelect="true"
				                allowSortColumn="false">
				                <div property="columns">
				                	<div type="indexcolumn" width="20" headerAlign="center" align="center">序号</div>
				                    <div field="targetName" width="100" headerAlign="center" align="center" allowSort="true">员工姓名</div>
				                   <div field="userid" width="80" headerAlign="center"  align="center" allowSort="true">员工帐号</div>
				                   <div field="orgname" width="100" headerAlign="center"  align="center" allowSort="true">所属机构</div>
				                   <div type="checkcolumn"></div>
				                   <div name="action" width="30" headerAlign="center" align="center">移除</div>
				                </div>
				            </div>
				            <input id="userIdList" class="nui-hidden" name="TAtsProductHandle.vcUserId"/>
				            <input id="userName" class="nui-hidden" name="TAtsProductHandle.vcUserName"/>  
				        </div>
				    </div>        
				</div>   
		    </div>
		    <div title="产品&组合名称">
		    	     <table style="width:100%;height:100%;">
		    	     <tr>
		    	     		<td class="form_label" colspan="3" width="200px" height="30px">
                    	      查询条件:<input  class="nui-textbox"  name="searchKey" id="searchKey" width="25%"/>
		        		      产品状态:<input class="nui-dictcombobox" id="cProductStatus"  valueField="dictID" textField="dictName" dictTypeId="productStatus"  
									emptyText="全部" nullItemText="全部" width="10%"  showClose="true" oncloseclick="onCloseClickValueEmpty" />
		        				<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="searchprod()"/>
							    <a id="query" class='nui-button' plain='false' iconCls="icon-reload" onclick="resetprod()">重置</a>                    
							</td>
							<!-- <td colspan="1" width="35%" align="left">
                        			
							</td>
							<td align="left">
								
							</td> -->
		    	     </tr>
				      <tr>
				         <td>可选产品&组合名称</td>
				         <td></td>
				         <td>已选产品&组合名称</td>
				      </tr>
				      <tr style="width:100%;height:100%;">
				         <td style="width:45%;height:100%;vertical-align:top;">		
							<div id="productinfo1" 
							class="nui-datagrid" 
							style="width:100%;height:100%;" 
							multiSelect="true"
							allowCellSelect="true"
				            allowUnselect="true"
                        	showPageInfo="true"
				            showPager="true" 
				            pageSize="20"
				            sizeList="[20,50,100,500,1000]"
				            url="com.cjhxfund.ats.fm.comm.common.getProductCombisByKey.biz.ext">
                        		<div property="columns">
                        			<div type="indexcolumn" width="10" headerAlign="center" align="center">序号</div>
                        			<div header="选择" field="fundInfo" style="width:700px;"></div>
                        			<div type="checkcolumn" width="20"></div>
                        		</div>
                			</div>
				       </td>
				         <td style="width:10%;">
				            <table style="width:100%;">
						    	<tr>
						    	  <td align="center">
						    	    <input type="button" id="addBtn" style="width:65px;text-align:center;" class='nui-button' plain='false' onclick="addEmpResource" text=">" />
						    	  </td>
						    	</tr><%-- 添加 --%>
								<tr>
								  <td align="center">
								    <input type="button" id="allDeleteBtn" class='nui-button' plain='false' style="width:65px;text-align:center;" text=">>" onclick="addAllOrgResource"/>
								  </td>
								</tr><%-- 全部添加 --%>
								<tr>
						    	  <td align="center">
						    	  		&nbsp;
						    	  </td>
						    	</tr>
								<tr>
								  <td align="center">
								    <input type="button" id="allDeleteBtn" class='nui-button' plain='false' style="width:65px;text-align:center;" text="&lt;&lt;" onclick="deleteAllOrgResource"/>
								  </td>
								</tr><%-- 全部删除 --%>
								<tr>
								  <td align="center">
								    <input type="button" id="deleteBtn" class='nui-button' plain='false' style="width:65px;text-align:center;" text="&lt;" onclick="deleteEmpResource" />
								  </td>
								</tr><%-- 删除 --%>
							</table>
				         </td>
				         <td style="width:45%;height:100%;">
							<div id="productinfo2" 
							class="nui-datagrid" 
							style="width:100%;height:100%;" 
							name="TAtsProductHandle.vcProductCode" 
							multiSelect="true"
							allowCellSelect="true"
				            allowUnselect="true"
                        	showPageInfo="false"
				            showPager="false">
                        		<div property="columns">
                        			<div type="indexcolumn" width="10" headerAlign="center" align="center">序号</div>
                        			<div header="选择" field="fundInfo" style="width:700px;"></div>
                        			<div type="checkcolumn" width="20"></div>
                        		</div>
                			</div>
                			<input id="combProductCode" class="nui-hidden" name="TAtsProductHandle.vcProductCode"/>
                			<input id="combProductName" class="nui-hidden" name="TAtsProductHandle.vcProductName"/>
	                        <input id="vcCombiNo" class="nui-hidden" name="TAtsProductHandle.vcCombiNo"/>
	                        <input id="vcCombiName" class="nui-hidden" name="TAtsProductHandle.vcCombiName"/>
	                        <input id="vcAssetId" class="nui-hidden" name="vcAssetId"/>
	                        <input id="vcProductId" class="nui-hidden" name="vcProductId"/>
	                        <input id="vcCombiId" class="nui-hidden" name="vcCombiId"/>
				         </td>
				      </tr>
				   </table>
		    </div>
		</div>
	</div>
	<div style="display:none" property="footer" class="mini-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">
		<div >选择用户和机构：</div>
		<div>
		<input id="selectUsers" class="mini-textboxlist" textName="selectUsersName" required="true" style="width:100%;height:50px;"
		        value="" text=""
		        valueField="id" textField="text"/>
		</div>
	</div>
    <div class="nui-toolbar" style="padding:0px;height: 5%" borderStyle="border:0;">
	    <table width="100%">
	        <tr>
	            <td style="text-align:center;" colspan="4">
	                <a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">
	                    保存
	                </a>
	                <span style="display:inline-block;width:25px;">
	                </span>
	                <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
	                    取消
	                </a>
	            </td>
	        </tr>
	    </table>
	</div>
</div>

	<script type="text/javascript">
    		nui.parse(); 
		    var _minSize = 0;//最小选择
		    var _maxSize= 10;//最大选择
		    var currentOrgid = '<%=userObject.getUserOrgId() %>';
		    var form = new nui.Form("#dataform1");
			var grid = nui.get("usergrid1");
			var grid2 = nui.get("usergrid2");
			var productinfo1 = nui.get("productinfo1");
			var productinfo2 = nui.get("productinfo2");
			productinfo1.load();
			var selectUserObj = nui.get("selectUsers");
			var _selectVal = [] ;
			selectUserObj.on("valuechanged", onValueChanged);
			function saveData(){
				form.validate();
				if (form.isValid() == false) {
					nui.alert("请检查必填项！");
					return;
				}
				var urlStr = "com.cjhxfund.ats.fm.baseinfo.TAtsProductHandleBiz.addTAtsProductHandle.biz.ext";
                /**
                	权限类型特殊验证：
					1、创金员工、非创金员工公共权限类型：
					00-组合查询权限；
					
					2、投顾、委托人等非创金员工权限类型：
					01-组合与投资录入权限；
					07-组合与投资确认权限；
					A4-需要投顾风控确认；
					A5-组合与投顾风控确认权限；
					A2-需要委托人确认；
					A3-组合与委托人确认权限；
					A1-投资录入确认可为同一人员；
					
					3、投资经理、交易员等创金员工权限类型：
					02-组合与投资/基金经理权限；
					03-组合与询价结果录入权限；
					04-组合与交易录单确认权限；
					05-组合与交易录单复核权限；
					06-组合与资金手工交收权限；
					08-组合与资金交收设置权限；
					09-组合与中标确认交易员审批权限；
					99-交易确认阶段权限；
					98-后台成交确认阶段权限；
                 */
                var relaType = nui.get("relaType").getValue();
                
                //不能同时设置“非创金员工”与“创金员工”权限类型
                if((relaType.indexOf("01")!=-1||relaType.indexOf("07")!=-1||relaType.indexOf("A4")!=-1||relaType.indexOf("A5")!=-1||relaType.indexOf("A2")!=-1||relaType.indexOf("A3")!=-1||relaType.indexOf("A1")!=-1) &&
                	(relaType.indexOf("02")!=-1||relaType.indexOf("03")!=-1||relaType.indexOf("04")!=-1||relaType.indexOf("05")!=-1||relaType.indexOf("06")!=-1||relaType.indexOf("08")!=-1||relaType.indexOf("09")!=-1)){
                	nui.alert("不能同时设置“非创金员工”与“创金员工”权限类型！","提示");
					return;
                }
                //不能同时设置“投资/基金经理岗”与“交易员岗”权限类型
                if(relaType.indexOf("02")!=-1 && (relaType.indexOf("03")!=-1||relaType.indexOf("04")!=-1||relaType.indexOf("05")!=-1||relaType.indexOf("06")!=-1||relaType.indexOf("08")!=-1||relaType.indexOf("09")!=-1)){
                	nui.alert("不能同时设置“投资/基金经理岗”与“交易员岗”权限类型！","提示");
					return;
                }
                //不能同时设置“00-组合查询”与其他权限类型
                if(relaType.indexOf("00")!=-1 && (relaType.indexOf("01")!=-1||relaType.indexOf("07")!=-1||relaType.indexOf("A4")!=-1||relaType.indexOf("A5")!=-1||relaType.indexOf("A2")!=-1||relaType.indexOf("A3")!=-1||relaType.indexOf("A1")!=-1 
                	|| relaType.indexOf("02")!=-1||relaType.indexOf("03")!=-1||relaType.indexOf("04")!=-1||relaType.indexOf("05")!=-1||relaType.indexOf("06")!=-1||relaType.indexOf("08")!=-1||relaType.indexOf("09")!=-1
                	|| relaType.indexOf("99")!=-1 || relaType.indexOf("98")!=-1 )){
                	nui.alert("不能同时设置“00-组合查询”与其他权限类型！","提示");
					return;
                }
                //不能同时设置“99-交易确认”与其他权限类型
                if(relaType.indexOf("99")!=-1 && (relaType.indexOf("01")!=-1||relaType.indexOf("07")!=-1||relaType.indexOf("A4")!=-1||relaType.indexOf("A5")!=-1||relaType.indexOf("A2")!=-1||relaType.indexOf("A3")!=-1||relaType.indexOf("A1")!=-1 
                	|| relaType.indexOf("02")!=-1||relaType.indexOf("03")!=-1||relaType.indexOf("04")!=-1||relaType.indexOf("05")!=-1||relaType.indexOf("06")!=-1||relaType.indexOf("08")!=-1||relaType.indexOf("09")!=-1
                	|| relaType.indexOf("00")!=-1 || relaType.indexOf("98")!=-1 )){
                	nui.alert("不能同时设置“99-交易确认”与其他权限类型！","提示");
					return;
                }
                //不能同时设置“98-后台成交确认”与其他权限类型
                if(relaType.indexOf("98")!=-1 && (relaType.indexOf("01")!=-1||relaType.indexOf("07")!=-1||relaType.indexOf("A4")!=-1||relaType.indexOf("A5")!=-1||relaType.indexOf("A2")!=-1||relaType.indexOf("A3")!=-1||relaType.indexOf("A1")!=-1 
                	|| relaType.indexOf("02")!=-1||relaType.indexOf("03")!=-1||relaType.indexOf("04")!=-1||relaType.indexOf("05")!=-1||relaType.indexOf("06")!=-1||relaType.indexOf("08")!=-1||relaType.indexOf("09")!=-1
                	|| relaType.indexOf("00")!=-1 || relaType.indexOf("99")!=-1 )){
                	nui.alert("不能同时设置“98-后台成交确认”与其他权限类型！","提示");
					return;
                }
                //若不是配置“99-交易确认阶段权限”或“98-后台已成交确认阶段权限”，则产品&组合名称必输
                if(relaType!="99" && relaType!="98"){
                	//获取产品&组合名称
	                var combProductCodeVal = "";//产品代码
	                var combProductNameVal = "";//产品名称
	                var vcCombiNoVal = "";//投资组合编号
	                var vcCombiNameVal = "";//投资组合名称
	                var vcAssetIdVal = "";//资产单元序号
	                var lProductIdVal = "";  //产品编号
	                var lCombiIdVal = "";  //组合编号
	                var fundInfos = productinfo2.findRows();
	                
	                if(fundInfos.length > 0){
	                	for(var i=0; i<fundInfos.length; i++){
	                		var fundInfo = fundInfos[i].fundInfo;
	                		if(fundInfo!=null && fundInfo!="" && fundInfo.split("|").length==7){
	                			var fundArr = fundInfo.split("|");
		                		combProductCodeVal += fundArr[0] + ",";//产品代码
				                combProductNameVal += fundArr[1] + ",";//产品名称
				                vcCombiNoVal += fundArr[2] + ",";//投资组合编号
				                vcCombiNameVal += fundArr[3] + ",";//投资组合名称
				                vcAssetIdVal += fundArr[4] + ",";//资产单元序号
				                lProductIdVal += fundArr[5] + ",";  //产品编号
				                lCombiIdVal += fundArr[6] + ","; //组合编号
	                		}
	                	}
                	}else{
                		nui.alert("产品&组合名称不能为空！","提示");
        				return;
                	}
                	
	                if(combProductCodeVal!=null && combProductCodeVal!=""){
	                	combProductCodeVal = combProductCodeVal.substr(0,combProductCodeVal.length-1);
	                	combProductNameVal = combProductNameVal.substr(0,combProductNameVal.length-1);
	                	vcCombiNoVal = vcCombiNoVal.substr(0,vcCombiNoVal.length-1);
	                	vcCombiNameVal = vcCombiNameVal.substr(0,vcCombiNameVal.length-1);
	                	vcAssetIdVal = vcAssetIdVal.substr(0,vcAssetIdVal.length-1);
	                	lProductIdVal = lProductIdVal.substr(0,lProductIdVal.length-1);
	                	lCombiIdVal = lCombiIdVal.substr(0,lCombiIdVal.length - 1);
	                }

	                nui.get("combProductCode").setValue(combProductCodeVal);
	                nui.get("combProductName").setValue(combProductNameVal);
	                nui.get("vcCombiNo").setValue(vcCombiNoVal);
	                nui.get("vcCombiName").setValue(vcCombiNameVal);
	                nui.get("vcAssetId").setValue(vcAssetIdVal);
                	nui.get("vcProductId").setValue(lProductIdVal);
                	nui.get("vcCombiId").setValue(lCombiIdVal);
                //若配置为“99-交易确认阶段权限”或“98-后台已成交确认阶段权限”，则给产品代码、产品名称等赋予特定值
                }else{
                	nui.get("combProductCode").setValue("All Products");
                	nui.get("vcProductId").setValue("All Products");
                	nui.get("combProductName").setValue("全部产品");
                	nui.get("vcCombiNo").setValue("All Combis");
                	nui.get("vcCombiId").setValue("All Combis");
                	nui.get("vcCombiName").setValue("全部组合");
                	nui.get("vcAssetId").setValue("All Assets");
                }
                //若不是配置“A1-投资录入确认可为同一人员”、“A2-需要委托人确认”、“A4-需要投顾风控确认”，则关联用户必输
                if(relaType!="A1" && relaType!="A2" && relaType!="A4"){
                	//重新设置用户ID、用户姓名
	                var userIdVal = "";
	                var userNameVal = "";
	                var userIdList = grid2.findRows();//用户ID值
	                if(userIdList.length > 0){
	                	for(var i=0; i<userIdList.length; i++){
	                		var userId = userIdList[i].targetId;
	                		var userName = userIdList[i].targetName;
	                		
	                		userIdVal += userId + ",";
	                		userNameVal += userName + ",";
	                	}
	                }else{
	                	nui.alert("关联用户不能为空！","提示");
        				return;
	                }
	                if(userIdVal!="" && userIdVal.length>0){
	                	userIdVal = userIdVal.substr(0,userIdVal.length-1);
	                }
	                if(userNameVal!="" && userNameVal.length>0){
	                	userNameVal = userNameVal.substr(0,userNameVal.length-1);
	                }
	                nui.get("userIdList").setValue(userIdVal);
	                nui.get("userName").setValue(userNameVal);
                }else{
                	nui.get("userIdList").setValue("All Users");
	                nui.get("userName").setValue("全部用户");
                }
                //获取表单值
                var data = form.getData(false,true);
                var json = nui.encode(data);
                var msg = commonLoading("正在保存数据，请稍后...","系统提示");
                $.ajax({
                    url:urlStr,
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                    	nui.hideMessageBox(msg);
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                            nui.alert("保存成功！", "系统提示", function(action){
								opener.refresh();
								//目前每个产品调整权限时都需要多次设置，所以把每次设置完成后自动关闭窗口调整为由人工选择是否关闭，by huangmizhi 20170804.
				                nui.confirm("确定要关闭产品权限配置窗口吗？","系统提示",function(action){
									if(action=="ok"){
										window.close();
									}
								});
                            });
                        }else{
                            nui.alert("保存失败", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                	//目前每个产品调整权限时都需要多次设置，所以把每次设置完成后自动关闭窗口调整为由人工选择是否关闭，by huangmizhi 20170804.
					                nui.confirm("确定要关闭产品权限配置窗口吗？","系统提示",function(action){
										if(action=="ok"){
											window.close();
										}
									});
                                }
                            });
                        }
                    }
                 });
				
			}
			function commonLoading(msg,title){
				return nui.loading(msg,title);
			}
			//关闭窗口
		    function CloseWindow(action) {
		       if(action=="close" && form.isChanged()){
		      	if(confirm("数据已改变,确认退出?")){
		           deleteFilePreparation();
		           /* window.opener.location.reloadData();
		           return window.CloseOwnerWindow(action); */
		           return CloseWindow("cance");/* window.close();// */
		        }else{
		           return false;
		        }
		      }else if(window.CloseOwnerWindow) {
		      	window.opener.location.reloadData();
		      	return window.CloseOwnerWindow(action);
		      } else{
		      	//window.opener.reloadData();
		      	return window.close();
		      }
		    }
			
			//值变换时触发函数-权限类型
		    /* function relaTypeValueChangedFun(cmp){
		    	var relaType = nui.get("relaType").getValue();
                if(relaType!="99" && relaType!="98"){//若不是配置“99-交易确认阶段权限”或“98-后台已成交确认阶段权限”，则产品&组合名称必输
                	nui.get("combProductCode").setRequired(true);
                }else{
                	nui.get("combProductCode").setRequired(false);
                }
                
                if(relaType!="A1" && relaType != "A2"){//若不是配置“投顾录入确认可为同一人员”，则关联用户必输
                	nui.get("userIdList").setRequired(true);
                	nui.get("userIdList").enable();
                }else{
                	nui.get("userIdList").setRequired(false);
                	nui.get("userIdList").disable();
                }
		    } */
		    
			//产品&组合名称选择 
			function addEmpResource(){
				var rows = productinfo1.getSelecteds();
				productinfo1.removeRows(rows);
				productinfo2.addRows(rows); 
		    }
		    function addAllOrgResource(){
		    	var rows = productinfo1.findRows();
		    	productinfo1.removeRows(rows);
				productinfo2.addRows(rows); 
		    }
		    function deleteEmpResource(){
		    	var rows = productinfo2.getSelecteds();
				productinfo2.removeRows(rows);
				productinfo1.addRows(rows);
		    }
		    function deleteAllOrgResource(){
		    	var rows = productinfo2.findRows();
		    	productinfo2.removeRows(rows);
				productinfo1.addRows(rows); 
		    }
			//机构查询
			 var tree = nui.get("depttree");
		     tree.on("nodeselect", function (e) {
		     	currentOrgid=e.node.orgid;
		     	search();
			});
			 var newRow = null;
			function select1(e){
				newRow = jQuery.extend(true, {}, e.record);
				var rows = grid2.findRows();
				var issel = false;
				if(rows.length > 0){
					for(var i= 0;i<rows.length;i++){
					 if(rows[i].userid == newRow.userid){
					 	  	issel = true;
						}
					}
					if(issel){
						nui.alert("该用户已选择！");
					}else{
						grid2.addRow(newRow);
					}
				}else{
					grid2.addRow(newRow);
				}
				newRow = null;
			}
			//人员选中的行下移
			function downmove(){
				var selrows = grid.getSelecteds();
				var rows = grid2.findRows();			
				if(selrows.length>0){
					for(var i=0;i<selrows.length;i++){
						newRow = jQuery.extend(true, {}, selrows[i]);
						var rows = grid2.findRows();
						var issel = false;
						if(rows.length > 0){
							for(var j= 0;j<rows.length;j++){
							 if(rows[j].userid == newRow.userid){
							 	  	issel = true;
								}
							}
							if(!issel){
								grid2.addRow(newRow);
							}
						}else{
							grid2.addRow(newRow);
						}
						newRow = null;
					}
				}
			}
			
			//人员选中全部记录并下移
			function downmoveAll(){
				//人员选中全部记录
				grid.selectAll();
				//人员选中的行下移
				downmove();
			}
			
			//人员移除选中的行
			function removeselects(){
				var selrows = grid2.getSelecteds();
				if(selrows.length>0){
				grid2.removeRows(selrows); 
				}
			}
			
			//人员选中全部记录并移除
			function removeselectsAll(){
				//人员选中全部记录
				grid2.selectAll();
				//人员移除选中的行
				removeselects();
			}
			
			//人员移除当前行 
			function removeselect(userid){
				var rows = grid2.findRows();
				if(rows.length > 0){
					for(var i= 0;i<rows.length;i++){
						if(rows[i].userid == userid){
							grid2.removeRow(rows[i]);
							return;
						}
					}
				}
			}
			
			//人员渲染行对象
			grid2.on("drawcell", function (e) {
				column = e.column,
				row=e.row;
				//action列，超连接操作按钮
				if (column.name == "action") {
					e.cellStyle = "text-align:left";
					e.cellHtml = "<div headerAlign='center' align='center'><a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='removeselect(\""+e.row.userid+"\")'>移除</a></div>";
				}       
			});
			
			//判断该用户是否已经被选中
			function isSelectExist( _val ){
				_val= _val+"";
				var _selectuser_val = selectUserObj.getValue() ;
			 	var _selectArray = _selectuser_val.split(",") ;
			 	var _index = $.inArray(_val,_selectArray) ;
			 	return _index < 0 ? false : true ;
			}

		    function getViewName(obj){
		    	return obj.username ;
		    }
		    function getViewValue(obj){
		    	return obj.empid ;
		    }

		      
			function onValueChanged(e){
				
				var _data = grid.getData() ;
				var _isExist ;
				$.each(_data ,function(_index,record) {  
		           _isExist = isSelectExist(record.targetId) ;
		            
		           if(_isExist){
		           		$("#chk_" + record.targetId).attr("checked"  ,'true') ;
		           }else{
		           		$("#chk_" + record.targetId).removeAttr("checked");
		           }
		        });
		        
		        //结果集合内删除被用户点击的
		        var valArray = selectUserObj.getValue().split(",") ;
		        
		        $.each(_selectVal ,function(_index,record) {
		          	var val = getViewValue(record) ;
		          	if (val!= valArray[_index]) {
		            	_selectVal.splice(_index ,1) ;
		            	return false ;
		            }
		             
		         });
		    }
		    //加载成功后
		    function searchprod(){
		    	var searchKey = nui.get("searchKey");
		    	var cProductStatus = nui.get("cProductStatus");
		    	var json = {searchKey:searchKey.getValue(),cProductStatus:cProductStatus.getValue()};
		    	productinfo1.load(json);
		    }
		    function resetprod(){
		    var searchKey = nui.get("searchKey");
		    var cProductStatus = nui.get("cProductStatus");
		    	searchKey.setValue("");
		    	cProductStatus.setValue("");
		    	productinfo1.load();
		    }
		   
		 
		    function search(index){
		    	if(currentOrgid == 1){
		    		grid.load();
		    	}else{
			     	var json = { orgid:currentOrgid ,datatype:"1"};
			     	if(index&&index>0){
			     		json={targetName:nui.get("targetName").getValue(),userid:nui.get("userid").getValue()};
			     	}
			    	grid.load(json);
		    	}
		    }
	    	function reset(){
	    		var formSear = new nui.Form("#form1");
				formSear.reset();
			}
		    function getType(){
		    	return nui.get("searchtype").getValue();
		    }

            //确定保存或更新
            function onOk() {
                saveData();
            }

            //取消
            function onCancel() {
                CloseWindow("close");
            }
            
            //产品权限配置帮助
            function showHelp(){
            	var url = "<%=request.getContextPath()%>/fm/baseinfo/product_handle_help.jsp";
				nui.open({
					url: url,
					title:"产品权限配置帮助", width:"700", height:"400"
				});
            }
            
    </script>
</body>
</html>