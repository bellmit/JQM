<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@page import="java.util.List"%>  
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="java.util.ArrayList"%>  
<%@page import="com.cjhxfund.ats.fm.commonUtil.DateUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): zhangyao
  - Date: 2016-12-06 16:13:30
  - Description:
-->
<head>
	<title>账户信息导入</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" href="css/offeringStyle.css"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/fm/comm/fileupload/js/swfupload.js"></script>
	<style>
	 	/*隐藏分页栏*/
		.mini-grid-pager{
			display:none !important;
		}
		b{
			font-weight:normal;
			color:#64A0E5;
		}
	</style>
</head>
<body>
<%
	String replaceFileName = DateUtil.currentDateString(DateUtil.YMD_NUMBER);
	String processInstID=request.getParameter("processInstID");
	String vcExchangeNo=request.getParameter("vcExchangeNo");
 %>
	<div style="width:100%;height:100%; "  borderStyle="border:solid 1px #aaa;">
		<table style="height:3px;vertical-align: middle;">
			<tr>
				<td style="width:20px;"  align="right">
					<div class="mini-button mini-button-disabled" enabled="false" iconCls="icon-edit"></div>
				</td>
				<td style="width:150px;"  align="left">
					<h4>新股信息导入配置</h4>
				</td>
			</tr>
		 </table>
		 <hr/>
		 <div style="margin-bottom:10px;"></div>
	  <iframe id="prodIfm" name="prodIfm" width="590"  height="30px" frameborder="no" border="0" marginwidth="0" marginheight="0" scolling="no" ></iframe>
	  <!--注释-->
	<div style="width:100%;">
	    <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	        <table style="width:100%;background:#DBE3F2;">
	            <tr>
	                <td  style="float:right;margin-right:10px;">
	                	<span style="color:#626262;">对比错误:<strong class="strong" style="background:#FF6666;"></strong></span>
	                	<span style="color:#626262;">本地数据无对比项:<strong class="strong" style="background:#339966;"></strong></span>
	                	<span style="color:#626262;">Excel导入数据无对比项:<strong class="strong" style="background:#0099FF;"></strong></span>
	                </td>
	            </tr>
	        </table>           
	    </div>
	</div>
	  <!-- 动态获取表内容 -->
	  <div class="description" style="margin-bottom:0px; height:450px;overflow: auto; ">
		 <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" 
	        allowCellEdit="true" allowCellSelect="true" multiSelect="true"
	        url="com.cjhxfund.ats.ipo.busOpr.loadData.biz.ext"  
	        idField="lPurchaseNo"
    		dataField="purchaseData"
	        allowCellValid="true">
	        <div property="columns">
	            <div field="rowid" name="rowid" width="50" align="center" headeralign="center">序号</div>
	            <div field="dsSource" width="100" headerAlign="center" align="center" renderer="ondataSourceRenderer">数据来源</div>
	            <!--深交所-->
	            <div field="vcRationProductCode" width="100" headerAlign="center" align="center">配售对象编码
	                <input property="editor" class="nui-textbox" style="width:100%;"/>                
	            </div>
	            <div field="codeFlag" width="30" headerAlign="center" align="center">codeFlag</div>
	            
	            <div field="enPurchasePrice" width="80" headerAlign="center" align="center">申报价格</br>（元）
	                <input property="editor" class="nui-textbox" style="width:100%;"/>                
	            </div>
	            <div field="priceFlag" width="30" headerAlign="center" align="center">priceFlag</div>
	            
	            <div field="enPurchaseNumber" width="100" headerAlign="center" align="center">拟申购数量</br>（万股）
	                <input property="editor" class="nui-textbox" style="width:100%;"/>                
	            </div>
	            <div field="numFlag" width="30" headerAlign="center" align="center">numFlag</div>
	            
	            <div field="vcStockAccountSz" width="100" headerAlign="center" align="center">证券账户
	                <input property="editor" class="nui-textbox" style="width:100%;"/>                
	            </div>
	            <div field="accountFlag" width="30" headerAlign="center" align="center">accountFlag</div>
	            
	            <div field="vcRationProductName" width="260" headerAlign="center" align="center">配售对象名称
	                <input property="editor" class="nui-textbox" style="width:100%;"/>                
	            </div>
	            <div field="nameFlag" width="30" headerAlign="center" align="center">nameFlag</div>
	            
	            <div field="seatSz" width="100" headerAlign="center" align="center">托管席位
	                <input property="editor" class="nui-textbox" style="width:100%;"/>                
	            </div>
	            <div field="seatFlag" width="30" headerAlign="center" align="center">seatFlag</div>
	            
	            <div field="lLockTime" width="80" headerAlign="center" align="center">自愿锁定期
	                <input property="editor" class="nui-textbox" style="width:100%;"/>                
	            </div>
	            <div field="lLockFlag" width="30" headerAlign="center" align="center">2</div>
	            
	            <!--上交所-->
	            <div field="vcPurchaseCode" width="80" headerAlign="center" align="center">证券代码
	                <input property="editor" class="nui-textbox" style="width:100%;"/>                
	            </div>
	            <div field="codeSFlag" width="30" headerAlign="center" align="center">codeFlag</div>
	            
	            <div field="vcStockAccountSh" width="120" headerAlign="center" align="center">配售对象代码</br>（上交所股东账号）
	                <input property="editor" class="nui-textbox" style="width:100%;"/>                
	            </div>
	            <div field="AccountShFlag" width="30" headerAlign="center" align="center">2</div>
	            
	            <div field="vcRationProductName" width="260" headerAlign="center" align="center">配售对象名称
	                <input property="editor" class="nui-textbox" style="width:100%;"/>                
	            </div>
	            <div field="nameFlag" width="30" headerAlign="center" align="center">nameFlag</div>
	            
	            <div field="enPurchasePrice" width="100" headerAlign="center" align="center">拟申购价格</br>(元)
	                <input property="editor" class="nui-textbox" style="width:100%;"/>                
	            </div>
	            <div field="priceFlag" width="30" headerAlign="center" align="center">priceFlag</div>
	            
	            <div field="enPurchaseNumber" width="80" headerAlign="center" align="center">申购数量</br>(万股)
	                <input property="editor" class="nui-textbox" style="width:100%;"/>                
	            </div>
	            <div field="numFlag" width="30" headerAlign="center" align="center">numFlag</div>
	            
	            <div field="lLockTime" width="80" headerAlign="center" align="center">自愿锁定期</br>（月）
	                <input property="editor" class="nui-textbox" style="width:100%;"/>                
	            </div>
	            <div field="2" width="30" headerAlign="center" align="center">2</div>
	        </div>
	    </div>
	 </div>
  </div>
 
	 <div id="footer" class="nui-toolbar" style="padding:0px; width:100%;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align:center;" >
					<!-- <a class='nui-button' plain='false' iconCls="icon-save" onclick="startUpload()">
                                                                        保存
					</a>
					
					<span style="display:inline-block;width:25px;"></span> -->
					<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
                                                                          关闭
					</a>
				</td>
			</tr>
		</table>
	</div>	
	<input id="vcExchangeNo" name="vcExchangeNo" class="nui-hidden" value="<%=vcExchangeNo %>" /> 
