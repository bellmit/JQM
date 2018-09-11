<%@page import="com.cjhxfund.commonUtil.ParamConfig"%>
<%@page import="com.cjhxfund.commonUtil.iDBManager2000"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*" %>

<%
  ResultSet result=null;
  String mSubject=null;
  String mStatus=null;
  String mAuthor=null;
  String mFileName=null;
  String mFileDate=null;
  String mHTMLPath="";

  String mDisabled="";
  String mDisabledSave="";
  String mWord="";
  String mExcel="";
  String FileAdd = "";
  String type = request.getParameter("type");

  //�Զ���ȡOfficeServer��OCX�ļ�����URL·��
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName="commonUtil/iWebOffice/OfficeServer.jsp";

  String agentAccessURL = ParamConfig.getValue("ZHFWPT_AGENT_ACCESS_URL");//��ȡ���������URL
  String serverType = ParamConfig.getValue("ZHFWPT_SERVER_TYPE");//��ȡURL���ͣ�0-��ȡ����·�������Ի�������1-��ȡ�����������еĴ���·����������������
  System.out.println("��ȡURL����----------------------"+serverType);
  String mServerUrl = "";
  String mHttpUrl = "";

  String applyName = mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName));    //��ȡ��ĿӦ������

  //�жϵ�ǰ�ǻ�ȡ����·�����Ǵ���·��
  if(serverType.equalsIgnoreCase("0") && serverType != null){
  	mServerUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + applyName + "/" + mServerName;//ȡ��OfficeServer�ļ�������URL
    mHttpUrl = "http://" + request.getServerName()+ ":" + request.getServerPort() + applyName +  "/";
  }else{
    mServerUrl = agentAccessURL + applyName + "/" + mServerName;
    mHttpUrl = agentAccessURL + applyName + "/";
  }
  System.out.println("mServerUrl   =="+mServerUrl);
  System.out.println("mHttpUrl   ==" +mHttpUrl);
  String mRecordID=request.getParameter("sysid");
  String mTemplate=request.getParameter("Template");
  String mFileType=request.getParameter("FileType");
  String mEditType=request.getParameter("EditType");
  String mShowType=request.getParameter("ShowType");
  //�����Ϣ��Ҫ��ID
  String lProductId=request.getParameter("lProductId");
  String vcProductCode=request.getParameter("vcProductCode");
  String bizId=request.getParameter("bizId");
  
  HttpSession  ss = request.getSession();
  UserObject user = (UserObject)ss.getAttribute("userObject");
  Map<String,Object> map = user.getAttributes();
  
  String mUserName = (String)map.get("EXTEND_USER_ID");
  
  //String mUserName=new String(request.getParameter("UserName").getBytes("8859_1"));

  //���ñ�ų�ʼֵ
  if (mRecordID==null){
     mRecordID="";
  }

  //���ñ༭״̬��ʼֵ
  if (mEditType==null || mEditType==""){
    mEditType="1,1";
  }

  //������ʾģʽ��ʼֵ
  if (mShowType==null || mShowType==""){
    mShowType="1";
  }

  //�����ĵ����ͳ�ʼֵ
  if (mFileType==null || mFileType==""){
    mFileType=".doc";
  }

  //�����û�����ʼֵ
  if (mUserName==null || mUserName==""){
    mUserName="���Ƽ�";
  }

  //����ģ���ʼֵ
  if (mTemplate==null){
    mTemplate="";
  }

  //�����ݿ�
  iDBManager2000 DbaObj=new iDBManager2000();
  if (DbaObj.OpenConnection()){
    String mSql="Select * From T_ATS_ATTACH_INFO Where L_ATTACH_ID ='"+ mRecordID + "'";
    try{
      result=DbaObj.ExecuteQuery(mSql);
      if (result.next()){
        /* mRecordID=result.getString("RecordID");
        mTemplate=result.getString("Template");
        mSubject=result.getString("Subject");
        mAuthor=result.getString("Author");
        mFileDate=result.getString("FileDate");
        mStatus=result.getString("Status");
        mFileType=result.getString("FileType");
        mHTMLPath=result.getString("HTMLPath"); */
        System.out.println(result.getString("VC_ATTACH_ADD"));
        mRecordID = result.getString("L_ATTACH_ID");
        mFileName = result.getString("VC_ATTACH_NAME");
        FileAdd =  result.getString("VC_ATTACH_ADD");
        System.out.println("�ĵ�·����============================="+FileAdd);
        mFileType = mFileName.substring(mFileName.lastIndexOf(".")  , mFileName.length());
        mEditType = "3,1";
        //mTemplate = "1";
      }
      else{
        //ȡ��Ψһֵ(mRecordID)
        java.util.Date dt=new java.util.Date();
        long lg=dt.getTime();
        Long ld=new Long(lg);
        //��ʼ��ֵ
        mRecordID=ld.toString();//��������ĵ��ı�ţ�ͨ���ñ�ţ����������ҵ���������������¼���ĵ�
        mSubject="����������";
        mAuthor=mUserName;
        mFileDate=DbaObj.GetDateTime();
        mStatus="DERF";
        mHTMLPath="";
      }
      result.close();
    }
    catch(SQLException e){
      System.out.println(e.toString());
    }
    DbaObj.CloseConnection() ;
  }

  if (mEditType=="0,0"){
    mDisabled="disabled";
    mDisabledSave="disabled";
  }
  else{
    mDisabled="";
  }

  mFileName=mRecordID + mFileType;  //ȡ���������ĵ�����
  if (mFileType.equalsIgnoreCase(".doc") || mFileType.equalsIgnoreCase(".wps")){
    mWord="";
    mExcel="disabled";
  }
  else if (mFileType==".xls"){
    mWord="disabled";
    mExcel="";
  }
  else{
    mDisabled="disabled";
  }
