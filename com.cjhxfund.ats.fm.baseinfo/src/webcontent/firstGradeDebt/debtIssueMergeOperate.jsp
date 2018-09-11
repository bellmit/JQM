<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 黄燕
  - Date: 2016-09-01 17:28:47
  - Description:
-->
<head>
<title>去重</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="width:100%;height:100%;overflow: hidden; margin: 0px;">
	<div id="tabs" class="nui-tabs" height="100%" style="overflow: hidden;border-left: 0xp;">
	<div title="汇总去重信息">
		<div  class="nui-toolbar" style="border-bottom: 1; padding: 0px;height:30px">
	        <table style="width: 100%;" >
	            <tr>
	                <td class="form_label" align="left">
	                <a class='nui-button' plain='false' iconCls="icon-add"  onclick="search(1)">自定义去重策略</a>
				    <a class='nui-button' plain='false' iconCls="icon-reload"  onclick="refreshTable()">刷新</a>
				    <a class='nui-button' plain='false' id="compare" iconCls='icon-search' onclick='compare(1)'>新债信息对比</a>
	                </td>
	                <td><span style="display:inline-block;width:1px;"></span></td>
	           </tr>
	        </table>
    	</div>
		<div id="datagrid1" class="nui-datagrid" style="width:100%;height:50%" url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryStockIssueInfo.biz.ext" 
		allowResize="false" dataField="stocks" virtualScroll="true" onselectionchanged="onSelectionChanged" showPager="true" pageSize="20" multiSelect="true" sortField="lStockIssueId" sortOrder="desc">
			<div property="columns">
				<div type="indexcolumn"></div>
				<div field="VC_ISSUER_NAME_FULL" name="vcIssuerNameFullField" width="100" headerAlign="center" visible="true" allowSort="true">发行主体</div>
				<div field="VC_STOCK_NAME_FULL" name="vcStockNameFullField" width="100" headerAlign="center" visible="false"  allowSort="true">债券全称</div>
				<div field="VC_STOCK_NAME" width="100" name="vcStockNameField" headerAlign="center" visible="false"  allowSort="true">债券简称</div>
				<div field="EN_EXIST_LIMITE" width="80" name="limiteField" headerAlign="center" visible="false"  align="right" allowSort="true">发行期限(年)</div>
				<div field="EN_ISSUE_BALANCE" width="80" name="balanceField" headerAlign="center" visible="false"  align="right" allowSort="true">发行规模(亿)</div>
				<div field="L_ISSUE_BEGIN_DATE" width="90" name="dateField" headerAlign="center" visible="false"  align="right" renderer="lIssueBeginDateRen" allowSort="true">发行日期</div>
				<div field="C_ISSUE_APPRAISE" width="60" name="cIssueAppraiseField" headerAlign="center" visible="false"  allowSort="true" renderer="creditRatingRen">主体评级</div>
				<div field="VC_ISSUE_PROPERTY" width="100" name="vcissuePropertyField" headerAlign="center" visible="false"  allowSort="true"  renderer="issuePropertyRen">主体类型</div>				
				<div field="VC_PAYMENT_PLACE" width="100" name="vcPaymentPalceField" headerAlign="center" visible="false"  allowSort="true" renderer="vcPaymentPlaceRen">登记托管所</div>
				<div field="C_MARKET_NO" width="80"  headerAlign="center" renderer="cMarketNoRen" allowSort="true" >交易市场</div>
				<div field="COUNTNUM" width="50" align="right"headerAlign="center" allowSort="true" >条数</div>
			</div>
		</div>
		
		
		<div id="datagrid2" class="nui-datagrid" style="width:100%;height:36.5%" url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryStockIssueInfo.biz.ext?type=2" 
	allowResize="false" dataField="stocks" virtualScroll="true" showPager="false" allowUnselect="true" multiSelect="true" sortField="lStockIssueId" sortOrder="desc">
			<div property="columns">
				<div type="indexcolumn"></div>
				<div type="checkcolumn"></div>
				<div field="lStockInvestNo" width="60" headerAlign="center" align="right" visible="false"></div>
				<div field="vcPaymentPlace" width="100" headerAlign="center" allowSort="true" renderer="vcPaymentPlaceRenderer">登记托管所</div>
				<div field="vcStockCode" width="100" headerAlign="center" allowSort="true">债券代码</div>
				<div field="vcStockName" width="100" headerAlign="center" allowSort="true">债券简称</div>
				<div field="vcStockNameFull" width="100" headerAlign="center" allowSort="true">债券全称</div>
				<div field="vcStockType" width="60" headerAlign="center" allowSort="true"  visible=false>债券类别</div>
				<div field="vcStockTypeName" width="100" headerAlign="center" allowSort="true">债券类别</div>
				<div field="cMarketNo" headerAlign="center" allowSort="true" visible=false>交易市场</div>
				<div field="vcMarketName" headerAlign="center" allowSort="true" visible=false>交易市场编码</div>
				<div field="enExistLimite" width="80" headerAlign="center" align="right" allowSort="true">发行期限(年)</div>
				<div field="enIssueBalance" width="80" headerAlign="center" align="right" allowSort="true">发行规模(亿)</div>
				<div field="vcIssuerNameFull" width="100" headerAlign="center" allowSort="true">发行主体</div>
				<div field="cIssueAppraise" width="60" headerAlign="center" allowSort="true" renderer="creditRatingRenderer">主体评级</div>
				<div field="vcIssueProperty" width="100" headerAlign="center" allowSort="true"  renderer="issuePropertyRenderer">主体类型</div>
				<div field="lIssueBeginDate" width="90" headerAlign="center" align="right" renderer="lIssueBeginDateRenderer" allowSort="true">发行日期</div>
				<div field="lStockIssueId" width="60" headerAlign="center" align="right" allowSort="true">序号</div>
			</div>
		</div>
		<div id="form" class="nui-toolbar" align="center" style="height:5%" >
        <form id="submitForm" action="">
        <table id="table1" class="table" style="width: 100%;" border="0">
            <tr>
	            <td align="center">
	            <a class='nui-button' plain='false' iconCls="icon-save"  onclick="submit(1)">去重</a>
	            <span style="display:inline-block;width:25px;"></span>
	            <a class='nui-button' plain='false' iconCls="icon-cancel"  onclick="onCancel()">取消</a>
			    </td>
           </tr>
        </table>
       </form>
    </div>
	</div>
	<div title="排列去重明细信息">
	<div class="search-condition">
		<div class="list">
			<div id="form1" class="nui-form" align="left" style="height: 55px">
				<form id="queryForm" action="">
					<table id="table1" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
						<tr>
							<td  style="width:70px" align="right">发行主体:</td>
							<td colspan="1" align="left" style="width:25%">
								<input class="nui-textbox" id="vcIssuerNameFull" name="paramMap/vcIssuerNameFull"
								width="100%" />
								<input class="nui-hidden" id="cMarketNo" name="paramMap/cMarketNo" width="100%" />
								<input class="nui-hidden" id="enExistLimite" name="paramMap/enExistLimite" width="100%" />
								<input class="nui-hidden" id="enIssueBalance" name="paramMap/enIssueBalance" width="100%" />
								<input class="nui-hidden" id="lIssueBeginDate" name="paramMap/lIssueBeginDate" width="100%" />
								<input class="nui-hidden" id="cIssueAppraise" name="paramMap/cIssueAppraise" width="100%" />
								<input class="nui-hidden" id="vcIssueProperty" name="paramMap/vcIssueProperty" width="100%" />
							</td>
							<td  style="width:60px" align="right">债券代码:</td>
							<td colspan="1" align="left" style="width:25%"><input class="nui-textbox"
								id="vcStockCode" name="paramMap/vcStockCode"
								style="width:100%" /></td>
							<td  style="width:60px" align="right">债券简称:</td>
							<td colspan="1" align="left" style="width:25%"><input class="nui-textbox"
								id="vcStockName" name="paramMap/vcStockName"
								style="width:100%" /></td><td></td>
						</tr>
						<tr>
							<td class="form_label" align="right">登记托管所:</td>
							<td colspan="1" align="left" style="width:25%"><input class="nui-dictcombobox"
								dictTypeId="CF_JY_DJTGCS" valueField="dictID" textField="dictName"
					                        name="paramMap/vcPaymentPlace" showClose="true" oncloseclick="onCloseClickValueEmpty" 
					                         id="vcPaymentPlace"  width="100%"/></td> 
							<td class="form_label" align="right">债券类别:</td>
							<td colspan="1" align="left" style="width:25%">
							<input style="width: 100%;" id="vcStockType" name="paramMap/vcStockType" class="mini-treeselect"  multiSelect="true" 
									        textField="text" valueField="id" parentField="pid" checkRecursive="false" 
									        emptyText="全部" nullItemText="全部" showFolderCheckBox="false"
									        showFolderCheckBox="true"   expandOnLoad="true" showTreeIcon="false" showClose="true" 
									         oncloseclick="onCloseClickValueEmpty" />
							</td> 
							<td>
								<td>
									<div property="footer">
							            <a class='nui-button' plain='false' iconCls="icon-search"  onclick="searchData()">
							                	查询
							            </a>
							            <span>&nbsp;</span>
							            <a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
							                	重置
							            </a>
							        </div>
							   </td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<div  class="nui-toolbar" style="border-bottom: 1; padding: 0px;height:30px">
        <table style="width: 100%;" >
            <tr>
                <td class="form_label" align="left">
                <a class='nui-button' plain='false' iconCls="icon-add"  onclick="search()">自定义去重策略</a>
			    <a class='nui-button' plain='false' iconCls="icon-reload"  onclick="refresh()">刷新</a>
                <a class='nui-button' plain='false' id="compare" iconCls='icon-search' onclick='compare()'>新债信息对比</a>
                </td>
                <td><span style="display:inline-block;width:1px;"></span></td>
           </tr>
        </table>
    </div>
	<div id="datagrid" class="nui-datagrid" style="width:100%;height:72.5%" url="com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryStockIssueInfo.biz.ext?type=2" 
	allowResize="false" dataField="stocks" virtualScroll="true" showPager="false" allowUnselect="true" multiSelect="true"  sortField="lStockIssueId" sortOrder="desc">
		<div property="columns">
			<div type="indexcolumn"></div>
			<div type="checkcolumn"></div>
			<div field="lStockInvestNo" width="60" headerAlign="center" align="right" visible="false"></div>
			<div field="vcPaymentPlace" width="100" headerAlign="center" allowSort="true" renderer="vcPaymentPlaceRenderer">登记托管所</div>
			<div field="vcStockCode" width="100" headerAlign="center" allowSort="true">债券代码</div>
			<div field="vcStockName" width="100" headerAlign="center" allowSort="true">债券简称</div>
			<div field="vcStockNameFull" width="100" headerAlign="center" allowSort="true">债券全称</div>
			<div field="vcStockType" width="60" headerAlign="center" allowSort="true"  visible=false>债券类别</div>
			<div field="vcStockTypeName" width="100" headerAlign="center" allowSort="true">债券类别</div>
			<div field="cMarketNo" headerAlign="center" allowSort="true" visible=false>交易市场</div>
			<div field="vcMarketName" headerAlign="center" allowSort="true" visible=false>交易市场编码</div>
			<div field="enExistLimite" width="80" headerAlign="center" align="right" allowSort="true">发行期限(年)</div>
			<div field="enIssueBalance" width="80" headerAlign="center" align="right" allowSort="true">发行规模(亿)</div>
			<div field="vcIssuerNameFull" width="100" headerAlign="center" allowSort="true">发行主体</div>
			<div field="cIssueAppraise" width="60" headerAlign="center" allowSort="true" renderer="creditRatingRenderer">主体评级</div>
			<div field="vcIssueProperty" width="100" headerAlign="center" allowSort="true"  renderer="issuePropertyRenderer">主体类型</div>
			<div field="lIssueBeginDate" width="90" headerAlign="center" align="right" renderer="lIssueBeginDateRenderer" allowSort="true">发行日期</div>
			<div field="lStockIssueId" width="60" headerAlign="center" align="right" allowSort="true">序号</div>
		</div>
	</div>
	<div id="form2" class="nui-toolbar" align="center" style="height:25px" >
        <form id="submitForm" action="">
        <table id="table1" class="table" style="width: 100%;" border="0">
            <tr>
                <td align="center">
	            <a class='nui-button' plain='false' iconCls="icon-save"  onclick="submit()">去重</a>
	            <span style="display:inline-block;width:25px;"></span>
	            <a class='nui-button' plain='false' iconCls="icon-cancel"  onclick="onCancel()">取消</a>
			    </td>
           </tr>
        </table>
       </form>
    </div>
    </div>
    </div>
    <form action="" id="openForm" name="openForm" method="post" target="_blank">
			<input class="nui-textbox" id="vcIssuerNameFullHid" name="paramMap/vcIssuerNameFull" width="100%" />
			<input class="nui-hidden" id="cMarketNoHid" name="paramMap/cMarketNo" width="100%" />
			<input class="nui-hidden" id="enExistLimiteHid" name="paramMap/enExistLimite" width="100%" />
			<input class="nui-hidden" id="enIssueBalanceHid" name="paramMap/enIssueBalance" width="100%" />
			<input class="nui-hidden" id="lIssueBeginDateHid" name="paramMap/lIssueBeginDate" width="100%" />
			<input class="nui-hidden" id="cIssueAppraiseHid" name="paramMap/cIssueAppraise" width="100%" />
			<input class="nui-hidden" id="vcIssuePropertyHid" name="paramMap/vcIssueProperty" width="100%" />
			<input style="width: 100%;" id="vcStockTypeHid" name="paramMap/vcStockType" />
			<input class="nui-hidden"  name="paramMap/vcPaymentPlace" id="vcPaymentPlaceHid"/>
			<input class="nui-textbox" id="vcStockNameHid" name="paramMap/vcStockName"/>
		</form>
	<script type="text/javascript">
    	nui.parse();
    	var grid1 = nui.get("datagrid1");
    	grid1.load();
    	var grid2 = nui.get("datagrid2");
    	init();
    	function init(){
    		$.ajax({
				url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryUserParamConf.biz.ext",
	            type:'POST',
	            data:null,
	            cache:false,
	            contentType:'text/json',
	            success:function(text){
					var data = nui.decode(text);
					var paramConf = data.map;
					//document .getElementById("tableHead").style.display = "none";
					if(paramConf.vc_issuer_name_full!=undefined){
						grid1.showColumn("vcIssuerNameFullField");
					}else{
						grid1.hideColumn("vcIssuerNameFullField");
					}
					if(paramConf.vc_stock_name_full!=undefined){
						grid1.showColumn("vcStockNameFullField");
					}else{
						grid1.hideColumn("vcStockNameFullField");
					}
					if(paramConf.en_exist_limite!=undefined){
						grid1.showColumn("limiteField");
					}else{
						grid1.hideColumn("limiteField");
					}
					if(paramConf.en_issue_balance!=undefined){
						grid1.showColumn("balanceField");
					}else{
						grid1.hideColumn("balanceField");
					}
					if(paramConf.l_issue_begin_date!=undefined){
						grid1.showColumn("dateField");
					}else{
						grid1.hideColumn("dateField");
					}
					if(paramConf.c_issue_appraise!=undefined){
						 grid1.showColumn("cIssueAppraiseField");
					}else{
						grid1.hideColumn("cIssueAppraiseField");
					}
					if(paramConf.vc_issue_property!=undefined){
						grid1.showColumn("vcissuePropertyField");
					}else{
						grid1.hideColumn("vcissuePropertyField");
					}
					if(paramConf.vc_payment_place!=undefined){
						grid1.showColumn("vcPaymentPalceField");
					}else{
						grid1.hideColumn("vcPaymentPalceField");
					}
					if(paramConf.vc_stock_name!=undefined){
						grid1.showColumn("vcStockNameField");
					}else{
						grid1.hideColumn("vcStockNameField");
					}
				}    
			});
    	}
    	
    	var grid = nui.get("datagrid");
		grid.load(); 
		
		//刷新缓存
		function  refresh(){
			grid.load();
		}
		function  refreshTable(){
			grid1.load();
			onSelectionChanged();
		}
		
		//选中行时查询明细信息
		function onSelectionChanged(e) {
            var record = grid1.getSelected();
            if (record) {
	            if(record.VC_ISSUER_NAME_FULL!=undefined){
					nui.get("vcIssuerNameFullHid").setValue(record.VC_ISSUER_NAME_FULL);
				}
				if(record.VC_STOCK_NAME!=undefined){
					nui.get("vcStockNameHid").setValue(record.VC_STOCK_NAME);
				}
				if(record.VC_STOCK_NAME_FULL!=undefined){
					nui.get("vcStockNameHid").setValue(record.VC_STOCK_NAME_FULL);
				}
				if(record.EN_EXIST_LIMITE!=undefined){
					nui.get("enExistLimiteHid").setValue(record.EN_EXIST_LIMITE);
				}
				if(record.EN_ISSUE_BALANCE!=undefined){
					nui.get("enIssueBalanceHid").setValue(record.EN_ISSUE_BALANCE)
				}
				if(record.L_ISSUE_BEGIN_DATE!=undefined){
					nui.get("lIssueBeginDateHid").setValue(record.L_ISSUE_BEGIN_DATE);
				}
				if(record.C_ISSUE_APPRAISE!=undefined && record.C_ISSUE_APPRAISE!=null){
					nui.get("cIssueAppraiseHid").setValue(record.C_ISSUE_APPRAISE);
				}
				if(record.VC_ISSUE_PROPERTY!=undefined){
					nui.get("vcIssuePropertyHid").setValue(record.VC_ISSUE_PROPERTY);
				}
				if(record.VC_PAYMENT_PLACE!=undefined){
					nui.get("vcPaymentPlaceHid").setValue(record.VC_PAYMENT_PLACE);
				}
				
	            nui.get("cMarketNoHid").setValue(record.C_MARKET_NO);
		   		var openForm = new nui.Form("#openForm");
		   		var data = openForm.getData(); //获取表单JS对象数据
		      	grid2.load(data);
            }
        }
        
		function search(type){
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
						                title: "去重策略设置", width: 500, height: 360,
						  onload: function () {
						    var  iframe = this.getIFrameEl();
						    iframe.contentWindow.SetData(data);
						  },
						  ondestroy: function (action) {
						    if(type==1){
						    	init();
						    	grid1.reload();
						    	//grid2.reset();
						    }else{
						    	grid.reload();
						    }
						    
						  }
						});
				}    
			});
		}
		
    	function onCancel(){
			//查询是否有附件，有，则删除
			window.CloseOwnerWindow();
	   	}
		function submit(type){
			
			var rows = grid.getSelecteds();
			if(type==1){//在汇总去重页面点击去重按钮
				rows = grid2.getSelecteds();
			}
			if(rows.length<2){
				nui.alert("请选择大于一条数据记录！");
			}else{
				nui.open({
				  url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueMergeChoose.jsp",
				                title: "选择目标债券", width: 400, height: 210,
				  onload: function () {
				    var  iframe = this.getIFrameEl();
				    iframe.contentWindow.SetData(rows);
				  },
				  ondestroy: function (action) {
				  	if(action=="checked"){
				  		grid.reload();
				  	}else if(action=="checkedNo"){
				  		window.CloseOwnerWindow();
				  	}
				  }
				});
			}
		}
		function creditRatingRen(e){
        	var cIssueApp = e.row.C_ISSUE_APPRAISE;
        	return nui.getDictText("issuerRating",cIssueApp);
        }
        function issuePropertyRen(e){
        	var vcIssuePro = e.row.VC_ISSUE_PROPERTY;
        	return nui.getDictText("ATS_FM_ISSUE_PROPERTY",vcIssuePro);
        }
        function vcPaymentPlaceRen(e){
        	var payMent = e.row.VC_PAYMENT_PLACE;
        	return nui.getDictText("CF_JY_DJTGCS",payMent);
        }
        function cMarketNoRen(e){
        	var cMar = e.row.C_MARKET_NO;
        	if(cMar=="1"){
        		return "上交所";
        	}else if(cMar=="2"){
        		return "深交所";
        	}else if(cMar=="5"){
        		return "银行间";
        	}else{
        		return "场外";
        	}
        }
        function lIssueBeginDateRen(e){
        	var date = e.row.L_ISSUE_BEGIN_DATE;
        	if(date.length==8){
        		return date.substring(0,4)+"-"+date.substring(4,6)+"-"+date.substring(6,8);
        	}else{
        		return 0;
        	}  
        }
        function creditRatingRenderer(e){
        	return nui.getDictText("issuerRating",e.row.cIssueAppraise);
        }
        function issuePropertyRenderer(e){
        	return nui.getDictText("ATS_FM_ISSUE_PROPERTY",e.row.vcIssueProperty);
        }
        function vcPaymentPlaceRenderer(e){
        	return nui.getDictText("CF_JY_DJTGCS",e.row.vcPaymentPlace);
        }
        
        function lIssueBeginDateRenderer(e){
        	var date = e.row.lIssueBeginDate;
        	if(date.length==8){
        		return date.substring(0,4)+"-"+date.substring(4,6)+"-"+date.substring(6,8);
        	}
        }
        //新债信息对比
    		function compare(type){
    			 var rows = grid.getSelecteds();
    			 if(type==1){
    			 	rows = grid2.getSelecteds();
    			 }
    			 var lStockIssueId="";
    			 if(rows.length>=2){ 
    			    //var data = {rowData:rows};com.cjhxfund.ats.fm.instr.FirstGradeDebtCompare.flow
    			    lStockIssueId= ""+rows[0].lStockIssueId+","+rows[1].lStockIssueId;
	        		window.open("<%=request.getContextPath() %>/fm/instr/firstGradeDebt/compareStockIssueInfo.jsp?lStockIssueId="+lStockIssueId);
    			 }else if(rows.length==1){
    			 	lStockIssueId= rows[0].lStockIssueId;
    			 	window.open("<%=request.getContextPath() %>/fm/instr/firstGradeDebt/compareStockIssueInfo.jsp?lStockIssueId="+lStockIssueId);
    			}else{
    				window.open("<%=request.getContextPath() %>/fm/instr/firstGradeDebt/compareStockIssueInfo.jsp?lStockIssueId="+lStockIssueId);
    			}
    		}
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
     function reset(){
		var form = new nui.Form("#form1");//将普通form转为nui的form
		form.reset();
	}
	function reloadData(){
		grid.reload();
		refreshTable();
	}
	function searchData() {
		    var form = new nui.Form("#form1");
		   	var data = form.getData(); //获取表单JS对象数据
	      	grid.load(data); //datagrid加载数据
	   }
    </script>
</body>
</html>