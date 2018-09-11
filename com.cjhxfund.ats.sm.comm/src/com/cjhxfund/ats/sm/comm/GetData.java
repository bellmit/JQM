/**
 * 
 */
package com.cjhxfund.ats.sm.comm;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.spring.support.DatabaseExt;
import commonj.sdo.DataObject;
import commonj.sdo.helper.DataFactory;

/**
 * @author 金文轩
 * @date 2016-09-23 10:12:37
 *
 */
@Bizlet("获取excel数据")
public class GetData {
	@Bizlet("获取表名")
	public Map<String,String> getTableName(String path,String today){
		Map<String,String> delDataParam = new HashMap<String,String>();
		if(!(path == null || path.length() <= 0)){
			if(path.indexOf("结算指令下载")!=-1&&
		    		"xlsx".equals(path.substring(path.lastIndexOf(".")+1))){
				delDataParam.put("tableName","T_ATS_BS_TALLY_ORDER");
			}
			if(path.indexOf("结算合同下载")!=-1&&
		    		"xlsx".equals(path.substring(path.lastIndexOf(".")+1))){
				delDataParam.put("tableName","T_ATS_BS_TALLY_CONTRACT");
			}
			if(path.indexOf("分销数据列表")!=-1&&
		    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
				delDataParam.put("tableName","T_ATS_BS_DISTRIBUTION");
			}
			if(path.indexOf("买断式回购列表")!=-1&&
		    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
				delDataParam.put("tableName","T_ATS_BS_BUYOUT_REPURCHASE");
			}
			if(path.indexOf("现券交易列表")!=-1&&
		    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
				delDataParam.put("tableName","T_ATS_BS_BOND_TRADE");
			}
			if(path.indexOf("质押式回购列表")!=-1&&
		    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
				delDataParam.put("tableName","T_ATS_BS_PLEDGE_STYLE_REPO");
			}
			if(path.indexOf("全额结算指令列表")!=-1&&
		    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
				delDataParam.put("tableName","T_ATS_BS_FULL_TALLY_ORDER");
			}
			delDataParam.put("lUpdatedt", today);
		}
		return delDataParam;
	}
	/**
	 *  根据不同表名分配不同的处理方法
	 * @param path excel文件本地存储路径
	 * @param today
	 * @return
	 */
	@Bizlet("根据不同表名分配不同的处理方法")
	public DataObject[] getData(String path,String today){
		DataObject[] excelData = null;
		if(!(path == null || path.length() <= 0)){
			if(path.indexOf("结算指令下载")!=-1&&
		    		"xlsx".equals(path.substring(path.lastIndexOf(".")+1))){
				excelData=getDataOfTallyOrder(path,today);
			}
			if(path.indexOf("结算合同下载")!=-1&&
		    		"xlsx".equals(path.substring(path.lastIndexOf(".")+1))){
				excelData=getDataOfTallyContract(path,today);
			}
			if(path.indexOf("分销数据列表")!=-1&&
		    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
				excelData=getDataOfDistribution(path,today);
			}
			if(path.indexOf("买断式回购列表")!=-1&&
		    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
				excelData=getDataOfBuyoutRepurchase(path,today);
			}
			if(path.indexOf("现券交易列表")!=-1&&
		    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
				excelData=getDataOfBondTrade(path,today);
			}
			if(path.indexOf("质押式回购列表")!=-1&&
		    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
				excelData=getDataOfPledgeStyleRepo(path,today);
			}
			if(path.indexOf("全额结算指令列表")!=-1&&
		    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
				excelData=getDataOfFullTallyOrder(path,today);
			}
		}
		return excelData;
	}
	