%>
<html>
<head>
<title>���Ƽ�-iWebOffice2009ȫ����עʵ��</title>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	
<script language="javascript" for=WebOffice event="OnMenuClick(vIndex,vCaption)">
  if (vIndex==1){  
    WebOpenLocal();     //�򿪱����ļ�
  }
  if (vIndex==2){  
    WebSaveLocal();     //���汾���ļ�
  }
  if (vIndex==3){
    SaveDocument();     //�������ĵ��������ϣ����˳���
  }
  if (vIndex==5){  
    WebOpenSignature(); //ǩ��ӡ��
  }
  if (vIndex==6){  
    WebShowSignature(); //��֤ǩ��
  }
  if (vIndex==8){  
    WebSaveVersion();   //����汾
  }
  if (vIndex==9){  
    WebOpenVersion();   //�򿪰汾
  }
  if (vIndex==11){
    SaveDocument();     //�������ĵ���������
    //webform.submit();   //Ȼ���˳�
  }
  if (vIndex==13){  
    WebOpenPrint();     //��ӡ�ĵ�
  }
</script>

<script language=javascript for=WebOffice event=OnToolsClick(vIndex,vCaption)>
  //��Ӧ�������¼�
  if (vIndex==11){
    webform.WebOffice.VisibleTools('��д��ע',false);       //���ػ���ʾiWebOffice������ true��ʾ  false����
  } 
  if (vIndex==12){
    webform.WebOffice.VisibleTools('��д��ע',true);        //���ػ���ʾiWebOffice������ true��ʾ  false����
  }  
  //if (vIndex==-1){webform.WebOffice.Alert(vCaption);}     //�������Ӧ��������ӦiWebOffice��׼�����������ť�¼�����"��д��ע",vCaption="��д��ע"
</script>

<script language=javascript>
/*
form������:webform
iWebOffice����:WebOffice
WebObject�ĵ�����ӿڣ��൱�ڣ�
�����Word  �ļ���WebObject ��Word  VBA��ActiveDocument����
�����Excel �ļ���WebObject ��Excel VBA��ActiveSheet����

�磺webform.WebOffice.WebObject
*/


//���ã���ʾ����״̬
function StatusMsg(mString){
  //webform.StatusBar.value=mString;
}

//���ã�����iWebOffice
function Load(){
  try{
    //�������Ա������ã�ʵʼ��iWebOffice
    webform.WebOffice.WebUrl="<%=mServerUrl%>?Filepath=<%=URLEncoder.encode(FileAdd,"utf-8") %>&FileType=2";      //WebUrl:ϵͳ������·������������ļ������������籣�桢���ĵ�����Ҫ�ļ�
    webform.WebOffice.RecordID="<%=mRecordID%>";            					//RecordID:���ĵ���¼���
    webform.WebOffice.Template="<%=mTemplate%>";            					//Template:ģ����
    webform.WebOffice.FileName="<%=mFileName%>";            					//FileName:�ĵ�����
    webform.WebOffice.FileType="<%=mFileType%>";            					//FileType:�ĵ�����  .doc  .xls  .wps
    webform.WebOffice.UserName="<%=mUserName%>";            					//UserName:�����û������ۼ�������Ҫ
    webform.WebOffice.EditType="<%=mEditType%>";            					//EditType:�༭����  ��ʽһ����ʽ��  <�ο������ĵ�>
                                                            //��һλ����Ϊ0,1,2,3 ����:0���ɱ༭;1���Ա༭,�޺ۼ�;2���Ա༭,�кۼ�,�����޶�;3���Ա༭,�кۼ�,���޶���
                                                            //�ڶ�λ����Ϊ0,1 ����:0������ע,1������ע�����Բο�iWebOffice2009��EditType���ԣ���ϸ�ο�������Ƥ��
    webform.WebOffice.MaxFileSize = 4 * 1024;               //�����ĵ���С���ƣ�Ĭ����8M���������ó�4M��
    webform.WebOffice.Language="CH";                        //Language:������֧����ʾѡ��   CH���� TW���� ENӢ��
    //webform.WebOffice.ShowWindow = true;                  //������ʾ�򿪻򱣴��ĵ��Ľ��ȴ��ڣ�Ĭ�ϲ���ʾ

    webform.WebOffice.PenColor="#FF0000";                   //PenColor:Ĭ����ע��ɫ
    webform.WebOffice.PenWidth="1";                         //PenWidth:Ĭ����ע�ʿ�
    webform.WebOffice.Print="1";                            //Print:Ĭ���Ƿ���Դ�ӡ:1���Դ�ӡ��ע,0�����Դ�ӡ��ע
    webform.WebOffice.ShowToolBar="1";                      //ShowToolBar:�Ƿ���ʾ������:1��ʾ,0����ʾ
    webform.WebOffice.UseUSBKey=true;
    
    webform.WebOffice.Compatible=true; 						//true��ʾΪ����ģʽ

    //����Ϊ�Զ��幤������ť�� ����һ:Index��ť���,������:Caption��ť��ʾ����,������:Iconͼ������
    //webform.WebOffice.AppendTools("11","������д��ע",11);  //��OnToolsClick�е� vIndex=11 ,vCaption="������д��ע";
    //webform.WebOffice.AppendTools("12","��ʾ��д��ע",12);  //��OnToolsClick�е� vIndex=12 ,vCaption="��ʾ��д��ע";
   // webform.WebOffice.AppendTools("13","-",0);
    //����Ϊ�Զ��幤������ť��

    webform.WebOffice.ShowMenu="1";                         //��������˵���ʾ
    //����Ϊ�Զ���˵���
    webform.WebOffice.AppendMenu("1","�򿪱����ļ�(&L)");
    webform.WebOffice.AppendMenu("2","���汾���ļ�(&S)");
    //webform.WebOffice.AppendMenu("3","����Զ���ļ�(&U)");
    webform.WebOffice.AppendMenu("4","-");
    webform.WebOffice.AppendMenu("5","ǩ��ӡ��(&Q)");
    webform.WebOffice.AppendMenu("6","��֤ǩ��(&Y)");
    //webform.WebOffice.AppendMenu("7","-");
    //webform.WebOffice.AppendMenu("8","����汾(&B)");
    //webform.WebOffice.AppendMenu("9","�򿪰汾(&D)");
    //webform.WebOffice.AppendMenu("10","-");
    //webform.WebOffice.AppendMenu("11","���沢�˳�(&E)");
    webform.WebOffice.AppendMenu("12","-");
    webform.WebOffice.AppendMenu("13","��ӡ�ĵ�(&P)");
    //����Ϊ�Զ���˵���
    webform.WebOffice.DisableMenu("��(&M);ѡ��(&O)...");    //��ֹĳ����Щ���˵���

    //WebSetRibbonUIXML();                                  //����OFFICE2007��ѡ���ʾ
    webform.WebOffice.WebOpen();                            //�򿪸��ĵ�    ����OfficeServer  �����ĵ�OPTION="LOADFILE"    ����ģ��OPTION="LOADTEMPLATE"     <�ο������ĵ�>
    webform.WebOffice.ShowType=<%=mShowType%>;              //�ĵ���ʾ��ʽ  1:��ʾ������ע  2:��ʾ��д��ע  0:��ʾ�ĵ��˸�

    StatusMsg(webform.WebOffice.Status);                    //״̬��Ϣ
  }catch(e){
    alert(e.description);                                   //��ʾ��������Ϣ
  }
}

