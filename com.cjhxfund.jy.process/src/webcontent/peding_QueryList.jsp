<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%-- <%@include file="/JQMHistory/common/commscripts.jsp" %> --%>

<%--
- Author(s): CJ-WB-DT13
- Date: 2016-01-25 17:40:16
- Description:
    --%>
    <head>
        <title>
            一级债券信息查询
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
		<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
		<script src="<%= request.getContextPath() %>/common/nui/locale/zh_CN.js" type="text/javascript"></script>
		<script src="<%= request.getContextPath() %>/process/util/common.js" type="text/javascript"></script>
		
		<script type="text/javascript" src="<%= request.getContextPath() %>/riskMgr/js/riskMgrComm.js"></script>
		<%@include file="/common/js/commscripts.jsp" %>
    </head>
    <body style="width:100%;height:100%;overflow: hidden; margin: 0px;">
       <div class="search-condition">
		  <div class="list">
            <div id="form1" class="nui-form"  align="center" style="height:10%" >
                <!-- 数据实体的名称 -->
                <input class="nui-hidden" name="bizCriteria/_entity" value="com.cjhxfund.jy.process.FirstGradeBond.FirstGradeBondEntity">
                <input class="nui-hidden" name="wfCriteria/_entity" value="com.eos.workflow.data.WFWorkItem" />
                <input class="nui-hidden" name="bizCriteria/_orderby[1]/_sort" value="desc" />
	                <input class="nui-hidden" name="bizCriteria/_orderby[1]/_property" value="processDate" />
                <!-- 排序字段 -->
                <table id="table1" class="table" style="width: 100%;" border="0">
                    <tr>
                        
                        <td class="form_label" align="right">
                            业务日期:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-datepicker" id="processDate" format="yyyy-MM-dd" name="bizCriteria/_expr[1]/processDate" />
                            <input class="nui-hidden" name="bizCriteria/_expr[1]/_op" value="=">
                        </td>
                        <td class="form_label" align="right">
                        产品名称:
                        </td>
                        <td>
                          <input id="vCFundCode_ZJTC" class="nui-buttonedit" name="bizCriteria/_expr[2]/combProductCode" id="combProductCode" onbuttonclick="ButtonClickGetFundName_ZJTC"/>
                          <input class="nui-hidden" name="bizCriteria/_expr[2]/_op" value="in">
                        </td>
                        <td class="form_label" align="right">
                            流程节点:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-textbox" name="wfCriteria/_expr[2]/partiName" />
                            <input class="nui-hidden" name="wfCriteria/_expr[2]/_op" value="=">
                        </td>
                        <td class="form_label" align="right">
                            业务类别:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-combobox" data="[{id: 1, text: '一级债券(非可转债)'}, {id: 2, text: '一级债券(可转债/可交换债)'}]"
                             name="bizCriteria/_expr[4]/businesstype" id="businessType"  value="2" onvaluechanged="dynamicHidingColumn"/>
                            <input class="nui-hidden" name="bizCriteria/_expr[4]/_op" value="=">
                            
                            <input class="nui-hidden" name="bizCriteria/_expr[5]/validStatus" value="0" />
							<input class="nui-hidden" name="bizCriteria/_expr[5]/_op" value="in"/>
							
							<input class="nui-hidden" name="bizCriteria/_expr[6]/currentstate" value="4,10" />
							<input class="nui-hidden" name="bizCriteria/_expr[6]/_op" value="in"/>
                        </td>
                        <td>
	                       <!--footer-->
					        <div property="footer" align="left">
					            <a class="nui-button" iconCls="icon-search"  onclick="search()">
					                查询
					            </a>
					           <%-- &nbsp;
					            <a class="nui-button" onclick="reset()">
					                重置
					            </a>--%>
					        </div>
                        </td>
                    </tr>
                </table>
            </div>
          </div>
        </div>  
        <div class="nui-toolbar" style="border-bottom:0;padding:0px">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" iconCls="icon-add" id="add" onclick="add()">申请</a>
                            &nbsp;
                            <a class="nui-button" iconCls="icon-ok" id="batchAgree" onclick="batchAgree()">批量确认</a>
                             &nbsp;
                            <a class="nui-button" iconCls="icon-ok" id="batchAgree" onclick="propelling()">推送招行</a>
                            &nbsp; 
                         <!--     <privilege:operation sourceId="ATS_YJZ_FQFKLC" sid="atsYjzFqfklc" clazz="nui-button" onClick="startRiskProcessByApplyStockInfoTab()" lableName="发起风控流程"  iconCls="icon-add" ></privilege:operation>
                           -->
                        </td>
                    </tr>
                </table>
            </div>  
            <div class="nui-fit" >
                <div 
                        id="datagrid1"
                        dataField="wflist"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.process.common.queryPersonWorkItems.biz.ext"
                        pageSize="20"
                        onShowRowDetail="onShowRowDetailList"
                        showPageInfo="true"
                        multiSelect="true"
                          onselectionchanged="selectionChanged" 
                        allowSortColumn="false">

                    <div property="columns">
                        <div type="checkcolumn">
                        </div>
                        <div type="expandcolumn"></div>
                        <div type="indexcolumn"></div>
                        
                        
                           <div field="lApplyInstId" headerAlign="center" allowSort="true" visible="false">申购指令/建议编号</div>
                        
                        
                        
                        <div field="btId" headerAlign="center" allowSort="true" visible="false">
                            编号
                        </div>
                        <div field="processinstid" headerAlign="center" allowSort="true" visible="false">
                            流程编号
                        </div>
                        <div field="workItemID" headerAlign="center" allowSort="true" visible="false">
                           工作项 编号
                        </div>
                        <div field="bizId" headerAlign="center" allowSort="true" visible="false">
                           业务编号
                        </div>
                        <div field="actionURL" headerAlign="center" allowSort="true" visible="false">
                           url
                        </div>
                        <div field="workItemName" headerAlign="center" allowSort="true" width="150px" >
                           当前节点
                        </div>
                        <div field="processDate" headerAlign="center" align="center" allowSort="true" dateFormat="yyyy-MM-dd">
                            投标日期
                        </div>
                        <div field="combProductName" headerAlign="center" width="150px" allowSort="true" >
                            产品名称
                        </div>
                        <div field="vcCombiName" headerAlign="center" width="150px" allowSort="true" >
                            组合名称
                        </div>
                        <div field="investproductnum" headerAlign="center" align="center" allowSort="true" width="50">
                            编号
                        </div>
                        <div field="investProductCode" headerAlign="center" allowSort="true" >
                            债券代码
                        </div>
                        <div field="investProductName" headerAlign="center" allowSort="true" >
                            债券名称
                        </div>
                        
                        <div field="combProductCode" headerAlign="center" allowSort="true" visible="false">
                            产品代码
                        </div>
                        <div field="vcCombiNo" headerAlign="center" allowSort="true" visible="false">
                            组合代码
                        </div>
                        <div field="netWorthScale" headerAlign="center" allowSort="true" visible="false">
                            净值规模(万元)
                        </div>

                        <div field="paymentplace" headerAlign="center" align="center" allowSort="true" renderer="renderPaymentplace">
                            登记托管场所
                        </div>
                        <div field="interestrate" headerAlign="center" align="right" allowSort="true" >
                            投标利率(%)
                        </div>
                        <div field="investcount" headerAlign="center" align="right" allowSort="true" >
                            投标金额(万元)
                        </div>
                        
                        <div field="purchaseAmount" headerAlign="center" align="right" allowSort="true" visible="false">
                            申购金额(万元)
                        </div>
                        <div field="depositRatio" headerAlign="center" align="right" allowSort="true" visible="false">
                            定金比例(%)
                        </div>
                        <div field="depositAmount" headerAlign="center" align="right" allowSort="true" visible="false">
                            定金金额(万元)
                        </div>
                        
                        <div field="ratingname" headerAlign="center" align="center" allowSort="true" >
                            发行主体
                        </div>
                        <div field="ratingType" headerAlign="center" align="center" allowSort="true" renderer="renderRatingType">
                            发行主体类型
                        </div>
                        <div field="subjectrating" headerAlign="center" align="center" allowSort="true"  renderer="renderSubjectrating">
                            主体评级
                        </div>
                        <div field="bondrating" headerAlign="center" align="center" allowSort="true" renderer="renderBondrating">
                            债项评级
                        </div> 
                        <div field="ratingagencies" headerAlign="center" align="center" allowSort="true" renderer="renderRatingagencies">
                            评级机构
                        </div>
                        <div field="investcategory" headerAlign="center" align="center" allowSort="true" renderer="renderInvestcategory">
                            债券种类
                        </div>
                        <div field="issueSize" headerAlign="center" align="right" allowSort="true" >
                            发行规模(万元)
                        </div>
                        <div field="resaleRight" headerAlign="center" align="center" align="center" allowSort="true" renderer="renderresaleRight">
                            是否具有回售权
                        </div>
                        <div field="redemptionRight" headerAlign="center" align="center" allowSort="true" renderer="renderredemptionRight">
                            是否具有赎回权
                        </div>
                        <div field="categorydate" headerAlign="center" align="right" allowSort="true" >
                            债券期限(年)
                        </div>
                        <div field="categorymoney" headerAlign="center" align="right" allowSort="true" >
                            主体发行证券存量(万元)
                        </div>
                        <div field="mainBearingMechanism" headerAlign="center" align="center" allowSort="true" >
                            主承机构
                        </div>
                        
                    </div>
                </div>
            </div>
 <!--隐藏表单-->
