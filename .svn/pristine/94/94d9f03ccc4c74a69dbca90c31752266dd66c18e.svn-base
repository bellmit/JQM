  	nui.parse();
	//加载表单数据
    var form = new nui.Form("#form1");
    var processForm=new nui.Form("#processForm");
    var processInstID = document.getElementById("processInstID").value;
    var workItemID = document.getElementById("workItemID").value;
    var rationType=document.getElementById("rationType");
    if(rationType!=null && rationType!=""){
    	var data = {processInstID:processInstID,rationType:"00"}; //获取表单多个控件的数据
    }else{
    	var data = {processInstID:processInstID};
    }
    var grid = nui.get("datagrid1");
    if(grid!=null){
    	grid.load(data,function(){
    		nui.ajax({
    	        url: "com.cjhxfund.ats.ipo.busOpr.queryIpoInstructInfo.biz.ext",
    	        type: "post",
    	        data: json,
    	        contentType:'text/json',
    	        success: function (text) {
    	        	//反序列化成对象
    	        	var info = text.ipoInstructInfo; 
    				// 设置多个控件数据
    				form.setData(text);
    				var lInquiryDate=nui.encode(info.lInquiryDate);
    				var lOfflinePurchaseDate=nui.encode(info.lOfflinePurchaseDate);
    				nui.get("lInquiryDate").setValue(strToDate(lInquiryDate));
    				nui.get("lOfflinePurchaseDate").setValue(strToDate(lOfflinePurchaseDate));
    				//发行人总股本（万股）=发行后总股本（万股）
    			    if(nui.get("stockAll")){
    			    	var enTotalEquity=nui.get("enTotalEquity").getValue();//发行后总股本（万股）
        	    		nui.get("stockAll").setValue(enTotalEquity);//发行人总股本（万股）
    			    }
    	        }
    	    });
    	});
    }
    var json = nui.encode(data);   //序列化成JSON           
    function strToDate(dateStr){
		var year = dateStr.slice(0,4);
		var month = dateStr.slice(4,6);
		var date = dateStr.slice(6,8);
		var finalDate = year + "-" + month + "-" + date;
		return finalDate;
	}
    processControlLoadData(processForm,workItemID);
    function processControlLoadData(formName,workItemID){
    	var processData = {workItemID:workItemID};
    	var processJson = nui.encode(processData);   //序列化成JSON 
    	nui.ajax({
            url: "com.cjhxfund.ats.ipo.task.queryPreviousWork.biz.ext",
            type: "post",
            data: processJson,
            contentType:'text/json',
            success: function (text) {
            	var approveInfo=text.approveInfos;
            	if(approveInfo.length>0){
            		$("#stockTd").append("<label>"+approveInfo[0].processInstName+"<label>");
            		$("#currentTd").append("<label>"+approveInfo[0].currentWorkItemName+"<label>");
            		//判断前驱活动实例的数量，多于一个，需要添加多个展示行
            		var actInstNum=approveInfo[0].actInstNum;
            		if(actInstNum==0){
            			$("#processTbl").append("<tr>"+
            					"<td class='td1' width='15%' align='right'>"
            					+"上一节点: </td>"
            					+"<td colspan='3' class='td2' width='85%''>"
            					+approveInfo[0].vcWorkItemName
            					+"</td>"
            					+"</tr>");
            			for(var i=0;i<approveInfo.length;i++){
            				$("#processTbl").append("<tr>"+
                					"<td class='td1' width='15%' align='right'>"
                					+"上一节点参与者: </td>"
                					+"<td colspan='3' class='td2' width='85%''>"
                					+approveInfo[i].vcUserName+"&nbsp;&nbsp;审批意见:"
                					+approveInfo[i].vcComments
                					+"</td>"
                					+"</tr>");
            			}
            		}
            		if(actInstNum==1){
            			var previousID=approveInfo[0].previousID;
            			var activityInstID=previousID.split(",");
            			for(var i=0;i<activityInstID.length;i++){
            				$("#processTbl").append("<tr>"+
                					"<td class='td1' width='15%' align='right'>"
                					+"上一节点: </td>"
                					+"<td colspan='3' class='td2' width='85%''>"
                					+approveInfo[i].vcWorkItemName
                					+"</td>"
                					+"</tr>");
            				for(var j=0;j<approveInfo.length;j++){
            					if(activityInstID[i]==approveInfo[j].lActivityInstId){
            						$("#processTbl").append("<tr>"+
                        					"<td class='td1' width='15%' align='right'>"
                        					+"上一节点参与者: </td>"
                        					+"<td colspan='3' class='td2' width='85%''>"
                        					+approveInfo[j].vcUserName+"&nbsp;&nbsp;审批意见:"
                        					+approveInfo[j].vcComments
                        					+"</td>"
                        					+"</tr>");
            					}
            				}
            			}
            	
            		}
            	}else{
            		$("#stockTd").append("<label>"+approveInfo[0].processInstName+"<label>");
            		$("#currentTd").append("<label>"+approveInfo[0].currentWorkItemName+"<label>");
            	}
            }
        });
    }
    
  
  //已办项隐藏审批内容及操作按钮
    (function (){
    	var vcType=nui.get("vcType").getValue();
    	if(vcType!="null"){//null:待办执行入口;finish:已办详情入口
    		if(nui.get("button1")){
    			var button1=nui.get("button1");
    			button1.disable();
    		}
    		if(nui.get("button2")){
    			var button2=nui.get("button2");
    			button2.disable();
    		}
    		if(nui.get("button3")){
    			var button3=nui.get("button3");
    			button3.disable();
    		}
    		if(nui.get("button4")){
    			nui.get("button4").disable();
    		}
    		nui.get("tabs").removeTab("index");
    		$(".mini-textbox-input").attr("disabled","true");
    	}
    })();  
 