//���ã��˳�iWebOffice
function UnLoad(){
  try{
    if (!webform.WebOffice.WebClose()){
      StatusMsg(webform.WebOffice.Status);
    }else{
      StatusMsg("�ر��ĵ�...");
    }
  }catch(e){
    alert(e.description);
  }
}

//���ã����ĵ�
function LoadDocument(){
  StatusMsg("���ڴ��ĵ�...");
  if (!webform.WebOffice.WebOpen()){  	//�򿪸��ĵ�    ����OfficeServer��OPTION="LOADFILE"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//���ã������ĵ�
function SaveDocument(){
  //webform.WebOffice.WebSetMsgByName("MyDefine1","�Զ������ֵ1");  //���ñ���MyDefine1="�Զ������ֵ1"�������������ö��  ��WebSave()ʱ��һ���ύ��OfficeServer��
  document.getElementById("submit").disabled = true;
  if (!webform.WebOffice.WebSave(true)){    //����OfficeServer��OPTION="SAVEFILE"  ע��WebSave()�Ǳ��渴�ϸ�ʽ�ļ�������OFFICE���ݺ���д��ע�ĵ�����ֻ�����OFFICE�ĵ���ʽ����ô����WebSave(true)
     document.getElementById("submit").disabled = false;
     StatusMsg(webform.WebOffice.Status);
     alert("����ʧ��!");
     return false;
  }else{
  	 document.getElementById("submit").disabled = false;
     StatusMsg(webform.WebOffice.Status);
     alert("����ɹ�!");
     return false;
  }
}


//���ã���ʾ�����غۼ�[���غۼ�ʱ�޸��ĵ�û�кۼ�����]  true��ʾ���غۼ�  false��ʾ��ʾ�ۼ�
function ShowRevision(mValue){
  if (mValue){
     webform.WebOffice.WebShow(true);
     StatusMsg("��ʾ�ۼ�...");
  }else{
     webform.WebOffice.WebShow(false);
     StatusMsg("���غۼ�...");
  }
}


//���ã���ʾ�����غۼ�[���غۼ�ʱ�޸��ĵ��кۼ�����]  true��ʾ���غۼ�  false��ʾ��ʾ�ۼ�
function ShowRevision2(mValue){
  if (mValue){
     webform.WebOffice.WebObject.ShowRevisions=true;   //��ʾ�ۼ�
  }else{
     webform.WebOffice.WebObject.ShowRevisions=false;  //���غۼ�
  }
}


//���ã���ȡ�ۼ�
function WebGetRevisions(){
  var Rev = webform.WebOffice.WebObject.Revisions;		//��ȡ�ۼ�����
  var Text="";

  for (i = 1;i <= Rev.Count;i++){
    Text=Text +"��"+ Rev.Item(i).Author+"��";
    if (Rev.Item(i).Type=="1"){
      Text=Text + '���в��룺'+Rev.Item(i).Range.Text+"\r\n";
    }else if (Rev.Item(i).Type=="2"){
      Text=Text + '����ɾ����'+Rev.Item(i).Range.Text+"\r\n";
    }
	else {
      Text=Text + '���������������������ݣ���'+Rev.Item(i).Range.Text+ '������������'+Rev.Item(i).FormatDescription+"����\r\n";
    }
  }
  alert("�ۼ����ݣ�\r\n\r\n"+Text);
}

//���ã�ˢ���ĵ�
function WebReFresh(){
  webform.WebOffice.WebReFresh();
  StatusMsg("�ĵ���ˢ��...");
}


//���ã��򿪰汾
function WebOpenVersion(){
  webform.WebOffice.WebOpenVersion();  	//����OfficeServer  �г��汾OPTION="LISTVERSION"     �����汾OPTION="LOADVERSION"   <�ο������ĵ�>
  StatusMsg(webform.WebOffice.Status);
}

//���ã�����汾
function WebSaveVersion(){
  webform.WebOffice.WebSaveVersion();  	//����OfficeServer��OPTION="SAVEVERSION"
  StatusMsg(webform.WebOffice.Status);

}

//���ã����浱ǰ�汾
function WebSaveVersionByFileID(){
  var mText=window.prompt("������汾˵��:","�汾��:V");
  if (mText==null){
     mText="���޸İ汾.";
  }
  webform.WebOffice.WebSaveVersionByFileID(mText);  	//����OfficeServer��OPTION="SAVEVERSION"  ͬʱ��FileIDֵ   <�ο������ĵ�>
  StatusMsg(webform.WebOffice.Status);
}


//���ã����ģ��
function LoadBookmarks(){
  StatusMsg("�������ģ��...");
  if (!webform.WebOffice.WebLoadBookmarks()){  	//����OfficeServer��OPTION="LOADBOOKMARKS"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//���ã���ǩ����
function WebOpenBookMarks(){
  try{
    webform.WebOffice.WebOpenBookmarks();  	//����OfficeServer��OPTION="LISTBOOKMARKS"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//���ã�������ǩֵ  vbmName:��ǩ���ƣ�vbmValue:��ǩֵ   ��ǩ����ע���Сд
function SetBookmarks(vbmName,vbmValue){
  if (!webform.WebOffice.WebSetBookmarks(vbmName,vbmValue)){
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//���ã����ݱ�ǩ���ƻ�ȡ��ǩֵ  vbmName:��ǩ����
function GetBookmarks(vbmName){
  var vbmValue;
  vbmValue=webform.WebOffice.WebGetBookmarks(vbmName);
  return vbmValue;
}

//���ã���ӡ�ĵ�
function WebOpenPrint(){
  try{
    webform.WebOffice.WebOpenPrint();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}


//���ã�ҳ������
function WebOpenPageSetup(){
   try{
	if (webform.WebOffice.FileType==".doc"){
	  webform.WebOffice.WebObject.Application.Dialogs(178).Show();
	}
	if(webform.WebOffice.FileType==".xls"){
	  webform.WebOffice.WebObject.Application.Dialogs(7).Show();
	}
   }catch(e){alert(e.description);}
}

//���ã�����ͼƬ
function WebOpenPicture(){
  try{
    webform.WebOffice.WebOpenPicture();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//���ã�ǩ��ӡ��
function WebOpenSignature(){
  alert("�����Ҫ����ȫǩ��,������ý��iSignature����ǩ���������ǩ��:\r\n���ص�ַhttp://www.goldgrid.cn/iSignature/Download.asp\r\n\r\n�������֧���ĵ������Ա�����CA֤�������ǩ��������,\r\n��ͨ����<���ҹ������͹��ұ��ܾ�>˫����֤�İ�ȫ����ǩ�²�Ʒ!");
  try{
    webform.WebOffice.WebOpenSignature();  	//����OfficeServer�� Aǩ���б�OPTION="LOADMARKLIST"    Bǩ�µ���OPTION="LOADMARKIMAGE"    Cȷ��ǩ��OPTION="SAVESIGNATURE"    <�ο������ĵ�>
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//���ã���֤ӡ��A
function WebShowSignature(){
  try{
    webform.WebOffice.WebShowSignature();  	//����OfficeServer��OPTION="LOADSIGNATURE"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//���ã���֤ӡ��B
function WebCheckSignature(){
  try{
    var i=webform.WebOffice.WebCheckSignature();  	//����OfficeServer��OPTION="LOADSIGNATURE"
    alert("�������"+i+"\r\n ע��: (=-1 �зǷ�ӡ��) (=0 û���κ�ӡ��) (>=1 �ж���Ϸ�ӡ��)");
    StatusMsg(i);
  }catch(e){alert(e.description);}
}

//���ã���Ϊ�����ļ�
function WebSaveLocal(){
  try{
    webform.WebOffice.WebSaveLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//���ã��򿪱����ļ�
function WebOpenLocal(){
  try{
    webform.WebOffice.WebOpenLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//���ã�����ΪHTML�ĵ�
function WebSaveAsHtml(){
  try{
    if (webform.WebOffice.WebSaveAsHtml())  	//����OfficeServer��OPTION="SAVEASHTML"
    {
      webform.HTMLPath.value="HTML/<%=mRecordID%>.htm";
      window.open("<%=mHttpUrl%>"+ webform.HTMLPath.value);
    }
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}


//���ã�����Ϊ�ĵ�ͼƬ
function WebSaveAsPage(){
  try{
    if (webform.WebOffice.WebSaveImage())  	//����OfficeServer��OPTION="SAVEIMAGE"
    {
      webform.HTMLPath.value="HTMLIMAGE/<%=mRecordID%>.htm";
      window.open("<%=mHttpUrl%>"+ webform.HTMLPath.value);
    }
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}


//���ã��رջ���ʾ���� ����1��ʾ����������  ����2Ϊfalseʱ����ʾ�ر�  �����ƾ��ɲ���VBA������
//����2Ϊtrueʱ����ʾ��ʾ
function WebToolsVisible(ToolName,Visible){
  try{
    webform.WebOffice.WebToolsVisible(ToolName,Visible);
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}


//���ã���ֹ�����ù��� ����1��ʾ����������  ����2��ʾ�������ť�ı��  �����ƺͱ�ž��ɲ���VBA������
//����3Ϊfalseʱ����ʾ��ֹ  ����3Ϊtrueʱ����ʾ����
function WebToolsEnable(ToolName,ToolIndex,Enable){
  try{
    webform.WebOffice.WebToolsEnable(ToolName,ToolIndex,Enable);
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//���ã���������  ����1Ϊtrue��ʾ�����ĵ�  false��ʾ�������
function WebProtect(value){
  try{
    webform.WebOffice.WebSetProtect(value,"");  //""��ʾ����Ϊ��
  }catch(e){alert(e.description);}
}

//���ã��������ֹ��������  ����1Ϊtrue��ʾ������  false��ʾ��ֹ����
function WebEnableCopy(value){
  try{
    webform.WebOffice.CopyType=value;
  }catch(e){alert(e.description);}
}


//���ã�����Զ�̷�����ͼƬ
function WebInsertImage(){
  try{
    webform.WebOffice.WebInsertImage('Image','GoldgridLogo.jpg',true,4);   //����OfficeServer��OPTION="INSERTIMAGE"  ����1��ʾ��ǩ����  ����2��ʾͼƬ�ļ���  ����3Ϊtrue͸��  false��ʾ��͸��  ����4Ϊ4��ʾ���������Ϸ�  5��ʾ���������·�
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}


//���ã����ط������ļ�������
function WebGetFile(){
  if (webform.WebOffice.WebGetFile("c:\\WebGetFile.doc","DownLoad.doc")){   //����OfficeServer��OPTION="GETFILE"  ����1��ʾ����·��  ����2��ʾ�������ļ�����
    StatusMsg(webform.WebOffice.Status);
  }else{
    StatusMsg(webform.WebOffice.Status);
  }
  alert(webform.WebOffice.Status+"\r\n"+"�ļ�����c:\\WebGetFile.doc");
}


//���ã��ϴ������ļ���������
function WebPutFile(){
  var mLocalFile=webform.WebOffice.WebOpenLocalDialog();
  if (mLocalFile!=""){
    alert(mLocalFile);
    if (webform.WebOffice.WebPutFile(mLocalFile,"Test.doc")){   //����OfficeServer��OPTION="PUTFILE"  ����1��ʾ����·���������κθ�ʽ�ļ�  ����2��ʾ�������ļ�����
      StatusMsg(webform.WebOffice.Status);
    }else{
      StatusMsg(webform.WebOffice.Status);
    }
    alert(webform.WebOffice.Status);
  }
}


//���ã���Զ���ļ�
function WebDownLoadFile(){
  mResult=webform.WebOffice.WebDownLoadFile("http://www.goldgrid.com/Images/abc.doc","c:\\abc.doc");
  if (mResult){
    webform.WebOffice.WebOpenLocalFile("c:\\abc.doc");
    alert("�ɹ�");
  }else{
    alert("ʧ��");
  }
}

//���ã�ȡ�÷�������ʱ�䣬���ñ���ʱ��  [V6.0.1.5����֧��]
function WebDateTime(){
  mResult=webform.WebOffice.WebDateTime(true);   //����OfficeServer��OPTION="DATETIME"   true��ʾ���ز����ñ���ʱ��Ϊ������ʱ�䣻false��ʾ�����ط�����ʱ��
  alert("��ʾ���Ѿ����ñ���ʱ��Ϊ "+mResult);    //�ù�����Ҫ�����ںۼ�����ʱ��ȡ������ʱ��
}


//���ã�������ɼ����
function WebSetWordTable(){
  var mText="",mName="",iColumns,iCells,iTable;
  //����COMMANDΪWORDTABLE
  webform.WebOffice.WebSetMsgByName("COMMAND","WORDTABLE");   //���ñ���COMMAND="WORDTABLE"����WebSendMessage()ʱ��һ���ύ��OfficeServer��
  //���͵���������
  //���û�д���
  if (webform.WebOffice.WebSendMessage()){                //����OfficeServer��OPTION="SENDMESSAGE"
	iColumns = webform.WebOffice.WebGetMsgByName("COLUMNS");  //ȡ����
	iCells = webform.WebOffice.WebGetMsgByName("CELLS");      //ȡ����
	iTable=webform.WebOffice.WebObject.Tables.Add(webform.WebOffice.WebObject.Application.Selection.Range,iCells,iColumns);   //���ɱ��
	for (var i=1; i<=iColumns; i++)
	{
   	  for (var j=1; j<=iCells; j++)
	  {
		mName=i.toString()+j.toString();
		mText=webform.WebOffice.WebGetMsgByName(mName);	 //ȡ��OfficeServer�еı������
		iTable.Columns(i).Cells(j).Range.Text=mText;   	//��䵥Ԫֵ
	   }
	}
   }
   StatusMsg(webform.WebOffice.Status);
}


//���ã���ȡ�ĵ�Txt����
function WebGetWordContent(){
  try{
    alert(webform.WebOffice.WebObject.Content.Text);
  }catch(e){alert(e.description);}
}

//���ã�дWord����
function WebSetWordContent(){
  var mText=window.prompt("����������:","��������");
  if (mText==null){
     return (false);
  }
  else
  {
     //����Ϊ��ʾѡ�е��ı�
     //alert(webform.WebOffice.WebObject.Application.Selection.Range.Text);
     //����Ϊ�ڵ�ǰ���������ı�
     webform.WebOffice.WebObject.Application.Selection.Range.Text= mText+"\n";
     //����Ϊ�ڵ�һ�κ�����ı�
     //webform.WebOffice.WebObject.Application.ActiveDocument.Range(1).Text=(mText);
  }
}


//���ã���ӡ�ڰ��ĵ�
function WebWordPrintBlackAndWhile(){
   var i,n;

   //ͼƬ��ڰ�
   i=0;
   n=webform.WebOffice.WebObject.Shapes.Count;
   for (var i=1; i<=n; i++)
   {
      webform.WebOffice.WebObject.Shapes.Item(i).PictureFormat.ColorType=3;
   }
   i=0;
   n=webform.WebOffice.WebObject.InlineShapes.Count;
   for (var i=1; i<=n; i++)
   {
      webform.WebOffice.WebObject.InlineShapes.Item(i).PictureFormat.ColorType=3;
   }

   //���ֱ�ڰ�
   webform.WebOffice.WebObject.Application.Selection.WholeStory();
   webform.WebOffice.WebObject.Application.Selection.Range.Font.Color = 0;
}

//���ã���Excel���
function WebGetExcelContent(){
    webform.WebOffice.WebObject.Application.Sheets(1).Select;
    webform.WebOffice.WebObject.Application.Range("C5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "126";
    webform.WebOffice.WebObject.Application.Range("C6").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "446";
    webform.WebOffice.WebObject.Application.Range("C7").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "556";
    webform.WebOffice.WebObject.Application.Range("C5:C8").Select;
    webform.WebOffice.WebObject.Application.Range("C8").Activate;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "=SUM(R[-3]C:R[-1]C)";
    webform.WebOffice.WebObject.Application.Range("D8").Select;
    alert(webform.WebOffice.WebObject.Application.Range("C8").Text);
}


//���ã�����������Ԫ
function WebSheetsLock(){
    webform.WebOffice.WebObject.Application.Sheets(1).Select;

    webform.WebOffice.WebObject.Application.Range("A1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "��Ʒ";
    webform.WebOffice.WebObject.Application.Range("B1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "�۸�";
    webform.WebOffice.WebObject.Application.Range("C1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "��ϸ˵��";
    webform.WebOffice.WebObject.Application.Range("D1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "���";
    webform.WebOffice.WebObject.Application.Range("A2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "��ǩ";
    webform.WebOffice.WebObject.Application.Range("A3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "ë��";
    webform.WebOffice.WebObject.Application.Range("A4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "�ֱ�";
    webform.WebOffice.WebObject.Application.Range("A5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "����";

    webform.WebOffice.WebObject.Application.Range("B2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "0.5";
    webform.WebOffice.WebObject.Application.Range("C2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "ӣ��";
    webform.WebOffice.WebObject.Application.Range("D2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "300";

    webform.WebOffice.WebObject.Application.Range("B3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "2";
    webform.WebOffice.WebObject.Application.Range("C3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "�Ǻ�";
    webform.WebOffice.WebObject.Application.Range("D3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "50";

    webform.WebOffice.WebObject.Application.Range("B4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "3";
    webform.WebOffice.WebObject.Application.Range("C4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "��ɫ";
    webform.WebOffice.WebObject.Application.Range("D4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "90";

    webform.WebOffice.WebObject.Application.Range("B5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "1";
    webform.WebOffice.WebObject.Application.Range("C5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "20cm";
    webform.WebOffice.WebObject.Application.Range("D5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "40";

    //����������
    webform.WebOffice.WebObject.Application.Range("B2:D5").Select;
    webform.WebOffice.WebObject.Application.Selection.Locked = false;
    webform.WebOffice.WebObject.Application.Selection.FormulaHidden = false;
    webform.WebOffice.WebObject.Application.ActiveSheet.Protect(true,true,true);

    alert("�Ѿ�����������ֻ��B2-D5��Ԫ������޸ġ�");
}

//���ã�VBA�׺�
function WebInsertVBA(){

	//����
	var object=webform.WebOffice.WebObject;
	var myl=object.Shapes.AddLine(100,60,305,60)
	myl.Line.ForeColor=255;
	myl.Line.Weight=2;
	var myl1=object.Shapes.AddLine(326,60,520,60)
	myl1.Line.ForeColor=255;
	myl1.Line.Weight=2;

	//object.Shapes.AddLine(200,200,450,200).Line.ForeColor=6;
   	var myRange=webform.WebOffice.WebObject.Range(0,0);
	myRange.Select();

	var mtext="��";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
   	var myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
   	myRange.ParagraphFormat.LineSpacingRule =1.5;
   	myRange.font.ColorIndex=6;
   	myRange.ParagraphFormat.Alignment=1;
   	myRange=webform.WebOffice.WebObject.Range(0,0);
	myRange.Select();
	mtext="���[��������]��������";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
	myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	myRange.ParagraphFormat.LineSpacingRule =1.5;
	myRange.ParagraphFormat.Alignment=1;
	myRange.font.ColorIndex=1;

	mtext="�����������ļ�";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
	myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	myRange.ParagraphFormat.LineSpacingRule =1.5;

	//myRange.Select();
	myRange.Font.ColorIndex=6;
	myRange.Font.Name="����_GB2312";
	myRange.font.Bold=true;
	myRange.Font.Size=50;
	myRange.ParagraphFormat.Alignment=1;

	//myRange=myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	webform.WebOffice.WebObject.PageSetup.LeftMargin=70;
	webform.WebOffice.WebObject.PageSetup.RightMargin=70;
	webform.WebOffice.WebObject.PageSetup.TopMargin=70;
	webform.WebOffice.WebObject.PageSetup.BottomMargin=70;
}

//���ã�ģ���׺칦��
function WebUseTemplate(){
  var mDialogUrl = "Template/TemplateForm.htm";
  var mObject = new Object();
  mObject.Template = "";
  window.showModalDialog(mDialogUrl, mObject, "dialogHeight:200px; dialogWidth:360px;center:yes;scroll:no;status:no;");

  //�ж��û��Ƿ�ѡ��ģ��
  if (mObject.Template==""){
    StatusMsg("ȡ������ģ��");
    return false;
  }else{
    if(WebAcceptAllRevisions()==false){                         //������ĺۼ���Ŀ����Ϊ�˱���ۼ�״̬�³��������쳣���⡣
      StatusMsg("������ĺۼ�ʧ�ܣ��׺���ֹ");
      return false;      
    }
    SaveDocument();                                             //���浱ǰ�༭���ĵ�
    webform.WebOffice.WebSetMsgByName("COMMAND","INSERTFILE");  //���ñ���COMMAND="INSERTFILE"����WebLoadTemplate()ʱ��һ���ύ��OfficeServer��     <�ο������ĵ�>
    webform.WebOffice.Template=mObject.Template;                //ȫ�ֱ���Template��ֵ����ʾ����ȡ������Ŀ¼��ģ�壬���ȡ���ݿ���ģ�壬TemplateֵΪ���ݿ��е�ģ���ţ����Ͼ���벻��Ҫ����Template="1050560363767"��ģ������Ϊ��Word����ģ�塱��ע��ģ������Ҫ��ǩContent�����ִ�Сд�����������޸�
    webform.WebOffice.EditType="1";                             //����Ϊ�������ۼ���״̬
    if (webform.WebOffice.WebLoadTemplate()){                   //����OfficeServer��OPTION="LOADTEMPLATE"
      //SetBookmarks("Title","�����м���з���������֪ͨ");     //���ģ������������Ϣ������⣬����ʣ��ĺţ����ͻ��ص�
      if (webform.WebOffice.WebInsertFile()){                   //��乫������   ����OfficeServer��OPTION="INSERTFILE"
        StatusMsg("ģ���׺�ɹ�");
        return true;
      }else{
        StatusMsg(webform.WebOffice.Status);
        return false;
      }
    }else{
      StatusMsg(webform.WebOffice.Status);
      return false;
    }
  }
}

//���ã����涨���ļ�
function WebUpdateFile(){
  if (webform.WebOffice.WebUpdateFile()){                //����OfficeServer��OPTION="UPDATEFILE"������WebSave()��WebSaveVersion()����
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}



//��ӡ��������
function WebCopysCtrlPrint(){
  var mCopies,objPrint;
  objPrint = webform.WebOffice.WebObject.Application.Dialogs(88);     //��ӡ���öԻ���
  if (objPrint.Display==-1){
    mCopies=objPrint.NumCopies;    //ȡ����Ҫ��ӡ����
    webform.WebOffice.WebSetMsgByName("COMMAND","COPIES");
    webform.WebOffice.WebSetMsgByName("OFFICEPRINTS",mCopies.toString());   //���ñ���OFFICEPRINTS��ֵ����WebSendMessage()ʱ��һ���ύ��OfficeServer��
    webform.WebOffice.WebSendMessage();                               //����OfficeServer��OPTION="SENDMESSAGE"
    if (webform.WebOffice.Status=="1") {
      alert("���������ӡ��ע����ʵ���������ĵ���ӡ����2��");
      objPrint.Execute;
    }else{
      alert("�ѳ�������Ĵ�ӡ����");
      return false;
    }
  }
}


//���ã�����Text
function WebInportText(){
    var mText;
    webform.WebOffice.WebSetMsgByName("COMMAND","INPORTTEXT");  //���ñ���COMMAND="INPORTTEXT"����WebSendMessage()ʱ��һ���ύ��OfficeServer��
    if (webform.WebOffice.WebSendMessage()){                    //����OfficeServer��OPTION="SENDMESSAGE"
      mText=webform.WebOffice.WebGetMsgByName("CONTENT");       //ȡ��OfficeServer���ݵı���CONTENTֵ
      webform.WebOffice.WebObject.Application.Selection.Range.Text=mText;
      alert("�����ı��ɹ�");
    }
    StatusMsg(webform.WebOffice.Status);
}


//���ã�����Text
function WebExportText(){
    var mText=webform.WebOffice.WebObject.Content.Text;
    webform.WebOffice.WebSetMsgByName("COMMAND","EXPORTTEXT");  //���ñ���COMMAND="EXPORTTEXT"����WebSendMessage()ʱ��һ���ύ��OfficeServer��
    webform.WebOffice.WebSetMsgByName("CONTENT",mText);         //���ñ���CONTENT="mText"����WebSendMessage()ʱ��һ���ύ��OfficeServer�У�������ʵ��ȫ�ļ������ܣ���WORD��TEXT���ݽ��м���
    if (webform.WebOffice.WebSendMessage()){                    //����OfficeServer��OPTION="SENDMESSAGE"
      alert("�����ı��ɹ�");
    }
    StatusMsg(webform.WebOffice.Status);
}


//���ã���ȡ�ĵ�ҳ��
function WebDocumentPageCount(){
  var intPageTotal = webform.WebOffice.WebObject.Application.ActiveDocument.BuiltInDocumentProperties(14);
  alert("�ĵ�ҳ������"+intPageTotal);
}

//���ã�ǩ�������ļ�����
function WebSignatureAtReadonly(){
  webform.WebOffice.WebSetProtect(false,"");                  //����ĵ�����
  webform.WebOffice.WebSetRevision(false,false,false,false);  //�����ĵ��ۼ�������״̬  ����1:����ʾ�ۼ�  ����2:�������ۼ�  ����3:����ӡʱ�кۼ�  ����4:���Ժۼ�������
  try{
    webform.WebOffice.WebOpenSignature();                     //����OfficeServer�� Aǩ���б�OPTION="LOADMARKLIST"    Bǩ�µ���OPTION="LOADMARKIMAGE"    Cȷ��ǩ��OPTION="SAVESIGNATURE"    <�ο������ĵ�>    �ĵ���Ҫ�����ǩManager�����������޸ı�ǩ����
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
  webform.WebOffice.WebSetProtect(true,"");                   //�����ĵ�
}

//���ã��ͻ��˺ͷ���������Ϣ��Ϣ����
function WebSendInformation(){
  var info = window.prompt("������Ҫ��������������ҳ���ϵ�����:","��������");
  if (info==null){return false}

  webform.WebOffice.WebSetMsgByName("COMMAND","SELFINFO");		//���ñ���COMMAND="SELFINFO"�������ڷ����������жϣ��Խ��봦���Զ���������ݵĴ��롣
  webform.WebOffice.WebSetMsgByName("TESTINFO",info);			//�Զ����һ������"TESTINFO"����info��������Ϣ���õ���Ϣ���У��Ա㴫����̨��
  if (webform.WebOffice.WebSendMessage()){						//���̨����Ϣ��������OfficeServer��OPTION="SENDMESSAGE"��
    info = webform.WebOffice.WebGetMsgByName("RETURNINFO");		//��������ɹ������ܷ������˷��ص���Ϣ��
	alert(info);
  }
  else{
    StatusMsg(webform.WebOffice.Status);
  }
}

//�жϱ༭��
function GetEditer(){
  if(webform.WebOffice.WebApplication(".doc")){     //WORD
    alert("����WORD�༭��");
  }
  if(webform.WebOffice.WebApplication(".xls")){     //EXCEL
    alert("����EXCEL�༭��");
  }
  if(webform.WebOffice.WebApplication(".wps")){     //��ɽWPS
    alert("����WPS�༭��");
  }
  if(webform.WebOffice.WebApplication(".et")){      //��ɽ���
    alert("����ET�༭��");
  }
  //������������".ppt"��".vso"......
}

//����OFFICE2007��ѡ���ʾ
function WebSetRibbonUIXML(){
  webform.WebOffice.RibbonUIXML = '' +
  '<customUI xmlns="http://schemas.microsoft.com/office/2006/01/customui">' +
  '  <ribbon startFromScratch="false">'+                    //����ʾ����ѡ����� false��ʾѡ���true����ʾѡ�
  '    <tabs>'+
  '      <tab idMso="TabReviewWord" visible="false">' +     //�ر���ͼ������
  '      </tab>'+
  '      <tab idMso="TabInsert" visible="false">' +         //�رղ��빤����
  '      </tab>'+
  '      <tab idMso="TabHome" visible="false">' +           //�رտ�ʼ������
  '      </tab>'+
  '    </tabs>' +
  '  </ribbon>' +
  '</customUI>';

/*
    ��õ�����ѡ�����
    ѡ�����      idMso��Excel��      idMso��Word��       idMso��Access��
    ��ʼ            TabHome             TabHome             TabHomeAccess
    ����            TabInsert           TabInsert           ��none��
    ҳ�沼��        TabPageLayoutExcel  TabPageLayoutWord   ��none��
    ��ʽ            TabFormulas         ��none��            ��none��
    ����            TabData             ��none��            ��none��
    ��ͼ            TabReview           TabReviewWord       ��none��
    ����            ��none��            ��none��            TabCreate
    �ⲿ����        ��none��            ��none��            TabExternalData
    ���ݿ⹤��      ��none��            ��none��            TabDatabaseTools
*/

/*
    iWebOffice�ؼ���RibbonUIXML���ԣ��ǻ���OFFICE2007��RibbonX��Ӧ�á�����RibbonX��������ϣ���Ҫ�Լ����в�ѯ��
*/
}

//��ȡע���ʮ���ƣ�
function WebReadRegString(){
  try{
    webform.WebOffice.WebOpenKey('HKEY_CURRENT_USER', 'Software\\Microsoft\\Office\\12.0\\Common\\Toolbars');    //��ע���
    var Content = webform.WebOffice.WebReadString('AddNewString');                                          //��ȡע���
    webform.WebOffice.WebCloseKey();                                                                        //�ر�ע���
    alert(Content);
  }
  catch(e){
    alert(e.description);
    webform.WebOffice.WebCloseKey();
  } 
} 

//д��ע���ʮ���ƣ�
function WebWriteRegString(){
  try{
    webform.WebOffice.WebOpenKey('HKEY_CURRENT_USER', 'Software\\Microsoft\\Office\\12.0\\Common\\Toolbars');    //��ע���
    var result = webform.WebOffice.WebWriteString('AddNewString','1234');                                   //д��ע���
    webform.WebOffice.WebCloseKey();                                                                        //�ر�ע���
    if (result) {
      alert("д��ע���ɹ���");
    }else{
      alert("д��ע���ʧ�ܣ�");
    }
  }
  catch(e){
    alert("д��ע���ʧ�ܣ�ԭ��"+e.description);
    webform.WebOffice.WebCloseKey();
  } 
} 

//��ȡע���ʮ�����ƣ�
function WebReadRegInteger(){
  try{
    webform.WebOffice.WebOpenKey('HKEY_CURRENT_USER', 'Software\\Microsoft\\Office\\12.0\\Common\\Toolbars');    //��ע���
    var Content = webform.WebOffice.WebReadInteger('AddNewInteger');                                        //��ȡע���
    webform.WebOffice.WebCloseKey();                                                                        //�ر�ע���
    alert(Content);
  }
  catch(e){
    alert(e.description);
    webform.WebOffice.WebCloseKey();
  } 
}

//д��ע���ʮ�����ƣ�
function WebWriteRegInteger(){
  try{
    webform.WebOffice.WebOpenKey('HKEY_CURRENT_USER', 'Software\\Microsoft\\Office\\12.0\\Common\\Toolbars');    //��ע���
    var result = webform.WebOffice.WebWriteInteger('AddNewInteger',5678);                                   //д��ע���
    webform.WebOffice.WebCloseKey();                                                                        //�ر�ע���
    if (result) {
      alert("д��ע���ɹ���");
    }else{
      alert("д��ע���ʧ�ܣ�");
    }
  }
  catch(e){
    alert(e.description);
    webform.WebOffice.WebCloseKey();
  } 
} 

//�����ĵ���ȫ���ۼ�
function WebAcceptAllRevisions(){
  webform.WebOffice.WebObject.Application.ActiveDocument.AcceptAllRevisions();
  var mCount = webform.WebOffice.WebObject.Application.ActiveDocument.Revisions.Count;
  if(mCount>0){
    return false;
  }else{
    return true;
  }
}

//�򿪵ķ������ϵ��ĵ����޸�
function WebOpenAndRepair(){
  webform.WebOffice.WebRepairMode = true;   //���޸�ģʽ
  webform.WebOffice.WebOpen();              //�ص��ղŴ򿪵ķ������ϵ��ĵ�
  StatusMsg(webform.WebOffice.Status);
  webform.WebOffice.WebRepairMode = false;  //�ر��޸�ģʽ
}

//�򿪱����ϵ��ĵ����޸�
function WebOpenLocalAndRepair(){
  webform.WebOffice.WebRepairMode = true;   //���޸�ģʽ
  webform.WebOffice.WebOpenLocal();         //�򿪱����ϵ��ĵ�
  StatusMsg(webform.WebOffice.Status);
  webform.WebOffice.WebRepairMode = false;  //�ر��޸�ģʽ
}

</script>

</head>
<body bgcolor="#ffffff" onload="Load()" onunload="UnLoad()">  <!--�������˳�iWebOffice-->
    	<form name="webform" method="post" action="iWebOffice/DocumentSave.jsp"  onsubmit="return SaveDocument();">  <!--����iWebOffice���ύ����Ϣ-->
		    <input type="hidden" name="RecordID" value="<%=mRecordID%>">
		    <input type="hidden" name="Template" value="<%=mTemplate%>">
		    <input type="hidden" name="FileType" value="<%=mFileType%>">
		    <input type="hidden" name="EditType" value="<%=mEditType%>">
		    <input type="hidden" name="HTMLPath" value="<%=mHTMLPath%>">
		    <!-- <a class='nui-button' plain='false' iconCls="icon-save" onclick="save()">
                               �����ĵ�
                            </a> -->
            <input type="submit"  value="�����ĵ�" id="submit" style="width: 80px;height: 30px;" />             
		    <table border=0 cellspacing='0' cellpadding='0' width=100% height=94% align=center class=TBStyle  >
		      
		      <tr width="400px">
		        <!-- <td align="center" valign=top class="TDTitleStyle" width="400px" height="100%">
		           
		           
			    </td> -->
		        <td height="100%" colspan="2" rowspan="12" align="right" valign="top" class="TDStyle" hegith="100%">
		          
		          <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
		            <tr>
		              <td bgcolor="menu" height="98%" valign="top" >
		                <!--����iWebPicture��ע��汾�ţ�����������-->
					    <script src="iWebOffice2009.js"></script>
		              </td>
		            </tr>
		          </table>
		           
		        </td>
		      </tr>
		    </table>
		  </form>
</body>

</html>