<script type="text/javascript">
	nui.parse();
	$("#prodIfm").attr("src","<%=request.getContextPath() %>/ipo/offering/common/fileUpload.jsp");
	var templetDownload = "onUpload";
	var func = "onUploadSuccess";
	var startUploadfunc = "startUpload";
    var UpSuccessBizParm=new Array();//params中按顺序给 逻辑流参数赋值.所以 Fdata 参数必须在回调逻辑流的第一位，其他参数必须按照数组顺序赋值，否则会出现赋值混乱，可为空
	UpSuccessBizParm[0]='<%=processInstID %>';
	var UpSuccessBiz="com.cjhxfund.ats.ipo.busOpr.instructCompare";//上传回调逻辑流全名称 逻辑流名称+逻辑构建全称，不可和回调函数名同时为空
    var grid=nui.get("datagrid1");
    function onFileSelect(e) {
        //alert("选择文件");
    }
    function onUploadSuccess(e) {
		var msglist = e.result[0];
		var data={equalData:e.result[0]};
		if(msglist==null){
			nui.alert("导入数据文件的申购代码与系统指令申代码不一致，请选择正确的文件！", "系统提示");
			return;
		}
        grid.load(data);
		if(nui.decode(msglist).exception){
			nui.alert("导入失败,请检查数据！", "", function(){});
			return;
        }else{
        	
        }
        
    }
    
    
    function onUploadError(e) {
         alert("上传失败：" + e.serverData);
    }

    function startUpload(fileupload) {
		var excelName = fileupload.text;
		if(excelName == ""){
			nui.alert("请选择一个导入文件", "", function(){});
	        return;
        }
		var reg = /\.(xls|xlsx)/i;
		if(!reg.test(excelName)){
        	nui.alert("文件类型不是*.xls或*.xlsx格式，请重新选择！", "", function(){});
	        return;
        }
    }
    
    function onCancel(){
           CloseWindow("cancel");
    }
     //关闭窗口
     function CloseWindow(action) {
        if (window.CloseOwnerWindow){
	        return window.CloseOwnerWindow(action);
        }
        else window.close();
    }
    
  grid.on("drawcell", function (e) {
    	var record = e.record,
    	 	field=e.field;
    	if(record.recordFlag=="1"){//1:本地数据无匹配;2:Excel导入数据无匹配
    		e.cellStyle="background:#0099FF;";
    	}
    	if(record.recordFlag=="2"){//1:本地数据无匹配;2:Excel导入数据无匹配
    		e.cellStyle="background:#339966;";
    	}
    	if(field == "vcRationProductCode"){
    		if(record.codeFlag=="1"){
				e.cellStyle="background:#FF6666;";
        	}
     	}
     	if(field == "enPurchasePrice"){
    		if(record.priceFlag=="1"){
				e.cellStyle="background:#FF6666;";
        	}
     	}
     	if(field == "enPurchaseNumber"){
    		if(record.numFlag=="1"){
				e.cellStyle="background:#FF6666;";
        	}
     	}
     	if(field == "vcStockAccountSz"){
    		if(record.accountFlag=="1"){
				e.cellStyle="background:#FF6666;";
        	}
     	}
     	if(field == "vcRationProductName"){
    		if(record.nameFlag=="1"){
				e.cellStyle="background:#FF6666;";
        	}
     	}
     	if(field == "seatSz"){
    		if(record.seatFlag=="1"){
				e.cellStyle="background:#FF6666;";
        	}
     	}
     	if(field == "lLockTime"){
    		if(record.lLockFlag=="1"){
				e.cellStyle="background:#FF6666;";
        	}
     	}
     	if(field == "vcPurchaseCode"){
    		if(record.codeFlag=="1"){
				e.cellStyle="background:#FF6666;";
        	}
     	}
     	if(field == "vcStockAccountSh"){
    		if(record.AccountShFlag=="1"){
				e.cellStyle="background:#FF6666;";
        	}
     	}
    });
     
    //合并单元格
    grid.on("load", function () {
        grid.mergeColumns(["rowid"]);
    }); 
    var dataSource = [{ id: 0, text: '<b>本地数据</b>' }, { id: 1, text: 'Excel导入数据'}];
    function ondataSourceRenderer(e) {
        for (var i = 0, l = dataSource.length; i < l; i++) {
            var g = dataSource[i];
            if (g.id == e.value) return g.text;
        }
        return "";
    }
    //隐藏列
	 (function (){
		var vcExchangeNo=nui.get("vcExchangeNo").value;
		grid.hideColumn (3);
		grid.hideColumn (5);
		grid.hideColumn (7);
		grid.hideColumn (9);
		grid.hideColumn (11);
		grid.hideColumn (13);
		grid.hideColumn (15);
		grid.hideColumn (17);
		grid.hideColumn (19);
		grid.hideColumn (21);
		grid.hideColumn (23);
		grid.hideColumn (25);
		grid.hideColumn (27); 
		if(vcExchangeNo=="03"){//03:沪市;04:深市
			grid.hideColumn (2);
			grid.hideColumn (4);
			grid.hideColumn (6);
			grid.hideColumn (8);
			grid.hideColumn (10);
			grid.hideColumn (12);
			grid.hideColumn (14);
		}else{
			grid.hideColumn (16);
			grid.hideColumn (18);
			grid.hideColumn (20);
			grid.hideColumn (22);
			grid.hideColumn (24);
			grid.hideColumn (26);
		} 
	})();
	
</script>
</body>
</html>