	/**
	 * 获取结算指令下载数据
	 * @param path excel文件本地存储路径
	 * @return
	 */
	@Bizlet("获取结算指令下载数据")
	public DataObject[] getDataOfTallyOrder(String path,String today){
		
		try{
			DataObject tAtsBsTallyOrder =null;
			XSSFWorkbook wb =null;
			XSSFSheet sheet =null;
			InputStream is = null;
			is=new FileInputStream(path);
			wb = new XSSFWorkbook(is);
			sheet = wb.getSheetAt(0);
			//数组长度为数据行号相减加一
			int dataLength=sheet.getLastRowNum()-sheet.getFirstRowNum()-1+1;
			DataObject[] tAtsBsTallyOrders=new DataObject[dataLength];
			//遍历行
			for (
					int i=sheet.getFirstRowNum()+1;
					i<=sheet.getLastRowNum();
					i++
					){
				XSSFRow row = sheet.getRow(i);
				tAtsBsTallyOrder =DataFactory.INSTANCE.create("com.cjhxfund.ats.sm.comm.o32ExcelData","TAtsBsTallyOrder");
				DatabaseExt.getPrimaryKey(tAtsBsTallyOrder);
				//遍历列
				for(int ii=0;ii<=75;ii++){
					//结算指令下载如果此列没有类型的话，需要做出判断
					if(row.getCell((short)ii) == null){
						tAtsBsTallyOrder.set(ii+1, "");
					}else{
						//不同的数据类型分别处理
						if(row.getCell((short)ii).getCellType()==1){
							tAtsBsTallyOrder.set(ii+1, row.getCell(ii).getStringCellValue());
						}else if(row.getCell((short)ii).getCellType()==0){
							DecimalFormat df = new DecimalFormat("0");  
							String numCell = df.format(row.getCell(ii).getNumericCellValue());
							tAtsBsTallyOrder.set(ii+1, numCell);
						}
					}
				}
				//数据实体放入数组。i不是从零开始，需要做处理
				long longtoday=Long.valueOf(today);
				Date now = new Date();
				tAtsBsTallyOrder.set(77, longtoday);//更新日期
				tAtsBsTallyOrder.set(78, now);//更新时间
				//System.out.println("实体：  "+tAtsBsTallyOrder.toString());
				tAtsBsTallyOrders[i-sheet.getFirstRowNum()-1]=tAtsBsTallyOrder;
			}
			System.out.println("读取EXCEL数据条数："+tAtsBsTallyOrders.length);
			return tAtsBsTallyOrders;
		}catch(Exception e){
			LogUtil.logError("结算指令下载解析EXCEL异常:{0}",e, path);
			return new DataObject[0];
		}
	}
	
	/**
	 * 获取结算合同下载数据
	 * @param path excel文件本地存储路径
	 * @return
	 */
	@Bizlet("获取结算合同下载数据")
	public DataObject[] getDataOfTallyContract(String path,String today){
		DataObject tAtsBsTallyContract =null;
		XSSFWorkbook wb =null;
		XSSFSheet sheet =null;
		InputStream is = null;
		try {
			is=new FileInputStream(path);
			//excel2007，扩展名是.xlsx，使用XSSF
			wb = new XSSFWorkbook(is);
		} catch (FileNotFoundException e) {
			LogUtil.logError("文件读写异常",e, new Object[]{});
			e.printStackTrace();
		}catch (IOException ee) {
			LogUtil.logError("输入输出流异常",ee, new Object[]{});
			ee.printStackTrace();
		}
		sheet = wb.getSheetAt(0);
		int dataLength=sheet.getLastRowNum()-sheet.getFirstRowNum()-1+1;
		DataObject[] tAtsBsTallyContracts=new DataObject[dataLength];
		//遍历行
		for (
				int i=sheet.getFirstRowNum()+1;
				i<=sheet.getLastRowNum();
				i++
				){
			XSSFRow row = sheet.getRow(i);
			tAtsBsTallyContract =DataFactory.INSTANCE.create("com.cjhxfund.ats.sm.comm.o32ExcelData","TAtsBsTallyContract");
			DatabaseExt.getPrimaryKey(tAtsBsTallyContract);
			//遍历列
			for(int ii=0;ii<=65;ii++){
				//结算合同下载如果此列没有类型的话，需要做出判断(目前是业务标识号出现这个情况)
				if(row.getCell((short)ii) == null){
					tAtsBsTallyContract.set(ii+1, "");
				}else{
					if(row.getCell((short)ii).getCellType()==1){
						tAtsBsTallyContract.set(ii+1, row.getCell(ii).getStringCellValue());
					}else if(row.getCell((short)ii).getCellType()==0){
						DecimalFormat df = new DecimalFormat("0");  
						String numCell = df.format(row.getCell(ii).getNumericCellValue());
						tAtsBsTallyContract.set(ii+1, numCell);
					}
				}
			}
			long longtoday=Long.valueOf(today);
			Date now = new Date();
			tAtsBsTallyContract.set(67, longtoday);
			tAtsBsTallyContract.set(68, now);
			//System.out.println("实体：  "+tAtsBsTallyContract.toString());
			tAtsBsTallyContracts[i-sheet.getFirstRowNum()-1]=tAtsBsTallyContract;
		}
		return tAtsBsTallyContracts;
	}
	
