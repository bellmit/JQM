/**
 * @author ayound
 */
function ScheduleTime(){
	
}
ScheduleTime.NUMBER_TYPE = 0;    //一般的数字类型，没有符号
ScheduleTime.EVERY_TYPE = 1;    //*号的类型，*
ScheduleTime.RANGE_TYPE = 2;    //范围类型 -
ScheduleTime.COMMA_TYPE = 3;    //逗号类型 ,
ScheduleTime.CYCLE_TYPE = 4;    //反斜线类型 /
ScheduleTime.IGNORE_TYPE = 5;   //问号类型 ?
ScheduleTime.MONTH_WEEK_TYPE = 6;   //#号类型 #

ScheduleTime.NOMAL_TYPE = "0,1,2,3,4"; //一般模式，支持 ,-*/
ScheduleTime.DAY_TYPE = "0,1,2,3,4,5"; //日期模式，支持 ,-*/?
ScheduleTime.WEEK_TYPE = "0,1,2,3,4,5,6"; //周模式，支持 ,-*/?#
/**
 * 解析定时器的模式.
 * @param {Object} text
 */
ScheduleTime.parseScheduleType = function(text){
	if(!text){
		return -1;
	}else{
		if(text.indexOf("/")>0){
			return ScheduleTime.CYCLE_TYPE;
		}else if(text.indexOf("-")>0){
			return ScheduleTime.RANGE_TYPE;
		}else if(text=="*"){
			return ScheduleTime.EVERY_TYPE;
		}else if(text=="?"){
			return ScheduleTime.IGNORE_TYPE;
		}else if(text.indexOf("#")>0){
			return ScheduleTime.MONTH_WEEK_TYPE;
		}else if(text.indexOf(",")>0){
			return ScheduleTime.COMMA_TYPE;
		}else{
			return ScheduleTime.NUMBER_TYPE;
		}
	}
}
/**
 * 解析定时器的某一项，返回一个对象.
 * @param {Object} text
 */
ScheduleTime.parseSchedule = function(text){
	var type = ScheduleTime.parseScheduleType(text);
	maxTime = null;
	minTime = null;
	cycleTime = null;
	cycleStart = null;
	commaArray = null;
	weekOrder = null;
	dayOrder = null;
	hasWorkDay = false;
	hasLast = false;
	hasCalendar = false;
	if(text.indexOf("L")>=0){
		hasLast = true;
		text = text.replace("L","");
	}
	if(text.indexOf("W")>=0){
		hasWorkDay = true;
		text = text.replace("W","");
	}
	if(text.indexOf("C")>=0){
		hasCalendar = true;
		text = text.replace("C","");
	}	
	if(type==ScheduleTime.RANGE_TYPE){
		var arr = text.split("-");
		minTime = arr[0];
		maxTime = arr[1];
	}else if(type==ScheduleTime.COMMA_TYPE){
		commaArray = text.split(",");
	}else if(type==ScheduleTime.CYCLE_TYPE){
		var arr = text.split("/");
		cycleTime = arr[1];
		cycleStart = arr[0];
	}else if(type==ScheduleTime.MONTH_WEEK_TYPE){
		var arr = text.split("#");
		weekOrder = arr[1];
		dayOrder = arr[0];
	}
	return {timeType:type,
			maxTime:maxTime,
			minTime:minTime,
			cycleTime:cycleTime,
			cycleStart:cycleStart,
			commaArray:commaArray,
			weekOrder : weekOrder,
			dayOrder : dayOrder,
			hasWorkDay : hasWorkDay,
			hasLast : hasLast,
			hasCalendar : hasCalendar			
			};
}

/**
 * 一个时间的模型.
 * @param {Object} text
 * @param {Object} supportType
 */
function ScheduleBase(text,supportType){
	this.supportType = supportType||ScheduleTime.NOMAL_TYPE;
	this.regText = text||"*";
	var obj = ScheduleTime.parseSchedule(this.regText);
	this.timeType = obj.timeType;
	this.maxTime = obj.maxTime;
	this.minTime = obj.minTime;
	this.cycleTime = obj.cycleTime;
	this.cycleStart = obj.cycleStart;
	this.commaArray = obj.commaArray;
	this.weekOrder = obj.weekOrder;
	this.dayOrder = obj.dayOrder;
	this.hasWorkDay = obj.hasWorkDay;
	this.hasLast = obj.hasLast;
	this.hasCalendar = obj.hasCalendar;		
}
/**
 * 验证该时间点.
 */
