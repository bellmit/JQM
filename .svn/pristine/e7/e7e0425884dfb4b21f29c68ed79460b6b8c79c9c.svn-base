<%@page pageEncoding="UTF-8"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<% 
	//UserObject user = (UserObject)session.getAttribute("userObject");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/common.jsp" %>

<html>

<head>
<title>选择推送给招行的债券</title>

</head>
<body>
<div class="nui-fit"  id="dataform1">
         <div class="nui-fit" style="width:100%;height:85%;">
            <div 
                id="usergrid1"
                dataField="data"
                class="nui-datagrid"
                style="width:100%;height:100%;"
                url="com.cjhxfund.jy.process.cfjybusinessbonetablebiz.getGmsStockApiList.biz.ext"
                allowCellSelect="true" 
                multiSelect="false"
                onrowclick="onrowclick"
                showPager="false"
                allowSortColumn="true">
                <div property="columns"> 
                		<div type="checkcolumn">
                        </div> 
                        <div field="vcStockCode" headerAlign="center" allowSort="true"  width="80px">
                            债券代码
                        </div>
                        <div field="vcStockName" headerAlign="center" allowSort="true" width="100px">
                            债券简称
                        </div>
                        <div field="vcStockNameFull" headerAlign="center" allowSort="true" width="150px">
                            债券全称
                        </div>
                        <div field="vcPaymentPlace" headerAlign="center" allowSort="true"  width="80px" align="center" renderer="onvcPaymentPlace">
                          登记托管机构
                        </div>
                        <div field="vcStocktypeName" headerAlign="center" allowSort="true"  align="center"  width="70px">
                            债券类别
                        </div>
                        <div field="vcIssuerName" headerAlign="center" align="center" allowSort="true"  width="100px">
                            发行主体
                        </div>
                       <div name="action" width="130px" align="center" headerAlign="center" >操作</div>
                </div>
            </div>  
        </div>
        <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
	        <a class="mini-button" style="width:90px;" iconCls="icon-ok"  onclick="ok()">推送债券</a>
	        <span style="display:inline-block;width:25px;"></span>
	        <a class="mini-button" iconCls="icon-close"  style="width:60px;" onclick="closeWindow('cancel')">取消</a>
   	 	</div>
</div>

<script type="text/javascript">
	nui.parse();
	var grid=nui.get("usergrid1");
	var form = new nui.Form("#dataform1");//将普通form转为nui的form
	
	function onrowclick(e){
		//debugger;
		/*var record = e.record;
		var checked = $("#chk_" + record.targetId).attr("checked");
		if(checked){
			$("#chk_" + record.targetId).removeAttr("checked");
		}else{
			$("#chk_" + record.targetId).attr("checked"  ,'true') ;
        }
        checkboxChange("#chk_" + record.targetId) ;*/
	}
	function onvcPaymentPlace(e){
  		return nui.getDictText("CF_JY_DJTGCS",e.row.vcPaymentPlace);;
	}
	//渲染行对象
 	grid.on("drawcell", function (e) {
	    var record = e.record,
	    column = e.column,
	    row=e.row;
	    //action列，超连接操作按钮
	    if (column.name == "action") {
	        e.cellStyle = "text-align:left";
		            e.cellHtml = "";
		            var yjsg="",zljk="";
		            
					yjsg =  "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;color:red;'  onclick='propelling(\""+row.lStockInvestNo+"\")'>推送债券</a>&nbsp;|&nbsp;";
					e.cellHtml=e.cellHtml+yjsg+zljk;//组装字符串
					e.cellHtml = e.cellHtml+"<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;color:red;' onclick='details()'>债券详情</a>";
					
	    }
	    //设置行样式
	    if (record.gender == 1) {
	        e.rowCls = "myrow";
	    }
     	
	});
	//推送按钮
	function ok(){
		//暂停200毫秒 防止比选中事件先触发，
		setTimeout(function(){
			var row = grid.getSelected();
			 if(row){ 
			 	propelling(row.lStockInvestNo);
			 }else{
			 	nui.alert("请选择一条债券。","提示");
			 }
		},100);
	}
	var successStatus= false;//控制提示语
	//推送新债到招行事件
	function propelling(e){
		if(e=="" || e==null){
			nui.alert("数据异常，请重新打开页面！");
			return;
		}
		nui.confirm("确认推送这条新债到招行?","系统提醒",function(action){
			if(action=="ok"){
				form.loading("推送中,请稍等...");//加载遮罩
				nui.ajax({
					    url: "com.cjhxfund.cjapi.WSPrimaryMarketService.stockPropelling.biz.ext",
					    type: "post",
					    data:{lStockInvestNo:e},
					    dataType:"json",
					    success: function (text) {
					    	form.unmask();//取消遮罩
					    	if(text.ret==true){
					    		successStatus=true;
					    		nui.alert("新债已成功推送到招行！","系统提醒",function (action){
					    			if (window.CloseOwnerWindow) 
					            		return window.CloseOwnerWindow("cancel");
					            	else window.close() ; 
					    		});
					    		
					    	}else{
					    		nui.alert("推送失败，请联系统系管理员！");
					    	}
					    }
				});
			}
         });
	}
	//详细信息
	function details(){
		//暂停200毫秒 防止比选中事件先触发，
		setTimeout(function(){
			var row = grid.getSelected();
			 if(row){ 
				nui.open({
                    url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueQueryDetail.jsp?lStockIssueId="+row.lStockIssueId,
                    title: "详细信息", 
                    width: 980, 
           			height: 700,
                    //allowResize:false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        iframe.contentWindow.initForm();
                    },
                    ondestroy: function (action) {
                        if(action=="saveSuccess"){
	                        grid.reload();
                   	 	}
                    }
                });
			 }else{
				nui.alert("请选择一条债券。","提示");
			} 
		},100);
		
	}
 	function setFormData(data) {
 	//console.log(data);
 		if(data.cfjybusinessbonetable.bizId==null || data.cfjybusinessbonetable.bizId==""){
			nui.alert("数据异常，请重新打开界面！","提示");
			return;
		}
 		var json = {bizId:data.cfjybusinessbonetable.bizId};
		grid.load(json);
	}
	
	function setData(data) {
	//console.log("data:");
		//console.log(data);
		if(data.bizId==null || data.bizId==""){
			nui.alert("数据异常，请重新打开界面！","提示");
			return;
		}
 		var json = {bizId:data.bizId};
		grid.load(json);
	}
	function closeWindow(action){
		if(successStatus==false){
			nui.confirm("您还未执行推送，确认关闭当前页面吗?","系统提醒",function(action){
				if(action=="ok"){
					if (window.CloseOwnerWindow) 
	            		return window.CloseOwnerWindow(action);
	            	else window.close() ; 
				}
			});
		}else{
			if (window.CloseOwnerWindow) 
        		return window.CloseOwnerWindow(action);
        	else window.close() ; 
		}
		
	}
 </script>
</body>
</html>