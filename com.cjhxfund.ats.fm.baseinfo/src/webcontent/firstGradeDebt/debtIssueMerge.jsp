<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 黄燕
  - Date: 2016-08-31 17:31:57
  - Description:
-->
<head>
<title>一级债信息查重</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    
    
</head>
<body style="width:99.6%;height:99.6%;overflow: hidden; margin: 0px;">
	<div class="search-condition">
		<div class="list">
			<div id="form1" class="nui-form" align="left" style="height: 55px">
				<form id="queryForm" action="">
					<table id="table1" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
						<tr>
							<td  style="width:60px" align="right">去重序号:</td>
							<td colspan="1" align="left" style="width:20%">
								<input class="nui-textbox" id="lProcessInstId" name="map/lProcessInstId"
								width="100%" />
							</td>
							<td  style="width:60px" align="right">债券代码:</td>
							<td colspan="1" align="left" style="width:20%"><input class="nui-textbox"
								id="vcStockCode" name="map/vcStockCode"
								style="width:100%" /></td>
							<td  style="width:60px" align="right">债券简称:</td>
							<td colspan="1" align="left" style="width:20%"><input class="nui-textbox"
								id="vcStockName" name="map/vcStockName"
								style="width:100%" /></td>
						<td style="width:80px" align="left">
					       <a id="query" class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
					                        重置
					       </a>                        
					     </td>
						</tr>
						<tr>
							<td style="width:60px" align="right">
                           	     发起时间:
	                        </td>
	                        <td style="width:20%" align="left">
	                            <input class="nui-datepicker" id="dApplicationTime" format="yyyy-MM-dd" name="map/dApplicationTime" width="100%"/>
	                        </td>
							<td class="form_label" align="right" style="width:60px">审批状态:</td>
							<td colspan="1" align="left" style="width:20%"><input class="nui-combobox"
								id="vcWorkItemName" name="map/vcWorkItemName"
								style="width:100%"
								data="[{id:'提交审核',text:'提交审核'}, {id:'交易员1复核', text: '交易员1复核'}, {id:'交易员2复核', text: '交易员2复核'}]"
								textField="text" valueField="id"
								showClose="true" oncloseclick="onCloseClickValueEmpty"/></td> 
							<td class="form_label" align="right" style="width:60px">债券类别:</td>
							<td colspan="1" align="left" style="width:20%">
							<input style="width: 100%;" id="vcStockType" name="map/vcStockType" class="mini-treeselect"  multiSelect="true" 
									        textField="text" valueField="id" parentField="pid" checkRecursive="false" 
									        emptyText="全部" nullItemText="全部" showFolderCheckBox="false"
									        showFolderCheckBox="true"   expandOnLoad="true" showTreeIcon="false" showClose="true" 
									         oncloseclick="onCloseClickValueEmpty" />
							</td>
							<td style="width:80px">
					       <a id="query" class='nui-button' plain='false' iconCls="icon-search" onclick="search()">
					                        查询
					       </a>                        
					    </td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<div  class="nui-toolbar" style="border-bottom:0;padding:0px">
		<table  style="width:100%;height:20px;">
			<tr>
				<td style="width: 100%;">
				<a class='nui-button' plain='false' iconCls="icon-add" onclick="repeatSet()">自定义去重策略</a> &nbsp; 
				<a class='nui-button' plain='false' iconCls="icon-search" onclick="merge()">发起去重</a>
				</td>
			</tr>
		</table>
	</div>
<div id="layout1" class="mini-layout" style="width:100%; height:87%;"  borderStyle="border:solid 1px #aaa;"> 
<div title="center" region="center"  >
<div class="nui-fit" >
	<div id="datagrid1" class="nui-datagrid"
		onselectionchanged="onSelectionChanged"
		style="width: 100%;height: 100%;"  allowResize="false"
		url="com.cjhxfund.ats.fm.baseinfo.approveInfoManager.queryRepeat.biz.ext"
		 sortField="dApplicationTime" sortOrder="desc" dataField="result" multiSelect="true" onShowRowDetail="onShowRowDetailList" pageSize="20">
		<div property="columns">
			<div type="indexcolumn"></div>
			<div type="expandcolumn"></div>
			<div field="vcUserId" width="80" headerAlign="center"
				allowSort="true">发起人</div>
			<div field="dApplicationTime" width="120" headerAlign="center"
				dateFormat="yyyy-MM-dd HH:mm:ss" allowSort="true" align="right">发起时间</div>
			<div field="vcProcessType" width="80" headerAlign="center"
				renderer="rendererVcProcessType" allowSort="true" visible="false">流程类型</div>
			<div field="vcStockCode" width="80" headerAlign="center"
				allowSort="true">债券代码</div>
			<div field="vcStockName" width="80" headerAlign="center"
				allowSort="true">债券简称</div>
			<div field="vcStockNameFull" width="80" headerAlign="center"
				allowSort="true">债券全称</div>
			<div field="typeName" width="120" headerAlign="center"
				allowSort="false">债券类别</div>
			<div field="vcStockType" headerAlign="center" allowSort="true" visible=false>证券类型编码</div>
			<div field="lInvestNo" width="100" headerAlign="center"  align="right"
				allowSort="true" visible="false">债券编码</div>
			<div field="vcWorkItemName" width="100" headerAlign="center"
				renderer="onWorkItemName" allowSort="true">审批状态</div>
			<div field="vcComments" width="100" headerAlign="center"
				renderer="onComments" allowSort="true">审批意见</div>
			<div field="vcAbstract" width="80" headerAlign="center"
				allowSort="true">摘要</div>
			<div field="lProcessInstId" width="80" headerAlign="center" align="right" allowSort="true">序号</div>
			<!-- <div field="" width="100" headerAlign="center"
				allowSort="true">操作者</div>
				 -->
		</div>
	</div>
