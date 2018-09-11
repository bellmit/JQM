<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
session="false" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <%@include file="/common/js/commscripts.jsp" %>
        <html>
            <!-- - Author(s): 胥思明 - Date: 2016-11-17 10:36:27 - Description: -->
            
            <head>
                <title>
                    债券附件信息
                </title>
                <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
            </head>
            
            <body style="width:100%;height:100%;overflow: hidden; margin: 0px;">
                <div class="search-condition">
                    <div class="list">
                        <div id="form1" class="nui-form" align="center" style="height: 10%">
                            <!-- 排序字段 -->
                            <form id="queryForm" action="">
                                <input class="nui-hidden" name="map/vcAttachType" value="2" width="100%"
                                />
                                <table id="table1" class="table" style="width:100%;table-layout:fixed;">
                                    <tr>
                                        <td style="width: 50px" align="right">
                                            债券全称:
                                        </td>
                                        <td style="width:15%" align="left">
                                            <input class="nui-textbox" id="vcStockCode" name="map/vcStockName" width="100%"
                                            />
                                        </td>
                                        <td style="width: 60px" align="right">
                                             债券代码:
                                        </td>
                                        <td style="width:15%" align="left">
                                            <input class="nui-textbox" id="vcStockCode" name="map/vcStockCode" width="100%"
                                            />
                                        </td>
                                        <td style="width: 70px" align="right">
                                            创建日期:
                                        </td>
                                        <td style="width:15%" align="left">
                                            <input class="nui-datepicker" format="yyyy-MM-dd" showClose="true" oncloseclick="onCloseClickValueEmpty"
                                            id="dCreateTime" name="map/dCreateTime" width="100%" />
                                        </td>
                                        <td style="width: 80px" align="right">
                                            登记托管机构:
                                        </td>
                                        <td style="width:15%" align="left">
                                            <input class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" valueField="dictID"
                                            textField="dictName" name="map/vcPaymentPlace" showClose="true" oncloseclick="onCloseClickValueEmpty"
                                            id="vcPaymentPlace" onvaluechanged="onMarketNoChanged" onblur="clearStockType"
                                            width="100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 50px" align="right">
                                            附件名称:
                                        </td>
                                        <td style="width:15%" align="left">
                                            <input class="nui-textbox" id=vcAttachName name="map/vcAttachName" width="100%"
                                            />
                                        </td>
                                        <td style="width: 80px" align="right">
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
                                    <div field="lProcessInstId" headerAlign="center" width="20px" allowSort="true"
                                    visible="false">
                                        流程编号
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
                                    <div field="lInvestNo" width="80" headerAlign="center" align="right" allowSort="true"
                                    visible="false">
                                        投资编号
                                    </div>
                                    <div field="vcAttachName" width="200" headerAlign="center">
                                        附件名称
                                    </div>
                                    <div field="vcStockCode" width="80" headerAlign="center" allowSort="true">
                                        债券代码
                                    </div>
                                    <div field="vcStockNameFull" width="200" headerAlign="center" allowSort="true">
                                        债券全称
                                    </div>
                                    <div field="vcStockType" width="80" headerAlign="center" allowSort="true">
                                        债券类别
                                    </div>
                                    <div field="vcPaymentPlace" width="110" headerAlign="center" allowSort="true"
                                    renderer="vcPaymentPlaceRenderer">
                                        登记托管机构
                                    </div>
                                    <div field="vcAttachAdd" width="250" headerAlign="center" allowSort="true">
                                        附件地址
                                    </div>
                                    <div field="vcAttachSize" width="100" headerAlign="center" allowSort="true"
                                    renderer="renderAttachGrose">
                                        附件大小
                                    </div>
                                    <div field="dCreateTime" width="80" headerAlign="center" align="right"
                                    allowSort="true" dateFormat="yyyy-MM-dd">
                                        创建时间
                                    </div>
                                    <div field="vcUserId" width="80" headerAlign="center" allowSort="true">
                                        用户名称
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div title="债券附件详细信息" region="south" showSplit="false" showHeader="true"
                    height="160" showSplitIcon="true">
                        <div id="editForm1">
                            <input class="mini-hidden" name="id" />
                            <table border="0" cellpadding="1" cellspacing="1" style="margin-top:10px;width: 100%; table-layout: fixed;">
                                <tr>
                                    <td style="width:90px;" align="right">
                                        债券全称:
                                    </td>
                                    <td>
                                        <input id="vcStockNameFull" name="vcStockNameFull" class="mini-textbox" style="width:100%"
                                        readonly="true" inputStyle="background-color:#f0f0f0;" />
                                    </td>
                                    <td style="width:90px;" align="right">
                                        债券类别:
                                    </td>
                                    <td>
                                        <input id="vcStockType" name="vcStockType" class="mini-textbox" style="width:100%"
                                        readonly="true" inputStyle="background-color:#f0f0f0;" />
                                    </td>
                                    <td style="width: 90px" align="right">
                                        债券代码:
                                    </td>
                                    <td>
                                        <input class="nui-textbox" id="vcStockCode" name="vcStockCode" style="width:100%"
                                        readonly="true" inputStyle="background-color:#f0f0f0;" />
                                    </td>
                                    <td style="width:90px;" align="right">
                                        登记托管机构:
                                    </td>
                                    <td>
                                        <input align="left" width="97%" id="vcPaymentPlace" name="vcPaymentPlace"
                                        class="nui-dictcombobox" dictTypeId="CF_JY_DJTGCS" readonly="true" inputStyle="background-color:#f0f0f0;"
                                        />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:90px;" align="right">
                                        附件名称:
                                    </td>
                                    <td style="width:250px;">
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
                                    <td style="width:80px; " align="right">
                                        附件大小:
                                    </td>
                                    <td>
                                        <input id="vcAttachSizes" class="mini-textbox" style="width:100%"
                                        readonly="true" inputStyle="background-color:#f0f0f0;" />
                                    </td>
                                    <td style="width:70px;" align="right">
                                        用户名称:
                                    </td>
                                    <td style="width:200px;">
                                        <input name="vcUserId" class="mini-textbox" style="width:97%" readonly="true"
                                        inputStyle="background-color:#f0f0f0;" />
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
                        var rows = grid.getSelecteds();
                        if (rows.length > 1) {
                            nui.get("update").disable();
                        } else {
                            //nui.get("update").enable();
                        }
                        sysnAttachSize(rows);
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
                            nui.get("processId").setValue(datas.lProcessInstId);
                            //给出提示并调用下载逻辑
                            nui.confirm("确认要下载吗？", "系统提示",
                            function(action) {
                                if (action == "ok") {
                                 var json = nui.encode({attachs:datas});
                                   	nui.ajax({
										url:"com.cjhxfund.ats.fm.baseinfo.AttachManager.attachManage.biz.ext",
										type:'POST',
										data:json,
										cache:false,
            							contentType:'text/json',		
										success:function(text){
						                    if(text.flag==false){
						                       nui.alert("下载失败，文件不存在！", "系统提示");
						                    }else{
						                         var form = document.getElementById("file_download");
			                                     form.action = "com.cjhxfund.ats.fm.baseinfo.FileDownLoad.flow";
			                                     form.submit();
	                                		}
										}
								});	
                                }
                            });
                        } else {
                            nui.alert("请先选择指令/建议.", "系统提示");
                        }
                        
                    }
                    nui.parse();
                </script>
            </body>
        
        </html>