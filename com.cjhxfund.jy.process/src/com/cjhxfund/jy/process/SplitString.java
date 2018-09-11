package com.cjhxfund.jy.process;

import com.cjhxfund.commonUtil.StrUtil;
import com.eos.system.annotation.Bizlet;

@Bizlet("分割字符")
public class SplitString {
      //循环分割字符
	@Bizlet("分割字符1")
	public String[] splitArgs(String args,String type){
		String[] strarray=args.split(type);
    	return strarray;
    }
     
  
	/**
	 * 
	 * @param str1  修改后的投标金额
	 * @param str2  未修改的投标金额
	 * @param str3  修改后的投票利率
	 * @param str4  未修改的投票利率
	 * @return 返回流程走那条支路  0-用印 1-交易员审核 2-人工审核
	 */
	@Bizlet("数字去千分位")
	public int DigitalThousandPoints(String str1,String str2,String str3,String str4){
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setGroupingUsed(false);
		int i = 0;
		double m_investcount = Double.valueOf(StrUtil.changeNull(str1).trim().replace(",",""));   //去千分位(修改后的投标金额)
		double investcount =  Double.valueOf(StrUtil.changeNull(str2).trim().replace(",",""));   //去千分位(未修改的投标金额)
		String m_interestrate = StrUtil.changeNull(str3).trim(); //将String类型转换成double 修改后的投标利率
		String interestrate = StrUtil.changeNull(str4).trim(); //将String类型转换成double 未修改的投标利率
		
		//判断修改后的投标金额与未修改的投标金额、修改后的投票利率与未修改的投票利率是否相等。相等说明没有修改直接进入用印环节
		if(m_investcount == investcount && m_interestrate.equalsIgnoreCase(interestrate)){
			i = 0;
		}else if(m_investcount == investcount && !m_interestrate.equalsIgnoreCase(interestrate)){ //投标金额相等，投标利率不等进入交易员审核环节
			i = 1;
		}else if(m_investcount > investcount && m_interestrate.equalsIgnoreCase(interestrate)){  //投标利率相等，修改后的投标金额大于未修改的投标金额。进入人工审核环节
			i = 2;
		}else if(m_investcount <= investcount && m_interestrate.equalsIgnoreCase(interestrate)){ //投标利率相等，修改后的投标金额小于等于未修改的投标金额。进入交易员审核环节
			i = 1;
		}else if(m_investcount <= investcount && !m_interestrate.equalsIgnoreCase(interestrate)){ //投标利率不相等，修改后的投标金额小于等于未修改的投标金额，进入交易员审核环节
			i = 1;
		}else if(m_investcount > investcount && !m_interestrate.equalsIgnoreCase(interestrate)){
			i = 2;   //投标利率不相等，修改后的投标金额大于未修改的投标金额，进入人工审核环节
		}
		return i;
	}
}
