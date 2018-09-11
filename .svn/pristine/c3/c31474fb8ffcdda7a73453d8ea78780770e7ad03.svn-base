/**
 * 
 */
package com.cjhxfund.jy.BackStageTradeProcess;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;

import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;

/**
 * @author 金文轩
 * @date 2016-09-09 15:20:45
 *
 */
@Bizlet("文件处理")
public class FileUtil {
	 /**
	  *  文件拷贝
	  * @param sourceFile
	  * @param targetFile
	  */
	@Bizlet("文件拷贝")
	 public static void fileChannelCopy(File sourceFile, File targetFile) {
		 FileInputStream fi = null;
		 FileOutputStream fo = null;
		 FileChannel in = null;
		 FileChannel out = null;
		 try {
			 fi = new FileInputStream(sourceFile);
			 fo = new FileOutputStream(targetFile);
			 in = fi.getChannel();//得到对应的文件通道
			 out = fo.getChannel();//得到对应的文件通道
			 in.transferTo(0, in.size(), out);//连接两个通道，并且从in通道读取，然后写入out通道
		 } catch (IOException e) {
			 e.printStackTrace();
		 } finally {
            try {
                 fi.close();
                 in.close();
                 fo.close();
                 out.close();
             } catch (IOException e) {
                 e.printStackTrace();
             }
         }
     }
	 /**
	  * 文件删除
	  * @param file
	  * @return
	  */
	 @Bizlet("文件删除")
	 public static String fileDelete(File file){
		 if (file.exists() && file.isFile()) {  
			 if (file.delete()) {
				 LogUtil.logInfo("删除成功", null, new Object[]{});
				 return "0";
			 } else { 
				 LogUtil.logError("删除文件失败", null, new Object[]{});
				 return "1";
			 }
		 }else {
			 LogUtil.logError("文件不存在，删除文件失败", null, new Object[]{});
			 return "2";
		 }
	 }
	 
	 public static void main(String[] args) {
	 }
}
