<%@page import="com.cjhxfund.ats.fm.comm.JDBCUtil"%>
<%@page import="com.cjhxfund.ats.fm.comm.JDBCUtil"%>
<%@page import="com.eos.foundation.database.DatabaseUtil"%>
<%@page import="com.primeton.spring.support.DatabaseExt"%>
<%@page import="com.eos.foundation.data.DataObjectUtil"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="com.eos.foundation.common.utils.FileUtil"%>
<%@page import="com.cjhxfund.commonUtil.iDBManager2000"%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Date" %><%-- 
<%@ page import="oracle.sql.BLOB" %>
<%@ page import="oracle.jdbc.*" %> --%>
<%@ page import="com.cjhxfund.commonUtil.iMsgServer2000" %>
<%!
public class iWebOffice {
  private int mFileSize;
  private byte[] mFileBody;
  private String mFileName;
  private String mFileType;
  private String mFileDate;
  private String mFileID;

  private String mRecordID;
  private String mTemplate;
  private String mDateTime;
  private String mOption;
  private String mMarkName;
  private String mPassword;
  private String mMarkList;
  private String mBookmark;
  private String mDescript;
  private String mHostName;
  private String mMarkGuid;
  private String mCommand;
  private String mContent;
  private String mHtmlName;
  private String mDirectory;
  private String mFilePath;

  private String mUserName;
  private int mColumns;
  private int mCells;
  private String mMyDefine1;
  private String mLocalFile;
  private String mRemoteFile;
  private String mLabelName;
  private String mImageName;
  private String mTableContent;

  private String Sql;
  
  private String database ="default";    //数据源

  //打印控制
  private String mOfficePrints;
  private int mCopies;

  //自定义信息传递
  private String mInfo;

  private iMsgServer2000 MsgObj;
  private iDBManager2000 DbaObj;

  // ************* 文档、模板管理代码    开始  *******************************

  //调出文档，将文档内容保存在mFileBody里，以便进行打包
  private boolean LoadFile() {
    boolean mResult = false;
    return (mResult);
  }

