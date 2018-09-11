var StringUtil = {
  /***** Use EOS function *****/
  substringAfter : function(str,keyStr){
    return substringAfter(str,keyStr);
  },
  
  /***** Use EOS function *****/
  substringBefore : function(str,keyStr){
    return substringBefore(str,keyStr);
  },
  
  /***** Use EOS function *****/
  getBytesLen : function(str){
    return getBytesLen(str);
  },
  
  /***** Use EOS function *****/
  get2BytesLen : function(str){
    return get2BytesLen(str);
  },
  
  /***** Use EOS function *****/
  lTrim : function(str){
    return lTrim(str);
  },
  
  /***** Use EOS function *****/
  rTrim : function(str){
    return rTrim(str);
  },
  
  /***** Use EOS function *****/
  trim : function(str){
    return trim(str);
  },
  
  /***** Use EOS function *****/
  allTrim : function(str){
    return allTrim(str);
  },

  /***** Use EOS function *****/
  xmlConversion : function(str){
    return xmlConversion(str);
  },
  
  /***** Use EOS function *****/
  htmlConversion : function(str){
    return htmlConversion(str);
  }
}

String.prototype.replaceAll = function(oldStr,newStr)
{
   var result = this;
   while(result.indexOf(oldStr) != -1){
     result = result.replace(oldStr,newStr);
   }
   return result;
};

