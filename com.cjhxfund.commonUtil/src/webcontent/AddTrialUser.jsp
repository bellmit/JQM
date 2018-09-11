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
<title>新增公测用户</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style>
    /*如果样式有调整 需要重新定位 这个id */
    #mini-71{
    	width:60px!important;
    }
    </style>
</head>
<body>
<div id="dataform1" style="width:100%;height:100%;" class="nui-form">
	<div style="height: 10%;text-align: center;border: 1px solid #a5acb5;">
		 <div style="margin-top: 20px;">
		 <span style="color:red">*</span><span>功能模块:</span>
		 <span>
		 <input id="relaType" class="nui-combobox" url="com.cjhxfund.commonUtil.userOperatorManager.queryTrialFuncDict.biz.ext" name="trialuser.vcTrialFunCode" textField="TEXT" valueField="ID" required="true" width="220px" /></span>		 
		 <input id="vcTrialFunName" class="nui-hidden" name="trialuser.vcTrialFunName"/>
		 <input id="userIdList" class="nui-hidden" name="trialuser.vcUserId"/>
		 <input id="userNameList" class="nui-hidden" name="trialuser.vcUserName"/>
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
				                        用户姓名:
				                    </td>
				                    <td colspan="1">
				                        <input class="nui-textbox" id="targetName"/>
				                    </td>
				                    <td class="form_label" style="text-align: right">
				                        用户ID:
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
				                    <div field="targetName" width="100" headerAlign="center" align="center" allowSort="true">用户姓名</div>
				                   <div field="userid" width="80" headerAlign="center"  align="center" allowSort="true">用户ID</div>
				                   <div field="orgname" width="100" headerAlign="center"  align="center" allowSort="true">所属机构</div>
				                   <div type="checkcolumn"></div>
				                </div>
				            </div>  
				        </div>
				        <div class="nui-fit" style="height:30px">
				      		<div style="width:200px;float:left;margin-top:3px;">已选关联用户</div>
				      		<span><a  class='nui-button' plain='false' style="margin-top:3px;" onclick="downmove()" >下移</a></span>
				      		<span><a  class='nui-button' plain='false' style="margin-top:3px;" onclick="removeselects()" >移除</a></span>
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
				                    <div field="targetName" width="100" headerAlign="center" align="center" allowSort="true">用户姓名</div>
				                   <div field="userid" width="80" name="trialuser.vcUserId" headerAlign="center"  align="center" allowSort="true">用户ID</div>
				                   <div field="orgname" width="100" headerAlign="center"  align="center" allowSort="true">所属机构</div>
				                   <div type="checkcolumn"></div>
				                   <div name="action" width="30" headerAlign="center" align="center">移除</div>
				                </div>
				            </div>
				        </div>
				    </div>        
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
			var selectUserObj = nui.get("selectUsers");
			var _selectVal = [] ;
			selectUserObj.on("valuechanged", onValueChanged);
			function saveData(){
				form.validate();
				if (form.isValid() == false) {
					nui.alert("请检查必填项!");
					return;
				}
				nui.get("vcTrialFunName").setValue(nui.get("relaType").getText());
					var userIdVal = "";
					var userNameVal = "";
	                var userIdList = grid2.findRows();//用户ID值
	                if(userIdList.length > 0){
	                	for(var i=0; i<userIdList.length; i++){
	                		var userId = userIdList[i].userid;
	                		var userName = userIdList[i].targetName;
	                		userNameVal += userName + ",";
	                		userIdVal += userId + ",";
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
	                nui.get("userNameList").setValue(userNameVal);
				var urlStr = "com.cjhxfund.commonUtil.userOperatorManager.addTrialUser.biz.ext";
				var data = form.getData(false,true);
                var json = nui.encode(data);
                $.ajax({
                    url:urlStr,
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                            nui.alert("保存成功！", "系统提示", function(action){
                            		opener.refresh();
  									window.close();
                                });
                        }else{
                            nui.alert("保存失败", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                    window.close();
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
			
			//人员移除选中的行
			function removeselects(){
				var selrows = grid2.getSelecteds();
				if(selrows.length>0){
				grid2.removeRows(selrows); 
				}
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
    </script>
</body>
</html>