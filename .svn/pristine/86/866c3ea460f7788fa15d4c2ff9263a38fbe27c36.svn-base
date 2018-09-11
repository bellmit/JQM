<%@page import="com.cjhxfund.ats.fm.commonUtil.JDBCUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>


<!-- 
  - Author(s): 王沐寰
  - Date: 2016-09-05 10:34:17
  - Description:
-->
<head>
<title>选择目标债券</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    
</head>
<body>
<div id="form1" class="nui-form"  align="center" style="height:82%" >
	<form id="queryForm" action="">
	<table id="table1" class="table" style="width: 100%;" border="0">
		<tr>
			<td  class="form_label" align="right" width="80px"> &nbsp;&nbsp;</td>
		</tr>
		
		<tr><td  class="form_label" align="right" width="80px"> &nbsp;&nbsp;选择：</td>
			<td colspan="1" align="left">
			<input  class="nui-combobox" id="combobox1"  textField="text" valueField="id" width="200px"/>
			<input  class="nui-checkbox" id="checked">继续去重
			</td>
			<td colspan="1"></td>
		</tr>
		<tr>
			<td  class="form_label" align="right" width="80px"> &nbsp;&nbsp;</td>
		</tr>
		<!-- <tr>
			<td></td>
			<td><a class='nui-button' plain='false' iconCls="icon-save"  onclick="submit()">确定</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a class='nui-button' plain='false' iconCls="icon-cancel"  onclick="onCancel()">放弃</a></td>
		</tr> -->
	</table>
	</form>
</div>
<div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
	         <table width="100%">
	             <tr>
	               <td style="text-align:center;" colspan="4">
	                  <a class='nui-button' plain='false' iconCls="icon-save"  onclick="submit()">确定</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a class='nui-button' plain='false' iconCls="icon-cancel"  onclick="onCancel()">放弃</a></td>
	                  <!-- <span style="display:inline-block;width:25px;"></span>
	                  <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
	                                取消
	                  </a> -->
	                </td>
	              </tr>
	          </table>
	      </div>


	<script type="text/javascript">
    	nui.parse();
    	var combobox1 = nui.get("combobox1");
    	var checked = nui.get("checked");
    	function SetData(rows){
    		var vals = "";
    		//combobox1.setData("[{id : 0 , text : '不可修改'},{id : 1 , text : '可修改'}]");
    		if(rows.length>0){    			
    			for(var i=0;i<rows.length;i++){
    					var text = rows[i].lStockIssueId+"|"+rows[i].vcStockCode+"|"+rows[i].vcStockNameFull;
    					vals = vals+"{id:"+rows[i].lStockInvestNo+",text:'"+text+"'}"+",";
    			}
    			
    		}else{
    			nui.alert("请选择！！！");
    		}
    		vals = "["+(vals.substring(0, (vals.length-1))+"]");
    		combobox1.setData(vals);
    		combobox1.setValue(rows[0].lStockInvestNo);
    	}
    	
    	function submit(){
    		var nodes = [];
    		var lStockInvestNo = combobox1.getValue();
    		var arr = combobox1.getText().split("|");
    		var lStockIssueId = arr[0]; 
    		var data = combobox1.getData();
    		for(var i=0;i<data.length;i++){
    				var array = data[i].text.split("|");
    				nodes.push({id:array[0]});
    		}
    		var json = nui.encode({nodes:nodes,selStock:lStockIssueId,lStockInvestNo:lStockInvestNo,type:1}); 
    		//提交的时候判断当前债券是否是正常状态		
    		nui.ajax({
				    url: "com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.checkStatus.biz.ext",
				    type: "post",
				    data: nui.encode({nodes:nodes}),
				    dataType:"json",
				    success: function (text1) {
					       if(text1.out==false){
								nui.alert("当前存在不可去重债券，请刷新页面，");
								return false;
					       }else{
					       		nui.open({
				                    url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueMergeAdd.jsp",
				                    title: "新债信息详情", 
				                    width: 980, 
				           			height: 650,
				                    //allowResize:false,
				                    onload: function () {
				                        var iframe = this.getIFrameEl();
				                        iframe.contentWindow.SetData(json,lStockIssueId);
				                    },
				                    ondestroy: function (action) {
				                        if(checked.checked){
					    					window.CloseOwnerWindow("checked");
						    			}else{
						    				window.CloseOwnerWindow("checkedNo");
						    			}
				                    }
				                });
					       		
					       }
				      	}
			});
    		
    		
    	}
    	//关闭窗口
		    function CloseWindow(action) {
		       if(action=="close" && form.isChanged()){
		           return CloseWindow("cance");/* window.close();// */
		      }else if(window.CloseOwnerWindow) {
		      	window.opener.location.reloadData();
		      	return window.CloseOwnerWindow(action);
		      } else{
		      	//window.opener.reloadData();
		      	return window.close();
		      }
		    }
    	function onCancel(){
			//查询是否有附件，有，则删除
			window.CloseOwnerWindow();
		}
    </script>
</body>
</html>