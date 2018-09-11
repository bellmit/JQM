<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@include file="/common/js/commscripts.jsp" %>
<%--
- Author(s): 杨敏
- Date: 2016-01-25 17:40:16
- Description:
    --%>
    <head>
        <title>
            一级债券信息查询
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <style type="text/css">
    	   #table tr th{
    	      font-weight: inherit;
    	   }
    	   
	.row_input {
	    background-position: 6px 50%;
	    background-repeat: no-repeat;
	    height:18px;
	    font-size: 9pt;
	}
    	</style>
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
    </head>
    <!-- 权限标签 -->
    
<body style="width:99.6%;height:99.6%;overflow: hidden;">
     <%--<div id="tabs" class="nui-tabs" style="width: 100%;height: 100%;">--%>
        <%--<div title="申购缴款(非可转债)">--%>
    <div id="layout1" class="nui-layout" style="width:100%; height:100%;" borderStyle="border:0px;">
        <div>
        <div class="search-condition">
		  <div class="list">
            <div id="form1" class="nui-form"  align="center" >
                <!-- 排序字段 -->
                <!-- <input class="nui-hidden" type="hidden" name="criteria/_orderby[1]/_sort" value="desc" />
                <input class="nui-hidden" type="hidden" name="criteria/_orderby[1]/_property" value="processDate" /> -->
                <input class="nui-hidden" type="hidden" id="cSource" name="criteria/_expr[8]/cSource" value="">
                <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                    <tr>
                    	<td style="width:80px" align="right">
                          	  发行日期:
                        </td>
                        <td style="width:20%" align="left" colspan="1">
                            <input class="nui-datepicker" id="processDate"  format="yyyy-MM-dd" name="criteria/_expr[1]/lIssueBeginDate" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[1]/_op" value=">=">
                         </td>
                         <td style="width:60px" align="center">至</td>
                         <td style="width:20%" align="left">
                            <input class="nui-datepicker"  id="processDate_stop" format="yyyy-MM-dd" name="criteria/_expr[4]/lIssueBeginDate" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[4]/_op" value="<="/>
                        </td>
                       <td style="width:60px" align="right">
                          	债券年限:
                        </td>
                        <td style="width:20%" align="left">
                            <input  class="nui-textbox"  name="criteria/_expr[2]/enExistLimite"
                             id="vcStockName" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[2]/_op" value="=">
                        </td>
                          
                      <td style="width:80px" align="right">
						登记托管机构:
		                </td>
		                <td style="width:20%" align="left">
							<input class="nui-dictcombobox" name="criteria/_expr[5]/vcPaymentPlace" dictTypeId="CF_JY_DJTGCS" valueField="dictID" textField="dictName"    
									 width="100%" showClose="true" oncloseclick="onCloseClickValueEmpty"  onvaluechanged="onMarketValueChanged"/>
                        	<input class="nui-hidden" type="hidden" name="criteria/_expr[5]/_op" value="=">
                        </td>
                        <td style="width:60px" align="right">
						债券类别:
		                </td>
		                <td style="width:20%" align="left">
							<input style="width: 100%;" id="queryVcStockType" name="criteria/_expr[9]/vcStockType" class="mini-treeselect"  multiSelect="true" 
						        textField="text" valueField="id" parentField="pid" checkRecursive="false"  showFolderCheckBox="false"
						        showFolderCheckBox="true"   expandOnLoad="true" showTreeIcon="false" showClose="true" 
						        popupWidth="200" oncloseclick="onCloseClickValueEmpty" />
                        	<input class="nui-hidden" type="hidden" name="criteria/_expr[9]/_op" value="in">
                        </td>
                        
                         <td style="width:80px">
					       <a id="query" class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
					                        重置
					       </a>                        
					     </td>  
                    </tr>
                    <tr>
                    	
                    	<td  align="right">
                          	债券简称:
                        </td>
                        <td style="width:20%" align="left">
                            <input  class="nui-textbox"  name="criteria/_or[1]/_expr[1]/vcStockName"
                             id="vcStockName" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[1]/_op" value="like">
                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[1]/_likeRule" value="all">
                            
                            <input  class="nui-hidden"  name="criteria/_or[1]/_expr[2]/vcStockNameFull"
                             id="vcStockNameFull" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[2]/_op" value="like">
                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[2]/_likeRule" value="all">
                        </td>
                        <td align="right">
						债券代码:
		                </td>
		                <td align="left">
                        	 <input  class="nui-textbox"   name="criteria/_expr[10]/vcStockCode"
                             id="vcStockCode"  width="100%"/>
                        	<input class="nui-hidden" type="hidden" name="criteria/_expr[10]/_op" value="like">
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[10]/_likeRule" value="all">
                        </td>
                        <td align="right">
						发行主体:
		                </td>
		                <td align="left">
							<input id="vCFundCode_ZJTC" class="nui-textbox"  name="criteria/_expr[3]/vcIssuerName"
                             id="IssuerName" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[3]/_op" value="like">
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[3]/_likeRule" value="all">
                        </td>
                        
                    	<td align="right">
						主体评级:
		                </td>
		                <td align="left">
							<input class="nui-dictcombobox" name="criteria/_expr[6]/cIssueAppraise"  valueField="dictID" textField="dictName" dictTypeId="issuerRating"  
									emptyText="全部" nullItemText="全部" multiSelect="true" showClose="true" valueFromSelect="true" width="100%" oncloseclick="onCloseClickValueEmpty"/>
                        	<input class="nui-hidden" type="hidden" name="criteria/_expr[6]/_op" value="in">
                        </td>
                        
                        <td align="right">
						主体类型:
		                </td>
		                <td align="left">
							<input class="nui-dictcombobox" name="criteria/_expr[7]/vcIssueProperty"   valueField="dictID" textField="dictName" dictTypeId="ATS_FM_ISSUE_PROPERTY"  
									emptyText="全部" nullItemText="全部"  multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" width="100%"/>
                        	<input class="nui-hidden" type="hidden" name="criteria/_expr[7]/_op" value="in">
                        </td>
                        
                        
                        <td >
					       <a id="query" class='nui-button' plain='false' iconCls="icon-search" onclick="search()">
					                        查询
					       </a>                        
					    </td>
                    </tr>
                    <tr>
                    	<td align="right">
						公告日期:
		                </td>
		                <td align="left">
							<input class="nui-datepicker" id="postDate" format="yyyy-MM-dd" name="criteria/_expr[11]/lIssuePostDate" width="100%"/>
                            <input class="nui-hidden" type="hidden" name="criteria/_expr[11]/_op" value="like">
                        </td>
                    </tr>
                </table>
            </div>
           </div>
         </div>   
         <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <!-- <a class='nui-button' plain='false' id="add" iconCls='icon-add' onclick='addAll()'>一键申购</a> -->
                        <privilege:operation sourceId="ATS_YJZ_YJSG" sid="add" clazz="nui-button" onClick="addAll()" lableName="一键申购"  iconCls="icon-add" ></privilege:operation>
                        <privilege:operation sourceId="ATS_YJZ_ZLJK" sid="addPay" clazz="nui-button" onClick="addPayment()" lableName="分销缴款"  iconCls="icon-add" ></privilege:operation>
                        <a class='nui-button' plain='false' id="details" iconCls='icon-edit' onclick='details()'>查看详情</a>
                        <a class='nui-button' plain='false' id="appraise" iconCls='icon-edit' onclick='bondAppraise()'>历史评级</a>
                        <!-- <privilege:operation sourceId="ATS_XZCX_XYFX" sid="appraise"  clazz="nui-button" onClick="bondAppraise()" lableName="历史评级"  iconCls="icon-edit" ></privilege:operation> -->
                        <!-- <privilege:operation sourceId="ATS_YJZ_CKXQ" sid="details" clazz="nui-button" onClick="details()" lableName="查看详情"  iconCls="icon-edit" ></privilege:operation> -->
                        <!-- <a class='nui-button' plain='false' id="addNo" iconCls='icon-add' onclick='addNoBond()'>无债券申购</a> -->
                        <!-- <privilege:operation sourceId="ATS_YJZ_WZQSG" sid="addNo" clazz="nui-button" onClick="addNoBond()" lableName="无债券申购"  iconCls="icon-add" ></privilege:operation> -->
                         <a class='nui-button' plain='false' id="compare" iconCls='icon-search' onclick='compare()'>新债信息对比</a>
                         <privilege:operation sourceId="ATS_JYGL_XZXXBXZ" sid="stockIssueInfoDown" clazz="nui-button" onClick="wordDownload1()" lableName="新债信息表下载"  iconCls="icon-download" ></privilege:operation>
                        <privilege:operation sourceId="ATS_ZH_STOCK_IMPORT" sid="ATS_ZH_STOCK_IMPORT" clazz="nui-button" onClick="importStockIssue()" lableName="导入"  iconCls="icon-upload" ></privilege:operation>
                        <privilege:operation sourceId="ATS_ZH_STOCK_EXPORT" sid="ATS_ZH_STOCK_EXPORT" clazz="nui-button" onClick="exportStockIssue()" lableName="导出"  iconCls="icon-download" ></privilege:operation>
                        <%--&nbsp;
                        <a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">编辑</a>
                        &nbsp;
                        <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()"> 删除</a>--%>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit" style="width:100%;height:100%;overflow:hidden;">
        	<div 
                id="datagrid1"
                dataField="stockissueinfos"
                class="nui-datagrid"
                style="width:100%;height:100%"
                url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryStockIssueInfos.biz.ext"
                        pageSize="20" sortField="lIssueBeginDate" sortOrder="desc"
                        showPageInfo="true"
                        multiSelect="true" 
                        onselectionchanged="selectionChanged"
                         frozenStartColumn="0" frozenEndColumn="5">

                    <div property="columns" >
                        <div type="indexcolumn">
                        </div>
                        <div type="checkcolumn">
                        </div>
                        <div name="action" width="110" headerAlign="center">#</div>
                        <div field="vcInterCode" headerAlign="center" allowSort="true" visible="false">
                            证券内码
                        </div>
                        <div field="vcInterCodeWind" headerAlign="center" allowSort="true" visible="false">
        wind内码
                        </div>
                        
                       
                        <div field="vcStockCode" headerAlign="center" allowSort="true" >
                            债券代码
                        </div>
                        <div name="cIsIntention" field="cIsIntention" headerAlign="center" align="center" allowSort="true" renderer="rendererIsIntention">
                            投资意向
                        </div>
                        <div field="vcStockName" headerAlign="center" allowSort="true" width="150px">
                            债券简称
                        </div>
                        <div field="vcStockNameFull" headerAlign="center" allowSort="true" width="150px">
                            债券全称
                        </div>
                        <div field="lIssueBeginDate" headerAlign="center" allowSort="true" width="100px" renderer="renderBeginDate">
                            发行日期
                        </div>
                        <div field="lPayDate" headerAlign="center" allowSort="true" width="100px" renderer="renderBeginDate">
                            缴款日期
                        </div>
                        <div field="dBidLimitTime" headerAlign="center" allowSort="true" width="100px" visible="false">
                            投标截止日期
                        </div>
                        <div field="lIssuePostDate" headerAlign="center" allowSort="true" width="100px" renderer="renderBeginDate">
                            公告日期
                        </div>
                        <div field="vcPaymentPlace" headerAlign="center" allowSort="true" width="80px" align="center" renderer="renderCMarketNo">
                          登记托管机构
                        </div>
                        <div field="vcStocktypeName" headerAlign="center" allowSort="true" width="70px" align="center" >
                            债券类别
                        </div>
                        <div field="enExistLimite" headerAlign="right" align="right"allowSort="true" width="80px" align="right">
                            发行期限(年)
                        </div>
                        <div field="enIssueBalance" headerAlign="right" align="right" allowSort="true" width="80px">
                            发行规模(亿)
                        </div>
                        <div field="cIssueAppraise" headerAlign="center" align="center" allowSort="true" width="60px" renderer="renderSubjectrating">
                            主体评级
                        </div>
                        <div field="vcIssuerName" headerAlign="center" align="center" allowSort="true" >
                            发行主体
                        </div>
                        
                        <div field="vcBondAppraiseOrgan" headerAlign="center" allowSort="true" renderer="renderRatingagencies">
                            债券评级机构
                        </div>
						<div field="vcIndustry" headerAlign="center" allowSort="true" visible="false">
                           所属行业
                        </div>
                        <div field="vcIssueAppraiseCsrcName" headerAlign="center" allowSort="true">
                           所属行业
                        </div>
                        <div field="vcIssueProperty" headerAlign="center" allowSort="true" renderer="renderProperty" >
                           主体类型
                        </div>
                        <div name="cSource" field="cSource" headerAlign="center" allowSort="true" renderer="renderCSource" >
                           数据来源
                        </div>
                    </div>
                </div>
             </div>
         </div>
         <div title="债券详情" region="south" showSplit="false" height="135" showHeader="true" showSplitIcon="true" expanded="false">
			<div id="dataform1" style="margin-right:15px">
            	<table id="table2" border="0" cellpadding="1" cellspacing="2" style="width:100%;table-layout:fixed;">	
            		<tr>
						<td  align="right">
					债券简称:
						</td>
						<td style="width:15%" align="left">
							<input class="nui-textbox" name="vcStockName" inputStyle="background-color:#f0f0f0;"  readonly="readonly" width="100%"/>
						</td>
						<td  align="right">
					债券类别:
						</td>
						<td style="width:15%" align="left">
							<input class="nui-textbox" id="infoCStockType" inputStyle="background-color:#f0f0f0;"  name="vcStocktypeName" readonly="readonly" width="100%"/>
						</td>
						<td  align="right">
			                        起息日:
						</td>
						<td style="width:15%" align="left">
							<input class="nui-datepicker" id="lBegincalDate" inputStyle="background-color:#f0f0f0;" name="lBegincalDate" format="yyyy-MM-dd" readonly="readonly" width="100%"/>
						</td>
						<td  align="right">
				                        到期日:
						</td>
						<td  style="width:15%" align="left">
							<input class="nui-datepicker" id="lEndincalDate" inputStyle="background-color:#f0f0f0;" name="lEndincalDate" readonly="readonly" width="100%"/>
						</td>
					</tr>
					<tr>
						<td align="right">
			                        债券期限(年):
						</td>
						<td align="left"> 
							<input  id="enExistLimite" class="nui-textbox" inputStyle="background-color:#f0f0f0;" name="enExistLimite" readonly="readonly" width="100%"/>
						</td>
						<td align="right" >
			                        付息频率(次/年):
						</td>
						<td align="left">
							<input class="nui-dictcombobox" id="enPayInteval" inputStyle="background-color:#f0f0f0;" allowInput="true" valueFromSelect="false" dictTypeId="ATS_CF_JY_FREQUENCY" readonly="readonly"  name="enPayInteval"  width="100%"/>
						</td>
						<td align="right">
			                        票面利率(%):
						</td>
						<td align="left">
							<input class="nui-textbox" id="enFaceRate" name="enFaceRate"  inputStyle="background-color:#f0f0f0;" readonly="readonly" width="100%"/>
						</td>
						<td align="right">
			                        利率类型:
						</td>
						<td align="left">
							<input class="nui-dictcombobox" dictTypeId="rateType" inputStyle="background-color:#f0f0f0;" name="cInterestType" readonly="readonly" width="100%"/>
						</td>
					</tr>
					<tr>
						<td align="right">
			                        是否具有回售权:
						</td>
						<td align="left">
							<input class="nui-dictcombobox" inputStyle="background-color:#f0f0f0;" dictTypeId="COF_YESORNO" id="cIsHaveSaleback" 
								name="cIsHaveSaleback" readonly="readonly" width="100%"/>
						</td>
						<td align="right">
			                        债券评级:
						</td>
						<td align="left">
							<input class="nui-dictcombobox" inputStyle="background-color:#f0f0f0;" dictTypeId="creditRating" name="cBondAppraise" id="cBondAppraise" readonly="readonly" width="100%"/>
						</td>
						<td align="right">
			                        主体评级:
						</td>
						<td align="left">
							<input class="nui-dictcombobox" inputStyle="background-color:#f0f0f0;" dictTypeId="issuerRating" name="cIssueAppraise" readonly="readonly" width="100%"/>
						</td>
						<td align="right">
			                        公告日期:
						</td>
						<td align="left">
							<input class="nui-datepicker" id="lIssuePostDate"  name="lIssuePostDate" inputStyle="background-color:#f0f0f0;" readonly="readonly" width="100%"/>
						</td>
					</tr>
				</table>
			  </div>
		</div>
	</div>
            	 <!-- 新债信息表下载  -->
		<form id="word_download" method="post">
			<!-- 数据实体的名称 -->
			<input class="nui-hidden" name="bizId"  id="bizId2"/>
			<!-- 下载方式：1是投资指令/建议管理里下载，否则为审批页面下载 -->
			<input class="nui-hidden" name="type"  id="type" value="2"/>
			<!-- 债券类别 -->
			<input class="nui-hidden" name="vcStockType"  id="vcStockType2"/>
		</form>
        <script type="text/javascript">
            nui.parse();
            var grid = nui.get("datagrid1");
			
			var zhTzjl = checkRole("ATS_JS_ZH_TZJL");
			var zhJyy = checkRole("ATS_JS_ZH_JYY");
			//交易管理页面隐藏投资意向列展示 或者 非招行投资经理且非招行交易员
			var pageFlag = '${param.page}';
			if(pageFlag=="jygl"){	//交易管理
				var column = grid.getColumn("cIsIntention");	//投资意向
				grid.hideColumn(column);
			}else{	//投资管理
				if(!zhTzjl && !zhJyy){
					var column = grid.getColumn("cIsIntention");	//投资意向
					grid.hideColumn(column);
				}
				var column = grid.getColumn("cSource");	//数据来源
				grid.hideColumn(column);
			}
			//查看招行导入的草稿数据权限
			if("jygl"==pageFlag || zhTzjl || zhJyy){
				nui.get("cSource").setValue("9");
			}

			//给业务日期查询条件赋值
			nui.get("processDate").setValue((new Date()));
            var formData = new nui.Form("#form1").getData(false,false);
            grid.load(formData);//加载列表数据
             $("#dataform1 .mini-buttonedit-buttons").remove();
		     $("#dataform1 .mini-buttonedit-border").css("background-color","#f0f0f0");
			//var stockTypeAll=null;//定义债券存储变量
			 loadStockTypeAll();
             //加载所有的债券信息
             function loadStockTypeAll(){
             	
             	nui.ajax({
				    url: "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext",
				    type: "post",
				    dataType:"json",
				    success: function (text) {
				    	//var vcStockType = nui.get("queryVcStockType");
				    	nui.get("queryVcStockType").loadList(text.data);
				    	//stockTypeAll=text.data;
				    	
				    }
				});
             	
             }
             //加载非权限标签的 按钮权限
             var result=null;
             nui.ajax({
					url:"com.cjhxfund.ats.fm.comm.common.queryMenuList.biz.ext",
		            type:'POST',
		            data:{funcCode:"ATS_YJZ_YJSG,ATS_YJZ_ZLJK"},
		            cache:false,
		            contentType:'text/json',
		            success:function(text){
		            	result = nui.decode(text.treeNodes);
		            	
			        }
			 });
			//渲染行对象
			 grid.on("drawcell", function (e) {
	            var record = e.record,
		        column = e.column,
		        row=e.row;
		        
		        /*field = e.field,
		        value = e.value;*/
		        
		         if(result==null){
		         	//等待ajax回传对象
		         	setTimeout(function(){
		        //action列，超连接操作按钮
		        if (column.name == "action") {
		            e.cellStyle = "text-align:left";
				            e.cellHtml = "";
				            var yjsg="",zljk="";
				            //判别权限
				            for(var k=0;k<result.length;k++){
			        			if(result[k].RES_ID=="ATS_YJZ_YJSG" && yjsg==""){
									yjsg =  "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='add(\"" + grid.indexOf(row) + "\")'>申购</a>&nbsp;";
								}
								if(result[k].RES_ID=="ATS_YJZ_ZLJK" && zljk==""){
									zljk =  "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;' onclick='addPaymentOne(\"" + grid.indexOf(row) + "\")'>缴款</a>&nbsp;";
								}
							}
							e.cellHtml=e.cellHtml+yjsg+zljk;//组装字符串
							e.cellHtml = e.cellHtml+"<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;' onclick='details()'>详情</a>&nbsp;";
							//lAttchCount
							//显示附件图标
							if( row.lAttchCount >0){
								e.cellHtml +="<img style='vertical-align:middle;' height='12px' src='<%=request.getContextPath() %>/fm/comm/img/fujian.png'>";
							}
		        }
		        //设置行样式
		        if (record.gender == 1) {
		            e.rowCls = "myrow";
		        }
		         	},1000);
		         }else{
		         	//action列，超连接操作按钮
			        if (column.name == "action") {
			            e.cellStyle = "text-align:left";
			            e.cellHtml = "";
			            var yjsg="",zljk="";
			           //判别权限
			            for(var k=0;k<result.length;k++){
		        			if(result[k].RES_ID=="ATS_YJZ_YJSG" && yjsg==""){
								yjsg =  "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;'  onclick='add(\"" + grid.indexOf(row) + "\")'>申购</a>&nbsp;";
							}
							if(result[k].RES_ID=="ATS_YJZ_ZLJK" && zljk==""){
								zljk =  "<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;' onclick='addPaymentOne(\"" + grid.indexOf(row) + "\")'>缴款</a>&nbsp;";
							}
						}
						e.cellHtml=e.cellHtml+yjsg+zljk;//组装字符串
						e.cellHtml = e.cellHtml+"<a class='nui-button' plain='false' style='cursor:pointer;text-decoration:underline;' onclick='details()'>详情</a>&nbsp;";
						//lAttchCount
						//显示附件图标
						if( row.lAttchCount >0){
							e.cellHtml +="<img style='vertical-align:middle;' height='12px' src='<%=request.getContextPath() %>/fm/comm/img/fujian.png'>";
						}
			        }
			        //设置行样式
			        if (record.gender == 1) {
			            e.rowCls = "myrow";
			        }
		         }
			        		
	        	
        	});
	        function edit(rowid) {
	            alert("编辑: " + rowid);
	        }
	        function del(rowid) {
	            alert("删除: " + rowid);
	        }
	        //交易场所,改变后更新债券类型
		    function onMarketValueChanged(e){
		    	
		        var cMarketNo=e.value;
		        //转换托管机构为交易市场
		        if(cMarketNo==3){
		        	cMarketNo=1;
		        }else if(cMarketNo==4){
		        	cMarketNo=2;
		        }else{
		        	cMarketNo=5;
		        }
		     	/*var vcStockType = mini.get("queryVcStockType");
		        vcStockType.setValue("");
	            var url = "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext?cMarketNo=" + cMarketNo;
	            vcStockType.setUrl(url);*/
	            
		    } 
	        //债券申购
	        function addNoBond(){
	        	nui.open({
		                    url: "<%=request.getContextPath() %>/fm/instr/firstGradeDebt/noBondApplyPurchase.jsp",
		                    title: "债券申购(非可转债)录入", width: 1100, height: 700,
		                    onload: function () {
		                        //弹出页面加载完成
			                    var iframe = this.getIFrameEl();
			                    //var data = {pageType:"add",lStockIssueId:row.lStockIssueId};//传入页面的json数据
			                    iframe.contentWindow.loadData();
		                    },
		                    ondestroy: function (action) {//弹出页面关闭前
		                    //刷新页面
	             			grid.reload();
		                    nui.get("details").enable();
		                }
		            });
	        }
	        //单个申购
	        function add(id){
	        	//获取当前行
	        	var index=parseInt(id);
	        	var row=grid.getRow(index);
	        	
	        	if(row){
	        	    var lIssueBeginDate= dateTemp(row.lIssueBeginDate);//发行日期
	        		lIssueBeginDate=Date.parse(new Date(lIssueBeginDate.replace(/-/g,"/")));
            		var lPayDate = dateTemp(row.lPayDate);//缴款日期
            		lPayDate=Date.parse(new Date(lPayDate.replace(/-/g,"/")));
					//获取的当前时间毫秒数 .getTime() 和  Date.parse（） 作用一样
					var lData = (new Date()).getTime()-86400000;
					//判断缴款日期为当天发起缴款
					var formatData = new Date();
					var sformatData = formatData.getFullYear()+""+(formatData.getMonth()+1)+""+formatData.getDate();
					if(row.lPayDate != "" && row.lPayDate != null){
						if(sformatData == row.lPayDate){
								nui.confirm("债券["+row.vcStockNameFull+"]现为缴款当天，是否发起缴款流程?","申购提醒",function(action){
		            				if(action=="ok"){
		            					nui.open({
							                    url: "<%=request.getContextPath() %>/fm/instr/firstGradePayment/payMentPurchase.jsp",
							                    title: "分销缴款(非可转债)录入", width: 1100, height: 700,
							                    onload: function () {//弹出页面加载完成
							                    var iframe = this.getIFrameEl();
							                    var data = {pageType:"add",lStockIssueId:row.lStockIssueId};//传入页面的json数据
							                        iframe.contentWindow.setFormDataPayMent(data);
							                    },
							             });
		            				}else{
		            					if(lPayDate!="" && lPayDate!=null && lData>lPayDate){
					            			nui.alert("债券["+row.vcStockNameFull+"]已过缴款日，请联系交易员更新债券信息");
					            			return;
					            		}
					            		if(lIssueBeginDate!="" && lIssueBeginDate!=null && lData>lIssueBeginDate){
					            			nui.confirm("债券["+row.vcStockNameFull+"]已过发行日，是否发起缴款流程?","申购提醒",function(action){
					            				if(action=="ok"){
					            					addPayment();
					            				}
					            			});
					            			return;
					            		}
		            					nui.open({
							                    url: "<%=request.getContextPath() %>/fm/instr/firstGradeDebt/noBondApplyPurchase.jsp",
							                    title: "债券申购(非可转债)录入", width: 1100, height: 700,
							                    onload: function () {//弹出页面加载完成
							                    var iframe = this.getIFrameEl();
							                    var data = {pageType:"add",lStockIssueId:row.lStockIssueId};//传入页面的json数据
							                    iframe.contentWindow.setFormData(data);
							                    },
							                    ondestroy: function (action) {//弹出页面关闭前
							                    //刷新页面
						             			grid.reload();
						             			nui.get("details").enable();
							                    
							                }
							             });
		            				}
            				});
				             return;
						}
					}
					if(lPayDate!="" && lPayDate!=null && lData>lPayDate){
            			nui.alert("债券["+row.vcStockNameFull+"]已过缴款日，请联系交易员更新债券信息");
            			return;
            		}
            		if(lIssueBeginDate!="" && lIssueBeginDate!=null && lData>lIssueBeginDate){
            			nui.confirm("债券["+row.vcStockNameFull+"]已过发行日，是否发起缴款流程?","申购提醒",function(action){
            				if(action=="ok"){
            					addPayment();
            				}
            			});
            			return;
            		}
					nui.open({
		                    url: "<%=request.getContextPath() %>/fm/instr/firstGradeDebt/noBondApplyPurchase.jsp",
		                    title: "债券申购(非可转债)录入", width: 1100, height: 700,
		                    onload: function () {//弹出页面加载完成
		                    var iframe = this.getIFrameEl();
		                    var data = {pageType:"add",lStockIssueId:row.lStockIssueId};//传入页面的json数据
		                    iframe.contentWindow.setFormData(data);
		                    },
		                    ondestroy: function (action) {//弹出页面关闭前
		                    //刷新页面
	             			grid.reload();
	             			nui.get("details").enable();
		                    
		                }
		             });
	             }else{
	             	nui.alert("请选择一条债券。","提示");
	             }
	        }
            //批量申购
            function addAll() {
            	var rows = grid.getSelecteds();
            	if(rows.length>0){
	                openApplyPurchase(rows,0);
                 }else{
    				addNoBond();
    			} 
            }
            //循环打开页面
            function openApplyPurchase(rows,i){
              //传入的数据不为空 这需要打开新的页面
            	if(rows.length>i){
            	    var lPayDate = dateTemp(rows[i].lPayDate);//缴款日期
            		lPayDate=Date.parse(new Date(lPayDate.replace(/-/g,"/")));
            	    var lIssueBeginDate= dateTemp(rows[i].lIssueBeginDate);//发行日期
            		lIssueBeginDate=Date.parse(new Date(lIssueBeginDate.replace(/-/g,"/")));

					//获取的当前时间毫秒数 .getTime() 和  Date.parse（） 作用一样
					var lData = (new Date()).getTime()-86400000;
					//判断缴款日期为当天发起缴款
					var formatData = new Date();
					var sformatData = formatData.getFullYear()+""+(formatData.getMonth()+1)+""+formatData.getDate();
					if(rows[i].lPayDate != "" && rows[i].lPayDate != null){
						if(sformatData == rows[i].lPayDate){
								nui.confirm("【"+(i+1)+"/"+rows.length+"】债券["+rows[i].vcStockNameFull+"]现为缴款当天，是否发起缴款流程?","申购提醒",function(action){
		            				if(action=="ok"){
		            					nui.open({
							                    url: "<%=request.getContextPath() %>/fm/instr/firstGradePayment/payMentPurchase.jsp",
							                    title: "分销缴款(非可转债)录入-【"+(i+1)+"/"+rows.length+"】", width: 1100, height: 700,
							                    onload: function () {//弹出页面加载完成
							                    var iframe = this.getIFrameEl();
							                    var data = {pageType:"add",lStockIssueId:rows[i].lStockIssueId};//传入页面的json数据
							                        iframe.contentWindow.setFormDataPayMent(data);
							                    },
							                    ondestroy: function (action) {//弹出页面关闭前
							                    	//关闭页面时 回调下一个界面
							                    	openApplyPurchase(rows,i+1);
							                }
							             });
		            				}else{
		            				   if(lPayDate!="" && lPayDate!=null && lData>lPayDate){
										    //批量申购时，只有一条数据或者最后一条数据改变提示
										    if(rows.length==1 || rows.length-1==i){
										      nui.confirm("【"+(i+1)+"/"+rows.length+"】债券["+rows[i].vcStockNameFull+"]已过缴款日,请联系交易员更新新债信息","申购提醒",function(action){
						        				if(action=="ok"){
						        				   //点确定时回调下一条数据
						        				   openApplyPurchase(rows,i+1);
						        				}else{
						        				   return;
						        				}
						        			  });
										    }else{
										      nui.confirm("【"+(i+1)+"/"+rows.length+"】债券["+rows[i].vcStockNameFull+"]已过缴款日,是否进行下一条?","申购提醒",function(action){
						        				if(action=="ok"){
						        				   //点确定时回调下一条数据
						        				   openApplyPurchase(rows,i+1);
						        				}else{
						        				   return;
						        				}
						        			  });
										    }
					            			return;
					            		}
					       		
					            		if(lIssueBeginDate!="" && lIssueBeginDate!=null && lData>lIssueBeginDate){
					            			nui.confirm("【"+(i+1)+"/"+rows.length+"】债券["+rows[i].vcStockNameFull+"]已过发行日，是否发起缴款流程?","申购提醒",function(action){
					            				if(action=="ok"){
					            					nui.open({
										                    url: "<%=request.getContextPath() %>/fm/instr/firstGradePayment/payMentPurchase.jsp",
										                    title: "分销缴款(非可转债)录入-【"+(i+1)+"/"+rows.length+"】", width: 1100, height: 700,
										                    onload: function () {//弹出页面加载完成
										                    var iframe = this.getIFrameEl();
										                    var data = {pageType:"add",lStockIssueId:rows[i].lStockIssueId};//传入页面的json数据
										                        iframe.contentWindow.setFormDataPayMent(data);
										                    },
										                    ondestroy: function (action) {//弹出页面关闭前
										                    	//关闭页面时 回调下一个界面
										                    	openApplyPurchase(rows,i+1);
										                }
										             });
					            				}else{
					            				   //点取消时回调下一条数据
					            				   openApplyPurchase(rows,i+1);
					            				}
					            			});
					            			return;
					            		}
						            	nui.open({
							                    url: "<%=request.getContextPath() %>/fm/instr/firstGradeDebt/noBondApplyPurchase.jsp",
							                    title: "债券申购(非可转债)录入-【"+(i+1)+"/"+rows.length+"】", width: 1100, height: 700,
							                    onload: function () {//弹出页面加载完成
							                    var iframe = this.getIFrameEl();
							                    var data = {pageType:"add",lStockIssueId:rows[i].lStockIssueId};//传入页面的json数据
							                    iframe.contentWindow.setFormData(data);
							                    },
							                    ondestroy: function (action) {//弹出页面关闭前
							                    	//关闭页面时 回调下一个界面
							                    	openApplyPurchase(rows,i+1);
							                }
							             });
		            				}
            				});       
							return;
						}
					}
					if(lPayDate!="" && lPayDate!=null && lData>lPayDate){
					    //批量申购时，只有一条数据或者最后一条数据改变提示
					    if(rows.length==1 || rows.length-1==i){
					      nui.confirm("【"+(i+1)+"/"+rows.length+"】债券["+rows[i].vcStockNameFull+"]已过缴款日,请联系交易员更新新债信息","申购提醒",function(action){
	        				if(action=="ok"){
	        				   //点确定时回调下一条数据
	        				   openApplyPurchase(rows,i+1);
	        				}else{
	        				   return;
	        				}
	        			  });
					    }else{
					      nui.confirm("【"+(i+1)+"/"+rows.length+"】债券["+rows[i].vcStockNameFull+"]已过缴款日,是否进行下一条?","申购提醒",function(action){
	        				if(action=="ok"){
	        				   //点确定时回调下一条数据
	        				   openApplyPurchase(rows,i+1);
	        				}else{
	        				   return;
	        				}
	        			  });
					    }
            			return;
            		}
       		
            		if(lIssueBeginDate!="" && lIssueBeginDate!=null && lData>lIssueBeginDate){
            			nui.confirm("【"+(i+1)+"/"+rows.length+"】债券["+rows[i].vcStockNameFull+"]已过发行日，是否发起缴款流程?","申购提醒",function(action){
            				if(action=="ok"){
            					nui.open({
					                    url: "<%=request.getContextPath() %>/fm/instr/firstGradePayment/payMentPurchase.jsp",
					                    title: "分销缴款(非可转债)录入-【"+(i+1)+"/"+rows.length+"】", width: 1100, height: 700,
					                    onload: function () {//弹出页面加载完成
					                    var iframe = this.getIFrameEl();
					                    var data = {pageType:"add",lStockIssueId:rows[i].lStockIssueId};//传入页面的json数据
					                        iframe.contentWindow.setFormDataPayMent(data);
					                    },
					                    ondestroy: function (action) {//弹出页面关闭前
					                    	//关闭页面时 回调下一个界面
					                    	openApplyPurchase(rows,i+1);
					                }
					             });
            				}else{
            				   //点取消时回调下一条数据
            				   openApplyPurchase(rows,i+1);
            				}
            			});
            			return;
            		}
	            	nui.open({
		                    url: "<%=request.getContextPath() %>/fm/instr/firstGradeDebt/noBondApplyPurchase.jsp",
		                    title: "债券申购(非可转债)录入-【"+(i+1)+"/"+rows.length+"】", width: 1100, height: 700,
		                    onload: function () {//弹出页面加载完成
		                    var iframe = this.getIFrameEl();
		                    var data = {pageType:"add",lStockIssueId:rows[i].lStockIssueId};//传入页面的json数据
		                    iframe.contentWindow.setFormData(data);
		                    },
		                    ondestroy: function (action) {//弹出页面关闭前
		                    	//关闭页面时 回调下一个界面
		                    	openApplyPurchase(rows,i+1);
		                }
		             });
	             }else{
	             	//刷新页面
	             	grid.reload();
	             	nui.get("details").enable();
	             }
            }
            /*指令/建议缴款*/
		   function addPayment(){
	   		   var rows = grid.getSelecteds();
	    	   if(rows.length>0){
	           	  openApplyPurchase1(rows,0);
	           }else{
				  nui.open({
		                    url: "<%=request.getContextPath() %>/fm/instr/firstGradePayment/payMentPurchase.jsp",
		                    title: "分销缴款(非可转债)录入", width: 1100, height: 700,
		                    onload: function () {//弹出页面加载完成
		                    //无债券缴款
		                    var iframe = this.getIFrameEl();
		                     //var data = {pageType:"add",lStockIssueId:rows[i].lStockIssueId};//传入页面的json数据
		                     iframe.contentWindow.setFormDataPayMentNo();
		                    },
		                    ondestroy: function (action) {//弹出页面关闭前
		                    	//关闭页面时 回调下一个界面	
		                    //	openApplyPurchase(rows,i+1);
		                }
		             });
			   } 
		   }
		   //单个缴款
	       function addPaymentOne(id){
	        	//获取当前行
	        	var index=parseInt(id);
	        	var row=grid.getRow(index);
	        	if(row){
            		var lPayDate = dateTemp(row.lPayDate);//缴款日期
            		lPayDate=Date.parse(new Date(lPayDate.replace(/-/g,"/")));
					//获取的当前时间毫秒数 .getTime() 和  Date.parse（） 作用一样
					var lData = (new Date()).getTime()-86400000;
            		if(lPayDate!="" && lPayDate!=null && lData>lPayDate){
            			nui.alert("债券["+row.vcStockNameFull+"]已过缴款日，请联系交易员更新债券信息");
            			return;
            		}
	            	nui.open({
		                    url: "<%=request.getContextPath() %>/fm/instr/firstGradePayment/payMentPurchase.jsp",
		                    title: "分销缴款(非可转债)录入", width: 1100, height: 700,
		                    onload: function () {//弹出页面加载完成
		                    var iframe = this.getIFrameEl();
		                    var data = {pageType:"add",lStockIssueId:row.lStockIssueId};//传入页面的json数据
		                    iframe.contentWindow.setFormDataPayMent(data);
		                    },
		                    ondestroy: function (action) {//弹出页面关闭前
			                    //刷新页面
		             			grid.reload();
		             			nui.get("details").enable();
		                    }
		             });
	             }else{
	             	nui.alert("请选择一条债券。","提示");
	             }
	        }
		   //循环打开页面
            function openApplyPurchase1(rows,i){
            	//传入的数据不为空 这需要打开新的页面
            	if(rows.length>i){
        	        var lPayDate = dateTemp(rows[i].lPayDate);//缴款日期
            		lPayDate=Date.parse(new Date(lPayDate.replace(/-/g,"/")));
					//获取的当前时间毫秒数 .getTime() 和  Date.parse（） 作用一样
					var lData = (new Date()).getTime()-86400000;
            		if(lPayDate!="" && lPayDate!=null && lData>lPayDate){
            			//批量申购时，只有一条数据或者最后一条数据改变提示
					    if(rows.length==1 || rows.length-1==i){
					      nui.confirm("【"+(i+1)+"/"+rows.length+"】债券["+rows[i].vcStockNameFull+"]已过缴款日,请联系交易员更新新债信息","申购提醒",function(action){
	        				if(action=="ok"){
	        				   //点确定时回调下一条数据
	        				   openApplyPurchase1(rows,i+1);
	        				}else{
	        				   return;
	        				}
	        			  });
					    }else{
					      nui.confirm("【"+(i+1)+"/"+rows.length+"】债券["+rows[i].vcStockNameFull+"]已过缴款日,是否进行下一条?","申购提醒",function(action){
	        				if(action=="ok"){
	        				   //点确定时回调下一条数据
	        				   openApplyPurchase1(rows,i+1);
	        				}else{
	        				   return;
	        				}
	        			  });
					    }
	        			return;
            		}
	            	nui.open({
		                    url: "<%=request.getContextPath() %>/fm/instr/firstGradePayment/payMentPurchase.jsp",
		                    title: "分销缴款(非可转债)录入-【"+(i+1)+"/"+rows.length+"】", width: 1100, height: 700,
		                    onload: function () {//弹出页面加载完成
		                    var iframe = this.getIFrameEl();
		                    var data = {pageType:"add",lStockIssueId:rows[i].lStockIssueId};//传入页面的json数据
		                    iframe.contentWindow.setFormDataPayMent(data);
		                    },
		                    ondestroy: function (action) {//弹出页面关闭前
		                    	//关闭页面时 回调下一个界面
		                    	openApplyPurchase1(rows,i+1);
		                }
		             });
	             }else{
	             	//刷新页面
	             	grid.reload();
	             	nui.get("details").enable();
	             }
            }
           //重新刷新页面
           function refresh(){
               var form = new  nui.Form("#form1");
               var json = form.getData(false,false);
               grid.load(json);//grid查询
               nui.get("update").enable();
           }
           //字符串截取日期
			function getSubstr(str){
				var str1=str.substr(0,10);//0开始，截取后面4位 
			 	return str1;
			}
           //查询
           function search() {
              //判定是否是否合法
             var processDate_stop = getSubstr(nui.get("processDate_stop").getValue());
             var processDate = getSubstr(nui.get("processDate").getValue());
            // startdata.replace(/-/g,"/")
             if(processDate_stop!="" && processDate!="" && processDate_stop!=processDate){
             	var d= Date.parse(processDate_stop.replace(/-/g,"/"))>Date.parse(processDate.replace(/-/g,"/"));
             	if(d==false){
             		nui.alert("查询截止日期小于起始日期");
             		return;
             	}
             }
             var vcStockName = nui.get("vcStockName").value;
             nui.get("vcStockNameFull").setValue(vcStockName);
              var form = new nui.Form("#form1");
              var json = form.getData(false,false);
              var dataForm1 = new nui.Form("#dataform1");
        	   dataForm1.reset();//清除明细信息
              grid.load(json);//grid查询
            }

            //重置查询条件
            function reset(){
               var form = new nui.Form("#form1");//将普通form转为nui的form
               form.reset();
               search();
            }
            
             //当选择列时
		     function selectionChanged(){
		        var rows = grid.getSelecteds();
		        
		        if(rows.length>1){
		               nui.get("details").disable();
		               nui.get("appraise").disable();
		        }else{
		               nui.get("details").enable();
		               nui.get("appraise").enable();
		        }
		    } 

            //enter键触发查询
            function onKeyEnter(e) {
                search();
            }
             
             //主体评级
             function renderSubjectrating(e){
               return nui.getDictText("issuerRating",e.row.cIssueAppraise);
             } 
             //定义交易市场
             //var Genders=[{ID:1,TEXT:'上交所'},{ID:2,TEXT:'深交所'},{ID:5,TEXT:'银行间'}];
             function renderCMarketNo(e){
             	 /*for (var i = 0, l = Genders.length; i < l; i++) {
	                var g = Genders[i];
	                if (g.ID == e.value) return g.TEXT;
	            }CF_JY_DJTGCS
	            return "";*/
	            return nui.getDictText("CF_JY_DJTGCS",e.row.vcPaymentPlace);
             }
             function renderBeginDate(e){
             	if(e.value=="0"  || e.value==null){
             		return "";
             	}
             	return dateTemp(e.value);
             }
             //时间转换
	    	function dateTemp(oldData){
	    		oldData=oldData+"";
	    		if(oldData==0 || oldData=="" || oldData=="null"){
	    			return "";
	    		}
	    		
	    		var datas=oldData.indexOf("-");
	    		if(datas>=0){
	    			return oldData;
	    		}
	    		var yy=oldData.substr(0,4);//0开始，截取后面4位
	    		var mm=oldData.substr(4,2);//4开始，截取后面2位
	    		var dd=oldData.substr(6,2);
	    		
	    		return yy+"-"+mm+"-"+dd;
	    	}
             //评级机构
             function renderRatingagencies(e){
               return nui.getDictText("outRatingOrgan",e.row.vcBondAppraiseOrgan);
             }
             
             //是否具有回售权
             function renderresaleRight(e){
               return nui.getDictText("COF_YESORNO",e.row.resaleRight);
             }
             //企业性质
             function renderProperty(e){
             	return nui.getDictText("ATS_FM_ISSUE_PROPERTY",e.row.vcIssueProperty);
             
             }
             //是否具有回售权
             function renderredemptionRight(e){
               return nui.getDictText("COF_YESORNO",e.row.redemptionRight);
             }
             
             //数据来源
             function renderCSource(e){
             	return nui.getDictText("ATS_FM_STOCKSOURCE", e.row.cSource);
             }
             
             function ButtonClickGetFundName_ZJTC(e){
			   	ButtonClickGetFundName(this,'<%=request.getParameter("jurisdiction")%>');
			}   
			
			//详细信息
    		function details(){
    			//暂停200毫秒 防止比选中事件先触发，
    			setTimeout(function(){
    				var row = grid.getSelected();
	    			 if(row){ 
						nui.open({
		                    url: "<%=request.getContextPath() %>/fm/baseinfo/firstGradeDebt/debtIssueQueryDetail.jsp?lStockIssueId="+row.lStockIssueId,
		                    title: "详细信息", 
		                    width: 980, 
		           			height: 700,
		                    //allowResize:false,
		                    onload: function () {
		                        var iframe = this.getIFrameEl();
		                        iframe.contentWindow.initForm();
		                    },
		                    ondestroy: function (action) {
		                        if(action=="saveSuccess"){
			                        grid.reload();
		                   	 	}
		                    }
		                });
	    			 }else{
	    				nui.alert("请选择一条债券。","提示");
	    			} 
    			},200);
    			
    		}
    		//新债信息对比
    		function compare(){
    			 var rows = grid.getSelecteds();
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

    		//时间转换
	    	function dateTemp(oldData){
	    		oldData=oldData+"";
	    		if(oldData==0 || oldData=="" || oldData=="null"){
	    			return "";
	    		}
	    		
	    		var datas=oldData.indexOf("-");
	    		if(datas>=0){
	    			return oldData;
	    		}
	    		var yy=oldData.substr(0,4);//0开始，截取后面4位
	    		var mm=oldData.substr(4,2);//4开始，截取后面2位
	    		var dd=oldData.substr(6,2);
	    		
	    		return yy+"-"+mm+"-"+dd;
	    	}
    		//行双击时重新设置tabs页面参数
			grid.on("rowclick", function (e) {
			
	            //var data = {cfjybusinessbonetable:{btId:e.row.btId}};
				/*var json = nui.encode(data);*/
				//console.log(e.row);
				var form = new nui.Form("#dataform1");//将普通form转为nui的form
				e.row.lBegincalDate=dateTemp(e.row.lBegincalDate);
				e.row.lEndincalDate=dateTemp(e.row.lEndincalDate);
				e.row.lIssuePostDate=dateTemp(e.row.lIssuePostDate);
				
				//enFaceRate
				form.setData(e.row);
				//处理付息频率，值满足数据字典则直接显示数据字典中对应值，否则直接显示值
				if(nui.get("enPayInteval").getText()=="" || nui.get("enPayInteval").getText()==null){
					nui.get("enPayInteval").setText(e.row.enPayInteval);
				}				
            });
            
            //历史评级 
            function bondAppraise(){
		       	var row = grid.getSelected();
		        if (row) {
		            if(row.cSource == '手工录入'){
		   				row.cSource = '1';
		   			}else if(row.cSource == '批量导入'){
		   				row.cSource = '2';
		   			}else if(row.cSource == 'O32数据'){
		   				row.cSource = '3';
		   			}else if(row.cSource == 'wind数据'){
		   				row.cSource = '4';
		   			}
		              nui.open({
		                    url: "<%=request.getContextPath() %>/fm/baseinfo/intfStockInfoQuery/getBondAppraise.jsp",
		                    title: "新债历史评级", 
		                    width: 700, 
		           			height: 500,
		                    onload: function () {
		                        var iframe = this.getIFrameEl();
		                        var data = row;
		                        iframe.contentWindow.SetData(data);
		                    }
		                });
		        } else {
		                nui.alert("请选中一条记录");
		            }
		            
		            
		       }
			function reloadData(){
				grid.reload();
			}
			
			//word文档下载
		    function wordDownload1(){
		       var row = grid.getSelected();
		        if (row) {
			    	var bizId=row.lBizId;
			    	nui.get("bizId2").setValue(bizId);
			    	
			    	//下载附件
			    	nui.confirm("确认要下载吗？","系统提示",function(action){
						if(action=="ok"){
							var form = document.getElementById("word_download");
							form.action = "com.cjhxfund.foundation.task.wordDownloadNoProcess.flow?vcStockCode="+row.vcStockCode;
					        form.submit();
						}
					});
				} else {
		            nui.alert("请选中一条指令/建议!");
		            return false;
		        }
		    }
		    
		    //投资意向列
		    function rendererIsIntention(e){
		    	var onclick = '';
		    	var cursor = '';
		    	var title = '';
		    	var imgPath = '/fm/instr/images/heart0.png';
		    	var status = '1';
		    	if(e.row.cIsIntention!=null && e.row.cIsIntention!=""){
	    			imgPath = '/fm/instr/images/heart1.png';
	    			status = 0;
		    	}
		    	if(zhTzjl){	//招行投资经理
		    		onclick='onclick="saveInstention('+status+', '+e.row.lStockIssueId+', '+e.rowIndex+')"';
		    		cursor= 'cursor: pointer;';
		    	}
		    	if(zhJyy && e.row.cIsIntention){	//招行交易员
		    		title = 'title="' + e.row.cIsIntention +'"';
		    	}
		    	
	    		return '<a '+onclick+' '+title+' style="background: url('+nui.context+imgPath+');'
				            +'background-size:21px 15px;background-repeat:no-repeat; padding-left: 20px; '+cursor+'"></a>';
		    }
		    
		    //保存投资意向信息
		    function saveInstention(cIsIntention, lStockIssueId, rowIndex){
		    	var timeFlag = false;//是否超时限
		    	var row = grid.getRow(rowIndex);
		    	var date = new Date();
		    	
		    	//如果为公告日当天的
		    	var intNowDate = date.Format("yyyyMMdd");
		    	var rowDate = row.lIssuePostDate.replace(/-/g,"");
		    	if(intNowDate > rowDate + 1){ //T-2日
		    		timeFlag = true;
		    	}else if(intNowDate = rowDate + 1){
		    		nui.ajax({
						url : "com.cjhxfund.commonUtil.zhfwptparamconfbiz.getParamConf.biz.ext",
						type : 'POST',
						data : {paramKey:"ATS_FIRST_INVEST_TIME"},
						cache : false,
						contentType : 'text/json',
						async: false,
						success : function(text) {
							var time = text.paramConf.paramValue;
							var times = time.split(":");
							var cHours = date.getHours();
							var cMinute = date.getMinutes();
							if(times.length<3) timeFlag = false;
							else if(cHours>times[0]) timeFlag = true;
							else if(cHours==times[0]&&cMinute>times[1]) timeFlag = true;
						}
					 });
		    	}else{
		    		timeFlag = false;
		    	}// T / T > 0 
		    	
			 	//超时跳过
			 	if(timeFlag) {
					nui.alert("该债券在已超过选择投资意向时限！"); 
				 	return;
			 	}
				 
		    	nui.ajax({
					url : "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.saveStockIntention.biz.ext",
					type : 'POST',
					data : {cIsIntention:cIsIntention, lStockIssueId:lStockIssueId},
					cache : false,
					contentType : 'text/json',
					success : function(text) {
						var returnJson = nui.decode(text);
						if(returnJson.exception == null){
							row.cIsIntention = cIsIntention;
							grid.updateRow(row);
						}
					}
				 });
		    }
		    
		    //判断当前用户是否属于指定的角色
		    function checkRole(roleCode){
		    	var rtn = false;
		    	nui.ajax({
					url : "com.cjhxfund.fpm.bpsExpend.role.queryRoleByCurrUserId.biz.ext",
					type : 'POST',
					data : {roleCode:roleCode},
					cache : false,
					async: false,
					contentType : 'text/json',
					success : function(text) {
						var returnJson = nui.decode(text);
						if(returnJson.exception == null){
							if(returnJson.roleEmp!=null && returnJson.roleEmp.flag =="1"){
								rtn = true;	
							}
						}
					}
				 });
				 return rtn;
		    }
		    
		    function importStockIssue() {
				mini.open({
		    		url: nui.context + "/fm/instr/firstGradeDebt/importStockIssueInfoZH.jsp",
		    		title: "新债信息导入", width: 850, height: 540,
		    		overflow:"hidden",
		    		onload: function () {},
		    		ondestroy: function (action) {
		        		grid.reload();
		    		}
				});
    		}
    		
    		function exportStockIssue(){
				var rows = grid.getSelecteds();
				if(rows.length>0){
		        	var form = new nui.Form("#form1");
		            var json = form.getData(false,false);
		            json.param = {filename:"新债信息.xlsx",rulename:"STOCK_ISSUE_INFO_ZH_EXCEL_EXPORT",modename:"新债信息"};
		            json.stockIssueInfos = rows;
		            //json.sortField = grid.getSortField();
		            //json.sortOrder = grid.getSortOrder();
		            var tip = nui.loading("拼命导出中,请稍等...","提示");
		            nui.ajax({ 
		            	url:'com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.exportStockIssueInfo.biz.ext',
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
				}else{
					nui.alert("请选择要导出的债券！");
				}
	        }
		</script>
     </body>
</html>