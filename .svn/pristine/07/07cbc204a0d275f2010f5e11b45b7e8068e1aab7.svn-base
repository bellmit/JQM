<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<div title="风控信息" id="riskInfoPanel" class="nui-panel" iconCls="icon-edit" style="width:100%;" showCollapseButton="true" collapseOnTitleClick="true">
	<div style="padding-top:5px;" id="instructInfoForm" class="nui-form">
		<div class="nui-toolbar" style="border-bottom:0;padding:0px">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                    	<input class="nui-button" id="riskMeasureBtn" iconCls="icon-reload" text="风控测算" onclick="riskMeasure()"/>&nbsp;&nbsp;&nbsp;
                    	<input class="nui-button" id="addRiskBtn" iconCls="icon-add" text="新增"  onclick="addRiskRow()"/>
                    	<input class="nui-button" id="delRiskBtn" iconCls="icon-remove" text="删除"  onclick="removeRiskRow()"/>
                    	<input class="nui-button" id="endProcess" iconCls="icon-remove" text="风控误卡，流程结束"  onclick="endProcess()"/>
                    	<input class="nui-button" id="riskHelp" iconCls="icon-help" tooltip="" style="float: right;" />
                    </td>
                </tr>
            </table>
        </div> 
		<div class="nui-fit" >
			<div 
                id="approveRiskGrid"
                dataField="riskInfos"
                class="nui-datagrid"
                style="width:100%;height:150px;"
                url="com.cjhxfund.ats.riskMgr.riskMgr.queryRiskDetail.biz.ext"
                showPager="false"
                oncellbeginedit="OnBanCellBeginEdit"
                multiSelect="true"
                allowCellEdit="true"
                allowCellSelect="true"
                sortField="lRiskmgrId"
                sortOrder="desc">
                <div property="columns">
	                <div field="vcIsTransaction" headerAlign="center" allowSort="false" renderer="riskApproveChilType" width="8%" >
	                   	审批类型<input property="editor" class="nui-dictcombobox" id="vcIsTransaction"  style="width:100%;" dictTypeId="riskApproveChilType"/>
	                </div>
	                <div field="vcRiskType" headerAlign="center" allowSort="false" renderer="riskmgrRisktype" width="8%" >
	                   	风控类型
	                </div>                        
	                <div field="vcRiskDescribe" headerAlign="center" width="31%" allowSort="false" >
	                   	风控说明<input property="editor" class="nui-textbox" id="vcRiskDescribe"  style="width:100%;"/>
	                </div>
	                <div field="vcSetValue" headerAlign="center" width="8%" allowSort="false" >
	                   	设置值<input property="editor" class="nui-textbox" id="vcSetValue"  style="width:100%;"/>
	                </div>
	                <div field="vcTrueValue" headerAlign="center" align="center" allowSort="false" width="8%">
	                   	真实值<input property="editor" class="nui-textbox" id="vcTrueValue"  style="width:100%;"/>
	                </div>
	                <div field="vcMolecularRiskValue" headerAlign="center" align="center" allowSort="false" width="8%">
	                  	 分子值<input property="editor" class="nui-textbox" id="vcMolecularRiskValue"  style="width:100%;"/>
	                </div>
	                <div field="vcDenomRiskValue" headerAlign="center" allowSort="false" width="8%">
	                 	分母值<input property="editor" class="nui-textbox" id="vcDenomRiskValue"  style="width:100%;"/>
	                </div>
	                <div field="vcRemarks" headerAlign="center" allowSort="false" width="21%">
	                  	 备注<input property="editor" class="nui-textarea" id="vcRemarks"  style="width:100%;"/>
	                </div>
	                <div field="cDataSource" headerAlign="center" allowSort="false" width="100px" renderer="dataSource">
	                	数据来源
	                </div>
	                <div field="lRiskmgrId" visible="false">
	                	风控表关联主键
	                </div>
                </div>
			</div>
		</div>
	</div>
</div>

