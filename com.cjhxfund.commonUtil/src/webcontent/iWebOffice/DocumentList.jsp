<%@page import="com.cjhxfund.commonUtil.iDBManager2000"%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date" %>
<%!
	iDBManager2000 DbaObj=new iDBManager2000();

  /**
   * 功能或作用：格式化日期时间
   * @param DateValue 输入日期或时间
   * @param DateType 格式化 EEEE是星期, yyyy是年, MM是月, dd是日, HH是小时, mm是分钟,  ss是秒
   * @return 输出字符串
   */
  public String FormatDate(String DateValue,String DateType)
  {
    String Result;
    SimpleDateFormat formatter = new SimpleDateFormat(DateType);
    try{
      Date mDateTime = formatter.parse(DateValue);
      Result = formatter.format(mDateTime);
    }catch(Exception ex){
      Result = ex.getMessage();
    }
    if (Result.equalsIgnoreCase("1900-01-01")){
      Result = "";
    }
    return Result;
  }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>金格iWebPDF示例程序</title>
<link rel='stylesheet' type='text/css' href='test.css'>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body bgcolor="#ffffff">
<div align="center"><font size="4" color="ff0000">iWebPDF在线管理中间件（阅读版）示例程序</font></div>
<br>
<table width="100%"><tr><td height="22"><script src="iWebPDF.js"></script></td></tr></table>
<hr size=1>
<table border=0  cellspacing='0' cellpadding='0' width=100% align=center class=TBStyle>
<tr>
  <td nowrap class="TDTitleStyle" style="line-height:20px; padding-left:10px;">
    <p style="color:#000000">请您注意：<br>
      　正式版可实现更强大的功能，需要正式版请与金格科技联系（0791-88108630）。<br>
      　如果希望正确演示本示例，您需要符合下列条件：<br>
      　1、请使用Windows XP以上操作系统、IE6以上的浏览器。<br>
      　2、请在打开本页面弹出安装插件的窗口时选择【安装】按钮，才能正常安装iWebPDF插件。<br>
      　3、如果不能正常自动安装iWebPDF插件，请你在这里<a href="iWebPDF.cab">下载安装程序</a>。<br>
	  </p>
  </td>  
  <td height="32" width="350" align=center nowrap class="TDTitleStyle">当前用户：
    <input type=text name="username" size=12 value="演示人">　
    <input type="button" name="CreatPDF" value="新建PDF" onClick="javascript:location.href='DocumentEdit.jsp?UserName='+username.value;">
  </td>
</tr>
</table>
<br>

<table border=0  cellspacing='0' cellpadding='0' width=100% align=center class=TBStyle>
<tr>
  <td width="100" height="25" align=center nowrap class="TDTitleStyle">编号</td>
  <td align=center nowrap class="TDTitleStyle">主题</td>
  <td width="150" align=center nowrap class="TDTitleStyle">作者</td>
  <td width="150" align=center nowrap class="TDTitleStyle">类型</td>
  <td width="150" align=center nowrap class="TDTitleStyle">日期</td>
  <td width="150" align=center nowrap class="TDTitleStyle">操作</td>
</tr>

<%
  try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery("select * from Document order by DocumentID desc");
          while (result.next()) {
%>
<tr>
  <td align="center" class="TDStyle"><%=result.getString("DocumentID")%>&nbsp;</td>
  <td align="center" class="TDStyle"><%=result.getString("Subject")%>&nbsp;</td>
  <td align="center" class="TDStyle"><%=result.getString("Author")%>&nbsp;</td>
  <td align="center" class="TDStyle"><%=result.getString("FileType")%>&nbsp;</td>
  <td align="center" class="TDStyle"><%=FormatDate(result.getString("FileDate"),"yyyy-MM-dd")%>&nbsp;</td>
  <td align="center"  nowrap class="TDStyle">
    <input type=button  onclick="javascript:location.href='DocumentEdit.jsp?RecordID=<%=result.getString("RecordID")%>&UserName='+username.value;" value="阅读"></td>
</tr>
<%
          }
          result.close();
        }
        catch (SQLException sqlex) {
          System.out.println(sqlex.toString());
        }
      }
      else {
        out.println("OpenDatabase Error");
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
%>
</table>
</body>
</html>
