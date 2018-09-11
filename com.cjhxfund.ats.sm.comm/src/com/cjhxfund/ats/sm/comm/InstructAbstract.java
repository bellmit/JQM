package com.cjhxfund.ats.sm.comm;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * 
 * @author 侯志勇
 * 用于拼装格式化待办摘要信息
 *
 */
@Bizlet("")
public class InstructAbstract {
	
	@Bizlet("instructInfo 指令数据对象")
	public static String assembleAbstract(DataObject instructInfo){
		String resultAbstract=null;
		StringBuffer vcAbstract=null;
		vcAbstract=new StringBuffer();
		String vcBizType = instructInfo.getString("vcBizType");
		if(vcBizType!=null && !"".equals(vcBizType)){
			if("1".equals(vcBizType)){
				vcAbstract.append("业务类型：银行间二级交易，");
			}else if("2".equals(vcBizType)){
				vcAbstract.append("业务类型：上海大宗交易，");
			}else if("3".equals(vcBizType)){
				vcAbstract.append("业务类型：上海固收平台，");
			}else if("4".equals(vcBizType)){
				vcAbstract.append("业务类型：深圳综合协议平台，");
			}else if("5".equals(vcBizType)){
				vcAbstract.append("业务类型：银行间质押式回购，");
			}else if("6".equals(vcBizType)){
				vcAbstract.append("业务类型：银行间买断式回购，");
			}else if("7".equals(vcBizType)){
				vcAbstract.append("业务类型：交易所协议式回购，");
			}
		}
		vcAbstract.append("委托方向："+instructInfo.getString("entrustName")+"，");
		String settleSpeed=instructInfo.getString("vcSettleSpeed");
		if(settleSpeed!=null &&!"".equals(settleSpeed)){
			if("0".equals(settleSpeed)){
				vcAbstract.append("清算速度：T+0"+"，");
			}
			if("1".equals(settleSpeed)){
				vcAbstract.append("清算速度：T+1"+"，");
			}
		}
		vcAbstract.append("指令发起人："+instructInfo.getString("vcInitiatorName")+"，");
		// 日期转换
		String lTradeDate = instructInfo.getString("lTradeDate");
		if(lTradeDate != null && !lTradeDate.equals("")){
         	lTradeDate = lTradeDate.substring(0, 4)+"-"+lTradeDate.substring(4,6)+"-"+lTradeDate.substring(6,8);
        }
		vcAbstract.append("交易日期："+lTradeDate);
		resultAbstract=vcAbstract.toString();
		return resultAbstract;
	}
}
