<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page import="java.util.*" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): zhangyao
  - Date: 2016-12-06 16:13:30
  - Description:
-->
<head>
	<title>投顾（反馈参与意见）</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="css/offeringStyle.css"/>
</head>
<%
    String processInstID = request.getParameter("processInstID");
	String workItemID = request.getParameter("workItemID");
	String vcExchangeNo=request.getParameter("vcExchangeNo");
	String vcType=request.getParameter("vcType");
	
	HttpSession  ss = request.getSession();
  	UserObject user = (UserObject)ss.getAttribute("userObject");
  	Map<String,Object> map = user.getAttributes();
  
  	String mUserID = (String)map.get("EXTEND_USER_ID");
 %>
<body>
<div id="tabs" class="nui-tabs" height="100%">
	<div title="反馈参与意见" class="content">
        <div class="main">
            <form id="form1" method="post" >
            	<!--基本信息-->
            	<input name="processInstID" id="processInstID" class="nui-hidden" value="<%=processInstID %>"/>
            	<input name="workItemID" id="workItemID" class="nui-hidden" value="<%=workItemID %>"/>
            	<input id="vcExchangeNo" name="vcExchangeNo" class="nui-hidden" value="<%=vcExchangeNo %>" />
            	<input id="lInstructNo" name="ipoInstructInfo.lInstructNo" class="nui-hidden" />
            	<input id="rationType" name="rationType" class="nui-hidden" value="00" />
            	<input id="vcType" name="vcType" class="nui-hidden" value="<%=vcType %>"/>
            	<%@include file="/ipo/offering/common/common_basicInfo.jsp" %>
            </form>
        	<!--操作按钮-->
			<div style="width:100%;">
		        <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
		            <table style="width:100%;background:#DBE3F2;">
		                <tr>
		                    <td>
		                        <a id="button1" class='nui-button' plain='false' iconCls="icon-cancel" onclick="cancelProduct()" plain="false">不参与</a>
		                        <span class="separator"></span>
		                        <a id="button2" class='nui-button' plain='false' iconCls="icon-ok" onclick="okProduct()" plain="false">参与</a>
		                    </td>
		                    <td  style="float:right;margin-right:10px;">
		                    	<!--<span style="color:#626262;">未处理:<strong class="strong" style="background:#0099FF;"></strong></span>-->
		                    	<span style="color:#626262;">不参与:<strong class="strong" style="background:#335799;"></strong></span>
		                    	<span style="color:#626262;">参与:<strong class="strong" style="background:#339966;"></strong></span>
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
	var myUserID='<%=mUserID %>';
	var grid = nui.get("datagrid1");
	//判断深市or沪市
	(function (){
		var vcExchangeNo=nui.get("vcExchangeNo").value;
		grid.hideColumn (3);
		grid.hideColumn (7);
		grid.hideColumn (9);
		grid.hideColumn (6);
		grid.hideColumn (8);
		grid.hideColumn (11);
		grid.hideColumn (10);//锁定期
		if(vcExchangeNo=="04"){
			grid.hideColumn (5);
		}else{
			grid.hideColumn (4);
		}
	})();
		
	function okProduct(e){
		var lInstructNo=nui.get("lInstructNo").value;
		var rows = grid.getSelecteds();
		var data={productJoin:rows,lInstructNo:lInstructNo,joinType:"00"};
		var json=nui.encode(data);
		if(rows.length>0){
			nui.ajax({
		        url: "com.cjhxfund.ats.ipo.busOpr.addJoinInfoForInvest.biz.ext",
		        type: "post",
		        data: json,
		        contentType:'text/json',
		        success: function (text) {
		        	var returnJson = nui.decode(text);
		        	if(returnJson.exception == null){
		        		nui.alert("参与成功，请审批","系统提示",function(){
			        		var rows=grid.getSelecteds();
			        		selectAll(rows);
		        		});
		        		
		        		grid.reload();
		        		/* document.getElementById("mini-1$body$1").style.display="none";
		        		document.getElementById("mini-1$body$2").style.display="block"; */
		        	}
		        }
	    	});
	    }else{
	    	nui.alert("请选择一行数据","系统提示");
	    }
	}
	
	function cancelProduct(){
		var lInstructNo=nui.get("lInstructNo").value;
		var rows = grid.getSelecteds();
		var data={productJoin:rows,lInstructNo:lInstructNo,joinType:"01"};
		var json=nui.encode(data);
		if(rows.length>0){
			nui.ajax({
		        url: "com.cjhxfund.ats.ipo.busOpr.addJoinInfoForInvest.biz.ext",
		        type: "post",
		        data: json,
		        contentType:'text/json',
		        success: function (text) {
		        	var returnJson = nui.decode(text);
		        	if(returnJson.exception == null){
		        		nui.alert("设置不参与成功","系统提示",function(){
			        		var rows=grid.getSelecteds();
			        		selectAll(rows);
		        		});
		        		grid.reload();
		        	}
		        }
	    	});
	    }else{
	    	nui.alert("请选择一行数据","系统提示");
	    }
	}
	function submitFlow(action){
			
			if(action == "ok"){
				
				var instructNo=nui.get("lInstructNo").value;
				
				if(lInstructNo=="" || lInstructNo==null){return;}
								
				var jsonInstructNo = nui.encode({lInstructNo:instructNo});
				//组装用户参与的产品信息
				nui.ajax({
			        url: "com.cjhxfund.ats.ipo.busOpr.queryUserJoinProdectInfo.biz.ext",
			        type: "post",
			        data: jsonInstructNo,
			        contentType:'text/json',
			        success: function (text) {
		        	var returnJson = nui.decode(text);
		        	var joinProdStr = returnJson.joinProdStr;
		        	nui.get("vcComments").setValue(nui.get("vcComments").getValue()+";"+joinProdStr);
		        	
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
				}
		    });
		}else{
			nui.get("processSubmit").enable();
		}
	}
	//流程提交函数
	function processSubmit(){
		var row=grid.findRow(function(row){
			if(row.vcProductParticipantion == "00"){
				if(myUserID==row.vcCreator || myUserID==row.vcLastupdator){
					return true;
				}else{
					nui.get("vcComments").setValue("放弃");
					return true;
				}
			}else if(row.vcProductParticipantion == "01"){
				if(myUserID==row.vcCreator || myUserID==row.vcLastupdator){
					return true;
				}else{
					nui.get("vcComments").setValue("放弃");
					return true;
				}
			}else{
				return false;
			}
		});
		if(row){
			nui.get("processSubmit").disable();
			nui.confirm("确认是否提交流程？","系统提示",function(action){
				submitFlow(action);
			});
		}else{
			nui.alert("请先在反馈参与意见页签中选择产品是【参与】还是【不参与】!");
			return false;
		}
		
	}
	
	//列表选择发生变化时触发事件
	function selectionChanged(){
	
	}
	grid.on("drawcell", function (e) {
	 	var record = e.record;
        //设置行样式
        if (record.vcProductParticipantion == "00") {//01:不参与;00:参与
            e.rowStyle = "background:#339966";
        }else if (record.vcProductParticipantion == "01"){
        	e.rowStyle = "background:#335799";
        }
      
	});
	
	grid.on("update",function(e){
		var rows=grid.getData();
		selectAll(rows);
	});
	function selectAll(rows){
		var vcType=nui.get("vcType").getValue();
		if(vcType!="null"){
			return;
		}
		var index=0;
		var len=rows.length;
		var countLen=0;
		if(len==1){
			if(rows[0].vcProductParticipantion == "00"){
				nui.get("vcComments").setValue("参与");
			}else{
				nui.get("vcComments").setValue("不参与");
			}
		}else if(len>1){
			var prodName="产品名称：";
			if(rows[0].vcProductParticipantion=="00"){
				while(index<len){
					if(rows[index].vcProductParticipantion=="00"){
						prodName=prodName+rows[index].prodName+",";
						countLen++;
					}
					index++;
				}
				if(countLen==len){
					nui.get("vcComments").setValue("参与");
				}else{
					nui.get("vcComments").setValue("部分参与"+"，"+prodName);
				}
			}else if(rows[0].vcProductParticipantion=="01"||rows[0].vcProductParticipantion==undefined){
				while(index<len){
					if(rows[index].vcProductParticipantion=="01"||rows[index].vcProductParticipantion==undefined){
						countLen++;
					}else if (rows[index].vcProductParticipantion=="00"){
						prodName=prodName+rows[index].prodName+",";
					}
					index++;
				}
				if(countLen==len){
					nui.get("vcComments").setValue("不参与");
				}else{
					nui.get("vcComments").setValue("部分参与"+"，"+prodName);
				}
			}
		}
	}
</script>
</body>
</html>