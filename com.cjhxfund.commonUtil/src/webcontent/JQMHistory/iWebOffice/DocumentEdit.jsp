<%@page import="com.cjhxfund.commonUtil.ParamConfig"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.cjhxfund.commonUtil.iDBManager2000"%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*" %>
<%!
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
<%
  ResultSet result=null;
  String mSubject=null;
  String mStatus=null;
  String mAuthor=null;
  String mFileDate=null;
  String mFileName ="";
  String FileName = "";     //文档名称
  String FileAdd = "";      //文档地址
  String type = request.getParameter("type");   //状态

  //自动获取OfficeServer和OCX文件完整URL路径
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName="commonUtil/JQMHistory/iWebOffice/PDFServer.jsp";

  //String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/"+mServerName;//取得OfficeServer文件的完整URL
  //String mHttpUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/";
  
  String agentAccessURL = ParamConfig.getValue("ZHFWPT_AGENT_ACCESS_URL");//获取代理服务器URL
  String serverType = ParamConfig.getValue("ZHFWPT_SERVER_TYPE");//获取URL类型：0-获取本地路径（测试环境）；1-获取设置在数据中的代理路径（生产环境）；
  
  String mServerUrl = "";
  String mHttpUrl = "";
  String applyName = mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName));    //获取项目应用名称
  
  //判断当前是获取本地路径还是代理路径
  if(serverType.equalsIgnoreCase("0")){
  	mServerUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + applyName + "/" + mServerName;//取得OfficeServer文件的完整URL
    mHttpUrl = "http://" + request.getServerName()+ ":" + request.getServerPort() + applyName +  "/";
  }else{
    mServerUrl = agentAccessURL + applyName + "/" + mServerName;
    mHttpUrl = agentAccessURL + applyName + "/";
  }
  
  System.out.println("PDF mServerUrl ====" + mServerUrl);
  System.out.println("PDF mHttpUrl ====" + mHttpUrl);
  	
  String mRecordID=request.getParameter("sysid");
  //request.getParameter("UserName")
  String mUserName="";

  //取得编号
  if ( mRecordID == null)
  {
     mRecordID="1";	//编号为空
  }
  //取得用户名
  if (mUserName==null || mUserName=="")
  {
    mUserName="金格科技";
  }

  //打开数据库
  iDBManager2000 DbaObj=new iDBManager2000();
  if (DbaObj.OpenConnection())
  {
    String mSql="Select * From CF_JY_ATTACH_INFO Where sysid='"+ mRecordID + "'";
    try
    {
      result=DbaObj.ExecuteQuery(mSql);
      if (result.next())
      {
        mRecordID=result.getString("sysid");
        FileName = result.getString("attach_name");
        FileAdd =  result.getString("attach_add");
       // mSubject=result.getString("Subject");
        //mAuthor=result.getString("Author");
       // mFileDate=result.getString("FileDate");
       // mStatus=result.getString("Status");
      }
      else
      {
	//取得唯一值(mRecordID)
        java.util.Date dt=new java.util.Date();
        long lg=dt.getTime();
        Long ld=new Long(lg);
	//初始化值
        mRecordID=ld.toString();//保存的是文档的编号，通过该编号，可以在里找到所有属于这条纪录的文档
        mSubject="请输入主题";
        mAuthor=mUserName;
        mFileDate=DbaObj.GetDateTime();
        mStatus="DERF";
      }
      result.close();
    }
    catch(SQLException e)
    {
      System.out.println(e.toString());
    }
    DbaObj.CloseConnection() ;
  }
%>

<html>
<head>
<title>金格iWebPDF示例程序</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel='stylesheet' type='text/css' href='test.css'>
<!--
<script language="javascript" for=WebPDF event="OnOpen()">
  alert("打开成功");
</script>

<script language="javascript" for=WebPDF event="OnClose()">
  alert("关闭成功");
</script>
-->
<script language=javascript>
/*
form表单名称:webform
iWebPDF名称:WebPDF
*/

//作用：显示操作状态
function StatusMsg(mString){
  //webform.StatusBar.value=mString;
}