  //保存文档，如果文档存在，则覆盖，不存在，则添加
  private File SaveFile() {
    boolean mResult = false;
    BufferedOutputStream bos = null;  
    FileOutputStream fos = null;  
    File file = null;  
    try {
       //获取文件名称
       String fileName = mFilePath.substring(mFilePath.lastIndexOf(File.separator) +1);
       
       if(fileName.indexOf("[用印]") == -1){
       		fileName = "[用印]"+fileName.replace(".docx", ".doc"); 
       }else{
            fileName = fileName.replace(".docx", ".doc");
       } 
       
       //获取修改后的文件路径
       String  filePath = mFilePath.substring(0,mFilePath.lastIndexOf(File.separator) +1) + fileName;
        
        
        File dir = new File(filePath);  
        if(!dir.exists()&&dir.isDirectory()){//判断文件目录是否存在  
             dir.mkdirs();  
        }  
        file = new File(filePath);  
        fos = new FileOutputStream(file);  
        bos = new BufferedOutputStream(fos);  
        bos.write(mFileBody);  
        
      } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            if (bos != null) {  
                try {  
                    bos.close();  
                } catch (IOException e1) {  
                    e1.printStackTrace();  
                }  
            }  
            if (fos != null) {  
                try {  
                    fos.close();  
                } catch (IOException e1) {  
                    e1.printStackTrace();  
                }  
            }  
        }  
    return file;
  }
  
  //保存附件信息到数据库中
  private boolean SaveCfJyAttachInfo(){
     boolean mResult = false;
     java.sql.PreparedStatement prestmt=null;
     java.sql.Connection conn = null;
    try {
      if (DbaObj.OpenConnection()) {
        try {
            //调用文件生成方法
            File file = SaveFile();
            
            DataObject obj = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.TAtsAttachInfo");
            obj.set("lAttachId", mRecordID);
            DatabaseUtil.expandEntityByTemplate(database, obj, obj);
            String attachName = obj.getString("vcAttachName");  
            //判断文件是否存在,不存在就添加。存在不作处理
	        if(attachName.indexOf("[用印]") == -1 && obj.getInt("vcVersionNo") != 2){    
	             Sql="update T_ATS_ATTACH_INFO set VC_ANNEX_SEAL = 1,VC_VERSION_NO = 2 WHERE L_ATTACH_ID='" + mRecordID + "'";
	            conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
	            prestmt = DbaObj.Conn.prepareStatement(Sql);
	            prestmt.execute();
	            prestmt.close();
	            conn.close();
	            System.out.print("lProcessInstId ==========" + obj.getString("lProcessInstId"));
	            //新增附件信息    
	       		DataObject PmAttachInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.TAtsAttachInfo");
	        	PmAttachInfo.setString("vcAttachName", "[用印]" + attachName);
	        	PmAttachInfo.setString("vcAttachAdd", file.getPath());
	        	PmAttachInfo.setDate("dCreateTime", new Date());
	        	PmAttachInfo.setInt("vcAttachSize", mFileSize);
	        	PmAttachInfo.setString("vcUserId", mUserName);
	        	PmAttachInfo.setString("vcAttachType", "1");
	        	PmAttachInfo.setString("vcAttachBizType", obj.getString("vcAttachBizType"));
	        	PmAttachInfo.setString("vcVersionNo", "1");
	        	PmAttachInfo.setString("vcAnnexSeal", obj.getString("vcAnnexSeal"));
	        	PmAttachInfo.setString("vcWhetherIndia", "1");
	        	PmAttachInfo.setString("cWhetherArchiving", obj.getString("cWhetherArchiving"));
	        	PmAttachInfo.setString("lProcessInstId", obj.getString("lProcessInstId"));
	        	PmAttachInfo.setString("lWorkItemId", obj.getString("lWorkItemId"));
	        	PmAttachInfo.setString("lBizId", obj.getString("lBizId"));
	            
	            DatabaseExt.getPrimaryKey(PmAttachInfo);
	            DatabaseUtil.insertEntity(database, PmAttachInfo);
	            .
           } 
        }
        catch (SQLException e) {
          System.out.println(e.toString());
          mResult = false;
        }
       }
      }catch(Exception e){
         e.printStackTrace();
         mResult = false;
      }finally{
         JDBCUtil.releaseResource(conn, prestmt, null);
      }
      return mResult;
  }


// *************接收流、写回流代码    开始  *******************************
//取得客户端发来的数据包
  private byte[] ReadPackage(HttpServletRequest request) {
    byte mStream[] = null;
    int totalRead = 0;
    int readBytes = 0;
    int totalBytes = 0;
    try {
      totalBytes = request.getContentLength();
      mStream = new byte[totalBytes];
      while (totalRead < totalBytes) {
        request.getInputStream();
        readBytes = request.getInputStream().read(mStream, totalRead,
                                                  totalBytes - totalRead);
        totalRead += readBytes;
        continue;
      }
    }
    catch (Exception e) {
      System.out.println(e.toString());
    }
    return (mStream);
  }

//发送处理后的数据包
  private void SendPackage(HttpServletResponse response) {
    try {
      ServletOutputStream OutBinarry = response.getOutputStream();
      OutBinarry.write(MsgObj.MsgVariant());
      OutBinarry.flush();
      OutBinarry.close();
    }
    catch (IOException e) {
      System.out.println(e.toString());
    }
  }

