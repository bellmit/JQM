/**
 * 
 */
function showDetail(gridId){
	//增加动态块
	var columns = nui.get(gridId).columns;
//	nui.get(gridId).columns[0].renderer.caller
	var html = '<div class="infoContainer"><ul>';
	for(var i =0;i<columns.length;i++){
		if(typeof columns[i].header == "string"){
			html = html + '<li><label>' + columns[i].header + '：</label><span id="'+columns[i].field+'Hover"></span></li>';
		}
	}
	html = html + '</ul></div>';
	if($(".infoContainer").length<1){
		$("body").append(html);
	}
	//绑定悬浮方法
	var tbody = $('#'+gridId+' > div > div:last > div:eq(3) > div:eq(1) > div > table > tbody');
	tbody.children().mouseover(
			function(e){
				var x = e.pageX;
				var y = e.pageY;
				var showThis = this;
				timer=setTimeout(function(e){
					//index为2时实际tr第一列
    	    		var index = $(showThis).index();
    	    		var data = nui.get(gridId).data;
    	    		var showData = data[index-2];
    	    		
    	    		for(var key in showData){
    	    			
    	    			$("#"+key + 'Hover').text(showData[key]);
        			}
    	    		$(".infoContainer").css({
    	    			'left':x,
    	    			'top':y
    	    		}).fadeIn(300);
				},300);
	    	}).mouseout(function(e){
	    		clearTimeout(timer);
		$(".infoContainer").fadeOut(300);
	});
}

/**
 * param1:gridId,param2:显示的detail数组
 * 
 * 数组下标要与显示界面列数对应
 */
function onHeaderShowDetail(gridId,detailData){
	var html = '<div class="HeaderShowDetail"><ul>';
	html = html + '<li><span id=Hover></span></li>';
	html = html + '</ul></div>';
	if($(".HeaderShowDetail").length<1){
		$("body").append(html);
	}
	//绑定悬浮方法
	var tr = $('#'+gridId+' > div > div:eq(1) > div:eq(1)> div:eq(1) > table > tbody > tr:eq(1)');
	tr.children().mouseover(
			function(e){
				var x = e.pageX;
				var y = e.pageY;
				if((document.body.clientWidth - x) <  290){
					x = document.body.clientWidth - 310;
				}
				var showThis = this;
				timer2=setTimeout(function(e){
    	    		var index = $(showThis).index();
    	    		for(key in detailData){
    	    			if(index == key){
    	    				var detail = detailData[index];
    	    				$("#Hover").text(detail);
    	    				$(".HeaderShowDetail").css({
    	    					'left':x,
    	    					'top':y
    	    				}).fadeIn(300);
    	    			}
    	    		}
				},300);
	    	}).mouseout(function(e){
	    		clearTimeout(timer2);
		$(".HeaderShowDetail").fadeOut(300);
	});
}