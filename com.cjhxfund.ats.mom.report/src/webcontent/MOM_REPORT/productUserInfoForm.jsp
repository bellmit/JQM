<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
  - Author(s):liangjilong
  - Date: 2016-11-11 08:25:25
  - Description:
    --%>
    <head>
        <title>新增产品用户信息</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    	<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
    </head>
    
    
    <body style="width: 100%;height: 100%;overflow: hidden;">
       <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
            <!-- hidden域 -->
        <div id="dataform1" style="padding-top:5px;">
	         <input class="nui-hidden" name="prodUserInfo.userId" id="prodUserInfo.userId"/>
	         <input class="nui-hidden" name="prodUserInfo.prodId" id="prodUserInfo.prodId"/>
              <table style="width:100%;table-layout:fixed;" class="nui-form-table">
				<tr>
                    <td class="form_label" width="22%" align="right">员工姓名: </td>
                    <td colspan="1"  width="32%">
                        <input class="nui-buttonedit"  width="180" name="prodUserInfo.userName" allowInput=false id="userName" onbuttonclick="selectUserName()"
                        required="true" requiredErrorText="员工姓名不能为空!"  emptyText="请输入员工姓名"/>
                    </td>
                </tr>
                 <tr>
                 	 <td class="form_label" width="22%" align="right">产品名称: </td>
                     <td colspan="1" width="32%">
                        <input class="nui-buttonedit" width="180" allowInput=false name="prodUserInfo.prodName"  id="prodName"  onbuttonclick="selectProduct()"
                         	required="true" requiredErrorText="产品名称不能为空!" emptyText="请输入产品名称"
                        />
                    </td>
                 </tr>
                 <!-- <tr>
                 	 <td class="form_label" width="22%" align="right">产品序列: </td>
                     <td colspan="1" width="32%">
                        <input class="nui-combobox" width="180" allowInput=false  name="prodUserInfo.prodLayer"  id="prodLayer" 
                         required="true" requiredErrorText="产品序列不能为空!"  allowInput="true" showNullItem="true" emptyText="请选择产品序列" url="./productLayerData.txt"
                         />
                    </td>
                 </tr> -->
            </table>
          
          <div class="nui-toolbar" style="padding:12px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a class='nui-button' plain='false' iconCls="icon-save" onclick="onOk()">保存 </a>
                            <span style="display:inline-block;width:25px;">
                            </span>
                            <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">取消</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        
        <script type="text/javascript">
            nui.parse();
	
	        //关闭窗口
	        function CloseWindow(action) {
	            if (action == "close" && form.isChanged()) {
	                if (confirm("数据被修改了，是否先保存？")) {
	                  //  saveData();
	                }
	            }
	            if (window.CloseOwnerWindow)
	            return window.CloseOwnerWindow(action);
	            else window.close();
	        }

                //确定保存或更新
            function onOk() {
           	 	saveData();
            }
            
          
            function saveData(){

                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //保存
                var urlStr = "com.cjhxfund.ats.mom.report.prodUserInfoManager.saveOrUpdateProdUserInfo.biz.ext";
                
                var userName=nui.getbyName("prodUserInfo.userName").getValue();//用户名称
                var prodName=nui.getbyName("prodUserInfo.prodName").getValue();//产品名称
                //var prodLayer=nui.getbyName("prodUserInfo.prodLayer").getValue();//产品类型
                 
                if(userName==null||userName==""){
                	mini.alert("员工姓名不能为空!","系统提示");
                	return false;
                }else{
                 	nui.get("prodName").enable();
                }
                
                if(prodName==null||prodName==""){
                	mini.alert("产品名称不能为空!","系统提示");
                	return false;
                }
                /* if(prodLayer==null||prodLayer==""){
                	mini.alert("产品序列不能为空!","系统提示");
                	return false;
                } */
                
                
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                //编辑
                if(pageType=="edit"){
                    //urlStr = ".biz.ext";
                }
                form.validate();
                if(form.isValid()==false) return;
                var data = form.getData(false,true);
                var json = nui.encode(data);
                $.ajax({
                    url:urlStr,
                    type:'POST', 
                    data:json,
                    cache:false,
                    async: false,///异步..
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                          	nui.alert("保存成功", "系统提示");
                            CloseWindow("saveSuccess");
                        }else{
                            nui.alert("保存失败", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                    CloseWindow("cancel");
                                }
                            });
                        }
                    }
                }); 
            }
            
              //取消
            function onCancel() {
                 CloseWindow("cancel");
            }
                    
             
			//选择人员名称.
			function selectUserName(){
				   nui.open({
				         url: "<%=request.getContextPath() %>/report/MOM_REPORT/userInfoWinList.jsp",
				         title: "用户信息", width: 1000, height: 508,
				         ondestroy: function (action) {//弹出页面关闭前
				               if (action == "ok") {
				               	  var iframe = this.getIFrameEl();
		                          var data = iframe.contentWindow.selectionUserChanged();
		                          data = nui.clone(data);
		                         // {empId: 1019, empCode: "jiaocui", empName: "焦翠", orgName: "创金合信_投顾业务组"}
                            	 nui.getbyName("prodUserInfo.userId").setValue(data.empId);
		                         nui.get("userName").setValue(data.empName);
                            	 nui.get("userName").setText(data.empName);
                            	 nui.get("prodName").enable();//选择完用户信息的时候把进来页面初始化那个按钮变为可用的.
		                      }
				          }
			        });    
			
			}

			//选择产品名称.
			function selectProduct(){
			 	   var userId=nui.getbyName("prodUserInfo.userId").getValue();//用户名称
				   nui.open({
				         url: "<%=request.getContextPath() %>/report/MOM_REPORT/productInfoWinList.jsp?userId="+userId,
				         title: "产品信息", width: 1000, height: 508,
				         allowDrag: true, // 允许拖拽位置
				         ondestroy: function (action) {//弹出页面关闭前
				               //grid1.reload();
				                 if (action == "ok") {
				               	  	var iframe = this.getIFrameEl();
		                          	var data = iframe.contentWindow.selectionProductChanged();
		                          	data = nui.clone(data);
		                          	var prodId="",prodName="";
		                          	for(var i=0;i<data.length;i++){
		                          		prodId+=data[i].prodId+",";
		                          		prodName+=data[i].prodName+",";
		                          	}
		                          	prodId=prodId.substring(0,prodId.length-1);
		                          	prodName=prodName.substring(0,prodName.length-1);
		                          	nui.getbyName("prodUserInfo.prodId").setValue(prodId);
		                          	nui.get("prodName").setValue(prodName);
                        	 	    nui.get("prodName").setText(prodName);
                        	 	    //选择完产品信息的时候把进来页面初始化那个按钮变为可用的.
                        	 	    //nui.get("prodLayer").enable();
		                      }
				          }
			        });    
			}
                
                
         	//页面间传输json数据
            function setFormData(data){
                //跨页面传递的数据对象，克隆后才可以安全使用
               	 var infos = nui.clone(data);
                //保存list页面传递过来的页面类型：add表示新增、edit表示编辑
                 nui.getbyName("pageType").setValue(infos.pageType);
            }
            
            initAttrEnableOrDisable();
            
            //进来页面初始化的时候禁掉这个按钮
            function initAttrEnableOrDisable(){
           		 nui.get("prodName").disable();
           		 nui.get("prodLayer").disable();
            }
            
              </script>
       </body>
  </html>
