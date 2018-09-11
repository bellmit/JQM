<%@page import="com.primeton.cap.AppUserManager"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): zhoulin
- Date: 2017-11-20 17:30:42
- Description:
    --%>
    <head>
        <title>模板信息维护</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <style type="text/css">
        	
        </style>
        <script src="<%= request.getContextPath() %>/common/nui/nui.js"	type="text/javascript"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/fm/comm/fileupload/js/swfupload.js"></script>
    </head>
    <body>
        <!-- 标识页面是修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;width: 100%;height:86%;" >
            <!-- hidden域 -->
        	<input class="nui-hidden" name="tatsstocktemplate.vcCreator" id="vcCreator"/>
            <input class="nui-hidden" name="tatsstocktemplate.dCreateTime" id="dCreateTime"/>
            <input class="nui-hidden" name="tatsstocktemplate.dUpdateTime" id="dUpdateTime"/>
            <input class="nui-hidden" name="tatsstocktemplate.vcTemplatePath" id="vcTemplatePath"/>
            <table style="width:100%;height:aotu;table-layout:fixed;" class="nui-form-table" cellspacing="5px" cellpadding="0" border-collapse="collapse" padding="0px" marign="0px">
             	<tr>
         			<td class="form_label" align="right" colspan="1">
                		<span style="color:red">*</span>&nbsp;模板名称:
                    </td>
                    <td colspan="2">
                		<input style="width: 100%;" allowInput="false" class="nui-textbox" id="vcTemplateName"  name="tatsstocktemplate.vcTemplateName" required="true"/>
                	</td>
                    <td colspan="1">
                    	<input style="width: 47%;" id="fileupload1" class="mini-fileupload" name="Fdata"
						flashUrl="../../comm/fileupload/js/swfupload.swf" uploadUrl="com.cjhxfund.ats.fm.comm.common.uploadStockTemplate.biz.ext" 
						onuploadsuccess="onUploadSuccess" onuploaderror="onUploadError" onfileselect="onFileSelect" limitType="*.xml"/> 
                    </td>
                </tr>
            	<tr>
            		<td class="form_label" align="right" colspan="1">
                    	<span style="color:red">*</span>&nbsp;债券代码:
                    </td>
                    <td colspan="2">
                		<input style="width: 100%;" class="nui-textbox" id="vcStockCode"  name="tatsstocktemplate.vcStockCode" required="true"/>
                    </td>
                    <td colspan="1" align="left" >
                		<a class='nui-button' plain='false' iconCls="icon-search" onclick="queryOpen()" id="queryStock"></a>
                		<a class='nui-button' plain='false' iconCls="icon-remove" id="cleanStock" onclick="stockIssueInfoClean()"></a>
			  		</td>
	  	    	</tr>
             	<tr>
             		<td class="form_label" align="right"colspan="1">
                    	<span style="color:red">*</span>&nbsp;债券全称:
                    </td>
                    <td colspan="2">
                		<input style="width: 100%;" class="nui-textbox" id="vcStockName"  name="tatsstocktemplate.vcStockName" required="true" />
                	</td>
				</tr>
	  	    	<tr>
            		<td class="form_label" align="right"colspan="1">
                    	<span style="color:red">*</span>&nbsp;市场:
                    </td>
                    <td colspan="2">
                		<input style="width: 100%;" class="nui-dictcombobox" id="cMarketNo"  name="tatsstocktemplate.cMarketNo" dictTypeId="tradePlace" required="true"/>
                    </td>
	  	    	</tr>
				<tr>
            		<td class="form_label" align="right"colspan="1">
                    	&nbsp;主承销商:
                    </td>
                    <td colspan="2">
                		<input style="width: 100%;" class="nui-textbox" id="vcMainUnderwriter"  name="tatsstocktemplate.vcMainUnderwriter"/>
                    </td>
	  	    	</tr>
	  	    	<tr style="display:none;" >
            		<td class="form_label" align="right"colspan="1">
                    	&nbsp;投资编号:
                    </td>
                    <td colspan="2">
                		<input style="width: 100%;" class="nui-textbox" id="lStockInvestNo"  name="tatsstocktemplate.lStockInvestNo"/>
                    </td>
	  	    	</tr>
	  	    	<tr>
            		<td class="form_label" align="right"colspan="1">
                    	&nbsp;序号:
                    </td>
                    <td colspan="2">
                		<input style="width: 100%;" class="nui-textbox" id="vcOrderNum"  name="tatsstocktemplate.vcOrderNum"/>
                    </td>
	  	    	</tr>
                <tr>
                    <td class="form_label" align="right"colspan="1">
                                                                                              备注:
                    </td>
                    <td colspan="2">
                         <input class="nui-textarea" style="width: 100%;" id="vcRemarks" name="tatsstocktemplate.vcRemarks"/>
                    </td>
                </tr>
                
            </table>
            <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a class="nui-button" iconCls="icon-save" onclick="onOk()">
                                保存
                            </a>
                            <span style="display:inline-block;width:25px;">
                            </span>
                            <a class="nui-button" iconCls="icon-cancel" onclick="onCancel()">
                                取消
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();
            //获取当前登录人的ID信息
            <% 	UserObject userObject = (UserObject)request.getSession().getAttribute("userObject"); %>
 			var currentUserID = "<%=userObject.getUserId() %>";
            var currentUserName = "<%=userObject.getUserName() %>";
            //填写制作人姓名
            nui.get("vcCreator").setValue(currentUserName);
			//是否允许上传模板
			var stockIssueInfoTemp;//如果为有债券 存放选择的债券
			
            function saveData(){
            	var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
            	var nowDate = new Date();  
                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                var urlStr = null;
                if(pageType=="edit"){
                	nui.get("dUpdateTime").setValue(nowDate);
                    urlStr = "com.cjhxfund.ats.fm.baseinfo.tatsstocktemplatebiz.updateTAtsStockTemplate.biz.ext";
                }else if(pageType=="add"){
                	nui.get("dCreateTime").setValue(nowDate);
            		nui.get("dUpdateTime").setValue(nowDate);
            		urlStr = "com.cjhxfund.ats.fm.baseinfo.tatsstocktemplatebiz.addTAtsStockTemplate.biz.ext";
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
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                            nui.alert("模板文件保存成功。", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                   	CloseWindow("saveSuccess");
                                }
                        	});
                        }else if(returnJson.exception.code=="24000040"){
                        	//console.log(returnJson.exception);
                            nui.alert("模板文件保存失败，债券信息重复录入。", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                    //CloseWindow("saveFailed");
                                }
                        	});
                        }else{
                        	nui.alert("模板文件保存失败。未知原因，请联系管理员。", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                    //CloseWindow("saveFailed");
                                }
                        	});
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
                //如果是点击编辑类型页面
                if (infos.pageType == "edit") {
                	var json = infos.record;
                    var form = new nui.Form("#dataform1");//将普通form转为nui的form
                    form.setData(json);
                    form.setChanged(false);
                    nui.get("vcStockCode").allowInput=false;
                    $("#vcStockCode input").css("background-color","#f0f0f0");//置灰
                    nui.get("vcStockName").allowInput=false;
                    $("#vcStockName input").css("background-color","#f0f0f0");//置灰
                    nui.get("cMarketNo").readOnly="true";
                    $("#cMarketNo input").css("background-color","#f0f0f0");//置灰
                    nui.get("vcMainUnderwriter").allowInput=false;
                    $("#vcMainUnderwriter input").css("background-color","#f0f0f0");//置灰
                    nui.get("queryStock").hide();
                    nui.get("cleanStock").hide();
                }
            }

            //关闭窗口
            function CloseWindow(action) {
                if (action == "close" && form.isChanged()) {
                    if (confirm("数据被修改了，是否先保存？")) {
                        saveData();
                    }
                }
                if (window.CloseOwnerWindow)
                return window.CloseOwnerWindow(action);
                else window.close();
            }

            //确定保存或更新
            function onOk() {
            	var vcTemplateName=nui.get("vcTemplateName").getValue();
            	var vcStockCode=nui.get("vcStockCode").getValue();
            	var vcStockName=nui.get("vcStockName").getValue();
            	var cMarketNo=nui.get("cMarketNo").getValue();
            	//console.log("vcStockCode="+vcStockCode);
            	if(vcTemplateName==null||vcTemplateName==""||vcStockCode==null||vcStockCode==""
            		||vcStockName==""||vcStockName==null||cMarketNo==""||cMarketNo==null){
            		nui.alert("必填项不能为空！！！");
            	}
                saveData();
            }

            //取消
            function onCancel() {
                CloseWindow("cancel");
            }
            
    		//打开查询债券界面
			function queryOpen(){
				var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
	            if(pageType=="edit"){
	            	nui.alert("模板编辑页面不允许重新选择债券信息。");
	            	return;
	            }
				var name=nui.get("vcStockName").getValue();
				nui.open({
	                    url: "<%=request.getContextPath() %>/fm/instr/firstGradeDebt/queryStockName.jsp",
	                    title: "查询债券", width: 850, height: 350,
	                    onload: function () {
	                        //弹出页面加载完成
		                    var iframe = this.getIFrameEl();
		                    var data = {vcStockName:name};//传入页面的json数据
		                    iframe.contentWindow.setFormData(data);
	                    },
	                    ondestroy: function (data) {//弹出页面关闭前
	                    //console.log(data);
	                    //判定回填数据
	                    if(data!=null && data!="" && data!="close"){
	                    	var form = new nui.Form("#dataform1");//将普通form转为nui的form
	                    	stockIssueInfoTemp=data;//存储 ，提交时使用
		                    //form.setData({applyInst:data});
		                   	form.setChanged(false);
		                   	nui.get("vcStockCode").setValue(data.vcStockCode);
		                   	nui.get("vcStockName").setValue(data.vcStockNameFull);
		                   	nui.get("vcMainUnderwriter").setValue(data.vcMainUnderwriter);
		                   	nui.get("cMarketNo").setValue(data.cMarketNo);
	                    }
	                }
	             });
			}
			/*清理有债券信息*/
			function stockIssueInfoClean(){
				var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
	            if(pageType=="edit"){
	            	nui.alert("模板编辑页面不允许重新选择债券信息。");
	            	return;
	            }
	           	nui.get("vcStockCode").setValue("");
	           	nui.get("vcStockName").setValue("");
	           	nui.get("vcMainUnderwriter").setValue("");
	           	nui.get("cMarketNo").setValue("");
			}
					
		    //文件选择后触发的方法
	    	function onFileSelect(e) {
	    		//在模板名称处回填被选中的附件名称
		    	var templateName = nui.get("fileupload1").getValue();
		    	nui.get("vcTemplateName").setValue(templateName);
				//如果是新增业务，先判断将要上传的附件的名字是否已经存入数据库
				var json = nui.encode({"criteria/_entity":"com.cjhxfund.ats.fm.baseinfo.stockTemplate.TAtsStockTemplate",
				"criteria/_expr[1]/vcTemplateName":templateName,"criteria/_expr[1]/_op":"="});
                
                $.ajax({
                    url:"com.cjhxfund.ats.fm.baseinfo.tatsstocktemplatebiz.queryTAtsStockTemplates.biz.ext",
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
	                    success:function(text){
	                        var returnJson = nui.decode(text);
	                        if(returnJson.exception == null){
	                        	if(text.total!=0){
		                        	nui.confirm("相同文件名的模板已经存在，继续保存将会更新该模板文件。","确认模板",function(e){
		                        		if(e=="ok"){
		                        			//console.log("更新模板");
		                        			startUpload();
		                        		}else{
		                        			nui.get("vcTemplateName").setValue("");
		                        			//console.log("放弃更新模板");
		                        		}
		                        	}); 
	                        	}else{
	                        		//console.log("开始上传");
	                        		startUpload();
	                        	}
	                        }else{
	                            nui.alert("查询模板信息失败！");
	                        }
	            		}
	            });
                
            }
				    
		    //上传成功后回调方法
		    function onUploadSuccess(e) {
		    	//回调子页面的方法
		    	//console.log(e);
		    	var templatePath =nui.decode(e.serverData).templatePath;
		        nui.get("vcTemplatePath").setValue(templatePath);
		        //console.log("上传完毕");
		    }
		    //上传错误
		    function onUploadError(e) {
		        nui.alert("上传失败，请联系管理员.");
		    }
				    
			//点击上传
		    function startUpload() {
		    	//调用逻辑流上传附件
		        var fileupload = nui.get("fileupload1");
		        fileupload.startUpload();
		        //console.log("正在上传");
		    }
		    //清空
		    function clearFileupload(){
		    	nui.get("fileupload1").setText("");
		    }
		    //市场代码字典转换
			function marketNoRenderer(e){
				//console.log("no");
	        	return nui.getDictText("tradePlace",e.row.cMarketNo);
	        }
        </script>
    </body>
</html>
