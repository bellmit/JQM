<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
session="false" %>
<%@page import="com.cjhxfund.ats.fm.comm.FileDownload"%>
<%@page import="commonj.sdo.DataObject"%>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>
        <html>
            <!-- - Author(s): 胥思明 - Date: 2016-11-17 10:35:40 - Description: -->
            
            <head>
                <title>
                    申购附件信息
                </title>
                <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
            </head>
            
            <body style="width:100%;height:100%;overflow: hidden; margin: 0px;">
                <div class="search-condition">
                    <div class="list">
                        <div id="form1" class="nui-form" align="center" style="height: 10%">
                            <!-- 排序字段 -->
                            <form id="queryForm" action="">
                                <input class="nui-hidden" name="map/vcAttachType" value="1" width="100%"
                                />
                                <table id="table1" border="0" cellpadding="1" cellspacing="1" style="width: 100%; table-layout: fixed;">
                                    <tr>
                                        <td style="width: 60px" align="right">
                                            产品名称:
                                        </td>
                                        <td style="width:15%" align="left">
                                            <input style="width: 100%;" id="vcProductName" class="mini-combobox" name="map/vcProductName"
                                            textField="TEXT" valueField="TEXT" url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryTAtsProductInfo.biz.ext"
                                            showNullItem="false" allowInput="false" onvalidation="onComboValidation"
                                            showClose="true" oncloseclick="onCloseClickValueEmpty" />
                                        </td>
                                        <td style="width: 70px" align="right">
                                            登记托管机构:
                                        </td>
                                        <td style="width:15%" align="left">
                                            <input class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" valueField="dictID"
                                            textField="dictName" name="map/vcPaymentPlace" showClose="true" oncloseclick="onCloseClickValueEmpty"
                                            id="vcPaymentPlace" onvaluechanged="onMarketNoChanged" onblur="clearStockType"
                                            width="100%" />
                                        </td>
                                        <td style="width: 50px" align="right">
                                            债券全称:
                                        </td>
                                        <td style="width:15%" align="left">
                                            <input class="nui-textbox" id="vcStockNameFull" name="map/vcStockNameFull" width="100%"
                                            />
                                        </td>
                                        <td style="width: 50px" align="right">
                                            创建日期:
                                        </td>
                                        <td style="width:15%" align="left">
                                            <input class="nui-datepicker" format="yyyy-MM-dd" showClose="true" oncloseclick="onCloseClickValueEmpty"
                                            id="dCreateTime" name="map/dCreateTime" width="98%" />
                                        </td>
                                    </tr>
                                    <tr>
                                    	<td style="width: 60px" align="right">
                                            附件名称:
                                        </td>
                                        <td style="width:15%" align="left">
                                            <input class="nui-textbox" id=vcAttachName name="map/vcAttachName" width="100%"
                                            />
                                        </td>
                                        <td style="width: 70px" align="right">
                                          附件业务类型:
                                        </td>
                                        <td style="width:15%" align="left">
                                            <input class="nui-dictcombobox" dictTypeId="ATS_PROCESS_TYPE" valueField="dictID"
                                            textField="dictName" name="map/vcProcessType" id="vcProcessType" showClose="true" 
                                            oncloseclick="onCloseClickValueEmpty" onvaluechanged="onMarketNoChanged" width="100%" />
                                       </td>
                                        <td style="width: 60px" align="right">
                                            用户名称:
                                        </td>
                                        <td style="width:15%" align="left">
                                            <input class="nui-textbox" id="vcUserId" name="map/vcUserId" width="100%"
                                            />
                                        </td>
                                        <td align="right">
                                            <a class='nui-button' plain='false' iconCls="icon-search" onclick="search()">
                                                查询
                                            </a>
                                        </td>
                                        <td align="left">
                                            <a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
                                                重置
                                            </a>
                                        </td>
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
                                <span>
                                    &nbsp;
                                </span>
                                <privilege:operation sourceId="ATS_RW_YB_FJXZ" sid="fileDownload" clazz="nui-button"
                                onClick="fileDownload()" lableName="附件下载" iconCls="icon-download">
                                </privilege:operation>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="layout1" class="mini-layout" style="width:100%; height:87.5%;"
                borderStyle="border:solid 1px #aaa;">
                    <div title="center" region="center">
                        <div class="nui-fit">
                            <div id="datagrid1" class="nui-datagrid" data="data" style="width: 100%; height: 100%;"
                            url="com.cjhxfund.ats.fm.baseinfo.AttachManager.queryBondAttachInfoWithPage.biz.ext"
                            pageSize="20" onShowRowDetail="onShowRowDetailList" onselectionchanged="selectionChanged"
                            sortField="lAttachId" sortOrder="desc" vcType="1" showPageInfo="true" multiSelect="true">
                                <div property="columns">
                                    <div type="checkcolumn">
                                    </div>
                                    <div field="lWorkItemId" headerAlign="center" width="20px" allowSort="true"
                                    visible="false">
                                        工作项 编号
                                    </div>
                                    <div field="lBizId" headerAlign="center" width="20px" allowSort="true"
                                    visible="false">
                                        业务编号
                                    </div>
                                    <div field="lAttachId" width="120" headerAlign="center" allowSort="true"
                                    visible="false">
                                        附件id
                                    </div>
                                    <div field="vcAttachName" width="200" headerAlign="center">
                                        附件名称
                                    </div>
                                    <div field="lProcessInstId" width="80" headerAlign="center" align="right"
                                    allowSort="true">
                                        投资编号
                                    </div>
                                    <div field="vcProductCode" width="140" headerAlign="center" allowSort="true">
                                        产品代码
                                    </div>
                                    <div field="vcProductName" width="140" headerAlign="center" allowSort="true">
                                        产品名称
                                    </div>
                                    <div field="vcProcessType" width="140" headerAlign="center" allowSort="true"
                                    renderer="vcProcessTypeRenderer">
                                        申购类型
                                    </div>
                                    <div field="vcStockCode" width="140" headerAlign="center" allowSort="true">
                                        债券代码
                                    </div>
                                    <div field="vcStockNameFull" width="140" headerAlign="center" allowSort="true">
                                        债券全称
                                    </div>
                                    <div field="vcPaymentPlace" width="110" headerAlign="center" allowSort="true"
                                    renderer="vcPaymentPlaceRenderer">
                                        登记托管机构
                                    </div>
                                    <div field="vcAttachAdd" width="250" headerAlign="center" allowSort="true">
                                        附件地址
                                    </div>
                                    <div field="vcAttachSize" id="vaSize" width="100" headerAlign="center"
                                    allowSort="true" renderer="renderAttachGrose">
                                        附件大小
                                    </div>
                                    <div field="dCreateTime" width="80" headerAlign="center" align="right"
                                    allowSort="true" dateFormat="yyyy-MM-dd">
                                        创建日期
                                    </div>
                                    <div field="vcWhetherIndia" width="70" headerAlign="center" allowSort="true"
                                    renderer="renderWhetherIndia">
                                        是否用印
                                    </div>
                                    <div field="vcAnnexSeal" width="90" headerAlign="center" allowSort="true"
                                    renderer="renderWhetherIndia">
                                        是否已经用印
                                    </div>
                                    <div field="vcWhetherFax" width="90" headerAlign="center" allowSort="true"
                                    renderer="renderWhetherIndia">
                                        是否已发传真
                                    </div>
                                    <div field="vcVersionNo" width="50" headerAlign="center" align="right"
                                    allowSort="true" visible="false">
                                        版本号
                                    </div>
                                    <div field="vcUserId" width="80" headerAlign="center" allowSort="true">
                                        用户名称
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div title="申购附件详细信息" region="south" showSplit="false" showHeader="true"
                    height="160" showSplitIcon="true">
                        <div id="editForm1">
                            <input class="mini-hidden" name="id" />
                            <table border="0" cellpadding="1" cellspacing="1" style="margin-top:10px;width: 100%; table-layout: fixed;">
                                <tr>
                                	<td style="width:70px; " align="right">
                                        产品名称:
                                    </td>
                                    <td style="width:180px;">
                                        <input id="vcProductName" name="vcProductName" class="mini-textbox" style="width:100%"
                                        readonly="true" inputStyle="background-color:#f0f0f0;" />
                                    </td>
                                    <td style="width:80px;" align="right">
                                        申购类型:
                                    </td>
                                    <td style="width:130px;">
                                        <input id="vcProcessType" name="vcProcessType" class="nui-dictcombobox"
                                        dictTypeId="ATS_PROCESS_TYPE" valueField="dictID" textField="dictName"
                                        style="width:100%" readonly="true" inputStyle="background-color:#f0f0f0;"
                                        />
                                    </td>
                                    <td style="width:100px;" align="right">
                                        登记托管机构:
                                    </td>
                                    <td style="width:180px;">
                                        <input align="left" width="100%" id="vcPaymentPlace" name="vcPaymentPlace"
                                        class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" readonly="true" inputStyle="background-color:#f0f0f0;"
                                        />
                                    </td>
                                    <td style="width:90px; " align="right">
                                        是否用印:
                                    </td>
                                    <td style="width:110px;">
                                        <input id="vcWhetherIndia" data="[{ id: 1, text: '是' }, { id: 0, text: '否'}]"
                                        name="vcWhetherIndia" class="mini-combobox" style="width:96%" readonly="true"
                                        inputStyle="background-color:#f0f0f0;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:120px;" align="right">
                                        债券全称:
                                    </td>
                                    <td>
                                        <input id="vcStockNameFull" name="vcStockNameFull" class="mini-textbox"
                                        style="width:100%" readonly="true" inputStyle="background-color:#f0f0f0;"
                                        />
                                    </td>
                                    <td style="width:240px;" align="right">
                                        投资编号:
                                    </td>
                                    <td>
                                        <input id="lProcessInstId" name="lProcessInstId" class="mini-textbox"
                                        style="width:100%" readonly="true" inputStyle="background-color:#f0f0f0;"
                                        />
                                    </td>
                                    <td style="width:90px;" align="right">
                                        用户名称:
                                    </td>
                                    <td style="width:150px;">
                                        <input name="vcUserId" class="mini-textbox" style="width:100%" readonly="true"
                                        inputStyle="background-color:#f0f0f0;" />
                                    </td>
                                    <td style="width:120px;" align="right">
                                        是否已发传真:
                                    </td>
                                    <td>
                                        <input id="vcWhetherFax" data="[{ id: 1, text: '是' }, { id: 0, text: '否'}]"
                                        name="vcWhetherFax" class="mini-combobox" style="width:96%" readonly="true"
                                        inputStyle="background-color:#f0f0f0;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:60px;" align="right">
                                        附件名称:
                                    </td>
                                    <td style="width:320px;">
                                        <input name="vcAttachName" class="mini-textbox" style="width:100%" readonly="true"
                                        inputStyle="background-color:#f0f0f0;" />
                                    </td>
                                    <td style="width:120px;" align="right">
                                        创建时间:
                                    </td>
                                    <td>
                                        <input name="dCreateTime" format="yyyy-MM-dd" class="nui-datepicker" style="width:100%"
                                        readonly="true" inputStyle="background-color:#f0f0f0;" />
                                    </td>
                                    <td style="width:240px; " align="right">
                                        附件大小:
                                    </td>
                                    <td>
                                        <input id="vcAttachSizes" class="mini-textbox" style="width:100%"
                                        readonly="true" inputStyle="background-color:#f0f0f0;" />
                                    </td>
                                    <td style="width:120px;" align="right">
                                        是否已经用印:
                                    </td>
                                    <td>
                                        <input id="vcAnnexSeal" data="[{ id: 1, text: '是' }, { id: 0, text: '否'}]"
                                        name="vcAnnexSeal" class="mini-combobox" style="width:96%" style="width:96%"
                                        readonly="true" inputStyle="background-color:#f0f0f0;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:80px;" align="right">
                                        附件地址:
                                    </td>
                                    <td>
                                        <input id="vcAttachAdd" name="vcAttachAdd" class="mini-textbox" style="width:100%"
                                        readonly="true" inputStyle="background-color:#f0f0f0;" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- 文档下载 -->
                <form id="file_download" method="post">
                    <!-- 数据实体的名称 -->
                    <input class="nui-hidden" name="processId" id="processId" />
                    <input class="nui-hidden" name="sysid" id="sysid" />
                    <input class="nui-hidden" name="lBizId" id="lBizId" />
                </form>
                <script type="text/javascript">
                    nui.parse();
                    var grid = nui.get("datagrid1");
                    grid.load();
                    var form = new nui.Form("#form1");
                    var msg;
                    var db = new nui.DataBinding();
                    db.bindForm("editForm1", grid);
                    var formData = form.getData(false, false);
                    grid.load(formData);
 					$("#editForm1 .mini-buttonedit-buttons").remove();
			        $("#editForm1 .mini-buttonedit-border").css("background-color","#f0f0f0");
                    function vcPaymentPlaceRenderer(e) {
                        return nui.getDictText("CF_JY_DJTGCS", e.row.vcPaymentPlace);
                    }
                    //查询
                    function search() {
                        var data = form.getData(false, false); //获取表单多个控件的数据
                        var editForm1 = new nui.Form("#editForm1");
        				editForm1.reset();
                        grid.load(data);
                    }
                    //重置
                    function reset() {
                        form.reset();
                    }

                    //重新刷新页面
                    function refresh() {
                        var form = new nui.Form("#form1");
                        var json = form.getData(false, false);
                        grid.load(json); //grid查询
                        //nui.get("update").enable();
                    }

                    //enter键触发查询
                    function onKeyEnter(e) {
                        search();
                    }

					//同步更改附件详情中的附件大小
                    function sysnAttachSize(record){
                    	var attachSizeDetail = nui.get("vcAttachSizes");
                    	var num = "";
                        if (record[0].vcAttachSize != null && record.length == 1) {
                        	var vcAttachSize = record[0].vcAttachSize / 1024 / 1024;
                            if (vcAttachSize < 1) {
                                vcAttachSize = record[0].vcAttachSize / 1024;
                                num = vcAttachSize.toFixed(2) + "KB";
                            } else {
                                num = vcAttachSize.toFixed(2) + "MB";
                            }
                            attachSizeDetail.setValue(num);
                        }
                    }
                    
                    //当选择列时
                    function selectionChanged() {
                        //nui.get("vcAttachbigsom").setValue(num);

                        var rows = grid.getSelecteds();
                        if (rows.length > 1) {
                            // nui.get("update").disable();
                        } else {
                            //nui.get("update").enable();
                        }
                        sysnAttachSize(rows);
                    }
                    function vcProcessTypeRenderer(e) {
                        return nui.getDictText("ATS_PROCESS_TYPE", e.row.vcProcessType);
                    }

                    function renderWhetherIndia(e) {
                        if (e.value == "0") {
                            return "否";
                        } else if (e.value == "1") {
                            return "是";
                        }
                    }

                    function renderAttachGrose(e) {
                        var record = e.record;
                        var num = e.cellHtml;
                        if (record.vcAttachSize != null) {
                            var vcAttachSize = record.vcAttachSize / 1024 / 1024;
                            if (vcAttachSize < 1) {
                                vcAttachSize = record.vcAttachSize / 1024;
                                num = vcAttachSize.toFixed(2) + "KB";
                            } else {
                                num = vcAttachSize.toFixed(2) + "MB";
                            }
                        }
                        return num;
                    }
 
                    //附件下载
                    function fileDownload() {
                        var datas = nui.get("datagrid1").getSelecteds();
                        var sysId = "";
                        for (var i = 0; i < datas.length; i++) {
                            if (sysId == "") {
                                sysId = datas[i].lAttachId;
                            } else {
                                sysId = sysId + "," + datas[i].lAttachId;
                            }
                        }
                        nui.get("sysid").setValue(sysId);
                        if (datas != null && datas != "") {
                            //设置参数
                            nui.get("processId").setValue(datas.lProcessInstId);

                            //给出提示并调用下载逻辑	
                            nui.confirm("确认要下载吗？", "系统提示",function(action) {
                                var form = document.getElementById("file_download");
                                var json1 = nui.encode({attachs:datas});
                                if (action == "ok") {
                                	nui.ajax({
										url:"com.cjhxfund.ats.fm.baseinfo.AttachManager.attachManage.biz.ext",
										type:'POST',
										data:json1,
										cache:false,
            							contentType:'text/json',		
										success:function(text){
						                    if(text.flag==false){
						                       nui.alert("下载失败，文件不存在！", "系统提示");
						                    }else{
						                        //请求下载页面流
			                                    form.action = "com.cjhxfund.ats.fm.baseinfo.FileDownLoad.flow";
			                                    form.submit();
	                                		}
										}
								});	            
                                	
		                        } 
                    	});
                    } else{
                               nui.alert("请先选择指令/建议!", "系统提示");
                          }
               }
                </script>
            </body>
        
        </html>