<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<%
	String userId_zbqr = ""; 
	if (userObject != null) {
		userId_zbqr = (String)userObject.getUserId();
	}
 %>
<!-- 
  - Author(s): 谢海光
  - Date: 2017-12-6 17:55:41
  - Description:
-->
<head>
<title>新债跟踪</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />  
    <style type="text/css">
    	.mini-tabs-bodys{
    		border: 0px;
    	}
    	.mini-layout-region{
    		border-left: 0px;
    		border-right: 0px;
    		border-bottom: 0px;
    	}
    	.mini-panel-border{
    		border-left: 0px;
    		border-right: 0px;
    	}
    </style> 
    <script type="text/javascript" src="<%=request.getContextPath() %>/common/js/commonjs.js"></script>
</head>
<body style="width: 100%;height: 100%;overflow: hidden;">
<div id="layout1" class="mini-layout" style="width:100%; height:100%;"  borderStyle="border:0px;">
	<div height="100%" borderStyle="border:0px;">
		<div class="search-condition" >
		  <div class="list">
            <div id="form1" class="nui-form"  align="center" >
                <form id="queryForm" action="">
                <!-- 数据实体的名称 -->
	            <input class="nui-hidden" name="bizCriteria/_entity" value="com.cjhxfund.ats.fm.instr.firstGradeDebt.FirstGradeDebtHandleEntity">
	            <input class="nui-hidden" name="wfCriteria/_entity" value="com.eos.workflow.data.WFWorkItem" />

                <input class="nui-hidden" name="bizCriteria/_expr[9]/lValidStatus" value="0" width="100%"/>
                <input class="nui-hidden" name="bizCriteria/_expr[9]/_op" value="=">
                <table id="table1" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;" >
                    <tr>
                    	<td style="width:60px" align="right">
                            缴款日期:
                        </td>
                        <td style="width:20%" align="left">
                            <input class="nui-datepicker" id="lPayDate" format="yyyy-MM-dd" name="bizCriteria/_and[1]/_expr[1]/dPaymentDate" width="100%"/>
                            <input class="nui-hidden" name="bizCriteria/_and[1]/_expr[1]/_op" value=">=">
                        </td>
                        <td style="width:60px" align="center">至</td>
                        <td style="width:20%" align="left">
                            <input class="nui-datepicker" id="lPayDate2" format="yyyy-MM-dd" name="bizCriteria/_and[1]/_expr[2]/dPaymentDate" width="100%"/>
                            <input class="nui-hidden" name="bizCriteria/_and[1]/_expr[2]/_op" value="<=">
                        </td>
                            <td style="width:60px" align="right">
                            产品名称:
                        </td>
                        <td style="width:20%" align="left">
                            <input id="vCFundCode_ZJTC" class="nui-buttonedit" name="bizCriteria/_expr[4]/vcProductCode"
                             id="combProductCode" onbuttonclick="ButtonClickGetFundName_ZJTC" width="100%"/>
                            <input class="nui-hidden" name="bizCriteria/_expr[4]/_op" value="=">
                        </td>
                        <td style="width:60px" align="right">划款情况: </td>
                        <td style="width:20%" align="left">
                        	<input class="nui-combobox" name="bizCriteria/_expr[7]/cTransferMoney" dictTypeId="TransferMoney"  id="TransferMoney"
                        			data="[{id: 1, text: '余额不足'}, {id: 2, text: '未出款'}, {id: 3, text: '已出款'}, {id: 4, text: '对方已成功收款'} ]" 
                        			showNullItem="false" multiSelect="true" showClose="true" valueFromSelect="true"
									  oncloseclick="onCloseClickValueEmpty"  width="100%"/>
                        	<input class="nui-hidden" name="bizCriteria/_expr[7]/_op" value="in">
                        </td> 
                      <td style="width:60px" align="right">
						债券简称:
		                </td>
		                <td style="width:20%" align="left">
							<input class="nui-textbox" id="vcStockName" name="bizCriteria/_expr[5]/vcStockName" width="100%"/>
                        	<input class="nui-hidden" type="hidden" name="bizCriteria/_expr[5]/_op" value="like">
                            <input class="nui-hidden" type="hidden" name="bizCriteria/_expr[5]/_likeRule" value="all">
 
                        </td>
                        <td style="width:80px">
                        	<a id="query" class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
					                        重置
					       </a>
                        </td>
                    </tr>
                    <tr>
                    	<td style="width:60px" align="right">
                          	  业务日期:
                        </td>
                        <td  align="left" colspan="1">
                            <input class="nui-datepicker" id="processDate"  format="yyyy-MM-dd" name="bizCriteria/_expr[1]/dApplicationTime" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="bizCriteria/_expr[1]/_op" value=">=">
                         </td>
                         <td style="width:60px" align="center">至</td>
                         <td  align="left">
                            <input class="nui-datepicker"  id="processDate_stop" format="yyyy-MM-dd" name="bizCriteria/_expr[2]/dApplicationTime" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="bizCriteria/_expr[2]/_op" value="<="/>
                        </td>
                        
                        <td align="right">
						归档情况:
		                </td>
		                <td align="left">
							<!-- <input class="nui-textbox" id="workitemname" name="bizCriteria/_or[1]/_expr[7]/workitemname" width="100%"/>
                        	<input class="nui-hidden" type="hidden" name="bizCriteria/_or[1]/_expr[7]/_op" value="like">
                            <input class="nui-hidden" type="hidden" name="bizCriteria/_or[1]/_expr[7]/_likeRule" value="all">
                             -->
                            <input class="nui-combobox" name="bizCriteria/_or[1]/_expr[7]/vcArchiveStatus" id="vcArchiveStatus"
                        			data="[{id: 0, text: '待归档'}, {id: 1, text: '归档中'}, {id: 2, text: '归档成功'}, {id: 3, text: '归档失败'}, {id: 4, text: '无需归档'} ]"  
                        			showNullItem="false" multiSelect="true" showClose="true" valueFromSelect="true"
									  oncloseclick="onCloseClickValueEmpty"  width="100%"/>
                        	<input class="nui-hidden" name="bizCriteria/_or[1]/_expr[7]/_op" value="in">
                          
                        </td>
                        <td align="right">流程状态: </td>
                        <td align="left">
                        	<input class="nui-combobox" name="bizCriteria/_expr[10]/currentState" dictTypeId="currentstate"  id="currentstate"
                        			data="[{id: 2, text: '流程运行中'}, {id:'7,8', text: '流程已结束'} ]" value="2" 
                        			showNullItem="false" multiSelect="true" showClose="true" valueFromSelect="true"
									  oncloseclick="onCloseClickValueEmpty"  width="100%"/>
                        	<input class="nui-hidden" name="bizCriteria/_expr[10]/_op" value="in">
                        </td> 
                        <td align="right">是否中标: </td>
                        <td align="left">
                        	<input class="nui-combobox" name="bizCriteria/_expr[6]/isWinTheBidding" dictTypeId="isWinTheBidding"  id="isWinTheBidding"
                        			data="[{id: '中标', text: '中标'}, {id: '未中标', text: '未中标'} ]" 
                        			showNullItem="false" multiSelect="false" showClose="true" valueFromSelect="true"
									  oncloseclick="onCloseClickValueEmpty"  width="100%"/>
                        	<input class="nui-hidden" name="bizCriteria/_expr[6]/_op" value="=">
                        </td> 
                        <td align="left" style="width:80px">
                        	<a class='nui-button' plain='false' iconCls="icon-search" onclick="search()">
					                        查询
					        </a>
                        	<input id="vcProcessType" class="nui-hidden" name="bizCriteria/_or[2]/_and[1]/_expr[1]/vcProcessType" value="1,5,8"  width="100%" />
                        	<input class="nui-hidden" name="bizCriteria/_or[2]/_and[1]/_expr[1]/_op" value="in">
					        
                        </td>
                    </tr>
                    <tr>
						<td align="right">对手方:</td>
                        <td align="left">
                        	<input class="nui-textbox" id="vcStocktypeName" name="bizCriteria/_expr[11]/vcBusinessObject" width="100%"/>
                        	<input class="nui-hidden" type="hidden" name="bizCriteria/_expr[11]/_op" value="like">
                            <input class="nui-hidden" type="hidden" name="bizCriteria/_expr[11]/_likeRule" value="all">
                        </td>
                        <td align="right"></td>
                        <td align="left"></td>
                        <td align="right"></td>
                        <td align="left"></td>
                        <td align="right"></td>
                        <td align="left"></td> 
                      	<td align="right"></td>
		                <td align="left"></td>
                        <td></td>
                    </tr>
                </table>
               </form>
            </div>
           </div>
         </div>   
            <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">                            
                            <!-- <a id="save" class='nui-button' plain='false' iconCls="icon-save" onclick="saveData()">保存</a>
                            <a id="archive" class='nui-button' plain='false' iconCls="icon-ok" onclick="archive()">归档</a> -->
                            <privilege:operation sourceId="ATS_XZGZ_SAVE" sid="saveData" clazz="nui-button" onClick="saveData()" lableName="保存" iconCls="icon-save" ></privilege:operation>
                            <privilege:operation sourceId="ATS_XZGZ_ARC" sid="archive" clazz="nui-button" onClick="archive()" lableName="归档" iconCls="icon-ok" ></privilege:operation>
                            <privilege:operation sourceId="ATS_JYGL_UPDATE" sid="updateHandleBid" clazz="nui-button" onClick="updateHandleBid()" lableName="修改归档信息"  iconCls="icon-edit" ></privilege:operation>
                            <privilege:operation sourceId="ATS_EXPORT_EXCEL" sid="exportExcel" clazz="nui-button" onClick="exportExcel()" lableName="导出"  iconCls="icon-download" ></privilege:operation> 
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
                        url="com.cjhxfund.ats.fm.instr.subStockIssueTrace.queryStockIssueTrace.biz.ext"
                        pageSize="20"
                        showPageInfo="true"
                        multiSelect="true"
                        onselectionchanged="selectionChanged"
                        onShowRowDetail="onShowRowDetailList"
                        allowCellEdit="true"
                        allowCellSelect="true"
                        allowSortColumn="true"
                        sortField="dApplicationTime"
                        sortOrder="desc">

                    <div property="columns">
                        <div type="checkcolumn">
                        </div>
                        <div type="expandcolumn"></div>
                       
                        <div field="lBizId" headerAlign="center" allowSort="true" visible="false">
                           lBizId
                        </div>
                        <div field="lApplyTraceId" headerAlign="center" allowSort="true" visible="false">
                           新债跟踪表ID
                        </div>
						<div field="lProcessInstId" headerAlign="center" allowSort="true" align="center"  width="70px">
		            流程编号
                        </div>
                        <div field="dApplicationTime" headerAlign="center" align="center" allowSort="true" dateFormat="yyyy-MM-dd">
                            业务时间
                        </div>
                        
                        <div field="vcProductName" headerAlign="center" allowSort="true" width="150px">
                            产品名称
                        </div>
                        <div field="vcStockName" headerAlign="center" allowSort="true" >
                            债券简称
                        </div>
                        <div field="vcStocktypeName" headerAlign="center" allowSort="true" >
                            债券类别
                        </div>
                        <div field="enInterestRate" headerAlign="center" allowSort="true" >
                            投标利率（%）
                        </div>
                        <div field="enInvestBalance" headerAlign="center" allowSort="true" >
                            投标金额
                        </div>
                        <div field="vcMainUnderwriter" headerAlign="center" allowSort="true"  width="200px">
                            主承销商
                        </div>
                         <div field="cFaxStatus" headerAlign="center" allowSort="true" renderer="onlFaxStatus">
                            传真&签收情况
                            <!-- <input property="editor" class="nui-dictcombobox"  dictTypeId="ATS_FAX_STATUS" style="width:100%;"/>  -->
                        </div>
                        <div field="enCouponRate" headerAlign="center" allowSort="true" >
                            中标利率            <!-- <input property="editor" class="mini-textbox" style="width:100%;" /> -->
                        </div>
                        <div field="isWinTheBidding" headerAlign="center" allowSort="true" >
                            是否中标
                        </div>
                        <div field="cApplyAuthStatus" headerAlign="center" allowSort="true" renderer="renderApplyAuthStatus">
                            投标指令有效性
                        </div>
                        <div field="dPaymentDate" name="dPaymentDate"  headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd" >
                            缴款日期              <!-- <input property="editor" class="mini-datepicker" style="width:100%;"/> -->
                        </div>
                        <div field="vcProcessType" headerAlign="center" allowSort="true" width="70px" renderer="rendererBizTypeName">
                            流程类别
                        </div>
                        <div field="enBallotPrice" headerAlign="center" allowSort="true" >
                           发行价格
                        </div>
                        <div field="enPayFaceValue" headerAlign="center" allowSort="true" renderer="renderEnPayFaceValue">
                            缴款面值
                        </div>
                        <div field="enPaymentMoney" headerAlign="center" allowSort="true" >
                            缴款金额
                        </div>
                        <div field="t0jyky" headerAlign="center"  width="80px" align="right">
                           头寸可用情况
                        </div>
                        <div field="lFixValidStatus" headerAlign="center" align="center"  renderer="renderlFixValidStatus">
              Fix发送状态
                        </div>
                        <div field="cTransferMoney" headerAlign="center" allowSort="true" renderer="rendercTransferMoney">
                           划款情况              <!-- <input property="editor" class="mini-combobox" style="width:100%;" data="FixValidStatus" />  -->
                        </div>
                        <div field="vcTransactionType" headerAlign="center" allowSort="true" renderer="renderTransaction">
                           交易方式
                        </div>
                        <div field="vcBusinessObject" headerAlign="center" allowSort="true">
                           交易对手方
                        </div>
                
                        <div field="cPaymentAuthStatus" headerAlign="center" align="center" allowSort="true"  renderer="renderPaymentAuthStatus">
       	        缴款授权状态
                        </div>
                         <div field="vcContactInfo" headerAlign="center" allowSort="true">
                           联系人与联系电话 <input property="editor" class="mini-textbox" style="width:100%;" />
                        </div>
                        <div field="vcTrackNumber" headerAlign="center" allowSort="true">
                          快递单号              <input property="editor" class="mini-textbox" style="width:100%;" />
                        </div>
                        <div field="vcRemark" headerAlign="center" allowSort="true">
                           备注                   <input property="editor" class="mini-textarea" style="width:100%;" minWidth="100" minHeight="50"/>
                        </div>
                        <div field="vcArchiveStatus" headerAlign="center" allowSort="true"  renderer="renderVcArchiveStatus">
                           归档完成情况
                        </div>
                        <div field="workitemname" headerAlign="center" allowSort="true" width="150px" >
                            当前节点
                        </div>
                        
                </div>
			</div>
		</div>
		</div>
	</div>	
			
	<script type="text/javascript">
    	nui.parse(); 
    	var grid = nui.get("datagrid1");
		var msg;
			
		//给业务日期查询条件赋值
		//nui.get("processDate").setValue(new Date());
		//nui.get("processDate_stop").setValue(new Date());
	
        var formData = new nui.Form("#form1").getData(false,false);
        grid.load(formData);
    	$("#dataform1 .mini-buttonedit-buttons").remove();
		$("#dataform1 .mini-buttonedit-border").css("background-color","#f0f0f0");
    	//重新刷新页面
        function refresh(){
           var form = new  nui.Form("#form1");
           var json = form.getData(false,false);
           grid.load(json);//grid查询
           nui.get("update").enable();
        }

           //查询
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
            
             //交易方式
			 function renderTransaction(e){
			  
			  return nui.getDictText("ATS_FM_PAYMENT",e.row.vcTransactionType);
			 }
             function ButtonClickGetFundName_ZJTC(e){
			   	ButtonClickGetFundName(this,'<%=request.getParameter("jurisdiction")%>');
			 }
			 function rendererBizTypeName(e){
			 	if(e.row.vcProcessType=="1" || e.row.vcProcessType=="5"){
			 		return "申购流程";
			 	}else if(e.row.vcProcessType=="8"){
			 		return "缴款流程";
			 	}
			 }
			//fix状态
			function renderlFixValidStatus(e){
				if(e.row.lFixValidStatus == 0){
					return "未发送";
				}else if(e.row.lFixValidStatus == 1){
					return "修改后未发送";
				}else if(e.row.lFixValidStatus == 2){
					return "发送中";
				}else if(e.row.lFixValidStatus == 3){
					return "发送成功";
				}else if(e.row.lFixValidStatus == 4){
					return "发送失败";
				}
			}
			function rendercTransferMoney(e){
			   if(e.row.cTransferMoney == 1){
					return "余额不足";
				}else if(e.row.cTransferMoney == 2){
					return "未出款";
				}else if(e.row.cTransferMoney == 3){
					return "已出款";
				}else if(e.row.cTransferMoney == 4){
					return "对方已成功收款";
				}
			}
			function renderVcArchiveStatus(e){
			   if(e.row.vcArchiveStatus == "0" || e.row.vcArchiveStatus==null){
					return "待归档";
				}else if(e.row.vcArchiveStatus == "1"){
					return "归档中";
				}else if(e.row.vcArchiveStatus == "2"){
					return "归档成功";
				}else if(e.row.vcArchiveStatus == "3"){
					return "归档失败";
				}else if(e.row.vcArchiveStatus == "4"){
					return "无需归档";
				}
			}
			var FixValidStatus = [{ id: 0, text: '未发送' }, { id: 1, text: '修改后未发送'}, { id: 2, text: '发送中'}
			                      , { id: 3, text: '发送成功'}, { id: 4, text: '发送失败'}, { id: 5, text: '对手方收款成功'}];
			// 申购授权状态
			function renderApplyAuthStatus(e){
				if(e.row.cApplyAuthStatus == 0){
					return "正式授权申购";
				}else if(e.row.cApplyAuthStatus == 1){
					return "非正式授权申购";
				}
			}
			
			// 缴款面值
			function renderEnPayFaceValue(e){
				if(e.row.enPayFaceValue == -1){
					return "";
				}else{
				  return e.row.enPayFaceValue;
				}
			}
			
			// 是否中标
			function renderIsWinTheBidding(e){
				if(e.row.isWinTheBidding == 1){
					return "是";
				}else if(e.row.isWinTheBidding == 2){
					return "否";
				}
			}
			// 缴款授权状态
			function renderPaymentAuthStatus(e){
				if(e.row.cPaymentAuthStatus == 2){
					return "正式授权缴款";
				}else if(e.row.cPaymentAuthStatus == 3){
					return "非正式授权缴款";
				}
			}
			

	function onlFaxStatus(e){
		return nui.getDictText("ATS_FAX_STATUS",e.row.cFaxStatus);
	}
	 function onBirthdayRenderer(e) {
            var value = e.row.lPayDate;
            if (value){
               return new Date(value.toString()).Format("yyyy-MM-dd")
            } 
            return "";
        }
		Date.prototype.Format = function (fmt) { 
	    var o = {
	        "M+": this.getMonth() + 1, //月份 
	        "d+": this.getDate(), //日 
	        "h+": this.getHours(), //小时 
	        "m+": this.getMinutes(), //分 
	        "s+": this.getSeconds(), //秒 
	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
	        "S": this.getMilliseconds() //毫秒 
	    };
	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	    for (var k in o)
	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	    return fmt;
	}
	//展示详细行数据
	function onShowRowDetailList(e) {
		var grid = e.sender;//获取表格
	    var row = e.record;//获取行数据
	    
	    var ProcessInstId = row.lProcessInstId;
	    var lBizId=row.lBizId;
	    
        var map={
            bizId:lBizId,
	        processinstid:ProcessInstId,
	        attachBusType:"1"
	    }
	    //获取附件信息
	    var processIdJson = nui.encode({map : map});
	    $.ajax({
            url:"com.cjhxfund.ats.fm.comm.attachUitlFunction.queryProcrssAttachment.biz.ext",
            type:'POST',
            data:processIdJson,
            cache: false,
            contentType:'text/json',
            success:function(text){
                var returnJson = nui.decode(text);
                if(returnJson.exception == null){
                    var bonds = returnJson.attachments;
                    var html = "<table border='0'  style='width:100%;'>";

					var bondStr = html + "</table>";
					    bondStr += "<table>"
                    			+" <tr>"
                    			+"  <td style='width:400px;font-weight:bold;' align='center'>附件名称</td>"
                    			+"  <td style='width:100px;font-weight:bold;' align='center'>是否需归档</td>"
                    			+" </tr>";
                    for(var i=0; i<bonds.length; i++){
                    	var bondInfo = bonds[i];
                    	
					      
                    	bondStr += "<tr><td align='center'>"+ changeNull(bondInfo.vcAttachName)+"</td><td align='center'>"+isWhetherArchiving(bondInfo.cWhetherArchiving)+"</td></tr>";
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
	var isEdit=true;
     nui.get("saveData").disable();
	//当选择列时saveData
    function selectionChanged(){
        var rows = grid.getSelecteds();
        if(rows.length>1){
            nui.get("archive").disable();
            nui.get("updateHandleBid").disable();
            nui.get("saveData").disable();
        }else{
            nui.get("archive").enable();
            nui.get("updateHandleBid").enable();
        }
    }
    function isWhetherArchiving(e){
         if(e==null || e=="" || e=="0"){
            return "否";
         }else{
            return "是";
         }
    }
     function saveData() {            
         nui.confirm("是否保存？","系统提示",function(action){
            //debugger;
            var rows = grid.getChanges();
               var processIdArr = new Array();
    		for(var i=0; i<rows.length; i++){
    			var record = rows[i];
    			var processIdTemp = {
    			    lProcessInstId:record.lProcessInstId,
    			    vcContactInfo:record.vcContactInfo,
    			    vcTrackNumber:record.vcTrackNumber,
    			    vcRemark:record.vcRemark
    			};
    			processIdArr.push(processIdTemp);
    		}
	        var json = nui.encode({stockIssueTraceData:processIdArr,attachments:null});
            grid.loading("保存中，请稍后......");
            $.ajax({
                url: "com.cjhxfund.ats.fm.instr.subStockIssueTrace.saveStockIssueTrace.biz.ext",
                type:'POST',
                data:json,
                cache: false,
                contentType:'text/json',
                success: function (text) {
                    grid.reload();
                    isEdit=true;
                    nui.get("saveData").disable();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
            });
          });
        }
        grid.on("beforeload", function (e) {
            if (grid.getChanges().length > 0) {
	                if (!confirm("有修改的数据未保存，是否取消本次操作？")) {
	                    e.cancel = true;
	                }
            }
        });
        grid.on("cellcommitedit", function (e) {
            if (e.field == "enFaceRate") {
                var reg = /^[0-9]+([.]{1}[0-9]+){0,1}$/;
			  if (!reg.test(e.value)){
                    nui.alert("中标利率只能输入数字！");
                    e.cancel = true;
                }
            }
             if (e.field == "lPayDate") {
                   if(e.value){
                      e.value=new Date(e.value).Format("yyyy-MM-dd");
                   }else{
                      e.value=null;
                   }
             }
        });
        function archive(){
           //debugger;
			var rows=grid.getSelecteds();
			if(rows.length==1){
			    var vcArchiveStatus=rows[0].vcArchiveStatus;
				if(vcArchiveStatus=="1" ){
				   nui.alert("指令已发起归档,无法再次发起归档！");
				   return;
				}
				if(vcArchiveStatus=="4"){
				   nui.alert("指令无需归档！");
				   return;
				}
			var json = nui.encode({paramMap:rows});
			nui.confirm("确认是否归档提交？","系统提示",function(action){
				if(action=="ok"){
					var a = nui.loading("正在处理中,请稍等...","提示");
					nui.ajax({
						url:"com.cjhxfund.ats.fm.instr.subStockIssueTrace.createStockIssueTrace.biz.ext",
						type:'POST',
						data:json,
						cache: false,
						contentType:'text/json',
						success:function(text){
							nui.hideMessageBox(a);
							var returnJson = nui.decode(text);
							if(returnJson.out=="3"){
				      			nui.alert("归档流程已发起成功！","归档提醒",function (a){
			    				   grid.reload();
			    			    });
				      		}else{
				      		    nui.alert("归档流程发起失败！");
				      		}
						}
			    	});
			    }
			});	
			}else{
			   nui.alert("请选择一条归档数据！");
			}
	   }	
	    //行双击时弹出页面展示该指令/建议详细信息
	 grid.on("rowdblclick", function (e) {
	    var detailUrl="<%=request.getContextPath() %>/fm/instr/firstGradeDebt/handleBidDetail.jsp";
	    if(e.row.vcProcessType==8){
	        detailUrl="<%=request.getContextPath() %>/fm/instr/firstGradeDebt/handlePaymentDetail.jsp";
	    }
		 nui.open({
                    url:detailUrl,
                    title: "新债跟踪详情", 
                    width: 1000, 
           			height: 700,
                    //allowResize:false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var type="3";
                         var power="1";
                         var buttonHandleBid=nui.get("updateHandleBid");
                        if(buttonHandleBid==null || buttonHandleBid==undefined){
                           power="2";
                        }
                        iframe.contentWindow.initForm(type,e.row.lProcessInstId,e.row.lBizId,e.row.workItemID,power,e.row.vcArchiveStatus);
                    },
                    ondestroy: function (action) {
                        if(action=="saveSuccess"){
	                        grid.reload();
                   	 	}
                    }
                });
	});
	function updateHandleBid(){
	    var row = grid.getSelected();
	    if (row) {
	           var detailUrl="<%=request.getContextPath() %>/fm/instr/firstGradeDebt/handleBidDetail.jsp";
			    if(row.vcProcessType==8){
			        detailUrl="<%=request.getContextPath() %>/fm/instr/firstGradeDebt/handlePaymentDetail.jsp";
			    }
	           nui.open({
                    url:detailUrl,
                    title: "新债投标详情", 
                    width: 1000, 
           			height: 700,
                    //allowResize:false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var type="3";
                        iframe.contentWindow.initForm(type,row.lProcessInstId,row.lBizId,row.workItemID,"1",row.vcArchiveStatus);
                    },
                    ondestroy: function (action) {
                        if(action=="saveSuccess"){
	                        grid.reload();
                   	 	}
                    }
                });
                isEdit=true;
                nui.get("saveData").disable();
        }else{
			nui.get("saveData").enable();
			isEdit=false;
		}
	}
	 //渲染行对象
	 grid.on("drawcell", function (e) {
	    column = e.column,
        row=e.row;
        //debugger;
       var field = e.field;
         	//action列，超连接操作按钮
         	//debugger;
	        if (field == "vcContactInfo" || field == "vcTrackNumber" || field == "vcRemark"){
	         e.cellStyle = "background-color:#FFFFBB;";
	        }
	        if (column.name == "dPaymentDate") {
			if(row.dPaymentDate == 0){
				e.cellHtml ="";
			}
			
		    }
	        	
	}); 
	grid.on("cellbeginedit", function (e) {
	        var field = e.field;
            if (field == "vcContactInfo" || field == "vcTrackNumber" || field == "vcRemark") {
                //debugger;
                var buttonHandleBid=nui.get("updateHandleBid");
                if(buttonHandleBid==null || buttonHandleBid==undefined){
	                 e.cancel = true;
                }else{
                    
                    if(isEdit){
	                   e.cancel = true;
	                }
                }
            }
        });
        
        function exportExcel(){
        	var form = new nui.Form("#form1");
            var json = form.getData(false,false);
            json.param = {filename:"新债跟踪.xlsx",rulename:"STOCK_ISSUE_TRACE_EXCEL_EXPORT",modename:"新债跟踪"};
            json.sortField = grid.getSortField();
            json.sortOrder = grid.getSortOrder();
            var tip = nui.loading("拼命导出中,请稍等...","提示");
            nui.ajax({ 
            	url:'com.cjhxfund.ats.fm.instr.subStockIssueTrace.queryStockIssueTraceExport.biz.ext',
            	data:json,
            	type:'POST',
            	cache:false,
            	contentType:'text/json',
				success:function(text){
					nui.hideMessageBox(tip);
					var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						var resultCode = nui.decode(text).resultCode;
						var resultMsg = nui.decode(text).resultMsg;
						var filepath = nui.decode(text).filepath;
						if(resultCode == 0){
							downfile(filepath);
						}else{
							nui.alert(resultMsg+"请联系管理员", "系统提示");
						}
					}else{
						nui.alert("导出时发生异常，请联系系统管理员处理", "系统提示");
					}
				}
			});
        }
    </script>
</body>
</html>