/**
 * 买卖页面公用方法
 */

//Gird 中使用的renderer，把空字符串转换为0
function cnSellRD(e){
	if(e.row.cnSell == null || e.row.cnSell == ""){
		return 0;
	}else{
		return e.row.cnSell;
	}
}