/**
 * 
 */
package org.gocom.components.coframe.auth.login;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import com.eos.system.annotation.Bizlet;

import edu.emory.mathcs.backport.java.util.concurrent.ExecutorService;
import edu.emory.mathcs.backport.java.util.concurrent.Executors;

/**
 * @author chenpeng
 * @date 2017-05-25 14:10:32
 *
 */
@Bizlet("后台线程类型")
public class DaemonThread implements Runnable  {
	
	//记录当前登录人的userId
	public static String userName = "";
	
	//是否终结线程标识
	public static boolean exit = true;
	
	//线程池
	public static ExecutorService executor = Executors.newCachedThreadPool();
	
	
	public void run() {
		// TODO 自动生成的方法存根
		//获取当前登录用户保存在map集合中的信息
		try {
			//获取用户登录信息
			UserText obj = VerifyCodeServlet.userMap.get(DaemonThread.userName);
			
			//解析时间，在登录时间加上15分钟
			Calendar cal = Calendar.getInstance();
			cal.setTime(obj.getDateTime());
			cal.add(Calendar.MINUTE,15);
			Date dateTimeE = cal.getTime();
			Date dateTimeB = null;
			System.out.println("判断条件 ============================="+exit);
			while(exit != false) {
				dateTimeB = new Date();
				//判断当前时间是否大于登录时间，当大于时清除用户登录次数
				if(dateTimeE.getTime() <= dateTimeB.getTime()){
					VerifyCodeServlet.userMap.remove(userName);
					exit = false;
				}
				 
				TimeUnit.MILLISECONDS.sleep((int)(Math.random() * 1000));
			}
		} catch (InterruptedException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
            //如果抛出异常则再次设置中断请求
            Thread.currentThread().interrupt();
		}
		
	}
	
	/**
	 * 向线程池写入线程
	 * @param userName 用户ID
	 */
	public static void removeNumberThread(String userName){
		DaemonThread.userName = userName;
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		//调用线程
		try{
			Thread daemon = new Thread(new DaemonThread());
			//String name = userName + format.format(new Date());
			daemon.setName(userName);
	        // 必须在start之前设置为后台线程  
	        daemon.setDaemon(true);  
	        //判断线程是否已经shutdown
	        if(!executor.isShutdown()){
	        	executor.execute(daemon); 
	        }
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * 关闭线程池
	 */
	public static void shutdown() {
		executor.shutdown();
		if(executor.isTerminated() == true){
			System.out.println("线程池线程关闭完成。");
		}
	}
	
	
	
	public static void main(String[] args) {
		Thread.currentThread().getThreadGroup();
		
		UserText user = new UserText("zhangsan", 1, new Date()); 
		
		VerifyCodeServlet.userMap.put("zhangsan", user);
		
		DaemonThread.removeNumberThread("zhangsan");
	}
}
