<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/processCommon.jsp"%>
<!-- 
  - Author(s): jiankanqian
  - Date: 2017-06-25
  - Description: 
-->

    
<html id="mainHtml">
	<head>
	    <title>
	    </title>
	    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	    <link rel="stylesheet" href="<%= request.getContextPath() %>/bootstrap/css/bootstrap.min.css" />
	    <link rel="stylesheet" href="<%= request.getContextPath() %>/bootstrap/css/bootstrap-responsive.min.css" />
	    <script src="<%= request.getContextPath() %>/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	    <script src="<%= request.getContextPath() %>/bpsExpend/processComm/js/jsplumb/jquery-1.11.1.min.js"></script>
        <script src="<%= request.getContextPath() %>/bpsExpend/processComm/js/jsplumb/jquery-ui-1.9.2.min.js"></script>
        <script src="<%= request.getContextPath() %>/bpsExpend/processComm/js/jsplumb/jquery.jsPlumb-1.7.2.js"></script>
	    <style type="text/css">
			.itemnotfinish{
			  border: 1px solid black;
              width: 200px;
              height: 60px;
              position: absolute;
			  background-color: #ffffff;
			  background-image: -moz-linear-gradient(top, #ffffff, #ffffff);
			  background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#ffffff), to(#ffffff));
			  background-image: -webkit-linear-gradient(top, #ffffff, #ffffff);
			  background-image: -o-linear-gradient(top, #ffffff, #ffffff);
			  background-image: linear-gradient(to bottom, #ffffff, #ffffff);
			  background-repeat: repeat-x;
			  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#ffffff', GradientType=0);
			}
			.itemruning{
              border: 1px solid black;
              width: 200px;
              height: 60px;
              position: absolute;
              background-color: #DA4E49;
			  background-image: -moz-linear-gradient(top, #DA4E49, #DA4E49);
			  background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#DA4E49), to(#DA4E49));
			  background-image: -webkit-linear-gradient(top, #DA4E49, #DA4E49);
			  background-image: -o-linear-gradient(top, #DA4E49, #DA4E49);
			  background-image: linear-gradient(to bottom, #DA4E49, #DA4E49);
			  background-repeat: repeat-x;
			  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#DA4E49', endColorstr='#DA4E49', GradientType=0);
          }
          .itemfinish{
              border: 1px solid black;
              width: 200px;
              height: 60px;
              position: absolute;
              background-color: #44ABC9;
			  background-image: -moz-linear-gradient(top, #44ABC9, #44ABC9);
			  background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#44ABC9), to(#44ABC9));
			  background-image: -webkit-linear-gradient(top, #44ABC9, #44ABC9);
			  background-image: -o-linear-gradient(top, #44ABC9, #44ABC9);
			  background-image: linear-gradient(to bottom, #44ABC9, #44ABC9);
			  background-repeat: repeat-x;
			  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#44ABC9', endColorstr='#44ABC9', GradientType=0);
            }
		    fieldset
		    {
		        border-left:0px;
		        border-right:0px;
		        border-bottom:0px;
		        width:98%;
		        line-height: 20px;
		    }
		    fieldset legend{
		     	font: bold 16px/2 Verdana, Geneva, sans-serif;
		    	
		    }
		    th{
		    	border-left: 1px solid #989898;vertical-align: text-top;text-align: right;
		    }
	    </style>
	</head>
	<body>
		<div id="mainDiv" style="width:97%;height: 450px;border: 0px;">
			<input class="nui-hidden" id="bizId" value="${param.bizId}"/>
			<fieldset>
					<h4><div id="barTitle"  style="float:left;padding-left: 20px" ></div></h4><br/>
					<div>
						<div style="float:left;margin-left:20px;margin-top:4px;background-color: #44ABC9;border:1px solid #444444;width:12px;height: 12px;"></div>
						<font style="float:left;font-size: 12px;">已完成&nbsp;</font>
						<div style="float:left;margin-top:4px;background-color: #DA4E49;border:1px solid #444444;width:12px;height:12px;"></div>
						<font style="float:left;font-size: 12px;">执行中&nbsp;</font>
						<div style="float:left;margin-top:4px;background-color: #ffffff;border:1px solid #444444;width:12px;height: 12px;"></div>
						<font style="float:left;font-size: 12px;">未执行&nbsp;</font>
					</div>
				<div id="bar">
				     
				</div>
			</fieldset>
		</div>
	<script type="text/javascript">
    	nui.parse();
		//业务类型
		var _bizType = "${param.bizType}";
		//流程ID
		var _processInstId = "${param.processInstId}";
    	 //启动中活动
    	var _acting = "acting";
    	//执行完活动
    	var _actFinish = "acted";
    	//未启动活动
    	var _actNot = "notAct";
    	//参与人数组
    	//var _actor = [];
    	//活动数组
    	var _activityTreeArray = [];
    	
    	//流程显示长度
    	var _lengthNum=0;
         //返回的div
        var _resultDiv="";
    	//流程连线颜色
    	var color1 = "#316b31";
    	//父接点
    	var parentActivity="";
    	//记录深度的个数
        var depsArray = new Array();
    	
    	//当前ID是否有深度。
    	var currentDiptFlag="0";
    	var marLeftCount=1;
    	//上一个div是否是有深度
    	var divPreIsDept="n";
    	var divPreLen=0;
    	var contextId=0;
    	var defaultAnchors = ["Top", "Right", "Bottom", "Left", [0.25, 0, 0, -1], [0.75, 0, 0, -1], [0.25, 1, 0, 1], [0.75, 1, 0, 1],[0, 0.25, 0, -1], [0, 0.75, 0, -1], [1, 0.25, 0, 1], [1, 0.75, 0, 1]];
  
    	loadProcessBarData();
    	//加载动态数据
    	function loadProcessBarData(){
    		nui.ajax({
	     		type:"post",
	     		url:"com.cjhxfund.fpm.bpsExpend.processBar.processBarComm.biz.ext",
	     		data:{bizType:_bizType,processInstID:_processInstId},
	     		cache:false,
	     		async:false,
	     		contentType:'text/json',
	     		success:function(data){
	     		    var obj = eval('(' + data.resultJson + ')');
	     		    _activityTreeArray = obj.tree; //activity
	     			//console.log("startTree.....");
	     		    //console.log(obj);
	     		    //console.log(_activityTreeArray);
	     		    //console.log("endTree.....");
	     			//$("#barTitle").text(_prodName);
	     			//设置流程名称 
	     			getProcessNameById();
	     		}
	     	});
    		//加载jsplumb工具
    		loadjsplumb(); 	
    	}
    	//获取流程名称
    	function getProcessNameById(){
    	    nui.ajax({
	     		type:"post",
	     		url:"com.cjhxfund.fpm.bpsExpend.processBar.getprocessNameForBarComm.biz.ext",
	     		data:{procInstID:_processInstId},
	     		cache:false,
	     		async:false,
	     		contentType:'text/json',
	     		success:function(data){
	     			$("#barTitle").text(data.procName);
	     		}
	     	});
    	}
    	function writeMarginAndTop(id,name,stat,mar,to,acter){
    	   if(currentDiptFlag=="0"){ 
    	      if(id==0){
    	         mar=0;
    	      }else{
    	         mar+=5; //看起来紧
    	      }
    	   }
    	     
     	   if(stat == _acting){
 	           _resultDiv='<div id="activity'+id+'" class="itemruning" style="text-align:center;float:left;margin-left:'+mar+'px;top:'+to+'px">'+name+'</div>';
     	   }else if(stat == _actFinish){  	//执行完活动
     	        _resultDiv='<div id="activity'+id+'" class="itemfinish" style="text-align:center;float:left;margin-left:'+mar+'px;top:'+to+'px">'+name+'</div>';
     	   }else if(stat == _actNot){  //未启动活动
     	         _resultDiv='<div id="activity'+id+'" class="itemnotfinish" style="text-align:center;float:left;margin-left:'+mar+'px;top:'+to+'px">'+name+'</div>';
     	   }else{
     	   }
     	   to+=60;
     	   _resultDiv+='<div style="width:200px;position:absolute;margin-left:'+mar+'px;top:'+to+'px">';
     	   //不需要拆分时间 
     	   //var actorGroup="";
     	  // for(var i=0;i<acter.length;i++){
     	   //       actorGroup = acter[i].replace("|",",");
     	    //      _resultDiv+=actorGroup+",";
     	  // }
     	    //var len = _resultDiv.length-1;
     	  // _resultDiv = _resultDiv.substring(0,len);
     	  _resultDiv+=acter+'</div>';
     	}
     	//获取margin长度
     	function getStyleMarginLeng(id){
     	     var objLeft=0;
     	     if(id!=0){
     		      var obj =  document.getElementById("activity"+(id-1)).style.marginLeft;
     		      var len = obj.length-2;
     		      objLeft = obj.substring(0,len);
     		      //console.log("len : "+obj+","+len+"，"+obj.substring(0,len));
     		 }
     		 return objLeft;
     	}
     	function buildDiv(id,name,sts,deptSts,acter){ //deptSts=0 没有深度，deptSts大于0有深度  
     	   //console.log("buildDiv : "+id+","+name+","+sts+","+deptSts);
     	   var flag=1;
     	   var counts=0;
     	   //返回的div
            //var _resultDiv="";
            var tops=240;
     	   if(_resultDiv == ""){
     	       flag=0;
     	   }
     	   if(flag==0 || deptSts==0){
     		       currentDiptFlag="0";
     		      //var counts = Math.abs(mar-divPreLen);
     		      var objLeft=getStyleMarginLeng(id);
                 if(divPreIsDept == "y"){
                   _lengthNum =  parseInt(objLeft)+200; //80和 itemruning这些的width有关，+100是根据实际情况而定 。
                 }else{
                   if(id!=0){
                       if(id==1){
                           _lengthNum = 200; //80 和 itemruning这些的width有关，+100是根据实际情况而定 。
                       }else{
                          _lengthNum = parseInt(objLeft)+200; //80 和 itemruning这些的width有关，+100是根据实际情况而定 。
                       }
                   }
                 }
     	        //console.log("ND : "+_lengthNum+",margin="+objLeft);
 	    	    //$("#activity"+id).css({"margin-left":(_lengthNum)+"px"})
 	    	    if(depsArray.length>1){
 	    	        //counts = tops/12; //显示的第一个深度
 	    	        counts = 0;
 	    	    }else{
 	    	        counts = tops; //平常没有深度
 	    	    }
 	    	    //$("#activity"+id).css("top",(counts)+"px"); //60 和 itemruning这些的height有关
 	    	    writeMarginAndTop(id,name,sts,_lengthNum,counts,acter);
 	    	    //divPreIsDept="n";
 	    	    divPreLen=0;
 	    	    contextId++;
     	   }else{
 	    	    var position=0;
 	    	    divPreIsDept="y";
 	    	    currentDiptFlag="1";
 	    	    divPreLen=depsArray.length;
 	    	    //var depsLen =depsArray.length;
 	    	    for(var i=0;i<depsArray.length;i++){
 	    	        if(id==depsArray[i]){
 	    	           position=i;
 	    	           break;
 	    	        }
 	    	    }
 	    	    _lengthNum=getStyleMarginLeng(id);
 		       // console.log("YD2 : "+_lengthNum);
 		    	 //var resCount = depsLen-(position+1);
 	    	     counts = tops/2*position;
 	    	    //$("#activity"+id).css("top",(counts)+"px"); //60 和 itemruning这些的height有关
     	        writeMarginAndTop(id,name,sts,_lengthNum,counts,acter);
     	   }
     	   
     	   	//var realWidth = _lengthNum;
     		//var width = realWidth<900?900:realWidth;
     		//$("#mainHtml").css("width",(width+20)+"px");
     	   	//console.log("html : "+_resultDiv);
     	   	$("#bar").css({"margin-top":"350px"});
     	    //$("#bar").html(_resultDiv);
     	    $("#bar").append(_resultDiv);
     	}
    	function loadjsplumb(){
    	    //单 个活动
	        var activ="";
	    	//活动名称
	    	var activityName="";
	    	//活动状态
	    	var actStatus = "";
	    	var divId;
	    	//流程数量
	    	var activNum=0;
	    	//判断是否有深度上一个
	    	var getDepNodeValueFront="";
	    	//判断是否有深度当前一个
	    	var getDepNodeValueCurrent="";
	    	var i;
	    	//参与者
	    	var actors=[];
    	     //初始化
    	     jsPlumb.ready(function() {
	                jsPlumb.importDefaults({
	                DragOptions : { cursor: 'pointer', zIndex:2000 },
	                PaintStyle : { strokeStyle:'#666' },
	                EndpointStyle : { width:5, height:5, strokeStyle:'#666' },
	                Endpoint : "Rectangle",
	                Anchors : [defaultAnchors]
	               });
			        var basicType = {
			            connector: "StateMachine",
			            paintStyle: { strokeStyle: "red", lineWidth: 4 },
			            hoverPaintStyle: { strokeStyle: "blue" }
			        };
     			    jsPlumb.registerConnectionType("basic", basicType);
     			    //开始创建流程图
     			      for(i=0;i<_activityTreeArray.length;i++){
			    	         activ = _activityTreeArray[i];
			    	         getDepNodeValueFront = getDepNodeValueCurrent;
			    	         getDepNodeValueCurrent = activ.depth;
			    	         //console.log("start.....");
			     		     //console.log(activ);
			     		     //console.log("end....."+activ.currentState+","+getDepNodeValueFront+","+getDepNodeValueCurrent);
			     		     //活动名称 
				    	     activityName =activ.activityInstName;
				    	     actStatus = activ.currentState;
				    	     //统计深度数量 
				    	     getDepNodeCount(getDepNodeValueCurrent);
				    	     //处理参与者
				    	     //actors = buildActors(activ.actors); //不拆除时间
				    	     actors = activ.actors;
			    	         if(getDepNodeValueCurrent == getDepNodeValueFront){
			    	             //获取到父节点
			    	            // parentActivity = getParentDepNode(_activityTreeArray[i].lastDepthActivity);
			    	             //console.log("start1.....");
		     		             //console.log(_activityTreeArray[i].lastDepthActivity);
		     		             //console.log("end1....."+activityName+","+actStatus);
			    	             buildDiv(i,activityName,actStatus,1,actors); // deptSts=0 没有深度，deptSts大于0有深度  
			    	             divId="activity"+i;
			    	             create("left"+i,"LeftMiddle",divId);
			    	             create("right"+i,"RightMiddle",divId);
			    	            // create("top"+i,"BottomCenter",divId);
			    	             //createconnect(i,parentActivity,null);//deptPrevActivity 有深度时，非空,nextActivity ==null
				    	      }else{
				    	          marLeftCount=0;
				    	          //activNum_i = _lengthNum;
				    	          buildDiv(i,activityName,actStatus,0,actors);// deptSts=0 没有深度，deptSts大于0有深度  
				    	          divId="activity"+i;
				    	          if(i!=0){ //判断第一个
				    	             create("left"+i,"LeftMiddle",divId);
				    	          }
				    	          if((i+1)!=_activityTreeArray.length){ //判断最后一个
				    	              create("right"+i,"RightMiddle",divId);
				    	              //
				    	            //  create("top"+i,"BottomCenter",divId);
				    	              //create("top"+i,"TopCenter",divId);
				    	          }
				    	          divPreIsDept="n";
				    	          //createconnect(activNum_i,null,activNum);// deptPrevActivity 有深度时，非空,nextActivity ==null
				    	      }
			    	   }
			    	   //重置当前深度 
			    	   getDepNodeValueCurrent="";
			    	   var nextArrays=[];
			    	   var j;
			    	   var istop;
			    	   //加载连线
			    	   //for(i=0;i<_activityTreeArray.length;i++){
				    	 //    nextArrays = _activityTreeArray[i].nextActivities;
				    	  //   if(nextArrays.length>0){
				    	  //   for(j=0;j<nextArrays.length;j++){
				    	   //         parentActivity = getParentDepNode(nextArrays[j]);
				    	    //              createconnect("right"+i,null,"left"+parentActivity);
				    	   //  }
				          //  }
				    	  // nextArrays=[];
			    	 //  } 
 
     		});
    	    jsPlumb.setSuspendDrawing(false,true);
    	}
    	//处理参与者 
    	function buildActors(act){
    	     var actors = [];
    	     var actor="";
    	     var actorArr=[];
    	     var actCount=0;
             var resultActorArray=new Array();
    	     if(act !=null && act != ""){
    	         actors= act.split("<br/>");
    	         for(var i=0;i<actors.length;i++){
    	               actor = actors[i];
    	               if(act !=null && actor!=""){
	    	               actorArr = actor.split(" - ");
	    	               resultActorArray[actCount]=actorArr[0];
	    	               actCount++;
	    	           }
    	         }
    	     }
    	     return resultActorArray;
    	}
    	//开始新建 
    	function create(uid,position,div_id){
    	    var point = {
                uuid:uid,
                //anchor:position,//连接点的位置，可以被覆盖
                anchor:["Continuous", {faces:["right","left","top","bottom"] }],
                paintStyle:{ fillStyle:color1 },//连接点的颜色
                 endpoint:["Dot", { radius:3 }],//连接点的形状、大小
                isSource:true, //是否可以拖动（作为连线起点）  
                scope:"green dot",//只有标识符相同的连接点才能连接 
                connectorStyle:{ strokeStyle:color1, lineWidth:1 },//点与点之间连线颜色
                connector: ["StateMachine", { curviness:25 } ],//线条形状，可弯曲
                //connector: ["Bezier", { curviness:20 } ],//线条形状，可弯曲
                //connector: ["Flowchart", { curviness:63 } ],
                //connector:["Straight", { curviness:63 } ], //直线
                maxConnections:30,
                isTarget:true,//是否可以放置（作为连线终点）  
              //  dropOptions : exampleDropOptions
            };
            jsPlumb.addEndpoint(div_id,point);
            //console.log("creat2......");
            //console.log(point);
            //console.log(point+","+div_id);
            // return point;
    	}
    	//开始连接
    	function createconnect(currentActivity,deptPrevActivity,nextActivity){//deptPrevActivity 有深度时，非空,nextActivity ==null
    	    //console.log("createconnect......");
    	    //console.log(currentActivity+","+nextActivity+","+deptPrevActivity);
    	   //var arrowCommon = {foldback: .7, fillStyle: color, width: 14};
    	    //overlays = [
              //  ['Arrow', {location:.8}, arrowCommon],
                // ['Arrow', {location:.3, direction:-1}, arrowCommon],
               // ];
    	    if(deptPrevActivity!=null && nextActivity==null){
    	        //jsPlumb.addEndpoint(divId,creat);
    	        jsPlumb.connect({uuids:[deptPrevActivity,currentActivity],editable:false});
    	    }else{
    	        if(currentActivity != nextActivity){
    	           //  jsPlumb.addEndpoint(divId,creat);
    	             jsPlumb.connect({uuids:[currentActivity,nextActivity],editable:false,reattach:true});
    	        }
    	      
    	    }
    	}
       //获取父类
    	function getParentDepNode(parentNode){
    	       var activInsId="";
    	       for(var i=0;i<_activityTreeArray.length;i++){
    	          if(_activityTreeArray[i].activityInstId == parentNode){
    	              activInsId=i;
    	              break;
    	          }
    	       }
    	       return activInsId;
    	}
    	//统计深度个数
    	//获取深度为depth的节点
    	function getDepNodeCount(depth){
    		var count = 0;
    		var dep="";
    		depsArray=new Array();
    	    for(var i=0;i<_activityTreeArray.length;i++){
    	        dep = _activityTreeArray[i].depth;
    			if(dep == depth){    				
    				depsArray[count]=i;
    				count++;   				
    			}
    		}
    	}
    	//判断是否连接顶上
    	function checkConnectTop(cur_i,nextId){
    	    var valueid="N";
    		var id="";
    	    for(var i=0;i<_activityTreeArray.length;i++){
    	        id = _activityTreeArray[i].activityInstId;
    			if(id == nextId){    				
    				//if(Math.abs(cur_i-i)>1){
    				if((i-cur_i)<1){
    				   valueid = "Y";
    				}			
    			}
    		}
    		return valueid;
    	}
    </script>
    </body>
</html>