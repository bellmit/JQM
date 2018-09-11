<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): 童伟
  - Date: 2017-10-24 15:17:28
  - Description:
-->
<head>
<title>返回审批信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<div id="approveResultInfoGrid" class="nui-datagrid" style="width:100%;height:353px" 
		showPager="false" multiSelect="false">
        <div property="columns">
            <div type="indexcolumn"></div>
            <div field="resultNo" headeralign="center" align="center" width="40px" renderer="resultNoValue">询价序号</div>   
            <div field="rtnCode" headeralign="center" align="center" width="40px" renderer="rtnCodeValue">处理结果</div>   
            <div field="rtnMsg" headeralign="center" align="center" width="200px">返回信息</div>
            <div field="vcBizType" name="vcBizType" headeralign="center" align="center" width="">业务类别</div>
        </div>
	</div>
	<div style="padding-top:5px;padding-bottom:5px; text-align: center;">
		<a class='nui-button' plain='true' iconCls="icon-cancel" onclick="onClose()">关闭</a>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var approveResultInfoGrid = nui.get("approveResultInfoGrid");
    	function setFormData(data){
    		//跨页面传递的数据对象，克隆后才可以安全使用
    		var resultInfoList = nui.clone(data);
    		for(var i=0; i<resultInfoList.length; i++){
    			var resultInfo = resultInfoList[i];
	    		if(resultInfo.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
	    			resultInfo.rtnCode = "成功";
				}else if(resultInfo.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
					resultInfo.rtnCode = "失败";
				}else if(resultInfo.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_NO_RCV_FR_O32%>"){
					resultInfo.rtnCode = "发送O32";
				}else if(resultInfo.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_RISK_VIOLATE_FORBID_CTRL%>"){
					resultInfo.rtnCode = "失败";
					resultInfor.tnMsg = "触发禁止风控,"+resultInfo.rtnMsg;
				}else if(resultInfo.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ORDER_USABLE_AMOUNT_INSUFFICIENT%>"){
					resultInfo.rtnCode = "失败";
				}
    		}
    		approveResultInfoGrid.hideColumn("vcBizType");
    		approveResultInfoGrid.addRows(resultInfoList);
    	}
	    
	    // 序号链接跳转
	    function resultNoValue(e){
			var s = null;
			if(e.row.resultNo != ""){
				s = "<a class='nui-button' style='color:#6959CD; cursor:pointer;text-decoration:underline;' onclick='instructDetail(\""+e.row.resultNo+"\",\""+e.row.vcBizType+"\")'>"+e.row.resultNo+"</a>";
			}
			return s;
		}
		
		//处理结果列处理，颜色处理，处理结果列，成功显示绿色，失败显示红色；
    	approveResultInfoGrid.on("drawcell", function (e) {
			var field = e.field,
	    		value = e.value;
	    	if(field =="rtnCode"){
	    		if(value=="发送O32中"){
					e.cellStyle="color:#EEC900;font-weight:bold";
	    		}else if(value=="失败"){
					e.cellStyle="color:#FF6666;font-weight:bold";
	    		}
	    		
	    	}
	    });
		
		//展示指令详细信息
	   function instructDetail(resultNo,vcBizType) {
	   		var frameHeight = 666;
	   		var url = "<%=request.getContextPath()%>/inquiry/inquiryResultManage/inquiryResultConfirm/repurchase/inquiryDetailShow_znhg_zyshg.jsp";
	   		if(vcBizType == "1"||vcBizType=="3"){
	   		
	   			url = "<%=request.getContextPath()%>/inquiry/inquiryResultManage/inquiryResultEntering/transaction/inquiryDetailShow_zqmm.jsp";
   				if(vcBizType=="1"){
		    		frameHeight = 376;
    			}else{
	    			frameHeight = 408;
    			}
	   		}
		    if (resultNo) {
		    	nui.open({
		            url: url,
		            title: "指令/建议详细展示",
		            width: 700,
		            height: frameHeight,
		            onload: function () {
		                var iframe = this.getIFrameEl();
		                // 直接从页面获取，不用去后台获取
		                iframe.contentWindow.setResultNo(resultNo);
		            },
		            ondestroy: function (action) {//弹出页面关闭前
			        }
		        });
		    }
	   }
	   
	   function onClose(action){
			if (window.CloseOwnerWindow)
			return window.CloseOwnerWindow(action);
			else window.close();
		}	   
	   
    </script>
    
    
</body>
</html>