	/**
	 * 获取上清分销数据列表数据
	 * @param path excel文件本地存储路径
	 * @return
	 */
	@SuppressWarnings({ "deprecation" })
	@Bizlet("获取上清分销数据列表数据")
	public DataObject[] getDataOfDistribution(String path,String today){
		DataObject tAtsBsDistribution =null;
		HSSFWorkbook wb =null;
		HSSFSheet sheet =null;
		InputStream is = null;
		try {
			is=new FileInputStream(path);
			wb = new HSSFWorkbook(is);
		} catch (FileNotFoundException e) {
			LogUtil.logError("文件读写异常",e, new Object[]{});
			e.printStackTrace();
		}catch (IOException ee) {
			LogUtil.logError("输入输出流异常",ee, new Object[]{});
			ee.printStackTrace();
		}
		sheet = wb.getSheetAt(0);
		int dataLength=sheet.getLastRowNum()-sheet.getFirstRowNum()-2+1;
		DataObject[] tAtsBsDistributions=new DataObject[dataLength];
		//遍历行
		for (
				int i=sheet.getFirstRowNum()+2;
				i<=sheet.getLastRowNum();
				i++
				){
			HSSFRow row = sheet.getRow(i);
			tAtsBsDistribution =DataFactory.INSTANCE.create("com.cjhxfund.ats.sm.comm.o32ExcelData","TAtsBsDistribution");
			DatabaseExt.getPrimaryKey(tAtsBsDistribution);
			//遍历列
			for(int ii=0;ii<=23;ii++){
				//上清分销数据列表如果此列没有类型的话，需要做出判断
				if(row.getCell((short)ii) == null){
					tAtsBsDistribution.set(ii+1, "");
				}else{
					if(row.getCell((short)ii).getCellType()==1){
						tAtsBsDistribution.set(ii+1, row.getCell((short)ii).getStringCellValue());
					}else if(row.getCell((short)ii).getCellType()==0){
						DecimalFormat df = new DecimalFormat("0");  
						String numCell = df.format(row.getCell((short)ii).getNumericCellValue());
						tAtsBsDistribution.set(ii+1, numCell);
					}
				}
			}
			long longtoday=Long.valueOf(today);
			Date now = new Date();
			tAtsBsDistribution.set(25, longtoday);
			tAtsBsDistribution.set(26, now);
			//System.out.println("实体：  "+tAtsBsDistribution.toString());
			tAtsBsDistributions[i-sheet.getFirstRowNum()-2]=tAtsBsDistribution;
		}
		return tAtsBsDistributions;
	}

	/**
	 * 获取上清买断式回购列表数据
	 * @param path excel文件本地存储路径
	 * @return
	 */
	@SuppressWarnings("deprecation")
	@Bizlet("获取上清买断式回购列表数据")
	public DataObject[] getDataOfBuyoutRepurchase(String path,String today){
		DataObject tAtsBsBuyoutRepurchase =null;
		HSSFWorkbook wb =null;
		HSSFSheet sheet =null;
		InputStream is = null;
		try {
			is=new FileInputStream(path);
			wb = new HSSFWorkbook(is);
		} catch (FileNotFoundException e) {
			LogUtil.logError("文件读写异常",e, new Object[]{});
			e.printStackTrace();
		}catch (IOException ee) {
			LogUtil.logError("输入输出流异常",ee, new Object[]{});
			ee.printStackTrace();
		}
		sheet = wb.getSheetAt(0);
		int dataLength=sheet.getLastRowNum()-sheet.getFirstRowNum()-2+1;
		DataObject[] tAtsBsBuyoutRepurchases=new DataObject[dataLength];
		//遍历行
		for (
				int i=sheet.getFirstRowNum()+2;
				i<=sheet.getLastRowNum();
				i++
				){
			HSSFRow row = sheet.getRow(i);
			tAtsBsBuyoutRepurchase =DataFactory.INSTANCE.create("com.cjhxfund.ats.sm.comm.o32ExcelData","TAtsBsBuyoutRepurchase");
			DatabaseExt.getPrimaryKey(tAtsBsBuyoutRepurchase);
			//遍历列
			for(int ii=0;ii<=24;ii++){
				//买断式回购如果此列没有类型的话，需要做出判断
				if(row.getCell((short)ii) == null){
					tAtsBsBuyoutRepurchase.set(ii+1, "");
				}else{
					if(row.getCell((short)ii).getCellType()==1){
						tAtsBsBuyoutRepurchase.set(ii+1, row.getCell((short)ii).getStringCellValue());
					}else if(row.getCell((short)ii).getCellType()==0){
						DecimalFormat df = new DecimalFormat("0");  
						String numCell = df.format(row.getCell((short)ii).getNumericCellValue());
						tAtsBsBuyoutRepurchase.set(ii+1, numCell);
					}
				}
			}
			long longtoday=Long.valueOf(today);
			Date now = new Date();
			tAtsBsBuyoutRepurchase.set(26, longtoday);
			tAtsBsBuyoutRepurchase.set(27, now);
			//System.out.println("实体：  "+tAtsBsBuyoutRepurchase.toString());
			tAtsBsBuyoutRepurchases[i-sheet.getFirstRowNum()-2]=tAtsBsBuyoutRepurchase;
		}
		return tAtsBsBuyoutRepurchases;
	}
	
