<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>
<html>
<!-- 
  - Author(s): 翟静
  - Date: 2016-11-18 10:14:50
  - Description:
-->
<head>
<title>新债历史评级</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="width: 100%;height: 100%;overflow: hidden;">
	<div id="tabs" class="nui-tabs" style="width: 100%;height: 93%;">
        <div title="主体评级">
               <div id="dataform2">
				  <input class="nui-hidden" name="cSource" />
				  <input class="nui-hidden" name="vcInterCode" />
				  <input class="nui-hidden" name="vcInterCodeWind" />
	           </div>
			   <div class="nui-fit">
					<div id="datagrid2" class="nui-datagrid"
					 style="width: 100%; height: 100%;" 
					 pageSize="20"   sortField="lAppraiseDate"  dataField="appraise" sortOrder="desc"
					 showPageInfo="true" url = "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.getIssuerAndBondAppraise.biz.ext">
						<div property="columns">
						    <div type="indexcolumn" headerAlign="center" width="20px">序号</div>
							<div field="lDate" headerAlign="center" width="30px" allowSort="true" >评级日期</div>	
							<div field="cIssuerAppraise" headerAlign="center" width="50px" allowSort="true" >主体评级</div>
							<div field="vcIssuerAppraiseOrga" headerAlign="center" width="110px"  allowSort="true" >主体评级机构</div>
						</div>
					</div>
			   </div>
		</div>
		<div title="债券评级">
               <div id="dataform3">
				  <input class="nui-hidden" name="cSource" />
				  <input class="nui-hidden" name="vcInterCode" />
				  <input class="nui-hidden" name="vcInterCodeWind" />
	           </div>
			   <div class="nui-fit">
					<div id="datagrid3" class="nui-datagrid"
					 style="width: 100%; height: 100%;" 
					 pageSize="20"   sortField="lAppraiseDate"  dataField="appraise" sortOrder="desc"
					 showPageInfo="true" url = "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.getIssuerAndBondAppraise.biz.ext">
						<div property="columns">
						    <div type="indexcolumn" headerAlign="center" width="20px">序号</div>
							<div field="lDate" headerAlign="center" width="30px" allowSort="true" >评级日期</div>	
							<div field="cBondAppraise" headerAlign="center" width="50px" allowSort="true" >债券评级</div>
							<div field="vcBondAppraiseOrga" headerAlign="center" width="110px"  allowSort="true" >债券评级机构</div>
						</div>
					</div>
			   </div>
		</div>
   </div>
	
	  <div id="footer" class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align:center;" >
					<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onExict()">
                                                                        关闭
					</a>
				</td>
			</tr>
		</table>
	</div>
	<script type="text/javascript">
    	nui.parse();
		var grid2 = nui.get("datagrid2"); 
		var grid3 = nui.get("datagrid3"); 
		
		var form2 = new nui.Form("#dataform2");
		var form3 = new nui.Form("#dataform3");
		 
		function SetData(data){
    	 
    	 form2.setData(data); 
    	 var data2 = form2.getData(false,false);      //获取表单多个控件的数据
         grid2.load(data2);
         
         form3.setData(data); 
    	 var data3 = form3.getData(false,false);      //获取表单多个控件的数据
         grid3.load(data3);
    	 //grid.setData(nui.decode(data));
    	}  
    	
	  //当选择列时
        function selectionChanged(){
            var rows = grid.getSelecteds();
            if(rows.length>1){
                nui.get("update").disable();
            }else{
                nui.get("update").enable();
            }
        }
        
       function onExict(){
           CloseWindow("cancel");
           
       }
	   function CloseWindow(action) {
	       if (window.CloseOwnerWindow){
		        return window.CloseOwnerWindow(action);
	       }
	       else window.close();
	   }
    </script>
</body>
</html>