<div title="禁止类申诉信息" id="banInfoPanel" class="nui-panel" iconCls="icon-edit" style="width:100%;" showCollapseButton="true" collapseOnTitleClick="true">
	<div style="padding-top:5px;" id="banInfoForm" class="nui-form">
		<div class="nui-toolbar" style="border-bottom:0;padding:0px">
        </div> 
		<div class="nui-fit" >
			<div 
                id="banRiskGrid"
                dataField="riskInfos"
                class="nui-datagrid"
                style="width:100%;height:150px;"
                url="com.cjhxfund.ats.riskMgr.riskMgr.queryRiskDetail.biz.ext"
                oncellbeginedit='editBanGrid'
                showPager="false"
                multiSelect="true"
                allowCellEdit="true"
                allowCellSelect="true">
                <div property="columns">
	                <div field="vcRiskDescribe" headerAlign="center" width="35%" allowSort="false" >
	                   	风控说明<input property="editor" class="nui-textbox" id="vcRiskDescribe"  style="width:100%;"/>
	                </div>
	                <div field="vcMolecularValue" headerAlign="center" align="center" allowSort="false" width="15%">
	                  	 分子值<input property="editor" class="nui-textbox" id="vcMolecularRiskValue"  style="width:100%;"/>
	                </div>
	                <div field="vcDenomValue" headerAlign="center" allowSort="false" width="15%">
	                 	分母值<input property="editor" class="nui-textbox" id="vcDenomRiskValue"  style="width:100%;"/>
	                </div>
	                <div field="vcDesc" headerAlign="center" allowSort="false" width="30%">
	                  	 说明<input property="editor" class="nui-textarea" id="vcRemarks"  style="width:100%;"/>
	                </div>
	                <div field="cDataSource" headerAlign="center" allowSort="false" width="5%" renderer="dataSource">
	                	数据来源
	                </div>
                </div>
			</div>
		</div>
	</div>
