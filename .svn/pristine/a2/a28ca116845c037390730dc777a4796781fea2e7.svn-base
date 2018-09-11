/**
 * 
 */
package com.cjhxfund.ats.sm.inquiry;

import com.cjhxfund.commonUtil.JDBCUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import commonj.sdo.DataObject;

/**
 * @author 刘玉龙
 * @date 2017-10-12 15:44:00
 *
 */
@Bizlet("")
public class InquiryResultManageUtil {
	
	/**
	 * 判断当前询价结果投资经理是否可以退回
	 * @param  
	 * @return 
	 * @author liuyulong
	 */
	@Bizlet("")
	public static DataObject inquiryBackAbility(DataObject instructParameter){
		DataObject resultObject = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		boolean isRevise = true;//是否可退回
		String resultMsg = null;//指令判断结果信息反馈
		DataObject lastInstructInfo = null;
		if(instructParameter.getString("lResultId")!=null && !"".equals(instructParameter.getLong("lResultId"))){
			lastInstructInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.sm.comm.atsSmData.TAtsInquiryResultInstruct");//询价结果信息
			lastInstructInfo.setLong("lResultId", instructParameter.getLong("lResultId"));
			DatabaseUtil.expandEntity(JDBCUtil.DATA_SOURCE_DEFAULT, lastInstructInfo);
			if(!"-1".equals(lastInstructInfo.getString("vcProcessStatus"))){
				isRevise = false;
				resultMsg = "当前记录已不在投资经理确认环节，请先确认流程状态!";
			}else if(!"1".equals(lastInstructInfo.getString("cIsValid"))){
				isRevise = false;
				resultMsg = "当前记录已无效，不能退回!";
			}
		}
		resultObject.setBoolean("isRevise", isRevise);
		resultObject.setString("resultMsg", resultMsg);
		return resultObject;
	}
	
	/**
	 * 判断当前询价结果投资经理是否可以确认
	 * @param  
	 * @return 
	 * @author liuyulong
	 */
	@Bizlet("")
	public static DataObject inquiryConfrimAbility(DataObject instructParameter){
		DataObject resultObject = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		boolean isRevise = true;//是否可确认
		String resultMsg = null;//指令判断结果信息反馈
		DataObject lastInstructInfo = null;
		if(instructParameter.getString("lResultId")!=null && !"".equals(instructParameter.getLong("lResultId"))){
			lastInstructInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.sm.comm.atsSmData.TAtsInquiryResultInstruct");//询价结果信息
			lastInstructInfo.setLong("lResultId", instructParameter.getLong("lResultId"));
			DatabaseUtil.expandEntity(JDBCUtil.DATA_SOURCE_DEFAULT, lastInstructInfo);
			if(!"-1".equals(lastInstructInfo.getString("vcProcessStatus")) && !"3".equals(lastInstructInfo.getString("vcProcessStatus"))){
				isRevise = false;
				resultMsg = "当前记录已不在投资经理确认环节，请先确认流程状态!";
			}else if(!"1".equals(lastInstructInfo.getString("cIsValid"))){
				isRevise = false;
				resultMsg = "当前记录已无效，不能审批!";
			}
		}
		resultObject.setBoolean("isRevise", isRevise);
		resultObject.setString("resultMsg", resultMsg);
		return resultObject;
	}
	
	/**
	 * 判断当前询价结果交易员提交
	 * @param  
	 * @return 
	 * @author liuyulong
	 */
	@Bizlet("")
	public static DataObject inquirySubmitAbility(DataObject instructParameter){
		DataObject resultObject = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		boolean isRevise = true;//是否可确认
		String resultMsg = null;//指令判断结果信息反馈
		DataObject lastInstructInfo = null;
		if(instructParameter!=null && instructParameter.getString("lResultId")!=null && !"".equals(instructParameter.getLong("lResultId"))){
			lastInstructInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.sm.comm.atsSmData.TAtsInquiryResultInstruct");//询价结果信息
			lastInstructInfo.setLong("lResultId", instructParameter.getLong("lResultId"));
			DatabaseUtil.expandEntity(JDBCUtil.DATA_SOURCE_DEFAULT, lastInstructInfo);
			if(!"-2".equals(lastInstructInfo.getString("vcProcessStatus"))){
				isRevise = false;
				resultMsg = "当前记录状态不可提交，请先确认流程状态!";
			}
		}
		resultObject.setBoolean("isRevise", isRevise);
		resultObject.setString("resultMsg", resultMsg);
		return resultObject;
	}
	
	
	/**
	 * @param args
	 * @author 刘玉龙
	 */
	public static void main(String[] args) {
		// TODO 自动生成的方法存根

	}

}
