<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!--
  - Author(s): luojuehuai
  - Date: 2016-09-06 10:44:58
  - Description:
-->
<head>
    <title>续作指令/建议</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <link href="../../css/common.css" rel="stylesheet"/>

    <style type="text/css">
        .flag {
            width: 120px;
            float: left;
            margin-right: 10px;
        }

        .flag > div {
            border: 2px solid #E4E5E9;
            border-radius: 5px;
        }

        .red {
            width: 25px;
            height: 15px;
            background: red;
            float: left;
            margin-top: 5px;
        }

        .infoLabel {
            width: 250px;
            float: left;

        }

        .infoLabel > label:first-of-type {
            float: left;
        }

        .infoLabel > label:last-of-type {
            float: left;
            width: 100px;
            height: 20px;
            display: block;
            border-bottom: 1px solid black;
        }
    </style>
</head>
<body>
<!-- 搜索栏 start -->
<div class="search-condition">
    <div class="list">
        <div class="nui-form" align="center">
            <form id="searchForm">
                <table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                    <tr>
                        <td style="width:60px">产品代码:</td>
                        <td style="width:20%" align="left" colspan="1">
                            <div name="fundCode" class="nui-combobox" pinyinField="ID" id="fundCode"
                                 textField="TEXT" valueField="ID"
                                 url="com.cjhxfund.commonUtil.applyInstUtil.queryTAtsProductInfo.biz.ext"
                                 showNullItem="false"
                                 allowInput="true"
                                 emptyText="请输入产品代码或产品名称..."
                                 nullItemText="请输入产品代码或产品名称..."
                                 valueFromSelect="true"
                                 showClose="true"
                                 oncloseclick="onCloseClick"
                                 popupWidth="300"
                                 onvaluechanged="selectFund"
                                 style="width:95%;">
                                <div property="columns">
                                    <div header="产品代码" field="ID" width="40px"></div>
                                    <div header="产品名称" field="TEXT"></div>
                                </div>
                            </div>

                        </td>
                        <td width="60px" align="right">产品组合</td>
                        <td colspan="1" width="18%" align="left">
                        <input name="vcCombiName" class="nui-combobox" id="vcCombiName"
                                   textField="TEXT" valueField="ID"
                                   dataField="data"
                                   url="com.cjhxfund.commonUtil.applyInstUtil.queryCombiInfo.biz.ext"
                                   showNullItem="false"
                                   allowInput="false"
                                   emptyText="全部"
                                   nullItemText="全部"
                                   showClose="true"
                                   oncloseclick="onCloseClick"
                                   style="width:178px"/>
                        </td>
                        <td width="60px" align="right">到期日区间</td>
                        <td colspan="1" width="30%" align="left">
                        <input id="startDate" allowInput="false" name="startDate" 
                        class="nui-datepicker" showClose="true" oncloseclick="onCloseClick" />
                        ~
                        <input id="endDate" allowInput="false" name="endDate"
                        class="nui-datepicker" showClose="true" oncloseclick="onCloseClick" />
                        </td>
                        <td width="60px" align="right">委托方向</td>
                        <td colspan="1" width="18%" align="left">
                        <input class="nui-dictcombobox" 
                                   name="cEntrustDirection" 
                                   id="cEntrustDirection" 
                                   valueField="dictID" 
                                   textField="dictName" 
                                   dictTypeId="entrustDirection"
                                   emptyText="全部" 
                                   showClose="true" 
                                   oncloseclick="onCloseClick" 
                                   style="width:178px"/>
                        </td>
                        <td width="60px" align="right"></td>
                        <td colspan="1" width="18%" align="left">
                        </td>
                    </tr>
                    <tr>
                        <td align="left" colspan="4">
                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="searchThgregister()"/>
                            <a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">重置</a>
                    <a class="nui-menubutton " plain="false" menu="#popupMenu"
                       id="searchCond"
                       name="searchCond"
                       data-options='{formId:"searchForm"}'
                       iconCls="icon-add">保存查询条件</a>
                    <ul id="popupMenu" class="mini-menu" style="display:none;width:250px;">
                    </ul>
                        </td>
                        <td colspan="1">
                        </td>
                        <td align="left" colspan="2">
                        </td>
                        <td colspan="1">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>
<!-- 搜索栏 end -->

<!-- thgregisterGrid  start-->
<div class="mini-fit">
<div id="thgregisterGrid" dataField="repuachaseList"
     url="com.cjhxfund.ats.sm.repurchase.RepurchaseBizManager.querySequelInstruct.biz.ext"
     class="nui-datagrid" style="width:100%;height:100%;" idField="id"
     pageSize="20"
     showPageInfo="true" multiSelect="true"
     allowResize="true"
     allowSortColumn="true"
     showReloadButton="true"
     sortMode="client"
     enableHotTrack="false"
     sizeList="[10,20,50,100]"
