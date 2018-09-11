package com.cjhxfund.ats.sm.comm;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.cjhxfund.ats.sm.comm.DirectoryWatcher;
import com.cjhxfund.ats.sm.comm.FileListener;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
/**
 * @author 金文轩
 * @date 2016-09-09 15:20:45
 *
 */
@Bizlet("监听器入口")
public class O32ServiceEntry {
	//上清中债文件监听器线程定义
	static DirectoryWatcher dwSourceCN = new DirectoryWatcher(Consts.getCNSourcePath(), 5);//中债
	static DirectoryWatcher dwSourceSH = new DirectoryWatcher(Consts.getSHSourcePath(), 5);//上清
	//上清中债两个监听定义
	private static FileListener listenerSourceCN=new FileListener();//中债
	private static FileListener listenerSourceSH=new FileListener();//上清
	
	static{
		// 启动文件监听
		File folderCN = new File(Consts.getCNSourcePath());
		File folderSH = new File(Consts.getSHSourcePath());
		//判断文件夹是否存在,如果不存在则创建文件夹
		if (!folderCN.exists()) {
			folderCN.mkdirs();
		}
		if (!folderSH.exists()) {
			folderSH.mkdirs();
		}
		//将监听添加到中债线程对象
		dwSourceCN.addListener(listenerSourceCN);
		//启动监听
		dwSourceCN.start();
		LogUtil.logInfo("自动开启中债登文件监听服务启动完成(二级债)", null, new Object[]{});
		System.out.println("自动开启中债登文件监听服务启动完成(二级债)");
		//将监听添加到上清线程对象
		dwSourceSH.addListener(listenerSourceSH);
		//启动监听
		dwSourceSH.start();
		LogUtil.logInfo("自动开启上清所文件监听服务启动完成(二级债)", null, new Object[]{});
		System.out.println("自动开启上清所文件监听服务启动完成(二级债)");
	}
	@Bizlet("监听器入口调用方法")
	public static String loadData(){
		return "已开始装载";
	}
	@Bizlet("手动开启监听器入口调用方法")
	public boolean handLoadData(){
		boolean flag = true;
		//清除监听器
		dwSourceCN.removeAllListeners();
		dwSourceSH.removeAllListeners();
		//回收对象
		dwSourceCN = null;
		dwSourceSH = null;
		
		listenerSourceCN = null; 
		listenerSourceSH = null;
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		//上清中债两个监听定义
		listenerSourceCN=new FileListener();//中债
		listenerSourceSH=new FileListener();//上清
		dwSourceCN = new DirectoryWatcher(Consts.getCNSourcePath(), 5);//中债
		dwSourceSH = new DirectoryWatcher(Consts.getSHSourcePath(), 5);//上清
		// 启动文件监听
		File folderCN = new File(Consts.getCNSourcePath());
		File folderSH = new File(Consts.getSHSourcePath());
		//判断文件夹是否存在,如果不存在则创建文件夹
		if (!folderCN.exists()) {
			folderCN.mkdirs();
		}
		if (!folderSH.exists()) {
			folderSH.mkdirs();
		}
		//手动开启监听之前需要删除之前所有的监听，否则可能会开启多个监听
		//dwSourceCN.removeAllListeners();
		//LogUtil.logInfo("手动删除中债全部监听任务(二级债)", null, new Object[]{});
		//将监听添加到中债线程对象
		dwSourceCN.addListener(listenerSourceCN);
		dwSourceCN.start();
		LogUtil.logInfo("手动开启中债登文件监听服务启动完成(二级债)", null, new Object[]{});
		//手动开启监听之前需要删除之前所有的监听，否则可能会开启多个监听
		//dwSourceSH.removeAllListeners();
		//LogUtil.logInfo("手动删除上清全部监听任务(二级债)", null, new Object[]{});
		//将监听添加到上清线程对象
		dwSourceSH.addListener(listenerSourceSH);
		dwSourceSH.start();
		LogUtil.logInfo("手动开启上清所文件监听服务启动完成(二级债)", null, new Object[]{});
		return flag;
	}
	@Bizlet("手动关闭开启监听器")
	public boolean handCloseAllListener(){
		boolean flag = false;
		//移除所有监听(二级债)
		LogUtil.logInfo("手动删除中债全部监听任务(二级债)", null, new Object[]{});
		dwSourceCN.removeAllListeners();
		LogUtil.logInfo("手动删除上清全部监听任务(二级债)", null, new Object[]{});
		dwSourceSH.removeAllListeners();
		flag = true;
		return flag;
	}
	
	/**
	 * 上次前台成交查询时间
	 */
	public static Date lastQueryTime;
	
	@Bizlet("获取上次查询时间")
	public String getLastQueryTime(){
		String lastQueryTimeStr;
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(lastQueryTime==null){
			Date now = new Date();
			//若刚启动项目，上次查询时间为空，则默认为当前时间的五分钟之前
			lastQueryTimeStr = df.format(new Date(now.getTime() - 300000));
		}else{
			lastQueryTimeStr = df.format(lastQueryTime);
		}
		System.out.println("上次查询时间为："+lastQueryTimeStr);
		return lastQueryTimeStr;
	}
	
	@Bizlet("记录此次查询时间")
	public void writeDownQueryTime(Date date){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		lastQueryTime = date;
		System.out.println("本次查询时间为："+df.format(lastQueryTime));
	}
	
	public static void main(String[] args) {
		loadData();
	}
}
