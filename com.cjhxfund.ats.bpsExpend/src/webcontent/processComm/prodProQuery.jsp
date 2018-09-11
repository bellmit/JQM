<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/common.jsp"%>
<!-- 
  - Author(s): huangy
  - Date: 2016-09-13 16:16:59
  - Description:产品要素查询
-->

<head>
<title>产品进度查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/echarts/echarts.js" type="text/javascript"></script>
    <style type="text/css">
       .divline{ 
            width: 100%; 
            height:100%;
            background-image:url("<%= request.getContextPath() %>/bpsExpend/processComm/img/u8.png");
            background-size:100% 30px;
			background-repeat:no-repeat;
			filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%= request.getContextPath() %>/bpsExpend/processComm/img/u8.png', sizingMethod='scale')\9;  
        }	
       .divline1{ 
            width: 100%; 
            height:100%;
            background-image:url("<%= request.getContextPath() %>/bpsExpend/processComm/img/u2.png");
            background-size:100% 30px;
			background-repeat:no-repeat;
			filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%= request.getContextPath() %>/bpsExpend/processComm/img/u2.png', sizingMethod='scale')\9;
        }	
       .divline_1{ 
            width: 50%; 
            height:100%;
            background-image:url("<%= request.getContextPath() %>/bpsExpend/processComm/img/u8.png");
            background-size:100% 30px;
			background-repeat:no-repeat;
			filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%= request.getContextPath() %>/bpsExpend/processComm/img/u8.png', sizingMethod='scale')\9;
        }	
       .divline1_1{ 
            width: 50%; 
            height:100%;
            background-image:url("<%= request.getContextPath() %>/bpsExpend/processComm/img/u2.png");
            background-size:100% 30px;
			background-repeat:no-repeat;
			filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%= request.getContextPath() %>/bpsExpend/processComm/img/u2.png', sizingMethod='scale')\9;
        }	
      .dateDiv{ 
           width: 90%; 
           height:100%;
           font:normal bold 10px/20px Arial,Helvetica,SimSun,sans-serif;
           font-variant:small-caps;
           position: absolute;
           margin:5px 0px 0px 5px;
           text-align:left;
        }	
       .dateDiv1{ 
           width: 90%; 
           height:200%;
           font:normal bold 10px/20px Arial,Helvetica,SimSun,sans-serif;
           font-variant:small-caps;
           position: absolute;
           margin:5px 0px 0px 5px;
           text-align:right;
        }	
    </style>
