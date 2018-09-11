<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): fengjunpei
  - Date: 2016-12-19 09:04:46
  - Description:算法每日成交金额图表
-->
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<head>
    <title>算法交易成交金额图表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
<script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/highcharts.js" ></script>
</head>
<body style="height:100%;width:100%;">
    <div id="win1" class="mini-window"  style="height:99%;width:99%;" 
        showToolbar="false" showFooter="true" showModal="true" allowResize="true">
            
        <div id="chartContainer" style="height:100%;width:100%;"></div>
    </div>
</body>
</html>

<script type="text/javascript">
mini.parse();
    function buildChart(){
    	var data = [];
    	nui.ajax({
			url:"com.cjhxfund.ats.algo.report.AlgoReportManage.getRealTimeAlgoAmount.biz.ext",
			type:"post",
			data:"",	
			async: false,
			contentType:"text/json",
			success:function(text){
				var resultData = text.resultData;
				var returnJson = nui.decode(text);
                if(returnJson.exception == null){
					for(var i=0;i<resultData.length;i++){
						 
						if(resultData[i].createDate>=0930 && resultData[i].createDate<=0934){
							data[0] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=0935 && resultData[i].createDate<=0939){
							data[1] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=0940 && resultData[i].createDate<=0944){
							data[2] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=0945 && resultData[i].createDate<=0949){
							data[3] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=0950 && resultData[i].createDate<=0954){
							data[4] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=0955 && resultData[i].createDate<=0959){
							data[5] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1000 && resultData[i].createDate<=1004){
							data[6] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1005 && resultData[i].createDate<=1009){
							data[7] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1010 && resultData[i].createDate<=1014){
							data[8] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1015 && resultData[i].createDate<=1019){
							data[9] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1020 && resultData[i].createDate<=1024){
							data[10] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1025 && resultData[i].createDate<=1029){
							data[11] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1030 && resultData[i].createDate<=1034){
							data[12] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1035 && resultData[i].createDate<=1039){
							data[13] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1040 && resultData[i].createDate<=1044){
							data[14] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1045 && resultData[i].createDate<=1049){
							data[15] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1050 && resultData[i].createDate<=1054){
							data[16] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1055 && resultData[i].createDate<=1059){
							data[17] = parseFloat(resultData[i].totalAmount);
						}
						else if(resultData[i].createDate>=1100 && resultData[i].createDate<=1104){
							data[18] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1105 && resultData[i].createDate<=1109){
							data[19] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1110 && resultData[i].createDate<=1114){
							data[20] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1115 && resultData[i].createDate<=1119){
							data[21] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1120 && resultData[i].createDate<=1124){
							data[22] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1125 && resultData[i].createDate<=1129){
							data[23] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1130 && resultData[i].createDate<=1134){
							data[24] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1135 && resultData[i].createDate<=1139){
							data[25] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1140 && resultData[i].createDate<=1144){
							data[26] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1145 && resultData[i].createDate<=1149){
							data[27] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1150 && resultData[i].createDate<=1154){
							data[28] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1155 && resultData[i].createDate<=1159){
							data[29] = parseFloat(resultData[i].totalAmount);
						}
						else if(resultData[i].createDate>=1200 && resultData[i].createDate<=1204){
							data[30] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1205 && resultData[i].createDate<=1209){
							data[31] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1210 && resultData[i].createDate<=1214){
							data[32] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1215 && resultData[i].createDate<=1219){
							data[33] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1220 && resultData[i].createDate<=1224){
							data[34] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1225 && resultData[i].createDate<=1229){
							data[35] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1230 && resultData[i].createDate<=1234){
							data[36] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1235 && resultData[i].createDate<=1239){
							data[37] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1240 && resultData[i].createDate<=1244){
							data[38] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1245 && resultData[i].createDate<=1249){
							data[39] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1250 && resultData[i].createDate<=1254){
							data[40] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1255 && resultData[i].createDate<=1259){
							data[41] = parseFloat(resultData[i].totalAmount);
						}
						else if(resultData[i].createDate>=1300 && resultData[i].createDate<=1304){
							data[42] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1305 && resultData[i].createDate<=1309){
							data[43] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1310 && resultData[i].createDate<=1314){
							data[44] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1315 && resultData[i].createDate<=1319){
							data[45] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1320 && resultData[i].createDate<=1324){
							data[46] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1325 && resultData[i].createDate<=1329){
							data[47] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1330 && resultData[i].createDate<=1334){
							data[48] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1335 && resultData[i].createDate<=1339){
							data[49] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1340 && resultData[i].createDate<=1344){
							data[50] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1345 && resultData[i].createDate<=1349){
							data[51] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1350 && resultData[i].createDate<=1354){
							data[52] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1355 && resultData[i].createDate<=1359){
							data[53] = parseFloat(resultData[i].totalAmount);
						}
						else if(resultData[i].createDate>=1400 && resultData[i].createDate<=1404){
							data[54] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1405 && resultData[i].createDate<=1409){
							data[55] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1410 && resultData[i].createDate<=1414){
							data[56] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1415 && resultData[i].createDate<=1419){
							data[57] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1420 && resultData[i].createDate<=1424){
							data[58] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1425 && resultData[i].createDate<=1429){
							data[59] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1430 && resultData[i].createDate<=1434){
							data[60] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1435 && resultData[i].createDate<=1439){
							data[61] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1440 && resultData[i].createDate<=1444){
							data[62] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1445 && resultData[i].createDate<=1449){
							data[63] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1450 && resultData[i].createDate<=1454){
							data[64] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1455 && resultData[i].createDate<=1459){
							data[65] = parseFloat(resultData[i].totalAmount);
						}else if(resultData[i].createDate>=1500 && resultData[i].createDate<=1504){
							data[66] = parseFloat(resultData[i].totalAmount);
						}
						
					}
					//默认展示所有时间段
					var count = 0;
					for(var i=0;i<67;i++){
						if(!data[i]){
							data[i] = 0;
						}else{
							count = i;
						}
					}
					//当前时间段数据的后面时间段全部显示为空白
					for(var i=count;i<67;i++){
						data[i+1] = null;
					}
				}else{
                    nui.alert("实时算法成交金额数据获取失败", "系统提示");
                }
			},
			error:function(){
				nui.alert("实时算法成交金额数据获取失败", "系统提示");
			}
		}); 
        var chart = new Highcharts.Chart({
        
            chart: {
                renderTo: 'chartContainer',
                type: 'areaspline'
            },
            title: {
                text: ' '
            },
            legend: {
                layout: 'vertical',
                align: 'top',
                verticalAlign: 'top',
                x: 60,
                y: 0,
                floating: true,
                borderWidth: 1,
                backgroundColor: '#FFFFFF'
            },
            xAxis: {
	            type: 'datetime',
	            labels: {
	                formatter: function () {
	                    var arr = [];  
		                arr[1468056600000]   = '09:30';  
		                arr[1468060200000]  = '10:30';  
		                arr[1468063800000] = '11:30'; 
		                arr[1468069200000] =  '13:00';
		                arr[1468072800000] = '14:00';  
		                arr[1468076400000] = '15:00';
	                    return  arr[this.value];
	                }
	            } 
            },
            yAxis: {
                title: {
                    text: ' '
                }
            },
             tooltip: {
                formatter: function() {
                     return '<b>' + this.series.name + '</b><br/>' +
                        Highcharts.dateFormat('%H:%M:%S', this.x) + '<br/>' +
                        Highcharts.numberFormat(this.y, 4)+'元';
                }
            },
            credits: {
                enabled: false
            },
            plotOptions: {
                areaspline: {
                    fillOpacity: 0.5
                }
            },
            series: [{
                name: '算法成交总金额',
		        data:data,
		        pointInterval: 300 *1000,  
                pointStart: Date.UTC(2016, 06, 09,09,30,00),  
                pointEnd:Date.UTC(2016,06,09,11,30,00)
            }]
        });
    }
    //系统自动刷新页面--所有业务通用
    function showChartWindow(){
    	var win = mini.get("win1");
        win.show();
        buildChart();
    }
    self.setInterval("showChartWindow()",60000*5);//设置自动刷新时间默认5分钟
    showChartWindow();
    
</script>