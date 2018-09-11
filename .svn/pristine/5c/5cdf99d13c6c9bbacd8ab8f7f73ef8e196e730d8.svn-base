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
	<title>交易员最终确认指令</title>
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
	<div title="交易员最终确认" class="content">
        <div class="main">
            <form id="form1" method="post" >
            	<!--基本信息-->
            	<input name="processInstID" id="processInstID" class="nui-hidden" value="<%=processInstID %>"/>
            	<input name="workItemID" id="workItemID" class="nui-hidden" value="<%=workItemID %>"/>
            	<input id="vcExchangeNo" name="vcExchangeNo" class="nui-hidden" value="<%=vcExchangeNo %>" />
            	<input id="lInstructNo" name="ipoInstructInfo.lInstructNo" class="nui-hidden" />
            	<input id="vcType" name="vcType" class="nui-hidden" value="<%=vcType %>"/>
            	<div id="panel1" class="nui-panel" title="新股发行信息"  style="width:100%;" 
                		  showCollapseButton="true"  allowResize="true" 
                		collapseOnTitleClick="true">
            		<%@include file="/ipo/offering/common/common_basicInfo.jsp" %>
            	</div>
            </form>	
        	<!--操作按钮-->
			<div style="width:100%; ">
		        <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
		            <table style="width:100%;background:#DBE3F2;">
		                <tr>
		                    <td>
		                        <a id="button1" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()" plain="false">修改</a>
		                        <span class="separator"></span>
		                        <a id="button2" class='nui-button' plain='false' iconCls="icon-remove" onclick="reject()" plain="false">剔除</a>
		                        <span class="separator"></span>
		                        <!-- <a id="button3" class='nui-button' plain='false' iconCls="icon-upload" onclick="participation()" plain="false">导出</a>
		                        <span class="separator"></span> -->
		                        <a id="button4" class='nui-button' plain='false' iconCls="icon-find" onclick="importStockIssue()" plain="false">对比</a>
		                    </td>
		                </tr>
		            </table>           
		        </div>
		    </div>
			<!--撑满页面-->
			<div class="mini-fit height-auto" style='height:auto !important' >   
			    <!--表格-->
			    <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" 
				    url="com.cjhxfund.ats.ipo.busOpr.queryPurchaseValue.biz.ext" 
				    idField="L_PRODUCT_NO"
				    dataField="purchaseInfo"
				    allowResize="true"  
					multiSelect="true" 
					showPager="false"
					onselectionChanged="selectionChanged">
				    <div property="columns">
				        <div type="indexcolumn" headerAlign="center" align="center">序号</div>
				        <div type="checkcolumn"></div>
				        <div field="prodName" width="9.2%" headerAlign="center" align="center">参与组合</div>
				        <div field="vcRationProductType" width="6.1%" align="center" headerAlign="center" renderer="rendervcRationProductType">产品类型</div>
				        <div field="enPurchasePrice" dataType="currency" width="5%" headerAlign="center" align="center">申报价格</div>
				        <div field="enPurchaseNumber" width="5%" headerAlign="center" align="center">申报数量</br>（万股）</div>
				        <div field="enPurchaseMoney" dataType="currency" width="5%" headerAlign="center" align="center">申购金额</br>（万元）</div>
				        <div field="loginname" width="6.1%" headerAlign="center" align="center">锁定期</div>
				        <div field="marketValueSz" dataType="currency" width="7.3%" headerAlign="center" allowSort="true">对应深交所日均市值</br>（万元）</div>
				        <div field="marketValueSh" dataType="currency" width="7.3%" headerAlign="center" allowSort="true">对应上交所日均市值</br>（万元）</div>
				        <div field="seatSz" width="6.1%" headerAlign="center" align="center">深圳席位号</div>
				        <div field="vcStockAccountSh" width="6.1%" headerAlign="center" align="center">沪市股东账户</div>
				        <div field="vcRationProductCode" width="6.1%" headerAlign="center" align="center">深交所配售</br>对象编码</div>
				        <div field="vcAssociationCode" width="6.1%" headerAlign="center" align="center">上交所协会编码</div>
				        <div field="vcComplianceRemark" width="12.3%" headerAlign="center">备注</div>
				        <div field="enPurchaseBeforeNumber" width="12.3%" headerAlign="center">初始申报数量</br>（万股）</div>
				    </div>
				</div>
	        </div>
		</div>	
     </div>
     <div title="审批内容" name="index">
		<%@include file="/ipo/task/processControl.jsp" %>
	</div>
	<div title="流程信息" url="/ats/sm/comm/task/processGraph.jsp?processInstID=<%=processInstID %>" ></div>
