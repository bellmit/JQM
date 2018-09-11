
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): wuyanfei
  - Date: 2016-09-09 17:19:48
  - Description:
-->
<head>
<title>询价录入</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/css/instruct.css"/>
    
</head>
<body>
	<!-- 查询条件开始 -->
	<div class="search-condition" id="one">
	   <div class="list">
	   		<div id="form_instruct_follow_condition" class="nui-form" align="center">
   				<table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                	<tr>
						<td width="60px"><span>产品名称:</span></td>
                        <td  align="left" width="15%" >
							<input class="nui-textbox" name="paramObject/vcStockCode" style="width:95%;"/>
						</td>
						<td>
							<a class='nui-button' plain='false' iconCls="icon-reset" >重置</a>&nbsp;
							<a class="mini-button" iconCls="icon-search" >查询</a>
						</td>
                    </tr>
				</table>
			</div>
	  	</div>
   	</div>
	<%-- 查询条件结束!!! --%>
	
	<!-- 查询条件开始 -->
	<div style="width:100%;height:80%">
		<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	        <table style="width:100%;">
	            <tr>
	                <td style="width:100%;">
	                	<a class="mini-button" iconCls="icon-edit" onclick="search()">录入询价结果</a>
						<a class="mini-button" iconCls="icon-edit" onclick="query()">录入线下指令/建议询价</a>
						<a class="mini-button" iconCls="icon-download">导出</a>
	                </td>
	            </tr>
	        </table>
	    </div>
		
		<div id="datagrid1" class="mini-datagrid" style="width:100%;height:50%;" 
        	 showPager="true" 
        	 showPageInfo="true"
        	 multiSelect="true"
             pagerButtons="#prompt_todays">
	        <div property="columns">
	            <div field="createtime" width="100" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true">日期</div> 
	            <div field="loginname" width="120" headerAlign="center" allowSort="true">询价指令/建议序号</div>    
	            <div field="name" width="120" headerAlign="center" allowSort="true">指令/建议状态</div>                            
	            <div field="gender" width="100"  align="center" headerAlign="center">询价状态</div>
	            <div field="salary" width="100" allowSort="true" headerAlign="center">确认状态</div>                                    
	         <!--    <div field="age" width="100" allowSort="true" headerAlign="center">产品代码</div> -->
	            <div field="name" width="120" headerAlign="center" allowSort="true">产品名称</div>                            
	            <div field="gender" width="100"  align="center" headerAlign="center">组合名称</div>
	            <div field="salary" width="100" allowSort="true" headerAlign="center">债券代码</div>                                    
	            <div field="age" width="100" allowSort="true" headerAlign="center">债券名称</div>
	            <div field="name" width="120" headerAlign="center" allowSort="true">业务类别</div>                            
	            <div field="gender" width="100"  align="center" headerAlign="center">委托方向</div>
	            <div field="salary" width="100" allowSort="true" headerAlign="center">询价金额(万元)</div>                                    
	            <div field="age" width="100" allowSort="true" headerAlign="center">清算速度</div>
	                           
	        </div>
	        <div id="prompt_todays">
		        <!-- <span class="separator"></span> -->
		        <div  style="margin-left:100px" name="product" class="mini-checkbox" readOnly="false" text="未询价" value="Y" trueValue="Y" falseValue="N" ></div>
				<div style="margin-left:50px; color:#45F819" name="product" class="mini-checkbox" readOnly="false" text="已完成" ></div>
				<div style="margin-left:50px; color:red" name="product" class="mini-checkbox" readOnly="false" text="已撤销" ></div>
				<div style="margin-left:50px; color:blue" name="product" class="mini-checkbox" readOnly="false" text="已修改" ></div>
	    	</div> 
    	</div> 
		<div id="datagrid1" class="nui-tabs" style="width:100%;height:46%; margin-top:10px" >
			 <div title="询价指令/建议详情" url="<%= request.getContextPath() %>/transaction/manage/enquiry_entering/enquiryEnteringDetails.jsp"></div>
			<div title="询价结果" url="<%= request.getContextPath() %>/transaction/manage/enquiry_entering/enquiryResult.jsp"></div>
			<div title="触犯风控" url="<%= request.getContextPath() %>/transaction/manage/enquiry_entering/offendRiskControl.jsp"></div>
			<div title="投资指令/建议审批信息" url="<%= request.getContextPath() %><!-- /transaction/manage/enquiry_entering/offendRiskControl.jsp -->"></div>
		</div>
	</div>
	<!-- 查询条件结束-->
	
	<script type="text/javascript">
    	nui.parse();
    	
    	var grid = nui.get("one");
    	function search(){
    		nui.open({
    			url:"<%=request.getContextPath() %>/transaction/manage/enquiry_entering/enteringEnquiryResult.jsp",
    			/* title:"录入询价结果", */
    			width:900,
    			height:600,
    			onload:function(){
    				
    			},
    			ondestroy:function(action){
    				
    			}
    		});
    	}
    	
    	function query(){
    		nui.open({
    			<%-- url:"<%=request.getContextPath() %>/transaction/invest/instructIssue.jsp", --%>
    			url:"<%=request.getContextPath() %>/transaction/manage/enquiry_entering/enteringOfflineInstructEnquiry.jsp",
    			title:"录入线下指令/建议询价",
    			width:900,
    			height:560,
    			onload:function(){
    			
    			},
    			ondestroy:function(){
    			
    			}
    		});
    	}
    </script>
</body>
</html>