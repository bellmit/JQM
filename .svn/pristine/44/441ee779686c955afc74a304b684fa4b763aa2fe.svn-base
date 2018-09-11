
	    function splitString(data){
    		var string = null;
    		if(data != null && data != ""){
    			var strs= data.split(",");
	    		if(strs.length>0){
	    			for(var i=0; i<strs.length; i++ ){ 
						if(i == 0){
							string = "'"+strs[i]+"'";
						}else{
							string += ",'"+strs[i]+"'";
						}
					} 
	    		}
    		}
			return string;
    	}
	    
	  //查询--所有业务通用
		function autoSearch() {
		//获取之前选中记录的主键ID，刷新后继续选中之前记录
		var rows_search = selectArr;
		var rowIds_search = "";
		for(var i=0; i<rows_search.length; i++){
			rowIds_search += rows_search[i].lResultId;
			if(i<rows_search.length-1){
				rowIds_search += ",";
			}
		}
		//开始查找记录
	    var form = new nui.Form(today_instruct);
	    var json = form.getData(false,false);
	    todays_instruct_grid.load(json,function(){
	    	//选中刷新前选中的记录
	    	var rows = todays_instruct_grid.findRows(function (row) {
	    		var exist = false;
	    		if(rowIds_search!=null && rowIds_search!=""){
	    			var rowIdsArr = rowIds_search.split(",");
	    			for(var i=0; i<rowIdsArr.length; i++){
	    				if (row.lResultId == rowIdsArr[i]){
		                	exist = true;
		                	break;
		                }
	    			}
	    		}
	    		return exist;
	        });
	        todays_instruct_grid.selects(rows);
	    	});
		}
		
		
		//生成uuid
        function guid() {
    		var time = new Date().getTime();
    		var random = GetRandomNum(1,999999);
    		var uuid = time.toString() + random.toString();
    		return uuid;
		}
    	
    	function GetRandomNum(Min,Max) {   
			var Range = Max - Min;   
			var Rand = Math.random();   
			return(Min + Math.round(Rand * Range));   
		}  
    	