</div>
<script type="text/javascript" src="js/loadbasicInfo.js"></script>
<script type="text/javascript">
    	var grid = nui.get("datagrid1");
    	//grid.frozenColumns (0,6);
    	var data = {processInstID:processInstID,riskState:"00",participantType:"00"};
    	grid.load(data);
    	var vcExchangeNo=nui.get("vcExchangeNo").value;
    	var processInstID=nui.get("processInstID").value;
    	var button1=nui.get("button1");
    	//隐藏列
		(function (){
			grid.hideColumn (15);//配售对象初始申报数量
			if(vcExchangeNo=="04"){
				grid.hideColumn (9);//对应上交所日均市值
				grid.hideColumn (11);//沪市股东账户
				grid.hideColumn (13);//上交所协会编码
			}else{
				grid.hideColumn (8);//对应深交所日均市值
				grid.hideColumn (10);//深圳席位号
				grid.hideColumn (12);//深交所配售对象
			}
		})();
    	
    	
    	/****
	    *
		* 函数名：processSubmit
		* 机   能： 提交流程
		* 输   入：无
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
		function processSubmit(){
			nui.get("processSubmit").disable();
			var processForm=new nui.Form("processForm");
			nui.confirm("确认是否提交流程？","系统提示",function(action){
				if(action == "ok"){
					var dataNo={ processInstID: processInstID };
					var json=nui.encode(dataNo);
					var flag=false;
					var vcApprove=processForm.getData();
					/****
				    *
					* 机   能： 检查指令数据是否对比一致
					* 输   入：无
					* 输   出: vcCompareFlag 根据这个值来确认是否已
					* 对比（0存在未匹配的数据，1表示完全匹配）
					* 日   期：2017-02-21
					* 作   者： 
					*
					*****/
					if(vcApprove.vcOperateType==1){
						nui.ajax({
							url: "com.cjhxfund.ats.ipo.busOpr.queryIpoInstructInfo.biz.ext",
							type: "post",
							data: json,
							async: false,
							contentType:'text/json',
							success: function (text) {
						    	var returnJson = nui.decode(text);
							    if(returnJson.exception == null){
						        	var vcCompareFlag=text.ipoInstructInfo.vcCompareFlag;
						        	if(vcCompareFlag==0){
						        		nui.alert("询价指令尚未确认，请对比确认后再提交！","系统提示");
						        		nui.get("processSubmit").enable();
						        		flag=true;
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
			    	
			    	/****
				    *
					* 功   能： 完成当前工作任务
					* 输   入：无
					* 输   出: 无
					* 日   期：2017-02-21
					* 作   者： 
					*
					*****/
			    	if(!flag){
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
				}else{
					nui.get("processSubmit").enable();
				}
			});
		}
    	
    	/****
	    *
		* 函数名：edit
		* 机   能： 修改申报数量
		* 输   入：无
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
    	 function edit() {
            var row = grid.getSelected();
            var enOfflineUpperNumber=nui.get("enOfflineUpperNumber").getValue();
            var enOfflineUnderNumber=nui.get("enOfflineUnderNumber").getValue();
            var enPurchaseSize=nui.get("enPurchaseSize").getValue();
            if (row) {
                nui.open({
                    url: "<%=request.getContextPath() %>/ipo/offering/stockEditWindow.jsp",
                    title: "修改信息", width: 350, height: 200,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = { action: "edit", purchaseInfo:row ,enOfflineUpperNumber:enOfflineUpperNumber, enOfflineUnderNumber:enOfflineUnderNumber , enPurchaseSize:enPurchaseSize };
                        iframe.contentWindow.SetData(data);
                    },
                    ondestroy: function (action) {
                        grid.reload();
                    }
                });
                
            } else {
                nui.alert("请选中一条记录");
            }
        }
        
        /****
	    *
		* 函数名：reject
		* 机   能： 剔除产品报价信息
		* 输   入：无
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
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
	    
    	/****
	    *
		* 函数名：importStockIssue
		* 机   能：对比系统指令和导入指令的差异
		* 输   入：无
		* 输   出: 无
		* 日   期：2017-02-15
		* 作   者： 
		*
		*****/
    	function importStockIssue() {
			nui.open({
			    url:"<%=request.getContextPath() %>/ipo/offering/importStockIssueFile.jsp?vcExchangeNo="+vcExchangeNo+"&processInstID="+processInstID,
			    title: "新股信息导入", width: 850, height: 610,
			    overflow:"hidden",
			    allowDrag:true,
			    onload: function () {
			        
			    },
			    ondestroy: function (action) {
			    
			    }
			});
	    }
	    
	  grid.on("drawcell", function (e) {
	 	var record = e.record;
        //设置行样式
        if (record.vcProductParticipantion == "01") {//01:不参与;00:参与
            e.rowStyle = "background:#FF6666";
        }
	});  
	//列表选择发生变化时触发事件
	function selectionChanged(){
		var vcType=nui.get("vcType").getValue();
		if(vcType!="null"){
			return;
		}
		var rcds = grid.getSelecteds();
		if(rcds.length == 1){//如果选中了一条记录
			button1.enable();
		}else{//如果选中了多条记录
			button1.disable();
		}
	}
	//字典类型处理
	function rendervcRationProductType(e) {
		return nui.getDictText("ATS_IPO_RATION_TYPE",e.row.vcRationProductType);
	}
</script>
<style>
#tabs{
	height:auto !important
}
.mini-panel-viewport.mini-grid-viewport{
	height:auto !important
}
.height-auto{
	height:auto !important
}
.mini-panel-body.mini-grid-rows{
	height:auto !important
}
</style>
</body>
</html>