//作用：载入iWebPDF
function Load(){
  try{
    //以下属性必须设置，实始化iWebPDF
    webform.WebPDF.WebUrl="<%=mServerUrl%>?Filepath=<%=URLEncoder.encode(FileAdd,"utf-8") %>";    //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档 
    webform.WebPDF.RecordID="<%=mRecordID %>";   //RecordID:本文档记录编号
    webform.WebPDF.FileName="<%=FileName %>";   //FileName:文档名称
    webform.WebPDF.UserName="lisi";   			//UserName:操作用户名
   

    webform.WebPDF.ShowTools = 1;               //工具栏可见（1,可见；0,不可见）
    webform.WebPDF.SaveRight = 1;               //是否允许保存当前文档（1,允许；0,不允许）
    webform.WebPDF.PrintRight = 1;              //是否允许打印当前文档（1,允许；0,不允许）
    webform.WebPDF.AlterUser = false;           //是否允许由控件弹出提示框 true表示允许  false表示不允许

    webform.WebPDF.ShowBookMark = 1;			//是否显示书签树按钮（1,显示；0,不显示）
    webform.WebPDF.ShowSigns = 1;         	    //设置签章工具栏当前是否可见（1,可见；0,不可见）
    webform.WebPDF.EnableHandWriter=true;
    
    //alert(webform.WebPDF.HaveSignature);
    //webform.WebPDF.HaveSignature = 1;
    //alert(webform.WebPDF.SideWidth);          //显示侧边栏的宽度
    
    webform.WebPDF.SideWidth = 100;             //设置侧边栏的宽度
 
    webform.WebPDF.WebOpen();                   //打开该文档    交互OfficeServer的OPTION="LOADFILE"    <参考技术文档>
    StatusMsg(webform.WebPDF.Status);           //状态信息

    webform.WebPDF.Zoom = 100;                  //缩放比例
    webform.WebPDF.Rotate = 360;                //当显示页释放角度
    webform.WebPDF.CurPage = 1;                 //当前显示的页码
    
  }catch(e){
    alert(e.description);                       //显示出错误信息
  }
}

//作用：退出iWebPDF
function UnLoad(){
  try{
    if (!webform.WebPDF.WebClose()){
      StatusMsg(webform.WebPDF.Status);
    }else{
      StatusMsg("关闭文档...");
    }
  }catch(e){
    alert(e.description);
  }
}

//作用：打开文档
function LoadDocument(){
  StatusMsg("正在打开文档...");
  if (!webform.WebPDF.WebOpen()){               //打开该文档    交互OfficeServer的OPTION="LOADFILE"
    StatusMsg(webform.WebPDF.Status);
  }else{
    StatusMsg(webform.WebPDF.Status);
  }
}

//作用：保存文档
function SaveDocument(){
  //webform.WebPDF.WebSetMsgByName("mydefine1","自定义变量值");  //设置变量MyDefine1="自定义变量值1"，变量可以设置多个  在WebSave()时，一起提交到OfficeServer中
  document.getElementById("submit").disabled = true;
  if (!webform.WebPDF.WebSave()){               //交互OfficeServer的OPTION="SAVEFILE"
  	alert("保存成功");
  	document.getElementById("submit").disabled = false;
    StatusMsg(webform.WebPDF.Status);
    return false;
  }else{
    alert("保存失败");
    document.getElementById("submit").disabled = false;
    StatusMsg(webform.WebPDF.Status);
    return true;
  }
}

