<%@page import="com.cjhxfund.commonUtil.JDBCUtil"%>
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
<%@ page import="java.util.Date" %>
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
  
  private String database ="default";    //����Դ

  //��ӡ����
  private String mOfficePrints;
  private int mCopies;

  //�Զ�����Ϣ����
  private String mInfo;

  private iMsgServer2000 MsgObj;
  private iDBManager2000 DbaObj;


 //--------------------Bolb�ֶδ���.��ʼ------------------------------//
 /* private void PutAtBlob(BLOB vField, int vSize) throws IOException {
    System.out.print("vField1  =="+vField);
    try {
      OutputStream outstream = vField.getBinaryOutputStream();
      outstream.write(mFileBody, 0, vSize);
      outstream.close();
    }
    catch (SQLException e) {

    }
  } */

 /*  private void GetAtBlob(BLOB vField, int vSize) throws IOException {
    try {
      System.out.print("vField1  =="+vField);
      mFileBody = new byte[vSize];
      InputStream instream = vField.getBinaryStream();
      instream.read(mFileBody, 0, vSize);
      instream.close();
    }
    catch (SQLException e) {

    }
  } */
  //--------------------Bolb�ֶδ���.����------------------------------//

  // ************* �ĵ���ģ��������    ��ʼ  *******************************

  //�����ĵ������ĵ����ݱ�����mFileBody��Ա���д��
  private boolean LoadFile() {
    boolean mResult = false;
   /*  String Sql = "SELECT FileBody,FileSize FROM Document_File WHERE RecordID='" +
        mRecordID + "'";
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {
            try {
              mFileSize=result.getInt("FileSize");
              GetAtBlob(((OracleResultSet)result).getBLOB("FileBody"),mFileSize);
              mResult = true ;
            }
            catch (IOException ex) {
              System.out.println(ex.toString());
              
            }
          }
          result.close();
        }
        catch (SQLException e) {
          System.out.println(e.getMessage());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    } */
    return (mResult);
  }

  //�����ĵ�������ĵ����ڣ��򸲸ǣ������ڣ������
  private File SaveFile() {
    boolean mResult = false;
    BufferedOutputStream bos = null;  
    FileOutputStream fos = null;  
    File file = null;  
    try {
       //��ȡ�ļ�����
       String fileName = mFilePath.substring(mFilePath.lastIndexOf(File.separator) +1);
       
       if(fileName.indexOf("[��ӡ]") == -1){
       		fileName = "[��ӡ]"+fileName.replace(".docx", ".doc"); 
       }else{
            fileName = fileName.replace(".docx", ".doc");
       } 
       
       //��ȡ�޸ĺ���ļ�·��
       String  filePath = mFilePath.substring(0,mFilePath.lastIndexOf(File.separator) +1) + fileName;
        
        
        File dir = new File(filePath);  
        if(!dir.exists()&&dir.isDirectory()){//�ж��ļ�Ŀ¼�Ƿ����  
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
  
  //���渽����Ϣ�����ݿ���
  private boolean SaveCfJyAttachInfo(){
     boolean mResult = false;
     java.sql.PreparedStatement prestmt=null;
     java.sql.Connection conn = null;
    try {
      if (DbaObj.OpenConnection()) {
        try {
            //�����ļ����ɷ���
            File file = SaveFile();
            
            DataObject obj = DataObjectUtil.createDataObject("com.cjhxfund.jy.process.FirstGradeBond.PmAttachInfo");
            obj.set("sysid", mRecordID);
            DatabaseUtil.expandEntityByTemplate(database, obj, obj);
            
            String attachName = obj.getString("attachName"); 
            //�ж��ļ��Ƿ����,�����ھ���ӡ����ڲ�������
	        if(attachName.indexOf("[��ӡ]") == -1 && obj.getInt("versionNumber") != 2){    
	            Sql="update CF_JY_ATTACH_INFO set annexseal = 1,version_Number = 2 WHERE sysid='" + mRecordID + "'";
	            conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
	            prestmt = DbaObj.Conn.prepareStatement(Sql);
	            prestmt.execute();
	            prestmt.close();
	            conn.close();
	            
	            DataObject PmAttachInfo = DataObjectUtil.createDataObject("com.cjhxfund.jy.process.FirstGradeBond.PmAttachInfo");
	            PmAttachInfo.setString("attachName", "[��ӡ]" + obj.getString("attachName"));
		        PmAttachInfo.setString("attachAdd", file.getPath());
		        PmAttachInfo.setDate("createTime", new Date());
		        PmAttachInfo.setInt("attachSize", mFileSize);
		        PmAttachInfo.setString("userId", mUserName);
		        PmAttachInfo.setString("attachType", "1");
		        PmAttachInfo.setString("attachBusType", "0");
		        PmAttachInfo.setString("versionNumber", "1");
		        PmAttachInfo.setString("annexseal", obj.getString("annexseal"));
		        PmAttachInfo.setString("whetherindia", "1");
		        PmAttachInfo.setString("processInstId", obj.getString("processInstId"));
		        PmAttachInfo.setString("workitemid", obj.getString("workitemid"));
		        PmAttachInfo.setString("bizId", obj.getString("bizId"));
	            
	            DatabaseExt.getPrimaryKey(PmAttachInfo);
	            DatabaseUtil.insertEntity(database, PmAttachInfo);
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


// *************��������д��������    ��ʼ  *******************************
//ȡ�ÿͻ��˷��������ݰ�
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

//���ʹ��������ݰ�
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

// *************��������д��������    ����  *******************************

  public void ExecuteRun(HttpServletRequest request,
                         HttpServletResponse response) {
    DbaObj = new iDBManager2000(); //�������ݿ����
    MsgObj = new iMsgServer2000(); //������Ϣ������

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

    mFilePath = request.getSession().getServletContext().getRealPath("");	//ȡ�÷�����·��

    System.out.println("ReadPackage   ="+mFilePath);
    try {
      if (request.getMethod().equalsIgnoreCase("POST")) {
        //MsgObj.MsgVariant(ReadPackage(request));                              //�ϰ汾��̨��������ݰ���ʽ���°�ؼ�Ҳ���ݣ�
        MsgObj.Load(request);                                                   //8.1.0.2���̨�����������ӿڣ�Ч�ʸ���
        if (MsgObj.GetMsgByName("DBSTEP").equalsIgnoreCase("DBSTEP")) {		//����ǺϷ�����Ϣ��
          mOption = MsgObj.GetMsgByName("OPTION");				//ȡ�ò�����Ϣ
          mUserName = MsgObj.GetMsgByName("USERNAME");				//ȡ��ϵͳ�û�
          System.out.println(mOption);						//��ӡ��������Ϣ

          if (mOption.equalsIgnoreCase("LOADFILE")) {				//����Ĵ���Ϊ�򿪷��������ݿ�����ļ�
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//ȡ���ĵ����
            mFileName = MsgObj.GetMsgByName("FILENAME");			//ȡ���ĵ�����
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//ȡ���ĵ�����
            mFilePath = request.getParameter("Filepath");           //ȥ���ĵ�·��
            
            File file = new File(mFilePath);
            mFileType = "pdf";
            MsgObj.MsgTextClear();						//����ı���Ϣ
             
            System.out.println("·��������" + file.getPath()  +"        �ĵ����ƣ�"+mFileName);
            
            if (MsgObj.MsgFileLoad(file.getPath())){			//���ļ��е����ĵ�
            //if (LoadFile()) {							//�����ݿ�����ĵ�
             // MsgObj.MsgFileBody(mFileBody);					//���ļ���Ϣ���
              MsgObj.SetMsgByName("STATUS", "�򿪳ɹ�!");			//����״̬��Ϣ
              MsgObj.MsgError("");						//���������Ϣ
            }
            else {
              MsgObj.MsgError("��ʧ��!");					//���ô�����Ϣ
            }
          }

          else if (mOption.equalsIgnoreCase("SAVEFILE")) {			//����Ĵ���Ϊ�����ļ��ڷ����������ݿ���
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//ȡ���ĵ����
            mFileName = MsgObj.GetMsgByName("FILENAME");			//ȡ���ĵ�����
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//ȡ���ĵ�����
            //mMyDefine1=MsgObj.GetMsgByName("MyDefine1");			//ȡ�ÿͻ��˴��ݱ���ֵ MyDefine1="�Զ������ֵ1"
            mFileSize = MsgObj.MsgFileSize();					//ȡ���ĵ���С
            mFileDate = DbaObj.GetDateTime();					//ȡ���ĵ�ʱ��
            mFileBody = MsgObj.MsgFileBody();					//ȡ���ĵ�����
            mFilePath = request.getParameter("Filepath");		//�������Ϊ�ļ�������д�ļ�·��
            mUserName = mUserName;						//ȡ�ñ����û�����
            mDescript = "ͨ�ð汾";						//�汾˵��
            MsgObj.MsgTextClear();						//����ı���Ϣ
            MsgObj.MsgFileClear();						//����ĵ�����

            //if (MsgObj.MsgFileSave(mFilePath+"\\"+mFileName))			//�����ĵ����ݵ��ļ�����
            if (SaveCfJyAttachInfo()) {							//�����ĵ����ݵ����ݿ���
              MsgObj.SetMsgByName("STATUS", "����ɹ�!");			//����״̬��Ϣ
              MsgObj.MsgError("");						//���������Ϣ
            }
            else {
              MsgObj.MsgError("����ʧ��!");					//���ô�����Ϣ
            }
          }

          else if (mOption.equalsIgnoreCase("INSERTFILE")) {			//����Ĵ���Ϊ�����ļ�
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//ȡ���ĵ����
            mFileName = MsgObj.GetMsgByName("FILENAME");			//ȡ���ĵ�����
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//ȡ���ĵ�����
            MsgObj.MsgTextClear();
            if (LoadFile()) {							//�����ĵ�
              MsgObj.MsgFileBody(mFileBody);					//���ļ���Ϣ���
              MsgObj.SetMsgByName("POSITION", "Content");			//���ò����λ��[��ǩ]
              MsgObj.SetMsgByName("STATUS", "�����ļ��ɹ�!");			//����״̬��Ϣ
              MsgObj.MsgError("");						//���������Ϣ
            }
            else {
              MsgObj.MsgError("�����ļ��ɹ�!");					//���ô�����Ϣ
            }
          }

          else if (mOption.equalsIgnoreCase("DATETIME")) {			//����Ĵ���Ϊ����ȡ�÷�����ʱ��
            MsgObj.MsgTextClear();						//����ı���Ϣ
            MsgObj.SetMsgByName("DATETIME", DbaObj.GetDateTime());		//��׼���ڸ�ʽ�ִ����� 2005-8-16 10:20:35
            //MsgObj.SetMsgByName("DATETIME","2006-01-01 10:24:24");		//��׼���ڸ�ʽ�ִ����� 2005-8-16 10:20:35
          }

          else if (mOption.equalsIgnoreCase("SENDMESSAGE")) {			//����Ĵ���ΪWebҳ��������Ϣ[��չ�ӿ�]
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//ȡ���ĵ����
            mFileName = MsgObj.GetMsgByName("FILENAME");			//ȡ���ĵ�����
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//ȡ���ĵ�����
            mCommand = MsgObj.GetMsgByName("COMMAND");				//ȡ�ò������� InportText or ExportText
            mContent = MsgObj.GetMsgByName("CONTENT");				//ȡ���ı���Ϣ Content
            mOfficePrints = MsgObj.GetMsgByName("OFFICEPRINTS");		//ȡ��Office�ĵ��Ĵ�ӡ����
            mInfo = MsgObj.GetMsgByName("TESTINFO");				//ȡ�ÿͻ��˴������Զ�����Ϣ

            MsgObj.MsgTextClear();
            MsgObj.MsgFileClear();
            System.out.println("COMMAND:"+mCommand);

            if (mCommand.equalsIgnoreCase("SELFINFO")) {
              mInfo = "���������յ��ͻ��˴�������Ϣ����" + mInfo + "�� | ";
              //��Ϸ��ظ��ͻ��˵���Ϣ
              mInfo = mInfo + "�������˷��ص�ǰ������ʱ�䣺" + DbaObj.GetDateTime();
              MsgObj.SetMsgByName("RETURNINFO", mInfo);				//�����ص���Ϣ���õ���Ϣ����
            }
            else {
              MsgObj.MsgError("�ͻ���Web�������ݰ�����û�к��ʵĴ�����![" + mCommand + "]");
              MsgObj.MsgTextClear();
              MsgObj.MsgFileClear();
            }
          }
        }
        else {
          MsgObj.MsgError("�ͻ��˷������ݰ�����!");
          MsgObj.MsgTextClear();
          MsgObj.MsgFileClear();
        }
      }
      else {
        MsgObj.MsgError("��ʹ��Post����");
        MsgObj.MsgTextClear();
        MsgObj.MsgFileClear();
      }
      System.out.println("SendPackage");
      System.out.println("");
      //SendPackage(response);                                                  //�ϰ��̨�෵����Ϣ�����ݷ������°�ؼ�Ҳ���ݣ�
      MsgObj.Send(response);                                                    //8.1.0.2�°��̨�������Ĺ��ܽӿڣ�Ч�ʸ���
    }
    catch (Exception e) {
      System.out.println(e.toString());
    }
  }
}
%>
<%
iWebOffice officeServer = new iWebOffice();
System.out.println("����  =  1");
officeServer.ExecuteRun(request,response);

out.clear();  
out = pageContext.pushBody();
%>