<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): zhangyao
  - Date: 2016-12-06 16:13:30
  - Description:
-->
<head>
	<title>交易员（确认主承备案）</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="css/offeringStyle.css"/>
</head>
<%
    String processInstID = request.getParameter("processInstID");
	String workItemID = request.getParameter("workItemID");
	String vcExchangeNo=request.getParameter("vcExchangeNo");
	String vcType=request.getParameter("vcType");
 %>
<body>
<div id="tabs" class="nui-tabs" height="100%">
	<div title="确认主承备案" class="content">
        <div class="main">
            <form id="form1" method="post" >
            	<!-- 基本信息 -->
            	<input name="processInstID" id="processInstID" class="nui-hidden" value="<%=processInstID %>"/>
            	<input name="workItemID" id="workItemID" class="nui-hidden" value="<%=workItemID %>"/>
            	<input id="vcExchangeNo" name="vcExchangeNo" class="nui-hidden" value="<%=vcExchangeNo %>" />
            	<input id="lInstructNo" name="ipoInstructInfo.lInstructNo" class="nui-hidden" />
            	<input id="vcType" name="vcType" class="nui-hidden" value="<%=vcType %>"/>
	            <%@include file="/ipo/offering/common/common_basicInfo.jsp" %>
            </form>	
        	<!--操作按钮-->
			<div style="width:100%;">
		        <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
		            <table style="width:100%;background:#DBE3F2;">
		                <tr>
		                    <td>
		                        <a id="button1" class='nui-button' plain='false' iconCls="icon-remove" onclick="reject()" plain="false">剔除</a>
		                        <span class="separator"></span>
		                        <a id="button2" class='nui-button' plain='false' iconCls="icon-undo" onclick="undo()" plain="false">恢复</a>
		                    </td>
		                    <td  style="float:right;margin-right:10px;">
		                    	<span style="color:#626262;">剔除:<strong class="strong" style="background:#FF6666;"></strong></span>
		                    </td>
		                </tr>
		            </table>           
		        </div>
		    </div>
	        <!--撑满页面-->
			<div class="nui-fit" >    
	            <!--产品表格-->
	            <%@include file="/ipo/offering/common/common_form_product.jsp" %>
	        </div>
		</div>	
    </div>
        
    <div title="审批内容" name="index">
		<%@include file="/ipo/task/processControl.jsp" %>
		<script type="text/javascript">
			$("#vcOperateType").attr("data","[{id: 1, text: '同意'}]");
		</script>
	</div>
	<div title="流程信息" url="/ats/sm/comm/task/processGraph.jsp?processInstID=<%=processInstID %>" ></div>
</div>
<script type="text/javascript" src="js/loadbasicInfo.js"></script>
<script type="text/javascript">
    var grid = nui.get("datagrid1");
     var a=grid.getColumn (2);
    //剔除
	function reject() {
        var rows = grid.getSelecteds();
        var lInstructNo=nui.get("lInstructNo").value;
        if (rows.length>0) {
            nui.open({
                url: "<%=request.getContextPath() %>/ipo/offering/traderRejectWindow.jsp?lInstructNo="+lInstructNo,
                title: "确定剔除此产品吗？", width: 260, height: 150,
                onload: function () {
                    var rowSetmt = grid.getSelecteds();
                    var iframe = this.getIFrameEl();
					iframe.contentWindow.setFormData(rowSetmt);
                },
                ondestroy: function (action) {
                    grid.reload();
                }
            });
        } else {
            nui.alert("请选中一条记录");
        }
    }
    //恢复
    function undo(){
		var lInstructNo=nui.get("lInstructNo").value;
		var rows = grid.getSelecteds();
		var data={productJoin:rows,lInstructNo:lInstructNo,operatorType:"0"};
		var json=nui.encode(data);
		if(rows.length>0){
			nui.ajax({
		        url: "com.cjhxfund.ats.ipo.busOpr.updateRemark.biz.ext",
		        type: "post",
		        data: json,
		        contentType:'text/json',
		        success: function (text) {
		        	var returnJson = nui.decode(text);
		        	if(returnJson.exception == null){
		        		nui.alert("恢复成功","系统提示");
		        		grid.reload();
		        	}
		        }
	    	});
	    }else{
	    	nui.alert("请选择一行数据","系统提示");
	    }
	}
    
	//判断深市or沪市
	(function (){
		var vcExchangeNo=nui.get("vcExchangeNo").value;
			grid.hideColumn (10);
			grid.hideColumn (11);
		if(vcExchangeNo=="04"){
			grid.hideColumn (5);
			grid.hideColumn (7);
			grid.hideColumn (9);
		}else{
			grid.hideColumn (4);
			grid.hideColumn (6);
			grid.hideColumn (8);
		}
	})();
	
	
	//流程提交函数
	function processSubmit(){
		nui.get("processSubmit").disable();
		nui.confirm("确认是否提交流程？","系统提示",function(action){
			if(action == "ok"){
				var processForm=new nui.Form("processForm");
				var data=processForm.getData();
				//var data={workItemID:workItemID};
				data["workItemID"]=workItemID;
				var approveData={approveParam:data};
				var json=nui.encode(approveData);
				nui.ajax({
			        url: "com.cjhxfund.ats.ipo.task.finishMyWork.biz.ext",
			        type: "post",
			        data: json,
			        contentType:'text/json',
			        success: function (text) {
		        	var returnJson = nui.decode(text);
			        	if(returnJson.exception == null){
			        		if(returnJson.rtnCode=="-1"){
			        			nui.alert("审批确认失败","系统提示");
			        			nui.get("processSubmit").enable();
			        		}else{
			        			nui.alert("审批确认成功","系统提示",function(){
			        				opener.location.reload();
									window.opener = null;
									window.open(' ', '_self', ' ');
									window.close();
			        			});
			        		}
			        	}else{
			        		nui.get("processSubmit").enable();
			        	}
	        		},
	        		ondestroy:function(action){
	        			nui.get("processSubmit").enable();
	        		},
	        		error:function(error){
	        			nui.get("processSubmit").enable();
	        		}
				});
			}else{
				nui.get("processSubmit").enable();
			}
		});
	}
	//列表选择发生变化时触发事件
	function selectionChanged(){
		var vcType=nui.get("vcType").getValue();
		if(vcType!="null"){
			return;
		}
		var rcds = grid.getSelecteds();
		var button1=nui.get("button1");
		var button2=nui.get("button2");
		var index = 0; 
		var len=rcds.length;
		if(rcds.length>0&&rcds[0].vcProductParticipantion == "01"){
			while((index < len)&&(rcds[index].vcProductParticipantion == "01")){ 
				index++; 
			}
			if(index == len){
				button1.disable();
				button2.enable();
			}else{
				button1.disable();
				button2.disable();
			}
		}else{
			while((index < len)&&(rcds[index].vcProductParticipantion == "00"||rcds[index].vcProductParticipantion == undefined)){ 
				index++; 
			}
			if(index == len){
				button1.enable();
				button2.disable();
			}else{
				button1.disable();
				button2.disable();
			} 
		} 
		if(rcds.length==0){
			button1.enable();
			button2.enable();
		}
	} 
	
	grid.on("drawcell", function (e) {
	 	var record = e.record;
        //设置行样式
        if (record.vcProductParticipantion == "01") {
            e.rowStyle = "background:#FF6666";
        }else{
        	e.rowStyle = "background:#fff";
        }
	});
</script>
</body>
</html>