</head>
<body style="height:100%; width:97%;margin:0;overflow:hidden;">
 	<div id="dataHeight" class="nui-fit" style="width:100%;height:100%;">
		<div id="graph" style="width:100%;"></div>
		
		<!-- 增加查询条件 -->
		<div id="form1" class="nui-form" align="center" style="border:1px solid #999999;height:40px;;border-bottom: 0;">
					<input class="nui-hidden">
					<div id="table1"  class="table" style="width:98%;height:40px;">
						<div style="margin:0px 115px 0px 115px">
						    <div class="form_label" style="font-weight:bold;float:left;margin:8px 0px 0px 0px;">产品类型</div>
						    <div class="form_label" style="width:80px;margin:8px 0px 0px 10px;float:left;">
								<input class="nui-dictcombobox" dictTypeId="PM_PRODUCT_TYPE_SEL" width="100%" name="prod_Type" id="prod_Type"
								 emptyText="一对一" showNullItem="true" nullItemText="一对一" onvaluechanged="renderType(this)"/> 
							</div>
						    <div class="form_label" style="font-weight:bold;width: 65px;float:left;margin:8px 0px 0px 80px;">产品名称</div>
							<div style="width:250px;margin:8px 0px 0px 0px;float:left;">
								<input class="nui-autocomplete" maxLength="64" width="100%"name="criteria._expr[1].prodName" id="prodName" onclick="queryProdName()" 
							url="com.cjhxfund.fpm.bpsExpend.task.queryProductInfo.biz.ext" valueField="prodName" textField="prodName" dataField="products" onenter="query" onvaluechanged="query"/> 
								<input class="nui-hidden" name="criteria._expr[1]._op" value="like">
							  	<input class="nui-hidden" name="criteria._expr[1]._likeRule" value="all">
								
							</div>
						</div>
						<div style="text-align:center;font-weight:bold;position:fixed; margin:5px 0px 0px 670px;float:right;">
		                    <a class="nui-button" onclick="query()" style="width:80px;height:30px;text-align: center;">查询 </a>
						</div>
					</div>
				</div>

		<div  style="width:100%;height:60%;" >
			<!--  <div class="nui-toolbar" style="height:18px;border-bottom:0px;padding:4px 8px 2px 8px;">
		 	       <div id="barTitle"  style="float:left;" >一对一</div> 
		 	</div> -->
		 	<!-- 一对一 -->
		 	<div id="datagrid1" class="nui-datagrid"  multiSelect="false" height="100%"  width="100%" sortOrder="" sortField="" pageSize="20"
				  dataField="proInfodetails" allowCellSelect="true"  showPageInfo="true" url="com.cjhxfund.fpm.bpsExpend.prodInfo.getProPhase.biz.ext" 
				onbeforeload="clearStatistics"   showSummaryRow="true"  visible="true" ondrawsummarycell="onDrawSummaryCell" >
					    	<div property="columns" >
						    	<div type="indexcolumn" width="3%" headerAlign="center" >序号</div>
						    	<div field="prodType" width="10%" headerAlign="center">产品类型</div>	
						    	<div field="prodName" width="23%" headerAlign="center" allowSort="true">产品名称</div>
						    	<div field="reserve"  width="16%" headerAlign="center">产品储备</div>
						    	<div field="design"  width="16%" headerAlign="center" allowSort="true">产品设计</div>
						    	<div field="seal" width="16%"  headerAlign="center" allowSort="true">合同用印</div>
						    	<div field="supply" width="16%" headerAlign="center"  allowSort="true">产品补录</div>
						    	<div field="sysid" visible="false" >sysid</div>	    	                       
					    	</div> 
	     	</div>
	     	
	     	<!-- 将 产品的一对多 一对一 公募拆分-->
	     	<!-- 一对多 -->
	     	<div id="datagrid2" class="nui-datagrid"  multiSelect="false" height="100%" width="100%" sortOrder="" sortField="" pageSize="20"
				  dataField="proInfodetails" allowCellSelect="true"  showPageInfo="true" url="com.cjhxfund.fpm.bpsExpend.prodInfo.getProPhase.biz.ext" 
				onbeforeload="clearStatistics"  showSummaryRow="true"  visible="false" ondrawsummarycell="onDrawSummaryCell">
					    	<div property="columns" >
						    	<div type="indexcolumn" width="3%" headerAlign="center">序号</div>
						    	<div field="prodType" width="10%" headerAlign="center">产品类型</div>	
						    	<div field="prodName" width="23%" headerAlign="center"  allowSort="true">产品名称</div>
						    	<div field="reserve"  width="16%" headerAlign="center">产品储备</div>
						    	<div field="design"  width="16%" headerAlign="center" allowSort="true">产品设计</div>
						    	<div field="seal" width="16%" headerAlign="center" allowSort="true">合同用印</div>
						    	<div field="supply" width="16%" headerAlign="center" allowSort="true">产品补录</div>
						    	<div field="sysid" visible="false" >sysid</div>	    	                       
					    	</div> 
	     	</div>
	     	<!-- 公募 -->
	     	<div id="datagrid3" class="nui-datagrid"  multiSelect="false" height="100%" width="100%" sortOrder="" sortField="" pageSize="20"
				  dataField="proInfodetails" allowCellSelect="true"  showPageInfo="true" url="com.cjhxfund.fpm.bpsExpend.prodInfo.getProPhase.biz.ext" 
				onbeforeload="clearStatistics"    showSummaryRow="true"  visible="false" ondrawsummarycell="onDrawSummaryCell">
					    	<div property="columns" >
						    	<div type="indexcolumn" width="3%" headerAlign="center">序号</div>
						    	<div field="prodType" width="10%" headerAlign="center" >产品类型</div>	
						    	<div field="prodName" width="39%" headerAlign="center" allowSort="true">产品名称</div>
						    	<div field="reserve"  width="16%" headerAlign="center">产品储备</div>
						    	<div field="design"  width="16%" headerAlign="center" allowSort="true">产品设计</div>
						    	<div field="register" width="16%" headerAlign="center" allowSort="true">公募注册</div>
						    	<div field="sysid" visible="false" >sysid</div>	    	                       
					    	</div> 
	     	</div>	
     	</div>
     </div>
	<script type="text/javascript">
	
		nui.parse();
		//高度设置
		resizeDatagridHeight();
		$(window).bind("resize", resizeDatagridHeight);
    	// 自动调整datagrid的外部高度,撑满屏幕
    	function resizeDatagridHeight(){
    		var realheight = window.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight;
	    	realheight =realheight *0.30;
	    	realheight = realheight  + "px";
	    	
	    	var datagridObj = document.getElementById("graph");
	    	datagridObj.style.height=realheight;
    	}
		var onegrid = nui.get("datagrid1");
		var manygrid = nui.get("datagrid2");
		var pubgrid = nui.get("datagrid3");
		var grid = onegrid;
		var publicType = "2144";
		var one2oneType = "2121";
		var one2manyType ="2122";
		var publicTypeName = "公募";
		var one2oneTypeName = "一对一";
		var one2manyTypeName ="一对多";
		var userPreference = one2oneType;
		var typename = one2oneTypeName;
		var needSum = true;
		//初始化列表 
		//initList();
		draw();
		render();
		grid.load({type:userPreference});
		//var wokingColor = "color:#DA4E49;background-color:#DA4E49;";
		//工作中的颜色(N)
		var wokingColor;
		//已完成的颜色(Y)
		//var doneColor ="color:#44ABC9;background-color:#44ABC9;";
		var doneColor;
		//小阶段的统计实体
		var reserveObj = new Object();
		var designObj = new Object();
		var sealObj = new Object();
		var supplyObj = new Object();
		var registerObj = new Object();
		//判断显示的颜色
		//boolean showColorFlag;  //false=yellow 
		var showColorFlag=0; //0=蓝，1=黄 
		//var upRownum=0; //上一个行
		var divIdCout=0;
		//定时设置
		var iTime="";
		//判断是否单击产品类型
		var isSelectProdType=false;
		function render(){
			grid.on("drawcell", function (e) {
			 	         var column = e.row; 
				 	    //console.log(".........");
				 	    //console.log(e);
				 	    //console.log(column);
				 	     var showHtml="";
			 	         if(e.columnIndex % 2==0){
			 	              showColorFlag=1;
			 	         }else{
			 	              showColorFlag=0;
			 	         }
				 	     if( e.column.field=="supply"){
				 	        showColorFlag=true; //显示颜色各类
				 	     	if(column.supply =='Y'){
				 	     		//e.cellStyle = doneColor;
				 	     	    //判断颜色  //c:显示颜色各类 ,h是否显示一半,时间id,dt1:开始日期，dt2:结束日期
		                       if(showColorFlag==0){
		                          showHtml=checkShowColor(true,false,divIdCout++,column.supplystarttime,column.supplyendtime);
		                       }else{
		                          showHtml=checkShowColor(false,false,divIdCout++,column.supplystarttime,column.supplyendtime);
		                       }
				 	     	}else if(column.supply =='N'){
				 	     	   if(showColorFlag==0){
		                          showHtml=checkShowColor(true,true,divIdCout++,column.supplystarttime,column.supplyendtime);
		                       }else{
		                          showHtml=checkShowColor(false,true,divIdCout++,column.supplystarttime,column.supplyendtime);
		                       }
				 	     	}else{
				 	     	    //加上测试的
				 	     		//e.cellHtml =showHtml '<a href="javascript:gotoTrack(\'' + column.supply + '\')">' + column.field + '</a>';
				 	     	}
				 	     }
				 	     if(  e.column.field=="seal" ){
				 	     	if(column.seal =='Y'){
				 	           if(showColorFlag==0){
		                          showHtml=checkShowColor(true,false,divIdCout++,column.sealstarttime,column.sealendtime);
		                       }else{
		                          showHtml=checkShowColor(false,false,divIdCout++,column.sealstarttime,column.sealendtime);
		                       }
				 	     	}else if(column.seal =='N'){
				 	            if(showColorFlag==0){
		                          showHtml=checkShowColor(true,true,divIdCout++,column.sealstarttime,column.sealendtime);
		                       }else{
		                          showHtml=checkShowColor(false,true,divIdCout++,column.sealstarttime,column.sealendtime);
		                       }
				 	     	}else{
				 	     		//sealObj.unstart++;
				 	     	}
				 	     }
				 	     if(  e.column.field=="design" ){
				 	     	if(column.design =='Y'){
				 	     	   if(showColorFlag==0){
		                          showHtml=checkShowColor(true,false,divIdCout++,column.designstarttime,column.designendtime);
		                       }else{
		                          showHtml=checkShowColor(false,false,divIdCout++,column.designstarttime,column.designendtime);
		                       }
				 	     	}else if(column.design =='N'){
				 	     	    if(showColorFlag==0){
		                          showHtml=checkShowColor(true,true,divIdCout++,column.designstarttime,column.designendtime);
		                       }else{
		                          showHtml=checkShowColor(false,true,divIdCout++,column.designstarttime,column.designendtime);
		                       }
				 	     	}else{
				 	     		//designObj.unstart++;
				 	     	}
				 	     }
				 	     if( e.field=="reserve"){
				 	     	if(column.reserve =='Y'){
				 	     	    if(showColorFlag==0){
		                          showHtml=checkShowColor(true,false,divIdCout++,column.reservestarttime,column.reserveendtime);
		                       }else{
		                          showHtml=checkShowColor(false,false,divIdCout++,column.reservestarttime,column.reserveendtime);
		                       }
				 	     	}else if(column.reserve =='N'){
				 	     	   if(showColorFlag==0){
		                          showHtml=checkShowColor(true,true,divIdCout++,column.reservestarttime,column.reserveendtime);
		                       }else{
		                          showHtml=checkShowColor(false,true,divIdCout++,column.reservestarttime,column.reserveendtime);
		                       }
				 	     	}else{
				 	     		//reserveObj.unstart++;
				 	     	}
				 	     }
				 	     if( e.field=="register"){
				 	     	if(column.register =='Y'){
				 	     	   if(showColorFlag==0){
		                          showHtml=checkShowColor(true,false,divIdCout++,column.registerstarttime,column.registerendtime);
		                       }else{
		                          showHtml=checkShowColor(false,false,divIdCout++,column.registerstarttime,column.registerendtime);
		                       }
				 	     	}else if(column.register =='N'){
				 	           if(showColorFlag==0){
		                          showHtml=checkShowColor(true,true,divIdCout++,column.registerstarttime,column.registerendtime);
		                       }else{
		                          showHtml=checkShowColor(false,true,divIdCout++,column.registerstarttime,column.registerendtime);
		                       }
				 	     	}else{
				 	     		//reserveObj.unstart++;
				 	     	}
				 	     }
				 	     //console.log("show html");
				 	     //console.log(showHtml);
				 	     if(showHtml!=""){
				 	         e.cellHtml=String.format(showHtml);
				 	     }
				 	     
	   		}); 
   		}
   		//
   		//初始化列表 
   		//function initList(){
   			  // var gridListData = getData("PM_PROD_RATE_SELECT","dictname");
   			   //var gridListData = getData("PM_PROD_TYPE_COMM","dictname");
   			   //console.log(gridListData);
		//var manygrid = nui.get("datagrid2");
		//var pubgrid = nui.get("datagrid3");
   		
   		//}
   		//判断颜色  //c:显示颜色各类 ,h是否显示一半,时间id,dt1:开始日期，dt2:结束日期
   		function checkShowColor(c,h,ids,dt1,dt2){
   		    if(dt1==null){
   		      dt1="";
   		    }
   		    if(dt2==null){
   		      dt2="";
   		    }
   		    var htmlstr="";
   		     //if(c){
   		        //blue(complate)&yellow(Running)
   		        if(h){
   		          //显示一半颜色 
   		          htmlstr='<div class="divline1_1" style="width:60%;height:30px;"><div id="'+ids+'" class="dateDiv">'+dt1+'</div></div>';
   		        }else{
   		          //显示全部颜色
   		          htmlstr='<div class="divline" style="width:100%;height:30px;"><div id="'+ids+'" class="dateDiv">'+dt1+'</div><div class="dateDiv1" id="'+ids+'">'+dt2+'</div></div>';
   		        }
   		     //}else{
   		       //yellow
   		     //  if(h){
   		          //显示一半颜色 
   		        //  htmlstr='<div  class="divline1_1" style="width:60%;height:30px;"><div id="'+ids+'" class="dateDiv">'+dt1+'</div></div>';
   		     //  }else{
   		          //显示全部颜色
   		        //    htmlstr='<div class="divline1" style="width:100%;height:30px;"><div id="'+ids+'" class="dateDiv">'+dt1+'</div><div class="dateDiv1" id="'+ids+'">'+dt2+'</div></div>';
   		     //  }
   		    // }
   		     return htmlstr;
   		}
		//设置颜色
		function setColor(e){
			title='style="background:#000; color:#FFF"';
			return title;
			
		}
		//获取数据
		//根据数据字典的ID 和 字段名称取出的对应的值 如果字段名称为空则取出查询实体的所有名称
		function getData(dictId,dictValue){
			var dictData = getDict(dictId);
			var queue = new Array();
			if(Boolean(dictData)){
			var Objs = dictData["proDict"];
			//console.log(Objs);
				if(dictValue){
					for( var i = 0; i < Objs.length;i++){
						for (x in Objs[i] ){
							if(x == dictValue){
								queue.push(Objs[i].dictname);
							}
						}
					}
					return queue;
				}else{
					return dictData;
				}
			}else{
				alert("数据字典未维护" +dictId);
				return null;
			}
		}
		//获取数据字典
		function getDict(dictName){
			var dict = dictName;
			var data = {dicttypeid:dict};
            var json = nui.encode(data);
            var result = null;
            if(json){
            	nui.ajax({
            	url:"com.cjhxfund.fpm.bpsExpend.prodInfo.getProdDict.biz.ext",
            	type:"post",
            	data:json,
            	async: false,
            	contentType:'text/json',
            	success:function(text){
            			result = text;
            		}
           		});
            }
            return result;
		}
		
		//组装数据
		//根据产品的各个状态组装成数据传入
		function assemblyData(proPhase,rawData,proType){
		    //console.log(proPhase);
		    //console.log(rawData);
		    //console.log(proType);
			var seriesArray = new Array();		
			for(var i=0;i<proPhase.length;i++){
				seriesArray[i]=new Array();
				seriesArray[i].phase = proPhase[i];
				var phaseno = null;
				for(var j = 0 ; j < proType.length; j++){
					for( var k = 0; k < rawData.length; k++){
						if(rawData[k].flag == proType[j] &&  rawData[k].phase == proPhase[i]){
							var obj = new Object();
							obj.numbers = rawData[k].numbers;
							obj.type =   proType[j];
							phaseNo = rawData[k].phaseno; 
							seriesArray[i].push(obj);
							
						}
					}
				}
				seriesArray[i].phaseno = phaseno;
				seriesArray[i].sort(
					function (a,b){
						var atype = a.type;
						var btype = b.type;
						return btype.localeCompare(atype);
					}
				);
			}
			//console.log(seriesArray);
			return seriesArray;
		}
		
		//加载数据
		function loadData(){
		   var datas = null;
			nui.ajax({
				url:"com.cjhxfund.fpm.bpsExpend.prodInfo.queryProdPhase.biz.ext",
				type:"post",
				async: false,
            	contentType:'text/json',
				success:function(text){
					var result = nui.decode(text);
					var Objs = result["proInfo"];
					datas = Objs;
				}
			});
			return datas;
		}
		
		function getResult(graphData){
			var result = [0,0,0];
			for( var i = 0; i< graphData.length;i++){
				var temp = graphData[i];
				result[i] = temp.numbers;
			}
			return result;
		}
		
		//生成柱状图
		function draw(){
		var myChart = echarts.init(document.getElementById("graph"));
	    //获取产品字典;
	    var proType = getData("PM_PROD_TYPE_COMM","dictname");
	    var proPhase = getData("PM_PROD_STATUS","dictname");
	    var chartTYpe = 'bar';
	    //获取产品各阶段的数量
	   var rawData = loadData();
	   var graphData = assemblyData(proPhase,rawData,proType);	   
	   proType.sort(function (a,b){
						return b.localeCompare(a);
					});
		var prodCreate = new Object();
		//var prodRefund = new Object();
		//var prodConstruct = new Object();
		//var prodOn = new Object();
		//var prodEnd = new Object();
		prodCreate.phase = graphData[0].phase;
		//prodCreate.phase="";
		prodCreate.data = getResult(graphData[0]);
		//prodRefund.phase = graphData[1].phase;
		//prodRefund.phase ="";
		//prodRefund.data = getResult(graphData[1]);
		//prodConstruct.phase = graphData[2].phase;
		//prodConstruct.phase ="";
		//prodConstruct.data = getResult(graphData[2]);
		//prodOn.phase = graphData[3].phase;
		//prodOn.phase = "";
		//prodOn.data = getResult(graphData[3]);
		//prodEnd.phase = graphData[4].phase;
		//prodEnd.phase ="";
		//prodEnd.data = getResult(graphData[4]); 
		var yaxisData=window.navigator.userAgent.indexOf("Chrome") !==-1 ? ['公募','一对多','一对一']:['一对一','一对多','公募'];
      	var option = {
      			//tooltip : {
			      //  axisPointer : {            
			        //    type : 'shadow'       
			      //  }
    			//},
    			grid :{
			        y:20,
			        y2:30
				},
			    legend: {
			        data:proPhase
			        
			    },
			    calculable : true,
			    xAxis : [
			        {
			            type : 'value',
			            scale:false
			        }
			    ],
			    yAxis : [
			        {
			            type : 'category',
			            //data : ['公募','一对多','一对一']//proType
			            data:yaxisData
			        }
			    ],
			    series : [
			        {
			            name:prodCreate.phase,
			            type:chartTYpe,
			            stack: '总量',
			            barWidth:'20px',
			            itemStyle : { normal: {label : {show: true}}},
			            data:prodCreate.data
			        }
			       // {
			        //    name:prodRefund.phase,
			         //   type:chartTYpe,
			         //   stack: '总量',
			         //   barWidth:'20px',
			        //    itemStyle : { normal: {label : {show: true}}},
			        //   data:prodRefund.data
			       // },
			        //{
			         //   name:prodConstruct.phase,
			         //   type:chartTYpe,
			         //   stack: '总量',
			         //   barWidth:'20px',
			         //   itemStyle : { normal: {label : {show: true}}},
			         //   data:prodConstruct.data
			       // },
			      //  {
			         //   name:prodOn.phase,
			        //    type:chartTYpe,
			         // stack: '总量',
			          //  barWidth:'20px',
			          //  itemStyle : { normal: {label : {show: true}}},
			          //  data:prodOn.data
			       // },
			       // {
			         //   name:prodEnd.phase,
			         //   type:chartTYpe,
			         //   stack: '总量',
			         //   barWidth:'20px',
			          //  itemStyle : { normal: {label : {show: true}}},
			          //  data:prodEnd.data
			        //}
			    ]
		};

        myChart.setOption(option);
      }
          // myChart.on('click', function (params) {
       //update by chenxing
       function renderType(params){
            //console.log("params");
            //console.log(params);
        	//$("#barTitle").text(params.name);
        	isSelectProdType=true;
			if(params.text == publicTypeName){
		    	typename = params.text;
		    	getSinglePhase(typename);
				grid =  pubgrid;
				nui.get("datagrid1").hide();
				nui.get("datagrid2").hide();
				nui.get("datagrid3").show();
				render();
				params.datagridname = "datagrid3";
			}else if( params.text == one2oneTypeName || params.text ==""){
				typename = one2oneTypeName;
			    getSinglePhase(typename);
				grid = onegrid;
				nui.get("datagrid1").show();
				nui.get("datagrid2").hide();
				nui.get("datagrid3").hide();
				render();
				params.datagridname = "datagrid1";
			}else{
				typename = params.text;
				getSinglePhase(typename);
				grid = manygrid;
				nui.get("datagrid1").hide();
				nui.get("datagrid2").show();
				nui.get("datagrid3").hide();
				render();
				params.datagridname = "datagrid2";
			}
        	search(params);
        	needSum=true;
        	//按条件查询 
        	//alert(nui.get("prodName").value);
        	if(nui.get("prodName").value!=""){
        	   //alert(123);
        	   iTime=setTimeout("query()",500);
        	}
       // });
       }
       //清除
       function clearTimeoutFunc(){
          if (iTime !=""){
             clearTimeout(iTime); 
             iTime="";
          } 
       }
      //产品阶段明细
      function search(params) {
            var phase = "产品成立";
            var datagrid = params.datagridname;
            var json = {prodType:typename,phase:phase,sortField:"prodName"}
			nui.ajax({
				url:"com.cjhxfund.fpm.bpsExpend.prodInfo.getProPhase.biz.ext",
				type:"post",
				data:json,
				success:function(text){
					nui.get(datagrid).load(json);
				}
			});
            
      }
      //查询
      //显示详细信息
      //progress
      function progress(){
	        	var row = grid.getSelected();
	        	if(!row) return;
	        	if( row.reserveprocessinstid ||  row.designprocessinstid
	        	 || row.sealprocessinstid || row.supplyprocessinstid) {
		        	nui.open({
		                //url:contextPath + "/util/proInformation/ProdprogressBar.jsp?row="+nui.encode(row),
		                url:contextPath + "/bpsExpend/processComm/progressBarComm.jsp?row="+nui.encode(row),
		                title: "产品流程进度条查看",
		                id: "progressPanel",
		                width: "98%",
		                height: "100%",
		                ondestroy: function (action) {
		                	
		                }
		            });
	            }else{
	            	return ;
	            }
	     }
	   //初始化统计数据
	   function clearStatistics(e){
		reserveObj.done = 0;
		reserveObj.doing =0;
		reserveObj.unstart = 0;
		designObj.done = 0;
		designObj.doing =0;
		designObj.unstart = 0;
		sealObj.done = 0;
		sealObj.doing =0;
		sealObj.unstart = 0;
		supplyObj.done = 0;
		supplyObj.doing =0;
		supplyObj.unstart = 0;
		
		registerObj.done = 0;
		registerObj.doing =0;
		registerObj.unstart = 0;
		
	   }
	   //获取统计数据