<form action="" name="openForm" method="post" target="_blank">
  <input type="hidden" name="workItemID" id="workItemID">
  <input type="hidden" name="processinstid" id="processinstid">
  <input type="hidden" name="bizId" id="bizId">
  <input type="hidden" name="btId" id="btId">
  <input type="hidden" name="pageType" id="pageType" value="1"/>
</form>
<script type="text/javascript">
	nui.parse();
	var grid = nui.get("datagrid1");
	//给业务日期查询条件赋值
	//nui.get("processDate").setValue(new Date());
			
	var formData = new nui.Form("#form1").getData(false,false);
	grid.load(formData);
	
	//新增
	function add() {
		var businessType = nui.get("businessType").getValue();
		var url = "<%=request.getContextPath() %>/process/FirstGradeBond/CfJyBusinessBoneTableForm.jsp";
		var title = "申购缴款(非可转债)录入";
		var width = "850";
		var height = "700";
		if(businessType == 2){
			url  = "<%=request.getContextPath() %>/process/FirstGradeBondKZJ/CfJyBusinessBoneTableKZZForm.jsp";
			title = "申购缴款(可转债)录入";
			width = "830";
			height = "660";
		}
		if(businessType == 1){
			nui.alert("由于系统升级，非可转债申购缴款指令，请到新债超市页签中发起！","提示");
			return;
		}
		nui.open({
			url: url,
			title: title, width: width, height: height,
			onload: function () {//弹出页面加载完成
				var iframe = this.getIFrameEl();
				var data = {pageType:"add"};//传入页面的json数据
    			iframe.contentWindow.setFormData(data);
			},
			ondestroy: function (action) {//弹出页面关闭前
				grid.reload();
			}
		});
	}
	//打开推送界面
    function propelling(){
    	var rows = grid.getSelecteds();
    	//console.log(rows);/
    	if(rows.length > 0){
    	
    	/*
    	*contentType:'text/json' 时候，nui.ajax 和 $。ajax $需要将data的值转换为json格式//nui.encode(data);
    	*/
    		nui.ajax({
				url:"com.cjhxfund.cjapi.WSPrimaryMarketService.checkApplyIs.biz.ext",
				type:'POST',
				data:{'investNo':rows[0].investproductnum},
	 			cache:false,
				contentType:'text/json',
				success:function(text){
					if(text.ret==false){
						nui.alert("当前指令不是通过接口下单，不允许推送到招行~");
						return ;
					}
					nui.open({
						url: "<%=request.getContextPath()%>/process/FirstGradeBond/stockApiList.jsp",
						title: "选择推送给招行的新债", width: 750, height: 350,
						showCloseButton:true,
						onload: function () {
							//弹出页面加载完成
							var iframe = this.getIFrameEl();
							//data.cfjybusinessbonetable
							var bizId=rows[0].bizId;
							var data = {bizId:bizId};//传入页面的json数据
										iframe.contentWindow.setData(data);
						},
						ondestroy: function (action) {//弹出页面关闭前
							
						}
					});
				}
			});
    		//if(rows[0].workItemName=="中标确认"){
		    	
			//}else{
			//	nui.alert("当前非中标确认节点，不能推送","提示");
			//}
		}else{
			nui.alert("没有选择指令/建议，不能确认","提示");
		}
    }      
	//重新刷新页面
	function refresh(){
		var form = new  nui.Form("#form1");
		var json = form.getData(false,false);
		grid.load(json);//grid查询
		nui.get("update").enable();
		dynamicHidingColumn();
	}

	//查询
	top["win"] = window;
	function search() {
		var form = new nui.Form("#form1");
		var json = form.getData(false,false);
		grid.load(json);//grid查询
	}

	//重置查询条件
	function reset(){
		var form = new nui.Form("#form1");//将普通form转为nui的form
		form.reset();
	}

	//enter键触发查询
	function onKeyEnter(e) {
		search();
	}

	//交易场所
	function renderPaymentplace(e){
		return nui.getDictText("CF_JY_DJTGCS",e.row.paymentplace);
	} 
             
	//主体评级
	function renderSubjectrating(e){
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_SUBJECT_RATING",e.row.subjectrating);
	}   
             
	//主体类型
	function renderRatingType(e){
		return nui.getDictText("CF_JY_ZTLX",e.row.ratingType);
	}
             
	//债项评级
	function renderBondrating(e){
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_BOND_RATING",e.row.bondrating);
	}
             
	//债券种类
	function renderInvestcategory(e){
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_BOND_CATEGORY",e.row.investcategory);
	}
             
	//评级机构
	function renderRatingagencies(e){
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_RATING_AGENCIES",e.row.ratingagencies);
	}
             
	//是否具有回售权
	function renderresaleRight(e){
		return nui.getDictText("COF_YESORNO",e.row.resaleRight);
	}
             
	//是否具有回售权
	function renderredemptionRight(e){
		return nui.getDictText("COF_YESORNO",e.row.redemptionRight);
	}
             
	function renderBusinessType(e){
		if(e.row.businessType ==1){
			return "一级债券(非可转债)";
		}else{
			return "一级债券(可转债)";
		}
	}

	//行双击时弹出页面展示该指令/建议详细信息--所有业务通用
	function rowdblclickFun(jspUrl, title, width, height, e, grid_confirm) {
		var row = e.record;//行对象值
		if (row) {
			nui.open({
				url: "<%=request.getContextPath()%>/"+jspUrl+"?bizId="+row.bizId+"&processinstid="+row.processinstid+"&workItemID="+row.workItemID,
				title: title,
				width: width,
				height: height,
				onload: function () {
					var iframe = this.getIFrameEl();
					var data = {pageType:"query",roleType:"TG",record:{cfjybusinessbonetable:row}};
					//直接从页面获取，不用去后台获取
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function (action) {//弹出页面关闭前
					if(action=="confirmSuccess"){//若是确认，则刷新页面
						grid.reload();
					}
				}
			});
		}
	}
    	
	//行双击时弹出页面展示该指令/建议详细信息
	grid.on("rowdblclick", function (e) {
		//rowdblclickFun(e.row.actionURL, e.row.workItemName, "100%", "100%", e, grid);
		wfOpenWin(e.row.actionURL,e.row.processinstid,e.row.workItemID,e.row.bizId,e.row.btId,"100%","100%");
	});
    
	function wfOpenWin(url,processInstID,workItemID,bizId,btId,width,height) {
		var winFrm=document.openForm;
		document.getElementById("processinstid").value=processInstID;
		document.getElementById("workItemID").value=workItemID;
		document.getElementById("bizId").value=bizId;
		document.getElementById("btId").value=btId;
		var actionURL=url; //目标页面
		winFrm.action=actionURL;
		var newwin = window.open('about:blank', 'newWindow', '');
		winFrm.target = 'newWindow';//这一句是关键
		winFrm.submit();
	}
		
	function ButtonClickGetFundName_ZJTC(e){
	   ButtonClickGetFundName(this,'<%=request.getParameter("jurisdiction")%>');
	}
	
	
	var jurisdiction = '<%=request.getParameter("jurisdiction") %>';
	var buttonShow = '<%=request.getParameter("buttonShow") %>';
	if(jurisdiction =="All"){
		if(buttonShow=="" || buttonShow==null){
			nui.get("add").disable();
		}
	}
	
	
	//批量同意功能
	function batchAgree(){
	   var rows = grid.getSelecteds();
	   var workitemIdArr = "";
	   var investNoArr = "";
	   //判断是否选择数据
	   if(rows.length == 0){
	     nui.alert("没有选择指令/建议，不能确认","提示");
	     return;
	   }
	   for(var i = 0;i < rows.length;i++){
			if(workitemIdArr == ""){
				workitemIdArr = rows[i].workItemID;
				investNoArr = rows[i].investproductnum;
	    	}else{
	       		workitemIdArr +=  "," + rows[i].workItemID;
	       		investNoArr += "," +  rows[i].investproductnum;
	    	}
	    }
	    var businessType = nui.get("businessType").getValue();  //获取流程类型
	    var data={workitemIdArr:workitemIdArr , businessType:businessType,investNoArr:investNoArr};
	    var urlStr = "com.cjhxfund.jy.process.common.processBatchAgree.biz.ext";
	    var json = nui.encode(data);
	    var a = nui.loading("正在处理中,请稍等...","提示");
		$.ajax({
			url:urlStr,
			type:'POST',
			data:json,
 			cache:false,
			contentType:'text/json',
			success:function(text){
				nui.hideMessageBox(a);
				var returnJson = nui.decode(text);
				if((returnJson.returnValue == "yes" || returnJson.returnValue == "y") && returnJson.returnText == undefined){
				  	nui.alert("提交确认成功", "系统提示", function(action){
				  	    if(action == "ok" || action == "close"){
							search();   //提交成功后重新刷新表格  
						}
				  	});
				}else{
					var returnText = returnJson.returnText;
					if(returnText != undefined && returnText != ""){
						nui.alert("指令/建议:"+returnText.substring(5,returnText.length)+"，调用招行接口失败。", "系统提示", function(action){
							if(action == "ok" || action == "close"){
								search();   //提交成功后重新刷新表格 
							}
						});
						
						return;
					}else{
						nui.alert("提交确认失败", "系统提示", function(action){});
					}
				}
			}
		});
	} 
	
	 //当选择列时
		     function selectionChanged(){
		        var rows = grid.getSelecteds();
		      
		        if(rows.length>1){
		               nui.get("atsYjzFqfklc").disable();
		              
		        }else{
		        	   nui.get("atsYjzFqfklc").enable();
		              
		               riskProcessBtnControlByApplyStockInfo(rows[0]);
		        }
		    } 
	
	   
	      
   </script>
  </body>
</html>
