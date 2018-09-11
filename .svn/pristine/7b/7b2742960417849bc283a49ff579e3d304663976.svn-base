<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 童伟
  - Date: 2017-11-14 17:10:44
  - Description:
-->
<head>
<title>报量历史</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<div>
		<div style="float: left;padding-left: 10px;line-height: 30px;font-size:10px;color:red;height:30px;">
			<b>说明：</b>①报量为100万整数倍；②特殊说明请在报量说明中填写；③报价待定时为空即可；
		</div>
	
		<div style="width:100%;height:345px;" class="nui-datagrid" id="reportGrid" showPager="false" allowSortColumn="false" allowCellSelect="true" multiSelect="true" allowCellValid="true">
			<div property="columns">
				<div field="lApplyInstId" width="20px" headerAlign="center" allowSort="true" align="center">
					指令编号
				</div>
				<div field="reportInfo" headerAlign="center" allowSort="true">
					      报价信息
				</div>
			</div>
		</div>
		<div class="" style="padding:0px;height:30px;" borderStyle="border:0;">
        	<table width="100%">
            	<tr>
              		<td style="text-align:center;" colspan="4"> 
	                  	<span style="display:inline-block;width:25px;"></span>
	                  	<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="CloseWindow()">关闭</a>
	                </td>
              	</tr>
          	</table>
      	</div>
	</div>
	<script type="text/javascript">
    	nui.parse();
    	var reportGrid = nui.get("reportGrid");
    	
    	//关闭窗口
	    function CloseWindow(action) {
	       if (window.CloseOwnerWindow)
	          return window.CloseOwnerWindow(action);
	       else window.close();
	    }
    	
    	function setData(investNo){
			var json = nui.encode({investNo:investNo});
			//查询系统报量信息
			$.ajax({
				url:"com.cjhxfund.ats.fm.comm.common.queryReportHistoryList.biz.ext",
				type:'POST',
				data:json,
				cache:false,
				async:false,
				contentType:'text/json',
				success:function(data){
					reportGrid.setData(data.reportInfoObj);
				}
			});
    	}
    </script>
</body>
</html>