/* 	   function getStatistics(e){
	   	getSinglePhase(typename);	
	   } */
	   
	   //获取产品的阶段统计
	   function getSinglePhase(typename){
	  	 var json = {typename:typename};
		   	$.ajax({
					url:"com.cjhxfund.fpm.bpsExpend.prodInfo.querySimplePhase.biz.ext",
					type:"post",
					data:json,
					async:false,
					success:function(text){
						var proInfo = text.proInfo;
						reserveObj.unstart = proInfo[0].reserveunstart;
						reserveObj.doing = proInfo[0].reservedoing;
						reserveObj.done = proInfo[0].reservedone;
						
						designObj.unstart = proInfo[0].designunstart;
						designObj.doing = proInfo[0].designdoing;
						designObj.done = proInfo[0].designdone;
						
						sealObj.unstart = proInfo[0].sealunstart;
						sealObj.doing = proInfo[0].sealdoing;
						sealObj.done = proInfo[0].sealdone;
						
						supplyObj.unstart = proInfo[0].supplyunstart;
						supplyObj.doing = proInfo[0].supplydoing;
						supplyObj.done = proInfo[0].supplydone;
						
						registerObj.unstart = proInfo[0].registerunstart;
						registerObj.doing = proInfo[0].registerdoing;
						registerObj.done = proInfo[0].registerdone;
					}
				});
	   }
	   
	   function onDrawSummaryCell(e) {
	   		if(typename==""){
	   		   typename = one2oneTypeName;
	   		}
	   		getSinglePhase(typename);
	   		if(!needSum){
	   			return ;
	   		}
            if (typename == "一对一") {
            	if(e.field == "reserve"){  
	                var s = "<div class='nui-fit' style='font-size:9pt;'>"
	                s +=      "进行中：" + reserveObj.doing + '  '+ "已完成:" +reserveObj.done 
	                        + "</div>";
	                e.cellHtml = s;
                }
                if(e.field == "design"){  
	                var s = "<div class='nui-fit' style='font-size:9pt;'>"
	                s +=     "进行中:" + designObj.doing + '  '+ "已完成:" +designObj.done 
	                        + "</div>";
	                e.cellHtml = s;
                }
                if(e.field == "seal"){  
	                var s = "<div class='nui-fit' style='font-size:9pt;'>"
	                s +=      "进行中:" + sealObj.doing + '  '+ "已完成:" +sealObj.done 
	                        + "</div>";
	                e.cellHtml = s;
                }
                if(e.field == "supply"){  
	                var s = "<div class='nui-fit' style='font-size:9pt;'>"
	                s +=      "进行中:" + supplyObj.doing + '  '+ "已完成:" +supplyObj.done 
	                        + "</div>";
	                e.cellHtml = s;
                }
            }else if(typename == "一对多"){
            	if(e.field == "reserve"){  
	                var s = "<div class='nui-fit' style='font-size:9pt;'>"
	                s +=     "进行中:" + reserveObj.doing + '  '+ "已完成:" +reserveObj.done 
	                        + "</div>";
	                e.cellHtml = s;
                }
                if(e.field == "design"){  
	                var s = "<div class='nui-fit' style='font-size:9pt;'>"
	                s +=     "进行中:" + designObj.doing + '  '+ "已完成:" +designObj.done 
	                        + "</div>";
	                e.cellHtml = s;
                }
                if(e.field == "seal"){  
	                var s = "<div class='nui-fit' style='font-size:9pt;'>"
	                s +=    "进行中:" + sealObj.doing + '  '+ "已完成:" +sealObj.done 
	                        + "</div>";
	                e.cellHtml = s;
                }
                if(e.field == "supply"){  
	                var s = "<div class='nui-fit' style='font-size:9pt;'>"
	                s +=     "进行中:" + supplyObj.doing + '  '+ "已完成:" +supplyObj.done 
	                        + "</div>";
	                e.cellHtml = s;
                }
            }else{
            	if(e.field == "reserve"){  
	                var s = "<div class='nui-fit' style='font-size:9pt;'>"
	                s +=     "进行中:" + reserveObj.doing + '  '+ "已完成:" +reserveObj.done 
	                        + "</div>";
	                e.cellHtml = s;
                }
                if(e.field == "design"){  
	                var s = "<div class='nui-fit' style='font-size:9pt;'>"
	                s +=     "进行中:" + designObj.doing + '  '+ "已完成:" +designObj.done 
	                        + "</div>";
	                e.cellHtml = s;
                }
                if(e.field == "register"){  
	                var s = "<div class='nui-fit' style='font-size:9pt;'>"
	                s +=     "进行中:" + registerObj.doing + '  '+ "已完成:" +registerObj.done 
	                        + "</div>";
	                e.cellHtml = s;
                }
            }
        }
        
        //产品阶段明细
      function query(e) {
            //console.log("select ....");
            //console.log(nui.get("prodName"));
            //console.log(e);
            var prodName;
            if(typeof(e)=="undefined"){
               prodName = nui.get("prodName").value;
            }else{
               prodName = e.source.text;
            }
            if(typename==""){
	   		   typename = one2oneTypeName;
	   		}
            var prodType = typename;
            
            needSum = false;
            //alert(prodName+","+prodType);
            var json = {prodName:prodName,prodType:prodType,sortField:"prodName"};
            //alert(prodName+","+prodType+","+grid);
			nui.ajax({
				url:"com.cjhxfund.fpm.bpsExpend.prodInfo.getProPhase.biz.ext",
				type:"post",
				data:json,
				async:false,
				success:function(text){
					nui.get(grid).load(json);
				}
			});
		    clearTimeoutFunc();
      }
          //点击模糊查询产品名称 
	function queryProdName(){
		var t = nui.get("prodName");
	    //t.params = {prodName:nui.get("prodName").getValue()};
	    //console.log(t);
	   	t.doQuery();
	}
    </script>
</body>
</html>