	/**
	 * 获取上清现券交易列表数据
	 * @param path excel文件本地存储路径
	 * @return
	 */
	@SuppressWarnings("deprecation")
	@Bizlet("获取上清现券交易列表数据")
	public DataObject[] getDataOfBondTrade(String path,String today){
		DataObject tAtsBsBondTrade =null;
		HSSFWorkbook wb =null;
		HSSFSheet sheet =null;
		InputStream is = null;
		try {
			is=new FileInputStream(path);
			wb = new HSSFWorkbook(is);
		} catch (FileNotFoundException e) {
			LogUtil.logError("文件读写异常",e, new Object[]{});
			e.printStackTrace();
		}catch (IOException ee) {
			LogUtil.logError("输入输出流异常",ee, new Object[]{});
			ee.printStackTrace();
		}
		sheet = wb.getSheetAt(0);
		int dataLength=sheet.getLastRowNum()-sheet.getFirstRowNum()-2+1;
		DataObject[] tAtsBsBondTrades=new DataObject[dataLength];
		//遍历行
		for (
				int i=sheet.getFirstRowNum()+2;
				i<=sheet.getLastRowNum();
				i++
				){
			HSSFRow row = sheet.getRow(i);
			tAtsBsBondTrade =DataFactory.INSTANCE.create("com.cjhxfund.ats.sm.comm.o32ExcelData","TAtsBsBondTrade");
			DatabaseExt.getPrimaryKey(tAtsBsBondTrade);
			//遍历列
			for(int ii=0;ii<=23;ii++){
				//现券交易数据如果此列没有类型的话，需要做出判断
				if(row.getCell((short)ii) == null){
					tAtsBsBondTrade.set(ii+1, "");
				}else{
					if(row.getCell((short)ii).getCellType()==1){
						tAtsBsBondTrade.set(ii+1, row.getCell((short)ii).getStringCellValue());
					}else if(row.getCell((short)ii).getCellType()==0){
						DecimalFormat df = new DecimalFormat("0");  
						String numCell = df.format(row.getCell((short)ii).getNumericCellValue());
						tAtsBsBondTrade.set(ii+1, numCell);
					}
				}
			}
			long longtoday=Long.valueOf(today);
			Date now = new Date();
			tAtsBsBondTrade.set(25, longtoday);
			tAtsBsBondTrade.set(26, now);
			//System.out.println("实体：  "+tAtsBsBondTrade.toString());
			tAtsBsBondTrades[i-sheet.getFirstRowNum()-2]=tAtsBsBondTrade;
		}
		return tAtsBsBondTrades;
	}
	