ScheduleBase.prototype.validate = function(){
	if(this.timeType<0){
		return false;
	}
	if(this.supportType.indexOf(this.timeType)>=0){
		return true;
	}else{
		return false;
	}	
}
ScheduleTime.NUMBER_TYPE = 0;    //一般的数字类型，没有符号
ScheduleTime.EVERY_TYPE = 1;    //*号的类型，*
ScheduleTime.RANGE_TYPE = 2;    //范围类型 -
ScheduleTime.COMMA_TYPE = 3;    //逗号类型 ,
ScheduleTime.CYCLE_TYPE = 4;    //反斜线类型 /
ScheduleTime.IGNORE_TYPE = 5;   //问号类型 ?
ScheduleTime.MONTH_WEEK_TYPE = 6;   //#号类型 #
/**
 * 输出文本.
 */
ScheduleBase.prototype.toText = function(){
	var result;
	if(this.timeType==ScheduleTime.NUMBER_TYPE){
		result = this.regText;
	}else if(this.timeType==ScheduleTime.EVERY_TYPE){
		return this.regText;
	}else if(this.timeType==ScheduleTime.RANGE_TYPE){
		result = this.minTime + "-" + this.maxTime;
	}else if(this.timeType==ScheduleTime.COMMA_TYPE){
		result = this.commaArray.join(",");
	}else if(this.timeType==ScheduleTime.CYCLE_TYPE){
		result = this.cycleStart + "/" + this.cycleTime;
	}else if(this.timeType==ScheduleTime.IGNORE_TYPE){
		return this.regText;
	}else if(this.timeType==ScheduleTime.MONTH_WEEK_TYPE){
		result = this.dayOrder + "#" + this.weekOrder;
	}
	return result;
}
/**
 * 解析某一项.
 * @param {Object} text
 */
ScheduleBase.prototype.parse = function(text){
	this.regText = text||"*";
	var obj = ScheduleTime.parseSchedule(this.regText);
	this.timeType = obj.timeType;
	this.maxTime = obj.maxTime;
	this.minTime = obj.minTime;
	this.cycleTime = obj.cycleTime;
	this.cycleStart = obj.cycleStart;
	this.commaArray = obj.commaArray;
	this.weekOrder = obj.weekOrder;
	this.dayOrder = obj.dayOrder;
	this.hasWorkDay = obj.hasWorkDay;
	this.hasLast = obj.hasLast;
	this.hasCalendar = obj.hasCalendar;	
}

function Schedule(regText){
	this.regText = regText||"0 0 0 * * ? *";
	this.second = null;
	this.minitue = null;
	this.hour = null;
	this.day = null;
	this.month = null;
	this.week = null;
	this.year = null;
	this.parse(this.regText);
}

Schedule.prototype.parse = function(regText){
	this.regText = regText;
	var arr = this.regText.split(" ");
	if(this.regText.indexOf("?")<0){
		if(arr[3]=="*"){
			if(arr[5]=="*"){
				arr[5] = "?";
			}else{
				arr[3] = "?";
			}
		}else{
			arr[5] = "?";
		}
	}
	if(arr[3]=="?"&&arr[5]=="?"){
		arr[3] = "*";
	}
	this.second = new ScheduleBase(arr[0]);
	this.minute = new ScheduleBase(arr[1]);
	this.hour = new ScheduleBase(arr[2]);
	this.day = new ScheduleBase(arr[3],ScheduleTime.DAY_TYPE);
	this.week = new ScheduleBase(arr[5],ScheduleTime.WEEK_TYPE);
	this.month = new ScheduleBase(arr[4]);
	this.year = new ScheduleBase(arr[6]);
}

Schedule.prototype.refresh = function(){
	this.regText = this.toText();
}

Schedule.prototype.toText = function(){
	var result = "";
	var day = this.day.toText();
	var week = this.week.toText();
	if(day=="?"&&week=="?"){
		day = "*";
	}
	if(day!="?"&&week!="?"){
		if(day=="*"){
			if(week=="*"){
				week = "?";
			}else{
				day = "?";
			}
		}else{
			week = "?";
		}
	}
	result += this.second.toText() + " ";
	result += this.minute.toText() + " ";
	result += this.hour.toText() + " ";
	result += day + " ";
	result += this.month.toText() + " ";
	result += week + " ";
	result += this.year.toText();
	return result;
}

