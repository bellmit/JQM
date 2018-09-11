/**
 * 
 */
package com.cjhxfund.ats.sm.comm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author heyi
 *
 */
@Bizlet("")
public class GetInnerCodeFromList {
	@Bizlet("获取证券内码")
	public String getInnerCodeFromGroup(List<DataObject> os){
		int length = os.size();
		String temp = null;
		for(int i =0;i<length;i++){
			temp = os.get(i).getString("VC_INTER_CODE");
		}
		return temp;
	}
	
	@Bizlet("获取资产单元信息")
	public static DataObject getAssetGroup(List<DataObject> os){
		DataObject param = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		int length = os.size();
		String lAssetId = null;
		String vcAssetCode = null;
		String vcAssetName = null;
		for(int i =0;i<length;i++){
			param.set("lAssetId", os.get(i).getString("L_ASSET_ID"));
			param.set("vcAssetCode", os.get(i).getString("VC_ASSET_NO"));
			param.set("vcAssetName", os.get(i).getString("VC_ASSET_NAME"));
		}
		return param;
	}
}

