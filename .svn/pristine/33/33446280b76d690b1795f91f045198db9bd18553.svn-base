var ValidateUtil = {
  /***** Use EOS function *****/
  isNull : function(str){
    return isNull(str);
  },
  
  /***** Use EOS function *****/
  isIP : function(str){
    return isIP(str);
  },
  
  /***** Use EOS function *****/
  isURL : function(str){
    return isURL(str);
  },
  
  /***** Use EOS function *****/
  isInteger : function(str){
    return isInteger(str);
  },
  
  /***** Use EOS function *****/
  isPositiveInteger : function(str){
    return isPositiveInteger(str);
  },
  
  /***** Use EOS function *****/
  isDecimal : function(str){
    return isDecimal(str);
  },
  
  /***** Use EOS function *****/
  isDecimal : function(str,len,pric){
    return isDecimal(str,len,pric);
  },
  
  //str:被检查的数;len:整数部分最大位数;pric:小数部分最大位数;max:最大值;min:最小值
  isDecimal : function(str,len,pric,max,min){
	var re = /^[0-9]+.?[0-9]*$/;        //判断输入是否为数字
	if(!re.test(str))
	{
		return false;
	}

	if( (max != "" && str > max) || (min != "" && str < min))      //判断最大最小值是否符合要求 
	{
		return false;
	}

 	var posi = str.indexOf('.');	    //输入是整数
 	if (posi == -1) {
 		if ( len != "" && str.length > len) {
 			return false;
 		}
 		else {
 			return true;
 		}
 	}
 	
 	var strs = str.split('.');           //输入是实数
 	var inter = strs[0]; 
 	var decimal = strs[1];
 		
    if ( (len != "" && inter.length > len) || (pric != "" && decimal.length > pric))  
	{
		return false;
	}
	else
	{
		return true;
	}
  },  
   
  /***** Use EOS function *****/
  isPort : function(str){
    return isPort(str);
  },
  
  /***** Use EOS function *****/
  isEmail : function(str){
    return isEmail(str);
  },
  
  /***** Use EOS function *****/
  isDate : function(str){
    return isDate(str);
  },
  
  /***** Use EOS function *****/
  isDate : function(str,format){
    return isDate(str,format);
  },
  
  /***** Use EOS function *****/
  isLastMatch : function(str1,str2){
    return isLastMatch(str1,str2);
  },
  
  /***** Use EOS function *****/
  isFirstMatch : function(str1,str2){
    return isFirstMatch(str1,str2);
  },
  
  /***** Use EOS function *****/
  isMatch : function(str1,str2){
    return isMatch(str1,str2);
  },
  
  /***** Use EOS function *****/
  isChinaMobileNo : function(str){
    return isChinaMobileNo(str);
  },
  
  /***** Use EOS function *****/
  isChinaZipcode : function(str){
    return isChinaZipcode(str);
  },
  
  /***** Use EOS function *****/
  isChinaIDNo : function(str){
    return isChinaIDNo(str);
  },
  
  /***** Use EOS function *****/
  checkPeriod : function(startDate,endDate){
    return checkPeriod(startDate,endDate);
  },
  
  /***** Use EOS function *****/
  matchRegExp : function(str,pattern,flag){
    return matchRegExp(str,pattern,flag);
  },
  
  /***** Use EOS function *****/
  isNumberOr_Letter : function(str){
    return isNumberOr_Letter(str);
  },
  
  /***** Use EOS function *****/
  isNumberOrLetter : function(str){
    return isNumberOrLetter(str);
  },
  
  /***** Use EOS function *****/
  isChinaOrNumbOrLett : function(str){
    return isChinaOrNumbOrLett(str);
  }
  
}