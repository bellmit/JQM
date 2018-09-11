var ArrayUtil = {
  /***** Use EOS function *****/
  $contains : function(arr,item){
    return $contains(arr,item);
  },
  
  /***** Use EOS function *****/
  $indexOf : function(arr,item){
    return $indexOf(arr,item);
  },
  
  /***** Use EOS function *****/
  $remove : function(arr,item){
    return $remove(arr,item);
  }
}
Array.prototype.add = function(obj)
{
  this[this.length] = obj;
}