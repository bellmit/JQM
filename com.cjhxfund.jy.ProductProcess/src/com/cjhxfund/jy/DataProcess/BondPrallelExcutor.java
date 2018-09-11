package com.cjhxfund.jy.DataProcess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CountDownLatch;

import com.cjhxfund.commonUtil.StrUtil;

public class BondPrallelExcutor extends BondExcutor{
		
	private List<PositionBasic> list;
	private Map<String,Bond> map;
	private CountDownLatch latch;
	
	public BondPrallelExcutor(List<PositionBasic> list,Map<String,Bond> map){
		super(list,map);
		this.list = list;
		this.map = map;
	}
	
	public BondPrallelExcutor(List<PositionBasic> list,Map<String,Bond> map,CountDownLatch latch){
		this.list = list;
		this.map = map;
		this.latch = latch;
	}
	
	@Override
	public List<?> query(Connection conn, String sql, List<Object> parameter,int split) {
		// TODO 自动生成的方法存根
		ResultSet set =null;
        PreparedStatement pre =null;
        String realSql = StrUtil.findContentStr(ZHXXCX_FILE_PATH+sql, null);      
        try {  
        	       	
        		System.out.println("start:" + System.currentTimeMillis());                 
            	realSql = realSql.replaceAll("To_Replace_Windcode", (String) parameter.get(split));
            	pre = conn.prepareStatement(realSql);          	
            	set = pre.executeQuery();          	
            	while(set.next()){
            		Bond bond = new Bond();
            		bond.setVcInterCodeWind2(set.getString("s_info_windcode"));
            		bond.setbIssuerCode(set.getString("b_info_issuercode"));
            		bond.setsInfoName(set.getString("s_info_name"));
            		bond.setbDelistDate(set.getString("B_INFO_DELISTDATE"));
            		bond.setbCnbd(set.getLong("B_ANAL_NET_CNBD"));
            		bond.setbIC1(set.getString("bIC1"));
            		bond.setbIC2(set.getString("bIC2"));
            		bond.setbIC3(set.getString("bIC3"));
            		bond.setbIC4(set.getString("bIC4"));
            		bond.setbPaymentDate(set.getString("B_INFO_PAYMENTDATE"));
            		bond.setbICD(set.getString("bICD"));
            		bond.setbGuarantorNature(set.getString("B_AGENCY_GUARANTORNATURE"));
            		bond.setbRatingOutlook(set.getString("B_RATE_RATINGOUTLOOK"));
            		bond.setIsCityInvest(set.getString("is_city_invest"));
            		bond.setbPtmyear(set.getString("B_ANAL_PTMYEAR"));
            		bond.setsIndustryName2(set.getString("S_INFO_INDUSTRYNAME2"));
            		bond.setProvince(set.getString("province"));
            		bond.setIsPayEarly(set.getString("is_pay_early"));
            		map.put(set.getString("s_info_windcode"), bond);
        	}          	
        	System.out.println("end:" + System.currentTimeMillis());            
        	
        } catch (SQLException e) {  
            e.printStackTrace();  
        } finally{       	
               try{  
                   if(set!=null){  
                	   set.close();  
                   }if(pre!=null){
                	   pre.clearBatch();
                	   pre.close();  
                   }
                   if(latch!=null){
               		latch.countDown();
               		}
               }catch(Exception e2){  
                   e2.printStackTrace();  
               }  
           }	
        return list;
	}

	
}
