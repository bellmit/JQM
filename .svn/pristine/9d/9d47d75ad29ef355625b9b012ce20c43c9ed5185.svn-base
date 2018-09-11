/**
 * 
 */
package com.cjhxfund.jy.BackStageTradeProcess.filelistener;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.concurrent.LinkedBlockingQueue;

import com.cjhxfund.jy.BackStageTradeProcess.Consts;
import com.cjhxfund.jy.BackStageTradeProcess.FileUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

/**
 * @author 金文轩
 * @date 2016-09-10 11:07:38
 *
 */
@Bizlet("")
public class FileListener extends BaseListener implements IFileListener {
	
	
	public static LinkedBlockingQueue<String> Q = new LinkedBlockingQueue<String>();

    /**
     * Connstructor
     */
    public FileListener() {
        super();
    }

    public void onStart(Object monitoredResource) {
        // On startup
        if (monitoredResource instanceof File) {
            File resource = (File) monitoredResource;
            if (resource.isDirectory()) {
            }
        }
    }
    
    public void onStop(Object notMonitoredResource) {

    }
    /**
     * @param newResource 监测到新的变化对象
     * 	文件新增时触发
     */
    public void onAdd(Object newResource) {
        if (newResource instanceof File) {
            File file = (File) newResource;
            //调用文件处理
            copyAndUpdate(file,"arrived");
        }
    }	
    /**
     * @param changedResource 监测到新的变化对象
     * 文件修改时触发
     */
    public void onChange(Object changedResource) {
        if (changedResource instanceof File) {
            File file = (File) changedResource;
            //调用文件处理
            copyAndUpdate(file,"modified");
        }
    }
    /**
     * @param deletedResource 监测到新的变化对象
     * 文件删除时触发
     */
    public void onDelete(Object deletedResource) {
        if (deletedResource instanceof String) {
            String deletedFile = (String) deletedResource;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            LogUtil.logInfo("【"+sdf.format(new Date())+"】"+"file:" + deletedFile + " deleted", null, new Object[]{});
        	System.out.println("【"+sdf.format(new Date())+"】"+"file:" + deletedFile + " deleted");
        }
    }
    /**
     *  监听到文件后的处理
     * @param file 新增或修改的文件
     * @param notify 控制台输出的提示
     */
    public void copyAndUpdate(File file,String notify){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (file.isFile()) {
        	LogUtil.logInfo("【"+sdf.format(new Date())+"】"+"file:" + file.getAbsolutePath() + " "+notify, null, new Object[]{});
        	System.out.println("【"+sdf.format(new Date())+"】"+"file:" + file.getAbsolutePath() + " "+notify);
        	//根据文件名筛选文件，只对下面5种文件进行炒作
        	if(file.getAbsolutePath().indexOf("结算指令下载")!=-1||
        			file.getAbsolutePath().indexOf("结算合同下载")!=-1||
	        			file.getAbsolutePath().indexOf("现券交易列表")!=-1||
	        				file.getAbsolutePath().indexOf("质押式回购列表")!=-1||
	        					file.getAbsolutePath().indexOf("全额结算指令列表")!=-1){
        		//文件到达源文件夹后拷贝至本地文件夹
        		File folder =new File(Consts.getLocalPath());
            	if (!folder.exists()) {
            		folder.mkdirs();
        		}
            	File localFile= new File(Consts.getLocalPath()+File.separator+file.getName());
            	FileUtil.fileChannelCopy(file, localFile);
            	LogUtil.logInfo("拷贝到路径：     "+Consts.getLocalPath()+File.separator+file.getName(), null, new Object[]{});
            	System.out.println("拷贝到路径：     "+Consts.getLocalPath()+File.separator+file.getName());
            	System.out.println("本地文件路径：     "+localFile.getAbsolutePath());
            	//若不是结算合同下载，则调用逻辑流，读取本地excel文件，将数据更新到数据库
        		if(file.getAbsolutePath().indexOf("结算合同下载")==-1){
        			String componentName = "com.cjhxfund.jy.BackStageTradeProcess.BackStageTradeStatusProcess";
                	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
    				Object[] params = new Object[1];
    				params[0]=Consts.getLocalPath()+File.separator+file.getName();
    				try {
						logicComponent.invoke("sqzzBsStatusUpdate",params);
					} catch (Throwable e) {
						e.printStackTrace();
						LogUtil.logError("调用更新后台成交状态逻辑流错误！", e, new Object[]{});
					}
    				//删除拷贝过来的文件
                	FileUtil.fileDelete(localFile);
        		}
        		//若是结算合同下载，则根据修改时间保留最新的文件
        		else{
        			//遍历所有文件数组
        			File localFolder = new File(Consts.getLocalPath());
        			File[] allFiles = localFolder.listFiles();
        			int count = 0;
        			for(int i=0;i<allFiles.length;i++){
        				if(allFiles[i].getName().indexOf("结算合同下载")!=-1){
        					count++;
        				}
        			}
        			//筛选出结算合同下载文件数组
        			File[] contractFiles = new File[count];
        			int idx = 0;
        			for(int i=0;i<allFiles.length;i++){
        				if(allFiles[i].getName().indexOf("结算合同下载")!=-1){
        					contractFiles[idx++] = allFiles[i];
        				}
        			}
        			//结算合同下载文件修改时间列表
        			List<Long> contractFileModifyTimeList = new ArrayList<Long>();
        			long time= 10;
        			for(int i=0;i<contractFiles.length;i++){
        				time=contractFiles[i].lastModified();
        				contractFileModifyTimeList.add(time);
        			}
        			//倒叙列表，将修改时间最新的放到第一个
        			Collections.sort(contractFileModifyTimeList);
        			Collections.reverse(contractFileModifyTimeList);
        			//大于两个结算合同下载文件时，将修改时间不是最新的文件删除
        			for(int i=0;i<contractFiles.length;i++){
        				if(!contractFileModifyTimeList.get(0).equals(contractFiles[i].lastModified())&&
        						contractFiles.length>1){
        					FileUtil.fileDelete(contractFiles[i]);
        				}
        			}
        		}
        	}
        }else if(file.isDirectory()){
        	LogUtil.logInfo("【"+sdf.format(new Date())+"】"+"file:" + file.getAbsolutePath() + " "+notify, null, new Object[]{});
        	System.out.println("【"+sdf.format(new Date())+"】"+"folder:" + file.getAbsolutePath() + " "+notify);
        }
    }
    public static void main(String[] args) {
    	
	}
}
