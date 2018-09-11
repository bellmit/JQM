<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp"%>
<!--
  - Author(s): 创金合信
  - Date: 2016-09-08 09:29:14
  - Description:
-->
<head>
<title>锁定券维护</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script type="text/javascript"
	src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
</head>
<body>
	<div style="width: 100%;">
		<div class="mini-toolbar" style="border-bottom: 0; paddingleft: 5px;">
			<form id="searchCondi">
				<table style="width: 100%;">
					<tr>
						<td style="width:25%">产品名称:
							<div name="vcProductCode" class="nui-combobox" pinyinField="vcProductCode" id="vcProductCode"
                            	textField="vcProductName" valueField="vcProductCode"
								url="com.cjhxfund.ats.sm.comm.TBondLockInfoManager.queryProductHandleByRealTypes.biz.ext?realType='01','02','04'"
								showNullItem="false"
								allowInput="true" 
								emptyText="请输入产品代码或产品名称..."
								nullItemText="请输入产品代码或产品名称..."
								valueFromSelect="true"
								showClose="true"
								onvaluechanged="selectFund" 
								style="width:68%"
								oncloseclick="onCloseClick"
								popupWidth="300">
								<div property="columns">
	                                <div header="产品代码" field="vcProductCode" width="40px"></div>
	                                <div header="产品名称" field="vcProductName"></div>
	                            </div>
                            </div>
						</td>
						<td style="width:25%">组合名称:
			                <input name="vcCombiCode" class="nui-combobox" id="vcCombiCode"
								textField="TEXT" valueField="ID" dataField="data"
								url="com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfo.biz.ext"
								showNullItem="false" allowInput="false"
								onvaluechanged="selectT0" emptyText="全部" nullItemText="请选择"
								showClose="true" oncloseclick="onCloseClick" style="width:68%"
								valueFromSelect="true"/>
		                </td>
		                <td>交易市场 :<input
							class="nui-dictcombobox" id="vcMarket" name="vcMarket"
							valueField="dictID" textField="dictName" dictTypeId="tradePlace"
							emptyText="全部" showClose="true" 
							oncloseclick="onCloseClick" 
							onvaluechanged='clearStockCode'
							valueFromSelect="true"
							style="width:68%" />
						</td>
		                <td style="width:25%">债券代码:
			                <div name="vcStockCode" class="nui-autocomplete"
								popupEmptyText="请选择"
								id="vcStockCode" 
								textField="stockCode" 
								valueField="stockCode"
								searchField="stockCode"
								url="com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.queryTbondCodeList.biz.ext"
								showNullItem="false" 
								allowInput="true" 
								emptyText="请选择"
								nullItemText="请选择" 
								valueFromSelect="true" 
								dataField="bondList"
								multiSelect="false" 
								showClose="true" 
								style="width:68%"
								oncloseclick="onCloseClick" 
								onvaluechanged='selectT0'
								onvalidation="O32ExistCheck"
								popupWidth="300" 
								onBeforeLoad="getStockCode">
								<div property="columns">
									<div header="债券代码" field="stockCode" width="40px"></div>
									<div header="债券名称" field="stockName"></div>
								</div>
								
								<div name="vcStockCode" class="nui-autocomplete" id="vcStockCode"
	                                 textField="stockCode" valueField="stockCode"
	                                 searchField="stockCode"
	                                 url="com.cjhxfund.ats.sm.comm.TBondBaseInfoManager.queryBankBetweenBondCode.biz.ext"
	                                 allowInput="true"
	                                 emptyText="请选择..."
	                                 nullItemText="请选择..."
	                                 valueFromSelect="false"
	                                 dataField="bondList"
	                                 multiSelect="false"
	                                 style="width:95%;"
	                                 popupWidth="300">
	                           		<div property="columns">
	                                    <div header="债券代码" field="stockCode" width="40px"></div>
	                                    <div header="债券名称" field="stockName"></div>
                                	</div>
                    		</div>
							</div>
		                </td>
					</tr>
					<tr>
		                <td>
							<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="queryLockBond()" /> 
							<a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">重置</a>
							<a class="nui-menubutton " plain="false" menu="#popupMenu" id="searchCond" name="searchCond" data-options='{formId:"searchCondi"}' iconCls="icon-add">保存查询条件 </a>
							<ul id="popupMenu" class="mini-menu" style="display: none; width: 250px;"></ul> 
		                </td>
					</tr>
				</table>
			</form>
		</div>
	</div>

	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;"><a class="mini-button"
					iconCls="icon-add" onclick="add()">添加锁定券</a></td>
			</tr>
		</table>
	</div>

	<div id="lockBondGrid" class="mini-datagrid" showReloadButton="false"
		style="width: 100%; height: 300px;"
		url="com.cjhxfund.ats.sm.comm.TBondLockInfoManager.queryBondLock.biz.ext"
		idField="lLockId" allowResize="true" dataField="bondLockList"
		sizeList="[10,20,30]" pageSize="10" frozenStartColumn="0"
		frozenEndColumn="6" onselectionchanged="selectionChanged"
		pagerButtons="#query_lockStatus">
		<div property="columns">
			<div name="action" width="80" align="center" headerAlign="center"
				align="center" renderer="onActionRenderer">操作</div>
			<div field=lLockId width="80" align="center" headerAlign="center">锁定编号</div>
			<div field="vcProductCode" width="80" align="center"
				headerAlign="center">产品代码</div>
			<div field="vcProductName" width="170" align="center"
				headerAlign="center">产品名称</div>
			<div field="vcCombiName" width="110" align="center"
				headerAlign="center">组合名称</div>
			<div field="vcStockCode" width="100" align="center"
				headerAlign="center">债券代码</div>
			<div field="vcStockName" width="120" align="center"
				headerAlign="center">债券名称</div>
			<div field="vcMarket" width="120" align="center"
				headerAlign="center" renderer="renderMarket">交易市场</div>
			<div field="lLockQtyFirst" width="120" align="center"
				headerAlign="center" numberFormat="n0">首次锁定数量</div>
			<div field="lLockQty" width="120" align="center" numberFormat="n0"
				headerAlign="center">当前锁定数量</div>
			<div field="operableUnLockQty" width="120" align="center" numberFormat="n0"
				headerAlign="center">可解锁数量</div>
			<div field="vcLockType" width="120" align="center"
				headerAlign="center" renderer="renderLockType">锁定类型</div>
			<div field="vcLockStatus" width="120" align="center"
				headerAlign="center" renderer="renderLockStatus">锁定状态</div>
			<div field="vcLockReason" width="120" align="center"
				headerAlign="center">锁定原因</div>
			<div field="tLockTime" width="120" align="center"
				headerAlign="center" renderer="dateRen">锁定时间</div>
			<div field="vcOperatorName" width="120" align="center"
				headerAlign="center">锁定人</div>
			<div field="lMaturitySettleDate" width="120" align="center"
				headerAlign="center">锁定到期日</div>
			<div field="lInstructNo" width="120" align="center"
				headerAlign="center">指令/建议序号</div>
		</div>
		<div id="query_lockStatus">
			<div id="lockStatus" name="searchData/lockStatus"
				style="margin-left: 50px;" false" class="nui-checkbox"
				onclick="queryLockBond()" readOnly="false" text="显示已解锁记录"></div>
			<div id="InvalidStatus" name="searchData/InvalidStatus"
				style="margin-left: 50px;" false" class="nui-checkbox"
				onclick="queryLockBond()" readOnly="false" text="显示无效记录"></div>
			<!--<div id="toUnLock" name="searchData/toUnLock"
				style="margin-left: 50px;" false" class="nui-checkbox"
				onclick="queryLockBond()" readOnly="false" text="显示待锁定记录"></div>-->
		</div>
	</div>

	<!-- 日志Grid -->
	<div class="nui-tabs"
		style="width: 100%; height: auto; overflow-x: auto;" activeIndex="0">
		<div title="锁定券解锁记录">
			<div id="lockBondLogGrid" class="mini-datagrid"
				showReloadButton="false" style="width: 100%; height: 300px;"
				url="com.cjhxfund.ats.sm.comm.TBondLockInfoManager.queryBondUnLockRcd.biz.ext"
				idField="lLockId" allowResize="true" showPager="false"
				dataField="bondUnlockRcdList">
				<div property="columns">
					<div field="lUnlockId" align="center" headerAlign="center">解锁编号</div>
					<div field="lLockId" align="center" headerAlign="center">锁定编号</div>
					<div field="lUnlockQty" align="center" headerAlign="center"
						numberFormat="n0">解锁数量</div>
					<div field="vcUnlockType" align="center" headerAlign="center"
						renderer="renderUnLockType">解锁类型</div>
					<!--<div field="lOperatorId" align="center" headerAlign="center">解锁人用户名</div>-->
					<div field="vcOperatorName" align="center" headerAlign="center">解锁人姓名</div>
					<div field="tApplyUnlockTime" align="center" headerAlign="center"
						renderer="dateRen">申请解锁时间</div>
					<div field="vcApprovalStatus" align="center" headerAlign="center"
						renderer="renderUnlockApproveStatus">审批状态</div>
					<div field="vcApprovalUsername" align="center" headerAlign="center">审批人姓名</div>
					<div field="vcApprovalOpinion" align="center" headerAlign="center">审批意见</div>
					<div field="tUnLockTime" align="center" headerAlign="center"
						renderer="dateRen">解锁时间</div>
					<div field="vcUnlockReason" align="center" headerAlign="center">解锁原因</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript"
		src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script>
	<script type="text/javascript">
		nui.parse();
		// 锁定状态
		var lockBondGrid = nui.get("lockBondGrid");
		var searchCondiForm = new nui.Form("searchCondi");
		var searchData = searchCondiForm.getData();
		if (nui.get("lockStatus").checked) {
			searchData["lockStatus"] = "";
		} else {
			searchData["lockStatus"] = "1,2";
		}
		// 是否有效（1有效，0无效）
		if (nui.get("InvalidStatus").checked) {
			searchData["InvalidStatus"] = "";
		} else {
			searchData["InvalidStatus"] = "1";
		}
		lockBondGrid.load({
			"blParam" : searchData
		});
		var lockBondLogGrid = nui.get("lockBondLogGrid");//获取详情标签列表
		function onActionRenderer(e) {
			var rowIndex = e.rowIndex;
			var s = '';
			if (e.record.vcLockStatus == "4" || e.record.cIsValid != "1") {
				return s;
			}
			if (e.record.vcLockSource == '1') {//来自买断式回购
				if (e.record.operableUnLockQty > 0) {//锁定中
					s = ' <a style="color:#00CCFF" href="javascript:applyUnlock(\''
							+ rowIndex + '\')" >申请解锁</a>';
				}
			} else if (e.record.vcLockSource == '2') {//来自手工添加
				if (e.record.operableUnLockQty > 0) {
					s = ' <a style="color:#00CCFF" href="javascript:unlock(\''
							+ rowIndex + '\')" >解锁</a>';
				}
			} else if(e.record.vcLockSource == '3'){
				// 查询用户权限
				nui.ajax({
					url : "com.cjhxfund.ats.sm.comm.InstructionManager.queryUserProductHandlesByProductCodeAndRealtype.biz.ext",
					type : 'POST',
					data : {
						productCode : e.record.vcProductCode,
						realType : "'02'"
					},
					cache : false,
					async : false,
					contentType : 'text/json',
					success : function(text) {
						var returnJson = nui.decode(text);
						if (returnJson.exception == null) {
							var usersList = returnJson.usersList;
							for (var i = 0; i < usersList.length; i++) {
								if (usersList[i].VC_USER_ID == returnJson.userId) {
									result = true;
									return;
								}
							}
							result = false;
						} else {
							result = false;
						}
					}
				});
				if (e.record.operableUnLockQty > 0) {
					if(result){
						s = ' <a style="color:#00CCFF" href="javascript:unlock(\''
								+ rowIndex + '\')" >解锁</a>';
					}else{
						s = ' <a style="color:#00CCFF" href="javascript:applyUnlock(\''
								+ rowIndex + '\')" >申请解锁</a>';
					}
				}
			}
			return s;
		}

		// 处理结算日期
		lockBondGrid.on("drawcell", function(e) {
			if (e.field == "lMaturitySettleDate") {
				if (e.value != "" && e.value != null) {
					e.cellHtml = nui.formatDate(DateUtil.numStrToDate(e.value
							.toString()), "yyyy-MM-dd");
				}

			}
		});

		//手动锁定来源，解锁
		var unlock = function(index) {
			nui.open({
				url : nui.context + "/sm/comm/lock/unlock.jsp",
				title : "解锁",
				width : 400,
				height : 200,
				onload : function() {
					var iframe = this.getIFrameEl();
					iframe.contentWindow.SetData(lockBondGrid.data[index],
							function() {
								queryLockBond();
							});
				},
				ondestroy : function(action) {
					//                 grid.reload();
				}
			});
		};
		
		// 申请解锁
		function applyUnlock(index) {
			//var row = lockBondGrid.getSelected();
			//if (!authorityJudgment(row)) {
				//nui.alert("您没有该产品的操作权限,请先确认！", "系统提示");
				//return;
			//}
			nui.open({
				url : nui.context + "/sm/comm/lock/unlockApply.jsp",
				title : "申请解锁",
				width : 400,
				height : 200,
				onload : function() {
					var iframe = this.getIFrameEl();
					iframe.contentWindow.SetData(lockBondGrid.data[index],
							function() {
								queryLockBond();
							});
				},
				ondestroy : function(action) {
					//                 grid.reload();
				}
			});
		};
		// 查看申请解锁进度
		var checkUnlock = function(e) {

		};

		//日期转换
		var dateRen = function(e) {
			var value = e.value;
			if (value)
				return nui.formatDate(value, 'yyyy-MM-dd HH:mm:ss');
			return "";
		};
		var queryLockBond = function() {
			var searchData = searchCondiForm.getData();
			// 锁定状态
			//if (nui.get("lockStatus").checked && nui.get("toUnLock").checked) {
			//	searchData["lockStatus"] = "";
			//}else if(nui.get("lockStatus").checked){
			//	searchData["lockStatus"] = "1,2,3";
			//}else if(nui.get("toUnLock").checked){
			//	searchData["lockStatus"] = "1,2,4";
			//} else {
			//	searchData["lockStatus"] = "1,2";
			//}
			if (nui.get("lockStatus").checked) {
				searchData["lockStatus"] = "";
			} else {
				searchData["lockStatus"] = "1,2";
			}
			// 是否有效（1有效，0无效）
			if (nui.get("InvalidStatus").checked) {
				searchData["InvalidStatus"] = "";
			} else {
				searchData["InvalidStatus"] = "1";
			}
			lockBondGrid.load({
				"blParam" : searchData
			});
		};

		// 添加锁定券
		function add() {
			mini.open({
				url : nui.context + "/sm/comm/lock/addLock.jsp",
				title : "添加锁定券",
				width : 500,
				height : 300,
				onload : function() {
				},
				ondestroy : function(action) {
					queryLockBond();
				}
			});
		};

		//页面X的删除功能
		function onCloseClick(e) {
			var obj = e.sender;
			obj.setText("");
			obj.setValue("");
		}
		//重置按钮
		var reset = function() {
			(new nui.Form("searchCondi")).clear();
		};

		function selectionChanged() {
			var row = lockBondGrid.getSelected();
			var data = {
				lLockId : parseInt(row.lLockId)
			}; //获取表单多个控件的数据
			lockBondLogGrid.load(data);
		}

		// 锁定券操作权限判断
		function authorityJudgment(data) {
			var result = false;
			nui.ajax({
				url : "com.cjhxfund.ats.sm.comm.InstructionManager.queryUserProductHandlesByProductCodeAndRealtype.biz.ext",
				type : 'POST',
				data : {
					productCode : data.vcProductCode,
					realType : "'01','04'"
				},
				cache : false,
				async : false,
				contentType : 'text/json',
				success : function(text) {
					var returnJson = nui.decode(text);
					if (returnJson.exception == null) {
						var usersList = returnJson.usersList;
						for (var i = 0; i < usersList.length; i++) {
							if (usersList[i].VC_USER_ID == returnJson.userId) {
								result = true;
								return;
							}
						}
						result = false;
					} else {
						result = false;
					}
				}
			});
			return result;
		}
		
		// 申请解锁审批状态翻译
		function renderUnlockApproveStatus(e){
			return nui.getDictText("unlockApproveStatus",e.row.vcApprovalStatus);
		}
		
		// 锁定类型翻译
		function renderLockType(e){
			return nui.getDictText("lockType",e.row.vcLockType);
		}
		
		// 解锁类型翻译
		function renderUnLockType(e){
			return nui.getDictText("unlockType",e.row.vcUnlockType);
		}
		
		// 锁定状态翻译
		function renderLockStatus(e){
			return nui.getDictText("lockStatus",e.row.vcLockStatus);
		}
		
		// 交易市场
		function renderMarket(e){
			return nui.getDictText("tradePlace",e.row.vcMarket);
		}
		
		//页面产品代码与产品组合combox联动
	    var fundCodeCombo = nui.get("vcProductCode");
	    var vcCombiCombo = nui.get("vcCombiCode");
	    var vcStockCombo = nui.get("vcStockCode");
	    var vcStockName = null;
		//联动方法
	    var selectFund = function (e) {
	        var id = fundCodeCombo.getValue();
	        if(id == ""){
	        	vcCombiCombo.setValue("");
	        	return false;
	        }else{
	        	nui.ajax({
		            data: {
		            	vcProductCode: id,
		            	queryType: "'01','02','04'"	
		            },
		            url: "com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfoByProductCodeAndRealType.biz.ext",
		            success: function (resp) {
		                if (resp.data) {
		                    vcCombiCombo.load(resp.data);
		                    vcCombiCombo.select(0);
		                }
		            },
		            //有错误码之后，把后面的错误提醒补齐。
		            fail: function (resp) {
		                alert(resp);
		            }
		        });
	        }      
	    };
	    
	    function getStockCode(e) {
        	var market = nui.get("vcMarket").getValue();
        	var productCode = nui.get("vcProductCode").getValue();
        	var combiNo = nui.get("vcCombiCode").getValue();
        	e.params["marketNo"] = market;
        	// 产品代码
        	e.params["fundId"] = productCode;
        	// 组合代码
        	e.params["combiNo"] = combiNo;
		}
		
		// 查询证券名称
	    function queryStockName() {
	    	var marketNo = nui.get("vcMarket").getValue();
	    	var vcStockCode = vcStockCombo.getText();
			var productCode = nui.get("vcProductCode").getValue();
			nui.ajax({
		        data: {'stockCode':vcStockCode,'fundId':productCode,'marketNo':marketNo,'selectType':'1'},
		        async: false,
		        url: "com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.queryTbondCodeList.biz.ext",
		        success: function (resp) {
		        	var bonds = resp.bondList;
		        	vcStockName = bonds[0].stockName;
		        },
		        //有错误码之后，把后面的错误提醒补齐。
		        fail: function (resp) {
		            nui.alert(resp);
		        }
		    });
		}
	    
		//初始化改变债券代码选择提示语句
    	$("#vcStockCode > span > input").attr("placeholder","全部");
	</script>
</body>
</html>