// *************接收流、写回流代码    结束  *******************************

  public void ExecuteRun(HttpServletRequest request,
                         HttpServletResponse response) {
    DbaObj = new iDBManager2000(); //创建数据库对象
    MsgObj = new iMsgServer2000(); //创建信息包对象

    mOption = "";
    mRecordID = "";
    mTemplate = "";
    mFileBody = null;
    mFileName = "";
    mFileType = "";
    mFileSize = 0;
    mFileID = "";
    mDateTime = "";
    mMarkName = "";
    mPassword = "";
    mMarkList = "";
    mBookmark = "";
    mMarkGuid = "";
    mDescript = "";
    mCommand = "";
    mContent = "";
    mLabelName = "";
    mImageName = "";
    mTableContent = "";
    mMyDefine1 = "";

    mFilePath = request.getSession().getServletContext().getRealPath("");	//取得服务器路径

    System.out.println("ReadPackage   ="+mFilePath);
    try {
      if (request.getMethod().equalsIgnoreCase("POST")) {
        //MsgObj.MsgVariant(ReadPackage(request));                              //老版本后台类解析数据包方式（新版控件也兼容）
        MsgObj.Load(request);                                                   //8.1.0.2版后台类新增解析接口，效率更高
        if (MsgObj.GetMsgByName("DBSTEP").equalsIgnoreCase("DBSTEP")) {		//如果是合法的信息包
          mOption = MsgObj.GetMsgByName("OPTION");				//取得操作信息
          mUserName = MsgObj.GetMsgByName("USERNAME");				//取得系统用户
          System.out.println("USERNAME: " + mUserName + "  OPTION: " + mOption);						//打印出调试信息
		  
          if (mOption.equalsIgnoreCase("LOADFILE")) {				//下面的代码为打开服务器数据库里的文件
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//取得文档编号
            mFileName = MsgObj.GetMsgByName("FILENAME");			//取得文档名称
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//取得文档类型
            mFilePath = request.getParameter("Filepath");           //去的文档路径
            
            File file = new File(mFilePath);
            mFileType = "pdf";
            MsgObj.MsgTextClear();						//清除文本信息
             
            System.out.println("路径：：：" + file.getPath()  +"        文档名称："+mFileName);
            
            if (MsgObj.MsgFileLoad(file.getPath())){			//从文件夹调入文档
            //if (LoadFile()) {							//从数据库调入文档
             // MsgObj.MsgFileBody(mFileBody);					//将文件信息打包
              MsgObj.SetMsgByName("STATUS", "打开成功!");			//设置状态信息
              MsgObj.MsgError("");						//清除错误信息
            }
            else {
              MsgObj.MsgError("打开失败!");					//设置错误信息
            }
          }

          else if (mOption.equalsIgnoreCase("SAVEFILE")) {			//下面的代码为保存文件在服务器的数据库里
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//取得文档编号
            mFileName = MsgObj.GetMsgByName("FILENAME");			//取得文档名称
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//取得文档类型
            //mMyDefine1=MsgObj.GetMsgByName("MyDefine1");			//取得客户端传递变量值 MyDefine1="自定义变量值1"
            mFileSize = MsgObj.MsgFileSize();					//取得文档大小
            mFileDate = DbaObj.GetDateTime();					//取得文档时间
            mFileBody = MsgObj.MsgFileBody();					//取得文档内容
            mFilePath = request.getParameter("Filepath");		//如果保存为文件，则填写文件路径
            mUserName = mUserName;						//取得保存用户名称
            mDescript = "通用版本";						//版本说明
            MsgObj.MsgTextClear();						//清除文本信息
            MsgObj.MsgFileClear();						//清除文档内容

            //if (MsgObj.MsgFileSave(mFilePath+"\\"+mFileName))			//保存文档内容到文件夹中
            if (SaveCfJyAttachInfo()) {							//保存文档内容到数据库中
              MsgObj.SetMsgByName("STATUS", "保存成功!");			//设置状态信息
              MsgObj.MsgError("");						//清除错误信息
            }
            else {
              MsgObj.MsgError("保存失败!");					//设置错误信息
            }
          }

          else if (mOption.equalsIgnoreCase("INSERTFILE")) {			//下面的代码为插入文件
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//取得文档编号
            mFileName = MsgObj.GetMsgByName("FILENAME");			//取得文档名称
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//取得文档类型
            MsgObj.MsgTextClear();
            if (LoadFile()) {							//调入文档
              MsgObj.MsgFileBody(mFileBody);					//将文件信息打包
              MsgObj.SetMsgByName("POSITION", "Content");			//设置插入的位置[书签]
              MsgObj.SetMsgByName("STATUS", "插入文件成功!");			//设置状态信息
              MsgObj.MsgError("");						//清除错误信息
            }
            else {
              MsgObj.MsgError("插入文件成功!");					//设置错误信息
            }
          }

          else if (mOption.equalsIgnoreCase("DATETIME")) {			//下面的代码为请求取得服务器时间
            MsgObj.MsgTextClear();						//清除文本信息
            MsgObj.SetMsgByName("DATETIME", DbaObj.GetDateTime());		//标准日期格式字串，如 2005-8-16 10:20:35
            //MsgObj.SetMsgByName("DATETIME","2006-01-01 10:24:24");		//标准日期格式字串，如 2005-8-16 10:20:35
          }

          else if (mOption.equalsIgnoreCase("SENDMESSAGE")) {			//下面的代码为Web页面请求信息[扩展接口]
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//取得文档编号
            mFileName = MsgObj.GetMsgByName("FILENAME");			//取得文档名称
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//取得文档类型
            mCommand = MsgObj.GetMsgByName("COMMAND");				//取得操作类型 InportText or ExportText
            mContent = MsgObj.GetMsgByName("CONTENT");				//取得文本信息 Content
            mOfficePrints = MsgObj.GetMsgByName("OFFICEPRINTS");		//取得Office文档的打印次数
            mInfo = MsgObj.GetMsgByName("TESTINFO");				//取得客户端传来的自定义信息

            MsgObj.MsgTextClear();
            MsgObj.MsgFileClear();
            System.out.println("COMMAND:"+mCommand);

            if (mCommand.equalsIgnoreCase("SELFINFO")) {
              mInfo = "服务器端收到客户端传来的信息：“" + mInfo + "” | ";
              //组合返回给客户端的信息
              mInfo = mInfo + "服务器端发回当前服务器时间：" + DbaObj.GetDateTime();
              MsgObj.SetMsgByName("RETURNINFO", mInfo);				//将返回的信息设置到信息包中
            }
            else {
              MsgObj.MsgError("客户端Web发送数据包命令没有合适的处理函数![" + mCommand + "]");
              MsgObj.MsgTextClear();
              MsgObj.MsgFileClear();
            }
          }
        }
        else {
          MsgObj.MsgError("客户端发送数据包错误!");
          MsgObj.MsgTextClear();
          MsgObj.MsgFileClear();
        }
      }
      else {
        MsgObj.MsgError("请使用Post方法");
        MsgObj.MsgTextClear();
        MsgObj.MsgFileClear();
      }
      System.out.println("SendPackage");
      System.out.println("");
      //SendPackage(response);                                                  //老版后台类返回信息包数据方法（新版控件也兼容）
      MsgObj.Send(response);                                                    //8.1.0.2新版后台类新增的功能接口，效率更高
    }
    catch (Exception e) {
      System.out.println(e.toString());
    }
  }
}
%>
<%
iWebOffice officeServer = new iWebOffice();
System.out.println("参数  =  1");
officeServer.ExecuteRun(request,response);

//根据应用服务器类型，关闭输出流
	//1、获取应用服务器类型
	String serverId=com.cjhxfund.commonUtil.ServerDetector.getServerId();
	//判定和关闭流
	if("tomcat".equals(serverId) || "-tomcat".equals(serverId)){
		out.clear();
		out = pageContext.pushBody();
	}else if("weblogic".equals(serverId)){
		//response.reset();
		//response.getWriter().close();
	}
  //out.clear();                                                                    //用于解决JSP页面中“已经调用getOutputStream()”问题
  //out=pageContext.pushBody();                                                     //用于解决JSP页面中“已经调用getOutputStream()”问题
  

%>