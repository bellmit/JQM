<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<title>附件下载</title>
<style>
	/*表头高度*/
	.mini-grid-table{
		height:25px;
	}
	.mini-button-plain{
		margin-top:0px !important;
	}
	/*隐藏分页栏*/
	.mini-grid-pager{
		display:none !important;
	}
</style>
<div style="width:590px;">
    <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
        <table style="width:100%;">
            <tr>
	            <td style="width:100%;">
	                <a class='nui-button' plain='false' id="fileDownload" iconCls="icon-download" onclick="fileDownload1()" style="margin-top: 5px;" plain="false">下载</a>
                </td>
            </tr>
        </table>           
    </div>
</div>
<div id="file_grid" class="nui-datagrid" style="width:590px;height:150px;" 
	 url="com.cjhxfund.ats.ipo.busOpr.queryDownloadFile.biz.ext" 
	 dataField="attachments"  multiSelect="true" allowSortColumn="false">
	 <div property="columns">
		<div type="indexcolumn" width="10"></div>
		<div type="checkcolumn" width="15"></div>
		<div field="lAttachId"  headerAlign="center" visible="false">编号</div> 
		<div field="vcAttachName"  headerAlign="center" style="width: 70%;" allowSort="true">文件名</div> 
	 </div>
</div>
<script>

</script>