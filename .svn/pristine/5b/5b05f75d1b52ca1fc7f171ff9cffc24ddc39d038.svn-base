<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 谢海光
  - Date: 2017-09-12 15:43:29
  - Description:
-->
<head>
<title>主承销商新债导入预览</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="width:100%;height:100%;overflow:height; margin: 0px;">
			       
			     <div class="nui-fit" > 
			         <div  id="datagrid1" 
			                        class="nui-datagrid"
			                        url=""
			                        style="width:100%;height:100%;"
			                        showPager="false" 
			                        multiSelect="true"
			                        >
			                    <div property="columns">
			                        <div type="indexcolumn"></div>
			                        <div field="lUnderwriterStockId" headerAlign="center" allowSort="true" visible=false>序号</div>
			                 		<div field="vcMainUnderwriter" headerAlign="center" allowSort="true" width="150px">主承销商</div>
			                 		<div field="vcUnderwriterContactInfo" headerAlign="center" allowSort="true" width="150px">主承销商相关联系方式</div>
			                 
			                 		<div field="vcApplicationTime" headerAlign="center" allowSort="true" width="180px">发行时间</div>
			                 
			                 		<div field="vcEntryTime" headerAlign="center" allowSort="true">簿记时间</div>
			                 
			                        <div field="vcIssuerNameFull" headerAlign="center" width="150px" allowSort="true" > 发行主体 </div>
			                        <div field="vcStockType" headerAlign="center" allowSort="true" >债券类别</div>
			                        <div field="vcIssueType" headerAlign="center" allowSort="true" >发行方式</div>
			                        <div field="vcStockName" headerAlign="center" allowSort="true"  width="180px">债券简称</div>
			                        <div field="vcStockNameFull" headerAlign="center" allowSort="true" >债券全称</div>
			                        <div field="vcIssueBalance" headerAlign="center" allowSort="true" width="80px" align="right">发行规模(亿)</div>
			                        <div field="vcExistLimite" headerAlign="center" allowSort="true" width="80px" align="right">发行期限(年)</div>
			                        <div field="vcExistLimiteDesc" headerAlign="center" allowSort="true" width="80px" align="right">发行期限备注</div>
			                        <div field="vcInquiryInterval" headerAlign="center" allowSort="true"  align="right" width="80px" >询价区间</div>
			                        <div field="vcIssueAppraise" headerAlign="center" align="center" allowSort="true" width="80" >主体评级</div>
			                        <div field="vcBondAppraise" headerAlign="center" align="center" width="60px">债券评级</div>
			                        
			                        <div field="vcAppraiseOrgan" headerAlign="center" width="150px" allowSort="true">债券评级机构</div>
			                        
			                        <div field="vcPaymentPlace" headerAlign="center" allowSort="true">登记托管机构</div>
			                        <div field="vcDueDate" headerAlign="center" allowSort="true" >预计到期日</div>
			                        <div field="vcPayInteval" headerAlign="center" allowSort="true" >还本付息方式</div>
			                        <div field="vcBegincalDate" headerAlign="center" allowSort="true" >起息日</div>
			                        <div field="vcCreditSituation" headerAlign="center" allowSort="true" >增信情况</div>
									<div field="vcEnterpriseProperty" headerAlign="center" allowSort="true" >企业性质</div>
									<div field="vcIsBid" headerAlign="center" allowSort="true" >是否城投</div>
									<div field="vcMarkAssets" headerAlign="center" allowSort="true" >标的资产</div>
									<div field="vcOldHolder" headerAlign="center" allowSort="true" >原始权益人</div>
									<div field="vcIsPledge" headerAlign="center" allowSort="true" >是否可质押</div>
									<div field="vcPropertyDesc" headerAlign="center" allowSort="true" >资质简介</div>
									<div field="vcHisIssue" headerAlign="center" allowSort="true" >历史发债</div>
									<div field="vcIsHaveFinancing" headerAlign="center" allowSort="true" >是否有过融资历史</div>
			                    </div>
			          </div>
			        </div>
 <div class="nui-toolbar" style="border:0; top:0px">
		    <table style="width:100%;">
		       <tr>
		           <td style="text-align:center;">
		                <a class="nui-button"  iconCls="icon-ok" onclick="onOk()">确定</a>
		               	<span style="display:inline-block;width:25px;"></span>
		        		<a class="nui-button"   iconCls="icon-cancel" onclick="onCancel()">取消</a>
		           </td>
		       </tr>
		    </table>
		</div>   
   <script type="text/javascript">
        nui.parse();
		var grid = nui.get("datagrid1");
		var filePath="";
		var clientPath="";
		var customName="";
        function SetData(formData){
            filePath=formData.filePath1;
            clientPath=formData.clientPath1;
            customName=formData.customName1;
            grid.setData(formData.underwriterStockInfo);
            
        }
        var isfalse=true;
        function onOk(){
           if(isfalse){
              isfalse=false;
              var userId='<%=operatorId %>';
              var json =nui.encode({userid:userId,clientPath:clientPath,filePath:filePath,customName:customName});
				nui.ajax({
				    url: "com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager.customUnderwriterStockUpload.biz.ext",
				    type: "post",
				    data: json,
				    dataType:"json",
				    success: function (e) {
				      isfalse=true;
				      if(e.msgList==null){
				      	nui.alert("导入失败,请检查数据！");
				      }else{
				      	var msglist = e.msgList;//msglist
				       if(nui.decode(msglist).exception){
				          nui.alert("导入失败,请检查数据！", "", function(){});
				          return;
				        }
				       if(nui.decode(msglist)){
				    		mini.open({
								    url:"<%=request.getContextPath() %>/fm/baseinfo/fileupload/resultMsg.jsp",
								    title: "导入返回的结果信息", width: 500, height: 500,
								    overflow:"hidden",
								    onload: function () {
								        var iframe = this.getIFrameEl();
								        //console.log(msglist);
								        iframe.contentWindow.SetData({msgList:msglist});
								    },
								     ondestroy: function (action) {	
								  		//prodIfmName.window.clearFileupload();
								  		CloseWindow("cancel");
							  		} 
								});
							}
				      }
				    }
				});
			}
        }
		//取消
        function onCancel() {
            CloseWindow("cancel");
        }
         //关闭窗口
        function CloseWindow(action) {
            if (action == "close" && form.isChanged()) {
                if (confirm("数据被修改了，是否先保存？")) {
                    saveData();
                }
            }
            if (window.CloseOwnerWindow)
            return window.CloseOwnerWindow(action);
            else window.close();
        }
   </script>
  </body>
</html>