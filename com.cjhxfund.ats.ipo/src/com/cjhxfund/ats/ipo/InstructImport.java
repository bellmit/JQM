package com.cjhxfund.ats.ipo;

import com.eos.system.annotation.Bizlet;
import commonj.sdo.DataObject;

@Bizlet("指令数据导入")
public class InstructImport {
	
	/**
	 * 
	 * @param fileName
	 * @param vcPurchaseCode
	 * @param vcExchangeNo
	 */
	
	@Bizlet("指令数据导入")
	public static DataObject[] importFile(String filePath,String clientName,String vcIssueCode){
		DataObject[] result=null;
		String vcExchangeNo=null;
		if(clientName!=null && !"".equals(clientName)){
			if(clientName.startsWith("0") || clientName.startsWith("3")){
				vcExchangeNo="SZ";
			}else if(clientName.startsWith("6")){
				vcExchangeNo="SH";
			}
		}
		String issueCode=clientName.substring(0, 6);
		if(issueCode!=null && vcIssueCode!=null ){
			if(!issueCode.equals(vcIssueCode)){
				return null;
			}
		}
		if(filePath!=null && !"".equals(filePath)){
			ImportExcelUtil importExcel=new ImportExcelUtil();
			result=importExcel.importFile(filePath,vcExchangeNo);
		}
		return result;
	}
}

