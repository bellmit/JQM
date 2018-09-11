<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2016-05-19 19:35:39
- Description: 综合信息查询-恒生估值系统估值表
--%>
<head>
<title>综合信息查询-恒生估值系统估值表</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:100%;height:100%;">
  <div class="search-condition">
	 <div class="list">
		<form id="form_HSFAGZB" method="post" >
			<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
			<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>"/>
			<%-- 查询类型 --%>
			<input class="nui-hidden" name="paramObject/queryType" value="HSFAGZB"/>
			<%--基金代码 --%>
			<input class="nui-hidden" id="prodcode" name="paramObject/vCFundCode" value="<%=request.getParameter("vCFundCode")%>"/>
			<%--业务日期 --%>
			<input class="nui-hidden" id="busdate" name="paramObject/busiDateEnd" value="<%=request.getParameter("busiDateEnd") %>"/>
			<input class="nui-hidden" name="paramObject/busiDateBegin" value="<%=request.getParameter("busiDateBegin") %>"/>
			<table id="table1" class="table" style="height:100%;table-layout:fixed;">
				<tr>
					<td class="form_label" width="80px" align="right">
					科目代码:
					</td>
					<td colspan="1" width="20%" align="left">
						<input id="vCKmdm_HSFAGZB" class="nui-textbox" width="100%" name="paramObject/vCKmdm"/>
					</td>
					<td class="form_label" width="10%" align="right">
					科目名称:
					</td>
					<td colspan="1" width="20%" align="left">
						<input id="vCKmmc_HSFAGZB" class="nui-textbox" width="100%"  name="paramObject/vCKmmc" />
					</td>
					<td colspan="1" width="40%" align="left">
						<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_HSFAGZB()"/>
						&nbsp;
						<input class='nui-button' plain='false' id="export_HSFAGZB" text="导出" iconCls="icon-download" onclick="export_HSFAGZB()"/>
						&nbsp;
						<!-- <input class='nui-button' plain='false' id="down_HSFAGZB" text="下载用印" iconCls="icon-download" onclick="down_HSFAGZB()"/> -->
						<privilege:operation sourceId="ATS_MOM_YYFJXZ" sid="down_HSFAGZB" clazz="nui-button" onClick="down_HSFAGZB()" lableName="下载用印"  iconCls="icon-download" ></privilege:operation>
					</td>
				</tr>
			</table>
		</form>
	  </div>
	</div>		
	<%-- 恒生估值系统估值表列表开始!!! --%> 	
	<div class="nui-fit">
		<div 
		    id="datagrid_HSFAGZB"
			dataField="resultObjectList"
			class="nui-datagrid"
			style="width:100%;height:100%;"
 			url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryZHXX.biz.ext"
			pageSize="100"
			frozenStartColumn="0"
			frozenEndColumn="2"
			showPageInfo="true"
			allowSortColumn="true"
			sortMode="client"
			virtualScroll="true"
			enableHotTrack="true"
			allowHeaderWrap="true"
			sizeList="[50,100,500,1000]"
			allowCellEdit="true"
			allowCellSelect="true"
			enterNextCell="true"
			allowMoveColumn="true"
			editNextOnEnterKey="true"
			idField="VC_KMDM" parentField="VC_KMDM" resultAsTree="false" 
			allowResize="true" expandOnLoad="true" treeColumn="taskname">

		<div property="columns">
			<div type="indexcolumn"></div>
			<div field="VC_KMDM" name="taskname" headerAlign="center" allowSort="true" align="left" width="130px">
                            科目代码
			</div>
			<div field="VC_KMMC" headerAlign="center" allowSort="true" align="left" width="150px">
                            科目名称
			</div>
			<div field="L_SL" headerAlign="center" allowSort="true" align="right" width="150px">
                            数量
 			</div>
			<div field="EN_DWCB" headerAlign="center" allowSort="true" align="right">
                            单位成本
			</div>
			<div field="EN_CB" headerAlign="center" allowSort="true" align="right" width="150px">
                            成本
			</div>
			<div field="EN_CBZJZ" headerAlign="center" allowSort="true" align="right">
                            成本占净值(%)
			</div>
			<div field="EN_HQJZ" headerAlign="center" allowSort="true" align="right">
                            市价
			</div>
			<div field="EN_SZ" headerAlign="center" allowSort="true" align="right" width="150px">
		市值
			</div>
			<div field="EN_SZZJZ" headerAlign="center" allowSort="true" align="right">
		市值占净值（%）
			</div>
            <div field="EN_GZZZ" headerAlign="center" allowSort="true" align="right" width="150px">
		 估值增值
            </div>
            <div field="VC_TPXX" headerAlign="center" allowSort="true" align="right" width="150px">
		停牌信息
             </div>
          </div>
        </div>
  	</div>
	<%-- 恒生估值系统估值表列表结束!!! --%>
	<form id="file_download" method="post">
            <!-- 附件id -->
            <input class="nui-hidden" name="sysid" id="sysid" />
    </form>
	
<script type="text/javascript">
    nui.parse();
    var datagrid_HSFAGZB = nui.get("datagrid_HSFAGZB");
    var form = new nui.Form("#form_HSFAGZB");
	var json = form.getData(false,false);
	datagrid_HSFAGZB.load(json);//grid查询
	
	
	//表格行增加样式
	datagrid_HSFAGZB.on("drawcell", function (e) {
    	var record = e.record;
		var VC_KMDM = record.VC_KMDM;//科目代码
		//设置行样式
		if(VC_KMDM!=null && VC_KMDM!="" && VC_KMDM.length==4){
			e.rowCls = "warn_bold";
		}
	});
	
	function search_HSFAGZB(){
	    search(datagrid_HSFAGZB, "#form_HSFAGZB");
	}
	//导出估值表
	function export_HSFAGZB(){
	    exportSubmit("export_HSFAGZB", "form_HSFAGZB", GB2312UnicodeConverter.ToGB2312('<%=request.getParameter("vCFundName")%>'));
	}
	//下载用印文件
	function down_HSFAGZB(){
		var prodcode = nui.get("prodcode").getValue();
		var busdate = nui.get("busdate").getValue();
        //给出提示并调用下载逻辑
        nui.confirm("确认要下载吗？", "系统提示",
        function(action) {
            if (action == "ok") {
             var json = nui.encode({prodcode:prodcode,busdate:busdate});
               	nui.ajax({
					url:"com.cjhxfund.jy.excelUploadAdd.excelUpload.queryMomBycode.biz.ext",
					type:'POST',
					data:json,
					cache:false,
					contentType:'text/json',		
					success:function(text){
	                    if(text.newmom.lAttachId!= null){
	                    	 nui.get("sysid").setValue(text.newmom.lAttachId);
	                         var form = document.getElementById("file_download");
                             form.action = "com.cjhxfund.jy.excelUploadAdd.FileDownLoad.flow";
                             form.submit();
                		}else{
                			nui.alert("下载失败，文件不存在！", "系统提示");
                		}
					}
			});	
            }
        });              
	}
	
</script>
</body>
</html>