/*******************************************************
 *@desc     : 判断页面状态并设置
 *******************************************************
 *@author   : 2010-07-27 魏凤 创建
 *******************************************************/
if($name("pageParaObj/pageState")!=null&&$name("pageParaObj/pageState").value == "readonly")
{
  g_SetPageReadonly();
}

if($name("pageParaObj/flowSuccess")!=null&&$name("pageParaObj/flowSuccess").value =="true")
{
  g_SetPageReadonly();
}