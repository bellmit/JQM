//传入日期为字符串类型时调用
function checkdate(dCurOperateTime,dateTime){   
 	//得到日期值并转化成日期格式，replace(//-/g, "//")是根据验证表达式把日期转化成长日期格式，这样
	//再进行判断就好判断了
    var sDate =new Date(dCurOperateTime.replace(/\-/g, "\/"));   
       
    if(sDate > dateTime){
    	nui.alert("当前流程正在审批中，请耐心等待！","系统提示");
     	return false;
    }
   	return true;
}

//传入日期格式为时间格式时调用
function checkDate1(dCurOperateTime){   
    //获取当前时间
    var myDate = getNowDateYYYYMMDDhhmmss();        
    if(dCurOperateTime > myDate){
    	nui.alert("当前流程正在审批中，请耐心等待！","系统提示");
     	return false;
    }
   	return true;
}
    
//获取当前服务器时间，yyyy-MM-dd HH:mm:ss
function getNowDateYYYYMMDDhhmmss(){
	var date = new Date();
	var seperator1 = "/";
    var seperator2 = ":";
	  
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var strDate = date.getDate();
	var hour = date.getHours();
	var minutes = date.getMinutes();
	var seconds = date.getSeconds();
	if (month >= 1 && month <= 9) {
	    month = "0" + month;
	}
	if (strDate >= 0 && strDate <= 9) {
	    strDate = "0" + strDate;
	}
	var currentDateStr = year + seperator1 + month + seperator1 + strDate +" "+ hour + seperator2 + minutes + seperator2 + seconds;
	var currentDate = new Date(currentDateStr);
	return currentDate;
}