>
    <div property="columns">
        <div name="action" headerAlign="center" align="center" renderer="opera">操作</div>
        <div field="lFundId" headerAlign="center">产品ID</div>
        <div field="vcFundName" headerAlign="center">产品名称</div>
        <div field="lBasecombiId" headerAlign="center">组合ID</div>
        <div field="vcCombiName" headerAlign="center">组合名称</div>
        <div field="cEntrustDirection" align="left" headerAlign="center" allowSort="true" renderer="EntrustDireName">
            委托方向
        </div>
        <div field="rivalName" align="left" headerAlign="center" allowSort="true"> 交易对手</div>
        
        <div field="enDealBalance" align="right" numberFormat="n2" headerAlign="center" allowSort="true">回购金额(元)</div>
        <div field="enHgBalance" align="right" numberFormat="n2" headerAlign="center" allowSort="true">到期结算金额(元)</div>
        <div field="enHgRatio" align="right" headerAlign="center" decimalPlaces="2" dataType="float" allowSort="true">
            回购利率(%)
        </div>
        <div field="lFirstSettleDate" headerAlign="center" align="left" renderer="gridFormatDate">首次结算日期</div>
        <div field="lSecondSettleDate" align="left" headerAlign="center" renderer="gridFormatDate">到期结算日期</div>
        <div field="lRedeemDays" align="right"  dataType="int">回购期限(天)</div>
        <div field="lContractPeriods" align="right" headerAlign="center" renderer="calContractPeriods">实际占款天数</div>
        <div field="vcContractNo" align="left" headerAlign="center">合同号</div>
        <div field="vcPledgeCode" align="left" headerAlign="center">质押券代码</div>
        <div field="vcPledgeCodeName" align="left" headerAlign="center">质押券名称</div>
        <div field="enPledgeAmount" align="right" headerAlign="center" numberFormat="n2">质押数量</div>
        <div field="enFaceAmout" align="right" headerAlign="center" renderer="calcEnFaceAmout" numberFormat="n2">券面金额(元)</div>
        <div field="enPledgeRatio" align="right" headerAlign="center">质押比例</div>
    </div>
</div>
</div>
<!-- thgregisterGrid  start-->


<!-- 第二个Grid end -->
<script type="text/javascript">

    nui.parse();
    var searchThgregister = function () {

        var date = new Date();
        var dateStr = DateUtil.toNumStr(date);
        
        var searchForm = (new nui.Form("searchForm")).getData();;
        var fundId = searchForm.fundCode;
        if (!fundId) {
            mini.showTips({
                content: "请选择产品代码。",
                state: "warning",
                x: "top",
                y: "top",
                timeout: 1000
            });
            return;
        }
        thgregisterGrid.load({
            param: {
                fundId: fundId,
                lSettleDate: dateStr,
                vcCombiName:searchForm.vcCombiName,
                startDate:DateUtil.toNumStr(searchForm.startDate),
                endDate:DateUtil.toNumStr(searchForm.endDate),
                cEntrustDirection:searchForm.cEntrustDirection
            }
        }, function (e) {
            var data = e.data;
            disableOpra(data);
        });
    };
    function opera(e) {
        if (e.row.disableOpra) {
            return '续作中';
        } else {
            return '<a style="color:#00CCFF" href="javascript:showMaturedSequel()" >续作</a>';
        }

    }
    var showMaturedSequel = function () {
        mini.open({
            url: nui.context + "/repurchase/invest/protocol_repo/sequentialOpera.jsp",
            title: "协议式回购续作指令/建议",
            width: "650px",
            height: "670px",
            onload: function () {
                var iframe = this.getIFrameEl();
                var data = thgregisterGrid.getSelected();
                iframe.contentWindow.SetData({"instructParameter": data, "bonds": {}},function(){
                searchThgregister();
                });
            },
            ondestroy: function (action) {
            }
        });
    };
    var reset = function () {

    };
    //因为要多次操作，所以加载时将grid的对象存入 thgregisterGrid 对象
    var thgregisterGrid = mini.get("thgregisterGrid");
    thgregisterGrid.hideColumns([1, 2, 3, 4]);
    //转换委托方向
    function EntrustDireName(e) {
        return nui.getDictText("entrustDirection", e.row.cEntrustDirection);
    }
    //页面X的删除功能
    function onCloseClick(e) {
        var obj = e.sender;
        obj.setText("");
        obj.setValue("");
    }
    function calcEnFaceAmout(e) {
        if (e.row.enPledgeAmount) {
            return e.row.enPledgeAmount * 100;
        }
        return "";
    }
    function gridFormatDate(e) {
        if (e.value) {
            return DateUtil.numStrToDateStr(e.value);
        }
        return "";
    }
    //计算实际占款天数
    function calContractPeriods(e) {
        var lHgDate = e.record.lHgDate;//首次成交日期
        if (lHgDate) {
            var todayTime = DateUtil.DstrToDate(DateUtil.dateToString(new Date));
            var date = (DateUtil.numStrToDate(lHgDate)).getTime();
            var temp = (todayTime - date) / (1000 * 60 * 60 * 24);
            return temp.toFixed(0);
        } else {
            return "";
        }
    }
</script>
<script type="text/javascript"
        src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/DateUtil.js"></script>
<script type="text/javascript"
        src="<%= request.getContextPath() %>/repurchase/invest/protocol_repo/js/protocalComList.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/SaveCondition.js"></script>
</body>
</html>
