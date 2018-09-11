package com.cjhxfund.jy.BackStageTradeProcess;

import java.io.File;

import com.cjhxfund.jy.BackStageTradeProcess.filelistener.DirectoryWatcher;
import com.cjhxfund.jy.BackStageTradeProcess.filelistener.FileListener;
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
		LogUtil.logInfo("自动开启中债登文件监听服务启动完成", null, new Object[]{});
		System.out.println("自动开启中债登文件监听服务启动完成");
		//将监听添加到上清线程对象
		dwSourceSH.addListener(listenerSourceSH);
		//启动监听
		dwSourceSH.start();
		LogUtil.logInfo("自动开启上清所文件监听服务启动完成", null, new Object[]{});
		System.out.println("自动开启上清所文件监听服务启动完成");
	}
	@Bizlet("监听器入口调用方法")
	public static String loadData(){
		return "已开始装载";
	}
	@Bizlet("手动开启监听器入口调用方法")
	public boolean handLoadData(){
		boolean flag = true;
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
		dwSourceCN.removeAllListeners();
		LogUtil.logInfo("手动删除中债全部监听任务", null, new Object[]{});
		//将监听添加到中债线程对象
		dwSourceCN.addListener(listenerSourceCN);
		dwSourceCN.start();
		LogUtil.logInfo("手动开启中债登文件监听服务启动完成", null, new Object[]{});
		//手动开启监听之前需要删除之前所有的监听，否则可能会开启多个监听
		dwSourceSH.removeAllListeners();
		LogUtil.logInfo("手动删除上清全部监听任务", null, new Object[]{});
		//将监听添加到上清线程对象
		dwSourceSH.addListener(listenerSourceSH);
		dwSourceSH.start();
		LogUtil.logInfo("手动开启上清所文件监听服务启动完成", null, new Object[]{});
		return flag;
	}
	@Bizlet("手动关闭开启监听器")
	public boolean handCloseAllListener(){
		boolean flag = true;
		//移除所有监听
		dwSourceCN.removeAllListeners();
		dwSourceSH.removeAllListeners();
		return flag;
	}
	public static void main(String[] args) {
		loadData();
	}
}