//作用：关闭文档
function WebClose(){
  try{
    webform.WebPDF.WebClose();
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：保存本地文档
function WebSaveLocal(){
  try{
    webform.WebPDF.WebSaveLocal();
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：打开本地文档
function WebOpenLocal(){
  try{
    webform.WebPDF.WebOpenLocal();
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：打印文档控制打印份数
function WebPrintCtrl(Ctrl){
  try{
	webform.WebPDF.WebPrint(Ctrl,"",1,webform.WebPDF.PageCount,true);
    StatusMsg(webform.WebPDF.Status);
  }
  catch(e){
    alert(e.description);
  }
}

//作用：翻至第一页
function WebGotoFirstPage(){
  try{
    webform.WebPDF.GotoFirstPage();
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：翻至最后一页
function WebGotoLastPage(){
  try{
    webform.WebPDF.GotoLastPage();
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：翻至前一页
function WebGotoPreviousPage(){
  try{
    webform.WebPDF.GotoPreviousPage();
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：翻至后一页
function WebGotoNextPage(){
  try{
    webform.WebPDF.GotoNextPage();
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：获取当前文档页数
function WebPageCount(){
  try{
    var mCount = webform.WebPDF.PageCount;
    alert("当前文档总页数为："+mCount)
  }catch(e){
    alert(e.description);
  }
}

//作用：当前显示模式（1 单页 2 双页 3 连续单页(默认) 4 连续双页）
function WebDisplayMode(mValue){
  try{
    webform.WebPDF.DisplayMode = mValue;
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用:禁用,启用全部功能按钮(参数ToolsName:按钮的名称;mValue:true启用 flase禁用)
function WebEnableTools(ToolNames,mValue){
  try{
    webform.WebPDF.EnableTools(ToolNames,mValue);
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description)
  }
}

//作用：通过Url打开文档
function WebOpenUrlFile(mUrl){
  try{
    webform.WebPDF.WebOpenUrlFile(mUrl);
    StatusMsg(webform.WebPDF.Status);
  }catch(e){
    alert(e.description);
  }
}

//作用：下载指定文件
function WebDownLoadFile(mUrl,mFileName){
  try{
    webform.WebPDF.WebDownLoadFile(mUrl,mFileName);
    alert("下载保存成功，保存地址为C:\\123.pdf。");
  }catch(e){
    alert(e.description);
  }
}

//作用：客户端和服务器端信息交互
function WebSendInformation(){
  var info = window.prompt("请输入要传到服务器处理页面上的内容:","参数内容");
  if (info==null){return false}

  webform.WebPDF.WebSetMsgByName("COMMAND","SELFINFO");     //设置变量COMMAND="SELFINFO"，用来在服务器端做判断，以进入处理自定义参数传递的代码。
  webform.WebPDF.WebSetMsgByName("TESTINFO",info);          //自定义的一个参数"TESTINFO"，将info变量的信息设置到信息包中，以便传到后台。
  if (webform.WebPDF.WebSendMessage()){                     //向后台发信息包。交互OfficeServer的OPTION="SENDMESSAGE"。
    info = webform.WebPDF.WebGetMsgByName("RETURNINFO");    //如果交互成功，接受服务器端返回的信息。
    alert(info);
  }
  else{
    StatusMsg(webform.WebPDF.Status);
  }
}


//作用：在PDF文档中增加水印
function WebSetWateMark(mText){
  try{
    var mPageCount = webform.WebPDF.PageCount;                              //webform.WebPDF.PageCount获得当前总页数
    if (webform.WebPDF.EditStatus){                                         //获取当前PDF文档状态，可以允许更改的文档就可以执行水印写操作
      webform.WebPDF.WateMark(1,mPageCount,mText,25,125,45,true,-1,-1);     //设置水印。参数一：开始页；参数二：结束页；参数三：水印文本；参数四：透明度；参数五：字体大小；参数六：旋转角度（逆时针）；参数七：水印位置；参数八：水印X坐标；参数九：水印Y坐标。
      //alert("该PDF文档允许编辑，增加水印成功");
    }else{
      alert("该PDF文档不允许编辑，无法增加水印");
    }
  }catch(e){
    alert(e.description);                                       //显示出错误信息
  }
}

//=====================iSignature PDF电子签章相关接口========================================


//作用：调用签章窗体
function WebShowSignDlg(){
  if (!(webform.WebPDF.ShowSignDlg(1))){
    alert("调用签章窗体失败");  
  }
}

//作用：调用批量验证
function WebShowCheckDlg(){
  if (!(webform.WebPDF.ShowCheckDlg())){
    alert("调用批量验证失败");  
  }
}

//作用：调用参数设置窗体
function WebShowParamDlg(){
  if (!(webform.WebPDF.ShowParamDlg())){
    alert("调用参数设置窗体失败");  
  }
}

//作用：获取签章XML数量（UTF-8码）
function WebSignatureItem(){
  alert(webform.WebPDF.SignatureItem(-1));
}

//作用：获取文档中签章数据XML
function GetSignatureItemsXML(){
  var i;
  var LoadOk;
  var ErrorObj;
  var XmlObj = new ActiveXObject("Microsoft.XMLDOM");
  var XmlText;
  
  XmlObj.async = false;
  LoadOk=XmlObj.loadXML(webform.WebPDF.SignatureItem(-1));
  //alert(webform.WebPDF.SignatureItem());
  ErrorObj = XmlObj.parseError;
  if (ErrorObj.errorCode != 0){
    alert("返回信息错误..." + ErrorObj.reason);
  }
  else{
    var CurNodes=XmlObj.getElementsByTagName("Signature_PDF");
    if( 1 == CurNodes.length ){
      var SignNode=CurNodes.item(0);
      if( SignNode.hasChildNodes() ){
        var SignNodes = SignNode.childNodes;
        for (var iXml=0;iXml<SignNodes.length;iXml++){
          var signItem = SignNodes.item(iXml);
          XmlText = "签章是否保护文档：" + signItem.selectSingleNode("SignatureProtect").text + ";    True: 文档改动签章会变化；False: 文档改动签章不会变化\r\n";
          XmlText = XmlText + "文档是否完整：" + signItem.selectSingleNode("SignatureResult").text + ";    True: 文档完整；False: 文档不完整\r\n";
          XmlText = XmlText + "签章名称：" + signItem.selectSingleNode("SignatureName").text + ";\r\n";
          XmlText = XmlText + "签章应用程序：" + signItem.selectSingleNode("SignatureApp").text + ";\r\n";	
          XmlText = XmlText + "签章单位：" + signItem.selectSingleNode("SignatureUnit").text + ";\r\n";	
          XmlText = XmlText + "签章用户：" + signItem.selectSingleNode("SignatureUser").text + ";\r\n";
          XmlText = XmlText + "签章存在钥匙盘序列号：" + signItem.selectSingleNode("SignatureKeySN").text + ";\r\n";
          XmlText = XmlText + "签章序列号：" + signItem.selectSingleNode("SignatureSN").text + ";\r\n";
          XmlText = XmlText + "签章时间：" + signItem.selectSingleNode("SignatureDate").text + ";\r\n";
          XmlText = XmlText + "签章类型：" + signItem.selectSingleNode("SignatureType").text + ";    签章类型，0：没有进行签章，1：电子签章，2：手写签章，3：二维条码\r\n";
          XmlText = XmlText + "文档锁定：" + signItem.selectSingleNode("SignatureLocked").text + ";    True:如果文档处于锁定状态，是该签章执行的锁定功能; False:如果文档处于锁定状态，不是该签章执行的锁定功能\r\n";
          alert(XmlText);
        }
      }
    }
  }
  delete XmlObj;
}

//作用：将页面跳转至指定名称的书签位置(返回值为非零表示成功定位，零表示查找指定名称的书签失败)
function WebGotoBookMark(){
  try{
    var mBookMark = window.prompt("请输入要跳转到的书签名称","书签名称");
    if(mBookMark==null){return false;}
    webform.WebPDF.GotoBookMark(mBookMark);
  }catch(e){
    alert(e.description); 
  }
}

//作用:控制页面是否显示(参数Pages:页面范围;Enable:true显示 flase不显示;Text显示的文字)
function WebEnablePages(){
  try{
    alert("示例中将禁止显示第一页的内容");
    webform.WebPDF.EnablePages(1,false,"第一页已被禁止显示");//可以禁止显示多页，如："1-10,15,20"。
  }catch(e){
    alert(e.description)
  }
}

//作用：获取指定代码所代表的错误文本
function WebGetErrorString(){
   try{
     var mCode = window.prompt("请输入想要查询的错误代码，错误代码从“-1”到“32”总共34个。","14");
     if(mCode==null){return false;}
     var mError=webform.WebPDF.GetErrorString(mCode); //通过错误代码获得错误信息。错误代码从“-1”到“32”，总共34个。
     alert("代码对应的错误信息为："+mError);
  }catch(e){
    alert(e.description);
  }
}

//作用：获取指定页的长度、宽度及角度
function WebGetPageSize(){
  try{
    var mWidth = webform.WebPDF.GetPageSize(1,0); //设置页面宽、高、角度。 参数一：开始页；参数二：返回值类型，0：宽度 1：高度 2：旋转角度
    var mHeight = webform.WebPDF.GetPageSize(1,1);
    var meight = webform.WebPDF.GetPageSize(1,2);

    alert("本例中返回第一页的宽度："+mWidth+"；高度："+mHeight+"；旋转角度："+webform.WebPDF.GetPageSize(1,2));
  }catch(e){
    alert(e.description);
  }
}

//作用：判断文档是否打开
function FileisOpen(){
  try{
    var mOpen = webform.WebPDF.isOpen; //返回1为打开；0为没有打开
    if(mOpen==1){
      mOpen = "文档已经打开！";
    }else{
      mOpen = "没有文档被打开！";
    }
    alert(mOpen);
  }catch(e){
    alert(e.description);
  }
}

//作用：获取当前文档中的所有文字内容，该内容可以用来做全文检索
function GetContentText(){
  try{    
    alert(webform.WebPDF.ContentText);
  }catch(e){
    alert(e.description);
  }
}

</script>
</head>
<body bgcolor="#ffffff" onLoad="Load()" onUnload="UnLoad()" style="width: 100%;height: 100%;overflow: hidden;">  <!--引导和退出iWebPDF-->
<form name="webform" method="post" action="iwebPDF/DocumentSave.jsp" onSubmit="return SaveDocument();">  <!--保存iWebPDF后提交表单信息-->
<input type=hidden name=RecordID value="<%=mRecordID%>">
<table border=0 cellspacing='0' cellpadding='0' width=100% height=100% align=center class=TBStyle>
      <%--<tr>
        <td height="24" align=center class="TDTitleStyle">主　题</td>
        <td class="TDStyle">&nbsp;<input type="text" name="Subject" value="<%=mSubject%>" class="IptStyle" style="WIDTH:75%">&nbsp;|←请输入主题</td>
        <td width="400" rowspan="4" class="TDTitleStyle" align="center"><input type="submit"  value="保存文档">&nbsp;<input type=button onClick="history.back()" value="返回列表"><br><br>注意：只有进行“保存文档”后，所做的操作才有效！</td>
      </tr>
      <tr>
        <td height="24" align=center class="TDTitleStyle">作　者</td>
        <td class="TDStyle">&nbsp;<input type=text name=Author value="<%=mAuthor%>" class="IptStyle"  style="WIDTH:75%">&nbsp;|←请输入作者</td>
      </tr>
      <tr>
        <td height="24" align=center class="TDTitleStyle">时　间</td>
        <td class="TDStyle">&nbsp;<input type=text name=FileDate value="<%=mFileDate%>" readonly class="IptStyleBlack" style="WIDTH:75%">&nbsp;|←编辑时间</td>
      </tr>
      <tr>
        <td height="24" align=center class="TDTitleStyle">状　态</td>
        <td class="TDStyle">&nbsp;<input type=text name=StatusBar readonly class="IptStyleBlack" style="WIDTH:75%">&nbsp;|←状态信息</td>
      </tr>--%>
      <tr width="100" height="28">
        <td align="center" valign=top class="TDTitleStyle" width="100" height="90%">
          <input type="submit"  value="保存文档" id="submit" >
              </td>
        <td height="100%" colspan="2" rowspan="7" align="right" valign="top" class="TDStyle" hegith="100%">
          <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
            <tr>
              <td bgcolor="menu" height="99%" valign="top">
                <!--调用iWebPicture，注意版本号，可用于升级-->
			    <script src="iWebPDF.js"></script>              </td>
            </tr>
          </table>        </td>
      </tr>
      
    </table>
</form>
<script type="text/javascript">
   var type = '<%=type %>';
   if(type == "0"){
     document.getElementById("submit").disabled = true;
   }
</script>
</body>
</html>