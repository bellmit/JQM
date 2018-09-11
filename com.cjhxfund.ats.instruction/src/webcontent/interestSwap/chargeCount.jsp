<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>	
<!-- 
  - Author(s): jiangkanqian
  - Date: 2018-05-31 09:13:00
  - Description:
-->
<head>
<title>冲销统计</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/css/instruct.css"/> 
    <script type="text/javascript" src="<%= request.getContextPath() %>/instruction/instructionUtil/instruction.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script>
</head>
<body>
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">
			   <div class="search-condition">
				   <div class="list">
					   <div id="form_today_instruct" class="nui-form" style="padding:2px;" align="center" style="height:10%">
					   		<!-- 业务标签:1-投顾端、2-交易员端 -->
		   					<input class="nui-hidden" id="queryType" name="queryType" value="1"/>
		   					<input class="nui-hidden" name="newCharge.lChargeId" id="lChargeId"/>
							<input class="nui-hidden" name="newCharge.lInstructId" id="lInstructId"/>							
			                <table id="instruct_follow_condition" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
				                <tr>
			                		<td class="form_label" width="60px">
										产品名称:
			                        </td>
			                        <td colspan="1" width="200px">
			                            <input id="vcProductCode" class="nui-buttonedit" name="vcProductCode" emptyText="全部" showClose="true" oncloseclick="onCloseClick" onbuttonclick="ButtonClickGetFundName_todayInstruct" style="width:95%"/>
			                        </td>
									<td width="60px" class="form_label">业务方向:</td>
									<td colspan="1" width="180px">
										<input class="nui-dictcombobox" id="vcBusinType" name="vcBusinType" multiSelect="true"
											valueField="dictID" textField="dictName" dictTypeId="interestSwapBusinType" 
											emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
									</td>
									<td class="form_label" width="60px">冲销日期:</td>
									<td colspan="1" width="290px">
										<input class="nui-datepicker" name="lTradeDateMin" style="width:120px" id="lTradeDateMin" showClose="true" oncloseclick="onCloseClick"/>
			                    		<span style="width:50px;" align="left">-</span>
										<input class="nui-datepicker" name="lTradeDateMax" style="width:120px" id="lTradeDateMax" showClose="true" oncloseclick="onCloseClick"/>
									</td>
									<td width="60px" class="form_label">冲销情况:</td>
									<td colspan="1" width="180px">
										<input class="nui-dictcombobox" id="isCharge" name="isCharge" multiSelect="true"
											data="[{id: 0, text: '未冲销'}, {id: 1, text: '已冲销'}]"
											emptyText="全部" showClose="true" oncloseclick="onCloseClick" style="width:95%"/>
									</td>
								</tr>
								<tr>
									<td colspan="7" align="left">
				                		<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
				                		<input class='nui-button' plain='false' text="重置" iconCls="icon-reset" onclick="reset()"/>
				                		<a class="nui-menubutton " plain="false" menu="#popupMenu"
			                               id="searchCond"
			                               name="searchCond"
			                               data-options='{formId:"form_today_instruct"}'
			                               iconCls="icon-add">保存查询条件</a>
			                            <ul id="popupMenu" class="mini-menu" style="display:none;"></ul>
				                	</td>
								</tr>
							</table>
						</div>
				  </div>
			   </div>

		<%-- 列表操作工具开始... --%>
		<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
	    	<table style="width:100%;table-layout:fixed;">
	            <tr>
	                <td style="width:75%;">
	                  <a class='nui-button' plain='false' iconCls="icon-download" id="export_todayInstruct" onclick="exportExcel()">导出</a>
	            </tr>
	        </table>
	    </div>
		        
		        <div class="nui-fit" style="width:100%;height:100%;overflow:hidden;">
		            <div id="treegrid_todays_instruct" class="nui-treegrid" style="width:100%;height:100%;"
				 		url="com.cjhxfund.ats.instruction.InterestSwap.InterestSwapInstruction.queryChargeCount.biz.ext"
				 		dataField="chargeInfos" treeColumn="lInstructId"
				 		showPager="true" pageSize="20"
				 		showTreeIcon="false" showTreeLines="false" multiSelect="true"
				 		sizeList="[20,50,100,200,500,1000]"
				 		showReloadButton="false"
				 		onbeforeload="onBeforeTreeLoad"
				 		onShowRowDetail="onShowRowDetailList"
				 		virtualScroll="true"
				 		onselect="onSelect"
				 		enableHotTrack="false"
				 		idField="lInstructId"
				 	>		
		                    <div property="columns">
		                        <div type="checkcolumn"></div>
		                        <div type="expandcolumn"></div>
		                        <div field="vcProductName" headerAlign="center" allowSort="true" align="center" width="200px">
		                            产品名称
		                        </div>
		                        <div field="vcCombiName" headerAlign="center" allowSort="true" align="left">
		                           组合名称
		                        </div>
		                        <div field="vcBusinName" headerAlign="center" allowSort="true" align="center" renderer="vcBusinNameRender">
		                            业务名称
		                        </div>
		                        <div field="vcBusinType" headerAlign="center" allowSort="true" align="left" renderer="vcBusinTypeRender">
		                            业务方向
		                        </div>
		                        <div field="lNominalCapital" headerAlign="center" allowSort="true" align="left">
		                            名义本金（万元）
		                        </div>
		                        <div field="lInstructNo" headerAlign="center" allowSort="true" align="center">
		                           开仓指令编号
		                        </div>
		                        <div field="tFsDealTime" headerAlign="center" allowSort="true" align="center" width="200px" renderer="resultRenderDeal">
		                           开仓时间
		                        </div>
		                        <div field="lActuSpendCapital" headerAlign="center" allowSort="true" align="left">
		                            累计冲销金额（万元）
		                        </div>
		                        <div field="lLeftCapital" headerAlign="center" allowSort="true" align="left" renderer="leftCapitalRender">
		                            可冲销金额（万元）
		                        </div>
		                     </div>
		                </div>		                
		                
		             </div>
		        </div>
	
		<!-- 导出参数 -->
	<div>
		<form id="export_FROM" method="post">
			<!-- 业务标签:当日指令/建议 -->
			<input class="nui-hidden" id="exportInstructId" name="paramObject/exportInstructId">
			<input class="nui-hidden" id="exportIselect" name="paramObject/exportIselect">
	   		<input class="nui-hidden" id="exportQueryType" name="paramObject/exportQueryType" value="1"/>
			<input class="nui-hidden" id="exportProductCode" name="paramObject/exportProductCode">
			<input class="nui-hidden" id="exportBusinType" name="paramObject/exportBusinType">
			<input class="nui-hidden" id="exportTradeDateMin" name="paramObject/exportTradeDateMin">
			<input class="nui-hidden" id="exportTradeDateMax" name="paramObject/exportTradeDateMax">
			<input class="nui-hidden" id="exportNoCharge" name="paramObject/noCharge">
			<input class="nui-hidden" id="exportCharged" name="paramObject/charged">				
		</form>	
	</div>
	<!-- 导出参数结束 -->
		            
	</div>


	<script type="text/javascript">
    	nui.parse();
    	
    	var today_instruct = new nui.Form("#form_today_instruct");
    	var todays_instruct_grid = nui.get("treegrid_todays_instruct");
    	var isSigleSelectChanged = false;
    	var selectArr = [];//已选的记录数组
    	
    	//重置
       	function reset(){
    		today_instruct.clear();
    		nui.get("queryType").setValue("1");
    	}  	
	   
	   function initWin(data){
	        var data = nui.clone(data);
	        if(data!=null){
	        	
	        }
    	}
       	
       	//行选中时发生
	    function onSelect(e){
	    	var record = e.record;
	    	var isExist = false;
	    	for(var i=0; i<selectArr.length; i++){
	    		var row = selectArr[i];
	    		if(row.lInstructId==record.lInstructId){
	    			selectArr[i] = record;
	    			isExist = true;//若之前已选中，则直接返回
	    			break;
	    		}
	    	}
	    	//若之前尚未选中该记录，则新增该记录到数组中
	    	if(isExist==false){
	    		selectArr.push(record);
	    	}
	    }
       	
       	function vcBusinTypeRender(e){
	    	return nui.getDictText("interestSwapBusinType",e.row.vcBusinType);
	   }
	   
	   function vcBusinNameRender(e){
	    	return nui.getDictText("interestSwapBusinName",e.row.vcBusinName);
	   }
       
       function resultRenderDeal(e){
	    	if(e.row.vcFsdealName!=null || e.row.vcFsdealName!=null){
	    		return (e.row.vcFsdealName==null?"":e.row.vcFsdealName) + "　" + nui.formatDate(e.row.tFsDealTime, "yyyy-MM-dd HH:mm:ss");
			}else{
				return (nui.formatDate(e.row.tFsDealTime, "yyyy-MM-dd HH:mm:ss"));
			}
	  }
      
      function leftCapitalRender(e){
      		var lNominalCapital = e.row.lNominalCapital;
      		var	lSpendCapital = e.row.lSpendCapital;
      		if(lNominalCapital!=null || lSpendCapital!=null){
			      var lLeftCapital = parseFloat(lNominalCapital.toString()) - parseFloat(lSpendCapital.toString());
			      return lLeftCapital;		
      		}
      }
       
       //展示详细行数据
		function onShowRowDetailList(e) {
			var grid = e.sender;//获取表格
			var row = e.record;//获取行数据
			var lInstructId = row.lInstructId;
			var lChargeId = row.lChargeId;
			var chargeCounts = nui.encode({lChargeId : lChargeId,lInstructId:lInstructId});
	    $.ajax({
            url:"com.cjhxfund.ats.instruction.InterestSwap.InterestSwapInstruction.queryChargeCountInfo.biz.ext",
            type:'POST',
            data:chargeCounts,
            cache: false,
            contentType:'text/json',
            success:function(text){
                var returnJson = nui.decode(text);
                if(returnJson.exception == null){
                    var bonds = returnJson.chargeInfos;
					var bondStr = "";
					    bondStr += "<table>"
                    			+" <tr>"
                    			+"  <td style='width:150px;font-weight:bold;' align='center'>冲销时间</td>"
                    			+"  <td style='width:220px;font-weight:bold;' align='center'>冲销类型</td>"
                    			+"  <td style='width:120px;font-weight:bold;' align='center'>已冲销金额(万元)</td>"
                    			+" </tr>";
                    var vcChargeType = "";		
                    for(var i=0; i<bonds.length; i++){	
                    	var bondInfo = bonds[i];
                    	
                    	if(bondInfo.vcChargeType == 0){
                    		  vcChargeType = "双边冲销";
					      }
					    if(bondInfo.vcChargeType == 1){
					    	  vcChargeType = "多边冲销";
					      }
                    					      
                    	bondStr += "<tr><td align='center'>"
                    	+nui.formatDate(bondInfo.tInputTime, "yyyy-MM-dd HH:mm:ss")
                    	+"</td><td align='center'>"
                    	+vcChargeType
                    	+"</td><td align='center'>"
                    	+bondInfo.lSpendCapital
                    	+"</td>"
                    	+"</tr>";
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
    
    function onCloseClick(e){
	    	var obj = e.sender;
            obj.setText("");
            obj.setValue("");
	    }
	
	//获取查询条件的产品名称
		function ButtonClickGetFundName_todayInstruct(e){
	        ButtonClickGetFundName(this);
		}
		
		//跨页多选选择表格获取产品
		function ButtonClickGetFundName(buttonEditObj){
	        nui.open({
	            url: "<%=request.getContextPath()%>/sm/comm/instruct/productInfoCombi.jsp",
	            title: "产品列表",
	            width: 450,
	            height: 380,
	            onload:function(){
	            	
	                var iframe = this.getIFrameEl();
	                var fundCodes = buttonEditObj.getValue();
	                var fundNames = buttonEditObj.getText();
	                var data = {
	                   fundCodes:fundCodes,
	                   fundNames:fundNames
	                };
	                iframe.contentWindow.SetData(data);
	            },
	            ondestroy: function (action) {
	            	
	                if (action == "ok") {
	                    var iframe = this.getIFrameEl();
	                    var data = iframe.contentWindow.GetData();
	                    data = nui.clone(data);
	                    buttonEditObj.setValue(data.vcProductCode);
	                    buttonEditObj.setText(data.vcProductName);
	                }
	            }
	        });
		}
		
		function onBeforeTreeLoad(e) {
        	var params = e.params;  //参数对象
        	
	        //可以传递自定义的属性
			var initParam = new nui.Form("#form_today_instruct").getData(false,false);
			//产品名称
			initParam["vcProductCode"] = splitString(initParam["vcProductCode"]);
			//业务类别
			if(initParam.vcBusinType != null && initParam.vcBusinType != ""){
        		initParam["vcBusinType"] = nui.get("vcBusinType").getValue();
        	}
        	//交易日期
        	if(initParam.lTradeDateMin != null && initParam.lTradeDateMin != ""){
        		initParam.lTradeDateMin = DateUtil.toNumStr(initParam.lTradeDateMin);
        	}
        	
        	if(initParam.lTradeDateMax != null && initParam.lTradeDateMax != ""){
        		initParam.lTradeDateMax = DateUtil.toNumStr(initParam.lTradeDateMax);
        	}
        	
        	//冲销情况
        	if(initParam.isCharge != null && initParam.isCharge != ""){
        		var isCharge = nui.get("isCharge").getValue();
        		if(isCharge == 0){
        			initParam["noCharge"] = 0;
        		}
        		if(isCharge == 1){
        			initParam["charged"] = 1;
        		}
        	}
        	
        	initParam["queryType"] = nui.get("queryType").getValue();
	        params.paramObject = initParam;
	   }
	
       function search(){
    		todays_instruct_grid.reload("com.cjhxfund.ats.instruction.InterestSwap.InterestSwapInstruction.queryChargeCount.biz.ext");
      }
      
      // 导出
        function exportExcel(){
        	//清空列表
        	new nui.Form("#export_FROM").clear();
        	
			var rows = selectArr;
			// 定义指令/建议序号
			var lInstructId = "";
			var iselect = "false";
			var msg = "您未选中指令/建议，将导出全部指令/建议，确定要导出吗?";
			if(rows.length>0){
				var iselect = "true";
				msg = "确定要导出吗?";
				for(var i=0; i<rows.length; i++){
					lInstructId+= rows[i].lInstructId+",";
				}
				//去掉最后一个逗号
			    if (lInstructId.length > 0) {
			        lInstructId = lInstructId.substr(0, lInstructId.length - 1);
			    }
			}
		    
		    // 设置导出form参数
			var initParam = new nui.Form("#form_today_instruct").getData(false,false);
			var vcProductCode = initParam["vcProductCode"];
			//产品名称
			if(vcProductCode != null && vcProductCode != ""){
				document.getElementById("exportProductCode").value = vcProductCode;
			}
			//业务类别
			if(initParam.vcBusinType != null && initParam.vcBusinType != ""){
        		document.getElementById("exportBusinType").value = nui.get("vcBusinType").getValue();
        	}
        	//交易日期
        	if(initParam.lTradeDateMin != null && initParam.lTradeDateMin != ""){
        		document.getElementById("exportTradeDateMin").value = DateUtil.toNumStr(initParam.lTradeDateMin);
        	}
        	
        	if(initParam.lTradeDateMax != null && initParam.lTradeDateMax != ""){
        		document.getElementById("exportTradeDateMax").value = DateUtil.toNumStr(initParam.lTradeDateMax);
        	}
        	
        	if(initParam.isCharge != null && initParam.isCharge != ""){
        		var isCharge = nui.get("isCharge").getValue();
        		if(isCharge == 0){
        			document.getElementById("exportNoCharge").value = 0;
        		}
        		if(isCharge == 1){
        			document.getElementById("exportCharged").value = 1;
        		}
        	}        		
        	       	
        	document.getElementById("exportQueryType").value = nui.get("queryType").getValue();
        	document.getElementById("exportIselect").value = iselect;
        	if(iselect == "true"){
        		document.getElementById("exportInstructId").value = lInstructId;
        	}
        	
			// 页面流跳转
			nui.confirm(msg,"系统提示",function(action){
				if(action=="ok"){
					nui.get("export_todayInstruct").disable();//禁用“导出”按钮
					var form = document.getElementById("export_FROM");				
					form.action = "com.cjhxfund.ats.instruction.InterestSwap.chargeCountExcle.flow";
			        form.submit();
			        //启用“导出”按钮
			        setTimeout("enableExport()",15000);
				}
			});
		}
		
		function enableExport(){
	  		nui.get("export_todayInstruct").enable();
		}
       	
    </script>
</body>
</html>