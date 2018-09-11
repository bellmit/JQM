//展示详细行数据
function onShowRowDetailList(e) {
		var grid = e.sender;//获取表格
	    var row = e.record;//获取行数据
	    var remark = changeNull(row.remarks);//备注信息 
	    //获取债券信息
	    var processIdJson = nui.encode({processInstId : row.processinstid});
	    $.ajax({
            url:"com.cjhxfund.jy.process.PmPrcAprvInfo.queryPmPrcAprvInfo.biz.ext",
            type:'POST',
            data:processIdJson,
            cache: false,
            contentType:'text/json',
            success:function(text){
                var returnJson = nui.decode(text);
                if(returnJson.exception == null){
                    var bonds = returnJson.prcAprvInfos;
                    var html = "<table border='0'  style='width:100%;'>";
					 
					/*if(abandonedReasons!=null && abandonedReasons!=""){
						html +=" <tr>"
							 + "  <td style='width:95px;font-weight:bold;vertical-align:top;' align='right'>废弃原因：</td>"
							 + "  <td>" + abandonedReasons + "</td>"
							 + " </tr>";
					} */
					if(remark!=null && remark!=""){
						html +=" <tr>"
							 + "  <td style='width:150px;font-weight:bold;vertical-align:top;' align='right'>备注信息：</td>"
							 + "  <td>" + remark + "</td>"
							 + " </tr>";
					}
					if(returnJson.nextActor!=null && returnJson.nextActor!=""){
						html +=" <tr>"
							 + "  <td style='width:150px;font-weight:bold;vertical-align:top;' align='right'>当前节点参与者：</td>"
							 + "  <td>" + returnJson.nextActor + "</td>"
							 + " </tr>";
					}
					html += "</table>";
                    
					var bondStr = html + "</table>";
                        bondStr += "<table>"
                    			+" <tr>"
                    			+"  <td style='width:150px;font-weight:bold;' align='center'>审批时间</td>"
                    			+"  <td style='width:220px;font-weight:bold;' align='center'>节点名称</td>"
                    			+"  <td style='width:120px;font-weight:bold;' align='center'>操作者</td>"
                    			+"  <td style='width:120px;font-weight:bold;' align='center'>操作</td>"
                    			+"  <td style='width:200px;font-weight:bold;' align='center'>操作意见</td>"
                    			+" </tr>";
                    var operateType = "同意";			
                    for(var i=0; i<bonds.length; i++){
                    	var bondInfo = bonds[i];
                    	  if(bondInfo.operateType == 1){
					            operateType = "同意";
					      }
					      if(bondInfo.operateType == 2){
					            operateType = "退办";
					      }
					      if(bondInfo.operateType == 3){
					            operateType = "转办";
					      }
					      if(bondInfo.operateType == 4){
					            operateType = "征求意见";
					      }
					      if(bondInfo.operateType == 5){
					            operateType = "否决";
					      }
					      if(bondInfo.operateType == 99){
					            operateType = "不同意";
					      }
					      
					      if(bondInfo.operateType == 98){
					            operateType = "修改";
					      }
					      if(bondInfo.operateType == 97){
					            operateType = "废弃";
					      }
					      
                    	bondStr += "<tr><td align='center'>"+ nui.formatDate(bondInfo.createTime, "yyyy-MM-dd HH:mm:ss")+"</td><td align='center'>"+changeNull(bondInfo.workItemName)+"</td><td align='center'>"+changeNull(bondInfo.userName)
                    			+	"</td><td align='center'>"+changeNull(operateType)+"</td><td align='center'>"+changeNull(bondInfo.comments)+"</td></tr>";
                    }
                    bondStr += "</table>";
                    
                    var td = grid.getRowDetailCellEl(row);

					td.innerHTML = bondStr;
                    
                }else{
					nui.alert("加载失败", "系统提示");
                }
            }
         });
	}



//根据选项动态隐藏列
function dynamicHidingColumn(e){
  //获取列集合
  var columns = grid.columns;
  var businessType = nui.get("businessType").getValue();
  if(businessType == 1){	
      //为一级债券(非可转债)时	      
      //显示投标金额、投标利率、是否具有回售权、是否具有赎回权
      grid.showColumn(columns[19]);
      grid.showColumn(columns[20]);
      grid.showColumn(columns[30]);
      grid.showColumn(columns[31]);
      
      //隐藏申购金额、定金比例、定金金额
      grid.hideColumn(columns[21]);
      grid.hideColumn(columns[22]);
      grid.hideColumn(columns[23]);
  }else{
      //为一级债券(可转债)时
      //隐藏投标金额、投标利率、是否具有回售权、是否具有赎回权
      grid.hideColumn(columns[19]);
      grid.hideColumn(columns[20]);
      grid.hideColumn(columns[30]);
      grid.hideColumn(columns[31]);
      
      //显示申购金额、定金比例、定金金额
      grid.showColumn(columns[21]);
      grid.showColumn(columns[22]);
      grid.showColumn(columns[23]);
  }
  
  search();
}