	/**
	 * 获取上清质押式回购列表数据
	 * @param path excel文件本地存储路径
	 * @return
	 */
	@SuppressWarnings("deprecation")
	@Bizlet("获取上清质押式回购列表数据")
	public DataObject[] getDataOfPledgeStyleRepo(String path,String today){
		DataObject tAtsBsPledgeStyleRepo =null;
		HSSFWorkbook wb =null;
		HSSFSheet sheet =null;
		InputStream is = null;
		try {
			is=new FileInputStream(path);
			wb = new HSSFWorkbook(is);
		} catch (FileNotFoundException e) {
			LogUtil.logError("文件读写异常",e, new Object[]{});
			e.printStackTrace();
		}catch (IOException ee) {
			LogUtil.logError("输入输出流异常",ee, new Object[]{});
			ee.printStackTrace();
		}
		sheet = wb.getSheetAt(0);
		int dataLength=sheet.getLastRowNum()-sheet.getFirstRowNum()-2+1;
		DataObject[] tAtsBsPledgeStyleRepos=new DataObject[dataLength];
		//遍历行
		for (
				int i=sheet.getFirstRowNum()+2;
				i<=sheet.getLastRowNum();
				i++
				){
			HSSFRow row = sheet.getRow(i);
			tAtsBsPledgeStyleRepo =DataFactory.INSTANCE.create("com.cjhxfund.ats.sm.comm.o32ExcelData","TAtsBsPledgeStyleRepo");
			DatabaseExt.getPrimaryKey(tAtsBsPledgeStyleRepo);
			//遍历列
			for(int ii=0;ii<=21;ii++){
				//质押式回购数据如果此列没有类型的话，需要做出判断
				if(row.getCell((short)ii) == null){
					tAtsBsPledgeStyleRepo.set(ii+1, "");
				}else{
					if(row.getCell((short)ii).getCellType()==1){
						tAtsBsPledgeStyleRepo.set(ii+1, row.getCell((short)ii).getStringCellValue());
					}else if(row.getCell((short)ii).getCellType()==0){
						DecimalFormat df = new DecimalFormat("0");  
						String numCell = df.format(row.getCell((short)ii).getNumericCellValue());
						tAtsBsPledgeStyleRepo.set(ii+1, numCell);
					}
				}
			}
			long longtoday=Long.valueOf(today);
			Date now = new Date();
			tAtsBsPledgeStyleRepo.set(23, longtoday);
			tAtsBsPledgeStyleRepo.set(24, now);
			//System.out.println("实体：  "+tAtsBsPledgeStyleRepo.toString());
			tAtsBsPledgeStyleRepos[i-sheet.getFirstRowNum()-2]=tAtsBsPledgeStyleRepo;
		}
		return tAtsBsPledgeStyleRepos;
	}
	