</div>
</div>
	<div title="新债查重详细信息" region="south" showSplit="false" showHeader="true" height="250" showSplitIcon="true" >
	<!-- <div id="from2" class="nui-tabs" style="width:100%;height: 100%;border:solid 1px #aaa;position:absolute;_bottom:auto;"
		activeIndex="0">
		<div title=" "> -->
			<div id="datagrid_detail" class="nui-datagrid"
				style="width: 100%; height: 100%;" allowResize="false" 
				url="com.cjhxfund.ats.fm.baseinfo.approveInfoManager.queryMergeDetail.biz.ext"
				sortField="lBizId" dataField="merges" showPager="false">
				<div property="columns">
			    <div type="indexcolumn"></div>
					<!-- <div field="lBizId" width="80" headerAlign="center"
						allowSort="true">流程序号</div>
					<div field="lStockInvestNo" width="80" headerAlign="center"
						allowSort="true" align="right">证券投资编号</div> -->
					<!-- <div field="cStatus" width="105" headerAlign="center" renderer="onCStatus"
						allowSort="true">新债发行数据状态</div> -->
					<div field="vcInterCode" width="80" headerAlign="center"
						allowSort="true" visible="false">债券内码</div>
					<div field="vcStockCode" width="60" headerAlign="center"
						allowSort="true">债券代码</div>
					<div field="vcStockName" width="80" headerAlign="center"
						allowSort="true">债券简称</div>
					<div field="vcStockNameFull" width="200" headerAlign="center"
						allowSort="true">债券全称</div>
					<div field="enExistLimite" width="80" headerAlign="center"
						allowSort="true" align="right">发行期限(年)</div>
					<div field="enIssueBalance" width="80" headerAlign="center"
						allowSort="true" align="right">发行规模(亿)</div>
					<div field="cBondAppraise" width="60" headerAlign="center"  renderer="onBondAppraiseRenderer"
						allowSort="true">债券评级</div>
					<div field="vcBondAppraiseOrgan" width="120" headerAlign="center"  renderer="onBondAppraiseOrganRenderer"
						allowSort="true">债券评级机构</div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid1");
    	nui.get("dApplicationTime").setValue((new Date()));
    	var datagrid_detail = nui.get("datagrid_detail"); 
    	var formData = new nui.Form("#form1").getData(false,false);
		grid.load(formData);
		loadStockTypeAll();
             //加载所有的债券信息
             function loadStockTypeAll(){
             	
             	nui.ajax({
				    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext",
				    type: "post",
				    dataType:"json",
				    success: function (text) {
				    	nui.get("vcStockType").loadList(text.data);
				    }
				});
             	
             }
		/* function onBizProcessRenderer(e){
			if(e.value == '1') return "一级债券申购";
			else if(e.value == '2') return "新债录入";
			else if(e.value == '3') return "新债修改";
			else if(e.value == '4') return "新债查重";
			else if(e.value == '5') return "一级债无债券申购";
		} */
		function onComments(e){
			if(e.value == null) return "复核中";
			else return e.value;
		}
		function onCStatus(e){
			if(e.value == 2) return "正常";
			else if(e.value == 4) return "失效";
			else if(e.value == 3) return "待复核";
		}
		function onWorkItemName(e){
			if(e.value == '复核') return "流程已结束";
			else return e.value;
		}
		function search() {
		    var form = new nui.Form("#form1");
		   	var data = form.getData(); //获取表单JS对象数据
	      	grid.load(data); //datagrid加载数据
	   }
	  function repeatSet(){
	   	 $.ajax({
				url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryDebtIssueMergeSet.biz.ext",
	            type:'POST',
	            data:null,
	            cache:false,
	            contentType:'text/json',
	            success:function(text){
					var data = nui.decode(text);
						nui.open({
						  url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueMergeSet.jsp",
						                title: "自定义去重策略", width: 500, height: 360,
						  onload: function () {
						    var  iframe = this.getIFrameEl();
						    iframe.contentWindow.SetData(data);
						  },
						  ondestroy: function (action) {
						    grid.reload();
						  }
						});
				}    
			});
	   }
	   function merge(){
	   		
			nui.open({
						  url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueMergeOperate.jsp",title: "请选择可能重复的债券", width: 900, height: 550,
						  onload: function () {
						    //var  iframe = this.getIFrameEl();
						    //iframe.contentWindow.SetData(data);
						  },
						  ondestroy: function (action) {
						    grid.reload();
						  }
						});
	   }
	   function onSelectionChanged(e) {
            var record = grid.getSelected();
	   		var data2={"lBizId":record.lProcessInstId};  
            if (record) {
                datagrid_detail.load(data2);
            }
        }
        //流程类型
	/* function rendererVcProcessType(e){
		var processType = e.row.VC_PROCESS_TYPE;
		if(processType == undefined){
			return nui.getDictText("ATS_PROCESS_TYPE",e.row.vcProcessType);
		}else{
			return nui.getDictText("ATS_PROCESS_TYPE",e.row.VC_PROCESS_TYPE);
		}
	} */
	function reset(){
		var form = new nui.Form("#form1");//将普通form转为nui的form
		form.reset();
	}
  function onBondAppraiseRenderer(e){
    	return nui.getDictText("creditRating",e.row.cBondAppraise);
    }
    
     //债券评级机构
    function onBondAppraiseOrganRenderer(e){
    	return nui.getDictText("outRatingOrgan",e.row.vcBondAppraiseOrgan);
    }
        //展示详细行数据
	function onShowRowDetailList(e) {
	    
		var grid = e.sender;//获取表格
	    var row = e.record;//获取行数据
	    var remark = null;
	    var ProcessInstId = row.lProcessInstId;
	    //判断待办中传过来的流程ID是否为空
	    if(ProcessInstId == undefined){
	    	ProcessInstId = row.lBizId;
	    }

	    //获取债券信息
	    var processIdJson = nui.encode({processInstId : ProcessInstId});
	    $.ajax({
            url:"com.cjhxfund.foundation.task.pendingTreatment.queryTAtsApproveInfo.biz.ext",
            type:'POST',
            data:processIdJson,
            cache: false,
            contentType:'text/json',
            success:function(text){
                var returnJson = nui.decode(text);
                if(returnJson.exception == null){
                    var bonds = returnJson.TAsApproveInfos;
                    var html = "<table border='0'  style='width:100%;'>";
					if(remark!=null && remark!=""){
						html +=" <tr>"
							 + "  <td style='width:150px;font-weight:bold;vertical-align:top;' align='right'>备注信息：</td>"
							 + "  <td>" + remark + "</td>"
							 + " </tr>";
					}
					if(returnJson.nextActor!=null && returnJson.nextActor!=""){
						html +=" <tr>"
							 + "  <td style='width:150px;font-weight:bold;vertical-align:top;' align='right'>当前节点参与者：</td>"
							 + "  <td>" + returnJson.nextActor + "</td>"
							 + " </tr>";
					}
					html += "</table>";
                    
					var bondStr = html + "</table>";
					    bondStr += "<table>"
                    			+" <tr>"
                    			+"  <td style='width:150px;font-weight:bold;' align='center'>审批时间</td>"
                    			+"  <td style='width:220px;font-weight:bold;' align='center'>节点名称</td>"
                    			+"  <td style='width:120px;font-weight:bold;' align='center'>操作者</td>"
                    			+"  <td style='width:120px;font-weight:bold;' align='center'>操作</td>"
                    			+"  <td style='width:200px;font-weight:bold;' align='center'>操作意见</td>"
                    			+" </tr>";
                    var vcOperateType = "同意";			
                    for(var i=0; i<bonds.length; i++){
                    	var bondInfo = bonds[i];
                    	  if(bondInfo.vcOperateType == 1){
                    		  vcOperateType = "同意";
					      }
					      if(bondInfo.vcOperateType == 2){
					    	  vcOperateType = "退办";
					      }
					      if(bondInfo.vcOperateType == 3){
					    	  vcOperateType = "转办";
					      }
					      if(bondInfo.vcOperateType == 4){
					    	  vcOperateType = "征求意见";
					      }
					      if(bondInfo.vcOperateType == 5){
					    	  vcOperateType = "否决";
					      }
					      if(bondInfo.vcOperateType == 99){
					    	  vcOperateType = "不同意";
					      }
					      
					      if(bondInfo.vcOperateType == 98){
					    	  vcOperateType = "修改";
					      }
					      if(bondInfo.vcOperateType == 97){
					    	  vcOperateType = "废弃";
					      }
					      
                    	bondStr += "<tr><td align='center'>"+ nui.formatDate(bondInfo.dCreateTime, "yyyy-MM-dd HH:mm:ss")+"</td><td align='center'>"+changeNull(bondInfo.vcWorkItemName)+"</td><td align='center'>"+changeNull(bondInfo.vcUserName)
                    			+	"</td><td align='center'>"+changeNull(vcOperateType)+"</td><td align='center'>"+changeNull(bondInfo.vcComments)+"</td></tr>";
                    }
                    bondStr += "</table>";
                    
                    var td = grid.getRowDetailCellEl(row);

					td.innerHTML = bondStr;
                    
                }else{
					nui.alert("加载失败", "系统提示");
                }
            }
         });
	}
    </script>
</body>
</html>