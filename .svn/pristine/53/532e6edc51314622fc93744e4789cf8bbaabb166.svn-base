<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): fengjunpei
  - Date: 2016-12-19 09:04:46
  - Description:算法每日成交金额图表
-->
<head>


<title>算法每日成交金额图表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/echarts.js" ></script>
    <script src="<%= request.getContextPath() %>/scripts/com.cjhxfund.js.base/utils/vintage.js" ></script>
    
</head>
<body style="width: 100%; height:100%;">
<div id="container" style="width: 100%; height:98%;"></div>



<script type="text/javascript">
	
nui.parse();
    	
// 第二个参数可以指定前面引入的主题
var chart = echarts.init(document.getElementById('container'), 'vintage');
var rawData = [];
 function buildChart(){
    nui.ajax({
		url:"com.cjhxfund.ats.algo.report.AlgoReportManage.queryTotalAmount.biz.ext",
		type:"post",
		data:"",	
		async: false,
		contentType:"text/json",
		success:function(text){
			var resultTotalAmoutList = text.resultTotalAmoutList;
			var resultAlgorithmList = text.resultAlgorithmList;
			//封装数据格式:data[["20161212","算法成交金额","非算法成交金额"],["20161213","算法成交金额","非算法成交金额"]]
			for(var i=0;i<resultAlgorithmList.length;i++){
				for(var j=0;j<resultTotalAmoutList.length;j++){
					if(resultAlgorithmList[i].createDate == resultTotalAmoutList[j].createDate){
						var data = [];
						data.add(resultTotalAmoutList[j].createDate);
						data.add(resultAlgorithmList[i].totalAmount);
						data.add(resultTotalAmoutList[j].totalAmount);
						rawData.push(data);
						break;
					}
				}
			}
			
		},
		error:function(){
			alert("error");
		}
	});
		
	var dates = rawData.map(function (item) {
    	return item[0];
	});

	var data = rawData.map(function (item) {
	    return [+item[1], +item[2]];
	});

	chart.setOption({
	    backgroundColor: '#21202D',
	    legend: {
	        data: ['总成交金额', '当日总成交金额'],
	        inactiveColor: '#777',
	        textStyle: {
	            color: '#fff'
	        }
	    },
	    tooltip: {
	        trigger: 'axis',
	        axisPointer: {
	            animation: false,
	            lineStyle: {
	                color: '#376df4',
	                width: 2,
	                opacity: 1
	            }
	        }
	    },
	    xAxis: {
	        type: 'category',
	        data: dates,
	        axisLine: { lineStyle: { color: '#8392A5' } }
	    },
	    yAxis: {
	        scale: true,
	        axisLine: { lineStyle: { color: '#8392A5' } },
	        splitLine: { show: false }
	    },
	    dataZoom: [{
	        textStyle: {
	            color: '#8392A5'
	        },
	        handleIcon: 'M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.1,8.8,9.4v1.3h1.3v-1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,24.4H6.7V23h6.6V24.4z M13.3,19.6H6.7v-1.4h6.6V19.6z',
	        handleSize: '80%',
	        dataBackground: {
	            areaStyle: {
	                color: '#8392A5'
	            },
	            lineStyle: {
	                opacity: 0.8,
	                color: '#8392A5'
	            }
	        },
	        handleStyle: {
	            color: '#fff',
	            shadowBlur: 3,
	            shadowColor: 'rgba(0, 0, 0, 0.6)',
	            shadowOffsetX: 2,
	            shadowOffsetY: 2
	        }
	    }, {
	        type: 'inside'
	    }],
	    animation: false,
	    series: [
	        {
	            name: '总成交金额',
	            type: 'line',
	            data: calculateMA(0, data),
	            smooth: true,
	            showSymbol: false,
	            lineStyle: {
	                normal: {
	                    width: 2
	                }
	            }
	        },
	        {
	            name: '当日总成交金额',
	            type: 'line',
	            data: calculateMA(1, data),
	            smooth: true,
	            showSymbol: false,
	            lineStyle: {
	                normal: {
	                    width: 2
	                }
	            }
	        }
    	]
    });		
}

function calculateMA(dayCount, data) {
    var result = [];
    for(var i=0;i<data.length;i++){
    	result.push(data[i][dayCount]);
    }
    return result;
}

function showChartWindow() {
    buildChart();
}
showChartWindow();

    </script>
</body>
</html>