	/**
	 * 取上清全额结算指令列表数据
	 * @param path excel文件本地存储路径
	 * @return
	 */
	@SuppressWarnings("deprecation")
	@Bizlet("获取上清全额结算指令列表数据")
	public DataObject[] getDataOfFullTallyOrder(String path,String today){
		DataObject tAtsBsFullTallyOrder =null;
		HSSFWorkbook wb =null;
		HSSFSheet sheet =null;
		InputStream is = null;
		try {
			is=new FileInputStream(path);
			wb = new HSSFWorkbook(is);
		} catch (FileNotFoundException e) {
			LogUtil.logError("文件读写异常",e, new Object[]{});
			e.printStackTrace();
		}catch (IOException ee) {
			LogUtil.logError("输入输出流异常",ee, new Object[]{});
			ee.printStackTrace();
		}
		sheet = wb.getSheetAt(0);
		int dataLength=sheet.getLastRowNum()-sheet.getFirstRowNum()-2+1;
		DataObject[] tAtsBsFullTallyOrders=new DataObject[dataLength];
		//遍历行
		for (
				int i=sheet.getFirstRowNum()+2;
				i<=sheet.getLastRowNum();
				i++
				){
			HSSFRow row = sheet.getRow(i);
			tAtsBsFullTallyOrder =DataFactory.INSTANCE.create("com.cjhxfund.ats.sm.comm.o32ExcelData","TAtsBsFullTallyOrder");
			DatabaseExt.getPrimaryKey(tAtsBsFullTallyOrder);
			//遍历列
			for(int ii=0;ii<=33;ii++){
				//上清全额结算指令数据如果此列没有类型的话，需要做出判断
				if(row.getCell((short)ii) == null){
					tAtsBsFullTallyOrder.set(ii+1, "");
				}else{
					if(row.getCell((short)ii).getCellType()==1){
						tAtsBsFullTallyOrder.set(ii+1, row.getCell((short)ii).getStringCellValue());
					}else if(row.getCell((short)ii).getCellType()==0){
						DecimalFormat df = new DecimalFormat("0");  
						String numCell = df.format(row.getCell((short)ii).getNumericCellValue());
						tAtsBsFullTallyOrder.set(ii+1, numCell);
					}
				}
			}
			long longtoday=Long.valueOf(today);
			Date now = new Date();
			tAtsBsFullTallyOrder.set(35, longtoday);
			tAtsBsFullTallyOrder.set(36, now);
			//System.out.println("实体：  "+tAtsBsFullTallyOrder.toString());
			tAtsBsFullTallyOrders[i-sheet.getFirstRowNum()-2]=tAtsBsFullTallyOrder;
		}
		return tAtsBsFullTallyOrders;
	}
	/***
	 * 用于删除数据的辅助数据集，存储表名、需要删除的字段名、源交易编号
	 * @param dataObject 获取到监听的excel列表数组
	 * @param tableName  需要删除数据的表名
	 * @return 新的DataObject对象，将表名、需要删除的字段名、字段值作为参数放到dataObject
	 */
	@Bizlet("删除数据的辅助对象数组")
	public  DataObject[] deleteData(DataObject[] dataObject,Map<String,String> delParam){
		
		if(null==dataObject||dataObject.length==0){
			return new DataObject[0];
		}
		DataObject[] datas=new DataObject[dataObject.length];
		String tabName = delParam.get("tableName");
		for(int i=0;i<dataObject.length;i++){
			DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
			data.setString("tableName", delParam.get("tableName"));
			//上清-分销数据表、现券交易表、买断式回购表、质押式回购表
			if("T_ATS_BS_DISTRIBUTION".equals(tabName.toUpperCase()) 
					|| "T_ATS_BS_BOND_TRADE".equals(tabName.toUpperCase())
					|| "T_ATS_BS_BUYOUT_REPURCHASE".equals(tabName.toUpperCase())
					|| "T_ATS_BS_PLEDGE_STYLE_REPO".equals(tabName.toUpperCase())){
				if(!(dataObject[i].getString("vcTxid")==null || "".equals(dataObject[i].getString("vcTxid")))){
					data.setString("vcTableName",tabName.toUpperCase());
					data.setString("vcKey", "vc_txid");
					data.setString("vcValue", dataObject[i].getString("vcTxid"));
				}else{
					data.setString("vcTableName",tabName.toUpperCase());
					data.setString("vcKey", "vc_txcd");
					data.setString("vcValue", dataObject[i].getString("vcTxcd"));
				}
			}
			//上清-全额结算指令表
			if("T_ATS_BS_FULL_TALLY_ORDER".equals(tabName.toUpperCase())){
				if(!(dataObject[i].getString("vcTxid")==null || "".equals(dataObject[i].getString("vcTxid")))){
					data.setString("vcTableName",tabName.toUpperCase());
					data.setString("vcKey", "vc_txid");
					data.setString("vcValue", dataObject[i].getString("vcTxid"));
				}else{
					data.setString("vcTableName",tabName.toUpperCase());
					data.setString("vcKey", "vc_txcd");
					data.setString("vcValue", dataObject[i].getString("vcTxcd"));
				}
			}
			//中债-结算指令下载表
			if("T_ATS_BS_TALLY_ORDER".equals(tabName.toUpperCase())){
				if(dataObject[i].getString("vcTxid")==null || "".equals(dataObject[i].getString("vcTxid"))){
					data.setString("vcTableName",tabName.toUpperCase());
					data.setString("vcKey", "vc_instrid");
					data.setString("vcValue", dataObject[i].getString("vcInstrid"));
				}else{
					data.setString("vcTableName",tabName.toUpperCase());
					data.setString("vcKey", "vc_txid");
					data.setString("vcValue", dataObject[i].getString("vcTxid"));
				}
			}
			//中债-结算合同下载表
			if("T_ATS_BS_TALLY_CONTRACT".equals(tabName.toUpperCase())){
				if(dataObject[i].getString("vcTxid")==null || "".equals(dataObject[i].getString("vcTxid"))){
					data.setString("vcTableName",tabName.toUpperCase());
					data.setString("vcKey", "vc_ctrctid");
					data.setString("vcValue", dataObject[i].getString("vcCtrctid"));
				}else{
					data.setString("vcTableName",tabName.toUpperCase());
					data.setString("vcKey", "vc_txid");
					data.setString("vcValue", dataObject[i].getString("vcTxid"));
				}
			}
			datas[i] = data;
		}
		return datas;
	}
}
