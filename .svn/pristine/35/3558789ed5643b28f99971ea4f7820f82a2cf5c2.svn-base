<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 黄燕
  - Date: 2016-08-31 17:31:57
  - Description:
-->
<head>
<title>一级债信息查重</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    
</head>
<body style="width:100%;height:100%;overflow: hidden; margin: 0px;">
	<div class="search-condition">
		<div class="list">
            <div id="form1" class="nui-form"  align="center" style="height:10%" >
                <form id="queryForm" action="">
                <table id="table1" class="table" style="width: 100%;" border="0">
                    <tr>
                        <td class="form_label" align="right">
                            	流程id:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-textbox" id="lProcessInstId" name="criteria._expr[0].lProcessInstId" style="margin-left: 10px;"/>
                            <input class="nui-hidden" name="criteria._expr[0]._op" value="="/>
                        </td>
                        <td class="form_label" align="right">
                            	申请人:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-textbox" id="vcUserId" name="criteria._expr[1].vcUserId" style="margin-left: 10px;"/>
                            <input class="nui-hidden" name="criteria._expr[1]._op" value="like"/>
							<input class="nui-hidden" name="criteria._expr[1]._likeRule" value="all"/>
                        </td>
                        <td>
                        	<div property="footer" align="right">
					            <a class='nui-button' plain='false' iconCls="icon-search"  onclick="search()">查询</a>
					            <a class='nui-button' plain='false' iconCls="icon-search"  onclick="repeatSet()">去重设置</a>
					            <a class='nui-button' plain='false' iconCls="icon-search"  onclick="repeat()">去重</a>
					    	</div>
					    </td>
                   </tr>
                </table>
               </form>
            </div>
          </div>
        </div>  
	<div id="datagrid1" class="nui-datagrid" onselectionchanged="onSelectionChanged"  style="width:100%;height:60%" allowResize="true" url="com.cjhxfund.ats.fm.baseinfo.approveInfoManager.queryRepeat.biz.ext" idField="lBizId" idField="id" dataField="result"  multiSelect="true">
		<div property="columns">
			<div type="checkcolumn"></div>
			<div field="lBizId" width="120" headerAlign="center" allowSort="true">主键ID</div>
			<div field="lProcessInstId" width="120" headerAlign="center" allowSort="true">流程id</div>
			<div field="vcUserId" width="120" headerAlign="center" allowSort="true">申请人</div>
			<div field="dApplicationTime" width="100" headerAlign="center"  dateFormat="yyyy-MM-dd" allowSort="true">申请时间</div>
			<div field="vcProcessType" width="120" headerAlign="center" allowSort="true">流程类型</div>
			<!-- <div field="vcAbstract" width="120" headerAlign="center" allowSort="true">摘要</div>
			<div field="vcProductCode" width="120" headerAlign="center" allowSort="true">产品编码</div>
			<div field="vcProductName" width="120" headerAlign="center" allowSort="true">产品名称</div>
			<div field="vcCombiNo" width="120" headerAlign="center" allowSort="true">投资组合编号</div>
			<div field="vcCombiName" width="120" headerAlign="center" allowSort="true">投资组合名称</div>
			<div field="lAssetId" width="120" headerAlign="center" allowSort="true">资产单元序号</div>
			<div field="vcAssetName" width="120" headerAlign="center" allowSort="true">资产单元名称</div>
			<div field="vcAssetNo" width="120" headerAlign="center" allowSort="true">资产单元编号</div> -->
			<div field="vcStockCode" width="120" headerAlign="center" allowSort="true">债券编号</div>
			<div field="vcStockName" width="120" headerAlign="center" allowSort="true">债券名称</div>
			<div field="vcStockType" width="120" headerAlign="center" allowSort="true">债券类别</div>
			<div field="lInvestNo" width="120" headerAlign="center" allowSort="true">申购投资编号</div>
			<!-- <div field="lFixValidStatus" width="120" headerAlign="center" allowSort="true">fix状态</div>
			<div field="vcClordId" width="120" headerAlign="center" allowSort="true">fix编号</div> -->	
		</div>
	</div>
	
	<div id="datagrid2" class="nui-datagrid"  style="width:100%;height:30%" allowResize="true" url="com.cjhxfund.ats.fm.baseinfo.approveInfoManager.queryRepeat.biz.ext" idField="lBizId" idField="id" dataField="result"  multiSelect="true">
		<div property="columns">
			<div field="lBizId" width="120" headerAlign="center" allowSort="true">流程序号</div>
			<div field="lStorkInvestNo" width="120" headerAlign="center" allowSort="true">证券投资编号</div>
			<div field="cStatus" width="100" headerAlign="center" allowSort="true">新债发行数据状态</div>
			<div field="vcInterCode" width="120" headerAlign="center" allowSort="true">债券内码</div>
			<div field="vcStockCode" width="120" headerAlign="center" allowSort="true">债券代码</div>
			<div field="vcStockName" width="120" headerAlign="center" allowSort="true">债券简称</div>
			<div field="vcStockName_full" width="120" headerAlign="center" allowSort="true">债券全称</div>
			<div field="vcStockType" width="120" headerAlign="center" allowSort="true">债券类别</div>
			<div field="enExistLimite" width="120" headerAlign="center" allowSort="true">发行期限(年)</div>
			<div field="enIssueBalance" width="120" headerAlign="center" allowSort="true">发行规模(亿)</div>
			<div field="cBondAppraise" width="120" headerAlign="center" allowSort="true">债券评级</div>
			<div field="vcIssueAppraiseOrgan" width="120" headerAlign="center" allowSort="true">债券评级机构</div>
		</div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid1"); 
		grid.load();
		//grid.sortBy("lBizId","desc");
		var row = grid.getSelected();
		if(row){
			alert(row);
		}
		function search() {
		    var form = new nui.Form("#form1");
		   	var data = form.getData(); //获取表单JS对象数据
	      	grid.load(data); //datagrid加载数据
	   }
	   function repeatSet(){
	   		nui.open({
			  url: "<%=request.getContextPath() %>/empmgr/EmpInput.jsp",
			                title: "去重设置", width: 600, height: 360,
			  onload: function () {
			    var  iframe = this.getIFrameEl();
			    var data = { action: "new"};
			    iframe.contentWindow.SetData(data);
			  },
			  ondestroy: function (action) {
			    grid.reload();
			  }
			});
	   }
	   function onSelectionChanged(e) {
            var grid = e.sender;
            var record = grid.getSelected();
            if (record) {
                //datagrid2.load({ lBizId: record.lBizId });
                alert(record.lProcessInstId);
            }
        }
    </script>
</body>
</html>