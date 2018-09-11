<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<%@ taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<%@ taglib uri="http://eos.primeton.com/tags/dict" prefix="d"%>
	
<!-- 
  - Author(s): CJ-WB-DT13
  - Date: 2016-07-19 10:53:42
  - Description:
-->
<head>
<title>债券日历</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        
</head>
<body style="width:100%;height:100%;">
<%
  int i = 0;
 %>

	<l:iterate id="id1" property="objs" indexId="i">
	
	      <div style="float: left;width: 20%;border: 1px solid #DCDCDC;margin: 2px;">
	        <dl style="">
	        	<dt style="border-bottom: 1px solid #DCDCDC;height: 40px;"><b:write iterateId="id1" property="vcStockName"/></dt>
	      		<dd style="border-bottom: 1px solid #DCDCDC;text-align: right;" >申购区间：</dd>
	      		<dd style="border-bottom: 1px solid #DCDCDC;">
	      			<label style="margin: 2px 2px 20px 2px;">
	      				<d:write iterateId="id1" dictTypeId="CF_JY_PRODUCT_PROCESS_SUBJECT_RATING" property="cIssueAppraise"/>/<d:write iterateId="id1" dictTypeId="CF_JY_PRODUCT_PROCESS_BOND_RATING" property="cBondAppraise" /></label>
	      		    <label style="margin: 2px 2px 20px 2px;">7年</label>
	      		    <label style="margin: 2px 2px 20px 2px;"><b:write iterateId="id1" property="enIssueBalance"/></label>
	      		</dd>
	      		<dd style="border-bottom: 1px solid #DCDCDC;text-align: right;">
	      			<a href="#" style="margin: 2px;" onclick="offerDownload()">募集说明书下载</a>
	      		</dd>
	      		<dd style="text-align: right;">
	      			<a class='nui-button' plain='false' style="margin: 2px;" onclick="details('<b:write iterateId="id1" property="vcInterCode"/>')">详情</a>&nbsp;
				    <a class='nui-button' plain='false' style="margin: 2px;" onclick="applyPurchase()">申购</a>
				</dd>
	        </dl>
	      </div>
	   <% i++; %>
	   <%
	      if(i%5==0){
	    %>
	    <br/>
	    <%
	     }
	    %>
	    
	</l:iterate>
	
	<script type="text/javascript">
    	nui.parse();
    	
    	//募集书下载
    	function offerDownload(){
    	}
    	
    	//详细信息
    	function details(vcInterCode){
			nui.open({
				url: "<%=request.getContextPath() %>/investmentIssued/firstGradeDebt/firstGradeDebt_details.jsp",
				title: "债券详情",width: 800, height: 540,
				onload: function () {//弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {pageType:"add",vcInterCode:vcInterCode};//传入页面的json数据
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function (action) {//弹出页面关闭前
               		
          		}
        	});
    	}
    	
    	//申购
    	function applyPurchase(btId){
    		nui.open({
				url: "<%=request.getContextPath() %>/investmentIssued/firstGradeDebt/firstGradeDebt_applyPurchase.jsp",
				title: "债券申购",width: 750, height: 560,
				onload: function () {//弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {pageType:"add",btId:btId};//传入页面的json数据
					//iframe.contentWindow.setFormData(data);
				},
				ondestroy: function (action) {//弹出页面关闭前
               		
          		}
        	});
    	}
    </script>
</body>
</html>