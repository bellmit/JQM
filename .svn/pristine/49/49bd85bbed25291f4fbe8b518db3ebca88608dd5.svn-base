<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 吴艳飞
  - Date: 2016-12-14 14:01:54
  - Description:
-->
<head>
<title>我的关注</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
    	$(function(){
    		//初始化改变债券代码选择提示语句
    		$("#vcStockCode>span>input").attr("placeholder","请输入证券代码");
		})
			
    </script>
</head>
<body>
	<div class="search-condition">
   		<div class="list">
   			<div id="query_condition" class="nui-form" align="center">
   				<table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                	<tr>
                		<td style="width:60px">证券代码:</td>
                        <td style="width:20%" align="left" colspan="1">
                        	<div name="vcStockCode" class="nui-autocomplete" id="vcStockCode"
	                                 textField="stockCode" valueField="stockCode"
	                                 searchField="stockCode"
	                                 url="com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.queryBondCode.biz.ext"
	                                 allowInput="true"
	                                 emptyText="请选择..."
	                                 nullItemText="请选择..."
	                                 valueFromSelect="false"
	                                 dataField="bondList"
	                                 multiSelect="false"
	                                 showClose="true"
	                                 oncloseclick="onCloseClick"
	                                 popupWidth="300"
	                                 style="width:95%">
	                           		<div property="columns">
	                                    <div header="债券代码" field="stockCode" ></div>
	                                    <div header="债券名称" field="stockName" width="100px"></div>
                                	</div>
                    		</div>
                    		<!-- <td><input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
                    				<a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">重置</a>
                    		</td> -->
                    		<!-- <td><a class='nui-button' plain='false' iconCls="icon-add" onclick="addAttention()">添加关注</a></td> -->
						</td>
						<td align="left" colspan="1">
					          <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
					   	</td>
                    </tr>
				</table>
   			</div>
   		</div>
   	</div>
   	
	<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                	<a class='nui-button' plain='false' iconCls="icon-add" onclick="addAttention()">添加关注</a>
                	<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="cancelAttention()">取消关注</a>
                </td>
            </tr>
        </table>
    </div>

	<div id="datagrid_attention_info" 
			 class="mini-datagrid"
			 url="com.cjhxfund.ats.sm.comm.MyAttentionInfoManager.queryAllAttentionBond.biz.ext" 
			 dataField="bondFollow"
			 style="width: 100%; height: 600px;" 
			 idField="id" 
			 allowResize="true"
			 sizeList="[20,30,50,100]" 
			 pageSize="20"
			 multiSelect="true">
		<div property="columns">
			<div type="checkcolumn"></div>
			<!-- 隐藏列 start -->
			<div field="vcStockInnerCode"  headerAlign="center" >证券内码	</div>
			<!-- 隐藏列 end -->
			<div field="vcStockCode" width="120" align="center" headerAlign="center">证券代码</div>
			<div field="vcStockName" width="120" align="center" headerAlign="center">证券名称</div>
			<div field="vcExchange" width="120" align="center" headerAlign="center" renderer="renderMarket">所属交易市场</div>
			<div field="vcStockType" width="120" align="center" headerAlign="center">债券类别</div>
			<div field="vcBondAppraise" width="120" align="center" headerAlign="center">债项评级</div>
			<div field="vcIssueAppraise" width="120" align="center" headerAlign="center">主体评级</div>
			<div field="vcIssueAppraiseOrgan" width="120" align="center" headerAlign="center">评级机构</div>
		</div>
	</div>
	<script type="text/javascript">
		nui.parse();
		var queryCondition = new nui.Form("#query_condition");
		var attentionInfo = nui.get("datagrid_attention_info");
		attentionInfo.hideColumns([1]);
		attentionInfo.reload();
		//添加关注弹框
		function addAttention(){
			nui.open({
			    url:"<%=request.getContextPath()%>/sm/comm/attention/addAttention.jsp",
				title : "添加关注",
				width : 300,
				height : 300,
				onload : function() {	
					
				},
				ondestroy : function(action) {
					 if (action == "ok") {
					 	attentionInfo.reload();
                    }
				}
			});
		}
		
		//页面X的删除功能
        function onCloseClick(e) {
            var obj = e.sender;
            obj.setText("");
            obj.setValue("");
        }
        
        //重置功能
        function reset(){
               queryCondition.reset();
         }
		 //查询客户关注的债券信息
       function search(){
    		var stockInfo = queryCondition.getData(false,false);
	        attentionInfo.load({bondParameter:stockInfo});
    	}
    	
        function cancelAttention(){
        	var rows = attentionInfo.getSelecteds();
        	if(rows.length > 0){
        		nui.confirm("确定取消关注此证券？", "提示",
		            function (action) {
		                if (action == "ok") {
		                	var positionInfo = copySelectData(rows);
				        	nui.ajax({
					            url : "com.cjhxfund.ats.sm.comm.MyAttentionInfoManager.cancelAttentionBond.biz.ext",
								type : 'POST',
								data : {bondParameter:positionInfo},
								cache : false,
								contentType : 'text/json',
					            success: function (text) {
					            	var returnJson = nui.decode(text);
									if(returnJson.exception == null){
										attentionInfo.reload();
										/* nui.alert("取消关注成功","提示"); */
									}else{
										nui.alert("系统异常,取消关注失败","系统提示");
									}
					            }
					        });
		                }
		            }
	        	);
        	}else{
        		nui.alert("请至少选择一条记录","提示");
        	}
        }
        //复制证券选中记录。
		function copySelectData(temp) {
   			 var temp2 = [];
   			 for (var i = 0; i < temp.length; i++) {
        		var object = {};
        		for (var key in temp[i]) {
            		object[key] = temp[i][key];
        		}
        		temp2.push(object);
   			 }
    		return temp2;
		}
		//交易市场列字典翻译
	    function renderMarket(e){
	    	return nui.getDictText("tradePlace",e.row.vcExchange);
	    }
	</script>
</body>
</html>