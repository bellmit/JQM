<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 徐福羊
  - Date: 2016-08-05 10:28:29
  - Description:
-->
<head>
<title>Title</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
</head>
<body>
    <div class="" id="form1">
        <a class='nui-button' plain='false' onclick="synDataByHs"> 同步O32数据 </a>
    </div>
    <div id="info_o32"></div>
    <br />
    <br />
    <div class="" id="form2">
        <a class='nui-button' plain='false' onclick="synDataByWind"> 同步Wind数据 </a>
    </div>
    <div id="info_wind"></div>
    <br />
    <br />
    <div class="" id="form3">
        <a class='nui-button' plain='false' onclick="synStockIssueData"> 同步O32&Wind数据 </a>
    </div>
    <div id="info_stock"></div>
    <br />
    <br />
    <div class="" id="form4">
        <a class='nui-button' plain='false' onclick="exportBondInfo"> 【启动】导出新债数据任务 </a>
    </div>
    <div id="info_export"></div>
    <br />
    <br />
    <div class="" id="form5">
        <a class='nui-button' plain='false' onclick="exportBondInfoClose"> 【关闭】导出新债数据任务 </a>
    </div>
    <br />
    <br />
    <div class="" id="form6">
        <a class='nui-button' plain='false' onclick="getHisRating"> 获取O32&Wind历史评级 </a>
    </div>
    <div id="info_HisRating"></div>

    <script type="text/javascript">
        nui.parse();
        function getHisRating() {
          var form = new nui.Form("#form6");
          var data = form.getData();
          var type = 11;
          var json = nui.encode(data);
          json = nui.encode({buttonType:type});
          nui.ajax({
            url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getBondInfoData.biz.ext",
            type: "post",
            contentType:'text/json',
            data: json ,
            success: function (text) {
              var returnJson = nui.decode(text);
              if (returnJson.returnValue == true) {
                var info = "获取O32&Wind历史评级结果：成功";
                document.getElementById("info_HisRating").innerHTML=info;
              }
              else {
                var info = "获取O32&Wind历史评级结果：失败"; 
                document.getElementById("info_HisRating").innerHTML=info;
              }
            }
          });
        }
        function synDataByHs() {
          var form = new nui.Form("#form1");
          var data = form.getData();
          var type = 1;
          var json = nui.encode(data);
          json = nui.encode({buttonType:type});
          nui.ajax({
            url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getBondInfoData.biz.ext",
            type: "post",
            contentType:'text/json',
            data: json ,
            success: function (text) {
              var returnJson = nui.decode(text);
              if (returnJson.returnValue == true) {
                var info = "同步Wind数据结果：成功";
                document.getElementById("info_o32").innerHTML=info;
              }
              else {
                var info = "同步Wind数据结果：失败"; 
                document.getElementById("info_o32").innerHTML=info;
              }
            }
          });
        }
        function synDataByWind() {
          var form = new nui.Form("#form2");
          var data = form.getData();
          var type = 2;
          var json = nui.encode(data);
          json = nui.encode({buttonType:type});
          nui.ajax({
            //url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getDataFromWind.biz.ext",
            url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getBondInfoData.biz.ext",
            type: "post",
            contentType:'text/json',
            data: json ,
            success: function (text) {
              var returnJson = nui.decode(text);
              if (returnJson.returnValue == true) {
                var info = "同步Wind数据结果：成功";
                document.getElementById("info_wind").innerHTML=info;
              }
              else {
                var info = "同步Wind数据结果：失败"; 
                document.getElementById("info_wind").innerHTML=info;
              }
            }
          });
        }
        function synStockIssueData() {
          var form = new nui.Form("#form3");
          var data = form.getData();
          var type = 3;
          var json = nui.encode(data);
          json = nui.encode({buttonType:type});
          nui.ajax({
            //url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getStockIssueData.biz.ext",
            url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getBondInfoData.biz.ext",
            type: "post",
            contentType:'text/json',
            data: json ,
            success: function (text) {
              var returnJson = nui.decode(text);
              if (returnJson.returnValue == true) {
                var info = "同步O32&Wind数据结果：成功";
                document.getElementById("info_stock").innerHTML=info;
              }
              else {
                var info = "同步O32&Wind数据结果：失败"; 
                document.getElementById("info_stock").innerHTML=info;
              }
            }
          });
        }
        function exportBondInfo() {
          var form = new nui.Form("#form4");
          var data = form.getData();
          var type = 4;
          var json = nui.encode(data);
          json = nui.encode({buttonType:type});
          nui.alert("【启动】导出新债数据任务结果：成功");
          nui.ajax({
            url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getBondInfoData.biz.ext",
            type: "post",
            contentType:'text/json',
            data: json ,
            success: function (text) {
              var returnJson = nui.decode(text);
              var info = "【启动】导出新债数据任务结果：成功";
              document.getElementById("info_export").innerHTML=info;
            }
          });
        }
        function exportBondInfoClose() {
          var form = new nui.Form("#form5");
          var data = form.getData();
          var type = 5;
          var json = nui.encode(data);
          json = nui.encode({buttonType:type});
          nui.ajax({
            url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getBondInfoData.biz.ext",
            type: "post",
            contentType:'text/json',
            data: json ,
            success: function (text) {
              var returnJson = nui.decode(text);
              if (returnJson.returnValue == true) {
                var info = "【关闭】导出新债数据任务结果：成功";
                document.getElementById("info_export_close").innerHTML=info;
              }
              else {
                var info = "【关闭】导出新债数据任务结果：失败";
                document.getElementById("info_export_close").innerHTML=info;
              }
            }
          });
        }
    </script>
</body>
</html>