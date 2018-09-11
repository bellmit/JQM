var DateUtil = {
  /***** Use EOS function *****/
  dateFormat : function(date,oldFmt,newFmt){
    return dateFormat(date,oldFmt,newFmt);
  },
  
  /***** Use EOS function *****/
  isDate : function(date,fmt){
    return isDate(date,fmt);
  },
  
  /***** Use EOS function *****/
  stringToDate : function(date,fmt){
    return stringToDate(date,fmt);
  },
  
  /***** Use EOS function *****/
  dateToString : function(date){
	  var year = date.getFullYear();
	  var month = date.getMonth()+1;
	  if(month < 10){
		  month = "0"+month;
	  }
	  var dateStr = date.getDate();
	  if(dateStr < 10){
		  dateStr = "0"+dateStr;
	  }
    return year+"-"+month+"-"+dateStr;
  },
  
  /***** Use EOS function *****/
  getMaxDay : function(year,month){
    return getMaxDay(year,month);
  },
  
  /***** 将date日期转化成八位数字字符串 *****/
  toNumStr : function(dateParam){
	  if(!dateParam){
		  return "";
	  }
	  var date = null;
	  if(typeof dateParam ==="string"){
		  
		  date = this.DstrToDate(dateParam);  
	  }else{
		  date = dateParam;
	  }
	  var dateStr = date.getFullYear()+((date.getMonth()+1)<10 ? "0":"")+
	   (date.getMonth()+1)+(date.getDate()<10 ? "0":"")+(date.getDate());
	  	   
	  return dateStr;
  },
  /***** 将八位数字字符串转化成date日期 *****/
  numStrToDate : function(dateStr){
	  var year = Number(dateStr.slice(0,4));
	  var month = Number(dateStr.slice(4,6));
	  var date = Number(dateStr.slice(6,8));
	  if(navigator.userAgent.indexOf("MSIE 8.0")>0){
		  return new Date(year,month-1,date);
	  }else{
		  return new Date(year,month-1,date);
	  }
	  },
  /***** 将八位数字字符串转化成date日期字符串 *****/
  numStrToDateStr : function(dateStr){
	  var year = dateStr.slice(0,4);
	  var month = dateStr.slice(4,6);
	  var date = dateStr.slice(6,8);
	  return year + "-" + month + "-" + date;
  },
  /***** 将6位数字字符串转化成time时间字符串 *****/
  numStrToTimeStr : function(timeStr){
	  var hh = timeStr.slice(0,2);
	  var mm = timeStr.slice(2,4);
	  var ss = timeStr.slice(4,6);
	  return hh + ":" + mm + ":" + ss;
  },
  /***** 将日期字符串转换为Date *****/
  DstrToDate : function(dateStr){
	  var temp = dateStr;
	  if(navigator.userAgent.indexOf("IE")>0 || navigator.userAgent.indexOf("Trident")>0 ){
		 temp = dateStr.replace("-","/");  
		 temp = temp.replace("-","/");  
	  }
	  return new Date(temp);
	  
  }
};


//判断是否为交易日期
var isTradeDate = function(e){
	var date = DateUtil.toNumStr(e.value);
    nui.ajax({
        data:{'param':{date:date,dateType:e.sender.dateType}},
        url:"com.cjhxfund.ats.sm.comm.CalCalender.isTradeDate.biz.ext",
        async:false,
        success:function(resp){
            if(!resp.isTradeDate){
            	e.errorText = "此日期不是交易日期！";
                e.isValid = false;
            }
        },
        fail:function(resp){
        	nui.alert("请重新输入日期。","系统提示");
        }
    });
};


//判断是否为交易日期
var isNotTradeDate = function(date,dateType){
	if(!date){
		return;
	}
	var result = false;
	date = DateUtil.toNumStr(date);
    nui.ajax({
        data:{'param':{date:date,dateType:dateType}},
        url:"com.cjhxfund.ats.sm.comm.CalCalender.isTradeDate.biz.ext",
        async:false,
        success:function(resp){
            if(!resp.isTradeDate){
            	result = true;
            }
        },
        fail:function(resp){
        	nui.alert("请重新输入日期。","系统提示");
        	return;
        }
    });
    return result;
};

//判断是否为交易日期,不是，则提示。任何情况下都通过校验。
var remindTradeDate = function(e,message){
	if(!e.value){
		return;
	}
	var date = DateUtil.toNumStr(e.value);
	var result = true;
    nui.ajax({
        data:{'param':{date:date,dateType:e.sender.dateType}},
        url:"com.cjhxfund.ats.sm.comm.CalCalender.isTradeDate.biz.ext",
        async:false,
        success:function(resp){
            if(!resp.isTradeDate){
            	var r=confirm(message);
            	result = r;
            }
        },
        fail:function(resp){
        	nui.alert("请重新输入日期。","系统提示");
        }
    });
    return result;
};