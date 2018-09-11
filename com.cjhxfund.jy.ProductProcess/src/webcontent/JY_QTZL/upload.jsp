<%@page import="com.cjhxfund.jy.ProductProcess.ProductProcessUtil"%>
<%@page import="com.cjhxfund.commonUtil.ProductUtil"%>
<%@page import="com.cjhxfund.commonUtil.DateUtil"%>
<%@page import="java.util.Date"%>
<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" session="false" %>
<%@page import="com.eos.foundation.database.DatabaseUtil"%>
<%@page import="com.eos.foundation.data.DataObjectUtil"%>
<%@page import="commonj.sdo.DataObject"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>

<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="com.eos.engine.component.ILogicComponent"%>
<%@page import="com.primeton.ext.engine.component.LogicComponentFactory"%>

<%
	String bizId = request.getParameter("bizId");
	String attachType = request.getParameter("attachType");
	String attachBusType = request.getParameter("attachBusType");
	String processinstid = request.getParameter("processinstid");
    String workItemID = request.getParameter("workItemID"); 
    String usreId = request.getParameter("usreId");
	//System.out.println("attachType:"+attachType);
	//System.out.println("attachBusType:"+attachBusType);
   
   
    //获取工作项信息
    DataObject objs = DataObjectUtil.createDataObject("com.eos.workflow.data.WFWorkItem");
    objs.set("workItemID", workItemID);
    DatabaseUtil.expandEntityByTemplate("default", objs, objs);

	String fileId = "";
	
	String attachName;
	
	String extention;
	
	UUID uuid;
	
	DiskFileItemFactory factory = new DiskFileItemFactory();
		// 设置内存缓冲区，超过后写入临时文件
		factory.setSizeThreshold(10240000); 
		// 设置临时文件存储位置
		String ContextPath = request.getContextPath();
		//设置上传路径
		String base = ProductProcessUtil.UPLOAD_FILE_PATH_QITAZHILING;

		
		File file = new File(base);
		
		if(!file.exists())
			file.mkdirs();
		factory.setRepository(file);
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 设置单个文件的最大上传值
		upload.setSizeMax(10002400000l);
		// 设置整个request的最大值
		upload.setSizeMax(10002400000l);
		upload.setHeaderEncoding("UTF-8");
		
		//逻辑构建名称
			String componentName = "com.cjhxfund.ats.fm.comm.attachUitlFunction";
			//逻辑流名称
			String operationName = "addAttachment";
			
			ILogicComponent comp = LogicComponentFactory.create(componentName);
			
			
		try {
			List<?> items = upload.parseRequest(request);
			FileItem item = null;
			String fileName = null;
			for (int i = 0 ;i < items.size(); i++){
				item = (FileItem) items.get(i);
				attachName=item.getName();
				
				// 保存文件
				if (!item.isFormField() && attachName.length() > 0) {
				   
				    //获取扩展名
				    if(attachName.length()>0&&attachName!=null){
				    int k=attachName.lastIndexOf(".");        
				    extention=attachName.substring(k+1);
				    uuid=UUID.randomUUID();
			    	fileName = base + File.separator + DateUtil.currentDateString(DateUtil.YYYYMMDDHHMMSS_NUMBER) + "_" + attachName.substring(0,k) +'.'+extention;
			    	} 
			    	//String newFilename = new String(fileName.getBytes("GB2312"), "UTF-8");
                    //文件名与UUID生成的文件写进服务器
					item.write(new File(fileName));
					//attachName = objs.getString("workItemName") + "_" + attachName;
		
					System.out.println("fileName:"+fileName);
					Object[] params = new Object[]{attachName,fileName,  item.getSize(),usreId,bizId,attachType,attachBusType,workItemID,processinstid};
					Object[] result = (Object[])comp.invoke(operationName, params);
					Long sysid = (Long)result[0];	
					fileId += sysid.toString();
				}			
					
			}
			out.write(fileId);
								
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}catch(Throwable e){
			System.out.print("文件写入出错！");
			e.printStackTrace();
		}
		
		
 %>