</div>

	<script type="text/javascript">
		nui.parse();/*********引用后删除该行************/
		var grid = nui.get("approveRiskGrid");
		var banGrid = nui.get("banRiskGrid");
		var riskmgrId = "";
		var riskType = "";
		var isAllEdit = "";
		var isBan = "n";
		
		//加载完成后，设置禁止类不可编辑审批类型
		grid.on("load", function (e) {
			rows = e.data;
			for(var i=0;i<rows.length;i++){
				if(rows[i].vcRiskType=="2"){
					isBan = "y";
				}
			}
			
			if(isBan=="n"){
				nui.get("banInfoPanel").hide();
			} else {
				nui.get("banInfoPanel").show();
				banGrid.load({lRiskmgrId:lRiskmgrId,vcRiskType:'2'});
			}
		});
		
		//加载风控表格数据
		//param lRiskmgrId 风控主表ID
		//param isEdit   是否可编辑y/n
		function setRiskInfoTable(lRiskmgrId,vcRiskType,isEdit){
			riskmgrId=lRiskmgrId;
			riskType=vcRiskType;
			isAllEdit=isEdit;
			loadTip();//加载提示
			//加载表格
			grid.load({lRiskmgrId:lRiskmgrId,vcRiskType:vcRiskType});
			if(isEdit!="y"){//不可编辑时置灰按钮，设置表格不可编辑
				nui.get("riskMeasureBtn").disable();
				nui.get("addRiskBtn").disable();
				nui.get("delRiskBtn").disable();
			}
		}
		
		//重加载风控试算
		function riskMeasure(){
			var json = nui.encode({lRiskmgrId:lRiskmgrId,lResultId:lResultId});
			var risktip = nui.loading("风控测算中,请稍等...","提示");
			$.ajax({   //查询用户选中设计的workItemID
	            url:"com.cjhxfund.ats.riskMgr.comm.reloadRiskDetail.biz.ext",
	            data:json,
	            type:'POST',
	            contentType:'text/json',
	            cache:false,
	            success:function(data){
	            	nui.hideMessageBox(risktip);
	            	returnJson = nui.decode(data);
	            	showRiskInfo(returnJson, returnJson);
	            }
            });
		}
		
		//获取最终风控审批类型
		function getMainApproveType(){
			var rows = grid.getData();
			var approveType = 0;	//其他
			
			//vcIsTransaction：0其他、1关联交易、2价格异常
			var vcIsTransaction_1 = false;
			var vcIsTransaction_2 = false;
			var isAllBan = true;//是否全部为禁止类
			for(var i=0;i<rows.length;i++){
				var row = rows[i];
				if(row.vcIsTransaction=="1"){
					vcIsTransaction_1 = true;
				}
				if(row.vcIsTransaction=="2"){
					vcIsTransaction_2 = true;
				}
				if(row.vcRiskType=='3'){
					isAllBan = false;
				}
			}
			
			if(vcIsTransaction_1==true && vcIsTransaction_2==true){
				approveType = 3;	//异常且关联
			}else if(vcIsTransaction_1==true){
				approveType = 2;	//关联
			}else if(vcIsTransaction_2==true){
				approveType = 1;	//异常
			}
			//全部为禁止类则没有审批类型
			if(isAllBan) approveType=4;
			return approveType;
		}
		
		function getRiskDetailData(){
			var datas = grid.getData();
			var banDatas = banGrid.getData();
			for(var i =0;i<datas.length;i++){
				//给审批类风控默认为其它类
				if((datas[i].vcIsTransaction==null||datas[i].vcIsTransaction=="")&&datas[i].vcRiskType==3){
					datas[i].vcIsTransaction=0;
				}
				//设置申诉值
				for(var j=0;j<banDatas.length;j++){
					if(datas[i].vcRiskNo==banDatas[j].vcRiskNo){
						datas[i].vcMolecularValue = banDatas[j].vcMolecularValue;
						datas[i].vcDenomValue = banDatas[j].vcDenomValue;
						datas[i].vcDesc = banDatas[j].vcDesc;
					}
				}
			}
			return datas;
		}
		
		
		function onselectionchanged(e){
		
		}
		
		function OnBanCellBeginEdit(e){
			var row = e.row;
			if(isAllEdit!="y"){
				e.cancel = true;
				return;
			}

			if(e.field=="vcIsTransaction"&&row.cDataSource!="3"){
				if(row.vcRiskType=="3"){
					e.cancel = false;
				} else {
					e.cancel = true;
				}
			} else if (row.cDataSource=="3"||e.field=="vcRemarks"){
				e.cancel = false;
			} else {
				e.cancel = true;
			}
		}
		
		//禁止类取消单元格编辑
		function editBanGrid(e){
			var row = e.row;
			if(isAllEdit!="y"){
				e.cancel = true;
				return;
			}
			
			if(e.field=="vcMolecularValue"&&!(row.vcMolecularRiskValue==null||row.vcMolecularRiskValue=='')){
				e.cancel = false;
			} else if (e.field=="vcDenomValue"&&!(row.vcDenomRiskValue==null||row.vcDenomRiskValue=='')){
				e.cancel = false;
			} else if (e.field=="vcDesc"){
				e.cancel = false;
			} else {
				e.cancel = true;
			}
		}
		
		//禁止类申诉表格验证
		function checkBanGrid(){
			var rows = banGrid.getData();
			var tipInfo;
			for(var i=0;i<rows.length;i++){
				var row = rows[i];
				if(row.vcMolecularRiskValue&&(row.vcMolecularValue==null||row.vcMolecularValue=="")){
					tipInfo += "第"+(i+1)+"行分子值不能为空<br>";
				}
				if(row.vcDenomRiskValue&&(row.vcDenomValue==null||row.vcDenomValue=="")){
					tipInfo += "第"+(i+1)+"行分母值不能为空<br>";
				}
				//当分母分子值都没有时，说明为必填项
				if(!row.vcMolecularRiskValue&&!row.vcDenomRiskValue&&(row.vcDesc==null||row.vcDesc=="")){
					tipInfo += "第"+(i+1)+"行说明不能为空<br>";
				}
			}
		}
		
		//加载提示信息
		function loadTip(){
			var json = nui.encode({paramKey:"ATS_RISK_TIPS_INFO"});
			$.ajax({   //查询用户选中设计的workItemID
	            url:"com.cjhxfund.ats.riskMgr.comm.getSysParam.biz.ext",
	            data:json,
	            type:'POST',
	            contentType:'text/json',
	            cache:false,
	            success:function(data){
	            	$("#riskHelp").attr("title",data.paramValue);
	            }
            });
		}
		
		//风控误卡，关闭流程
		function endProcess(){
			nui.confirm("是否确认发起风控误卡流程？", "系统提示",
	            function (action) {  
		            if(action=="ok"){        
						var json = nui.encode({lRiskmgrId:lRiskmgrId,riskProcessInstId:processInstID?processInstID:null});
						$.ajax({   //查询用户选中设计的workItemID
				            url:"com.cjhxfund.ats.riskMgr.riskmgrMistake.startRiskMistakeProcess.biz.ext",
				            data:json,
				            type:'POST',
				            contentType:'text/json',
				            cache:false,
				            async:false,
				            success:function(data){
				            	nui.alert("风控误卡流程发起成功","系统提示",function(action){
			                 	 	//刷新前页面
			                 	 	if (window.opener && window.opener.search){
				                    	window.opener.search();
					                } else if(window.parent && window.parent.opener && window.parent.opener.search){
					                	window.parent.opener.search();
					                }
									window.close();
									window.parent.close();
			               		});
				            }
			            });
		            }
            	}
        	)
			
		}
		
		//增加行
		function addRiskRow(){
			var length = grid.getData().length;
		    var newRow = {vcRiskType:"3",cDataSource:"3",lRiskmgrId:riskmgrId};
		    grid.addRow(newRow, length);
		    grid.deselectAll();
            grid.select(newRow);
		}
		//删除行
		function removeRiskRow(){
			var rows = grid.getSelecteds();
			for(var i=0;i<rows.length;i++){
				var row = rows[i];
				if(row.cDataSource!="3"){
					nui.alert("只能删除数据来源为‘新增’的风控数据");
					return;
				}
			}
			grid.removeRows(rows,false);
		}
		
	function riskApproveChilType(e){//风控审批类型：1异常 2关联 3异常且关联
	  	return nui.getDictText("riskApproveChilType",e.row.vcIsTransaction);
	}	
		
	function riskmgrRisktype(e){//风控类型：1预警 2禁止 3审批
	  	return nui.getDictText("ATS_RISKMGR_RISKTYPE",e.row.vcRiskType);
	}
	
	function dataSource(e){
		return nui.getDictText("ATS_RISKMGR_DATASOURCE",e.row.cDataSource);
	}
	
	//触发风控
	//触发风控处理
	function showRiskInfo(returnJson, instructJson){
		if(returnJson.exception == null){
			var instructParameterData = instructJson.instructParameter;
			if(returnJson.rtnCode == nui.ATS_SUCCESS){
	        	//风控通过
	        	window.parent.nui.alert(returnJson.rtnMsg,"系统提示");
				return '1';
			}else if(returnJson.rtnCode == "203" || returnJson.rtnCode == "302"){
	        	//风控校验失败 || 可用不足且风控校验失败
	        	window.parent.nui.alert(returnJson.rtnMsg,"系统提示");
	        	return '-1';
	        }else{  
	        	//触发风控
	            nui.open({
	            	url: nui.context+"/riskMgr/riskInfo/reLoadRiskDetailList.jsp",
	                title: "风险提示",
	                width: 800,
	                height: 380,
	                onload: function () {
	                    var iframe = this.getIFrameEl();
	                    iframe.contentWindow.SetData('3', returnJson.riskMsg, instructParameterData , riskmgrId);
	                },
	                ondestroy: function (retAction) {
	                	var action = retAction.action;
	                	if(action=='-1'){
	                		
	                	}else if(action=='1'){
	                		nui.alert("覆盖成功");
	                		grid.load({lRiskmgrId:riskmgrId,vcRiskType:riskType});
	                	}
	                }
	            });
	        }
		}else{
			nui.alert("系统异常","系统提示");
			return '-1';
		}
		return '-1';
	}
	
    </script>
