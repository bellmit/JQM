<%@page import="com.cjhxfund.commonUtil.iDBManager2000"%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*," %>
<%
  String mRecordID=request.getParameter("RecordID");
  if (mRecordID==null) mRecordID="";
  String mSubject=new String(request.getParameter("Subject").getBytes("8859_1"));
  String mAuthor=new String(request.getParameter("Author").getBytes("8859_1"));
  String mFileDate=new String(request.getParameter("FileDate").getBytes("8859_1"));
  String mFileType="pdf";
  String mStatus="READ";

  int mDocumentId=0;

iDBManager2000 DbaObj=new iDBManager2000();
if (DbaObj.OpenConnection())
{
  String mysql="SELECT DocumentID,RecordID from Document Where RecordID='" + mRecordID + "'";
  try
  {
    ResultSet result=DbaObj.ExecuteQuery(mysql) ;
    if (result.next())
    {
      mysql="update Document set DocumentID=?,RecordID=?,Subject=?,Author=?,FileDate=?,FileType=?,Status=? where RecordID='"+mRecordID+"'";
      mDocumentId=result.getInt("DocumentID");
    }
    else
    {
      //mysql="insert into Document (DocumentID,RecordID,Subject,Author,FileDate,FileType,Status) values (?,?,?,?,?,?,?)";
      mysql="insert into Document (DocumentID,RecordID,Subject,Author,FileDate,FileType,Status) values (?,?,?,?,?,?,?)";

      mDocumentId=DbaObj.GetMaxID("Document","DocumentID");

      //mysql="insert into Document (DocumentID,RecordID,Subject,Author,FileDate,FileType,Status) values ("+mDocumentId+",'"+mRecordID+"','"+mSubject+"','"+mAuthor+"','"+mFileDate+"','"+mFileType+"','READ')";
    }
    result.close();
  }
  catch(Exception e)
  {
      System.out.println(e.toString());
  }
  java.sql.PreparedStatement prestmt=null;
  try
  {
      prestmt=DbaObj.Conn.prepareStatement(mysql);
      prestmt.setInt(1,mDocumentId);
      prestmt.setString(2,mRecordID);
      prestmt.setString(3,mSubject);
      prestmt.setString(4,mAuthor);
      java.sql.Date date = java.sql.Date.valueOf(mFileDate.substring(0,10));
      prestmt.setDate(5,date);
      //prestmt.setString(5,mFileDate);
      prestmt.setString(6,mFileType);
      prestmt.setString(7,"READ");

      //DbaObj.Conn.setAutoCommit(true) ;
      prestmt.executeUpdate();
      DbaObj.Conn.commit();

  }
  catch(Exception e)
  {
      System.out.println(e.toString());
  }
  finally
  {
      prestmt.close();
  }
  DbaObj.CloseConnection() ;
}
else
{
  out.println("OpenDatabase Error") ;
}
response.sendRedirect("DocumentList.jsp");
%>
